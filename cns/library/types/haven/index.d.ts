namespace haven {
  interface HavenBufferMethods {
    append(text: string, targetWindow: number = 0): void;
    flush(targetWindow: number = 0): void;
    init(opt?: { outputFilter?: Function }): void;
    newline(targetWindow: number = 0): void;
  }

  interface HavenFileMethods {
    syncfs(toPersistent: boolean = false, callback: Function = null): void;
  }

  interface HavenKeypressMethods {
    addListener(listener: Function): () => void;
    init(): void;
    isWaiting(): boolean;
    removeListener(listener: Function): boolean;
    send(e: KeyEvent|MouseEvent): void;
    wait(): void;
    waitPromise(): Promise<void>;
  }

  interface HavenInputMethods {
    block(): void;
    getMode(): string|null;
    getIsTextPrinted(): boolean;
    init(opt: {expectHook?: Function, submitHook?: Function}): void;
    isBlocked(): boolean;
    keypress: HavenKeypressMethods;
    setMode(mode: string|null): void;
    textWasPrinted(newState: boolean = true): void;
    unblock(): void;
  }

  interface HavenHistoryMethods {
    add(cmd: string): boolean;
    clear(): void;
    get(): string[];
    remove(index: number): boolean;
    set(newHistory: string[]): void;
  }

  interface HavenPromptPrefixMethods {
    get(): string;
    set(prefix: string): void;
  }

  interface HavenPromptMethods {
    expectInput(): void;
    get(): HTMLElement;
    hide(): void;
    history: HavenHistoryMethods;
    sendCommand(e: Event, command: string): void;
    init(opt: {expectHook?: Function, submitHook?: Function, inputFilter?: Function, enginePrompt?: boolean, unicode?: boolean, engineInputFunction?: Function}): void;
    isReady(): boolean;
    prefix: HavenPromptPrefixMethods;
    scrollOrFocus(e: KeyEvent|MouseEvent): void;
    setDoScroll(status: boolean): void;
    setEngineInputFunction(func: Function): void;
    show(): void;
  }

  interface HavenAutosaveMethods {
    remove(): void;
    restore(): void;
    save(): void;
    setName(filename: string): void;
  }

  interface HavenStateMethods {
    autosave: HavenAutosaveMethods;
    restoreUI(): void;
  }

  interface HavenContainerMethods {
    append(container: HTMLElement, target: number|HTMLElement): void;
    get(targetWindow: number): HTMLElement;
    set(newContainer: HTMLElement, targetWindow: number): void;
  }

  interface HavenCursorPosition {
    col: number|null;
    line: number|null;
  }

  interface HavenUIState {
    cmdHistory: string[];
    currentColors: {text: number, background: number};
    font: {
      bold: boolean,
      italic: boolean,
      underline: boolean,
      proportional: boolean,
      original: number,
    };
    position: HavenCursorPosition;
    title: string;
    windowDimensions: {
      left: number,
      top: number,
      right: number,
      bottom: number,
    };
    windowContents: string;
  };

  interface HavenUIDimensions {
    window: {height: number, width: number};
    line: {height: number, width: number};
    char: {height: number, width: number};
  }

  interface HavenWindowPositionMethods {
    reset(targetWindow: number): void;
    restore(oldState: HavenCursorPosition): void;
    set(col: number|null, line: number|null, havenWindow: number): void;
  }

  interface HavenWindowMethods {
    append(content: string, targetWindow: number): void;
    clear(targetWindow: number): void;
    create(outputWindow: number, left: number, top: number, right: number, bottom: number): void;
    container: HavenContainerMethods;
    get(targetWindow: number): HTMLElement;
    getUIState(): HavenUIState;
    init(): void;
    measureDimensions: HavenUIDimensions;
    newTurnContainer(targetWindow: number): HTMLDivElement;
    rotateTurnMarkers(): void;
    position: HavenWindowPositionMethods;
    setTitle(title: string): void;
  }

  export const buffer: HavenBufferMethods;
  export const file: HavenFileMethods;
  export const input: HavenInputMethods;
  export const prompt: HavenPromptMethods;
  export const state: HavenStateMethods;
  export const window: HavenWindowMethods;
}
