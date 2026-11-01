<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL TLA+ workstream checkpoint

**Snapshot:** 2026-11-01. The branch head is the current head of PR #319; consult
the PR for the exact commit SHA rather than pinning a checkpoint to a SHA that
changes with every correction commit.

## Current repository state

- Repository: AntheaLiles/k7pl.
- Model location: repository-root models/, intentionally flat.
- Work branch: fix/tla-ci-unified-suite-2026-10-31, PR #319, based on
  main@2fbf609f6f3e67ffe011a3f28fd247526684155a.
- PR #319 was open and ready for review (not draft) at the start of this
  correction pass. No merge to main is performed by this work.
- PR #311 remains open and unmerged; its head
  f3b33cd34e1da49a4c8c41ca632c586e66715e70 is a historical specification
  snapshot only. Its author explicitly requested that it not be merged before
  the lexical work is complete.
- The live coverage matrix is CHAPTER-COVERAGE.md; theorem and assurance
  gaps remain in wiki/assurance.md. The dated
  SPEC-COVERAGE-AUDIT-2026-10-31.md is historical, not the current main
  baseline.
- REMEDIATION-ROADMAP-P0-P4.md is the single remediation-priority register;
  REMEDIATION-EXECUTION-PROMPT.md is the reusable execution brief. The
  P0–P4 scale is distinct from the descriptive model-family groupings in
  WORK-PLAN.md.

## Corrections in this pass

- TLA-16 .cfg values now use the string values required by the module ASSUME.
- TLA-06 uses finite boolean occurrence indicators instead of unbounded
  counters; the first caller, foreign or post-ack event remains observable.
- TLA-12 has an explicit finite FrameLimit in both profiles. This is a
  model-exploration bound, not a physical frame-rate guarantee.
- TLA-14's authored negative witness now begins with the enabled
  SendClientHello transition.
- The 39 TLA-01..16 profiles are declared in TLC-PROFILES.json; Deno checks
  exact configuration/module coverage and runs each profile with failure
  accumulation and per-profile logs.
- D01 remains in the blocking r9-tlc job in ci.yaml and is also run by
  k7pl-semantics.yaml to produce d01-tlc-evidence for k-smoke. This duplicate
  run is intentional because the reusable semantics workflow is not part of
  CI OK. The unified tla-model-check-evidence contains D01 + R9 + TLA-01..16;
  d01-tlc-evidence remains the separate formal-chain input artifact.

## Validation state

The first end-to-end TLC run (workflow run 41305607506, on the
pre-parser-fix head) executed all 39 profiles. Ten of 18 positive profiles
completed without errors; twelve of 21 negative profiles reached their named
invariant violation. The remaining 17 profiles did not reach a model verdict:
TLA-01, TLA-02, TLA-05, TLA-07, TLA-12 and TLA-16 contained parse or semantic
analysis errors. These were corrected in the current branch head by making
set comprehensions and action quantifier scopes explicit, correcting the
TLA-05 disjunction grouping and the TLA-07 bracket mismatch. The negative
runner criterion was also tightened to require TLC's exact
`Error: Invariant <name> is violated.` diagnostic.

The first end-to-end run 41305607506 was on pre-parser-fix head efd0212b065016c206b9c83c0059f3623957959b: 10/18 positive and 12/21 negative outcomes matched. The corrected-source run 41306284770 was on head 29845511f018b80da543b975a995b477d4ba9cb4: 15/18 positive and 17/21 negative outcomes matched. Seven profiles still had no expected verdict: TLA-02 positive and negative stopped with a TypeOK evaluation error (the NoPairValue string sentinel is compared with a message-pair tuple); all four TLA-07 profiles failed parsing at the WriteCell expression on line 126; TLA-12 positive stopped because AdvanceFrame did not completely specify frameOverrun. The later CI run 41307048438 on the subsequent documentation/registry-test head 225112f22622390256c574d810933aa2acd23fdd was cancelled during branch updates. The current head therefore has no completed full CI run. Do not report the 39 profiles as green, an all-green CI result or a promoted model status until the current head completes CI and all 39 outcomes match. A negative profile counts as successful only when TLC reaches the exact named invariant violation; configuration, parser, ASSUME, type, timeout or wrong-invariant failures are failures.

## Next actions

1. Correct TLA-02 TypeOK's heterogeneous NoPairValue sentinel comparison;
   correct the TLA-07 WriteCell parser expression; make the TLA-12 AdvanceFrame
   action fully assign frameOverrun and rerun the three families.
2. Run all 39 profiles on the latest PR head and inspect each state count,
   queue exhaustion, trace, bound, TLC digest and retained D01/R9 log.
3. Close P0 in REMEDIATION-ROADMAP-P0-P4.md only after all 39 outcomes and
   required CI checks complete successfully on the current head.
4. Then work through P1 non-vacuity and property sensitivity, P2 current-main
   traceability and open semantic gates, and defer P3/P4 until their target
   contracts are explicit. Use CHAPTER-COVERAGE.md for coverage and
   wiki/assurance.md for the authoritative theorem/gap register.
