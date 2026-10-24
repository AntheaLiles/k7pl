# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Contract tests for the KLean-generated Lean axiom dependency report."""

from __future__ import annotations

import json
import unittest
from pathlib import Path

from k7pl_semantics_axiom_report import AuditError, parse_report

ROOT = Path(__file__).resolve().parents[2]
CONTRACT = json.loads((ROOT / "proofs" / "axiom-audit-contract.json").read_text(encoding="utf-8"))


def make_log(overrides: dict[str, list[str]] | None = None, missing: set[str] | None = None) -> str:
    overrides = overrides or {}
    missing = missing or set()
    lines = []
    for index, declaration in enumerate(CONTRACT["declarations"], start=1):
        name = declaration["name"]
        if name in missing:
            continue
        axioms = overrides.get(name, declaration["axioms"])
        location = f"info: K7PL/Generated.lean:{index}:0: "
        if axioms:
            lines.append(f"{location}'{name}' depends on axioms: [{', '.join(axioms)}]")
        else:
            lines.append(f"{location}'{name}' does not depend on any axioms")
    return "\n".join(lines) + "\n"


class TestK7plSemanticsAxiomReport(unittest.TestCase):
    def test_exact_contract_and_empty_axiom_sets_are_preserved(self):
        report = parse_report(
            make_log(),
            CONTRACT,
            source_commit="a" * 40,
            workflow_run_id="12345",
            lean_version="Lean version 4.34.0",
        )
        self.assertEqual(report["status"], "passed")
        self.assertEqual(report["sourceCommit"], "a" * 40)
        self.assertEqual(report["workflowRunId"], "12345")
        self.assertEqual(report["declarationCount"], len(CONTRACT["declarations"]))
        by_name = {row["name"]: row for row in report["declarations"]}
        self.assertEqual(by_name["K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected"]["observedAxioms"], [])
        self.assertEqual(by_name["K7PL.Bridge.add_root_is_klean_rewrite"]["observedAxioms"], ["propext"])
        self.assertTrue(all(row["matchesContract"] for row in report["declarations"]))

    def test_missing_report_is_not_treated_as_empty_axiom_set(self):
        missing = {"K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected"}
        with self.assertRaisesRegex(AuditError, "missing #print axioms report"):
            parse_report(make_log(missing=missing), CONTRACT, source_commit="x", workflow_run_id="y", lean_version="z")

    def test_unexpected_axiom_dependency_fails_exact_match(self):
        name = "K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected"
        with self.assertRaisesRegex(AuditError, "expected axioms"):
            parse_report(
                make_log(overrides={name: ["propext"]}),
                CONTRACT,
                source_commit="x",
                workflow_run_id="y",
                lean_version="z",
            )

    def test_unexpected_extra_axiom_fails_even_if_contract_is_changed(self):
        altered = json.loads(json.dumps(CONTRACT))
        altered["declarations"][0]["axioms"] = ["Lean.ofReduceBool"]
        with self.assertRaisesRegex(AuditError, "unapproved axiom"):
            parse_report(
                make_log(overrides={altered["declarations"][0]["name"]: ["Lean.ofReduceBool"]}),
                altered,
                source_commit="x",
                workflow_run_id="y",
                lean_version="z",
            )

    def test_conflicting_duplicate_reports_fail(self):
        name = "K7PL.Bridge.add_root_is_klean_rewrite"
        log = make_log() + f"info: repeated: '{name}' does not depend on any axioms\n"
        with self.assertRaisesRegex(AuditError, "conflicting"):
            parse_report(log, CONTRACT, source_commit="x", workflow_run_id="y", lean_version="z")

    def test_sorry_ax_fails(self):
        with self.assertRaisesRegex(AuditError, "sorryAx"):
            parse_report(
                make_log() + "info: forbidden dependency sorryAx\n",
                CONTRACT,
                source_commit="x",
                workflow_run_id="y",
                lean_version="z",
            )


if __name__ == "__main__":
    unittest.main()
