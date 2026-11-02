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

Deno.test("the balance reader gives the delimiter at fault and its line", () => {
  // krun output of the balance reader for "[a (b\n c]\n)".
  const refusals = refusalsOf(fixture("located.json"));
  assertEquals(
    refusals.map((r) => [r.code, r.line, r.site]),
    [
      ["ERR-TOP-001", 1, "`(` line 1"],
      ["ERR-DLM-001", 1, "`(` line 1"],
      ["ERR-DLM-002", 3, "`)` line 3"],
    ],
  );
  assertStringIncludes(refusals[1].message, "Délimiteur ouvrant jamais refermé");
});

Deno.test("a closing delimiter of another pair names the open delimiter it meets", () => {
  // krun output of the balance reader for "[a b)".
  const refusals = refusalsOf(fixture("meets.json"));
  assertEquals(
    refusals.map((r) => [r.code, r.line, r.site]),
    [
      ["ERR-DLM-003", 1, "`)` line 1 meets `[` opened line 1"],
      ["ERR-DLM-001", 1, "`[` line 1"],
    ],
  );
});

Deno.test("a string never closed is reported at its opening quote", () => {
  // krun output of the balance reader for "(f \"a\nb\n".
  const refusals = refusalsOf(fixture("open-string.json"));
  assertEquals(
    refusals.map((r) => [r.code, r.line, r.site]),
    [
      ["ERR-DLM-004", 1, '`"` line 1'],
      ["ERR-DLM-001", 1, "`(` line 1"],
    ],
  );
});

Deno.test("a well layered text leaves no refusal", () => {
  assertEquals(refusalsOf(fixture("accepted.json")), []);
});

Deno.test("a malformed refusal or site is an error, not a silent pass", () => {
  const throws = (json: unknown) => {
    try {
      refusalsOf(json);
    } catch {
      return true;
    }
    return false;
  };
  assertEquals(throws({ node: "KApply", label: { name: "refusal" }, args: [] }), true);
  const located = refusalsOf(fixture("located.json"));
  assertEquals(located.length, 3);
  assertEquals(throws({ node: "KApply", label: { name: "located" }, args: [] }), true);
});
