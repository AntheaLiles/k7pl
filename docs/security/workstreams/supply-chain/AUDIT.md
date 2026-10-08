<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Audit — chaîne d'approvisionnement et publication (vague 1)

| | |
|---|---|
| Rôle | `supply-chain-release-specialist` (relance après interruption 429) |
| Date | 6 octobre 2026 |
| Base auditée | `origin/main` = `b5f6146` (worktree `worktree-agent-af1c7bb62304dc137`) |
| Nature | **Audit uniquement.** Aucun fichier de `.github/`, `spec/`, `src/`, `tests/`, `scripts/` modifié ; pas de commit. |
| Statuts | VERIFIED · PARTIAL · PREPARED · HUMAN ACTION REQUIRED · BLOCKED · FUTURE · N/A. « ESTIMÉ » = non vérifié par une commande ou un fichier lu ici. |
| Distinction | Chaque point sépare **fait observé** (commande ou `fichier:ligne`), **interprétation**, **décision proposée**, **hypothèse**, **action restante** (règle `.claude/rules/documentation.md`). |

Les pistes laissées dans le scratchpad par d'autres agents (`sc-*`, `actions/`, `repro/`, `zizmor*.json`…) n'ont servi que de pistes :
tout ce qui est repris ci-dessous a été re-lu ou re-exécuté (scripts `scA-*` du scratchpad).

## 0. Synthèse

1. **La chaîne de publication de la spécification n'a jamais fonctionné de bout en bout, et le `release.yaml` actuel ne peut pas fonctionner dans la configuration actuelle du dépôt.**
   La seule release (`spec-v0.0.0-alpha.1`) est *immuable*, sans asset ; son seul run (ancien workflow « Lean Build ») a échoué au job `zenodo` ; `release.yaml` n'a aucun run (§3.1).
   Deux défauts indépendants bloquent l'étape « joindre le PDF » : (a) `gh release upload` vise une release **déjà publiée** donc immuable (assets ni ajoutables, ni remplaçables, ni supprimables, d'après la documentation GitHub) ; (b) le job `publish-spec` n'a ni `checkout` ni `GH_REPO` : `gh` échoue hors dépôt git (reproduit localement).
2. **Il n'existe aujourd'hui aucune procédure de vérification d'un artefact** (aucun artefact publié, aucune attestation d'artefact). Il existe seulement une **attestation de release GitHub** sur le tag (lien tag → commit, signée par GitHub, sans asset) (§4).
3. **Les épinglages sont réels et corrects** : 18 actions tierces épinglées sur SHA de 40 hex, chaque commentaire de version résolu en amont et identique ; 14 révisions de `lake-manifest.json` en SHA 40 hex, cohérentes avec les manifestes amont ; Tectonic vérifié par SHA-256 (§3.2, §3.6, §3.4).
4. **Ce qui n'est pas épinglé est ce que les actions composites et les scripts téléchargent à l'exécution** : elan (script sur `master`, binaire `latest`, aucune vérification d'empreinte), toolchain Lean, binaires `actionlint` (`latest`), `gitleaks`, `lychee`, images Docker par tag, bundle TeX de Tectonic (alias mutable hors GitHub). Aucun n'est vérifié par empreinte ; seul le blast radius (jobs en `contents: read`) limite le risque (§3.3–3.4).
5. **Le PDF n'est probablement pas reproductible bit à bit** (indice : tailles d'artefacts `spec-pdf` différentes pour deux builds de `main` aux entrées `spec/` identiques, alors que `spec-tex` a une taille identique) ; l'attestation seule ne permet donc pas la vérification indépendante par reconstruction (§3.7).
6. **Zenodo** : l'état (`zenodo-state`) n'existe pas ; la première exécution créera un *nouvel* enregistrement, donc un nouveau DOI de concept, sans lien démontré avec le DOI `10.5281/zenodo.23040451` affiché dans `README.md`/`CITATION.cff`. L'origine de ce DOI et des SWHID n'est pas établie par le dépôt (§3.9).
7. **Mesures à valeur réelle** (§6–7) : flux « tag → build → release brouillon + assets + attestation → publication humaine → Zenodo » ; contrôle que le tag est sur `main` ; secrets dans des *environments* ; séparation build / ouverture de PR dans `bump-lean.yaml` ; hook de session sans `curl | sh` sur `master` ; contrôle de cohérence du manifeste Lake. **Décoratif** : SBOM maison, cosign en plus d'`actions/attest`, SLSA L3 revendiqué, checksum présenté comme signature (§9).

## 1. Périmètre, méthode, limites

**Lu en entier** : `.github/workflows/*.yaml` (9 fichiers), `.github/workflows/README.md`, `.github/dependabot.yml`, `scripts/claude-session-start.sh`, `scripts/bump-lean.sh`, `scripts/latest-lean-version.sh`, `scripts/sync_zenodo.py`, `scripts/requirements-zenodo.txt` (structure), `lakefile.lean`, `lake-manifest.json`, `lean-toolchain`, `zenodo.json`, `zenodo.files.json`, `CITATION.cff`, `CONTRIBUTING.md` (§ release), `SECURITY.md`, `scripts/ci/impact.py`.
**Interrogé** (lectures publiques `gh api`/`git ls-remote`, `GH_TOKEN` retiré) : releases, tags, runs, artefacts, ruleset, API d'attestations, tags amont des actions, manifestes amont, sources amont à SHA fixé (actions composites, elan, Mathlib `Cache/`, Tectonic 0.15.0, `gh`).
**Exécuté** : `pip download --require-hashes` (hashes Zenodo), `zizmor 1.30.1 --offline` (persona `regular` puis `auditor`), reproduction du `grep -Eq` de `ci.yaml`, calcul de SHA-256 (Tectonic, elan, gh).

**Limites d'environnement (proxy)** : refusés — `zenodo.org`, `doi.org`, `archive.softwareheritage.org`, `relay.fullyjustified.net` (bundle TeX), `tuf-repo-cdn.sigstore.dev`, `tuf-repo.github.com`, `tmaproduction.blob.core.windows.net` (bundles d'attestations), `api.github.com` hors dépôt audité (`gh api repos/<autre>/…` → 403), `actions/permissions`, `hooks`, `immutable-releases` (réglage), `actions/caches`. Conséquences : **aucune vérification cryptographique d'attestation n'a pu être exécutée ici** (ni `gh release verify`, ni `gh attestation verify`, ni cosign) ; le réglage « immutable releases » du dépôt et les réglages Actions ne sont pas lisibles. Aucune toolchain Lean : **aucun** `lake build/test/lint` n'a été exécuté.

## 2. Chemin réel modélisé

Légende : **S** = intégrité de la source, **B** = du build, **P** = de la publication. Coût : S ≤ 1 h, M ≈ ½ journée, L > 1 j (ESTIMÉ).

| # | Maillon | Intégrité | Contrôle existant (preuve) | Défaut constaté | Risque réel (menace) | Mesure possible | Coût | Dépendance | Statut attendu |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Source → `main` | S | Ruleset « PR on main » (id 24138119) : PR obligatoire, `required_linear_history`, `deletion`, `non_fast_forward`, check requis `CI OK`, **aucun acteur de contournement** (`gh api repos/AntheaLiles/k7pl/rulesets/24138119`) | 0 approbation requise ; aucun commit signé ; un seul humain | Compte mainteneur compromis : fusion autonome possible (PR + CI) | Hors périmètre dépôt (2FA, clés d'accès) ; signature des commits **non** recommandée ici (§5) | — | Gouvernance | N/A (autre domaine) |
| 2 | Tag | S/P | Aucun contrôle de dépôt. Tag `spec-v0.0.0-alpha.1` **léger** (`git/ref/tags/…` → `type: commit`), non signé ; aucune règle de tag (une seule règle : `target: branch`) | Tag libre de création/déplacement/suppression **avant** publication ; rien ne vérifie que le commit tagué est sur `main` | Tag déplacé ou posé sur une branche non relue avant la publication de la release | (a) étape CI « le commit tagué est un ancêtre de `main` et `CI OK` y a réussi » ; (b) règle de tag `spec-v*`, `v*` (création/mise à jour/suppression restreintes) | S + S | (b) réglage GitHub | PREPARED (a) / HUMAN ACTION REQUIRED (b) |
| 3 | Tag → release | P | **Release immuable** (`immutable: true`, `gh api repos/…/releases`) ; attestation de release GitHub présente (§3.7) | Procédure documentée (CONTRIBUTING.md:90) = « créer la release », donc publication immédiate ; incompatible avec l'ajout d'assets après coup | Release modifiée après coup : **déjà bloquée par GitHub** (tag + assets verrouillés) | Brouillon → assets → publication (§6) | M | Réglage immuabilité (HUMAN) | PREPARED |
| 4 | Build : outils | B | `lean-toolchain` = `leanprover/lean4:v4.34.0` ; Tectonic 0.15.0 + SHA-256 (`verify.yaml:190-207`) | elan = script `master` + binaire `latest`, **sans empreinte** ; toolchain Lean téléchargée sans vérification d'empreinte dans elan (grep) ; bundle TeX = alias mutable hors GitHub, non épinglé | Action ou hôte amont compromis → code exécuté dans le job de build du PDF | Hors hook : épingler elan (version + SHA-256, TOFU) ; contrôler `lean --version` n'apporte rien (§9) | S–M | — | PARTIAL |
| 5 | Build : dépendances Lake | B | `lake-manifest.json` : 14/14 `rev` en 40 hex, = pins des manifestes amont (§3.6) | `@ "v4.34.0"` = tag mutable, résolu par le manifeste ; rien dans la CI ne contrôle manifeste ↔ tag amont | PR de bump malveillante ou manifeste altéré (`rev` ou URL) non repérée à l'œil | Contrôle CI « `rev` 40 hex, URL dans une liste fermée, `rev` = tag pelé amont » | S | Réseau CI | PREPARED |
| 6 | Build : caches | B | Clé `lake-deps-<hash(manifeste, toolchain)>` sans `restore-keys` ; caches de PR confinés au ref de PR (doc GitHub) | Le build d'un tag restaure le cache de `main` (portée « branche par défaut ») ; contenu non vérifié (artefacts `.olean`) | Cache de `main` empoisonné (nécessite déjà l'exécution de code sur `main`) | Pas de cache pour les builds de release (`use_cache: false`), coût = build à froid (non mesuré) | S + coût CI | — | PREPARED |
| 7 | Artefact | B | `upload-artifact` `spec-pdf`, 90 jours (`verify.yaml:227-233`) | **Non reproductible** (indice §3.7) ; pas de `SOURCE_DATE_EPOCH` | Impossible de revérifier par reconstruction | `SOURCE_DATE_EPOCH` = date du commit + mesure par double build (domaine reproductibilité) | M | Domaine `quality-reproducibility` | FUTURE |
| 8 | Checksum | P | `sha256sum … > .sha256` dans `publish-spec` (`release.yaml:104-106`) | Somme calculée **dans le job qui publie** : même racine de confiance que le fichier | Aucun gain contre un attaquant qui remplace le PDF (il remplace aussi la somme) ; protège de la corruption | Le garder comme commodité (`sha256sum -c`), ne pas le présenter comme signature | — | — | VERIFIED (limité) |
| 9 | Provenance | B/P | `actions/attest` `1e69f48…` (v4.2.2), `subject-path: out/k7pl-spec.pdf`, permissions `id-token`+`attestations` (`release.yaml:108-111`) | **Jamais exécuté** ; build (`spec-pdf`, `verify.yaml`) ≠ job qui atteste (`publish-spec`) ; `artifact-metadata: write` superflu | Provenance liée au workflow `release.yaml@tag`, pas aux étapes de build réelles | Voir §3.7 ; retirer `artifact-metadata` ; joindre le bundle `.sigstore.json` à la release | S | — | PREPARED |
| 10 | Signature | P | Aucune signature distincte (l'attestation est une signature Sigstore keyless) | — | — | Aucune signature supplémentaire utile (§5) | — | — | N/A |
| 11 | GitHub Release | P | `gh release upload --clobber` (`release.yaml:113-116`) | **Ne peut pas réussir** : release publiée donc immuable ; pas de `GH_REPO`/`checkout` | Publication incomplète ; Zenodo jamais atteint (`needs: publish-spec`) | Flux brouillon (§6) | M | — | PREPARED |
| 12 | Zenodo | P | Secrets `ZENODO_TOKEN`, `ZENODO_ENV` ; `pip --require-hashes` (180 hashes, vérifiés) ; `persist-credentials: false` | État sur branche mutable `zenodo-state` (absente) ; jeton Git passé en argument ; `ZENODO_ENV` en secret avec repli silencieux sur `production` ; aucun lien tag/commit/empreinte dans l'enregistrement ; DOI publié irréversible | Doublon de DOI ; état altéré ; publication de test en production | Environment `zenodo` ; DOI de concept déclaré dans le dépôt ; refus si DOI déclaré et état absent ; vérification du PDF avant dépôt (§3.9) | M | Décision humaine sur le DOI | PREPARED / HUMAN ACTION REQUIRED |
| 13 | Publication HTML (GitHub Pages) | P | `ci.yaml:118-136` : le job `deploy-pages` (`pages: write`, `id-token: write`, environment `github-pages`) ne tourne qu'en `push` sur `main` après `CI OK` ; l'artefact vient du job `spec` (`upload-pages-artifact`), qui n'a aucune permission d'écriture ni OIDC | Séparation build / déploiement correcte ; pas d'attestation du site (non offerte par Pages) | Faible : même confiance que `main` | Aucune | — | — | VERIFIED (séparation) |

## 3. Constats détaillés

### 3.1 Release immuable et `release.yaml` (question prioritaire)

**Faits observés**

- `gh api repos/AntheaLiles/k7pl/releases` : une seule release, `spec-v0.0.0-alpha.1` (id 399137059), `immutable: true`, `draft: false`, 0 asset, `created_at` 2026-09-29T12:29:42Z (= date du commit tagué `dcd65a9` : pour une release, `created_at` est la date du commit, pas celle du brouillon), `published_at` 12:42:18Z, `target_commitish: main`, auteur `AntheaLiles`.
- `git ls-remote origin 'refs/tags/*'` : un seul tag, **léger** (aucune ligne `^{}`), → `dcd65a9` ; `gh api …/git/ref/tags/spec-v0.0.0-alpha.1` → `object.type = commit`. Commit `dcd65a9` : auteur « Claude », non signé (`%G?` = N), arbre git `87a0438631217b7c3b5aeacc868b2fa70e0fb480`.
- Run `36569899593` (workflow `.github/workflows/lean.yaml`, aujourd'hui supprimé, événement `release`) : `build` et `spec-pdf` ont réussi ; `zenodo` a échoué à sa première étape (« Check that the release matches CITATION.cff… ») ; `release-check` et `deploy-spec` ignorés. Aucune étape de dépôt Zenodo n'a donc été atteinte.
- `gh api repos/AntheaLiles/k7pl/actions/workflows/release.yaml/runs` → `total_count: 0`. Le `release.yaml` actuel **n'a jamais tourné**.
- `git ls-remote --heads origin` : pas de branche `zenodo-state`.
- Documentation GitHub (`content/actions/…`/`managing-releases-in-a-repository.md`, re-téléchargée, ligne 84) : « If you have enabled immutable releases for your repository, you cannot add, replace, or delete assets after a release is published, and you cannot move or delete its tag while the release exists. »
- Documentation « Immutable releases » : bonne pratique = brouillon → joindre tous les assets → publier ; la création d'une release immuable génère automatiquement une **attestation de release** (tag, SHA du commit, assets).
- Reproduit : `gh release view …` hors dépôt git, sans `GH_REPO` → `failed to run git: fatal: not a git repository`. Avec seulement `GITHUB_REPOSITORY` exporté, même échec ; avec `GH_REPO` la résolution passe.
- `release.yaml:7-9` (`on: release: types: [published]`), `:85-116` (`publish-spec` : `download-artifact` → `sha256sum` → `actions/attest` → `gh release upload … --clobber`), `:98-99` (aucun `checkout`), `:113-116` (seul `GH_TOKEN` en env).

**Interprétation**

- Dans l'ordre actuel, la release est *publiée par l'humain*, **puis** le workflow tente d'y ajouter le PDF. Si le réglage d'immuabilité est actif (il l'était le 29/09 : la release est `immutable`), l'upload est refusé par GitHub. Ce défaut est **structurel** : aucune variante de `release.yaml` déclenchée par `published` ne peut joindre des assets à une release immuable.
- Indépendamment, `publish-spec` échouerait aussi faute de dépôt git (`GH_REPO`) : défaut latent distinct, masqué parce que le workflow n'a jamais tourné.
- L'échec de `publish-spec` empêche `zenodo` de partir (`needs`) : c'est un échec *sûr* (rien d'irréversible n'est publié sur Zenodo si la release GitHub n'est pas complète) ; cet ordre est à conserver.
- `spec-v0.0.0-alpha.1` est définitivement une release sans artefact (tag et assets verrouillés). Aucune correction n'est possible sur cette release ; la première release utile sera une nouvelle version.
- La procédure écrite (`CONTRIBUTING.md:90`, « créer la release sur `main` avec le tag ») et `.github/workflows/README.md:106-108` décrivent un flux qui ne peut plus fonctionner tel quel.

**Décision proposée** (non implémentée ; arbitrage orchestrateur) — flux compatible, détaillé au §6 : poussée du tag → build → **release brouillon** avec PDF, somme et bundle d'attestation → attestation d'artefact → *publication humaine* du brouillon (la release devient immuable, attestation de release automatique) → job Zenodo déclenché par `release: published`, qui **télécharge les assets publiés** (pas de reconstruction) et les vérifie avant dépôt.

**Hypothèse à confirmer par l'humain** : que le réglage « Enable release immutability » est encore actif au niveau du dépôt (non lisible ici : `gh api repos/…/immutable-releases` → 403). Il ne s'applique qu'aux releases futures ; l'état `immutable: true` de la release existante est le seul indice observé.

**Statut** : le workflow actuel est **BLOCKED** (échec certain à l'étape d'upload) ; le flux cible est **PREPARED** (conception, rien d'écrit).

### 3.2 Épinglage des actions

**Faits observés** (`grep -rn 'uses:' .github/workflows` ; résolution de chaque commentaire de version par `git ls-remote --tags` avec déréférencement `^{}` : script `scratchpad/scA-verify-pins.sh`)

- Toute action tierce est référencée `owner/repo@<40 hex> # vX.Y.Z` : **18 actions distinctes, 0 non épinglée** (les 7 `uses: ./.github/workflows/…` sont locaux).
- Les 18 couples (SHA, tag du commentaire) **correspondent** au tag amont : `actions/checkout v7.0.1`, `upload-artifact v7.0.1`, `download-artifact v8.0.1`, `cache v6.1.0`, `setup-python v7.0.0`, `attest v4.2.2`, `upload-pages-artifact v5.0.0`, `configure-pages v6.0.0`, `deploy-pages v5.0.1`, `leanprover/lean-action v1.6.1`, `lycheeverse/lychee-action v2.9.0`, `raven-actions/actionlint v2.2.0`, `gitleaks/gitleaks-action v3.0.0`, `fsfe/reuse-action v6.0.0` (annoté), `wagoid/commitlint-github-action v6.2.1` (annoté), `peter-evans/create-pull-request v8.1.1`, `ossf/scorecard-action v2.4.4` (annoté), `github/codeql-action v4.38.2` (annoté). Aucun SHA « orphelin » (impostor-commit) : chaque SHA est la cible d'un tag amont.
- Les `uses:` imbriqués des actions composites lues sont eux aussi épinglés par SHA par leurs auteurs : `lean-action` → `actions/cache/{restore,save}@caa2961… # v5` ; `raven-actions/actionlint` → `actions/github-script@3a2844b… # v9.0.0`, `actions/cache@27d5ce7… # v5.0.5`.
- `zizmor 1.30.1 --offline --persona auditor` (exécuté ici) : aucun `unpinned-uses` ; les audits **en ligne** (`impostor-commit`, `known-vulnerable-actions`, `stale-action-refs`) n'ont pas pu tourner (pas de jeton valide).
- Dependabot : `github-actions` hebdomadaire groupé, `pip /scripts` mensuel (`.github/dependabot.yml`). Sans `cooldown` (`zizmor dependabot-cooldown`, 2 occurrences).

**Interprétation** : l'épinglage de 1er niveau est complet et exact. Il protège contre le déplacement d'un tag amont, pas contre un SHA déjà malveillant ni contre ce que l'action télécharge ensuite (§3.3). Sans `cooldown`, Dependabot proposera un SHA publié il y a quelques heures, fenêtre typique d'une compromission détectée a posteriori.

**Mesures** : `cooldown: default-days: 7` (ESTIMÉ : valeur à choisir) sur les deux écosystèmes — coût S, dépôt-local ; réglage « Require actions to be pinned to a full-length commit SHA » et liste blanche d'actions (Settings → Actions → General) — **HUMAN ACTION REQUIRED**, non lisible ici.

**Statut** : VERIFIED (épinglage) ; PREPARED (cooldown) ; HUMAN ACTION REQUIRED (politique GitHub).

### 3.3 Ce que les actions composites téléchargent à l'exécution

Sources lues **au SHA épinglé** (`raw.githubusercontent.com/<repo>/<sha>/…`, script `scratchpad/scA-fetch.py`).

| Action (job) | Téléchargement à l'exécution | Vérification d'intégrité | Blast radius |
|---|---|---|---|
| `leanprover/lean-action` (`impl`, `spec`, `bump`) | `scripts/install_elan.sh` : `curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \| sh -s -- -y --default-toolchain none`, puis binaire elan `latest` (voir §3.4) | **Aucune** (branche mutable, pas d'empreinte) | `impl`/`spec` : `contents: read` ; **`spec` produit le PDF attesté** ; `bump` : voir §3.10 |
| `lycheeverse/lychee-action` (`quick`) | `curl -sfLO …/lychee-v0.24.2…tar.gz` (version par défaut de l'action, fixe) | Aucune (pas de somme) | `contents: read`, mode `--offline` |
| `raven-actions/actionlint` (`security`) | binaire `actionlint` **`version: latest`** (défaut) depuis `github.com/rhysd/actionlint/releases` via `tool-cache`, + matcher JSON depuis `raw.githubusercontent.com` à la balise | Aucune | `contents: read` ; sa sortie conditionne `CI OK` |
| `gitleaks/gitleaks-action` (`security`) | binaire gitleaks 8.24.3 (défaut de `src/index.js`) depuis `github.com/zricethezav/gitleaks/releases`, mis en cache (`gitleaks-cache-…`) | Aucune | `contents: read` + `GITHUB_TOKEN` en env |
| `fsfe/reuse-action` (`reuse`) | image Docker construite à l'exécution : `FROM fsfe/reuse:6` (**tag mobile Docker Hub**, pas de digest) | Aucune | `contents: read` |
| `wagoid/commitlint-github-action` (`commitlint`) | `Dockerfile` construit à l'exécution : `FROM node:20.16.0-alpine3.20` (tag, pas de digest), `apk add git` (non épinglé), `npm ci --ignore-scripts` (lockfile : intégrité npm) | Partielle (npm) | `contents: read` |
| `ossf/scorecard-action` (`scorecard`) | `image: docker://ghcr.io/ossf/scorecard-action:v2.4.4` (**tag**, pas de digest) | Aucune côté dépôt | **`id-token: write` + `security-events: write`** |
| `peter-evans/create-pull-request` (`bump`) | action Node empaquetée, rien téléchargé | N/A | `BUMP_TOKEN` en entrée (§3.10) |
| `actions/*` (checkout, cache, artifacts, attest, pages) | actions Node empaquetées (`dist/`) | N/A (épinglées) | variable |

**Interprétation** : l'épinglage SHA ne couvre pas ces téléchargements. Les cas à enjeu réel sont (i) elan/toolchain dans le job `spec` (il construit le PDF attesté) ; (ii) l'image `scorecard-action` (jeton OIDC, mais éditeur de confiance et correctif non disponible côté dépôt : le `uses:` ne permet pas de forcer un digest). Les autres jobs n'ont que `contents: read` et aucun secret : l'enjeu est la **fiabilité du signal** (un contrôle pourrait être neutralisé), pas l'exfiltration.

**Mesures dépôt-locales** : `version:` fixe pour actionlint (+ vérification de somme impossible via l'action) ; remplacer lychee/actionlint par un téléchargement épinglé + `sha256sum -c` (même schéma que Tectonic) **seulement si** le gain est jugé utile — coût M, dépendance entretien des sommes. **Décision proposée** : ne traiter que (i) en priorité (§3.4) ; documenter le reste comme risque accepté.

**Statut** : PARTIAL (risque connu, non traité) ; FUTURE pour lychee/actionlint/Docker.

### 3.4 Téléchargements directs, toolchain, Tectonic

**Faits observés**

- `scripts/claude-session-start.sh:15-16` : `curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | sh -s -- -y --default-toolchain none`, sans somme, branche mutable. Enregistré comme hook `SessionStart` (`.claude/settings.json`, timeout 900 s) ; exécuté seulement si `CLAUDE_CODE_REMOTE=true` (sessions Claude Code web), donc **hors CI**, mais dans un bac à sable qui détient un accès en écriture au dépôt par le proxy Git.
- `elan-init.sh` de `master` (SHA-256 `a620ff16…bf53`, 9 823 octets, relu le 2026-10-06) télécharge `…/leanprover/elan/releases/latest/download/elan-<arch>.tar.gz` ; aucune vérification d'empreinte dans le script. Ce fichier est **identique octet pour octet** à celui du tag `v4.2.4` (dernier tag elan d'après `git ls-remote`). Mesure indicative (TOFU, pas une garantie amont) : `elan-x86_64-unknown-linux-gnu.tar.gz` v4.2.4 = `42b94d4244e8353142c456ec0e4ca6528fd898a6c604d4059f494e706e431f63` (5 MB, téléchargé le 2026-10-06T05:33Z).
- Recherche d'empreinte ou de signature dans les sources `master` d'elan (`elan-dist/src/{dist,download,manifestation}.rs`, `elan-utils/src/utils.rs`, `Cargo.toml`) : **aucune occurrence** de `sha256`, `hash`, `checksum`, `verify`, `signature`. Le toolchain `leanprover/lean4:v4.34.0` est résolu par nom de version via `release.lean-lang.org` et téléchargé en HTTPS. *Recherche par motif, non exhaustive* : ESTIMÉ = elan ne vérifie pas d'empreinte de toolchain.
- Tectonic : `verify.yaml:190-192` (`TECTONIC_VERSION: 0.15.0`, `TECTONIC_SHA256: dfb82876…6407`), `:199-210` (`curl --proto '=https' --tlsv1.2 …` puis `sha256sum --check --strict`). **Re-téléchargé indépendamment** (`tectonic@0.15.0/tectonic-0.15.0-x86_64-unknown-linux-musl.tar.gz`, 14 175 003 octets) : SHA-256 **identique** à la valeur du dépôt.
- Bundle TeX : `crates/bundles/src/lib.rs` de Tectonic au tag `tectonic@0.15.0`, l. 118-120 : URL par défaut `https://relay.fullyjustified.net/default_bundle_v{format_version}.tar` (hôte hors GitHub, alias par numéro de format). Le « digest » (`SHA256SUM`) est lu **dans le bundle lui-même** (`itar.rs`) pour la cohérence du cache, sans comparaison à une valeur du dépôt. Le job met en cache `~/.cache/Tectonic` avec une clé fixe et un `restore-keys` par préfixe (`verify.yaml:212-218`).
- `lake exe cache get` (`verify.yaml:93`, `bump-lean.yaml:62`, hook de session) : au rev Mathlib `5ed2965` (`Cache/Requests.lean`, `Cache/IO.lean`, relus), récupération par `curl` depuis le service de cache Mathlib (`https://cache.mathlib.org` par défaut), fichiers nommés par empreinte d'**entrée** ; aucune vérification de signature ni d'empreinte de **sortie** dans ces fichiers (recherche par motif) ; `curl` statique tiré de `leanprover-community/static-curl` si le `curl` système est trop ancien. N'est exécuté que dans `impl` (non requis pour le PDF : la bibliothèque `Spec` n'importe que `VersoManual`, `SpecExt`, `SpecBib` ; aucun `import Mathlib|K7pl|Cslib` dans `spec/` et `tools/`).
- Python : `scripts/requirements-zenodo.txt` — 5 paquets (`certifi`, `charset-normalizer`, `idna`, `requests`, `urllib3`), 180 `--hash=sha256`, installé avec `--require-hashes` (`release.yaml:160`). Exécuté ici : `pip download --require-hashes --no-deps --only-binary=:all: -r …` (CPython 3.11) → les 5 *wheels* téléchargées satisfont les hashes. CPython 3.13 (celui de la CI) non testé. Les scripts de CI (`controle.py`, `ci/impact.py`, `suivi.py`) n'importent que la bibliothèque standard.
- Autres téléchargements : aucun (recherche de `curl|wget|pip install|npm|…` hors `archives/` et `docs/recherche`).

**Interprétation**

- Le hook de session est le seul endroit où du **code distant mutable est exécuté** (`curl | sh` sur `master`) ; son effet n'est pas borné par `contents: read`. La mesure est dépôt-locale et peu coûteuse : télécharger l'archive d'une version d'elan fixée, vérifier une somme enregistrée dans le script, puis lancer l'installateur ; la somme est de type TOFU (aucune empreinte amont publiée n'a été trouvée) mais protège d'un remplacement ultérieur. Le gain est partiel : elan télécharge ensuite le toolchain sans vérification (ESTIMÉ).
- Le SHA-256 de Tectonic **défini dans le même dépôt** prouve : « l'archive que le job extrait est identique à celle examinée quand la somme a été enregistrée » (protection contre le remplacement ultérieur de l'asset, la corruption, un CDN altéré). Il ne prouve **ni** l'authenticité de cette première archive (pas de signature amont vérifiée), **ni** la sûreté du bundle TeX chargé ensuite. Quiconque peut modifier le workflow peut aussi modifier la somme : c'est un contrôle de dérive, pas d'authenticité.
- Le bundle TeX non épinglé est le maillon « dépendance externe non déterministe » le plus large du PDF : fontes, paquets et formats viennent d'un hôte tiers ; deux builds à des dates différentes peuvent produire des PDF différents à source égale (lien avec §3.7).

**Mesures**

| Mesure | Nature | Coût | Statut |
|---|---|---|---|
| Hook de session : version + somme d'elan, plus de `curl … master \| sh` | dépôt-locale (`scripts/claude-session-start.sh`) | S | PREPARED |
| Remplacer `leanprover/lean-action` (installation d'elan seule) par le même téléchargement épinglé dans `verify.yaml` (jobs `impl`/`spec`) | dépôt-locale | M | FUTURE (gain partiel, voir §9) |
| Épingler le bundle TeX (somme du `.tar` ou de `SHA256SUM`, bundle explicite) | dépôt-locale, **à mesurer** | M | FUTURE (hôte bloqué ici : impossible à valider) |
| Documenter dans `SECURITY.md` la liste des dépendances externes non épinglées (risque accepté) | doc | S | PREPARED |

**Statut** : PARTIAL.

### 3.5 Caches (`actions/cache`)

**Faits observés**

- `verify.yaml:86-90` (job `impl`) et `:138-142` (job `spec`) : cache de `.lake/packages`, clé `lake-deps-${{ hashFiles('lake-manifest.json', 'lean-toolchain') }}`, **sans `restore-keys`**. `:212-218` (job `spec-pdf`) : cache `~/.cache/Tectonic`, clé `tectonic-<os>-<version>-v1` + `restore-keys` par préfixe.
- Les jobs `impl` et `spec` partagent la **même clé** : le premier à enregistrer l'emporte.
- Documentation GitHub (`dependency-caching.md`, re-téléchargée, « Restrictions for accessing a cache ») : un run lit les caches de sa branche ou de son tag **et de la branche par défaut** ; les caches de deux tags différents ne sont pas partagés ; un cache créé par un run `pull_request` est limité au ref de fusion de la PR et ne peut pas être lu par la branche de base ; seuls `push`, `workflow_dispatch`, `repository_dispatch`, `delete`, `registry_package`, `page_build` et `schedule` peuvent écrire dans la portée de la branche par défaut.
- Un run déclenché par `release` a pour ref le **tag** : il lit donc les caches de `main` et enregistre les siens dans la portée du tag.
- `ci.yaml` ne se déclenche en `push` que sur `main` ; `full.yaml` en `schedule` ; `scorecard.yaml` en `push: main`. Aucun workflow ne s'exécute en `push` sur une branche quelconque.

**Interprétation**

- Le build du PDF d'une release restaure donc `.lake/packages` et le cache Tectonic **issus de `main`**, enregistrés par des runs post-fusion. Une PR ne peut pas les empoisonner (portée confinée) ; il faut déjà exécuter du code dans un run de `main` (action ou dépendance compromise) pour y planter un contenu. Le contenu du cache (artefacts `.olean` de Verso et subverso, arbres git) **n'est pas revérifié** à la restauration : il est supposé identique à un build à froid.
- Le cache `.lake/packages` est aussi alimenté par le job `impl`, après `lake exe cache get` (contenu issu du service de cache Mathlib, §3.4) ; ce contenu ne participe pas à la construction du PDF (`Spec` n'importe pas Mathlib) mais partage la clé et le répertoire.
- **Risque réel : faible** (prérequis = compromission préalable d'une exécution sur `main`) mais **sans contrôle** : le PDF attesté est construit avec un cache non maîtrisé à la restauration. ESTIMÉ : la construction à froid de `Spec` (Verso + dépendances) coûte plusieurs minutes de plus (non mesuré ; à titre de repère, le job `build` du run de septembre a duré ~6 min, sans que l'état du cache soit connu).

**Mesure** : paramètre d'entrée `use_cache` de `verify.yaml` (défaut `true`), passé à `false` par `release.yaml` pour `spec` et `spec-pdf` ; coût S (modification de `verify.yaml` et `release.yaml`) + temps de CI à mesurer. Le cache Tectonic doit alors aussi être désactivé pour la release (sinon le bundle vient du cache de `main`).

**Statut** : PARTIAL ; mesure PREPARED.

### 3.6 `lake-manifest.json`, `lakefile.lean`

**Faits observés**

- `lakefile.lean:46-53` : `require mathlib|cslib|verso from git "<url>" @ "v4.34.0"` (tag, mutable en principe).
- `lake-manifest.json` : 14 paquets, **14/14** `rev` = 40 hex ; trois directs (`mathlib`, `cslib`, `verso`, `inherited: false`) et onze hérités (`inputRev` = `main`, `master` ou `v4.34.0`). URL : `github.com/leanprover-community/*`, `github.com/leanprover/*`, `github.com/acmepjz/md4lean`.
- Les `rev` des trois dépendances directes **égalent** le tag amont déréférencé (`ls-remote --tags` ; `scratchpad/scA-verify-lake.sh`) : mathlib `5ed2965`, cslib `990e65a`, verso `cad4b63` ; de même `Cli` (`lean4-cli`, `e92c9f1`) pour `v4.34.0`.
- Les 8 + 5 + 9 entrées des manifestes de Mathlib, Verso et CSLib à leur rev épinglé sont **toutes** identiques aux `rev` correspondants du manifeste racine (`scratchpad/scA-manifests.py`) : les dépendances transitives héritent des pins de leurs amonts (pas de résolution de `main` au dernier `lake update`).
- `scripts/bump-lean.sh:26-35` réécrit `lean-toolchain` et les trois `@ "vX.Y.Z"`, validés par la regex `^v[0-9]+\.[0-9]+\.[0-9]+$` ; `lake update` résout ensuite les `rev`.
- Rien dans la CI ne contrôle manifeste ↔ tag amont ni la liste d'URL autorisées.

**Interprétation** : l'état actuel est sain et vérifiable. Le risque se situe lors d'un `lake update` (bump) : le contenu du manifeste dépend du réseau à cet instant et n'est relu que par l'humain (seul approbateur, 0 approbation requise). Un contrôle automatique rendrait la relecture de la PR de bump fiable. Le tag amont n'est pas sous contrôle du dépôt : un tag déplacé chez l'amont après le bump ne change pas le manifeste (le `rev` est épinglé), mais un bump réalisé *après* un déplacement malveillant l'embarquerait.

**Mesure** (dépôt-locale, S) : script de contrôle (exécuté dans `verify.yaml` job `quick`, ou dans `bump-lean.yaml` avant la PR) vérifiant (1) `rev` = 40 hex pour chaque entrée, (2) URL ∈ liste fermée (trois propriétaires), (3) pour chaque dépendance directe, `rev` = `ls-remote --tags <url> <inputRev>^{}`, (4) `lean-toolchain` = `leanprover/lean4:<même tag>`. Ne détecte pas une compromission *amont* du tag ; détecte une altération du manifeste dans la PR.

**Statut** : VERIFIED (état) ; PREPARED (contrôle).

### 3.7 Provenance (`actions/attest`) : ce qu'elle prouve et ne prouve pas

**Faits observés**

- `release.yaml:85-116` : le PDF est **construit** par le job `spec-pdf` du workflow réutilisable `verify.yaml`, transmis par l'artefact Actions `spec-pdf`, puis **téléchargé** dans `publish-spec`, qui calcule la somme, appelle `actions/attest` (`subject-path: out/k7pl-spec.pdf`, sans prédicat → provenance de build SLSA par défaut, d'après `README.md` de l'action au SHA `1e69f48`, tableau l. 53) et téléverse. Permissions du job : `contents: write`, `id-token: write`, `attestations: write`, `artifact-metadata: write`.
- README de l'action (l. 75-76, 147-151, 367-380) : `artifact-metadata: write` ne sert qu'à créer un *storage record*, émis seulement avec `push-to-registry: true` et pour des dépôts d'organisation. Ici `push-to-registry` est absent : la permission est **superflue**.
- **Aucune attestation d'artefact n'existe** (le workflow n'a jamais tourné). Il existe une **attestation de release** : `gh api repos/AntheaLiles/k7pl/attestations/sha1:dcd65a987eaa40a8ae4d3409688898a34a382296` → 1 attestation, `initiator: github`, bundle Sigstore v0.3 ; déclaration in-toto `…/release/v0.2` : sujet `pkg:github/AntheaLiles/k7pl@spec-v0.0.0-alpha.1` (digest `sha1:dcd65a98…`), prédicat `{tag: spec-v0.0.0-alpha.1, repository: AntheaLiles/k7pl, repositoryId: 1393364239, ownerId: 120063455, databaseId: 399137059}` ; certificat « GitHub, Inc. / Attester » (émetteur « Fulcio Intermediate l1 », valide du 2026-06-12 au 2027-06-12), SAN `https://dotcom.releases.github.com` ; 1 horodatage RFC 3161, 0 entrée Rekor. Contenu **lu** (décodé), chaîne de confiance **non validée** ici (§1).
- `gh release verify spec-v0.0.0-alpha.1 -R AntheaLiles/k7pl` : gh 2.89.0 **et** 2.102.0 (dernière version amont, SHA-256 comparé à `gh_2.102.0_checksums.txt`) répondent « no attestations for tag … (sha1:dcd65a98…) ». `GH_DEBUG=api` montre : liste d'attestations → HTTP 200, puis 4 tentatives de téléchargement du bundle sur `tmaproduction.blob.core.windows.net`, sans réponse (hôte refusé par le proxy). **Le message est trompeur : l'échec vient de l'environnement, pas du dépôt** (le code de `gh` renvoie « no attestations » pour toute erreur de récupération). La vérification `gh release verify` reste donc à rejouer hors de ce bac à sable.
- Scorecard `Signed-Releases` (source v5.5.0 relue, `docs/checks/internal/checks.yaml:668-676`) : cherche, dans les assets des dernières releases, des fichiers `*.minisig`, `*.asc`, `*.sig`, `*.sign`, `*.sigstore`, `*.sigstore.json`, `*.intoto.jsonl` ; « ne vérifie pas les signatures » ; ignore les archives de code source. Les attestations stockées par GitHub **ne sont pas des assets de release** : invisibles pour ce contrôle.

**Ce que prouverait l'attestation d'artefact** (après `gh attestation verify … --signer-workflow AntheaLiles/k7pl/.github/workflows/release.yaml --source-ref refs/tags/<tag>`) : *le fichier de SHA-256 X a été attesté par une exécution du workflow `release.yaml` de AntheaLiles/k7pl, au ref `refs/tags/<tag>` et au commit C, sur un runner GitHub (identité OIDC signée par Sigstore, horodatée)*. Dépôt public → instance Sigstore « public good » (ESTIMÉ, d'après la documentation GitHub).

**Ce qu'elle ne prouve pas**

1. Que X ait été produit **à partir des sources de C** par les étapes décrites : le job qui atteste (`publish-spec`) n'est pas celui qui construit (`spec-pdf`) ; le fichier transite par le magasin d'artefacts de la même exécution. Tout code exécuté plus tôt dans la même exécution (compilation Lake de Verso et dépendances, actions) peut produire ou substituer l'artefact ; l'attestation décrit « le workflow `release.yaml` » et non les étapes de build réelles.
2. L'absence de code malveillant dans les entrées du build (toolchain, Verso, bundle TeX, §3.3-3.5).
3. La **reproductibilité** (cf. ci-dessous) : un tiers ne peut pas reconstruire et comparer.
4. Que C ait été relu ou fusionné par le processus protégé (aucun contrôle « le tag est sur `main` » aujourd'hui, §2 ligne 2).
5. L'intention ou l'identité d'une **personne** : l'identité liée est un workflow, pas un mainteneur.
6. La justesse du contenu de la spécification.

**Reproductibilité du PDF (indice, ESTIMÉ)**

- `gh api repos/AntheaLiles/k7pl/actions/artifacts` : `spec-pdf` du run 37384681012 (`main`, `67cbe51`, ancien workflow « Lean Build ») = 1 491 048 octets ; du run 37385570730 (`main`, `b5f6146`, « CI ») = 1 491 043 octets ; du run PR 37384554736 (`f7ee13a`, commit absent du clone local) = 1 491 045 octets. Dans les trois, `spec-tex` = 536 326 octets et `spec-html` = 2 482 432 octets (identiques). `git diff --stat 67cbe51 b5f6146 -- spec tools biblio lakefile.lean lake-manifest.json lean-toolchain` : **vide**, soit entrées identiques entre les deux runs de `main`.
- Interprétation : les tailles sont celles d'archives zip d'artefacts (pas des PDF) ; pour des entrées TeX identiques, les PDF compressés diffèrent de quelques octets. **Indice que le PDF n'est pas reproductible bit à bit**, non concluant (les deux runs n'exécutent pas le même fichier de workflow ; contenu PDF non téléchargé : `GH_TOKEN` invalide, `gh run download` impossible). Source amont : Tectonic 0.15.0 accepte `SOURCE_DATE_EPOCH` et `-Z deterministic-mode` (`src/unstable_opts.rs:32-35`, relu) ; `verify.yaml` n'en définit aucun.
- Une piste d'un autre agent (`scratchpad/repro/hashes-A-r{1,2}-{tex,html-multi}.txt`) indique deux rendus consécutifs identiques pour TeX et HTML ; **non re-vérifiée** ici (même machine, même répertoire : ne démontre rien sur la reproductibilité inter-environnements) et sans compilation PDF.

**Mesures**

| Mesure | Nature | Coût | Statut |
|---|---|---|---|
| Retirer `artifact-metadata: write` de `publish-spec` | dépôt-locale | S | PREPARED |
| Joindre le bundle `actions/attest` (`bundle-path`) comme asset `k7pl-spec.pdf.sigstore.json` : vérification **hors ligne** (`gh attestation verify --bundle`) et visibilité Scorecard (effet de bord, pas un but) | dépôt-locale | S | PREPARED |
| Calculer la somme SHA-256 dans le job de **build**, la passer en sortie de job et la **recomparer** dans le job d'attestation | dépôt-locale | S | PREPARED (gain modeste : détecte une altération entre jobs hors prise de contrôle de la plate-forme) |
| `SOURCE_DATE_EPOCH` = date du commit, double build et comparaison de SHA-256 en CI | dépôt-locale ; **domaine `quality-reproducibility`** | M | FUTURE |
| Ne publier aucune affirmation SLSA/« reproductible » avant la première release attestée **et** vérifiée | doc | S | PREPARED |

**Statut** : PREPARED (mécanisme présent, jamais exécuté) ; vérification externe : HUMAN ACTION REQUIRED.

### 3.8 Releases `v*` (implémentation) : quel artefact aurait une utilité réelle ?

**Faits observés** : aucune release `v*` ; `lakefile.lean:42` déclare `version := v!"0.1.0"` ; l'implémentation est une bibliothèque Lean (`lean_lib K7pl`, l. 57) ; les seules cibles exécutables sont `mainTest` (pilote de tests, l. 70) et `spec` (générateur de la spécification, l. 95). Le job `implementation-verify` de `release.yaml` n'a aucune étape de publication d'asset. `gh` : `verify-asset` ne s'applique pas aux archives de code source auto-générées (documentation « Verifying the integrity of a release »).

**Interprétation (utilité pour l'utilisateur)**

- Un utilisateur de k7pl consomme le **code source** via Lake (`require k7pl from git "…" @ "vX.Y.Z"`), qui résout le tag en SHA dans *son* `lake-manifest.json`. Aucun binaire distribuable n'existe ; un paquet de fichiers `.olean` dépend de la toolchain et n'est pas portable.
- Ce qui lui sert vraiment : (1) que le tag `vX.Y.Z` **ne puisse plus être déplacé** → release immuable (déjà active, sans workflow) ; (2) qu'il puisse le vérifier : `gh release verify vX.Y.Z -R AntheaLiles/k7pl` (attestation de release générée automatiquement par GitHub, sans asset) ; (3) des notes de release tirées de `CHANGELOG.md`. Rien de plus n'est utile.
- Un SBOM n'apporterait rien : la liste exacte des dépendances (nom, URL, rev) est `lake-manifest.json` au tag, déjà lisible par machine.
- **Asymétrie** : le flux `v*` actuel (aucun asset à joindre) est **compatible** avec l'immuabilité ; seul le flux `spec-v*` est cassé. Mais la vérification de l'implémentation (`implementation-verify`) s'exécute **après** la publication : une release immuable déjà publiée ne peut plus être retirée si ce contrôle échoue. Avec des releases immuables, les contrôles bloquants doivent s'exécuter **avant** la publication (poussée du tag ou brouillon).

**Décision proposée** : aucun artefact pour `v*` ; déplacer les contrôles avant publication (mêmes déclencheurs que §6) ; publier les notes depuis `CHANGELOG.md`. **Statut** : PREPARED.

### 3.9 Zenodo

**Faits observés**

- `release.yaml:118-196` ; `scripts/sync_zenodo.py` ; `CITATION.cff:13` (`doi: "10.5281/zenodo.23040451"`) ; `README.md:11-13, 68-69` ; `CONTRIBUTING.md:90-99` ; `.github/workflows/README.md:123-125` ; `docs/tracking/DASHBOARD.md:181` (cite encore `lean.yaml`, job `zenodo` : documentation périmée).
- **Origine du DOI non établie par le dépôt** : le DOI figure dans `CITATION.cff` et `README.md` depuis le commit `05aa321` (2026-10-01), alors que le seul run de release (2026-09-29) a échoué *avant* toute étape Zenodo et que `zenodo-state` n'a jamais existé. Les badges Software Heritage et le « SWHID de la release » ont été ajoutés le 2026-10-05 par `61e916e` (auteur « Claude ») avec le message « Ce SWHID est celui de la release spec-v0.0.0-alpha.1 », **sans source ni contrôle**.
- Vérification partielle : `swh:1:dir:b81695cf…` (README l. 13) **≠** l'arbre git du tag (`git rev-parse dcd65a9^{tree}` = `87a04386…`). Les identifiants de répertoire SWH sont calculés comme des arbres git ; l'écart n'est donc pas un simple défaut de format. J'ai testé quatre enveloppes de type archive GitHub (`AntheaLiles-k7pl-dcd65a9`, nom long, `k7pl-spec-v0.0.0-alpha.1`, `k7pl-v0.0.0-alpha.1`) : aucune ne reproduit `b81695cf` (`scratchpad/scA-swh.py`). **Non concluant** (le contenu archivé par SWH est celui de l'enregistrement Zenodo, d'origine inconnue). Zenodo, doi.org et SWH sont refusés par le proxy : **non vérifiable ici**.
- `zenodo-state` : **absente** (`git ls-remote --heads origin`) → `sync_zenodo.py:187-193` : « First publication: new record » → nouveau dépôt Zenodo et **nouveau DOI de concept**.
- `ZENODO_ENV = os.getenv("ZENODO_ENV") or "production"` (`sync_zenodo.py:32`) : secret absent ou vide → **production** ; toute valeur autre que `sandbox` → production. C'est un secret (`release.yaml:173`) alors qu'il n'a rien de confidentiel : il est masqué dans les journaux, ce qui rend le mode invisible.
- État : lu depuis `origin/zenodo-state` **avant** l'usage du secret (`release.yaml:162-168`, sans authentification : `persist-credentials: false`), puis ses valeurs `conceptrecid`/`recid` sont interpolées dans des URL d'API (`sync_zenodo.py:96-111`) appelées avec `Authorization: Bearer $ZENODO_TOKEN` vers `zenodo.org` (hôte fixe par `BASE_URL`). La branche n'est couverte par aucune règle (le ruleset ne vise que la branche par défaut) ; ont `contents: write` : le job `zenodo`, `publish-spec`, le job `bump`, et `BUMP_TOKEN`.
- Écriture de l'état : `git -c "http.extraheader=AUTHORIZATION: bearer $GITHUB_TOKEN" push …` (`release.yaml:195`) : le jeton passe **en argument de commande** (visible dans la liste des processus du runner ; masqué dans les journaux). Le job entier porte `contents: write` (`:124-125`). Le push suit la publication Zenodo, non atomique : si le push échoue après la publication, l'état est perdu.
- `zenodo.json` : `related_identifiers` ne contient que l'URL générique du dépôt et celle de Pages ; ni tag, ni SHA de commit, ni empreinte du PDF, ni URL de la release ne sont inscrits dans l'enregistrement. `publication_date` = jour du build.
- Aucune vérification que le PDF déposé est celui de la release : `zenodo` retélécharge l'artefact `spec-pdf` indépendamment de `publish-spec` ; Zenodo renvoie une somme de fichier que le script ne contrôle pas.
- Un DOI publié est **irréversible**.

**Interprétation**

- Si le DOI `23040451` a été créé par l'**intégration GitHub native de Zenodo** (webhook sur publication de release) ou à la main, alors (a) l'enregistrement contient probablement l'archive de dépôt du tag, pas un PDF construit par la CI ; (b) si l'intégration native est encore activée, **chaque release à venir créera un second enregistrement** en plus de celui de la CI. Hypothèse **à confirmer** par l'humain ; aucun élément ici ne la confirme.
- La première exécution de la CI créerait un DOI de concept **différent** de celui affiché : situation de DOI doublon, non réparable après publication.
- Les affirmations « DOI », « SWHID de la release » du `README.md`/`CHANGELOG.md` ne sont **pas démontrées** par une preuve du dépôt (statut : hypothèse tant que le contrôle humain n'a pas eu lieu).

**Mesures**

| Mesure | Nature | Coût | Statut |
|---|---|---|---|
| Job Zenodo dans un *environment* `zenodo` : `ZENODO_TOKEN` en secret d'environnement, `ZENODO_ENV` en **variable**, validée (`production` ou `sandbox` exactement) ; environment limité aux tags `spec-v*` | dépôt (`environment:`) + **réglage GitHub** | S + HUMAN | PREPARED / HUMAN ACTION REQUIRED |
| DOI de concept **déclaré dans le dépôt** (relu en PR) à la place de `zenodo-state` ; refus de créer un enregistrement si un DOI est déjà déclaré sans état correspondant, sauf option explicite | dépôt-locale (`scripts/sync_zenodo.py`, `release.yaml`) | M | PREPARED (décision humaine sur le DOI d'abord) |
| Avant le dépôt : télécharger les assets de la release **publiée**, `gh release verify-asset` + `gh attestation verify` ; déposer ces octets-là | dépôt-locale | S | PREPARED |
| Inscrire tag, SHA du commit, empreinte du PDF et URL de la release dans les métadonnées Zenodo | dépôt-locale (`sync_zenodo.py`, `zenodo.json`) | S | PREPARED |
| Jeton hors argument de commande (variables `GIT_CONFIG_*`) ou suppression du push d'état | dépôt-locale | S | PREPARED |
| Vérifier l'enregistrement `23040451` et l'intégration GitHub de Zenodo (§8) | **humain** | S | HUMAN ACTION REQUIRED |

**Statut** : BLOCKED (jamais exécuté, dépend de l'étape d'upload) ; décision humaine requise avant toute première publication.

### 3.10 `bump-lean.yaml`

**Faits observés** (`bump-lean.yaml`, `zizmor --offline --persona auditor`)

- Job `bump` : `permissions: contents: write`, `pull-requests: write` (l. 22-24) pendant toute la durée (timeout 180 min).
- Le même job exécute du code amont : `scripts/bump-lean.sh --no-update "<tag>"` (l. 46), `lean-action` (installation d'elan, l. 48-56), puis `lake update`, `lake exe cache get`, `lake build`, `lake test` (l. 58-64). `lake update` évalue les `lakefile.lean` des révisions nouvellement résolues ; `lake build`/`lake test` exécutent le code de ces dépendances et du dépôt.
- `BUMP_TOKEN` n'est présent que dans les deux étapes suivantes (l. 66-75 : test non vide ; l. 77-94 : `peter-evans/create-pull-request` avec `token: ${{ secrets.BUMP_TOKEN }}`, `add-paths` limité à `lean-toolchain`, `lakefile.lean`, `lake-manifest.json`) : **sur la même machine virtuelle** que l'exécution du code amont.
- `${{ steps.version.outputs.latest }}` est interpolé dans un `run:` (l. 46) et dans `with:` de l'action (l. 82-86). La valeur est contrainte par `grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$'` (`scripts/latest-lean-version.sh:12-15`) puis par `bump-lean.sh:21` : **non exploitable en l'état** (zizmor : `template-injection`, gravité informationnelle, confiance faible).
- zizmor (auditor) : `secrets-outside-env` ×2 (l. 69, 81) ; `superfluous-actions` (l. 79 : `gh pr create` suffirait).
- Le jeton de la PR n'est utilisé que par l'action ; `GITHUB_TOKEN` n'est jamais passé en entrée → les deux permissions `write` du job sont **inutiles** (sauf si `BUMP_TOKEN` était absent).
- Portée de `BUMP_TOKEN` : **inconnue** (secret illisible). Le ruleset n'a aucun acteur de contournement : un PAT du propriétaire ne peut pas pousser directement sur `main` ; il peut en revanche créer des branches et des **tags** non protégés.
- Dernier run planifié : 2026-10-03T10:38Z, `success`. Aucune version plus récente n'existait probablement (étapes conditionnelles ignorées) : le chemin PAT n'a **pas été exercé** (ESTIMÉ).

**Interprétation** : le risque réel est un **amont compromis** (tag Lean/Mathlib/CSLib/Verso publié par un tiers, résolu automatiquement le 3 du mois) dont le code, exécuté sur la machine virtuelle qui détient ensuite le PAT, peut en altérer les entrées (fichiers de l'action sous `_work/_actions`, binaires du `PATH`) et exfiltrer `BUMP_TOKEN` ; ce jeton a au moins `contents: write` et peut créer tags et branches. La séparation build / ouverture de PR est **possible et peu coûteuse** : le PAT n'est alors jamais présent sur une machine ayant exécuté du code amont.

**Mesures**

| Mesure | Nature | Coût | Statut |
|---|---|---|---|
| Deux jobs : `build` (`contents: read`, aucun secret : bump, `lake update`, build, test ; **artefact** = les trois fichiers) puis `open-pr` (aucun code Lean ; télécharge l'artefact, valide qu'**exactement** ces trois fichiers diffèrent, exécute le contrôle de manifeste du §3.6, appelle `create-pull-request`) | dépôt-locale (`bump-lean.yaml`) | M | PREPARED |
| Passer `latest` par `env:` au lieu de l'interpoler dans `run:` | dépôt-locale | S | PREPARED (hygiène) |
| `BUMP_TOKEN` : PAT à granularité fine, limité à ce dépôt (Contents RW, Pull requests RW), expiration courte, stocké en secret d'**environment** `bump-lean` limité à `main` | **réglage GitHub** | S | HUMAN ACTION REQUIRED |
| Règle de tag `spec-v*`, `v*` (cf. §2 ligne 2) : limite ce qu'un PAT volé peut faire | **réglage GitHub** | S | HUMAN ACTION REQUIRED |

**Statut** : PARTIAL (aucune faille démontrée ; surface réelle, mesure peu coûteuse).

## 4. « Comment un utilisateur peut-il vérifier qu'un artefact provient de ce dépôt et de cette chaîne de build ? »

**Réponse : pour un artefact, cette procédure n'existe pas aujourd'hui.** Aucun artefact n'est publié (la seule release a 0 asset), aucune attestation d'artefact n'a été produite (`release.yaml` n'a jamais tourné) et le PDF n'est pas reproductible (§3.7). Les artefacts Actions `spec-pdf` (90 jours) ne sont ni attestés ni téléchargeables sans authentification : ce ne sont pas des artefacts de publication.

**Ce qui est utilisable aujourd'hui (source uniquement)**

| Commande | Ce qu'elle prouve | Ce qu'elle ne prouve pas |
|---|---|---|
| `gh release verify spec-v0.0.0-alpha.1 -R AntheaLiles/k7pl` | GitHub atteste (signature Sigstore de GitHub) que la release 399137059 du dépôt 1393364239 a été publiée avec le tag `spec-v0.0.0-alpha.1` au commit `dcd65a98…` et que ce tag est verrouillé (release immuable) | le contenu d'un artefact (il n'y en a pas), l'auteur humain, la chaîne de build |
| `git clone https://github.com/AntheaLiles/k7pl && git rev-parse spec-v0.0.0-alpha.1^{commit}` → doit afficher `dcd65a987eaa40a8ae4d3409688898a34a382296` | le tag local désigne le commit attesté | que le commit ait été relu |

Réserve : `gh release verify` **n'a pas pu être mené à son terme dans cet environnement** (hôte des bundles et dépôt TUF Sigstore refusés par le proxy, §3.7) ; l'API d'attestations répond bien (une attestation `release/v0.2`, contenu décodé), mais la validation cryptographique reste **à rejouer par un humain** (§8). Aucune procédure cosign n'a été testée (cosign absent).

**Procédure cible, utilisable dès la première release attestée** (à écrire dans `SECURITY.md` en vague 2, une fois testée) :

```
gh release verify       spec-vX.Y.Z -R AntheaLiles/k7pl
gh release download     spec-vX.Y.Z -R AntheaLiles/k7pl -p 'k7pl-spec.pdf*'
gh release verify-asset spec-vX.Y.Z k7pl-spec.pdf -R AntheaLiles/k7pl
gh attestation verify   k7pl-spec.pdf --repo AntheaLiles/k7pl \
    --signer-workflow AntheaLiles/k7pl/.github/workflows/release.yaml \
    --source-ref refs/tags/spec-vX.Y.Z
# hors ligne (bundle joint à la release) :
gh attestation verify   k7pl-spec.pdf --repo AntheaLiles/k7pl \
    --bundle k7pl-spec.pdf.sigstore.json \
    --signer-workflow AntheaLiles/k7pl/.github/workflows/release.yaml \
    --source-ref refs/tags/spec-vX.Y.Z
sha256sum -c k7pl-spec.pdf.sha256      # corruption seulement
```

(Options `--signer-workflow`, `--source-ref`, `--bundle`, `--predicate-type` : présentes dans `gh attestation verify --help` de gh 2.89.0 ; `--signer-workflow` doit désigner le workflow qui **appelle** `actions/attest` : il faut le mettre à jour si l'attestation est déplacée dans un autre fichier.)

Ce que cette procédure prouvera : (1) `verify-asset` — le fichier est exactement un asset enregistré par GitHub à la publication immuable de la release `spec-vX.Y.Z` ; (2) `attestation verify` — le fichier a été attesté par une exécution de `release.yaml` du dépôt `AntheaLiles/k7pl`, au ref `refs/tags/spec-vX.Y.Z`, sur un runner GitHub. Ce qu'elle ne prouvera **pas** : voir §3.7 (points 1 à 6). En particulier elle **ne prouve pas** que le PDF soit « celui que produirait un tiers à partir des sources » tant que la reproductibilité n'est pas mesurée.

## 5. Évaluation honnête des mécanismes

| Mécanisme | Utile ici ? | Pourquoi | Mesure dépôt-locale ou réglage GitHub | Statut |
|---|---|---|---|---|
| **Attestations d'artefact GitHub** (`actions/attest`) | **Oui** | C'est déjà du Sigstore « keyless » (certificat Fulcio lié à l'identité du workflow + journal de transparence pour un dépôt public) ; coût quasi nul ; vérifiable par un tiers avec `gh` | dépôt-locale ; rien à régler | PREPARED (jamais exécuté) |
| **cosign** en plus | **Non** (décoratif) | Duplique l'attestation, ajoute une seconde identité à vérifier, aucune nouvelle racine de confiance ; `cosign verify-blob-attestation` reste possible côté tiers sur le même bundle (non testé ici) | — | N/A |
| **Attestation de release** (releases immuables) | **Oui** | Automatique, gratuite : lie tag, commit et empreintes des assets ; bloque le déplacement du tag | **réglage GitHub** (déjà actif d'après `immutable: true`) | VERIFIED (existence) ; vérification crypto : HUMAN ACTION REQUIRED |
| **SLSA** | Partiellement | **Niveau réel aujourd'hui : aucun revendicable** (aucune provenance publiée). **Atteignable : Build L2** (GitHub : « artifact attestations by itself provides SLSA v1.0 Build Level 2 », `concepts/security/artifact-attestations.md`). **L3** exige un workflow réutilisable isolant le build de l'appelant : formellement atteignable, mais appelant et réutilisable sont ici dans le **même dépôt, même propriétaire** : l'isolation visée par L3 est nominale. Prérequis de L2 sincère : attestation produite par la plate-forme pour l'artefact construit dans la même exécution, **vérification imposée au consommateur** (`--signer-workflow`, `--source-ref`), provenance fidèle à la construction. Le volet « Source » de SLSA n'est pas satisfait (0 approbation, aucun commit signé) | dépôt-locale | FUTURE : ne rien afficher avant la 1re release vérifiée |
| **SBOM** | **Non, pour l'instant** | Les entrées réelles du PDF : toolchain Lean, paquets Lake (= `lake-manifest.json`, déjà machine-lisible et versionné), Tectonic 0.15.0 + somme, **bundle TeX non épinglé**, actions. Un SBOM généré à la main ne ferait que reformuler le manifeste et risquerait d'afficher une exhaustivité fausse (interdit par `.claude/rules/security.md`). Aucun générateur standard ne comprend Lake | — | FUTURE si un consommateur en fait la demande |
| **Releases immuables** | **Oui** | Verrouille tag et assets, supprime la classe « release modifiée après coup » ; coût : irréversibilité (une erreur = nouvelle version, tag non réutilisable) et ordre imposé (brouillon → assets → publication) | **réglage GitHub** + flux §6 | PREPARED |
| **Tags signés** (`git tag -s`, SSH ou GPG) | Faible, non nulle | Authentifie une *intention humaine* par une clé détenue hors GitHub, différente de la racine « GitHub / OIDC » ; ne signe pas les commits (sur les 69 commits de `main` : 49 de « Claude », 19 de « Cyprien PIERRE », 1 de dependabot ; `git log --format=%G?` = `N` pour les 69). Valeur réelle seulement si un tiers connaît la clé par un canal **extérieur au dépôt** (ORCID, site, notice Zenodo). Nécessite une clé gérée par l'humain (jamais par une session d'agent) | action humaine | FUTURE, optionnel ; **ne pas** exiger dans la CI tant qu'aucun tag n'est signé |
| **Checksum SHA-256** | Commodité | Détecte la corruption ; n'authentifie rien (calculé et publié par le même job) | dépôt-locale | VERIFIED (limité) |

**Mesures dépôt-locales vs réglages GitHub** — dépôt-locales : flux de release, contrôle « tag ∈ `main` », `use_cache: false`, contrôle du manifeste Lake, séparation du bump, hook de session, Zenodo (état, vérification, métadonnées), `cooldown` Dependabot, documentation. Réglages GitHub (**HUMAN ACTION REQUIRED**, non lisibles ici) : immuabilité des releases, règle de tag, environments `zenodo` / `bump-lean`, politique Actions (SHA obligatoire, liste d'actions), PAT, intégration GitHub de Zenodo.

## 6. Flux de release compatible avec l'immuabilité (proposition, rien n'est écrit)

**Principe** : tout ce qui doit être joint à la release l'est **avant** la publication ; tout contrôle bloquant s'exécute **avant** la publication ; l'irréversible (publication immuable, DOI) vient en dernier et par un geste humain.

```
git tag [-s] spec-vX.Y.Z && git push origin spec-vX.Y.Z        (humain)
  └─ release.yaml  (on: push: tags: spec-v*, v*)
       1. check        contents: read   métadonnées (CITATION.cff, CHANGELOG), tag ∈ ancêtres de main,
                                         check « CI OK » réussi sur ce SHA
       2. verify       contents: read   verify.yaml (spec_build / lean_build), use_cache: false
       3. draft        contents: write, id-token: write, attestations: write
                       download spec-pdf → sha256 → actions/attest → bundle .sigstore.json
                       gh release create TAG --draft --verify-tag --notes-file <extrait CHANGELOG>
                           [--prerelease] k7pl-spec.pdf .sha256 .sigstore.json     (GH_REPO défini)
  (humain) relit le brouillon, rejoue `gh attestation verify` en local, publie  → release immuable + attestation de release
       └─ zenodo.yaml (on: release: published, spec-v* seulement)
            environment: zenodo ; contents: read
            gh release download → gh release verify-asset → gh attestation verify → sync_zenodo.py
```

**Ce que cela change**

- **Déclencheurs** : `release: published` ne sert plus qu'au job Zenodo ; la construction part du **push du tag** (le ref de la provenance reste `refs/tags/<tag>`, ce qui permet `--source-ref`). Un `workflow_dispatch` en **mode essai** (construction et contrôles, sans attestation ni brouillon) permet de tester le flux sans artefact permanent. Variante écartée comme voie principale : `workflow_dispatch(version)` + `--target <sha>` (le tag serait créé par GitHub à la publication, non signé, provenance rattachée à `refs/heads/main`).
- **Permissions** : les jobs qui exécutent du code Lean/TeX restent en `contents: read` ; seule l'étape de brouillon porte `contents: write`, `id-token: write`, `attestations: write` (et plus `artifact-metadata`). Le job Zenodo n'a plus besoin de `contents: write` (plus de branche d'état) : `contents: read`. Un brouillon créé avec `GITHUB_TOKEN` ne déclenche pas de workflow ; la publication par l'humain déclenche `release: published` (comportement décrit par la documentation GitHub des événements, **non testé** ici : ESTIMÉ).
- **Job Zenodo** : il ne reconstruit plus rien ; il dépose **les octets de l'asset publié**, après `verify-asset` et `attestation verify`. L'état (`zenodo-state`) disparaît au profit d'un identifiant de concept déclaré dans le dépôt (§3.9) ; le DOI de **concept** (stable) est celui à citer dans `CITATION.cff`, parce que le DOI de **version** n'existe qu'après la release.
- **Tags** : une règle de tag (`spec-v*`, `v*` : création, mise à jour, suppression restreintes) protège la fenêtre « tag poussé / release non publiée », seule période où le tag est déplaçable (réglage GitHub). Un tag erroné non publié se supprime ; **après publication**, il est verrouillé et son nom n'est plus réutilisable.
- **Documents à aligner** (vague 2) : `CONTRIBUTING.md` (procédure « pousser le tag, relire le brouillon, publier »), `.github/workflows/README.md`, `SECURITY.md` (procédure de vérification du §4). `docs/tracking/DASHBOARD.md:181` cite encore `lean.yaml` (hors de mon périmètre).

**Pré-requis avant toute première release** (décisions humaines, §8) : élucider le DOI `23040451` et l'intégration GitHub de Zenodo ; confirmer que l'immuabilité est active ; faire une répétition (brouillon supprimé, Zenodo *sandbox*) ; la porte P6 de `docs/tracking/DASHBOARD.md:155` prévoit une décision explicite pour la première version publiée.

**Statut** : PREPARED (conception). Non testé : la création d'un brouillon avec assets puis sa publication sur ce dépôt n'a pas pu être essayée (aucune écriture en vague 1) ; le comportement « upload sur release immuable publiée = refus » repose sur la documentation GitHub, **non reproduit** (HTTP exact non observé).

## 7. Écarts classés

### Critiques (la publication de la spécification est inopérante ou irréversiblement ambiguë)

| ID | Écart | Preuve | Mesure | Statut |
|---|---|---|---|---|
| C1 | `release.yaml` ne peut pas joindre le PDF : upload vers une release publiée donc immuable ; en plus `gh` sans `GH_REPO`/`checkout` | §3.1 (`release.yaml:98-116`, doc GitHub l. 84, reproduction locale) | Flux brouillon (§6) | BLOCKED → PREPARED |
| C2 | Zenodo : première exécution = nouveau DOI de concept sans lien avec `10.5281/zenodo.23040451` ; origine du DOI et des SWHID inexpliquée ; publication irréversible | §3.9 (`zenodo-state` absente, commit `05aa321`, `61e916e`, arbre `87a04386…` ≠ `b81695cf…`) | Décision humaine d'abord (§8, H2) ; puis DOI déclaré dans le dépôt + refus si état absent | HUMAN ACTION REQUIRED |

### Importants

| ID | Écart | Preuve | Mesure | Statut |
|---|---|---|---|---|
| I1 | Aucun contrôle « tag ∈ `main` » ni « CI OK sur ce SHA » ; aucune règle de tag | §2 ligne 2 (un seul ruleset, `target: branch`) | Étape `check` + règle de tag (réglage) | PREPARED / HUMAN |
| I2 | `bump-lean.yaml` : PAT présent sur la machine qui exécute du code amont ; permissions `write` inutiles | §3.10 | Séparer `build` / `open-pr` ; environment | PREPARED |
| I3 | Secrets `ZENODO_TOKEN`, `ZENODO_ENV`, `BUMP_TOKEN` hors *environment* (zizmor `secrets-outside-env` ×4) ; `ZENODO_ENV` : secret masqué avec repli sur `production` | §3.9, §3.10 | Environments + variable validée | PREPARED / HUMAN |
| I4 | Hook `SessionStart` : `curl … elan/master/elan-init.sh \| sh` (code distant mutable, sandbox avec écriture) | `scripts/claude-session-start.sh:15-16` | elan versionné + somme | PREPARED |
| I5 | PDF attesté construit avec caches de `main` non revérifiés, bundle TeX non épinglé, sortie probablement non reproductible | §3.4, §3.5, §3.7 | `use_cache: false` en release ; `SOURCE_DATE_EPOCH` + double build (domaine reproductibilité) | PARTIAL |
| I6 | Provenance : le job qui atteste n'est pas celui qui construit ; bundle non joint (pas de vérification hors ligne) ; `artifact-metadata: write` superflu | §3.7 | Somme transmise et recomparée ; bundle en asset ; retrait de la permission | PREPARED |
| I7 | Documentation qui décrit comme acquis un flux jamais exécuté (`.github/workflows/README.md:106-108`, `CONTRIBUTING.md:90-99`, README « DOI », « SWHID de la release », `CHANGELOG.md`) | §3.1, §3.9 | Aligner après décision humaine ; marquer « non vérifié » en attendant | PREPARED |
| I8 | Contrôles de release exécutés **après** publication (`implementation-verify`) alors qu'une release immuable ne se retire pas | §3.8 | Déplacer avant publication | PREPARED |
| I9 | Zenodo : état sur branche mutable lue avant usage du secret, jeton Git en argument de commande, aucune vérification que le PDF déposé = PDF publié, aucun lien tag/commit/empreinte dans l'enregistrement | §3.9 | Voir tableau de mesures §3.9 | PREPARED |

### Opportunistes

| ID | Écart | Mesure | Statut |
|---|---|---|---|
| O1 | Dependabot sans `cooldown` (2 écosystèmes) | `cooldown: default-days` | PREPARED |
| O2 | `bump-lean.yaml:46` interpolation dans `run:` (non exploitable : regex) | passage par `env:` | PREPARED |
| O3 | `ci.yaml:57` : `grep -Eq` avec `\\.` dans une chaîne entre apostrophes : le motif exige une barre oblique inverse littérale ; **reproduit** (`scratchpad/scA-regex.sh`) : ne reconnaît pas `lakefile.lean`, `lake-manifest.json`, `.github/dependabot.yml`, `scripts/sync_zenodo.py`, `scripts/requirements-zenodo.txt` (reconnaît `lean-toolchain`, `.github/workflows/`, `scripts/ci/`). **Sans effet aujourd'hui** : `scripts/ci/impact.py:14-22` (`FULL_EXACT`) force déjà la vérification complète pour ces chemins. Code mort trompeur, domaine CI | corriger ou supprimer le `grep` | FUTURE (autre domaine) |
| O4 | `actionlint` en `version: latest` ; images Docker par tag (`fsfe/reuse:6`, `node:20.16.0-alpine3.20`, `scorecard-action:v2.4.4`) | fixer la version d'actionlint ; documenter le reste en risque accepté | FUTURE |
| O5 | Politique GitHub « SHA obligatoire » et liste d'actions autorisées non vérifiables | réglage | HUMAN ACTION REQUIRED |
| O6 | `CHANGELOG.md:54` mentionne « LuaLaTeX » (le PDF est compilé par Tectonic, moteur XeTeX) ; `docs/tracking/DASHBOARD.md:181` cite `lean.yaml` | corrections documentaires | FUTURE (hors périmètre) |
| O7 | Remplacer `lean-action` (elan seul) par un téléchargement épinglé dans `verify.yaml` | gain partiel (toolchain non vérifiée par elan) | FUTURE |

## 8. Actions humaines (procédure exacte, comment vérifier)

| ID | Action | Où / commande | Comment vérifier |
|---|---|---|---|
| H1 | Confirmer que l'**immuabilité des releases** est active | *Settings → General → section Releases* : réglage d'immuabilité des releases (intitulé exact ESTIMÉ ; ne vaut que pour les releases **futures**) | `gh api repos/AntheaLiles/k7pl/releases --jq '.[0].immutable'` après la prochaine release = `true` ; avec un jeton administrateur : `gh api repos/AntheaLiles/k7pl/immutable-releases` |
| H2 | **Élucider le DOI `10.5281/zenodo.23040451`** avant toute exécution du job Zenodo | Ouvrir l'enregistrement sur zenodo.org : noter (a) DOI de concept vs de version (« Versions »), (b) fichiers déposés (archive GitHub du tag ou PDF), (c) « Related works », (d) mode de création ; *Zenodo → compte → GitHub* : l'interrupteur du dépôt `AntheaLiles/k7pl` est-il actif ? Décider : garder l'intégration native **ou** `sync_zenodo.py` (pas les deux : doublons) | Consigner la décision dans `docs/tracking/DECISIONS.md` ; test sur *sandbox* (`ZENODO_ENV=sandbox`) avant production |
| H3 | **Contrôler le SWHID du README** | Ouvrir `https://archive.softwareheritage.org/swh:1:dir:b81695cfdce2e418f8a8431b79e8894ee7310c50` ; comparer au contenu du tag (`git ls-tree dcd65a9`, arbre `87a0438631217b7c3b5aeacc868b2fa70e0fb480`) | Si l'identifiant ne désigne pas le contenu du tag, retirer ou corriger la mention « SWHID de la release » (`README.md:13`, `CHANGELOG.md:20-21`) |
| H4 | **Rejouer la vérification cryptographique** de l'attestation de release | Depuis une machine sans restriction réseau, gh ≥ 2.89 : `gh release verify spec-v0.0.0-alpha.1 -R AntheaLiles/k7pl` | Sortie attendue : « Release spec-v0.0.0-alpha.1 verified! » (`gh` imprime sujets et empreintes) ; une erreur « no attestations » **depuis le bac à sable** n'est pas probante (§3.7) |
| H5 | Créer les **environments** `zenodo` et `bump-lean` | *Settings → Environments → New environment* ; `zenodo` : restreindre aux tags `spec-v*`, secret `ZENODO_TOKEN`, **variable** `ZENODO_ENV`, relecteur = le mainteneur (geste volontaire) ; `bump-lean` : restreindre à `main`, secret `BUMP_TOKEN` | `gh api repos/AntheaLiles/k7pl/environments` (jeton administrateur) ; un run de branche qui référence l'environnement est refusé |
| H6 | **Remplacer le PAT** `BUMP_TOKEN` par un PAT à granularité fine | *Settings → Developer settings → Fine-grained tokens* : dépôt unique, Contents RW, Pull requests RW, expiration ≤ 90 jours ; révoquer l'ancien | `workflow_dispatch` de *Bump Lean* quand une version plus récente existe : la PR est créée et la CI normale démarre |
| H7 | **Règle de tag** | *Settings → Rules → Rulesets → New tag ruleset* : motifs `spec-v*`, `v*` ; restreindre mise à jour et suppression (création libre) ; contournement : administrateur du dépôt (pour supprimer un tag non publié) | `gh api repos/AntheaLiles/k7pl/rulesets --jq '.[]\|{name,target}'` ; tester sur un tag jetable (jamais sur `spec-v0.0.0-alpha.1`) |
| H8 | Politique Actions | *Settings → Actions → General* : exiger l'épinglage par SHA complet, limiter les actions autorisées | Une PR contenant `uses: x/y@v1` échoue au démarrage |
| H9 | **Répétition** du flux de release | Tag d'essai sur *sandbox* Zenodo, brouillon supprimé sans publication | Le brouillon contient les trois assets ; `gh attestation verify --bundle …` réussit en local ; le tag d'essai est supprimé (impossible après publication) |
| H10 | (Optionnel) tags signés | Clé de signature SSH propre au mainteneur, enregistrée comme *signing key* ; `git tag -s` | `git tag -v spec-vX.Y.Z` ; mention « Verified » sur GitHub |

## 9. Ce qui ne doit PAS être « corrigé » ou ajouté (décoratif ou faux signal)

- **cosign / signature « maison »** en plus d'`actions/attest` ; toute clé privée stockée dans un secret du dépôt.
- **SBOM** écrit à la main, ou attesté sans générateur ; **badge SLSA** ; mention « reproductible » ; revendication SLSA L3 (appelant et réutilisable dans le même dépôt).
- Présenter `k7pl-spec.pdf.sha256` comme une signature ou une preuve d'authenticité.
- Tenter de « réparer » `spec-v0.0.0-alpha.1` (supprimer/recréer la release, y ajouter un PDF) : tag non réutilisable, DOI/SWHID déjà cités.
- Vérifier `lean --version` (hash de commit) pour « valider » le toolchain : un binaire malveillant peut mentir.
- `dependency-review-action` pour Lake (ESTIMÉ : le graphe de dépendances GitHub ne lit pas `lake-manifest.json`).
- Remplacer des SHA par des tags, ou ajouter des tags de version à côté des SHA.
- Imposer `require_code_owner_review`, un CODEOWNERS bloquant ou ≥ 1 approbation : avec un seul mainteneur, cela bloque tout ou impose un contournement ; relève de la gouvernance, pas de la chaîne d'approvisionnement.
- Appliquer sans vérification la suggestion `zizmor self-repository` (`$/…` à la place de `./…`, 7 occurrences) : aucun gain de sécurité, syntaxe non vérifiée pour Actions/actionlint.
- Désactiver les caches de la CI de PR (seul le build de release est concerné).
- Modifier `README.md` (DOI, SWHID) ou `CITATION.cff` sans la décision H2/H3.

## 10. Fichiers que je voudrais modifier en vague 2

| Fichier | Nature | Collision probable |
|---|---|---|
| `.github/workflows/release.yaml` | refonte : déclencheur de tag, `check`, brouillon, permissions, `GH_REPO` | scorecard / governance / security-assurance (permissions, environments) |
| `.github/workflows/zenodo.yaml` (**nouveau**, ou job séparé) | déclenché par `release: published`, environment `zenodo` | idem |
| `.github/workflows/verify.yaml` | entrée `use_cache`, somme SHA-256 en sortie de job, éventuellement `SOURCE_DATE_EPOCH` | **reproductibilité**, CI/qualité (fichier partagé) |
| `.github/workflows/bump-lean.yaml` | séparation `build` / `open-pr`, `env:`, environment | governance (PAT/environments) |
| `.github/dependabot.yml` | `cooldown` | governance / scorecard |
| `scripts/claude-session-start.sh` | elan épinglé + somme | — |
| `scripts/sync_zenodo.py` | DOI déclaré, refus fail-closed, validation `ZENODO_ENV`, métadonnées tag/SHA/empreinte | — |
| `scripts/ci/check-manifest.*` + test (**nouveaux**) | contrôle du manifeste Lake | CI (`scripts/ci/` force la vérification complète) |
| `zenodo.json` | `related_identifiers` versionnés (release, tag) | — (voir frontière §12) |
| `CONTRIBUTING.md` | procédure « pousser le tag, relire le brouillon, publier » | **cii / governance** |
| `SECURITY.md` | procédure de vérification (§4), dépendances externes non épinglées | **cii / governance / security-assurance** |
| `.github/workflows/README.md` | releases, intégrité, Zenodo | **tous** |
| `docs/security/workstreams/supply-chain/{CHANGES,VALIDATION}.md` | prévus par la définition de l'agent | — |

**Ne seront pas touchés par moi** : `README.md`, `CITATION.cff`, `CHANGELOG.md`, `spec/**`, `src/**`, `tests/**`, `docs/tracking/**` (décisions humaines ou frontière).

## 11. Contradictions et chevauchements avec les autres domaines

- **Scorecard** : `Signed-Releases` ne reconnaît que des *assets* (`*.sigstore.json`, …) : le bundle d'attestation joint à la release sert à la fois la vérification hors ligne (utilité réelle) et ce contrôle ; je le recommande **pour l'utilité**, pas pour le score. `Pinned-Dependencies` : `curl | sh` dans `scripts/claude-session-start.sh` est probablement signalé (ESTIMÉ) ; `Token-Permissions` : `contents: write` au niveau du job dans `bump`, `publish-spec`, `zenodo`.
- **Gouvernance GitHub** : règle de tag, environments, PAT, immuabilité, politique Actions, intégration Zenodo : réglages listés au §8, à arbitrer par `github-governance-specialist`.
- **Sécurité** : zizmor (`secrets-outside-env`, `template-injection`, `dependabot-cooldown`, `excessive-permissions` sur `scorecard.yaml:16`) : mêmes constats, pas de divergence.
- **Reproductibilité / qualité** : reproductibilité du PDF, `SOURCE_DATE_EPOCH`, double build, caches : je ne fais que **signaler** l'indice (§3.7) ; la mesure leur revient.
- **CII** : critères sur les releases signées et les constructions reproductibles : ne rien déclarer avant les preuves du §4.
- **CI** : `ci.yaml:57` (O3).
- **Contradiction documentaire** : `.github/workflows/README.md:106-110` et `CONTRIBUTING.md:90-99` décrivent un flux qui ne peut pas fonctionner (§3.1) ; `README.md`/`CHANGELOG.md` présentent DOI et SWHID comme acquis (§3.9).

## 12. Points touchant `spec/`, `src/` ou la sémantique (frontière)

- Rien dans cet audit ne modifie ni ne propose de modifier `spec/`, `src/`, `tests/`. La publication Zenodo est la **publication du manuscrit** : son déclenchement relève de l'auteur (« ne rien modifier sans l'accord de l'auteur » ; porte P6, `docs/tracking/DASHBOARD.md:155`).
- Le contrôle de release lit `spec/CHANGELOG.md` (section `## [X.Y.Z]`) : tout changement de ce fichier est une décision de l'auteur.
- **À signaler à `consistency-auditor` et à l'auteur (spec ↔ Lean ; non tranché)** : `zenodo.json` (description : « chaque exemple de code est compilé contre l'implémentation de référence ») et `CITATION.cff` (abstract : « vérifiée par Lean 4 contre son implémentation de référence (Mathlib, CSLib) ») affirment un lien spécification ↔ implémentation. Dans ce que j'ai lu, `spec/` et `tools/` n'importent que `VersoManual`, `SpecExt`, `SpecBib` : **aucune référence à `K7pl`, `Mathlib` ou `Cslib`** (`grep`). Ces métadonnées seront figées de façon irréversible par Zenodo ; leur exactitude n'est pas établie par ce que j'ai observé. Je ne propose aucune modification.
- L'attestation du PDF ne dit **rien** de la vérité des énoncés de la spécification (§3.7, point 6).

## 13. Ce que je n'ai pas pu vérifier, et pourquoi

| Point | Raison | Statut |
|---|---|---|
| Validité cryptographique des attestations (`gh release verify`, `gh attestation verify`, cosign) | TUF Sigstore, `tuf-repo.github.com` et le stockage des bundles (`tmaproduction.blob.core.windows.net`) refusés par le proxy ; cosign absent | NON VÉRIFIABLE DEPUIS CETTE SESSION → HUMAN ACTION REQUIRED (H4) |
| Réglage « immutable releases » du dépôt ; politique Actions ; environments ; webhooks (dont Zenodo) ; permissions du jeton par défaut | `403` du proxy ou jeton non administrateur | HUMAN ACTION REQUIRED (H1, H5, H8) |
| Contenu et provenance de l'enregistrement Zenodo `23040451`, SWHID | `zenodo.org`, `doi.org`, `archive.softwareheritage.org` refusés | HUMAN ACTION REQUIRED (H2, H3) |
| Comportement exact d'un upload sur release immuable publiée (code HTTP) | aucune écriture autorisée en vague 1 ; repose sur la documentation GitHub | ESTIMÉ (fort) |
| Reproductibilité réelle du PDF | bundle TeX (`relay.fullyjustified.net`) refusé ; PDF d'artefact non téléchargeable (jeton invalide) ; pas de toolchain Lean exécutée | ESTIMÉ (indice §3.7) |
| Le job `publish-spec` échoue-t-il sans `GH_REPO` **en Actions** ? | reproduit hors Actions seulement (`gh` hors dépôt git, avec `GITHUB_REPOSITORY` exporté) | ESTIMÉ (fort) |
| Audits zizmor en ligne (`impostor-commit`, `known-vulnerable-actions`, `stale-action-refs`) ; avis de sécurité des actions épinglées | jeton invalide, API hors dépôt refusée | NON VÉRIFIÉ |
| Portée et expiration de `BUMP_TOKEN`, valeur de `ZENODO_ENV` | secrets illisibles | HUMAN ACTION REQUIRED (H5, H6) |
| `lake build`, `lake test`, `lake lint`, `reuse lint` | aucune toolchain Lean ; hors périmètre d'un audit | N/A (aucune exécution revendiquée) |
| Hashes `requirements-zenodo.txt` pour CPython 3.13 | testé en 3.11 uniquement | PARTIAL |
| Absence de vérification d'empreinte dans elan et dans le client de cache Mathlib | recherche par motif, non exhaustive | ESTIMÉ |

## Annexe — commandes reproductibles (lectures, sans écriture)

```
# épinglage des actions et du manifeste (scripts dans le scratchpad de la session)
bash scratchpad/scA-verify-pins.sh        # 18 couples SHA/tag : MATCH
bash scratchpad/scA-verify-lake.sh        # 4 tags amont v4.34.0 : MATCH
python3 -I scratchpad/scA-manifests.py    # revs transitives = pins amont : SAME
# release, tag, attestation
unset GH_TOKEN
gh api repos/AntheaLiles/k7pl/releases --jq '.[]|{tag_name,immutable,draft,assets:(.assets|length)}'
gh api repos/AntheaLiles/k7pl/git/ref/tags/spec-v0.0.0-alpha.1 --jq .object.type          # commit : tag léger
gh api repos/AntheaLiles/k7pl/attestations/sha1:dcd65a987eaa40a8ae4d3409688898a34a382296  # attestation de release
gh api repos/AntheaLiles/k7pl/actions/workflows/release.yaml/runs --jq .total_count         # 0
gh api repos/AntheaLiles/k7pl/rulesets/24138119                                             # ruleset de main
git ls-remote --heads origin zenodo-state                                                   # vide
# autres
zizmor --offline --persona auditor .github/workflows .github/dependabot.yml
pip download --require-hashes --no-deps --only-binary=:all: -r scripts/requirements-zenodo.txt -d <dossier vide>
```
