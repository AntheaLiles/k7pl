<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# K7PL CI controller (slice 1)

TypeScript controller for the K7PL CI, running under Deno. Slice 1 delivers
three commands and no workflow integration: the controller is exercised locally
and in shadow mode, and it is wired into `.github/workflows/ci.yaml` only after
owner review (see cutover criteria below).

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

## Cutover criteria for slice 1 (all must hold before any workflow wiring)

1. `deno task test`, `deno task check`, `deno task lint`, and
   `deno task fmt --check` pass in this directory.
2. `validate-registry` passes against the repository tree.
3. Shadow mode agrees with the legacy classifier on the current `main` head and
   on a representative set of historical ranges (documentation-only, spec-only,
   Lean-only, CI-only, unknown path).
4. The owner has reviewed the registry, the evidence schema, and the parity
   tests, and has decided the open decisions listed in the slice-1 report
   (notably the `wiki/research.md` classifier rule and the exact `setup-deno`
   SHA).
5. Only then: a separate change wires shadow mode into `ci.yaml` (as a
   non-gating diagnostic first), and a later change makes the Deno classifier
   authoritative. Neither is part of this slice.
