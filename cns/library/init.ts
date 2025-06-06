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

// Early initialization of Vorple, Quixe, Electron, and shared event listeners.

import {
  initAchievements,
} from './achievements.ts';

import {
  initAnalytics,
  logEvent,
} from './analytics.ts'

import {
  initCloudSync,
} from './cloud-sync.ts';

import {
  initCredits,
  stopCredits,
} from './credits.ts';

import {
  initMusic,
} from './music.ts';

import {
  initPopups,
} from './popups.ts';

import {
  initSplash,
  stopSplash,
} from './splash.ts';

import {
  getCPU,
  getOS,
  isDesktopBundle,
  isMobileBrowser,
  scrollToBottom,
  toggleFullscreen,
} from './util.ts';

import type * as FSModule from 'fs';
import type * as PathModule from 'path';

// Defined in HTML:
declare global {
  const desktopCredit: HTMLDivElement;
  const desktopLicense: HTMLDetailsElement;
  const window0: HTMLDivElement;
  const output: HTMLDivElement;
}

let fs: typeof FSModule;
let path: typeof PathModule;
let logFile: number|null = null;

function stopSplashOnKeyDown(event: KeyboardEvent): void {
  // Don't monkey with key presses during gameplay.
  if (document.body && document.body.dataset['mode'] == 'play') {
    return;
  }

  // Don't let key presses go to the interpreter input in non-gameplay
  // modes.
  event.stopImmediatePropagation();
  if (event.key === 'Escape' || event.key === 'Enter') {
    if (document.body.dataset['mode'] == 'splash') {
      stopSplash();
    } else {
      stopCredits();
    }
  }
}

function initLogFile(): void {
  fs = window.require('fs');
  path = window.require('path');

  const gameFolder = path.dirname(process.execPath);
  const logFilePath = path.join(gameFolder, 'log.txt');

  try {
    fs.renameSync(logFilePath, logFilePath + '.previous');
  } catch (error) {}

  logFile = fs.openSync(logFilePath, 'w', 0o644);
}

function logToFile(level: string, args: IArguments): void {
  if (logFile !== null) {
    const now = new Date();
    fs.writeFileSync(logFile, `[${now}][${level}]:`);
    for (const arg of args) {
      if (typeof arg == 'object') {
        fs.writeFileSync(logFile, ` ${JSON.stringify(arg)}`);
      } else {
        fs.writeFileSync(logFile, ` ${arg}`);
      }
    }
    fs.writeFileSync(logFile, '\n', { flush: true });
  }
}

function wrapLogMethod(level: 'debug'|'log'|'info'|'warn'|'error'): void {
  const original = console[level];
  console[level] = function() {
    try {
      // @ts-ignore
      original.apply(console, arguments);
    } catch (error) {}

    try {
      logToFile(level, arguments);
    } catch (error) {}
  };
}

function redirectLogsToFile(): void {
  if (isDesktopBundle()) {
    initLogFile();
    wrapLogMethod('debug');
    wrapLogMethod('log');
    wrapLogMethod('info');
    wrapLogMethod('warn');
    wrapLogMethod('error');
  }
}

function initVorple(): void {
  // Disable debugging features, then initialize Vorple.
  vorple.debug.off();
  vorple.init();

  // Some Vorple prompts (like after "quit") don't scroll to the bottom
  // automatically.  Fix that here.
  vorple.addEventListener('expectCommand', scrollToBottom);

  vorple.addEventListener('quit', () => {
    // Try closing the window.  This works on desktop builds, but not in
    // browsers.
    window.close();

    // That fails in browsers, so now we add this message to the game's
    // "window" element.
    window0.appendChild(
        document.createTextNode('You may now close this window.'));
    scrollToBottom();
  });
}

function initDebugElements(): void {
  // Show/hide elements for debugging.
  const isMobileBrowserElement =
      document.querySelector<HTMLDivElement>('#is-mobile-browser')!;
  const isDesktopBrowserElement =
      document.querySelector<HTMLDivElement>('#is-desktop-browser')!;
  const isDesktopBundleElement =
      document.querySelector<HTMLDivElement>('#is-desktop-bundle')!;
  const osElement =
      document.querySelector<HTMLDivElement>('#show-os')!;
  const cpuElement =
      document.querySelector<HTMLDivElement>('#show-cpu')!;
  const userAgentElement =
      document.querySelector<HTMLDivElement>('#show-user-agent')!;

  osElement.innerText = 'OS: ' + getOS();
  cpuElement.innerText = 'CPU: ' + getCPU();
  userAgentElement.innerText = 'User Agent: ' + navigator.userAgent;

  logEvent(getOS(), /* userInput= */ false);
  logEvent(getCPU(), /* userInput= */ false);

  if (isDesktopBundle()) {
    isMobileBrowserElement.style.display = 'none';
    isDesktopBrowserElement.style.display = 'none';
    userAgentElement.style.display = 'none';
  } else if (isMobileBrowser()) {
    isDesktopBrowserElement.style.display = 'none';
    isDesktopBundleElement.style.display = 'none';
  } else {  // Desktop browser
    isMobileBrowserElement.style.display = 'none';
    isDesktopBundleElement.style.display = 'none';
  }
}

function logBuildType(): void {
  if (isDesktopBundle()) {
    logEvent('desktop', /* userInput= */ false);
  } else if (isMobileBrowser()) {
    logEvent('mobile', /* userInput= */ false);
  } else {
    logEvent('browser', /* userInput= */ false);
  }
}

function enableBuildSpecificElements(): void {
  if (isDesktopBundle()) {
    // Enable desktop-bundle-specific elements.
    for (const element of
         document.querySelectorAll<HTMLElement>('.desktop-bundle-only')) {
      element.style.display = 'block';
    }
  } else {
    // Enable browser-specific elements.
    for (const element of
         document.querySelectorAll<HTMLElement>('.browser-only')) {
      element.style.display = 'block';
    }
  }

  if (isMobileBrowser()) {
    // Flag mobile status for CSS use.
    document.body.dataset['mobile'] = 'true';
  }
}

function enableFullscreen(): void {
  if (isDesktopBundle()) {
    // Allow F10 to toggle fullscreen.
    document.addEventListener('keypress', (event) => {
      if (event.key === 'F10') {
        toggleFullscreen();
      }
    });
  }
}

async function init(firedEarly: boolean): Promise<void> {
  const inits: [() => (void|Promise<void>), string][] = [
    [redirectLogsToFile, 'redirect logs to file'],
    [initVorple, 'init Vorple'],
    [initAnalytics, 'init analytics'],
    [initCloudSync, 'init cloud sync'],
    [initDebugElements, 'init debug elements'],
    [initAchievements, 'init achievements'],
    [initMusic, 'init music'],
    [initPopups, 'init popups'],
    [initCredits, 'init credits'],
    [initSplash, 'init splash'],
    [logBuildType, 'log build type'],
    [enableBuildSpecificElements, 'enable build-specific elements'],
    [enableFullscreen, 'enable fullscreen'],
  ];

  for (const [fn, name] of inits) {
    try {
      await fn();
    } catch (error) {
      console.error(`Failed to ${name}!`, error);
    }
  }

  if (firedEarly) {
    console.log('DOMContentLoaded fired early!');
  }
}

// Global keypresses are used to stop splash screen or credits early.
document.addEventListener('keydown', stopSplashOnKeyDown, { capture: true });

// Scroll to the bottom on window resize.  Also triggered by font size changes.
window.addEventListener('resize', scrollToBottom);

// Do main initialization after loading the DOM content.
if (document.readyState == 'complete') {
  void init(true);
} else {
  document.addEventListener('DOMContentLoaded', () => void init(false));
}

// Log unhandled errors.
window.addEventListener('error', (event) => {
  console.error('Unhandled error:', {
    message: event.message,
    filename: event.filename,
    lineno: event.lineno,
    colno: event.colno,
  });
});

// Log unhandled Promise rejections.
window.addEventListener('unhandledrejection', (event) => {
  console.error('Unhandled rejection:', {
    reason: event.reason,
  });
});
