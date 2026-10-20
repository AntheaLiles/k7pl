<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# ADR-0011 — Decision records, roles and workstream N

| Field | Value |
|---|---|
| Status | Accepted (takes effect when the owner merges the PR that adds this record) |
| Date | 2026-10-20 |
| Decision-makers | Cyprien PIERRE |
| Proposed by | Claude Code (agent), process note on owner decision 49 (2026-10-20) |
| Decisions register | [Owner decisions of 19–20 October 2026](../tracking/DECISIONS.md#owner-decisions-of-1920-october-2026), item 49 |
| Depends on | — |
| Gates | — |

## Context and Problem Statement

Owner decision 49 (2026-10-19) asked for proposals on decision records, roles and a workstream for
the K → Lean chain, « inspired by comparable K / Lean 4 projects », pending the owner's validation.
The KLean plan brought ten draft ADRs (French, role placeholders « responsable spec / preuve /
outillage », a root `adr/` directory), while the repository has:

- a one-line-per-decision register, [`docs/tracking/DECISIONS.md`](../tracking/DECISIONS.md)
  (French, identifiers `D-n`, `ARB-PR-nn`, `QA-nn`, …);
- one person holding every role: [`docs/security/GOVERNANCE.md`](../security/GOVERNANCE.md) states
  that agents are neither independent maintainers nor human approvers, and the independent human
  reviewer role is unfilled;
- master-plan workstreams A–K, where K is « Lean tools for project-compliance assurance »
  (issue #122) and no workstream covers the K Framework chain.

Comparable practice read for the proposals (process note, §1): MADR (`docs/decisions/`,
`nnnn-title.md`, statuses, Considered Options, Decision Outcome with Confirmation); Cedar RFCs
(decision comment then merge); GitHub CODEOWNERS (owners auto-requested; a PR author cannot
approve their own PR; administrators can merge without approval); KEVM, KWasm, Aeneas,
VersoBlueprint and leanblueprint for the chain itself.

## Considered Options

Decision records (process note, N-5):

1. **MADR files in `docs/decisions/`, English slugs, `DECISIONS.md` as the index** (chosen).
2. `docs/tracking/adr/`: no new top-level `docs/` directory; departs from the MADR default path.
3. No ADR files, one extended row per decision in `DECISIONS.md`: the ten drafts do not fit
   one-line rows, and `DECISIONS.md` is French, against the English-outside-`spec/` rule.

Roles (N-6):

1. **No CODEOWNERS; roles as hats of one decider; enforcement in machine checks** (chosen).
2. CODEOWNERS listing `@AntheaLiles` for all paths, without required code-owner review: routing
   only, auto-requests on the author's own PRs, no assurance gain; must not be described as
   review.
3. CODEOWNERS with required code-owner review: every PR needs an administrator bypass, a gate that
   is always overridden (« review theatre »). Not recommended.

Workstream (N-7):

1. **New workstream N — Normative executable semantics (K definition → KLean → Lean proofs)**
   (chosen).
2. Rename the existing K to `Q` and give the K chain the letter K: edits in tracked documents and
   issue #122; historical mentions keep the old meaning.
3. Descriptive identifiers (`WS-SEM`) for new workstreams only: two naming schemes in one table.
4. Fold the chain into H: mixes the producer of evidence with the register that judges it, which
   decision 47 wants separated and computed.

## Decision Outcome

Chosen options: option 1 of each list, as proposed in the process note. The owner answered
« oui » to the proposals on 2026-10-20. No further rationale was given by the owner.

### Decision records

- ADRs live in `docs/decisions/`, one file `NNNN-english-slug.md` per decision; four-digit
  numbers from `0001`, written `ADR-0001`. [`docs/decisions/README.md`](README.md) holds the
  conventions and the index; [`docs/decisions/template.md`](template.md) the template.
- Template: MADR « minimal » plus project fields — status, date (last status change),
  decision-makers (the author only; never an agent, never a placeholder), proposed-by (a person or
  an agent; informative, not an approval), decisions-register rows, depends-on, gates. Sections:
  Context and Problem Statement · Considered Options · Decision Outcome (with Consequences and
  **Confirmation** = the CI check or Lean artefact that enforces it) · More Information.
- Acceptance act: the owner merges the PR that sets the status Accepted; the merge commit by the
  maintainer account is the record. An agent may draft the ADR and open the PR; it never decides
  the status.
- `DECISIONS.md` is the index: one row per ADR (ID, title, status, link), no duplicated content;
  the long form lives only in the ADR. Existing `D-n` / `ARB-PR-nn` rows are not converted
  retroactively; a row is converted only when it is superseded or reopened.
- The ten KLean drafts are ported into English with the single decision-maker, and « Decision
  Outcome » is pre-filled only where an owner decision already exists.

### Roles

- No CODEOWNERS file for now.
- In every ADR and in the KLean plan, « responsable spec / preuve / outillage » becomes the single
  decision-maker Cyprien PIERRE; where the plan needs a role, it is written « author (spec hat) »,
  « author (proof hat) », « author (tooling hat) ». No name is invented; agents appear only as
  proposers.
- Enforceable controls instead of reviews: the required check `CI OK`, extended along the KLean
  waves with the `proofs/` axiom audit and the extraction determinism check; the acceptance act of
  an ADR is the owner's merge.
- `GOVERNANCE.md` keeps its row « Relecteur humain indépendant — Aucun titulaire actuellement »
  (independent human reviewer: none); agents' « review » reports are evidence to verify, never
  approvals.

### Workstream N

- New master-plan workstream **N — Normative executable semantics (K → KLean → Lean)**, sub-items
  `N0`, `N1`, …: ADR-0001…0010 as N0 (framing); the KLean waves (gates G1–G10, WP0–WP11)
  re-expressed as N1…Nn with exit criteria in the plan's format.
- The letter K keeps its meaning (compliance tooling, issue #122).
- Relations stated in the plan: C (N moves C3/C4 normative content into K blocks and depends on
  C decisions such as ψ and `thm:progres`; the C exit gate stays C's); H (N produces evidence; H
  owns the register and, after decision 47, the computed status model; N keeps no status
  vocabulary of its own); I (the K definition run by `krun` becomes the executable reference model
  for differential testing); J (« no release unless the K model, the Lean proofs and the
  differential tests are up to date », as a release-gate item once those exist).
- The decision identifiers `N-1`…`N-11` of the KLean instruction, cited in `DECISIONS.md`, are
  not workstream sub-items; if that instruction is deposited, they are renamed (`KD-1`…).

### Consequences

- (+) Long decisions get a stable English home without overloading the French register.
- (+) No reviewer is invented; acceptance is a verifiable act (the owner's merge).
- (−) One more place to keep consistent with `DECISIONS.md` (one index row per ADR).
- (−) Until checks exist, nothing but the owner's merge enforces an ADR.

### Confirmation

Done in the PR that adds this record:

- `docs/decisions/` with README, template and ADR-0001…0012;
- workstream N in [`docs/tracking/PROJECT-MASTER-PLAN.md`](../tracking/PROJECT-MASTER-PLAN.md);
- index rows in `DECISIONS.md`;
- no `CODEOWNERS` file (the repository has none).

Proposed by the process note and not done yet: one row for `docs/decisions/` in
[`docs/ARCHITECTURE.md`](../ARCHITECTURE.md), and `docs/decisions` in `REQUIRED_DIRS` of
`scripts/ci/check_documentation_architecture.py` with its test (a strengthening of the check).

## More Information

### Notes on the record

- The process note (« Owner decision 49 — process proposals for the K → Lean chain »,
  2026-10-20) and the KLean instruction are session notes, not deposited in the repository. The
  owner's « oui » was given in the working session of 2026-10-20 and is relayed here as given.
- **Field layout:** the process note put the fields in YAML front matter. Every Markdown file of
  the repository opens with its REUSE header comment
  ([`.claude/skills/writing-rules.md`](../../.claude/skills/writing-rules.md), §4), after which a
  YAML block would no longer be front matter; the fields are therefore a table under the title.
- **Acceptance wording:** the process note says an agent « never sets accepted ». This record and
  [ADR-0012](0012-k-as-normative-home-of-c3-c4.md) were prepared with the status Accepted by an
  agent, at the request of the owner's session, because both record decisions the owner had
  already given; they are accepted only by the owner's merge. The owner may prefer to set the
  status personally before merging.
- The process note's further proposals P-1…P-6 (single K-version pin file, project-owned Prelude,
  coordinated toolchain bump, differential testing, literate K in Verso, computed statuses) are
  not part of this decision.
