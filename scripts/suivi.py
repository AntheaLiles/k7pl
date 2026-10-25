# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""FROZEN — retired tracking-view generator, 2026-10-25.

This script formerly rendered the derived tracking views (`docs/tracking/`)
from `docs/tracking/fiches-statuts.csv` and
`docs/peer-review/pr-02/taches-consolidees.md`. In the complete
tracking, review and method closing of 2026-10-25, the unclosed
cards were carried into `wiki/roadmap.md`, the views and the status
table were deleted, and this generator was frozen: its `fiches`,
`enonces` and `all` commands now refuse with a frozen notice and
write nothing. Its `check` function survives only as a unit-tested
function on synthetic corpora (see `tests/python/test_suivi.py`);
it is no longer a live gate on repository files, and the workflow
step that ran it is removed. The history read is corrected here
as well (Q6 of that closing): the script no longer reads the
deleted `docs/history/` snapshot — the "reviewed number" column
it produced from that snapshot is abandoned, and no reviewed
number from it may be quoted as a current fact.
"""

from __future__ import annotations

import csv
import re
import sys
from collections import Counter, OrderedDict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import manuscript_metrics as mm  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
TRACKING = ROOT / "docs" / "tracking"
# Frozen: these paths name the deleted inputs, for the unit-tested
# `check` function on synthetic corpora only. Nothing in this file
# reads them for a live run any more; `main` refuses generation.
CARDS = ROOT / "docs" / "peer-review" / "pr-02" / "taches-consolidees.md"
STATUTS = TRACKING / "fiches-statuts.csv"

LOTS = OrderedDict(
    [
        ("BLOQ", "Blockers"),
        ("STRUCT", "Structural"),
        ("PORT", "Scope"),
        ("PREUVE", "Proof debt"),
        ("NOTA", "Notation, counts, references"),
        ("IMPL", "Implementation and tooling"),
        ("FACT", "Factorisations to write"),
        ("REFUS", "Rejected factorisations"),
        ("REECR", "Statement rewrites"),
        ("BIB", "Bibliographic checks"),
        ("TRANS", "Cross-cutting revisions"),
        ("ARB-PR", "Arbitrations"),
    ]
)

STATUS_LABELS = {
    "theoreme": "theorem",
    "proposition": "proposition",
    "exigence": "requirement",
    "conjecture": "conjecture",
    "definition": "definition",
    "litterature": "literature",
}
LEVEL_LABELS = {
    "langage": "language",
    "representation": "representation",
    "compilation": "compilation",
    "deploiement": "deployment",
}

SYMBOL = {
    "fermee": "✅ closed",
    "partielle": "🟡 partial",
    "a-ratifier": "⏳ to ratify",
    "decision": "❓ decision",
    "ecartee": "⛔ rejected",
    "ouverte": "⬜ open",
}


def cards() -> "OrderedDict[str, str]":
    """Card id → title, from the consolidated plan."""
    text = CARDS.read_text(encoding="utf-8")
    out: "OrderedDict[str, str]" = OrderedDict()
    for m in re.finditer(r"^### `([A-Z-]+-\d+)` — (.*)$", text, re.M):
        title = re.sub(r"^(?:✅|⚠️) \*\*[^*]*\*\* — ", "", m.group(2)).strip()
        out[m.group(1)] = title
    in_tables = False
    for line in text.split("\n"):
        if line.startswith("## 9. Lot REFUS") or line.startswith("## 10. Lot REECR") or line.startswith("## 11. Lot BIB"):
            in_tables = True
        elif line.startswith("## ") and not re.match(r"## (9|10|11)\.", line):
            in_tables = False
        if in_tables:
            m = re.match(r"^\| `((?:REFUS|REECR|BIB)-\d+)` \| (.*?) \|", line)
            if m:
                out[m.group(1)] = m.group(2).strip()
    return out


def statuts() -> "OrderedDict[str, dict]":
    with STATUTS.open(encoding="utf-8", newline="") as f:
        return OrderedDict((r["id"], r) for r in csv.DictReader(f))


def lot_of(card_id: str) -> str:
    return card_id.rsplit("-", 1)[0]


def check() -> int:
    c, s = cards(), statuts()
    missing = [i for i in c if i not in s]
    extra = [i for i in s if i not in c]
    for i in missing:
        print(f"card without status: {i}")
    for i in extra:
        print(f"status without card: {i}")
    bad = [i for i, r in s.items() if r["statut"] not in SYMBOL]
    for i in bad:
        print(f"unknown status for {i}: {s[i]['statut']}")
    print(f"{len(c)} cards, {len(s)} statuses")
    return 1 if missing or extra or bad else 0


def lot_summary() -> str:
    s = statuts()
    rows = ["| Lot | Cards | ✅ closed | 🟡 partial | ⏳ to ratify | ❓ decision | ⛔ rejected | ⬜ open |", "|---|--:|--:|--:|--:|--:|--:|--:|"]
    tot = Counter()
    for lot, label in LOTS.items():
        ids = [i for i in s if lot_of(i) == lot]
        c = Counter(s[i]["statut"] for i in ids)
        tot.update(c)
        rows.append(
            f"| `{lot}` {label} | {len(ids)} | {c['fermee']} | {c['partielle']} | {c['a-ratifier']} | {c['decision']} | {c['ecartee']} | {c['ouverte']} |"
        )
    n = sum(tot.values())
    rows.append(f"| **Total** | **{n}** | **{tot['fermee']}** | **{tot['partielle']}** | **{tot['a-ratifier']}** | **{tot['decision']}** | **{tot['ecartee']}** | **{tot['ouverte']}** |")
    return "\n".join(rows)


def render_fiches() -> str:
    c, s = cards(), statuts()
    out = [
        "# PR-02 Campaign Cards — Status by Card",
        "",
        "Generated view from `docs/peer-review/pr-02/taches-consolidees.md` (card content) and `fiches-statuts.csv` (the only manually maintained status source). Do not edit this file.",
        "",
        "Confidence: **journal** means a session report names the card; **card** means the status is stated in the card; **inferred** means it is derived by correlating a manuscript status change with the card text and remains to be confirmed.",
        "",
        "## Summary by lot",
        "",
        lot_summary(),
        "",
    ]
    for lot, label in LOTS.items():
        ids = [i for i in c if lot_of(i) == lot]
        out += [f"## {lot} — {label}", "", "| Card | Status | Title | Evidence · note |", "|---|---|---|---|"]
        for i in ids:
            r = s[i]
            proof = ""
            if r["preuve"]:
                rel = r["preuve"]
                proof = f"[{r['confiance']}](../{rel})"
            if r["note"]:
                proof += (" · " if proof else "") + r["note"]
            title = c[i].replace("|", "\\|")
            out.append(f"| `{i}` | {SYMBOL[r['statut']]} | {title} | {proof} |")
        out.append("")
    return "\n".join(out)


def write(path: Path, text: str) -> None:
    path.write_text(text.rstrip("\n") + "\n", encoding="utf-8")
    print("écrit", path.relative_to(ROOT))


def relu_numbers() -> dict[str, str]:
    """Statement label → reviewed number: abandoned with the deleted
    `docs/history/` Org snapshot (Q6, 2026-10-25). Always empty now;
    no reviewed number from that snapshot may be quoted as current."""
    return {}


def render_enonces() -> str:
    relu = relu_numbers()
    out = [
        "# Correspondance des énoncés numérotés et de leurs étiquettes",
        "",
        "Generated view from `spec/`. The inventory number is a global ordinal in document order, not the displayed counter of a specialized statement directive. The historical number from the reviewed PDF is shown separately. Do not edit this file.",
        "",
        "* **Reviewed no.**: number printed in the PDF read by the six reviewers. A dash marks a statement introduced later.",
        "* **References**: number of `{num}` references to the statement; zero means only that it is not cited.",
        "",
        "| Inventory no. | Reviewed no. | Label | Kind/role | Level | Title | Section | References |",
        "|--:|--:|---|---|---|---|---|--:|",
    ]
    for r in mm.statements():
        out.append(
            f"| {r['numero']} | {relu.get(r['label'], '—')} | `{r['label']}` | {STATUS_LABELS.get(r['statut'], r['statut'])} | {LEVEL_LABELS.get(r['niveau'], r['niveau'])} | {r['titre']} | §{r['section']} | {r['renvois']} |"
        )
    return "\n".join(out)


def main() -> int:
    cmd = sys.argv[1] if len(sys.argv) > 1 else "all"
    if cmd == "check":
        if not CARDS.exists() or not STATUTS.exists():
            print("scripts/suivi.py is FROZEN (2026-10-25): its inputs are deleted; check() survives only as a unit-tested function on synthetic corpora.")
            return 2
        return check()
    print("scripts/suivi.py is FROZEN (2026-10-25): the tracking views are deleted and the card source of truth is wiki/roadmap.md; nothing is generated.")
    return 2


if __name__ == "__main__":
    sys.exit(main())
