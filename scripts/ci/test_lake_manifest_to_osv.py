# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline tests for the Lake-to-OSV-Scanner adapter."""

import copy
import json
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "scripts" / "ci"))

from lake_manifest_to_osv import convert_manifest  # noqa: E402

REAL_MANIFEST = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
REAL_LAKEFILE = (ROOT / "lakefile.lean").read_text(encoding="utf-8")
REAL_TOOLCHAIN = (ROOT / "lean-toolchain").read_text(encoding="utf-8")


class ConversionTests(unittest.TestCase):
    def test_real_manifest_is_converted_without_losing_revisions(self):
        result = convert_manifest(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN)
        packages = result["results"][0]["packages"]
        self.assertEqual(len(packages), len(REAL_MANIFEST["packages"]))
        by_url = {item["package"]["name"]: item["package"]["commit"] for item in packages}
        for package in REAL_MANIFEST["packages"]:
            self.assertEqual(
                by_url[package["url"].removeprefix("https://")],
                package["rev"],
            )

    def test_output_is_deterministic_independent_of_manifest_order(self):
        first = convert_manifest(REAL_MANIFEST)
        reversed_manifest = copy.deepcopy(REAL_MANIFEST)
        reversed_manifest["packages"].reverse()
        self.assertEqual(first, convert_manifest(reversed_manifest, REAL_LAKEFILE, REAL_TOOLCHAIN))

    def test_invalid_repository_is_rejected(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"][0]["url"] = "https://example.invalid/attacker/repo"
        with self.assertRaisesRegex(ValueError, "url"):
            convert_manifest(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)

    def test_non_commit_revision_is_rejected(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"][0]["rev"] = "main"
        with self.assertRaisesRegex(ValueError, "40 lowercase hexadecimal"):
            convert_manifest(manifest)

    def test_empty_dependency_list_is_rejected(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"] = []
        with self.assertRaisesRegex(ValueError, "missing, empty or not a list"):
            convert_manifest(manifest)

    def test_lakefile_revision_mismatch_is_rejected(self):
        mismatched_lakefile = REAL_LAKEFILE.replace(
            '"https://github.com/leanprover/verso" @ "v4.34.0"',
            '"https://github.com/leanprover/verso" @ "v4.33.0"',
        )
        self.assertNotEqual(mismatched_lakefile, REAL_LAKEFILE)
        with self.assertRaisesRegex(ValueError, "inconsistent Lake inputs"):
            convert_manifest(REAL_MANIFEST, mismatched_lakefile, REAL_TOOLCHAIN)

    def test_toolchain_mismatch_is_rejected(self):
        with self.assertRaisesRegex(ValueError, "inconsistent Lake inputs"):
            convert_manifest(REAL_MANIFEST, REAL_LAKEFILE, "leanprover/lean4:v4.0.1\\n")


if __name__ == "__main__":
    unittest.main()
