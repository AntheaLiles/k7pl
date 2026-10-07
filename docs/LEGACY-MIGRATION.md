<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Legacy documentation migration programme

This document defines the second-stage migration of the existing documentation material. The first controlled physical relocation has now been executed. This document remains the migration programme and provenance policy.

**Document version:** 1.0.0  
**Last updated:** 2026-10-06  
**Audience:** maintainers and future documentation editors.

## Objective

Transform the existing documentation corpus into material that is useful from the current documentation architecture without losing scientific provenance, review evidence, or historical context.

## Non-goals

This programme does not delete historical material, rewrite the normative specification to match documentation, or automatically move files based only on directory names.

## Phase 1 — Inventory

Classify every legacy document as one or more of:

- current normative support;
- current scientific explanation;
- current method;
- current assurance evidence;
- peer-review evidence;
- reference material;
- historical provenance;
- obsolete material.

Record source path, destination candidate, preservation requirement, and links that would be affected.

## Phase 2 — Extraction

For each document classified as current material, identify propositions, definitions, decisions, evidence, unresolved questions, and references that remain valid.

Do not copy historical conclusions into current documents without re-evaluating their validity.

## Phase 3 — Rewrite

Rewrite extracted material into the appropriate current document:

- architecture claims → ARCHITECTURE.md;
- scientific problem and contribution claims → RESEARCH.md;
- current methodological rules → METHOD.md;
- claims and evidence → ASSURANCE.md;
- current factual state → CI-generated STATUS.md;
- active review evidence → peer-review/.

A historical document may remain as provenance even when its relevant propositions have been rewritten elsewhere.

## Phase 4 — Traceability

For every migrated scientific claim, preserve a link to its source material until the migration is independently reviewed.

Where a claim has no current support, mark it as open or remove it from the current claim set rather than silently preserving it.

## Phase 5 — Relocation

Only after rewriting and traceability review should files be moved to docs/archives/ or another current location.

Preserve Git history and update internal links.

## Phase 6 — Validation

The migration is complete only when:

1. no legacy document is the sole source of a current normative claim;
2. current documents do not depend on obsolete terminology without explanation;
3. historical material remains identifiable as historical;
4. links and REUSE metadata pass CI;
5. an independent reader can follow the current documentation path without reconstructing project history.

## Planned order

The first migration targets should be the highest-value material from suivi/ and recherche/, followed by relectures/ and methode/. journal/, bibliographie/, and historique/ should be migrated only after their evidence or provenance roles have been classified.

No bulk move is authorized by this plan alone.
