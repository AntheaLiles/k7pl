// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals } from "./assert.ts";
import { listingUnits } from "../src/units.ts";

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

Deno.test("blocks outside listings and blocks with a language are not units", () => {
  const units = listingUnits("spec/X.lean", SOURCE);
  assertEquals(units.length, 1);
});
