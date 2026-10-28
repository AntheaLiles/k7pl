// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/** Append lines to the runner's GITHUB_OUTPUT file, if set. */
export function writeGithubOutput(lines: string[]): void {
  const output = Deno.env.get("GITHUB_OUTPUT");
  if (!output) return;
  Deno.writeTextFileSync(output, lines.map((line) => `${line}\n`).join(""), {
    append: true,
  });
}
