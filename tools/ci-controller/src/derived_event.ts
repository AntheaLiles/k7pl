// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Decision entry point for the impact job (cutover C3).
 *
 * Runs the derived classifier with the exact event routing of
 * scripts/ci/ci_impact.sh (via classifierArgs, shared with
 * impact_event.ts): a workflow_dispatch on automation/generated-status
 * classifies against origin/main, a head already on main gets the
 * full validation, any other manual dispatch is full, and
 * pull_request and push use BASE_SHA..HEAD_SHA. Writes all
 * thirteen decision surfaces to GITHUB_OUTPUT. The legacy Python
 * classifier no longer decides anything; it runs only in reversed
 * shadow (controller-shadow, non-blocking).
 *
 * Run from the repository root. Deno permissions: read the
 * registry, run git for the range, read the event env, write
 * GITHUB_OUTPUT.
 */

import { changedPaths, formatClassification } from "./classify.ts";
import { deriveClassification, derivedDecisionOutputLines } from "./derived.ts";
import { classifierArgs } from "./impact_event.ts";
import { loadRegistryFile } from "./registry.ts";
import { writeGithubOutput } from "./output.ts";

const DEFAULT_REGISTRY = ".github/ci/components.yaml";

async function runGit(args: string[]): Promise<{
  code: number;
  stdout: string;
  stderr: string;
}> {
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
    const forceFull = args[0] === "--force-full";
    const paths = forceFull ? [] : await changedPaths(args[1], args[3]);
    const registry = loadRegistryFile(DEFAULT_REGISTRY);
    const derived = deriveClassification(registry, paths, forceFull);
    console.log(formatClassification(paths, derived));
    console.log(
      `Derived surfaces: ${
        Object.entries(derived.surfaces).map(([k, v]) => `${k}=${v}`).join(" ")
      } unclassified=${derived.unclassified}`,
    );
    if (derived.unknown_paths.length > 0) {
      console.log("Derived unclassified paths:");
      for (const path of derived.unknown_paths) console.log(`  '${path}'`);
    }
    writeGithubOutput(derivedDecisionOutputLines(derived));
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
