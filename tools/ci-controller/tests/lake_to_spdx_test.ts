// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  generateSbom,
  normalizeCreated,
  runLakeToSpdx,
  spdxId,
  spdxJson,
} from "../src/lake_to_spdx.ts";
import { PAPERPROOF_WORKSPACE } from "../src/lake_to_osv.ts";

// Parity cases transcribed from scripts/ci/test_lake_manifest_to_spdx.py.
// These are the specification for the port: if the Python
// generator changes, these tests must change with it, in the same
// commit, and the change must be owner-approved.

function urlPath(url: URL): string {
  return decodeURIComponent(url.pathname);
}

const REPO_ROOT = urlPath(new URL("../../../", import.meta.url));
const PAPERPROOF_DIR = `${REPO_ROOT}tools/paperproof-export`;
const PAPERPROOF_LABEL = "tools/paperproof-export/lake-manifest.json";

async function readJson(path: string): Promise<Record<string, unknown>> {
  return JSON.parse(await Deno.readTextFile(path)) as Record<string, unknown>;
}

async function readText(path: string): Promise<string> {
  return await Deno.readTextFile(path);
}

function clone<T>(value: T): T {
  return JSON.parse(JSON.stringify(value)) as T;
}

async function assertRejectsWith(
  fn: () => Promise<unknown>,
  substring: string,
): Promise<void> {
  let caught: unknown;
  try {
    await fn();
  } catch (error) {
    caught = error;
  }
  assert(caught instanceof Error, `expected an error containing ${substring}`);
  assertStringIncludes(caught.message, substring);
}

function assertThrowsWith(fn: () => unknown, substring: string): void {
  let caught: unknown;
  try {
    fn();
  } catch (error) {
    caught = error;
  }
  assert(caught instanceof Error, `expected an error containing ${substring}`);
  assertStringIncludes(caught.message, substring);
}

const REAL_MANIFEST = await readJson(`${REPO_ROOT}lake-manifest.json`);
const REAL_LAKEFILE = await readText(`${REPO_ROOT}lakefile.lean`);
const REAL_TOOLCHAIN = await readText(`${REPO_ROOT}lean-toolchain`);
const PAPERPROOF_MANIFEST = await readJson(
  `${PAPERPROOF_DIR}/lake-manifest.json`,
);
const PAPERPROOF_LAKEFILE = await readText(`${PAPERPROOF_DIR}/lakefile.lean`);
const PAPERPROOF_TOOLCHAIN = await readText(`${PAPERPROOF_DIR}/lean-toolchain`);
const CREATED = "2026-10-10T00:00:00Z";

type Manifest = Record<string, unknown>;
type Pkg = Record<string, unknown>;

function packagesOf(manifest: Manifest): Pkg[] {
  return manifest["packages"] as Pkg[];
}

async function generate(manifest: Manifest = REAL_MANIFEST) {
  return await generateSbom(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN, CREATED);
}

async function paperproof() {
  return await generateSbom(
    PAPERPROOF_MANIFEST,
    PAPERPROOF_LAKEFILE,
    PAPERPROOF_TOOLCHAIN,
    CREATED,
    PAPERPROOF_WORKSPACE,
  );
}

Deno.test("real manifest preserves every package url and revision", async () => {
  const result = await generate();
  assertEquals(result.spdxVersion, "SPDX-2.3");
  assertEquals(result.dataLicense, "CC0-1.0");
  assertEquals(result.packages.length, packagesOf(REAL_MANIFEST).length);
  const byName = new Map(result.packages.map((p) => [p.name, p]));
  assertEquals(
    new Set(byName.keys()),
    new Set(packagesOf(REAL_MANIFEST).map((p) => String(p["name"]))),
  );
  for (const entry of packagesOf(REAL_MANIFEST)) {
    const pkg = byName.get(String(entry["name"]))!;
    assertEquals(pkg.downloadLocation, entry["url"]);
    assertEquals(pkg.versionInfo, entry["rev"]);
    assertEquals(pkg.licenseDeclared, "NOASSERTION");
    assertEquals(pkg.licenseConcluded, "NOASSERTION");
    assertEquals(pkg.copyrightText, "NOASSERTION");
    assertEquals(pkg.filesAnalyzed, false);
  }
});

Deno.test("inventory relations do not invent dependency edges", async () => {
  const result = await generate();
  const packageIds = new Set(result.packages.map((p) => p.SPDXID));
  const described = new Set(
    result.relationships
      .filter((r) =>
        r.spdxElementId === "SPDXRef-DOCUMENT" &&
        r.relationshipType === "DESCRIBES"
      )
      .map((r) => r.relatedSpdxElement),
  );
  assertEquals(described, packageIds);
  assert(
    !result.relationships.some((r) => r.relationshipType === "DEPENDS_ON"),
  );
});

Deno.test("output is deterministic for same manifest and timestamp", async () => {
  const first = await generate();
  const reversed = clone(REAL_MANIFEST);
  packagesOf(reversed).reverse();
  assertEquals(await generate(reversed), first);
});

Deno.test("document namespace changes when inventory changes", async () => {
  const changed = clone(REAL_MANIFEST);
  packagesOf(changed)[0]["scope"] = "different-scope";
  const first = await generate();
  const second = await generate(changed);
  assert(first.documentNamespace !== second.documentNamespace);
});

Deno.test("invalid manifest is rejected", async () => {
  const changed = clone(REAL_MANIFEST);
  packagesOf(changed)[0]["rev"] = "not-a-commit";
  await assertRejectsWith(
    () => generate(changed),
    "40 lowercase hexadecimal",
  );
});

Deno.test("created timestamp is normalized to UTC", () => {
  assertEquals(normalizeCreated("2026-10-10T02:00:00+02:00"), CREATED);
  assertEquals(normalizeCreated("2026-10-10T00:00:00Z"), CREATED);
  assertEquals(normalizeCreated("2026-10-10T01:00:00+01:00"), CREATED);
});

Deno.test("created timestamp requires timezone", () => {
  assertThrowsWith(
    () => normalizeCreated("2026-10-10T00:00:00"),
    "explicit timezone",
  );
  assertThrowsWith(
    () => normalizeCreated("not-a-timestamp"),
    "ISO 8601",
  );
});

Deno.test("source date epoch is used when timestamp is omitted", () => {
  assertEquals(
    normalizeCreated(null, { SOURCE_DATE_EPOCH: "1791590400" }),
    "2026-10-10T00:00:00Z",
  );
  assertThrowsWith(
    () => normalizeCreated(null, { SOURCE_DATE_EPOCH: "not-a-number" }),
    "SOURCE_DATE_EPOCH must be a valid Unix timestamp",
  );
});

Deno.test("spdx identifiers use the identifier subset and short rev", () => {
  assertEquals(
    spdxId({
      name: "mathlib",
      rev: "5ed2965256430c3649e86755f9576b54eca72435",
    }),
    "SPDXRef-Dependency-mathlib-5ed296525643",
  );
  // "_" is outside [A-Za-z0-9.-] and becomes "-"; leading/trailing
  // "." and "-" are stripped, as in the Python slug.
  assertEquals(
    spdxId({ name: "a_b.c", rev: "0123456789abcdef0123456789abcdef01234567" }),
    "SPDXRef-Dependency-a-b.c-0123456789ab",
  );
});

Deno.test("root package comments name the empty scope", async () => {
  const result = await generate();
  const mathlib = result.packages.find((p) => p.name === "mathlib")!;
  assertStringIncludes(
    mathlib.packageComment,
    "Listed in lake-manifest.json. ",
  );
  assertStringIncludes(mathlib.packageComment, "scope: (empty).");
  assertStringIncludes(mathlib.packageComment, "inherited: false");
  const plausible = result.packages.find((p) => p.name === "plausible")!;
  assertStringIncludes(
    plausible.packageComment,
    "scope: leanprover-community.",
  );
  assertStringIncludes(plausible.packageComment, "inherited: true");
});

Deno.test("root document keeps its name and comments", async () => {
  const result = await generate();
  assertEquals(result.name, "K7PL Lake dependency inventory");
  assert(result.comment.startsWith(
    "Scoped inventory generated from lake-manifest.json. It covers only the package entries",
  ));
  assert(
    result.packages.every((p) =>
      p.packageComment.startsWith("Listed in lake-manifest.json. ")
    ),
  );
});

Deno.test("paperproof document says what it describes", async () => {
  const result = await paperproof();
  assertEquals(
    result.name,
    "K7PL Lake dependency inventory (tools/paperproof-export)",
  );
  assertStringIncludes(result.comment, `generated from ${PAPERPROOF_LABEL}`);
  assertStringIncludes(
    result.comment,
    "not a dependency of the k7pl Lake package",
  );
  assert(
    result.packages.every((p) =>
      p.packageComment.startsWith(`Listed in ${PAPERPROOF_LABEL}. `)
    ),
  );
  const byName = new Map(result.packages.map((p) => [p.name, p]));
  assertEquals(
    new Set(byName.keys()),
    new Set(packagesOf(PAPERPROOF_MANIFEST).map((p) => String(p["name"]))),
  );
  for (const entry of packagesOf(PAPERPROOF_MANIFEST)) {
    const pkg = byName.get(String(entry["name"]))!;
    assertEquals(pkg.versionInfo, entry["rev"]);
    assertEquals(pkg.downloadLocation, entry["url"]);
  }
});

Deno.test("two documents have distinct namespaces", async () => {
  const root = await generate();
  assert(root.documentNamespace !== (await paperproof()).documentNamespace);
});

Deno.test("document namespaces match the python generator exactly", async () => {
  // Golden values from scripts/ci/lake_manifest_to_spdx.py on the
  // same manifests and timestamp: the namespace is a SHA-256 of
  // the canonical serialization, so any separator or ordering
  // drift in canonicalManifest() changes it. This test pins it.
  const root = await generate();
  assertEquals(
    root.documentNamespace,
    "https://spdx.org/spdxdocs/k7pl-lake-dependencies-8f1152c8950a587c5692c9ac3f8cc05c289bbfeeaceb8b1220feabe4e0a035b7",
  );
  assertEquals(
    (await paperproof()).documentNamespace,
    "https://spdx.org/spdxdocs/k7pl-lake-dependencies-60be06f11cfd4c7991c7d0ba7f4481f0236114e44d5dbcaa6d8f41e2f9ff525b",
  );
});

Deno.test("paperproof manifest is refused under the root rules", async () => {
  await assertRejectsWith(
    () =>
      generateSbom(
        PAPERPROOF_MANIFEST,
        PAPERPROOF_LAKEFILE,
        PAPERPROOF_TOOLCHAIN,
        CREATED,
      ),
    "invalid Lake manifest",
  );
});

Deno.test("cli output is byte reproducible for fixed timestamp", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const firstPath = `${tmp}/first.spdx.json`;
    const secondPath = `${tmp}/second.spdx.json`;
    for (const outputPath of [firstPath, secondPath]) {
      const completed = await runLakeToSpdx(
        ["--created", CREATED, "--output", outputPath],
        REPO_ROOT,
        {},
      );
      assertEquals(completed.exitCode, 0, completed.stderr);
    }
    assertEquals(
      await Deno.readFile(firstPath),
      await Deno.readFile(secondPath),
    );
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("cli defaults to the files of the manifest workspace", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const outputs = [`${tmp}/first.spdx.json`, `${tmp}/second.spdx.json`];
    for (const output of outputs) {
      const completed = await runLakeToSpdx(
        [
          "--manifest",
          // Absolute here (the Python test uses the relative label
          // with cwd at the repository root; deno test runs from
          // tools/ci-controller, so a relative label would resolve
          // against the wrong directory).
          `${PAPERPROOF_DIR}/lake-manifest.json`,
          "--created",
          CREATED,
          "--output",
          output,
        ],
        REPO_ROOT,
        {},
      );
      assertEquals(completed.exitCode, 0, completed.stderr);
    }
    assertEquals(
      await Deno.readFile(outputs[0]),
      await Deno.readFile(outputs[1]),
    );
    // Byte comparison against the library output (the Python test
    // compares parsed objects, which is key-order-insensitive;
    // assertEquals stringifies, so compare canonical text).
    assertEquals(
      await Deno.readTextFile(outputs[0]),
      spdxJson(await paperproof()),
    );
    // An explicit lakefile still overrides the workspace default
    // (and is checked).
    const completed = await runLakeToSpdx(
      [
        "--manifest",
        `${PAPERPROOF_DIR}/lake-manifest.json`,
        "--lakefile",
        `${REPO_ROOT}lakefile.lean`,
        "--created",
        CREATED,
        "--output",
        outputs[0],
      ],
      REPO_ROOT,
      {},
    );
    assertEquals(completed.exitCode, 1);
    assertStringIncludes(completed.stderr, "inconsistent Lake inputs");
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("cli writes to stdout when output is omitted", async () => {
  const completed = await runLakeToSpdx(["--created", CREATED], REPO_ROOT, {});
  assertEquals(completed.exitCode, 0, completed.stderr);
  assertStringIncludes(
    completed.stderr,
    "Generated scoped SPDX 2.3 inventory with 14 Lake package entries",
  );
  const document = JSON.parse(completed.stdout);
  assertEquals(document["spdxVersion"], "SPDX-2.3");
  assertEquals(document["packages"].length, 14);
});
