// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Event-to-range routing for the impact classifier.
 *
 * The event routing formerly lived in scripts/ci/ci_impact.sh, which
 * invoked the legacy Python classifier. Since cutover C3 classifierArgs
 * feeds derived_event.ts, the decision entry point; cutover C4 removed
 * the shell wrapper, the Python classifier and this module's former
 * Python-invoking entry point.
 */

import type { CommandResult, GitRunner } from "./changes.ts";

export type { CommandResult, GitRunner };

export type ImpactEnvironment = Record<string, string | undefined>;

export async function classifierArgs(
  env: ImpactEnvironment,
  git: GitRunner,
): Promise<string[]> {
  const eventName = env.EVENT_NAME;
  const ref = env.REF;
  const head = env.HEAD_SHA;

  if (
    eventName === "workflow_dispatch" &&
    ref === "refs/heads/automation/generated-status"
  ) {
    const mainRef = "refs/remotes/origin/main";
    const available = await git([
      "rev-parse",
      "--verify",
      "--quiet",
      mainRef,
    ]);
    if (available.code !== 0) {
      throw new Error("origin/main is not available in the checkout");
    }
    if (!head) {
      throw new Error("HEAD_SHA is required for generated-status dispatch");
    }

    const ancestor = await git([
      "merge-base",
      "--is-ancestor",
      head,
      mainRef,
    ]);
    if (ancestor.code === 0) return ["--force-full"];

    const base = await git(["merge-base", mainRef, head]);
    if (base.code !== 0 || base.stdout.trim() === "") {
      throw new Error(
        "generated-status branch has no merge base with origin/main",
      );
    }
    return ["--base", base.stdout.trim(), "--head", head];
  }

  if (eventName === "workflow_dispatch") return ["--force-full"];

  const base = env.BASE_SHA;
  if (!base || !head) {
    throw new Error(
      "BASE_SHA and HEAD_SHA are required outside workflow_dispatch",
    );
  }
  return ["--base", base, "--head", head];
}
