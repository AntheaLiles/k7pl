# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline tests for the Lake-to-OSV-Scanner adapter."""

import copy
import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "scripts" / "ci"))

import check_manifest  # noqa: E402
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
        first = convert_manifest(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN)
        reversed_manifest = copy.deepcopy(REAL_MANIFEST)
        reversed_manifest["packages"].reverse()
        self.assertEqual(
            first,
            convert_manifest(reversed_manifest, REAL_LAKEFILE, REAL_TOOLCHAIN),
        )

    def test_invalid_repository_is_rejected(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"][0]["url"] = "https://example.invalid/attacker/repo"
        with self.assertRaisesRegex(ValueError, "url"):
            convert_manifest(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)

    def test_non_commit_revision_is_rejected(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"][0]["rev"] = "main"
        with self.assertRaisesRegex(ValueError, "40 lowercase hexadecimal"):
            convert_manifest(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)

    def test_empty_dependency_list_is_rejected(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"] = []
        with self.assertRaisesRegex(ValueError, "missing, empty or not a list"):
            convert_manifest(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)

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
            convert_manifest(REAL_MANIFEST, REAL_LAKEFILE, "leanprover/lean4:v4.0.1\n")


    def test_deterministic_adversarial_mutation_corpus_rejects_untrusted_manifest_shapes(self):
        """Bounded mutation testing for the real Lake-to-OSV input boundary (no network)."""
        cases = []

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["unexpectedRootField"] = "must not be ignored"
        cases.append(("unknown-root-key", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"][0]["unexpectedPackageField"] = "must not be ignored"
        cases.append(("unknown-package-key", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"][0]["type"] = "archive"
        cases.append(("non-git-package", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"][0]["inherited"] = "false"
        cases.append(("non-boolean-inherited", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"][0]["scope"] = "../../outside"
        cases.append(("path-traversal-scope", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"][0]["rev"] = "A" * 40
        cases.append(("uppercase-revision", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"][0]["url"] = "https://example.invalid/attacker/repo"
        cases.append(("untrusted-repository", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"].append(copy.deepcopy(candidate["packages"][0]))
        cases.append(("duplicate-package", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"][0] = None
        cases.append(("non-object-package", candidate))

        candidate = copy.deepcopy(REAL_MANIFEST)
        candidate["packages"] = None
        cases.append(("non-list-package-container", candidate))

        for case_name, candidate in cases:
            with self.subTest(case=case_name):
                with self.assertRaises(ValueError):
                    convert_manifest(candidate, REAL_LAKEFILE, REAL_TOOLCHAIN)

    def test_adversarial_mutation_corpus_does_not_change_valid_pin_projection(self):
        """Permutation is benign: normalized OSV output must retain every exact commit pin."""
        baseline = convert_manifest(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN)
        for rotation in range(1, len(REAL_MANIFEST["packages"])):
            candidate = copy.deepcopy(REAL_MANIFEST)
            candidate["packages"] = (
                candidate["packages"][rotation:] + candidate["packages"][:rotation]
            )
            with self.subTest(rotation=rotation):
                projected = convert_manifest(candidate, REAL_LAKEFILE, REAL_TOOLCHAIN)
                self.assertEqual(projected, baseline)
                projected_pins = {
                    item["package"]["name"]: item["package"]["commit"]
                    for item in projected["results"][0]["packages"]
                }
                for package in REAL_MANIFEST["packages"]:
                    self.assertEqual(
                        projected_pins[package["url"].removeprefix("https://")],
                        package["rev"],
                    )

class SharedLoadingTests(unittest.TestCase):
    """Loading and validation come from check_manifest.py: the same rules, the same workspace choice."""

    SCRIPT = ROOT / "scripts" / "ci" / "lake_manifest_to_osv.py"
    PAPERPROOF = ROOT / check_manifest.PAPERPROOF_DIRECTORY

    def run_cli(self, *args):
        return subprocess.run([sys.executable, str(self.SCRIPT), *args], cwd=ROOT, check=False,
                              capture_output=True, text=True)

    def test_the_paperproof_workspace_is_converted_under_its_own_rules(self):
        manifest = json.loads((self.PAPERPROOF / "lake-manifest.json").read_text(encoding="utf-8"))
        lakefile = (self.PAPERPROOF / "lakefile.lean").read_text(encoding="utf-8")
        toolchain = (self.PAPERPROOF / "lean-toolchain").read_text(encoding="utf-8")
        result = convert_manifest(manifest, lakefile, toolchain, check_manifest.PAPERPROOF_WORKSPACE)
        names = {item["package"]["name"] for item in result["results"][0]["packages"]}
        self.assertIn("github.com/Paper-Proof/paperproof", names)
        self.assertEqual(len(names), len(manifest["packages"]))
        with self.assertRaisesRegex(ValueError, "invalid Lake manifest"):
            convert_manifest(manifest, lakefile, toolchain)  # the root workspace refuses Paperproof

    def test_cli_picks_the_workspace_from_the_manifest_path(self):
        with tempfile.TemporaryDirectory() as tmp:
            output = Path(tmp) / "osv.json"
            completed = self.run_cli("--manifest", str(self.PAPERPROOF / "lake-manifest.json"),
                                     "--output", str(output))
            self.assertEqual(completed.returncode, 0, completed.stderr)
            self.assertIn("10 pinned Lake Git dependencies", completed.stdout)
            # The same bytes elsewhere are judged by the root workspace's rules, and refused.
            copied = Path(tmp) / "lake-manifest.json"
            copied.write_bytes((self.PAPERPROOF / "lake-manifest.json").read_bytes())
            completed = self.run_cli("--manifest", str(copied), "--output", str(output))
            self.assertEqual(completed.returncode, 1)
            self.assertIn("Paperproof: not one of the known packages", completed.stderr)

    def test_cli_refuses_oversized_and_symlinked_manifests(self):
        with tempfile.TemporaryDirectory() as tmp:
            output = Path(tmp) / "osv.json"
            big = Path(tmp) / "big.json"
            big.write_text(" " * (check_manifest.MAX_MANIFEST_BYTES + 1), encoding="utf-8")
            completed = self.run_cli("--manifest", str(big), "--output", str(output))
            self.assertEqual(completed.returncode, 1)
            self.assertIn("is larger than", completed.stderr)
            link = Path(tmp) / "link.json"
            try:
                link.symlink_to(ROOT / "lake-manifest.json")
            except OSError:
                self.skipTest("symbolic links are not available")
            completed = self.run_cli("--manifest", str(link), "--output", str(output))
            self.assertEqual(completed.returncode, 1)
            self.assertIn("not a regular file", completed.stderr)
            self.assertFalse(output.exists())


if __name__ == "__main__":
    unittest.main()
