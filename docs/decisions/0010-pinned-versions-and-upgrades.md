<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0010 — Pinned versions and version upgrades

| Field | Value |
|---|---|
| Status | Proposed — exact versions to be filled in (partly decided by the owner: see [Owner decisions already given](#owner-decisions-already-given)) |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-010); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), items 50 and 53 |
| Depends on | [ADR-0006](0006-klean-as-audited-translator.md) |
| Work packages | WP4, WP5 |
| Gates | G3, G5 |

## Context and Problem Statement

K, klean, Lean, Mathlib, CSLib and Verso evolve at different paces. The prototype (PR #232) uses
Lean 4.34.0 with a shim, because klean's template targeted an earlier version. At the date of this
ADR, the latest stable Lean version is 4.35.0 (12/10/2026) and a 4.36.0-rc1 is available.

## Considered Options

The draft lists no alternative.

## Decision Outcome

Proposed decision:

1. **The target Lean version is the one supported by klean and the tested shim**, not
   automatically the latest stable version.
2. **Pinned versions** (to be filled in, all recorded in the provenance of the reports):

   | Component | Mechanism | Version |
   |---|---|---|
   | Lean | `lean-toolchain` | `<to be filled in>` |
   | Mathlib | `lake-manifest.json` | `<revision>` |
   | CSLib | `lake-manifest.json` | `<revision>` |
   | Verso (+ Blueprint if used) | `lake-manifest.json` | `<revision>` |
   | K Framework (kompile, backends) | container image or Nix, by digest | `<version / digest>` |
   | klean | frozen version + shim | `<version / commit>` |
   | Kernel re-checking tool | frozen version | `<version>` |

3. **Upgrade procedure:**
   1. dedicated branch;
   2. full regeneration (S1–S4);
   3. diff of the generated snapshot (if Q6 = yes);
   4. klean audit redone ([ADR-0006](0006-klean-as-audited-translator.md)) if klean or Lean
      changes;
   5. all gates green;
   6. amendment of this ADR (version table).
4. **Cadence:** on demand, with a quarterly review of the gap with the latest stable Lean
   version.
5. An RC MUST NOT be used on `main`.

### Consequences

- (+) Reproducible builds; complete provenance of the evidence.
- (−) Possible lag behind the latest versions of Lean and Mathlib.

### Confirmation

- G3 and G5 run with the pinned versions; CI fails if the detected version differs from the
  table.

## Owner decisions already given

- **Item 50** (2026-10-19): the Lean version is not changed now (`leanprover/lean4:v4.34.0` in
  `lean-toolchain`, `proofs/` and `spec/formal-chain/`); a migration to v4.36 (or later) is to be
  planned (register wording). This settles the current Lean version; the migration plan is still
  open.
- **Item 53** (2026-10-19): « ok => à faire » for ADR-003…010 and Q1–Q6: the work is requested.
- **Not decided:** the rule of clause 1, the version table (clause 2), the upgrade procedure
  (clause 3), the cadence (clause 4) and the RC rule (clause 5). The ADR stays Proposed.

## Open questions

- **Q6** — version a snapshot of the generated outputs (`generated-snapshot/`)? Bears on step 3
  of clause 3 (today: CI artefact only).
- Bump policy for `proofs/`, `spec/formal-chain/` and the shim (KLean instruction, X-12, item
  N-9): the monthly `bump-lean.yaml` workflow regenerates only the root `lean-toolchain`,
  `lakefile.lean` and `lake-manifest.json`.
- Two Verso revisions coexist and `spec/formal-chain/` pulls `verso-slides` at tag
  `v4.34.0-rc2`, against clause 5 (X-12, item N-10).
- K image pinned by tag and klean by version without hash, against « by digest » (X-13).

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-010-versions-epinglees.md` of the plan « Workflow
  KLean K7PL » (18 October 2026); the plan and its instruction are session notes, not deposited in
  the repository.
- Role placeholder « responsable outillage » replaced by the single decision-maker
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- The context's claim about Lean 4.35.0 and 4.36.0-rc1 is the draft's; neither the KLean
  instruction nor this port verified it.
- The version table is left unfilled: filling it is the amendment act of clause 3. Values observed
  on `main` (`be35c5e`, 2026-10-20), for the owner: Lean `v4.34.0` in `lean-toolchain`,
  `proofs/lean-toolchain` and `spec/formal-chain/lean-toolchain`; root manifest Mathlib `5ed2965`,
  CSLib `990e65a`, Verso `cad4b63` (input revision `v4.34.0` each); `spec/formal-chain/` manifest
  VersoBlueprint `a1cf706`, Verso `52c8c95`, `verso-slides` `42e649a` (input revision
  `v4.34.0-rc2`); K image `runtimeverificationinc/kframework-k:ubuntu-jammy-7.1.337` (tag);
  klean `kframework==7.1.337` (pip, no hash); no kernel re-checking tool.
- S1–S4 are the pipeline stages of the plan (§5 of the plan).
