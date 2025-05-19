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

// Everything related to the scrolling credits.

import {
  scrollToBottom,
} from './util.ts';

// Defined in HTML:
declare global {
  const creditsOuterSizer: HTMLDivElement;
  const creditsWrapper: HTMLDivElement;
  const credits: HTMLDivElement;
}

function fixCreditSizing() {
  // Set this sizer's height based on runtime sizing so that the
  // percentages in CSS calc() will work.
  creditsOuterSizer.style.height = creditsWrapper.clientHeight + 'px';
}

export function stopCredits() {
  document.body.dataset['mode'] = 'play';
  vorple.prompt.unhide();
  scrollToBottom();
}

export function showCredits() {
  vorple.prompt.hide();
  document.body.dataset['mode'] = 'credits';
  // Let render & layout happen, then fix sizing.  The credits animation
  // has a 2s delay, so this 1s delay on sizing works.
  setTimeout(fixCreditSizing, 1000);
}

export function initCredits(): void {
  // The credits sizer needs to be updated with a calculated content size to
  // make scrolling work.
  window.addEventListener('resize', fixCreditSizing);

  // When the animation ends, stop the credits.
  creditsWrapper.onanimationend = stopCredits;

  // When the user clicks, stop the credits.
  credits.addEventListener('click', stopCredits);
}
