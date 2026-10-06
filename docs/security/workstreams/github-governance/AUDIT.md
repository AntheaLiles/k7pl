<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit de la gouvernance GitHub — vague 1

- **Agent** : `github-governance-specialist` (rôle d'assurance, lecture seule sur le dépôt et sur GitHub).
- **Date** : 2026-10-05/06. **Référence** : `origin/main` = `b5f6146` (69 commits).
- **Worktree** : `.claude/worktrees/agent-aecd6b765486cba34`, branche `worktree-agent-aecd6b765486cba34`.
- **Périmètre** : protection de `main`, checks requis, revues, CODEOWNERS, bypass, méthodes de fusion,
  tags et releases, déclencheurs et permissions des workflows, secrets et environnements, branche
  `zenodo-state`, cohérence avec `CONTRIBUTING.md`, `SECURITY.md`, `README.md`, Scorecard et CII.
- **Hors périmètre** : `spec/`, `src/`, `tests/` (aucune proposition ne les touche, voir § 11).
- **Nature du document** : rapport d'audit, non normatif. Aucune configuration GitHub n'a été
  modifiée ; aucun fichier hors de ce rapport n'a été écrit.

Conventions : **[F]** fait observé (avec sa preuve) · **[I]** interprétation · **[H]** hypothèse ·
**[D]** décision à prendre par la mainteneuse · **[A]** action restante. Statuts : `VERIFIED` ·
`PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE` · `N/A`. « ESTIMÉ » marque
une évaluation non vérifiable depuis cette session.

## 1. Synthèse

1. [F] `main` est protégée par un **ruleset** unique (« PR on main », id 24138119), actif, **sans
   bypass** : PR obligatoire, suppression et force-push interdits, historique linéaire, un seul check
   requis `CI OK` lié à l'application GitHub Actions (id 15368). Ce socle est sain et applicable
   à l'administratrice elle-même.
2. [F] **0 approbation requise** et **0 revue** sur les 13 PR (11 fusionnées par leur propre autrice,
   AntheaLiles ; 1 PR Dependabot fusionnée sans revue). Il n'existe **aucune pratique de revue par un
   second humain** : la configuration ne le cache pas, mais rien dans `CONTRIBUTING.md` ne le dit.
3. [F] **Releases immuables** : la seule release (`spec-v0.0.0-alpha.1`) porte `immutable: true`.
   Or `release.yaml` joint le PDF **après** publication (`gh release upload … --clobber`), ce que
   GitHub refuse sur une release immuable. [I] Le pipeline de publication de la spécification
   (PDF + Zenodo) est donc, en l'état, **voué à l'échec** dès la prochaine release `spec-v*` si
   l'immutabilité est toujours active. C'est l'écart le plus grave du domaine.
4. [F] Les secrets `ZENODO_TOKEN`, `ZENODO_ENV` et `BUMP_TOKEN` sont utilisés **sans environnement**
   GitHub. [I] Toute personne ou tout jeton capable de pousser une branche (y compris une session
   d'agent disposant du droit `push`) peut les exfiltrer par une PR interne qui modifie un workflow,
   sans rien fusionner.
5. [F] Aucun ruleset ne vise les **tags** ni la branche **`zenodo-state`** (qui n'existe pas encore).
6. [F] Incohérences de fusion : le dépôt autorise merge + rebase (squash désactivé), le ruleset liste
   merge/rebase/squash, l'historique linéaire interdit le merge ; seul le **rebase** est effectif.
7. [I] En mono-mainteneur, `required_approving_review_count: 1` rendrait **toutes** les PR de la
   mainteneuse (et des agents agissant sous son compte) **non fusionnables** ; le seul moyen de fusionner
   serait un bypass, c'est-à-dire un contournement systématique. À ne pas faire (§ 4.2).

## 2. Méthode et sources

Commandes exécutées dans cette session (lectures uniquement) :

- `unset GH_TOKEN; gh api repos/AntheaLiles/k7pl/rulesets/24138119` (et `rulesets`,
  `rulesets?targets=tag`, `rules/branches/main`, `rules/branches/zenodo-state`).
- `gh api repos/AntheaLiles/k7pl` (paramètres de fusion), `…/branches`, `…/tags`, `…/releases`,
  `…/git/refs/tags/spec-v0.0.0-alpha.1`, `…/commits/<sha>`, `…/pulls?state=all`,
  `…/pulls/<n>/reviews`, `…/pulls/<n>/commits`, `…/issues/<n>/events`, `…/contributors`,
  `…/commits/<sha>/check-runs`, `…/private-vulnerability-reporting`, `…/community/profile`.
- Outils MCP GitHub : `list_repository_collaborators`, `actions_list` (workflows, runs).
- `git log origin/main --format='%an <%ae> | %cn <%ce> | %G?'`, `git log --merges`, `git log -S'CI OK'`.
- Test local du motif `grep -Eq` de `ci.yaml:57` (script Python lisant le YAML).
- Lecture intégrale des 9 workflows, de `.github/workflows/README.md`, `dependabot.yml`, du modèle de
  PR, de `scripts/ci/impact.py`, `CONTRIBUTING.md`, `SECURITY.md`, `README.md`.
- Documentation de référence téléchargée (dépôts publics, `raw.githubusercontent.com`) :
  `ossf/scorecard` `docs/checks.md` ; `coreinfrastructure/best-practices-badge`
  `criteria/criteria.yml` et `config/locales/en.yml` ; `github/docs` (pages « about protected
  branches », « immutable releases », « managing releases », fragments réutilisables) ;
  `github/rest-api-description` (OpenAPI).

Limites d'accès (voir § 12) : le proxy de la session refuse `actions/permissions*`, `environments`,
`hooks`, `collaborators` (REST), et l'intégration reçoit 403 sur `branches/main/protection`,
l'historique du ruleset, les « rule suites » et `immutable-releases`. `docs.github.com`,
`api.securityscorecards.dev` et `www.bestpractices.dev` sont inaccessibles.

[F] Les appels `gh api` passent par une **intégration GitHub authentifiée** (réponse « Resource not
accessible by integration » sur certains chemins ; `permissions.admin: true` sur le dépôt). Selon
l'OpenAPI GitHub, `bypass_actors` n'est renvoyé qu'à un appelant ayant un accès en écriture au
ruleset : le champ étant renvoyé (`[]`), la valeur est significative — à confirmer dans l'interface.

## 3. Faits observés

### 3.1 Dépôt et accès

- [F] Dépôt public d'un compte personnel (`owner.type = User`, id 120063455). Un seul collaborateur :
  `AntheaLiles`, rôle `admin` (MCP `list_repository_collaborators`).
- [F] Paramètres : `allow_merge_commit: true`, `allow_squash_merge: false`, `allow_rebase_merge: true`,
  `allow_auto_merge: false`, `delete_branch_on_merge: false`, `allow_update_branch: false`,
  `web_commit_signoff_required: false`, `has_discussions: true`, `has_wiki: false`
  (`gh api repos/AntheaLiles/k7pl`).
- [F] Branches : `main` (protégée) et `claude/lean4-reuse-init-qvzlcg` (réutilisée par les PR #1 à #6
  et #10, encore ouverte). Pas de `zenodo-state`.
- [F] Contributeurs selon GitHub : `AntheaLiles` (41), **`claude` (38, type `User`)**,
  `dependabot[bot]` (1) (`gh api …/contributors?anon=1`). Les commits signés
  `Claude <noreply@anthropic.com>` sont rattachés par GitHub à un compte `claude`.
- [F] Signalement privé de vulnérabilités activé (`…/private-vulnerability-reporting` → `enabled: true`).

### 3.2 Ruleset « PR on main » (id 24138119)

[F] Lecture complète (`gh api repos/AntheaLiles/k7pl/rulesets/24138119`) :

| Paramètre | Valeur |
|---|---|
| `enforcement` / cible | `active` / `~DEFAULT_BRANCH` |
| `bypass_actors` | `[]` |
| `deletion`, `non_fast_forward`, `required_linear_history` | présents |
| `pull_request.required_approving_review_count` | `0` |
| `dismiss_stale_reviews_on_push` | `false` |
| `require_code_owner_review` | `false` |
| `require_last_push_approval` | `false` |
| `required_review_thread_resolution` | `false` |
| `require_extra_approval_for_unattributed_changes` | `true` (paramètre absent de l'OpenAPI publique : sémantique non vérifiée) |
| `allowed_merge_methods` | `merge`, `rebase`, `squash` |
| `required_status_checks` | **un seul** : `CI OK`, `integration_id: 15368` (GitHub Actions) |
| `strict_required_status_checks_policy` | `false` |
| `do_not_enforce_on_create` | `false` |
| créé / modifié | 2026-09-28T19:53 / 2026-10-05T15:15:04 |

- [F] `rules/branches/main` renvoie exactement ces règles et aucune autre source. Aucun autre
  ruleset (`gh api …/rulesets`) ; aucun ruleset de tag (`rulesets?targets=tag` → `[]`). L'ancienne API
  de protection des tags (`tags/protection`) répond 404.
- [F] La protection de branche « classique » n'est pas lisible (`branches/main/protection` → 403).
- [F] Le ruleset a été modifié à 15:15:04, quatorze secondes avant la fusion de la PR #7 (15:15:18),
  qui introduisait le job `CI OK` (`git log -S'CI OK'` → `3563d1d`). [I] Cohérent avec un
  remplacement du check requis au moment de la fusion. Historique du ruleset non lisible (403).

### 3.3 Checks requis et jobs réels

- [F] Check runs sur la tête de la PR #13 (`f7ee13a`) et sur `main` (`b5f6146`) : `CI OK`,
  `Analyse d'impact`, `Vérification / Contrôles rapides`, `Vérification / Implémentation Lean`,
  `Vérification / Spécification Verso`, `Vérification / PDF de la spécification`,
  `Vérification / Résultat de la vérification`, `REUSE / reuse-compliance-check`,
  `Security / actionlint`, `Security / gitleaks`, `Conventional Commits / commitlint`,
  `Publication GitHub Pages` (sauté en PR) ; tous émis par l'app 15368.
- [F] Le nom requis `CI OK` correspond au job `ci-ok` (`ci.yaml:87-116`) : `if: always()`, dépend de
  `impact`, `verify`, `reuse`, `commitlint`, `security`, et échoue si l'un d'eux n'est pas `success`.
- [F] `verify.yaml:235-256` (job « Résultat de la vérification ») accepte `success|skipped` pour les
  jobs internes sautés par l'analyse d'impact ; un échec ou une annulation fait échouer `verify`.
- [F] Documentation GitHub (`github/docs`, `about-protected-branches.md:95` et fragment
  `skipped-job-status-checks-passing.md`) : un check requis est satisfait par `successful`, `skipped`
  ou `neutral` ; « A job that is skipped will report its status as "Success" ».
- [F] `ci.yaml` n'a pas de filtre `paths` : `CI OK` est produit pour toute PR. Un `ci.yaml` invalide
  ne produit pas de `CI OK` → la PR reste bloquée (« Expected »).
- [F] `ci.yaml:57` : le motif `grep -Eq` contient `\\.` dans un bloc littéral YAML ; grep reçoit
  `\\.` (antislash littéral + un caractère quelconque). Test local : **ne correspondent pas**
  `.github/dependabot.yml`, `lakefile.lean`, `lake-manifest.json`, `scripts/sync_zenodo.py`,
  `scripts/requirements-zenodo.txt` ; correspondent `lean-toolchain`, `.github/workflows/…`,
  `scripts/ci/…`. [F] `scripts/ci/impact.py:14-22` classe déjà ces chemins en « full »
  (`FULL_EXACT`). [I] Défense redondante partiellement inopérante, sans effet aujourd'hui.

### 3.4 Pratique des PR

- [F] 13 PR : 11 fusionnées par `AntheaLiles` qui en est l'autrice, 1 PR Dependabot (#9) fusionnée par
  `AntheaLiles`, 1 PR Dependabot fermée (#8), 1 PR ouverte (#10). **0 revue** sur toutes
  (`…/pulls/<n>/reviews` → `[]`), 0 commentaire de revue.
- [F] Événements `merged` sans `performed_via_github_app` (`…/issues/<n>/events`). [I] Compatible avec
  des fusions faites par la personne elle-même ; ne le prouve pas (un jeton personnel donnerait la
  même trace).
- [F] Sur `main` : 0 commit de fusion ; auteurs : `Claude <noreply@anthropic.com>` 27,
  `Claude <120063455+AntheaLiles@…>` 22, `Cyprien PIERRE` 19, `dependabot[bot]` 1 ; committer :
  `Cyprien PIERRE` pour les 69 (effet de la fusion par rebase).
- [F] PR #11, fusionnée à 18:57 après la dernière modification du ruleset, ne contient que des
  commits attribués à `claude` : `require_extra_approval_for_unattributed_changes` ne l'a pas bloquée.

### 3.5 Signatures, tags, releases

- [F] 69/69 commits de `main` non signés (`%G?` = `N` ; API : `verification.reason = unsigned` sur
  `b5f6146` et `dcd65a9`). Le commit Dependabot, signé à l'origine par GitHub, a perdu sa signature
  lors du rebase (committer réécrit).
- [F] Un seul tag, `spec-v0.0.0-alpha.1` → `dcd65a9`, **léger** (`object.type = commit`) : il ne peut
  pas porter de signature. Aucun tag `v*`.
- [F] Une seule release, `spec-v0.0.0-alpha.1` : publiée par `AntheaLiles` le 2026-09-29, `target =
  main`, `prerelease: false`, **aucun asset**, **`immutable: true`**.
- [F] Le seul run déclenché par `release` est « Lean Build » (`lean.yaml`, supprimé depuis), en
  **échec** (run 36569899593). L'actuel `release.yaml` n'a jamais tourné (workflow enregistré le
  2026-10-06 à 00:56).
- [F] `github/docs` (`managing-releases-in-a-repository.md:84`) : avec les releases immuables, « you
  cannot add, replace, or delete assets after a release is published, and you cannot move or delete
  its tag while the release exists » ; la page « Immutable releases » recommande brouillon → assets →
  publication, et indique qu'un nom de tag d'une release immuable supprimée ne peut pas être réutilisé.
- [F] `release.yaml:113-116` : `gh release upload "$TAG" … --clobber` après l'événement
  `release: published` ; `release.yaml:121` : le job `zenodo` dépend de `publish-spec`.

### 3.6 Workflows : déclencheurs, permissions, secrets

- [F] Déclencheurs : `pull_request`, `push` sur `main`, `workflow_dispatch`, `schedule`, `release:
  published`, `workflow_call`, `branch_protection_rule` (Scorecard). **Aucun** `pull_request_target`,
  `workflow_run`, `issue_comment`, `repository_dispatch` (grep sur `.github/workflows/`).
- [F] Les 9 workflows déclarent `permissions` au niveau racine (`contents: read`, ou `read-all` pour
  `scorecard.yaml:16`). Élévations par job : `deploy-pages` (`pages`, `id-token`), `publish-spec`
  (`contents`, `id-token`, `attestations`, `artifact-metadata` en écriture), `zenodo`
  (`contents: write`), `bump` (`contents`, `pull-requests` en écriture), Scorecard
  (`security-events`, `id-token`).
- [F] Secrets : `ZENODO_TOKEN`, `ZENODO_ENV` (`release.yaml:170-174`), `BUMP_TOKEN`
  (`bump-lean.yaml:66-81`), `GITHUB_TOKEN`. Seul `deploy-pages` déclare un `environment`
  (`github-pages`, `ci.yaml:127-129`). Le job `zenodo` n'en déclare pas.
- [F] `release.yaml` ne vérifie pas que le commit du tag appartient à `main`.
- [F] `scorecard.yaml:31-36` n'utilise pas de `repo_token` : Scorecard tourne avec le jeton par défaut.

### 3.7 Branche d'état `zenodo-state`

- [F] Écrite par `release.yaml:176-196` (création orpheline si absente, puis commits en avance rapide,
  push avec `GITHUB_TOKEN` en en-tête HTTP). Elle **n'existe pas** (liste des branches) et
  `rules/branches/zenodo-state` → `[]` : aucune règle ne s'y appliquerait.
- [F] `release.yaml:162-168` lit `.zenodo_state.json` depuis cette branche avant de publier.
  [I] Qui peut réécrire cette branche peut orienter la publication Zenodo suivante (dépôt ou
  version visés).

## 4. Question centrale : revue de code en mono-mainteneur

### 4.1 Ce que « 0 reviewer requis » signifie

- [I] La règle `pull_request` avec 0 approbation garantit que tout changement passe par une PR et
  par `CI OK`. Elle **ne garantit aucun regard humain** : une PR peut être fusionnée par son autrice
  dès que `CI OK` est vert.
- [I] L'oracle du check requis est **défini par la PR elle-même** : pour l'événement `pull_request`,
  GitHub exécute la version de `ci.yaml` (et de `impact.py`) contenue dans la PR. Une PR qui remplace
  `ci-ok` par une étape triviale, ou lui donne une condition fausse (job sauté = succès), obtient un
  `CI OK` vert. Sans second humain, le seul garde-fou est la lecture du diff par la personne qui
  fusionne. Les vérifications post-fusion (`push` sur `main`, `full.yaml` quotidien) tournent avec la
  version déjà fusionnée des workflows.
- [I] Les agents (sessions Claude) poussent des branches et ouvrent des PR **sous l'identité de la
  mainteneuse**. La configuration actuelle n'empêche pas une fusion par API par un jeton disposant des
  droits d'écriture : l'humain dans la boucle relève de la pratique, pas de la configuration.
- [I] Les commits rédigés par un agent et fusionnés par la mainteneuse **ne constituent pas une
  revue à deux personnes** : l'agent est un outil piloté par la même personne. Que GitHub attribue ces
  commits au compte `claude` ne change rien à ce constat.

### 4.2 Effet de `required_approving_review_count: 1` avec un seul humain

[F] GitHub ne compte que les approbations de personnes ayant le droit d'écriture
(`about-protected-branches.md:68`). [ESTIMÉ, comportement connu non re-testé ici] L'autrice d'une
PR ne peut pas l'approuver.

| Origine de la PR | Mergeable avec 1 approbation requise ? |
|---|---|
| PR ouverte par `AntheaLiles` (toutes les PR humaines et d'agents à ce jour) | **Non**, jamais : aucune autre personne n'a le droit d'écriture |
| PR Dependabot (`dependabot[bot]`) | Oui : la mainteneuse peut l'approuver |
| PR `bump-lean` via `BUMP_TOKEN` | Non si `BUMP_TOKEN` est un PAT de la mainteneuse ; oui si c'est une GitHub App (type inconnu) |
| PR d'un contributeur externe (fork) | Oui : approbation réelle de la mainteneuse |

- [I] Conséquence : `main` deviendrait **non fusionnable** pour le flux de travail courant. La seule
  issue serait d'ajouter l'administratrice en bypass et de fusionner en contournant la règle à chaque
  PR. Ce serait un **contournement déclaré et systématique**, pas une revue. [ESTIMÉ] Scorecard verrait
  « ≥ 1 reviewer » (palier 2 partiellement crédité) tout en considérant `EnforceAdmins = false` dès
  qu'un bypass est défini : signal de score amélioré **sans** amélioration de sécurité. **À ne pas
  faire.**
- [D] Une variante honnête existe, si la mainteneuse le décide : faire ouvrir les PR des agents par
  une identité distincte (GitHub App, auteur `…[bot]`), la mainteneuse devenant l'approbatrice. Ce
  serait une **revue humaine réelle de changements produits par une machine**, utile contre les
  erreurs ou les injections d'agent, mais **sans second humain indépendant** : elle ne couvre ni le
  risque de compromission du compte de la mainteneuse ni le critère CII `two_person_review`, et doit
  être documentée comme telle. Elle bloquerait les PR rédigées directement par la mainteneuse
  (bypass déclaré ou PR d'agent obligatoire).

### 4.3 Propriétés qui exigent un second humain

| Propriété | Pourquoi elle est requise | Déjà préparé | Action GitHub exacte (quand un second humain existe) | Vérification | Conséquence pour la fusion |
|---|---|---|---|---|---|
| Approbation ≥ 1 | Scorecard Branch-Protection palier 2 ; CII `two_person_review` (Gold) ; détection d'une contribution malveillante ou d'un compte compromis | Ruleset avec règle `pull_request` (0) | Ajouter la personne avec le rôle `Write` ou `Maintain` ; ruleset → « Require a pull request before merging » → « Required approvals » = 1 | `gh api …/rulesets/24138119` → `required_approving_review_count: 1` ; PR fusionnées avec `reviews[].state = APPROVED` par une autre personne | Chaque PR attend l'autre personne ; délai réel |
| Approbation du dernier push | Empêche d'ajouter du contenu non relu après approbation | Rien | Ruleset → « Require approval of the most recent reviewable push » | `require_last_push_approval: true` | Qui pousse en dernier ne peut pas valider ; avec un seul humain : blocage |
| Revue des code owners | Responsabilité par zone (p. ex. `spec/`, `.github/workflows/`) | Aucun `CODEOWNERS` | Créer `.github/CODEOWNERS` avec au moins deux propriétaires réels ; ruleset → « Require review from Code Owners » | `require_code_owner_review: true` ; onglet « Files » de la PR | Avec un seul propriétaire autrice de la PR : blocage [ESTIMÉ] |
| Approbations ≥ 2 | Scorecard palier 4 | Rien | « Required approvals » = 2 | idem | Trois personnes actives nécessaires |
| Continuité d'accès | CII Silver `access_continuity` (MUST), `bus_factor` (SHOULD Silver, MUST Gold) | Rien | Second mainteneur (rôle `Admin` ou `Maintain`) et/ou successeur désigné dans les paramètres du compte [ESTIMÉ : emplacement exact à confirmer] | Liste des collaborateurs ; document de gouvernance | Aucune |
| Contributeurs non associés | CII Gold `contributors_unassociated` | — | Hors configuration | — | — |

Statut de toutes ces lignes : `HUMAN ACTION REQUIRED` (structurel). Aucune ne doit être simulée.

### 4.4 Propriétés atteignables seule, et leur valeur réelle

| Réglage | Faisable seule | Valeur réelle aujourd'hui | Coût / risque |
|---|---|---|---|
| Branche à jour avant fusion (`strict`) | Oui | **Réelle** : la combinaison PR + `main` courant est vérifiée avant fusion (aujourd'hui seule la vérification post-fusion la voit) | Une relance de CI après chaque mise à jour (jusqu'à 45 min pour Lean) |
| Résolution des conversations | Oui | Modérée : empêche de fusionner avec une remarque externe ou d'outil non traitée | La mainteneuse résout elle-même : auto-attestation, à présenter comme telle |
| Méthode de fusion unique (rebase) | Oui | Clarté, cohérence avec `CONTRIBUTING.md` | Aucun |
| Ruleset de tags `v*`, `spec-v*` | Oui | **Réelle** contre la suppression ou le déplacement accidentels et contre les jetons non administrateurs ; faible contre l'administratrice (elle peut modifier le ruleset) | Aucun pour le flux actuel |
| Ruleset `zenodo-state` (suppression, force-push) | Oui | Réelle : l'état Zenodo ne peut plus être réécrit, seulement prolongé | Compatible avec `release.yaml` (pushs en avance rapide) |
| Environnements `zenodo` / `bump` avec politique de refs | Oui | **Élevée** : les secrets ne sont plus lisibles depuis une PR interne | Nécessite `environment:` dans les workflows (vague 2) |
| Approbation manuelle d'un déploiement (`zenodo`) | Oui (auto-approbation) | Réelle : un geste humain conscient avant une publication **irréversible** (DOI) ; [H] hors de portée des sessions d'agent dans cet environnement (chemins Actions refusés par le proxy) | Ce n'est **pas** une revue ; à documenter comme « porte manuelle » |
| Rejet des stale reviews | Oui | ≈ 0 tant qu'aucune approbation n'est requise ; préparatoire | Aucun |
| `CODEOWNERS` déclaratif (`* @AntheaLiles`) | Oui | Faible : documente la responsabilité, ne contrôle rien | Faux signal si présenté comme contrôle ; blocage si « Require review from Code Owners » est coché |
| Approbation des workflows de forks (option la plus stricte) | Oui | Réelle contre l'abus de ressources CI par des forks | Un clic par PR externe |
| « Allow GitHub Actions to create and approve pull requests » décoché | Oui | Réelle si des approbations deviennent requises (un workflow ne peut pas s'auto-approuver) | Aucun : `bump-lean` utilise `BUMP_TOKEN` |
| 2FA du compte | Oui | **Élevée** : en mono-mainteneur, la compromission du compte est la compromission du projet | Aucun |

## 5. Tableau des contrôles

| Contrôle | État | Preuve | Risque réel | Action | Dépendance | Statut |
|---|---|---|---|---|---|---|
| Protection de `main` | Ruleset actif ; protection classique illisible | `rulesets/24138119` ; `branches/main/protection` → 403 | Faible | Confirmer dans l'UI l'absence de règle classique en doublon | Humain | VERIFIED / HUMAN ACTION REQUIRED |
| PR obligatoire | Oui, sans bypass | idem | — | — | — | VERIFIED |
| Bypass / application aux admins | `bypass_actors: []` | idem | L'admin peut modifier le ruleset | Consulter l'historique du ruleset | Humain | VERIFIED (config) |
| Force-push / suppression `main` | Interdits | idem | — | — | — | VERIFIED |
| Historique linéaire | Exigé | idem | — | — | — | VERIFIED |
| Check requis | `CI OK` (app 15368), non strict | ruleset ; check-runs PR #13 | Oracle modifiable par la PR ; combinaison non testée | `strict: true` ; garder `CI OK` seul | Humain | PARTIAL |
| Jobs sautés | `CI OK` en `always()` ; sous-jobs `skipped` acceptés | `ci.yaml:87-116` ; `verify.yaml:235-256` | Seulement via une PR modifiant `ci.yaml` | Vigilance à la fusion | — | VERIFIED |
| Motif `grep` force-full | 5/8 motifs inopérants | `ci.yaml:57` ; test local | Nul (doublé par `impact.py`) | Corriger ou supprimer | Vague 2 (CI) | PARTIAL |
| Approbations requises | 0 ; 0 revue sur 13 PR | ruleset ; `pulls/<n>/reviews` | Aucun second regard | § 4 | Second humain | HUMAN ACTION REQUIRED |
| Stale reviews | `false` | ruleset | Sans objet à 0 | Activer (préparatoire) | Humain | FUTURE |
| Dernier push | `false` | ruleset | — | Ne pas activer seule | Second humain | FUTURE |
| Conversations | `false` | ruleset | Faible | Activer | Humain | HUMAN ACTION REQUIRED |
| CODEOWNERS | Absent | Glob | — | Pas d'exigence ; déclaratif optionnel | Second humain | FUTURE |
| Méthodes de fusion | Dépôt merge+rebase ; ruleset 3 méthodes ; effectif : rebase | API dépôt + ruleset | Confusion | Aligner sur rebase | Humain | HUMAN ACTION REQUIRED |
| Commits signés | 0/69 | `git log %G?` ; API | Pas de preuve d'origine | Ne pas exiger (incompatible rebase GitHub) | Décision | FUTURE |
| Tags `v*` / `spec-v*` | Aucun ruleset ; tag léger | `rulesets?targets=tag` ; `git/refs/tags` | Tag non publié créé, déplacé ou supprimé par tout acteur en écriture | Ruleset de tags | Humain | HUMAN ACTION REQUIRED |
| Releases immuables vs pipeline | `immutable: true` ; upload après publication | `releases` ; `release.yaml:113-121` ; `github/docs` | **Publication PDF/Zenodo impossible** | Arbitrer le flux (brouillon) | Vague 2 + humain | BLOCKED |
| Qui publie une release | 1 admin + jetons (`BUMP_TOKEN`, intégration d'agent) | collaborateurs ; `release.yaml` | DOI irréversible depuis un commit non fusionné | Environnement `zenodo` + contrôle d'ascendance | Humain + vague 2 | HUMAN ACTION REQUIRED |
| Secrets / environnements | Secrets de dépôt, sans `environment:` | `release.yaml:170-174` ; `bump-lean.yaml:66-81` | Exfiltration par PR interne | Environnements | Humain + vague 2 | HUMAN ACTION REQUIRED |
| Permissions par défaut | Illisibles ; tous les workflows explicites | proxy 403 ; lecture des workflows | Faible | Régler « read » ; décocher l'approbation par Actions | Humain | HUMAN ACTION REQUIRED |
| Déclencheurs | Aucun déclencheur privilégié | grep | Faible | — | — | VERIFIED |
| PR de forks | Réglage illisible | proxy 403 | Faible à moyen | Option la plus stricte | Humain | HUMAN ACTION REQUIRED |
| `zenodo-state` | Inexistante, sans règle | `branches` ; `rules/branches/zenodo-state` → `[]` | Orientation d'une publication | Ruleset dédié | Humain | HUMAN ACTION REQUIRED |
| Suppression des branches fusionnées | `false` | API dépôt | Hygiène | Activer | Humain | HUMAN ACTION REQUIRED (opportuniste) |
| 2FA | Illisible | — | Élevé si absent | Vérifier | Humain | HUMAN ACTION REQUIRED |
| Continuité d'accès | 1 admin | collaborateurs | Bus factor 1 | § 4.3 | Second humain | HUMAN ACTION REQUIRED |

## 6. Cohérence documentaire (contradictions signalées, non résolues)

| # | Affirmation | Observation | Nature |
|---|---|---|---|
| C1 | `CONTRIBUTING.md:35` : « Fusion par rebase (historique linéaire, chaque commit ayant déjà été vérifié) » | La CI vérifie la tête de PR (ref de fusion) et la pointe de `main` après push, jamais chaque commit ; le rebase GitHub recrée les commits | Inexact |
| C2 | `CONTRIBUTING.md:33-34` : « Tous les checks doivent passer : compilation, tests, lint, audit des axiomes, REUSE… » | CI sensible à l'impact : compilation et tests seulement si la surface l'exige ; seul `CI OK` est requis | Imprécis depuis PR #13 |
| C3 | `CONTRIBUTING.md:90` et `:105` : « créer la release sur `main` » | Rien ne l'impose (`release.yaml` ne vérifie pas l'ascendance ; aucun ruleset de tag) | Règle non outillée |
| C4 | `CONTRIBUTING.md:92-93`, `README.md:40` et `:67-68` : PDF joint à la release et publié sur Zenodo par la CI | Release unique immuable et sans asset ; `zenodo-state` absente ; run de release en échec ; upload post-publication incompatible avec l'immutabilité | Contradiction factuelle |
| C5 | `SECURITY.md:10` : « k7pl n'a pas encore de version publiée » | Release `spec-v0.0.0-alpha.1` publiée (spécification) ; aucune version d'implémentation | À préciser |
| C6 | `README.md:8` : badge `lean.yaml` | Workflow supprimé (absent de la liste des workflows) | Badge cassé |
| C7 | Ruleset `allowed_merge_methods` merge/rebase/squash | Dépôt : squash désactivé ; historique linéaire : merge interdit ; `CONTRIBUTING.md:35` : rebase | Incohérence de configuration |
| C8 | `.github/workflows/README.md:47-49` : `dependabot.yml`, `lakefile.lean`… forcent la vérification complète | Vrai par `impact.py:14-22`, faux par `ci.yaml:57` | Vrai par un seul des deux mécanismes |
| C9 | `.github/workflows/README.md:30` : `CI OK` est le seul check exigé | Conforme au ruleset | Cohérent |
| C10 | Aucun document ne dit qu'il n'y a qu'une mainteneuse et pas de second relecteur | 0 revue ; 1 collaborateur | Lacune (CII Silver `governance`, `roles_responsibilities`) |
| C11 | `CODE_OF_CONDUCT.md:45` : signalement « par message privé » via le profil GitHub | GitHub n'offre pas de messagerie privée entre comptes [ESTIMÉ] | Canal à préciser (domaine CII) |

## 7. Scorecard et CII (ESTIMÉ)

Score réel non lisible (`api.securityscorecards.dev` et `www.bestpractices.dev` refusés) :
**HUMAN ACTION REQUIRED (relire)**. Reconstitution à partir des règles publiées :

- **Branch-Protection** (`ossf/scorecard` `docs/checks.md`) : palier 1 (force-push, suppression)
  satisfait → 3/10 ; palier 2 non satisfait faute de « ≥ 1 reviewer ». Sans jeton administrateur
  (cas de `scorecard.yaml`), les exigences « for administrators » sont ignorées ; « a tier must be
  fully satisfied before you can earn points from the next tier ». Estimation : **≈ 3/10**, que ne
  changent ni `strict`, ni la résolution des conversations, ni les rulesets de tags.
- **Code-Review** : approbation ou fusionneur différent du committer requis ; 13 PR sans approbation,
  committer = fusionneuse (rebase). Estimation : **0/10**. Les revues par des bots ou des IA ne
  comptent pas.
- **Contributors** : le compte `claude` apparaît comme contributeur. [I] Risque de faux signal
  (organisation supplémentaire) : à examiner par l'agent Scorecard, sans le présenter comme un second
  contributeur humain.
- **CII** (`criteria.yml`, niveaux 0/1/2) : rien sur la revue au niveau Passing. Silver :
  `governance` (MUST), `roles_responsibilities` (MUST), `access_continuity` (MUST), `bus_factor`
  (SHOULD), `signed_releases` (MUST, N/A possible), `version_tags_signed` (SUGGESTED). Gold :
  `code_review_standards` (MUST, **documentable seule**), `two_person_review` (MUST, **impossible
  seule**), `bus_factor` (MUST), `contributors_unassociated` (MUST), `require_2FA` (MUST).

## 8. Écarts classés

**Critiques**

1. Releases immuables incompatibles avec `release.yaml` (upload post-publication) : la prochaine
   release `spec-v*` échouera au job `publish-spec` et n'atteindra pas Zenodo (`BLOCKED`). [D] Flux
   brouillon → assets → publication, ou désactivation de l'immutabilité.
2. Secrets de publication (`ZENODO_TOKEN`) et d'automatisation (`BUMP_TOKEN`) exposés à toute PR
   interne : avec des agents disposant du droit `push`, l'exfiltration ne demande aucune fusion.

**Importants**

3. Aucune protection des tags `v*` / `spec-v*` ; aucun contrôle « tag sur `main` » ; une publication
   Zenodo est irréversible.
4. `zenodo-state` non protégée (dès sa création).
5. Checks non stricts : la combinaison PR + `main` courant n'est vérifiée qu'après fusion.
6. Revue par un second humain absente et non documentée (C10) ; contradictions C1 à C5.

**Opportunistes**

7. Méthodes de fusion à aligner (C7) ; suppression automatique des branches fusionnées ; badge cassé
   (C6) ; motif `grep` (C8) ; résolution des conversations ; rejet des stale reviews (préparatoire).

## 9. Actions humaines GitHub (procédures et vérification)

Chaque action est faisable seule. Aucune ne crée de revue.

**H1. Ruleset de `main`** (Settings → Rules → Rulesets → « PR on main ») :
- « Require status checks to pass » → cocher « Require branches to be up to date before merging ».
- « Require a pull request before merging » → cocher « Require conversation resolution before
  merging » et « Dismiss stale pull request approvals when new commits are pushed » ; « Allowed merge
  methods » : ne garder que « Rebase ».
- Ne pas toucher : « Required approvals » (0), « Require review from Code Owners », « Require approval
  of the most recent reviewable push », liste de bypass (vide).
- Vérifier : `gh api repos/AntheaLiles/k7pl/rulesets/24138119` → `strict_required_status_checks_policy:
  true`, `required_review_thread_resolution: true`, `dismiss_stale_reviews_on_push: true`,
  `allowed_merge_methods: ["rebase"]`, `bypass_actors: []`.

**H2. Paramètres du dépôt** (Settings → General → Pull Requests) : décocher « Allow merge commits » ;
garder « Allow rebase merging » ; cocher « Always suggest updating pull request branches » et
« Automatically delete head branches ». Vérifier : `gh api repos/AntheaLiles/k7pl` →
`allow_merge_commit: false`, `allow_rebase_merge: true`, `allow_update_branch: true`,
`delete_branch_on_merge: true`.

**H3. Ruleset de tags** (Settings → Rules → Rulesets → New ruleset → New tag ruleset) : nom « Release
tags », Enforcement « Active », cibles par motif `v*` et `spec-v*`, règles « Restrict updates »,
« Restrict deletions », « Block force pushes », bypass vide. [D] Optionnel : un second ruleset
« Restrict creations » avec bypass « Repository admin », en sachant qu'un jeton personnel de
l'administratrice bénéficierait probablement du bypass [ESTIMÉ]. Vérifier : `gh api
"repos/AntheaLiles/k7pl/rulesets?targets=tag"` non vide ; tentative de `git push --delete` d'un tag
de test refusée.

**H4. Ruleset `zenodo-state`** (New branch ruleset) : cible « Include by pattern » `zenodo-state`,
règles « Restrict deletions » et « Block force pushes », bypass vide, sans « Restrict creations » ni
« Restrict updates » (la CI crée puis prolonge la branche). Vérifier : `gh api
repos/AntheaLiles/k7pl/rules/branches/zenodo-state` → `deletion` et `non_fast_forward`.

**H5. Environnements** (Settings → Environments), après la modification des workflows en vague 2 :
- `zenodo` : « Deployment branches and tags » → « Selected branches and tags » → règle de **tag**
  `spec-v*` ; secrets d'environnement `ZENODO_TOKEN`, `ZENODO_ENV`. [D] « Required reviewers » =
  AntheaLiles, **sans** « Prevent self-review » : porte manuelle avant publication, à documenter comme
  auto-approbation et non comme revue.
- `bump` : branche `main` seulement ; secret `BUMP_TOKEN`.
- Ordre : (1) créer les environnements et leurs secrets ; (2) fusionner les `environment:` ;
  (3) supprimer les secrets de dépôt correspondants. Vérifier : Settings → Secrets and variables →
  Actions ne liste plus ces secrets au niveau dépôt ; un run de release attend l'approbation ; une PR
  de test ne voit pas `ZENODO_TOKEN`.
- `github-pages` : vérifier que la politique de déploiement est limitée à `main`.

**H6. Actions** (Settings → Actions → General) : approbation des workflows de forks sur l'option la
plus stricte ; « Workflow permissions » = « Read repository contents and packages permissions » ;
décocher « Allow GitHub Actions to create and approve pull requests ». Vérification : lecture de
l'écran (API inaccessible depuis cette session).

**H7. Releases immuables** (Settings → General → Releases) : relever l'état réel du réglage et le
consigner ; ne pas le changer avant l'arbitrage du flux (§ 8.1).

**H8. Compte** : vérifier que la 2FA est active (CII Gold `require_2FA`) ; documenter un plan de
continuité (successeur ou second mainteneur) pour `access_continuity`.

**H9. Relectures non possibles ici** : historique du ruleset et « Rule insights » (aucune
désactivation temporaire ?), sémantique de `require_extra_approval_for_unattributed_changes` dans
l'UI, type et portée de `BUMP_TOKEN`, webhooks (intégration Zenodo–GitHub active ? [H] le DOI
10.5281/zenodo.23040451 existe alors qu'aucun run de release n'a réussi), score Scorecard publié,
fiche CII 15239.

## 10. Ce qu'il ne faut pas faire (faux signaux)

- Passer `required_approving_review_count` à 1 en ajoutant l'administratrice en bypass.
- Créer un second compte, ou utiliser une App, Copilot, un bot ou GitHub Actions pour approuver.
- Exiger la revue des code owners, ou l'approbation du dernier push, avec une seule propriétaire.
- Ajouter les jobs internes (« Vérification / … ») comme checks requis : sautés = succès.
- Présenter le compte `claude`, les agents de revue (`formal-reviewer`, `verification-specialist`)
  ou les fusions de PR d'agents comme une revue indépendante ou un second contributeur.
- Donner à `scorecard.yaml` un PAT administrateur (`repo_token`) pour le seul score.
- Exiger les commits signés tant que la fusion se fait par rebase sur GitHub (commits recréés non
  signés, observé) : `FUTURE`, après décision sur la méthode de fusion et la signature locale.
- Désactiver l'immutabilité des releases pour « réparer » la CI sans arbitrage.

## 11. Frontière `spec/`, `src/`, sémantique

- Aucune action proposée ne modifie `spec/`, `src/` ou `tests/`.
- Le flux `spec-vX.Y.Z` lit `CITATION.cff` et `spec/CHANGELOG.md` : tout changement du flux de release
  (brouillon, environnement) doit laisser ces fichiers inchangés. Une note éventuelle dans
  `spec/CHANGELOG.md` relève de l'autrice.
- [D] Un `CODEOWNERS` attribuant `spec/` à l'autrice traduirait la règle « ne rien modifier sans
  l'accord de l'auteur », mais ne la ferait pas respecter sans second humain : décision de l'autrice,
  à documenter comme déclarative.

## 12. Non vérifié dans cette session

- Paramètres Actions (permissions par défaut, forks, actions autorisées), environnements, secrets
  existants, webhooks : refusés par le proxy.
- Protection classique de `main`, historique du ruleset, « Rule insights », réglage de dépôt des
  releases immuables : 403 pour l'intégration.
- Scores Scorecard et CII réels : domaines refusés.
- Interdiction de l'auto-approbation et emplacement exact de certains écrans : comportements GitHub
  connus, non re-testés (aucune écriture effectuée).
- Création effective de releases ou de tags par l'intégration de session : **non testée
  volontairement** (action d'écriture irréversible).
- Fonctionnement du push `zenodo-state` (en-tête `AUTHORIZATION: bearer`) : jamais exécuté.
- Aucune commande `lake build`, `lake test`, `lake lint` ou `reuse lint` n'a été lancée (sans objet
  pour un audit de configuration).
