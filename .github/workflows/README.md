<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Spécification des workflows CI/CD

Ce répertoire définit l'automatisation de construction, de vérification et de publication de k7pl.

La règle de conception centrale est :

`diff → surface d'impact → contrôles nécessaires`

Il n'existe pas de branche `dev` servant de zone « moins vérifiée ». Les branches de travail peuvent être incomplètes ; `main` reste la branche d'intégration. Le coût de validation est déterminé par l'impact technique du changement.

## Architecture

| Workflow | Déclenchement | Fonction |
|---|---|---|
| `ci.yaml` | PR, push sur `main`, manuel | Orchestration : classification d'impact, contrôles ciblés, contrôles invariants et `CI OK` ; sur `main`, publication de Pages (`deploy-pages`) et régénération de `docs/STATUS.md` (`status`) |
| `verify.yaml` | `workflow_call` | Chaîne réutilisable de validation Lean/Verso |
| `full.yaml` | Quotidien, manuel | Vérification complète du projet |
| `release.yaml` | Push d'un tag `spec-v*` ou `v*`, essai manuel | Contrôles avant publication ; brouillon de release attesté pour `spec-vX.Y.Z` (voir « Releases ») |
| `zenodo.yaml` | Release `spec-v*` publiée | Archivage sur Zenodo des octets de la release publiée, après vérification (voir « Publication Zenodo ») |
| `reuse.yaml` | Appelé par `ci.yaml`, manuel | Conformité REUSE |
| `commitlint.yaml` | Appelé par `ci.yaml`, manuel | Conventional Commits |
| `security.yaml` | Appelé par `ci.yaml`, manuel | actionlint + Gitleaks |
| `scorecard.yaml` | Planifié, push sur `main`, manuel | OpenSSF Scorecard |
| `bump-lean.yaml` | Planifié, manuel | Détection des mises à jour Lean/Mathlib/CSLib/Verso : un job construit sans secret, un second ouvre la PR |

`CI OK` est le seul status check exigé par le ruleset de `main`. Il agrège l'analyse d'impact, la validation ciblée et les trois contrôles invariants (REUSE, Conventional Commits et sécurité).

## Analyse d'impact

La classification est implémentée par `scripts/ci/impact.py`. Elle travaille sur les chemins réellement modifiés entre le commit de base et le commit courant. Pour garantir un comportement conservateur, tout chemin inconnu force une vérification complète.

`scripts/ci/impact.py` est la **seule** source des chemins qui forcent la vérification complète : `ci.yaml` n'en duplique plus la liste. Le classifieur et les autres scripts de `scripts/ci/` sont testés par `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` (bibliothèque standard seule, sans réseau). Le job d'impact exécute aussi `scripts/ci/check_manifest.py` (hors ligne) : un `lake-manifest.json` modifié par une PR ordinaire est contrôlé comme celui de la PR de `bump-lean`. Toute modification de `scripts/ci/**` est considérée comme une modification de l'infrastructure de CI et force donc la vérification complète.

Les surfaces sont les suivantes.

| Surface | Contrôles |
|---|---|
| `src/**`, `tests/**` | build Lean, tests, lint, audit des axiomes |
| `scripts/axiom-audit.sh` | build Lean **et** build de la spécification : le script est appelé par les deux chaînes |
| `spec/**`, `tools/**`, `docs/bibliography/**`, `scripts/controle.py`, `scripts/controles/**`, `scripts/manuscript_metrics.py` | contrôles statiques, build Verso, audit des axiomes, rendu HTML/TeX, PDF |
| `docs/tracking/primitives.md` | contrôles statiques de la spécification |
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
python3 scripts/ci/check_lean_modules.py
lake build K7pl K7plTests
lake test
lake lint
scripts/axiom-audit.sh K7pl K7pl
scripts/axiom-audit.sh <racine> +<racine>      # pour chaque racine de tests/ lue dans lakefile.lean
```

`check_lean_modules.py` détecte les fichiers Lean de `src/` et `tests/` qu'aucune racine de `lakefile.lean` n'atteint : `lake build` ne les compile jamais, et un `#guard` faux ou un avertissement n'y ferait donc pas échouer le build. Le script échoue bruyamment si la structure de `lakefile.lean` n'est pas reconnue.

L'audit d'axiomes des modules de test est lancé racine par racine, car `axiom-audit` prend un préfixe de nom de module et les modules de test sont plats. Les audits de `K7plTests` ne sont validés que par la CI GitHub : ils exigent Mathlib.

Le cache des dépendances Lake est partagé logiquement par l'implémentation et la spécification. Sa clé dépend de `lake-manifest.json` et de `lean-toolchain`.

## Validation de la spécification

La surface de spécification exécute :

```
python3 scripts/controle.py --format github
lake build Spec
scripts/axiom-audit.sh Spec Spec
scripts/axiom-audit.sh SpecExt SpecExt
scripts/axiom-audit.sh SpecBib SpecBib
lake exe spec --output _out/spec --with-tex
tectonic -X compile --keep-logs -Z deterministic-mode main.tex     # avec SOURCE_DATE_EPOCH
```

`SOURCE_DATE_EPOCH` vaut la date du commit construit ; sur un événement `pull_request`, c'est celle du commit de fusion synthétique de GitHub. Avec `-Z deterministic-mode`, cela retire deux sources de variation connues (date de construction, chemins absolus). Cela ne démontre **pas** que deux compilations donnent les mêmes octets : le bundle TeX de Tectonic est téléchargé à l'exécution et n'est pas épinglé, et aucun contrôle ne compile deux fois ni ne compare deux empreintes. Le PDF n'est donc **pas** présenté comme reproductible. Le journal de compilation est conservé (artefact `spec-pdf-log`) et résumé, sans seuil bloquant : aucun build sain n'a encore été observé.

L'entrée `use_cache` de `verify.yaml` (défaut `true`) permet de construire sans restaurer les caches de `.lake/packages` et de Tectonic : `release.yaml` l'utilise à `false`.

Une modification de `docs/tracking/primitives.md` nécessite les contrôles statiques mais pas le build/rendu Verso, car ce fichier est consommé directement par `scripts/controles/croise.py`.

Le PDF est un artefact dérivé : il n'est produit que lorsque le build de la spécification est nécessaire.

## Publication GitHub Pages

Sur `main`, Pages est publié seulement lorsqu'une modification affecte le build de la spécification. L'artefact HTML est produit par `verify.yaml`, puis déployé par le job `deploy-pages` de `ci.yaml` avec les permissions d'écriture limitées à ce job.

Une modification uniquement liée à l'implémentation ne reconstruit donc pas le manuscrit ni sa publication.

## Statut généré (`docs/STATUS.md`)

Sur un push sur `main`, une fois `CI OK` réussi, le job `status` de `ci.yaml` exécute `scripts/generate_status.py` puis, si nécessaire, pousse la branche `automation/generated-status` et ouvre ou met à jour sa PR vers `main`. Il déclenche ensuite explicitement `CI` par `workflow_dispatch` sur le commit généré ; cette exception est nécessaire car les événements créés par `GITHUB_TOKEN` ne relancent pas les workflows ordinaires. `docs/STATUS.md` est un fichier généré : il ne se modifie pas à la main.

C'est le seul job de `ci.yaml` qui écrit dans le dépôt : `contents: write` et `pull-requests: write`, avec `persist-credentials: true` à l'extraction (nécessaire à la poussée). Observations, à ne pas lire comme des garanties :

- le réglage « Allow GitHub Actions to create and approve pull requests » doit être activé pour que `gh pr create` aboutisse ; `docs/security/ACTIONS-HUMAINES.md` § 1.5 en tient compte ;
- une PR créée avec `GITHUB_TOKEN` ne déclenche pas automatiquement les workflows `pull_request` : le job `status` contourne ce mécanisme en déclenchant explicitement `workflow_dispatch` sur la branche générée ; la première exécution réelle de ce flux reste à observer avant de considérer le mécanisme comme vérifié ;
- le job n'exécute que du code déjà fusionné sur `main` ; la branche `automation/generated-status` n'est pas protégée par le ruleset de `main`.

Voir `docs/security/DECISIONS-REQUISES.md`, D11.

## Vérification complète

`full.yaml` exécute tous les contrôles de fond Lean et Verso, plus le rendu PDF. Il est programmé quotidiennement et reste déclenchable manuellement.

Cette vérification détecte les interactions entre surfaces que l'analyse locale d'une PR ne peut pas garantir. Elle complète les contrôles ciblés ; elle ne les remplace pas.

## Releases

Les releases sont séparées de la CI de PR. Les releases GitHub de ce dépôt sont conçues pour être **immuables** (la release existante l'est ; le réglage du dépôt est à confirmer) : une fois publiée, une release immuable ne peut plus recevoir, remplacer ni perdre d'asset, et son tag ne peut plus bouger. Tout ce qui doit être joint l'est donc **avant** la publication, tout contrôle bloquant s'exécute **avant** la publication, et l'étape irréversible vient en dernier, par un geste humain.

1. L'humain pousse le tag `spec-vX.Y.Z` (ou `vX.Y.Z`) sur un commit de `main`.
2. `release.yaml` contrôle les métadonnées (`CITATION.cff` et `spec/CHANGELOG.md` pour la spécification ; `lakefile.lean` et `CHANGELOG.md` pour l'implémentation), que le commit tagué est un ancêtre de `main` et que le check `CI OK` d'GitHub Actions a réussi sur ce commit. Il reconstruit sans cache Actions (`use_cache: false` ; le cache binaire de Mathlib, tiré par `lake exe cache get`, reste utilisé par la chaîne d'implémentation) et rejoue les contrôles de la chaîne concernée.
3. Pour `spec-vX.Y.Z` seulement, le job `draft` calcule le checksum SHA-256 du PDF, génère l'attestation de provenance (`actions/attest`) et crée une release **en brouillon** contenant le PDF, son checksum et le bundle d'attestation `k7pl-spec.pdf.sigstore.json`. Il ne publie jamais. Pour `vX.Y.Z`, aucun artefact n'est produit : une bibliothèque Lake est consommée en source, par son tag.
4. L'humain relit le brouillon, rejoue en local les commandes de vérification (elles figurent dans les notes du brouillon), puis publie. La release devient immuable et GitHub génère son attestation de release.
5. La publication d'une release `spec-v*` déclenche `zenodo.yaml`.

`workflow_dispatch` est un **essai** : mêmes contrôles et même build, sans brouillon, sans attestation, sans écriture. Il exige un commit déjà présent sur `main`, et n'est possible qu'une fois ce workflow fusionné sur `main`.

**Ce que l'attestation prouve.** Le PDF a été attesté par une exécution de `release.yaml` de ce dépôt, au tag et au commit indiqués, sur un runner hébergé par GitHub. **Ce qu'elle ne prouve pas** : que le PDF est reproductible, que les entrées du build (toolchain, bundle TeX) sont exemptes de code malveillant, que le commit a été relu, ni quoi que ce soit sur la vérité de la spécification. L'identité liée est un workflow, pas une personne. Le PDF est construit par un job et attesté par un autre ; il transite par un artefact du même run.

**Les contrôles du job `check` protègent de l'erreur, pas d'un acteur capable de pousser un tag** : pour un tag poussé, GitHub exécute le workflow du commit tagué. Les barrières réelles sont la restriction de la **création** des tags (contournement limité au rôle administrateur), l'environnement `zenodo` protégé (dont le relecteur est la même identité que celle des agents : une porte manuelle, non une revue indépendante) et la relecture humaine du brouillon (voir `docs/security/ACTIONS-HUMAINES.md`).

**Statut.** Ce flux est écrit et vérifié par `actionlint`, `zizmor` hors ligne et des tests de ses blocs de script, mais **n'a jamais été exécuté de bout en bout**. La seule release existante (`spec-v0.0.0-alpha.1`) n'a aucun artefact joint et ne peut plus en recevoir. La première release produite par ce flux doit être précédée d'une répétition sur le sandbox Zenodo.

## Intégrité de Tectonic

Tectonic est téléchargé depuis une URL versionnée et son archive Linux x86_64 musl est vérifiée avant extraction :

```
TECTONIC_VERSION = 0.15.0
TECTONIC_SHA256  = dfb82876f2986862996e564fa507a9e576e0c1e3bee63c2c1bd677c2543e6407
```

Cette somme est enregistrée dans le même dépôt : elle détecte une dérive de l'archive, elle n'en prouve pas l'authenticité. Le bundle TeX que Tectonic télécharge ensuite n'est pas épinglé.

Les actions GitHub sont appelées par SHA et annotées par leur version lisible. Ce que les actions composites téléchargent à leur tour (elan, actionlint, images Docker par tag…) n'est pas vérifié par empreinte : voir « Limites connues » dans `SECURITY.md`.

## Publication Zenodo et identifiants

Un DOI Zenodo est irréversible : `zenodo.yaml` échoue donc par défaut et ne reconstruit rien. Il s'exécute dans l'environnement `zenodo` (jeton en secret d'environnement, `ZENODO_ENV` et `ZENODO_CONCEPT_RECID` en variables), télécharge les assets de la release **publiée**, vérifie la release (`gh release verify`), chaque asset (`gh release verify-asset`) et l'attestation du PDF contre `release.yaml` au tag et au commit de la release (`gh attestation verify`), et seulement ensuite dépose ces octets-là.

`scripts/sync_zenodo.py` refuse, avant tout appel réseau, de publier si `ZENODO_ENV` n'est pas exactement `production` ou `sandbox`, ou si `ZENODO_CONCEPT_RECID` est absent ou invalide (un entier, ou `NEW` pour créer explicitement un nouveau concept). Une release déjà archivée n'est pas republiée. Un run avec `NEW` ne doit jamais être rejoué : renseigner ensuite la variable avec l'identifiant affiché dans le résumé du job. `NEW` ne peut pas savoir que l'enregistrement existe déjà ; le script refuse donc de s'exécuter, avant tout appel réseau, si `GITHUB_RUN_ATTEMPT` est absent ou différent de `1` (un « Re-run » est refusé). Toute erreur après l'envoi de la demande de publication (réponse inattendue, connexion perdue, échec du rapport) écrit le DOI, le résumé (concept, « ne pas rejouer ») et sort avec le code 3 ; une interruption est ré-élevée après ce rapport ; seules les réponses 400, 401, 403, 404 et 422 à la demande de publication prouvent qu'aucune publication n'a eu lieu ; une réponse perdue ou une erreur 5xx y est signalée comme « publication incertaine », à vérifier sur Zenodo avant toute reprise.

Il n'y a plus de branche `zenodo-state` ni d'écriture dans le dépôt. L'origine du DOI `10.5281/zenodo.23040451` cité par le dépôt n'est pas établie par celui-ci : c'est une décision de l'autrice (voir `docs/security/DECISIONS-REQUISES.md`, D1).

Le workflow `bump-lean.yaml` sépare la construction (`contents: read`, aucun secret : il exécute du code amont) de l'ouverture de la PR (environnement `bump-lean`, qui détient `BUMP_TOKEN` et n'exécute aucun code Lean ; il contrôle le manifeste avec `scripts/ci/check_manifest.py --check-tags --check-upstream`, dont l'en-tête de `bump-lean.yaml` liste ce qui est vérifié et ce qui ne l'est pas : une nouvelle dépendance transitive fait échouer ce contrôle jusqu'à ce qu'une personne l'ajoute à `ALLOWED_PACKAGES`). Une PR créée avec `GITHUB_TOKEN` ne déclenche pas les workflows de PR normaux ; `BUMP_TOKEN` reste donc requis.

## Invariants

Les workflows doivent respecter les invariants suivants :

- `main` est la branche d'intégration ; aucune branche `dev` n'est nécessaire.
- Les Conventional Commits ne servent pas à contourner des contrôles techniques.
- La classification est basée sur les chemins modifiés.
- Toute incertitude de classification augmente le périmètre de vérification.
- Les contrôles invariants sont indépendants de l'impact.
- `CI OK` ne réussit que si tous les contrôles obligatoires requis par la CI réussissent.
- Aucun artefact ou élément de provenance ne doit être considéré comme publié sans succès du workflow qui le produit.
- La CI ne publie jamais une release : elle prépare un brouillon, l'humain publie.
- Les contrôles qui conditionnent une release s'exécutent avant sa publication, et le build d'une release n'utilise aucun cache Actions.
- Les artefacts de spécification sont dérivés de jobs de build réussis ; aucune affirmation de reproductibilité n'est faite tant qu'elle n'est pas démontrée.
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
