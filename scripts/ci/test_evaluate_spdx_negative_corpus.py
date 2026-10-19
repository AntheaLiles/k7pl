#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline tests for the non-gating SPDX mutation/evidence harness."""

from __future__ import annotations

import copy
import json
import os
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from evaluate_spdx_negative_corpus import (
    PROBES,
    ROOT,
    WRAPPER,
    _coverage_summary,
    _tool_input_hashes,
    _workflow_context,
    sha256_file,
)


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
        self.assertIn("unknown-top-level-field", names)
        self.assertIn("spdx-2.2-version-in-2.3-run", names)
        self.assertIn("duplicate-relationship", names)

        for name, _hypothesis, mutate in PROBES:
            with self.subTest(probe=name):
                changed = copy.deepcopy(self.document)
                before = copy.deepcopy(changed)
                mutate(changed)
                self.assertNotEqual(changed, before, f"{name} did not change the fixture")

    def test_workflow_context_records_run_and_pull_request_identity(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            event_path = Path(temporary) / "event.json"
            event_path.write_text(
                json.dumps({"pull_request": {"head": {"sha": "pull-request-head-sha"}}}),
                encoding="utf-8",
            )
            environment = {
                "GITHUB_EVENT_PATH": str(event_path),
                "GITHUB_RUN_ID": "38953520978",
                "GITHUB_RUN_ATTEMPT": "1",
                "GITHUB_SHA": "workflow-checked-out-sha",
            }
            with patch.dict(os.environ, environment, clear=True):
                workflow = _workflow_context()

        self.assertEqual(workflow["runId"], 38953520978)
        self.assertEqual(workflow["runAttempt"], 1)
        self.assertEqual(workflow["checkedOutSha"], "workflow-checked-out-sha")
        self.assertEqual(workflow["pullRequestHeadSha"], "pull-request-head-sha")

    def test_missing_or_malformed_event_does_not_invent_pull_request_head(self) -> None:
        with patch.dict(os.environ, {"GITHUB_SHA": "checked-out-sha"}, clear=True):
            workflow = _workflow_context()
        self.assertEqual(workflow["checkedOutSha"], "checked-out-sha")
        self.assertIsNone(workflow["pullRequestHeadSha"])
        self.assertIsNone(workflow["runId"])

    def test_tool_input_hashes_bind_all_relevant_sources_and_locks(self) -> None:
        hashes = _tool_input_hashes()
        expected_keys = {
            "negativeCorpusScriptSha256",
            "sbomGeneratorSha256",
            "spdxValidatorWrapperSha256",
            "digestHelperSha256",
            "benchmarkScriptSha256",
            "lakeManifestSha256",
            "lakefileSha256",
            "leanToolchainSha256",
            "ciRequirementsLockSha256",
            "spdxValidatorRequirementsLockSha256",
        }
        self.assertEqual(set(hashes), expected_keys)
        self.assertTrue(all(len(value) == 64 and all(c in "0123456789abcdef" for c in value) for value in hashes.values()))
        self.assertEqual(hashes["negativeCorpusScriptSha256"], sha256_file(Path(__file__).resolve().with_name("evaluate_spdx_negative_corpus.py")))
        self.assertEqual(hashes["spdxValidatorWrapperSha256"], sha256_file(WRAPPER))
        self.assertEqual(hashes["lakeManifestSha256"], sha256_file(ROOT / "lake-manifest.json"))

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
