<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 11: remaining statements and cross-domain obligations

**Status:** provisional source-level review; author ratification required.  
**Scope:** the 37 labels not covered by batches 01–10, as compared with the 69-entry mechanical inventory. The three labels in batch 10 are not repeated as audited targets here. Directly invoked dependencies and the surrounding source text were inspected where relevant.  
**Method and limit:** read the complete statement and proof-sketch blocks in the source files, then compare their conclusions with the hypotheses and named dependencies. This is not a Lean proof, external-standard conformance review, or author ratification. A plausible sketch is not treated as an established result. No source statement, label, assumption, status, or numbering was changed.

## Summary of findings

| Label | Provisional finding | Main obligation / decision |
|---|---|---|
| `thm:surete_spatiale` | Conditional resource-safety argument; H1 is assumed and is not independently discharged by this block | Resolve H1 through `thm:introduction_unique` without circular justification; preserve H2 and H3 |
| `thm:introduction_unique` | Composite claim: uniqueness, acyclicity, and termination; the arena-elimination case is explicitly unfinished | Separate the three conclusions and prove the missing arena-elimination case |
| `thm:elaboration` | Definition plus a semantic-preservation claim and consequences | Separate the definition of `Elab` from its correctness theorem and state the typing/scope conditions |
| `thm:staticite_syntaxe` | Broad architectural theorem supported by inspection of phases and macro discipline | Enumerate every syntax-producing mechanism and connect the phase boundary to the operational semantics |
| `thm:hygiene` | Standard-looking substitution commutation, but dependent on the precise scoped AST/substitution algebra | State freshness, alpha-equivalence, and binder action explicitly |
| `thm:hygiene_graduee` | Explicitly not demonstrated; depends on macro expansion, substitution, and action compatibility | Keep proposed until the graded context/effect cases are proved |
| `thm:resucrage` | Explicit surface-language requirement, not a result of the kernel AST theorem | Retain as a separate requirement unless a surface binding algebra is supplied |
| `thm:determinisme_rejeu` | Conditional deterministic replay result | Formalize journal completeness, the observation relation, and capability-result capture |
| `thm:rejeu_binaire` | Binary identity needs stronger serialization and environment premises than observation equality alone | Define the representation map and injectivity/invariance condition precisely |
| `thm:liberte_initialisation` | DAG ordering excludes cyclic dependency waits only if node initialization itself terminates | Add local termination and exact wait-edge correspondence as premises |
| `thm:sync_motifs_jonction` | Atomic join reduction is plausible under the guard rule, but mailbox non-emptiness alone may not encode matching/guard eligibility | Specify the matching predicate and atomic transition semantics |
| `thm:surete_ffi` | Type-level ownership transfer supports the actor-side non-access claim, not host-side revocation | Keep the narrow theorem distinct from the external `thm:revocation_ffi` requirement |
| `thm:revocation_ffi` | Correctly identified as an implementation requirement beyond the language's type system | Define the observable post-return condition and test the bridge implementation |
| `thm:completude_graduee` | Finite code-to-premise enumeration is conditional on a complete kernel constructor/error inventory and an in-judgment trust boundary | Version and mechanically check the table; do not infer implementation completeness |
| `thm:completude_verificateur` | Explicit implementation requirement, with test-based or derivation-based routes | Keep separate from the logical completeness claim |
| `thm:coherence_subsomption` | Statement is semantic coherence of interpretations; existence of joins is not enough | Prove identity/composition laws for coercions in each factor and then for the product |
| `thm:commutation_monoide` | Finite iteration case is supported by multiplicativity; the infinite case has an explicit supremum-preservation premise | Verify the quotient map respects all presentation relations and the exact finite/infinite signatures |
| `thm:substitution` | Conditional multi-component substitution theorem with several distinct algebraic obligations | Keep grade projection, usage scaling, effect iteration, and budget transport separate |
| `thm:substitution_simultanee` | Corollary of elementary substitution under finite contexts; order-independence is not stable under a future ordered-context discipline | Keep as corollary; if ordered zones are adopted, state reverse-topological substitution order |
| `thm:lemme_fondamental` | Proof sketch explicitly omits `Declassify`; direct dependency cycle with bounded disclosure | Resolve the cycle by isolating a core fragment or parameterizing the release relation; do not claim established |
| `thm:isomorphisme_memoire` | Zero-copy layout claim is limited to primitive fixed-width arrays and a concrete ABI/profile | Validate exact Arrow/Cap'n Proto/MLIR alignment, null-bitmap, ownership, and pointer-writing conditions against pinned versions |
| `thm:expansion_macro` | Derivation from substitution is plausible; noncommutative effect order is correctly treated as occurrence order | Verify the expansion rule's exact occurrence and effect composition, without replacing it by an unjustified power law |
| `thm:homomorphisme_roues` | Injective payload encoding and select behavior are separate from arithmetic semantics; custom propagation is an implementation obligation | Differentially test all singularity operations and supported hardware/compiler combinations |
| `thm:representation_inobservable` | The stated condition needs correction at the specification level: injectivity of `obs ∘ repr` does not express invariance under alternative representations and can point in the opposite direction | Formulate observational equivalence of representations of the same value; keep the source unchanged pending author decision |
| `thm:interface_jugement` | Definition with a finite-scope closure claim, not a theorem about every future extension | Keep the declared scope and the revision clause; distinguish “exactly three” within the enumerated declaration forms from global extensibility |
| `thm:rejet_reproductible` | Conditional on fixed solver configuration and deterministic traversals/resource accounting | Specify the configuration as part of the input; test byte-identical diagnostics across repeated builds |
| `thm:abaissement_grades` | Explicit conjecture; schema preservation only applies once every lowering rule has a derivation image | Preserve conjectural status until each pass, grade mapping, and target rule is proved |
| `thm:terminaison_couche_3` | Instance of polarized progression; relies on the dependent fold and its decreasing index | State the evaluation relation and structural-recursion restrictions; do not quantify over arbitrary potentially diverging functions |
| `thm:productivite_couche_2` | Productivity is not established merely by `ω ⊖ 1 = ω`; a guarded observation-producing step is essential | Prove each finite observation is reached and state guardedness/constructor conditions |
| `thm:progression_polarisee` | Useful meta-schema, but termination and productivity are different conclusions and require different measure arguments | Retain two typed instances with distinct conclusions and hypotheses |
| `thm:loi_historique` | Distributive-law equations are stated abstractly; the sketch needs exact natural-transformation types and a componentwise verification | Check both coherence diagrams and truncation preservation, not just the intuitive reading |
| `thm:troncature_comonade` | Broad all-functor claim with several indexed maps and boundary equations; proof remains on paper | Type-check each `T`, `δ`, and `λ` equation, especially the rank boundary, and separate standard cofree facts from the K7PL truncation result |
| `thm:fenetre_grade` | The identification of three concrete windows with one grade is explicitly not demonstrated | Supply representation maps and prove that the compile-time bounds coincide |
| `thm:stabilisation_pipeline` | Finite-budget descent supports termination if every modifying pass consumes budget and no other transition increases it | State the transition invariant and how a no-change pass is detected |
| `thm:divulgation_delimitee` | Explicitly not demonstrated; its proof sketch depends on the fundamental lemma and non-interference | Resolve the dependency cycle before promotion; define the escape set, closure, and relational release clause |
| `thm:action_parallele` | Componentwise law is routine for finite natural multiplicities on work/depth pairs | Make the multiplicity domain and the exact parallel-effect operation explicit |
| `thm:preservation_type` | Compound block combining reduction preservation with the independent MLIR-lowering conjecture | Track core type preservation and `thm:abaissement_grades` separately, retaining P2 and P1b obligations |

## Detailed review notes

### 1. Memory safety: `thm:surete_spatiale` and `thm:introduction_unique`

The safety theorem relies on H1, H2, and H3. Its own sketch explicitly says linearity prevents duplication of one capability but does not prevent two capabilities from being independently introduced for the same region; H1 is needed for that second property. The introduction theorem claims H1, but its final sentence says the arena-elimination case remains to be written and that H1 depends on it. This is not a syntactic theorem-reference cycle: the explicit edge is `thm:introduction_unique → thm:surete_spatiale`. It is an argumentative circularity unless the arena-elimination rule or another independent premise establishes uniqueness. The introduction block is also composite: (a) uniqueness per region, (b) acyclicity of destinations, and (c) termination of arena construction have different measures and proof obligations. Keep H2 (interval disjointness) and H3 (nesting discipline) explicit; neither substitutes for H1.

### 2. Surface elaboration and macros: `thm:elaboration`, `thm:staticite_syntaxe`, `thm:hygiene`, `thm:hygiene_graduee`, `thm:resucrage`, `thm:expansion_macro`

The elaboration block is labelled as a definition, but its statement also asserts semantic preservation. The definition of `Elab` and a correctness theorem about `Sens` should be treated as distinct logical objects during migration. Its sketch relies on hygiene, substitution, typing, and a separate usage-scaling law for quantitative effects.

Static syntax is supported by a phase argument only if the inventory of syntax-producing mechanisms is complete. The source itself singles out macros and `bind-to`; the phase separation, scope index, and metalevel parametricity must be connected to formal rules rather than inferred from prose alone.

The ungraded hygiene equation is a plausible naturality law for a scoped AST, but “`σ` does not touch any variable bound by `M`” needs a precise freshness/renaming convention, and the binder case must establish equality modulo the chosen alpha-equivalence. The graded version explicitly says “Non démontré” and depends on `thm:expansion_macro`, elementary substitution, and action compatibility. It must not inherit the ungraded result by name alone. `thm:resucrage` correctly identifies a separate gap: kernel hygiene does not prove preservation of surface alpha-equivalence without a surface binding algebra and compositional desugaring.

The macro-expansion sketch correctly refuses to turn a declared grade into an effect multiplicity: effects compose in the actual syntax-occurrence order, and the quantale is noncommutative. Its remaining obligation is to align the formal `Expand` rule with that occurrence order and the precise substitution theorem, including repeated and unused metavariables.

### 3. Replay and initialization: `thm:determinisme_rejeu`, `thm:rejeu_binaire`, `thm:liberte_initialisation`, `thm:sync_motifs_jonction`

Logical replay follows if the journal is complete for every nondeterministic external observation and the replay substitutes exactly those recorded results. “Complete” is a substantive premise, not a consequence of pure handlers. Define the observation equivalence and the journal schema so the proof can identify which state components are compared.

Binary replay adds a stronger conclusion. The reproducibility profile must fix layout versions, architecture, floating-point rounding/NaN behavior, and scheduling; the serialization function must be deterministic. Equality of observations alone does not imply bit identity without a correctly typed and directed injectivity/invariance premise.

A DAG gives a topological order, but acyclicity alone does not prove that each actor's initialization terminates or that every dynamic wait corresponds to a graph edge. `thm:liberte_initialisation` therefore needs local termination and a precise graph/transition correspondence. The join-pattern theorem is grounded in the guard rule, but the displayed condition “both mailboxes are nonempty” is sufficient only if it includes matching payloads, compatible patterns, and all guard conditions. The lock-free pointer-swap implementation is a separate refinement obligation; the source-level equation does not itself prove the memory-model claim.

### 4. FFI boundary: `thm:surete_ffi` and `thm:revocation_ffi`

The safety theorem establishes the actor cannot access a linearly transferred buffer while the bridge owns its capability, provided no alias or untracked access bypasses the typed context. It explicitly does not establish that the host stops using the buffer after return. That second direction is correctly stated as an implementation requirement: stale host handles must be invalidated by a bridge mechanism and tested at the foreign boundary. Do not fold host-side revocation into the type theorem.

### 5. Rejection completeness and subsumption: `thm:completude_graduee`, `thm:completude_verificateur`, `thm:coherence_subsomption`

The graded-completeness claim is restricted to a closed list of kernel constructors and error codes; it also depends on the trust boundary being represented in the judgment. The code-to-missing-premise table must be generated or checked against the current grammar and rules, and the finite error inventory must be versioned. It does not establish the converse that every derivable program is accepted. That converse is an implementation property and is already separated as `thm:completude_verificateur`, an explicit requirement rather than a theorem.

For subsumption, componentwise joins establish properties of the order but do not establish coherence of the associated conversion functions. The proof must verify identity and composition for the conversion in each factor, including the usage/coercion interaction, then close the result under products. Until those obligations are discharged, retain the proposition status.

### 6. Algebra and substitution: `thm:commutation_monoide`, `thm:substitution`, `thm:substitution_simultanee`, `thm:action_parallele`

The monoid projection is well-defined only if it respects every relation in the presentation. The “no mixed relation” premise is the key sufficient condition described by the sketch; monotonicity and the finite iteration equation must be checked against the actual ordered-monoid structure. The `n = ω` case is genuinely stronger and depends on preservation of the relevant suprema; it must not be inferred from finite multiplicativity.

The elementary substitution theorem is deliberately conditional on a factored family of laws: type formation under erased usage, identity/composition/bilinearity of usage scaling, commutation with `ψ`, compatibility of full-grade conversions, and the separate action `φ_n` for effect repetition. These are different obligations and should remain separately traceable. The simultaneous theorem follows by iterating elementary substitution over a finite context, but its order-independence relies on contexts being finite maps. If ordered zones are introduced, the proof must substitute in reverse order within each zone, as the sketch itself notes.

The parallel action equation follows componentwise for finite integer multiplicities when work uses addition and depth uses maximum, since multiplication by a fixed nonnegative integer preserves both operations. State the multiplicity domain explicitly; do not silently extend the law to an undefined rational or infinite iteration.

### 7. Fundamental lemma and bounded disclosure: `thm:lemme_fondamental`, `thm:divulgation_delimitee`

The fundamental-lemma sketch leaves the `Declassify` case untreated and explicitly points to bounded disclosure. The disclosure sketch is explicitly “Non démontré” and depends on the fundamental lemma and non-interference. The syntactic cycle is real: `thm:lemme_fondamental → thm:divulgation_delimitee → thm:lemme_fondamental`. This prevents treating either sketch as a complete proof. Two plausible architectures remain: (A) prove a core fundamental lemma for the language without `Declassify`, then prove the extension separately under a release relation; or (B) parameterize the fundamental lemma by a release relation/condition and prove the `Declassify` case in that generalized theorem. A third possibility is an independent auxiliary closure/parametricity lemma. This batch does not select one architecture or modify source claims; an author decision is required before the cycle is removed.

The relation-logic argument also needs exact definitions for related substitutions, observation projection, closure of the escape set, and the release clause. Non-interference in the sequential fragment cannot silently cover communication or the declassification case.

### 8. Representation and ABI: `thm:isomorphisme_memoire`, `thm:homomorphisme_roues`, `thm:representation_inobservable`

The zero-copy result is deliberately narrow: fixed-width primitive values, a pinned profile of Arrow/Cap'n Proto/MLIR layouts, omitted Arrow validity bitmap only when there are no nulls, and an already aligned segment. It still requires the Cap'n Proto list pointer write. The structured-data case is not zero-copy and is a row/column transposition. The proof must verify the exact supported specification versions and alignment guarantees; a generic “64-bit aligned” statement must not be treated as a substitute for every format's precise contract.

The wheel singularity encoding has three different claims: four payload patterns are distinct; masked select returns the selected bits; and K7PL arithmetic follows a custom singularity-propagation table. The first two are representation-level claims, while the third is an implementation obligation, not a consequence of IEEE 754 NaN behavior. Differential tests should cover all singularity pairs and target/compiler combinations in the supported profile.

The representation-invisibility requirement contains a semantic mismatch in its current formula. The prose requires that alternative representations of the same value be observationally indistinguishable, whereas injectivity of `obs ∘ repr` is a property separating distinct values by observation and does not express invariance under representational variation. The suitable shape is an invariance/equivalence condition over two representations of the same semantic value, not injectivity of the value-to-observation map. This is a likely source-level specification defect; do not edit it automatically because the exact semantic domain of `repr` and `obs` must first be ratified.

### 9. Interface and compiler claims: `thm:interface_jugement`, `thm:rejet_reproductible`, `thm:abaissement_grades`, `thm:stabilisation_pipeline`

The interface judgment is explicitly a definition with closure only over the finite declaration forms enumerated in the chapter. Keep that scope limitation visible; an extension that needs a fourth component invokes the stated revision rule rather than refuting the local definition.

Rejection reproducibility is conditional on a fixed solver configuration and deterministic traversal, search, seed, and resource accounting. The diagnostic is a function of the source *within that configuration*, not independent of all configuration changes. Tests should compare the entire diagnostic, including location and code, across repeated builds.

The MLIR grade-preservation block is explicitly a conjecture. The generic translation-preservation schema only applies after each lowering rule has been shown to map source derivations to target derivations. Track each pass's obligation, grade mapping, target typing rule, and the P1b dependency independently; do not promote the conjecture from the existence of a schema.

Pipeline stabilization follows from a finite descending specialization budget only if every term-changing iteration consumes at least one unit, the budget never increases, and a no-change iteration is recognized as a fixed point. Those operational premises should be stated and tested.

### 10. Polarized recursion and historical context: `thm:terminaison_couche_3`, `thm:productivite_couche_2`, `thm:progression_polarisee`, `thm:loi_historique`, `thm:troncature_comonade`, `thm:fenetre_grade`

The layer-3 termination claim relies on a dependent fold whose index decreases in a well-founded order and on the exclusion of general recursion. Its quantification over `f : μF → A` must be read as the specified terminating fold schema, not an arbitrary function that may diverge.

The layer-2 productivity argument needs more than the equation `ω ⊖ 1 = ω`: an infinite measure can remain unchanged forever. The operational typing discipline must force a productive constructor/yield before recursive unfolding, and each finite observation must be reachable in finite time. This is a substantive guardedness obligation.

The polarized progression schema is useful if it is treated as two instances with different conclusions: finite structural exhaustion for `μ`, finite-time production of each observation for `ν`. It must not imply that productivity is termination or that the two measures share the same well-foundedness argument.

The historical distributive-law block must state the types of `λ`, counit, comultiplication, and composition explicitly. The two coherence diagrams and their preservation under truncation are separate equations. The truncation theorem then makes a broad “for every endofunctor” claim with several indexed maps; its boundary equations for `T`, `δ`, and `λ` require type-checking and a complete rank induction. The standard cofree-comonad facts must be separated from the K7PL-specific claim that truncation preserves the structure. The sketch is on paper and has not been mechanized.

Finally, the identification of coinductive truncation, stack bound, and `StreamContext` size as the same compile-time grade is explicitly not demonstrated. Each concrete representation needs a map to and from the common window and a proof that the bounds coincide.

## Dependency and status conclusions

1. The only direct syntactic cycle currently identified by the dependency checker remains `thm:lemme_fondamental ↔ thm:divulgation_delimitee`. The H1 issue between `thm:introduction_unique` and `thm:surete_spatiale` is argumentative, not a syntactic cycle.
2. The most important unresolved dependency chain is substitution → fundamental lemma → non-interference/disclosure, with translation typing → refinement → simulation/fidelity as a separate chain. Repeated labels in audit batches are cross-references, not additional unique statements.
3. Compound blocks needing split tracking include `thm:introduction_unique`, `thm:elaboration`, `thm:rejeu_binaire` (environment assumptions versus binary conclusion), `thm:preservation_type`, and `thm:troncature_comonade` (standard structure versus K7PL-specific truncation).
4. No status is promoted by this note. The conjectures `thm:determinisme_observationnel` and `thm:abaissement_grades`, the explicit requirements, and the unproved propositions remain distinct.
5. The inventory and batch crosswalk still require a mechanically generated coverage matrix and a fresh source inventory before C8.0 can be considered closed.
