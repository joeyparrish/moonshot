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

// Utilities.  This module has has no side-effects on import.

export function scrollToBottom(): void {
  // Check for null in case this is called before the interpreter is
  // initialized.
  const vorpleElement = document.getElementById('vorple') as HTMLElement|null;
  if (vorpleElement) {
    vorpleElement.scrollTo(0, vorpleElement.scrollHeight);
  }
}

export function isDesktopBundle(): boolean {
  // If we're using nw.js, we're in a desktop bundle.
  if (window.nw) {
    return true;
  }
  return false;
}

export function isMobileBrowser(): boolean {
  return /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
}

// A decorator for listeners to ignore events that are not targeted for the
// exact element we're listening on.
export function exactTarget(element: HTMLElement, listener: EventListener): EventListener {
  return (event: Event) => {
    if (event.target == element) {
      listener(event);
    }
  };
}
