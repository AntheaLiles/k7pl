// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import {
  type AuditInput,
  auditIssues,
  auditTexts,
  hasNonWhitespace,
  parseAuditInput,
  runSbomAudit,
  verifyContract,
} from "../src/sbom_audit.ts";

const REV = "a".repeat(40);

const manifestPkg = {
  name: "alpha",
  url: "https://github.com/example/alpha",
  rev: REV,
};
const sbomPkg = {
  name: "alpha",
  spdxId: "SPDXRef-Dependency-alpha-aaaaaaaaaaaa",
  versionInfo: REV,
  downloadLocation: "https://github.com/example/alpha",
  licenseDeclared: "NOASSERTION",
  licenseConcluded: "NOASSERTION",
  copyrightText: "NOASSERTION",
};
const rel = {
  spdxElementId: "SPDXRef-DOCUMENT",
  relationshipType: "DESCRIBES",
  relatedSpdxElement: sbomPkg.spdxId,
};
function sample(): AuditInput {
  return {
    manifestName: "k7pl",
    manifestPackages: [{ ...manifestPkg }],
    spdxVersion: "SPDX-2.3",
    documentId: "SPDXRef-DOCUMENT",
    packages: [{ ...sbomPkg }],
    relationships: [{ ...rel }],
  };
}

Deno.test("valid normalized inventory passes with no diagnostics", () => {
  assert(verifyContract(sample()));
  assertEquals(auditIssues(sample()), []);
});

Deno.test("revision format is enforced", () => {
  const input = sample();
  input.manifestPackages = [{ ...manifestPkg, rev: "bad" }];
  assert(!verifyContract(input));
});

Deno.test("component revision and URL must be preserved", () => {
  const byRev = sample();
  byRev.packages = [{ ...sbomPkg, versionInfo: "b".repeat(40) }];
  assert(!verifyContract(byRev));
  const byUrl = sample();
  byUrl.packages = [
    { ...sbomPkg, downloadLocation: "https://example.invalid/alpha" },
  ];
  assert(!verifyContract(byUrl));
});

Deno.test("empty and whitespace-only identities are rejected", () => {
  const empty = sample();
  empty.packages = [{ ...sbomPkg, name: "" }];
  assert(!verifyContract(empty));
  for (const name of ["   ", "\u00a0"]) {
    const m = sample();
    m.manifestPackages = [{ ...manifestPkg, name }];
    assert(!verifyContract(m));
    const s = sample();
    s.packages = [{ ...sbomPkg, name }];
    assert(!verifyContract(s));
  }
  const mDiag = sample();
  mDiag.manifestPackages = [{ ...manifestPkg, name: "   " }];
  assert(
    auditIssues(mDiag).some((d) => d.ruleId === "SBOM-MANIFEST-EMPTY-IDENTITY"),
  );
  const sDiag = sample();
  sDiag.packages = [{ ...sbomPkg, name: "   " }];
  assert(
    auditIssues(sDiag).some((d) => d.ruleId === "SBOM-PACKAGE-EMPTY-IDENTITY"),
  );
});

Deno.test("Python 3.13 strip whitespace set is rejected, boundary points are not", () => {
  const strip = [
    0x0009,
    0x000a,
    0x000b,
    0x000c,
    0x000d,
    0x001c,
    0x001d,
    0x001e,
    0x001f,
    0x0020,
    0x0085,
    0x00a0,
    0x1680,
    0x2000,
    0x2001,
    0x2002,
    0x2003,
    0x2004,
    0x2005,
    0x2006,
    0x2007,
    0x2008,
    0x2009,
    0x200a,
    0x2028,
    0x2029,
    0x202f,
    0x205f,
    0x3000,
  ];
  for (const cp of strip) {
    const name = String.fromCodePoint(cp);
    assert(
      !hasNonWhitespace(name),
      `U+${cp.toString(16)} should be whitespace`,
    );
    const input = sample();
    input.manifestPackages = [{ ...manifestPkg, name }];
    input.packages = [{ ...sbomPkg, name }];
    assert(!verifyContract(input));
  }
  const boundary = [
    0x0008,
    0x000e,
    0x001b,
    0x0021,
    0x0084,
    0x0086,
    0x009f,
    0x00a1,
    0x167f,
    0x1681,
    0x1fff,
    0x200b,
    0x2027,
    0x202a,
    0x205e,
    0x3001,
    0xfeff,
  ];
  for (const cp of boundary) {
    const name = String.fromCodePoint(cp);
    assert(
      hasNonWhitespace(name),
      `U+${cp.toString(16)} should not be whitespace`,
    );
    const input = sample();
    input.manifestPackages = [{ ...manifestPkg, name }];
    input.packages = [{ ...sbomPkg, name }];
    assert(verifyContract(input));
  }
});

Deno.test("licence facts must stay NOASSERTION, invented edges rejected", () => {
  const lic = sample();
  lic.packages = [{ ...sbomPkg, licenseDeclared: "MIT" }];
  assert(!verifyContract(lic));
  const edge = sample();
  edge.relationships = [{ ...rel, relationshipType: "DEPENDS_ON" }];
  assert(!verifyContract(edge));
  const missing = sample();
  missing.relationships = [];
  assert(!verifyContract(missing));
  const dupRel = sample();
  dupRel.relationships = [{ ...rel }, { ...rel }];
  assert(!verifyContract(dupRel));
});

Deno.test("duplicate package ids and wrong SPDX version rejected", () => {
  const dup = sample();
  dup.packages = [{ ...sbomPkg }, { ...sbomPkg }];
  dup.relationships = [{ ...rel }, { ...rel }];
  assert(!verifyContract(dup));
  const ver = sample();
  ver.spdxVersion = "SPDX-2.2";
  assert(!verifyContract(ver));
});

Deno.test("invalid JSON reports ERROR, empty inventory reports FAIL", () => {
  assertEquals(
    auditTexts("{", "{}", "manifest.json", "spdx.json").status,
    "ERROR",
  );
  assertEquals(
    auditTexts(
      '{"name":"k7pl","packages":[]}',
      "{",
      "manifest.json",
      "spdx.json",
    )
      .status,
    "ERROR",
  );
  const empty = auditTexts(
    '{"name":"k7pl","packages":[]}',
    '{"spdxVersion":"SPDX-2.3","SPDXID":"SPDXRef-DOCUMENT","packages":[],"relationships":[]}',
    "manifest.json",
    "spdx.json",
  );
  assertEquals(empty.status, "FAIL");
  assert(
    empty.diagnostics.some((d) => d.ruleId === "SBOM-EMPTY-INVENTORY"),
  );
  assert(
    !verifyContract({
      ...sample(),
      manifestPackages: [],
      packages: [],
      relationships: [],
    }),
  );
});

Deno.test("missing required manifest field is rejected as INPUT-SHAPE", () => {
  const manifest = {
    name: "k7pl",
    packages: [{ name: "alpha", url: "https://github.com/example/alpha" }],
  };
  const sbom = {
    spdxVersion: "SPDX-2.3",
    SPDXID: "SPDXRef-DOCUMENT",
    packages: [],
    relationships: [],
  };
  let threw = false;
  try {
    parseAuditInput(manifest, sbom);
  } catch {
    threw = true;
  }
  assert(threw);
  const report = auditTexts(
    JSON.stringify(manifest),
    JSON.stringify(sbom),
    "manifest.json",
    "spdx.json",
  );
  assertEquals(report.status, "ERROR");
  assert(
    report.diagnostics.some((d) => d.ruleId === "INPUT-SHAPE"),
  );
});

Deno.test("CLI: usage and unreadable inputs exit 2, valid inputs exit 0", async () => {
  const usage = await runSbomAudit([]);
  assertEquals(usage.exitCode, 2);
  assert(JSON.parse(usage.stdout).diagnostics[0].ruleId === "USAGE");
  const missing = await runSbomAudit([
    "/nonexistent/manifest.json",
    "/nonexistent/sbom.json",
  ]);
  assertEquals(missing.exitCode, 2);
  assert(JSON.parse(missing.stdout).diagnostics[0].ruleId === "INPUT-READ");
  const dir = await Deno.makeTempDir();
  try {
    const manifestPath = `${dir}/lake-manifest.json`;
    const sbomPath = `${dir}/k7pl-lake.spdx.json`;
    const input = sample();
    await Deno.writeTextFile(
      manifestPath,
      JSON.stringify({
        name: input.manifestName,
        packages: input.manifestPackages,
      }),
    );
    await Deno.writeTextFile(
      sbomPath,
      JSON.stringify({
        spdxVersion: input.spdxVersion,
        SPDXID: input.documentId,
        // SPDX field names, not the TS interface names.
        packages: input.packages.map((p) => ({
          name: p.name,
          SPDXID: p.spdxId,
          versionInfo: p.versionInfo,
          downloadLocation: p.downloadLocation,
          licenseDeclared: p.licenseDeclared,
          licenseConcluded: p.licenseConcluded,
          copyrightText: p.copyrightText,
        })),
        relationships: input.relationships,
      }),
    );
    const ok = await runSbomAudit([manifestPath, sbomPath]);
    assertEquals(ok.exitCode, 0);
    const report = JSON.parse(ok.stdout);
    assertEquals(report.status, "PASS");
    assertEquals(report.tool, "k7pl-sbom-audit");
    assertEquals(report.diagnostics, []);
  } finally {
    await Deno.remove(dir, { recursive: true });
  }
});
