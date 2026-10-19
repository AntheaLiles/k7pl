# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Regression checks for the native Lean/Verso executable-code pipeline."""

from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[2]


class CodeArtifactContractTests(unittest.TestCase):
    def setUp(self) -> None:
        self.page = (ROOT / "spec/Spec/CodeArtifacts.lean").read_text(encoding="utf-8")
        self.extension = (ROOT / "tools/SpecExt/CodeArtifacts.lean").read_text(encoding="utf-8")
        self.spec_main = (ROOT / "tools/SpecMain.lean").read_text(encoding="utf-8")
        self.k_make = (ROOT / "src/k/Makefile").read_text(encoding="utf-8")
        self.root_make = (ROOT / "Makefile").read_text(encoding="utf-8")
        self.workflow = (ROOT / ".github/workflows/k7pl-semantics.yaml").read_text(encoding="utf-8")

    def test_verso_is_the_only_maintained_k_definition(self) -> None:
        self.assertIn('```k7plK (file := "src/k/.build/generated/semantics.k")', self.page)
        self.assertFalse((ROOT / "src/k/semantics.k").exists())
        self.assertIn("$(K_SOURCE)", self.k_make)
        self.assertIn("lake exe spec --extract-code-only", self.k_make)
        self.assertIn("SpecExt.CodeArtifacts.extractArtifacts sourceDoc", self.spec_main)

    def test_python_verifier_is_generated_from_the_verso_page(self) -> None:
        self.assertIn('```pythonScript (file := "src/k/.build/generated/check_k_examples.py")', self.page)
        self.assertIn("EXPECTED_OUTPUTS = {", self.page)
        self.assertIn("$(PYTHON_CHECK)", self.k_make)
        self.assertIn('"add.k7": "6"', self.page)
        self.assertIn('"select.k7": "3"', self.page)

    def test_native_extraction_validates_targets_before_writing(self) -> None:
        self.assertIn('target.startsWith "src/k/.build/generated/"', self.extension)
        self.assertIn('component != ".."', self.extension)
        self.assertIn('target.endsWith ".k"', self.extension)
        self.assertIn('target.endsWith ".py"', self.extension)
        self.assertIn("collectPart text", self.extension)
        self.assertIn('import SpecExt.CodeArtifacts', self.page)
        self.assertFalse((ROOT / "scripts/extract_verso_code.py").exists())

    def test_extract_only_mode_bypasses_rendering(self) -> None:
        self.assertIn('args.contains "--extract-code-only"', self.spec_main)
        self.assertLess(
            self.spec_main.index("extractArtifacts sourceDoc"),
            self.spec_main.index("manualMain"),
        )
        self.assertIn("lake exe spec --extract-code-only", self.root_make)

    def test_formal_semantics_workflow_builds_lean_before_k_extraction(self) -> None:
        self.assertLess(
            self.workflow.index("Install the repository-pinned Lean toolchain"),
            self.workflow.index("Compile K definition and run examples"),
        )
        self.assertIn('"spec/Spec/**"', self.workflow)
        self.assertIn('"tools/**"', self.workflow)
        self.assertNotIn("extract_verso_code.py", self.workflow)

    def test_workflow_packages_the_generated_sources(self) -> None:
        self.assertIn(".build/generated/semantics.k", self.workflow)
        self.assertIn(".build/generated/check_k_examples.py", self.workflow)


if __name__ == "__main__":
    unittest.main()
