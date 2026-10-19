#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Check the Lean SBOM audit report, replay its negative CLI cases and write the CI evidence.

Run by the `impl` job of `.github/workflows/verify.yaml`, after `lake_manifest_to_spdx.py` has
generated the scoped SPDX inventory and `lake exe sbomAudit` has audited it against
`lake-manifest.json`. The script:

1. requires the audit report to be a PASS of `k7pl-sbom-audit` with no diagnostic, on the
   expected source artifacts;
2. runs `lake exe sbomAudit` on four negative inputs and requires, for each, the expected exit
   status, report status and diagnostic rule(s):

   - a malformed manifest (`{`): ERROR/2, `INPUT-JSON-MANIFEST`;
   - the generated SBOM with its first package revision altered: FAIL/1,
     `SBOM-INVENTORY-MISMATCH`;
   - an empty manifest and an empty SPDX inventory: FAIL/1, `SBOM-EMPTY-INVENTORY`;
   - a package named U+00A0 (a Unicode blank) in both files: FAIL/1,
     `SBOM-MANIFEST-EMPTY-IDENTITY` and `SBOM-PACKAGE-EMPTY-IDENTITY`;

3. writes the evidence JSON (`k7pl.ci-evidence/v1`) and a summary for the job.

It runs only inside GitHub Actions: `GITHUB_RUN_ID`, `GITHUB_RUN_ATTEMPT`, `GITHUB_SHA`,
`GITHUB_WORKFLOW` and `GITHUB_STEP_SUMMARY` are required; `GITHUB_EVENT_PATH` is optional.

The evidence records what this job checked. It is not a provenance attestation and it does not
claim that the inventory is complete (see `lake_manifest_to_spdx.py`).

Exit status: 0 when every check passes, 1 otherwise.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import subprocess
import sys
from collections.abc import Callable, Mapping
from pathlib import Path
from typing import Any

from check_manifest import clean
from lake_manifest_to_spdx import TOOL_NAME as SBOM_TOOL_NAME
from lake_manifest_to_spdx import TOOL_VERSION as SBOM_TOOL_VERSION

ROOT = Path(__file__).resolve().parents[2]
REPORT_SCHEMA = "k7pl.compliance-report/v1"
AUDIT_TOOL = "k7pl-sbom-audit"
EVIDENCE_SCHEMA = "k7pl.ci-evidence/v1"
MANIFEST_ARTIFACT = "lake-manifest.json"
SBOM_ARTIFACT = "k7pl-lake.spdx.json"
# Files hashed into the evidence, besides the manifest and the SBOM given on the command line.
# The order of `inputs` is part of the evidence format: append, do not reorder.
HASHED_SOURCES = (
    "lakefile.lean",
    "lean-toolchain",
    "scripts/ci/lake_manifest_to_spdx.py",
    "tools/Compliance/SbomAudit.lean",
    "tools/Compliance/SbomAuditMain.lean",
)

# (manifest path, SBOM path) -> the finished `lake exe sbomAudit` process.
AuditRunner = Callable[[str, str], subprocess.CompletedProcess]


class EvidenceError(Exception):
    """A check failed: the evidence must not be written."""


def lake_sbom_audit(manifest: str, sbom: str) -> subprocess.CompletedProcess:
    """Run the Lean audit executable; its exit status is part of what is checked."""
    return subprocess.run(
        ["lake", "exe", "sbomAudit", manifest, sbom],
        check=False,
        capture_output=True,
        text=True,
    )


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with open(path, "rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def require(condition: bool, message: str) -> None:
    if not condition:
        raise EvidenceError(message)


def check_report(report: object, sbom_name: str = SBOM_ARTIFACT) -> dict[str, Any]:
    """The audit report of the valid inputs: a PASS with no diagnostic, on the expected files."""
    require(isinstance(report, dict), "the audit report is not a JSON object")
    assert isinstance(report, dict)
    require(report.get("schemaVersion") == REPORT_SCHEMA, f"unexpected report schema: {report.get('schemaVersion')!r}")
    require(report.get("tool") == AUDIT_TOOL, f"unexpected audit tool: {report.get('tool')!r}")
    require(isinstance(report.get("toolVersion"), str) and report["toolVersion"] != "",
            f"the report has no tool version: {report.get('toolVersion')!r}")
    require(report.get("status") == "PASS", f"audit status is {report.get('status')!r}, not PASS")
    require(report.get("diagnostics") == [], f"the audit reported diagnostics: {report.get('diagnostics')!r}")
    sources = report.get("sourceArtifacts")
    require(isinstance(sources, list) and len(sources) >= 2 and all(isinstance(s, str) for s in sources[:2]),
            f"unexpected source artifacts: {sources!r}")
    require(sources[0] == MANIFEST_ARTIFACT, f"the audit read {sources[0]!r}, not {MANIFEST_ARTIFACT}")
    require(sources[1].endswith("/" + sbom_name), f"the audit read {sources[1]!r}, not the generated {sbom_name}")
    return report


def expect_audit_failure(result: subprocess.CompletedProcess, case: str, exit_code: int,
                         status: str, rules: tuple[str, ...]) -> dict[str, Any]:
    """One negative case: the expected exit status, report status and every expected rule."""
    require(result.returncode == exit_code,
            f"{case}: exit status {result.returncode}, expected {exit_code} "
            f"(stdout: {result.stdout!r}, stderr: {result.stderr!r})")
    try:
        report = json.loads(result.stdout)
    except json.JSONDecodeError as error:
        raise EvidenceError(f"{case}: the audit did not print a JSON report: {error}") from error
    require(isinstance(report, dict) and report.get("status") == status,
            f"{case}: report status is not {status}: {report!r}")
    diagnostics = report.get("diagnostics")
    require(isinstance(diagnostics, list)
            and all(isinstance(d, dict) and isinstance(d.get("ruleId"), str) for d in diagnostics),
            f"{case}: malformed diagnostics: {report!r}")
    found = {d["ruleId"] for d in diagnostics}
    missing = [rule for rule in rules if rule not in found]
    require(not missing, f"{case}: no {', '.join(missing)} diagnostic: {report!r}")
    return {"case": case, "exitCode": result.returncode, "status": report["status"]}


def mutate_first_revision(sbom: dict[str, Any]) -> dict[str, Any]:
    """The SBOM with the first character of its first package revision changed (f <-> e)."""
    mutated = json.loads(json.dumps(sbom))
    original = mutated["packages"][0]["versionInfo"]
    replacement = "e" if original[0] == "f" else "f"
    mutated["packages"][0]["versionInfo"] = replacement + original[1:]
    return mutated


# An empty pair is structurally parseable but not a valid K7PL dependency inventory.
EMPTY_MANIFEST_TEXT = '{"name":"k7pl","packages":[]}'
EMPTY_SBOM = {"spdxVersion": "SPDX-2.3", "SPDXID": "SPDXRef-DOCUMENT", "packages": [], "relationships": []}

# The Lean model and CLI must reject blank package names using the same whitespace set as the
# Python preflight wrapper (including Unicode separators such as U+00A0).
BLANK_NAME = "\u00a0"
BLANK_REVISION = "a" * 40
BLANK_URL = "https://github.com/example/alpha"
BLANK_MANIFEST = {"name": "k7pl", "packages": [{"name": BLANK_NAME, "url": BLANK_URL, "rev": BLANK_REVISION}]}
BLANK_SBOM = {
    "spdxVersion": "SPDX-2.3",
    "SPDXID": "SPDXRef-DOCUMENT",
    "packages": [{
        "name": BLANK_NAME,
        "SPDXID": "SPDXRef-Package-alpha",
        "versionInfo": BLANK_REVISION,
        "downloadLocation": BLANK_URL,
        "licenseDeclared": "NOASSERTION",
        "licenseConcluded": "NOASSERTION",
        "copyrightText": "NOASSERTION",
    }],
    "relationships": [{
        "spdxElementId": "SPDXRef-DOCUMENT",
        "relationshipType": "DESCRIBES",
        "relatedSpdxElement": "SPDXRef-Package-alpha",
    }],
}


def run_negative_cases(manifest_path: Path, sbom_path: Path, scratch_dir: Path,
                       run_audit: AuditRunner = lake_sbom_audit) -> list[dict[str, Any]]:
    """Exercise the executable's exit-code/report contract end to end on four bad inputs."""
    cases = []
    malformed_manifest = scratch_dir / "malformed-manifest.json"
    malformed_manifest.write_text("{", encoding="utf-8")
    cases.append(expect_audit_failure(
        run_audit(str(malformed_manifest), str(sbom_path)),
        "malformed manifest JSON", 2, "ERROR", ("INPUT-JSON-MANIFEST",),
    ))

    with open(sbom_path, encoding="utf-8") as stream:
        sbom = json.load(stream)
    mismatch_path = scratch_dir / "mismatched.spdx.json"
    mismatch_path.write_text(json.dumps(mutate_first_revision(sbom)), encoding="utf-8")
    cases.append(expect_audit_failure(
        run_audit(str(manifest_path), str(mismatch_path)),
        "mutated package revision", 1, "FAIL", ("SBOM-INVENTORY-MISMATCH",),
    ))

    empty_manifest = scratch_dir / "empty-manifest.json"
    empty_manifest.write_text(EMPTY_MANIFEST_TEXT, encoding="utf-8")
    empty_sbom = scratch_dir / "empty-inventory.spdx.json"
    empty_sbom.write_text(json.dumps(EMPTY_SBOM), encoding="utf-8")
    cases.append(expect_audit_failure(
        run_audit(str(empty_manifest), str(empty_sbom)),
        "empty manifest and SPDX inventory", 1, "FAIL", ("SBOM-EMPTY-INVENTORY",),
    ))

    blank_manifest = scratch_dir / "blank-name-manifest.json"
    blank_manifest.write_text(json.dumps(BLANK_MANIFEST), encoding="utf-8")
    blank_sbom = scratch_dir / "blank-name.spdx.json"
    blank_sbom.write_text(json.dumps(BLANK_SBOM), encoding="utf-8")
    cases.append(expect_audit_failure(
        run_audit(str(blank_manifest), str(blank_sbom)),
        "Unicode blank package name (U+00A0)", 1, "FAIL",
        ("SBOM-MANIFEST-EMPTY-IDENTITY", "SBOM-PACKAGE-EMPTY-IDENTITY"),
    ))
    return cases


def pull_request_head(env: Mapping[str, str]) -> str | None:
    event_path = env.get("GITHUB_EVENT_PATH")
    if not event_path:
        return None
    with open(event_path, encoding="utf-8") as stream:
        event = json.load(stream)
    return (event.get("pull_request") or {}).get("head", {}).get("sha")


def required_env(env: Mapping[str, str], name: str) -> str:
    value = env.get(name)
    if not value:
        raise EvidenceError(f"{name} is not set: this script runs inside GitHub Actions")
    return value


def build_evidence(report: dict[str, Any], negative_cases: list[dict[str, Any]], manifest_path: Path,
                   sbom_path: Path, root: Path, env: Mapping[str, str]) -> dict[str, Any]:
    inputs = [{"artifact": MANIFEST_ARTIFACT, "sha256": sha256_file(manifest_path)}]
    inputs += [{"artifact": name, "sha256": sha256_file(root / name)} for name in HASHED_SOURCES]
    inputs.append({"artifact": SBOM_ARTIFACT, "sha256": sha256_file(sbom_path)})
    try:
        run_id = int(required_env(env, "GITHUB_RUN_ID"))
        run_attempt = int(required_env(env, "GITHUB_RUN_ATTEMPT"))
    except ValueError as error:
        raise EvidenceError(f"GITHUB_RUN_ID or GITHUB_RUN_ATTEMPT is not an integer: {error}") from error
    return {
        "schemaVersion": EVIDENCE_SCHEMA,
        "workflow": {
            # The calling workflow (CI, Full Verification, Release): verify.yaml is reusable.
            "name": required_env(env, "GITHUB_WORKFLOW"),
            "runId": run_id,
            "runAttempt": run_attempt,
            "checkedOutSha": required_env(env, "GITHUB_SHA"),
            "pullRequestHeadSha": pull_request_head(env),
        },
        "toolchain": {
            "lean": (root / "lean-toolchain").read_text(encoding="utf-8").strip(),
            "sbomGenerator": f"{SBOM_TOOL_NAME}@{SBOM_TOOL_VERSION}",
            "leanAudit": f"{report['tool']}@{report['toolVersion']}",
        },
        "inputs": inputs,
        "audit": report,
        "negativeCases": negative_cases,
    }


def input_sha256(evidence: dict[str, Any], artifact: str) -> str:
    """The hash recorded for one input, looked up by name rather than by position."""
    matches = [item["sha256"] for item in evidence["inputs"] if item["artifact"] == artifact]
    require(len(matches) == 1, f"expected one input named {artifact}, found {len(matches)}")
    return matches[0]


def summary_lines(evidence: dict[str, Any], component_count: int) -> list[str]:
    cases = "; ".join(
        f"{case['case']} → {case['status']}/{case['exitCode']}" for case in evidence["negativeCases"]
    )
    return [
        "### Scoped SPDX consistency audit",
        f"- Valid input: {evidence['audit']['status']}; {component_count} manifest components checked.",
        f"- Negative integration cases: {cases}.",
        f"- Lean toolchain: `{evidence['toolchain']['lean']}`",
        f"- Manifest SHA-256: `{input_sha256(evidence, MANIFEST_ARTIFACT)}`",
        f"- Generated SPDX SHA-256: `{input_sha256(evidence, SBOM_ARTIFACT)}`",
    ]


def manifest_component_count(manifest_path: Path) -> int:
    with open(manifest_path, encoding="utf-8") as stream:
        manifest = json.load(stream)
    packages = manifest.get("packages") if isinstance(manifest, dict) else None
    require(isinstance(packages, list) and len(packages) > 0, f"{manifest_path} has no package list")
    return len(packages)


def produce(args: argparse.Namespace, env: Mapping[str, str], run_audit: AuditRunner) -> dict[str, Any]:
    scratch = args.scratch_dir or env.get("RUNNER_TEMP")
    if not scratch:
        raise EvidenceError("RUNNER_TEMP is not set and --scratch-dir was not given")
    summary_path = required_env(env, "GITHUB_STEP_SUMMARY")
    with open(args.report, encoding="utf-8") as stream:
        report = check_report(json.load(stream))
    negative_cases = run_negative_cases(args.manifest, args.sbom, Path(scratch), run_audit)
    evidence = build_evidence(report, negative_cases, args.manifest, args.sbom, args.root, env)
    with open(args.output, "w", encoding="utf-8") as stream:
        json.dump(evidence, stream, indent=2, sort_keys=True)
        stream.write("\n")
    lines = summary_lines(evidence, manifest_component_count(args.manifest))
    with open(summary_path, "a", encoding="utf-8") as summary:
        summary.write("\n".join(lines) + "\n")
    return evidence


def main(argv: list[str] | None = None, env: Mapping[str, str] | None = None,
         run_audit: AuditRunner = lake_sbom_audit) -> int:
    """Command line entry point; `env` and `run_audit` are replaced by doubles in the tests."""
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--report", type=Path, required=True, help="sbomAudit report of the valid inputs")
    parser.add_argument("--manifest", type=Path, required=True, help="the audited lake-manifest.json")
    parser.add_argument("--sbom", type=Path, required=True, help="the audited SPDX document")
    parser.add_argument("--output", type=Path, required=True, help="where to write the evidence JSON")
    parser.add_argument("--root", type=Path, default=ROOT, help="repository root (default: this checkout)")
    parser.add_argument("--scratch-dir", type=Path, help="directory for the negative inputs (default: RUNNER_TEMP)")
    args = parser.parse_args(argv)
    environment = os.environ if env is None else env
    annotate = environment.get("GITHUB_ACTIONS") == "true"
    try:
        produce(args, environment, run_audit)
    except (EvidenceError, OSError, ValueError, KeyError, IndexError, TypeError) as error:
        message = clean(f"{type(error).__name__}: {error}" if not isinstance(error, EvidenceError) else str(error))
        print(f"::error::{message}" if annotate else f"error: {message}", file=sys.stderr)
        return 1
    print("Lean scoped SPDX consistency audit and negative CLI cases: PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
