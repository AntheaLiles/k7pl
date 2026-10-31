<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL - KonSept Programming Language

[![Lean Build](https://github.com/AntheaLiles/k7pl/actions/workflows/ci.yaml/badge.svg?branch=main)](https://github.com/AntheaLiles/k7pl/actions/workflows/ci.yaml)

K7PL is a programming language whose implementation is written in
[Lean 4](https://lean-lang.org/), with [Mathlib](https://github.com/leanprover-community/mathlib4)
and [CSLib](https://github.com/leanprover/cslib). Its specification is written in
[Verso](https://github.com/leanprover/verso).

## Understanding the project

The current documentation path starts with [`wiki/HOME.md`](wiki/HOME.md), then [`wiki/understanding.md`](wiki/understanding.md), [`wiki/layers.md`](wiki/layers.md) and [`wiki/research.md`](wiki/research.md), and the normative specification in [`spec/`](spec/). The factual state is produced by CI in `wiki/STATUS.md`, while [`wiki/assurance.md`](wiki/assurance.md) sets out the scientific assurance case. Historical and tracking material is organised according to the documentation architecture described in [`wiki/HOME.md`](wiki/HOME.md) and [`wiki/understanding.md`](wiki/understanding.md).

## Getting started

The Lean version is pinned in `lean-toolchain`; [elan](https://github.com/leanprover/elan)
installs it automatically.

```sh
lake exe cache get                # downloads the precompiled Mathlib binaries
lake build                        # builds the implementation (src/) and the specification (spec/)
lake test                         # runs the tests (tests/)
lake lint                         # Batteries linter
reuse lint                        # checks REUSE compliance

# Before rendering the specification: Tectonic 0.15.0 and Poppler (pdftocairo) must be installed.
SOURCE_DATE_EPOCH=946684800 bash scripts/ci/build_tikz_figures.sh
cp out/tikz-production/* spec/figures/
lake exe spec --output _out/spec --with-tex
```

All the figures of the specification are written in TikZ (`spec/figures/tikz/`); their PDF/SVG files are generated artefacts ignored by Git; CI produces them and then injects them before rendering. For a local rendering identical to CI, run these steps before `lake exe spec`.

## Specification

The language specification — the manuscript "K7PL : KonSept Programming Language", seven
chapters, the document's references, annex A, a page of extracted tactic traces and a
non-normative page of experimental executable artefacts — is in [`spec/`](spec/), written in
Verso (in French), under the CC-BY-4.0 license. It is published at
<https://anthealiles.github.io/k7pl/> when the CI of `main` rebuilds the specification. The flow
that will attach its PDF to each `spec-vX.Y.Z` release and archive it on Zenodo is described in
[`CONTRIBUTING.md`](CONTRIBUTING.md); it has not yet been run end to end.

The former annexes B, C and D are no longer part of `spec/`: since commit `d84021f`, their
material is kept as tooling prototypes in [`tools/prototypes-bcd/`](tools/prototypes-bcd/),
outside the normative specification. Their future editorial scope is an open decision (`D-7` in
[`wiki/decisions.md`](wiki/decisions.md)).

The manuscript is still being corrected (review campaign PR-02): the entry point is the
[roadmap](wiki/roadmap.md), which states where it stands and what remains to be
done before implementing the language. The original Org-mode manuscript was converted
to Verso in [`spec/`](spec/); its annexes and former tooling were closed
in 2026-10-25, integrated into `spec/`, `scripts/` and `tools/` or
explicitly abandoned, as traced in git history.

## Organisation

| Directory | Contents |
|---|---|
| [`src/`](src/) | Lean implementation; `src/k/` builds the K definitions of `lexicon/` |
| [`lexicon/`](lexicon/) | K definitions, displayed by the `K` blocks of `spec/`: the lemmas (`lexemes/`), the structure rules and syntactic sugar (`syntax/`), the non-normative K7OS model (`models/`) |
| [`proofs/`](proofs/) | maintained Lean proofs, and KLean modules generated at build time |
| [`tests/`](tests/), [`tests/examples/`](tests/examples/) | Lean/Python tests, and K7PL `.k7` programs |
| [`spec/`](spec/) | normative Verso specification, figures, and an experimental exposition under `spec/formal-chain/` |
| [`tools/`](tools/) | specification generator and Verso extensions (`SpecExt/`); bibliography (`SpecBib.lean`, generated from [`wiki/references.json`](wiki/references.json)); Lean compliance and audit models (`Compliance/`); the isolated Paperproof extraction workspace (`paperproof-export/`); the non-normative B/C/D prototypes (`prototypes-bcd/`); the checker of K7PL texts against the grammar of the layers (`layer-check/`) |
| [`lib/`](lib/) | libraries written in K7PL (currently one example file, `lib-example.k7`) |
| [`wiki/`](wiki/) | consolidated project documentation (entry, layers, research; further pages added lot by lot) |
| [`scripts/`](scripts/) | maintenance, Org → Verso conversion, metrics and tracking |

## Experimental K → Lean chain

An experimental slice of K semantics lives in `lexicon/`, one file per lemma, and the `K` blocks of `spec/Spec/CodeArtifacts.lean` display it next to its Verso documentation. The Python block of that page generates the checker of the examples into `src/k/.build/generated/`, a file ignored by Git that must not be modified directly. The test source programs use the `.k7` extension in `tests/examples/`. The maintained Lean proofs are under `proofs/K7PL/`; the KLean modules are generated during the build. The Verso Blueprint exposition stays in `spec/formal-chain/`, separate from the normative specification.

`make k-check` compiles the K definition of `lexicon/`, extracts the Python checker from Verso and runs the examples. `make k-layers-check` checks the listings of the specification and the `.k7` files against the grammar of the layers (`lexicon/syntax/`), and the error codes and messages that K emits against annex A. `make formal-chain` extends this flow with the export of KORE to KLean, the build of the proofs and the rendering of the Verso exposition. This prototype does not formalise the whole of K7PL: the link between the K function `typeOf` and the Lean judgement `HasType` remains to be established.

## Contributing

[![fair-software.eu](https://img.shields.io/badge/fair--software.eu-%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8B-yellow)](https://fair-software.eu)
[![DEI](https://img.shields.io/badge/DEI-DEI.md-6f42c1)](DEI.md)

See [`CONTRIBUTING.md`](CONTRIBUTING.md) (workflow), the
[writing rules](.claude/skills/writing-rules.md) and the
[code of conduct](CODE_OF_CONDUCT.md). Vulnerabilities are reported privately:
see [`SECURITY.md`](SECURITY.md).

## Citing k7pl

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23040451.svg)](https://doi.org/10.5281/zenodo.23040451)
[![SWH origin](https://archive.softwareheritage.org/badge/origin/https://doi.org/10.5281/zenodo.23040451/)](https://archive.softwareheritage.org/browse/origin/?origin_url=https://doi.org/10.5281/zenodo.23040451)

Versions of the specification are meant to be archived on [Zenodo](https://zenodo.org)
with a DOI, their PDF being attached to the corresponding GitHub release. This flow has not yet been
run end to end: the `spec-v0.0.0-alpha.1` release has no PDF attached (see
[`CONTRIBUTING.md`](CONTRIBUTING.md)). See
[`CITATION.cff`](CITATION.cff) (the "Cite this repository" button on GitHub). DOI: [10.5281/zenodo.23040451](https://doi.org/10.5281/zenodo.23040451).

[![SWH directory](https://archive.softwareheritage.org/badge/swh:1:dir:b81695cfdce2e418f8a8431b79e8894ee7310c50/)](https://archive.softwareheritage.org/swh:1:dir:b81695cfdce2e418f8a8431b79e8894ee7310c50;origin=https://doi.org/10.5281/zenodo.23040451;visit=swh:1:snp:e8d0a0046dc9e4509fc52655611c04a49414fa89;anchor=swh:1:rel:6c1db6481a70f65688c0cf1f8eb8cbfcf1e128b9)

## Security

[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/AntheaLiles/k7pl/badge)](https://scorecard.dev/viewer/?uri=github.com/AntheaLiles/k7pl)
[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/15239/badge)](https://www.bestpractices.dev/projects/15239)

Vulnerabilities must not be reported in public issues. Use
[GitHub private reporting](https://github.com/AntheaLiles/k7pl/security/advisories/new) and give
the affected commit, the reproduction steps and the presumed impact. The scope covers in particular
the consistency of the specification and its proofs, the implementation of the language and the build
chain. See [`SECURITY.md`](SECURITY.md) for the full policy, the response times
and the known limits of the build chain.

## Licenses

[![REUSE status](https://api.reuse.software/badge/github.com/AntheaLiles/k7pl)](https://api.reuse.software/info/github.com/AntheaLiles/k7pl)

- Code: [CeCILL 2.1](LICENSES/CECILL-2.1.txt)
- Libraries written in K7PL: [CeCILL-C](LICENSES/CECILL-C.txt)
- Specifications and documentation: [CC-BY-4.0](LICENSES/CC-BY-4.0.txt)
- Infrastructure and configuration: [CC0-1.0](LICENSES/CC0-1.0.txt)
- Three proof-visualization files: [Apache-2.0](LICENSES/Apache-2.0.txt) —
  `tools/SpecExt/ProofVisualization.lean`, `scripts/ci/build_proof_visualizations.py` and
  `scripts/ci/test_build_proof_visualizations.py`

See [`LICENSE.md`](LICENSE.md) for the details and the mapping from paths to licenses.
