// Utilities.  This module has has no side-effects on import.

export function scrollToBottom(): void {
  // Check for null in case this is called before the interpreter is
  // initialized.
  const vorpleElement = document.getElementById('vorple') as HTMLElement|null;
  if (vorpleElement) {
    vorpleElement.scrollTo(0, vorpleElement.scrollHeight);
  }
}

export function isDesktopBundle(): boolean {
  // If we're using nw.js, we're in a desktop bundle.
  if (window.nw) {
    return true;
  }
  return false;
}

export function isMobileBrowser(): boolean {
  return /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
}

// A decorator for listeners to ignore events that are not targeted for the
// exact element we're listening on.
export function exactTarget(element: HTMLElement, listener: EventListener): EventListener {
  return (event: Event) => {
    if (event.target == element) {
      listener(event);
    }
  };
}
