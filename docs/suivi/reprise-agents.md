<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Reprise des agents : où en est chaque chantier
> **Résolu le 7 octobre 2026 (relecture de la PR n° 10).** La régression de `BLOQ-12` décrite ci-dessous a été réparée avant la fusion : la règle par réunion d'étiquettes, la note de sources, le journal 02-33 et le contrôle `scripts/controles/singularites.py` sont présents dans l'état de la PR. Les mentions de « `HEAD` » et les actions « rétablir `504739d` » décrivent l'état *avant* réparation ; les hashs cités (`504739d`, `d08f92b`, `97788c3`, `5449b35`) désignent des commits fusionnés en un seul par le squash de la PR et ne sont plus atteignables.

Ce fichier sert de point de reprise si une session s'arrête (limite de dépense, erreur 429). Un agent repris lit d'abord ce fichier et `git log`, puis exécute exactement la **prochaine action** de sa section. Règle de travail : commiter et pousser après chaque étape terminée, jamais plus d'une étape non commitée.

## Études

Chantier : deux études comparatives sans choix, demandées par l'auteur (« pour faire un choix éclairé j'ai besoin d'avoir une analyse des possibilités au regard de l'état actuel du manuscrit »), sans toucher à `spec/`.

* (a) [`etude-spawn-fil-de-temps`](../recherche/etude-spawn-fil-de-temps.md) : le fil de temps de la fibrille engendrée par `spawn`.
* (b) [`etude-parallele-fourche-entrelacement`](../recherche/etude-parallele-fourche-entrelacement.md) : `∥` et `vmap`, fourche-jointure contre entrelacement.

Branche : `claude/lean4-reuse-init-qvzlcg` (pousser sans force, `git fetch` puis `git merge` avant chaque push).

| Étape | État |
|---|---|
| 0. ce fichier de reprise | fait |
| 1. lecture du manuscrit et de l'instruction, relevé des faits (labels, règles) | fait |
| 2. écrire l'étude (a) | fait (relue, labels vérifiés) |
| 3. écrire l'étude (b) | fait (labels vérifiés, tableaux contrôlés) |
| 4. remplacer les mentions « (étude à écrire) » par des liens (`DECISIONS.md`, `TABLEAU-DE-BORD.md`, `instruction-des-decisions.md`, `ANOMALIES.md`, `CHANGELOG.md`) | fait |
| 5. contrôles : `python3 scripts/controle.py`, `python3 scripts/suivi.py all`, `reuse lint`, liens Markdown hors ligne | fait (tous verts) |
| 6. rapport final | à faire (rien d'autre à écrire : les études sont terminées) |

**Dernier commit :** voir `git log` (mis à jour à chaque étape).

**Prochaine action concrète :** aucune étape d'écriture ne reste. Si l'auteur répond, mettre à jour `DECISIONS.md` (la décision), puis `RESTE-A-FAIRE` via `python3 scripts/suivi.py all`. Ordre conseillé par les études : décider `∥` avant `spawn`.

**Sources externes :** les pages éditeurs et arXiv sont inaccessibles depuis la session (vérifié : pas de réponse). Les études ne citent que les notices de `biblio/references.json` et les notes du corpus du dépôt ; le corps des articles n'est pas relu. Chaque citation porte son niveau de vérification.

## Analyses : T-68 et dossier

Chantier : analyses détaillées des éléments à trancher, face au manuscrit, sans toucher à `spec/` (demande de l'auteur : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher »). Fichiers : `docs/recherche/analyses-decisions/t68-vocabulaire-face-au-manuscrit.md` et `docs/recherche/analyses-decisions/README.md` (index général).

| Étape | État |
|---|---|
| 0. section de reprise | fait |
| 1. mesures : essai à blanc, parcours des occurrences, collisions, copie appliquée, largeur LaTeX | fait |
| 2. écrire `t68-vocabulaire-face-au-manuscrit.md` | fait |
| 3. écrire `README.md` du dossier (index) | fait ; renvois aux sept dossiers de conception et aux cinq `ratifications-*` liés |
| 4. renvois : `TABLEAU-DE-BORD.md`, `DECISIONS.md`, `docs/README.md` ; `python3 scripts/suivi.py all` | fait (refait le 7 octobre : un commit d'un autre agent, `e4899e9`, les avait supprimés avec les deux fichiers, restaurés depuis `1dbbe6d`) |
| 5. finaliser l'index : lier `00-index-ratifications.md` | fait (le fichier est apparu le 7 octobre) |

**Dernier commit :** voir `git log`.

**Prochaine action concrète :** aucune étape d'écriture ne reste ; rendre le rapport. Si l'on reprend : vérifier que `docs/recherche/analyses-decisions/README.md` et `t68-vocabulaire-face-au-manuscrit.md` sont présents (voir la vigilance ci-dessous), et si un nouveau fichier apparaît dans le dossier, l'ajouter à l'index. Avant toute écriture : vérifier que l'arbre n'est pas en retard sur la branche (suppressions indexées inattendues : `git reset --hard HEAD` si tout est commité).

**Vigilance (concurrence).** Trois agents poussent sur la même branche ; un commit écrit depuis un arbre de travail en retard supprime ce que les autres viennent d'ajouter (déjà arrivé : `97788c3` a défait la correction de `BLOQ-12`, voir le dossier 4 §0 ; `e4899e9` a supprimé les deux fichiers de cette section). Avant chaque commit : `git diff --cached --stat` ne doit montrer que ses propres fichiers.

## Analyses : ratifications

Chantier : analyses détaillées, face au manuscrit, des fiches « a-ratifier » (demande de l'auteur : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher »). Dossier : [`analyses-decisions/`](../recherche/analyses-decisions/). Ni `fiches-statuts.csv` ni `DECISIONS.md` (sauf un renvoi) ne sont modifiés. Niveau de vérification : lecture du Verso, pas de compilation, aucune source externe.

| Étape | Fichier | État |
|---|---|---|
| 1 | `ratifications-pipeline-et-preuves.md` (STRUCT-06, STRUCT-05/TRANS-04) | fait |
| 2 | `ratifications-grades-et-cadre.md` (STRUCT-16, TRANS-02, FACT-12, STRUCT-01, FACT-14, PREUVE-05) | fait |
| 3 | `ratifications-numerique-et-execution.md` (ARB-PR-04, IMPL-07, BLOQ-12, IMPL-04) | fait |
| 4 | `ratifications-effets-et-fermetures.md` (ARB-PR-03/BIB-01, sept fermetures, FACT-09, BIB-17) | fait |
| 5 | `ratifications-anom-17.md` (ANOM-17, PREUVE-04/TRANS-06, ANOM-09/10, D-7, sceaux) | fait |
| 6 | `00-index-ratifications.md` + renvoi dans `DECISIONS.md` | fait (index écrit ; renvoi dans `DECISIONS.md` : déjà porté par le renvoi vers le dossier) |

**Dernier commit :** voir `git log`.

**Prochaine action concrète :** aucune étape d'écriture ne reste ; rapport final remis. Si l'auteur répond, mettre à jour `DECISIONS.md` puis `python3 scripts/suivi.py all`. **Règle de travail (incident du 7 octobre) :** le répertoire de travail est partagé et la référence de branche avance sous l'arbre ; ne jamais faire d'ajout global, et valider par chemins explicites (`commit --only`).

## Analyses : conception

Chantier : dossiers de décision de conception, un fichier par élément, dans [`docs/recherche/analyses-decisions/`](../recherche/analyses-decisions/) (demande de l'auteur : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher »). Sans toucher à `spec/` ni à `.github/`. Même grille partout : question exacte, état du manuscrit (lignes lues), options, recommandation, formulation Verso non appliquée, ce que la réponse débloque. Index : [`00-index-design`](../recherche/analyses-decisions/00-index-design.md).

| Étape | État |
|---|---|
| 1. `01-parallele-et-vmap.md` | fait |
| 2. `02-spawn-et-fil-de-temps.md` | fait |
| 3. `03-anom-18-facteur-temporel.md` | fait |
| 4. `04-singularites-comp-et-delta.md` | fait |
| 5. `05-sceaux-progres-preservation.md` | fait |
| 6. `06-formes-temporelles-declassify-at-move.md` | fait |
| 7. `07-arb-pr-04-rejeu-binaire.md` | fait |
| 8. `00-index-design.md` | fait |

**Dernier commit :** voir `git log -- docs/recherche/analyses-decisions/`.

**Alerte (dossier 4, §0).** Le commit `97788c3` a défait la correction de `BLOQ-12` des commits `d08f92b` et `504739d` (§3.2 revenu à la règle « borne supérieure » non associative, contrôle `scripts/controles/singularites.py`, `scripts/verif_singularites.py`, note `sources-singularites.md`, journal `2026-10-07-pr-02-33`, notices bibliographiques, lignes de `CHANGELOG`). Cause probable : commit construit sur un index périmé, plusieurs agents écrivant sur la même branche. Restauration à faire : `git checkout 504739d -- <les onze chemins du dossier 4>` après relecture de `git diff 504739d 97788c3 -- docs/suivi`.

**Prochaine action concrète :** aucune étape d'écriture ne reste ; si l'auteur répond à un dossier, mettre à jour `DECISIONS.md` puis `python3 scripts/suivi.py all`.

## Manuscrit et sources

Chantier : (1) sourcer les propagations de singularités (`BLOQ-12`, `IMPL-07`), (2) rédiger ce qui reste en attente sans décision de fond (hors études `spawn`/`∥` et hors `T-68`), (3) mettre à jour `docs/`. Mandat de l'auteur pour modifier le manuscrit au plus juste, en le consignant (fiche, journal, `CHANGELOG.md`, `spec/CHANGELOG.md`). Aucun sceau changé, aucune fiche fermée sans preuve.

| Étape | État |
|---|---|
| 1. sources des singularités : accès tentés (tous fermés), note `docs/recherche/sources-singularites.md`, `scripts/verif_singularites.py`, correction du §3.2 (associativité), notice IEEE 754-2019, journal `2026-10-07-pr-02-33` | fait |
| 1 bis. contrôle `scripts/controles/singularites.py` (tables du §3.2 contre la roue des fractions), branché dans `controle.py` | fait |
| 2. parcours de `DECISIONS.md`, `ANOMALIES.md`, `RESTE-A-FAIRE.md`, `fiches-statuts.csv` : tout ce qui reste dépend d'une ratification, d'une décision, du corps des sources ou d'un modèle de coût (journal 2026-10-07-pr-02-33, §D) | fait |
| 3. rien de rédigeable sans décision de fond n'a été relevé | fait |
| 4. cohérence : `lake build Spec`, `controle.py`, `suivi.py all`, `reuse lint` | fait |
| 5. rapport final | à faire |

**Dernier commit :** voir `git log`.

**Prochaine action concrète :** rapport final (étape 5) ; si une session reprend, ne rien réécrire : attendre la ratification de l'auteur ou l'accès aux sources.

**Sources externes :** pages d'éditeurs, d'arXiv, de Wikipédia, d'IEEE bloquées (`EGRESS_BLOCKED`, vérifié le 7 octobre) ; seuls les résumés de la recherche en ligne sont lisibles ; ne jamais présenter comme lu ce qui ne l'est pas. Avant un `lake build`, copier `/home/user/k7pl/.lake` dans le dossier de travail (`cp -a`) : le cache Mathlib distant est inaccessible.
