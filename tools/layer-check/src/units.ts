// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Finds the K7PL texts to check: the listings of the Verso specification and the `.k7` files.
 *
 * In a Verso source, a unit is the body of a fenced code block without a language, inside a
 * `listing` directive (`::::listing (label := "...")`, closed by a line of the same colons).
 * Blocks with a language (`K`, `pythonScript`, ...) are not K7PL text, and inline code spans
 * are not read: nothing in their markup says which ones are K7PL.
 */

export interface Unit {
  /** Repository-relative path of the source. */
  file: string;
  /** Line of the first code line in `file`, 1-based. */
  line: number;
  /** Listing label, or the path for a `.k7` file. */
  label: string;
  code: string;
}

/** `.k7` paths that are not K7PL text, with the reason. */
export const EXCLUDED: ReadonlyArray<{ prefix: string; reason: string }> = [
  {
    prefix: "tests/examples/native-boundary/",
    reason: "inputs of the non-normative K7OS native-boundary model, not K7PL text",
  },
];

// `.claude/` holds agent settings and, under `worktrees/`, temporary checkouts of the
// repository, whose texts would be read twice.
const SKIPPED_DIRS = new Set([".git", ".lake", "_out", "node_modules", ".build", ".claude"]);
const FENCE = /^\s*```\s*([^\s`(]*)/;
const FENCE_CLOSE = /^\s*```\s*$/;
const LISTING = /^(:{3,})listing\b(.*)$/;
const LABEL = /label\s*:=\s*"([^"]+)"/;

export function listingUnits(file: string, text: string): Unit[] {
  const lines = text.split("\n");
  const units: Unit[] = [];
  let listing: { colons: string; label: string } | undefined;
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (listing && line.trimEnd() === listing.colons) {
      listing = undefined;
      continue;
    }
    const opening = LISTING.exec(line);
    if (opening) {
      if (listing) {
        throw new Error(
          `${file}:${i + 1}: nested listing directive before ${listing.label} closes`,
        );
      }
      const label = LABEL.exec(opening[2])?.[1] ?? `listing at line ${i + 1}`;
      listing = { colons: opening[1], label };
      continue;
    }
    const fence = FENCE.exec(line);
    if (!fence) continue;
    let close = i + 1;
    while (close < lines.length && !FENCE_CLOSE.test(lines[close])) close++;
    if (close === lines.length) {
      throw new Error(`${file}:${i + 1}: unterminated fenced code block`);
    }
    if (listing && fence[1] === "") {
      units.push({
        file,
        line: i + 2,
        label: listing.label,
        code: lines.slice(i + 1, close).join("\n"),
      });
    }
    i = close;
  }
  if (listing) {
    throw new Error(`${file}: unterminated listing directive ${listing.label}`);
  }
  return units;
}

async function* walk(root: string, dir: string): AsyncGenerator<string> {
  const entries: Deno.DirEntry[] = [];
  for await (const entry of Deno.readDir(`${root}/${dir}`)) entries.push(entry);
  entries.sort((a, b) => a.name < b.name ? -1 : a.name > b.name ? 1 : 0);
  for (const entry of entries) {
    const path = dir === "" ? entry.name : `${dir}/${entry.name}`;
    if (entry.isDirectory) {
      if (!SKIPPED_DIRS.has(entry.name)) yield* walk(root, path);
    } else if (entry.isFile) {
      yield path;
    }
  }
}

/** Every unit of the repository rooted at `root`, in a stable order. */
export async function collectUnits(root: string): Promise<Unit[]> {
  const units: Unit[] = [];
  for await (const path of walk(root, "spec")) {
    if (path.endsWith(".lean")) {
      units.push(...listingUnits(path, await Deno.readTextFile(`${root}/${path}`)));
    }
  }
  for await (const path of walk(root, "")) {
    if (!path.endsWith(".k7")) continue;
    if (EXCLUDED.some((e) => path.startsWith(e.prefix))) continue;
    units.push({
      file: path,
      line: 1,
      label: path,
      code: await Deno.readTextFile(`${root}/${path}`),
    });
  }
  return units;
}
