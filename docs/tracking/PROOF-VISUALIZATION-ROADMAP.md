<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL proof and construction visualization roadmap

**State updated: 2026-10-13.** A first static proof-view pipeline is being added to the existing Verso site. Its extraction depends on a separate, pinned Lean workspace. Generated site artifacts and CI evidence will determine whether the whole chain is operational; an editor screenshot or a successful root build alone is not the acceptance criterion.

## 1. Architecture and authority

K7PL's canonical sources remain in their existing locations: normative/documentary formalization in spec/, executable Lean modules in src/, behavioral tests in tests/, Verso extensions in tools/, and generation/validation scripts in scripts/. Visualizations are derived outputs, not new authority.

The pipeline separates four things:

1. Kernel-checked source: what the K7PL build verifies under the root toolchain.
2. Extracted observations: the tactic transitions, goals and hypotheses Paperproof reports.
3. Rendered view: static HTML and JSON produced from those observations.
4. Editorial explanations: titles and descriptions selected to orient readers, explicitly identified as editorial.

The proof-view JSON uses schema k7pl.proof-visualization/v1. It stores declaration identity, exact source revision and lines, source SHA-256, extractor/toolchain provenance, Paperproof's step order, allGoals, and explicit non-claims. A missing or unsupported view must never be interpreted as a missing or unverified proof. No relation between a normative statement and a declaration is inferred from similar names or proximity.

The detailed coverage status and test evidence are maintained in [the proof visualization coverage matrix](PROOF-VISUALIZATION-COVERAGE.md). It deliberately distinguishes corpus presence from demonstrated extractor support.

## 2. M1 — extraction et rendu natif dans Verso

Paperproof reste une dépendance épinglée dans un workspace Lake isolé, mais celui-ci utilise désormais Lean 4.34.0 et Mathlib v4.34.0. K7PL ne change pas son toolchain racine ni ses dépendances normatives. Le script d'extraction produit seulement les artefacts JSON et leur manifeste : il ne fabrique plus de pages HTML autonomes ni de liens injectés après le rendu.

Le bloc proofviz de tools/SpecExt/ProofVisualization.lean consomme le même schéma JSON versionné pour ses deux backends Verso. Le renderer HTML utilise des nœuds structurés et du CSS ; le renderer TeX échappe les valeurs avant leur émission. La page de document spec/Spec/ProofVisualizations.lean appelle le bloc par des identifiants contrôlés. La CI exécute l'extraction avant la compilation Verso, puis construit HTML et TeX et compile le PDF.

Le run CI 38447082870 a validé cette chaîne sous Lean 4.34.0 pour trois déclarations réelles : K7pl.Arith.eval_double, K7pl.UsageScale.scaleUsage_comp et K7pl.UsageScale.projectUsageContext_scale. Le commit courant élargit le corpus à K7pl.GradeBudget.finite_multiplicity_compatibility et K7pl.MemoryCapability.allocate_preserves_unique ; leur statut est « en validation CI » jusqu'à la réussite du run qui les introduit.

Le registre de couverture détaillé se trouve dans [PROOF-VISUALIZATION-COVERAGE.md](PROOF-VISUALIZATION-COVERAGE.md). Il sépare les constructions présentes dans le corpus, les capacités réellement extraites, les validations par test et les limites encore ouvertes.

Le pipeline n'affirme pas qu'une vue est une preuve indépendante, ni qu'un énoncé Lean correspond à une déclaration normative. Il n'infère aucune relation depuis les noms ou la proximité des fichiers. Les exemples sélectionnés ne démontrent pas une couverture universelle de Lean.

## 3. M2 — human assessment of the visualization

**Human action still required:** inspect the generated proof pages on a current browser, keyboard-only and mobile-sized viewport; compare their transitions to the exact Lean source; record whether the view helps a reader understand goal changes rather than simply restating tactic syntax. Record any export failures and the relevant Paperproof/Lean versions. This is a usability/review action, not a CI property.

Exit condition: all currently selected views have been inspected, misleading or missing transitions are recorded, and the result is retained in the tracking record. If the exporter cannot elaborate a source on its isolated toolchain, record the exact failure and reduce the target set only with documented reasons; do not weaken the root Lean build.

## 4. M3 — validate explicit formalArtifact references

The existing Verso statement metadata has a formalArtifact field, but it does not yet form a globally validated proof graph. Add a checker that resolves only explicitly declared targets against Lean's module/declaration inventory. Report target existence and semantic correspondence as separate fields. The existence of a declaration cannot establish that it formalizes the cited prose statement.

Acceptance: a missing target fails a focused negative test; a valid target resolves to a canonical source location; a correspondence edge is emitted only if the metadata and review process explicitly warrant it.

## 5. M4 — integrate explicit links into existing navigation

Reuse scripts/ci/navigation_graph/ and its current HTML graph rather than create a second graph database. The current graph extracts containment, rendered references and citations; it intentionally does not infer proves, implemented-by or tested-by edges. Extend it only with a new relation type backed by formalArtifact metadata and source provenance. A static proof-view link should point to the generated view and canonical Lean source. It must not assert that a statement is normatively established merely because the target exists or builds.

Acceptance: output validation checks every local page/data link, source revision and target file. Unavailable metadata produces no edge.

## 6. M5 — other Lean constructs and proof forms

Do not equate every formal object with a tactic tree. The next coverage inventory should sample actual current sources and distinguish:
- tactic proof trace: goals/hypotheses through tactic transitions;
- term-style proof: elaborated proof term and its referenced declarations;
- definitions and expressions: syntax/AST or elaborated expression tree;
- inductive types: constructors, indices, parameters and recursors;
- elaboration: source syntax, elaborated expression and information/source locations;
- dependency graph: declarations that import or reference one another, which is not a proof progression.

Lean's InfoTree/TacticInfo API provides elaboration and tactic positions/goals: https://lean-lang.org/doc/api/Lean/Elab/InfoTree/Types.html. A future adapter should use exact information already emitted by Lean where possible and retain gaps where that information is unavailable.

## 7. M6 — targeted ecosystem comparison

No universal schema or adapters are justified yet. The comparison should focus on actual interfaces and limits:

| Ecosystem | Concrete interface to assess | What it can inform | Important limit |
|---|---|---|---|
| Lean | InfoTree/TacticInfo; Paperproof terminal JSON | tactic goal transitions, source positions, observed hypotheses | Paperproof's proof-tree mode is not a universal AST or dependency graph |
| Agda | interaction JSON and HTML backend: https://agda.readthedocs.io/en/latest/tools/command-line-options.html and https://agda.readthedocs.io/en/latest/tools/generating-html.html | editor interaction data and static source navigation | HTML output is not equivalent to a Paperproof goal-transition tree |
| Idris 2 | IDE/REPL interaction: https://idris2.readthedocs.io/en/latest/tutorial/interactive.html | holes, inspection, proof search and interactive editing | an interactive state protocol is not automatically a stable proof-serialization format |
| Rocq | proof mode and CoqIDE server: https://rocq-prover.org/doc/v8.20/refman/proofs/writing-proofs/proof-mode.html and https://docs.rocq-prover.org/v8.17/api/coqide-server/Interface/index.html | goals, local context, focused/background/shelved goals | interactive states need provenance and stable export decisions for publication |
| Isabelle | PIDE/JEdit and Isar proof commands: https://isabelle.in.tum.de/library/Doc/JEdit/JEdit.html and https://isabelle.in.tum.de/website-Isabelle2026-RC3/dist/library/Doc/Isar_Ref/Proof.html | document snapshots, proof state and structured Isar transitions | the document model and proof language should not be flattened into the Lean tactic model |

The first comparison should name one real example and its actual data interface per ecosystem. Only then decide which fields can be shared and where adapters must preserve ecosystem-specific semantics. Do not add those adapters in M1.

## 8. M7 — construction, implementation and tests

The long-term path is rule/statement → formalization/declaration → proof or construction → implementation → tests. Keep these edges typed and provenance-backed. The current navigation metadata and coverage scripts are useful sources, but no relationship should be manufactured from filename similarity, import adjacency or nearby line numbers. If a relation is manually reviewed, record that status; if generated, record its source and validation method. Keep edge validation status separate from the epistemic status of its target.

## Verification record

The relevant checks are:
- scripts/ci/test_build_proof_visualizations.py: offline tests for required export fields, rejection of empty/incomplete exports, source/declaration lookup, provenance claims, preservation of observed goal fields, and temporary source staging/cleanup. These tests use a synthetic Paperproof export; they do not execute Paperproof or test the Verso HTML/TeX renderers.
- The Verso renderer and full extraction path are exercised by the dedicated CI job: root specification build, pinned Paperproof extraction, HTML/TeX rendering, PDF generation, and downstream navigation/asset validation. Inspect the step logs for the exact commit before claiming this passed.
- scripts/ci/check_lean_modules.py and the root Lean build: the ordinary K7PL Lean sources/tests under the root toolchain; this does not by itself validate the separate extraction workspace.
- Existing navigation and HTML validators: local links, anchors, provenance and freshness only for the generated outputs and checks they explicitly cover. They do not independently prove semantic fidelity of each goal transition.

A passing Python unit test validates the renderer contract, not Paperproof's runtime compatibility. A passing root Lean build validates K7PL's compilation, not that the separate extractor ran. Completion of the static proof pipeline is determined by the end-to-end CI step; human usability remains separately open.
