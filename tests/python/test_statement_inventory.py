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
