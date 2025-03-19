async function startMusic() {
  // FIXME: support disabling music
  if (!backgroundMusic.paused && !backgroundMusic.ended) return;

  try {
    await backgroundMusic.play();
  } catch (error) {}
}

let backgroundMusicLoopTo = 0;

function setBackgroundMusic(url, loopTo, credit, link) {
  backgroundMusicLoopTo = loopTo;
  backgroundMusic.src = url;
  backgroundMusicCredit.textContent = credit;
  backgroundMusicLink.href = link;
  startMusic();
}

document.addEventListener('DOMContentLoaded', () => {
  window.addEventListener('click', startMusic);
  window.addEventListener('keydown', startMusic);

  backgroundMusic.addEventListener('ended', () => {
    backgroundMusic.currentTime = backgroundMusicLoopTo;
    startMusic();
  });
});
