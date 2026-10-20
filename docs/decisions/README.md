<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Architecture decision records

This directory holds the architecture decision records (ADRs) of K7PL: one file per decision that
needs more than a line, with its context, the options considered, the outcome and how it is
checked. The one-line register of all decisions stays
[`docs/tracking/DECISIONS.md`](../tracking/DECISIONS.md), which indexes these files.

The conventions below were set by [ADR-0011](0011-decision-records-roles-and-workstream-n.md)
(owner decision 49, validated on 2026-10-20).

## Conventions

- **Format:** [MADR](https://github.com/adr/madr) « minimal » plus project fields; copy
  [`template.md`](template.md). Sections: Context and Problem Statement · Considered Options ·
  Decision Outcome (with Consequences and **Confirmation**, the check that enforces the decision)
  · More Information. A Proposed ADR that the owner has partly decided adds « Owner decisions
  already given »; open questions go in « Open questions ».
- **Fields** (a table under the title, because the REUSE header opens every file): Status, Date
  (last status change), Decision-makers, Proposed by, Decisions register, Depends on, Gates.
- **Numbering and names:** four digits from `0001`, never reused; the identifier is written
  `ADR-0001`; the file is `NNNN-english-slug.md`. Text and file names are in English (only
  `spec/` is French); the owner's French words are quoted as given.
- **Statuses:** `Proposed` · `Accepted` · `Rejected` · `Superseded by ADR-NNNN`. A decision that
  changes is recorded by a new ADR; the old one becomes Superseded.
- **Decision-maker:** Cyprien PIERRE, the owner (maintainer account `AntheaLiles`). Never an
  agent, never a placeholder. Roles that the KLean plan gave to separate people are hats of the
  owner: « author (spec hat) », « author (proof hat) », « author (tooling hat) ».
- **Proposer:** a person or an agent. The field is informative: an agent proposes, drafts and
  opens the PR; its analyses are evidence to verify, never an approval or a review
  ([`docs/security/GOVERNANCE.md`](../security/GOVERNANCE.md)).
- **Acceptance:** an ADR is accepted when the owner merges the PR that sets its status to
  Accepted; the merge commit by the maintainer account is the record. An agent never decides the
  status; it writes Accepted only to record a decision the owner has already given, quoted with
  its source, and that status takes effect only at the owner's merge.
- **Partial decisions:** when an owner decision settles only part of an ADR, the ADR stays
  Proposed and quotes the owner's words with the part they settle.
- **Link with `DECISIONS.md`:** each ADR names its register rows in « Decisions register »;
  `DECISIONS.md` has one row per ADR (identifier, title, status, link) and no copy of its content.
  Existing `D-n` / `ARB-PR-nn` rows are not converted retroactively.
- **Normative words** MUST, MUST NOT, SHOULD, MAY are used as in RFC 2119.
- **KLean plan identifiers:** ADR-0001…0010 are ported from the plan « Workflow KLean K7PL »
  (18 October 2026), a session document not deposited in the repository. Its identifiers are kept
  as written: principles PR-1…PR-8, work packages WP0–WP11, gates G1–G10, tests T1–T6,
  obligations O1–O13, profile rules K1–K9, open questions Q1–Q7, milestones M1–M4, task cards
  T-000…T-405. They are unrelated to the master-plan workstreams and sub-items (C1…, H1…, N0…)
  and to the proof-visualization milestones M1–M7.

## Index

| ADR | Title | Status | Depends on | Gates | Owner decisions (DECISIONS.md items) |
|---|---|---|---|---|---|
| [ADR-0001](0001-trust-order-and-normative-k-text.md) | Trust order and normative status of the K text | Proposed; partly decided | — | G6, G8 | 48 (K blocks normative), 44 |
| [ADR-0002](0002-one-concept-one-home.md) | One concept, one home (no Lean mirror) | Proposed | 0001 | review, G9 | 44 (related) |
| [ADR-0003](0003-k-blocks-in-verso-and-extraction.md) | K blocks in Verso and extraction | Proposed; partly decided | 0001, 0002 | G1, G2, G10 | 48 (K blocks normative), 53 |
| [ADR-0004](0004-k7pl-profile-of-k.md) | K7PL profile of K | Proposed | 0003, 0006 | G4 | 53; 43, 52 (related) |
| [ADR-0005](0005-executable-axiom-policy.md) | Executable axiom policy | Proposed — awaiting Q5 | — | G5 | 53; 43 (related) |
| [ADR-0006](0006-klean-as-audited-translator.md) | klean, an audited translator | Proposed; partly decided | 0004, 0005 | G5, G6 | 43 (Prelude route), 53 |
| [ADR-0007](0007-computed-assurance-statuses.md) | Computed assurance statuses | Proposed | 0003, 0006 | G8, G10 | 53; 47 (related) |
| [ADR-0008](0008-initial-out-of-scope.md) | Initially out of scope | Proposed | 0001 | review | 53 |
| [ADR-0009](0009-layer-3-array-representation.md) | Representation of layer-3 arrays | Proposed — awaiting Q3 | 0004, 0005 | G4, G5 | 53; 43, 52 (related) |
| [ADR-0010](0010-pinned-versions-and-upgrades.md) | Pinned versions and version upgrades | Proposed; partly decided | 0006 | G3, G5 | 50 (no Lean change now), 53 |
| [ADR-0011](0011-decision-records-roles-and-workstream-n.md) | Decision records, roles and workstream N | Accepted | — | — | 49 (validated 2026-10-20) |
| [ADR-0012](0012-k-as-normative-home-of-c3-c4.md) | K as the normative home of the C3/C4 grammar and semantics | Accepted | 0001 | — | 44 |

« Accepted » takes effect when the owner merges the PR that adds the record. The owner decisions
are the items of the section
[« Owner decisions of 19–20 October 2026 »](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026)
of `DECISIONS.md`.

### Dependencies of the ported ADRs

From the plan's index (« X ──► Y » means Y depends on X; the « Depends on » column above is
complete, the graph is the plan's summary):

~~~text
0001 ──► 0002 ──► 0003 ──► 0004 ◄── 0006 ◄── 0005
  │                          │        │
  └──► 0008                  └► 0009  └──► 0010

0003, 0006 ──► 0007
~~~

### Open questions of the KLean plan

| Q | Question | ADRs |
|---|---|---|
| Q1 | Exact names and definitions of the three layers; matrix of allowed crossings | 0003, 0004, 0009, 0012 |
| Q2 | Orchestrator model: sequential or concurrent? Determinism required? | 0002, 0004, 0012 |
| Q3 | Array representation; footprints on whole arrays or slices? | 0009, 0004 |
| Q4 | Are the fragments (ownership, grade, effects) and the algebraic laws of grades still current? | 0002, 0012 |
| Q5 | Is `Classical.choice` admitted (constructive requirement or not)? | 0005 |
| Q6 | Version a snapshot of the generated outputs? | 0010 |
| Q7 | Typing defined in K (algorithmic) or as a separate Lean judgment? | 0002, 0012 |

Owner decision 53 answers « ok => à faire » for ADR-003…010, Q1–Q6 and the instruction item N-8
(Lake targets or Makefiles for the chain): the work is requested; no question is answered by it.
