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

// Toast interface, for consistency

const DEFAULT_TOAST_DURATION_SECONDS = 20;

type ToastLevel = 'info'|'success'|'warning'|'error';

async function showToast(
    level: ToastLevel,
    title: string,
    description: string,
    // To dedup and replace toasts with newer ones for the same subject:
    key: string = '',
    timeoutSeconds: number = DEFAULT_TOAST_DURATION_SECONDS): Promise<HTMLElement> {
  // Defer toasts until we're in play mode.
  if (document.body.dataset['mode'] != 'play') {
    return new Promise(resolve => {
      setTimeout(() => {
        resolve(showToast(level, title, description, key, timeoutSeconds));
      }, 1000);
    });
  }

  // Find existing toasts for this same key.
  if (key) {
    const oldToastElements = Array.from(document.querySelectorAll<HTMLElement>(
        `.toast-info[data-key=${key}`));
    for (const oldToastElement of oldToastElements) {
      try {
        // We could use toastr.clear($(oldToastElement)), but that causes the old
        // one to fade away before disappearing.  Better to have the new one pop
        // over the old one much faster by simply removing the old one from the
        // DOM.
        $(oldToastElement).remove();
      } catch (error) {
        console.error('Failed to remove toast', oldToastElement, error);
      }
    }
  }

  const rv = toastr[level](
      description,
      title,
      {
        timeOut: timeoutSeconds * 1000,
        positionClass: 'toast-top-right',
      });
  const toastElement = rv[0]!;

  if (key) {
    toastElement.dataset['key'] = key;
  }

  return toastElement;
}

export function achievement(
    title: string,
    description: string,
    achievementName: string,
    timeoutSeconds?: number): Promise<HTMLElement> {
  // We abuse the "info" toast type for achievements.
  return showToast('info', title, description, achievementName, timeoutSeconds);
}

export function success(
    title: string,
    description: string,
    timeoutSeconds?: number): Promise<HTMLElement> {
  return showToast('success', title, description, '', timeoutSeconds);
}

export function warning(
    title: string,
    description: string,
    timeoutSeconds?: number): Promise<HTMLElement> {
  return showToast('warning', title, description, '', timeoutSeconds);
}

export function error(
    title: string,
    description: string,
    timeoutSeconds?: number): Promise<HTMLElement> {
  return showToast('error', title, description, '', timeoutSeconds);
}
