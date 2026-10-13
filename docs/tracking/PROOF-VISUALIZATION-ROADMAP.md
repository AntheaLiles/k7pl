<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Proof visualization roadmap for K7PL

**Status as of 2026-10-13:** first code prototype prepared; the Lean fixtures are part of the project build, but the Paperproof editor UI has not yet been visually validated. This is a technical roadmap, not a claim that a proof visualization establishes specification conformance.

## Evidence from the current repository

The project already has a browser-based documentation/navigation graph and a separate source-driven semantic graph. Their documented edge vocabulary is intentionally limited to structural containment, rendered references and citations; neither infers proof relations from names or file proximity. See [the navigation graph contract](../../scripts/ci/navigation_graph/README.md), [the inventory of interactive exploration](INTERACTIVE-EXPLORATION-INVENTORY.md), and [the current navigation backlog](INTERACTIVE-EXPLORATION-PLAN.md).

The C3 Lean kernel already contains tactic proofs that are useful first targets: `scaleUsage_comp`, `addContext_assoc` and `eraseContext_singleton` in [EffectiveKernel.lean](../../spec/Spec/C3/EffectiveKernel.lean). The shared Verso statement representation has a `formalArtifact` field in [Theorem.lean](../../tools/SpecExt/Theorem.lean), and the statement-ontology check validates the permitted combinations of evidence metadata in [statement_ontology.py](../../scripts/controles/statement_ontology.py). This is not yet a general, mechanically checked graph of proof dependencies.

[Paperproof](https://github.com/Paper-Proof/paperproof) is a VS Code extension that visualizes the evolution of goals and hypotheses in tactic-based Lean proofs beginning with `by`. It is a good first instrument for examining proof scripts, but its visualization is editor-side: it does not by itself create an embeddable proof tree for the K7PL website, prove a specification-to-Lean correspondence, or establish that a theorem is normatively adequate. No Paperproof dependency has been added to K7PL's Lake project.

## Implementation status

### M1 — Lean `by` proof-tree fixture

**Status: prototype implemented; CI and visual validation are separate gates.**

[`tests/ProofVisualization.lean`](../../tests/ProofVisualization.lean) provides three tactic proofs over the actual C3 kernel types and operations. They mirror existing proofs to give the editor a small, stable set of readable targets:

- `paperproof_scaleUsage_comp`: record update, case analysis and simplification;
- `paperproof_addContext_assoc`: function extensionality and associativity;
- `paperproof_eraseContext_singleton`: an equality split followed by simplification.

The module is listed as a root of `K7plTests` in `lakefile.lean`, so it is compiled with the ordinary project tests. It imports no Paperproof module and changes no normative statement. The fixtures are duplicated proof scripts for visualization, not authoritative claims and not evidence of equivalence to the specification.

**Repository verification:** `lake build K7plTests`; `python3 scripts/ci/check_lean_modules.py`. The CI result is the evidence for successful compilation; it does not validate the Paperproof interface.

### M2 — Validate usefulness before building a second interface

**Status: proposed; requires a human editor session.**

Use Paperproof on the three fixture theorems, then open their canonical counterparts in `spec/Spec/C3/EffectiveKernel.lean`. Record the VS Code/Paperproof versions, whether all three proof trees render on the repository's Lean 4.34.0 toolchain, and any failure or confusing representation. Evaluate whether the tree helps explain tactic steps that are hard to follow in source, rather than merely confirming that source code exists.

**Exit condition:** all three examples have either been rendered successfully or a reproducible incompatibility has been recorded; the observed value and limitations are written down. Do not proceed to website integration solely because the Lean module compiles.

### M3 — Validate explicit formal-artifact targets

**Value:** high; reduces broken or misleading links between statements and Lean declarations.  
**Dependency:** M1 fixtures build, and M2 confirms the chosen proof-view workflow is usable.

Add a machine check for explicitly declared `formalArtifact` targets, using Lean's actual module/declaration inventory rather than name similarity. Report target-existence separately from semantic correspondence. A declaration that exists is not, by itself, evidence that it formalizes the prose statement; such a correspondence needs an explicit source mapping and appropriate review.

**Acceptance:** missing or malformed targets fail a focused test; valid targets resolve to their canonical source location; no proof or conformance status is inferred from the target's existence.

### M4 — Connect proof targets to the existing web navigation graph

**Value:** high once M3 provides reliable target identities.  
**Dependency:** M3; reuse the current graph model rather than introducing a parallel graph.

Expose only explicit links from a statement to its formal target and source location. Keep distinct edge types for documentation references, citation, declaration target and any later reviewed correspondence. The website should link to the Lean source and the editor-side Paperproof workflow; it should not claim to render Paperproof's proof tree in HTML unless a separate, tested export mechanism exists.

**Acceptance:** navigation links resolve; generated edges are traceable to explicit metadata; absence of metadata stays absence, not an inferred relation.

### M5 — Cover Lean proofs that Paperproof's proof-tree mode does not represent

**Value:** medium to high; avoids making tactic scripts the implicit model of all proof evidence.  
**Dependency:** M1–M3, plus a concrete inventory of proof forms in current source.

Inventory term-style proofs, definitional proofs, automated tactics and generated proof terms separately. For each category, decide whether a Paperproof feature already covers it, whether a different Lean view is appropriate, or whether the artefact should remain a direct source link. Do not write a custom renderer until the gap is demonstrated with concrete repository examples.

**Acceptance:** a tested coverage table names the source examples, the visual mechanism, and the unsupported cases.

### M6 — Reusable proof-visualization model across ecosystems

**Value:** strategic; implementation should follow comparative evidence, not precede it.  
**Dependency:** M3's distinction between artifact identity, visualization, proof evidence and semantic correspondence; M5's inventory of Lean proof forms.

Compare concrete workflows and exported data from Lean/Paperproof, Idris, Agda, Rocq and Isabelle. Separate at least: proof text/term, goals and hypotheses, transitions, branching, dependencies, source provenance, and browser-export capability. First produce a small comparative matrix with citations and one representative example per ecosystem; only then propose an adapter or common interchange representation.

**Acceptance:** no common schema is assumed until the comparison identifies which concepts genuinely correspond and which are ecosystem-specific.

## Human actions required now

- [ ] Install or enable the [Paperproof VS Code extension](https://marketplace.visualstudio.com/items?itemName=paperproof.paperproof) in a local VS Code session.
- [ ] Open `tests/ProofVisualization.lean`, inspect the Paperproof views for all three `paperproof_*` declarations, then inspect the corresponding canonical declarations in `spec/Spec/C3/EffectiveKernel.lean`.
- [ ] Record the extension version, VS Code version, result for each theorem, and any error against Lean 4.34.0. If it fails, retain the exact error; do not add Paperproof to the build dependencies as a workaround without a separate technical decision.
- [ ] Judge whether the visualization improves comprehension of the proof steps and identify any misleading simplification. This is an editorial/research evaluation, not a CI assertion.

No authorial decision is needed to merge a test fixture, and no normative K7PL change is included here. Future assertions that a given Lean declaration corresponds to a specific normative statement must remain an explicit review item.

## Commands and claims

| Claim | Verification | What the verification does **not** establish |
|---|---|---|
| The demo module is part of the Lean test roots | `lakefile.lean`, `K7plTests.roots` | That a VS Code extension is installed |
| The fixtures compile | `lake build K7plTests` or the matching green CI job | That Paperproof renders their proof trees |
| Lean source has the canonical proofs listed above | `spec/Spec/C3/EffectiveKernel.lean`, search the three theorem names | Semantic correspondence with every normative statement |
| Existing web graph does not infer proof relations | `scripts/ci/navigation_graph/README.md` | That its user experience is already optimal |
| Paperproof's supported interface and proof-mode boundary | [Official Paperproof README](https://github.com/Paper-Proof/paperproof) | Compatibility or usability on this workstation's exact VS Code/Lean setup |
