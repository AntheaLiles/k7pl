<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit sécurité et assurance — vague 1

| Champ | Valeur |
|---|---|
| Rôle | `security-assurance-specialist` (agent, **pas une revue humaine**) |
| Date | 2026-10-05/06 |
| Base auditée | `main` = `b5f6146` (worktree `.claude/worktrees/agent-aaf6c73db6e6cd8fb`, branche `worktree-agent-aaf6c73db6e6cd8fb`) |
| Périmètre | modèle de menace réel, workflows et privilèges, surface d'exécution de code, chemins d'attaque, revendications (Claim → Argument → Evidence), SAST, faux signaux, documents d'assurance |
| Nature | **audit uniquement** : aucun workflow, script, ni fichier de `spec/`/`src/` modifié |
| Validation | aucune toolchain Lean locale : rien n'a été compilé ; aucune affirmation ci-dessous ne repose sur un `lake build` |

Conventions : **[FO]** fait observé (commande ou fichier:ligne lus par cet agent) · **[I]** interprétation ·
**[H]** hypothèse · **[D]** décision proposée (à arbitrer) · **[A]** action restante. Statuts : `VERIFIED` ·
`PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE` · `N/A`. « ESTIMÉ » = non vérifié ici.
Échelles : vraisemblance F (faible) / M (moyenne) / É (élevée) ; impact F / M / É / C (critique).

## 0. Synthèse

1. **[FO]** Aucun déclencheur dangereux (`pull_request_target`, `workflow_run`, `issue_comment`), 18 actions
   épinglées par SHA **et** chaque SHA correspond bien au tag annoncé en amont (pas de commit imposteur),
   `persist-credentials: false` sur les 13 `actions/checkout`, une seule expression dans un `run:` et elle est
   filtrée par deux regex. La CI de PR (y compris depuis un fork) ne détient aucun secret ni jeton en écriture.
   L'hygiène « classique » des workflows est bonne.
2. **[I]** La faiblesse structurelle est ailleurs : **un seul humain, 0 approbation requise, aucun environnement
   protégé, aucun ruleset de tag**. Le ruleset de `main` protège contre l'accident, pas contre un identifiant
   compromis : tout porteur de `contents:write` + `pull-requests:write` (compte, `BUMP_TOKEN`, session d'agent
   avec droits d'écriture) peut ouvrir une PR, attendre `CI OK`, fusionner, taguer et déclencher une publication
   Zenodo **irréversible** (DOI).
3. **[FO]** La chaîne de publication de la spécification (`publish-spec` + attestation + Zenodo) **n'a jamais
   abouti** : l'unique release (`spec-v0.0.0-alpha.1`) a échoué au contrôle de métadonnées (run 36569899593,
   ancien `lean.yaml`), aucun asset n'est attaché, la branche `zenodo-state` n'existe pas. Toute revendication
   « PDF joint à la release / archivé sur Zenodo / provenance » est aujourd'hui **non satisfaite**.
4. **[I]** Trois écarts réels de moindre privilège : `bump-lean` exécute du code amont (`lake update/build/test`,
   `elan-init.sh` depuis `master`) dans un job qui détient le PAT `BUMP_TOKEN` et un `GITHUB_TOKEN` en écriture
   **inutilisé** ; le job `zenodo` lit un état depuis une branche mutable non protégée et l'injecte dans des URL
   appelées avec le jeton Zenodo ; les builds de release restaurent des caches Actions de portée `main`.
5. **[FO]** La surface « le langage exécute du code » n'existe pas encore : `src/` = 106 lignes (un compteur LTS et
   de l'arithmétique), sans IO, FFI, `unsafe`, `#eval` ni `initialize`. L'exécution de code arbitraire est en
   revanche **inhérente à la chaîne de construction** (Lake, élaboration Lean, dépendances, C de MD4Lean).
6. **[I]** Le vecteur le plus vraisemblable aujourd'hui est **l'agent de code piégé** : 49 des 69 commits de
   `main` sont signés « Claude », les PR sont ouvertes et fusionnées sous l'identité du mainteneur avec 0 revue
   formelle, et aucun agent ne restreint ses outils. `isolation: worktree` n'est pas une frontière de sécurité.

## 1. Faits observés et commandes

| # | Fait | Preuve (commande exécutée ou fichier:ligne) |
|---|---|---|
| F1 | Ruleset unique « PR on main » (branche `~DEFAULT_BRANCH`) : `deletion`, `non_fast_forward`, `pull_request` (0 approbation, pas de code owners, pas de last-push approval), `required_linear_history`, `required_status_checks` = `CI OK` (integration_id 15368), `strict_required_status_checks_policy: false` ; `bypass_actors: []` en lecture **anonyme** (non probant) | `unset GH_TOKEN; gh api repos/AntheaLiles/k7pl/rulesets/24138119` |
| F2 | Aucun ruleset de tag | `gh api repos/AntheaLiles/k7pl/rulesets` (1 seul ruleset, `target: branch`) |
| F3 | Refs distantes : `main`, une branche `claude/…`, `refs/pull/*`, tag `spec-v0.0.0-alpha.1` ; **pas de `zenodo-state`** | `git ls-remote origin` |
| F4 | Run de release 36569899593 (`lean.yaml` @ `dcd65a9`) : job `zenodo` en échec à l'étape « Check that the release matches CITATION.cff… » ; release sans asset | `gh api …/actions/runs?event=release` ; `…/runs/36569899593/jobs` ; `gh api …/releases` |
| F5 | Signalement privé de vulnérabilité activé | `gh api repos/AntheaLiles/k7pl/private-vulnerability-reporting` → `{"enabled":true}` |
| F6 | 69 commits sur `origin/main`, **tous** `%G? = N` ; auteurs : « Claude » 49 (27 `noreply@anthropic.com`, 22 adresse noreply du mainteneur), « Cyprien PIERRE » 19, dependabot 1 | `git log --format=%G? origin/main \| sort \| uniq -c` ; idem `%an <%ae>` |
| F7 | PR 7, 9, 11, 12, 13 : 0 review chacune, fusionnées par `AntheaLiles` ; PR 13 (13 fichiers, workflows) fusionnée 18 min après ouverture | `scratchpad/sa_probe_prs.sh` (API publique `pulls/N`, `pulls/N/reviews`) |
| F8 | Aucun `pull_request_target` / `workflow_run` / `issue_comment` ; 13 `actions/checkout`, 13 `persist-credentials: false` ; une seule expression `${{ }}` dans un `run:` : `bump-lean.yaml:46` | `scratchpad/sa_probe_workflows.sh` |
| F9 | 18 actions épinglées : chaque SHA = cible du tag commenté dans le dépôt amont | `scratchpad/sa_probe_pins.sh` (`git ls-remote --tags`), 18 × `OK` |
| F10 | `leanprover/lean-action@f061402…` (v1.6.1) installe elan par `curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \| sh`, inconditionnellement | `action.yml:221-226` et `scripts/install_elan.sh:8-9` téléchargés au SHA épinglé |
| F11 | `actions/attest` v4.2.2 : `artifact-metadata: write` ne sert qu'aux *storage records* (avec `push-to-registry: true`, dépôts d'organisation uniquement) | README de l'action au SHA épinglé, l. 63-76 et 367-380 |
| F12 | Le `grep -Eq` de `ci.yaml:57` ne reconnaît pas `lakefile.lean`, `lake-manifest.json`, `.github/dependabot.yml`, `scripts/sync_zenodo.py`, `scripts/requirements-zenodo.txt` (`\\.` = antislash littéral) ; `impact.py` les classe pourtant en `full` (`FULL_EXACT`, l. 14-21) → aucun effet actuel, redondance illusoire | `scratchpad/sa_probe_impact.sh` |
| F13 | `impact.py` classe `.claude/settings.json` sans aucun contrôle, `.claude/agents/*.md` et `SECURITY.md` en simple vérification de liens | même sonde |
| F14 | Les 14 fichiers `.claude/agents/*.md` commencent par un commentaire SPDX `<!-- … -->` ; le bloc `---` n'arrive qu'à la ligne 6 ; aucun ne déclare `tools:` | `head -c 4` + `grep -n -m1 '^---$'` sur chaque fichier |
| F15 | Worktrees d'agents sous `/home/user/k7pl/.claude/worktrees/` (6 présents), exclus par `.git/info/exclude`, partageant le même `.git` (hooks, config, stash) | `git check-ignore -v` ; `ls` |
| F16 | `lake-manifest.json` : 14 paquets git épinglés par commit (dont MD4Lean, code C, depuis un compte personnel `acmepjz`) | lecture JSON du manifeste |
| F17 | `scripts/requirements-zenodo.txt` : 5 paquets, 180 empreintes `sha256`, installés avec `--require-hashes` (`release.yaml:160`) | `grep -c sha256` |
| F18 | Zenodo, `api.securityscorecards.dev`, `bestpractices.dev`, API `actions/caches`, `immutable-releases`, `pages`, `environments` : refusés depuis cette session | `curl` → `CONNECT 403` ; `gh api` → 403 |

## 2. Modèle de menace (brouillon structuré)

### 2.1 Actifs

| Actif | Propriété à protéger | Où |
|---|---|---|
| A1. Branche `main` (spec, implémentation, preuves, workflows, règles d'agents) | intégrité, traçabilité | GitHub |
| A2. Tags et releases `spec-v*` / `v*` | intégrité, lien tag ↔ commit revu | GitHub |
| A3. PDF de la spécification + somme SHA-256 + attestation Sigstore | intégrité, authenticité | assets de release, API attestations |
| A4. Dépôts Zenodo (DOI de version et de concept) | intégrité, **irréversibilité** : un dépôt publié ne se retire pas par l'utilisateur | compte Zenodo du mainteneur (tous ses dépôts, pas seulement k7pl) |
| A5. Site GitHub Pages (`anthealiles.github.io/k7pl`) | intégrité | environnement `github-pages` |
| A6. Secrets : `ZENODO_TOKEN`, `ZENODO_ENV`, `BUMP_TOKEN` ; jetons éphémères `GITHUB_TOKEN`, OIDC, `ACTIONS_RUNTIME_TOKEN` | confidentialité | secrets de dépôt, mémoire du runner |
| A7. Caches Actions (`.lake/packages` avec oléans compilés, `~/.cache/Tectonic`) | intégrité | stockage de cache, portée par ref |
| A8. Assurance des preuves (« aucun axiome hors liste ») | correction | `axiom-audit`, oléans Mathlib |
| A9. Comptes : GitHub `AntheaLiles`, Zenodo, ORCID | authenticité | hors dépôt |
| A10. Sessions d'agents Claude Code (identifiants GitHub de session, écriture dans le dépôt) | intégrité | conteneur de session, proxy |

### 2.2 Acteurs

| Acteur | Capacités | Motivation plausible |
|---|---|---|
| T1. Anonyme / contributeur externe (fork) | ouvrir issues et PR ; faire exécuter du code dans la CI non privilégiée | vandalisme, minage, ingénierie sociale, injection de prompt |
| T2. Mainteneur (unique humain) | admin ; seul à fusionner, taguer, publier | — (risque d'erreur, de fatigue, de confiance excessive dans les agents) |
| T3. Agents Claude Code (sessions, sous-agents) | lecture/écriture du dépôt ; outils GitHub MCP (dont `merge_pull_request`, `push_files`) ; agissent sous l'identité du mainteneur | aucune ; **vecteur** d'un attaquant via injection |
| T4. Amont compromis : actions GitHub, Lean/elan, Mathlib/CSLib/Verso et transitifs, serveur de cache Mathlib, PyPI, Tectonic et son bundle TeX | code exécuté dans les jobs qui les utilisent | chaîne d'approvisionnement |
| T5. Voleur d'identifiant (PAT, session, jeton Zenodo) | les droits de l'identifiant volé | publication falsifiée, persistance |
| T6. Plateformes (GitHub, Zenodo, Sigstore) | racines de confiance | hors modèle (supposées honnêtes) |

### 2.3 Frontières de confiance

| Frontière | Côté non fiable → côté fiable | Contrôle observé |
|---|---|---|
| B1. PR (fork ou branche) → `main` | code de la PR → branche intégrée | ruleset : PR + `CI OK` ; **0 approbation** ; décision humaine de fusion |
| B2. Job non privilégié → job privilégié (même run) | artefacts `spec-tex`, `spec-pdf`, `github-pages` | artefacts du **même run** seulement (`download-artifact` sans `run-id`) ; pas de cache restauré dans les jobs privilégiés |
| B3. Ref quelconque → cache de portée `main` → run de tag | caches Actions | portée par ref (une PR n'écrit pas dans le cache de `main`) ; **aucune** protection des runs de release contre un cache `main` empoisonné |
| B4. Commit quelconque → tag de release → workflow `release.yaml` | le workflow exécuté est celui **du commit tagué** | aucun : ni ruleset de tag, ni contrôle « commit tagué ∈ `main` » |
| B5. Dépôt GitHub → Zenodo | `ZENODO_TOKEN` (secret de dépôt) | aucun environnement, aucune approbation |
| B6. Contenu lu par un agent (issue, PR, fichier, journal CI, page web) → actions de l'agent | instructions vs données | système de permissions Claude Code (mode non vérifié), proxy ; règles écrites dans `.claude/` |
| B7. Amont (Lake, PyPI, actions, curl) → runner | code et binaires | SHA d'action, commit du manifeste, `--require-hashes`, SHA-256 de Tectonic ; **pas** pour `elan-init.sh`, la toolchain Lean, les oléans Mathlib, le bundle TeX |

### 2.4 Surfaces d'attaque

- S1. Événements GitHub : `pull_request` (forks), `push: main`, `release: published`, `schedule`, `workflow_dispatch`, `branch_protection_rule`.
- S2. Code exécuté à la construction : `lakefile.lean` (Lean exécuté par Lake), élaboration (macros, tactiques, `initialize` des dépendances), C de MD4Lean compilé, scripts Python et shell du dépôt.
- S3. Téléchargements : toolchain (elan, Lean), dépendances Lake, `lake exe cache get`, PyPI, Tectonic + bundle TeX, `axiom-audit` (cloné et compilé).
- S4. Caches Actions et artefacts.
- S5. Branche `zenodo-state` (lue puis écrite par le job `zenodo`).
- S6. Identifiants : compte GitHub, `BUMP_TOKEN`, `ZENODO_TOKEN`, sessions d'agents.
- S7. Fichiers qui pilotent les agents : `.claude/settings.json` (hook `SessionStart`), `scripts/claude-session-start.sh`, `.claude/agents/*.md`, `.claude/rules/*.md`, `.claude/skills/**`, `.claude/CLAUDE.md`.
- S8. Intégrations hors CI : application ou webhook Zenodo–GitHub (**[H]**, voir §5 A12), Pages.

### 2.5 Hypothèses de sécurité (à tenir pour vraies, non vérifiées ici)

- H-1. Le compte GitHub du mainteneur est protégé par une 2FA résistante à l'hameçonnage. `HUMAN ACTION REQUIRED`.
- H-2. GitHub, Sigstore et Zenodo sont honnêtes ; l'isolement entre runners hébergés est effectif.
- H-3. Les organisations amont `leanprover`, `leanprover-community`, `actions` ne sont pas compromises au moment d'une montée de version.
- H-4. Le mainteneur relit réellement les diffs de `.github/workflows/`, `scripts/ci/`, `.claude/` avant de fusionner (aucune trace : 0 review formelle, F7).
- H-5. Les sessions d'agents n'ont pas de droit de fusion non supervisé (mode de permission non vérifié).
- H-6. `BUMP_TOKEN` est un PAT *fine-grained* limité à k7pl, sans permission *Workflows* (non vérifiable ici).

### 2.6 Contrôles existants (avec preuve)

| Contrôle | Ce qu'il arrête réellement | Preuve | Statut |
|---|---|---|---|
| C1. Épinglage SHA des actions, SHA = tag amont | mutation de tag amont ; commit imposteur | F9 | VERIFIED |
| C2. `permissions: contents: read` par défaut, écritures limitées par job | abus du `GITHUB_TOKEN` dans les jobs non privilégiés | F8 ; `ci.yaml:13-14`, `release.yaml:11-12`, `verify.yaml:41-42` | VERIFIED |
| C3. `persist-credentials: false` partout | persistance du jeton dans `.git/config` | F8 | VERIFIED (le jeton reste en mémoire du runner) |
| C4. Pas de déclencheur privilégié sur contenu non fiable | « pwn request » | F8 | VERIFIED |
| C5. Artefacts consommés dans le même run uniquement | artefact injecté depuis un autre run | `release.yaml:99-102,150-153`, `verify.yaml:194-197` | VERIFIED |
| C6. Jobs privilégiés sans checkout ni build (`publish-spec`, `deploy-pages`) | code amont dans le job qui signe/publie | `release.yaml:85-116`, `ci.yaml:118-136` | VERIFIED |
| C7. `--require-hashes` pour Zenodo | paquet PyPI substitué | F17 | VERIFIED |
| C8. Tectonic vérifié par SHA-256 | binaire substitué | `verify.yaml:191-192,207` | VERIFIED (le bundle TeX téléchargé ensuite : non vérifié) |
| C9. `axiom-audit` cloné par tag puis contrôlé par SHA | outil d'audit substitué | `scripts/axiom-audit.sh:17-18,25-30` | VERIFIED |
| C10. Dépendances Lake épinglées par commit | dérive silencieuse | F16 | VERIFIED |
| C11. Validation de version par regex (`latest-lean-version.sh:13`, `bump-lean.sh:21`) | injection via `steps.version.outputs.latest` | lecture | VERIFIED |
| C12. Ruleset `main` + `CI OK` lié à l'app GitHub Actions (15368) | force-push, suppression, fusion sans CI, statut usurpé par une autre app | F1 | VERIFIED (n'arrête pas un identifiant en écriture) |
| C13. gitleaks sur PR (historique complet de la PR) | secret committé | `security.yaml:25-36` | PARTIAL : `archives/outillage-org/` exclu (`.gitleaks.toml:13`) |
| C14. Signalement privé de vulnérabilité | divulgation publique prématurée | F5 | VERIFIED |
| C15. Attestation de provenance du PDF | substitution du PDF *après* la build | `release.yaml:108-111` | **FUTURE** : jamais exécutée (F4) |

### 2.7 Risques résiduels (après contrôles existants)

R1 compromission du compte mainteneur (C, F-M) ; R2 vol ou abus de `BUMP_TOKEN` (É, F) ; R3 publication Zenodo
falsifiée ou mal rattachée (É, F) ; R4 empoisonnement de cache vers la release (É, F) ; R5 agent piégé (É, M) ;
R6 amont compromis (elan `master`, oléans Mathlib, bundle TeX) (M-É, F) ; R7 incohérence DOI au premier
`spec-v*` réussi (M, É — quasi certain si rien ne change, voir §5 A11).

## 3. Revue des workflows et des privilèges

### 3.1 Vue d'ensemble

| Workflow / job | Déclencheur | Permissions | Secrets | Code tiers exécuté | Verdict |
|---|---|---|---|---|---|
| `ci.yaml` `impact` | push main, PR, dispatch | `contents: read` | — | Python du dépôt (celui de la PR) | OK |
| `ci.yaml` → `verify.yaml` (`quick`, `impl`, `spec`, `spec-pdf`) | idem | `contents: read` | — | Lake, Lean, Mathlib, Verso, MD4Lean, lychee, Tectonic | OK (non privilégié) ; écrit des caches |
| `ci.yaml` `deploy-pages` | push main, si `CI OK` | `pages: write`, `id-token: write`, env. `github-pages` | — | `configure-pages`, `deploy-pages` | Justifié (§3.3) |
| `reuse`, `commitlint`, `security` (réutilisables) | via `ci.yaml` | `contents: read` | `GITHUB_TOKEN` (lecture) pour gitleaks | reuse-action, commitlint, actionlint, gitleaks (binaires téléchargés par les actions) | OK |
| `full.yaml` | cron quotidien, dispatch | `contents: read` | — | comme `verify` | OK ; **alimente les caches de portée `main`** |
| `scorecard.yaml` | push main, cron, `branch_protection_rule`, dispatch | top `read-all` ; job : `security-events: write`, `id-token: write`, `contents: read`, `actions: read` | — | scorecard-action, upload-sarif | Justifié |
| `release.yaml` `*-release-check`, `*-verify` | `release: published` | `contents: read` | — | Lake/Lean/Verso/Tectonic | OK, **mais** restaure les caches de `main` (§3.5) |
| `release.yaml` `publish-spec` | idem, tag `spec-v*` | `contents`, `id-token`, `attestations`, `artifact-metadata` : write | `GITHUB_TOKEN` | download-artifact, attest, `gh` | Justifié sauf `artifact-metadata` (§3.2) |
| `release.yaml` `zenodo` | idem | `contents: write` | `ZENODO_TOKEN`, `ZENODO_ENV`, `GITHUB_TOKEN` | checkout, download-artifact, setup-python, pip (hashé), `sync_zenodo.py` | **Écarts** (§3.2) |
| `bump-lean.yaml` `bump` | cron mensuel, dispatch | `contents: write`, `pull-requests: write` | `BUMP_TOKEN` | **lake update/build/test sur version amont neuve**, lean-action (+ `elan-init.sh` de `master`), create-pull-request | **Écart principal** (§3.4) |

### 3.2 `release.yaml`

**`publish-spec`** (`release.yaml:85-116`).
- `contents: write` : requis par `gh release upload` (l. 116). Inévitable tant que le PDF est attaché *après*
  publication de la release.
- `id-token: write` + `attestations: write` : requis par `actions/attest` (certificat Sigstore via OIDC, stockage
  de l'attestation). Inévitables pour l'attestation.
- `artifact-metadata: write` : **[FO]** l'action ne s'en sert que pour un *storage record* avec
  `push-to-registry: true`, réservé aux dépôts d'organisation (F11) ; ici sujet fichier, dépôt personnel. **[I]**
  Privilège inutile (impact faible). **[D]** Le retirer, en le validant par une release de test.
- **[FO]** Le job n'exécute ni checkout ni build : bon découpage (C6).
- **[I]** `--clobber` (l. 116) permet de remplacer un asset existant lors d'une relance : sans gravité tant que
  l'attestation est régénérée, mais à garder en tête si l'on active les releases immuables (§8).

**`zenodo`** (`release.yaml:118-196`).
- `contents: write` ne sert qu'au `push` vers `zenodo-state` (l. 195-196). **[I]** Évitable : l'identifiant de
  concept Zenodo est une donnée stable qui peut vivre dans le dépôt (revue par PR, p. ex. `zenodo.files.json` ou
  `CITATION.cff`) ; le job redescendrait alors à `contents: read`.
- **[FO]** L'état est lu depuis `zenodo-state` (l. 162-168), branche **non couverte** par le ruleset (F1, F2), puis
  `conceptrecid`/`recid` sont insérés tels quels dans des chemins d'URL appelés avec le jeton
  (`sync_zenodo.py:98-104,113-118`). **[I]** Un acteur qui écrit sur cette branche peut faire publier la release
  comme nouvelle version d'un **autre** dépôt Zenodo du mainteneur, ou, avec une valeur contenant `/`, `?` ou `#`,
  viser un autre point d'API de dépôt (toujours sur `zenodo.org`, toujours avec le jeton). Prérequis : droit
  d'écriture (T5).
- **[FO]** Aucun `environment:` : `ZENODO_TOKEN` est un secret de dépôt, lisible par **tout** workflow d'une ref où
  un porteur de droit d'écriture pousse un fichier de workflow. **[I]** Le jeton Zenodo vaut pour **tous** les
  dépôts du compte, et la publication est irréversible : c'est l'actif le plus mal défendu au regard de son impact.
- **[FO]** Jeton passé par `git -c http.extraheader=… bearer $GITHUB_TOKEN` (l. 195) : il apparaît dans la ligne de
  commande du processus (lisible via `/proc` par les autres processus du job). **[I]** Faible ; préférer
  `GIT_CONFIG_COUNT/KEY/VALUE` ou un *credential helper*. **[H]** Le schéma `bearer` n'a jamais été exercé en CI
  (F3) : son fonctionnement n'est pas démontré.
- **[I]** Ordre « publier puis sauver l'état » : si le `push` échoue après publication, la release suivante repart
  de `{}` et crée un **nouveau** concept DOI (risque d'intégrité de la citation, pas d'attaque).
- **[FO]** `ZENODO_ENV` est stocké comme secret alors que ce n'est pas un secret. **[I]** Une variable suffirait et
  rendrait la configuration lisible.

**Contrôles de release** (`release.yaml:27-50,60-83`). **[FO]** Ils comparent tag, `CITATION.cff`/`lakefile.lean`
et changelogs ; **aucun** ne vérifie que le commit tagué appartient à `main` ni qu'il a passé `CI OK`. **[FO]**
`spec-verify` n'appelle `verify.yaml` qu'avec `spec_build: true` : `controle.py` (job `quick`) n'est pas exécuté
à la release.

### 3.3 `ci.yaml:deploy-pages`

`pages: write` et `id-token: write` sont exactement ce qu'exige `actions/deploy-pages` (déploiement authentifié par
OIDC). Le job ne fait ni checkout ni build, ne s'exécute que sur `push` de `main` après `CI OK`
(`ci.yaml:120`), et cible l'environnement `github-pages`. **Justifié.** Reste à vérifier (`HUMAN ACTION REQUIRED`)
la politique de branches de déploiement de cet environnement (API refusée, F18).

### 3.4 `bump-lean.yaml`

- **[FO]** Le job détient `contents: write` + `pull-requests: write` (l. 22-24) **et** `BUMP_TOKEN` (l. 69, 81),
  puis exécute `lake update`, `lake exe cache get`, `lake build`, `lake test` (l. 58-64) sur la **nouvelle**
  version amont, et lean-action, qui exécute `elan-init.sh` depuis la branche `master` (F10).
- **[FO]** Aucune étape n'utilise le `GITHUB_TOKEN` en écriture : checkout sans persistance, lean-action n'a pas
  d'entrée `token`, create-pull-request reçoit `token: BUMP_TOKEN` et `branch-token` vaut `token` par défaut
  (`action.yml` de create-pull-request au SHA épinglé). **[I]** `contents: write` / `pull-requests: write` sont
  **superflus** ; à valider par un `workflow_dispatch` après réduction à `contents: read`.
- **[I]** Exposition du PAT : `BUMP_TOKEN` n'est placé dans l'environnement qu'aux l. 69 et 81, mais le code
  exécuté plus tôt dans le **même job** tourne sur le même runner ; les analyses publiques de l'incident
  tj-actions (mars 2025) montrent la lecture des secrets du job dans la mémoire du processus `Runner.Worker`
  (ESTIMÉ : dépend de la date de livraison des secrets au runner). Le code amont peut aussi modifier
  `lakefile.lean` / `lake-manifest.json` avant que la PR ne soit créée **sous l'identité du mainteneur**.
- **[FO]** Injection `${{ steps.version.outputs.latest }}` (l. 46) : valeur filtrée par
  `^v[0-9]+\.[0-9]+\.[0-9]+$` à la source (`latest-lean-version.sh:13`) puis revalidée (`bump-lean.sh:21`).
  **Non exploitable** ; la défense est cependant non locale (dans d'autres fichiers). Passer la valeur par `env:`
  la rendrait locale et lisible.
- **[I]** Valeur du PAT : il ne sert qu'à ce que la PR déclenche la CI. Un PAT `contents:write` +
  `pull-requests:write` permet, avec 0 approbation, d'ouvrir **et fusionner** une PR qui passe `CI OK`, puis de créer
  une release, donc de déclencher Zenodo. **[D]** Options, par ordre de préférence : (a) découper en un job
  non privilégié (calcul + build + test, diff en artefact) et un job court qui ne fait que créer la PR ;
  (b) supprimer le PAT : PR créée avec `GITHUB_TOKEN`, puis CI lancée par `workflow_dispatch` (événement autorisé
  pour ce jeton, nécessite `actions: write`) — **[H]** que le check `CI OK` d'un run `workflow_dispatch` sur le SHA
  de tête satisfasse le ruleset est probable mais non vérifié ; (c) à défaut, PAT fine-grained minimal à courte
  expiration (`HUMAN ACTION REQUIRED`).

### 3.5 Caches (`actions/cache`)

- **[FO]** `.lake/packages` (clé `lake-deps-<hash manifeste, toolchain>`, `verify.yaml:86-90,138-142`) et
  `~/.cache/Tectonic` (avec `restore-keys` préfixe, `verify.yaml:212-218`). `.lake/packages` contient les oléans
  compilés des dépendances.
- **[I]** PR → `main` : **non** (les caches d'une PR sont de portée `refs/pull/N/merge`). `main` → tag : **oui**
  (un run de tag peut restaurer les caches de la branche par défaut). Écrivent dans la portée `main` : les runs de
  `ci.yaml` (push) et `full.yaml` (quotidien), donc **toute** étape de ces runs, y compris les actions tierces de
  lint (lychee, reuse, commitlint, gitleaks, actionlint), qui reçoivent `ACTIONS_RUNTIME_TOKEN`.
- **[I]** Conséquence : du code exécuté une fois dans un run de `main` peut empoisonner ce que la release
  compile → PDF falsifié **avec attestation valide** et DOI. Aucun contrôle actuel. **[D]** Ne restaurer aucun
  cache dans les runs de release (entrée `use_cache` de `verify.yaml`, fausse pour `release.yaml`) ; coût :
  un build Verso complet à chaque release (Mathlib n'est pas importé par `Spec`).

### 3.6 `scorecard.yaml` et `security.yaml`

- Scorecard : `id-token: write` (publication du résultat via OIDC) et `security-events: write` (envoi SARIF) sont
  requis par `publish_results: true` et l'upload ; `read-all` en tête ne s'applique à aucun job (le job déclare
  ses permissions). **Justifié.** L'envoi du SARIF de Scorecard **n'est pas** une analyse SAST (§7).
- Security : actionlint et gitleaks en lecture seule. **[I]** gitleaks ne voit que l'historique de la PR ;
  l'exclusion de `archives/outillage-org/` est raisonnable (archive figée) mais un secret ajouté là échapperait au
  contrôle. actionlint n'est pas un auditeur de sécurité des workflows (pas de détection
  d'empoisonnement de cache ni de privilèges excessifs).

## 4. Surface d'exécution de code

| Zone | Constat | Statut |
|---|---|---|
| `src/` (106 lignes) | **[FO]** Aucun `IO`, `unsafe`, `@[extern]`, `implemented_by`, `run_cmd`, `#eval`, `initialize`, `IO.Process` (grep sur `src`, `tests`, `tools`) ; contenu : `Main.hello`, `K7pl.Arith`, compteur LTS (`K7pl.Semantics`) | N/A aujourd'hui |
| `tests/` | **[FO]** `MainTest.lean:21-29` : `IO.println` du pilote de test uniquement | N/A |
| `tools/` | **[FO]** `SpecMain.lean:13,20` : `manualMain` écrit HTML/TeX et copie `spec/figures` ; `SpecExt` rend en `IO` sans processus externe ; `SpecBib.lean` est généré par `biblio.py` avec échappement `\` et `"` (`lean_str`) | OK |
| `spec/` | **[FO]** Aucun `#eval`/`IO`/`run_cmd` (les occurrences de « extern » sont de la prose) | OK |
| `lakefile.lean` | **[I]** Code Lean exécuté par **toute** commande `lake` ; `supportInterpreter := true` (l. 98) pour `spec` | inhérent |
| Dépendances | **[I]** L'élaboration exécute tactiques, macros et `initialize` de Mathlib/CSLib/Verso ; MD4Lean compile du C (F16). Les oléans de `lake exe cache get` ne sont **pas** revérifiés par le noyau à l'import (ESTIMÉ, comportement documenté de Lean ; `lean4checker` existe pour cela) | inhérent |
| Python | **[FO]** `subprocess` en liste uniquement (`impact.py:44`, `org2md.py:63`, `convert.py:453`), pas de `shell=True`, pas de `pickle`/`yaml.load`/`eval` ; JSON seulement. Seul point : état Zenodo non validé (§3.2) | OK sauf §3.2 |
| Shell | **[FO]** Variables citées ; versions validées par regex ; `axiom-audit` vérifié par SHA ; `claude-session-start.sh:15-16` exécute `elan-init.sh` de `master` sans empreinte puis `lake exe cache get` (l. 25), donc le `lakefile.lean` du checkout | écart (§5 A9) |

**Réponse à `SECURITY.md:29-30`** (« défaut de l'implémentation du langage permettant d'exécuter du code ou
d'accéder à des ressources non prévues ») : **FUTURE**. Il n'existe ni analyseur, ni interpréteur, ni exécutable
prenant un programme k7pl en entrée. Le risque réel d'exécution de code est celui de la chaîne de construction,
déjà couvert par la ligne 31. La ligne 27-28 (cohérence, contournement de l'audit des axiomes) est, elle,
**applicable aujourd'hui** ; elle inclut un contournement par oléans de dépendance non revérifiés.

## 5. Chemins d'attaque concrets

| # | Chemin (étapes) | V | I | Contrôle qui l'arrête | Manque |
|---|---|---|---|---|---|
| A1 | 1. Hameçonnage / vol de session du mainteneur → 2. admin → 3. désactive le ruleset, lit les secrets, publie | F-M | C | 2FA (non vérifiée) | H-1, passkey |
| A2 | 1. Upstream (nouveau tag Mathlib/CSLib/Verso ou transitif, ou `elan` `master`) piégé → 2. exécuté par `bump` → 3. lit `BUMP_TOKEN` → 4. ouvre et fusionne une PR qui passe `CI OK` (0 approbation) → 5. crée `spec-v*` → 6. PDF attesté + DOI Zenodo | F | É | aucun spécifique (épinglage SHA de lean-action n'épingle pas `elan-init.sh`) | §3.4 (a)/(b), environnement `zenodo`, tag ruleset |
| A3 | 1. PR de fork modifiant `scripts/ci/impact.py` ou un workflow pour vider les contrôles → 2. `CI OK` vert (la CI de PR exécute le code de la PR) → 3. fusion par confiance | F | É | décision humaine | aucune revue tracée (F7) |
| A4 | 1. Texte piégé dans une issue, une PR, un commentaire, un fichier de `docs/` ou un journal CI → 2. lu par un agent → 3. l'agent pousse une branche, modifie `.github/workflows/` ou `.claude/**`, ouvre puis fusionne une PR (outil `merge_pull_request` disponible) | M | É | permissions Claude Code (mode non vérifié) ; `CI OK` (n'arrête pas) | restriction d'outils par rôle, interdiction de fusion par agent |
| A5 | 1. Agent piégé ou PR modifie `.claude/settings.json` / `scripts/claude-session-start.sh` / `.claude/agents/*.md` → 2. fusion (aucun contrôle CI, F13) → 3. exécution ou consignes persistantes dans **chaque** session future | F-M | É | relecture humaine | idem A4 |
| A6 | 1. Code exécuté dans un run de `main` (action de lint compromise après un bump Dependabot fusionné, ou dépendance) → 2. écrit une entrée de cache `lake-deps-*` / `tectonic-*` → 3. la release la restaure → 4. PDF falsifié signé par la vraie attestation | F | É | portée de cache (bloque PR → main seulement) | pas de cache en release |
| A7 | 1. Porteur d'un droit d'écriture (A1, A2, A4) pousse un commit hors `main` → 2. tague `spec-v*` dessus → 3. `release.yaml` **de ce commit** s'exécute avec `ZENODO_TOKEN` | F | É | aucun | tag ruleset, contrôle d'ascendance, environnement |
| A8 | 1. Écriture sur `zenodo-state` (non protégée) → 2. `conceptrecid` d'un autre dépôt du mainteneur ou valeur à `/`/`#` → 3. la release suivante publie au mauvais endroit, avec le jeton | F | M | aucun | validation numérique de l'état ; état dans le dépôt |
| A9 | 1. `leanprover/elan` `master` compromis → 2. exécuté par toute CI Lean (via lean-action) **et** par le hook de session des agents | F | É | aucun | installation versionnée + SHA-256 (modèle Tectonic) |
| A10 | 1. Oléans du cache Mathlib substitués → 2. déclaration fausse importée sans revérification noyau → 3. preuve k7pl « acceptée », `axiom-audit` muet | TF | M | aucun | `lean4checker` dans `full.yaml` (coût à évaluer) |
| A11 | (intégrité, sans attaquant) 1. prochain `spec-v*` → 2. `zenodo-state` absent → 3. `sync_zenodo.py` crée un **nouveau** concept, différent de `10.5281/zenodo.23040451` cité partout | É | M | aucun | décision humaine sur le DOI de concept avant la release |
| A12 | **[H]** Si l'intégration Zenodo–GitHub (webhook) est active : toute release publiée, y compris sur un commit non revu, est archivée hors CI | ? | M | aucun | vérifier et choisir un seul canal |
| A13 | PR de fork : minage, épuisement des minutes | M | F | approbation des premiers contributeurs (réglage non vérifié) | vérifier le réglage |

## 6. Revendications : Claim → Argument → Evidence

| Claim (source) | Argument | Evidence | Statut |
|---|---|---|---|
| « Le PDF est archivé sur Zenodo à chaque release `spec-vX.Y.Z` » (`README.md:40`, `CONTRIBUTING.md:79,92-93`) | le job `zenodo` publie après `publish-spec` | workflow présent ; **aucune** exécution réussie (F4), pas de `zenodo-state` (F3) | **FUTURE** (intention ≠ preuve) |
| « son PDF est joint à la release GitHub correspondante » (`README.md:67-68`) | `gh release upload` | release unique sans asset (F4) | **FUTURE** / faux aujourd'hui |
| Provenance du PDF (`.github/workflows/README.md:108-110`) | `actions/attest` sur le PDF | aucune attestation produite (F4) ; même produite, elle lie l'artefact au **workflow et au commit**, pas à une revue ni à `main` | **FUTURE** ; portée à préciser |
| « Le token du job est injecté uniquement lors du push vers `zenodo-state` » (`.github/workflows/README.md:125`) | `GITHUB_TOKEN` en `env` de la seule étape l. 176-196 | vrai pour l'environnement ; faux pour le privilège : `contents: write` vaut pour tout le job | **PARTIAL** |
| « Toute modification de l'infrastructure CI ou des dépendances critiques déclenche une vérification complète » (`.github/workflows/README.md:141`) | `impact.py` `FULL_EXACT`/`FULL_PREFIXES` | F12 : vrai via `impact.py` ; le `grep` de `ci.yaml:57` est inopérant ; `.claude/settings.json` n'est pas considéré comme critique | **PARTIAL** |
| « Les artefacts de spécification sont toujours dérivés d'une validation réussie » (`.github/workflows/README.md:140`) | `needs:` | à la release, `controle.py` n'est pas exécuté (§3.2) ; caches de `main` restaurés | **PARTIAL** |
| « Fusion par rebase (… chaque commit ayant déjà été vérifié) » (`CONTRIBUTING.md:35`) | CI sur la PR | la CI vérifie la tête fusionnée, pas chaque commit ; `strict_required_status_checks_policy: false` (F1) | **PARTIAL** |
| « créer la release sur `main` » (`CONTRIBUTING.md:90,105`) | procédure | aucun contrôle technique (F2, §3.2) | consigne, non garantie |
| « Seuls `propext`, `Classical.choice`, `Quot.sound` … la CI le vérifie » (`CONTRIBUTING.md:62-63`) | `axiom-audit` sur `K7pl` et `Spec` | `verify.yaml:114-116,147-148`, outil vérifié par SHA ; runs `CI` récents en succès ; **non exécuté ici** ; limite A10 | **PARTIAL** (VERIFIED pour la configuration, pas pour l'exécution) |
| « Premier retour sous 7 jours » (`SECURITY.md:19`) | engagement | aucune donnée de signalement | politique, pas une preuve |
| Périmètre « exécuter du code » (`SECURITY.md:29-30`) | — | §4 | **FUTURE** (sans objet aujourd'hui) |
| « k7pl n'a pas encore de version publiée » (`SECURITY.md:10`) | — | une release `spec-v0.0.0-alpha.1` existe (spécification, pas implémentation) | à préciser |
| Badge « Lean Build » (`README.md:8`) | — | pointe vers `lean.yaml`, supprimé : signal périmé | faux signal |
| Badge Scorecard (`README.md:10`) | — | score non lisible d'ici (F18) | `HUMAN ACTION REQUIRED` (relire) |

## 7. SAST : valeur réelle

- **Lean 4** : aucun outil SAST n'existe ; le rôle d'analyse statique est tenu par le noyau, `warningAsError`,
  `lake lint` et `axiom-audit`. Aucun outil à ajouter ; ne **jamais** présenter un SAST Python/YAML comme couvrant
  le langage.
- **Python** (scripts de maintenance, 3 941 lignes au total d'après `wc -l`, un seul script avec secret et réseau) : CodeQL Python
  trouverait peu (pas de désérialisation, pas de shell) ; le seul défaut réel (§3.2, état Zenodo) est un défaut de
  validation métier qu'un SAST générique ne signale pas. Valeur **faible**.
- **YAML GitHub Actions** : c'est **la** surface réelle (§3, §5). Un auditeur dédié (zizmor : injection de
  modèle, privilèges excessifs, empoisonnement de cache, `curl | sh`, commits imposteurs) apporte une valeur
  **réelle et continue**, surtout parce que des agents écrivent les workflows. CodeQL `actions` recouvre une
  partie de ces règles ; valeur **moyenne**, coût faible en *default setup* (réglage administrateur, triage dans
  l'onglet Security par un seul mainteneur).
- **Shell** : actionlint passe shellcheck sur les `run:` (ESTIMÉ : shellcheck présent sur `ubuntu-latest`) ; les 5
  scripts de `scripts/*.sh` ne sont pas analysés. Valeur faible, coût quasi nul.
- **[D]** Recommandation : zizmor (épinglé et vérifié, hors ligne) dans `security.yaml` comme SAST des workflows ;
  CodeQL *default setup* optionnel (décision humaine) ; shellcheck sur `scripts/*.sh` si peu coûteux. Le SARIF de
  Scorecard **n'est pas** un SAST.

## 8. Contrôles qui produiraient un faux signal si on les « corrigeait » à l'aveugle

1. **Approbations requises ≥ 1** avec un seul humain : impossible sans un second compte ; créer ce compte pour
   s'auto-approuver = revue fabriquée (interdit).
2. **CODEOWNERS** désignant le seul mainteneur, sans approbation requise : aucun effet ; décoratif.
3. **Commits signés obligatoires** : les commits faits par l'API/le web (agents) seraient signés par la clé de
   GitHub (« Verified ») ; ce badge n'atteste ni l'auteur humain ni une revue.
4. **Releases immuables** activées sans refonte : `publish-spec` attache le PDF **après** publication
   (`release.yaml:116`) ; soit le job casse, soit on désactive à nouveau. Il faut d'abord passer à « brouillon →
   assets → publication ».
5. **« Corriger » le `grep` de `ci.yaml:57`** : ne change rien (F12) ; le supprimer (source unique : `impact.py`)
   est plus honnête qu'une double défense apparente.
6. **Attestation présentée comme « release signée » ou « source revue »** : elle lie le PDF au workflow et au
   commit ; `gh attestation verify` sans `--signer-workflow`/`--source-ref` ni contrôle d'ascendance ne prouve pas
   que le contenu vient de `main`.
7. **Ajouter CodeQL « pour le point SAST »** en laissant croire que le langage est analysé.
8. **Épingler l'URL de `elan-init.sh` sur un SHA sans vérifier d'empreinte** pour satisfaire un contrôle
   « Pinned-Dependencies » : l'intégrité vient de l'empreinte, pas de l'URL.
9. **Harnais de fuzzing** : il n'y a pas d'analyseur à fuzzer ; décoratif tant que `src/` n'en contient pas.
10. **`SECURITY-REVIEW.md` sans revue réelle** : ce rapport est une revue d'agent, non validée par un humain ;
    l'écrire comme « revue de sécurité » serait une revue fabriquée.
11. **`dismiss_stale_reviews` / `require_last_push_approval`** : sans objet avec 0 approbation.
12. **`persist-credentials: false` cité comme « aucun jeton exposé »** : le jeton reste en mémoire du runner.

## 9. Documents d'assurance : réel ou décoratif

| Document | Pratique réelle correspondante ? | Avis |
|---|---|---|
| `THREAT-MODEL.md` | **Oui**, si on s'en sert pour justifier chaque privilège de workflow et qu'on le relit à chaque PR touchant `.github/workflows/`, `scripts/ci/`, `.claude/settings.json` | **Utile** : à dériver du §2 et §5, court, daté |
| `ASSURANCE-CASE.md` | **Oui, partiellement** : registre des revendications publiques (§6) avec leur statut ; c'est aussi la forme honnête du critère `assurance_case` de CII (Silver, ESTIMÉ) | **Utile** si fusionné avec le modèle de menace ou réduit au registre ; la plupart des claims sont aujourd'hui FUTURE et doivent le rester écrits ainsi |
| `SECURITY-MODEL.md` | Non : doublon du modèle de menace (§2.3-2.6) et de `.github/workflows/README.md` | **Décoratif** → fusionner dans `THREAT-MODEL.md` |
| `SECURITY-REVIEW.md` | Seulement comme **journal daté** de revues effectivement faites (qui, quoi, quand, validé ou non par un humain) | **Décoratif** sous forme de document de synthèse ; les `AUDIT.md` de vague 1 tiennent déjà lieu de trace |

**[D]** Proposition : un seul `docs/security/THREAT-MODEL.md` (actifs, acteurs, frontières, contrôles, risques
résiduels, justification des privilèges) + un `docs/security/ASSURANCE-CASE.md` court (registre CAE), ou les
deux fusionnés. Décision à l'orchestrateur, en coordination avec `cii-specialist` (même liste de fichiers dans
sa définition).

## 10. Écarts et priorités proposées

**P0** (exploitable sans identifiant, impact élevé) : **aucun constaté.**

**P1** (impact élevé, chemin réaliste, correctif borné)
1. Environnement `zenodo` : secrets déplacés du dépôt vers l'environnement, politique de déploiement limitée aux
   tags `spec-v*`, relecteur requis (auto-approbation autorisée) → seul second facteur réel contre A2/A4/A7
   (workflow + action humaine).
2. `bump-lean` : retirer `contents: write`/`pull-requests: write` inutilisés ; séparer build non privilégié et
   création de PR, ou supprimer le PAT (§3.4) ; vérifier la portée et l'expiration de `BUMP_TOKEN`.
3. Release sans cache Actions (`verify.yaml` + `release.yaml`) ; contrôle « commit tagué ancêtre de `origin/main` »
   dans `*-release-check`.
4. Ruleset de tags `v*` et `spec-v*` (mise à jour et suppression interdites).
5. Décider du DOI de concept **avant** le prochain `spec-v*` (A11) et du canal Zenodo unique (A12).
6. Agents : interdire la fusion de PR et l'écriture directe sur `main` par les agents (permissions `deny` dans la
   configuration Claude Code), restreindre `tools:` des rôles « lecture » ; vérifier que les en-têtes YAML des
   agents sont bien lus (F14, **[H]** : un en-tête qui ne commence pas le fichier peut être ignoré, ce qui
   annulerait `model`/`effort`/`isolation`).

**P2**
7. `sync_zenodo.py` : valider `conceptrecid`/`recid` comme entiers ; à terme, état dans le dépôt et job en
   `contents: read`.
8. elan et toolchain installés par version + SHA-256 (CI hors lean-action, et hook de session).
9. zizmor dans `security.yaml`.
10. Corriger les revendications de §6 (README, CONTRIBUTING, workflows/README, SECURITY.md) pour qu'elles disent
    FUTURE / PARTIAL ce qui l'est.

**P3**
11. Retirer `artifact-metadata: write`. 12. Jeton Zenodo-state hors ligne de commande. 13. Supprimer le `grep` mort
de `ci.yaml:57`. 14. `ZENODO_ENV` en variable. 15. `strict_required_status_checks_policy: true`. 16. `lean4checker`
dans `full.yaml` (coût à mesurer). 17. Badge `lean.yaml` périmé.

## 11. Actions humaines (procédure et vérification)

| # | Procédure | Vérification |
|---|---|---|
| H1 | GitHub → Settings → Password and authentication : 2FA active, de préférence clé de sécurité / passkey ; idem Zenodo si proposé | `gh api user --jq .two_factor_authentication` (authentifié) = `true` |
| H2 | Settings → Developer settings → tokens : identifier `BUMP_TOKEN`. Si classique : révoquer ; sinon fine-grained, dépôt k7pl seul, *Contents* RW, *Pull requests* RW, *Metadata* R, **pas** *Workflows*, expiration ≤ 90 j ; mettre à jour le secret | page du jeton (portée affichée) ; date de mise à jour du secret |
| H3 | Après la vague 2 : Settings → Environments → `zenodo` → *Deployment branches and tags* : tags `spec-v*` ; *Required reviewers* : AntheaLiles (ne **pas** cocher *Prevent self-review*) ; y créer `ZENODO_TOKEN` (+ `ZENODO_ENV` en variable) ; supprimer les secrets de dépôt correspondants | `gh api repos/AntheaLiles/k7pl/environments/zenodo` (authentifié) ; liste des secrets de dépôt |
| H4 | Settings → Environments → `github-pages` : déploiement limité à `main` | même API |
| H5 | Settings → Rules → New tag ruleset : cibles `v*`, `spec-v*` ; *Restrict updates*, *Restrict deletions* ; actif | `gh api repos/AntheaLiles/k7pl/rulesets` montre `target: tag` |
| H6 | Settings → Actions → General : approbation requise pour les workflows des contributeurs externes ; permissions par défaut « Read » ; « Allow GitHub Actions to create and approve pull requests » désactivé | `gh api repos/AntheaLiles/k7pl/actions/permissions/workflow` (authentifié) |
| H7 | Settings → Webhooks et zenodo.org → onglet GitHub : l'intégration Zenodo est-elle active pour k7pl ? Ouvrir le dépôt 10.5281/zenodo.23040451 : type, fichiers (archive source ou PDF) | capture des deux écrans ; métadonnées du dépôt |
| H8 | Avant le prochain `spec-v*` : fixer le concept DOI à prolonger (créer `zenodo-state` à la main ou, après vague 2, l'inscrire dans le dépôt) ; tester d'abord avec `ZENODO_ENV=sandbox` | run de release sandbox réussi, DOI de concept inchangé |
| H9 | Settings → Code security : *Secret scanning* et *Push protection* actifs | page de réglages (l'API anonyme renvoie `security_and_analysis: null`) |
| H10 | Claude Code : vérifier le mode de permission des sessions et la liste `/agents` (les 14 agents apparaissent-ils avec leur modèle ?) | sortie de `/agents` |
| H11 | Relire le score Scorecard et l'état du badge CII 15239 | NON VÉRIFIABLE DEPUIS CETTE SESSION |

## 12. Fichiers visés en vague 2 (pour éviter les collisions)

- Nouveaux : `docs/security/THREAT-MODEL.md`, `docs/security/ASSURANCE-CASE.md` (collision possible avec
  `cii-specialist`).
- `.github/workflows/release.yaml` (environnement, ascendance, pas de cache, `artifact-metadata`, jeton),
  `.github/workflows/verify.yaml` (entrée `use_cache`), `.github/workflows/bump-lean.yaml` (permissions, découpage),
  `.github/workflows/security.yaml` (zizmor), `.github/workflows/ci.yaml` (grep mort) — collisions probables avec
  `supply-chain-release-specialist`, `scorecard-specialist`, `quality-reproducibility-specialist`.
- `scripts/sync_zenodo.py` (validation de l'état), `scripts/claude-session-start.sh` (elan épinglé).
- `.claude/settings.json` (permissions `deny`), `.claude/agents/*.md` (`tools:` ; place de l'en-tête SPDX, avec
  annotation `REUSE.toml` si l'en-tête doit sortir du fichier) — décision de l'orchestrateur.
- `SECURITY.md`, `README.md`, `CONTRIBUTING.md`, `.github/workflows/README.md` (revendications) — collision avec
  `github-governance-specialist` / `cii-specialist`.

## 13. Frontière `spec/` / `src/` / sémantique

Aucun écart ne demande de modifier `spec/` ni `src/`. Deux points à **signaler** seulement : (1) le périmètre de
`SECURITY.md` sur l'exécution de code deviendra applicable quand `src/` contiendra un analyseur ou un
interpréteur : il faudra alors un modèle de menace du langage (entrées non fiables, effets `Import`, ressources
externes évoquées par `spec/Spec/C6/LeProcessusDeCompilation.lean:61-63`) ; (2) l'assurance « propriété prouvée »
dépend d'oléans Mathlib non revérifiés (A10), ce qui touche la séparation épistémique « prouvé » du projet.

## 14. Non vérifié, et pourquoi

- Score Scorecard, badge CII : domaines refusés par le proxy (F18) → `HUMAN ACTION REQUIRED`.
- Acteurs de contournement réels des rulesets, environnements, réglages Actions, portée des secrets, 2FA,
  webhooks, caches existants, releases immuables, secret scanning : API refusées ou réservées à l'administrateur.
- Dépôt Zenodo 23040451 : `zenodo.org` refusé.
- Fonctionnement réel de `http.extraheader … bearer`, effet du retrait de `artifact-metadata`, satisfaction du
  ruleset par un run `workflow_dispatch` : jamais exercés ; seule une release de test le montrera.
- Lecture des secrets dans la mémoire du runner, absence de revérification noyau des oléans, intégrité du bundle
  Tectonic, comportement de Lake avec un paquet mis en cache modifié : ESTIMÉ (documentation et incidents publics,
  non reproduits).
- Interprétation des en-têtes YAML d'agents précédés d'un commentaire : hypothèse, non testée.
- Aucun `lake build`/`lake test`/`lake lint` exécuté (pas de toolchain) ; l'état « CI verte » repose sur l'API
  publique des runs (`CI` sur `b5f6146` : `success`).
