<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0001 — Trust order and normative status of the K text

| Field | Value |
|---|---|
| Status | Proposed (partly decided by the owner: see [Owner decisions already given](#owner-decisions-already-given)) |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-001); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), items 44 and 48 |
| Depends on | — |
| Work packages | all |
| Gates | G6, G8 |

## Context and Problem Statement

K7PL combines three artefacts: a Verso specification, Lean 4 proofs and a K definition. Without
an explicit rule, these artefacts may diverge without anyone knowing which one is authoritative.
Moreover, K is the tool best suited to writing the grammar and the operational semantics, whereas
its execution tools are the least verified part of the chain.

## Considered Options

Rejected alternatives listed by the draft:

- **K as the source of truth for the proofs**: contradicts the intended trust order.
- **Lean first, with a hand-rewritten operational semantics**: duplicates the definitions (see
  [ADR-0002](0002-one-concept-one-home.md)).
- **Prose-only specification, without normative K**: the grammar and the semantics would be
  neither executable nor verifiable.

## Decision Outcome

Proposed decision:

1. **The Verso specification is normative.** It comprises the prose, the normative K blocks
   ([ADR-0003](0003-k-blocks-in-verso-and-extraction.md)) and the statements of Lean theorems.
2. **The K text and the K tools are distinguished:**
   - the normative *K text* is part of the specification: it is **normative**;
   - the *K tools* (`kompile`, `krun`, `kore-rpc`, `kprove`) are **witnesses**: their results
     are evidence, never proofs.
3. **Trust order: spec → Lean → K.**
4. **Conflict resolution:**

   | Conflict | Interpretation | Action |
   |---|---|---|
   | A theorem required by the spec is false on KGen | Internal inconsistency of the spec | Decision of the author (spec hat), recorded by an ADR or a `spec-conflict` issue |
   | `krun` contradicts a fact proved in Lean | Tool or translation defect | `tooling` issue; the K evidence is invalidated |
   | Trace replay impossible (T2) | Translation gap or profile violation | Blocking (G6) |
   | Golden example ≠ `krun` | Wrong K rule or wrong example | Decision of the author (spec hat) |

5. **The transfer hypothesis `KStep ⊆ Rewrites`** (every step executed by K is a step of the
   relation generated in Lean) is a meta-level statement. It MUST be documented and validated by
   trace replay (T2). It MUST NOT be declared as a Lean `axiom`.

### Consequences

- (+) A single arbiter in case of disagreement; no second source of truth.
- (+) Writing the semantics in K remains compatible with a Lean trusted kernel.
- (−) The translators `kompile` and klean enter the trusted base **of the transfer**. This is
  mitigated by [ADR-0004](0004-k7pl-profile-of-k.md),
  [ADR-0006](0006-klean-as-audited-translator.md) and T2.
- (−) A spec/Lean conflict needs a human decision: it is not resolved automatically.

### Confirmation

- G6: trace replay and unique-successor check.
- G8: every status downgrade requires an ADR reference.
- Issue label `spec-conflict` with a dedicated template.

None of these checks exists in the repository yet (KLean instruction, §4.4).

## Owner decisions already given

- **Item 48** (2026-10-19): « les codeblocs K dans les fichiers Verso sont normatifs ». This
  settles clause 2, first bullet (the K text is normative), and the part of clause 1 that counts
  the K blocks in the normative specification. It was applied on `main` by PR #255 (`e79392e`),
  which makes `spec/Spec/CodeArtifacts.lean` state that its K code blocks are normative.
- **Item 44** (2026-10-19), option (b): « K becomes the normative home of the C3/C4 grammar and
  semantics; the Lean proofs run on the KLean-generated types » (register wording). It extends
  the normative K text to the C3/C4 grammar and semantics; it is recorded in
  [ADR-0012](0012-k-as-normative-home-of-c3-c4.md).
- **Not decided:** the trust order (clause 3), the status of the K tools as witnesses (clause 2,
  second bullet), the conflict-resolution table (clause 4) and the transfer hypothesis
  (clause 5). The ADR therefore stays Proposed.

## Open questions

- None of Q1–Q7 of the plan bears directly on this ADR.
- The draft's dependency graph makes ADR-0002, ADR-0003 and ADR-0008 depend on this ADR.

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-001-ordre-de-confiance.md` of the plan « Workflow
  KLean K7PL » (18 October 2026). The plan and its instruction against the repository (« KLean
  instruction ») are session notes, not deposited in the repository at the time of writing.
- The role placeholders « responsable spec / preuve / outillage » are replaced by the single
  decision-maker, and « décision du responsable spec » by « decision of the author (spec hat) »,
  as [ADR-0011](0011-decision-records-roles-and-workstream-n.md) decides.
- Identifiers G1–G10 (gates), T1–T6 (tests), KGen (the generated Lean package) and the issue
  labels `spec-conflict` and `tooling` are the plan's; none exists in the repository yet.
- Repository state when ported (KLean instruction, §4.5): the trust order is consistent with the
  authority rules of [`docs/ARCHITECTURE.md`](../ARCHITECTURE.md); conflicts X-1 (scope of K)
  and X-2 (non-normative page) of the instruction are addressed by items 44 and 48.
