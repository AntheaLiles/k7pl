// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Build a minimal SARIF report from a BadgeApp criteria drift report.
 *
 * Port of scripts/ci/badge_criteria_drift_sarif.py (cutover C5).
 * The drift report is the JSON written by
 * check_badge_proposals.py --check-upstream --report. The SARIF is
 * what surfaces the finding in the repository's Security tab
 * (Code Scanning) via github/codeql-action/upload-sarif; the drift
 * script also writes the human-readable report as an artifact, and
 * the job itself fails on drift or on an unavailable check
 * (F3, owner decision 2026-10-25).
 *
 * One result per drifted blob or per check error, located at the
 * pinned registry file: the registry is the artefact that is
 * stale, and updating it deliberately is the only fix. An
 * unchanged report produces a SARIF with no results, so the
 * upload step still runs and closes any previous alert.
 *
 * The output is byte-identical to the Python helper's for the
 * same report (same key order, 2-space indent, trailing newline),
 * so the switch of the security_badge_criteria_drift.sh call
 * from python3 to this module changes no uploaded content.
 */

export const REGISTRY_LOCATION = "scripts/ci/badge_criteria_registry.json";
export const TOOL_NAME = "BadgeApp criteria drift";
export const TOOL_URI = "https://github.com/ossf/best-practices-badge";

export interface DriftItem {
  path?: string;
  expected_blob_sha?: string;
  observed_blob_sha?: string;
}

export interface ErrorItem {
  path?: string;
  error?: string;
}

export interface DriftReport {
  // Carried for parity with the Python report shape; buildSarif
  // ignores it, exactly as the Python helper does.
  status?: string;
  drift?: DriftItem[];
  errors?: ErrorItem[];
}

const RULES = [
  {
    id: "badge-criteria-drift",
    name: "BadgeCriteriaDrift",
    shortDescription: { text: "OpenSSF BadgeApp criteria changed upstream" },
    fullDescription: {
      text: "A pinned BadgeApp criteria blob differs from upstream. " +
        "The pinned registry is stale; update it deliberately, " +
        "never automatically.",
    },
    defaultConfiguration: { level: "error" },
    help: {
      text: "Review the drift report artifact and update " +
        "scripts/ci/badge_criteria_registry.json deliberately.",
    },
  },
  {
    id: "badge-criteria-unavailable",
    name: "BadgeCriteriaUnavailable",
    shortDescription: {
      text: "OpenSSF BadgeApp criteria drift could not be verified",
    },
    fullDescription: {
      text: "The upstream check failed, so the pinned registry " +
        "cannot be shown to be current. This is not evidence " +
        "that the criteria are unchanged.",
    },
    defaultConfiguration: { level: "warning" },
    help: { text: "Inspect the drift report and retry the check." },
  },
];

function location() {
  return [
    {
      physicalLocation: {
        artifactLocation: { uri: REGISTRY_LOCATION },
        region: { startLine: 1 },
      },
    },
  ];
}

export function buildSarif(report: DriftReport): unknown {
  const results = [];
  for (const item of report.drift ?? []) {
    results.push({
      ruleId: "badge-criteria-drift",
      level: "error",
      message: {
        text: "BadgeApp criteria blob changed upstream for " +
          `${item.path}: pinned ${item.expected_blob_sha}, observed ` +
          `${item.observed_blob_sha}.`,
      },
      locations: location(),
    });
  }
  for (const item of report.errors ?? []) {
    results.push({
      ruleId: "badge-criteria-unavailable",
      level: "warning",
      message: {
        text: "Could not verify BadgeApp criteria for " +
          `${item.path}: ${item.error}.`,
      },
      locations: location(),
    });
  }
  return {
    $schema: "https://json.schemastore.org/sarif-2.1.0.json",
    version: "2.1.0",
    runs: [
      {
        tool: {
          driver: {
            name: TOOL_NAME,
            informationUri: TOOL_URI,
            rules: RULES,
          },
        },
        results,
      },
    ],
  };
}

if (import.meta.main) {
  const args = Deno.args;
  const reportFlag = args.indexOf("--report");
  const outputFlag = args.indexOf("--output");
  if (
    reportFlag === -1 || outputFlag === -1 ||
    reportFlag + 1 >= args.length || outputFlag + 1 >= args.length
  ) {
    console.error(
      "usage: badge_drift_sarif.ts --report <report.json> --output <out.sarif>",
    );
    Deno.exit(2);
  }
  const reportPath = args[reportFlag + 1];
  const outputPath = args[outputFlag + 1];
  const report = JSON.parse(
    await Deno.readTextFile(reportPath),
  ) as DriftReport;
  const parent = outputPath.split("/").slice(0, -1).join("/");
  if (parent !== "") await Deno.mkdir(parent, { recursive: true });
  await Deno.writeTextFile(
    outputPath,
    JSON.stringify(buildSarif(report), null, 2) + "\n",
  );
}
