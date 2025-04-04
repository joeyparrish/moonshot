(function () {
  // Set Quixe (interpreter) options so that it doesn't change the page title.
  window.game_options = {
    set_page_title: false,
  };

  function play() {
    // Ignore during the credits or if already in play.
    const mode = document.body.dataset.mode;
    if (mode == 'credits' || mode == 'play') {
      return;
    }

    // Go into play mode.
    document.body.dataset.mode = 'play';
  }

  function fixCreditSizing() {
    // Set this sizer's height based on runtime sizing so that the
    // percentages in CSS calc() will work.
    creditsOuterSizer.style.height = creditsWrapper.clientHeight + 'px';
  }

  function stopCredits() {
    document.body.dataset.mode = 'play';
    scrollToBottom();
  }

  function showCredits() {
    document.body.dataset.mode = 'credits';
    // Let render & layout happen, then fix sizing.  The credits animation
    // has a 2s delay, so this 1s delay on sizing works.
    setTimeout(fixCreditSizing, 1000);
  }

  function scrollToBottom() {
    const vorpleElement = document.getElementById('vorple');
    if (vorpleElement) {
      vorpleElement.scrollTo(0, vorpleElement.scrollHeight);
    }
  }

  function isDesktopBundle() {
    if (window.nw) {
      return true;
    }
    return false;
  }
  window.isDesktopBundle = isDesktopBundle;

  document.addEventListener('DOMContentLoaded', () => {
    window.addEventListener('resize', fixCreditSizing);

    // Move on after the animations end, or a click, or escape, or enter.
    document.getElementById('cover').onanimationend = play;
    creditsWrapper.onanimationend = stopCredits;

    splash.addEventListener('click', play);
    credits.addEventListener('click', stopCredits);

    document.addEventListener('keydown', (event) => {
      // Don't monkey with key presses during gameplay.
      if (document.body.dataset.mode == 'play') {
        return;
      }

      // Don't let key presses go to the interpreter input in non-gameplay
      // modes.
      event.stopImmediatePropagation();
      if (event.key === 'Escape' || event.key === 'Enter') {
        if (document.body.dataset.mode == 'splash') {
          play();
        } else {
          stopCredits();
        }
      }
    }, { capture: true });

    // Disable debugging features, then initialize Vorple.
    vorple.debug.off();
    vorple.init();

    // Some Vorple prompts (like after "quit") don't scroll to the bottom
    // automatically.  Fix that here.
    vorple.addEventListener('expectCommand', scrollToBottom);

    if (isDesktopBundle()) {
      // Enable desktop-bundle-specific elements.
      desktopCredit.style.display = 'block';
      desktopLicense.style.display = 'block';

      // Open target=_blank links in the default browser.
      nw.Window.get().on('new-win-policy', function(frame, url, policy) {
        // Do not open the window.
        policy.ignore();
        // Open it in the user's default browser.
        nw.Shell.openExternal(url);
      });
    }

    // Start the splash screen.
    document.body.dataset.mode = 'splash';
  });

  // Export public functions:
  window.showCredits = showCredits;
  window.scrollToBottom = scrollToBottom;
})();
