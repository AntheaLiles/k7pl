// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Reads the code tables of annex A (`spec/Spec/AnnexeA/*.lean`) and the codes that the K
 * definition of the refusals declares.
 *
 * A table row is a line `* * <codes>` followed by a line `  * <trigger and correction>`; a first
 * cell may name several codes (`ERR-FFI-001` / `ERR-TYP-008`).
 */

const CODE = /ERR-[A-Z]+-\d+/g;

/** Code → text of its row, for every row of the given Verso sources. */
export function annexRows(sources: string[]): Map<string, string> {
  const rows = new Map<string, string>();
  for (const source of sources) {
    const lines = source.split("\n");
    for (let i = 0; i + 1 < lines.length; i++) {
      const head = /^\* \* (.*)$/.exec(lines[i]);
      const body = /^ {2}\* (.*)$/.exec(lines[i + 1]);
      if (!head || !body) continue;
      for (const code of head[1].match(CODE) ?? []) rows.set(code, body[1].trim());
    }
  }
  return rows;
}

/** The codes of the `Code` sort of a K source: `syntax Code ::= "ERR-..." | ...`. */
export function declaredKCodes(kSource: string): string[] {
  const declaration = /syntax\s+Code\s*::=([^\n]*(?:\n\s*\|[^\n]*)*)/.exec(kSource);
  if (!declaration) return [];
  return [...declaration[1].matchAll(/"(ERR-[A-Z]+-\d+)"/g)].map((m) => m[1]);
}
