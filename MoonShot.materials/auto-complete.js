// These are exposed to the window for the game to call into.
const knownTopics = new Map();

const DEFAULT_TOPICS = [''];

function resetTopics() {
  knownTopics.clear();
  for (const topic of DEFAULT_TOPICS) {
    addTopic(topic);
  }
}

function addTopic(topic) {
  // We index in a case-insensitive way.
  const key = topic.toLowerCase();
  // The value we store is otherwise cased as specified.
  if (!knownTopics.has(key)) {
    knownTopics.set(key, topic);
  }
}

resetTopics();

// The "vorple" global doesn't exist until DOMContentLoaded.
document.addEventListener('DOMContentLoaded', () => {
  const autoComplete = document.getElementById('auto-complete');
  const select = autoComplete.querySelector('select');
  let inputField = null;
  let inputForm = null;
  let promptOffset = 0;
  let endCommandAfterAutoComplete = false;

  // Don't let the input field steal keystrokes from the auto-complete
  // suggestions, which should be keyboard navigable and accessible by default.
  select.addEventListener('keydown', (event) => {
    event.stopPropagation();
  });

  // When focus leaves the auto-complete selection, if it's not blank, we adopt
  // it right away and send it to the command prompt.
  select.addEventListener('blur', () => {
    if (select.value) {
      if (endCommandAfterAutoComplete) {
        // Add this value to the input field and submit it.
        vorple.prompt.submit(inputField.value + select.value);
        inputField.value = '';
      } else {
        // Add this value to the input field only.
        inputField.value += select.value;
        hideAutoComplete();
      }
    }
  });

  function initializeAutoComplete() {
    // Set our preferred prefix, with a little extra space.
    vorple.prompt.setPrefix('>&nbsp;', /* isHtmlSafe= */ true);

    // Watch input field changes.  The field didn't exist earlier than this.
    inputField = document.getElementById('lineinput-field');
    inputField.addEventListener('input', onInput);

    inputForm = document.getElementById('lineinput');

    // Space taken up by the prompt prefix:
    promptOffset =
        inputField.getBoundingClientRect().x -
        inputForm.getBoundingClientRect().x;

    // Move the auto-complete object inside the form where it can overlay.
    inputForm.appendChild(autoComplete);
  }

  function onExpectCommand() {
    // This only needs to happen once, so remove the listener now.
    vorple.removeEventListener('expectCommand', onExpectCommand);
    initializeAutoComplete();
  }
  // When this event finally fires for the first time, the command prompt
  // definitely exists.
  vorple.addEventListener('expectCommand', onExpectCommand);

  function onInput() {
    const input = inputField.value;

    if (/^ask (.*)\babout +$/.exec(input)) {
      showAutoComplete(knownTopics.values(), /* endOfCommand= */ true);
    } else {
      hideAutoComplete();
    }
  }
  // Run this also on "expectCommand", which runs after the user hits enter on
  // a command.
  vorple.addEventListener('expectCommand', onInput);

  function showAutoComplete(options, endOfCommand) {
    endCommandAfterAutoComplete = endOfCommand;

    // Where the caret is within the input field:
    const caret = getCaretCoordinates(inputField, inputField.value.length);

    // Remove any old options from the select field:
    while (select.firstChild) {
      select.removeChild(select.firstChild);
    }

    // Recreate select options:
    for (const o of options) {
      const optionElement = document.createElement('option');
      optionElement.value = o;
      optionElement.innerText = o;
      select.appendChild(optionElement);
    }

    // Position and show the auto-complete elements.
    autoComplete.style.left = `${caret.left + promptOffset}px`;
    autoComplete.style.display = 'inline-block';
  }

  function hideAutoComplete() {
    autoComplete.style.display = 'none';
  }
});
