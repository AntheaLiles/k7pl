// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Lexical probes and the glyphs of the reader.
 *
 * A probe is a `.k7` file of `tests/lexical/` whose comments `;; expect: <Class> …` give, in the
 * order of the text, the class the tree reader must give each atom: `Symbol`, `Train`, `Number`
 * or `String`. `kast --output json` parses the text with the tree reader; its tokens, in document
 * order, carry their sorts.
 *
 * The glyphs that form a train are listed twice: in the table of chapter 1 (`tab:glyphes`) and in
 * the `Train` token of `lexicon/syntax/tokens.k`, which also holds the modifiers of chapter 5.
 * The two lists must agree.
 */

/** Modifiers that join glyphs in a train (chapter 5, `NotationsSpecialisees.lean`). */
export const MODIFIERS: readonly string[] = ["´", "¨"];

const EXPECT = /;;\s*expect:\s*([A-Za-z ]+)/g;

/** The classes a probe expects, in the order of the text. */
export function expectedClasses(text: string): string[] {
  return [...text.matchAll(EXPECT)].flatMap((m) => m[1].trim().split(/\s+/));
}

interface KNode {
  node?: string;
  sort?: { name?: string };
  token?: string;
  args?: KNode[];
  items?: KNode[];
  term?: KNode;
}

export interface Token {
  token: string;
  sort: string;
}

/** The tokens of a KAST JSON document, in document order. */
export function tokensOf(json: unknown): Token[] {
  const found: Token[] = [];
  const visit = (node: KNode | undefined): void => {
    if (node === undefined || typeof node !== "object") return;
    if (node.node === "KToken" && node.token !== undefined && node.sort?.name !== undefined) {
      found.push({ token: node.token, sort: node.sort.name });
      return;
    }
    if (node.term) visit(node.term);
    for (const child of node.args ?? []) visit(child);
    for (const child of node.items ?? []) visit(child);
  };
  visit(json as KNode);
  return found;
}

/** Why the tokens do not have the expected classes, or undefined when they do. */
export function lexicalProblem(expected: string[], tokens: Token[]): string | undefined {
  if (expected.length === 0) return "the probe expects nothing";
  if (expected.length !== tokens.length) {
    return `expects ${expected.length} atom(s), K reads ${tokens.length}`;
  }
  const wrong = tokens
    .map((t, i) => ({ ...t, expected: expected[i] }))
    .filter((t) => t.sort !== t.expected)
    .map((t) => `${t.token} is ${t.sort}, expected ${t.expected}`);
  return wrong.length === 0 ? undefined : wrong.join("; ");
}

/** Parses a text with `kast` and returns its tokens, or the reason it could not be read. */
export async function kastTokens(
  kast: string,
  definition: string,
  path: string,
): Promise<{ tokens: Token[] } | { detail: string }> {
  const output = await new Deno.Command(kast, {
    args: ["--definition", definition, "--output", "json", path],
    stdout: "piped",
    stderr: "piped",
  }).output();
  if (output.code !== 0) {
    const detail = new TextDecoder().decode(output.stderr).split("\n")
      .filter((l) => l.trim() !== "" && !l.includes("JAVA_TOOL")).slice(0, 3).join(" | ");
    return { detail: detail || `kast exited with status ${output.code}` };
  }
  return { tokens: tokensOf(JSON.parse(new TextDecoder().decode(output.stdout))) };
}

/** The glyphs of `tab:glyphes`: first cells written as a code span. */
export function tableGlyphs(source: string): string[] {
  return [...source.matchAll(/^\* \* `([^`]+)`\s*$/gm)].map((m) => m[1]);
}

/** The glyphs and modifiers of the `Train` token of `tokens.k`. */
export function readerGlyphs(kSource: string): string[] {
  const m = /syntax\s+Train\s*::=\s*r"\((.*?)\)\+"/.exec(kSource);
  if (!m) return [];
  return m[1].split("|").map((g) => g.replace(/^\\+/, ""));
}

/** Differences between the table of chapter 1, with the modifiers, and the reader. */
export function glyphProblems(table: string[], reader: string[]): string[] {
  const expected = new Set([...table, ...MODIFIERS]);
  const actual = new Set(reader);
  const problems: string[] = [];
  if (table.length === 0) problems.push("no glyph found in tab:glyphes");
  if (reader.length === 0) problems.push("no Train token found in tokens.k");
  for (const g of expected) {
    if (!actual.has(g)) problems.push(`${g} is a glyph or modifier the reader does not know`);
  }
  for (const g of actual) {
    if (!expected.has(g)) problems.push(`${g} is read as a glyph but is not in tab:glyphes`);
  }
  return problems;
}
