<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Vocabulary

This is the dedicated page for the lexical, syntactic and semantic
research on K7PL's constituents — the long research work behind
the words, the forms and the meanings of the language. It is a
research page, not a normative page: it
records what is being evaluated, what is open, and what must
still be proved, and it is the entry point for the deep
evaluation work that is still in progress and must now advance
strongly. It does not replace the specification, and it does not
ratify a name or authorise a renaming on its own.

## Authority

- The normative language is stated in [`spec/`](../spec/) only.
  For a fact about the current language, start there, at the
  revision in force.
- The status of a choice is stated in
  [decisions](decisions.md): decided, open, or applied pending
  ratification. A historical note, a proposal in an archive, or
  a candidate word in a register is not a decision.
- This page and [primitives](primitives.md) are research
  material. They never establish a normative state on their
  own, and this page ratifies no naming choice and authorises
  no renaming.

## Three dimensions of the same work

A constituent of K7PL — a primitive, a form, a type former, a
grade, an effect — has to be evaluated on three dimensions at
once. A word that is good on one dimension can fail on another,
and that is why this research is long.

| Dimension | Question asked | Where it is worked on |
| --- | --- | --- |
| Lexical | Which word should name this constituent, in which namespace, without collision, and with what mnemonic and brevity cost? | [primitives](primitives.md) (candidate words, argument for and against each) |
| Syntactic | Which surface form, glyph or alias carries it, how does it parse, and how does it sit in the term grammar and the type grammar? | Term grammar and type grammar in `spec/` (C3); glyph table (C1/C5); the cross-check in `scripts/controles/croise.py` |
| Semantic | What does it mean — which typing rule governs it, which reduction, which model, which laws — and what is actually proved about it, as opposed to sketched? | Typing rules (C3), operational semantics (C4), Lean models in `src/` and `spec/`; [assurance](assurance.md) for the proof status of each claim |

The three dimensions must not be collapsed: lexical coverage
(a word exists for a rule) is not semantic traceability (the
rule's meaning is proved and linked to its formalisation).
The roadmap's stage H states this explicitly — it is currently
lexical coverage, not semantic traceability — and this page
keeps that distinction.

## Deep evaluation programme: what must now advance

The constituents evaluated above are not finished by being
listed. Each one must be carried through four kinds of deep
evaluation, and the work is still in progress on all four.
The sections of [roadmap](roadmap.md) named below are the
action lots that carry this programme out; this page does not
duplicate their items, it states the programme they serve.

1. **Formalisation in K.** The normative executable semantics
   (K → KLean → Lean) is the roadmap's stage N: open, framed,
   exit criteria not met, gates G1–G10 proposed, with C3/C4
   to be rewritten in K only under explicit specification
   mandates. A constituent is not formalised in K because its
   name appears in a register; it is formalised when its
   K definition, its syntax and its semantics are written
   and checked.
2. **Instrumentation in Lean, and in TLA+.** Lean
   instrumentation is the roadmap's stage K (Lean tools for
   project-compliance assurance, open, human decision
   pending) and the existing Lean models in `src/` and
   `spec/`, whose bridges to the operational rules are
   largely still open (see [assurance](assurance.md)).
   TLA+ instrumentation exists in CI for specific models
   (actor cancellation, native boundary), but the simulation
   between K configurations, TLA+ states and the native
   boundary state remains explicitly open in
   `docs/formal-semantics.md`: a checked TLA+ model is not,
   on its own, a proof that the model corresponds to the
   complete normative semantics.
3. **Proof linking.** Every constituent's claims must be
   linked, statement by statement, between the normative
   text, the Lean statement and the proof: which statement,
   which hypotheses, which evidence, which Lean lemma, and
   what gap remains. That is the roadmap's stage H and the
   gate-C work, and it is the difference between lexical
   coverage and semantic traceability. No statement moves
   to "proved" without a compiled Lean proof, without
   sorry/admit/new axiom/native_decide, with a clean axiom
   audit, and with an exact statement correspondence
   validated by the author.
4. **Theorem validation.** The theorems that use these
   constituents — substitution, preservation, progress,
   commutation, refinement, lowering — are, at the current
   state, sketches or open obligations, not established
   results (see [assurance](assurance.md) and the
   consolidated PR-03 review). Validating them means
   proving them for a stated fragment under stated
   hypotheses, or explicitly restricting or requalifying
   the claim — never silently strengthening it, and never
   presenting a sketch as a proof.

## What this page is not, and what happens next

This page is the consolidated entry point for the research
closed in the research lot of 2026-10-25: the
`docs/research/` files were closed file by file under the
same rule as every other `docs/` directory — integrated
into the project, integrated into the wiki, or explicitly
abandoned with a reason traced in the migration matrix —
and the directory is deleted. Do not treat a constituent
as settled because it has a name in a register.

## The questionnaire that carries the work forward

The future collaborative vocabulary work is organised by
the working questionnaire in [questions](questions.md):
58 questions — 48 term questions, 8 token questions and
2 method questions — in families (values, products and
sums; suspension, computation and quantification; time,
coinduction and concurrency; token questions; method
arbitrations). The questionnaire's organisation, its recorded
answers and its blockers are preserved there; the
registers that framed it (audit, ontology, closure plan,
decision register, historical inventory) are closed, their
verdicts carried here, in [questions](questions.md), in
[decisions](decisions.md) and in the roadmap section
"Work the research lot follow-ups" — not recopied as
registers, and with no historical lineage retold.

Two method answers are recorded. The author's method
choice of 2026-10-25 (Q-METH-002, option A): a global lot
after the ontological audit, no individual ratification of
lemmas or tokens until the scope, categorisation and
formal-chain contradictions are delimited. And the
arbitration sequence of 2026-10-26 (Q-METH-001, option A):
non-collision, scientific exactness, family and grade
invariants, provisional ecological grid, mnemonic
arguments, brevity. Individual answers are dated
preferences until the global lot; the first is `lambda`
for `Lam`. None of them ratifies a term, and none
authorises a renaming.

The blockers that are not lexical votes, all open except
B-ONTO-07:

- B-ONTO-01 — the count of 46 announced by the C3 text
  and the cross-check omits the `fix` and `declassify`
  forms of the expected table, although they are in the
  grammar and C3 gives them rules in its body: audit
  the cross-check coverage, separately from the
  questionnaire; rename or delete nothing on this basis.
- B-ONTO-02 — categories and typing of the temporal
  forms, declassification, `at_n` and `move`: resolve
  the categories and align grammar, rules and reduction.
- B-ONTO-03 — representation of the environmental wait
  of `When`: define the separate observation or
  orchestration and revise the affected obligation
  before any final choice.
- B-ONTO-04 — `When` resource correctness, and a
  possible dual modality requested by the audit:
  complete the proof, or modify the theoretical
  proposition under explicit ratification.
- B-ONTO-05 — `Vec`: the type is declared derived, but
  the vector rules and a possible graded indexed fold
  each require their own proof: establish which
  obligations are kept and which are lost before using
  `fold` as a name or a factorisation.
- B-ONTO-06 — ν / `Out` / `Cop`: rules present in C3
  against a register narrative saying rules are
  missing: reconcile the register state with the
  normative state and the real proofs.
- B-ONTO-07 — the ecological criterion had no ratified
  rank from historical criteria. Lifted on 2026-10-26:
  Q-METH-001, option A, ranks the provisional ecological
  grid fourth.

The ontological register's other durable content is
already where it belongs: the seven refused
factorisations are the negative tests of
[research](research.md), "Refused factorisations"; the
form-by-form chain (grammar → rule → reduction → AST →
proof/test) is the programme of § "Deep evaluation
programme" above, and its gaps are the roadmap's stage H
and gate-C work. Nothing else from the register is
carried as a claim.
