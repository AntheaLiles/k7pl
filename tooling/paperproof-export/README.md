<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Paperproof extraction workspace

This is an isolated Lake workspace that extracts a curated set of real K7PL tactic proofs into versioned JSON observations. Verso is the only documentation front-end for the site's HTML and TeX/PDF outputs; the Python adapter produces data only.

## Compatibility and dependency boundary

The workspace is pinned to leanprover/lean4:v4.34.0 and Mathlib v4.34.0, matching the root K7PL toolchain release without adding Paperproof to the root Lake workspace. Paperproof is pinned to upstream commit 05c68e9cb8e881f9e971abb94efd231a269e0229; its parser and terminal are built from upstream source, not copied into K7PL. The lockfile records the full dependency graph. CI has verified this workspace's compilation and extraction for a selected set of declarations, not for every proof form or tactic.

Paperproof's terminal interface rejects source paths outside its own Lake workspace. The Python adapter therefore stages a byte-for-byte copy of each selected source file in a temporary directory inside this isolated workspace. The copied bytes preserve source positions, but the staging path is never used as provenance: artifacts refer to the canonical K7PL path, exact Git revision, source line range, and SHA-256 of the original bytes. Temporary source and terminal JSON files are cleaned up even when extraction fails.

## Reproduce the pipeline

From the repository root:

    cd tooling/paperproof-export
    lake exe cache get
    lake build terminal
    cd ../..

    python3 scripts/ci/build_proof_visualizations.py \
      --repo-root . \
      --data-dir _out/proof-visualizations/data \
      --ref "$(git rev-parse HEAD)" \
      --extractor-dir tooling/paperproof-export

Run the Verso document build afterwards:

    lake exe spec --output _out/spec --with-tex

The proofviz directive in spec/Spec/ProofVisualizations.lean reads the same JSON manifest for its HTML and TeX renderers. The TeX output is used by the PDF build. CI extracts data before the Verso render; it does not render or inject separate proof HTML pages after Verso.

## Current corpus and status

- K7pl.Arith.eval_double in src/K7pl/Arith.lean: simp and ring.
- K7pl.UsageScale.scaleUsage_comp in src/K7pl/UsageScale.lean: cases and simp.
- K7pl.UsageScale.projectUsageContext_scale in src/K7pl/UsageScale.lean: funext, cases and simp.
- K7pl.GradeBudget.finite_multiplicity_compatibility in src/K7pl/GradeBudget.lean: nested cases, have and simp.
- K7pl.MemoryCapability.allocate_preserves_unique in src/K7pl/MemoryCapability.lean: intro, by_cases, subst, have, simp and omega.

The first three declarations were extracted and rendered through Verso HTML/TeX under Lean 4.34.0 in CI run 38447082870. The latter two are part of the expanded corpus in this branch; their support status is pending the current CI result and must not be assumed in advance. These examples are selected cases, not a complete inventory.

Editorial titles and descriptions are separate from exported tactic steps, hypotheses and goals. A source-name similarity or shared module does not establish a normative correspondence.

## Contract and limits

The output schema is k7pl.proof-visualization/v1. Each JSON artifact carries declaration identity, canonical source path, revision, source hash, line span, extractor revision, both toolchain identifiers, exported steps and goals. The adapter refuses exports without tactic steps, positions, before-goals, or after/spawned-goal arrays. Missing states are not invented. The Verso renderer validates the schema, exact curated declaration/path mapping, source URL and line span, and consistency between artifact and manifest revision. HTML text is emitted through Verso's structured HTML representation; TeX text is escaped before insertion.

Lean 4.34.0 exposes public InfoTree/TacticInfo structures including tactic locations, metavariable contexts, and goals before and after tactics. Paperproof uses this general mechanism. However, observed output for five examples is not a general guarantee for all syntax or semantics. The coverage matrix distinguishes presence in the corpus from actual extraction, rendering, and test evidence.

Extracted views are observations, not independent proof terms and not verified mappings between Lean declarations and normative statements. The upstream Paperproof licence is MIT. No Paperproof source is copied or modified in this repository; its revision remains a pinned dependency in this isolated workspace.
