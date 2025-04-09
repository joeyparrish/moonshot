// Steam Cloud Sync module.

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
let savesFolderPath: string;
let mostRecentRestoreGameName: string = '';

// No-op for browser builds.
if (isDesktopBundle()) {
  fs = window.require('fs');
  path = window.require('path');

  gameFolder = path.dirname(process.execPath);
  settingsPath = path.join(gameFolder, 'settings.json');
  savesFolderPath = path.join(gameFolder, 'Saves');

  fs.mkdirSync(savesFolderPath, {recursive: true});

  // Back up localStorage through the filesystem.
  localStorage.setItem = storageShim(localStorage.setItem, /* checkKey= */ true);
  localStorage.removeItem = storageShim(localStorage.removeItem, /* checkKey= */ true);
  localStorage.clear = storageShim(localStorage.clear, /* checkKey= */ false);

  document.addEventListener('DOMContentLoaded', async () => {
    // Vorple's FS may not be loaded yet.
    await vorple.file.init();

    // Pick up Steam Cloud Save files and load them into the virtual filesystem
    // of the interpreter.
    try {
      await loadSavedGamesFromDisk();
    } catch (error) {
      console.error('Failed to load saved games from disk!', error);
    }

    // Shim Glk's file writing API to get access to saved games as they are
    // written:
    Glk.glk_put_buffer_stream = glkShim(
        Glk.glk_put_buffer_stream, onSaveGame,
        'Failed to write save game!');

    // Shim the file reading API to get access to the name of the restored game
    // during loading, to restore the saved transcript afterward.
    Glk.glk_get_buffer_stream = glkShim(
        Glk.glk_get_buffer_stream, onLoadGame,
        'Failed to snoop on loaded game name!');
  });
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
  const vfs = vorple.file.getFS();

  // For each save in our folder, load the data and sync it into the virtual
  // filesystem used by the interpreter.
  for (const saveName of fs.readdirSync(savesFolderPath)) {
    if (!saveName.endsWith('.sav')) continue;

    const savePath = path.join(savesFolderPath, saveName);
    const saveData = JSON.parse(fs.readFileSync(savePath, {encoding: 'utf8'})) as SaveData;

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
          saveData.vfsPath,
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

function onLoadGame(stream: Glk.GlkStream, _array: number[]) {
  // NOTE: This is called multiple times per restore, once per kB of loaded
  // data.  Since all we care about is the file name, that's fine.
  mostRecentRestoreGameName = stream.filename.split('/').pop()!;
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
  const savePath = path.join(savesFolderPath, saveName + '.sav');
  fs.writeFileSync(savePath, JSON.stringify(saveData), {encoding: 'utf8'});
}

export function postRestore(): void {
  const saveName = mostRecentRestoreGameName;
  const savePath = path.join(savesFolderPath, saveName + '.sav');
  const saveData = JSON.parse(fs.readFileSync(savePath, {encoding: 'utf8'})) as SaveData;

  restoreTranscript(saveData.transcriptHTML);
  console.log('Game transcript restored:', saveName);
}
