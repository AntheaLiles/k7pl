<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit OpenSSF Scorecard — vague 1 (audit seul)

**Domaine** : `scorecard-specialist`. **Date** : 2026-10-06. **Dépôt** : `AntheaLiles/k7pl`, commit audité `b5f6146` (tête de `origin/main`). **Nature** : rapport d'audit, non normatif ; aucune modification de `.github/`, `spec/`, `src/`, `tests/`, `archives/` n'a été faite. Ce fichier est le seul fichier écrit.

Convention de lecture (règle `.claude/rules/documentation.md`) : **Fait** (observé, avec sa preuve), **Interprétation**, **Hypothèse**, **Décision requise**, **Action restante**. Statuts : VERIFIED · PARTIAL · PREPARED · HUMAN ACTION REQUIRED · BLOCKED · FUTURE · N/A. Toute valeur non observée est marquée **ESTIMÉ**.

---

## 1. Synthèse

1. **Fait — le score réel est lisible.** Le postulat « score inaccessible depuis cette session » est inexact : le job `Scorecard` du push `b5f6146` imprime le JSON complet des 18 contrôles dans son journal. Lu par `mcp__github__get_job_logs(owner=AntheaLiles, repo=k7pl, job_id=112017874665, return_content=true, tail_lines=150)` (run `37385570410`, 2026-10-05T22:56:34Z, Scorecard `v5.5.0`, commit Scorecard `c395761d…`). **Score agrégé : 6,0 / 10.** (L'artefact SARIF `scorecard-results`, id `11378255984`, expire le 2026-11-04.)
2. **Fait — le calcul est reproductible.** J'ai compilé Scorecard `v5.5.0` depuis le module Go publié (même version que celle embarquée par `ossf/scorecard-action@2d11466…` / v2.4.4, vérifié dans son `go.mod`) et l'ai exécuté en mode `--local` sur le worktree : les neuf contrôles fondés sur les fichiers donnent exactement les scores du run distant. Les poids de risque (Critique 10, Haut 7,5, Moyen 5, Faible 2,5) reproduisent exactement 6,0 : les projections du §6 sont donc fiables **dans leur arithmétique** (le détail des gains reste ESTIMÉ).
3. **Cinq constats qui comptent** :
   - **Security-Policy 4/10 est un artefact de nommage, pas un défaut de politique** : `.claude/rules/security.md` fait écran à `SECURITY.md` (Scorecard apparie les fichiers par nom de base, sans casse). Démontré par expérience (§3.15). Renommer ce fichier de règles suffit (+6 points sur ce contrôle, +0,32 d'agrégé).
   - **Pinned-Dependencies 9/10** ne reproche qu'une ligne : `scripts/claude-session-start.sh:15` (`curl … master/elan-init.sh | sh`). Mais le même `curl | sh` sur `master` s'exécute en CI **à l'intérieur** de `leanprover/lean-action` épinglé (§3.13) : Scorecard ne le voit pas, le risque réel est plus grand que ce que le score dit.
   - **SAST 0/10 est vrai** : `upload-sarif` n'est pas de la SAST (Scorecard v5.5.0 cherche `github/codeql-action/analyze`). Une SAST réelle est possible sur `actions` et `python` (340 Ko de Python), pas sur Lean.
   - **Signed-Releases est « inconclusif » (exclu du score) et peut devenir un piège** : la seule release (`spec-v0.0.0-alpha.1`) n'a **aucun asset**. La première release avec PDF + `.sha256` mais sans fichier de signature reconnu ferait passer le contrôle à **0** (agrégé 6,0 → ~5,6). `release.yaml` n'a **jamais été exécuté** (aucun run).
   - **Code-Review 0/10, Branch-Protection 3/10, Fuzzing 0/10, Contributors volatil** : plafonds structurels d'un dépôt mono-mainteneur ; ne rien « corriger » pour le score (§8).
4. **Plafond honnête (ESTIMÉ)** : ≈ **7,9** / 10, atteignable en ~3 mois (renommage, épinglage, CodeQL si décidé, ruleset strict, bundle Sigstore en release, `Maintained` à partir du 2026-12-27, badge CII « passing »). Au-delà, il faudrait un second relecteur humain réel.

---

## 2. Méthode, sources, limites

**Faits sur la méthode** (reproductibles) :

- Journal du job Scorecard : voir §1.1. Détail des contrôles : colonnes `details` du JSON (cités ci-dessous).
- Code Scorecard `v5.5.0` : archive `https://proxy.golang.org/github.com/ossf/scorecard/v5/@v/v5.5.0.zip` (hash d'origine `c395761df6afe1a69e476bc60a013a94bcbc153f`, identique au `scorecard.commit` du run distant). Lu : `checks/evaluation/*.go`, `checks/raw/*.go`, `probes/*/impl.go`, `clients/githubrepo/*.go`, `docs/checks.md`.
- Compilation locale : `GOTOOLCHAIN=go1.25.7 go -C <source> build -o scorecard .` ; exécution : `scorecard --local <répertoire> --checks … --show-details --format json`. Binaire, sources et JSON sont dans la scratchpad de session (hors dépôt, rien n'est suivi).
- Expériences contrôlées sur copies hors dépôt (§3.15, §3.13, §3.14) ; le worktree n'a pas été modifié.
- Lecture des workflows, scripts et réglages du dépôt (`gh api repos/AntheaLiles/k7pl/{rulesets/24138119,rules/branches/main,releases,languages,license,community/profile,private-vulnerability-reporting,pulls/*}` ; `mcp__github__actions_list`).
- `osv-scanner` v2 (dépendance de Scorecard) compilé localement pour lister ce que l'extraction OSV voit (§3.18).

**Limites** : `api.scorecardsecurity`/`api.scorecard.dev`, `www.bestpractices.dev`, `api.osv.dev`, `release.lean-lang.org` sont refusés par le proxy ; les points qui en dépendent sont marqués. Aucune toolchain Lean : **aucun `lake build/test/lint` n'a été exécuté** (ni nécessaire pour cet audit).

---

## 3. Fiches par contrôle (18 contrôles du run + 2 expérimentaux)

Format : **État** · **Preuve** · **Défaut** · **Risque réel** (distinct du risque de score) · **Modification** · **Coût** · **Dépendance** · **Statut** · **Score** (observé / atteignable honnêtement).

### 3.1 Binary-Artifacts — observé 10 / atteignable 10
- **État (Fait)** : « no binaries found in the repo ». **Preuve** : JSON du run ; `scorecard --local` = 10.
- **Défaut** : aucun. **Risque réel** : faible. Le contrôle ne voit que le dépôt ; il ne dit rien des binaires téléchargés en CI (Tectonic, elan, actions à image Docker).
- **Modification** : aucune. **Statut** : VERIFIED.

### 3.2 Branch-Protection — observé 3 / atteignable 4
- **État (Fait)** : ruleset actif `PR on main` (id 24138119) : `deletion`, `non_fast_forward`, `required_linear_history`, `pull_request` (`required_approving_review_count: 0`, `dismiss_stale_reviews_on_push: false`, `require_code_owner_review: false`, `require_last_push_approval: false`), `required_status_checks` (« CI OK », `strict_required_status_checks_policy: false`), `bypass_actors: []`. **Preuve** : `gh api repos/AntheaLiles/k7pl/rulesets/24138119` ; détails du JSON du run (« branch protection settings apply to administrators », « does not require approvers », « up-to-date branches is disabled », « last push approval is disabled », « PRs are required »).
- **Calcul (Interprétation, code `checks/evaluation/branch_protection.go`, `clients/githubrepo/branches.go`)** : palier 1 (suppression + force-push bloqués) = 3 pts ; palier 2 (≥1 approbation 2/5 + à jour 1/5 + dernière poussée approuvée 1/5 + PR exigée 1/5) : seul « PR exigée » est vrai, 1/5 → 0,6 ; total 3,6 tronqué à **3**. Le palier 3 (status checks, +2) n'est **pas compté** tant que le palier 2 n'est pas complet (cascade `computeFinalScore`) : le check « CI OK » obligatoire ne rapporte donc rien.
- **Défaut** : palier 2 incomplet ; il exige une approbation d'un tiers, impossible honnêtement avec un seul humain.
- **Risque réel** : la prise de contrôle du compte unique permet de publier ET fusionner. Compensations réelles déjà en place : CI obligatoire, aucun bypass (EnforceAdmins vrai), historique linéaire, pas de force-push, pas de suppression. Non couverts : **protection des tags** (aucun ruleset de tags : le tag `spec-v0.0.0-alpha.1`, cité par le DOI Zenodo et le SWHID du README, est mutable), second facteur du compte (non vérifiable).
- **Modification** : (a) `strict_required_status_checks_policy: true` (HUMAN, §7.3) : palier 2 à 2/5 → score **4**. (b) ruleset de tags (HUMAN, §7.4), sans effet sur le score. **Coût** (a) : chaque PR doit être à jour avant fusion (CI longue : `impl` jusqu'à 45 min) ; acceptable mais **décision de l'auteur**.
- **Statut** : HUMAN ACTION REQUIRED (a, b). Le reste : N/A honnête.

### 3.3 CI-Tests — observé 10 / atteignable 10
- **Fait** : « 5 out of 5 merged PRs checked by a CI test » (PR 7, 9, 11, 12, 13). **Statut** : VERIFIED.
- **Risque réel** : le contrôle regarde le nom des check-runs, pas leur contenu. La CI est sélective (`scripts/ci/impact.py` décide quels jobs Lean/Verso tournent) : une erreur du classifieur ne serait pas vue ici (domaine `quality-reproducibility-specialist`).

### 3.4 CII-Best-Practices — observé 2 / atteignable 5
- **Fait** : « badge detected: InProgress » (JSON du run). Le projet 15239 est donc détecté mais incomplet. **Non vérifiable depuis cette session** : l'état saisi sur `bestpractices.dev` (proxy 403).
- **Interprétation** : le badge « passing » (5 pts) demande de répondre à chaque critère (Met / Unmet / N/A avec justification) ; c'est un acte humain. Silver (7) et gold (10) comportent des critères de continuité d'accès / de facteur bus ≥ 2 : **ESTIMÉ non atteignables** honnêtement à un seul mainteneur.
- **Risque réel** : faible côté sécurité ; la valeur est de forcer un auto-examen. **Statut** : HUMAN ACTION REQUIRED (domaine `cii-specialist`, §7.2).

### 3.5 Code-Review — observé 0 / atteignable 0
- **Fait** : « Found 0/4 approved changesets ». **Preuve** : JSON ; `gh api repos/AntheaLiles/k7pl/pulls/{1,4,7,9,11,12,13}` + `/reviews` : 0 relecture sur les 13 PR ; auteur = fusionneur = `AntheaLiles` pour les PR 1-7, 11, 12, 13 ; la PR 9 (Dependabot, fusionnée par l'humain) compte comme approuvée et est écartée du calcul (code `probes/codeApproved`).
- **Interprétation** : le code exige une approbation d'un compte **différent** de l'auteur de la PR ; le fusionneur compte comme relecteur implicite seulement s'il diffère de l'auteur. Les PR de session agent sont ouvertes **sous le compte de l'auteur** : aucune relecture indépendante, y compris du code produit par agent. Scorecard (docs/checks.md) précise que les relectures par bot ou IA ne comptent pas.
- **Risque réel** : élevé en principe (aucun second regard humain). Compensations : CI obligatoire sans bypass, historique public, audit des axiomes en CI.
- **Modification honnête** : aucune. FUTURE : un second relecteur humain réel (§7.10). **Statut** : N/A (plafond structurel) / FUTURE.

### 3.6 Contributors — observé 6 / atteignable : non pilotable
- **Fait** : « found contributions from: anthropics, freeengineering » → 2 organisations → 6. **Interprétation** : `anthropics` vient du champ « Company » du profil du compte `claude` (qui porte les commits `noreply@anthropic.com`, 38 commits) ; `freeengineering` du profil de l'auteur (41 commits). L'indicateur n'est pas un signal de sécurité et est **volatil** : si l'attribution des commits change, le score peut retomber à 3 (−0,08 d'agrégé) sans changement de sécurité.
- **Modification** : aucune ; ne pas toucher aux champs de profil (§8). **Statut** : N/A.

### 3.7 Dangerous-Workflow — observé 10 / atteignable 10
- **Fait** : « no dangerous workflow patterns detected » ; aucun `pull_request_target`, `workflow_run`, `issue_comment` dans `.github/workflows/`. **Statut** : VERIFIED.
- **Risque réel (hygiène, non vu par Scorecard)** : `bump-lean.yaml:46` interpole une sortie d'étape dans un `run:` (`"${{ steps.version.outputs.latest }}"`) ; la valeur vient de `scripts/latest-lean-version.sh` (données amont). Le motif est celui que les analyseurs d'Actions (CodeQL `actions`, zizmor) signalent comme injection de modèle de faible gravité. Correction triviale : passer par `env:`. Les autres interpolations de `run:` passent déjà par `env:` (`ci.yaml:46-48`, `release.yaml:38,71,97,130`).

### 3.8 Dependency-Update-Tool — observé 10 / atteignable 10
- **Fait** : « detected update tool: Dependabot: .github/dependabot.yml:1 ». Le code ne teste que la **présence** de `.github/dependabot.yml` ou d'un fichier Renovate/Scala-Steward (`checks/raw/dependency_update_tool.go`) ; il ne reconnaît pas `bump-lean.yaml` et n'en a pas besoin.
- **Risque réel** : Dependabot (`github-actions` hebdomadaire groupé ; `pip` `/scripts` mensuel) ne couvre **pas** les dépendances Lake (Mathlib, CSLib, Verso, + 11 transitives) : elles dépendent du workflow mensuel `bump-lean.yaml` (cron `43 5 3 * *`) qui exige `BUMP_TOKEN` (type et portée du jeton non vérifiables, §7.9). **Statut** : VERIFIED.

### 3.9 Fuzzing — observé 0 / atteignable 0 (N/A)
- **Fait** : « no fuzzer integrations found ». Langues du dépôt (`gh api …/languages`) : Lean 1 060 643 o, Python 339 867 o, TeX, Emacs Lisp, Shell. Scorecard ne reconnaît aucun outil de fuzzing ni de test à propriétés pour Lean (liste : Go natif, Haskell, JS/TS `fast-check`, Erlang, Elixir, Gleam, F#/C#, Python `atheris`, OSS-Fuzz, ClusterFuzzLite).
- **Interprétation** : les tests à propriétés réels du projet (`plausible`, présent dans `lake-manifest.json`) sont invisibles pour Scorecard. Ajouter un harnais `atheris` à des scripts de maintenance pour faire basculer le contrôle serait décoratif (§8). **Statut** : N/A, justifié.

### 3.10 License — observé 9 / atteignable 9
- **Fait** : « license file detected » (`LICENSE.md`), « does not contain an FSF or OSI license ». **Preuve** : `gh api repos/AntheaLiles/k7pl/license` → `path: LICENSE.md`, `spdx_id: NOASSERTION`, `key: other`.
- **Interprétation** : le dépôt est réellement sous deux licences (CECILL-2.1 pour le code, CC-BY-4.0 pour `spec/`), conforme REUSE (`LICENSES/CECILL-2.1.txt`, `LICENSES/CC-BY-4.0.txt`). L'API GitHub ne peut pas désigner une licence unique. Le dernier point (+0,027 d'agrégé) exigerait de présenter une licence unique : **ne pas le chercher** (§8). **Statut** : VERIFIED ; plafond N/A.

### 3.11 Maintained — observé 0 / atteignable 10 (par le temps)
- **Fait** : « project was created within the last 90 days » (JSON). Dépôt créé le 2026-09-28T17:07:10Z (`gh api repos/AntheaLiles/k7pl`).
- **Interprétation (code `checks/evaluation/maintained.go`)** : tant que `createdAt` est à moins de 90 jours, le score est 0 quelle que soit l'activité. Ensuite, score = min(10, (commits des 90 derniers jours + tickets avec activité d'un collaborateur) / 12). Avec 69 commits en une semaine, **10 dès le premier run après le 2026-12-27T17:07Z** (premier lundi : le 2026-12-28, cron `17 6 * * 1`, ou tout push sur `main`) — **ESTIMÉ** (date, sous réserve que la cadence se maintienne).
- **Modification** : aucune. Ne pas produire de commits ni de tickets artificiels. **Statut** : FUTURE (dépendance : temps).

### 3.12 Packaging — observé −1 (exclu) / atteignable −1 (N/A)
- **Fait** : « packaging workflow not detected » ; score −1 : le contrôle est **inconclusif** et ne pèse pas dans l'agrégé (`checks/evaluation/packaging.go`). Scorecard reconnaît des motifs `npm publish`, `docker push`, `gem push`, `cargo publish`, `pypa/gh-action-pypi-publish`, etc. (`checks/fileparser/github_workflow.go:453-`) ; la publication par `gh release upload` + Zenodo n'en fait pas partie.
- **Interprétation** : k7pl est un langage et une spécification, pas un paquet ; Lake n'a pas de registre reconnu (cf. `.howfairis.yml`, exemption déclarée). Aucune pénalité : **ne rien ajouter**. **Statut** : N/A, justifié.

### 3.13 Pinned-Dependencies — observé 9 / atteignable 10
- **Fait** : « Warn: downloadThenRun not pinned by hash: scripts/claude-session-start.sh:15 » ; « 29/29 GitHub-owned et 10/10 third-party GitHubAction pinned ; 0/1 downloadThenRun ; 1/1 pipCommand ». Formule : 10 × Σ(épinglés × poids) / Σ(total × poids) = 148/158 → 9.
- **Preuve de correction** : copie hors dépôt avec l'URL épinglée sur le commit du tag `v4.2.4` d'elan : **Pinned-Dependencies 10** (`scorecard --local`). Règle de Scorecard (`checks/raw/shell_download_validate.go:301-336`) : un `curl | sh` n'est « épinglé » que si l'URL est `raw.githubusercontent.com/<org>/<repo>/<SHA 40 hex>/…`.
- **Le commit à utiliser (à reconfirmer en vague 2)** : `227caca133724d5516bee25c2aeb3e609478f2d8` (tag elan v4.2.4, résolu par `proxy.golang.org/github.com/leanprover/elan/@latest`). Le contenu de `elan-init.sh` y est **octet pour octet identique** à `master` et au commit `0e36a07b…` (SHA-256 `a620ff1641616222c8d37c54845492004bb84d6877cdbc944dd65c1aa685bf53`, trois téléchargements comparés le 2026-10-06).
- **Défaut résiduel (Fait)** : `elan-init.sh` (lignes 102-106) télécharge ensuite `releases/latest/download/elan-<arch>.tar.gz` **sans somme de contrôle** ; épingler le script n'épingle pas le binaire. Le gain de score (+1) est donc réel pour le script mais **PARTIAL** pour la sécurité.
- **Risque réel supérieur au score (Fait)** : `leanprover/lean-action@f061402b660e0c34644504b324e830f2991d4865` (épinglé, `verify.yaml:76-84` et `128-136`, `bump-lean.yaml:49`) exécute `scripts/install_elan.sh`, qui fait `curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh` (lu à ce SHA). Cela s'exécute dans les jobs `impl` et `spec` — ce dernier produit le PDF **attesté** en release. Scorecard n'analyse pas l'intérieur des actions composites : 10/10 ne dit rien de ceci. De même pour les téléchargements internes de `raven-actions/actionlint`, `gitleaks/gitleaks-action`, `fsfe/reuse-action` et l'image `docker://ghcr.io/ossf/scorecard-action:v2.4.4` (par étiquette).
- **Ce que Scorecard voit du reste (Fait/Interprétation)** : Tectonic (`verify.yaml:190-210`) est téléchargé par version fixe + `sha256sum --check --strict`, hors pipe → non signalé, et le contrôle est réel. `pip install --require-hashes -r scripts/requirements-zenodo.txt` (`release.yaml:160`) → 1/1 épinglé. `lake-manifest.json` épingle les 14 paquets Lake par `rev` (SHA), mais Scorecard ne lit pas Lake.
- **Modification** : (a) vague 2, `scripts/claude-session-start.sh` : URL épinglée au commit (+1, PARTIAL). (b) FUTURE (domaine `supply-chain-release-specialist`) : installer elan en CI par version fixe + SHA-256 (même schéma que Tectonic) au lieu du `curl | sh` de `lean-action` ; coût moyen (entretien de la version/somme, à coupler à `bump-lean`). **Coût (a)** : minime. **Statut** : PARTIAL (a PREPARED), (b) FUTURE.

### 3.14 SAST — observé 0 / atteignable 10 (si décision)
- **Fait** : « 0 commits out of 30 are checked with a SAST tool ». `scorecard.yaml:43-46` utilise `github/codeql-action/upload-sarif` : **ne compte pas**. Le code (`checks/raw/sast.go`) cherche `uses: github/codeql-action/analyze` (regex `^github/codeql-action/analyze$`), Sonar, Snyk, Pysa, Qodana, Hadolint, ou des check-runs d'applications `github-code-scanning` / `github-advanced-security` / `sonarcloud` sur les PR récemment fusionnées.
- **Calcul (Interprétation, `checks/evaluation/sast.go`)** : avec un workflow `analyze` présent mais 0/30 commits analysés → 0·3 + 10·7 / 10 = **7** dès le premier run ; 10 quand les 30 derniers commits (PR) ont un check-run de code scanning. **Les 7 premiers points viennent de la seule présence du fichier** : le seul critère légitime d'adoption est la valeur de l'analyse.
- **Valeur réelle** : CodeQL sait analyser `actions` (injections, permissions, extraits de workflow : 9 workflows) et `python` (340 Ko : `scripts/controle.py`, `org2verso/`, `biblio/`, `sync_zenodo.py` qui manipule un jeton Zenodo). **Lean n'est pas supporté** (aucune SAST réelle pour 76 % du code ; les garde-fous propres au projet — `lake lint`, `scripts/axiom-audit.sh` — sont réels mais invisibles pour Scorecard).
- **Preuve de détection** : copie hors dépôt avec un workflow `init`+`analyze` (`languages: actions,python`) : `scorecard --local` → SAST 10 ; Token-Permissions et Pinned-Dependencies restent 10.
- **Modification (D : décision de l'auteur)** : soit `.github/workflows/codeql.yaml` (SHA 2892aa5… déjà utilisé, déclencheurs `pull_request`, `push` sur `main`, hebdomadaire ; `contents: read` en tête, `security-events: write` au job), soit « default setup » dans les réglages (§7.7 ; sans fichier, détection par check-runs seulement : score proportionnel). **Coût** : quelques minutes de CI par PR, gratuit sur dépôt public ; ne devient pas un check obligatoire. **Statut** : PREPARED (en attente de décision).

### 3.15 Security-Policy — observé 4 / atteignable 10
- **Fait** : « Warn: no linked content found ». **Cause (Fait, démontré)** : `SECURITY.md:14-16` contient pourtant l'URL `https://github.com/AntheaLiles/k7pl/security/advisories/new` ; mais `OnMatchingFileContentDo` apparie par **nom de base sans casse** et s'arrête au premier fichier lu : `.claude/rules/security.md` (trié avant `SECURITY.md`) est analysé à la place, et n'a ni lien ni courriel. Expériences (copies hors dépôt, `scorecard --local --checks Security-Policy`) : `SECURITY.md` seul → **10** ; `SECURITY.md` + `.claude/rules/security.md` → **4** ; `SECURITY.md` + une autre règle nommée autrement → **10** ; dépôt complet avec la règle renommée `assurance.md` → **10**. `gh api repos/AntheaLiles/k7pl/private-vulnerability-reporting` → `{"enabled":true}` : la politique dit vrai.
- **Défaut** : collision de nom (le contenu de la politique n'est pas en cause). **Risque réel** : nul pour la sécurité ; le score affiche à tort une politique sans lien.
- **Modification** : renommer `.claude/rules/security.md` en `.claude/rules/assurance.md` (son titre est déjà « Règles de sécurité et d'assurance »). Aucune référence au chemin dans le dépôt (`grep` sur `.claude/`, `.github/`, `docs/`, `scripts/`, `README.md`, `CONTRIBUTING.md`) ; à propager dans les rapports des autres agents (le briefing le cite). **Garde-fou pour la vague 2** : n'écrire aucun fichier `security.md`/`.markdown`/`.rst`/`.adoc` hors racine (les motifs reconnus incluent `.github/security.md` et `docs/security.md`).
- **Coût** : nul. **Statut** : PREPARED. **Score** : 4 → 10 (agrégé +0,32).

### 3.16 Signed-Releases — observé −1 (exclu) / atteignable 8
- **Fait** : « no releases found » (JSON). `gh api repos/AntheaLiles/k7pl/releases` : une seule release `spec-v0.0.0-alpha.1`, **`assets: []`**. Le code ne considère que les releases **ayant des assets** (`len(release.Assets) == 0 → continue`, `probes/releasesAreSigned/impl.go`) parmi les 5 dernières, **tous préfixes de tag confondus** (une release `spec-v*` suffit ; l'absence de tag `v*` n'est pas un obstacle). Aucun finding → « no releases found » → inconclusif.
- **Ce que Scorecard détecte (Fait)** : suffixes d'assets `.asc .minisig .sig .sign .sigstore .sigstore.json` → 8 ; `.intoto.jsonl` → 10. Rien d'autre : ni `.sha256`, ni l'attestation stockée dans le dépôt d'attestations GitHub par `actions/attest`.
- **Piège (Interprétation)** : si une release avec assets (PDF + `.sha256`, tels que `release.yaml:104-116` les publie) existe sans suffixe reconnu, le contrôle devient conclusif à **0** : agrégé 6,0 → ~5,5 (§6). Il faut donc publier le bundle **dès la première release avec assets**.
- **Modification (domaine `supply-chain-release-specialist`, fichier `release.yaml`)** : donner un `id` à l'étape `actions/attest` (SHA 1e69f48…, v4.2.2 ; sans prédicat elle génère une **provenance SLSA** — README à ce SHA —, sortie `bundle-path`) puis téléverser ce bundle comme asset `k7pl-spec.pdf.sigstore.json` (copie renommée, passée par `env:`). Score **8**, honnête : c'est la vraie attestation Sigstore. **10** (`.intoto.jsonl`) : **non recommandé** — le fichier de GitHub est un bundle Sigstore, pas l'enveloppe DSSE du générateur SLSA ; le renommer serait cosmétique (§8). Vérification réelle après publication : `gh attestation verify k7pl-spec.pdf --repo AntheaLiles/k7pl`.
- **Risque réel (Fait)** : `release.yaml` **n'a jamais tourné** (aucun run du workflow ; seul le run `Lean Build` de l'ancien `lean.yaml` a échoué sur la release du 2026-09-29). Attestation, publication du PDF et Zenodo sont **PREPARED, non VERIFIED**. **Statut** : PREPARED (pour la modification), FUTURE (pour le score).

### 3.17 Token-Permissions — observé 10 / atteignable 10
- **Fait** : 10 ; `permissions` de tête à `contents: read` dans 8 workflows, `read-all` dans `scorecard.yaml:16` (Info, non pénalisé : le contrôle l'accepte et les règles de `publish_results` l'imposent : « pas d'écriture au niveau du workflow »). Avertissements d'information : `contents: write` à `bump-lean.yaml:23`, `release.yaml:92`, `release.yaml:125`.
- **Risque réel** : `release.yaml:92` (téléverser le PDF) et `:125` (pousser la branche `zenodo-state`) sont justifiés. `bump-lean.yaml:22-24` donne `contents: write` + `pull-requests: write` au `GITHUB_TOKEN`, alors que la PR est créée avec `BUMP_TOKEN` (`:81`) ; **Hypothèse** : ces écritures sont inutiles et `lake update`/`lake build` exécutent du code de dépendances dans ce job — à confirmer par le domaine supply-chain avant de réduire. Le réglage dépôt « Workflow permissions » n'est pas détectable par Scorecard (§7.8).
- **Statut** : VERIFIED ; hygiène opportuniste.

### 3.18 Vulnerabilities — observé 10 / atteignable 10 (aveugle sur Lake)
- **Fait** : « 0 existing vulnerabilities detected ». **Sources (code `clients/osv.go`)** : `osv-scanner` v2 en lecture récursive du dépôt avec l'extracteur `python/requirements` activé + interrogation par hash de commit. **Expérience** : `osv-scanner scan -r <copie>` (binaire compilé) → un seul fichier extrait, `scripts/requirements-zenodo.txt`, **5 paquets PyPI** ; `lake-manifest.json` (14 paquets Lake), `lakefile.lean` et les workflows ne sont pas lus. (L'interrogation `api.osv.dev` est bloquée localement ; le résultat 0 vient du run distant.)
- **Interprétation** : 10/10 est vrai mais **non informatif pour Lean** ; aucune source OSV ne couvre Lake. Mathlib/Batteries/Verso/CSLib sont épinglés par `rev` ; le risque propre à l'écosystème est l'exécution de code à l'élaboration (métaprogrammation), pas un CVE catalogué. Les alertes Dependabot GitHub ne couvrent pas Lake non plus (réglages non lisibles, §7.9).
- **Statut** : VERIFIED (score) ; aveuglement documenté.

### 3.19 Contrôles expérimentaux : SBOM, Webhooks
- **Fait** : ils sont retirés de la liste par défaut sans `SCORECARD_EXPERIMENTAL` (`checks/all_checks.go`) ; ils sont absents du JSON du run. Pas de webhook lisible (réglage admin).
- **Interprétation** : SBOM (5 pts : fichier SBOM dans les sources ou en asset de release) pourrait entrer dans la liste par défaut en v6. Il n'existe pas de générateur SBOM établi pour Lake : **ne rien produire** tant qu'un SBOM réel n'est pas généré par un outil (règle `security.md` : pas de SBOM fabriqué). **Statut** : FUTURE.

---

## 4. Vérification des hypothèses du mandat

| # | Hypothèse | Verdict | Preuve |
|---|---|---|---|
| 1 | `scorecard.yaml` : `permissions: read-all` en tête ; `upload-sarif` ≠ SAST | **Partiellement confirmée.** `upload-sarif` n'est pas de la SAST (confirmé). `read-all` n'est **pas pénalisé** (Info) et n'a aucun effet d'exécution (le bloc `permissions:` du job le remplace) ; il est conforme aux restrictions de `publish_results`. | JSON ; `scorecard.yaml:16,22-26` ; README de `scorecard-action` au SHA 2d11466 |
| 2 | Signed-Releases | **Confirmée et précisée** : seuls les suffixes d'assets comptent ; `.sha256` et `actions/attest` seuls : non vus ; sans release avec assets : inconclusif (exclu), pas 0 ; `spec-v*` suffit. | §3.16 |
| 3 | Pinned-Dependencies | **Confirmée.** Une seule ligne signalée ; l'intérieur de `lean-action` (même `curl \| sh` sur `master`) n'est pas vu ; Tectonic (SHA-256) et pip (`--require-hashes`) sont vus comme corrects/épinglés. | §3.13 |
| 4 | Dependency-Update-Tool | **Confirmée** : présence de `dependabot.yml` seulement ; `bump-lean.yaml` ignoré, sans conséquence. | §3.8 |
| 5 | Branch-Protection / Code-Review à auteur unique | **Confirmée et chiffrée** : 3/10 (palier 2 incomplet, palier 3 non compté) et 0/10. | §3.2, §3.5 |
| 6 | Maintained / Contributors / CII | **Confirmée** : `Maintained` 0 tant que < 90 jours (→ 2026-12-27) ; Contributors 6 volatil ; CII 2 (InProgress). | §3.11, §3.6, §3.4 |
| 7 | Vulnerabilities | **Confirmée** : OSV ne lit que `requirements-zenodo.txt` ; rien sur Lake. | §3.18 |

---

## 5. Écarts

### Critiques (risque réel)
Aucun contrôle Scorecard « critique » n'est en défaut. Deux **risques réels** que le score ne montre pas (renvoyés aux domaines concernés) :
- **C1.** `curl | sh` de `master/elan-init.sh` exécuté en CI dans `leanprover/lean-action` (jobs `impl`, `spec`), le second alimentant le PDF attesté (`verify.yaml:118-182`, `release.yaml`). Domaine : `supply-chain-release-specialist`.
- **C2.** Pipeline de release jamais exécuté (`release.yaml`) et **tags de release non protégés**. Domaine : `supply-chain-release-specialist` / `github-governance-specialist`.

### Importants (score et réel)
- **I1.** Security-Policy 4 → 10 par renommage de `.claude/rules/security.md` (§3.15) : artefact pur, +0,32.
- **I2.** Signed-Releases : ajouter le bundle Sigstore **avant** toute release avec assets (§3.16) ; sinon −0,5.
- **I3.** Pinned-Dependencies 9 → 10 : épingler l'URL elan du hook de session (§3.13), PARTIAL.
- **I4.** SAST : décision de l'auteur sur CodeQL `actions`+`python` (§3.14) : +0,38 puis +0,54 si adopté.

### Opportunistes
- **O1.** `strict_required_status_checks_policy: true` (+1 Branch-Protection, +0,08) : décision d'auteur, friction non nulle.
- **O2.** `bump-lean.yaml:46` : passer `steps.version.outputs.latest` par `env:` ; réduire le `GITHUB_TOKEN` du job (hypothèse à confirmer).
- **O3.** `scorecard.yaml:16` `read-all` → `contents: read` : cohérence cosmétique, sans effet de score ni de risque ; peut rester tel quel.
- **O4.** README : le badge « Lean Build » (`README.md:8`) pointe vers `lean.yaml`, qui n'existe plus (hors périmètre Scorecard ; à signaler).
- **O5.** Le ruleset liste `allowed_merge_methods` merge/rebase/squash alors que `required_linear_history` interdit les merges et que le dépôt désactive le squash : incohérence cosmétique des réglages.

---

## 6. Projection de score (arithmétique vérifiée ; gains ESTIMÉS)

| Scénario | Agrégé |
|---|---|
| Observé (run 37385570410) | **6,00** |
| A. + renommage `security.md` + URL elan épinglée | 6,38 |
| B1. A + CodeQL, premier run (0/30 commits analysés) | 6,76 |
| B2. A + CodeQL, 30 commits analysés | 6,92 |
| C. B2 + ruleset strict | 7,00 |
| **Piège** : C + première release avec assets sans fichier de signature | 6,47 |
| D. C + release avec `.sigstore.json` (Signed-Releases = 8) | 7,08 |
| E. D + `Maintained` après le 2026-12-27 | 7,83 |
| F. E + badge CII « passing » (humain) | **7,90** |
| F avec Contributors retombant à 3 | 7,83 |

Plafond structurel : Code-Review 0, Fuzzing 0, License 9, Branch-Protection 4, CII 5 sans second contributeur. Scénarios au-delà de F : exigent un second humain réel (§7.10).

---

## 7. Actions humaines (GitHub-side), avec procédure et vérification

**7.1 Relire le score publié** (HUMAN ACTION REQUIRED). Ouvrir `https://scorecard.dev/viewer/?uri=github.com/AntheaLiles/k7pl` (ou `curl https://api.scorecard.dev/projects/github.com/AntheaLiles/k7pl`). Attendu : 6,0 et les scores du §3. Non vérifiable ici (proxy). Le contrôle équivalent reste le journal du job `Scorecard` (§1.1).

**7.2 Badge CII, projet 15239** (domaine `cii-specialist`). `https://www.bestpractices.dev/en/projects/15239/edit` → renseigner chaque critère « passing » (Met / Unmet / N/A + justification, avec URL de preuve du dépôt). Vérifier : `https://www.bestpractices.dev/projects/15239/badge` affiche « passing » ; au run Scorecard suivant, CII-Best-Practices passe de 2 à 5.

**7.3 Ruleset strict** (décision de l'auteur). Settings → Rules → Rulesets → « PR on main » → « Require status checks to pass » → cocher « Require branches to be up to date before merging » → Save. Vérifier : `gh api repos/AntheaLiles/k7pl/rulesets/24138119 --jq '.rules[] | select(.type=="required_status_checks") | .parameters.strict_required_status_checks_policy'` → `true` ; au run suivant, Branch-Protection 4 (« up-to-date branches » en Info).

**7.4 Protéger les tags de release** (sans effet de score ; risque réel C2). Settings → Rules → Rulesets → New ruleset → **New tag ruleset** : nom « Release tags » ; Enforcement « Active » ; cibler `refs/tags/spec-v*` et `refs/tags/v*` ; règles « Restrict deletions » et « Restrict updates » (ne **pas** cocher « Restrict creations » : la création de la release en dépend) ; liste de contournement vide. Vérifier : `gh api repos/AntheaLiles/k7pl/rulesets --jq '.[] | {name,target}'` liste un ruleset `tag`. À coordonner avec `github-governance-specialist`.

**7.5 Second facteur du compte** (non vérifiable ici). github.com/settings/security : activer clé de sécurité / passkey ; vérifier les sessions et jetons actifs.

**7.6 Portée des secrets** (non vérifiable : endpoint `environments` bloqué). Déplacer `ZENODO_TOKEN`/`ZENODO_ENV` dans un environnement dédié restreint aux tags `spec-v*`, et `BUMP_TOKEN` dans un environnement restreint à `main` (Settings → Environments → New environment → « Deployment branches and tags » ; Environment secrets), puis ajouter `environment:` aux jobs `zenodo` et `bump`. Motif : un workflow modifié sur une branche du même dépôt reçoit les secrets du dépôt. Domaine `github-governance-specialist`.

**7.7 CodeQL, voie « default setup »** (alternative au fichier de workflow, §3.14). Settings → Advanced Security / Code security → Code scanning → CodeQL analysis → Set up → Default → langages `Actions` et `Python` → Enable. Vérifier : onglet Security → Code scanning ; check-runs « CodeQL » sur les PR ; SAST proportionnel aux PR analysées.

**7.8 Réglages d'Actions** (non détectables par Scorecard). Settings → Actions → General : « Workflow permissions » = « Read repository contents and packages permissions » ; « Fork pull request workflows » = approbation exigée pour tous les contributeurs externes. Lecture API bloquée (`actions/permissions*`).

**7.9 Jeton `BUMP_TOKEN` et alertes Dependabot** (non vérifiable). Vérifier dans Settings → Developer settings que le jeton est à portée fine, limité au dépôt (Contents + Pull requests : écriture), avec expiration. Vérifier Settings → Code security : Dependabot alerts, Dependabot security updates, Secret scanning, Push protection.

**7.10 Second relecteur humain** (FUTURE, seul chemin honnête pour Code-Review et le palier 2/4 de Branch-Protection). Inviter une personne réelle (Settings → Collaborators and teams → Add people, rôle Write) ; **ensuite seulement** passer `required_approving_review_count` à 1 dans le ruleset. Tant que cette personne n'existe pas, ne pas toucher à ces réglages (§8).

---

## 8. Ce qui ne doit PAS être « corrigé » ni ajouté pour gagner un point

- **Signed-Releases** : pas de fichiers `.sig`/`.asc` factices ; ne pas renommer `.sha256` en `.sig` ; ne pas nommer le bundle `.intoto.jsonl` pour viser 10 sans provenance au format du générateur SLSA.
- **SAST** : pas de workflow CodeQL sans langage analysable, pas de `languages` hors sujet ; ne pas compter `upload-sarif` ; zizmor/actionlint sont utiles mais ne comptent pas — ne pas en ajouter pour Scorecard.
- **Fuzzing** : pas de harnais `atheris` plaqué sur des scripts ; les tests à propriétés `plausible` sont la pratique réelle, invisible de Scorecard.
- **Packaging** : pas de `docker push` ni de paquet factice (le contrôle est inconclusif, donc non pénalisant).
- **Code-Review / Branch-Protection** : pas de second compte ni de « relecteur » bot/IA ; pas d'acteur de contournement ; pas de `required_approving_review_count ≥ 1` tant que personne d'autre n'existe (le dépôt serait bloqué) ; `require_last_push_approval`, `dismiss_stale_reviews_on_push` et `require_code_owner_review` sont décoratifs à zéro approbation exigée ; pas de `CODEOWNERS` d'un seul propriétaire pour le score.
- **Contributors** : ne pas modifier les champs « Company » des profils ni ajouter de contributeurs.
- **License** : ne pas réécrire `LICENSE.md` en licence unique ; le dépôt est réellement sous deux licences.
- **Maintained** : pas de commits ni de tickets artificiels.
- **Security-Policy** : ne pas toucher au texte de `SECURITY.md` (déjà complet) ; seul le fichier de règles homonyme gêne.
- **Dependency-Update-Tool / Token-Permissions / Pinned-Dependencies** : ne pas retirer `bump-lean.yaml` ni Dependabot ; ne pas affaiblir un contrôle (`.claude/rules/project.md`).
- **CII** : ne pas répondre « Met » sans preuve ; ne pas viser silver/gold sans second contributeur.

---

## 9. Plan de vague 2 : fichiers à modifier (propriétaire unique par fichier)

| Fichier | Changement | Propriétaire suggéré |
|---|---|---|
| `.claude/rules/security.md` → `.claude/rules/assurance.md` (`git mv`) | I1 | session principale (zone `.claude/`) |
| `scripts/claude-session-start.sh` | I3 : URL elan épinglée au commit `227caca…`, commentaire sur la limite (binaire non vérifié) | `scorecard-specialist` |
| `.github/workflows/codeql.yaml` (nouveau) | I4, **si décision** | `scorecard-specialist` / `security-assurance-specialist` |
| `.github/workflows/release.yaml` | I2 : `id` sur `actions/attest`, téléverser le bundle `.sigstore.json` | `supply-chain-release-specialist` seul |
| `.github/workflows/bump-lean.yaml` | O2 | `supply-chain-release-specialist` seul |
| `CHANGELOG.md` (`[Unreleased]`) | une ligne par changement notable | session principale (écrivain unique) |
| `docs/security/workstreams/scorecard/{CHANGES,VALIDATION}.md` | traçabilité | `scorecard-specialist` |

Non modifiés : `.github/workflows/scorecard.yaml` (conforme), `SECURITY.md`, `README.md` (badge O4 à confier à qui possède le README), `spec/`, `src/`, `tests/`.

**Validation** : (1) `scorecard --local <worktree>` (binaire reproductible) sur les contrôles fondés sur les fichiers ; (2) la CI GitHub est la seule voie de validation Lean/CI (`ci.yaml` ne tourne que sur PR / `main` / dispatch) ; (3) relire le journal du job `Scorecard` après fusion pour les scores distants (§1.1). Aucun `lake build/test/lint` n'est nécessaire pour ces fichiers ; il serait faux d'affirmer qu'ils ont été exécutés.

---

## 10. Chevauchements avec les autres domaines

- `supply-chain-release-specialist` : C1 (elan/`lean-action`), I2 (`release.yaml`), O2 (`bump-lean.yaml`), absence de test de release, cache `actions/cache` de `.lake/packages` restauré dans le job qui alimente le PDF attesté (`verify.yaml:86-90,138-142`) — **Hypothèse** à évaluer.
- `github-governance-specialist` : ruleset (O1, 7.3), tags (7.4), environnements/secrets (7.6), réglages d'Actions (7.8), alertes (7.9), incohérence O5.
- `cii-specialist` : 3.4/7.2 ; le critère « static_analysis » interagit avec la décision SAST (I4) et avec les contrôles propres au projet (`lake lint`, audit des axiomes).
- `security-assurance-specialist` : décision CodeQL ; cohérence du renommage `security.md` avec ses règles.
- `quality-reproducibility-specialist` : fiabilité du classifieur `scripts/ci/impact.py` (3.3) ; test de release.
- Risque de collision d'écriture : `CHANGELOG.md`, `release.yaml`, `README.md` (§9).

---

## 11. Frontière `spec/`, `src/`, sémantique

Aucune action proposée ne touche `spec/`, `src/`, `tests/` ni la sémantique du langage. À signaler : une release `spec-v*` est le seul vecteur de « release » actuel ; toute modification du contenu ou de la version du manuscrit relève de l'accord de l'auteur et de `spec/CHANGELOG.md` + `CITATION.cff`, hors de ce domaine. La procédure « Publier une version » de `CONTRIBUTING.md` devra être mise à jour si `release.yaml` change (I2).

---

## 12. Non vérifié, et pourquoi

- Score publié sur `api.scorecard.dev` et page du visualiseur : proxy 403.
- État détaillé du badge CII 15239 au-delà de « InProgress » : proxy 403 sur `www.bestpractices.dev`.
- Interrogation OSV réelle en local : `api.osv.dev` refusé ; le « 0 vulnérabilité » est celui du run distant.
- Alertes de code scanning, alertes Dependabot, secret scanning, environnements, secrets, réglages `actions/permissions*`, collaborateurs, second facteur : endpoints bloqués ou hors de portée.
- Type et portée de `BUMP_TOKEN`, `ZENODO_TOKEN`, `ZENODO_ENV` : non lisibles.
- Exécution réelle de `release.yaml` (aucun run existant) : le comportement d'attestation/téléversement/Zenodo est **PREPARED**, non VERIFIED.
- Aucune exécution de `lake build`, `lake test`, `lake lint`, `reuse lint`, `actionlint` : toolchain et outils absents ; non nécessaire pour cet audit.
- Le SHA du commit elan (`227caca…`) vient du proxy de modules Go ; à reconfirmer au moment de la modification.
- Effet exact d'un workflow CodeQL sur le score distant (check-runs d'applications) : arithmétique issue du code, non observée.
