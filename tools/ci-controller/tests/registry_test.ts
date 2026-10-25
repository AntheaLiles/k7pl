// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { loadRegistryFile, validateRegistry } from "../src/registry.ts";
import { parseYaml } from "../src/yaml.ts";

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;
const REGISTRY_PATH = `${REPO_ROOT}.github/ci/components.yaml`;

Deno.test("registry loads and validates against the repository tree", () => {
  const registry = loadRegistryFile(REGISTRY_PATH);
  assertEquals(validateRegistry(registry, REPO_ROOT), []);
});

Deno.test("registry contains every expected component", () => {
  const registry = loadRegistryFile(REGISTRY_PATH);
  const ids = registry.components.map((c) => c.id).sort();
  assertEquals(ids, [
    "ci-configuration",
    "implementation",
    "k-semantics",
    "lean-proofs",
    "python-tooling",
    "spec-tooling",
    "specification",
    "theoretical-projects",
    "tla-models",
    "wiki",
  ]);
});

Deno.test("proof chain edges are declared, and TLA+ is not derived from K", () => {
  const registry = loadRegistryFile(REGISTRY_PATH);
  assertEquals(registry.componentById.get("k-semantics")!.dependsOn, [
    "specification",
  ]);
  assertEquals(registry.componentById.get("lean-proofs")!.dependsOn, [
    "k-semantics",
  ]);
  assertEquals(registry.componentById.get("tla-models")!.dependsOn, []);
  assertEquals(registry.stageById.get("lean-proof-build")!.requires, [
    "klean-export",
  ]);
  assertEquals(registry.stageById.get("klean-export")!.requires, ["k-compile"]);
});

Deno.test("only the lean proof stage may emit proof claims", () => {
  const registry = loadRegistryFile(REGISTRY_PATH);
  const proofStages = registry.stages.filter((s) =>
    s.allowedClaimClasses.includes("proof")
  );
  assertEquals(proofStages.map((s) => s.id), ["lean-proof-build"]);
});

Deno.test("registry validation rejects an unknown dependency", () => {
  const registry = loadRegistryFile(REGISTRY_PATH);
  const broken = {
    ...registry,
    components: registry.components.map((c) =>
      c.id === "wiki" ? { ...c, dependsOn: ["no-such-component"] } : c
    ),
  };
  // Rebuild the map the validator reads from (validateRegistry uses
  // componentById only for reference checks, so this is enough).
  const errors = validateRegistry(broken as never, REPO_ROOT);
  assert(errors.some((e) => e.includes("unknown dependency")));
});

Deno.test("registry validation rejects a missing root", () => {
  const registry = loadRegistryFile(REGISTRY_PATH);
  const broken = {
    ...registry,
    components: registry.components.map((c) =>
      c.id === "wiki" ? { ...c, roots: ["wiki-no-such-dir/"] } : c
    ),
  };
  const errors = validateRegistry(broken as never, REPO_ROOT);
  assert(errors.some((e) => e.includes("does not exist")));
});

Deno.test("registry validation rejects a dependency cycle", () => {
  const registry = loadRegistryFile(REGISTRY_PATH);
  const broken = {
    ...registry,
    components: registry.components.map((c) => {
      if (c.id === "specification") {
        return { ...c, dependsOn: ["spec-tooling"] };
      }
      return c;
    }),
  };
  const errors = validateRegistry(broken as never, REPO_ROOT);
  assert(errors.some((e) => e.includes("cycle")));
});

Deno.test("yaml subset parser rejects anchors and tabs", () => {
  let failed = false;
  try {
    parseYaml("a: &anchor 1\n");
  } catch {
    failed = true;
  }
  assert(failed, "anchors must be rejected");
  failed = false;
  try {
    parseYaml("a:\n\t- 1\n");
  } catch {
    failed = true;
  }
  assert(failed, "tabs must be rejected");
});

Deno.test("yaml subset parser handles the registry's constructs", () => {
  const value = parseYaml(
    "a:\n  - x\n  - 'y z'\n  - \"w\"\nb: [1, 2]\nc: true\nd: 42\ne:\n",
  ) as Record<string, unknown>;
  assertEquals(value["a"], ["x", "y z", "w"]);
  assertEquals(value["b"], [1, 2]);
  assertEquals(value["c"], true);
  assertEquals(value["d"], 42);
  assertEquals(value["e"], null);
});

Deno.test("yaml parser handles sequence items that are mappings", () => {
  const value = parseYaml(
    "items:\n  - id: a\n    version: 1\n  - id: b\n    version: 2\n",
  ) as {
    items: { id: string; version: number }[];
  };
  assertEquals(value.items, [{ id: "a", version: 1 }, { id: "b", version: 2 }]);
});

Deno.test("yaml parser keeps hash characters inside unquoted scalars", () => {
  const value = parseYaml("url: https://example.invalid/x#frag\n") as Record<
    string,
    unknown
  >;
  assertStringIncludes(String(value["url"]), "#frag");
});
