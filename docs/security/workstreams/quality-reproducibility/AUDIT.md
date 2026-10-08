<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit qualité et reproductibilité — vague 1

Domaine : `quality-reproducibility-specialist` (tests, qualité CI, analyse statique, fuzzing, builds déterministes, reproductibilité des artefacts).
Nature du document : **audit uniquement**. Aucun fichier du dépôt autre que celui-ci n'a été modifié. Aucune décision n'est prise ici : les propositions sont des recommandations pour l'arbitrage de l'orchestrateur.

## Résumé

| Question | Réponse | Statut |
|---|---|---|
| La regex `\\.` de `ci.yaml:57` a-t-elle un effet ? | Non, aujourd'hui : 5 alternatives sur 8 sont mortes (testé avec la regex exacte), mais `impact.py` (`FULL_EXACT`) et son repli « inconnu → full » compensent (testé de bout en bout). La regex est entièrement redondante ; défaut SIGPIPE/`pipefail` latent reproduit. | VERIFIED |
| `ci-ok` / `verification-result` cohérents sur `skipped` ? | Oui : `skipped` n'est accepté qu'à l'intérieur de `verify.yaml` ; `ci-ok` exige `success` strict ; seule exigence du ruleset : `CI OK`. | VERIFIED (lu + API publique) |
| Que contient `src/` ? | 9 déclarations (deux exemples jouets, 2 théorèmes prouvés) ; ni lexer, ni parser, ni AST k7pl. | VERIFIED (lu) |
| Fuzzing / tests par propriétés ? | Non pertinent aujourd'hui (aucune surface d'entrée) ; déclencheurs identifiés. | FUTURE |
| SAST ? | Aucun outil à ajouter pour Lean ; actionlint propre ; zizmor (8 constats faibles) optionnel ; pas de CodeQL pour le score. | VERIFIED (exécuté) / décision à prendre |
| Reproductibilité ? | **PARTIAL.** Lean → HTML/TeX : identique sur 2 builds propres × 3 rendus (HTML 290 fichiers, TeX 40, 78 + 654 artefacts Lean). TeX → PDF : non exécuté (bundle injoignable) et non déterministe tel qu'écrit. Jamais « reproductible » sans niveau 2. | PARTIAL / BLOCKED (PDF) |
| `reuse lint` ? | Conforme REUSE 3.3, 363/363 fichiers (reuse 6.2.0). | VERIFIED |
| Régressions invisibles aujourd'hui ? | Fichiers Lean orphelins (testé), `native_decide` hors `K7pl`/`Spec` (testé), avertissements dans les racines d'exécutables (testé), PDF dégradé, dérive de `docs/suivi`. | VERIFIED (mécanismes) |
| `lake build K7pl`, `lake test`, `lake lint` | **Non exécutés par moi** (Mathlib). | NON VÉRIFIÉ → H1 |

Écarts critiques : aucun. Importants : I1 à I4 (§9.1).



## 0. Portée, méthode, provenance des preuves

**Commit audité** : `b5f6146` (`refactor(ci): nettoyer le classifieur d'impact`, 2026-10-06), worktree `agent-abb4167bc8009ac55`, branche `worktree-agent-abb4167bc8009ac55`.

**Règle de lecture.** Chaque affirmation porte l'une de ces étiquettes d'origine :

- **[EXÉCUTÉ]** : commande lancée par moi dans cette session, sortie observée (la commande ou le script est cité).
- **[LU]** : lecture d'un fichier du dépôt ou d'une source amont (fichier:ligne). Une lecture n'établit pas un comportement d'exécution.
- **[PISTE]** : élément repris d'une pièce laissée dans le scratchpad par un prédécesseur ou par un autre agent, **non réexécuté** par moi. Un [PISTE] n'est jamais une preuve ici.
- **[ESTIMÉ]** : souvenir ou raisonnement non vérifié.

**Écart avec le briefing (fait observé).** Le briefing indique qu'aucune toolchain Lean n'est disponible (`release.lean-lang.org` refusé). C'est exact pour *elan*, mais l'archive de la toolchain est téléchargeable depuis les assets de la release GitHub `leanprover/lean4` (le proxy refuse `release.lean-lang.org`, pas `github.com`). J'ai donc pu exécuter **réellement** Lean 4.34.0 / Lake 5.0.0 sur la partie du dépôt qui n'exige pas le cache binaire de Mathlib : la spécification (`lake build Spec`, `lake exe spec`) et un mini-projet de contrôle (§3.4, §5). En revanche, je n'ai **pas** exécuté `lake build K7pl K7plTests`, `lake test` ni `lake lint` sur le dépôt lui-même (voir §0.1). Ces trois contrôles restent **non vérifiés par moi**.

### 0.1 Ce qui a été exécuté, ce qui ne l'a pas été

| Contrôle | Exécuté par moi ? | Détail |
|---|---|---|
| `python3 scripts/ci/test_impact.py` | oui | 9 tests, OK (§2.3) |
| `python3 scripts/controle.py` | oui | « TOUS LES CONTROLES PASSENT », code retour 0 |
| `python3 scripts/suivi.py check` + `all` (dans une copie) | oui | 190 fiches ; aucune différence avec `docs/suivi/` (§8) |
| `reuse lint` (reuse 6.2.0, installé par `pip`) | oui | conforme REUSE 3.3, 363/363 fichiers (§6) |
| actionlint 1.7.12, zizmor 1.30.1 (hors ligne), bandit 1.9.4, ruff 0.16.10 | oui | sorties au §4 |
| `lake build Spec`, `lake exe spec --with-tex` (Lean 4.34.0) | oui | protocole et résultats au §5 |
| `scripts/axiom-audit.sh` (le vrai script) | oui, sur un mini-projet seulement | §3.4 ; pas sur `K7pl` ni `Spec` du dépôt, voir §5.6 pour `Spec` |
| `lake build K7pl K7plTests`, `lake test`, `lake lint` sur le dépôt | **non** | exigent Mathlib précompilé (voir ci-dessous) |
| compilation TeX → PDF (Tectonic 0.15.0) | **non** | bundle TeX injoignable (§5.3) |
| lychee, commitlint, gitleaks | **non** | outils absents, hors périmètre de ce domaine |

Pourquoi pas `lake build K7pl` : ces cibles importent `Mathlib.Tactic.Ring` et `Cslib.Foundations.Semantics.LTS.Basic`, donc la fermeture transitive de Mathlib. Sans le cache binaire (`lake exe cache get`), il faudrait recompiler Mathlib depuis les sources, ce qui dépasse largement le budget de cette session. **[ESTIMÉ → à confirmer en vague 2 ou par la CI]** : la disponibilité du cache n'a pas été sondée ici (voir §9, « non vérifié »).

## 1. Cartographie des contrôles existants

Chaque ligne : propriété visée → niveau → oracle → erreur détectable → couverture CI réelle (selon les chemins modifiés, d'après `impact.py` et `verify.yaml`) → faiblesse. Les « faiblesses » renvoient aux sections d'analyse. Statuts : VERIFIED = j'ai exécuté ou observé le contrôle ; PARTIAL = existe mais couverture incomplète ; N/A = hors de ma capacité d'observation.

| # | Contrôle | Propriété → niveau | Oracle | Erreur détectée | Couverture CI réelle | Faiblesse | Statut |
|---|---|---|---|---|---|---|---|
| 1 | `lake build K7pl K7plTests` (`verify.yaml:95-96`) | modules et tests typent, théorèmes prouvés, `#guard` vrais, aucun avertissement → typage + sémantique (preuves) + compilation | noyau et élaborateur Lean ; `warningAsError` (`lakefile.lean`) | erreur de type, preuve fausse, `#guard` faux, tout avertissement **des bibliothèques** | job `impl` si `lean_build` (`src/`, `tests/`, `scripts/axiom-audit.sh`) ou `full` (lakefile, toolchain, manifeste, workflows, `scripts/ci/`, scripts inconnus, cron quotidien, `workflow_dispatch`) | fichiers hors `roots`/imports jamais compilés (§8 R1) ; racines d'exécutables hors `warningAsError` (§3.4) ; **non exécuté par moi** (Mathlib) | PARTIAL / non vérifié |
| 2 | `lake test` (`verify.yaml:98-99`) | exécution des 5 contrôles du `main` → comportement d'exécution (smoke) | liste de booléens, code retour 0/1 | régression dans `Expr.eval`, `step`, `Main.hello` (double emploi avec les `#guard`) | idem 1 | redondant avec `#guard` ; pas de contrôle du nombre de tests (§3.2) ; **non exécuté par moi** | PARTIAL / non vérifié |
| 3 | `lake lint` (`verify.yaml:101-103`, `lintDriverArgs := #["K7pl"]`) | linters d'environnement Batteries/Mathlib sur `K7pl.*` → invariants de style/doc | `batteries/runLinter` | docstrings manquantes, lemmes `simp` mal formés, etc. | idem 1 | périmètre `K7pl` seulement (`tests/`, `tools/`, `spec/` hors champ, **[ESTIMÉ]** `Main` aussi) ; **non exécuté par moi** | PARTIAL / non vérifié |
| 4 | Audit d'axiomes (`verify.yaml:116,148`) | aucune déclaration n'utilise d'axiome hors `propext/Classical.choice/Quot.sound` → métathéorie | environnement Lean, `axiom-audit` épinglé par tag **et** SHA | `sorry`, `native_decide`, tout `axiom` nouveau (**testé** §3.5) | `impl` : racine `K7pl` ; `spec` : racine `Spec` | `K7plTests`, `MainTest`, `SpecExt`, `SpecBib`, `SpecMain` non audités (SpecExt/SpecBib propres aujourd'hui, §5.6) ; `scripts/axiom-audit.sh` classé `lean` seul (§2.5) | VERIFIED (outil), PARTIAL (périmètre) |
| 5 | Avertissements = erreurs (`lakefile.lean`) | aucune dérive d'avertissement → compilation | Lake `leanOptions` | `sorry` (« declaration uses sorry »), linters Mathlib, variables inutilisées | bibliothèques seulement | exemptions : `lean_exe mainTest`, `lean_exe spec` (**testé** en mini-projet, §3.4) | PARTIAL |
| 6 | `python3 scripts/controle.py --format github` (`verify.yaml:55-57`) | cohérence interne de la spécification (structure, algèbre, notation, croisement grammaire/règles, 17 sondes sémantiques) → documentaire/« sémantique » du manuscrit | règles Python + `scripts/controles/donnees/sondes.json` | incohérences que les règles formalisent | job `quick` si `spec_check` (`spec/`, `tools/`, `scripts/biblio/`, `scripts/controle*`, `docs/tracking/primitives.md`) ou `full` | contrôles par expressions régulières ; peu d'auto-tests (un auto-test dans `croise`) ; ne remplace pas une relecture | VERIFIED (exécuté : passe, code 0) |
| 7 | `lake build Spec` + audit + `lake exe spec --with-tex` (`verify.yaml:144-151`) | la spécification Verso s'élabore (renvois, citations, énoncés), se rend → rendu | élaborateur Lean + `if-no-files-found: error` | erreur d'élaboration Verso, exception de rendu, sortie vide | job `spec` si `spec_build` ou `full` | le **contenu** rendu n'est pas contrôlé (aucun instantané) | VERIFIED (exécuté : 0 avertissement, 290 HTML + 40 TeX) |
| 8 | Compilation PDF Tectonic (`verify.yaml:184-233`) | le TeX se compile → rendu | code de sortie de Tectonic | erreur LaTeX bloquante | job `spec-pdf` (dépend de `spec`) | journaux non inspectés ; non déterministe (§5.4) ; réseau au runtime | PARTIAL / non exécuté (bundle injoignable) |
| 9 | lychee `--offline '**/*.md'` (`verify.yaml:59-64`) | liens locaux Markdown valides → documentaire | lychee | lien local mort | job `quick` si `docs_links` | **hors ligne** : aucun lien externe contrôlé ; ancres non vérifiées par défaut (**[ESTIMÉ]**, option `--include-fragments` absente) | PARTIAL (non exécuté) |
| 10 | `scripts/ci/test_impact.py` (`ci.yaml:40-41`) | le classifieur d'impact route correctement → logique | `unittest` | régression de routage testée | toujours (job `impact`) | ne teste pas l'enveloppe shell de `ci.yaml` ni chaque entrée de `FULL_EXACT` (§2.3-2.4) | VERIFIED (9/9) |
| 11 | REUSE (`reuse.yaml`) | licences/droits d'auteur conformes → métadonnées | `fsfe/reuse-action` | fichier sans licence | toujours | version de `reuse` de l'action non vérifiée | VERIFIED (localement, reuse 6.2.0, §6) |
| 12 | Conventional Commits (`commitlint.yaml`) | messages de commit conformes → processus | `wagoid/commitlint-github-action` | message non conforme | toujours | ne couvre pas le contenu | N/A (non exécuté) |
| 13 | actionlint + gitleaks (`security.yaml`) | syntaxe des workflows ; absence de secrets | actionlint ; gitleaks | expression/typage de workflow invalide ; secret commité | toujours | actionlint : 0 constat à ma passe locale (§4.3) ; gitleaks non exécuté | VERIFIED (actionlint) / N/A (gitleaks) |
| 14 | `scripts/suivi.py check/all` | vues dérivées de `docs/suivi/` à jour → documentaire | script Python | dérive entre `fiches-statuts.csv` et les vues générées | **absent de la CI** | exécuté par moi dans une copie : aucune différence aujourd'hui (§8 R6) | PARTIAL (hors CI) |
| 15 | `ci-ok` + `verification-result` | agrégat requis par le ruleset (`CI OK`) | résultat des jobs | jobs en échec/annulés | toujours | repose sur la justesse du classifieur pour les `skipped` (§2.5) | VERIFIED (lu) |

**Matrice chemin → validation lancée** (**[EXÉCUTÉ]** `qr/classify_matrix.py`, fonction `classify` réelle, un chemin à la fois ; en plus des jobs toujours actifs `impact`, `reuse`, `commitlint`, `security`) :

| Chemin modifié | Contrôles lancés |
|---|---|
| `src/**`, `tests/**`, `scripts/axiom-audit.sh` | `impl` seul |
| `spec/**` (y compris `spec/CHANGELOG.md`, `spec/figures/**`), `tools/**`, `biblio/**`, `scripts/controle.py`, `scripts/controles/**`, `scripts/manuscript_metrics.py` | `quick` (`controle.py`) + `spec` + `spec-pdf` |
| `docs/suivi/primitives.md` | `quick` (`controle.py` + lychee) |
| tout autre `*.md` (README, CHANGELOG, CONTRIBUTING, `docs/**`, `.claude/**`, modèle de PR) | `quick` (lychee hors ligne seulement) |
| `docs/**` non Markdown (dont `docs/suivi/fiches-statuts.csv`), `.claude/**` non Markdown (dont `.claude/settings.json`), `.github/ISSUE_TEMPLATE/**`, `LICENSES/**`, `CITATION.cff` | **aucun contrôle de `verify`** (seulement REUSE, commitlint, security) |
| `.github/workflows/**`, `.github/dependabot.yml`, `scripts/ci/**`, `lakefile.lean`, `lean-toolchain`, `lake-manifest.json`, `scripts/sync_zenodo.py`, `scripts/requirements-zenodo.txt`, tout chemin inconnu (`scripts/suivi.py`, `scripts/bump-lean.sh`, `.gitleaks.toml`, `REUSE.toml`, `.gitignore`, `zenodo*.json`, `archives/**`, `.github/CODEOWNERS`…) | `full` (tous les jobs) |

Remarque : tout fichier **nouveau** d'un type non prévu est classé « inconnu » → `full`. Le classifieur est donc conservateur : l'erreur possible est la sous-validation d'un chemin explicitement classé léger ou partiel (lignes « aucun contrôle » et « `impl` seul » ci-dessus), non l'oubli d'un chemin nouveau.

## 2. Regex `grep -Eq` de `ci.yaml` et classifieur `impact.py`

### 2.1 Faits observés

**[LU]** `.github/workflows/ci.yaml:56-61` : l'étape `Run CI impact classifier` calcule la liste `changed`, puis :

```sh
if printf '%s\n' "$changed" | grep -Eq '^(.github/workflows/|.github/dependabot\\.yml$|scripts/ci/|lakefile\\.lean$|lean-toolchain$|lake-manifest\\.json$|scripts/sync_zenodo\\.py$|scripts/requirements-zenodo\\.txt$)'; then
  python3 scripts/ci/impact.py --base "$BASE_SHA" --head "$HEAD_SHA" --force-full
else
  python3 scripts/ci/impact.py --base "$BASE_SHA" --head "$HEAD_SHA"
fi
```

Le bloc est un scalaire littéral YAML (`run: |`) : le shell reçoit donc `\\.` tel quel, **entre apostrophes**, et `grep -E` reçoit deux antislashs. En ERE, `\\` est un antislash littéral et `.` est « n'importe quel caractère » : `lakefile\\.lean$` désigne la chaîne `lakefile\<x>lean`, qui ne peut pas être un chemin du dépôt.

**[EXÉCUTÉ]** `python3 qr/regex_test.py .github/workflows/ci.yaml` (extrait la regex du fichier avec PyYAML puis lance `grep -Eq` dessus ; script conservé dans le scratchpad) :

```
REGEX: ^(.github/workflows/|.github/dependabot\\.yml$|scripts/ci/|lakefile\\.lean$|lean-toolchain$|lake-manifest\\.json$|scripts/sync_zenodo\\.py$|scripts/requirements-zenodo\\.txt$)
MATCH    '.github/workflows/ci.yaml'
MATCH    'scripts/ci/impact.py'
MATCH    'lean-toolchain'
no-match '.github/dependabot.yml'
no-match 'lakefile.lean'
no-match 'lake-manifest.json'
no-match 'scripts/sync_zenodo.py'
no-match 'scripts/requirements-zenodo.txt'
MATCH    'lakefile\.lean'          (chaîne avec antislash littéral : ne peut pas exister comme chemin réel)
```

**Constat confirmé** : cinq des huit alternatives ne peuvent jamais correspondre à un vrai chemin (`.github/dependabot.yml`, `lakefile.lean`, `lake-manifest.json`, `scripts/sync_zenodo.py`, `scripts/requirements-zenodo.txt`). Les trois autres (`.github/workflows/`, `scripts/ci/`, `lean-toolchain$`) fonctionnent. Défaut secondaire : dans `.github/workflows/` et `.github/dependabot` le `.` non échappé accepte n'importe quel caractère (faux positifs théoriques sans conséquence : le résultat est « plus de validation »).

### 2.2 Compensation par `impact.py`

**[LU]** `scripts/ci/impact.py:14-22` : `FULL_EXACT` contient exactement les six chemins exacts (`.github/dependabot.yml`, `lakefile.lean`, `lean-toolchain`, `lake-manifest.json`, `scripts/sync_zenodo.py`, `scripts/requirements-zenodo.txt`) et `FULL_PREFIXES = (".github/workflows/", "scripts/ci/")` : l'ensemble est identique à celui de la regex shell. De plus (`impact.py:78-82`) tout chemin non classé (`unknown`) force `full`.

**[EXÉCUTÉ]** simulation de bout en bout : j'extrais le bloc `run` réel de l'étape `impact` (PyYAML), je le lance avec `EVENT_NAME=pull_request` et le **vrai** `impact.py` dans un dépôt git jetable où un seul chemin est modifié à la fois (`qr/sim_impact.sh`). Sortie (colonne 1 : la branche `grep` du shell a-t-elle été prise ?) :

```
grep-branch=no  | lakefile.lean                   | full=true  lean_build=true spec_build=true unclassified=false
grep-branch=no  | lake-manifest.json              | full=true  lean_build=true spec_build=true unclassified=false
grep-branch=yes | lean-toolchain                  | full=true  ...
grep-branch=no  | .github/dependabot.yml          | full=true  ...
grep-branch=no  | scripts/sync_zenodo.py          | full=true  ...
grep-branch=no  | scripts/requirements-zenodo.txt | full=true  ...
grep-branch=yes | .github/workflows/ci.yaml       | full=true  ...
grep-branch=no  | scripts/axiom-audit.sh          | full=false lean_build=true spec_build=false
grep-branch=no  | src/K7pl/X.lean                 | full=false lean_build=true spec_build=false
grep-branch=no  | docs/x.md                       | full=false docs_links=true lean_build=false
grep-branch=no  | spec/Spec/C1.lean               | full=false spec_check=true spec_build=true lean_build=false
grep-branch=no  | scripts/suivi.py                | full=true  unclassified=true
grep-branch=no  | scripts/claude-session-start.sh | full=true  unclassified=true
grep-branch=no  | .gitleaks.toml / REUSE.toml / .commitlintrc.yaml / zenodo.json / .github/CODEOWNERS | full=true unclassified=true
```

(La ligne `scripts/ci/impact.py` de ma simulation n'est pas exploitable : mon script y ajoute une ligne de texte qui rend le fichier invalide en Python ; c'est un artefact de ma simulation. Ce chemin figure dans `FULL_PREFIXES` et dans la regex.)

**[EXÉCUTÉ]** chemins à noms inhabituels (`qr/sim_odd.sh`) : git cite ces noms dans `--name-only` (`"src/\303\251.lean"`, `"spec/Spec/tab\tname.lean"`) ; `impact.py` les classe `unknown` et force `full=true`. Le comportement est **sûr par défaut**.

### 2.3 Conclusion sur ce point

- **Confirmé par ma propre exécution** : aujourd'hui, l'erreur d'échappement de la regex shell est **sans effet** sur la validation réelle. Les cinq chemins en cause déclenchent `full=true` via `impact.py` (`FULL_EXACT`), et même sans `FULL_EXACT` ils tomberaient dans `unknown` → `full`.
- **Interprétation** : la regex shell est entièrement **redondante** avec `impact.py` (même ensemble de chemins ; `impact.py` est de toute façon sûr par défaut). Elle duplique la source de vérité sans rien ajouter. Le seul effet de la branche `--force-full` est de court-circuiter le calcul de chemins : en mode `--force-full`, `impact.py` n'affiche plus la liste des chemins modifiés (`impact.py:117-118`, `paths = []`), ce qui appauvrit le journal.
- **Défaut latent distinct (reproduit)** : sous `set -o pipefail`, `printf '%s\n' "$changed" | grep -Eq …` peut rendre un faux négatif si la liste dépasse la taille du tube (SIGPIPE de `printf` quand `grep -q` a déjà quitté). **[EXÉCUTÉ]** `qr/pipefail.sh` : 1 000 chemins → correspondance trouvée ; 20 000 et 100 000 chemins → « NOT matched », alors que `.github/workflows/ci.yaml` est la première ligne. Sans conséquence aujourd'hui (même compensation par `impact.py`), et irréaliste pour un diff normal (le seuil est de l'ordre de 64 Kio de noms de fichiers), mais cela confirme que ce `grep` est un point de fragilité sans valeur ajoutée.
- **Recommandation (vague 2, `ci.yaml`)** : supprimer la regex shell et ne garder que `impact.py` comme source unique ; ou, au minimum, corriger `\\.` en `\.` (déplacement simple, mais ne résout pas le doublon). Dans les deux cas, ajouter à `test_impact.py` un test paramétré sur chaque entrée de `FULL_EXACT` et chaque préfixe de `FULL_PREFIXES` (les tests actuels ne couvrent que `.github/workflows/ci.yaml`, `test_impact.py:43-47`).

### 2.4 Tests unitaires du classifieur

**[EXÉCUTÉ]** `python3 scripts/ci/test_impact.py` → `Ran 9 tests in 0.000s — OK`. Ce que ces tests détectent : une régression de la logique pour `docs/*.md`, `.claude/*.md`, `src/`, `spec/`, `docs/suivi/primitives.md`, un chemin de workflow, un chemin inconnu, un mélange de surfaces, `--force-full`. Ce qu'ils ne détectent pas : la suppression d'un chemin de `FULL_EXACT` (il retomberait dans `unknown` → `full`, donc le test passerait quand même), l'enveloppe shell de `ci.yaml`, et la sémantique de `git diff` (base/head).

### 2.5 `ci-ok` et `verification-result`

**[LU]** `ci.yaml:87-116` (`ci-ok`, `if: always()`) exige `result == success` **strictement** pour `impact`, `verify`, `reuse`, `commitlint`, `security` : un `skipped` ou un `cancelled` fait échouer. **[LU]** `verify.yaml:235-256` (`verification-result`, `if: always()`) accepte `success` et `skipped` pour `quick`, `impl`, `spec`, `spec-pdf`, et rejette tout le reste (`failure`, `cancelled`).

**[EXÉCUTÉ]** `gh api repos/AntheaLiles/k7pl/rules/branches/main` (lecture publique) : la seule vérification requise du ruleset est `{"context": "CI OK", "integration_id": 15368}`, `strict_required_status_checks_policy: false`.

**Interprétation (cohérence).** Les deux traitements ne se contredisent pas : `skipped` n'est accepté qu'à l'intérieur de `verify.yaml`, là où les sauts sont voulus (`if: inputs.…` ; `spec-pdf` dépend de `spec`). Au niveau de `ci-ok`, les cinq jobs appelés s'exécutent toujours, donc `success` strict y est le bon test. Une défaillance de `spec` rend `verify` en échec (et `spec-pdf` sauté, mais `verification-result` voit `spec=failure`). `verification-result` est redondant avec le résultat agrégé du job appelant `verify` (un job appelé en échec rend le job appelant en échec) ; sa seule valeur est d'exister comme agrégateur nommé. **Faiblesse réelle** : la seule garantie contre un `skipped` indu est la justesse du classifieur (`impl` sauté parce que `lean_build=false` alors qu'un changement Lean n'a pas été reconnu comme tel). Filet : la CI quotidienne `full.yaml` (cron `17 3 * * *`, `full: true`), non bloquante et postérieure à la fusion.

**Cas limite relevé (§2.2)** : `scripts/axiom-audit.sh` est classé `LEAN_EXACT` (`impact.py:23`) alors que `verify.yaml:148` l'appelle aussi dans le job `spec` (`scripts/axiom-audit.sh Spec Spec`). Une modification de ce script ne lance que le job `impl` (`lean_build`), pas `spec` : une régression propre à l'appel `Spec Spec` ne serait vue qu'au prochain passage `full`. Écart **opportuniste**.

## 3. Contenu réel de `src/` et `tests/`, fuzzing, warnings, axiomes

### 3.1 Cartographie exacte

**[LU]** (211 lignes en tout, `wc -l` sur `src/**/*.lean tests/*.lean` : 12 + 56 + 50 + 16 pour `src/`, 25 + 22 + 30 pour `tests/`).

| Module | Contenu | Propriété établie |
|---|---|---|
| `src/K7pl.lean` | racine ; importe `K7pl.Arith` et `K7pl.Semantics` | — |
| `src/K7pl/Arith.lean` | `inductive Expr` (3 constructeurs : `lit`, `add`, `mul`), `def Expr.eval`, `def double`, `theorem eval_double` | **prouvée** : `(double e).eval = 2 * e.eval` (`simp only` puis `ring`) ; docstring : « A toy expression language […] reference example of a Mathlib-based development » |
| `src/K7pl/Semantics.lean` | `inductive Action` (`incr`, `reset`), `def step`, `def counter : LTS Nat Action`, `theorem counter_incr_twice` | **prouvée** : deux `incr` mènent de `n` à `n + 2` (`LTS.MTr.stepL`, `rfl`) ; « reference example of a CSLib-based development » |
| `src/Main.lean` | `def Main.hello : String := "Hello, world!"` | smoke test |

Total : **9 déclarations de premier niveau** (2 types inductifs, 5 définitions, 2 théorèmes ; décompte manuel : Arith 4, Semantics 4, Main 1). **Il n'existe dans `src/` ni lexer, ni parser, ni AST du langage k7pl, ni sérialisation, ni invariant sémantique du langage k7pl.** `Expr` et `Action` sont des exemples jouets du gabarit de projet, pas la syntaxe de k7pl. [Observation de frontière : cela signifie aussi que *toute* correspondance « spec ↔ Lean » est aujourd'hui vide ; ce n'est pas un défaut de qualité du dépôt, c'est l'état d'avancement. Voir §10.]

### 3.2 Ce que testent les tests

**[LU]** `tests/ArithTest.lean` : `sample = 2 + 3*4`, deux `#guard` (14 et 28), un `example` qui instancie `eval_double`, et une liste `tests` de 2 booléens. `tests/SemanticsTest.lean` : deux `#guard` (`step 3 .incr = 4`, `step 3 .reset = 0`), un `example` qui instancie `counter_incr_twice`, 2 booléens. `tests/MainTest.lean` : `testHello` + concaténation des listes ; `main` imprime `ok:`/`FAIL:` et renvoie `0` ou `1`.

Total : 5 contrôles d'exécution (`lake test`), 4 `#guard` (échec **à la compilation** : `lake build K7plTests`), 2 `example`.

**Interprétation.**

- Les `#guard` échouent bien à la compilation si `eval`/`step` sont cassés : le test peut échouer (critère de `.claude/rules/lean.md`, section Tests). Mais les mêmes assertions existent en double, une fois en `#guard` (interprète, compilation) et une fois dans `tests` (code compilé, exécution) ; `lake test` n'ajoute donc que : la compilation et le lien de l'exécutable `mainTest`, l'exécution du code compilé (pas l'interprète) et `Main.hello`.
- La ligne `("eval double", (double sample).eval == 2 * sample.eval)` instancie un théorème **déjà prouvé** (`eval_double`) : elle ne peut échouer que si la preuve était fausse, ce qui est impossible dans le noyau. Elle est **décorative** comme contrôle de la propriété ; elle ne vaut que comme smoke test d'exécution. C'est la preuve qui porte la propriété, pas le test.
- Niveau : typage/sémantique de deux mini-développements. Aucun contrôle ne porte sur la syntaxe de k7pl (inexistante).
- **[LU]** `lake build K7pl K7plTests` ne construit pas `MainTest` (racine de l'exécutable, pas de la bibliothèque `K7plTests` : `lakefile.lean`, `roots := #[`ArithTest, `SemanticsTest]`). Il est construit uniquement par `lake test`.

### 3.3 Fuzzing et tests par propriétés

**Verdict : FUTURE / non pertinent aujourd'hui.**

- **Surface d'entrée non fiable : aucune dans `src/`.** Pas de lexer/parser, pas de lecture de fichier ni d'entrée utilisateur dans `src/` ; `Main.hello` est une constante. Un fuzzer lancé aujourd'hui n'exercerait que `Expr.eval` sur des arbres générés — c'est précisément ce que `eval_double` et les `#guard` couvrent, avec une preuve en plus. Ce serait un fuzzer décoratif (interdit par la définition de l'agent).
- **Autres surfaces du dépôt** (hors `src/`) : `lake exe spec` lit `spec/` (sources de confiance, écrites par le mainteneur et relues en PR) ; `scripts/controles/*.py` parsent le Verso par expressions régulières ; `scripts/org2verso/` (parseur Org, conversion historique à usage unique) ; `scripts/ci/impact.py` consomme des noms de fichiers git (j'ai montré au §2.2 qu'il est sûr par défaut pour les noms inhabituels). Aucune n'est une surface d'attaque réaliste qui justifie un fuzzer ; un test de propriété sur `impact.py` serait de peu de valeur comparé à un test paramétré sur `FULL_EXACT` (§2.3).
- **Quand cela deviendra pertinent** (déclencheurs identifiables) :
  1. dès qu'apparaît dans `src/K7pl/` une fonction `String → Except Erreur Ast` (lexer/parser concret) : propriétés *totalité sur entrée arbitraire* (pas de `panic!`, pas de non-terminaison pour un `partial def`), *rejet propre* des entrées mal formées ;
  2. dès qu'existe un `print`/sérialisation : *aller-retour* `parse (print a) = a`, idempotence de la normalisation ;
  3. dès qu'existe un évaluateur « de référence » (celui de la spécification) et un évaluateur optimisé ou compilé : test différentiel ;
  4. dès que l'implémentation lit un fichier ou argument utilisateur (CLI).
  Dans les cas 1 à 3, une preuve Lean est préférable quand l'énoncé est stabilisé ; le test par propriétés sert pour les énoncés pas encore prouvés et pour détecter la dérive entre code exécutable et énoncé.
- **Outillage disponible sans nouvelle dépendance** : `plausible` figure dans `lake-manifest.json` (`inherited: true`, dépendance transitive de Mathlib, rev `118aa17ee846…`). **[ESTIMÉ]** qu'il est importable depuis `tests/` sans modifier `lakefile.lean` ; à vérifier au moment de l'usage (je n'ai pas exécuté Mathlib).

### 3.4 « Tout avertissement fait échouer la compilation » : couverture réelle (testée)

**[LU]** `lakefile.lean` : `warningAsError true` est posé via `leanOptions` sur `K7pl` (`k7plBaseOptions ++ k7plLinters`), `K7plTests` (`k7plBaseOptions`), `SpecBib`, `SpecExt`, `Spec` (`k7plSpecOptions`). **Ni `lean_exe mainTest` (racine `tests/MainTest.lean`) ni `lean_exe spec` (racine `tools/SpecMain.lean`) ne définissent `leanOptions`.**

**[EXÉCUTÉ]** mini-projet jetable `qr/mini` reproduisant ce schéma d'options (Lean 4.34.0, Lake 5.0.0, sans Mathlib ; `qr/mini_run.sh`, `qr/mini_exe_opts.sh`) :

| Cas | Résultat observé |
|---|---|
| Variable inutilisée dans une `lean_lib` avec `warningAsError` | **échec** du build (`Some required targets logged failures: - Ctl`, `exit=1`) |
| Même code dans la racine d'une `lean_exe` **sans** `leanOptions` (comme `mainTest`) | **succès** : `⚠ Built MainTest`, avertissement affiché, `Build completed successfully`, `exit=0` ; `lake test` renvoie `0` |
| Même code, `lean_exe` **avec** `leanOptions := miniOptions` | **échec** (`- MainTest`, `exit=1`) : l'option s'applique bien à la racine d'un exécutable |

**Constat** : dans k7pl, `MainTest.lean` (30 lignes) et `SpecMain.lean` (20 lignes) ne sont pas couverts par la règle « tout avertissement est une erreur » (en particulier un `declaration uses 'sorry'` y serait seulement un avertissement). **Transposition à k7pl : [ESTIMÉ à partir du mini-projet]** ; je n'ai pas compilé ces deux fichiers dans le dépôt. Gravité faible (deux petits fichiers sans théorème), mais cela contredit la formulation de la règle du dépôt. Correction candidate (vague 2, **`lakefile.lean`** : à signaler explicitement en PR d'après `.claude/rules/lean.md`) : ajouter `leanOptions := k7plBaseOptions` (ou `k7plSpecOptions` pour `spec`) aux deux `lean_exe`. À valider par la CI (risque : un avertissement latent dans `SpecMain.lean` ferait alors échouer le build ; il n'en existe pas à ma connaissance puisque ma compilation de `Spec` n'a pas touché `SpecMain`, voir §5.6 où l'exécutable est réellement construit).

### 3.5 Audit d'axiomes : ce qu'il voit et ce qu'il ne voit pas (testé)

**[LU]** `scripts/axiom-audit.sh` : construit les cibles demandées, clone `leanprover-community/axiom-audit` épinglé par tag `v0.1.2` **et** vérifie le SHA `46024e00…` (`axiom-audit.sh:17-30`), puis `axiom-audit --allow propext,Classical.choice,Quot.sound --root <ROOT>`. **[LU]** CI : `verify.yaml:116` → `scripts/axiom-audit.sh K7pl K7pl` ; `verify.yaml:148` → `scripts/axiom-audit.sh Spec Spec`.

**[EXÉCUTÉ]** le **vrai** script, sur le mini-projet (`qr/mini_run.sh`, étapes 5 et 6) où le module de test `ATest` (bibliothèque `MiniTests`) contient `theorem uses_native : 2 + 2 = 4 := by native_decide` :

```
$ scripts/axiom-audit.sh Mini Mini        # = ce que la CI fait pour K7pl K7pl
axiom-audit: audited 1 declaration(s) under 'Mini'; all within the allowlist [...]      exit=0
$ scripts/axiom-audit.sh ATest MiniTests  # = auditer la bibliothèque de tests
axiom-audit: 2 declaration(s) under 'ATest' use disallowed axioms:
  ATest.uses_native._native.native_decide.ax_1_1 → [...]
  ATest.uses_native → [ATest.uses_native._native.native_decide.ax_1_1]            exit=1
```

Et `lake build Mini MiniTests` réussit sans aucun avertissement avec ce `native_decide`.

**Constats.**

1. L'audit **détecte** bien `native_decide` (axiome auxiliaire `…_native.native_decide.ax_…`), `sorry` (`sorryAx`) et tout nouvel `axiom`, là où il est lancé : l'invariant « ni `sorry`, ni `axiom`, ni `native_decide` » est outillé pour `K7pl.*` et `Spec.*`.
2. **Il n'est pas lancé sur `K7plTests`** (ni sur `tests/MainTest.lean`, ni sur `SpecExt`, `SpecBib`, `tools/SpecMain.lean`). Un `native_decide` ou un `axiom` ajouté dans `tests/` passerait la compilation (aucun avertissement), `lake test`, `lake lint` (dont l'argument est `K7pl`, `lakefile.lean` `lintDriverArgs`) **et** l'audit d'axiomes. Le seul garde-fou serait la relecture humaine. **Écart important** pour l'invariant « jamais de `native_decide` » : couverture partielle du dépôt par le contrôle automatique. **[ESTIMÉ]** pour `SpecExt`/`SpecBib` (le préfixe `Spec` de `--root Spec` ne couvre vraisemblablement pas `SpecExt`) ; testé en §5.6 sur le dépôt réel.
3. Correction candidate (vague 2, `verify.yaml` + `scripts/`) : ajouter `scripts/axiom-audit.sh K7plTests K7plTests` (et `SpecExt`) ; ou un `grep -rnE '\b(native_decide|sorry|admit|axiom)\b' src tests tools spec` borné, comme filet syntaxique **complémentaire** (pas un substitut à l'audit sur environnement, qui voit les axiomes transitifs). Chaque ajout est à évaluer avec ses faux positifs (le mot `axiom` apparaît dans la spécification en français).

## 4. Analyse statique (SAST) : ce qui est approprié

### 4.1 Lean (`src/`, `tests/`, `tools/`, `spec/`)

**Interprétation / [ESTIMÉ]** : à ma connaissance, aucun outil SAST généraliste (CodeQL, Semgrep, SonarQube) ne supporte Lean 4 ; je n'ai pas pu le vérifier hors ligne et je ne l'affirme pas comme fait établi. Dans un projet Lean, l'« analyse statique » pertinente est celle déjà en place : noyau (preuves), `warningAsError`, linters (`lake lint` = `batteries/runLinter K7pl`, jeu standard Mathlib via `weak.linter.mathlibStandardSet`) et audit d'axiomes. Les lacunes réelles sont des **trous de couverture de ces contrôles** (§3.4 et §3.5), pas l'absence d'un scanner générique. **Aucun outil à ajouter pour Lean.**

### 4.2 Python (`scripts/`, environ 1 700 lignes hors `archives/`)

**[EXÉCUTÉ]** `bandit 1.9.4 -r scripts` : 12 constats, tous de sévérité **LOW** et confiance haute, 0 medium, 0 high (B101 `assert` ×4, B404 import de `subprocess` ×3, B603 `subprocess` sans shell ×3, B607 chemin partiel ×2), dans `scripts/ci/impact.py`, `scripts/org2md.py`, `scripts/org2verso/*`. Lecture : `impact.py` lance `git diff` avec une liste d'arguments, sans shell, `--base/--head` provenant de l'événement GitHub (SHA) ; `org2*` sont des convertisseurs historiques. Aucun constat n'est exploitable en l'état.

**[EXÉCUTÉ]** `ruff 0.16.10 check scripts` (jeu de règles par défaut, **sans configuration du dépôt**, aucun `pyproject.toml`/`ruff.toml` dans le dépôt) : 125 constats de style/modernisation (ex. `DTZ011 date.today()` dans `sync_zenodo.py:80`). Ce n'est pas de la sécurité : bruit à ne pas adopter tel quel.

**Valeur réelle** : faible. Les scripts qui touchent des secrets ou le réseau sont `sync_zenodo.py` (token Zenodo, dépendances épinglées par hachage dans la CI) et `bump-lean.yaml` : leur risque est dans le **workflow** (permissions, injection de contexte), pas dans l'analyse du Python.

### 4.3 Workflows YAML

**[EXÉCUTÉ]** `actionlint 1.7.12` sur les 9 workflows (`.github/workflows/*.yaml`) : aucun constat, code 0. (La CI exécute `raven-actions/actionlint` épinglé par SHA, `security.yaml:22-23` ; la version d'actionlint qu'il embarque n'a pas été vérifiée.)

**[EXÉCUTÉ]** `zizmor 1.30.1 --offline` (persona `regular`) : 8 constats, 0 medium, 0 high.

| Règle | Gravité / confiance | Où | Lecture |
|---|---|---|---|
| `self-repository` ×7 | Low / High | `ci.yaml:64,76,80,84`, `full.yaml:20`, `release.yaml:20,53` | style : `uses: ./.github/workflows/x.yaml` → suggestion `$/…`. **Je n'ai pas pu vérifier que cette syntaxe est acceptée par GitHub Actions** (docs.zizmor.sh injoignable depuis la session). **Ne pas appliquer la correction automatique sans preuve.** |
| `template-injection` ×1 | Informational / Low | `bump-lean.yaml:44` (`scripts/bump-lean.sh --no-update "${{ steps.version.outputs.latest }}"`) | la valeur vient de `scripts/latest-lean-version.sh` et `bump-lean.sh:21-24` la contraint à `^v[0-9]+\.[0-9]+\.[0-9]+$` ; risque résiduel faible mais le motif idiomatique est de passer par une variable d'environnement |

Limites : le mode hors ligne n'exécute pas les audits qui interrogent l'API GitHub (commits « imposteurs », actions vulnérables connues, références obsolètes). Ils relèvent des agents `supply-chain-release-specialist` et `github-governance-specialist` ; je ne les ai pas contournés.

**Interprétation.** zizmor est l'outil **spécialisé** adapté au YAML de workflows de ce dépôt (workflows avec écriture, secrets, `id-token: write` : `release.yaml`, `bump-lean.yaml`) et complète actionlint (syntaxe/typage des expressions) sans le remplacer. Coût de maintenance : faible s'il est épinglé par SHA et non bloquant au départ ; il faudra trier les 8 constats ci-dessus. **Décision à prendre par l'orchestrateur avec le domaine supply-chain** (recouvrement) ; je ne l'impose pas.

### 4.4 CodeQL et Scorecard

La définition de l'agent interdit d'installer CodeQL « pour que Scorecard détecte du SAST ». Constat : CodeQL ne couvrirait ni Lean (voir 4.1, ESTIMÉ), ni de manière utile un Python de 1 700 lignes sans entrée non fiable ; pour les workflows, zizmor est plus ciblé (ESTIMÉ). **Pas de CodeQL pour le score.** Le score Scorecard « SAST » restera donc bas par construction ; c'est un **fait à documenter honnêtement**, pas à corriger par un outil décoratif. (Le score réel n'est pas lisible depuis cette session : `api.securityscorecards.dev` refusé.)

## 5. Reproductibilité des artefacts

**Principe retenu** (`.claude/rules/verification.md`, section Reproductibilité) : un artefact n'est reproductible que si plusieurs exécutions indépendantes produisent un résultat conforme à un critère défini ; l'épinglage des dépendances n'est pas une démonstration. **Verdict global : PARTIAL.** Une partie de la chaîne (Lean → HTML/TeX) a été démontrée identique sur deux builds propres ; l'étape finale (TeX → PDF, l'artefact réellement publié) n'a **pas** pu être exécutée et présente des sources de non-déterminisme identifiées par lecture.

### 5.1 Artefacts publiés et chaîne de production

**[LU]** `verify.yaml` (jobs `spec` puis `spec-pdf`) et `release.yaml` :

```
sources (git, lake-manifest.json) ──lake build Spec──▶ .olean/.ilean/.c
   ──lake exe spec --output _out/spec --with-tex──▶ _out/spec/html-multi  (artefact spec-html, 14 j)
                                                  └▶ _out/spec/tex        (artefact spec-tex, 14 j)
   spec-tex ──tectonic -X compile --keep-logs main.tex──▶ k7pl-spec.pdf   (artefact spec-pdf, 90 j)
   release spec-v* : sha256sum + actions/attest (provenance) + gh release upload + Zenodo
```

Aucune étape du dépôt ne recompile deux fois ni ne compare deux hachages : le dépôt n'affirme pas de **build** reproductible (**[EXÉCUTÉ]** `grep -i "reproducib|reproductib|déterministe|deterministic"` sur `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CHANGELOG.md`, `.github/`, `docs/README.md` : une seule occurrence, `CHANGELOG.md:31`, « Conversion Org → Verso reproductible (`scripts/org2verso/`) »). Cette phrase vise le convertisseur historique Org → Verso, pas le build de la spécification ; aucun contrôle de CI ne l'étaye (et `spec/` s'édite désormais directement : les fichiers générés l'indiquent en tête) ; je ne l'ai pas testée. Les occurrences de « compilation reproductible » dans `docs/tracking/DASHBOARD.md` et `docs/suivi/registre-obligations.md` sont des **exigences sur le futur langage** (spécification), sans rapport avec la reproductibilité du build du dépôt. La **provenance** attestée (`actions/attest`, `release.yaml:109`) dit *où et comment* le PDF a été construit ; elle ne dit pas qu'une seconde construction redonnerait les mêmes octets.

### 5.2 Expérience exécutée : Lean → HTML/TeX (« build A / build B »)

**Entrées.** Dépôt à `b5f6146` (fichiers suivis seulement, sans `.git`), copié dans deux répertoires distincts `qr/A` et `qr/B` ; `.lake/packages` repris de checkouts laissés dans le scratchpad par le prédécesseur (une pièce [PISTE]), puis **vérifiés par moi** : pour chacun des 14 paquets, `git rev-parse HEAD` = `rev` de `lake-manifest.json`, `origin` = `url`, arbre propre, `git clean -xfd` (aucun artefact de build résiduel) (`qr/prepare.sh`, sortie `OK` pour les 14). Toolchain : `lean-4.34.0-linux.tar.zst` téléchargé depuis les assets GitHub de `leanprover/lean4`, SHA-256 de l'archive `caaa98356098c85dc0fcbbd28e1ec66f39eb6551829972b752ff20e1286b646b` (calculé par moi ; **non comparé à un condensat publié indépendant** : l'API GitHub de ce dépôt n'est pas accessible depuis la session) ; `lean --version` → `Lean (version 4.34.0, x86_64-unknown-linux-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)` ; `lake --version` → `5.0.0-src+293d5d0`.

**Procédure** (`qr/build_and_render.sh`, lancée simultanément pour A et B sur la même machine, 4 cœurs, sans cache) : `lake build Spec` (668 jobs, 634 s pour chacun) ; puis `lake exe spec --output _out/<tag> --with-tex` trois fois : `r1` ; `r2` (5 s plus tard) ; `r3` avec un environnement perturbé (`TZ=Pacific/Kiritimati LC_ALL=C.UTF-8 LANG=C.UTF-8 SOURCE_DATE_EPOCH=0`). Pour chaque rendu, SHA-256 de chaque fichier (liste triée en `LC_ALL=C`) ; de même pour tous les `.olean`, `.ilean`, `.c` du projet.

**Résultats observés (comparaison fichier par fichier avec `cmp` des listes de condensats, pas seulement un préfixe).**

| Objet | Fichiers | A = B ? | r1 = r2 = r3 (dans A, dans B) ? |
|---|---|---|---|
| Rendu HTML `html-multi` | 290 | oui | oui (condensat de la liste : `806739e663a89683…`) |
| Rendu TeX `tex` (`main.tex` + `figures/`) | 40 | oui | oui (`7e47c3708a7c0deb…`) |
| `.olean` du projet (Spec, SpecExt, SpecBib) | 78 | oui | — |
| `.ilean` du projet | 78 | oui | — |
| `.c` générés du projet | 78 | oui | — |
| `.olean`/`.ilean`/`.c` des dépendances compilées depuis les sources (MD4Lean, illuminate, subverso, verso) | 654 | oui | — |

Condensats complets des listes (SHA-256 du fichier de liste, identiques pour A et B) : HTML `806739e663a89683cd744ff9d29c661866d9ed371f093a57ae5c6123994271e0`, TeX `7e47c3708a7c0deb855bf933c953ca0df4a2829ddd0091b4a2820b7f5cb3b4fa`. SHA-256 de `main.tex` dans r1 (A et B) : voir la ligne `./main.tex` de `qr/hashes-A/r1-tex.txt` (`91c1e9b3ee288a79864b243faf7f74fe16037cd29cebb46ef9a52cfbea43e515`).

**Contrôle négatif** (la comparaison peut échouer) : dans la copie B uniquement, un mot ajouté dans `spec/Spec/C7.lean` (« est fondée » → « est bien fondée »), reconstruction incrémentale (6 s), nouveau rendu `r4` : `main.tex` change (`91c1e9b3…` → `5ff1efcf…`, 1 fichier TeX sur 40), 98 fichiers HTML changent (index de recherche), 1 `.olean` et 1 `.c` changent. La comparaison détecte donc bien une différence d'entrée d'un seul mot. (La modification n'a eu lieu que dans la copie jetable, jamais dans le dépôt.)

Autres observations : aucune occurrence de chemin absolu du build ni de date dans les sorties (`grep` sur `/tmp/claude`, `/home/user`, motifs de date : seul `katex.js` correspond à un motif numérique sans rapport) ; aucun avertissement dans le journal du build (`grep -ci warning` → 0) ; `tools/SpecExt*` ne contient aucun appel à l'horloge, à l'environnement ni à l'aléa (`grep` sur `monoMsNow|getRandom|getEnv|Time|SOURCE_DATE` : aucune occurrence dans `tools/`) ; `main.tex` contient `\date{\sffamily }`, c'est-à-dire **aucune date dans la source TeX**.

### 5.3 Ce que cette expérience prouve, et ne prouve pas

**Prouve (observé, N = 2 builds propres × 3 rendus) :** dans cet environnement (même machine, même toolchain 4.34.0, mêmes 14 paquets aux révisions du manifeste), la génération `lake build Spec` → `lake exe spec --with-tex` donne des octets identiques pour le HTML, le TeX et les `.olean/.ilean/.c`, indépendamment du répertoire de build, de quelques secondes d'écart, de `TZ`, de la locale et de `SOURCE_DATE_EPOCH`. Rien dans le code de `tools/` ne dépend de l'horloge ou de l'environnement.

**Ne prouve pas :**

- la reproductibilité **entre machines/images** (autre CPU, autre OS, autre date de calendrier, autre version du compilateur C embarqué) : A et B sont sur la même machine au même instant ;
- celle des objets natifs (`.o`, bibliothèques dynamiques, exécutable `spec`) : non hachés ;
- celle de la **toolchain** elle-même et de son provenance : l'archive n'a pas été comparée à un condensat publié indépendamment ;
- celle du **PDF** (étape suivante) : voir ci-dessous ;
- l'exactitude du contenu (un rendu reproductible peut être faux) ;
- le build de `K7pl`/`K7plTests` (Mathlib non construit ici).

### 5.4 Étape TeX → PDF (Tectonic 0.15.0) : non exécutée, sources de non-déterminisme identifiées

**[EXÉCUTÉ]** Vérification de l'outil : l'archive `tectonic-0.15.0-x86_64-unknown-linux-musl.tar.gz` a pour SHA-256 `dfb82876f2986862996e564fa507a9e576e0c1e3bee63c2c1bd677c2543e6407`, identique à `TECTONIC_SHA256` (`verify.yaml:192`) ; le binaire extrait répond `Tectonic 0.15.0`. **[EXÉCUTÉ]** `tectonic -X compile main.tex` sur un document minimal : `note: connecting to https://relay.fullyjustified.net/default_bundle_v33.tar` puis `error: … unsuccessful tunnel` (le proxy de la session refuse l'hôte). **Aucune compilation TeX n'a donc été possible ici, et je ne rapporte aucun condensat de PDF.** Aucune distribution TeX locale n'existe (`which xelatex pdflatex tex kpsewhich` → rien).

Sources de non-déterminisme de cette étape (toutes **[LU]**, code amont de Tectonic `tectonic@0.15.0`, `src/driver.rs` et `src/bin/tectonic/compile.rs`, récupérés en lecture seule ; effets sur les octets du PDF **[ESTIMÉ]**, non mesurés) :

1. **Date de construction.** `build_date_from_env` (`driver.rs:992-1007`) : si `SOURCE_DATE_EPOCH` est définie elle est utilisée ; sinon, hors mode déterministe, `SystemTime::now()`. `verify.yaml:222-225` ne définit pas `SOURCE_DATE_EPOCH` et ne passe pas `-Z deterministic-mode`. La date est transmise au moteur TeX (`driver.rs:1873` et `1966`) : les métadonnées de date du PDF et l'identifiant de fichier dépendent donc très probablement de l'heure de la CI → **deux builds consécutifs du même TeX ne donneront en général pas le même PDF**.
2. **Mode déterministe non activé** (`-Z deterministic-mode`) : dans ce mode Tectonic masque les chemins absolus et force la date de modification (`driver.rs:1855-1866`) ; absent ici.
3. **Fichiers de support TeX téléchargés au runtime** depuis `relay.fullyjustified.net` (bundle `default_bundle_v33.tar`, comportement observé ci-dessus). Les paquets requis par `main.tex` (memoir, sourcecodepro, sourcesanspro, sourceserifpro, tcolorbox, hyperref, unicode-math, etc., d'après les `\usepackage` de `main.tex` observé) viennent de là. Le cache de Tectonic valide les données par rapport à un condensat **fourni par le même serveur** (`SHA256SUM`, `crates/bundles/src/cache.rs`) : aucune valeur attendue n'est épinglée dans le dépôt. Le job dépend donc du réseau, de la disponibilité de l'hôte et de la confiance dans celui-ci ; l'immuabilité du contenu de `v33` n'est pas vérifiée.
4. **Cache d'état** `actions/cache` sur `~/.cache/Tectonic` avec `restore-keys` par préfixe (`verify.yaml:212-218`, clé constante `…-v1`) : l'état de départ du build dépend de l'historique des exécutions.
5. **Aucune inspection du journal** : `--keep-logs` conserve les journaux sur le runner mais ils ne sont ni téléversés ni analysés ; un code de sortie 0 n'exclut pas des références non résolues ou des glyphes manquants (comportement TeX habituel pour des avertissements, **[ESTIMÉ]** pour Tectonic).
6. Le PDF est **construit dans le run de release** (job `spec-verify` → artefact `spec-pdf` → `publish-spec`) : le PDF publié n'est pas celui d'un run antérieur de CI sur le même commit ; aucun contrôle ne compare les deux.

### 5.5 Autres sources de non-déterminisme du chemin de build

| Source | Étape | Statut observé |
|---|---|---|
| Version de Lean (`lean-toolchain`) | tout | épinglée par chaîne de version (`leanprover/lean4:v4.34.0`) ; installée par elan via `lean-action` épinglé par SHA ; vérification d'intégrité d'elan non auditée ici |
| Paquets Lake | tout | épinglés par SHA de commit dans `lake-manifest.json` (adressage par contenu git) : bon ; vérifié pour les 14 (§5.2) |
| Cache Mathlib (`lake exe cache get`, job `impl`) | `K7pl` | binaire distant ; échec toléré (`verify.yaml:93`, avertissement seulement) ; **non testé ici** |
| `actions/cache` `.lake/packages` (clé : `hashFiles(lake-manifest.json, lean-toolchain)`) | `impl`, `spec` | restaure aussi les `.lake/build` des paquets (Verso…) ; si Lean est déterministe (§5.2) un cache chaud et un build froid donnent les mêmes octets ; **dépendance d'état non mesurée en CI** |
| Image `ubuntu-latest` | tout | flottante ; non épinglée |
| Ordre de fichiers / `find` | HTML/TeX | n'affecte que mes listes de condensats (triées) ; le contenu de Verso identique sur 6 rendus |
| Horloge, `TZ`, locale | Lean → TeX | testés (§5.2) : sans effet |
| Python (`scripts/controle.py`) | contrôle | sans sortie d'artefact ; version de `python3` non épinglée |
| Archives zip des artefacts GitHub | transfert | l'octet du fichier extrait est inchangé ; le condensat de l'archive zip varie (horodatages) mais n'est pas utilisé |

### 5.6 Audit d'axiomes sur la spécification (exécuté)

**[EXÉCUTÉ]** dans la copie A construite (§5.2), le **vrai** `scripts/axiom-audit.sh` : `Spec Spec` → « audited 1319 declaration(s) under 'Spec'; all within the allowlist » (exit 0) ; `SpecExt SpecExt` → 586 déclarations, dans la liste autorisée (exit 0) ; `SpecBib SpecBib` → 2 déclarations, dans la liste autorisée (exit 0). La CI n'audite que `Spec` (`verify.yaml:148`) : `SpecExt` et `SpecBib` **ne sont pas audités**, mais ils sont **propres aujourd'hui** (premier constat chiffré). L'exécutable `spec` (`tools/SpecMain.lean`) a été construit pendant le rendu sans aucun avertissement (journal `qr/render-A-r1.log` : `Built SpecMain`, pas de `⚠`) : ajouter `leanOptions` à `lean_exe spec` (§3.4) **ne ferait donc pas échouer le build actuel** pour cet exécutable. (Pour `mainTest`, non vérifié : Mathlib non construit.)

### 5.7 Protocole minimal et honnête proposé (non implémenté en vague 1)

**Niveau 1 : Lean → HTML/TeX (testable hors CI, démontré ci-dessus).** Dans un job de CI (de préférence sur `full.yaml`/cron quotidien, pas à chaque PR : coût ≈ un second build de `Spec`) : `lake build Spec` + `lake exe spec --output _out/a --with-tex` ; effacer `_out` et `.lake/build` du projet (pas les paquets) ; reconstruire dans un second répertoire de travail ; comparer les listes de condensats triées de `html-multi` et `tex` (script d'une vingtaine de lignes). Preuve apportée : déterminisme de la génération Verso/SpecExt *dans cette image de runner*. Preuve non apportée : indépendance vis-à-vis de l'image/de la date. Détecte : une régression introduite dans `tools/SpecExt` ou par une mise à jour de Verso/Lean (itération sur table de hachage non ordonnée, horodatage, chemin absolu, aléa).

**Niveau 2 : TeX → PDF (exige le réseau, donc la CI ou une machine avec accès au bundle).** Sur l'artefact `spec-tex` d'un même run : (a) définir `SOURCE_DATE_EPOCH` à la date du commit (`git log -1 --format=%ct`) et passer `-Z deterministic-mode` ; (b) compiler **deux fois**, dans deux répertoires de travail frais ; (c) comparer `sha256sum` des deux PDF ; (d) **enregistrer le condensat du bundle** téléchargé (`SHA256SUM` du cache Tectonic) comme part de la preuve ; (e) contrôle négatif : une compilation sans `SOURCE_DATE_EPOCH` séparée de 2 s doit donner un hachage différent (preuve que le mécanisme de date est bien la cause et que le test peut échouer). Si `hash A ≠ hash B` malgré (a), diagnostiquer avant toute affirmation (`diffoscope`, ou comparaison des champs de date/ID). Preuve apportée si égalité : mêmes entrées TeX + même binaire Tectonic épinglé + même contenu de bundle + même `SOURCE_DATE_EPOCH` ⇒ mêmes octets sur 2 exécutions indépendantes. Preuve **non** apportée : immutabilité future du bundle (non épinglé), reproductibilité par un tiers sans l'image, correction du contenu.

**Niveau 3 : build complet d'`impl` (`K7pl`) :** exige le cache Mathlib et la CI ; sans objet tant que `src/` est un gabarit de deux modules (§3.1) ; **FUTURE**.

**Formulation à n'utiliser qu'après démonstration** : « La génération HTML/TeX de la spécification est déterministe (2 builds propres, mêmes octets) dans l'image X ; le PDF n'est pas encore démontré reproductible. » Ne jamais écrire « build reproductible » avant le niveau 2.



## 6. REUSE

**[EXÉCUTÉ]** `pip install reuse` (dans un venv jetable) → `reuse, version 6.2.0` ; `reuse lint` à la racine du worktree (HEAD `b5f6146`, avant l'ajout de ce document) :

```
* Bad licenses: 0            * Deprecated licenses: 0       * Licenses without file extension: 0
* Missing licenses: 0        * Unused licenses: 0           * Used licenses: CC-BY-4.0, CECILL-2.1
* Read errors: 0             * Invalid SPDX License Expressions: 0
* Files with copyright information: 363 / 363
* Files with license information: 363 / 363
Congratulations! Your project is compliant with version 3.3 of the REUSE Specification :-)
exit=0
```

Niveau : conformité de licences/droits d'auteur (métadonnées), pas qualité du code. La CI utilise `fsfe/reuse-action@676e2d56… # v6.0.0` (`reuse.yaml:22-23`) : la version de `reuse` embarquée par cette action n'a pas été vérifiée ; l'écart avec 6.2.0 est improbable mais non exclu. Après ajout de ce document (non suivi), `reuse lint` renvoie toujours « compliant », 364/364 fichiers. `docs/**` est couvert par une annotation de `REUSE.toml` (`REUSE.toml:71`), donc le dossier `docs/security/` ne demande pas d'en-tête SPDX par fichier.

## 7. Documentation de build : un tiers peut-il reproduire ?

**[LU]** `CONTRIBUTING.md:17-23` et `README.md:21-32` : `lake exe cache get`, `lake build && lake test`, `pip install reuse && reuse lint`, `lake lint`, `lake exe spec --output _out/spec`. La version de Lean est donnée par `lean-toolchain` (`leanprover/lean4:v4.34.0`), « elan l'installe automatiquement ».

| Besoin d'un tiers | Documenté ? | Observation |
|---|---|---|
| Installer elan | non (lien seulement, `README.md:23`) | suppose elan déjà présent |
| Prérequis système (git, curl, Python 3, `zstd` pour les toolchains) | non | `scripts/*.py` supposent `python3` ; version non précisée (la CI prend celle de `ubuntu-latest`) |
| Durée et ressources d'un build à froid | non | la CI fixe 45 min (`verify.yaml:70,122`) ; le cache Mathlib est « best effort » (`verify.yaml:93`) |
| Reconstruire les contrôles de la CI en local (`python3 scripts/controle.py`, `scripts/axiom-audit.sh K7pl K7pl`, `lake lint`) | partiel | `lake lint` est dans le README ; `controle.py` n'est mentionné que dans `.claude/CLAUDE.md` et les règles ; l'audit d'axiomes n'est pas dans le README |
| Générer le TeX / le PDF de la spécification | non | `README.md:31` ne donne que le HTML ; ni `--with-tex`, ni Tectonic 0.15.0 (SHA-256 épinglé dans `verify.yaml:191-192`), ni la commande `tectonic -X compile` |
| Contrôler un PDF publié | non | un SHA-256 est joint à la release (`release.yaml:104-106`) mais aucune procédure de recalcul n'est écrite |
| Versions d'outils | partiel | Lean/Mathlib/CSLib/Verso : une seule version dans `lakefile.lean` + `lake-manifest.json` ; Tectonic : `verify.yaml` ; `axiom-audit` : `scripts/axiom-audit.sh` ; `reuse`, Python : non fixés |

**Interprétation** : un tiers peut compiler `K7pl`/`Spec` en suivant le README (hypothèse : elan installé et réseau ouvert), mais **ne peut pas reproduire l'artefact publié (PDF)** à partir de la documentation seule. Rien ne prétend le contraire pour le build (§5.1 : seule la phrase `CHANGELOG.md:31` sur le convertisseur Org → Verso emploie « reproductible »). Action (vague 2, `CONTRIBUTING.md`/`README.md`) : un paragraphe « Reconstruire et vérifier » listant prérequis, versions et commandes exactes, **et** formulant honnêtement ce que la sortie prouve (voir §5.7), une fois le protocole du §5 arbitré.

## 8. Régressions qui passeraient inaperçues aujourd'hui

| # | Régression | Preuve | Statut |
|---|---|---|---|
| R1 | **Fichier Lean non compilé** : un nouveau module de `src/` non importé par `K7pl.lean`, ou un nouveau `tests/XTest.lean` absent des `roots` de `K7plTests` et de `MainTest`, n'est jamais construit ; un `#guard` faux ou un avertissement fatal dedans ne fait pas échouer `lake build` | **[EXÉCUTÉ]** mini-projet (`qr/mini_orphan.sh`, `qr/mini_orphan2.sh`) : `OrphanTest.lean` avec `#guard 2 + 2 == 5` et `Orphan.lean` avec une variable inutilisée, hors `roots` et non importés : `lake build Mini MiniTests` → « Build completed successfully », `exit=0` ; traités directement par `lean`, les deux échouent (`exit=1`). Aucun contrôle du dépôt ne vérifie l'exhaustivité (la règle est une liste de gestes manuels : `.claude/skills/writing-rules.md:145-151`) | VERIFIED (mécanisme) ; transposition à k7pl **[LU]** : `lakefile.lean` `roots := #[`ArithTest, `SemanticsTest]` |
| R2 | `native_decide`/`axiom` ajouté dans `tests/`, `tools/SpecExt`, `tools/SpecBib`, `tests/MainTest.lean`, `tools/SpecMain.lean` | §3.5 ; `K7plTests` non audité (mini-projet) | VERIFIED (mécanisme) |
| R3 | Avertissement (y compris `sorry`) dans `tests/MainTest.lean` ou `tools/SpecMain.lean` | §3.4 (mini-projet) | VERIFIED (mécanisme) ; transposition ESTIMÉ |
| R4 | PDF dont le contenu se dégrade sans erreur bloquante (références `??`, glyphes manquants, débordements) | §5.4 point 5 : journaux jamais inspectés | PARTIAL ; comportement exact de Tectonic ESTIMÉ |
| R5 | Dérive de rendu de la spécification (changement de Verso/Lean par `bump-lean`, ou de `tools/SpecExt`) sans diff de contenu | aucun instantané ni comparaison ; seul critère : sortie non vide | PARTIAL |
| R6 | Vues dérivées de `docs/suivi/` périmées (`fiches-statuts.csv` modifié sans `suivi.py all`) | `suivi.py` absent des workflows (`grep` : aucune occurrence) ; `fiches-statuts.csv` est « léger » (matrice §1) ; **aujourd'hui** aucune dérive (`suivi.py all` dans une copie : aucune différence) | VERIFIED (absence de contrôle) |
| R7 | Régression propre à l'appel `axiom-audit.sh Spec Spec` après modification du script | classé `lean` seul (§2.5) | VERIFIED (lu + simulation) |
| R8 | Modification de `.claude/settings.json` (déclaration de hooks, dont `scripts/claude-session-start.sh`) | classé léger : aucun contrôle ; **recouvrement** avec les domaines supply-chain et gouvernance | VERIFIED (matrice §1) |
| R9 | `lake test` « vert » sans exécuter tous les tests : retirer `ArithTest.tests` de la liste de `MainTest.tests` | aucun contrôle de cardinalité ; les `#guard` restent le vrai filet | LU |
| R10 | Logique de `scripts/sync_zenodo.py` (214 lignes), `bump-lean.sh`, `latest-lean-version.sh`, `claude-session-start.sh`, convertisseurs `org2*` : aucun test automatique ; seul `impact.py` en a (9 tests) | `find scripts -name 'test_*'` → `scripts/ci/test_impact.py` seul | VERIFIED (absence) |
| R11 | PDF publié différent de celui construit par la CI du même commit (il est reconstruit dans le run de release) ; aucune comparaison | §5.4 point 6 | VERIFIED (lu) |
| R12 | Cache Mathlib indisponible : le job `impl` reconstruit Mathlib (jusqu'à 45 min) avec un simple avertissement ; échec bruyant (timeout) mais lent | `verify.yaml:93` | LU |

## 9. Écarts, actions et recommandations

### 9.1 Écarts

**Critiques : aucun.** Je n'ai pas observé d'écart qui laisse passer silencieusement, aujourd'hui, une régression de sécurité du dépôt. (Réserve : `lake build/test/lint` n'ont pas été exécutés par moi, §0.1.)

**Importants**

1. **I1.** Les invariants « jamais de `native_decide`/`axiom`/`sorry` » ne sont outillés que pour les racines `K7pl` et `Spec` ; `K7plTests`, `SpecExt`, `SpecBib` et les deux racines d'exécutables sont hors champ (§3.4, §3.5). Aucune violation actuelle (`SpecExt`/`SpecBib` audités à ma passe : propres).
2. **I2.** Aucun contrôle d'exhaustivité des modules Lean : un module ou un test oublié dans `roots`/`import` n'est ni compilé ni testé (R1). Cette classe d'erreur est naturelle avec la procédure manuelle de `writing-rules.md`.
3. **I3.** Le PDF publié n'est pas démontré reproductible et ne peut pas l'être tel que `verify.yaml` est écrit (`SOURCE_DATE_EPOCH` absente, bundle TeX non épinglé et téléchargé au runtime, cache d'état). Aucune affirmation contraire n'est faite dans le dépôt : il s'agit d'une limite à **documenter**, pas d'un mensonge à corriger.
4. **I4.** Les contrôles qui portent la valeur d'assurance de `src/` (`lake build K7pl`, `lake test`, `lake lint`) n'ont pas pu être exécutés dans cette session : leur état réel est celui de la CI (à lire par un humain, §9.2).

**Opportunistes**

- **O1.** Supprimer la regex `grep -Eq` redondante de `ci.yaml:57` (cinq alternatives mortes à cause de `\\.`, défaut SIGPIPE/`pipefail` reproduit, journal appauvri en `--force-full`) ; `impact.py` est la source unique ; ajouter un test paramétré sur `FULL_EXACT`/`FULL_PREFIXES` (§2.3).
- **O2.** Classer `scripts/axiom-audit.sh` aussi comme déclencheur de `spec_build` (il est appelé par le job `spec`).
- **O3.** `leanOptions` sur `lean_exe mainTest` (et `spec`, déjà sans avertissement) : **`lakefile.lean`, modification à signaler en PR** (§3.4).
- **O4.** Rendre `scripts/suivi.py check` (et `all` + `git diff --exit-code docs/suivi`) exécutable en CI quand `docs/suivi/**` change, y compris le CSV (R6).
- **O5.** Inspecter les journaux Tectonic (`--keep-logs`) : échec sur « undefined reference », « Missing character », au minimum avertissement dans le résumé d'étape ; téléverser le journal. Comportement exact de Tectonic à vérifier en CI avant de rendre cela bloquant.
- **O6.** Optionnel : zizmor en non bloquant, SHA-épinglé, après arbitrage avec les domaines supply-chain/sécurité (§4.3) ; passer `steps.version.outputs.latest` par `env:` dans `bump-lean.yaml:44`.
- **O7.** Section « Reconstruire et vérifier » dans `CONTRIBUTING.md`/`README.md` (§7).
- **O8.** Contrôle de cardinalité de `MainTest.tests` ; script d'exhaustivité des modules (I2).
- **O9.** lychee : décider explicitement si les liens externes et les ancres doivent être contrôlés (aujourd'hui hors ligne seulement).

### 9.2 Actions humaines requises (HUMAN ACTION REQUIRED)

| # | Action | Procédure exacte | Comment vérifier |
|---|---|---|---|
| H1 | Lire l'état réel de `impl` (build/test/lint) sur `main` | depuis une machine authentifiée : `gh run list --repo AntheaLiles/k7pl --workflow CI --branch main --limit 5` puis `gh run view <id> --log --job <impl>` ; relever `Build completed successfully`, `N/N tests passed`, sortie de `lake lint`, et la ligne `axiom-audit: audited N declaration(s) under 'K7pl'; all within the allowlist` | les trois lignes citées figurent dans le journal du job `Implémentation Lean` ; consigner l'identifiant de run dans `VALIDATION.md` (vague 2) |
| H2 | Trancher l'ambition de reproductibilité | choisir entre : (a) rien de plus, documenter la limite ; (b) niveau 1 quotidien (§5.7) ; (c) niveaux 1 + 2 | décision écrite dans `docs/` (journal de décisions), avant toute formulation publique |
| H3 | Si zizmor est adopté : vérifier dans la documentation GitHub Actions que `uses: $/…` existe avant d'appliquer l'autofix `self-repository` | lecture de la documentation officielle (inaccessible depuis cette session pour zizmor) | un workflow modifié passe `actionlint` **et** s'exécute (run `workflow_dispatch`) |
| H4 | Validation en CI des changements de `lakefile.lean` (si retenus) | ouvrir une PR dédiée, signaler `lakefile.lean` dans la description (règle `.claude/rules/lean.md`) | job `impl` vert avec `leanOptions` sur `mainTest` |
| H5 | Lire le score Scorecard et l'état CII | `api.securityscorecards.dev` et `bestpractices.dev` refusés ici | hors de mon domaine ; voir les autres agents |

### 9.3 Ce qui ne doit PAS être corrigé ou ajouté (décoratif ou faux signal)

- **Pas de fuzzer, pas de cible OSS-Fuzz/ClusterFuzzLite** tant que `src/` n'a ni lexer, ni parser, ni sérialisation (§3.3) : il n'exercerait que `Expr.eval`, déjà prouvé.
- **Pas de CodeQL pour faire apparaître un score SAST** (§4.4) ; pas d'adoption en bloc de ruff (125 constats de style, non sécuritaires) ni de bandit bloquant (12 constats LOW).
- **Ne pas appliquer l'autofix zizmor `self-repository`** sans preuve que la syntaxe est valide (§4.3).
- **Ne pas écrire « build reproductible »** (README, CII, release) avant démonstration du niveau 2 (§5.7). Le niveau 1 permet seulement d'écrire que la génération HTML/TeX est déterministe dans l'image testée.
- **Ne pas ajouter de test qui instancie un théorème déjà prouvé** (déjà le cas pour `eval double` : ligne décorative).
- **Ne pas rendre bloquant** un contrôle de journal Tectonic avant d'avoir observé en CI ce qu'un build sain produit.
- Ne pas affaiblir `warningAsError` ni l'audit d'axiomes ; ne pas supprimer le job `quick`.

### 9.4 Fichiers que je voudrais modifier en vague 2 (pour éviter les collisions d'écriture)

| Fichier | Modification envisagée | Recouvrement possible |
|---|---|---|
| `.github/workflows/ci.yaml` | supprimer la regex shell (O1) | gouvernance/supply-chain (même fichier : permissions, épinglage) |
| `.github/workflows/verify.yaml` | audit d'axiomes sur `K7plTests`/`SpecExt` (I1) ; `SOURCE_DATE_EPOCH` + `-Z deterministic-mode` + inspection du journal Tectonic (O5, I3) ; étape d'exhaustivité des modules (I2) ; éventuel job `repro` (niveau 1) | supply-chain (Tectonic, bundle), CII |
| `.github/workflows/full.yaml` | éventuel déclenchement du job de reproductibilité (cron quotidien) | — |
| `scripts/ci/impact.py`, `scripts/ci/test_impact.py` | tests paramétrés ; classement de `scripts/axiom-audit.sh` (O1, O2) | — |
| `scripts/axiom-audit.sh` | éventuellement accepter plusieurs racines | supply-chain (épinglage du SHA) |
| `scripts/` (nouveaux : contrôle d'exhaustivité des modules Lean, comparaison de rendus) | nouveaux fichiers, avec en-têtes REUSE | — |
| `CONTRIBUTING.md`, `README.md` | section « Reconstruire et vérifier » (O7) | CII, scorecard (documentation) |
| `lakefile.lean` | `leanOptions` sur les deux `lean_exe` (O3) | **frontière** : configuration de build, à signaler en PR |
| `docs/security/workstreams/quality-reproducibility/CHANGES.md`, `VALIDATION.md` | à créer en vague 2 | — |

Je ne prévois de toucher ni `.github/workflows/release.yaml`, ni `scripts/claude-session-start.sh`, ni `scripts/sync_zenodo.py`.

### 9.5 Contradictions et recouvrements avec les autres domaines

- **Supply chain / release** : le bundle TeX non épinglé, l'absence de `SOURCE_DATE_EPOCH`, l'attestation de provenance sans reproductibilité (`release.yaml:109`) relèvent aussi d'eux ; `claude-session-start.sh` (`curl … elan-init.sh | sh` sur branche mutable, `scripts/claude-session-start.sh:15-17`) est dans leur périmètre, pas dans le mien.
- **Gouvernance** : `CI OK` seul requis (ruleset) et `strict_required_status_checks_policy: false` ; mon constat sur les `skipped` du §2.5 en dépend.
- **Sécurité** : actionlint/gitleaks/zizmor (§4.3) ; `.claude/settings.json` classé léger (R8).
- **Scorecard / CII** : « Fuzzing » et « SAST » resteront faibles par construction (§3.3, §4) : à documenter, non à contourner. Le critère CII de build reproductible ne doit pas être revendiqué (§5).
- **Contradiction avec le briefing** : le briefing annonce qu'aucune toolchain Lean n'est utilisable ; elle l'est (archive GitHub) pour tout ce qui ne dépend pas du cache Mathlib. Les autres agents peuvent donc exécuter `lake build Spec`/`lake exe spec`/`axiom-audit` eux aussi.
- Les deux autres agents qui concluaient « effet nul de la regex » ont raison pour l'effet (confirmé par ma propre exécution, §2) ; la nuance que j'ajoute : la regex est entièrement redondante et porte un défaut SIGPIPE latent.

### 9.6 Points touchant `spec/`, `src/` ou la sémantique (frontière)

Aucun changement n'est proposé dans `spec/`, `src/` ou `tests/`. À signaler :

- `lakefile.lean` (O3) : configuration de build des cibles de `src/` et de `tools/` ; modification **non sémantique** mais explicitement à signaler en PR.
- Le contrôle d'exhaustivité des modules (I2) et l'extension de l'audit d'axiomes (I1) **lisent** `src/` et `tests/` sans les modifier ; tout `grep` de `axiom` sur `spec/` aurait des faux positifs (mot français) et ne doit pas conduire à toucher le manuscrit.
- `main.tex` contient `\date{\sffamily }` (aucune date). Introduire une date dans le PDF serait une décision éditoriale de l'auteur sur `spec/` ou sur `tools/SpecExt` ; je ne la propose pas.
- Fuzzing/PBT (§3.3) : les propriétés futures (aller-retour de l'analyseur, totalité) dépendront de la syntaxe concrète de k7pl, qui n'est pas encore formalisée ; la relation `spécification → formalisation → implémentation → preuve → test` est aujourd'hui vide côté `src/` (les deux modules sont des exemples jouets). Rien ici ne présume de ce que la spécification dira.

### 9.7 Ce que je n'ai PAS pu vérifier, et pourquoi

| Point | Raison | Étiquette |
|---|---|---|
| `lake build K7pl K7plTests`, `lake test`, `lake lint` sur le dépôt | exigent Mathlib précompilé ; cache non sondé, reconstruction hors budget | NON VÉRIFIÉ → H1 |
| Disponibilité du cache Mathlib (`lake exe cache get`) | non sondé | NON VÉRIFIÉ |
| Compilation Tectonic → PDF, effet exact de `SOURCE_DATE_EPOCH`/`-Z deterministic-mode` sur les octets du PDF | bundle `relay.fullyjustified.net` refusé par le proxy ; pas de TeX local | BLOCKED (hypothèse de la lecture du code : ESTIMÉ) |
| Reproductibilité entre machines, de l'exécutable `spec` et des `.o` | non mesuré (même machine, objets natifs non hachés) | NON VÉRIFIÉ |
| Condensat indépendant de l'archive Lean 4.34.0 | API GitHub de `leanprover/lean4` non accessible dans la session | NON VÉRIFIÉ |
| Intégrité des toolchains installées par elan dans la CI | non auditée | NON VÉRIFIÉ |
| lychee (ancres, liens externes), commitlint, gitleaks, version de `reuse` de l'action | outils non installés / hors périmètre | NON VÉRIFIÉ |
| Historique réel des runs de CI (taux d'échec, flakiness du cache) | non consulté | NON VÉRIFIÉ |
| Scorecard réel, badge CII | hôtes refusés par le proxy | HUMAN ACTION REQUIRED |
| Transposition à k7pl de §3.4 (exécutables hors `warningAsError`) | établi sur mini-projet, pas sur les fichiers du dépôt (Mathlib) | ESTIMÉ |

## 10. Annexe : pièces utilisées

Scripts et sorties de mes expériences (non suivis, dans le scratchpad de session, sous `qr/`) : `regex_test.py`, `sim_impact.sh`, `sim_odd.sh`, `pipefail.sh`, `classify_matrix.py`, `mini/` + `mini_run.sh`, `mini_exe_opts.sh`, `mini_orphan.sh`, `mini_orphan2.sh`, `prepare.sh`, `build_and_render.sh`, `negative_control.sh`, `axiom_spec.sh`, `pkg_hash.sh`, `suivi_check.sh`, `sast_run.sh`, `zizmor_sum.sh`, listes de condensats `hashes-A/`, `hashes-B/`. **Ces scripts ne sont pas versionnés** ; la vague 2 les reprendra sous `scripts/` si le protocole du §5.7 est retenu.

Pièces [PISTE] du prédécesseur consultées, **non réexécutées** et non utilisées comme preuve : `repro/` (build et hachages A/B antérieurs, répertoires `A`, `B`, `toolchain`), `tectonic/` (sources amont partielles), `tex-smoke/`, `regex/`. Seuls ont été réutilisés, après vérification, l'archive de toolchain (SHA-256 recalculé), l'archive Tectonic (SHA-256 recalculé, identique à `verify.yaml:192`) et les checkouts de paquets (révisions recalculées).

