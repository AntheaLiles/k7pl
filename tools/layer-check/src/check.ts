// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Verdicts on the units, from what the two K readers emit for each of them.
 *
 * A unit may declare that it must be refused, with a comment such as `;; rejeté : ERR-TOP-001`
 * (the form chapter 5 uses) or `;; refused: ERR-TOP-001` (test files); a test may also give the
 * line where a code is expected, `ERR-DLM-001 at line 2`, the first line of the unit being 1. Of
 * the declared codes, those that the K readers can emit must be exactly the codes the balance
 * reader emits; a declared code out of their reach (a typing error, say) is reported as not
 * checked here, and the unit must then emit no refusal. A unit that declares nothing must emit
 * no refusal.
 *
 * Agreement: the balance reader (`balance.k`) reads every text, the tree reader (`refusals.k`)
 * only the texts whose delimiters pair. When the balance reader finds no delimiter fault, the
 * tree reader must read the text and emit the same `ERR-TOP` codes in the same order; when it
 * finds one, the tree reader must fail to read the text.
 *
 * Association: every refusal that K emits must carry the code and the message of a row of
 * annex A, word for word, and every code that K declares must have such a row and be emitted
 * by at least one unit.
 */

import type { Reading, Refusal } from "./kast.ts";
import type { Unit } from "./units.ts";

const DECLARED =
  /(?:rejet[ée]*|refused)\s*:\s*((?:ERR-[A-Z]+-\d+(?:\s+at\s+line\s+\d+)?[\s,]*)+)/giu;
const DECLARED_ITEM = /(ERR-[A-Z]+-\d+)(?:\s+at\s+line\s+(\d+))?/g;

export interface Declaration {
  code: string;
  line?: number;
}

export function declarations(code: string): Declaration[] {
  const found: Declaration[] = [];
  for (const m of code.matchAll(DECLARED)) {
    for (const item of m[1].matchAll(DECLARED_ITEM)) {
      found.push(
        item[2] === undefined ? { code: item[1] } : { code: item[1], line: Number(item[2]) },
      );
    }
  }
  return found;
}

export function declaredCodes(code: string): string[] {
  return [...new Set(declarations(code).map((d) => d.code))].sort();
}

export interface Verdict {
  unit: Unit;
  ok: boolean;
  refusals: Refusal[];
  unchecked: string[];
  reason?: string;
}

const sameSet = (a: string[], b: string[]) =>
  JSON.stringify([...new Set(a)].sort()) === JSON.stringify([...new Set(b)].sort());

const isDelimiterFault = (r: Refusal) => r.code.startsWith("ERR-DLM-");

/** Why the two readers disagree on a text, or undefined when they agree. */
export function disagreement(balance: Refusal[], tree: Reading): string | undefined {
  if (balance.some(isDelimiterFault)) {
    return tree.kind === "read"
      ? "the balance reader finds delimiters that do not pair, the tree reader reads the text"
      : undefined;
  }
  if (tree.kind === "unreadable") {
    return `the balance reader reads the text, the tree reader does not: ${tree.detail}`;
  }
  const fromBalance = balance.map((r) => r.code).join(", ");
  const fromTree = tree.refusals.map((r) => r.code).join(", ");
  return fromBalance === fromTree
    ? undefined
    : `the balance reader emits [${fromBalance}], the tree reader [${fromTree}]`;
}

export function judge(
  unit: Unit,
  balance: Reading,
  tree: Reading,
  kCodes: ReadonlySet<string>,
  annex: ReadonlyMap<string, string>,
): Verdict {
  if (balance.kind === "unreadable") {
    return {
      unit,
      ok: false,
      refusals: [],
      unchecked: [],
      reason: `not readable: ${balance.detail}`,
    };
  }
  const declared = declarations(unit.code);
  const declaredSet = declaredCodes(unit.code);
  const checkable = declaredSet.filter((c) => kCodes.has(c));
  const unchecked = declaredSet.filter((c) => !kCodes.has(c));
  const emitted = balance.refusals.map((r) => r.code);
  const verdict: Verdict = { unit, ok: true, refusals: balance.refusals, unchecked };
  const fail = (reason: string): Verdict => ({ ...verdict, ok: false, reason });
  if (!sameSet(emitted, checkable)) {
    return fail(`declared [${checkable.join(", ")}], K emits [${emitted.join(", ")}]`);
  }
  for (const d of declared) {
    if (d.line === undefined || !kCodes.has(d.code)) continue;
    const lines = balance.refusals.filter((r) => r.code === d.code).map((r) => r.line);
    if (!lines.includes(d.line)) {
      return fail(
        `declared ${d.code} at line ${d.line}, K emits it at lines [${lines.join(", ")}]`,
      );
    }
  }
  const disagree = disagreement(balance.refusals, tree);
  if (disagree !== undefined) return fail(`readers disagree: ${disagree}`);
  for (const r of balance.refusals) {
    const row = annex.get(r.code);
    if (row === undefined) return fail(`${r.code} has no row in annex A`);
    if (row !== r.message) return fail(`${r.code}: K emits "${r.message}", annex A says "${row}"`);
  }
  return verdict;
}

/** Problems of the association between the codes K declares, annex A and the corpus. */
export function associationProblems(
  kCodes: readonly string[],
  annex: ReadonlyMap<string, string>,
  verdicts: readonly Verdict[],
): string[] {
  const problems: string[] = [];
  if (kCodes.length === 0) problems.push("the K definition declares no code");
  const emitted = new Set(verdicts.flatMap((v) => v.refusals.map((r) => r.code)));
  for (const code of kCodes) {
    if (!annex.has(code)) problems.push(`${code} is declared by K but has no row in annex A`);
    if (!emitted.has(code)) problems.push(`${code} is declared by K but no checked text emits it`);
  }
  return problems;
}

export function formatVerdict(v: Verdict): string {
  const where = `${v.unit.file}:${v.unit.line} ${v.unit.label}`;
  const codes = v.refusals.length === 0
    ? ""
    : ` [${v.refusals.map((r) => (r.site ? `${r.code} ${r.site}` : r.code)).join(", ")}]`;
  const unchecked = v.unchecked.length === 0
    ? ""
    : ` (declared, not checked here: ${v.unchecked.join(", ")})`;
  return v.ok ? `PASS ${where}${codes}${unchecked}` : `FAIL ${where}: ${v.reason}`;
}
