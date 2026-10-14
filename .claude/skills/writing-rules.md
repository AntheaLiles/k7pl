<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
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
| `spec/Spec/<Ch>.lean`          | Un chapitre (`C1`…`C7`, `Refs`, `AnnexeA`…`AnnexeD`) : titre, `{refsection}`, introduction, `{include}` des sections | CC-BY-4.0  |
| `spec/Spec/<Ch>/<Section>.lean` | Une section de niveau 2 : ses sous-sections (`#`, `##`…) et ses blocs | CC-BY-4.0  |
| `spec/figures/`                | Figures : sources TikZ canoniques dans `tikz/` (avec `manifest.json`), dont `<nom>.svg` (HTML) et `<nom>.pdf` (PDF) sont générés et non suivis ; `sources/` conserve les anciennes sources drawio et mermaid | CC-BY-4.0  |
| `spec/CHANGELOG.md`            | Versions de la spécification (releases `spec-vX.Y.Z`)           | CC-BY-4.0  |
| `tools/SpecMain.lean`          | Générateur de la spécification (`lake exe spec`)                | CECILL-2.1 |
| `tools/SpecExt/`, `tools/SpecExt.lean` | Extensions Verso de la spécification (renvois, énoncés, formules, figures, citations…) | CECILL-2.1 |
| `tools/SpecBib.lean`           | Bibliographie, **générée** par `scripts/biblio/biblio.py`        | CECILL-2.1 |
| `docs/bibliography/references.json` | Notices des œuvres citées (source de `SpecBib.lean`)       | CC-BY-4.0  |
| `docs/`                        | Documentation courante, suivi, recherche, méthode, assurance et preuves | CC-BY-4.0  |
| `docs/archives/`               | Manuscrit Org figé, ancien outillage                             | CC-BY-4.0 / CECILL-2.1 |
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
| `LICENSE.md`                   | Présentation des licences, en français                          | —          |
| `README.md`, `CHANGELOG.md`    | Documentation du projet                                         | CECILL-2.1 |
| `CONTRIBUTING.md`, `SECURITY.md` | Déroulement des contributions, signalement de vulnérabilités  | CECILL-2.1 |
| `CODE_OF_CONDUCT.md`           | Contributor Covenant 2.1 (traduction française)                 | CC-BY-4.0  |
| `CITATION.cff`                 | Comment citer la spécification (DOI Zenodo)                     | CECILL-2.1 |

Dépendances (toutes épinglées sur la version de `lean-toolchain`) :

- **Mathlib** : mathématiques et tactiques (`ring`, `simp`, `omega`…).
- **CSLib** : fondements de l'informatique (LTS, lambda-calcul, relations…).
- **Verso** : écriture de la spécification (genre `Manual`).

Les bibliothèques écrites **dans le langage k7pl** (et non en Lean) sont
recommandées sous `CECILL-C` (copyleft faible), voir `LICENSE.md`.

## 2. Langues

- **Anglais** pour tout le code source : identifiants, docstrings, commentaires,
  messages affichés, noms de tests, scripts et workflows.
- **Français** pour la documentation : README, CONTRIBUTING, SECURITY, CHANGELOG,
  règles de rédaction, spécification Verso (`spec/`), issues et PR.
- Messages de commit : français ou anglais, au format Conventional Commits.

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
-- SPDX-License-Identifier: CC0-1.0
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
# SPDX-License-Identifier: CC0-1.0
```

Markdown :

```markdown
<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
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
| `{cite "CLÉ1,CLÉ2"}[]` | citation numérique `[3, 5–7]`, numérotée par chapitre (`{refsection}`) ; la clé doit exister dans `docs/bibliography/references.json` |
| `::::theorem (label := "thm:x") (scope := "metatheory")`, et ses directives sœurs | énoncé : définition, prémisse, résultat, exigence, résultat de la littérature, exemple ; voir « Énoncés : directives spécialisées » ci-dessous |
| `::::thm (label := "thm:x") (status := …) (level := …)` | **historique**, conservé pour compatibilité ; `spec/` ne l'emploie plus. `status` : `theoreme`, `proposition`, `conjecture`, `definition`, `exigence`, `litterature` |
| `::::formula (label := "eq:x") (kind := "formule")` | formule(s) : blocs de code contenant du LaTeX mathématique, `:::caption` |
| `::::figure (label := "fig:x") (src := "nom") (alt := "…") (width := "90")` | figure `spec/figures/nom.{svg,pdf}` ; créneaux `:::caption`, `:::desc`, `:::note`, `:::source` |
| `::::k7table (label := "tab:x") (align := "lZ{1.0}")` | tableau légendé autour d'un `:::table +header` ; `align` : colonnes `tabularx` du PDF |
| `::::listing (label := "lst:x")` | code source légendé |
| `{rmq}[…]` | remarque marginale numérotée (« RMQ n. ») |
| `{sc}[…]` | petites capitales |
| `{listof "figure"}` | liste des figures, `"table"`, `"formule"`, `"listing"` |
| `{printindex}` | index à pages (PDF) et à sections (HTML) ; les termes de `tools/SpecExt/IndexTerms.lean` sont reconnus dans le texte à la génération (`SpecExt.AutoMark`), sans balisage à la main |
| `{idx "terme"}[texte]`, `{gloss "définition"}[texte]` | marques posées par la reconnaissance automatique (index, infobulle du glossaire) ; ne s'écrivent pas à la main |
| `:::comment` + bloc de code | commentaire d'auteur, conservé dans la source, jamais rendu |
| `{missing "label"}[]` | renvoi non résolu du manuscrit d'origine, imprimé `??` — à remplacer par `{num}` dès que l'étiquette existe |

Les étiquettes suivent `sec:`, `thm:`, `eq:`, `fig:`, `tab:`, `lst:`. Un énoncé corrigé **change de
sceau** (son `role` ou son `state`), il ne perd pas son étiquette ni ne se renumérote à la main :
chaque rôle (ou chaque nature, pour un objet sans rôle) a son compteur, qui suit l'ordre du
document ; les anciens blocs `::::thm` partageaient un compteur unique.

#### Énoncés : directives spécialisées

Toutes les directives d'énoncé partagent une représentation interne (`StatementInfo`, dans
`tools/SpecExt/Theorem.lean`) et une même validation. Elles séparent la nature de l'objet, son rôle,
son état épistémique, son appui et sa portée. Contrat repris de
`docs/tracking/LEAN-STATEMENT-ONTOLOGY-IMPLEMENTATION.md`, supprimé après intégration (dernière
version :
[`2bdb06e`](https://github.com/AntheaLiles/k7pl/blob/2bdb06e5e42857cef5c2f9084f6b6b7245bed46b/docs/tracking/LEAN-STATEMENT-ONTOLOGY-IMPLEMENTATION.md)) ;
les décisions qui le fondent sont dans `docs/tracking/DECISIONS.md` (taxonomie C8, 9 octobre 2026).

| Directive | Nature (`kind`) | Rôle par défaut | État par défaut | Numérotée | Étiquette |
|---|---|---|---|---|---|
| `::::theorem`, `::::lemma`, `::::corollary`, `::::proposition` | `result` | le nom de la directive | `under-review` | oui | requise |
| `::::conjecture` | `result` | `conjecture` | `proposed` | oui | requise |
| `::::axiom`, `::::postulate` | `assumption` | `axiom`, `postulate` | `under-review` | oui | requise |
| `::::hypothesis` | `assumption` | `hypothesis` | `under-review` | non | facultative |
| `::::definition` | `definition` | — | `not-applicable` | oui | requise |
| `::::requirement` | `requirement` | — | `not-applicable` | oui | requise |
| `::::literature` | `literature` | — | `not-applicable` | oui | requise |
| `::::example`, `::::counterexample` | `example`, `counterexample` | — | `not-applicable` | non | facultative |

Arguments, tous nommés :

- `label` : étiquette `thm:…` ;
- `scope` : **obligatoire**, vocabulaire fermé : `syntax`, `metatheory`, `graphs`, `resources`,
  `memory-safety`, `security`, `operational-semantics`, `graded-typing`, `effects`,
  `logical-relations`, `translation`, `fixed-points`, `interoperability`, `concurrency`,
  `ffi-safety`, `representation`, `compiler-interface`, `compilation`, `resource-accounting`,
  `literature`, `runtime`. Une étiquette de portée ne vaut pas garantie : les hypothèses et les
  limites restent dans le texte de l'énoncé ;
- `state` : `proposed`, `under-review`, `supported`, `established`, `refuted` ou `withdrawn` pour un
  résultat ou une prémisse ; `not-applicable` pour tout autre objet. Le rôle et l'état sont
  indépendants ;
- `evidence` : `none` (défaut), `written-proof`, `proofsketch`, `literature`, `computation`,
  `counterexample`, `lean-proof`. Une démonstration écrite, une esquisse et une preuve Lean sont
  trois choses distinctes ;
- `role` : remplace le rôle par défaut, s'il est compatible avec la nature ;
- `source` : provenance bibliographique, obligatoire pour `::::literature` et avec
  `evidence := "literature"` ;
- `formalArtifact` : déclaration Lean vérifiée (`Module.declaration`), obligatoire avec
  `evidence := "lean-proof"` et refusée sinon ;
- `level` : domaine historique (`langage` par défaut, `compilation`, `representation`,
  `deploiement`), conservé tel quel ; ce n'est pas la portée ;
- `+unnumbered` : objet local non numéroté.

Créneaux : `:::title` ; `:::statement`, ou `:::statement +titled` dont le premier paragraphe devient
le titre de l'énoncé ; `:::proofsketch` ; `:::note`, comme tout autre créneau, rendu en paragraphe
simple. Le texte placé hors créneau n'est pas rendu.

```text
::::theorem (label := "thm:exemple") (state := "under-review") (evidence := "proofsketch") (scope := "metatheory")
:::title
Titre court
:::
:::statement
Le texte de l'énoncé.
:::
:::proofsketch
L'argument, explicitement incomplet.
:::
::::
```

**Validation à la compilation** (`lake build Spec`). Sont refusés :

- un objet numéroté sans étiquette ;
- un état, un type d'appui ou une portée hors vocabulaire, ou une portée absente ;
- un résultat ou une prémisse sans état épistémique, ou un autre objet dont l'état n'est pas
  `not-applicable` ;
- un rôle incompatible avec la nature, ou une conjecture marquée `established` ;
- un résultat de la littérature sans `source` ;
- `lean-proof` sans `formalArtifact`, ou `formalArtifact` sans `lean-proof` ;
- `proofsketch`, `written-proof` ou `lean-proof` sur un objet qui n'est pas un résultat ;
- une hypothèse de portée `global`.

**Contrôle d'ontologie** (`scripts/controles/statement_ontology.py`, lancé par
`scripts/controle.py`). Il reprend ces règles et ajoute :

- `evidence := "proofsketch"` exige un créneau `:::proofsketch` ; ce créneau n'est admis qu'avec
  `evidence` égal à `proofsketch` ou `literature` ;
- le texte hors créneau est refusé.

**Limites.** Ces contrôles sont structurels. Ils ne valident ni une preuve, ni l'adéquation d'une
esquisse, ni l'attache d'une hypothèse à l'argument qu'elle qualifie. La présence de `source` est
exigée, pas sa résolution bibliographique. Aucune métadonnée ne remplace une preuve : passer un
énoncé à `established`, changer son rôle ou déclarer `lean-proof` est un changement de statut
scientifique, qui demande l'accord de l'autrice et, pour `lean-proof`, l'artefact formel testé.

### Vérifier

1. `lake build Spec` (compilation ; les avertissements sont des erreurs).
2. `lake exe spec --output _out/spec --with-tex` (rendu ; un renvoi ou une clé inconnus font échouer).
3. `python3 scripts/manuscript_metrics.py summary`, et `python3 scripts/suivi.py all` si des fiches ont changé d'état.
4. Ajouter une ligne dans `spec/CHANGELOG.md` (commit de type `docs(spec)`).

La bibliographie : ajouter une œuvre = ajouter sa notice à `docs/bibliography/references.json` (champs de
`scripts/biblio/biblio.py`), puis `python3 scripts/biblio/biblio.py lean docs/bibliography/references.json
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
-- SPDX-License-Identifier: CC0-1.0

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
| `#+BEGIN_EXPORT latex` `\begin{theorem}[…]` | `::::theorem` (ou la directive de sa nature) + `:::statement` + `:::proofsketch` |
| `#+BEGIN_EXPORT latex` `\begin{align*}` + `\captionof{formule}` | `::::formula (kind := "formule")` |
| `# commentaire`                       | `:::comment` + bloc de code                    |
| `#+PRINT_BIBLIOGRAPHY:`               | `{bibliography}`                               |
| `#+LATEX: \listoffigures`             | `{listof "figure"}`                            |
| `TODO` / `DRAFT` dans un titre        | commentaire `-- TODO:` dans le source          |

Cette table résume `scripts/org2verso/` : la conversion du manuscrit Org est reproductible
(`python3 scripts/org2verso/convert.py --src docs/archives/manuscrit-org --meta spec/figures --out <dossier>`
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
  un humain : un agent peut proposer des lemmes intermédiaires et des preuves, mais
  ne modifie pas l'énoncé d'un théorème principal sans accord explicite.
- Les rôles Claude Code sont séparés : architecture de la spec, édition de la spec,
  revue formelle, preuve Lean, implémentation Lean, diagnostic, cohérence transverse
  et vérification. Ne pas utiliser un agent généraliste quand un rôle spécialisé existe.
- Pour une tâche qui traverse `spec/` et `src/`, ne pas passer directement de
  « demande » à « code » : établir d'abord le contrat et ses dépendances, puis faire
  vérifier la cohérence entre spécification, formalisation, preuve, tests et documentation.
- Les skills sous `.claude/skills/` décrivent les procédures réutilisables ; les règles
  sous `.claude/rules/` définissent les invariants ; les agents sous `.claude/agents/`
  définissent les rôles et leurs paramètres de modèle. Les trois niveaux sont complémentaires.
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
