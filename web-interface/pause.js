/* This is custom JS to pause the game in the web experience. */

function unpauseGame() {
  // Show the prompt.
  vorple.prompt.unhide();
  // Re-enable the UI.
  vorple.layout.unblock();
  // The pause command in Inform is waiting for this.
  vorple.prompt.queueKeypress(' ');
  // Show buttons again.
  showPopupButtons();
  // Drop the "click to continue" card.
  document.querySelector('.continue')?.remove();
}

function pauseGame() {
  // Prevent the player from typing or clicking anything.
  vorple.layout.block();
  // Hide the prompt.
  vorple.prompt.hide();
  // Hide the buttons, which are partially covered by the "uiblock" element.
  hidePopupButtons();

  // Wait for a click or keypress on the window, just once, and in capture
  // phase so it isn't stolen by some other element.
  const listener = (event) => {
    if (event.type == 'keydown' && event.key != ' ' && event.key != 'Enter') {
      // Ignore keys other than space or enter.  Especially, say Alt+Tab.  So
      // annoyed by having the pause dismissed by modifier keys.
      return;
    }

    // Defer unpausing, to make sure this event is dead before the interpreter
    // moves again.  This allows us to pause immediately after unpausing if we
    // have a series of screens we want to pause on.
    setTimeout(() => unpauseGame(), 100);

    // Either event is enough to cancel listening for the other.
    // Because of this, we don't use "once" in the listener setup.
    window.removeEventListener('click', listener, {capture: true});
    window.removeEventListener('keydown', listener, {capture: true});
  };
  window.addEventListener('click', listener,
      {capture: true, passive: true});
  window.addEventListener('keydown', listener,
      {capture: true, passive: true});
}
