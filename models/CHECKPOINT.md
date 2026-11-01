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
- D01 is run once in k7pl-semantics.yaml; the R9/TLA suite is run in
  ci.yaml. The artifacts are distinct: d01-tlc-evidence for D01 and
  tla-model-check-evidence for R9 + TLA-01..16.

## Validation state

The fixes in this commit have not yet been observed in a GitHub Actions run.
Do not report a successful TLC profile, an all-green CI result, or a promoted
model status until the current PR head completes its checks. A negative profile
counts as successful only when TLC reaches the named invariant violation;
configuration, parser, ASSUME or type failures are failures.

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
