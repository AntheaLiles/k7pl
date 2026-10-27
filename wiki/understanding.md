<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Understanding K7PL

> **Provenance — Lot 1 (pilot).**
> Consolidated 2026-10-25 from `docs/README.md` and
> `docs/ARCHITECTURE.md`, on `main` at
> `c56c84509812abe49cd716832f7ccdb750613036`.
> Status: living and canonical for project understanding and repository
> organisation. Normative language requirements remain in `spec/`.
> Open point: the interactive exploration and navigation-graph work is
> summarised here only at the level stated in the sources; its detailed
> tracking pages are not consolidated in this lot.

## What K7PL is

K7PL is a programming language whose implementation is written in Lean 4,
with Mathlib and CSLib, and whose specification is written in Verso. It
is a research project, not a production language. Its central question
is how a language can be designed so that the commitments made in its
specification can be represented, analysed, formalised, implemented, and
verified without silently changing their meaning between stages.

The project separates, deliberately, what it specifies from what it
formalises, implements, proves, and tests. That separation is the point:
each stage produces a different kind of evidence, and no stage's success
is allowed to stand in for another stage's result. See the authority
rules in [HOME](HOME.md).

## The chain, and what each arrow does not guarantee

```
Scientific question
        │
        ▼
  Specification
        │
        ▼
  Formalisation
        │
        ▼
  Implementation
     /       \
    ▼         ▼
 Proofs      Tests
     \       /
      ▼     ▼
   Assurance
```

- The **specification** states normative commitments.
- **Formalisation** represents selected formalisable commitments in
  Lean. It is a representation, not a replacement.
- **Implementation** is the executable realisation. Its behaviour is
  evidence about the implementation; it does not redefine the
  specification.
- **Proofs** establish mathematical propositions, in the formal system
  in which they were checked.
- **Tests** provide computational evidence about the behaviour actually
  exercised.
- **Assurance** is the argument that connects these kinds of evidence,
  within an explicitly bounded scope. It is not a declaration of
  absolute correctness.

The arrows above indicate intended relationships, not automatic
guarantees. In particular, this architecture does not establish that
every specification commitment is formalised, that the implementation
conforms to the specification, or that every scientific claim is
proved. Those are open assurance questions, now consolidated in [assurance](assurance.md); the CI-generated status remains in `docs/STATUS.md`.

## Repository layers

"Repository layers" here means parts of the repository. They are not
the language layers L1, L2, L3 — see [layers](layers.md) for that
distinction, which is the single most common source of confusion in
this project.

| Part | Location | Role |
| --- | --- | --- |
| Normative specification | `spec/` | Authoritative language specification |
| Experimental exposition | `spec/formal-chain/` | Verso Blueprint exposition of the experimental K → Lean chain, separate from the normative `spec/Spec/` |
| Formalisation and implementation | `src/` | Lean formal representation and executable implementation; `src/k/` builds the K definitions of `lexicon/` |
| K definitions | `lexicon/` | Every `.k` file of the project: the lemmas (`lexemes/`), the structure rules and syntactic sugar (`syntax/`), the non-normative K7OS model (`models/`); the `K` blocks of `spec/` display them |
| Experimental K → Lean proofs | `proofs/` | Separate Lake package for the experimental K → Lean chain; KLean-generated modules are built in CI and are not tracked |
| Tests | `tests/` | Executable behavioural checks |
| Specification tooling | `tools/` | Verso generator and extensions; the isolated Paperproof extraction workspace (`tools/paperproof-export/`); the non-normative B/C/D annex prototypes (`tools/prototypes-bcd/`); the checker of K7PL texts against the grammar of the layers (`tools/layer-check/`) |
| Auxiliary tooling | `scripts/` | Maintenance, analysis, CI support |
| Example library | `lib/` | Example K7PL library file (`lib-example.k7`) |
| Scientific documentation | `wiki/` (this folder) | Consolidated project documentation, replacing `docs/` lot by lot |
| Historical material | git history, traced in the migration matrix | Dated historical records. The former `docs/archives/` and `docs/history/` directories were closed in 2026-10-25: their verified content was integrated into `spec/`, `scripts/`, `tools/` or this wiki, or explicitly abandoned, and each action is traced in the migration matrix. |
| Automation | `.github/` | CI, security, release, repository automation |
| Agent infrastructure | `.claude/` | Agent rules, skills, agents |

## Reading paths

- **Understand the language:** this page, then
  [layers](layers.md), then [research](research.md), then the
  specification in `spec/`.
- **Understand the research:** [research](research.md), then the
  specification's reading guide (`spec/Spec/C1/ReadingGuide.lean`)
  for the fixed meanings of postulate, theorem, commitment, and reading.
- **Work on the project:** [method](method.md) for the working
  method, and the repository `CONTRIBUTING.md` for contribution
  rules.
- **Assess the current state:** [assurance](assurance.md) for the
  assurance case, and the CI-generated `docs/STATUS.md` (do not edit
  it by hand) for the generated status, until that status has its
  own wiki successor.

## Interactive exploration

K7PL is also developing an interactive presentation and exploration
layer, whose purpose is to make relationships between specification,
formalisation, implementation, proofs, tests, documentation,
bibliography, decisions, and history navigable. It is not a replacement
for the repository's canonical sources. Its vision, in short: a
presentation and exploration layer above the existing sources, not a
new source of truth; it aims at neither a global Markdown-to-MDX
migration nor a web framework in Lean; its purpose is to make an
assumed complexity explorable, without masking it or artificially
simplifying it. Its development is gated by a demonstration of value
on a real comprehension path.

### Navigation model

No single global structure currently links definition, theorem,
proof, code and tests with a typed relation, a provenance and a
distinct validation status — that is the gap the navigation work
addresses, not a claim that the gap is closed. The model that
governs it, consolidated here from the former semantic model:

- A node's identity rests on its stable Verso label, never on its
  displayed number.
- Edges are typed (`references`, `cites`, `declared-in`,
  `renders-to`, `generated-from`, `imports`, `tested-by`), with
  provenance and a validation state.
- An edge's validation state and its target's epistemic status are
  two distinct dimensions.
- `tested-by` (and likewise `implemented-by`) is never produced by
  a heuristic on file names, imports or file proximity: a missing
  relation is better than a plausible undemonstrated one.
- A citation does not become a premise, and a Verso reference does
  not become a proof dependency.
- The generator contract for the bounded C6/C3 views lives in
  `scripts/ci/navigation_graph/README.md`, not here: that README
  is the technical documentation of the component while it is
  active.

The figure provenance catalogue is generated during the build and
validated in CI: 12 figures declared, with links to the Verso
declaration, the TikZ source, the SVG and PDF renders, the renderer
and the workflow, and GitHub links pinned to the build revision.

### Proof visualisation

Proof visualisation follows a four-level architecture: source
verified by the kernel; extracted observations; rendered view;
editorial explanations identified as such. Two rules follow: a
missing or unsupported view must never be read as a missing or
unverified proof, and no relation between a normative statement and
a declaration is inferred from similar names or file proximity.
The validated corpus, at its last state (Paperproof extraction
under Lean 4.34.0, five declarations, with 2, 2, 5, 17 and 8 tactic
observations respectively), carries its own limit: one validated
example per tactic family is not validation of all variants, and an
extractor's output does not prove the semantic interpretation of
each branch link. A successful extraction and rendering prove that
the artefacts were produced and compiled, not that the
visualisation is faithful, readable or useful.

### Still open, carried by the roadmap sections

The following gates are not closed by this section, and their work
is carried by the roadmap sections named in [roadmap](roadmap.md)
("Build the interactive exploration envelope", "Validate the
navigation prototype with users", "Complete the proof
visualisation"), after the tracking files that once carried them
were deleted in the complete tracking, review and method closing
of 2026-10-25: the preregistered user
comparison (8 readers, one task, published raw times and failures,
with decision thresholds on accuracy and time); the human review of
the 12 TikZ figures; PDF/UA validation; the remaining user stories
and the final phase. Only the comparison's result will authorise
extending the graph; until then, the navigation and proof
visualisation files kept are a backlog and a proof dossier, not
consolidated knowledge.

## What was dropped or corrected in consolidation

- The entry path in the old `docs/README.md` listed many individual
  tracking pages (interactive exploration, navigation prototype,
  proof visualisation) as if they were entry points. They are kept as
  interim references above, but they are not entry points of this wiki:
  entry points are understanding, layers, research, and the
  specification itself.
- A duplicated sentence in the old `docs/README.md` (the closed
  figure-sheet audit and TikZ proof of concept, stated twice) is
  removed; the underlying historical fact is preserved for the later
  provenance lot, not repeated here.
- The old `docs/README.md` and `docs/ARCHITECTURE.md` carried
  "Last updated" headers (2026-10-13 and 2026-10-14) that did not match
  their last commits. This page replaces those headers with the
  provenance block above, which names the consolidation date and the
  base commit instead of an unverified update date.
