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

from file_digest import sha256_file

EXPECTED_VALIDATOR_VERSION = "0.8.5"
ROOT = Path(__file__).resolve().parents[2]
WRAPPER = ROOT / "scripts" / "ci" / "validate_spdx.py"


def _workflow_context() -> dict[str, str | int | None]:
    """Return available GitHub Actions provenance without inferring missing run identity."""
    pull_request_head_sha: str | None = None
    event_path = os.environ.get("GITHUB_EVENT_PATH")
    if event_path:
        try:
            with open(event_path, encoding="utf-8") as stream:
                event = json.load(stream)
            if isinstance(event, dict):
                pull_request = event.get("pull_request")
                if isinstance(pull_request, dict):
                    head = pull_request.get("head")
                    if isinstance(head, dict) and isinstance(head.get("sha"), str):
                        pull_request_head_sha = head["sha"]
        except (OSError, UnicodeDecodeError, json.JSONDecodeError):
            # Keep the field explicitly null instead of treating malformed metadata as provenance.
            pass

    def integer_env(name: str) -> int | None:
        raw = os.environ.get(name)
        if raw is None:
            return None
        try:
            return int(raw)
        except ValueError:
            return None

    return {
        "runId": integer_env("GITHUB_RUN_ID"),
        "runAttempt": integer_env("GITHUB_RUN_ATTEMPT"),
        "checkedOutSha": os.environ.get("GITHUB_SHA"),
        "pullRequestHeadSha": pull_request_head_sha,
    }


def _tool_input_hashes() -> dict[str, str]:
    """Hash source/configuration files that determine the observed corpus result."""
    paths = {
        "negativeCorpusScriptSha256": Path(__file__).resolve(),
        "sbomGeneratorSha256": ROOT / "scripts" / "ci" / "lake_manifest_to_spdx.py",
        "spdxValidatorWrapperSha256": WRAPPER,
        "digestHelperSha256": ROOT / "scripts" / "ci" / "file_digest.py",
        "benchmarkScriptSha256": ROOT / "scripts" / "ci" / "benchmark_spdx_validator.py",
        "lakeManifestSha256": ROOT / "lake-manifest.json",
        "lakefileSha256": ROOT / "lakefile.lean",
        "leanToolchainSha256": ROOT / "lean-toolchain",
        "ciRequirementsLockSha256": ROOT / "scripts" / "requirements-ci.txt",
        "spdxValidatorRequirementsLockSha256": ROOT / "scripts" / "requirements-spdx-validator.txt",
    }
    return {name: sha256_file(path) for name, path in paths.items()}


def _missing_namespace(document: dict[str, Any]) -> None:
    document.pop("documentNamespace", None)


def _unsupported_spdx_version(document: dict[str, Any]) -> None:
    document["spdxVersion"] = "SPDX-9.9"


def _unknown_top_level_field(document: dict[str, Any]) -> None:
    # Probe whether the external validator rejects, ignores, or preserves an undeclared JSON field.
    # The observation is intentionally non-blocking and does not assume a particular parser policy.
    document["k7plProbeUnknownProperty"] = "probe-only"


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


def _missing_package_name(document: dict[str, Any]) -> None:
    document["packages"][0].pop("name", None)


def _null_package_name(document: dict[str, Any]) -> None:
    document["packages"][0]["name"] = None


def _missing_spdx_version(document: dict[str, Any]) -> None:
    document.pop("spdxVersion", None)


def _spdx_22_version(document: dict[str, Any]) -> None:
    document["spdxVersion"] = "SPDX-2.2"


def _missing_document_name(document: dict[str, Any]) -> None:
    document.pop("name", None)


def _empty_document_name(document: dict[str, Any]) -> None:
    document["name"] = ""


def _empty_package_spdxid(document: dict[str, Any]) -> None:
    document["packages"][0]["SPDXID"] = ""


def _empty_download_location(document: dict[str, Any]) -> None:
    document["packages"][0]["downloadLocation"] = ""


def _duplicate_relationship(document: dict[str, Any]) -> None:
    if not document.get("relationships"):
        raise ValueError("duplicate relationship probe requires at least one relationship")
    document["relationships"].append(copy.deepcopy(document["relationships"][0]))


def _inconsistent_relationship_source(document: dict[str, Any]) -> None:
    if not document.get("relationships"):
        raise ValueError("relationship-source probe requires at least one relationship")
    document["relationships"][0]["spdxElementId"] = "SPDXRef-Probe-Undeclared-Source"


def _unsupported_license_assertion(document: dict[str, Any]) -> None:
    # This is a semantic/provenance challenge, not a claim that MIT is actually false.
    # The test replaces an unknown assertion with a valid-looking but unsubstantiated value.
    document["packages"][0]["licenseDeclared"] = "MIT"


PROBES: tuple[tuple[str, str, Callable[[dict[str, Any]], None]], ...] = (
    ("missing-document-namespace", "Remove documentNamespace, a required document identity field.", _missing_namespace),
    ("missing-spdx-version", "Remove the declared SPDX specification version.", _missing_spdx_version),
    ("unsupported-spdx-version", "Use an unsupported SPDX version token.", _unsupported_spdx_version),
    ("unknown-top-level-field", "Add an undeclared top-level JSON property and observe the validator/parser policy.", _unknown_top_level_field),
    ("spdx-2.2-version-in-2.3-run", "Declare SPDX-2.2 while the invocation explicitly selects SPDX-2.3.", _spdx_22_version),
    ("missing-document-name", "Remove the document name field.", _missing_document_name),
    ("empty-document-name", "Set the document name to an empty string.", _empty_document_name),
    ("missing-package-name", "Remove a package name; compare direct-validator and wrapper diagnostics.", _missing_package_name),
    ("null-package-name", "Use null instead of a package name string.", _null_package_name),
    ("missing-package-download-location", "Remove a package downloadLocation field.", _missing_download_location),
    ("empty-package-download-location", "Set downloadLocation to an empty string.", _empty_download_location),
    ("invalid-license-expression", "Use a malformed declared-license expression.", _invalid_license_expression),
    ("unsupported-license-assertion", "Replace NOASSERTION with MIT without adding evidence; syntactic validation cannot prove this factual assertion.", _unsupported_license_assertion),
    ("dangling-relationship-reference", "Point a relationship at an undeclared SPDX identifier.", _dangling_relationship),
    ("inconsistent-relationship-source", "Set a relationship source to an undeclared identifier.", _inconsistent_relationship_source),
    ("duplicate-package-spdxid", "Duplicate package identifiers.", _duplicate_package_identifier),
    ("duplicate-relationship", "Duplicate a relationship object / target.", _duplicate_relationship),
    ("empty-package-name-upstream-885", "Known upstream gap tracked in spdx/tools-python issue #885; wrapper preflight should intercept it.", _empty_package_name),
)


def _invoke(command: list[str], env: dict[str, str] | None = None) -> dict[str, Any]:
    try:
        result = subprocess.run(command, check=False, capture_output=True, text=True, env=env)
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


def _report_wrapper_result(wrapper: dict[str, Any]) -> dict[str, Any]:
    wrapper_report: dict[str, Any] | None = None
    try:
        wrapper_report = json.loads(wrapper["stdout"])
    except json.JSONDecodeError:
        pass
    return {
        "returnCode": wrapper["returnCode"],
        "executionError": wrapper["executionError"],
        "status": wrapper_report.get("status") if wrapper_report else None,
        "diagnosticRuleIds": [
            item.get("ruleId") for item in (wrapper_report or {}).get("diagnostics", [])
        ],
        "diagnosticMessages": [
            item.get("message") for item in (wrapper_report or {}).get("diagnostics", [])
        ],
    }


def _observe_raw_case(name: str, hypothesis: str, raw_text: str, directory: Path) -> dict[str, Any]:
    input_path = directory / f"{name}.spdx.json"
    input_path.write_text(raw_text, encoding="utf-8")
    external = _invoke(["pyspdxtools", "--infile", str(input_path), "--version", "SPDX-2.3"])
    wrapper = _invoke([sys.executable, str(WRAPPER), str(input_path)])
    return {
        "name": name,
        "probeHypothesis": hypothesis,
        "inputSha256": sha256_file(input_path),
        "externalValidator": external,
        "wrapper": _report_wrapper_result(wrapper),
    }


def _observe_tool_error(input_path: Path, directory: Path) -> dict[str, Any]:
    missing_command = _invoke([
        str(directory / "definitely-no-such-spdx-validator"),
        "--infile", str(input_path), "--version", "SPDX-2.3",
    ])
    isolated_path = directory / "empty-path"
    isolated_path.mkdir()
    env = os.environ.copy()
    env["PATH"] = str(isolated_path)
    wrapper = _invoke([sys.executable, str(WRAPPER), str(input_path)], env=env)
    return {
        "directCommandMissing": missing_command,
        "wrapperWithValidatorAbsentFromPath": _report_wrapper_result(wrapper),
        "interpretation": (
            "These controls exercise command-execution/error handling; they do not simulate every "
            "possible crash, timeout, corrupt database, or internal error in spdx-tools."
        ),
    }


def _coverage_summary(base: dict[str, Any]) -> dict[str, Any]:
    observations = [base.get("positiveControl")] + base.get("cases", []) + base.get("rawCases", [])
    observations = [item for item in observations if isinstance(item, dict)]
    wrapper_statuses: dict[str, int] = {}
    rule_ids: set[str] = set()
    external_codes: dict[str, int] = {}
    for item in observations:
        wrapper = item.get("wrapper", {})
        status = wrapper.get("status") or "NO-JSON-REPORT"
        wrapper_statuses[status] = wrapper_statuses.get(status, 0) + 1
        rule_ids.update(rule_id for rule_id in wrapper.get("diagnosticRuleIds", []) if rule_id)
        external = item.get("externalValidator", {})
        code = str(external.get("returnCode", "none"))
        external_codes[code] = external_codes.get(code, 0) + 1
    return {
        "mutationCases": len(base.get("cases", [])),
        "rawInputCases": len(base.get("rawCases", [])),
        "wrapperStatusCounts": wrapper_statuses,
        "wrapperDiagnosticRuleIdsObserved": sorted(rule_ids),
        "externalValidatorReturnCodeCounts": external_codes,
        "notASchemaCoverageClaim": True,
    }


def run_probes(input_path: Path) -> dict[str, Any]:
    try:
        validator_version = version("spdx-tools")
    except PackageNotFoundError:
        validator_version = None
    base: dict[str, Any] = {
        "schemaVersion": "k7pl.spdx-negative-probe/v2",
        "workflow": _workflow_context(),
        "toolInputs": {},
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
        "rawCases": [],
        "toolErrorControls": None,
        "limitations": [
            "This is an exploratory mutation corpus, not comprehensive SPDX 2.3 schema coverage.",
            "A zero exit code is an observation, not by itself a conclusion of standards conformance.",
            "Probe hypotheses must be reviewed against the pinned SPDX 2.3 specification before any blocking gate is proposed.",
            "The wrapper's local preflight can detect some cases before the external validator runs.",
            "This result does not establish SBOM completeness, vulnerability absence, license compatibility, or global compliance.",
        ],
    }
    try:
        base["toolInputs"] = _tool_input_hashes()
    except OSError as error:
        base["status"] = "ERROR"
        base["error"] = f"Unable to fingerprint experiment inputs: {error}"
        return base
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
            base["rawCases"].append(_observe_raw_case(
                "malformed-json", "Input is not syntactically valid JSON.", '{"packages": [', directory
            ))
            base["rawCases"].append(_observe_raw_case(
                "json-root-array", "JSON is syntactically valid but the document root is not an object.", '[]', directory
            ))
            base["toolErrorControls"] = _observe_tool_error(input_path, directory)
        base["status"] = "OBSERVED"
        base["diagnosticCoverageSummary"] = _coverage_summary(base)
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
            stream.write(f"- Status: {report.get('status')}; structured mutations: {len(report.get('cases', []))}; raw-input cases: {len(report.get('rawCases', []))}.\n")
            stream.write("- Tool-error controls and the observed wrapper diagnostic IDs are saved in the JSON artefact.\n")
            stream.write("- This step records observations only; no probe result gates CI and this is not schema coverage.\n")
    print(
        "Non-blocking SPDX negative-corpus probes recorded: "
        f"status={report.get('status')}, cases={len(report.get('cases', []))}, "
        f"raw_cases={len(report.get('rawCases', []))}"
    )
    # The experiment is deliberately non-gating. Report ERROR in the artifact for review.
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
