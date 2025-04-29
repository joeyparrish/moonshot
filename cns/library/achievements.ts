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
  achievement as toastAchievement,
  error as toastError,
} from './toast.ts';

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

interface AchievementMetadata {
  title: string;
  description: string;
  secret?: boolean;
  stat?: string;
  target?: number;
}

interface AchievementMetadataMap {
  [key: string]: AchievementMetadata;
}

interface StatMetadata {
  target: number;
  achievementName: string;
}

interface StatMetadataMap {
  [key: string]: StatMetadata;
}

const UNLOCKED = 'unlocked';
const SECRET_ICON = 'achievements/secret.png';
let achievements: AchievementMetadataMap = {};
let stats: StatMetadataMap = {};
let client: Client;

function achievementKey(name: string): string {
  return `chicken-noodle-soap--achievements--${name}`;
}

function achievementIcon(name: string, status: 'locked'|'unlocked'): string {
  return `achievements/${name}_${status}.png`;
}

async function showAchievement(
    achievementName: string,
    title: string,
    description: string,
    icon: string): Promise<void> {
  const toastElement = await toastAchievement(title, description, achievementName);
  toastElement.style.setProperty('--achievement-icon', `url(${icon})`);
}

function connectStatsToAchievement(statName: string, value: number): void {
  // In browser builds, we don't have a stats system tied to achievements
  // automatically.  In desktop builds, we have Steam, but the toasts don't
  // show up because we don't have support for the Steam overlay.  Because of
  // that, we don't merely depend on Steam to link stats to achievements.  We
  // also implement that here for consistent display.

  if (statName in stats) {
    const {achievementName, target} = stats[statName]!;
    if (value >= target) {
      unlock(achievementName);
    } else {
      relock(achievementName);
      if (achievementName in achievements) {
        const { title, description } = achievements[achievementName]!;
        showAchievement(
            achievementName,
            `Achievement Progress\n\n${title}`,
            `${description}\n${value} / ${target}`,
            achievementIcon(achievementName, 'locked'));
      }
    }
  }
}

export async function initAchievements(): Promise<void> {
  if (isDesktopBundle()) {
    try {
      const steamworks = window.require('steamworks.js');
      client = steamworks.init(STEAM_APP_ID);
    } catch (error) {
      toastError('Failed to load Steam API!',
          'Achievements and stats are unavailable.');
      console.error('Failed to load Steam API!', error);
    }
  }

  // Get achievement metadata in all environments.
  const response = await fetch('achievements/metadata.json');
  achievements = await response.json() as AchievementMetadataMap;

  for (const achievementName in achievements) {
    const metadata = achievements[achievementName]!;
    if (metadata.stat) {
      stats[metadata.stat] = {
        achievementName,
        target: metadata.target!,
      };
    }
  }
}

export function getStat(name: string): number {
  if (isDesktopBundle()) {
    if (!client) return 0;

    const value = client.stats.getInt(name);
    if (value === null) {
      console.error(`Failed to get stat ${name}!`);
      return 0;
    }
    return value;
  } else {
    const stringValue = localStorage.getItem(achievementKey(name));
    return stringValue ? parseInt(stringValue, 10) : 0;
  }
}

export function setStat(name: string, value: number): void {
  if (isDesktopBundle()) {
    if (!client) return;
    if (!client.stats.setInt(name, value) || !client.stats.store()) {
      console.error(`Failed to set stat ${name}!`);
    }
  } else {
    if (value != getStat(name)) {
      localStorage.setItem(achievementKey(name), value.toString());
    }
  }

  connectStatsToAchievement(name, value);
}

export function incrementStat(name: string): void {
  const value = getStat(name) + 1;
  setStat(name, value);
}

export function addBit(name: string, bit: number): void {
  // Bits are 1-based in inform, so a zero gets ignored.
  if (bit == 0) return;

  const value = getStat(name) | (1 << (bit - 1));
  setStat(name, value);
}

export function countBits(maskName: string, statName: string): void {
  let value = getStat(maskName);
  let bits = 0;

  while (value > 0) {
    if (value & 1) {
      bits++;
    }
    value >>= 1;
  }

  setStat(statName, bits);
}

export function unlock(name: string): void {
  console.log('Unlocked: ' + name);

  if (isUnlocked(name)) return;

  if (isDesktopBundle()) {
    if (!client) return;
    if (!client.achievement.activate(name)) {
      console.error(`Failed to unlock achievement!`);
    }
  } else {
    localStorage.setItem(achievementKey(name), UNLOCKED);
  }

  if (name in achievements) {
    const { title, description } = achievements[name]!;
    showAchievement(
        name,
        `Achievement Unlocked!\n\n${title}`,
        description,
        achievementIcon(name, 'unlocked'));
  }
}

export function isUnlocked(name: string): boolean {
  if (isDesktopBundle()) {
    if (!client) return false;
    return client.achievement.isActivated(name);
  } else {
    return localStorage.getItem(achievementKey(name)) == UNLOCKED;
  }
}

export function relock(name: string): void {
  console.log('Relocking: ' + name);

  if (isDesktopBundle()) {
    if (!client) return;
    if (!client.achievement.clear(name)) {
      console.error(`Failed to relock achievement!`);
    }
  } else {
    localStorage.removeItem(achievementKey(name));
  }
}

export function showAchievements(): void {
  const achievementContainer = document.getElementById('achievement-container')!;
  while (achievementContainer.children.length) {
    achievementContainer.removeChild(achievementContainer.lastElementChild!);
  }

  const unlocked: HTMLDivElement[] = [];
  const partial: HTMLDivElement[] = [];
  const locked: HTMLDivElement[] = [];
  const hidden: HTMLDivElement[] = [];

  for (const name in achievements) {
    const {title, description, secret, stat, target} = achievements[name]!;
    const div = document.createElement('div');
    div.classList.add('achievement');

    const imgElement = document.createElement('img');
    const titleElement = document.createElement('div');
    const descriptionElement = document.createElement('div');
    const progressElement = document.createElement('div');

    titleElement.classList.add('title');
    descriptionElement.classList.add('description');
    progressElement.classList.add('progress');

    const thisIsUnlocked = isUnlocked(name);
    if (!thisIsUnlocked && secret) {
      imgElement.src = SECRET_ICON;
      titleElement.innerText = 'Hidden Achievement';
      descriptionElement.innerText = 'Revealed once unlocked.';

      hidden.push(div);
    } else {
      imgElement.src = achievementIcon(
          name, thisIsUnlocked ? 'unlocked' : 'locked');
      titleElement.innerText = title;
      descriptionElement.innerText = description;
      if (stat) {
        const value = getStat(stat);
        progressElement.innerText = `Progress: ${value} / ${target}`;
      }

      if (thisIsUnlocked) {
        unlocked.push(div);
      } else if (stat) {
        partial.push(div);
      } else {
        locked.push(div);
      }
    }

    div.appendChild(imgElement);
    div.appendChild(titleElement);
    div.appendChild(descriptionElement);
    div.appendChild(progressElement);
  }

  for (const div of unlocked) {
    achievementContainer.appendChild(div);
  }
  for (const div of partial) {
    achievementContainer.appendChild(div);
  }
  for (const div of locked) {
    achievementContainer.appendChild(div);
  }
  for (const div of hidden) {
    achievementContainer.appendChild(div);
  }
}
