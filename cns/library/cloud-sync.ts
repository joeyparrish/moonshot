/* Chicken Noodle Soap Text Adventure Game Interface
 *
 * Copyright 2025 Joey Parrish
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 *
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Steam Cloud Sync module.

import {
  success as toastSuccess,
} from './toast.ts';

import {
  captureHTML,
  captureText,
  restoreTranscript,
} from './transcripts.ts';

import {
  isDesktopBundle,
} from './util.ts';

import type * as FSModule from 'fs';
import type * as PathModule from 'path';

// We serialize all of this into JSON, so number[] avoids a real encoding.
// It also happens to be what we get when we steal data from
// Glk.glk_put_buffer_stream.
interface SaveData {
  vfsPath: string;
  saveBytes: number[];
  transcriptHTML: string;
  transcriptText: string;
}

// We don't want to copy 3P localStorage keys into our settings file.
// Limit ourselves to this prefix.
const LOCAL_STORAGE_PREFIX = 'chicken-noodle-soap--';

let fs: typeof FSModule;
let path: typeof PathModule;
let gameFolder: string;
let settingsPath: string;
let autoSavePath: string;

// Must match the filename used by the CNS extension in Inform.
const AUTO_SAVE_FILE: string = 'CNSAutoSave';

// No-op for browser builds.
if (isDesktopBundle()) {
  fs = window.require('fs');
  path = window.require('path');

  gameFolder = path.dirname(process.execPath);
  settingsPath = path.join(gameFolder, 'settings.json');
  autoSavePath = path.join(gameFolder, 'autosave.json');

  // Back up localStorage through the filesystem.
  localStorage.setItem = storageShim(localStorage.setItem, /* checkKey= */ true);
  localStorage.removeItem = storageShim(localStorage.removeItem, /* checkKey= */ true);
  localStorage.clear = storageShim(localStorage.clear, /* checkKey= */ false);
}

export async function initCloudSync(): Promise<void> {
  if (!isDesktopBundle()) {
    return;
  }

  // Vorple's FS may not be loaded yet.
  await vorple.file.init();

  // Pick up Steam Cloud Save files and load them into the virtual filesystem
  // of the interpreter.
  try {
    await loadSavedGamesFromDisk();
  } catch (error) {
    console.error('Failed to load saved games from disk!', error);
    try { wipeSavedGames(); } catch (_) {}
  }

  // Shim Glk's file writing API to get access to saved games as they are
  // written:
  Glk.glk_put_buffer_stream = glkShim(
      Glk.glk_put_buffer_stream, onSaveGame,
      'Failed to write saved game!');
}

function saveSettingsToDisk(): void {
  const settings: { [key: string]: string } = {};

  for (let i = 0; i < localStorage.length; i++) {
    const key = localStorage.key(i)!;
    if (key.startsWith(LOCAL_STORAGE_PREFIX)) {
      const value = localStorage.getItem(key)!;
      settings[key] = value;
    }
  }

  fs.writeFileSync(settingsPath, JSON.stringify(settings));
}

export function loadSettingsFromDisk(): void {
  if (!fs.existsSync(settingsPath)) {
    return;
  }

  try {
    const settings = JSON.parse(fs.readFileSync(settingsPath, {encoding: 'utf8'}));

    for (const key in settings) {
      localStorage.setItem(key, settings[key]);
    }
  } catch (error) {
    console.error('Failed to load settings!', error);
  }
}

function storageShim<T extends Function>(method: T, checkKey: boolean): T {
  return function() {
    // Call the original.
    const retval = method.apply(localStorage, arguments);

    // Save the data.
    try {
      let shouldSave: boolean = true;

      if (checkKey) {
        // Only save if the key matches one of ours.
        // This could be data saved by a 3P library, and possibly before we
        // managed to load cloud-synced settings, so we want to be very
        // careful not to overwrite our cloud-synced settings before
        // loading them.
        const key = arguments[0] as string;
        shouldSave = key.startsWith(LOCAL_STORAGE_PREFIX);
      }

      if (shouldSave) {
        saveSettingsToDisk();
      }
    } catch (error) {
      // Complain and fall through.  Shouldn't happen, though.
      console.error('Failed to store settings!', error);
    }

    // Return the return value.
    return retval;
  } as unknown as T;
}

// NOTE: Saved games are invalidated and ignored after the Inform game itself
// is modified.
async function loadSavedGamesFromDisk(): Promise<void> {
  // Load autosave data and sync it into the virtual filesystem used by the
  // interpreter.
  if (fs.existsSync(autoSavePath)) {
    const vfs = vorple.file.getFS();
    const saveData = JSON.parse(
        fs.readFileSync(autoSavePath, {encoding: 'utf8'})) as SaveData;

    // The VFS interface requires a string.  It shouldn't, but if I give it a
    // Uint8Array or anything else I can come up with, it throws trying to call
    // .copy() on some deep internal structure about a million levels of async
    // operations deep.  So we carefully build a string here.  It's obnoxious,
    // and it's the wrong way to handle binary data, but the things we would
    // need to do it right aren't exposed through Vorple.  I seriously
    // considered a custom build of Vorple, and we may still go that way
    // eventually...
    let dataString = '';
    for (const byte of saveData.saveBytes) {
      dataString += String.fromCharCode(byte);
    }
    await new Promise((resolve, reject) => {
      vfs.writeFile(
          // NOTE: This relative path needs to be prefixed with /inform/.
          // Vorple docs state that this is the default for relative paths, but
          // it doesn't seem to work here.
          '/inform/' + saveData.vfsPath,
          dataString,
          {encoding: 'binary'},
          (error: Error, result: undefined) => {
            if (error) {
              console.error('Failed to write save to vfs!', error);
              reject(error);
            } else {
              resolve(result);
            }
          });
    });
  } else {
    // If our autosave backup has been deleted from the game folder, wipe the
    // VFS to match.
    console.log('Autosave file not found!', autoSavePath);
    wipeSavedGames();
  }
}

export function wipeSavedGames(): void {
  if (!isDesktopBundle()) {
    return;
  }

  console.log('Wiping saved games...');
  try {
    if (fs.existsSync(autoSavePath)) {
      fs.unlinkSync(autoSavePath);
    }
  } catch (error) {
    console.error('Failed to unlink auto-save file from game folder.');
  }

  try {
    const vfs = vorple.file.getFS();
    vfs.unlink(
        // NOTE: This relative path needs to be prefixed with /inform/.
        // Vorple docs state that this is the default for relative paths, but
        // it doesn't seem to work here.
        '/inform/' + AUTO_SAVE_FILE);
  } catch (error) {
    console.error('Failed to unlink auto-save file from VFS.');
  }
}

function glkShim<T extends Function>(method: T, pre: T, errorCtx: string): T {
  return function() {
    // Call the "pre" callback first, logging errors, then fall through.
    try {
      pre.apply(null, arguments);
    } catch (error) {
      console.error(errorCtx, error);
    }

    return method.apply(null, arguments);
  } as unknown as T;
}

function onSaveGame(stream: Glk.GlkStream, array: number[]) {
  const transcriptHTML = captureHTML(/* includeAutoComplete= */ true);
  const transcriptText = captureText(/* includeAutoComplete= */ false);

  const saveData: SaveData = {
    vfsPath: stream.filename,
    saveBytes: array,
    transcriptHTML,
    transcriptText,
  };

  const saveName = stream.filename.split('/').pop()!;
  if (saveName != AUTO_SAVE_FILE) {
    // This shouldn't happen with auto-save being enforced.
    console.error('Unexpected saved game:', stream.filename);
    return;
  }

  fs.writeFileSync(autoSavePath, JSON.stringify(saveData), {encoding: 'utf8'});
}

export function postRestore(): boolean {
  toastSuccess('Loaded game successfully.', 'Your progress has been restored.');

  // Avoid an exception when restoring a game in a browser.  This is called
  // directly by the game.
  if (!isDesktopBundle()) {
    return true;
  }

  try {
    const saveData = JSON.parse(fs.readFileSync(autoSavePath, {encoding: 'utf8'})) as SaveData;
    restoreTranscript(saveData.transcriptHTML);
    console.log('Game transcript restored.');
    return true;
  } catch (error) {
    console.error('Failed to restore game transcript!', error);
    return false;
  }
}
