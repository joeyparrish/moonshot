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

// The entry point of the library.  Everything must be imported here.

// Top-level modules which set things up at load-time, including event
// listeners for further actions at DOM-ready-time.
import './init.ts';
import './achievements.ts';
import './analytics.ts';
import './auto-complete.ts';
import './cloud-sync.ts';
import './credits.ts';
import './elements.ts';
import './music.ts';
import './pause.ts';
import './popups.ts';
import './splash.ts';
import './toast.ts';
import './transcripts.ts';

// Set up the public, global interface of the library, usable from Inform or
// HTML:

import * as achievements from './achievements.ts';
import {logEvent} from './analytics.ts';
import * as autocomplete from './auto-complete.ts';
import {postRestore} from './cloud-sync.ts';
import {showCredits} from './credits.ts';
import * as elements from './elements.ts';
import {setBackgroundMusic, stopBackgroundMusic} from './music.ts';
import {pauseGame} from './pause.ts';
import {showHelp, showMap, showSettings} from './popups.ts';
import * as toast from './toast.ts';
import {reportBug, saveTranscript} from './transcripts.ts';
import {isDesktopBundle} from './util.ts';

// @ts-ignore
window.cns = {
  achievements,
  autocomplete,
  elements,
  isDesktopBundle,
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
  toast,
};
