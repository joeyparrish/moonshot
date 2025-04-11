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
    const steamworks = window.require('steamworks.js');
    client = steamworks.init(STEAM_APP_ID);
  }
}

export function getStat(name: string): number {
  if (isDesktopBundle()) {
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
  if (isDesktopBundle()) {
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
  if (isDesktopBundle()) {
    console.log('Unlocked: ' + name);
    if (!client.achievement.activate(name)) {
      console.error(`Failed to unlock achievement!`);
    }
  }
}

export function isUnlocked(name: string): boolean {
  if (isDesktopBundle()) {
    return client.achievement.isActivated(name);
  } else {
    return false;
  }
}

export function relock(name: string): void {
  if (isDesktopBundle()) {
    console.log('Relocking: ' + name);
    if (!client.achievement.clear(name)) {
      console.error(`Failed to relock achievement!`);
    }
  }
}
