<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Validation — chaîne d'approvisionnement et publication (vague 2)

| | |
|---|---|
| Rôle | `supply-chain-release-specialist`, vague 2 |
| Date | 6 octobre 2026 |
| Base | `b5f6146` ; commits locaux `46d737a`, `58ea019`, `723a799`, `d87ebd8`, `4deacdf` |
| Environnement | Linux, CPython 3.11.15, gh 2.89.0 ; `actionlint` 1.7.12 + ShellCheck 0.11.0, `zizmor` 1.30.1, `reuse` 6.2.0 (outils du scratchpad de la session) |
| Nature | Ce document dit ce qui a été **réellement exécuté** et ce qui **ne l'a pas été**. Les sorties citées sont celles observées. |

**Ce document décrit la vague 2 ; sa section 11 (« Vague 2 bis ») le remplace pour tout ce qu'elle couvre** : parité avec la CI (ShellCheck 0.9.0, `gitleaks`), nouveaux tests, mutations, simulations. Les chiffres du §1 (89 tests, 13 et 25 mutants) sont ceux d'avant ; ils ne sont plus à jour. L'usage de ShellCheck 0.11 y est abandonné (il masquait SC2015).

**Règle de lecture.** Un workflow dont les étapes shell ont été exécutées hors ligne avec des doublures, et dont `actionlint`/`zizmor` sont propres, reste `PREPARED` : aucune exécution sur GitHub n'a eu lieu. Une vérification plus faible n'est pas présentée comme une preuve d'une propriété plus forte.

## 1. Synthèse

| Contrôle | Résultat | Portée |
|---|---|---|
| `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` (racine du dépôt) | `Ran 89 tests … OK` (9 `test_impact`, 49 `test_check_manifest`, 31 `test_sync_zenodo`) | `VERIFIED` : propriétés des scripts, hors ligne |
| Même commande, **sockets désactivés et `requests` non importable** | `Ran 89 tests … OK` | `VERIFIED` : la suite n'a besoin ni du réseau ni de `pip` |
| Tests de mutation (§4) | 13 mutants de `check_manifest.py` et 25 de `sync_zenodo.py` : **tous tués** | `VERIFIED` : les tests peuvent échouer |
| `check_manifest.py` sur le `lake-manifest.json` réel | `all checks passed` ; avec `--check-tags` (réseau) : `all checks passed (including upstream tags)` | `VERIFIED` pour l'état du 6 octobre 2026 |
| `actionlint` (avec ShellCheck) | `bump-lean.yaml`, `zenodo.yaml` : propres ; `release.yaml` : **2 erreurs, toutes deux `input "use_cache" is not defined`** tant que `verify.yaml` n'a pas l'entrée ; **propre** contre une copie de scratch qui porte l'entrée | `PARTIAL` (dépend de H12) |
| `zizmor --offline` persona `regular` | 3 constats dont 1 supprimé par le persona (probablement `superfluous-actions`, affiché en `auditor`) et 2 × `self-repository` (déjà présents avant, non appliqués : AUDIT §9) ; `dependabot.yml` : aucun | `VERIFIED` : aucun constat nouveau |
| `zizmor --offline` persona `auditor` | 3 constats : `superfluous-actions` (informatif, déjà présent, action imposée par la consigne) + 2 × `self-repository` ; `dependabot.yml` : aucun | `VERIFIED` : aucun constat nouveau |
| `bash -n` et ShellCheck sur `claude-session-start.sh` | aucune erreur, code 0 | `VERIFIED` |
| Hook exécuté dans un `HOME` jetable | elan 4.2.4 installé ; chemin « somme différente » : refus sans rien installer | `VERIFIED` (hors `lake`, §5.1) |
| Étapes shell de `bump-lean.yaml` / `open-pr` | 8 scénarios simulés sur un dépôt de scratch, comportements attendus | `VERIFIED` pour la logique shell, pas pour les actions tierces |
| Étapes shell de `release.yaml` / `check` | 19 scénarios sur un dépôt git de scratch, comportements attendus | idem |
| Étapes shell de `release.yaml` / `draft` | 5 scénarios avec un `gh` factice, comportements attendus | idem |
| YAML (`yaml.safe_load`) des quatre fichiers | valides | `VERIFIED` (syntaxe seulement) |
| `reuse lint` (reuse 6.2.0) | `Files with copyright information: 369 / 369`, `Files with license information: 369 / 369`, conforme à la spécification REUSE 3.3 | `VERIFIED` |
| Exécution réelle d'un workflow, tag, release, brouillon, attestation, appel Zenodo, `lake` | **non exécutés** | voir §8 |

## 2. Commandes et sorties observées

Toutes depuis la racine du worktree. Les chemins d'outils sont ceux du scratchpad de la session.

### 2.1 Tests unitaires

```
$ python3 -m unittest discover -s scripts/ci -p 'test_*.py'
.........................................................................................
Ran 89 tests in 0.083s
OK
```

Test hors réseau et sans dépendance (script de scratch `offline_run.py`) : `socket.socket.connect`, `connect_ex`, `create_connection`, `getaddrinfo` remplacés par une fonction qui lève ; `sys.modules["requests"] = None` ; `python3 -I` ; mêmes tests, `Ran 89 tests in 0.086s … OK`.

### 2.2 Manifeste Lake réel

```
$ python3 scripts/ci/check_manifest.py
lake-manifest.json: all checks passed
$ python3 scripts/ci/check_manifest.py --check-tags
lake-manifest.json: all checks passed (including upstream tags)
```

La seconde commande interroge `git ls-remote` sur les trois dépôts directs (Mathlib, CSLib, Verso) : `rev` = commit du tag `v4.34.0`. **Ces tags sont légers** (aucune ligne `^{}`), d'où le traitement des deux formes dans le script (CHANGES §4).

### 2.3 Lint des workflows

```
$ actionlint -shellcheck=<shellcheck> .github/workflows/release.yaml      # verify.yaml actuel
release.yaml:211:7: input "use_cache" is not defined in "./.github/workflows/verify.yaml" reusable workflow. defined inputs are "deploy_pages", "docs_links", "full", "lean_build", "spec_build", "spec_check" [workflow-call]
release.yaml:222:7: (même message)
$ actionlint … release.yaml zenodo.yaml bump-lean.yaml   # copie de scratch où verify.yaml a l'entrée use_cache
(aucune sortie, code 0)
```

La copie de scratch ne diffère de `verify.yaml` que par l'ajout de l'entrée booléenne `use_cache` (défaut `true`) : c'est la lecture que je fais du contrat d'interface, **pas** le fichier que livrera l'agent qualité.

```
$ zizmor --offline --persona regular   release.yaml zenodo.yaml bump-lean.yaml
help[self-repository] release.yaml:208 et :219  (uses: ./.github/workflows/verify.yaml)
3 findings (1 suppressed, 2 unsafe fixes): 0 informational, 2 low, 0 medium, 0 high
$ zizmor --offline --persona auditor   release.yaml zenodo.yaml bump-lean.yaml
info[superfluous-actions] bump-lean.yaml:187 (peter-evans/create-pull-request)
help[self-repository] release.yaml:208 et :219
3 findings (2 unsafe fixes): 1 informational, 2 low, 0 medium, 0 high
$ zizmor --offline --persona auditor   .github/dependabot.yml
No findings to report. Good job!
```

**Comparaison avec l'audit (persona `auditor`, mêmes trois fichiers avant modification) :** 15 constats, dont `secrets-outside-env` ×4, `template-injection`, `dependabot-cooldown` ×2, `undocumented-permissions` ×3, `concurrency-limits`, `anonymous-definition`, `superfluous-actions`, `self-repository` ×2. Après : les trois derniers uniquement, tous antérieurs. **Aucun constat nouveau.** Les audits **en ligne** de zizmor (`impostor-commit`, `known-vulnerable-actions`, `stale-action-refs`) n'ont pas pu tourner (pas de jeton valide, API hors dépôt refusée).

### 2.4 Hook de session

```
$ bash -n scripts/claude-session-start.sh && shellcheck scripts/claude-session-start.sh
bash -n OK / shellcheck OK
```

## 3. Détail par action

### 3.1 R12 — Dependabot

`yaml.safe_load` : structure attendue (`cooldown: {default-days: 7}` sous chacun des deux écosystèmes). `zizmor` : plus de `dependabot-cooldown`. **Non établi** : validation par un schéma Dependabot (aucun outil de schéma disponible ici) ; que les mises à jour de sécurité échappent au `cooldown` (comportement documenté par GitHub d'après ma connaissance, non vérifié ici).

### 3.2 R8 — Hook de session

Exécution dans un `HOME` jetable (`mktemp -d` sous le scratchpad), `env -i`, `CLAUDE_CODE_REMOTE=true`, `CLAUDE_PROJECT_DIR` = répertoire **vide** (jamais le dépôt, donc aucun `lake` sur le dépôt) :

```
k7pl: Lean toolchain or Mathlib cache unavailable (network policy?); rely on CI to build.
exit=0
$HOME/.elan/bin/{elan,lake,lean,leanc,leanchecker,leanmake,leanpkg}   (liens vers elan)
$HOME/.profile                                                         (modifié par elan-init)
$CLAUDE_ENV_FILE: export PATH="<HOME jetable>/.elan/bin:$PATH"
$ ~/.elan/bin/elan --version  →  elan 4.2.4 (227caca13 2026-08-25)
```

Le message final est attendu : le dossier de projet vide n'a pas de `lean-toolchain`, donc `lake exe cache get` échoue et le hook retombe sur « rely on CI to build ». L'installation, elle, a réussi avec l'archive vérifiée.

Chemin « somme différente » (copie de scratch du script dont les 8 premiers caractères de la somme x86_64 sont remplacés par des zéros) :

```
k7pl: SHA-256 mismatch for elan-x86_64-unknown-linux-gnu.tar.gz (v4.2.4): expected 0000000044e8…, got 42b94d4244e8….
k7pl: elan was NOT installed.
k7pl: elan could not be installed (network policy?); rely on CI to build.
exit=0     (aucun $HOME/.elan créé, aucun fichier d'environnement écrit)
```

**Sommes : ce qui est établi.** Téléchargées par HTTPS depuis la page de release GitHub, **deux fois chacune**, mêmes résultats ; la valeur x86_64 (`42b94d42…1f63`) est identique à celle de l'audit (§3.4), observation indépendante de la mienne. `aarch64` : `05febd12…2bf9`, observée ici seulement. **Ce qui n'est pas établi** : l'authenticité de la première archive (aucune empreinte ni signature amont n'existe), le contenu de l'archive au-delà de ce que `elan-init --help` et `--version` ont montré. Le script le dit en commentaire. Les archives des deux architectures contiennent le seul membre `elan-init` (`tar -tzvf`). Non testé : l'architecture aarch64 (aucune machine), les plates-formes non Linux (refus attendu, non exécuté).

### 3.3 R4 — `check_manifest.py`

- 49 tests : manifeste réel accepté ; `rev` court, nom de branche, majuscules, 41 caractères, saut de ligne final, absent ou non chaîne ; URL hors liste, propriétaire approchant, autre hôte, identifiants, port, `http`, SSH, `file`, chemin trop long, requête, suffixe `.git`, non-chaîne ; type non `git`, doublon, `packagesDir`, liste vide, non-objet ; toolchain incohérent, un `require` sur une autre version, toolchain illisible, `inputRev` ou URL différents du lakefile, dépendance directe absente ou marquée héritée, `require` hors forme, `require` hors liste d'URL ; JSON invalide, trop gros, absent, imbriqué à 100 000 niveaux, lien symbolique ; codes de sortie 0/1 ; `--check-tags` avec une doublure : tag léger et annoté, `rev` différent, tag absent, requête en échec, seules les dépendances directes interrogées, URL hors liste ou nom de tag ressemblant à une option jamais interrogés ; commande `git ls-remote` construite comme liste d'arguments avec les deux formes de référence.
- Aucun test ne requiert le réseau ; `--check-tags` n'est exercé par aucun test (vérifié à la main, §2.2).

### 3.4 R4 — `bump-lean.yaml` (étapes `open-pr` simulées)

Script de scratch `sim_openpr.py` : lit les blocs `run:` **tels quels** dans le workflow et les exécute dans un dépôt git de scratch (base = « v4.33.0 » + manifeste modifié ; artefact = le vrai manifeste v4.34.0 ou une version altérée). Les étapes `uses:` ne sont pas exécutées (le téléchargement d'artefact est remplacé par une écriture de fichier ; `create-pull-request` n'est pas lancé). Le réseau est réel pour `--check-tags`.

| Scénario | Résultat observé |
|---|---|
| nominal | toutes les étapes passent ; `git status` : exactement `lake-manifest.json`, `lakefile.lean`, `lean-toolchain` modifiés |
| `rev` tronqué dans l'artefact | refus : `rev must be 40 lowercase hexadecimal digits` |
| URL `github.com/evil/plausible` | refus : `owner 'evil' is not in […]` |
| `rev` bien formé mais différent du tag amont (verso) | refus par `--check-tags` |
| fichier supplémentaire dans l'artefact | refus : `l'artefact doit contenir uniquement lake-manifest.json` |
| fichier supplémentaire modifié dans le dépôt | refus à l'étape « exactly the expected files differ » |
| `BUMP_TOKEN` vide | refus dès la première étape, message d'origine conservé |
| version `v4.34.0; echo pwned` | refus à la validation de version |

**Non établi** : le comportement de `actions/upload-artifact` / `download-artifact` (un seul fichier, hors lien symbolique) ; celui de `create-pull-request` avec `add-paths` (inchangé par rapport à l'ancien workflow) ; le chemin « nouvelle version » complet (aucune version plus récente que `v4.34.0` n'existait le 6 octobre : `scripts/latest-lean-version.sh` → `v4.34.0`).

### 3.5 R1 + R6 — `release.yaml`, job `check` (19 scénarios)

Script de scratch `sim_check.py` : dépôt « origin » nu + clone (comme `fetch-depth: 0`), historique `main` + branche `feature`, tags légers et annotés ; `gh api` remplacé par un `gh` factice qui sert un JSON et applique le **filtre `jq` du workflow** avec le vrai `jq`. Les blocs `run:` et `env:` sont lus dans le workflow.

| Scénario | Résultat |
|---|---|
| tag `spec-vX` valide sur `main`, `CI OK` présent | passe ; notes extraites = section du changelog |
| même, tag **annoté** | passe (`^{commit}` pèle bien le tag) |
| tag `vX` (implémentation) | passe |
| `CITATION.cff` ≠ tag | refus |
| section de changelog vide | refus |
| tag sur un commit hors `main` | refus : `not an ancestor of origin/main` |
| tag déplacé après le déclenchement | refus : `the tag moved` |
| `CI OK` absent, en échec, ou émis par une autre application | refus |
| tags `spec-vfoo`, `vfoo`, `release-1`, push de branche | refus à la résolution |
| essai (`workflow_dispatch`) spec et implémentation | passe, `dry_run=true`, résumé « no draft, no attestation » |
| essai avec version `0.1.0; echo pwned` ou kind inconnu | refus |
| essai sur un commit hors `main` | refus |

### 3.6 R1 + R6 — `release.yaml`, job `draft` (5 scénarios, `gh` factice)

Stable : `gh release list` puis `gh release create <tag> --draft --verify-tag --title <tag> --notes-file … <pdf> <sha256> <bundle>`, **sans** `--prerelease` ; version `0.0.0-alpha.1` : `--prerelease` présent ; release déjà existante : refus avant toute écriture ; artefact `spec-pdf` avec fichier supplémentaire : refus ; bundle absent : refus. Le fichier de notes envoyé contient la section du changelog puis le bloc « Vérification » (commandes `gh` de l'audit §4). La somme `.sha256` est celle du PDF factice.

### 3.7 R3 — `sync_zenodo.py` et `zenodo.yaml`

- 31 tests contre une doublure de l'API Zenodo (une classe qui répond aux routes utilisées et enregistre chaque appel ; tout appel non prévu lève `AssertionError`).
- **Refus avant réseau** (la doublure n'a enregistré aucun appel, code de sortie 2) : `ZENODO_CONCEPT_RECID` absent, vide, ou invalide (`abc`, `12a`, `-5`, `0`, `012`, `1.5`, espaces, saut de ligne, `new`, `NEW `, `1e9`, `123/../x`, `0x10`, chiffres non ASCII, trop long, `1,2`) ; `ZENODO_ENV` absent, vide, `prod`, `Production`, `SANDBOX`, `staging`, avec espace, URL ; jeton absent ; tag, SHA, dépôt, URL de release mal formés ; version divergente du tag ; zéro ou plusieurs PDF.
- **Acceptation** : `NEW` : séquence d'appels exacte `POST depositions` → `GET files` → `POST files` → `POST publish` → `GET records`, **jamais** de lecture de concept ; le résumé demande de renseigner la variable et donne l'identifiant de concept créé ; un identifiant numérique : lecture du concept, `newversion`, remplacement du fichier hérité, publication, jamais de `POST depositions`.
- **Garde-fous** : identifiant de version saisi à la place du concept → refus avant toute écriture ; concept illisible (HTTP 404) → exception, aucune création ; lien `latest_draft` vers un autre hôte, en `http`, avec identifiants, vers une autre collection, avec chemin remonté, non numérique, absent → refus, aucun appel hors de l'instance ; identifiant de fichier non conforme → aucun `DELETE` ; somme différente → arrêt avant publication ; somme absente ou illisible → « non vérifiée » (jamais « vérifiée ») ; release déjà archivée → refus ; relecture de l'enregistrement impossible après publication → compte rendu avec la réponse de publication ; DOI affiché avant la relecture.
- **Provenance** : identifiants `isSupplementTo`/`isDerivedFrom`/`isIdenticalTo` et empreinte SHA-256 des octets réellement publiés dans les notes ; identifiants de `zenodo.json` conservés ; `zenodo.json` inchangé octet pour octet ; jeton jamais imprimé (vérifié dans chaque exécution).
- CLI avec la **vraie** bibliothèque `requests` et un proxy volontairement injoignable (`127.0.0.1:9`) : sans concept, concept invalide, environnement invalide → `Configuration error: …`, code 2, aucun appel ; `NEW` et un entier acceptés par `--check-config` ; `NEW` sans PDF → arrêt avant le réseau.
- `zenodo.yaml` : `actionlint` et `zizmor` propres ; les blocs `run:` ne contiennent aucune interpolation `${{ }}` (balayage automatique).

### 3.8 `reuse lint`

Voir §9.

## 4. Tests de mutation

Script de scratch : applique **un** changement à la fois au script testé, relance la suite concernée, exige un échec.

- `check_manifest.py`, 13 mutants : `rev` de 7 à 40 caractères accepté, propriétaire `evil` autorisé, utilisateur/port acceptés, `http` accepté, épinglage du toolchain ignoré, forme pelée non préférée, suffixe `.git` accepté, type non `git` accepté, `packagesDir` ignoré, `inputRev` ignoré, `match` au lieu de `fullmatch`, nom de tag non contrôlé, lien symbolique accepté → **13 tués**.
- `sync_zenodo.py`, 25 mutants : repli de `ZENODO_ENV` sur la production, vérification d'absence du concept retirée (et variante où l'absence vaut `NEW`, tuée à part), zéros de tête acceptés, `new` accepté, écart de concept ignoré, hôte des liens / requête non contrôlés, somme différente ignorée, somme absente présentée comme vérifiée, empreinte absente des notes, booléen accepté comme identifiant, identifiants de provenance supprimés, plusieurs PDF acceptés, `--check-config` exigeant un jeton, identifiant de fichier non contrôlé, divergence version/tag ignorée, SHA non contrôlé, jeton facultatif, tag non contrôlé, URL de release non contrôlée, absence de PDF acceptée, concept jamais lu, double archivage permis, échec de relecture fatal après publication, DOI non affiché avant relecture → **25 tués**.

Un premier mutant « le concept vide vaut `NEW` » avait **survécu** parce qu'il était équivalent (la vérification d'absence le précède) ; il a été remplacé par le mutant non équivalent ci-dessus.

## 5. Ce que les simulations ne démontrent pas

Elles exécutent les blocs `run:` du fichier réel, mais **ni** les actions tierces (`checkout`, `upload-artifact`, `download-artifact`, `attest`, `create-pull-request`, `lean-action`, `setup-python`), **ni** l'évaluation des expressions `${{ }}` par GitHub (remplacées par une table), **ni** les permissions du `GITHUB_TOKEN`, **ni** les environments, **ni** le comportement de `gh` contre GitHub. Le `jq` des simulations est celui du système, pas le `gojq` de `gh` (les deux filtres utilisés — sélection et `env.TAG` — sont du `jq` courant).

## 6. API Zenodo : ce qui est établi, ce qui ne l'est pas

`zenodo.org` et `sandbox.zenodo.org` sont **refusés par le proxy** (`CONNECT tunnel failed, response 403`, observé le 6 octobre 2026). Aucune réponse réelle de Zenodo n'a donc été vue. Tout ce qui suit repose sur le comportement de l'ancien script (qui s'appuyait sur `conceptrecid`, `id`, `links.latest_draft`, `links.record`, la liste des fichiers) et sur ma connaissance de la documentation, **non vérifiée ici** :

| Hypothèse | Si elle est fausse |
|---|---|
| `GET /api/records/<concept>` renvoie `id` et `conceptrecid` | le script refuse (échec sûr, message clair) |
| La réponse d'envoi d'un fichier, ou la liste des fichiers, porte `checksum` (MD5, éventuellement préfixé) | « non vérifié » dans le journal et le résumé ; la publication continue |
| `metadata.related_identifiers` est présent dans l'enregistrement lu | la garde « déjà archivé » est inerte (jamais bloquante à tort) |
| Les relations `isSupplementTo`, `isDerivedFrom`, `isIdenticalTo` sont acceptées | l'API refuse la mise à jour des métadonnées, **avant** la publication |
| Le champ `notes` accepte du texte brut sur plusieurs lignes | idem |
| Un second `newversion` sans publication réutilise le brouillon existant | une nouvelle tentative après échec pourrait demander un nettoyage manuel du brouillon Zenodo |
| Les liens `latest_draft` et `record` sont des URL `https` de l'instance, chemins `/api/deposit/depositions/<id>` et `/api/records/<id>` | le script refuse (échec sûr) |

**Conséquence** : la répétition sur *sandbox* (H9) est le moyen d'établir ces points ; elle n'a pas été faite.

## 7. Relecture adversariale du diff

Pour chaque permission : que ferait un attaquant ? Si une étape échoue au milieu ? Un contrôle peut-il être contourné ou sauté sans bruit ?

**`release.yaml`**

- *`check` (`contents: read`, `checks: read`)* : lecture seule, aucun secret, `persist-credentials: false`. Un attaquant qui contrôle l'entrée (nom de tag) ne peut rien injecter : tout passe par `env:` et par une validation par expression régulière.
- *Contournement* : **les contrôles de `check` sont dans le workflow du commit tagué.** Quelqu'un qui peut pousser un tag sur un commit dont `release.yaml` a été modifié les supprime. Ils protègent de l'erreur, pas d'un acteur ayant le droit d'écriture. Barrières réelles : règle de tag (H7), environment `zenodo` protégé (H5), relecture humaine du brouillon. **Écart non refermé par ce dépôt.**
- *`verify-*`* : exécutent du code amont avec `contents: read` et le jeton d'exécution des artefacts ; elles peuvent remplacer l'artefact `spec-pdf` (ou `release-notes`) du même run : la limite connue de la transmission par artefact (AUDIT §3.7, point 1) subsiste. `draft` n'exécute aucun code du dépôt, donc ne peut être détourné que par le contenu du PDF, que l'humain relit avant publication ; l'attestation ne dit rien de la sûreté des entrées du build.
- *`draft` (`contents: write`, `id-token: write`, `attestations: write`)* : un attaquant qui y exécuterait du code pourrait créer des releases, des tags et des attestations. Ce job n'a ni checkout, ni outil de build ; seules des actions épinglées et des commandes `gh` y tournent. `artifact-metadata` est retiré.
- *Échec au milieu* : après l'attestation et avant la création du brouillon → attestation orpheline (sans effet, vérifiable) ; création partielle du brouillon → le rejeu est refusé (« une release existe déjà »), l'humain supprime le brouillon et relance ; le tag n'est jamais modifié.
- *Saut silencieux* : `draft` ne s'exécute que si `check` **et** `verify-spec` réussissent (`needs` + condition) ; un dispatch ne peut pas créer de brouillon (`dry_run` toujours vrai) ; une poussée ne peut pas être traitée comme un essai.
- *Incertitudes* : `GITHUB_SHA` d'un tag annoté (le contrôle « tag déplacé » échoue **fermé** s'il diffère) ; nom exact du check `CI OK` et slug `github-actions` de l'application (échec fermé si faux : message explicite) ; `--source-digest`/`--deny-self-hosted-runners` côté `zenodo.yaml` (même remarque).

**`zenodo.yaml` et `sync_zenodo.py`**

- *`environment: zenodo`* : barrière réelle des secrets (si l'autrice la configure) ; `contents: read` : un code détourné ne pourrait rien écrire dans le dépôt. Le jeton Zenodo n'est donné qu'à l'étape de dépôt.
- *Contournement* : mêmes réserves que ci-dessus (workflow du commit tagué). `gh release verify` exige une release **immuable** : si l'immuabilité n'est pas active, le job échoue (sûr, bloquant : H1).
- *Échec au milieu* : après `newversion`/création et avant publication → brouillon Zenodo non publié (aucun DOI figé) ; après publication → le DOI est affiché immédiatement. **`NEW` n'est pas rejouable** : une seconde exécution créerait un second concept ; l'idempotence ne peut pas être contrôlée pour `NEW`. Dit dans le script, le résumé et `CHANGES.md` (§7, étape 6).
- *Bruit* : l'avertissement « somme non vérifiée » ne bloque pas : si l'API ne renvoie jamais de somme, le contrôle d'intégrité côté Zenodo n'existe pas ; les vérifications `gh` précèdent de toute façon le dépôt des mêmes octets.
- *Rejeu après succès avec concept numérique* : refusé (garde « déjà archivé ») si l'API renvoie les métadonnées liées ; sinon un second dépôt de mêmes octets serait possible (version supplémentaire, même concept).

**`bump-lean.yaml` et `check_manifest.py`**

- *`build`* : `contents: read`, aucun secret, `persist-credentials: false` ; le code amont peut lire son propre espace de travail, falsifier `lake-manifest.json`, `lean-toolchain`, `lakefile.lean` et tout fichier du dépôt : seul le manifeste sort du job. Le contrôle précoce du manifeste dans ce job est **consultatif** (il s'exécute après l'évaluation de code amont) ; le contrôle qui compte est celui d'`open-pr`.
- *`open-pr`* : n'exécute aucun code Lean ; Python standard, `git ls-remote` vers les seules URL de la liste fermée ; `BUMP_TOKEN` n'est lu que par l'étape d'exigence (test de présence) et par `create-pull-request`.
- *Contournements possibles* : (i) un `rev` bien formé malveillant dans une organisation autorisée pour une dépendance **héritée** ; (ii) des clés non contrôlées d'un paquet (`configFile`, `subDir`) ; (iii) un tag amont déplacé avant le bump. La relecture de la PR par l'autrice reste la barrière ; la liste figure dans `CHANGES.md` §4.
- *Échec au milieu* : si `create-pull-request` échoue, rien n'est poussé ; la branche `bump/lean-<version>` peut exister en cas d'échec partiel (même comportement qu'avant).
- *Saut silencieux* : `open-pr` ne tourne que si `newer == 'true'` ; sinon aucune PR, comme avant. Si `build` échoue, `open-pr` est ignoré.

**Hook `claude-session-start.sh`**

- Aucune exécution de code téléchargé avant la vérification de la somme ; extraction limitée à un membre ; répertoire temporaire supprimé dans tous les chemins. Contournement : modifier le script **et** la somme ; la première archive n'est pas authentifiée (TOFU). Le toolchain Lean est téléchargé ensuite par elan sans vérification.
- Écart de comportement par rapport à l'ancien script : `elan-init` modifie `~/.profile` (comme l'ancien `elan-init.sh`, qui passait les mêmes arguments) ; `--no-modify-path` n'a pas été ajouté (changement de comportement non demandé).

## 8. Ce qui n'a PAS pu être exécuté

| Élément | Raison | Statut |
|---|---|---|
| Un run réel de `release.yaml` (push de tag, dispatch), un brouillon, une attestation, une publication | aucune écriture sur GitHub autorisée ; aucun tag ni release | `PREPARED` |
| `gh release verify`, `gh release verify-asset`, `gh attestation verify` | rien à vérifier (aucune release attestée) ; hôtes TUF et stockage des bundles refusés par le proxy (audit) | `HUMAN ACTION REQUIRED` (H9) |
| Le `gh` des runners hébergés | version inconnue ; seules les options de gh 2.89.0 local ont été lues | `HUMAN ACTION REQUIRED` (H11) |
| Un appel à l'API Zenodo (production ou sandbox) | `zenodo.org` refusé par le proxy | `HUMAN ACTION REQUIRED` (H9) |
| `lake update`, `lake build`, `lake test`, `lake lint`, `lake exe cache get` sur le dépôt | interdit par la consigne ; aucune toolchain Lean n'a été installée sur le dépôt (elan l'a été **uniquement** dans un `HOME` jetable) | non exécuté |
| Le chemin « nouvelle version Lean » complet de `bump-lean.yaml` | aucune version plus récente que `v4.34.0` n'existe | `PREPARED` |
| Le hook sur aarch64 ou hors Linux | aucune machine | non exécuté |
| Validation par schéma de `dependabot.yml` | aucun outil disponible | `PARTIAL` |
| Audits en ligne de zizmor | pas de jeton valide | non vérifié |
| `release.yaml` contre le `verify.yaml` **réel** de l'agent qualité | l'entrée `use_cache` n'y est pas encore (H12) | `BLOCKED` jusqu'à l'intégration |
| Reproductibilité du PDF, SLSA, SBOM | hors périmètre ; aucune revendication faite | `FUTURE` |
| Réglages GitHub (immuabilité, environments, règle de tag, `BUMP_TOKEN`, politique d'actions) | non lisibles ni modifiables d'ici | `HUMAN ACTION REQUIRED` |

## 9. Résultat de `reuse lint`

```
$ reuse lint
* Bad licenses: 0   * Missing licenses: 0   * Unused licenses: 0   * Read errors: 0
* Used licenses: CC-BY-4.0, CECILL-2.1
* Files with copyright information: 369 / 369
* Files with license information: 369 / 369
Congratulations! Your project is compliant with version 3.3 of the REUSE Specification :-)
```

Exécuté sur le worktree (nouveaux fichiers inclus : `zenodo.yaml`, `check_manifest.py`, les deux fichiers de test, `CHANGES.md`, `VALIDATION.md`).

## 10. Outils de validation non versionnés

Les scripts de simulation et de mutation cités (`sim_openpr.py`, `sim_check.py`, `sim_draft.py`, `mutate_manifest.py`, `mutate_zenodo.py`, `offline_run.py`, démonstration CLI, hook jetable) sont restés dans le scratchpad de la session : le périmètre de fichiers autorisés ne les couvrait pas. Les propriétés qu'ils vérifient qui valent d'être conservées sont déjà des tests versionnés (`scripts/ci/test_check_manifest.py`, `scripts/ci/test_sync_zenodo.py`) ; les simulations de blocs `run:` ne le sont pas. Les rejouer demande de les réécrire à partir des descriptions des §3.2 à §3.7.

## 11. Vague 2 bis — validation (parité avec la CI)

Base `c9372cb`, branche `fix/supply-chain-r2`. Outils : `actionlint` 1.7.12 avec **ShellCheck 0.9.0** (copie `sc09`, identique à celui de la CI), `zizmor` 1.30.1, `gitleaks` 8.24.3 (`.gitleaks.toml` de la tête), CPython 3.11.15. **Le ShellCheck 0.11 du §1 n'est plus utilisé pour conclure** : il masquait SC2015.

### 11.1 Ce qui a été exécuté

| Contrôle | Résultat observé |
|---|---|
| `actionlint .github/workflows/*.yaml` (ShellCheck 0.9.0), **avant** correction | reproduit exactement les deux erreurs de la CI : `bump-lean.yaml:159 SC2015` et `release.yaml:265 SC2015` |
| même commande, **après** | aucune sortie, code 0 (tous les workflows du dépôt, `verify.yaml` réel avec `use_cache` inclus) |
| `zizmor --offline` personas `regular` et `auditor` (release, zenodo, bump-lean, dependabot) | 3 constats, tous antérieurs : 2 × `self-repository` et 1 `superfluous-actions` informatif ; **aucun constat nouveau** |
| `gitleaks detect --redact --no-banner --exit-code=2` (historique, 136 commits) | `no leaks found`, code 0 |
| `gitleaks detect --no-git` (arbre de travail, contenu non encore commité compris) | `no leaks found` |
| `bash -n scripts/claude-session-start.sh`, `py_compile` des deux scripts | OK |
| `unshare -rn python3 -m unittest discover -s scripts/ci -p 'test_*.py'` (espace de noms **sans réseau**, vérifié : `Network is unreachable`) | `Ran 206 tests … OK` (toute la suite, tests des autres agents inclus) ; mes deux modules : 93 (`test_check_manifest`) et 62 (`test_sync_zenodo`) |
| même suite, sockets désactivés et `requests` non importable (`offline_run.py`, `python3 -I`) | `Ran 206 tests … OK` |
| `python3 scripts/ci/check_manifest.py` | `all checks passed` |
| `python3 scripts/ci/check_manifest.py --check-tags --check-upstream` (**réseau réel** : `git ls-remote`, `raw.githubusercontent.com`) | `all checks passed (including upstream tags and manifests)` : les 11 paquets hérités du manifeste réel sont identiques (nom, URL, `rev`) à ce que Mathlib, CSLib et Verso publient à leur `rev` |

### 11.2 Tests de mutation (un changement à la fois, la suite du module doit échouer)

- `check_manifest.py` : **34 mutants, 34 tués**. Ajoutés par cette vague : liste de dépôts ignorée, nom non lié à son dépôt, paquet supplémentaire accepté, `..` accepté, chemin absolu ou tiret initial accepté, `refs/` accepté dans `inputRev`, clé inconnue (paquet, racine) acceptée, `lakeDir` ou `name` ignorés, paquet « direct » non exigé par le lakefile, fragment ou requête vides acceptés, manifeste trop gros accepté, comparaison amont ignorée, dépendance directe non vérifiée digne de confiance, paquet non listé accepté, document amont trop gros accepté, hôte de récupération non contrôlé, `--check-upstream` sans contrôle de tag, `main` qui ignore `--check-tags` ou `--check-upstream`, sortie non assainie, `sys.exit(main())` → `main()`. Le mutant « suffixe `.git` accepté » a **disparu** : la clause était devenue redondante avec la liste exacte de dépôts (code mort) ; elle a été supprimée au lieu d'être gardée sans test.
- `sync_zenodo.py` : **45 mutants, 45 tués** (dont `sys.exit(run())` → `run()`). Ajoutés : NEW autorisé sur un rejeu, compteur de tentative ignoré, `zenodo.json` absent ou invalide devenant `{}`, `creators` non requis, préfixe `spec-v` non exigé, `DELETE` en échec ignoré, repli sur la liste des fichiers retiré, `os.environ` non lu par défaut, échec après publication non traité, résumé non écrit, code 3 perdu, jeton non expurgé, 5xx traité comme un refus, drapeau « publication envoyée » jamais levé, échec d'écriture du résumé fatal, `zenodo.files.json` exigé, type des métadonnées par fichier non contrôlé, réponse de publication non objet acceptée.
- Aucun mutant ne survit. Un mutant équivalent est apparu en cours de route : « un concept vide vaut `NEW` » (la vérification d'absence le précède, branche morte) ; il est remplacé par la suppression de cette vérification, tuée.

### 11.3 Simulations des blocs `run:` (fichiers réels, `gh` factice sauf mention)

- `open-pr` (étapes shell lues dans le workflow, **réseau réel** pour `--check-tags --check-upstream`) : nominal passe ; `rev` hérité forgé (`batteries` = `0…0`) refusé par la comparaison à l'amont ; paquet supplémentaire refusé ; `rev` direct faux refusé ; URL `evil/plausible` refusée ; version `v4.34.0; echo pwned` refusée.
- `draft` : tag léger et tag **annoté** sur `GITHUB_SHA` → `gh release create` appelé avec les trois assets (`--prerelease` pour `0.0.0-alpha.1`) ; tag déplacé, tag annoté déplacé, tags annotés imbriqués au-delà de 5 niveaux, objet de tag qui n'est pas un commit → **échec avant `gh release create`**, jamais appelé (vérifié dans le journal d'appels). Notes envoyées : sections « Avant publication » et « Après publication » avec `--source-digest <sha>` et `--deny-self-hosted-runners`.
- `check` : inchangé depuis la vague 2 (19 scénarios), non rejoué.

### 11.4 Ce qui n'a PAS pu être exécuté ou vérifié

| Élément | Raison | Statut |
|---|---|---|
| `gh api repos/<dépôt>/git/ref/tags/<tag>` et `git/tags/<sha>` contre GitHub | aucune écriture ni lecture autorisée hors du dépôt audité ; la forme `[.object.type, .object.sha]` suit la documentation de l'API REST, non exécutée ici | `PREPARED` |
| `gh release verify` / `verify-asset` sur un **brouillon** (pour confirmer qu'ils échouent avant publication) | aucune release à essayer ; le comportement est déduit de l'aide de `gh` et de l'audit §3.1 | non exécuté |
| Le comportement de `GITHUB_RUN_ATTEMPT` lors d'un « Re-run » | n'existe qu'en Actions ; la garde est testée avec la valeur injectée | `HUMAN ACTION REQUIRED` (H9 : répétition) |
| `--check-upstream` depuis un runner GitHub (accès à `raw.githubusercontent.com`) | non testé hors de la session | `PREPARED` |
| Classement 4xx / 5xx des réponses de Zenodo à la requête de publication | jamais vu de réponse réelle de Zenodo (hôte refusé par le proxy) ; testé avec une doublure | `HUMAN ACTION REQUIRED` (H9 : sandbox) |
| `lake update` / `build` / `test` / `lint` sur le dépôt | interdit par la consigne | non exécuté |
