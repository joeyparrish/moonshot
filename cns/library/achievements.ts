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

// Achievements interface, connected to Steam in desktop bundles

import {
  isDesktopBundle,
} from './util.ts';

import type {
  Client,
} from 'steamworks.js';

// Defined in HTML:
declare global {
  const STEAM_APP_ID: number;
}

let client: Client;

export function initAchievements(): void {
  if (isDesktopBundle()) {
    try {
      const steamworks = window.require('steamworks.js');
      client = steamworks.init(STEAM_APP_ID);
    } catch (error) {
      toastr.error(
          'Achievements and stats are unavailable.',
          'Failed to load Steam API!', {
            timeOut: 10 * 1000,
            positionClass: 'toast-bottom-right',
          });
      console.error('Failed to load Steam API!', error);
    }
  }
}

export function getStat(name: string): number {
  if (isDesktopBundle() && client) {
    const value = client.stats.getInt(name);
    if (value === null) {
      console.error(`Failed to get stat ${name}!`);
      return 0;
    }
    return value;
  } else {
    return 0;
  }
}

export function setStat(name: string, value: number): void {
  if (isDesktopBundle() && client) {
    if (!client.stats.setInt(name, value) || !client.stats.store()) {
      console.error(`Failed to set stat ${name}!`);
    }
  }
}

export function incrementStat(name: string): void {
  const value = getStat(name) + 1;
  setStat(name, value);
}

export function addBit(name: string, bit: number): void {
  const value = getStat(name) | (1 << (bit - 1));
  setStat(name, value);
}

export function countBits(maskName: string, statName: string): void {
  let value = getStat(maskName);
  let bits = 0;

  while (value) {
    if (value & 1) {
      bits++;
    }
    value >>= 1;
  }

  setStat(statName, bits);
}

export function unlock(name: string): void {
  if (isDesktopBundle() && client) {
    console.log('Unlocked: ' + name);
    if (!client.achievement.activate(name)) {
      console.error(`Failed to unlock achievement!`);
    }
  }
}

export function isUnlocked(name: string): boolean {
  if (isDesktopBundle() && client) {
    return client.achievement.isActivated(name);
  } else {
    return false;
  }
}

export function relock(name: string): void {
  if (isDesktopBundle() && client) {
    console.log('Relocking: ' + name);
    if (!client.achievement.clear(name)) {
      console.error(`Failed to relock achievement!`);
    }
  }
}
