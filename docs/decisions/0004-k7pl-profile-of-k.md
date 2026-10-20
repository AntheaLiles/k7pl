<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0004 — K7PL profile of K

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2026-10-20 (port; the draft is dated 2026-10-18) |
| Decision-makers | Cyprien PIERRE |
| Proposed by | assistant model, plan « Workflow KLean K7PL » (draft ADR-004); ported by Claude Code (agent) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), items 43 and 52 (related), 53 |
| Depends on | [ADR-0003](0003-k-blocks-in-verso-and-extraction.md), [ADR-0006](0006-klean-as-audited-translator.md) |
| Work packages | WP3, WP7–WP9 |
| Gates | G4 |

## Context and Problem Statement

According to the documents analysed (to be confirmed by the WP4 audit), klean translates hooks
into uninterpreted functions accompanied by axioms, and ignores priorities and `ensures` clauses.
The generated relation would then be an over-approximation of K: universal properties transfer to
K, but existential properties do not. Restricting normative K to a well-chosen subset makes the
translation **exact**.

## Considered Options

Rejected alternatives listed by the draft:

- **Full K + accepted over-approximation**: existential properties are lost.
- **Full K + in-house generator that handles everything**: high and immediate cost; remains an
  option of [ADR-0006](0006-klean-as-audited-translator.md).

## Decision Outcome

Proposed decision. Normative K (blocks with `normative=true`) MUST respect the following rules:

| ID | Rule |
|---|---|
| K1 | Every rule has a `label` equal to the `id` of its block. |
| K2 | No `priority`, `owise` or `ensures` in the normative semantics. |
| K3 | Every `function` is marked `total` and its cases are exhaustive. |
| K4 | Hooks limited to an allowlist (basic `INT` and `BOOL` operations, exact list in `tools/klint/allowlist.json`). Each hook is implemented in Lean in the Prelude ([ADR-0005](0005-executable-axiom-policy.md)) and tested (T4). |
| K5 | No hooked collections in normative K, unless decided by [ADR-0009](0009-layer-3-array-representation.md). |
| K6 | An automaton = one pure K `function`, invoked by an orchestrator rule. It never spans several rewriting steps. |
| K7 | Productions and rules that cross a layer appear only in blocks with `kind=bridge`. |
| K8 | K `macro` and `alias` forbidden unless by derogation: they disappear before KORE. |
| K9 | `strict` and `seqstrict` allowed: the administrative steps (heat/cool) are treated as τ in Lean. |

1. **The `klint` linter checks the KORE** (where attributes are preserved) rather than the `.k`
   text. Its output is `reports/lint.json`.
2. **Derogation:** a dedicated ADR stating the rule concerned, the justification and the
   treatment on the Lean side (for example a priority-filtered relation and a restricted
   existential status).
3. **Evolution:** if the audit shows that klean handles a construct correctly (for example
   priorities), the corresponding rule MAY be relaxed by amending this ADR.
4. Blocks with `normative=false` (illustrative) are not subject to the profile.

### Consequences

- (+) The generated relation is exact on normative K: existential properties become transferable
  (status `proved-exact`).
- (+) Atomicity of automata guaranteed by construction (K6).
- (−) Reduced expressiveness: some idiomatic K formulations (`owise`) must be rewritten with
  explicit guards.
- (−) Maintenance of the allowlist and of the linter.

### Confirmation

- G4: any violation not covered by a derogation fails CI.
- The linter has one positive and one negative case tested per rule.

Neither the linter nor G4 exists in the repository yet.

## Owner decisions already given

- **Item 53** (2026-10-19): « ok => à faire » for ADR-003…010: the work is requested; the profile
  is not accepted by it.
- **Item 52** (2026-10-19, related): « toute fonction ou groupe de fonctions mise en production
  est appelé automate ». Rule K6 defines an automaton as *one* K function; whether K6 must also
  cover a group of functions is not decided.
- **Item 43** (2026-10-19, related): option (c) excludes the Map/Set/List collection hooks from
  the generated Prelude, which is consistent with K5 but does not decide it.

## Open questions

- **Q1** — names and definitions of the three layers; matrix of allowed crossings (K7; WP7).
- **Q2** — orchestrator model: sequential or concurrent, determinism required (K6; WP8, O12).
- **Q3** — array representation ([ADR-0009](0009-layer-3-array-representation.md)), which
  conditions the exception in K5.
- The klean audit (T-401) may amend K2 and K4 (clause 3).

## More Information

### Notes on the port

- Translated from the French draft `adr/ADR-004-profil-k7pl-de-k.md` of the plan « Workflow
  KLean K7PL » (18 October 2026); the plan and its instruction are session notes, not deposited in
  the repository.
- Role placeholders replaced by the single decision-maker
  ([ADR-0011](0011-decision-records-roles-and-workstream-n.md)).
- The status name `prouvé-exact` is translated as `proved-exact`, as in
  [ADR-0007](0007-computed-assurance-statuses.md).
- `tools/klint/` and `reports/lint.json` are the plan's proposals; `tools/klint/` is compatible
  with the repository layout; the instruction notes that `reports/` would be CI artefacts rather
  than a tracked root directory (X-7, §4.3).
- Repository state when ported (KLean instruction, §4.5): the K block of
  `spec/Spec/CodeArtifacts.lean` would violate K1 (unlabelled `typeOf` equations, if K1 covers
  functions), K3 (`typeOf` partial, no `total`) and K4 (`==K` from `K-EQUAL`).
- The klean facts of the context (hooks, priorities) are partly confirmed by the instruction's
  static reading of the `kframework==7.1.337` wheel (template Prelude with 41 `axiom` declarations
  for Map/Set/List hooks; `Rewrite.lean` described as an over-approximation that ignores rule
  priorities); no klean run was made, so the WP4 audit remains required.
