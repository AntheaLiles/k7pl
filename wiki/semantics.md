<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Formal semantics

This page carries the durable content of
`docs/formal-semantics.md` (deleted in the security,
decisions and docs-root closing of 2026-10-25): an
executable K semantics for an experimental sublanguage
of K7PL, its bridges to Lean, and the native-boundary
model. It is a prototype, not the normative semantics
of K7PL, and nothing here proves a correspondence with
the complete normative semantics.

## Prototype scope

The editable source of the definition is in `lexicon/`:
one file per lemma in `lexicon/lexemes/` (`literals.k`,
`add.k`, `lt.k`, `select.k`), composed by the module
`LEXICON` of `lexicon/lexicon.k`. The `K` blocks of
`spec/Spec/CodeArtifacts.lean` display these files, read
when the document is elaborated, and the extraction pass
refuses a K file of `lexicon/` that no block displays.
The Python block of the same page holds the checker for
the example programs: `lake exe spec --extract-code-only`
generates `src/k/.build/generated/check_k_examples.py`,
ignored by Git and not to be edited directly. The source programs are in `tests/examples/`
and use the `.k7` extension.

| Construct | K representation | Behaviour |
| --- | --- | --- |
| Integer literal | builtin `Int` | Integer value |
| Boolean literal | builtin `Bool` | Boolean value |
| `(+ e1 e2)` | `k7Add` | Strict integer addition, left to right |
| `(< e1 e2)` | `k7Lt` | Integer comparison |
| `(select c e1 e2)` | `k7Select` | Evaluates the condition, then selects a branch |
| Base types | `IntType`, `BoolType` | Partial classifier `typeOf` |

The examples run by CI are `(+ 1 (+ 2 3)) → 6` and
`(select (< 1 2) (+ 1 2) (+ 10 20)) → 3`.

## Bridges to Lean, and their exact limit

The maintained Lean proof project gives explicit
one-way bridges for each computational root rule in
this experimental subset. Source rule labels are the
labels in the editable Verso K definition; target
constructors are generated from the compiled K
definition by KLean.

| K rule | Generated KLean constructor | Lean evidence |
| --- | --- | --- |
| `k7AddEval` | `Rewrites.k7AddEval` | `K7PL.Bridge.add_root_is_klean_rewrite` |
| `k7LessThanEval` | `Rewrites.k7LessThanEval` | `K7PL.Bridge.less_than_root_is_klean_rewrite` |
| `k7SelectTrue` | `Rewrites.k7SelectTrue` | `K7PL.Bridge.select_true_root_is_klean_rewrite` |
| `k7SelectFalse` | `Rewrites.k7SelectFalse` | `K7PL.Bridge.select_false_root_is_klean_rewrite` |

These results establish the listed root transitions
over complete generated configurations. They do **not**
yet establish a general simulation theorem for every
expression-level `SurfaceStep`, including all
evaluation-context and continuation transitions. The
generated `Rewrites` relation has a separate
preservation theorem for `MachineTyping`; this does
not, by itself, prove that the K classifier `typeOf`
is equivalent to the Lean judgment `HasType`. The
broader relation, including source contexts, remains
an explicit proof obligation. A green build or a
successful example run does not discharge it.

## Reproduce

From the repository root, with K available:

```sh
make k-check
krun --definition src/k/.build/kompiled tests/examples/add.k7
```

To also run the export to Lean, the proofs and the
Verso exposition, with `klean` `kframework==7.1.337`
and Lean `v4.34.0`:

```sh
make formal-chain
```

## Native boundary model (profile model, non-normative)

The separate model `lexicon/models/native-boundary.k`
(module `NATIVE-BOUNDARY`) is displayed by a `K` block of
the Verso page.
It compares three cases: a native call conforming to
its contract, a write refused under the abstract
hypothesis of an enforced boundary, and a native
write that modifies the protected state when no
boundary is enforced. This model adds no construction
to the normative grammar of K7PL and chooses no
hardware mechanism.

The same abstract transition is explored by TLC with
two configurations: the enforced-boundary
configuration must preserve protected integrity; the
negative configuration must produce a counterexample.
The negative witness is fixed on the value 1: initial
state (protected = 0, service = 0), action
NativeWrite(1), then state (protected = 1,
service = 0). Lean proves preservation for all finite
traces of the confined profile and replays this
witness explicitly in one step. CI also runs the
three K examples with the same values.

These results are corroborations from distinct
models, **not yet a K ↔ TLA+ simulation theorem and
not a proof that the model corresponds to the
complete normative semantics of K7PL**. The TLC
sources and logs are packaged with the K sources,
the Lean proofs and the Verso documentation in the
formal-semantics workflow. The TLA+ sources live in
`theoretical-projects/k7os/models/` (moved from
`docs/research/k7pl-os/models/` in the research
closing of 2026-10-25, with the workflows repointed);
they are executable models, not wiki or specification
content. The projection relation
between complete K configurations, TLA+ states and
`K7PL.NativeBoundary.State` remains explicitly open.

## Trust boundary

`klean` consumes the K definition compiled to KORE
and generates a `Rewrites` relation on complete K
configurations, including the auxiliary strictness
transitions (heat/cool) and the continuation frames.
The Lean package proves `preservation` and `progress`
for the expression relation `SurfaceStep` and the
preservation of `MachineTyping` for the generated
`Rewrites` relation of the sublanguage. The axiom
audit allows `[propext]` and forbids `sorryAx`.

The K function `typeOf` is not exported as `Rewrites`
rules; its correspondence with the structural Lean
judgment `HasType` remains to be proved. The result
does not formalise the fragments of resources,
grades, effects, actors, capabilities, or the
complete normative grammar. The KORE → Lean
translation, the hooked functions and the fidelity of
this definition to the specification are separate
trust obligations.
