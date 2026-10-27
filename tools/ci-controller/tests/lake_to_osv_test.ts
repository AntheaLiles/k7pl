// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  convertManifest,
  PAPERPROOF_WORKSPACE,
  runLakeToOsv,
} from "../src/lake_to_osv.ts";

// Parity cases transcribed from scripts/ci/test_lake_manifest_to_osv.py.
// These are the specification for the port: if the Python adapter
// changes, these tests must change with it, in the same commit,
// and the change must be owner-approved.

function urlPath(url: URL): string {
  return decodeURIComponent(url.pathname);
}

const REPO_ROOT = urlPath(new URL("../../../", import.meta.url));
const PAPERPROOF_DIR = `${REPO_ROOT}tools/paperproof-export`;

async function readJson(path: string): Promise<Record<string, unknown>> {
  return JSON.parse(await Deno.readTextFile(path)) as Record<string, unknown>;
}

async function readText(path: string): Promise<string> {
  return await Deno.readTextFile(path);
}

function clone<T>(value: T): T {
  return JSON.parse(JSON.stringify(value)) as T;
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

type Manifest = Record<string, unknown>;
type Pkg = Record<string, unknown>;

function packagesOf(manifest: Manifest): Pkg[] {
  return manifest["packages"] as Pkg[];
}

Deno.test("real manifest is converted without losing revisions", () => {
  const result = convertManifest(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN);
  const packages = result.results[0].packages;
  assertEquals(packages.length, packagesOf(REAL_MANIFEST).length);
  const byUrl = new Map(
    packages.map((item) => [item.package.name, item.package.commit]),
  );
  for (const pkg of packagesOf(REAL_MANIFEST)) {
    const url = String(pkg["url"]);
    const name = url.startsWith("https://")
      ? url.slice("https://".length)
      : url;
    assertEquals(byUrl.get(name), pkg["rev"]);
  }
});

Deno.test("output is deterministic independent of manifest order", () => {
  const first = convertManifest(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN);
  const reversed = clone(REAL_MANIFEST);
  packagesOf(reversed).reverse();
  assertEquals(
    convertManifest(reversed, REAL_LAKEFILE, REAL_TOOLCHAIN),
    first,
  );
});

Deno.test("invalid repository is rejected", () => {
  const manifest = clone(REAL_MANIFEST);
  packagesOf(manifest)[0]["url"] = "https://example.invalid/attacker/repo";
  assertThrowsWith(
    () => convertManifest(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN),
    "url",
  );
});

Deno.test("non-commit revision is rejected", () => {
  const manifest = clone(REAL_MANIFEST);
  packagesOf(manifest)[0]["rev"] = "main";
  assertThrowsWith(
    () => convertManifest(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN),
    "40 lowercase hexadecimal",
  );
});

Deno.test("empty dependency list is rejected", () => {
  const manifest = clone(REAL_MANIFEST);
  manifest["packages"] = [];
  assertThrowsWith(
    () => convertManifest(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN),
    "missing, empty or not a list",
  );
});

Deno.test("lakefile revision mismatch is rejected", () => {
  const mismatched = REAL_LAKEFILE.replace(
    '"https://github.com/leanprover/verso" @ "v4.34.0"',
    '"https://github.com/leanprover/verso" @ "v4.33.0"',
  );
  assert(mismatched !== REAL_LAKEFILE);
  assertThrowsWith(
    () => convertManifest(REAL_MANIFEST, mismatched, REAL_TOOLCHAIN),
    "inconsistent Lake inputs",
  );
});

Deno.test("toolchain mismatch is rejected", () => {
  assertThrowsWith(
    () =>
      convertManifest(
        REAL_MANIFEST,
        REAL_LAKEFILE,
        "leanprover/lean4:v4.0.1\n",
      ),
    "inconsistent Lake inputs",
  );
});

Deno.test("adversarial mutation corpus rejects untrusted manifest shapes", () => {
  const cases: Array<[string, (m: Manifest) => void]> = [
    ["unknown-root-key", (m) => {
      m["unexpectedRootField"] = "must not be ignored";
    }],
    ["unknown-package-key", (m) => {
      packagesOf(m)[0]["unexpectedPackageField"] = "must not be ignored";
    }],
    ["non-git-package", (m) => {
      packagesOf(m)[0]["type"] = "archive";
    }],
    ["non-boolean-inherited", (m) => {
      packagesOf(m)[0]["inherited"] = "false";
    }],
    ["path-traversal-scope", (m) => {
      packagesOf(m)[0]["scope"] = "../../outside";
    }],
    ["uppercase-revision", (m) => {
      packagesOf(m)[0]["rev"] = "A".repeat(40);
    }],
    ["untrusted-repository", (m) => {
      packagesOf(m)[0]["url"] = "https://example.invalid/attacker/repo";
    }],
    ["duplicate-package", (m) => {
      packagesOf(m).push(clone(packagesOf(m)[0]));
    }],
    ["non-object-package", (m) => {
      packagesOf(m)[0] = null as unknown as Pkg;
    }],
    ["non-list-package-container", (m) => {
      m["packages"] = null;
    }],
  ];
  for (const [name, mutate] of cases) {
    const candidate = clone(REAL_MANIFEST);
    mutate(candidate);
    let threw = false;
    try {
      convertManifest(candidate, REAL_LAKEFILE, REAL_TOOLCHAIN);
    } catch {
      threw = true;
    }
    assert(threw, `mutation ${name} must be rejected`);
  }
});

Deno.test("rotations do not change the valid pin projection", () => {
  const baseline = convertManifest(
    REAL_MANIFEST,
    REAL_LAKEFILE,
    REAL_TOOLCHAIN,
  );
  const count = packagesOf(REAL_MANIFEST).length;
  for (let rotation = 1; rotation < count; rotation++) {
    const candidate = clone(REAL_MANIFEST);
    const pkgs = packagesOf(candidate);
    candidate["packages"] = [
      ...pkgs.slice(rotation),
      ...pkgs.slice(0, rotation),
    ];
    const projected = convertManifest(candidate, REAL_LAKEFILE, REAL_TOOLCHAIN);
    assertEquals(projected, baseline);
  }
});

Deno.test("paperproof workspace is converted under its own rules", () => {
  const result = convertManifest(
    PAPERPROOF_MANIFEST,
    PAPERPROOF_LAKEFILE,
    PAPERPROOF_TOOLCHAIN,
    PAPERPROOF_WORKSPACE,
  );
  const names = new Set(result.results[0].packages.map((i) => i.package.name));
  assert(names.has("github.com/Paper-Proof/paperproof"));
  assertEquals(names.size, packagesOf(PAPERPROOF_MANIFEST).length);
  assertThrowsWith(
    () =>
      convertManifest(
        PAPERPROOF_MANIFEST,
        PAPERPROOF_LAKEFILE,
        PAPERPROOF_TOOLCHAIN,
      ),
    "invalid Lake manifest",
  );
});

Deno.test("cli picks the workspace from the manifest path", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const output = `${tmp}/osv.json`;
    const completed = runLakeToOsv(
      [
        "--manifest",
        `${PAPERPROOF_DIR}/lake-manifest.json`,
        "--output",
        output,
      ],
      REPO_ROOT,
    );
    assertEquals(completed.exitCode, 0);
    assertStringIncludes(completed.stdout, "10 pinned Lake Git dependencies");
    const copied = `${tmp}/lake-manifest.json`;
    await Deno.writeFile(
      copied,
      await Deno.readFile(`${PAPERPROOF_DIR}/lake-manifest.json`),
    );
    const refused = runLakeToOsv(
      ["--manifest", copied, "--output", output],
      REPO_ROOT,
    );
    assertEquals(refused.exitCode, 1);
    assertStringIncludes(
      refused.stderr,
      "Paperproof: not one of the known packages",
    );
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("cli refuses oversized and symlinked manifests", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const output = `${tmp}/osv.json`;
    const big = `${tmp}/big.json`;
    await Deno.writeTextFile(big, " ".repeat((1 << 20) + 1));
    const oversized = runLakeToOsv(
      ["--manifest", big, "--output", output],
      REPO_ROOT,
    );
    assertEquals(oversized.exitCode, 1);
    assertStringIncludes(oversized.stderr, "is larger than");
    const link = `${tmp}/link.json`;
    try {
      await Deno.symlink(`${REPO_ROOT}lake-manifest.json`, link);
    } catch {
      // Symbolic links are not available here; skip that part.
      return;
    }
    const linked = runLakeToOsv(
      ["--manifest", link, "--output", output],
      REPO_ROOT,
    );
    assertEquals(linked.exitCode, 1);
    assertStringIncludes(linked.stderr, "not a regular file");
    let outputExists = true;
    try {
      await Deno.stat(output);
    } catch {
      outputExists = false;
    }
    assert(!outputExists);
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});
