// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Verdicts on the units, from what K emits for each of them.
 *
 * A unit may declare that it must be refused, with a comment such as `; rejeté : ERR-TOP-001`
 * (the form chapter 5 uses) or `; refused: ERR-TOP-001` (test files). Of the declared codes,
 * those that the K definition can emit must be exactly the codes it emits; a declared code
 * out of its reach (a typing error, say) is reported as not checked here, and the unit must
 * then emit no refusal. A unit that declares nothing must emit no refusal.
 *
 * Association: every refusal that K emits must carry the code and the message of a row of
 * annex A, word for word, and every code that K declares must have such a row and be emitted
 * by at least one unit.
 */

import type { Reading, Refusal } from "./kast.ts";
import type { Unit } from "./units.ts";

const DECLARED = /(?:rejet[ée]*|refused)\s*:\s*((?:ERR-[A-Z]+-\d+[\s,]*)+)/giu;

export function declaredCodes(code: string): string[] {
  const declared = new Set<string>();
  for (const m of code.matchAll(DECLARED)) {
    for (const c of m[1].match(/ERR-[A-Z]+-\d+/g) ?? []) declared.add(c);
  }
  return [...declared].sort();
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

export function judge(
  unit: Unit,
  reading: Reading,
  kCodes: ReadonlySet<string>,
  annex: ReadonlyMap<string, string>,
): Verdict {
  if (reading.kind === "unreadable") {
    return {
      unit,
      ok: false,
      refusals: [],
      unchecked: [],
      reason: `not readable: ${reading.detail}`,
    };
  }
  const declared = declaredCodes(unit.code);
  const checkable = declared.filter((c) => kCodes.has(c));
  const unchecked = declared.filter((c) => !kCodes.has(c));
  const emitted = reading.refusals.map((r) => r.code);
  const verdict: Verdict = { unit, ok: true, refusals: reading.refusals, unchecked };
  if (!sameSet(emitted, checkable)) {
    verdict.ok = false;
    verdict.reason = `declared [${checkable.join(", ")}], K emits [${emitted.join(", ")}]`;
    return verdict;
  }
  for (const r of reading.refusals) {
    const row = annex.get(r.code);
    if (row === undefined) {
      verdict.ok = false;
      verdict.reason = `${r.code} has no row in annex A`;
      return verdict;
    }
    if (row !== r.message) {
      verdict.ok = false;
      verdict.reason = `${r.code}: K emits "${r.message}", annex A says "${row}"`;
      return verdict;
    }
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
  const codes = v.refusals.length === 0 ? "" : ` [${v.refusals.map((r) => r.code).join(", ")}]`;
  const unchecked = v.unchecked.length === 0
    ? ""
    : ` (declared, not checked here: ${v.unchecked.join(", ")})`;
  return v.ok ? `PASS ${where}${codes}${unchecked}` : `FAIL ${where}: ${v.reason}`;
}
