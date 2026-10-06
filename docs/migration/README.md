<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Migration register

This directory contains the operational records for the legacy documentation migration defined by LEGACY-MIGRATION.md.

The migration is knowledge migration, not file migration. Legacy material is source evidence; current documents are rewritten knowledge supports. The sequence is extraction, qualification, rewriting, traceability, validation, then physical relocation.

## Lot states

NOT STARTED → IN PROGRESS → UNDER REVIEW → VALIDATED.

## L0 — Corpus freeze and inventory

L0 is established by the reproducible inventory generator in scripts/inventory_legacy.py. Its mechanically derived fields must be regenerated from the Git working tree rather than manually maintained.

## L1 — suivi/

L1 is IN PROGRESS. Its semantic qualification is recorded in L1-SUIVI.md. No suivi/ file is moved or deleted during semantic qualification.

## L2–L5

L2: recherche/. L3: methode/ and relectures/. L4: journal/, bibliographie/, and historique/. L5: global validation and physical relocation.

The register is updated as extracted propositions are qualified and rewritten.
