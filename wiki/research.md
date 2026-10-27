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
  Reference, Unicon Technical Report 8c, 2017,
  http://unicon.org/utr/utr8.pdf. The Icon reference itself was
  not checked.
- **Tcl.** Two groupings: double quotes, with substitutions, and
  braces, with "No substitutions" and braces that "nest within the
  word"; backslash sequences `\a \b \f \n \r \t \v \\ \ooo \xhh
  \uhhhh \Uhhhhhhhh`; for backslash-newline, "A single space
  character replaces the backslash, newline, and all spaces and
  tabs after the newline." Source: Tcl 8.6 manual page `Tcl`
  (rules 4, 6 and 9),
  https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm.
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
  https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm.
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
  (http://www.ada-auth.org/standards/22rm/html/RM-3-5.html); "Discrete
  types are either integer types or are defined by enumeration of their
  values (enumeration types)"
  (http://www.ada-auth.org/standards/22rm/html/RM-3-2.html), as
  `type Color is (White, Red, Yellow, Green, Blue, Brown, Black);`
  (http://www.ada-auth.org/standards/22rm/html/RM-3-5-1.html).
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
