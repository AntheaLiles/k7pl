<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0006 — klean, an audited translator

| Field | Value |
|---|---|
| Status | Proposed (partly decided by the owner: see [Owner decisions already given](#owner-decisions-already-given)) |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-006); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), items 43 and 53 |
| Depends on | [ADR-0004](0004-k7pl-profile-of-k.md), [ADR-0005](0005-executable-axiom-policy.md) |
| Work packages | WP4, WP5, WP10 |
| Gates | G5, G6 |

## Context and Problem Statement

klean produces, from `definition.kore`, a Lean package (sorts, injections, functions, rewrite
relation). PR #232 shows that the pipeline works on a subset, with a Lean-version compatibility
shim. The exact behaviour of klean on hooks, priorities, `ensures` and partial functions is **not
yet confirmed** in our context.

## Considered Options

Rejected alternatives listed by the draft:

- **In-house generator from the start**: high immediate cost; remains an option.
- **Deep embedding in Matching Logic (AML)**: out of scope
  ([ADR-0008](0008-initial-out-of-scope.md)).
- **Hand-rewritten semantics**: forbidden by [ADR-0002](0002-one-concept-one-home.md).

## Decision Outcome

Proposed decision:

1. **klean is the chosen KORE → Lean translator**, in a pinned version
   ([ADR-0010](0010-pinned-versions-and-upgrades.md)). Its output goes to `build/lean-gen/KGen/`
   and MUST NEVER be edited.
2. **Mandatory audit (WP4)** on minimal K definitions, one per behaviour to test:

   | Behaviour | Question |
   |---|---|
   | Hooks | Uninterpreted function + axiom? Possible to substitute a `def`? |
   | `priority` / `owise` | Ignored? Represented? |
   | `requires` | Translated into a hypothesis of the constructor? |
   | `ensures` | Ignored? |
   | `total` / partial functions | Total `def`? `partial`? Axiom? |
   | `strict` (heat/cool) | Distinct constructors identifiable as τ? |
   | Rule labels | Kept in constructor names? |
   | Collections | Handling of `Map`, `List`, `Set`, arrays |

   Deliverable: `reports/klean-audit.json` and a summary note.
3. **Prelude without axioms:** each allowed hook ([ADR-0004](0004-k7pl-profile-of-k.md), K4) is a
   Lean `def`; the conventions (division, modulo, overflow) are checked against the LLVM backend
   (T4).
4. **Compatibility shim** versioned and accompanied by regression tests.
5. **Trace validation mandatory (T2)**, with a unique-successor check.
6. **In-house complementary generation** from the manifest and the KORE: `Meta.lean` (layers,
   bridges, footprints, automata) and `Grammar.lean` (reified grammar).
7. **Decision tree after the audit:**
   - the [ADR-0004](0004-k7pl-profile-of-k.md) profile suffices to guarantee an exact translation
     → klean is kept;
   - a blocking gap exists → fix proposed upstream, or a pinned **fork**;
   - several structural gaps → **in-house KORE → Lean generator** (Lean metaprogramming), decided
     by a new ADR.

### Consequences

- (+) An existing tool and the work of PR #232 are reused.
- (+) Confidence in the translation is measured, not presumed.
- (−) Dependency on an external tool whose pace of change differs from Lean's.

### Confirmation

- G5 on KGen + Prelude; G6 on the corpus; audit redone at each klean version upgrade.

## Owner decisions already given

- **Item 43** (2026-10-19), option (c): « generate with `-r` (selected rules) and/or a patched,
  project-owned Prelude that excludes the Map/Set/List collection hooks » (register wording).
  This settles how clause 3 (Prelude without axioms) is to be reached for the collection hooks.
  Still open: the choice between `-r`, the patched Prelude, or both; and how a patched,
  project-owned Prelude relates to clause 1 (« MUST NEVER be edited »), which the instruction left
  to this ADR (T-405).
- **Item 53** (2026-10-19): « ok => à faire » for ADR-003…010: the audit and the rest of the
  work are requested; clauses 1, 2, 4–7 are not decided. The ADR stays Proposed.

## Open questions

- The decision tree of clause 7 waits for the klean audit (T-401) on the fixture corpus (T-300).
- Whether the existing shim, which removes one generated declaration, is a « compatibility »
  change under clause 4 or an edit under clause 1.

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-006-klean-traducteur-audite.md` of the plan
  « Workflow KLean K7PL » (18 October 2026); the plan and its instruction are session notes, not
  deposited in the repository.
- Role placeholders replaced by the single decision-maker
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- `build/lean-gen/KGen/`, `reports/klean-audit.json`, `Meta.lean` and `Grammar.lean` are the
  plan's names. In the repository the generated package is written to `proofs/K7PL2Lean/`
  (ignored by Git).
- Repository state when ported (KLean instruction, §2.1, §2.3): klean is pinned by version
  (`pip install kframework==7.1.337`, no hash, in `scripts/ci/k7pl_semantics_install_klean.sh`); the shim is
  [`scripts/ci/patch_klean_prelude.py`](../../scripts/ci/patch_klean_prelude.py), which removes
  one generated `ByteArray.decEq` that collides with Lean 4.34.0, with three unit tests; the
  instruction's static reading of the wheel found 41 `axiom` declarations for Map/Set/List hooks
  in the template Prelude, and INT hooks already written as `def`s.
