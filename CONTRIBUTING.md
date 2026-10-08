<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Contribuer à k7pl

Merci de votre intérêt pour k7pl. Ce document décrit le déroulement d'une
contribution ; les règles détaillées de rédaction (structure, nommage, en-têtes
SPDX, style Lean et Verso) sont dans
[`.claude/skills/writing-rules.md`](.claude/skills/writing-rules.md), qui fait
référence pour les humains comme pour les agents.

En participant, vous acceptez le [code de conduite](CODE_OF_CONDUCT.md).

## Mettre en place l'environnement

```sh
git clone https://github.com/AntheaLiles/k7pl.git && cd k7pl
lake exe cache get   # binaires Mathlib précompilés (elan installe la bonne version de Lean)
lake build && lake test
pip install reuse && reuse lint
```

## Déroulement

1. Ouvrir une issue pour toute proposition non triviale (changement du langage,
   nouvelle dépendance), afin d'en discuter avant d'écrire le code.
2. Créer une branche courte depuis `main` (`feat/lambda`, `fix/parser-precedence`…).
3. Faire des commits au format [Conventional Commits](https://www.conventionalcommits.org/fr/),
   avec `CHANGELOG.md` à jour. La CI vérifie **chaque commit** de la PR avec `.commitlintrc.yaml` :
   en-tête de 100 caractères au plus, type parmi `feat`, `fix`, `docs`, `style`, `refactor`, `perf`,
   `test`, `build`, `ci`, `chore`, portée en minuscules, sujet sans majuscule initiale ni point final.
   Un seul commit refusé fait échouer `CI OK`, et corriger un message déjà poussé oblige à réécrire
   l'historique de la branche : vérifier **avant** de pousser (voir « Vérifier ses commits »).
4. Ouvrir une pull request vers `main` en remplissant le modèle.
5. Le check `CI OK` doit passer. Il agrège l'analyse d'impact, les contrôles ciblés selon les
   fichiers modifiés (Lean : compilation, tests, lint, audit des axiomes ; spécification :
   contrôles, compilation, rendu), REUSE, Conventional Commits, actionlint et gitleaks.
6. Fusion par **rebase** (historique linéaire). Les contrôles de build vérifient la tête de la pull
   request, pas chaque commit pris isolément ; `commitlint`, lui, les lit tous.

Ne jamais réécrire l'historique d'une branche partagée (pas de force-push sur
`main`, ni sur la branche d'une autre personne).

### Vérifier ses commits

Avec Node installé (ce dépôt n'a pas de `package.json` : l'outil s'installe dans un dossier temporaire,
à côté d'une copie de la configuration, dont `extends` se résout depuis ce dossier) :

```sh
mkdir -p /tmp/commitlint && cp .commitlintrc.yaml /tmp/commitlint/
(cd /tmp/commitlint && npm init -y >/dev/null \
  && npm install --no-audit --no-fund @commitlint/cli@19 @commitlint/config-conventional@19)
/tmp/commitlint/node_modules/.bin/commitlint --cwd . --config /tmp/commitlint/.commitlintrc.yaml --from origin/main
```

Sans message d'erreur, la plage `origin/main..HEAD` est conforme à ce que contrôle la CI.

## Revue

Aujourd'hui, aucune revue par une seconde personne n'a lieu : k7pl est porté par une seule
personne, qui fusionne ses propres pull requests une fois le check `CI OK` réussi. Le ruleset de
`main` n'exige aucune approbation. Les agents d'assistance (Claude Code) rédigent, proposent et
vérifient des changements ; ils ne constituent pas une revue indépendante. Ce que cela implique
pour les critères de sécurité est détaillé dans
[`docs/security/OPENSSF-AUDIT.md`](docs/security/OPENSSF-AUDIT.md) (§ 6).

## Corriger la spécification

Le manuscrit est écrit en Verso (`spec/Spec/`, un module par chapitre et par section de
niveau 2) ; les règles d'écriture et les extensions disponibles (`{num}`, `{cite}`, `thm`,
`formula`, `figure`…) sont dans les [règles de rédaction](.claude/skills/writing-rules.md), §6 et §8.
Avant d'écrire, lire le [tableau de bord](docs/tracking/DASHBOARD.md) ; après un changement
notable, mettre à jour `docs/tracking/fiches-statuts.csv` puis lancer `python3 scripts/suivi.py all`.
Un énoncé corrigé change de sceau (`status`, `level` de la directive `thm`), il ne se réécrit
pas à l'identique.

## Langues

- **Français** : documentation (README, CONTRIBUTING, spécification Verso,
  règles de rédaction), issues et pull requests.
- **Anglais** : code source Lean (identifiants, docstrings, commentaires),
  messages affichés par le code, workflows et scripts.

Les messages de commit sont en français (voir les exemples des règles de rédaction).

## Preuves et axiomes

- Aucun `sorry` ni `admit` : tout avertissement fait échouer la compilation.
- Seuls les axiomes standard `propext`, `Classical.choice` et `Quot.sound`
  sont admis sous `K7pl` ; la CI le vérifie avec `axiom-audit`. Ajouter un
  axiome demande une discussion préalable dans une issue.

## Mettre à jour Lean et les dépendances

Lean, Mathlib, CSLib et Verso montent ensemble :
`scripts/bump-lean.sh vX.Y.Z`, puis `lake build && lake test`. Le workflow
`Bump Lean` ouvre automatiquement une PR chaque mois quand une nouvelle version
commune existe.

Le job d'impact de la CI lance `scripts/ci/check_manifest.py` (hors ligne) à chaque exécution : le
manifeste `lake-manifest.json` ne doit contenir que les 14 paquets connus, chacun lié à son dépôt.
Une nouvelle dépendance, y compris transitive, fait donc échouer la CI **volontairement** jusqu'à ce
qu'une personne l'ait relue et ajoutée à `ALLOWED_PACKAGES` dans `scripts/ci/check_manifest.py`
(`nom: propriétaire/dépôt`) ; la PR de `Bump Lean` n'aboutit pas seule dans ce cas.

## Publier une version

La spécification et l'implémentation ont des versions **indépendantes** :

| Release    | Tag            | Version déclarée dans           | Changelog            | Effet                               |
|------------|----------------|---------------------------------|----------------------|-------------------------------------|
| Spécification | `spec-vX.Y.Z` | `CITATION.cff` (`version`)     | `spec/CHANGELOG.md`  | brouillon de release avec le PDF, sa somme SHA-256 et son attestation ; archivage Zenodo après publication |
| Implémentation | `vX.Y.Z`     | `lakefile.lean` (`version`)    | `CHANGELOG.md`       | contrôles avant publication ; ni artefact ni Zenodo |

Les releases de ce dépôt sont conçues pour être **immuables** (la release existante l'est ; le réglage du
dépôt est à confirmer, voir [`docs/security/ACTIONS-HUMAINES.md`](docs/security/ACTIONS-HUMAINES.md), § 1.6) : une
fois publiée, une release immuable ne peut plus recevoir, remplacer ni perdre d'asset, et son tag ne peut plus bouger. La CI prépare donc tout *avant* la
publication, et **ne publie jamais** : la publication est un geste humain, irréversible. Une erreur
après publication impose une nouvelle version, et le nom d'un tag publié n'est pas réutilisable.

> **Statut.** Ce flux est écrit et vérifié par des outils statiques et des tests de ses scripts, mais
> il **n'a jamais été exécuté de bout en bout**. Avant la première release de spécification, suivre la
> liste de [`docs/security/ACTIONS-HUMAINES.md`](docs/security/ACTIONS-HUMAINES.md) (§ 5) : environnements
> protégés, règle de tags, décision sur le DOI, répétition sur le sandbox Zenodo.

### Spécification (`spec-vX.Y.Z`)

1. Dans une PR : passer `[Unreleased]` de `spec/CHANGELOG.md` en
   `## [X.Y.Z] - AAAA-MM-JJ`, et mettre à jour `version` et `date-released`
   dans `CITATION.cff`.
2. Après fusion, poser le tag sur un commit de `main` et le pousser :
   `git tag spec-vX.Y.Z <commit> && git push origin spec-vX.Y.Z`. Ne pas créer la release à la main.
3. `release.yaml` contrôle les métadonnées, que le commit est sur `main` et que `CI OK` y a réussi,
   reconstruit sans cache Actions, puis crée une release **en brouillon** contenant le PDF
   (`k7pl-spec.pdf`), sa somme (`.sha256`) et l'attestation (`.sigstore.json`).
4. Relire le brouillon, rejouer en local les commandes « Avant publication » de ses notes
   (`sha256sum -c`, puis `gh attestation verify --bundle` avec `--source-digest` et
   `--deny-self-hosted-runners`), puis le **publier**. GitHub génère alors l'attestation de la
   release : `gh release verify` et `gh release verify-asset` ne fonctionnent qu'à partir de là.
5. La publication déclenche `zenodo.yaml`, qui vérifie les assets publiés avant de les déposer. Il
   refuse de publier tant que les variables `ZENODO_ENV` (exactement `production` ou `sandbox`) et
   `ZENODO_CONCEPT_RECID` (l'identifiant du concept, ou `NEW` pour en créer un) ne sont pas
   renseignées dans l'environnement `zenodo`. Après un run avec `NEW`, renseigner la variable avec
   l'identifiant affiché dans le résumé du job, et **ne jamais rejouer ce run** : avec `NEW`, le
   script refuse de s'exécuter si `GITHUB_RUN_ATTEMPT` n'est pas `1`, et un échec après l'envoi de
   la publication (code de sortie 3) écrit le DOI et l'identifiant du concept dans le résumé du job.
6. Vérifier que le DOI de `CITATION.cff` et du README est le bon.

Métadonnées Zenodo : `zenodo.json` (communes) et `zenodo.files.json` (par PDF) ; le script y ajoute
à l'exécution le tag, le commit, l'URL de la release et la somme SHA-256 du PDF. `ZENODO_ENV=sandbox`
publie sur sandbox.zenodo.org avec un jeton du sandbox.

Un essai à blanc existe : le workflow `Release`, lancé à la main (`workflow_dispatch`), rejoue les
contrôles et la construction sans rien écrire. Il n'est disponible qu'une fois ce workflow sur
`main`, exige un commit déjà sur `main` et une version dont les métadonnées sont prêtes.

### Implémentation (`vX.Y.Z`)

1. Dans une PR : passer `[Unreleased]` de `CHANGELOG.md` en `## [X.Y.Z] - AAAA-MM-JJ`
   et mettre à jour `version` dans `lakefile.lean`.
2. Après fusion, pousser le tag `vX.Y.Z` sur un commit de `main`. `release.yaml` contrôle et vérifie
   l'implémentation **avant** toute publication ; il ne produit aucun artefact (une bibliothèque
   Lake est consommée en source, par son tag).
3. Quand ce run est vert, créer la release depuis le tag (notes tirées de `CHANGELOG.md`) : la publier
   la rend immuable.

## Sécurité

Ne pas signaler de vulnérabilité dans une issue publique : voir [SECURITY.md](SECURITY.md).
