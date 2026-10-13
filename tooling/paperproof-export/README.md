<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Paperproof extraction workspace

This is an isolated compatibility workspace for exporting tactic-proof observations used by K7PL's static documentation. It is not imported by the normative specification or by K7PL's regular implementation build.

## Why a separate workspace?

K7PL's canonical toolchain is declared in the repository root and currently uses Lean 4.34.0. The reviewed Paperproof source revision uses an older Lean/Mathlib stack (Lean 4.29.0-rc8 in its example workspace, with a nested library toolchain also present in upstream). Updating K7PL's root toolchain or adding an incompatible Paperproof dependency would risk unrelated builds. This workspace pins Paperproof to commit 05c68e9cb8e881f9e971abb94efd231a269e0229 and uses a matching Mathlib release. Its lockfile pins transitive package revisions.

Paperproof's upstream terminal program extracts observed tactic steps and their goals into JSON. K7PL reuses this upstream extractor; it does not vendor or patch its parser. The K7PL renderer consumes that JSON in a separate Python script.

## Reproduce locally

First build the normal K7PL documentation site with the root toolchain and the repository's documented figure prerequisites. Then run:

    cd tooling/paperproof-export
    lake exe cache get
    cd ../..
    python3 scripts/ci/build_proof_visualizations.py \
      --site _out/spec/html-multi \
      --ref "$(git rev-parse HEAD)" \
      --extractor-dir tooling/paperproof-export

The extractor calls the upstream command with a source file, fully qualified declaration name, and temporary JSON output path. The renderer writes static pages under _out/spec/html-multi/proofs/, raw structured artifacts under proofs/data/, and a manifest.json. It adds a link to the existing navigation index. The output is generated during CI and is not committed as hand-maintained site content.

## Current targets

- K7pl.Arith.eval_double in src/K7pl/Arith.lean.
- K7pl.UsageScale.scaleUsage_comp in src/K7pl/UsageScale.lean.
- K7pl.UsageScale.projectUsageContext_scale in src/K7pl/UsageScale.lean.

These targets are selected examples, not a declaration inventory. Source links are anchored to the exact source revision that produced the site. Target labels and short descriptions are editorial; proof scripts, theorem statements, tactics, hypotheses and goals are taken from source and Paperproof's output.

## Contract and limits

The output schema is k7pl.proof-visualization/v1. Each JSON artifact carries the declaration identity, source path and SHA-256, revision, line span, extractor revision, both toolchains, exported steps/goals, and explicit non-claims. The Python validator refuses exports without tactic steps, positions, before-goals or after/spawned-goal arrays. It does not fill in missing goal states. All goal and hypothesis text is HTML escaped.

The site is static, has no JavaScript runtime requirement for these views, supports keyboard disclosure via native details/summary, uses text labels and outlines rather than color-only distinctions, and collapses transitions into a single column on small screens. This is a mechanical accessibility baseline, not a claim of conformance or successful human usability evaluation.

The separate extractor toolchain is not evidence that the main K7PL toolchain verified an object. The root K7PL CI build checks the source independently under its pinned version. The static HTML and JSON are derived views, not proofs; the extractor does not establish a normative-to-Lean correspondence. If a declaration cannot be exported, generation fails instead of making a placeholder claim.

Paperproof's upstream interface is documented in https://github.com/Paper-Proof/paperproof, in particular its terminal export source. Upstream license: MIT. No Paperproof dependency is added to the root Lake workspace.
