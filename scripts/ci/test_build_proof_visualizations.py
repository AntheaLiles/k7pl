# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: Apache-2.0
"""Offline contract tests for Paperproof extraction and the Verso data contract."""

import json
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch

import build_proof_visualizations as viz

REV = "d" * 40
TARGET = {
    "slug": "sample-proof",
    "title": "Preuve d’essai",
    "source": "src/K7pl/Arith.lean",
    "declaration": "K7pl.Arith.sample",
    "description": "Petit exemple de test.",
}
GOAL = {
    "username": "⊢",
    "type": "P",
    "hyps": [{"username": "h", "type": "P", "value": None, "id": "fvar.h", "isProof": "proof"}],
    "id": "?m.1",
}
STEP = {
    "tacticString": "cases h",
    "goalBefore": GOAL,
    "goalsAfter": [{"username": "case_a", "type": "Q", "hyps": [], "id": "?m.2"}],
    "tacticDependsOn": ["fvar.h"],
    "spawnedGoals": [{"username": "case_b", "type": "R", "hyps": [], "id": "?m.3"}],
    "position": {"start": {"line": 3, "character": 2}, "stop": {"line": 3, "character": 9}},
    "theorems": [],
}
EXPORT = {"steps": [STEP], "allGoals": [GOAL]}
SOURCE = "namespace K7pl.Arith\n\ntheorem sample : P := by\n  cases h\nend K7pl.Arith\n"


class PaperproofExportTests(unittest.TestCase):
    def test_accepts_export_with_branching(self):
        self.assertEqual(len(viz.validate_export(EXPORT)["steps"][0]["spawnedGoals"]), 1)

    def test_rejects_empty_export_instead_of_fabricating_steps(self):
        with self.assertRaisesRegex(ValueError, "no tactic steps"):
            viz.validate_export({"steps": [], "allGoals": []})

    def test_rejects_missing_tactic_dependency_ids(self):
        broken = dict(STEP)
        broken.pop("tacticDependsOn")
        with self.assertRaisesRegex(ValueError, r"tacticDependsOn must be an array"):
            viz.validate_export({"steps": [broken], "allGoals": [GOAL]})

    def test_rejects_malformed_tactic_dependency_ids(self):
        broken = dict(STEP, tacticDependsOn=["fvar.h", 7])
        with self.assertRaisesRegex(ValueError, r"tacticDependsOn\[1\] must be a non-empty string identifier"):
            viz.validate_export({"steps": [broken], "allGoals": [GOAL]})

    def test_preserves_exact_dependency_identifiers_for_context_resolution(self):
        artifact = viz.build_artifact(TARGET, EXPORT, SOURCE, REV, "leanprover/lean4:v4.34.0")
        step = artifact["extracted"]["steps"][0]
        known_ids = {
            hypothesis["id"]
            for goal in [step["goalBefore"], *step["goalsAfter"], *step["spawnedGoals"]]
            for hypothesis in goal["hyps"]
            if isinstance(hypothesis.get("id"), str)
        }
        self.assertEqual(step["tacticDependsOn"], ["fvar.h"])
        self.assertIn(step["tacticDependsOn"][0], known_ids)

    def test_rejects_missing_source_positions(self):
        broken = {"steps": [dict(STEP, position={})], "allGoals": []}
        with self.assertRaisesRegex(ValueError, "position.start"):
            viz.validate_export(broken)

    def test_rejects_source_positions_outside_the_actual_file(self):
        bad_step = dict(STEP, position={
            "start": {"line": 99, "character": 0},
            "stop": {"line": 99, "character": 3},
        })
        with self.assertRaisesRegex(ValueError, "fall outside the source span"):
            viz.build_artifact(
                TARGET, {"steps": [bad_step], "allGoals": [GOAL]},
                SOURCE, REV, "leanprover/lean4:v4.34.0"
            )

    def test_rejects_reversed_source_positions(self):
        bad_step = dict(STEP, position={
            "start": {"line": 3, "character": 9},
            "stop": {"line": 3, "character": 2},
        })
        with self.assertRaisesRegex(ValueError, "stop before its start"):
            viz.validate_export({"steps": [bad_step], "allGoals": [GOAL]})

    def test_checkout_revision_requires_a_full_sha(self):
        with self.assertRaisesRegex(ValueError, "full, lowercase 40-character"):
            viz.validate_checkout_revision(Path("."), "main")

    def test_checkout_revision_rejects_a_stale_or_mismatched_tree(self):
        checked_out = "e" * 40
        with patch.object(
            viz.subprocess, "run",
            return_value=SimpleNamespace(returncode=0, stdout=checked_out + "\n", stderr="")
        ):
            with self.assertRaisesRegex(ValueError, "Source revision mismatch"):
                viz.validate_checkout_revision(Path("."), REV)

    def test_checkout_revision_accepts_the_exact_checkout_sha(self):
        with patch.object(
            viz.subprocess, "run",
            return_value=SimpleNamespace(returncode=0, stdout=REV + "\n", stderr="")
        ):
            viz.validate_checkout_revision(Path("."), REV)

    def test_source_and_provenance_are_separated_from_verification(self):
        artifact = viz.build_artifact(TARGET, EXPORT, SOURCE, REV, "leanprover/lean4:v4.34.0")
        self.assertEqual(artifact["identity"]["declarationLine"], 3)
        self.assertEqual(artifact["identity"]["sourceRevision"], REV)
        self.assertEqual(artifact["provenance"]["paperproofRevision"], viz.PAPERPROOF_REVISION)
        self.assertFalse(artifact["guarantees"]["k7plMainToolchainVerifiedByThisArtifact"])

    def test_extractor_stages_exact_source_inside_workspace_and_cleans_it(self):
        with tempfile.TemporaryDirectory() as root_dir, \
             tempfile.TemporaryDirectory() as extractor_dir, \
             tempfile.TemporaryDirectory() as output_dir:
            root = Path(root_dir)
            extractor = Path(extractor_dir)
            source_path = root / TARGET["source"]
            source_path.parent.mkdir(parents=True)
            source_path.write_text(SOURCE, encoding="utf-8")
            staged_paths = []

            def fake_run(command, cwd, text, capture_output, check):
                staged = Path(command[3]).resolve()
                self.assertTrue(staged.is_relative_to(extractor.resolve()))
                self.assertEqual(staged.read_text(encoding="utf-8"), SOURCE)
                self.assertEqual(command[4], TARGET["declaration"])
                Path(command[5]).write_text(json.dumps(EXPORT), encoding="utf-8")
                staged_paths.append(staged)
                return SimpleNamespace(returncode=0, stdout="", stderr="")

            with patch.object(viz.subprocess, "run", side_effect=fake_run):
                artifact = viz.extract_one(
                    root, extractor, TARGET, REV, "leanprover/lean4:v4.34.0", Path(output_dir)
                )

            self.assertEqual(artifact["identity"]["sourceSha256"], viz.hashlib.sha256(SOURCE.encode("utf-8")).hexdigest())
            self.assertTrue(staged_paths)
            self.assertFalse(staged_paths[0].exists())
            self.assertFalse((Path(output_dir) / ".sample-proof.paperproof.json").exists())


    def test_every_curated_target_resolves_to_one_real_declaration(self):
        repo_root = Path(viz.__file__).resolve().parents[2]
        self.assertGreaterEqual(len(viz.TARGETS), 5)
        seen = set()
        for target in viz.TARGETS:
            identity = (target["source"], target["declaration"])
            self.assertNotIn(identity, seen)
            seen.add(identity)
            source_path = repo_root / target["source"]
            self.assertTrue(source_path.is_file(), f"missing source: {target['source']}")
            source = source_path.read_text(encoding="utf-8")
            line = viz.declaration_line(source, target["declaration"])
            self.assertGreater(line, 0, target["declaration"])

    def test_artifact_preserves_full_observed_steps_without_claiming_authority(self):
        artifact = viz.build_artifact(TARGET, EXPORT, SOURCE, REV, "leanprover/lean4:v4.34.0")
        step = artifact["extracted"]["steps"][0]
        self.assertEqual(step["tacticDependsOn"], ["fvar.h"])
        self.assertEqual(step["goalsAfter"][0]["id"], "?m.2")
        self.assertEqual(step["spawnedGoals"][0]["id"], "?m.3")
        self.assertEqual(artifact["schemaVersion"], "k7pl.proof-visualization/v1")
        self.assertFalse(artifact["guarantees"]["semanticCorrespondenceToNormativeSpecificationEstablished"])


if __name__ == "__main__":
    unittest.main()
