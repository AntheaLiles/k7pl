// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  ALLOWED_PACKAGES,
  checkConsistency,
  checkManifest,
  checkTags,
  checkUpstream,
  clean,
  type Fetch,
  fetchUpstreamManifest,
  loadManifest,
  type LsRemote,
  MAX_MANIFEST_BYTES,
  PAPERPROOF_ALLOWED_PACKAGES,
  PAPERPROOF_WORKSPACE,
  runCheckManifest,
  runCheckManifestCommand,
  upstreamManifestUrl,
  validatedManifest,
} from "../src/manifest.ts";

// Parity cases transcribed from scripts/ci/test_check_manifest.py.
// These are the specification for the port: if the Python
// script changes, these tests must change with it, in the
// same commit, and the change must be owner-approved.

const REPO_ROOT = Deno.realPathSync(
  new URL("../../..", import.meta.url).pathname,
);

type Manifest = Record<string, unknown>;
type Package = Record<string, unknown>;

function readRealManifest(): Manifest {
  return JSON.parse(
    Deno.readTextFileSync(`${REPO_ROOT}/lake-manifest.json`),
  ) as Manifest;
}

function readRealLakefile(): string {
  return Deno.readTextFileSync(`${REPO_ROOT}/lakefile.lean`);
}

function readRealToolchain(): string {
  return Deno.readTextFileSync(`${REPO_ROOT}/lean-toolchain`);
}

function readPaperproofManifest(): Manifest {
  return JSON.parse(
    Deno.readTextFileSync(
      `${REPO_ROOT}/tools/paperproof-export/lake-manifest.json`,
    ),
  ) as Manifest;
}

function clone<T>(value: T): T {
  return JSON.parse(JSON.stringify(value)) as T;
}

function packagesOf(manifest: Manifest): Package[] {
  return manifest["packages"] as Package[];
}

function manifestWith(changesOnFirst: Record<string, unknown>): Manifest {
  const manifest = readRealManifest();
  Object.assign(packagesOf(manifest)[0], changesOnFirst);
  return manifest;
}

function manifestChanging(
  packageName: string,
  changes: Record<string, unknown>,
): Manifest {
  const manifest = readRealManifest();
  const found = packagesOf(manifest).find((p) => p["name"] === packageName)!;
  Object.assign(found, changes);
  return manifest;
}

function manifestWithTopLevel(changes: Record<string, unknown>): Manifest {
  const manifest = readRealManifest();
  Object.assign(manifest, changes);
  return manifest;
}

function assertContains(errors: string[], needle: string): void {
  assert(
    errors.some((e) => e.includes(needle)),
    `expected an error containing ${JSON.stringify(needle)}, got ${
      JSON.stringify(errors)
    }`,
  );
}

function assertThrowsWith(fn: () => unknown, needle: string): void {
  let caught: unknown;
  try {
    fn();
  } catch (error) {
    caught = error;
  }
  assert(caught instanceof Error, `expected a throw containing ${needle}`);
  assertStringIncludes(caught.message, needle);
}

function noNetwork(): never {
  throw new Error("unexpected network query");
}

const DIRECT = ["mathlib", "cslib", "verso"] as const;

Deno.test("real manifest passes the offline checks", () => {
  const manifest = readRealManifest();
  assertEquals(checkManifest(manifest), []);
  assertEquals(
    checkConsistency(manifest, readRealLakefile(), readRealToolchain()),
    [],
  );
});

Deno.test("the allow-list is exactly what the real manifest holds", () => {
  const real: Record<string, string> = {};
  for (const p of packagesOf(readRealManifest())) {
    real[p["name"] as string] = (p["url"] as string).replace(
      "https://github.com/",
      "",
    );
  }
  assertEquals(ALLOWED_PACKAGES, real);
});

Deno.test("bad revs are rejected", () => {
  const real = packagesOf(readRealManifest())[0]["rev"] as string;
  for (
    const rev of [
      real.slice(0, 7),
      "main",
      "A".repeat(40),
      "a".repeat(41),
      `${"a".repeat(40)}\n`,
      null,
      12345,
      ["a".repeat(40)],
    ]
  ) {
    const errors = checkManifest(manifestWith({ rev }));
    assertContains(errors, "40 lowercase hexadecimal");
  }
});

Deno.test("bad urls are rejected", () => {
  const bad = [
    "https://github.com/evil/mathlib4",
    "https://github.com/leanprover-community-evil/mathlib4",
    "https://github.com/Leanprover/mathlib4",
    "https://gitlab.com/leanprover-community/mathlib4",
    "https://github.com.evil.example/leanprover-community/mathlib4",
    "https://github.com@evil.example/leanprover-community/mathlib4",
    "https://user:pw@github.com/leanprover-community/mathlib4",
    "https://github.com:8443/leanprover-community/mathlib4",
    "http://github.com/leanprover-community/mathlib4",
    "git@github.com:leanprover-community/mathlib4",
    "ssh://git@github.com/leanprover-community/mathlib4",
    "file:///tmp/mathlib4",
    "https://github.com/leanprover-community/mathlib4/tree/main",
    "https://github.com/leanprover-community/mathlib4?x=1",
    "https://github.com/leanprover-community/mathlib4.git",
    "https://github.com/leanprover-community",
    "https://github.com/leanprover-community/mathlib4#x",
    "https://github.com/leanprover-community/mathlib4#",
    null,
    ["https://github.com/leanprover/verso"],
  ];
  for (const url of bad) {
    const errors = checkManifest(manifestWith({ url }));
    assert(
      errors.some((e) => e.includes("rejected") || e.includes("`url`")),
      `url ${JSON.stringify(url)} should be rejected, got ${
        JSON.stringify(errors)
      }`,
    );
  }
});

Deno.test("repository names must be plain names", () => {
  for (
    const repo of ["", ".", "..", "-x", "a b", "mathlib4.git", "mathlib4%20"]
  ) {
    const errors = checkManifest(
      manifestWith({ url: `https://github.com/leanprover-community/${repo}` }),
    );
    assert(
      errors.length > 0,
      `repo ${JSON.stringify(repo)} should be rejected`,
    );
  }
});

Deno.test("each known package is accepted with its own repository", () => {
  for (const [name, repository] of Object.entries(ALLOWED_PACKAGES)) {
    const manifest = readRealManifest();
    const package_ = {
      ...packagesOf(manifest)[0],
      name,
      url: `https://github.com/${repository}`,
    };
    assertEquals(
      checkManifest({ ...manifest, packages: [package_] }),
      [],
    );
  }
});

Deno.test("structure failures are rejected", () => {
  assertContains(
    checkManifest(manifestWith({ type: "path" })),
    "must be 'git'",
  );
  const duplicated = readRealManifest();
  packagesOf(duplicated).push(clone(packagesOf(duplicated)[0]));
  assertContains(checkManifest(duplicated), "duplicate");
  assertContains(
    checkManifest(manifestWithTopLevel({ packagesDir: "/tmp/elsewhere" })),
    "packagesDir",
  );
  for (const packages of [[], null, "x"]) {
    const manifest = readRealManifest();
    manifest["packages"] = packages;
    assert(checkManifest(manifest).length > 0);
  }
  const missing = readRealManifest();
  delete missing["packages"];
  assert(checkManifest(missing).length > 0);
  for (const value of [[], "text", 3, null]) {
    assert(checkManifest(value).length > 0);
  }
});

Deno.test("path fields refuse traversal, absolute paths and odd characters", () => {
  const bad = [
    "../../..",
    "..",
    "a/../b",
    "/etc/passwd",
    "a b",
    "a;b",
    "$(id)",
    "x\n",
    "-rf",
    "~",
    "a\\b",
  ];
  for (const key of ["subDir", "configFile", "manifestFile", "scope"]) {
    for (const value of bad) {
      const errors = checkManifest(
        manifestChanging("batteries", { [key]: value }),
      );
      assertContains(errors, "plain relative path");
    }
    const errors = checkManifest(manifestChanging("batteries", { [key]: 5 }));
    assertContains(errors, "is not a string");
  }
  for (const key of ["configFile", "manifestFile"]) {
    assertContains(
      checkManifest(manifestChanging("batteries", { [key]: "" })),
      "plain relative path",
    );
  }
});

Deno.test("plain relative paths are accepted", () => {
  const cases: Array<[string, unknown]> = [
    ["subDir", "sub/dir"],
    ["subDir", null],
    ["configFile", "lakefile.toml"],
    ["scope", ""],
  ];
  for (const [key, value] of cases) {
    assertEquals(
      checkManifest(manifestChanging("batteries", { [key]: value })),
      [],
    );
  }
});

Deno.test("inputRev must be a plain name and not a full ref", () => {
  for (
    const value of [
      "refs/heads/evil",
      "refs/tags/v1",
      "../x",
      "a b",
      "-x",
      "main\n",
      "",
      5,
    ]
  ) {
    assertContains(
      checkManifest(manifestChanging("batteries", { inputRev: value })),
      "`inputRev` must be a plain name",
    );
  }
  for (const value of ["main", "master", "v4.34.0", "feature/x", null]) {
    assertEquals(
      checkManifest(manifestChanging("batteries", { inputRev: value })),
      [],
    );
  }
});

Deno.test("config and manifest file names are closed lists", () => {
  for (
    const value of [
      "evil.lean",
      "tools/run.lean",
      "lakefile.lean.bak",
      "Lakefile.lean",
    ]
  ) {
    assertContains(
      checkManifest(manifestChanging("batteries", { configFile: value })),
      "`configFile` must be one of",
    );
  }
  for (const value of ["other.json", "sub/lake-manifest.json"]) {
    assertContains(
      checkManifest(manifestChanging("batteries", { manifestFile: value })),
      "`manifestFile` must be",
    );
  }
  for (const value of ["lakefile.lean", "lakefile.toml"]) {
    assertEquals(
      checkManifest(manifestChanging("batteries", { configFile: value })),
      [],
    );
  }
});

Deno.test("version and fixedToolchain must be well formed when present", () => {
  for (
    const value of ["", "v1.2.0", "1.2.0\n", "1.2.x", "1", 1, null, ["1.2.0"]]
  ) {
    assertContains(
      checkManifest(manifestWithTopLevel({ version: value })),
      "`version` must be dotted numbers",
    );
  }
  for (const value of ["false", 0, null, [false]]) {
    assertContains(
      checkManifest(manifestWithTopLevel({ fixedToolchain: value })),
      "`fixedToolchain` must be a boolean",
    );
  }
  for (const value of ["1.2", "1.3.0", "2.0.1"]) {
    assertEquals(
      checkManifest(
        manifestWithTopLevel({ version: value, fixedToolchain: true }),
      ),
      [],
    );
  }
});

Deno.test("top-level lakeDir, name and unknown keys are refused", () => {
  assertContains(
    checkManifest(manifestWithTopLevel({ lakeDir: "../../x" })),
    "`lakeDir` must be",
  );
  assertContains(
    checkManifest(manifestWithTopLevel({ name: "evil name" })),
    "`name` must match",
  );
  assertContains(
    checkManifest(manifestWithTopLevel({ name: "x\n::notice::y" })),
    "`name` must match",
  );
  assertContains(
    checkManifest(manifestWithTopLevel({ extra: 1 })),
    "unknown top-level key",
  );
  assertContains(
    checkManifest(manifestChanging("batteries", { extra: "x" })),
    "unknown key",
  );
  assertContains(
    checkManifest(manifestChanging("batteries", { inherited: "yes" })),
    "`inherited` must be a boolean",
  );
});

Deno.test("a package name that is not a string is a clean rejection, not a crash", () => {
  for (const name of [["mathlib"], { a: 1 }, 3, null]) {
    const manifest = manifestWith({ name });
    assert(checkManifest(manifest).length > 0);
    // checkConsistency must not throw on the same input.
    const errors = checkConsistency(
      manifest,
      readRealLakefile(),
      readRealToolchain(),
    );
    assert(errors.length > 0);
  }
});

Deno.test("consistency failures are rejected", () => {
  const manifest = readRealManifest();
  const lakefile = readRealLakefile();
  const toolchain = readRealToolchain();
  const older = checkConsistency(
    manifest,
    lakefile,
    "leanprover/lean4:v4.0.1\n",
  );
  assertContains(older, "lean-toolchain is 'v4.0.1'");
  assertEquals(older.filter((e) => e.includes("lean-toolchain is")).length, 3);
  const otherTag = lakefile.replace(
    '"https://github.com/leanprover/verso" @ "v4.34.0"',
    '"https://github.com/leanprover/verso" @ "v4.33.0"',
  );
  assert(otherTag !== lakefile);
  assertContains(
    checkConsistency(manifest, otherTag, toolchain),
    "`require verso` is pinned to 'v4.33.0'",
  );
  for (
    const text of [
      "",
      "leanprover/lean4:nightly\n",
      "other/toolchain:v4.34.0\n",
      "v4.34.0\n",
    ]
  ) {
    assertContains(
      checkConsistency(manifest, lakefile, text),
      "unrecognised content",
    );
  }
  assertContains(
    checkConsistency(
      manifestWith({ inputRev: "v4.33.0" }),
      lakefile,
      toolchain,
    ),
    "inputRev",
  );
  assertContains(
    checkConsistency(
      manifestWith({ url: "https://github.com/leanprover/mathlib4" }),
      lakefile,
      toolchain,
    ),
    "manifest url",
  );
  const missing = readRealManifest();
  missing["packages"] = packagesOf(missing).filter((p) =>
    p["name"] !== "cslib"
  );
  assertContains(
    checkConsistency(missing, lakefile, toolchain),
    "no package named 'cslib'",
  );
  assertContains(
    checkConsistency(manifestWith({ inherited: true }), lakefile, toolchain),
    "inherited: false",
  );
  const commented = lakefile.replace(
    "require cslib from git",
    "-- require cslib from git",
  );
  assertContains(
    checkConsistency(manifest, commented, toolchain),
    "missing `require cslib`",
  );
  assertContains(
    checkConsistency(
      manifest,
      `${lakefile}\nrequire local from "../elsewhere"\n`,
      toolchain,
    ),
    "not of the form",
  );
  assertContains(
    checkConsistency(
      manifest,
      `${lakefile}\nrequire extra from git "https://github.com/evil/extra" @ "v1"\n`,
      toolchain,
    ),
    "evil",
  );
  assertContains(
    checkConsistency(
      manifestWithTopLevel({ name: "evil" }),
      lakefile,
      toolchain,
    ),
    "manifest `name` 'evil' != lakefile package 'k7pl'",
  );
  assertContains(
    checkConsistency(manifest, `${lakefile}\npackage other\n`, toolchain),
    "expected one `package` declaration, found 2",
  );
  assertContains(
    checkConsistency(
      manifestChanging("batteries", { inherited: false }),
      lakefile,
      toolchain,
    ),
    "batteries: not inherited, but no `require`",
  );
});

Deno.test("a well-formed rev is not caught offline", () => {
  // Documents the limit that --check-upstream exists for.
  assertEquals(
    checkManifest(manifestChanging("batteries", { rev: "0".repeat(40) })),
    [],
  );
});

Deno.test("clean replaces every non-printable character", () => {
  assertEquals(clean("a\nb\rc\td\x00e\u2028f\x85g"), "a?b?c?d?e?f?g");
  assertEquals(clean("plain text: ok"), "plain text: ok");
});

Deno.test("injected workflow commands are sanitised by clean", () => {
  // The command entry point cleans every error before
  // printing it as ::error::, so a newline taken from the
  // manifest cannot start a command of its own.
  const payload = "x\n::notice::pwned\n::add-mask::secret";
  const errors = checkManifest(
    manifestChanging("batteries", { name: payload }),
  );
  assertContains(errors, "`name` must match");
  for (const error of errors) {
    assert(!clean(error).includes("\n"));
    assert(!clean(error).startsWith("::notice"));
  }
});

async function withTempDir(
  fn: (dir: string) => void | Promise<void>,
): Promise<void> {
  const dir = Deno.makeTempDirSync();
  try {
    await fn(dir);
  } finally {
    Deno.removeSync(dir, { recursive: true });
  }
}

function writeRoot(
  dir: string,
  manifest: Manifest,
  lakefile = readRealLakefile(),
  toolchain = readRealToolchain(),
): void {
  Deno.writeTextFileSync(`${dir}/lake-manifest.json`, JSON.stringify(manifest));
  Deno.writeTextFileSync(`${dir}/lakefile.lean`, lakefile);
  Deno.writeTextFileSync(`${dir}/lean-toolchain`, toolchain);
}

Deno.test("run on a temporary copy of the real files", async () => {
  await withTempDir(async (dir) => {
    writeRoot(dir, readRealManifest());
    assertEquals(
      await runCheckManifest(dir, null, { lsRemote: noNetwork }),
      [],
    );
    assertEquals(
      await runCheckManifest(dir, null, { lsRemote: noNetwork }),
      await runCheckManifest(REPO_ROOT, null, { lsRemote: noNetwork }),
    );
    writeRoot(dir, manifestWith({ rev: "abc1234" }));
    const errors = await runCheckManifest(dir, null, { lsRemote: noNetwork });
    assertContains(errors, "40 lowercase hexadecimal");
  });
});

Deno.test("the manifest option checks another file against the repository pins", async () => {
  await withTempDir(async (dir) => {
    writeRoot(dir, readRealManifest());
    const other = `${dir}/elsewhere.json`;
    Deno.writeTextFileSync(
      other,
      JSON.stringify(manifestWith({ rev: "abc1234" })),
    );
    const errors = await runCheckManifest(dir, other, { lsRemote: noNetwork });
    assertContains(errors, "40 lowercase hexadecimal");
    assertEquals(
      await runCheckManifest(dir, null, { lsRemote: noNetwork }),
      [],
    );
  });
});

Deno.test("malformed manifest inputs fail cleanly", async () => {
  await withTempDir(async (dir) => {
    writeRoot(dir, readRealManifest());
    const path = `${dir}/lake-manifest.json`;
    Deno.writeTextFileSync(path, "{not json");
    assertContains(
      await runCheckManifest(dir, null, { lsRemote: noNetwork }),
      "is not valid JSON",
    );
    Deno.removeSync(path);
    assertContains(
      await runCheckManifest(dir, null, { lsRemote: noNetwork }),
      "is not a regular file",
    );
    assertThrowsWith(
      () => loadManifest(`${dir}/missing.json`),
      "is not a regular file",
    );
  });
});

Deno.test("an oversized manifest is refused for its size", async () => {
  await withTempDir(async (dir) => {
    writeRoot(dir, readRealManifest());
    const path = `${dir}/lake-manifest.json`;
    const withPadding = (total: number): string => {
      const document = { ...readRealManifest(), padding: "" };
      const base = JSON.stringify(document).length;
      document["padding"] = "x".repeat(total - base);
      const text = JSON.stringify(document);
      assertEquals(text.length, total);
      return text;
    };
    Deno.writeTextFileSync(path, withPadding(MAX_MANIFEST_BYTES + 1));
    const over = await runCheckManifest(dir, null, { lsRemote: noNetwork });
    assertContains(over, "is larger than");
    assert(!over.some((e) => e.includes("is not valid JSON")));
    Deno.writeTextFileSync(path, withPadding(MAX_MANIFEST_BYTES));
    const under = await runCheckManifest(dir, null, { lsRemote: noNetwork });
    assert(!under.some((e) => e.includes("is larger than")));
    assertContains(under, "unknown top-level key");
  });
});

Deno.test("deeply nested and symlinked manifests fail cleanly", async () => {
  await withTempDir((dir) => {
    const nested = `${dir}/nested.json`;
    Deno.writeTextFileSync(nested, "[".repeat(100_000) + "]".repeat(100_000));
    assertThrowsWith(() => loadManifest(nested), "is not valid JSON");
    const target = `${dir}/target.json`;
    Deno.writeTextFileSync(target, JSON.stringify(readRealManifest()));
    const link = `${dir}/link.json`;
    Deno.symlinkSync(target, link);
    assertThrowsWith(() => loadManifest(link), "is not a regular file");
  });
});

Deno.test("a new dependency is refused with the way to accept it", async () => {
  await withTempDir(async (dir) => {
    const manifest = readRealManifest();
    const batteries = packagesOf(manifest).find((p) =>
      p["name"] === "batteries"
    )!;
    packagesOf(manifest).push({ ...batteries, name: "newdep" });
    writeRoot(dir, manifest);
    const errors = await runCheckManifest(dir, null, { lsRemote: noNetwork });
    assertContains(errors, "newdep: not one of the known packages");
    // The command entry point prints the hint for this case.
    const code = await runCheckManifestCommand(["--root", dir]);
    assertEquals(code, 1);
  });
});

function upstreamFrom(
  manifest: Manifest,
  peeled: ReadonlySet<string> = new Set(),
): LsRemote {
  const byUrl = new Map<string, Package>();
  for (const p of packagesOf(manifest)) byUrl.set(p["url"] as string, p);
  return (url, tag) => {
    const package_ = byUrl.get(url)!;
    if (peeled.has(package_["name"] as string)) {
      return [
        `${"f".repeat(40)}\trefs/tags/${tag}`,
        `${package_["rev"]}\trefs/tags/${tag}^{}`,
      ];
    }
    return [`${package_["rev"]}\trefs/tags/${tag}`];
  };
}

Deno.test("matching lightweight and annotated tags pass", async () => {
  const manifest = readRealManifest();
  assertEquals(await checkTags(manifest, upstreamFrom(manifest)), []);
  assertEquals(
    await checkTags(manifest, upstreamFrom(manifest, new Set(DIRECT))),
    [],
  );
});

Deno.test("tag failures are rejected", async () => {
  const manifest = readRealManifest();
  const altered = manifestWith({ rev: "0".repeat(40) });
  const errors = await checkTags(altered, upstreamFrom(manifest));
  assert(
    errors.some((e) =>
      e.includes("mathlib") && e.includes("!= upstream commit")
    ),
    JSON.stringify(errors),
  );
  const missing = await checkTags(manifest, () => []);
  assertEquals(
    missing.filter((e) => e.includes("not found upstream")).length,
    3,
  );
  const failing: LsRemote = () => {
    throw new Error("no network");
  };
  const failed = await checkTags(manifest, failing);
  assertEquals(failed.filter((e) => e.includes("could not query")).length, 3);
});

Deno.test("only direct dependencies are queried, and bad urls and tags never are", async () => {
  const manifest = readRealManifest();
  const queried: string[] = [];
  const recording: LsRemote = (url, tag) => {
    queried.push(url);
    return upstreamFrom(manifest)(url, tag);
  };
  await checkTags(manifest, recording);
  const directUrls = new Set(
    packagesOf(manifest).filter((p) => p["inherited"] === false).map((p) =>
      p["url"] as string
    ),
  );
  assertEquals(new Set(queried), directUrls);
  assertEquals(queried.length, 3);

  const queriedBy = async (mutated: Manifest) => {
    const seen: Array<[string, string]> = [];
    const upstream = upstreamFrom(manifest);
    const rec: LsRemote = (url, tag) => {
      seen.push([url, tag]);
      return directUrls.has(url) ? upstream(url, tag) : [];
    };
    return { errors: await checkTags(mutated, rec), seen };
  };
  const evil = "https://github.com/evil/mathlib4";
  const evilResult = await queriedBy(manifestWith({ url: evil }));
  assertContains(evilResult.errors, "allow-list");
  assert(!evilResult.seen.some(([url]) => url === evil));
  assertEquals(evilResult.seen.length, 2);
  for (const tag of ["--upload-pack=evil", "-x", "v1 v2", "", "../x"]) {
    const result = await queriedBy(manifestWith({ inputRev: tag }));
    assertContains(result.errors, "not a plain tag name");
    assert(!result.seen.some(([, t]) => t === tag));
    assertEquals(result.seen.length, 2);
  }
});

function upstreamDocuments(manifest: Manifest): Map<string, Uint8Array> {
  const encoder = new TextEncoder();
  const direct = packagesOf(manifest).filter((p) => p["inherited"] === false);
  const inherited = packagesOf(manifest).filter((p) => p["inherited"] === true);
  const documents = new Map<string, Uint8Array>();
  direct.forEach((parent, index) => {
    const listed = inherited.filter((p, position) =>
      position % direct.length === index || p["name"] === "batteries"
    ).map((p) => ({ name: p["name"], url: p["url"], rev: p["rev"] }));
    const url = upstreamManifestUrl(
      parent["url"] as string,
      parent["rev"] as string,
    );
    documents.set(
      url,
      encoder.encode(JSON.stringify({ version: "1.2.0", packages: listed })),
    );
  });
  return documents;
}

class FakeUpstream {
  calls: string[] = [];
  constructor(private documents: Map<string, Uint8Array>) {}
  fetch: Fetch = (url) => {
    this.calls.push(url);
    const body = this.documents.get(url);
    if (body === undefined) {
      throw new Error(`no such upstream document: ${url}`);
    }
    return body;
  };
}

Deno.test("a faithful upstream is accepted", async () => {
  const manifest = readRealManifest();
  const fake = new FakeUpstream(upstreamDocuments(manifest));
  assertEquals(await checkUpstream(manifest, new Set(DIRECT), fake.fetch), []);
  assertEquals(fake.calls.length, 3);
  for (
    const parent of packagesOf(manifest).filter((p) =>
      DIRECT.includes(p["name"] as typeof DIRECT[number])
    )
  ) {
    const ownerRepo = (parent["url"] as string).replace(
      "https://github.com/",
      "",
    );
    assert(fake.calls.includes(
      `https://raw.githubusercontent.com/${ownerRepo}/${
        parent["rev"]
      }/lake-manifest.json`,
    ));
  }
});

Deno.test("upstream mismatches and unlisted packages are refused", async () => {
  const manifest = readRealManifest();
  const forged = manifestChanging("batteries", { rev: "0".repeat(40) });
  const errors = await checkUpstream(
    forged,
    new Set(DIRECT),
    new FakeUpstream(upstreamDocuments(manifest)).fetch,
  );
  assertEquals(errors.length, 1);
  assert(
    errors[0].startsWith("batteries:") &&
      errors[0].includes("differ from upstream"),
  );

  const urlForged = manifestChanging("batteries", {
    url: "https://github.com/leanprover-community/mathlib4",
  });
  const urlErrors = await checkUpstream(
    urlForged,
    new Set(DIRECT),
    new FakeUpstream(upstreamDocuments(manifest)).fetch,
  );
  assert(
    urlErrors.some((e) =>
      e.startsWith("batteries:") && e.includes("differ from upstream")
    ),
  );

  const documents = upstreamDocuments(manifest);
  const withoutAesop = new Map<string, Uint8Array>();
  for (const [url, body] of documents) {
    const document = JSON.parse(new TextDecoder().decode(body)) as Manifest;
    document["packages"] = (document["packages"] as Package[]).filter(
      (p) => p["name"] !== "aesop",
    );
    withoutAesop.set(url, new TextEncoder().encode(JSON.stringify(document)));
  }
  assertEquals(
    await checkUpstream(
      manifest,
      new Set(DIRECT),
      new FakeUpstream(withoutAesop).fetch,
    ),
    ["aesop: not listed by the manifest of any verified direct dependency"],
  );
});

Deno.test("a package listed only by an unverified dependency is refused", async () => {
  const manifest = readRealManifest();
  const documents = upstreamDocuments(manifest);
  const names = (isVerso: boolean): Set<string> => {
    const out = new Set<string>();
    for (const [url, body] of documents) {
      if (url.includes("/verso/") !== isVerso) continue;
      const document = JSON.parse(new TextDecoder().decode(body)) as Manifest;
      for (const p of document["packages"] as Package[]) {
        out.add(p["name"] as string);
      }
    }
    return out;
  };
  const onlyInVerso = new Set(
    [...names(true)].filter((n) => !names(false).has(n)),
  );
  assert(onlyInVerso.size > 0);
  const fake = new FakeUpstream(documents);
  const errors = await checkUpstream(
    manifest,
    new Set(["mathlib", "cslib"]),
    fake.fetch,
  );
  assertEquals(fake.calls.length, 2);
  assert(!fake.calls.some((url) => url.includes("/verso/")));
  assertEquals(new Set(errors.map((e) => e.split(":")[0])), onlyInVerso);
});

Deno.test("unreadable or malformed upstream manifests are refused", async () => {
  const manifest = readRealManifest();
  const answers: Array<[string, Uint8Array | Error]> = [
    ["os error", new Error("boom")],
    ["not json", new TextEncoder().encode("not json")],
    ["not utf-8", new Uint8Array([0xff, 0xfe])],
    ["no list", new TextEncoder().encode('{"packages": 3}')],
    ["not an object", new TextEncoder().encode("[]")],
  ];
  for (const [label, answer] of answers) {
    const fetch: Fetch = () => {
      if (answer instanceof Error) throw answer;
      return answer;
    };
    const errors = await checkUpstream(manifest, new Set(DIRECT), fetch);
    assert(
      errors.some((e) => e.startsWith("mathlib:")),
      `${label}: ${JSON.stringify(errors)}`,
    );
    assert(errors.some((e) => e.includes("not listed")), label);
  }
});

Deno.test("the manifest of an unverified or invalid dependency is never fetched", async () => {
  const manifest = readRealManifest();
  const fake = new FakeUpstream(upstreamDocuments(manifest));
  const errors = await checkUpstream(manifest, new Set(), fake.fetch);
  assertEquals(fake.calls, []);
  assert(errors.length > 0);
  const fake2 = new FakeUpstream(upstreamDocuments(manifest));
  const invalid = manifestChanging("mathlib", { rev: "main" });
  const errors2 = await checkUpstream(invalid, new Set(DIRECT), fake2.fetch);
  assert(!fake2.calls.some((url) => url.includes("/mathlib4/main/")));
  assert(errors2.some((e) => e.includes("not fetching the upstream manifest")));
});

Deno.test("the default fetch only talks https to the raw host and bounds the size", async () => {
  for (
    const url of [
      "http://raw.githubusercontent.com/a/b/c/lake-manifest.json",
      "https://evil.example/a/b/c/lake-manifest.json",
      "https://raw.githubusercontent.com.evil.example/a/b/c/lake-manifest.json",
      "file:///etc/passwd",
    ]
  ) {
    let caught: unknown;
    try {
      await fetchUpstreamManifest(url);
    } catch (error) {
      caught = error;
    }
    assert(
      caught instanceof Error && caught.message.includes("refusing to fetch"),
      url,
    );
  }
  const originalFetch = globalThis.fetch;
  try {
    globalThis.fetch = () =>
      Promise.resolve(
        new Response("x".repeat(MAX_MANIFEST_BYTES + 1)),
      );
    let caught: unknown;
    try {
      await fetchUpstreamManifest(
        "https://raw.githubusercontent.com/a/b/c/lake-manifest.json",
      );
    } catch (error) {
      caught = error;
    }
    assert(
      caught instanceof Error && caught.message.includes("is larger than"),
    );
    globalThis.fetch = () => Promise.resolve(new Response("{}"));
    assertEquals(
      await fetchUpstreamManifest(
        "https://raw.githubusercontent.com/a/b/c/lake-manifest.json",
      ),
      new TextEncoder().encode("{}"),
    );
  } finally {
    globalThis.fetch = originalFetch;
  }
});

Deno.test("validatedManifest accepts the real manifest and rejects a bad one", () => {
  const manifest = readRealManifest();
  assertEquals(
    validatedManifest(manifest, readRealLakefile(), readRealToolchain()),
    manifest,
  );
  assertThrowsWith(
    () =>
      validatedManifest(
        manifestWith({ rev: "abc" }),
        readRealLakefile(),
        readRealToolchain(),
      ),
    "invalid Lake manifest",
  );
});

Deno.test("the Paperproof workspace has its own allow-list", async () => {
  const manifest = readPaperproofManifest();
  const lakefile = Deno.readTextFileSync(
    `${REPO_ROOT}/tools/paperproof-export/lakefile.lean`,
  );
  const toolchain = Deno.readTextFileSync(
    `${REPO_ROOT}/tools/paperproof-export/lean-toolchain`,
  );
  assertEquals(checkManifest(manifest, PAPERPROOF_WORKSPACE), []);
  assertEquals(
    checkConsistency(manifest, lakefile, toolchain, PAPERPROOF_WORKSPACE),
    [],
  );
  const real: Record<string, string> = {};
  for (const p of packagesOf(manifest)) {
    real[p["name"] as string] = (p["url"] as string).replace(
      "https://github.com/",
      "",
    );
  }
  // Dict equality in Python is order-insensitive; compare sorted entries.
  assertEquals(
    Object.entries(PAPERPROOF_ALLOWED_PACKAGES).sort(),
    Object.entries(real).sort(),
  );
  for (
    const [name, repository] of Object.entries(PAPERPROOF_ALLOWED_PACKAGES)
  ) {
    if (name in ALLOWED_PACKAGES) {
      assertEquals(repository, ALLOWED_PACKAGES[name]);
    }
  }
  const paperproof = packagesOf(manifest).find((p) =>
    p["name"] === "Paperproof"
  )!;
  const rootWithPaperproof = readRealManifest();
  packagesOf(rootWithPaperproof).push({ ...paperproof, inherited: true });
  assertContains(
    checkManifest(rootWithPaperproof),
    "Paperproof: not one of the known packages",
  );
  for (const name of ["cslib", "verso", "subverso", "MD4Lean", "illuminate"]) {
    const rootPackage = packagesOf(readRealManifest()).find((p) =>
      p["name"] === name
    )!;
    const pp = readPaperproofManifest();
    packagesOf(pp).push({ ...rootPackage, inherited: true });
    assertContains(
      checkManifest(pp, PAPERPROOF_WORKSPACE),
      `${name}: not one of the known packages`,
    );
  }
  // The Paperproof manifest, reached by its own path, passes offline…
  const ppPath = `${REPO_ROOT}/tools/paperproof-export/lake-manifest.json`;
  assertEquals(
    await runCheckManifest(REPO_ROOT, ppPath, { lsRemote: noNetwork }),
    [],
  );
  // …but the network checks are refused for it, root workspace only.
  const refused = await runCheckManifest(REPO_ROOT, ppPath, {
    tags: true,
    lsRemote: noNetwork,
  });
  assertContains(refused, "root workspace only");
});

Deno.test("check-manifest command usage handling", async () => {
  assertEquals(await runCheckManifestCommand(["--help"]), 0);
  assertEquals(await runCheckManifestCommand(["--no-such-option"]), 2);
  assertEquals(await runCheckManifestCommand(["--root"]), 2);
});
