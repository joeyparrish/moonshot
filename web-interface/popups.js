document.addEventListener('DOMContentLoaded', () => {
  function exactTarget(element, listener) {
    return (event) => {
      if (event.target == element) {
        listener(event);
      }
    };
  }

  const openButtons = document.querySelectorAll('.popup-open');
  for (const button of openButtons) {
    button.addEventListener('click', showPopup);
  }

  const closeButtons = document.querySelectorAll('.popup-close');
  for (const button of closeButtons) {
    button.addEventListener('click', hidePopup);
  }

  const scrims = document.querySelectorAll('.popup-container');
  for (const scrim of scrims) {
    scrim.addEventListener('click', exactTarget(scrim, hidePopup));
  }

  const settingsElements = document.querySelectorAll('[data-settings-key]');
  for (const element of settingsElements) {
    const key = element.dataset.settingsKey;
    const settingString = localStorage.getItem(key) || 'true';
    setSetting(element, key, settingString);

    element.addEventListener('change', (event) => {
      const value = element.type == 'checkbox' ?
          event.target.checked :
          event.target.value;
      setSetting(element, key, value);
    });
  }

  function setSetting(element, key, value) {
    localStorage.setItem(key, value);
    if (element.type == 'checkbox') {
      element.checked = value === true || value === 'true';
    } else {
      element.value = value;
    }

    // Run custom "onapply" hook from the element.
    // This differs from "change" events, which are triggered by the user
    // changing the UI.  In contrast, this can be triggered by us loading the
    // initial settings, as well.
    const onApply = element.getAttribute('onapply');
    if (onApply) {
      window.event = { target: element };
      eval(onApply);
      delete window.event;
    }
  }
});

function showSettings() {
  document.getElementById('settings-button').click();
}

function showHelp() {
  document.getElementById('help-button').click();
}

function showMap() {
  document.getElementById('map-button').click();
}

function showPopup(event) {
  const button = event.target.closest('.popup-open')
  const popupContainerId = button.dataset.popupContainerId;
  const popupContainer = document.getElementById(popupContainerId);
  popupContainer.classList.remove('hidden');

  // Only once it's shown, we can scroll back to the top of the popup content.
  // If we don't do this, it will open at the last place the user scrolled.
  const popup = popupContainer.querySelector('.popup');
  popup.scrollTo(0, 0);
}

function hidePopup(event) {
  const popupContainer = event.target.closest('.popup-container');
  popupContainer.classList.add('hidden');
}

function showPopupButtons() {
  const openButtons = document.querySelectorAll('.popup-open');
  for (const button of openButtons) {
    button.classList.remove('hidden');
  }
}

function hidePopupButtons() {
  const openButtons = document.querySelectorAll('.popup-open');
  for (const button of openButtons) {
    button.classList.add('hidden');
  }
}
