// Everything related to game transcripts.

import {
  hideAutoComplete,
  maybeShowAutoComplete,
} from './auto-complete.ts';

interface TranscriptBody {
  comments: string,
  transcriptText: string,
  transcriptHTML: string,
}

export function captureHTML(includeAutoComplete: boolean): string {
  if (!includeAutoComplete) {
    hideAutoComplete();
  }
  const transcriptHTML = output.outerHTML;
  if (!includeAutoComplete) {
    maybeShowAutoComplete();
  }
  return transcriptHTML;
}

export function captureText(includeAutoComplete: boolean): string {
  if (!includeAutoComplete) {
    hideAutoComplete();
  }
  const transcriptText = output.innerText;
  if (!includeAutoComplete) {
    maybeShowAutoComplete();
  }
  return transcriptText;
}

export function restoreTranscript(html: string): void {
  // TODO: Sanitize this, in case the user has hacked it!
  output.outerHTML = html;
}

export async function saveTranscript(): Promise<void> {
  const text = captureText(/* includeAutoComplete= */ false);
  const blob = new Blob([text], {type: 'text/plain'});
  const suggestedName = `${document.title} Transcript.txt`;

  if (!!window.showSaveFilePicker) {
    try {
      const handle = await showSaveFilePicker({suggestedName});
      const writable = await handle.createWritable();
      await writable.write(blob);
      await writable.close();
    } catch (error) {
      console.error('Failed to save transcript:', error);
    }
  } else {
    // Fallback for Firefox & Safari as of April 2025
    // TODO: Untested!
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.style.display = 'none';
    a.href = url;
    a.download = suggestedName;
    document.body.appendChild(a);
    a.click();
    setTimeout(() => document.body.removeChild(a), 500);
  }
}

function delay(seconds: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, seconds * 1000));
}

export async function reportBug(comments: string, button: HTMLButtonElement): Promise<void> {
  const buttonText = button.innerText;
  try {
    button.disabled = true;

    const body: TranscriptBody = {
      comments,
      transcriptText: captureText(/* includeAutoComplete= */ false),
      transcriptHTML: captureHTML(/* includeAutoComplete= */ false),
    };

    // POST to server
    const bugUrl = `https://chickennoodlesoap.com/api/transcript/${document.title}`;
    const response = await fetch(bugUrl, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    });

    if (!response.ok) {
      const errorText = response.text();
      console.error('Failed to post bug report:', response.statusText, errorText);
      throw new Error('Failed to post bug report!');
    }

    button.innerText = 'Report sent!';
  } catch (error) {
    button.innerText = 'Failed!';
  } finally {
    await delay(5);
    button.disabled = false;
    button.innerText = buttonText;
  }
}
