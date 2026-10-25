# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CC0-1.0

from collections import Counter
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
RULES_SOURCE = ROOT / "spec" / "Spec" / "C3" / "ReglesDeTypage.lean"

# Inventory-only guard, not a mathematical proof. The former C-06 audit and
# the theory-object register lived in docs/migration/ until the complete
# migration closing of 2026-10-25 deleted them; their verdicts are traced in
# wiki/_migration-matrix.md and survive in git history. This file keeps only
# the live side of the old guard: the C3 rule inventory must still match the
# pinned inventory, so that a new rule forces a proof-by-cases review.
#
# NOTE — pre-existing drift, not ratified here: at the migration closing the
# current inventory counts 51 occurrences, not 49: `Nxt` and `Loc` were added
# to the typing rules (spec change b0d2cbf) after the 49-row inventory was
# pinned. This test therefore FAILS until the gate re-audit reviews the two
# added rules by cases. Updating the pinned inventory to 51 without that
# review would silently ratify the drift, so it is deliberately not done here.
EXPECTED_RULE_OCCURRENCES = Counter([
    "Var", "Ret", "Th", "Let", "Fo", "Box", "Unbox", "Lam", "App", "Pair", "Inj",
    "Pack", "Open", "One", "OneE", "Split", "Case", "Op", "Tick", "Del", "Sub",
    "SubBox", "Alw", "Alw", "Now", "Wait", "When", "Sc", "Fold", "Unfold", "Gen",
    "Inst", "Out", "Cop", "With", "Proj", "VecI", "VecE", "Slice", "Par", "Vmap",
    "Spawn", "New", "Send", "Guard", "Free", "At", "Move", "Try",
])


def test_c3_rule_inventory_still_matches_the_pinned_inventory():
    rules_text = RULES_SOURCE.read_text(encoding="utf-8")

    actual = Counter(re.findall(r"\\textsc\s*\{([^}]+)\}", rules_text))
    assert actual == EXPECTED_RULE_OCCURRENCES, (
        "C3 rule inventory changed; review the proof by cases: "
        f"missing={EXPECTED_RULE_OCCURRENCES - actual}, added={actual - EXPECTED_RULE_OCCURRENCES}"
    )
    assert sum(actual.values()) == 49
