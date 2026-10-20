# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Test support: run a workflow step script of scripts/ci with stub commands and fake runner files.

`StepScriptCase` gives each test a temporary directory holding a `bin/` directory placed first on
PATH, a working directory, and the files that the runner provides (GITHUB_OUTPUT,
GITHUB_STEP_SUMMARY, GITHUB_PATH, RUNNER_TEMP). `stub(name, body)` writes a command that records
its arguments, then runs `body`; `calls()` returns the recorded invocations. Nothing reaches the
network and no real token is used: the step scripts that pull request CI never runs (release,
Zenodo, scheduled or main-only jobs) are checked this way.
"""

from __future__ import annotations

import os
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts" / "ci"
SEP = "\x1f"

STUB = """#!/usr/bin/env bash
{{ printf '%s' "${{0##*/}}"; printf '\\x1f%s' "$@"; printf '\\n'; }} >> "$CALL_LOG"
{body}
"""

GIT_ENV = {
    "GIT_AUTHOR_NAME": "t",
    "GIT_AUTHOR_EMAIL": "t@example.invalid",
    "GIT_COMMITTER_NAME": "t",
    "GIT_COMMITTER_EMAIL": "t@example.invalid",
    "GIT_CONFIG_NOSYSTEM": "1",
}


@unittest.skipIf(shutil.which("bash") is None or shutil.which("git") is None, "bash and git are required")
class StepScriptCase(unittest.TestCase):
    def setUp(self):
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        self.tmp = Path(tmp.name)
        self.bin = self.tmp / "bin"
        self.bin.mkdir()
        self.work = self.tmp / "work"
        self.work.mkdir()
        self.runner_temp = self.tmp / "runner-temp"
        self.runner_temp.mkdir()
        self.calls_file = self.tmp / "calls"
        self.output = self.tmp / "github_output"
        self.summary = self.tmp / "step_summary"
        self.github_path = self.tmp / "github_path"
        for path in (self.calls_file, self.output, self.summary, self.github_path):
            path.write_text("")
        self.env = {
            "PATH": f"{self.bin}{os.pathsep}{os.environ.get('PATH', '')}",
            "HOME": str(self.tmp),
            "CALL_LOG": str(self.calls_file),
            "GITHUB_OUTPUT": str(self.output),
            "GITHUB_STEP_SUMMARY": str(self.summary),
            "GITHUB_PATH": str(self.github_path),
            "RUNNER_TEMP": str(self.runner_temp),
            **GIT_ENV,
        }

    def stub(self, name: str, body: str = "") -> None:
        """A command `name` first on PATH: it records its arguments, then runs `body` (bash)."""
        path = self.bin / name
        path.write_text(STUB.format(body=body), encoding="utf-8")
        path.chmod(0o755)

    def run_script(self, name: str, *args: str, cwd: Path | None = None, **env: str) -> subprocess.CompletedProcess:
        return subprocess.run(
            ["bash", str(SCRIPTS / name), *args], cwd=cwd or self.work, env={**self.env, **env},
            capture_output=True, text=True, check=False, timeout=60,
        )

    def calls(self, command: str | None = None) -> list[list[str]]:
        """The recorded invocations, [command, arg...], optionally of one command only."""
        rows = [line.split(SEP) for line in self.calls_file.read_text().splitlines()]
        return [row for row in rows if command is None or row[0] == command]

    def git(self, *args: str) -> str:
        return subprocess.run(["git", *args], cwd=self.work, env={**os.environ, **GIT_ENV, "HOME": str(self.tmp)},
                              check=True, capture_output=True, text=True).stdout.strip()

    def commit(self, path: str, text: str, message: str) -> str:
        target = self.work / path
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(text)
        self.git("add", "-A")
        self.git("commit", "-q", "-m", message)
        return self.git("rev-parse", "HEAD")
