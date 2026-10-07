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

### Ajouté

- Suivi : séance 33 (`docs/journal/2026-10-07-pr-02-33-sources-des-singularites.md`), note de sources des propagations de singularités (`docs/recherche/sources-singularites.md`) vérification exhaustive de l'algèbre des singularités (`scripts/verif_singularites.py`) et contrôle des tables de propagation du §3.2 contre la roue des fractions (`scripts/controles/singularites.py`) ; notice d'IEEE 754-2019 dans `biblio/references.json`.
- Générateur de la spécification : index à pages et reconnaissance automatique des termes de l'index, du glossaire et des acronymes (`tools/SpecExt/Index.lean`, `AutoMark.lean`, `IndexCore.lean`, `IndexTerms.lean`), interface HTML en français (`tools/SpecExt/Translate.lean`), tests (`tests/SpecToolsTest.lean`, `lakefile.lean`), garde `scripts/controles/indexation.py` (`ANOM-09`, `ANOM-10`).

### Added

- Audit OpenSSF (`docs/security/`) : six audits indépendants (Scorecard, bonnes pratiques CII, gouvernance GitHub,
  chaîne d'approvisionnement, assurance, qualité), matrice consolidée, plan de remédiation, décisions et actions
  humaines requises, modèle de menace et registre des revendications. Rapports d'agents, non validés par une personne.
- CI : `scripts/ci/check_lean_modules.py` (modules Lean que `lake build` ne compile jamais), audits d'axiomes de
  `SpecExt`, `SpecBib` et des modules de test, entrée `use_cache` de `verify.yaml`, `scripts/ci/check_manifest.py`
  (contrôle du manifeste Lake) et tests de `scripts/ci/` (tous lancés par `unittest discover`).
- `zenodo.yaml` : archivage Zenodo des octets de la release publiée, après vérification de la release et de
  l'attestation du PDF ; échoue par défaut tant que le concept Zenodo n'est pas déclaré.

- Badges DOI (Zenodo), Software Heritage (origine, et répertoire de la release `0.0.0-alpha.1`
  avec son SWHID qualifié, à mettre à jour à chaque release `spec-vX.Y.Z`) et fair-software.eu
  dans le README, avec `.howfairis.yml` : le critère « registre » y est déclaré hors sujet, le
  critère « checklist » reste non satisfait (4 sur 5).
- CI : jobs parallèles `quick`, `impl`, `spec` et contrôle agrégé `CI OK` ; audit d'axiomes
  ciblé (`scripts/axiom-audit.sh`) ; concurrence, délais d'expiration et déclencheurs durcis ; annotations et résumés de job, audit d'axiomes de la spécification, vérification des
  liens locaux.
- Le manuscrit de la spécification en Verso (`spec/`), converti de l'Org-mode ; extensions Verso
  (`tools/SpecExt/` : renvois, énoncés scellés, formules, figures, tableaux, citations par
  chapitre, remarques marginales, listes) ; bibliographie générée (`tools/SpecBib.lean`,
  `biblio/references.json`).
- Conversion Org → Verso reproductible (`scripts/org2verso/`), chaîne bibliographique
  (`scripts/biblio/`), conversion Org → Markdown (`scripts/org2md.py`), mesures du manuscrit et
  vues du suivi (`scripts/manuscript_metrics.py`, `scripts/suivi.py`).
- Contrôles sur le Verso (`scripts/controles/`, `scripts/controle.py`, lancés en CI) : algèbre aux bornes, sceaux, propagation, croisement grammaire × règles, structure.
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

- `release.yaml` refondu pour les releases immuables : poussée du tag, contrôles (tag sur `main`, `CI OK`), build
  sans cache, brouillon de release avec PDF, somme et attestation ; la publication reste un geste humain. Corrige
  deux défauts qui l'empêchaient de joindre le PDF (upload après publication d'une release immuable ; absence de
  `GH_REPO`). Non encore exécuté de bout en bout.
- `sync_zenodo.py` : plus de branche d'état `zenodo-state`, instance et concept déclarés explicitement, refus avant
  tout appel réseau si la configuration est incomplète.
- `bump-lean.yaml` : un job de construction sans secret, un job d'ouverture de PR qui n'exécute aucun code Lean ;
  `check_manifest.py` lie chacun des 14 paquets à son dépôt et compare, en réseau, les paquets hérités aux manifestes
  publiés à l'amont (`--check-upstream`). Une nouvelle dépendance transitive fait échouer le contrôle jusqu'à ce
  qu'une personne l'ajoute à la liste.
- `release.yaml` : le tag est revérifié juste avant la création du brouillon ; les notes de la release séparent
  les commandes de vérification d'avant et d'après publication.
- `sync_zenodo.py` : toute erreur après l'envoi de la publication écrit le DOI et sort avec le code 3 (au lieu
  d'un succès silencieux en cas de relecture refusée) ; `NEW` refuse de s'exécuter si `GITHUB_RUN_ATTEMPT` n'est
  pas `1`.
- `sync_zenodo.py` (suite d'un réaudit indépendant) : une relecture qui n'est pas un objet, une erreur de rapport ou
  une interruption n'empêchent plus d'écrire le DOI ; seules les réponses 400, 401, 403, 404 et 422 prouvent
  qu'aucune publication n'a eu lieu ; un jeton mal formé est refusé sans être affiché.
- `CONTRIBUTING.md` : critères exacts de `commitlint` (chaque commit est lu, en-tête de 100 caractères au plus) et procédure de
  contrôle local ; marche à suivre quand le contrôle de manifeste refuse une nouvelle dépendance, que `check_manifest.py` indique
  désormais dans son message d'échec.
- `check_manifest.py` est lancé par le job d'impact de `ci.yaml` à chaque exécution, et contrôle aussi `configFile`,
  `manifestFile`, `version` et `fixedToolchain` ; `check_lean_modules.py` refuse un `srcDir` calculé ; `impact.py`
  cite les chemins qu'il affiche.
- Hook de session : elan installé par version et somme enregistrée, plus de `curl … | sh` sur `master`.
- Dependabot : délai de sept jours (`cooldown`) avant de proposer une nouvelle version.
- `ci.yaml` : `scripts/ci/impact.py` est la seule source des chemins qui forcent la vérification complète (une
  regex shell redondante, dont cinq alternatives sur huit ne correspondaient à rien, est supprimée) ;
  `scripts/axiom-audit.sh` déclenche aussi le build de la spécification.
- Compilation du PDF : `SOURCE_DATE_EPOCH` et `-Z deterministic-mode` ; journal de compilation conservé. Le PDF
  n'est pas pour autant démontré reproductible.
- README : badge de CI corrigé (il pointait vers un workflow supprimé) ; flux de publication décrit comme non encore
  exécuté de bout en bout. `CONTRIBUTING.md` et `SECURITY.md` alignés sur ces changements.
- `LICENSE` devient `LICENSE.md` ; les références (README, règles de rédaction) sont mises à jour.
  Mise en forme Markdown du fichier, texte inchangé (deux puces et leurs paragraphes
  s'affichaient en blocs de code).
- `CITATION.cff` : version `0.0.0-alpha.1`, celle du tag `spec-v0.0.0-alpha.1` ; le contrôle de
  release du job `zenodo` compare ces deux valeurs et avait échoué sur `0.0.0`.
- Les spécifications passent d'Org-mode à Verso.
- Le code source (identifiants, docstrings, commentaires) est désormais en anglais.
- `CITATION.cff` décrit la spécification (CC-BY-4.0, ORCID) en vue du DOI Zenodo.
