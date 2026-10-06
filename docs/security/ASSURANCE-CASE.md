<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Registre des revendications de sécurité et d'assurance

| | |
|---|---|
| Nature | Registre **court**, au format Claim → Argument → Evidence. Produit par une session d'agents, **non validé par l'autrice**. |
| Date | 2026-10-06 ; état de `origin/main` (`b5f6146`) et de la branche de cette campagne |
| Périmètre | Sécurité de la chaîne de construction et de publication. **Distinct** de [`docs/ASSURANCE.md`](../ASSURANCE.md), qui porte l'argument d'assurance **scientifique** (spécification, formalisation, preuves) avec son propre vocabulaire de statuts. |
| Règle | Une intention, une politique ou une action future n'est **jamais** une preuve d'une propriété déjà satisfaite. Une revendication non démontrée est marquée comme telle. |
| Lecture | `VERIFIED` : observé par une commande ou une lecture citée. `PARTIAL` : vrai pour une partie. `PREPARED` : écrit, non exécuté de bout en bout. `FUTURE` : pas encore vrai. `NOT CLAIMED` : volontairement non affirmé. |

Ce registre répond au critère CII `assurance_case` **sans le satisfaire** : un cas d'assurance honnête aujourd'hui est surtout la liste de ce
qui n'est pas encore démontré.

## 1. Revendications étayées

| # | Claim | Argument | Evidence | Statut |
|---|---|---|---|---|
| C1 | Les actions de CI sont épinglées par SHA, et chaque SHA est la cible du tag annoncé en amont | 18 actions tierces, SHA de 40 hex ; chaque commentaire de version résolu par `git ls-remote --tags` avec déréférencement | audits supply-chain § 3.2 et assurance F9 ; ne couvre pas ce que les actions téléchargent à l'exécution | VERIFIED |
| C2 | Aucun workflow n'utilise de déclencheur à risque (`pull_request_target`, `workflow_run`, `issue_comment`) | recherche dans `.github/workflows/` | audit assurance F8 ; relancer `grep` pour le re-vérifier | VERIFIED |
| C3 | `main` ne peut être ni supprimée ni réécrite, exige une PR et le check `CI OK`, sans acteur de contournement | ruleset 24138119 | `gh api repos/AntheaLiles/k7pl/rulesets/24138119` ; l'absence d'acteur de contournement a été lue avec un jeton d'intégration (valeur significative d'après l'OpenAPI, à confirmer dans l'interface) | VERIFIED (configuration) ; n'arrête pas un identifiant en écriture |
| C4 | Les dépendances Lake sont épinglées par commit | 14 paquets, 14 `rev` de 40 hex, identiques aux pins des manifestes amont | audit supply-chain § 3.6 ; `scripts/ci/check_manifest.py` : exécuté en CI par le job d'impact de `ci.yaml` (hors ligne : `lake-manifest.json: all checks passed`, run 37520170453) ; `--check-tags --check-upstream` exécuté une fois en réseau réel pendant la session (11 paquets hérités identiques à ce que Mathlib, CSLib et Verso publient à leur `rev`), jamais en CI ; le contrôle en réseau ne s'exécute que dans `bump-lean.yaml` (préparé, jamais exécuté de bout en bout). Il ne détecte ni un paquet omis ni un commit malveillant épinglé par un manifeste amont | VERIFIED (contrôle hors ligne, en CI) ; PREPARED (contrôle en réseau) |
| C5 | Le signalement privé de vulnérabilité est activé | API publique | `gh api repos/AntheaLiles/k7pl/private-vulnerability-reporting` → `{"enabled":true}` | VERIFIED |
| C6 | La release `spec-v0.0.0-alpha.1` est immuable | champ `immutable` de l'API | `gh api repos/AntheaLiles/k7pl/releases` → `immutable: true`, 0 asset. Le réglage du dépôt n'a pas pu être lu | VERIFIED (pour cette release) |
| C7 | Tout module Lean de `src/` et `tests/` est atteint par une racine de `lakefile.lean` | `scripts/ci/check_lean_modules.py` ; test sur mini-projet avec orphelin (échec attendu) | exécuté en CI, run 37424012908 : étape « Check that every Lean file is built » réussie, sur `3fd82f1` | VERIFIED (CI) |
| C8 | Aucun `sorry`, `axiom` ni `native_decide` dans `K7pl`, les modules de test, `Spec`, `SpecExt` et `SpecBib` | `scripts/axiom-audit.sh` sur chaque racine, liste autorisée `propext`, `Classical.choice`, `Quot.sound` | run 37424012908 : audits réussis (journal : `MainTest` 4 déclarations, `SemanticsTest` 1 ; local : `Spec` 1319, `SpecExt` 586, `SpecBib` 2). Les oléans de Mathlib ne sont pas revérifiés par le noyau à l'import (ESTIMÉ) | PARTIAL |
| C9 | Les scores Scorecard publiés sont reproductibles pour les contrôles fondés sur les fichiers | binaire Scorecard v5.5.0 local, export propre de `b5f6146` | 9 scores identiques au journal du run 37385570410 (score 6,0) | VERIFIED |

## 2. Revendications qui ne sont pas (encore) vraies

| # | Claim (source) | État réel | Statut |
|---|---|---|---|
| N1 | « Le PDF est joint à la release et archivé sur Zenodo » (`README.md`, `CONTRIBUTING.md` avant cette campagne) | la release n'a aucun asset ; la chaîne n'a jamais abouti ; le flux refondu n'a jamais été exécuté de bout en bout | FUTURE |
| N2 | « Un artefact publié provient de ce dépôt et de cette chaîne » | aucun artefact publié ; aucune attestation d'artefact. La procédure de vérification (`SECURITY.md`) est une cible, non éprouvée | FUTURE |
| N3 | « Les secrets de publication sont inaccessibles à une PR » | aucun environnement ne les protège aujourd'hui ; `environment:` est ajouté aux workflows, mais le réglage de protection est humain | HUMAN ACTION REQUIRED |
| N4 | « Un tag de release ne peut pas être posé hors de `main` ni déplacé avant publication » | aucune règle de tags ; le contrôle `check` ne résiste pas à un acteur qui peut pousser un tag ; la règle à créer doit restreindre aussi la **création** ; un identifiant qui hérite du contournement administrateur n'est pas arrêté | HUMAN ACTION REQUIRED |
| N5 | « Tout avertissement fait échouer la compilation » (`lakefile.lean`) | vrai pour les bibliothèques ; faux pour `lean_exe mainTest` et `lean_exe spec` (établi sur mini-projet, transposition ESTIMÉE) | PARTIAL |
| N6 | « La spécification est vérifiée par Lean 4 contre son implémentation de référence » (`CITATION.cff`, `zenodo.json`) | il n'existe pas d'implémentation de référence ; `spec/` et `tools/` n'importent ni `K7pl` ni Mathlib ni CSLib | NOT CLAIMED ici ; **décision D5** de l'autrice |
| N7 | Revue de code indépendante | aucune : un seul humain, zéro revue sur 13 PR, zéro approbation requise | NOT CLAIMED (structurel) |
| N8 | « Premier retour sous 7 jours » (`SECURITY.md`) | engagement de l'autrice, aucune donnée de signalement | politique, non preuve |

## 3. Ce qui n'est volontairement pas affirmé

- **Reproductibilité du PDF** : non démontrée (bundle TeX non épinglé, aucune double compilation comparée). Seule la génération HTML/TeX de la
  spécification a été observée identique sur deux builds propres **d'une même machine**.
- **SLSA** : aucun niveau n'est revendiqué (aucune provenance publiée).
- **SBOM** : `lake-manifest.json` tient lieu de nomenclature des dépendances Lake ; aucun SBOM n'est produit.
- **SAST** : aucun outil ne couvre Lean. Le SARIF de Scorecard n'est pas un SAST.
- **Fuzzing** : aucune surface d'entrée ; `src/` ne contient que 9 déclarations.
- **Propriétés de sécurité du langage** (non-interférence, déclassification) : ce sont des énoncés de la spécification, ni implémentés ni prouvés.

## 4. Entretien

Ce registre vieillit : une revendication passe de `PREPARED` à `VERIFIED` seulement avec une exécution observée (run, commande), jamais par
décision. À relire avant toute release et après toute modification de `.github/workflows/`.
