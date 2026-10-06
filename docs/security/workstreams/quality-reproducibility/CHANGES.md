<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Changements qualité et reproductibilité : vague 2

| | |
|---|---|
| Domaine | `quality-reproducibility-specialist` |
| Base | `b5f6146` (`refactor(ci): nettoyer le classifieur d'impact`) |
| Nature | Récit des changements et de leurs limites. Les résultats des contrôles sont dans `VALIDATION.md`. |
| Portée | `.github/workflows/ci.yaml`, `.github/workflows/verify.yaml`, `scripts/ci/` (classifieur, deux nouveaux fichiers, tests), ce dossier. Rien dans `spec/`, `src/`, `tests/`, `lakefile.lean`, ni dans les fichiers des autres agents. |
| Statut global | **PREPARED** : les workflows n'ont pas été exécutés par GitHub Actions. Les scripts Python sont testés localement. |

Statuts : `VERIFIED` · `PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE`.

## Commits

| SHA | Action | Contenu |
|---|---|---|
| `e0d474f` | R2 | entrée `use_cache` de `verify.yaml` |
| `08eb987` | R9 | `ci.yaml` : suppression du `grep` ; `impact.py` : `axiom-audit.sh` ; `test_impact.py` |
| `a888c1f` | R10 | audits d'axiomes, `check_lean_modules.py` et son test |
| `e3a5e79` | R11 | date de construction du PDF, journal Tectonic |
| `ac5b2a1` | (mise en forme) | deux lignes trop longues |
| `144309b` | R10 (correction) | emplacement du contrôle des modules Lean dans le job `impl` |
| (suivant) | documentation | ce fichier et `VALIDATION.md` |

## R2 : entrée `use_cache` (`verify.yaml`)

**Fait.** Entrée booléenne optionnelle, défaut `true`. Quand elle vaut `false`, les trois étapes `actions/cache` portent `if: ${{ inputs.use_cache }}` et sont sautées : `.lake/packages` (jobs `impl` et `spec`) et `~/.cache/Tectonic` (job `spec-pdf`). Une étape `actions/cache` sautée ne restaure ni ne sauvegarde.

**Contrat respecté.** Sans l'entrée, le comportement est celui d'avant (`ci.yaml`, `full.yaml` n'ont pas besoin de changer). `release.yaml` (autre agent) appellera `verify.yaml` avec `use_cache: false`.

**Limites.**
- `lake exe cache get` (binaires précompilés de Mathlib, job `impl`) n'est pas un `actions/cache` : il reste actif. Il n'entre pas dans la construction du PDF.
- Avec `use_cache: false`, le job `spec-pdf` télécharge tout le bundle TeX au lieu de partir d'un cache : il est plus lent. Le bundle reste téléchargé à l'exécution et non épinglé (voir R11).
- `PREPARED` : l'entrée n'a pas été exercée par un appel réel.

## R9 : `ci.yaml`, `impact.py`

**Suppression de l'étape shell `grep -Eq`.**
- Motif (audit §2) : cinq alternatives sur huit ne pouvaient jamais correspondre (`\\.` dans un scalaire littéral YAML entre apostrophes), les trois autres doublaient `FULL_EXACT`/`FULL_PREFIXES`, et `printf | grep -q` sous `pipefail` peut perdre une correspondance sur une très longue liste.
- Preuve avant suppression (voir `VALIDATION.md` §2) : les alternatives de la regex forment exactement l'ensemble `FULL_EXACT ∪ FULL_PREFIXES` ; sur dépôt jetable, avec le bloc `run` extrait du YAML, les dix chemins des deux listes donnent `full=true` **et** `unclassified=false` par `impact.py` seul.
- `impact.py` devient la seule source. Le comportement `workflow_dispatch` (`--force-full`) est conservé. Conséquence mineure et positive : pour un changement de chemin « complet », le journal liste maintenant les chemins modifiés (avant, `--force-full` les masquait).

**Étape de test.** `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` remplace `python3 scripts/ci/test_impact.py` (contrat d'interface 2) : elle attrape aussi les tests des autres scripts de `scripts/ci/`. Les tests d'un autre agent absents de ce worktree n'ont pas été exécutés ici.

**`impact.py`.** `scripts/axiom-audit.sh` est classé déclencheur de `lean_build` **et** de `spec_build` (le job `spec` l'appelle ; audit §2.5). La constante `LEAN_EXACT`, devenue vide, est remplacée par `LEAN_AND_SPEC_BUILD_EXACT`.
- Effet de bord à connaître (**décision à valider**) : sur `main`, `spec_build=true` déclenche aussi la publication GitHub Pages (`ci.yaml`, `deploy_pages`). Une modification de `axiom-audit.sh` republie donc une spécification identique. Sans danger, mais c'est un changement de comportement. Un changement de ce script lance aussi le job `spec-pdf`.

**`test_impact.py`.** 9 tests conservés, 12 ajoutés.
- Listes attendues **écrites en dur** (elles sont la spécification, indépendantes des constantes de `impact.py`).
- Tests paramétrés (`subTest`) sur chaque entrée de `FULL_EXACT` et chaque préfixe de `FULL_PREFIXES`. Chaque cas exige `full=true`, **`unclassified=false`** et `unknown_paths=[]` : un chemin retiré d'une liste ne retombe donc pas silencieusement dans « inconnu → full ».
- Test d'égalité entre les listes attendues et les constantes (un ajout non documenté échoue aussi).
- Test de correspondance exacte (`lakefile.lean.orig` doit être « inconnu »), test des voisins légers, test de `axiom-audit.sh`.
- Tests de bout en bout `impact.py --base/--head` sur dépôt jetable (le chemin que suit l'étape `impact` de `ci.yaml`), y compris `--force-full` et l'absence d'intervalle de commits (erreur, pas succès).
- Contrôle par mutation (15 mutants sur `impact.py` et `check_lean_modules.py`, tous tués ; `VALIDATION.md` §1.2).

## R10 : audit d'axiomes et exhaustivité des modules Lean

### Audits d'axiomes (`verify.yaml`)

Chaque audit est dans une étape nommée distincte (les étapes existantes sont renommées `(K7pl)` et `(Spec)`).

| Job | Étape | Commande | Statut |
|---|---|---|---|
| `impl` | `Audit the axioms (K7pl)` | `scripts/axiom-audit.sh K7pl K7pl` (inchangé, seulement renommé) | état réel en CI non relu ici (H1 de l'audit) |
| `impl` | `Audit the axioms (tests)` | boucle, voir ci-dessous | **PREPARED** (à valider par la CI : Mathlib) |
| `spec` | `Audit the axioms (Spec)` | `scripts/axiom-audit.sh Spec Spec` (inchangé) | idem |
| `spec` | `Audit the axioms (SpecExt)` | `scripts/axiom-audit.sh SpecExt SpecExt` | **VERIFIED** localement avec le vrai script : 586 déclarations, dans la liste autorisée |
| `spec` | `Audit the axioms (SpecBib)` | `scripts/axiom-audit.sh SpecBib SpecBib` | **VERIFIED** localement : 2 déclarations, dans la liste autorisée |

**Écart avec le contrat.** La commande demandée, `scripts/axiom-audit.sh K7plTests K7plTests`, **ne peut pas fonctionner** et aurait rendu la CI rouge à coup sûr.
- Cause (source de `axiom-audit` v0.1.2, lue) : `--root` désigne un préfixe de nom de module et l'environnement audité est celui de `import <racine>`. `K7plTests` est un nom de bibliothèque Lake, pas un module : les modules sont plats (`ArithTest`, `SemanticsTest`, `MainTest`).
- Reproduction (mini-projet de même disposition, vrai script) : `axiom-audit: failed to load the environment or audit: unknown module prefix 'K7plTests'`, code de sortie 2. Échec bruyant, non silencieux.
- Solution retenue : l'étape lit les racines des cibles dont `srcDir` est `tests` (`check_lean_modules.py --roots-in tests`, même analyseur de `lakefile.lean`) et audite chacune : `scripts/axiom-audit.sh <racine> +<racine>` (`+<racine>` est la syntaxe Lake d'un module). Un nouveau module de test déclaré dans le lakefile est audité sans modifier le workflow. Toutes les racines sont auditées même si l'une échoue ; l'étape échoue si l'une échoue, avec une annotation `::error::` nommant la racine. Une racine `MainTest` (exécutable de `lake test`) est incluse : elle n'était couverte par aucun contrôle.
- Coût : chaque appel clone et construit `axiom-audit` (environ 10 s mesurés sur le mini-projet), soit environ 30 s pour trois racines. Option pour l'autrice : faire accepter plusieurs racines (ou `--modules`) à `scripts/axiom-audit.sh`, fichier du domaine supply-chain, ce qui supprimerait la boucle.

### `scripts/ci/check_lean_modules.py` (nouveau)

**Ce qu'il fait.** Lit `lakefile.lean`, calcule les modules atteignables depuis les racines de toutes les `lean_lib`/`lean_exe` déclarées (dans le `srcDir` de chaque cible) en suivant les `import` en en-tête des fichiers, et signale (code 1) tout `.lean` de `src/` ou `tests/` hors de cet ensemble : la situation R1 de l'audit (un `#guard` faux ou un avertissement fatal dans un tel fichier ne ferait pas échouer `lake build`). Bibliothèque standard seule, appelable depuis n'importe quel répertoire (`--repo`).

**Échecs bruyants (code 2)** sur toute structure non reconnue : lakefile absent ou en TOML ; aucune déclaration ; `globs` ; liste de racines non littérale ; `srcDir` non littéral ; mot-clé `lean_lib`/`lean_exe` qui ne correspond pas à une déclaration reconnue (garde-fou de comptage) ; fichier racine absent ; dossier analysé absent. Les commentaires (ligne, bloc imbriqué) sont retirés avant la lecture des imports.

**Branchement.** Étape `Check that every Lean file is built` du job `impl`, juste avant `lake build` (après la récupération du cache Mathlib : le premier emplacement choisi, avant l'installation d'elan, aurait laissé `lake lint` et les audits, qui s'exécutent même après un échec, démarrer sur un Mathlib froid ; corrigé par `144309b`).

**Limites.**
- Il vérifie l'atteignabilité, pas qu'un module atteignable soit testé ou audité.
- Il ne lit que `lakefile.lean`, avec les formes ci-dessus ; `globs` n'est pas géré, par choix : l'échec bruyant plutôt qu'une supposition.
- Il n'analyse que `src/` et `tests/` par défaut. Avec `--dirs src tests tools spec`, il rapporte aujourd'hui 86 fichiers, tous atteignables ; cette extension n'est pas branchée (décision).
- `lakefile.lean` lui-même n'est pas modifié (interdit) : `leanOptions` sur `lean_exe mainTest`/`spec` (audit O3) reste ouvert.

## R11 : job `spec-pdf` (`verify.yaml`)

**Ce qui change.**
1. `SOURCE_DATE_EPOCH` est fourni à Tectonic. Le job n'a pas de checkout ; il ne reçoit pas un deuxième checkout (surface et coût inutiles). Le job `spec` lit `git log -1 --format=%ct` (date de **commit**, pas d'auteur) et la transmet par une sortie de job. Une valeur absente ou non numérique fait échouer l'étape avant Tectonic : le code amont de Tectonic panique sur une valeur non numérique (`expect("invalid SOURCE_DATE_EPOCH (not a number)")`, lu).
2. `-Z deterministic-mode` est passé à Tectonic : amont, il masque les chemins absolus et force la date de modification des fichiers sur la date de construction.
3. Le journal `main.log` (produit par `--keep-logs`, répertoire du fichier d'entrée) est téléversé en artefact `spec-pdf-log` (14 jours, `if-no-files-found: warn`) et un résumé d'étape (`$GITHUB_STEP_SUMMARY`) compte les lignes `Warning`, `undefined`/`Undefined` et `Missing character`. **Non bloquant** : aucun build sain n'a été observé, donc aucun seuil.

**Sémantique de la date.**
- `push`, `workflow_dispatch`, `release` : `actions/checkout` extrait par défaut le commit du contexte ; c'est sa date de commit qui est lue (comportement attendu, non observé en CI).
- `pull_request` : `actions/checkout` extrait le commit de fusion **synthétique** de GitHub ; la date est celle du calcul de cette fusion, pas celle du dernier commit de la branche. Elle change si GitHub recalcule la fusion (la base a bougé).
- Dans tous les cas, c'est la date du commit extrait par le job `spec`, qui est bien la source du TeX compilé par `spec-pdf` (même run, artefact `spec-tex`).

**Ce que cela ne démontre PAS.**
- Cela ne démontre pas que deux compilations du même TeX donnent les mêmes octets. Rien dans le workflow ne compile deux fois ni ne compare deux condensats.
- Le bundle TeX (`default_bundle_v33.tar`, hôte `relay.fullyjustified.net`) est toujours téléchargé à l'exécution et n'est pas épinglé : son contenu futur n'est pas contrôlé.
- Avec `use_cache: true` (défaut), l'état de départ dépend encore du cache `~/.cache/Tectonic` (clé constante, `restore-keys`).
- Les effets exacts de ces deux réglages sur les octets du PDF n'ont **pas** été mesurés : le bundle est inaccessible depuis la session, aucune compilation n'a pu être faite.
- La démonstration de niveau 2 de l'audit §5.7 (deux compilations dans deux répertoires frais, comparaison des condensats, enregistrement du condensat du bundle, contrôle négatif) reste à faire : **HUMAN ACTION REQUIRED** (décision H2 de l'audit) puis exécution en CI.

**Vérifié (étiquette PREPARED pour l'ensemble).**
- L'option existe : le binaire Tectonic 0.15.0 (extrait de l'archive dont le SHA-256 égale `TECTONIC_SHA256`) liste `-Z deterministic-mode` ; la ligne de commande exacte du workflow est acceptée par l'analyse des arguments (l'échec ne survient qu'au téléchargement du bundle) ; une option inconnue est rejetée à l'analyse (témoin). Code amont `tectonic@0.15.0` lu : `build_date_from_env` donne priorité à `SOURCE_DATE_EPOCH`, et le mode déterministe masque les chemins absolus.
- Le shell des nouvelles étapes (date, garde, résumé) a été exécuté avec un faux `tectonic` (voir `VALIDATION.md` §2.5). Cela valide le câblage, pas Tectonic.

## Ce qui n'est pas fait, et pourquoi

| Point | Raison | Statut |
|---|---|---|
| Construction « A / B » du niveau 1 (audit §5.7), job `repro` | hors liste des actions R2/R9/R10/R11 ; décision H2 de l'autrice | FUTURE / HUMAN ACTION REQUIRED |
| `leanOptions` sur `lean_exe mainTest` et `spec` (audit O3) | `lakefile.lean` interdit | décision de l'autrice |
| `suivi.py check` en CI (audit O4) | hors périmètre | FUTURE |
| Mise à jour de `.github/workflows/README.md` (commande de test, `check_lean_modules.py`, `use_cache`, artefact `spec-pdf-log`, classement de `axiom-audit.sh`) | fichier de la session principale | à faire par elle |
| Mention du contrôle d'exhaustivité dans `.claude/skills/writing-rules.md` §5 | `.claude/**` interdit | à décider |
| Exécution réelle des workflows modifiés | aucune écriture sur GitHub, pas de push | HUMAN ACTION REQUIRED (CI) |

## Décisions qui reviennent à l'autrice

1. Publication Pages relancée par une modification de `scripts/axiom-audit.sh` (conséquence de `spec_build`) : accepter, ou séparer un indicateur dédié.
2. Boucle d'audit des tests (3 clones d'`axiom-audit`) contre une évolution de `scripts/axiom-audit.sh` (plusieurs racines).
3. Étendre `check_lean_modules.py` à `tools` et `spec` (`--dirs`) : un changement d'une ligne dans `verify.yaml`, sans violation aujourd'hui.
4. Rendre le résumé du journal Tectonic bloquant, après observation d'un build sain.
5. Niveau de reproductibilité visé pour le PDF (H2).

## Vague 2 bis (corrections après l'audit de vérification indépendante)

Deux commits de l'agent qualité (`178b3d8`, `f07fe7e`), intégrés par la session principale. L'agent s'est arrêté (limite de dépense de
l'organisation) avant d'écrire sa propre section de suivi et sa mutation : cette section et la vérification qui l'accompagne
(`VALIDATION.md`) sont de la session principale, et ne couvrent que ce qu'elle a observé.

| Fichier | Changement | Raison |
|---|---|---|
| `scripts/ci/check_lean_modules.py` | `srcDir`, `roots` (bibliothèque) et `root` (exécutable) doivent être des littéraux ; plus aucune valeur par défaut de Lake supposée (`"."`, `` `Main ``, nom de la cible) | un champ omis était une valeur supposée, donc un silence possible |
| `scripts/ci/check_lean_modules.py` | lecture de l'en-tête d'import alignée sur la grammaire de Lean 4.34 : `[module] [prelude] ([public] [meta] import [all] Nom)*` | l'ancienne lecture acceptait `private` et `runtime`, absents de cette grammaire |
| `scripts/ci/impact.py` | un échec de `git diff` arrête le script (message et code de sortie explicites) | un diff en échec devenait « aucun chemin modifié », donc aucune validation |
| `scripts/ci/impact.py` | suppression de `--diff-filter` ; `--no-renames` conservé | tout type de changement compte ; un renommage vaut suppression plus ajout (déplacer `lakefile.lean` sous `docs/` ne passe plus pour un changement de documentation) |
| `scripts/ci/impact.py` | suppression d'une branche morte (`elif … pass`) | code non testé et sans effet |
| `scripts/ci/test_check_lean_modules.py`, `test_impact.py` | tests du code de sortie en sous-processus, de chaque défaut de Lake, de la suppression et du renommage | une régression de l'un de ces comportements fait échouer un test (voir `VALIDATION.md`) |

**Limite assumée.** Une en-tête d'import qui utilise un mot-clé absent de la grammaire de Lean 4.34 (`private import`) arrête la lecture des
imports à cette ligne : le script peut alors signaler un orphelin à tort, jamais passer sous silence un orphelin réel. Il échoue du côté sûr.
