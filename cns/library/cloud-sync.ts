// Steam Cloud Sync module.

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
}

// We don't want to copy 3P localStorage keys into our settings file.
// Limit ourselves to this prefix.
const LOCAL_STORAGE_PREFIX = 'chicken-noodle-soap--';

let fs: typeof FSModule;
let path: typeof PathModule;
let gameFolder: string;
let settingsPath: string;
let savesFolderPath: string;

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
    await loadSavedGamesFromDisk();

    // Shim Glk's file writing API to get access to saved games as they are
    // written:
    const original_glk_write = Glk.glk_put_buffer_stream;
    Glk.glk_put_buffer_stream = (stream, array) => {
      try {
        const saveData: SaveData = {
          vfsPath: stream.filename,
          saveBytes: array,
        };
        const saveName = stream.filename.split('/').pop()!;

        const savePath = path.join(savesFolderPath, saveName);
        fs.writeFileSync(savePath, JSON.stringify(saveData), {encoding: 'utf8'});
      } catch (error) {
        // Complain and fall through.  Shouldn't happen, though.
        console.error(error);
      }
      return original_glk_write(stream, array);
    };
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
  const settings = JSON.parse(fs.readFileSync(settingsPath, {encoding: 'utf8'}));
  localStorage.clear();

  for (const key in settings) {
    localStorage.setItem(key, settings[key]);
  }
}

function storageShim(method: Function, checkKey: boolean) {
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
      console.error(error);
    }

    // Return the return value.
    return retval;
  };
}

// NOTE: Saved games are invalidated and ignored after the Inform game itself
// is modified.
async function loadSavedGamesFromDisk(): Promise<void> {
  const vfs = vorple.file.getFS();

  // For each save in our folder, load the data and sync it into the virtual
  // filesystem used by the interpreter.
  for (const saveName of fs.readdirSync(savesFolderPath)) {
    const savePath = path.join(savesFolderPath, saveName);
    const saveData = JSON.parse(fs.readFileSync(savePath, {encoding: 'utf8'})) as SaveData;
    await new Promise((resolve, reject) => {
      vfs.writeFile(
          savePath, new Uint8Array(saveData.saveBytes), {encoding: null},
          (error: Error, result: undefined) => {
            if (error) reject(error);
            else resolve(result);
          });
    });
  }
}
