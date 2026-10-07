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

| 5 | Étapes Lean explicites (mesurables) + cache `.lake/packages` à clé immuable (`lake-manifest.json` + `lean-toolchain`), un par job (`lakedeps-impl-*`, `lakedeps-spec-*`) | voir ci-dessous |

### Mesures (PR n° 7, mêmes commits, tentative 1 = cache froid, tentative 2 = cache chaud)

| Poste | Avant (`build`) | Cache froid | Cache chaud |
| --- | --- | --- | --- |
| Récupération Mathlib (`impl`) | ≈ 563 s (tout `lean-action`) | 240 s | 28 s (+ 32 s de restauration) |
| `lake test` (`impl`) | | 203 s (lien de l'exécutable : compile en C les modules Mathlib importés) | < 5 s |
| Build `Spec` (`spec`) | | 330 s | 67 s |
| Rendu HTML+TeX | 12 s | 14 s | 17 s |
| **Job `impl`** | 589 s (job unique) | ≈ 8 min | **≈ 1 min 30** |
| **Job `spec`** | | ≈ 6 min | **≈ 2 min** |

`CI OK` est atteint à cache chaud en ≈ 2 min, au lieu de ≈ 10 min. Le job `spec-pdf` (≈ 90 s) ne
conditionne pas `CI OK`. Seul le premier run après un changement de `lake-manifest.json` ou de
`lean-toolchain` est à froid.

### Lots 6, 7, 8 (réalisés)

* Lot 6 : `scripts/controle.py --format github` (groupes de log par contrôle, annotation `::error::`
  par échec, résumé dans `$GITHUB_STEP_SUMMARY`) ; le format `text` reste le défaut.
* Lot 7 : résumés de job (`impl`, `spec`), et `lint` / audit s'exécutent même si les tests
  échouent (`if: !cancelled()`) : un run rapporte tous les problèmes, sans `continue-on-error`,
  qui aurait masqué l'échec dans `CI OK`.
* Lot 8 : audit d'axiomes de `Spec` (`scripts/axiom-audit.sh Spec Spec`, vert) ; vérification
  hors ligne des liens relatifs Markdown par lychee (`--offline`, 0 erreur). gitleaks analyse déjà
  l'historique complet (`fetch-depth: 0`).

## Reporté

Lot 2 (problem matcher, `NO_COLOR`) et lot 9 (filtrage par chemins) : sans effet mesurable à
cache chaud (jobs de 1 à 2 min), non réalisés.

## Action humaine

Dans les réglages du dépôt, remplacer les required checks par le seul `CI OK`
(les anciens noms de job `build` n'existent plus). Fusion de la PR : à votre accord.
