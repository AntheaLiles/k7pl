<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0008 — Initially out of scope

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-008); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), item 53 |
| Depends on | [ADR-0001](0001-trust-order-and-normative-k-text.md) |
| Work packages | all |
| Gates | review |

## Context and Problem Statement

The preliminary studies list many integration routes. Pursuing all of them would scatter the
effort without closing the main gap: the correspondence between normative K and the Lean
properties.

## Considered Options

The draft lists no alternative.

## Decision Outcome

Proposed decision. The following are **out of scope** until milestone M3, unless reopened by an
ADR:

| Item | Reason | Reopening criterion |
|---|---|---|
| Lean ↔ K FFI | Lean FFI unstable; no demonstrated need | Measured performance need, without impact on `proofs/` |
| Permanent RPC service | Operational complexity | Symbolic campaigns not feasible with one-off calls |
| Deep embedding in AML | High research cost; does not bear on the semantics of K7PL | The metatheory of K becomes a goal |
| Lean → K translation | Useless with K as the home ([ADR-0002](0002-one-concept-one-home.md)) | — |
| `kprove` as a source of proof | Outside the Lean kernel | Replay checked in Lean available |
| Executing K at Verso elaboration | Non-reproducible build ([ADR-0003](0003-k-blocks-in-verso-and-extraction.md)) | — |
| Categorical adequacy (O13) | Depends on M3 | After M3 |

**Allowed nevertheless:** **one-off** use of `kore-rpc` in `tools/` (for example to export T2
traces), without a service architecture.

### Consequences

- (+) Effort concentrated on M1–M3.
- (−) Some research directions are postponed.

### Confirmation

- Review: any PR that introduces an item of this list cites a reopening ADR.

## Owner decisions already given

- **Item 53** (2026-10-19): « ok => à faire » for ADR-003…010: the work is requested; the list is
  not accepted by it. The ADR stays Proposed.

## Open questions

- None of Q1–Q7 bears on this ADR.
- The milestones M1–M4 are defined by the plan, which is not deposited in the repository.

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-008-hors-perimetre-initial.md` of the plan
  « Workflow KLean K7PL » (18 October 2026); the plan and its instruction are session notes, not
  deposited in the repository.
- Role placeholders replaced by the single decision-maker
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- The plan's milestones M1–M4 are unrelated to the milestones M1–M7 of
  [`docs/tracking/PROOF-VISUALIZATION-ROADMAP.md`](../tracking/PROOF-VISUALIZATION-ROADMAP.md).
- « Review » in the Confirmation row cannot mean an independent review: the project has a single
  maintainer and agents are not reviewers ([`docs/security/GOVERNANCE.md`](../security/GOVERNANCE.md),
  [ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- Repository state when ported (KLean instruction, §4.5): nothing in the repository contradicts
  the list.
