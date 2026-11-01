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

The corrected head has not yet completed its rerun. Do not report the 39
profiles as green, an all-green CI result, or a promoted model status until
that rerun completes. A negative profile counts as successful only when TLC
reaches the named invariant violation; configuration, parser, ASSUME, type or
wrong-invariant failures are failures.

## Next actions

1. Inspect the Deno format/check/lint/tests, registry validation, REUSE and
   CommitLint results on the updated PR head.
2. Review the uploaded tla-model-check-evidence: all 39 TLA profiles must
   meet their expected positive/negative result, and the R9 logs must be
   retained. D01 is separately evidenced by d01-tlc-evidence.
3. If the profiles complete, keep model status labels unchanged until actual
   traces and state-space completion have been reviewed against their declared
   witnesses and limits.
4. Continue the model-quality work in CHAPTER-COVERAGE.md; use
   WORK-PLAN.md for sequencing only, and wiki/assurance.md for the
   authoritative theorem/gap register.
