// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/** Minimal assertion helpers, kept in-repo so the test suite has zero remote dependencies. */

export function assert(
  condition: unknown,
  message = "assertion failed",
): asserts condition {
  if (!condition) throw new Error(message);
}

export function assertEquals(
  actual: unknown,
  expected: unknown,
  message?: string,
): void {
  const a = JSON.stringify(actual);
  const e = JSON.stringify(expected);
  if (a !== e) {
    throw new Error(message ?? `expected ${e}, got ${a}`);
  }
}

export function assertStringIncludes(
  actual: string,
  expected: string,
  message?: string,
): void {
  if (!actual.includes(expected)) {
    throw new Error(
      message ??
        `expected ${JSON.stringify(actual)} to include ${
          JSON.stringify(expected)
        }`,
    );
  }
}
