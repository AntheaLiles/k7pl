<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# K7PL CI controller

TypeScript tooling for the K7PL CI, running under Deno. The controller is
integrated in selected CI checks while the broader migration remains staged.

## Current workflow integration

- The blocking `impact` job in `.github/workflows/ci.yaml` runs the controller's
  check, lint, format and test tasks. It uses the Deno manifest validator for
  the offline Lake-manifest check.
- The blocking implementation job in `.github/workflows/verify.yaml` uses
  `src/lean_modules.ts` for Lean-module reachability.
- The `controller-shadow` job pins the hosted OS to `ubuntu-22.04`, installs
  Deno 2.9.8 through the shared composite action, and compares Deno's impact
  classifier with the Python reference. The official Deno container image was
  evaluated but not used as a GitHub Actions job container: it does not include
  Node.js, which JavaScript-based actions such as checkout require. The
  comparison remains report-only and is not a CI gate.
- Python and shell implementations remain in the repository while this migration
  is validated. Do not remove a legacy implementation until its Deno replacement
  has passed the relevant tests and a full green CI cycle.

## Runtime

- Deno **2.9.8** (exact version installed for slice 1 development via the
  official installer; in CI it must be installed with `denoland/setup-deno`
  pinned by full SHA and this exact version — the SHA is resolved at
  implementation time and is not written here from memory).
- Zero runtime dependencies: Deno standard facilities only. `deno.lock` is
  committed; with no remote dependencies it records only the lockfile version.
- Every source file carries an SPDX CECILL-2.1 header. `deno.json` and
  `deno.lock` cannot carry a header (JSON); they are covered by the REUSE.toml
  annotations added with this slice.

## Commands

Run from the repository root. The `--allow-*` flags below are the minimum for
each command; do not run the controller with `-A`.

| Command                        | Minimum Deno permissions                                                                                                               |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| `classify` (paths / base-head) | `--allow-run=git --allow-read --allow-env --allow-write` (write is only used when `GITHUB_OUTPUT` is set, to append the surface lines) |
| `classify --shadow`            | As above, plus `--allow-run=python3` (legacy classifier) and `--allow-write` for its temporary `GITHUB_OUTPUT` file                    |
| `validate-registry`            | `--allow-read`                                                                                                                         |
| `validate-evidence`            | `--allow-read`                                                                                                                         |
| `deno test` (this directory)   | `--allow-read --allow-run --allow-env --allow-write` (tests create temporary git repositories and temporary output files)              |

Examples:

```sh
deno run --allow-read --allow-run --allow-env --allow-write src/main.ts classify --base <base> --head <head>
deno run --allow-read --allow-run --allow-env --allow-write src/main.ts classify --paths src/Foo.lean docs/a.md
deno run --allow-read --allow-run --allow-env --allow-write src/main.ts classify --base <base> --head <head> --shadow
deno run --allow-read src/main.ts validate-registry
deno run --allow-read src/main.ts validate-evidence --evidence evidence.json
deno task test
```

`classify` mirrors `scripts/ci/impact.py` exactly: same rule tables, same rule
order, same surface outputs (`full`, `docs_links`, `spec_check`, `spec_build`,
`lean_build`, `python_tests`, `tracking_views`, `unclassified`), and the same
fail-closed rule (an unknown path forces full validation). It writes the
surfaces to `GITHUB_OUTPUT` when that variable is set, in the same key order as
the Python classifier.

D2 slice 1 (descriptive only): `.github/ci/components.yaml` now also declares,
per component, `impact_surfaces` and, where applicable, `read_inputs` (the
former "read by another surface" rules). `validate-registry` checks them (known
surface vocabulary, non-empty, no duplicates, read inputs existing on disk). The
classifier does **not** read them yet: it still uses its own tables, and the new
surface names (`axiom_audit`, `k_compile`, `k_examples`, `klean_export`,
`tla_model_check`) are derivation targets, not outputs. Deriving the classifier
from the registry is the next D2 slice, in shadow first, with a parity test —
and with the deduplication refactor for `axiom_audit`, so the same audit is
never run twice under two names.

D2 slice 2 (shadow only): `src/derived.ts` derives surfaces from the registry —
roots (respecting excludes) plus read inputs, with Markdown → `docs_links` and
fail-closed unknown → `full` as the only classifier-resident rules.
`classify --derived` prints a derived classification.
`classify --derived-shadow` compares derived with legacy per path (aggregate
comparison alone would hide divergences that cancel out). It prints reviewed
migration deltas as informational output and exits 1 only for an unlisted path
or a changed delta. The allowlist in `src/derived.ts` matches both the path
family and the complete set of legacy-surface differences; its cases are
asserted in `tests/derived_test.ts`.

Reviewed cases include the D2 target mappings (proofs/ → `axiom_audit`, TLA
models → `tla_model_check`, `src/k/` → K surfaces without Lean over-triggering),
the PR #311 move of K source files to `lexicon/`, K example inputs under `lib/`,
and the rename/move of the Python specification tooling. The existing
`wiki/references.json` delta is also retained: the wiki root adds `docs_links`
beside the declared specification read input. Unreviewed differences remain
visible and fail the shadow step. A read input may restrict its surfaces (`src/`
triggers `spec_check` only for the specification component); the implementation
component excludes `tests/python/` so Python tests do not over-trigger
`lean_build`. The derived classifier remains authoritative; the legacy
classifier is retained as a diagnostic comparison.

## Shadow mode

`classify --shadow` runs the legacy Python classifier and the Deno classifier on
the same `--base..--head` range, compares every surface and the unknown-path
list, and exits non-zero on any divergence. The Python run's `GITHUB_OUTPUT` is
redirected to a temporary file, so shadow mode never clobbers the runner's
output. Shadow mode is diagnostic only in slice 1: it is not referenced by any
workflow and does not gate any aggregator.

## Evidence records

See `evidence.schema.json`. A record is validated by `validate-evidence` against
the schema and against `.github/ci/components.yaml`: unknown stage, unknown
dependency, claim class not allowed for the stage, missing required claim (e.g.
a proof claim for `lean-proof-build`), malformed digest, or any claim on a
failed stage are all rejected. A record is a checkable claim about a stage, not
a proof in itself.

## Remaining classifier cutover criteria

The Deno test, check, lint and format tasks now run in the blocking `impact`
job. Event routing for the impact classifier is also implemented in
`src/impact_event.ts`; it preserves the existing Python classifier as the source
of truth while replacing the shell wrapper in the workflow. The legacy
`scripts/ci/ci_impact.sh` remains for compatibility and its regression tests.
The migration is still staged: the Deno/Python comparison stays report-only
until parity evidence is reviewed.

Before switching the authoritative impact-classifier call away from Python:

1. The blocking Deno quality tasks must pass in a complete CI cycle.
2. `validate-registry` must pass against the repository tree.
3. Shadow mode must agree on the current base/head and representative historical
   ranges (documentation-only, specification-only, Lean-only, CI-only, and
   unknown paths); any divergence must be explained and resolved rather than
   hidden by aggregate surface equality.
4. The registry, evidence schema, and parity results must have been reviewed,
   including the owner decisions recorded in the slice-1 report.
5. Only a separate, explicit cutover change may make the Deno classifier
   authoritative and move the parity job into the blocking gate. Keep the Python
   reference and shell entry points in the repository until that change has
   passed a complete green CI cycle.
