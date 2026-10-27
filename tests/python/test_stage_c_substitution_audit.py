# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CC0-1.0

from collections import Counter
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
RULES_SOURCE = ROOT / "spec" / "Spec" / "C3" / "TypingRules.lean"

# Inventory-only guard, not a mathematical proof. The former C-06 audit and
# the theory-object register lived in docs/migration/ until the complete
# migration closing of 2026-10-25 deleted them; their verdicts are traced in
# wiki/_migration-matrix.md and survive in git history. This file keeps only
# the live side of the old guard: the C3 rule inventory must still match the
# pinned inventory, so that a new rule forces a proof-by-cases review.
#
# NOTE — ratified by the author on 2026-10-25: `Nxt` and `Loc` are real
# typing rules, added by spec change b0d2cbf. They join the construction of
# the typing system, which the author objectifies as the object system of
# K7PL (composing a type is providing an immutable object), a conception
# strongly inspired by CLOS, whose construction includes locality clauses.
# The pinned inventory is therefore 51 occurrences, not 49.
EXPECTED_RULE_OCCURRENCES = Counter([
    "Var", "Ret", "Th", "Let", "Fo", "Box", "Unbox", "Lam", "App", "Pair", "Inj",
    "Pack", "Open", "One", "OneE", "Split", "Case", "Op", "Tick", "Del", "Sub",
    "SubBox", "Alw", "Alw", "Now", "Nxt", "Wait", "When", "Sc", "Fold", "Unfold", "Gen",
    "Inst", "Out", "Cop", "With", "Proj", "VecI", "VecE", "Slice", "Par", "Vmap",
    "Spawn", "New", "Send", "Guard", "Free", "At", "Loc", "Move", "Try",
])


def test_c3_rule_inventory_still_matches_the_pinned_inventory():
    rules_text = RULES_SOURCE.read_text(encoding="utf-8")

    actual = Counter(re.findall(r"\\textsc\s*\{([^}]+)\}", rules_text))
    assert actual == EXPECTED_RULE_OCCURRENCES, (
        "C3 rule inventory changed; review the proof by cases: "
        f"missing={EXPECTED_RULE_OCCURRENCES - actual}, added={actual - EXPECTED_RULE_OCCURRENCES}"
    )
    assert sum(actual.values()) == 51
