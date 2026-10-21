<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Positioning against graded and quantitative type systems

**Status:** SKELETON (item 31). **Snapshot:** `main` at `7d522ab`, 2026-10-20.
**Nature:** research working table. It is not normative and makes no claim of its own.

This is a skeleton. Every empty cell is empty on purpose: the column "Difference with K7PL" is
reserved for the owner and is always left empty; the column "Grading structure" is filled only where
the specification states it (no entry of [`references.json`](../bibliography/references.json) carries
an abstract: 0 of 251 entries have an `abstract` field). No external claim was added: every
reference is a key that exists in `docs/bibliography/references.json`, every statement in the table is
a quotation of `spec/` with its file and line, and a system without a key is marked "reference
missing" instead of being cited from memory.

## Conventions

- Paths are relative to `spec/Spec/`; line numbers are those of the snapshot.
- Quotations keep the French and the Verso markup of the source (math as `` $`…` ``, emphasis as `_…_`). `[...]` marks an
  omission, in practice a `{cite …}[]` call or a clause outside the point. A cell that cites a
  passage citing several keys says so.
- "Grading structure" quotes what the specification says about the system's grades. It is not a
  summary of the cited work.

## Table

| System | Reference (bib key) | What the specification says about it | Grading structure | Difference with K7PL |
|---|---|---|---|---|
| Granule | `orchardQuantitativeProgramReasoning2019` (Orchard, Liepelt, Eades III, *Quantitative Program Reasoning with Graded Modal Types*, PACMPL 3 (ICFP), 2019); the specification cites this key for Granule | `C1/AxiomatiqueGerminale.lean:197`: « _le porteur des annotations de grades de ressource_, au sens de _Granule_ » (definition of `\mathcal{G}`).<br>`C1/Postulats.lean:140-142`: « Pile, tas et arènes sont des régimes explicites, choisis par des grades de ressource — au sens de _Granule_ [...] — plutôt que délégués à un mécanisme implicite. »<br>`C3/LeSystemeGradue.lean:24-26`: « Traiter la modalité comme un _grade_ plutôt que comme trois cases disjointes vient de Granule, qui généralise linéarité et affinité à un système modal gradué par un semi-anneau quelconque [...]. K7PL adopte cette gradation en fixant le semi-anneau »<br>`C3/LeSystemeGradue.lean:161-164` (cites `liepeltSameCoeffectDifferent2026`, not this key): « Les grades y sont par ailleurs entrés dans Haskell, Idris et Granule, selon deux lignées distinctes — celle où l'annotation est _pervasive_ et porte sur les types de fonctions, et celle où elle passe par une modalité graduée [...]. Ce document appartient à la seconde. »<br>`C3/LeSystemeGradue.lean:349-351` (also cites `moonGradedModalDependent2021`): « Il vérifie les formes d'introduction contre le grade annoncé, synthétise celui des formes d'élimination, et défère au solveur SMT les contraintes résiduelles sur $`\mathcal{R}`. C'est l'architecture qu'adoptent les systèmes gradués existants »<br>`C3/StructuresOuvertesEffetsEtMetaTheorie.lean:212-215`: « K7PL n'infère pas les grades d'une définition non annotée et ne produit pas de type le plus général, parce qu'aucun système gradué comparable ne le fait. Granule exige la même signature et range inférence et types principaux parmi ses travaux futurs »<br>`C6/LeProcessusDeCompilation.lean:85-90` (also cites `deamorimReallyNaturalLinear2014` and `moonGradedModalDependent2021`): « Cet ordre n'est toutefois que l'une des trois architectures attestées : le typage de DFuzz [...] exécute une passe de style Hindley-Milner puis une procédure de résolution de contraintes, tandis que Granule [...] et la théorie graduée dépendante de Moon et al. [...] procèdent par typage bidirectionnel adossé à un solveur SMT, sans séquentialiser les deux treillis. K7PL retient la première pour la prévisibilité du temps de compilation, non par contrainte algorithmique. » | `C3/LeSystemeGradue.lean:25`: « un système modal gradué par un semi-anneau quelconque » | |
| Quantitative type theory (Atkey) | `atkeySyntaxSemanticsQuantitative2018` (Atkey, *Syntax and Semantics of Quantitative Type Theory*, Symposium on Logic in Computer Science, 2018) | `C1/Postulats.lean:33`: « Combiner suivi d'usage et dépendance impose la discipline du contexte annulé »<br>`C1/Postulats.lean:100-101` (also cites `moonGradedModalDependent2021`): « un indice _clos à la compilation_ est admis, un indice _dépendant d'une valeur d'exécution_ ne l'est pas. K7PL a donc bien des effets indexés, sous leur forme statique, et la réserve ne porte que sur le second cas »<br>`C3/LeSystemeGradue.lean:32-34`: « La formation des types doit s'effectuer dans un contexte dont tous les usages sont annulés, faute de quoi la substitution cesse d'être admissible »<br>`C3/StructuresOuvertesEffetsEtMetaTheorie.lean:284-287`: « Un système quantitatif qui autorise une dépendance de type sur une variable d'usage non nul cesse d'admettre la substitution, et l'échec se produit sur la règle d'application [...]. Le fragment visé ici exclut cette configuration par construction »<br>Without this key, about « la théorie quantitative des types » (`C6/CeQueLeSolveurRetourne.lean:342-353`, cites `HUANG`): « La théorie quantitative des types marque le jugement d'un indicateur binaire — effacé ou présent — de sorte que l'effaçabilité d'une abstraction se lit _sur le jugement_. » (`:343-345`); « la théorie quantitative ne saurait porter les quatre composantes du grade » (`:350`). | Not stated with this key. The specification says, about « la théorie quantitative des types » and citing `HUANG` (`C6/CeQueLeSolveurRetourne.lean:343-344`): « marque le jugement d'un indicateur binaire — effacé ou présent » | |
| Quantitative type theory (McBride) | reference missing: no entry of `references.json` is a McBride paper on quantitative type theory (the McBride entries are `ALLAIS-MCBRIDE`, `allaisTypeScopeSafe2018` and `altenkirchIndexedContainers2015`, on other subjects) | The specification does not mention McBride in connection with quantitative type theory. | | |
| Graded modal dependent type theory (Moon, Eades, Orchard) | `moonGradedModalDependent2021` (Moon, Eades III, Orchard, *Graded Modal Dependent Type Theory*, Programming Languages and Systems, LNCS 12648, 2021) | `C1/Postulats.lean:34`: « les systèmes gradués dépendants portent un vecteur de grades de contexte à côté de celui du sujet »<br>`C1/Postulats.lean:100-101`: see the Atkey row (both keys cited).<br>`C3/LeSystemeGradue.lean:35-36`: « Les théories graduées dépendantes acquittent cette exigence en portant un vecteur de grades de contexte à côté de celui du sujet »<br>`C3/LeSystemeGradue.lean:349-351`: see the Granule row (both keys cited).<br>`C3/StructuresOuvertesEffetsEtMetaTheorie.lean:215-216`, after the Granule sentence quoted in that row: « la théorie graduée dépendante de Moon, Eades III et Orchard procède de même »<br>`C3/StructuresOuvertesEffetsEtMetaTheorie.lean:287-289`: « le cas général relève de la même source et de la théorie des types dépendants gradués [...], et ce document ne le traite pas »<br>`C6/LeProcessusDeCompilation.lean:87-89`: see the Granule row (« la théorie graduée dépendante de Moon et al. »). | `C1/Postulats.lean:34` and `C3/LeSystemeGradue.lean:35-36`: « un vecteur de grades de contexte à côté de celui du sujet » | |
| Graded modal dependent type theory with a universe and erasure (Abel et al.) | `abelGradedModalDependent2023` (Abel, Danielsson, Eriksson, *A Graded Modal Dependent Type Theory with a Universe and Erasure, Formalized*, PACMPL 7 (ICFP), 2023) | `C3/LeSystemeGradue.lean:29-31`: « la décidabilité, elle, n'en dépend pas et s'obtient sur un semi-anneau partiellement ordonné arbitraire, avec normalisation et préservation des grades sous réduction »<br>`C3/LesContraintesDeValeur.lean:59-65`: « Abel, Danielsson et Eriksson [...] établissent que la correction d'une fonction d'extraction n'est acquise que pour une classe restreinte de modalités. Sur les programmes ouverts, trois réserves conjointes s'y ajoutent : toutes les variables du contexte effaçables, contexte cohérent, et filtrage interdit sur un paquet dont le témoin est effacé. Lever cette dernière suffit à perdre la canonicité, contre-exemple à l'appui. K7PL adopte ces trois réserves comme conditions de sa propre garantie d'effacement » | `C3/LeSystemeGradue.lean:30-31`: « un semi-anneau partiellement ordonné arbitraire » | |

## Other keys that the owner may add as rows

These graded or quantitative works are present in `references.json` and cited in `spec/`; they are
listed by key and title only, and were not examined for this skeleton:
`erikssonGradedModalType2025` (*Graded Modal Type Theory, Formalized*),
`choudhuryGradedDependentType2021` (*A Graded Dependent Type System with a Usage-Aware Semantics*),
`liepeltSameCoeffectDifferent2026` (*Same Coeffect, Different Base: Connecting Two Dominant Approaches
to Graded Types*), `hanukaevUnificationGradedSubstructural2026` (*A Unification of Graded and
Substructural Logics*), `vollmerMixedLinearGraded2024` (*A Mixed Linear and Graded Logic: Proofs,
Terms, and Models*), `brunelCoreQuantitativeCoeffect2014` (*A Core Quantitative Coeffect Calculus*),
`ghicaBoundedLinearTypes2014` (*Bounded Linear Types in a Resource Semiring*),
`gaboardiCombiningEffectsCoeffects2016` (*Combining Effects and Coeffects via Grading*),
`deamorimReallyNaturalLinear2014` (*Really Natural Linear Indexed Type Checking*, the DFuzz source of
the C6 quotation above) and `HUANG` (*QTAL: A Quantitatively and Dependently Typed Assembly
Language*).

`docs/research/corpus.md` holds working reading notes for the four keys of the table (sections
`### orchardQuantitativeProgramReasoning2019`, `### atkeySyntaxSemanticsQuantitative2018`,
`### moonGradedModalDependent2021`, `### abelGradedModalDependent2023`). They are neither the
specification nor an abstract, so they were not used to fill the table.

## Reading questions noticed while collecting the quotations

These are observations on the specification text, for the owner. They are interpretations, not
findings of fact, and nothing was changed.

1. `C6/LeProcessusDeCompilation.lean:85-90` announces « l'une des trois architectures attestées » and
   names two (DFuzz; Granule together with Moon et al.), then says « K7PL retient la première ». The
   same section at `:73-77` says the compiler « procède bidirectionnellement », and
   `C3/LeSystemeGradue.lean:348-353` calls the bidirectional architecture the one « qu'adoptent les
   systèmes gradués existants ». Which architecture « la première » designates is not settled by the
   text.
2. `C1/Postulats.lean:33-35` cites the context-annulment discipline (Atkey) and the dependent graded
   systems (Moon et al.), then says « Aucun ne gradue. ». The verb seems to refer to the « échelle »
   of `:24`; next to a citation of graded systems, a reader may take it as "none of them is graded".

## Remaining actions

| Action | Owner | Status |
|---|---|---|
| Fill the column "Difference with K7PL" | owner | HUMAN ACTION REQUIRED |
| Decide whether McBride's quantitative type theory needs a bibliography entry, and add it with a verified source if so | owner | HUMAN ACTION REQUIRED |
| Decide which further keys (list above) become rows | owner | HUMAN ACTION REQUIRED |
| Answer the two reading questions | owner | HUMAN ACTION REQUIRED |
