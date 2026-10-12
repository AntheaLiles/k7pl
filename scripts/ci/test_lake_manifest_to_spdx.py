# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline tests for the scoped Lake-to-SPDX inventory generator."""

import copy
import json
import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "scripts" / "ci"))

from lake_manifest_to_spdx import generate_sbom, normalize_created  # noqa: E402

REAL_MANIFEST = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
REAL_LAKEFILE = (ROOT / "lakefile.lean").read_text(encoding="utf-8")
REAL_TOOLCHAIN = (ROOT / "lean-toolchain").read_text(encoding="utf-8")
CREATED = "2026-10-10T00:00:00Z"


class SbomTests(unittest.TestCase):
    def generate(self, manifest=REAL_MANIFEST):
        return generate_sbom(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN, CREATED)

    def test_real_manifest_preserves_every_package_url_and_revision(self):
        result = self.generate()
        self.assertEqual(result["spdxVersion"], "SPDX-2.3")
        self.assertEqual(result["dataLicense"], "CC0-1.0")
        self.assertEqual(len(result["packages"]), len(REAL_MANIFEST["packages"]))
        by_name = {package["name"]: package for package in result["packages"]}
        self.assertEqual(set(by_name), {package["name"] for package in REAL_MANIFEST["packages"]})
        for entry in REAL_MANIFEST["packages"]:
            package = by_name[entry["name"]]
            self.assertEqual(package["downloadLocation"], entry["url"])
            self.assertEqual(package["versionInfo"], entry["rev"])
            self.assertEqual(package["licenseDeclared"], "NOASSERTION")
            self.assertEqual(package["licenseConcluded"], "NOASSERTION")
            self.assertEqual(package["copyrightText"], "NOASSERTION")

    def test_inventory_relations_do_not_invent_dependency_edges(self):
        result = self.generate()
        package_ids = {package["SPDXID"] for package in result["packages"]}
        described_ids = {
            relation["relatedSpdxElement"]
            for relation in result["relationships"]
            if relation["spdxElementId"] == "SPDXRef-DOCUMENT"
            and relation["relationshipType"] == "DESCRIBES"
        }
        self.assertEqual(described_ids, package_ids)
        self.assertFalse(any(relation["relationshipType"] == "DEPENDS_ON" for relation in result["relationships"]))

    def test_output_is_deterministic_for_same_manifest_and_timestamp(self):
        first = self.generate()
        reversed_manifest = copy.deepcopy(REAL_MANIFEST)
        reversed_manifest["packages"].reverse()
        self.assertEqual(first, self.generate(reversed_manifest))

    def test_cli_output_is_byte_reproducible_for_fixed_timestamp(self):
        with tempfile.TemporaryDirectory() as directory:
            first_path = Path(directory) / "first.spdx.json"
            second_path = Path(directory) / "second.spdx.json"
            command = [
                sys.executable,
                str(ROOT / "scripts" / "ci" / "lake_manifest_to_spdx.py"),
                "--created",
                CREATED,
            ]
            for output_path in (first_path, second_path):
                completed = subprocess.run(
                    [*command, "--output", str(output_path)],
                    cwd=ROOT,
                    check=False,
                    capture_output=True,
                    text=True,
                )
                self.assertEqual(completed.returncode, 0, completed.stderr)
            self.assertEqual(first_path.read_bytes(), second_path.read_bytes())

    def test_document_namespace_changes_when_inventory_changes(self):
        changed = copy.deepcopy(REAL_MANIFEST)
        changed["packages"][0]["scope"] = "different-scope"
        first = self.generate()
        second = self.generate(changed)
        self.assertNotEqual(first["documentNamespace"], second["documentNamespace"])

    def test_invalid_manifest_is_rejected(self):
        changed = copy.deepcopy(REAL_MANIFEST)
        changed["packages"][0]["rev"] = "not-a-commit"
        with self.assertRaisesRegex(ValueError, "40 lowercase hexadecimal"):
            self.generate(changed)

    def test_created_timestamp_is_normalized_to_utc(self):
        self.assertEqual(normalize_created("2026-10-10T02:00:00+02:00"), CREATED)

    def test_created_timestamp_requires_timezone(self):
        with self.assertRaisesRegex(ValueError, "explicit timezone"):
            normalize_created("2026-10-10T00:00:00")

    def test_source_date_epoch_is_used_when_timestamp_is_omitted(self):
        with patch.dict(os.environ, {"SOURCE_DATE_EPOCH": "1791590400"}):
            self.assertEqual(normalize_created(), "2026-10-10T00:00:00Z")


if __name__ == "__main__":
    unittest.main()
