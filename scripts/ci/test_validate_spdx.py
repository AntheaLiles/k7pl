#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline regression tests for K7PL's guard around the external SPDX validator."""

from __future__ import annotations

import unittest

from validate_spdx import preflight_issues


class PreflightTests(unittest.TestCase):
    def test_named_package_has_no_preflight_issue(self) -> None:
        document = {"packages": [{"name": "mathlib"}]}
        self.assertEqual(preflight_issues(document), [])

    def test_empty_name_is_rejected_for_known_upstream_gap(self) -> None:
        document = {"packages": [{"name": ""}]}
        issues = preflight_issues(document)
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGE-NAME"])
        self.assertIn("#885", issues[0]["message"])

    def test_missing_name_is_rejected(self) -> None:
        issues = preflight_issues({"packages": [{}]})
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGE-NAME"])

    def test_whitespace_only_name_is_rejected(self) -> None:
        issues = preflight_issues({"packages": [{"name": "   "}]})
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGE-NAME"])

    def test_non_object_package_is_rejected(self) -> None:
        issues = preflight_issues({"packages": ["not-an-object"]})
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGE"])

    def test_missing_packages_array_is_rejected(self) -> None:
        issues = preflight_issues({})
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGES"])

    def test_non_object_document_is_rejected(self) -> None:
        issues = preflight_issues([])
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-DOCUMENT"])


if __name__ == "__main__":
    unittest.main()
