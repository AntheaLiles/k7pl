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


def render_axiom_traceability(contract_path: Path) -> list[str]:
    """Render the expected axiom dependencies without misrepresenting them as a run result."""
    heading = [
        "## Traçabilité des dépendances aux axiomes",
        "",
        "Le tableau ci-dessous est le contrat versionné des dépendances attendues. Il indique les axiomes "
        "dont chaque déclaration est censée dépendre ; un ensemble vide impose que Lean indique explicitement "
        "qu’elle ne dépend d’aucun axiome. **Ce tableau ne prouve pas que le commit courant a passé l’audit.** "
        "Le rapport des dépendances effectivement observées est produit pour chaque exécution par "
        "[le workflow de sémantique formelle K7PL](../.github/workflows/k7pl-semantics.yaml), puis "
        "inclus dans l’artefact d’évidence de la chaîne formelle.",
        "",
    ]
    if not contract_path.is_file():
        return heading + [
            "Aucun contrat de dépendance aux axiomes n’existe à ce chemin ; aucune dépendance par déclaration "
            "n’est donc publiée pour cette arborescence.",
            "",
        ]
    try:
        contract = json.loads(contract_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as error:
        raise ValueError(f"invalid axiom dependency contract {contract_path}: {error}") from error
    declarations = contract.get("declarations")
    if not isinstance(declarations, list) or not declarations:
        raise ValueError(f"axiom dependency contract {contract_path} has no declarations")
    lines = heading + [
        "| Déclaration Lean | Axiomes attendus | Rôle / périmètre |",
        "|---|---|---|",
    ]
    seen = set()
    for item in declarations:
        name = item.get("name")
        axioms = item.get("axioms")
        role = item.get("role", "")
        if not isinstance(name, str) or not name or name in seen:
            raise ValueError(f"invalid or duplicate declaration in {contract_path}: {name!r}")
        if not isinstance(axioms, list) or any(not isinstance(axiom, str) for axiom in axioms):
            raise ValueError(f"invalid axiom set for {name} in {contract_path}")
        if not isinstance(role, str):
            raise ValueError(f"invalid role for {name} in {contract_path}")
        seen.add(name)
        displayed_axioms = ", ".join(f"`{axiom}`" for axiom in sorted(axioms)) if axioms else "∅ (aucun axiome attendu)"
        safe_role = role.replace("|", "\\|")
        lines.append(f"| `{name}` | {displayed_axioms} | {safe_role} |")
    lines.append("")
    lines.append("L’évidence d’une exécution n’est acceptée que si son rapport d’audit correspond exactement à ces ensembles ; un rapport absent n’est jamais interprété comme un ensemble vide.")
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
        "This document is generated by CI from repository facts and the CI verification gate.",
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
    lines.extend(render_axiom_traceability(Path("proofs/axiom-audit-contract.json")))
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
    )
    Path(a.output).write_text(text, encoding="utf-8")
    couverture.update_status(Path(a.output))


if __name__ == "__main__":
    main()
