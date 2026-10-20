<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL — B/C/D tooling prototypes

This directory keeps the material extracted from the former normative annexes B, C and D
(`AnnexB.lean`: LSP and REPL; `AnnexC.lean`: sushi; `AnnexD.lean`: sugoi).

These documents are tooling prototypes: they are neither the normative specification nor the
future standard library.

The provenance of the files is kept in their content and their headers. This directory is
dedicated to the later development and qualification of these prototypes.

The content is not included in `spec/` and must not be read as a normative extension of the
language.

The files are the roots of the non-default `lean_lib` `K7plPrototypes` (`lakefile.lean`), which
the `spec` job of `.github/workflows/verify.yaml` builds with `lake build K7plPrototypes`.
