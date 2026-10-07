# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Couverture spec ↔ Lean : la matrice des identifiants normatifs.

Le manuscrit pose des énoncés (`::::thm`), nomme des formules (`::::formula`) et écrit des règles
de typage (`\\textsc{R} \\frac{…}{…}`) : ce sont les **identifiants normatifs** du projet. Chacun
d'eux est une dette de vérification tant qu'aucune preuve Lean ne le rejoint. Cette matrice
extrait les identifiants de `spec/`, cherche dans `src/` les accroches de couplage, et publie le
résultat dans `docs/STATUS.md` (bloc délimité, régénéré par la CI) :

* `Formule N := M` — la formule d'étiquette `N` est l'énoncé formalisé par le lemme `M` ;
* `Énoncé thm:N := M` — le lemme `M` est déclaré comme formalisation de l'énoncé `thm:N` ;
* `Regle R := M1, M2` — la règle de typage `R` est couverte par les constructions `M1, M2` de
  l'algèbre formalisée (`src/K7pl/Algebre.lean`) ;

Les accroches vivent dans les commentaires de `src/` (anglais, docstrings) ; la grammaire ci-dessus
est la seule acceptée, et une accroche mal formée est un échec — jamais un silence. Tant qu'aucune
accroche n'existe, la matrice affiche 0 % : c'est le point de départ, pas une anomalie.

    python3 scripts/controles/couverture.py            # compte rendu
    python3 scripts/controles/couverture.py --update   # régénère le bloc de docs/STATUS.md
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

if __package__ in (None, ""):  # executable standalone: `python3 scripts/controles/couverture.py`
    sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
    from journal import ko, ok
else:
    from .journal import ko, ok

ROOT = Path(__file__).resolve().parent.parent.parent
SRC = ROOT / "src"
STATUS = ROOT / "docs" / "STATUS.md"

BEGIN = "<!-- BEGIN:COUVERTURE -->"
END = "<!-- END:COUVERTURE -->"

# Accroches de couplage, dans les commentaires de src/.
ANCHOR_FORMULA = re.compile(r"^\s*(?:--|/\*-?)?\s*Formule\s+(eq:[\w-]+)\s*:=\s*([\w.]+)", re.M)
ANCHOR_STATEMENT = re.compile(r"^\s*(?:--|/\*-?)?\s*Énoncé\s+(thm:[\w-]+)\s*:=\s*([\w.]+)", re.M)
# re.M is part of the compiled pattern: without it `^` matches only at offset 0, and every anchor
# sitting after a file's first line would be silently skipped — coverage would read 0 % with no error.
ANCHOR_REGLE = re.compile(r"^\s*(?:--|/\*-?)?\s*Regle\s+([A-Za-z][\w{}^.-]*)\s*:=\s*([^\n]+)", re.M)
NAMESPACE = re.compile(r"^\s*namespace\s+K7pl([\w.]*)", re.M)
DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)*(?:theorem|lemma|def|abbrev)\s+([\w.'_-]+)", re.M)


def _strip_comment_markers(text: str) -> str:
    """Comment bodies read like prose; strip the leading `--` so the anchors match either way."""
    return "\n".join(re.sub(r"^\s*--\s?", "", line) for line in text.splitlines())


def lean_units() -> list[tuple[str, str]]:
    """(namespace, code) per Lean unit of `src/` — a namespace and the declarations that follow it.

    A declaration before any namespace belongs to the file's own path (`Main.lean` → `Main`).
    """
    units = []
    for path in sorted(SRC.rglob("*.lean")):
        text = path.read_text(encoding="utf-8")
        default = path.relative_to(SRC).with_suffix("").as_posix().replace("/", ".")
        marks = [(m.start(), m.group(1) or "") for m in NAMESPACE.finditer(text)]
        if not marks:
            units.append((default, text))
            continue
        if marks[0][0] > 0:
            units.append((default, text[: marks[0][0]]))
        for i, (pos, ns) in enumerate(marks):
            end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
            units.append(("K7pl" + ns, text[pos:end]))
    return units


def normative_ids() -> tuple[list[dict], dict]:
    """The three families of normative identifiers, with their counts."""
    import manuscript_metrics as mm

    statements = mm.statements()
    formulas = [
        {"label": lab}
        for _, _, text in _modules()
        for lab in re.findall(r'^::::formula[^\n]*\(label := "(eq:[^"]+)"\)', text, re.M)
    ]
    rules = sorted({a + (b or "") for a, b in re.findall(r"\\textsc\{([A-Za-z]+)\}(\^\{[^}]*\})?\s*\\;?\s*\\frac", _everything())})
    return statements, {"formules": formulas, "regles": rules}


def _modules():
    from controles import corpus

    return corpus.modules()


def _everything():
    from controles import corpus

    return corpus.everything()


def _corpus_available() -> bool:
    try:
        import manuscript_metrics  # noqa: F401
        from controles import corpus  # noqa: F401

        corpus.modules()
        return True
    except Exception:
        return False


def scan() -> dict:
    """The coverage matrix: every normative identifier, covered or not."""
    statements, extra = normative_ids()
    units = lean_units()
    all_lemmas = {name for _, code in units for name in DECL.findall(code)}
    anchored_formulas = set()
    anchored_statements = set()
    malformed = []
    for ns, code in units:
        body = _strip_comment_markers(code)
        for label, lemma in ANCHOR_FORMULA.findall(body):
            anchored_formulas.add(label)
            if lemma not in all_lemmas:
                malformed.append(f"{ns}: « Formule {label} := {lemma} » — {lemma} n'existe pas dans src/")
        for label, lemma in ANCHOR_STATEMENT.findall(body):
            if lemma not in all_lemmas:
                malformed.append(f"{ns}: « Énoncé {label} := {lemma} » — {lemma} n'existe pas dans src/")
            else:
                anchored_statements.add(label)
    # regles: only when the algebra table exists (Regle R := …)
    covered_rules = set()
    for ns, code in units:
        for rule, names in ANCHOR_REGLE.findall(_strip_comment_markers(code)):
            for name in [n.strip() for n in names.split(",") if n.strip()]:
                if name not in all_lemmas:
                    malformed.append(f"{ns}: « Regle {rule} := {name} » — {name} n'existe pas dans src/")
            covered_rules.add(rule)
    return {
        "enonces": statements,
        "formules": extra["formules"],
        "regles": extra["regles"],
        "all_lemmas": all_lemmas,
        "anchored_formulas": anchored_formulas,
        "anchored_statements": anchored_statements,
        "covered_rules": covered_rules,
        "malformed": malformed,
    }


def matrix() -> tuple[str, dict]:
    g = scan()
    st = g["enonces"]
    th = [r for r in st if r["statut"] == "theoreme"]
    ouverts = [r for r in st if r["statut"] in ("proposition", "conjecture", "exigence")]
    fm = g["formules"]
    rg = g["regles"]
    cov_th = sum(1 for r in th if r["label"] in g["anchored_statements"])
    cov_fm = sum(1 for f in fm if f["label"] in g["anchored_formulas"])
    cov_rg = sum(1 for r in rg if r in g["covered_rules"])
    lines = [
        "| Famille normative | Total | Couverts | Taux |",
        "|---|--:|--:|--:|",
        f"| Énoncés `theoreme` (directive `thm`) | {len(th)} | {cov_th} | {100 * cov_th // max(len(th), 1)} % |",
        f"| Énoncés ouverts (proposition, conjecture, exigence) | {len(ouverts)} | {sum(1 for r in ouverts if r['label'] in g['anchored_statements'])} | {100 * sum(1 for r in ouverts if r['label'] in g['anchored_statements']) // max(len(ouverts), 1)} % |",
        f"| Formules numérotées (`::::formula`) | {len(fm)} | {cov_fm} | {100 * cov_fm // max(len(fm), 1)} % |",
        f"| Règles de typage (`\\\\textsc{{R}} \\\\frac{{…}}{{…}}`) | {len(rg)} | {cov_rg} | {100 * cov_rg // max(len(rg), 1)} % |",
    ]
    stats = {
        "theoremes": len(th), "theoremes_couverts": cov_th,
        "ouverts": len(ouverts), "formules": len(fm), "formules_couverts": cov_fm,
        "regles": len(rg), "regles_couverts": cov_rg,
        "accroches": len(g["anchored_formulas"]) + len(g["anchored_statements"]),
        "malformees": g["malformed"],
    }
    return "\n".join(lines), stats


def render_block() -> str:
    table, stats = matrix()
    note = (
        "Une accroche est nulle tant que `src/` ne cite pas encore le manuscrit ; chaque fiche "
        "`IMPL` doit alors joindre une accroche (`Formule eq:… := lemme`, `Énoncé thm:… := lemme`, `Regle … := …`) "
        "et faire monter ce taux."
        if stats["accroches"] == 0
        else "Régénérer : `python3 scripts/controles/couverture.py --update`."
    )
    return "\n".join(
        [
            BEGIN,
            "## Couverture spécification ↔ Lean",
            "",
            "Identifiants normatifs extraits de `spec/` par `scripts/controles/couverture.py`, "
            "rapprochés des accroches de couplage dans les commentaires de `src/`. " + note,
            "",
            table,
            END,
        ]
    )


def update_status() -> None:
    text = STATUS.read_text(encoding="utf-8")
    block = render_block()
    pat = re.compile(re.escape(BEGIN) + r".*?" + re.escape(END), re.S)
    if pat.search(text):
        text = pat.sub(lambda _: block, text)
    else:
        text = text.rstrip("\n") + "\n\n" + block + "\n"
    STATUS.write_text(text, encoding="utf-8")
    print("bloc de couverture mis à jour dans", STATUS.relative_to(ROOT))


def run() -> None:
    """Check entry point (see `scripts/controle.py`): the matrix must be computable and clean."""
    print("\n[Couverture spec ↔ Lean]")
    if not _corpus_available():
        ok("couverture : hors corpus Verso complet (mini-corpus de test), contrôle non conduit")
        return
    _, stats = matrix()
    if stats["malformees"]:
        ko("accroches de couplage mal formées : %s" % stats["malformees"][:4])
        return
    total = stats["theoremes"] + stats["formules"] + stats["regles"]
    ok("couverture : %d identifiants normatifs (%d énoncés-sceaux, %d formules, %d règles), %d accroche(s) de couplage"
       % (total, stats["theoremes"], stats["formules"], stats["regles"], stats["accroches"]))


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--update", action="store_true", help="régénère le bloc de docs/STATUS.md")
    args = parser.parse_args()
    if args.update:
        update_status()
        return 0
    run()
    return 0


if __name__ == "__main__":
    sys.exit(main())
