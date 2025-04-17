// Auto-complete module.

interface AutoCompleteObjectProperties {
  name: string;
  inventory: boolean;
  takeable: boolean;
  edible: boolean;
  potable: boolean;
  openable: boolean;
  sittable: boolean;
};

const knownTopics = new Map<string, string>();
let knownObjects: AutoCompleteObjectProperties[] = [];
let knownPeople: string[] = [];
let specialVerbs: string[] = [];
let includeBasicVerbs: boolean = true;
let customAutoCompletes: [RegExp, string[]][] = [];  // [re, arrayOfOptions]

let select: HTMLSelectElement;
let autoComplete: HTMLElement;
let ellipsis: HTMLElement;
let inputField: HTMLInputElement;
let inputForm: HTMLFormElement;
let promptOffset: number = 0;
let endCommandAfterAutoComplete: boolean = false;
let continuationAfterAutoComplete: string = '';

const BASIC_VERBS: string[] = [
  'examine ',
  'inventory\n',
  'wait\n',
  'save\n',
  'restore\n',
];

export function resetVerbs(includeBasic: boolean = true): void {
  includeBasicVerbs = includeBasic;
  specialVerbs = [''];
}

export function addVerb(verb: string): void {
  specialVerbs.push(verb);
}

export function resetTopics(): void {
  knownTopics.clear();
  addTopic('');
}

export function addTopic(topic: string): void {
  // We index in a case-insensitive way.
  const key = topic.toLowerCase();
  // The value we store is otherwise cased as specified.
  if (!knownTopics.has(key)) {
    knownTopics.set(key, topic);
  }
}

export function resetObjects(): void {
  knownObjects = [];
}

export function addObject(properties: AutoCompleteObjectProperties): void {
  knownObjects.push(properties);
}

function objectsMatching(properties: Partial<AutoCompleteObjectProperties>) {
  const matches: string[] = [''];
  for (const item of knownObjects) {
    let match = true;
    for (const [field, value] of Object.entries(properties)) {
      if (item[field as keyof AutoCompleteObjectProperties] != value) {
        match = false;
        break;
      }
    }
    if (match && !matches.includes(item.name)) {
      matches.push(item.name);
    }
  }
  if (properties.takeable == true && matches.length > 1) {
    matches.push('all');
  }
  return matches;
}

export function resetPeople(): void {
  knownPeople = [''];
}

export function addPerson(person: string): void {
  knownPeople.push(person);
}

export function resetCustomAutoComplete(): void {
  customAutoCompletes = [];
}

export function addCustomAutoComplete(re: RegExp, arrayOfOptions: string[]): void {
  // Add the empty string to the front of the array.
  customAutoCompletes.push([re, [''].concat(arrayOfOptions)]);
}

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
function processSelectChange(event: Event): void {
  // This event is meant solely for the auto-complete element, and should not
  // go to any other element or handler.
  event.stopPropagation();

  // For key events, we're only watching Enter and Space.
  const keyEvent = event as KeyboardEvent;
  if (keyEvent.key && keyEvent.key != 'Enter' && keyEvent.key != ' ') {
    return;
  }

  // When any of these events happen, if the auto-complete selection is not
  // blank, we adopt it right away and send it to the command prompt.
  if (select.value) {
    // Ending the command is forced when the select value ends with '\n'.
    if (endCommandAfterAutoComplete || select.value.endsWith('\n')) {
      // Add this value to the input field and submit it.
      const fullCommand = inputField.value + select.value.trim();
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
    if (!inputField.disabled) {
      setTimeout(() => inputField.focus(), 0);
    }

    // Make sure multiple "select change" events don't cause duplicate items
    // to be sent to the input.
    select.value = '';

    // This suggestion may trigger another, so check again.
    maybeShowAutoComplete();
  }
}

function initializeAutoComplete(): void {
  // These are the auto-complete interface elements.
  select = document.createElement('select');
  autoComplete = document.createElement('span');
  autoComplete.id = 'auto-complete';
  ellipsis = document.createElement('span');
  ellipsis.id = 'ellipsis';
  ellipsis.textContent = '... ';
  autoComplete.appendChild(ellipsis);
  autoComplete.appendChild(select);

  // This extra span at the end allows you to tab out without leaving the page.
  // JS code from Vorple will bring focus back to the input field after that.
  const extraSpan = document.createElement('span');
  extraSpan.tabIndex = 0;

  // Without this handler, the input field steals keystrokes from
  // auto-complete, and we can't use enter or space to open the select element.
  // We want to keep keyboard navigation and accessibility.  This also lets us
  // get the enter key when someone chooses from an open select element with
  // the keyboard.
  select.addEventListener('keydown', processSelectChange);

  // Without this handler, a touchscreen device needs a second tap to blur
  // before the selection is processed.
  select.addEventListener('touchend', processSelectChange);

  // Without this handler, you can't tab in, arrow to something, then tab out.
  select.addEventListener('blur', processSelectChange);

  // Without this handler, the select element doesn't stay open when you click
  // it.  That's because Vorple has a click handler on document that sends
  // focus immediately to the input element.  Our stopPropagation fixes that.
  // This is also needed to process changes when you select something purely
  // with the mouse.
  select.addEventListener('click', processSelectChange);

  // Watch input field changes.  The field didn't exist earlier than this.
  inputField = document.querySelector<HTMLInputElement>('#lineinput-field')!;
  inputField.addEventListener('input', maybeShowAutoComplete);

  inputField.addEventListener('keydown', (event) => {
    // Don't let the user press enter when there's nothing in the input field.
    if (event.key == 'Enter' && /^\s*$/.exec(inputField.value)) {
      event.preventDefault();
    }

    // When scrolling back through old history, we should recompute
    // auto-complete.
    if (event.key == 'ArrowUp' || event.key == 'ArrowDown') {
      maybeShowAutoComplete();
    }
  });

  // Create a delete button to the left of the input field.  Only used on
  // touchscreen devices where the input field is disabled.
  const deleteButton = document.createElement('button');
  deleteButton.id = 'delete-button';
  // Without this "type=button" attribute, hitting enter on the input field
  // will trigger this button to be clicked... even with "display: none".
  // Buttons inside form elements are "submit" buttons by default.
  deleteButton.type = 'button';
  deleteButton.classList.add('floating-button');
  deleteButton.innerText = '⌫';
  deleteButton.addEventListener('click', (event) => {
    // If we don't do this, we'll submit the input "form".
    event.preventDefault();

    // Remove the last word from the input.
    const words = inputField.value.trim().split(/\s+/);
    words.pop();
    inputField.value = words.length ? words.join(' ') + ' ' : '';

    // Recompute autocomplete.
    maybeShowAutoComplete();
  });

  inputForm = document.getElementById('lineinput') as HTMLFormElement;

  // Compute prompt offset now and on resize.
  onResize();
  window.addEventListener('resize', onResize);

  // Move the auto-complete elements inside the form where they can overlay.
  inputForm.appendChild(autoComplete);
  inputForm.appendChild(extraSpan);
  inputForm.appendChild(deleteButton);

  // Check the auto-complete state now and on resize.
  maybeShowAutoComplete();
  window.addEventListener('resize', maybeShowAutoComplete);
}

function onResize(): void {
  // Compute space taken up by the prompt prefix.  This can change when the
  // zoom level changes, and the zoom level changing triggers a resize event.
  promptOffset =
      inputField.getBoundingClientRect().x -
      inputForm.getBoundingClientRect().x;
}

function showAutoComplete(options: Iterable<string>, endOfCommand: boolean, continuation: string = ''): void {
  endCommandAfterAutoComplete = endOfCommand;
  continuationAfterAutoComplete = continuation;

  // Where the caret is within the input field:
  const caret = window.getCaretCoordinates(inputField, inputField.value.length);

  // Special case: if the input is blank, hide the ellipsis and move over a little.
  const hasContent = /\S/.exec(inputField.value);
  ellipsis.style.display = hasContent ? 'inline' : 'none';
  const additionalOffset = hasContent ? '0px' : '0.5em';

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
  autoComplete.style.left = `calc(${caret.left + promptOffset}px + ${additionalOffset})`;
  autoComplete.style.display = 'inline-block';
}

export function hideAutoComplete(): void {
  autoComplete.style.display = 'none';
}

export function maybeShowAutoComplete(): void {
  const input = inputField.value;

  for (const [re, arrayOfOptions] of customAutoCompletes) {
    if (re.exec(input)) {
      showAutoComplete(arrayOfOptions, /* endOfCommand= */ false);
      return;
    }
  }

  if (/^ *$/i.exec(input)) {
    let verbs: string[] = specialVerbs;
    if (includeBasicVerbs) {
      verbs = verbs.concat(BASIC_VERBS);
    }
    showAutoComplete(verbs, /* endOfCommand= */ false);
  } else if (/^ *ask (.*)\babout +$/i.exec(input)) {
    showAutoComplete(knownTopics.values(), /* endOfCommand= */ true);
  } else if (/^ *(x|exa|examine) +$/i.exec(input)) {
    // Everything
    showAutoComplete(objectsMatching({}), /* endOfCommand= */ true);
  } else if (/^ *take +$/i.exec(input)) {
    // Takeable
    showAutoComplete(objectsMatching({takeable: true}), /* endOfCommand= */ true);
  } else if (/^ *eat +$/i.exec(input)) {
    // Edible inventory
    showAutoComplete(objectsMatching({edible: true}), /* endOfCommand= */ true);
  } else if (/^ *drink +$/i.exec(input)) {
    // Potable inventory
    showAutoComplete(objectsMatching({potable: true}), /* endOfCommand= */ true);
  } else if (/^ *open +$/i.exec(input)) {
    // Openable
    showAutoComplete(objectsMatching({openable: true}), /* endOfCommand= */ true);
  } else if (/^ *drop +$/i.exec(input)) {
    // All inventory
    showAutoComplete(objectsMatching({inventory: true}), /* endOfCommand= */ true);
  } else if (/^ *give +$/i.exec(input)) {
    // All inventory
    showAutoComplete(objectsMatching({inventory: true}), /* endOfCommand= */ false, ' to ');
  } else if (/^ *sit on +$/i.exec(input)) {
    showAutoComplete(objectsMatching({sittable: true}), /* endOfCommand= */ true);
  } else if (/^ *give (.*)\bto +$/i.exec(input)) {
    showAutoComplete(knownPeople, /* endOfCommand= */ true);
  } else if (/^ *ask +$/i.exec(input)) {
    showAutoComplete(knownPeople, /* endOfCommand= */ false, ' about ');
  } else if (/^ *wake +$/i.exec(input)) {
    showAutoComplete(knownPeople, /* endOfCommand= */ false);
  } else {
    hideAutoComplete();
  }
}

resetVerbs();
resetTopics();
resetObjects();
resetPeople();
resetCustomAutoComplete();

// The "vorple" global doesn't exist until DOMContentLoaded.
document.addEventListener('DOMContentLoaded', () => {
  function onExpectCommand(): void {
    // Initialize autocomplete.
    initializeAutoComplete();

    // Once initialized, recompute auto-complete every time a new prompt is
    // shown.
    vorple.addEventListener('expectCommand', maybeShowAutoComplete);

    // This only needs to happen once, so remove the listener now.
    // Removing this while it's executing seems to cause some other listeners not to fire...
    setTimeout(() => {
      vorple.removeEventListener('expectCommand', onExpectCommand);
    }, 1);
  }

  // When this event finally fires for the first time, the command prompt
  // definitely exists.  This interface doesn't have a {once:true} option.
  vorple.addEventListener('expectCommand', onExpectCommand);
});
