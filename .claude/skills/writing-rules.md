<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# k7pl writing rules

This document gathers all the rules to follow when writing code, tests,
specifications and commit messages in this repository.

## 1. Repository structure

| Path                           | Role                                                            | License    |
|--------------------------------|-----------------------------------------------------------------|------------|
| `src/Main.lean`                | Historical entry point (`Main.hello`)                           | CECILL-2.1 |
| `src/K7pl.lean`                | Library root: imports every `K7pl.*` module                     | CECILL-2.1 |
| `src/K7pl/`                    | Implementation of the language in Lean 4 (Mathlib, CSLib)       | CECILL-2.1 |
| `tests/`                       | Lean 4 tests (one `<Module>Test.lean` file per module)          | CECILL-2.1 |
| `spec/Spec.lean`               | Root of the Verso specification: title, `{texsetup}`, inclusion of the chapters | CC-BY-4.0  |
| `spec/Spec/<Ch>.lean`          | One chapter (`C1`…`C7`, `Refs`, `AnnexA`…`AnnexD`): title, `{refsection}`, introduction, `{include}` of the sections | CC-BY-4.0  |
| `spec/Spec/<Ch>/<Section>.lean` | One level-2 section: its subsections (`#`, `##`…) and its blocks | CC-BY-4.0  |
| `spec/figures/`                | Figures: canonical TikZ sources in `tikz/` (with `manifest.json`), from which `<name>.svg` (HTML) and `<name>.pdf` (PDF) are generated and not tracked; `sources/` keeps the former drawio and mermaid sources | CC-BY-4.0  |
| `spec/CHANGELOG.md`            | Specification versions (`spec-vX.Y.Z` releases)                | CC-BY-4.0  |
| `wiki/`                        | Canonical project documentation and generated status views     | CC-BY-4.0  |
| `tools/SpecMain.lean`          | Specification generator (`lake exe spec`)                       | CECILL-2.1 |
| `tools/SpecExt/`, `tools/SpecExt.lean` | Verso extensions of the specification (cross-references, statements, formulas, figures, citations…) | CECILL-2.1 |
| `tools/SpecBib.lean`           | Bibliography, **generated** by `scripts/biblio/biblio.py`       | CECILL-2.1 |
| `wiki/references.json`            | Cited-work metadata consumed by the bibliography pipeline  | CC-BY-4.0  |
| `LICENSES/`                    | Full license texts (managed with `reuse download`)              | —          |
| `scripts/`                     | Bibliography generation, metrics, CI checks and maintenance   | CECILL-2.1 |
| `zenodo.json`, `zenodo.files.json` | Zenodo metadata (shared, per PDF) — via `REUSE.toml`        | CECILL-2.1 |
| `.github/workflows/`           | CI: build/tests/lint/axioms, Pages, REUSE, commits, security    | CECILL-2.1 |
| `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md` | Issue and PR templates | CECILL-2.1 |
| `.github/dependabot.yml`       | GitHub Actions updates                                          | CECILL-2.1 |
| `.claude/`                     | Instructions and session hook for agents                        | CECILL-2.1 |
| `lakefile.lean`                | Lake configuration (libraries, executables, dependencies)       | CECILL-2.1 |
| `lake-manifest.json`           | Exact revisions of the dependencies (via `REUSE.toml`)          | CECILL-2.1 |
| `lean-toolchain`               | Pinned Lean version (via `REUSE.toml`)                          | CECILL-2.1 |
| `.commitlintrc.yaml`           | Configuration of the Conventional Commits lint                  | CECILL-2.1 |
| `REUSE.toml`                   | Licenses of the files that cannot carry a header                | CECILL-2.1 |
| `LICENSE.md`                   | Overview of the licenses, in French                             | —          |
| `README.md`, `CHANGELOG.md`    | Project documentation                                           | CECILL-2.1 |
| `CONTRIBUTING.md`, `SECURITY.md` | Contribution workflow, vulnerability reporting                | CECILL-2.1 |
| `CODE_OF_CONDUCT.md`           | Contributor Covenant 2.1 (French translation)                   | CC-BY-4.0  |
| `CITATION.cff`                 | How to cite the specification (Zenodo DOI)                      | CECILL-2.1 |

Dependencies (all pinned to the version in `lean-toolchain`):

- **Mathlib**: mathematics and tactics (`ring`, `simp`, `omega`…).
- **CSLib**: foundations of computer science (LTS, lambda calculus, relations…).
- **Verso**: writing the specification (`Manual` genre).

Libraries written **in the k7pl language** (not in Lean) are
recommended under `CECILL-C` (weak copyleft), see `LICENSE.md`.

## 2. Languages

- **French** only for the specification (`spec/`).
- **English** for everything else: all source code (identifiers, docstrings,
  comments, displayed messages, test names, scripts and workflows), the
  documentation (README, CONTRIBUTING, SECURITY, CHANGELOG, these writing
  rules), tracking, agent, rule and skill files, issues and PRs.
- Commit messages: English, in the Conventional Commits format (§9).
- Strings rendered into the specification (Verso extensions, generated
  bibliography, navigation texts) follow the specification and stay in French.
- File names: English.
- Historical and evidence records that remain in the repository are not
  translated. Analyse and arbitrate each before moving or deleting it, and record
  the destination or reason for removal.

## 3. Naming conventions

- `.lean` files (code, tests **and** Verso specifications): **CamelCase**,
  one module per file, the file name matches the module name.
  E.g. `src/K7pl/Parser.lean` → module `K7pl.Parser`,
  `spec/Spec/SyntaxRules.lean` → module `Spec.SyntaxRules`.
- Test files: name of the tested module followed by `Test`, at the root of `tests/`.
  E.g. `src/K7pl/Parser.lean` → `tests/ParserTest.lean` (module `ParserTest`).
  Do not create a test module under `K7pl.*`: that prefix belongs to `src/`.
- Lean identifiers: `lowerCamelCase` for functions and values
  (`parseExpr`, `testHello`), `UpperCamelCase` for types, structures,
  classes and namespaces (`Expr`, `TypeEnv`). Theorems in `snake_case`,
  as in Mathlib (`eval_double`).

## 4. REUSE headers

Every file starts with an SPDX header giving the year and the author's
name: `SPDX-FileCopyrightText: <year> Cyprien PIERRE` (or the name of the
person contributing).

| File                                            | Comment prefix          | SPDX identifier  |
|-------------------------------------------------|-------------------------|------------------|
| `.lean` in `src/`, `tests/`, `tools/`, root     | `--`                    | `CECILL-2.1`     |
| `.lean` in `spec/` (Verso)                      | `--`                    | `CC-BY-4.0`      |
| `.yaml`, `.yml`, `.toml`                        | `#`                     | `CECILL-2.1`     |
| `.md`                                           | `<!-- … -->`            | `CECILL-2.1`     |
| `.gitignore`, `.gitattributes`, `.editorconfig` | `#` + `REUSE.toml`      | `CECILL-2.1`     |
| `lean-toolchain`, `lake-manifest.json`          | none → `REUSE.toml`     | `CECILL-2.1`     |
| Library written in k7pl                         | according to the syntax | `CECILL-C`       |

Lean 4 (code):

```lean
-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC0-1.0
```

Verso (`spec/`):

```lean
-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0
```

YAML, TOML, Git configuration files and EditorConfig:

```yaml
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CC0-1.0
```

Markdown:

```markdown
<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->
```

File that cannot hold a comment: add it to `REUSE.toml`

```toml
[[annotations]]
path = "path/to/the/file"
precedence = "aggregate"
SPDX-FileCopyrightText = "2026 Cyprien PIERRE"
SPDX-License-Identifier = "CECILL-2.1"
```

Every new license used must have its text in `LICENSES/`:
`reuse download <IDENTIFIER>`. Check with `reuse lint`.

## 5. Adding a `.lean` module

1. Create `src/K7pl/<Module>.lean` (CamelCase) with the CECILL-2.1 SPDX header.
2. Declare the content in `namespace K7pl.<Module>` … `end K7pl.<Module>`.
3. Add `import K7pl.<Module>` to `src/K7pl.lean`.
4. Create `tests/<Module>Test.lean` with the SPDX header:
   - compile-time checks (`#guard`, `#guard_msgs`, `example`);
   - property tests with `plausible` when an invariant lends itself to it;
   - a list `def tests : List (String × Bool)` run by `lake test`.
5. Update `lakefile.lean`: add `` `<Module>Test `` to the `roots` of
   `lean_lib K7plTests`, then import the test module in
   `tests/MainTest.lean` and concatenate its `tests` list.
6. For a new dependency: `require` in `lakefile.lean`, then
   `lake update <package>` and commit `lake-manifest.json`.
7. Add a line to `CHANGELOG.md`, section `[Unreleased]`.
8. Check: `lake build && lake test && lake lint && reuse lint`.

Import Mathlib and CSLib **module by module** (`import Mathlib.Tactic.Ring`),
never `import Mathlib` or `import Cslib` as a whole: compilation stays fast.

## 6. Writing in the specification (Verso)

The specification is written in [Verso](https://github.com/leanprover/verso), `Manual` genre.
These are Lean files: `lake build` compiles them, and any error (cross-reference to an unknown
label, missing bibliography key, invalid markup) makes compilation or rendering fail.

**The manuscript carries the instruction « ne rien modifier sans l'accord de l'auteur »**
("change nothing without the author's consent"): its text is corrected only on request, by the
smallest change, and the change is recorded (tracking card, log).

### Structure

- `spec/Spec.lean` includes the chapters in document order; each chapter `Spec/<Ch>.lean`
  opens a bibliography section (`{refsection "c3-types"}`), carries its introduction, then
  `{include 0 Spec.<Ch>.<Section>}` for each of its sections; the module of its **last**
  section ends with `{bibliography}` (the list of the works cited in the chapter).
- A section module starts with `#doc (Manual) "Title" =>`, then a `%%%` metadata block
  (`file := "…"`: name of the HTML page; `tag := "…"`: canonical, stable name of the
  section; `number := false` for the annexes, whose number (`A.`, `A.1.`) is written in the
  title), then `{label "sec:…"}` if the section is referenced.
- Name a new module in ASCII CamelCase, without accents; add its `import` and its
  `{include}` to the chapter module.

### Specification extensions (`tools/SpecExt/`)

| What to write | Role |
|---|---|
| `{num "sec:x"}[]` | numbered cross-reference, link to the object (section, statement, formula, figure, table, listing) — replaces `\ref` |
| `{label "sec:x"}` | label of the current section (`(display := "A.1")` forces the displayed number) |
| `{cite "KEY1,KEY2"}[]` | numeric citation `[3, 5–7]`, numbered per chapter (`{refsection}`); the key must exist in `wiki/references.json` |
| `::::theorem (label := "thm:x") (scope := "metatheory")`, and its sibling directives | statement: definition, premise, result, requirement, result from the literature, example; see "Statements: specialised directives" below |
| `::::thm (label := "thm:x") (status := …) (level := …)` | **historical**, kept for compatibility; `spec/` no longer uses it. `status`: `theoreme`, `proposition`, `conjecture`, `definition`, `exigence`, `litterature` |
| `::::formula (label := "eq:x") (kind := "formule")` | formula(s): code blocks containing mathematical LaTeX, `:::caption` |
| `::::figure (label := "fig:x") (src := "name") (alt := "…") (width := "90")` | figure `spec/figures/name.{svg,pdf}`; slots `:::caption`, `:::desc`, `:::note`, `:::source` |
| `::::k7table (label := "tab:x") (align := "lZ{1.0}")` | captioned table around a `:::table +header`; `align`: `tabularx` columns of the PDF |
| `::::listing (label := "lst:x")` | captioned source code |
| `{rmq}[…]` | numbered margin note ("RMQ n.") |
| `{sc}[…]` | small capitals |
| `{listof "figure"}` | list of figures, `"table"`, `"formule"`, `"listing"` |
| `{printindex}` | index with pages (PDF) and with sections (HTML); the terms of `tools/SpecExt/IndexTerms.lean` are recognised in the text at generation time (`SpecExt.AutoMark`), without hand markup |
| `{idx "term"}[text]`, `{gloss "definition"}[text]` | marks placed by the automatic recognition (index, glossary tooltip); not written by hand |
| `:::comment` + code block | author's comment, kept in the source, never rendered |
| `{missing "label"}[]` | unresolved cross-reference of the original manuscript, printed `??` — to be replaced by `{num}` as soon as the label exists |

Labels follow `sec:`, `thm:`, `eq:`, `fig:`, `tab:`, `lst:`. A corrected statement **changes its
seal** (its `role` or its `state`); it neither loses its label nor is renumbered by hand:
each role (or each kind, for an object without a role) has its own counter, which follows the
document order; the former `::::thm` blocks shared a single counter.

#### Statements: specialised directives

All statement directives share an internal representation (`StatementInfo`, in
`tools/SpecExt/Theorem.lean`) and the same validation. They separate the kind of the object, its
role, its epistemic state, its support and its scope. Contract taken from
`docs/tracking/LEAN-STATEMENT-ONTOLOGY-IMPLEMENTATION.md`, deleted after integration (last
version:
[`2bdb06e`](https://github.com/AntheaLiles/k7pl/blob/2bdb06e5e42857cef5c2f9084f6b6b7245bed46b/docs/tracking/LEAN-STATEMENT-ONTOLOGY-IMPLEMENTATION.md));
the decisions it rests on are in `docs/tracking/DECISIONS.md` (C8 taxonomy, 9 October 2026).

| Directive | Kind (`kind`) | Default role | Default state | Numbered | Label |
|---|---|---|---|---|---|
| `::::theorem`, `::::lemma`, `::::corollary`, `::::proposition` | `result` | the directive's name | `under-review` | yes | required |
| `::::conjecture` | `result` | `conjecture` | `proposed` | yes | required |
| `::::axiom`, `::::postulate` | `assumption` | `axiom`, `postulate` | `under-review` | yes | required |
| `::::hypothesis` | `assumption` | `hypothesis` | `under-review` | no | optional |
| `::::definition` | `definition` | — | `not-applicable` | yes | required |
| `::::requirement` | `requirement` | — | `not-applicable` | yes | required |
| `::::literature` | `literature` | — | `not-applicable` | yes | required |
| `::::example`, `::::counterexample` | `example`, `counterexample` | — | `not-applicable` | no | optional |

Arguments, all named:

- `label`: a `thm:…` label;
- `scope`: **mandatory**, closed vocabulary: `syntax`, `metatheory`, `graphs`, `resources`,
  `memory-safety`, `security`, `operational-semantics`, `graded-typing`, `effects`,
  `logical-relations`, `translation`, `fixed-points`, `interoperability`, `concurrency`,
  `ffi-safety`, `representation`, `compiler-interface`, `compilation`, `resource-accounting`,
  `literature`, `runtime`. A scope label is not a guarantee: the hypotheses and the limits
  stay in the text of the statement;
- `state`: `proposed`, `under-review`, `supported`, `established`, `refuted` or `withdrawn` for a
  result or a premise; `not-applicable` for any other object. Role and state are
  independent;
- `evidence`: `none` (default), `written-proof`, `proofsketch`, `literature`, `computation`,
  `counterexample`, `lean-proof`. A written proof, a sketch and a Lean proof are
  three distinct things;
- `role`: replaces the default role, if it is compatible with the kind;
- `source`: bibliographic provenance, mandatory for `::::literature` and with
  `evidence := "literature"`;
- `formalArtifact`: verified Lean declaration (`Module.declaration`), mandatory with
  `evidence := "lean-proof"` and refused otherwise;
- `level`: historical domain (`langage` by default, `compilation`, `representation`,
  `deploiement`), kept as is; it is not the scope;
- `+unnumbered`: local unnumbered object.

Slots: `:::title`; `:::statement`, or `:::statement +titled`, whose first paragraph becomes
the statement's title; `:::proofsketch`; `:::note`, like any other slot, rendered as a plain
paragraph. Text placed outside a slot is not rendered.

```text
::::theorem (label := "thm:example") (state := "under-review") (evidence := "proofsketch") (scope := "metatheory")
:::title
Short title
:::
:::statement
The text of the statement.
:::
:::proofsketch
The argument, explicitly incomplete.
:::
::::
```

**Compile-time validation** (`lake build Spec`). The following are refused:

- a numbered object without a label;
- a state, an evidence type or a scope outside the vocabulary, or a missing scope;
- a result or a premise without an epistemic state, or another object whose state is not
  `not-applicable`;
- a role incompatible with the kind, or a conjecture marked `established`;
- a result from the literature without `source`;
- `lean-proof` without `formalArtifact`, or `formalArtifact` without `lean-proof`;
- `proofsketch`, `written-proof` or `lean-proof` on an object that is not a result;
- a hypothesis with `global` scope.

**Ontology check** (`scripts/spec_checks/statement_ontology.py`, run by
`scripts/check_spec.py`). It repeats these rules and adds:

- `evidence := "proofsketch"` requires a `:::proofsketch` slot; that slot is only allowed with
  `evidence` equal to `proofsketch` or `literature`;
- text outside a slot is refused.

**Limits.** These checks are structural. They validate neither a proof, nor the adequacy of a
sketch, nor the attachment of a hypothesis to the argument it qualifies. The presence of `source`
is required, not its bibliographic resolution. No metadata replaces a proof: moving a
statement to `established`, changing its role or declaring `lean-proof` is a change of
scientific status, which requires the author's agreement and, for `lean-proof`, the tested formal
artefact.

### Checking

1. `lake build Spec` (compilation; warnings are errors).
2. `lake exe spec --output _out/spec --with-tex` (rendering; an unknown cross-reference or key makes it fail).
3. `python3 scripts/manuscript_metrics.py summary`, and `python3 scripts/suivi.py all` if tracking cards changed state.
4. Add a line to `spec/CHANGELOG.md` (commit of type `docs(spec)`).

The bibliography: adding a work = adding its record to `wiki/references.json` (fields of
`scripts/biblio/biblio.py`), then `python3 scripts/biblio/biblio.py lean wiki/references.json
tools/SpecBib.lean`.

## 7. Lean 4 style

The rules follow Mathlib's; the Mathlib linters (`mathlibStandardSet`)
are active on `src/`, and any warning makes compilation fail
(`warningAsError`). `lake lint` (Batteries `runLinter`) additionally checks
missing docstrings and common defects.

Header and module documentation:

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

The sections come in this order; those without content are omitted
(`Notation` only if the module introduces notation, `References` only if there are any).

Docstrings:

- Every definition, structure, inductive, **constructor** and main theorem
  has a `/-- … -/` docstring; so do reusable lemmas.
- Complete sentence in English, ending with a period; following lines not indented.
- Write for the editor tooltip: concise, self-contained, complementing the signature
  without paraphrasing it.
- Every tactic, command or attribute defined in the project has a docstring.

Comments: explain the *why* (choice of representation, `WellFounded`
rather than fuel…), never the *what* that the type already expresses.

Proofs and axioms:

- No `sorry`/`admit` in merged code (blocked by `warningAsError`).
- No new `axiom`, no `native_decide`: the axiom audit in CI
  only accepts `propext`, `Classical.choice` and `Quot.sound` under `K7pl`.
- Separate definitions and proofs when a module grows
  (`K7pl/Foo/Defs.lean` for definitions, `K7pl/Foo/Basic.lean` for lemmas).
- Files of at most 1500 lines (`linter.style.longFile`), lines of at most 100 characters.

Layout:

- Order within a file: SPDX header, blank line, `import`, module documentation
  `/-! … -/`, `open`, then `namespace`. The `import`s must precede
  every other command.
- One `import` per line, sorted: external dependencies (Mathlib, Cslib, Verso)
  first, then the project's modules.
- `open` limited to what is strictly necessary; prefer `open X in` for a local use.
- All the content of a module inside `namespace K7pl.<Module>` … `end K7pl.<Module>`.
- 2-space indentation, no tabs, lines of at most 100 characters.
- Internal definitions marked `private`.
- No `sorry` in merged code.

## 8. Verso style and rewriting from Org-mode

Style:

- One file = one chapter = one `#doc (Manual) "Title" =>`.
- Section headings with `#`, `##`, `###` (relative to the chapter); no skipped level.
- One sentence per line: diffs stay readable, rendering is not affected.
- Every Lean code example goes in a ` ```lean ` block (checked); examples
  in k7pl syntax use a block without a language until a dedicated
  highlighter exists.
- Chapter metadata in a `%%%` block (e.g. `shortTitle := "…"`).


### Prohibited lexical family in the French specification

The lexical family registered in `scripts/spec_checks/vocabulary.py`, including its listed grammatical forms and derivatives, is prohibited in authored textual sources under `spec/`. The check is lexical, not a ban on matching character sequences: unrelated words such as `violet` remain valid.

Do not use a blind global replacement. Choose a context-sensitive formulation that preserves the technical claim and its epistemic status. Examples include `non-respect de l'invariant`, `exigence non satisfaite`, `écart au protocole`, `rejet à la compilation`, `cas inexprimable` and `absence de dérivation`, as appropriate to the actual meaning.

Do not change a formal statement's premises, conclusion, scope, seal (`state`/`role`) or evidence status as a side effect of lexical editing. For claims about declassification or non-interference, state exactly which property is retained, weakened or suspended and under what conditions. If no equivalent wording is clear, request author arbitration instead of inventing a substitute.

The rule is enforced by `scripts/check_spec.py` through `scripts/spec_checks/vocabulary.py`.

Org-mode → Verso correspondences, for rewriting the existing sources:

| Org-mode                              | Verso                                          |
|---------------------------------------|------------------------------------------------|
| `#+TITLE: Title`                      | `#doc (Manual) "Title" =>`                     |
| `#+AUTHOR: Name`                      | `%%%` `authors := ["Name"]` `%%%`              |
| `* Section`, `** Subsection`          | `# Section`, `## Subsection`                   |
| `/italic/`, `*bold*`                  | `_italic_`, `*bold*`                           |
| `=code=`, `~code~`                    | `` `code` ``                                   |
| `[[url][text]]`                       | `[text](url)`                                  |
| `- item`, `1. item`                   | `* item`, `1. item`                            |
| `#+BEGIN_SRC lean … #+END_SRC`        | ` ```lean … ``` ` (checked by Lean)            |
| `#+BEGIN_SRC k7pl … #+END_SRC`        | ` ``` … ``` `                                  |
| `#+BEGIN_QUOTE … #+END_QUOTE`         | `> quotation`                                  |
| `#+INCLUDE: "other.org"`              | `import Spec.Other` + `{include 0 Spec.Other}` |
| `\ref{label}`, `[[tab:x]]`, `\eqref{x}` | `{num "label"}[]`, `({num "x"}[])`          |
| `#+LATEX: \label{sec:x}` under a heading | `{label "sec:x"}` under the heading         |
| `[cite:@key;@key]`                    | `{cite "key,key"}[]`                           |
| `[rmq:text]`                          | `{rmq}[text]`                                  |
| `\textsc{x}`                          | `{sc}[x]`                                      |
| `#+NAME:` + `#+CAPTION:` + table      | `::::k7table (label := …)` + `:::caption` + `:::table +header` |
| `#+NAME:` + `#+CAPTION:` + `[[file.drawio]]` | `::::figure (label := …) (src := …)`    |
| `#+BEGIN_EXPORT latex` `\begin{theorem}[…]` | `::::theorem` (or the directive of its kind) + `:::statement` + `:::proofsketch` |
| `#+BEGIN_EXPORT latex` `\begin{align*}` + `\captionof{formule}` | `::::formula (kind := "formule")` |
| `# comment`                           | `:::comment` + code block                      |
| `#+PRINT_BIBLIOGRAPHY:`               | `{bibliography}`                               |
| `#+LATEX: \listoffigures`             | `{listof "figure"}`                            |
| `TODO` / `DRAFT` in a heading         | `-- TODO:` comment in the source               |

The former Org-to-Verso converter has been retired. Maintain the normative
specification in `spec/` and use the repository's Verso/Lake workflows to build
and validate its generated outputs.

## 9. Conventional Commits

Format: `<type>(<scope>): <description>`

- Messages are written in English.
- Description in the imperative mood (`add`, not `added` or `adds`), starting with a
  lower-case letter, without a final period.
- `scope`: module or area touched (`parser`, `typechecker`, `spec`, `ci`, `reuse`…), in lower
  case; chapter scopes are written in upper case (`C8`).
- Header (`<type>(<scope>): <description>`) of at most 100 characters.
- Types:

| Type        | Use                                                |
|-------------|----------------------------------------------------|
| `feat`      | new feature                                        |
| `fix`       | bug fix                                            |
| `docs`      | documentation, specifications                      |
| `style`     | formatting without behaviour change                |
| `refactor`  | restructuring without behaviour change             |
| `perf`      | performance improvement                            |
| `test`      | adding or fixing tests                             |
| `build`     | Lake, toolchain, dependencies                      |
| `ci`        | continuous integration                             |
| `chore`     | miscellaneous maintenance                          |
| `revert`    | reverting an earlier commit                        |
| `licensing` | SPDX headers, REUSE, license texts                 |
| `a11y`      | accessibility                                      |

Examples:

```
feat(parser): add support for lambda expressions
fix(typechecker): fix the resolution of polymorphic types
docs(spec): document the annotation syntax
```

Breaking change: add `!` after the scope
(`feat(parser)!: …`) and a `BREAKING CHANGE: …` footer.

The format is checked in CI by commitlint (`.github/workflows/commitlint.yaml`,
configuration `.commitlintrc.yaml`, which extends `@commitlint/config-conventional`).
The configuration enforces the type list above, the scope case (lower case or upper case),
the 100-character header and the absence of a final period. It does not enforce the case of
the description (Dependabot writes "Bump …"), the length of body and footer lines, or the
language of the message. [`CONTRIBUTING.md`](../../CONTRIBUTING.md), section
"Commit messages", describes the same rules. Local check of the last commit:
`npx --yes -p @commitlint/cli -p @commitlint/config-conventional commitlint --from HEAD~1`.

## 10. Working with an agent (Claude Code)

- A patch is finished only if `lake build`, `lake test` and `lake lint` pass,
  locally or in CI: never declare it finished on review alone.
- Never invent a lemma name: check it (`#check`, `exact?`, search
  in the Mathlib/CSLib sources) before using it.
- Never introduce `sorry`, `axiom`, `native_decide`, nor disable a linter
  or a test to make CI pass.
- The main theorems (correctness statements of the language) are validated by
  a human: an agent may propose intermediate lemmas and proofs, but
  does not modify the statement of a main theorem without explicit agreement.
- The Claude Code roles are separate: spec architecture, spec editing,
  formal review, Lean proof, Lean implementation, diagnosis, cross-cutting consistency
  and verification. Do not use a general-purpose agent when a specialised role exists.
- For a task that spans `spec/` and `src/`, do not go straight from
  "request" to "code": first establish the contract and its dependencies, then have
  the consistency between specification, formalisation, proof, tests and documentation checked.
- The skills under `.claude/skills/` describe reusable procedures; the rules
  under `.claude/rules/` define the invariants; the agents under `.claude/agents/`
  define the roles and their model settings. The three levels are complementary.
- Touching `lakefile.lean`, `lean-toolchain` or `.github/workflows/` requires
  an explicit mention in the PR description.

## 11. Checklist before committing

- [ ] SPDX header present and correct
- [ ] Valid SPDX identifier (`CECILL-2.1`, `CC-BY-4.0`, `CECILL-C`)
- [ ] Copyright with year and name
- [ ] File in the right directory
- [ ] Only `spec/` in French; everything else (code, documentation, commit messages) in English
- [ ] Docstrings on new declarations, module documentation up to date
- [ ] Associated test if new module
- [ ] No `sorry`, no new axiom
- [ ] `CHANGELOG.md` updated
- [ ] Commit message follows Conventional Commits
- [ ] `lake build`, `lake test`, `lake lint` and `reuse lint` pass
