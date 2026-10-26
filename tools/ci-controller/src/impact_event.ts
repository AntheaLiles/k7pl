// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Event-to-argument adapter for the impact classifier.
 *
 * The event routing formerly lived in scripts/ci/ci_impact.sh. The Python
 * classifier remains the gating reference until the Deno/Python parity gate
 * has passed its historical-range criteria; this adapter changes only the
 * shell orchestration, not classification semantics.
 */

export type ImpactEnvironment = Record<string, string | undefined>;

export interface CommandResult {
  code: number;
  stdout: string;
  stderr: string;
}

export type GitRunner = (args: string[]) => Promise<CommandResult>;

export async function classifierArgs(
  env: ImpactEnvironment,
  git: GitRunner,
): Promise<string[]> {
  const eventName = env.EVENT_NAME;
  const ref = env.REF;
  const head = env.HEAD_SHA;

  if (eventName === "workflow_dispatch" && ref === "refs/heads/automation/generated-status") {
    const mainRef = "refs/remotes/origin/main";
    const available = await git(["rev-parse", "--verify", "--quiet", mainRef]);
    if (available.code !== 0) {
      throw new Error("origin/main is not available in the checkout");
    }
    if (!head) throw new Error("HEAD_SHA is required for generated-status dispatch");

    const ancestor = await git(["merge-base", "--is-ancestor", head, mainRef]);
    if (ancestor.code === 0) return ["--force-full"];

    const base = await git(["merge-base", mainRef, head]);
    if (base.code !== 0 || base.stdout.trim() === "") {
      throw new Error("generated-status branch has no merge base with origin/main");
    }
    return ["--base", base.stdout.trim(), "--head", head];
  }

  if (eventName === "workflow_dispatch") return ["--force-full"];

  const base = env.BASE_SHA;
  if (!base || !head) {
    throw new Error("BASE_SHA and HEAD_SHA are required outside workflow_dispatch");
  }
  return ["--base", base, "--head", head];
}

async function runGit(args: string[]): Promise<CommandResult> {
  const command = new Deno.Command("git", {
    args,
    stdout: "piped",
    stderr: "piped",
  });
  const result = await command.output();
  return {
    code: result.code,
    stdout: new TextDecoder().decode(result.stdout),
    stderr: new TextDecoder().decode(result.stderr),
  };
}

if (import.meta.main) {
  try {
    const args = await classifierArgs(
      {
        EVENT_NAME: Deno.env.get("EVENT_NAME"),
        REF: Deno.env.get("REF"),
        BASE_SHA: Deno.env.get("BASE_SHA"),
        HEAD_SHA: Deno.env.get("HEAD_SHA"),
      },
      runGit,
    );
    const child = new Deno.Command("python3", {
      args: ["scripts/ci/impact.py", ...args],
      stdin: "inherit",
      stdout: "inherit",
      stderr: "inherit",
    }).spawn();
    const result = await child.status;
    Deno.exit(result.code);
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
