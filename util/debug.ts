/**
 * Shorthand for
 *
 * ```typescript
 * if (process.env.NODE_ENV === "development") {
 *   console.log(message, ...optionalParams);
 * }
 * ```
 */
export function devLog(...data: any[]): void;
export function devLog(message?: any, ...optionalParams: any[]): void {
  if (process.env.NODE_ENV === "development") {
    console.log(message, ...optionalParams);
  }
}
