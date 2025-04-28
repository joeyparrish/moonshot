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

// Everything related to the splash screen.

// Defined in HTML:
declare global {
  const cover: HTMLDivElement;
  const splash: HTMLDivElement;
}

export function stopSplash() {
  // Ignore during the credits or if already in play.
  const mode = document.body.dataset['mode'];
  if (mode == 'credits' || mode == 'play') {
    return;
  }

  // Go into play mode.
  document.body.dataset['mode'] = 'play';

  // Focus input, if it exists.
  document.querySelector<HTMLInputElement>('#lineinput-field')?.focus();
}

document.addEventListener('DOMContentLoaded', () => {
  // When the animation ends, stop the splash.
  cover.onanimationend = stopSplash;

  // When the user clicks, stop the splash.
  splash.addEventListener('click', stopSplash);

  // Start the splash screen.
  document.body.dataset['mode'] = 'splash';
});
