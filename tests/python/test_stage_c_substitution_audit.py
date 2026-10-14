# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CC0-1.0

from collections import Counter
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[2]
RULES_SOURCE = ROOT / "spec" / "Spec" / "C3" / "ReglesDeTypage.lean"
AUDIT_SOURCE = ROOT / "docs" / "migration" / "L1-C06-SUBSTITUTION-AUDIT-2026-10-11.md"
REGISTRY_SOURCE = ROOT / "docs" / "migration" / "L1-THEORY-OBJECTS.md"

# Inventory-only guard, not a mathematical proof.
EXPECTED_RULE_OCCURRENCES = Counter([
    "Var", "Ret", "Th", "Let", "Fo", "Box", "Unbox", "Lam", "App", "Pair", "Inj",
    "Pack", "Open", "One", "OneE", "Split", "Case", "Op", "Tick", "Del", "Sub",
    "SubBox", "Alw", "Alw", "Now", "Wait", "When", "Sc", "Fold", "Unfold", "Gen",
    "Inst", "Out", "Cop", "With", "Proj", "VecI", "VecE", "Slice", "Par", "Vmap",
    "Spawn", "New", "Send", "Guard", "Free", "At", "Move", "Try",
])


def test_c06_matrix_covers_every_current_c3_rule_occurrence():
    rules_text = RULES_SOURCE.read_text(encoding="utf-8")
    audit_text = AUDIT_SOURCE.read_text(encoding="utf-8")

    actual = Counter(re.findall(r"\\textsc\s*\{([^}]+)\}", rules_text))
    assert actual == EXPECTED_RULE_OCCURRENCES, (
        "C3 rule inventory changed; review the proof by cases: "
        f"missing={EXPECTED_RULE_OCCURRENCES - actual}, added={actual - EXPECTED_RULE_OCCURRENCES}"
    )
    assert sum(actual.values()) == 49

    matrix = audit_text.split("## 4. Table exhaustive", maxsplit=1)[1].split(
        "### Conversions à intégrer à l’induction", maxsplit=1
    )[0]
    rows = []
    for line in matrix.splitlines():
        if not line.startswith("|"):
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if len(cells) >= 4 and cells[0] not in {"Règle", "---"}:
            label = cells[0].split()[0].removesuffix("⁺").removesuffix("⁻")
            rows.append(label)

    listed = Counter(rows)
    assert listed == actual, (
        "C-06 matrix does not cover the source inventory exactly once: "
        f"missing={actual - listed}, extra={listed - actual}"
    )
    assert "Alw⁺ (introduction)" in audit_text
    assert "Alw⁻ (élimination)" in audit_text


def test_c06_contract_keeps_conversions_and_effect_axes_explicit():
    audit_text = AUDIT_SOURCE.read_text(encoding="utf-8")
    registry_text = REGISTRY_SOURCE.read_text(encoding="utf-8")

    for required in (
        "ConvCtx", "Conv!", "SubBox", "Scale_Usage", "φ_n", "When", "ψ",
        "π_U", "rationnel", "Démontré dans Lean", "OUVERT",
    ):
        assert required in audit_text, f"Missing C-06 boundary statement: {required}"

    assert "L1-C06-SUBSTITUTION-AUDIT-2026-10-11.md" in registry_text
    assert "C-06 — Substitution, conversions, Scale_Usage et φ_n" in registry_text
