// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * K7PL CI controller (slice 1).
 *
 * Commands:
 *   classify --base <sha> --head <sha> [--force-full] [--paths ...]
 *     Classify changed paths into CI surfaces, in parity with
 *     scripts/ci/impact.py. With --shadow, also run the legacy
 *     Python classifier and fail on any divergence.
 *   validate-registry [--registry <path>] [--root <dir>]
 *     Load and validate .github/ci/components.yaml.
 *   validate-evidence --evidence <file> [--registry <path>]
 *     Validate one evidence record against the schema and the
 *     registry.
 *
 * Run from the repository root. Deno permissions are per command
 * (see README.md); this file never requests more than it needs.
 */

import {
  changedPaths,
  classify,
  formatClassification,
  githubOutputLines,
} from "./classify.ts";
import { validateEvidence, validateEvidenceSchema } from "./evidence.ts";
import { loadRegistryFile, validateRegistry } from "./registry.ts";
import { runShadow } from "./shadow.ts";

const DEFAULT_REGISTRY = ".github/ci/components.yaml";

function usage(): string {
  return [
    "Usage:",
    "  deno run --allow-read --allow-run --allow-env --allow-write src/main.ts classify --base <sha> --head <sha> [--force-full] [--shadow]",
    "  deno run --allow-read --allow-run --allow-env --allow-write src/main.ts classify --paths <path...> [--force-full]",
    "  deno run --allow-read src/main.ts validate-registry [--registry <path>] [--root <dir>]",
    "  deno run --allow-read src/main.ts validate-evidence --evidence <file> [--registry <path>]",
  ].join("\n");
}

interface Args {
  flags: Map<string, string | boolean>;
  positional: string[];
}

function parseArgs(argv: string[]): Args {
  const flags = new Map<string, string | boolean>();
  const positional: string[] = [];
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    if (arg.startsWith("--")) {
      const key = arg.slice(2);
      const eq = key.indexOf("=");
      if (eq >= 0) {
        flags.set(key.slice(0, eq), key.slice(eq + 1));
      } else if (key === "paths") {
        const values: string[] = [];
        while (i + 1 < argv.length && !argv[i + 1].startsWith("--")) {
          values.push(argv[++i]);
        }
        flags.set("paths", values.join("\n"));
      } else if (["force-full", "shadow", "help"].includes(key)) {
        flags.set(key, true);
      } else if (i + 1 < argv.length) {
        flags.set(key, argv[++i]);
      } else {
        flags.set(key, true);
      }
    } else {
      positional.push(arg);
    }
  }
  return { flags, positional };
}

function writeGithubOutput(lines: string[]): void {
  const output = Deno.env.get("GITHUB_OUTPUT");
  if (!output) return;
  Deno.writeTextFileSync(output, lines.map((line) => `${line}\n`).join(""), {
    append: true,
  });
}

async function runClassify(args: Args): Promise<number> {
  const forceFull = args.flags.get("force-full") === true;
  const shadow = args.flags.get("shadow") === true;
  if (shadow) {
    const base = args.flags.get("base");
    const head = args.flags.get("head");
    if (typeof base !== "string" || typeof head !== "string") {
      console.error("classify --shadow requires --base and --head");
      return 2;
    }
    const result = await runShadow(base, head, "scripts/ci/impact.py", ".");
    console.log(formatClassification(result.paths, result.deno));
    // Print the comparison explicitly so a divergence is unambiguous.
    if (result.divergences.length > 0) {
      console.error(
        "shadow: DIVERGENCE between Deno and legacy Python classifiers:",
      );
      for (const divergence of result.divergences) {
        console.error(`  ${divergence}`);
      }
      return 1;
    }
    console.log("shadow: Deno and legacy Python classifiers agree");
    return 0;
  }

  let paths: string[];
  const pathsFlag = args.flags.get("paths");
  if (typeof pathsFlag === "string") {
    paths = pathsFlag === "" ? [] : pathsFlag.split("\n");
  } else {
    const base = args.flags.get("base");
    const head = args.flags.get("head");
    if (forceFull) {
      paths = [];
    } else if (typeof base === "string" && typeof head === "string") {
      paths = await changedPaths(base, head);
    } else {
      console.error(
        "classify requires --base and --head, or --paths, or --force-full",
      );
      return 2;
    }
  }
  const result = classify(paths, forceFull);
  console.log(formatClassification(paths, result));
  writeGithubOutput(githubOutputLines(result));
  return 0;
}

function runValidateRegistry(args: Args): number {
  const registryPath = typeof args.flags.get("registry") === "string"
    ? String(args.flags.get("registry"))
    : DEFAULT_REGISTRY;
  const root = typeof args.flags.get("root") === "string"
    ? String(args.flags.get("root"))
    : ".";
  let registry;
  try {
    registry = loadRegistryFile(registryPath);
  } catch (error) {
    console.error(
      `validate-registry: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
    return 1;
  }
  const errors = validateRegistry(registry, root);
  if (errors.length > 0) {
    for (const error of errors) console.error(`validate-registry: ${error}`);
    return 1;
  }
  console.log(
    `validate-registry: OK (${registry.components.length} components, ${registry.stages.length} stages, ${registry.toolchains.length} toolchains)`,
  );
  return 0;
}

function runValidateEvidence(args: Args): number {
  const evidencePath = args.flags.get("evidence");
  if (typeof evidencePath !== "string") {
    console.error("validate-evidence requires --evidence <file>");
    return 2;
  }
  const registryPath = typeof args.flags.get("registry") === "string"
    ? String(args.flags.get("registry"))
    : DEFAULT_REGISTRY;
  let raw: string;
  try {
    raw = Deno.readTextFileSync(evidencePath);
  } catch {
    console.error(`validate-evidence: cannot read ${evidencePath}`);
    return 1;
  }
  let value: unknown;
  try {
    value = JSON.parse(raw);
  } catch {
    console.error(`validate-evidence: ${evidencePath} is not valid JSON`);
    return 1;
  }
  const schemaErrors = validateEvidenceSchema(value);
  if (schemaErrors.length > 0) {
    for (const error of schemaErrors) {
      console.error(`validate-evidence: ${error}`);
    }
    return 1;
  }
  let registry;
  try {
    registry = loadRegistryFile(registryPath);
  } catch (error) {
    console.error(
      `validate-evidence: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
    return 1;
  }
  const errors = validateEvidence(value, registry);
  if (errors.length > 0) {
    for (const error of errors) console.error(`validate-evidence: ${error}`);
    return 1;
  }
  console.log("validate-evidence: OK");
  return 0;
}

async function main(argv: string[]): Promise<number> {
  const [command, ...rest] = argv;
  const args = parseArgs(rest);
  if (args.flags.get("help") === true || command === undefined) {
    console.log(usage());
    return command === undefined ? 2 : 0;
  }
  try {
    switch (command) {
      case "classify":
        return await runClassify(args);
      case "validate-registry":
        return runValidateRegistry(args);
      case "validate-evidence":
        return runValidateEvidence(args);
      default:
        console.error(`unknown command: ${command}\n${usage()}`);
        return 2;
    }
  } catch (error) {
    console.error(
      `ci-controller: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
    return 1;
  }
}

if (import.meta.main) {
  Deno.exit(await main(Deno.args));
}
