<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# T-68 — table de renommage mécanique

**Séance 32.** Ce qui change **si** le [vocabulaire en bloc](../recherche/t68-vocabulaire-en-bloc.md) est ratifié ; **rien n'est appliqué**. Le script [`scripts/t68_renommer.py`](../../scripts/t68_renommer.py) lit [`t68-renommage.csv`](t68-renommage.csv) et fait l'essai à blanc par défaut (`--appliquer` écrit). Il ne touche que les fichiers vivants (`spec/`, `scripts/controles/`, `docs/suivi/primitives.md`) : les relectures, les journaux et les archives citent le vocabulaire d'alors et restent des états datés.

## 1. Constructeurs K qui changent

| Ancien | Nouveau | Motif | Fichiers (occurrences) | Total |
|---|---|---|---|---:|
| `inj` | `inject` | `\mathsf\{inj\}` | `C3/GrammaireDesTermes.lean` (1), `C3/ReglesDeTypage.lean` (1), `C4/SemantiqueOperationnelle.lean` (4) | 6 |
| `iter` | `iterate` | `\mathsf\{iter\}` | `C3/GrammaireDesTermes.lean` (1), `C3/ReglesDeTypage.lean` (1), `C4/SemantiqueOperationnelle.lean` (3) | 5 |
| `vmap` | `vectormap` | `\mathsf\{vmap\}` | `C3/GrammaireDesTermes.lean` (1), `C3/ReglesDeTypage.lean` (2), `C4/SemantiqueOperationnelle.lean` (3) | 6 |
| `open` | `unpack` | `\mathsf\{open\}` | `C3/GrammaireDesTermes.lean` (1), `C3/ReglesDeTypage.lean` (1), `C4/SemantiqueOperationnelle.lean` (1) | 3 |
| `at (□)` | `current` | `\mathsf\{at\}(?!_)` | `C3/GrammaireDesTermes.lean` (3), `C3/ReglesDeTypage.lean` (2), `C4/SemantiqueOperationnelle.lean` (3) | 8 |
| `loc` | `placed` | `\mathsf\{loc\}` | `C3/GrammaireDesTermes.lean` (2), `C3/ReglesDeTypage.lean` (1), `C4/SemantiqueOperationnelle.lean` (5) | 8 |

Dans `scripts/controles/croise.py`, les motifs du tableau `EXPECTED` portent ces mêmes mots (écrits en expressions régulières Python) : `mathsf\{inj\}`, `mathsf\{iter\}`, `mathsf\{vmap\}`, `mathsf\{open\}`,
`mathsf\{at\}` (le motif de `Alw^{-}` ; celui de `At` est `mathsf\{at\}_n` et ne change pas) et `mathsf\{loc\}_n`. Le script les réécrit aussi (ligne `croise.py` du CSV).

## 2. Occurrences en prose à relire à la main

Le script ne remplace que les formes `\mathsf{…}`. Les emplois en prose (en police de code, entre accents graves) sont listés ici pour relecture, parce qu'un mot comme `open` ou `at` est aussi un mot ordinaire :

* `open` : `C4/CalculDeProcessusSousJacent.lean` (1)
* `unpack` : `AnnexeA/DistinctionDePhaseEtMetaprogrammation.lean` (1), `C3/StructuresOuvertesEffetsEtMetaTheorie.lean` (2)
* `at` : aucune
* `inj` : aucune
* `iter` : aucune
* `vmap` : aucune

## 3. Entrées de glossaire à ajouter (noms N)

Le glossaire (`spec/Spec/Refs/ListeDesGlosses.lean`) ne porte aujourd'hui que quelques-uns des 49 noms. Au renommage, une entrée par nom N qui n'y figure pas, de la forme « genre puis différence », sans renvoi à une page ;
l'écriture de ces entrées est un travail éditorial, non mécanique. Noms déjà présents :

* présents (5) : opération à portée, observation, copatron, localisation, déclassification
* à ajouter (44) : variable, abstraction, application, thunk, force, return, liaison séquentielle, unité, élimination de l'unité, paire, décomposition de paire, injection, filtrage, conjonction additive, projection, pack, unpack, promotion, restitution, opération, repliage, dépliage, généralisation, instanciation, délai, permanence, lecture instantanée, présence, pas suivant, attente, déclenchement, pli indexé gradué, point fixe, mise en parallèle, application vectorisée, engendrement, découpe, création de boîte, émission, réception gardée, libération, marque de lieu, déplacement, récupération

## 4. Ordre d'application

1. ratification en bloc (ou par amendement de la table) ; 2. `python3 scripts/t68_renommer.py` (essai) puis `--appliquer` ; 3. entrées de glossaire ; 4. `lake build Spec`, `lake exe spec --output _out/spec --with-tex`,
`python3 scripts/controle.py`, `python3 scripts/suivi.py all` ; 5. une ligne à `spec/CHANGELOG.md` et au journal ; 6. commit `docs(spec): renommer les primitives (T-68)`.
