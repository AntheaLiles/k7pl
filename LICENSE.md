<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

Licenses
========

This repository follows the REUSE Specification: every file is given a
copyright holder and a license, either by an SPDX header in the file itself or
by an annotation in `REUSE.toml` (for files that cannot carry a header, or
whose header is overridden). REUSE also allows adjacent `.license` files; the
repository does not use any. Compliance is checked by `reuse lint`, locally and
in the "REUSE Compliance Check" CI workflow (`.github/workflows/reuse.yaml`).

The full license texts are in `LICENSES/`.

Licenses used
-------------

| SPDX identifier | License                                        | Full text                  |
|-----------------|------------------------------------------------|----------------------------|
| `CECILL-2.1`    | CeCILL Free Software License Agreement v2.1    | `LICENSES/CECILL-2.1.txt`  |
| `CECILL-C`      | CeCILL-C Free Software License Agreement       | `LICENSES/CECILL-C.txt`    |
| `CC-BY-4.0`     | Creative Commons Attribution 4.0 International | `LICENSES/CC-BY-4.0.txt`   |
| `CC0-1.0`       | Creative Commons Zero v1.0 Universal           | `LICENSES/CC0-1.0.txt`     |
| `Apache-2.0`    | Apache License 2.0                             | `LICENSES/Apache-2.0.txt`  |

Policy
------

- **Project software → CeCILL-2.1** (SPDX: `CECILL-2.1`)

  The implementation of the language, its tests, and the tools and scripts that
  constitute software, notably `src/`, `tests/`, `tools/` except explicitly
  generated artifacts, `scripts/` except data explicitly classified otherwise,
  and `lakefile.lean`.

- **Libraries and components written in K7PL → CeCILL-C** (SPDX: `CECILL-C`)

  Components intended to be reused as libraries, notably `lib/`, use the weak
  copyleft of CeCILL-C.

- **Specification, documentation and scientific content → CC-BY-4.0**
  (SPDX: `CC-BY-4.0`)

  The specification `spec/`, its figures, the documentation `docs/`, the
  policies and other intellectual documents of the project may be freely
  reused, subject to the attribution required by CC-BY-4.0.

- **Infrastructure, configuration, metadata and technical artifacts → CC0-1.0**
  (SPDX: `CC0-1.0`)

  This covers notably the `.github/` and `.claude/` infrastructure, the root
  configuration files, the Zenodo/Citation metadata, generated manifests and
  some generated artifacts. The aim is to allow their reuse without imposing
  the software copyleft or an attribution requirement, where the project's
  rights allow it.

This classification follows the **functional nature of the work**, not its file
extension: a script remains software, a document remains documentary content
and a technical configuration remains infrastructure.

The policy above has no category for `Apache-2.0`; the files that use it are
listed in [Apache-2.0 files](#apache-20-files).

### Third-party data and works

A license can only be granted for rights the project actually holds.
Bibliographic data or excerpts from third parties remain subject to the rights
and licenses that apply to their sources; classifying them under CC0 is
therefore conditional on that verification.

### Generated files

A generated file is distinguished from its generator: the generator may be
software under CeCILL-2.1 while the output may be under CC0 when the project
holds the necessary rights and the output contains no protected third-party
work.

The PDF files of `spec/figures/` are currently kept because the PDF build
consumes them (when this map was computed, only `spec/figures/services-lsp.pdf`
was committed). They are derived from the figure sources, and their removal
will be handled separately once PDF generation has been shown to be
reproducible enough.

License map
-----------

This map describes the licenses actually declared, not the policy. It was
computed with `reuse spdx` (reuse 6.2.0) and by reading the SPDX headers, on
the commit that introduced it (based on `main` at `7af5581`). Run `reuse spdx`
to recompute it; where this map and `reuse spdx` disagree, `reuse spdx`
describes the current state. Counts are numbers of files. The former `tooling/`
directory has since been folded into `tools/`: its two rows give the new paths
and the new file names of the B/C/D prototypes, with unchanged counts.

| Path | License | Declared by | Exceptions and notes |
|------|---------|-------------|----------------------|
| `src/` | `CECILL-2.1` (11), `CC0-1.0` (2) | headers | `CC0-1.0`: `src/k/.gitignore`, `src/k/Makefile` |
| `tests/*.lean` | `CECILL-2.1` (6) | headers | none |
| `tests/examples/` | `CECILL-C` (2) | `REUSE.toml` (`tests/examples/**`) | `add.k7`, `select.k7` |
| `tests/python/` | `CECILL-2.1` (8), `CC0-1.0` (7) | headers | `CC0-1.0`: `test_build_figure_provenance.py`, `test_build_semantic_graph.py`, `test_check_navigation_outputs.py`, `test_stage_c_effective_rule_matrix.py`, `test_stage_c_interface_audit.py`, `test_stage_c_substitution_audit.py`, `test_statement_inventory.py` |
| `tools/` | `CECILL-2.1` (22) | headers | `tools/SpecBib.lean`: `CC0-1.0` (generated; header and `REUSE.toml` override); `tools/SpecExt/ProofVisualization.lean`: `Apache-2.0` |
| `scripts/` | `CECILL-2.1` (55) | headers | `Apache-2.0` (2): `scripts/ci/build_proof_visualizations.py`, `scripts/ci/test_build_proof_visualizations.py`. `CC-BY-4.0` (2): `scripts/ci/navigation_graph/README.md`, `scripts/ci/navigation_graph/navigation_explanations.py`. `CC0-1.0` (19): `scripts/ci/build_figure_provenance.py`, `scripts/ci/build_semantic_graph.py`, `scripts/ci/build_tikz_figures.sh`, `scripts/ci/check_navigation_outputs.py`, `scripts/ci/check_tikz_figures.py`, `scripts/ci/enrich_figure_svg_metadata.py`, `scripts/ci/test_enrich_figure_svg_metadata.py`, `scripts/ci/patch_klean_prelude.py`, `scripts/ci/test_patch_klean_prelude.py`, the five Python files of `scripts/ci/navigation_graph/` other than `navigation_explanations.py`, `scripts/controles/statement_inventory.py`, `scripts/requirements-ci.txt`, `scripts/requirements-spdx-validator.txt` (headers), and `scripts/ci/badge_criteria_registry.json`, `scripts/controles/donnees/sondes.json` (`REUSE.toml`) |
| `lakefile.lean` | `CECILL-2.1` | header | none |
| `proofs/` | `CC0-1.0` (10), `CC-BY-4.0` (1) | headers | `README.md`: `CC-BY-4.0`; the Lean files `K7PL.lean` and `K7PL/*.lean` (5) are `CC0-1.0`, like the Lake files and `Makefile` |
| `tools/paperproof-export/` | mixed (4) | headers and `REUSE.toml` | `lakefile.lean`: `CECILL-2.1`; `lake-manifest.json`, `lean-toolchain`: `CC0-1.0` (`REUSE.toml`); `README.md`: `CC-BY-4.0` |
| `tools/prototypes-bcd/` | `CC-BY-4.0` (4) | headers | `AnnexB.lean`, `AnnexC.lean`, `AnnexD.lean`, `README.md` |
| `lib/` | `CECILL-C` (1) | header and `REUSE.toml` (`lib/**`) | `lib/README.md`: `CC-BY-4.0` (header and `REUSE.toml` override) |
| `spec/` (except `spec/formal-chain/`) | `CC-BY-4.0` (94) | headers; `REUSE.toml` for `spec/figures/**` | none |
| `spec/formal-chain/` | `CC0-1.0` (5), `CECILL-2.1` (3), `CC-BY-4.0` (1) | headers | `CECILL-2.1`: `BlueprintK7PL.lean`, `BlueprintK7PL/Blueprint.lean`, `BlueprintK7PLMain.lean`; `CC-BY-4.0`: `BlueprintK7PL/Chapters/Semantics.lean`; `CC0-1.0`: `.gitignore`, `Makefile`, `lake-manifest.json`, `lakefile.lean`, `lean-toolchain` |
| `docs/` | `CC-BY-4.0` (248) | `REUSE.toml` (`docs/**`) and headers | `docs/archives/outillage-org/**`: `CECILL-2.1` (30, `REUSE.toml`); `docs/bibliography/references.json`: `CC0-1.0` (`REUSE.toml` override) |
| `.github/` | `CC0-1.0` (21) | headers; `REUSE.toml` for four JSON files | none |
| `.claude/` | `CC0-1.0` (28), `CECILL-2.1` (10) | headers; `REUSE.toml` for `settings.json` | `CECILL-2.1`: ten of the fourteen files of `.claude/agents/` (`cii-specialist.md`, `consistency-auditor.md`, `formal-reviewer.md`, `github-governance-specialist.md`, `lean-implementer.md`, `quality-reproducibility-specialist.md`, `scorecard-specialist.md`, `security-assurance-specialist.md`, `supply-chain-release-specialist.md`, `verification-specialist.md`) |
| Root documentation | `CC-BY-4.0` | headers | `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CHANGELOG.md`, `DEI.md`, `CODE_OF_CONDUCT.md` (copyright: Contributor Covenant contributors), `CODE_OF_CONDUCT/` (5) |
| Root configuration and metadata | `CC0-1.0` | `REUSE.toml` override | `.gitignore`, `.gitattributes`, `.editorconfig`, `.commitlintrc.yaml`, `.gitleaks.toml`, `.howfairis.yml`, `pytest.ini`, `CITATION.cff`, `lean-toolchain`, `lake-manifest.json`, `zenodo.json`, `zenodo.files.json`; `Makefile` and `CHECKPOINT.md` are `CC0-1.0` through their own headers |
| `LICENSE.md`, `REUSE.toml`, `LICENSES/` | own headers (`CC-BY-4.0`, `CC0-1.0`); license texts | — | not scanned by `reuse`, which ignores these files |

`reuse spdx` also reports `CC-BY-4.0` for `scripts/org2verso/convert.py` and
`tests/python/conftest.py`, and for `.claude/skills/writing-rules.md`, and
`CECILL-2.1` for `spec/Spec/CodeArtifacts.lean`, because these files contain an
SPDX header template or example as text. Their own headers are `CECILL-2.1`,
`CECILL-2.1`, `CC0-1.0` and `CC-BY-4.0`; the counts above use the own header.

### Apache-2.0 files

Three files carry an `Apache-2.0` SPDX header. The license text
`LICENSES/Apache-2.0.txt` was added by commit `2480b08` (2026-10-13).

| File | `Apache-2.0` header since |
|------|---------------------------|
| `tools/SpecExt/ProofVisualization.lean` | its creation, commit `97cf161` |
| `scripts/ci/build_proof_visualizations.py` | commit `bd541ed` (created under `CECILL-2.1` in `8e94a2f`) |
| `scripts/ci/test_build_proof_visualizations.py` | commit `9b87ae3` (created under `CECILL-2.1` in `8e94a2f`) |

These files are `Apache-2.0` per their SPDX headers. No rationale for this
choice is recorded in the repository: the commit messages above have no body,
and `docs/tracking/PROOF-VISUALIZATION-COVERAGE.md` records the state (adapter
and extension under Apache-2.0) without a reason.

### Observed heterogeneity

The following facts are recorded without any decision.

- Code files: of the 137 tracked `.lean`, `.py` and `.sh` files outside
  `spec/` and `docs/`, the SPDX headers declare `CECILL-2.1` for 102,
  `CC0-1.0` for 28, `CC-BY-4.0` for 4 and `Apache-2.0` for 3. By directory:
  `src/` 11 `CECILL-2.1`; `tests/` 14 `CECILL-2.1` and 7 `CC0-1.0`; `tools/`
  22 `CECILL-2.1`, 1 `CC0-1.0` and 1 `Apache-2.0`; `scripts/` 53
  `CECILL-2.1`, 15 `CC0-1.0`, 2 `Apache-2.0` and 1 `CC-BY-4.0`; `tooling/` (now
  `tools/paperproof-export/` and `tools/prototypes-bcd/`) 1 `CECILL-2.1` and 3 `CC-BY-4.0`; `proofs/` 5 `CC0-1.0`; `lakefile.lean`
  `CECILL-2.1`.
- The policy above and `.claude/skills/writing-rules.md` (at `7af5581`)
  give `CECILL-2.1` for project software: the table of section 4 of
  `writing-rules.md` assigns `CECILL-2.1` to `.lean` files in `src/`,
  `tests/`, `tools/` and the root, and its section 1 assigns `CECILL-2.1` to
  `scripts/`. Its Lean header example in section 4 shows `CC0-1.0`.
- The same tables of `writing-rules.md` also assign `CECILL-2.1` to paths that
  are declared otherwise, for example `.github/workflows/` and `.claude/`
  (mostly `CC0-1.0`), `lean-toolchain`, `lake-manifest.json`, `zenodo.json`
  and `CITATION.cff` (`CC0-1.0`), and `README.md` (`CC-BY-4.0`).
- The policy above places `.claude/` under `CC0-1.0`; ten files of
  `.claude/agents/` carry `CECILL-2.1` headers.
- `tools/SpecBib.lean` is declared `CC0-1.0` (header and `REUSE.toml`
  override), but its generator `scripts/biblio/biblio.py` writes a
  `CECILL-2.1` header; the `REUSE.toml` override keeps the declared license at
  `CC0-1.0` when the file is regenerated.

Links
-----

- Full license texts: `LICENSES/`
- CeCILL license family: <https://cecill.info/>
- Creative Commons BY 4.0: <https://creativecommons.org/licenses/by/4.0/>
- Creative Commons Zero 1.0: <https://creativecommons.org/publicdomain/zero/1.0/>
- Apache License 2.0: <https://www.apache.org/licenses/LICENSE-2.0>
- REUSE Specification: <https://reuse.software/>
