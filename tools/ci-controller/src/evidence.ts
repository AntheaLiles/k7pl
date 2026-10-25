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
  traceability?: EvidenceTraceability;
}

/**
 * Requirement-to-evidence traceability, transcribed from the deleted
 * tools/Compliance/RequirementEvidence model (no live consumer):
 * the data model and structural rules only, not the assessor.
 * Applicability is an explicit decision; an applicable requirement
 * needs a named decider and a rationale; exceptions need a reason,
 * an approver, and an expiry. Expiry itself is enforced by the
 * consumer at report time (records carry no clock); a record never
 * claims satisfaction on its own.
 */
export interface EvidenceTraceability {
  requirementId: string;
  applicability: string;
  sourceRef?: string;
  sourceRevision?: number;
  artifactId?: string;
  artifactRevision?: number;
  decidedBy?: string;
  rationale?: string;
  evidence?: { status: string; reviewedBy?: string }[];
  exceptions?: { reason: string; approvedBy: string; expiresAt: number }[];
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
    "traceability",
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
  if (value["traceability"] !== undefined) {
    const t = value["traceability"];
    if (!isRecord(t)) {
      errors.push("traceability: expected an object");
    } else {
      for (const key of Object.keys(t)) {
        if (
          ![
            "requirementId",
            "applicability",
            "sourceRef",
            "sourceRevision",
            "artifactId",
            "artifactRevision",
            "decidedBy",
            "rationale",
            "evidence",
            "exceptions",
          ].includes(key)
        ) {
          errors.push(`traceability: unexpected property ${key}`);
        }
      }
      if (typeof t["requirementId"] !== "string" || t["requirementId"] === "") {
        errors.push("traceability.requirementId: expected a non-empty string");
      }
      if (
        !["applicable", "notApplicable", "unresolved"].includes(
          String(t["applicability"]),
        )
      ) {
        errors.push(
          "traceability.applicability: expected one of applicable, notApplicable, unresolved",
        );
      }
      if (t["applicability"] === "applicable") {
        if (typeof t["decidedBy"] !== "string" || t["decidedBy"] === "") {
          errors.push(
            "traceability.decidedBy: expected a non-empty string for an applicable requirement",
          );
        }
        if (typeof t["rationale"] !== "string" || t["rationale"] === "") {
          errors.push(
            "traceability.rationale: expected a non-empty string for an applicable requirement",
          );
        }
      }
      for (
        const key of ["sourceRef", "artifactId"]
      ) {
        if (
          t[key] !== undefined &&
          (typeof t[key] !== "string" || t[key] === "")
        ) {
          errors.push(`traceability.${key}: expected a non-empty string`);
        }
      }
      for (const key of ["sourceRevision", "artifactRevision"]) {
        if (
          t[key] !== undefined &&
          (typeof t[key] !== "number" || !Number.isInteger(t[key]) ||
            (t[key] as number) < 0)
        ) {
          errors.push(`traceability.${key}: expected a non-negative integer`);
        }
      }
      if (t["evidence"] !== undefined) {
        if (!Array.isArray(t["evidence"])) {
          errors.push("traceability.evidence: expected an array");
        } else {
          for (let i = 0; i < t["evidence"].length; i++) {
            const item = t["evidence"][i];
            if (!isRecord(item)) {
              errors.push(`traceability.evidence[${i}]: expected an object`);
              continue;
            }
            if (
              !["verified", "unreviewed", "disputed"].includes(
                String(item["status"]),
              )
            ) {
              errors.push(
                `traceability.evidence[${i}].status: expected one of verified, unreviewed, disputed`,
              );
            }
            if (
              item["reviewedBy"] !== undefined &&
              (typeof item["reviewedBy"] !== "string" ||
                item["reviewedBy"] === "")
            ) {
              errors.push(
                `traceability.evidence[${i}].reviewedBy: expected a non-empty string`,
              );
            }
            for (const key of Object.keys(item)) {
              if (key !== "status" && key !== "reviewedBy") {
                errors.push(
                  `traceability.evidence[${i}]: unexpected property ${key}`,
                );
              }
            }
          }
        }
      }
      if (t["exceptions"] !== undefined) {
        if (!Array.isArray(t["exceptions"])) {
          errors.push("traceability.exceptions: expected an array");
        } else {
          for (let i = 0; i < t["exceptions"].length; i++) {
            const item = t["exceptions"][i];
            if (!isRecord(item)) {
              errors.push(`traceability.exceptions[${i}]: expected an object`);
              continue;
            }
            for (const key of ["reason", "approvedBy"]) {
              if (typeof item[key] !== "string" || item[key] === "") {
                errors.push(
                  `traceability.exceptions[${i}].${key}: expected a non-empty string`,
                );
              }
            }
            if (
              typeof item["expiresAt"] !== "number" ||
              !Number.isInteger(item["expiresAt"]) ||
              (item["expiresAt"] as number) < 0
            ) {
              errors.push(
                `traceability.exceptions[${i}].expiresAt: expected a non-negative integer`,
              );
            }
            for (const key of Object.keys(item)) {
              if (
                key !== "reason" && key !== "approvedBy" && key !== "expiresAt"
              ) {
                errors.push(
                  `traceability.exceptions[${i}]: unexpected property ${key}`,
                );
              }
            }
          }
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
