// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * The changed paths of a commit range, and the human-readable report
 * of a classification. Shared by the impact job's decision entry
 * point (derived_event.ts) and the `classify` command (main.ts).
 *
 * Until cutover C4 this lived in classify.ts beside the legacy
 * classifier, a faithful port of scripts/ci/impact.py; C4 removed
 * both classifiers' legacy rule tables, and the registry-derived
 * classifier (derived.ts) is the only one.
 */

/** The eight keys every report prints, in the order the workflows read them. */
export const REPORT_KEYS = [
  "full",
  "docs_links",
  "spec_check",
  "spec_build",
  "lean_build",
  "python_tests",
  "tracking_views",
  "unclassified",
] as const;

export type ReportKey = (typeof REPORT_KEYS)[number];

export type ReportedClassification =
  & { [K in ReportKey]: boolean }
  & { unknown_paths: string[] };

export interface CommandResult {
  code: number;
  stdout: string;
  stderr: string;
}

export type GitRunner = (args: string[]) => Promise<CommandResult>;

/** Run git in the current directory, or in `cwd`. */
export function gitRunner(cwd?: string): GitRunner {
  return async (args: string[]) => {
    const command = new Deno.Command("git", {
      args,
      cwd,
      stdout: "piped",
      stderr: "piped",
    });
    const result = await command.output();
    return {
      code: result.code,
      stdout: new TextDecoder().decode(result.stdout),
      stderr: new TextDecoder().decode(result.stderr),
    };
  };
}

/**
 * Paths that differ between two commits. Rename detection is off, so
 * a renamed file is seen as a deletion and an addition: a file moved
 * away from a path that forces validation still forces it. A failed
 * diff is an error, never an empty list.
 */
export async function changedPaths(
  base: string,
  head: string,
  git: GitRunner = gitRunner(),
): Promise<string[]> {
  const { code, stdout, stderr } = await git([
    "diff",
    "--name-only",
    "--no-renames",
    base,
    head,
  ]);
  if (code !== 0) {
    throw new Error(
      `impact: git diff ${base} ${head} failed with exit status ${code}: ${stderr.trim()}`,
    );
  }
  return stdout.split("\n").filter((line) => line !== "");
}

/**
 * A path quoted as Python's repr() quotes it (single quotes), the form
 * the impact log has always used. Every path line is also indented,
 * so a path such as `::warning::x` is never read by the runner as a
 * workflow command.
 */
export function quotePath(path: string): string {
  return `'${path.replace(/\\/g, "\\\\").replace(/'/g, "\\'")}'`;
}

/** The human-readable report of a classification. */
export function formatClassification(
  paths: readonly string[],
  result: ReportedClassification,
): string {
  const lines: string[] = [];
  lines.push(`Changed paths: ${paths.length}`);
  for (const path of paths) lines.push(`  ${quotePath(path)}`);
  const parts = REPORT_KEYS.map((key) =>
    `${key}=${String(result[key]).toLowerCase()}`
  );
  lines.push(`Impact: ${parts.join(" ")}`);
  if (result.unknown_paths.length > 0) {
    lines.push("Unclassified paths:");
    for (const path of result.unknown_paths) {
      lines.push(`  ${quotePath(path)}`);
    }
  }
  return lines.join("\n");
}
