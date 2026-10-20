<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0005 — Executable axiom policy

| Field | Value |
|---|---|
| Status | Proposed — decision awaiting Q5 (`Classical.choice`) |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-005); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), items 43 (related) and 53 |
| Depends on | — |
| Work packages | WP4, WP5, WP6–WP9 |
| Gates | G5 |

## Context and Problem Statement

The K7PL specification requires « zero axiom, zero sorry ». This requirement must be made precise
to be checkable:

- Mathlib relies on Lean's standard axioms;
- `native_decide` introduces `Lean.ofReduceBool`, which brings the Lean compiler into the trusted
  base;
- `#print axioms` has known blind spots (Lean issue #7463: axioms hidden via `@csimp` combined
  with `native_decide`);
- `@[implemented_by]` and `@[extern]` change executable behaviour without appearing in the axiom
  audit.

## Considered Options

Rejected alternatives listed by the draft:

- **Checking with `#print axioms` alone**: known blind spots.
- **Allowing `native_decide` with documentation**: contrary to the specification's requirement.

## Decision Outcome

Proposed decision:

1. **Allowlist:** `propext`, `Quot.sound`, `Classical.choice`. Q5 is open: if a constructive
   requirement is chosen, `Classical.choice` is removed and the Mathlib dependencies concerned
   must be identified. **Recommendation: allow it**; a large part of Mathlib depends on it.
2. **Forbidden in `proofs/` and in the Prelude:** `sorryAx`; `Lean.ofReduceBool`, hence no
   `native_decide`; any project `axiom` declaration; the attributes `implemented_by`, `extern`
   and `csimp`.
3. **Allowed decision tactics:** `decide` and `decide +kernel`.
4. **Audit tool:** a Lean metaprogramming script (collecting axioms through the environment API)
   applied to **all** declarations of the `Proofs.*` and `Prelude.*` modules, rather than parsing
   the output of `#print axioms`. Output: `reports/axioms.json`.
5. **Re-checking by an external kernel** (a lean4checker-type tool) of the proof modules, in CI.
6. **Scope:** `tools/` and `tests/` MAY use `#eval` and native code, but MUST NOT be imported by
   `proofs/`.
7. **Meta-level hypotheses** (for example `KStep ⊆ Rewrites`,
   [ADR-0001](0001-trust-order-and-normative-k-text.md)): documented in `docs/assumptions.md`,
   never formalised as an `axiom`.

### Consequences

- (+) « Zero axiom » becomes a mechanically checked property.
- (+) The trusted base is limited to the Lean kernel and the standard axioms.
- (−) Some proofs by computation will be slower without `native_decide` (plan for
  `decide +kernel`, reflection, or structured lemmas).

### Confirmation

- G5: an axiom outside the list, a forbidden attribute or a failure of the external re-check ⇒ CI
  fails.

## Owner decisions already given

- **Item 43** (2026-10-19, related), option (c): « generate with `-r` (selected rules) and/or a
  patched, project-owned Prelude that excludes the Map/Set/List collection hooks » (register
  wording). It answers whether « no new axiom » covers the generated KLean modules by choosing a
  generation route that removes the collection-hook axioms; it does not decide this policy. The
  choice between `-r`, the patched Prelude, or both, is still open.
- **Item 53** (2026-10-19): « ok => à faire » for ADR-003…010 and Q1–Q6: the work is requested;
  Q5 is not answered by it.

## Open questions

- **Q5** — is `Classical.choice` admitted (constructive requirement or not)? Blocks G5. The
  KLean instruction notes that it is de facto allowed today: `scripts/axiom-audit.sh` already
  enforces the allowlist `propext,Classical.choice,Quot.sound`.

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-005-politique-axiomes.md` of the plan « Workflow
  KLean K7PL » (18 October 2026); the plan and its instruction are session notes, not deposited in
  the repository.
- Role placeholder « responsable preuve » replaced by the single decision-maker
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- **Source of the « zero axiom » rule:** the instruction found it in
  [`.claude/CLAUDE.md`](../../.claude/CLAUDE.md) and the project rules, not in `spec/`; the
  context and the rejected alternative keep the draft's wording « the specification requires ».
- Lean issue #7463 is cited by the draft; the port did not check it.
- `Proofs.*`, `Prelude.*`, `reports/axioms.json` and `docs/assumptions.md` are the plan's names.
  In the repository, the proof package is `proofs/` (libraries `K7PL` and the generated
  `K7PL2Lean`); `docs/assumptions.md` does not exist and the existing hypothesis register is
  [`docs/tracking/hypotheses-de-module.md`](../tracking/hypotheses-de-module.md).
- Repository state when ported (KLean instruction, X-3, X-4): `scripts/axiom-audit.sh` runs in
  `verify.yaml` on the root libraries, not on `proofs/`; `proofs/lakefile.toml` has no
  `warningAsError`; the K workflow only greps the build log for `sorryAx` and two
  `depends on axioms:` lines (`scripts/ci/k7pl_semantics_build_proofs.sh`); no external kernel
  re-check is configured.
