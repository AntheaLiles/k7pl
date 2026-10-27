// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Shadow mode: run the legacy Python classifier and the Deno
 * classifier on the same changed-path range, compare their
 * surfaces and unknown paths, and fail on any divergence.
 *
 * Shadow mode is diagnostic only: since slice 3 it is wired into
 * ci.yaml as the controller-shadow job, which is NOT in the
 * ci-ok aggregator's needs and runs with continue-on-error.
 * Promoting it to a gate is a separate, owner-reviewed step
 * (see README.md, cutover criteria). The Python run writes its
 * GITHUB_OUTPUT to a temporary file so it never clobbers the
 * runner's output file.
 */

import { type Classification, classify, SURFACE_KEYS } from "./classify.ts";

export interface ShadowResult {
  paths: string[];
  deno: Classification;
  python: Classification;
  divergences: string[];
}

function parsePythonOutput(text: string): Record<string, string> {
  const out: Record<string, string> = {};
  for (const line of text.split("\n")) {
    const match = /^([a-z_]+)=(true|false)$/.exec(line.trim());
    if (match) out[match[1]] = match[2];
  }
  return out;
}

export async function runShadow(
  base: string,
  head: string,
  pythonScript: string,
  repoRoot: string,
): Promise<ShadowResult> {
  const tmpDir = await Deno.makeTempDir({ prefix: "ci-shadow-" });
  try {
    const pythonOutput = `${tmpDir}/github_output`;
    const env = { ...Deno.env.toObject(), GITHUB_OUTPUT: pythonOutput };
    const command = new Deno.Command("python3", {
      args: [pythonScript, "--base", base, "--head", head],
      stdout: "piped",
      stderr: "piped",
      env,
      cwd: repoRoot,
    });
    const { code, stdout, stderr } = await command.output();
    if (code !== 0) {
      const detail = new TextDecoder().decode(stderr).trim();
      throw new Error(
        `shadow: legacy classifier failed with exit status ${code}: ${detail}`,
      );
    }
    const stdoutText = new TextDecoder().decode(stdout);
    const parsed = parsePythonOutput(await Deno.readTextFile(pythonOutput));
    const pythonUnknown: string[] = [];
    let inUnknown = false;
    for (const line of stdoutText.split("\n")) {
      if (line === "Unclassified paths:") {
        inUnknown = true;
        continue;
      }
      if (inUnknown) {
        const match = /^ {2}'(.*)'$/.exec(line);
        if (match) {
          pythonUnknown.push(
            match[1].replace(/\\'/g, "'").replace(/\\\\/g, "\\"),
          );
        }
      }
    }
    const python: Classification = {
      full: parsed["full"] === "true",
      docs_links: parsed["docs_links"] === "true",
      spec_check: parsed["spec_check"] === "true",
      spec_build: parsed["spec_build"] === "true",
      lean_build: parsed["lean_build"] === "true",
      python_tests: parsed["python_tests"] === "true",
      tracking_views: parsed["tracking_views"] === "true",
      unclassified: parsed["unclassified"] === "true",
      unknown_paths: pythonUnknown,
    };

    // Deno classification on the same range, via git directly.
    const git = new Deno.Command("git", {
      args: ["diff", "--name-only", "--no-renames", base, head],
      stdout: "piped",
      stderr: "piped",
      cwd: repoRoot,
    });
    const gitOut = await git.output();
    if (gitOut.code !== 0) {
      throw new Error(`shadow: git diff ${base} ${head} failed`);
    }
    const paths = new TextDecoder().decode(gitOut.stdout).split("\n").filter((
      line,
    ) => line !== "");
    const deno = classify(paths);

    const divergences: string[] = [];
    for (const key of SURFACE_KEYS) {
      if (deno[key] !== python[key]) {
        divergences.push(`${key}: deno=${deno[key]} python=${python[key]}`);
      }
    }
    if (
      JSON.stringify(deno.unknown_paths) !==
        JSON.stringify(python.unknown_paths)
    ) {
      divergences.push(
        `unknown_paths: deno=${JSON.stringify(deno.unknown_paths)} python=${
          JSON.stringify(python.unknown_paths)
        }`,
      );
    }
    return { paths, deno, python, divergences };
  } finally {
    await Deno.remove(tmpDir, { recursive: true }).catch(() => {});
  }
}
