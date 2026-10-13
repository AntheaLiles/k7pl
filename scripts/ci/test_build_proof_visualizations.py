# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1
"""Offline contract tests for Paperproof extraction and static HTML generation."""

import json
import tempfile
import unittest
from pathlib import Path

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
    "tacticDependsOn": ["h"],
    "spawnedGoals": [{"username": "case_b", "type": "R", "hyps": [], "id": "?m.3"}],
    "position": {"start": {"line": 10, "character": 2}, "stop": {"line": 10, "character": 9}},
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

    def test_rejects_missing_source_positions(self):
        broken = {"steps": [dict(STEP, position={})], "allGoals": []}
        with self.assertRaisesRegex(ValueError, "position.start"):
            viz.validate_export(broken)

    def test_source_and_provenance_are_separated_from_verification(self):
        artifact = viz.build_artifact(TARGET, EXPORT, SOURCE, REV, "leanprover/lean4:v4.34.0")
        self.assertEqual(artifact["identity"]["declarationLine"], 3)
        self.assertEqual(artifact["identity"]["sourceRevision"], REV)
        self.assertEqual(artifact["provenance"]["paperproofRevision"], viz.PAPERPROOF_REVISION)
        self.assertFalse(artifact["guarantees"]["k7plMainToolchainVerifiedByThisArtifact"])

    def test_renderer_distinguishes_goal_transitions_and_created_branches(self):
        url = f"https://github.com/AntheaLiles/k7pl/blob/{REV}/src/K7pl/Arith.lean#L3-L12"
        page = viz.render_step(STEP, 1, url)
        self.assertIn("Objectif avant la tactique", page)
        self.assertIn("Objectifs après (1)", page)
        self.assertIn("Objectifs créés hors de la branche associée (1)", page)
        self.assertIn(f"blob/{REV}/src/K7pl/Arith.lean#L11-L11", page)

    def test_html_escapes_goal_and_hypothesis_text(self):
        goal = {"type": "<script>alert(1)</script>", "hyps": [{"username": "<h>", "type": "P", "isProof": "proof"}]}
        rendered = viz.render_goal(goal, "Objectif")
        self.assertNotIn("<script>", rendered)
        self.assertIn("&lt;script&gt;", rendered)
        self.assertIn("&lt;h&gt;", rendered)

    def test_nav_injection_is_idempotent(self):
        with tempfile.TemporaryDirectory() as temp:
            nav = Path(temp) / "index.html"
            nav.write_text('<nav><a href="../index.html">Retour</a></nav>', encoding="utf-8")
            viz.inject_nav_link(nav)
            viz.inject_nav_link(nav)
            self.assertEqual(nav.read_text(encoding="utf-8").count("Visualisations de preuves"), 1)

    def test_site_validator_rejects_stale_source_revision(self):
        with tempfile.TemporaryDirectory() as temp:
            site = Path(temp)
            (site / "navigation").mkdir()
            (site / "navigation/index.html").write_text(
                '<nav><a href="../proofs/index.html">Visualisations de preuves</a></nav>', encoding="utf-8")
            output = site / "proofs"
            (output / "data").mkdir(parents=True)
            artifact = viz.build_artifact(TARGET, EXPORT, SOURCE, REV, "leanprover/lean4:v4.34.0")
            (output / "index.html").write_text(viz.render_index([artifact], REV), encoding="utf-8")
            (output / "sample-proof.html").write_text(viz.render_proof(artifact), encoding="utf-8")
            (output / "data/sample-proof.json").write_text(json.dumps(artifact), encoding="utf-8")
            viz.validate_site(site, [artifact], REV)
            stale = viz.build_artifact(TARGET, EXPORT, SOURCE, "e" * 40, "leanprover/lean4:v4.34.0")
            with self.assertRaisesRegex(ValueError, "source revision mismatch"):
                viz.validate_site(site, [stale], REV)


if __name__ == "__main__":
    unittest.main()
