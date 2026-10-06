<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Validation qualité et reproductibilité : vague 2

| | |
|---|---|
| Domaine | `quality-reproducibility-specialist` |
| Base | `b5f6146` ; commits `e0d474f`, `08eb987`, `a888c1f`, `e3a5e79`, `ac5b2a1`, `144309b` (voir `CHANGES.md`), puis le commit de documentation de ce dossier |
| Nature | Sorties **réellement observées** dans cette session. Ce qui n'a pas pu être exécuté est listé au §3. |
| Étiquettes | **[EXÉCUTÉ]** commande lancée ici, sortie observée ; **[LU]** fichier ou source amont lu ; **[ESTIMÉ]** non vérifié |
| Statuts | `VERIFIED` · `PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE` |

**Règle de lecture.** Un contrôle plus faible ne tient pas lieu de preuve d'une propriété plus forte. Les deux workflows modifiés (`ci.yaml`, `verify.yaml`) sont `PREPARED` : analysés par des outils statiques et par exécution de leur logique shell dans des dépôts jetables, **jamais exécutés par GitHub Actions**. Je n'ai **pas** exécuté `lake build K7pl K7plTests`, `lake test` ni `lake lint` sur le dépôt (Mathlib).

## Environnement

Python 3.11.15, git 2.43.0, actionlint 1.7.12 (avec shellcheck 0.11.0, installé par `pip install shellcheck-py` dans un répertoire du scratchpad ; actionlint l'utilise s'il est sur le `PATH`), zizmor 1.30.1 (hors ligne), reuse 6.2.0, Lean 4.34.0 / Lake 5.0.0 (archive de toolchain GitHub déjà utilisée par l'audit ; son SHA-256 n'a pas été comparé à un condensat indépendant), Tectonic 0.15.0 (archive dont le SHA-256 `dfb82876…6407` égale `TECTONIC_SHA256` de `verify.yaml`, recalculé ici ; binaire extrait de cette archive). Les scripts de validation sont dans le scratchpad de la session et ne sont pas versionnés.

## 1. Synthèse

| # | Action | Contrôle | Résultat observé | Statut |
|---|---|---|---|---|
| 1 | tous | `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` (depuis la racine, puis depuis `/tmp`) | 51 tests, OK (21 `test_impact`, 30 `test_check_lean_modules`) | VERIFIED |
| 2 | R9, R10 | contrôle par mutation de `impact.py` et `check_lean_modules.py` | 15 mutants sur 15 tués ; version initiale : 1 mutant survivant, corrigé (§1.2) | VERIFIED |
| 3 | R9 | simulation de bout en bout de l'étape `impact` (ancienne et nouvelle) | 10 chemins : `full=true`, `unclassified=false` par `impact.py` seul ; mêmes ensembles | VERIFIED |
| 4 | R2, R9, R10, R11 | actionlint (+ shellcheck) sur les 9 workflows | 0 constat, avant et après | VERIFIED |
| 5 | R2, R9, R10, R11 | zizmor `--offline`, personas `regular` et `auditor` | constats identiques à la base (aucun nouveau) | VERIFIED |
| 6 | R10 | `check_lean_modules.py` sur le dépôt réel | OK : 7 fichiers, 9 racines, 7 cibles | VERIFIED |
| 7 | R10 | orphelins sur mini-projet avec le vrai Lake | `lake build` réussit, le script échoue (code 1) | VERIFIED (mécanisme) |
| 8 | R10 | `axiom-audit.sh SpecExt SpecExt`, `SpecBib SpecBib`, `Spec Spec` (vrai script) | 586, 2, 1319 déclarations, dans la liste autorisée | VERIFIED |
| 9 | R10 | commande littérale `axiom-audit.sh K7plTests K7plTests` (mini-projet de même disposition) | échec, code 2 : `unknown module prefix 'K7plTests'` | VERIFIED (écart au contrat) |
| 10 | R10 | boucle d'audit des tests (bloc `run` réel), mini-projet | propre : 3 racines OK ; `native_decide` : échec nommant la racine ; `lake build` reste vert | VERIFIED (mécanisme) |
| 11 | R10 | audit d'axiomes de `K7plTests` sur le dépôt | non exécuté (Mathlib) | PREPARED / HUMAN ACTION REQUIRED (CI) |
| 12 | R11 | option `-Z deterministic-mode` de Tectonic 0.15.0 | listée par le binaire ; ligne de commande du workflow acceptée à l'analyse | PREPARED |
| 13 | R11 | logique shell (date, garde, résumé) avec un faux `tectonic` | conforme (§2.5) | VERIFIED (câblage seulement) |
| 14 | R11 | compilation du PDF | non exécutée (bundle injoignable) | BLOCKED |
| 15 | tous | `reuse lint` | conforme REUSE 3.3 (§2.6) | VERIFIED |
| 16 | tous | `lake build K7pl K7plTests`, `lake test`, `lake lint` ; exécution des workflows | non exécutés | HUMAN ACTION REQUIRED (CI) |

### 1.1 Tests unitaires

**[EXÉCUTÉ]** depuis la racine du worktree :

```
$ python3 -m unittest discover -s scripts/ci -p 'test_*.py'
...................................................
Ran 51 tests in 1.489s

OK
```

Même résultat lancé depuis `/tmp` avec le chemin absolu du répertoire (les tests ne dépendent pas du répertoire courant). Les tests `test_check_manifest.py` et `test_sync_zenodo.py` de l'autre agent n'existent pas dans ce worktree : **non exécutés**.

### 1.2 Contrôle par mutation

Question posée : « un test peut-il échouer si la propriété visée est cassée ? » (`.claude/rules/lean.md`). **[EXÉCUTÉ]** : chaque mutation est appliquée à une copie jetable de `scripts/ci/`, puis les tests sont lancés ; l'état non muté doit passer.

```
unmutated: returncode=0 (OK)
[0]  drop .github/dependabot.yml from FULL_EXACT                    KILLED (3 failing)
[1]  drop lake-manifest.json from FULL_EXACT                        KILLED (3)
[2]  drop scripts/requirements-zenodo.txt from FULL_EXACT           KILLED (3)
[3]  drop lean-toolchain from FULL_EXACT                            KILLED (3)
[4]  drop scripts/ci/ from FULL_PREFIXES                            KILLED (4)
[5]  drop .github/workflows/ from FULL_PREFIXES                     KILLED (4)
[6]  axiom-audit.sh no longer triggers spec_build                   KILLED (2)
[7]  axiom-audit.sh no longer triggers lean_build                   KILLED (2)
[8]  imports are not followed                                       KILLED (10)
[9]  comments are not stripped before reading imports               KILLED (3)
[10] scan finds nothing (vacuous pass)                              KILLED (6)
[11] globs silently accepted                                        KILLED (1)
[12] missing scanned directory silently skipped                     KILLED (1)
[13] keyword tripwire removed                                       KILLED (1)
[14] orphans no longer fail the exit status                         KILLED (5)
survivors or errors: 0
```

Sur la première version des tests, deux mutants avaient échappé (`[9]`, `[11]`) : le test de `globs` échouait pour une mauvaise raison (la racine par défaut n'avait pas de fichier), et aucun test n'avait de commentaire entre deux imports. Les tests ont été durcis (raison de l'échec vérifiée dans chaque test d'échec bruyant ; `globs` combiné à une liste `roots` valide ; test du commentaire dans l'en-tête), puis la mutation relancée. **Ce que cela ne prouve pas** : 15 mutants choisis par moi ne forment pas une preuve de couverture ; c'est un contrôle de sensibilité.

## 2. Détails

### 2.1 R9 : preuve avant suppression de l'étape `grep`

**[EXÉCUTÉ]** `sim_ci.py` : extrait par PyYAML le bloc `run` de l'étape `id: impact` de l'ancien `ci.yaml` (commit `b5f6146`) et du nouveau, les exécute avec `EVENT_NAME=pull_request` dans un dépôt git jetable où seul le chemin testé diffère entre base et tête, avec l'`impact.py` de l'ancien commit pour l'ancienne étape et celui du worktree pour la nouvelle (le chemin `scripts/ci/impact.py` est modifié par un commentaire Python pour que le fichier reste valide).

```
new step has no grep: True
regex alternatives: ['.github/dependabot.yml', '.github/workflows/', 'lake-manifest.json', 'lakefile.lean',
  'lean-toolchain', 'scripts/ci/', 'scripts/requirements-zenodo.txt', 'scripts/sync_zenodo.py']
impact FULL_EXACT + FULL_PREFIXES: (même liste, 8 éléments)
same set of paths: True

path                              | OLD (shell regex + impact)        | NEW (impact only)
.github/dependabot.yml            | full=true unclass=false n=1       | full=true unclass=false n=1
lake-manifest.json                | full=true unclass=false n=1       | full=true unclass=false n=1
lakefile.lean                     | full=true unclass=false n=1       | full=true unclass=false n=1
lean-toolchain                    | full=true unclass=false n=0       | full=true unclass=false n=1
scripts/requirements-zenodo.txt   | full=true unclass=false n=1       | full=true unclass=false n=1
scripts/sync_zenodo.py            | full=true unclass=false n=1       | full=true unclass=false n=1
.github/workflows/check.txt       | full=true unclass=false n=0       | full=true unclass=false n=1
scripts/ci/check.txt              | full=true unclass=false n=0       | full=true unclass=false n=1
scripts/ci/impact.py              | full=true unclass=false n=0       | full=true unclass=false n=1
.github/workflows/ci.yaml         | full=true unclass=false n=0       | full=true unclass=false n=1
scripts/axiom-audit.sh            | full=false lean=true spec=false   | full=false lean=true spec=true
src/K7pl/X.lean, tests/XTest.lean | full=false lean=true spec=false   | (identique)
docs/x.md, .github/ISSUE_TEMPLATE/x.md | full=false, tout faux      | (identique)
spec/Spec/C1.lean                 | full=false spec=true lean=false   | (identique)
scripts/suivi.py                  | full=true unclass=true            | full=true unclass=true
OLD workflow_dispatch: full=true lean=true spec=true docs=true
NEW workflow_dispatch: full=true lean=true spec=true docs=true
paths of the lists NOT forced to full by impact.py alone (must be 0): 0
```

Lecture : `n` est le nombre de chemins listés par `impact.py` ; `n=0` désigne l'ancienne branche `--force-full` (celle de la regex, atteinte pour les seuls `lean-toolchain`, `.github/workflows/`, `scripts/ci/`). Les cinq autres chemins n'ont jamais emprunté la branche regex mais donnaient déjà `full=true` par `impact.py`. Le seul écart ancien/nouveau est celui voulu : `scripts/axiom-audit.sh` déclenche `spec_build`.

### 2.2 Analyse statique des workflows

**[EXÉCUTÉ]** `actionlint` sur `.github/workflows/*.yaml`, avec shellcheck sur le `PATH` (sonde : un `echo $x` non cité y est bien signalé, SC2086) : **0 constat** sur la base `b5f6146` et sur le worktree, code 0. Sans shellcheck : 0 constat également.

**[EXÉCUTÉ]** `zizmor --offline`, comparaison par (persona, règle, gravité, fichier, extrait du code) sans numéros de ligne :

| Persona | Base | Worktree |
|---|---|---|
| `regular` | 30 constats (22 supprimés) : 1 informational, 7 low, 0 medium, 0 high | identique |
| `auditor` | 30 constats : 8 informational, 17 low, 5 medium, 0 high | identique |

Le résumé détaillé (`self-repository` ×7, `template-injection` ×1 pour `regular` ; plus `anonymous-definition`, `concurrency-limits`, `excessive-permissions`, `secrets-outside-env`, `superfluous-actions`, `undocumented-permissions` pour `auditor`) est identique ligne à ligne : **aucun constat nouveau**. Limite : mode hors ligne, les audits qui interrogent l'API GitHub ne sont pas exécutés ; je n'ai appliqué aucune correction automatique.

### 2.3 R10 : exhaustivité des modules Lean

**[EXÉCUTÉ]** sur le dépôt réel :

```
$ python3 scripts/ci/check_lean_modules.py
check_lean_modules: 7 Lean file(s) under src, tests, all reachable from the 9 root(s) of 7 lean_lib/lean_exe target(s).
$ python3 scripts/ci/check_lean_modules.py --roots-in tests
ArithTest
MainTest
SemanticsTest
$ python3 scripts/ci/check_lean_modules.py --dirs src tests tools spec      # information, non branché
check_lean_modules: 86 Lean file(s) under src, tests, tools, spec, all reachable ...
```

**[EXÉCUTÉ]** reproduction de R1 avec le vrai Lake (mini-projet de même disposition que `lakefile.lean`, Lean 4.34.0, sans Mathlib), en ajoutant `tests/OrphanTest.lean` (`#guard 2 + 2 == 5`) et `src/K7pl/Orphan.lean`, absents de tout `roots` et non importés :

```
lake build K7pl K7plTests        -> Build completed successfully (8 jobs).     exit=0
check step (bloc run réel)       -> check_lean_modules: Lean files that no lean_lib/lean_exe root reaches:
                                      src/K7pl/Orphan.lean
                                      tests/OrphanTest.lean                       exit=1
lake env lean tests/OrphanTest.lean -> error: Expression 2 + 2 == 5 did not evaluate to `true`   exit=1
```

C'est le fait de l'audit §8 R1, reproduit : le build reste vert tandis que le fichier est faux. Le contrôle l'attrape. Les cas d'échec bruyant (code 2) sont couverts par les tests du §1.1.

### 2.4 R10 : audits d'axiomes

**[EXÉCUTÉ]** le vrai `scripts/axiom-audit.sh` du worktree, dans la copie `A` de l'audit (sources identiques au worktree : `diff` de `spec/`, `tools/`, `lakefile.lean`, `lake-manifest.json` sans différence), déjà construite :

```
scripts/axiom-audit.sh Spec Spec        -> axiom-audit: audited 1319 declaration(s) under 'Spec'; all within the allowlist   exit=0
scripts/axiom-audit.sh SpecExt SpecExt  -> axiom-audit: audited 586 declaration(s) under 'SpecExt'; all within the allowlist  exit=0
scripts/axiom-audit.sh SpecBib SpecBib  -> axiom-audit: audited 2 declaration(s) under 'SpecBib'; all within the allowlist     exit=0
```

(liste autorisée : `propext`, `Classical.choice`, `Quot.sound`). Les deux étapes ajoutées au job `spec` passent donc sur le commit actuel.

**Audit des tests : écart avec le contrat.** Sur un mini-projet de même disposition que `lakefile.lean` (`lean_lib K7pl`, `lean_lib K7plTests` à racines plates, `lean_exe mainTest`), **[EXÉCUTÉ]** :

```
scripts/axiom-audit.sh K7plTests K7plTests
  axiom-audit: failed to load the environment or audit: unknown module prefix 'K7plTests'      exit=2
scripts/axiom-audit.sh ArithTest K7plTests      -> audited 2 declaration(s) under 'ArithTest' ...        exit=0
scripts/axiom-audit.sh SemanticsTest K7plTests  -> audited 2 declaration(s) under 'SemanticsTest' ...    exit=0
scripts/axiom-audit.sh ArithTest +ArithTest     -> audited 2 declaration(s) under 'ArithTest' ...        exit=0
scripts/axiom-audit.sh MainTest mainTest        -> audited 3 declaration(s) under 'MainTest' ...         exit=0
scripts/axiom-audit.sh MainTest +MainTest       -> audited 3 declaration(s) under 'MainTest' ...         exit=0
```

Cause **[LU]** (`AxiomAudit.lean` et `Main.lean` du dépôt `axiom-audit` au SHA épinglé `46024e00…`) : `inAuditedLib root mod := mod == root || root.isPrefixOf mod`, et sans `--modules` l'environnement est celui de `import <racine>`. La commande demandée aurait fait échouer la CI à chaque exécution.

**[EXÉCUTÉ]** blocs `run` réels du workflow (extraits par PyYAML) sur ce mini-projet, trois cas :

```
A. projet propre : Build completed successfully ; audit loop (tests) exit=0
     ::group::axiom-audit ArithTest      -> audited 2 declaration(s) ... within the allowlist
     ::group::axiom-audit MainTest       -> audited 3 declaration(s) ... within the allowlist
     ::group::axiom-audit SemanticsTest  -> audited 2 declaration(s) ... within the allowlist
B. `theorem bad : 2 + 2 = 4 := by native_decide` dans SemanticsTest :
     lake build K7pl K7plTests -> Build completed successfully   exit=0   (rien ne le signale à la compilation)
     audit loop (tests) exit=1 : ArithTest et MainTest OK (la boucle continue), puis
     ::error::the axiom audit of SemanticsTest failed
     axiom-audit: 2 declaration(s) under 'SemanticsTest' use disallowed axioms:
       SemanticsTest.bad._native.native_decide.ax_1_1 → [...]   SemanticsTest.bad → [...]
C. orphelins : voir §2.3
```

Le cas B est le test négatif de l'audit des tests : la violation passe `lake build` et échoue à l'audit, avec la racine fautive nommée. **Ce qui n'est pas établi** : le comportement sur les vrais `ArithTest`, `SemanticsTest` et `MainTest` de k7pl (importent Mathlib et CSLib, non construits ici). Statut : **PREPARED**, à valider par la CI ; aucune violation n'est connue (ces modules contiennent des `#guard`, des `example` et des listes de booléens, d'après l'audit §3.2).

### 2.5 R11 : Tectonic et logique shell

**[EXÉCUTÉ]** binaire Tectonic 0.15.0 extrait de l'archive épinglée (`tectonic -X compile -Z help main.tex`) :

```
    -Z deterministic-mode       Force a deterministic build environment. Note that setting
                                    `SOURCE_DATE_EPOCH` is usually sufficient for reproducible builds,
                                    and this option makes some extra functionality trade-offs.
                                    Specifically, deterministic mode breaks SyncTeX's auxiliary files ...
$ SOURCE_DATE_EPOCH=1700000000 tectonic -X compile --keep-logs -Z deterministic-mode main.tex
note: connecting to https://relay.fullyjustified.net/default_bundle_v33.tar
error: error sending request for url (...): unsuccessful tunnel          (bundle injoignable, après l'analyse des arguments)
$ tectonic -X compile --keep-logs -Z no-such-option main.tex
error: Invalid value for '-Z <option>...': Unknown unstable option 'no-such-option'      (témoin : l'analyse peut échouer)
```

**[LU]** `tectonic@0.15.0`, `src/driver.rs` (`build_date_from_env` : `SOURCE_DATE_EPOCH` prioritaire, sinon `UNIX_EPOCH` en mode déterministe, sinon l'heure courante ; `expect("invalid SOURCE_DATE_EPOCH (not a number)")` sur une valeur non numérique) et `src/unstable_opts.rs`. La note du binaire dit elle-même que `SOURCE_DATE_EPOCH` « is usually sufficient » : le mode déterministe y ajoute des compromis (SyncTeX), sans effet ici (`--synctex` n'est pas demandé).

**[EXÉCUTÉ]** `sim_pdf.py` : blocs `run` réels des étapes `Record the commit date of the source`, `Compile the PDF`, `Summarise the compilation log`, avec un faux `tectonic` qui enregistre ses arguments (cela valide le câblage, **pas** Tectonic) :

```
Record the commit date : commit de date de committer 2001-09-09T01:46:40Z (date d'auteur différente)
   -> exit=0 output='epoch=1000000000'                 (hors dépôt : exit=128, aucune sortie écrite)
Compile the PDF :
   SOURCE_DATE_EPOCH='1000000000' exit=0 ; stub : tectonic -X compile --keep-logs -Z deterministic-mode main.tex | SOURCE_DATE_EPOCH=1000000000
   ''  | '12ab' | '-1' | '1.5'  -> exit=1, "::error::SOURCE_DATE_EPOCH is not a number: ...", Tectonic non appelé
Summarise the compilation log :
   avec journal : exit=0 ; lignes=6, 'Warning'=2, 'Undefined'/'undefined'=2, 'Missing character'=1
   sans journal : exit=0 ; "No log found at _out/spec/tex/main.log"
```

Le résumé est non bloquant dans les deux cas (code 0).

### 2.6 `reuse lint`

**[EXÉCUTÉ]** `reuse lint` (6.2.0) à la racine du worktree, commits inclus et nouveaux fichiers présents :

```
* Files with copyright information: 367 / 367
* Files with license information: 367 / 367
Congratulations! Your project is compliant with version 3.3 of the REUSE Specification :-)
```

(base : 363 fichiers ; +2 scripts, +2 documents.) La version de `reuse` de l'action CI n'a pas été vérifiée.

## 3. Ce qui n'a pas été exécuté

| Point | Raison | Statut |
|---|---|---|
| `lake build K7pl K7plTests`, `lake test`, `lake lint` | Mathlib précompilé indisponible ici ; jamais exécutés par moi | HUMAN ACTION REQUIRED (CI) |
| Audit d'axiomes de `ArithTest`, `SemanticsTest`, `MainTest` sur k7pl | idem ; mécanisme validé sur mini-projet seulement | PREPARED |
| `check_lean_modules.py` dans le job `impl` réel | non exécuté par Actions ; exécuté sur le dépôt et sur mini-projets | PREPARED |
| Exécution des workflows (`ci.yaml`, `verify.yaml`) par GitHub Actions, dont `use_cache: false` et la sortie de job `source_date_epoch` | pas d'écriture sur GitHub, pas de push | HUMAN ACTION REQUIRED |
| Compilation Tectonic, effet de `SOURCE_DATE_EPOCH` et de `-Z deterministic-mode` sur les octets du PDF, contenu réel de `main.log` | bundle `relay.fullyjustified.net` refusé par le proxy | BLOCKED |
| Deux compilations et comparaison de condensats (niveau 2, audit §5.7) | non implémenté ; décision H2 | HUMAN ACTION REQUIRED / FUTURE |
| Tests `test_check_manifest.py` et `test_sync_zenodo.py` (autre agent) | absents du worktree | non exécutés |
| lychee, commitlint, gitleaks | hors périmètre, outils absents | non exécutés |
| Format Conventional Commits des 7 commits | longueur d'en-tête vérifiée à la main (≤ 100 caractères) ; `commitlint` non exécuté | PARTIAL |

## 4. Relecture adversariale du diff

**Un contrôle peut-il être sauté silencieusement ?**
- `Check that every Lean file is built` : pas de `if`, donc exécuté chaque fois que `impl` l'est ; `impl` est lancé par `lean_build` (`src/`, `tests/`, `scripts/axiom-audit.sh`) ou `full` (`lakefile.lean`, `scripts/ci/`…) : toute modification qui peut créer un orphelin déclenche le job (confirmé par `test_impact.py`).
- `Audit the axioms (tests)` : une liste de racines vide est impossible (`--roots-in` sort en code 2 s'il n'y en a pas) ; une erreur de lecture du lakefile échoue l'étape (`set -e` sur l'affectation) ; une racine en échec ne masque pas les autres mais fait échouer l'étape.
- Les nouveaux audits portent `if: ${{ !cancelled() }}` (comme l'audit `K7pl` existant) : un échec de build ne les saute pas. Limite : si une étape précédente échoue, ils s'exécutent quand même et peuvent produire du bruit, jamais un succès trompeur.
- Aucun nouveau `continue-on-error`, aucun `|| true` hors du comptage non bloquant du journal Tectonic (par construction).
- **Reste non couvert** : `tools/` et `spec/` pour l'exhaustivité (observé propre aujourd'hui, non branché) ; `leanOptions` des deux `lean_exe` (audit O3).

**`ci-ok` accepte-t-il toujours exactement ce qu'il doit ?** Oui : le bloc `ci-ok` n'est pas modifié ; `needs` inchangé ; `success` strict pour `impact`, `verify`, `reuse`, `commitlint`, `security`. `verification-result` est inchangé ; les étapes ajoutées sont dans les jobs existants et ne peuvent que faire échouer davantage. L'étape `impact` échoue toujours bruyamment si `impact.py` échoue (`set -euo pipefail`).

**Ai-je affaibli quelque chose ?**
- Supprimé : l'étape `grep` de `ci.yaml`, **prouvée** redondante (§2.1) ; sa suppression ne retire aucun chemin de `full`, et un chemin retiré de `impact.py` fait désormais échouer des tests (§1.2), ce qui n'était pas le cas avant.
- Remplacé : `python3 scripts/ci/test_impact.py` par `unittest discover`, qui exécute au moins les mêmes tests (les 9 d'origine sont conservés).
- Renommé : les étapes `Audit the axioms` (K7pl, Spec) ; aucune référence à ces noms hors du fichier (le ruleset exige `CI OK`, un nom de job).
- Aucun linter, aucun test ni `warningAsError` désactivé ; aucun `sorry`, `admit`, `axiom` ni `native_decide` introduit ; `lakefile.lean`, `lean-toolchain`, `lake-manifest.json` non touchés ; seul `.github/workflows/` est modifié, ce qui est à signaler dans la PR (`.claude/rules/lean.md`).

**Risques résiduels.**
- `spec_build` pour `axiom-audit.sh` relance la publication Pages sur `main` (décision signalée dans `CHANGES.md`).
- `spec-pdf` dépend maintenant de la sortie de job `spec` : si une évolution rend `spec` non producteur de la sortie, l'étape de compilation échoue explicitement (garde numérique), sans produire un PDF daté de l'heure courante.
- La date est celle du commit de fusion synthétique pour `pull_request` : un PDF construit en PR peut changer de date sans changement de source.
- `.github/workflows/README.md` (session principale) décrit encore `test_impact.py` comme la commande de test : à mettre à jour.

## Vague 2 bis : vérification par la session principale

Faits observés, dans l'ordre. Ce que l'agent a lui-même mesuré avant de s'arrêter n'est pas repris ici : il ne l'a pas consigné.

1. **Dépôt réel.** `python3 scripts/ci/check_lean_modules.py` : 7 fichiers sous `src` et `tests`, tous atteints depuis 9 racines de 7 cibles,
   code de sortie 0. `--roots-in tests` : `ArithTest`, `MainTest`, `SemanticsTest` (identique à la liste utilisée par `verify.yaml`).
2. **Suite.** `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` : 258 tests réussis (tous modules `scripts/ci/` confondus).
   Fonctions `test_` de `test_impact.py` : 21 avant, 44 après ; de `test_check_lean_modules.py` : 30 avant, 59 après.
3. **Grammaire d'import.** Source de Lean `v4.34.0` (`src/Lean/Parser/Module.lean`, obtenu depuis `raw.githubusercontent.com`) : le motif
   `Module.header| $[module]? $[prelude]? $importsStx*` et `Module.import| $[public]? $[meta]? import $[all]? $mod` correspond à la lecture
   du script. Aucun `lean` n'est installé dans la session : la grammaire a été lue, non exécutée.
4. **Mutation ciblée** (9 mutants écrits à la main, suite complète relancée pour chacun, fichier restauré ensuite) :

   | Mutant | Résultat |
   |---|---|
   | échec de `git diff` ignoré | tué |
   | détection des renommages rétablie | tué |
   | `--diff-filter=AM` (suppressions perdues) | tué |
   | `import all` non sauté | tué |
   | modificateur `public` non sauté | tué |
   | mot-clé `module` non sauté | tué |
   | `srcDir` par défaut supposé | tué |
   | `root` par défaut supposé | tué |
   | `roots` par défaut supposé | tué |

   9 mutants, 9 tués, 0 survivant. C'est un échantillon choisi après lecture du diff, pas une mutation exhaustive : il ne prouve pas
   qu'aucune régression ne passe.
5. **Non fait.** Parité CI de `shellcheck` pour les fichiers de cette vague : sans objet (aucun workflow touché). Aucune exécution GitHub de
   ces scripts depuis l'intégration (voir `docs/security/IMPLEMENTATION-STATUS.md` pour la CI de la tête finale).
