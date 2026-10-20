<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0009 — Representation of layer-3 arrays

| Field | Value |
|---|---|
| Status | Proposed — decision awaiting Q3 |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-009); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), items 43 and 52 (related), 53 |
| Depends on | [ADR-0004](0004-k7pl-profile-of-k.md), [ADR-0005](0005-executable-axiom-policy.md) |
| Work packages | WP8 |
| Gates | G4, G5 |

## Context and Problem Statement

K7PL automata are mostly layer-3 and work on arrays. K's hooked collections would be translated by
klean with axioms (to be confirmed in WP4), which is incompatible with
[ADR-0005](0005-executable-axiom-policy.md). The granularity of the footprints (whole arrays or
slices) conditions obligation O7.

## Considered Options

| | A — User-defined K constructors | B — Hooked collections + Lean implementation | C — Hybrid |
|---|---|---|---|
| Principle | Arrays as K sorts and total functions, without hooks | K hooks; Lean Prelude with `def` (Mathlib List/Array/Vector) | A for the normative part; B in a separate execution profile |
| Axioms | None | None if the Prelude is complete | None on the normative side |
| Proof effort | Medium (basic lemmas to write) | Medium (prove the laws of the Prelude) | A + A ↔ B equivalence tested |
| `krun` performance | Lower | Good | Good in execution |
| Fidelity | Total (same source) | Depends on the hook conventions (T4) | Total for the normative part |
| Footprints as slices | Easy to express | Possible | Easy |

## Decision Outcome

Proposed decision:

- **Option A for milestones M2–M3.** Option **C** if `krun` performance becomes a measured
  bottleneck (T3 campaigns).
- The basic operations (read, write, size, map, fold, slice) MUST be K `function`s marked `total`
  ([ADR-0004](0004-k7pl-profile-of-k.md), K3) defined in `layer=3` blocks.
- The basic Lean lemmas on these operations (size preserved, read/write independence on distinct
  indices) MUST be proved once and reused for O7.

### Consequences

- (+) Zero axiom without dependence on hooks.
- (−) Slower K execution; basic lemmas to write.

### Confirmation

- G4: no hooked collection in normative K (unless C is adopted, and then only in the execution
  profile).
- G5 on the basic lemmas; T4 if option B or C is chosen.

## Owner decisions already given

- **Item 53** (2026-10-19): « ok => à faire » for ADR-003…010 and Q1–Q6: the work is requested;
  Q3 is not answered by it. The ADR stays Proposed.
- **Item 43** (2026-10-19, related), option (c): the patched, project-owned Prelude « excludes the
  Map/Set/List collection hooks » (register wording). Whether this rules out option B is not
  stated by the owner.
- **Item 52** (2026-10-19, related): « toute fonction ou groupe de fonctions mise en production
  est appelé automate »; which automata each layer creates is still open.

## Open questions

- **Q3** — array representation; are footprints on whole arrays or on slices? Blocks WP8. The
  draft details it as:
  - footprints at the level of the whole array or of the slice?
  - are sizes static (known at elaboration) or dynamic?
  - are multi-dimensional arrays needed from M2?
- **Q1** — layer names and crossing matrix, on which `layer=3` blocks depend.

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-009-tableaux-couche-3.md` of the plan « Workflow
  KLean K7PL » (18 October 2026); the plan and its instruction are session notes, not deposited in
  the repository.
- Role placeholders replaced by the single decision-maker
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- The draft's « Options » and « Questions à trancher (Q3) » sections are carried into
  « Considered Options » and « Open questions ».
- Repository state when ported (KLean instruction, §4.5): there are no arrays in the K definition;
  the three layers are named in C1 `tab:dimensions` (layer 3 = « Pureté mathématique », `[ ]`).
- The plan's milestones M2–M3 are unrelated to the proof-visualization milestones of the
  repository (see [ADR-0008](0008-initial-out-of-scope.md)).
