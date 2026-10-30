// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals } from "./assert.ts";
import { collectUnits, listingUnits } from "../src/units.ts";

const SOURCE = [
  "Texte.",
  "",
  '::::listing (label := "lst:exemple")',
  ":::caption",
  "Légende",
  ":::",
  "",
  "```",
  "[f [g x]]",
  "```",
  "::::",
  "",
  "```",
  "(hors listing)",
  "```",
  "",
  '::::listing (label := "lst:k")',
  '```K (file := "lexicon/syntax/layers.k")',
  "```",
  "::::",
].join("\n");

Deno.test("a listing code block without language is a unit, with its label and first line", () => {
  const units = listingUnits("spec/X.lean", SOURCE);
  assertEquals(units.map((u) => [u.label, u.line, u.code]), [["lst:exemple", 9, "[f [g x]]"]]);
});

Deno.test("malformed listings and fenced blocks fail closed", () => {
  let missingFence = false;
  try {
    listingUnits("spec/X.lean", '::::listing (label := "lst:broken")\n```\n[open]');
  } catch (error) {
    missingFence = error instanceof Error && error.message.includes("unterminated fenced code block");
  }
  assertEquals(missingFence, true);

  let missingDirective = false;
  try {
    listingUnits("spec/X.lean", '::::listing (label := "lst:broken")\n```\n[ok]\n```');
  } catch (error) {
    missingDirective = error instanceof Error && error.message.includes("unterminated listing directive");
  }
  assertEquals(missingDirective, true);

  let nestedDirective = false;
  try {
    listingUnits("spec/X.lean", '::::listing (label := "outer")\n::::listing (label := "inner")');
  } catch (error) {
    nestedDirective = error instanceof Error && error.message.includes("nested listing directive");
  }
  assertEquals(nestedDirective, true);
});

Deno.test("the real Verso corpus keeps its listing inventory discoverable", async () => {
  const root = await Deno.realPath(new URL("../../../", import.meta.url));
  const units = await collectUnits(root);
  const listings = units.filter((unit) => unit.file.startsWith("spec/"));
  const required = ["lst:fonction-pure", "lst:gestionnaire", "lst:acteur"];
  const labels = new Set(listings.map((unit) => unit.label));
  assertEquals(required.filter((label) => !labels.has(label)), []);
  assertEquals(listings.length >= required.length, true);

  let sourceDirectives = 0;
  const visit = async (directory: string): Promise<void> => {
    for await (const entry of Deno.readDir(directory)) {
      const path = `${directory}/${entry.name}`;
      if (entry.isDirectory) await visit(path);
      else if (entry.isFile && path.endsWith(".lean")) {
        const source = await Deno.readTextFile(path);
        sourceDirectives += source.split("\n").filter((line) => /^:{3,}listing\b/.test(line)).length;
      }
    }
  };
  await visit(`${root}/spec`);
  assertEquals(listings.length, sourceDirectives);
});

Deno.test("blocks outside listings and blocks with a language are not units", () => {
  const units = listingUnits("spec/X.lean", SOURCE);
  assertEquals(units.length, 1);
});
