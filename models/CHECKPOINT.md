<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL TLA+ workstream checkpoint

**Snapshot:** 2026-11-01, after source commit \`a173e227445df7a1a9966d7d443360a41248c36a\`.  
**Repository:** AntheaLiles/k7pl.  
**PR:** #319, branch \`fix/tla-ci-unified-suite-2026-10-31\`.  
**Source head:** \`a173e227445df7a1a9966d7d443360a41248c36a\`.  
**Base:** \`main@2fbf609f6f3e67ffe011a3f28fd247526684155a\` (rechecked; unchanged).  
**PR state:** open, not draft, not merged.

## Repository and process state

- \`models/\` remains at repository root and intentionally flat.
- PR #311 remains open and unmerged; it is not the normative source.
- Applicable clauses were checked against current \`main\` at the PR base SHA.
- \`wiki/assurance.md\` remains the central theorem/gap register. H1–H3
  remain open; no TLA-07 claim discharges them.
- All writes were fast-forward updates to this PR branch. No main-branch write,
  force-push, protection bypass or merge occurred.

## Commits added by this remediation pass

| SHA | Commit | Scope |
|---|---|---|
| \`dafbc608f8c94a97644f336286cc228e94d3d975\` | \`fix(tla): repair blocking model checks\` | TLA-02/TLA-07/TLA-12 initial fixes; strict D01/R9 predicates; REUSE header |
| \`399242330c8d81e54975d60cf3e184f7d843195a\` | \`fix(tla): make profile sentinels parser-safe\` | Move TLA-02 sentinel to module; CFG parser fix; TLA-07 LET binding |
| \`70a15318a546b88211b97aad7ca157a83a79ac5f\` | \`fix(tla): avoid nested capability index expressions\` | TLA-07 LET binding in GrantCapability |
| \`279f160b61c5502b2cb730841377ef4c4d88fbd6\` | \`fix(tla): model prepared-patch revocation interleaving\` | TLA-12 revocation model/invariant/control; 40th profile; correct TLA-01 oracle |
| \`a7a6d631f0c19876b0437276e6cd6e8bec79a3de\` | \`fix(tla): correct control profile comment syntax\` | TLA-12 CFG comment syntax |
| \`8e661c718f1f55cfec39b168ef80a624289ebce1\` | \`docs(tla): record live remediation evidence and gates\` | Checkpoint, roadmap, gates, dependencies, toolchain evidence |
| \`9410a577c195d9fec828f47f92dbf23570f97fc6\` | \`docs(tla): qualify model coverage and property sensitivity\` | Sensitivity matrix and TLA-01/03/07/12 work-plan notes |
| \`a173e227445df7a1a9966d7d443360a41248c36a\` | \`fix(tla): enforce capability reuse and revocation invariants\` | TLA-07 monotone revocation history and safe generation reuse; TLA-12 action completeness; REUSE annotation |

Every commit above was appended without force-push.

## Source changes in the latest commit

- TLA-07 \`Allocate\` rejects a generation already recorded as stale, unless a
  preceding \`ReuseSlot\` explicitly marked an unsafe finite-generation collision
  under \`AllowGenerationWrap\`. The marker is consumed when the slot is allocated.
- TLA-07 records \`everRevokedCapabilities\` monotonically. Destroy and explicit
  revocation add to this history; normal grant cannot reactivate a historically
  revoked capability. The intentionally unsafe restore control can, making
  \`NoCapabilityRevival\` falsifiable instead of tautological.
- TLA-12 parenthesises the disjunction assigned to
  \`appliedAfterRevocation'\`, preventing operator precedence from leaving that
  variable unspecified in \`ApplyPatch\`.
- \`REUSE.toml\` includes the new JSON oracle in the existing CC0 annotation,
  because JSON cannot carry an SPDX comment.

These are model-level corrections to existing candidate invariants and
controls. They do not ratify language semantics, establish region ownership,
or decide the lifecycle of a prepared patch after revocation.

## Latest complete TLC evidence inspected

Run [41310176908](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908)
used source SHA \`a7a6d631f0c19876b0437276e6cd6e8bec79a3de\` and the 40-profile
manifest (18 positive, 22 negative):

- 37/40 profiles reached the expected outcome: 17/18 positive and 20/22
  negative.
- TLA-02 positive and negative both passed after the CFG sentinel correction.
- All TLA-07 profiles parsed; three did not meet the expected result:
  - positive \`tla07-capability-lifetime\`: \`NoStaleEntityAlias\` violated
    after \`Init → Allocate → Destroy → Allocate\`; 8 generated, 8 distinct,
    3 queued, depth 4.
  - negative \`tla07-revocation-restore\`: full exploration completed
    (23,211 generated, 5,292 distinct, queue empty, depth 19), but the expected
    \`NoCapabilityRevival\` violation did not occur. Restore removed the
    capability from the current revoked set as it added it to the active set;
    historical revocation was not recorded.
  - negative \`tla12-apply-after-revocation\`: TLC reported an incomplete
    successor for \`ApplyPatch\`, with \`appliedAfterRevocation\` unspecified;
    13 generated, 11 distinct, 6 queued, depth 4.
- TLA-12 positive passed (49 generated, 33 distinct, queue empty, depth 7).
- The new source commit \`a173e227...\` addresses those three model defects.
  It has **not yet been validated by TLC**.

The full artifact is [\`tla-model-check-evidence\` — run 41310176908,
artifact 13085331418](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908/artifacts/13085331418).
It contains 116 archive entries; all 115 entries in \`SHA256SUMS\` were
verified. TLC 1.7.4 JAR digest was verified by the workflow as
\`936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88\`.
Uploaded artifact SHA-256:
\`3c6ab091887715f0cd38f3a2bf59570a929bfca8b1ad74cb6aa979e9b6135e1d\`.

## CI state by exact source SHA

- Run [41310176908](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908)
  on \`a7a6d631...\` fails overall because of the three TLA profiles above and
  the missing REUSE annotation for
  \`models/TLA12-Revocation-ExpectedCounterexample.json\`.
- Deno CI-controller checks passed: \`deno task fmt\`, \`deno task lint\`,
  \`deno task check\`, \`deno task test\`; 327 tests passed, zero failed.
  Derived-surface/classifier checks passed.
- CommitLint, actionlint, zizmor, gitleaks and OSV checks passed.
- Python tooling checks passed.
- Lean build completed (1,287 jobs); Lean inventory/axiom audits passed.
- Verso specification build completed (1,578 jobs), specification checks,
  PDF and HTML artifacts succeeded.
- D01 standalone TLC passed with the exact \`ProtectedIntegrity\` violation
  and a trace; artifact 13085037909 was produced and remains consumed by
  \`k-smoke\`.
- K semantic compile/examples/Verso Blueprint rendering remained in progress
  at last observation; do not infer its completion from independent Lean or
  specification builds.
- Run [41311344952](https://github.com/AntheaLiles/k7pl/actions/runs/41311344952)
  is attached to the current source SHA \`a173e227...\` and is \`pending\` with
  no jobs created at last observation. Run 41310176908 still holds the workflow
  concurrency slot with its K/Verso job in progress.
- No current-source-head verdict exists for the 40-profile suite or REUSE.

## Remediation status

- **P0:** open. The latest complete 40-profile result is 37/40 on
  \`a7a6d631...\`; the three source corrections and REUSE annotation are on
  \`a173e227...\`, but that SHA has not yet been validated.
- **P1:** partially implemented. TLA-01 oracle matches the observed one-edge
  Simulation witness; TLA-12 models revocation between handling and apply, but
  pending-patch disposition is open. TLA-03 termination is vacuous in the
  positive profile; TLA-07 ownership/rights preservation is not established by
  fixed disjoint cell sets; TLA-05/09/11/16 limits are in CHAPTER-COVERAGE.
- **P2:** clause mapping checked against current main at the base SHA. G3
  (valid termination), G7 (region/range ownership and rights operations), G18
  (prepared-patch lifecycle), fairness and K/TLA/Lean relation remain open.
  No KState/TLAState relation, refinement map or simulation theorem is claimed.
- **P3/P4:** deferred pending concrete target/runtime/integration contracts.
- \`wiki/assurance.md\` is unchanged: no existing theorem/gap was discharged.
  H1–H3 remain open and are not covered by TLA-07.

## Next actions

1. Validate the exact \`a173e227...\` head on a fresh completed CI run:
   40 TLC profiles, REUSE, Deno, Python, Lean, K and Verso.
2. Inspect every profile's diagnostic, generated/distinct states, queue, depth
   and trace in the 40-profile artifact. Do not transfer \`a7a6d631...\`
   results to the current head.
3. Obtain explicit owner decisions for G3, G7 and G18; do not introduce
   fairness, completion predicates, ownership algebra or patch-disposition
   semantics without ratification.
4. Preserve the separation between abstract atomic TLA-16 and concrete
   weak-memory implementation; defer P3/P4.
5. Keep PR #319 open and unmerged.
