<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Lean statement-command taxonomy and proof-bearing exposition plan

**Status:** PLANNED — C8  
**Scope:** specification source in `spec/`, Verso extensions in `tools/SpecExt/`, statement inventories and controls  
**Purpose:** make the mathematical and epistemic nature of specification statements explicit while reducing explanatory prose that merely labels or repeats that nature

## 1. Epistemic problem

The current specification source is written in Lean files, but the constructs being discussed here are not Lean propositions or Lean declarations directly. They are Verso/SpecExt directives embedded in Lean source files. The distinction matters: changing a directive changes the document representation and its validation model; it does not by itself change the mathematical content.

The current `::::thm` extension uses a single `status` field for heterogeneous categories: theorem, proposition, conjecture, definition, requirement, and literature result. It also attaches a proof-sketch slot to that common block. This representation is serviceable for rendering but does not distinguish:

- what introduces vocabulary;
- what is assumed;
- what is asserted as a mathematical result;
- what is a local premise;
- what is required by the project;
- what is imported from the literature;
- what is merely illustrative;
- what constitutes evidence for a result.

The scientific problem is therefore not primarily syntactic. It is a classification problem: the document currently encodes several distinct epistemic roles through one overloaded command.

## 2. Design principle

The taxonomy must separate four dimensions that are currently conflated.

| Dimension | Question | Examples |
|---|---|---|
| Object kind | What is this block? | definition, assumption, result, requirement, example |
| Logical role | What role does it play? | axiom, postulate, hypothesis, theorem, lemma, corollary, proposition, conjecture |
| Evidence | What supports it? | proof, proof sketch, literature source, computation, counterexample |
| Scope | Where does it govern? | local hypothesis, chapter-level assumption, normative specification, representation profile |

The command vocabulary should expose these distinctions directly. A command must not imply a stronger epistemic status than the source warrants.

## 3. Preliminary ontology to ratify

This is a working ontology, not yet a normative decision.

### Definitions

A definition introduces or fixes the meaning of a symbol, object, relation, or construction. It is not a theorem and does not require a proof slot. Its validity is controlled by well-formedness, consistency with prior definitions, and scope.

Candidate command: `::::definition`.

### Assumptions

An assumption is accepted as a premise rather than established by the specification.

The first distinction to test is:

- axiom: a foundational mathematical assumption of the formal system;
- postulate: an authorial or architectural commitment adopted as a starting point;
- hypothesis: a premise local to a result or argument.

These terms are often treated as synonyms in the literature. K7PL must not invent a distinction merely to obtain more labels. The plan therefore requires a literature check and an authorial ratification before separate normative semantics are assigned.

Candidate commands: `::::axiom`, `::::postulate`, with hypotheses preferably represented as a structured premise of the result they qualify rather than as globally numbered statements.

### Results

A result is a statement intended to be established by the project or explicitly presented as a claim whose status is not yet established.

The following roles should be distinguished by use, not by truth strength:

- theorem: major established result;
- lemma: established result introduced primarily as a dependency;
- corollary: established result derived directly from one or more established results;
- proposition: established result whose role is not theorem-level in the exposition;
- conjecture: result not established and explicitly presented as such.

A proposition is not mathematically less true than a theorem. The distinction is rhetorical and structural unless the project explicitly defines a stronger convention.

Candidate commands: `::::theorem`, `::::lemma`, `::::corollary`, `::::proposition`, `::::conjecture`.

### Requirements

A requirement expresses something the language, formalisation, implementation, or assurance case must satisfy. It is not a theorem and must not receive a proof-sketch slot merely because it is numbered.

Candidate command: `::::requirement`.

### Literature results

A literature result records a result attributed to an external source. Its provenance is part of its semantics as a documentary object. It must not be silently reclassified as an established K7PL result.

Candidate command: `::::literature`.

### Examples and counterexamples

Examples instantiate a definition or result; counterexamples delimit a claim or motivate a restriction. Neither is automatically normative.

Candidate commands: `::::example` and `::::counterexample`.

### Proof and proof sketch

A proof is evidence intended to establish a result. A proof sketch is an explicitly incomplete or compressed proof argument.

They are not numbered statements. They should be slots or child blocks attached to a result, with validation rules depending on the parent kind.

Candidate blocks: `:::proof` and `:::proofsketch`.

The existing `:::proofsketch` should therefore be retained as a compatibility concept but separated from the theorem-status vocabulary. A full `proof` slot must not be conflated with a proof sketch.

## 4. Why this should reduce prose

The intended gain is not typographical. It is a reduction in redundant metatext.

For example, once a block is explicitly a definition, the surrounding prose should not need to say that it “defines” the object. Once a block is explicitly a corollary, the prose need not announce that it “follows from” a previous theorem when the dependency can be encoded and rendered. Once a result has a proof slot, a paragraph whose sole purpose is to say that the result is proved can disappear.

This does not license removal of explanatory prose carrying assumptions, interpretation, scope, limitations, or scientific motivation. Those remain necessary because they contain information not recoverable from the command taxonomy.

The criterion is therefore:

> Remove prose only when its information is represented losslessly by a structured statement kind, relation, or evidence block.

## 5. Migration architecture

The current `::::thm` should not be removed first. Migration must proceed in layers.

### C8.0 — Inventory

Build a complete inventory of all current statement blocks and classify each occurrence independently.

Required fields:

`label → current status → proposed kind → proposed role → level → proof/evidence → dependencies → normative effect`.

No source text is rewritten at this stage.

### C8.1 — Ontology validation

Test the preliminary categories against:

- current specification usage;
- the project method and assurance vocabulary;
- relevant mathematical writing conventions;
- existing open-statement controls;
- the distinction between normative commitments and external evidence.

The output is a ratified taxonomy, not merely a list of command names.

### C8.2 — Extension refactoring

Refactor `tools/SpecExt/Theorem.lean` into a representation that can encode the ratified taxonomy.

The preferred architecture is one internal statement representation with validated variants rather than a copy-pasted renderer for every command. Surface commands may remain distinct for authoring clarity while sharing the same internal representation and rendering infrastructure.

The internal representation should validate at least:

- admissible metadata by kind;
- whether a label is required;
- whether numbering is applicable;
- whether a proof or proof sketch is permitted;
- whether a level is meaningful;
- whether provenance is required;
- whether the block is normative, evidential, or expository.

### C8.3 — Inventory and controls

Update `scripts/manuscript_metrics.py`, `scripts/controles/notation.py`, and related coverage tooling so that the taxonomy is structural rather than inferred from the old `status` string.

Controls should reject at least:

- theorem/result blocks without the required evidence policy;
- definitions carrying theorem-only proof metadata;
- requirements carrying theorem proof sketches;
- hypotheses promoted to global normative claims;
- literature results without provenance;
- duplicate or conflicting labels;
- conjectures described downstream as established;
- proof blocks detached from an eligible parent.

### C8.4 — Controlled migration

Migrate the existing statements without changing their mathematical content.

For each migrated block:

1. preserve its label;
2. preserve its numbering unless a deliberate renumbering decision is made;
3. preserve its text;
4. preserve its current epistemic status;
5. assign the new kind/role;
6. move evidence into the appropriate proof/proof-sketch structure;
7. record ambiguous classifications rather than guessing.

The migration must be reversible until the complete inventory passes validation.

### C8.5 — Prose reduction

Only after the taxonomy is mechanically validated, perform a separate editorial pass.

For every explanatory paragraph adjacent to a structured statement ask:

1. Does it add an assumption?
2. Does it add scope?
3. Does it add interpretation?
4. Does it add motivation?
5. Does it add a limitation?
6. Or does it merely announce the kind or evidential status of the following block?

Only the sixth category is a candidate for deletion.

The before/after word count is evidence of reduction, not its justification.

### C8.6 — Traceability

Extend the specification ↔ Lean inventory so that the distinction between:

`normative statement → formal target → proof/evidence`

and

`literature result / assumption / example → provenance or local support`

is explicit.

This work feeds H-semantic traceability but must not be used to claim semantic correspondence merely because labels coincide.

### C8.7 — Exit gate

C8 closes only when:

1. every numbered statement has a validated kind and role;
2. definitions, assumptions, requirements, results, literature claims, and examples are structurally distinguishable;
3. local hypotheses cannot silently become global normative statements;
4. proof and proof-sketch blocks have validated parent kinds;
5. open claims remain open in generated inventories and propagation checks;
6. provenance requirements are enforced for literature claims;
7. the current statement inventory is regenerated from source;
8. the specification builds and renders;
9. the existing mathematical content is unchanged except for explicitly ratified classification;
10. a prose-reduction pass demonstrates that removed text was structurally redundant rather than scientifically necessary.

## 6. Expected implementation sequence

The work should be performed in small, independently reviewable changes:

1. inventory and taxonomy proposal;
2. validation rules and tests;
3. shared internal statement representation;
4. compatibility support for existing `::::thm`;
5. migration of definitions and requirements;
6. migration of assumptions and literature results;
7. migration of theorem/lemma/corollary/proposition/conjecture roles;
8. migration of examples and counterexamples;
9. proof/proof-sketch separation;
10. regenerated inventories and traceability;
11. prose reduction;
12. final CI and scientific review.

No stage should alter theorem truth conditions merely to fit the command model.

## 7. Relation to the existing controls

The existing `notation.py` seal already demonstrates the right direction: it checks declared statuses, levels, duplicate labels, and the presence or absence of proof sketches for selected statuses. C8 should generalize this from a set of string conventions to an explicit ontology.

The current `manuscript_metrics.py` scanner is intentionally textual. It should remain simple, but its output should be derived from the richer command metadata rather than a single overloaded status field.

The current theorem extension in `tools/SpecExt/Theorem.lean` is therefore the implementation point, while `scripts/manuscript_metrics.py` and the notation controls are the assurance points.

## 8. Scientific constraint

This refactoring is documentary/formal infrastructure. It must not be used to manufacture mathematical certainty.

In particular:

- changing proposition → theorem is a scientific status change, not a formatting change;
- adding a proof slot is not a proof;
- marking a literature result as established does not make it a K7PL result;
- turning a prose assumption into an axiom changes the explicit foundational surface and requires authorial ratification;
- deleting prose is legitimate only when the represented information remains recoverable elsewhere.

The taxonomy exists to make these distinctions harder to violate, not easier to conceal.

## 9. Deliverables

The C8 work should ultimately produce:

- a ratified statement ontology;
- a shared SpecExt representation and command family;
- generated statement inventory with kind, role, scope, and evidence;
- validation rules and regression tests;
- a migrated specification with unchanged mathematical content;
- a measured prose reduction report;
- updated specification ↔ Lean traceability;
- a historical record of the migration decisions.

Until these artefacts exist, the current `::::thm` representation remains authoritative.
