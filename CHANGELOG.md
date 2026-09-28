<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# Changelog

Toutes les modifications notables de ce projet sont consignées dans ce fichier.

Le format s'inspire de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).

## [Unreleased]

### Added

- Initialisation du dépôt (structure, licences REUSE, CI, projet Lake).
- Dépendances Mathlib, CSLib et Verso, épinglées sur Lean v4.34.0.
- Exemples : `K7pl.Arith` (Mathlib), `K7pl.Semantics` (CSLib) et leurs tests.
- Spécification en Verso (`spec/`) et générateur HTML (`lake exe spec`).
- CI : compilation, tests et génération de la spécification ; lint Conventional Commits.

- Options Lean strictes (`autoImplicit` désactivé, avertissements bloquants),
  linters Mathlib, `lake lint` (Batteries) et audit des axiomes en CI.
- Publication de la spécification sur GitHub Pages.
- CI de sécurité : actionlint, gitleaks, OpenSSF Scorecard ; Dependabot pour les
  GitHub Actions ; actions épinglées par SHA.
- Montée de version groupée de Lean, Mathlib, CSLib et Verso
  (`scripts/bump-lean.sh`, workflow mensuel).
- `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `CITATION.cff`,
  modèles d'issues et de pull request.
- Hook `SessionStart` pour les sessions Claude Code sur le web.

### Changed

- Les spécifications passent d'Org-mode à Verso.
- Le code source (identifiants, docstrings, commentaires) est désormais en anglais.
