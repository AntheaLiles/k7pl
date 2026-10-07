<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Document provenance

This page is the current reader-facing provenance entry point for the K7PL repository.

The migration preserves three distinct things: source provenance, current documentation, and historical evidence. Physical relocation does not by itself change scientific status, and historical records are not rewritten merely to make their language or terminology current.

## Current ownership

The normative specification is maintained under `spec/`. Current project documentation is under `docs/`. Frozen source artefacts are under [`docs/archives/`](archives/). Historical project records are under [`docs/history/`](history/). Active review evidence is under [`docs/peer-review/`](peer-review/), and active research, method, bibliography, migration, security, and tracking material has a dedicated directory.

The selected bibliography is maintained at [`docs/bibliography/references.json`](bibliography/references.json). It is the machine-readable source for the generated `tools/SpecBib.lean` module.

## Provenance policy

A migrated document keeps its original source identity and its migration destination is recorded in the migration registers. A historical source record may retain its original language when translation would obscure provenance. Current reader-facing documentation and generated views use English.

The detailed migration correspondence from the original `K7PL_spec.zip` corpus is preserved in [`history/2026-10-07-provenance-migration.md`](history/2026-10-07-provenance-migration.md). It records source paths, conversions, and retained artefacts without pretending that historical source material was rewritten.

## Bibliography provenance

The original working corpus contained large Zotero exports and PDF indexes that were deliberately not imported. Only the bibliographic metadata required by the specification is retained. The retained `references.json` is now owned by `docs/bibliography/`; no second active bibliography source exists at repository root.

## Migration invariant

A current document must have an identifiable source or generating process, and a historical artefact must remain identifiable as historical evidence. The repository must never infer epistemic status from a directory name alone.
