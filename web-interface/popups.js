document.addEventListener('DOMContentLoaded', () => {
  const openButtons = document.querySelectorAll('.popup-open');
  for (const button of openButtons) {
    button.addEventListener('click', showPopup);
  }

  const closeButtons = document.querySelectorAll('.popup-close');
  for (const button of closeButtons) {
    button.addEventListener('click', hidePopup);
  }

  const EASY_MODE_KEY = 'chicken-noodle-soap--easy-mode';
  const easyModeToggle = document.getElementById('easy-mode-toggle');
  const easyModeString = localStorage.getItem(EASY_MODE_KEY) || 'true';
  setEasyMode(easyModeString == 'true');

  function setEasyMode(easyMode) {
    localStorage.setItem(EASY_MODE_KEY, easyMode);
    document.body.dataset.difficulty = easyMode ? 'easy' : 'medium';
    easyModeToggle.checked = easyMode;
  }

  easyModeToggle.addEventListener('change', (event) => {
    setEasyMode(event.target.checked);
  });
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
