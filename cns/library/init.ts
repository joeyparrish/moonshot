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
  scrollToBottom,
  isDesktopBundle,
} from './util.ts';

// Defined in HTML:
declare global {
  const desktopCredit: HTMLDivElement;
  const desktopLicense: HTMLDetailsElement;
  const window0: HTMLDivElement;
}

// Global keypresses are used to stop splash screen or credits early.
document.addEventListener('keydown', (event) => {
  // Don't monkey with key presses during gameplay.
  if (document.body.dataset['mode'] == 'play') {
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

  if (isDesktopBundle()) {
    // Enable desktop-bundle-specific elements.
    desktopCredit.style.display = 'block';
    desktopLicense.style.display = 'block';

    // Open target=_blank links in the default browser.
    nw.Window.get().on('new-win-policy', function(_frame, url, policy) {
      // Do not open the window.
      policy.ignore();
      // Open it in the user's default browser.
      nw.Shell.openExternal(url);
    });

    // Show the window that we initially hid to avoid a white window FOUC.
    nw.Window.get().show();
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
