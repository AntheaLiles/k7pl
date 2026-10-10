#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Validate an SPDX 2.3 JSON document with pinned SPDX Tools plus K7PL gap guards."""

from __future__ import annotations

import hashlib
import json
import os
import shutil
import subprocess
import sys
from importlib.metadata import PackageNotFoundError, version
from pathlib import Path
from typing import Any

EXPECTED_VALIDATOR_VERSION = "0.8.5"
REPORT_SCHEMA = "k7pl.spdx-validation/v1"


def preflight_issues(document: object) -> list[dict[str, str]]:
    """Reject obvious required-field gaps, including the currently reported upstream name gap."""
    issues: list[dict[str, str]] = []
    if not isinstance(document, dict):
        return [{
            "ruleId": "SPDX-PREFLIGHT-DOCUMENT",
            "message": "The SPDX JSON root must be an object.",
            "artifact": "document",
        }]

    packages = document.get("packages")
    if not isinstance(packages, list):
        return [{
            "ruleId": "SPDX-PREFLIGHT-PACKAGES",
            "message": "The SPDX JSON packages field must be an array.",
            "artifact": "packages",
        }]

    for index, package in enumerate(packages):
        artifact = f"packages[{index}]"
        if not isinstance(package, dict):
            issues.append({
                "ruleId": "SPDX-PREFLIGHT-PACKAGE",
                "message": "Each SPDX package entry must be an object.",
                "artifact": artifact,
            })
            continue
        name = package.get("name")
        if not isinstance(name, str) or not name.strip():
            issues.append({
                "ruleId": "SPDX-PREFLIGHT-PACKAGE-NAME",
                "message": (
                    "Every package in this K7PL inventory must have a non-empty name. "
                    "This guard covers the known upstream validation gap tracked in "
                    "spdx/tools-python issue #885."
                ),
                "artifact": f"{artifact}.name",
            })
    return issues


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _report(
    path: Path,
    status: str,
    validator_version: str | None,
    digest: str | None,
    diagnostics: list[dict[str, str]],
    validator_stderr: str = "",
) -> dict[str, Any]:
    workflow: dict[str, Any] = {
        "runId": os.environ.get("GITHUB_RUN_ID"),
        "runAttempt": os.environ.get("GITHUB_RUN_ATTEMPT"),
        "checkedOutSha": os.environ.get("GITHUB_SHA"),
    }
    event_path = os.environ.get("GITHUB_EVENT_PATH")
    if event_path:
        try:
            with open(event_path, encoding="utf-8") as stream:
                event = json.load(stream)
            workflow["pullRequestHeadSha"] = (
                (event.get("pull_request") or {}).get("head", {}).get("sha")
            )
        except (OSError, json.JSONDecodeError, AttributeError):
            workflow["pullRequestHeadSha"] = None

    report: dict[str, Any] = {
        "schemaVersion": REPORT_SCHEMA,
        "status": status,
        "input": {"artifact": path.name, "sha256": digest},
        "validator": {
            "name": "spdx-tools",
            "version": validator_version,
            "expectedVersion": EXPECTED_VALIDATOR_VERSION,
            "command": ["pyspdxtools", "--infile", str(path), "--version", "SPDX-2.3"],
        },
        "workflow": workflow,
        "diagnostics": diagnostics,
        "limitations": [
            "The external validator checks the supplied SPDX document; it does not establish that the SBOM inventories every build/runtime dependency or shipped artifact.",
            "K7PL preflight guards package names because spdx/tools-python issue #885 reports that an empty PackageName may not be flagged by the external validator.",
            "This result is not a proof of vulnerability absence, licence compatibility, provenance of upstream dependencies, or overall legal/regulatory compliance.",
        ],
    }
    if validator_stderr:
        report["validatorStderr"] = validator_stderr[-8000:]
    return report


def validate(path: Path) -> tuple[dict[str, Any], int]:
    try:
        validator_version = version("spdx-tools")
    except PackageNotFoundError:
        return _report(
            path, "ERROR", None, None,
            [{"ruleId": "SPDX-VALIDATOR-MISSING", "message": "The pinned spdx-tools package is not installed.", "artifact": "toolchain"}],
        ), 2

    if validator_version != EXPECTED_VALIDATOR_VERSION:
        return _report(
            path, "ERROR", validator_version, None,
            [{"ruleId": "SPDX-VALIDATOR-VERSION", "message": f"Expected spdx-tools {EXPECTED_VALIDATOR_VERSION}, got {validator_version}.", "artifact": "toolchain"}],
        ), 2

    if shutil.which("pyspdxtools") is None:
        return _report(
            path, "ERROR", validator_version, None,
            [{"ruleId": "SPDX-VALIDATOR-CLI-MISSING", "message": "The pyspdxtools executable was not found on PATH.", "artifact": "toolchain"}],
        ), 2

    try:
        digest_before = sha256_file(path)
        with path.open("r", encoding="utf-8") as stream:
            document = json.load(stream)
    except json.JSONDecodeError as error:
        return _report(
            path, "ERROR", validator_version, None,
            [{"ruleId": "SPDX-INPUT-JSON", "message": f"Input is not valid JSON: {error}", "artifact": path.name}],
        ), 2
    except (OSError, UnicodeDecodeError) as error:
        return _report(
            path, "ERROR", validator_version, None,
            [{"ruleId": "SPDX-INPUT-READ", "message": f"Unable to read the input: {error}", "artifact": path.name}],
        ), 2

    issues = preflight_issues(document)
    if issues:
        return _report(path, "FAIL", validator_version, digest_before, issues), 1

    command = [
        "pyspdxtools",
        "--infile",
        str(path),
        "--version",
        "SPDX-2.3",
    ]
    try:
        result = subprocess.run(command, check=False, capture_output=True, text=True)
    except OSError as error:
        return _report(
            path, "ERROR", validator_version, digest_before,
            [{"ruleId": "SPDX-VALIDATOR-EXEC", "message": f"Unable to execute validator: {error}", "artifact": "toolchain"}],
        ), 2

    try:
        digest_after = sha256_file(path)
    except OSError as error:
        return _report(
            path, "ERROR", validator_version, digest_before,
            [{"ruleId": "SPDX-INPUT-READ", "message": f"Unable to re-read input after validation: {error}", "artifact": path.name}],
        ), 2

    if digest_after != digest_before:
        return _report(
            path, "ERROR", validator_version, digest_before,
            [{"ruleId": "SPDX-INPUT-CHANGED", "message": "The input bytes changed while validation was running.", "artifact": path.name}],
        ), 2

    if result.returncode != 0:
        detail = (result.stderr or result.stdout or "Validator exited unsuccessfully.").strip()
        report = _report(
            path, "FAIL", validator_version, digest_before,
            [{"ruleId": "SPDX-TOOLS-VALIDATION", "message": detail[-8000:], "artifact": path.name}],
            result.stderr,
        )
        return report, 1

    return _report(path, "PASS", validator_version, digest_before, []), 0


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        report = _report(
            Path(argv[1]) if len(argv) > 1 else Path("spdx.json"),
            "ERROR",
            None,
            None,
            [{"ruleId": "USAGE", "message": "Usage: validate_spdx.py <spdx-2.3.json>", "artifact": "arguments"}],
        )
        print(json.dumps(report, sort_keys=True))
        return 2
    report, exit_code = validate(Path(argv[1]))
    print(json.dumps(report, sort_keys=True))
    return exit_code


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
