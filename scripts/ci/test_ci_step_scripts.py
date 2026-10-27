# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Dry runs of the step scripts that a pull request does not run.

The `status` job of ci.yaml runs only on a push to main, the workflow_dispatch branches of the
impact step only on a manual or automated dispatch, and the BadgeApp drift job of security.yaml
only on schedule or by hand. Their scripts are run here with stub commands first on PATH (gh,
git when no repository is needed, python3 for the programs they call) and fake runner files: no
network, no token, no push. The tests check the commands invoked and what is written to
GITHUB_OUTPUT and GITHUB_STEP_SUMMARY.
"""

from __future__ import annotations

import subprocess
import unittest

from step_script_testing import StepScriptCase


class ImpactScriptTests(StepScriptCase):
    """ci.yaml, job `impact`: which range the classifier gets for each event."""

    def setUp(self):
        super().setUp()
        self.stub("python3")
        self.git("init", "-q", "-b", "main")
        self.m1 = self.commit("f", "1", "m1")
        self.m2 = self.commit("f", "2", "m2")
        self.git("update-ref", "refs/remotes/origin/main", self.m2)
        self.git("switch", "-q", "-c", "topic", self.m1)
        self.b1 = self.commit("g", "b", "b1")

    def classify(self, event, ref, head, base="b" * 40):
        result = self.run_script("ci_impact.sh", EVENT_NAME=event, REF=ref, HEAD_SHA=head, BASE_SHA=base)
        return result, [row[1:] for row in self.calls("python3")]

    def test_a_pull_request_classifies_its_range(self):
        result, calls = self.classify("pull_request", "refs/pull/1/merge", self.b1, self.m1)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(calls, [["scripts/ci/impact.py", "--base", self.m1, "--head", self.b1]])

    def test_a_manual_dispatch_forces_the_full_validation(self):
        result, calls = self.classify("workflow_dispatch", "refs/heads/topic", self.b1)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(calls, [["scripts/ci/impact.py", "--force-full"]])

    def test_the_generated_status_branch_is_classified_against_main(self):
        result, calls = self.classify("workflow_dispatch", "refs/heads/automation/generated-status", self.b1)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(calls, [["scripts/ci/impact.py", "--base", self.m1, "--head", self.b1]])

    def test_a_commit_already_on_main_gets_the_full_validation(self):
        result, calls = self.classify("workflow_dispatch", "refs/heads/automation/generated-status", self.m2)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(calls, [["scripts/ci/impact.py", "--force-full"]])

    def test_the_generated_status_branch_needs_origin_main(self):
        self.git("update-ref", "-d", "refs/remotes/origin/main")
        result, calls = self.classify("workflow_dispatch", "refs/heads/automation/generated-status", self.b1)
        self.assertEqual(result.returncode, 1)
        self.assertIn("::error::origin/main is not available in the checkout", result.stdout)
        self.assertEqual(calls, [])


class StatusScriptTests(StepScriptCase):
    """ci.yaml, job `status` (push on main only)."""

    def outputs(self) -> str:
        return self.output.read_text()

    def test_baseline_is_current_when_only_status_changed_since_its_commit(self):
        self.git("init", "-q", "-b", "main")
        base = self.commit("wiki/STATUS.md", "# K7PL Status\n", "c1")
        self.git("remote", "add", "origin", str(self.work))
        head = self.commit("wiki/STATUS.md", f"# K7PL Status\n\n**Generated for commit:** {base}\n", "c2")
        result = self.run_script("ci_status_baseline.sh", GITHUB_SHA=head)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.outputs(), "current=true\n")
        self.assertIn(f"latest substantive commit ({base})", result.stdout)

    def test_baseline_is_stale_after_another_change_or_without_a_marker(self):
        self.git("init", "-q", "-b", "main")
        base = self.commit("wiki/STATUS.md", "# K7PL Status\n", "c1")
        self.git("remote", "add", "origin", str(self.work))
        self.commit("wiki/STATUS.md", f"# K7PL Status\n\n**Generated for commit:** {base}\n", "c2")
        head = self.commit("src.txt", "change", "c3")
        self.assertEqual(self.run_script("ci_status_baseline.sh", GITHUB_SHA=head).returncode, 0)
        self.git("checkout", "-q", base)
        self.assertEqual(self.run_script("ci_status_baseline.sh", GITHUB_SHA=base).returncode, 0)
        self.assertEqual(self.outputs(), "current=false\ncurrent=false\n")

    def test_changes_reports_whether_status_was_rewritten(self):
        self.git("init", "-q", "-b", "main")
        self.commit("wiki/STATUS.md", "# K7PL Status\n", "c1")
        self.assertEqual(self.run_script("ci_status_changes.sh").returncode, 0)
        (self.work / "wiki" / "STATUS.md").write_text("# K7PL Status\n\nnew\n")
        self.assertEqual(self.run_script("ci_status_changes.sh").returncode, 0)
        self.assertEqual(self.outputs(), "changed=false\nchanged=true\n")

    def test_publish_commits_status_only_and_force_pushes_the_branch(self):
        self.stub("git")
        result = self.run_script("ci_status_publish.sh")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual([row[1:] for row in self.calls("git")], [
            ["switch", "-C", "automation/generated-status"],
            ["config", "user.name", "github-actions[bot]"],
            ["config", "user.email", "41898282+github-actions[bot]@users.noreply.github.com"],
            ["add", "wiki/STATUS.md"],
            ["commit", "-m", "ci: update generated project status"],
            ["push", "--force", "origin", "automation/generated-status"],
        ])

    def test_publish_stops_at_the_first_failing_git_command(self):
        self.stub("git", '[ "$1" != commit ] || exit 1')
        result = self.run_script("ci_status_publish.sh")
        self.assertEqual(result.returncode, 1)
        self.assertEqual([row[1] for row in self.calls("git")], ["switch", "config", "config", "add", "commit"])

    def test_pull_request_is_opened_only_when_none_is_open(self):
        self.stub("gh", 'if [ "$2" = list ]; then echo "$OPEN"; fi')
        self.assertEqual(self.run_script("ci_status_pull_request.sh", GH_TOKEN="t", OPEN="1").returncode, 0)
        self.assertEqual([row[1:3] for row in self.calls("gh")], [["pr", "list"]])
        self.assertEqual(self.run_script("ci_status_pull_request.sh", GH_TOKEN="t", OPEN="0").returncode, 0)
        create = self.calls("gh")[-1]
        self.assertEqual(create[1:3], ["pr", "create"])
        self.assertEqual(create[create.index("--head") + 1], "automation/generated-status")
        self.assertEqual(create[create.index("--base") + 1], "main")

    def test_pull_request_fails_when_gh_cannot_list(self):
        self.stub("gh", 'exit 1')
        result = self.run_script("ci_status_pull_request.sh", GH_TOKEN="t")
        self.assertEqual(result.returncode, 1)
        self.assertEqual(len(self.calls("gh")), 1)


class AxiomEvidenceScriptTests(StepScriptCase):
    """Generated status must never infer a passing axiom audit from an absent artifact."""

    def setUp(self):
        super().setUp()
        self.stub("gh", 'if [ "$1" = "run" ] && [ "$2" = "list" ]; then printf "[]"; else exit 2; fi')

    def fetch(self, **overrides):
        env = {
            "EVENT_NAME": "push",
            "SOURCE_SHA": "a" * 40,
            "CURRENT_SHA": "a" * 40,
            "GITHUB_REPOSITORY": "AntheaLiles/k7pl",
            "GH_TOKEN": "test-token",
        }
        env.update(overrides)
        return self.run_script("ci_status_fetch_axioms.sh", **env)

    def test_missing_successful_run_is_not_available_not_a_pass(self):
        result = self.fetch()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.output.read_text(), "available=false\nreport_path=\n")
        self.assertIn("No completed successful K7PL formal-semantics run", result.stdout)
        self.assertEqual(len(self.calls("gh")), 1)

    def test_malformed_source_commit_fails_closed(self):
        result = self.fetch(SOURCE_SHA="not-a-commit")
        self.assertEqual(result.returncode, 1)
        self.assertIn("full 40-character SHA-1", result.stdout)
        self.assertEqual(self.calls("gh"), [])


class BadgeDriftScriptTests(StepScriptCase):
    """security.yaml, job `badge-criteria-drift` (schedule and manual runs only)."""

    def drift(self, status: int) -> subprocess.CompletedProcess:
        self.stub("python3", f'echo "{{}}" > "${{@: -1}}"; exit {status}')
        return self.run_script("security_badge_criteria_drift.sh")

    def test_every_outcome_exits_with_its_status_and_is_stated(self):
        # F3, owner decision 2026-10-25: drift and unavailable checks
        # fail the job (exit 1 and 2) instead of warning and exiting 0.
        expected = {
            0: ("", "unchanged from the pinned registry"),
            1: ("::error::OpenSSF BadgeApp criteria changed upstream", "Upstream criteria drift detected"),
            2: ("::error::Could not verify", "This is not evidence that the criteria are unchanged"),
        }
        for status, (annotation, summary) in expected.items():
            with self.subTest(status=status):
                self.summary.write_text("")
                result = self.drift(status)
                self.assertEqual(result.returncode, status, result.stderr)
                self.assertIn(annotation, result.stdout)
                self.assertIn(summary, self.summary.read_text())
        self.assertEqual(
            self.calls("python3")[0][1:],
            ["scripts/ci/check_badge_proposals.py", "--check-upstream", "--report",
             str(self.runner_temp / "badge-criteria-drift.json")],
        )


if __name__ == "__main__":
    unittest.main()
