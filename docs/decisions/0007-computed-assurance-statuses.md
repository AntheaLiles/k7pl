<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0007 — Computed assurance statuses

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-007); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), items 47 (related) and 53 |
| Depends on | [ADR-0003](0003-k-blocks-in-verso-and-extraction.md), [ADR-0006](0006-klean-as-audited-translator.md) |
| Work packages | WP1, WP5, WP10 |
| Gates | G8, G10 |

## Context and Problem Statement

A specification that displays « proved » or « tested » without a mechanical link to the actual
results gives an illusory confidence. Verso must present the evidence, not fabricate it.

## Considered Options

Rejected alternative listed by the draft:

- **Statuses in the prose or in manual attributes**: prone to drift.

## Decision Outcome

Proposed decision:

1. **Recognised statuses and conditions:**

   | Status | Condition |
   |---|---|
   | `defined` | Normative K block extracted, compiled, compliant with the linter |
   | `proved` | Lean theorem built, axiom audit compliant ([ADR-0005](0005-executable-axiom-policy.md)) |
   | `proved-transferred` | Proved, universal, on `KGen.Rewrites` |
   | `proved-exact` | Proved, existential, under the [ADR-0004](0004-k7pl-profile-of-k.md) profile (K2) and T2 green |
   | `traced` | T2 replay succeeded for the example |
   | `tested(n, coverage)` | T1, T3 or T4 green |
   | `assumed` | Hypothesis listed in `docs/assumptions.md` |
   | `open` | Obligation declared, not satisfied |

2. **Single source:** the statuses are **computed** by CI in `reports/status.json` from
   `manifest.json`, `lint.json`, `axioms.json`, and the trace and test reports. No manual entry.
3. **Theorem ↔ block link:** a project Lean attribute (name to be fixed in WP1, for example
   `@[k7pl_obligation "O4" "c4-rule-…"]`) links a theorem to an obligation and to the `id`s of
   K blocks.
4. **Provenance:** each status carries the commit, the hashes of the blocks and the versions of
   the tools ([ADR-0010](0010-pinned-versions-and-upgrades.md)).
5. **Rendering:** the Verso badges read `reports/status.json`; a missing status is displayed as
   `open`.
6. **Non-regression:** any downgrade with respect to `main` requires an ADR or issue reference
   (G8).

### Consequences

- (+) The published document reflects exactly the verified state.
- (+) The specification serves as a traceability matrix.
- (−) The report schema must be maintained.

### Confirmation

- G8 (downgrade); G10 (build and badges); G9 (orphan rules).

None of these gates exists in the repository yet.

## Owner decisions already given

- **Item 47** (2026-10-19, related): « tous les éléments de traçabilité calculés et exposés de
  manière fiable et prouvés par de l'outillage Lean ». This sets the direction of clause 2
  (computed, not hand-entered) for all traceability elements, as a workstream still to be
  instructed; it does not decide the status list, the attribute, the report files or the rendering
  of this ADR. The KLean process note proposed to rewrite this ADR after the decision-47
  instruction; this port does not do so.
- **Item 53** (2026-10-19): « ok => à faire » for ADR-003…010: the work is requested, the
  clauses are not accepted by it.

## Open questions

- Relation with the C8 statement ontology (KLean instruction, conflict X-6):
  `tools/SpecExt/Theorem.lean` carries an author-declared `epistemicState` and `evidence` by
  design, while clause 2 forbids manual statuses; options listed by the instruction (item N-4,
  not yet put to the owner): computed statuses as evidence badges next to the author's epistemic
  state; computed statuses replacing `evidence` for `lean-proof`; separate registers.
- The status vocabulary must be reconciled with the other vocabularies in use (decision-47
  instruction, session note).

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-007-statuts-calcules.md` of the plan « Workflow KLean
  K7PL » (18 October 2026); the plan and its instruction are session notes, not deposited in the
  repository.
- Role placeholders replaced by the single decision-maker
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- **Status identifiers translated** (French originals: `défini`, `prouvé`, `prouvé-transféré`,
  `prouvé-exact`, `tracé`, `testé(n, couverture)`, `supposé`, `ouvert`), following the rule that
  identifiers outside `spec/` are English.
- **Name adapted:** the draft's example block id `c6-rule-…` becomes `c4-rule-…`: in this
  repository the operational semantics is in chapter C4 and C6 is compilation (KLean instruction,
  conflict X-17). The id format itself is open (X-20, see
  [ADR-0003](0003-k-blocks-in-verso-and-extraction.md)).
- `reports/status.json` and the other report files are the plan's names; the instruction notes
  that they would be CI artefacts rather than a tracked root directory (X-7, §4.3).
  `docs/assumptions.md` does not exist; the existing register is
  [`docs/tracking/hypotheses-de-module.md`](../tracking/hypotheses-de-module.md).
