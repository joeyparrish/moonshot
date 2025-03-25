(function () {
  // Prevent the right-click context menu in desktop bundles.
  if (window.__TAURI__) {
    document.addEventListener('contextmenu', event => event.preventDefault());
  }
    
  // Set Quixe (interpreter) options so that it doesn't change the page title.
  window.game_options = {
    set_page_title: false,
  };

  function play() {
    // Ignore during the credits or if already in play.
    if (document.body.classList.contains('credits') ||
        document.body.classList.contains('play')) {
      return;
    }

    // Hide the splash screen.
    document.body.classList.add('play');

    if (document.getElementById('vorple') == null) {
      // Disable debugging features, then initialize Vorple.
      vorple.debug.off();
      vorple.init();
    }
  }
    
  function fixCreditSizing() {
    // Set this sizer's height based on runtime sizing so that the
    // percentages in CSS calc() will work.
    creditsOuterSizer.style.height = creditsWrapper.clientHeight + 'px';
  }

  window.addEventListener('resize', fixCreditSizing);

  function stopCredits() {
    document.body.classList.remove('credits');
    document.body.classList.add('play');
    scrollToBottom();
  }

  function showCredits() {
    document.body.classList.remove('play');
    document.body.classList.add('credits');
    // Let render & layout happen, then fix sizing.  The credits animation
    // has a 2s delay, so this 1s delay on sizing works.
    setTimeout(fixCreditSizing, 1000);

    creditsWrapper.onanimationend = stopCredits;
  }

  document.addEventListener('DOMContentLoaded', () => {
    // Move on after the animations end, or a click, or escape, or enter.
    document.getElementById('cover').onanimationend = play;
    document.addEventListener('click', play);
    document.addEventListener('keypress', (event) => {
      if (event.key === "Escape" || event.key === "Enter") {
        play();
        stopCredits();
      }
    });

    // Enable desktop-bundle-specific elements.
    tauriCredit.style.display = 'block';
    tauriLicense.style.display = 'block';
  });

  function scrollToBottom() {
    window.scrollTo(0, document.body.clientHeight);
  }

  function tellTauri(name /* string */, args /* object */) {
    if (window.__TAURI__) {
      window.__TAURI__.core.invoke(name, args);
    }
  }

  // Export public functions:
  window.showCredits = showCredits;
  window.scrollToBottom = scrollToBottom;
  window.tellTauri = tellTauri;
})();
