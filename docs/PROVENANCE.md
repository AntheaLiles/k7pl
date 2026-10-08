<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Document provenance

**Last updated:** 2026-10-08

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


## Release et archivage Zenodo

Les releases de spécification suivent le tag `spec-vX.Y.Z`. Le workflow
`release.yaml` vérifie que le tag désigne un commit de `main`, que `CI OK`
a réussi sur ce commit, puis reconstruit le PDF sans cache et prépare une release
GitHub immuable en brouillon avec le PDF, sa somme SHA-256 et son attestation
Sigstore. La publication de cette release est une action humaine et déclenche
ensuite `zenodo.yaml`, qui vérifie les mêmes artefacts avant dépôt.

Le DOI `10.5281/zenodo.23040451` est un enregistrement externe déjà référencé
par le dépôt. Le dépôt ne fournit pas de preuve suffisante pour déterminer si
cet identifiant est le DOI de concept, celui d'une version, ni si son contenu
correspond à l'archive GitHub publiée le 29 septembre 2026 ; la release
`spec-v0.0.0-alpha.1` de GitHub est bien immuable mais ne contient actuellement
aucun asset. Cette incertitude est donc conservée comme provenance externe à
vérifier, et non transformée en fait.

Le flux `scripts/sync_zenodo.py` n'infère jamais le concept à partir de ce DOI :
`ZENODO_CONCEPT_RECID` doit être fourni explicitement, ou prendre la valeur
`NEW` lorsque la décision est de créer délibérément un nouveau concept. À
l'exécution, le flux ajoute au record le tag, le commit, l'URL de release et le
SHA-256 du PDF, puis refuse une seconde publication du même tag. Ainsi,
l'enregistrement `23040451` ne peut pas provoquer silencieusement une collision
avec le prochain concept publié.
