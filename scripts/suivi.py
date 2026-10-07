# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Renders the derived tracking views (`docs/tracking/`).

    python3 scripts/suivi.py check      # the status table covers exactly the review cards
    python3 scripts/suivi.py fiches     # docs/tracking/FICHES-PR02.md
    python3 scripts/suivi.py enonces    # docs/tracking/correspondance-enonces.md
    python3 scripts/suivi.py dashboard  # refreshes the generated blocks of TABLEAU-DE-BORD.md
    python3 scripts/suivi.py all

Human-maintained inputs: `docs/tracking/fiches-statuts.csv` (one row per card: status, confidence,
proof, note) and the prose of the dashboard. What is produced: every count, every register.
The cards themselves (titles, findings) live in `docs/peer-review/pr-02/taches-consolidees.md`.
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
HISTORY = ROOT / "docs" / "history"
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
        ("REECR", "Réécritures d'énoncés"),
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
    """Statement label → number printed in the PDF the reviewers read (September 9), from the
    snapshot of the former Org tooling."""
    snap = HISTORY / "correspondance-theoremes-org.md"
    if not snap.exists():
        return {}
    rows = re.findall(r"^\| (—|\d+) \| \d+ \| `(thm:[^`]+)` \|", snap.read_text(encoding="utf-8"), re.M)
    return {lab: relu for relu, lab in rows}


def render_enonces() -> str:
    relu = relu_numbers()
    out = [
        "# Correspondance des énoncés numérotés et de leurs étiquettes",
        "",
        "Generated view from `spec/`. The number is the global statement counter in document order. Do not edit this file.",
        "",
        "* **Reviewed no.**: number printed in the PDF read by the six reviewers. A dash marks a statement introduced later.",
        "* **References**: number of `{num}` references to the statement; zero means only that it is not cited.",
        "",
        "| No. | Reviewed no. | Label | Status | Level | Title | Section | References |",
        "|--:|--:|---|---|---|---|---|--:|",
    ]
    for r in mm.statements():
        out.append(
            f"| {r['numero']} | {relu.get(r['label'], '—')} | `{r['label']}` | {r['statut']} | {r['niveau']} | {r['titre']} | §{r['section']} | {r['renvois']} |"
        )
    return "\n".join(out)


def refresh_block(text: str, name: str, body: str) -> str:
    pat = re.compile(rf"<!-- BEGIN:{name} -->.*?<!-- END:{name} -->", re.S)
    if not pat.search(text):
        raise SystemExit(f"bloc <!-- BEGIN:{name} --> introuvable")
    return pat.sub(lambda m: f"<!-- BEGIN:{name} -->\n{body}\n<!-- END:{name} -->", text)


def dashboard() -> None:
    path = TRACKING / "TABLEAU-DE-BORD.md"
    text = path.read_text(encoding="utf-8")
    text = refresh_block(text, "mesures", mm.md_summary())
    text = refresh_block(text, "fiches", lot_summary())
    st = mm.statements()
    openr = [r for r in st if r["statut"] in ("proposition", "conjecture", "exigence")]
    lines = ["| Label | Status | Level | Section | References |", "|---|---|---|---|--:|"]
    for r in openr:
        lines.append(f"| `{r['label']}` | {STATUS_LABELS.get(r['statut'], r['statut'])} | {LEVEL_LABELS.get(r['niveau'], r['niveau'])} | §{r['section']} | {r['renvois']} |")
    text = refresh_block(text, "ouverts", "\n".join(lines))
    write(path, text)


def main() -> int:
    cmd = sys.argv[1] if len(sys.argv) > 1 else "all"
    if cmd == "check":
        return check()
    if cmd in ("fiches", "all"):
        if check():
            return 1
        write(TRACKING / "FICHES-PR02.md", render_fiches())
    if cmd in ("enonces", "all"):
        write(TRACKING / "correspondance-enonces.md", render_enonces())
    if cmd in ("dashboard", "all"):
        dashboard()
    if cmd not in ("check", "fiches", "enonces", "dashboard", "all"):
        print(__doc__)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
