// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import { classify } from "../src/classify.ts";
import { deriveClassification, derivedDivergences } from "../src/derived.ts";
import { loadRegistryFile } from "../src/registry.ts";

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;
const REGISTRY_PATH = `${REPO_ROOT}.github/ci/components.yaml`;

function derived(paths: string[]) {
  return deriveClassification(loadRegistryFile(REGISTRY_PATH), paths);
}

Deno.test("derived classifier maps spec roots to the spec surfaces", () => {
  const result = derived(["spec/Spec/C3/Foo.lean"]);
  assertEquals(result.spec_check, true);
  assertEquals(result.spec_build, true);
  assertEquals(result.python_tests, true);
  assertEquals(result.lean_build, false);
  assertEquals(result.full, false);
});

Deno.test("derived classifier applies read inputs (src, assurance, SpecExt)", () => {
  const result = derived([
    "src/Foo.lean",
    "wiki/assurance.md",
    "tools/SpecExt/IndexCore.lean",
  ]);
  assertEquals(result.lean_build, true);
  assertEquals(result.spec_check, true);
  assertEquals(result.python_tests, true);
  assertEquals(result.docs_links, true);
});

Deno.test("a src/ change alone triggers spec_check, not the spec build", () => {
  // This is why read inputs may restrict their surfaces: src/ is
  // read by the spec checks only, while spec/ roots trigger the
  // whole specification surface set.
  const result = derived(["src/Foo.lean"]);
  assertEquals(result.spec_check, true);
  assertEquals(result.spec_build, false);
  assertEquals(result.python_tests, true);
  assertEquals(result.lean_build, true);
});

Deno.test("derived classifier maps spec-build inputs declared in the registry", () => {
  const result = derived([
    "scripts/controle.py",
    "scripts/controles/croise.py",
    "wiki/references.json",
  ]);
  assertEquals(result.spec_check, true);
  assertEquals(result.spec_build, true);
  assertEquals(result.python_tests, true);
  assertEquals(result.full, false);
});

Deno.test("derived classifier maps K, proofs and TLA to their new surfaces", () => {
  const k = derived(["src/k/foo.k"]);
  assertEquals(k.surfaces.k_compile, true);
  assertEquals(k.surfaces.k_examples, true);
  assertEquals(k.surfaces.klean_export, true);
  // Decided D2 behaviour, diverging from legacy: src/k/ no longer
  // over-triggers the Lean build; its spec/python read rules stay.
  assertEquals(k.lean_build, false);
  assertEquals(k.spec_check, true);
  assertEquals(k.python_tests, true);

  const proofs = derived(["proofs/Foo.lean"]);
  assertEquals(proofs.surfaces.axiom_audit, true);
  assertEquals(proofs.full, false);

  const tla = derived(["theoretical-projects/k7os/models/D01.tla"]);
  assertEquals(tla.surfaces.tla_model_check, true);
  assertEquals(tla.full, false);
});

Deno.test("derived classifier forces full on unknown paths, fail-closed", () => {
  const result = derived(["some/random/file.txt"]);
  assertEquals(result.full, true);
  assertEquals(result.unclassified, true);
  assertEquals(result.unknown_paths, ["some/random/file.txt"]);
  // Conservative expansion: an unknown path triggers every surface,
  // including the new derivation targets.
  assertEquals(result.surfaces.axiom_audit, true);
  assertEquals(result.surfaces.tla_model_check, true);
});

Deno.test("derived classifier maps full-exact toolchain files to full", () => {
  const result = derived(["lakefile.lean", "lean-toolchain"]);
  assertEquals(result.full, true);
  assertEquals(result.unclassified, false);
});

Deno.test("derived and legacy classifiers agree on the core path set", () => {
  const paths = [
    "spec/Spec/C3/Foo.lean",
    "src/Foo.lean",
    "tests/FooTest.lean",
    "tools/SpecExt/IndexCore.lean",
    "scripts/controle.py",
    "scripts/generate_status.py",
    "tests/python/test_foo.py",
    "wiki/assurance.md",
    "wiki/guide.md",
    "lakefile.lean",
    ".github/workflows/ci.yaml",
    "scripts/ci/impact.py",
  ];
  const divergences = derivedDivergences(derived(paths), classify(paths));
  assertEquals(divergences, []);
});

Deno.test("derived-shadow documents the known divergences, it does not hide them", () => {
  const registry = loadRegistryFile(REGISTRY_PATH);
  const divergentPaths = [
    // Intended D2 behaviour: dedicated surfaces instead of full.
    "proofs/Foo.lean",
    "theoretical-projects/k7os/models/D01.tla",
    // Intended D2 behaviour: K surfaces, no Lean over-triggering.
    "src/k/foo.k",
    // Registry gaps to close before cutover: light paths and the
    // axiom-audit script are claimed by no component.
    ".claude/settings.json",
    "CITATION.cff",
    "scripts/axiom-audit.sh",
    // Non-Markdown wiki/theoretical files: legacy leaves them
    // unclassified (hence full), the registry maps them to links.
    "wiki/notes.json",
    "theoretical-projects/k7os/notes.txt",
    // wiki/references.json is a spec-build input, but the wiki
    // root also claims it for docs_links; conservative extra
    // surface, legacy spec branch does not set it.
    "wiki/references.json",
  ];
  for (const path of divergentPaths) {
    const divergences = derivedDivergences(
      deriveClassification(registry, [path]),
      classify([path]),
    );
    assert(
      divergences.length > 0,
      `${path} must diverge in shadow (otherwise it is not a known case)`,
    );
  }
});
