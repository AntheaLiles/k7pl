# SPDX-FileCopyrightText: 2026 K7PL contributors
#
# SPDX-License-Identifier: CC0-1.0
"""Regression tests for the C8 legacy statement inventory drift checker."""

from __future__ import annotations

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
CONTROLS = ROOT / "scripts" / "controles"
if str(CONTROLS) not in sys.path:
    sys.path.insert(0, str(CONTROLS))

import statement_inventory as inventory  # noqa: E402


def test_current_inventory_matches_all_active_statement_blocks():
    errors = inventory.check_inventory()
    assert errors == [], "\n".join(errors)
    rows = inventory.source_inventory()
    assert len(rows) == 69
    assert len({row["path"] for row in rows}) == 21


def test_inventory_drift_is_reported(tmp_path):
    original = inventory.DEFAULT_INVENTORY.read_text(encoding="utf-8")
    changed = original.replace("thm:schema_commutation", "thm:deliberately_stale", 1)
    path = tmp_path / "inventory.md"
    path.write_text(changed, encoding="utf-8")

    errors = inventory.check_inventory(path)

    assert any("missing inventory row" in error for error in errors)
    assert any("stale inventory row" in error for error in errors)


def test_statement_dependencies_resolve_and_keep_direct_edges():
    rows = inventory.source_inventory()
    labels = {str(row["label"]) for row in rows}
    unresolved = [
        (row["label"], dependency)
        for row in rows
        for dependency in row["dependencies"]
        if dependency not in labels
    ]
    assert unresolved == []

    by_label = {str(row["label"]): row for row in rows}
    assert by_label["thm:schema_effacement"]["dependencies"] == [
        "thm:raffinement",
        "thm:schema_commutation",
        "thm:schema_preservation",
    ]


def test_dependency_cycles_reports_strongly_connected_components():
    rows = [
        {"label": "thm:a", "dependencies": ["thm:b"]},
        {"label": "thm:b", "dependencies": ["thm:a", "thm:c"]},
        {"label": "thm:c", "dependencies": []},
        {"label": "thm:downstream", "dependencies": ["thm:a"]},
    ]
    assert inventory.dependency_cycles(rows) == [["thm:a", "thm:b"]]


def test_dependency_cycles_returns_empty_for_acyclic_graph():
    rows = [
        {"label": "thm:base", "dependencies": []},
        {"label": "thm:derived", "dependencies": ["thm:base"]},
    ]
    assert inventory.dependency_cycles(rows) == []


def test_dependency_cycles_reports_self_reference():
    rows = [{"label": "thm:self", "dependencies": ["thm:self"]}]
    assert inventory.dependency_cycles(rows) == [["thm:self"]]


def test_current_source_graph_has_no_syntactic_cycle_after_core_scope_change():
    cycles = inventory.dependency_cycles(inventory.source_inventory())
    assert cycles == []
