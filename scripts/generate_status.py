# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Generate `docs/STATUS.md` from repository facts and the results of the CI jobs.

The `status` job of ci.yaml runs it on main, from the repository root:

    python3 scripts/generate_status.py --verification "$K7PL_VERIFICATION"

The results of the other jobs come from the options or from the `K7PL_*_RESULT` environment
variables. The coverage block of `scripts/controles/couverture.py` is then refreshed in the
written file.
"""

import argparse
import datetime
import hashlib
import json
import os
import re
import stat
import subprocess
from pathlib import Path

from controles import couverture


def sh(*args):
    return subprocess.check_output(args, text=True).strip()


def count_lean_files(directory: Path) -> int:
    """Number of regular files named `*.lean` under `directory`, at any depth.

    Same count as `find <directory> -type f -name '*.lean' | wc -l`: hidden directories are
    searched, symbolic links are neither counted nor followed (the directory itself included),
    and a missing directory counts zero.
    """
    if os.path.islink(directory):
        return 0
    count = 0
    for current, _, names in os.walk(directory):
        for name in names:
            if name.endswith(".lean") and stat.S_ISREG(os.lstat(os.path.join(current, name)).st_mode):
                count += 1
    return count


def implementation_version(lakefile: str) -> str:
    """The `version := v!"…"` of the package in `lakefile.lean`, or `unknown`."""
    match = re.search(r'version\s*:=\s*v!"([^"]+)"', lakefile)
    return match.group(1) if match else "unknown"


def generated_date(commit_date: str) -> str:
    """The calendar date (`YYYY-MM-DD`) of an ISO 8601 commit date, in its own offset."""
    return datetime.datetime.fromisoformat(commit_date.replace("Z", "+00:00")).date().isoformat()


def render_axiom_traceability(
    contract_path: Path,
    report_path: Path | None = None,
    expected_commit: str | None = None,
) -> list[str]:
    """Render expected axiom sets and, only when validated, observed run evidence."""
    heading = [
        "## Traçabilité des dépendances aux axiomes",
        "",
        "Le tableau ci-dessous est le contrat versionné des dépendances attendues. Un ensemble vide impose que Lean indique explicitement qu'une déclaration ne dépend d'aucun axiome ; un rapport absent n'est jamais interprété comme un ensemble vide.",
        "",
    ]
    if not contract_path.is_file():
        lines = heading + [
            "Aucun contrat de dépendance aux axiomes n'existe à ce chemin ; aucune dépendance par déclaration n'est publiée pour cette arborescence.",
            "",
            "**Axiom audit evidence for commit:** " + (expected_commit or "unknown"),
            "**Axiom audit status:** NOT AVAILABLE",
            "",
        ]
        return lines

    try:
        contract_bytes = contract_path.read_bytes()
        contract = json.loads(contract_bytes)
    except (OSError, json.JSONDecodeError) as error:
        raise ValueError(f"cannot read axiom dependency contract {contract_path}: {error}") from error
    declarations = contract.get("declarations")
    if not isinstance(declarations, list) or not declarations:
        raise ValueError(f"axiom dependency contract {contract_path} has no declarations")

    expected_by_name: dict[str, dict] = {}
    lines = heading + [
        "| Déclaration Lean | Axiomes attendus | Rôle / périmètre |",
        "|---|---|---|",
    ]
    for item in declarations:
        if not isinstance(item, dict):
            raise ValueError(f"invalid declaration entry in {contract_path}: {item!r}")
        name = item.get("name")
        axioms = item.get("axioms")
        role = item.get("role", "")
        if not isinstance(name, str) or not name or name in expected_by_name:
            raise ValueError(f"invalid or duplicate declaration in {contract_path}: {name!r}")
        if not isinstance(axioms, list) or any(not isinstance(axiom, str) for axiom in axioms):
            raise ValueError(f"invalid axiom set for {name} in {contract_path}")
        if len(set(axioms)) != len(axioms):
            raise ValueError(f"duplicate axiom in expected set for {name} in {contract_path}")
        if not isinstance(role, str):
            raise ValueError(f"invalid role for {name} in {contract_path}")
        expected_by_name[name] = item
        displayed_axioms = ", ".join(f"`{axiom}`" for axiom in sorted(axioms)) if axioms else "∅ (aucun axiome attendu)"
        safe_role = role.replace("|", "\\|")
        lines.append(f"| `{name}` | {displayed_axioms} | {safe_role} |")
    lines.append("")

    lines.extend([
        "## Audit des axiomes du commit généré",
        "",
        "**Axiom audit evidence for commit:** " + (expected_commit or "unknown"),
    ])
    if report_path is None or not report_path.is_file():
        lines.extend([
            "**Axiom audit status:** NOT AVAILABLE",
            "",
            "Aucun rapport d'audit réussi correspondant à ce commit n'a été récupéré. Les ensembles attendus ci-dessus ne constituent pas une preuve d'exécution ; aucun statut de preuve actuel n'est déduit.",
            "",
        ])
        return lines

    try:
        report = json.loads(report_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise ValueError(f"cannot read axiom audit report {report_path}: {error}") from error

    contract_sha = hashlib.sha256(contract_bytes).hexdigest()
    if report.get("kind") != "lean-axiom-dependency-audit" or report.get("status") != "passed":
        raise ValueError("axiom audit report is not a successful lean-axiom-dependency-audit report")
    if report.get("contractSha256") != contract_sha:
        raise ValueError("axiom audit report contract hash does not match the checked-in contract")
    if expected_commit and report.get("sourceCommit") != expected_commit:
        raise ValueError(
            f"axiom audit report is for commit {report.get('sourceCommit')!r}, expected {expected_commit!r}"
        )
    run_id = report.get("workflowRunId")
    lean_version = report.get("leanVersion")
    if not isinstance(run_id, str) or not run_id or run_id == "unknown":
        raise ValueError("axiom audit report has no workflow run identifier")
    if not isinstance(lean_version, str) or not lean_version or lean_version == "unknown":
        raise ValueError("axiom audit report has no Lean version")
    observed_entries = report.get("declarations")
    if not isinstance(observed_entries, list) or len(observed_entries) != len(expected_by_name):
        raise ValueError("axiom audit report declaration count does not match the checked-in contract")

    observed_by_name = {}
    for item in observed_entries:
        if not isinstance(item, dict) or not isinstance(item.get("name"), str):
            raise ValueError("invalid declaration entry in axiom audit report")
        name = item["name"]
        if name in observed_by_name:
            raise ValueError(f"duplicate declaration in axiom audit report: {name}")
        observed_by_name[name] = item
    if set(observed_by_name) != set(expected_by_name):
        raise ValueError("axiom audit report declarations do not match the checked-in contract")

    lines.extend([
        "**Axiom audit status:** PASS",
        "**Axiom audit run ID:** " + run_id,
        "**Axiom audit run:** [ouvrir l'exécution CI](https://github.com/AntheaLiles/k7pl/actions/runs/" + run_id + ")",
        "**Axiom audit Lean version:** " + lean_version,
        "**Axiom audit contract SHA-256:** " + contract_sha,
        "",
        "| Déclaration Lean | Axiomes observés | Concordance exacte |",
        "|---|---|---|",
    ])
    for name, expected in expected_by_name.items():
        item = observed_by_name[name]
        expected_axioms = sorted(expected["axioms"])
        observed_axioms = item.get("observedAxioms")
        if (
            sorted(observed_axioms) if isinstance(observed_axioms, list) and
            all(isinstance(axiom, str) for axiom in observed_axioms) else None
        ) != expected_axioms:
            raise ValueError(f"observed axiom set for {name} does not match the contract")
        if item.get("expectedAxioms") != expected_axioms or item.get("matchesContract") is not True:
            raise ValueError(f"axiom audit report does not attest an exact contract match for {name}")
        displayed_observed = ", ".join(f"`{axiom}`" for axiom in observed_axioms) if observed_axioms else "∅ (aucun axiome)"
        lines.append(f"| `{name}` | {displayed_observed} | PASS |")
    lines.append("")
    lines.append("Le statut PASS correspond au seul commit indiqué ci-dessus et aux déclarations du contrat versionné ; il ne prouve ni leur correspondance normative complète ni la sûreté générale de K7PL.")
    lines.append("")
    return lines


def render_status(
    *,
    commit: str,
    date: str,
    version: str,
    toolchain: str,
    verification: str,
    ci_results: dict[str, str],
    counts: dict[str, int],
    axiom_report_path: Path | None = None,
) -> str:
    """The generated part of `docs/STATUS.md`, before its coverage block is refreshed."""
    lines = [
        "<!-- GENERATED CONTENT START -->",
        "<!--",
        "GENERATED FILE: do not edit manually.",
        "Source: scripts/generate_status.py",
        "-->",
        "",
        "# K7PL Status",
        "",
        "This document is generated by CI from repository facts, the checked-in axiom dependency contract, and the CI verification gate.",
        "",
        "**Generated for commit:** " + commit,
        "**Commit date:** " + date,
        "**Generated date:** " + generated_date(date),
        "**Implementation version:** " + version,
        "**Lean toolchain:** " + toolchain,
        "",
        "## CI verification",
        "",
        "| Fact | Status |",
        "|---|---|",
        "| Verification gate (CI OK aggregate) | " + verification + " |",
        "| Impact analysis | " + ci_results["Impact analysis"] + " |",
        "| Verification aggregate (impact scope) | " + ci_results["Verification aggregate"] + " |",
        "| REUSE | " + ci_results["REUSE"] + " |",
        "| Conventional Commits | " + ci_results["Conventional Commits"] + " |",
        "| Security | " + ci_results["Security"] + " |",
        "",
        "CI success means that the configured checks ran for the applicable impact scope; it does not establish correctness of every scientific claim.",
        "",
        "## Repository facts",
        "",
        "| Fact | Value |",
        "|---|---:|",
        "| Lean source files under src/ | " + str(counts["src"]) + " |",
        "| Lean test files under tests/ | " + str(counts["tests"]) + " |",
        "| Lean specification modules under spec/ | " + str(counts["spec"]) + " |",
        "",
        "These counts are generated from the current Git tree and are not estimates of formalisation completeness.",
        "",
    ]
    lines.extend(render_axiom_traceability(
        Path("proofs/axiom-audit-contract.json"),
        report_path=axiom_report_path,
        expected_commit=commit,
    ))
    lines.extend([
        "## Scientific status",
        "",
        "See [ASSURANCE.md](ASSURANCE.md) for scientific status. CI success does not imply specification coherence, complete specification/formalisation correspondence, or implementation conformance.",
        "",
        "## Generation",
        "",
        "The authoritative generator is [scripts/generate_status.py](../scripts/generate_status.py). CI is responsible for updating this file; manual edits are not part of the project workflow."
    ])
    return "\n".join(lines) + "\n"


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--output", default="docs/STATUS.md")
    p.add_argument("--verification", default=os.environ.get("K7PL_VERIFICATION", "unknown"))
    p.add_argument("--impact-result", default=os.environ.get("K7PL_IMPACT_RESULT", "unknown"))
    p.add_argument("--verify-result", default=os.environ.get("K7PL_VERIFY_RESULT", "unknown"))
    p.add_argument("--reuse-result", default=os.environ.get("K7PL_REUSE_RESULT", "unknown"))
    p.add_argument("--commitlint-result", default=os.environ.get("K7PL_COMMITLINT_RESULT", "unknown"))
    p.add_argument("--security-result", default=os.environ.get("K7PL_SECURITY_RESULT", "unknown"))
    a = p.parse_args()
    text = render_status(
        commit=sh("git", "rev-parse", "HEAD"),
        date=sh("git", "show", "-s", "--format=%cI", "HEAD"),
        version=implementation_version(Path("lakefile.lean").read_text()),
        toolchain=Path("lean-toolchain").read_text().strip(),
        verification=a.verification.upper(),
        ci_results={
            "Impact analysis": a.impact_result.upper(),
            "Verification aggregate": a.verify_result.upper(),
            "REUSE": a.reuse_result.upper(),
            "Conventional Commits": a.commitlint_result.upper(),
            "Security": a.security_result.upper(),
        },
        counts={name: count_lean_files(Path(name)) for name in ("src", "tests", "spec")},
        axiom_report_path=(
            Path(os.environ["K7PL_AXIOM_AUDIT_REPORT"])
            if os.environ.get("K7PL_AXIOM_AUDIT_REPORT")
            else None
        ),
    )
    Path(a.output).write_text(text, encoding="utf-8")
    couverture.update_status(Path(a.output))


if __name__ == "__main__":
    main()
