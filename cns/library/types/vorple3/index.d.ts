namespace vorple {
  type VorpleEventCategory = "init" | "expectCommand" | "submitCommand" | "expectKeypress" | "submitKeypress" | "quit";
  type VorpleEventListener = (meta: VorpleEventMetadata) => Promise<void> | void;

  interface VorpleEventMetadata {
    event?: MouseEvent | KeyboardEvent;
    input?: string | number;
    mouseClick?: boolean;
    original?: string | number;
    silent?: boolean;
    type: VorpleEventCategory;
    userAction?: boolean;
  }

  interface VorpleDebug {
    error(text: string): true;
    log(text: string): boolean;
    on(): void;
    off(): void;
    status(): boolean;
    toggle(newState?: boolean): boolean;
  }

  interface VorpleInputFilterMeta {
    input: string;
    original: string;
    silent: boolean;
    type: "line" | "char";
    userAction: boolean;
  }

  // If === false, cancel the input.  If true (or undefined), let the input pass.
  type VorpleInputFilter = (input: string, meta: VorpleInputFilterMeta) => boolean|void;

  interface VorplePrompt {
    addInputFilter(filter: VorpleInputFilter): (() => void);
    applyInputFilters(originalInput: string, meta: VorpleInputFilterMeta): Promise<string|false>;
    clearCommandQueue(): void;
    clearKeyQueue(): void;
    hide(): void;
    init(): void;
    queueCommand(cmd: string, silent?: boolean): void;
    queueKeypress(key: string): void;
    removeInputFilter(filter: VorpleInputFilter): boolean;
    setPrefix(prefix: string, isHtml?: boolean): string;
    setValue(value: string): void;
    submit(command?: null | string, silent?: boolean): void;
    unhide(): void;
  }

  interface VorpleFile {
    init(): Promise<FSModule>;
    getFS(): FSModule;
  }

  interface VorpleLayout {
    block(): void;
    closeTag(targetWindow?: number): boolean;
    focus(targetElement: string | PlainObject<any>, targetWindow?: number): boolean;
    isBlocked(): boolean;
    openTag(tagName: string, classes: string, targetWindow?: number): true;
    scrollTo(target: string | PlainObject<any>, speed?: number): Promise<boolean>;
    scrollToEnd(speed?: number): Promise<void>;
    unblock(): void;
  }

  export const debug: VorpleDebug;
  export const file: VorpleFile;
  export const layout: VorpleLayout;
  export const prompt: VorplePrompt;

  export function addEventListener(type: VorpleEventCategory|VorpleEventCategory[], listener: VorpleEventListener): (() => void);
  export function checkVersion(versionRange: string): boolean;
  export function evaluate(code: string): void;
  export function getInformVersion(): 6 | 7 | undefined;
  export function init(): void;
  export function removeEventListener(eventNames: VorpleEventCategory | VorpleEventCategory[], listener: VorpleEventListener): boolean;
  export function requireVersion(requiredVersion: string, callback?: ((versionMatches: boolean) => void)): boolean;
  export function setInformVersion(version: 7 | 6): void;
  export function triggerEvent(eventName: VorpleEventCategory, meta?: Partial<VorpleEventMetadata>): Promise<void>;
}
