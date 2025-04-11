// The entry point of the library.  Everything must be imported here.

// Top-level modules which set things up at load-time, including event
// listeners for further actions at DOM-ready-time.
import './init.ts';
import './achievements.ts';
import './analytics.ts';
import './auto-complete.ts';
import './cloud-sync.ts';
import './credits.ts';
import './music.ts';
import './pause.ts';
import './popups.ts';
import './splash.ts';
import './transcripts.ts';

// Set up the public, global interface of the library, usable from Inform or
// HTML:

import * as achievements from './achievements.ts';
import {logEvent} from './analytics.ts';
import * as autocomplete from './auto-complete.ts';
import {postRestore} from './cloud-sync.ts';
import {showCredits} from './credits.ts';
import {setBackgroundMusic, stopBackgroundMusic} from './music.ts';
import {pauseGame} from './pause.ts';
import {showHelp, showMap, showSettings} from './popups.ts';
import {reportBug, saveTranscript} from './transcripts.ts';

// @ts-ignore
window.cns = {
  achievements,
  autocomplete,
  logEvent,
  pauseGame,
  postRestore,
  reportBug,
  saveTranscript,
  setBackgroundMusic,
  showCredits,
  showHelp,
  showMap,
  showSettings,
  stopBackgroundMusic,
};
