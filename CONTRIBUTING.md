<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
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
3. Faire des commits au format [Conventional Commits](https://www.conventionalcommits.org/fr/)
   (vérifié en CI), avec `CHANGELOG.md` à jour.
4. Ouvrir une pull request vers `main` en remplissant le modèle.
5. Tous les checks doivent passer : compilation, tests, lint, audit des axiomes,
   REUSE, Conventional Commits, actionlint, gitleaks.
6. Fusion par **rebase** (historique linéaire, chaque commit ayant déjà été vérifié).

Ne jamais réécrire l'historique d'une branche partagée (pas de force-push sur
`main`, ni sur la branche d'une autre personne).

## Corriger la spécification

Le manuscrit est écrit en Verso (`spec/Spec/`, un module par chapitre et par section de
niveau 2) ; les règles d'écriture et les extensions disponibles (`{num}`, `{cite}`, `thm`,
`formula`, `figure`…) sont dans les [règles de rédaction](.claude/skills/writing-rules.md), §6 et §8.
Avant d'écrire, lire le [tableau de bord](docs/suivi/TABLEAU-DE-BORD.md) ; après un changement
notable, mettre à jour `docs/suivi/fiches-statuts.csv` puis lancer `python3 scripts/suivi.py all`.
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

## Publier une version

La spécification et l'implémentation ont des versions **indépendantes** :

| Release    | Tag            | Version déclarée dans           | Changelog            | Effet                               |
|------------|----------------|---------------------------------|----------------------|-------------------------------------|
| Spécification | `spec-vX.Y.Z` | `CITATION.cff` (`version`)     | `spec/CHANGELOG.md`  | PDF publié sur Zenodo et joint à la release |
| Implémentation | `vX.Y.Z`     | `lakefile.lean` (`version`)    | `CHANGELOG.md`       | Contrôle de cohérence, pas de Zenodo |

Dans les deux cas, la CI refuse la release si la version du tag ne correspond
pas au fichier de version et au changelog.

### Spécification (`spec-vX.Y.Z`)

1. Dans une PR : passer `[Unreleased]` de `spec/CHANGELOG.md` en
   `## [X.Y.Z] - AAAA-MM-JJ`, et mettre à jour `version` et `date-released`
   dans `CITATION.cff`.
2. Après fusion, créer la release sur `main` avec le tag `spec-vX.Y.Z`
   (titre conseillé : « Spécification X.Y.Z »).
3. La CI compile le PDF (artefact `spec-pdf`), le publie sur Zenodo, l'attache
   à la release et enregistre l'état Zenodo sur la branche `zenodo-state`.
4. Après la première publication, ajouter le DOI de concept (affiché dans le
   résumé du job `zenodo`) dans `CITATION.cff` (`identifiers`) et dans le README.

Métadonnées Zenodo : `zenodo.json` (communes) et `zenodo.files.json` (par PDF).
Le secret `ZENODO_ENV=sandbox` permet de tester sur sandbox.zenodo.org
(avec un jeton `ZENODO_TOKEN` du sandbox).

### Implémentation (`vX.Y.Z`)

1. Dans une PR : passer `[Unreleased]` de `CHANGELOG.md` en `## [X.Y.Z] - AAAA-MM-JJ`
   et mettre à jour `version` dans `lakefile.lean`.
2. Après fusion, créer la release sur `main` avec le tag `vX.Y.Z`
   (titre conseillé : « k7pl X.Y.Z »).

## Sécurité

Ne pas signaler de vulnérabilité dans une issue publique : voir [SECURITY.md](SECURITY.md).
