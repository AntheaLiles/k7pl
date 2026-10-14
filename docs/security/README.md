<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Security and supply-chain assurance

This directory gathers the OpenSSF audit carried out on the repository and its follow-up work. It covers the **security of the build and
publication chain** (workflows, dependencies, releases, accounts). It says nothing about the scientific correctness of the language, which
belongs to [`../ASSURANCE.md`](../ASSURANCE.md). The current factual state of the repository is produced by CI in [`../STATUS.md`](../STATUS.md).

**Where the current state is kept.** Open security, release and BadgeApp gates are tracked in [`OPENSSF-ROADMAP.md`](OPENSSF-ROADMAP.md); the
maintainer-only steps are in [`ACTIONS-HUMAINES.md`](ACTIONS-HUMAINES.md). The latest dated operational snapshot in this directory is the
post-merge state of PR #129 observed on 2026-10-11 (`main` head `86959948`, CI run `38094667153` green on its second attempt, BadgeApp drift
job `skipped`), recorded in section 18 of [`IMPLEMENTATION-STATUS.md`](IMPLEMENTATION-STATUS.md); it does not describe later `main` heads. The
2026-10-10 archives remain historical. No OpenSSF level, recorded BadgeApp answer or human review is claimed.

**Document version:** 1.0.0  
**Last updated:** 2026-10-14  
**Audience:** the maintainer, reviewers, agents.

## Commit identifiers cited

The branch of this campaign was **squashed into a single commit** (maintainer's decision, so that `commitlint` passes on the PR), then merged
into `main` **by rebase**: the three commits of the PR became `b94a4e3`, `ab070c6` and `da1abb1`. Any commit identifier cited in this
directory that is not in the history of `main` (for example `3fd82f1`, `ce606a9`, `25eb642`, `5e4edcf`, `c9372cb`, `b8ee3b6`, `cb3c7e5`,
`a9b20ab`) refers to the branch history **before** the squash or before the rebase: it is no longer reachable. CI run numbers remain valid;
`b5f6146` and `4a8c34f` are commits of `main`.

## Nature of the documents

These documents are **dated records** of a campaign conducted by agents; they are **not validated by the maintainer** and do not become
normative through their level of detail. They describe the state of the repository at the date and commit they state. Later changes (for
example the `status` job added to `ci.yaml` on `main` after the audit) appear in them only where explicitly mentioned. The Markdown documents
listed below are still written in French.

| Document | Role |
|---|---|
| [`OPENSSF-AUDIT.md`](OPENSSF-AUDIT.md) | consolidated gap matrix of the six audits |
| [`BADGE-AUTOMATION.md`](BADGE-AUTOMATION.md) | verified BadgeApp state, analysis of the proposals and cautious synchronisation rule |
| [`BADGE-CONFORMANCE-MATRIX.md`](BADGE-CONFORMANCE-MATRIX.md) | criterion-by-criterion conformance matrix and dated evidential states |
| [`scripts/ci/check_badge_proposals.py`](../../scripts/ci/check_badge_proposals.py) | local consistency check, proposal-URL generation and read-only detection of upstream drift |
| [`OPENSSF-ROADMAP.md`](OPENSSF-ROADMAP.md) | active register of gaps and actions still open |
| [`IMPLEMENTATION-STATUS.md`](IMPLEMENTATION-STATUS.md) | what was done, what was not, and the validation actually run |
| [`DECISIONS-REQUISES.md`](DECISIONS-REQUISES.md) | decisions that belong to the maintainer (D1 to D11) |
| [`ACTIONS-HUMAINES.md`](ACTIONS-HUMAINES.md) | GitHub, account, Zenodo and BadgeApp settings; section 6 of the register separately gathers the human acceptance checklist for interactive navigation |
| [`THREAT-MODEL.md`](THREAT-MODEL.md) | assets, actors, attack paths, workflow privileges |
| [`ASSURANCE-CASE.md`](ASSURANCE-CASE.md) | security claims that are supported, and those that are not (yet) true |
| [`GOVERNANCE.md`](GOVERNANCE.md) | decision model, actual roles and continuity limits |
| [`SECRETS-POLICY.md`](SECRETS-POLICY.md) | secret-handling rules and administrative checks still required |
| [`TOOLING-EVALUATION.md`](TOOLING-EVALUATION.md) | prospective evaluation of security tools (OSV-Scanner for Lake dependencies with a separate SBOM, Lean fuzzing and SAST, zizmor for workflows, branch governance); adopts no tool and claims no coverage |
| [`LEAN-SECURITY-TOOLCHAIN.md`](LEAN-SECURITY-TOOLCHAIN.md) | target architecture and phases of a Lean 4 security-tooling programme (format-independent data model, adapters, SPDX/CycloneDX strategy); the bounded Lake→SPDX 2.3 demonstrator is documented in [`../research/LEAN-COMPLIANCE-ASSURANCE.md`](../research/LEAN-COMPLIANCE-ASSURANCE.md) |
| [`workstreams/`](workstreams/) | raw agent reports: audits, changes, validations, final audits |

## Status vocabulary

For security: `VERIFIED`, `PARTIAL`, `PREPARED`, `HUMAN ACTION REQUIRED`, `BLOCKED`, `FUTURE` (see `.claude/rules/security.md`).
The vocabulary of [`../METHOD.md`](../METHOD.md) (`ESTABLISHED`, `UNDER REVIEW`, …) applies to scientific claims: the two are not mixed.

## Historical records

The former checklists and the initial remediation plan are kept under [docs/history/](../history/) as dated traces; they are no longer active registers. The workstream reports remain historical supporting evidence, not task lists to work through.
