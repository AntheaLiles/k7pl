// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals, assertStringIncludes } from "./assert.ts";
import {
  expectedClasses,
  glyphProblems,
  lexicalProblem,
  MODIFIERS,
  readerGlyphs,
  tableGlyphs,
  tokensOf,
} from "../src/lexical.ts";

const fixture = (name: string) =>
  JSON.parse(Deno.readTextFileSync(new URL(`./fixtures/${name}`, import.meta.url)));

Deno.test("a probe lists the expected classes in the order of the text", () => {
  assertEquals(expectedClasses("[a 1] ;; expect: Symbol Number\n[+] ;; expect: Train"), [
    "Symbol",
    "Number",
    "Train",
  ]);
});

Deno.test("the tokens of a parsed text keep their sorts and their order", () => {
  // kast output of the tree reader for the sample of numbers, trains and symbols.
  const tokens = tokensOf(fixture("classes.json"));
  const classOf = (t: string) => tokens.find((x) => x.token === t)?.sort;
  assertEquals(
    ["42", "1_000_000", "1/3", "3+4i", "nan", "+´÷≠", "<=", "-", "x-1", "0x1F", "infinity"]
      .map(classOf),
    [
      "Number",
      "Number",
      "Number",
      "Number",
      "Number",
      "Train",
      "Train",
      "Train",
      "Symbol",
      "Symbol",
      "Symbol",
    ],
  );
});

Deno.test("a probe fails when a class or the number of atoms differs", () => {
  const tokens = [{ token: "x-1", sort: "Symbol" }, { token: "-", sort: "Train" }];
  assertEquals(lexicalProblem(["Symbol", "Train"], tokens), undefined);
  assertStringIncludes(
    lexicalProblem(["Symbol", "Symbol"], tokens) ?? "",
    "- is Train, expected Symbol",
  );
  assertStringIncludes(lexicalProblem(["Symbol"], tokens) ?? "", "expects 1 atom(s), K reads 2");
  assertEquals(lexicalProblem([], []), "the probe expects nothing");
});

Deno.test("the glyphs of the reader must equal the table of chapter 1 and the modifiers", () => {
  const table = tableGlyphs(
    "* * Glyphe\n  * Point de code\n* * `+`\n  * `U+002B`\n* * `÷`\n  * `U+00F7`\n",
  );
  assertEquals(table, ["+", "÷"]);
  const reader = readerGlyphs('syntax Train ::= r"(\\\\+|÷|´|¨)+" [token, prec(2)]');
  assertEquals(reader, ["+", "÷", "´", "¨"]);
  assertEquals(glyphProblems(table, reader), []);
  assertEquals(glyphProblems(table, ["+", ...MODIFIERS]), [
    "÷ is a glyph or modifier the reader does not know",
  ]);
  assertEquals(glyphProblems(["+"], reader), ["÷ is read as a glyph but is not in tab:glyphes"]);
});
