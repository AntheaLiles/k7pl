<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# CI — mesure initiale et reconnaissance (lot 0)

Dernier run réussi de « Lean Build » sur `main` : [37301418064](https://github.com/AntheaLiles/k7pl/actions/runs/37301418064)
(`50abe58`, push, 5 octobre 2026). Durées relevées par `gh api …/actions/runs/<id>/jobs`.

## 0.1 — Durées par étape

| Job | Étape | Durée | % du job |
|---|---|--:|--:|
| `build` (589 s) | `lean-action` (cache Mathlib + build + test + lint + audit) | 563 s | 95,6 % |
| | rendu de la spécification (HTML + TeX) | 12 s | 2,0 % |
| | reste (checkout, `controle.py`, uploads) | 14 s | 2,4 % |
| `spec-pdf` (92 s) | compilation du PDF (Tectonic) | 78 s | 84,8 % |
| | sauvegarde du cache Tectonic | 5 s | 5,4 % |
| `deploy-spec` (44 s) | déploiement Pages | 39 s | 88,6 % |
| `release-check`, `zenodo` | ignorés (événement `push`) | 0 s | — |

Chemin critique du push : `build` → `spec-pdf` ≈ 589 + 92 = **≈ 11 min 20 s** (`deploy-spec` en parallèle de `spec-pdf`).
**Limite de la mesure** : l'API ne ventile pas l'intérieur de l'étape `lean-action` (cache, build, test, lint,
audit) ; les journaux bruts ne sont pas accessibles par ce canal. Le lot 4 ventilera ces postes en les séparant.

## 0.2 — `Spec` importe-t-il Mathlib ?

`grep -rn "^import Mathlib\|^import Cslib" spec/ tools/` → **aucun résultat**. Les imports de `tools/` sont
`VersoManual`, `Spec`, `SpecBib`, `SpecExt.*`. **Hypothèse du lot 5 confirmée** : la spécification ne dépend
ni de Mathlib ni de CSLib.

## 0.3 — `src/K7pl` dépend-il de Verso ?

`grep -rn "^import Verso\|^import SubVerso\|^import Spec" src/ tests/` → **aucun résultat**. Imports de `src/` et
`tests/` : `Mathlib.Tactic.Ring`, `Cslib.Foundations.Semantics.LTS.Basic`, `K7pl.*`, modules de test.
**Hypothèse symétrique confirmée.**

## 0.4 — `lean-action` v1.6.0 (`50fcf42d`)

Lu dans `action.yml` et `scripts/run_axiom_audit.sh` à ce SHA :

* **`axiom-audit-root` n'accepte qu'une racine** : le script ajoute `--root "$AXIOM_AUDIT_ROOT"` (valeur
  unique) ; vide, l'outil prend la première `lean_lib` du lakefile. Pour auditer `Spec`, il faut un second
  appel de l'outil (lot 8).
* **L'audit lance un `lake build` nu** (« `lake build` is a no-op if the project is already up to date »).
  Or `K7pl` **et** `Spec` sont `@[default_target]` : **dans le job `impl`, l'audit via `lean-action`
  compilerait Verso**, ce qui annule le gain du lot 4. Même constat pour l'étape `build` : elle exécute
  `lake build $BUILD_ARGS`, `build-args` étant vide par défaut ; il faut donc `build-args: "K7pl K7plTests"`.
  **Point à trancher** (ne pas toucher `lakefile.lean`) : exécuter l'audit nous-mêmes dans `impl` — cloner
  `axiom-audit` `v0.1.2` (SHA `46024e00…`, vérifié par le script d'origine), le compiler avec la toolchain du
  projet, puis `lake env …/axiom-audit --allow … --root K7pl` — au lieu de `axiom-audit: true`.
* **Cache `use-github-cache`** (défaut `true`, **déjà actif aujourd'hui**) : restaure et sauvegarde
  `<lake-package-directory>/.lake` entier, clé `lake-<os>-<arch>-<hash toolchain>-<hash manifest>-<github.sha>`,
  `restore-keys` = même préfixe sans le SHA. La clé contient `github.sha` : **chaque run écrit une nouvelle entrée**,
  y compris depuis une branche de PR, ce qui consomme le quota de 10 Go (le critère « aucune entrée depuis une
  branche de PR » du lot 5 est donc violé aujourd'hui).
* **Ordre interne** : `build` → `test` → `lint` → `axiom-audit` (conditions `run-lake-*` de l'étape `config`,
  audit si `axiom-audit == 'true'`) ; `lake exe cache get` s'exécute dans une étape « get mathlib cache » **avant**
  le build, déclenchée par détection de Mathlib ou `use-mathlib-cache: true`.
* **Idempotence d'un double appel** : non établie. Les étapes de restauration et de sauvegarde du cache sont
  gardées par `use-github-cache == 'true'` ; un second appel avec la même clé tenterait de réécrire une entrée
  existante (comportement de `actions/cache` : avertissement, pas échec, mais **non vérifié ici**). Le lot 5
  prévoit `use-github-cache: false` partout, ce qui évite la question.

## 0.5 — Taille des artefacts de dépendances

`gh cache list` / `…/actions/caches` : **refusés par le proxy de session (HTTP 403)** — la taille des caches
existants n'a donc pas pu être lue. Mesure locale partielle (`du -sh .lake/packages/*/.lake/build`, build local
**incomplet** : ni CSLib ni l'arbre complet de Mathlib) :

| Paquet | Build local |
|---|--:|
| `verso` | 407 Mo |
| `subverso` | 63 Mo |
| `illuminate` | 51 Mo |
| `MD4Lean` | 3 Mo |
| `batteries` | 2 Mo |
| `mathlib` (partiel) | 130 Mo |
| `.lake/packages` (sources + builds) | 1,4 Go |

Les paquets hors Mathlib/CSLib (`verso`, `subverso`, `illuminate`, `MD4Lean`) pèsent ≈ 520 Mo décompressés, soit
largement sous 2 Go compressés. **Reste à mesurer en CI** (étape `du -sh` temporaire) : CSLib complet, et le
`.lake` actuel mis en cache par `lean-action` (probablement la plus grosse entrée, Mathlib compris).

## Conséquences pour la suite

1. Lot 4 : confirmé réalisable (0.2 et 0.3), **mais** `lean-action` ne peut pas rester l'exécutant de l'audit
   d'axiomes ni du build nu dans `impl` (0.4). Proposition : `build-args: "K7pl K7plTests"`, `test`/`lint` via
   l'action, **audit d'axiomes exécuté par une étape dédiée** (même outil, même SHA).
2. Lot 5 : le cache natif de `lean-action` est déjà actif et écrit à chaque run ; le désactiver (`use-github-cache: false`)
   et le remplacer par le cache ciblé fera baisser la consommation du quota.
3. Lot 8.1 : `Spec` s'audite par un second appel de l'outil avec `--root Spec`.
