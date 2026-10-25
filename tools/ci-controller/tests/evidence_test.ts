// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import { validateEvidence, validateEvidenceSchema } from "../src/evidence.ts";
import { loadRegistryFile } from "../src/registry.ts";

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;
const REGISTRY = loadRegistryFile(`${REPO_ROOT}.github/ci/components.yaml`);
const SHA = "a".repeat(64);
const COMMIT = "b".repeat(40);

function baseRecord(
  overrides: Record<string, unknown> = {},
): Record<string, unknown> {
  return {
    stage: "k-compile",
    commit: COMMIT,
    run: "12345",
    tool: {
      name: "kompile",
      version: "7.1.337",
      source: "kframework-k:ubuntu-jammy-7.1.337",
    },
    inputs: [{ path: "spec/Spec", sha256: SHA }],
    outputs: [{ path: "src/k/.build/kompiled", sha256: SHA }],
    exit_code: 0,
    claims: [{ class: "execution", property: "k-definition-compiled" }],
    depends_on: ["spec-extract"],
    ...overrides,
  };
}

Deno.test("valid k-compile evidence passes", () => {
  assertEquals(validateEvidence(baseRecord(), REGISTRY), []);
});

Deno.test("valid lean proof evidence passes", () => {
  const record = baseRecord({
    stage: "lean-proof-build",
    tool: {
      name: "lake",
      version: "leanprover/lean4:v4.34.0",
      source: "lean-toolchain",
    },
    claims: [{
      class: "proof",
      property: "K7PL.MachineSoundness.end_to_end_preservation",
    }],
    depends_on: ["klean-export"],
  });
  assertEquals(validateEvidence(record, REGISTRY), []);
});

Deno.test("valid tla verification evidence passes", () => {
  const record = baseRecord({
    stage: "tla-model-check",
    tool: { name: "tlc", version: "1.7.4", source: "tla2tools.jar" },
    claims: [{
      class: "verification",
      property: "D01 ProtectedIntegrity holds",
    }],
    depends_on: [],
  });
  assertEquals(validateEvidence(record, REGISTRY), []);
});

Deno.test("missing proof claim is rejected", () => {
  const record = baseRecord({
    stage: "lean-proof-build",
    claims: [{ class: "execution", property: "lean build finished" }],
    depends_on: ["klean-export"],
  });
  const errors = validateEvidence(record, REGISTRY);
  assert(
    errors.some((e) => e.includes("missing required claim class proof")),
    JSON.stringify(errors),
  );
});

Deno.test("proof claim on a non-proof stage is rejected", () => {
  const record = baseRecord({
    stage: "tla-model-check",
    claims: [{ class: "proof", property: "D01 proved" }],
  });
  const errors = validateEvidence(record, REGISTRY);
  assert(errors.some((e) => e.includes("not allowed")), JSON.stringify(errors));
});

Deno.test("unknown stage is rejected", () => {
  const errors = validateEvidence(
    baseRecord({ stage: "mlir-lowering" }),
    REGISTRY,
  );
  assert(
    errors.some((e) => e.includes("unknown stage")),
    JSON.stringify(errors),
  );
});

Deno.test("unknown dependency is rejected", () => {
  const errors = validateEvidence(
    baseRecord({ depends_on: ["no-such-stage"] }),
    REGISTRY,
  );
  assert(
    errors.some((e) => e.includes("unknown stage")),
    JSON.stringify(errors),
  );
});

Deno.test("missing required input stage is rejected when depends_on is present", () => {
  const errors = validateEvidence(baseRecord({ depends_on: [] }), REGISTRY);
  assert(
    errors.some((e) => e.includes("required input stage spec-extract")),
    JSON.stringify(errors),
  );
});

Deno.test("missing digest is rejected", () => {
  const record = baseRecord();
  record["inputs"] = [{ path: "spec/Spec" }];
  const errors = validateEvidence(record, REGISTRY);
  assert(errors.some((e) => e.includes("sha256")), JSON.stringify(errors));
});

Deno.test("malformed digest is rejected", () => {
  const record = baseRecord();
  record["outputs"] = [{ path: "x", sha256: "not-a-digest" }];
  const errors = validateEvidenceSchema(record);
  assert(errors.some((e) => e.includes("sha256")), JSON.stringify(errors));
});

Deno.test("malformed commit sha is rejected", () => {
  const errors = validateEvidenceSchema(baseRecord({ commit: "abc123" }));
  assert(errors.some((e) => e.includes("commit")), JSON.stringify(errors));
});

Deno.test("claims on a failed stage are rejected", () => {
  const errors = validateEvidence(baseRecord({ exit_code: 2 }), REGISTRY);
  assert(
    errors.some((e) => e.includes("failed stage claims nothing")),
    JSON.stringify(errors),
  );
});

Deno.test("failed stage with no claims still fails its required-claim rule", () => {
  const record = baseRecord({ exit_code: 1, claims: [] });
  // k-compile requires an execution claim, so this fails on the
  // missing claim -- which is the correct behaviour: a failed
  // stage must not be counted as a successful stage either.
  const errors = validateEvidence(record, REGISTRY);
  assert(
    errors.some((e) => e.includes("missing required claim class")),
    JSON.stringify(errors),
  );
});

Deno.test("duplicate claims are rejected", () => {
  const record = baseRecord({
    claims: [
      { class: "execution", property: "same" },
      { class: "execution", property: "same" },
    ],
  });
  const errors = validateEvidenceSchema(record);
  assert(
    errors.some((e) => e.includes("duplicate claim")),
    JSON.stringify(errors),
  );
});

Deno.test("unexpected top-level property is rejected", () => {
  const errors = validateEvidenceSchema(baseRecord({ surprise: true }));
  assert(
    errors.some((e) => e.includes("unexpected property")),
    JSON.stringify(errors),
  );
});

Deno.test("traceability block from RequirementEvidence validates structurally", () => {
  const record = baseRecord({
    traceability: {
      requirementId: "REQ-SBOM-01",
      applicability: "applicable",
      decidedBy: "owner",
      rationale: "SBOM coherence is in scope for this release.",
      evidence: [{ status: "verified", reviewedBy: "owner" }],
      exceptions: [],
    },
  });
  assertEquals(validateEvidenceSchema(record), []);
});

Deno.test("traceability rejects applicable without decider or rationale", () => {
  const noDecider = validateEvidenceSchema(baseRecord({
    traceability: { requirementId: "R1", applicability: "applicable" },
  }));
  assert(
    noDecider.some((e) => e.includes("decidedBy")),
    JSON.stringify(noDecider),
  );
  assert(
    noDecider.some((e) => e.includes("rationale")),
    JSON.stringify(noDecider),
  );
});

Deno.test("traceability rejects bad enums and exception without expiry", () => {
  const badEnum = validateEvidenceSchema(baseRecord({
    traceability: { requirementId: "R1", applicability: "maybe" },
  }));
  assert(
    badEnum.some((e) => e.includes("applicability")),
    JSON.stringify(badEnum),
  );
  const badException = validateEvidenceSchema(baseRecord({
    traceability: {
      requirementId: "R1",
      applicability: "applicable",
      decidedBy: "owner",
      rationale: "x",
      exceptions: [{ reason: "bot blocks CI", approvedBy: "owner" }],
    },
  }));
  assert(
    badException.some((e) => e.includes("expiresAt")),
    JSON.stringify(badException),
  );
});
