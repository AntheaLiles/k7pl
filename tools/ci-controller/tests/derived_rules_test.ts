// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import { deriveClassification } from "../src/derived.ts";
import { loadRegistryFile } from "../src/registry.ts";

// The routing rules that tests/classify_test.ts stated for the legacy
// classifier (transcribed from scripts/ci/test_impact.py), restated
// for the derived classifier at cutover C4, when both legacy
// classifiers were removed. Where the derived classifier diverges by
// a decided D2 behaviour (proofs/), the test states the decided
// routing; tests/derived_test.ts lists every such divergence.

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;
const REGISTRY = loadRegistryFile(`${REPO_ROOT}.github/ci/components.yaml`);

function classify(paths: string[], forceFull = false) {
  return deriveClassification(REGISTRY, paths, forceFull);
}

const REPORTED = [
  "full",
  "docs_links",
  "spec_check",
  "spec_build",
  "lean_build",
  "python_tests",
  "tracking_views",
] as const;

Deno.test("markdown is light", () => {
  const result = classify(["docs/foo.md"]);
  assert(result.docs_links);
  assert(!result.full);
  assert(!result.spec_build);
  assert(!result.lean_build);
});

Deno.test("claude markdown is light", () => {
  const result = classify([".claude/agents/example.md"]);
  assert(result.docs_links);
  assert(!result.full);
});

Deno.test("lean surface", () => {
  const result = classify(["src/K7pl/Foo.lean"]);
  assertEquals(
    {
      lean_build: result.lean_build,
      spec_check: result.spec_check,
      python_tests: result.python_tests,
    },
    { lean_build: true, spec_check: true, python_tests: true },
  );
  assert(!result.spec_build);
  assert(!result.full);
});

Deno.test("tests lean surface has no spec check", () => {
  const result = classify(["tests/Anything.lean"]);
  assert(result.lean_build);
  assert(!result.spec_check);
  assert(!result.python_tests);
});

Deno.test("tracking views only on full validation", () => {
  assert(!classify(["spec/Spec/C1.lean"]).tracking_views);
  assert(!classify(["wiki/roadmap.md"]).tracking_views);
  assert(!classify(["docs/other.md"]).tracking_views);
  assert(classify(["spec/Spec/C1.lean"], true).tracking_views);
});

Deno.test("spec surface", () => {
  const result = classify(["spec/Spec/C1.lean"]);
  assert(result.spec_check);
  assert(result.spec_build);
  assert(result.python_tests);
  assert(!result.lean_build);
});

Deno.test("wiki research is docs links only (D1: wiki is not normative)", () => {
  const result = classify(["wiki/research.md"]);
  assert(result.docs_links);
  assert(!result.spec_check);
  assert(!result.spec_build);
});

Deno.test("ci change forces full", () => {
  const result = classify([".github/workflows/ci.yaml"]);
  assert(result.full);
  assert(result.spec_build);
  assert(result.lean_build);
  assert(result.docs_links);
});

Deno.test("non-markdown docs path forces full (F9)", () => {
  const result = classify(["docs/notes.txt"]);
  assert(result.full);
  assert(result.unclassified);
  assertEquals(result.unknown_paths, ["docs/notes.txt"]);
});

Deno.test("unknown path forces full", () => {
  const result = classify(["new-format.toml"]);
  assert(result.full);
  assert(result.unclassified);
  assertEquals(result.unknown_paths, ["new-format.toml"]);
});

Deno.test("mixed surfaces are unioned", () => {
  const result = classify([
    "src/K7pl/Foo.lean",
    "docs/foo.md",
    "spec/Spec/C2.lean",
  ]);
  assert(result.lean_build);
  assert(result.spec_build);
  assert(result.docs_links);
  assert(!result.full);
});

Deno.test("force full dominates", () => {
  const result = classify(["docs/foo.md"], true);
  for (const key of REPORTED) assert(result[key], key);
  assert(Object.values(result.surfaces).every((on) => on));
});

Deno.test("every full exact path forces full by name", () => {
  for (
    const path of [
      ".github/dependabot.yml",
      "lakefile.lean",
      "lean-toolchain",
      "lake-manifest.json",
      "scripts/sync_zenodo.py",
      "scripts/requirements-zenodo.txt",
    ]
  ) {
    const result = classify([path]);
    assert(result.full, path);
    assert(
      !result.unclassified,
      `${path} must force full by name, not as unknown`,
    );
    assertEquals(result.unknown_paths, []);
  }
});

Deno.test("every full prefix forces full by name", () => {
  for (
    const path of [
      ".github/workflows/end-to-end.txt",
      "scripts/ci/end-to-end.txt",
    ]
  ) {
    const result = classify([path]);
    assert(result.full, path);
    assert(!result.unclassified, path);
  }
});

Deno.test("near-miss exact paths are unknown", () => {
  const result = classify(["lakefile.lean.orig"]);
  assert(result.full);
  assert(result.unclassified);
});

Deno.test("light paths validate nothing else", () => {
  for (
    const path of [
      ".github/ISSUE_TEMPLATE/bug.yaml",
      "docs/security/notes.md",
      "LICENSES/MIT.txt",
      "CITATION.cff",
    ]
  ) {
    const result = classify([path]);
    assert(!result.full, path);
    assert(!result.unclassified, path);
    assert(!result.lean_build && !result.spec_build, path);
  }
});

Deno.test("read-by-another-surface rules", () => {
  assertEquals(
    {
      docs: classify(["wiki/assurance.md"]).docs_links,
      py: classify(["wiki/assurance.md"]).python_tests,
    },
    { docs: true, py: true },
  );
  const tools = classify(["tools/Compliance/SbomAudit.lean"]);
  assert(
    tools.lean_build && tools.spec_check && tools.spec_build &&
      tools.python_tests,
  );
  const otherTools = classify(["tools/SpecExt/Float.lean"]);
  assert(!otherTools.lean_build);
  assert(otherTools.spec_build);
});

Deno.test("axiom audit runs lean and spec builds, nothing else", () => {
  const result = classify(["scripts/axiom-audit.sh"]);
  assert(result.lean_build);
  assert(result.spec_build);
  assert(!result.full);
  assert(!result.unclassified);
  assert(!result.spec_check);
  assert(!result.docs_links);
});

Deno.test("markdown under a full prefix still forces full", () => {
  const result = classify([".github/workflows/README.md"]);
  assert(result.full);
  assert(result.docs_links);
  assert(!result.unclassified);
});

Deno.test("markdown under a validated surface keeps that surface", () => {
  const result = classify(["src/K7pl/NOTES.md"]);
  assert(result.lean_build);
  assert(result.docs_links);
  assert(!result.full);
});

Deno.test("spec markdown adds link check to spec surfaces", () => {
  const result = classify(["spec/CHANGELOG.md"]);
  assert(
    result.docs_links && result.spec_check && result.spec_build &&
      result.python_tests,
  );
});

Deno.test("proofs paths run the axiom audit, not full (decided D2)", () => {
  for (const path of ["proofs/K7PL/Proof.lean", "proofs/lakefile.toml"]) {
    const result = classify([path]);
    assert(result.surfaces.axiom_audit, path);
    assert(!result.full && !result.unclassified, path);
  }
});

Deno.test("empty path list validates nothing", () => {
  const result = classify([]);
  assert(!result.full && !result.unclassified);
  for (const key of REPORTED) assert(!result[key], key);
  assert(Object.values(result.surfaces).every((on) => !on));
});

Deno.test("case-insensitive markdown extensions", () => {
  const result = classify(["CHANGELOG.MD", "docs/a.markdown"]);
  assert(result.docs_links);
  assert(!result.full);
});
