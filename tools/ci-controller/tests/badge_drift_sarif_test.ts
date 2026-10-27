// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import { buildSarif } from "../src/badge_drift_sarif.ts";

// Transcribed from scripts/ci/test_badge_drift_sarif.py (cutover C5).
// The Deno port must produce the same SARIF document as the Python
// helper for the same report; see the CLI equivalence check in the
// C5 notes (python3 helper output diffed against this module).

interface SarifDoc {
  version: string;
  runs: {
    tool: { driver: { rules: { id: string }[] } };
    results: {
      ruleId: string;
      level: string;
      message: { text: string };
      locations: {
        physicalLocation: {
          artifactLocation: { uri: string };
        };
      }[];
    }[];
  }[];
}

Deno.test("unchanged report has no results", () => {
  const doc = buildSarif({
    status: "unchanged",
    drift: [],
    errors: [],
  }) as SarifDoc;
  assertEquals(doc.version, "2.1.0");
  assertEquals(doc.runs[0].results, []);
  assertEquals(
    new Set(doc.runs[0].tool.driver.rules.map((rule) => rule.id)),
    new Set(["badge-criteria-drift", "badge-criteria-unavailable"]),
  );
});

Deno.test("drift produces one error result per blob", () => {
  const doc = buildSarif({
    status: "drift",
    drift: [{
      path: "criteria/criteria.yml",
      expected_blob_sha: "a".repeat(40),
      observed_blob_sha: "b".repeat(40),
    }],
    errors: [],
  }) as SarifDoc;
  assertEquals(doc.runs[0].results.length, 1);
  const [result] = doc.runs[0].results;
  assertEquals(result.ruleId, "badge-criteria-drift");
  assertEquals(result.level, "error");
  assert(result.message.text.includes("criteria/criteria.yml"));
  assertEquals(
    result.locations[0].physicalLocation.artifactLocation.uri,
    "scripts/ci/badge_criteria_registry.json",
  );
});

Deno.test("unavailable produces a warning result", () => {
  const doc = buildSarif({
    status: "unavailable",
    drift: [],
    errors: [{ path: "criteria/criteria.yml", error: "timeout" }],
  }) as SarifDoc;
  assertEquals(doc.runs[0].results.length, 1);
  const [result] = doc.runs[0].results;
  assertEquals(result.ruleId, "badge-criteria-unavailable");
  assertEquals(result.level, "warning");
});
