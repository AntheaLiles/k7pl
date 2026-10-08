<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Changements — chaîne d'approvisionnement et publication (vague 2)

| | |
|---|---|
| Rôle | `supply-chain-release-specialist`, vague 2 (implémentation) |
| Date | 6 octobre 2026 |
| Base | `origin/main` = `b5f6146` ; travail dans le worktree `worktree-agent-ad2592aa4e624c884`, commits locaux, **ni push ni PR** |
| Source des décisions | `AUDIT.md` (même dossier) §3.1, §3.4, §3.9, §3.10, §4, §6, §10 ; `docs/security/OPENSSF-ROADMAP.md` §1 et actions R1, R3, R4, R6, R8, R12 |
| Statuts | `VERIFIED` · `PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE` |
| Lecture | Faits observés, interprétations, décisions, hypothèses et actions restantes sont séparés (règle `.claude/rules/documentation.md`). Les validations sont dans `VALIDATION.md`. |

**Aucun workflow modifié ici n'a été exécuté sur GitHub** : aucun tag, aucune release, aucun dispatch, aucun appel Zenodo, aucun `lake` sur le dépôt. Les workflows sont donc `PREPARED`, jamais « testés de bout en bout ». Les scripts Python et la logique shell des étapes ont, eux, été exécutés hors ligne (voir `VALIDATION.md`).

## 1. Commits

| Action | Commit | Contenu |
|---|---|---|
| R12 | `46d737a` | `.github/dependabot.yml` : `cooldown: default-days: 7` pour `github-actions` et `pip` |
| R8 | `58ea019` | `scripts/claude-session-start.sh` : elan v4.2.4 par archive + SHA-256, plus de `curl … master \| sh` |
| R4 | `723a799` | `.github/workflows/bump-lean.yaml` en deux jobs ; `scripts/ci/check_manifest.py` + `test_check_manifest.py` |
| R1 + R6 | `d87ebd8` | `.github/workflows/release.yaml` : flux compatible avec les releases immuables, contrôle « tag sur `main` et `CI OK` » |
| R3 | `4deacdf` | `.github/workflows/zenodo.yaml` (nouveau), `scripts/sync_zenodo.py`, `scripts/ci/test_sync_zenodo.py` |
| — | (ce commit) | `CHANGES.md` et `VALIDATION.md` |

Fichiers modifiés : uniquement ceux du périmètre. Aucun fichier de `spec/`, `src/`, `tests/`, `.claude/`, `docs/suivi/`, ni `ci.yaml`, `verify.yaml`, `zenodo.json`, `zenodo.files.json`, `lakefile.lean`, `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CHANGELOG.md`, `.github/workflows/README.md`.

## 2. R1 + R6 — `release.yaml`

**Constat de départ (AUDIT §3.1).** Le workflow se déclenchait sur `release: published`, donc après la publication ; une release publiée est immuable : l'ajout du PDF ne pouvait pas réussir. Le job `publish-spec` n'avait en outre ni dépôt git ni `GH_REPO`. Le workflow n'avait jamais tourné.

**Flux implémenté.**

```
(humain)   git tag spec-vX.Y.Z && git push origin spec-vX.Y.Z      (ou vX.Y.Z)
release.yaml
  check              contents: read, checks: read
  verify-spec        verify.yaml (spec_build, use_cache: false)       tags spec-v*
  verify-implementation  verify.yaml (lean_build, use_cache: false)   tags v*
  draft              contents: write, id-token: write, attestations: write   tags spec-v* seulement
(humain)   relire le brouillon, rejouer `gh attestation verify`, publier
zenodo.yaml         release: published, spec-v* seulement (§3)
```

| Élément | Décision |
|---|---|
| Déclencheurs | `push` de tags `spec-v*` et `v*` ; `workflow_dispatch` (entrées `kind` et `version`) = **essai** : mêmes contrôles et même build, jamais de brouillon, d'attestation ni d'écriture (`dry_run` vaut toujours `true` pour un dispatch) |
| Permissions | `permissions: {}` en tête ; chaque job déclare les siennes, chaque permission élevée est commentée ; **pas** `artifact-metadata` (superflu, AUDIT §3.7) ; `create-storage-record: false` ajouté à `actions/attest` pour que cela reste vrai si le défaut de l'action change |
| Concurrence | `release-<ref>` par tag, sans annulation |
| `check` | `fetch-depth: 0`, `persist-credentials: false` ; version dérivée du tag et validée (`X.Y.Z` ou `X.Y.Z-pré.version`) ; mêmes contrôles de métadonnées qu'avant (`lakefile.lean` + `CHANGELOG.md` pour `v*`, `CITATION.cff` + `spec/CHANGELOG.md` pour `spec-v*`) avec une section de changelog **non vide** ; le tag n'a pas bougé (`refs/tags/<tag>^{commit}` = `GITHUB_SHA`) ; le commit est ancêtre de `origin/main` ; un check run `CI OK` réussi **émis par GitHub Actions** existe sur ce SHA (API `commits/<sha>/check-runs`) |
| Valeurs `github.*` | toutes passent par `env:` ; aucune n'est interpolée dans un `run:` |
| `draft` | ne s'exécute qu'après `check` et `verify-spec` ; ne lance aucun code du dépôt ; refuse de continuer si une release (même brouillon) existe déjà pour le tag ; somme SHA-256 ; `actions/attest` (SHA épinglé déjà présent, `id: attest`) ; copie du `bundle-path` en `k7pl-spec.pdf.sigstore.json` ; `gh release create --draft --verify-tag` avec le PDF, la somme et le bundle ; `--prerelease` si la version contient un `-` ; `GH_REPO` défini ; **ne publie jamais** |
| Notes de release | section de `spec/CHANGELOG.md` extraite par le job `check` (lecture seule) et transmise par artefact `release-notes` ; le job `draft` y ajoute un bloc « Vérification » (commandes `gh` du §4 de l'audit, mention que la somme ne détecte que la corruption) |
| Tags `v*` | `check` + vérification, aucun artefact (AUDIT §3.8) ; l'humain crée la release ensuite |
| Épinglage | les SHA de 40 hex et leurs commentaires de version sont ceux déjà présents dans le dépôt (`checkout` v7.0.1, `download-artifact` v8.0.1, `upload-artifact` v7.0.1, `attest` v4.2.2) |
| `timeout-minutes` | présent sur `check` (10) et `draft` (15) ; **impossible** sur les jobs qui appellent `verify.yaml` (clé interdite pour un job `uses:`) : les délais sont ceux des jobs appelés |

**Écart au contrat d'interface.** `release.yaml` appelle `verify.yaml` avec `use_cache: false`, entrée qui n'existe pas encore dans le `verify.yaml` de ce worktree (propriété de l'agent qualité). Tant que l'entrée n'existe pas, `actionlint` signale `input "use_cache" is not defined` (deux occurrences) ; la validation complète a été faite contre une copie de scratch qui porte l'entrée (voir `VALIDATION.md`). **Ne pas fusionner `release.yaml` sans la modification correspondante de `verify.yaml`.**

**Limite à connaître (voir §7, H7).** Pour un tag poussé, GitHub exécute le workflow tel qu'il est **dans le commit tagué**. Les contrôles de `check` protègent contre l'erreur (tag déplacé, tag sur une branche non relue, CI non passée) ; ils ne résistent pas à quelqu'un qui peut pousser un tag sur un commit dont `release.yaml` a été modifié. Ce qui résiste : une règle de tag (création restreinte), l'environment protégé et la relecture humaine du brouillon. D'où H7. Même remarque pour `zenodo.yaml` : ses vérifications sont dans le workflow du commit tagué, et l'environment `zenodo` (H5) est la vraie barrière.

## 3. R3 — `zenodo.yaml` et `sync_zenodo.py`

**Constat de départ (AUDIT §3.9).** État sur une branche mutable `zenodo-state` (absente) ; `ZENODO_ENV` en secret avec repli silencieux sur la production ; jeton Git passé en argument de commande ; retéléchargement indépendant de l'artefact ; aucun lien tag/commit/empreinte dans l'enregistrement ; DOI du README d'origine non établie ; un DOI publié est irréversible.

### `zenodo.yaml` (nouveau)

| Élément | Décision |
|---|---|
| Déclencheur | `release: types: [published]`, job exécuté seulement si le tag commence par `spec-v` |
| Permissions | `contents: read` (workflow et job) ; plus de branche d'état, plus de `contents: write` |
| Environment | `zenodo` (secret `ZENODO_TOKEN`, variables `ZENODO_ENV` et `ZENODO_CONCEPT_RECID`) ; `concurrency: zenodo` fixe |
| Ordre | checkout → `setup-python` → `pip install --require-hashes -r scripts/requirements-zenodo.txt` (conservé) → `sync_zenodo.py --check-config` (échec **avant** tout téléchargement) → cohérence `CITATION.cff` / `spec/CHANGELOG.md` → présence des sous-commandes `gh` nécessaires → `gh release download` (`GH_REPO` défini) → `gh release verify`, `gh release verify-asset`, `gh attestation verify --bundle … --signer-workflow <dépôt>/.github/workflows/release.yaml --source-ref refs/tags/<tag> --source-digest <SHA> --deny-self-hosted-runners`, `sha256sum --check` → **seulement alors** `sync_zenodo.py` |
| Rien n'est reconstruit | les octets déposés sont ceux qui viennent d'être vérifiés |
| Jetons | `GH_TOKEN` n'est fourni qu'aux étapes `gh` ; `ZENODO_TOKEN` qu'à l'étape de dépôt (et jamais imprimé : testé) |

### `sync_zenodo.py`

| Élément | Décision |
|---|---|
| Échec par défaut | avant **tout** appel réseau (testé : la doublure de `requests` n'enregistre aucun appel) : `ZENODO_ENV` différent exactement de `production`/`sandbox` (plus de repli) ; `ZENODO_CONCEPT_RECID` absent, vide ou ni entier strictement positif ni `NEW` ; `ZENODO_TOKEN` absent ; tag, SHA, dépôt ou URL de release mal formés ; plus d'un PDF (un concept = un document) ; aucun PDF |
| `ZENODO_CONCEPT_RECID` | entier : nouvelle version de ce concept ; `NEW` : création explicite d'un nouveau concept, avec rappel dans le résumé du job de renseigner la variable ensuite |
| Concept déclaré | l'enregistrement lu doit porter `conceptrecid` égal à la valeur déclarée (refus si l'on a saisi un identifiant de **version**) ; s'il ne peut pas être lu, **aucun** repli sur la création d'un enregistrement (comportement d'avant : repli silencieux) |
| Idempotence | si la dernière version du concept porte déjà l'identifiant lié à ce tag, refus (non demandé ; ajouté parce qu'un second dépôt est irréversible). Non applicable à `NEW`, qui ne doit donc jamais être rejoué |
| Identifiants dans les URL | tout identifiant venant de Zenodo est validé comme entier avant d'entrer dans une URL ; les liens des réponses (`latest_draft`, `record`) ne sont jamais suivis tels quels : hôte, schéma, chemin, absence de requête et de port sont contrôlés, puis seul l'entier est réutilisé (l'en-tête d'autorisation ne part donc pas vers un autre hôte) |
| Métadonnées à l'exécution | sans modifier `zenodo.json` ni `zenodo.files.json` : `related_identifiers` ajoutés (`…/tree/<tag>` `isSupplementTo`, `…/commit/<sha>` `isDerivedFrom`, URL de la release `isIdenticalTo`) ; notes complétées par l'empreinte SHA-256 du PDF, le dépôt, le tag et le commit ; `version` imposée par le tag |
| Somme renvoyée par Zenodo | comparée au fichier local **avant** publication quand l'API la fournit (MD5 ou SHA-256, préfixe `md5:` accepté) ; écart = refus ; absence ou format non reconnu = avertissement et mention « non vérifié » dans le résumé (jamais présentée comme vérifiée) |
| Après publication | le DOI est affiché dès la réponse de publication ; si la relecture de l'enregistrement échoue, le script rend compte de la réponse de publication au lieu d'échouer |
| État | plus de `.zenodo_state.json`, plus de branche `zenodo-state` ; les identifiants créés sont écrits dans `$GITHUB_STEP_SUMMARY` |
| Entrée supplémentaire | `--check-config` (valide l'environnement sans jeton ni réseau) |

**Décisions de conception à relire.**

- `ZENODO_TAG`, `ZENODO_COMMIT`, `ZENODO_REPOSITORY`, `ZENODO_RELEASE_URL` sont **obligatoires** (le script n'a plus de mode « sans provenance »). `ZENODO_VERSION` est facultatif et doit égaler le tag sans `spec-v`.
- Les relations choisies (`isSupplementTo`, `isDerivedFrom`, `isIdenticalTo`) appartiennent au vocabulaire DataCite ; leur acceptation par l'API Zenodo n'a pas pu être vérifiée (voir `VALIDATION.md` §6). Un refus de l'API intervient avant la publication.

## 4. R4 — `bump-lean.yaml` et `check_manifest.py`

**Constat de départ (AUDIT §3.10).** Le même job exécutait du code amont (`lake update`, `lake build`, `lake test`) puis détenait `BUMP_TOKEN` ; `contents: write` et `pull-requests: write` inutiles ; interpolation dans `run:`.

| Élément | Décision |
|---|---|
| `build` | `contents: read`, aucun secret ; version, `bump-lean.sh --no-update`, `lean-action` (installation d'elan), `lake update`, **contrôle précoce et consultatif** du manifeste, `lake exe cache get`, `lake build`, `lake test` ; livre **seulement** `lake-manifest.json` (artefact `lake-manifest`, 3 jours) |
| `open-pr` | `environment: bump-lean`, `contents: read`, **aucun code Lean** ; exige `BUMP_TOKEN` (message d'erreur explicite conservé) ; checkout propre ; valide `LATEST` et `CURRENT` (`vX.Y.Z`) ; **régénère** `lean-toolchain` et `lakefile.lean` avec `scripts/bump-lean.sh --no-update` ; télécharge le manifeste comme donnée non fiable (un seul fichier ordinaire) ; `check_manifest.py --check-tags` ; copie ; vérifie que **exactement** `lake-manifest.json`, `lakefile.lean`, `lean-toolchain` diffèrent (rien d'indexé, rien d'untracked) ; puis seulement `peter-evans/create-pull-request` avec `BUMP_TOKEN` |
| Interpolations | `steps.version.outputs.*` et `needs.build.outputs.*` passent par `env:` ; dans `with:` de l'action, seules des valeurs déjà validées sont utilisées |
| Permissions | `contents: read` au niveau du workflow et de chaque job ; le `GITHUB_TOKEN` n'écrit rien |
| Concurrence | `bump-lean`, sans annulation (demandée par le persona `auditor` de zizmor) |

### `scripts/ci/check_manifest.py` (stdlib seule)

*(Description de la vague 2 ; le contrôle a été durci par la « Vague 2 bis » du §11, qui prévaut.)* Contrôles : manifeste objet JSON de taille bornée et fichier ordinaire ; `packagesDir` = `.lake/packages` ; pour chaque paquet : `type` = `git`, nom unique, `rev` = 40 hex minuscules exactement, URL `https://github.com/<propriétaire>/<dépôt>` avec propriétaire dans `{leanprover-community, leanprover, acmepjz}`, sans identifiants, port, requête, fragment ni suffixe `.git` ; `lean-toolchain` = `leanprover/lean4:vX.Y.Z` ; `mathlib`, `cslib`, `verso` requis par `lakefile.lean` et épinglés sur la version du toolchain ; chaque `require … from git` du lakefile retrouvé dans le manifeste avec la même URL, le même `inputRev`, `inherited: false`. Avec `--check-tags` (réseau, **désactivé par défaut**, jamais exigé par les tests) : `rev` de chaque dépendance directe = commit du tag amont.

**Écart à la consigne, constaté par mesure.** La commande littérale `git ls-remote --tags <url> <inputRev>^{}` ne renvoie **rien** pour un tag léger. Les tags `v4.34.0` de Mathlib, CSLib, Verso et lean4-cli sont **légers** (vérifié : aucune ligne `^{}`). Le script interroge donc `refs/tags/<tag>` **et** `refs/tags/<tag>^{}` et compare avec la forme pelée si elle existe, sinon avec la référence elle-même.

`--check-tags` est **activé** dans le job `open-pr` (il détecte un manifeste modifié après résolution) ; il reste désactivé par défaut dans le script.

**Limites (non couvertes) — périmées sur les deux premiers points, voir §11.** Les 11 dépendances héritées (`inputRev` = `main`, `master`…) ne sont liées à aucun tag : un `rev` bien formé mais malveillant dans une organisation autorisée n'est pas détecté ; la relecture de la PR reste nécessaire. Les clés inconnues d'un paquet (`configFile`, `subDir`…) ne sont pas contrôlées. Un tag déplacé chez l'amont **avant** le bump n'est pas détecté.

## 5. R8 — `scripts/claude-session-start.sh`

| Élément | Décision |
|---|---|
| Installation | archive de la release GitHub `leanprover/elan` **v4.2.4** (dernier tag amont au 6 octobre 2026, vérifié par `git ls-remote`) ; somme SHA-256 enregistrée dans le script, vérifiée **avant** extraction ; seul le membre `elan-init` est extrait ; puis `elan-init -y --default-toolchain none` |
| Sommes | `x86_64-unknown-linux-gnu` : `42b94d4244e8353142c456ec0e4ca6528fd898a6c604d4059f494e706e431f63` ; `aarch64-unknown-linux-gnu` : `05febd124d84ebf994b2e7479922a5650b1e950c17ae3bd1ddd776b65bb72bf9` |
| Statut des sommes | **première observation (TOFU)**, dite comme telle dans le script : calculées ici par téléchargement HTTPS (deux fois chacune, résultats identiques) ; l'amont n'en publie pas. Elles détectent un remplacement ultérieur de l'asset, pas l'authenticité de la première archive ; qui peut modifier le script peut modifier la somme. La valeur x86_64 est **identique** à celle citée par l'audit (§3.4), ce qui confirme deux observations indépendantes, pas une garantie amont |
| Non couvert | elan télécharge ensuite le toolchain Lean sans vérification d'empreinte (constat de l'audit, par recherche de motif) |
| Erreurs | plateforme ou architecture sans archive épinglée, `sha256sum` absent, téléchargement en échec, somme différente : le hook n'exécute **aucun** code téléchargé, affiche le message d'origine (« rely on CI to build ») et sort avec 0 |

## 6. R12 — `dependabot.yml`

`cooldown: default-days: 7` pour `github-actions` et `pip` (7 jours : valeur à choisir, hypothèse de l'audit). Les mises à jour de sécurité ne sont pas retardées (comportement documenté par GitHub, non vérifié ici). Le schéma Dependabot n'a pas pu être validé par un outil ; voir `VALIDATION.md`.

## 7. Actions humaines et décisions de l'autrice

Les identifiants H1, H5, H6, H7 et H9 reprennent la numérotation de l'audit (§8) ; D1, D2, H11 et H12 sont nouveaux.

| ID | Action ou décision | Pourquoi |
|---|---|---|
| D1 | **Décider** de la valeur de `ZENODO_CONCEPT_RECID` : numéro du concept de `10.5281/zenodo.23040451` (si c'est un DOI de concept) **ou** `NEW` | L'origine du DOI du README n'est pas établie par le dépôt (AUDIT §3.9) ; le script refuse sans cette variable. Si l'identifiant saisi est celui d'une **version**, le script le refuse |
| D2 | Élucider si l'intégration native GitHub ↔ Zenodo est active pour le dépôt | Sinon chaque release créerait un second enregistrement, en plus de celui-ci |
| H1 | Confirmer que l'**immuabilité des releases** est active | `zenodo.yaml` exige `gh release verify` : sans attestation de release, il échoue (sûr, mais bloquant) |
| H5 | Créer les environments `zenodo` (secret `ZENODO_TOKEN`, variables `ZENODO_ENV` = `production` ou `sandbox` **exactement**, `ZENODO_CONCEPT_RECID` ; déploiement limité aux tags `spec-v*` ; relecteur requis conseillé) et `bump-lean` (secret `BUMP_TOKEN`, limité à `main`) | Les workflows y font référence ; un environment inexistant est créé sans protection au premier run |
| H6 | Remplacer `BUMP_TOKEN` par un PAT à granularité fine (dépôt unique, Contents et Pull requests en lecture/écriture, expiration courte) | Portée actuelle inconnue |
| H7 | Règle de tag `spec-v*`, `v*` (création, mise à jour et suppression restreintes) | Les contrôles de `release.yaml` sont dans le workflow du commit tagué : seule une restriction côté GitHub empêche de les contourner (§2) |
| H9 | **Répétition** : `workflow_dispatch` de `release.yaml` (essai), puis un tag d'essai, brouillon relu et supprimé, Zenodo `sandbox` | Aucun de ces workflows n'a tourné de bout en bout |
| H11 | Vérifier que le `gh` des runners GitHub-hébergés connaît `gh release verify` et `verify-asset` | Le job Zenodo s'arrête sinon, avec un message explicite (version du runner non connue ici ; les options utilisées sont confirmées par l'aide de gh 2.89.0 installé en local, sans exécution contre GitHub) |
| H12 | Faire fusionner par l'agent qualité (ou ajouter) l'entrée `use_cache` de `verify.yaml` **avant** de fusionner `release.yaml` | Contrat d'interface ; sans elle, `release.yaml` est invalide |

**Procédure humaine de release (résumé).** (1) pousser le tag `spec-vX.Y.Z` ; (2) attendre `release.yaml` (essai possible avant, par dispatch) ; (3) relire le brouillon (assets, notes) ; (4) rejouer en local les commandes `gh release download` / `gh attestation verify --bundle …` indiquées dans les notes ; (5) publier : la release devient immuable et déclenche `zenodo.yaml` ; (6) après un premier dépôt `NEW`, **renseigner** `ZENODO_CONCEPT_RECID` avec l'identifiant du résumé du job avant toute autre exécution ; (7) mettre à jour `CITATION.cff` / `README.md` selon la décision D1.

## 8. À faire par la session principale (documents hors de mon périmètre)

- `.github/workflows/README.md` : sections « Releases » (flux brouillon, plus de publication après coup, essai par dispatch) et « Publication Zenodo et identifiants » (plus de `zenodo-state` ni de `contents: write`) ; mention du `cooldown` et de l'épinglage d'elan.
- `CONTRIBUTING.md` (§ release, l. 90-99 d'après l'audit) : « pousser le tag, relire le brouillon, publier ».
- `SECURITY.md` : procédure de vérification (AUDIT §4, **après** la première release vérifiée), liste des dépendances externes non épinglées (toolchain Lean, bundle TeX, images Docker), TOFU du hook.
- `docs/suivi/DASHBOARD.md:181` cite encore `lean.yaml`.
- Ne rien afficher (« DOI », « SWHID de la release », « reproductible », SLSA) avant les décisions D1/H3 et la première release attestée **et** vérifiée.

## 9. Ce qui n'a volontairement pas été fait

cosign en plus d'`actions/attest`, SBOM, revendication SLSA, remplacement de `lean-action` par un téléchargement épinglé, épinglage du bundle TeX, `SOURCE_DATE_EPOCH` et double build (domaine `quality-reproducibility`), tags signés, retrait de `spec-v0.0.0-alpha.1` (AUDIT §9). Statut : `FUTURE` ou sans objet.

## 10. Statuts

| Action | Statut | Raison |
|---|---|---|
| R1 + R6 | `PREPARED` | écrit, lint propre, logique shell exécutée hors ligne ; jamais exécuté sur GitHub ; dépend de `use_cache` (H12) |
| R3 | `PREPARED` / `HUMAN ACTION REQUIRED` | script testé hors ligne contre une doublure de l'API ; API Zenodo réelle non jointe ; D1, H1, H5 |
| R4 | `PREPARED` | contrôle testé sur le manifeste réel, avec le réseau pour `--check-tags` ; étapes d'`open-pr` simulées ; première exécution réelle au prochain bump |
| R8 | `PREPARED` | exécuté dans un `HOME` jetable : elan 4.2.4 installé, chemin « somme différente » vérifié ; `lake exe cache get` non exécuté sur le dépôt |
| R12 | `PREPARED` | YAML valide, zizmor sans constat ; schéma Dependabot non validé par un outil |

## 11. Vague 2 bis — corrections après la CI de la tête finale et deux audits indépendants

| | |
|---|---|
| Base | `c9372cb` (tête de l'orchestratrice, avec les six commits de la vague 2) ; branche locale `fix/supply-chain-r2`, pas de push |
| Commits | `99c3214` (SC2015) · `43d543c` (F1, manifeste Lake) · `48779c0` (F4, brouillon) · `1d64196` (F2 et autres constats, Zenodo) · le commit de ce document |
| Parité CI | `actionlint` avec ShellCheck **0.9.0** (celui d'Ubuntu 24.04), `gitleaks` 8.24.3, `zizmor --offline` : voir `VALIDATION.md` §11. ShellCheck 0.11 masquait SC2015 : il n'est plus utilisé pour conclure |

### 11.1 Constats traités

| Constat | Correction | Fichier |
|---|---|---|
| SC2015 (`A && B \|\| C`) à `bump-lean.yaml` (validation du manifeste) et `release.yaml` (somme du PDF) | deux `if … then … fi` ; aucune autre construction `&& … \|\|` dans les trois workflows | `bump-lean.yaml`, `release.yaml` |
| **F1** : 11 paquets sur 14 sans contrainte réelle (`rev` nul, URL redirigée, `subDir`/`configFile` = `../../..`, `inputRev` = `refs/heads/evil`, paquet en plus, `lakeDir`/`name` modifiés) | voir §11.2 | `check_manifest.py`, `bump-lean.yaml` |
| **F2** : après `publish`, un lien `record` inattendu ou une `ConnectionError` faisait échouer le job sans résumé ; avec `NEW`, un « Re-run » aurait créé un second concept | voir §11.3 | `sync_zenodo.py`, `zenodo.yaml` |
| M5 : `zenodo.json` absent, vide ou invalide retombait sur `{}` | erreur claire avant le réseau (code 2) ; `creators` requis ; `zenodo.files.json` optionnel mais, s'il existe, objet JSON valide | `sync_zenodo.py` |
| Z4 : préfixe `spec-v` | exigé, et testé par des tags que la seule longueur de version ne rejetait pas (`release-1.2.3`, `svec-v0.1.0`…) | `test_sync_zenodo.py` |
| Z2 : échec d'un `DELETE` de fichier hérité | test : l'exception est levée, rien n'est téléversé ni publié | `test_sync_zenodo.py` |
| Z6 : repli sur la liste des fichiers pour la somme | testé (somme seulement dans la liste : vérifiée ; fausse : arrêt avant publication) | `test_sync_zenodo.py` |
| Z3 : comportement par défaut sur `os.environ` | testé (`--check-config`, refus, publication complète avec résumé) | `test_sync_zenodo.py` |
| V6 : cas « URL avec fragment » et « nom de dépôt simple » annoncés | testés ; **le test a trouvé un défaut réel** : `…/mathlib4#` et `…?` (fragment ou requête vides) passaient `check_url` (`urlsplit` les rapporte comme absents) ; refusés désormais par examen du texte | `check_manifest.py` |
| M4 : un `name` du manifeste pouvait injecter une commande de workflow (`::notice::`) | `name` limité à `[A-Za-z0-9._-]+` ; tous les messages passent par `clean()` (caractères non imprimables remplacés) ; testé sur `name`, sur d'autres champs et sur un `rev` imprimé tel quel par `--check-tags` | `check_manifest.py` |
| V1 : mutants `sys.exit(main())` → `main()` survivants | chaque script est lancé en sous-processus (`sys.executable`, racine du dépôt, environnement contrôlé, sans réseau) : codes 0, 1, 2 (et 3 pour Zenodo) ; `requests` y est remplacé par un module factice via `PYTHONPATH` | les deux fichiers de test |
| V2 : câblage `main → run → check_tags` non testé | `main(argv, ls_remote, fetch)` accepte des doublures ; tests de bout en bout de `--check-tags` et `--check-upstream` | `check_manifest.py`, test |
| V3 : test « manifeste trop gros » avec du blanc (rejeté comme JSON invalide) | JSON **valide** trop gros (remplissage dans une chaîne) : rejet « is larger than », sans « not valid JSON » ; témoin positif : même document un octet sous le plafond, lu et refusé pour une autre raison | test |
| **F4** : le tag pouvait bouger entre `check` et la création | `draft` résout le tag par l'API (un tag annoté est suivi jusqu'au commit) **juste avant** `gh release create` et exige `$GITHUB_SHA` ; sinon aucune release n'est créée | `release.yaml` |
| F4 : commandes des notes | séparées en « avant publication » (`sha256sum -c`, `gh attestation verify --bundle … --signer-workflow … --source-ref … --source-digest <sha> --deny-self-hosted-runners`) et « après publication » (`gh release verify`, `gh release verify-asset`) | `release.yaml` |

### 11.2 F1 — ce que `check_manifest.py` contrôle maintenant (exactement)

Sans réseau : clés connues seulement (manifeste et paquets) ; `packagesDir` = `.lake/packages`, `lakeDir` = `.lake`, `name` = paquet du lakefile ; chaque paquet est `git`, de nom connu (**14 noms**, `ALLOWED_PACKAGES`, tirés du manifeste du 6 octobre 2026) et d'**URL exactement égale au dépôt enregistré pour ce nom** (plus de liste de propriétaires entiers : une URL redirigée vers un autre dépôt autorisé est refusée) ; `rev` = 40 hex minuscules ; `subDir`, `configFile`, `manifestFile`, `scope` = chemins relatifs simples (`[A-Za-z0-9._/-]`, pas de `..`, pas de chemin absolu ni de tiret initial) ; `inputRev` = nom simple, jamais `refs/…` ; `lean-toolchain` et les trois `@ "vX.Y.Z"` concordent ; les paquets non hérités sont exactement les `require` du lakefile (même URL, même `inputRev`).

Avec réseau, activés par `open-pr` et **désactivés par défaut** : `--check-tags` (le `rev` de chaque dépendance directe est le commit de son tag amont) et `--check-upstream` (implique `--check-tags`) : pour chaque dépendance directe dont le `rev` a passé le contrôle de tag, le `lake-manifest.json` publié par l'amont **à ce `rev`** est lu sur `raw.githubusercontent.com` (https, hôte fixe, taille bornée) ; chaque paquet **hérité** doit y figurer avec les mêmes nom, URL et `rev` ; un paquet qu'aucune dépendance vérifiée ne liste est refusé.

L'en-tête de `bump-lean.yaml` reprend cette liste et dit ce qui n'est **pas** contrôlé : un paquet **absent** du manifeste, un commit malveillant épinglé par un manifeste amont lui-même, un tag amont déplacé avant le bump. La relecture du diff de `lake-manifest.json` par l'autrice reste la barrière finale.

**Conséquence d'exploitation.** Une nouvelle dépendance transitive (nom inconnu) ou un changement de format de manifeste Lake (clé nouvelle) fait **échouer** `open-pr` jusqu'à ce qu'un humain mette à jour `ALLOWED_PACKAGES` ou les clés connues dans `scripts/ci/check_manifest.py`. C'est voulu (échec fermé), mais la PR de bump automatique ne s'ouvrira pas seule dans ce cas.

### 11.3 F2 — comportement de `sync_zenodo.py` après l'envoi de la publication

| Situation | Résultat |
|---|---|
| échec avant l'envoi de la requête de publication | message et code 1 (refus), ou trace d'exécution ; aucun DOI |
| refus net de Zenodo à la requête de publication (HTTP 4xx) | échec sans résumé (rien n'est publié) |
| réponse perdue (`ConnectionError`, délai) ou HTTP 5xx à la requête de publication | « publication **incertaine** » : résumé avec le numéro de dépôt, consigne de vérifier sur Zenodo avant tout rejeu ; code 3 |
| après réception de la réponse de publication : lien `record` inattendu, relecture refusée, `ConnectionError`, toute autre exception | DOI, concept et consigne (« renseigner `ZENODO_CONCEPT_RECID`, **ne pas rejouer** ») affichés et écrits dans le résumé ; code 3 |
| succès | comme avant ; un résumé qui ne peut pas être écrit est signalé sans changer le code 0 |

Le jeton est expurgé de tous ces messages (testé). **Changement de comportement par rapport à la vague 2** : une relecture refusée après publication faisait un succès (code 0, repli sur la réponse de publication) ; c'est maintenant un échec visible (code 3), avec le même résumé.

`ZENODO_CONCEPT_RECID=NEW` refuse de s'exécuter, avant tout appel réseau (y compris `--check-config`), si `GITHUB_RUN_ATTEMPT` est absent ou différent de `1` : un « Re-run » garde l'identifiant d'exécution et incrémente ce compteur (comportement de GitHub Actions, **non vérifié ici**, hors Actions). Un identifiant de concept numérique n'est pas concerné (la garde « déjà archivée » s'applique si l'API renvoie les métadonnées).

### 11.4 Écarts avec la consigne, hypothèses, actions

- **Plus strict que demandé** (F1) : la liste blanche lie chaque **nom** de paquet à **son** dépôt, pas seulement un ensemble de paires ; les clés inconnues sont refusées ; `inputRev` doit aussi être un nom simple (`[A-Za-z0-9][A-Za-z0-9._/-]*`).
- `--check-upstream` ne signale pas un paquet **manquant** du manifeste (un build échouerait, ce n'est pas une atteinte à l'intégrité) ; il n'examine pas les dépendances directes elles-mêmes au-delà du contrôle de tag.
- `--check-upstream` suppose que `raw.githubusercontent.com` est joignable depuis le runner (vrai ici, via le proxy de la session ; non testé sur un runner GitHub).
- F4 (a) : la résolution du tag utilise deux points d'accès de l'API (`git/ref/tags/<tag>`, `git/tags/<sha>`) ; elle n'a été exécutée qu'avec un `gh` factice, pas contre GitHub.
- F4 (b) : que `gh release verify` et `verify-asset` ne fonctionnent qu'**après** publication repose sur l'aide de `gh` (« fetches the attestation for the release ») et sur l'audit §3.1 (l'attestation de release est créée à la publication de la release immuable). **Non exécuté** sur un brouillon : aucune release n'existe pour essayer. Les commandes « avant publication » supposent que l'humaine a téléchargé les trois fichiers depuis la page du brouillon (visible des seuls mainteneurs).
- Aucune constante ressemblant à un secret n'a été ajoutée ; `TOKEN = "tok-secret-0123456789"` (déjà allowlistée par l'orchestratrice) est inchangée ; `gitleaks` (historique et arbre de travail) ne signale rien.
- **À ajouter par la session principale** dans la documentation transversale : `--check-upstream` et la liste blanche de noms (échec voulu pour toute nouvelle dépendance), le code de sortie 3 et l'instruction « ne pas rejouer », la règle `GITHUB_RUN_ATTEMPT` pour `NEW`, le fait que `gh release verify` n'est utilisable qu'après publication.
