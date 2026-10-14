<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Reprise sélective de l'archive PR #10 (`d39d012`)

**État :** IN PROGRESS
**Décision d'origine :** option C, retenue par l'autrice le 13 octobre 2026 : reprise sélective, note par note, dans un lot de `docs/migration/`.
**Source :** branche `valuable/claude/lean4-reuse-init-qvzlcg`, commit `d39d012ea77277bfd774f67985966fb6ba7340cf` (PR #10, fermée sans fusion).
**Révision de base examinée :** `main`, SHA `99a7375e764e86b3c19c19be82accd8db6096a91` ; aucun fichier cité ne change jusqu'à `06f8466`.
**Revue préalable :** [`BRANCHES-STATUS.md`](../tracking/BRANCHES-STATUS.md), section 5 (quatre lots, 126 lignes classées).
**Limite épistémique :** qualification de migration. Ce lot n'est ni une preuve, ni une ratification, ni une modification de `spec/`.

## 1. Règles de la reprise

1. Aucune modification normative de `spec/` sans mandat explicite, point par point. Les rédactions normatives de l'archive deviennent des **propositions** (§ 6), non appliquées.
2. Aucune note n'est une preuve ni une ratification. Les décisions que l'archive attribue à l'autrice sont traitées dans [`DECISIONS.md`](../tracking/DECISIONS.md), pas ici.
3. Les contenus non normatifs utiles peuvent être versés dans `main` à l'endroit vivant adapté, avec provenance et bandeau de statut (§ 4).
4. Les numéros de séance 21 à 33 de l'archive entrent en collision avec la série `docs/history/2026-10-07-pr-02-21…62` de `main` ; tout versement de compte rendu exige un nom de série distinct.
5. Les chemins d'avant la migration (`docs/journal/`, `docs/recherche/`, `docs/suivi/`, `biblio/references.json`) sont refusés par `scripts/ci/check_documentation_architecture.py` hors de `docs/history/`, `docs/archives/` et `docs/migration/`, même dans une URL. Les permaliens vers l'archive ne figurent donc que dans ce lot ou dans `docs/history/`.

**Catégories.** VERSÉ (pièce historique ou de recherche, avec bandeau) · EXTRAIT (partie reprise) · OBLIGATION (obligation non normative rattachée à un objet C ou à une étape) · PROPOSITION (rédaction normative soumise à mandat) · ÉCARTÉ (motif donné).

## 2. Provenance et accès

Chaque pièce est citée par son permalien `https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/<chemin>`, noté ⟨chemin⟩ ci-dessous. Ces permaliens dépendent de la conservation de la branche `valuable/…` ou d'un tag d'archive (décision en attente). Les numéros de ligne de l'archive renvoient à `d39d012` ; ceux de `main` à la révision de base.

Abréviations : DEC = `docs/tracking/DECISIONS.md` ; CSV = `docs/tracking/fiches-statuts.csv` ; LSM = `docs/tracking/LEAN-STATEMENT-MIGRATION.md` ; PMP = `docs/tracking/PROJECT-MASTER-PLAN.md` ; INS = [instruction C des constats de l'archive](L1-C-ARCHIVE-FINDINGS-INSTRUCTION-2026-10-14.md).

## 3. Table de décision, pièce par pièce

### 3.1 Comptes rendus 21 à 33 (`docs/journal/`)

Sort commun : **non versés dans ce lot**. Le versement des treize comptes rendus dans `docs/history/` correspond à l'option A, que l'autrice n'a pas retenue ; il reste une décision séparée (DEC, « Archive PR #10 : versement des comptes rendus »). Leur contenu est routé ci-dessous, chaque pièce étant citée par permalien.

| Séance | Pièce | Contenu routé | Constat sur `main` |
|---|---|---|---|
| 21 | [⟨docs/journal/2026-10-05-pr-02-21-struct-et-facts.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-05-pr-02-21-struct-et-facts.md) | O-20, P-17 | déclare traités STRUCT-15/19/20/21, FACT-11/18, BLOQ-08 ; CSV l. 9, 30, 34-36 les gardent ouverts ou partiels |
| 22 | [⟨…-22-preuves-fin.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-05-pr-02-22-preuves-fin.md) | P-16 | « PREUVE-09/15 closes », « PREUVE-04 prouvée » : contredit par LSM l. 77, 175, 235 |
| 23 | [⟨…-23-reprises-et-suivi.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-05-pr-02-23-reprises-et-suivi.md) | O-24 | non scientifique ; contrôles de structure absents de `main` |
| 24 | [⟨…-24-loi-distributive.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-24-loi-distributive.md) | O-01, P-01 | instruit : INS § 1 |
| 25 | [⟨…-25-trans.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-25-trans.md) | P-17 | TRANS-02 dépassé (décision C-01 du 11 octobre) ; TRANS-03 : CSV l. 115 |
| 26 | [⟨…-26-arene.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-26-arene.md) | — | dépassé : la voie retenue correspond à la voie (b) de H1, non ratifiée (DEC, ligne H1) ; CSV l. 10, 67 |
| 27 | [⟨…-27-coercions-produit.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-27-coercions-produit.md) | O-21 | dépassé (`ReglesDeTypage.lean`, l. 437-439 ; DEC, `thm:relation_produit`) |
| 28 | [⟨…-28-troncature-et-conformite.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-28-troncature-et-conformite.md) | P-10, P-19, V-06 | troncature déjà dans `main` (`AlgebresCoalgebresEtPointsFixes.lean`, l. 567-619, via `5fa5634`) ; FACT-07 instruit : INS § 2 |
| 29 | [⟨…-29-anom-17-et-preuve-03.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-29-anom-17-et-preuve-03.md) | O-02, O-27, P-02, P-09, P-10 | instruit : INS §§ 3 et 4 |
| 30 | [⟨…-30-arbitrages-deja-pris.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-30-arbitrages-deja-pris.md) | — | décisions « retenues » alléguées : DEC ; D-7 y est rangée parmi les entrées **non** arbitrées (l. 47-48), contrairement au README de l'archive |
| 31 | [⟨…-31-orientations-appliquees.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-31-orientations-appliquees.md) | P-11, P-12, P-14, P-18, P-22 | sa table « Modifications du manuscrit » décrit des changements **absents de `main`** |
| 32 | [⟨…-32-redactions-de-l-auteur.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-32-redactions-de-l-auteur.md) | P-04, P-05, P-14, P-15, V-07 | citations attribuées à l'autrice (l. 17, 79, 111, 154) : DEC ; ANOM-09 dépassée (DEC, « Index PDF ») |
| 33 | [⟨docs/journal/2026-10-07-pr-02-33-sources-des-singularites.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-07-pr-02-33-sources-des-singularites.md) | P-14, O-15 | instruit : INS § 6 ; `docs/research/sources-singularites.md` est déjà dans `main` |

### 3.2 Notes `docs/recherche/analyses-decisions/`

Aucune n'est versée en entier.

| Pièce | Sort | Destination | Motif |
|---|---|---|---|
| [⟨README.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/README.md) | ÉCARTÉ | — | § 5 traité dans DEC ; § 4 suivi par `FICHES-PR02.md` et `docs/bibliography/verifications-pr02.md` ; bandeau faux (PR fermée sans fusion) |
| [⟨00-index-design.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/00-index-design.md) | EXTRAIT | O-03, O-05, O-06, O-12 | constats transversaux (l. 35-41) ; recommandations écartées (régression `504739d` inaccessible) |
| [⟨00-index-ratifications.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/00-index-ratifications.md) | EXTRAIT | O-16, O-17, O-19, P-05, P-11 | cinq questions de modèle requalifiées (Q1 dépassée : porteur de l'usage `WithTop ℚ≥0` ; Q2 relève de D) ; verdicts R/N écartés |
| [⟨01-parallele-et-vmap.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/01-parallele-et-vmap.md) | OBLIGATION (E, FUTURE) | O-03, O-04, O-05 | grille V0-V7 et formulations du § 7 : matériau E, visent `eq:reductions-orientees`, absent de `main` |
| [⟨02-spawn-et-fil-de-temps.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/02-spawn-et-fil-de-temps.md) | OBLIGATION (F, C-07) | O-07, P-06 | instruit : INS § 5 ; table O1a-O4c et clause O1b : matériau F |
| [⟨03-anom-18-facteur-temporel.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/03-anom-18-facteur-temporel.md) | OBLIGATION (C-01, C-05) | O-06 | forme de `κ` déjà dans `main` (`GrammaireDesTypes.lean`, l. 109-118) ; Q1-Q2 dépassées par D-17 ; reste : INS § 5 |
| [⟨04-singularites-comp-et-delta.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/04-singularites-comp-et-delta.md) | EXTRAIT (D, FUTURE) | O-10, P-14 | options A-E, tableau d'impacts, calculs reproduits : INS § 6 ; D bloquée (PMP) |
| [⟨05-sceaux-progres-preservation.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/05-sceaux-progres-preservation.md) | OBLIGATION (C8) | O-11, O-29, P-20 | sceaux remplacés par la classification C8.0 (rôle et état séparés) |
| [⟨06-formes-temporelles-declassify-at-move.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/06-formes-temporelles-declassify-at-move.md) | OBLIGATION (C-06, C-07, G2) | O-08, O-09, O-10, P-05 | lecture T-A dépassée par P3-B |
| [⟨07-arb-pr-04-rejeu-binaire.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/07-arb-pr-04-rejeu-binaire.md) | OBLIGATION (C-08, G1) | O-13, O-14, P-11 | le reste est dépassé (ARB-PR-04 reformulé, DEC) |
| [⟨ratifications-anom-17.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-anom-17.md) | OBLIGATION ; verdicts ÉCARTÉS | O-18, O-19, P-02, P-03, P-07, P-08, P-22 | D-7 contredit par DEC ; ANOM-09 dépassée |
| [⟨ratifications-effets-et-fermetures.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-effets-et-fermetures.md) | EXTRAIT (G1) | O-22, P-01, P-13, V-07 | sept fermetures déduites : matériau G1, à revérifier (CSV l. 46, 54, 137, 141, 142, 146, 160) |
| [⟨ratifications-grades-et-cadre.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-grades-et-cadre.md) | en partie ÉCARTÉ | O-01, P-01, P-18 | STRUCT-16 dépassé par D-16 ; TRANS-02, FACT-12, STRUCT-01 dépassés |
| [⟨ratifications-numerique-et-execution.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-numerique-et-execution.md) | EXTRAIT (D, FUTURE) | O-23, P-11, P-12 | bandeau faux écarté |
| [⟨ratifications-pipeline-et-preuves.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-pipeline-et-preuves.md) | PROPOSITION | O-16, O-17, P-15, P-16 | — |
| [⟨t68-vocabulaire-face-au-manuscrit.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/t68-vocabulaire-face-au-manuscrit.md) | EXTRAIT (G2) | V-05, O-25, O-26 | essai à blanc (comptes faux sur `main`) et plan « en bloc » (décision alléguée) écartés |

### 3.3 Études et notes de `docs/recherche/`

| Pièce | Sort | Destination | Motif |
|---|---|---|---|
| [⟨etude-parallele-fourche-entrelacement.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/etude-parallele-fourche-entrelacement.md) | VERSÉ (prévu) | V-02 | matériau E ; ses « faits vérifiés » portent sur `d39d012` |
| [⟨etude-spawn-fil-de-temps.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/etude-spawn-fil-de-temps.md) | VERSÉ (prévu) | V-03 | matériau F et C-07 ; présuppose `eq:traduction-fils`, `thm:chaine_fils`, absents de `main` |
| [⟨instruction-des-decisions.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/instruction-des-decisions.md) | OBLIGATION, non versée | O-01, O-02, O-08, P-04, P-05, P-07, P-08, P-12, P-22 | instruit : INS §§ 1, 3, 4 ; en-tête « orientations appliquées » : décisions alléguées (DEC) |
| [⟨t68-vocabulaire-en-bloc.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/t68-vocabulaire-en-bloc.md) | EXTRAIT (G2) | V-05 | registres K/N/S, règles R-K/R-N, table de 49 lignes (base `d39d012`), collisions ; décision « en bloc » alléguée (DEC) |

### 3.4 Pièces T-68 et scripts

| Pièce | Sort | Motif |
|---|---|---|
| [⟨docs/suivi/t68-renommage.csv⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/suivi/t68-renommage.csv) | ÉCARTÉ | comptes faux sur `main` ; les six correspondances K sont reprises par V-05 |
| [⟨docs/suivi/t68-table-de-renommage.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/suivi/t68-table-de-renommage.md) | ÉCARTÉ | chemin refusé, comptes faux ; la prose à relire est couverte par V-05 |
| [⟨scripts/t68_renommer.py⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/scripts/t68_renommer.py) | ÉCARTÉ | lit `docs/suivi/` ; avec `--appliquer`, réécrirait `spec/` selon un vocabulaire non ratifié |
| [⟨scripts/controles/vocabulaire.py⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/scripts/controles/vocabulaire.py) | ÉCARTÉ ; proposition de contrôle G2 (FUTURE) | non branché ; échouerait sur `main` (`Nxt`, `Loc`, `Declassify` sans règle face aux 46 de `scripts/controles/croise.py`) |

## 4. Versements non normatifs

| Id | Contenu | Cible | État |
|---|---|---|---|
| V-02 | étude `∥` (300 lignes) | `docs/research/2026-10-06-etude-parallele-fourche-entrelacement.md` | PREPARED : bandeau, `biblio/references.json` → `docs/bibliography/references.json`, liens réécrits |
| V-03 | étude `spawn` (291 lignes) | `docs/research/2026-10-06-etude-spawn-fil-de-temps.md` | PREPARED : idem, plus `docs/research/corpus.md` |
| V-05 | note T-68 (extraits) | `docs/research/t68-vocabulaire-proposition-archive-pr10.md` | PREPARED après annotation : citations à relire sur `main` |
| V-06 | relevés BIB 3 à 5 de `docs/bibliographie/verifications-pr02.md` | `docs/bibliography/verifications-pr02-archive-pr10.md` | PREPARED après annotation : « texte corrigé » faux sur `main` (`1/0 = ⊥` subsiste), BIB-17 dite fermée alors que CSV l. 179 la garde ouverte |
| V-07 | `docs/suivi/codes-et-premisses.md` | `docs/research/codes-et-premisses-archive-pr10.md` | PREPARED après annotation : numéros de phase de l'archive (0 à 10), garde absente de `main` |

Ces versements feront l'objet d'une PR distincte, après relecture de chaque pièce. Dans `docs/research/` et `docs/bibliography/`, aucune chaîne d'ancien chemin, même dans une URL : la provenance exacte reste dans ce lot. **V-01** (versement des treize comptes rendus dans `docs/history/`) n'est pas prévu : voir § 3.1.

## 5. Obligations (non normatives)

Numérotation de travail ; O-28 n'est pas attribuée. Les obligations déjà instruites renvoient à l'instruction C, qui les détaille.

| Id | Objet ou étape | Obligation | État |
|---|---|---|---|
| O-01 | C-01, C-03, C-06 | commutativité de `ℰ`, multiplicativité de `φ_n`, cas ω | instruite : INS § 1 |
| O-02 | C-04, C-07 | réduction des formes temporelles sur terme clos | instruite : INS § 3 |
| O-03 | E | « couche 3 » stricte ou chronométrée (`AxiomatiqueGerminale.lean`, l. 788-790, contre `ReglesDeTypage.lean`, l. 1323-1326) | FUTURE |
| O-04 | C-08 | `Par` employée avec des capacités linéaires (`ModelesDeMemoire.lean`, l. 49-51) | ouverte |
| O-05 | E | le progrès de `∥` exige la terminaison des branches (`ReglesDeTypage.lean`, l. 1338-1343) | FUTURE |
| O-06 | C-01, C-05 | `w`, `s`, `δ_ℓ`, `ℓ̂`, couplage `Spawn`/`Send`/`Move` | instruite : INS § 5 |
| O-07 | F | niveau de l'événement `spawn` | FUTURE |
| O-08 | C-06, C-07 | `@_nε`, `loc(Δ)`, `Ser(V)` et le coût `c` non définis (`ReglesDeTypage.lean`, l. 1476, 1490, 1496) | ouverte |
| O-09 | C-07 | `○` sans élimination ; `F` sans indice d'effet (l. 1496) | ouverte ; voir INS § 3 |
| O-10 | G2, D | collisions de notation : `δ` (trois sens), `at`/`at_n`, `open`/`unpack`, « localisation » | ouverte ; INS § 6 (W3) |
| O-11 | C8 (contrôles) | `scripts/controles/notation.py` n'examine que le texte qui suit le renvoi ; mesurer avant de renforcer | ouverte |
| O-12 | C-08 | `Π` sans coordonnée d'ordonnancement ni de chaîne de compilation (`EchelleDuSysteme.lean`, l. 175, 189) | ouverte |
| O-13 | C-07, C-08 | portée « par acteur » du rejeu, variante D-loc | ouverte |
| O-14 | G1 | ARB-PR-04 : CSV l. 125 et `FICHES-PR02.md` l. 270 contre DEC | ouverte |
| O-15 | D | statut des affirmations de `sources-singularites.md` | levée par la correction de la note (INS § 6) |
| O-16 | C8 | esquisse de `thm:stabilisation_pipeline` (`LeProcessusDeCompilation.lean`, l. 155) | ouverte |
| O-17 | G1 | `ERR-TOP-001` attribué à deux phases ; doctests « en Phase 1 » | ouverte |
| O-18 | C-06, C-07 | liaison du copatron (non vérifiée) | ouverte ; INS § 4 |
| O-19 | F | double comptage du travail dans `spawn` | FUTURE |
| O-20 | G1 | STRUCT-15/19/21 et BLOQ-08 (CSV l. 9, 30, 34, 36) | ouverte |
| O-21 | C-03 | argument « unité terminale » à revérifier sous l'usage `WithTop ℚ≥0` | ouverte |
| O-22 | C-09 | option b de BIB-01 (CSV l. 163) | ouverte |
| O-23 | D | la classe « fini » masque le dépassement flottant ; l'écart IEEE touche la soustraction | FUTURE |
| O-24 | contrôles | contrôles de structure de la séance 23 absents de `main` | ouverte |
| O-25 | J | débordement mesuré de la ligne « valeurs » (517 pt contre 345 pt) sur un document de substitution | HUMAN ACTION : mesurer sur le PDF réel |
| O-26 | G2 | bruit des infobulles d'AutoMark (`tools/SpecExt/AutoMark.lean`, l. 21) | ouverte |
| O-27 | C-07 | hypothèses « `ℒ` fini » et « `⟦operation⟧` sans fil », conditionnelles à P-10 | ouverte |
| O-29 | C8 | exception `declassify` dans ARB-PR-06 (LSM l. 402) | ouverte |

## 6. Propositions normatives (non appliquées)

Aucune ne doit être appliquée sans mandat explicite, point par point. Numérotation de travail ; P-21 n'est pas attribuée.

| Id | Proposition | Passage de `spec/` | Objet ou étape |
|---|---|---|---|
| P-01 | loi distributive « affaiblie » si `ℰ₀` non commutatif | `ReglesDeTypage.lean`, l. 642-645, 657 ; `AxiomatiqueGerminale.lean`, l. 317-321 | C-01, C-03, C-06 ; INS § 1 (D-φ2) |
| P-02 | `Λα.c` et copatron dans les formes terminales de `thm:progres` | `SemantiqueOperationnelle.lean`, l. 209-210 | C-07 ; INS § 4 (D-P1) |
| P-03 | sous-typage des tailles `νC⟨j⟩ <: νC⟨i⟩` | `ReglesDeTypage.lean`, l. 237-239 | C-06, C-07 |
| P-04 | grammaire des formes temporelles (`next`, `loc_n`, `Nxt`, `Loc`, `Declassify`, six schémas) | `GrammaireDesTermes.lean`, l. 33 ; `GrammaireDesTypes.lean`, l. 42-44 | C-04, C-07, G2 ; INS § 3 (D-T1) |
| P-05 | `declassify` : prémisse `fv(v) = ∅` contre `e ∈ 𝒳` ; niveau de la boîte | `AdjonctionsEtEnrichissement.lean`, l. 224 | C-07, C8 |
| P-06 | restreindre « Couche 2 — tous les cas » aux cas traduits | `LeSystemeDeSortesDuMetalangage.lean`, l. 247 | C-07 ; INS § 5 (D-S3) |
| P-07 | `Guard` à plusieurs messages contre `thm:sync_motifs_jonction` | `ReglesDeTypage.lean`, l. 1407 ; `EchelleDuSysteme.lean`, l. 486 | C-07, C-08 ; INS § 4 (D-P2) |
| P-08 | défaillance de `try` | `SemantiqueOperationnelle.lean`, l. 42-103 | C-07 |
| P-09 | schémas manquants : `fix`, `out`, globales de couche 2, contextes | `SemantiqueOperationnelle.lean`, l. 42, 82 | C-07 ; INS § 4 (P3) |
| P-10 | fil de temps : genre `maillon`, traduction par niveau, `thm:chaine_fils` | `LeSystemeDeSortesDuMetalangage.lean` (`tab:capacites`) | C-07 |
| P-11 | `E_repro` et `Π` : « trois » contre quatre composantes, portée par acteur | `EchelleDuSysteme.lean`, l. 113-116, 175, 189 | C-08, G1 |
| P-12 | topologie SPSC par couple et file de jonction (IMPL-04) | `EchelleDuSysteme.lean`, l. 507-508 | I, C-08 |
| P-13 | sens de l'invalidation au destructeur (BIB-17) | `EchelleDuSysteme.lean`, l. 565-567 | C-08, G1 |
| P-14 | singularités `∘` et `δ`, tables de propagation, `1/0` | `LesContraintesDeValeur.lean`, l. 352, 366-368, 403 | D, bloquée ; INS § 6 |
| P-15 | phases numérotées de 0 à 10 (STRUCT-06) | `LeProcessusDeCompilation.lean`, l. 34, 47-49 | G1 |
| P-16 | ordre de préservation du § 6.1 et `tab:invariants-de-passe` | `LeProcessusDeCompilation.lean`, § 6.1 | C8, G1 |
| P-17 | guide de lecture : TRANS-08, STRUCT-15 | après `GuideDeLecture.lean`, l. 35-36 | G1 (éditorial) |
| P-18 | « aucun cadre unique » des notions de monotonie (FACT-14) | `AdjonctionsEtEnrichissement.lean`, l. 385 | G1 |
| P-19 | non-monotonie en `ℓ` de la relation logique (FACT-07) | `SemantiqueOperationnelle.lean`, § relation logique | C8 ; INS § 2 (D-ℓ) |
| P-20 | « sont démontrés », « exactement la seconde » ; exception `declassify` | `SemantiqueOperationnelle.lean`, l. 27-28 ; `StructuresOuvertesEffetsEtMetaTheorie.lean`, l. 311-318 | corrections éditoriales |
| P-22 | voies ANOM-17 (sens de l'archive) : `slice`, `∥`/`vmap`, comptabilité de `spawn` | `ReglesDeTypage.lean`, l. 1228, 1289, 1393 | C-08, E, F |

PREUVE-08 (troncature) n'appelle pas de proposition : le texte est déjà dans `main` ; seule sa ratification est en question (DEC).

## 7. Décisions attribuées à l'autrice

Traitées dans [`DECISIONS.md`](../tracking/DECISIONS.md). Ce lot ne les reprend pas et ne les tient pas pour prises.

## 8. Contrôles

Exécutés pour la PR qui introduit ce lot : `scripts/controle.py`, `scripts/ci/check_documentation_architecture.py`, `scripts/suivi.py check` puis `all`, `pytest tests/python`, `statement_inventory`. Lychee tourne en CI. Aucun de ces contrôles ne valide le contenu scientifique.

## 9. Critère de sortie

Le lot passe UNDER REVIEW lorsque : chaque pièce a un sort (fait) ; V-02 à V-07 sont versés ou écartés ; chaque obligation est rattachée à un registre C ou à une étape ; chaque proposition a reçu un mandat, un refus, ou reste explicitement ouverte dans `DECISIONS.md` ; les contrôles passent. Il passe VALIDATED seulement après relecture de l'autrice.
