<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Ratified statement-taxonomy decisions

**Decision date:** 2026-10-09  
**Status:** Ratified design constraints; implementation not yet validated  
**Canonical plan:** [LEAN-STATEMENT-COMMANDS-PLAN.md](LEAN-STATEMENT-COMMANDS-PLAN.md)

This record captures the author's answers to the C8 calibration questions. It records decisions, not evidence that the implementation already satisfies them.

## Ratified decisions

1. **Ontology:** target a strict multidimensional model separating object kind, logical/expository role, epistemic state, evidence, and scope. A hybrid representation is an acceptable migration state, not the target.
2. **Result roles:** theorem (major established result), lemma (established dependency), corollary (directly derived established result), proposition (other established result), conjecture (not established). The first four are expository roles, not a truth hierarchy.
3. **Epistemic state:** `proposed`, `under-review`, `supported`, `established`, `refuted`, `withdrawn`. Role and state are independent.
4. **Requirements:** one generic requirement object with explicit scope and normative effect.
5. **Assumptions:** hypotheses local to a result/argument are structured premises of that result/argument. Axiom/postulate are not normatively distinguished without justification.
6. **Literature:** external results are documentary objects with bibliographic provenance and explicit K7PL usage; they are not automatically K7PL-established results.
7. **Future work:** selected external results may later be reimplemented as formal proofs. Track that as a separate improvement, with explicit source/result/formal-artifact traceability.
8. **Evidence:** written mathematical demonstrations and machine-checked Lean proofs are distinct. Proof sketches are explicitly incomplete. Machine-checking requires an identified formal artifact.
9. **Scope:** model explicit scope separately from the existing domain `level`.
10. **Labels and numbering:** per-type counters are allowed. Labels are required for numbered/referenced objects and optional for local examples. Preserve existing labels/references during initial migration; document deliberate renumbering.
11. **Commands:** expose specialized authoring commands backed by one shared validated representation.
12. **CI:** fail on mechanically decidable structural and consistency violations. Do not pretend that scientific judgments are mechanically proven.
13. **Migration:** use small, buildable, independently reviewable PRs. Preserve source statement text, labels, references, assumptions, and epistemic status during the initial migration.
14. **Prose reduction:** only after structural migration is validated; deletion requires evidence that the information is represented losslessly elsewhere.
15. **Exit gate:** C8 remains open until inventories, build/render, blocking checks, traceability, and qualitative prose review all pass.

## Open implementation questions (not authorial calibration questions)

These are to be resolved by source inspection and tests, not guessed:

- Which exact finite vocabulary and compatibility mapping should be used for `scope`?
- How should epistemic state, evidence kind, and formal-artifact identifiers be represented in Verso directive arguments without permitting invalid combinations?
- Which existing statement instances have ambiguous kind/role/state assignments and therefore require explicit author review?
- Which generated outputs and CI jobs consume the current statement inventory or depend on the shared theorem counter?
- What bibliographic identifier format will connect an external result to its sources and any later formal reimplementation?

## External-proof follow-up

Create a separate follow-up task for evaluating which literature-derived results merit formal reimplementation. Selection must be based on assurance value, dependencies, feasibility, and licensing/access to source material. Do not make external proof reimplementation a prerequisite for merely recording a literature result, and do not label a literature result as machine-checked until the formal artifact exists and is tested.
