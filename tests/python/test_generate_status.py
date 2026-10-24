# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for `scripts/generate_status.py`, the generator of `docs/STATUS.md`.

The counts used to come from `bash -lc "find <dir> -type f -name '*.lean' | wc -l"`; the
differential test below keeps `find` as the oracle of `count_lean_files` on a tree built to
exercise its edge cases (hidden directories, symbolic links, case, directories named `*.lean`).
"""

from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

import pytest

import generate_status as gs

CI_RESULTS = {
    "Impact analysis": "SUCCESS",
    "Verification aggregate": "FAILURE",
    "REUSE": "SUCCESS",
    "Conventional Commits": "SKIPPED",
    "Security": "UNKNOWN",
}


def write(path, text=""):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


@pytest.fixture
def tricky_tree(tmp_path):
    """A tree whose `*.lean` regular files are exactly the five marked `counted`."""
    root = tmp_path / "src"
    for rel in ("A.lean", "K/B.lean", "K/Deep/C.lean", ".hidden/D.lean", "dir.lean/E.lean"):
        write(root / rel, "-- counted\n")
    for rel in ("upper.LEAN", "notes.lean.bak", "lean", "K/readme.md"):
        write(root / rel, "-- not counted\n")
    write(tmp_path / "outside" / "F.lean", "-- reached only through a link\n")
    (root / "link.lean").symlink_to(root / "A.lean")
    (root / "linked-dir").symlink_to(tmp_path / "outside", target_is_directory=True)
    (root / "dangling.lean").symlink_to(tmp_path / "missing.lean")
    return root


def find_count(directory) -> int:
    done = subprocess.run(
        f"find '{directory}' -type f -name '*.lean' | wc -l",
        shell=True, capture_output=True, text=True, check=True,
    )
    return int(done.stdout)


def test_count_lean_files_counts_regular_files_only(tricky_tree):
    assert gs.count_lean_files(tricky_tree) == 5


@pytest.mark.skipif(shutil.which("find") is None, reason="needs find(1) as the oracle")
def test_count_lean_files_matches_find(tricky_tree, tmp_path):
    (tmp_path / "src-link").symlink_to(tricky_tree, target_is_directory=True)
    for directory in (tricky_tree, tricky_tree / "K", tmp_path / "src-link", tmp_path):
        assert gs.count_lean_files(directory) == find_count(directory), directory


def test_a_missing_directory_counts_zero(tmp_path):
    assert gs.count_lean_files(tmp_path / "absent") == 0


def test_implementation_version():
    lakefile = 'package k7pl where\n  version := v!"0.1.0"\n  lintDriver := "x"\n'
    assert gs.implementation_version(lakefile) == "0.1.0"
    assert gs.implementation_version('version:=v!"2.0.0-rc1"') == "2.0.0-rc1"
    assert gs.implementation_version("package k7pl where\n") == "unknown"
    assert gs.implementation_version('version := "0.1.0"') == "unknown"


def test_generated_date_keeps_the_commit_offset():
    assert gs.generated_date("2026-10-14T23:30:00+02:00") == "2026-10-14"
    assert gs.generated_date("2026-10-14T23:30:00-05:00") == "2026-10-14"
    assert gs.generated_date("2026-10-14T23:30:00Z") == "2026-10-14"


def render(**overrides):
    facts = dict(
        commit="0" * 40,
        date="2026-10-14T12:00:00+02:00",
        version="0.1.0",
        toolchain="leanprover/lean4:v4.34.0",
        verification="SUCCESS",
        ci_results=CI_RESULTS,
        counts={"src": 11, "tests": 6, "spec": 64},
    )
    facts.update(overrides)
    return gs.render_status(**facts)


def test_render_status_layout():
    text = render()
    lines = text.split("\n")
    assert lines[0] == "<!-- GENERATED CONTENT START -->"
    assert "# K7PL Status" in lines
    assert text.endswith("manual edits are not part of the project workflow.\n")
    assert not text.endswith("\n\n")
    for line in (
        "**Generated for commit:** " + "0" * 40,
        "**Commit date:** 2026-10-14T12:00:00+02:00",
        "**Generated date:** 2026-10-14",
        "**Implementation version:** 0.1.0",
        "**Lean toolchain:** leanprover/lean4:v4.34.0",
        "| Verification gate (CI OK aggregate) | SUCCESS |",
        "| Impact analysis | SUCCESS |",
        "| Verification aggregate (impact scope) | FAILURE |",
        "| REUSE | SUCCESS |",
        "| Conventional Commits | SKIPPED |",
        "| Security | UNKNOWN |",
        "| Lean source files under src/ | 11 |",
        "| Lean test files under tests/ | 6 |",
        "| Lean specification modules under spec/ | 64 |",
    ):
        assert line in lines, line


def test_axiom_traceability_lists_expected_dependencies_not_run_status(tmp_path):
    contract = tmp_path / "axiom-contract.json"
    contract.write_text(
        json.dumps({
            "declarations": [
                {"name": "A.zero", "axioms": [], "role": "constructive theorem"},
                {"name": "A.extensional", "axioms": ["propext"], "role": "extensionality"},
            ]
        }),
        encoding="utf-8",
    )
    rendered = "\n".join(gs.render_axiom_traceability(contract))
    assert "Axiomes attendus" in rendered
    assert "`A.zero`" in rendered
    assert "∅ (aucun axiome attendu)" in rendered
    assert "`propext`" in rendered
    assert "ne prouve pas que le commit courant a passé l’audit" in rendered
    assert "rapport des dépendances effectivement observées" in rendered


def test_axiom_traceability_absence_is_explicit(tmp_path):
    rendered = "\n".join(gs.render_axiom_traceability(tmp_path / "missing.json"))
    assert "Aucun contrat de dépendance aux axiomes n’existe" in rendered
    assert "aucune dépendance par déclaration" in rendered


def test_render_status_needs_every_fact():
    with pytest.raises(KeyError):
        render(ci_results={key: value for key, value in CI_RESULTS.items() if key != "Security"})
    with pytest.raises(KeyError):
        render(counts={"src": 1, "tests": 1})


@pytest.mark.skipif(shutil.which("git") is None, reason="needs git")
def test_main_writes_the_facts_of_the_working_tree(tmp_path, monkeypatch):
    env = {
        "PATH": os.environ.get("PATH", ""),
        "HOME": str(tmp_path),
        "GIT_CONFIG_GLOBAL": os.devnull,
        "GIT_CONFIG_SYSTEM": os.devnull,
        "GIT_AUTHOR_NAME": "test",
        "GIT_AUTHOR_EMAIL": "test@example.invalid",
        "GIT_COMMITTER_NAME": "test",
        "GIT_COMMITTER_EMAIL": "test@example.invalid",
        "GIT_COMMITTER_DATE": "2026-10-14T23:30:00+02:00",
    }
    repo = tmp_path / "repo"
    write(repo / "lean-toolchain", "leanprover/lean4:v0.0.0\n")
    write(repo / "lakefile.lean", 'package demo where\n  version := v!"9.9.9"\n')
    for rel in ("src/A.lean", "src/K/B.lean", "tests/T.lean", "spec/S.lean", "spec/T.lean", "spec/U.lean"):
        write(repo / rel, "-- module\n")
    write(repo / "docs" / "STATUS.md", "stale\n")
    for args in (("init", "--quiet"), ("add", "--all"), ("commit", "--quiet", "-m", "demo")):
        subprocess.run(["git", "-c", "commit.gpgsign=false", *args], cwd=repo, env=env, check=True)
    commit = subprocess.run(
        ["git", "rev-parse", "HEAD"], cwd=repo, env=env, check=True, capture_output=True, text=True
    ).stdout.strip()

    refreshed = []
    monkeypatch.setattr(gs.couverture, "update_status", refreshed.append)
    for name in ("VERIFICATION", "IMPACT", "VERIFY", "REUSE", "COMMITLINT", "SECURITY"):
        suffix = "" if name == "VERIFICATION" else "_RESULT"
        monkeypatch.delenv(f"K7PL_{name}{suffix}", raising=False)
    monkeypatch.setenv("K7PL_IMPACT_RESULT", "success")
    monkeypatch.setenv("GIT_CONFIG_GLOBAL", os.devnull)
    monkeypatch.chdir(repo)
    monkeypatch.setattr(sys, "argv", ["generate_status.py", "--verification", "success"])
    gs.main()

    text = (repo / "docs" / "STATUS.md").read_text(encoding="utf-8")
    assert refreshed == [Path("docs/STATUS.md")]
    assert text == render(
        commit=commit,
        date="2026-10-14T23:30:00+02:00",
        version="9.9.9",
        toolchain="leanprover/lean4:v0.0.0",
        verification="SUCCESS",
        ci_results={
            "Impact analysis": "SUCCESS",
            "Verification aggregate": "UNKNOWN",
            "REUSE": "UNKNOWN",
            "Conventional Commits": "UNKNOWN",
            "Security": "UNKNOWN",
        },
        counts={"src": 2, "tests": 1, "spec": 3},
    )
