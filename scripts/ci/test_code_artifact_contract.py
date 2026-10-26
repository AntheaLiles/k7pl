# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Regression checks for the native Lean/Verso executable-code pipeline."""

from pathlib import Path
import json
import re
import unittest

ROOT = Path(__file__).resolve().parents[2]


class CodeArtifactContractTests(unittest.TestCase):
    def setUp(self) -> None:
        self.page = (ROOT / "spec/Spec/CodeArtifacts.lean").read_text(encoding="utf-8")
        self.extension = (ROOT / "tools/SpecExt/CodeArtifacts.lean").read_text(encoding="utf-8")
        self.spec_main = (ROOT / "tools/SpecMain.lean").read_text(encoding="utf-8")
        self.k_make = (ROOT / "src/k/Makefile").read_text(encoding="utf-8")
        self.lakefile = (ROOT / "lakefile.lean").read_text(encoding="utf-8")
        self.root_make = (ROOT / "Makefile").read_text(encoding="utf-8")
        self.workflow_file = workflow = (ROOT / ".github/workflows/k7pl-semantics.yaml").read_text(encoding="utf-8")
        # The workflow and the scripts/ci step scripts that it runs.
        self.step_scripts = sorted(set(re.findall(r"\bscripts/ci/k7pl_semantics_\w+\.sh\b", workflow)))
        self.workflow = "\n".join(
            [workflow] + [(ROOT / name).read_text(encoding="utf-8") for name in self.step_scripts]
        )

    def test_lexicon_is_the_only_home_of_k_sources(self) -> None:
        # Owner decision of 2026-10-26: every K file lives in lexicon/ (lexemes/, syntax/).
        stray = [
            path.relative_to(ROOT).as_posix()
            for path in ROOT.rglob("*.k")
            if not set(path.relative_to(ROOT).parts) & {".git", ".lake", ".build", "_out"}
            and path.relative_to(ROOT).parts[0] != "lexicon"
        ]
        self.assertEqual(stray, [])
        self.assertTrue((ROOT / "lexicon/lexemes").is_dir())
        self.assertTrue((ROOT / "lexicon/syntax").is_dir())
        self.assertFalse((ROOT / "src/k/semantics.k").exists())
        self.assertIn("K_SOURCE := $(LEXICON)/lexicon.k", self.k_make)
        self.assertIn("--main-module LEXICON --syntax-module LEXICON", self.k_make)
        self.assertIn("SpecExt.CodeArtifacts.extractArtifacts sourceDoc", self.spec_main)

    def test_each_lexicon_file_is_displayed_by_exactly_one_k_block(self) -> None:
        displayed = []
        for path in sorted((ROOT / "spec").rglob("*.lean")):
            text = path.read_text(encoding="utf-8")
            for match in re.finditer(r'```K \(file := "([^"]+)"\)\n```', text):
                displayed.append(match.group(1))
        lexicon = sorted(path.relative_to(ROOT).as_posix() for path in (ROOT / "lexicon").rglob("*.k"))
        self.assertEqual(sorted(displayed), lexicon)
        self.assertEqual(len(displayed), len(set(displayed)))

    def test_k_blocks_display_their_file_instead_of_copying_it(self) -> None:
        self.assertIn("meta def K : CodeBlockExpanderOf LexiconFileConfig", self.extension)
        self.assertIn("IO.FS.readFile file", self.extension)
        self.assertIn("must stay empty", self.extension)
        self.assertIn('path.startsWith "lexicon/" && path.endsWith ".k"', self.extension)
        self.assertIn("displayed by no K block", self.extension)
        self.assertNotIn("k7plK", self.extension)
        self.assertNotIn("k7osModel", self.extension)
        self.assertIn("input_dir lexicon", self.lakefile)
        self.assertIn("needs := #[lexicon]", self.lakefile)

    def test_page_declares_the_k_blocks_normative(self) -> None:
        # Owner decision of 2026-10-19: the K code blocks of the Verso files are normative;
        # the Python checker stays a verification tool.
        self.assertIn("Les blocs K de sémantique du sous-langage K7PL\nci-dessous sont la source éditable normative", self.page)
        self.assertIn("Le modèle K7OS séparé est explicitement non normatif", self.page)
        self.assertIn("vérification et n'est pas normatif", self.page)
        self.assertIn('tag := "experimental-code-artifacts"', self.page)

    def test_k7os_profile_model_is_separate(self) -> None:
        self.assertIn('```K (file := "lexicon/models/native-boundary.k")', self.page)
        self.assertIn("--main-module NATIVE-BOUNDARY", self.k_make)
        self.assertIn("boundary-check", self.k_make)
        self.assertIn("k7pl_os_boundary_check.sh", self.k_make)

    def test_layer_grammar_is_checked_against_the_listings(self) -> None:
        self.assertIn("LAYERS_SOURCE := $(LEXICON)/syntax/refusals.k", self.k_make)
        self.assertIn("--main-module REFUSALS --syntax-module TOKENS --gen-bison-parser", self.k_make)
        self.assertIn("tools/layer-check/src/main.ts check", self.k_make)
        self.assertIn("make -C src/k layers-check", self.workflow)

    def test_d01_counterexample_vector_is_aligned_across_tools(self) -> None:
        vector_path = ROOT / "theoretical-projects/k7os/models/D01-NativeBoundary-ExpectedCounterexample.json"
        vector = json.loads(vector_path.read_text(encoding="utf-8"))
        self.assertEqual(vector["id"], "D01-CE-NATIVE-WRITE-UNCONFINED-01")
        self.assertEqual(vector["initial"], {"protectedValue": 0, "serviceValue": 0, "lastEvent": "Init"})
        self.assertEqual(vector["actions"], [{"name": "NativeWrite", "argument": 1}])
        self.assertEqual(
            vector["final"],
            {"protectedValue": 1, "serviceValue": 0, "lastEvent": "NativeWriteBypass"},
        )
        self.assertEqual(vector["violatedInvariant"], "ProtectedIntegrity")

        tla = (ROOT / "theoretical-projects/k7os/models/D01NativeBoundary.tla").read_text(encoding="utf-8")
        negative_cfg = (ROOT / "theoretical-projects/k7os/models/D01-NativeBoundary-Unconfined.cfg").read_text(encoding="utf-8")
        k_example = (ROOT / vector["kExample"]).read_text(encoding="utf-8")
        lean = (ROOT / "proofs/K7PL/NativeBoundary.lean").read_text(encoding="utf-8")
        blueprint = (ROOT / "spec/formal-chain/BlueprintK7PL/Chapters/Semantics.lean").read_text(encoding="utf-8")
        self.assertIn("Values == {0, 1}", tla)
        self.assertIn("BoundaryEnforced = FALSE", negative_cfg)
        self.assertIn("nativeWrite(false, 1)", k_example)
        self.assertIn("Steps .sharedUnconfined initial [.nativeWrite 1] ⟨1, 0⟩", lean)
        self.assertIn('lean := "K7PL.NativeBoundary.unconfined_native_write_trace_replay"', blueprint)

    def test_python_verifier_is_generated_from_the_verso_page(self) -> None:
        self.assertIn('```pythonScript (file := "src/k/.build/generated/check_k_examples.py")', self.page)
        self.assertIn("EXPECTED_OUTPUTS = {", self.page)
        self.assertIn("$(PYTHON_CHECK)", self.k_make)
        self.assertIn('"add.k7": "6"', self.page)
        self.assertIn('"select.k7": "3"', self.page)

    def test_native_extraction_validates_targets_before_writing(self) -> None:
        self.assertIn('target.startsWith "src/k/.build/generated/"', self.extension)
        self.assertIn('component != ".."', self.extension)
        self.assertIn('target.endsWith ".py"', self.extension)
        self.assertIn("collectPart text", self.extension)
        self.assertIn("code.getString", self.extension)
        self.assertNotIn("getVersoCodeBlock", self.extension)
        self.assertIn('import SpecExt.CodeArtifacts', self.page)
        self.assertIn("open SpecExt.CodeArtifacts", self.page)
        self.assertIn("# Définition K expérimentale", self.page)
        self.assertIn("# Script Python de vérification des exemples", self.page)
        self.assertNotIn("**", self.page)
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
        self.assertIn('"lexicon/**"', self.workflow)
        self.assertIn('"tools/**"', self.workflow)
        self.assertNotIn("extract_verso_code.py", self.workflow)

    def test_workflow_packages_the_k_sources(self) -> None:
        self.assertIn("scripts/ci/k7pl_semantics_package_evidence.sh", self.step_scripts)
        self.assertIn('cp -a "$GITHUB_WORKSPACE/lexicon"', self.workflow)
        self.assertIn(".build/generated/check_k_examples.py", self.workflow)

    def test_step_scripts_trigger_the_workflow(self) -> None:
        # Both the pull_request and the push path filters.
        self.assertEqual(self.workflow_file.count('- "scripts/ci/k7pl_semantics_*.sh"'), 2)


if __name__ == "__main__":
    unittest.main()
