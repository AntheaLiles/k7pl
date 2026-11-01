<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL TLA+ workstream checkpoint

**Snapshot:** 2026-11-01, live repository state observed during this pass.  
**Repository:** AntheaLiles/k7pl.  
**Branch:** `fix/tla-ci-unified-suite-2026-10-31`, PR #319.  
**Current head:** `a7a6d631f0c19876b0437276e6cd6e8bec79a3de`.  
**Base:** `main@2fbf609f6f3e67ffe011a3f28fd247526684155a` (rechecked; unchanged).  
**PR:** open, ready for review (not draft), not merged.

## Current repository state

- Models remain at repository-root `models/`, intentionally flat.
- PR #311 remains open and unmerged. Its head is not a normative source;
  current specification clauses were rechecked against main at the base SHA.
- `CHAPTER-COVERAGE.md` is the live model coverage matrix;
  `OPEN-GATES.md` records semantic questions; `WORK-PLAN.md` records
  model scope; `wiki/assurance.md` remains the central theorem/gap register.
- No main-branch write, force-push, protection bypass or PR merge occurred.

## Commits added in this remediation pass

| SHA | Commit | Scope |
|---|---|---|
| `dafbc608f8c94a97644f336286cc228e94d3d975` | `fix(tla): repair blocking model checks` | Initial TLA-02/TLA-07/TLA-12 source corrections; strict D01/R9 shell predicates; REUSE header |
| `399242330c8d81e54975d60cf3e184f7d843195a` | `fix(tla): make profile sentinels parser-safe` | Move NoPair to a module operator; remove unsupported tuple assignments from CFG; LET binding in TLA-07 invariant |
| `70a15318a546b88211b97aad7ca157a83a79ac5f` | `fix(tla): avoid nested capability index expressions` | LET binding in TLA-07 GrantCapability |
| `279f160b61c5502b2cb730841377ef4c4d88fbd6` | `fix(tla): model prepared-patch revocation interleaving` | TLA-12 revocation action/invariant/negative profile; correct TLA-01 SimulationGap expected trace; profile inventory 40 |
| `a7a6d631f0c19876b0437276e6cd6e8bec79a3de` | `fix(tla): correct control profile comment syntax` | Correct TLA CFG comment syntax in the new revocation control |

Each commit was appended by a non-forced fast-forward ref update against the
immediately preceding head. The PR head above is the current source revision.

## Source changes in this pass

- TLA-02: `NoPair` is now defined in the TLA module as a pair, rather than
  assigned as a tuple literal in a TLC configuration (the CFG parser rejected
  that syntax).
- TLA-07: local `LET` bindings isolate `CapSlot(c)` in
  `WriteCell`, `ValidCapabilitiesMatchGeneration` and `GrantCapability`.
- TLA-12: `frameOverrun'` now assigns the explicit parenthesised disjunction.
  The later candidate extension models revocation between `HandleEvent` and
  `ApplyPatch`, tracks post-revocation application and adds a negative profile.
- TLA-01: the authored SimulationGap JSON was corrected to the observed
  one-step TLC witness; it no longer claims that a wait cycle was observed.
- D01/R9 negative shell checks now require TLC's exact named invariant
  violation and a counterexample trace header, and reject parser, semantic,
  ASSUME and TypeOK failures.
- The TLA inventory is now 40 profiles: 18 positive and 22 negative.
  The controller test expects 22 negative profiles.

## Validation evidence and limits

### Latest complete TLC artifact inspected

Run [41308633862](https://github.com/AntheaLiles/k7pl/actions/runs/41308633862)
was executed on `dafbc608f8c94a97644f336286cc228e94d3d975`, with the previous
39-profile manifest:

- 16/18 positive profiles reached the no-error TLC completion diagnostic.
- 17/21 negative profiles reached their exact expected invariant violation.
- Six profiles failed before the expected verdict: TLA-02 positive and
  negative (tuple literal rejected in CFG parsing); TLA-07 positive and three
  negative controls (parser error in `ValidCapabilitiesMatchGeneration`).
- TLA-12 positive passed on the pre-revocation model (33 generated, 23
  distinct states, depth 7, queue empty); this does not validate the later
  revocation action or the new 40th profile.
- The D01/R9 shell checks passed with the stricter predicates. D01's
  standalone evidence artifact remains the input consumed by `k-smoke`.
- The unified artifact contained 113 files. Its `SHA256SUMS` file had 112
  entries, all verified after normalising a leading `./`; the TLC JAR
  SHA-256 was `936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88`,
  matching the workflow pin.

This is evidence for SHA `dafbc608...` and the old 39-profile inventory
only. It does not validate the later TLA-02/TLA-07 changes or the new TLA-12
interleaving.

### Current-head CI

- Current source head: `a7a6d631f0c19876b0437276e6cd6e8bec79a3de`.
- CI run [41310176908](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908):
  `pending`, with no jobs created at last observation.
- Documentation publication run 41310176530: `queued`.
- Earlier CI run 41308633862 remains `in_progress` in
  `Formal semantics / Compile K semantics, execute examples, export to Lean`,
  step `Render Verso Blueprint documentation`. Its job logs are no longer
  retrievable from the GitHub API (404 BlobNotFound); it was not cancelled.
  This unfinished run is currently preventing the newer CI run from starting.
- Intermediate runs 41309147207 and 41309882634 were cancelled after later
  commits advanced the branch. They are not validation evidence.

### Other checks observed on run 41308633862 (same parent SHA dafbc)

- REUSE: passed, 581/581 files with copyright and license information.
- CommitLint: passed (`Lint free!`); actionlint and zizmor: passed.
- Deno controller quick checks and registry/classifier shadow: passed.
- Python tooling checks: passed.
- Lean build and axiom audits: passed.
- Verso specification validation and PDF build: passed.
- D01 separate TLC and artifact producer: passed.
- Unified 39-profile TLC job: failed (33/39 expected outcomes).
- K semantic compile/examples/Verso Blueprint render: still in progress at last
  observation; no completion verdict.
- Exact independent `deno fmt`, `deno check`, `deno lint` and `deno test`
  command outcomes were not separately confirmed from the retrieved logs.

## Remediation status

- **P0:** open. The current 40-profile inventory has not completed on the
  current head. No current-head TLC verdict exists. P0.3 strict D01/R9
  predicates and P0.4 integrity inspection have evidence on the old run;
  P0.1 parser fixes remain unvalidated.
- **P1:** partially implemented, not closed. TLA-01 expected trace corrected;
  TLA-12 revocation interleaving represented. TLA-03 termination, TLA-07
  ownership, TLA-05 definitional checks, TLA-09 arithmetic dependence,
  TLA-11 one-step scope and TLA-16 atomic abstraction remain limitations.
- **P2:** current-main clause mapping rechecked; G3, G6/G7/G8/G9/G11/G14,
  and new G18 remain open. No KState/TLAState relation or simulation theorem
  is established.
- **P3/P4:** deferred; no concrete target/runtime or selected integration
  contract justifies those refinements.

## Next actions

1. Obtain a completed run for the current head and inspect the entire 40-profile
   artifact, exact state/depth/queue metrics, traces, TLC digest and checksum
   manifest. Do not transfer the 39-profile result to the current manifest.
2. If TLA-02/TLA-07 parser fixes pass, perform property-by-property sensitivity
   review; if they fail, fix the semantic cause and rerun the current head.
3. Obtain explicit decisions for G3 valid termination, G7 region ownership and
   G18 prepared-patch lifecycle. Do not add fairness or patch disposal policy
   without owner ratification.
4. Update the assurance register only when a theorem/gap status genuinely
   changes; H1–H3 remain open and are not covered by TLA-07.
5. Keep the PR open and unmerged.
