# SPDX-FileCopyrightText: 2026 K7PL contributors
# SPDX-License-Identifier: CC0-1.0
"""Traceability guard for the Stage C effective-rule evidence matrix.

This validates the matrix against the Verso rule inventory. It is not a
proof of typing, substitution, resource preservation, or semantic simulation.
"""

from __future__ import annotations

from collections import Counter
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
RULES_SOURCE = ROOT / "spec" / "Spec" / "C3" / "ReglesDeTypage.lean"
MATRIX_SOURCE = ROOT / "docs" / "migration" / "L1-C-EFFECTIVE-RULE-EVIDENCE-MATRIX-2026-10-12.md"


def test_effective_rule_matrix_matches_all_c3_rule_occurrences():
    source = RULES_SOURCE.read_text(encoding="utf-8")
    matrix = MATRIX_SOURCE.read_text(encoding="utf-8")
    source_labels = Counter(re.findall(r"\\textsc\s*\{([^}]+)\}", source))
    matrix_labels = re.findall(r"^\|\s*\d+\s*\|\s*`([^`]+)`\s*\|", matrix, re.MULTILINE)
    normalised = [re.sub(r"[⁺⁻]$", "", label) for label in matrix_labels]

    assert len(matrix_labels) == 49, f"expected 49 matrix rows, got {len(matrix_labels)}"
    assert Counter(normalised) == source_labels, (
        "matrix/source inventory drift: "
        f"missing={source_labels - Counter(normalised)}, "
        f"extra={Counter(normalised) - source_labels}"
    )
    assert all("**ABSENT**" in line for line in matrix.splitlines() if re.match(r"^\|\s*\d+\s*\|", line))
    assert "ne constitue ni une preuve" in matrix.lower()
