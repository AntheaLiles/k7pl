<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit OpenSSF de k7pl : matrice consolidée (vague 1)

| | |
|---|---|
| Nature | Rapport d'audit **non normatif**, produit par une session d'agents. Ce n'est pas une revue de sécurité humaine et il ne vaut pas déclaration de conformité. |
| Base auditée | `origin/main` = `b5f6146` (2026-10-06) |
| Rédaction | Session principale (orchestratrice), à partir de six audits indépendants et de vérifications propres |
| Sources | `docs/security/workstreams/{scorecard,cii,github-governance,supply-chain,security-assurance,quality-reproducibility}/AUDIT.md` |
| Suite | Plan : `docs/security/OPENSSF-ROADMAP.md` · Bilan : `docs/security/IMPLEMENTATION-STATUS.md` |

Conventions (règle `.claude/rules/documentation.md`) : **fait** (observé, avec sa preuve), **interprétation**, **décision**,
**hypothèse**, **action restante**. Statuts : `VERIFIED` · `PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` ·
`FUTURE` ; `N/A` s'il n'y a rien à satisfaire, avec justification. « ESTIMÉ » : non vérifié par une commande ou un fichier lu.

## 0. Ce qu'il faut retenir

1. **Aucun écart exploitable sans identifiant n'a été trouvé** (P0 : aucun). L'hygiène classique des workflows est bonne : aucun
   déclencheur dangereux, 18 actions épinglées sur un SHA qui correspond bien au tag amont, `persist-credentials: false` partout.
2. **Le pipeline de publication de la spécification ne peut pas fonctionner tel qu'il est écrit, et n'a jamais fonctionné.**
   `release.yaml` ajoute le PDF *après* la publication, or la release est immuable ; `publish-spec` n'a en outre ni `checkout` ni
   `GH_REPO`. Le seul run de release (n° 36569899593) est celui de l'ancien workflow et a échoué.
3. **Aucune procédure de vérification d'un artefact n'existe aujourd'hui** : zéro asset publié, aucune attestation d'artefact.
   Seule existe une attestation de release GitHub sur le tag.
4. **Le DOI et les identifiants Software Heritage du README n'ont aucune origine démontrée dans le dépôt.** La première publication
   par la CI créerait un nouveau DOI de concept, irréversible, sans lien avec celui affiché.
5. **Score Scorecard « avant » : 6,0 / 10** (observé). Les plafonds sont structurels (un seul humain, aucune revue) ; plusieurs
   contrôles bas sont des artefacts de mesure ou dépendent du temps. Rien n'est à « corriger » pour gagner un point (§ 7).
6. **Un seul humain, zéro approbation requise, aucune revue enregistrée sur 13 PR.** Les critères de revue indépendante, de facteur
   bus et de continuité d'accès sont documentés comme structurellement indisponibles. Aucun relecteur n'a été ni ne sera fabriqué.

## 1. Vérifications faites par la session principale

Ces vérifications sont indépendantes des agents et servent de socle aux arbitrages.

| Réf. | Vérification | Résultat |
|---|---|---|
| O1 | Journal du job Scorecard, run 37385570410 (`mcp__github__get_job_logs`, job 112017874665) | **Score agrégé 6,0**, Scorecard v5.5.0 ; scores par contrôle au § 2.A |
| O2 | Binaire Scorecard v5.5.0 compilé par un agent, exécuté en `--local` sur un **export propre** de `b5f6146` | Reproduit exactement les 9 scores distants des contrôles fondés sur les fichiers. Piège : un scan du répertoire de travail contamine la mesure (worktrees d'agents). Les métadonnées de build du binaire (Go 1.25.7, module `ossf/scorecard/v5`, sommes des dépendances) sont cohérentes avec une compilation locale ; son hash n'est pas comparé à une source indépendante |
| O3 | Regex de `ci.yaml:57` extraite du fichier et testée en ERE | 5 alternatives sur 8 ne matchent jamais (`lakefile.lean`, `lake-manifest.json`, `.github/dependabot.yml`, `scripts/sync_zenodo.py`, `scripts/requirements-zenodo.txt`) |
| O4 | API publique des releases, runs, branches | Release `spec-v0.0.0-alpha.1` : `immutable: true`, 0 asset ; seul run `release`, workflow « Lean Build », `failure` ; branche `zenodo-state` absente |
| O5 | Auteurs sur `origin/main` | 69 commits : « Claude » 49, « Cyprien PIERRE » 19, dependabot 1 ; 13 PR, toutes ouvertes par `AntheaLiles` |
| O6 | Signalement privé de vulnérabilité | `{"enabled": true}` |
| O7 | Lecture du fichier `release.yaml` | `publish-spec` : aucun `checkout`, aucun `GH_REPO` (confirme l'agent supply-chain) |

**Limites de l'environnement.** `api.securityscorecards.dev`, `www.bestpractices.dev`, `zenodo.org`, `doi.org`,
`archive.softwareheritage.org` et l'hôte des bundles d'attestation sont refusés par le proxy ; `GH_TOKEN` est invalide ; les API
`actions/permissions`, `environments`, `collaborators` et la protection classique de branche sont inaccessibles. Les réglages
GitHub-side, l'état du badge CII et la validité cryptographique des attestations sont donc **non vérifiables depuis cette
session** : `HUMAN ACTION REQUIRED (relire)`.

## 2. Matrice

### 2.A Scorecard (état observé : run 37385570410, score 6,0)

| Domaine | Contrôle | État | Preuve | Risque réel | Action | Dépendance | Statut |
|---|---|---|---|---|---|---|---|
| Scorecard | Binary-Artifacts | 10 | O1, O2 | faible | — | — | VERIFIED |
| Scorecard | Branch-Protection | 3 : paliers 1 acquis ; palier 2 incomplet faute d'approbation requise | O1 ; SC § 3.2 ; GOV § 3.2 | prise de contrôle du compte unique | `strict_required_status_checks_policy: true` (+1) ; **aucune approbation fabriquée** | autrice | PARTIAL (plafond structurel) |
| Scorecard | CI-Tests | 10 | O1 | le contrôle lit les noms de checks, pas leur contenu | tests paramétrés du classifieur | — | VERIFIED |
| Scorecard | CII-Best-Practices | 2 (« InProgress ») | O1 | faible | renseigner le formulaire du projet 15239 | autrice | HUMAN ACTION REQUIRED |
| Scorecard | Code-Review | 0 (0/4 approuvés) | O1 ; GOV § 3.4 | aucun second regard | aucune action honnête | second humain | BLOCKED (structurel) |
| Scorecard | Contributors | 6 ; volatil (organisations lues sur le champ « Company » des profils, dont le compte `claude`) | O1 ; SC § 3.6 | aucun | ne rien modifier | — | N/A (non pilotable) |
| Scorecard | Dangerous-Workflow | 10 | O1 ; ASS F8 | faible | — | — | VERIFIED |
| Scorecard | Dependency-Update-Tool | 10 ; Dependabot ne couvre pas Lake | O1 ; SC § 3.8 | dépendances Lake hors alertes | `cooldown` ; veille Lake via `bump-lean` | — | VERIFIED |
| Scorecard | Fuzzing | 0 | O1 | aucune surface d'entrée dans `src/` | rien : un fuzzer serait décoratif | analyseur du langage | FUTURE |
| Scorecard | License | 9 : deux licences réelles (CECILL-2.1, CC-BY-4.0) | O1 | aucun | ne pas réécrire `LICENSE.md` | — | VERIFIED (plafond N/A) |
| Scorecard | Maintained | 0 : dépôt créé il y a moins de 90 jours | O1 | aucun | attendre (≥ 2026-12-27, ESTIMÉ) | temps | FUTURE |
| Scorecard | Packaging | −1 (exclu) | O1 | aucun | rien | — | N/A |
| Scorecard | Pinned-Dependencies | 9 : `curl … master/elan-init.sh \| sh` dans `scripts/claude-session-start.sh:15` | O1, O2 | moyen (hook de session des agents) ; le même motif existe dans `lean-action`, invisible pour Scorecard | installer elan par version + somme | — | PARTIAL → P2 |
| Scorecard | SAST | 0 | O1 | aucun outil SAST ne couvre Lean | **pas de CodeQL pour le score** | décision autrice | N/A / FUTURE |
| Scorecard | Security-Policy | 4 : **artefact de nommage** (`.claude/rules/security.md` masque `SECURITY.md`) | O1, O2 ; SC § 3.15 | nul | non corrigé volontairement (voir § 4) | autrice | PARTIAL (artefact de mesure) |
| Scorecard | Signed-Releases | −1 (aucune release avec assets) | O1 ; SC § 3.16 | piège : bascule à 0 si une release avec assets n'a pas de fichier de signature reconnu | joindre le bundle `.sigstore.json` dès la première release | première release | PREPARED |
| Scorecard | Token-Permissions | 10 ; `contents: write` justifiés sauf `bump-lean` | O1 ; ASS § 3.4 | faible | réduire `bump-lean` | — | VERIFIED |
| Scorecard | Vulnerabilities | 10 ; aveugle sur Lake | O1 ; SC § 3.18 | OSV ne lit que `requirements-zenodo.txt` | documenter | — | VERIFIED |

### 2.B Gouvernance GitHub

| Domaine | Contrôle | État | Preuve | Risque réel | Action | Dépendance | Statut |
|---|---|---|---|---|---|---|---|
| Gouvernance | Protection de `main` | Ruleset « PR on main » (id 24138119) : PR obligatoire, suppression et force-push interdits, historique linéaire, `bypass_actors: []` | GOV § 3.2 | faible ; protège de l'accident, pas d'un identifiant compromis | — | — | VERIFIED |
| Gouvernance | Checks requis | un seul, `CI OK`, non strict | GOV § 3.3 | l'oracle est défini par la PR elle-même ; la combinaison PR + `main` courant n'est testée qu'après fusion | `strict: true` | autrice (friction : CI longue) | PARTIAL |
| Gouvernance | Approbations / revue | 0 requise ; 0 revue sur 13 PR | O5 ; GOV § 3.4 | aucun second regard | voir § 6 | second humain | HUMAN ACTION REQUIRED (structurel) |
| Gouvernance | Règle de tags `v*`, `spec-v*` | aucune ; tag léger, non signable | GOV § 3.5 | tag déplacé ou posé hors `main` avant publication | ruleset de tags | autrice | HUMAN ACTION REQUIRED |
| Gouvernance | Secrets et environnements | `ZENODO_TOKEN`, `ZENODO_ENV`, `BUMP_TOKEN` sans `environment:` | GOV § 3.6 ; ASS § 3.2 | exfiltration par une PR interne (aucune fusion nécessaire) | environnements `zenodo` et `bump-lean` | autrice + vague 2 | HUMAN ACTION REQUIRED |
| Gouvernance | Méthodes de fusion | dépôt : merge + rebase ; ruleset : merge/rebase/squash ; seul le rebase est effectif | GOV § 3.1 | confusion | n'autoriser que le rebase | autrice | HUMAN ACTION REQUIRED |
| Gouvernance | Commits signés | 0 / 69 ; le rebase GitHub retire les signatures | GOV § 3.5 | pas de preuve d'origine | ne pas l'exiger maintenant | décision | FUTURE |
| Gouvernance | CODEOWNERS | absent | GOV § 4.4 | aucun | **ne pas créer** (déclaratif, un seul nom) | second humain | N/A |
| Gouvernance | Réglages Actions, 2FA, politique SHA | illisibles | GOV § 12 | 2FA : élevé si absente | vérifier | autrice | HUMAN ACTION REQUIRED |
| Gouvernance | Continuité d'accès | un seul compte, des secrets personnels | CII § 6 | facteur bus 1 | successeur GitHub, coffre | autrice | HUMAN ACTION REQUIRED (structurel) |

### 2.C Chaîne d'approvisionnement et release

| Domaine | Contrôle | État | Preuve | Risque réel | Action | Dépendance | Statut |
|---|---|---|---|---|---|---|---|
| Supply chain | Épinglage des actions | 18 / 18 sur SHA de 40 hex, résolus et identiques au tag amont | SUP § 3.2 ; ASS F9 | faible ; ne couvre pas les téléchargements à l'exécution | `cooldown` Dependabot | — | VERIFIED |
| Supply chain | Téléchargements des actions composites | elan (script `master` + binaire `latest`), actionlint `latest`, images Docker par tag : aucune empreinte | SUP § 3.3 | `spec` construit le PDF attesté avec un elan non vérifié ; les autres jobs sont en `contents: read` | traiter elan/toolchain en priorité ; documenter le reste en risque accepté | — | PARTIAL |
| Supply chain | Hook de session : `curl … \| sh` sur `master` | présent | SUP § 3.4 | moyen : code distant mutable dans un bac à sable qui a l'écriture au dépôt | version + SHA-256 | — | PREPARED |
| Supply chain | Tectonic 0.15.0 | somme SHA-256 vérifiée ; identique à un téléchargement indépendant | SUP § 3.4 ; QUA § 5.4 | contrôle de dérive, pas d'authenticité ; **bundle TeX non épinglé, téléchargé à l'exécution** | épingler le bundle (à mesurer) | hôte inaccessible ici | PARTIAL |
| Supply chain | Caches restaurés par le build d'un tag | le run d'un tag lit les caches de `main` | SUP § 3.5 ; ASS § 3.5 | faible (il faut déjà avoir exécuté du code sur `main`) mais **sans contrôle** pour un PDF attesté | `use_cache: false` en release | coût CI non mesuré | PREPARED |
| Supply chain | `lake-manifest.json` | 14 / 14 `rev` de 40 hex, identiques aux pins amont | SUP § 3.6 | faible ; la PR de bump n'est relue que par l'œil | contrôle automatique du manifeste | — | VERIFIED (état) / PREPARED (contrôle) |
| Supply chain | `release.yaml` | upload après publication d'une release immuable ; pas de `GH_REPO` ; **jamais exécuté** | O4, O7 ; SUP § 3.1 | publication incomplète ; Zenodo jamais atteint | flux brouillon → assets → publication | réglage d'immuabilité | BLOCKED |
| Supply chain | Provenance (`actions/attest`) | jamais exécutée ; le job qui atteste n'est pas celui qui construit | SUP § 3.7 | l'identité liée est le workflow, pas les étapes de build | bundle joint ; vérification avec `--signer-workflow` et `--source-ref` | première release | PREPARED |
| Supply chain | Procédure de vérification d'un artefact | **n'existe pas** (0 asset) | SUP § 4 | — | écrire la procédure après la première release vérifiée | première release | BLOCKED |
| Supply chain | Attestation de release GitHub | existe sur le tag (`release/v0.2`, sujet `sha1:dcd65a98…`), contenu décodé ; chaîne de confiance non validée ici | SUP § 3.7 | — | rejouer `gh release verify` hors du bac à sable | autrice | HUMAN ACTION REQUIRED |
| Supply chain | Zenodo | jamais exécuté ; état sur branche mutable absente ; DOI affiché sans origine ; `ZENODO_ENV` secret avec repli sur la production | SUP § 3.9 ; ASS § 3.2 | **doublon de DOI irréversible** | échec par défaut tant que le DOI de concept n'est pas déclaré ; environnement `zenodo` | décision autrice | BLOCKED |
| Supply chain | `bump-lean.yaml` | PAT sur la machine qui exécute du code amont ; `contents: write` inutile ; interpolation dans `run:` | SUP § 3.10 ; ASS § 3.4 | moyen (amont compromis) | séparer build et ouverture de PR ; `env:` | — | PARTIAL |
| Supply chain | Releases `v*` (implémentation) | aucun artefact utile | SUP § 3.8 | contrôles de release exécutés après publication | contrôles avant publication | — | PREPARED |

### 2.D Assurance sécurité

| Domaine | Contrôle | État | Preuve | Risque réel | Action | Dépendance | Statut |
|---|---|---|---|---|---|---|---|
| Assurance | Déclencheurs dangereux | aucun `pull_request_target`, `workflow_run`, `issue_comment` | ASS F8 | faible | — | — | VERIFIED |
| Assurance | `persist-credentials: false` | 13 / 13 | ASS F8 | le jeton reste en mémoire du runner | — | — | VERIFIED |
| Assurance | Privilèges des jobs | justifiés, sauf `artifact-metadata: write` (superflu) et `bump-lean` | ASS § 3 | faible | retirer | — | PARTIAL |
| Assurance | Agent de code piégé (injection de prompt) | 49 des 69 commits de `main` portent l'auteur « Claude » ; PR ouvertes et fusionnées sous l'identité de l'autrice ; aucun agent ne restreint ses outils ; outil `merge_pull_request` disponible | ASS § 5 (A4, A5) | **le vecteur le plus vraisemblable aujourd'hui** | `deny` sur la fusion par un agent, outils restreints par rôle | **décision autrice** (`.claude/settings.json`) | HUMAN ACTION REQUIRED |
| Assurance | Surface d'exécution du langage | aucune (`src/` minuscule, sans IO, FFI ni `unsafe` ; décompte courant dans `docs/STATUS.md`) | ASS § 4 ; QUA § 3.1 | l'exécution de code est inhérente à la chaîne de construction (Lake, élaboration Lean) | périmètre de `SECURITY.md` sur l'exécution : FUTURE | analyseur du langage | FUTURE |
| Assurance | SAST | aucun outil ne couvre Lean ; CodeQL ne couvre que `actions` et Python ; zizmor adapté aux workflows | ASS § 7 ; QUA § 4 | faible | zizmor : essai sur branche, décision | autrice | FUTURE |
| Assurance | Modèle de menace | produit par agent (ASS § 2, § 5) | ASS | — | `THREAT-MODEL.md` daté, non validé par l'autrice | autrice | PREPARED |

### 2.E Qualité et reproductibilité

| Domaine | Contrôle | État | Preuve | Risque réel | Action | Dépendance | Statut |
|---|---|---|---|---|---|---|---|
| Qualité | Regex `grep` de `ci.yaml:57` | 5 alternatives mortes ; `impact.py` (`FULL_EXACT`) compense ; défaut SIGPIPE latent reproduit | O3 ; QUA § 2 | nul aujourd'hui ; double défense illusoire | supprimer le `grep`, tests paramétrés | — | VERIFIED |
| Qualité | `ci-ok` et jobs `skipped` | cohérents ; `skipped` accepté seulement dans `verify.yaml` | QUA § 2.5 ; GOV § 3.3 | dépend de la justesse du classifieur | classer `axiom-audit.sh` aussi en `spec` | — | VERIFIED |
| Qualité | Audit d'axiomes | détecte `native_decide`, `sorry`, `axiom` là où il est lancé (`K7pl`, `Spec`) | QUA § 3.5 | `K7plTests`, `SpecExt`, `SpecBib` hors champ (propres aujourd'hui : 586 et 2 déclarations auditées) | étendre | — | PARTIAL |
| Qualité | `warningAsError` | ne couvre pas `lean_exe mainTest` ni `lean_exe spec` (établi sur mini-projet) | QUA § 3.4 | faible | `leanOptions` sur les deux exécutables : **`lakefile.lean`, à signaler en PR dédiée** | PR dédiée | PARTIAL |
| Qualité | Modules Lean orphelins | un fichier hors `roots` / imports n'est jamais compilé (reproduit) | QUA § 8 (R1) | élevé en structure | script d'exhaustivité | — | PARTIAL |
| Qualité | `lake build/test/lint` de `K7pl` | verts en CI sur `b5f6146` (run 37385570730) ; **non exécutés par les agents ni par moi** | CII § 0 ; QUA § 0.1 | — | — | — | VERIFIED (CI, lu seulement) |
| Qualité | Reproductibilité Lean → HTML / TeX | 2 builds propres × 3 rendus : mêmes octets (HTML 290 fichiers, TeX 40, 78 + 654 artefacts Lean), contrôle négatif concluant ; **même machine seulement** | QUA § 5.2 | — | job quotidien optionnel (décision) | décision autrice | PARTIAL |
| Qualité | Reproductibilité du PDF | non démontrée ; `SOURCE_DATE_EPOCH` absent, bundle TeX non épinglé, cache d'état | QUA § 5.4 | impossible de re-vérifier par reconstruction | `SOURCE_DATE_EPOCH` ; ne jamais écrire « reproductible » | bundle TeX inaccessible ici | BLOCKED (démonstration) |
| Qualité | Fuzzing / tests par propriétés | aucune surface d'entrée | QUA § 3.3 | — | rien aujourd'hui ; déclencheurs identifiés | analyseur du langage | FUTURE |
| Qualité | `reuse lint` | conforme REUSE 3.3 | CII § 0 ; commande relancée à chaque commit | — | — | — | VERIFIED |
| Qualité | Documentation de build | un tiers ne peut pas reproduire le PDF publié à partir du seul README | QUA § 7 | — | section « Reconstruire et vérifier » | — | PARTIAL |

### 2.F Bonnes pratiques CII (projet 15239)

L'état saisi sur le site est **non lisible depuis cette session**. Les critères ont été lus dans le dépôt source du site
(`coreinfrastructure/best-practices-badge`, commit `75560e37`, 2026-10-02 : 67 critères Passing, 55 Silver, 23 Gold).

| Domaine | Niveau / critère | État | Preuve | Action | Dépendance | Statut |
|---|---|---|---|---|---|---|
| CII | Passing, dans son ensemble | atteignable ; aucun MUST structurellement hors d'atteinte | CII § 3 | actions humaines ci-dessous | autrice | PARTIAL |
| CII | `release_notes` | non satisfait : notes auto-générées, aucune section de changelog pour `0.0.0-alpha.1` | CII § 3 | éditer la release sur GitHub ; `spec/CHANGELOG.md` est sous `spec/` : décision de l'autrice | autrice | HUMAN ACTION REQUIRED |
| CII | `know_secure_design`, `know_common_errors` | attestation personnelle | CII § 3 | réponse sincère de l'autrice | autrice | HUMAN ACTION REQUIRED |
| CII | `static_analysis` | défendable avec justification précise (`lake lint`, audit d'axiomes, actionlint) | CII § 3 | formuler prudemment | autrice | PARTIAL |
| CII | Silver : `governance`, `roles_responsibilities` | non satisfaits ; pratique réelle visible mais non décrite | CII § 4, § 7 | brouillon fourni (voir roadmap), à valider | autrice | HUMAN ACTION REQUIRED |
| CII | Silver : `access_continuity` | non satisfait | CII § 4 | successeur GitHub + coffre | autrice | HUMAN ACTION REQUIRED |
| CII | Silver : `signed_releases` | non satisfait : attestation jamais produite | CII § 4 | première release vérifiée | vague 2 + humain | PREPARED |
| CII | Silver : `build_repeatable` | non démontré | CII § 4 | ne pas revendiquer | — | FUTURE |
| CII | Silver : `assurance_case`, `documentation_security` | non satisfaits | CII § 4 | `ASSURANCE-CASE.md` et `THREAT-MODEL.md` (non validés) | autrice | PREPARED |
| CII | Silver : `bus_factor` (SHOULD) | 1 personne | CII § 4 | justification honnête ; les agents ne comptent pas | — | BLOCKED |
| CII | Gold : `two_person_review`, `contributors_unassociated`, `bus_factor` (MUST) | structurellement hors d'atteinte pour une mainteneuse seule | CII § 5 | aucune | seconde personne réelle | BLOCKED |
| CII | Gold : `code_review_standards` | documentable seule | CII § 5 | décrire la revue **réelle**, sans prétendre à une seconde personne | autrice | FUTURE |
| CII | Gold : `hardened_site` | probablement non conforme (GitHub Pages ne permet pas de définir CSP ni X-Frame-Options) | CII § 5 | mesurer | hébergement | BLOCKED (externe, ESTIMÉ) |

**Verdict par niveau.** *Passing* : atteignable, sous réserve d'actions humaines. *Silver* : non atteignable en l'état ; devient
atteignable par des documents décrivant la pratique réelle, des actions humaines et trois chantiers techniques (releases signées,
build répétable, analyse statique des workflows). *Gold* : structurellement hors d'atteinte avec une seule personne.

### 2.G Affirmations publiques qui excèdent les preuves

| Réf. | Affirmation (fichier) | Constat | Gravité | Traitement |
|---|---|---|---|---|
| A1 | Spécification « vérifiée par Lean 4 contre son implémentation de référence » (`CITATION.cff:22-24`, `zenodo.json:3`, `zenodo.files.json:4`) | il n'existe pas d'implémentation de référence ; `spec/` et `tools/` n'importent ni `K7pl`, ni Mathlib, ni CSLib | **haute** : sera figée de façon irréversible par Zenodo | **décision de l'autrice** ; formulation proposée dans la roadmap, non appliquée |
| A2 | « Son PDF est joint à la release GitHub » ; « publié sur Zenodo » (`README.md:39-40, 67-68`, `CONTRIBUTING.md:92-93`) | la release n'a aucun asset ; la chaîne n'a jamais abouti | haute | alignée sur l'état réel (vague 2, documentation) |
| A3 | DOI `10.5281/zenodo.23040451` (`README.md:11`, `CITATION.cff:13`) | origine non établie par le dépôt (cité depuis `05aa321`, après l'échec de la CI) | moyenne | **décision de l'autrice** (H2) |
| A4 | Badges Software Heritage (`README.md:12-13`) | `swh:1:dir:b81695cf…` ≠ arbre git du tag (`87a04386…`) ; quatre enveloppes d'archive testées ne le reproduisent pas ; non vérifiable ici | moyenne | **décision de l'autrice** (H3) |
| A5 | Badge fair-software 4/5 (`README.md:14`) | badge statique ; le critère « registry » repose sur une exemption auto-déclarée | faible | signalé |
| A6 | Badge « Lean Build » (`README.md:8`) | pointe vers `lean.yaml`, supprimé | moyenne | **corrigé** (vague 2) : signal périmé, non un détecteur |
| A7 | Canal de signalement du code de conduite (`CODE_OF_CONDUCT.md:45`) | « message privé via le profil GitHub » : GitHub n'offre pas de messagerie privée (ESTIMÉ) | moyenne | décision de l'autrice |
| A8 | « Tous les checks doivent passer : compilation, tests, lint… » (`CONTRIBUTING.md:33-34`) | exécution sélective depuis la PR n° 13 | faible | aligné (vague 2) |

## 3. Écarts critiques

1. **C1. Publication de la spécification inopérante** (`release.yaml`) : double défaut (immuabilité, absence de `GH_REPO`).
   Mesure : flux « tag → contrôles et build → release brouillon avec assets et attestation → publication humaine → Zenodo ».
2. **C2. Publication Zenodo irréversiblement ambiguë** : DOI affiché sans origine ; état sur une branche mutable absente ;
   `ZENODO_ENV` en secret avec repli silencieux sur la production. Mesure : échec par défaut tant que le DOI de concept n'est pas
   déclaré explicitement ; **décision humaine d'abord**.
3. **C3. Secrets de publication et d'automatisation lisibles par toute PR interne.** Mesure : environnements `zenodo` et
   `bump-lean` (réglage GitHub + `environment:` dans les workflows).

## 4. Écarts importants

- Aucun contrôle « le tag est sur `main` et `CI OK` y a réussi » ; aucune règle de tag.
- `bump-lean.yaml` : le PAT et du code amont sur la même machine ; permissions d'écriture inutiles.
- Le PDF attesté est construit avec des caches de `main` non revérifiés et un bundle TeX non épinglé ; il n'est pas démontré
  reproductible.
- Hook de session : `curl … | sh` sur une branche mutable.
- Les invariants « jamais de `native_decide`, d'`axiom` ni de `sorry` » ne sont outillés que pour `K7pl` et `Spec` ; aucun contrôle
  d'exhaustivité des modules Lean.
- Documentation qui décrit comme acquis un flux jamais exécuté (A2, A3, A4).
- Contrôles de release de l'implémentation exécutés après publication, alors qu'une release immuable ne se retire pas.
- **Security-Policy 4/10 : artefact de mesure, non corrigé.** `.claude/rules/security.md` fait écran à `SECURITY.md` pour
  Scorecard ; renommer ce fichier de règles ferait passer le contrôle à 10 sans rien changer à la sécurité. Décision : ne pas le
  faire (objet : `.claude/`, gain uniquement de score), le documenter, et laisser à l'autrice la possibilité de le renommer.

## 5. Améliorations opportunistes

`cooldown` Dependabot ; `strict_required_status_checks_policy` ; méthode de fusion unique ; suppression automatique des branches
fusionnées ; badge « Lean Build » ; `artifact-metadata: write` superflu ; jeton Git hors ligne de commande dans le job Zenodo ;
`ZENODO_ENV` en variable ; zizmor en essai ; `lean_exe` sans `warningAsError` ; classement de `axiom-audit.sh` pour le job
`spec` ; `suivi.py` hors CI.

## 6. Critères structurellement indisponibles à une mainteneuse seule

| Critère | État technique | Obstacle organisationnel | Action humaine nécessaire | Possibilité future | Statut |
|---|---|---|---|---|---|
| Approbation requise (Scorecard Branch-Protection palier 2, Code-Review) | ruleset avec règle de PR, 0 approbation | seule personne ayant le droit d'écriture : une PR ouverte par elle (y compris celles des agents) ne pourrait **jamais** être approuvée ; `required_approving_review_count: 1` bloquerait toutes les PR, et un contournement systématique ne serait pas une revue | inviter une personne réelle (rôle Write) **puis** passer à 1 | oui, avec une seconde personne | BLOCKED |
| Revue par les code owners, approbation du dernier push | absents | idem | idem | idem | BLOCKED |
| `two_person_review`, `contributors_unassociated`, `bus_factor` (Gold) | 0 revue ; 1 contributeur humain | idem | idem | idem | BLOCKED |
| `access_continuity` (Silver) | un compte, des secrets personnels | personne d'autre n'a d'accès | successeur GitHub, coffre de continuité, ou organisation à deux propriétaires | oui, seule | HUMAN ACTION REQUIRED |
| Revue de sécurité humaine (Gold `security_review`) | les audits de cette campagne sont des rapports d'agents | aucune revue humaine | l'autrice conduit, date et signe une revue | oui, seule | HUMAN ACTION REQUIRED |

**Ce qui ne doit pas être présenté comme une revue :** les agents de revue (`formal-reviewer`, `verification-specialist`), le compte
`claude`, Dependabot, la fusion par l'autrice de commits rédigés par un agent, un second compte, un bot ou Copilot.

## 7. Ce qu'il ne faut pas « corriger » ni ajouter

| À éviter | Raison |
|---|---|
| `required_approving_review_count ≥ 1`, avec ou sans contournement administrateur | bloque `main` ou fabrique une revue |
| `CODEOWNERS`, `MAINTAINERS.md` à un seul nom | décoratifs ; ne contrôlent rien |
| CodeQL pour faire apparaître un score SAST | Scorecard attribue 7/10 à la seule présence du fichier ; Lean n'est pas couvert (faux signal) |
| Un fuzzer ou une cible OSS-Fuzz | aucune surface d'entrée ; il n'exercerait que `Expr.eval`, déjà prouvé |
| `.sha256` ou `.sigstore.json` renommés, fichiers `.sig` factices | fabrication de signature |
| `cosign` en plus d'`actions/attest` ; SBOM écrit à la main ; badge SLSA ; la mention « reproductible » | décoratifs ou non démontrés |
| « Réparer » la release `spec-v0.0.0-alpha.1` | immuable ; tag non réutilisable ; DOI et SWHID déjà cités |
| Commits ou tickets artificiels pour `Maintained` ; champs « Company » pour `Contributors` | fabrication |
| Réécrire `LICENSE.md` en licence unique | le dépôt est réellement sous deux licences |
| `SECURITY-REVIEW.md` rédigé par un agent | serait une revue fabriquée |
| `SECURITY-MODEL.md` séparé | doublon du modèle de menace |
| Désactiver l'immuabilité des releases pour « réparer » la CI | perd la protection ; la réponse est de changer le flux |
| Exiger les commits signés tant que la fusion se fait par rebase | GitHub recrée les commits sans signature |

## 8. Critères non applicables aujourd'hui

Packaging (`N/A`) ; Fuzzing (`FUTURE`, aucune surface) ; critères CII de cryptographie (aucune cryptographie dans le logiciel
produit) ; `input_validation` et `hardening` (aucun logiciel exposé) ; `dynamic_analysis_unsafe` (Lean et Python sûrs en mémoire).
Ces `N/A` supposent que l'autrice déclare d'abord ce qu'est « le logiciel produit par le projet » (CII § 1), faute de quoi ils
paraîtraient opportunistes.

## 9. Frontière scientifique

Aucune mesure proposée ne modifie `spec/`, `src/` ou `tests/`. Trois points sont signalés, pas résolus :
(1) `spec/CHANGELOG.md` n'a pas de section `0.0.0-alpha.1` (critère CII `release_notes`) ; l'ajouter modifierait `spec/` ;
(2) l'affirmation A1 décrit la relation spécification ↔ implémentation, c'est-à-dire l'état de la formalisation ;
(3) l'assurance « propriété prouvée » repose sur des oléans Mathlib que le noyau ne revérifie pas à l'import (ESTIMÉ).
Aucune propriété de sécurité du langage énoncée dans la spécification (non-interférence, déclassification) ne doit être reprise
comme garantie : ce sont des énoncés, pas des propriétés implémentées ni prouvées.
