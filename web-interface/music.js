async function startMusic() {
  if (!backgroundMusic.paused && !backgroundMusic.ended) return;
  if (!backgroundMusic.currentSrc) return;

  try {
    await backgroundMusic.play();
  } catch (error) {}
}

let backgroundMusicLoopTo = 0;

function setBackgroundMusic(relativeUrl, loopTo, credit, link) {
  // The audio element has a canonical URL, so we have to canonicalize the
  // input to compare.
  const url = (new URL(relativeUrl, location.href)).href;
  if (backgroundMusic.currentSrc == url) {
    // Already playing this one, so don't do anything.
    return;
  }

  stopBackgroundMusic();

  backgroundMusic.src = url;
  backgroundMusicLoopTo = loopTo;
  backgroundMusicCredit.textContent = credit;
  backgroundMusicLink.href = link;
  backgroundMusicLink.style.display = 'inline';
  noMusic.style.display = 'none';

  startMusic();
}

function stopBackgroundMusic() {
  backgroundMusic.pause();
  backgroundMusic.src = '';

  noMusic.style.display = 'inline';
  backgroundMusicLink.style.display = 'none';
}

document.addEventListener('DOMContentLoaded', () => {
  window.addEventListener('click', startMusic);
  window.addEventListener('keydown', startMusic);

  backgroundMusic.addEventListener('ended', () => {
    backgroundMusic.currentTime = backgroundMusicLoopTo;
    startMusic();
  });
});
