<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# Spécification des workflows CI/CD

Ce répertoire définit l'automatisation de construction, de vérification et de publication de k7pl.

La règle de conception centrale est :

`diff → surface d'impact → contrôles nécessaires`

Il n'existe pas de branche `dev` servant de zone « moins vérifiée ». Les branches de travail peuvent être incomplètes ; `main` reste la branche d'intégration. Le coût de validation est déterminé par l'impact technique du changement.

## Architecture

| Workflow | Déclenchement | Fonction |
|---|---|---|
| `ci.yaml` | PR, push sur `main`, manuel | Orchestration : classification d'impact, contrôles ciblés, contrôles invariants et `CI OK` |
| `verify.yaml` | `workflow_call` | Chaîne réutilisable de validation Lean/Verso |
| `full.yaml` | Quotidien, manuel | Vérification complète du projet |
| `release.yaml` | Release GitHub publiée | Vérification et publication de `vX.Y.Z` et `spec-vX.Y.Z` |
| `reuse.yaml` | Appelé par `ci.yaml`, manuel | Conformité REUSE |
| `commitlint.yaml` | Appelé par `ci.yaml`, manuel | Conventional Commits |
| `security.yaml` | Appelé par `ci.yaml`, manuel | actionlint + Gitleaks |
| `scorecard.yaml` | Planifié, push sur `main`, manuel | OpenSSF Scorecard |
| `bump-lean.yaml` | Planifié, manuel | Détection et préparation des mises à jour Lean/Mathlib/CSLib/Verso |

`CI OK` est le seul status check exigé par le ruleset de `main`. Il agrège l'analyse d'impact, la validation ciblée et les trois contrôles invariants (REUSE, Conventional Commits et sécurité).

## Analyse d'impact

La classification est implémentée par `scripts/ci/impact.py`. Elle travaille sur les chemins réellement modifiés entre le commit de base et le commit courant. Pour garantir un comportement conservateur, tout chemin inconnu force une vérification complète.

Le classifieur est lui-même testé par `scripts/ci/test_impact.py`. Toute modification de `scripts/ci/**` est considérée comme une modification de l'infrastructure de CI et force donc la vérification complète.

Les surfaces sont les suivantes.

| Surface | Contrôles |
|---|---|
| `src/**`, `tests/**`, `scripts/axiom-audit.sh` | build Lean, tests, lint, audit des axiomes |
| `spec/**`, `tools/**`, `biblio/**`, `scripts/controle.py`, `scripts/controles/**`, `scripts/manuscript_metrics.py` | contrôles statiques, build Verso, audit des axiomes, rendu HTML/TeX, PDF |
| `docs/suivi/primitives.md` | contrôles statiques de la spécification |
| `*.md` | contrôle des liens locaux |
| `docs/**`, `.claude/**`, `.github/ISSUE_TEMPLATE/**`, `LICENSES/**`, `CITATION.cff` | documentation/configuration légère ; contrôles invariants seulement, avec contrôle des liens pour Markdown |
| `.github/workflows/**`, `.github/dependabot.yml` | vérification complète |
| `lakefile.lean`, `lean-toolchain`, `lake-manifest.json` | vérification complète |
| `scripts/sync_zenodo.py`, `scripts/requirements-zenodo.txt` | vérification complète |

Les surfaces se cumulent. Par exemple, une PR modifiant `src/**` et `spec/**` exécute les chaînes Lean et Verso.

Le routage ne dépend pas du préfixe Conventional Commit. Un commit `docs:` ne reçoit donc pas automatiquement un passe-droit et un commit `feat:` ne déclenche pas automatiquement davantage de contrôles.

## Contrôles invariants

Les contrôles REUSE, Conventional Commits et Security sont exécutés sur toutes les PR via des workflows réutilisables appelés par `ci.yaml`. Ils ne sont pas supprimés par l'analyse d'impact.

Cette séparation permet à `CI OK` de rester l'unique check obligatoire tout en rendant effectivement bloquant l'échec de l'un de ces contrôles.

## Validation Lean

La surface Lean exécute :

```
lake build K7pl K7plTests
lake test
lake lint
scripts/axiom-audit.sh K7pl K7pl
```

Le cache des dépendances Lake est partagé logiquement par l'implémentation et la spécification. Sa clé dépend de `lake-manifest.json` et de `lean-toolchain`.

## Validation de la spécification

La surface de spécification exécute :

```
python3 scripts/controle.py --format github
lake build Spec
scripts/axiom-audit.sh Spec Spec
lake exe spec --output _out/spec --with-tex
tectonic -X compile --keep-logs main.tex
```

Une modification de `docs/suivi/primitives.md` nécessite les contrôles statiques mais pas le build/rendu Verso, car ce fichier est consommé directement par `scripts/controles/croise.py`.

Le PDF est un artefact dérivé : il n'est produit que lorsque le build de la spécification est nécessaire.

## Publication GitHub Pages

Sur `main`, Pages est publié seulement lorsqu'une modification affecte le build de la spécification. L'artefact HTML est produit par `verify.yaml`, puis déployé par le job `deploy-pages` de `ci.yaml` avec les permissions d'écriture limitées à ce job.

Une modification uniquement liée à l'implémentation ne reconstruit donc pas le manuscrit ni sa publication.

## Vérification complète

`full.yaml` exécute tous les contrôles de fond Lean et Verso, plus le rendu PDF. Il est programmé quotidiennement et reste déclenchable manuellement.

Cette vérification détecte les interactions entre surfaces que l'analyse locale d'une PR ne peut pas garantir. Elle complète les contrôles ciblés ; elle ne les remplace pas.

## Releases

Les releases sont séparées de la CI de PR.

Pour `vX.Y.Z`, `release.yaml` vérifie l'implémentation et sa cohérence avec `lakefile.lean` et `CHANGELOG.md`.

Pour `spec-vX.Y.Z`, il vérifie `CITATION.cff` et `spec/CHANGELOG.md`, génère le PDF, produit un checksum SHA-256, puis génère une attestation de provenance avec GitHub Artifact Attestations. Le PDF et son checksum sont joints à la release et la publication Zenodo est effectuée ensuite.

L'attestation de provenance est une preuve signée de la relation entre l'artefact et son processus de build ; elle ne constitue pas à elle seule une signature cryptographique du tag Git.

## Intégrité de Tectonic

Tectonic est téléchargé depuis une URL versionnée et son archive Linux x86_64 musl est vérifiée avant extraction :

```
TECTONIC_VERSION = 0.15.0
TECTONIC_SHA256  = dfb82876f2986862996e564fa507a9e576e0c1e3bee63c2c1bd677c2543e6407
```

Les actions GitHub sont appelées par SHA et annotées par leur version lisible.

## Publication Zenodo et identifiants

Le job Zenodo utilise `persist-credentials: false`. Le token du job est injecté uniquement lors du push vers `zenodo-state`.

Le workflow `bump-lean.yaml` exige désormais le secret `BUMP_TOKEN`. Une PR créée avec `GITHUB_TOKEN` ne reçoit pas nécessairement les événements de PR normaux ; l'automatisation ne tombe donc plus silencieusement sur un chemin de création qui contournerait la CI standard.

## Invariants

Les workflows doivent respecter les invariants suivants :

- `main` est la branche d'intégration ; aucune branche `dev` n'est nécessaire.
- Les Conventional Commits ne servent pas à contourner des contrôles techniques.
- La classification est basée sur les chemins modifiés.
- Toute incertitude de classification augmente le périmètre de vérification.
- Les contrôles invariants sont indépendants de l'impact.
- `CI OK` ne réussit que si tous les contrôles obligatoires requis par la CI réussissent.
- Aucun artefact ou élément de provenance ne doit être considéré comme publié sans succès du workflow qui le produit.
- Les artefacts de spécification sont toujours dérivés d'une validation réussie.
- Toute modification de l'infrastructure CI ou des dépendances critiques déclenche une vérification complète.

## Rapport entre les objets du projet

La CI reflète la séparation épistémique du dépôt :

```
spécification normative
        ↓
formalisation Verso
        ↓
implémentation Lean
        ↓
preuves / audits
        ↓
tests
        ↓
artefacts publiés
```

Chaque contrôle possède ainsi une propriété cible, une surface d'applicabilité et un oracle distincts.

`README.md` est une spécification descriptive. Le comportement effectif est défini par les workflows et `scripts/ci/impact.py`. Toute divergence entre les deux doit être corrigée.
