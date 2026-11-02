<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# CI migration checkpoint

## Current branch

- Replacement branch: `ci/slice3-replacement`.
- Replacement PR: #312, targeting `main`; open and not merged.
- Original PR #309 remains open and unmerged. Do not merge either PR until
  the replacement's complete CI is green and the remaining migration criteria
  have been reviewed.
- The replacement starts at `main` commit
  `cdc91d94facb457f077cf0c5da46ec7c700c730f` and has a linear history. The
  intermediate merge commit `da7b8cb5f706c51a2be6bdb8dcaf41e0521d07f1` was
  omitted.

## History repair

- The overlong C0 classifier rule/test commits were consolidated as
  `ci: align derived classifier rules and coverage tests`
  (`501621ddbb6d2652c40adfb87b437ee9ce8a5519`).
- The overlong C1/C5 axiom-audit implementation and adjacent tests were
  consolidated as `ci: deduplicate Deno axiom audit and its tests`
  (`2b8fa7a79b78f3d1b186fa42e6796160dbe76fec`).
- These replace the three Commitlint failures observed on the old head:
  - `57a7350ae5d728b69c7b8911b963cc67a1ceeba1`: 128-character header.
  - `97f383e1163bc5e64eee5a7ec4c1ec40fa0fbebb`: 154-character header.
  - `44e7386c64245d55552f4399226023bdc8efb1fa`: 124-character header.
- The replacement history omits the automatic merge commit. The remaining
  commit headers were checked against the allowed Conventional Commit types
  and the 100-character limit.

## CI fixes based on observed failures

- `tools/ci-controller/tests/impact_event_test.ts`: removed both
  `require-await` lint violations reported at the mock runner and missing-SHA
  test.
- `tools/ci-controller/src/build_proofs.ts`: the parser treated `--build` as
  a value-taking option and consumed the following `--workdir`. It now
  handles `--build` as a boolean flag and leaves subsequent flags available.
- `tools/ci-controller/tests/build_proofs_test.ts`: added a regression test
  that checks independent parsing of `--build`, `--workdir`, and
  `--log-output`.
- `CHECKPOINT.md`: added SPDX metadata after REUSE reported the missing
  copyright and license information.
- Preserved the K Framework image digest, the `unzip` prerequisite before
  Deno setup, and the Dependabot pins from current `main`.
- Deno formatting fixes were applied separately to `CHECKPOINT.md`
  (`d5188d7e0aff7277da932b1ee133896fdc33000b`),
  `impact_event_test.ts` (`2b57bb4a9b30f09dd7957ca711bdd7f3883a0356`),
  and `axiom_audit.ts` (`97d20fc10af5b8c418943c536598599a45f4b6f4`).

## Evidence and validation

- Old CI run `40398238506`, head
  `0f5e80eb8bceca103c250af58666417772a2ef54`: Commitlint failed on the three
  headers above, Deno lint failed on two `require-await` violations, and REUSE
  failed because `CHECKPOINT.md` lacked SPDX metadata.
- Old K semantics run `40398237663`, job `121837151795`: after K
  compilation/examples, the proof build stopped with exit 2 and printed the
  `build_proofs.ts` usage. The CLI parser defect is covered by a regression
  test.
- CI run `40401507647`, head `852e79271b94f5ab9ff17ef33fb64729fe1741bf`,
  passed Commitlint and REUSE but failed `deno fmt --check` on three files.
  Those formatting differences have been addressed in the commits above.
- On head `97d20fc10af5b8c418943c536598599a45f4b6f4`, CI run `40402307947`
  was pending and K semantics run `40402307090` was in progress when last
  checked. Neither is evidence of a green full CI cycle.
- Local Deno test execution is unavailable in this session; the repository
  clone attempt failed with `Could not resolve host: github.com`. No local
  test pass is claimed.

## Latest replacement CI and follow-up fixes

- Replacement CI run `40402576185` (merge ref for head
  `350a4972dcf9da31fac43699caea0c2b4c543f92`) passed Commitlint, REUSE,
  actionlint, zizmor, gitleaks, the Deno type check and lint, and the
  Deno/Python classifier shadow check. The blocking impact job stopped at
  `deno fmt --check` because `tools/ci-controller/README.md` had Markdown
  wrapping differences.
- That README was reformatted to the exact wrapping requested by Deno in commit
  `588635b19968fc3cc2daa4bdc563859f4b30cda4`.
- K semantics run `40402575230` passed the D01 TLC checks and K compilation,
  examples, and Klean export. The proof-build invocation failed because
  `${{ github.workspace }}` expanded to the runner-host path
  `/home/runner/work/k7pl/k7pl/proofs`, which does not exist in the K job
  container; the actual mounted workspace is under `$GITHUB_WORKSPACE` (shown in
  the logs as `/__w/k7pl/k7pl`). The workflow now passes
  `"$GITHUB_WORKSPACE/proofs"` to the Deno builder and lets the Blueprint
  renderer resolve its own repository-relative directory in commit
  `63b65739cdd9d38176c7f8f098a9cfac3d92af5e`.
- Current replacement head at checkpoint update:
  `63b65739cdd9d38176c7f8f098a9cfac3d92af5e`. The new commits have not yet
  produced an observable PR-triggered workflow run in the connector, so neither
  fix is considered CI-validated. Local Deno is unavailable and the clone
  attempt failed due to DNS/network failure; no local test pass is claimed.


- Full CI run `40409404222` on pre-fix head
  `180c589fb7c6b2c8cb0bfffa6ce9098a66a4c5e3` passed the Deno controller check,
  lint, format and test tasks; Commitlint, REUSE, actionlint, zizmor, gitleaks,
  controller-shadow and R9/TLC also passed. `Test the CI scripts` failed because
  `test_impact_coverage.py` required `verify_sbom_audit.sh` in the active
  workflow inventory after `verify.yaml` had moved its orchestration to
  `lake_to_spdx.ts` and `sbom_evidence.ts`.
- Commit `9e28bc9fca913aad671726df2cd53690e6ac70e4` updates the coverage test to
  check that the legacy shell file remains present separately and that both Deno
  replacements are wired into the workflow. This test fix is not yet validated;
  the K proof-build path correction also awaits a completed run.


## Documentation-architecture regression found in CI

- CI run `40409937046` on head
  `f24f1dc18ea175779f5eac26c594ce1dd8d06474` passed the Deno controller and
  impact checks, Commitlint, REUSE, actionlint, zizmor, gitleaks, controller
  shadow, and R9/TLC. `Verification / Contrôles rapides` failed in the
  documentation-architecture guard with obsolete `docs/archives/` and
  `docs/history/` references in active `.claude/` instructions, plus false
  positives from the legacy Python guard and its tests.
- Updated `.claude/CLAUDE.md`, `.claude/rules/documentation.md`,
  `.claude/rules/project.md` and `.claude/skills/writing-rules.md` to remove
  references to deleted documentation locations and the retired Org converter.
- `tools/ci-controller/src/documentation_architecture.ts` now explicitly
  exempts the legacy Python guard and test, matching the Python original's
  self-exclusion behavior. Its test asserts all four guard/reference paths are
  exempt and verifies they cannot create false positives. The active
  `.claude/` directory remains scanned; the guard itself was not disabled.
- Commits implementing these fixes:
  `20cc72642204181fe266f6724688efca796875e2`,
  `a06c96e7fa1a90c5e0d5fcebab2fd0db6b69da4f`,
  `79d340581939a835d6751879b08131f08455acfa`,
  `d6986a5a97904faa96ad7e0155029f65537359d0`,
  `ad57a231279a3ed819d6342961e494b7013ca0c7`,
  `b6c5a82808c3e9adb3acfedebaa55c2068a51e0e`.
- These architecture fixes await CI validation. In the latest run, the K
  proof-build job was still in progress; the correction from the runner-host
  proofs path to `$GITHUB_WORKSPACE/proofs` also needs a completed successful
  K job.


## Follow-up: formatter and SPDX environment permissions

- CI run `40410595135` caught a Deno formatting mismatch in the new
  `documentation_architecture_test.ts` loop. Commit
  `032f9c097e0291157eda2afe72355f502752f902` reformats both loops to Deno's
  canonical layout.
- In the earlier implementation check from CI run `40409937046`, the scoped
  Lake-to-SPDX inventory failed with `lake_manifest_to_spdx.py: Requires env
  access` (Deno's message asks for `--allow-env`). The converter resolves
  relative input paths against the current working directory;
  `.github/workflows/verify.yaml` now grants environment permission to the two
  `lake_to_spdx.ts` invocations. No network or subprocess permission was added
  to this converter.
- The external-link report in run `40409937046` reported connection failures
  for `mirage.io` and its technical-background page. Both URLs respond to
  independent web access; the workflow explicitly keeps this job
  `continue-on-error: true`, so the transient network failures are report-only
  and were not “fixed” by removing or replacing valid research citations.
- Latest observed CI/K runs on head
  `032f9c097e0291157eda2afe72355f502752f902` are CI
  `40411108063` (pending) and K semantics `40411107230` (in progress).
  Neither the formatter correction, the documentation guard correction nor the
  SPDX permission correction is yet considered validated by a completed run.


## Validation results as of 2026-10-27

- CI run `40411492295` completed with the required `CI OK` gate green.
  The quick checks, Deno controller, Python tests, implementation Lean build,
  SPDX audit/evidence, axiom audits, Verso build, PDF verification, OSV scan,
  actionlint, zizmor, gitleaks, REUSE and Commitlint all succeeded.
- K7PL formal semantics run `40411491720` also completed successfully:
  the D01 TLC check and the K semantics compile/examples/export-to-Lean job
  both passed. This validates the proof-builder workspace-path correction.
- The only unsuccessful job was `External links`, explicitly configured as
  report-only with `continue-on-error: true`. Its sole reported error was
  HTTP 429 from `https://www.gnu.org/software/hurd/hurd.html`, after the
  configured 30-second per-host interval and retries. The exact Hurd page is
  confirmed by the official GNU search result; it remains cited in the dossier.
- Added an exact-URL exception in `lychee.toml` (commit
  `2582e30e7477f9dd146eccf1dd641755e0594898`) with an explicit reason and
  re-check date 2027-01-25. No domain-wide exclusion and no global acceptance
  of 429 responses were introduced. Updated the workflow's policy comment in
  commit `78c25436bbe0cb9cc487228e2f9989593a85aa34`.
- The current PR head is `78c25436bbe0cb9cc487228e2f9989593a85aa34`.
  Its workflow runs have not yet appeared in the connector; the exception and
  comment update therefore remain pending CI validation. PR #312 remains open,
  unmerged, and mergeable.


## Follow-up on the final-head external-link report

- CI run `40418281586` completed with `CI OK` successful. The Lean
  implementation/tests/lint and axiom audits, SPDX inventory and artifact,
  Python/CI tests, TikZ verification, Verso specification, PDF, OSV scan,
  actionlint, zizmor, gitleaks, REUSE, Commitlint and TLA+ all passed.
  K7PL semantics run `40418280585` completed successfully: K compilation,
  both example/profile checks, KORE export, Klean compatibility, proof-project
  build, axiom audit and Blueprint rendering passed.
- The only non-green job was the report-only external-link checker. With the
  first exact exception active, its rerun found two HTTP 429 responses for
  `https://www.gnu.org/software/hurd/gnumach-doc/Introduction.html`, cited
  twice in `theoretical-projects/k7os/R8-operating-systems-comparison.md`.
- Commit `1c781352b403000dd018fc2539970c93ec5fc05a` adds an exact URL-only
  exception with a reason and a 2027-01-25 re-check date. It does not accept
  429 responses globally or exclude the GNU domain. Commit
  `703e3afb30a7e05fac07f80cb4ec2aa2c1fe573d` updates the workflow policy
  comment to document both exact URL exceptions and the review date.
- Those final changes require a fresh CI check. The prior complete run verifies
  all blocking checks and the K chain; it does not verify the newly added
  GNU Mach exclusion.

## Next action

Validate the GNU Mach exact-URL exception on the latest PR head. Require the
external-link report to show no errors and preserve the green CI OK and K runs;
keep PR #312 open and unmerged.

Wait for CI and K-semantics runs on the current head, inspect the external-link
job, and verify that the exact URL exception is honoured. Keep PR #312 open
until all blocking checks pass.

Inspect the newest replacement-PR CI and K-semantics runs, fix any new
evidence-backed failures, and require a complete green CI cycle before
considering closure of the original PR or any merge.
