/* Chicken Noodle Soap Text Adventure Game Interface
 *
 * Copyright 2025 Joey Parrish
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 *
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Background music module.

// Defined in HTML:
declare global {
  const backgroundMusic: HTMLAudioElement;
  const backgroundMusicCredit: HTMLDivElement;
  const backgroundMusicLink: HTMLAnchorElement;
  const noMusic: HTMLDivElement;
}

async function startMusic(): Promise<void> {
  if (!backgroundMusic.paused && !backgroundMusic.ended) return;
  if (!backgroundMusic.currentSrc) return;

  try {
    await backgroundMusic.play();
  } catch (error) {}
}

let backgroundMusicLoopTo: number = 0;

export function setBackgroundMusic(relativeUrl: string, loopTo: number, credit: string, link: string): void {
  // The audio element has a canonical URL, so we have to canonicalize the
  // input to compare.
  const url = (new URL(relativeUrl, location.href)).href;
  if (backgroundMusic.currentSrc == url) {
    // Already playing this one, so don't do anything.
    return;
  }

  stopBackgroundMusic();

  backgroundMusic.src = url;
  // playbackRate might be 0 due to a previous call to pauseBackgroundMusic.
  backgroundMusic.playbackRate = 1;

  backgroundMusicLoopTo = loopTo;
  backgroundMusicCredit.textContent = credit;
  backgroundMusicLink.href = link;
  backgroundMusicLink.style.display = 'inline';
  noMusic.style.display = 'none';

  startMusic();
}

export function stopBackgroundMusic(): void {
  backgroundMusic.pause();
  backgroundMusic.src = '';

  noMusic.style.display = 'inline';
  backgroundMusicLink.style.display = 'none';
}

export function pauseBackgroundMusic(): void {
  // Don't use pause(), which is a state we get into also when awaiting user
  // interaction with the page to start the music.  Use playbackRate = 0, which
  // won't be reverted by play().  This gives us a separate override state for
  // music without pausing or unloading content.
  backgroundMusic.playbackRate = 0;
}

export function resumeBackgroundMusic(): void {
  backgroundMusic.playbackRate = 1;
}

export function initMusic(): void {
  window.addEventListener('click', startMusic);
  window.addEventListener('keydown', startMusic);

  vorple.addEventListener('quit', () => {
    stopBackgroundMusic();
  });

  backgroundMusic.addEventListener('ended', () => {
    backgroundMusic.currentTime = backgroundMusicLoopTo;
    startMusic();
  });
}
