namespace Glk {
  interface GlkStream {
    // This is all we care about right now.
    filename: string;
  }

  export function glk_put_buffer_stream(stream: GlkStream, array: number[]): void;
}
