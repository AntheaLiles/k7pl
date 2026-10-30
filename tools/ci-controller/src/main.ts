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
 *     Python classifier and fail on any divergence. With
 *     --derived, classify from the registry instead (the decision
 *     classifier since cutover C3; derived_event.ts is the impact
 *     job's entry point). With --derived-shadow, compare the
 *     derived classifier with the legacy Deno classifier; documented
 *     migration deltas are informational, unexpected deltas exit 1.
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
import {
  deriveClassification,
  derivedDivergences,
  derivedGithubOutputLines,
  isExpectedDerivedDivergence,
} from "./derived.ts";
import { validateEvidence, validateEvidenceSchema } from "./evidence.ts";
import { loadRegistryFile, validateRegistry } from "./registry.ts";
import { runShadow } from "./shadow.ts";
import { writeGithubOutput } from "./output.ts";

const DEFAULT_REGISTRY = ".github/ci/components.yaml";

function usage(): string {
  return [
    "Usage:",
    "  deno run --allow-read --allow-run --allow-env --allow-write src/main.ts classify --base <sha> --head <sha> [--force-full] [--shadow]",
    "  deno run --allow-read --allow-run --allow-env --allow-write src/main.ts classify --paths <path...> [--force-full]",
    "  deno run --allow-read --allow-run src/main.ts classify --paths <path...> --derived",
    "  deno run --allow-read --allow-run src/main.ts classify --base <sha> --head <sha> --derived-shadow",
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
      } else if (
        ["force-full", "shadow", "derived", "derived-shadow", "help"].includes(
          key,
        )
      ) {
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
  if (args.flags.get("derived") === true) {
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
    writeGithubOutput(derivedGithubOutputLines(derived));
    return 0;
  }

  if (args.flags.get("derived-shadow") === true) {
    const registry = loadRegistryFile(DEFAULT_REGISTRY);
    const legacy = classify(paths, forceFull);
    const derived = deriveClassification(registry, paths, forceFull);
    console.log("legacy:");
    console.log(formatClassification(paths, legacy));
    console.log("derived:");
    console.log(formatClassification(paths, derived));
    console.log(
      `Derived surfaces: ${
        Object.entries(derived.surfaces).map(([k, v]) => `${k}=${v}`).join(" ")
      } unclassified=${derived.unclassified}`,
    );
    // Per-path comparison is primary: an aggregate comparison
    // alone would hide divergences that cancel out (e.g. one
    // unknown path under each classifier both forcing full).
    // Documented migration deltas remain visible but are not CI
    // failures; any new path or changed delta remains fatal.
    const divergences = derivedDivergences(derived, legacy);
    const expectedPerPath: string[] = [];
    const unexpectedPerPath: string[] = [];
    const expectedKeys = new Set<string>();
    for (const path of paths) {
      const singleDerived = deriveClassification(registry, [path]);
      const singleLegacy = classify([path]);
      const single = derivedDivergences(singleDerived, singleLegacy);
      if (single.length > 0) {
        const detail = `path ${path}: ${single.join(", ")}`;
        if (isExpectedDerivedDivergence(path, single)) {
          expectedPerPath.push(detail);
          for (const divergence of single) {
            expectedKeys.add(divergence.slice(0, divergence.indexOf(":")));
          }
        } else {
          unexpectedPerPath.push(detail);
        }
      }
    }
    if (expectedPerPath.length > 0) {
      console.log("derived-shadow: documented divergences (informational):");
      for (const detail of expectedPerPath) console.log(`  ${detail}`);
    }
    const unexplainedAggregate = divergences.filter((divergence) =>
      !expectedKeys.has(divergence.slice(0, divergence.indexOf(":")))
    );
    if (unexpectedPerPath.length > 0 || unexplainedAggregate.length > 0) {
      console.error("derived-shadow: UNEXPECTED divergences (derived vs legacy):");
      for (const divergence of unexplainedAggregate) {
        console.error(`  aggregate: ${divergence}`);
      }
      for (const detail of unexpectedPerPath) console.error(`  ${detail}`);
      return 1;
    }
    if (expectedPerPath.length > 0 || divergences.length > 0) {
      console.log("derived-shadow: all divergences are documented; no unexpected mismatch");
    } else {
      console.log("derived-shadow: derived and legacy classifiers agree");
    }
    return 0;
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
