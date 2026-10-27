// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Checks the K7PL texts of the repository with the two readers of `lexicon/syntax/`: the
 * tree reader (grammar of the layers) and the balance reader (delimiters that do not pair).
 *
 *   deno run --allow-read --allow-write --allow-run tools/layer-check/src/main.ts check \
 *     --definition src/k/.build/layers-kompiled --balance src/k/.build/balance-kompiled \
 *     [--krun krun] [--kast kast] [--root .]
 *
 * It also checks the lexical probes of `tests/lexical/` with `kast`, and the glyphs of the reader
 * against the table of chapter 1.
 *
 * Run from the repository root, after `make -C src/k layers-kompile balance-kompile`. Exit
 * status 1 when a text, the agreement of the readers or the association between K and annex A
 * fails.
 */

import { annexRows, declaredKCodes } from "./annex.ts";
import { associationProblems, formatVerdict, judge, type Verdict } from "./check.ts";
import { readWithK } from "./kast.ts";
import {
  expectedClasses,
  glyphProblems,
  kastTokens,
  lexicalProblem,
  readerGlyphs,
  tableGlyphs,
} from "./lexical.ts";
import { collectUnits } from "./units.ts";

export const CODES_SOURCE = "lexicon/syntax/codes.k";
export const ANNEX_DIR = "spec/Spec/AnnexeA";
export const TOKENS_SOURCE = "lexicon/syntax/tokens.k";
export const GLYPH_TABLE = "spec/Spec/C1/TableDesGlyphes.lean";
export const LEXICAL_PROBES = "tests/lexical";

/** Runs the lexical probes; returns the number of failures. */
async function lexicalProbes(root: string, kast: string, definition: string): Promise<number> {
  let failed = 0;
  const probes: string[] = [];
  for await (const entry of Deno.readDir(`${root}/${LEXICAL_PROBES}`)) {
    if (entry.isFile && entry.name.endsWith(".k7")) probes.push(`${LEXICAL_PROBES}/${entry.name}`);
  }
  probes.sort();
  for (const probe of probes) {
    const reading = await kastTokens(kast, definition, `${root}/${probe}`);
    const problem = "detail" in reading ? `not readable: ${reading.detail}` : lexicalProblem(
      expectedClasses(await Deno.readTextFile(`${root}/${probe}`)),
      reading.tokens,
    );
    if (problem === undefined) {
      console.log(`PASS lexical ${probe}`);
    } else {
      failed++;
      console.log(`FAIL lexical ${probe}: ${problem}`);
    }
  }
  if (probes.length === 0) {
    failed++;
    console.log(`FAIL lexical: no probe in ${LEXICAL_PROBES}`);
  }
  return failed;
}

function option(args: string[], name: string, fallback?: string): string {
  const i = args.indexOf(name);
  const value = i >= 0 ? args[i + 1] : fallback;
  if (value === undefined) throw new Error(`missing ${name}`);
  return value;
}

export async function check(args: string[]): Promise<number> {
  const root = option(args, "--root", ".");
  const definition = option(args, "--definition");
  const balance = option(args, "--balance");
  const krun = option(args, "--krun", "krun");
  const kast = option(args, "--kast", "kast");

  const kCodes = declaredKCodes(await Deno.readTextFile(`${root}/${CODES_SOURCE}`));
  const annexSources: string[] = [];
  for await (const entry of Deno.readDir(`${root}/${ANNEX_DIR}`)) {
    if (entry.isFile && entry.name.endsWith(".lean")) {
      annexSources.push(await Deno.readTextFile(`${root}/${ANNEX_DIR}/${entry.name}`));
    }
  }
  const annex = annexRows(annexSources);
  const units = await collectUnits(root);
  const scratch = await Deno.makeTempDir({ prefix: "layer-check-" });
  const verdicts: Verdict[] = [];
  try {
    for (const [i, unit] of units.entries()) {
      const path = `${scratch}/unit-${i}.k7`;
      await Deno.writeTextFile(path, unit.code.endsWith("\n") ? unit.code : `${unit.code}\n`);
      const verdict = judge(
        unit,
        await readWithK(krun, balance, path),
        await readWithK(krun, definition, path),
        new Set(kCodes),
        annex,
      );
      verdicts.push(verdict);
      console.log(formatVerdict(verdict));
    }
  } finally {
    await Deno.remove(scratch, { recursive: true });
  }
  const problems = associationProblems(kCodes, annex, verdicts);
  for (const p of problems) console.log(`FAIL association: ${p}`);
  const glyphs = glyphProblems(
    tableGlyphs(await Deno.readTextFile(`${root}/${GLYPH_TABLE}`)),
    readerGlyphs(await Deno.readTextFile(`${root}/${TOKENS_SOURCE}`)),
  );
  for (const p of glyphs) console.log(`FAIL glyphs: ${p}`);
  if (glyphs.length === 0) {
    console.log("PASS glyphs: tab:glyphes and the modifiers equal the reader's");
  }
  const lexical = await lexicalProbes(root, kast, definition);
  const failed = verdicts.filter((v) => !v.ok).length + problems.length + glyphs.length + lexical;
  console.log(
    `${verdicts.length} text(s), ${kCodes.length} code(s) declared by K, ${failed} failure(s)`,
  );
  return failed === 0 ? 0 : 1;
}

if (import.meta.main) {
  const [command, ...rest] = Deno.args;
  if (command !== "check") {
    console.error(
      "usage: main.ts check --definition <kompiled> --balance <kompiled> [--krun <krun>] [--kast <kast>] [--root <dir>]",
    );
    Deno.exit(2);
  }
  Deno.exit(await check(rest));
}
