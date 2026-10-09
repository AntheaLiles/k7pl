<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 01: reusable metatheory statements

**Status:** provisional source-level review; author ratification required.  
**Scope:** the seven active statement blocks in `spec/Spec/C2/SixSchemasDeMetatheorie.lean`.  
**Method:** read each complete statement and proof sketch, then checked whether the stated assumptions visibly support the claimed conclusion. This is not a Lean formal proof or independent validation of the mathematics.  
**Source integrity:** no mathematical source, label, hypothesis, or proof sketch was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:schema_commutation` | Under-specified general schema | Structural recursion, hygiene, and preservation of binding do not by themselves state the compatibility laws needed for substitution commutation |
| `thm:schema_preservation` | Plausible induction schema, interface incomplete | Define how contexts, premises, and rule instances are translated, and what it means for each rule image to be a target derivation |
| `thm:tri_topologique` | Standard result; sketch appears adequate at this level | State graph conventions and whether the graph is simple or permits irrelevant edge multiplicity |
| `thm:schema_restriction` | Not yet justified as a generic theorem | The structure, restriction map, closure/stability condition, and source/target of the claimed morphism are not defined precisely enough |
| `thm:schema_reinvocation` | Compound: intended law plus open compatibility obligation | “Finite” conflicts with `n ∈ ℕ∞`; associativity/unit and the action laws are not established by the sketch |
| `thm:schema_effacement` | Conclusion exceeds the cited conditions as currently stated | “What it forgets is exactly the fibre” and the refinement-system morphism need definitions and a separate justification |
| `thm:lemme_capacite` | Conditional argument; operational premises need to be explicit | The typing/contraction rules and meaning of concurrent accesses are assumed rather than stated in the block |

None of these findings establishes that a claim is false. They identify the minimum mathematical/interface questions that must be resolved before assigning an epistemic state or migrating the command.

## Detailed findings

### 1. `thm:schema_commutation` — substitution commutation

The statement quantifies over a transformation defined by structural recursion that introduces no free variables and respects binding. The conclusion is that it commutes with substitution up to renaming of bound variables.

The sketch handles constructors componentwise and singles out binders. However, the stated conditions do not explicitly require the defining clauses of the transformation to preserve the variable/substitution structure. Structural recursion and hygiene alone are not a specification of those compatibility equations.

**Required review:** state the transformation's action on variables and each constructor, including binders; define capture-avoiding substitution and the renaming equivalence; then identify the exact side condition that makes the binder case work. Until those conditions are explicit, treat the schema as under-specified rather than established.

### 2. `thm:schema_preservation` — preservation by translation

The proof sketch is the expected induction over a source derivation, provided every source rule instance maps to a target derivation whose premises correspond to the translations of the source premises.

The statement currently says that the image of every source rule is a target derivation, but does not define the translation of contexts/judgments or the compatibility between a rule instance and its translated premises. “Composition of derivations is admissible” also depends on the target system's actual judgment structure.

**Required review:** specify the source and target judgment forms, the context translation, and the per-rule obligation (including premises and side conditions). Keep this as a general proof schema; do not treat the prose alone as evidence that each future instance satisfies the obligation.

### 3. `thm:tri_topologique` — topological ordering

The statement is the standard finite-DAG result. The sketch's orientation is consistent: choose a vertex with no predecessor, place it first, and recursively order the remaining graph.

**Required review:** make the edge orientation convention explicit in the surrounding graph definitions. No substantive defect is identified in the sketch as written; this is not a substitute for checking downstream applications' acyclicity premises.

### 4. `thm:schema_restriction` — restriction as a morphism

The statement refers to a criterion on elements, an operation that removes excluded elements, and stability under the structure's operations. It then concludes that the restriction is a morphism preserving composition and identity. The proof sketch describes a mixed case where one argument is removed and another retained, but does not specify the algebraic structure or how the restriction acts on such inputs.

For a generic structure, closure of the retained elements does not by itself define an endomorphism on all original elements, nor does “removing” elements automatically produce a map preserving identities and composition.

**Required review:** define the category/algebraic structure, the source and target of the restriction, the map on objects and operations, and the precise closure/stability condition. Check each claimed instance against that interface. Do not infer a generic morphism theorem from the analogy among the five listed constructions.

### 5. `thm:schema_reinvocation` — bounded reinvocation

The prose combines a context-scaling operation, an effect transformation, an associativity claim, and a unit claim. The sketch explicitly leaves compatibility of context scaling and effect transformation as an obligation, and warns that it is not automatic for the full grade structure.

There is also a domain mismatch: “finite” reinvocation is stated for `n ∈ ℕ∞`, which conventionally includes an infinite element. The statement does not itself state the associativity/unit laws in a form that the sketch proves.

**Required review:** decide whether the domain is finite natural numbers or an extended domain containing infinity; state the laws for `Scale_Usage` and `φ_n` and their compatibility; separate the generic definition from the finite-reinvocation compatibility requirement if the latter remains open. No budget multiplication should be inferred.

### 6. `thm:schema_effacement` — refinement-system morphism

The sketch cites commutation, preservation, and refinement as three already established results. Even if the first two obligations hold, the further claim that “what it forgets is exactly the fibre” requires a definition of the relevant map, refinement relation/system, and fibre. It does not follow from commutation and derivation preservation alone without additional structure.

**Required review:** define the refinement systems and morphism, identify the map whose fibres are meant, and state the exact result supplied by `thm:raffinement`. Verify that its hypotheses match the transformation in this schema. Preserve the three dependencies, but do not treat the citations themselves as validation of the composite conclusion.

### 7. `thm:lemme_capacite` — linear capability

The sketch's intended argument is that two accesses require two occurrences of a capability of grade 1, which would require a prohibited contraction. This is valid only relative to specific typing rules and a precise meaning of “two concurrent accesses.” Those conditions are described informally, not fully captured by the block.

**Required review:** cite or state the capability-introduction/access rules, the exact contraction rule and its admissible grades, and the formal notion of concurrency/access distinctness. Check whether the conclusion follows from linearity alone or additionally needs a property of the operational semantics. Keep the result conditional until these interfaces are explicit.

## Consequences for C8

1. These seven blocks are not ready for automatic migration based solely on their current `status` values or titles.
2. The generic schemas need explicit interfaces and instance obligations; a shared label such as “theorem” must not conceal an unfulfilled obligation.
3. `thm:schema_reinvocation` is the clearest candidate for decomposition into a definition/schema and a separate compatibility requirement if the author confirms that the compatibility remains open.
4. No source claim has been reclassified as established, refuted, or withdrawn in this note. All proposed resolutions require author review.
5. This batch is limited to `SixSchemasDeMetatheorie.lean`; it does not close the semantic audit of the remaining 62 blocks.
