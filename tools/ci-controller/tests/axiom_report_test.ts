// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import {
  AuditError,
  axiomReportToEvidence,
  parseReport,
  sha256Hex,
} from "../src/axiom_report.ts";
import { validateEvidenceSchema } from "../src/evidence.ts";

// Parity cases transcribed from scripts/ci/test_k7pl_semantics_axiom_report.py.
// These are the specification for the port: if the Python report
// changes, these tests must change with it, in the same commit,
// and the change must be owner-approved.

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;
const CONTRACT = JSON.parse(
  await Deno.readTextFile(`${REPO_ROOT}proofs/axiom-audit-contract.json`),
) as {
  declarations: { name: string; axioms: string[] }[];
};

function assertThrows(
  fn: () => unknown,
  pattern: RegExp,
  message?: string,
): void {
  try {
    fn();
  } catch (error) {
    const text = error instanceof Error ? error.message : String(error);
    if (!pattern.test(text)) {
      throw new Error(
        message ?? `expected error matching ${pattern}, got ${text}`,
      );
    }
    return;
  }
  throw new Error(message ?? `expected function to throw matching ${pattern}`);
}

function makeLog(
  overrides: Record<string, string[]> = {},
  missing: Set<string> = new Set(),
): string {
  const lines: string[] = [];
  CONTRACT.declarations.forEach((declaration, index) => {
    if (missing.has(declaration.name)) return;
    const axioms = overrides[declaration.name] ?? declaration.axioms;
    const location = `info: K7PL/Generated.lean:${index + 1}:0: `;
    if (axioms.length > 0) {
      lines.push(
        `${location}'${declaration.name}' depends on axioms: [${
          axioms.join(", ")
        }]`,
      );
    } else {
      lines.push(
        `${location}'${declaration.name}' does not depend on any axioms`,
      );
    }
  });
  return lines.join("\n") + "\n";
}

const COMMIT = "a".repeat(40);
const SHA = "b".repeat(64);

Deno.test("exact contract and empty axiom sets are preserved", () => {
  const report = parseReport(makeLog(), CONTRACT, {
    sourceCommit: COMMIT,
    workflowRunId: "12345",
    leanVersion: "Lean version 4.34.0",
  });
  assertEquals(report.status, "passed");
  assertEquals(report.sourceCommit, COMMIT);
  assertEquals(report.workflowRunId, "12345");
  assertEquals(report.declarationCount, CONTRACT.declarations.length);
  const byName = new Map(report.declarations.map((row) => [row.name, row]));
  assertEquals(
    byName.get("K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected")
      ?.observedAxioms,
    [],
  );
  assertEquals(
    byName.get("K7PL.Bridge.add_root_is_klean_rewrite")?.observedAxioms,
    ["propext"],
  );
  assert(report.declarations.every((row) => row.matchesContract));
});

Deno.test("missing report is not treated as an empty axiom set", () => {
  const missing = new Set([
    "K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected",
  ]);
  assertThrows(
    () => parseReport(makeLog({}, missing), CONTRACT, {}),
    /missing #print axioms report/,
  );
});

Deno.test("unexpected axiom dependency fails exact match", () => {
  const name = "K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected";
  assertThrows(
    () => parseReport(makeLog({ [name]: ["propext"] }), CONTRACT, {}),
    /expected axioms/,
  );
});

Deno.test("unexpected extra axiom fails even if contract is changed", () => {
  const altered = JSON.parse(JSON.stringify(CONTRACT)) as typeof CONTRACT;
  altered.declarations[0].axioms = ["Lean.ofReduceBool"];
  assertThrows(
    () =>
      parseReport(
        makeLog({ [altered.declarations[0].name]: ["Lean.ofReduceBool"] }),
        altered,
        {},
      ),
    /forbidden axiom|unapproved axiom/,
  );
});

Deno.test("contract cannot expand the project axiom allowlist", () => {
  const altered = JSON.parse(JSON.stringify(CONTRACT)) as typeof CONTRACT & {
    policy: { allowedStandardAxioms: string[] };
  };
  altered.policy.allowedStandardAxioms.push("Lean.ofReduceBool");
  altered.declarations[0].axioms = ["Lean.ofReduceBool"];
  assertThrows(
    () =>
      parseReport(
        makeLog({ [altered.declarations[0].name]: ["Lean.ofReduceBool"] }),
        altered,
        {},
      ),
    /changes the project allowlist/,
  );
});

Deno.test("conflicting duplicate reports fail", () => {
  const name = "K7PL.Bridge.add_root_is_klean_rewrite";
  const log = makeLog() +
    `info: repeated: '${name}' does not depend on any axioms\n`;
  assertThrows(() => parseReport(log, CONTRACT, {}), /conflicting/);
});

Deno.test("sorryAx fails", () => {
  assertThrows(
    () =>
      parseReport(
        makeLog() + "info: forbidden dependency sorryAx\n",
        CONTRACT,
        {},
      ),
    /sorryAx/,
  );
});

Deno.test("sorryAx split by ANSI escapes still fails", () => {
  // The Python report strips ANSI before checking; a marker
  // hidden inside escape sequences must not slip through.
  const log = makeLog() + "info: \x1B[31msorry\x1B[0mAx\n";
  assertThrows(() => parseReport(log, CONTRACT, {}), /sorryAx/);
});

Deno.test("empty source commit, run id and lean version become unknown", () => {
  const report = parseReport(makeLog(), CONTRACT, {
    sourceCommit: "",
    workflowRunId: "",
    leanVersion: "",
  });
  assertEquals(report.sourceCommit, "unknown");
  assertEquals(report.workflowRunId, "unknown");
  assertEquals(report.leanVersion, "unknown");
});

Deno.test("evidence is verification-only and schema-valid, never proof", () => {
  const report = parseReport(makeLog(), CONTRACT, {
    sourceCommit: COMMIT,
    workflowRunId: "12345",
    leanVersion: "Lean version 4.34.0",
  });
  const evidence = axiomReportToEvidence(report, {
    commit: COMMIT,
    run: "12345",
    tool: {
      name: "axiom_report",
      version: "0.1.0",
      source: "tools/ci-controller/src/axiom_report.ts",
    },
    inputs: [{ path: "proofs/axiom-audit-contract.json", sha256: SHA }],
    outputs: [{ path: "k7pl-axiom-audit.json", sha256: SHA }],
  });
  assertEquals(validateEvidenceSchema(evidence), []);
  assert(evidence.claims.every((claim) => claim.class === "verification"));
  assert(!evidence.claims.some((claim) => claim.class === "proof"));
  assertEquals(evidence.exit_code, 0);
});

Deno.test("sha256 helper matches the known SHA-256 of abc", async () => {
  assertEquals(
    await sha256Hex("abc"),
    "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
  );
  assert(reportUsesAuditError());
  function reportUsesAuditError(): boolean {
    try {
      parseReport("", CONTRACT, {});
    } catch (error) {
      return error instanceof AuditError;
    }
    return false;
  }
});
