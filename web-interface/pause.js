/* This is custom JS to pause the game in the web experience. */

function unpauseGame() {
  // Show the prompt.
  vorple.prompt.unhide();
  // The pause command in Inform is waiting for this.
  vorple.prompt.queueKeypress(' ');
  // Show buttons again.
  showPopupButtons();
  // Drop the "click to continue" card.
  document.querySelector('.continue')?.remove();
}

const UNPAUSE_KEYS = [
  'Enter',
  'Escape',
];

function pauseGame() {
  const vorpleElement = document.getElementById('vorple');

  // Hide the prompt.
  vorple.prompt.hide();
  // Hide the buttons, which are partially covered by the "uiblock" element.
  hidePopupButtons();
  // Scroll down to the bottom.
  scrollToBottom();

  // Wait for a click or keypress, just once.
  const listener = (event) => {
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
      // Key events have a few different possible paths.
      if (UNPAUSE_KEYS.includes(event.key)) {
        endPauseState();
      } else if (event.key == 'PageUp' || event.key == 'PageDown') {
        // Navite keyboard scrolling doesn't work for some unknown reason when
        // we're paused, so emulate it here, since we're already handling key
        // events in this state.
        const signY = event.key == 'PageDown' ? 1 : -1;
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
