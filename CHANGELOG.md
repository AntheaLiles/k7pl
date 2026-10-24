<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Changelog

All notable changes to this project are recorded in this file.

This file tracks the implementation and the repository (releases `vX.Y.Z`); the
specification has its own history in [`spec/CHANGELOG.md`](spec/CHANGELOG.md)
(releases `spec-vX.Y.Z`).

The format is inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- K7OS exploration portfolio: preserve the previously studied shared-address-space/unikernel target, alternative isolation architectures, actor-memory constraints, native/FFI and DMA boundaries, concurrency, cancellation, recovery, persistence, budgets, boot and build-chain options in a separate non-normative dossier. Update the SPEC-D register to reflect merged R4/R5 reports and map language obligations separately from OS-realization decisions. No target architecture or new normative K7PL guarantee is ratified.


- R9 model-checking research: compare TLC, Apalache, Lean and stateful testing; add a bounded actor-cancellation TLA+ model, nominal and negative configurations, a counterexample-to-test vector and a bidirectional traceability convention. TLC CI checks the nominal invariants over 9 reachable states and reproduces the intended counterexample to the stronger cancellation claim. Correspondence with the full normative K7PL semantics remains open. Non-normative.

- R8 OS-design research: compare language-isolated, capability-based, hardware-compartment, microkernel, unikernel, and verified-compilation architectures; extend the analysis to TempleOS, Oberon, GNU Hurd, Multics, FreeBSD, PICK, DBOS, Plan 9, Inferno, A2/Bluebottle, 9front, Harvey, MINIX 3, QNX Neutrino, OpenBSD pledge/unveil, Qubes OS, Redox, Medley Interlisp and k23. Distinguish OS protection from runtime, database, transaction and namespace models. Correct a mistaken candidate identification to Qubes OS. Non-normative; no OS architecture is ratified.

- R7 OS-design research: distinguish logical replay from crash consistency and external-effect semantics; specify open obligations for durable logs/checkpoints, linear-resource recovery, retries, budgets, and fault-injection testing. Non-normative; no end-to-end crash-recovery guarantee is claimed.

- R6 OS-design research: audit abstract grade/budget arithmetic against operational cost semantics, compilation, binary-level WCET analysis, CPU budgets, scheduling feasibility, and target-specific assumptions. Non-normative; no end-to-end real-time guarantee is claimed.

- R4 OS-design research: audit the static-DAG/dynamic-wait-graph proof obligation, separate local/global progress from fair termination, and define testable contracts for timeout, cancellation, crash recovery, and resource cleanup. Non-normative; liveness guarantees remain conditional where the model or fairness assumptions are open.

- R3 OS-design research: define relational confidentiality/integrity obligations, observation boundaries, controlled declassification and endorsement, timing-channel limits, and adversarial test cases. Non-normative; no global information-flow guarantee is claimed.

- R0 OS-design research: add a versioned threat model, observation model, assurance matrix, falsification cases, and architecture gates. Non-normative; no OS guarantee is promoted to established status.

- GitHub Wiki publication from docs/, excluding docs/archives/**, with deterministic page names, export tests, navigation indexes, and a commit-bound SHA-256 manifest.
- Proof visualizations: observations of five selected Lean proofs, extracted with Paperproof in an
  isolated Lake workspace (`tools/paperproof-export`, Lean 4.34.0) and rendered natively by a Verso
  extension (`tools/SpecExt/ProofVisualization.lean`) in HTML and TeX (#216); transition layout (#221).
  These are non-normative observations; their human review is tracked in
  `docs/tracking/PROOF-VISUALIZATION-HUMAN-REVIEW.md`.
- Navigation of the published specification: figure-provenance catalog (#136), semantic reference
  graphs (#138, #141, #144, #146, #150), a graph derived from the rendered Verso HTML (#184), a
  searchable interactive relation graph published with the site (#196) and progressive explanations
  (#208).
- Figures: reproducible TikZ pipeline for HTML and PDF (#127, #133, #135, #142); every figure of
  the specification is now a TikZ source under `spec/figures/tikz/`, whose PDF and SVG are generated
  in CI and not tracked (#223). Long descriptions of figures are linked, and PDF page splits inside
  figures are prevented (#149).
- C8 statement ontology: shared ontology and controls for statement blocks (#131, #134) and
  migration of 69 statements (#139).
- Compliance: Lean prototype of a Lake-manifest-to-SPDX consistency audit (`K7plCompliance`,
  `sbomAudit`) (#128) and bounded assurance evaluation tests (#151).
- CI: automated checks of the OpenSSF badge criteria (#129).

### Changed

- Specification wording: context-sensitive vocabulary cleanup and a source-anchored lexical-family check integrated into `scripts/controle.py`; unrelated words such as `violet` remain allowed.
- C8 statement inventory check (`scripts/controles/statement_inventory.py`): the pre-migration
  snapshot, which fixes the 69 historical labels and their levels, is now a frozen appendix of
  `docs/tracking/LEAN-STATEMENT-MIGRATION.md`; a test pins its SHA-256 digest.
- CI: Conventional Commits enforcement restored in commitlint, with the project types `licensing`
  and `a11y` (#224).
- `K7pl.MemoryCapability` no longer imports the whole of `Mathlib.Tactic` (#225).
- `tooling/` is folded into `tools/`: the Paperproof workspace is now `tools/paperproof-export/`,
  and the B/C/D prototypes are `tools/prototypes-bcd/` with English file names (`AnnexB.lean`,
  `AnnexC.lean`, `AnnexD.lean`). The prototypes become the non-default `lean_lib`
  `K7plPrototypes`, which the `spec` job of `verify.yaml` builds.
- Compliance audit: reject an empty Lake inventory, state the exact Boolean/predicate equivalence in Lean, and cover the empty-inventory behavior in model and CLI regression tests.
- Compliance audit: align Lean package-name validation with the SPDX wrapper for empty, ASCII-whitespace-only and Unicode-whitespace-only names; add regressions for both layers.
- SPDX assurance research: preserve a case-by-case non-gating negative-corpus review and attach workflow identity plus hashes of the corpus, validator, generator, configuration and dependency locks to v2 probe reports.
- SPDX validation: reject undeclared SPDX 2.3 root properties in the wrapper after confirming that `spdx-tools 0.8.5` accepted a field forbidden by the pinned JSON Schema; add unit and CLI regressions.
- Added an empirical probe for an undeclared top-level SPDX JSON field; the new probe remains non-blocking until its external-validator behavior is observed and interpreted.

### Security and research

- Assurance tooling: add deterministic adversarial mutation tests for the Lake-to-OSV adapter and record the observed OSV-Scanner, actionlint, zizmor, and generated-figure accessibility results with their limitations. This does not introduce a general fuzzer, a Lean SAST claim, or a blocking vulnerability gate.
- R1 OS-design research: compare typed, software, kernel, and hardware capabilities; specify revocation and in-flight-operation semantics; document FFI ownership modes, device-access boundaries, and formal obligations. Non-normative; no security guarantee is marked established.
- R2 OS-design research: map source-to-binary assurance boundaries, define the semantic observations a compiler must preserve, compare verified compilation and translation validation, and stage the zero-overhead target. Non-normative; no end-to-end compiler guarantee is marked established.
- R5 OS-design research: distinguish abstract capability counting from a complete memory-safety argument; map H1/H2/H3, borrowing, fractional permissions, alias provenance, FFI, and weak-memory proof obligations. Non-normative; end-to-end memory safety remains unestablished.

## [0.0.0-alpha.1]

### Added

- CI: Lean diagnostics and REUSE violations are now annotated according to a selective, prioritised policy, without adding write permissions on pull requests (#64, #66).
- OpenSSF audit (`docs/security/`): six independent audits (Scorecard, CII best practices, GitHub governance,
  supply chain, assurance, quality), consolidated matrix, remediation plan, decisions and required human
  actions, threat model and claims register. Agent reports, not validated by a person.
- CI: `scripts/ci/check_lean_modules.py` (Lean modules that `lake build` never compiles), axiom audits of
  `SpecExt`, `SpecBib` and of the test modules, `use_cache` input of `verify.yaml`, `scripts/ci/check_manifest.py`
  (Lake manifest check) and tests of `scripts/ci/` (all run by `unittest discover`).
- `zenodo.yaml`: Zenodo archiving of the bytes of the published release, after verification of the release and
  of the PDF attestation; fails by default as long as the Zenodo concept is not declared.

- DOI (Zenodo), Software Heritage (origin, and directory of the `0.0.0-alpha.1` release
  with its qualified SWHID, to be updated at each `spec-vX.Y.Z` release) and fair-software.eu badges
  in the README, with `.howfairis.yml`: the "registry" criterion is declared out of scope there, the
  "checklist" criterion remains unsatisfied (4 out of 5).
- CI: parallel jobs `quick`, `impl`, `spec` and aggregated check `CI OK`; targeted axiom
  audit (`scripts/axiom-audit.sh`); hardened concurrency, timeouts and triggers; job annotations and summaries, axiom audit of the specification, check of the
  local links.
- The specification manuscript in Verso (`spec/`), converted from Org-mode; Verso extensions
  (`tools/SpecExt/`: cross-references, sealed statements, formulas, figures, tables, per-chapter
  citations, margin notes, lists); generated bibliography (`tools/SpecBib.lean`,
  `docs/bibliography/references.json`).
- Reproducible Org → Verso conversion (`scripts/org2verso/`), bibliography chain
  (`scripts/biblio/`), Org → Markdown conversion (`scripts/org2md.py`), manuscript metrics and
  tracking views (`scripts/manuscript_metrics.py`, `scripts/suivi.py`).
- Checks on the Verso (`scripts/controles/`, `scripts/controle.py`, run in CI): algebra at the bounds, seals, propagation, grammar × rules cross-check, structure.
- `docs/`: tracking (dashboard, 190 records of the PR-02 campaign, decisions, anomalies),
  reviews, method, research, session log; `archives/`: frozen Org manuscript and former
  tooling.
- Repository initialisation (structure, REUSE licences, CI, Lake project).
- Mathlib, CSLib and Verso dependencies, pinned on Lean v4.34.0.
- Examples: `K7pl.Arith` (Mathlib), `K7pl.Semantics` (CSLib) and their tests.
- Specification in Verso (`spec/`) and HTML generator (`lake exe spec`).
- CI: build, tests and generation of the specification; Conventional Commits lint.
- Strict Lean options (`autoImplicit` disabled, blocking warnings),
  Mathlib linters, `lake lint` (Batteries) and axiom audit in CI.
- Publication of the specification on GitHub Pages.
- Security CI: actionlint, gitleaks, OpenSSF Scorecard; Dependabot for
  GitHub Actions; actions pinned by SHA.
- Grouped version bump of Lean, Mathlib, CSLib and Verso
  (`scripts/bump-lean.sh`, monthly workflow).
- `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `CITATION.cff`,
  issue and pull request templates.
- `SessionStart` hook for Claude Code sessions on the web.
- PDF of the specification generated in CI (Verso → TeX → LuaLaTeX, `spec-pdf` artifact).
- Publication on Zenodo at each `spec-vX.Y.Z` release (`scripts/sync_zenodo.py`,
  adapted from quickViz); the PDF is also attached to the release. Implementation
  releases (`vX.Y.Z`) are independent.

### Changed

- `release.yaml` redesigned for immutable releases: tag push, checks (tag on `main`, `CI OK`), build
  without cache, release draft with PDF, checksum and attestation; publication remains a human action. Fixes
  two defects that prevented it from attaching the PDF (upload after publication of an immutable release; missing
  `GH_REPO`). Not yet run end to end.
- `sync_zenodo.py`: no more `zenodo-state` state branch, instance and concept declared explicitly, refusal before
  any network call if the configuration is incomplete.
- `bump-lean.yaml`: a build job without secrets, a PR-opening job that runs no Lean code;
  `check_manifest.py` ties each of the 14 packages to its repository and compares, over the network, the inherited
  packages with the manifests published upstream (`--check-upstream`). A new transitive dependency makes the check
  fail until a person adds it to the list.
- `release.yaml`: the tag is re-checked just before the draft is created; the release notes separate
  the verification commands for before and after publication.
- `sync_zenodo.py`: any error after the publication is sent writes the DOI and exits with code 3 (instead
  of a silent success when the read-back is refused); `NEW` refuses to run if `GITHUB_RUN_ATTEMPT` is
  not `1`.
- `sync_zenodo.py` (following an independent re-audit): a read-back that is not an object, a report error or
  an interruption no longer prevents writing the DOI; only 400, 401, 403, 404 and 422 responses prove
  that no publication took place; a malformed token is refused without being displayed.
- `CONTRIBUTING.md`: exact `commitlint` criteria (every commit is read, header of at most 100 characters) and local
  check procedure; steps to follow when the manifest check refuses a new dependency, which `check_manifest.py` now
  states in its failure message.
- `check_manifest.py` is run by the impact job of `ci.yaml` at every run, and also checks `configFile`,
  `manifestFile`, `version` and `fixedToolchain`; `check_lean_modules.py` refuses a computed `srcDir`; `impact.py`
  quotes the paths it prints.
- Session hook: elan installed by version and recorded checksum, no more `curl … | sh` on `master`.
- Dependabot: seven-day delay (`cooldown`) before proposing a new version.
- `ci.yaml`: `scripts/ci/impact.py` is the only source of the paths that force the full verification (a
  redundant shell regex, five of whose eight alternatives matched nothing, is removed);
  `scripts/axiom-audit.sh` also triggers the build of the specification.
- PDF compilation: `SOURCE_DATE_EPOCH` and `-Z deterministic-mode`; compilation log kept. The PDF
  is not thereby shown to be reproducible.
- README: CI badge fixed (it pointed to a deleted workflow); publication flow described as not yet
  run end to end. `CONTRIBUTING.md` and `SECURITY.md` aligned with these changes.
- `LICENSE` becomes `LICENSE.md`; the references (README, writing rules) are updated.
  Markdown formatting of the file, text unchanged (two bullets and their paragraphs
  were displayed as code blocks).
- `CITATION.cff`: version `0.0.0-alpha.1`, that of the `spec-v0.0.0-alpha.1` tag; the release
  check of the `zenodo` job compares these two values and had failed on `0.0.0`.
- The specifications move from Org-mode to Verso.
- The source code (identifiers, docstrings, comments) is now in English.
- `CITATION.cff` describes the specification (CC-BY-4.0, ORCID) with a view to the Zenodo DOI.

### Fixed

- CI: `controle.py` annotations escaped and deduplicated; Tectonic cache key tied to the sources
  (a cache with a fixed key was never rewritten); link check without `archives/`.
