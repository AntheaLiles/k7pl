<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Migration register

This directory contains the operational records for the legacy documentation migration defined by [LEGACY-MIGRATION.md](../LEGACY-MIGRATION.md).

The migration is knowledge migration, not file migration. Legacy material is treated as source evidence; current documents are rewritten knowledge supports. The controlled sequence is extraction, qualification, rewriting, traceability, validation, and only then physical relocation.

## Lot states

NOT STARTED → IN PROGRESS → UNDER REVIEW → VALIDATED.

A lot is not validated merely because files have been moved. Semantic, epistemic, traceability, and navigation checks are required.

## L0 — Corpus freeze and inventory

The authoritative L0 register is [LEGACY-INVENTORY.md](LEGACY-INVENTORY.md). It is generated from the Git working tree by [scripts/inventory_legacy.py](../../scripts/inventory_legacy.py).

The first inventory records the legacy corpus without modifying or deleting it. Candidate destinations are provisional until semantic qualification.

## L1–L5

The detailed execution order remains defined in [LEGACY-MIGRATION.md](../LEGACY-MIGRATION.md):

- L1: `suivi/`
- L2: `recherche/`
- L3: `methode/` and `relectures/`
- L4: `journal/`, `bibliographie/`, and `historique/`
- L5: global validation and physical relocation.

The register must be updated as each extracted proposition is qualified and rewritten. Historical sources remain identifiable until the corresponding lot is validated.
