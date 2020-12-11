function logEvent(action, userInput=false) {
  gtag('event', action, {
    'event_category': 'game',
    // 'event_label': ,
    // 'value': ,
    'non_interaction': !userInput,
    // non_interaction set to true will exclude the event from "engagement"
    // measurements.
  });
}

window.addEventListener('DOMContentLoaded', (event) => {
  vorple.prompt.addInputFilter((input, meta) => {
    if (meta.userAction && meta.type == "line") {
      // If it's user action and line type, the user typed something and hit
      // enter.  When that happens, send a "turn" event.
      logEvent('turn', /* userInput */ true);
    }
  });
});
