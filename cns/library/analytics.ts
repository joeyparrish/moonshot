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

// Google Analytics module.

export function logEvent(action: string, userInput: boolean = false): void {
  gtag('event', action, {
    'event_category': 'game',
    // 'event_label': ,
    // 'value': ,
    'non_interaction': !userInput,
    // non_interaction set to true will exclude the event from "engagement"
    // measurements.
  });
}

export function initAnalytics(): void {
  vorple.prompt.addInputFilter((_input, meta) => {
    if (meta.userAction && meta.type == "line") {
      // If it's user action and line type, the user typed something and hit
      // enter.  When that happens, send a "turn" event.
      logEvent('turn', /* userInput */ true);
    }
  });
}
