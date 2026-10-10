<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Shared statement ontology: implementation contract

**Status:** implementation draft in PR; build and rendering validation pending.

This document records the first implementation slice of C8. It is not evidence that the Lean extension compiles, that migrated source blocks are correct, or that any mathematical claim is established.

## Shared representation

`tools/SpecExt/Theorem.lean` now defines one internal `StatementInfo` record used by the existing `::::thm` directive and the specialized authoring directives. It separates:

- `kind`: `definition`, `assumption`, `result`, `requirement`, `literature`, `example`, `counterexample`;
- `role`: theorem, lemma, corollary, proposition, conjecture, axiom, postulate, or hypothesis, where applicable;
- `epistemicState`: proposed, under-review, supported, established, refuted, withdrawn, or not-applicable for object kinds without a truth status;
- `evidence`: none, written-proof, proofsketch, literature, computation, counterexample, or lean-proof;
- `scope`, kept distinct from historical `level`;
- `source` for provenance and `formalArtifact` for a machine-checked Lean artifact.

The legacy `status` field remains only as a display/compatibility value. Legacy `::::thm` blocks map into the shared record without changing their source syntax or promoting their epistemic status. The historical shared counter is retained for legacy blocks; new commands use role/kind-specific sequences.

## Authoring commands

The shared parser/constructor is exposed through these directives: `::::definition`, `::::axiom`, `::::postulate`, `::::hypothesis`, `::::theorem`, `::::lemma`, `::::corollary`, `::::proposition`, `::::conjecture`, `::::requirement`, `::::literature`, `::::example`, and `::::counterexample`.

Example of a result candidate:

```text
::::theorem (label := "thm:example") (state := "under-review") (scope := "chapter-level") (evidence := "proofsketch")
:::statement
The statement text is preserved here.
:::
:::proofsketch
The incomplete proof argument is recorded here.
:::
::::
```

Example of a literature object:

```text
::::literature (label := "thm:external-result") (source := "doi:10.xxxx/example") (scope := "documentary")
:::statement
The externally attributed result is stated here.
:::
::::
```

Metadata validation rejects unknown epistemic/evidence values, incompatible kind/role pairs, missing labels on numbered/referenced command kinds, literature objects without provenance, machine-checked evidence without a formal artifact identifier, and hypotheses without an explicit non-global scope. Examples and counterexamples are unnumbered by default; `+unnumbered` can mark another genuinely local object as unnumbered. `evidence := "lean-proof"` is intentionally distinct from a written proof or a proof sketch.

## Compatibility and limits

- Existing source blocks are not migrated by this change. They retain their labels, prose, references, and legacy numbering.
- The first slice shares the renderer and internal representation; it does not yet update the inventory, Python controls, or CI gate. Those belong to the next C8 point.
- Presence/absence of `:::proofsketch` is not yet cross-validated against the `evidence` metadata. The next validation slice must make slot-parent rules mechanically enforceable.
- A hypothesis still needs an explicit local scope string and must be attached to the relevant argument/result during controlled migration; this directive does not by itself prove that structural relationship.
- Bibliographic identifiers are currently represented as strings. Their canonical format and reference resolution remain to be specified by the inventory/control work.
- No `::::thm` statement has been assigned `established` as a consequence of this refactor. Metadata never substitutes for a proof.

## Required validation before merge

1. Run the Lean build and tests for `SpecExt` and the `Spec` library.
2. Generate both HTML and PDF/LaTeX outputs and compare representative legacy blocks.
3. Exercise every new command, including invalid metadata combinations and the compatibility path.
4. Confirm the old labels/references and legacy numbering are unchanged.
5. Do not migrate the 69 blocks or remove legacy support in this PR.