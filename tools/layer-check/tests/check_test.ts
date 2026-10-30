// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals, assertStringIncludes } from "./assert.ts";
import {
  associationProblems,
  declarations,
  declaredCodes,
  disagreement,
  judge,
} from "../src/check.ts";
import { classifyKFailure, type Reading } from "../src/kast.ts";
import type { Unit } from "../src/units.ts";

const K_CODES = new Set(["ERR-TOP-001", "ERR-TOP-002", "ERR-TOP-003", "ERR-DLM-001"]);
const ANNEX = new Map([
  ["ERR-TOP-001", "Message 1."],
  ["ERR-TOP-002", "Message 2."],
  ["ERR-TOP-003", "Message 3."],
  ["ERR-DLM-001", "Message D1."],
]);
const unit = (code: string): Unit => ({ file: "f.k7", line: 1, label: "f.k7", code });
/** A reading that emits the given codes, each at line 1 unless a line is given (`CODE@2`). */
const read = (...codes: string[]): Extract<Reading, { kind: "read" }> => ({
  kind: "read",
  refusals: codes.map((c) => {
    const [code, line] = c.split("@");
    return { code, message: ANNEX.get(code) ?? "?", line: Number(line ?? 1) };
  }),
});
const unreadable: Reading = { kind: "unreadable", failure: "parse", detail: "syntax error" };
/** Both readers agree on a text whose delimiters pair. */
const both = (u: Unit, ...codes: string[]) =>
  judge(u, read(...codes), read(...codes), K_CODES, ANNEX);

Deno.test("declared codes accept the French and the English markers", () => {
  assertEquals(declaredCodes("[a (b)] ;; rejeté : ERR-TOP-001"), ["ERR-TOP-001"]);
  assertEquals(declaredCodes("(a {b}) ;; refused: ERR-TOP-003, ERR-PUR-001"), [
    "ERR-PUR-001",
    "ERR-TOP-003",
  ]);
});

Deno.test("a declaration may give the line where a code is expected", () => {
  assertEquals(declarations(";; refused: ERR-DLM-001 at line 2, ERR-TOP-001"), [
    { code: "ERR-DLM-001", line: 2 },
    { code: "ERR-TOP-001" },
  ]);
});

Deno.test("a text without declaration must emit no refusal", () => {
  assertEquals(both(unit("[a]")).ok, true);
  const v = both(unit("[a (b)]"), "ERR-TOP-001");
  assertEquals(v.ok, false);
  assertStringIncludes(v.reason ?? "", "K emits [ERR-TOP-001]");
});

Deno.test("a declared refusal must be emitted, and only it", () => {
  assertEquals(both(unit(";; refused: ERR-TOP-002"), "ERR-TOP-002").ok, true);
  assertEquals(both(unit(";; refused: ERR-TOP-002")).ok, false);
  assertEquals(both(unit(";; refused: ERR-TOP-002"), "ERR-TOP-002", "ERR-TOP-003").ok, false);
});

Deno.test("a declared line must be the line where K emits the code", () => {
  const u = unit(";; refused: ERR-DLM-001 at line 2");
  assertEquals(judge(u, read("ERR-DLM-001@2"), unreadable, K_CODES, ANNEX).ok, true);
  const v = judge(u, read("ERR-DLM-001@3"), unreadable, K_CODES, ANNEX);
  assertEquals(v.ok, false);
  assertStringIncludes(v.reason ?? "", "declared ERR-DLM-001 at line 2, K emits it at lines [3]");
});

Deno.test("a declared code out of K's reach is reported, and the text must emit nothing", () => {
  const v = both(unit(";; rejeté : ERR-PUR-001"));
  assertEquals([v.ok, v.unchecked], [true, ["ERR-PUR-001"]]);
});

Deno.test("a message that differs from annex A fails the association", () => {
  const reading: Reading = {
    kind: "read",
    refusals: [{ code: "ERR-TOP-001", message: "Autre." }],
  };
  const v = judge(unit(";; refused: ERR-TOP-001"), reading, reading, K_CODES, ANNEX);
  assertEquals(v.ok, false);
  assertStringIncludes(v.reason ?? "", "annex A says");
});

Deno.test("a text the balance reader cannot read fails", () => {
  const v = judge(unit('"open'), unreadable, unreadable, K_CODES, ANNEX);
  assertEquals(v.ok, false);
});

Deno.test("the readers must agree on the layer codes of a text whose delimiters pair", () => {
  assertEquals(disagreement(read("ERR-TOP-001").refusals, read("ERR-TOP-001")), undefined);
  assertStringIncludes(
    disagreement(read("ERR-TOP-001", "ERR-TOP-003").refusals, read("ERR-TOP-003", "ERR-TOP-001")) ??
      "",
    "the balance reader emits [ERR-TOP-001, ERR-TOP-003], the tree reader [ERR-TOP-003, ERR-TOP-001]",
  );
  assertStringIncludes(disagreement([], unreadable) ?? "", "the tree reader does not");
  const v = judge(unit(";; refused: ERR-TOP-001"), read("ERR-TOP-001"), read(), K_CODES, ANNEX);
  assertEquals(v.ok, false);
  assertStringIncludes(v.reason ?? "", "readers disagree");
});

Deno.test("delimiters that do not pair must also stop the tree reader", () => {
  const u = unit(";; refused: ERR-DLM-001");
  assertEquals(judge(u, read("ERR-DLM-001"), unreadable, K_CODES, ANNEX).ok, true);
  const v = judge(u, read("ERR-DLM-001"), read(), K_CODES, ANNEX);
  assertEquals(v.ok, false);
  assertStringIncludes(v.reason ?? "", "the tree reader reads the text");
});

Deno.test("repeated refusals are compared with multiplicity, not as a set", () => {
  const once = judge(
    unit(";; refused: ERR-DLM-001, ERR-DLM-001"),
    read("ERR-DLM-001"),
    unreadable,
    K_CODES,
    ANNEX,
  );
  assertEquals(once.ok, false);
  assertStringIncludes(once.reason ?? "", "declared [ERR-DLM-001, ERR-DLM-001]");
  const twice = judge(
    unit(";; refused: ERR-DLM-001, ERR-DLM-001"),
    read("ERR-DLM-001", "ERR-DLM-001"),
    unreadable,
    K_CODES,
    ANNEX,
  );
  assertEquals(twice.ok, true);
});

Deno.test("only a parse failure is accepted as the tree reader expected refusal", () => {
  assertEquals(classifyKFailure("Parse error at line 1"), "parse");
  assertEquals(classifyKFailure("syntax error: unexpected token"), "parse");
  assertEquals(classifyKFailure("Java exception while evaluating rule"), "execution");
  assertEquals(
    disagreement(read("ERR-DLM-001").refusals, {
      kind: "unreadable",
      failure: "execution",
      detail: "Java exception while evaluating rule",
    })?.includes("non-parse reason"),
    true,
  );
});
Deno.test("every code K declares needs an annex row and a text that emits it", () => {
  const v = both(unit(";; refused: ERR-TOP-001"), "ERR-TOP-001");
  const problems = associationProblems(["ERR-TOP-001", "ERR-TOP-004"], ANNEX, [v]);
  assertEquals(problems, [
    "ERR-TOP-004 is declared by K but has no row in annex A",
    "ERR-TOP-004 is declared by K but no checked text emits it",
  ]);
});
