<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 08: session deadlock freedom and parallel determinism

**Status:** provisional source-level review; author ratification required.  
**Scope:** complete blocks `thm:deadlock_acyclique` in `spec/Spec/C3/LesContraintesDeValeur.lean` and `thm:determinisme_parallele` in `spec/Spec/C3/ReglesDeTypage.lean`, including their stated premises and direct dependencies.  
**Method:** inspect the complete statements and proof sketches for agreement between assumptions, operational claims, and conclusions. This is not a Lean formal proof or independent validation of the cited session-calculus literature.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:deadlock_acyclique` | The proof sketch explicitly identifies preservation of the relationship between the static wiring graph and the dynamic wait graph as the key invariant, but the transition from “missing premise” to “by construction” is not formalized | Define the wiring/dependency and wait relations; prove each reachable waiting edge is supported by a wiring edge and that reduction preserves this invariant |
| `thm:determinisme_parallele` | The depth inequality is immediate for nonnegative costs, but equality of returned values and the claimed effect scope need explicit operational assumptions | Define the observation/result of parallel and sequential composition and show independent layer-3 computations cannot interfere; specify the cost algebra and treatment of failures/termination |

Neither finding establishes falsity. The review distinguishes a plausible design argument from the formal invariant and semantic definitions needed to support the statements.

## Detailed findings

### 1. `thm:deadlock_acyclique` — absence of mutual blocking from session-graph acyclicity

The statement assumes a network of actors whose channels are typed by dual session protocols and whose dependency graph is acyclic. It concludes that the network never reaches a state of mutual deadlock.

The sketch has a clear intended argument: linear session endpoints cannot be silently abandoned; the compile-time graph is finite and checked for acyclicity; topological ordering and cut elimination identify a possible communication. It also explicitly recognizes that the compile-time wiring graph and runtime wait graph are distinct. Acyclicity of the former does not, on its own, imply acyclicity of the latter.

The proof therefore needs the simulation invariant stated in the sketch: for every reachable state, if actor `a` waits for a message from actor `b`, then `(a,b)` is an edge of the wiring/dependency graph. Earlier in the same sketch this is described as the missing premise; later it is said to follow “by construction” from the typing judgment, because a `Guard` waits on a mailbox represented in the context. That is a potentially valid resolution, but the proof obligation has been relocated rather than discharged: the typing rules must actually constrain the mailbox's sender and preserve that association across actor activation, message consumption, residual mailbox types, timeout, and every reduction rule.

The claim that there is always a reducible communication also requires care about terminal networks and timeouts. The statement excludes mutual deadlock, not all blocked or terminal states. The proof should not conflate a network that has terminated, a state where a timeout is enabled, and a genuine cycle of actors waiting indefinitely.

**Required review:** define the static dependency relation and the dynamic wait relation independently. State the invariant relating them and prove it by induction/coinduction over reachable transitions, with cases for `Guard`, message emission/consumption, mailbox residuals, and `Timeout`. Then show that any nonterminal mutual-wait cycle induces a cycle in the static graph. Explicitly separate terminal states and timeout-enabled progress from mutual deadlock. Until the invariant is demonstrated from the actual rules, retain the result as a candidate with an incomplete proof interface.

### 2. `thm:determinisme_parallele` — layer-3 parallel determinism

The statement says that, for two layer-3 computations, parallel composition returns the same value as sequential composition, while the parallel computation's depth-effect component is bounded by the sequential one.

The sketch argues that layer 3 is cartesian and has cost as its only effect, so its computations have no operation through which to interfere. It then appeals to the neutral effect component to identify the returned values and uses `max(s₁,s₂) ≤ s₁+s₂` for the depth comparison. The numerical inequality is routine if costs are nonnegative elements of the specified cost monoid/order. It does not, by itself, prove the semantic equality of returned values.

The statement needs an explicit account of what “return the same value” means: syntactic equality, equality in the denotational semantics, or observational equivalence. It also needs the operational assumptions under which both branches terminate and return values, and how exceptions, divergence, or nondeterminism are treated. “No effects other than cost” is a promising non-interference premise, but the proof should derive the required independence from the layer-3 typing/operational rules rather than assume that the word “cartesian” alone entails it.

Finally, the conclusion says the effects differ only in depth. This should be checked against the complete effect structure: the proof sketch refers to neutral effect components and a depth component, so the exact projection and order used for the comparison should be named. The comparison is not a blanket claim that parallel execution is faster in wall-clock time; it is a statement about the formal depth component.

**Required review:** define result equality and the semantics of `c₁ ∥ c₂` and the sequential composition. State whether the theorem assumes termination and how errors/divergence are handled. Prove independence of the two layer-3 computations from the absence of observable non-cost effects, then establish the effect comparison using the exact grade operation and order. Keep the conclusion limited to the formal depth metric.

## Cross-cutting consequences for C8

1. Static acyclicity yields runtime deadlock freedom only through a preserved relation between wiring dependencies and runtime waits.
2. The claim that typing makes every wait edge a wiring edge needs rule-by-rule proof; it cannot be inferred from the intended architecture alone.
3. The depth inequality in `thm:determinisme_parallele` and equality of returned values are separate proof obligations.
4. No source claim has been reclassified in this note. All proposed obligations require author review.
5. This batch covers two blocks and does not close the audit of the remaining statement blocks.
