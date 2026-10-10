# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline tests for BadgeApp source checks and proposal URL safety."""

from __future__ import annotations

import json
import unittest
from pathlib import Path

import check_badge_proposals as badge


ROOT = Path(__file__).resolve().parents[2]
SOURCE_SHA = "a" * 40


def proposal(**changes):
    data = {
        "schema_version": 1, "section": "passing", "source_sha": SOURCE_SHA,
        "human_reviewed": True, "metadata": {},
        "criteria": {"contribution": {
            "status": "Met",
            "justification": "The public contribution guide explains the pull-request process.",
            "approved": True, "evidence": ["CONTRIBUTING.md"],
        }},
    }
    data.update(changes)
    return data


class SourceCoherenceTests(unittest.TestCase):
    def test_current_repository_sources_are_coherent(self):
        self.assertEqual(badge.check_source_coherence(ROOT), [])

    def test_registry_is_pinned_and_section_specific(self):
        registry = badge.load_registry()
        self.assertEqual(
            {key: len(value) for key, value in registry["sections"].items()},
            {"passing": 67, "silver": 55, "gold": 22, "baseline-1": 24, "baseline-2": 19, "baseline-3": 21},
        )
        self.assertTrue(registry["source"]["metal"]["blob_sha"])
        self.assertTrue(registry["source"]["baseline"]["blob_sha"])


class ProposalValidationTests(unittest.TestCase):
    def test_valid_proposal_generates_encoded_url_and_pinned_evidence(self):
        data = proposal(metadata={"description": {
            "value": "A specification and implementation project with bounded claims.",
            "approved": True, "evidence": ["README.md"],
        }})
        url = badge.build_proposal_url(data, root=ROOT)
        self.assertTrue(url.startswith("https://www.bestpractices.dev/en/projects/15239/passing/edit?"))
        self.assertIn("contribution_status=Met", url)
        self.assertIn("contribution_justification=", url)
        self.assertIn("description=A+specification", url)
        self.assertIn(SOURCE_SHA, url)
        self.assertNotIn("overrides=", url)
        self.assertNotIn("reanalyze=", url)

    def test_metadata_requires_human_approval_and_evidence(self):
        data = proposal(criteria={})
        data["metadata"] = {"license": {"value":"Example","approved":False,"evidence":["LICENSE.md"]}}
        with self.assertRaisesRegex(badge.ProposalError, "explicit human approval"):
            badge.build_proposal_url(data, root=ROOT)

    def test_unknown_metadata_field_is_refused(self):
        data = proposal(metadata={"repository-code":{"value":"x","approved":True,"evidence":["README.md"]}})
        with self.assertRaisesRegex(badge.ProposalError, "unsupported metadata field"):
            badge.build_proposal_url(data, root=ROOT)

    def test_force_and_reanalysis_switches_are_refused(self):
        for key in ("overrides", "reanalyze"):
            data = proposal()
            data[key] = "1"
            with self.subTest(key=key), self.assertRaisesRegex(badge.ProposalError, "forbidden"):
                badge.build_proposal_url(data, root=ROOT)

    def test_unreviewed_proposal_is_refused(self):
        with self.assertRaisesRegex(badge.ProposalError, "human_reviewed"):
            badge.build_proposal_url(proposal(human_reviewed=False), root=ROOT)

    def test_invalid_section_and_criterion_are_refused(self):
        with self.assertRaisesRegex(badge.ProposalError, "unsupported BadgeApp section"):
            badge.build_proposal_url(proposal(section="all"), root=ROOT)
        data = proposal(criteria={"not_a_real_criterion":{
            "status":"Met","justification":"x","approved":True,"evidence":["README.md"]
        }})
        with self.assertRaisesRegex(badge.ProposalError, "not defined"):
            badge.build_proposal_url(data, root=ROOT)

    def test_unknown_status_cannot_reset_an_answer(self):
        data = proposal()
        data["criteria"]["contribution"]["status"] = "?"
        with self.assertRaisesRegex(badge.ProposalError, "status must be exactly"):
            badge.build_proposal_url(data, root=ROOT)

    def test_na_is_refused_when_not_permitted_upstream(self):
        data = proposal()
        data["criteria"]["contribution"]["status"] = "N/A"
        with self.assertRaisesRegex(badge.ProposalError, "does not permit N/A"):
            badge.build_proposal_url(data, root=ROOT)

    def test_evidence_must_be_present_and_https_if_external(self):
        data = proposal()
        data["criteria"]["contribution"]["evidence"] = []
        with self.assertRaisesRegex(badge.ProposalError, "requires evidence"):
            badge.build_proposal_url(data, root=ROOT)
        data["criteria"]["contribution"]["evidence"] = ["http://example.com/proof"]
        with self.assertRaisesRegex(badge.ProposalError, "must be HTTPS"):
            badge.build_proposal_url(data, root=ROOT)

    def test_evidence_paths_must_exist_and_stay_in_repository(self):
        data = proposal()
        data["criteria"]["contribution"]["evidence"] = ["missing.md"]
        with self.assertRaisesRegex(badge.ProposalError, "does not exist"):
            badge.build_proposal_url(data, root=ROOT)
        data["criteria"]["contribution"]["evidence"] = ["../outside.md"]
        with self.assertRaisesRegex(badge.ProposalError, "not normalized"):
            badge.build_proposal_url(data, root=ROOT)

    def test_met_url_required_criterion_uses_pinned_evidence(self):
        registry = badge.load_registry()
        self.assertTrue(registry["sections"]["passing"]["contribution"]["met_url_required"])
        url = badge.build_proposal_url(proposal(), root=ROOT, registry=registry)
        self.assertIn("https%3A%2F%2Fgithub.com%2FAntheaLiles%2Fk7pl%2Fblob%2F" + SOURCE_SHA + "%2FCONTRIBUTING.md", url)

    def test_credentials_in_evidence_url_are_refused(self):
        data = proposal()
        data["criteria"]["contribution"]["evidence"] = ["https://user:pass@example.com/proof"]
        with self.assertRaisesRegex(badge.ProposalError, "safe HTTPS URL"):
            badge.build_proposal_url(data, root=ROOT)

    def test_metadata_only_proposal_is_possible_after_decision(self):
        data = proposal(criteria={})
        data["metadata"] = {"name":{"value":"K7PL","approved":True,"evidence":["README.md"]}}
        self.assertIn("name=K7PL", badge.build_proposal_url(data, root=ROOT))

    def test_excessively_long_url_is_refused(self):
        data = proposal()
        data["criteria"]["contribution"]["justification"] = "x" * 7000
        with self.assertRaisesRegex(badge.ProposalError, "exceeds 6000"):
            badge.build_proposal_url(data, root=ROOT)


class UpstreamDriftTests(unittest.TestCase):
    class Response:
        def __init__(self, payload):
            self.payload = json.dumps(payload).encode("utf-8")
        def __enter__(self): return self
        def __exit__(self, *args): return False
        def read(self): return self.payload

    def test_unchanged_sources_are_reported(self):
        registry = badge.load_registry()
        responses = iter([
            {"sha": registry["source"]["metal"]["blob_sha"]},
            {"sha": registry["source"]["baseline"]["blob_sha"]},
        ])
        report = badge.upstream_drift_report(registry, opener=lambda req, timeout=15: self.Response(next(responses)))
        self.assertEqual(report["status"], "unchanged")
        self.assertEqual(len(report["checks"]), 2)

    def test_changed_source_is_reported_without_registry_mutation(self):
        registry = badge.load_registry()
        previous = registry["source"]["metal"]["blob_sha"]
        responses = iter([
            {"sha": "b" * 40},
            {"sha": registry["source"]["baseline"]["blob_sha"]},
        ])
        report = badge.upstream_drift_report(registry, opener=lambda req, timeout=15: self.Response(next(responses)))
        self.assertEqual(report["status"], "drift")
        self.assertEqual(len(report["drift"]), 1)
        self.assertEqual(registry["source"]["metal"]["blob_sha"], previous)

    def test_network_error_is_reported_as_unavailable(self):
        registry = badge.load_registry()
        def fail(request, timeout=15):
            raise OSError("network unavailable")
        report = badge.upstream_drift_report(registry, opener=fail)
        self.assertEqual(report["status"], "unavailable")
        self.assertEqual(len(report["errors"]), 2)


if __name__ == "__main__":
    unittest.main()
