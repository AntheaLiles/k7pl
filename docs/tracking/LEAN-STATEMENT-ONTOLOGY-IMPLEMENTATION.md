<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Shared statement ontology: implementation contract

**Status:** the shared representation, legacy compatibility and structural controls passed CI on PR #134 exact head `0a2171c3c3a188a9d2802bd6779392d393eefe07` (run [#1024](https://github.com/AntheaLiles/k7pl/actions/runs/38121483338), 2026-10-11). PR #134 remains open and unmerged; validation of the migrated source belongs to PR #139.

This document records the shared implementation and structural-control slice of C8. On the exact head recorded above, Python tooling tests, quick checks, Lean implementation/tests, Verso rendering, and PDF compilation succeeded. These results validate that revision's build and mechanical controls only; they do not validate the migrated source blocks or establish any mathematical claim.

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
::::theorem (label := "thm:example") (state := "under-review") (scope := "metatheory") (evidence := "proofsketch")
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
::::literature (label := "thm:external-result") (source := "doi:10.xxxx/example") (scope := "literature")
:::statement
The externally attributed result is stated here.
:::
::::
```

Metadata validation rejects unknown epistemic/evidence values, incompatible kind/role pairs, missing labels on numbered/referenced command kinds, literature objects without provenance, machine-checked evidence without a formal artifact identifier, and hypotheses without an explicit non-global scope. Examples and counterexamples are unnumbered by default; `+unnumbered` can mark another genuinely local object as unnumbered. `evidence := "lean-proof"` is intentionally distinct from a written proof or a proof sketch.

## Compatibility and limits

- Existing source blocks are not migrated by this change. They retain their labels, prose, references, and legacy numbering.
- The shared representation and legacy compatibility are covered by PR #134. Ontology metadata checks and inventory drift controls are implemented across C8.3/C8.4; the 69-block migration and its register have a separate validation gate in PR #139.
- Python structural controls cross-check `evidence` against the presence/absence of `:::proofsketch` for specialized directives. This is a metadata/slot check, not a proof checker and not a judgment of proof adequacy.
- A hypothesis still needs an explicit local scope string and must be attached to the relevant argument/result during controlled migration; this directive does not by itself prove that structural relationship.
- Bibliographic identifiers are represented as source strings. The controls require provenance to be present but do not resolve canonical bibliographic identifiers or prove that an external claim supports its use in K7PL.
- No `::::thm` statement has been assigned `established` as a consequence of this refactor. Metadata never substitutes for a proof.

## Validation record and assurance boundary

CI run [#1024](https://github.com/AntheaLiles/k7pl/actions/runs/38121483338) passed on the exact PR #134 head `0a2171c3c3a188a9d2802bd6779392d393eefe07`, including Python tooling, quick checks, Lean implementation/tests, Verso rendering, and PDF compilation.

The current migration is reviewed independently in PR #139. A passing build or structural checker is not mathematical proof validation. The remaining obligations include bibliographic source resolution, semantic attachment of local hypotheses, proof adequacy, and the rendered numbering/reference review recorded in the migration register.

### Controlled scope vocabulary

The `scope` argument is a closed identifier, not free-form prose. The accepted tags are: `syntax`, `metatheory`, `graphs`, `resources`, `memory-safety`, `security`, `operational-semantics`, `graded-typing`, `effects`, `logical-relations`, `translation`, `fixed-points`, `interoperability`, `concurrency`, `ffi-safety`, `representation`, `compiler-interface`, `compilation`, `resource-accounting`, `literature`, and `runtime`. Detailed assumptions and limits remain in the statement text and the migration register; the tag must not be read as proof of any guarantee.


### Controlled scope vocabulary

The `scope` argument is a closed identifier, not free-form prose. The accepted tags are: `syntax`, `metatheory`, `graphs`, `resources`, `memory-safety`, `security`, `operational-semantics`, `graded-typing`, `effects`, `logical-relations`, `translation`, `fixed-points`, `interoperability`, `concurrency`, `ffi-safety`, `representation`, `compiler-interface`, `compilation`, `resource-accounting`, `literature`, and `runtime`. Detailed assumptions and limits remain in the statement text and the migration register; the tag must not be read as proof of any guarantee.
