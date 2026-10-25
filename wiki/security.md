<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Security

> **Provenance — Lot 2 (draft) completed in the
> security, decisions and docs-root closing of 2026-10-25.**
> Consolidated 2026-10-25 from the security directory in
> `docs/security/` (deleted in that closing): its dated campaign
> overview, threat model, conformance audit and roadmap,
> implementation status, security assurance case, governance,
> secrets policy, tooling evaluation, Lean security toolchain,
> human-actions checklist, badge automation and conformance
> matrix, maintainer-decisions file, and the workstream reports
> underneath it. The workstream reports are evidence, not a
> task list: their dated findings are summarised below with
> their dates and bases, and their wave-2 code changes live in
> the repository (workflows and scripts), not in this page.
> Nothing in this page is a human security review, and the
> maintainer decisions below remain open until the owner
> decides them.
> This page is about the **security of the build and publication
> chain** — workflows, dependencies, releases and accounts. It
> says nothing about the scientific correctness of the language,
> which belongs to [assurance](assurance.md). The two vocabularies
> must not be mixed.

## What this page is, and what it is not

The security material consolidated here is largely a dated
campaign record produced by agent sessions, not a human security
review, and not validated by the maintainer. Its documents
describe the repository at the date and commit they state; later
changes appear in them only where explicitly mentioned. The
workstream reports underneath the security directory are raw
agent reports: historical supporting evidence, not task lists to
work through, and not normative through their level of detail.

Status words used here for security are different from the
scientific assurance vocabulary: `VERIFIED` (observed),
`PARTIAL`, `PREPARED` (written, not run end to end, or dependent
on a human setting), `HUMAN ACTION REQUIRED`, `BLOCKED`,
`FUTURE`. A control marked `PREPARED` is not counted as present.

## Threat model in plain language

The threat model is a dated knowledge state, produced by an
agent session and not validated by the owner. It models the
repository, its build chain and its publication, not the
language itself: there is no analyser or interpreter to model
yet. Its stated base is 2026-10-06, with prepared branch changes
not yet merged at that date. It must be re-read whenever a pull
request touches workflows, CI scripts, session tooling or
secrets, and updated when it no longer describes reality.

### Assets to protect

The main branch (specification, implementation, proofs,
workflows and agent rules) and its traceability; tags and
releases and the link between a tag and its commit, and their
immutability; the specification PDF, its checksum and its
attestation; archival records, whose publication cannot be
withdrawn by the user once published; the published
specification site; secrets and ephemeral tokens; action
caches, including compiled library artefacts and typesetting
caches; the proof axiom audit, meaning no axiom outside the
allowed list; accounts on the hosting, archival and identifier
platforms; and agent sessions themselves, including their
identifiers and their write access to the repository.

### Actors

An anonymous or external contributor who can open issues and
pull requests and have code executed in unprivileged CI; the
sole human maintainer, who alone administers, merges, tags and
publishes; agents working under the maintainer's identity, which
makes prompt injection a vector for an attacker; compromised
upstream components (actions, the Lean toolchain installer,
libraries, the library cache, package indexes and typesetting
tools); a credential thief; and the hosting, archival and
signing platforms themselves, treated as honest trust roots and
outside the model.

### Trust boundaries, in brief

A pull request, from a fork or a branch, reaches the main
branch through a ruleset requiring a pull request and a green
CI aggregate, with **zero required approvals**; the CI oracle
is the workflow from the pull request itself. Unprivileged jobs
and privileged jobs in the same run are separated, with
privileged jobs doing no checkout or build. Caches are scoped
by reference, so a pull request does not write into the main
branch's cache, although a tag run used to read main-branch
caches. A workflow triggered by a tag runs the workflow from
the tagged commit, with no rule that the commit be on the main
branch and no check, at the time of the model, that it is.
Secrets are held as repository secrets without a protected
environment in some flows, and agent permissions were, at the
time of the model, not verified.

### Attack paths that matter most

- **Prompt injection through an issue, pull request or file**,
  leading an agent to modify workflows or agent configuration
  and then merge. This is rated medium likelihood, critical
  impact, and is the path that most directly exploits agents
  working under the maintainer's identity.
- **A fork pull request that empties the controls** — the
  impact-analysis script or the workflows — and still obtains a
  green CI aggregate, relying on human merge as the only
  remaining barrier, with no traced review.
- **Compromised upstream code** executed by a toolchain-bump
  job, reading a token, then a merged pull request, then a tag,
  then an attested PDF and an archival record.
- **A tag pushed onto a commit outside the main branch**,
  whose release workflow then runs from that commit.
- **Session theft or phishing** leading to administration,
  ruleset deactivation, secret reading or publication.
- **A substituted library cache** leading to a false import
  declaration without kernel re-verification; a kernel checker
  is listed as future work, not as a present control.

## Supply-chain controls observed, and their limits

Observed controls include: most actions pinned by commit
hash; workflows not persisting credentials by default;
dependency updates with an anti-compromise delay; Python CI
installs with pinned hashes; REUSE licence checks in CI;
secret scanning; workflow linting, whose blocking threshold was
**not yet decided** at the time of the campaign; operating-system
vulnerability scanning of the Lean manifest; a software bill of
materials; and a manifest check tying each package to its
upstream repository, structure and pinned revision.

Limits stated in the source, which this page does not soften:
the toolchain installer is unauthenticated; the typesetting
bundle is unpinned; compiled library artefacts from the cache
are not re-verified; no second human reviewer exists; and a
single maintainer is the bus factor for merge, tagging and
publication. A control that is prepared but not merged, and a
setting that requires a human action, are not counted as
present.

## Open-source security programme: dated snapshot, no level claimed

The conformance campaign is recorded in dated snapshots from
2026-10-10 and 2026-10-11. The latest dated operational snapshot
in the source is the post-merge state of a security pull
request observed on 2026-10-11, with CI green on its second
attempt and a badge-platform drift job skipped. That snapshot
does **not** describe later main-branch heads, and no
conformance level, recorded badge-platform answer or human
review is claimed in this page.

Open gates at the time of the source include the security,
release and badge-platform gates tracked in the roadmap, and
the maintainer-only steps in the human-actions checklist:
hosting, account, archival and badge-platform settings, and
publication decisions. The former checklists and the initial
remediation plan are historical traces, not current status
sources.

## Secrets and governance

Secrets named in the source, as names only and never as values,
include the archival token and the toolchain-bump token, plus
ephemeral hosting tokens and identity tokens. Rules stated in
the source include: secrets are not to be read by unprivileged
jobs, archival publication requires a protected environment
and a human gate, and a token used by a job that executes
upstream code must never be on the same machine as that code.

Governance, as recorded: a single human maintainer decides,
merges, tags and publishes; there is no second reviewer; agent
sessions draft, propose and check, but do not constitute an
independent review; and the repository has no code-owners file.
Continuity therefore depends on one person, and that risk is
stated here rather than mitigated by this page.

## Maintainer decisions still open, by theme

The source file of maintainer decisions is grouped here by
theme, not by its internal labels, and this page does not
decide any of them. The themes are:

- **Archival record origin:** establish the origin of the
  archival identifier before any CI publication uses it, so a
  later release does not create a second, distinct archival
  concept record.
- **Immutable releases and publication procedure:** keep
  releases immutable and adopt the new publication procedure.
- **What agents may do in the repository:** restrict agent
  tooling and, in particular, whether an agent may merge.
- **Publication metadata claims:** do not claim in publication
  metadata that something is verified against the reference
  implementation unless that claim is actually supported.
- **Branch protection:** require strict status checks on the
  main-branch ruleset.
- **Reproducibility ambition:** decide how far reproducibility
  is claimed, distinguishing a reproducible build from a
  reproducible specification rendering and from bit-for-bit
  replay.
- **Workflow scanner threshold:** decide whether workflow
  linting blocks, or remains a trial.
- **Governance and reporting:** governance model, language of
  reports, developer sign-off, and the conduct-reporting
  channel.
- **Release notes:** notes for the first specification alpha
  release and the specification changelog.
- **Status job writing to the repository:** the CI status job
  added to the main branch after the security audit, which
  writes into the repository and can open pull requests.

*Provenance (secondary): these themes correspond to the eleven
maintainer decisions in the source file, listed there under
short internal labels. This page uses the themes as titles and
does not promote those labels to headings.*

## Tooling evaluation: no tool adopted, no coverage claimed

Prospective tools evaluated in the source, with a dated
maturity review and observed results, include vulnerability
scanning for Lean dependencies with a separate bill of
materials, Lean fuzzing and static analysis, workflow linting,
and branch governance. The source declares **no tool adopted**
and claims **no coverage** from this evaluation. A bounded
demonstrator converting the Lean manifest to a standard
bill-of-materials format is documented, but a demonstrator is
not a deployed control.

The Lean security toolchain programme in the source is a
target architecture in phases — a format-independent data
model, adapters, and a standard-format strategy — not a
present toolchain.

## Dated snapshots, in order

| Date and base | What was observed |
| --- | --- |
| 2026-10-05/06, base `b5f6146` (head of `origin/main`) | Wave-1 audits: Scorecard, CII best practices, GitHub governance, supply chain, security assurance, quality and reproducibility. Scorecard aggregate **6.0 / 10** (run 37385570410, Scorecard v5.5.0); the nine file-based controls were reproduced exactly by a locally compiled Scorecard v5.5.0 on a clean export of `b5f6146`. |
| 2026-10-06 | Scorecard aggregate **6.1** at `da1abb1` (run 37524313277), the only control change being Pinned-Dependencies 9 → 10, as the local measurement had predicted. |
| 2026-10-10, PR #129 merged 17:09:57 UTC | Wave-2 automated base integrated; head observed `86959948`. CI run 38094667153 succeeded on its second attempt after a TLS error on `Install elan` in attempt 1; Scorecard run 38094666898 succeeded. A workflow success is not a score and not a conformance level. |
| 2026-10-11 | Post-merge technical state audited; the badge-platform drift job was skipped in the snapshot, and no conformance level, recorded badge-platform answer or human review is claimed. |
| 2026-10-16 / 2026-10-17 | Tooling maturity review and observed results (see below). |

## Scorecard per control, at the audit base

Observed and attainable scores at `b5f6146` (wave-1 Scorecard
audit, 2026-10-06). "Attainable" is the audit's own estimate,
not a promise, and several attainable scores depend on human
settings or on time, not on code alone.

| Control | Observed | Attainable |
| --- | --- | --- |
| Binary-Artifacts | 10 | 10 |
| Branch-Protection | 3 | 4 |
| CI-Tests | 10 | 10 |
| CII-Best-Practices | 2 | 5 |
| Code-Review | 0 | 0 |
| Contributors | 6 | not steerable |
| Dangerous-Workflow | 10 | 10 |
| Dependency-Update-Tool | 10 | 10 |
| Fuzzing | 0 | 0 (not applicable) |
| License | 9 | 9 |
| Maintained | 0 | 10 (by time) |
| Packaging | −1 (excluded) | −1 (not applicable) |
| Pinned-Dependencies | 9 | 10 |
| SAST | 0 | 10 (only if decided; see below) |
| Security-Policy | 4 | 10 |
| Signed-Releases | −1 (excluded) | 8 |
| Token-Permissions | 10 | 10 |
| Vulnerabilities | 10 | 10 (blind to Lake) |

Two readings that must not be mistaken for defects: the
Security-Policy score of 4 is a naming artefact, not a
missing policy — Scorecard matches files by basename without
case and stops at the first file read, and the agent-rules
file `.claude/rules/security.md` screens `SECURITY.md`;
renaming that rules file is a score decision, not a security
gain, and is left to the maintainer (decision D4 below).
The SAST score stays low by construction: no tool covers
Lean, and CodeQL was deliberately not added to chase the
score (see tooling below).

## Conformance levels: what is attainable, what is not

From the CII best-practices audit (project 15239,
2026-10-06):

- **Passing is attainable**, subject to human actions: no
  MUST criterion is structurally out of reach, but the
  remaining criteria require the human steps listed below
  before any level can be displayed.
- **Silver is not attainable as it stands**; it is
  attainable in the medium term except for `bus_factor`
  (a SHOULD criterion, justifiable for a single maintainer
  rather than satisfiable by headcount).
- **Gold is structurally out of reach for a single-person
  project** and must not be claimed or chased.

## Assurance case: claims supported, claims not yet true

From the assurance-case register (base 2026-10-06, status
addendum 2026-10-10; agent-produced, not validated by the
owner). The register answers the CII `assurance_case`
criterion without satisfying it: an honest assurance case
today is mostly a list of what is not yet demonstrated.

Supported, as observed (VERIFIED, with the limits stated in
the source): CI actions pinned by SHA, each SHA the target
of its announced upstream tag (18 third-party actions;
this does not cover what actions download at run time);
no risky workflow trigger (`pull_request_target`,
`workflow_run`, `issue_comment`); `main` protected by
ruleset 24138119 (no deletion or rewrite, pull request
and `CI OK` required, no bypass actor read — this does
not stop a write-capable identity); Lake dependencies
pinned by commit (14 packages, 14 forty-hex revisions;
offline check in CI, network check prepared only);
private vulnerability reporting enabled; release
`spec-v0.0.0-alpha.1` immutable (for that release, 0
assets); every Lean module in `src/` and `tests/` reached
from a `lakefile.lean` root; file-based Scorecard scores
reproducible (see above).

Not yet true, as recorded (PARTIAL, HUMAN ACTION REQUIRED,
or deliberately NOT CLAIMED): a published artefact
provenancing to this repository and build chain (manual
release rehearsal creates no draft, asset or attestation);
publication secrets inaccessible to a pull request (no
protecting environment in force; the `environment:` keys
are added, the protection setting is human); a release
tag that cannot be placed off `main` or moved before
publication (no tag rules; the `check` job does not resist
a tag-pushing actor); "every warning fails the build"
(true for libraries, false for `lean_exe mainTest` and
`lean_exe spec`); "the specification is verified by Lean
4 against its reference implementation" (no reference
implementation exists — maintainer decision D5); independent
code review (none: one human, zero required approvals);
PDF reproducibility (TeX bundle unpinned, no compared
double build; only HTML/TeX generation observed identical
on two clean builds of one machine); SLSA (no level
claimed, no provenance published); SBOM (the SPDX 2.3
prototype exists but its output was not validated by an
independent parser nor integrated into a release); SAST
(no tool covers Lean; Scorecard SARIF is not a SAST);
fuzzing (no input surface identified); language security
properties such as non-interference (specification
statements, neither implemented nor proved).

## Human actions: what only the maintainer can close

The human-actions checklist records the wave-2 automated
base as integrated (PR #129, 2026-10-10) and leaves the
following to the maintainer; they are the same eleven
decisions as the maintainer-decisions themes above, with
two checklist points added here:

- **D8, workflow linting:** decide separately, after
  examining the Code Scanning findings, whether zizmor
  becomes blocking. Do not make it blocking only to raise
  a score.
- **D4, policy filename:** keep the measurement-artefact
  explanation unless an explicit renaming decision is
  made. A change made only for the score must not be
  presented as a security gain.
- **Interactive navigation recipe:** the checklist's
  section 6 (manual recipe for the published site, with a
  results sheet to fill) is not a security action; it is
  already carried by the roadmap section "Validate the
  navigation prototype with users" and is not duplicated
  here.

## Tooling: conclusions, not adoptions

From the prospective tooling evaluation, with a maturity
review on 2026-10-16 and observed results on 2026-10-17.
**No tool is adopted and no coverage is claimed.**

- **Lake dependency scanning:** OSV-Scanner first, with a
  separate bill of materials. A scan becomes blocking only
  after criteria the source states (useful capability for
  K7PL, validated on a branch, measured on representative
  inputs).
- **Lean fuzzing and static analysis:** no adoption.
  `lean-fuzz` is a NO-GO as a dependency while its licence
  is undeclared, its toolchain is v4.29.0 against K7PL's
  v4.34.0, and no qualified K7PL target with oracle and
  replay exists. SAST must distinguish three layers:
  detectable Lean code defects, proof errors and axiom
  uses (already partly covered by existing audits), and
  workflow and dependency defects (CI and supply-chain
  tooling, not a Lean SAST).
- **Workflow SAST:** zizmor, observed (20 findings in the
  auditor persona: 7 self-repository, 5
  anonymous-definition, 4 concurrency-limits, 2
  undocumented-permissions, 1 superfluous-actions, 1
  excessive-permissions), non-blocking pending decision D8.
- **Branch governance and actions:** as recorded in the
  governance audit; no tool adopted for the score.
- **CodeQL:** deliberately not added. It would not cover
  Lean, nor usefully cover ~1,700 lines of Python without
  untrusted input, and zizmor is more targeted for
  workflows.
- **SBOM strategy:** the Lean security toolchain programme
  is a target architecture in phases (format-independent
  data model, adapters, SPDX and CycloneDX strategy),
  not a present toolchain. Syft, Grype and ORT were
  examined outside the SBOM track; no adoption is recorded.

## Wave-2 changes: integrated into the project

The wave-2 change and validation reports are not prose to
preserve; their durable content is code and workflows
already in the repository, and it is traced here as
integrated into the project:

- Supply chain: `release.yaml` (immutable-release
  `check` job, 19 scenarios, and `draft` job, 5 scenarios
  with a fake `gh`), `zenodo.yaml` and
  `sync_zenodo.py`, `bump-lean.yaml` with
  `scripts/ci/check_manifest.py`, `dependabot.yml`,
  `scripts/claude-session-start.sh` (session hook).
- Quality and reproducibility: `verify.yaml` entry
  `use_cache`, impact classifier changes in `ci.yaml`
  and `impact.py`, `scripts/ci/check_lean_modules.py`
  (every Lean file in `src/` and `tests/` reached from a
  lakefile root), axiom-audit completeness in
  `verify.yaml`, `spec-pdf` job, Tectonic and shell
  logic fixes.
- The independent final verification (2026-10-06) gave a
  global verdict of PARTIAL: nothing BLOCKED, no protected
  file touched, all replayed commands passed, no re-read
  claim contradicted by an observed fact — but real blind
  spots in the added controls (exit codes of the three
  scripts untested, `--check-tags` wiring untested, a
  manifest-size test without an oracle), and the
  `release.yaml`, `zenodo.yaml` and `bump-lean.yaml`
  workflows had never run on GitHub, so they stayed
  PREPARED, as the campaign itself said. The wave-2bis
  re-audit corrected the findings it raised; the
  remaining blind spots are the reason this page claims
  no verified end-to-end chain.

## Workstream evidence: what each report is

| Report (all agent-produced, 2026-10-05/06 unless noted) | Base and verdict |
| --- | --- |
| Scorecard audit | `b5f6146`, run 37385570410, aggregate 6.0; 18 controls plus 2 experimental (SBOM, webhooks); per-control table above. |
| CII best-practices audit (project 15239) | Passing attainable subject to human actions; Silver medium-term except `bus_factor`; Gold structurally out of reach. |
| GitHub governance audit | `b5f6146`, ruleset 24138119; "0 reviewer required" analysed as a single-maintainer property, not as a review. |
| Supply-chain audit | 18 action SHA/tag pairs verified; pinning does not cover runtime downloads (elan/toolchain in the PDF job, Scorecard image by tag); release and Zenodo gaps classified critical, important, opportunistic. |
| Security assurance audit | Threat-model draft, workflow and privilege review, claim → argument → evidence table; claims that would be false signals if "fixed" blindly are named. |
| Quality and reproducibility audit | SAST verdict: no Lean tool to add, actionlint clean, zizmor optional, no CodeQL for the score; PDF reproducibility not demonstrated. |
| Supply-chain changes and validation (wave 2) | Code listed above; simulations and mutation tests recorded; what simulations do not demonstrate is stated. |
| Quality changes and validation (wave 2) | Code listed above; unit tests, mutation control, adversarial re-reading recorded; unexecuted parts named. |
| Final independent verification (2026-10-06) | Global verdict PARTIAL (see above); mutation control, protected-file check, documentation ↔ code coherence. |
| Final security assurance audit (2026-10-06) | Minor findings including a workflow-command injection via an unquoted manifest `name` after `::error::` (exit code still 1, no dangerous command reachable); fix recorded as formatting with `!r` or neutralising carriage return, newline and `::`. |
| Wave-2bis independent re-audit (2026-10-06) | Auditor verdict and findings, with the main session's responses; what the auditor tried to break without succeeding, and what it could not verify. |

## What this page does not establish

Nothing in this page establishes that the repository is secure,
that a conformance level has been achieved, that a human
security review has taken place, or that any prepared control
is in force. The threat model is dated and unvalidated, the
workstream reports are agent records, and several controls
depend on human settings that are still open. Until the
maintainer decisions above are made and the controls are
observed in force at a current commit, cite this page for the
dated state and the open decisions — not for a security
guarantee.
