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

function pauseGame() {
  // Hide the prompt.
  vorple.prompt.hide();
  // Hide the buttons, which are partially covered by the "uiblock" element.
  hidePopupButtons();

  // Wait for a click or keypress, just once.
  const vorpleElement = document.getElementById('vorple');
  const listener = (event) => {
    // FIXME: key events are broken if we listen to #vorple
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
    vorpleElement.removeEventListener('click', listener, {capture: true});
    vorpleElement.removeEventListener('keydown', listener, {capture: true});
  };
  vorpleElement.addEventListener('click', listener, {capture: true});
  vorpleElement.addEventListener('keydown', listener, {capture: true});
}
