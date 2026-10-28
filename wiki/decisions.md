<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Decisions

> **Provenance — Lot 2 (draft, pending validation).**
> Consolidated 2026-10-25 from three registers: the architecture
> decision records in `docs/decisions/`, the decisions and
> ratifications register in `docs/tracking/DECISIONS.md`, and the
> migration decisions formerly in `docs/migration/L1-DECISIONS.md`
> (deleted in the migration closing of 2026-10-25, traced in
> the migration matrix, surviving in git history).
> Maintainer decisions about security are summarised by theme in
> [security](security.md) and are not duplicated here as a
> second register.
> Status: draft. Nothing in this page is validated until the owner
> validates it. The tracking register was itemised here and
> deleted locally in the complete tracking, review and method
> closing of 2026-10-25, pending that validation; until then
> it survives in git history. The architecture records and the
> migration decisions remain the interim references for their
> sections.
> Titles in this page are descriptive, in plain language. Former
> internal labels appear only in small provenance lines, where
> they are needed to find the exact source section. A decision
> recorded here is not automatically normative: owner ratification
> is what makes it so, and a decision recorded as applied but not
> confirmed is marked as such.

## How to read this register

- **Decided:** the owner has decided, and the decision is in
  force unless a later decision revises it.
- **Accepted on merge:** a record whose effect begins when the
  owner merges the pull request that adds it.
- **Applied, awaiting ratification:** the decision is already
  applied in practice but has not been confirmed by the owner.
- **Proposed:** a proposal, partly decided at most, awaiting a
  full owner decision.
- **Open:** the owner must still choose; this page presents the
  options and does not choose among them.

Where a decision below says "owner decision needed", that is a
genuine open point, not a formality. Agent analysis in a source
register does not replace an owner decision.

## Architecture decisions, by theme

### Trust order and normative status of the executable text

The executable text is trusted in a defined order relative to
the normative specification, and conflicts about the scope of
the executable language and about non-normative pages are
addressed by specific items in the source record.
*Status: proposed, partly decided by the owner. Provenance
(secondary): architecture decision record 0001.*

### One concept, one home, no Lean mirror

Each concept has a single home. In particular, the project does
not maintain a Lean mirror that duplicates a concept held
elsewhere.
*Status: proposed. Provenance (secondary): architecture decision
record 0002.*

### Executable blocks in the specification, and extraction

Executable blocks live in the specification source and are
extracted by tooling, rather than being maintained as separate
executable files that could drift from the specification.
*Status: superseded by record 0013 (owner decision of
2026-10-26). Provenance (secondary): architecture decision
record 0003.*

### Profile of the executable language

The project defines a specific profile of the executable
language it uses, rather than adopting the whole language
without restriction.
*Status: proposed. Provenance (secondary): architecture decision
record 0004.*

### Executable axiom policy

The policy for axioms in executable artefacts is proposed, with
one open question about the classical choice principle: whether
it may be used, and under what conditions.
*Status: proposed, awaiting that owner decision. Provenance
(secondary): architecture decision record 0005.*

### Audited translator from executable to Lean

Translation from the executable language to Lean is treated as
an audited translator, not as an informal conversion: its
output must be checkable and its limits stated.
*Status: proposed, partly decided by the owner. Provenance
(secondary): architecture decision record 0006.*

### Computed assurance statuses

Assurance statuses are computed from evidence rather than
asserted by hand, under rules that must themselves be stated.
*Status: proposed. Provenance (secondary): architecture decision
record 0007.*

### Initially out of scope

Certain topics are explicitly declared out of scope at the
start, so that later work does not silently expand the project
into them without a new decision.
*Status: proposed. Provenance (secondary): architecture decision
record 0008.*

### Representation of pure-layer arrays

How arrays in the pure layer are represented is proposed, with
one open question awaiting an owner decision.
*Status: proposed, awaiting that owner decision. Provenance
(secondary): architecture decision record 0009.*

### Pinned versions and version upgrades

Versions of tools and libraries are pinned, and upgrades follow
a stated procedure, with exact versions to be filled in where
the record still leaves them open.
*Status: proposed, exact versions partly decided by the owner.
Provenance (secondary): architecture decision record 0010.*

### Decision records, roles and workstream organisation

How decision records are written, who holds which role, and
how the remaining workstream is organised are fixed by this
record.
*Status: accepted on merge. Provenance (secondary): architecture
decision record 0011.*

### Executable language as the normative home for type and automata grammar

The executable language is the normative home for the grammar
and semantics of the type chapter and the automata chapter,
rather than those chapters holding a second, competing
definition.
*Status: accepted on merge. Provenance (secondary): architecture
decision record 0012.*

### K sources in `lexicon/`, displayed by the specification

Every K file lives in `lexicon/` and is displayed, without
rewriting, by a `K` block of the specification, which stays its
normative view; only the Python checker is still extracted from
the specification.
*Status: accepted on merge (owner decision of 2026-10-26).
Record 0013; supersedes record 0003.*

## Architecture decision records, in detail

The theme summaries above are the short form. This section
carries the detail of the twelve architecture decision
records (ADRs) from `docs/decisions/`, and of record 0013, added
on 2026-10-26, (deleted in the
security, decisions and docs-root closing of 2026-10-25):
the options considered and rejected, the confirmation check
that enforces each decision, the dependencies and gates,
and the owner decisions already given with their exact
scope. Nine records stay Proposed, two are Accepted, record
0013 is accepted on merge and supersedes record 0003; a partial
owner decision leaves its record Proposed, as the conventions
below require.

### Record conventions

From the records' index (itself fixed by the accepted
record on decision records, see below) and its template,
which is superseded by this section:

- **Format:** MADR "minimal" plus project fields. Sections:
  Context and Problem Statement; Considered Options;
  Decision Outcome, with Consequences and Confirmation
  (the check that enforces the decision); More Information.
  A Proposed record that the owner has partly decided adds
  "Owner decisions already given"; open questions go in
  "Open questions".
- **Fields:** Status, Date (last status change),
  Decision-makers, Proposed by, Decisions register, Depends
  on, Gates. Text is in English (only `spec/` is French);
  the owner's French words are quoted as given.
- **Numbering:** four digits from `0001`, never reused,
  written `ADR-0001`; the file was `NNNN-english-slug.md`.
- **Statuses:** `Proposed`, `Accepted`, `Rejected`,
  `Superseded by ADR-NNNN`. A decision that changes is
  recorded by a new record; the old one becomes Superseded.
- **Decision-maker:** the owner only (maintainer account
  `AntheaLiles`). Never an agent, never a placeholder.
  Roles the KLean plan gave to separate people are hats of
  the owner: author (spec hat), author (proof hat),
  author (tooling hat).
- **Acceptance:** a record is accepted when the owner
  merges the pull request that sets its status to
  Accepted; the merge commit by the maintainer account is
  the record. An agent never decides the status; it writes
  Accepted only to record a decision the owner has already
  given, quoted with its source.
- **Partial decisions:** when an owner decision settles
  only part of a record, the record stays Proposed and
  quotes the owner's words with the part they settle.
- **Normative words** MUST, MUST NOT, SHOULD, MAY are
  used as in RFC 2119.
- **KLean plan identifiers:** records 0001–0010 are
  ported from the plan "Workflow KLean K7PL"
  (18 October 2026), a session document not deposited in
  the repository. Its identifiers are kept as written:
  principles PR-1–PR-8, work packages WP0–WP11, gates
  G1–G10, tests T1–T6, obligations O1–O13, profile rules
  K1–K9, open questions Q1–Q7, milestones M1–M4, task
  cards T-000–T-405. They are unrelated to the master-plan
  workstreams and sub-items (C1…, H1…, N0…) and to the
  proof-visualisation milestones M1–M7.

### Dependency graph

From the plan's index ("X ──► Y" means Y depends on X):

```text
0001 ──► 0002 ──► 0003 ──► 0004 ◄── 0006 ◄── 0005
  │                          │        │
  └──► 0008                  └► 0009  └──► 0010

0003, 0006 ──► 0007

0003 is superseded by 0013 (2026-10-26); the records that
depended on 0003 now depend on 0013.
```

### Open questions of the KLean plan

| Question | ADRs | Follow-up |
| --- | --- | --- |
| Q1 — Exact names and definitions of the three layers; matrix of allowed crossings | 0003, 0004, 0009, 0012 | Roadmap: Decide the remaining representation and translation questions |
| Q2 — Orchestrator model: sequential or concurrent? Determinism required? | 0002, 0004, 0012 | Roadmap: Decide the remaining concurrency questions |
| Q3 — Array representation; footprints on whole arrays or slices? | 0009, 0004 | Roadmap: Decide the remaining representation and translation questions |
| Q4 — Are the fragments (ownership, grade, effects) and the algebraic laws of grades still current? | 0002, 0012 | Roadmap: Decide the remaining representation and translation questions |
| Q5 — Is `Classical.choice` admitted (constructive requirement or not)? | 0005 | Roadmap: Decide the remaining representation and translation questions |
| Q6 — Version a snapshot of the generated outputs? | 0010 | Roadmap: Decide the remaining editorial and tooling questions |
| Q7 — Typing defined in K (algorithmic) or as a separate Lean judgment? | 0002, 0012 | Roadmap: Decide the remaining representation and translation questions |

Owner decision 53 answers "ok => à faire" for records
0003–0010, Q1–Q6 and the instruction item N-8 (Lake
targets or Makefiles for the chain): the work is
requested; no question is answered by it.

### Trust order and normative status of the executable text

*Status: Proposed, partly decided. Depends on: none.
Gates: G6, G8. Provenance (secondary): architecture
decision record 0001.*
Proposed outcome: the Verso specification is normative,
comprising the prose, the normative K blocks (record
0003) and the statements of Lean theorems; the normative
K text is part of the specification, while the K tools
(`kompile`, `krun`, `kore-rpc`, `kprove`) are witnesses,
not normative artefacts. Rejected: K as the source of
truth for the proofs (contradicts the intended trust
order); Lean first with a hand-rewritten operational
semantics (duplicates definitions, see record 0002);
prose-only specification without normative K (grammar
and semantics would be neither executable nor
verifiable). Confirmation: G6 (trace replay and
unique-successor check); G8 (every status downgrade
requires a record reference); an issue label
`spec-conflict` with a dedicated template. None of
these checks exists in the repository yet.
Owner decisions already given: item 48 (2026-10-19),
"K code blocks in the Verso files are normative" —
this settles the K-text clause and the part of the
normative specification that counts the K blocks, applied
on `main` by PR #255. Item 44 is related (see record
0012).
Follow-up: Roadmap: Ratify the applied decisions.

### One concept, one home, no Lean mirror

*Status: Proposed. Depends on: 0001. Gates: review, G9.
Provenance (secondary): architecture decision record
0002.*
Proposed outcome: each concept has a single home —
surface grammar in K (`syntax` blocks), operational
semantics in K (`rule` blocks), automata and orchestrator
in K (`automaton`, `orchestrator` blocks), algorithmic
typing in K (subject to Q7), layers, footprints and
bridges in the metadata of the Verso blocks (record
0003). Rejected: double definition plus differential
tests (doubled cost, tests covering only a corpus);
Lean as the home of the grammar (K is better suited
and serves as the basis for execution). Confirmation:
a PR-1 checkbox in the pull-request template; a
heuristic mirror detector (non-blocking), comparing
constructors of hand-written inductives with those of
KGen by name and arity and reporting similarities; G9
(a normative K rule without an associated obligation
fails).
Open: Q7 (typing in K or separate Lean judgment,
blocking the algorithmic-typing row and work packages
WP9, WP11); Q4 (fragments and grade laws still
current).
Owner decision already given: item 44 (2026-10-19),
option (b) (see record 0012), pointing the same way.
Follow-up: Roadmap: Decide the remaining
representation and translation questions.

### Executable blocks in the specification, and extraction

*Status: Superseded by record 0013 (owner decision of
2026-10-26, quoted there). Depends on: 0001, 0002. Gates:
G1, G2, G10. Provenance (secondary): architecture
decision record 0003.* The text below is kept as the
record's history.
Proposed outcome: normative K MUST reside only in `k`
blocks of the `SpecK.*` modules; `.k` files are build
artefacts generated by extraction, never versioned nor
edited; each block carries an attribute contract
(`module` required, K module name; `id` required,
stable and unique, equal to the K `label` for `rule`
and `automaton` blocks, with further attributes in the
record). Rejected: canonical `.k` files included in
Verso by label (inverts the literate logic; kept as
plan B should the Verso extension prove infeasible on
the pinned version); running `kompile` at Verso
elaboration (non-reproducible, slow,
environment-dependent). Confirmation: G1 (elaboration
of `SpecK`: attributes, uniqueness); G2 (identical
extraction on two runs, hashes consistent with the
manifest); G10 (HTML/PDF build, valid links and
anchors).
Open: the mechanism — PR #235 already extracts K from
Verso with `tools/SpecExt/CodeArtifacts.lean`
(`@[code_block]` expanders, a `block_extension`,
extraction by `lake exe spec --extract-code-only`
into `src/k/.build/generated/`), which differs from
the contract above (one file per block, no attributes
in the current form).
Owner decisions already given: item 48 (2026-10-19),
K blocks normative (premise of clause 1, applied by
PR #255); item 53, work requested, profile not
accepted by it; 2026-10-26, every `.k` file lives in
`lexicon/` (`lexemes/`, `syntax/`) — the option this
record rejected and kept as plan B (canonical `.k`
files included in Verso) is the one applied: each `K`
block displays a file of `lexicon/`, read at
elaboration, and the extraction pass refuses a K file
that no block displays. The K blocks stay normative.
The attribute contract (`module`, `id`) is not
applied. The record stays Proposed.
Follow-up: Roadmap: Build the remaining checks and
tools; Ratify the applied decisions.

### Profile of the executable language

*Status: Proposed. Depends on: 0003, 0006. Gates: G4.
Provenance (secondary): architecture decision record
0004.*
Proposed outcome: normative K (blocks with
`normative=true`) MUST respect profile rules K1–K9,
including: every rule has a `label` equal to its
block's `id` (K1); no `priority`, `owise` or `ensures`
in the normative semantics (K2); every `function`
marked `total` with exhaustive cases (K3); hooks
limited to an allowlist (basic `INT` and `BOOL`
operations, with the full list in the record).
Rejected: full K plus accepted over-approximation
(existential properties lost); full K plus an in-house
generator handling everything (high immediate cost;
remains an option of record 0006). Confirmation: G4
(any violation not covered by a derogation fails CI);
the linter has one positive and one negative case
tested per rule. Neither the linter nor G4 exists in
the repository yet.
Open: Q1 (layer names and definitions, allowed-crossing
matrix); Q2 (orchestrator model); Q3 (array
representation, record 0009).
Owner decisions already given: item 53 (work
requested, profile not accepted); items 43 and 52
related (Prelude route; automata definition).
Follow-up: Roadmap: Decide the remaining
representation and translation questions; Build the
remaining checks and tools.

### Executable axiom policy

*Status: Proposed, awaiting Q5. Depends on: none.
Gates: G5. Provenance (secondary): architecture
decision record 0005.*
Proposed outcome: allowlist `propext`, `Quot.sound`,
`Classical.choice` (Q5 open: if a constructive
requirement is chosen, `Classical.choice` is removed
and the Mathlib dependencies concerned must be
identified; the recommendation is to allow it, since
a large part of Mathlib depends on it); forbidden in
`proofs/` and in the Prelude: `sorryAx`,
`Lean.ofReduceBool`, hence no `native_decide`, with
the full forbidden list in the record. Rejected:
checking with `#print axioms` alone (known blind
spots); allowing `native_decide` with documentation
(contrary to the specification's requirement).
Confirmation: G5 (an axiom outside the list, a
forbidden attribute, or a failure of the external
re-check makes CI fail).
Open: Q5, blocking gate G5. The KLean instruction
notes that the allowlist is de facto in force today:
`scripts/axiom-audit.sh` already enforces
`propext, Classical.choice, Quot.sound`.
Owner decisions already given: item 53 (work
requested); item 43 related (Prelude route, option
(c): generate with `-r` (selected rules) and/or a
patched, project-owned Prelude excluding the Map/Set/
List collection hooks — this answers whether "no new
axiom" covers the generated Prelude).
Follow-up: Roadmap: Decide the remaining
representation and translation questions.

### Audited translator from executable to Lean

*Status: Proposed, partly decided. Depends on: 0004,
0005. Gates: G5, G6. Provenance (secondary):
architecture decision record 0006.*
Proposed outcome: klean is the chosen KORE → Lean
translator, in a pinned version (record 0010); its
output goes to `build/lean-gen/KGen/` and MUST NEVER
be edited; a mandatory audit (WP4) on minimal K
definitions, one per behaviour to test (hooks,
uninterpreted functions, axioms, substitutable `def`s,
with the full audit table in the record); a decision
tree (clause 7) for what to do when the audit fails.
Rejected: an in-house generator from the start (high
immediate cost; remains an option); deep embedding in
Matching Logic / AML (out of scope, record 0008);
hand-rewritten semantics (forbidden by record 0002).
Confirmation: G5 on KGen plus Prelude; G6 on the
corpus; the audit redone at each klean version
upgrade.
Open: the clause-7 decision tree waits for the klean
audit (T-401) on the fixture corpus (T-300); whether
the existing shim, which removes one generated
declaration, is a "compatibility" change under clause
4 or an edit under clause 1.
Owner decisions already given: item 43, option (c)
(Prelude route, settling how clause 3 — a Prelude
without axioms — is to be realised); item 53 (work
requested).
Follow-up: Roadmap: Prove the remaining formal
obligations; Build the remaining checks and tools.

### Computed assurance statuses

*Status: Proposed. Depends on: 0003, 0006. Gates: G8,
G10. Provenance (secondary): architecture decision
record 0007.*
Proposed outcome: recognised statuses with conditions
— `defined` (normative K block extracted, compiled,
linter-compliant), `proved` (Lean theorem built,
axiom-audit compliant per record 0005),
`proved-transferred` (proved, universal, on
`KGen.Rewrites`), `proved-exact` (proved, existential,
under the record's conditions), with further statuses
in the record; statuses are computed from evidence,
never hand-entered. Rejected: statuses in the prose
or in manual attributes (prone to drift).
Confirmation: G8 (downgrade), G10 (build and badges),
G9 (orphan rules). None of these gates exists in the
repository yet.
Open: relation with the C8 statement ontology
(KLean instruction, conflict X-6):
`tools/SpecExt/Theorem.lean` carries an author-declared
`epistemicState` and `evidence` by design, while
clause 2 forbids manual statuses; options listed by
the instruction (item N-4, not yet put to the owner)
are recorded in the source, not decided here.
Owner decisions already given: item 53 (work
requested); item 47 related ("all traceability
elements computed and reliably exposed and proved by
Lean tooling" — setting the direction of clause 2).
Follow-up: Roadmap: Build the remaining checks and
tools; Close the statement migration gate.

### Initially out of scope

*Status: Proposed. Depends on: 0001. Gates: review.
Provenance (secondary): architecture decision record
0008.*
Proposed outcome: the following are out of scope
until milestone M3, unless reopened by a record:
Lean ↔ K FFI (Lean FFI unstable, no demonstrated
need; reopening criterion: measured performance need
without impact on `proofs/`); permanent RPC service
(operational complexity; reopening criterion:
symbolic campaigns not feasible with one-off calls);
deep embedding in AML; and the further items listed
in the record, each with its reason and reopening
criterion. No alternative is listed in the draft.
Confirmation: review — any pull request introducing
an item of this list cites a reopening record.
Open: none of Q1–Q7 bears on this record; the
milestones M1–M4 are defined by the plan, which is
not deposited in the repository.
Owner decisions already given: item 53 (work
requested; the list is not accepted by it). The
record stays Proposed.
Follow-up: none, unless a reopening record is
proposed — Roadmap: Decide the method open points.

### Representation of pure-layer arrays

*Status: Proposed, awaiting Q3. Depends on: 0004,
0005. Gates: G4, G5. Provenance (secondary):
architecture decision record 0009.*
Proposed outcome: option A for milestones M2–M3,
option C if `krun` performance becomes a measured
bottleneck (T3 campaigns). Options: A — user-defined
K constructors (arrays as K sorts and total
functions, without hooks, no axioms, medium proof
effort for basic lemmas); B — hooked collections plus
Lean implementation (K hooks; Lean Prelude with
`def`, Mathlib List/Array/Vector; no axioms if the
Prelude is complete); C — hybrid (A for the
normative part, B in a separate execution profile).
Basic operations (read, write, size, map, fold,
slice) MUST be K `function`s marked `total` (record
0004, K3) defined in `layer=3` blocks, with basic
Lean lemmas (size preserved, read/write independence
on distinct indices, and the rest in the record).
Confirmation: G4 (no hooked collection in normative
K, unless C is adopted, and then only in the
execution profile); G5 on the basic lemmas; T4 if
option B or C is chosen.
Open: Q3 — footprints on whole arrays or on slices?
Sizes static (known at elaboration) or dynamic? Are
multi-dimensional arrays needed from M2? Q1 (layer
names) also bears on it.
Owner decisions already given: item 53 (work
requested; Q3 not answered); item 43 related
(Prelude route).
Follow-up: Roadmap: Decide the remaining
representation and translation questions.

### Pinned versions and version upgrades

*Status: Proposed, exact versions to be filled in,
partly decided. Depends on: 0006. Gates: G3, G5.
Provenance (secondary): architecture decision record
0010.*
Proposed outcome: the target Lean version is the one
supported by klean and the tested shim, not
automatically the latest stable version; pinned
versions by mechanism — Lean in `lean-toolchain`,
Mathlib, CSLib and Verso (plus Blueprint if used)
in `lake-manifest.json`, K Framework (kompile,
backends) by container image or Nix digest — with
the version table in the record still to be filled
in, and an upgrade procedure whose steps are stated
there. No alternative is listed in the draft.
Confirmation: G3 and G5 run with the pinned
versions; CI fails if the detected version differs
from the table.
Open: Q6 (version a snapshot of the generated
outputs? — today a CI artefact only); bump policy
for `proofs/`, `spec/formal-chain/` and the shim
(KLean instruction, X-12, item N-9: the monthly
`bump-lean.yaml` workflow regenerates only the root
toolchain, as recorded in the source).
Owner decisions already given: item 50 (2026-10-19):
the Lean version is not changed now
(`leanprover/lean4:v4.34.0` in `lean-toolchain`,
`proofs/` and `spec/formal-chain/`); a migration to
v4.36 (or later) is to be planned. Item 53 (work
requested).
Follow-up: Roadmap: Decide the remaining editorial
and tooling questions; Build the remaining checks
and tools.

### Decision records, roles and workstream organisation

*Status: Accepted on merge. Depends on: none.
Gates: none. Provenance (secondary): architecture
decision record 0011.*
Chosen options, as proposed in the process note, to
which the owner answered "oui" on 2026-10-20 (owner
decision 49; no further rationale was given by the
owner): decision records as MADR files in
`docs/decisions/` (now this section), English slugs,
the decisions register as index; no CODEOWNERS file;
roles as hats of one decider, enforced in machine
checks; workstream N as the remaining workstream.
Rejected: a `docs/tracking/adr/` directory (no new
top-level `docs/` directory; departs from the MADR
default path); no record files, one extended row per
decision in the register (the ten drafts do not fit
one-line rows, and the register is French, against
the English-outside-`spec/` rule).
Confirmation, done in the pull request that adds this
record: the records directory with its index,
template and records 0001–0012; workstream N in the
master plan; index rows in the register; no
CODEOWNERS file. The template and index are
superseded by this section and by the theme
summaries above.
Follow-up: none — Roadmap: Ratify the applied
decisions (for the record that its acceptance is
recorded, not re-decided).

### Executable language as the normative home for type and automata grammar

*Status: Accepted on merge. Depends on: 0001
(proposed). Gates: none. Provenance (secondary):
architecture decision record 0012.*
Chosen option (b), owner decision of 2026-10-19
(item 44, register wording): "K becomes the normative
home of the C3/C4 grammar and semantics; the Lean
proofs run on the KLean-generated types." No
rationale beyond the choice was recorded. Rejected:
(a) K covers only an executable surface subset,
C3/C4 stay normative LaTeX, K is a checked
companion; (c) staged: subset now, extended chapter
by chapter with mandates. Consequences, stated by
the register as still open for this item: the
rewriting of C3/C4 in K and the move of the Lean
proofs to the generated types. Neither is done by
this decision.
Open: mandate scope — the specification rules
require an explicit request for every normative
change of `spec/`; whether this decision is that
request for the whole rewriting of C3/C4 in K, or
each rewriting needs its own request, is not settled
in the record.
Related owner decisions of the same day: item 48
(K blocks normative, applied on `main` by PR #255);
item 43, option (c) (axioms of the generated
Prelude).
Confirmation: none yet. The work is tracked in
workstream N of the master plan (now the roadmap
section "Close the theoretical gate and the master
plan sequence").
Follow-up: Roadmap: Close the theoretical gate and
the master plan sequence; Ratify the applied
decisions.

### K sources in `lexicon/`, displayed by the specification

*Status: Accepted on merge (record 0013). Supersedes:
0003. Depends on: 0001, 0002. Gates: G1, G10.*
Owner decisions of 2026-10-26, quoted as given: "à la
racine de main, créer "lexicon/" ce dossiers doit
contenir tous les fichiers ".k", en sous dossiers on
doit retrouver "lexemes/" qui doit contenir tous les
".k" dédiés aux lemmes (mots primitifs du langage) et
"syntax/" qui doit contenir les règles de structures,
le sucre syntaxique etc. => il faut donc migrer les
fichiers .k situés ailleurs dans le projet"; "je suis
d'accord pour un bloc 'K'"; "un module "LAYERS" oui =>
ne mets pas de préfixes ni suffixes"; on record 0003:
"pourquoi ne pas clore l'adr si elle est mise en
oeuvre ?"; on the specification: "un fichier .k
devrait donc y être inclu sans réécriture pour
toujours être à jour".
Decision outcome: every `.k` file of the project lives
in `lexicon/` (`lexemes/` for the lemmas, `syntax/` for
structure rules and syntactic sugar, `models/` for the
non-normative K7OS model); K modules carry no prefix or
suffix; the specification displays each file, without
rewriting, in an empty `K` block that reads it at
elaboration, and that block is the normative view of
the K text (item 48 still applies). The Python checker
of the examples is still extracted from its Verso
block into `src/k/.build/generated/`, the part of
record 0003 that remains.
Considered options: K text held in Verso blocks and
extracted into ignored `.k` files (record 0003's
proposed outcome, applied until 2026-10-26); canonical
`.k` files included in Verso (record 0003's plan B,
chosen).
Confirmation: the extraction pass of `lake exe spec`
refuses a K file of `lexicon/` that no `K` block
displays, or that two blocks display;
`scripts/ci/test_code_artifact_contract.py` checks
that no `.k` file lives outside `lexicon/`;
`lakefile.lean` declares `lexicon/` as an `input_dir`
needed by `Spec`, so a changed K file rebuilds the
specification; `make -C src/k check`,
`boundary-check` and `layers-check` compile from
`lexicon/`.
Open: whether a `K` block carries attributes linking
it to rule labels and to the Lean theorems proved on
the KLean output, so that those theorems can be shown
under the block (record 0003's attribute contract,
`module` and `id`, is not carried over); syntax
colouring of K in HTML and PDF.
Follow-up: Roadmap: Build the remaining checks and
tools; Ratify the applied decisions.

## Migration decisions, by theme

### Replay and reproducibility by representation profile

Replay is parameterised by a representation profile, not
claimed as bit-for-bit replay in general. Formalising the
profile and its reproducibility evidence, and keeping their
traceability, remain open tasks.
*Status: decided, with formalisation still to do. Provenance
(secondary): migration decisions, replay section.*

### Binary replay route — open

The general bit-for-bit replay claim is abandoned (see
"Replay and reproducibility by representation profile"
above); what remains open is the route for a bounded
replay claim. (a) Logic only. (b) Binary under an
extended reproducibility profile. (c) Binary by
construction, with the singularity propagation table
as what makes injectivity true. (d) Total binary
replay, set aside while no bound is written.
Provisional orientation, to confirm: B then C, fixing
the "one machine" scope the memory model already
applies, adding the fourth component to the
reproducibility profile; A stays the fallback if the
implementation cannot hold B. Before choosing:
measure what the test oracle expects (observational
equivalence on output suffices for A, otherwise B or
C); establish compatibility with the hidden-cost
postulate for route D; verify the injectivity
hypothesis by a differential test at implementation
time. Provenance: binary-replay instruction
(ARB-PR-04).
  Follow-up: Roadmap: Work the research lot follow-ups
— decide with a dated owner decision, or record
explicitly that it stays open.

### External theory imports, by kind

Modal theory and graded types are treated as normative
foundations. A cost calculus is treated as a formal
dependency, not as normative. Guarded recursion with multiple
clocks is qualified layer by layer, not adopted wholesale.
Coherence chains and sedimentation still have to be built for
these imports.
*Status: decided in kind, with the coherence work still open
and blocking for theoretical closure. Provenance (secondary):
migration decisions, external imports section.*

### Timed rule and temporal structure

An additional temporal structure is retained, distinct from a
purely budgetary reading of working sessions. The owner
ratified on 2026-10-11 that environmental latency belongs to
the orchestrator, not to the triggered automaton's execution
budget. The design interface retained in working sessions
59–62 is that when maps the temporal family of the effect
to the unbounded cost, with admissibility checked when the
effect passes through the effect transformation and
consumption applied afterwards; proving that contract rule
by rule remains open, and the interface is not a proof of
correctness. Formalising the distinct representations and
proving the timed-rule contract remain open, and theoretical
closure remains open for the same reason.
*Status: owner decision recorded 2026-10-11; formalisation
open. Provenance (secondary): migration decisions, timed-rule
section.*

### Minimality of the primitive set

An autonomous audit of the minimality of the primitive set is
the route from primitive to obligation to rule to property to
proof. The set is not minimal by assertion.
*Status: decided as a route; the audit itself is a blocking
task for implementation and mechanisation. Provenance
(secondary): migration decisions, primitive-minimality section.*

### Future of the prototype appendices — open

The former appendices are out of the specification: their
material lives as condensed tooling prototypes in
`tools/prototypes-bcd/` (LSP and REPL, sushi, sugoi), with the
mechanisms they rely on in the specification chapters, and it
is explicitly non-normative. Their full Org sources were
deleted in the archives closure (2026-10-25), traced in the
migration matrix, and survive only in git history; the
"defer" option below therefore no longer means keeping those
Org files in the tree. The remaining normative
cross-reference has been removed. What happens next is still
the owner's choice, and this page does not choose:

- develop them separately, after checking the real status and
  guarantees of each tool;
- group them into one complementary-tooling appendix with an
  explicit boundary between specified language and tools; or
- defer them, keeping the normative document to its current
  scope, with provenance in the tooling prototypes and the
  frozen manuscript.

No normative content is to be rewritten before ratification.
*Status: open. Provenance (secondary): migration decisions,
short arbitration sheet for the prototype appendices.*

## Tracking register, itemised

This section itemises the tracking register
`docs/tracking/DECISIONS.md` decision by decision, in
descriptive titles in plain language. Former codes appear
only in the secondary provenance note at the end of each
item, never as titles. Statuses are those of the register
itself at its last state (synthesis of 2026-10-11, with
owner answers of 2026-10-19 and 2026-10-20): "decided"
means the register says the owner decided it;
"applied, awaiting ratification" means a session report
applied it without written owner confirmation; "open"
means the owner must still choose. Where an item is
already covered in the architecture or migration
sections above, this section says so instead of
duplicating it, and the item is still counted here.

Correction applied 2026-10-25 (owner direction: the
owner could not list the corrections, so they are
consolidated here on the principle that one roadmap
section is one action lot for a later agent): every item
below now ends with a "Follow-up" line. A decided item
says "none" unless the item text itself states a
remainder, in which case the remainder is named; an
applied item points to "Ratify the applied decisions" in
[roadmap](roadmap.md) and must not be quoted as decided
until ratified; an open item points to the roadmap
section that owns its decision, or, where no section
owns it yet, says so explicitly. Conversely, every
roadmap section that carries register work names the
decisions it carries, so the two pages can be checked
against each other in either direction: a roadmap item
from the register without a decision here, or an open or
applied decision here without a roadmap section, is an
error in this consolidation, not a gap to fill silently.
No status reserve is removed by this correction, no
statement is promoted to "proved", and the three
parameterise arbitrations stay open (see "Open decisions
for the owner, collected" and the roadmap section that
owns them): the doctrine presenting them as decided
against the register recording them as open is a
contradiction to state, not to resolve in silence.

### Decided

- **Reading lot, eighth part: answers of 2026-10-28
  (Q-SPEC-309 to Q-SPEC-310).** Recorded verbatim in
  [questions](questions.md) as VOC-2026-10-28-012 to
  VOC-2026-10-28-017. In short:
  - Trains follow FIXAPL's rule, triadic words kept out: the
    arity of each word, not the length of the train, decides
    how it combines; read from the right, a monadic word
    applies to the result of what is on its right, a dyadic
    word forms a fork with the word on its left or takes the
    train's left argument, a group counts as one word, and a
    triadic word is only ever applied. The editor colours
    each word by its role (value, function, modifier of one
    function, modifier of two).
  - `[[ … ]]` in layer 3 holds only a literal recognised by
    its shape, a class or an interval, with no head word
    (revises Q-LEX-609 B); frame storage is a property of a
    declaration, cell-wise application a modifier of trains.
    An interval is written `a..b` with both bounds included,
    a second element giving the step, several intervals
    forming a matrix of index pairs, texts of one character
    allowed as bounds; other bounds are marked by a dedicated
    keyword, still to name (the author's examples, « inner,
    outer, left, right », are « largement criticable »); in
    layer 2 the lazy interval is written `((1..n))`.
  - The encoding belongs to the text type: UTF-8 by default,
    the one a typed hole resolves to, and ASCII, UTF-16,
    UTF-32, Emacs's and others can be written.
  - The actor's `:on … :sets` form is applied now; the
    author recalls that `bind-to` gave way to `bind` and the
    words of monads, to compare with the words of algebraic
    effects.
  Applied on 2026-10-28 (`spec/CHANGELOG.md`): chapter 5
  states the train rule with FIXAPL in the bibliography
  (`wiki/references.json`, `tools/SpecBib.lean`), colouring
  by role, the literal shapes of `[[ … ]]` and the interval
  forms, `((1..n))`, and the encoding in the text type, and
  rewrites the standard deviation with one inner group; the
  glossary defines a train by the arity of its terms;
  `lst:acteur` takes the `:on … :sets` form,
  `lst:gestionnaire` shows the handler the clause implies,
  the remark that follows the actor is rewritten, the row of
  `def:elaboration` becomes the `:on` clause, and the proof
  sketch and the note of `thm:staticite_syntaxe` no longer
  name `bind-to`, its statement unchanged.
  Not applied yet, with the reason: the reader
  (`lexicon/syntax/tokens.k`) does not classify intervals,
  which it reads as one atom, nor the doubled pairs' literal
  shapes — to do with the reading of white brackets; the
  keyword for excluded bounds, the notation of encodings,
  what a width that is not a multiple of an encoding's unit
  means, whether a layer-2 interval may leave out its end,
  and the words `:on`, `:sets`, `bind`, `+frame` and `rank`
  wait for the choice of words or a later question.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Reading lot, seventh part: answers of 2026-10-28
  (Q-STR-401 to Q-LEX-613).** Recorded verbatim in
  [questions](questions.md) as VOC-2026-10-28-001 to
  VOC-2026-10-28-011. In short:
  - Texts: every `%XX` is decoded in a raw text, a literal
    `%` being `%25`; text types are `str` and `strN`, N
    counting the bits they allocate as in `intN`, graphemes
    being counted only by the development interface; a class
    tested on a grapheme of several code points tests its
    base.
  - Doubled forms: `[[:alpha:]]` is kept beside the head
    words; `{{ … }}` in layer 1 is a refined type.
  - An actor's `:on` clause names the field it sets
    (`:sets value`), the implicit handler following the rule
    of `Result`; « il nous faut une approche plus systémique
    pour identifier et composer les scénarios », to discuss.
  - Codes: `ERR-POL-002` (an instance missing when the budget
    is spent), `ERR-POL-003` (growth on a cycle),
    `ERR-TER-002` (a query that does not stratify), and the
    prefix `HEY-` for remarks.
  Kept open, with research asked for: trains longer than
  three words (Q-SPEC-306: FIXAPL, colouring by arity as
  Uiua, BQN, FIXAPL and colorForth, and what the
  specification already says). Clarification asked: whether
  `[[ range … ]]` makes sense given the nature of layer 3
  (Q-LEX-610).
  Applied on 2026-10-28 (`spec/CHANGELOG.md`): chapter 5
  states the decoding of `%XX` in raw texts, `strN` and
  `str`, the base of a grapheme for classes, `[[:alpha:]]`
  beside the head words, `{{ … }}` as a refined type and
  `HEY-LEX-001`; chapters 6, 2 and 7 cite `ERR-POL-002`,
  `ERR-POL-003` and `ERR-TER-002`; annex A gains these codes,
  the prefix `HEY-` and a table of remarks (messages
  proposals); the classification row of
  `thm:terminaison_strates` names its refusal code.
  Not applied yet, with the reason: the actor's `:on … :sets`
  form (Q-SPEC-307) replaces `bind-to`, which the definition
  `def:elaboration` lists among the six written forms and
  the proof sketch of the static-syntax corollary
  (`thm:staticite_syntaxe`) discusses as the only place where
  a name is produced; that
  rewrite touches a definition and a proof sketch, and the
  author asked for a broader discussion of scenarios first,
  so it is put to the eighth part.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Reading lot, sixth part: answers of 2026-10-27
  (20 of 25 questions).** Recorded verbatim in
  [questions](questions.md) as VOC-2026-10-27-073 to
  VOC-2026-10-27-092. In short:
  - Texts: no character type; as PostgreSQL's `varchar`, a
    text type carries its bound, counted in graphemes or in
    bytes as stated, or left as a typed hole; the names of
    invisible characters are `\tab`, `\return`, `\nbsp`,
    `\shy`, `\zwsp`, `\zwnj`, `\zwj`, `\bom`, others added
    as needed; each tag's type declares how its holes are
    written, `sql` (standard SQL) being the first to
    specify.
  - `@` belongs to patterns: `@name` defines a pattern, the
    four R-expression annotations stay, `@` alone is a
    character and `text@text` a text; an undeclared tag
    gives `WRN-LEX-001`, warnings never blocking
    compilation unless a flag asks for it; a literal that
    holds its own closer uses an alias of its tag.
  - Negation: the semipositive rule enters the
    specification, and the compiler also accepts a
    negation of a relation of the same query when the query
    splits into strata (Q-SPEC-206 revised to its option
    B); the complement of a class is taken among Unicode
    scalar values.
  - Trains are layer-3 expressions between brackets,
    `[fold add div length]`; `'` is Lisp's quote; a glyph in
    a file is rewritten as its word by the formatter, with a
    remark rather than a warning (« HEY-LEX-… »).
  - `t` and `f` are constants nothing can rebind, `-f` a
    naming convention; `+name` is a shorthand for
    `:name t`, an option not written being `f`.
  - `[[ … ]]` takes a head word: `range`, `frame`, `cells`;
    `((:alpha:))` is an idiom bracket without arguments.
  - Monomorphisation: no attribute, the budget decides
    alone; instances are cached by content, so a real change
    of a generic recompiles its instances, not the units
    that use it.
  - An actor pairs each message with its pure transition
    (`:on`), its handler implicit.
  - A type written with two segments takes halves by
    default, with a warning (`fix32` is `fix16.16`).
  Withdrawn: Q-LEX-606, the glyphs to add, « car celui ci se
  fait après le choix des lemmes ». Kept open: the grouping
  of trains longer than three words (Q-SPEC-303, « Les
  propositions sont arbitraires et non satisfaisantes »).
  Not answered yet, carried into the seventh part: Q-STR-401,
  Q-LEX-610, Q-LEX-612 and Q-TYP-401.
  Applied on 2026-10-27 (`spec/CHANGELOG.md`): chapter 2
  gains the corollary `thm:terminaison_strates` (state
  proposed, proof sketched, its source added to the
  bibliography), registered in the current classification of
  [assurance](assurance.md) and in the inventory check, and
  chapter 7 points to it; chapter 5 states the four sigils
  and `@` for patterns, trains between brackets (the mean and
  the standard deviation rewritten), the rewriting of glyphs
  with a remark, the quote, `t` and `f`, `+name`, the head
  words of `[[ … ]]`, texts without a character type, the
  names of invisible characters, `WRN-LEX-001`, tag aliases,
  holes declared by the tag's type, stratified negation in
  `[sql|…|sql]` and the universe of a class complement;
  chapter 6 the cache keyed by content; annex A the prefix
  `WRN-` and `WRN-LEX-001` (message a proposal).
  Not applied yet, with the reason: the rewrite of the handler
  and actor listings waits for what the implicit handler
  makes of a transition's result; the code of remarks waits
  for its prefix; the refusal of a query that does not
  stratify has no code yet; how a text type is written is put
  to the seventh part; the reader of `lexicon/` does not read
  the new forms yet.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Reading lot, fifth part (revised): answers of
  2026-10-27 (Q-STR-302 to Q-ARC-001).** Recorded verbatim
  in [questions](questions.md) as VOC-2026-10-27-039 to
  VOC-2026-10-27-072. In short:
  - Texts: `""` before a separator is the empty text,
    otherwise it opens a raw text; in a raw text `\` stays
    literal, and quotation marks are written `%22` and a
    leading space `%20`, as in a URL; invisible characters
    get a short closed list of K7PL names beside LaTeX's;
    the bound of a text type counts the bytes of its UTF-8
    encoding, graphemes measuring lines for the formatter
    and the linter; a character is written like a text of
    one character (`"a"`, `"μ"`, `"\lambda"`); the editor
    always shows a raw text as `« s »`.
  - Qualified delimiters: `{tag|` is one opening delimiter
    waiting for `|tag}` (« Keep it simple »); a tag is a
    layer-1 type, and an unknown tag leaves its literal
    plain text, typed by the tag all the same; a negation
    in a recursive layer-3 query is allowed only of a
    relation fixed before the recursion.
  - Character classes: `[:alpha: c]`, `[[:alpha:]]`,
    `((:alpha:))` and `{{:alpha:}}` as proposed.
  - Trains: the text form first, the view replacing each
    word by its glyph in place, `(fold add div length)`
    viewed `(´+÷≠)`, with fixed arities everywhere; one
    alias per arity as a direction, each lemma still to be
    weighed; the boolean values are `t` and `f`;
    properties rather than flags for now.
  - Doubled forms: `⟦ ⟧` holds ranges, storage in the
    caller's frame and functions applied cell by cell, open
    to more; `⦅ ⦆` are idiom brackets, with the author's
    statement « K7PL se veut Lazy en toute circonstance »,
    made precise in the conversation: « les automates
    compilés en couche 3 sont invoqués paresseusement par
    l'orchestrateur », which agrees with chapter 1's
    strategy by layer; `⦃ ⦄` stays open.
  - Monomorphisation: the mechanism of Q-TYP-301 A
    (collection from the roots, instances named by their
    hash and counted in the budget, growth on a cycle
    refused, nothing shared at run time), its limit on
    recompilation recorded; exhaustion of the budget stops
    inlining and refuses a missing instance; higher-order
    functions are copied per function argument in the same
    budget.
  - Branchings for the computation, for operations and
    handlers, and for method combination, the other
    families staying functions; the generic definition
    word is `def`, the function envelope `defn`, and
    envelopes are layer-1 macros open to every program,
    which compose.
  - Numbers: `comN = two floN/2`, and a default with a
    warning for every type written with two segments;
    warnings take the prefix `WRN-` (`WRN-NUM-001`); an
    unresolved typed hole is `ERR-SMT-003`.
  - Names: labels go into English once their words are
    chosen; statements carry `subject`, `formalArtifact`
    and `uses`, checked by the build; one key, written by
    the rules of each place, mapped mechanically.
  - The old K archive is not added: its remaining value is
    extracted into the research, then it is discarded.
  Kept open or clarification asked, for the next part:
  raw-text percent decoding (Q-STR-303), the writing of
  holes and the reservation of `@` for TXR-style pattern
  matching (Q-STR-307), the limits of the negation rule
  (Q-SPEC-206), the universe of `¬` (Q-LEX-504), `fold` over
  several quoted expressions (Q-SPEC-207), `-f` and `-t`
  (Q-LEX-506), flags (Q-LEX-507), `⦃ ⦄` (Q-LEX-403), the
  rewrite of the handler and actor listings (Q-SPEC-202),
  the property of Lean's `@[specialize]` (Q-TYP-303), and
  the reading of `((:alpha:))` now that `⦅ ⦆` are idiom
  brackets (Q-LEX-402).
  Applied on 2026-10-27 (`spec/CHANGELOG.md`): chapter 5
  states texts, escapes, raw texts, the character written
  as a text, the two measures of length, the view rule,
  qualified delimiters and their four forms, character
  classes, the meanings of `[[ … ]]` and `(( … ))`, `||`,
  `t` and `f`, `def` and its envelopes, and the trains in
  text form with their view, the mean and the standard
  deviation rewritten (the latter with parenthesised
  trains of at most three words, so that no grouping rule
  is assumed); chapter 6 states the mechanism of
  monomorphisation, the exhaustion of the budget and the
  specialisation of higher-order functions; annex A adds
  `ERR-SMT-003`, its message a proposal.
  Not applied yet, with the reason: the negation rule of
  layer-3 queries waits for its limits (Q-SPEC-206); the
  codes of a missing instance and of growth on a cycle are
  not chosen; `WRN-NUM-001` and the defaults of two-segment
  types wait for the number kinds to enter the
  specification; the list of names of invisible characters
  is to be drawn up; the glyph table does not yet carry an
  alias per arity, its lemmas being weighed one by one; the
  label fields `subject` and `uses` and their check are to
  be built in `tools/SpecExt`; labels wait for the
  vocabulary lots; the reader (`lexicon/syntax/`) does not
  yet read qualified delimiters, raw texts with `%22`,
  class names or booleans as such, and still reads glyph
  runs, which files no longer need.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Conversation of 2026-10-27 on texts, doubled and
  qualified delimiters, escapes and trains.** Decided in
  the conversation that followed the opening of the fifth
  part, the author's words quoted as given:
  - Repetition: « répéter un délimiteur élève son niveau
    sans changer sa couche », including `||` for the third
    dimension — « Oui ! ». `|` separates the rows of an
    array, `||` the third dimension.
  - Texts: `"` is « un délimiteur typé (varchar 0-n) » with
    « une forme vide `""`, une forme simple `"s"` et une
    forme double `""s""` (à l'image de `{}`, `{s}` et
    `{{s}}`) », the doubled form being raw.
  - Qualified delimiters `tag|…|tag`: « le type (eg.
    "sql") devra être défini et demain éventuellement les
    règles syntaxiques propres à ce type implémenté pour
    valider le littéral => ce littéral n'étant pas
    "compilé" […] cela permettra d'apporter une certaine
    expérience utilisateur »; the four forms of one tag
    are retained — `"sql|…|sql"` typed text, `{sql|…|sql}`
    declared and checked at compile time, `(sql|…|sql)`
    executed, `[sql|…|sql]` pure and terminating — « avec
    la couche 3 limitée au fragment monotone ».
  - Layers: « ⦅…⦆ comme ⦃…⦄ interdit en couche 3 puisque
    le délimiteur doublé reste dans la couche du
    délimiteur simple ».
  - Files and views: « les fichiers gardent ""s"" et
    l'éditeur affiche « s » => pareil pour le reste »:
    files keep ASCII; the editor shows `« s »`, the white
    brackets, `‖` for `||` (« `‖` maintenu car il faut
    tout de même distinguer la spec mathématique qui
    modélise les comportements du code source qui les
    soutiendra »), and `(not ((…)))` as the train
    `(¬⦅…⦆)`.
  - Holes: a hole in a qualified literal is « un trou
    typé, il faut rouvrir Q-STR-003 à cet égard ».
  - Escapes: in a text, « j'accepte que `\` échape le
    caractère qui le suis »; special characters take
    « les noms de LaTeX pour l'instant »; « Absorber une
    seule espace après un nom LaTeX »; a code point is
    written `\u'…'` rather than `\u{…}` (« pour éviter
    d'introduire encore des guillemets droits » and
    braces).
  - Trains: « un train s'écris en text avec des espaces,
    la forme glyphique est une vue avancée du même code »;
    « on écris les trains de gauche à droite, en
    préservant la logique s-exp, et pour que cela
    fonctionne les arités sont spécifiés très clairement
    (une arité doit donc être typé pour les symboles
    monadique, diadique voir triadique mais jamais
    n-air comme le reste du langage) ». After reading
    chapter 5 on trains and arities, no head word marks a
    train: the elaboration tells a train from an
    application by the typed arities (`ERR-STK-001`); the
    author: « Je pense que tu as raison sur ces
    analyses. »
  Settled questions of the fifth part, withdrawn:
  Q-STR-301 (escapes) and Q-LEX-404 (spacing of white
  brackets). The research is in [research](research.md),
  « Conversation of 2026-10-27 ».
  Applied on 2026-10-27: the wiki only. Not applied yet:
  the reader (`tokens.k` reads glyph trains, not their
  aliases), chapter 5 (examples, escapes, texts) and
  annex A wait for the revised fifth part.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Reading lot, fourth part: answers of 2026-10-27
  (Q-STR-201 to Q-LEX-304).** Recorded verbatim in
  [questions](questions.md) as VOC-2026-10-27-022 to
  VOC-2026-10-27-038. In short: a path is a symbol with
  slashes, its spaces percent-encoded as in a URL; a
  heredoc is written between triple quotes, the double
  quote staying the mark of text; lexical errors form the
  segment `ERR-LEX`; type names stay lowercase and a type
  appears only after a property that announces it
  (`:num`, `:type`); the head of a function type is
  `function`; the lemma for Haskell's `>>=` is `bind`,
  monadic constructions being branchings declared with `:`
  (`:bind`, `:return`); a handler binds actors and an actor
  binds productive or terminating functions; the 8-bit
  floats are `flo8e4` and `flo8e5`, `flo8` alone meaning
  `flo8e4` with a warning; exact reals are `rea`, computed
  after the theory of computable reals; a typed hole is
  resolved to the smallest width that holds every value
  the solver can bound, and refused when it bounds nothing;
  an empty pair is the empty data structure of its layer,
  each layer being itself a data structure (linear arena,
  heap, stack); a doubled pair is also written with white
  brackets, `⦃ ⦄`, `⦅ ⦆` and `⟦ ⟧`, with the same
  meaning, each doubled form being a precision dedicated to
  its layer.
  Applied on 2026-10-27: chapter 5 states the path,
  type-position, empty-pair, doubled-pair and typed-hole
  rules, and its listings write `function`; probes of
  `tests/lexical/` and `tests/layers/` check that paths,
  empty pairs and doubled pairs are read.
  Not applied yet, with the reason: the reader does not
  read the white brackets, because K's regular expressions
  cannot keep them out of symbols, so a white bracket glued
  to an atom would be read as part of it — the spacing rule
  is put to the author (fifth part); the escapes, the
  homogeneous design of strings, monomorphisation, the
  inventory of branchings, the rewrite of the handler and
  actor listings, a generic definition word, the codes of
  warnings and of an unresolved typed hole, the reading of
  « fixN = two floN/2 », and the meanings of the doubled
  forms are the fifth part of the lot; ranges wait for the
  doubled forms; the number kinds and widths enter the
  specification with the writing of types.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Reading lot, third part: answers of 2026-10-27
  (Q-LEX-201 to Q-ERR-102).** Recorded verbatim in
  [questions](questions.md) as VOC-2026-10-27-001 to
  VOC-2026-10-27-021. In short: a run made only of glyphs
  and modifiers is a train, any other run is read whole
  (`increase-counter`, `-2`); lenses get clear names such
  as `view` and `set`, and `^` is neither a sigil nor a
  glyph; a type variable is introduced by a binder, and
  "Polymorphisme est interdit en K7PL => tout est
  monomorphé."; a function type is written flat, its head
  being a true lemma rather than an arrow; the `Int` of
  `lst:acteur` was historical, and `int` without a width
  is a typed hole resolved in its family; the four
  listings of chapter 5 are accepted with their prose,
  `bind-to` standing for Haskell's `>>=` and not being a
  chosen lemma; other identifiers of the specification wait
  for the vocabulary lots; the judgement of chapter 3 takes
  two Δ zones; the number kinds gain `mod`, `dfx`, `bfl`,
  `flo8`, `pos`, `itv`, `qua`, `dua`, `gau`, `alg` and
  `pad`, unbounded integers being refused ("un typed hole
  évite un choix arbitraire"); floating-point widths are
  those of IEEE 754-2019, integers take any width, and
  `fix` counts the sign bit; literals are decimal with
  fraction, exponent and `_`, rational, complex, `inf`,
  `-inf` and `nan`, without radix prefixes; an unknown
  escape is refused; a line break inside a string is a
  character of it ("Important pour les docstrings"); a raw
  string is written `""…""`, equivalent to Raku's corner
  brackets, and paths should be valid inline; an unclosed
  string gets a code in `ERR-DLM`, a quote in a comment
  none; the recovery rule and the messages of `ERR-DLM-001`
  to `ERR-DLM-003` are confirmed.
  Applied on 2026-10-27: `lexicon/syntax/tokens.k` reads
  trains, numbers and the decided literals, and
  `tools/layer-check` checks its glyphs against
  `tab:glyphes` and the classes of the probes of
  `tests/lexical/`; `lexicon/syntax/balance.k` refuses an
  unclosed string with `ERR-DLM-004` (message proposed) and
  annex A.8 lists it; the four listings of chapter 5 are
  rewritten (definitions opened in layer 1, contract marks
  before the name, `view` and `set`, the flat function
  type, `{field value :num int}`), with the layer roles and
  the reading rules in its prose; the judgement of chapter
  3 is written with two Δ zones.
  Not applied yet, with the reason: the words `defn`,
  `:type`, `fn`, `field`, `defhandler` and `bind-to` of the
  listings are placeholders until the vocabulary lots and
  the fourth part of this lot (Q-TYP-202, Q-SPEC-101); the
  writing of type names (Q-TYP-201), what remains of `∀`
  (Q-TYP-203), the escapes (Q-STR-201), the raw string and
  its collision with `""` (Q-STR-202), inline paths
  (Q-STR-203), heredocs (Q-STR-204), the code of an unknown
  escape (Q-STR-205), the prose of `lst:acteur`
  (Q-SPEC-102), the two 8-bit floats (Q-NUM-201), the name
  of exact reals (Q-NUM-202) and the resolution of typed
  holes (Q-NUM-203) are the fourth part of the lot; the
  number kinds and widths enter the specification with the
  writing of types.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Reading lot, second part: answers of 2026-10-26
  (Q-LEX-101 to Q-ERR-004).** Recorded verbatim in
  [questions](questions.md) as VOC-2026-10-26-012 to
  VOC-2026-10-26-033. In short: `?` and `!` are both
  written before the name; the sigils are `#`, `:`, `@`,
  `?` and `!` (`^` left out, the author being unsure);
  glyphs come from the closed list of chapter 1, each
  typeable by its alias through a formatter; a disabled
  tree is read and checked; `a;` reads `a` then `;`; type
  notations follow their role, the intention in
  mathematics and programs in K7PL; the formulas of the
  metalanguage are mathematics; a definition opens in
  layer 1, where its type is set ("On va coder la stdlib
  en layer 1 pour définir les fonctions et leurs
  comportement dans les couches 2 et 3."); a declaration
  that carries a type is written in `{ }`; the number
  kinds `int`, `nat`, `flo`, `dec`, `fix`, `com`, `rat`
  and exact reals are kept, and "La liste doit être
  complete."; `nat` names the unsigned integers; the width
  of a complex number is its total width, `com64` (two
  `flo32`) the smallest, then `com128` and `com256`; a
  fixed-point type is `fixM.N` (`fix4.16`); units are UCUM
  codes; a backslash escapes; line breaks inside a literal
  stay open until the trade-offs are evaluated; a literal
  never interpolates; K7PL has a raw form and heredocs; the
  delimiter errors form the segment `ERR-DLM`; a message
  carries signal, rule and knowledge, and the compiler
  prints a short message with its code, each code having
  an explanation page; translations go through a catalogue
  keyed by code; annex A is recomposed once it is
  implemented, quoted as given: "On attend d'avoir
  implémenté l'annexe A avant de la recomposée. l'avantage
  c'est que l'on pourra construire un index cohérent et
  consolidé suivi d'une page par code d'erreur comme GHC
  et Rust."
  Applied on 2026-10-27: the formulas of the metalanguage
  and the type notations of the theory prose are math
  spans (chapters 1 to 6, 160 occurrences); chapter 5
  states that a disabled tree is read and checked and how
  `a;` reads; `lexicon/syntax/balance.k` reads a text as a
  pushdown automaton and emits `ERR-DLM-001` to
  `ERR-DLM-003` with their lines, the messages being
  proposals; annex A gains section A.8; `tools/layer-check`
  requires the two readers to agree.
  Not applied yet, with the reason: the contract marks
  before the name, the sigils, types set in layer 1 only,
  definitions opened in layer 1 and typed declarations in
  `{ }` change the four listings of chapter 5 together, and
  those listings need the K7PL writing of types — put to
  the author as one rewrite (Q-SPEC-001, Q-TYP-101 to
  Q-TYP-104); glyph recognition waits for Q-LEX-201, since
  five ASCII glyphs meet kebab-case names and signed
  numbers; number kinds, widths and literals, escapes, the
  raw and heredoc notations: third part of the lot; message
  shape, catalogue and the recomposition of annex A: at
  that recomposition (Q-ERR-004). The program-meant type
  notations (annex A, chapter 7) and the judgement with Γ
  of chapter 3 stay in code (Q-NOT-001).
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Reading lot: answers of 2026-10-26 (Q-LEX-001 to
  Q-LEX-006).** Recorded verbatim in
  [questions](questions.md) as VOC-2026-10-26-003 to
  VOC-2026-10-26-011. In short: sigils are read apart and
  trains are written glyph by glyph, each glyph a macro
  composed in layer 3; identifiers are English kebab-case,
  with `?` before the name (`?increase-counter`); a number's
  type is a property (`:num int32`, three letters and a bit
  width, refinable by `:unit mm`); strings wait for a
  research step; `;;` comments to the end of the line,
  `;;;` and `;;;;` headings, `;(`, `;[`, `;{` disable a
  tree, a lone `;` is an ordinary character; types are set
  in layer 1 only (option D of Q-LEX-005); unbalanced
  delimiters get codes for an opener never closed, a closer
  with no opener, a closer of another pair, an unclosed
  string and an odd number of quotes in a comment, under a
  new segment named by a dedicated study, one code per
  kind, a closer looking for its opener further out.
  Owner message of the same day, quoted as given:
  "l'écriture d'un délimiteur DOIT, et c'est bien sa
  nature, définir la limite de couche"; "la manipulation
  des types se fait en couche 1. La couche 2 orchestre et
  "produit" et la couche 3 calcule et termine"; notations
  such as `Vector(n, T)` "ne respecte pas la syntaxe de
  K7PL" and are to be formalised "soit en S-Expression
  suivant les prescriptions de K7PL, soit dans un format
  algorytmique neutre"; "La couche 3 consiste à réaliser
  des opérations dans la stack et la couche 2 dans le
  heap, y définir des types est incohérent"; annex A "devra
  être recomposée à partir des implémentations K, Lean et
  TLA+", kept in French for now, with the
  internationalisation of messages to explore; the file
  renames are finished once PR #309 is merged;
  method: "on recherche, on énumère, on objective puis on
  choisis". Spec anchors: the memory row of
  `tab:dimensions` (chapter 1: layer 1 linear arenas,
  layer 2 heap, layer 3 stack) and `tab:delimiteurs`
  (chapter 5). No sentence of `spec/` states yet that types
  are set in layer 1 only; the types lot adds it.
  Applied on 2026-10-26: the comment rule and the
  delimiter rule in chapter 5. Still open, in the second
  part of the reading lot (Q-LEX-101 to Q-ERR-004 in
  [questions](questions.md)): the contract mark `!`, the
  sigil set, glyph recognition, disabled trees, `a;`, the
  layer of declarations such as `(defvar ...)` and
  `(champ valeur : Int)`, the formalisation of type
  notations, number kinds and units, strings, the
  reading-error segment and messages.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Layer grammar, refusal codes, and K as their
  home.** Owner decisions of 2026-10-26. The grammar of
  the three delimiter pairs is the author's: `[ ]`
  (layer 3) contains only atoms and `[ ]`; `( )`
  (layer 2) contains atoms, `( )` and `[ ]`; `{ }`
  (layer 1) contains all three; an atom is a symbol, a
  number or a string. There is no layer-neutral
  "ordinary parenthesis". The grammar is written in K
  (`lexicon/syntax/layers.k`, module `LAYERS`), with
  the three refused inclusions as the productions it
  lacks (`lexicon/syntax/crossings.k`); K emits the
  code and the message of each refusal
  (`lexicon/syntax/refusals.k`), and `tools/layer-check`
  compares them word for word with annex A and checks
  every listing of `spec/` and every `.k7` file.
  Numbering rule: `ERR-TOP-001` to `ERR-TOP-n` name the
  delimiter-composition infractions, from the most
  specific container (layer 3) to the most generic
  (layer 1) — `( )` in `[ ]` (001), `{ }` in `[ ]`
  (002), `{ }` in `( )` (003, new) — and the category's
  other codes continue the numbering: the former
  `ERR-TOP-003` becomes `ERR-TOP-004`. Chapter 5 and its
  listings were corrected accordingly, with the author's
  rewrite of `lst:fonction-pure`. Answers of the
  owner, second round of 2026-10-26: the messages of
  002 and 003 are validated (002 no longer says "Même
  correction", whose `let` of layer 2 would fall under
  003); the refusals happen at reading, in Phase 0, and
  chapter 5 says so; `(champ ...)` in `lst:acteur` is
  layer 2, aligned with the objectives of that layer;
  unbalanced delimiters get error codes, in the manner
  of Parinfer. Still open, put to the owner as
  questions Q-LEX-001 to Q-LEX-006 in
  [questions](questions.md): the lexical classes of
  symbols, numbers and strings, and comments (the
  definitions of `lexicon/syntax/tokens.k` are material
  to consider, not decisions); delimiters in type,
  pattern and literal positions (refinement types
  `{x : T | p}`, applied types such as `Vector(n, T)`);
  the taxonomy, numbering and recovery of the balance
  codes. Provenance: owner instructions of 2026-10-26
  in the working session.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **K sources live in `lexicon/`.** Owner decision of
  2026-10-26: every `.k` file lives in the root
  directory `lexicon/`, with `lexicon/lexemes/` for the
  lemmas (primitive words of the language) and
  `lexicon/syntax/` for structure rules and syntactic
  sugar; the K modules carry no prefix or suffix
  (`LAYERS`, not `K7PL-LAYERS`); the Verso block kind is
  `K`. Applied: the subset semantics is split by lemma
  (`literals`, `add`, `lt`, `select`) and composed by
  `LEXICON` (`lexicon/lexicon.k`); the non-normative
  K7OS model is `lexicon/models/native-boundary.k`
  (module `NATIVE-BOUNDARY`). Rule labels are
  unchanged; KLean derives the names of the generated
  heat and cool constructors from module names, so the
  Lean proofs follow the rename
  (`K7PL_SYNTAX_k7Add1_heat` becomes `ADD_k7Add1_heat`).
  Recorded as architecture record 0013, which
  supersedes record 0003 at the owner's request (see
  both records below). File names and content outside
  `spec/` are in English (owner instruction of the
  same day): `lib/lib-exemple.k7` became
  `lib/lib-example.k7`. Provenance: owner instructions
  of 2026-10-26.
  Follow-up: Roadmap: Ratify the applied decisions.
- **Vocabulary arbitration sequence (Q-METH-001,
  option A).** Author's answer of 2026-10-26
  (VOC-2026-10-26-001): non-collision, then scientific
  exactness, family and grade invariants, a provisional
  ecological grid, mnemonic arguments, and brevity last.
  It ranks the ecological criterion and lifts blocker
  B-ONTO-07. Individual answers to the questionnaire are
  recorded as dated preferences and ratified only in the
  global lot (VOC-2026-10-26-002); the first is `lambda`
  as the retained lemma of `Lam` (an anonymous function;
  a named function is *defined*), argued in
  [primitives](primitives.md). Wherever `lambda` is a
  candidate lemma, the question explains that the
  symbol λ also names a natural transformation of the
  graded distributive law in chapter 3 (owner
  instruction of 2026-10-26). Method choice and
  preference only: no term is ratified and nothing is
  renamed. Provenance: owner answers of 2026-10-26.
  Follow-up: Roadmap: Work the research lot follow-ups.
- **Vocabulary method: global lot after the ontological
  audit.** No lemma or token is ratified individually
  until the scope, categorisation and formal-chain
  contradictions are delimited; the lexical arbitration
  then happens in one lot, once the blockers are lifted.
  Author's explicit method choice of 2026-10-25
  (VOC-2026-10-25-001, questionnaire question
  Q-METH-002, option A). This is a method choice only:
  it is neither a scientific ratification of any term
  proposed, nor an authorisation to change normative
  forms, macros, AST, proofs or tests. Independent
  analyses continue without waiting for further
  questionnaire answers. Provenance: core-vocabulary
  decision register and questionnaire, 2026-10-25.
  Follow-up: Roadmap: Work the research lot
  follow-ups — answer the questionnaire lot by lot
  under this method; the ontological audit itself
  stays open until its blockers are cleared.

- **Formalise layer 2, hold the sedimentation thesis
  whole.** Decided 2026-09-15. Provenance: D-1, ARB-PR-05.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Six kernel design choices.** Channel as value,
  primitive asynchrony, sessions and mailboxes,
  imported graph, graded locality, cost in work and
  depth; no fourth place in the judgement.
  Provenance: session of 2026-09-30, layer-3 parallel
  report.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Modal subsumption direction.** No inversion;
  collision between two orders. Provenance: ARB-PR-01.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Size clause.** Two size kinds, never shared.
  Provenance: ARB-PR-02.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Minimal kernel framework.** The manuscript
  framework, ratified; two factorisation cards depart
  from it. Two competing architectures were
  examined and set aside, with their reasons
  recorded rather than erased: a five-layer
  minimal architecture, and a fibred bimodal
  architecture. Provenance: ARB-PR-05.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **No univalent socle for factorisations.**
  Tempting false factorisations are documented as
  refusals rather than executed. Provenance: treatment
  plan §6, and the refused-factorisations file.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Modal and graded family, not a homotopic socle.**
  Decided 2026-10-01. A homotopy type theory socle
  was examined and rejected as a "false good idea",
  on four diriment obstacles: univalence makes
  representation-equality statements inexpressible
  (the bit-for-bit coincidence theorems are
  precisely statements not invariant under
  isomorphism); the cost of transport is neither
  constant nor statically bounded, which the
  hidden-cost postulate forbids concealing, and no
  published theory counts it in the budget;
  Lean imposes definitional proof irrelevance and
  subsingleton elimination, incompatible with
  univalence, so adopting HoTT would mean
  abandoning Lean and Mathlib; and no HoTT variant
  provides the ordered semiring of grades, the
  heart of the system, nor does a graded-plus-
  univalent combination exist in the literature.
  The diagnostic corollary is to state in the
  specification that K7PL is deliberately not
  invariant under representation equivalence: the
  categorical abstract semantics and the
  representation determination pull in opposite
  directions. Four imports remain profitable, to
  be instructed one by one, none as a socle:
  modal theory (mode theory) for ordering the
  eleven modalities; calf and decalf for tick,
  budget and phase distinction, a route for the
  heaviest proof debt; formalised graded type
  theory as a mechanisation pattern, with the
  restriction that no instance may affect
  definitional equality, to be verified against
  the mixed product; multi-clock guarded
  recursion for productivity without a size
  index, as an alternative to the size clause.
  One punctual, instrumental use of strict
  cubical theory without Glue types is allowed
  for a single proof debt, as a proof tool,
  never as a socle. Import statuses at the
  register's last state: two partial, the rest
  open; they are to be instructed one by one,
  not acquired. This decision is distinct from
  the three September arbitrations recorded as
  open below (non-commutativity, termination
  and productivity in one or two theorems,
  fibrille and cofibrille), which are different
  questions. Provenance: ARB-PR-07, D-2.
  Follow-up: Remainder: instruct the four imports one by one — Roadmap: Ratify the applied decisions.
- **Graded preservation end to end, as a declared
  objective.** The claim becomes a proof, pass by
  pass, monomorphised fragment first; it remains a
  conjecture until proved. Decided 2026-10-01.
  Provenance: ARB-PR-06.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Historical print-index work abandoned.** Its
  mechanism is replaced by the canonical index list
  and current indexation; no merge of that branch is
  required. Provenance: split/pr10-1.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Bit-for-bit replay promise replaced.** Logical
  semantic replay; bit identity conditioned on the
  representation profile. Note: the replacement of
  the historic formulation is decided; the
  orientation to confirm (first B, then C) is
  still recorded as a decision pending in the
  card register. Provenance: ARB-PR-04.
  Follow-up: Remainder: confirm the orientation (first B, then C), still recorded as pending in the card register — Roadmap: Ratify the applied decisions.
- **Primitive words, finishing order.** Second to
  last, before the release. Provenance: T-68.
  Follow-up: Finishing order noted — Roadmap: Close the primitive research register.
- **Appendix E merged into the manuscript.**
  Grammars and rules in chapter 3, semantics and
  sorts in chapter 4, glyph table in chapter 1.
  Provenance: STRUCT-23.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **First release timing.** After gates P1 to P5,
  at gate P6. Decided 2026-10-01. Note: the register
  lists this decision twice; it is one decision, not
  two. Provenance: D-9.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Judgement indexing not required, and both
  options of the second blocker validated.**
  Validated 2026-10-01, to be re-evaluated as a whole
  once everything is treated. Provenance: BLOQ-05,
  BLOQ-07.
  Follow-up: Remainder: re-evaluate as a whole once everything is treated — no roadmap section opened for it until then; record the re-evaluation when the treatment completes.
- **Verso is authoritative.** Org files archived,
  controls ported. Decided 2026-10-01.
  Provenance: D-5.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Manuscript subtitle.** "A functional layered
  programming language" is authoritative; the
  repository carries no other subtitle.
  Provenance: D-6.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Glossary layers restored.** Layer 1, layer 2
  and layer 3 entries present in the glossary list.
  Provenance: D-8.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Documentation physical pass closed.**
  Remaining migration decisions belong to the
  migration registers. Provenance: DOC-D8.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **PDF index.** The index is called, a paginated
  index is emitted, and CI rejects unresolved index
  targets. Provenance: post-October decisions, index
  row.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Release gates in sequence.** P1 scientific
  blockers, P2 open assertions, P3 author decisions,
  P4 implementation, P5 manuscript and documentation
  stabilisation, P6 release. Provenance: P1–P6 row.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Refinement theorem split.** The construction
  keeps its historic label; its three readings
  become corollaries (erasure, non-interference,
  precision), each with its premises, states
  inherited without promotion. Decided 2026-10-12.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Sedimentation statement corrected.** It now
  holds for non-graded containers and refers to the
  graded sedimentation requirement, correcting an
  editorial residue of the split. Decided
  2026-10-12.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Reinvocation schema domain.** The index runs
  over N∞ with the ω case treated explicitly, and
  its compatibility is a separate obligation; the
  title "bounded" remains open. Decided
  2026-10-12, author advice after coherence check.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Language rule.** Only the specification is in
  French; everything else must be in English, and
  file names are in English. Historical and
  evidence records are not translated: they are
  kept as they are until their content has been
  analysed and arbitrated, then deleted
  progressively, each deletion recording where the
  content went or why it was abandoned. The
  specification stays French, and whether module
  file names under `spec/` are renamed is not yet
  decided. Decided 2026-10-19.
  Decided 2026-10-27, owner instruction quoted as given:
  "Tu peux finaliser le renommage des fichiers en
  anglais." (after "Tu finaliseras les renommage des
  fichiers quand la PR de Muse sera fusionnée", 2026-10-26;
  PR #309 was replaced by #312, merged). The module file
  names under `spec/` are renamed too. Applied on
  2026-10-27: the 51 French module files of `spec/Spec/`,
  `scripts/controle.py` and `scripts/controles/`
  (`scripts/check_spec.py`, `scripts/spec_checks/`),
  `scripts/verif_singularites.py`, two figure assets and
  the K7OS dossier files, with every reference; contents
  are not translated. The list is in `CHANGELOG.md`.
  Decided 2026-10-27, author's instruction quoted as given,
  about the frozen inventory: "non il faut lui donner
  directement les bons noms pour ne pas maintenir des
  fichiers de correspondances qui n'ont aucune valeur
  ajoutée." Applied the same day: the frozen inventory of
  [assurance](assurance.md) and the notes of the stage C
  pins name the files by their English names, the digest
  that pins the inventory being re-synced; permalinks pinned
  to older commits keep the paths of their commit, which
  those commits hold. The same rule will hold for labels if
  they are renamed (Q-TRC-001).
  Follow-up: Rule carried — Roadmap: Finish the language migration.
- **Interactive navigation, phase direction:
  reorient.** Recorded 2026-10-11: keep the
  provenance slice, suspend the semantic
  extension, and condition any widening on the
  preregistered user comparison and on explicit
  traceability of every relation. Whether this
  phase decision is taken or provisional is itself
  an open governance question, listed among the
  open items below.
  Follow-up: Direction carried — Roadmap: Build the interactive exploration envelope.
- **Prototype extraction framework.** The
  extraction lots for the prototype appendices are
  carried by the migration dossier, without
  rewriting the historical sources. Decided as a
  framework; the editorial scope of the prototypes
  themselves (separate, grouped, or deferred)
  remains open.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Archive attribution, verified.** Decisions
  attributed to the owner by the PR #10 archive,
  verified 2026-10-14: none was decided on the
  main branch; one is moot, two were already open,
  one was decided otherwise, and one belongs to a
  card verification. This verification finding is
  recorded so the archive is not cited as a source
  of owner decisions.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Statement taxonomy, fifteen ratified design
  decisions.** Multidimensional ontology, result
  roles, epistemic states, generic requirement,
  assumptions as structured premises, literature as
  documentary objects, future formal reimplementation
  tracked separately, evidence kinds distinguished,
  scope separate from level, labels and numbering,
  specialised commands on one shared representation,
  CI failing on mechanically decidable violations,
  small buildable migration pull requests, prose
  reduction only after structural migration, and an
  exit gate requiring inventories, build, blocking
  checks, traceability and qualitative prose review.
  Ratified 2026-10-09.
  Follow-up: Taxonomy carried — Roadmap: Close the statement migration gate.
- **PR10 archive, selective recovery.** Option C:
  note-by-note recovery in a migration lot, with
  the findings instructed in C. Decided
  2026-10-13.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **TikZ proof of concept into production.** All
  illustration figures are to be coded in TikZ.
  Decided 2026-10-13; application modalities remain
  open (see below).
  Follow-up: Production decision carried — figure conformance work in Roadmap: Re-audit and re-measure.
- **Zenodo DOI, not used implicitly as a
  publication concept.** Its exact role must be
  verified humanly on Zenodo; the release flow uses
  the concept record identifier explicitly, and a
  new concept is reserved for a voluntary creation.
  Provenance: D-10.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Zenodo PDF publication type.** Technical note;
  metadata aligned. Provenance: D-11.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **No public conformance claim while coupling is
  unestablished.** Lean checks the specification
  and its formal obligations; the implementation
  exists separately. Provenance: D-12.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Fair-software badge, manual four out of five.**
  The registry criterion is explicitly out of
  scope; the displayed score is not presented as
  an automatic computation. Provenance: D-13.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Branch hygiene.** Historical branches
  classified in the branch-status register; the
  Claude Lean-reuse branch kept as a non-normative
  scientific archive at that date; the split
  outillage branch explicitly abandoned; the
  generated-status automation superseded by the
  later pull request. Provenance: D-14. Note:
  the 2026-10-25 remote-branch merges supersede
  this row in part — the split branches are now
  merged, the Claude branch remains unmerged and
  pending an explicit owner decision.
  Follow-up: Branch decisions carried — Roadmap: Decide the security and governance questions (Claude branch still to be decided explicitly).
- **Cost budget totality.** The cost function is
  total under the explicit hypotheses and
  conventions that make work, depth and maximum
  well defined, as the maximum of work and depth.
  Ratification resolves the total-or-partial
  choice; it is not a proof of its properties.
  Decided 2026-10-11. Provenance: D-17.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Empty supremum convention.** The empty level
  set is allowed, and its supremum is 0 in N∞.
  Decided 2026-10-11. Provenance: D-18, D4. Note:
  the same decision is repeated inside the D-17
  section; see the divergence questions below.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Budget admissibility principle.** A budget is
  admissible when the announced cost does not
  exceed it, in canonical normalised form.
  Ratified 2026-10-11. Provenance: D-19, D5. Note:
  whether the canonical form itself is owner
  ratified, or only a logical normalisation, is
  questioned below.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Consume, partial domain.** Defined only where
  admissibility holds; on that domain its retained
  value is the budget minus the announced cost,
  under truncated subtraction. Decided
  2026-10-11, option A. Provenance: D-20, D6.
  Note: whether that value is retained or still a
  candidate is questioned below.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Psi domain independent of Consume.** Do not
  define Psi as partial exactly where Consume is
  partial, and do not infer from a Psi application
  alone that an effect traversal is authorised.
  Decided 2026-10-11, option B. Provenance: D-21,
  D7.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Budget consumption.** Extended truncated
  subtraction, with ω minus ω equal to ω, in the
  layers where Consume is used; layers do not
  define variants of subtraction. Decided
  2026-10-11, option A. Provenance: D-22, D8.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Multiplicity compatibility law.** The
  candidate law is formulated on the admissible
  domain where consumption and multiplicity
  operations are defined; sufficiency of the
  hypotheses, in particular for n = ω, must be
  established; no proof is claimed. Decided
  2026-10-11, option A. Provenance: D-23, D9.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Multiplicity law, restricted domain.** Kept
  as a conditional lemma, with hypotheses
  stronger than admissibility alone; n = ω is
  not included by default. Decided 2026-10-11,
  option A. Provenance: D-24, D10.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Multiplicity work order.** Audit the
  historically signalled demonstrations and their
  dependencies first; fix the exact lemma
  hypotheses only after that audit. Decided
  2026-10-11, option A. Provenance: D-25, D11.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Modes scope.** Three reference modes are
  retained — linear, affine, unrestricted — with
  their laws, morphism contract and realisation
  by the rules still to be normalised and proved;
  the Rel mode is not activated in the current
  grammar or generating rules. Decided
  2026-10-11. Provenance: D-16. The distinction
  between a usage interval and a structural Rel
  triplet is required; the candidate diamond
  establishes neither that current rules realise
  Rel nor that its activation is required.
  Reopening the scope for Rel is a separate owner
  decision, not taken here: it would require a
  precise use case no current mode expresses
  satisfactorily, a coherent definition separating
  the usage interval from the structural triplet,
  the morphism contract with its exact inclusions
  and non-inclusions, a rule-by-rule analysis with
  its substitution and cut obligations, an explicit
  separation of paper proof, Lean formalisation,
  tests and conjectures, and a decision on changing
  the published sedimentation and generating rules.
  Until then Rel stays a documented possibility,
  not a fourth activated modality.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **When, and the P3-B decision.** Environmental
  waiting is orchestrator surveillance latency,
  not the triggered automaton's execution cost.
  Ratified 2026-10-11. Already covered in the
  migration decisions above; formalisation of
  the separation, the orchestrator role and the
  budget contract remains open.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Budget discipline orientation.** Option C:
  budgets validated at compilation, automaton
  execution held within bounds, safeguards
  modulated by layer. Ratified for instruction
  2026-10-11. Already covered in the migration
  decisions above; a correctness theorem linking
  static acceptance to real execution remains
  open.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Owner decisions of 2026-10-19 and 2026-10-20,
  items 42 to 53.** (a) Reword 27 passages saying
  "demonstrated" or "established" while the
  statement is under review or proposed, using
  "sketched", "conjectured" or "open obligation".
  (b) KLean Prelude axioms: generate with
  selected rules and/or a patched, project-owned
  Prelude excluding Map, Set and List collection
  hooks. (c) K is the normative home of the
  chapter 3 and 4 grammar and semantics; Lean
  proofs run on KLean-generated types. (d) Psi
  is still to be done, documented in the
  axiomatics and in D-17 to D-25. (e) Progress
  theorem: modify the statement to be true
  without corrupting its intention, direction
  decided, exact text pending. (f) Traceability
  workstream: all traceability elements computed,
  reliably exposed, and proved by Lean tooling.
  (g) K code blocks in Verso files are normative.
  (h) Process proposals for decision records,
  roles and workstream: validated by the owner,
  recorded as architecture record 0011. (i) Lean
  version unchanged now (v4.34.0); migration to
  v4.36 or later to be planned. (j) TikZ
  figures: the drawing is always authoritative,
  alt text must match the drawing; other figure
  questions taken later. (k) Automata: any
  function or group of functions put into
  production is called an automaton; which
  automata each layer creates, and how types and
  categories are used, remain to discuss.
  (l) Remaining KLean plan items (records 003 to
  010, questions, notes): approved, to do.
  Provenance: owner answers 42–53.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **PR #246 review answers, 2026-10-20.** Redo
  PR #246 as a clean pull request from main,
  taking over its correct parts and crediting
  it; the owner closes #246. Progress: verify
  what really changes and the opportunity
  effects before a multi-choice proposal;
  options A to D prepared on paper, awaiting
  choice. Deadlock: keep the absence-of-blocking
  conclusion, make simulation an explicit
  premise. Effects: align every passage on
  effects as communications on distinguished
  channels; do not restrict the theorem to
  effect-free code. Binary replay: injectivity
  replaced by representation invariance.
  Stabilisation pipeline: move operational
  premises into the statement. Commutation
  schema: add the substitution-compatibility
  hypothesis. Mandate scope: items raised by
  ChatGPT's analysis only. Process proposals:
  validated, recorded as architecture record
  0011. Automaton definition: written in the
  chapter 4 introduction as the document's
  stance only. Note: the process-proposal answer
  here is the same decision as item 49 above, not
  a second decision.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **PR #252 and #256 answers, 2026-10-20.**
  Extra passages similar to the listed ones are
  included in the rewording mandate; the
  circuit-breaker caption must not confuse
  fibre, fibrille and co-fibre, and "cofree"
  in chapter 2 is written as the plain English
  word in italics. Both applied by PR #259.
  Follow-up: none — decided item, recorded for traceability; no roadmap section opened for it.
- **Statement taxonomy, implementation
  questions.** Scope vocabulary: closed list of
  21 identifiers, decided. State, evidence and
  formal-artifact representation in Verso
  directive arguments: decided, validated at
  compilation and by the ontology control.
  Ambiguous kind, role and state assignments:
  decided by ratification of the 69 blocks.
  Generated outputs and CI consumers:
  inventoried before the migration step.
  Bibliographic identifier format: open (see
  below).
  Follow-up: Implementation questions carried — Roadmap: Close the statement migration gate.
- **Scientific state C, 2026-10-11.** PR #54
  merged 2026-10-08, but stage C is not
  satisfied and stages D to F are not authorised.
  Grade interfaces ratified; conversion and
  comonad coherence, exhaustive substitution,
  resource correctness, simulation, the third
  memory hypothesis, operational measures and
  the full audit remain open. Already covered
  in [assurance](assurance.md); listed here
  only so the register is complete.

### Applied, awaiting ratification

  Follow-up: State carried — Roadmap: Close the theoretical gate and the master plan sequence (fresh gate verdict still required; the 2026-10-11 state is not a current verdict).
- **Grade components reopened.** Elision remains
  admitted as a presentation convention, but
  scalar action and grade-versus-mode separation
  remain to be established. Author decision
  2026-10-07, resumed in PR #54.
  Provenance: QA-28.
  Follow-up: Roadmap: Ratify the applied decisions — confirm, revise or revert with a dated owner decision; until then this item must not be quoted as decided.
- **Coherence results, epistemic status.** The
  coherence axiom, parallel action, mode
  morphisms and substitution theorems remain
  propositions; usage coherence is a distinct
  proposition. PR #54 merged 2026-10-08, but
  its merge is not scientific ratification of
  those statuses. Provenance: ARB-PR-04, PR-54.
  Follow-up: Roadmap: Ratify the applied decisions — confirm, revise or revert with a dated owner decision; until then this item must not be quoted as decided.
- **Scoped effects.** Algebraic and scoped
  effect structures named, weak closure on the
  second, monoid kept. To confirm: the Hefty
  Algebras reference stays uninstructed while
  the modularity need is unestablished.
  Provenance: ARB-PR-03.
  Follow-up: Roadmap: Ratify the applied decisions — confirm, revise or revert with a dated owner decision; until then this item must not be quoted as decided.
- **Seven deduced card closures.** Port and
  rewrite cards closed by deduction, with
  confidence marked "deduced" in the card-status
  file. Provenance: PORT-08, PORT-16, REECR-02,
  -06, -07, -11, -25.

### Open, awaiting an owner decision

- **Core-vocabulary ontological blockers.** Seven
  blockers that are not lexical votes; B-ONTO-07 was
  lifted on 2026-10-26 (see "Vocabulary arbitration
  sequence" under Decided), the six others are open:
  B-ONTO-01 (cross-check count of 46 omits `fix` and
  `declassify`, present in the grammar and ruled in
  C3); B-ONTO-02 (categories and typing of temporal
  forms, declassification, `at_n`, `move`);
  B-ONTO-03 (representation of the environmental wait
  of `When`); B-ONTO-04 (`When` resource correctness
  and a possible dual modality); B-ONTO-05 (`Vec`
  declared derived, its rules and any graded indexed
  fold each needing their own proof); B-ONTO-06
  (ν / `Out` / `Cop` rules present in C3 against a
  register narrative of missing rules); B-ONTO-07
  (no ratified rank for the ecological criterion until
  the method-arbitration question for it is answered).
  Provenance: core-vocabulary questionnaire, 2026-10-25.
  Follow-up: Roadmap: Work the research lot
  follow-ups — clear each blocker, or record
  explicitly that it stays open.
- **Positioning comparison, unfilled.** The comparison
  table against graded and quantitative systems has its
  "Difference with K7PL" column reserved for the owner
  and empty by construction; it also leaves open
  whether McBride's quantitative type theory needs a
  bibliography entry (with a verified source if so),
  which further keys become rows, and two reading
  questions noticed while collecting quotations. No
  differential comparison is therefore integrated
  anywhere until the owner fills the column.
  Provenance: positioning skeleton, 2026-10-20.
  Follow-up: Roadmap: Work the research lot
  follow-ups — fill, or record explicitly that it
  stays unfilled.
- **Lean compliance workstream, decision pending
  (issue #122).** Proposed decision, not taken:
  GO for the bounded demonstrator (Lake manifest →
  SPDX 2.3 inventory, 14 commit pins kept, unknown
  licences as NOASSERTION, serialised document
  compared against a pinned external SPDX validator,
  deterministic tests including negative manifest
  cases); NO-GO for treating it as a production
  compliance engine, for any production conformance
  gate, and for legal compliance claims. The
  demonstrator code already lives in the project
  (`tools/Compliance/`, SPDX checks in `scripts/ci/`);
  what is missing is the workstream decision, not the
  code. The requirement-to-evidence model is a second
  demonstrator with the same shape: GO for the small
  model and its counterexamples, NO-GO as a
  production engine or as a change to the normative
  language; its next validation step is an
  independently reviewed mapping of one real,
  non-safety-critical requirement. Conditions still
  open before any closure: human review of the
  empty-string interpretation for SPDX document and
  package names; formal ratification of the boundary
  between generic SPDX and the local K7PL profile
  (notably uniqueness of DESCRIBES relations);
  re-running the negative corpus after the provenance
  change, with each report binding commit, PR head,
  positive document, script and configuration hashes
  and effective tool versions; keeping raw
  observations and gaps, never deleting a mutation
  because it surprises. The negative corpus stays
  experimental and non-blocking. Provenance: Lean
  compliance assurance and decision notes, issue #122.
  Follow-up: Roadmap: Work the research lot
  follow-ups — decide with a dated owner decision, or
  record explicitly that it stays open; issue #122
  stays open until then.
- **K7OS deltas SPEC-D-02 to SPEC-D-25, open.**
  The provisional delta register of the k7os
  theoretical project (`theoretical-projects/k7os/
  SPEC-DELTA-REGISTER.md`) lists 25 deltas to
  instruct. SPEC-D-01 (delimiting the intrinsic
  guarantees) is closed only in its instructed
  perimeter, via PR #302: general simulation of
  context/continuation steps, full projection between
  representations, FFI contracts and their proof
  remain distinct obligations. SPEC-D-02 (a coherent
  assurance vocabulary) has a first tranche proposed
  in a separate PR, explicitly not its global closure.
  SPEC-D-03 to SPEC-D-25 (threat profiles and trust
  base; bilateral unsafe obligations; FFI contract
  versus native confinement; capabilities versus
  effective authority; memory model completion;
  out-of-domain and unsafe behaviour; confidentiality,
  integrity and non-interference as distinct
  contracts; observables and side-channel exclusions;
  actor computation versus the real wait graph;
  protocol fidelity, progress, deadlock-freedom,
  starvation and termination distinguished;
  cancellation, timeout and protocol-error contracts;
  what budget grades quantify; abstract cost versus
  machine cost versus WCET versus deadline
  feasibility; failure and recovery decomposition;
  journal, checkpoint, commit and external effects;
  source-to-execution adequacy; preservation at each
  MLIR/LLVM stage; trust base and reproducible
  assurance; requirement–definition–proof–test
  traceability; framing of zero-overhead claims;
  normative abstract machine versus concrete
  profiles; OS comparisons as falsification
  criteria; bounded models and counterexamples
  related to K7PL semantics) are each open: every
  delta needs an author decision and revalidation at
  the current head before any normative wording, and
  none is copied here as a clause. Provenance:
  k7os delta register, 2026-10-25.
  Follow-up: Roadmap: Work the research lot
  follow-ups — triage delta by delta, or record
  explicitly that a delta stays open.

  Follow-up: Roadmap: Ratify the applied decisions — confirm, revise or revert with a dated owner decision; until then this item must not be quoted as decided.
- **Four targeted imports, which to pour and
  where.** Said to be validated in the
  2026-10-01 session report, not poured into the
  text; the last is discarded for the size
  blocker, corrected otherwise. Three
  instructions to conduct, including the modes
  instruction.
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Spatial safety, origin of the first
  hypothesis.** (a) Complete the arena
  elimination rule, from which the unique
  introduction theorem would then derive the
  hypothesis independently. (b) Keep the
  hypothesis as a normative or architectural
  hypothesis, restricting the scope of the
  unique introduction theorem or leaving its
  state open. (c) Reformulate objects and
  premises after reviewing the rules, if the
  two statements aim at different uniqueness
  levels. The second and third hypotheses
  remain distinct. Provenance: H1.
  Follow-up: Roadmap: Decide the spatial safety hypothesis — decide with a dated owner decision, or record explicitly that it stays open.
- **Unique introduction theorem, split or not.**
  (a) Three statements. (b) One block
  distinguishing its three parts. (c) Current
  text with a note. Provenance:
  thm:introduction_unique.
  Follow-up: Roadmap: Decide the spatial safety hypothesis — decide with a dated owner decision, or record explicitly that it stays open.
- **Binary replay, scope of the E_repro
  question.** Under the representation profile,
  does binary replay identity hold for a single
  machine only, without multi-actor binary
  replay? Does the E_repro ordering aim at the
  order inside one actor, or the order between
  fibrilles of one machine? (a) One machine.
  (b) Multi-actor with a reception journal
  (unbounded journal). (c) Leave the scope to
  the profile (current state). The injectivity
  premise itself was decided 2026-10-20 (see
  decided items above); this scope question
  stays open.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Truncation comonad, separate or not.**
  (a) A literature object for the standard
  facts and a K7PL theorem for truncation
  preservation. (b) A block distinguishing the
  two parts. (c) Current text with a note.
  Related: text applied 2026-10-07 (convention
  of spacing, additive graduation, idempotence
  as a tower of truncations, lambda defined
  directly) has no ratification trace; the
  PR #10 archive calls it "held as ratified".
  Options: confirm; revert to the composite
  definition with a restricted container class;
  or confirm precision by precision.
  Provenance: PREUVE-08.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Parallel determinism, orientation.** The
  statement says parallel "majors" sequential
  composition on depth, while the sketch
  concludes the parallel depth is at most the
  sequential depth. (a) Correct the statement.
  (b) Correct the sketch if the statement
  expresses the intention. (c) Leave with a
  note. The PR #10 archive applied (a) in
  session 31, without a decision trace.
  Follow-up: Roadmap: Decide the remaining concurrency questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Translation commutation, domain.** Raw
  terms, or well-typed derivations with a
  freshness condition for the restricted name?
  (a) Restrict to well-typed derivations and
  add freshness. (b) Keep raw terms and state
  the conditions under which translation is
  defined. (c) Keep current text with a note.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Fix image, separate or not.** (a) A
  definition of the translation clause, then
  the correctness theorem (typing, sorting,
  value). (b) Keep one block distinguishing
  the clause from what is demonstrated.
  (c) Keep current text with a note.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Journal stratification, premise.** State
  in the theorem the observational
  non-interference premise the sketch uses, or
  prove observation preservation directly.
  The property is held only for the sequential
  fragment and remains conjectural under
  concurrency.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Product relation, budget case.** The
  sketch declares the budget case "to be
  written". (a) Restrict the statement to the
  three covered factors and separate the
  budget as an open requirement. (b) Keep the
  statement and write the budget lemma.
  (c) Keep current text with a note.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Progress, local versus global.** (a) Split
  into a local progress statement, hypotheses
  in the statement, and a global progress
  statement, with pool configuration and an
  acyclicity premise. (b) Keep one block
  writing both forms with their premises.
  (c) Keep current text with a note. Owner
  direction 2026-10-19 and 2026-10-20:
  modify the statement to be true without
  corrupting its intention, options A to D
  prepared, exact text pending.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Truncated distributivity, reading of
  "necessary".** Manual verification, not
  mechanised, under the empty-supremum
  convention: the law holds for finite usage
  or zero coefficient, fails for infinite
  usage and non-zero coefficient at one
  value, holds at another. "False" therefore
  reads "is not an identity". (a) Reformulate
  as "is not an identity". (b) Restrict the
  statement to the domain where the law holds.
  (c) Current text with a note.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Box-times addition, totality.** The
  statement says the equality is total; the
  sketch conditions it on "satisfied
  structural domains". (a) Restrict the
  statement to those domains. (b) Complete
  the sketch to establish totality.
  (c) Current text with a note.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Product relation and subsumption
  coherence, usage domain named in sketches.**
  Both sketches name usage by N∞, while the
  normative usage scope is WithTop Q≥0:
  rational usages admitted in layer 2. (a)
  Correct the sketches. (b) Justify the
  restriction to N∞ in each sketch.
  (c) Current text.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Progress, terminal forms.** What to do
  with a statement refuted as written by
  well-typed closed computations that are
  neither terminal nor reducible? (a) Modify
  the statement (terminal list, sequential
  domain, or pool). (b) Move the state to
  refuted pending reformulation. (c) Keep
  under review with a note listing the
  witnesses. Owner direction: option (a),
  via decision 46. Provenance: D-P1.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Guard, multi-message junction.** Is
  multi-message junction native? Guard binds
  one message per branch; the sketch claims
  multi-place consumption as a "native
  operation". (A) Extend Guard to two-message
  patterns (stage F). (B) Keep one message per
  branch and withdraw the native atomicity
  claim. Provenance: D-P2.
  Follow-up: Roadmap: Decide the remaining concurrency questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Temporal forms, category.** Category of
  "always" and "now" (values or computations),
  and sort of forms whose terms and types do
  not agree (declassify, six temporal forms,
  at_n, move): correct the grammars, retype
  the rules, or refer to the metalanguage?
  (a) Values, with the given reduction
  schemas. (b) Computations, with terminal
  forms or dedicated steps.
  Provenance: D-T1.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **When under P3-B, form of environmental
  waiting.** The configuration has no
  environment component, and the reduction
  relation is "the definition of execution".
  (W1) Orchestrator component and a waiting
  terminal form. (W2) Sequential reading, the
  latency living in the orchestrator. (W3)
  The reduction relation does not reduce
  "when"; the translation gives its meaning.
  Provenance: D-T2. Note: the conclusion of
  "when" was changed in 2026-10-12 without a
  trace in the registers.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Phi, three questions.** Sense of the
  endomorphism in the monoid equation
  (monotone or monoid?); status of lambda
  with respect to mu; the ω case.
  Options per question are in the register.
  Provenance: D-φ1, D-φ2, D-φ3.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Level indexing of the logical relation.**
  Monotonicity in the level is false in the
  linear implication case on the unrestricted
  universe; no statement invokes it.
  (a) Discrete family, compatible with all
  current statements. (b) Functorial indexing
  on the level order, with an inclusion proof
  or a Kripke-type clause. (c) Add to the
  manuscript the sentence "non-monotone in
  level". Provenance: D-ℓ, FACT-07.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Spawn, send and move.** Are work and
  size projections (the level is preserved)
  or scalar aggregates? Add coupling clauses
  (stage F) or reduce the "closed temporal
  channel by rule" claim? Delimit now in
  stage C the domain of translation and of
  sort confinement, or wait for stage F?
  Work, size, time delta and level hat are
  undefined for these effects; no translation
  clause exists for spawn, send, guard, new
  or free. Provenance: D-S1, D-S2, D-S3.
  Follow-up: Roadmap: Decide the remaining concurrency questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Composition and delta classes, kept?**
  If so, under which propagation rule? The
  Verso text names four singularities without
  a rule; the union rule exists only on the
  split singularites branch. (i) Remove the
  two classes. (ii) Label union (the extension
  is no longer a wheel). (iii) Fixed
  priority. (iv) Composition does not absorb
  infinity. To be decided after gate C;
  stage D is blocked. Provenance: BLOQ-12,
  IMPL-07.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Compilation phase numbering.** The figure
  starts at Parse = 1 and intercalates 1.5
  and 2.5; chapters 3 and 5 invoke an absent
  Phase 0. (a) 0 to 10 consecutively.
  (b) Keep 1.5 and 2.5 and add "Phase 0:
  Expansion". (c) Parse = 0, Expansion = 1.
  (d) Expansion = 1.25. Provenance: STRUCT-06,
  REECR-16.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Primitive vocabulary method.** Is the
  vocabulary chosen and applied in one go,
  with common form rules, or primitive by
  primitive? Before or after the minimality
  audit? Only the order is decided
  (second to last); the minimality audit is
  open. (a) In a block. (b) As it goes, in
  the primitives file, current state, with
  collisions already noted. (c) Either, only
  after the audit. Provenance: T-68 method.
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Preservation order of section 6.1.** Must
  each pass, the representation and the
  environment declare what they preserve?
  Absent from main. (a) A table of
  denotational, graded, trace-at-level and
  representation preservation, a level-sensitive
  unit admitting only trace-at-level passes.
  (b) Declare nothing. (c) A single invariant,
  rejected by the card. Provenance: STRUCT-05,
  TRANS-04.
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Mailbox topology, multi-sender actor.**
  The text says "SPSC ring", the card is open.
  (a) One SPSC ring per (sender, mailbox)
  pair and a junction queue. (b) One MPSC
  ring. (c) An implementation question
  outside the normative text. The atomic
  matching protocol is to be chosen with the
  option. Provenance: IMPL-04.
  Follow-up: Roadmap: Decide the remaining concurrency questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Locale API proposal, optional.** Submit
  a locale API proposal to Verso, or close
  the anomaly on its local scope? Corrected
  locally; said to be open elsewhere; the
  prepared proposal is missing.
  Provenance: ANOM-10.
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **PR #10 archive, follow-ups.** (1) Pour
  thirteen reports 21 to 33 into history as
  a PR-02 archive series, or not. (2) Keep
  the branch or set an archive tag to
  guarantee permalinks. (3) Pour the T-68
  extract now or at stage G2. (4) Mandate or
  refusal for each normative proposal P-01
  to P-22.
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Interactive navigation, governance.**
  (1) Is the "reorient" phase decision taken
  or provisional? (2) Which pre-registered
  protocol to retain, and what expected
  answer for an unversioned SVG? (3) Is the
  inventory warning on publishing two
  generators obsolete? (4) Is the proof
  visualisation milestone M4 subject to the
  "reorient" gate?
  Follow-up: Roadmap: Validate the navigation prototype with users — decide with a dated owner decision, or record explicitly that it stays open.
- **TikZ in production, application
  modalities.** (1) Scope: specification
  figures only, or also ASCII diagrams in
  documentation? (2) Faithful reproduction
  or free redesign (a redesign may require
  changing an alt text or description, hence
  the specification)? (3) Mathematics
  composed in TeX or kept literal? (4) Two
  figures where alt text and drawing
  disagree — owner answer 2026-10-19: the
  drawing is always authoritative, alt text
  must match the drawing. (5) The
  undeclared services mind map: delete,
  archive, or convert? (6) Delete draw.io
  and mmd sources once replaced?
  Follow-up: Roadmap: Re-audit and re-measure — decide with a dated owner decision, or record explicitly that it stays open.
- **Metalanguage translation, context
  question.** Should the statement show a
  context for the distinguished effect
  channels in its target sequent? The target
  sequent holds only the translated context
  and the distinguished variable; since the
  owner's answer on effects, the sketch says
  an effect operation becomes a communication
  on a distinguished channel and the target
  sequent must count these channels, but the
  statement leaves them implicit. Raised in
  PR #261; no options prepared.
  Follow-up: Roadmap: Decide the remaining representation and translation questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Deadlock acyclicity, proof obligation
  question.** Is "every blocked state induces
  a wait cycle" acceptable as a proof
  obligation rather than a premise? The
  statement takes acyclicity and simulation
  as premises and concludes absence of
  mutual blocking; the step from a blocked
  state to a wait cycle is not a premise,
  the sketch relies on it, and the note
  leaves open the separation of terminal
  states and timeout progress from mutual
  blocking. Raised in PR #261.
  Follow-up: Roadmap: Decide the remaining concurrency questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Refinement erasure, wording question.**
  Should the statement say "latent effects"
  instead of "grades and effects"? The
  corollary says the phase erases "grades
  and effects", which the translation does
  not carry; matching the owner's answer on
  effects would need "latent effects".
  Raised in PR #261.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Preservation, side findings.** Two side
  findings of the instruction for decision
  46, on paper, not mechanised: a possible
  counterexample to the preservation
  statement via vector iteration, and an
  ill-sorted unfold scheme mapping a
  computation to a value. Among the options
  of decision 46, option C addresses both,
  options B and D only the second, with a
  fix of Unfold. Statement change, or rule
  changes for vector iteration and unfold?
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Progress, options of decision 46.** Which
  option? Do changes to the evaluation
  contexts of the reduction relation fall
  under decision 46? Options A to D prepared
  on paper, awaiting the owner's choice;
  every option rewords the prose on exactly
  one pure reduction per elimination rule
  and keeps the label, title, role and state.
  Follow-up: Roadmap: Settle the remaining statement wordings — decide with a dated owner decision, or record explicitly that it stays open.
- **Versions and tags.** Tag
  spec-v0.0.0-alpha.2, or set the citation
  file back to 0.0.0-alpha.1? Which version
  scheme for the implementation? As it
  stands, neither candidate tag would pass
  the release metadata check. Options:
  tag the alpha.2 version; set the citation
  file back until the next tag; and for the
  implementation, align the lakefile on a
  0.0.0-alpha scheme, or align the root
  changelog on 0.1.0.
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Editorial corrections awaiting agreement.**
  Eight corrections that do not change the
  meaning of a statement, but touch the
  manuscript text: retitle the bounded
  reinvocation schema to cover the ω case;
  replace Org italics with Verso italics in
  the least-fixed-point termination theorem;
  make explicit the subject ("the reference
  interpreter") in the interpreter fidelity
  theorem; repoint two reading-guide
  references from the refinement construction
  to its precision corollary; correct the
  wheel division example (0/0 is bottom,
  1/0 is infinity, not "x/0 is bottom for
  all x") while keeping the conclusion on
  non-homomorphism to IEEE 754; fix pending
  references (a vanished clause, and the
  singularity propagation table, absent from
  main); change "three components" to "four"
  in the system-scale file; align the time
  channel family notation with the normative
  form.
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Documentary question.** Restore the C8
  classification ratification register as an
  autonomous piece, or leave it as it is?
  Its rules and cross-cutting decisions are
  already taken over, without rewriting, in
  the migration register.
  Follow-up: Roadmap: Close the statement migration gate — decide with a dated owner decision, or record explicitly that it stays open.
- **Human actions, branches.** State of
  2026-10-14: no audit or obsolete branches
  remain on the remote; main, the
  generated-status automation, open pull
  request branches and the five valuable
  branches remain. Update: the 2026-10-25
  merges merged the split branches; the
  Claude branch remains unmerged, pending
  an explicit owner decision; the
  generated-status automation was excluded
  from those merges by instruction.
  Follow-up: Roadmap: Decide the security and governance questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Prototype appendices, editorial scope.**
  Present them separately, group them into one
  complementary-tooling appendix with an explicit
  boundary, or defer them? Open. The extraction
  framework above is decided; this scope choice
  is not.
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Bibliographic identifier format.** Open:
  sources remain free strings; no canonical
  resolution. Under C8.6 and C8.7, in the
  migration register's closure obligations.
  A second C8 implementation question is open
  with no task identified: evaluating which
  literature results should be reimplemented
  formally.
  Follow-up: Roadmap: Close the statement migration gate — decide with a dated owner decision, or record explicitly that it stays open.
- **Lean project assurance tools.** Open, to
  be instructed; no implementation decision
  taken. Issue #122 opens the exploration:
  compare Lean with simpler solutions, define
  a bounded assurance claim, propose a
  non-critical demonstrator with
  counterexamples; no implicit change to the
  normative specification or the Lean
  implementation. Provenance: D-15.
  Follow-up: Roadmap: Close the theoretical gate and the master plan sequence — decide with a dated owner decision, or record explicitly that it stays open.
- **Unreconciled items.** The September
  adjustment programme (115 items in three
  blocks) carries its items as "done" or
  "decided"; the research questions are
  closed 224 out of 225 (the one in progress
  asks whether integrable cones carry a
  graded exponential over the resource
  structure). They were not reconciled one
  by one with the current manuscript; a
  targeted reconciliation is proposed for
  items touching statements taken up under
  concurrency (blocks A and C).
  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
- **Identifier divergences, questions for the
  owner, not resolved here.** (1) The D-17
  section repeats, after its own decision, a
  paragraph on the empty supremum, which is
  the subject of D-18: keep both, or leave
  it to D-18 only? (2) The typed-interface
  audit says "decided, exact formula open",
  and the admissibility note ratifies the
  principle only; the D-19 heading is
  "canonical normalised form", and the
  theory-objects register says admissibility
  is "normalised to cost ≤ budget". Both
  call this a logical normalisation, not an
  owner ratification: does the owner ratify
  admissibility as equivalent to cost ≤
  budget in canonical form? (3) The
  typed-interface audit and the Consume
  note keep budget minus cost as the
  "candidate value", while D-20 says "its
  retained value": is this value retained,
  or still a candidate?

  Follow-up: Roadmap: Decide the remaining editorial and tooling questions — decide with a dated owner decision, or record explicitly that it stays open.
### What this itemisation does not claim

This itemisation is a transcription, in
descriptive titles, of the register as it
stands. It does not re-verify each decision
against the current specification, and it
does not promote an "applied, awaiting
ratification" decision to a decided one, nor
an open decision to a decided one. The
architecture decision records in
`docs/decisions/` are already itemised in the
concordance below; they are not duplicated
here. If the owner rejects this itemisation,
the register survives in git history, and
this section must be revised, not silently
kept.


## Open decisions for the owner, collected

- The three September 2026 arbitrations, explicitly left
  undecided in their September records and not decided by
  this page: whether non-commutativity should also be carried
  on the context or only as a grade parameter (the effect
  quantale already carries it); whether termination and
  productivity should stay two theorems or become one theorem
  parameterised by polarity; and whether a fibrille or
  cofibrille should be an added word or the named instance of
  a parameterised regime.
- The September 2026 reference-machine question: the language
  selects the acquire-release memory model without naming the
  reference machine against which worst-case bounds hold, and
  its liveness invariant holds only under a memory-fairness
  hypothesis. The specification states these as a bound and a
  hypothesis, not as a decided machine.
- The executable axiom policy's open question about the
  classical choice principle.
- The pure-layer array representation's open question.
- The exact versions still to be filled in for pinned tools
  and libraries.
- The future of the prototype appendices: separate, grouped,
  or deferred.
- The tracking register's decisions awaiting an owner
  decision, including editorial corrections and the
  multiplicity, budget and consumption themes listed above.
- The security maintainer decisions grouped in
  [security](security.md).
- Any decision marked "applied, awaiting ratification" in the
  source registers, which needs explicit confirmation before
  it is treated as decided.
- From the consolidated review of October 2026, the
  following owner decisions, none taken by this page:
  the mathematical definition aimed at for contextual
  composition on the four-coordinate grade (usage,
  monotonicity, level, budget) and the domain of the
  effect transformation; whether the automata hierarchy
  (local, actor, system) is a model of graded linear
  logic, with protocols encoded as linear implications,
  or an additional primitive mechanism — noting that
  the chapter 4 introduction already states, as the
  document's stance, that any production function or
  group of functions is an automaton, which does not
  settle the hierarchy question; the expression of
  the licence in SPDX terms — noting that the
  repository already maps licences per artefact
  (code under CeCILL-2.1, specification and
  documentation under CC-BY-4.0, citation file under
  CC-BY-4.0), so the signalled conflict is nuanced
  rather than confirmed, and the owner is to confirm
  the expression; and the genre of the document —
  specification monograph with a research programme,
  or a split into a foundations article and a Lean
  engineering and traceability article.
- Also open from that review: the wording of the
  remaining proof-vocabulary passages, including the
  progress theorem and absence of blocking, which the
  specification changelog leaves awaiting a decision;
  and the split of progress into local progress and
  global progress — noting that the current
  operational semantics text already separates
  them, with acyclicity of the dependency graph as
  the premise excluding mutual blocking, so the
  remaining point is the introductory wording, not
  a new fusion.
- The temporal order under concurrency, which the
  simulation audit requires to be ratified before
  the simulation is completed or restricted to the
  sequential fragment alone. The audit submits
  three options without choosing one: a local
  order per fibril, with no total order claimed
  between concurrent events; a global linearised
  order imposed by a shared time channel, with the
  token-acquisition and arbitration rules stated;
  or a partial order of events (dependencies /
  happens-before), with the mathematical object of
  traces, its composition operations and its
  preservation by the target defined — which could
  require a normative change to the trace model.
  If none of the three covers the author's intent,
  that intent must be specified rather than deduced
  from the sketched proof. Provenance (secondary):
  simulation audit, section 5.
- The normative proposals of the PR #10 archive
  recovery (P-01 to P-22: weakened distributive law,
  terminal forms of progress, size subtyping,
  temporal-form grammar, declassify premise, layer-2
  translation scope, multi-message Guard, try
  failure, missing schemes, time thread, replay
  profile and scope, SPSC topology, destructor
  invalidation, singularities, phase numbering,
  pass preservation order, reading guide, the
  "no single framework" monotonicity note,
  level non-monotonicity, editorial corrections,
  and the archive's anomaly-17 routes). None has
  received a mandate or a refusal: each awaits a
  point-by-point owner mandate or refusal, and this
  page does not apply any of them. Their underlying
  instruction verdicts are carried by the items
  above (phi questions, level indexing, spawn and
  send, composition and delta classes, phase
  numbering) and by the roadmap's Decide sections.
  The archive's non-normative deposits themselves
  (parallel and spawn studies, T-68 proposal,
  bibliography verifications, codes and premises)
  were closed with the research lot of 2026-10-25
  (abandoned as non-normative archive material, with
  reasons traced in the migration matrix) and
  are not decided here. Provenance (secondary):
  PR #10 archive recovery, section 6.

## Source concordance (secondary traceability only)

This table exists only so a reader can find the exact source
section. The descriptive titles above are the identities in
this wiki; the labels below are not headings and are not to be
used as titles.

| Descriptive title in this page | Source register | Former label |
| --- | --- | --- |
| Trust order and normative status of the executable text | Architecture decision records | 0001 |
| One concept, one home, no Lean mirror | Architecture decision records | 0002 |
| Executable blocks in the specification, and extraction | Architecture decision records | 0003 |
| Profile of the executable language | Architecture decision records | 0004 |
| Executable axiom policy | Architecture decision records | 0005 |
| Audited translator from executable to Lean | Architecture decision records | 0006 |
| Computed assurance statuses | Architecture decision records | 0007 |
| Initially out of scope | Architecture decision records | 0008 |
| Representation of pure-layer arrays | Architecture decision records | 0009 |
| Pinned versions and version upgrades | Architecture decision records | 0010 |
| Decision records, roles and workstream organisation | Architecture decision records | 0011 |
| Executable language as the normative home for type and automata grammar | Architecture decision records | 0012 |
| Future of the prototype appendices | Migration decisions, short arbitration sheet | Editorial future of the appendices, open |

The tracking register's many smaller decisions are not
concorded one by one in this draft. That is a deliberate scope
limit of Lot 2. Proposed rule, not yet decided by the owner:
the tracking register should not be deleted on the strength of
this thematic summary alone. A complete, descriptive
itemisation has now been produced above, in the
"Tracking register, itemised" section — each decision
with a descriptive title in plain language, former codes only
as secondary traceability — and corrected on 2026-10-25
with a follow-up line per item (roadmap section, or
explicit "none") and autonomous roadmap sections, on the
owner's direction that one roadmap section is one action
lot for a later agent. The itemisation remains pending
owner validation of the complete tracking, review and
method closing lot; the register's deletion in that lot
is local only, reversible from git, until the owner
validates it. The owner's validation of the conservative
Lot 2 closing did not settle it.
