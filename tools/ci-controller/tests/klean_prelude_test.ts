// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CC0-1.0

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  DECLARATION,
  INSTANCE,
  patchPreludeReport,
  patchText,
  PROBE_NOTE,
} from "../src/klean_prelude.ts";

// Parity cases transcribed from scripts/ci/test_patch_klean_prelude.py,
// plus the probe-marker contract added by the Deno port: the shim
// is a compatibility probe, never a soundness argument.

function assertThrows(fn: () => unknown, pattern: RegExp): void {
  try {
    fn();
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    assert(
      pattern.test(message),
      `expected error matching ${pattern}, got ${JSON.stringify(message)}`,
    );
    return;
  }
  throw new Error(`expected function to throw matching ${pattern}`);
}

Deno.test("removes only the duplicate helper and keeps the instance", () => {
  const prefix = "import Lean\n\n-- Prelude fixture\n";
  const block = DECLARATION + "\n  match a, b with\n  | x, y => exact x\n\n";
  const suffix = INSTANCE + "\n";
  const patched = patchText(prefix + block + suffix);
  assertEquals(patched, prefix + suffix);
  assert(!patched.includes(DECLARATION));
  assertStringIncludes(patched, INSTANCE);
});

Deno.test("fails closed when the signature changes", () => {
  assertThrows(
    () => patchText("import Lean\n\n" + INSTANCE + "\n"),
    /generator output changed/,
  );
});

Deno.test("fails closed when the instance anchor is missing", () => {
  const source = DECLARATION + "\n  := by decide\n";
  assertThrows(() => patchText(source), /instance/);
});

Deno.test("fails closed when the instance occurs before the declaration", () => {
  const source = INSTANCE + "\n" + DECLARATION + "\n  body\n";
  assertThrows(
    () => patchText(source),
    /generated instance occurs before ByteArray.decEq declaration/,
  );
});

Deno.test("fails closed on an extra declaration inside the shim span", () => {
  const source = DECLARATION + "\n  def inner := 1\n" + INSTANCE + "\n";
  assertThrows(
    () => patchText(source),
    /unexpected extra declaration in compatibility shim span/,
  );
});

Deno.test("fails closed when the declaration is not followed by a newline", () => {
  const source = DECLARATION + " " + INSTANCE + "\n";
  assertThrows(
    () => patchText(source),
    /unexpected ByteArray.decEq declaration formatting/,
  );
});

Deno.test("probe report is marked probe and is not a soundness argument", () => {
  const prefix = "import Lean\n\n";
  const block = DECLARATION + "\n  match a, b with\n  | x, y => exact x\n\n";
  const suffix = INSTANCE + "\n";
  const report = patchPreludeReport(prefix + block + suffix);
  assertEquals(report.probe, true);
  assertEquals(report.kind, "klean-prelude-compatibility-probe");
  assertEquals(report.patched, prefix + suffix);
  assertStringIncludes(report.removed, DECLARATION);
  assert(!report.removed.includes(INSTANCE));
  assertStringIncludes(report.note, "not a soundness argument");
  assertEquals(report.note, PROBE_NOTE);
});
