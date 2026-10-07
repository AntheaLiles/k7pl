<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Les éléments à trancher : analyses détaillées face au manuscrit
> **Résolu le 7 octobre 2026 (relecture de la PR n° 10).** La régression de `BLOQ-12` décrite ci-dessous a été réparée avant la fusion : la règle par réunion d'étiquettes, la note de sources, le journal 02-33 et le contrôle `scripts/controles/singularites.py` sont présents dans l'état de la PR. Les mentions de « `HEAD` » et les actions « rétablir `504739d` » décrivent l'état *avant* réparation ; les hashs cités (`504739d`, `d08f92b`, `97788c3`, `5449b35`) désignent des commits fusionnés en un seul par le squash de la PR et ne sont plus atteignables.

**État au 6 octobre 2026.** Ce dossier répond à la demande de l'auteur : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Il réunit, par famille de décision, une analyse qui confronte chaque choix au texte de `spec/` tel qu'il est, dit ce que le choix change, et formule ce qu'il y a à ratifier ou à décider. **Aucune analyse ne tranche à la place de l'auteur** et aucune ne modifie `spec/` ; la source de vérité des décisions reste [`DECISIONS.md`](../../suivi/DECISIONS.md), celle des fiches [`fiches-statuts.csv`](../../suivi/fiches-statuts.csv), le point d'entrée du suivi [`TABLEAU-DE-BORD.md`](../../suivi/TABLEAU-DE-BORD.md).

Chaque fichier annonce son **niveau de vérification** (lecture du Verso, contrôle ou compilation, source externe lue ou non). Une analyse « à venir » dans l'index ci-dessous est un fichier attendu qui n'est pas encore écrit ; elle est notée dans [`reprise-agents.md`](../../suivi/reprise-agents.md), où l'on peut voir où en est chaque chantier.

## 1. Lecture rapide : ce qui attend l'auteur

| Famille | Combien | Où lire | État du dossier |
|---|--:|---|---|
| **Vocabulaire des primitives (`T-68`)** : ratifier en bloc 49 lignes | 1 décision en 6 blocs | [`t68-vocabulaire-face-au-manuscrit`](t68-vocabulaire-face-au-manuscrit.md) | écrit |
| **Choix de conception** (`∥` et `vmap`, `spawn`, `ANOM-18`, singularités, sceaux, formes temporelles, `ARB-PR-04`) | 7 dossiers de décision | [`00-index-design`](00-index-design.md) (§2) | écrit |
| **Fiches « à ratifier »** (appliqué, non confirmé) | 15 fiches de `RESTE-A-FAIRE.md`, plus les lignes de `DECISIONS.md` | les cinq `ratifications-*` (§3) | cinq fichiers et leur index écrits ; l'index [`00-index-ratifications`](00-index-ratifications.md) écrit |
| **Décisions déjà prises** de l'auteur, à ne pas lui redemander | 14 décisions rappelées | §5 | écrit |
| **Sources inaccessibles** à lire plus tard | 8 fiches de recherche, dont le corps de l'article de Carlström | §4 | écrit |

**Constat transversal à lire avant le reste.** Le [dossier 4](04-singularites-comp-et-delta.md) (§0) établit que l'état du dépôt a **régressé** sur `BLOQ-12` : un commit de la série des études (`97788c3`) a défait la correction écrite par `d08f92b` et `504739d` (règle de combinaison des singularités rendue non associative, contrôle `singularites.py` et journal supprimés). Ce n'est pas une décision, c'est une réparation : à rétablir **avant** de ratifier `BLOQ-12` ou `IMPL-07`. Le même mécanisme (un commit écrit depuis un arbre de travail en retard sur la branche, qui supprime ce que d'autres viennent d'ajouter) a supprimé, le temps d'un commit, les fichiers de ce dossier qui portent l'analyse `T-68` et cet index ; ils ont été restaurés. Avant de ratifier, vérifier par `git log --stat` que les fichiers cités ici sont présents.

## 2. Conception

Point d'entrée : [`00-index-design`](00-index-design.md), qui donne, pour chacun des sept dossiers, la recommandation en une ligne, l'urgence, les dépendances et l'ordre de décision conseillé.

| # | Dossier | Élément |
|--:|---|---|
| 1 | [`01-parallele-et-vmap`](01-parallele-et-vmap.md) | `∥` et `vmap` : la lecture qui fait foi (fourche-jointure ou entrelacement) |
| 2 | [`02-spawn-et-fil-de-temps`](02-spawn-et-fil-de-temps.md) | `spawn` et le fil de temps de la fibrille engendrée |
| 3 | [`03-anom-18-facteur-temporel`](03-anom-18-facteur-temporel.md) | `ANOM-18` : forme complète du facteur temporel |
| 4 | [`04-singularites-comp-et-delta`](04-singularites-comp-et-delta.md) | singularités `∘` et `δ` (`BLOQ-12`, `IMPL-07`) |
| 5 | [`05-sceaux-progres-preservation`](05-sceaux-progres-preservation.md) | sceaux de `thm:progres` et de `thm:preservation` |
| 6 | [`06-formes-temporelles-declassify-at-move`](06-formes-temporelles-declassify-at-move.md) | formes temporelles, `declassify`, `at_n`, `move` |
| 7 | [`07-arb-pr-04-rejeu-binaire`](07-arb-pr-04-rejeu-binaire.md) | `ARB-PR-04` : la promesse du rejeu bit à bit |

Les deux études comparatives plus anciennes, hors de ce dossier, restent la base des dossiers 1 et 2 : [`etude-spawn-fil-de-temps`](../etude-spawn-fil-de-temps.md) et [`etude-parallele-fourche-entrelacement`](../etude-parallele-fourche-entrelacement.md). Ordre de décision conseillé par l'index de conception : rétablir `504739d`, puis le dossier 3, puis 1, 2, 5, et enfin 6 et 7.

**Lien avec `T-68`.** Le choix du mot K de `vmap` (`vectormap` dans la proposition) dépend du dossier 1 : si `∥` et `vmap` changent de forme (par exemple la restriction au parallélisme pur de la recommandation du dossier 1), le mot est à revoir avec eux ; voir [`t68-vocabulaire-face-au-manuscrit`](t68-vocabulaire-face-au-manuscrit.md) §10, rang 1. De même `at_n`, `loc_n` (`placed_n`) et `move` sont l'objet du dossier 6, qui traite les formes, pas les mots : le renommage de `T-68` ne les modifie que par `loc_n` et ne préjuge pas du dossier 6.

## 3. Ratifications (appliqué, non confirmé)

Point d'entrée : [`00-index-ratifications`](00-index-ratifications.md). Les analyses par famille de fiches :

| Fichier | Éléments traités | État |
|---|---|---|
| [`ratifications-pipeline-et-preuves`](ratifications-pipeline-et-preuves.md) | `STRUCT-06` (et `REECR-16`), `STRUCT-05`, `TRANS-04` | écrit |
| [`ratifications-grades-et-cadre`](ratifications-grades-et-cadre.md) | `STRUCT-16`, `TRANS-02`, `FACT-12`, `STRUCT-01`, `FACT-14`, `PREUVE-05` | écrit |
| [`ratifications-numerique-et-execution`](ratifications-numerique-et-execution.md) | `ARB-PR-04`, `IMPL-07`, `BLOQ-12`, `IMPL-04` | écrit |
| [`ratifications-effets-et-fermetures`](ratifications-effets-et-fermetures.md) | `ARB-PR-03` (et `BIB-01`), sept fermetures déduites, `FACT-09`, `BIB-17` | écrit |
| [`ratifications-anom-17`](ratifications-anom-17.md) | les cinq lignes `ANOM-17`, points de forme, grammaires et schémas des modalités, `PREUVE-04`, `TRANS-06`, `ANOM-09`, `ANOM-10`, `D-7`, changements de sceau | écrit |
| [`00-index-ratifications`](00-index-ratifications.md) | index des cinq fichiers | écrit |

Les 15 fiches du tableau « À ratifier » de [`RESTE-A-FAIRE.md`](../../suivi/RESTE-A-FAIRE.md) (`BLOQ-12`, `STRUCT-06`, `STRUCT-16`, `PREUVE-05`, `FACT-09`, `FACT-14`, `ARB-PR-04`, `STRUCT-01`, `IMPL-04`, `FACT-12`, `TRANS-02`, `IMPL-07`, `ARB-PR-03`, `STRUCT-05`, `TRANS-04`) sont réparties entre ces fichiers : trois dans le premier, six dans le deuxième, quatre dans le troisième, deux dans le quatrième (`ARB-PR-03`, `FACT-09`). **Recouvrement à noter** : les dossiers 4 (singularités) et 7 (`ARB-PR-04`) de conception portent sur les mêmes fiches (`BLOQ-12`, `IMPL-07`, `ARB-PR-04`) que `ratifications-numerique-et-execution` : la première lecture est la ratification (ce qui a été appliqué), la seconde l'éventail des options.

## 4. Sources inaccessibles, à lire plus tard

Les pages des éditeurs et d'arXiv ne répondent pas depuis les sessions de travail (vérifié lors des études de `spawn` et de `∥`). Les analyses ne citent que les notices de [`biblio/references.json`](../../../biblio/references.json) et les notes du dépôt ; le corps des articles n'est pas relu. Ce qui reste à lire, avec ce que l'on en attend (état de [`fiches-statuts.csv`](../../suivi/fiches-statuts.csv) et de [`verifications-pr02`](../../bibliographie/verifications-pr02.md)) :

| Fiche | Source | Ce qui reste à lire | Ce qui en dépend |
|---|---|---|---|
| `BLOQ-12` | Carlström 2004 (roues) : notice confirmée, **corps non lu** | les axiomes de la roue, pour les vérifier sur l'extension `∘`, `δ` | ratification de `BLOQ-12` (et de `IMPL-07`, qui en dépend) |
| `BIB-21` | théorie des types graduée formalisée (Abel, Danielsson, Eriksson, ICFP 2023) | la restriction sur l'égalité définitionnelle, contre le produit mixte | un des imports ciblés de `ARB-PR-07` |
| `BIB-04`, `BIB-27` | join-calculus (Fournet–Gonthier), types de boîtes aux lettres (de'Liguoro–Padovani) et *Special Delivery* | le protocole d'appariement ; le théorème d'interblocage | ratification de `IMPL-04` |
| `BIB-12` | extension additive de la logique linéaire classique, transport intuitionniste (Caires et Pérez, ESOP 2017) | la possibilité du transport | — |
| `BIB-24` | théorie cubique sans types Glue (XTT) | la compatibilité avec la sédimentation | `PREUVE-16` |
| `BIB-25` | algèbre de Kleene concurrente | la compatibilité de la loi d'échange avec la résiduation | — (dépendance non déclarée dans le CSV) |
| `BIB-01` | *Hefty Algebras* (2023/2025) | **ne pas instruire** tant que `ARB-PR-03` n'est pas ratifiée | — |
| `PREUVE-16` | type de chemin cubique pour Lean | aucune offre retrouvée ; limite d'outil | transposition graduée de la sédimentation |

Aucune de ces lectures ne bloque une ratification d'ensemble ; elles bornent le niveau de confiance de quatre d'entre elles (`BLOQ-12`, `IMPL-04`, `IMPL-07`, `ARB-PR-03`).

## 5. Décisions de l'auteur déjà prises (à ne pas redemander)

Source : [`DECISIONS.md`](../../suivi/DECISIONS.md), section « Tranchées ». Les mots entre guillemets sont ceux de l'auteur.

| Décision | Ce qui est tranché | Où |
|---|---|---|
| `D-1` | périmètre du noyau formel : voie 2, la couche 2 formalisée | 15 septembre |
| six décisions de conception | canal comme valeur, asynchrone primitif, sessions et boîtes aux lettres, graphe importé, localité graduée, coût en travail et profondeur | [journal 04](../../journal/2026-09-30-pr-02-04-couche-3-parallele.md) |
| `ARB-PR-01`, `ARB-PR-02`, `ARB-PR-05` | pas d'inversion de la subsomption ; deux sortes de tailles ; cadre du manuscrit | `DECISIONS.md` |
| `ARB-PR-07` / `D-2` | famille modale et graduée ; imports ciblés instruits un à un | 1er octobre |
| `ARB-PR-06` | préservation graduée de bout en bout comme objectif | 1er octobre |
| `D-5`, `D-6`, `D-8`, `D-9` | le Verso fait foi ; sous-titre ; trois couches au glossaire ; première release en P6 | 1er octobre |
| `D-7` | annexes B, C, D sorties de la spécification (prototypes) | commit `d84021f` |
| `PREUVE-08` | graduation additive de la troncature | ratifiée |
| `STRUCT-06` | « Renumérote toutes les phases de compilation pour les remettre en cohérence » | 6 octobre ; reste à ratifier le schéma, non le principe |
| `BLOQ-12` | « Les singularités sont à définir, leurs propagations réelles sont à sourcer dans les références » | 6 octobre |
| `ANOM-17` (grammaires) | « Les grammaires sont à définir » | 6 octobre |
| `ANOM-09`, `ANOM-10` | « Ok alors rédige ANOM-09 et ANOM-10 » | 6 octobre |
| `T-68` | « en bloc, car il y a un besoin de complétude et un besoin de cohérence dans le choix du vocabulaire » | 6 octobre ; place dans l'ordre : avant-dernier |
| `ANOM-17` (`spawn`, `∥`) | « pour faire un choix éclairé j'ai besoin d'avoir une analyse des possibilités au regard de l'état actuel du manuscrit » | deux études écrites, sans choix |

Cette liste n'est pas la liste des fiches closes : [`RESTE-A-FAIRE.md`](../../suivi/RESTE-A-FAIRE.md) en donne l'état (32 fiches ouvertes sur 190).

## 6. Les quatre qui attendent un choix de fond

Reprise de la section « Attendent une décision de l'auteur » de [`DECISIONS.md`](../../suivi/DECISIONS.md) :

| | Question | Étude ou analyse | Remarque |
|---|---|---|---|
| `ANOM-17` | `spawn` : bifurcation par maillon pour le fil de temps ? | [`etude-spawn-fil-de-temps`](../etude-spawn-fil-de-temps.md) | à décider après `∥` |
| `ANOM-17` | `∥` : fourche-jointure ou entrelacement par branche ? | [`etude-parallele-fourche-entrelacement`](../etude-parallele-fourche-entrelacement.md) | à lire en premier |
| `T-68` | ratifier en bloc les 49 primitives | [`t68-vocabulaire-face-au-manuscrit`](t68-vocabulaire-face-au-manuscrit.md) | six décisions de bloc ; les lignes à regarder en premier : `Vmap`, le nom de `Op`, `Alw^{-}` |
| `BIB-01` | *Hefty Algebras* : instruire ? | conditionnel à `ARB-PR-03` ; analyse dans [`ratifications-effets-et-fermetures`](ratifications-effets-et-fermetures.md) | |

## 7. Ordre de lecture conseillé

1. §2 : l'index de conception et son ordre conseillé (rétablir `504739d`, puis `ANOM-18`, puis `∥` avant `spawn`) ; ce qui commande le reste.
2. [`t68-vocabulaire-face-au-manuscrit`](t68-vocabulaire-face-au-manuscrit.md) : une seule séance de ratification, mécanique ensuite.
3. Les ratifications (§3), dans l'ordre de l'index des ratifications.
4. §4 si l'on veut connaître les limites de confiance.

## 8. Mise à jour

Ce dossier est tenu à la main. Quand un fichier « à venir » apparaît, remplacer « à venir » par « écrit » et lier le fichier. Quand une décision est prise, la porter dans `DECISIONS.md` (source de vérité) et la retirer des sections ci-dessus qui la présentent comme à trancher.
