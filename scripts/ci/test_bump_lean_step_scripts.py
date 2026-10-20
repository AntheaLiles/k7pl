# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Dry runs of the shell steps of bump-lean.yaml.

bump-lean.yaml runs on schedule or by hand, never on a pull request. Its shell steps are run here
with stub commands first on PATH (lake, python3 for check_manifest.py, a stub
scripts/latest-lean-version.sh) and throw-away repositories, without network or token. The tests
pin the version decision of the `build` job and the checks of the `open-pr` job that guard the
pull request opened with BUMP_TOKEN: the versions, the Paperproof toolchain, the untrusted
manifest artifact and the exact set of changed files.
"""

from __future__ import annotations

import unittest

from step_script_testing import StepScriptCase

PAPERPROOF = {"PAPERPROOF_WORKSPACE": "tools/paperproof-export"}


class FindVersionTests(StepScriptCase):
    """Job `build`, step "Find the latest common release"."""

    def setUp(self):
        super().setUp()
        (self.work / "lean-toolchain").write_text("leanprover/lean4:v4.34.0\n")
        workspace = self.work / "tools" / "paperproof-export"
        workspace.mkdir(parents=True)
        (workspace / "lean-toolchain").write_text("leanprover/lean4:v4.29.0\n")
        latest = self.work / "scripts" / "latest-lean-version.sh"
        latest.parent.mkdir()
        latest.write_text('#!/usr/bin/env bash\necho "$LATEST_OUT"\nexit "${LATEST_RC:-0}"\n')
        latest.chmod(0o755)

    def find(self, latest: str, status: str = "0"):
        self.output.write_text("")
        return self.run_script("bump_lean_find_version.sh", LATEST_OUT=latest, LATEST_RC=status, **PAPERPROOF)

    def outputs(self) -> dict[str, str]:
        return dict(line.split("=", 1) for line in self.output.read_text().splitlines())

    def test_only_a_strictly_newer_release_is_a_bump(self):
        for latest, newer in (("v4.35.0", "true"), ("v4.34.0", "false"), ("v4.9.0", "false"), ("v4.100.0", "true")):
            with self.subTest(latest=latest):
                result = self.find(latest)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertEqual(self.outputs(), {"current": "v4.34.0", "latest": latest, "newer": newer})

    def test_the_summary_states_both_toolchains(self):
        self.find("v4.35.0")
        summary = self.summary.read_text()
        self.assertIn("`v4.34.0`; latest common release: `v4.35.0`", summary)
        self.assertIn("(`tools/paperproof-export`, not bumped): `leanprover/lean4:v4.29.0`", summary)

    def test_a_failed_lookup_fails_before_any_output(self):
        self.assertNotEqual(self.find("", status="1").returncode, 0)
        self.assertEqual(self.output.read_text(), "")


class BuildAndTestTests(StepScriptCase):
    """Job `build`, step "Build and test"."""

    def build(self, fail_at: str):
        self.stub("lake", f'[ "$*" != "{fail_at}" ] || exit 1')
        return self.run_script("bump_lean_build_and_test.sh")

    def test_a_missing_mathlib_cache_is_only_a_warning(self):
        result = self.build("exe cache get")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("::warning::Mathlib cache unavailable", result.stdout)
        self.assertEqual([row[1:] for row in self.calls("lake")], [["exe", "cache", "get"], ["build"], ["test"]])

    def test_a_failed_build_stops_before_the_tests(self):
        self.assertNotEqual(self.build("build").returncode, 0)
        self.assertEqual([row[1:] for row in self.calls("lake")], [["exe", "cache", "get"], ["build"]])
        self.calls_file.write_text("")
        self.assertNotEqual(self.build("test").returncode, 0)


class OpenPullRequestTests(StepScriptCase):
    """Job `open-pr` (environment bump-lean, BUMP_TOKEN): the checks before the pull request."""

    def test_versions_must_be_plain_releases(self):
        ok = self.run_script("bump_lean_validate_versions.sh", LATEST="v4.35.0", CURRENT="v4.34.0")
        self.assertEqual(ok.returncode, 0, ok.stdout + ok.stderr)
        for latest, current in (("v4.35.0-rc1", "v4.34.0"), ("v4.35.0", "4.34.0"), ("v4.35.0\nx", "v4.34.0"),
                                ("v4.35.0`", "v4.34.0")):
            with self.subTest(latest=latest, current=current):
                result = self.run_script("bump_lean_validate_versions.sh", LATEST=latest, CURRENT=current)
                self.assertEqual(result.returncode, 1)
                self.assertIn("::error::version invalide", result.stdout)

    def test_the_paperproof_toolchain_must_be_a_plain_name(self):
        toolchain = self.work / "tools" / "paperproof-export" / "lean-toolchain"
        toolchain.parent.mkdir(parents=True)
        toolchain.write_text("leanprover/lean4:v4.29.0\n")
        result = self.run_script("bump_lean_paperproof_toolchain.sh", **PAPERPROOF)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(self.output.read_text(), "toolchain=leanprover/lean4:v4.29.0\n")
        for text in ("leanprover/lean4:v4.29.0-rc1\n", "leanprover/lean4:v4.29.0` [x](y)\n"):
            with self.subTest(text=text):
                self.output.write_text("")
                toolchain.write_text(text)
                result = self.run_script("bump_lean_paperproof_toolchain.sh", **PAPERPROOF)
                self.assertEqual(result.returncode, 1)
                self.assertEqual(self.output.read_text(), "")

    def untrusted(self):
        directory = self.runner_temp / "untrusted"
        directory.mkdir()
        (self.work / "lake-manifest.json").write_text('{"old": 1}\n')
        return directory

    def validate(self, status: int = 0):
        self.stub("python3", f"exit {status}")
        return self.run_script("bump_lean_validate_manifest.sh")

    def test_a_valid_manifest_is_checked_upstream_then_put_in_place(self):
        directory = self.untrusted()
        (directory / "lake-manifest.json").write_text('{"new": 1}\n')
        result = self.validate()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(self.calls("python3")[0][1:], [
            "scripts/ci/check_manifest.py", "--manifest", str(directory / "lake-manifest.json"),
            "--check-tags", "--check-upstream",
        ])
        self.assertEqual((self.work / "lake-manifest.json").read_text(), '{"new": 1}\n')

    def test_a_manifest_rejected_by_the_check_is_not_put_in_place(self):
        (self.untrusted() / "lake-manifest.json").write_text('{"new": 1}\n')
        self.assertNotEqual(self.validate(status=1).returncode, 0)
        self.assertEqual((self.work / "lake-manifest.json").read_text(), '{"old": 1}\n')

    def test_an_unexpected_artifact_is_refused_before_the_check(self):
        layouts = {
            "extra file": lambda d: ((d / "lake-manifest.json").write_text("{}"), (d / "x").write_text("")),
            "symlink": lambda d: (d / "lake-manifest.json").symlink_to(self.work / "lake-manifest.json"),
            "directory": lambda d: (d / "lake-manifest.json").mkdir(),
            "other name": lambda d: (d / "manifest.json").write_text("{}"),
            "empty": lambda d: None,
        }
        for name, layout in layouts.items():
            with self.subTest(layout=name):
                self.setUp()  # a fresh runner directory and call log for each layout
                layout(self.untrusted())
                result = self.validate()
                self.assertEqual(result.returncode, 1)
                self.assertIn("::error::", result.stdout)
                self.assertEqual(self.calls("python3"), [])
                self.assertEqual((self.work / "lake-manifest.json").read_text(), '{"old": 1}\n')

    def bumped_repository(self):
        for name in ("lake-manifest.json", "lakefile.lean", "lean-toolchain", "README.md"):
            (self.work / name).write_text("old\n")
        self.git("init", "-q", "-b", "main")
        self.git("add", "-A")
        self.git("commit", "-q", "-m", "c")
        for name in ("lake-manifest.json", "lakefile.lean", "lean-toolchain"):
            (self.work / name).write_text("new\n")

    def test_exactly_the_three_bumped_files_may_differ(self):
        self.bumped_repository()
        result = self.run_script("bump_lean_check_diff.sh")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_any_other_difference_is_refused(self):
        changes = {
            "modified": lambda: (self.work / "README.md").write_text("new\n"),
            # Staged only: `git diff` (working tree against the index) still lists the three files.
            "staged": lambda: ((self.work / "extra.txt").write_text("x"), self.git("add", "extra.txt")),
            "untracked": lambda: (self.work / "new.txt").write_text("x"),
            "unchanged": lambda: self.git("checkout", "--", "lakefile.lean"),
        }
        for name, change in changes.items():
            with self.subTest(change=name):
                self.setUp()  # a fresh repository for each change
                self.bumped_repository()
                change()
                result = self.run_script("bump_lean_check_diff.sh")
                self.assertEqual(result.returncode, 1)
                self.assertIn("::error::seuls lake-manifest.json, lakefile.lean et lean-toolchain", result.stdout)


if __name__ == "__main__":
    unittest.main()
