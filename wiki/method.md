<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Method

> **Provenance.**
> Consolidated 2026-10-25 from `docs/METHOD.md` and
> `docs/method/` (writing charter, project doctrine, Doctrine E,
> working protocol), on the wiki-consolidation branch.
> Status: living and canonical for the project's working method.
> This page states rules that are currently applicable. It does
> not transcribe the dated working journals those files also
> contain: anecdotes about a particular search, export failure
> or probe are evidence for how a rule was learned, not rules
> themselves, and they survive only in git history.
> Where a rule below conflicts with an open decision in
> [decisions](decisions.md), the decision page governs: this
> page does not decide anything by itself.

## What governs what

When a formalisation diverges from what the axiomatics
states, that is not a contradiction between two statements of
equal rank: it is a formalisation error, and the
formalisation is brought into conformity. An axiom moves
only on infeasibility. A formalisation embarrassment is not
infeasibility, and discomfort in writing is never paid for
on the foundations.

In order of prevalence: postulates, then axiom, then
demonstrations. Each level returns what it can return, and
none returns what belongs to another level.

## Sedimentation

Sedimentation is the project's method of reasoning, as
presented in the Prolegomena of the specification. It is
neither open nor closed as a method; only the graded
sedimentation theorem and its related constructions are
open. See [layers](layers.md) for that distinction, and do
not re-state it here as a second version.

## Parameterise, do not add

The working doctrine argues for a preference, not a
decided rule: when the choice is between adding a
structure and parameterising the structure already
held, parameterise. A parameter must be named
correctly, or the parameterised statement is more
obscure than the two it replaces. The grade is an
example of the preference, not an exception to it:
the grade is constructed with regard to the
postulates, not postulated, and it evolves as
research distils earlier theories. A new component
must justify itself before the postulates like any
construction; it is not an entitlement to add at
will.

Three specific applications of this rule — whether
non-commutativity is also carried on the context or only
as a grade parameter, whether termination and
productivity stay two theorems or become one theorem
parameterised by polarity, and whether a fibrille or
cofibrille is an added word or the named instance of a
parameterised regime — are recorded as open owner
decisions in [decisions](decisions.md). This page does
not close them, even though the working doctrine argues
for the parameterising direction in each case.

## Elide, do not restrict — and do not confuse the two

A component left unwritten takes its permissive value:
that is notation. A component carried by a smaller
algebra is a mode: that is structure. Elision is
adopted, under three conditions: one convention per
component; never elide the budget for a binding that
allocates, its permissive value being infinity and the
postulate on hidden cost forbidding it; and the
convention carried by the schema version, or the
postulate on tacit agreement would rest on an unwritten
agreement. Note: this elision rule, including the
budget ban, comes from a September 2026 arbitration;
its confirmation after the Verso migration is an open
point below, and the specification governs in the
meantime. Restriction in general is refused: opening
the mode lattice would make pointwise addition
undefined between modes, threaten the joins on which
subsumption coherence depends, and make link editing
depend on the mode. If a need appears, the way out is
a named mode with its morphism to the existing modes,
not an open lattice.

## Every commitment names its route

Every commitment names the route by which it will be
discharged, and there are only three routes:

- **Literature:** the statement is already established
  elsewhere; it carries its primary source, referenced
  and not re-demonstrated.
- **Demonstration:** it is not established elsewhere;
  it carries the name of the theorem that will
  discharge it.
- **Measurement:** it cannot be demonstrated at all —
  it is a statement about use or about a realisation;
  it carries the protocol that would settle it.

A commitment with no named route is not a commitment.
A fourth route would be a way of not choosing.

This rule is alive, not historical: it is checked by
`route_of_each_commitment()` in
`scripts/controles/notation.py`. One tension is left
open below: the rule names no route for a design
decision, which neither literature, demonstration
nor measurement can settle; design decisions have
their own status in [decisions](decisions.md).

## Artefact discipline

K7PL distinguishes specification, formalisation,
implementation, proof, test, documentation, and
assurance evidence. A result must be reported at the
level at which it has actually been established.

- **Specification changes.** The specification is not
  weakened merely to accommodate an implementation or
  proof failure. When formalisation exposes ambiguity,
  contradiction, missing premises, or an unprovable
  intended property, the issue is first classified. A
  specification change is an explicit scientific
  decision with traceability to affected commitments.
- **Formalisation.** A formalisation should identify
  the normative statement or semantic commitment that
  motivates it. A theorem without a defensible
  relation to a project claim remains a mathematical
  result, not automatic evidence for the language
  specification.
- **Proof.** Proofs must establish the stated
  proposition without silently weakening hypotheses
  or conclusions. The project does not use sorry,
  admit, newly introduced axioms, or native_decide as
  substitutes for missing proof obligations.
- **Tests.** Tests are executable evidence and should
  be traceable to the behaviour or property they
  check. Passing tests do not establish specification
  coherence beyond their tested scope.
- **Review.** Review is adversarial evidence. A
  review should distinguish confirmed defects,
  counterexamples, unresolved questions, plausible
  concerns, and recommendations. Absence of an
  identified objection is not itself a proof.

## Status vocabulary

See [HOME](HOME.md), "Status vocabulary": the bounded
statuses (ESTABLISHED, PARTIAL, UNDER REVIEW, IN
PROGRESS, OPEN, BLOCKED, NOT STARTED) are
claim- or workstream-level progress states, not
statement kinds or evidence types, and they do not
imply absolute correctness. This page does not
maintain a second copy of that vocabulary.

## Automation preference

Whenever a fact can be derived reproducibly from an
authoritative machine-readable source or a successful
build, test, proof, or static analysis, prefer
generating it automatically rather than maintaining a
manually edited duplicate. This applies particularly
to Lean and test counts, build and test results,
toolchain and dependency versions, generated
specification metrics, CI status, and release
metadata.

## Current versus historical material

A current document describes the state presently
claimed by the project. A historical document explains
a previous state, decision, or line of reasoning.
Historical material must not become normative merely
through accumulation or detail.

## Working with literature

Verification against the literature follows five
roles, adapted here from the former Org-mode protocol
to the current Verso workflow:

1. **Formal summary:** what a source establishes, not
   what it suggests. No comparison with K7PL at this
   stage.
2. **Comparison matrix:** each source statement
   confronted with a precise location in the project
   document, with a status of compatible, partly
   compatible, or incompatible; each incompatibility
   produces an issue.
3. **Contradiction journal:** one issue per
   divergence, with severity, location, cited
   evidence (not paraphrase), and proposed fix.
4. **Citation actions:** references in the project's
   format, with an explicit list of entries consulted
   without insertion, and the reason. An entry read
   and discarded must be said to be discarded.
5. **Synthesis:** concordance and divergence
   summaries, and an action plan ordered by severity.

A report ends with recursive verification: each
earlier conclusion the new material touches is said
to be confirmed, refined, or refuted. A cluster that
never refutes anything is suspect.

Invariants that survive the change of tooling:

- A derived correspondence table is never entered
  by hand.
- References are by named labels, never by numbers.
- Semantic probes — passage-to-expected-author pairs
  replayed at each pass — are kept, because formal
  controls pass on a false bibliography without them.
- No reference from the previous version disappears
  without a decision.
- Attribution is verified: a count of occurrences
  does not say which occurrence, and a probe can
  catch the following citation instead of the
  intended one.

## Verification discipline

Distilled from the September 2026 doctrine's fault
journal, without its anecdotes about a dead tooling
(Zotero, Org export):

- Search the whole record, not the titles; proper
  names (tool, assistant, language, author) are
  searched on the whole record. When there are two
  inventories, search both.
- Read what a probe returns. A count is not an
  answer, in either direction; homonyms mislead.
  Check the form of an inventory as soon as a
  result is too clean (all absent, all present, a
  round count): an extreme result signals a probe
  defect first, and the first evidence to look for
  is in the list of known defects.
- An empty field authorises no conclusion about
  the object, only about the data; look at the
  neighbouring fields. Sometimes re-exporting is
  better than probing better.
- When two sources designate the same thing and
  diverge from it, follow their cross-references.
  Before concluding that one chapter contradicts
  another, check that the shared word has the same
  referent in both places.
- A blind control is worse than no control: when
  a pattern is corrected somewhere, look for who
  else carries it; verify a control by counting
  the same object twice by two paths.
- A control never softens to pass; it is refined
  and then says more. Rewriting a failing control
  until it passes deletes data.
- No identifier written from memory: DOI, ISBN,
  arXiv identifier, code location, URL are verified
  against their source in the same pass.
- Before stating a rule, look for a dated decision
  on the same object: the decision file is a
  source, not a journal.
- A conjecture is not filed with findings: a
  separate "to verify" section, and "probably"
  protects nothing.
- Seek the mechanism, not the name, when the name
  is a common word; a source that classifies is
  worth ten probes.
- On structured text, split into blocks first,
  edit the block, rejoin; recount after any bulk
  edit; verify idempotence.

## What kind of question is this

Before assembling an arbitration file, classify the
question. A theory question is settled by a source.
An ergonomics question is settled by a measure. A
design question is settled by no source at all: it
is settled by decision. Check first whether the
doctrine already answers it; an over-argued
acquired point reads as an open question.

## Corpus constitution

A literature corpus is constituted explicitly:
criteria stated before collection, queries in
constrained blocks, a nominative prediction of two
or three works whose absence would signal a
malformed query, expected polysemies, and a report
of what was consulted without being taken. This
paragraph overlaps the research lot; whether it
belongs here or there is an open point below.

## Writing

Writing rules derived from the September 2026 charter,
whose measurements (755 paragraphs, 2,726 sentences;
median 28 words per sentence against a 15–25 target)
are a dated snapshot, not a current claim:

- Keep sentences short and paragraphs bounded; a
  long sentence is a mechanical fault to split, not
  a style to defend. As recommended targets, not
  norms: no sentence over 60 words, at most 10% of
  sentences over 40 words, no paragraph over 200
  words. The 9th decile at 35 words is a marker,
  not a compliance threshold: a 40–50 word sentence
  carrying a condition and a reservation resists
  shortening because its length holds what it
  states.
- The operative authority for writing today is
  `.claude/skills/writing-rules.md` (Verso style,
  compilation rules, metrics via
  `scripts/manuscript_metrics.py`). This page
  states durable principles; it does not become a
  second, competing style guide.
- One argument per paragraph; an announcement
  ("this will be shown") is not an argument.
- Prescriptive statements distinguish postulates,
  commitments, and obligations, and say which they
  are.
- Avoid metadiscourse tics ("it is better", "it is
  precisely", "deserves to be") that assert value
  instead of giving reasons.
- Rewriting proceeds in passes — long sentences,
  announcements, paragraphs, argument, prescriptive
  statements, then a spiral re-reading — not by
  editing everything at once.

## Open points

The following are not decided by this page; they
await an explicit owner decision:

- The three "parameterise" arbitrations of
  September 2026 (non-commutativity carried as a
  grade parameter, one polarity-parameterised
  theorem for termination and productivity, one
  name and parameter for fibrille and cofibrille):
  the doctrine presents them as decided in the
  parameterising direction, while
  [decisions](decisions.md) records them as
  explicitly left undecided. Both readings are
  cited there; this page does not close them.
- Scope of the three-routes rule for design
  decisions, which no route settles (see above).
- Confirmation of the elision rule, including
  the budget ban, after the Verso migration.
- Citations inside proofs: the old rule forbade
  them on Org grounds that are dead, and it sits
  in apparent tension with the current rule
  requiring a source for literature results.
  Not imported as a rule.
- Acronyms: glossary versus note, and the
  expansion of PIA, left unresolved by the
  charter. Aligned with the existing roadmap
  action to reintroduce, via the tools, a
  specification check verifying that every
  acronym used in `spec/` is declared in the
  glossary.
- Placement of corpus constitution: this page
  or the research lot.

## What was dropped in consolidation

- The dated measurements and the rewrite programme
  of the writing charter are not current rules; the
  rules above are what survives them.
- The doctrine's dated lesson journal (September
  2026 searches, export failures, probes and
  transport faults) is not transcribed: its durable
  rules are the prevalence order, parameterisation,
  elision, and the three routes above.
- The working protocol's Org-mode specifics (roles
  for Org tooling, Emacs export, Org source hygiene)
  are not carried over; its literature roles and
  invariants are, adapted to Verso.
- The former method files were written in French
  with their own dates. This English page records
  that fact rather than erasing it, and it does not
  decide, by itself, which of their rules remain
  current beyond the ones stated here.
