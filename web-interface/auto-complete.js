// These are exposed to the window for the game to call into.
const knownTopics = new Map();
let knownObjects = [];
let knownPeople = [];

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

function resetObjects() {
  knownObjects = [];
}

function addObject(properties) {
  knownObjects.push(properties);
}

function objectsMatching(properties) {
  const matches = [''];
  for (const item of knownObjects) {
    let match = true;
    for (const [field, value] of Object.entries(properties)) {
      if (item[field] != value) {
        match = false;
        break;
      }
    }
    if (match && !matches.includes(item.name)) {
      matches.push(item.name);
    }
  }
  return matches;
}

function resetPeople() {
  knownPeople = [''];
}

function addPerson(person) {
  knownPeople.push(person);
}

resetTopics();
resetObjects();
resetPeople();

// The "vorple" global doesn't exist until DOMContentLoaded.
document.addEventListener('DOMContentLoaded', () => {
  let select;
  let autoComplete;
  let inputField = null;
  let inputForm = null;
  let promptOffset = 0;
  let endCommandAfterAutoComplete = false;
  let continuationAfterAutoComplete = '';

  // Select elements have a "change" event, but this fires when using up/down
  // arrows to flip through items without "choosing" one.  Instead, we use a
  // combination of other events (very inconsistent across platforms) to
  // process the change in a select element's value in these user scenarios:
  //  1. tab in, arrows to select, tab out
  //  2. tab in, arrows to select, enter/space to choose
  //  3. tab in, enter/space to open, hover to select, click to choose
  //  4. tab in, enter/space to open, hover to select, enter/space to choose
  //  5. tab in, enter/space to open, arrows to select, enter/space to choose
  //  6. click to open, hover to select, click to choose
  //  7. click to open, hover to select, enter/space to choose
  //  8. click to open, arrows to select, enter/space to choose
  // The "click to choose" scenarios (3 & 6) don't work in Linux Tauri without
  // hitting Enter again.
  function processSelectChange(event) {
    // This event is meant solely for the auto-complete element, and should not
    // go to any other element or handler.
    event.stopPropagation();

    // For key events, we're only watching Enter and Space.
    if (event.key && event.key != 'Enter' && event.key != ' ') {
      return;
    }

    // When any of these events happen, if the auto-complete selection is not
    // blank, we adopt it right away and send it to the command prompt.
    if (select.value) {
      if (endCommandAfterAutoComplete) {
        // Add this value to the input field and submit it.
        const fullCommand = inputField.value + select.value;
        inputField.value = '';
        // Delaying the submit avoids a double-enter effect on the input field.
        setTimeout(() => vorple.prompt.submit(fullCommand), 0);
      } else {
        // Add this value to the input field only.
        inputField.value += select.value + continuationAfterAutoComplete;
      }
      hideAutoComplete();

      // Bring focus back to the input field after auto-complete is done.
      // If this isn't deferred for a tick, it causes duplicate input in Vorple.
      setTimeout(() => inputField.focus(), 0);

      // Make sure multiple "select change" events don't cause duplicate items
      // to be sent to the input.
      select.value = '';

      // This suggestion may trigger another, so check again.
      onInput();
    }
  }

  function initializeAutoComplete() {
    // These are the auto-complete interface elements.
    select = document.createElement('select');
    autoComplete = document.createElement('span');
    autoComplete.id = 'auto-complete';
    autoComplete.appendChild(document.createTextNode('... '));
    autoComplete.appendChild(select);
    document.body.appendChild(autoComplete);

    // This extra span at the end allows you to tab out without leaving the page.
    // JS code from Vorple will bring focus back to the input field after that.
    const extraSpan = document.createElement('span');
    extraSpan.tabIndex = 0;
    document.body.appendChild(extraSpan);

    // Without this handler, the input field steals keystrokes from
    // auto-complete, and we can't use enter or space to open the select element.
    // We want to keep keyboard navigation and accessibility.  This also lets us
    // get the enter key when someone chooses from an open select element with
    // the keyboard.
    select.addEventListener('keydown', processSelectChange);

    // Without this handler, you can't tab in, arrow to something, then tab out.
    // This is also the handler that fires for most scenarios in Chrome, but not
    // Linux Tauri.
    select.addEventListener('blur', processSelectChange);

    // Without this handler, choosing something with the keyboard doesn't work in
    // Linux Tauri.
    select.addEventListener('keyup', processSelectChange);

    // Without this handler, the select element doesn't stay open when you click
    // it.  That's because Vorple has a click handler on document that sends
    // focus immediately to the input element.  Our stopPropagation fixes that.
    // This is also needed to process changes when you select something purely
    // with the mouse.
    select.addEventListener('click', processSelectChange);

    // Set our preferred prefix, with a little extra space.
    vorple.prompt.setPrefix('>&nbsp;', /* isHtmlSafe= */ true);

    // Watch input field changes.  The field didn't exist earlier than this.
    inputField = document.getElementById('lineinput-field');
    inputField.addEventListener('input', onInput);

    inputField.addEventListener('keydown', (event) => {
      // Don't let the user press enter when there's nothing in the input field.
      if (event.key == 'Enter' && /^\s*$/.exec(inputField.value)) {
        event.preventDefault();
      }
    });

    inputForm = document.getElementById('lineinput');

    // Space taken up by the prompt prefix:
    promptOffset =
        inputField.getBoundingClientRect().x -
        inputForm.getBoundingClientRect().x;

    // Move the auto-complete elements inside the form where they can overlay.
    inputForm.appendChild(autoComplete);
    inputForm.appendChild(extraSpan)
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

    if (/^ *ask (.*)\babout +$/.exec(input)) {
      showAutoComplete(knownTopics.values(), /* endOfCommand= */ true);
    } else if (/^ *(x|exa|examine) +$/.exec(input)) {
      // Everything
      showAutoComplete(objectsMatching({}), /* endOfCommand= */ true);
    } else if (/^ *take +$/.exec(input)) {
      // Takeable
      showAutoComplete(objectsMatching({takeable: true}), /* endOfCommand= */ true);
    } else if (/^ *eat +$/.exec(input)) {
      // Edible inventory
      showAutoComplete(objectsMatching({edible: true}), /* endOfCommand= */ true);
    } else if (/^ *drink +$/.exec(input)) {
      // Potable inventory
      showAutoComplete(objectsMatching({potable: true}), /* endOfCommand= */ true);
    } else if (/^ *open +$/.exec(input)) {
      // Openable
      showAutoComplete(objectsMatching({openable: true}), /* endOfCommand= */ true);
    } else if (/^ *drop +$/.exec(input)) {
      // All inventory
      showAutoComplete(objectsMatching({inventory: true}), /* endOfCommand= */ true);
    } else if (/^ *give +$/.exec(input)) {
      // All inventory
      showAutoComplete(objectsMatching({inventory: true}), /* endOfCommand= */ true, ' to ');
    } else if (/^ *give (.*)\bto +$/.exec(input)) {
      showAutoComplete(knownPeople, /* endOfCommand= */ false);
    } else if (/^ *ask +$/.exec(input)) {
      showAutoComplete(knownPeople, /* endOfCommand= */ false, ' about ');
    } else if (/^ *wake +$/.exec(input)) {
      showAutoComplete(knownPeople, /* endOfCommand= */ false);
    } else {
      hideAutoComplete();
    }
  }
  // Run this also on "expectCommand", which runs after the user hits enter on
  // a command.
  vorple.addEventListener('expectCommand', onInput);

  function showAutoComplete(options, endOfCommand, continuation = '') {
    endCommandAfterAutoComplete = endOfCommand;
    continuationAfterAutoComplete = continuation;

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
