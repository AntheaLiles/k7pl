// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals, assertStringIncludes } from "./assert.ts";
import { refusalsOf } from "../src/kast.ts";

const fixture = (name: string) =>
  JSON.parse(Deno.readTextFileSync(new URL(`./fixtures/${name}`, import.meta.url)));

Deno.test("refusals are read in the order of the text, with their codes and messages", () => {
  // krun output for `[ ( { } ) ]`.
  const refusals = refusalsOf(fixture("nested.json"));
  assertEquals(refusals.map((r) => r.code), ["ERR-TOP-001", "ERR-TOP-003"]);
  assertStringIncludes(refusals[1].message, "Structure de couche 1 `{ }` instanciée");
});

Deno.test("a well layered text leaves no refusal", () => {
  assertEquals(refusalsOf(fixture("accepted.json")), []);
});

Deno.test("a malformed refusal term is an error, not a silent pass", () => {
  let failed = false;
  try {
    refusalsOf({ node: "KApply", label: { name: "refusal" }, args: [] });
  } catch {
    failed = true;
  }
  assertEquals(failed, true);
});
