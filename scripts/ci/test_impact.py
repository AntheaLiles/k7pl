# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the CI impact classifier."""

import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

import impact
from impact import classify

IMPACT_SCRIPT = Path(__file__).with_name("impact.py")

# The expected lists are written out on purpose: they are the specification, independent of the
# constants of impact.py. A path dropped from FULL_EXACT would otherwise fall back silently on
# "unknown path -> full", which is why every test below also asserts `unclassified` is false.
EXPECTED_FULL_EXACT = {
    ".github/dependabot.yml",
    "lakefile.lean",
    "lean-toolchain",
    "lake-manifest.json",
    "scripts/sync_zenodo.py",
    "scripts/requirements-zenodo.txt",
}
EXPECTED_FULL_PREFIXES = (".github/workflows/", "scripts/ci/")
SURFACES = ("full", "docs_links", "spec_check", "spec_build", "lean_build")
EXPECTED_LEAN_PREFIXES = ("src/", "tests/")
EXPECTED_LEAN_AND_SPEC_BUILD_EXACT = {"scripts/axiom-audit.sh"}
EXPECTED_SPEC_BUILD_EXACT = {"scripts/controle.py", "scripts/manuscript_metrics.py"}
EXPECTED_SPEC_BUILD_PREFIXES = ("spec/", "tools/", "biblio/", "scripts/controles/")
EXPECTED_SPEC_CHECK_EXACT = {"docs/suivi/primitives.md"}
EXPECTED_LIGHT_PREFIXES = ("docs/", ".claude/", ".github/ISSUE_TEMPLATE/", "LICENSES/")
EXPECTED_LIGHT_EXACT = {"CITATION.cff"}


class ImpactTests(unittest.TestCase):
    def test_markdown_is_light(self):
        result = classify(["docs/foo.md"])
        self.assertTrue(result["docs_links"])
        self.assertFalse(result["full"])
        self.assertFalse(result["spec_build"])
        self.assertFalse(result["lean_build"])

    def test_claude_markdown_is_light(self):
        result = classify([".claude/agents/example.md"])
        self.assertTrue(result["docs_links"])
        self.assertFalse(result["full"])

    def test_lean_surface(self):
        result = classify(["src/K7pl/Foo.lean"])
        self.assertTrue(result["lean_build"])
        self.assertFalse(result["spec_build"])
        self.assertFalse(result["full"])

    def test_spec_surface(self):
        result = classify(["spec/Spec/C1.lean"])
        self.assertTrue(result["spec_check"])
        self.assertTrue(result["spec_build"])
        self.assertFalse(result["lean_build"])

    def test_spec_tracking_file(self):
        result = classify(["docs/suivi/primitives.md"])
        self.assertTrue(result["docs_links"])
        self.assertTrue(result["spec_check"])
        self.assertFalse(result["spec_build"])

    def test_ci_change_forces_full(self):
        result = classify([".github/workflows/ci.yaml"])
        self.assertTrue(result["full"])
        self.assertTrue(result["spec_build"])
        self.assertTrue(result["lean_build"])

    def test_unknown_path_forces_full(self):
        result = classify(["new-format.toml"])
        self.assertTrue(result["full"])
        self.assertTrue(result["unclassified"])

    def test_mixed_surfaces_are_unioned(self):
        result = classify(["src/K7pl/Foo.lean", "docs/foo.md", "spec/Spec/C2.lean"])
        self.assertTrue(result["lean_build"])
        self.assertTrue(result["spec_build"])
        self.assertTrue(result["docs_links"])
        self.assertFalse(result["full"])

    def test_full_flag_dominates(self):
        result = classify(["docs/foo.md"], force_full=True)
        self.assertTrue(all(result[key] for key in ("full", "docs_links", "spec_check", "spec_build", "lean_build")))


class FullSurfaceTests(unittest.TestCase):
    """Every path that must force the complete validation does so by name, not by fallback."""

    def assert_full_by_classification(self, path):
        result = classify([path])
        self.assertTrue(result["full"], path)
        self.assertFalse(result["unclassified"], f"{path} only forces full as an unknown path")
        self.assertEqual(result["unknown_paths"], [], path)
        for surface in SURFACES:
            self.assertTrue(result[surface], f"{path}: {surface}")

    def test_expected_lists_match_the_classifier(self):
        self.assertEqual(impact.FULL_EXACT, EXPECTED_FULL_EXACT)
        self.assertEqual(impact.FULL_PREFIXES, EXPECTED_FULL_PREFIXES)

    def test_each_exact_path_forces_full(self):
        for path in sorted(EXPECTED_FULL_EXACT):
            with self.subTest(path=path):
                self.assert_full_by_classification(path)

    def test_each_prefix_forces_full(self):
        for prefix in EXPECTED_FULL_PREFIXES:
            for path in (f"{prefix}new-file.yaml", f"{prefix}nested/dir/new_file.py"):
                with self.subTest(path=path):
                    self.assert_full_by_classification(path)

    def test_exact_paths_are_matched_exactly(self):
        for path in sorted(EXPECTED_FULL_EXACT):
            with self.subTest(path=path):
                result = classify([path + ".orig"])
                self.assertTrue(result["full"])
                self.assertTrue(result["unclassified"], "a near-miss must be seen as unknown")

    def test_neighbouring_light_paths_do_not_force_full(self):
        light = (".github/ISSUE_TEMPLATE/bug.yaml", "docs/security/notes.md", "LICENSES/MIT.txt")
        for path in light:
            with self.subTest(path=path):
                result = classify([path])
                self.assertFalse(result["full"])
                self.assertFalse(result["unclassified"])
                self.assertFalse(result["lean_build"] or result["spec_build"])


class SurfaceTableTests(unittest.TestCase):
    """The routing tables are specified here too: dropping an entry must not go unnoticed.

    A dropped entry would not fail anything by itself: the path would become "unknown" and force
    the complete validation, silently turning a targeted run into a full one (and, for the light
    paths, into a needless one).
    """

    def test_expected_tables_match_the_classifier(self):
        self.assertEqual(impact.LEAN_PREFIXES, EXPECTED_LEAN_PREFIXES)
        self.assertEqual(impact.LEAN_AND_SPEC_BUILD_EXACT, EXPECTED_LEAN_AND_SPEC_BUILD_EXACT)
        self.assertEqual(impact.SPEC_BUILD_EXACT, EXPECTED_SPEC_BUILD_EXACT)
        self.assertEqual(impact.SPEC_BUILD_PREFIXES, EXPECTED_SPEC_BUILD_PREFIXES)
        self.assertEqual(impact.SPEC_CHECK_EXACT, EXPECTED_SPEC_CHECK_EXACT)
        self.assertEqual(impact.LIGHT_PREFIXES, EXPECTED_LIGHT_PREFIXES)
        self.assertEqual(impact.LIGHT_EXACT, EXPECTED_LIGHT_EXACT)

    def assert_surfaces(self, path, **expected):
        result = classify([path])
        self.assertFalse(result["unclassified"], f"{path} is unknown")
        actual = {surface: result[surface] for surface in SURFACES}
        wanted = {surface: expected.get(surface, False) for surface in SURFACES}
        self.assertEqual(actual, wanted, path)

    def test_lean_paths(self):
        for prefix in EXPECTED_LEAN_PREFIXES:
            with self.subTest(prefix=prefix):
                self.assert_surfaces(f"{prefix}Anything.lean", lean_build=True)

    def test_specification_build_paths(self):
        paths = sorted(EXPECTED_SPEC_BUILD_EXACT) + [f"{p}Anything.lean" for p in EXPECTED_SPEC_BUILD_PREFIXES]
        for path in paths:
            with self.subTest(path=path):
                self.assert_surfaces(path, spec_check=True, spec_build=True)

    def test_specification_check_path(self):
        for path in sorted(EXPECTED_SPEC_CHECK_EXACT):
            with self.subTest(path=path):
                self.assert_surfaces(path, docs_links=True, spec_check=True)

    def test_light_paths_validate_nothing(self):
        paths = sorted(EXPECTED_LIGHT_EXACT) + [f"{p}anything.txt" for p in EXPECTED_LIGHT_PREFIXES]
        for path in paths:
            with self.subTest(path=path):
                self.assert_surfaces(path)

    def test_markdown_files_only_ask_for_the_link_check(self):
        for path in ("README.md", "docs/a.markdown", "CHANGELOG.MD", ".claude/agents/x.md"):
            with self.subTest(path=path):
                self.assert_surfaces(path, docs_links=True)

    def test_markdown_in_a_validated_directory_adds_the_link_check(self):
        self.assert_surfaces("spec/CHANGELOG.md", docs_links=True, spec_check=True, spec_build=True)
        self.assert_surfaces("tests/NOTES.markdown", docs_links=True, lean_build=True)


class EdgeClassificationTests(unittest.TestCase):
    def test_no_path_means_nothing_to_validate(self):
        result = classify([])
        self.assertFalse(any(result[surface] for surface in SURFACES))
        self.assertFalse(result["unclassified"])

    def test_markdown_under_a_full_prefix_still_forces_full(self):
        result = classify([".github/workflows/README.md"])
        self.assertTrue(result["full"])
        self.assertTrue(result["docs_links"])
        self.assertFalse(result["unclassified"])

    def test_markdown_under_a_validated_surface_keeps_that_surface(self):
        result = classify(["src/K7pl/NOTES.md"])
        self.assertTrue(result["lean_build"])
        self.assertTrue(result["docs_links"])
        self.assertFalse(result["full"])

    def test_one_forcing_path_among_light_ones_forces_full(self):
        result = classify(["docs/a.md", "docs/b.md", "lakefile.lean", "LICENSES/MIT.txt"])
        self.assertTrue(result["full"])
        self.assertFalse(result["unclassified"])


class AxiomAuditClassificationTests(unittest.TestCase):
    """`scripts/axiom-audit.sh` is called by the `impl` and by the `spec` job of verify.yaml."""

    def test_axiom_audit_runs_the_lean_and_the_specification_builds(self):
        result = classify(["scripts/axiom-audit.sh"])
        self.assertTrue(result["lean_build"])
        self.assertTrue(result["spec_build"])
        self.assertFalse(result["full"])
        self.assertFalse(result["unclassified"])
        self.assertFalse(result["spec_check"], "controle.py does not read the script")
        self.assertFalse(result["docs_links"])

    def test_plain_lean_changes_still_skip_the_specification_build(self):
        for path in ("src/K7pl/Foo.lean", "tests/FooTest.lean"):
            with self.subTest(path=path):
                result = classify([path])
                self.assertTrue(result["lean_build"])
                self.assertFalse(result["spec_build"])


class RepositoryDiffEndToEndTests(unittest.TestCase):
    """Run `impact.py --base/--head` as a process on throw-away repositories.

    The CI reads two things only: the exit status and the `GITHUB_OUTPUT` file. A failure that
    leaves both looking healthy (status 0, every flag false) makes the whole validation vanish.
    """

    KEYS = {"full", "docs_links", "spec_check", "spec_build", "lean_build", "unclassified"}

    def setUp(self):
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        self.tmp = Path(tmp.name)
        self.output = self.tmp / "github_output"
        self.env = {
            "PATH": os.environ.get("PATH", ""),
            "HOME": str(self.tmp),
            "PYTHONDONTWRITEBYTECODE": "1",
            "GIT_CONFIG_GLOBAL": os.devnull,
            "GIT_CONFIG_SYSTEM": os.devnull,
            "GIT_AUTHOR_NAME": "test",
            "GIT_AUTHOR_EMAIL": "test@example.invalid",
            "GIT_COMMITTER_NAME": "test",
            "GIT_COMMITTER_EMAIL": "test@example.invalid",
            "GIT_CEILING_DIRECTORIES": str(self.tmp),
        }

    def vcs(self, repo, *args):
        done = subprocess.run(
            ["git", "-C", str(repo), "-c", "commit.gpgsign=false", *args],
            check=True, capture_output=True, text=True, env=self.env,
        )
        return done.stdout.strip()

    def commit(self, repo, message):
        self.vcs(repo, "add", "--all")
        self.vcs(repo, "commit", "--quiet", "--allow-empty", "-m", message)
        return self.vcs(repo, "rev-parse", "HEAD")

    def run_impact(self, repo, *args):
        """Run impact.py in `repo`; returns (process, outputs written to GITHUB_OUTPUT)."""
        self.output.unlink(missing_ok=True)
        env = {**self.env, "GITHUB_OUTPUT": str(self.output)}
        done = subprocess.run(
            [sys.executable, "-I", str(IMPACT_SCRIPT), *args],
            cwd=repo, env=env, capture_output=True, text=True, timeout=60,
        )
        text = self.output.read_text() if self.output.exists() else ""
        return done, dict(line.split("=", 1) for line in text.splitlines())

    def scenario(self, before, change):
        """Commit `before`, apply `change(repo)`, commit again; returns (repo, base, head)."""
        repo = Path(tempfile.mkdtemp(dir=self.tmp))
        self.vcs(repo, "init", "--quiet")
        self.vcs(repo, "config", "diff.renames", "true")
        for path, text in before.items():
            (repo / path).parent.mkdir(parents=True, exist_ok=True)
            (repo / path).write_text(text, encoding="utf-8")
        base = self.commit(repo, "base")
        change(repo)
        return repo, base, self.commit(repo, "head")

    def impact_of_change(self, path, change):
        """Outputs when `change(repo)` is applied to a repository holding only `path`."""
        repo, base, head = self.scenario({path: "# base\n"}, change)
        done, outputs = self.run_impact(repo, "--base", base, "--head", head)
        self.assertEqual(done.returncode, 0, done.stderr)
        return done, outputs

    def test_full_paths_force_full_through_the_diff(self):
        paths = sorted(EXPECTED_FULL_EXACT) + [
            f"{prefix}end-to-end.txt" for prefix in EXPECTED_FULL_PREFIXES
        ]
        for path in paths:
            with self.subTest(path=path):
                _, outputs = self.impact_of_change(
                    path, lambda repo, path=path: (repo / path).write_text("# head\n")
                )
                self.assertEqual(outputs["full"], "true")
                self.assertEqual(outputs["unclassified"], "false")

    def test_every_kind_of_change_to_a_full_path_forces_full(self):
        def delete(repo):
            (repo / "lakefile.lean").unlink()

        def replace_by_symlink(repo):
            (repo / "lakefile.lean").unlink()
            (repo / "lakefile.lean").symlink_to("elsewhere")

        changes = {
            "modified": lambda repo: (repo / "lakefile.lean").write_text("# head\n"),
            "deleted": delete,
            "type changed": replace_by_symlink,
        }
        for label, change in changes.items():
            with self.subTest(change=label):
                done, outputs = self.impact_of_change("lakefile.lean", change)
                self.assertEqual(outputs["full"], "true")
                self.assertIn("lakefile.lean", done.stdout)

    def test_added_full_path_forces_full(self):
        repo, base, head = self.scenario(
            {"docs/note.md": "x\n"}, lambda repo: (repo / "lake-manifest.json").write_text("{}\n")
        )
        _, outputs = self.run_impact(repo, "--base", base, "--head", head)
        self.assertEqual((outputs["full"], outputs["unclassified"]), ("true", "false"))

    def test_deleting_lakefile_alone_forces_full(self):
        repo, base, head = self.scenario(
            {"lakefile.lean": "x\n", "docs/note.md": "x\n"}, lambda repo: (repo / "lakefile.lean").unlink()
        )
        done, outputs = self.run_impact(repo, "--base", base, "--head", head)
        self.assertIn("Changed paths: 1", done.stdout)
        self.assertEqual((outputs["full"], outputs["unclassified"]), ("true", "false"))

    def test_rename_is_seen_as_a_deletion_and_an_addition(self):
        renames = {
            "light to full": ("docs/note.md", "lakefile.lean"),
            "full to light": ("lakefile.lean", "docs/lakefile.md"),
            "full to full": ("lean-toolchain", "scripts/ci/toolchain.txt"),
        }
        for label, (old, new) in renames.items():
            with self.subTest(rename=label):
                def move(repo, old=old, new=new):
                    (repo / new).parent.mkdir(parents=True, exist_ok=True)
                    (repo / old).rename(repo / new)

                repo, base, head = self.scenario({old: "same content\n"}, move)
                # Precondition: with rename detection git lists the new path only, so a classifier
                # that reads that listing would not see the old path disappear.
                self.assertEqual(self.vcs(repo, "diff", "--name-only", base, head), new)
                done, outputs = self.run_impact(repo, "--base", base, "--head", head)
                self.assertIn("Changed paths: 2", done.stdout)
                self.assertIn(f"  {old!r}\n", done.stdout)
                self.assertIn(f"  {new!r}\n", done.stdout)
                self.assertEqual((outputs["full"], outputs["unclassified"]), ("true", "false"))

    def test_light_rename_stays_light(self):
        def move(repo):
            (repo / "docs/new.md").parent.mkdir(parents=True, exist_ok=True)
            (repo / "docs/old.md").rename(repo / "docs/new.md")

        repo, base, head = self.scenario({"docs/old.md": "same content\n"}, move)
        done, outputs = self.run_impact(repo, "--base", base, "--head", head)
        self.assertIn("Changed paths: 2", done.stdout)
        self.assertEqual((outputs["full"], outputs["docs_links"]), ("false", "true"))

    def test_a_failed_diff_is_fatal_and_writes_nothing(self):
        repo, base, head = self.scenario({"docs/note.md": "x\n"}, lambda repo: None)
        zeros = "0" * 40  # what `github.event.before` holds when a branch is created
        cases = {
            "unknown base": (repo, ("--base", zeros, "--head", head)),
            "unknown head": (repo, ("--base", base, "--head", zeros)),
            "not a repository": (self.tmp, ("--base", base, "--head", head)),
        }
        for label, (cwd, args) in cases.items():
            with self.subTest(case=label):
                done, outputs = self.run_impact(cwd, *args)
                self.assertNotEqual(done.returncode, 0, "a failed diff must fail the job")
                self.assertEqual(outputs, {}, "no output may be written for a failed diff")
                self.assertIn("git diff", done.stderr)
                self.assertIn("failed", done.stderr)
                self.assertNotIn("Impact:", done.stdout)

    def test_missing_or_empty_commit_range_is_an_error_not_a_silent_pass(self):
        repo, base, head = self.scenario({"docs/note.md": "x\n"}, lambda repo: None)
        for args in ((), ("--base", base), ("--head", head), ("--base", "", "--head", head)):
            with self.subTest(args=args):
                done, outputs = self.run_impact(repo, *args)
                self.assertEqual(done.returncode, 2)
                self.assertIn("--base et --head sont requis", done.stderr)
                self.assertEqual(outputs, {})

    def test_identical_commits_validate_nothing_explicitly(self):
        repo, base, _ = self.scenario({"docs/note.md": "x\n"}, lambda repo: None)
        done, outputs = self.run_impact(repo, "--base", base, "--head", base)
        self.assertEqual(done.returncode, 0)
        self.assertIn("Changed paths: 0", done.stdout)
        self.assertEqual(set(outputs), self.KEYS)
        self.assertEqual(set(outputs.values()), {"false"})

    def test_outputs_have_exactly_the_keys_the_workflow_reads(self):
        done, outputs = self.impact_of_change(
            "src/K7pl/X.lean", lambda repo: (repo / "src/K7pl/X.lean").write_text("# head\n")
        )
        self.assertEqual(set(outputs), self.KEYS)
        self.assertTrue(set(outputs.values()) <= {"true", "false"})
        self.assertEqual(outputs["lean_build"], "true")

    def test_log_shows_the_decision(self):
        done, _ = self.impact_of_change(
            "docs/note.md", lambda repo: (repo / "docs/note.md").write_text("# head\n")
        )
        self.assertIn("Changed paths: 1\n  'docs/note.md'\n", done.stdout)
        self.assertIn(
            "Impact: full=false docs_links=true spec_check=false spec_build=false "
            "lean_build=false unclassified=false\n",
            done.stdout,
        )
        self.assertNotIn("Unclassified paths:", done.stdout)

    def test_a_path_that_looks_like_a_workflow_command_is_not_printed_as_one(self):
        name = "::warning::pwned"
        done, _ = self.impact_of_change(name, lambda repo: (repo / name).write_text("x\n"))
        for line in done.stdout.splitlines():
            self.assertFalse(line.lstrip().startswith("::"), line)
        self.assertIn(f"  {name!r}\n", done.stdout)

    def test_log_lists_the_unclassified_paths(self):
        done, outputs = self.impact_of_change(
            "new-format.toml", lambda repo: (repo / "new-format.toml").write_text("# head\n")
        )
        self.assertIn("Unclassified paths:\n  'new-format.toml'\n", done.stdout)
        self.assertIn(
            "Impact: full=true docs_links=true spec_check=true spec_build=true "
            "lean_build=true unclassified=true\n",
            done.stdout,
        )
        self.assertEqual((outputs["full"], outputs["unclassified"]), ("true", "true"))

    def test_runs_without_github_output_for_local_use(self):
        env = {key: value for key, value in self.env.items()}
        done = subprocess.run(
            [sys.executable, "-I", str(IMPACT_SCRIPT), "--force-full"],
            cwd=self.tmp, env=env, capture_output=True, text=True, timeout=60,
        )
        self.assertEqual(done.returncode, 0, done.stderr)
        self.assertIn("Impact: full=true", done.stdout)

    def test_unusual_path_names_fall_back_on_full(self):
        # git quotes such names, the classifier does not recognise them: unknown, hence full.
        _, outputs = self.impact_of_change(
            "src/\u00e9.lean", lambda repo: (repo / "src/\u00e9.lean").write_text("# head\n")
        )
        self.assertEqual((outputs["full"], outputs["unclassified"]), ("true", "true"))

    def test_axiom_audit_through_the_diff(self):
        _, outputs = self.impact_of_change(
            "scripts/axiom-audit.sh", lambda repo: (repo / "scripts/axiom-audit.sh").write_text("#\n")
        )
        self.assertEqual(
            {key: outputs[key] for key in ("full", "lean_build", "spec_build", "spec_check")},
            {"full": "false", "lean_build": "true", "spec_build": "true", "spec_check": "false"},
        )

    def test_markdown_only_change_stays_light_through_the_diff(self):
        _, outputs = self.impact_of_change(
            "docs/note.md", lambda repo: (repo / "docs/note.md").write_text("# head\n")
        )
        self.assertEqual(
            {key: outputs[key] for key in ("full", "lean_build", "spec_build", "docs_links")},
            {"full": "false", "lean_build": "false", "spec_build": "false", "docs_links": "true"},
        )

    def test_force_full_needs_no_commit_range(self):
        done, outputs = self.run_impact(self.tmp, "--force-full")
        self.assertEqual(done.returncode, 0, done.stderr)
        self.assertEqual(set(outputs), self.KEYS)
        self.assertTrue(all(outputs[surface] == "true" for surface in SURFACES))
        self.assertEqual(outputs["unclassified"], "false")


if __name__ == "__main__":
    unittest.main()
