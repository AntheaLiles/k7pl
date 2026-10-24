#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Normalize and enforce the KLean-generated proof project's #print axioms evidence.

The expected dependency set for every tracked declaration comes from
proofs/axiom-audit-contract.json. An empty dependency set is recorded as [] rather
than treated as a missing audit. Missing, conflicting, changed, or forbidden axiom
reports are hard failures.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
from pathlib import Path

ANSI_ESCAPE = re.compile(r"\x1B\[[0-?]*[ -/]*[@-~]")
DEPENDS = re.compile(r"'(?P<name>[^']+)' depends on axioms:\s*\[(?P<axioms>[^]]*)\]")
NO_AXIOMS = re.compile(r"'(?P<name>[^']+)' does not depend on any axioms")


PROJECT_ALLOWED_STANDARD_AXIOMS = frozenset({"propext", "Classical.choice", "Quot.sound"})
PROJECT_REQUIRED_FORBIDDEN_AXIOMS = frozenset({"sorryAx", "Lean.ofReduceBool"})


class AuditError(ValueError):
    """The build log does not satisfy the declared axiom-audit contract."""


def parse_report(text: str, contract: dict, *, source_commit: str, workflow_run_id: str,
                 lean_version: str) -> dict:
    """Parse actual Lean reports and compare every tracked declaration with its contract."""
    clean = ANSI_ESCAPE.sub("", text)
    if "sorryAx" in clean:
        raise AuditError("forbidden sorryAx marker found in the Lean build log")

    policy = contract.get("policy", {})
    forbidden = set(policy.get("forbiddenAxioms", []))
    allowed = set(policy.get("allowedStandardAxioms", []))
    if policy.get("matching") != "exact-set":
        raise AuditError("contract policy.matching must be 'exact-set'")
    if allowed != PROJECT_ALLOWED_STANDARD_AXIOMS:
        raise AuditError(
            "contract changes the project allowlist: "
            f"expected {sorted(PROJECT_ALLOWED_STANDARD_AXIOMS)}, observed {sorted(allowed)}"
        )
    if not PROJECT_REQUIRED_FORBIDDEN_AXIOMS <= forbidden:
        raise AuditError(
            "contract omits required forbidden axiom markers: "
            f"{sorted(PROJECT_REQUIRED_FORBIDDEN_AXIOMS - forbidden)}"
        )

    expected = contract.get("declarations")
    if not isinstance(expected, list) or not expected:
        raise AuditError("contract must declare a non-empty declarations list")

    expected_by_name: dict[str, dict] = {}
    for entry in expected:
        name = entry.get("name")
        axioms = entry.get("axioms")
        if not isinstance(name, str) or not name:
            raise AuditError("each declaration needs a non-empty name")
        if name in expected_by_name:
            raise AuditError(f"duplicate declaration in contract: {name}")
        if not isinstance(axioms, list) or any(not isinstance(a, str) for a in axioms):
            raise AuditError(f"{name}: axioms must be a list of names (empty list means none)")
        if len(set(axioms)) != len(axioms):
            raise AuditError(f"{name}: duplicate axiom in contract")
        if set(axioms) & forbidden:
            raise AuditError(f"{name}: contract includes forbidden axiom(s): {sorted(set(axioms) & forbidden)}")
        if set(axioms) - allowed:
            raise AuditError(f"{name}: contract includes unapproved axiom(s): {sorted(set(axioms) - allowed)}")
        expected_by_name[name] = entry

    observed: dict[str, set[tuple[str, ...]]] = {}
    for line in clean.splitlines():
        match = DEPENDS.search(line)
        if match:
            names = tuple(sorted(a.strip() for a in match.group("axioms").split(",") if a.strip()))
            observed.setdefault(match.group("name"), set()).add(names)
            continue
        match = NO_AXIOMS.search(line)
        if match:
            observed.setdefault(match.group("name"), set()).add(tuple())

    declarations = []
    missing = []
    failures = []
    for name, entry in expected_by_name.items():
        reports = observed.get(name, set())
        if not reports:
            missing.append(name)
            continue
        if len(reports) != 1:
            failures.append(f"{name}: conflicting #print axioms reports: {sorted(reports)}")
            continue
        actual = list(next(iter(reports)))
        declared = sorted(entry["axioms"])
        if actual != declared:
            failures.append(f"{name}: expected axioms {declared}, observed {actual}")
        if set(actual) & forbidden:
            failures.append(f"{name}: forbidden axiom(s) observed: {sorted(set(actual) & forbidden)}")
        if set(actual) - allowed:
            failures.append(f"{name}: unapproved axiom(s) observed: {sorted(set(actual) - allowed)}")
        declarations.append({
            "name": name,
            "role": entry.get("role", ""),
            "expectedAxioms": declared,
            "observedAxioms": actual,
            "matchesContract": actual == declared,
        })

    if missing:
        failures.append("missing #print axioms report(s): " + ", ".join(missing))
    if failures:
        raise AuditError("; ".join(failures))

    return {
        "schemaVersion": contract.get("schemaVersion", 1),
        "kind": "lean-axiom-dependency-audit",
        "status": "passed",
        "sourceCommit": source_commit or "unknown",
        "workflowRunId": workflow_run_id or "unknown",
        "leanVersion": lean_version or "unknown",
        "contract": "proofs/axiom-audit-contract.json",
        "matching": "exact-set",
        "forbiddenAxioms": sorted(forbidden),
        "allowedStandardAxioms": sorted(allowed),
        "declarationCount": len(declarations),
        "declarations": declarations,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--log", type=Path, required=True, help="Lean build log containing #print axioms output")
    parser.add_argument("--contract", type=Path, default=Path("proofs/axiom-audit-contract.json"))
    parser.add_argument("--output", type=Path, required=True, help="JSON evidence report path")
    parser.add_argument("--source-commit", default=os.environ.get("GITHUB_SHA", "unknown"))
    parser.add_argument("--workflow-run-id", default=os.environ.get("GITHUB_RUN_ID", "unknown"))
    parser.add_argument("--lean-version", default="")
    args = parser.parse_args(argv)

    try:
        contract_bytes = args.contract.read_bytes()
        contract = json.loads(contract_bytes)
        log = args.log.read_text(encoding="utf-8", errors="replace")
        report = parse_report(
            log,
            contract,
            source_commit=args.source_commit,
            workflow_run_id=args.workflow_run_id,
            lean_version=args.lean_version,
        )
        report["contractSha256"] = hashlib.sha256(contract_bytes).hexdigest()
    except (OSError, json.JSONDecodeError, AuditError) as error:
        print(f"axiom dependency audit failed: {error}", file=sys.stderr)
        return 1

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    for declaration in report["declarations"]:
        axioms = ", ".join(declaration["observedAxioms"]) or "∅ (aucun axiome)"
        print(f"AXIOM-AUDIT {declaration['name']} := [{axioms}]")
    print(f"axiom dependency audit passed: {report['declarationCount']} declarations; report={args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
