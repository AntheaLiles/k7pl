# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Dry runs of the step scripts of the `check` job of release.yaml.

release.yaml runs on a pushed `spec-v*`/`v*` tag or a manual rehearsal, never on a pull request:
these scripts are run here with stub commands first on PATH (gh) and throw-away repositories,
without network or token, and the tests check what they accept, what they refuse and what they
write to GITHUB_OUTPUT, GITHUB_STEP_SUMMARY and release-notes.md.
"""

from __future__ import annotations

import shutil
import unittest

from step_script_testing import SCRIPTS, StepScriptCase

SHA = "c" * 40


class ResolveTests(StepScriptCase):
    """Step "Resolve what is being released"."""

    def resolve(self, event="push", ref_type="tag", ref_name="", kind="", version=""):
        return self.run_script("release_resolve.sh", EVENT_NAME=event, REF_TYPE=ref_type, REF_NAME=ref_name,
                               INPUT_KIND=kind, INPUT_VERSION=version)

    def outputs(self) -> dict[str, str]:
        return dict(line.split("=", 1) for line in self.output.read_text().splitlines())

    def test_a_pushed_tag_is_a_release(self):
        for tag, kind, version in (("spec-v1.2.3", "spec", "1.2.3"),
                                   ("v0.1.0-alpha.2", "implementation", "0.1.0-alpha.2")):
            with self.subTest(tag=tag):
                self.output.write_text("")
                result = self.resolve(ref_name=tag)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertEqual(self.outputs(), {"kind": kind, "version": version, "tag": tag, "dry_run": "false"})
        self.assertEqual(self.summary.read_text(), "")

    def test_a_dispatch_is_a_rehearsal(self):
        result = self.resolve(event="workflow_dispatch", ref_type="branch", ref_name="main",
                              kind="implementation", version="2.0.0-rc.1")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(self.outputs(),
                         {"kind": "implementation", "version": "2.0.0-rc.1", "tag": "v2.0.0-rc.1", "dry_run": "true"})
        self.assertIn("Rehearsal of v2.0.0-rc.1", self.summary.read_text())

    def test_refusals_write_no_output(self):
        cases = {
            "neither spec-vX.Y.Z nor vX.Y.Z": dict(ref_name="release-1"),
            "expected a tag": dict(ref_type="branch", ref_name="main"),
            "is not a version": dict(ref_name="spec-v1.2"),
            "'1.0.0;id' is not a version": dict(ref_name="v1.0.0;id"),
            "unknown kind 'docs'": dict(event="workflow_dispatch", ref_type="branch", kind="docs", version="1.0.0"),
            "'1.0.0-' is not a version": dict(event="workflow_dispatch", ref_type="branch", kind="spec",
                                              version="1.0.0-"),
        }
        for message, args in cases.items():
            with self.subTest(message=message):
                result = self.resolve(**args)
                self.assertEqual(result.returncode, 1)
                self.assertIn("::error::", result.stdout)
                self.assertIn(message, result.stdout)
                self.assertEqual(self.output.read_text(), "")


class MetadataTests(StepScriptCase):
    """Step "Check the release metadata and extract the notes"."""

    def setUp(self):
        super().setUp()
        (self.work / "scripts" / "ci").mkdir(parents=True)
        shutil.copy(SCRIPTS / "citation_version.sh", self.work / "scripts" / "ci")
        (self.work / "lakefile.lean").write_text('package k7pl where\n  version := v!"0.1.0"\n')
        (self.work / "CHANGELOG.md").write_text("# Changelog\n\n## [0.1.0]\n\n- First.\n\n## [0.0.1]\n\n- Old.\n")
        (self.work / "CITATION.cff").write_text('cff-version: 1.2.0\nversion: "1.0.0"\n')
        (self.work / "spec").mkdir()
        self.spec_changelog = self.work / "spec" / "CHANGELOG.md"
        self.spec_changelog.write_text("# Spec\n\n## [1.0.0]\n\n- Added x.\n\n## [0.9.0]\n\n- Older.\n")

    def check(self, kind, version, tag):
        return self.run_script("release_check_metadata.sh", KIND=kind, VERSION=version, TAG=tag)

    def notes(self) -> str:
        return (self.work / "release-notes.md").read_text()

    def test_matching_releases_get_their_changelog_section_as_notes(self):
        result = self.check("implementation", "0.1.0", "v0.1.0")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(self.notes(), "\n- First.\n\n")
        result = self.check("spec", "1.0.0", "spec-v1.0.0")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(self.notes(), "\n- Added x.\n\n")

    def test_a_version_mismatch_is_refused(self):
        result = self.check("implementation", "0.2.0", "v0.2.0")
        self.assertEqual(result.returncode, 1)
        self.assertIn("::error::lakefile.lean déclare '0.1.0' mais la release est 'v0.2.0'", result.stdout)
        result = self.check("spec", "1.1.0", "spec-v1.1.0")
        self.assertEqual(result.returncode, 1)
        self.assertIn("::error::CITATION.cff déclare '1.0.0' mais la release est 'spec-v1.1.0'", result.stdout)

    def test_a_missing_or_blank_section_is_refused(self):
        for text in ("# Spec\n\n## [0.9.0]\n\n- Older.\n", "# Spec\n\n## [1.0.0]\n  \n## [0.9.0]\n- Older.\n"):
            with self.subTest(text=text):
                self.spec_changelog.write_text(text)
                result = self.check("spec", "1.0.0", "spec-v1.0.0")
                self.assertEqual(result.returncode, 1)
                self.assertIn("::error::spec/CHANGELOG.md n'a pas de section '## [1.0.0]' non vide", result.stdout)


class OnMainTests(StepScriptCase):
    """Step "Check that the tagged commit is on main"."""

    def setUp(self):
        super().setUp()
        self.git("init", "-q", "-b", "main")
        self.c1 = self.commit("f", "1", "c1")
        self.c2 = self.commit("f", "2", "c2")
        self.git("update-ref", "refs/remotes/origin/main", self.c2)

    def check(self, sha, dry_run="false"):
        return self.run_script("release_check_on_main.sh", TAG="spec-v1.0.0", DRY_RUN=dry_run, GITHUB_SHA=sha)

    def test_a_tag_on_main_is_accepted(self):
        self.git("tag", "-a", "-m", "t", "spec-v1.0.0", self.c2)
        result = self.check(self.c2)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn(f"{self.c2} is on main.", result.stdout)

    def test_a_moved_tag_is_refused(self):
        self.git("tag", "spec-v1.0.0", self.c1)
        result = self.check(self.c2)
        self.assertEqual(result.returncode, 1)
        self.assertIn("the tag moved", result.stdout)

    def test_a_rehearsal_needs_no_tag_but_a_commit_on_main(self):
        self.assertEqual(self.check(self.c1, dry_run="true").returncode, 0)
        self.git("switch", "-q", "-c", "side", self.c1)
        side = self.commit("g", "x", "side")
        result = self.check(side, dry_run="true")
        self.assertEqual(result.returncode, 1)
        self.assertIn("is not an ancestor of origin/main: refusing to release it", result.stdout)

    def test_origin_main_is_required(self):
        self.git("update-ref", "-d", "refs/remotes/origin/main")
        result = self.check(self.c2, dry_run="true")
        self.assertEqual(result.returncode, 1)
        self.assertIn("::error::origin/main is not available in the checkout", result.stdout)


class CiOkTests(StepScriptCase):
    """Step "Check that CI OK succeeded on the tagged commit"."""

    def check(self, run_ids: str, status: int = 0):
        self.stub("gh", f'printf "{run_ids}"; exit {status}')
        return self.run_script("release_check_ci_ok.sh", GH_TOKEN="t", GH_REPO="owner/k7pl", GITHUB_SHA=SHA)

    def test_a_successful_run_from_github_actions_is_required(self):
        result = self.check("11\\n")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        call = self.calls("gh")[0]
        self.assertEqual(call[1:4], ["api", "--paginate", f"repos/owner/k7pl/commits/{SHA}/check-runs?per_page=100"])
        query = call[call.index("--jq") + 1]
        for condition in ('.name == "CI OK"', '.conclusion == "success"', '.app.slug == "github-actions"'):
            self.assertIn(condition, query)

    def test_no_successful_run_or_a_failing_query_is_refused(self):
        result = self.check("")
        self.assertEqual(result.returncode, 1)
        self.assertIn("::error::no successful 'CI OK' check run from GitHub Actions", result.stdout)
        self.assertNotEqual(self.check("11\\n", status=1).returncode, 0)


if __name__ == "__main__":
    unittest.main()
