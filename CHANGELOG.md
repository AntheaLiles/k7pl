<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# Changelog

Toutes les modifications notables de ce projet sont consignées dans ce fichier.

Ce fichier suit l'implémentation et le dépôt (releases `vX.Y.Z`) ; la
spécification a son propre historique dans [`spec/CHANGELOG.md`](spec/CHANGELOG.md)
(releases `spec-vX.Y.Z`).

Le format s'inspire de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).

## [Unreleased]

### Added

- Le manuscrit de la spécification en Verso (`spec/`), converti de l'Org-mode ; extensions Verso
  (`tools/SpecExt/` : renvois, énoncés scellés, formules, figures, tableaux, citations par
  chapitre, remarques marginales, listes) ; bibliographie générée (`tools/SpecBib.lean`,
  `biblio/references.json`).
- Conversion Org → Verso reproductible (`scripts/org2verso/`), chaîne bibliographique
  (`scripts/biblio/`), conversion Org → Markdown (`scripts/org2md.py`), mesures du manuscrit et
  vues du suivi (`scripts/manuscript_metrics.py`, `scripts/suivi.py`).
- `docs/` : suivi (tableau de bord, 190 fiches de la campagne PR-02, décisions, anomalies),
  relectures, méthode, recherche, journal de séances ; `archives/` : manuscrit Org figé et ancien
  outillage.
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
- PDF de la spécification généré en CI (Verso → TeX → LuaLaTeX, artefact `spec-pdf`).
- Publication sur Zenodo à chaque release `spec-vX.Y.Z` (`scripts/sync_zenodo.py`,
  adapté de quickViz) ; le PDF est aussi joint à la release. Les releases de
  l'implémentation (`vX.Y.Z`) sont indépendantes.

### Changed

- Les spécifications passent d'Org-mode à Verso.
- Le code source (identifiants, docstrings, commentaires) est désormais en anglais.
- `CITATION.cff` décrit la spécification (CC-BY-4.0, ORCID) en vue du DOI Zenodo.
