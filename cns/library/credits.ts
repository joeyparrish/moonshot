// Everything related to the scrolling credits.

import {
  scrollToBottom,
} from './util.ts';

// Defined in HTML:
declare global {
  const creditsOuterSizer: HTMLDivElement;
  const creditsWrapper: HTMLDivElement;
  const credits: HTMLDivElement;
}

function fixCreditSizing() {
  // Set this sizer's height based on runtime sizing so that the
  // percentages in CSS calc() will work.
  creditsOuterSizer.style.height = creditsWrapper.clientHeight + 'px';
}

export function stopCredits() {
  document.body.dataset['mode'] = 'play';
  scrollToBottom();
}

export function showCredits() {
  document.body.dataset['mode'] = 'credits';
  // Let render & layout happen, then fix sizing.  The credits animation
  // has a 2s delay, so this 1s delay on sizing works.
  setTimeout(fixCreditSizing, 1000);
}

document.addEventListener('DOMContentLoaded', () => {
  // The credits sizer needs to be updated with a calculated content size to
  // make scrolling work.
  window.addEventListener('resize', fixCreditSizing);

  // When the animation ends, stop the credits.
  creditsWrapper.onanimationend = stopCredits;

  // When the user clicks, stop the credits.
  credits.addEventListener('click', stopCredits);
});
