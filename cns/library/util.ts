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

export function getOS(): 'macos'|'windows'|'linux'|'cros'|'ios'|'android'|'unknownos' {
  const ua = navigator.userAgent.toLowerCase();
  if (ua.includes('android')) {
    return 'android';
  } else if (ua.includes('iphone') || ua.includes('ipad')) {
    return 'ios';
  } else if (ua.includes('macintosh')) {
    return 'macos';
  } else if (ua.includes('windows')) {
    return 'windows';
  } else if (ua.includes('cros ')) {
    return 'cros';
  } else if (ua.includes('linux')) {
    return 'linux';
  } else {
    return 'unknownos';
  }
}

export function getCPU(): 'arm64'|'x64'|'unknowncpu' {
  if (isDesktopBundle()) {
    if (process.arch == 'x64') {
      return 'x64';
    } else if (process.arch == 'arm64') {
      return 'arm64';
    } else {
      return 'unknowncpu';
    }
  } else {
    return 'unknowncpu';
  }
}
