<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0012 — K as the normative home of the C3/C4 grammar and semantics

| Field | Value |
|---|---|
| Status | Accepted (takes effect when the owner merges the PR that adds this record) |
| Date | 2026-10-20 (owner decision of 2026-10-19) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | Claude Code (agent), KLean instruction (question N-1) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), item 44 |
| Depends on | [ADR-0001](0001-trust-order-and-normative-k-text.md) (proposed) |
| Gates | — |

## Context and Problem Statement

The KLean plan's vision is that the Verso specification holds the *unique* definition of the K7PL
grammar and semantics, written in K. In the repository (KLean instruction, conflict X-1):

- the normative grammar of the core calculus is in chapter C3
  (`spec/Spec/C3/GrammaireDesTermes.lean`, `spec/Spec/C3/GrammaireDesTypes.lean`, LaTeX `::=`
  rules) and the operational semantics in chapter C4
  (`spec/Spec/C4/SemantiqueOperationnelle.lean`);
- the K definition in `spec/Spec/CodeArtifacts.lean` covers a five-construct S-expression subset
  (integer and boolean literals, `+`, `<`, `select`) with a partial `typeOf`;
- the module `Spec.C3.EffectiveKernel` defines Lean inductives for values, computations and their
  types.

Realising the plan's vision therefore means rewriting C3/C4 normative content as K. The question
was where the normative grammar and semantics of C3/C4 live.

## Considered Options

Options put to the owner (KLean instruction, §5.4, N-1):

- (a) K covers only an executable surface subset; C3/C4 stay normative LaTeX; K is a checked
  companion.
- **(b) K becomes the normative home of the C3/C4 grammar and semantics** (a large normative
  change).
- (c) Staged: subset now, extended chapter by chapter with mandates.

## Decision Outcome

Chosen option: **(b)**. Owner decision of 2026-10-19, register wording: « K becomes the normative
home of the C3/C4 grammar and semantics; the Lean proofs run on the KLean-generated types. » No
rationale beyond the choice was recorded.

Related owner decisions of the same day: item 48, « les codeblocs K dans les fichiers Verso sont
normatifs », applied on `main` by PR #255; item 43, option (c), for the axioms of the generated
Prelude.

### Consequences

Stated by the register as still open for this item: « the rewriting of C3/C4 in K and the move of
the Lean proofs to the generated types ». Neither has started: no K block defines C3/C4 content,
and the proofs in `proofs/` run on the generated types of the five-construct subset only.

The decision bears on the proposed ADRs [ADR-0001](0001-trust-order-and-normative-k-text.md)
(normative K text), [ADR-0002](0002-one-concept-one-home.md) (one concept, one home) and
[ADR-0003](0003-k-blocks-in-verso-and-extraction.md) (K blocks in Verso); it does not decide them.

### Confirmation

None yet. The work is tracked in workstream N of
[`docs/tracking/PROJECT-MASTER-PLAN.md`](../tracking/PROJECT-MASTER-PLAN.md).

## Open questions

- **Mandate scope:** the specification rules require an explicit request for every normative
  change of `spec/` ([`.claude/rules/specification.md`](../../.claude/rules/specification.md)).
  Whether this decision is that request for the whole rewriting of C3/C4 in K, or each rewriting
  needs its own request, is not stated by the owner.
- **Second Lean home:** whether `Spec.C3.EffectiveKernel` remains once K defines the core grammar
  (KLean instruction, X-5) is not decided.
- **Coverage of C3/C4 by K:** questions Q1 (layers and crossings), Q2 (orchestrator; C4
  `EchelleDuSysteme`), Q4 (fragments, grades, effects and their laws) and Q7 (typing in K or as a
  Lean judgment) of the plan bear on what the K definition of C3/C4 must cover (KLean instruction,
  §5.2).

## More Information

### Notes on the record

- This ADR exists because no ported KLean draft covers decision 44: the drafts assume K as the
  home of « the grammar » and « the operational semantics » without naming C3/C4, and the question
  N-1 was raised by the KLean instruction, not by the plan.
- The KLean instruction is a session note, not deposited in the repository; its identifier N-1 is
  unrelated to the sub-items of workstream N
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- Prepared with the status Accepted by an agent to record a decision the owner had already given;
  see the acceptance note of [ADR-0011](0011-decision-records-roles-and-workstream-n.md).
