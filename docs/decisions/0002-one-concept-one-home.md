<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0002 — One concept, one home (no Lean mirror)

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-002); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), item 44 (related) |
| Depends on | [ADR-0001](0001-trust-order-and-normative-k-text.md) |
| Work packages | WP6–WP9, WP11 |
| Gates | code review, G9 |

## Context and Problem Statement

Defining the same thing in K and in Lean doubles the maintenance effort and creates a risk of
silent divergence. The current prototype (PR #232) already contains hand-written mirrors
(`SurfaceStep`, `HasType`) on top of the generated constructors.

## Considered Options

Rejected alternatives listed by the draft:

- **Double definition plus differential tests**: the cost is doubled and the tests only cover a
  corpus.
- **Lean as the home of the grammar**: K is better suited and serves as the basis for execution.

## Decision Outcome

Proposed decision:

1. **Each concept has a single home:**

   | Concept | Home |
   |---|---|
   | Surface grammar | K (`syntax` blocks) |
   | Operational semantics | K (`rule` blocks) |
   | Automata, orchestrator | K (`automaton`, `orchestrator` blocks) |
   | Algorithmic typing | K (subject to Q7) |
   | Layers, footprints, bridges | Metadata of the Verso blocks ([ADR-0003](0003-k-blocks-in-verso-and-extraction.md)) |
   | Algebraic laws (grades, budgets) | Lean (Mathlib classes) |
   | Concrete operations on grades | K |
   | Categorical foundations | Lean / Mathlib |
   | Properties (sealing, preservation, footprint…) | Lean (theorems) |
   | Examples and expected results | Spec (`example` blocks) |

2. **Lean constructions allowed on the generated types (KGen):** predicates, abstraction
   functions (`α : KGen.Config → Model`), theorems, law classes and instance proofs, tactics and
   meta commands.
3. **Forbidden: mirrors.** A Lean `inductive`, `def` or relation that copies a K production, rule
   or function MUST NOT be written.
4. **Structure/instance pattern:** Lean defines the abstract structure (the laws), K defines the
   concrete instance, and Lean proves that the instance satisfies the structure.
5. **Mandatory review question** for every Lean PR: « Could this definition be generated from
   K? » If so, refusal: import it from KGen.
6. **Migration:** the mirrors of PR #232 MUST be removed in WP11. Their theorems are carried over
   to `KGen.Rewrites`.
7. **Exception:** only through a derogation ADR that justifies why the definition cannot be
   generated and provides an equivalence theorem with the generated version.

### Consequences

- (+) No divergence is possible between two definitions.
- (+) Review focuses on properties, not on copies.
- (−) The quality of the klean translation becomes critical
  ([ADR-0006](0006-klean-as-audited-translator.md)).
- (−) Independence of validation must come from elsewhere: Lean properties, examples written by
  humans, the compiler (T1, T3, T5).

### Confirmation

- PR-1 checkbox in the PR template.
- Heuristic mirror detector (non-blocking): it compares the constructors of hand-written
  inductives with those of KGen (names, arities) and reports similarities.
- G9: a normative K rule without an associated obligation or test is reported.

None of these checks exists in the repository yet.

## Owner decisions already given

- **Item 44** (2026-10-19), option (b): « K becomes the normative home of the C3/C4 grammar and
  semantics; the Lean proofs run on the KLean-generated types » (register wording; see
  [ADR-0012](0012-k-as-normative-home-of-c3-c4.md)). It points the same way as clauses 1 (grammar
  and semantics in K), 2 and 6 (proofs on the generated types), but the owner did not decide the
  prohibition of mirrors (clause 3), the review question (clause 5), the exception procedure
  (clause 7) or the rest of the table of clause 1. The ADR stays Proposed. The process note on
  decision 49 had marked this ADR as « a consequence of 44 to confirm ».
- Item 53 lists ADR-003…010 as « ok => à faire »; it does not name this ADR.

## Open questions

- **Q7** — typing defined in K (algorithmic, recommended by PR-1) or a separate Lean judgment?
  Blocks the « algorithmic typing » row and WP9, WP11.
- **Q4** — are the fragments (ownership, grade, effects) and the algebraic laws of grades still
  current? Bears on the « algebraic laws » and « concrete operations on grades » rows.
- **Q2** — orchestrator model (sequential or concurrent; determinism required?). Bears on the
  « automata, orchestrator » row.
- From the KLean instruction (conflict X-5): `typeOf` is partial, uses `==K` and its equations
  are not exported by klean, so removing the `HasType` mirror needs either a total, exportable
  `typeOf` or a derogation under clause 7 (instruction item N-11, not yet put to the owner).

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-002-un-concept-un-foyer.md` of the plan « Workflow
  KLean K7PL » (18 October 2026); the plan and its instruction are session notes, not deposited in
  the repository.
- Role placeholders replaced by the single decision-maker
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- « PR-1 » is principle 1 of the plan (« one concept, one home »); the repository's PR template
  is [`.github/PULL_REQUEST_TEMPLATE.md`](../../.github/PULL_REQUEST_TEMPLATE.md) and has no
  such checkbox.
- Repository state when ported: the mirrors `HasType`, `Value` and `SurfaceStep` are in
  `proofs/K7PL/Proof.lean`; `rewrites_preserve_machine_typing` in
  `proofs/K7PL/MachineSoundness.lean` already works on the generated `Rewrites` constructors;
  `Spec.C3.EffectiveKernel` defines Lean term and type inductives, which the instruction counts
  as a possible second home once K defines the core grammar (X-5).
