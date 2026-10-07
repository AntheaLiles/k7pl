# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Renders the derived views of the follow-up (`docs/suivi/`).

    python3 scripts/suivi.py check      # the status table covers every card, and only them
    python3 scripts/suivi.py fiches     # docs/suivi/FICHES-PR02.md
    python3 scripts/suivi.py reste      # docs/suivi/RESTE-A-FAIRE.md (what remains, by nature of the work)
    python3 scripts/suivi.py enonces    # docs/suivi/correspondance-enonces.md
    python3 scripts/suivi.py dashboard  # refreshes the generated blocks of TABLEAU-DE-BORD.md
    python3 scripts/suivi.py all

What a person maintains: `docs/suivi/fiches-statuts.csv` (one row per card: status, confidence,
proof, note) and the prose of the dashboard. What is produced: every count, every register.
The cards themselves (titles, findings) live in `docs/relectures/pr-02/taches-consolidees.md`.
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
SUIVI = ROOT / "docs" / "suivi"
CARDS = ROOT / "docs" / "relectures" / "pr-02" / "taches-consolidees.md"
STATUTS = SUIVI / "fiches-statuts.csv"

LOTS = OrderedDict(
    [
        ("BLOQ", "Bloquants"),
        ("STRUCT", "Structurels"),
        ("PORT", "Portée"),
        ("PREUVE", "Dettes de preuve"),
        ("NOTA", "Notation, comptes, renvois"),
        ("IMPL", "Implémentation et outillage"),
        ("FACT", "Factorisations à écrire"),
        ("REFUS", "Factorisations refusées"),
        ("REECR", "Réécritures d'énoncés"),
        ("BIB", "Vérifications bibliographiques"),
        ("TRANS", "Refontes transversales"),
        ("ARB-PR", "Arbitrages"),
    ]
)

SYMBOL = {
    "fermee": "✅ fermée",
    "partielle": "🟡 partielle",
    "a-ratifier": "⏳ à ratifier",
    "decision": "❓ décision",
    "ecartee": "⛔ écartée",
    "ouverte": "⬜ ouverte",
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
        print(f"fiche sans statut : {i}")
    for i in extra:
        print(f"statut sans fiche : {i}")
    bad = [i for i, r in s.items() if r["statut"] not in SYMBOL]
    for i, r in s.items():
        if r["statut"] not in ("fermee", "ecartee") and r.get("nature") not in NATURES:
            print(f"fiche ouverte sans nature : {i}")
            bad.append(i)
    for i in bad:
        print(f"statut inconnu pour {i} : {s[i]['statut']}")
    print(f"{len(c)} fiches, {len(s)} statuts")
    return 1 if missing or extra or bad else 0


def lot_summary() -> str:
    s = statuts()
    rows = ["| Lot | Fiches | ✅ fermées | 🟡 partielles | ⏳ à ratifier | ❓ décision | ⛔ écartées | ⬜ ouvertes |", "|---|--:|--:|--:|--:|--:|--:|--:|"]
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
        "# Fiches de la campagne PR-02 — état par fiche",
        "",
        "Vue **produite** par `scripts/suivi.py fiches` à partir de [`docs/relectures/pr-02/taches-consolidees.md`](../relectures/pr-02/taches-consolidees.md) (le texte des fiches) et de [`fiches-statuts.csv`](fiches-statuts.csv) (l'état, seul fichier à tenir à la main). Ne pas éditer ce fichier.",
        "",
        "Confiance : **journal** = le compte rendu de séance nomme la fiche ; **fiche** = l'état est dans la fiche elle-même ; **déduite** = conclue par le rapprochement d'un changement de statut du manuscrit et du texte de la fiche — *à confirmer par l'auteur*.",
        "",
        "## Synthèse par lot",
        "",
        lot_summary(),
        "",
    ]
    for lot, label in LOTS.items():
        ids = [i for i in c if lot_of(i) == lot]
        out += [f"## {lot} — {label}", "", "| Fiche | État | Titre | Preuve · note |", "|---|---|---|---|"]
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


NATURES = OrderedDict(
    [
        ("decision", "Décisions de l'auteur"),
        ("ratification", "À ratifier (appliqué, non confirmé)"),
        ("conception", "Travaux de conception"),
        ("preuve", "Preuves à conduire"),
        ("redaction", "Rédaction restante"),
        ("outil", "Contrôles et outillage"),
        ("recherche", "Recherches et vérifications de sources"),
    ]
)


def render_reste() -> str:
    """The to-do view: every card that is neither closed nor set aside, by nature of the work."""
    c, s = cards(), statuts()
    open_rows = [r for r in s.values() if r["statut"] not in ("fermee", "ecartee")]
    out = [
        "# Reste à faire",
        "",
        "Vue **produite** par `scripts/suivi.py reste` à partir de [`fiches-statuts.csv`](fiches-statuts.csv) (colonnes `nature`, `avancement`, `suite`, `depend`). Ne pas éditer ce fichier : tenir le CSV.",
        "",
        f"**{len(open_rows)} fiches** restent à traiter sur {len(s)} ; {sum(1 for r in s.values() if r['statut'] == 'fermee')} sont fermées, {sum(1 for r in s.values() if r['statut'] == 'ecartee')} écartées. `avancement` est une estimation du travail accompli sur la fiche, pas une mesure.",
        "",
        "| Nature | Fiches | Avancement moyen |",
        "|---|--:|--:|",
    ]
    for nat, label in NATURES.items():
        rs = [r for r in open_rows if r["nature"] == nat]
        if rs:
            avg = sum(int(r["avancement"] or 0) for r in rs) // len(rs)
            out.append(f"| {label} | {len(rs)} | {avg} % |")
    out.append("")
    for nat, label in NATURES.items():
        rs = [r for r in open_rows if r["nature"] == nat]
        if not rs:
            continue
        out += [f"## {label}", "", "| Fiche | Titre | Avancement | Prochaine étape | Dépend de |", "|---|---|--:|---|---|"]
        for r in sorted(rs, key=lambda r: -int(r["avancement"] or 0)):
            title = c.get(r["id"], "").replace("|", "\\|")[:90]
            out.append(f"| `{r['id']}` | {title} | {r['avancement']} % | {r['suite']} | {r['depend']} |")
        out.append("")
    return "\n".join(out)


def write(path: Path, text: str) -> None:
    path.write_text(text.rstrip("\n") + "\n", encoding="utf-8")
    print("écrit", path.relative_to(ROOT))


def relu_numbers() -> dict[str, str]:
    """Statement label → number printed in the PDF the reviewers read (September 9), from the
    snapshot of the former Org tooling."""
    snap = SUIVI / "correspondance-theoremes-org.md"
    if not snap.exists():
        return {}
    rows = re.findall(r"^\| (—|\d+) \| \d+ \| `(thm:[^`]+)` \|", snap.read_text(encoding="utf-8"), re.M)
    return {lab: relu for relu, lab in rows}


def render_enonces() -> str:
    relu = relu_numbers()
    out = [
        "# Correspondance des énoncés numérotés et de leurs étiquettes",
        "",
        "Vue **produite** par `scripts/suivi.py enonces` à partir de `spec/` (le numéro est celui du compteur global de la spécification, dans l'ordre du document). Ne pas éditer ce fichier.",
        "",
        "* **N° relu** : le numéro imprimé dans le PDF du 9 septembre 2026 que les six relecteurs ont lu, et que citent encore les fiches (« Th. 36 »). Un tiret marque un énoncé écrit depuis.",
        "* **Renvois** : nombre de `{num}` qui pointent vers l'énoncé ; zéro ne veut pas dire inutile, seulement jamais cité.",
        "",
        "| N° | N° relu | Étiquette | Statut | Niveau | Titre | Lieu | Renvois |",
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
    path = SUIVI / "TABLEAU-DE-BORD.md"
    text = path.read_text(encoding="utf-8")
    text = refresh_block(text, "mesures", mm.md_summary())
    text = refresh_block(text, "fiches", lot_summary())
    st = mm.statements()
    openr = [r for r in st if r["statut"] in ("proposition", "conjecture", "exigence")]
    lines = ["| Étiquette | Statut | Niveau | Lieu | Renvois |", "|---|---|---|---|--:|"]
    for r in openr:
        lines.append(f"| `{r['label']}` | {r['statut']} | {r['niveau']} | §{r['section']} | {r['renvois']} |")
    text = refresh_block(text, "ouverts", "\n".join(lines))
    write(path, text)


def main() -> int:
    cmd = sys.argv[1] if len(sys.argv) > 1 else "all"
    if cmd == "check":
        return check()
    if cmd in ("fiches", "all"):
        if check():
            return 1
        write(SUIVI / "FICHES-PR02.md", render_fiches())
    if cmd in ("reste", "all"):
        if check():
            return 1
        write(SUIVI / "RESTE-A-FAIRE.md", render_reste())
    if cmd in ("enonces", "all"):
        write(SUIVI / "correspondance-enonces.md", render_enonces())
    if cmd in ("dashboard", "all"):
        dashboard()
    if cmd not in ("check", "fiches", "reste", "enonces", "dashboard", "all"):
        print(__doc__)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
