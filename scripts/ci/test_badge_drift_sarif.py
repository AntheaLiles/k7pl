#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the BadgeApp drift SARIF builder."""

import json
import unittest

import badge_criteria_drift_sarif as sarif


class SarifTests(unittest.TestCase):
    def test_unchanged_report_has_no_results(self):
        doc = sarif.build_sarif({"status": "unchanged", "drift": [], "errors": []})
        self.assertEqual(doc["version"], "2.1.0")
        self.assertEqual(doc["runs"][0]["results"], [])
        self.assertEqual(
            {rule["id"] for rule in doc["runs"][0]["tool"]["driver"]["rules"]},
            {"badge-criteria-drift", "badge-criteria-unavailable"},
        )

    def test_drift_produces_one_error_result_per_blob(self):
        doc = sarif.build_sarif(
            {
                "status": "drift",
                "drift": [
                    {
                        "path": "criteria/criteria.yml",
                        "expected_blob_sha": "a" * 40,
                        "observed_blob_sha": "b" * 40,
                    }
                ],
                "errors": [],
            }
        )
        (result,) = doc["runs"][0]["results"]
        self.assertEqual(result["ruleId"], "badge-criteria-drift")
        self.assertEqual(result["level"], "error")
        self.assertIn("criteria/criteria.yml", result["message"]["text"])
        location = result["locations"][0]["physicalLocation"]
        self.assertEqual(
            location["artifactLocation"]["uri"],
            "scripts/ci/badge_criteria_registry.json",
        )

    def test_unavailable_produces_a_warning_result(self):
        doc = sarif.build_sarif(
            {
                "status": "unavailable",
                "drift": [],
                "errors": [{"path": "criteria/criteria.yml", "error": "timeout"}],
            }
        )
        (result,) = doc["runs"][0]["results"]
        self.assertEqual(result["ruleId"], "badge-criteria-unavailable")
        self.assertEqual(result["level"], "warning")


if __name__ == "__main__":
    unittest.main()
