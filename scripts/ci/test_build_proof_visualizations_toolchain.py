# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline tests: build_proof_visualizations.py keeps the two Lean toolchains apart.

The K7PL toolchain is read from the root lean-toolchain (it moves with scripts/bump-lean.sh); the
extractor's toolchain is the reviewed Paperproof pin, compared with the workspace's own file. A
root bump must therefore neither break the extractor checks nor leave a stale K7PL toolchain in
the generated artifacts.
"""

import json
import sys
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch

import build_proof_visualizations as viz

ROOT = Path(__file__).resolve().parents[2]
EXTRACTOR_DIR = viz.DEFAULT_EXTRACTOR_DIR
REV = "c" * 40


def write_repository(root: Path, main_toolchain: str, extractor_toolchain: str = viz.PAPERPROOF_TOOLCHAIN,
                     mathlib_rev: str | None = None) -> Path:
    """A repository root with a root lean-toolchain and a copy of the extractor workspace files."""
    (root / "lean-toolchain").write_text(main_toolchain + "\n", encoding="utf-8")
    extractor = root / EXTRACTOR_DIR
    extractor.mkdir(parents=True)
    (extractor / "lean-toolchain").write_text(extractor_toolchain + "\n", encoding="utf-8")
    lock = json.loads((ROOT / EXTRACTOR_DIR / "lake-manifest.json").read_text(encoding="utf-8"))
    if mathlib_rev is not None:
        next(p for p in lock["packages"] if p["name"] == "mathlib")["inputRev"] = mathlib_rev
    (extractor / "lake-manifest.json").write_text(json.dumps(lock), encoding="utf-8")
    return extractor


class MainToolchainTests(unittest.TestCase):
    def test_the_default_is_the_root_lean_toolchain(self):
        expected = (ROOT / "lean-toolchain").read_text(encoding="utf-8").strip()
        self.assertEqual(viz.read_main_toolchain(ROOT), expected)

    def test_a_bumped_root_toolchain_is_read_not_assumed(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "lean-toolchain").write_text("leanprover/lean4:v4.99.0\n", encoding="utf-8")
            self.assertEqual(viz.read_main_toolchain(root), "leanprover/lean4:v4.99.0")

    def test_an_unrecognised_root_toolchain_is_refused(self):
        for text in ("", "leanprover/lean4:nightly", "v4.34.0", "leanprover/lean4:v4.34.0 junk"):
            with self.subTest(text=text), tempfile.TemporaryDirectory() as tmp:
                (Path(tmp) / "lean-toolchain").write_text(text + "\n", encoding="utf-8")
                with self.assertRaisesRegex(ValueError, "unrecognised Lean toolchain"):
                    viz.read_main_toolchain(Path(tmp))

    def test_the_limits_name_both_toolchains_actually_used(self):
        target = viz.TARGETS[0]
        source = "theorem eval_double : True := by\n  trivial\n"
        export = {
            "steps": [{
                "tacticString": "trivial",
                "goalBefore": {"id": "?m.1", "hyps": []},
                "goalsAfter": [],
                "spawnedGoals": [],
                "tacticDependsOn": [],
                "position": {"start": {"line": 1, "character": 2}, "stop": {"line": 1, "character": 9}},
            }],
            "allGoals": [],
        }
        artifact = viz.build_artifact(target, export, source, REV, "leanprover/lean4:v4.99.0")
        self.assertEqual(artifact["provenance"]["k7plMainToolchain"], "leanprover/lean4:v4.99.0")
        self.assertEqual(artifact["provenance"]["paperproofToolchain"], viz.PAPERPROOF_TOOLCHAIN)
        limit = artifact["limits"][0]
        self.assertIn("leanprover/lean4:v4.99.0", limit)
        self.assertIn(viz.PAPERPROOF_TOOLCHAIN, limit)
        self.assertNotIn("4.34.0 build", limit.replace(viz.PAPERPROOF_TOOLCHAIN, ""))


class ExtractorPinTests(unittest.TestCase):
    def test_the_real_extractor_workspace_matches_the_reviewed_pins(self):
        viz.validate_lock(ROOT / EXTRACTOR_DIR)

    def test_a_root_bump_does_not_touch_the_extractor_checks(self):
        with tempfile.TemporaryDirectory() as tmp:
            extractor = write_repository(Path(tmp), "leanprover/lean4:v4.99.0")
            viz.validate_lock(extractor)

    def test_extractor_mathlib_must_follow_the_extractor_toolchain(self):
        release = viz.toolchain_release(viz.PAPERPROOF_TOOLCHAIN)
        with tempfile.TemporaryDirectory() as tmp:
            extractor = write_repository(Path(tmp), "leanprover/lean4:v4.99.0", mathlib_rev="v4.99.0")
            with self.assertRaisesRegex(ValueError, f"must use Mathlib {release}"):
                viz.validate_lock(extractor)

    def test_extractor_toolchain_drift_is_refused(self):
        with tempfile.TemporaryDirectory() as tmp:
            extractor = write_repository(Path(tmp), "leanprover/lean4:v4.99.0",
                                         extractor_toolchain="leanprover/lean4:v4.99.0")
            with self.assertRaisesRegex(ValueError, "Paperproof toolchain drift"):
                viz.validate_lock(extractor)


class CommandLineTests(unittest.TestCase):
    """`main` end to end, with the Lean extraction replaced by a canned export."""

    def run_main(self, root: Path, *extra: str) -> dict:
        data_dir = root / "data"

        def fake_extract(_root, _extractor, target, revision, main_toolchain, _output):
            return {"slug": target["slug"], "identity": {"declaration": target["declaration"]},
                    "extracted": {"steps": []}, "main": main_toolchain}

        argv = ["build_proof_visualizations.py", "--repo-root", str(root), "--data-dir", "data",
                "--ref", REV, "--extractor-dir", str(EXTRACTOR_DIR), *extra]
        with patch.object(sys, "argv", argv), \
             patch.object(viz, "validate_checkout_revision"), \
             patch.object(viz, "extract_one", side_effect=fake_extract), \
             patch("builtins.print"):
            self.assertEqual(viz.main(), 0)
        return json.loads((data_dir / "manifest.json").read_text(encoding="utf-8"))

    def test_the_manifest_records_the_root_toolchain_by_default(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            write_repository(root, "leanprover/lean4:v4.99.0")
            manifest = self.run_main(root)
        self.assertEqual(manifest["mainToolchain"], "leanprover/lean4:v4.99.0")
        self.assertEqual(manifest["extractorToolchain"], viz.PAPERPROOF_TOOLCHAIN)

    def test_an_explicit_main_toolchain_still_wins(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            write_repository(root, "leanprover/lean4:v4.99.0")
            manifest = self.run_main(root, "--main-toolchain", "leanprover/lean4:v4.98.0")
        self.assertEqual(manifest["mainToolchain"], "leanprover/lean4:v4.98.0")

    def test_validate_checkout_revision_is_not_bypassed_by_default(self):
        # Guard for the double above: the real main does call it with the --ref value.
        calls = []
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            write_repository(root, "leanprover/lean4:v4.99.0")
            argv = ["x", "--repo-root", str(root), "--ref", REV, "--extractor-dir", str(EXTRACTOR_DIR)]
            with patch.object(sys, "argv", argv), \
                 patch.object(viz.subprocess, "run",
                              side_effect=lambda *a, **k: calls.append(a) or SimpleNamespace(
                                  returncode=0, stdout="d" * 40 + "\n", stderr="")):
                with self.assertRaisesRegex(ValueError, "Source revision mismatch"):
                    viz.main()
        self.assertEqual(calls[0][0], ["git", "rev-parse", "HEAD"])


if __name__ == "__main__":
    unittest.main()
