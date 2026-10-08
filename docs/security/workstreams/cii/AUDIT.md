<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit OpenSSF Best Practices (CII) — k7pl, projet 15239

**Nature du document** : rapport d'audit de la vague 1, **non normatif**. Il ne modifie aucune
pratique du projet et ne vaut ni déclaration de conformité ni réponse au formulaire du badge.

| | |
|---|---|
| Date | 2026-10-06 |
| Commit audité | `b5f6146` (`origin/main`, identique à la base du worktree) |
| Branche du worktree | `worktree-agent-af3f7da326fd25ed5` |
| Rédigé par | agent `cii-specialist` (Claude), à relire par l'autrice |
| Projet sur le site | <https://www.bestpractices.dev/fr/projects/15239> — **état saisi non lu** (voir §0) |

## 0. Ce qui fonde ce rapport, et ce qui manque

**Fait observé** — `www.bestpractices.dev` est refusé par le proxy de la session (`curl` : « CONNECT
tunnel failed, response 403 » ; WebFetch : `EGRESS_BLOCKED`). Les réponses déjà saisies pour le
projet 15239, son niveau et son pourcentage **n'ont pas pu être lus**. Tout ce qui concerne l'état sur le
site est donc **HUMAN ACTION REQUIRED (relire)**.

**Fait observé** — le texte des critères ne vient **pas** de mémoire : il a été lu dans le dépôt source du
site, `coreinfrastructure/best-practices-badge`, commit `75560e376d7c40a353f2d3a885c3919fd1255026`
(2026-10-02), fichiers `criteria/criteria.yml` (niveaux, catégories, drapeaux N/A et URL) et
`config/locales/en.yml` (énoncés et détails). Décompte : **67 critères Passing, 55 Silver, 23 Gold**,
aucun marqué `future` ni `obsolete` à ce commit. Le site peut avoir évolué depuis : écart **ESTIMÉ** faible.
Le site propose aussi désormais des sections « baseline-1/2/3 » (OSPS Baseline,
`criteria/baseline_criteria.yml`) : hors périmètre de ce rapport.

**Ce qui reste ESTIMÉ** — (a) la façon dont le correcteur du site interpréterait une justification ; (b) les
faits externes non mesurables d'ici (en-têtes HTTP de Pages, alertes Dependabot et code scanning, avis de
sécurité privés, 2FA du compte, contenu archivé par Software Heritage).

**Aucune toolchain Lean locale** : je n'ai exécuté ni `lake build`, ni `lake test`, ni `lake lint`. Les
résultats Lean cités viennent de la CI GitHub (run `37385570730`, `push` sur `main`, commit `b5f6146`,
tous les jobs et toutes les étapes en `success`, lus par l'API publique).

Commandes exécutées localement (résultats cités dans le rapport) :

| Commande | Résultat |
|---|---|
| `python3 -m reuse lint` (reuse 6.2.0 installé dans le scratchpad) | conforme REUSE 3.3 ; 363/363 fichiers avec copyright et licence |
| `python3 scripts/ci/test_impact.py` | 9 tests, OK |
| `python3 scripts/controle.py` | « TOUS LES CONTROLES PASSENT » ; arbre de travail inchangé (`git status` vide) |
| liste SPDX 3.29 (paquet `spdx-license-list`) | `CECILL-2.1` : `osi_approved=True` ; `CC-BY-4.0` : `osi_approved=False`, `fsf_libre=True` |
| `gh api repos/AntheaLiles/k7pl/...` (lecture anonyme) | métadonnées, ruleset, PR, revues, releases, runs (cités au fil du texte) |

Légende des colonnes **État proposé** (valeur que la preuve du dépôt permettrait de défendre sur le
formulaire) : `Met` · `Unmet` · `N/A` · `à confirmer`. Légende **Statut** (règle du projet) : `VERIFIED` ·
`PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE`. Abréviations : FO = fait observé ;
I = interprétation ; H = hypothèse.

## 1. Question préalable : quel est « le logiciel produit par le projet » ?

Beaucoup de critères ne s'appliquent qu'au « software produced by the project ». La réponse change une
dizaine de choix N/A. **Faits observés** :

- `src/` ne contient que trois modules jouets (`Main.hello`, `K7pl.Arith`, `K7pl.Semantics`) ; le langage
  k7pl **n'est pas implémenté** (README.md:42-45 et `docs/suivi/DASHBOARD.md` §2 le disent).
- `lakefile.lean:42` déclare la version `0.1.0`, mais aucun tag `v*` n'existe.
- La seule release est `spec-v0.0.0-alpha.1` : un **document** (spécification, CC-BY-4.0).
- Le logiciel effectivement exécuté est l'outillage : générateur `lake exe spec` (`tools/`), contrôles
  Python (`scripts/controles/`), publication Zenodo (`scripts/sync_zenodo.py`), workflows.

**Interprétation proposée** (à trancher par l'autrice, **HUMAN ACTION REQUIRED**) : déclarer dans la
description du projet sur le site que les résultats actuels sont (1) une spécification publiée et (2) une
bibliothèque Lean embryonnaire, sans logiciel destiné à des utilisateurs finaux ; l'outillage (`tools/`,
`scripts/`) est du logiciel de construction. Cette déclaration doit précéder les choix N/A ci-dessous,
sinon ils paraîtront opportunistes.

## 2. Synthèse par niveau

### Passing — atteignable, sous réserve d'actions humaines

Aucun critère MUST n'est structurellement hors d'atteinte. Restent à traiter avant de pouvoir afficher
« passing » de façon défendable :

| Critère | Pourquoi | Nature |
|---|---|---|
| `release_notes` | la seule release porte des notes auto-générées (liste de titres de PR) et aucune section `[0.0.0-alpha.1]` n'existe dans `spec/CHANGELOG.md` | documentaire (édition de la release sur GitHub) |
| `know_secure_design`, `know_common_errors` | attestation personnelle de l'autrice ; aucun document ne peut la remplacer | organisationnel |
| `static_analysis` | Met défendable seulement avec une justification précise (`lake lint`, axiom-audit, actionlint) ; rien sur Python | justification + technique |
| `documentation_interface`, `documentation_basics` | dépendent de la décision du §1 | interprétatif |
| `english` (SHOULD) | politique « tout en français » : il faut soit une justification, soit une phrase acceptant les rapports en anglais | décision |
| `vulnerability_report_response`, `vulnerabilities_fixed_60_days`, `static_analysis_fixed` | données privées (avis, alertes) non lisibles d'ici | vérification humaine |

### Silver — non atteignable en l'état ; atteignable à moyen terme sauf `bus_factor` (SHOULD, justifiable)

Manquent surtout des **documents qui décrivent une pratique réelle** (gouvernance et rôles, feuille de
route, exigences de sécurité, assurance case, processus de réponse aux vulnérabilités, revue de code), plus
trois chantiers techniques : releases signées et vérifiables (`signed_releases`), build répétable
(`build_repeatable`), analyse statique à règles de vulnérabilité pour Python et les workflows
(`static_analysis_common_vulnerabilities`). `access_continuity` (MUST) demande une **action humaine
concrète** mais est accessible à une personne seule (le critère admet « clés dans un coffre et testament »).

### Gold — structurellement hors d'atteinte pour un projet à une seule personne

`bus_factor` (MUST), `contributors_unassociated` (MUST) et `two_person_review` (MUST) exigent au moins une
seconde personne humaine réelle. Aucun document, aucun agent, aucune configuration ne peut les satisfaire.
`hardened_site` dépend en outre de l'hébergement (GitHub Pages, ESTIMÉ non conforme).

## 3. Passing — critère par critère

### Basics

| Critère | Exig. | État proposé | Preuve | Écart | Nature | Action possible | Dépendance | Statut |
|---|---|---|---|---|---|---|---|---|
| `description_good` | MUST | Met (à confirmer) | README.md:16-19 ; description du dépôt en anglais (`gh api repos/AntheaLiles/k7pl`, champ `description`) ; page d'intro de la spec (spec/Spec.lean:38) | le README dit *ce qu'est* k7pl, pas *quel problème il résout* | documentaire | une phrase de but en tête du README, écrite par l'autrice | autrice | PARTIAL |
| `interact` | MUST | Met | obtenir : CONTRIBUTING.md:19, README.md:39-40, :67-69 ; retours : CONTRIBUTING.md:27, `.github/ISSUE_TEMPLATE/bug.yml`, `proposal.yml` ; contribuer : README.md:58-63 | — | — | — | — | VERIFIED (dépôt) |
| `contribution` | MUST, URL | Met | CONTRIBUTING.md:25-38 ; URL <https://github.com/AntheaLiles/k7pl/blob/main/CONTRIBUTING.md> | — | — | — | — | VERIFIED |
| `contribution_requirements` | SHOULD | Met | CONTRIBUTING.md:8-12 (renvoi aux règles de rédaction), :30-35, :59-64 ; `.github/PULL_REQUEST_TEMPLATE.md` | règles rangées sous `.claude/skills/` (trouvables, peu conventionnelles) ; aucun style Python | documentaire | — | — | VERIFIED |
| `floss_license` | MUST | Met | `LICENSES/CECILL-2.1.txt` ; LICENSE.md:14-27 ; SPDX 3.29 : CECILL-2.1 approuvée OSI | GitHub ne reconnaît pas la licence (`license: NOASSERTION`) : l'auto-remplissage du site peut échouer | externe | justifier à la main sur le site | — | VERIFIED |
| `floss_license_osi` | SUGG | Met | idem ; CC-BY-4.0 couvre un document (spec), pas le logiciel | — | — | — | — | VERIFIED |
| `license_location` | MUST, URL | Met | dossier `LICENSES/` (convention REUSE, citée nommément par le critère) + LICENSE.md ; `reuse lint` 363/363 | — | — | URL <https://github.com/AntheaLiles/k7pl/tree/main/LICENSES> | — | VERIFIED |
| `documentation_basics` | MUST (N/A) | Met (à confirmer) | README.md:21-33 ; CONTRIBUTING.md:16-23 ; spec publiée | « comment l'utiliser » n'a pas d'objet tant que le langage n'est pas implémenté | interprétatif | trancher §1 | §1 | PARTIAL |
| `documentation_interface` | MUST (N/A) | à confirmer | la spec publiée décrit l'interface *prévue* du langage ; la bibliothèque Lean n'a que des docstrings (src/K7pl/*.lean) | « merely having comments in implementation code is not sufficient » | interprétatif | Met via la spec (justifié), ou N/A (aucun logiciel pour utilisateurs), ou doc-gen4 plus tard | §1 | HUMAN ACTION REQUIRED |
| `sites_https` | MUST | Met | homepage `https://anthealiles.github.io/k7pl/` ; dépôt et DOI en `https:` | application de HTTPS sur Pages non lisible (API `pages` refusée) ; ESTIMÉ : imposée sur `*.github.io` | externe | vérifier Settings → Pages → « Enforce HTTPS » | — | PARTIAL (ESTIMÉ) |
| `discussion` | MUST | Met | Issues, PR, Discussions (`has_discussions: true`) | — | — | — | — | VERIFIED |
| `english` | SHOULD | Unmet justifié, ou Met après décision | politique : `.claude/CLAUDE.md` (« Documentation, spécification, issues, PR … : français »), règles de rédaction §2 ; description du dépôt en anglais | rien n'indique qu'un rapport en anglais est accepté | organisationnel | décision de l'autrice : justification écrite, ou une phrase « reports in English are welcome » dans CONTRIBUTING/SECURITY | autrice | HUMAN ACTION REQUIRED |
| `maintained` | MUST | Met | 69 commits du 2026-09-29 au 2026-10-06 (`git log origin/main`) ; CI verte (run 37385570730) | — | — | — | — | VERIFIED |

### Change Control

| Critère | Exig. | État proposé | Preuve | Écart | Nature | Action possible | Dépendance | Statut |
|---|---|---|---|---|---|---|---|---|
| `repo_public` | MUST | Met | dépôt public (API : `visibility: public`) | — | — | — | — | VERIFIED |
| `repo_track` | MUST | Met | historique git | 49 commits ont pour auteur « Claude » (27 en `noreply@anthropic.com`, 22 avec l'adresse noreply de l'autrice) : le « qui » mêle humaine et agent | documentaire | l'expliquer dans GOVERNANCE (§6) | — | VERIFIED |
| `repo_interim` | MUST | Met | 69 commits, 13 PR, 1 release | — | — | — | — | VERIFIED |
| `repo_distributed` | SUGG | Met | git | — | — | — | — | VERIFIED |
| `version_unique` | MUST | Met | tag `spec-v0.0.0-alpha.1` ; `CITATION.cff` ; `lakefile.lean:42` | au tag, `CITATION.cff` déclarait `0.0.0` (git show tag:CITATION.cff, l. 17), corrigé ensuite (eff757a) | documentaire | — | — | VERIFIED |
| `version_semver` | SUGG | Met | `0.0.0-alpha.1`, schéma `vX.Y.Z` (CONTRIBUTING.md:77-80) | release alpha non marquée « pre-release » (API : `prerelease: false`) | documentaire | cocher « Set as a pre-release » | autrice | VERIFIED |
| `version_tags` | SUGG | Met | tag git (léger : `git cat-file -t` → `commit`), non signé | — | — | — | — | VERIFIED |
| `release_notes` | MUST (N/A, URL) | Unmet en l'état | corps de la release = « What's Changed » auto-généré (liste de titres de PR) ; `spec/CHANGELOG.md` sans section `[0.0.0-alpha.1]` au tag comme aujourd'hui (spec/CHANGELOG.md:13) | pas de résumé lisible des changements majeurs ni de leur impact | documentaire | éditer la release sur GitHub (aucune modification du dépôt) ; pour la suite, `release.yaml:80-83` exige la section `## [X.Y.Z]` | `spec/CHANGELOG.md` est sous `spec/` (frontière) | HUMAN ACTION REQUIRED |
| `release_notes_vulns` | MUST (N/A) | N/A | aucun avis publié (`gh api …/security-advisories` → 0) | — | — | — | — | VERIFIED |

### Reporting

| Critère | Exig. | État proposé | Preuve | Écart | Nature | Action possible | Dépendance | Statut |
|---|---|---|---|---|---|---|---|---|
| `report_process` | MUST, URL | Met | Issues + modèles ; `.github/ISSUE_TEMPLATE/config.yml:5` (`blank_issues_enabled: false`) | modèles uniquement en français | — | URL <https://github.com/AntheaLiles/k7pl/issues> | — | VERIFIED |
| `report_tracker` | SHOULD | Met | GitHub Issues | — | — | — | — | VERIFIED |
| `report_responses` | MUST | Met (vacuité) | 0 issue depuis la création du dépôt (2026-09-28) : `gh api …/issues?state=all` ne renvoie que 13 PR | fenêtre « 2 à 12 mois » vide | — | justifier « aucun rapport reçu » | — | PARTIAL |
| `enhancement_responses` | SHOULD | Met (vacuité) | idem | idem | — | idem | — | PARTIAL |
| `report_archive` | MUST, URL | Met | <https://github.com/AntheaLiles/k7pl/issues?q=> | — | — | — | — | VERIFIED |
| `vulnerability_report_process` | MUST, URL | Met | SECURITY.md:12-21 ; config.yml (lien « Signaler une vulnérabilité ») ; README.md:62-63 | — | — | URL <https://github.com/AntheaLiles/k7pl/security/policy> | — | VERIFIED |
| `vulnerability_report_private` | MUST (N/A, URL) | Met | SECURITY.md:14-16 ; `gh api …/private-vulnerability-reporting` → `{"enabled":true}` | — | — | — | — | VERIFIED |
| `vulnerability_report_response` | MUST (N/A) | N/A (à confirmer) | engagement « premier retour sous 7 jours » (SECURITY.md:19), ≤ 14 j | rapports privés invisibles d'ici | externe | l'autrice vérifie Security → Advisories | autrice | HUMAN ACTION REQUIRED |

### Quality

| Critère | Exig. | État proposé | Preuve | Écart | Nature | Action possible | Dépendance | Statut |
|---|---|---|---|---|---|---|---|---|
| `build` | MUST (N/A) | Met | `lakefile.lean` ; CI : `lake build K7pl K7plTests`, `lake build Spec` en succès (run 37385570730) | non exécuté localement | — | — | — | VERIFIED (CI) |
| `build_common_tools` | SUGG | Met | Lake | — | — | — | — | VERIFIED |
| `build_floss_tools` | SHOULD | Met | Lean, Lake, Mathlib, CSLib, Verso, Tectonic | licences de ces outils non relues ici | — | — | — | PARTIAL (ESTIMÉ) |
| `test` | MUST | Met | `tests/MainTest.lean` + `@[test_driver]` (lakefile.lean:68-72) ; README.md:29 ; CONTRIBUTING.md:21 ; étape CI « Test » en succès | suite minimale (cinq vérifications à l'exécution) | — | — | — | VERIFIED (CI) |
| `test_invocation` | SHOULD | Met | `lake test` | — | — | — | — | VERIFIED |
| `test_most` | SUGG | Unmet | aucune mesure ; `tools/SpecExt/` sans test ; `scripts/` : seuls `scripts/ci/test_impact.py` et l'auto-test de `algebre` | — | technique | — | quality | FUTURE |
| `test_continuous_integration` | SUGG | Met | `ci.yaml` (PR, push `main`), `full.yaml` quotidien | sélection par impact : un diff purement documentaire ne lance pas `lake test` | — | — | — | VERIFIED |
| `test_policy` | MUST | Met | règles de rédaction §5 (`.claude/skills/writing-rules.md:141-148`) et :409 ; PR template :14 | politique liée au « nouveau module », pas à la « fonctionnalité majeure » | documentaire | — | — | VERIFIED |
| `tests_are_added` | MUST | Met (à confirmer) | 90e5ea0 ajoute `scripts/ci/impact.py` **avec** `scripts/ci/test_impact.py` (9 tests, OK en local) ; `K7pl.Arith`/`Semantics` ont leurs tests | les changements majeurs récents portent sur la spec et les contrôles, pas sur l'implémentation | interprétatif | — | §1 | PARTIAL |
| `tests_documented_added` | SUGG | Met | PR template :14 ; règles §5, §11 | CONTRIBUTING.md ne l'énonce pas lui-même | documentaire | une ligne dans « Déroulement » | autrice | PARTIAL |
| `warnings` | MUST | Met | lakefile.lean:16-22 (`warningAsError`, `autoImplicit` désactivé), :32-39 (`mathlibStandardSet`), :43 (`batteries/runLinter`) ; étape CI « Lint » en succès | `scripts/` (Python) sans linter | — | — | — | VERIFIED |
| `warnings_fixed` | MUST | Met | tout avertissement fait échouer le build | — | — | — | — | VERIFIED (CI) |
| `warnings_strict` | SUGG | Met (Lean) / Unmet (Python) | idem | Python | technique | linter Python en CI | quality | PARTIAL |

### Security

| Critère | Exig. | État proposé | Preuve | Écart | Nature | Action possible | Dépendance | Statut |
|---|---|---|---|---|---|---|---|---|
| `know_secure_design` | MUST | à attester | aucune preuve documentaire possible : compétence d'une personne | — | organisationnel | l'autrice répond, Met seulement si c'est vrai (formation libre possible : OpenSSF LFD121) | autrice | HUMAN ACTION REQUIRED |
| `know_common_errors` | MUST | à attester | SECURITY.md:23-31 montre une conscience des classes de risque propres au projet (cohérence, axiomes, chaîne de build) | idem | organisationnel | idem | autrice | HUMAN ACTION REQUIRED |
| `crypto_published`, `crypto_call`, `crypto_floss`, `crypto_keylength`, `crypto_working`, `crypto_weaknesses`, `crypto_pfs`, `crypto_password_storage`, `crypto_random` | MUST/SHOULD (N/A) | N/A | aucune cryptographie dans `src/`, `tests/`, `tools/` ; `scripts/sync_zenodo.py` n'appelle Zenodo qu'en `https://` via `requests` (vérification TLS par défaut, aucun `verify=`, l. 37-39) | — | — | justifier N/A : le logiciel produit n'implémente ni n'appelle de cryptographie | §1 | VERIFIED |
| `delivery_mitm` | MUST | Met | GitHub, Pages, Zenodo, doi.org en HTTPS ; `release.yaml:104-111` (SHA-256 + attestation) | l'attestation n'a jamais été produite (voir `signed_releases`) | — | — | — | VERIFIED (HTTPS) ; PREPARED (attestation) |
| `delivery_unsigned` | MUST | Met | aucune empreinte lue en HTTP ; `verify.yaml:191-207` : SHA-256 de Tectonic écrit dans le dépôt | hors critère mais voisin : `scripts/claude-session-start.sh:15-16` exécute `elan-init.sh` depuis la branche mutable `master`, sans vérification | technique | — | supply-chain | VERIFIED |
| `vulnerabilities_fixed_60_days` | MUST | Met (à confirmer) | 0 avis publié ; alertes Dependabot non lisibles (API refusée) | — | externe | l'autrice vérifie Security → Dependabot alerts | autrice | HUMAN ACTION REQUIRED |
| `vulnerabilities_critical_fixed` | SHOULD | Met (vacuité) | idem | — | — | — | — | HUMAN ACTION REQUIRED |
| `no_leaked_credentials` | MUST | Met | gitleaks sur tout l'historique (`security.yaml`, `fetch-depth: 0`), succès au run 37385570730 ; `.gitleaks.toml:13` n'exclut que `archives/outillage-org/` | répertoire entier exclu (faux positifs documentés) ; gitleaks non relancé localement | technique | — | scorecard | VERIFIED (CI) |

### Analysis

| Critère | Exig. | État proposé | Preuve | Écart | Nature | Action possible | Dépendance | Statut |
|---|---|---|---|---|---|---|---|---|
| `static_analysis` | MUST (N/A, justif.) | Met défendable (à confirmer) | `lake lint` (Batteries `runLinter`, outil distinct des avertissements du compilateur) et l'audit d'axiomes (`scripts/axiom-audit.sh`) appliqués avant une release `vX.Y.Z` (`release.yaml:19-25` → `verify.yaml:95-116`) et à chaque PR touchant Lean ; actionlint à chaque PR | rien sur Python ; aucun outil FLOSS orienté vulnérabilités pour Lean (ESTIMÉ) | technique | justification précise et prudente ; option vague 2 : CodeQL (python, actions) ou zizmor + bandit | quality, scorecard | PARTIAL |
| `static_analysis_common_vulnerabilities` | SUGG | Unmet | aucun outil à règles de vulnérabilité (CodeQL, bandit, semgrep, zizmor) ; Scorecard évalue des pratiques, ce n'est pas un SAST | — | technique | idem | quality, scorecard | FUTURE |
| `static_analysis_fixed` | MUST (N/A) | N/A ou Met (à confirmer) | alertes code scanning illisibles d'ici (HTTP 403) | — | externe | l'autrice vérifie Security → Code scanning | autrice | HUMAN ACTION REQUIRED |
| `static_analysis_often` | SUGG | Met | actionlint à chaque PR ; `lake lint` à chaque PR Lean et chaque jour (`full.yaml`) | — | — | — | — | VERIFIED |
| `dynamic_analysis` | SUGG | Unmet | ni fuzzing ni test de propriétés : `plausible` est cité (writing-rules.md:148) mais aucun test ne l'importe (`tests/*.lean`) | — | technique | — | quality | FUTURE |
| `dynamic_analysis_unsafe` | SUGG (N/A) | N/A | Lean et Python sont sûrs en mémoire ; aucun `unsafe`, `@[extern]`, `implemented_by` dans `src/`, `tests/`, `tools/` (recherche) | — | — | — | — | VERIFIED |
| `dynamic_analysis_enable_assertions` | SUGG | Unmet | `#guard` est une vérification à la compilation, pas une assertion d'exécution | — | technique | — | quality | FUTURE |
| `dynamic_analysis_fixed` | MUST (N/A) | N/A | pas d'analyse dynamique | — | — | — | — | VERIFIED |

## 4. Silver — critère par critère

Les critères Passing promus (SHOULD/SUGGESTED devenus MUST) sont repris avec leur nouvelle exigence.

| Critère | Exig. | État proposé | Preuve | Écart | Nature | Action possible | Dépendance | Statut |
|---|---|---|---|---|---|---|---|---|
| `achieve_passing` | MUST | Unmet tant que Passing n'est pas obtenu | état du site illisible | — | externe | §3 | Passing | HUMAN ACTION REQUIRED |
| `contribution_requirements` | MUST, URL | Met | voir §3 | style Python non spécifié | documentaire | — | — | VERIFIED |
| `dco` | SHOULD, URL | Unmet | 1 seul `Signed-off-by` sur 69 commits ; ni DCO ni CLA dans CONTRIBUTING | — | organisationnel (choix juridique) | adopter le DCO (texte dans CONTRIBUTING, `git commit -s`, contrôle en CI) **ou** justifier l'absence | autrice | HUMAN ACTION REQUIRED |
| `governance` | MUST, URL | Unmet | pratique réelle visible mais non décrite comme telle : `docs/tracking/DECISIONS.md` (« Attendent une décision de l'auteur », « à ratifier ») ; CONTRIBUTING.md:27-28 | aucun document de gouvernance | documentaire | GOVERNANCE.md court qui décrit la pratique réelle (§6) | autrice | HUMAN ACTION REQUIRED |
| `code_of_conduct` | MUST, URL | Met | CODE_OF_CONDUCT.md (Contributor Covenant 2.1, FR) ; profil communautaire 100 % | canal de signalement (CODE_OF_CONDUCT.md:45) : « message privé … via son profil GitHub » — GitHub n'a pas de messagerie privée | documentaire / organisationnel | l'autrice désigne un canal qui existe | autrice | PARTIAL |
| `roles_responsibilities` | MUST, URL | Unmet | aucun document ; rôles implicites : autrice-mainteneuse (@AntheaLiles), agents IA auteurs de commits, Dependabot | — | documentaire | dans le même GOVERNANCE.md (le critère l'autorise) | autrice | HUMAN ACTION REQUIRED |
| `access_continuity` | MUST, URL | Unmet | une seule personne détient le compte GitHub, les secrets (`ZENODO_TOKEN`, `BUMP_TOKEN`), les comptes Zenodo et ORCID | — | organisationnel | voir §5 | autrice | HUMAN ACTION REQUIRED |
| `bus_factor` | SHOULD, URL | Unmet (justifier) | une seule personne humaine (compte GitHub 120063455, « Cyprien PIERRE », 19 commits) ; les 49 commits « Claude » viennent d'un agent, dont 22 sous l'adresse de ce même compte | — | structurel | justification honnête ; ne pas compter les agents | — | BLOCKED |
| `documentation_roadmap` | MUST, URL | Unmet | `docs/suivi/DASHBOARD.md` §2 et portes P1–P6 (l. 110-157) donnent le chemin vers l'implémentation | ni horizon d'un an, ni « ce que le projet ne fera pas » | documentaire | feuille de route écrite ou validée par l'autrice (§6) | autrice | HUMAN ACTION REQUIRED |
| `documentation_architecture` | MUST (N/A), URL | PARTIAL | règles §1 (structure du dépôt) ; `.github/workflows/README.md` (architecture CI) | rien sur l'architecture du logiciel produit (bibliothèque, générateur `SpecExt`/`SpecMain`, contrôles) | documentaire | page courte, ou N/A justifié tant qu'il n'y a pas d'implémentation | §1 | FUTURE |
| `documentation_security` | MUST (N/A), URL | Unmet | SECURITY.md:23-31 décrit le périmètre de signalement, pas ce que l'utilisateur peut attendre | — | documentaire | modèle de sécurité (propriétaire : security-assurance) | security-assurance | FUTURE |
| `documentation_quick_start` | MUST (N/A), URL | PARTIAL | README.md:21-33 | lance le build, ne permet de « faire quelque chose » avec aucun logiciel | interprétatif | N/A justifié, ou Met « lire la spec, lancer les tests » | §1 | HUMAN ACTION REQUIRED |
| `documentation_current` | MUST (N/A) | Unmet (défauts connus) | voir §7, défauts D1-D6 | — | documentaire | corriger hors `spec/` en vague 2 | — | FUTURE |
| `documentation_achievements` | MUST, URL | Unmet dès qu'un badge est obtenu | README.md:8-14 : aucun badge OpenSSF Best Practices | — | documentaire | ajouter le badge du projet 15239 (§8) | décision autrice | HUMAN ACTION REQUIRED |
| `accessibility_best_practices` | SHOULD (N/A) | à confirmer | directive `figure` avec `alt` (règles §6) ; HTML Verso non audité | — | — | — | — | FUTURE |
| `internationalization` | SHOULD (N/A) | N/A | le logiciel produit n'émet pas de texte pour des utilisateurs (hors messages de tests) | — | — | — | §1 | PARTIAL |
| `sites_password_security` | MUST (N/A) | N/A | aucun site du projet ne stocke de mots de passe (GitHub, Pages statique, Zenodo) | — | — | — | — | VERIFIED |
| `maintenance_or_update` | MUST (N/A) | N/A (à confirmer) | aucune version antérieure du logiciel en usage ; une release de document en alpha | — | — | — | §1 | PARTIAL |
| `report_tracker` | MUST | Met | GitHub Issues | — | — | — | — | VERIFIED |
| `vulnerability_report_credit` | MUST (N/A), URL | N/A | aucune vulnérabilité résolue ; crédit promis (SECURITY.md:19-21) | — | — | — | — | VERIFIED |
| `vulnerability_response_process` | MUST, URL | PARTIAL | SECURITY.md:18-21 (retour sous 7 j, correctif et avis publiés ensemble, crédit) | pas d'étapes : tri, gravité (CVSS), correctif privé (fork temporaire de l'avis GitHub), CVE, divulgation coordonnée | documentaire + engagement | compléter SECURITY.md — engagement que seule l'autrice peut prendre | autrice | HUMAN ACTION REQUIRED |
| `coding_standards` | MUST (N/A), URL | PARTIAL | règles §7 (`writing-rules.md:216-218` : « Les règles suivent celles de Mathlib »), §9 | aucun guide pour Python et shell | documentaire | citer PEP 8 (ou l'outil retenu) pour `scripts/` | quality | PARTIAL |
| `coding_standards_enforced` | MUST (N/A) | PARTIAL | linters Mathlib, `warningAsError`, `lake lint`, commitlint, REUSE | Python non contrôlé alors qu'un outil FLOSS existe | technique | linter Python en CI | quality | FUTURE |
| `build_standard_variables` | MUST (N/A) | N/A (à confirmer) | binaires natifs produits par Lake (`mainTest`, `spec`) non distribués | ESTIMÉ : le critère vise les builds natifs distribués | — | justifier N/A | — | PARTIAL |
| `build_preserve_debug` | SHOULD (N/A) | N/A | pas de système d'installation | — | — | — | — | PARTIAL |
| `build_non_recursive` | MUST (N/A) | Met | Lake construit un graphe unique de cibles (pas de `make` récursif) | ESTIMÉ (fonctionnement de Lake) | — | — | — | PARTIAL |
| `build_repeatable` | MUST (N/A) | Unmet (non démontré) | aucune comparaison bit-à-bit (`.olean`, HTML, PDF) ; `.claude/rules/verification.md:50-52` rappelle que l'épinglage ne suffit pas | — | technique | double build et comparaison | quality | FUTURE |
| `installation_common` | MUST (N/A) | à confirmer | `require k7pl from git` (convention Lake) possible ; rien de publié pour des utilisateurs | — | interprétatif | Met justifié ou N/A selon §1 | §1 | HUMAN ACTION REQUIRED |
| `installation_standard_variables` | MUST (N/A) | N/A | pas de système d'installation | — | — | — | — | VERIFIED |
| `installation_development_quick` | MUST (N/A) | Met | CONTRIBUTING.md:16-23 ; hook `SessionStart` | — | — | — | — | VERIFIED |
| `external_dependencies` | MUST (N/A), URL | Met | `lakefile.lean:46-53`, `lake-manifest.json`, `scripts/requirements-zenodo.txt` (empreintes) | — | — | — | — | VERIFIED |
| `dependency_monitoring` | MUST (N/A) | PARTIAL | Dependabot (actions hebdo, pip mensuel : `.github/dependabot.yml`) ; `bump-lean.yaml` mensuel | `bump-lean` met à jour, ne détecte pas de vulnérabilités ; dépendances transitives Lake non surveillées ; état des alertes Dependabot illisible | externe / technique | l'autrice confirme que les alertes Dependabot sont actives ; décrire la veille Lean | supply-chain | HUMAN ACTION REQUIRED |
| `updateable_reused_components` | MUST (N/A) | Met | `scripts/bump-lean.sh`, `bump-lean.yaml`, Lake | — | — | — | — | VERIFIED |
| `interfaces_current` | SHOULD (N/A) | Met | les dépréciations Lean produisent des avertissements, bloquants ici | ESTIMÉ (comportement de Lean) | — | — | — | PARTIAL |
| `automated_integration_testing` | MUST | Met (à confirmer) | `ci.yaml` à chaque PR et push sur `main`, rapport agrégé `CI OK` (seul check requis par le ruleset 24138119) | `lake test` ne tourne pas sur un changement purement documentaire ; complet quotidien (`full.yaml`) | interprétatif | justifier la sélection par impact | — | PARTIAL |
| `regression_tests_added50` | MUST (N/A) | à confirmer | aucun bogue logiciel suivi en issue ; règle d'agent `.claude/rules/verification.md:46-48` ; les `fix(...)` récents touchent surtout `spec/` et `.claude/` | pas de traçabilité bogue → test | documentaire | N/A justifié (aucun bogue logiciel corrigé) ou traçabilité | — | PARTIAL |
| `test_statement_coverage80` | MUST (N/A) | N/A pour Lean (à confirmer) ; Unmet pour Python | ESTIMÉ : pas d'outil FLOSS de couverture pour Lean 4 ; `coverage.py` existe pour `scripts/` | — | interprétatif | dépend de §1 (outillage inclus ou non) | §1, quality | HUMAN ACTION REQUIRED |
| `test_policy_mandated` | MUST (N/A) | PARTIAL | règles §5 (procédure d'ajout de module), checklist :409 | pas de politique écrite « toute fonctionnalité majeure ⇒ tests obligatoires » | documentaire | une phrase normative dans CONTRIBUTING | autrice | FUTURE |
| `tests_documented_added` | MUST (N/A) | PARTIAL | PR template :14 | idem | documentaire | idem | autrice | FUTURE |
| `warnings_strict` | MUST (N/A) | PARTIAL | Lean au maximum ; Python sans linter | — | technique | linter Python | quality | FUTURE |
| `implement_secure_design` | MUST (N/A) | à confirmer | CI : permissions minimales (`ci.yaml:13-14`, `release.yaml:11-12` et droits par job :91-95), `persist-credentials: false`, actions épinglées par SHA, `pip --require-hashes` ; bibliothèque Lean pure | aucun argumentaire écrit | documentaire | assurance case | security-assurance | FUTURE |
| `crypto_weaknesses`, `crypto_algorithm_agility`, `crypto_credential_agility`, `crypto_used_network`, `crypto_tls12`, `crypto_certificate_verification`, `crypto_verification_private` | MUST/SHOULD (N/A) | N/A | voir §3 (aucune cryptographie, aucun réseau dans le logiciel produit) | — | — | — | §1 | VERIFIED |
| `signed_releases` | MUST (N/A) | Unmet | `release.yaml:108-111` : attestation de provenance (Sigstore, `actions/attest`) pour le PDF — **jamais exécutée** : l'unique release a 0 fichier joint et son run (36569899593, ancien `lean.yaml`) a échoué au job `zenodo` ; aucune procédure de vérification pour les utilisateurs ; tag non signé | — | technique + documentaire | après une release réussie, documenter `gh attestation verify k7pl-spec.pdf -R AntheaLiles/k7pl` (doc GitHub « use artifact attestations ») ; signer les tags pour les sources | supply-chain | PREPARED |
| `version_tags_signed` | SUGG | Unmet | tag léger non signé | — | technique | clé de signature de l'autrice | supply-chain | FUTURE |
| `input_validation` | MUST (N/A) | N/A (à confirmer) | le logiciel actuel ne lit pas d'entrée non fiable ; l'analyseur du langage en lira (FUTURE) | — | — | — | §1 | FUTURE |
| `hardening` | SHOULD (N/A) | N/A (à confirmer) | aucun logiciel exposé | — | — | — | §1 | FUTURE |
| `assurance_case` | MUST, URL | Unmet | aucun | — | documentaire | assurance case Claim → Argument → Evidence (propriétaire : security-assurance) | security-assurance | FUTURE |
| `static_analysis_common_vulnerabilities` | MUST (N/A) | Unmet (Python, Actions) ; N/A pour Lean (ESTIMÉ) | voir §3 | — | technique | CodeQL ou zizmor + bandit, à arbitrer | scorecard, quality | FUTURE |
| `dynamic_analysis_unsafe` | MUST (N/A) | N/A | voir §3 | — | — | — | — | VERIFIED |

## 5. Gold — critère par critère

| Critère | Exig. | État proposé | Preuve | Écart | Nature | Action possible | Dépendance | Statut |
|---|---|---|---|---|---|---|---|---|
| `achieve_silver` | MUST | Unmet | dépend de §4 | — | — | — | Silver | FUTURE |
| `bus_factor` | MUST, URL | Unmet | une personne | — | structurel | seule issue : une seconde personne réelle | humain | BLOCKED |
| `contributors_unassociated` | MUST, URL | Unmet | un seul contributeur humain ; agents et Dependabot ne sont pas des contributeurs au sens du critère | — | structurel | idem | humain | BLOCKED |
| `copyright_per_file` | MUST | PARTIAL | en-tête SPDX dans tous les sources actifs (`src/`, `tests/`, `tools/`, `spec/*.lean`, `scripts/*.py`/`.sh`, workflows) ; sans en-tête dans le fichier : `archives/outillage-org/` (20 `.py`, 1 `.el`, 1 `.tex`, `Makefile`) et les JSON (couverts par `REUSE.toml`) | archives figées | organisationnel | décider si l'archive est hors périmètre ou reçoit des en-têtes (modification d'archive) | autrice | HUMAN ACTION REQUIRED |
| `license_per_file` | MUST | PARTIAL | idem ; `reuse lint` 363/363 grâce à `REUSE.toml` | idem | organisationnel | idem | autrice | HUMAN ACTION REQUIRED |
| `repo_distributed` | MUST | Met | git | — | — | — | — | VERIFIED |
| `small_tasks` | MUST, URL | Unmet | l'étiquette « good first issue » existe, 0 issue | — | organisationnel | l'autrice ouvre 2-3 issues réellement accessibles (ex. défauts D1-D3 du §7) | autrice | HUMAN ACTION REQUIRED |
| `require_2FA` | MUST | à confirmer | compte personnel : pas de réglage « exiger la 2FA » (réservé aux organisations) ; GitHub impose la 2FA aux comptes qui créent des releases (doc GitHub « About mandatory two-factor authentication ») ⇒ ESTIMÉ actif | — | externe | l'autrice confirme ; option : organisation avec « Require 2FA » | autrice | HUMAN ACTION REQUIRED |
| `secure_2FA` | SHOULD | à confirmer | méthode inconnue (TOTP, clé, passkey ou SMS) | — | externe | l'autrice confirme une méthode non-SMS | autrice | HUMAN ACTION REQUIRED |
| `code_review_standards` | MUST (N/A), URL | Unmet | aucune exigence de revue écrite ; le PR template est une checklist d'auteur | — | documentaire | décrire la revue **réelle** (autrice + CI + agents de vérification), sans prétendre à une seconde personne | autrice | FUTURE |
| `two_person_review` | MUST | Unmet | 0 revue enregistrée sur les 12 PR fermées (`gh api …/pulls/N/reviews` → `[]`) ; ruleset : `required_approving_review_count: 0` | — | structurel | aucune avant une seconde personne | humain | BLOCKED |
| `build_reproducible` | MUST (N/A), URL | Unmet | voir `build_repeatable` | — | technique | — | quality | FUTURE |
| `test_invocation` | MUST, URL | Met | `lake test` | — | — | — | — | VERIFIED |
| `test_continuous_integration` | MUST, URL | Met | `ci.yaml`, `full.yaml` | — | — | — | — | VERIFIED |
| `test_statement_coverage90`, `test_branch_coverage80` | MUST (N/A) | comme `test_statement_coverage80` | — | — | interprétatif | — | §1, quality | HUMAN ACTION REQUIRED |
| `crypto_used_network`, `crypto_tls12` | MUST (N/A) | N/A | voir §3 | — | — | — | — | VERIFIED |
| `hardened_site` | MUST, URL | Unmet probable | GitHub : conforme selon le critère lui-même ; Pages (`github.io`) : ESTIMÉ sans CSP ni X-Frame-Options (GitHub Pages ne permet pas de les définir) ; Zenodo : inconnu ; aucune mesure possible d'ici | — | externe | mesurer (securityheaders.com) ; un autre hébergement serait une décision lourde | autrice | BLOCKED (externe, ESTIMÉ) |
| `security_review` | MUST | Unmet | aucune revue de sécurité humaine documentée ; `docs/relectures/` contient des relectures **de la spécification par des LLM** (`docs/PROVENANCE.md:27-32`), pas des revues de sécurité | — | organisationnel | revue conduite et signée par l'autrice (le critère accepte les membres du projet), appuyée sur cette vague | security-assurance | HUMAN ACTION REQUIRED |
| `hardening` | MUST (N/A), URL | N/A (à confirmer) | aucun logiciel exposé | — | — | — | §1 | FUTURE |
| `dynamic_analysis` | MUST (N/A) | Unmet | voir §3 | — | technique | tests de propriétés (`plausible`) quand un invariant s'y prête | quality | FUTURE |
| `dynamic_analysis_enable_assertions` | SHOULD (N/A) | Unmet | voir §3 | — | technique | — | quality | FUTURE |

## 6. Critères organisationnels

| Critère | État technique | Obstacle organisationnel | Action humaine nécessaire | Possibilité future | Statut |
|---|---|---|---|---|---|
| `governance`, `roles_responsibilities` (Silver) | pratique réelle tracée dans `docs/tracking/DECISIONS.md` | aucun : il suffit de l'écrire | l'autrice valide un texte décrivant le modèle réel : une mainteneuse décide ; les agents IA rédigent et proposent, n'approuvent rien ; les décisions de fond sont consignées | immédiate | HUMAN ACTION REQUIRED |
| `access_continuity` (Silver, MUST) | un compte, deux secrets, comptes Zenodo et ORCID personnels | personne d'autre n'a d'accès | (1) GitHub → Settings → Account → « Successor settings » → « Add successor » ; (2) dépôt chiffré (« lockbox ») : codes de récupération 2FA, accès Zenodo, procédure de rotation de `ZENODO_TOKEN`/`BUMP_TOKEN`, avec mention testamentaire des droits ; (3) option forte : transférer le dépôt dans une organisation avec deux propriétaires | le successeur GitHub ne couvre que le décès, et agit après un certificat de décès + 7 jours ou une nécrologie + 21 jours, sans pouvoir se connecter au compte : il ne suffit pas seul (incapacité, retrait volontaire) | HUMAN ACTION REQUIRED |
| `bus_factor` (Silver SHOULD, Gold MUST) | 1 | une seule personne | aucune action documentaire ; recruter une seconde personne est une décision de projet | Gold seulement avec une seconde personne réelle | BLOCKED |
| `contributors_unassociated` (Gold) | 1 contributeur | idem | idem | idem | BLOCKED |
| `two_person_review` (Gold) | 0 revue enregistrée | idem ; une revue par agent IA ne compte pas, et présenter « l'IA est l'autrice, l'humaine relit » comme une revue par une autre personne serait une revue fabriquée | aucune | idem | BLOCKED |
| `code_review_standards` (Gold) | checklist PR, CI | aucun pour documenter la revue réelle | l'autrice décrit ce qu'elle vérifie avant fusion | immédiate | FUTURE |
| `small_tasks` (Gold) | étiquette existante | aucune issue ouverte | ouvrir 2-3 issues accessibles | immédiate | HUMAN ACTION REQUIRED |
| `require_2FA`, `secure_2FA` (Gold) | non lisible | compte personnel | confirmer la 2FA et sa méthode | organisation avec « Require 2FA » | HUMAN ACTION REQUIRED |
| `dco` (Silver SHOULD) | 1/69 `Signed-off-by` | choix juridique | adopter ou justifier | — | HUMAN ACTION REQUIRED |
| `know_secure_design`, `know_common_errors` (Passing) | — | compétence personnelle | réponse sincère de l'autrice | formation libre | HUMAN ACTION REQUIRED |
| `security_review` (Gold) | — | aucune revue humaine | revue datée et signée par l'autrice | après la vague 2 | HUMAN ACTION REQUIRED |
| `english` (Passing SHOULD) | — | politique de langue | justifier ou ouvrir aux rapports en anglais | — | HUMAN ACTION REQUIRED |

## 7. Documents de gouvernance et de sécurité : pratique réelle ou décor ?

| Document | Répond-il à une pratique réelle ? | Critères servis | Recommandation |
|---|---|---|---|
| `GOVERNANCE.md` | **Oui**, si court et factuel : une mainteneuse unique qui décide ; agents IA qui proposent sans approuver ; journal des décisions dans `docs/tracking/DECISIONS.md` ; issue préalable pour les propositions non triviales (CONTRIBUTING.md:27-28) | `governance`, `roles_responsibilities`, éclaire `repo_track` | à créer en vague 2 **après validation de l'autrice** ; y intégrer les rôles |
| `MAINTAINERS.md` | Non, seul : il ne listerait qu'un nom, déjà dans `CITATION.cff` | — | **décoratif** : fusionner dans GOVERNANCE.md |
| `ROADMAP.md` | En partie : le tableau de bord porte un vrai chemin (portes P1-P6, `D-9` : `spec-v0.1.0` après P6) ; l'horizon d'un an et la liste « ce que le projet ne fera pas » sont des intentions que seule l'autrice peut énoncer | `documentation_roadmap` | à écrire par l'autrice, ou section du tableau de bord liée depuis le README ; un texte rédigé par un agent serait une intention fabriquée |
| `docs/security/SECURITY-MODEL.md` | **Oui** : ce qu'on peut attendre aujourd'hui (théorèmes Lean prouvés modulo les axiomes audités ; aucune garantie sur les énoncés de la spec non formalisés ; aucun binaire publié ; chaîne de publication) | `documentation_security` | propriétaire : security-assurance |
| `docs/security/THREAT-MODEL.md` | **Oui** pour la CI, les releases, Pages et Zenodo (secrets, permissions d'écriture, PR de forks) | `assurance_case` | security-assurance |
| `docs/security/ASSURANCE-CASE.md` | **Oui**, exigé par Silver, à condition d'argumenter les vraies frontières de confiance | `assurance_case`, `implement_secure_design` | security-assurance ; le CII ne fait que le lier |
| `docs/security/SECURITY-REVIEW.md` | **Seulement** si une revue humaine a réellement lieu ; un document d'agent intitulé « revue de sécurité » serait un faux signal pour `security_review` | `security_review` | ne pas créer sans revue humaine datée |
| `CODEOWNERS` | Non pour une personne seule (pas de second relecteur à solliciter) | aucun critère CII | décoratif ; domaine github-governance |
| `.bestpractices.json` | mécanisme réel du site (pré-remplissage) | aucun | non nécessaire ; risque de dériver de l'état saisi sur le site |

## 8. Affirmations actuelles qui excèdent les preuves

| # | Affirmation | Preuve contraire ou manquante | Gravité |
|---|---|---|---|
| A1 | `CITATION.cff:22-24` : spécification « vérifiée par Lean 4 contre son implémentation de référence » ; `zenodo.json:3` : « chaque exemple de code est compilé contre l'implémentation de référence » ; `zenodo.files.json:4` : « exemples vérifiés par Lean 4 » | il n'existe pas d'implémentation de référence (`src/` = trois modules jouets) ; le build Verso vérifie renvois, citations et axiomes des modules Lean de la spec, il ne compile aucun exemple k7pl | **haute** : affirmation publique de vérification ; métadonnées peut-être déjà déposées sur Zenodo (non vérifiable) |
| A2 | README.md:67-68 : « son PDF est joint à la release GitHub correspondante » ; README.md:39-40 et CONTRIBUTING.md:92-93 : PDF publié sur Zenodo et joint par la CI | la release `spec-v0.0.0-alpha.1` a 0 fichier joint ; son run (36569899593) a échoué à l'étape « Check that the release matches CITATION.cff and spec/CHANGELOG.md » ; la chaîne n'a jamais réussi de bout en bout | haute (PREPARED présenté comme fait) |
| A3 | README.md:11 et `CITATION.cff:13` : DOI `10.5281/zenodo.23040451` | le DOI apparaît le 2026-10-01 (05aa321), après l'échec de la CI ; l'origine du dépôt Zenodo (manuel, intégration GitHub-Zenodo ?) n'est documentée nulle part | moyenne — HUMAN : vérifier ce que contient l'enregistrement |
| A4 | README.md:12-13 : badges Software Heritage « origin » et « directory » | l'origine archivée est le DOI Zenodo, pas le dépôt GitHub ; `swh:1:dir:b81695cf…` n'est ni l'arbre git du tag (`87a04386…`) ni cet arbre enveloppé sous les noms d'archive usuels (calcul local) ; contenu non vérifiable d'ici | moyenne — peut laisser croire que le code source est archivé |
| A5 | README.md:14 : badge fair-software.eu à 4/5 | badge **statique** (shields.io), non recalculé ; le critère « registry » y compte grâce à une exemption auto-déclarée (`.howfairis.yml:7-10`) ; le CHANGELOG (l. 20-23) le dit, le README non | faible à moyenne |
| A6 | README.md:8 : badge « Lean Build » vers `lean.yaml` | workflow supprimé en 90e5ea0 ; ESTIMÉ : le badge continue d'afficher l'état du dernier run (succès du 2026-10-05) d'un workflow qui ne tourne plus | moyenne (signal périmé) |
| A7 | CODE_OF_CONDUCT.md:45 : signalement « par message privé … via son profil GitHub » | GitHub n'offre pas de messagerie privée | moyenne (canal inopérant) |
| A8 | CONTRIBUTING.md:33-34 : « Tous les checks doivent passer : compilation, tests, lint, audit des axiomes… » | sélection par impact : ces checks ne tournent que si la surface Lean change | faible |

Défauts documentaires (`documentation_current`), hors `spec/` sauf mention :

- **D1** README.md:8 (badge `lean.yaml`, voir A6).
- **D2** `docs/suivi/DASHBOARD.md:163` (« job `build` ») et :181 (« workflow `lean.yaml`, job `zenodo` ») : workflows renommés.
- **D3** `lakefile.lean:74` : « generated by `outils/biblio/biblio.py` » — le script est `scripts/biblio/biblio.py`.
- **D4** `CHANGELOG.md:54` : PDF « Verso → TeX → LuaLaTeX » ; la CI utilise Tectonic (`verify.yaml:184-233`).
- **D5** SECURITY.md:10 : « k7pl n'a pas encore de version publiée » alors que `spec-v0.0.0-alpha.1` existe (ambigu : vrai pour l'implémentation).
- **D6** `.claude/skills/writing-rules.md:35` : Dependabot « Mises à jour des GitHub Actions » ; il couvre aussi pip.

Point positif à conserver : `.github/workflows/README.md:110` dit explicitement que l'attestation de
provenance n'est pas une signature du tag. C'est le ton juste.

## 9. Actions humaines — procédures

**H1. Relire l'état saisi sur le site** (préalable à tout le reste).
1. Se connecter sur <https://www.bestpractices.dev/fr/projects/15239> avec le compte GitHub propriétaire.
2. Ouvrir successivement `…/projects/15239/passing/edit`, `…/silver/edit`, `…/gold/edit` (format
   `/projects/:id/:section/edit`, documenté dans `docs/api.md` du dépôt du site).
3. Pour chaque critère, comparer avec les §3-5 : n'indiquer `Met` que si la preuve citée existe ; coller les
   URL indiquées pour les critères « URL required ». Ne pas reprendre aveuglément l'auto-remplissage
   (bouton « Save (and continue) 🤖 ») : par exemple, GitHub ne détecte pas la licence
   (`license: NOASSERTION`), la réponse à `floss_license` doit donc être justifiée à la main.
4. Vérifier : `https://www.bestpractices.dev/projects/15239.json` (champs `badge_level`,
   `tiered_percentage`, `*_status`, `*_justification`).

**H2. Trancher la question du §1** et l'écrire dans la description du projet sur le site.

**H3. Notes de la release existante** : GitHub → Releases → `spec-v0.0.0-alpha.1` → Edit → remplacer la liste
auto-générée par un résumé lisible (ce que contient cette alpha, ce qui n'y est pas) ; cocher « Set as a
pre-release » ; enregistrer. Vérifier : `gh api repos/AntheaLiles/k7pl/releases --jq '.[0] | {prerelease, body}'`.

**H4. Données privées** : Security → Advisories (aucun rapport en attente de plus de 14 jours) ; Security →
Dependabot alerts (activé ; aucune alerte moyenne ou plus ancienne de 60 jours) ; Security → Code scanning
(alertes Scorecard ouvertes). Reporter le résultat dans les justifications du site.

**H5. Continuité d'accès** : GitHub → Settings → Account → « Successor settings » → saisir la personne →
« Add successor » (elle reste « Pending » jusqu'à acceptation). Compléter par un coffre (codes de récupération
2FA, accès Zenodo/ORCID, procédure de rotation des secrets) et une disposition testamentaire, ou par une
organisation à deux propriétaires. Vérifier : la personne apparaît comme successeur accepté.

**H6. 2FA** : GitHub → Settings → Password and authentication : 2FA active, méthode autre que SMS. Le dire
dans la justification de `require_2FA` / `secure_2FA` (Gold).

**H7. Badge** : quand l'autrice le décide, ajouter au README
`[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/15239/badge)](https://www.bestpractices.dev/projects/15239)`
(format documenté dans `docs/api.md` du site) ; il affiche l'état réel, y compris « in progress ». Effet de bord :
le critère « checklist » de fair-software deviendrait satisfait.

**H8. Décisions de contenu** (aucune ne peut être prise par un agent) : gouvernance et rôles (validation d'un
texte), feuille de route (intentions à un an, « ce que le projet ne fera pas »), DCO, langue des rapports,
canal du code de conduite, processus de réponse aux vulnérabilités (engagements), sort des affirmations A1-A5.

**H9. Revue de sécurité** (Gold) : la conduire, la dater, la signer ; préciser l'assistance des agents.

## 10. Ce qu'il ne faut pas « corriger » ni ajouter

- Ne pas déclarer `bus_factor`, `contributors_unassociated` ou `two_person_review` satisfaits grâce aux agents,
  à Dependabot, ou au fait que les commits « Claude » sont relus par l'humaine.
- Ne pas créer `MAINTAINERS.md` ou `CODEOWNERS` à un seul nom pour « faire » de la gouvernance.
- Ne pas rédiger de feuille de route ni de revue de sécurité à la place de l'autrice.
- Ne pas cocher `signed_releases` sur la seule présence de `actions/attest` dans `release.yaml` : aucune
  attestation n'existe encore.
- Ne pas cocher `build_repeatable` sur la base de l'épinglage (`lake-manifest.json`, SHA d'actions).
- Ne pas ajouter de SAST « pour le score » sans traitement des résultats (`static_analysis_fixed`).
- Ne pas marquer N/A des critères de documentation sans avoir d'abord écrit la réponse du §1.

## 11. Fichiers que la vague 2 pourrait toucher (côté CII)

`README.md` (badges A4-A6, D1, badge CII), `CONTRIBUTING.md` (politique de tests, langue, revue, DCO),
`SECURITY.md` (processus de réponse, D5), `CODE_OF_CONDUCT.md:45` (canal), `GOVERNANCE.md` (nouveau, après
validation), `CITATION.cff`, `zenodo.json`, `zenodo.files.json` (A1, sur décision de l'autrice),
`lakefile.lean:74` (D3), `CHANGELOG.md`, `docs/suivi/DASHBOARD.md` (D2),
`.claude/skills/writing-rules.md:35` (D6). Les documents `docs/security/*.md` appartiennent à
security-assurance : le CII s'y réfère sans les écrire.

## 12. Chevauchements et frontières

- **security-assurance** : SECURITY-MODEL, THREAT-MODEL, ASSURANCE-CASE, SECURITY-REVIEW figurent dans les
  deux définitions d'agent (`cii-specialist.md:41-47`, `security-assurance-specialist.md:59-62`) ⇒ risque de
  collision d'écriture ; proposer qu'un seul propriétaire (security-assurance) les écrive.
- **supply-chain** : `signed_releases`, `version_tags_signed`, `dependency_monitoring` ; hook `curl | sh`
  sur branche mutable (`scripts/claude-session-start.sh:15-16`) ; `bump-lean.yaml:46` interpole
  `${{ steps.version.outputs.latest }}` (valeur issue d'une requête distante) directement dans `run:`.
- **quality-reproducibility** : `build_repeatable`/`build_reproducible`, couverture, linter Python,
  `dynamic_analysis`. Constat voisin : `ci.yaml:57` contient `\\.` dans une expression `grep -E` d'un bloc
  littéral YAML, qui exige un antislash littéral et ne correspond donc jamais aux chemins visés ; sans effet
  aujourd'hui car `scripts/ci/impact.py:14-22` couvre les mêmes chemins.
- **scorecard** : SAST (`static_analysis_common_vulnerabilities`), Code-Review, Signed-Releases recoupent les
  critères CII ; lecture des alertes Scorecard (H4).
- **github-governance** : ruleset `PR on main` (0 approbation requise, `CI OK` requis, historique linéaire),
  2FA, organisation éventuelle (H5, H6).

## 13. Points touchant `spec/`, `src/` ou la sémantique (signalés, non proposés comme faits)

- `spec/CHANGELOG.md` n'a pas de section pour `0.0.0-alpha.1` (`release_notes`) : l'ajouter rétroactivement
  modifierait un fichier de `spec/` ; décision de l'autrice.
- L'affirmation A1 décrit la relation spec ↔ implémentation : la corriger revient à décrire honnêtement
  l'état de la formalisation, ce qui relève de l'autrice et de la séparation épistémique du projet.
- `documentation_security` et l'assurance case ne doivent pas reprendre comme garanties les propriétés de
  sécurité *du langage* énoncées dans la spec (non-interférence, déclassification…) : ce sont des énoncés,
  pas des propriétés implémentées ni prouvées.
- `input_validation`, `hardening`, `dynamic_analysis` deviendront réels avec l'analyseur et le compilateur
  (FUTURE) : rien à faire dans `src/` au titre du badge aujourd'hui.

## 14. Non vérifié, et pourquoi

- État saisi sur bestpractices.dev, en-têtes de Pages, contenu Zenodo et Software Heritage : hôtes refusés
  par le proxy.
- Alertes Dependabot et code scanning, avis privés, réglages Pages, collaborateurs, environnements,
  protection de branche classique : API refusées (proxy ou 403).
- 2FA et méthode : donnée du compte.
- `lake build`, `lake test`, `lake lint` en local : pas de toolchain (résultats CI seulement).
- gitleaks, actionlint, zizmor, scorecard non exécutés localement (absents).
- Licences exactes des outils de build (`build_floss_tools`) : non relues.
