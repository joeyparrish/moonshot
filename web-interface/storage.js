(function() {
  if (isDesktopBundle()) {
    const path = require('path');
    const fs = require('fs');
    const vpath = {
      join: (...a) => a.join('/'),
    };

    const gameFolder = path.dirname(process.execPath);
    const settingsPath = path.join(gameFolder, 'settings.json');
    const savesFolder = path.join(gameFolder, 'Saves');

    // Path to saves in the Vorple virtual filesystem.
    const V_SAVES_FOLDER = '/extended/savefiles';
    // The constant for stat().mode to know if you're looking at a directory.
    const IS_DIR = 0o40000;
    // We don't want to copy 3P localStorage keys into our settings.  Limit to
    // this prefix.
    const LOCAL_STORAGE_PREFIX = 'chicken-noodle-soap--';

    fs.mkdirSync(savesFolder, {recursive: true});

    // Back up localStorage through the filesystem.
    localStorage.setItem = storageShim(localStorage.setItem, /* checkKey= */ true);
    localStorage.removeItem = storageShim(localStorage.removeItem, /* checkKey= */ true);
    localStorage.clear = storageShim(localStorage.clear, /* checkKey= */ false);

    document.addEventListener('DOMContentLoaded', async () => {
      // Vorple's FS may not be loaded yet.
      await vorple.file.init();

      // Pick up Steam Cloud Save files.
      await loadSavedGamesFromDisk();
    });

    function saveSettingsToDisk() {
      const settings = {};

      for (let i = 0; i < localStorage.length; i++) {
        const key = localStorage.key(i);
        if (key.startsWith(LOCAL_STORAGE_PREFIX)) {
          const value = localStorage.getItem(key);
          settings[key] = value;
        }
      }

      fs.writeFileSync(settingsPath, JSON.stringify(settings));
    }

    function loadSettingsFromDisk() {
      const settings = JSON.parse(fs.readFileSync(settingsPath));
      localStorage.clear();

      for (const key in settings) {
        localStorage.setItem(key, settings[key]);
      }
    }
    window.loadSettingsFromDisk = loadSettingsFromDisk;

    function storageShim(method, checkKey) {
      return function() {
        // Call the original.
        const retval = method.apply(localStorage, arguments);

        // Save the data.
        try {
          let shouldSave = true;

          if (checkKey) {
            // Only save if the key matches one of ours.
            // This could be data saved by a 3P library, and possibly before we
            // managed to load cloud-synced settings, so we want to be very
            // careful not to overwrite our cloud-synced settings before
            // loading them.
            const key = arguments[0];
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

    function readdir(vfs, path) {
      return new Promise((resolve, reject) => {
        vfs.readdir(path, (error, result) => {
          if (error) reject(error);
          else resolve(result);
        });
      });
    }

    function read(vfs, path) {
      return new Promise((resolve, reject) => {
        vfs.readFile(path, 'binary', (error, result) => {
          if (error) reject(error);
          else resolve(result);
        });
      });
    }

    function stat(vfs, path) {
      return new Promise((resolve, reject) => {
        vfs.stat(path, (error, result) => {
          if (error) reject(error);
          else resolve(result);
        });
      });
    }

    function mkdir(vfs, path) {
      return new Promise((resolve, reject) => {
        vfs.mkdir(path, {recursive: true}, (error, result) => {
          // A little special error-handling for vorple VFS...
          if (error && error.code == 'EEXIST') resolve(undefined);
          else if (error) reject(error);
          else resolve(result);
        });
      });
    }

    function write(vfs, path, data) {
      return new Promise((resolve, reject) => {
        vfs.writeFile(path, data, 'binary', (error, result) => {
          if (error) reject(error);
          else resolve(result);
        });
      });
    }

    // Dump file contents, recursively, from a filesystem into a dictionary.
    // The dictionary keys are relative paths formatted for a destination
    // filesystem, which may differ from the source.  (e.g. generic web paths
    // to Windows paths.)  The dictionary values are the file contents.
    // fromFs is a module like "node:fs", and fromPath and toPath are modules
    // like "node:path" (where only join() is used).
    async function dumpdir_r(fromFs, fromPath, toPath, currentPath, relativePath=[], ret={}) {
      const children = await readdir(fromFs, currentPath);

      for (const child of children) {
        const childPath = fromPath.join(currentPath, child);
        const childRelativePath = relativePath.concat(child);
        const stats = await stat(fromFs, childPath);
        if (stats.mode & IS_DIR) {
          await dumpdir_r(fromFs, fromPath, toPath, childPath, childRelativePath, ret);
        } else {
          const key = toPath.join(...childRelativePath);
          const value = await read(fromFs, childPath);
          ret[key] = value;
        }
      }

      return ret;
    }

    // Sync saved games from one filesystem to another.  (e.g. virtual web
    // filesystem to host OS filesystem, or vice versa.)
    async function syncSavedGames(fromFs, fromPath, fromFolder, toFs, toPath, toFolder) {
      const saveFiles = await dumpdir_r(fromFs, fromPath, toPath, fromFolder);

      for (const relativePath in saveFiles) {
        const fullPath = toPath.join(toFolder, relativePath);
        const folderPath = path.dirname(fullPath);
        await mkdir(toFs, folderPath);
        await write(toFs, fullPath, saveFiles[relativePath]);
      }
    }

    async function writeSavedGamesToDisk() {
      const vfs = vorple.file.getFS();
      await syncSavedGames(
         vfs, vpath, V_SAVES_FOLDER,  // from
         fs, path, savesFolder,  // to
      );
    }
    window.writeSavedGamesToDisk = writeSavedGamesToDisk;

    async function loadSavedGamesFromDisk() {
      const vfs = vorple.file.getFS();
      await syncSavedGames(
         fs, path, savesFolder,  // from
         vfs, vpath, V_SAVES_FOLDER,  // to
      );
    }
  } else {
    // No desktop bundle?  Don't do anything with this hook.
    window.writeSavedGamesToDisk = function() {};
  }
})();
