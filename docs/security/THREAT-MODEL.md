<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Modèle de menace de k7pl

| | |
|---|---|
| Nature | **État des connaissances daté, produit par une session d'agents. Non validé par l'autrice.** Ce n'est pas une revue de sécurité humaine. |
| Date, base | 2026-10-06, `origin/main` = `b5f6146`, plus les changements de la branche de cette campagne (`PREPARED`, non fusionnés) |
| Sources | `docs/security/workstreams/security-assurance/AUDIT.md` (§ 2, § 3, § 5), `supply-chain/AUDIT.md`, `github-governance/AUDIT.md`, vérifications de la session principale (`OPENSSF-AUDIT.md`, § 1) |
| Ce que ce document n'est pas | Il ne modélise pas le langage k7pl : il n'existe ni analyseur ni interpréteur. Il modélise le dépôt, la chaîne de construction et la publication. |

Statuts : `VERIFIED` (observé) · `PARTIAL` · `PREPARED` (écrit, non exécuté de bout en bout, ou dépend d'un réglage humain) ·
`HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE`. Aucun contrôle `PREPARED` n'est compté comme présent.

**Usage proposé** (une pratique à adopter par l'autrice, non un engagement pris pour elle) : relire ce document quand une PR touche
`.github/workflows/`, `scripts/ci/`, `scripts/claude-session-start.sh`, `.claude/` ou les secrets, et le mettre à jour s'il ne décrit plus
la réalité.

## 1. Actifs

| Actif | Propriété à protéger | Où |
|---|---|---|
| A1 Branche `main` (spécification, implémentation, preuves, workflows, règles d'agents) | intégrité, traçabilité | GitHub |
| A2 Tags et releases `spec-v*`, `v*` | lien tag ↔ commit ; immutabilité | GitHub |
| A3 PDF de la spécification, somme, attestation | intégrité, authenticité | assets de release |
| A4 Enregistrements Zenodo (DOI) | intégrité ; **irréversibilité** : un enregistrement publié ne se retire pas par l'utilisateur | compte Zenodo (tous ses dépôts, pas seulement k7pl) |
| A5 Site GitHub Pages | intégrité | environnement `github-pages` |
| A6 Secrets : `ZENODO_TOKEN`, `BUMP_TOKEN` ; jetons éphémères (`GITHUB_TOKEN`, OIDC) | confidentialité | secrets de dépôt, mémoire du runner |
| A7 Caches Actions (`.lake/packages` avec oléans compilés, `~/.cache/Tectonic`) | intégrité | stockage de cache, portée par ref |
| A8 Assurance des preuves (« aucun axiome hors liste ») | correction | `axiom-audit`, oléans de Mathlib |
| A9 Comptes : GitHub `AntheaLiles`, Zenodo, ORCID | authenticité | hors dépôt |
| A10 Sessions d'agents (identifiants de session, écriture dans le dépôt) | intégrité | conteneur de session |

## 2. Acteurs

| Acteur | Capacités |
|---|---|
| T1 Anonyme, contributeur externe (fork) | ouvrir issues et PR ; faire exécuter du code dans la CI non privilégiée |
| T2 Mainteneuse (unique humaine) | administration ; seule à fusionner, taguer, publier |
| T3 Agents Claude Code | lecture et écriture du dépôt, outils GitHub (dont la fusion de PR), sous l'identité de la mainteneuse ; **vecteur** d'un attaquant par injection de prompt |
| T4 Amont compromis : actions GitHub, elan et Lean, Mathlib/CSLib/Verso et transitifs, serveur de cache de Mathlib, PyPI, Tectonic et son bundle TeX | code exécuté dans les jobs qui les utilisent |
| T5 Voleur d'identifiant (PAT, session, jeton Zenodo) | les droits de l'identifiant volé |
| T6 Plateformes (GitHub, Zenodo, Sigstore) | racines de confiance : **hors modèle**, supposées honnêtes |

## 3. Frontières de confiance

| Frontière | Contrôle observé | Statut |
|---|---|---|
| B1 PR (fork ou branche) → `main` | ruleset : PR + `CI OK` ; **zéro approbation** ; l'oracle (`ci.yaml`) est celui de la PR elle-même | PARTIAL |
| B2 Job non privilégié → job privilégié du même run | artefacts du **même run** seulement ; jobs privilégiés sans checkout ni build (`publish-spec` ancien, `draft`, `deploy-pages`) | VERIFIED |
| B3 Ref quelconque → cache de la branche par défaut → run d'un tag | portée par ref (une PR n'écrit pas dans le cache de `main`) ; le run d'un tag lisait les caches de `main` | VERIFIED (constat) ; **PREPARED** (`use_cache: false` dans `release.yaml`) |
| B4 Commit quelconque → tag → workflow de release | le workflow exécuté est celui **du commit tagué** ; aucune règle de tags ; rien ne vérifiait que le commit est sur `main` | PREPARED (contrôle `check`) ; HUMAN ACTION REQUIRED (règle de tags) |
| B5 Dépôt → Zenodo | `ZENODO_TOKEN` en secret de dépôt, sans environnement | HUMAN ACTION REQUIRED (environnement `zenodo`) ; PREPARED (`environment: zenodo`, échec par défaut) |
| B6 Contenu lu par un agent → actions de l'agent | permissions de Claude Code (mode non vérifié) | HUMAN ACTION REQUIRED (décision D3) |
| B7 Amont → runner (Lake, PyPI, actions, `curl`) | SHA d'action, commit du manifeste, `--require-hashes`, SHA-256 de Tectonic ; **pas** pour elan, la toolchain, les oléans de Mathlib, le bundle TeX | PARTIAL |

## 4. Chemins d'attaque et contrôles

Vraisemblance : F faible, M moyenne, É élevée. Impact : F, M, É, C critique. Les contrôles « préparés » ne s'appliquent qu'après
fusion et réglages humains.

| Chemin | V | I | Contrôle existant | Contrôle préparé | Reste |
|---|---|---|---|---|---|
| Vol de session ou hameçonnage du compte → administration → désactivation du ruleset, lecture des secrets, publication | F-M | C | 2FA (non vérifiée) | — | 2FA par clé d'accès (H) |
| Amont piégé (Lean, Mathlib, elan `master`) exécuté par `bump-lean` → lecture de `BUMP_TOKEN` → PR fusionnée → tag → PDF attesté → DOI | F | É | — | `bump-lean` en deux jobs (le jeton n'est jamais sur la machine qui exécute du code amont) ; manifeste contrôlé par `check_manifest.py --check-tags --check-upstream` (14 noms de paquets liés chacun à son dépôt, structure, `rev` de 40 hex, tags et manifestes amont) : cela ne détecte ni un commit malveillant que le manifeste amont épingle lui-même, ni un paquet omis | PAT à granularité fine (H) ; la PR de bump reste relue par l'œil |
| PR de fork qui vide les contrôles (`impact.py`, workflow) et obtient un `CI OK` vert | F | É | décision humaine de fusion | — | aucune revue tracée ; zéro approbation requise (structurel) |
| Injection de prompt par une issue, une PR, un fichier → agent qui modifie `.github/workflows/` ou `.claude/**` puis fusionne | M | É | permissions de Claude Code (mode non vérifié) ; `CI OK` n'arrête pas ce chemin | — | **décision D3** : interdire la fusion par un agent, restreindre les outils |
| Agent piégé ou PR modifiant `.claude/settings.json` ou le hook de session → exécution à chaque session future | F-M | É | relecture humaine | hook sans `curl \| sh` sur `master` | `.claude/settings.json` n'est couvert par aucun contrôle de CI |
| Code fusionné sur `main` → job `status` (jeton en écriture sur le contenu) → poussée d'une branche d'automatisation, ouverture d'une PR | F | M | exécute seulement du code déjà fusionné ; PR sans `CI OK` tant que la CI n'est pas relancée (ESTIMÉ) ; la fusion reste humaine | — | branche non protégée ; réglage « Actions peut créer des PR » (D11) |
| Code exécuté dans un run de `main` → écriture d'un cache → restauré par la release → PDF falsifié avec attestation valide | F | É | portée de cache | `use_cache: false` en release | — |
| Porteur d'un droit d'écriture pose `spec-v*` sur un commit hors `main` → le workflow de release **de ce commit** s'exécute | F | É | — | contrôle « ancêtre de `main` et `CI OK` » ; brouillon (pas de publication automatique) | **ne résiste pas à un acteur qui peut pousser un tag** : barrières = restriction de la création des tags avec contournement limité au rôle administrateur (H), environnement `zenodo` protégé (H ; porte manuelle, le relecteur est la même identité que celle des agents), relecture du brouillon. Résiduel : `BUMP_TOKEN` (écriture du contenu) peut créer des tags et publier une release, et un identifiant qui hérite du contournement administrateur n'est pas arrêté |
| Seconde release `spec-vX+1` alors que `ZENODO_CONCEPT_RECID` vaut encore `NEW` → second concept DOI, distinct du premier | F | M | `NEW` refusé si `GITHUB_RUN_ATTEMPT` n'est pas `1` (couvre le rejeu du même run seulement) ; consigne écrite dans le résumé du job | — | rien ne vérifie qu'un enregistrement lié au dépôt existe déjà : `already_archived` ne lit que la dernière version du concept déclaré ; relecteur de l'environnement `zenodo` (H) |
| `zenodo-state` réécrit → publication visant un autre enregistrement du compte Zenodo | F | M | — | branche supprimée du flux ; concept déclaré en variable d'environnement, validé | — |
| elan `master` compromis → exécuté par toute CI Lean et par le hook de session | F | É | — | hook : version + somme (première observation, non publiée par l'amont) | CI : `lean-action` exécute toujours le script de `master` |
| Oléans du cache de Mathlib substitués → déclaration fausse importée sans revérification du noyau | TF | M | — | — | `lean4checker` (FUTURE) |
| Prochaine release : `zenodo-state` absent → nouveau concept DOI, différent de `10.5281/zenodo.23040451` (intégrité, sans attaquant) | É | M | — | **échec par défaut** tant que `ZENODO_CONCEPT_RECID` n'est pas déclaré | **décision D1** |
| Intégration native Zenodo-GitHub encore active → second enregistrement à chaque release | ? | M | — | — | à vérifier (H) |
| PR de fork : minage, épuisement des minutes | M | F | — | — | approbation des workflows de forks (H) |
| Code amont exécuté par `bump-lean` (job `build`, planifié sur `main`) → cache écrit sous une clé prévisible → restauré ensuite par la CI de la PR de bump, par `main`, par Pages | F | M-É | le job n'a ni secret ni droit d'écriture | — | chemin non traité (ESTIMÉ) |

## 5. Justification des privilèges (workflows après la branche de cette campagne)

| Job | Privilège | Pourquoi inévitable | Statut |
|---|---|---|---|
| `release.yaml` `draft` | `contents: write`, `id-token: write`, `attestations: write` | créer le brouillon et ses assets ; identité Sigstore sans clé ; stocker l'attestation | PREPARED |
| `release.yaml` `check`, vérifications | `contents: read` (+ `checks: read` pour `check`) | lire les check-runs du commit | PREPARED |
| `zenodo.yaml` | `contents: read`, environnement `zenodo` | ne dépose que les octets vérifiés d'une release publiée ; plus d'écriture dans le dépôt | PREPARED |
| `bump-lean.yaml` `build` | `contents: read`, aucun secret | exécute du code amont | PREPARED |
| `bump-lean.yaml` `open-pr` | `contents: read`, environnement `bump-lean`, `BUMP_TOKEN` | n'exécute aucun code Lean | PREPARED |
| `ci.yaml` `status` | `contents: write`, `pull-requests: write`, `persist-credentials: true` | pousser `automation/generated-status` et ouvrir la PR de `docs/STATUS.md` (voir `.github/workflows/README.md`, « Statut généré ») ; ne s'exécute que sur `main` après `CI OK` ; ajouté sur `main` après l'audit, **non audité par la campagne** au-delà de cette ligne | PARTIAL |
| `ci.yaml` `deploy-pages` | `pages: write`, `id-token: write` | exigés par `actions/deploy-pages` ; ne s'exécute que sur `main` après `CI OK` | VERIFIED |
| `scorecard.yaml` | `security-events: write`, `id-token: write` | publication du résultat par OIDC et envoi du SARIF | VERIFIED |

Retiré par la branche : `artifact-metadata: write` (superflu), `contents: write` de `zenodo` et de `bump-lean`.

## 6. Hypothèses de sécurité

À tenir pour vraies, **non vérifiées** depuis la session qui a produit ce document :

- Le compte GitHub de la mainteneuse est protégé par une 2FA résistante à l'hameçonnage.
- GitHub, Sigstore et Zenodo sont honnêtes ; l'isolement entre runners hébergés est effectif.
- Les organisations amont `leanprover`, `leanprover-community` et `actions` ne sont pas compromises au moment d'une montée de version.
- La mainteneuse relit réellement les diffs de `.github/workflows/`, `scripts/ci/`, `.claude/` avant de fusionner (aucune trace : zéro revue sur 13 PR).
- Les sessions d'agents n'ont pas de droit de fusion non supervisé (mode de permission non vérifié).
- `BUMP_TOKEN` est un PAT à granularité fine, limité à ce dépôt, sans la permission « Workflows ».
- L'historique de `main` reste linéaire et fusionné par rebase : la garde « `CI OK` » de `release.yaml` ne contrôle que l'application émettrice du check, ni le workflow, ni l'événement qui l'a produit.

## 7. Risques résiduels

R1 compromission du compte de la mainteneuse (impact critique) ; R2 vol ou abus de `BUMP_TOKEN` ; R3 publication Zenodo falsifiée, mal
rattachée ou en doublon ; R4 empoisonnement de cache avant la release ; R5 agent piégé ; R6 amont compromis (elan, oléans de Mathlib,
bundle TeX), non couvert par des empreintes ; R7 PDF non démontré reproductible, donc non re-vérifiable par reconstruction.

## 8. Limites de ce document

Non vérifiés ici : réglages GitHub (environnements, politique Actions, immuabilité du dépôt), 2FA, Zenodo, portée des secrets, validité
cryptographique des attestations. Ce modèle est un brouillon structuré à relire et à corriger par l'autrice ; il ne remplace pas une revue de
sécurité humaine (`ACTIONS-HUMAINES.md`, § 7).
