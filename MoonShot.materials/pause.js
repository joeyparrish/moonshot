/* This is custom JS to pause the game in the web experience. */

function unpauseGame() {
  // Show the prompt.
  vorple.prompt.unhide();
  // Re-enable the UI.
  vorple.layout.unblock();
  // The pause command in Inform is waiting for this.
  vorple.prompt.queueKeypress(' ');
}

function pauseGame() {
  // Prevent the player from typing or clicking anything.
  vorple.layout.block();
  // Hide the prompt.
  vorple.prompt.hide();

  // Wait for a click or keypress on the window, just once, and in capture
  // phase so it isn't stolen by some other element.
  window.addEventListener('click', unpauseGame,
      {capture: true, passive: true, once: true});
  window.addEventListener('keydown', unpauseGame,
      {capture: true, passive: true, once: true});
}
