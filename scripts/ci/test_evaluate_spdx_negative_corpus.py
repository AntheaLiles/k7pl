#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline tests for the non-gating SPDX mutation/evidence harness."""

from __future__ import annotations

import copy
import unittest

from evaluate_spdx_negative_corpus import PROBES, _coverage_summary


class NegativeCorpusTests(unittest.TestCase):
    def setUp(self) -> None:
        self.document = {
            "spdxVersion": "SPDX-2.3",
            "dataLicense": "CC0-1.0",
            "SPDXID": "SPDXRef-DOCUMENT",
            "name": "k7pl",
            "documentNamespace": "https://example.invalid/spdx",
            "packages": [
                {"name": "alpha", "SPDXID": "SPDXRef-alpha", "downloadLocation": "NOASSERTION",
                 "licenseDeclared": "NOASSERTION", "versionInfo": "a" * 40},
                {"name": "beta", "SPDXID": "SPDXRef-beta", "downloadLocation": "NOASSERTION",
                 "licenseDeclared": "NOASSERTION", "versionInfo": "b" * 40},
            ],
            "relationships": [
                {"spdxElementId": "SPDXRef-DOCUMENT", "relationshipType": "DESCRIBES",
                 "relatedSpdxElement": "SPDXRef-alpha"},
                {"spdxElementId": "SPDXRef-DOCUMENT", "relationshipType": "DESCRIBES",
                 "relatedSpdxElement": "SPDXRef-beta"},
            ],
        }

    def test_all_structured_probes_are_named_and_mutate_the_fixture(self) -> None:
        names = [name for name, _, _ in PROBES]
        self.assertEqual(len(names), len(set(names)))
        self.assertIn("empty-package-name-upstream-885", names)
        self.assertIn("unsupported-license-assertion", names)
        self.assertIn("spdx-2.2-version-in-2.3-run", names)
        self.assertIn("duplicate-relationship", names)

        for name, _hypothesis, mutate in PROBES:
            with self.subTest(probe=name):
                changed = copy.deepcopy(self.document)
                before = copy.deepcopy(changed)
                mutate(changed)
                self.assertNotEqual(changed, before, f"{name} did not change the fixture")

    def test_unsupported_license_assertion_is_explicitly_semantic(self) -> None:
        probe = next(item for item in PROBES if item[0] == "unsupported-license-assertion")
        changed = copy.deepcopy(self.document)
        probe[2](changed)
        self.assertEqual(changed["packages"][0]["licenseDeclared"], "MIT")
        # This proves only that the mutation is syntactically expressible; not whether the claim is true.

    def test_coverage_summary_does_not_claim_schema_coverage(self) -> None:
        report = {
            "positiveControl": {
                "wrapper": {"status": "PASS", "diagnosticRuleIds": []},
                "externalValidator": {"returnCode": 0},
            },
            "cases": [{
                "wrapper": {"status": "FAIL", "diagnosticRuleIds": ["SPDX-PREFLIGHT-PACKAGE-NAME"]},
                "externalValidator": {"returnCode": 0},
            }],
            "rawCases": [],
        }
        summary = _coverage_summary(report)
        self.assertTrue(summary["notASchemaCoverageClaim"])
        self.assertEqual(summary["mutationCases"], 1)
        self.assertIn("SPDX-PREFLIGHT-PACKAGE-NAME", summary["wrapperDiagnosticRuleIdsObserved"])
        self.assertEqual(summary["externalValidatorReturnCodeCounts"], {"0": 2})


if __name__ == "__main__":
    unittest.main()
