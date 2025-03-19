async function startMusic() {
  if (!backgroundMusic.paused && !backgroundMusic.ended) return;
  if (!backgroundMusic.src) return;

  try {
    await backgroundMusic.play();
  } catch (error) {}
}

let backgroundMusicLoopTo = 0;

function setBackgroundMusic(url, loopTo, credit, link) {
  // The audio element has a canonical URL, so we have to canonicalize the
  // input to compare.
  url = (new URL(url, location.href)).href;
  if (backgroundMusic.src == url) {
    // Already playing this one.
    return;
  }

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
