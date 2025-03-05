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
}

function pauseGame() {
  // Prevent the player from typing or clicking anything.
  vorple.layout.block();
  // Hide the prompt.
  vorple.prompt.hide();

  // Wait for a click or keypress on the window, just once, and in capture
  // phase so it isn't stolen by some other element.
  const listener = () => {
    unpauseGame();

    // Either event is enough to cancel listening for the other.
    // Because of this, we don't use "once" in the listener setup.
    window.removeEventListener('click', listener);
    window.removeEventListener('keydown', listener);
  };
  window.addEventListener('click', listener,
      {capture: true, passive: true, once: true});
  window.addEventListener('keydown', listener,
      {capture: true, passive: true, once: true});

  // Hide the buttons, which are partially hidden by the "uiblock" element.
  hidePopupButtons();
}
