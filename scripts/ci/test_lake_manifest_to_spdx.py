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

import check_manifest  # noqa: E402
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


PAPERPROOF_DIR = ROOT / check_manifest.PAPERPROOF_DIRECTORY
PAPERPROOF_LABEL = f"{check_manifest.PAPERPROOF_DIRECTORY}/lake-manifest.json"
PAPERPROOF_MANIFEST = json.loads((PAPERPROOF_DIR / "lake-manifest.json").read_text(encoding="utf-8"))
PAPERPROOF_LAKEFILE = (PAPERPROOF_DIR / "lakefile.lean").read_text(encoding="utf-8")
PAPERPROOF_TOOLCHAIN = (PAPERPROOF_DIR / "lean-toolchain").read_text(encoding="utf-8")
SCRIPT = ROOT / "scripts" / "ci" / "lake_manifest_to_spdx.py"


class WorkspaceDocumentTests(unittest.TestCase):
    """One document per Lake workspace; the root document keeps its identity."""

    def paperproof(self):
        return generate_sbom(PAPERPROOF_MANIFEST, PAPERPROOF_LAKEFILE, PAPERPROOF_TOOLCHAIN, CREATED,
                             check_manifest.PAPERPROOF_WORKSPACE)

    def test_the_root_document_keeps_its_name_and_comments(self):
        result = generate_sbom(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN, CREATED)
        self.assertEqual(result["name"], "K7PL Lake dependency inventory")
        self.assertTrue(result["comment"].startswith(
            "Scoped inventory generated from lake-manifest.json. It covers only the package entries"))
        self.assertTrue(all(p["packageComment"].startswith("Listed in lake-manifest.json. ")
                            for p in result["packages"]))

    def test_the_paperproof_document_says_what_it_describes(self):
        result = self.paperproof()
        self.assertEqual(result["name"], f"K7PL Lake dependency inventory ({check_manifest.PAPERPROOF_DIRECTORY})")
        self.assertIn(f"generated from {PAPERPROOF_LABEL}", result["comment"])
        self.assertIn("not a dependency of the k7pl Lake package", result["comment"])
        self.assertTrue(all(p["packageComment"].startswith(f"Listed in {PAPERPROOF_LABEL}. ")
                            for p in result["packages"]))
        by_name = {p["name"]: p for p in result["packages"]}
        self.assertEqual(set(by_name), {p["name"] for p in PAPERPROOF_MANIFEST["packages"]})
        for entry in PAPERPROOF_MANIFEST["packages"]:
            self.assertEqual(by_name[entry["name"]]["versionInfo"], entry["rev"])
            self.assertEqual(by_name[entry["name"]]["downloadLocation"], entry["url"])

    def test_the_two_documents_have_distinct_namespaces(self):
        root = generate_sbom(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN, CREATED)
        self.assertNotEqual(root["documentNamespace"], self.paperproof()["documentNamespace"])

    def test_the_paperproof_manifest_is_refused_under_the_root_rules(self):
        with self.assertRaisesRegex(ValueError, "invalid Lake manifest"):
            generate_sbom(PAPERPROOF_MANIFEST, PAPERPROOF_LAKEFILE, PAPERPROOF_TOOLCHAIN, CREATED)

    def test_cli_defaults_to_the_files_of_the_manifest_workspace(self):
        with tempfile.TemporaryDirectory() as directory:
            outputs = [Path(directory) / name for name in ("first.spdx.json", "second.spdx.json")]
            for output in outputs:
                completed = subprocess.run(
                    [sys.executable, str(SCRIPT), "--manifest", PAPERPROOF_LABEL,
                     "--created", CREATED, "--output", str(output)],
                    cwd=ROOT, check=False, capture_output=True, text=True,
                )
                self.assertEqual(completed.returncode, 0, completed.stderr)
            self.assertEqual(outputs[0].read_bytes(), outputs[1].read_bytes())
            self.assertEqual(json.loads(outputs[0].read_text(encoding="utf-8")), self.paperproof())
            # An explicit lakefile still overrides the workspace default (and is checked).
            completed = subprocess.run(
                [sys.executable, str(SCRIPT), "--manifest", PAPERPROOF_LABEL,
                 "--lakefile", "lakefile.lean", "--created", CREATED, "--output", str(outputs[0])],
                cwd=ROOT, check=False, capture_output=True, text=True,
            )
            self.assertEqual(completed.returncode, 1)
            self.assertIn("inconsistent Lake inputs", completed.stderr)


if __name__ == "__main__":
    unittest.main()
