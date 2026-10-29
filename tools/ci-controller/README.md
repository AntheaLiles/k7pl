<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# K7PL CI controller

TypeScript tooling for the K7PL CI, running under Deno. The controller decides
what the CI runs (the impact classifier) and carries the Deno ports of former
Python and shell CI steps.

## Current workflow integration

- The blocking `impact` job in `.github/workflows/ci.yaml` runs the controller's
  check, lint, format and test tasks, validates the component registry
  (`validate-registry`), runs the Deno manifest validator for the offline
  Lake-manifest check, and decides the thirteen surfaces with
  `src/derived_event.ts`.
- The impact classifier is derived from `.github/ci/components.yaml`
  (`src/derived.ts`). Since cutover C4 it is the only classifier: the legacy
  Python classifier (`scripts/ci/impact.py`), its shell wrapper
  (`scripts/ci/ci_impact.sh`), its Deno port (`src/classify.ts`) and the
  non-blocking `controller-shadow` job that compared them are removed.
- `scripts/ci/test_impact_coverage.py` checks that every file a check reads
  triggers that check, by asking this classifier (`classify --json`); the jobs
  that run it install Deno.
- The blocking implementation job in `.github/workflows/verify.yaml` uses
  `src/lean_modules.ts` for Lean-module reachability; the other ported steps are
  called from `verify.yaml`, `security.yaml` and `k7pl-semantics.yaml`.

## Runtime

- Deno **2.9.8**, installed in CI by the shared composite action
  `.github/actions/setup-deno`, which pins `denoland/setup-deno` by full SHA and
  this exact version.
- Zero runtime dependencies: Deno standard facilities only. `deno.lock` is
  committed; with no remote dependencies it records only the lockfile version.
- Every source file carries an SPDX CECILL-2.1 header. `deno.json` and
  `deno.lock` cannot carry a header (JSON); they are covered by the REUSE.toml
  annotations.

## Commands

Run from the repository root. The `--allow-*` flags below are the minimum for
each command; do not run the controller with `-A`.

| Command                         | Minimum Deno permissions                                                                                                  |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `classify` (base-head)          | `--allow-read --allow-run=git --allow-env=GITHUB_OUTPUT --allow-write` (write is only used when `GITHUB_OUTPUT` is set)   |
| `classify --paths`              | `--allow-read --allow-env=GITHUB_OUTPUT --allow-write`                                                                    |
| `classify --json`               | `--allow-read`                                                                                                            |
| `src/derived_event.ts` (impact) | `--allow-read --allow-run=git --allow-env=EVENT_NAME,REF,BASE_SHA,HEAD_SHA,GITHUB_OUTPUT --allow-write`                   |
| `validate-registry`             | `--allow-read`                                                                                                            |
| `validate-evidence`             | `--allow-read`                                                                                                            |
| `deno test` (this directory)    | `--allow-read --allow-run --allow-env --allow-write` (tests create temporary git repositories and temporary output files) |

Examples:

```sh
deno run --allow-read --allow-run=git --allow-env=GITHUB_OUTPUT --allow-write src/main.ts classify --base <base> --head <head>
deno run --allow-read --allow-env=GITHUB_OUTPUT --allow-write src/main.ts classify --paths src/Foo.lean docs/a.md
deno run --allow-read src/main.ts classify --json --paths src/Foo.lean docs/a.md
deno run --allow-read src/main.ts validate-registry
deno run --allow-read src/main.ts validate-evidence --evidence evidence.json
deno task test
```

`classify` prints the changed paths, the eight report keys (`full`,
`docs_links`, `spec_check`, `spec_build`, `lean_build`, `python_tests`,
`tracking_views`, `unclassified`) and the derived surfaces, and appends the
thirteen decision lines to `GITHUB_OUTPUT` when that variable is set, exactly as
the impact job does. An unknown path forces full validation (fail-closed). With
`--json`, it prints one classification per path instead, as a JSON object keyed
by path; `--stdin` reads the paths, one per line, from standard input. An option
the command does not know is refused, so a caller still passing a mode removed
at cutover C4 (`--shadow`, `--derived-shadow`, `--derived`) fails.

## The derived classifier

A path triggers the `impact_surfaces` of every component whose roots contain it
(respecting that component's excludes), plus the surfaces of every component
whose `read_inputs` contain it; a read input may restrict its surfaces (`src/`
triggers `spec_check` only for the specification component). Rules that are not
component tables live in `src/derived.ts`: any Markdown file triggers
`docs_links`; the light paths trigger nothing; `scripts/axiom-audit.sh` triggers
`lean_build` and `spec_build`; a non-Markdown file under `wiki/` or
`theoretical-projects/` that no component claims as a TLA model or read input is
unclassified; and any unclassified path forces full validation, which sets every
surface.

The routing is asserted by `tests/derived_test.ts` (registry semantics and the
decided D2 divergences from the former legacy classifier),
`tests/derived_rules_test.ts` (the routing rules formerly stated for the legacy
classifier, restated for this one) and `tests/derived_event_test.ts` (the impact
job's entry point end to end, through real `git diff` runs: renames seen as a
deletion and an addition, a failed diff fatal and writing nothing, a path that
looks like a workflow command never printed as one, unusual names falling back
on full).

## Classifier cutovers

- D2 slices 1 and 2: the registry declares `impact_surfaces` and `read_inputs`,
  and the classifier is derived from it, in shadow.
- C0: the derived classifier reproduces the legacy light paths, the axiom-audit
  exact rule and the fail-closed treatment of non-Markdown documentation files.
- C1, C2: the K and TLA surfaces are declared and orchestrate
  `k7pl-semantics.yaml` and `r9-tlc`.
- C3 (owner-approved 2026-10-25, slice 3): the derived classifier decides all
  thirteen surfaces; the legacy Python classifier runs only in reversed shadow,
  non-blocking.
- C4: after complete green CI cycles on `main` under C3, the legacy classifier,
  its wrapper, its Deno port and the shadow job are removed; their tests are
  restated for the derived classifier, and the coverage guard asks it.

## Evidence records

See `evidence.schema.json`. A record is validated by `validate-evidence` against
the schema and against `.github/ci/components.yaml`: unknown stage, unknown
dependency, claim class not allowed for the stage, missing required claim (e.g.
a proof claim for `lean-proof-build`), malformed digest, or any claim on a
failed stage are all rejected. A record is a checkable claim about a stage, not
a proof in itself.
