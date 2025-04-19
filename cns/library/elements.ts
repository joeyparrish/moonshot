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

// Based on vorple.layout.openTag, but with an open set of properties instead
// of only a set of class names.  The gymnastics Vorple goes through to create
// a hyperlink are very inefficient.  First create a unique ID, then create an
// element with that ID in a class name, then use jQuery to find and modify
// that element... Let's just create the element right the first time, in one
// JS call.
export function openTag(
    tagName: string,
    properties: {[key: string]: any},
    attributes: {[key: string]: string} = {},
    windowIndex: number = 0): void {
  haven.buffer.flush(windowIndex);

  const currentContainer = haven.window.container.get(windowIndex);
  const element = document.createElement(tagName) as HTMLElement;

  for (const key in properties) {
    // @ts-ignore
    element[key] = properties[key];
  }

  for (const key in attributes) {
    element.setAttribute(key, attributes[key]!);
  }

  haven.window.container.append(element, currentContainer);
  haven.window.container.set(element, windowIndex);
}

// Just delegate to Vorple.  No need to change this.
export function closeTag(windowIndex: number = 0): void {
  vorple.layout.closeTag(windowIndex);
}
