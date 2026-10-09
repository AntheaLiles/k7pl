<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 03: operational metatheory and resource bounds

**Status:** provisional source-level review; author ratification required.  
**Scope:** the complete blocks `thm:preservation`, `thm:progres`, and `thm:correction_ressource` in `spec/Spec/C4/SemantiqueOperationnelle.lean`, including the surrounding explanations that state their intended use.  
**Method:** compare each statement with its proof sketch, the definitions it invokes, and the scope/assumptions declared in the surrounding text. This is not a Lean formal proof or an independent validation of the cited literature.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:preservation` | Substantial proof plan, but the concurrent trace/potential invariant needs a precise formal interface | Define the trace order, the product `τ · ε`, and the chain-wise interpretation under partial order |
| `thm:progres` | Conditional local-progress argument with explicit implementation assumptions; statement and global-progress discussion need alignment | Keep local progress distinct from progress of a pool, and make totality/arena-conformance assumptions part of the formal statement |
| `thm:correction_ressource` | Proposed instrumented-machine invariant, not yet proved by the supplied sketch | Define the instrumented transition relation and the per-rule update of `ν`; the crucial coherence argument is deferred |

None of these findings establishes falsity. In particular, an induction outline is not treated as a completed proof, and a statement about an instrumented semantics is not inferred from the uninstrumented semantics without a simulation/invariant argument.

## Detailed findings

### 1. `thm:preservation` — type preservation and non-increasing potential

The theorem combines subject reduction with a potential inequality:
`τ' · ε' ⊑ τ · ε`. The sketch separates pure reductions, effectful reductions, scoped operations, and congruence. It explicitly relies on the substitution lemma, effect typing rules, monotonicity of the effect product, and monotonicity of the scoped-effect transformer.

The statement adds a concurrent interpretation: `τ` is a labelled partial order rather than a sequence, and decrease is to be read along every chain. This is an important qualification, but the theorem block does not itself define the partial-order trace operations or the exact relation between a trace and the effect annotation. The proof sketch uses the product `τ · ε` and a chain-wise comparison as though their typing and monotonicity laws were already available. Those interfaces are prerequisites for the inequality to be a well-formed invariant.

The sketch also says that the scoped transformer is monotone because each element of `𝓜` has normal form `φₙ ∘ π_S` and both factors are monotone. That argument depends on the normal-form theorem and on closure of monotonicity under composition; the dependency should be explicit in the proof record.

**Required review:** specify the trace object and its order, define how a trace combines with a residual effect, and state the order-preservation laws required for each side of the product. Explain precisely how the sequential inequality lifts to the chain-wise partial-order case. Record the normal-form/monotonicity result used for scoped effects. Until these interfaces are explicit, classify the proof as outlined and conditional rather than established.

### 2. `thm:progres` — local progress and global progress

The statement gives the familiar shape of local progress for a closed, well-typed computation, parameterized by arbitrary arena state `μ` and trace `τ`. The proof sketch, however, begins by describing a different, global property: a multiset of concurrent computations advances if at least one member is reducible, and deadlock is excluded by acyclicity of the dependency graph. It then outlines local progress by induction on typing.

The surrounding text explicitly states two further assumptions: effect operations must be total on well-typed arguments, and the arena must conform to the lowering/compilation specification because the arena elimination rule is not given. It says these are to be module hypotheses in the proof assistant, not lemmas. They are therefore substantive premises, not incidental implementation notes.

**Required review:** separate (a) local progress of one closed computation from (b) global progress of a pool. For local progress, state the totality of each effect operation and the exact arena-conformance assumption in the theorem or its module context. For global progress, state the pool configuration, the criterion “at least one member can step,” and the acyclicity premise excluding mutual blocking. Do not use the local theorem alone as proof of the global one.

### 3. `thm:correction_ressource` — usage grades as execution bounds

The statement proposes extending the operational configuration with an instrumented counter `ν`, intended to count effective accesses per binding and per member of the concurrent pool, summing counts for shared bindings. It then claims that every execution respects the usage component of the grade in the typing context.

The sketch says the proof follows preservation by induction over transitions, with additional work to show the counter never exceeds the annotation. For rules composing two contexts, this is said to reduce to the coherence law for `φ` and `ψ`. The source itself later acknowledges that this is the “most substantial” part of the programme and notes that related results in the cited literature cover a more restricted simply typed fragment without recursion.

The proposed statement depends on an instrumented machine that is not defined within the theorem block. Without the counter's initial value, update function for each transition, treatment of binding creation/removal, and behavior under shared resources and concurrent steps, the invariant cannot yet be checked. Nor does the uninstrumented preservation theorem alone imply it: the proof needs a relation between each original step and its counter update, plus the usage arithmetic for the relevant rule.

**Required review:** define the instrumented configuration and transition relation, the initial counter, and the per-rule counter update. State how `ν` is indexed across contexts/members and how shared bindings are counted without double-counting or losing ownership information. Prove the variable-use, composition, substitution, and concurrency cases, identifying exactly where the coherence laws for `φ` and `ψ` are required. Preserve the caveat about the more restricted literature results; they motivate a proof route but do not establish the K7PL theorem.

## Cross-cutting consequences for C8

1. Type preservation, progress, and quantitative resource correctness are distinct obligations. The first does not imply the third without an instrumented-semantics argument.
2. The local/global distinction in progress must remain explicit, as must the two implementation hypotheses named by the source.
3. The partial-order trace model is part of the theorem's mathematical interface; the chain-wise interpretation should not remain only explanatory prose.
4. The usage-grade result should not be promoted based on its proof plan or the existence of analogous literature results.
5. No source claim has been reclassified in this note. All proposed decompositions and formal obligations require author review.
6. This batch covers three blocks; it does not close the audit of the remaining statement blocks.
