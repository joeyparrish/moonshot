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

// Early initialization of Vorple, Quixe, nw.js, and shared event listeners.

import {
  initAchievements,
} from './achievements.ts';

import {
  stopCredits,
} from './credits.ts';

import {
  stopSplash,
} from './splash.ts';

import {
  isDesktopBundle,
  isMobileBrowser,
  scrollToBottom,
} from './util.ts';

// Defined in HTML:
declare global {
  const desktopCredit: HTMLDivElement;
  const desktopLicense: HTMLDetailsElement;
  const window0: HTMLDivElement;
  const output: HTMLDivElement;
}

// Global keypresses are used to stop splash screen or credits early.
document.addEventListener('keydown', (event) => {
  // Don't monkey with key presses during gameplay.
  if (document.body && document.body.dataset['mode'] == 'play') {
    return;
  }

  // Don't let key presses go to the interpreter input in non-gameplay
  // modes.
  event.stopImmediatePropagation();
  if (event.key === 'Escape' || event.key === 'Enter') {
    if (document.body.dataset['mode'] == 'splash') {
      stopSplash();
    } else {
      stopCredits();
    }
  }
}, { capture: true });

// Scroll to the bottom on window resize.  Also triggered by font size changes.
window.addEventListener('resize', scrollToBottom);

// Do this after loading the DOM content.
document.addEventListener('DOMContentLoaded', () => {
  // Disable debugging features, then initialize Vorple.
  vorple.debug.off();
  vorple.init();

  // Some Vorple prompts (like after "quit") don't scroll to the bottom
  // automatically.  Fix that here.
  vorple.addEventListener('expectCommand', scrollToBottom);

  // Initialize the achievements interface.
  initAchievements();

  // Show/hide elements for debugging.
  const isMobileBrowserElement =
      document.querySelector<HTMLDivElement>('#is-mobile-browser')!;
  const isDesktopBrowserElement =
      document.querySelector<HTMLDivElement>('#is-desktop-browser')!;
  const isDesktopBundleElement =
      document.querySelector<HTMLDivElement>('#is-desktop-bundle')!;
  const userAgentElement =
      document.querySelector<HTMLDivElement>('#show-user-agent')!;
  userAgentElement.innerText = 'User Agent: ' + navigator.userAgent;
  if (isDesktopBundle()) {
    isMobileBrowserElement.style.display = 'none';
    isDesktopBrowserElement.style.display = 'none';
    userAgentElement.style.display = 'none';
  } else if (isMobileBrowser()) {
    isDesktopBrowserElement.style.display = 'none';
    isDesktopBundleElement.style.display = 'none';
  } else {  // Desktop browser
    isMobileBrowserElement.style.display = 'none';
    isDesktopBundleElement.style.display = 'none';
  }

  if (isDesktopBundle()) {
    // Enable desktop-bundle-specific elements.
    for (const element of
         document.querySelectorAll<HTMLElement>('.desktop-bundle-only')) {
      element.style.display = 'block';
    }

    const win = nw.Window.get();

    // Open target=_blank links in the default browser.
    win.on('new-win-policy', function(_frame, url, policy) {
      // Do not open the window.
      policy.ignore();
      // Open it in the user's default browser.
      nw.Shell.openExternal(url);
    });

    // Show the window that we initially hid to avoid a white window FOUC.
    win.show();

    // Allow F10 to toggle fullscreen.
    nw.App.registerGlobalHotKey(new nw.Shortcut({
      key: "F10",
      active: () => win.toggleFullscreen(),
      failed: (error) => console.log(error),
    }));
  } else {
    // Enable browser-specific elements.
    for (const element of
         document.querySelectorAll<HTMLElement>('.browser-only')) {
      element.style.display = 'block';
    }
  }

  if (isMobileBrowser()) {
    // Flag mobile status for CSS use.
    document.body.dataset['mobile'] = 'true';

    // On mobile browsers, force the use of autocomplete.
    const forceAutoComplete = () => {
      // Disable the input field so it doesn't get focus and trigger the
      // virtual keyboard.
      const inputField =
          document.querySelector<HTMLInputElement>('#lineinput-field')!;
      inputField.disabled = true;

      // Disable the autocomplete setting and force it to "on".
      const autoCompleteToggle =
          document.querySelector<HTMLInputElement>('#auto-complete-toggle')!;
      autoCompleteToggle.disabled = true;
      autoCompleteToggle.checked = true;

      // Trigger the effects of the autocomplete toggle.
      localStorage.setItem(autoCompleteToggle.dataset['settingsKey']!, 'true');
      document.body.dataset['autoComplete'] = 'true';

      // Since we can't hover this on mobile to know why it's disabled, use
      // Vorple's "powertip" functionality, which relies on jQuery.
      autoCompleteToggle.title = 'Required on mobile devices';
      // @ts-ignore
      $(autoCompleteToggle).powerTip({smartPlacement: true});

      // Removing this while it's executing seems to cause some other listeners not to fire...
      setTimeout(() => {
        vorple.removeEventListener('expectCommand', forceAutoComplete);
      }, 1);
    };

    // We can't force autocomplete until the input field exists, after
    // vorple.init() and guaranteed by the time the first 'expectCommand' event
    // fires.
    vorple.addEventListener('expectCommand', forceAutoComplete);
  }

  vorple.addEventListener('quit', () => {
    // Try closing the window.  This works on desktop builds, but not in
    // browsers.
    window.close();

    // That fails in browsers, so now we add this message to the game's
    // "window" element.
    window0.appendChild(
        document.createTextNode('You may now close this window.'));
    scrollToBottom();
  });
});
