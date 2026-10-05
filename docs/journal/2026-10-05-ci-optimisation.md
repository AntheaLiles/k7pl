<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Optimisation de la CI : lots réalisés (5 octobre 2026)

Suite de `2026-10-05-ci-mesure-initiale.md`. PR n° 7 (brouillon).

## Réalisé

| Lot | Contenu | Résultat |
| --- | --- | --- |
| 1 | Déclencheurs (`push` limité à `main`), `concurrency`, `timeout-minutes`, rétention des artefacts, clé du cache Tectonic, actions épinglées par SHA | actionlint vert |
| 3 | Job `quick` : `scripts/controle.py` (Python pur, sans toolchain Lean) | 5 s |
| 4 | Scission `impl` (`K7pl K7plTests`, test, lint, audit) / `spec` (`Spec`, rendu) / `ci-ok` ; audit d'axiomes par `scripts/axiom-audit.sh` (build ciblé) | `impl` 6 min 18, `spec` 6 min 03, en parallèle ; audit 8 s |

Durée totale observée sur la PR (`c70d48e`) : environ 8 min, jobs `impl` et `spec` en parallèle
(cache Mathlib froid pour `impl` : à ré-évaluer après cache chaud).

## Reporté (non réalisé dans cette passe)

Lots 2 (problem matcher, `NO_COLOR`), 5 (cache `.lake` ciblé par job), 6 (annotations
`controle.py --format=github`), 7 (résumés de job), 8 (audit des axiomes de `Spec`, lychee
`--offline`, gitleaks sur plage), 9 (filtrage par chemins). Aucun n'est bloquant ; à reprendre
si les temps restent trop longs.

## Action humaine

Dans les réglages du dépôt, remplacer les required checks par le seul `CI OK`
(les anciens noms de job `build` n'existent plus). Fusion de la PR : à votre accord.
