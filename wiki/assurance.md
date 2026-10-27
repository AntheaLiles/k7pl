<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Assurance

> **Provenance — Lot 2, assurance case validated in the
> conservative Lot 2 closing.**
> Consolidated 2026-10-25 from `docs/ASSURANCE.md`, the project
> dashboard in `docs/tracking/DASHBOARD.md`, the project master plan
> in `docs/tracking/PROJECT-MASTER-PLAN.md`, and the theoretical
> gate evidence dossier dated 2026-10-11 with its independent exit
> audit and its revalidation dated 2026-10-12, all formerly
> in `docs/migration/` (deleted in the migration closing of
> 2026-10-25, traced in the migration matrix, surviving in
> git history).
> Status: living and canonical for the assurance case.
> `docs/ASSURANCE.md` was deleted in the Lot 2 closing after
> validation of this page; the gate dossier in `docs/migration/`
> was retained as evidence by this closing. It is deleted in
> the migration closing of 2026-10-25, traced in the migration
> matrix, and survives in git history.
> This page states why scientific and formal claims should be
> considered adequately supported within an explicitly bounded
> scope. It is not a declaration of absolute correctness, and it
> is distinct from supply-chain security, which is covered in
> [security](security.md).

## What assurance means here

Assurance covers relationships among specification, formalisation,
implementation, proofs, tests, reviews, reproducibility and
documentation. A claim's progress and a statement's epistemic state
are two different things: a claim may be specified or formalised
while its proof obligation remains open, and "established" always
means established against explicit criteria and scope, never
globally or absolutely proven.

Status words used in this page: `ESTABLISHED`, `PARTIAL`,
`UNDER REVIEW`, `IN PROGRESS`, `OPEN`, `BLOCKED`, `NOT STARTED`.

Evidence can establish only what its kind covers: a mathematical
proof establishes the stated proposition in its formal system; a
formal verification establishes the stated machine-checked
obligation; a computation establishes the result of the specified
computation; a test establishes behaviour actually exercised; a
static analysis establishes the properties its analyser covers;
peer review establishes objections, counterexamples and assessment
within its scope; design rationale explains why a decision was made;
reproducibility evidence establishes that a declared process can be
rerun under stated conditions.

Invalid inferences, stated explicitly in the source: a Lean theorem
proved does not mean the implementation is proven correct; passing
tests do not mean the specification is proven coherent; a successful
build does not mean the formalisation is complete; peer review
without an identified objection is not a mathematical proof; a
green CI run means the configured checks succeeded on their impact
scope, not that every claim is proven.

Traceability runs both ways: a scientific claim must lead to a
normative requirement, then to a formal statement, then to a Lean
definition or theorem, then to a proof, then to executable evidence;
and a Lean theorem must be traceable back to the normative
commitment it supports.

## The six assurance claims

### Conceptual foundations are explicit enough for systematic review

**Claim:** the principal concepts and dependencies of the language
are explicit enough to support systematic review.
**Argument:** the architecture and the specification expose the
principal layers and distinguish normative commitments from formal
and executable artefacts.
**Evidence:** the architecture page, the specification, and formal
review material.
**Status:** `PARTIAL`.
**Limitation:** the next comprehensive formal peer-review cycle is
expected to refine conceptual dependency analysis.
*Provenance (secondary): former claim label in the source, C1.*

### Specification coherence is an independent obligation

**Claim:** coherence of the specification is treated as an
independent assurance obligation, assessed through adversarial
review, explicit issue tracking and consistency analysis.
**Evidence:** peer-review material, active registers, the semantic
qualification register, and the coherence review closed
2026-10-09.
**Status:** `UNDER REVIEW`.
**Limitation:** absence of an identified contradiction is not proof
of global coherence.
*Provenance (secondary): former claim label in the source, C2.*

### Formal artefacts represent identifiable normative commitments

**Claim:** formal artefacts are intended to represent identifiable
normative commitments rather than silently replacing them.
**Argument:** method requires traceability from formal statements
to normative commitments and forbids weakening the specification
solely to make formalisation succeed.
**Evidence:** the method page, the architecture page, Lean source
and consistency-audit procedures.
**Status:** `PARTIAL`.
**Limitation:** a complete specification-to-formalisation
traceability graph is not yet claimed.
*Provenance (secondary): former claim label in the source, C3.*

### Implementation conformance is separate from compilation

**Claim:** implementation correctness is separate from compilation
and testing. The project separates implementation, proof and test
evidence and does not infer specification conformance from
successful compilation.
**Evidence:** the architecture and method pages, the Lean
implementation and its tests.
**Status:** `OPEN`.
**Limitation:** a complete conformance argument is not currently
claimed.
*Provenance (secondary): former claim label in the source, C4.*

### Declared checks are reproducibly executed by CI

**Claim:** declared computational and formal checks are
reproducibly executed by CI for the relevant impact scope.
**Argument:** CI performs configured specification checks, Lean
builds, tests, linting, axiom audits, link checks, REUSE checks
and security checks.
**Evidence:** the CI workflows and CI records.
**Status:** `PARTIAL`.
**Limitation:** CI success establishes execution of configured
checks, not correctness of every scientific claim.
*Provenance (secondary): former claim label in the source, C5.*

### Artefacts and processes are traceable enough to reproduce checks

**Claim:** project artefacts and validation processes are
sufficiently traceable to support reproduction of declared checks.
**Argument:** source, specification, tests, CI configuration,
licensing metadata, releases and archival records are maintained
in the repository and release infrastructure.
**Evidence:** repository history, CI workflows, REUSE metadata,
releases, citation metadata and archival records.
**Status:** `PARTIAL`.
**Limitation:** reproducibility of every historical result and
complete provenance of every external dependency are not claimed.
*Provenance (secondary): former claim label in the source, C6.*

No domain is claimed as `ESTABLISHED` in this page or in its
source. That absence is itself a finding, not an omission.

## The theoretical gate that is still open

**Plain-language summary of the gate:** the theoretical stage of
the project — the stage that must settle the language's core
objects, signatures, resource accounting, substitution, simulation
and memory model — is not finished. Later stages, including the
work on singularities, on the remaining language features, on
implementation conformance and on release, must not start
substantive work until this gate is explicitly satisfied.

The evidence dossier dated 2026-10-11, at the reference commit
it names, concludes that the gate is **not satisfied**. The
independent exit audit of the same date and the revalidation
dated 2026-10-12 reach the same conclusion. This page does not
re-audit the gate at the current head: the dashboard still states
that the stage is open, but a fresh verdict at the current commit
is an open task for the owner, not something this draft claims.

What blocks the gate, in descriptive terms, is nine linked
obligations. Each one below gives what is missing, what decision
the owner must make, and what would count as satisfying it. The
former numbered labels are given only as secondary provenance,
so a reader can find the exact dossier section.

### Grade, usage and mode signatures

What is missing: exact types, domains and partiality for the
grade algebra, the usage projection, the scaling operation, the
budget operator and the admissibility and consumption operators;
several of these remain candidates in the categorical chapter,
and the budget operator is given with a partial signature while
its formula looks total.
Owner decision needed: ratify or revise the candidate interfaces
and confirm the carriers and domains.
What would satisfy it: a canonical table of object, type, domain,
hypotheses and rules, with every operation in the rules typed and
every partiality given an explicit domain.
*Provenance (secondary): gate dossier section C-01.*

### Modal relation domains and directions

What is missing: the exact contract of mode morphisms, the
direction of containment, and the separation between syntactic
inclusion, subtyping, precision order and morphism. No morphism
follows from interval inclusion alone, and the mode-realisation
theorem remains a proposition with a sketch.
Owner decision needed: confirm the proposed realisation or choose
another structure explicitly if a comparison fails.
What would satisfy it: a comparison matrix, each entry with a
contract and a proof or counterexample, then a check of the rules.
*Provenance (secondary): gate dossier section C-02.*

### Conversions and scaling of usage

What is missing: identity and composition laws for coercions,
naturality of the graded comonad, and compatibility of the
weakening and contraction operations; syntactic relabelling alone
does not prove the coercion laws.
Owner decision needed: confirm the indexing interface and the
admissible external hypotheses.
What would satisfy it: typed, proved diagrams, or exactly declared
external hypotheses, with every conversion case in the
substitution induction.
*Provenance (secondary): gate dossier section C-03.*

### The timed rule, resource accounting and correction

What is missing: the cost of every rule, the treatment of finite,
zero and infinite budgets, the shared domain of the budget
transformation, and the limit cases of infinite cost under a
finite budget. The budget interface proposed in working sessions
is not yet made explicit as consumption in the timed rule's
conclusion, and its rule-by-rule correction is not proved.
Owner decision needed: arbitrate between counting a wait in the
execution budget and treating environmental latency as outside
that budget. A later note records an owner decision that
environmental latency belongs to the orchestrator, not to the
triggered automaton's execution budget; formalising that
distinction and proving the timed-rule contract remain open.
What would satisfy it: a proof that no inadmissible crossing is
typable and no cost is hidden, with limit cases covered.
*Provenance (secondary): gate dossier section C-04.*

### Work and depth aggregators and budget scalarisation

What is missing: determination of the total or partial domain of
the budget operator, verification of its order and composition
laws, and a convention for the empty set or for a non-empty
location set, on which the infinite-cost case depends.
Owner decision needed: confirm the domain and the scalar and
budget-bound hypotheses, without deleting the partiality on the
strength of a working note alone.
What would satisfy it: all laws proved on the real domains, an
unambiguous signature, and the infinite-cost case established
under explicit hypotheses.
*Provenance (secondary): gate dossier section C-05.*

### Substitution, conversions and context actions

What is missing: a complete induction over all cases — variables
and binders, boxes, application, vectors, subtyping and related
constructors — with conversions, shared contexts, budgets and
effects, and with the scaling and effective-multiplicity
operations kept in their separate roles.
Owner decision needed: no strengthening or change of status
without confirming the normative signatures and multiplicity
rules.
What would satisfy it: a rule-by-rule induction with typed
premises and explicit freshness, established conversions, and a
demonstrated simultaneous-substitution corollary.
*Provenance (secondary): gate dossier section C-06.*

### Source reduction, simulation and adequacy

What is missing: a typed simulation, proved for every rule, with
a trace and channel invariant and a distinct target adequacy
argument. The simulation obligation itself is open, and a
forward simulation alone does not prove bisimulation or full
abstraction.
Owner decision needed: confirm the exact scope of fidelity and
the observations, without extending the conclusion to a
bidirectional equivalence. Also open, from the simulation
audit: the temporal order under concurrency — a local order
per fibril, a global linearised order, or a partial order of
events — must be ratified before the simulation is completed
or restricted to the sequential fragment alone (see the open
decisions in [decisions](decisions.md)).
What would satisfy it: a simulation proved for every rule, a
trace and channel invariant, and adequacy kept distinct from
simulation.
*Provenance (secondary): gate dossier section C-07.*

### Abstract memory, uniqueness hypotheses and representation profile

What is missing: independent proofs of the three spatial-safety
hypotheses — at most one introduction of a write capability per
region, disjoint ranges denoting distinct regions, and delimiters
preventing a Cartesian value from capturing a linear capability.
Spatial safety is currently conditional on these hypotheses, the
unique-introduction proof sketch still lacks the arena-elimination
case, and the argument graph for the first hypothesis is
potentially circular.
Owner decision needed: either establish the first hypothesis
through an explicit elimination rule, or assume it explicitly as
a model hypothesis with a restricted scope and a reduced claim.
What would satisfy it: the chosen route recorded, an independent
proof or an explicit hypothesis, distinct proofs for the other
two hypotheses, and concrete claims tied to a versioned
representation profile, without automatic inference to a binary
or interface contract.
*Provenance (secondary): gate dossier section C-08, hypotheses
H1, H2 and H3 in the source.*

### External formal imports and dependencies

What is missing: for every external framework used, its version
and reference, the fragment taken, the hypotheses borrowed, the
mapping into this project, and the property deduced from it.
A reference alone does not prove an instance in this project.
Owner decision needed: confirm the normative scope of modal
theory and graded types, and the admissible external hypotheses;
do not make a cost calculus or guarded recursion normative merely
because formalisation is convenient.
What would satisfy it: a complete and precise import register,
with hypotheses and mapping, and no silent external hypothesis.
*Provenance (secondary): gate dossier section C-09.*

## Peer-review evidence

Peer review is adversarial evidence, not normative
state. This section consolidates the September 2026
reviews; it does not promote their objections to
theorems, nor their "closed" statuses to facts
verified at the current head.

### Provenance and epistemic status

Two review cycles are consolidated. The first cycle
(pr-01, 2026-09-08 and 2026-09-09) reviewed an
earlier manuscript and produced 28 executable
correction instructions, applied the same day with
three failures remaining (the three nu items, to be
closed by decision). The second cycle (pr-02)
reviewed the manuscript of 2026-09-09 in six
reports, consolidated 2026-09-14 (revision 2) into a
190-entry plan: 127 detailed cards plus 63 entries
in tables, with a section tracing every source item
to a card, an acquired result, or an arbitration.
That consolidation is the provenance for everything
below; the raw reports themselves are session
prose, kept in git history, not recopied here.

Two limits govern every status quoted below. The
consolidation's direct verification covers only
about twenty decisive points on the document; the
other cards rest on the reports' faith. And the
card statuses in the tracking view (119 closed,
34 partial, 31 open, 1 to ratify, 3 decision,
2 rejected, at the view's last state of
30 September to 5 October) rest on session journals
now in git history only, while the specification
has continued to evolve. A "closed" status from
that view is therefore quoted as a register status
at that date, never as a verification at the
current head. One quoted count is explicitly not
propagated: a claim that one item was the only one
of nineteen in its case does not appear in the
extracted text layer and is not confirmed.

### Convergence: points raised by at least three reviewers

- The heaviest proof debt, unnamed in the
  commitment table (see below), is not
  demonstrated.
- Static acyclicity is not liveness: a dynamic
  dependency cycle exists without a static graph
  cycle (canonical counterexample below).
- Bit-for-bit replay is not established as
  stated; the historic formulation was replaced
  (see [decisions](decisions.md)).
- Zero-copy, isolation without a memory
  management unit, and closure of the tenth rule
  are contested.
- Fifty-one statements carry a single
  "theorem" environment with heterogeneous
  epistemic statuses: demonstrated, under
  hypotheses, from literature, implementation or
  environment properties, definitions, and
  conjectures — several statements belonging to
  several categories at once. The lesson is the
  heterogeneity, not any count: the counts are
  not additive and must not be quoted as a
  tally.

### Methodological lesson from the first cycle

Controls verify internal coherence, never the
truth of a mathematical claim. Only three
controls were mechanisable at that date (typing
judgement outside chapter 2, one glyph per
modality, forbidden vocabulary near a hash);
everything else required an external reviewer at
each major version. That lesson stands, and it is
why this page treats review as evidence rather
than as proof.

### Open and partial cards, in descriptive titles

Register statuses at the view's last state, to be
re-checked against the current specification; old
codes only as secondary provenance:

- Partial: two semantics without an agreement
  theorem; the context structure interpreting
  nothing, with its first postulate as an axiom
  without a model; the resource structure with
  two definitions; the level not produced by the
  rules; spatial safety; the representation
  theorem; the heaviest proof debt and the
  session non-interference, delimited disclosure,
  truncation, substitution and related proof
  debts; modal coercion coherence.
- Open: inversion of anteriority (the supposedly
  germinal judgement is founded by an annex);
  the trace as a sequence rather than a partial
  order; the handler as a primitive; compilation
  and execution as a modality; the distributive
  law; dependent, indexed and graded-effect
  fragments; the remaining proof debts on
  indexed effects, distribution and guarded
  recursion; boxes and atomic matching; the
  singularity propagation table; factorisations
  on the level index and on quantale versus
  prefixing; transversal cards on propagation,
  the obligation register and the modal
  relation; bibliography cards, including the
  modularity reference left uninstructed.
- Decision pending: the mode system as the
  single home of the eleven modalities, and the
  graded distributive law.
- To ratify: scoped effects, with the
  intermediate position (algebraic and scoped
  structures named, weak closure on the second)
  applied but not owner-confirmed, and the
  modularity reference still uninstructed.

### The heaviest proof debt, missing from the commitment table

The consolidation's heaviest debt is absent from
the commitment table, together with two further
missing commitments (agreement between the two
semantics, and existence of the context
interpretation). That absence is itself a
register gap, recorded here, not only a proof
debt. Relatedly, the budget is an upper bound,
not a prediction: a handler that reduces cost
receives no credit for it, so the declared budget
is structurally pessimistic in the presence of
cutting scoped operations, and the gap to the
real cost is unbounded. Where the timed rule is
discussed above, read "budget" with that
consequence in mind.

### Objections instructed and set aside

Instructed objections that were set aside, and
must not be reintroduced by corrective zeal at
closing time: the overloading of the bang
operator is legitimate; the two-context choice
is deliberate; the inter-chapter coherences
stand; "no hidden cost" is nuanced rather than
false; local atomicity is correctly distinguished
from global compositionality. The refused
factorisations (grade and size index, usage
comonad and cofree comonad, wiring graph and
wait graph, two projections, inductive and
coinductive sizes, three preservations,
algebraic and scoped effects) are documented
refusals: a well-executed refusal looks like an
absence, so it is recorded rather than executed.

### Canonical counterexamples

- **Dynamic cycle without a static cycle.**
  Four actors in a diamond with a junction: a
  temporal circular dependency with no cycle in
  the static graph. This is why the static graph
  alone cannot establish absence of deadlock,
  and why the guard analysis in
  [research](research.md) matters.
- **Secret case without a level clause.** A
  mailbox with a tick and a secret key, two
  branches, two levels: without the level clause
  on the case rule, a valid derivation
  discloses. This is the first test case to
  execute before writing the guard rules.
- **Propagation defect.** Corrections are
  written where they are discovered, while
  earlier statements are not updated (seven
  mentions of one theorem at incompatible
  statuses, two definitions of the resource
  structure, two senses of "elaboration", an
  uncorrected rule, a phase zero invoked ten
  times and absent from the pipeline). This is
  the justification for the obligation register
  and for the rule that a reservation bounding
  an affirmation must rewrite the affirmation.

### What remains to re-check

The first cycle's inherited reservations, after
re-checking against the current specification:
the wait-graph simulation is named, not
demonstrated, with the coinduction preservation
step missing; erasure preservation is to be
written; the two subsumption orders are to be
separated. The second cycle's open and partial
cards above are to be re-checked the same way.
Until that re-check, this section is a
consolidated objection register, not a
verification.

### Third cycle: consolidated review, October 2026

A third, consolidated review (observations dated
2026-10-17, on commits then current, uploaded by
the owner on 2026-10-25 and integrated as
`docs/peer-review/pr-03/`, then deleted after
integration) reached a verdict of major revisions.
Its core claim, checked here against the current
tree rather than taken on trust, is that the
metatheoretical guarantees announced in prose
exceed what the Lean files prove: substitution,
preservation, progress, commutation, refinement
and lowering stand at proof sketch or open
obligation. No counterexample was found; the
claim is about demonstrated correspondence, not
about the language being false. All line numbers
from that review were relocated before use, since
they had moved.

What was already covered, and is not recopied as
new: the text-to-status alignment (22 of 27
passages reworded under the owner's 2026-10-19
mandate, plus an 8-passage extension; five
passages remain, awaiting a decision on progress
and on absence of blocking); the status file
(still generated, for an earlier commit, and
measuring declared links rather than statement
equivalence); the figure sheets (closed in
PR #273); the open obligations already carried
by the gate section above; and decisions 42–53
of the 2026-10-19/20 session, already itemised
in [decisions](decisions.md).

What this cycle adds, verified in the current
tree:

- The effective kernel covers only Var, Ret, Lam,
  App and Let; contextual composition and the
  effect transformation are explicit parameters,
  and the addition law for composition is only
  sketched. Its definition and domain are owner
  decisions, not settled here.
- The abstract Lean models (memory capability,
  grade budget, usage scaling, structural modes,
  memory ranges) prove properties of abstract
  models, with no proved bridge to the
  operational rules, effect judgements or typing
  rules they are meant to serve. No global
  guarantee (memory safety, absence of data
  races, cost bound) may be presented as deduced
  from an abstract model without that bridge.
- No interpretation of the graded judgements in
  the co-Kleisli category of the indexed comonad
  is given, and no projection of the four grade
  coordinates onto the gradation structure; the
  categorical chapters describe the intended
  frame, and statements depending on it remain
  open.
- The operational semantics module in `src/` is a
  counter demonstrator only (two increments from
  `n` to `n + 2`), never to be cited as the
  semantics of K7PL.
- One wording remains unaligned in the current
  tree and was deliberately not edited here: the
  operational semantics introduction still says
  preservation and progress are demonstrated,
  while both theorems stand as under-review with
  proof-sketch evidence. That passage is among
  the five awaiting an owner decision, so it is
  recorded as open, not silently reworded.
- No `sorry`, `admit`, new axiom or `native_decide`
  declaration was found in `src/` or `spec/` in
  the pre-integration check (only the adjective
  "admitted" in comments); axiom audits were not
  run, since no full Lean build was executed.

Discarded findings from that review were checked
for absence and not treated: figure files and
Lean modules it lists as absent from its
observed manifest, and the two quoted slogans
about garbage collection and end-to-end
correctness, which do not occur in the tree.

### Module hypotheses and tool obstacles

Transcription into a proof assistant will have to
pose six hypotheses as parameters, from the module
hypotheses inventory (2026-10-08): totality of the
operation interpretation; conformance of the arena
lowering; determinism of traversal, search and
seed; simulation; translation threading the time
channel; and the extended reproducibility
statement with its profile. Four tool obstacles are
named with them: sort metatheory mechanised for a
single sort only; a cubic path type missing in the
target assistant; a solver emitting no certificate;
and a formalised graded proof pattern in Agda,
whose transposition cost must be budgeted. These
are parameters and obstacles, not established
results.

### Statement migration exit gate

The statement migration register (C8) is not closed.
Its exit gate opens only when every numbered
statement has a validated type and role, when local
hypotheses do not silently become global normative
statements, when the inventory is regenerated from
the source, and when a prose-reduction pass
demonstrates the structural redundancy of the
deleted text. Two scientific constraints belong to
the same gate: changing a proposition into a
theorem is a change of scientific status, not of
formatting, and adding a proof slot is not a proof.
The master plan's exit criteria for the theoretical
gate's final stage are: explicit signatures;
explicit domains and directions; external
dependencies separated; open propositions visibly
open; remaining work of a proof, semantic or
decision nature; and later stages startable with
no hidden theoretical object. One governing rule
from the same plan: a downstream artefact — Lean
compilation, a green CI, an implementation
behaviour, a referenced historical document —
never silently closes an upstream scientific
obligation.

## Assurance gaps, stated plainly

1. Complete the specification coherence assessment.
2. Construct a systematic specification-to-formalisation trace.
3. Define and verify the intended implementation-conformance
   boundary.
4. Re-check the consolidated peer-review objections and
   resolutions against the current specification (the
   consolidation itself is now in the section above;
   the re-check is what remains).
5. Expand reproducibility evidence where current CI evidence is
   insufficient.

These gaps are intentionally visible in this page, as they were
in its source.

## Intrinsic guarantees and the native boundary

This is a scoped closure, not a general safety claim. The
normative correction in the germinal axiomatics limits actor
isolation to the communication transitions of the abstract model.
It does not claim physical inaccessibility or confinement of
arbitrary native code. A finite model and a counterexample are
non-normative falsification evidence for the distinction between
an enforced boundary and an unconfined native write.

For the implemented expression subset only, the maintained Lean
proofs give one-way witnesses for root addition, integer
comparison and both conditional branches against the generated
rewrite relation, and separately prove preservation for that
generated relation under an explicit typing invariant. These
results do **not** establish general source-to-machine simulation
for every reduction, context and continuation transition,
equivalence of the executable classifier and the Lean typing
judgement, physical native confinement, or correctness of a
foreign-function implementation.

The per-declaration expected axiom dependencies and their
run-specific observed report are still being connected to
generated status. Until the exact audit report is attached to a
successful formal-semantics run for the relevant commit, a
dependency contract is not evidence that the run passed.

## What this page does not establish

Nothing in this page establishes that the language is proven
safe, that its specification is globally coherent, that its
implementation conforms to its specification, or that the
executable classifier and the Lean typing judgement are
equivalent. Those claims would require the gate obligations
above, a specification-to-formalisation trace, and the
corresponding proofs. Until then, cite this page for the claim
statuses and the open obligations — not for the theorems.

## Open points for the owner

- Ratify or revise the candidate interfaces and the budget
  operator's domain, and record the timed-rule interpretation
  in a form that can be formalised.
- Choose the route for the first spatial-safety hypothesis:
  explicit elimination rule, or explicit model hypothesis with
  a reduced claim.
- Re-verify the theoretical gate at the current head, criterion
  by criterion, and obtain an explicit human review before any
  later stage is allowed to start substantive work.
- Decide the future of the prototype appendices: develop them
  separately, group them into one complementary-tooling appendix
  with an explicit boundary, or defer them. This page does not
  choose among those options.

## Statement inventory (C8)

This appendix is the machine-checked successor of
`docs/tracking/LEAN-STATEMENT-MIGRATION.md`, deleted in the
complete tracking, review and method closing of 2026-10-25.
It carries, verbatim, the current classification table and
the frozen pre-migration appendix that
`scripts/spec_checks/statement_inventory.py` reads (repointed
here from the deleted register). A classification is not a
proof: the register's repeated note is carried — a ratified
classification does not establish any mathematical claim.
The C8 gate itself (C8.5 prose reduction not started, C8.6
traceability open, C8.7 exit gate open) is carried in
[roadmap](roadmap.md), "Close the statement migration
gate"; the eleven semantic-review lots are tasks there,
not tables here. The frozen appendix below describes the
pre-migration snapshot at its reference commit, not the
current state; its line numbers are historical landmarks
and no longer necessarily match current lines.

### Classification courante
| Label | Source | Nature | Rôle | État | Appui | Scope tag | Portée détaillée ratifiée | Niveau historique | Note de migration |
|---|---|---|---|---|---|---|---|---|
| `thm:divulgation_delimitee` | `spec/Spec/C2/AdjunctionsAndEnrichment.lean` | result | conjecture | proposed | proofsketch | security | Proposition de non-interférence conditionnelle à l’accord sur les échappatoires ; cas Declassify et relation de libération non prouvés. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:terminaison_lfp` | `spec/Spec/C2/AdjunctionsAndEnrichment.lean` | result | theorem | under-review | proofsketch | fixed-points | Itération monotone sur Trellis_fin de hauteur h ; vérifier hypothèses d’ordre, hauteur, borne et leastness. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:terminaison_strates` | `spec/Spec/C2/AdjunctionsAndEnrichment.lean` | result | corollary | proposed | proofsketch | fixed-points | Stratum-by-stratum evaluation of a layer-3 query whose negations stratify, each stratum by thm:terminaison_lfp; dependency relation, decision of stratifiability and refusal code still to state. | langage | Added on 2026-10-27 by the author's choice Q-SPEC-301 (Q-SPEC-206 B); classification not yet ratified; a classification is not a mathematical proof. |
| `req:sedimentation_graduee` | `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | requirement | — | not-applicable | none | fixed-points | Extension graduée de la sédimentation; convergence ouverte | langage | Exigence ouverte séparée du résultat de littérature thm:sedimentation. |
| `thm:fenetre_grade` | `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | result | proposition | proposed | proofsketch | fixed-points | Réduction de fenêtres de pile à la troncature N_r ; explicitement non démontrée dans le bloc. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:loi_historique` | `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | result | theorem | under-review | proofsketch | fixed-points | Lois de cohérence de λ pour la comonade cofree et bialgèbre ; naturalité et équations doivent être vérifiées. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:productivite_couche_2` | `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | result | corollary | under-review | proofsketch | fixed-points | Production d’une observation en temps fini par anamorphisme typé ; ne signifie pas épuisement du flux. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:progression_polarisee` | `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | result | theorem | under-review | proofsketch | fixed-points | Principe général à deux cas de polarité : terminaison en μ, production finie d’observation en ν. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:sedimentation` | `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | literature | — | not-applicable | literature | literature | Résultat non gradué de points fixes imbriqués et convergence des approximations finies | langage | Esquisse explicative conservée sur l’objet documentaire ; provenance bibliographique exacte encore à résoudre. |
| `thm:terminaison_couche_3` | `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | result | corollary | under-review | proofsketch | fixed-points | Terminaison du pli sur μF par indice strictement décroissant ; corollaire de progression_polarisee. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:troncature_comonade` | `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | result | theorem | under-review | proofsketch | fixed-points | Lois de comonade graduée et morphisme de comonades pour la troncature, sous les définitions de N_r et δ. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:action_parallele` | `spec/Spec/C2/ExponentialComonadAndFragments.lean` | result | lemma | under-review | proofsketch | effects | Compatibilité de φ_n avec l’effet parallèle pour multiplicité entière ; budget exclu et traité séparément. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:coherence_axiome` | `spec/Spec/C2/ExponentialComonadAndFragments.lean` | result | proposition | proposed | proofsketch | effects | Compatibilité r·ψ(Δ,ε)=ψ(r·Δ,φ_r(ε)) seulement dans le domaine où les deux actions sont définies ; aucun axiome par le seul nom. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:coherence_usage` | `spec/Spec/C2/ExponentialComonadAndFragments.lean` | result | lemma | under-review | proofsketch | effects | Commutation de Scale_Usage avec ψ, sous factorisation et domaine défini ; signatures et quatre composantes à confirmer. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:distributivite_tronquee` | `spec/Spec/C2/ExponentialComonadAndFragments.lean` | result | lemma | under-review | proofsketch | effects | Pour u fini ou k=0 ; la preuve par cas des combinaisons finies/infinies, notamment k=ω, doit être exhaustive. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `req:schema_reinvocation_compatibility` | `spec/Spec/C2/SixMetatheorySchemas.lean` | requirement | — | not-applicable | none | metatheory | Ré-invocation de multiplicité n ∈ ℕ∞ ; l’associativité et la compatibilité contexte/effet sont des obligations distinctes ; au cas ω, la compatibilité est distincte et conditionnelle aux suprema qui définissent φ_ω | langage | Obligation extraite de thm:schema_reinvocation. |
| `thm:lemme_capacite` | `spec/Spec/C2/SixMetatheorySchemas.lean` | result | lemma | under-review | proofsketch | resources | Ressources linéaires / accès concurrents | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_commutation` | `spec/Spec/C2/SixMetatheorySchemas.lean` | result | lemma | under-review | proofsketch | metatheory | Substitution et transformations syntaxiques | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_effacement` | `spec/Spec/C2/SixMetatheorySchemas.lean` | result | lemma | under-review | proofsketch | metatheory | Morphism de raffinement conditionnel aux lois de commutation, préservation et fibre ; les trois conséquences ne sont pas acquittées par le seul schéma. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_preservation` | `spec/Spec/C2/SixMetatheorySchemas.lean` | result | lemma | under-review | proofsketch | metatheory | Traduction de systèmes de règles | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_reinvocation` | `spec/Spec/C2/SixMetatheorySchemas.lean` | result | lemma | under-review | none | metatheory | Ré-invocation de multiplicité n ∈ ℕ∞ : cas fini borné, cas ω traité explicitement (domaine décidé par l'autrice le 12 octobre 2026). | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_restriction` | `spec/Spec/C2/SixMetatheorySchemas.lean` | result | lemma | under-review | proofsketch | metatheory | Restriction de structures | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:tri_topologique` | `spec/Spec/C2/SixMetatheorySchemas.lean` | result | lemma | supported | proofsketch | graphs | Graphes finis | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:determinisme_observationnel` | `spec/Spec/C2/RefinementSystem.lean` | result | conjecture | proposed | proofsketch | operational-semantics | Conjecture conditionnelle à une politique d’ordonnancement non consultative ; le cas Guard reste ouvert. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:non_interference` | `spec/Spec/C2/RefinementSystem.lean` | result | theorem | under-review | proofsketch | security | Fragment séquentiel ; observation indexée par niveau. Ne pas étendre à la concurrence ni à la déclassification. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:raffinement` | `spec/Spec/C2/RefinementSystem.lean` | result | theorem | under-review | proofsketch | metatheory | Construction du système de raffinement, conditionnelle à une traduction fonctorielle préservant le typage ; les trois lectures sont des corollaires séparés. | langage | Classification ratifiée ; scindé le 12 octobre 2026 (décision de l'autrice, option a). La classification n’est pas une preuve mathématique. |
| `thm:raffinement_effacement` | `spec/Spec/C2/RefinementSystem.lean` | result | corollary | under-review | none | metatheory | Effacement de la Phase 8 comme action de la traduction sur les objets, sous la prémisse que la Phase 8 efface exactement grades et effets. | langage | Objet issu de la scission de thm:raffinement ; état hérité du bloc d'origine, sans promotion. Formulation des prémisses à valider par l'autrice. |
| `thm:raffinement_non_interference` | `spec/Spec/C2/RefinementSystem.lean` | result | corollary | under-review | none | security | Non-interférence du chapitre 1 comme indiscernabilité dans la base, relativement à une relation d'observation fixée sur le métalangage. | langage | Objet issu de la scission de thm:raffinement ; état hérité du bloc d'origine, sans promotion. Formulation des prémisses à valider par l'autrice. |
| `thm:raffinement_precision` | `spec/Spec/C2/RefinementSystem.lean` | result | corollary | under-review | proofsketch | graded-typing | Précision restreinte à une fibre comme ordre de la fibre, et ordre modal comme restriction à l'usage, si ⊑ porte sur grades et effets et si sa restriction est un ordre. | langage | Objet issu de la scission de thm:raffinement ; esquisse déplacée depuis le bloc d'origine. Formulation des prémisses à valider par l'autrice. |
| `thm:temps_mononiveau` | `spec/Spec/C3/TypeGrammar.lean` | result | lemma | under-review | proofsketch | effects | Sous-quantale des effets concentrés à un niveau ; vérifier fermeture et signature complète des opérations. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `req:homomorphisme_roues_realisation` | `spec/Spec/C3/ValueConstraints.lean` | requirement | — | not-applicable | none | representation | Injectivité des quatre singularités et comportement de select ; l’arithmétique des valeurs encodées est une exigence de réalisation séparée | representation | Obligation de réalisation séparée de thm:homomorphisme_roues. |
| `thm:deadlock_acyclique` | `spec/Spec/C3/ValueConstraints.lean` | result | theorem | under-review | proofsketch | concurrency | Absence de blocage mutuel sous protocoles duaux et graphe de dépendances acyclique ; invariant graphe statique/dynamique à établir. 2026-10-20 : cet invariant, la simulation du graphe d'attente (Sim), est une prémisse explicite de l'énoncé (décision de l'autrice, Q3 a). | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:homomorphisme_roues` | `spec/Spec/C3/ValueConstraints.lean` | result | proposition | under-review | proofsketch | representation | Injectivité des quatre singularités et comportement de select | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:representation_inobservable` | `spec/Spec/C3/ValueConstraints.lean` | requirement | — | not-applicable | none | representation | Invariance de obs entre représentations admissibles d’une même valeur ; relation d’admissibilité et signatures de repr/obs à préciser. | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:completude_graduee` | `spec/Spec/C3/GradedSystem.lean` | result | proposition | under-review | proofsketch | graded-typing | Exhaustivité uniquement sur l’inventaire fermé des codes du noyau, pas sur l’annexe illustrative ni les extensions. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:completude_verificateur` | `spec/Spec/C3/GradedSystem.lean` | requirement | — | not-applicable | none | graded-typing | Implémentation du vérificateur / compilation | compilation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:morphismes_modes` | `spec/Spec/C3/GradedSystem.lean` | result | proposition | under-review | proofsketch | graded-typing | Quatre morphismes pour l’instanciation donnée ; dépend de l’orientation exacte des inclusions Cont et de l’affaiblissement. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:boxtimes_addition` | `spec/Spec/C3/TypingRules.lean` | result | corollary | under-review | proofsketch | graded-typing | Égalité avec l’addition des contextes lorsque la composante temporelle est nulle et ψ est définie partout. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:coherence_subsomption` | `spec/Spec/C3/TypingRules.lean` | result | proposition | under-review | proofsketch | graded-typing | Cohérence des interprétations des dérivations d’un même terme ; isoler les faits annexes sur les jointures. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:commutation_monoide` | `spec/Spec/C3/TypingRules.lean` | result | lemma | under-review | proofsketch | graded-typing | Projection sur S sous absence de relations croisées ; le cas ω dépend de la préservation des suprema du quotient. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:determinisme_parallele` | `spec/Spec/C3/TypingRules.lean` | result | theorem | under-review | proofsketch | graded-typing | Couche 3 / parallélisme / coût | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:loi_distributive_conditions` | `spec/Spec/C3/TypingRules.lean` | result | theorem | under-review | proofsketch | legacy-unspecified | Énoncé présent dans spec/, comptabilisé le 2026-10-25 par décision de l'auteur (aucun énoncé en trop, manque de traçabilité) ; portée détaillée à compléter. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:substitution` | `spec/Spec/C3/TypingRules.lean` | result | lemma | under-review | proofsketch | graded-typing | Substitution typée sous hypothèses explicites de mise à l’échelle d’usage, compatibilité avec ψ et conversions de grade. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:substitution_indices` | `spec/Spec/C3/TypingRules.lean` | result | theorem | under-review | proofsketch | legacy-unspecified | Énoncé présent dans spec/, comptabilisé le 2026-10-25 par décision de l'auteur (aucun énoncé en trop, manque de traçabilité) ; portée détaillée à compléter. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:substitution_simultanee` | `spec/Spec/C3/TypingRules.lean` | result | corollary | under-review | proofsketch | graded-typing | Substitution simultanée dérivée par itération de substitution élémentaire, une liaison à la fois. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:preservation_type` | `spec/Spec/C3/OpenStructuresEffectsAndMetatheory.lean` | result | theorem | under-review | proofsketch | graded-typing | Préservation par réduction sous condition de séparation P2 ; volet MLIR est la conjecture distincte abaissement_grades. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:fidelite_interprete` | `spec/Spec/C4/UnderlyingProcessCalculus.lean` | result | theorem | under-review | proofsketch | translation | Fidélité conditionnelle sur communication, contrôle et effets ; exclut explicitement grades et raffinements. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:simulation` | `spec/Spec/C4/UnderlyingProcessCalculus.lean` | result | theorem | under-review | proofsketch | translation | Simulation avant →+ modulo équivalence structurelle, avec extension de trace ; le canal de temps et les clauses d’effet restent à établir. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:traduction_metalangage` | `spec/Spec/C4/UnderlyingProcessCalculus.lean` | result | theorem | under-review | proofsketch | translation | Préservation du typage de chaque dérivation par traduction, sous obligations par règle et ré-invocation. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:isomorphisme_memoire` | `spec/Spec/C4/ActorScale.lean` | result | proposition | under-review | proofsketch | interoperability | Dispositions bit-à-bit pour types primitifs de largeur fixe et versions déclarées ; pas de garantie générale entre formats. | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:determinisme_rejeu` | `spec/Spec/C4/SystemScale.lean` | result | theorem | under-review | proofsketch | runtime | Rejeu logique observationnel, sous journal complet et gestionnaires purs ; ne conclut pas à l’identité binaire. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:liberte_initialisation` | `spec/Spec/C4/SystemScale.lean` | result | lemma | under-review | proofsketch | runtime | Initialisation complète sous acyclicité du graphe et correspondance démontrée entre graphe statique et attentes dynamiques. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:rejeu_binaire` | `spec/Spec/C4/SystemScale.lean` | result | corollary | under-review | proofsketch | runtime | Identité binaire seulement sous E_repro et injectivité de la représentation ; corollaire conditionnel du rejeu logique. 2026-10-20 : l'injectivité est remplacée par l'invariance `H_repr` (décision de l'autrice, Q3 c, option a). | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:revocation_ffi` | `spec/Spec/C4/SystemScale.lean` | requirement | — | not-applicable | none | ffi-safety | Passerelle FFI / runtime | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:surete_ffi` | `spec/Spec/C4/SystemScale.lean` | result | theorem | under-review | proofsketch | ffi-safety | Exclusivité d’accès de l’acteur pendant l’appel FFI ; n’implique pas la révocation côté hôte. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:sync_motifs_jonction` | `spec/Spec/C4/SystemScale.lean` | result | lemma | under-review | proofsketch | concurrency | Sémantique de Guard/jonction pour présence simultanée de messages ; préciser la relation exacte avec la transition. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:chaine_fils` | `spec/Spec/C4/MetalanguageSortSystem.lean` | result | proposition | under-review | proofsketch | legacy-unspecified | Énoncé présent dans spec/, comptabilisé le 2026-10-25 par décision de l'auteur (aucun énoncé en trop, manque de traçabilité) ; portée détaillée à compléter. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:cloture_sortage` | `spec/Spec/C4/MetalanguageSortSystem.lean` | result | lemma | under-review | proofsketch | graded-typing | Préservation du sortage par substitution à égalité de sortes ; l’égalité discrète simplifie l’induction mais les cas restent à contrôler. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:confinement_sortes` | `spec/Spec/C4/MetalanguageSortSystem.lean` | result | lemma | under-review | proofsketch | graded-typing | Sortage de la traduction et confinement des canaux d’effets libres à ceux mentionnés par ε ; dépend de la traduction typée. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:introduction_unique` | `spec/Spec/C4/MemoryModels.lean` | result | proposition | under-review | proofsketch | memory-safety | Unicité d’introduction, acyclicité des destinations et terminaison ; la justification de H1 et le cas d’élimination d’arène restent ouverts. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:surete_spatiale` | `spec/Spec/C4/MemoryModels.lean` | result | theorem | under-review | proofsketch | memory-safety | Impossibilité de mutation concurrente sous H1, H2 et H3 ; H1 n’est pas justifiée indépendamment. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:commutation_traduction` | `spec/Spec/C4/OperationalSemantics.lean` | result | lemma | under-review | proofsketch | translation | Équation de traduction/substitution modulo congruence structurelle cible ; conditions de fraîcheur et cas de construction à vérifier. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:correspondance_niveaux` | `spec/Spec/C4/OperationalSemantics.lean` | result | proposition | under-review | proofsketch | legacy-unspecified | Énoncé présent dans spec/, comptabilisé le 2026-10-25 par décision de l'auteur (aucun énoncé en trop, manque de traçabilité) ; portée détaillée à compléter. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:correction_ressource` | `spec/Spec/C4/OperationalSemantics.lean` | result | theorem | under-review | proofsketch | resource-accounting | Borne instrumentée des usages effectifs par membre et liaison ; machine instrumentée et compte partagé à définir. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:image_fix` | `spec/Spec/C4/OperationalSemantics.lean` | result | theorem | under-review | proofsketch | fixed-points | Image du point fixe sur Trellis_fin de hauteur h ; dépend de terminaison_lfp et de la compatibilité de ré-invocation finie. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:lemme_fondamental` | `spec/Spec/C4/OperationalSemantics.lean` | result | lemma | under-review | proofsketch | logical-relations | Fragment sans Declassify, y compris dans les images de substitution ; la déclassification reste hors portée. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:preservation` | `spec/Spec/C4/OperationalSemantics.lean` | result | theorem | under-review | proofsketch | operational-semantics | Préservation du type et décroissance du potentiel le long des chaînes d’une trace partielle ; invariants concurrents à formaliser. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:progres` | `spec/Spec/C4/OperationalSemantics.lean` | result | theorem | under-review | proofsketch | operational-semantics | Progrès local d’un calcul clos ; ne pas confondre avec le progrès global d’un pool et l’absence de blocage mutuel. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:relation_produit` | `spec/Spec/C4/OperationalSemantics.lean` | result | lemma | under-review | proofsketch | logical-relations | Compatibilité d’une relation logique produit sous la condition sur la clause de modalité ; la composante budget reste à justifier. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:stratification_journal` | `spec/Spec/C4/OperationalSemantics.lean` | result | theorem | under-review | proofsketch | operational-semantics | Équivalence d’observation du rejeu après projection au niveau ℓ ; dépend de la sémantique des traces et de l’effacement sûr. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:expansion_macro` | `spec/Spec/C5/WhatAMacroDeclares.lean` | result | corollary | under-review | proofsketch | syntax | Dérivabilité de Expand par substitution et composition des effets dans l’ordre syntaxique ; corollaire de l’élaboration. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `def:elaboration` | `spec/Spec/C5/ElaborationTheorem.lean` | definition | — | not-applicable | none | syntax | Fonction Surface → Noyau | langage | Compagnon de la séparation du bloc composite thm:elaboration. |
| `thm:elaboration` | `spec/Spec/C5/ElaborationTheorem.lean` | result | theorem | under-review | proofsketch | syntax | Fonction Surface → Noyau ; isoler la définition de la préservation du sens et des conséquences annexes. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:hygiene` | `spec/Spec/C5/SpecialisedNotations.lean` | result | lemma | under-review | proofsketch | syntax | Macros / substitution | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:hygiene_graduee` | `spec/Spec/C5/SpecialisedNotations.lean` | result | conjecture | proposed | proofsketch | syntax | Commutation graduée de la métasubstitution ; le transfert des contextes/effets reste non démontré. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:resucrage` | `spec/Spec/C5/SpecialisedNotations.lean` | requirement | — | not-applicable | none | syntax | Exigence de préservation de l’α-équivalence de surface ; l’algèbre de liaison de surface manque. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:staticite_syntaxe` | `spec/Spec/C5/SpecialisedNotations.lean` | result | corollary | under-review | proofsketch | syntax | Aucune production de noms à l’exécution, sous la grammaire et les phases décrites ; corollaire revendiqué de l’élaboration. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:abaissement_grades` | `spec/Spec/C6/WhatTheSolverReturns.lean` | result | conjecture | proposed | proofsketch | compilation | Conjecture de préservation des grades par abaissement vers MLIR ; preuve règle par règle absente. | compilation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:interface_jugement` | `spec/Spec/C6/WhatTheSolverReturns.lean` | definition | — | not-applicable | none | compilation | Définition de l’interface par le jugement | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:interface_jugement_cloture` | `spec/Spec/C6/WhatTheSolverReturns.lean` | result | proposition | under-review | proofsketch | compilation | Définition de l’interface par le jugement ; clôture limitée aux formes de déclaration énumérées | langage | Propriété séparée de la définition thm:interface_jugement. |
| `thm:rejet_reproductible` | `spec/Spec/C6/WhatTheSolverReturns.lean` | result | theorem | under-review | proofsketch | compilation | Identité du diagnostic sous configuration fixe et hypothèse D_det ; déterminisme des parcours/choix à garantir. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:stabilisation_pipeline` | `spec/Spec/C6/CompilationProcess.lean` | result | theorem | under-review | proofsketch | compilation | Terminaison de la boucle vérification/optimisation sous budget fini décroissant strictement à chaque modification. 2026-10-20 : les prémisses opérationnelles sont dans l'énoncé (décision de l'autrice, Q3 d). | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |

### 2. Inventaire détaillé

Le statut et le niveau sont les valeurs explicites présentes dans la directive ; en l'absence d'argument, la valeur par défaut de l'implémentation actuelle est reportée (`theoreme` et `langage`). Le titre est transcrit du créneau `:::title`, avec espaces normalisés.

| Source | Ligne | Label | Statut historique | Niveau historique | Titre | Esquisse |
|---|---:|---|---|---|---|---|
| `spec/Spec/C2/SixMetatheorySchemas.lean` | 35 | `thm:schema_commutation` | theoreme | langage | schéma de commutation | oui |
| `spec/Spec/C2/SixMetatheorySchemas.lean` | 63 | `thm:schema_preservation` | theoreme | langage | schéma de préservation par traduction | oui |
| `spec/Spec/C2/SixMetatheorySchemas.lean` | 88 | `thm:tri_topologique` | theoreme | langage | tri topologique | oui |
| `spec/Spec/C2/SixMetatheorySchemas.lean` | 111 | `thm:schema_restriction` | theoreme | langage | schéma de restriction | oui |
| `spec/Spec/C2/SixMetatheorySchemas.lean` | 150 | `thm:schema_reinvocation` | theoreme | langage | schéma de ré-invocation bornée | oui |
| `spec/Spec/C2/SixMetatheorySchemas.lean` | 188 | `thm:schema_effacement` | theoreme | langage | schéma d'effacement | oui |
| `spec/Spec/C2/SixMetatheorySchemas.lean` | 227 | `thm:lemme_capacite` | theoreme | langage | lemme de capacité | oui |
| `spec/Spec/C4/MemoryModels.lean` | 41 | `thm:surete_spatiale` | theoreme | langage | sûreté spatiale par capacités linéaires | oui |
| `spec/Spec/C4/MemoryModels.lean` | 99 | `thm:introduction_unique` | proposition | langage | loi unique d'introduction des ressources d'écriture | oui |
| `spec/Spec/C5/ElaborationTheorem.lean` | 30 | `thm:elaboration` | definition | langage | élaboration | oui |
| `spec/Spec/C2/RefinementSystem.lean` | 52 | `thm:raffinement` | theoreme | langage | structure de raffinement | oui |
| `spec/Spec/C2/RefinementSystem.lean` | 152 | `thm:non_interference` | theoreme | langage | non-interférence graduée, fragment séquentiel | oui |
| `spec/Spec/C2/RefinementSystem.lean` | 191 | `thm:determinisme_observationnel` | conjecture | langage | déterminisme observationnel | oui |
| `spec/Spec/C5/SpecialisedNotations.lean` | 126 | `thm:staticite_syntaxe` | theoreme | langage | staticité de la syntaxe | oui |
| `spec/Spec/C5/SpecialisedNotations.lean` | 217 | `thm:hygiene` | theoreme | langage | hygiène des expansions | oui |
| `spec/Spec/C5/SpecialisedNotations.lean` | 241 | `thm:hygiene_graduee` | proposition | langage | hygiène graduée des expansions | oui |
| `spec/Spec/C5/SpecialisedNotations.lean` | 261 | `thm:resucrage` | exigence | langage | préservation de l'α-équivalence de surface | non |
| `spec/Spec/C4/SystemScale.lean` | 118 | `thm:determinisme_rejeu` | theoreme | langage | déterminisme logique du rejeu | oui |
| `spec/Spec/C4/SystemScale.lean` | 144 | `thm:rejeu_binaire` | proposition | representation | identité binaire du rejeu, sous environnement reproductible | oui |
| `spec/Spec/C4/SystemScale.lean` | 320 | `thm:liberte_initialisation` | theoreme | langage | liberté d'initialisation par DAG topologique | oui |
| `spec/Spec/C4/SystemScale.lean` | 469 | `thm:sync_motifs_jonction` | theoreme | langage | synchronisation atomique des motifs de jonction | oui |
| `spec/Spec/C4/SystemScale.lean` | 548 | `thm:surete_ffi` | theoreme | langage | sûreté FFI par la passerelle de capacité | oui |
| `spec/Spec/C4/SystemScale.lean` | 575 | `thm:revocation_ffi` | exigence | representation | révocation à la frontière étrangère | non |
| `spec/Spec/C3/TypeGrammar.lean` | 123 | `thm:temps_mononiveau` | theoreme | langage | le cas mononiveau redonne la forme plate | oui |
| `spec/Spec/C3/GradedSystem.lean` | 130 | `thm:morphismes_modes` | proposition | langage | ordre structurel des modes | oui |
| `spec/Spec/C3/GradedSystem.lean` | 521 | `thm:completude_graduee` | proposition | langage | complétude graduée | oui |
| `spec/Spec/C3/GradedSystem.lean` | 555 | `thm:completude_verificateur` | exigence | compilation | le vérificateur n'émet que des codes de la correspondance | non |
| `spec/Spec/C3/TypingRules.lean` | 103 | `thm:boxtimes_addition` | theoreme | langage | $`\boxtimes` généralise l'addition ponctuelle | oui |
| `spec/Spec/C3/TypingRules.lean` | 386 | `thm:coherence_subsomption` | proposition | langage | cohérence de la subsomption | oui |
| `spec/Spec/C3/TypingRules.lean` | 726 | `thm:commutation_monoide` | theoreme | langage | commutation des deux familles | oui |
| `spec/Spec/C3/TypingRules.lean` | 1319 | `thm:determinisme_parallele` | theoreme | langage | déterminisme du parallélisme de couche 3 | oui |
| `spec/Spec/C3/TypingRules.lean` | 1605 | `thm:substitution` | proposition | langage | substitution sur trois niveaux | oui |
| `spec/Spec/C3/TypingRules.lean` | 1696 | `thm:substitution_simultanee` | theoreme | langage | substitution simultanée — corollaire de la substitution élémentaire | oui |
| `spec/Spec/C4/OperationalSemantics.lean` | 137 | `thm:preservation` | theoreme | langage | préservation | oui |
| `spec/Spec/C4/OperationalSemantics.lean` | 195 | `thm:progres` | theoreme | langage | progrès | oui |
| `spec/Spec/C4/OperationalSemantics.lean` | 290 | `thm:correction_ressource` | theoreme | langage | correction de ressource | oui |
| `spec/Spec/C4/OperationalSemantics.lean` | 393 | `thm:stratification_journal` | theoreme | langage | stratification du journal | oui |
| `spec/Spec/C4/OperationalSemantics.lean` | 535 | `thm:relation_produit` | proposition | langage | relation logique sur un produit de structures ordonnées | oui |
| `spec/Spec/C4/OperationalSemantics.lean` | 561 | `thm:lemme_fondamental` | theoreme | langage | lemme fondamental | oui |
| `spec/Spec/C4/OperationalSemantics.lean` | 717 | `thm:commutation_traduction` | theoreme | langage | commutation de la traduction et de la substitution | oui |
| `spec/Spec/C4/OperationalSemantics.lean` | 792 | `thm:image_fix` | theoreme | langage | image du point fixe déductif | oui |
| `spec/Spec/C4/ActorScale.lean` | 142 | `thm:isomorphisme_memoire` | proposition | representation | correspondances de disposition, transfert zéro-copie | oui |
| `spec/Spec/C5/WhatAMacroDeclares.lean` | 96 | `thm:expansion_macro` | theoreme | langage | la règle d'expansion est dérivable | oui |
| `spec/Spec/C3/ValueConstraints.lean` | 274 | `thm:deadlock_acyclique` | theoreme | langage | absence de deadlock par acyclicité du graphe de sessions | oui |
| `spec/Spec/C3/ValueConstraints.lean` | 350 | `thm:homomorphisme_roues` | proposition | representation | représentation des singularités de la théorie des roues | oui |
| `spec/Spec/C3/ValueConstraints.lean` | 384 | `thm:representation_inobservable` | exigence | representation | aucune liberté de représentation n'est observable | non |
| `spec/Spec/C6/WhatTheSolverReturns.lean` | 60 | `thm:interface_jugement` | definition | langage | l'interface d'une unité de compilation est son jugement | oui |
| `spec/Spec/C6/WhatTheSolverReturns.lean` | 132 | `thm:rejet_reproductible` | theoreme | langage | reproductibilité du rejet | oui |
| `spec/Spec/C6/WhatTheSolverReturns.lean` | 463 | `thm:abaissement_grades` | conjecture | compilation | l'abaissement préserve le jugement gradué | oui |
| `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | 132 | `thm:terminaison_couche_3` | theoreme | langage | terminaison de la couche 3 — l'instance inductive | oui |
| `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | 216 | `thm:sedimentation` | theoreme | langage | bonne définition de la sédimentation | oui |
| `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | 294 | `thm:productivite_couche_2` | theoreme | langage | productivité de la couche 2 — l'instance coinductive | oui |
| `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | 342 | `thm:progression_polarisee` | theoreme | langage | progression, paramétrée par la couche | oui |
| `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | 454 | `thm:loi_historique` | theoreme | langage | loi distributive de l'historique | oui |
| `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | 526 | `thm:troncature_comonade` | theoreme | langage | la troncature est un morphisme de comonades | oui |
| `spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean` | 576 | `thm:fenetre_grade` | proposition | langage | une fenêtre est un grade | oui |
| `spec/Spec/C4/UnderlyingProcessCalculus.lean` | 151 | `thm:traduction_metalangage` | proposition | langage | la traduction préserve le typage | oui |
| `spec/Spec/C4/UnderlyingProcessCalculus.lean` | 299 | `thm:simulation` | proposition | langage | simulation de la relation de réduction par la traduction | oui |
| `spec/Spec/C4/UnderlyingProcessCalculus.lean` | 340 | `thm:fidelite_interprete` | proposition | langage | fidélité de l'interpréteur de référence | oui |
| `spec/Spec/C6/CompilationProcess.lean` | 155 | `thm:stabilisation_pipeline` | theoreme | langage | stabilisation du pipeline | oui |
| `spec/Spec/C4/MetalanguageSortSystem.lean` | 187 | `thm:cloture_sortage` | theoreme | langage | clôture du bon sortage par substitution | oui |
| `spec/Spec/C4/MetalanguageSortSystem.lean` | 214 | `thm:confinement_sortes` | theoreme | langage | confinement des canaux distingués | oui |
| `spec/Spec/C2/AdjunctionsAndEnrichment.lean` | 234 | `thm:divulgation_delimitee` | proposition | langage | divulgation délimitée | oui |
| `spec/Spec/C2/AdjunctionsAndEnrichment.lean` | 381 | `thm:terminaison_lfp` | theoreme | langage | terminaison du point fixe déductif | oui |
| `spec/Spec/C2/ExponentialComonadAndFragments.lean` | 125 | `thm:distributivite_tronquee` | theoreme | langage | distributivité du produit sur la soustraction tronquée | oui |
| `spec/Spec/C2/ExponentialComonadAndFragments.lean` | 158 | `thm:coherence_axiome` | proposition | langage | condition de compatibilité de l'action graduée | oui |
| `spec/Spec/C2/ExponentialComonadAndFragments.lean` | 182 | `thm:coherence_usage` | proposition | langage | cohérence de l'action d'usage | oui |
| `spec/Spec/C2/ExponentialComonadAndFragments.lean` | 280 | `thm:action_parallele` | proposition | langage | compatibilité de l'itération et de la mise en parallèle | oui |
| `spec/Spec/C3/OpenStructuresEffectsAndMetatheory.lean` | 253 | `thm:preservation_type` | theoreme | langage | préservation du type | oui |

### 3. Classification sémantique encore requise

Les champs suivants **ne peuvent pas être déduits de façon fiable** du seul ancien `status` ou du titre. Ils restent à examiner occurrence par occurrence à partir du contenu intégral de l'énoncé et de ses dépendances :

- **Nature de l'objet** : résultat K7PL, définition, exigence, axiome/postulat, hypothèse locale, résultat de littérature, exemple/contre-exemple ou autre objet documentaire.
- **Rôle logique/expositif** : théorème, lemme, corollaire, proposition, conjecture, ou rôle différent selon l'ontologie ratifiée.
- **État épistémique** : proposé, en revue, étayé, établi, réfuté ou retiré. Les valeurs héritées ne sont pas automatiquement équivalentes à ces états.
- **Portée (`scope`)** : à déterminer séparément du `level` hérité.
- **Type d'appui** : argument textuel, esquisse de preuve, preuve rédigée complète, preuve Lean vérifiée, référence externe, ou absence d'appui explicite.
- **Hypothèses et dépendances** : prémisses locales, autres énoncés invoqués, références bibliographiques et éventuelle accroche vers `src/`.

Aucune de ces dimensions n'est remplie par inférence dans cet inventaire mécanique. La prochaine étape est une annotation sémantique contrôlée et vérifiée, puis une comparaison avec les compteurs, contrôles et rendus actuels. Le document ne doit pas être utilisé comme autorisation de migrer les énoncés.

### 4. Consommateurs à préserver

Le contrôle des dépendances a identifié au minimum les points suivants :

- `tools/SpecExt/Theorem.lean` : type interne `ThmInfo`, valeurs par défaut, rendu HTML/LaTeX, slot `proofsketch` et compteur partagé `theoreme`.
- `scripts/manuscript_metrics.py` : extraction textuelle des directives et calculs par statut/niveau, y compris la métrique des énoncés « ouverts ».
- `scripts/spec_checks/notation.py` : liste fermée des statuts/niveaux, exigence d'esquisse pour certains objets, interdiction d'esquisse sur les exigences et propagation des références d'énoncés ouverts.
- `scripts/spec_checks/structure.py` : préfixe `thm:`, unicité des labels et vérification des références.
- `scripts/spec_checks/statement_coverage.py` : couverture des énoncés par accroches vers les déclarations Lean et publication des métriques de couverture.

Cette liste est le minimum confirmé par inspection ; les références supplémentaires doivent être recherchées avant C8.2. Les règles existantes ne doivent pas être supprimées avant que leurs équivalents cibles soient testés.

### 5. Limites et contrôles de la présente étape

Ce document a été établi par rapprochement des résultats de recherche GitHub et de la lecture des fichiers sources listés. Il n'a pas encore été régénéré par un script exécuté dans l'environnement du dépôt. Avant de considérer C8.0 clos, il faut :

1. automatiser la génération du relevé depuis l'arbre de travail ;
2. vérifier que les nombres, labels, statuts, niveaux, lignes et slots concordent avec les sources ;
3. vérifier les chemins d'inclusion et rechercher les formes d'énoncés hors de `spec/Spec/**/*.lean` ;
4. faire valider la classification sémantique sans modifier les énoncés ;
5. consigner les exceptions et les dépendances non résolues.
