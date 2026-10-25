// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Evidence record validation (see evidence.schema.json).
 *
 * A record is a checkable claim about one stage, not a proof in
 * itself. The validator rejects, with a named reason:
 * - a record that fails the schema (missing/wrong-typed fields,
 *   malformed SHA-256 digests, malformed commit SHA);
 * - an unknown stage, or a stage whose component is unknown;
 * - a claim class the stage may not emit, or a required claim
 *   class the stage did not emit (a missing proof);
 * - a declared dependency that is not a known stage, or a
 *   required stage input that the record does not declare;
 * - any claim on a stage whose exit code is non-zero: a failed
 *   stage claims nothing.
 *
 * Dependency note: `depends_on` is optional in slice 1 records.
 * When it is absent, required inputs are NOT enforced here —
 * that enforcement belongs to the aggregator in a later slice,
 * once every stage emits dependency provenance. When it is
 * present, it is fully checked.
 */

import type { ClaimClass, Registry } from "./registry.ts";

export interface EvidenceClaim {
  class: string;
  property: string;
}

export interface EvidenceDigest {
  path: string;
  sha256: string;
}

export interface Evidence {
  stage: string;
  commit: string;
  run: string;
  tool: { name: string; version: string; source: string };
  inputs: EvidenceDigest[];
  outputs: EvidenceDigest[];
  exit_code: number;
  claims: EvidenceClaim[];
  depends_on?: string[];
}

const SHA256 = /^[0-9a-f]{64}$/;
const COMMIT_SHA = /^[0-9a-f]{40}$/;

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function checkDigestList(
  value: unknown,
  field: string,
  errors: string[],
): void {
  if (!Array.isArray(value)) {
    errors.push(`${field}: expected an array`);
    return;
  }
  for (let i = 0; i < value.length; i++) {
    const item = value[i];
    if (!isRecord(item)) {
      errors.push(`${field}[${i}]: expected an object`);
      continue;
    }
    if (typeof item["path"] !== "string" || item["path"] === "") {
      errors.push(`${field}[${i}].path: expected a non-empty string`);
    }
    if (typeof item["sha256"] !== "string" || !SHA256.test(item["sha256"])) {
      errors.push(
        `${field}[${i}].sha256: expected a lowercase hex SHA-256 digest`,
      );
    }
    for (const key of Object.keys(item)) {
      if (key !== "path" && key !== "sha256") {
        errors.push(`${field}[${i}]: unexpected property ${key}`);
      }
    }
  }
}

/** Schema-level validation only (no registry). Returns error strings. */
export function validateEvidenceSchema(value: unknown): string[] {
  const errors: string[] = [];
  if (!isRecord(value)) return ["evidence: expected an object"];
  const allowed = [
    "stage",
    "commit",
    "run",
    "tool",
    "inputs",
    "outputs",
    "exit_code",
    "claims",
    "depends_on",
  ];
  for (const key of Object.keys(value)) {
    if (!allowed.includes(key)) {
      errors.push(`evidence: unexpected property ${key}`);
    }
  }
  for (
    const key of [
      "stage",
      "commit",
      "run",
      "tool",
      "inputs",
      "outputs",
      "exit_code",
      "claims",
    ]
  ) {
    if (value[key] === undefined) {
      errors.push(`evidence: missing required property ${key}`);
    }
  }
  if (typeof value["stage"] !== "string" || value["stage"] === "") {
    errors.push("stage: expected a non-empty string");
  }
  if (
    typeof value["commit"] !== "string" || !COMMIT_SHA.test(value["commit"])
  ) {
    errors.push("commit: expected a full 40-character lowercase hex SHA");
  }
  if (typeof value["run"] !== "string" || value["run"] === "") {
    errors.push("run: expected a non-empty string");
  }
  if (!isRecord(value["tool"])) {
    errors.push("tool: expected an object");
  } else {
    for (const key of ["name", "version", "source"]) {
      if (typeof value["tool"][key] !== "string" || value["tool"][key] === "") {
        errors.push(`tool.${key}: expected a non-empty string`);
      }
    }
    for (const key of Object.keys(value["tool"])) {
      if (!["name", "version", "source"].includes(key)) {
        errors.push(`tool: unexpected property ${key}`);
      }
    }
  }
  checkDigestList(value["inputs"], "inputs", errors);
  checkDigestList(value["outputs"], "outputs", errors);
  if (
    typeof value["exit_code"] !== "number" ||
    !Number.isInteger(value["exit_code"]) || value["exit_code"] < 0 ||
    value["exit_code"] > 255
  ) {
    errors.push("exit_code: expected an integer between 0 and 255");
  }
  if (!Array.isArray(value["claims"])) {
    errors.push("claims: expected an array");
  } else {
    const seen = new Set<string>();
    for (let i = 0; i < value["claims"].length; i++) {
      const claim = value["claims"][i];
      if (!isRecord(claim)) {
        errors.push(`claims[${i}]: expected an object`);
        continue;
      }
      if (
        !["execution", "verification", "proof"].includes(String(claim["class"]))
      ) {
        errors.push(
          `claims[${i}].class: expected one of execution, verification, proof`,
        );
      }
      if (typeof claim["property"] !== "string" || claim["property"] === "") {
        errors.push(`claims[${i}].property: expected a non-empty string`);
      }
      for (const key of Object.keys(claim)) {
        if (key !== "class" && key !== "property") {
          errors.push(`claims[${i}]: unexpected property ${key}`);
        }
      }
      const pair = `${String(claim["class"])}:${String(claim["property"])}`;
      if (seen.has(pair)) errors.push(`claims[${i}]: duplicate claim ${pair}`);
      seen.add(pair);
    }
  }
  if (value["depends_on"] !== undefined) {
    if (!Array.isArray(value["depends_on"])) {
      errors.push("depends_on: expected an array of stage ids");
    } else {
      for (let i = 0; i < value["depends_on"].length; i++) {
        if (
          typeof value["depends_on"][i] !== "string" ||
          value["depends_on"][i] === ""
        ) {
          errors.push(`depends_on[${i}]: expected a non-empty stage id`);
        }
      }
    }
  }
  return errors;
}

/** Full validation: schema + registry rules. Returns error strings. */
export function validateEvidence(value: unknown, registry: Registry): string[] {
  const errors = validateEvidenceSchema(value);
  if (!isRecord(value)) return errors;
  const evidence = value as unknown as Evidence;
  const stage = registry.stageById.get(evidence.stage);
  if (!stage) {
    errors.push(`stage: unknown stage ${JSON.stringify(evidence.stage)}`);
    return errors;
  }
  if (
    typeof evidence.exit_code === "number" && evidence.exit_code !== 0 &&
    Array.isArray(evidence.claims) && evidence.claims.length > 0
  ) {
    errors.push(
      `stage ${stage.id}: exit_code is ${evidence.exit_code} but the record carries claims; a failed stage claims nothing`,
    );
  }
  if (Array.isArray(evidence.claims)) {
    const classes = new Set<string>();
    for (const claim of evidence.claims) {
      if (typeof claim.class === "string") classes.add(claim.class);
      if (
        typeof claim.class === "string" &&
        !(stage.allowedClaimClasses as string[]).includes(claim.class)
      ) {
        errors.push(
          `stage ${stage.id}: claim class ${claim.class} is not allowed for this stage (allowed: ${
            stage.allowedClaimClasses.join(", ")
          })`,
        );
      }
    }
    for (const required of stage.requiredClaimClasses as ClaimClass[]) {
      if (!classes.has(required)) {
        errors.push(
          `stage ${stage.id}: missing required claim class ${required} (claims present: ${
            [...classes].join(", ") || "none"
          })`,
        );
      }
    }
  }
  if (evidence.depends_on !== undefined) {
    for (const dep of evidence.depends_on) {
      if (!registry.stageById.has(dep)) {
        errors.push(`depends_on: unknown stage ${JSON.stringify(dep)}`);
      }
    }
    for (const required of stage.requires) {
      if (!evidence.depends_on.includes(required)) {
        errors.push(
          `stage ${stage.id}: required input stage ${required} is not declared in depends_on`,
        );
      }
    }
  }
  return errors;
}
