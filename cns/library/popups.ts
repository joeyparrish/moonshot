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

// A module to control the popup dialogs.

import {
  loadSettingsFromDisk,
} from './cloud-sync.ts';

import {
  exactTarget,
  isDesktopBundle,
} from './util.ts';

export function showSettings() {
  document.getElementById('settings-button')!.click();
}

export function showHelp() {
  document.getElementById('help-button')!.click();
}

export function showMap() {
  document.getElementById('map-button')!.click();
}

function showPopup(event: Event): void {
  const button = (event.target as HTMLElement).closest<HTMLElement>('.popup-open')!;
  const popupContainerId = button.dataset['popupContainerId']!;
  const popupContainer = document.getElementById(popupContainerId)!;
  popupContainer.classList.remove('hidden');

  // Only once it's shown, we can scroll back to the top of the popup content.
  // If we don't do this, it will open at the last place the user scrolled.
  const popup = popupContainer.querySelector('.popup')!;
  popup.scrollTo(0, 0);

  // Make sure to hide the prompt so that the popup can have focus.
  // showPopup can happen on the same event as hidePopup for buttons like the
  // OSS license button.  So give it a tiny delay to make sure hidePopup
  // completes (and shows the prompt) before we hide the prompt again.
  // Otherwise, these can fire in the wrong order and cause the prompt to show
  // and steal focus.
  setTimeout(() => vorple.prompt.hide(), 1);
}

function hidePopup(event: Event): void {
  const popupContainer = (event.target as HTMLElement).closest<HTMLElement>('.popup-container')!;
  popupContainer.classList.add('hidden');

  // Make sure to show the prompt again.
  vorple.prompt.unhide();
}

export function showPopupButtons(): void {
  const openButtons = document.querySelectorAll<HTMLElement>('.popup-open');
  for (const button of openButtons) {
    button.classList.remove('hidden');
  }
}

export function hidePopupButtons(): void {
  const openButtons = document.querySelectorAll<HTMLElement>('.popup-open');
  for (const button of openButtons) {
    button.classList.add('hidden');
  }
}

document.addEventListener('DOMContentLoaded', () => {
  if (isDesktopBundle()) {
    // Load settings from the filesystem into localStorage.
    loadSettingsFromDisk();
  }

  const openButtons = document.querySelectorAll<HTMLElement>('.popup-open');
  for (const button of openButtons) {
    button.addEventListener('click', showPopup);
  }

  const closeButtons = document.querySelectorAll<HTMLElement>('.popup-close');
  for (const button of closeButtons) {
    button.addEventListener('click', hidePopup);
  }

  const scrims = document.querySelectorAll<HTMLElement>('.popup-container');
  for (const scrim of scrims) {
    scrim.addEventListener('click', exactTarget(scrim, hidePopup));
  }

  const settingsElements = document.querySelectorAll<HTMLInputElement>('[data-settings-key]');
  for (const element of settingsElements) {
    const key = element.dataset['settingsKey']!;
    const isBool = element.type == 'checkbox';

    let defaultSetting = element.dataset['defaultSetting'];
    if (defaultSetting === undefined) {
      defaultSetting = isBool ? 'true' : '';
    }

    const settingString = localStorage.getItem(key) || defaultSetting;
    setSetting(element, key, settingString);

    element.addEventListener('change', () => {
      const value = isBool ? element.checked.toString() : element.value;
      setSetting(element, key, value);
    });
  }

  function setSetting(element: HTMLInputElement, key: string, value: string): void {
    localStorage.setItem(key, value);
    if (element.type == 'checkbox') {
      element.checked = value === 'true';
    } else {
      element.value = value;
    }

    // Run custom "onapply" hook from the element.
    // This differs from "change" events, which are triggered by the user
    // changing the UI.  In contrast, this can be triggered by us loading the
    // initial settings, as well.
    const onApply = element.getAttribute('onapply');
    if (onApply) {
      // @ts-ignore
      window.event = { target: element };

      // new Function avoids complaints from esbuild about the use of eval()
      const onApplyCallback = new Function(onApply);
      onApplyCallback();

      // @ts-ignore
      delete window.event;
    }
  }
});
