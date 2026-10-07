<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Project Dashboard

This is the current entry point for project tracking. It summarizes the state of the specification, the PR-02 review campaign, current obligations, and the gates that must be passed before implementation work is treated as stable.

The detailed registers remain the authoritative sources for their respective roles: [decisions](DECISIONS.md), [anomalies](ANOMALIES.md), [review cards](FICHES-PR02.md), [obligations](registre-obligations.md), [primitives](primitives.md), and the [documentation architecture plan](DOCUMENTATION-ARCHITECTURE-PLAN.md).

The dashboard contains generated blocks. Run `python3 scripts/suivi.py dashboard` after changes to the specification or tracking inputs. Generated values must not be edited manually.

## Current specification measures

<!-- BEGIN:mesures -->
<!-- END:mesures -->

## PR-02 campaign

<!-- BEGIN:fiches -->
<!-- END:fiches -->

## Open specification statements

<!-- BEGIN:ouverts -->
<!-- END:ouverts -->

## Reading the remaining work

The next scientific work is governed by the current PR-02 treatment plan and its dependency structure. Historical campaign plans remain in [`docs/history/`](../history/). Decisions that require author ratification are recorded in [`DECISIONS.md`](DECISIONS.md); the implementation gate is not inferred from a clean CI run alone.

The dashboard is a navigation surface, not a normative specification. The normative language definition remains in [`spec/`](../../spec/).
