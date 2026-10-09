<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Plan de remédiation OpenSSF de k7pl

| | |
|---|---|
| Nature | Plan de travail de la session principale ; **non normatif**. Dérive de `docs/security/OPENSSF-AUDIT.md`. |
| Principe | La qualité réelle prime sur le score. Chaque action a une raison identifiable et une validation attendue. |
| Découpage | Petits changements indépendants, un propriétaire unique par fichier, validation avant intégration. |
| Statuts | `VERIFIED` · `PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE` |

Un statut `PREPARED` signifie : écrit, vérifié par les outils disponibles ici, **non exécuté de bout en bout**. Rien de ce plan
ne prend effet sur `main` sans fusion par l'autrice.

## 1. Règles de répartition des fichiers

Une seule écriture simultanée par fichier. Les deux agents d'implémentation travaillent dans des worktrees distincts, sur des
fichiers disjoints ; la session principale écrit seule la documentation transversale.

| Fichiers | Propriétaire |
|---|---|
| `.github/workflows/release.yaml`, `.github/workflows/zenodo.yaml` (nouveau), `.github/workflows/bump-lean.yaml`, `.github/dependabot.yml` | `supply-chain-release-specialist` |
| `scripts/sync_zenodo.py` et son test, `scripts/claude-session-start.sh`, `scripts/ci/check_manifest.py` (nouveau) et son test | `supply-chain-release-specialist` |
| `.github/workflows/ci.yaml`, `.github/workflows/verify.yaml` | `quality-reproducibility-specialist` |
| `scripts/ci/impact.py`, `scripts/ci/test_impact.py`, nouveau contrôle d'exhaustivité des modules Lean sous `scripts/ci/` | `quality-reproducibility-specialist` |
| `docs/security/workstreams/<domaine>/CHANGES.md` et `VALIDATION.md` | l'agent du domaine |
| `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CHANGELOG.md`, `.github/workflows/README.md`, `.gitignore`, `docs/security/*.md` | session principale (écrivain unique) |
| `lakefile.lean`, `spec/**`, `src/**`, `tests/**`, `archives/**`, `CITATION.cff`, `zenodo.json`, `zenodo.files.json`, `.claude/**` | **personne** : décision de l'autrice |

**Contrat d'interface `verify.yaml` ↔ `release.yaml`** (fixé par la session principale pour permettre le travail en parallèle) :
`verify.yaml` reçoit une entrée booléenne optionnelle `use_cache` (défaut `true`, comportement actuel inchangé). Quand elle vaut
`false`, les étapes `actions/cache` de `.lake/packages` et de `~/.cache/Tectonic` sont sautées. `release.yaml` appelle
`verify.yaml` avec `use_cache: false`.

## 2. P0 : sécurité ou intégrité critique

**Aucune.** Aucun écart exploitable sans identifiant n'a été constaté. Le chemin de publication, bloqué, ne cause pas de dommage
tant qu'il ne s'exécute pas : son défaut est de ne pas fonctionner, pas d'agir mal.

## 3. P1 : conformité importante

| ID | Problème | Justification | Fichiers | Agent | Dépendances | Risque de régression | Validation attendue | Statut |
|---|---|---|---|---|---|---|---|---|
| R1 | `release.yaml` ne peut pas joindre le PDF (release immuable ; pas de `GH_REPO`) et n'a jamais tourné | C1 : sans correction, la première release de spécification échoue | `release.yaml` | supply-chain | R2 ; réglage d'immuabilité (H) | **élevé** : workflow jamais exécuté de bout en bout | `actionlint` ; `zizmor` hors ligne ; relecture adversariale ; mode essai déclenché en CI (contrôles et build, sans brouillon) ; répétition humaine sur sandbox | PREPARED |
| R2 | Le build du PDF attesté restaure des caches de `main` | écart important (ASS § 3.5, SUP § 3.5) | `verify.yaml` (entrée `use_cache`) | quality | — | faible : défaut inchangé | `actionlint` ; CI complète verte avec `use_cache` par défaut | PREPARED |
| R3 | Zenodo : DOI sans origine, état sur branche mutable, `ZENODO_ENV` en secret, jeton en argument de commande | C2 : DOI de concept en doublon irréversible | `zenodo.yaml`, `sync_zenodo.py` + test | supply-chain | **décision de l'autrice sur le DOI** ; environnement `zenodo` (H) | élevé (irréversible) : d'où l'**échec par défaut** | tests unitaires hors ligne avec simulation de l'API ; `actionlint` ; répétition sur sandbox | PREPARED |
| R4 | `bump-lean` : PAT et code amont sur la même machine ; `contents: write` inutile ; interpolation dans `run:` | écart important (SUP § 3.10, ASS § 3.4) | `bump-lean.yaml`, `scripts/ci/check_manifest.py` + test | supply-chain | environnement `bump-lean` (H) | moyen : branche « nouvelle version » non exercée depuis longtemps | `actionlint` ; tests du contrôle de manifeste sur le manifeste réel ; relecture ; première exécution réelle au prochain bump | PREPARED |
| R5 | Secrets hors environnement ; aucune règle de tags ; réglages Actions et 2FA non vérifiés | C3 | réglages GitHub | — | — | — | liste de procédures et vérifications dans `ACTIONS-HUMAINES.md` | HUMAN ACTION REQUIRED |
| R6 | Aucun contrôle « le tag est sur `main` et `CI OK` y a réussi » | I1 (SUP) | `release.yaml` (job `check`) | supply-chain | R1 | faible | même validation que R1 | PREPARED |
| R7 | Le vecteur d'agent piégé n'est pas restreint | risque le plus vraisemblable (ASS § 5) | `.claude/settings.json`, `.claude/agents/*.md` | — | **décision de l'autrice** | — | extrait proposé dans `DECISIONS-REQUISES.md` | HUMAN ACTION REQUIRED |

## 4. P2 : amélioration substantielle

| ID | Problème | Justification | Fichiers | Agent | Dépendances | Risque de régression | Validation attendue | Statut |
|---|---|---|---|---|---|---|---|---|
| R8 | Hook de session : `curl … master/elan-init.sh \| sh` | code distant mutable dans un bac à sable avec écriture au dépôt ; Pinned-Dependencies 9 | `scripts/claude-session-start.sh` | supply-chain | — | moyen : le hook s'exécute à chaque session | `bash -n` ; exécution dans un `HOME` jetable ; la somme est « première observation » (TOFU), pas une empreinte publiée par l'amont | PREPARED |
| R9 | Regex `grep` morte de `ci.yaml:57` ; `axiom-audit.sh` non classé pour le job `spec` | double défense illusoire (QUA § 2) | `ci.yaml`, `impact.py`, `test_impact.py` | quality | — | faible | `python3 scripts/ci/test_impact.py` ; simulation du classifieur ; CI | PREPARED |
| R10 | Audit d'axiomes limité à `K7pl` et `Spec` ; modules Lean orphelins non détectés | I1, I2 (QUA) | `verify.yaml`, nouveau script sous `scripts/ci/` | quality | — | moyen : un audit peut révéler un cas inattendu | script testé sur le dépôt ; audit de `SpecExt` et `SpecBib` déjà vérifié propre ; **audit de `K7plTests` à valider en CI** (Mathlib) | PREPARED |
| R11 | PDF non reproductible : `SOURCE_DATE_EPOCH` absent, journaux Tectonic ignorés | I3 (QUA) | `verify.yaml` | quality | bundle TeX inaccessible ici | moyen | `actionlint` ; CI complète ; **ne jamais écrire « reproductible »** | PREPARED |
| R12 | Dependabot sans `cooldown` | fenêtre de compromission détectée a posteriori (SUP § 3.2) | `dependabot.yml` | supply-chain | — | faible | `actionlint` sans objet ; validation du schéma ; relecture | PREPARED |
| R13 | Documentation qui décrit comme acquis un flux jamais exécuté ; badge périmé | A2, A6, A8 | `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `.github/workflows/README.md`, `CHANGELOG.md` | session principale | R1, R3 (pour décrire le flux réel) | faible | relecture ; `reuse lint` ; liens locaux | PREPARED |
| R14 | Aucun modèle de menace ni registre des revendications | critère CII `assurance_case` ; revendications sans preuve | `docs/security/THREAT-MODEL.md`, `ASSURANCE-CASE.md` | session principale | — | faible | traçabilité vers les audits ; **non validés par l'autrice** | PREPARED |
| R15 | Décisions humaines et actions GitHub dispersées dans six rapports | lisibilité | `docs/security/ACTIONS-HUMAINES.md`, `DECISIONS-REQUISES.md` | session principale | — | nul | relecture | PREPARED |
| R16 | `.claude/worktrees/` apparaît comme non suivi à chaque usage des agents isolés | le hook de fin de session le signale ; ce sont des copies du dépôt, pas des fichiers du projet | `.gitignore` | session principale | — | nul | `git status` propre après création d'un worktree | PREPARED |

## 5. P3 : amélioration future ou sur décision

| ID | Sujet | Statut | Raison de ne pas le faire maintenant |
|---|---|---|---|
| R17 | Audit statique des workflows GitHub Actions par zizmor | PREPARED (PR en cours) | job non bloquant ajouté à `security.yaml`, action et version de l'analyseur épinglées, résultats destinés à Code Scanning ; confirmer la CI et examiner les constats avant toute décision de blocage |
| R18 | `leanOptions` sur `lean_exe mainTest` et `spec` | VERIFIED (PR #98 fusionnée) | `lakefile.lean` applique `k7plBaseOptions` à `mainTest` et `k7plSpecOptions` à `spec` ; CI de PR passée. La portée doit être réévaluée si de nouvelles cibles exécutables sont ajoutées. |
| R19 | Double build quotidien de reproductibilité (niveau 1 : HTML/TeX ; niveau 2 : PDF) | FUTURE | décision d'ambition de l'autrice ; niveau 2 impossible à valider ici |
| R20 | Installer elan par version et somme dans la CI à la place de `lean-action` | FUTURE | gain partiel : elan ne vérifie pas ensuite le toolchain |
| R21 | Épingler le bundle TeX de Tectonic | BLOCKED | hôte inaccessible depuis cette session |
| R22 | `lean4checker` dans `full.yaml` | FUTURE | coût à mesurer ; revérifie les oléans importés |
| R23 | Tags signés | FUTURE | clé détenue par l'humain ; valeur faible sans canal de confiance extérieur |
| R24 | Fuzzing, tests par propriétés | FUTURE | aucune surface d'entrée avant un analyseur du langage |
| R25 | SBOM SPDX/CycloneDX | FUTURE | Le manifeste Lake n'est pas une SBOM. L'adaptateur OSV proposé sert uniquement à l'analyse d'avis par commit ; générer et valider une SBOM normalisée reste un chantier distinct. |
| R26 | `suivi.py` en CI | FUTURE | hors périmètre OpenSSF |
| R27 | Surveillance des vulnérabilités Lake par OSV-Scanner | PARTIAL (premier run exécuté) | Run 37951599075 : 14 paquets extraits, `No issues found`, SARIF envoyé à Code Scanning. Un scan hebdomadaire est configuré dans la PR ; la répétition planifiée, la couverture des avis et le triage restent à établir. Le scan est non bloquant. |

## 6. Ordre d'exécution de la vague 2

1. **En parallèle** : `supply-chain-release-specialist` (R1, R3, R4, R6, R8, R12) et `quality-reproducibility-specialist` (R2, R9, R10, R11),
   sur des fichiers disjoints, chacun dans son worktree, avec lecture préalable de son `AUDIT.md`.
2. **Intégration** par la session principale : application des deux jeux de modifications sur la branche, résolution de la seule
   frontière commune (le contrat `use_cache`), puis relecture adversariale de chaque diff.
3. **Documentation** par la session principale (R13 à R16), après intégration, pour qu'elle décrive ce qui existe réellement.
4. **Validation** : voir § 7.
5. **Audit final indépendant** par un agent de vérification et un agent d'assurance, sur le résultat intégré.

## 7. Plan de validation

| Contrôle | Quand | Remarque |
|---|---|---|
| `python3 scripts/ci/test_impact.py`, tests des nouveaux scripts | à chaque modification de `scripts/` | hors ligne |
| `actionlint` et job zizmor dans `security.yaml` | après chaque workflow modifié | le job utilise le persona `regular`, une version d'analyseur fixée et désactive les audits en ligne au départ ; examiner les constats Code Scanning avant d'envisager un seuil bloquant. Le persona `auditor` reste un contrôle exploratoire séparé |
| `reuse lint` | à chaque commit | 368 / 368 au dernier relevé |
| `python3 scripts/controle.py` | avant clôture | contrôles de la spécification |
| `lake build Spec`, `lake exe spec --with-tex`, `scripts/axiom-audit.sh` | avant clôture | une toolchain Lean 4.34.0 est téléchargeable depuis les assets GitHub (seul `release.lean-lang.org` est refusé) ; Mathlib non disponible |
| `lake build K7pl K7plTests`, `lake test`, `lake lint` | **par la CI GitHub seulement** | exige Mathlib ; `ci.yaml` ne se déclenche que sur PR, `push` sur `main` ou `workflow_dispatch` : une branche poussée seule ne lance rien. Déclenchement par `workflow_dispatch` sur la branche si les droits le permettent, sinon `HUMAN ACTION REQUIRED` |
| Scorecard : avant / après | avant clôture | binaire local sur **export propre** pour les 9 contrôles fondés sur les fichiers ; les contrôles dépendant de GitHub (Branch-Protection, Code-Review, Signed-Releases, Maintained, CII) ne se relisent qu'après fusion, via le journal du job `Scorecard` |
| `gitleaks` | si un binaire est disponible | sinon signalé comme non exécuté |

Aucune de ces validations ne sera présentée comme réussie sans sortie observée.

## 8. Résultats attendus sur Scorecard (avant → après), hors décisions de l'autrice

Estimations arithmétiques (méthode de l'audit Scorecard, § 6) ; elles ne sont pas des objectifs.

| Changement | Contrôle | Avant | Après (ESTIMÉ) | Réel ou artefact ? |
|---|---|---|---|---|
| Hook : elan par version et somme | Pinned-Dependencies | 9 | 10 | réel pour le hook ; PARTIAL (le binaire reste non vérifié par elan) |
| Première release avec bundle `.sigstore.json` | Signed-Releases | −1 (exclu) | 8 | réel (c'est la vraie attestation) ; sans lui, la première release ferait chuter le contrôle à 0 |
| `strict_required_status_checks_policy` (autrice) | Branch-Protection | 3 | 4 | réel |
| Passage du temps (≥ 2026-12-27) | Maintained | 0 | jusqu'à 10 | temps |
| Formulaire CII renseigné (autrice) | CII-Best-Practices | 2 | jusqu'à 5 | réel si les réponses sont sincères |
| — | Security-Policy | 4 | 4 | **artefact de mesure, non corrigé** |
| — | SAST, Code-Review, Fuzzing | 0 | 0 | plafonds structurels ou sans objet, non contournés |
