<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# Règles de rédaction du projet k7pl

Ce document rassemble toutes les règles à suivre pour écrire du code, des
tests, des spécifications et des messages de commit dans ce dépôt.

## 1. Structure du dépôt

| Chemin                         | Rôle                                                        | Licence    |
|--------------------------------|-------------------------------------------------------------|------------|
| `src/`                         | Implémentation du langage en Lean 4                         | CECILL-2.1 |
| `tests/`                       | Tests en Lean 4 (un fichier de test par module)             | CECILL-2.1 |
| `spec/`                        | Spécifications en org-mode (ajoutées a posteriori)          | CC-BY-4.0  |
| `LICENSES/`                    | Textes complets des licences (gérés par `reuse download`)   | —          |
| `.github/workflows/`           | Intégration continue (vérification REUSE)                   | CECILL-2.1 |
| `.claude/`                     | Consignes pour les contributeurs et les agents              | CECILL-2.1 |
| `lakefile.lean`                | Configuration Lake (bibliothèque, exécutable de tests)      | CECILL-2.1 |
| `lean-toolchain`               | Version de Lean fixée                                       | CECILL-2.1 |
| `REUSE.toml`                   | Licences des fichiers qui ne peuvent pas porter d'en-tête   | CECILL-2.1 |
| `LICENSE`                      | Présentation des licences, en français                      | —          |
| `README.md`, `CHANGELOG.md`    | Documentation du projet                                     | CECILL-2.1 |

Les bibliothèques écrites **dans le langage k7pl** (et non en Lean) sont
recommandées sous `CECILL-C` (copyleft faible), voir `LICENSE`.

## 2. Conventions de nommage

- Fichiers `.lean` : **CamelCase**, un module par fichier, le nom de fichier
  correspond au nom du module. Ex. `Parser.lean`, `TypeChecker.lean`.
  Sous-dossiers en CamelCase également : `src/Syntax/Lexer.lean` → module
  `Syntax.Lexer`.
- Fichiers de test : nom du module testé suivi de `Test`.
  Ex. `src/Parser.lean` → `tests/ParserTest.lean`.
- Fichiers `.org` : **kebab-case**. Ex. `syntax-rules.org`, `type-system.org`.
- Identifiants Lean : `lowerCamelCase` pour les fonctions et valeurs
  (`parseExpr`, `testHello`), `UpperCamelCase` pour les types, structures,
  classes et espaces de noms (`Expr`, `TypeEnv`).

## 3. En-têtes REUSE

Chaque fichier commence par un en-tête SPDX avec l'année et le nom de
l'auteur. Pour tous les fichiers : `SPDX-FileCopyrightText: <année> Cyprien PIERRE`
(ou le nom de la personne qui contribue).

| Extension / fichier                         | Préfixe de commentaire | Identifiant SPDX | Exemple d'en-tête |
|---------------------------------------------|------------------------|------------------|-------------------|
| `.lean`                                     | `--`                   | `CECILL-2.1`     | voir ci-dessous   |
| `.org` (dans `spec/`)                       | `#`                    | `CC-BY-4.0`      | voir ci-dessous   |
| `.yaml`, `.yml`, `.toml`                    | `#`                    | `CECILL-2.1`     | voir ci-dessous   |
| `.md`                                       | `<!-- … -->`           | `CECILL-2.1`     | voir ci-dessous   |
| `.gitignore`, `.gitattributes`, `.editorconfig` | `#` + `REUSE.toml` | `CECILL-2.1`     | voir ci-dessous   |
| `lean-toolchain`, `lake-manifest.json`      | aucun → `REUSE.toml`   | `CECILL-2.1`     | entrée `[[annotations]]` |
| Bibliothèque écrite en k7pl                 | selon la syntaxe       | `CECILL-C`       | —                 |

Lean 4 :

```lean
-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1
```

org-mode (`spec/`) :

```org
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CC-BY-4.0
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

## 4. Ajouter un module `.lean`

1. Créer `src/<Module>.lean` (CamelCase) avec l'en-tête SPDX CECILL-2.1.
2. Déclarer le contenu dans `namespace <Module>` … `end <Module>`.
3. Créer `tests/<Module>Test.lean` avec l'en-tête SPDX et des fonctions
   `test…` qui renvoient `Bool`.
4. Appeler ces tests depuis `tests/MainTest.lean` (fonction `main`).
5. Mettre à jour `lakefile.lean` si nécessaire : un module de premier niveau
   qui n'est importé par aucun autre doit être ajouté à `roots` de
   `lean_lib K7pl` (sinon `lake build` ne le compile pas).
6. Ajouter une ligne dans `CHANGELOG.md`, section `[Unreleased]`.
7. Vérifier : `lake build && lake test && reuse lint`.

## 5. Ajouter une spécification `.org`

Uniquement sur demande : les spécifications sont ajoutées a posteriori.

1. Créer `spec/<sujet>.org` (kebab-case) avec l'en-tête SPDX **CC-BY-4.0**.
2. Structure :

   ```org
   # SPDX-FileCopyrightText: 2026 Cyprien PIERRE
   #
   # SPDX-License-Identifier: CC-BY-4.0

   #+TITLE: Règles de syntaxe
   #+LANGUAGE: fr

   * Règles de syntaxe
   ** Expressions
   Texte explicatif.

   #+BEGIN_SRC k7pl
   let x = 1
   #+END_SRC
   ```

3. Ajouter une ligne dans `CHANGELOG.md` (type `docs`).

## 6. Style Lean 4

- Ordre dans un fichier : en-tête SPDX, ligne vide, `import`, `open`, puis
  `namespace`. Les `import` doivent précéder toute autre commande.
- Un `import` par ligne, triés : bibliothèque standard d'abord, puis les
  modules du projet.
- `open` limité au strict nécessaire ; préférer `open X in` pour un usage local.
- Tout le contenu d'un module dans `namespace <Module>` … `end <Module>`.
- Indentation de 2 espaces, pas de tabulations, lignes de 100 caractères au plus.
- Docstrings `/-- … -/` sur toutes les définitions publiques ; commentaires
  de module `/-! … -/` en tête de fichier après les imports si utile.
- Définitions internes marquées `private`.
- Pas de `sorry` dans le code fusionné.

## 7. Style org-mode

- Un seul titre de premier niveau (`*`) par fichier, reprenant `#+TITLE`.
- Sous-sections avec `**`, `***` ; pas de saut de niveau.
- Blocs de code : `#+BEGIN_SRC <langage>` … `#+END_SRC` (en majuscules),
  toujours avec le langage indiqué (`k7pl`, `lean`, `ebnf`…).
- Mots-clés TODO autorisés : `TODO`, `DRAFT`, `DONE`
  (`#+TODO: TODO DRAFT | DONE` en tête de fichier si utilisés).
- Indentation de 2 espaces, une phrase par ligne conseillée pour des diffs lisibles.

## 8. Conventional Commits

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

## 9. Checklist avant commit

- [ ] En-tête SPDX présent et correct
- [ ] Identifiant SPDX valide (`CECILL-2.1`, `CC-BY-4.0`, `CECILL-C`)
- [ ] Copyright avec année et nom
- [ ] Fichier dans le bon dossier
- [ ] Test associé si nouveau module
- [ ] `CHANGELOG.md` mis à jour
- [ ] Message de commit conforme Conventional Commits
- [ ] `lake build`, `lake test` et `reuse lint` passent
