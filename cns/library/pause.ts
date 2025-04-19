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

// Customization for pausing the game.

import {
  hidePopupButtons,
  showPopupButtons,
} from './popups.ts';

import {
  scrollToBottom,
} from './util.ts';

function unpauseGame(): void {
  // Show the prompt.
  vorple.prompt.unhide();
  // The pause command in Inform is waiting for this.
  vorple.prompt.queueKeypress(' ');
  // Show buttons again.
  showPopupButtons();
  // Drop the "click to continue" card.
  document.querySelector('.continue')?.remove();
}

const UNPAUSE_KEYS: string[] = [
  'Enter',
  'Escape',
];

export function pauseGame(): void {
  const vorpleElement = document.getElementById('vorple') as HTMLDivElement;

  // Hide the prompt.
  vorple.prompt.hide();
  // Hide the buttons, which are partially covered by the "uiblock" element.
  hidePopupButtons();
  // Scroll down to the bottom.
  scrollToBottom();

  // Wait for a click or keypress, just once.
  const listener = (event: Event) => {
    const endPauseState = () => {
      // Defer unpausing, to make sure this event is dead before the
      // interpreter moves again.  This allows us to pause immediately after
      // unpausing if we have a series of screens we want to pause on.
      setTimeout(() => unpauseGame(), 100);

      // Either event is enough to cancel listening for the other.
      // Because of this, we don't use "once" in the listener setup.
      vorpleElement.removeEventListener('click', listener, {capture: true});
      document.removeEventListener('keydown', listener, {capture: true});
    };

    if (event.type == 'keydown') {
      const keyEvent = event as KeyboardEvent;
      // Key events have a few different possible paths.
      if (UNPAUSE_KEYS.includes(keyEvent.key)) {
        endPauseState();
      } else if (keyEvent.key == 'PageUp' || keyEvent.key == 'PageDown') {
        // Native keyboard scrolling doesn't work for some unknown reason when
        // we're paused, so emulate it here, since we're already handling key
        // events in this state.
        const signY = keyEvent.key == 'PageDown' ? 1 : -1;
        const deltaY = vorpleElement.clientHeight * signY * 0.8;
        vorpleElement.scrollBy(0, deltaY);
      } else {
        // Ignore other keys.  Especially, say, Alt+Tab.
        // So annoyed by having the pause dismissed by modifier keys.
        return;
      }
    } else {
      // Click event.  Unconditionally end the pause state.
      endPauseState();
    }
  };
  vorpleElement.addEventListener('click', listener, {capture: true});
  document.addEventListener('keydown', listener, {capture: true});
}
