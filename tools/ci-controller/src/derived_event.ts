// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Decision entry point for the impact job (cutover C3).
 *
 * Runs the derived classifier with the event routing of
 * impact_event.ts (the former scripts/ci/ci_impact.sh): a
 * workflow_dispatch on automation/generated-status classifies against
 * origin/main, a head already on main gets the full validation, any
 * other manual dispatch is full, and pull_request and push use
 * BASE_SHA..HEAD_SHA. Writes all thirteen decision surfaces to
 * GITHUB_OUTPUT, and nothing at all when the classification fails.
 * Since cutover C4 it is the only classifier the CI runs.
 *
 * Run from the repository root. Deno permissions: read the
 * registry, run git for the range, read the event env, write
 * GITHUB_OUTPUT.
 */

import {
  changedPaths,
  formatClassification,
  type GitRunner,
  gitRunner,
} from "./changes.ts";
import { deriveClassification, derivedDecisionOutputLines } from "./derived.ts";
import { classifierArgs, type ImpactEnvironment } from "./impact_event.ts";
import { loadRegistryFile } from "./registry.ts";
import { writeGithubOutput } from "./output.ts";

export const DEFAULT_REGISTRY = ".github/ci/components.yaml";

export interface ImpactDependencies {
  git: GitRunner;
  registryPath: string;
  log: (line: string) => void;
  error: (line: string) => void;
  writeOutput: (lines: string[]) => void;
}

/**
 * Classify the event's range and emit the decision. Returns the exit
 * status; the outputs are written only after a complete
 * classification, so a failed diff leaves the job with no surface.
 */
export async function runImpact(
  env: ImpactEnvironment,
  deps: ImpactDependencies,
): Promise<number> {
  try {
    const args = await classifierArgs(env, deps.git);
    const forceFull = args[0] === "--force-full";
    const paths = forceFull
      ? []
      : await changedPaths(args[1], args[3], deps.git);
    const registry = loadRegistryFile(deps.registryPath);
    const derived = deriveClassification(registry, paths, forceFull);
    deps.log(formatClassification(paths, derived));
    deps.log(
      `Derived surfaces: ${
        Object.entries(derived.surfaces).map(([k, v]) => `${k}=${v}`).join(" ")
      } unclassified=${derived.unclassified}`,
    );
    deps.writeOutput(derivedDecisionOutputLines(derived));
    return 0;
  } catch (error) {
    deps.error(error instanceof Error ? error.message : String(error));
    return 1;
  }
}

/** The process environment and dependencies of the impact job. */
export function runImpactFromProcess(): Promise<number> {
  return runImpact(
    {
      EVENT_NAME: Deno.env.get("EVENT_NAME"),
      REF: Deno.env.get("REF"),
      BASE_SHA: Deno.env.get("BASE_SHA"),
      HEAD_SHA: Deno.env.get("HEAD_SHA"),
    },
    {
      git: gitRunner(),
      registryPath: DEFAULT_REGISTRY,
      log: (line) => console.log(line),
      error: (line) => console.error(line),
      writeOutput: writeGithubOutput,
    },
  );
}

if (import.meta.main) {
  Deno.exit(await runImpactFromProcess());
}
