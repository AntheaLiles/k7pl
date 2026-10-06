<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Vérification finale indépendante : campagne OpenSSF

| | |
|---|---|
| Rôle | `verification-specialist` (n'a écrit aucun des changements vérifiés) |
| Cible | `ce606a9` (`docs(security): ajouter le modèle de menace et le registre des revendications`), comparée à la base `b5f6146` |
| Date | 6 octobre 2026 |
| Question posée | Chaque affirmation de la campagne est-elle démontrée par un contrôle qui pourrait échouer ? (et non : la CI est-elle verte ?) |
| Étiquettes | **[EXÉCUTÉ]** commande lancée par moi, sortie observée · **[LU]** fichier, journal ou rapport lu, non rejoué · **[ESTIMÉ]** non vérifié |
| Classement | `VERIFIED` · `PARTIAL` · `BLOCKED` · `NOT VERIFIED` (règle `.claude/rules/verification.md` : une vérification plus faible ne vaut pas preuve d'une propriété plus forte) |
| Réseau | HTTPS via le proxy de la session ; `zenodo.org`, l'API des environments et `GH_TOKEN` (invalide) indisponibles |

**Verdict global : `PARTIAL`.** Rien n'est `BLOCKED` : aucun fichier protégé n'a été touché (§ 6), toutes les commandes rejouées passent, et aucune des affirmations relues n'est contredite par un fait observé. Mais les contrôles **ajoutés** ont des angles morts réels (§ 7) : le code de sortie du processus des trois scripts n'est testé nulle part, le câblage de `--check-tags` non plus, un test de taille de manifeste n'a pas d'oracle. Les workflows `release.yaml`, `zenodo.yaml` et `bump-lean.yaml` n'ont jamais tourné sur GitHub : ils restent `PREPARED`, ce que la campagne dit elle-même.

## 1. Commandes rejouées par moi

Toutes depuis la racine du worktree à `ce606a9`, sauf mention.

| # | Commande | Résultat observé | Étiquette | Classement |
|---|---|---|---|---|
| 1 | `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` | `Ran 131 tests … OK` (51 + 49 + 31, cohérent avec les rapports des deux agents) | [EXÉCUTÉ] | VERIFIED |
| 2 | même suite, lancée depuis `/tmp` avec chemin absolu | `Ran 131 tests … OK` | [EXÉCUTÉ] | VERIFIED |
| 3 | même suite dans `unshare -rn` (réseau coupé ; sonde : `connect` → `Network is unreachable`) | `Ran 131 tests … OK` | [EXÉCUTÉ] | VERIFIED |
| 4 | même suite avec `python3 -S` (aucun site-packages ; `requests` non importable, sonde faite) | `Ran 131 tests … OK` : l'étape de `ci.yaml` n'a besoin d'aucune installation | [EXÉCUTÉ] | VERIFIED |
| 5 | `python3 scripts/controle.py` | `TOUS LES CONTROLES PASSENT`, code 0 | [EXÉCUTÉ] | VERIFIED |
| 6 | `actionlint` 1.7.12 + `shellcheck` sur `.github/workflows/*.yaml` (10 fichiers) | aucune sortie, code 0. Sonde négative : un `echo $x` non cité dans un workflow jetable fait échouer la même invocation (`SC2086`, code 1) | [EXÉCUTÉ] | VERIFIED |
| 7 | `zizmor --offline` persona `regular` (workflows + `dependabot.yml`) | 20 constats (13 supprimés par le persona) : 7 × `self-repository`, tous `low`, rien d'autre | [EXÉCUTÉ] | VERIFIED |
| 8 | `zizmor --offline` persona `auditor` | 20 constats : 7 `self-repository`, 5 `anonymous-definition`, 4 `concurrency-limits`, 2 `undocumented-permissions`, 1 `superfluous-actions`, 1 `excessive-permissions` (`scorecard.yaml:16`). Tous ces motifs existaient à `b5f6146` | [EXÉCUTÉ] | VERIFIED |
| 9 | mêmes deux zizmor sur `b5f6146` (`git archive`, comparaison) | base : 32 constats chacun, dont `template-injection`, 2 × `dependabot-cooldown`, 4 × `secrets-outside-env` (auditor). Disparus à `ce606a9` : ces trois familles. **Aucun constat nouveau** | [EXÉCUTÉ] | VERIFIED |
| 10 | `python -m reuse lint` (reuse 6.2.0) | 385/385 fichiers avec copyright et licence ; conforme à REUSE 3.3 (mon fichier non encore compté) | [EXÉCUTÉ] | VERIFIED |
| 11 | `python3 scripts/ci/check_manifest.py` | `all checks passed`, code 0 | [EXÉCUTÉ] | VERIFIED |
| 12 | `python3 scripts/ci/check_manifest.py --check-tags` (réseau) | `all checks passed (including upstream tags)` : `rev` des 3 dépendances directes = commit du tag amont | [EXÉCUTÉ] | VERIFIED (état du 6 octobre) |
| 13 | `python3 scripts/ci/check_lean_modules.py` | `7 Lean file(s) … all reachable from the 9 root(s) of 7 … target(s)`, code 0 | [EXÉCUTÉ] | VERIFIED |
| 14 | 18 actions : SHA du `uses:` contre `git ls-remote` du tag du commentaire (avec forme pelée) | 18/18 identiques ; 43 `uses:` externes, tous épinglés sur 40 hex et commentés | [EXÉCUTÉ] | VERIFIED |
| 15 | `scripts/claude-session-start.sh` : `bash -n`, `shellcheck`, téléchargement indépendant des deux archives elan v4.2.4 | SHA-256 x86_64 `42b94d42…1f63` et aarch64 `05febd12…2bf9` = valeurs du script ; chaque archive ne contient que `elan-init` | [EXÉCUTÉ] | VERIFIED (même chemin réseau que les agents : ce n'est pas une seconde origine) |
| 16 | hook exécuté dans un `HOME` jetable (`env -i`, dossier de projet vide) | elan 4.2.4 installé, `PATH` écrit dans `CLAUDE_ENV_FILE`, code 0. Copie du script avec 8 premiers hex de la somme remplacés par `0` : `SHA-256 mismatch … elan was NOT installed`, aucun `~/.elan`, code 0 (best effort voulu) | [EXÉCUTÉ] | VERIFIED |
| 17 | Scorecard v5.5.0 local (binaire compilé par un agent) sur exports propres, 7 contrôles fondés sur les fichiers | `b5f6146` : Binary-Artifacts 10, Dangerous-Workflow 10, Fuzzing 0, License 9, Pinned-Dependencies 9, Security-Policy 4, Token-Permissions 10 = journal distant. `ce606a9` : seul changement, Pinned-Dependencies **10** (hook épinglé) | [EXÉCUTÉ] | VERIFIED (binaire non attesté) |
| 18 | reproduction de la regex supprimée de `ci.yaml` (`grep -Eq`, guillemets du bloc `run`) | 5 alternatives sur 8 ne correspondent à aucun chemin réel (`lakefile.lean`, `lake-manifest.json`, `dependabot.yml`, `sync_zenodo.py`, `requirements-zenodo.txt`) | [EXÉCUTÉ] | VERIFIED |
| 19 | blocs `run:` de `release.yaml` (`Resolve…`, `Check the release metadata…`) extraits et rejoués dans un dossier jetable | 9 cas de résolution et 4 cas de métadonnées conformes à l'attendu (tag non-version, branche, injection `;id`, kind inconnu : refus ; métadonnées réelles du dépôt : refus pour `spec 0.0.0-alpha.1` car `spec/CHANGELOG.md` n'a pas de section, pour `v9.9.9` car `lakefile.lean` dit `0.1.0`) | [EXÉCUTÉ] simulation | PARTIAL (voir § 3.3) |
| 20 | bloc `Audit the axioms (tests)` de `verify.yaml` avec un `axiom-audit.sh` factice | propre : 3 racines, code 0 ; une racine en échec : la boucle continue, `::error::` nomme la racine, code 1 ; deux racines en échec : deux annotations, code 1 | [EXÉCUTÉ] simulation | PARTIAL |
| 21 | API publique (curl) : release, signalement privé, ruleset 24138119, règles de tags | `spec-v0.0.0-alpha.1` : `immutable: true`, 0 asset ; `private-vulnerability-reporting: {"enabled": true}` ; ruleset actif (PR, suppression et force-push interdits, historique linéaire, check `CI OK` de l'app Actions, 0 approbation) ; liste des règles de tags : vide | [EXÉCUTÉ] | VERIFIED |
| 22 | journaux et jobs GitHub (lecture) : run `37424012908` (CI, `3fd82f1`), run `37385570410` (Scorecard, `b5f6146`), runs `37385570730` et `36569899593` | voir § 3.1 | [LU] | VERIFIED pour ce qu'ils montrent |

**Non lancé, par consigne ou faute de moyen** : `lake build`, `lake test`, `lake lint` du dépôt (Mathlib indisponible), `gitleaks`, `commitlint`, `lychee` (j'ai fait un contrôle de liens équivalent : § 5), audits en ligne de zizmor, toute exécution sur GitHub Actions.

## 2. Contrôle par mutation indépendant

**Méthode.** Un harnais à moi (`ast`, un nœud muté à la fois : comparaisons, opérateurs booléens, `not`, conditions niées ou forcées à faux, constantes, chaînes sémantiques, suppression de `raise`/`continue`/appels/affectations, valeur de retour) appliqué à une copie jetable hors dépôt, puis le fichier de tests correspondant. Contrôle préalable : la source normalisée (`ast.unparse`) non mutée passe chaque suite. Ensuite 38 mutants **écrits à la main** sur des comportements précis, différents de ceux des `VALIDATION.md` (ils avaient 15, 13 et 25 mutants choisis ; aucun n'est repris tel quel). Les scripts de mutation sont dans le scratchpad de la session et ne sont pas versionnés.

| Cible | Tests | Mutants AST | Tués | Survivants |
|---|---|---|---|---|
| `scripts/ci/impact.py` | `test_impact` | 174 | 143 | 31 |
| `scripts/ci/check_lean_modules.py` | `test_check_lean_modules` | 324 | 270 | 54 |
| `scripts/ci/check_manifest.py` | `test_check_manifest` | 335 | 281 | 54 |
| `scripts/sync_zenodo.py` | `test_sync_zenodo` | 462 | 368 | 94 |
| **Total** | | **1 295** | **1 062 (82 %)** | **233** |
| Mutants manuels | idem | 38 exécutés (1 motif non appliqué) | 16 | **22** |

**Tri des survivants (partiel, non exhaustif).** Une partie est sans conséquence : messages d'erreur et de journal, valeurs de `timeout`, taille de bloc de lecture, défenses redondantes (`netloc` déjà comparé en entier, `RecursionError` couvert par un autre `except`), branche morte déjà présente dans `impact.py` (`elif … pass`, lignes 65-66, 5 mutants), blanchiment des commentaires dans `strip_comments`. Je n'ai pas classé les 233 un par un ; **ce qui suit est ce que j'ai jugé significatif**, avec le mutant manuel qui le démontre.

| Mutant manuel | Fichier | Effet du mutant | Résultat |
|---|---|---|---|
| L1 | `check_lean_modules.py` | `raise SystemExit(main())` → `main()` : le script sort toujours 0 | **survit** |
| M1 | `check_manifest.py` | `sys.exit(main())` → `main()` | **survit** |
| Z1 | `sync_zenodo.py` | `sys.exit(run())` → `run()` | **survit** |
| M2 | `check_manifest.py` | `run()` ignore `tags` (`if False`) | **survit** |
| M4 | `check_manifest.py` | `main()` transmet `False` à `run()` à la place de `--check-tags` | **survit** |
| M3 | `check_manifest.py` | plafond `MAX_MANIFEST_BYTES` retiré | **survit** |
| M5 | `check_manifest.py` | fragment d'URL non rejeté | **survit** |
| M6 | `check_manifest.py` | forme du nom de dépôt (`SEGMENT_RE`) non contrôlée | **survit** |
| I1 | `impact.py` | `--diff-filter=ACDMRT` → `ACMRT` : un fichier supprimé ne compte plus | **survit** |
| I2 | `impact.py` | `--no-renames` retiré : un renommage `src/` → `docs/` masque le chemin supprimé | **survit** |
| I3 | `impact.py` | `check=True` → `False` : un `git diff` en échec donne zéro chemin, donc rien à valider | **survit** |
| I8 | `impact.py` | tout `.lean` hors dossiers connus classé « léger » (au lieu d'inconnu → complet) | **survit** |
| L5, L6 | `check_lean_modules.py` | racine par défaut d'un `lean_exe` (`Main`) ou d'une `lean_lib` (son nom) | **survivent** |
| Z2 | `sync_zenodo.py` | échec d'un `DELETE` de fichier hérité toléré (`check()` retiré) | **survit** |
| Z3 | `sync_zenodo.py` | `run()` sans `environ` n'utilise plus `os.environ` (chemin de production) | **survit** |
| Z4 | `sync_zenodo.py` | préfixe `spec-v` non exigé (seul `VERSION_RE` sur la fin du tag) | **survit** |
| Z6 | `sync_zenodo.py` | repli « lire la somme dans la liste des fichiers » désactivé | **survit** |
| Z7, Z8, Z9 | `sync_zenodo.py` | `publication_date` non posée ; valeur de l'en-tête `Authorization` ; dossier par défaut | **survivent** (faible portée) |

Tués (utile à savoir : ces contrôles ont bien un oracle) : I5 (`dependabot.yml` rétrogradé), I6, I7, L2, L3, L4, L7, L8, M8 (propriétaire `acmepjz`), Z5, Z10 à Z15 (concept ≠ version, somme incohérente, double archivage, plusieurs PDF, caractères d'espacement dans l'URL, fichier jamais envoyé).

## 3. Affirmation par affirmation

Grille : propriété → niveau → oracle → erreur détectable → résultat → classement.

### 3.1 `docs/security/ASSURANCE-CASE.md` § 1 (revendications étayées)

| Id | Propriété visée (niveau) | Oracle | Erreur détectable | Résultat observé par moi | Classement |
|---|---|---|---|---|---|
| C1 | actions épinglées par SHA et SHA = cible du tag annoncé (configuration + exactitude) | `ls-remote` amont, forme pelée comprise | SHA qui ne correspond plus à son tag, action non épinglée | 43 `uses:` externes, 43 épinglés, 18 actions distinctes, 18/18 = tag amont [EXÉCUTÉ]. Ne couvre pas ce que les actions téléchargent (dit par le registre) | VERIFIED |
| C2 | aucun déclencheur à risque (configuration) | recherche textuelle dans les 10 workflows | `pull_request_target`, `workflow_run`, `issue_comment` | aucune occurrence [EXÉCUTÉ] | VERIFIED |
| C3 | `main` protégée, check `CI OK`, sans contournement (configuration GitHub) | API publique du ruleset | règle absente ou contournable | PR, `deletion`, `non_fast_forward`, `required_linear_history`, check `CI OK` (app 15368) présents ; `bypass_actors: []` lu **sans** authentification, valeur à confirmer en interface [EXÉCUTÉ] | PARTIAL (contournement non confirmé) |
| C4 | dépendances Lake épinglées par commit (configuration) ; « identiques aux pins amont » (exactitude) | `check_manifest.py`, `--check-tags` | `rev` mal formé ou ≠ tag | 14 paquets, 14 `rev` de 40 hex ; 3 directes = tag amont [EXÉCUTÉ]. Les 11 héritées ne sont liées à aucun tag : « identiques aux manifestes amont » n'est pas rejoué | PARTIAL |
| C5 | signalement privé activé | API publique | désactivé | `{"enabled": true}` [EXÉCUTÉ] | VERIFIED |
| C6 | release `spec-v0.0.0-alpha.1` immuable | champ `immutable` | release modifiable | `immutable: true`, 0 asset [EXÉCUTÉ] ; le réglage du dépôt reste illisible | VERIFIED (cette release) |
| C7 | tout module de `src/` et `tests/` est atteint (structure) | `check_lean_modules.py` + Lake | orphelin | script : 7 fichiers atteints [EXÉCUTÉ] ; run CI `37424012908`, job `Implémentation Lean`, étape « Check that every Lean file is built » `success` [LU] ; `src/`, `tests/`, `lakefile.lean`, `verify.yaml`, `check_lean_modules.py` sont **identiques** entre `3fd82f1` et `ce606a9` [EXÉCUTÉ, `git diff --stat` vide]. La détection d'orphelins est démontrée par les tests ; son code de sortie ne l'est pas (V1) | VERIFIED (état) |
| C8 | aucun `sorry`/`axiom`/`native_decide` dans les racines auditées (audit d'axiomes, liste `propext`, `Classical.choice`, `Quot.sound`) | `axiom-audit` v0.1.2 | axiome hors liste | même run : étapes `Audit the axioms` K7pl, tests, Spec, SpecExt, SpecBib toutes `success` ; journal : `ArithTest` 2, `MainTest` 4, `SemanticsTest` 1 déclarations, « all within the allowlist » [LU] ; compteurs `Spec` 1319, `SpecExt` 586, `SpecBib` 2 non relus. Je n'ai pas rejoué l'audit (Lean/Mathlib) | PARTIAL (comme le dit le registre) |
| C9 | scores Scorecard « fichiers » reproductibles | binaire local, export propre | écart de score | 7 scores identiques aux miens ; le journal `37385570410` donne score **6,0** et les 18 scores du § 2.A de l'audit, ligne à ligne [LU + EXÉCUTÉ] ; binaire compilé par un agent, non attesté | VERIFIED |

### 3.2 `ASSURANCE-CASE.md` § 2 (revendications non vraies) et `OPENSSF-AUDIT.md` § 0

| Id | Énoncé | Résultat observé | Classement |
|---|---|---|---|
| N1, N2 | PDF joint / artefact publié : faux aujourd'hui | release sans asset [EXÉCUTÉ] ; README et CONTRIBUTING reformulés (diff lu) | VERIFIED |
| N3 | secrets non protégés par un environment | API des environments refusée par le proxy ; les workflows déclarent `environment: zenodo` et `bump-lean` [LU] ; protection réelle non lisible | NOT VERIFIED (action humaine, dite) |
| N4 | aucune règle de tags | liste publique vide [EXÉCUTÉ] | VERIFIED (faiblement : lecture non authentifiée) |
| N5 | `warningAsError` absent des `lean_exe` | `lakefile.lean` : `leanOptions` seulement sur les `lean_lib` [LU] ; comportement établi sur mini-projet par l'agent, non rejoué | PARTIAL |
| N6 | pas d'implémentation de référence ; métadonnées l'affirment | `CITATION.cff:24` et `zenodo.json:3` contiennent bien « implémentation de référence » ; `spec/` et `tools/` n'importent ni `K7pl`, ni Mathlib, ni Cslib [EXÉCUTÉ]. **Imprécision** : l'audit cite aussi `zenodo.files.json:4`, qui dit « exemples vérifiés par Lean 4 » (plus faible) | VERIFIED (avec la réserve) |
| N7 | aucune revue indépendante | 0 approbation requise [EXÉCUTÉ] ; « 0 revue sur 13 PR » non rejoué | PARTIAL |
| N8 | délai de 7 jours | engagement, pas une preuve | n/a (dit par le registre) |
| § 0 pt 1 | « aucun écart exploitable sans identifiant (P0 : aucun) » | affirmation d'absence : ses appuis (pas de déclencheur à risque, 18/18 épinglés, `persist-credentials: false` 13/13) sont vérifiés, l'absence ne peut pas l'être | PARTIAL |
| § 0 pt 2 | pipeline de release inopérant et jamais exécuté | `release.yaml` de `b5f6146` lu : `gh release upload` après publication, `publish-spec` sans `checkout` ni `GH_REPO` ; seul run de release = `36569899593`, workflow « Lean Build » (`lean.yaml`), `failure`, tag `dcd65a9` [EXÉCUTÉ + LU] | VERIFIED |
| § 0 pt 3 | aucune procédure de vérification d'artefact | 0 asset [EXÉCUTÉ] | VERIFIED |
| § 0 pt 4 | DOI et SWHID du README sans origine démontrée | Zenodo et Software Heritage inaccessibles ; rien dans le dépôt ne l'établit | NOT VERIFIED (affirmation d'absence) |
| § 0 pt 5 | Scorecard 6,0 | journal du run `37385570410` [LU] | VERIFIED |
| § 0 pt 6 | un humain, zéro approbation, zéro revue | approbations : voir N7 | PARTIAL |

### 3.3 `OPENSSF-AUDIT.md` § 2 (matrice)

| Bloc | Résultat observé | Classement |
|---|---|---|
| 2.A Scorecard | les 18 scores de la matrice égalent ceux du journal `37385570410` [LU] ; mes 7 contrôles locaux égalent aussi. Les interprétations (artefact de nommage de `Security-Policy`, plafonds structurels) relèvent de la lecture du code Scorecard par un agent | VERIFIED (scores) / NOT VERIFIED (interprétations) |
| 2.B gouvernance | seul le ruleset est relu (C3) ; méthodes de fusion, Actions, 2FA, CODEOWNERS illisibles d'ici | PARTIAL |
| 2.C chaîne d'approvisionnement | épinglage des actions, manifeste, hook : rejoués. « `release.yaml` BLOCKED », « Zenodo BLOCKED » décrivent la **base** : la matrice est un rapport de vague 1 ; l'état après campagne est dans les `CHANGES.md` | VERIFIED (ce qui est rejoué) |
| 2.D assurance | pas de déclencheur à risque, `persist-credentials` 13/13 ✓ ; « agent piégé : le vecteur le plus vraisemblable » est une appréciation, non une mesure | PARTIAL |
| 2.E qualité | regex morte reproduite (§ 1 n° 18) ; `ci-ok`/`skipped` : `verification-result` n'accepte que `success` ou `skipped` [LU] ; run `37385570730` : CI `success` sur `b5f6146` [LU] ; reproductibilité du PDF « non démontrée » : exact (aucun double build dans les workflows) | VERIFIED |
| 2.F CII | critères lus dans le dépôt du site, état saisi illisible ; statuts honnêtement `HUMAN ACTION REQUIRED` | NOT VERIFIED (non vérifiable d'ici) |
| 2.G affirmations publiques | A1 (`CITATION.cff`, `zenodo.json`) ✓ avec l'imprécision de `zenodo.files.json` ; A2, A6, A8 : README, CONTRIBUTING corrigés (diff lu) ✓ ; A3 : `05aa321` existe ; A4, A5, A7 non rejoués | PARTIAL |

### 3.4 `supply-chain/CHANGES.md` et `VALIDATION.md`

| Action | Propriété et niveau | Ce qui la démontre | Ce qui manque | Classement |
|---|---|---|---|---|
| R12 `cooldown` Dependabot | configuration | YAML relu ; zizmor : `dependabot-cooldown` disparu (base : 2) [EXÉCUTÉ] | schéma Dependabot non validé par un outil ; « les mises à jour de sécurité ne sont pas retardées » est une connaissance de la documentation GitHub [ESTIMÉ] | PARTIAL |
| R8 hook elan par version et somme | comportement du script + intégrité de l'archive | n° 15 et 16 : somme, membre unique, installation, refus sur somme fausse, `shellcheck` | somme = première observation (TOFU, dit) ; aarch64 non exécuté ; l'installation du toolchain Lean par elan reste non vérifiée (dit) ; aucun test versionné du hook | VERIFIED (la propriété énoncée), limitée |
| R4 `check_manifest.py` | structure du manifeste (liste d'organisations, `rev` 40 hex, URL) | 49 tests ; 335 mutants AST, 281 tués ; mutants manuels M8 tué | M1 à M6 survivent : code de sortie, câblage `--check-tags`, plafond de taille, fragment, forme du nom de dépôt (§ 7) | PARTIAL |
| R4 `bump-lean.yaml` en deux jobs | séparation des privilèges (configuration) puis comportement | lecture : `build` sans secret, `contents: read`, `open-pr` seul avec `environment` et `BUMP_TOKEN`, ordre des étapes (régénération avant contrôle) ; zizmor : `secrets-outside-env` ×4 et `template-injection` disparus [EXÉCUTÉ] | les 8 scénarios `sim_openpr.py` ne sont pas versionnés et je ne les ai pas rejoués ; jamais exécuté sur GitHub ; tri `sort` dépendant de la locale (`C.UTF-8` donne bien l'ordre attendu [EXÉCUTÉ] ; autre locale [ESTIMÉ]) | PARTIAL (PREPARED) |
| R1 + R6 `release.yaml` | refus avant publication ; brouillon seulement | n° 19 (13 cas) ; lecture : `permissions: {}`, permissions élevées limitées à `draft`, `needs`, `if:` ; anciens contrôles conservés ou renforcés (§ 4) | le `check` des étapes `git merge-base`, `gh api …/check-runs`, et le job `draft` (19 + 5 scénarios `sim_check.py`, `sim_draft.py`) non rejoués ; `gojq` de `gh` ≠ `jq` des simulations ; jamais exécuté par Actions | PARTIAL (PREPARED) |
| R3 `zenodo.yaml` + `sync_zenodo.py` | refus avant tout appel réseau ; dépôt des octets vérifiés | 31 tests ; 462 mutants, 368 tués ; mutants manuels Z5, Z10 à Z15 tués ; `--check-config` | double de l'API écrit par l'auteur (l'oracle est sa compréhension de Zenodo) ; Z1 à Z4, Z6 survivent ; API réelle jamais jointe | PARTIAL |
| « aucun appel Zenodo, aucun tag, aucune release, aucune écriture GitHub » | absence d'effet de bord | liste des releases : une seule, ancienne, 0 asset [EXÉCUTÉ] | — | VERIFIED |
| D1, H1, H5, H7, H9, H11 | décisions et actions humaines | listées dans `ACTIONS-HUMAINES.md` | faites ni vérifiées (dit) | HUMAN ACTION REQUIRED |

### 3.5 `quality-reproducibility/CHANGES.md` et `VALIDATION.md`

| Action | Propriété et niveau | Ce qui la démontre | Ce qui manque | Classement |
|---|---|---|---|---|
| R2 `use_cache` | comportement des 3 étapes `actions/cache` | `if: ${{ inputs.use_cache }}` lu ; run CI `37424012908` (défaut `true`) : étapes de cache `success` | la branche `use_cache: false` n'a jamais été exécutée | PARTIAL (PREPARED) |
| R9 suppression du `grep` | `impact.py` seule source ; pas de chemin perdu | regex reproduite (n° 18) ; tests paramétrés, exacts, `unclassified == false`, bout en bout par sous-processus ; 174 mutants, 143 tués ; run CI : `Test the CI scripts` et `Run CI impact classifier` `success` (branche `--force-full` seulement : l'événement était un `workflow_dispatch`) | la branche `--base/--head` n'est exercée que par les tests locaux ; I1 à I3 survivent | VERIFIED (équivalence) / PARTIAL (robustesse) |
| R9 `axiom-audit.sh` → `spec_build` | classement | tests unitaires et de bout en bout ; mutants L/I6 tués | décision « Pages republiées » signalée comme à valider | VERIFIED |
| R10 `check_lean_modules.py` | atteignabilité des modules | n° 13 ; 30 tests ; 324 mutants, 270 tués ; CI `success` | L1 (code de sortie), L5, L6 ; reproduction sur mini-projet [LU] | VERIFIED (état) / PARTIAL (contrôle) |
| R10 audits SpecExt, SpecBib, tests | aucun axiome hors liste | CI `success` pour les trois ; boucle rejouée avec un `axiom-audit.sh` factice (n° 20) | échec réel de la boucle (`native_decide`) vu seulement sur mini-projet [LU], pas en CI | VERIFIED (succès) / PARTIAL (détection) |
| R10 écart au contrat (`K7plTests` n'est pas un préfixe de module) | la commande demandée échouerait | cause lue dans le code de `axiom-audit` ; étape de CI réelle réussie avec la solution retenue | reproduction de l'échec non rejouée | PARTIAL |
| R11 `SOURCE_DATE_EPOCH` + `-Z deterministic-mode` | le câblage fonctionne sur un runner | run CI `37424012908`, job `PDF de la spécification` : étapes « Compile the PDF », « Summarise », « Upload the compilation log » `success` : **Tectonic a accepté la ligne de commande et le bundle était joignable en CI**. Le rapport de l'agent classait la compilation `BLOCKED` pour son bac à sable : c'était juste, mais la CI l'a levée | déterminisme des octets : jamais mesuré (aucun double build) ; la campagne le dit et ne revendique rien | VERIFIED (câblage) / NOT VERIFIED (reproductibilité, non revendiquée) |

## 4. Régression : un contrôle a-t-il été affaibli ?

Comparaison `git diff b5f6146..ce606a9` des cinq workflows modifiés [EXÉCUTÉ + LU].

- **`ci.yaml`** : seul retrait, l'étape `grep -Eq` et l'appel conditionnel à `--force-full`. Le test remplacé (`python3 scripts/ci/test_impact.py` → `unittest discover`) exécute au moins les mêmes tests. Aucun `continue-on-error`, aucun `|| true` ajouté, aucun seuil changé.
- **Correction du défaut de `ci.yaml`.** Le défaut est une **redondance morte**, pas un comportement erroné : les 5 chemins concernés forçaient déjà `full` par `FULL_EXACT`. Le contrôle qui aurait échoué **avant** la correction n'existe donc pas (les tests paramétrés passent aussi sur l'ancien `impact.py`, dont les listes sont inchangées) ; ce qui a changé, c'est qu'un chemin retiré de `impact.py` fait maintenant échouer un test (mutants I5 tué, `FULL_PREFIXES`/`FULL_EXACT` : égalité en dur). Contrôle pertinent après : oui. Contrôle qui garantirait que `ci.yaml` ne réintroduit pas de liste parallèle : non (pas de test lisant le YAML) ; acceptable, non démontré.
- **`verify.yaml`** : ajouts seulement (entrée `use_cache` avec `if:` sur les 3 caches, étapes d'audit et de contrôle des modules, étapes de journal Tectonic). Les nouveaux `if: ${{ !cancelled() }}` n'existent que sur des étapes ajoutées ; `verification-result` est inchangé et n'accepte que `success` ou `skipped`. Les étapes de journal sont **non bloquantes par construction** (`|| true` sur des `grep -c`) : dit par la campagne, sans seuil.
- **`release.yaml`** : les contrôles de métadonnées de l'ancien fichier (`CITATION.cff`, `spec/CHANGELOG.md`, `lakefile.lean`, `CHANGELOG.md`) sont conservés et renforcés (section non vide ; tag non déplacé ; ancêtre de `main` ; check `CI OK` émis par GitHub Actions). L'appel de vérification de la spécification passe de `spec_build` à `spec_check` + `spec_build` + `use_cache: false` : plus strict. Le contrôle exécuté après publication (donc sans pouvoir bloquer) devient un contrôle avant publication. Aucun contrôle retiré.
- **`bump-lean.yaml`** : `lake update`, `lake build`, `lake test` conservés dans `build` ; ajout du contrôle du manifeste. Aucun retrait.
- **Zenodo** : l'état sur branche `zenodo-state` est supprimé, volontairement (dit, justifié) ; `ZENODO_ENV` passe de secret avec repli sur la production à variable sans repli.
- **Aucun** `sorry`, `admit`, `axiom`, `native_decide` ajouté (aucun fichier Lean modifié) ; `lakefile.lean`, `lean-toolchain`, `lake-manifest.json` intacts ; modification de `.github/workflows/` à signaler dans la PR (règle `lean.md`).

## 5. Cohérence documentation ↔ code

| Élément cité | Code | Résultat |
|---|---|---|
| noms d'artefacts `spec-pdf`, `release-notes`, `lake-manifest`, `spec-pdf-log` (README des workflows, CONTRIBUTING) | `verify.yaml`, `release.yaml`, `bump-lean.yaml` | cohérents [LU] |
| variables et secrets : secret `ZENODO_TOKEN`, variables `ZENODO_ENV` et `ZENODO_CONCEPT_RECID` (`zenodo`), secret `BUMP_TOKEN` (`bump-lean`) | `zenodo.yaml` (`vars.`, `secrets.`), `bump-lean.yaml` | cohérents [LU] |
| options `gh` : `release verify`, `release verify-asset`, `release download --dir --pattern`, `release create --draft --verify-tag --prerelease --notes-file --title`, `release list --json tagName --jq --limit`, `attestation verify --bundle --repo --signer-workflow --source-ref --source-digest --deny-self-hosted-runners` | `gh --help` de gh 2.89.0 [EXÉCUTÉ] | toutes existent ; gh des runners hébergés : non connu (H11) |
| commande de test `unittest discover -s scripts/ci -p 'test_*.py'` | `ci.yaml` | identique |
| `workflow CI`, job `CI OK`, `gh run list --workflow CI` | `ci.yaml` (`name: CI`, job `CI OK`) | cohérent |
| noms de jobs de `release.yaml` (`check`, `verify-spec`, `verify-implementation`, `draft`) | README : « job `check` », « job `draft` » | cohérent |
| chemins de fichiers cités, liens Markdown locaux des 21 fichiers modifiés | script de contrôle à moi | **0 lien Markdown cassé** [EXÉCUTÉ] ; ce que `lychee --offline` verrait est équivalent |
| `OPENSSF-AUDIT.md` en-tête : « Bilan : `docs/security/IMPLEMENTATION-STATUS.md` » | fichier absent | **référence pendante** |
| les `AUDIT.md` citent des scripts de preuve (`qr/*.sh`, `scratchpad/*`) | absents du dépôt | preuves non rejouables depuis le dépôt (règle de traçabilité de `documentation.md`) |
| notes du brouillon et CONTRIBUTING étape 4 : « rejouer en local les commandes de vérification de ses notes » | les notes listent aussi `gh release verify` et `verify-asset`, qui ne peuvent réussir qu'après la publication (l'attestation de release naît à la publication) | ambiguïté de procédure [ESTIMÉ] ; `ACTIONS-HUMAINES.md` § 5 ne cite, lui, que `gh attestation verify` pour le brouillon |
| `CHANGELOG.md` : « regex … dont cinq alternatives sur huit ne correspondaient à rien » | n° 18 | exact |

## 6. Lean, spécification et fichiers protégés

`git diff --stat b5f6146..ce606a9 -- spec src tests lakefile.lean CITATION.cff 'zenodo*.json' .claude lean-toolchain lake-manifest.json` : **sortie vide**. Idem pour `docs/suivi`, `archives`, `biblio`, `LICENSES`, `REUSE.toml`, `LICENSE.md`, `scripts/controle.py`, `scripts/controles`, `scripts/suivi.py`, `scripts/axiom-audit.sh`, `scripts/bump-lean.sh` [EXÉCUTÉ]. **Aucun `BLOQUANT`.** Fichiers touchés hors `docs/security/` : `.github/dependabot.yml`, 6 workflows, `.gitignore` (+3 lignes, `.claude/worktrees/`, mentionné dans la feuille de route), `CHANGELOG.md`, `CONTRIBUTING.md`, `README.md`, `SECURITY.md`, `scripts/` (hook, `sync_zenodo.py`, `scripts/ci/`). Analyse de motifs de secrets sur les lignes ajoutées : aucune occurrence [EXÉCUTÉ].

## 7. Tests sans oracle, mutants survivants, angles morts

Gravité par rapport à l'objectif de la campagne (contrôles qui doivent échouer quand la propriété est violée).

| Id | Gravité | Constat | Preuve |
|---|---|---|---|
| V1 | **élevée** | **Le code de sortie du processus des trois scripts ajoutés n'est testé par aucun test** : `main()`/`run()` sont appelés en direct, aucun test ne lance `python3 script.py`. Une régression de la dernière ligne (`sys.exit(main())` → `main()`) rend le contrôle non bloquant sans qu'un test échoue. La CI repose uniquement sur ce code de sortie. | mutants L1, M1, Z1 survivent ; AST : `raise SystemExit(main())` → `pass` survit (`check_lean_modules.py:282`), `sys.exit` supprimé survit (`check_manifest.py:281`, `sync_zenodo.py:554`) ; `grep subprocess` dans les trois fichiers de test : aucun appel de ce type |
| V2 | **élevée** | **Le câblage `--check-tags` n'est pas testé** : `check_tags()` l'est (doublure), pas le passage `main` → `run` → `check_tags`. Le job `open-pr` l'active comme contrôle de provenance ; le désactiver ne fait échouer aucun test. Le seul contrôle réel de ce chemin est ma commande n° 12 et celle de l'agent, à la main. | mutants M2, M4, AST lignes 250-251 de `check_manifest.py` |
| V3 | moyenne | **Test sans oracle** : `test_invalid_json_oversized_and_missing_files_fail` écrit `" " * (MAX+1)`, du blanc, qui est rejeté comme JSON invalide **même sans le plafond**. Le plafond de taille, annoncé comme testé (`VALIDATION.md` § 3.3 « trop gros »), n'a aucun oracle. | M3 survit ; AST `if size > MAX` → `if False` survit, `1 << 20` → `1 << 21` survit |
| V4 | moyenne | `impact.py` : aucun test de **suppression**, de **renommage**, ni d'**échec de `git diff`** (qui donnerait zéro chemin, donc aucune validation) ; un seul exemple de « chemin inconnu → complet » (`new-format.toml`). Code antérieur à la campagne, mais la campagne en fait la « seule source ». | I1, I2, I3, I8 survivent |
| V5 | moyenne | `sync_zenodo.py`, garde-fous d'un dépôt **irréversible** sans oracle : un `DELETE` de fichier hérité en échec est ignoré, donc une version pourrait garder l'ancien PDF (Z2) ; le préfixe `spec-v` du tag n'est pas vraiment exigé par le script (Z4, le workflow filtre en amont) ; le repli « lire la somme dans la liste » (Z6) et la lecture réelle de `os.environ` (Z3) ne sont jamais exercés ; `load_json` retombe **en silence** sur `{}` si `zenodo.json` est absent ou invalide (le test Z5 ne couvre que le nom de fichier). | Z2, Z3, Z4, Z6 survivent ; AST lignes 179, 184-185 |
| V6 | moyenne | `CHANGES.md` § 4 annonce une URL « sans … fragment » et un nom de dépôt « simple » ; ni l'un ni l'autre n'est testé. | M5, M6 survivent |
| V7 | moyenne | **Les simulations de blocs `run:` ne sont pas versionnées** (`sim_check.py` 19 cas, `sim_openpr.py` 8, `sim_draft.py` 5, `sim_ci.py`, `sim_pdf.py`, scripts de mutation). Les résultats « VERIFIED pour la logique shell » reposent donc sur des rapports. Je n'en ai rejoué indépendamment que : résolution et métadonnées de `release.yaml`, boucle d'audit, hook. Et une simulation n'est pas une exécution par Actions (expressions `${{ }}` remplacées, actions tierces, permissions du jeton, environments et `gh` réel absents). | `VALIDATION.md` § 5 et § 10 (dits par leurs auteurs) |
| V8 | moyenne | Les tests de `sync_zenodo.py` s'appuient sur un double de l'API écrit par le même auteur que le script : ils prouvent la cohérence interne, pas le contrat de Zenodo. | `VALIDATION.md` § 6 (dit) ; `zenodo.org` refusé ici |
| V9 | faible | Branches par défaut de `check_lean_modules.py` jamais testées : racine par défaut d'un `lean_exe` (`Main`) et d'une `lean_lib`, `srcDir` par défaut, `root` non littéral, modificateurs `prelude`/`private`/`meta`/`runtime` de `import`. Le dépôt n'utilise aucune de ces formes ; le risque est un faux orphelin (échec bruyant), pas un faux succès. | L5, L6 survivent ; AST lignes 105-106, 148, 157-161, 184-193 |
| V10 | faible | Valeurs par défaut et textes de `sync_zenodo.py` sans oracle : `publication_date`, en-tête `Authorization`, dossier par défaut, relations dédupliquées, message « checksum matches » dans le résumé. | Z7, Z8, Z9 ; AST lignes 283-294, 400 |
| V11 | faible | Le seul appel réel à `git ls-remote` (`git_ls_remote_tag`) est exercé par un test qui **mocke `subprocess.run`** et n'en contrôle que la ligne de commande ; son comportement réel n'est vu que par ma commande n° 12. | `test_default_query_uses_an_argument_list_with_both_ref_forms` |
| V12 | faible | Références et preuves : `IMPLEMENTATION-STATUS.md` absent ; scripts de preuve des `AUDIT.md` hors dépôt ; `zenodo.files.json:4` cité à tort pour « implémentation de référence ». | § 5 |
| V13 | faible | Aucun test versionné du hook de session (vérifié à la main, n° 15 et 16). | — |

## 8. Affirmations non démontrées

Ni démenties ni établies par un contrôle qui aurait pu échouer :

1. Le flux `release.yaml` → brouillon → publication → `zenodo.yaml` fonctionne de bout en bout (aucune exécution par Actions ; `gh release verify`, `verify-asset`, attestations et bundle, `actions/attest` non joués ; version de `gh` des runners inconnue, H11).
2. Le contrôle « tag sur `main` » et « `CI OK` émis par GitHub Actions » rejette bien un faux tag ou une CI absente sur GitHub (simulé par l'agent seulement ; `GITHUB_SHA` d'un tag annoté, slug `github-actions` : escompté, non observé).
3. `bump-lean.yaml` en deux jobs : transmission du seul manifeste par artefact, `create-pull-request` avec `add-paths`.
4. L'API Zenodo se comporte comme le double (champs `conceptrecid`, `checksum`, `related_identifiers`, relations DataCite acceptées, `newversion` réutilisant un brouillon).
5. `use_cache: false` ne restaure aucun cache (jamais exécuté).
6. Audit d'axiomes : détection réelle d'un `native_decide` dans `K7plTests` sur ce dépôt (vue sur mini-projet [LU] ; en CI seul le cas propre).
7. Reproductibilité du PDF : non démontrée, **non revendiquée** (README, SECURITY, `CHANGELOG.md`, registre : cohérents).
8. Protection effective des environments `zenodo` et `bump-lean`, règle de tags, 2FA, réglages Actions : illisibles ; décrits comme actions humaines.
9. Tout ce qui dépend de Lean/Mathlib sur le dépôt : `lake build`, `lake test`, `lake lint` à `ce606a9`. Le run `37424012908` les couvre pour `3fd82f1` ; les fichiers concernés sont identiques à `ce606a9` (§ 3.1, C7), mais les 18 fichiers modifiés depuis (workflows de release, Zenodo, bump, `check_manifest`, `sync_zenodo`, leurs tests, hook, documentation) n'ont **aucune** exécution GitHub.
10. Les 131 tests dans l'étape `Test the CI scripts` du runner : seuls 51 y ont tourné (run `37424012908`) ; les 80 autres ne l'ont été que localement (Python 3.11 ; version du runner non comparée).

## 9. Ce que je n'ai pas pu exécuter, et pourquoi

| Élément | Raison |
|---|---|
| `lake build`, `lake test`, `lake lint`, audits d'axiomes sur le dépôt | consigne : Mathlib indisponible ; jamais prétendu |
| Exécution de `release.yaml`, `zenodo.yaml`, `bump-lean.yaml` | aucune écriture GitHub autorisée ; aucun dispatch ni tag |
| API Zenodo, Software Heritage, bestpractices.dev, Scorecard distant | hôtes refusés par le proxy |
| API des environments, collaborateurs, protections classiques ; `bypass_actors` authentifié | `GH_TOKEN` invalide, chemin refusé par le proxy |
| `gh release verify`, `gh attestation verify` sur une vraie release | aucune release attestée ; hôtes de bundles refusés |
| `gitleaks`, `commitlint`, `lychee` | outils absents (contrôle de liens et de motifs de secrets équivalents faits à la main) |
| audits en ligne de zizmor | pas de jeton valide |
| rejeu de `sim_check.py`, `sim_openpr.py`, `sim_draft.py`, `sim_ci.py`, `sim_pdf.py` | scripts non versionnés ; je n'ai refait que ce que j'ai pu reconstruire de façon indépendante (n° 19, 20, 16) |
| mutants sur le hook de session et sur les blocs `run:` de `release.yaml`/`bump-lean.yaml` | pas de suite de tests versionnée à muter |
| Tectonic, deux compilations, comparaison de condensats | non implémenté dans les workflows ; non revendiqué |
| Python 3.12 du runner | seul CPython 3.11.15 disponible |

## 10. Contrat de vérification de ce rapport

```
Propriété : chaque affirmation de la campagne est démontrée par un contrôle qui peut échouer
→ niveau : rapport de vérification (méta) ; sous-niveaux : configuration, structure, comportement d'un script, rendu, reproductibilité
→ oracle : exécutions § 1, mutation § 2, lectures de journaux § 3.1, comparaison de base § 4
→ erreur détectable : contrôle affaibli ou sans oracle (§ 7), affirmation sans preuve (§ 8), régression (§ 4), incohérence documentaire (§ 5)
→ contrôle choisi : rejeu indépendant + mutation indépendante + diff b5f6146..ce606a9
→ résultat observé : PARTIAL
```
