# CI migration checkpoint

## Current scope

Branch: `ci/slice3-branching` (PR #309; do not merge).

## Last completed action

- Updated `scripts/ci/test_code_artifact_contract.py` in commit `194a847418b6fd55a66383a7398c7af884dc3fa8` (`ci: align K semantics contract tests with Deno migration`).
- Reconfigured `.github/workflows/ci.yaml` in commit `c33f2f0cd3a9e60da2f7fa406e5ca7856b471229`: removed the official Deno container from `controller-shadow`, pinned the runner to `ubuntu-22.04`, and installed Deno using the shared action. This avoids running JavaScript-based GitHub Actions inside a minimal container without Node.js.
- Added `tools/ci-controller/src/impact_event.ts` in commit `56dcf1174cd833722eceb389968f7b6765f136b7`, with focused event-routing tests in `tools/ci-controller/tests/impact_event_test.ts` (latest test edit `63c8267931e4074b9075930a9fba23eeacbc2d59`). It ports the `ci_impact.sh` event-routing layer to Deno but deliberately invokes `scripts/ci/impact.py` as the classifier reference until parity cutover criteria pass.
- Changed `.github/workflows/ci.yaml` to use the Deno event adapter in commit `112813f0e6bdb026bbd0ac6cff85b0e89082f3e0`; documented the staged migration in `tools/ci-controller/README.md` (commit `b470265115decd73bee8e43682ca5583dcae372b`).
- Updated `.github/ci/components.yaml` in commit `bef1eaa1192c60e79e303e8f102621dc8f36daf5` and `tools/ci-controller/README.md` in commit `e6ac4c5496b103847970daf987135ea5850fbbe7` to document the runtime decision.
- The test now asserts that the K7OS boundary check is wired to `tools/ci-controller/src/os_boundary_check.ts`, and that formal-chain evidence packaging is wired to `tools/ci-controller/src/package_evidence.ts`.
- Before this update, CI run `40396722636`, job `121831731317`, failed two assertions because those tests still expected the superseded shell wrappers `k7pl_os_boundary_check.sh` and `k7pl_semantics_package_evidence.sh`.
- The K job's earlier `unzip` prerequisite is now explicitly installed before the pinned Deno setup in `.github/workflows/k7pl-semantics.yaml`; this fixed the setup-stage blocker in the observed run, which then advanced to the two stale contract assertions.

## Validation state

- No local checkout or local command execution is available through the current GitHub connector session.
- No workflow run for the latest head has been observed yet; the new TypeScript source/tests and workflow wiring have not been validated by CI.
- Do not remove legacy shell/Python implementations until their Deno replacements pass their focused tests and a complete green CI cycle.
- Keep required checks blocking; no merge, no force-push, no edits to `main`.

## Next actions

1. Confirm the latest commit's CI result and fix any evidence-backed failures.
2. Review the remaining shell/Python entry points against existing Deno ports and tests; migrate in small parity-checked slices.
4. Keep the K Framework image pinned; its workflow installs `unzip` before Deno setup. A derived K image still requires a build/publish flow, immutable digest, and validation before adoption.
5. Keep the classifier shadow check report-only until parity criteria are satisfied; do not switch the Python classifier's gating authority in this tranche.
