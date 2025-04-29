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

function showToast(
    level: ToastLevel,
    title: string,
    description: string,
    timeoutSeconds: number = DEFAULT_TOAST_DURATION_SECONDS): HTMLElement {
  const rv = toastr[level](
      description,
      title,
      {
        timeOut: timeoutSeconds * 1000,
        positionClass: 'toast-top-right',
      });
  const toastElement = rv[0]!;
  return toastElement;
}

export function achievement(
    title: string,
    description: string,
    timeoutSeconds?: number): HTMLElement {
  // We abuse the "info" toast type for achievements.
  return showToast('info', title, description, timeoutSeconds);
}

export function success(
    title: string,
    description: string,
    timeoutSeconds?: number): HTMLElement {
  return showToast('success', title, description, timeoutSeconds);
}

export function warning(
    title: string,
    description: string,
    timeoutSeconds?: number): HTMLElement {
  return showToast('warning', title, description, timeoutSeconds);
}

export function error(
    title: string,
    description: string,
    timeoutSeconds?: number): HTMLElement {
  return showToast('error', title, description, timeoutSeconds);
}
