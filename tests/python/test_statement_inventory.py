# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
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

import hashlib  # noqa: E402

import statement_inventory as inventory  # noqa: E402


def test_current_inventory_matches_all_active_statement_blocks():
    errors = inventory.check_inventory()
    assert errors == [], "\n".join(errors)
    rows = inventory.source_inventory()
    assert len(rows) == 77
    assert len({row["path"] for row in rows}) == 21


def test_all_historical_levels_are_preserved():
    rows = inventory.source_inventory()
    historical = inventory.historical_levels()
    assert len(historical) == 69
    current = {str(row["label"]): str(row["level"]) for row in rows}
    assert set(historical) <= set(current)
    assert {label: current[label] for label in historical} == historical


def test_historical_level_drift_is_reported(tmp_path, monkeypatch):
    original = inventory.HISTORICAL_INVENTORY.read_text(encoding="utf-8")
    lines = original.splitlines()
    for index, line in enumerate(lines):
        if line.startswith("| `spec/Spec/") and "`thm:" in line:
            cells = line.split("|")
            cells[5] = " representation "
            lines[index] = "|".join(cells)
            break
    else:
        raise AssertionError("no detailed historical statement row found")
    path = tmp_path / "historical-inventory.md"
    path.write_text("\n".join(lines), encoding="utf-8")
    monkeypatch.setattr(inventory, "HISTORICAL_INVENTORY", path)

    errors = inventory.check_inventory()

    assert any("historical level changed:" in error for error in errors)


def test_inventory_drift_is_reported(tmp_path):
    original = inventory.DEFAULT_INVENTORY.read_text(encoding="utf-8")
    changed = original.replace("| `thm:schema_commutation` |", "| `thm:deliberately_stale` |", 1)
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


def test_current_dependency_cycle_scan_is_advisory(capsys):
    result = inventory.main(["--dependency-cycles"])
    output = capsys.readouterr().out
    assert result == 0
    assert (
        "no syntactic cycles detected" in output
        or "possible dependency cycle (semantic review required)" in output
    )

def test_all_historical_labels_survive_with_only_declared_companion_objects():
    rows = inventory.source_inventory()
    historical = inventory.historical_labels()
    active = {str(row["label"]) for row in rows}
    assert len(historical) == 69
    assert historical <= active
    assert active - historical == inventory.EXPECTED_COMPANION_LABELS
    assert len(inventory.EXPECTED_COMPANION_LABELS) == 8


# SHA-256 of the detailed table of the pre-migration snapshot. The digest was computed on
# LEAN-STATEMENT-INVENTORY.md (last version e9b5d2b2) before the snapshot moved, unchanged, into
# the appendix of the migration register. The level and label checks read this table, so any
# edit to it must fail here rather than silently rebase the historical baseline.
FROZEN_HISTORICAL_TABLE_SHA256 = "88e8213a23c0103db2a6f6789ffb175553f83adb051839040fc67225d7f66c10"


def test_historical_snapshot_is_frozen():
    text = inventory.HISTORICAL_INVENTORY.read_text(encoding="utf-8")
    table = inventory.historical_table(text)
    assert hashlib.sha256(table.encode("utf-8")).hexdigest() == FROZEN_HISTORICAL_TABLE_SHA256
    assert len(inventory.HISTORICAL_ROW.findall(table)) == 69


def test_historical_snapshot_follows_the_classification_table():
    text = inventory.DEFAULT_INVENTORY.read_text(encoding="utf-8")
    assert text.index("## Classification courante") < text.index(inventory.HISTORICAL_TABLE_START)
    assert text.index(inventory.HISTORICAL_TABLE_START) < text.index(inventory.HISTORICAL_TABLE_END)
