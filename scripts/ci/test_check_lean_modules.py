# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the Lean module reachability check.

Run from anywhere with `python3 -m unittest discover -s scripts/ci -p 'test_*.py'`. The synthetic
repositories reproduce the failure shown by the audit (an orphan module and an orphan test that
`lake build` silently skips); the real repository is also checked, with a guard against vacuity.
"""

import contextlib
import io
import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

import check_lean_modules as check

REPO_ROOT = Path(__file__).resolve().parents[2]
SCRIPT = Path(__file__).with_name("check_lean_modules.py")

LAKEFILE = """\
import Lake
open Lake DSL

package mini

/-- Library. -/
@[default_target]
lean_lib Mini where
  srcDir := "src"
  roots := #[`Main, `Mini]
  leanOptions := #[⟨`warningAsError, true⟩]

lean_lib MiniTests where
  srcDir := "tests"
  roots := #[`ATest]

@[test_driver]
lean_exe mainTest where
  srcDir := "tests"
  root := `MainTest
"""

BASE_FILES = {
    "lakefile.lean": LAKEFILE,
    "src/Main.lean": "def Main.hello := 1\n",
    "src/Mini.lean": "import Mini.Leaf\n",
    "src/Mini/Leaf.lean": "def Mini.leaf := 1\n",
    "tests/ATest.lean": "import Mini\n#guard 1 + 1 == 2\n",
    "tests/MainTest.lean": "import ATest\ndef main : IO Unit := pure ()\n",
}


def run(repo: Path, *args: str) -> tuple[int, str, str]:
    out, err = io.StringIO(), io.StringIO()
    with contextlib.redirect_stdout(out), contextlib.redirect_stderr(err):
        code = check.main(["--repo", str(repo), *args])
    return code, out.getvalue(), err.getvalue()


class RepoCase(unittest.TestCase):
    def make_repo(self, **overrides: str | None) -> Path:
        """Write BASE_FILES plus overrides (`None` deletes); keys use `__` for `/` and `_dot_`."""
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        repo = Path(tmp.name)
        files = dict(BASE_FILES)
        for key, content in overrides.items():
            path = key.replace("__", "/").replace("_dot_", ".")
            if content is None:
                files.pop(path, None)
            else:
                files[path] = content
        for path, content in files.items():
            target = repo / path
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(content, encoding="utf-8")
        return repo


class OrphanDetectionTests(RepoCase):
    def test_complete_repository_passes(self):
        code, out, _ = run(self.make_repo())
        self.assertEqual(code, 0, out)

    def test_orphan_module_in_src_is_reported(self):
        repo = self.make_repo(src__Mini__Orphan_dot_lean="def Mini.orphan := 1\n")
        code, out, _ = run(repo)
        self.assertEqual(code, 1)
        self.assertIn("src/Mini/Orphan.lean", out)
        self.assertNotIn("src/Mini/Leaf.lean", out)

    def test_orphan_test_is_reported(self):
        repo = self.make_repo(tests__OrphanTest_dot_lean="#guard 2 + 2 == 5\n")
        code, out, _ = run(repo)
        self.assertEqual(code, 1)
        self.assertIn("tests/OrphanTest.lean", out)

    def test_transitive_import_makes_a_module_reachable(self):
        repo = self.make_repo(
            src__Mini__Leaf_dot_lean="import Mini.Deep\n",
            src__Mini__Deep_dot_lean="def Mini.deep := 1\n",
        )
        self.assertEqual(run(repo)[0], 0)

    def test_test_module_imported_only_by_the_executable_is_reachable(self):
        repo = self.make_repo(
            tests__MainTest_dot_lean="import ATest\nimport BTest\ndef main : IO Unit := pure ()\n",
            tests__BTest_dot_lean="#guard true\n",
        )
        self.assertEqual(run(repo)[0], 0)

    def test_imports_hidden_in_comments_do_not_count(self):
        repo = self.make_repo(
            src__Mini_dot_lean=(
                "import Mini.Leaf\n-- import Mini.Orphan\n/- import Mini.Orphan -/\n"
                "/-! import Mini.Orphan\n/- nested -/ import Mini.Orphan -/\n"
            ),
            src__Mini__Orphan_dot_lean="def Mini.orphan := 1\n",
        )
        code, out, _ = run(repo)
        self.assertEqual(code, 1)
        self.assertIn("src/Mini/Orphan.lean", out)

    def test_import_after_the_header_does_not_count(self):
        repo = self.make_repo(
            src__Mini_dot_lean="import Mini.Leaf\n\ndef x := 1\nimport Mini.Orphan\n",
            src__Mini__Orphan_dot_lean="def Mini.orphan := 1\n",
        )
        self.assertEqual(run(repo)[0], 1)

    def test_comment_between_two_imports_is_skipped(self):
        repo = self.make_repo(
            src__Mini_dot_lean="import Mini.Leaf\n-- a comment inside the header\n"
            "/- another -/\nimport Mini.Other\n",
            src__Mini__Other_dot_lean="def Mini.other := 1\n",
        )
        self.assertEqual(run(repo)[0], 0)

    def test_import_modifiers_are_followed(self):
        repo = self.make_repo(
            src__Mini_dot_lean="module\npublic import Mini.Leaf\nimport all Mini.Other\n",
            src__Mini__Other_dot_lean="def Mini.other := 1\n",
        )
        self.assertEqual(run(repo)[0], 0)

    def test_header_grammar_of_lean_4_34(self):
        # [module] [prelude] ([public] [meta] import [all] Name)*
        header = (
            "module\nprelude\npublic meta import Mini.A\nmeta import all Mini.B\n"
            "public import Mini.C\nimport Mini.D\n"
        )
        repo = self.make_repo(
            src__Mini_dot_lean=header,
            src__Mini__Leaf_dot_lean=None,
            **{f"src__Mini__{name}_dot_lean": f"def Mini.x{name} := 1\n" for name in "ABCD"},
        )
        self.assertEqual(run(repo)[0], 0)
        self.assertEqual(check.imports_of(repo / "src/Mini.lean"), ["Mini.A", "Mini.B", "Mini.C", "Mini.D"])

    def test_module_and_prelude_are_each_optional(self):
        for header in ("module\nimport Mini.Leaf\n", "prelude\nimport Mini.Leaf\n", "import Mini.Leaf\n"):
            with self.subTest(header=header):
                repo = self.make_repo(src__Mini_dot_lean=header)
                self.assertEqual(check.imports_of(repo / "src/Mini.lean"), ["Mini.Leaf"])

    def test_comments_separate_tokens_without_whitespace(self):
        header = (
            "import Mini.A--line comment right after the name\n"
            "import/- block -/Mini.B\n"
            "/- multi\nline\ncomment -/import Mini.C\n"
            "/-! doc\n/- nested -/\nstill doc -/\nimport Mini.D\n"
        )
        repo = self.make_repo(src__Mini_dot_lean=header)
        self.assertEqual(check.imports_of(repo / "src/Mini.lean"), ["Mini.A", "Mini.B", "Mini.C", "Mini.D"])

    def test_import_cycles_do_not_hang(self):
        repo = self.make_repo(
            src__Mini_dot_lean="import Mini.Leaf\n",
            src__Mini__Leaf_dot_lean="import Mini.Cycle\n",
            src__Mini__Cycle_dot_lean="import Mini.Leaf\n",
        )
        done = subprocess.run(
            [sys.executable, "-I", str(SCRIPT), "--repo", str(repo)],
            capture_output=True, text=True, timeout=20,
        )
        self.assertEqual(done.returncode, 0, (done.stdout, done.stderr))

    def test_report_names_the_problem_and_the_remedy(self):
        repo = self.make_repo(src__Mini__Orphan_dot_lean="def Mini.orphan := 1\n")
        code, out, err = run(repo)
        self.assertEqual((code, err), (1, ""))
        lines = out.splitlines()
        self.assertEqual(lines[0], "check_lean_modules: Lean files that no lean_lib/lean_exe root reaches:")
        self.assertEqual(lines[1], "  src/Mini/Orphan.lean")
        self.assertIn("`lake build` never compiles them.", lines[2])
        self.assertIn("`roots` of a lean_lib of lakefile.lean", lines[2])

    def test_success_report_counts_files_and_targets(self):
        code, out, _ = run(self.make_repo())
        self.assertEqual(code, 0)
        self.assertEqual(
            out.strip(),
            "check_lean_modules: 5 Lean file(s) under src, tests, all reachable from the 4 root(s) "
            "of 3 lean_lib/lean_exe target(s).",
        )

    def test_incomplete_import_is_ignored_not_a_crash(self):
        repo = self.make_repo(src__Mini_dot_lean="import Mini.Leaf\nimport all\n")
        self.assertEqual(check.imports_of(repo / "src/Mini.lean"), ["Mini.Leaf"])
        repo = self.make_repo(src__Mini_dot_lean="import")
        self.assertEqual(check.imports_of(repo / "src/Mini.lean"), [])

    def test_text_that_is_not_a_header_stops_the_scan(self):
        repo = self.make_repo(src__Mini_dot_lean="/-! doc -/\nopen Nat\nimport Mini.Leaf\n")
        self.assertEqual(check.imports_of(repo / "src/Mini.lean"), [])

    def test_dirs_option_limits_the_scan(self):
        repo = self.make_repo(tests__OrphanTest_dot_lean="#guard true\n")
        self.assertEqual(run(repo)[0], 1)
        self.assertEqual(run(repo, "--dirs", "src")[0], 0)

    def test_every_orphan_is_listed(self):
        repo = self.make_repo(
            src__A_dot_lean="def a := 1\n",
            tests__BTest_dot_lean="def b := 1\n",
        )
        code, out, _ = run(repo)
        self.assertEqual(code, 1)
        self.assertIn("src/A.lean", out)
        self.assertIn("tests/BTest.lean", out)

    def test_dot_lake_is_not_scanned(self):
        repo = self.make_repo()
        (repo / "src" / ".lake").mkdir()
        (repo / "src" / ".lake" / "Hidden.lean").write_text("def h := 1\n", encoding="utf-8")
        self.assertEqual(run(repo)[0], 0)


class LoudFailureTests(RepoCase):
    def assert_unrecognized(self, repo: Path, *args: str, reason: str):
        code, out, err = run(repo, *args)
        self.assertEqual(code, 2, (out, err))
        self.assertIn("cannot analyse", err)
        self.assertIn(reason, err)
        self.assertEqual(out, "")

    def lakefile_without(self, old: str, new: str = "") -> Path:
        self.assertEqual(LAKEFILE.count(old), 1, old)
        return self.make_repo(lakefile_dot_lean=LAKEFILE.replace(old, new))

    def test_missing_lakefile(self):
        self.assert_unrecognized(self.make_repo(lakefile_dot_lean=None), reason="not found")

    def test_toml_lakefile_is_not_supported(self):
        repo = self.make_repo(lakefile_dot_lean=None, lakefile_dot_toml="name = 'x'\n")
        self.assert_unrecognized(repo, reason="lakefile.toml is not supported")

    def test_lakefile_without_targets(self):
        repo = self.make_repo(lakefile_dot_lean="import Lake\npackage p\n")
        self.assert_unrecognized(repo, reason="no lean_lib/lean_exe declaration")

    def test_globs_are_not_supported(self):
        # `roots` stays valid: only the `globs` guard can reject this lakefile.
        repo = self.lakefile_without(
            "roots := #[`ATest]", "roots := #[`ATest]\n  globs := #[.submodules `ATest]"
        )
        self.assert_unrecognized(repo, reason="`globs`")

    def test_computed_roots_are_not_supported(self):
        repo = self.lakefile_without("roots := #[`ATest]", "roots := myRoots")
        self.assert_unrecognized(repo, reason="`roots` is missing or is not a literal list")

    def test_roots_with_non_literal_entries_are_not_supported(self):
        repo = self.lakefile_without("roots := #[`ATest]", "roots := #[`ATest, mkRoot]")
        self.assert_unrecognized(repo, reason="something other than name literals")

    def test_non_literal_src_dir_is_not_supported(self):
        repo = self.lakefile_without('srcDir := "tests"\n  roots', "srcDir := testDir\n  roots")
        self.assert_unrecognized(repo, reason="`srcDir` is missing or is not a string literal")

    def test_a_literal_followed_by_more_is_a_computed_value_not_a_literal(self):
        cases = {
            "srcDir with a path join": ('srcDir := "tests"\n  roots', 'srcDir := "tests" / "x"\n  roots', "`srcDir`"),
            "srcDir with a concatenation": ('srcDir := "tests"\n  roots', 'srcDir := "tests" ++ suffix\n  roots', "`srcDir`"),
            "roots with a concatenation": ("roots := #[`ATest]", "roots := #[`ATest] ++ more", "`roots`"),
            "root with a member access": ("root := `MainTest", "root := `MainTest |>.foo", "`root`"),
        }
        for label, (old, new, reason) in cases.items():
            with self.subTest(label):
                self.assert_unrecognized(self.lakefile_without(old, new), reason=reason)

    def test_a_trailing_comma_after_a_literal_is_accepted(self):
        repo = self.lakefile_without('srcDir := "tests"\n  roots', 'srcDir := "tests",\n  roots')
        self.assertEqual(run(repo)[0], 0)

    def test_lake_defaults_are_not_assumed(self):
        # Lake would default these three fields; the check refuses to guess instead.
        no_src_dir = self.lakefile_without('  srcDir := "tests"\n  roots := #[`ATest]', "  roots := #[`ATest]")
        self.assert_unrecognized(no_src_dir, reason="`srcDir` is missing")
        no_roots = self.lakefile_without('  roots := #[`ATest]\n', "")
        self.assert_unrecognized(no_roots, reason="`roots` is missing")
        no_root = self.lakefile_without("  root := `MainTest\n", "")
        self.assert_unrecognized(no_root, reason="`root` is missing")

    def test_non_literal_exe_root_is_not_supported(self):
        repo = self.lakefile_without("root := `MainTest", "root := mkRoot")
        self.assert_unrecognized(repo, reason="`root` is missing or is not a name literal")

    def test_field_on_the_where_line_is_read(self):
        repo = self.lakefile_without(
            'lean_lib MiniTests where\n  srcDir := "tests"', 'lean_lib MiniTests where srcDir := "tests"'
        )
        self.assertEqual(run(repo)[0], 0)
        broken = self.lakefile_without(
            'lean_lib MiniTests where\n  srcDir := "tests"', 'lean_lib MiniTests where srcDir := nope'
        )
        self.assert_unrecognized(broken, reason="`srcDir` is missing or is not a string literal")

    def test_declaration_shapes_the_parser_does_not_handle_are_not_ignored(self):
        shapes = {
            "same-line attribute": ("@[test_driver]\nlean_exe mainTest where", "@[test_driver] lean_exe mainTest where"),
            "no where": ("lean_lib MiniTests where", "lean_lib MiniTests"),
        }
        for label, (old, new) in shapes.items():
            with self.subTest(shape=label):
                self.assert_unrecognized(self.lakefile_without(old, new), reason="unsupported syntax")

    def test_multi_line_roots_list_is_read(self):
        repo = self.lakefile_without(
            "roots := #[`Main, `Mini]", "roots := #[\n    `Main,\n    `Mini\n  ]"
        )
        self.assertEqual(run(repo)[0], 0)

    def test_comment_inside_a_declaration_does_not_hide_its_fields(self):
        repo = self.lakefile_without(
            '  srcDir := "tests"\n  roots := #[`ATest]',
            '  srcDir := "tests"\n  /- a comment\n     over two lines -/\n  roots := #[`ATest]',
        )
        self.assertEqual(run(repo)[0], 0)

    def test_a_declaration_body_ends_at_the_next_unindented_line(self):
        # The field after the unindented line belongs to nothing: it must not be read as ours.
        repo = self.lakefile_without(
            'lean_lib MiniTests where\n  srcDir := "tests"\n  roots := #[`ATest]',
            'lean_lib MiniTests where\n  roots := #[`ATest]\nx srcDir := "tests"',
        )
        self.assert_unrecognized(repo, reason="`srcDir` is missing or is not a string literal")

    def test_error_messages_name_the_cause(self):
        code, out, err = run(self.make_repo(lakefile_dot_lean=None))
        self.assertTrue(err.rstrip().endswith("lakefile.lean not found"), err)
        code, out, err = run(self.make_repo(lakefile_dot_lean=None, lakefile_dot_toml="x = 1\n"))
        self.assertTrue(err.rstrip().endswith("lakefile.lean not found (lakefile.toml is not supported)"), err)

    def test_declaration_the_parser_does_not_see_is_not_ignored(self):
        lakefile = LAKEFILE + '\nmeta if true then\n  lean_lib Hidden where\n    srcDir := "x"\n'
        self.assert_unrecognized(
            self.make_repo(lakefile_dot_lean=lakefile), reason="unsupported syntax"
        )

    def test_declaration_in_a_comment_is_not_counted(self):
        lakefile = LAKEFILE + "\n-- lean_lib Ghost where\n/- lean_exe ghost -/\n"
        self.assertEqual(run(self.make_repo(lakefile_dot_lean=lakefile))[0], 0)

    def test_missing_root_file(self):
        self.assert_unrecognized(
            self.make_repo(tests__ATest_dot_lean=None), reason="root module ATest has no file"
        )

    def test_missing_scanned_directory(self):
        self.assert_unrecognized(
            self.make_repo(), "--dirs", "src", "nowhere", reason="nowhere/ does not exist"
        )


class RootsInTests(RepoCase):
    def test_roots_of_the_libraries_and_executables_of_a_directory(self):
        code, out, _ = run(self.make_repo(), "--roots-in", "tests")
        self.assertEqual((code, out.split()), (0, ["ATest", "MainTest"]))

    def test_unknown_directory_is_an_error(self):
        code, out, err = run(self.make_repo(), "--roots-in", "elsewhere")
        self.assertEqual((code, out), (2, ""))
        self.assertIn("cannot analyse", err)


class StripCommentsTests(unittest.TestCase):
    def test_line_and_nested_block_comments(self):
        text = "a -- b\nc /- d /- e -/ f -/ g\n"
        self.assertEqual(check.strip_comments(text).split(), ["a", "c", "g"])

    def test_comment_markers_inside_strings_are_kept(self):
        text = 'x := "a -- b /- c"\ny'
        self.assertIn('"a -- b /- c"', check.strip_comments(text))

    def test_escaped_quote_does_not_end_a_string(self):
        text = 'x := "a\\"b -- still a string" -- real comment\ny'
        stripped = check.strip_comments(text)
        self.assertIn("-- still a string", stripped)
        self.assertNotIn("real comment", stripped)
        self.assertTrue(stripped.rstrip().endswith("y"))

    def test_a_backslash_ending_the_text_is_not_a_crash(self):
        self.assertEqual(check.strip_comments('"abc\\'), '"abc\\')

    def test_text_right_after_a_closing_delimiter_is_kept(self):
        self.assertEqual(check.strip_comments("/- a -/import").split(), ["import"])
        self.assertEqual(check.strip_comments("/-a-/x/-b-/y").split(), ["x", "y"])

    def test_text_is_not_otherwise_altered(self):
        text = "def f (n : Nat) : Nat := n + 1\n"
        self.assertEqual(check.strip_comments(text), text)

    def test_newlines_inside_comments_stay_newlines(self):
        self.assertEqual(check.strip_comments("a/- x\ny -/b"), "a    \n    b")

    def test_line_structure_is_preserved(self):
        text = "a\n/- one\ntwo -/\nb\n"
        self.assertEqual(check.strip_comments(text).count("\n"), text.count("\n"))


class RealRepositoryTests(unittest.TestCase):
    def test_real_repository_has_no_orphan(self):
        code, out, err = run(REPO_ROOT)
        self.assertEqual(code, 0, (out, err))

    def test_real_analysis_is_not_vacuous(self):
        targets = check.parse_lakefile(REPO_ROOT / "lakefile.lean")
        names = {target.name for target in targets}
        self.assertTrue({"K7pl", "K7plTests", "mainTest"} <= names, names)
        reachable = check.reachable_files(REPO_ROOT, targets)
        for expected in ("src/K7pl/Arith.lean", "src/K7pl/Semantics.lean", "tests/ArithTest.lean"):
            self.assertIn(REPO_ROOT / expected, reachable)
        scanned = check.scan(REPO_ROOT, list(check.DEFAULT_SCAN_DIRS))
        self.assertGreaterEqual(len(scanned), 7)

    def test_real_test_roots_are_what_the_axiom_audit_loop_iterates_over(self):
        code, out, _ = run(REPO_ROOT, "--roots-in", "tests")
        self.assertEqual(code, 0)
        self.assertTrue({"ArithTest", "SemanticsTest", "MainTest"} <= set(out.split()), out)


class CommandLineTests(RepoCase):
    """Run the script as a process: the CI reads nothing but its exit status."""

    def cli(self, *args: str, cwd: Path) -> subprocess.CompletedProcess:
        env = {"PATH": os.environ.get("PATH", ""), "PYTHONDONTWRITEBYTECODE": "1"}
        return subprocess.run(
            [sys.executable, "-I", str(SCRIPT), *args],
            cwd=cwd, env=env, capture_output=True, text=True, timeout=60,
        )

    def test_exit_0_on_the_real_repository_from_its_root(self):
        done = self.cli(cwd=REPO_ROOT)
        self.assertEqual(done.returncode, 0, (done.stdout, done.stderr))
        self.assertIn("all reachable", done.stdout)
        self.assertEqual(done.stderr, "")

    def test_exit_0_from_another_directory(self):
        with tempfile.TemporaryDirectory() as elsewhere:
            done = self.cli("--repo", str(REPO_ROOT), cwd=Path(elsewhere))
        self.assertEqual(done.returncode, 0, (done.stdout, done.stderr))

    def test_exit_1_for_an_orphan_from_any_directory(self):
        repo = self.make_repo(src__Mini__Orphan_dot_lean="def Mini.orphan := 1\n")
        with tempfile.TemporaryDirectory() as elsewhere:
            for cwd, args in ((repo, ()), (Path(elsewhere), ("--repo", str(repo)))):
                with self.subTest(cwd=str(cwd)):
                    done = self.cli(*args, cwd=cwd)
                    self.assertEqual(done.returncode, 1, (done.stdout, done.stderr))
                    self.assertIn("src/Mini/Orphan.lean", done.stdout)
                    self.assertEqual(done.stderr, "")

    def test_exit_2_for_an_unrecognised_layout(self):
        repo = self.make_repo(lakefile_dot_lean=None)
        with tempfile.TemporaryDirectory() as elsewhere:
            for cwd, args in ((repo, ()), (Path(elsewhere), ("--repo", str(repo)))):
                with self.subTest(cwd=str(cwd)):
                    done = self.cli(*args, cwd=cwd)
                    self.assertEqual(done.returncode, 2, (done.stdout, done.stderr))
                    self.assertEqual(done.stdout, "")
                    self.assertIn("cannot analyse", done.stderr)

    def test_non_utf8_locale_does_not_matter(self):
        # lakefile.lean contains non-ASCII characters; the files are read as UTF-8 explicitly.
        env = {
            "PATH": os.environ.get("PATH", ""), "LC_ALL": "C", "LANG": "C",
            "PYTHONUTF8": "0", "PYTHONCOERCECLOCALE": "0", "PYTHONDONTWRITEBYTECODE": "1",
        }
        done = subprocess.run(
            [sys.executable, "-I", str(SCRIPT), "--repo", str(REPO_ROOT)],
            cwd=REPO_ROOT, env=env, capture_output=True, text=True, timeout=60,
        )
        self.assertEqual(done.returncode, 0, (done.stdout, done.stderr))

    def test_exit_2_for_bad_arguments(self):
        done = self.cli("--no-such-option", cwd=REPO_ROOT)
        self.assertEqual(done.returncode, 2)

    def test_roots_in_through_the_process(self):
        done = self.cli("--roots-in", "tests", cwd=REPO_ROOT)
        self.assertEqual(done.returncode, 0, done.stderr)
        self.assertTrue({"ArithTest", "MainTest", "SemanticsTest"} <= set(done.stdout.split()), done.stdout)
        done = self.cli("--roots-in", "nowhere", cwd=REPO_ROOT)
        self.assertEqual((done.returncode, done.stdout), (2, ""))


if __name__ == "__main__":
    unittest.main()
