// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { sha256File } from "../src/file_digest.ts";
import {
  generateSbom,
  spdxJson,
  TOOL_NAME,
  TOOL_VERSION,
} from "../src/lake_to_spdx.ts";
import { loadWorkspaceInputs, PAPERPROOF_WORKSPACE } from "../src/manifest.ts";
import {
  checkReport,
  EvidenceError,
  inputSha256,
  main,
  mutateFirstRevision,
  pythonJson,
  runNegativeCases,
} from "../src/sbom_evidence.ts";
import type { AuditResult } from "../src/sbom_evidence.ts";

// Transcribed from scripts/ci/test_sbom_evidence.py (cutover C5).
// `lake exe sbomAudit` is replaced by a double that answers like
// the Lean executable; the Lean executable itself is exercised by
// the `impl` job of verify.yaml, not here.
//
// Two transcription adaptations, both behaviour-preserving for
// what these tests assert:
// - The Python tests are synchronous; the Deno pipeline is async
//   (subprocess and WebCrypto hashing), so the doubles and the
//   workspace helpers are async and the tests await them.
// - The Python tests capture stdout/stderr with
//   `contextlib.redirect_stdout/stderr`; here `main` prints with
//   `console.log`/`console.error`, which the workspace runner
//   temporarily replaces with capturing functions.

const REPO_ROOT = new URL("../../../", import.meta.url).pathname.replace(
  /\/$/,
  "",
);
const REAL_MANIFEST = JSON.parse(
  await Deno.readTextFile(`${REPO_ROOT}/lake-manifest.json`),
) as Record<string, unknown>;
const REAL_LAKEFILE = await Deno.readTextFile(`${REPO_ROOT}/lakefile.lean`);
const REAL_TOOLCHAIN = await Deno.readTextFile(`${REPO_ROOT}/lean-toolchain`);
const CREATED = "2026-10-10T00:00:00Z";
const PAPERPROOF_MANIFEST_PATH =
  `${REPO_ROOT}/tools/paperproof-export/lake-manifest.json`;

function leanReport(
  status = "PASS",
  diagnostics: string[] = [],
  sources: string[] = ["lake-manifest.json", "/tmp/k7pl-lake.spdx.json"],
): Record<string, unknown> {
  return {
    schemaVersion: "k7pl.compliance-report/v1",
    tool: "k7pl-sbom-audit",
    toolVersion: "0.1.0",
    status,
    assuranceScope: "scope",
    sourceArtifacts: sources,
    limitations: ["limit"],
    diagnostics: diagnostics.map((rule) => ({
      ruleId: rule,
      severity: "error",
      message: "m",
      artifact: "a",
    })),
  };
}

function assertThrowsEvidence(
  fn: () => unknown,
  pattern?: RegExp,
): void {
  try {
    fn();
  } catch (error) {
    assert(
      error instanceof EvidenceError,
      `expected EvidenceError, got ${error}`,
    );
    if (pattern) {
      assert(
        pattern.test(error.message),
        `expected error matching ${pattern}, got ${error.message}`,
      );
    }
    return;
  }
  throw new Error("expected function to throw EvidenceError");
}

async function assertRejectsEvidence(
  fn: () => Promise<unknown>,
  pattern?: RegExp,
): Promise<void> {
  try {
    await fn();
  } catch (error) {
    assert(
      error instanceof EvidenceError,
      `expected EvidenceError, got ${error}`,
    );
    if (pattern) {
      assert(
        pattern.test(error.message),
        `expected error matching ${pattern}, got ${error.message}`,
      );
    }
    return;
  }
  throw new Error("expected function to reject with EvidenceError");
}

async function exists(path: string): Promise<boolean> {
  try {
    await Deno.stat(path);
    return true;
  } catch {
    return false;
  }
}

function deepCopy<T>(value: T): T {
  return JSON.parse(JSON.stringify(value)) as T;
}

/** Answers like the Lean executable on the four negative inputs, PASS otherwise.
 *
 * ERROR/2 on unparsable JSON; FAIL/1 on an empty inventory, on a
 * blank package name, or on a revision that differs from
 * `manifest`. `overrides` maps a rule to the (exit status, report)
 * to answer instead, to model a broken executable.
 */
class FakeAudit {
  calls: [string, string][] = [];

  constructor(
    private manifest: Record<string, unknown>,
    private overrides: Record<string, [number, Record<string, unknown>]> = {},
  ) {}

  answer(
    key: string,
    code: number,
    report: Record<string, unknown>,
  ): AuditResult {
    const [overrideCode, overrideReport] = this.overrides[key] ??
      [code, report];
    return {
      code: overrideCode,
      stdout: JSON.stringify(overrideReport),
      stderr: "",
    };
  }

  async call(manifestPath: string, sbomPath: string): Promise<AuditResult> {
    this.calls.push([manifestPath, sbomPath]);
    let manifest: Record<string, unknown>;
    try {
      manifest = JSON.parse(await Deno.readTextFile(manifestPath));
    } catch (error) {
      if (error instanceof SyntaxError) {
        return this.answer(
          "malformed",
          2,
          leanReport("ERROR", ["INPUT-JSON-MANIFEST"]),
        );
      }
      throw error;
    }
    const sbom = JSON.parse(await Deno.readTextFile(sbomPath));
    const packages = manifest["packages"] as Record<string, unknown>[];
    if (packages.length === 0) {
      return this.answer(
        "empty",
        1,
        leanReport("FAIL", ["SBOM-EMPTY-INVENTORY"]),
      );
    }
    if (
      packages.some((item) => !(item["name"] as string).trim())
    ) {
      return this.answer(
        "blank",
        1,
        leanReport("FAIL", [
          "SBOM-MANIFEST-EMPTY-IDENTITY",
          "SBOM-PACKAGE-EMPTY-IDENTITY",
        ]),
      );
    }
    const manifestRevs = new Set(
      (this.manifest["packages"] as Record<string, unknown>[]).map((item) =>
        JSON.stringify([item["name"], item["rev"]])
      ),
    );
    const sbomRevs = new Set(
      (sbom["packages"] as Record<string, unknown>[]).map((item) =>
        JSON.stringify([item["name"], item["versionInfo"]])
      ),
    );
    const same = manifestRevs.size === sbomRevs.size &&
      [...manifestRevs].every((rev) => sbomRevs.has(rev));
    if (!same) {
      return this.answer(
        "mismatch",
        1,
        leanReport("FAIL", ["SBOM-INVENTORY-MISMATCH"]),
      );
    }
    return { code: 0, stdout: JSON.stringify(leanReport()), stderr: "" };
  }
}

interface WorkspaceOptions {
  manifest?: Record<string, unknown>;
  report?: Record<string, unknown> | null;
  pullRequestHead?: string | null;
}

/** A temporary RUNNER_TEMP holding the generated SBOM, the report and the event payload. */
class Workspace {
  dir!: string;
  manifestData!: Record<string, unknown>;
  manifest!: string;
  sbom!: string;
  report!: string;
  output!: string;
  summary!: string;
  event!: string;
  env!: Record<string, string>;

  static async create(options: WorkspaceOptions = {}): Promise<Workspace> {
    const ws = new Workspace();
    ws.dir = await Deno.makeTempDir();
    ws.manifestData = options.manifest ?? REAL_MANIFEST;
    ws.manifest = `${ws.dir}/lake-manifest.json`;
    await Deno.writeTextFile(ws.manifest, pythonJson(ws.manifestData));
    const sbom = await generateSbom(
      REAL_MANIFEST,
      REAL_LAKEFILE,
      REAL_TOOLCHAIN,
      CREATED,
    );
    ws.sbom = `${ws.dir}/k7pl-lake.spdx.json`;
    // The Python tests write the workspace SBOM with
    // `json.dumps(sbom, indent=2, sort_keys=True)`; the SPDX
    // port's `spdxJson` is exactly that text.
    await Deno.writeTextFile(ws.sbom, spdxJson(sbom));
    const report = options.report ??
      leanReport("PASS", [], ["lake-manifest.json", ws.sbom]);
    ws.report = `${ws.dir}/k7pl-sbom-audit.json`;
    await Deno.writeTextFile(ws.report, pythonJson(report));
    ws.output = `${ws.dir}/k7pl-sbom-evidence.json`;
    ws.summary = `${ws.dir}/summary.md`;
    ws.event = `${ws.dir}/event.json`;
    const head = options.pullRequestHead === undefined
      ? "a".repeat(40)
      : options.pullRequestHead;
    const event = head ? { pull_request: { head: { sha: head } } } : {};
    await Deno.writeTextFile(ws.event, pythonJson(event));
    ws.env = {
      RUNNER_TEMP: ws.dir,
      GITHUB_RUN_ID: "123",
      GITHUB_RUN_ATTEMPT: "2",
      GITHUB_SHA: "b".repeat(40),
      GITHUB_WORKFLOW: "Full Verification",
      GITHUB_EVENT_PATH: ws.event,
      GITHUB_STEP_SUMMARY: ws.summary,
    };
    return ws;
  }

  argv(): string[] {
    return [
      "--report",
      this.report,
      "--manifest",
      this.manifest,
      "--sbom",
      this.sbom,
      "--output",
      this.output,
      "--root",
      REPO_ROOT,
    ];
  }

  async run(
    audit?: (manifest: string, sbom: string) => Promise<AuditResult>,
    env?: Record<string, string>,
    extra: string[] = [],
  ): Promise<{ code: number; out: string; err: string }> {
    const originalLog = console.log;
    const originalError = console.error;
    let out = "";
    let err = "";
    console.log = (...args: unknown[]) => {
      out += args.map(String).join(" ") + "\n";
    };
    console.error = (...args: unknown[]) => {
      err += args.map(String).join(" ") + "\n";
    };
    try {
      const runner = audit ??
        ((manifest: string, sbom: string) =>
          new FakeAudit(this.manifestData).call(manifest, sbom));
      const code = await main(
        [...this.argv(), ...extra],
        env ?? this.env,
        runner,
      );
      return { code, out, err };
    } finally {
      console.log = originalLog;
      console.error = originalError;
    }
  }
}

async function withWorkspace<T>(
  fn: (ws: Workspace) => Promise<T>,
  options: WorkspaceOptions = {},
): Promise<T> {
  const ws = await Workspace.create(options);
  try {
    return await fn(ws);
  } finally {
    await Deno.remove(ws.dir, { recursive: true });
  }
}

Deno.test("a clean pass is accepted", () => {
  const report = leanReport();
  assert(checkReport(report) === report);
});

Deno.test("every deviation of the audit report is refused", () => {
  const cases: Record<string, Record<string, unknown>> = {
    schema: { schemaVersion: "other/v1" },
    tool: { tool: "other" },
    "tool version": { toolVersion: "" },
    "status FAIL": { status: "FAIL" },
    "status ERROR": { status: "ERROR" },
    diagnostics: { diagnostics: [{ ruleId: "X" }] },
    "manifest source": {
      sourceArtifacts: ["other.json", "/tmp/k7pl-lake.spdx.json"],
    },
    "sbom source": {
      sourceArtifacts: ["lake-manifest.json", "/tmp/other.spdx.json"],
    },
    "bare sbom name": {
      sourceArtifacts: ["lake-manifest.json", "k7pl-lake.spdx.json"],
    },
    "one source": { sourceArtifacts: ["lake-manifest.json"] },
  };
  for (const [label, change] of Object.entries(cases)) {
    try {
      assertThrowsEvidence(() => checkReport({ ...leanReport(), ...change }));
    } catch (error) {
      throw new Error(`case ${label}: ${error}`);
    }
  }
  for (
    const key of [
      "schemaVersion",
      "tool",
      "toolVersion",
      "status",
      "diagnostics",
      "sourceArtifacts",
    ]
  ) {
    const report = leanReport();
    delete report[key];
    assertThrowsEvidence(() => checkReport(report));
  }
  assertThrowsEvidence(() => checkReport([]));
});

const RECORDED_CASES = [
  { case: "malformed manifest JSON", exitCode: 2, status: "ERROR" },
  { case: "mutated package revision", exitCode: 1, status: "FAIL" },
  { case: "empty manifest and SPDX inventory", exitCode: 1, status: "FAIL" },
  {
    case: "Unicode blank package name (U+00A0)",
    exitCode: 1,
    status: "FAIL",
  },
];

Deno.test("the expected failures are recorded", async () => {
  await withWorkspace(async (ws) => {
    const audit = new FakeAudit(REAL_MANIFEST);
    const cases = await runNegativeCases(
      ws.manifest,
      ws.sbom,
      ws.dir,
      (manifest, sbom) => audit.call(manifest, sbom),
    );
    assertEquals(cases, RECORDED_CASES);
    assertEquals(audit.calls, [
      [`${ws.dir}/malformed-manifest.json`, ws.sbom],
      [ws.manifest, `${ws.dir}/mismatched.spdx.json`],
      [
        `${ws.dir}/empty-manifest.json`,
        `${ws.dir}/empty-inventory.spdx.json`,
      ],
      [
        `${ws.dir}/blank-name-manifest.json`,
        `${ws.dir}/blank-name.spdx.json`,
      ],
    ]);
  });
});

Deno.test("the negative inputs are those of the former inline step", async () => {
  await withWorkspace(async (ws) => {
    await runNegativeCases(
      ws.manifest,
      ws.sbom,
      ws.dir,
      (manifest, sbom) => new FakeAudit(REAL_MANIFEST).call(manifest, sbom),
    );
    const read = (name: string) => Deno.readTextFileSync(`${ws.dir}/${name}`);
    assertEquals(read("malformed-manifest.json"), "{");
    assertEquals(
      read("empty-manifest.json"),
      '{"name":"k7pl","packages":[]}',
    );
    assertEquals(JSON.parse(read("empty-inventory.spdx.json")), {
      spdxVersion: "SPDX-2.3",
      SPDXID: "SPDXRef-DOCUMENT",
      packages: [],
      relationships: [],
    });
    assertEquals(JSON.parse(read("blank-name-manifest.json")), {
      name: "k7pl",
      packages: [{
        name: "\u00a0",
        url: "https://github.com/example/alpha",
        rev: "a".repeat(40),
      }],
    });
    // json.dumps escapes the blank name.
    assertStringIncludes(read("blank-name-manifest.json"), '"name": "\\u00a0"');
    const blankSbom = JSON.parse(read("blank-name.spdx.json"));
    assertEquals(blankSbom["packages"][0]["name"], "\u00a0");
    assertEquals(blankSbom["packages"][0]["SPDXID"], "SPDXRef-Package-alpha");
    assertEquals(blankSbom["packages"][0]["versionInfo"], "a".repeat(40));
    assertEquals(blankSbom["relationships"], [{
      spdxElementId: "SPDXRef-DOCUMENT",
      relationshipType: "DESCRIBES",
      relatedSpdxElement: "SPDXRef-Package-alpha",
    }]);
    for (
      const key of ["licenseDeclared", "licenseConcluded", "copyrightText"]
    ) {
      assertEquals(blankSbom["packages"][0][key], "NOASSERTION");
    }
    // Really a Unicode blank.
    assertEquals("\u00a0".trim(), "");
  });
});

Deno.test("the mutation changes exactly the first revision", async () => {
  await withWorkspace(async (ws) => {
    const sbom = JSON.parse(await Deno.readTextFile(ws.sbom));
    for (const first of ["f", "0"]) {
      const original = deepCopy(sbom);
      original["packages"][0]["versionInfo"] = first + "1".repeat(39);
      const mutated = mutateFirstRevision(original);
      assert(
        (mutated["packages"] as Record<string, unknown>[])[0]["versionInfo"] !==
          (original["packages"] as Record<string, unknown>[])[0]["versionInfo"],
      );
      assertEquals(
        ((mutated["packages"] as Record<string, unknown>[])[0][
          "versionInfo"
        ] as string).slice(1),
        "1".repeat(39),
      );
      assertEquals(
        (mutated["packages"] as unknown[]).slice(1),
        (original["packages"] as unknown[]).slice(1),
      );
      // The input is untouched.
      assertEquals(
        ((original["packages"] as Record<string, unknown>[])[0][
          "versionInfo"
        ] as string)[0],
        first,
      );
    }
  });
});

Deno.test("an audit that accepts a bad input is refused", async () => {
  await withWorkspace(async (ws) => {
    const wrong: Record<
      string,
      Record<string, [number, Record<string, unknown>]>
    > = {
      "malformed exit status": {
        malformed: [1, leanReport("ERROR", ["INPUT-JSON-MANIFEST"])],
      },
      "malformed status": {
        malformed: [2, leanReport("FAIL", ["INPUT-JSON-MANIFEST"])],
      },
      "malformed rule": {
        malformed: [2, leanReport("ERROR", ["INPUT-SHAPE"])],
      },
      "mismatch passes": { mismatch: [0, leanReport()] },
      "mismatch rule": {
        mismatch: [1, leanReport("FAIL", ["SBOM-RELATIONSHIP-COUNT"])],
      },
      "mismatch error": {
        mismatch: [2, leanReport("ERROR", ["SBOM-INVENTORY-MISMATCH"])],
      },
      "empty passes": { empty: [0, leanReport()] },
      "empty rule": { empty: [1, leanReport("FAIL", ["SBOM-CONTRACT"])] },
      "empty error": {
        empty: [2, leanReport("ERROR", ["SBOM-EMPTY-INVENTORY"])],
      },
      "blank passes": { blank: [0, leanReport()] },
      "blank manifest rule only": {
        blank: [1, leanReport("FAIL", ["SBOM-MANIFEST-EMPTY-IDENTITY"])],
      },
      "blank package rule only": {
        blank: [1, leanReport("FAIL", ["SBOM-PACKAGE-EMPTY-IDENTITY"])],
      },
      "blank exit status": {
        blank: [
          2,
          leanReport("FAIL", [
            "SBOM-MANIFEST-EMPTY-IDENTITY",
            "SBOM-PACKAGE-EMPTY-IDENTITY",
          ]),
        ],
      },
    };
    for (const [label, overrides] of Object.entries(wrong)) {
      try {
        await assertRejectsEvidence(() =>
          runNegativeCases(
            ws.manifest,
            ws.sbom,
            ws.dir,
            (manifest, sbom) =>
              new FakeAudit(REAL_MANIFEST, overrides).call(manifest, sbom),
          )
        );
      } catch (error) {
        throw new Error(`case ${label}: ${error}`);
      }
    }
  });
});

Deno.test("a diagnostic without a rule is refused", async () => {
  await withWorkspace(async (ws) => {
    const report = leanReport("FAIL", ["SBOM-EMPTY-INVENTORY"]);
    (report["diagnostics"] as Record<string, unknown>[]).push({
      severity: "error",
    });
    await assertRejectsEvidence(
      () =>
        runNegativeCases(
          ws.manifest,
          ws.sbom,
          ws.dir,
          (manifest, sbom) =>
            new FakeAudit(REAL_MANIFEST, { empty: [1, report] }).call(
              manifest,
              sbom,
            ),
        ),
      /malformed diagnostics/,
    );
  });
});

Deno.test("a report that is not JSON is refused", async () => {
  await withWorkspace(async (ws) => {
    const garbage = (_manifest: string, _sbom: string) =>
      Promise.resolve({ code: 2, stdout: "not json", stderr: "" });
    await assertRejectsEvidence(
      () => runNegativeCases(ws.manifest, ws.sbom, ws.dir, garbage),
      /did not print a JSON report/,
    );
  });
});

Deno.test("end to end evidence and summary", async () => {
  await withWorkspace(async (ws) => {
    const { code, out, err } = await ws.run();
    assertEquals(code, 0);
    assertEquals(err, "");
    assertStringIncludes(out, "negative CLI cases: PASS");
    const evidence = JSON.parse(await Deno.readTextFile(ws.output));
    assertEquals(evidence["schemaVersion"], "k7pl.ci-evidence/v1");
    // The evidence file is written with sorted keys, so the parsed
    // workflow object is in alphabetical key order, unlike the
    // Python dict-insertion order; compare field by field, as
    // Python's dict equality does.
    assertEquals(evidence["workflow"]["name"], "Full Verification");
    assertEquals(evidence["workflow"]["runId"], 123);
    assertEquals(evidence["workflow"]["runAttempt"], 2);
    assertEquals(evidence["workflow"]["checkedOutSha"], "b".repeat(40));
    assertEquals(
      evidence["workflow"]["pullRequestHeadSha"],
      "a".repeat(40),
    );
    assertEquals(evidence["audit"]["status"], "PASS");
    assertEquals(evidence["negativeCases"], RECORDED_CASES);
  });
});

Deno.test("the inputs keep their names order and real hashes", async () => {
  await withWorkspace(async (ws) => {
    assertEquals((await ws.run()).code, 0);
    const inputs = JSON.parse(await Deno.readTextFile(ws.output))["inputs"];
    assertEquals(
      inputs.map((item: Record<string, unknown>) => item["artifact"]),
      [
        "lake-manifest.json",
        "lakefile.lean",
        "lean-toolchain",
        "scripts/ci/lake_manifest_to_spdx.py",
        "tools/Compliance/SbomAudit.lean",
        "tools/Compliance/SbomAuditMain.lean",
        "k7pl-lake.spdx.json",
      ],
    );
    assertEquals(inputs[0]["sha256"], await sha256File(ws.manifest));
    assertEquals(
      inputs[1]["sha256"],
      await sha256File(`${REPO_ROOT}/lakefile.lean`),
    );
    assertEquals(inputs[6]["sha256"], await sha256File(ws.sbom));
  });
});

Deno.test("the summary reports the SPDX hash not the lakefile hash", async () => {
  await withWorkspace(async (ws) => {
    assertEquals((await ws.run()).code, 0);
    const summary = await Deno.readTextFile(ws.summary);
    assertStringIncludes(
      summary,
      `- Generated SPDX SHA-256: \`${await sha256File(ws.sbom)}\``,
    );
    assertStringIncludes(
      summary,
      `- Manifest SHA-256: \`${await sha256File(ws.manifest)}\``,
    );
    assert(
      !summary.includes(await sha256File(`${REPO_ROOT}/lakefile.lean`)),
    );
  });
});

Deno.test("the component count comes from the manifest", async () => {
  await withWorkspace(async (ws) => {
    assertEquals((await ws.run()).code, 0);
    const expected = (REAL_MANIFEST["packages"] as unknown[]).length;
    assertStringIncludes(
      await Deno.readTextFile(ws.summary),
      `- Valid input: PASS; ${expected} manifest components checked.`,
    );
  });
  await withWorkspace(async (ws) => {
    const audit = new FakeAudit(REAL_MANIFEST);
    // The double compares against the full inventory.
    assertEquals(
      (await ws.run((manifest, sbom) => audit.call(manifest, sbom))).code,
      0,
    );
    assertStringIncludes(
      await Deno.readTextFile(ws.summary),
      "- Valid input: PASS; 3 manifest components checked.",
    );
  }, {
    manifest: (() => {
      const smaller = deepCopy(REAL_MANIFEST);
      smaller["packages"] = (smaller["packages"] as unknown[]).slice(0, 3);
      return smaller;
    })(),
  });
});

Deno.test("the summary states the observed negative results", async () => {
  await withWorkspace(async (ws) => {
    assertEquals((await ws.run()).code, 0);
    assertStringIncludes(
      await Deno.readTextFile(ws.summary),
      "- Negative integration cases: malformed manifest JSON → ERROR/2; mutated package revision → FAIL/1; " +
        "empty manifest and SPDX inventory → FAIL/1; Unicode blank package name (U+00A0) → FAIL/1.",
    );
  });
});

Deno.test("tool versions are not duplicated", async () => {
  await withWorkspace(async (ws) => {
    assertEquals((await ws.run()).code, 0);
    let toolchain = JSON.parse(await Deno.readTextFile(ws.output))["toolchain"];
    assertEquals(toolchain["sbomGenerator"], `${TOOL_NAME}@${TOOL_VERSION}`);
    assertEquals(toolchain["leanAudit"], "k7pl-sbom-audit@0.1.0");
    assertEquals(toolchain["lean"], REAL_TOOLCHAIN.trim());
    const report = leanReport("PASS", [], ["lake-manifest.json", ws.sbom]);
    report["toolVersion"] = "9.9.9";
    await Deno.writeTextFile(ws.report, pythonJson(report));
    assertEquals((await ws.run()).code, 0);
    toolchain = JSON.parse(await Deno.readTextFile(ws.output))["toolchain"];
    assertEquals(toolchain["leanAudit"], "k7pl-sbom-audit@9.9.9");
  });
});

Deno.test("without a pull request event the head is null", async () => {
  await withWorkspace(async (ws) => {
    assertEquals((await ws.run()).code, 0);
    assertEquals(
      JSON.parse(
        await Deno.readTextFile(ws.output),
      )["workflow"]["pullRequestHeadSha"],
      null,
    );
    const env = { ...ws.env };
    delete env["GITHUB_EVENT_PATH"];
    assertEquals((await ws.run(undefined, env)).code, 0);
  }, { pullRequestHead: null });
});

Deno.test("failures write no evidence and exit 1", async () => {
  await withWorkspace(async (ws) => {
    const { code, err } = await ws.run();
    assertEquals(code, 1);
    assertStringIncludes(err, "not PASS");
    assertEquals(await exists(ws.output), false);
    assertEquals(await exists(ws.summary), false);
  }, { report: leanReport("FAIL", ["SBOM-INVENTORY-MISMATCH"]) });
});

Deno.test("the github environment is required", async () => {
  for (
    const name of [
      "GITHUB_RUN_ID",
      "GITHUB_RUN_ATTEMPT",
      "GITHUB_SHA",
      "GITHUB_WORKFLOW",
      "GITHUB_STEP_SUMMARY",
      "RUNNER_TEMP",
    ]
  ) {
    await withWorkspace(async (ws) => {
      const env = { ...ws.env };
      delete env[name];
      const { code, err } = await ws.run(undefined, env);
      assertEquals(code, 1);
      assertStringIncludes(err, name);
    });
  }
  await withWorkspace(async (ws) => {
    const { code, err } = await ws.run(undefined, {
      ...ws.env,
      GITHUB_RUN_ID: "abc",
    });
    assertEquals(code, 1);
    assertStringIncludes(err, "not an integer");
  });
});

Deno.test("errors are annotations without injected commands", async () => {
  await withWorkspace(async (ws) => {
    const { code, err } = await ws.run(undefined, {
      ...ws.env,
      GITHUB_ACTIONS: "true",
    });
    assertEquals(code, 1);
    const lines = err.trimEnd().split("\n");
    assertEquals(lines.length, 1);
    assert(lines[0].startsWith("::error::"));
  }, {
    report: { ...leanReport(), status: "FAIL\n::notice::pwned" },
  });
});

async function paperproofSbom(
  ws: Workspace,
  mutate?: (doc: {
    packages: Record<string, unknown>[];
    relationships: Record<string, unknown>[];
    spdxVersion: string;
  }) => void,
): Promise<string> {
  const inputs = loadWorkspaceInputs(REPO_ROOT, PAPERPROOF_MANIFEST_PATH);
  const sbom = await generateSbom(
    inputs.manifest,
    inputs.lakefile,
    inputs.toolchain,
    CREATED,
    inputs.workspace,
  );
  if (mutate) {
    mutate(
      sbom as unknown as {
        packages: Record<string, unknown>[];
        relationships: Record<string, unknown>[];
        spdxVersion: string;
      },
    );
  }
  const path = `${ws.dir}/k7pl-paperproof-export-lake.spdx.json`;
  await Deno.writeTextFile(path, pythonJson(sbom));
  return path;
}

Deno.test("the separate document is recorded and summarised", async () => {
  await withWorkspace(async (ws) => {
    const sbom = await paperproofSbom(ws);
    const { code, err } = await ws.run(undefined, undefined, [
      "--extra-inventory",
      PAPERPROOF_MANIFEST_PATH,
      sbom,
    ]);
    assertEquals(code, 0);
    assertEquals(err, "");
    const evidence = JSON.parse(await Deno.readTextFile(ws.output));
    const [inventory] = evidence["additionalInventories"];
    assertEquals(inventory["workspace"], PAPERPROOF_WORKSPACE.directory);
    assertEquals(
      inventory["components"],
      (JSON.parse(
        await Deno.readTextFile(PAPERPROOF_MANIFEST_PATH),
      )["packages"] as unknown[]).length,
    );
    assertEquals(inventory["auditedBySbomAudit"], false);
    assertEquals(
      (inventory["inputs"] as Record<string, unknown>[]).map((item) =>
        item["artifact"]
      ),
      [
        `${PAPERPROOF_WORKSPACE.directory}/lake-manifest.json`,
        `${PAPERPROOF_WORKSPACE.directory}/lakefile.lean`,
        `${PAPERPROOF_WORKSPACE.directory}/lean-toolchain`,
        "k7pl-paperproof-export-lake.spdx.json",
      ],
    );
    assertEquals(
      (inventory["inputs"] as Record<string, unknown>[])[0]["sha256"],
      await sha256File(PAPERPROOF_MANIFEST_PATH),
    );
    assertEquals(
      (inventory["inputs"] as Record<string, unknown>[])[3]["sha256"],
      await sha256File(sbom),
    );
    // The root inventory is untouched by the extra document.
    assertEquals(
      inputSha256(evidence, "k7pl-lake.spdx.json"),
      await sha256File(ws.sbom),
    );
    const summary = await Deno.readTextFile(ws.summary);
    assertStringIncludes(
      summary,
      `- Separate inventory of \`${PAPERPROOF_WORKSPACE.directory}\`: ${
        inventory["components"]
      } components, ` +
        `SPDX SHA-256 \`${await sha256File(sbom)}\``,
    );
    assertStringIncludes(summary, "not audited by sbomAudit");
  });
});

Deno.test("without extra inventory the evidence has no such key", async () => {
  await withWorkspace(async (ws) => {
    assertEquals((await ws.run()).code, 0);
    const evidence = JSON.parse(await Deno.readTextFile(ws.output));
    assert(!("additionalInventories" in evidence));
  });
});

Deno.test("a document that does not match its manifest is refused", async () => {
  const mutations: Record<
    string,
    (doc: {
      packages: Record<string, unknown>[];
      relationships: Record<string, unknown>[];
      spdxVersion: string;
    }) => void
  > = {
    revision: (doc) => {
      doc.packages[0]["versionInfo"] = "0".repeat(40);
    },
    url: (doc) => {
      doc.packages[0]["downloadLocation"] = "https://github.com/evil/x";
    },
    "extra package": (doc) => {
      doc.packages.push({
        ...doc.packages[0],
        name: "extra",
        SPDXID: "SPDXRef-x",
      });
    },
    "missing package": (doc) => {
      doc.packages.pop();
    },
    "missing relationship": (doc) => {
      doc.relationships.pop();
    },
    "dependency edge": (doc) => {
      doc.relationships.push({
        spdxElementId: doc.packages[0]["SPDXID"],
        relationshipType: "DEPENDS_ON",
        relatedSpdxElement: doc.packages[1]["SPDXID"],
      });
    },
    version: (doc) => {
      doc.spdxVersion = "SPDX-2.2";
    },
  };
  for (const [label, mutate] of Object.entries(mutations)) {
    try {
      await withWorkspace(async (ws) => {
        const sbom = await paperproofSbom(ws, mutate);
        const { code, err } = await ws.run(undefined, undefined, [
          "--extra-inventory",
          PAPERPROOF_MANIFEST_PATH,
          sbom,
        ]);
        assertEquals(code, 1);
        assertStringIncludes(err, PAPERPROOF_WORKSPACE.directory);
        assertEquals(await exists(ws.output), false);
      });
    } catch (error) {
      throw new Error(`mutation ${label}: ${error}`);
    }
  }
});

Deno.test("the root manifest is not an extra inventory", async () => {
  await withWorkspace(async (ws) => {
    const { code, err } = await ws.run(undefined, undefined, [
      "--extra-inventory",
      `${REPO_ROOT}/lake-manifest.json`,
      ws.sbom,
    ]);
    assertEquals(code, 1);
    assertStringIncludes(err, "not the root one");
  });
});

Deno.test("two documents cannot share a name", async () => {
  await withWorkspace(async (ws) => {
    const sameName = `${ws.dir}/copy`;
    await Deno.mkdir(sameName);
    const sbom = await paperproofSbom(ws);
    const clash = `${sameName}/k7pl-lake.spdx.json`;
    await Deno.copyFile(sbom, clash);
    const { code, err } = await ws.run(undefined, undefined, [
      "--extra-inventory",
      PAPERPROOF_MANIFEST_PATH,
      clash,
    ]);
    assertEquals(code, 1);
    assertStringIncludes(err, "two documents with the same name");
  });
});
