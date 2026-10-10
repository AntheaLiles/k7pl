#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Non-gating exploratory probes of spdx-tools diagnostics on mutated SPDX 2.3 JSON.

This records observations; it deliberately does not assert that the upstream validator
must accept or reject any individual mutation. A human must review the observations
against the applicable SPDX 2.3 specification before using them to design a gate.
"""

from __future__ import annotations

import argparse
import copy
import hashlib
import json
import os
import platform
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime, timezone
from importlib.metadata import PackageNotFoundError, version
from pathlib import Path
from typing import Any, Callable

EXPECTED_VALIDATOR_VERSION = "0.8.5"
ROOT = Path(__file__).resolve().parents[2]
WRAPPER = ROOT / "scripts" / "ci" / "validate_spdx.py"


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _missing_namespace(document: dict[str, Any]) -> None:
    document.pop("documentNamespace", None)


def _unsupported_spdx_version(document: dict[str, Any]) -> None:
    document["spdxVersion"] = "SPDX-9.9"


def _missing_download_location(document: dict[str, Any]) -> None:
    document["packages"][0].pop("downloadLocation", None)


def _invalid_license_expression(document: dict[str, Any]) -> None:
    document["packages"][0]["licenseDeclared"] = "GPL-2.0 AND ("


def _dangling_relationship(document: dict[str, Any]) -> None:
    document["relationships"][0]["relatedSpdxElement"] = "SPDXRef-Probe-Does-Not-Exist"


def _duplicate_package_identifier(document: dict[str, Any]) -> None:
    if len(document["packages"]) < 2:
        raise ValueError("duplicate SPDXID probe requires at least two packages")
    document["packages"][1]["SPDXID"] = document["packages"][0]["SPDXID"]


def _empty_package_name(document: dict[str, Any]) -> None:
    document["packages"][0]["name"] = ""


PROBES: tuple[tuple[str, str, Callable[[dict[str, Any]], None]], ...] = (
    ("missing-document-namespace", "Probe a missing required document identity field.", _missing_namespace),
    ("unsupported-spdx-version", "Probe an unsupported SPDX version token.", _unsupported_spdx_version),
    ("missing-package-download-location", "Probe a package with its download location field removed.", _missing_download_location),
    ("invalid-license-expression", "Probe a malformed declared-license expression.", _invalid_license_expression),
    ("dangling-relationship-reference", "Probe a relationship pointing to an undeclared SPDX identifier.", _dangling_relationship),
    ("duplicate-package-spdxid", "Probe duplicate package identifiers.", _duplicate_package_identifier),
    ("empty-package-name-upstream-885", "Known upstream gap probe tracked in spdx/tools-python issue #885; wrapper preflight should intercept it.", _empty_package_name),
)


def _invoke(command: list[str]) -> dict[str, Any]:
    try:
        result = subprocess.run(command, check=False, capture_output=True, text=True)
        return {
            "returnCode": result.returncode,
            "returnedZero": result.returncode == 0,
            "stdout": (result.stdout or "")[-3000:],
            "stderr": (result.stderr or "")[-3000:],
            "executionError": None,
        }
    except OSError as error:
        return {
            "returnCode": None,
            "returnedZero": None,
            "stdout": "",
            "stderr": "",
            "executionError": str(error),
        }


def _observe_case(name: str, hypothesis: str, document: dict[str, Any], directory: Path) -> dict[str, Any]:
    input_path = directory / f"{name}.spdx.json"
    input_path.write_text(
        json.dumps(document, sort_keys=True, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    external = _invoke(["pyspdxtools", "--infile", str(input_path), "--version", "SPDX-2.3"])
    wrapper = _invoke([sys.executable, str(WRAPPER), str(input_path)])
    wrapper_report: dict[str, Any] | None = None
    try:
        wrapper_report = json.loads(wrapper["stdout"])
    except json.JSONDecodeError:
        pass
    return {
        "name": name,
        "probeHypothesis": hypothesis,
        "inputSha256": sha256_file(input_path),
        "externalValidator": external,
        "wrapper": {
            "returnCode": wrapper["returnCode"],
            "executionError": wrapper["executionError"],
            "status": wrapper_report.get("status") if wrapper_report else None,
            "diagnosticRuleIds": [
                item.get("ruleId") for item in (wrapper_report or {}).get("diagnostics", [])
            ],
            "diagnosticMessages": [
                item.get("message") for item in (wrapper_report or {}).get("diagnostics", [])
            ],
        },
    }


def run_probes(input_path: Path) -> dict[str, Any]:
    try:
        validator_version = version("spdx-tools")
    except PackageNotFoundError:
        validator_version = None
    base: dict[str, Any] = {
        "schemaVersion": "k7pl.spdx-negative-probe/v1",
        "probeOnly": True,
        "blockingControl": False,
        "measuredAt": datetime.now(timezone.utc).isoformat(timespec="milliseconds").replace("+00:00", "Z"),
        "method": (
            "The same positive SPDX 2.3 document is copied and mutated one case at a time. "
            "Both pyspdxtools and the K7PL wrapper are invoked; raw status/output is recorded. "
            "Probe hypotheses are not asserted as conformance conclusions."
        ),
        "environment": {
            "pythonVersion": platform.python_version(),
            "platform": platform.platform(),
            "validatorVersion": validator_version,
            "expectedValidatorVersion": EXPECTED_VALIDATOR_VERSION,
            "validatorExecutable": shutil.which("pyspdxtools"),
            "wrapperSha256": sha256_file(WRAPPER),
        },
        "positiveInput": {"artifact": input_path.name, "sha256": None},
        "positiveControl": None,
        "cases": [],
        "limitations": [
            "This is an exploratory mutation corpus, not comprehensive SPDX 2.3 schema coverage.",
            "A zero exit code is an observation, not by itself a conclusion of standards conformance.",
            "Probe hypotheses must be reviewed against the pinned SPDX 2.3 specification before any blocking gate is proposed.",
            "The wrapper's local preflight can detect some cases before the external validator runs.",
            "This result does not establish SBOM completeness, vulnerability absence, license compatibility, or global compliance.",
        ],
    }
    if validator_version != EXPECTED_VALIDATOR_VERSION:
        base["status"] = "ERROR"
        base["error"] = f"Expected spdx-tools {EXPECTED_VALIDATOR_VERSION}, got {validator_version!r}"
        return base
    if shutil.which("pyspdxtools") is None:
        base["status"] = "ERROR"
        base["error"] = "pyspdxtools executable not found"
        return base
    try:
        original = json.loads(input_path.read_text(encoding="utf-8"))
        if not isinstance(original, dict) or not isinstance(original.get("packages"), list):
            raise ValueError("positive control must be an SPDX JSON object with a packages array")
        base["positiveInput"]["sha256"] = sha256_file(input_path)
        with tempfile.TemporaryDirectory(prefix="k7pl-spdx-negative-probes-") as temporary:
            directory = Path(temporary)
            base["positiveControl"] = _observe_case(
                "positive-control", "Known-positive generated document should validate.", original, directory
            )
            for name, hypothesis, mutate in PROBES:
                changed = copy.deepcopy(original)
                try:
                    mutate(changed)
                    base["cases"].append(_observe_case(name, hypothesis, changed, directory))
                except (IndexError, KeyError, TypeError, ValueError) as error:
                    base["cases"].append({"name": name, "probeHypothesis": hypothesis, "skipped": str(error)})
        base["status"] = "OBSERVED"
    except (OSError, UnicodeDecodeError, json.JSONDecodeError, ValueError) as error:
        base["status"] = "ERROR"
        base["error"] = str(error)
    return base


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True, help="generated positive SPDX 2.3 JSON input")
    parser.add_argument("--output", type=Path, required=True, help="write exploratory JSON observations")
    args = parser.parse_args()
    report = run_probes(args.input)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, sort_keys=True, ensure_ascii=False) + "\n", encoding="utf-8")
    summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary_path:
        with open(summary_path, "a", encoding="utf-8") as stream:
            stream.write("### Exploratory SPDX negative-corpus probes (non-blocking)\n")
            stream.write(f"- Status: {report.get('status')}; external-validator probes: {len(report.get('cases', []))}.\n")
            stream.write("- This step records observations only; no probe result gates CI.\n")
    print(
        "Non-blocking SPDX negative-corpus probes recorded: "
        f"status={report.get('status')}, cases={len(report.get('cases', []))}"
    )
    # The experiment is deliberately non-gating. Report ERROR in the artifact for review.
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
