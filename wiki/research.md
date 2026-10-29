<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Research

> **Provenance — Lot 1 (pilot).**
> Consolidated 2026-10-25 from `docs/RESEARCH.md`, on `main` at
> `c56c84509812abe49cd716832f7ccdb750613036`.
> Status: living and canonical for the research problem, hypothesis,
> object, contributions, and validation strategy.
> The detailed working analyses formerly in `docs/research/` were
> closed file by file in the research closing of 2026-10-25 and are
> traced in the migration matrix: each file was integrated into the
> project or the wiki, moved to `theoretical-projects/k7os/`, or
> explicitly abandoned with a reason, and the directory is deleted.
> Nothing closed in that lot is promoted to a current research claim
> by being listed or summarised here. The core-vocabulary dossier
> is summarised in § "Current work: core vocabulary" from its
> 2026-10-25 files; it is explicitly non-normative, and its
> questionnaire survives as the working page
> [questions](questions.md).

## Research problem

The problem is not merely to implement another programming language.
It is to establish a development chain in which semantic and structural
commitments made by a language specification can be represented,
analysed, formalised, implemented, and verified without silently
changing their meaning between stages.

That problem combines four kinds of work that are usually kept apart:
language design, formal semantics, proof engineering, and scientific
traceability. K7PL's wager is that these can be held together in a
single project only if the specification is developed as a scientific
object — that is, only if its commitments are explicit, their
dependencies are traceable, and the evidence at each stage is related
back to the commitments it is supposed to support.

## Research hypothesis

A language specification can be developed as a scientific object when:

- its normative commitments are explicit;
- dependencies are traceable;
- formalisable content is represented in a proof assistant;
- implementation and testing evidence can be related back to those
  commitments.

The hypothesis is deliberately bounded. It is stronger than "the
implementation compiles", and weaker than a claim that the complete
language is already formally verified. Any reading of this project that
collapses that distinction — in either direction — misstates the
hypothesis.

## Scientific object

The object of study comprises, together:

- language concepts and their dependencies;
- the normative specification;
- its formal representation;
- properties selected for proof;
- the executable implementation;
- tests and counterexamples;
- the assurance argument connecting them.

No single element of that list is the object on its own. In particular,
a Lean theorem without a justified relation to a normative commitment
is a mathematical result, not automatic evidence for the language
specification; and an executable test is evidence about the behaviour
it exercised, not about the specification as a whole.

## Expected contributions

The project aims to contribute:

- a precise language design and specification;
- a formal account of selected properties;
- proof-oriented Lean representations;
- an executable implementation with an explicit relation to the formal
  model;
- a reproducible assurance process;
- a methodology for moving from specification claims to formal and
  executable evidence.

The exact scientific contribution claims remain subject to formal
review. They are aims, not established results, and this page does not
upgrade them.

## Validation strategy

Validation is multi-layered, and no layer substitutes for the others:

1. Specification review.
2. Formalisation analysis.
3. Lean proofs.
4. Executable tests.
5. Consistency audits.
6. Reproducibility through CI.

A successful proof, test, compilation, or review must not be
interpreted as establishing a stronger claim than the artefact
supports. See the invalid inferences listed in [HOME](HOME.md).

## Current limitations

The project remains under active specification review. Lean
infrastructure and executable tests must not be interpreted as
evidence that the complete normative specification has been formalised
or that implementation conformance is already proven. The assurance
case (to be consolidated in a later lot) records, among other gaps, the
incomplete specification coherence assessment, the absence of a
systematic specification-to-formalisation trace, and the undefined
implementation-conformance boundary.

## Open research questions

Open questions include:

- the characterisation of the mathematical foundations;
- the architecture of formal semantics;
- the completeness of the specification-to-formalisation
  correspondence;
- the properties for which implementation conformance can ultimately
  be established.

These are questions, not findings. Detailed research history,
including working analyses, research questions, and corpus notes, was
kept in `docs/research/` until the research closing of 2026-10-25
and now survives in git history, with its verdicts carried in
§ "Research lot closure" below and in [questions](questions.md).
That material is provenance and evidence; it does not become a current
research claim merely by being retained, and most of it is written in
French, with its own dates — a fact this English consolidation records
rather than erases.

Three questions from the former research-question register
(227 question headings, all but three marked done) were still
in review at its last state, and remain open here:

- whether every binding needs all four grade components
  (usage, mode, level, budget);
- whether the full grade should be a global algebra, a
  heterogeneous annotation, or an enriched comonadic index;
- whether modal subtyping across the linear, affine and
  unrestricted fragments is derivable from structure or must
  be axiomatised. The register's corrected October 2026
  conclusion is conditional: the literature defines a mode by
  a grade algebra, a contraction ideal and a weakening
  predicate, not by a grade interval, and the candidate
  separation of syntactic strata from structural modes does
  not yet establish that the judgement and rules realise
  those structures.

Not an open question in the same sense: the relevant mode
is not activated in the current grammar or generating
rules, and its exclusion is not a judgement that it is
useless — reopening it is a separate owner decision with
its own criteria, recorded in [decisions](decisions.md)
("Modes scope").

Two further open items come from the evening review of
2026-09-09, and are carried here rather than dropped
with the review files; neither has been re-verified
against the current specification. First, whether
integrable cones carry a graded exponential over the
resource structure — the one research question still
in progress in the former register. Second,
enrichment over preorders: at that date the only open
demonstrable commitment with no assigned theorem.
The vocabulary selection for the primitives, open
that same evening, is carried by the tracking lot,
not by this page.

The consolidated review of October 2026 adds
three open research items, none decided here.
First, positioning against the literature: no
differential comparison is given with Granule,
quantitative type theory (Atkey 2018), graded
dependent type theories (Moon, Eades and Orchard
2021; Abel, Danielsson and Eriksson 2023 — two
distinct entries in the current bibliography, not
to be conflated), or recent multi-level systems,
and K7PL's original supplement — four grade
coordinates, three-layer sedimentation,
automata, traceability — is not isolated. The
owner is to fill and validate a mechanism-by-
mechanism comparison table. Second, the formal
class of "pragmatic dependent types" (indices
excluded from resource tracking) is undefined:
whether that exclusion preserves the announced
guarantees is an open conjecture or result, not
an established fact. Third, a bibliographic
check remains open, with no change made to the
bibliography: the graded-system chapter cites a
general decidability, normalisation and grade-
preservation result, without distinguishing a
literature result from a result established for
K7PL, and that citation must be checked against
its primary source before any correction.

## Current work: core vocabulary

As of 2026-10-25, the active research workstream on `main` is the
core-vocabulary work: a non-normative, dated (2026-10-25) preparation
dossier that audits, inventories, and ontologises the vocabulary of
the kernel, with a closure plan and a decision register. Its stated
purpose is to determine the exact referent of each name, the level at
which it exists, and the obligations it carries, before comparing
designations — without masking the uncertainties that currently prevent
decisions.

Its discipline, which this wiki preserves, is to keep distinct:

- a fact of the current source (a form written in `spec/`);
- a ratified author decision (an explicit choice in the current
  register, with its scope);
- an established mathematical result;
- a formal proof state;
- a historical or bibliographic result;
- a design hypothesis;
- an open arbitration.

The dossier ratifies no lemma, token, or theoretical object, and it
modifies neither the grammar, nor the rules, nor the proofs, nor the
macros. Its open points include token-versus-lemma questions and
explicitly blocked decisions, and the distinction between current term
forms and open minimality claims. The nine commits between the audit
commit (`a3ac6af`) and the Lot 1 base (`c56c845`) belong to this
workstream and to the former history index; they are research
preparation, not a change to the normative specification. The
former history directory was closed on 2026-10-25, traced in
the migration matrix, and survives only in git history.

Nine vocabulary verdicts from the primitives register
(2026-10-08) are recorded here, in one sentence
each, as decided vocabulary facts, not as open
questions: the vector is derived as a type, not a
constructor; the terminal coalgebra is primitive
but lacks its two rules; the diamond and its three
forms are primitive (an earlier verdict was badly
carried over); the diamond elimination rule lacks
its constraint, whose repair costs one connector;
the deferred step requires a single modality;
declassification is primitive and the current
treatment is the right one; the deductive fixed
point is primitive (its exclusion rested on a
confusion); constructors without an entry are
eleven, not three; codereliction is set aside, for
a stronger reason than the one first sought. The
register's 45 open primitive questions are not
copied here: they stay in the living primitives
register until the minimality audit closes them.

Two related research briefs from the older index are also worth naming
at this level, without consolidating their content here: the k7os
research briefs (ten briefs on threat modelling, authority, compiler
correctness, information flow, concurrency, memory, real-time budgets,
failure recovery, OS comparisons, and model checking), now kept as a
non-normative theoretical project in
`theoretical-projects/k7os/` (renamed from `docs/research/k7pl-os/`
in the research closing of 2026-10-25; the proposed root name
`theoretical-projects/` is submitted for owner validation), and the
Lean compliance assurance workstream (issue #122, a bounded Lake →
SPDX demonstrator, with a conditional go for the demonstrator and an
explicit no-go for general production or legal compliance claims),
whose proposed decision and remaining conditions are itemised in
[decisions](decisions.md) and carried by the roadmap section "Work
the research lot follow-ups". Naming them here is an index, not an
endorsement of their conclusions; no k7os conclusion is copied into
this page or into `spec/`, and each delta of its provisional register
(SPEC-D-01 to SPEC-D-25) stays conditioned on an author decision and
on revalidation at the current head (see § "Research lot closure").

## Former research arcs

The former working system classified the bibliography by research
arc. That classification is the durable part of the old arc map
(`docs/archives/outillage-org/donnees/arcs.json`, deleted in the
archives closure); the key-by-key map itself is not carried over,
because the bibliography keys have since migrated to the structured
entries in `docs/bibliography/references.json`, and the old short
keys no longer resolve. The arcs were, in the old map's order:

- A — categories;
- B — types and proofs;
- C — automata;
- D — computation and complexity;
- E — graphs, orders and games;
- F — concurrency;
- G — syntax and legibility;
- H — history and feedback;
- I — compilation;
- J — effects and resources;
- K — verification and security;
- L — data and queries;
- M — probabilistic methods and learning.

This list is a historical taxonomy, not a current research claim:
it records how the former corpus was organised, and it does not
assert that any work under an arc is established.

## Research programmes decided, not realised

The material in this section is working material
from 2026-09-15, decided as a direction and not
realised. It is not integrated into the manuscript
and it is not promoted to a current claim. It is
recorded here so that closing the review files does
not silently abandon it.

### Concurrency programme

Direction decided 2026-09-15: layer 2 must become a
formalised concurrent language, not a cited target;
the earlier route that would have left it as a
citation is abandoned and must not be executed.
The programme extends that direction to layers 1
and 3. Six design decisions are to be settled
before any writing: channel as a value, with the
discipline carried by the grade; primitive
asynchrony, synchronous rendezvous derived
(emission non-blocking, reception blocking,
rendezvous as emission plus acknowledgement wait);
both channel and mailbox formers under one
semantics, with a channel-to-mailbox embedding
theorem; the mailbox graph imported with its
theorem rather than defined by hand, so that
acyclicity becomes a typing condition and absence
of deadlock its corollary; locality as a graded
modality, not a fifth grade component; cost as a
work-and-depth pair.

Five changes of nature follow, three of them deep.
The trace ceases to be a sequence and becomes a
labelled partial order, or else a scheduler is
written into the semantics; the theorems on traces
are re-stated, and the whole of annex E is
affected. Sequential non-interference does not
survive concurrency: the scheduler enters the
attacker model, and the correct notion becomes
observational determinism (or possibilistic
non-interference), so the non-interference
theorems change statement. The effect algebra
becomes a concurrent quantale with a second,
commutative composition and an exchange law, and
the cost becomes a work-and-depth pair per level.
The budget must say what it bounds — work, depth,
or both; the recommendation is both, subtraction
component-wise. Distribution introduces partial
failure, disciplined by affine sessions with
explicit cancellation and supervision, not typed
away. One invariant is preserved throughout: no
fourth place in the judgement — channels in
graded value, locality in modal coeffect,
parallelism in effect.

Fourteen new theorems are named provisionally, by
layer: for layer 3, the effect bimonoide,
determinism of Cartesian parallelism (the first
result to produce: short, true, without
dependency), work-and-depth compositionality,
depth invariance of vectorisation, and parallel
budget correctness; for layer 2, preservation
under concurrency, protocol fidelity, absence of
deadlock (imported, replacing the old deadlock
theorem), absence of waste, fidelity under
cancellation (typing timeout and circuit-breaker),
and observational determinism (the main cost,
replacing the sequential non-interference theorem
under concurrency); for layer 1, locality safety,
distribution closure (locality in coeffect,
network cost in effect, serialisability as a
refinement obligation, no fourth component), and
progress under failure.

Order in five stages: prerequisites first (no
extending an algebra that still has two
definitions); layer 3 alone as a coherent
deliverable; the layer 2 kernel; layer 2 safety;
layer 1; consolidation (three-stage physical
autonomy postulate, extended profile, renumbering,
commitment table). Stated risks, with fallbacks:
observational determinism may resist — fall back
to stating it under a named scheduling hypothesis,
not promising it without hypothesis; the
graded-times-mailbox combination may fail on a
missing greatest lower bound — test it at the
layer 2 stage on the three test cases below; the
partial-order trace may cost more than estimated
— fall back to a canonical scheduler, with
scheduler independence as a separate theorem;
distribution revives serialisation (fixing a
binary format, extending the representation
theorems to the network, enlarging the profile)
— record it in the obligation register; volume
and dilution — a longer document whose new pages
are below the standard of the others would be
worse than the current honest document.

What the programme does not do: it does not make
layer 2 deterministic (non-determinism journaled,
invisible at a level, replayable); no Byzantine
tolerance (frank stop only); no scheduler supplied
(fairness, priorities, starvation are named
implementation requirements); no dynamic placement
(localisation known at compilation).

### Mailboxes, graded cost, locality

Three claimed contributions, as working material,
not integrated into the manuscript:

- **Mailboxes times graded context.** The
  discipline "several senders, one receiver" as
  two grades on two capacities (send at ω,
  receive at 1, cancellable receive in [0..1]),
  absorbing quasi-linear typing into the grade
  lattice; mailbox as the dual of the arena.
- **Graded coeffects times work-and-depth cost.**
  Cost as a pair per level; sequential
  composition adds work and depth, parallel
  composition adds work and takes the maximum
  depth, branching takes maxima; the grade
  distributes over parallel composition; two
  parallel branches consume work additively and
  share the same deadline — "parallelising does
  not save budget". Limit stated by the study
  itself: depth is compositional only on the
  structured fragment; for the guard operation
  it depends on another process's emission date,
  so depth is defined outside guard first, then
  a delivery bound is paid into the profile.
- **Locality as a graded modality.** Grades as
  sets of locations, trivial scalar action,
  closure theorem; frank failure as subsumption
  (losing a location is passing to a smaller
  location set); move rules, with the constraint
  that moving requires the value's level to be
  below the network level, because the movement
  pattern (size, origin, date) is observable
  independently of encryption — outside that
  constraint, moving must go through
  declassification, so it depends on the spatial
  safety hypothesis.

### Guard, branching, and the third order

The most durable analysis of the three studies
concerns the guard operation. Its branching
operation (only one usage takes place) is
distinct from addition (both take place), is
defined everywhere, and needs a third order on
the resource structure — without it, the
extension would reproduce exactly the modal
subtyping defect. The branching operation is
sound on the affine and Cartesian fragments but
requires equality of contexts (or an explicit
discard) on the linear fragment, so the case
operation is unnecessarily strong in layers 2
and 3, where branching would suffice. The case
rule itself has a hole: it constrains no level,
so a case on a sum with a secret constructor
discloses without raising the level; a clause
bounding the branches' levels by the
constructor's level is to be added as a new
sub-point of the spatial-safety card. The
guard's effect is waiting plus the branches'
effects: waiting consumes depth but no work,
subtracted from the depth budget, not the work
budget. A finitude condition applies: the
supremum of branch effects assumes completeness
whose open question is a known proof debt —
safe while the branch set is finite, which is
true of every written pattern, but "to be
written as a condition, not assumed". Imposed
order: first, equality of contexts and the
level clause, without dependency; then the
branching operation, depending on the
obligation register and the grade definition.

Three test cases are to be executed before
writing: first, a mailbox with a tick and a
secret key, two branches, two levels — without
the level clause, a valid derivation discloses;
then unequal usage in the affine fragment
(failure under equality, success under
branching); then linear branching (confirming
that equality is required, else reopening the
heaviest proof debt).

## Refused factorisations

Seven fusions were examined and refused, each in
one sentence with its reason; two further
architectures, set aside by the manuscript
framework decision, are recorded here for the same
reason, because the card register asks for them to
be consigned here. A well-executed refusal looks
like an absence, so it is documented rather than
executed. The general lesson: resemblance of
notation never justifies a fusion; only shared
obligations do.

- Grade versus size index: the same objects, but
  different orders — a well-founded fragment is
  required for size.
- Usage comonad versus cofree comonad: two
  comonads, two roles.
- Wiring graph versus wait graph: the first
  inductive, finite and static; the second
  coinductive, unfolded as activations proceed.
- Two projections with opposite uses:
  conservative versus observational.
- Inductive versus coinductive sizes: one schema,
  two instances of different sorts — unifying the
  schema does not unify the object. An earlier
  unification error of this kind, from
  2026-09-09, is explicitly recognised.
- Three preservations with contrary nestings,
  none containing another.
- Algebraic effects versus scoped effects: a
  constant effect versus an effect that is a
  function of its argument's effect, with weak
  closure declared on the second.
- Five-layer minimal architecture: set aside by
  the ratified manuscript framework decision (see
  [decisions](decisions.md)).
- Fibred bimodal architecture: set aside by the
  same decision.

## Reading lot: research of 2026-10-26

Research asked by the author in the answers to the reading lot
(Q-LEX-002, Q-LEX-003, Q-LEX-006) and in the message of the same
day. Each paragraph separates what the source says from what this
page infers for K7PL; nothing here is a decision. The candidates
built from it are the second part of the reading lot in
[questions](questions.md).

### Strings in text-handling languages

Sources read on 2026-10-26.

- **SNOBOL4.** Literals are enclosed in apostrophes or double
  quotation marks; "the beginning and ending marks must be the
  same"; a literal may contain the other mark; "The null string is
  represented by two successive marks". No escape is described.
  Source: SNOBOL4 tutorial, chapter 1,
  https://www.regressive.org/snobol4/docs/burks/tutorial/ch1.htm.
- **Icon, as described by the Unicon reference.** Double quotes,
  escape sequences from a table, and "Incomplete string literals
  may be continued on the next line if the last character on a
  line is an underscore (_). In that case, the underscore, the
  newline, and any whitespace at the beginning of the next line
  are not part of the string literal." Source: Unicon Language
  Reference, Unicon Technical Report 8c, 2017, at
  `unicon.org/utr/utr8.pdf`, which the Unicon reports page
  (http://unicon.org/reports.html) still links to but which
  answers 404 since 2026-10-27; archived copy of 2025-12-01:
  http://web.archive.org/web/20251201152803/http://unicon.org/utr/utr8.pdf.
  The Icon reference itself was not checked.
- **Tcl.** Two groupings: double quotes, with substitutions, and
  braces, with "No substitutions" and braces that "nest within the
  word"; backslash sequences `\a \b \f \n \r \t \v \\ \ooo \xhh
  \uhhhh \Uhhhhhhhh`; for backslash-newline, "A single space
  character replaces the backslash, newline, and all spaces and
  tabs after the newline." Source: Tcl 8.6 manual page `Tcl`
  (rules 4, 6 and 9), its source in the Tcl repository,
  https://core.tcl-lang.org/tcl/doc/core-8-6-branch/doc/Tcl.n
  (www.tcl-lang.org timed out on 2026-10-27).
- **Emacs Lisp.** Double quotes; a backslash before a double quote
  or a backslash; "an escaped newline—one that is preceded by
  ‘\’—does not become part of the string"; "The newline character
  is not special in the read syntax for strings"; an escaped space
  is ignored too. Source: GNU Emacs Lisp Reference Manual, "Syntax
  for Strings",
  https://www.gnu.org/software/emacs/manual/html_node/elisp/Syntax-for-Strings.html.
- **TeX.** No string type: each input character is paired with one
  of 16 category codes, and the input processor forms character,
  control-sequence and parameter tokens from these pairs; verbatim
  text is obtained by changing category codes. Source: V. Eijkhout,
  *TeX by Topic*, chapter 2, "Category codes" (free edition, 2007).
- **SQL.** Single quotes; a quote inside is written twice
  (`'Dianne''s horse'`); "Two string constants that are only
  separated by whitespace with at least one newline are
  concatenated", which the PostgreSQL manual says is specified by
  SQL; `E'…'` backslash escapes and dollar quoting are PostgreSQL
  extensions. Source: PostgreSQL manual, "Lexical Structure",
  section 4.1.2,
  https://www.postgresql.org/docs/current/sql-syntax-lexical.html.
- **Raku.** A family of quoting forms: `Q` (or `｢…｣`) takes its
  content literally; `q` (`'…'`) processes backslash escapes
  without interpolation; `qq` (`"…"`) also interpolates variables
  and `{…}` blocks; adverbs combine these behaviours; any non-word
  character may delimit, bracket pairs nest; heredocs `q:to/END/`
  strip the terminator's indentation. The page says nothing about
  a backslash at the end of a line. Source: Raku documentation,
  "Quoting constructs", https://docs.raku.org/language/quoting.
- **TXR Lisp.** Not checked: the manual
  (https://www.nongnu.org/txr/txr-manpage.html) refused every
  connection from this session. A 2013 post by its author on the
  txr-users list says string literals are single-line and have no
  backslash-newline continuation
  (https://lists.nongnu.org/archive/html/txr-users/2013-07/msg00004.html);
  to verify against the current manual.

Inferred for K7PL, not decided: four separate questions come out of
this — how a quote or a control character is escaped (backslash,
doubling, none), what a line break inside a literal means (kept,
dropped after a mark such as `\` or `_`, forbidden), whether a
literal interpolates, and whether raw or heredoc forms exist. Tcl's
brace form cannot be borrowed as such: `{ }` opens layer 1 in K7PL.

### Glyphs and trains: BQN and Uiua

- **BQN.** "Otherwise, a single character forms a token. Only the
  specified set of characters can be used; others result in an
  error." Names are formed from letters, digits and `_`; their
  first character gives their role; numbers use `¯∞π0123456789`;
  a string doubles its double quote; `#` opens a comment. Source:
  BQN specification, "Tokens",
  https://mlochbaum.github.io/BQN/spec/token.html.
- **Uiua.** Primitives are glyphs; each can also be typed as its
  all-lowercase name, which the formatter replaces with the glyph;
  user-defined names need an uppercase letter. Source, secondary:
  APL Wiki, "Uiua" (the uiua.org pages returned 404 to this
  session).

Inferred for K7PL, not decided: the author's answer (glyphs are
macros composed in layer 3) leaves open how the reader cuts
`+´÷≠` — from a closed list of glyphs as in BQN, from Unicode symbol
categories, or from names that a formatter turns into glyphs as in
Uiua.

### Error codes and messages

- **K7PL.** The glossary defines a code as `ERR`, a three-letter
  segment naming the protected invariant, and an order number;
  annex A distinguishes three levels of message — signal, rule,
  knowledge — after Rasmussen.
- **Rust.** Codes `E` and four digits (`E0001` to `E0806`), each
  with its own explanation page in the error index. Source:
  https://doc.rust-lang.org/error_codes/error-index.html.
- **GHC.** Codes `[GHC-12345]`, emitted since GHC 9.6.1, documented
  in a community index of errors and warnings with summaries and,
  for some, examples. Source: https://errors.haskell.org/.
- **Parinfer 3.13.1.** Eight named errors, already listed in
  Q-LEX-006.
- **Translation.** rustc makes diagnostics translatable with
  Fluent resources (`.ftl`), one identifier per message; as of
  October 2024 that infrastructure "is waiting for a
  yet-to-be-proposed redesign". Source: rustc dev guide,
  "Translation",
  https://rustc-dev-guide.rust-lang.org/diagnostics/translation.html.
  Fluent presents itself as "A localization system for
  natural-sounding translations" in which "translations are
  asymmetric". Source: https://projectfluent.org/.

### Numbers and units

- **IEEE 754-2019** (named in chapter 3, not in the bibliography) defines binary
  and decimal floating-point interchange formats; the widths
  16, 32, 64 and 128 for binary and 32, 64 and 128 for decimal are
  the candidates for `flo` and `dec`.
- **UCUM**, version 2.2 (2024-06-17), "a code system intended to
  include all units of measures being contemporarily used in
  international science, engineering, and business", with SI and
  non-SI units and a case-insensitive variant of every symbol
  (degree Celsius: `Cel`, `CEL`). Source: https://ucum.org/ucum.

### Notations of the specification that are not K7PL

Found on 2026-10-26 in the inline code spans of `spec/Spec/`, math
spans excluded (heuristic scan: it may miss a span split across
lines). Two families. Type notations, in three incompatible styles
— application `Vector(n, T)`, angle brackets `WriteCap<T>`,
juxtaposition `Vec n T`:

- `Aff → Unr` — C3/GradedSystem.lean:133
- `Chan(p)` — C1/GerminalAxiomatics.lean:169
- `Dest T` — C3/GradedSystem.lean:444, C3/GradedSystem.lean:466
- `File(Closed)` — C3/ValueConstraints.lean:130
- `File(Open)` — C3/ValueConstraints.lean:130
- `Incomplete A B` — C2/AdjunctionsAndEnrichment.lean:60, C2/AlgebrasCoalgebrasAndFixedPoints.lean:54, C3/GradedSystem.lean:445, C3/GradedSystem.lean:466
- `Lin T` — AnnexA/CapabilitiesAndMemory.lean:36, C3/GradedSystem.lean:359
- `Lin → Aff` — C3/GradedSystem.lean:133
- `Lin → Unr` — C3/GradedSystem.lean:133
- `Lin(SessionEndpoint)` — C3/ValueConstraints.lean:304
- `Lin_k T` — C3/GradedSystem.lean:451
- `Range(0,k)` — C1/Postulates.lean:106
- `ReadCap<T>` — C3/GradedSystem.lean:394, C3/GradedSystem.lean:400
- `recv(Bool)` — C3/ValueConstraints.lean:147
- `Recv(T,P^⊥)` — C3/ValueConstraints.lean:158
- `Result(T, OutOfBounds)` — C3/ValueConstraints.lean:79
- `Result(T, OverflowError)` — C3/ValueConstraints.lean:454
- `Result<Float64, Singularity>` — AnnexA/ValueConstraintsAndResidualProofs.lean:42
- `send(Int)` — C3/ValueConstraints.lean:146
- `Send(Int, Recv(Bool, End))` — C3/ValueConstraints.lean:152
- `Send(T,P)` — C3/ValueConstraints.lean:158
- `SharedChan(p)` — C1/GerminalAxiomatics.lean:170, C1/GerminalAxiomatics.lean:182
- `TimeWindow(T, n, unit)` — C7/CaseStudyIIInteractiveDevelopmentAndLibrary.lean:53
- `Vec n T` — C2/AdjunctionsAndEnrichment.lean:83, C4/ActorScale.lean:159, C4/ActorScale.lean:173
- `Vector(n, T)` — C3/ValueConstraints.lean:71
- `Vector(n,T)` — C2/AdjunctionsAndEnrichment.lean:59, C6/CompilationProcess.lean:248
- `Wheel<T>` — C3/ValueConstraints.lean:363
- `WriteCap(Arena<T>, Range(0,k))` — C4/ActorScale.lean:109
- `WriteCap(Arena<T>, Range(k+1,2k))` — C4/ActorScale.lean:110
- `WriteCap(B)` — C4/SystemScale.lean:624, C4/SystemScale.lean:630, C4/SystemScale.lean:636
- `WriteCap(DOM)` — C7/CaseStudyINativeReactiveArchitecture.lean:69
- `WriteCap<T>` — C3/GradedSystem.lean:392
- `{x : T | p}` — C3/ValueConstraints.lean:85
- `λx. (f x) g (h x)` — C5/SpecialisedNotations.lean:45
- `λx. f(g(x))` — C5/SpecialisedNotations.lean:45

Metalanguage formulas written as code although they are
mathematics:

- `Adm(β, κ)` — C2/ExponentialComonadAndFragments.lean:241, C2/ExponentialComonadAndFragments.lean:243
- `Adm(β,κ(ε))` — C1/GerminalAxiomatics.lean:412
- `Adm(β,κ)` — C1/GerminalAxiomatics.lean:363
- `C(κ)` — C2/ExponentialComonadAndFragments.lean:294
- `Consume(β, κ)` — C2/ExponentialComonadAndFragments.lean:243
- `Consume(β,κ)` — C1/GerminalAxiomatics.lean:363
- `Cost_Budget(κ)` — C1/GerminalAxiomatics.lean:361, C1/GerminalAxiomatics.lean:363
- `Cost_Budget(κ) : ℕ∞` — C2/ExponentialComonadAndFragments.lean:241
- `Cost_Budget(κ) = max(W(κ), D(κ))` — C2/ExponentialComonadAndFragments.lean:239
- `Cost_Budget(κ) ≤ β` — C2/ExponentialComonadAndFragments.lean:241
- `Cost_Budget(κ)≤C(κ)` — C2/ExponentialComonadAndFragments.lean:296
- `max(W(κ),D(κ))` — C1/GerminalAxiomatics.lean:361
- `n(β ⊖ k)=nβ ⊖ nk` — C3/TypingRules.lean:994
- `R_cfg(Cₛ', P')` — C4/UnderlyingProcessCalculus.lean:320
- `Scale_Usage(1,Δ)=Δ` — C2/ExponentialComonadAndFragments.lean:478
- `Scale_Usage(\pi_U(r),\Delta')` — C3/TypingRules.lean:1633
- `Scale_Usage(a,Scale_Usage(b,Δ))=Scale_Usage(a·b,Δ)` — C2/ExponentialComonadAndFragments.lean:480
- `Scale_Usage(a,Δ₁+Δ₂)=Scale_Usage(a,Δ₁)+Scale_Usage(a,Δ₂)` — C2/ExponentialComonadAndFragments.lean:482
- `Scale_Usage(n,Δ₂)` — C3/TypingRules.lean:571
- `β ⊖ Cost_Budget(κ)` — C1/GerminalAxiomatics.lean:361, C1/GerminalAxiomatics.lean:392, C2/ExponentialComonadAndFragments.lean:243

Status on 2026-10-27, after the author's answers Q-TYP-001 (option C,
by role) and Q-TYP-002 (option A): the type notations of the theory
prose and the formulas of the metalanguage, together with the other
formulas of the same paragraphs, are math spans (160 occurrences,
commit "docs(spec): write metalanguage formulas and theory type
notations as math"). Still in code: the notations that stand for a
program (annex A, `Lin T` and `Result<Float64, Singularity>`; chapter
7, `TimeWindow(T, n, unit)` and `WriteCap(DOM)`), which wait for the
K7PL writing of types (Q-TYP-101 to Q-TYP-104); and the judgement
`Δ;Γ ⊢ C at d ▷ Δ';Γ'[m]` of chapter 3, which the notation check of
`scripts/spec_checks/notation.py` refuses in mathematics because Γ is
used as a zone of the judgement (Q-NOT-001).

## Reading lot: research of 2026-10-27

Material for the third part of the reading lot
([questions](questions.md)). Each claim carries its source; a source
marked *secondary* is an encyclopaedia or a blog, to be replaced by
the primary text before a claim enters `spec/`.

### Glyphs and names

- **Raku** allows in an ordinary identifier "embedded apostrophes `'`
  and/or hyphens `-`, provided that the next character is each time
  alphabetic" (`don't-do-that`). Source:
  https://docs.raku.org/language/syntax.
- **BQN**: "Word tokens are formed from the numeric characters
  `¯∞π0123456789`" and the alphabetic characters
  `_abc…xyzABC…XYZ`; an identifier begins with an alphabetic
  character, so no name holds `-`, and a negative number is written
  with the high minus `¯`. Source:
  https://mlochbaum.github.io/BQN/spec/token.html.
- **Chapter 1**, `tab:glyphes`: five of the 28 glyphs are ASCII
  (`+`, `-`, `=`, `<`, `>`), which meets the kebab-case names of
  Q-LEX-001 and the signed numbers of Q-LEX-002 (Q-LEX-201).

### Kinds and widths of numbers

- **IEEE 754-2019**: basic formats binary32, binary64, binary128,
  decimal64, decimal128; interchange formats binary16, binary256,
  decimal32, and any multiple of 32 bits. Source (*secondary*):
  https://en.wikipedia.org/wiki/IEEE_754.
- **Julia**: `Int8` to `Int128`, `UInt8` to `UInt128`, `Float16`,
  `Float32`, `Float64`, and the arbitrary-precision `BigInt` and
  `BigFloat`. Source:
  https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/.
- **Zig**: "arbitrary bit-width integers can be referenced by using an
  identifier of `i` or `u` followed by digits", up to 65535 bits.
  Source: https://ziglang.org/documentation/0.14.0/.
- **Ada**: modular types, whose arithmetic wraps around a modulus
  (RM 3.5.4); ordinary fixed point types, defined by a delta, and
  decimal fixed point types, defined by a delta that is a power of ten
  and a number of digits (RM 3.5.9). Sources:
  https://www.adaic.org/resources/add_content/standards/05aarm/html/AA-3-5-4.html,
  https://www.adaic.org/resources/add_content/standards/05aarm/html/AA-3-5-9.html
  (the 2022 manual at ada-auth.org answered 503 on 2026-10-26).
- **Scheme**: the numerical tower integer ⊂ rational ⊂ real ⊂
  complex, "every integer is a rational with an implicit denominator
  of 1", with exact and inexact numbers ("inexactness is a contagious
  property"). Source (*secondary*):
  https://en.wikipedia.org/wiki/Numerical_tower.
- **Small floats**: bfloat16, 8 exponent and 7 fraction bits; the
  8-bit formats E4M3 and E5M2, standardised by the OCP 8-bit Floating
  Point Specification (OFP8) revision 1.0, 2023, and by the OCP
  Microscaling (MX) specification 1.0. Source (*secondary*):
  https://en.wikipedia.org/wiki/Minifloat.
- **Posits**: "In March 2022, a standard was ratified and published by
  the Posit Working Group" (Standard for Posit Arithmetic, 2022), each
  posit width with a quire. Source (*secondary*):
  https://en.wikipedia.org/wiki/Unum_(number_format).
- **Intervals**: IEEE Std 1788-2015, Standard for Interval Arithmetic,
  and IEEE Std 1788.1-2017, a simplified subset. Source (*secondary*):
  https://en.wikipedia.org/wiki/Interval_arithmetic.
- **Exact reals**: the iRRAM, "a C++ package for error-free real
  arithmetic based on the concept of a Real-RAM". Source:
  https://irram.uni-trier.de/.
- **Exact algebraic numbers**: SageMath `QQbar` and its real subfield
  `AA`. Source:
  https://doc.sagemath.org/html/en/reference/number_fields/sage/rings/qqbar.html.
- **Quaternions and octonions**: Boost.Math class templates
  `quaternion` and `octonion`. Source (old documentation, Boost
  1.34.1): https://www.boost.org/doc/libs/1_34_1/doc/html/boost_math/octonions.html.
- **Fixed point notation**: in the Texas Instruments Q notation the
  sign bit is "not counted in the m parameter"; in the ARM variant
  "the m number also counts the sign bit"; a `U` prefix marks an
  unsigned format. Source (*secondary*):
  https://en.wikipedia.org/wiki/Q_(number_format).
- Hyperreal and surreal numbers are left out of Q-NUM-101: they are
  not computable in general, which Q-LEX-002 requires.

### Escapes, raw strings and heredocs

- **Rust**: quote escapes `\'` `\"`; ASCII escapes `\x41` (two hex
  digits, up to 0x7F), `\n`, `\r`, `\t`, `\\`, `\0`; the Unicode escape
  `\u{7FFF}` ("up to 6 hex digits", a Unicode scalar value). "Raw
  string literals do not process any escapes": `r"…"`, and `r#"…"#`
  with fewer than 256 `#`. Source:
  https://doc.rust-lang.org/reference/tokens.html.
- **Tcl**, rule 9: `\a` `\b` `\f` `\n` `\r` `\t` `\v` `\\`, `\ooo`,
  `\xhh`, `\uhhhh`, `\Uhhhhhhhh`; for any other character "the
  backslash is dropped and the following character is treated as an
  ordinary character"; a backslash, a newline and the following spaces
  or tabs are replaced by one space. Source:
  https://core.tcl-lang.org/tcl/doc/core-8-6-branch/doc/Tcl.n.
- **Raku**: "in the plain `Q` form, backslash escapes aren't allowed",
  and `｢…｣` is its shortcut; for heredocs, "If the terminator is
  indented, that amount of indention is removed from the string
  literals". Source: https://docs.raku.org/language/quoting.
- **Java** text blocks: `"""` followed by a line terminator; "the
  position of the closing `"""` characters does have an effect if
  placed on its own line". Source: https://openjdk.org/jeps/378.
- **C#** raw string literals: three or more double quotes; "Any
  whitespace to the left of the closing quotes is removed from all
  lines of the raw string literal". Source:
  https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/raw-string.
- **Swift**: multi-line literals strip the indentation of the closing
  delimiter (SE-0168); raw strings use `#"…"#` (SE-0200). Source
  (*secondary*, proposal discussions): https://www.swift.org/blog/behind-SE-0200.
- **Perl** 5.26: `<<~` removes the indentation of the terminator from
  every line. Source (*secondary*):
  https://www.effectiveperlprogramming.com/?p=2006.
- **Zig**: "Multiline string literals have no escapes and can span
  across multiple lines", each line starting with `\\`. Source:
  https://ziglang.org/documentation/0.14.0/.

### Identifiers left in the specification

Found on 2026-10-27 in the code spans of `spec/Spec/` (Q-SPEC-002):
snake_case primitives `hollow_alloc` (C3/GradedSystem.lean),
`alloc_range` (C4/MemoryModels.lean), `provenance_id`
(C6/WhatTheSolverReturns.lean); the law `coherence_usage`
(C2/ExponentialComonadAndFragments.lean); number types `Int`
(`lst:acteur`), `Float64` (annex A, `ERR-TYP-005`) and `Decimal128`
(C7/CaseStudyIIInteractiveDevelopmentAndLibrary.lean). The French
identifiers of the four listings of chapter 5 are rewritten with them
(Q-SPEC-001).

## Reading lot: research of 2026-10-27, fourth part

Material for the fourth part of the reading lot
([questions](questions.md)). Each claim carries its source; a source
marked *secondary* is an encyclopaedia or a blog, to be replaced by
the primary text before a claim enters `spec/`.

### Escapes and POSIX

- **POSIX File Format Notation**: the escape sequences `\\`, `\a`,
  `\b`, `\f`, `\n`, `\r`, `\t`, `\v`, each with its terminal action
  ("Move the printing position to the start of the next line" for
  `\n`). Source: POSIX.1-2024, XBD chapter 5,
  https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap05.html.
- **POSIX dollar-single-quotes** `$'…'`: `\"`, `\'`, `\\`, `\a`, `\b`,
  `\e`, `\f`, `\n`, `\r`, `\t`, `\v`, `\cX` (a control character),
  `\xXX` and `\ddd` (bytes, hexadecimal and octal); "The behavior of an
  unescaped <backslash> immediately followed by any other character,
  including <newline>, is unspecified." Source: POSIX.1-2024, Shell
  Command Language,
  https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html.

### Raw strings, paths and heredocs

- **Racket** here strings `#<<END`: the body ends before a line whose
  only content is the terminator; "No escape sequences are recognized".
  Source: https://docs.racket-lang.org/reference/reader.html.
- **Lua** long brackets: a long literal "starts with an opening long
  bracket of any level and ends at the first closing long bracket of
  the same level"; they "do not interpret any escape sequences"; a
  newline right after the opening bracket is dropped. Source:
  https://www.lua.org/manual/5.4/manual.html.
- **J** scripts, `0 : 0` (`noun define`): "the entry is terminated by a
  lone right parenthesis". Source:
  https://www.jsoftware.com/help/dictionary/dicth.htm.
- **LaTeX** `verbatim`: its content "cannot include the string
  `\end{verbatim}`"; "carriage returns and blanks are taken
  literally". Source: https://latexref.xyz/verbatim.html.
- **Python** triple quotes: "Unescaped newlines are also allowed and
  retained"; three unescaped quotes of the opening kind terminate the
  literal. Source:
  https://docs.python.org/3/reference/lexical_analysis.html.
- **Rebol** files: "The percent sign is necessary to prevent file names
  from being interpreted as words within the language"; "If backslashes
  are found they are converted to forward slashes"; a drive is written
  `%/C/docs/file.txt`; a name with spaces goes in quotes,
  `%"cool movie clip.mpg"`. Source:
  https://www.rebol.com/docs/core23/rebolcore-12.html.
- **Nix**: "A path literal must contain at least one slash to be
  recognised as such." Source:
  https://nix.dev/manual/nix/2.24/language/syntax.
- **Common Lisp**: "When a double-quote is encountered, characters are
  read from the input stream and accumulated until another double-quote
  is encountered"; a line break is one of those characters. Source:
  CLHS 2.4.5, https://www.lispworks.com/documentation/HyperSpec/Body/02_de.htm.

### Types: names, function types, polymorphism

- **Common Lisp**: the compound type specifier
  `(function [arg-typespec [value-typespec]])`, "used only for
  declaration and not for discrimination". Source:
  https://www.lispworks.com/documentation/HyperSpec/Body/t_fn.htm.
- **Typed Racket**: base types are capitalised, compound words joined by
  hyphens (`Integer`, `Exact-Rational`); function types are written
  `(-> …)`, the arguments first and the result last, as read from the
  examples of the page. Source:
  https://docs.racket-lang.org/ts-reference/type-ref.html.
- **Carp**: `(Fn [<arg-type1> <arg-type2> ...] <return-type>) ;;
  Function type`. Source:
  https://github.com/carp-lang/Carp/blob/master/docs/LanguageGuide.md.
- **Rust**: "A function pointer type, written using the fn keyword,
  refers to a function whose identity is not necessarily known at
  compile-time." Source:
  https://doc.rust-lang.org/reference/types/function-pointer.html.
- **MLton**: "Monomorphisation eliminates polymorphic values and
  datatype declarations by duplicating them for each type at which they
  are used." Source:
  https://github.com/MLton/mlton/blob/master/doc/guide/src/Monomorphise.adoc.
- **rustc**: the `type_length_limit` attribute "sets the maximum number
  of type substitutions allowed when constructing a concrete type during
  monomorphization" (https://doc.rust-lang.org/reference/attributes/limits.html);
  an unbounded chain of instances fails with "reached the recursion
  limit while instantiating"
  (https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_monomorphize/messages.ftl).

### Empty and doubled delimiters, ranges

Added on 2026-10-27 at the author's request (Q-LEX-301 to
Q-LEX-304).

- **In the specification**: chapter 3 writes, in mathematics, the
  unit value `()` and the vector literal `[v₀, …, vₙ₋₁]`
  (`eq:grammaire-termes`); chapter 2 writes `⟦·⟧` for a translation;
  the listings of chapter 5 open a match clause with `((Ok new-value) …)`.
  The author's grammar repeats contents zero or more times, and
  `lexicon/syntax/layers.k` reads empty pairs.
- **Category theory**: a terminal object "may also be viewed as a
  limit over the empty diagram". Source:
  https://ncatlab.org/nlab/show/terminal+object.
- **Common Lisp**: `()` is "an alternative notation for writing the
  symbol nil, used to emphasize the use of nil as an empty list"
  (https://www.lispworks.com/documentation/HyperSpec/Body/26_glo_9.htm);
  "A lambda form is similar to a function form, except that the
  function name is replaced by a lambda expression"
  (https://www.lispworks.com/documentation/HyperSpec/Body/03_ababd.htm).
- **Scheme**: "In many dialects of Lisp, the empty list, (), is a
  legitimate expression evaluating to itself. In Scheme, it is an
  error"; the operator of a call is any expression,
  `((if #f + *) 3 4)` gives 12. Source: R7RS, §4.1.3,
  https://small.r7rs.org/attachment/r7rs.pdf.
- **Clojure**: "An empty list () evaluates to an empty list." Source:
  https://clojure.org/reference/evaluation.
- **Rust**: the tuple type with no fields "is often called unit"
  (https://doc.rust-lang.org/reference/types/tuple.html); "When a block
  does not contain a final operand and the block does not diverge, the
  block has unit type and unit value"
  (https://doc.rust-lang.org/reference/expressions/block-expr.html);
  range expressions `a..b`, `a..=b`, `a..`
  (https://doc.rust-lang.org/reference/expressions/range-expr.html);
  `{` is escaped as `{{` in format strings
  (https://doc.rust-lang.org/std/fmt/index.html).
- **Haskell**: "The unit datatype () has one non-⊥ member, the nullary
  constructor ()"
  (https://www.haskell.org/onlinereport/haskell2010/haskellch6.html);
  arithmetic sequences `[e1, e2 .. e3]` and `[e1 ..]`
  (https://www.haskell.org/onlinereport/haskell2010/haskellch3.html).
- **Python**: `()` an empty tuple, `[]` an empty list, `{}` an empty
  dictionary. Source: https://docs.python.org/3/reference/expressions.html.
- **Bash**: `((expression))` evaluates an arithmetic expression,
  `[[ expression ]]` a conditional expression. Source:
  https://man7.org/linux/man-pages/man1/bash.1.html.
- **C++**: attributes are written `[[ … ]]`. Source:
  https://eel.is/c++draft/dcl.attr.grammar.
- **Org mode**: links are written `[[LINK]]` and
  `[[LINK][DESCRIPTION]]`. Source:
  https://orgmode.org/manual/Link-Format.html.
- **Agda**: "Instance arguments are enclosed in double curly braces
  {{ }}". Source:
  https://agda.readthedocs.io/en/latest/language/instance-arguments.html.
  **Lean 4** reads `{{x : Nat}}` as the strict implicit binder
  `⦃x : Nat⦄`: checked on 2026-10-27 with Lean 4.34.0, the toolchain
  of this repository (`#check @f` prints `f : ⦃x : Nat⦄ → …`).
- **Mustache**: "A {{name}} tag in a basic template will try to find
  the name key in the current context". Source:
  https://mustache.github.io/mustache.5.html.
- **Ada**: "A range has a lower bound and an upper bound and specifies
  a subset of the values of some scalar type (the type of the range)"
  (https://www.adaic.org/resources/add_content/standards/22rm/html/RM-3-5.html);
  "Discrete types are either integer types or are defined by enumeration
  of their values (enumeration types)"
  (https://www.adaic.org/resources/add_content/standards/22rm/html/RM-3-2.html),
  as `type Color is (White, Red, Yellow, Green, Blue, Brown, Black);`
  (https://www.adaic.org/resources/add_content/standards/22rm/html/RM-3-5-1.html).
  Ada 2022 reference manual, on the AdaIC mirror; ada-auth.org refused
  connections from the CI runner on 2026-10-27.
- **Raku**: ranges use "two dots, and optionally a caret which
  indicates that the endpoint marked with it is excluded". Source:
  https://docs.raku.org/type/Range.
- **Ruby**: `Range.new(2, 5).to_a # => [2, 3, 4, 5]`;
  `Range.new(2, 5, true).to_a # => [2, 3, 4]`. Source:
  https://docs.ruby-lang.org/en/master/Range.html.
- **Unicode** writes ranges with two dots: "0000..007F; Basic Latin".
  Source: https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt.
- **POSIX** regular expressions: character classes such as `[:alpha:]`
  are written inside a bracket expression, hence `[[:alpha:]]`.
  Source: https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap09.html.
- **BQN**: Range `↕` "creates arrays of indices"; given a list of
  numbers "it returns an array of index lists". Source:
  https://mlochbaum.github.io/BQN/doc/range.html. In K7PL's
  `tab:glyphes`, `↕` is `windows`.
- **French mathematics**: an interval of integers is sometimes written
  with white brackets, `⟦−5, 3⟧`. Source (*secondary*):
  https://fr.wikipedia.org/wiki/Intervalle_(math%C3%A9matiques).

### The bind of monads

- **Rust** `Option::and_then`: "Returns `None` if the option is `None`,
  otherwise calls `f` with the wrapped value and returns the result";
  "Some languages call this operation flatmap." Source:
  https://doc.rust-lang.org/std/option/enum.Option.html.

## Reading lot: research of 2026-10-27, fifth part

Material for the fifth part of the reading lot
([questions](questions.md)), opened by the answers to the fourth part.
Each claim carries its source, read on 2026-10-27; quotations are
verbatim. What is inferred for K7PL is marked as such and decides
nothing.

### Escapes: other traditions

- **Doubling.** Ada: `string_element ::= "" |
  non_quotation_mark_graphic_character`; "A string_element is either a
  pair of quotation marks (""), or a single graphic_character other
  than a quotation mark."
  (https://www.adaic.org/resources/add_content/standards/22rm/html/RM-2-6.html).
  BQN: "Pairs of quotes `""` in between represent one quote character,
  and other characters (including `'`) represent themselves"
  (https://mlochbaum.github.io/BQN/doc/syntax.html); "the character
  with code point `n` is `@+n`"
  (https://mlochbaum.github.io/BQN/doc/arithmetic.html).
- **One escape.** Common Lisp: "If a single escape character is seen,
  the single escape character is discarded, the next character is
  accumulated, and accumulation continues."
  (https://www.lispworks.com/documentation/HyperSpec/Body/02_de.htm).
- **Names.** Python: `\N{name}`, "Named Unicode character"
  (https://docs.python.org/3/reference/lexical_analysis.html). Haskell
  2010, §2.6: escapes by ASCII names (`\NUL` … `\DEL`), `\^A`,
  decimal, octal and hexadecimal; "The escape character `\&` is
  provided as a “null character” to allow strings such as `"\137\&9"`
  and `"\SO\&H"` to be constructed"; a "gap", "two backslants
  enclosing white characters", is ignored
  (https://www.haskell.org/onlinereport/haskell2010/haskellch2.html).
- **Terminated numbers.** XML 1.0: `CharRef ::= '&#' [0-9]+ ';' |
  '&#x' [0-9a-fA-F]+ ';'`; `&` and `<` "MUST be escaped using either
  numeric character references or the strings "&amp;" and "&lt;""
  (https://www.w3.org/TR/xml/, §2.4 and §4.1). R7RS §6.7:
  `\x<hex scalar value>;`, "specified character (note the terminating
  semi-colon)" (https://small.r7rs.org/attachment/r7rs.pdf).
- **JSON.** "All Unicode characters may be placed within the quotation
  marks, except for the characters that MUST be escaped: quotation
  mark, reverse solidus, and the control characters (U+0000 through
  U+001F)." (https://www.rfc-editor.org/rfc/rfc8259#section-7).
- **Percent-encoding.** "A percent-encoded octet is encoded as a
  character triplet, consisting of the percent character "%" followed
  by the two hexadecimal digits representing that octet's numeric
  value." (https://www.rfc-editor.org/rfc/rfc3986#section-2.1).

Inferred for K7PL, not decided: doubling the quote and opening a raw
string with two quotes (Q-STR-104) cannot both hold; a semicolon that
ends a number meets the semicolons that mark comments and disabled
trees outside strings.

### Strings of several quotes

- **CommonMark**: "A backtick string is a string of one or more
  backtick characters (`) that is neither preceded nor followed by a
  backtick. A code span begins with a backtick string and ends with a
  backtick string of equal length."; one leading and one trailing space
  are removed when both are present
  (https://spec.commonmark.org/0.31.2/#code-spans).
- **C#**: "A raw string literal starts and ends with a minimum of three
  double quote (") characters"; "When your string literal contains
  three consecutive double-quotes, you start and end the raw string
  literal with four double quote characters"; "The raw string
  literal's content must not contain a set of contiguous " characters
  whose length is equal to or greater than the raw string literal
  delimiter length."
  (https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/raw-string).
- **OCaml**: "Quoted strings are delimited by a matching pair of
  `{ quoted-string-id |` and `| quoted-string-id }` with the same
  quoted-string-id on both sides" (https://ocaml.org/manual/5.2/lex.html).
- **Go**: raw strings between back quotes; "Within the quotes, any
  character may appear except back quote."
  (https://go.dev/ref/spec#String_literals).

### Monomorphisation

- **Chapter 6** (`CompilationProcess.lean`, `WhatTheSolverReturns.lean`):
  Phase 3 monomorphises each generic call into a concrete copy, once;
  monomorphisation is type-directed inlining and decrements the budget
  of specialisation, a grade of the unit of compilation shared with
  inlining, whose exhaustion "arrête la duplication au lieu d'échouer";
  Phase 4 generalises only row variables in layer 2; the budget is
  written in the source; handlers compile by capability passing; the
  unit of specialisation of defunctionalisation is left to decide.
  Annex A: `ERR-POL-001` refuses dynamic dispatch and virtual tables.
- **MLton**: "The monomorphiser works by making one pass over the
  entire program", with "a cache for each variable declared in a
  polymorphic declaration that maps a lists of type arguments to a new
  variable name"; finite instances "due to the absence of polymorphic
  recursion in SML"; unused constructors must be dropped "in order for
  the translation to terminate"
  (https://github.com/MLton/mlton/blob/master/doc/guide/src/Monomorphise.adoc).
  "Whole-program compilation is an integral part of the design of
  MLton and is not likely to change."
  (https://github.com/MLton/mlton/blob/master/doc/guide/src/WholeProgramOptimization.adoc).
- **rustc**: the collector builds the mono item graph from roots,
  "the public non-generic syntactic items", and follows uses "until no
  more new nodes are found"; "A generic definition in crate X might
  produce monomorphizations that are compiled into crate Y"; lazy and
  eager strategies
  (https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_monomorphize/src/collector.rs).
  "Rust takes a different approach: it monomorphizes all generic
  types." (https://rustc-dev-guide.rust-lang.org/backend/monomorph.html).
  `recursion_limit` defaults to 128; `type_length_limit` bounds "the
  maximum number of type substitutions allowed when constructing a
  concrete type during monomorphization"
  (https://doc.rust-lang.org/reference/attributes/limits.html).
- **C++**: an "implementation-defined quantity that specifies the
  limit on the total depth of recursive instantiations"; "The result of
  an infinite recursion in instantiation is undefined"
  (https://eel.is/c++draft/temp.inst).
- **Zig**: "Compile-time parameters is how Zig implements generics. It
  is compile-time duck typing." (https://ziglang.org/documentation/0.14.0/).
- **Shared code.** Go 1.18: "a single chunk of assembly for each unique
  GC shape", each taking a dictionary
  (https://github.com/golang/proposal/blob/master/design/generics-implementation-gcshape.md).
  .NET: one specialised type per value type; for reference types "the
  runtime reuses the previously created specialized version"
  (https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/generics-in-the-run-time).
  Swift specialises only "If the generic function's definition is
  visible to the optimizer and the concrete type is known"
  (https://github.com/swiftlang/swift/blob/main/docs/OptimizationTips.rst).
  GHC's `SPECIALIZE` asks "that GHC create a copy of a function with
  specific arguments; most commonly, a copy of an overloaded function
  with specific class dictionary arguments"
  (https://downloads.haskell.org/ghc/latest/docs/users_guide/exts/pragmas.html).
- **Function arguments.** Lean's `@[specialize]` is "in particular
  useful for functions that take other functions as parameters"
  (https://github.com/leanprover/lean4/blob/v4.34.0/src/Lean/Compiler/Specialize.lean).
  Julia "avoids automatically specializing on argument type parameters
  in three specific cases: Type, Function, and Vararg"
  (https://docs.julialang.org/en/v1/manual/performance-tips/).

Inferred for K7PL, not decided: `ERR-POL-001` places K7PL in the
family that copies (MLton, rustc, C++, Zig) and outside the one that
shares code (Go, .NET, Swift, GHC); a monomorphisation stopped by an
exhausted budget leaves no code to call, unlike an inlining. The
mechanism put to the author (Q-TYP-301) combines rustc's collection,
MLton's table, chapter 6's hash addressing and budget, and a refusal
of growing instance chains.

### Branchings

- **Chapter 3**: the term grammar (`eq:grammaire-termes`) holds
  `return`, `let x ← c in c`, `thunk`, `force`, `box_r`, `unbox`,
  `always`, `now`, `next`, `delay`, `wait`, `when`, `at_n`,
  `move_{n→m}`, `operation_ε`, `scoped_f`, `try … catch`, `out` and
  copatterns, `free`, `slice`, `declassify_ℓ`; its types, `F_ε`,
  `U_ε`, `!_r`, `□`, `◇`, `◯`, `@_n`, `μ`, `ν`, `Arena`, `Cap`.
- **Haskell**: the laws of `Monad` start with `return a >>= k = k a`
  (https://hackage.haskell.org/package/base/docs/Control-Monad.html);
  a comonad has `extract`, `duplicate` and `extend`
  (https://hackage.haskell.org/package/comonad/docs/Control-Comonad.html).
- **CLOS**: "An auxiliary method is a method whose qualifier is
  :before, :after, or :around"; "All the before methods are called, in
  most-specific-first order. Their values are ignored."; "All the after
  methods are called in most-specific-last order."
  (https://www.lispworks.com/documentation/HyperSpec/Body/07_ffb.htm).

### Definitions and envelopes

- **Racket**: "The first form binds id to the result of expr, and the
  second form binds id to a procedure."
  (https://docs.racket-lang.org/reference/define.html).
- **Clojure**: `defn` is a macro, "Same as (def name (fn [params* ]
  exprs*)) […] with any doc-string or attrs added to the var metadata"
  (https://clojure.github.io/clojure/clojure.core-api.html).
- **Common Lisp**: `defun` "Defines a new function named function-name
  in the global environment."
  (https://www.lispworks.com/documentation/HyperSpec/Body/m_defun.htm).

### Codes of warnings

- **GHC** "started emiting a code with the format [GHC-12345] for its
  messages in version 9.6.1"; the index covers "both errors and
  warnings" (https://errors.haskell.org/).
- **C#**: errors such as "CS0029"
  (https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-messages/)
  and "Compiler Warning (level 3) CS0168"
  (https://learn.microsoft.com/en-us/dotnet/csharp/misc/cs0168).
- **rustc**: "lints are divided into six levels: allow expect warn
  force-warn deny forbid" (https://doc.rust-lang.org/rustc/lints/levels.html).

### White brackets: meanings and spacing

- **Ranks and arrays.** J: "The verb u"n applies u to each cell as
  specified by the rank n" (https://www.jsoftware.com/help/dictionary/d600v.htm).
- **Lists on demand.** Clojure's `lazy-seq` "yields a Seqable object
  that will invoke the body only the first time seq is called, and will
  cache the result" (https://clojure.github.io/clojure/clojure.core-api.html).
- **Idiom brackets.** McBride and Paterson write `⟦f u₁ … uₙ⟧`,
  "indicating a shift into the idiom of an Applicative functor, where a
  pure function is applied to a sequence of effectful arguments"
  (https://www.staff.city.ac.uk/~ross/papers/Applicative.pdf, p. 4;
  the brackets were checked on the rendered page). Idris: "`[| f a1
  …an |]` is translated into `pure f <*> a1 <*> … <*> an`"
  (https://docs.idris-lang.org/en/latest/tutorial/interfaces.html).
- **Allocators.** Zig: "by convention, there is no default allocator
  in Zig. Instead, functions which need to allocate accept an Allocator
  parameter" (https://ziglang.org/documentation/0.14.0/). C++: "The
  memory_resource class is an abstract interface to an unbounded set of
  classes encapsulating memory resources." (https://eel.is/c++draft/mem.res).
  Rust's `Vec::with_capacity_in` is a "nightly-only experimental API"
  (https://doc.rust-lang.org/std/vec/struct.Vec.html).
- **Instance arguments.** Agda: "Instance arguments are enclosed in
  double curly braces {{ }}, e.g. {{x : T}}. Alternatively they can be
  enclosed, with proper spacing, e.g. ⦃ x : T ⦄, in the unicode braces
  ⦃ ⦄"; they are found when "a unique instance of the required type can
  be built from declared instances and the current context"
  (https://agda.readthedocs.io/en/latest/language/instance-arguments.html).
- **K, checked on 2026-10-27 with K 7.1.337** (scratch grammar, not in
  the repository): K refuses non-ASCII characters inside a negated
  character class or a range, so the symbol class cannot exclude white
  brackets; `⟦ x ⟧` reads as a pair; a token with priority made of
  symbol characters around a white bracket catches `⟦x⟧` and `a⟦b`,
  while `a≠b⊏c` stays a symbol and `⟦ a≠b [c] ⟦ x ⟧ ⟧` reads as nested
  pairs.

### Names that link statements, K and proofs

Added on 2026-10-27 at the author's request (Q-TRC-001 to Q-TRC-003).

- **In the repository**, counted on 2026-10-27: 234 labels in
  `spec/Spec/` (77 `thm`, 52 `sec`, 51 `eq`, 31 `tab`, 12 `fig`, 8
  `lst`, 3 `req`, 1 `def`), with French slugs, and 594 `{num …}`
  references. A label is registered for cross-references and rendered
  as an anchor (`#lbl-lst-gestionnaire`); the displayed text is the
  number. Page addresses come from section tags. The statement
  extension (`tools/SpecExt/Theorem.lean`) has `formalArtifact`,
  required with `evidence := "lean-proof"`; no statement uses it (64
  `proofsketch`, 12 `none`, 1 `literature`), and
  `scripts/spec_checks/statement_ontology.py` checks it syntactically
  only. The 101 theorems of `src/` and `proofs/` are named in English.
  `Spec` and `K7pl` are libraries of the same Lake package.
- **Verso** v4.34.0: the `{name}` role resolves a Lean constant with
  `realizeGlobalConstNoOverloadWithInfo` and logs an error when it does
  not exist
  (https://github.com/leanprover/verso/blob/v4.34.0/src/verso-manual/VersoManual/InlineLean.lean,
  read in the repository's Lake package).
- **Lean blueprint**: "`\lean` that lists the Lean declaration names
  corresponding to the surrounding definition or statement (including
  namespaces)"; "`\leanok` which claims the surrounding environment is
  fully formalized"; "`\uses` that lists LaTeX labels that are used in
  the surrounding environment. This information is used to create the
  dependency graph"; "`leanblueprint checkdecls` to check that every
  Lean declaration name that appear in the blueprint exist in the
  project" (https://github.com/PatrickMassot/leanblueprint).
- **Mathlib**: "Terms of Props (e.g. proofs, theorem names) use
  snake_case. Props and Types (or Sort) (inductive types, structures,
  classes) are in UpperCamelCase."
  (https://leanprover-community.github.io/contribute/naming.html).

Inferred for K7PL, not decided: a shared name makes the link readable
but checks nothing; a statement about the whole calculus has no single
element to share a name with; the existing `formalArtifact` field and
Verso's name resolution make a checked link possible without a new
tool.

### Conversation of 2026-10-27

Sources read during the conversation that followed the opening of the
fifth part; its decisions are in [decisions](decisions.md). They feed
the revised fifth part.

- **Qualified delimiters.** OCaml: `{%sql|...|}` stands for
  `[%sql{|...|}]`; « Note that the word-delimited form, for example
  {sql|...|sql}, should not be used for signaling that an extension
  is in use. Indeed, the user cannot see from the code whether this
  string literal has different semantics than they expect. Moreover,
  giving semantics to a specific delimiter limits the freedom to
  change the delimiter to avoid escaping issues. »
  (https://ocaml.org/manual/5.2/extensionnodes.html). Haskell: « A
  quasi-quote has the form [quoter| string |]. The ⟨quoter⟩ must be
  the name of an imported quoter […] There must be no spaces in the
  token [quoter|. » (https://downloads.haskell.org/ghc/latest/docs/users_guide/exts/template_haskell.html).
  Julia: « A non-standard string literal looks like a regular
  double-quoted string literal, but is immediately prefixed by an
  identifier »; « Users and packages may also define new non-standard
  string literals » (https://docs.julialang.org/en/v1/manual/strings/).
  Scribble: « A block of text can begin with a “|{” and terminated
  accordingly with a “}|” »; « punctuation characters can be added
  between the | and the braces […] used as a “here string”
  replacement » (https://docs.racket-lang.org/scribble/reader.html).
- **Dimensions by repetition.** Julia: « The number of semicolons in
  the separator specifies the particular dimension, so ;;;
  concatenates in the third dimension, ;;;; in the 4th, and so on. »
  (https://docs.julialang.org/en/v1/manual/arrays/). Chapter 5: « La
  barre verticale sépare les rangs d'un littéral tableau : `[1 2 | 3
  4]` dénote une matrice deux par deux ».
- **Pure queries.** Chapter 7, case study III: the facts in a layer-1
  arena, « L'analyse est un acteur de couche 2, qui reçoit les faits,
  calcule et répond aux requêtes. Le calcul lui-même est un fix de
  couche 3 […]. Le théorème thm:terminaison_lfp en donne la
  terminaison », and stratified negation is left out. PostgreSQL:
  « When working with recursive queries it is important to be sure
  that the recursive part of the query will eventually return no
  tuples, or else the query will loop indefinitely. »
  (https://www.postgresql.org/docs/current/queries-with.html); « A
  dollar sign ($) followed by digits is used to represent a positional
  parameter in the body of a function definition or a prepared
  statement. In other contexts the dollar sign can be part of an
  identifier or a dollar-quoted string constant. »
  (https://www.postgresql.org/docs/current/sql-syntax-lexical.html).
- **Character classes.** POSIX: « A character class expression is
  expressed as a character class name enclosed within
  bracket-<colon> ("[:" and ":]") delimiters »
  (https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap09.html).
  UTS #18, annex C: `alpha` is `\p{Alphabetic}`
  (https://www.unicode.org/reports/tr18/). Counted from
  `DerivedCoreProperties-18.0.0.txt` (dated 2026-08-07): 160,254
  `Alphabetic` code points in 775 contiguous runs
  (https://www.unicode.org/Public/UCD/latest/ucd/DerivedCoreProperties.txt).
  The glyph table gives `¬` (`not`) as « Négation bit-à-bit ».
- **Texts.** UAX #29 describes « grapheme clusters (“user-perceived
  characters”) » (https://www.unicode.org/reports/tr29/). BQN:
  « Character literals start and end with `'`, and have exactly one
  character in between » (https://mlochbaum.github.io/BQN/doc/syntax.html).
  R7RS, §6.6: « Characters are written using the notation
  #\⟨character⟩ or #\⟨character name⟩ or #\x⟨hex scalar value⟩ ».
  Python: « Even in a raw literal, quotes can be escaped with a
  backslash, but the backslash remains in the result »
  (https://docs.python.org/3/reference/lexical_analysis.html).
- **LaTeX.** Reserved characters `\ { } % $ & _ ^ # ~`, typeset as
  `\# \$ \% \& \{ \} \_ \~{} \^{} \textbackslash`
  (https://latexref.xyz/Special-characters.html,
  https://latexref.xyz/Printing-special-characters.html);
  `\guillemetleft («)`, `\guillemetright (»)`, `\guillemotleft` being
  « misspellings inherited from Adobe »; 72 commands under « Text
  symbols », logos and commands with arguments among them
  (https://latexref.xyz/Text-symbols.html); `\u` is the breve accent
  (https://latexref.xyz/Accents.html); « The default, if this package
  is not loaded, is UTF-8 » (https://latexref.xyz/inputenc-package.html;
  LaTeX News 28,
  https://www.latex-project.org/news/latex2e-news/ltnews28.pdf).
- **TeX.** *TeX by Topic*: « an escape character […] followed by a
  string of ‘letters’ is lumped together into a control word […] An
  escape character followed by a single character that is not of
  category 11, letter, is made into a control symbol »; « After
  control words spaces are ignored »; « any quadruplet ^^xy where both
  x and y are lowercase hexadecimal digits 0–9, a–f, is replaced by a
  character in the range 0–255 »
  (https://ctan.org/pkg/texbytopic).
  ConTeXt: `\backslash`, `\%`, `\{`, `\}`, `\lettertilde`
  (https://wiki.contextgarden.net/Special_characters).
- **OpTeX** (https://petr.olsak.net/optex/): « OpTeX is a LuaTeX
  format (LuaHBTeX format since 2025) based on Plain TeX macros (by
  Donald Knuth) ». Its manual
  (https://petr.olsak.net/ftp/olsak/optex/optex-doc.pdf): the text
  accent macros « are undefined in OpTeX. Use real letters like á, ř,
  ž in your source document »; `\"⟨quoted text⟩"` prints
  « language-dependent normal or alternative quotes » (« note that the
  terminating character is the same but it isn't escaped »); inline
  verbatim is « tagged (before and after) by a character which is
  declared by \verbchar⟨char⟩ »; in `\code{⟨text⟩}` only `\`, `#`,
  `%`, unmatched braces and repeated spaces or `^` are escaped. P.
  Olšák, « Comparison of OpTeX with other formats: LaTeX and
  ConTeXt », TUGboat 42:1 (2021): users own the names made of letters,
  OpTeX the `\_foo` names, packages `\_pkg_foo`
  (https://petr.olsak.net/ftp/olsak/bulletin/tb130olsak-fmtcmp.pdf).
- **Typst**: « To escape a character, precede it with a backslash. To
  insert any Unicode codepoint, you can write a hexadecimal escape
  sequence: \u{1f600}. The same kind of escape sequences also work in
  strings. » (https://typst.app/docs/reference/syntax/); symbols with
  dotted names, `quote.chevron.r.double` for `»`, `bar.v.double` for
  `‖`, `bar.v.triple` for `⦀` (https://typst.app/docs/reference/symbols/sym/).
- **Uiua**, *secondary* (uiua.org returned 404 to this session, the
  APL Wiki 403): primitives can be typed by lowercase names, and the
  formatter rewrites them as glyphs in the source (APL Wiki, « Uiua »;
  a blog report on its editor extension,
  https://zenn.dev/hatappo/articles/11c7ca2bc2d98e). K7PL would store
  the names and show the glyphs, the reverse.
- **K, checked on 2026-10-27 with K 7.1.337** (scratch grammars, not
  in the repository): a token `«…»` reads `«b c»` and `«»`, but a
  content with non-ASCII characters is refused by the scanner and an
  inner `»` is not excluded; the decision to keep ASCII in files
  removes the need.
- **Chapter 5 and the glyph table.** « un 2-train `(f g)` dénote
  λx. f(g(x)), un 3-train `(f g h)` dénote la fourche »; glyph and
  alias are « strictement équivalent[s] au niveau de l'AST »; annex A,
  `ERR-STK-001`. The table gives `≠` only as `neq` (dyadic) while
  chapter 5 uses it for the length; `´`, `¨`, `√` and `²` have no row;
  `-` (`sub`) and `⊢` (`right-id`) have no monadic alias.

## Reading lot: research of 2026-10-28, after the eighth part

The sources of the sixth to eighth parts are quoted in the facts of
each question ([questions](questions.md)). This section keeps what the
answers to the eighth part raised. Read on 2026-10-28; quotations are
verbatim; what is inferred for K7PL is marked as such and decides
nothing.

### Text encodings

- **Emacs**, Emacs Lisp manual, « Text Representations »: « a character
  codepoint in Emacs is a 22-bit integer »; « Emacs uses a
  variable-length internal representation of characters, that stores
  each character as a sequence of 1 to 5 8-bit bytes, depending on the
  magnitude of its codepoint », a representation « based on » UTF-8,
  which « Emacs extends […] to represent the additional codepoints it
  uses for raw 8-bit bytes and characters not unified with Unicode »;
  and, in « Coding System Basics », the coding system `utf-8-emacs`
  « specifies that the data is represented in the internal Emacs
  encoding ». Source:
  https://github.com/emacs-mirror/emacs/blob/emacs-30/doc/lispref/nonascii.texi.
- Inferred, not decided: the author's message on Q-STR-407 says that
  Emacs encodes text on 7 bits; by the manual, its internal encoding
  uses 8-bit bytes, 1 to 5 per character, and 7 bits is the width of
  ASCII. The answer's point stands either way: several encodings must be
  expressible in a text type, and a width counted in bits then depends
  on the unit of the encoding (8 bits for UTF-8, 16 for UTF-16, 32 for
  UTF-32, 7 for ASCII stored without padding).

### Actor scenarios: material for the discussion

Opened on 2026-10-28 at the author's request (Q-SPEC-307: « il nous
faut une approche plus systémique pour identifier et composer les
scénarios avec la question : est-ce que je souhaite séparer une
vérification d'une transformation, d'une livraison, etc. »).

What the specification already says:

- Chapter 3, « pureté des gestionnaires »: a pure layer-2 handler
  is a map `(Message × Capacités × État) → État` whose effect is
  neutral, and « Le résultat d'un tel gestionnaire n'est pas un effet
  exécuté mais une _description_ d'effets, une liste d'instructions
  que l'exécutif réalise ; c'est cette exécution, non la transition,
  qui est journalisée. »
- Chapter 4, the replay theorem `thm:determinisme_rejeu` (under
  review): replaying the journaled
  messages through the pure handlers of an actor reproduces its final
  state up to observation.
- Chapter 5 (eighth part): `:on (Increment :sets value […])`, the
  handler derived by the rule of `Result`.

Other systems, read on 2026-10-28; quotations are verbatim:

- **Erlang/OTP `gen_server`**: `handle_call` returns
  « {reply,Reply,NewState} […] The Reply value is sent back to the
  client request and there becomes its return value. The gen_server
  process continues executing with the possibly updated internal
  state NewState ». Source:
  https://www.erlang.org/doc/apps/stdlib/gen_server.html.
- **Elm**: « our programs will also send Cmd and Sub values to the
  runtime system. In this world, our programs can command the runtime
  system to make an HTTP request or to generate a random number ».
  Source: https://guide.elm-lang.org/effects/.
- **The decider (J. Chassaing, 2021)**: « type Decide = Command ->
  State -> Event list »; « This function has no reason to produce any
  side effects »; « type Evolve = State -> Event -> State […] Given a
  current State, when Event occurs, here is the new State ». Source:
  https://thinkbeforecoding.com/post/2021/12/17/functional-event-sourcing-decider.
- **Akka persistence**: « A command handler returns an Effect
  directive that defines what event or events, if any, to persist »;
  « The event handler must only update the state and never perform
  side effects, as those would also be executed during recovery of
  the persistent actor. Side effects should be performed in thenRun
  from the command handler after persisting the event ». Source:
  https://doc.akka.io/libraries/akka-core/current/typed/persistence.html.
- **Event sourcing (M. Fowler, 2005)**: « Capture all changes to an
  application state as a sequence of events ». Source:
  https://martinfowler.com/eaaDev/EventSourcing.html.

Inferred, not decided:

- The three steps the author names map onto the layers. Checking a
  message and deciding what happens is pure and terminating (layer
  3). So is applying what was decided to the state (the decider's
  `evolve`). Delivering — the reply, the messages to other actors,
  what is persisted — is the description of effects of chapter 3,
  which the executive runs (layer 2).
- The rule of `Result` of the eighth part is the degenerate case:
  one decision (`Ok v` or `Err e`), an `evolve` that sets one field,
  and a delivery reduced to the reply.
- Akka's rule that the event handler never performs side effects is
  the condition chapter 4's replay theorem already needs: replay runs
  the transitions again, never the deliveries.
- Scenarios that span several messages (a protocol, a saga) are not
  covered by any of these shapes; they belong with the session types
  of chapter 4 and annex A.

## Reading lot: research of 2026-10-29, after the tenth part

Three reports asked by the author on 2026-10-29: what a module is
(Q-SPEC-504, VOC-2026-10-29-011) and top-level forms as autonomous
processes (Q-SPEC-505, VOC-2026-10-29-010), each « un rapport
analytique adversarial complet sur ce sujet avec limites,
opportunités, exemples, etc. et notamment un paragraphe d'analyse
scientifique sur le sujet et les possibilités concernant K7PL »; and
the strategies that avoid Rust's very long compilation times
(Q-TYP-602, VOC-2026-10-29-008). Sources were read on 2026-10-29 and
are quoted verbatim; the specification is quoted as it stands after
the tenth part was applied. Each report separates what is observed
(the specification, the sources) from what is inferred for K7PL, which
is marked as such and decides nothing. Every word of the K7PL
examples is a placeholder.

### Report 1 — What a module is (Q-SPEC-504)

#### The question

The ninth part asked what a module is (Q-SPEC-406). The author's
clarification (VOC-2026-10-28-030): « emacs lexical binding pour
définir un périmètre général, pour le reste, il faut préciser la
question parce qu'une S-Expression non encapsulée dans une autre est
un processus autonome executable en parallele des autres du même
rang. il faut donc définir ce qu'est un module parce que là je ne
comprend pas et ai peur de mélanger les sujets ». The tenth part
offered three options — a file, the compilation unit of chapter 6, no
module — and the author asked for this report instead of choosing.
The second half of the clarification, top-level forms, is Report 2.

#### What the specification already holds

Observed on 2026-10-29:

- **Modules, used but not defined.** Chapter 4 (system scale) builds
  « la catégorie librement engendrée par le graphe des dépendances —
  objets les modules, morphismes les chemins de dépendance », and a
  namespace is « une sous-catégorie large », whose inclusion is a
  faithful functor. Restricting the graph to one dimension « remplace
  la hiérarchie de dossiers physiques par une lecture purement logique
  du graphe de types ». Two warnings are computed on this graph,
  instability and centrality; annex A has `ERR-ARC-002`, « Seuil de
  centralité dépassé (God Object) ». The glossary defines a namespace
  as a « Sous-catégorie large du graphe des modules, close par
  composition », but defines no module.
- **The compilation unit and its interface.** Chapter 6 states as a
  definition, `thm:interface_jugement`, that « l'interface d'une unité
  de compilation est son jugement »: in Δ ⊢ t : A | ℰ, « Δ dit ce que
  l'unité _exige_, A ce qu'elle _est_, ℰ ce qu'elle _produit_ ». It
  draws the consequence: « S'il tient, une interface n'a rien à
  déclarer que le jugement ne porte déjà, et le langage n'a pas de
  langage de modules séparé à maintenir ». It also accepts the cost:
  « si le grade est dans l'interface, alors le changer change
  l'interface, et les unités dépendantes recompilent ». The bounded
  compilation requirement makes the unit carry the budget: « Tout
  travail de compilation est borné par un grade porté par l'unité de
  compilation ». Monomorphisation starts « des racines de l'unité de
  compilation — ses points d'entrée et ce que son interface exporte »,
  and « Un générique d'une autre unité s'instancie dans l'unité qui
  l'emploie, sa source voyageant dans l'interface ».
- **The stamp.** The glossary's « estampille »: « Marque attachée à
  une unité de compilation qui atteste de quelle définition elle
  provient, et par laquelle deux unités se reconnaissent compatibles ».
  Instances and the binary are named by the hash of a normalised
  syntax tree (chapter 6).
- **The package.** SMT obligations « qui traversent la frontière de
  paquet » need a certificate (chapter 6); chapter 3 names « la
  signature des paquets » among the possible strategies at a boundary.
  The same word, « paquet », names the existential packages of chapter
  3, with their `pack` and `unpack`.
- **Names.** `thm:staticite_syntaxe`: « Aucune construction de K7PL ne
  calcule un nom ; toute opération d'espace de noms vit au niveau
  macro, où elle est typée par `binds` ». A path is a symbol whose
  names are separated by `/` (chapter 5).
- **Not found:** a definition of a module; a form that imports; the
  file as a unit of the language; an entry point other than the
  « points d'entrée » of chapter 6, which are not defined.

Inference for K7PL: the specification already has four groupings —
the namespace (a logical view), the module (an object of the
dependency graph), the compilation unit (roots, interface, budget,
stamp) and the package (the boundary where certificates are required)
— and a fifth, implicit one, the file. The question is less what a
module is than which of these coincide. The specification has also
already ruled on one point: there is no separate module language,
since the interface is the judgement.

#### What the literature and other languages hold

- **Two processes, not one.** Leroy (1994): « Modularization is the
  process of decomposing a program in small units (modules) that can
  be understood in isolation by the programmers […]. Separate
  compilation is the process of decomposing a program in small units
  (compilation units) that can be typechecked and compiled separately
  by the compiler ». On identifying them, as Modula-2 does: « this
  identification is limiting. Since compilation units are usually
  directly mapped onto file system objects, separate compilation tends
  to keep the structure of compilation units simple, with the
  dependencies “hard-wired” inside the units » (X. Leroy, « Manifest
  types, modules, and separate compilation », POPL 1994,
  https://xavierleroy.org/publi/manifest-types-popl.pdf).
- **Separate compilation stated formally.** Cardelli (1997): « Some
  language definitions specify what are to be the compilation units
  (e.g.: Ada [12]), but others do not (e.g.: Standard ML [17]) »; « We
  propose a framework where each module is separately compiled to a
  self-contained entity called a linkset; we show that separately
  compiled, compatible modules can be safely linked together » (L.
  Cardelli, « Program Fragments, Linking, and Modularization », POPL
  1997, http://lucacardelli.name/Papers/Linking.A4.pdf).
- **Weak and strong modularity.** Backpack (Kilpatrick, Dreyer, Peyton
  Jones, Marlow, POPL 2014): « Module systems like that of Haskell
  permit only a weak form of modularity in which module
  implementations directly depend on other implementations and must be
  processed in dependency order. Module systems like that of ML, on the
  other hand, permit a stronger form of modularity in which explicit
  interfaces express assumptions about dependencies, and each module
  can be typechecked and reasoned about independently »
  (https://plv.mpi-sws.org/backpack/).
- **What ML modules are.** Rossberg, Russo and Dreyer, « F-ing
  Modules »: « ML modules are a powerful language mechanism for
  decomposing programs into reusable components. Unfortunately, they
  also have a reputation for being "complex" »; their elaboration
  translates module expressions « into vanilla System F ω », and
  « We thereby show that ML modules are merely a particular mode of use
  of System F ω » (https://people.mpi-sws.org/~rossberg/f-ing/). The
  specification already cites the history of Standard ML
  (`macqueenHistoryStandardML2020`) and Leroy's syntactic theory of
  generativity and sharing (`leroySyntacticTheoryType1996`).
- **Rust.** « A crate is a unit of compilation and linking, as well as
  versioning, distribution, and runtime loading. A crate contains a
  tree of nested module scopes » (Rust reference, crates and source
  files, https://doc.rust-lang.org/reference/crates-and-source-files.html).
  The unit of compilation is the crate; the module is a scope inside
  it.
- **Swift.** « The optimizer can only perform specialization if the
  definition of the generic declaration is visible in the current
  Module. This can only occur if the declaration is in the same file
  as the invocation of the generic, unless the
  ``-whole-module-optimization`` flag is used » (Swift, optimization
  tips,
  https://github.com/swiftlang/swift/blob/main/docs/OptimizationTips.rst):
  the module boundary is an optimisation boundary.
- **Unison.** « Each Unison definition is identified by a hash of its
  syntax tree. Put another way, Unison code is content-addressed »;
  « Names are like pointers to addresses »; « Because Unison
  definitions are identified by their hash, they never change […].
  Thus, we can parse and typecheck definitions once, and then store
  the results in a cache which is never invalidated » (Unison, the big
  idea, https://www.unison-lang.org/docs/the-big-idea/).
- **Racket and phases.** Flatt (2002): Lisp and Scheme implementations
  « tend to allow the mingling of compile-time values and run-time
  values, as well as values from separate compilations. Such mingling
  breaks programming tools that must parse code without executing it »;
  MzScheme « addresses the problem through a macro system that
  separates compilation without sacrificing the expressiveness of
  macros » (M. Flatt, « Composable and Compilable Macros: You Want it
  When? », ICFP 2002,
  https://www.cs.utah.edu/plt/publications/macromod.pdf).
- **Emacs, OCaml, Racket files.** Quoted in the tenth part
  ([questions](questions.md), Q-SPEC-504): lexical binding is set for
  a whole file; an OCaml compilation unit is an interface and an
  implementation; a Racket module typically resides in its own file.

#### The options, read adversarially

**A — The file is the module.**
For: one notion; Emacs's file-local lexical binding is literally
this; Racket and OCaml practice. Against, from the specification:
chapter 4 already reads structure off the dependency graph and
« remplace la hiérarchie de dossiers physiques »; chapter 6 lets a
generic's source travel in an interface and names instances by hash,
which a file-sized unit would turn into a file-sized cache. Against,
from the literature: Leroy's remark that compilation units mapped onto
files keep their dependencies « hard-wired ». Hidden costs: renaming
or splitting a file changes a module's identity; the budget of chapter
6 becomes a per-file budget, an arbitrary grain; an actor, its
handlers and its pure functions cannot be one unit across files.

**B — The compilation unit is the module; a file is a lexical
perimeter.**
For: chapter 6 already gives the unit its roots, its interface (the
judgement), its budget and its stamp; Leroy's distinction keeps both
processes; Rust's crate is the same choice. Against: two notions to
name — though Leroy shows they are two processes, so the second
notion is not an addition but a recognition. Rust shows the unit
becomes the grain of parallelism and of reuse unless it is split
again: rustc splits each crate into codegen units (Report 3). And the
unit boundary is where specialisation stops seeing the generic, as
Swift's rule shows; chapter 6 answers by making the generic's source
travel in the interface, so a cross-unit instance compiles in the
using unit.

**C — No module.**
For: nothing new. Against: chapter 6's interface, its budget, its
stamp and the certificate at the package boundary lose their object;
chapter 4's dependency graph loses its objects; there is no separate
compilation, which works against the author's aim of short
compilations (Q-TYP-602, Report 3).

**D — The definition is the unit of identity; a module is a named,
versioned set of definitions with an interface; a file is a lexical
perimeter.** Not among the tenth part's options; drawn from Unison and
from chapter 6.
For: chapter 6 already names instances and the binary by the hash of a
normalised syntax tree; with definitions named the same way, Unison's
« typecheck definitions once » cache, « never invalidated », follows;
definitions are independent units of work, so they parallelise
(Report 3); a namespace stays a view of chapter 4's graph; a module
becomes what is versioned, signed and certified (the « paquet » of
chapter 6). Against: identity by hash is intensional — two definitions
that behave alike have different hashes; Unison's hash « pins down all
its dependencies », so changing a widely used definition gives new
hashes to everything that depends on it, which must be checked again
(the untouched rest is not); names, versions and files need a tool
that maps them to hashes; normalisation must be stable across compiler
versions, or the compiler's own hash must enter the key.

**E — ML-style modules: signatures, structures, functors.**
Not among the tenth part's options; included because it is the
reference design.
For: the strongest modularity in Backpack's sense — each module
« typechecked and reasoned about independently ». Against: chapter 6
has already ruled that there is no separate module language, the
interface being the judgement (`thm:interface_jugement`); a functor is
a module with named parameters, while the author decided that a
generic names no type parameter (VOC-2026-10-28-037); F-ing modules
shows ML modules are « a particular mode of use » of System Fω, whose
∀ and ∃ K7PL's surface does not write; and the reputation the F-ing
abstract reports.

Options combine: D for identity and B for the boundary of interface,
budget, stamp and certificate is a candidate; so is A where the file
and the unit happen to coincide, by convention rather than by rule.

Gaps found in the specification:

- « module » is used by chapter 4 and by chapter 6 (« Une interface de
  module doit énoncer trois choses ») but never defined;
- « paquet » names both the existential package of chapter 3 and the
  boundary of distribution of chapter 6;
- no form says how a unit names what it uses from another (an import),
  although `thm:staticite_syntaxe` requires that it be static, typed by
  `binds` at the macro level;
- chapter 6's « points d'entrée » are not defined (Report 2).

#### Examples

```
;; A — the file math/stats.k7 is the module math/stats
{defn mean :type {function {vector num} num} [add fold div length]}

;; B — a unit that spans math/stats.k7 and math/spread.k7
{defunit math/stats :roots (mean std-dev) :budget 64}

;; D — names point to hashes of normalised definitions
{defmodule math/stats :version 1.2.0 :exports (mean std-dev)}
```

#### Scientific analysis

A module system answers three questions that the literature separates
and that languages often merge. **Scope**: which names a piece of text
sees — a static, syntactic relation. In K7PL it is fixed at the end of
Phase 1 (`thm:staticite_syntaxe`), so any lexical perimeter, the file
among them, is enough for it; Emacs's lexical binding is an answer to
this question only. **Identity and linking**: which definitions exist
and how separately compiled pieces combine. Cardelli gives separate
compilability a formal statement — compatible, separately compiled
fragments link safely — and content addressing makes identity a
function of the normalised syntax tree, so that linking becomes the
union of sets of hashes; K7PL's stamp is the compatibility witness
Cardelli's statement needs, and the certificate of chapter 6 its
proof-carrying counterpart for SMT obligations. **Abstraction**: what
a client may not see. In the ML tradition this is the signature, and
F-ing modules reduces it to System Fω, that is, to universal and
existential types. K7PL already holds the three ingredients apart:
lexical scope at Phase 1, identity by hash in chapter 6, abstraction
by the existential packages of chapter 3 with their explicit `pack`
and `unpack`; and chapter 6 has already decided that the interface
needs no fourth ingredient, since the judgement carries what a unit
requires (Δ), what it is (A) and what it produces (ℰ) — a position
that Standard ML, with no effects in its signatures, and Haskell, with
no module system as rich, each fell short of, as chapter 6 notes. In
chapter 4's terms, the decision left is what the objects of the free
category 𝒟 on the dependency graph are: files (A), units (B) or
definitions (D). Under D, a module is a set of objects of 𝒟 given an
interface, and a namespace remains a wide subcategory — a view, not a
container. The open mathematical point is compositional: whether the
judgement of a unit is determined by the judgements of its
definitions, so that a unit's interface can be computed rather than
written. If it is, D and B compose without a second source of truth;
if it is not, the unit's interface is a separate artefact that can
disagree with its definitions, and chapter 6's definition would need a
coherence statement.

#### Limits of this report

No measurement was made; Unison's tooling, its codebase format and its
treatment of files were not examined beyond the page quoted; Mitchell
and Plotkin's account of abstract types as existential types was not
read for this report; no statement here is proved.

#### What remains for the author to decide

Which grouping carries the interface, the budget, the stamp and the
certificate (A, B, C, D, E or a combination); whether « module »,
« unit » and « package » are one word, two or three; and how the
existential « paquet » of chapter 3 and the distributed « paquet » of
chapter 6 are told apart. The question is asked again with these
options in the next part.

### Report 2 — Top-level forms as autonomous processes (Q-SPEC-505)

#### The question

The author's statement of the ninth part (VOC-2026-10-28-030): « une
S-Expression non encapsulée dans une autre est un processus autonome
executable en parallele des autres du même rang ». The tenth part
noted that the specification says nothing of top-level forms and
offered three readings; the author asked for this report.

#### What the specification already holds

Observed on 2026-10-29:

- **The system is a parallel composition.** Chapter 4: « À l'échelle
  du système, la coalgèbre qui produit l'état suivant n'est plus celle
  d'un acteur isolé, mais celle de l'orchestrateur tout entier, dont
  l'état est composé des états de tous les acteurs qu'il supervise »;
  « un système est un terme — composition parallèle d'acteurs sous
  restriction des canaux privés — ».
- **Phase 2 already reads the actors.** Chapter 6: the configuration
  pass « collecte, à partir des définitions d'acteurs et des `strand`
  de workflow, les ressources externes que le programme engage », and
  « C'est aussi là que le tri topologique du graphe de câblage établit
  son acyclicité […] : un cycle y produit `ERR-ARC-001` », « Cycle
  dans le graphe de dépendances entre acteurs et canaux » (annex A).
- **Replay.** Chapter 1, postulate of distributed determinism: « En
  couche 2, il est déterministe *modulo le journal* : l'entrelacement
  des acteurs est journalisé, et c'est le journal qui le restitue ».
- **Virtual actors.** Chapter 4 (system scale): « Un acteur virtuel est
  une adresse logique dans le modèle abstrait. Le cycle de vie
  distingue les états actif et inactif et exige la préservation de
  l'état observable lors des transitions. Une réalisation peut
  sérialiser l'état inactif dans un instantané journalisé, restituer sa
  mémoire puis rejouer les messages consignés lors de la
  réactivation »; the figure `fig:acteur-cycle-de-vie` draws the two
  states, activation loading the snapshot and replaying the journal.
- **Laziness and events.** The author's remark of 2026-10-27: « les
  automates compilés en couche 3 sont invoqués paresseusement par
  l'orchestrateur »; the answer to Q-ACT-001 (VOC-2026-10-29-002):
  « l'objectif est de réagir […] c'est la cible "event-based" de K7PL
  qui vient compléter la phylosophie "lazy" ».
- **The layers.** Types are written in layer 1 only, inside `{ }`;
  layer 2, `( )`, orchestrates and produces; layer 3, `[ ]`, computes
  and terminates (chapter 5).
- **Not found:** anything about top-level forms; a program's start;
  the « points d'entrée » of chapter 6 beyond their name.

Inference for K7PL: the specification has the target — a parallel
composition of actors, an acyclic wiring graph, a journal, virtual
actors that activate and deactivate — but no map from a source text's
top-level forms to that composition.

#### What the literature and other languages hold

- **One entry point.** Haskell: « A Haskell program is a collection of
  modules, one of which, by convention, must be called Main and must
  export the value main. The value of the program is the value of the
  identifier main in module Main, which must be a computation of type
  IO τ for some type τ » (Haskell 2010 report, chapter 5,
  https://www.haskell.org/onlinereport/haskell2010/haskellch5.html).
  Pony: « A Pony program has to have a Main actor »; « our Main actor
  has to have a constructor called create that takes a single
  parameter of type Env. That’s how all programs start! » (Pony
  tutorial,
  https://tutorial.ponylang.io/getting-started/how-it-works.html).
- **Order by dependencies.** Go: « Within a package, package-level
  variable initialization proceeds stepwise, with each step selecting
  the variable earliest in declaration order which has no dependencies
  on uninitialized variables »; « If any variables are still
  uninitialized when this process ends, those variables are part of
  one or more initialization cycles, and the program is not valid »;
  « If a package has imports, the imported packages are initialized
  before initializing the package itself »; « initialization always
  sequences the init functions: it will not invoke the next one until
  the previous one has returned » (Go specification, package
  initialization, https://go.dev/ref/spec#Package_initialization).
- **Order by position.** Erlang/OTP supervisors: « When the supervisor
  is started, the child processes are started in order from left to
  right according to this list. When the supervisor is going to
  terminate, it first terminates its child processes in reversed start
  order, from right to left » (Erlang/OTP, supervisor,
  https://www.erlang.org/doc/apps/stdlib/supervisor.html).
- **Processes declared, then activated together.** Kahn (1974): « The
  program S consists of a set of declarations and a body »; « The
  infix operator par initiates the concurrent activation of the
  processes » (G. Kahn, « The semantics of a simple language for
  parallel programming », IFIP Congress 1974). Lee and Parks (1995)
  describe Kahn process networks as « a model of computation where a
  number of concurrent processes communicate through unidirectional
  FIFO channels, where writes to the channel are non-blocking, and
  reads are blocking », and dataflow process networks as « repeated
  "firings" of a dataflow "actor" »
  (https://ptolemy.berkeley.edu/publications/papers/95/processNets/).
  Lee (2006): « In the original PN model due to Kahn and MacQueen
  [31], the blocking reads ensure that every network defines a
  deterministic computation » (E. A. Lee, « The Problem with
  Threads », UCB/EECS-2006-1,
  https://www2.eecs.berkeley.edu/Pubs/TechRpts/2006/EECS-2006-1.pdf).
- **Processes that always exist.** Orleans: « Actors are purely
  logical entities that always exist, virtually. An actor cannot be
  explicitly created nor destroyed, and its virtual existence is
  unaffected by the failure of a server that executes it. Since actors
  always exist, they are always addressable » (Microsoft, Orleans
  overview, https://learn.microsoft.com/en-us/dotnet/orleans/overview).

#### The options, read adversarially

**A — Every top-level form, whatever its layer, is a process.**
For: one rule, the author's statement taken literally. Against: a
`{ }` form is a declaration, elaborated in Phases 0 to 2, and has no
behaviour to run; a `[ ]` form is a pure value, whose evaluation is
not a process and whose place, by the laziness recorded on 2026-10-27,
is to be invoked when needed; « types en couche 1 seulement » makes a
running declaration a category error.

**B — Top-level layer-2 forms are processes; `{ }` are declarations;
a top-level `[ ]` is a pure value.**
For: it follows the layers, and chapter 4's parallel composition
receives exactly the layer-2 forms. Against: it says nothing of order;
a process that sends before its receiver exists, or an initialisation
with effects, is left to the executive; Go's rules show how much an
unordered start leaves undefined.

**C — B, ordered by dependencies.**
For: Go's precedent (dependency order, then declaration order; cycles
make the program invalid) and Erlang's (an explicit order and its
reverse at shutdown); Phase 2 already computes the topological order
of the wiring graph and refuses cycles (`ERR-ARC-001`); « même rang »
gets a meaning, the same depth in that order, processes of one rank
starting in parallel. Against: a rank-by-rank start sequences the
system by the depth of its graph, and an event-based system does not
need it when mailboxes buffer messages sent before a receiver is
ready.

**D — B, with lazy activation.** Not among the tenth part's options;
drawn from chapter 4's virtual actors, from Orleans and from the
author's laziness.
Top-level layer-2 forms declare processes that exist virtually; the
orchestrator activates one on its first message, and only the sources
of events — an ingress that receives from outside, a `defer` that
fires — start at once. For: it is the event-based and lazy target the
author names; no start order has to be specified, since a message to a
process not yet active activates it; chapter 4 already has the
lifecycle — an actor virtual by default, activated by loading its
snapshot and replaying its journal — so D adds no mechanism, only the
rule that top-level forms are such actors; Orleans shows the model at
scale; deactivation and failure become the same case. Against: what
starts the system must be named, an ingress or a timer; the first
message pays the activation; chapter 4 leaves snapshot, journal and
atomicity of activation to the realisation, so `persist` (Q-ACT-005)
must say what of them the language guarantees; « autonomous process »
becomes « potential process »,
which changes the author's statement; acyclicity and budgets must be
checked on the virtual graph, not on the active one.

**E — One entry point.**
For: Haskell's `main`, Pony's `Main` actor; explicit. Against: it
contradicts the author's statement that top-level forms are
autonomous, and turns the parallel composition of chapter 4 into a
single root.

C and D combine: D for the processes, C's order for the eager sources
when one depends on another.

Determinism, adversarially: Kahn networks are deterministic because
reads block on one channel each (Lee); actors whose mailbox merges
messages from several senders are not, which is why chapter 1 journals
the interleaving. Parallel top-level processes therefore do not
threaten replay, since the journal restores the interleaving, but they
do not give determinism by construction either.

Gaps found in the specification: no rule maps top-level forms to the
orchestrator's composition; chapter 6's « points d'entrée » are
undefined; « même rang » has no definition; chapter 4's virtual actor
says nothing of what first activates an actor.

#### Examples

```
{defactor counter …}                   ;; layer 1: a declaration, not a process
(counter)                              ;; layer 2: a top-level process (B, C, D)
(http-ingress :port 8080 :to counter)  ;; layer 2: an event source, started at once under D
[add fold div length]                  ;; layer 3: a pure value, evaluated where it is used
```

#### Scientific analysis

Chapter 4 gives the system a coalgebra whose state is the product of
the actors' states, generated by the product of their behaviour
functors and restricted by the topology. Top-level layer-2 forms are
the natural source of the factors of that product: each one
contributes one component, and the restriction is the wiring graph of
Phase 2. « Même rang » can then be read two ways. Read as depth in the
acyclic dependency order, it is a stratification: processes of one
stratum compose in parallel, strata compose in sequence — the same
shape as the strata of chapter 2's `thm:terminaison_strates`, applied
to start instead of evaluation. Read as syntax — the same layer, not
nested — it gives no order at all, and order must come from the
messages. The two readings correspond to two schedulers in the sense
of Mokhov, Mitchell and Peyton Jones (Report 3): a topological
scheduler that starts what is ready in dependency order (C), and a
suspending one that starts what is demanded when it is demanded (D).
On determinism, the classical result is Kahn's: networks of processes
with blocking reads on single channels compute deterministic results,
whatever the schedule (Lee). K7PL's actors read from mailboxes that
merge senders, so they fall outside that class, and the journal is
what chapter 1 uses to recover determinism. The opportunity, stated as
a hypothesis: a sub-network whose channels each have one writer and
one reader, read by blocking receives, is a Kahn network, and its
interleavings need not be journaled; recognising such sub-networks in
Phase 2 would shorten the journal without weakening replay. It would
need a proof that the restriction is preserved by the executive.

#### Limits of this report

Kahn's paper was read only through its abstract and opening pages;
the determinism result is quoted from Lee. Orleans's activation and
deactivation were not examined beyond the overview quoted. No option
was prototyped.

#### What remains for the author to decide

Which forms are processes at top level (A, B, E), whether they start
in order (C), lazily (D) or both; what « même rang » means; what
starts a program; and whether to pursue the Kahn sub-network
hypothesis. The question is asked again with these options in the
next part.

### Report 3 — Compilation times: strategies against Rust's long builds (Q-TYP-602)

#### The question

The justification of Q-TYP-602 (VOC-2026-10-29-008): « les phases de
compilations sont réputés non fiabilisées. par exemple, la résolution
SMT n'a pas suffisament été explorée pour identifier les traitements
paralleles etc. ici, dans la mesure du possible, j'aimerais trouver
les stratégies permettant de limiter les temps de compilations hyper
longs de Rust ». The answer to Q-TYP-603 (VOC-2026-10-29-009) adds that
a language server checks while the code is written, and that
compilation « doit suivre un protocole strict et reproductible ».

#### What the specification already holds

Observed on 2026-10-29, after the tenth part was applied:

- **Predictability is a stated aim.** Chapter 6 keeps a first
  Hindley-Milner pass « pour la prévisibilité du temps de
  compilation »; the bounded compilation requirement: « Tout travail de
  compilation est borné par un grade porté par l'unité de compilation,
  et ce grade se mesure en _compte de ressource reproductible_ — jamais
  en délai »; « _Le budget du solveur est un compte de ressource,
  jamais un délai._ »
- **The solver is restricted.** Only a fragment 𝒯₀ whose decidability
  is established is submitted; any obligation outside it is « rejetée
  à la compilation avec un code d'erreur, et jamais soumise »; 𝒯₀ is
  not yet delimited.
- **Instances are economised.** Monomorphisation collects from the
  unit's roots and makes only the instances reached; an instance is
  named by the hash of the normalised tree of its generic and its type
  arguments, made once and linked once; a cache keyed by that hash
  means that « un changement de cette source qui laisse inchangé l'AST
  normalisé du générique ne recompile rien »; every new instance
  decrements the specialisation budget. Since the tenth part,
  monomorphisation runs once, at the opening of Phase 8, and Phases 5
  and 6 check each generic once.
- **Signatures are obligatory.** « toute définition de plus haut niveau
  porte une signature » (chapter 6, after chapter 3), so that Phase 3
  checks bidirectionally without inferring across definitions.
- **Early failure.** Phase 2 produces a manifest of external resources
  « validable avant même qu'un type n'ait été inféré ».
- **A cost accepted.** Because the grade is in the interface,
  changing it recompiles the dependent units (`thm:interface_jugement`
  and its discussion).

#### Where compilation time goes elsewhere

- **rustc, monomorphisation.** Quoted in the sixth part
  ([questions](questions.md)): the collector starts from « the public
  non-generic syntactic items », instantiates lazily, and « A generic
  definition in crate X might produce monomorphizations that are
  compiled into crate Y ».
- **rustc, parallel code generation.** « During monomorphization the
  compiler splits up all the code to be generated into smaller chunks
  called codegen units. These are then generated by independent
  instances of LLVM running in parallel. At the end, the linker is run
  to combine all the codegen units together into one binary »; the
  same page warns: « As of November 2024, the parallel front-end is
  undergoing significant changes, so this page contains quite a bit of
  outdated information » (rustc dev guide, parallel compilation,
  https://rustc-dev-guide.rust-lang.org/parallel-rustc.html).
- **rustc, incremental compilation.** « The basic algorithm is called
  the red-green algorithm. The high-level idea is that, after each run
  of the compiler, we will save the results of all the queries that we
  do, as well as the query DAG »; « if all of Q’s inputs are green,
  then we can conclude that Q must be green » (rustc dev guide,
  incremental compilation,
  https://rustc-dev-guide.rust-lang.org/queries/incremental-compilation.html).
  Salsa, its generalisation: « a Rust framework for writing
  incremental, on-demand programs […] based on the incremental
  recompilation techniques that we built for rustc »
  (https://salsa-rs.github.io/salsa/).
- **rustc, back end.** The Cranelift back end: « This has the potential
  to improve compilation times in debug mode »
  (https://github.com/rust-lang/rustc_codegen_cranelift).
- **Go, fewer copies at a runtime cost.** « we will generate a single
  chunk of assembly for each unique GC shape used by any
  instantiation. Each chunk of assembly will take as an argument a
  _dictionary_ »; the proposal is « middle ground » between full
  stenciling and dictionaries (Go, GC shape stenciling,
  https://github.com/golang/proposal/blob/master/design/generics-implementation-gcshape.md).
- **Swift, specialisation bounded by visibility.** Quoted in Report 1.
- **Unison, nothing rebuilt.** « we can parse and typecheck
  definitions once, and then store the results in a cache which is
  never invalidated » (Report 1).
- **Build systems, in theory.** Mokhov, Mitchell and Peyton Jones:
  « A build system is minimal if it executes tasks at most once per
  build and only if they transitively depend on inputs that changed
  since the previous build »; early cutoff: « When it executes a task
  and the result is unchanged from the previous build, it is
  unnecessary to execute the dependent tasks »; and two choices « the
  order in which tasks are built (§4.1) and whether or not a task is
  (re-)built (§4.2). These choices turn out to be orthogonal »
  (« Build Systems à la Carte », ICFP 2018,
  https://www.microsoft.com/en-us/research/uploads/prod/2018/03/build-systems-a-la-carte.pdf).
- **Verification, cached.** Leino and Wüstholz: « The caching system
  uses the program’s call graph and control-flow graph to focus the
  verification effort on just the parts of the program that were
  affected by the user’s most recent modifications »; it is
  implemented in Boogie and used in the Dafny IDE (« Fine-grained
  Caching of Verification Results », CAV 2015,
  https://www.microsoft.com/en-us/research/publication/fine-grained-caching-of-verification-results/).
- **Verification, unpredictable.** F*: « Even a single poorly chosen
  quantified assumption in the prover’s context can make an otherwise
  simple proof take very long »; its query statistics report a
  failure « in 5647 milliseconds with fuel 4 and ifuel 0 and rlimit
  2723280 » (F* tutorial, under the hood: SMT,
  https://fstar-lang.org/tutorial/book/under_the_hood/uth_smt.html).
  Z3's `rlimit`: « default resource limit used for solvers. Unrestricted
  when set to 0 » (Z3 guide, parameters,
  https://microsoft.github.io/z3guide/programming/Parameters/).
- **Verification, faster by design.** Verus, the authors' own claim:
  « Verus verifies code 3–61x faster and with less effort than the
  state of the art » (« Verus: A Practical Foundation for Systems
  Verification », SOSP 2024,
  https://www.microsoft.com/en-us/research/publication/verus-a-practical-foundation-for-systems-verification/).

#### Strategies, read adversarially

Each strategy is marked: **in the specification** (already there),
**compatible** (fits without a decision against it) or **closed**
(ruled out by a decision).

- **S1 — Content-addressed results for every phase** (compatible).
  Extend chapter 6's instance cache to parsing, typing, effect,
  termination and solver results, each keyed by the hash of its
  normalised input and of the compiler. For: Unison's cache « never
  invalidated »; a key that holds every input makes an incremental
  build equal to a clean one. Against: normalisation must be stable;
  the store grows and needs collection.
- **S2 — Query-based incremental compilation with early cutoff**
  (partly in the specification). rustc's red-green algorithm and Salsa
  re-run only the queries whose inputs changed; early cutoff stops at
  an unchanged output. Chapter 6's « ne recompile rien » when the
  normalised tree is unchanged is already an early cutoff. For:
  minimality in Mokhov's sense. Against: incremental compilers are
  complex, and an incremental bug breaks reproducibility; S1's keys and
  a clean reference build in continuous integration answer it.
- **S3 — Parallelism by independence** (compatible). Names are fixed
  after Phase 1 and every top-level definition carries a signature, so
  Phase 3 can check definitions independently; Phases 5 and 6 check
  each generic once; SMT obligations of distinct definitions are
  independent queries, which can be sent in parallel; instances are
  independent units of code generation, as rustc's codegen units. For:
  the parallelism comes from the language's own structure, not from
  the compiler's tricks. Against: Phase 7 and Phase 8 iterate until
  stabilisation, which is a sequential loop over the whole unit, and
  solving one hard query in parallel is a different problem from
  dispatching many easy ones.
- **S4 — Cached and replayed verification** (partly in the
  specification). Cache solver answers by obligation hash, as Boogie
  does for Dafny; replay a recorded proof instead of searching again —
  chapter 6 already demands certificates across package boundaries,
  and the same certificates can serve locally. For: the verifier then
  costs what changed. Against: a certificate must be checked, which
  costs less than a search but not nothing.
- **S5 — A solver discipline** (in the specification for its
  principles). Stay in 𝒯₀, avoid quantified assumptions or bound their
  instantiation (F*), keep queries small (Verus's claim), and count
  the solver's work in a resource count rather than in time, as chapter
  6 already requires and as Z3's `rlimit` and F*'s statistics expose.
  For: predictability, the aim chapter 6 states. Against: 𝒯₀ is not
  yet delimited, and every obligation outside it is a refusal the
  developer must answer.
- **S6 — Fewer instances** (in the specification, with a risk). Only
  reached instances, one per hash, bounded by the budget. Go's shape
  stenciling would cut instances further but passes a dictionary at
  run time, which chapter 6 forbids (`ERR-POL-001`): **closed** in that
  form. A K7PL-specific risk, inferred: typed holes resolved each at
  its smallest width (Q-TYP-601) multiply instances — a
  `{function int int}` used with four input widths and four output
  widths can need up to sixteen copies. Rounding hole widths to a small
  set of widths would bound the product, at the cost of the « plus
  petite largeur » rule.
- **S7 — Two back ends** (compatible). A fast, non-optimising back end
  for the development loop, as Cranelift is for rustc, and the
  optimising one for release; the language server checks while the
  code is written (Q-TYP-603), and the release build follows the strict
  and reproducible protocol. Against: two back ends to keep equivalent,
  which the preservation invariants of chapter 6 would have to cover.
- **S8 — Fail early** (in the specification). Phase 2's manifest, the
  phase order that refuses before investing, and the language server.

#### Scientific analysis

Incremental compilation is memoisation over a dependency graph of
computations: rustc's query DAG, Salsa's database, the tasks of a
build system. Mokhov, Mitchell and Peyton Jones show that what a build
system does reduces to two orthogonal choices — a scheduler, which
orders the work, and a rebuilder, which decides whether a piece must be
redone — and they define correctness against a build from scratch.
That is the bridge between the author's two demands: an incremental
compiler is reproducible exactly when its rebuilder keys every result
by all of its inputs, the compiler included, so that a cached result
is the result a clean build would compute; content addressing, which
chapter 6 already uses for instances, is that keying. On the solver,
the decidability of each theory does not bound the time a query takes,
and quantifier instantiation is the usual source of unpredictability,
as F*'s tutorial shows; a quantifier-free 𝒯₀, small queries and a
resource count instead of a delay give a verification whose cost is
predictable and repeatable, and since obligations of distinct
definitions are independent, they parallelise without any parallel
solving. What remains specific to K7PL is the cost of precision: the
grade in the interface recompiles dependents when it changes, and
independent typed holes can multiply instances; both are prices
chapter 6 accepts openly, and the budget is the mechanism that bounds
them.

#### Limits of this report

Nothing was measured, on rustc or on any K7PL prototype; Verus's
speed-up is its authors' claim; the parallel rustc front end is
described by a page that calls itself partly outdated; whether Z3's
`rlimit` gives the same count across platforms was not checked, and
chapter 6's reproducible resource count depends on it or on an
equivalent.

#### What remains for the author to decide

Which strategies to adopt (S1 to S8); whether hole widths are rounded
to bound instances (S6); and how 𝒯₀ is delimited, which chapter 6
already leaves open. The choice is asked in the next part.

## Archive review: early K premises (`OLD_K_K7PL`)

Received from the author on 2026-10-27 as `OLD_K_K7PL.zip`, described
as "un vieux (très vieux) dossier (il a plus d'un an) avec les
prémisses K de K7PL", to be sorted, classed, evaluated and criticised
against the current specification "sans y accorder trop
d'importance". The archive is not added to the repository; this
section is the whole of what is kept from it (the author's decision
and the extraction are at its end).

### Facts

- **Content.** 20 modules, each a `.k` file and a French design note
  (`.md`): tokens, the syntax of three layers and their union (01–05),
  types — primitive, template, dimension, linear, traits, union
  (06–11) —, a K configuration (12), evaluation of each layer and
  their union (13–16), memory (17), actors (18), streams (19),
  verification (20). 3,810 lines of K, 1,265 of notes; 398
  `rule`s and 424 `syntax` declarations. The file dates inside the archive are 2026-06-17.
- **State.** The K does not compile with K 7.1.337 (checked
  2026-10-27 on the concatenation of the 20 files): the outer parser
  stops at the first `List{…}` written inside a production
  (`syntax BindBody ::= InitClause List{HandlerClause, ""}`); there
  are 102 such inline lists and 2 `/* empty */` alternatives, and no
  module imports K's built-in domains while 88 lines use `Int` or
  `Map` operations. It is a specification sketch in K notation, not
  a K definition.
- **Unresolved references.** "TDD R1 … R33" (a requirement document
  not in the archive), "LML" (a language for which `$` and `§` are
  reserved), "B+" (the monomorphic template discipline), "G4 stand
  by", and the keyword `sugoi`.

### The layers are numbered the other way round

The archive's layer 1 is the pure, terminating, tacit array core
written in `[ ]`; its layer 2 is the S-expression logic in `( )`,
"purement fonctionnelle", whose handlers return descriptions; its
layer 3 holds declarations in `{ }` — types, actors, streams, memory,
clusters — with "AUCUNE logique applicative", logic being bound from
layer 2 by `bind-to`. The roles of the three delimiters are those of
the current specification; only the numbers are reversed (archive
L1 = current layer 3, archive L3 = current layer 1). The archive's
composition rule, "N appelle ≤ N", is the current descending form
`{ ( [ ] ) }` under that renumbering.

### Classification against the current specification

Verdicts: **kept** (the current specification states the same
thing), **superseded** (the current specification or a decided
answer chose otherwise), **input** (not in the current
specification; material for an open question), **implementation**
(a runtime or code-generation choice outside the specification's
level).

| Archive component | Current specification | Verdict |
|---|---|---|
| Five verified forms `pure`, `terminates`, `logic`, `event`, `contract` (03) | The same five proof keywords, `tab:c5-mots-cles-preuve` | kept |
| Layer-2 handlers return a pure `HandlerResult` description, executed by the runtime (03, 14) | Chapter 3: a pure layer-2 handler returns « une description d'effets » | kept |
| Trains `(f g)` composition, `(f g h)` fork; stack blocks `[dup * +]` typed by stack effects (02) | Chapter 5, same definitions, `[dup *]` has effect `(1 – 2)` | kept |
| Templates monomorphised, « Pas de ∀T », « Pas de ∃T », no higher kinds (07) | Chapter 3 keeps ∀ and ∃, monomorphised in Phase 3; Q-TYP-102 « tout est monomorphé » | input: a stricter position for Q-TYP-301 |
| Traits with `Self`, one instance per (trait, type), static dispatch (10) | `ERR-TYP-010`, `ERR-POL-001` | kept |
| No silent wraparound: overflow returns `Result` (06) | `{result int32 overflow}` in `lst:fonction-pure` | kept |
| `terminates [measure]`, termination by measure, productivity of streams (20) | `ERR-TER-001` « Utiliser un pli ou le mot-clé `terminates` », layer-2 productivity | kept |
| Hot-reload with preserved state (15, 18) | `ERR-DPL-001` | kept |
| Views `tref` without copy (13) | Annex A: « Une vue `tref` s'échappe de son cadre local » | kept |
| No pointer crosses a layer boundary; copy at each crossing (17) | Annex A: absolute pointer in a layer-1 arena refused, relative offsets | kept |
| Backpressure policies `block`, `drop-oldest`, `drop-newest`, `error` (19) | `ERR-CMP-002`: rate mismatch « sans stratégie d'ajustement » | input: the strategies themselves |
| Temporal properties □ ◇ U checked by model checking (20) | Chapter 3: □ ◇ ◯ are types | superseded (integrated in the types) |
| Numbering of layers, `.67` files for tacit code, `¤` prefix for layer calls (01, 02, 03) | Delimiters alone mark layers; one file kind | superseded |
| Typed literals `(i64 42)`, no default numeric type; names `Int64`, `Float32` (01, 06) | `:num int32`, typed holes resolved by the solver (Q-NUM-203); families `int`, `flo`, `dec`… | superseded |
| Types as layer-2 S-expressions, `(Int64 -> Float64)` (03) | Types set in layer 1 only, lowercase, `{function …}` (Q-TYP-201, Q-TYP-202) | superseded |
| `;` comment or row separator in `[ ]` (01, 02) | `;;` comments, `;` disables a tree, `|` separates rows | superseded |
| `#/regex/flags` (01, 03) | `#` is the `comptime` sigil; qualified delimiters (conversation of 2026-10-27) | superseded |
| 2-modifiers `∘` `⊸` `⟜`, 1-modifiers `´ ˜ ¨` `` ` `` `⌜` (02) | `↢` `↣` chosen against BQN familiarity, `⊘` compose; `´` `¨` in chapter 5 | superseded (deliberately) |
| `@var`, `@(match …)` text patterns after TXR (03) | `@` is a sigil read in Phase 0; TXR is cited for layer 2 | input |
| `define` as the definition word (01, 03) | Q-SPEC-203 asks for a generic definition word | input |
| `bind-to` with `init` / `on-message` / `handler-result :new-state :reply :emit` (03) | `lst:gestionnaire`, `lst:acteur`; the author's `:bind` / `:result` (Q-SPEC-202) | input |
| Character literals `'a'`, `'\u{1F600}'`; booleans `true` / `false` (01) | No character literal or boolean name yet | input |
| `+flag` / `-flag` boolean arguments (01) | `+verify`, `+introspect` in chapter 6 | input: a general flag syntax |
| Strings: UTF-8, length in graphemes (UAX #29), grapheme index (06) | Text type and its length still open | input |
| Dimensions as SI exponent vectors over 7 base dimensions, `deftype-op`, `defconversion` (08) | Units after UCUM (Q-NUM-005), `:unit mm` | input: to confront with UCUM |
| Allocation hierarchy Tagged → Stack → Region → Owned → RC → Arena → Linear, annotations `+stack` `+region` `+rc` `+arena` (17) | Each layer is a data structure (arena, heap, stack); RC where sharing is graded | input: meanings of the doubled forms (Q-LEX-402, Q-LEX-403) |
| Commit or rollback of a `HandlerResult`; `emit` sent only after commit (15) | Not stated in these terms | input |
| Flat supervision, restart policies `+restart-always` … (18) | Chapter 4, actor and system scales | input |
| `ask-and-continue`, `scatter-gather`, `saga` (03) | Not in the specification | input: a layer-2 library |
| Modules `(module … (export …) (import …))`; tests `describe` / `it` / `expect` (03) | Module theory in chapter 4, without syntax; specification blocks purged at link time | input |
| `deftype-layout` with explicit offsets, WAT linear memory, `defcluster`, `deploy`, `defsecurity-lattice` (04) | Layout isomorphism theorem, capabilities, confidentiality grade | input |
| HM "B+" inference with holes, no `Any` (11) | Bidirectional checking with an SMT solver; full Damas–Milner given up | superseded |
| Tagged pointers; slab, buddy and mmap allocators; 64-byte alignment, SIMD (06, 02, 17) | — | implementation |
| K configuration of runtime state (12) | Operational semantics of chapter 4 | implementation, as a checklist |

### Interpretation (not decided)

The archive's lasting value is its intent, most of which the current
specification already carries with a renumbered vocabulary; its K is
not reusable as code beside `lexicon/`, which compiles and is checked.
Its inputs are worth a question each where an open point already
exists: the definition word, the handler and actor forms, character
and boolean literals, flags, the length of a text, units, memory
annotations for the doubled forms, transactional handlers, and a
library of layer-2 orchestration patterns.

### Decision and extracted value

The author chose on 2026-10-27 (Q-ARC-001, option A): the archive
stays out of the repository, « Extract remaining value (eg lemme
candidat, glyphes, etc.) Then trash it out. » What follows is that
extraction, made mechanically from the quoted terminals of the
archive's `syntax` declarations and compared with the code spans and
listings of `spec/` and with `tab:glyphes`; the archive itself was
then deleted. Nothing here is decided: these are candidates for the
vocabulary lots.

**Glyphs.** The archive's tacit layer reads 33 glyphs. Twelve are
absent from `tab:glyphes`:

| Glyph | Archive's name | Note |
|---|---|---|
| `´` | fold | named « pli » by chapter 5, absent from the table |
| `¨` | each | named « chacun » by chapter 5, absent from the table |
| `˜` | swap | BQN's Self/Swap |
| `` ` `` | scan | |
| `⌜` | table | BQN's Table |
| `∘` | atop | |
| `○` | over | |
| `←` | definition (`mean ← +´÷≠`) | K7PL defines with `def` (Q-SPEC-203) |
| `«` `»` | shift | `« s »` is now the view of a raw text (Q-STR-308) |
| `√` | square root | written by chapter 5's standard deviation, absent from the table |
| `⊐` | index of | |
| `⊑` | pick | |

Chapter 5 also writes `²` (square), which neither the table nor the
archive holds. The aliases of these glyphs (`fold`, `each`, `sqrt`,
`square`…) are the direction chosen by Q-LEX-505, each still to weigh.

**Candidate lemmas.** Of the archive's 224 keyword terminals, 38 are
already written by the specification (`lambda`, `let`, `match`,
`pure`, `terminates`, `event`, `contract`, `logic`, `defactor`,
`deftype`, `bind-to`, `spawn`, `send`, `dup`, `guard`, `when`…). The
others, grouped, without the machine types (`i8`…`u64`, `f32`, `f64`,
superseded by the number families), `true` and `false` (superseded by
`t` and `f`, Q-LEX-506), and two words without meaning (`hello`,
`sugoi`):

- Definitions and declarations: `define`, `define-computation`,
  `deftemplate`, `deftrait`, `definterface`, `defstream`, `defstage`,
  `deforchestrator`, `defmemory`, `defcluster`, `defconversion`,
  `deftype-layout`, `deftype-op`, `defsecurity-lattice`, `impl`,
  `self`, `requires`, `needs-cap` — candidate envelopes of `def`
  (Q-SPEC-204).
- Layer-2 orchestration: `ask`, `ask-and-continue`, `scatter-gather`,
  `collect-from`, `feed-to`, `msg-to`, `pipeline`, `consume`,
  `connect`, `reply`, `on-message`, `init`, `handler-result`,
  `stage-result`, `with-state`, `transfer`, `revoke`, `keep`, `quota`,
  `priority`.
- Control and quotation: `if`, `for`, `apply`, `quote`,
  `quasiquote`, `unquote`, `lazy`, `mut`, `imm`.
- Stack words of concatenative blocks, beside `dup`: `swap`, `rot`,
  `nip`, `over`, `dip`, `pop`.
- Bit operations: `bit-and`, `bit-or`, `bit-xor`, `bit-not`,
  `bit-shift-left`, `bit-shift-right`.
- Memory: `in-region`, `shared-mem`, `mem-load`, `mem-store`,
  `mem-grow`, `mem-size`, and the flags `+stack`, `+region`, `+rc`,
  `+arena` (doubled forms, Q-LEX-401 to Q-LEX-403; flags, Q-LEX-507).
- Supervision and life cycle: `+restart-always`, `+restart-never`,
  `+restart-max`, `+restart-with-state`, `+sandbox-none`,
  `+sandbox-process`, `+sandbox-region`; the states `created`,
  `idle`, `running`, `paused`, `restarting`, `crashed`, `completed`,
  `dead`.
- Streams: `backpressure` and its policies `block`, `drop-oldest`,
  `drop-newest`, `error` (`ERR-CMP-002`).
- Tests: `describe`, `it`, `expect`, `expect-err`, `fuzz`,
  `:to-equal`.
- Properties: `:emit`, `:new-state`, `:reply`, `:reply-to`,
  `:on-timeout`, `:on-reply`, `:on-partial`, `:timeout`, `:invariant`,
  `:guard`, `:unit`, `:dimension`, `:offset`, `:align`, `:padding`,
  `:size`, `:policy`, `:growth-policy`, `:replicas`, `:targets`,
  `:security`, `:read`, `:write`, `:read-write`, `:cpu`, `:memory`,
  `:host`, `:port`, `:metrics`, `:logs`.

**Other value**, already carried by the classification above: the
allocation hierarchy and its annotations, commit or rollback of a
`HandlerResult` with `emit` sent after commit, the backpressure
policies, SI dimension vectors, `@` text patterns after TXR (now the
author's reservation of `@`, Q-STR-307), and the layer-2 patterns
`ask-and-continue`, `scatter-gather` and `saga`.

## Research lot closure

The research closing of 2026-10-25 closed the 53 files of
`docs/research/` (29 prose files plus the 24-file k7pl-os
dossier, moved as a whole). Verdicts, not registers, were
carried forward; the detail of every file, with its reason,
is in the migration matrix. What survives as work is this.

### Manuscript backlog: six state-of-the-art questions

The only file in the lot that was naturally integrable
contributed its backlog, extracted item by item: six
"to explore for a future state of the art" notes, removed
from `spec/` on 2026-10-01 because they were tracking notes,
not text. They are open research questions, not claims:

- rich diagnostic conventions in contemporary compilers
  (Rust, Elm, Roc) and the type error message as a research
  object in its own right (Wand; Heeren, Hage and
  Swierstra) — for the former annex A;
- the Language Server Protocol; interactive proof
  environments with typed holes (Agda, Idris, Hazel);
  deterministic-replay debuggers (rr, Pernosco);
  interactive-computation notebooks (Jupyter) against the
  tabular REPL — for the former annex B;
- typed structured shells (Nushell, PowerShell, Elvish);
  the command/query convergence argument (jq, Miller);
  Unix stream combinators as a fragment of a more general
  calculus (McIlroy) — for the former annex C;
- content-addressed package managers (Nix, Guix, Unison);
  proof-carrying code (Necula); eliminating the software
  supply chain as an attack surface — for the former
  annex D;
- the APL/J/K/BQN/Uiua notational tradition, and usability
  studies comparing symbolic notation with textual aliases
  in programming pedagogy — for the glyph table;
- region-based memory management (Tofte and Talpin);
  hash-consing and persistent structures (Appel; Baker);
  comparison with the GC-free memory hierarchies of Rust
  and Zig — for the memory models chapter.

Two further removed notes are not backlog: a type-isolation
note (the Singularity bet shifting isolation weight onto
compiler correctness, with no residual-risk measure
produced) and a superseded arbitration note (End
self-duality, moot since protocol forms became surface
syntax). Both survive in git history only.

### September analyses: verdicts already carried, three points open

The three September 2026 analyses (terminal coalgebra
forms; finite biproduct and codereliction; the
probabilistic opening through measurable cones) were
agent analyses, not ratified, predating the October
changes to `spec/`. Their verdicts are already carried
elsewhere and are not reopened here: the terminal
coalgebra is primitive but lacks its two rules, and
codereliction is set aside, in the primitive inventory
above. Three points they left open are carried here as
open research items, explicitly **not revalidated against
the current specification** — revalidation is a task of
the roadmap section "Work the research lot follow-ups",
and the argumentative detail stays in git history:

- whether restricting sizes to ℕ∞ \ {ω} collides with a
  real use (rationals are in the grade structure for
  divided read capabilities; no fractional size is known
  to make sense, but grade uses must be reread first);
- whether size quantification needs size variables distinct
  from type variables;
- which concrete model, if any, carries the size coding
  (an impredicative realisability model interpreting sizes
  as an uncountable ordinal was invoked, with what the
  category must verify left unstated), under the standing
  reserve that any concrete model retained for the
  category must be checked against two abstentions: it
  is not a Lafont category, and it has no finite
  biproducts, lest it give the language a codereliction
  it does not declare. The probabilistic extension itself
  is declared out of scope but not out of reach, needing
  no new connector; whether integrable cones carry a
  graded exponential over the resource structure is
  already listed among the open questions above.

### Positioning, empirical agenda, and archives

- **Positioning.** The comparison skeleton against graded
  and quantitative systems is not integrated: its
  "Difference with K7PL" column was reserved for the owner
  and left empty by construction. It becomes a section of
  this page only once the owner fills it; until then it
  is an open decision in [decisions](decisions.md) and a
  task of the roadmap section "Work the research lot
  follow-ups". The same holds for its two reading
  questions and for whether further keys become rows.
- **Empirical agenda.** The empirical register's three
  DONE entries were protocols, not results (expressivity
  cost of the two postulates; expressivity cost of
  delimitation, measurable on text alone once the syntax
  is frozen — the only measure that waits for nothing;
  the hardware reference model, requalified as relative
  to a profile). Its nine TODO entries (execution cost
  of guarantees once erasure is effective; the two axes
  of the testing agenda; annotation burden, learning
  curve, diagnostic quality, compilation time, comparison
  against a witness language) are agenda items
  conditioned on an executable kernel, carried by the
  roadmap section "Work the research lot follow-ups",
  not prose of this page.
- **Parallel and spawn studies, codes, and the T-68
  proposal (PR #10 archive).** Non-normative archive
  material, never reviewed or ratified, PR closed without
  merging. Nothing is extracted from it in bulk, and
  nothing is cited from its translations as a source:
  any variant, code or candidate it holds can only be
  taken up by an individual author decision, after
  revalidation against the current `spec/`. Its
  concurrence overlap with the k7os R4 brief does not
  duplicate it (different bases and statuses).
- **Corpus.** The 8,236-line corpus is a bibliographic
  and ergonomic working instrument, not content: the
  structured bibliography is already closed in the wiki
  assets, corpus constitution is already a section of
  [method](method.md), and segments identified but not
  imported and not read cannot be integrated. It is
  abandoned as an instrument, with its reason traced;
  only precise author syntheses, one by one, could one
  day join this page.
- **Pointers and superseded briefs.** The four one-page
  historical pointers, the three French k7os instruction
  drafts (superseded by the English R0/R1/R2 reports),
  the former annex E preamble (the annex having been
  folded into chapters 1, 3 and 4 on 2026-10-01), and
  the September QA-28 verdict (already itemised in
  [decisions](decisions.md)) are abandoned simply, with
  reasons traced; no historical matter from them is
  recopied here.

## What was dropped in consolidation

- The old `docs/RESEARCH.md` carried a long, file-by-file index of
  `docs/research/` and `docs/bibliography/`, with one-line summaries
  of each working file. That index is not reproduced here. Reproducing
  it would have created a second, diverging index for material that
  has not yet been evaluated file by file. The index will be rebuilt
  from the evaluation lots themselves, not copied forward.
- The old page's statement that the former Arc G and corpus registers
  "have been retired from this active research list" is preserved in
  substance in the core-vocabulary summary above: their provenance,
  contradictions, and source pointers are consolidated in the
  core-vocabulary historical inventory, and the former historical
  copies were closed with the history directory on 2026-10-25,
  traced in the migration matrix.

## Primitive inventory

This table is the successor of `docs/tracking/primitives.md`
(the T-68 primitives register), deleted in the complete
tracking, review and method closing of 2026-10-25. The
register's header recorded 45 entries marked DOING at
2026-10-08, but the file as deleted contained 48 headings
marked DOING; the 48 rows below are the operative list and
the 45 is a stale header count, not to be quoted as
current. Titles are translated into English from the
register's French headings; the full per-entry research
prose — candidate words with the argument for and
against each — is preserved in the dedicated page
[primitives](primitives.md), restored at the owner's
request on 2026-10-25 because it is an important
research point that must not be lost. Each row below
is an open research question, and the work that closes
it is in [roadmap](roadmap.md), "Close the primitive
research register": retain the primitive with a
definition and its laws, merge it into another
primitive, or explicitly abandon it with a reason.
Nine DONE verdicts from the register were already
integrated into this page before this lot and are not
reopened here. The Rule column is
the machine-readable input repointed for
`scripts/spec_checks/cross_check.py`, which cross-checks the
term grammar against the typing rules and this list;
rule names beyond the checker's expected table (vector
mapping, spawn, mailbox operations, recovery) are listed
here because the register lists them, not because the
checker governs them.

| Rule | Primitive research question | Status |
| --- | --- | --- |
| `Var` | Designate a binding | DOING |
| `Lam` | Build a computation awaiting an argument | DOING |
| `App` | Apply a computation to a value | DOING |
| `Th` | Suspend a computation into a value | DOING |
| `Fo` | Resume a suspended computation | DOING |
| `Ret` | Inject a value into a trivial computation | DOING |
| `Let` | Sequence two computations, binding the first's result | DOING |
| `One` | Denote the sole value of the unit type | DOING |
| `OneE` | Consume the unit without binding anything | DOING |
| `Pair` | Join two disjoint resources | DOING |
| `Split` | Undo a pair, binding its two components | DOING |
| `Inj` | Mark a value with a sum tag | DOING |
| `Case` | Choose a branch by tag | DOING |
| `With` | Offer several observations on one computation | DOING |
| `Proj` | Select an observation | DOING |
| `Pack` | Hide a type witness | DOING |
| `Open` | Open a hidden witness without letting it escape | DOING |
| `Box` | Enter under a graded modality | DOING |
| `Unbox` | Exit a graded modality, restoring the grade | DOING |
| `Sc` | Interpret an effectful computation in a given model | DOING |
| `Op` | Trigger a signature operation | DOING |
| `Fold` | Fold a type fixed point | DOING |
| `Unfold` | Unfold a type fixed point | DOING |
| `Out` | Observe a coinductive fixed point | DOING |
| `Cop` | Define by observations | DOING |
| `Gen` | Generalise over a type variable | DOING |
| `Inst` | Instantiate a type variable | DOING |
| `Del` | Defer a computation by one step | DOING |
| `Alw` | State a permanent guarantee | DOING |
| `Alw^{-}` | Use a permanent guarantee | DOING |
| `Now` | State an immediate guarantee | DOING |
| `Wait` | Defer an eventual guarantee by one step | DOING |
| `When` | Consume an eventual guarantee | DOING |
| `VecI` | Fold an indexed family under a grade | DOING |
| `VecE` | Fold an indexed family under a grade | DOING |
| `Par` | Put two computations in parallel | DOING |
| `Vmap` | Apply a function to a whole vector | DOING |
| `Spawn` | Spawn a concurrent task | DOING |
| `Slice` | Split a write capability | DOING |
| `New` | Create a mailbox | DOING |
| `Send` | Send a message to a mailbox | DOING |
| `Guard` | Receive under guard | DOING |
| `Free` | Free an empty mailbox | DOING |
| `Nxt` | State a guarantee for the next step | DOING |
| `Loc` | Attest that a value is at a location | DOING |
| `Declassify` | Lower the level of a value named in advance | DOING |
| `At` | Localise a computation | DOING |
| `Move` | Move a value from one location to another | DOING |
| `Try` | Recover from a failure | DOING |
