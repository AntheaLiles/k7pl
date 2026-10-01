<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# Règles de rédaction du projet k7pl

Ce document rassemble toutes les règles à suivre pour écrire du code, des
tests, des spécifications et des messages de commit dans ce dépôt.

## 1. Structure du dépôt

| Chemin                         | Rôle                                                            | Licence    |
|--------------------------------|-----------------------------------------------------------------|------------|
| `src/Main.lean`                | Point d'entrée historique (`Main.hello`)                        | CECILL-2.1 |
| `src/K7pl.lean`                | Racine de la bibliothèque : importe tous les modules `K7pl.*`   | CECILL-2.1 |
| `src/K7pl/`                    | Implémentation du langage en Lean 4 (Mathlib, CSLib)            | CECILL-2.1 |
| `tests/`                       | Tests en Lean 4 (un fichier `<Module>Test.lean` par module)     | CECILL-2.1 |
| `spec/Spec.lean`               | Racine de la spécification Verso : titre, `{texsetup}`, inclusion des chapitres | CC-BY-4.0  |
| `spec/Spec/<Ch>.lean`          | Un chapitre (`C1`…`C7`, `Refs`, `AnnexeA`…`AnnexeE`) : titre, `{refsection}`, introduction, `{include}` des sections | CC-BY-4.0  |
| `spec/Spec/<Ch>/<Section>.lean` | Une section de niveau 2 : ses sous-sections (`#`, `##`…) et ses blocs | CC-BY-4.0  |
| `spec/figures/`                | Figures : `<nom>.svg` (HTML), `<nom>.pdf` (PDF), `sources/` (drawio, mermaid) | CC-BY-4.0  |
| `spec/CHANGELOG.md`            | Versions de la spécification (releases `spec-vX.Y.Z`)           | CC-BY-4.0  |
| `tools/SpecMain.lean`          | Générateur de la spécification (`lake exe spec`)                | CECILL-2.1 |
| `tools/SpecExt/`, `tools/SpecExt.lean` | Extensions Verso de la spécification (renvois, énoncés, formules, figures, citations…) | CECILL-2.1 |
| `tools/SpecBib.lean`           | Bibliographie, **générée** par `scripts/biblio/biblio.py`        | CECILL-2.1 |
| `biblio/references.json`       | Notices des 250 œuvres citées (source de `SpecBib.lean`)         | CC-BY-4.0  |
| `docs/`                        | Suivi, relectures, méthode, recherche, journal (Markdown)        | CC-BY-4.0  |
| `archives/`                    | Manuscrit Org figé, ancien outillage                             | CC-BY-4.0 / CECILL-2.1 |
| `LICENSES/`                    | Textes complets des licences (gérés par `reuse download`)       | —          |
| `scripts/`                     | Maintenance (montée de version, hook de session, Zenodo), conversion Org → Verso (`org2verso/`), bibliographie (`biblio/`), mesures et suivi | CECILL-2.1 |
| `zenodo.json`, `zenodo.files.json` | Métadonnées Zenodo (communes, par PDF) — via `REUSE.toml`   | CECILL-2.1 |
| `.github/workflows/`           | CI : build/tests/lint/axiomes, Pages, REUSE, commits, sécurité  | CECILL-2.1 |
| `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md` | Modèles d'issues et de PR | CECILL-2.1 |
| `.github/dependabot.yml`       | Mises à jour des GitHub Actions                                 | CECILL-2.1 |
| `.claude/`                     | Consignes et hook de session pour les agents                    | CECILL-2.1 |
| `lakefile.lean`                | Configuration Lake (bibliothèques, exécutables, dépendances)    | CECILL-2.1 |
| `lake-manifest.json`           | Révisions exactes des dépendances (via `REUSE.toml`)            | CECILL-2.1 |
| `lean-toolchain`               | Version de Lean fixée (via `REUSE.toml`)                        | CECILL-2.1 |
| `.commitlintrc.yaml`           | Configuration du lint Conventional Commits                      | CECILL-2.1 |
| `REUSE.toml`                   | Licences des fichiers qui ne peuvent pas porter d'en-tête       | CECILL-2.1 |
| `LICENSE`                      | Présentation des licences, en français                          | —          |
| `README.md`, `CHANGELOG.md`    | Documentation du projet                                         | CECILL-2.1 |
| `CONTRIBUTING.md`, `SECURITY.md` | Déroulement des contributions, signalement de vulnérabilités  | CECILL-2.1 |
| `CODE_OF_CONDUCT.md`           | Contributor Covenant 2.1 (traduction française)                 | CC-BY-4.0  |
| `CITATION.cff`                 | Comment citer la spécification (DOI Zenodo)                     | CECILL-2.1 |

Dépendances (toutes épinglées sur la version de `lean-toolchain`) :

- **Mathlib** : mathématiques et tactiques (`ring`, `simp`, `omega`…).
- **CSLib** : fondements de l'informatique (LTS, lambda-calcul, relations…).
- **Verso** : écriture de la spécification (genre `Manual`).

Les bibliothèques écrites **dans le langage k7pl** (et non en Lean) sont
recommandées sous `CECILL-C` (copyleft faible), voir `LICENSE`.

## 2. Langues

- **Anglais** pour tout le code source : identifiants, docstrings, commentaires,
  messages affichés, noms de tests, scripts et workflows.
- **Français** pour la documentation : README, CONTRIBUTING, SECURITY, CHANGELOG,
  règles de rédaction, spécification Verso (`spec/`), issues et PR.
- Messages de commit : en français, au format Conventional Commits.

## 3. Conventions de nommage

- Fichiers `.lean` (code, tests **et** spécifications Verso) : **CamelCase**,
  un module par fichier, le nom de fichier correspond au nom du module.
  Ex. `src/K7pl/Parser.lean` → module `K7pl.Parser`,
  `spec/Spec/SyntaxRules.lean` → module `Spec.SyntaxRules`.
- Fichiers de test : nom du module testé suivi de `Test`, à la racine de `tests/`.
  Ex. `src/K7pl/Parser.lean` → `tests/ParserTest.lean` (module `ParserTest`).
  Ne pas créer de module de test sous `K7pl.*` : ce préfixe appartient à `src/`.
- Identifiants Lean : `lowerCamelCase` pour les fonctions et valeurs
  (`parseExpr`, `testHello`), `UpperCamelCase` pour les types, structures,
  classes et espaces de noms (`Expr`, `TypeEnv`). Théorèmes en `snake_case`
  à la manière de Mathlib (`eval_double`).

## 4. En-têtes REUSE

Chaque fichier commence par un en-tête SPDX avec l'année et le nom de
l'auteur : `SPDX-FileCopyrightText: <année> Cyprien PIERRE` (ou le nom de la
personne qui contribue).

| Fichier                                         | Préfixe de commentaire | Identifiant SPDX |
|-------------------------------------------------|------------------------|------------------|
| `.lean` dans `src/`, `tests/`, `tools/`, racine | `--`                   | `CECILL-2.1`     |
| `.lean` dans `spec/` (Verso)                    | `--`                   | `CC-BY-4.0`      |
| `.yaml`, `.yml`, `.toml`                        | `#`                    | `CECILL-2.1`     |
| `.md`                                           | `<!-- … -->`           | `CECILL-2.1`     |
| `.gitignore`, `.gitattributes`, `.editorconfig` | `#` + `REUSE.toml`     | `CECILL-2.1`     |
| `lean-toolchain`, `lake-manifest.json`          | aucun → `REUSE.toml`   | `CECILL-2.1`     |
| Bibliothèque écrite en k7pl                     | selon la syntaxe       | `CECILL-C`       |

Lean 4 (code) :

```lean
-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1
```

Verso (`spec/`) :

```lean
-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0
```

YAML, TOML, fichiers de configuration Git et EditorConfig :

```yaml
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1
```

Markdown :

```markdown
<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->
```

Fichier sans commentaire possible : ajouter dans `REUSE.toml`

```toml
[[annotations]]
path = "chemin/du/fichier"
precedence = "aggregate"
SPDX-FileCopyrightText = "2026 Cyprien PIERRE"
SPDX-License-Identifier = "CECILL-2.1"
```

Toute nouvelle licence utilisée doit avoir son texte dans `LICENSES/` :
`reuse download <IDENTIFIANT>`. Vérifier avec `reuse lint`.

## 5. Ajouter un module `.lean`

1. Créer `src/K7pl/<Module>.lean` (CamelCase) avec l'en-tête SPDX CECILL-2.1.
2. Déclarer le contenu dans `namespace K7pl.<Module>` … `end K7pl.<Module>`.
3. Ajouter `import K7pl.<Module>` dans `src/K7pl.lean`.
4. Créer `tests/<Module>Test.lean` avec l'en-tête SPDX :
   - vérifications à la compilation (`#guard`, `#guard_msgs`, `example`) ;
   - tests de propriétés avec `plausible` quand un invariant s'y prête ;
   - une liste `def tests : List (String × Bool)` exécutée par `lake test`.
5. Mettre à jour `lakefile.lean` : ajouter `` `<Module>Test `` aux `roots` de
   `lean_lib K7plTests`, puis importer le module de test dans
   `tests/MainTest.lean` et concaténer sa liste `tests`.
6. Pour une nouvelle dépendance : `require` dans `lakefile.lean`, puis
   `lake update <paquet>` et commit de `lake-manifest.json`.
7. Ajouter une ligne dans `CHANGELOG.md`, section `[Unreleased]`.
8. Vérifier : `lake build && lake test && lake lint && reuse lint`.

Importer Mathlib et CSLib **module par module** (`import Mathlib.Tactic.Ring`),
jamais `import Mathlib` ni `import Cslib` en entier : la compilation reste rapide.

## 6. Écrire dans la spécification (Verso)

La spécification est écrite en [Verso](https://github.com/leanprover/verso), genre `Manual`.
Ce sont des fichiers Lean : `lake build` les compile, et toute erreur (renvoi vers une étiquette
inconnue, clé bibliographique absente, balisage invalide) fait échouer la compilation ou le rendu.

**Le manuscrit porte « ne rien modifier sans l'accord de l'auteur »** : on ne corrige son texte
que sur demande, par la plus petite modification, et on consigne le changement (fiche, journal).

### Structure

- `spec/Spec.lean` inclut les chapitres dans l'ordre du document ; chaque chapitre `Spec/<Ch>.lean`
  ouvre une section de bibliographie (`{refsection "c3-types"}`), porte son introduction, puis
  `{include 0 Spec.<Ch>.<Section>}` pour chacune de ses sections ; son module de **dernière**
  section se termine par `{bibliography}` (la liste des œuvres citées dans le chapitre).
- Un module de section commence par `#doc (Manual) "Titre" =>`, puis un bloc `%%%` de
  métadonnées (`file := "…"` : nom de la page HTML ; `tag := "…"` : nom canonique, stable, de la
  section ; `number := false` pour les annexes, dont le numéro (`A.`, `A.1.`) est écrit dans le
  titre), puis `{label "sec:…"}` si la section est référencée.
- Nommer un nouveau module en CamelCase ASCII, sans accent ; ajouter son `import` et son
  `{include}` dans le module du chapitre.

### Extensions de la spécification (`tools/SpecExt/`)

| À écrire | Rôle |
|---|---|
| `{num "sec:x"}[]` | renvoi numéroté, lien vers l'objet (section, énoncé, formule, figure, tableau, listing) — remplace `\ref` |
| `{label "sec:x"}` | étiquette de la section courante (`(display := "A.1")` impose le numéro affiché) |
| `{cite "CLÉ1,CLÉ2"}[]` | citation numérique `[3, 5–7]`, numérotée par chapitre (`{refsection}`) ; la clé doit exister dans `biblio/references.json` |
| `::::thm (label := "thm:x") (status := "proposition") (level := "representation")` | énoncé scellé ; créneaux `:::title`, `:::statement`, `:::proofsketch`. `status` : `theoreme` (défaut), `proposition`, `conjecture`, `definition`, `exigence`, `litterature` ; `level` : `langage` (défaut), `compilation`, `representation`, `deploiement` |
| `::::formula (label := "eq:x") (kind := "formule")` | formule(s) : blocs de code contenant du LaTeX mathématique, `:::caption` |
| `::::figure (label := "fig:x") (src := "nom") (alt := "…") (width := "90")` | figure `spec/figures/nom.{svg,pdf}` ; créneaux `:::caption`, `:::desc`, `:::note`, `:::source` |
| `::::k7table (label := "tab:x") (align := "lZ{1.0}")` | tableau légendé autour d'un `:::table +header` ; `align` : colonnes `tabularx` du PDF |
| `::::listing (label := "lst:x")` | code source légendé |
| `{rmq}[…]` | remarque marginale numérotée (« RMQ n. ») |
| `{sc}[…]` | petites capitales |
| `{listof "figure"}` | liste des figures, `"table"`, `"formule"`, `"listing"` |
| `:::comment` + bloc de code | commentaire d'auteur, conservé dans la source, jamais rendu |
| `{missing "label"}[]` | renvoi non résolu du manuscrit d'origine, imprimé `??` — à remplacer par `{num}` dès que l'étiquette existe |

Les étiquettes suivent `sec:`, `thm:`, `eq:`, `fig:`, `tab:`, `lst:`. Un énoncé corrigé **change de
sceau**, il ne perd pas son étiquette ni ne se renumérote à la main : le compteur d'énoncés est
global et suit l'ordre du document.

### Vérifier

1. `lake build Spec` (compilation ; les avertissements sont des erreurs).
2. `lake exe spec --output _out/spec --with-tex` (rendu ; un renvoi ou une clé inconnus font échouer).
3. `python3 scripts/manuscript_metrics.py summary`, et `python3 scripts/suivi.py all` si des fiches ont changé d'état.
4. Ajouter une ligne dans `spec/CHANGELOG.md` (commit de type `docs(spec)`).

La bibliographie : ajouter une œuvre = ajouter sa notice à `biblio/references.json` (champs de
`scripts/biblio/biblio.py`), puis `python3 scripts/biblio/biblio.py lean biblio/references.json
tools/SpecBib.lean`.

## 7. Style Lean 4

Les règles suivent celles de Mathlib ; les linters de Mathlib (`mathlibStandardSet`)
sont actifs sur `src/`, et tout avertissement fait échouer la compilation
(`warningAsError`). `lake lint` (Batteries `runLinter`) vérifie en plus les
docstrings manquantes et les défauts courants.

En-tête et documentation de module :

```lean
-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Tactic.Ring
import K7pl.Syntax

/-!
# Small-step semantics

One-paragraph summary of the module.

## Main definitions

* `K7pl.Step`: the one-step reduction relation.

## Main statements

* `K7pl.step_deterministic`: reduction is deterministic.

## Notation

* `e ⟶ e'`: one reduction step.

## Implementation notes

Why this representation was chosen (only the non-obvious choices).

## References

* Wright & Felleisen (1994), *A Syntactic Approach to Type Soundness*.
-/
```

Les sections sont dans cet ordre ; celles qui n'ont pas de contenu sont omises
(`Notation` seulement si le module en introduit, `References` seulement s'il y en a).

Docstrings :

- Toute définition, structure, inductive, **constructeur** et théorème principal
  a un docstring `/-- … -/` ; les lemmes réutilisables aussi.
- Phrase complète en anglais, terminée par un point ; lignes suivantes non indentées.
- Écrire pour l'infobulle de l'éditeur : concis, autonome, complète la signature
  sans la paraphraser.
- Toute tactique, commande ou attribut défini dans le projet a un docstring.

Commentaires : expliquer le *pourquoi* (choix de représentation, `WellFounded`
plutôt que du carburant…), jamais le *quoi* que le type exprime déjà.

Preuves et axiomes :

- Aucun `sorry`/`admit` dans le code fusionné (bloqué par `warningAsError`).
- Aucun `axiom` nouveau, aucun `native_decide` : l'audit des axiomes en CI
  n'accepte que `propext`, `Classical.choice` et `Quot.sound` sous `K7pl`.
- Séparer définitions et preuves quand un module grossit
  (`K7pl/Foo/Defs.lean` pour les définitions, `K7pl/Foo/Basic.lean` pour les lemmes).
- Fichiers de 1500 lignes au plus (`linter.style.longFile`), lignes de 100 caractères au plus.

Mise en forme :

- Ordre dans un fichier : en-tête SPDX, ligne vide, `import`, documentation de
  module `/-! … -/`, `open`, puis `namespace`. Les `import` doivent précéder
  toute autre commande.
- Un `import` par ligne, triés : dépendances externes (Mathlib, Cslib, Verso)
  d'abord, puis les modules du projet.
- `open` limité au strict nécessaire ; préférer `open X in` pour un usage local.
- Tout le contenu d'un module dans `namespace K7pl.<Module>` … `end K7pl.<Module>`.
- Indentation de 2 espaces, pas de tabulations, lignes de 100 caractères au plus.
- Définitions internes marquées `private`.
- Pas de `sorry` dans le code fusionné.

## 8. Style Verso et réécriture depuis Org-mode

Style :

- Un fichier = un chapitre = un `#doc (Manual) "Titre" =>`.
- Titres de section avec `#`, `##`, `###` (relatifs au chapitre) ; pas de saut de niveau.
- Une phrase par ligne : les diffs restent lisibles, le rendu n'est pas affecté.
- Tout exemple de code Lean passe par un bloc ` ```lean ` (vérifié) ; les
  exemples dans la syntaxe k7pl utilisent un bloc sans langue en attendant
  un surligneur dédié.
- Métadonnées de chapitre dans un bloc `%%%` (ex. `shortTitle := "…"`).

Correspondances Org-mode → Verso, pour la réécriture des sources existantes :

| Org-mode                              | Verso                                          |
|---------------------------------------|------------------------------------------------|
| `#+TITLE: Titre`                      | `#doc (Manual) "Titre" =>`                     |
| `#+AUTHOR: Nom`                       | `%%%` `authors := ["Nom"]` `%%%`               |
| `* Section`, `** Sous-section`         | `# Section`, `## Sous-section`                 |
| `/italique/`, `*gras*`                | `_italique_`, `*gras*`                         |
| `=code=`, `~code~`                    | `` `code` ``                                   |
| `[[url][texte]]`                      | `[texte](url)`                                 |
| `- item`, `1. item`                   | `* item`, `1. item`                            |
| `#+BEGIN_SRC lean … #+END_SRC`        | ` ```lean … ``` ` (vérifié par Lean)           |
| `#+BEGIN_SRC k7pl … #+END_SRC`        | ` ``` … ``` `                                  |
| `#+BEGIN_QUOTE … #+END_QUOTE`         | `> citation`                                   |
| `#+INCLUDE: "autre.org"`              | `import Spec.Autre` + `{include 0 Spec.Autre}` |
| `\ref{label}`, `[[tab:x]]`, `\eqref{x}` | `{num "label"}[]`, `({num "x"}[])`          |
| `#+LATEX: \label{sec:x}` sous un titre | `{label "sec:x"}` sous le titre               |
| `[cite:@clé;@clé]`                    | `{cite "clé,clé"}[]`                           |
| `[rmq:texte]`                         | `{rmq}[texte]`                                 |
| `\textsc{x}`                          | `{sc}[x]`                                      |
| `#+NAME:` + `#+CAPTION:` + tableau    | `::::k7table (label := …)` + `:::caption` + `:::table +header` |
| `#+NAME:` + `#+CAPTION:` + `[[fichier.drawio]]` | `::::figure (label := …) (src := …)`  |
| `#+BEGIN_EXPORT latex` `\begin{theorem}[…]` | `::::thm` + `:::statement` + `:::proofsketch` |
| `#+BEGIN_EXPORT latex` `\begin{align*}` + `\captionof{formule}` | `::::formula (kind := "formule")` |
| `# commentaire`                       | `:::comment` + bloc de code                    |
| `#+PRINT_BIBLIOGRAPHY:`               | `{bibliography}`                               |
| `#+LATEX: \listoffigures`             | `{listof "figure"}`                            |
| `TODO` / `DRAFT` dans un titre        | commentaire `-- TODO:` dans le source          |

Cette table résume `scripts/org2verso/` : la conversion du manuscrit Org est reproductible
(`python3 scripts/org2verso/convert.py --src archives/manuscrit-org --meta spec/figures --out <dossier>`
donne les modules actuels, au caractère près, à la date de la conversion).

## 9. Conventional Commits

Format : `<type>(<scope>): <description>`

- Description à l'infinitif, en minuscules, sans point final.
- `scope` : module ou zone touchée (`parser`, `typechecker`, `spec`, `ci`, `reuse`…).
- Types :

| Type       | Usage                                              |
|------------|----------------------------------------------------|
| `feat`     | nouvelle fonctionnalité                            |
| `fix`      | correction de bogue                                |
| `docs`     | documentation, spécifications                      |
| `style`    | mise en forme sans changement de comportement      |
| `refactor` | restructuration sans changement de comportement    |
| `perf`     | amélioration de performance                        |
| `test`     | ajout ou correction de tests                       |
| `build`    | Lake, toolchain, dépendances                       |
| `ci`       | intégration continue                               |
| `chore`    | maintenance diverse                                |

Exemples :

```
feat(parser): ajouter support des expressions lambda
fix(typechecker): corriger la résolution des types polymorphes
docs(spec): documenter la syntaxe des annotations
```

Changement incompatible : ajouter `!` après le scope
(`feat(parser)!: …`) et un pied de page `BREAKING CHANGE: …`.

Le format est vérifié en CI par commitlint (`.github/workflows/commitlint.yaml`,
configuration `.commitlintrc.yaml`). Vérification locale du dernier commit :
`npx --yes -p @commitlint/cli -p @commitlint/config-conventional commitlint --from HEAD~1`.

## 10. Travailler avec un agent (Claude Code)

- Un patch n'est terminé que si `lake build`, `lake test` et `lake lint` passent,
  localement ou en CI : ne jamais le déclarer fini sur la seule relecture.
- Ne jamais inventer un nom de lemme : le vérifier (`#check`, `exact?`, recherche
  dans les sources de Mathlib/CSLib) avant de l'utiliser.
- Ne jamais introduire `sorry`, `axiom`, `native_decide`, ni désactiver un linter
  ou un test pour faire passer la CI.
- Les théorèmes principaux (énoncés de correction du langage) sont validés par
  un humain : un agent peut proposer lemmes intermédiaires et preuves, mais ne
  modifie pas l'énoncé d'un théorème principal sans accord explicite.
- Toucher `lakefile.lean`, `lean-toolchain` ou `.github/workflows/` demande
  une mention explicite dans la description de la PR.

## 11. Checklist avant commit

- [ ] En-tête SPDX présent et correct
- [ ] Identifiant SPDX valide (`CECILL-2.1`, `CC-BY-4.0`, `CECILL-C`)
- [ ] Copyright avec année et nom
- [ ] Fichier dans le bon dossier
- [ ] Code source en anglais, documentation en français
- [ ] Docstrings sur les nouvelles déclarations, documentation de module à jour
- [ ] Test associé si nouveau module
- [ ] Aucun `sorry`, aucun nouvel axiome
- [ ] `CHANGELOG.md` mis à jour
- [ ] Message de commit conforme Conventional Commits
- [ ] `lake build`, `lake test`, `lake lint` et `reuse lint` passent
