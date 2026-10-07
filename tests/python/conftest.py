# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Fixtures for the Python tooling tests: a mini Verso corpus, isolated from `spec/`.

The checks under `scripts/controles/` read the whole manuscript through two module-level
attributes — `manuscript_metrics.SPEC` (where the sources live) and `controles.corpus.SPEC`
(the cached view). The fixtures below repoint both at a small synthetic corpus built in
`tmp_path`, so a test can mutate one seal, one label or one rule and watch the checks react.
A check that never fails on a mutation is worth nothing — see the dashboard's own motto.
"""

from __future__ import annotations

import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

CHAPTER_HEADER = """-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import VersoManual
open Verso.Genre Manual

#doc (Manual) "{TITLE}" =>
%%%
authors := ["Test"]
file := "{FILE}"
%%%

{{label "sec:{SEC}"}}

{{num "sec:{SEC}"}}[]
"""


def header(title: str, file: str, sec: str) -> str:
    """One chapter/section source. Doubled braces: this template runs through `.format()`,
    but the Verso directives inside must survive as literal `{num …}` markers."""
    return CHAPTER_HEADER.format(TITLE=title, FILE=file, SEC=sec)


C1_BODY = """Le cadre pose $`\\omega`` les conventions.

{label "sec:c1"}

{{num "sec:c1-guide"}}[]

::::k7table (label := "tab:c1-symboles")
```
| Symbole | Sens |
| $`\\Delta`$ | contexte du jugement |
| $`\\Gamma`$ | contexte catégorique |
| $`\\mathcal{R}`$ | ressources |
| $`\\mathcal{X}`$ | échappatoires |
| $`!_r`$ | modalité de ressource |
| $`\\varphi_r`$ | transport d'effet |
| $`\\boxtimes`$ | produit des effets |
```
::::
"""

GUIDE_BODY = """Le guide route chaque engagement : littérature, démonstration ou mesure.

{label "sec:c1-guide"}

::::k7table (label := "tab:engagements")
```
| Engagement | Énoncé | Route attendue | Route |
| * Un test * | * ce que l'on promet * | * par où passer * | * littérature * |
```
::::
"""

C2_BODY = """Un jugement $`\\Delta \\vdash t : T`$. La modalité de ressource s'écrit $`!_r`$.

::::thm (label := "thm:exemple") (status := "theoreme")
:::title
exemple de théorème
:::

:::statement +titled
Enoncé d'exemple

Le texte de l'énoncé, avec un renvoi {num "eq:pilote"}[].
:::

:::proofsketch
Croquis de preuve.
:::
::::

::::formula (label := "eq:pilote")
```
\\textsc{Var}\\;\\frac{\\;}{\\;\\mathbf{0}\\cdot\\Delta,\\, x :_{1} V \\;\\vdash\\; x : V\\;}
```
::::

La loi d'action est le /résidu/ de l'addition, restreinte aux usages finis ($`u \\neq \\omega`$).
Les quatre égalités : $`0 \\cdot \\omega`$, $`\\omega \\cdot 0`$, $`\\omega + \\omega`$, $`\\omega \\cdot \\omega`$.
Les sortes de tailles : $`\\mathbb{S}_\\mu \\;=\\; \\mathbb{N}_\\infty \\setminus \\{\\omega\\}`$
et $`\\mathbb{S}_\\nu \\;=\\; \\mathbb{N}_\\infty`$.
Il y a une règle de typage Var :

::::formula (label := "eq:grammaire-termes")
```
\\begin{align*}
v &::= x \\mid () \\mid (v, v) \\mid \\mathsf{box}_r\\,v \\\\
c &::= \\lambda x. c \\mid c\\,v \\mid \\mathsf{return}\\;v
\\end{align*}
```
::::

La règle Var conclut $`\\Delta, x : V \\vdash x : V`$ :

\\textsc{Var}\\;\\frac{\\;x \\in \\Delta\\;}{\\;\\Delta \\vdash x : V\\;}
"""

# The checks read the manuscript through `corpus.modules()`, which walks the include tree from
# Spec.lean, and several of them reach for hard-coded module names (C2.Algebre, C3, C4,
# C1.GuideDeLecture, Refs.ListeDesGlosses). The mini-corpus mirrors that skeleton — same names,
# minimal content — so every check can run here exactly as it does on the real corpus.
SKELETON = {
    "Spec/C1/GuideDeLecture.lean": ("GUIDE DE LECTURE", "c1-guide",
                                    "Le guide route chaque engagement : littérature, démonstration ou mesure.\n"),
    "Spec/C2/Algebre.lean": ("ALGÈBRE DES RESSOURCES", "c2-algebre",
                             "Chapitre-test pour les contrôles qui exploitent le corpus complet.\n\n"
                             '::::formula (label := "eq:grammaire-types")\n```\n'
                             "V ::= \\mathbf{1} \\mid \\mathsf{Box}\\,_r\\,V \\mid V \\otimes V\n```\n::::\n"),
    "Spec/C3.lean": ("DYNAMIQUE", "c3",
                     "La dynamique : $`\\omega + \\omega`$ sert de coût infini.\n\n"
                             "$`\\mathbb{S}_\\nu \\;=\\; \\mathbb{N}_\\infty`$\n"),
    "Spec/C4.lean": ("RESSOURCES", "c4",
                     "Les ressources : les flux portés par la sorte $`\\mathbb{S}_\\nu`$.\n"),
    "Spec/Refs/ListeDesGlosses.lean": ("GLOSSAIRE", "glosses",
                                       ": couche 1\n\n  Le langage.\n\n: couche 2\n\n  La dynamique.\n\n: couche 3\n\n  Les ressources.\n"),
}


def leaf(rel: str, title: str, sec: str, body: str) -> str:
    """One module file: the standard header plus its body."""
    return header(title, Path(rel).stem.lower(), sec) + body


def mutate(corpus, rel, old, new):
    """Apply a textual mutation to one file of the mini-corpus (the "muté" half of the tests)."""
    f = corpus / rel
    text = f.read_text(encoding="utf-8")
    assert old in text, f"mutation cible introuvable dans {rel}"
    f.write_text(text.replace(old, new), encoding="utf-8")


@pytest.fixture
def corpus(tmp_path):
    """A mini-corpus mirroring the real include skeleton: C1 (+ guide), C2 (+ two sections),
    C3, C4 and the glossary — enough for every check under `controles/` to run."""
    spec = tmp_path / "spec"

    def write(rel: str, text: str):
        f = spec / rel
        f.parent.mkdir(parents=True, exist_ok=True)
        f.write_text(text, encoding="utf-8")

    write("Spec.lean",
          '#doc (Manual) "MINI" =>\n%%%\nauthors := ["Test"]\n%%%\n\n'
          "{include 0 Spec.C1}\n\n{include 0 Spec.C2}\n\n{include 0 Spec.C3}\n\n"
          "{include 0 Spec.C4}\n\n{include 0 Spec.Refs.ListeDesGlosses}\n")
    # Chapter-level files carry their own `{label}` (as in the real corpus).
    write("Spec/C1.lean",
          header("CADRE", "c1", "c1") + "Le cadre pose $`\\omega`` les conventions.\n\n"
          "{include 0 Spec.C1.GuideDeLecture}\n")
    write("Spec/C2.lean",
          header("FONDEMENTS", "c2", "c2") + "{include 0 Spec.C2.Fondements}\n\n"
          "{include 0 Spec.C2.Algebre}\n")
    write("Spec/C2/Fondements.lean",
          leaf("Spec/C2/Fondements.lean", "FONDEMENTS", "c2-fondements", C2_BODY))
    for rel, (title, sec, body) in SKELETON.items():
        write(rel, leaf(rel, title, sec, body))
    return spec


@pytest.fixture
def primitives(corpus, monkeypatch):
    """A stub `docs/tracking/primitives.md` beside the mini-corpus, declaring the Var rule.

    The croisée check reads that file through `corpus.SPEC.parent`, so pointing SPEC at the
    tmp corpus and writing the stub next to it is enough for the three-way cross-check.
    """
    doc = corpus.parent / "docs" / "suivi" / "primitives.md"
    doc.parent.mkdir(parents=True, exist_ok=True)
    doc.write_text("REGLE: Var\n", encoding="utf-8")
    return doc


@pytest.fixture
def patched(corpus, monkeypatch):
    """Point every reader of the corpus at the mini-corpus, with a fresh cache each time."""
    import manuscript_metrics as mm
    from controles import corpus as cp

    monkeypatch.setattr(mm, "SPEC", corpus)
    monkeypatch.setattr(cp, "SPEC", corpus)
    cp.modules.cache_clear()
    yield corpus
    cp.modules.cache_clear()


@pytest.fixture(autouse=True)
def clean_journal():
    """Each test starts from an empty verdict log and leaves it empty."""
    from controles import journal

    journal.failures.clear()
    journal.github = False
    yield
    journal.failures.clear()


@pytest.fixture
def real_lean(monkeypatch):
    """Point the coverage control's `SRC` at the repository's real `src/`.

    The anchor grammar is only exercised against synthetic files in unit tests; this fixture lets
    a regression test run the *whole* scan over the actual Lean sources, which is where a silent
    parser mismatch (anchors present but never matched) would otherwise hide forever.
    """
    from controles import couverture

    monkeypatch.setattr(couverture, "SRC", ROOT / "src")
    return couverture
