// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals, assertStringIncludes } from "./assert.ts";
import { associationProblems, declaredCodes, judge } from "../src/check.ts";
import type { Unit } from "../src/units.ts";

const K_CODES = new Set(["ERR-TOP-001", "ERR-TOP-002", "ERR-TOP-003"]);
const ANNEX = new Map([
  ["ERR-TOP-001", "Message 1."],
  ["ERR-TOP-002", "Message 2."],
  ["ERR-TOP-003", "Message 3."],
]);
const unit = (code: string): Unit => ({ file: "f.k7", line: 1, label: "f.k7", code });
const read = (...codes: string[]) => ({
  kind: "read" as const,
  refusals: codes.map((code) => ({ code, message: ANNEX.get(code) ?? "?" })),
});

Deno.test("declared codes accept the French and the English markers", () => {
  assertEquals(declaredCodes("[a (b)] ; rejeté : ERR-TOP-001"), ["ERR-TOP-001"]);
  assertEquals(declaredCodes("(a {b}) ; refused: ERR-TOP-003, ERR-PUR-001"), [
    "ERR-PUR-001",
    "ERR-TOP-003",
  ]);
});

Deno.test("a text without declaration must emit no refusal", () => {
  assertEquals(judge(unit("[a]"), read(), K_CODES, ANNEX).ok, true);
  const v = judge(unit("[a (b)]"), read("ERR-TOP-001"), K_CODES, ANNEX);
  assertEquals(v.ok, false);
  assertStringIncludes(v.reason ?? "", "K emits [ERR-TOP-001]");
});

Deno.test("a declared refusal must be emitted, and only it", () => {
  assertEquals(judge(unit("; refused: ERR-TOP-002"), read("ERR-TOP-002"), K_CODES, ANNEX).ok, true);
  assertEquals(judge(unit("; refused: ERR-TOP-002"), read(), K_CODES, ANNEX).ok, false);
  assertEquals(
    judge(unit("; refused: ERR-TOP-002"), read("ERR-TOP-002", "ERR-TOP-003"), K_CODES, ANNEX).ok,
    false,
  );
});

Deno.test("a declared code out of K's reach is reported, and the text must emit nothing", () => {
  const v = judge(unit("; rejeté : ERR-PUR-001"), read(), K_CODES, ANNEX);
  assertEquals([v.ok, v.unchecked], [true, ["ERR-PUR-001"]]);
});

Deno.test("a message that differs from annex A fails the association", () => {
  const reading = { kind: "read" as const, refusals: [{ code: "ERR-TOP-001", message: "Autre." }] };
  const v = judge(unit("; refused: ERR-TOP-001"), reading, K_CODES, ANNEX);
  assertEquals(v.ok, false);
  assertStringIncludes(v.reason ?? "", "annex A says");
});

Deno.test("an unreadable text fails", () => {
  const v = judge(unit("[a"), { kind: "unreadable", detail: "syntax error" }, K_CODES, ANNEX);
  assertEquals(v.ok, false);
});

Deno.test("every code K declares needs an annex row and a text that emits it", () => {
  const v = judge(unit("; refused: ERR-TOP-001"), read("ERR-TOP-001"), K_CODES, ANNEX);
  const problems = associationProblems(["ERR-TOP-001", "ERR-TOP-004"], ANNEX, [v]);
  assertEquals(problems, [
    "ERR-TOP-004 is declared by K but has no row in annex A",
    "ERR-TOP-004 is declared by K but no checked text emits it",
  ]);
});
