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
        package_evidence = (ROOT / "tools/ci-controller/src/package_evidence.ts").read_text(encoding="utf-8")
        self.workflow = "\n".join(
            [workflow, package_evidence]
            + [(ROOT / name).read_text(encoding="utf-8") for name in self.step_scripts]
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
        # The assertions run on the page with whitespace collapsed: the contract is the
        # declaration itself, not where the prose happens to wrap (spec/README.md §7.6
        # reflows paragraphs at 120 characters).
        page = re.sub(r"\s+", " ", self.page)
        self.assertIn("Les blocs K de sémantique du sous-langage K7PL ci-dessous sont la source éditable normative", page)
        self.assertIn("Le modèle K7OS séparé est explicitement non normatif", page)
        self.assertIn("vérification et n'est pas normatif", page)
        self.assertIn('tag := "experimental-code-artifacts"', page)

    def test_k7os_profile_model_is_separate(self) -> None:
        self.assertIn('```K (file := "lexicon/models/native-boundary.k")', self.page)
        self.assertIn("--main-module NATIVE-BOUNDARY", self.k_make)
        self.assertIn("boundary-check", self.k_make)
        self.assertIn("tools/ci-controller/src/os_boundary_check.ts", self.k_make)
        self.assertNotIn("k7pl_os_boundary_check.sh", self.k_make)

    def test_layer_grammar_is_checked_against_the_listings(self) -> None:
        self.assertIn("LAYERS_SOURCE := $(LEXICON)/syntax/refusals.k", self.k_make)
        self.assertIn("--main-module REFUSALS --syntax-module TOKENS --gen-bison-parser", self.k_make)
        self.assertIn("LAYER_CHECK ?= $(DENO) run --allow-read --allow-write --allow-run tools/layer-check/src/main.ts", self.k_make)
        self.assertIn("$(LAYER_CHECK) check", self.k_make)
        self.assertIn("BALANCE_SOURCE := $(LEXICON)/syntax/balance.k", self.k_make)
        self.assertIn("--main-module BALANCE --syntax-module SCANNER --gen-bison-parser", self.k_make)
        self.assertIn('--balance "src/k/$(BALANCE_DEFINITION)"', self.k_make)
        self.assertIn('--kast "$(KAST)"', self.k_make)
        self.assertIn('make -C src/k layers-check LAYER_CHECK="k7pl-layer-check"', self.workflow)
        # The K container has no Deno: the layer checker runs there as the binary that the
        # controller-binary job compiles, which also runs its unit tests.
        binary_job = self.workflow_file.split("  controller-binary:", 1)[1].split("\n  k-smoke:", 1)[0]
        self.assertIn("(cd ../layer-check && deno task compile)", binary_job)
        self.assertIn("tools/ci-controller/dist/k7pl-layer-check", binary_job)
        self.assertIn("working-directory: tools/layer-check", binary_job)
        layer_tasks = json.loads((ROOT / "tools/layer-check/deno.json").read_text(encoding="utf-8"))["tasks"]
        self.assertIn("--output dist/k7pl-layer-check src/main.ts", layer_tasks["compile"])

    def test_proof_project_fetches_its_mathlib_cache_before_building(self) -> None:
        # proofs/ requires the root package, hence Mathlib, in a Lake workspace of its own:
        # without its own cache the proof build compiles Mathlib from source and runs past
        # the K job's timeout (run 41248858168 was cancelled during that build).
        k_smoke = self.workflow_file.split("  k-smoke:", 1)[1].split("\n  refresh-main-status:", 1)[0]
        cache = k_smoke.index("Fetch the Mathlib cache for the proof project")
        self.assertLess(cache, k_smoke.index("k7pl-ci build-proofs"))
        self.assertIn("working-directory: proofs\n        run: lake exe cache get", k_smoke)
        lakefile = (ROOT / "proofs/lakefile.lean").read_text(encoding="utf-8")
        self.assertIn('require k7pl from ".."', lakefile)
        # spec/formal-chain requires the proof package, hence the root package and its
        # dependencies: Lake refuses a manifest that does not list them (the Blueprint
        # render failed with "dependency 'k7pl' of 'K7PLProofs' not in manifest").
        chain = json.loads((ROOT / "spec/formal-chain/lake-manifest.json").read_text(encoding="utf-8"))
        names = {package["name"] for package in chain["packages"]}
        root = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
        self.assertIn("k7pl", names)
        self.assertLessEqual({package["name"] for package in root["packages"]}, names)

    def test_d01_counterexample_vector_is_aligned_across_tools(self) -> None:
        vector_path = ROOT / "models/D01-NativeBoundary-ExpectedCounterexample.json"
        vector = json.loads(vector_path.read_text(encoding="utf-8"))
        self.assertEqual(vector["id"], "D01-CE-NATIVE-WRITE-UNCONFINED-01")
        self.assertEqual(vector["initial"], {"protectedValue": 0, "serviceValue": 0, "lastEvent": "Init"})
        self.assertEqual(vector["actions"], [{"name": "NativeWrite", "argument": 1}])
        self.assertEqual(
            vector["final"],
            {"protectedValue": 1, "serviceValue": 0, "lastEvent": "NativeWriteBypass"},
        )
        self.assertEqual(vector["violatedInvariant"], "ProtectedIntegrity")

        tla = (ROOT / "models/D01NativeBoundary.tla").read_text(encoding="utf-8")
        negative_cfg = (ROOT / "models/D01-NativeBoundary-Unconfined.cfg").read_text(encoding="utf-8")
        k_example = (ROOT / vector["kExample"]).read_text(encoding="utf-8")
        lean = (ROOT / "proofs/archive/KLean/NativeBoundary.lean").read_text(encoding="utf-8")
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
        # Cutover C2: the workflow is no longer triggered by path filters
        # (spec/Spec/**, tools/**); ci.yaml calls it with surface inputs.
        self.assertIn("workflow_call", self.workflow_file)
        for surface in (
            "k_compile",
            "k_examples",
            "klean_export",
            "tla_model_check",
            "axiom_audit",
        ):
            self.assertIn(surface, self.workflow_file)
        # PR #311: every K file lives in lexicon/, which the component
        # registry routes to the K surfaces in place of a path filter.
        components = (ROOT / ".github/ci/components.yaml").read_text(encoding="utf-8")
        self.assertIn("- path: lexicon/", components)
        # `lake build Spec` reads lexicon/ (input_dir in lakefile.lean): since
        # cutover C3 the derived classifier decides spec_build, so the
        # specification component must declare lexicon/ as a read input.
        spec_block = components.split("  - id: specification", 1)[1].split("\n  - id: ", 1)[0]
        self.assertIn("- path: lexicon/", spec_block)
        self.assertIn("input_dir lexicon", self.lakefile)
        self.assertNotIn("extract_verso_code.py", self.workflow)

    def test_workflow_packages_the_k_sources(self) -> None:
        # The K job runs the compiled controller, whose package-evidence command is
        # package_evidence.ts.
        cli = (ROOT / "tools/ci-controller/src/cli.ts").read_text(encoding="utf-8")
        self.assertIn("k7pl-ci package-evidence", self.workflow_file)
        self.assertIn('"package-evidence": {', cli)
        self.assertIn('from "./package_evidence.ts"', cli)
        self.assertNotIn("scripts/ci/k7pl_semantics_package_evidence.sh", self.step_scripts)
        self.assertIn('copyItem(ws("lexicon"), art("lexicon"))', self.workflow)
        self.assertNotIn(".build/generated/semantics.k", self.workflow)
        self.assertIn(".build/generated/check_k_examples.py", self.workflow)

    def test_k_job_runs_the_compiled_controller_without_installing_deno(self) -> None:
        k_smoke = self.workflow_file.split("  k-smoke:", 1)[1].split("\n  refresh-main-status:", 1)[0]
        self.assertIn("needs: [d01-tlc, controller-binary]", k_smoke)
        self.assertIn("name: k7pl-ci-controller", k_smoke)
        self.assertIn("sha256sum -c k7pl-ci.sha256", k_smoke)
        self.assertNotIn("setup-deno", k_smoke)
        self.assertNotIn("apt-get", k_smoke)
        self.assertNotIn("deno run", k_smoke)
        self.assertIn("deno task compile", self.workflow_file)
        # The checkout is owned by another user than the container's: git refuses it
        # ("dubious ownership"), and an audited commit read with git came out empty, so the
        # generated status could never match the audit to its commit. GITHUB_SHA is the
        # commit the job checked out.
        self.assertIn('k7pl-ci axiom-report', k_smoke)
        self.assertIn('--source-commit "$GITHUB_SHA"', k_smoke)
        self.assertNotIn("rev-parse", k_smoke)

    def test_semantics_workflow_is_triggered_by_surfaces_not_paths(self) -> None:
        # Cutover C2: path filters are gone; ci.yaml calls the workflow
        # with derived surface inputs, and workflow_dispatch stays manual.
        self.assertIn("workflow_call", self.workflow_file)
        self.assertIn("workflow_dispatch", self.workflow_file)
        self.assertNotIn('- "scripts/ci/k7pl_semantics_*.sh"', self.workflow_file)
        self.assertNotIn("pull_request:", self.workflow_file)
        self.assertNotIn("push:", self.workflow_file)


if __name__ == "__main__":
    unittest.main()
