// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Bounded consistency audit for the K7PL Lake dependency inventory.
 *
 * Port of tools/Compliance/SbomAudit.lean (+ SbomAuditMain.lean for the
 * CLI shape). The control is kept: it checks a narrow contract between
 * the repository's Lake manifest and K7PL's scoped SPDX 2.3 inventory.
 * It is not a general SPDX validator and does not infer dependency
 * edges, discover omitted packages, establish licence compatibility,
 * or query vulnerability databases.
 *
 * Why a Deno port: the Lean version's theorems (verifyContract_sound /
 * complete) are about the *normalized* model only; its own report
 * limitations state that JSON parsing, file I/O, toolchain integrity
 * and external validation are outside the theorem. Moving the
 * executable check to the controller therefore loses no proof about
 * real inputs, and removes a Lean build target plus an axiom-audit
 * surface from the implementation job. The Lean sources stay live
 * until the wiring slice replaces `lake exe sbomAudit` callers
 * (verify_sbom_audit.sh, sbom_evidence.py) with this module.
 *
 * Behaviour notes (approximations, all fail-closed):
 * - JSON parse error messages come from the JS parser, not Lean's;
 *   the status (ERROR) and rule ids (INPUT-JSON-MANIFEST/SPDX) are
 *   preserved exactly.
 * - Missing/wrong-typed fields produce INPUT-SHAPE with a message
 *   naming the field; Lean's getObjValAs? wording differs.
 * - Report JSON key order follows the Lean structure field order.
 */

export interface ManifestPackage {
  name: string;
  url: string;
  rev: string;
}

export interface SbomPackage {
  name: string;
  spdxId: string;
  versionInfo: string;
  downloadLocation: string;
  licenseDeclared: string;
  licenseConcluded: string;
  copyrightText: string;
}

export interface SbomRelationship {
  spdxElementId: string;
  relationshipType: string;
  relatedSpdxElement: string;
}

export interface AuditInput {
  manifestName: string;
  manifestPackages: ManifestPackage[];
  spdxVersion: string;
  documentId: string;
  packages: SbomPackage[];
  relationships: SbomRelationship[];
}

export interface Diagnostic {
  ruleId: string;
  severity: string;
  message: string;
  artifact: string;
}

export interface AuditReport {
  schemaVersion: string;
  tool: string;
  toolVersion: string;
  status: string;
  assuranceScope: string;
  sourceArtifacts: string[];
  limitations: string[];
  diagnostics: Diagnostic[];
}

/** Whitespace code points removed by Python 3.13's str.strip(). */
const INVENTORY_WHITESPACE = new Set([
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
]);

export function hasNonWhitespace(value: string): boolean {
  for (const ch of value) {
    if (!INVENTORY_WHITESPACE.has(ch.codePointAt(0)!)) return true;
  }
  return false;
}

export function validRevision(revision: string): boolean {
  return revision.length === 40 && /^[0-9a-f]+$/.test(revision);
}

function allDistinct(values: string[]): boolean {
  return new Set(values).size === values.length;
}

export function sameComponent(
  manifestPackage: ManifestPackage,
  sbomPackage: SbomPackage,
): boolean {
  return manifestPackage.name === sbomPackage.name &&
    manifestPackage.url === sbomPackage.downloadLocation &&
    manifestPackage.rev === sbomPackage.versionInfo;
}

export function sameInventory(input: AuditInput): boolean {
  return input.manifestPackages.length === input.packages.length &&
    input.manifestPackages.every((item) =>
      input.packages.some((pkg) => sameComponent(item, pkg))
    ) &&
    input.packages.every((item) =>
      input.manifestPackages.some((source) => sameComponent(source, item))
    );
}

export function verifyContract(input: AuditInput): boolean {
  return input.manifestName === "k7pl" &&
    input.spdxVersion === "SPDX-2.3" &&
    input.documentId === "SPDXRef-DOCUMENT" &&
    input.manifestPackages.length > 0 &&
    allDistinct(input.manifestPackages.map((item) => item.name)) &&
    input.manifestPackages.every((item) =>
      hasNonWhitespace(item.name) && item.url !== ""
    ) &&
    allDistinct(input.packages.map((item) => item.name)) &&
    input.packages.every((item) =>
      hasNonWhitespace(item.name) && item.downloadLocation !== ""
    ) &&
    allDistinct(input.packages.map((item) => item.spdxId)) &&
    input.packages.every((item) =>
      item.spdxId !== "" && item.spdxId !== "SPDXRef-DOCUMENT"
    ) &&
    input.manifestPackages.every((item) => validRevision(item.rev)) &&
    sameInventory(input) &&
    input.packages.every((item) =>
      item.licenseDeclared === "NOASSERTION" &&
      item.licenseConcluded === "NOASSERTION" &&
      item.copyrightText === "NOASSERTION"
    ) &&
    input.relationships.length === input.packages.length &&
    allDistinct(
      input.relationships.map((item) => item.relatedSpdxElement),
    ) &&
    input.relationships.every((item) =>
      item.spdxElementId === "SPDXRef-DOCUMENT" &&
      item.relationshipType === "DESCRIBES" &&
      input.packages.some((pkg) => pkg.spdxId === item.relatedSpdxElement)
    ) &&
    input.packages.every((pkg) =>
      input.relationships.some((rel) => rel.relatedSpdxElement === pkg.spdxId)
    );
}

function diagnostic(
  ruleId: string,
  message: string,
  artifact: string,
): Diagnostic {
  return { ruleId, severity: "error", message, artifact };
}

export function auditIssues(input: AuditInput): Diagnostic[] {
  const issues: Diagnostic[] = [];
  const push = (cond: boolean, d: Diagnostic) => {
    if (!cond) issues.push(d);
  };
  push(
    input.manifestName === "k7pl",
    diagnostic(
      "SBOM-MANIFEST-IDENTITY",
      "The Lake manifest name must be k7pl.",
      "lake-manifest.json",
    ),
  );
  push(
    input.spdxVersion === "SPDX-2.3",
    diagnostic(
      "SBOM-SPDX-VERSION",
      "The document must declare SPDX-2.3 for this prototype.",
      "spdx",
    ),
  );
  push(
    input.documentId === "SPDXRef-DOCUMENT",
    diagnostic(
      "SBOM-DOCUMENT-ID",
      "The document ID must be SPDXRef-DOCUMENT.",
      "spdx",
    ),
  );
  if (input.manifestPackages.length === 0) {
    issues.push(diagnostic(
      "SBOM-EMPTY-INVENTORY",
      "The Lake manifest must contain at least one package for this K7PL audit profile.",
      "lake-manifest.json",
    ));
  }
  push(
    allDistinct(input.manifestPackages.map((item) => item.name)),
    diagnostic(
      "SBOM-MANIFEST-DUPLICATE-NAME",
      "The Lake manifest contains duplicate package names.",
      "lake-manifest.json",
    ),
  );
  push(
    input.manifestPackages.every((item) =>
      hasNonWhitespace(item.name) && item.url !== ""
    ),
    diagnostic(
      "SBOM-MANIFEST-EMPTY-IDENTITY",
      "A manifest package has an empty or whitespace-only name, or an empty repository URL.",
      "lake-manifest.json",
    ),
  );
  push(
    allDistinct(input.packages.map((item) => item.name)),
    diagnostic(
      "SBOM-DUPLICATE-PACKAGE-NAME",
      "The SPDX inventory contains duplicate package names.",
      "spdx",
    ),
  );
  push(
    input.packages.every((item) =>
      hasNonWhitespace(item.name) && item.downloadLocation !== ""
    ),
    diagnostic(
      "SBOM-PACKAGE-EMPTY-IDENTITY",
      "An SPDX package has an empty or whitespace-only name, or an empty download location.",
      "spdx",
    ),
  );
  push(
    allDistinct(input.packages.map((item) => item.spdxId)),
    diagnostic(
      "SBOM-DUPLICATE-SPDX-ID",
      "The SPDX inventory contains duplicate package identifiers.",
      "spdx",
    ),
  );
  push(
    input.packages.every((item) =>
      item.spdxId !== "" && item.spdxId !== "SPDXRef-DOCUMENT"
    ),
    diagnostic(
      "SBOM-PACKAGE-ID",
      "A package identifier is empty or conflicts with the document identifier.",
      "spdx",
    ),
  );
  push(
    input.manifestPackages.every((item) => validRevision(item.rev)),
    diagnostic(
      "SBOM-REVISION-FORMAT",
      "A Lake revision is not forty lowercase hexadecimal characters.",
      "lake-manifest.json",
    ),
  );
  push(
    sameInventory(input),
    diagnostic(
      "SBOM-INVENTORY-MISMATCH",
      "Package names, URLs, and exact resolved revisions must be preserved.",
      "lake-manifest.json;spdx",
    ),
  );
  push(
    input.packages.every((item) =>
      item.licenseDeclared === "NOASSERTION" &&
      item.licenseConcluded === "NOASSERTION" &&
      item.copyrightText === "NOASSERTION"
    ),
    diagnostic(
      "SBOM-UNKNOWN-LICENSE-ASSERTION",
      "Unknown licence and copyright facts must remain NOASSERTION.",
      "spdx",
    ),
  );
  push(
    input.relationships.length === input.packages.length,
    diagnostic(
      "SBOM-RELATIONSHIP-COUNT",
      "Exactly one DESCRIBES relationship per package is required.",
      "spdx",
    ),
  );
  push(
    allDistinct(
      input.relationships.map((item) => item.relatedSpdxElement),
    ),
    diagnostic(
      "SBOM-DUPLICATE-RELATIONSHIP-TARGET",
      "A package is the target of more than one relationship.",
      "spdx",
    ),
  );
  push(
    input.relationships.every((item) =>
      item.spdxElementId === "SPDXRef-DOCUMENT" &&
      item.relationshipType === "DESCRIBES" &&
      input.packages.some((pkg) => pkg.spdxId === item.relatedSpdxElement)
    ),
    diagnostic(
      "SBOM-RELATIONSHIP-INVALID",
      "Only SPDXRef-DOCUMENT DESCRIBES relationships to existing package IDs are in scope; dependency edges must not be invented.",
      "spdx",
    ),
  );
  push(
    input.packages.every((pkg) =>
      input.relationships.some((rel) => rel.relatedSpdxElement === pkg.spdxId)
    ),
    diagnostic(
      "SBOM-RELATIONSHIP-MISSING",
      "At least one package has no DESCRIBES relationship.",
      "spdx",
    ),
  );
  return issues;
}

export const REPORT_LIMITATIONS: string[] = [
  "This is not a complete SPDX 2.3 schema or semantic validator; validate the document independently.",
  "Only entries present in lake-manifest.json are covered; this check cannot prove the manifest is complete.",
  "The flattened Lake inventory does not establish a complete direct/transitive dependency graph.",
  "The theorem applies to the normalized Lean model; JSON parsing, file I/O, toolchain integrity and external validation are outside the theorem.",
  "No absence of vulnerabilities, licence compatibility, legal compliance, or production readiness is established.",
];

export function makeReport(
  manifestPath: string,
  sbomPath: string,
  status: string,
  issues: Diagnostic[],
): AuditReport {
  return {
    schemaVersion: "k7pl.compliance-report/v1",
    tool: "k7pl-sbom-audit",
    toolVersion: "0.1.0",
    status,
    assuranceScope:
      "Consistency of represented K7PL Lake package entries with the scoped SPDX 2.3 inventory contract.",
    sourceArtifacts: [manifestPath, sbomPath],
    limitations: REPORT_LIMITATIONS,
    diagnostics: issues,
  };
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function reqString(obj: unknown, key: string): string {
  if (!isRecord(obj) || typeof obj[key] !== "string") {
    throw new Error(`field '${key}' is missing or has the wrong type`);
  }
  return obj[key] as string;
}

function reqArray(obj: unknown, key: string): unknown[] {
  if (!isRecord(obj) || !Array.isArray(obj[key])) {
    throw new Error(`field '${key}' is not a JSON array`);
  }
  return obj[key] as unknown[];
}

export function parseAuditInput(
  manifestDocument: unknown,
  sbomDocument: unknown,
): AuditInput {
  const manifestPackages = reqArray(manifestDocument, "packages").map((v) => ({
    name: reqString(v, "name"),
    url: reqString(v, "url"),
    rev: reqString(v, "rev"),
  }));
  const packages = reqArray(sbomDocument, "packages").map((v) => ({
    name: reqString(v, "name"),
    spdxId: reqString(v, "SPDXID"),
    versionInfo: reqString(v, "versionInfo"),
    downloadLocation: reqString(v, "downloadLocation"),
    licenseDeclared: reqString(v, "licenseDeclared"),
    licenseConcluded: reqString(v, "licenseConcluded"),
    copyrightText: reqString(v, "copyrightText"),
  }));
  const relationships = reqArray(sbomDocument, "relationships").map((v) => ({
    spdxElementId: reqString(v, "spdxElementId"),
    relationshipType: reqString(v, "relationshipType"),
    relatedSpdxElement: reqString(v, "relatedSpdxElement"),
  }));
  return {
    manifestName: reqString(manifestDocument, "name"),
    manifestPackages,
    spdxVersion: reqString(sbomDocument, "spdxVersion"),
    documentId: reqString(sbomDocument, "SPDXID"),
    packages,
    relationships,
  };
}

export function auditTexts(
  manifestText: string,
  sbomText: string,
  manifestPath: string,
  sbomPath: string,
): AuditReport {
  let manifestDocument: unknown;
  try {
    manifestDocument = JSON.parse(manifestText);
  } catch (e) {
    return makeReport(manifestPath, sbomPath, "ERROR", [diagnostic(
      "INPUT-JSON-MANIFEST",
      `The Lake manifest is not valid JSON: ${
        e instanceof Error ? e.message : String(e)
      }`,
      manifestPath,
    )]);
  }
  let sbomDocument: unknown;
  try {
    sbomDocument = JSON.parse(sbomText);
  } catch (e) {
    return makeReport(manifestPath, sbomPath, "ERROR", [diagnostic(
      "INPUT-JSON-SPDX",
      `The SPDX input is not valid JSON: ${
        e instanceof Error ? e.message : String(e)
      }`,
      sbomPath,
    )]);
  }
  let input: AuditInput;
  try {
    input = parseAuditInput(manifestDocument, sbomDocument);
  } catch (e) {
    return makeReport(manifestPath, sbomPath, "ERROR", [diagnostic(
      "INPUT-SHAPE",
      `A required field is missing or has the wrong type: ${
        e instanceof Error ? e.message : String(e)
      }`,
      "inputs",
    )]);
  }
  const issues = auditIssues(input);
  const ok = verifyContract(input);
  const finalIssues = ok ? issues : (issues.length > 0 ? issues : [diagnostic(
    "SBOM-CONTRACT",
    "The normalized inputs do not satisfy the inventory contract.",
    "lake-manifest.json;spdx",
  )]);
  return makeReport(
    manifestPath,
    sbomPath,
    ok ? "PASS" : "FAIL",
    finalIssues,
  );
}

/** CLI runner (mirrors SbomAuditMain): returns exit code + compressed report JSON. */
export async function runSbomAudit(
  args: string[],
): Promise<{ exitCode: number; stdout: string }> {
  if (args.length !== 2) {
    const report = makeReport("lake-manifest.json", "spdx.json", "ERROR", [
      diagnostic(
        "USAGE",
        "Usage: lake exe sbomAudit -- <lake-manifest.json> <spdx-2.3.json>",
        "arguments",
      ),
    ]);
    return { exitCode: 2, stdout: JSON.stringify(report) };
  }
  const [manifestPath, sbomPath] = args;
  let manifestText: string;
  let sbomText: string;
  try {
    manifestText = await Deno.readTextFile(manifestPath);
    sbomText = await Deno.readTextFile(sbomPath);
  } catch {
    const report = makeReport(manifestPath, sbomPath, "ERROR", [diagnostic(
      "INPUT-READ",
      "Unable to read one or more input files.",
      "inputs",
    )]);
    return { exitCode: 2, stdout: JSON.stringify(report) };
  }
  const report = auditTexts(manifestText, sbomText, manifestPath, sbomPath);
  const exitCode = report.status === "PASS"
    ? 0
    : report.status === "FAIL"
    ? 1
    : 2;
  return { exitCode, stdout: JSON.stringify(report) };
}

if (import.meta.main) {
  const { exitCode, stdout } = await runSbomAudit(Deno.args);
  console.log(stdout);
  Deno.exit(exitCode);
}
