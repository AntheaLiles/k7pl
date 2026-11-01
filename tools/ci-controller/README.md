<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# K7PL CI controller

TypeScript tooling for the K7PL CI, running under Deno. The derived Deno
classifier is the blocking decision source for all thirteen validation surfaces;
the Python and legacy Deno classifiers remain non-blocking comparison
references.

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
| TLC profile runner             | `--allow-read --allow-write --allow-run=java,sha256sum`                                                                                |
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

## Registry-derived classification

The blocking impact job reads `.github/ci/components.yaml` through
`src/derived.ts` and `src/derived_event.ts`; the derived classifier decides all
thirteen validation surfaces. Component roots, exclusions and `read_inputs`
define path-to-surface routing. The Markdown `docs_links` rule, light/full path
rules and fail-closed unknown-path rule remain classifier-resident because they
are not component ownership rules.

`classify --derived` prints the registry-derived classification.
`classify --derived-shadow` compares it with the legacy Deno projection per
path; `classify --shadow` compares the legacy Deno and Python implementations.
Both comparisons run in `controller-shadow`, which is explicitly non-blocking.
Neither legacy implementation decides the CI result.

The `tla-models` component owns `models/`. Its finite execution inventory is
`models/TLC-PROFILES.json`; the Deno runner validates exact coverage of every
TLA configuration and model module before invoking TLC. Changes to the runner,
its tests and its Deno task manifest are declared as `read_inputs` of the
component, so the model-check gate also exercises its orchestration code.

The derived classifier is therefore authoritative. Further cleanup of the legacy
Python and Deno projections is a separate migration decision and must preserve
the fail-closed handling of unknown paths.

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

## Remaining legacy retirement work

The derived Deno classifier is already the blocking decision source for all
thirteen surfaces. Python and the older Deno classifier remain in
`controller-shadow` as comparison references; they are not gates and must not be
described as sources of truth. The shell entry point remains for compatibility
and its regression tests.

Before removing any legacy reference, retain per-path parity evidence across
representative historical ranges (documentation-only, specification-only,
Lean-only, CI-only and unknown paths), explain every divergence, and preserve
the fail-closed unknown-path behaviour. Do not silently convert an intended
shadow divergence into an assumption of equivalence.
