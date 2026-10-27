// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  EXPECTED_VALIDATOR_VERSION,
  preflightIssues,
  sha256File,
  validate,
  validateSpdxMain,
  type ValidatorTool,
} from "../src/validate_spdx.ts";

// Parity cases transcribed from scripts/ci/test_validate_spdx.py,
// with the Python unittest.mock patches replaced by the injected
// ValidatorTool stub (see validate_spdx.ts: the tool call is an
// injection point, stubbed here, never a new validator).
// These are the specification for the port: if the Python wrapper
// changes, these tests must change with it, in the same commit,
// and the change must be owner-approved.

const VALIDATOR_VERSION = "0.8.5";

// Python 3.13 str.strip() whitespace code points, and the
// boundary code points Python does NOT treat as whitespace,
// both transcribed from test_validate_spdx.py.
const PYTHON_STRIP_CODEPOINTS = [
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
const PYTHON_NON_WHITESPACE_BOUNDARY_CODEPOINTS = [
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

function ruleIds(document: unknown): string[] {
  return preflightIssues(document).map((issue) => issue.ruleId);
}

function stubTool(overrides: Partial<ValidatorTool> = {}): ValidatorTool & {
  calls: { version: number; executable: number; run: number };
  lastCommand: string[] | null;
} {
  const calls = { version: 0, executable: 0, run: 0 };
  let lastCommand: string[] | null = null;
  const tool: ValidatorTool & {
    calls: typeof calls;
    lastCommand: string[] | null;
  } = {
    calls,
    get lastCommand() {
      return lastCommand;
    },
    getVersion: () => {
      calls.version++;
      return VALIDATOR_VERSION;
    },
    findExecutable: () => {
      calls.executable++;
      return "/usr/bin/pyspdxtools";
    },
    run: (_command: string[]) => {
      calls.run++;
      lastCommand = _command;
      return { returncode: 0, stdout: "", stderr: "" };
    },
    ...overrides,
  };
  return tool;
}

async function writeDocument(
  directory: string,
  payload: unknown,
): Promise<string> {
  const path = `${directory}/input.spdx.json`;
  await Deno.writeTextFile(path, JSON.stringify(payload));
  return path;
}

Deno.test("named package has no preflight issue", () => {
  assertEquals(preflightIssues({ packages: [{ name: "mathlib" }] }), []);
});

Deno.test("empty name is rejected for known upstream gap", () => {
  const issues = preflightIssues({ packages: [{ name: "" }] });
  assertEquals(ruleIds({ packages: [{ name: "" }] }), [
    "SPDX-PREFLIGHT-PACKAGE-NAME",
  ]);
  assertStringIncludes(issues[0].message, "#885");
});

Deno.test("missing name is rejected", () => {
  assertEquals(ruleIds({ packages: [{}] }), ["SPDX-PREFLIGHT-PACKAGE-NAME"]);
});

Deno.test("whitespace-only name is rejected", () => {
  assertEquals(
    ruleIds({ packages: [{ name: "   " }] }),
    ["SPDX-PREFLIGHT-PACKAGE-NAME"],
  );
});

Deno.test("python strip whitespace set is rejected", () => {
  for (const codePoint of PYTHON_STRIP_CODEPOINTS) {
    const name = String.fromCodePoint(codePoint);
    assertEquals(
      ruleIds({ packages: [{ name }] }),
      ["SPDX-PREFLIGHT-PACKAGE-NAME"],
      `U+${codePoint.toString(16).padStart(4, "0")}`,
    );
  }
});

Deno.test("non-whitespace boundary code points are not treated as blank", () => {
  for (const codePoint of PYTHON_NON_WHITESPACE_BOUNDARY_CODEPOINTS) {
    const name = String.fromCodePoint(codePoint);
    assertEquals(
      preflightIssues({ packages: [{ name }] }),
      [],
      `U+${codePoint.toString(16).padStart(4, "0")}`,
    );
  }
});

Deno.test("non-object package is rejected", () => {
  assertEquals(
    ruleIds({ packages: ["not-an-object"] }),
    ["SPDX-PREFLIGHT-PACKAGE"],
  );
});

Deno.test("missing packages array is rejected", () => {
  assertEquals(ruleIds({}), ["SPDX-PREFLIGHT-PACKAGES"]);
});

Deno.test("non-object document is rejected", () => {
  assertEquals(ruleIds([]), ["SPDX-PREFLIGHT-DOCUMENT"]);
});

Deno.test("unknown root property is rejected by pinned spdx 2.3 schema guard", () => {
  const document = {
    packages: [{ name: "mathlib" }],
    k7plProbeUnknownProperty: "probe-only",
  };
  const issues = preflightIssues(document);
  assertEquals(
    issues.map((issue) => [issue.ruleId, issue.artifact]),
    [[
      "SPDX-PREFLIGHT-UNKNOWN-DOCUMENT-FIELD",
      "document.k7plProbeUnknownProperty",
    ]],
  );
});

Deno.test("multiple preflight issues keep rule ids and paths", () => {
  const issues = preflightIssues({
    packages: [{}, { name: "  " }, "not-an-object", { name: "mathlib" }],
  });
  assertEquals(
    issues.map((issue) => [issue.ruleId, issue.artifact]),
    [
      ["SPDX-PREFLIGHT-PACKAGE-NAME", "packages[0].name"],
      ["SPDX-PREFLIGHT-PACKAGE-NAME", "packages[1].name"],
      ["SPDX-PREFLIGHT-PACKAGE", "packages[2]"],
    ],
  );
});

Deno.test("cli rejects unknown root property before external validator", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = `${tmp}/unknown-field.spdx.json`;
    await Deno.writeTextFile(
      path,
      JSON.stringify({
        packages: [{ name: "mathlib" }],
        k7plProbeUnknownProperty: "probe-only",
      }),
    );
    const tool = stubTool();
    const { exitCode, report } = await validateSpdxMain(
      ["validate_spdx.py", path],
      { tool, env: {} },
    );
    assertEquals(exitCode, 1);
    assertEquals(report.status, "FAIL");
    assertEquals(
      report.diagnostics.map((d) => d.ruleId),
      ["SPDX-PREFLIGHT-UNKNOWN-DOCUMENT-FIELD"],
    );
    assertEquals(tool.calls.run, 0);
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("cli rejects empty package name before external validator", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = `${tmp}/empty-name.spdx.json`;
    await Deno.writeTextFile(
      path,
      JSON.stringify({ packages: [{ name: "" }] }),
    );
    const tool = stubTool();
    const { exitCode, report } = await validateSpdxMain(
      ["validate_spdx.py", path],
      { tool, env: {} },
    );
    assertEquals(exitCode, 1);
    assertEquals(report.status, "FAIL");
    assertEquals(report.validator.elapsedMs, null);
    assert(typeof report.elapsedMs === "number");
    assertEquals(
      report.diagnostics.map((d) => d.ruleId),
      ["SPDX-PREFLIGHT-PACKAGE-NAME"],
    );
    assertEquals(tool.calls.run, 0);
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("missing validator package is an error", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = await writeDocument(tmp, { packages: [{ name: "mathlib" }] });
    const tool = stubTool({ getVersion: () => null });
    const { report, exitCode } = await validate(path, { tool, env: {} });
    assertEquals([report.status, exitCode], ["ERROR", 2]);
    assertEquals(report.diagnostics[0].ruleId, "SPDX-VALIDATOR-MISSING");
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("unexpected validator version is an error without executable lookup", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = await writeDocument(tmp, { packages: [{ name: "mathlib" }] });
    const tool = stubTool({ getVersion: () => "0.8.4" });
    const { report, exitCode } = await validate(path, { tool, env: {} });
    assertEquals([report.status, exitCode], ["ERROR", 2]);
    assertEquals(report.diagnostics[0].ruleId, "SPDX-VALIDATOR-VERSION");
    assertEquals(tool.calls.executable, 0);
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("missing validator executable is an error", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = await writeDocument(tmp, { packages: [{ name: "mathlib" }] });
    const tool = stubTool({ findExecutable: () => null });
    const { report, exitCode } = await validate(path, { tool, env: {} });
    assertEquals([report.status, exitCode], ["ERROR", 2]);
    assertEquals(report.diagnostics[0].ruleId, "SPDX-VALIDATOR-CLI-MISSING");
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("malformed json is an error", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = `${tmp}/broken.spdx.json`;
    await Deno.writeTextFile(path, '{"packages": [');
    const tool = stubTool();
    const { report, exitCode } = await validate(path, { tool, env: {} });
    assertEquals([report.status, exitCode], ["ERROR", 2]);
    assertEquals(report.diagnostics[0].ruleId, "SPDX-INPUT-JSON");
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("unreadable input is an error", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = `${tmp}/missing.spdx.json`;
    const tool = stubTool();
    const { report, exitCode } = await validate(path, { tool, env: {} });
    assertEquals([report.status, exitCode], ["ERROR", 2]);
    assertEquals(report.diagnostics[0].ruleId, "SPDX-INPUT-READ");
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("external validator failure is a fail with diagnostic", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = await writeDocument(tmp, { packages: [{ name: "mathlib" }] });
    const tool = stubTool({
      run: () => ({
        returncode: 1,
        stdout: "",
        stderr: "invalid SPDX document",
      }),
    });
    const { report, exitCode } = await validate(path, { tool, env: {} });
    assertEquals([report.status, exitCode], ["FAIL", 1]);
    assertEquals(report.diagnostics[0].ruleId, "SPDX-TOOLS-VALIDATION");
    assertStringIncludes(
      report.diagnostics[0].message,
      "invalid SPDX document",
    );
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("external validator execution error is an error", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = await writeDocument(tmp, { packages: [{ name: "mathlib" }] });
    const tool = stubTool({
      run: () => {
        throw new Error("exec failed");
      },
    });
    const { report, exitCode } = await validate(path, { tool, env: {} });
    assertEquals([report.status, exitCode], ["ERROR", 2]);
    assertEquals(report.diagnostics[0].ruleId, "SPDX-VALIDATOR-EXEC");
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("input change during validation is an error", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = await writeDocument(tmp, { packages: [{ name: "mathlib" }] });
    const digests = ["a".repeat(64), "b".repeat(64)];
    const tool = stubTool();
    const { report, exitCode } = await validate(path, {
      tool,
      env: {},
      sha256File: () => Promise.resolve(digests.shift()!),
    });
    assertEquals([report.status, exitCode], ["ERROR", 2]);
    assertEquals(report.diagnostics[0].ruleId, "SPDX-INPUT-CHANGED");
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("valid wrapper path preserves sha and report contract", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = await writeDocument(tmp, { packages: [{ name: "mathlib" }] });
    const expectedDigest = await sha256File(path);
    const tool = stubTool();
    const { report, exitCode } = await validate(path, { tool, env: {} });
    assertEquals([report.status, exitCode], ["PASS", 0]);
    assertEquals(report.schemaVersion, "k7pl.spdx-validation/v1");
    assertEquals(report.input.sha256, expectedDigest);
    assertEquals(report.input.artifact, "input.spdx.json");
    assertEquals(report.validator.version, VALIDATOR_VERSION);
    assertEquals(report.validator.expectedVersion, EXPECTED_VALIDATOR_VERSION);
    assertEquals(report.diagnostics, []);
    assert(
      report.limitations.some((l) => l.includes("additionalProperties=false")),
    );
    assert(report.limitations.some((l) => l.includes("root-only guard")));
    assertEquals(tool.calls.run, 1);
    assertEquals(tool.lastCommand!.slice(-3), [path, "--version", "SPDX-2.3"]);
    assertEquals(
      tool.lastCommand,
      ["pyspdxtools", "--infile", path, "--version", "SPDX-2.3"],
    );
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("workflow fields come from the environment and event file", async () => {
  const tmp = await Deno.makeTempDir();
  try {
    const path = await writeDocument(tmp, { packages: [{ name: "mathlib" }] });
    const eventPath = `${tmp}/event.json`;
    await Deno.writeTextFile(
      eventPath,
      JSON.stringify({
        pull_request: {
          head: { sha: "deadbeefdeadbeefdeadbeefdeadbeefdeadbeef" },
        },
      }),
    );
    const tool = stubTool();
    const { report } = await validate(path, {
      tool,
      env: {
        GITHUB_RUN_ID: "123",
        GITHUB_RUN_ATTEMPT: "2",
        GITHUB_SHA: "abc",
        GITHUB_EVENT_PATH: eventPath,
      },
    });
    assertEquals(report.workflow.runId, "123");
    assertEquals(report.workflow.runAttempt, "2");
    assertEquals(report.workflow.checkedOutSha, "abc");
    assertEquals(
      report.workflow.pullRequestHeadSha,
      "deadbeefdeadbeefdeadbeefdeadbeefdeadbeef",
    );
  } finally {
    await Deno.remove(tmp, { recursive: true });
  }
});

Deno.test("usage error emits structured report and exit code two", async () => {
  const { exitCode, report } = await validateSpdxMain(
    ["validate_spdx.py"],
    { env: {} },
  );
  assertEquals(exitCode, 2);
  assertEquals(report.status, "ERROR");
  assertEquals(report.diagnostics[0].ruleId, "USAGE");
  assert(typeof report.elapsedMs === "number");
});
