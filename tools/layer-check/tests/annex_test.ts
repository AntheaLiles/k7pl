// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals } from "./assert.ts";
import { annexRows, declaredKCodes } from "../src/annex.ts";

Deno.test("annex rows map each code of the first cell to the text of the second", () => {
  const rows = annexRows([
    [
      ":::table +header",
      "* * Code",
      "  * Déclencheur et correction",
      "* * `ERR-TOP-001`",
      "  * Structure de couche 2.",
      "* * `ERR-FFI-001` / `ERR-TYP-008`",
      "  * Fuite.",
    ].join("\n"),
  ]);
  assertEquals([...rows.entries()], [
    ["ERR-TOP-001", "Structure de couche 2."],
    ["ERR-FFI-001", "Fuite."],
    ["ERR-TYP-008", "Fuite."],
  ]);
});

Deno.test("the codes of the K Code sort are read from its declaration", () => {
  const source = 'module M\n  syntax Code ::= "ERR-TOP-001" | "ERR-TOP-002"\n' +
    '                | "ERR-TOP-003"\n  syntax Other ::= "ERR-XXX-009"\nendmodule\n';
  assertEquals(declaredKCodes(source), ["ERR-TOP-001", "ERR-TOP-002", "ERR-TOP-003"]);
});
