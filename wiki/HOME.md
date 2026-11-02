<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Wiki

K7PL (KonSept Programming Language) is a research project on the design and
formal treatment of a programming language whose specification,
formalisation, implementation, proofs, and executable tests remain traceable
but distinct. This wiki is the project's consolidated documentation. It is
written in English and is the authoring source for project documentation;
the separate GitHub wiki is regenerated from `wiki/` and must not be edited
as an independent source of truth.

> **Provenance — Lot 1 (pilot).**
> Consolidated 2026-10-25 from `docs/README.md`, `docs/ARCHITECTURE.md`,
> `docs/RESEARCH.md`, and, for status vocabulary only, `docs/ASSURANCE.md`,
> on `main` at `c56c84509812abe49cd716832f7ccdb750613036`.
> Status: living and canonical for the topics it covers.
> Renamed 2026-10-25 from `wiki/README.md` to `wiki/HOME.md` at
> the owner's request; content unchanged by the rename, except
> for links pointing to the new name.
> The Lot 1 sources `docs/README.md`, `docs/ARCHITECTURE.md` and
> `docs/RESEARCH.md` were deleted in the Lot 1 closing commit after
> owner validation. Other `docs/` files remain in the repository until
> their own lot is validated; they are no longer the reference for
> topics already consolidated here.

## Start here

Read in this order:

1. [Understanding](understanding.md) — what K7PL is, how the repository
   is organised, and how specification, formalisation, implementation,
   proofs, and tests relate.
2. [Layers](layers.md) — the canonical definition of the three layers
   L1, L2, and L3, and what they must not be confused with.
3. [Research](research.md) — the scientific problem, hypothesis, object,
   expected contributions, and validation strategy.
4. [Vocabulary](vocabulary.md) — the dedicated page for the lexical,
   syntactic and semantic research on K7PL's constituents, and
   for the deep evaluation programme still in progress
   (formalisation in K, Lean and TLA+ instrumentation, proof
   linking, theorem validation).
5. [Semantics](semantics.md) — the executable K semantics
   prototype, its bridges to Lean, and the native-boundary
   model, with their exact limits.
6. [Publishing](publishing.md) — how the GitHub wiki is
   generated from `wiki/`, and what has not been regenerated.
7. [Bibliography](bibliography.md) — the cited-works data,
   its rules, and what was abandoned.
8. The normative specification in [`spec/`](../spec/) — the only place
   where language requirements are stated authoritatively. The wiki
   summarises and points to it; it never replaces it.

Later lots will add, in the same place, consolidated pages for assurance
and gate C, security, decisions, tracking and review, method, provenance
and history, and bibliography. Until a topic has its own consolidated
page, its `docs/` source remains the interim reference for that topic
only, and must not be silently promoted to a current claim.

## Authority rules

These rules are consolidated from `docs/ARCHITECTURE.md`. They decide
every conflict between artefacts.

1. Normative commitments in the current specification are authoritative
   for language requirements.
2. Formalisation is a representation of identified normative commitments,
   not a replacement for them.
3. Implementation behaviour is evidence about the implementation and does
   not silently redefine the specification.
4. Proofs establish the propositions they actually prove, in the formal
   system and environment in which they were checked.
5. Tests establish the behaviours they actually exercise.
6. Historical documents provide provenance unless explicitly promoted
   into current project state.
7. A change that requires weakening a normative claim merely to make an
   implementation compile is a specification issue, not an
   implementation shortcut.

## Status vocabulary

A claim's progress and a statement's epistemic state are two different
things. Do not deduce one from the other.

**Assurance status** (for a claim or workstream, from
`docs/ASSURANCE.md`): `ESTABLISHED`, `PARTIAL`, `UNDER REVIEW`,
`IN PROGRESS`, `OPEN`, `BLOCKED`, `NOT STARTED`. `ESTABLISHED` means
established against explicit criteria and scope; it never means globally
or absolutely proven.

**Statement-level epistemic state** (from the specification's reading
guide, `spec/Spec/C1/ReadingGuide.lean`): `proposed`, `under-review`,
`supported`, `established`, `refuted`, `withdrawn`, `not-applicable`.
The guide also fixes four kinds of statement — postulate (posed, not
derived), theorem (a result statement, whose name alone is neither a
proof nor a validation of scope), commitment (held true without proof,
and said so), and reading (an organising analogy, with no demonstrative
force) — plus reserve, obligation, and requirement. Evidence kinds are
`none`, `written-proof`, `proofsketch`, `literature`, `computation`,
`counterexample`, and `lean-proof`. A declared state or evidence kind is
not, by itself, a tool report: a `lean-proof` value does not replace a
compilation and axiom-audit report for the commit concerned.

**Invalid inferences.** A Lean theorem proved does not mean the
implementation is proven correct. Passing tests do not mean the
specification is proven coherent. A successful build does not mean the
formalisation is complete. A green CI run means the configured checks
succeeded on their impact scope, not that every K7PL claim is proven.
Peer review without an identified objection is not a mathematical proof.

## The frozen rule

Once a topic is consolidated in `wiki/` and its lot is validated, later
work must use only the consolidated `wiki/` pages for that topic. Do not
go back to the superseded `docs/` files for a consolidated topic, do not
reintroduce a dropped claim without a new decision, and do not edit the
generated GitHub wiki directly. The per-lot correspondence between old
and new files was recorded in a temporary migration matrix during the
refactor; that matrix itself was deleted when the whole refactor was
closed on 2026-10-25, as decided for this project, and survives in
git history.

## Open points carried from Lot 1

- Sedimentation in [layers.md](layers.md) is presented as the
  project's method of reasoning from the Prolegomena, neither open
  nor closed as a theorem would be. What remains open is the graded
  sedimentation theorem and the related functor and glued-category
  constructions, listed there separately.
- A second textual point, now resolved in [layers](layers.md):
  `GerminalAxiomatics.lean` previously said "la couche 2 est pure
  par construction"; the owner confirmed L3 is pure and terminating
  and L2 is productive with algebraic effects, and the sentence was
  corrected to "la couche 3" in the Lot 1 closing commit.
- Assurance is validated and its source deleted in the
  conservative Lot 2 closing ([assurance](assurance.md)).
  Security and decisions remain drafts in Lot 2
  ([security](security.md), [decisions](decisions.md)), pending
  owner validation; their `docs/` sources remain the interim
  references and are not deleted by this closing.
- Method is consolidated in [method](method.md). Tracking and
  review are partially consolidated: peer-review evidence in
  [assurance](assurance.md), research programmes in
  [research](research.md), the itemised tracking register in
  [decisions](decisions.md), and the navigation model above in
  [understanding](understanding.md). Their live registers
  (decisions, card statuses, master plan, statement migration,
  proof visualisation, navigation backlog) are kept in `docs/`
  until their own closing criteria are met, and are interim
  references only, pending their lots. Provenance and
  bibliography are not yet consolidated.
- `wiki/STATUS.md` is generated by CI and must not be edited by hand.
  Its generated successor in `wiki/` is a decision for a later lot.
