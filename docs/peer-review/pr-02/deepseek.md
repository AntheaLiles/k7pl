HOLISTIC FORMAL PEER REVIEW — K7PL SPECIFICATION

0. Preliminary Assessment

Document: K7PL: KonSept Programming Language — A functional layered programming language
Author: Cyprien PIERRE
Date: 2026-09-09
Length: 285 pages
Status: Technical specification in construction

This document presents a substantial and ambitious programming language design. It is notable for its intellectual honesty—it explicitly distinguishes between what is established, what is under construction, and what remains conjectural. My review will follow the requested methodology: first reconstruct the problem, then systematically identify structural issues, hidden dependencies, concept collisions, and missing factorizations.

---

1. Reconstruction of the Problem

1.1 Scientific Question

What fundamental problem does the document seek to solve?

The document addresses a classic tension in systems programming: performance, safety, and verifiability are typically seen as a trade-off triangle. K7PL's claim is that these three requirements are instances of the same algebraic structure—graded modalities over a resource semiring—and can therefore be expressed as graduations within a single language rather than as a compromise.

Deep architectural problem: How can a single language simultaneously:

· Execute close to hardware (P3: explicit memory regimes, O(1) allocation)
· Guarantee memory safety and absence of data races (P1, P2: linear/affine types)
· Enable formal verification before deployment (graded modal types, refinement system)

Core principle: The judgment Δ ⊢_G t : A | ℰ where:

· Δ: graded context (what the term requires)
· G: grade algebra (usage, monotonicity, confidentiality, budget)
· A: type (what the term is)
· ℰ: effects (what the term produces)

This judgment is specialized into three layers:

· Layer 3: Cartesian (pure, terminating, no effects)
· Layer 2: Affine (productive, controlled effects, streams)
· Layer 1: Linear (strict resources, no duplication or weakening)

Key claimed insight: The three layers are not three languages but one judgment read under three restrictions—the "sedimentation" metaphor.

1.2 Central Object

What is the conceptual "germ" of the system?

The graded context Δ plays this role. It is:

· A finite map from variables to grades
· Where grades are elements of R = (Q≥0 ∪ {ω}, +, ×, 0, 1, ≤)
· Each grade has four components: usage, monotonicity, confidentiality, budget

How many mechanisms are instances of this object?

1. Resource usage: Linear (r=1), Affine (r∈[0,1]), Unrestricted (r=ω)
2. Monotonicity: Discrete vs. monotone functions (component m)
3. Confidentiality: Information flow levels (component ℓ)
4. Budget: Worst-case execution cost (component β)
5. Channel protocols: Encoded as linear implications, not separate primitives
6. CRDTs: Conflict-free replicated data types as graded semilattices
7. Capabilities: Linear write caps, fractional read caps
8. Effect handlers: As catamorphisms over initial algebras
9. Temporal modalities: □ (always), ◇ (eventually), ○ (next step)

Central observation: The document claims—and I will test—that all these mechanisms are instances of a single graded modal type theory. This is the core factorizing insight.

1.3 Architecture of Levels

The document explicitly distinguishes:

Level What it contains
Syntax S-expressions, delimiters { } ( ) [ ]
Judgments Δ ⊢_G t : A \| ℰ
Semantics Category C (SMCC), comonad !_r
Meta-theory Substitution lemma, logical relations, translation
Compilation 8 phases (macro expansion → SMT solving → MLIR → LLVM)
Runtime Fibrilles (stackless), fibres (stackful), arenas, actors
Deployment Physical placement, NUMA, GPU offload

Potential level errors to watch:

· Confusing typability with execution correctness
· Confusing compiler correctness with runtime safety
· Confusing logical replay with bit-identical replay
· Confusing absence of a derivation with a runtime check

---

2. Conceptual Cartography

2.1 Central Notions and Their Dependencies

```
Postulates P1-P4
    ↓
Category C (SMCC)
    ↓
Graded comonad !_r over semiring R
    ↓
Judgment Δ ⊢_G t : A | ℰ
    ↓
Three layer specializations (Lin/Aff/Cart)
    ↓
Type system (grades + value constraints)
    ↓
Automata execution model (R-expressions, actors, streams)
    ↓
Compilation pipeline (8 phases)
    ↓
Runtime (fibrilles, fibres, arenas, replay)
```

2.2 Concept Duplications

Observation 1: Three "termination" criteria

The document presents three termination/productivity criteria:

1. Layer 3: Dependently-typed fold with decreasing index (Theorem 2)
2. Layer 2: Coinductive streams with sized types (Theorem 4)
3. Deductive fixpoint: Finite height types (Theorem 8)

Diagnosis: These are presented as three criteria but share a common structure—each requires a well-founded order:

· Layer 3: N with < (inductive)
· Layer 2: N with < read coinductively
· Deductive: Finite height (no infinite chains)

Factorizing abstraction: A sized type theory where every type carries a size index, and operations either consume (inductive) or produce (coinductive) size units. The document hints at this but does not fully factorize it.

Recommendation: Unify Theorems 2, 4, 5, and 8 under a single "sized progression" theorem.

---

Observation 2: Three "effect" concepts

The document uses "effect" in three distinct ways:

1. Algebraic effects: Operation signatures Σ, handlers as algebras (Section 2.3)
2. Scoped effects: Operations that take computations (Section 3.3, Section E.3.2)
3. Coeffects: What the context requires (Section 1.4)

Diagnosis: These are not distinguished clearly in the main text. The appendix (Section E.3.2) distinguishes them properly with the operator scoped_f(v,c), but this distinction is not visible in the main chapters.

Current formulation:

· ℰ is the effect produced by a computation
· Δ is the graded context (what it requires)
· The interaction is governed by distributive law λ_{r,ε}: !r ∘ T_ε ⇒ T{φ(r,ε)} ∘ !_{ψ(r,ε)}

Issue: This treats algebraic effects and scoped effects uniformly, but scoped effects require a monoïd of transformers ℳ (Section E.3.2). The document's main text does not explain that algebraic effects and scoped effects have different meta-theory.

---

Observation 3: Four "monotonicity" concepts

1. Monotonicity as a grade component (Section 2.4): Functions can be declared monotone via grade m
2. Monotonicity of the fixpoint operator (Theorem 8): fix only terminates if f is monotone
3. Monotonicity of composition/tensor (Section 2.4): C is enriched over preorders
4. Monotonicity of Datalog rules (Section 4.5): Adding facts only derives more facts

Diagnosis: These are four different concepts with one name:

· (1) and (3) are about functions preserving order
· (2) is about the domain having an order
· (4) is about rule bodies being positive

Problem: The text (Section 2.4) claims that "monotonicity is a property declared and verified rather than a proof obligation." But this conflates the function's preservation property with the domain's order structure.

Recommendation: Distinguish:

· Order-preserving functions: f : S →_mon S (grade component)
· Ordered domains: Trellisfin (domain structure)
· Monotone rule sets: Datalog derivation function (meta-property of the program)

---

Observation 4: Multiple "replay" claims

The document distinguishes:

1. Logical replay: Same observable state (Theorem 22)
2. Bit-identical replay: Under reproducible environment (Theorem 23)
3. Stratified replay: Projection of journal by level (Theorem 46)

Diagnosis: These are properly distinguished. The document is explicit that bit-identical replay requires E_repro (environment reproducibility), which is not guaranteed by the language.

Status: This is correct. No duplication problem here.

---

Observation 5: Multiple "substitution" lemmas

The document has:

1. Scheme of commutation (Theorem 11): T · subst = subst · T
2. Substitution lemma (Theorem 41): For Δ, x:rV_i ⊢ c : C | ε(i) and Δ' ⊢ v : V_j
3. Simultaneous substitution (Theorem 42): Closing a term, one binding at a time
4. Meta-substitution (Theorem 30): (Mθ)[σ] = (M[σ])θ for macros

Diagnosis: These are all instances of the same pattern—substitution commuting with structure. They should be presented as instances of a single theorem parameterized by the object (terms, ASTs, macro bodies).

Factorizing abstraction: A general "substitution commutes with construction" theorem:

· For any term construction C[t] and substitution σ, (C[t])[σ] = C[t[σ]]
· Parameterized by: (1) object language, (2) construction rules, (3) binding discipline

Recommendation: Present Theorems 11, 30, 41, 42 as instances of one theorem.

---

3. Conceptual Collisions

3.1 Symbol Overload: ⊗

Sense 1 (Section 2.1): Tensor product in category C, modeling disjoint resources.
Sense 2 (Section 2.4): Tensor product in the graded comonad's contraction, modeling composition of contexts.
Sense 3 (Section 4.2): Tensor product in the judgment, modeling composition of contexts.

Diagnosis: These are related but not identical. The first is a categorical operation; the second is the induced operation on contexts; the third is the syntactic operation in the judgment.

Recommendation: Use different notation for the categorical tensor (⊗_C) and the context composition (⊗_Δ). The document already uses different notations in some places—formalize this.

---

3.2 Symbol Overload: !

Sense 1 (Section 2.2): Graded comonad !_r, the "exponential" of linear logic.
Sense 2 (Section 2.4): The same !_r used for confidentiality levels.
Sense 3 (Section 3.1): The same !_r used in types.

Diagnosis: These are all the same object—the graded comonad. The overloading is legitimate because it is one concept. The document explicitly states that R is a product of four structures (usage, monotonicity, confidentiality, budget), and !_r is parameterized by a grade that combines all four.

Issue: The document previously used □ for the exponential, then switched to !. The text (Section 1.5) says "La ressource porte ! et non □ : c'est le glyphe de l'exponentielle depuis Girard, un lecteur le reconnaît sans l'apprendre." This is correct.

Status: Not a collision—these are the same object.

---

3.3 Symbol Overload: Δ and Γ

Sense 1 (Section 1.4): Δ is the graded context of the judgment.
Sense 2 (Section 2.1): Γ is a generic context in categorical notation.

Diagnosis: The document explicitly distinguishes these:

· Δ: "contexte gradué du jugement K7PL"
· Γ: "contexte catégorique ou métathéorique, jamais une zone du jugement"

Issue: The document (Section 1.4) says "Δω là où l'usage écrirait Γ." This could be confusing to readers familiar with linear logic.

Status: This is a deliberate choice, not a collision. The document acknowledges it.

---

3.4 Confusion: Monoidal vs. Cartesian Product

Issue: The document claims (Section 1.4) that C is a SMCC (not Cartesian), so ⊗ models disjoint resources. But then it uses ⊗ both for resources and for composition of contexts. In a SMCC, ⊗ is associative but not Cartesian—no diagonal or projections.

Problem: The graded comonad !_r provides the Cartesian structure only on objects of the form !_r A. The document is careful about this in Section 2.2, but the distinction is not visible in the main exposition.

Recommendation: Make the distinction explicit in the judgment notation. Use:

· Δ₁ + Δ₂ for context composition (addition of grades)
· A ⊗ B for type-level tensor (resources)
· ⊠_ε for effect-aware context composition

This is already done in the appendix but not in the main text.

---

3.5 Confusion: Set vs. Interval vs. Mode

Issue: The modal intervals [1..1], [0..1], [0..ω], [1..ω] (Table 6) are presented as "modes." But:

· A mode is a triple (grade algebra, contraction ideal, weakening boolean)
· An interval is a subset of R

Diagnosis: The document (Section 3.1) correctly identifies this: "une modalité est un sous-ensemble distingué de cette algèbre, porté par un type." The intervals are subsets, the modes are the triples. But the presentation in Table 6 conflates them.

Recommendation: Table 6 should present the four modes as triples, not as intervals. The intervals are the meaning of the modes in R, not the modes themselves.

---

3.6 Confusion: Type vs. Value vs. Grade

Issue: The document (Section 3.1) says "Un grade est une valeur, une modalité est un domaine de valeurs." But then:

· Types like Vec n T have n as a grade (value at type level)
· Grades are elements of R (values at the judgment level)
· Modes are sets of grades (domains of values)

Diagnosis: This is correctly distinguished when the document is precise. But the notation doesn't reflect the distinction clearly.

Recommendation: Use explicit notation:

· Grade: r ∈ R (value)
· Mode: M ⊆ R (set of grades)
· Type: A (object of C)
· Value: v (term)

The document already does this in the appendix. Main text should be consistent.

---

4. Level Errors

4.1 Level Error: Compilation vs. Execution

Issue (Section 1.3): "Reste à dire quel statut donner aux échappatoires que cette borne inférieure exige." The document discusses compile-time vs. runtime division (Phase 8 erasure). But:

Problem: Phase 8 erases "everything that belongs to compilation," but this distinction relies on a modal necessity (code under □ is compile-time available). The document (Section 1.4) acknowledges this but doesn't formalize it.

Level confusion: The document uses "compile-time" both as a phase (Phase 0 macros) and as a modal property (non-interference). These are different levels.

Recommendation: Formalize the compile-time/runtime distinction as a modal type, not as a phase. The document already mentions this approach (Section 1.4: "c'est une modalité de nécessité") but doesn't implement it.

---

4.2 Level Error: Logical Replay vs. Bit-identical Replay

Issue (Theorem 22 vs. Theorem 23): The document distinguishes logical replay (observable equality) from bit-identical replay (under E_repro). This is correctly distinguished.

Problem: The text (Section 4.5) says "le rejeu logique — même journal, même suite d'états observables — est ce que P4 garantit." But P4 says "toute exécution distribuée de K7PL est rejouable." The document later adds "Le rejeu est logique par construction — il rend le même état à l'observation près —, et binaire sous la seule hypothèse d'un environnement reproductible."

Level distinction: The first claim is a language property (P4 guarantees replay). The second is an environment property (E_repro enables bit-identical replay). These are correctly distinguished.

Status: No level error here.

---

4.3 Level Error: Static Bounds vs. Dynamic Measurement

Issue (Section 1.4): "Ce que l'appareil établit est une correction : le coût reste sous la borne, et la borne sous le budget."

Level distinction:

· Budget: static declaration (in the grade)
· Synthesized bound: static inference (from the type system)
· Actual cost: dynamic measurement (at runtime)

Problem: The document says "la bornes synthétisée" is what the type system calculates. But the type system calculates a static bound, not a dynamic measurement. The correction theorem (Theorem 43) says the actual cost stays under the bound.

Recommendation: The document already distinguishes these correctly. No change needed.

---

4.4 Level Error: Local Atomicity vs. Global Compositionality

Issue (Theorems 25 and Section 4.5): The document claims atomicity for join patterns: "L'acteur réagit par P si et seulement si des messages pour x et y sont simultanément présents." This is local atomicity (a single transition).

Problem: The document (Section 4.5) acknowledges that global compositionality (preserving correctness when objects are composed) is a separate property. It says "L'énoncé est local : il porte sur une jonction prise isolément. La propriété dont l'architecture a besoin est distincte et ne s'en déduit pas."

Level distinction: Local atomicity (single transition) ≠ global compositionality (composition of correct components).

Status: The document correctly distinguishes these. No level error.

---

5. Proof Level Analysis

5.1 Missing Proof: Abaissement preserves graded judgment

Location: Section 6.1, Theorem 36

Current statement: "Si Δ ⊢ c : C | ε et si ⟦c⟧ est l'image de c par l'abaissement vers MLIR, alors il existe des traductions ⟦Δ⟧, ⟦C⟧ et ⟦ε⟧ telles que ⟦Δ⟧ ⊢ ⟦c⟧ : ⟦C⟧ | ⟦ε⟧."

Problem: The document admits (Section 6.1, Page 206) "Ce théorème n'est pas démontré." It claims "La littérature fournit la forme de la règle que cet énoncé devra porter" but "la version quantitative est présentée comme une conjecture."

Diagnosis: This is a blocking defect (A): the graded preservation through lowering is essential for the claimed end-to-end guarantee. Without it, P1's claim that "toute optimisation admise du compilateur est accompagnée d'un morphisme de correction sémantique dans C" is not established.

What remains valid: The ungraded preservation (Theorem 19) is valid. The graded preservation by evaluation (Theorem 43) is valid. What's missing is the graded preservation by compilation.

Required: Either prove Theorem 36 or restrict the claim to ungraded properties that survive lowering.

---

5.2 Missing Proof: Non-interference for session fragment

Location: Section 2.5, Theorem 10; Appendix E.4.3

Current statement: "Pour tout niveau ℓ∈L et toutes dérivations d1,d2 de même image sous [·]ℓ, les termes sous-jacents sont observationnellement équivalents pour un observateur de niveau ℓ."

Problem: The document (Appendix E.4.4) admits: "La non-interférence graduée est démontrée pour le fragment sans communication, temps compris — et elle attend, pour le fragment avec canaux, un objet unique partagé avec la preuve de traduction."

Diagnosis: This is a proof debt (D). The framework exists (logical relation with sorted names), but the proof is not complete.

What remains valid: The non-interference for the communication-free fragment (with timing channels included) is established. This is already more than many systems do.

Required: Complete the session fragment proof using the sorting system defined in Appendix E.5.

---

5.3 Missing Proof: Delimited release theorem

Location: Section 2.4, Theorem 7; Appendix E.4.5

Current statement: The theorem states that "une échappatoire ne libère que ce qu'elle nomme" — quantified over programs with declassifications over X, if states agree on what the ℓ-level observer sees and on the value of each expression in X, then executions are indistinguishable at level ℓ.

Problem: The proof (Appendix E.4.5) is sketched but not fully conducted. The document identifies a subtle issue: "le lemme de substitution en révèle un contournement que la règle n'exclut pas. Substituer dans un terme donne declassify_{ℓ'}(e)[v/x] = declassify_{ℓ'}(e[v/x]), et rien ne garantit que e[v/x] appartienne encore à X."

Diagnosis: This is a proof debt (D). The solution is identified: X must be a set of closed expressions. The document says "C'est la lecture que retient la littérature dont l'énoncé est repris" but the proof is not fully conducted.

What remains valid: The framework is sound. The issue is identified and has a known solution.

Required: Conduct the proof with the closedness condition explicitly stated.

---

5.4 Missing Proof: Graded distributive law

Location: Section 1.4, Table 2; Appendix E.3

Current statement: "φ dit comment l'effet est modifié lorsqu'on le fait passer derrière la demande; ψ, comment la demande l'est lorsqu'on la fait passer devant l'effet."

Problem: The laws governing φ and ψ are stated (Table 2) but the distributive law itself—the transformation λ_{r,ε}: !r ∘ T_ε ⇒ T{φ(r,ε)} ∘ !_{ψ(r,ε)}—is not fully specified. Appendix E.3.3 says "Ces deux règles ne sont pas écrites."

Diagnosis: This is a structural defect (B): the interaction between coeffects and effects is central to the system's claim of unifying performance, safety, and verifiability. Without the distributive law, the judgment's components are not really integrated.

What remains valid: The individual components (graded comonad for coeffects, graded monad for effects) are well-defined. The composition rule (LET and APP in Appendix E.3) assumes the law but doesn't state it.

Required: Write the distributive law rules explicitly and verify they satisfy the coherence conditions.

---

5.5 Missing Proof: Indexed graded effects

Location: Section 1.4; Appendix E.3.4

Current statement: "La gradation indexée qu'exigent les effets dépendant de valeurs" is listed as "Nommé, non posé" in Section 1.1.

Problem: The document admits this is not yet defined. The requirements are:

· Vec n T: the effect of iterating depends on n
· The grade of an effect can depend on an index

Diagnosis: This is a structural defect (B): the system claims to have "graded modal dependent types" but the dependency of grades on values (not just types) is not formalized.

What remains valid: The simple graded type system (where grades are constants) is formalized. The indexed extension is identified and scoped.

Required: Define the indexed graded monad framework and prove the substitution lemma for it (Theorem 41 already provides the form).

---

5.6 Over-strong Claim: "La condition de clôture est suffisante"

Location: Section 1.4

Current statement: "Cette condition n'est pas une simple discipline de conception : c'est le critère de cohérence auquel une extension se vérifie."

Problem: The document explicitly walks this back: "Cette condition est suffisante sous une condition, et il n'est pas nécessaire ; l'énoncer comme une équivalence, ainsi que ce document l'a longtemps fait, promettait plus qu'il ne tient."

Diagnosis: This is a scope defect (C): the closure condition is sufficient for extensions that fit the three strata (coeffect, effect, refinement) but not necessary. The counterexample given is a probabilistic extension.

What remains valid: The condition is useful and sufficient for most intended extensions.

Required: State the condition as sufficient, not necessary.

---

5.7 Over-strong Claim: "Absence de course à la donnée garantie par le type"

Location: Section 4.4, Theorem 21

Current statement: "Deux accès concurrents n'ont pas de dérivation" — the document claims that data races are made inexpressible rather than detected.

Problem: The theorem assumes contexts are disjoint (Δ₁ ⊗ Δ₂). But as the document notes in RMQ 27: "La preuve suppose les deux contextes disjoints, ce que Γ₁⊗Γ₂ écrit mais ne garantit pas par lui-même dès que les fragments s'imbriquent. La couche 3 admet la contraction ; si une valeur cartésienne pouvait capturer une capacité linéaire, la duplication licite en couche 3 dupliquerait une ressource qui ne doit pas l'être, et l'énoncé tomberait."

Diagnosis: The theorem holds under the nesting discipline of delimiters (Section 5.1): only { ... ( ... [ ... ] ... ) ... } is allowed. This prevents Cartesian values from capturing linear capabilities.

What remains valid: Under the stated nesting discipline, the theorem holds. The document (Section 4.4) correctly identifies the condition.

Required: The dependency should be explicit in the theorem statement.

---

5.8 Over-strong Claim: "Aucun coût n'est dissimulé"

Location: Section 1.3, P3

Current statement: "Aucune abstraction de K7PL ne dissimule un coût mémoire."

Problem: The document admits (Section 1.3) that "l'amortissement" is allowed in layer 2 (heap with ownership), where an amortized bound is a promise about averages, not a worst-case bound. P3 is interpreted as: "la borne que les règles synthétisent est celle de son pire cas et non celle de son coût moyen."

Diagnosis: This is a scope defect (C): P3 applies to worst-case bounds. Amortized bounds are allowed only when explicitly annotated. The document (Section 1.3) says "Si l'annotation d'effet portait l'amorti, la borne synthétisée serait franchie par un pic, et la propriété de préservation deviendrait fausse."

What remains valid: The principle of not hiding costs is preserved—amortized costs must be identified as such.

Required: The amortized case needs a formal account in the type system. The document mentions this but doesn't provide it.

---

6. Missing Factorizations

6.1 Four Termination Criteria → One Sized Type Theory

Current state: Three termination criteria (fold, coinductive stream, deductive fixpoint) + one progress theorem. They are partially unified in Theorem 5 (progression parameterized by layer).

Missing factorization: A single sized type system where:

· All types carry size indices
· Structural recursion consumes size
· Coinduction produces size
· Finite height is a special case (size bounded)

Benefit: The three termination/productivity proofs become instances of one theorem.

---

6.2 Multiple Resource Disciplines → Graded Modal Logic

Current state: Linear, affine, unrestricted, relevant (Rel) as four modes.

Missing factorization: The modes are already identified as intervals in R. But the morphism of modes framework (Section 3.1, Hanukaev & Eades) should be the primary presentation, with modes derived from intervals rather than presented as a table.

Benefit: If a fourth mode is needed, it's just another interval. The table (Table 6) already shows this.

---

6.3 Multiple Effect Handling Schemes → One Catamorphism Pattern

Current state:

· Algebraic effects: handled as catamorphisms over initial algebras (Section 2.3)
· Scoped effects: handled via monoïd of transformers ℳ (Section E.3.2)
· Effect handlers: compiled via capability-passing style (Section 6.1)

Missing factorization: These are three different mechanisms. The document (Section 2.3) correctly identifies algebraic effects as catamorphisms. Scoped effects require a different treatment (the monoïd of transformers). The document admits this is "une réserve de modularité."

Recommendation: Keep them distinguished. They are not instances of the same abstraction.

---

6.4 Four Monotonicity Concepts → One Order-Preserving Framework

Current state:

1. Grade component m (function-level monotonicity)
2. Domain Trellisfin (fixpoint domain)
3. Enriched category (compositional monotonicity)
4. Datalog rules (derivation monotonicity)

Missing factorization: A general theory of monotone structures where:

· A monotone type is a type equipped with an order
· A monotone function preserves that order
· The fixpoint operator is defined on monotone types
· Datalog rules are compiled to monotone functions

Benefit: The connection between grade-m and the fixpoint operator becomes explicit.

---

6.5 Multiple "Substitution Lemmas" → One Substitution Theorem

Current state:

1. Term substitution (Theorem 41)
2. Simultaneous substitution (Theorem 42)
3. Macro metavariable substitution (Theorem 30)
4. Translation commutation (Theorem 48)

Missing factorization: A general substitution theorem for all objects:

· For any term construction C[t] and substitution σ
· (C[t])[σ] = C[t[σ]]
· Parameterized by: object language, binding discipline, capture avoidance

Benefit: All four lemmas become instances, reducing proof duplication.

---

6.6 Multiple "Replay" Properties → One Observational Equivalence Framework

Current state:

1. Logical replay (Theorem 22)
2. Bit-identical replay (Theorem 23)
3. Stratified replay (Theorem 46)

Missing factorization: The three are already connected by the logical relation and projection π_ℓ. The factorization is actually present in the appendix (Section E.4.2). The main text could make this clearer.

Benefit: The relationship between P4 and confidentiality becomes explicit.

---

7. Orthogonal Factors

7.1 Usage × Value

Claim: Orthogonality P2: usage (Lin/Aff/Unr) is independent of value constraints.

Verification: The document (Section 3.1) explains this carefully. The condition is "les variables qui n'interviennent que dans la formation d'une contrainte de valeur portent un grade nul." This ensures that value constraints don't affect resource tracking.

Status: Verified. This is a core design decision.

---

7.2 Type × Effect × Coeffect

Claim: The judgment has three components: Δ (coeffect), A (type), ℰ (effect).

Verification: The document (Section 1.4) argues this is complete: "toute extension future du langage doit se projeter sur ces trois composantes." The counterexample is probabilistic effects, which would require a fourth component.

Status: The document acknowledges the limitation. The three components are sufficient for the intended domain, not universally complete.

---

7.3 Compile-time × Runtime

Claim: Phase 8 erases all compile-time artifacts.

Verification: The document (Section 1.4) distinguishes these but doesn't fully formalize the modal necessity. The connection to non-interference is made (Section 2.5).

Status: The distinction is present but not fully formalized. The appendix mentions a "modalité de nécessité" approach but doesn't implement it.

---

8. Over-Strong Equivalences

8.1 "Exactement" in the Closure Condition

Location: Section 1.4

Statement: "Cette condition n'est pas une simple discipline de conception : c'est le critère de cohérence auquel une extension se vérifie."

Problem: The document walks this back: "Cette condition est suffisante sous une condition, et il n'est pas nécessaire ; l'énoncer comme une équivalence, ainsi que ce document l'a longtemps fait, promettait plus qu'il ne tient."

Status: The document acknowledges the over-statement.

---

8.2 "Automatiquement" in Cost Analysis

Location: Section 1.4, Section 3.1

Statement: The document claims that "l'annotation de potentiel" is not needed for most bounds because the solver can infer them.

Problem: The document (Section 6.2) acknowledges: "Les techniques d'analyse de ressource automatisées sont restreintes à des familles de bornes relativement contraintes, tandis que les techniques plus expressives reposent sur des preuves écrites à la main."

Status: The document provides a nuanced view—automation is possible for some families, annotations are needed for others.

---

8.3 "Gratuitement" in Zero-Copy Transfer

Location: Section 4.3, Theorem 20

Statement: "Le transfert d'un pointeur y dispense de toute copie."

Problem: This only holds for primitive types. For structures, "Arrow décompose la donnée en un tampon par champ tandis que Cap'n Proto impose une liste composite" — the transfer requires transposition in O(n).

Status: The document correctly identifies the limitation. "Zero-copy" is not a global property.

---

9. Inter-Chapter Consistency

9.1 Notation Changes

Issue: The document uses both ! and □ in different places for the graded comonad. Section 1.5 acknowledges this: "Ce document a longtemps écrit les deux pour le même objet ... ce qui était le vrai défaut, l'un ou l'autre valant mieux que les deux."

Status: Fixed in the current version.

---

9.2 Grade Components: Four vs. More

Issue: Section 1.4 says "Le grade porte aujourd'hui quatre composantes" but then says "une composante nouvelle n'est donc pas une entorse à justifier, mais l'usage normal d'un objet ouvert."

Consistency: This is consistent—the four components are the current state, not a fixed limit. The condition for adding new components is specified.

---

9.3 Effect of Tick: ℕ∞ vs. ℕ^ℒ_∞

Issue: Section 1.4 says the component of time is a "tick" counted. Appendix E.1 changes this: "Un facteur temporel réduit à un ℕ∞ nu ne peut pas porter cela : il compte des pas sans dire à quel niveau ils ont été faits. C'est donc une famille κ ∈ ℕ^ℒ_∞."

Consistency: This is a refinement, not a contradiction. The main text's simpler presentation is for clarity; the appendix gives the full formal detail.

---

9.4 Metatheory: CBPV vs. λ-calcul

Issue: Section 1.4 says K7PL uses "appel par poussée de valeur." Section 3.3 says "le vérificateur est bidirectionnel, non principal." Appendix E.3 uses CBPV style.

Consistency: The system is consistently presented in CBPV style throughout. The main text's type system rules are simpler; the appendix gives the formal CBPV rules.

---

10. Compilation as Proof Chain

10.1 The Pipeline

Phases:

1. Phase 0: Macro expansion (in sandbox)
2. Phase 1: Parsing and desugaring
3. Phase 1.5: Acyclicity checking (intercalary)
4. Phase 2: Type inference and unification (bidirectional)
5. Phase 2.5: Elaboration (intercalary)
6. Phase 3: Effect checking
7. Phase 4: Termination/productivity checking
8. Phase 5: SMT solving for value constraints
9. Phase 6: Optimization (inlining, deforestation, defunctionalization)
10. Phase 7: Lowering to MLIR/LLVM
11. Phase 8: Erasure of compile-time artifacts

10.2 Invariants Preserved

· Typability: Preserved by all phases (claimed)
· Grade bounds: Preserved by all phases (claimed)
· Effect soundness: Preserved by Phases 3-5 (claimed)
· Termination/productivity: Preserved by Phase 4 (claimed)

10.3 Invariants Potentially Lost

· Graded correctness through lowering: NOT established (Theorem 36 is conjectural)
· Bit-identical replay: Depends on E_repro (environment property)

10.4 Hidden Loop

Issue: Phase 6 (optimization) can generate new grade constraints that Phase 5 already checked. The document notes this (Section 6.1): "Le pipeline suppose ici une dépendance à sens unique qui n'est pas établie." The solution is to iterate (Theorem 33).

Status: The document acknowledges the loop and provides a termination argument.

---

11. Semantic vs. Implementation Properties

11.1 Language Properties

· Typability (static)
· Safety (no data races, no use-after-free) — static
· Termination (Layer 3) — static
· Productivity (Layer 2) — static
· Determinism (P4) — language property (logical replay)
· Confidentiality — static (grades)

11.2 Implementation Properties

· Bit-identical replay — depends on E_repro (not language property)
· Performance (WCET) — depends on hardware profile
· Compiler performance — bounded by a grade but not a language property
· SMT solving time — depends on solver configuration

11.3 Environment Properties

· E_repro: reproducible order, rounding, compiler version
· Hardware profile: cache hierarchy, core count
· Network behavior: latency, partition

Status: The document generally distinguishes these correctly.

---

12. Literature Use

12.1 Proper Use

· Graded modal types: Granule, Orchard et al. — correctly cited
· Session types as linear logic: Toninho & Yoshida — correctly cited
· Call-by-push-value: Levy, Torczon et al. — correctly cited
· Containers: Altenkirch & Morris — correctly cited
· Coinductive types: Abel & Pientka — correctly cited

12.2 Extrapolations

Issue: The document claims the "forme de preuve" from the literature but not the "résultat lui-même" in several places:

· Theorem 7 (delimited release): follows Sabelfeld & Myers but not fully proved for K7PL
· Theorem 10 (non-interference): follows Algehed & Bernardy but not fully proved for sessions
· Theorem 36 (lowering preservation): follows Huang's QTAL but as a conjecture

Status: The document is honest about what it has established vs. what it borrows. Section 1.1 distinguishes "Arrêté," "Construit," and "Nommé."

---

13. Devil's Advocate Objections

Objection 1: "Cette factorisation n'est-elle qu'une analogie?"

Objection: The document claims that layers 1, 2, 3 are "one judgment read under three restrictions." But the restrictions are structural (rules allowed) and semantic (effects). Are they really one system?

Response: The appendix (Section E.3) shows the rules are indeed specializations of a single judgment. The three layers differ only in which rules are allowed (Δ = ∅ vs. Δ_aff vs. Δ_lin). This is a genuine factorization, not an analogy.

Verdict: Objection rebutted.

---

Objection 2: "Cette catégorie existe-t-elle réellement avec les opérations définies?"

Objection: The document assumes C exists as a SMCC with a graded comonad satisfying the laws. But the construction of such a C for K7PL's types is not given.

Response: The document (Section 2.2) says "Cω est donc cartésienne" and refers to the literature (Benton, Bierman, Schalk). The category is standard. The graded extension is from Fukihara & Katsumata.

Verdict: The category exists in the literature. The document is building on established work.

---

Objection 3: "Cette propriété n'est-elle seulement vraie dans le cas discret?"

Objection: The termination/productivity proofs (Theorems 2, 4, 5) assume a discrete well-founded order (N∞). What about continuous domains?

Response: The document limits itself to discrete types: "Tout indice de taille est pris dans N∞ \ {ω}" (Section 2.3). Continuous domains are not supported.

Verdict: The property is true for the intended domain. The document acknowledges the limitation.

---

Objection 4: "Ce résultat ne repose-t-il pas sur une hypothèse absente?"

Objection: The graded modal type system relies on the semiring R being "residuated" for the budget component (subtraction). But the document (Section 2.2) says "La structure requise pour cette composante est donc un monoïde commutatif naturellement ordonné et résidué, dont la part semi-anneau n'est qu'un fragment."

Response: The document explicitly states the requirement: R must be residuated. This is not absent—it's specified.

Verdict: Objection rebutted.

---

Objection 5: "Cette optimisation préserve-t-elle le comportement ou seulement le typage?"

Objection: Theorem 19 (preservation of type) only says typability is preserved. Does it say behavior is preserved?

Response: The document distinguishes: Theorem 19 is about type preservation. Behavioral preservation is a separate property, stated in P1: "toute optimisation admise du compilateur est accompagnée d'un morphisme de correction sémantique dans C."

Verdict: The document distinguishes the two. The issue is whether the morphism is proved (see Objection 1 on Theorem 36).

---

Objection 6: "Cette représentation est-elle réellement sans copie?"

Objection: The document claims "zero-copy" for transfers between layers (Theorem 20). But the theorem explicitly states this only holds for primitive types. For structures, transposition is required.

Response: The document correctly limits the claim. "Zero-copy" is not a global property.

Verdict: The objection is anticipated and addressed.

---

Objection 7: "La garantie statique survit-elle à la frontière FFI?"

Objection: The document (Section 4.5) admits that code leaving through FFI escapes the type system. The theorem only guarantees that the caller loses access, not that the callee doesn't retain it.

Response: The document (Theorem 26) states: "Au retour, la passerelle restitue la capacité à l'acteur." But this is a constraint on the FFI implementation, not a language property.

Verdict: This is a genuine limitation. The document acknowledges it (Section 4.5: "le destructeur d'une capacité exportée devrait en émettre une, faute de quoi P3 cesse de valoir au-delà de la frontière").

---

Objection 8: "Le graphe statique contrôle-t-il réellement toutes les dépendances dynamiques?"

Objection: The document (Theorem 17) claims absence of deadlock from acyclicity of the static dependency graph. But the runtime wait graph is dynamic.

Response: The document correctly identifies this distinction (Section 3.2, RMQ 23): "Deux graphes sont en jeu, et les confondre serait l'erreur à ne pas commettre. Le graphe de câblage du §4.3 est donné en entier à la compilation ... Le graphe d'attente à l'exécution se déplie au fil des activations."

Verdict: The document acknowledges the limitation. The theorem applies to the static graph, which is a sufficient condition but not necessary.

---

14. Root Causes of Problems

Root Cause 1: The Document is in Progress

Symptom: Many "missing" items are explicitly identified as such in Section 1.1 ("Arrêté," "Construit," "Nommé"). The document is honest about its state.

Recommendation: This is not a defect—it's a feature. The document should continue to maintain this honesty.

Root Cause 2: Multiple Unifications Claimed but Not Fully Implemented

Symptom: The document claims several factorizations that are partial:

· Three termination criteria → one sized type theory (partial)
· Multiple resource disciplines → graded modal logic (well done)
· Effect handling schemes → catamorphism pattern (partial for scoped effects)

Recommendation: For each claimed unification, either:

1. Complete the formalization (for sized types, scoped effects)
2. Acknowledge the limitation (as done for scoped effects)

Root Cause 3: The Formal Appendix is a Late Addition

Symptom: The appendix (Section E) contains many definitions and proofs that the main text assumes. The main text refers to the appendix for "preuves ouvertes" but the formalization is not integrated.

Recommendation: The appendix should be integrated into the main text or clearly identified as the formal foundation.

Root Cause 4: The Type System is Not Fully Written

Symptom: The document (Section 1.1) lists "le jeu de règles de typage lui-même, dont l'absence est ce qui suspend les quatre preuves ouvertes" as "Nommé, non posé."

Recommendation: The type system rules should be written in the main text, not only in the appendix.

---

15. Minimal Corrections

15.1 Clarification: Theorem 36 is Conjectural

Current: The theorem is stated as if established.

Correction: Restate as a conjecture or proof obligation. The document already acknowledges it's not proved (Section 6.1). This should be reflected in the theorem statement.

15.2 Clarification: Closure Condition is Sufficient, Not Necessary

Current: "Cette condition n'est pas une simple discipline de conception : c'est le critère de cohérence auquel une extension se vérifie."

Correction: "Cette condition est suffisante, non nécessaire. Une extension peut satisfaire les postulats sans s'y ranger, mais nécessite alors une révision de l'axiome."

15.3 Clarification: Zero-copy is Limited to Primitives

Current: Theorem 20 claims zero-copy transfer.

Correction: The theorem already states the limitation. The main text should emphasize it.

15.4 Clarification: P3 and Amortized Costs

Current: P3 says "aucune abstraction ne dissimule un coût mémoire."

Correction: The document already clarifies that amortized costs are allowed when explicitly annotated. This should be in P3's statement.

15.5 Restriction: Macros Cannot Access the World

Current: The document (Section 5.4) says macros are in sandbox.

Correction: This is already stated: "une macro ne peut ni lire un fichier, ni interroger le réseau, ni consulter l'horloge." This is a genuine restriction and should be emphasized.

---

16. Global Verdict

Architecture

The architecture is ambitious and coherently designed. The central insight—that three conflicting requirements (performance, safety, verifiability) are instances of graded modal types—is well-supported. The three-layer sedimented architecture (Lin/Aff/Cart) is elegant and theoretically grounded.

Rating: Strong

Coherence

The document is internally coherent. The main concepts are well-defined and consistently used. The appendix formalizes the main text. The document is honest about what is established vs. what is conjectural.

Rating: Strong

Solidité des preuves

The proofs are well-structured for the established parts. The substitution lemma, preservation, and progress are proven. The non-interference and delimited release proofs are sketched but not complete for the session fragment. The lowering preservation (Theorem 36) is a conjecture.

Rating: Moderate (Strong for established parts, Weak for conjectural parts)

Factorisation

The document identifies and partially implements several factorizations:

· Three termination criteria → sized types (partial)
· Resource disciplines → graded modal logic (good)
· Effect handling → catamorphisms (partial for scoped effects)
· Multiple replays → logical relation with projections (good)

Rating: Moderate

Mécanisabilité

The document is designed for mechanization: finite rule sets, decidable SMT fragments, explicit grades. The formal appendix provides the necessary definitions. The main gaps are:

· Lowering preservation (conjectural)
· Complete type system rules (not fully written)
· Scoped effects monoïd (written in appendix)

Rating: Moderate

---

Summary

This document presents a substantial and well-constructed programming language specification. Its central contribution—the graded modal type system unifying performance, safety, and verifiability—is theoretically sound and elegantly presented. The three-layer sedimented architecture provides a practical path from high-level verification to low-level execution.

Critical issues to address:

1. Theorem 36 (lowering preservation): This is a conjecture, not a theorem. Either prove it or restrict the claim.
2. Non-interference for sessions: The proof is sketched but not complete. The sorting system (Appendix E.5) provides the framework.
3. Delimited release: The substitution issue needs to be resolved with the closedness condition.
4. Distributive law: The φ and ψ laws need explicit rules and proof of coherence.
5. Indexed graded effects: The dependency of grades on values needs formalization.
6. Type system rules: Should be written in the main text.

Strengths:

1. Honest catalog of what's established vs. conjectural
2. Coherent architectural vision
3. Well-grounded in the literature
4. Extensive formal appendix
5. Clear distinction between language properties, implementation properties, and environment properties

Overall assessment: The document is a strong specification of a research language. The core ideas are sound and well-presented. The main challenge is completing the formal proofs for the most ambitious claims (lowering preservation, non-interference for sessions). The document's honesty about its state is a significant strength.

Rating:

\boxed{
\text{Architecture: A} \;|\;
\text{Cohérence: A-} \;|\;
\text{Solidité des preuves: B+} \;|\;
\text{Factorisation: B+} \;|\;
\text{Mécanisabilité: B}
}
