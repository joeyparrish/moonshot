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
}

document.addEventListener('DOMContentLoaded', () => {
  // When the animation ends, stop the splash.
  cover.onanimationend = stopSplash;

  // When the user clicks, stop the splash.
  splash.addEventListener('click', stopSplash);

  // Start the splash screen.
  document.body.dataset['mode'] = 'splash';
});
