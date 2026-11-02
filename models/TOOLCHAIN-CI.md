<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# TLA+ toolchain and CI plan

## 1. Terminology

TLA+ is the specification language. TLC, Apalache and TLAPS are tools with different verification methods; they are not interchangeable language extensions.

| Name | Category | Intended use in K7PL | Important limit |
|---|---|---|---|
| TLA+ | Specification language | States, actions, transition relations, invariants and temporal properties | A specification is not checked until a tool runs it |
| SANY | TLA+ parser/analyser | Parse and analyse modules and imports | Syntax acceptance does not establish semantic correctness |
| TLC | Explicit-state model checker | Reachable-state exploration, invariants, deadlocks and temporal properties over configured finite models | Exhaustive only for the supplied model and finite configuration |
| Apalache | Symbolic/bounded model checker using SMT | Bounded symbolic exploration and supported invariant checks | Supported TLA+ subset and bound/mode must be recorded |
| TLAPS | TLA+ proof system | Mechanised deductive proofs, especially invariants | Not a substitute for TLC temporal/liveness exploration |
| PlusCal | Algorithmic notation translated to TLA+ | Optional notation for procedural protocols or schedulers | Additional source notation; no independent proof engine |
| PRISM | Probabilistic model checker | Conditional: quantitative probabilistic availability, latency or leakage models | Different probabilistic model and assumptions |
| GenMC | C/C++ concurrent-program model checker | Conditional: concrete weak-memory implementation of queues or atomics | Does not verify the abstract TLA+ model |

Primary documentation:
- TLA+ tools: https://lamport.azurewebsites.net/tla/tools.html
- TLA+ tools repository and CLI usage: https://github.com/tlaplus/tlaplus
- Apalache documentation: https://apalache-mc.org/docs/
- TLAPS repository/documentation: https://github.com/tlaplus/tlapm
- PRISM: https://www.prismmodelchecker.org/
- GenMC: https://github.com/MPI-SWS/genmc

## 2. Default tool choice

Start with TLA+ native notation and TLC.

For each model:
1. Parse and check module dependencies.
2. Declare finite constants and model bounds.
3. Run TLC for `TypeOK`, safety invariants, deadlock checks and temporal properties where appropriate.
4. Preserve the complete counterexample when a property fails.
5. Add Apalache only when symbolic encoding or bounded exploration adds value over explicit-state TLC.
6. Use TLAPS only for a distinct deductive obligation that is valuable in TLA+; do not duplicate the Lean proof effort without a reason.
7. Use external verification tools only for concrete profiles (probabilities, weak-memory program behaviour, etc.).

PlusCal is optional. It should not be introduced merely to make models look procedural. Choose it only if it materially improves reviewability of an algorithm-style protocol, and retain the generated TLA+ relationship in the evidence.

## 3. Tool-specific limits

### TLA+ native

A discrete logical clock can be represented as an ordinary state variable, tick action or bounded counter. A finite-state model can express waits, timeouts, frame numbers and deadlines abstractly.

TLA+ does not measure milliseconds, processor cycles or WCET. A result about a discrete deadline is only as meaningful as the mapping between ticks and the target execution profile.

### TLC

TLC is the default explicit-state checker. A successful run must record:
- exact TLA+ source revision;
- every imported module and tool version;
- every `.cfg` and its constants;
- invariants and temporal properties checked;
- workers and relevant CLI flags;
- state count, transition count and completion status;
- counterexample traces or proof of expected negative result;
- any symmetry, view or state-constraint reduction that changes the explored space.

Finite exploration is not a proof for unbounded actor counts, mailbox sizes, integer domains or event histories unless an additional theorem justifies that transfer.

### Apalache

Use Apalache for bounded symbolic analysis where SMT constraints on data and transitions are useful. Record:
- Apalache version;
- solver and solver version;
- supported language subset used;
- bound/length/depth;
- check mode and options;
- counterexample or successful bounded result.

Do not describe “no counterexample up to k steps” as proof for arbitrary execution lengths. Do not assume every TLC-supported construct has identical Apalache support.

### TLAPS

Use TLAPS only where a deductive proof in TLA+ serves a clear purpose. It may be useful for parameterised invariants or to establish model-level lemmas that are otherwise cumbersome. It is not the primary tool for temporal liveness; TLC remains the initial tool for those properties. Lean is already the project's main proof assistant and should remain primary for language-wide mathematical theorems.

### PRISM

Only introduce PRISM if K7PL adopts a precise probabilistic property: a probability distribution, observation model, adversary, time horizon and measurable outcome. It is not justified merely because a system has randomness or latency. Keep non-probabilistic TLA+ safety models independent from any probabilistic extension.

### GenMC

GenMC is a candidate only if the relevant concrete implementation is C/C++ and the selected memory constructs are within its supported model. It can explore behaviours of the concrete concurrent program under weak-memory assumptions. It does not prove that the K7PL abstract mailbox or join semantics is correctly implemented; that requires an explicit abstraction/refinement argument. If K7PL's runtime language changes, reconsider the concrete verification tool.

## 4. Existing repository baseline

Repository state reviewed on **2026-11-01**, with the workstream based on
`main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a`:

- D01 is checked in `r9-tlc` in `.github/workflows/ci.yaml`, which is a
  dependency of `CI OK`. It is also checked by `d01-tlc` in
  `.github/workflows/k7pl-semantics.yaml` to produce `d01-tlc-evidence` for
  `k-smoke`. This duplicate execution is intentional because the reusable
  semantics workflow is not itself part of the `CI OK` gate. Removing the
  duplication requires a verified cross-job artifact hand-off that preserves
  both the gate and the formal-chain consumer.
- R9 and TLA-01..16 are checked by `r9-tlc` in `.github/workflows/ci.yaml`;
  D01/R9/TLA-01..16 evidence is stored together in `tla-model-check-evidence`.
- The 39 TLA-01..16 profiles (18 positive, 21 negative) are declared in
  `models/TLC-PROFILES.json`. The Deno runner validates the manifest against
  every `TLA*.cfg` and every TLA/K7PL model module before execution; the
  controller test suite checks that a new or renamed profile cannot be omitted.
- The `tla-model-check-evidence` artifact contains D01 under `d01/`, R9 under
  `r9/`, and TLA-01..16 at the artifact root: sources, configurations,
  authored expectations, per-profile logs, Java identity, pinned TLC JAR
  digest and checksums. The separate `d01-tlc-evidence` produced by the
  reusable semantics workflow is consumed by `k-smoke`; neither artifact is
  described as a proof.
- TLC 1.7.4 is downloaded and verified against the pinned SHA-256 and SHA-1
  before execution. The unified artifact has fail-on-missing upload semantics
  and 14-day retention.
- First run 41305607506 on pre-parser-fix head
  `efd0212b065016c206b9c83c0059f3623957959b` executed all 39 TLA profiles:
  10/18 positive and 12/21 negative outcomes matched; 17 profiles had no model
  verdict because of parser/semantic defects in six modules.
- Corrected-source run 41306284770 on head
  `29845511f018b80da543b975a995b477d4ba9cb4` matched 15/18 positive and 17/21
  negative outcomes. Seven profiles remained unsuccessful: TLA-02 positive and
  negative stopped at TypeOK evaluation (string sentinel NoPairValue compared
  with a message-pair tuple); TLA-07 positive plus three negative profiles
  failed parsing in WriteCell line 126; TLA-12 positive failed because
  AdvanceFrame did not completely assign frameOverrun. The TLA job and CI OK
  therefore failed. The current branch head is later and contains documentation
  and registry-test updates; its full CI run has not completed. Do not call the
  suite green based on either run.
- The current CI design has a model-check stage but no separate fast TLA parse
  tier. A parser-only tier remains a proposal until the pinned TLC/SANY
  invocation and import-resolution behaviour are verified.
- `wiki/semantics.md` states that K, Lean and TLA+ remain corroborating
  descriptions and that the K ↔ TLA+ projection is open. If PR #311 later
  replaces that page, its `models/` path reference and non-normative disclaimer
  must be preserved in the successor documentation.


## 5. Proposed CI tiers

| Tier | Implementation status | Trigger | Checks | Evidence |
|---|---|---|---|---|
| TLA parse | **Not implemented** | Any `.tla` or `.cfg` change | SANY/parser and import resolution | Parser/tool version, module list, output |
| TLA model check | **Implemented** | `tla_model_check` impact surface | TLC checks for D01, R9 and TLA-01..16; the 39 TLA profiles accumulate failures and negative profiles must reach their named invariant violation | Sources, configs, authored expectations, per-profile logs, state counts, traces and hashes |
| TLA extended | **Not implemented** | Selected models or manual/full workflow | Apalache; TLAPS only when a proof is registered | Exact tool versions, solver, bounds or proof output |
| Formal-chain packaging | **Not implemented** | Model/proof/source changes | Package TLA, K sources, Lean source and matching evidence | Commit-matched archive with provenance |
| Concrete refinement | **Not implemented** | Runtime implementation changes | Model-specific tests and external concurrency checker where relevant | Runtime revision, platform profile, test traces |

Do not make every PR run every expensive analysis. Use a source-impact map, but ensure that shared modules trigger all dependent models and that manual/full execution remains available.

## 6. Evidence and reproducibility contract

For each CI run preserve:
- source commit SHA and repository revision;
- model module and imported modules;
- configuration file(s);
- constants, bounds and state constraints;
- exact tool binaries/version and verified digest where feasible;
- command line;
- exit code and log;
- properties checked and their declarations;
- number of states/transitions and whether exploration completed;
- counterexample trace, if any;
- negative-control expectation and whether it was reproduced.

The artefact must not be called a proof unless the verification method is a proof method and the statement's assumptions are explicit. Use “TLC model check passed for configuration X” rather than “K7PL property proved”.

## 7. CI rollout

1. Preserve the existing D01 and R9 checks while moving their working directory to repository-root `models/`.
2. TLA-01 is wired into the existing `r9-tlc` job when `tla_model_check` is selected. The first TLC attempt on the previous source revision failed in `.cfg` parsing; the adjacency-function correction is present, but the latest-head run is pending and no corrected TLA-01 result is claimed.
3. TLA-02..16 candidate modules and finite profiles are now present and routed through the same TLC suite; their runs remain pending. The TLA-02 selection policy is exploratory only, and G2 is not ratified.
4. TLA-03 fairness applies only in its explicit fair profile; it is not a normative scheduler guarantee. TLA-14/15 remain conditional, and TLA-16 remains an atomic abstract queue.
5. Model-selection/artifact coverage is grouped by the TLA workstream directory; any model/config/vector change triggers the suite. A future shared imported module must also trigger every dependent model.
6. Add Apalache only after a representative model demonstrates a concrete need.
7. Add cross-formalism evidence only after an explicit K/TLA or Lean/TLA relation exists.

The expanded suite adds candidate models and finite configurations without changing normative K7PL text. The current head has not yet passed TLC; the previous TLA-01 parser failure is recorded in `CHECKPOINT.md`. The suite result must be reviewed before any model status advances.


## 8. Live CI evidence — 2026-11-01

The manifest now contains 40 TLA profiles (18 positive, 22 negative), after
adding `TLA12-ApplyAfterRevocationControl.cfg`. The last inspected full TLC
artifact is still the 39-profile run [41308633862](https://github.com/AntheaLiles/k7pl/actions/runs/41308633862)
on `dafbc608f8c94a97644f336286cc228e94d3d975`: 16/18 positive and 17/21
negative outcomes matched. TLA-02's two configurations failed CFG parsing;
TLA-07's four configurations failed parsing in `ValidCapabilitiesMatchGeneration`.
Later source fixes and the TLA-12 revocation model are not covered by that
artifact. The artifact contains 113 files; all 112 entries in `SHA256SUMS`
were verified. TLC JAR SHA-256: `936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88`.
The separate D01 evidence artifact remained successful and consumed by
`k-smoke`.

For the same run/SHA `dafbc608...`, REUSE passed for 581/581 files, CommitLint,
actionlint and zizmor passed, controller quick checks and classifier shadow
passed, Python tooling checks passed, Lean implementation build and axiom
audits passed, Verso specification checks and PDF generation passed, and the
separate D01 TLC job passed. The unified TLC job failed (33/39 total expected
outcomes); K semantics compile/examples/Verso Blueprint render was still in
progress at last observation. The exact individual Deno fmt/check/lint/test
command outcomes were not separately confirmed in the retrieved log excerpts.

The current PR #319 source head is `a7a6d631f0c19876b0437276e6cd6e8bec79a3de`.
CI run [41310176908](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908)
is pending and has no jobs yet. The older K/Verso formal-chain job in run
41308633862 remains in progress at `Render Verso Blueprint documentation`,
blocking the queued run under workflow concurrency. Intermediate runs
41309147207 and 41309882634 were cancelled after later fast-forward commits;
they are not validation results. Do not label the current head validated.


## 9. Current 40-profile result and follow-up source head — 2026-11-01

Run [41310176908](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908)
on `a7a6d631f0c19876b0437276e6cd6e8bec79a3de` ran all 40 profiles and
reached 37/40 expected outcomes (17/18 positive, 20/22 negative). The exact
profile outcomes, generated/distinct/queue counts and depths are in
`CHAPTER-COVERAGE.md` §4.7.1. Three failures remained: positive TLA-07
`NoStaleEntityAlias` unexpectedly violated; negative TLA-07 `NoCapabilityRevival`
not violated after complete search (23,211 / 5,292 / 0, depth 19); and the
TLA-12 negative control's incomplete `ApplyPatch` successor (13 / 11 / 6,
depth 4). TLA-02 parser failures and TLA-07 parser failures were resolved.

Artifact [13085331418](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908/artifacts/13085331418):
116 entries, 115 SHA256SUMS entries verified; TLC 1.7.4 JAR SHA-256
`936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88` matches
the pinned release. Uploaded artifact digest
`3c6ab091887715f0cd38f3a2bf59570a929bfca8b1ad74cb6aa979e9b6135e1d`.

Deno controller tasks fmt/lint/check/test passed (327 tests, zero failures);
Python tooling, Lean 1,287-job build, Lean inventory/axiom checks, Verso
specification build (1,578 jobs), PDF, D01 TLC, CommitLint, actionlint,
zizmor, gitleaks and OSV checks passed. REUSE failed only because
`models/TLA12-Revocation-ExpectedCounterexample.json` was not included in the
CC0 annotation; commit `a173e227...` adds it. The K semantic compile/examples/
Verso Blueprint job remained in progress at last observation.

Commit `a173e227445df7a1a9966d7d443360a41248c36a` corrects the three TLA model
defects and REUSE annotation. Its run
[41311344952](https://github.com/AntheaLiles/k7pl/actions/runs/41311344952)
is pending with no jobs at last observation because 41310176908 still holds
the workflow concurrency slot. These source corrections are committed but
not validated; do not transfer the 37/40 result to `a173e227...`.
