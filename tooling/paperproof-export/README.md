<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Paperproof extraction workspace

This is an isolated Lake workspace that extracts a curated set of real K7PL tactic proofs into versioned JSON observations. The root K7PL implementation and normative specification remain on their existing Lean 4.34.0 toolchain and dependency graph.

## Compatibility and dependency boundary

The workspace is now pinned to `leanprover/lean4:v4.34.0` and Mathlib `v4.34.0`, matching the root K7PL toolchain release without adding Paperproof to the root Lake workspace. Paperproof is pinned to upstream commit `05c68e9cb8e881f9e971abb94efd231a269e0229`; its parser and terminal are built from upstream source, not copied into K7PL. The lockfile records the full dependency graph. This is a compatibility experiment for the selected declarations, not a claim that every tactic syntax or elaboration pattern is supported.

Paperproof's terminal interface rejects source paths outside its own Lake workspace. The Python adapter therefore stages a byte-for-byte copy of each selected source file in a temporary directory inside this isolated workspace. The copied bytes preserve the source positions, but the staging path is never used as provenance: artifacts refer to the canonical K7PL path, exact Git revision, source line range and SHA-256 of the original bytes. Temporary source and terminal JSON files are cleaned up even when extraction fails.

## Reproduce the pipeline

From the repository root, install the pinned toolchains and build the isolated extractor:

    cd tooling/paperproof-export
    lake exe cache get
    lake build terminal
    cd ../..

Then extract JSON observations at a specific source revision:

    python3 scripts/ci/build_proof_visualizations.py \
      --repo-root . \
      --data-dir _out/proof-visualizations/data \
      --data-only \
      --ref "$(git rev-parse HEAD)" \
      --extractor-dir tooling/paperproof-export

The extract step runs before `lake exe spec --output _out/spec --with-tex`. The `proofviz` Verso directive in `spec/Spec/ProofVisualizations.lean` reads that same JSON manifest in both the HTML and TeX backends. The TeX output is subsequently used by the PDF build. The previous standalone HTML mode remains transitional only; CI uses `--data-only` and does not inject a post-render navigation link.

## Current targets

- `K7pl.Arith.eval_double` in `src/K7pl/Arith.lean`.
- `K7pl.UsageScale.scaleUsage_comp` in `src/K7pl/UsageScale.lean`.
- `K7pl.UsageScale.projectUsageContext_scale` in `src/K7pl/UsageScale.lean`.

These declarations are selected examples, not a complete inventory. Editorial titles and descriptions are separate from exported tactic steps, hypotheses and goals. A source-name similarity or shared module does not establish a normative correspondence.

## Contract and limits

The output schema is `k7pl.proof-visualization/v1`. Each JSON artifact carries declaration identity, canonical source path, revision, source hash, line span, extractor revision, both toolchain identifiers, exported steps and goals. The adapter refuses exports without tactic steps, positions, before-goals, or after/spawned-goal arrays. Missing states are not invented. The Verso renderer validates schema, exact curated declaration/path mapping, source URL and line span, and consistency between artifact and manifest revision. HTML text uses Verso's structured HTML representation; TeX text is escaped before insertion into output.

The public Lean 4.34.0 `InfoTree` API includes `TacticInfo` nodes with metavariable contexts and goals before and after tactics. Paperproof uses this general public mechanism. The extractor's actual compatibility is nevertheless established only when the pinned workspace builds and exports each selected K7PL declaration in CI. A successful root K7PL build alone is not evidence of exporter compatibility. Nor do extracted observations constitute independent proof terms or a verified mapping between Lean declarations and normative statements.

The curated target set is intentionally narrow. The presence of a tactic family in source does not by itself demonstrate that its transition was extracted or rendered faithfully. The current coverage matrix separates corpus observations, adapter capabilities, test evidence, unsupported dimensions, and outstanding human validation.

Upstream Paperproof license: MIT. No Paperproof source is copied or modified in this repository; its revision remains a pinned dependency in this isolated workspace.
