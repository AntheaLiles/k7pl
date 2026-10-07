<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 30 : audit des « en attente » déjà arbitrés

Demande de l'auteur : « La liste des sujets en attente de décision contient des items qui ont déjà été
arbitrés. Identifie-les et réalise les correctifs dans le manuscrit, réalise ensuite les items qui en
dépendaient, puis traite tous les éléments encore en attente et termine par une mise à jour d'ensemble
de `docs/`. » Ce document est l'audit (étape 1) ; les correctifs sont dans les journaux et fiches de la
séance (étapes 2 à 4).

**Sources parcourues :** `DECISIONS.md` (sections « Attendent », « Nouvelles »), `instruction-des-decisions.md`,
`instruction-arb-pr-04-rejeu-binaire.md`, `ANOMALIES.md`, `RESTE-A-FAIRE.md`, `fiches-statuts.csv` (colonnes
`statut`, `note`, `suite`, `depend`), `TABLEAU-DE-BORD.md` (§2.A et portes), les journaux des séances 11, 15, 28, 29,
`taches-consolidees.md` (fiches `BLOQ-05`, `-07`, `STRUCT-01`, `FACT-12`).

**Décisions de l'auteur retenues comme sources** (communiquées au cours des échanges, déjà inscrites au
tableau « Tranchées le 1er octobre 2026 (suite) » de `DECISIONS.md` pour la plupart) : socle = famille modale
et graduée (`ARB-PR-07` / `D-2`, imports ciblés instruits un à un) ; préservation graduée de bout en bout =
objectif (`ARB-PR-06`) ; `ARB-PR-04` : à instruire ; `T-68` avant-dernier dans l'ordre de finition, juste avant
la release ; annexe E fondue ; première release `spec-v0.1.0` à la porte P6 ; `BLOQ-05` (indexation du jugement non
requise) et les deux options de `BLOQ-07` validées le 1er octobre ; le Verso fait foi (`D-5`) ; graduation
additive `N_{r+s} → N_r N_s` de la troncature (§2.3), vérifiée, tenue pour ratifiée.

## A. Entrées en attente qui étaient déjà arbitrées

| # | Entrée « en attente » | Où elle figurait | Arbitrage déjà pris | Source | Ce qui restait réellement |
|---|---|---|---|---|---|
| 1 | `ARB-PR-04` : « choisir la voie A à D » | `DECISIONS.md` « Attendent » ; `RESTE-A-FAIRE` ; fiche CSV `decision` | **à instruire**, avant de trancher ; l'instruction est écrite | `DECISIONS.md` « Tranchées le 1er octobre » ; `instruction-arb-pr-04-rejeu-binaire.md` ; journal 15 | choisir la voie : appliquée B puis C (orientation de l'instruction), **à ratifier** |
| 2 | `T-68` : « mots des primitives » comme décision en attente | `DECISIONS.md` « Attendent » ; tableau de bord §2.A | **avant-dernier** dans l'ordre de finition, juste avant la release | `DECISIONS.md` 1er octobre ; journal 15 | contenu éditorial seul ; proposition de vocabulaire à préparer, rien à renommer |
| 3 | porte **P3** « … et `T-68` tranchées » | `TABLEAU-DE-BORD.md` §2.D | contredit l'ordre arbitré : `T-68` est après P5 et avant P6 | idem + `D-9` | porte P3 corrigée ; `T-68` rangé entre P5 et P6 |
| 4 | « les quatre imports ciblés : lesquels verser, où » | `DECISIONS.md` « Attendent » | le **cadre** est arbitré : famille modale et graduée, imports **instruits un à un** | `ARB-PR-07` / `D-2` ; motif écrit au §1.2 | l'instruction un à un (`BIB-10`, `-20`, `-21`, `-22`) : travail de recherche, plus une décision d'auteur |
| 5 | `FACT-12` / `STRUCT-01` : « choisir la formulation » | `DECISIONS.md` ; fiches `decision` / `conception` | le cadre est celui du manuscrit (`ARB-PR-05`, ratifié) et le socle une famille modale et graduée (`D-2`) ; `FACT-21`, `-22` écartées | `DECISIONS.md` ; fiche `FACT-12` (« ARB-PR-05 écarte déjà FACT-21/22 ») | orientation de l'instruction (ne pas unifier), **à ratifier** |
| 6 | `D-9` : première release | `DECISIONS.md` (deux fois : tranchée et « Nouvelles ») | porte P6, après P1 à P5 | `DECISIONS.md` 1er octobre | doublon retiré |
| 7 | `D-8` : rétablir au glossaire les trois couches | `DECISIONS.md` « Nouvelles » (ouverte) | recommandation « oui » **exécutée** : `ANOM-06` ✅, entrées « couche 1/2/3 » au glossaire | `ANOMALIES.md` ; `spec/Spec/Refs/ListeDesGlosses.lean` | rien : tranchée et appliquée |
| 8 | `BLOQ-05` : poser ou non l'indexation `Δ ⊢^ℓ` | fiche `BLOQ-05` ; journal 28 (« l'énoncé demande une reformulation ») | indexation **non requise** (validée le 1er octobre) | `DECISIONS.md` 1er octobre | la reformulation est la lecture par nœud de dérivation (clause des règles `Op`, `Case`, `Tick`) ; remarque ajoutée au texte |
| 9 | `BLOQ-07` : deux options (restriction de domaine ; lemme de simulation) | fiche `BLOQ-07` | les deux **validées** : énoncé conditionnel à `Sim` *et* simulation à conduire | idem | rien à décider ; reste la preuve (`PREUVE-07`) |
| 10 | `ARB-PR-06` : préservation graduée de bout en bout | `RESTE-A-FAIRE` (`PREUVE-02` « conception ») ; `ANOM-17` (`declassify`) | **objectif** ; passe par passe ; fragment monomorphisé d'abord | `DECISIONS.md` ; §6.2 | pas une décision : conséquence pour `declassify` (voie B, qui préserve le typage gradué) |
| 11 | troncature (§2.3) : graduation additive « à confirmer » | journal 28 | ratifiée (vérifiée) | échange | note de ratification ; aucune modification du texte (déjà additive) |
| 12 | première release : portes | `TABLEAU-DE-BORD.md` | P6 | `D-9` | portes réécrites (`P3` sans `T-68`) |

## B. Entrées vérifiées **non** arbitrées (restent à traiter)

`BLOQ-12` / `IMPL-07` (contenu de la table de propagation : `∘` et `δ` indéfinis), `IMPL-04`, `STRUCT-16`,
`STRUCT-06`, `FACT-14`, `D-7`, `ANOM-17` (les sept voies), `ARB-PR-03`, `STRUCT-05` / `TRANS-04`, `TRANS-02`, les
sept fermetures déduites, `BIB-01`, `PREUVE-05` (loi stricte ou affaiblie). Pour chacune, la convention du dépôt
« appliquée, à ratifier » s'applique quand l'instruction donne une orientation et que l'orientation ne dénature pas le
projet (séance 31 : [orientations appliquées](2026-10-06-pr-02-31-orientations-appliquees.md)) ; sinon l'élément reste en attente avec sa question.

## C. Cohérence du manuscrit avec les arbitrages déjà pris (relevé)

| Arbitrage | Où le manuscrit le dit | État |
|---|---|---|
| socle modal et gradué ; imports ciblés un à un | §1.2 (guide de lecture) | conforme, rien à corriger |
| préservation graduée = objectif | §6.2, théorème `thm:abaissement_grades` | conforme |
| `BLOQ-07` conditionnel à `Sim` | table `tab:engagements` (« rouverte : Sim »), `thm:fidelite_interprete` | conforme |
| `BLOQ-05` sans indexation | `thm:correspondance_niveaux` (énoncé sur `niv(Δ)`) | conforme ; remarque ajoutée |
| troncature additive | `thm:troncature_comonade` (« somme des profondeurs ») | conforme |
| annexe E fondue ; trois couches au glossaire | ch. 3, 4 ; glossaire | conforme |
| P6 / release | hors manuscrit (docs, `CITATION.cff`) | portes corrigées |
