<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Actions humaines requises

| | |
|---|---|
| Nature | Liste consolidée de ce que le dépôt ne peut pas accomplir seul : réglages GitHub, compte, Zenodo, site du badge, vérifications à rejouer hors du bac à sable. |
| Origine | Dédoublonnage des listes des six audits (`docs/security/workstreams/*/AUDIT.md`). |
| Statut | Au 2026-10-10, la répétition `workflow_dispatch` du workflow `Release` sur `main` a réussi (contrôles et build à blanc, sans brouillon ni publication). Le ruleset « PR on main » a été lu le 2026-10-09 ; les réglages administratifs, le compte, les environnements, les secrets et Zenodo restent à vérifier ou à exécuter. |
| Décisions associées | `docs/security/DECISIONS-REQUISES.md` (identifiants D1 à D11) |

Les commandes `gh api` ci-dessous se lisent avec un jeton qui a les droits sur le dépôt ; certaines exigent les droits d'administration.

**Portée actuelle (2026-10-10).** Ce document ne conserve que les opérations humaines encore à vérifier ou à décider. La répétition manuelle du workflow `Release` a réussi, mais n'a pas exercé la publication réelle, Zenodo, ni les paramètres d'administration. La campagne est en pause temporaire ; ne pas interpréter cette pause comme une validation des points ci-dessous.

## 0. Ordre conseillé

La campagne est **fusionnée** (PR #28, 2026-10-06). La répétition manuelle du workflow `Release` a réussi le 2026-10-10 sur `main` ; c'est un essai à blanc qui ne crée ni brouillon ni attestation et ne publie rien. Il ne valide pas les paramètres administratifs ni le parcours de publication réel.

1. **Priorité administrative** : créer les environnements `zenodo` et `bump-lean` **avec leurs protections** (§ 1.4), avant tout `workflow_dispatch` de `bump-lean.yaml`, avant la prochaine exécution planifiée de ce workflow et avant toute publication.
2. Déplacer les secrets vers les environnements, puis supprimer les secrets de dépôt correspondants ; vérifier la règle de tags, l'immuabilité, les permissions Actions et les contrôles de sécurité (§ 1).
3. Trancher la décision DOI D1 et répéter le flux Zenodo sur le sandbox avant toute publication (§ 3 et § 5).
4. Avant la première release de spécification : achever les vérifications du § 5, notamment la vérification locale de l'attestation et la relecture des métadonnées.

### 0.1 Résultat de la répétition Release

| Contrôle | État au 2026-10-10 | Limite |
|---|---|---|
| `CI OK` sur `main` | réussi selon le résultat communiqué par la mainteneuse | ne prouve pas la configuration administrative GitHub |
| Workflow `Release` lancé manuellement sur `main` | réussi selon le résultat communiqué par la mainteneuse | `workflow_dispatch` n'émet ni brouillon ni attestation et n'exerce pas l'événement réel de tag |
| Publication réelle et archivage Zenodo | non exécutés par cette répétition | à garder comme actions séparées ; elles comportent des étapes irréversibles |

Les réglages administratifs ci-dessous sont distincts des contrôles de code et ne sont pas considérés comme validés par la réussite du workflow.

## 1. Réglages GitHub

### 1.1 Ruleset de `main` (Settings → Rules → Rulesets → « PR on main »)

- Cocher « Require branches to be up to date before merging » (décision D6). Coût : une relance de CI après chaque mise à jour du tronc.
- Facultatif : « Require conversation resolution before merging », « Dismiss stale pull request approvals… », et ne garder que « Rebase »
  comme méthode de fusion autorisée.
- **Ne pas toucher** : « Required approvals » (0), « Require review from Code Owners », « Require approval of the most recent
  reviewable push », liste de contournement (vide). Avec une seule personne, les activer bloquerait toute PR ou créerait un
  contournement systématique, qui ne serait pas une revue.
- **Constat vérifié le 2026-10-09** via `GET /repos/AntheaLiles/k7pl/rulesets/24138119`: ruleset actif, cible `~DEFAULT_BRANCH`, règles `deletion`, `non_fast_forward`, `pull_request`, `required_linear_history` et status check `CI OK`; `bypass_actors: []`.
- **Écarts observés** : `required_approving_review_count: 0` et `strict_required_status_checks_policy: false`. La revue indépendante ne peut pas être exigée sans second mainteneur ; décider séparément si l'exigence « branche à jour » doit être activée. Ne pas présenter la présence d'une PR obligatoire comme une revue indépendante.

### 1.2 Paramètres du dépôt (Settings → General → Pull Requests)

Décocher « Allow merge commits » ; garder « Allow rebase merging » ; cocher « Always suggest updating pull request branches » et
« Automatically delete head branches ». Vérifier : `gh api repos/AntheaLiles/k7pl` → `allow_merge_commit: false`, `allow_update_branch: true`,
`delete_branch_on_merge: true`.

### 1.3 Règle de tags (Settings → Rules → Rulesets → New tag ruleset)

Motifs `spec-v*` et `v*` ; restreindre la **création**, la **mise à jour** et la **suppression**, bloquer les force-push. Contournement : le
rôle « Repository admin » seulement (c'est l'autrice qui pose les tags : la CI n'en crée aucun). **Restreindre la création est essentiel** :
sans cela, la règle n'empêcherait pas de poser `spec-vX.Y.Z` sur un commit hors `main` dont `release.yaml` aurait été modifié, et le job
de brouillon produirait alors une attestation valide.

**Limite connue.** Cette règle n'arrête pas un identifiant qui hérite du contournement administrateur (un jeton personnel de l'autrice, une
session d'agent qui agit sous son compte : ESTIMÉ, non vérifié). `BUMP_TOKEN` a besoin du droit d'écriture sur le contenu pour pousser sa
branche ; il peut donc aussi créer des tags et publier une release, ce qui la rend immuable et déclenche Zenodo. Préférer, pour ce jeton, une
GitHub App qui n'est pas dans la liste de contournement ; à défaut, un jeton à granularité fine sur ce seul dépôt. Après publication, le tag
est de toute façon verrouillé par l'immuabilité de la release. Tester sur un tag jetable, **jamais** sur `spec-v0.0.0-alpha.1`.
Vérifier : `gh api "repos/AntheaLiles/k7pl/rulesets?targets=tag"` non vide.

### 1.4 Environnements (Settings → Environments)

| Environnement | Restriction de déploiement | Secrets | Variables | Relecteur |
|---|---|---|---|---|
| `zenodo` | tags `spec-v*` uniquement | `ZENODO_TOKEN` | `ZENODO_ENV` (`production` ou `sandbox`), `ZENODO_CONCEPT_RECID` (entier, ou `NEW`) | l'autrice, **sans** « Prevent self-review » : c'est une porte manuelle avant une publication irréversible, **pas une revue** |
| `bump-lean` | branche `main` uniquement | `BUMP_TOKEN` | — | aucun |
| `github-pages` (existe) | vérifier qu'il est limité à `main` | — | — | — |

Vérifier : `gh api repos/AntheaLiles/k7pl/environments` ; une PR de test ne voit pas `ZENODO_TOKEN`.

### 1.5 Actions (Settings → Actions → General)

« Fork pull request workflows » : approbation exigée pour tous les contributeurs externes ; « Workflow permissions » : lecture seule du contenu ;
**ne pas décocher** « Allow GitHub Actions to create and approve pull requests » tant que le job `status` de `ci.yaml` ouvre la PR de `docs/STATUS.md` (voir D11 : sans ce réglage, `gh pr create` échoue) ; si possible, exiger l'épinglage par SHA complet. Vérifier :
`gh api repos/AntheaLiles/k7pl/actions/permissions/workflow`.

### 1.6 Releases immuables (Settings → General → Releases)

Confirmer que l'immuabilité est active (la release existante l'est) et **ne pas la désactiver** pour contourner la CI : la procédure de
publication a été adaptée (décision D2). Vérifier après la prochaine release : `gh api repos/AntheaLiles/k7pl/releases --jq '.[0].immutable'` → `true`.

### 1.7 Sécurité (Settings → Code security)

Activer « Secret scanning » et « Push protection », vérifier « Dependabot alerts ». Le signalement privé de vulnérabilité est déjà activé.
Consulter Security → Advisories, Dependabot alerts et Code scanning, et reporter le résultat dans les justifications du formulaire CII.

### 1.8 Jeton `BUMP_TOKEN`

Remplacer par un jeton à granularité fine : dépôt `k7pl` seul, Contents et Pull requests en lecture-écriture, **sans** la permission « Workflows »,
expiration ≤ 90 jours ; révoquer l'ancien. Vérifier : un `workflow_dispatch` de « Bump Lean », quand une version plus récente existe, crée la PR et la
CI démarre.

## 2. Compte

- **2FA** : active, de préférence par clé d'accès, sans SMS (Settings → Password and authentication). Sur un dépôt personnel, la
  compromission du compte est la compromission du projet. Idem pour Zenodo.
- **Continuité d'accès** (critère CII Silver) : Settings → Account → « Successor settings » → « Add successor ». Ce réglage ne couvre que le décès,
  après justificatif et délai, et le successeur ne peut pas se connecter : il ne suffit pas. Le compléter par un coffre (codes de récupération 2FA,
  accès Zenodo et ORCID, procédure de rotation de `ZENODO_TOKEN` et `BUMP_TOKEN`) ou par une organisation à deux propriétaires.

## 3. Zenodo (décision D1)

1. Ouvrir l'enregistrement `10.5281/zenodo.23040451` : DOI de concept ou de version ? Fichiers déposés (archive du dépôt ou PDF) ? Mode de création ?
2. Sur zenodo.org, onglet GitHub du compte : l'interrupteur du dépôt `AntheaLiles/k7pl` est-il actif ? Choisir **un seul** canal (intégration native
   **ou** `zenodo.yaml`), le consigner dans `docs/tracking/DECISIONS.md`.
3. Contrôler l'identifiant Software Heritage du README : `swh:1:dir:b81695cf…` ne correspond pas à l'arbre git du tag (`87a04386…`) d'après l'audit.
   S'il ne désigne pas le contenu du tag, corriger ou retirer la mention.
4. Répéter sur le sandbox (`ZENODO_ENV=sandbox`) avant la production.

## 4. Site des bonnes pratiques (bestpractices.dev)

1. Déclarer d'abord ce qu'est « le logiciel produit par le projet » (annexe D de `DECISIONS-REQUISES.md`).
2. Relire ou renseigner chaque critère sur `https://www.bestpractices.dev/fr/projects/15239/{passing,silver,gold}/edit` : n'indiquer `Met` que si la preuve
   citée existe. Ne pas reprendre aveuglément l'auto-remplissage (GitHub ne détecte pas la licence : `NOASSERTION`). Vérifier via
   `https://www.bestpractices.dev/projects/15239.json`.
3. Éditer les notes de la release `spec-v0.0.0-alpha.1` (résumé lisible à la place de la liste auto-générée) et cocher « pre-release » (D10).
4. Décisions de contenu qu'aucun agent ne peut prendre : gouvernance, feuille de route, DCO, langue des signalements, canal du code de conduite.
5. Facultatif, sur décision : ajouter le badge du projet au README.

## 5. Avant la première release de spécification

- [ ] DOI : D1 tranchée ; variable `ZENODO_CONCEPT_RECID` renseignée.
- [ ] Environnements `zenodo` et `bump-lean` créés et protégés ; secrets déplacés ; secrets de dépôt supprimés.
- [ ] Règle de tags active ; immuabilité confirmée.
- [ ] Répétition complète sur le sandbox Zenodo : tag d'essai → brouillon contenant le PDF, le `.sha256` et le bundle `.sigstore.json` → vérification locale
  → brouillon supprimé sans publication → tag d'essai supprimé (impossible après publication).
- [ ] Vérification locale du brouillon, depuis une machine sans restriction réseau :
  `gh attestation verify k7pl-spec.pdf --repo AntheaLiles/k7pl --bundle k7pl-spec.pdf.sigstore.json --signer-workflow AntheaLiles/k7pl/.github/workflows/release.yaml --source-ref refs/tags/spec-vX.Y.Z --source-digest "$(git rev-parse spec-vX.Y.Z^{commit})" --deny-self-hosted-runners`
  (`--source-digest` et `--deny-self-hosted-runners` sont désactivés par défaut : sans eux, la vérification ne contrôle ni le commit ni le type de runner).
- [ ] Métadonnées de publication relues (D5) : **Zenodo les figera.**

## 6. Vérifications à rejouer hors du bac à sable de la session

| Vérification | Procédure | Pourquoi ici ne suffit pas |
|---|---|---|
| Attestation de release existante | `gh release verify spec-v0.0.0-alpha.1 -R AntheaLiles/k7pl`, depuis une machine sans proxy | l'hôte des bundles est refusé : le message « no attestations » obtenu ici est trompeur et ne prouve rien |
| État de CI de `K7pl` | `gh run list --repo AntheaLiles/k7pl --workflow CI --branch main --limit 5`, puis le journal du job `impl` : `Build completed successfully`, `N/N tests passed`, sortie de `lake lint`, ligne `axiom-audit … all within the allowlist` | `lake build K7pl`, `lake test` et `lake lint` exigent Mathlib et n'ont jamais été exécutés par les agents |
| Score Scorecard publié | `https://scorecard.dev/viewer/?uri=github.com/AntheaLiles/k7pl` ; sinon le journal du job `Scorecard` après fusion | `api.securityscorecards.dev` est refusé ; le score « avant » (6,0) a été lu dans le journal du job |
| Agents enregistrés | sortie de `/agents` : les 14 agents apparaissent-ils avec leur modèle ? | hypothèse non testée sur l'en-tête SPDX placé avant le bloc de métadonnées (D3) |

## 7. Revue de sécurité humaine (critère CII Gold)

Les audits de cette campagne sont des rapports d'agents, **non validés par une personne**. Une revue de sécurité conduite, datée et signée
par l'autrice, appuyée sur ces rapports, serait la seule façon honnête de satisfaire ce critère. Aucun document `SECURITY-REVIEW.md` ne doit être
créé sans cette revue.
