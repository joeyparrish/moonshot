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
}

function hidePopup(event: Event): void {
  const popupContainer = (event.target as HTMLElement).closest<HTMLElement>('.popup-container')!;
  popupContainer.classList.add('hidden');
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
