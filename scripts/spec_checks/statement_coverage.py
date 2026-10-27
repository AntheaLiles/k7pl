# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Couverture spec ↔ Lean : la matrice des identifiants normatifs.

Le manuscrit pose des énoncés (`::::thm`), nomme des formules (`::::formula`) et écrit des règles
de typage (`\\textsc{R} \\frac{…}{…}`) : ce sont les **identifiants normatifs** du projet. Chacun
d'eux est une dette de vérification tant qu'aucune preuve Lean ne le rejoint. Cette matrice
extrait les identifiants de `spec/`, cherche dans `src/` les accroches de couplage, et publie le
résultat dans `wiki/STATUS.md` (bloc délimité, régénéré par la CI) :

* `Formule N := M` — la formule d'étiquette `N` est l'énoncé formalisé par le lemme `M` ;
* `Énoncé thm:N := M` — le lemme `M` est déclaré comme formalisation de l'énoncé `thm:N` ;
* `Regle R := M1, M2` — la règle de typage `R` est couverte par les constructions `M1, M2` de
  l'algèbre formalisée (`src/K7pl/Algebre.lean`) ;

Les accroches vivent dans les commentaires de `src/` (anglais, docstrings) ; la grammaire ci-dessus
est la seule acceptée, et une accroche mal formée est un échec — jamais un silence. Tant qu'aucune
accroche n'existe, la matrice affiche 0 % : c'est le point de départ, pas une anomalie.

    python3 scripts/spec_checks/statement_coverage.py            # compte rendu
    python3 scripts/spec_checks/statement_coverage.py --update   # régénère le bloc de wiki/STATUS.md
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

if __package__ in (None, ""):  # executable standalone: `python3 scripts/spec_checks/statement_coverage.py`
    sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
    from journal import ko, ok
else:
    from .journal import ko, ok

ROOT = Path(__file__).resolve().parent.parent.parent
SRC = ROOT / "src"
STATUS = ROOT / "wiki" / "STATUS.md"

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

# Statement families of the matrix, selected on the C8 fields of `manuscript_metrics.statements()`
# (`kind`, `role`), never on the historical `statut`: since the C8 directive migration that field
# holds `role or kind`, so the historical values (`theoreme`, `exigence`) no longer occur and a
# filter on them silently reads zero. The split follows the ratified C8 result roles
# (docs/tracking/DECISIONS.md, C8 taxonomy decision 2): theorem, lemma, corollary and proposition
# are the four expository roles of a result put forward as established, conjecture is the role of
# a result that is not. Hence:
# * theorem-like: a `result` whose role is `theorem`, `lemma`, `corollary` or `proposition`;
# * conjectures and requirements: a `result` whose role is `conjecture`, and every `requirement`;
# * neither: definitions, literature, assumptions, examples and counterexamples.
# The epistemic `state` is not used: role and state are independent (decision 3), and a family
# must not read as a verdict on truth.
THEOREM_LIKE_ROLES = frozenset({"theorem", "lemma", "corollary", "proposition"})
OPEN_RESULT_ROLES = frozenset({"conjecture"})
OPEN_KINDS = frozenset({"requirement"})


def statement_family(row: dict) -> str | None:
    """Family of one statement row: `"theoremes"`, `"ouverts"`, or None for neither."""
    if row["kind"] == "result" and row["role"] in THEOREM_LIKE_ROLES:
        return "theoremes"
    if (row["kind"] == "result" and row["role"] in OPEN_RESULT_ROLES) or row["kind"] in OPEN_KINDS:
        return "ouverts"
    return None


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
    from spec_checks import corpus

    return corpus.modules()


def _everything():
    from spec_checks import corpus

    return corpus.everything()


def _corpus_available() -> bool:
    try:
        import manuscript_metrics  # noqa: F401
        from spec_checks import corpus  # noqa: F401

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


def _row(family: str, total: int, linked: int) -> str:
    return f"| {family} | {total} | {linked} | {100 * linked // max(total, 1)} % |"


def matrix() -> tuple[str, dict]:
    # The rendered strings stay in French, like the rest of the generated block of wiki/STATUS.md.
    g = scan()
    st = g["enonces"]
    th = [r for r in st if statement_family(r) == "theoremes"]
    ouverts = [r for r in st if statement_family(r) == "ouverts"]
    fm = g["formules"]
    rg = g["regles"]
    cov_th = sum(1 for r in th if r["label"] in g["anchored_statements"])
    cov_ou = sum(1 for r in ouverts if r["label"] in g["anchored_statements"])
    cov_fm = sum(1 for f in fm if f["label"] in g["anchored_formulas"])
    cov_rg = sum(1 for r in rg if r in g["covered_rules"])
    lines = [
        "| Famille normative | Total | Liens déclarés | Part liée |",
        "|---|--:|--:|--:|",
        _row("Énoncés `theorem`, `lemma`, `corollary`, `proposition`", len(th), cov_th),
        _row("Énoncés `conjecture` et exigences (`requirement`)", len(ouverts), cov_ou),
        _row("Formules numérotées (`::::formula`)", len(fm), cov_fm),
        _row("Règles de typage (`\\\\textsc{R} \\\\frac{…}{…}`)", len(rg), cov_rg),
    ]
    stats = {
        "theoremes": len(th), "theoremes_couverts": cov_th,
        "ouverts": len(ouverts), "ouverts_couverts": cov_ou,
        "hors_familles": len(st) - len(th) - len(ouverts),
        "formules": len(fm), "formules_couverts": cov_fm,
        "regles": len(rg), "regles_couverts": cov_rg,
        "accroches": len(g["anchored_formulas"]) + len(g["anchored_statements"]) + len(g["covered_rules"]),
        "malformees": g["malformed"],
    }
    return "\n".join(lines), stats


def render_block() -> str:
    table, stats = matrix()
    note = (
        "Aucun lien n'est encore déclaré : chaque fiche `IMPL` doit joindre une accroche."
        if stats["accroches"] == 0
        else "Régénérer : `python3 scripts/spec_checks/statement_coverage.py --update`."
    )
    return "\n".join(
        [
            BEGIN,
            "## Liens déclarés spécification ↔ Lean",
            "",
            "Identifiants normatifs extraits de `spec/` par `scripts/spec_checks/statement_coverage.py`, "
            "rapprochés des accroches de couplage déclarées dans les commentaires de `src/` "
            "(`Formule eq:… := lemme`, `Énoncé thm:… := lemme`, `Regle … := …`). Un lien déclaré est "
            "une accroche lexicale vers une déclaration de `src/` : il n'atteste ni que cette déclaration "
            "formalise l'identifiant, ni qu'elle le prouve ; ce tableau ne mesure pas une couverture par "
            "la preuve. " + note,
            "",
            "Les énoncés sont répartis selon leur nature et leur rôle (taxonomie C8), non selon leur état "
            f"épistémique ; {stats['hors_familles']} énoncé(s) d'une autre nature (définition, littérature, "
            "axiome, postulat, hypothèse, exemple, contre-exemple) ne relèvent d'aucune des deux familles.",
            "",
            table,
            END,
        ]
    )


def update_status(status_path: Path | None = None) -> None:
    target = status_path or STATUS
    text = target.read_text(encoding="utf-8")
    block = render_block()
    pat = re.compile(re.escape(BEGIN) + r".*?" + re.escape(END), re.S)
    if pat.search(text):
        text = pat.sub(lambda _: block, text)
    else:
        text = text.rstrip("\n") + "\n\n" + block + "\n"
    target.write_text(text, encoding="utf-8")
    print("bloc de couverture mis à jour dans", target.relative_to(ROOT) if target.is_relative_to(ROOT) else target)


def run() -> None:
    """Check entry point (see `scripts/check_spec.py`): the matrix must be computable and clean."""
    print("\n[Couverture spec ↔ Lean]")
    if not _corpus_available():
        ok("couverture : hors corpus Verso complet (mini-corpus de test), contrôle non conduit")
        return
    _, stats = matrix()
    if stats["malformees"]:
        ko("accroches de couplage mal formées : %s" % stats["malformees"][:4])
        return
    total = stats["theoremes"] + stats["ouverts"] + stats["formules"] + stats["regles"]
    ok("couverture : %d identifiants normatifs (%d énoncés theorem/lemma/corollary/proposition, "
       "%d conjectures et exigences, %d formules, %d règles), %d accroche(s) de couplage"
       % (total, stats["theoremes"], stats["ouverts"], stats["formules"], stats["regles"], stats["accroches"]))


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--update", action="store_true", help="régénère le bloc de wiki/STATUS.md")
    args = parser.parse_args()
    if args.update:
        update_status()
        return 0
    run()
    return 0


if __name__ == "__main__":
    sys.exit(main())
