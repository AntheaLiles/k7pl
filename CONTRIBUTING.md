<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Contributing to k7pl

Thank you for your interest in k7pl. This document describes the workflow of a
contribution; the detailed writing rules (structure, naming, SPDX headers,
Lean and Verso style) are in
[`.claude/skills/writing-rules.md`](.claude/skills/writing-rules.md), which is
the reference for humans and agents alike.

By participating, you accept the [code of conduct](CODE_OF_CONDUCT.md).

## Setting up the environment

```sh
git clone https://github.com/AntheaLiles/k7pl.git && cd k7pl
lake exe cache get   # precompiled Mathlib binaries (elan installs the right Lean version)
lake build && lake test
pip install reuse && reuse lint
```

## Workflow

1. Open an issue for any non-trivial proposal (change to the language,
   new dependency), so that it is discussed before the code is written.
2. Create a short-lived branch from `main` (`feat/lambda`, `fix/parser-precedence`…).
3. Write commits in the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
   format (see [Commit messages](#commit-messages)), with `CHANGELOG.md` up to date. CI checks
   **every commit** of the PR with `.commitlintrc.yaml`. A single rejected commit makes `CI OK`
   fail, and fixing a message that has already been pushed requires rewriting the history of the
   branch: check **before** pushing (see [Checking your commits](#checking-your-commits)).
4. Open a pull request against `main` and fill in the template.
5. The `CI OK` check must pass. It aggregates the impact analysis, the checks targeted at the
   changed files (Lean: compilation, tests, lint, axiom audit; specification: checks, compilation,
   rendering), REUSE, Conventional Commits, actionlint and gitleaks.
6. Every new feature or major change must come with automated tests covering its expected
   behaviour and the plausible regressions. If an automated test is not relevant or not possible,
   explain why in the PR and record the alternative check. Bug fixes must add a regression test
   when a test can reasonably reproduce the defect.
7. Merging follows the GitHub ruleset: a linear history is required, but the repository does not impose a particular method (merge, rebase or squash). The build checks verify the head of the pull
   request, not each commit taken in isolation; `commitlint`, on the other hand, reads all of them.

Never rewrite the history of a shared branch (no force-push to
`main`, nor to someone else's branch).

## Commit messages

Commit messages are written in English and follow
[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):

```
<type>(<scope>): <description>
```

CI checks every commit of a pull request with commitlint (`.github/workflows/commitlint.yaml`).
Its configuration, `.commitlintrc.yaml`, extends `@commitlint/config-conventional` and sets:

- **Types**: the standard types `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`,
  `build`, `ci`, `chore` and `revert`, plus two project types used in the history: `licensing`
  (SPDX headers, REUSE, license texts) and `a11y` (accessibility).
- **Scope**: in lower case (`parser`, `spec`, `ci`…), or in upper case for chapter scopes such
  as `C8`.
- **Header**: at most 100 characters.
- **Body and footer**: line length not limited (Dependabot and release notes produce long
  lines: URLs, tables).
- **Subject case**: not enforced, because Dependabot writes sentence-case subjects ("Bump …").

The other rules of `@commitlint/config-conventional` still apply, in particular: a non-empty
type in lower case, a non-empty subject without a final period, no leading or trailing
whitespace in the header, and a blank line before the body and before the footer (warning only).

commitlint does not check the language: writing commit messages in English is a project rule
(see [Languages](#languages)). The style conventions (imperative mood, lower-case initial,
examples) and breaking changes (`!` after the scope and a `BREAKING CHANGE: …` footer) are
described in the [writing rules](.claude/skills/writing-rules.md), §9.

### Checking your commits

With Node installed (this repository has no `package.json`: the tool is installed in a temporary
directory, next to a copy of the configuration, whose `extends` is resolved from that directory):

```sh
mkdir -p /tmp/commitlint && cp .commitlintrc.yaml /tmp/commitlint/
(cd /tmp/commitlint && npm init -y >/dev/null \
  && npm install --no-audit --no-fund @commitlint/cli@19 @commitlint/config-conventional@19)
/tmp/commitlint/node_modules/.bin/commitlint --cwd . --config /tmp/commitlint/.commitlintrc.yaml --from origin/main
```

If no error message is printed, the range `origin/main..HEAD` complies with what CI checks.

## Review

Today, no review by a second person takes place: k7pl is carried by a single
person, who merges their own pull requests once the `CI OK` check has passed. The ruleset of
`main` requires no approval. The assistant agents (Claude Code) draft, propose and
check changes; they do not constitute an independent review. This observation is an explicit
structural gap, not an implicit approval.

For each PR, the author performs a self-review before merging: fitness for the need and the scope,
analysis of the effects on the semantics and the interfaces, tests added or updated, consistent
documentation and changelog, justified dependencies and licenses, absence of secrets, minimal CI
permissions, valid links and references, result of every required check. For a sensitive change,
the PR must describe the residual risks and the evidence that remains to be verified. This
self-review and CI do not replace an independent examination by another person.

The project does not claim to meet the OpenSSF criterion that requires a review by a person other
than the author. The governance requirements and responsibilities are described in
[`docs/security/GOVERNANCE.md`](docs/security/GOVERNANCE.md); the state of the audit is tracked in
[`docs/security/OPENSSF-AUDIT.md`](docs/security/OPENSSF-AUDIT.md).

## Correcting the specification

The manuscript is written in Verso (`spec/Spec/`, one module per chapter and per level-2
section); the writing rules and the available extensions (`{num}`, `{cite}`, `thm`,
`formula`, `figure`…) are in the [writing rules](.claude/skills/writing-rules.md), §6 and §8.
Before writing, read the [dashboard](docs/tracking/DASHBOARD.md); after a
notable change, update `docs/tracking/fiches-statuts.csv` then run `python3 scripts/suivi.py all`.
A corrected statement changes its seal (`status`, `level` of the `thm` directive); it is not
rewritten as though nothing had changed.

## Languages

- **French**: the specification (`spec/`) only.
- **English**: everything else — source code (identifiers, docstrings, comments), messages
  displayed by the code, workflows and scripts, documentation (README, CONTRIBUTING, writing
  rules, `docs/`), tracking, agent and rule files, issues, pull requests and commit messages.

Strings rendered into the specification (Verso extensions, generated bibliography, navigation
texts) follow the specification and stay in French. File names are in English. Historical and
evidence records (`docs/history/`, `docs/archives/`, `docs/peer-review/`, dated audits) are not
translated: they are kept until their content has been analysed and arbitrated (moved elsewhere,
abandoned, etc.), then deleted progressively.

The CI does not check the language. French text outside `spec/` that predates this rule is
listed, with the detection method used, in the translation backlog
[`docs/tracking/LANGUAGE-MIGRATION.md`](docs/tracking/LANGUAGE-MIGRATION.md).

## Proofs and axioms

- No `sorry` or `admit`: any warning makes compilation fail.
- Only the standard axioms `propext`, `Classical.choice` and `Quot.sound`
  are allowed under `K7pl`; CI checks this with `axiom-audit`. Adding an
  axiom requires a prior discussion in an issue.

## Updating Lean and dependencies

Lean, Mathlib, CSLib and Verso are upgraded together:
`scripts/bump-lean.sh vX.Y.Z`, then `lake build && lake test`. The
`Bump Lean` workflow automatically opens a PR every month when a new common
version exists.

The CI impact job runs `scripts/ci/check_manifest.py` (offline) on every run: the
manifest `lake-manifest.json` must contain only the 14 known packages, each tied to its repository.
A new dependency, including a transitive one, therefore makes CI fail **on purpose** until
a person has reviewed it and added it to `ALLOWED_PACKAGES` in `scripts/ci/check_manifest.py`
(`name: owner/repository`); in that case the `Bump Lean` PR does not succeed on its own.

## Publishing a release

The specification and the implementation have **independent** versions:

| Release        | Tag           | Version declared in             | Changelog            | Effect                              |
|----------------|---------------|---------------------------------|----------------------|-------------------------------------|
| Specification  | `spec-vX.Y.Z` | `CITATION.cff` (`version`)      | `spec/CHANGELOG.md`  | draft release with the PDF, its SHA-256 checksum and its attestation; Zenodo archiving after publication |
| Implementation | `vX.Y.Z`      | `lakefile.lean` (`version`)     | `CHANGELOG.md`       | checks before publication; neither artefact nor Zenodo |

The releases of this repository are designed to be **immutable** (the existing release is; the
repository setting remains to be confirmed, see [`docs/security/ACTIONS-HUMAINES.md`](docs/security/ACTIONS-HUMAINES.md), § 1.6): once
published, an immutable release can no longer receive, replace or lose an asset, and its tag can no longer move. CI therefore prepares everything *before*
publication, and **never publishes**: publication is a human, irreversible act. An error
after publication requires a new version, and the name of a published tag cannot be reused.

> **Status.** This flow is written and checked by static tools and by tests of its scripts, but
> it **has never been run end to end**. Before the first specification release, follow the
> list in [`docs/security/ACTIONS-HUMAINES.md`](docs/security/ACTIONS-HUMAINES.md) (§ 5): protected
> environments, tag rule, decision on the DOI, rehearsal on the Zenodo sandbox.

### Specification (`spec-vX.Y.Z`)

1. In a PR: turn `[Unreleased]` in `spec/CHANGELOG.md` into
   `## [X.Y.Z] - YYYY-MM-DD`, and update `version` and `date-released`
   in `CITATION.cff`.
2. After merging, put the tag on a commit of `main` and push it:
   `git tag spec-vX.Y.Z <commit> && git push origin spec-vX.Y.Z`. Do not create the release by hand.
3. `release.yaml` checks the metadata, that the commit is on `main` and that `CI OK` succeeded on it,
   rebuilds without the Actions cache, then creates a **draft** release containing the PDF
   (`k7pl-spec.pdf`), its checksum (`.sha256`) and the attestation (`.sigstore.json`).
4. Review the draft, replay locally the commands of the "Avant publication" ("before
   publication") section of its notes (`sha256sum -c`, then `gh attestation verify --bundle` with
   `--source-digest` and `--deny-self-hosted-runners`), then **publish** it. GitHub then generates
   the release attestation: `gh release verify` and `gh release verify-asset` only work from that
   point on.
5. Publication triggers `zenodo.yaml`, which checks the published assets before depositing them. It
   refuses to publish as long as the variables `ZENODO_ENV` (exactly `production` or `sandbox`) and
   `ZENODO_CONCEPT_RECID` (the concept identifier, or `NEW` to create one) are not
   set in the `zenodo` environment. After a run with `NEW`, set the variable to
   the identifier shown in the job summary, and **never re-run that run**: with `NEW`, the
   script refuses to run if `GITHUB_RUN_ATTEMPT` is not `1`, and a failure after the
   publication has been sent (exit code 3) writes the DOI and the concept identifier to the job
   summary.
6. Check that the DOI in `CITATION.cff` and in the README is the right one.

Zenodo metadata: `zenodo.json` (shared) and `zenodo.files.json` (per PDF); at run time, the script
adds the tag, the commit, the release URL and the SHA-256 checksum of the PDF. `ZENODO_ENV=sandbox`
publishes to sandbox.zenodo.org with a sandbox token.

A dry run exists: the `Release` workflow, started by hand (`workflow_dispatch`), replays the
checks and the build without writing anything. It is only available once this workflow is on
`main`, and requires a commit already on `main` and a version whose metadata are ready.

### Implementation (`vX.Y.Z`)

1. In a PR: turn `[Unreleased]` in `CHANGELOG.md` into `## [X.Y.Z] - YYYY-MM-DD`
   and update `version` in `lakefile.lean`.
2. After merging, push the tag `vX.Y.Z` on a commit of `main`. `release.yaml` checks and verifies
   the implementation **before** any publication; it produces no artefact (a Lake library
   is consumed as source, through its tag).
3. When that run is green, create the release from the tag (notes taken from `CHANGELOG.md`):
   publishing it makes it immutable.

## Security

Do not report a vulnerability in a public issue: see [SECURITY.md](SECURITY.md).
