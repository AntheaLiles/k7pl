<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL — Project Master Plan

**Status:** ACTIVE PLANNING  
**Snapshot:** 2026-10-10  
**Scope:** scientific/formal workstreams A–J and documentation architecture

This document is the project-level execution map. It does not replace the detailed registers, decision logs, theoretical-object register, assurance case, or documentation-migration plan.

## 1. Governing principle

The project is no longer one undifferentiated "PR-02 finishing" phase. The remaining work belongs to distinct tracks:

1. theoretical stabilization;
2. metatheoretical proof obligations;
3. language constructs and operational semantics;
4. specification/formalisation traceability;
5. implementation conformance;
6. release and reproducibility;
7. documentation architecture and knowledge migration.

The governing rule is:

> A downstream artefact must never silently stabilize an upstream scientific commitment.

Therefore:

- Lean compilation does not close a scientific obligation.
- CI success does not establish specification correctness.
- Implementation behaviour does not define the normative semantics retroactively.
- A historical document does not become current merely because it is referenced.
- A documentation move does not constitute a scientific rewrite.

## 2. Global state at the current snapshot

| Workstream | State | Anchor | Exit condition |
|---|---|---|---|
| A — finalize #50 | DONE | #50 merged | repository entry-point/security baseline incorporated |
| B — freeze CI/documentation baseline | DONE | #53 merged; current main baseline | execution baseline remains identifiable and reproducible |
| C — theoretical objects | IN PROGRESS — PR #54 merged; residual obligations remain | #54 + current migration/proof registers | theoretical interfaces closed; residual work explicit as proof/semantic/decision obligations |
| D — singularities | NOT STARTED in this sequence | BLOQ-12 / singularity work | singularity treatment resolved without hidden architectural change |
| E — ∥ | NOT STARTED | PR-02 continuation | parallel construct formally and semantically integrated |
| F — spawn | NOT STARTED | PR-02 continuation | spawn semantics and typing integrated |
| G — ratifications and T-68 | PARTIALLY PREPARED | DECISIONS.md / primitives.md | outstanding decisions ratified and T-68 closed |
| H — Spec ↔ Lean traceability | PARTIAL | scripts/controles/couverture.py | semantic traceability established |
| I — implementation conformance | OPEN | IMPL obligations / ASSURANCE.md | bounded conformance claim with evidence |
| J — release / PDF / Zenodo | PARTIAL | release gate P6; OpenSSF tracking in `docs/security/` | real tag-triggered release, attestation verification, Zenodo sandbox and reproducibility evidence |
| Documentation architecture | DONE | #58 + #60; D8 validated | physical architecture closed; semantic migration remains tracked separately in docs/migration/ |
| K — Lean tools for project-compliance assurance | OPEN — research question | [issue #122](https://github.com/AntheaLiles/k7pl/issues/122) | bounded assurance claim, evidence boundary, comparison with simpler alternatives, and go/no-go demonstrator note |

Main baseline is intentionally a dated snapshot rather than a maintained live SHA. For the current execution state, use the commit SHA attached to the CI run/PR under review; this plan does not assert a dynamic baseline.

## 3. Dependency structure

~~~text
A → B → C → D → E → F → G → H → I → J
          │
          ├── C8 statement-command taxonomy
          ├── provenance / historical classification
          └── semantic migration lots under docs/migration/
~~~

This is the principal execution order, not a requirement that every commit be serialized. Documentation inventory, bibliographic verification, provenance work, and early traceability infrastructure may proceed in parallel when they only record evidence and do not silently change scientific status.

The strict boundaries are:

- C before any downstream architectural reinterpretation;
- D before E when the parallel semantics depend on singularity treatment;
- E before F where spawn depends on the parallel semantics;
- G before release;
- I before release;
- final documentation validation after the scientific and generated outputs have stabilized.

## 4. A — Finalize #50

**Objective.** Complete the immediate repository/README/security cleanup.

**State.** DONE. #50 is merged.

**Exit evidence.**

- #50 merged;
- generated-status updates #51 and #53 subsequently merged;
- current main includes the resulting repository state.

**Rule.** Later documentation migration must not reopen the scientific scope of #50 unless a concrete inconsistency is found.

## 5. B — Freeze the CI/documentation baseline

**Objective.** Establish the repository state from which the scientific continuation is resumed.

The baseline establishes:

- generated project status through CI;
- a distinct verification gate;
- specification build/rendering evidence;
- Lean build, tests, lint and axiom-audit evidence;
- repository, documentation and security checks;
- an explicit statement that CI success is not scientific proof.

The baseline freezes execution evidence, not mathematical conclusions.

**Exit status: DONE.**

## 6. C — Restart PR-02 on theoretical objects

**Objective.** Stabilize the theoretical objects and their epistemic boundaries before reopening dependent constructs.

**Current state.** PR #54 was merged on 2026-10-08. This closed that delivery step, not workstream C: the remaining theoretical interfaces, proof obligations and semantic/decision questions remain tracked below and in the active migration registers.

The architectural exploration is substantially closed. The remaining work must be demonstrative, semantic, or decisional rather than a new uncontrolled architectural search.

### C1 — Object and boundary control

Every important object must be classifiable as:

- normative;
- derived;
- proof obligation;
- formal dependency;
- representation profile.

The working chain is:

object → signature → normative role → dependencies → invoked property → evidence → formalisation.

### C2 — Modes and grades

The current stabilized boundary is:

- 𝓡 carries the usage component;
- 𝒢 carries the complete grade;
- Scale_Usage acts only on usage;
- Consume and ⊖ concern budget consumption;
- φₙ concerns effective repetition multiplicity;
- Cost_Budget is the scalar interface for temporal cost.

The following identifications remain forbidden unless proved:

- 𝒢 as a global semiring;
- usage as execution multiplicity;
- modal intervals as complete mode algebras;
- budget as an exact residual;
- a theorem on one component as a theorem on the complete grade.

### C3 — Temporal objects

Temporal constructs must be analysed by layer.

For When, the current architectural resolution is:

- unbounded cost is exposed rather than hidden;
- finite-budget compatibility is mediated by the effect crossing through ψ;
- Adm remains distinct from ⊖.

### C4 — Operational semantics

The reduction relation remains the source operational object.

The translation to the metalanguage is a representation whose adequacy depends on Sim. PREUVE-07 therefore remains an obligation, not an assumed theorem.

### C5 — Memory and representation

The boundary is explicit:

abstract memory safety ≠ concrete representation conformance.

The representation profile Π is not a semantic property of the language. Logical replay remains semantic; bitwise replay belongs to representation-profile conformance.

### C6 — Remaining interface/proof obligations

The residual C work includes, at minimum:

- naturality, identity and composition for coerce;
- compatibility with w and c;
- substitution closure under conversions and Scale_Usage;
- the interaction between ψ and Cost_Budget;
- exact W/D aggregators and their properties;
- remaining semantic and memory obligations, including Sim and H1/H2.

### C7 — C exit gate

C closes only when:

1. every central normative object has an explicit signature;
2. every invoked relation has an explicit domain and direction;
3. external formal dependencies are separated from K7PL commitments;
4. open propositions and conjectures remain visibly open;
5. remaining work is proof/semantic/decision work rather than architectural discovery;
6. D–F can proceed without introducing hidden theoretical objects.

Compilation of #54 alone is not a C exit criterion.

## 7. D — Singularities / BLOQ-12

**Objective.** Resolve the singularity treatment without reopening the architecture stabilized in C.

D must identify:

- the singular object/interface;
- its normative status;
- its effect on typing and/or semantics;
- relevant invariants;
- proof obligations;
- exact formal correspondence.

D must not solve a singularity by introducing an implicit new algebra, mode, effect, budget operator, or representation assumption. Such a requirement returns to C.

**Exit criterion.** BLOQ-12 and related obligations are formally resolved, explicitly weakened/re-scoped with authorial ratification, or isolated as a bounded non-blocking open result.

## 8. E — ∥

**Objective.** Stabilize parallel composition using the C and D boundaries.

The treatment must cover:

- syntax and typing;
- grade/resource interaction;
- effect composition;
- operational reduction;
- trace/order semantics;
- existing invariants;
- Lean correspondence.

**Exit criterion.** ∥ introduces no second implicit semantics and does not bypass grade/effect accounting.

## 9. F — spawn

**Objective.** Stabilize spawn as a language construct, not merely an implementation convenience.

The treatment must cover:

- typing conditions;
- resource ownership and grade implications;
- lifecycle and trace semantics;
- sessions, mailboxes and actors;
- interaction with ∥;
- progress/productivity/termination obligations where applicable;
- Lean correspondence.

**Exit criterion.** spawn is defined by explicit semantic obligations and no longer relies on an informal runtime interpretation.

## 10. G — Ratifications and T-68

**Objective.** Turn decisions already applied in practice into explicit project decisions and finish the primitive vocabulary.

### G1 — Ratifications

Revisit at minimum:

- ARB-PR-03;
- the replay/representation boundary associated with ARB-PR-04;
- remaining import decisions;
- inferred status closures lacking explicit confirmation.

A ratification records the decision, rationale, scope and effect on normative text.

### G2 — T-68

T-68 is deliberately late in the finishing sequence.

The target is:

- one stable name per primitive;
- a consistent vocabulary across specification, formalisation and documentation;
- no terminology choice that silently changes semantics.

**Exit criterion.** No release-relevant authorial decision remains merely applied-but-unratified, and T-68 is closed.

## 11. H — Strengthen specification ↔ Lean traceability

**Objective.** Move from lexical coverage to semantic evidence.

The current coverage infrastructure can extract normative identifiers and detect candidate links, but current coverage is not a semantic correspondence proof.

### H1 — Normative to formal

For each selected normative commitment:

spec identifier → formal target → proof/evidence → status.

### H2 — Formal to normative

For each relevant Lean artefact:

Lean artefact → normative commitment → intended claim.

The reverse direction is required to prevent formal results from becoming de facto specification additions.

### H3 — Status semantics

The traceability register must distinguish at least:

- exact correspondence;
- partial correspondence;
- implementation-only artefact;
- external dependency;
- test/evidence only;
- no formal target required.

**Exit criterion.** The graph is strong enough for assurance review and no longer amounts only to lexical matching.

## 12. I — Implementation conformance

**Objective.** Establish the exact boundary between what Lean proves, what tests observe, and what the implementation is claimed to conform to.

Mandatory distinction:

mathematical proof ≠ formalisation success ≠ executable test ≠ implementation conformance.

The conformance case must state:

- implemented normative layer;
- intentionally unimplemented scope;
- representation profile assumptions;
- replay/reproducibility guarantees;
- proved properties;
- tested properties;
- residual assumptions.

ARB-PR-04 must be reflected consistently: logical replay is semantic; bitwise replay is representation-profile conformance.

**Exit criterion.** ASSURANCE.md contains a bounded, evidence-backed conformance claim with explicit limitations.

Compilation is not an exit criterion.

## 13. J — Release, PDF, Zenodo and reproducibility

**Objective.** Exercise the real publication path only after scientific and conformance gates are closed.

### J1 — Release candidate

Prepare:

- normative specification build;
- HTML rendering;
- PDF;
- generated status;
- traceability report;
- assurance state;
- repository metadata.

### J2 — Real release workflow

Exercise:

- version/tag;
- release creation;
- PDF artefact publication;
- Zenodo archival;
- DOI/provenance metadata;
- reproducibility information.

### J3 — Release gate

The existing P6 decision remains authoritative:

> first release only after P1–P5.

**Exit criterion.** A clean release can be generated from a known commit, and its artefacts can be independently identified and reproduced.

## 14. Cross-cutting assurance gates

### X1 — No hidden promotion

No theorem, implementation result, external result or test is promoted to normative status without an explicit scientific record.

### X2 — No backward semantic inference

A Lean definition must not retroactively determine the meaning of a specification construct merely because it is convenient for formalisation.

### X3 — Open claims remain open

The project keeps the conservative status vocabulary:

ESTABLISHED / PARTIAL / UNDER REVIEW / IN PROGRESS / OPEN / BLOCKED / NOT STARTED.

### X4 — Generated artefacts follow generators

Generated Markdown and status files are maintained through their authoritative generators.

### X5 — Green CI is necessary but insufficient

A green verification gate establishes execution of configured checks; it does not establish scientific correctness.

## 15. Documentation architecture as a cross-cutting workstream

The documentation chantier is not an eleventh scientific phase.

The physical architecture programme is closed. Its final historical record is [2026-10-08-documentation-architecture-plan.md](../history/2026-10-08-documentation-architecture-plan.md); active semantic migration remains under [docs/migration/](../migration/).

Its target information architecture is:

~~~text
docs/
├── README.md
├── ARCHITECTURE.md
├── ASSURANCE.md
├── METHOD.md
├── PROVENANCE.md
├── RESEARCH.md
├── STATUS.md
├── archives/
├── bibliography/
├── history/
├── migration/
├── peer-review/
├── research/
├── security/
└── tracking/
~~~

The epistemic distinction is fixed as:

- archives: preserved artefacts;
- history: evolution of the project;
- tracking: current operational state;
- peer-review: adversarial assessment;
- research: active exploratory knowledge;
- migration: controlled migration records.

PR #55 established the target ontology; #58 performed the physical reorganization and #60 completed the controlled D7/D8 documentation pass.

## 16. Documentation closure

The physical migration is complete. The former DOC-D0–D8 execution queue is retained in the historical architecture record and is no longer an active work queue.

Current rule:

- physical tree and generated entry points are closed under #58/#60;
- historical and archived provenance remains immutable unless explicitly reopened;
- semantic migration lots remain active under docs/migration/;
- current tracking is maintained in docs/tracking/;
- the dashboard is DASHBOARD.md and is a navigation surface, not a generated fact table.

The remaining documentation work is therefore maintenance and semantic extraction, not another directory migration.

## 17. Parallelism policy

Work that may proceed in parallel:

- C8 inventory and taxonomy analysis alongside the remaining C proof/interface work;
- bibliographic verification that does not alter normative claims;
- semantic migration lots whose output is explicitly non-normative;
- early traceability infrastructure that records gaps without closing them;
- security and repository hygiene.

Work that should remain sequential:

- C before downstream architectural reinterpretation;
- D before E when parallel semantics depend on singularity treatment;
- E before F where spawn depends on parallel semantics;
- G before release;
- I before release;
- semantic documentation extraction must not precede the closure of the scientific boundary it documents.

Work that must not cross an unresolved boundary:

- semantic rewriting against an unclosed formal object;
- implementation-conformance claims against an unresolved normative interface;
- archive relocation while active path dependencies remain unverified.

## 18. Global release gates

### P1 — Scientific blockers

No blocker remains open without an explicitly accepted scope.

### P2 — Open-claim discipline

Every open proposition, conjecture or requirement has:

- a status;
- a route;
- its relevant assumptions;
- no prose presenting it as established.

### P3 — Authorial decisions

Required decisions and ratifications are explicit.

### P4 — Implementation specification

Implementation obligations are closed or explicitly deferred with rationale.

### P5 — Manuscript/documentation stabilization

Normative text and reader-facing documentation are coherent; generated outputs are reproducible; final rereading is complete.

### P6 — Release

The first release is produced, archived and traceable through the real release/Zenodo workflow.

## 19. Definition of project completeness

The project is not complete merely because:

- CI is green;
- Lean compiles;
- the specification renders;
- the directory tree looks clean;
- the implementation runs.

For the first release, the defensible chain is:

normative claim → formal object/proof where applicable → executable/conformance evidence where applicable → assurance statement → reproducible release artefact.

Every missing link must be explicit.

## 20. Immediate execution queue

At the current snapshot:

The OpenSSF/security workstream is tracked separately in [the operational roadmap](../security/OPENSSF-ROADMAP.md) and [the human-action register](../security/ACTIONS-HUMAINES.md); it is intentionally not duplicated in this scientific execution queue.

1. complete the review of #54 and merge only once its current head is green and its scientific scope is accepted;
2. continue the remaining C proof/interface obligations and open C8 statement-command taxonomy as a dedicated sub-workstream;
3. do not reopen the completed physical documentation migration; use docs/migration/ only for the remaining semantic lots;
4. open D only after the C exit gate is satisfied;
5. execute E, then F;
6. ratify G and close T-68;
7. strengthen H from lexical coverage to semantic traceability;
8. establish the bounded implementation-conformance case I;
9. exercise J and P1–P6;
10. complete the semantic migration lots that remain justified, then maintain the closed physical architecture without recreating a migration work queue.
11. start K as a separate research question via issue #122; do not treat Lean formalization as automatic legal, contractual, or organizational compliance.

If a stage exposes a new architectural dependency, stop the downstream progression and reclassify the dependency rather than silently carrying it forward.

## 21. Authoritative supporting documents

The master plan is intentionally a navigation layer.

Detailed evidence remains in:

- docs/STATUS.md — generated repository/CI status;
- docs/ASSURANCE.md — assurance case;
- docs/tracking/DECISIONS.md — decisions and ratifications;
- docs/tracking/FICHES-PR02.md — PR-02 tracking;
- docs/migration/L1-THEORY-OBJECTS.md — theoretical-object boundaries;
- docs/history/2026-10-08-documentation-architecture-plan.md — completed physical documentation migration record;
- docs/tracking/LEAN-STATEMENT-COMMANDS-PLAN.md — C8 statement-command taxonomy and proof-bearing exposition;
- scripts/controles/couverture.py — initial specification/Lean coverage infrastructure.

The master plan should not duplicate theorem statements or historical session reports.

## 22. Maintenance rule

Update this master plan only when a workstream changes:

- dependency structure;
- exit criterion;
- scope;
- evidence class;
- position in the global sequence.

Routine progress belongs in the dedicated registers.


## 23. K — Lean tools for project-compliance assurance

**Status:** OPEN — prototype merged; expanded evaluation branch created; do not close until independent CI runs and corpus review are complete  
**Anchor:** [GitHub issue #122](https://github.com/AntheaLiles/k7pl/issues/122) · [decision, coverage and extension note](../research/LEAN-COMPLIANCE-ASSURANCE.md) · [merged prototype PR #128](https://github.com/AntheaLiles/k7pl/pull/128) · [evaluation branch](https://github.com/AntheaLiles/k7pl/tree/research/lean-assurance-evaluation-2026-10-11)

The current `main` head was checked as `86959948ff36deb6e8ee0985cf22740787696720`. Its global CI run [#1006](https://github.com/AntheaLiles/k7pl/actions/runs/38094667153) is **failed** at `Vérification / Spécification Verso`; the Lean implementation job succeeded. Do not quote an older green run as the current `main` status. Prototype PR #128 and documentation PR #147 are merged; issue #122 remains open.

The historical prototype evidence is retained: CI #891 and run #38086816755 each ran five timing samples against the same generated SPDX document SHA-256 `a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c`, validator script hash `279ed992c4cf534539a27179cacefa998c35fee7e1cf2427e5268c95dad3fe03`, and lock hash `300e52cba5c20930dfd2e7a9a1ef6042d057e56336de6ae58c67ff14b0646632`. Median `pyspdxtools` time was 304.564 ms then 277.628 ms; wrapper medians 316.976 and 288.930 ms; CLI process medians 381.283 and 345.772 ms. These are two runs with five within-run samples each, not a robust benchmark. Historical reports did not directly establish cache hit/miss state.

The isolated branch `research/lean-assurance-evaluation-2026-10-11` extends the non-blocking SPDX negative harness from seven mutations to 17 structured mutations, two raw-input cases (malformed JSON and wrong root type), and explicit command/tool-absence controls. It adds tests that each probe changes the fixture and that summaries do not claim schema coverage. The timing report records effective tool versions, runner/image information when available, and hashes of the SBOM generator, source manifest, Lean configuration, benchmark script, validator script, negative corpus and hash lock; cache observations are explicitly qualified as incomplete.

The first measurement run, [#38118745654](https://github.com/AntheaLiles/k7pl/actions/runs/38118745654), produced a successful Python job and evidence artefact, but the overall workflow was later **cancelled** after a newer branch commit and is not a completed end-to-end CI pass. The second run [#38118879020](https://github.com/AntheaLiles/k7pl/actions/runs/38118879020) is fully **success**: Python, Lean build/tests/lint, axiom audits, TikZ, Verso/PDF, and the security/REUSE/commit checks passed.

Both runs used identical SBOM SHA `a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c`, validator script SHA `279ed992c4cf534539a27179cacefa998c35fee7e1cf2427e5268c95dad3fe03`, SBOM generator SHA `dbd9cdc4709a2b3d8a3d4dd46c17d6513437e06ac1f7567cecd52552271612f4`, benchmark SHA `28b270b277c41dece4ccbeac3a0b2d56c5b9d1e34c5ad26bde04ac7c59334bf9`, negative-corpus SHA `0ae239b0c0d025ec64972a825d9043ee22bb95895c2a6e789b6a6cefceda5af8`, and lock SHA `300e52cba5c20930dfd2e7a9a1ef6042d057e56336de6ae58c67ff14b0646632`. Same Python 3.13.16, spdx-tools 0.8.5 and ubuntu24 runner image `20261004.327.1`. Five repetitions per run:
- Validator median 242.982 ms (235.505–248.182) then 307.206 ms (301.649–312.112);
- wrapper median 252.959 ms (245.874–258.674) then 319.455 ms (313.959–324.909);
- full CLI median 304.341 ms (299.104–316.036) then 382.304 ms (377.180–388.608).

Median increases of about 26% across these two jobs indicate meaningful inter-run variability compared with within-run spread, but do not explain its cause. The reported pip cache inventory is 5.7 MB / 70 files, with no direct cache hit/miss signal; no causal cache attribution is justified. These constitute two independent measurement jobs but only one completed full workflow run. A further **two completed full PR CI runs** at identical code/tool/input hashes are required for the declared three-full-run evaluation threshold.

The two artifact reports produce the same negative-corpus distribution: 17 structured mutations and two raw-input cases, direct `pyspdxtools` return code 0 for five observations and nonzero for 15; local wrapper statuses four `PASS`, 15 `FAIL`, one `ERROR`. #885 remains caught locally while accepted upstream; empty document-name string, unsubstantiated `licenseDeclared = "MIT"`, and a duplicate relation were accepted by the external tool and need different interpretations: normative ambiguity for the empty document name, no proof of external truth for MIT, and no general standard uniqueness constraint for relation objects (the latter violates only the narrow K7PL profile).

Scientific boundary remains fixed: theorem `Compliance.SbomAudit.verifyContract_sound` covers the declared predicate on the normalized finite Lean model. It does not prove parser fidelity, full SPDX conformance, output conformance on its own, inventory exhaustivity, dependency graph completeness, upstream fact truth, vulnerability absence, licence compatibility or organizational/legal compliance.

**Current recommendation:** GO for maintaining the bounded research prototype and completing this evidence evaluation. NO-GO for production-gate use, global compliance claims, or SBOM-exhaustivity claims. Extension decisions: CycloneDX—NO-GO unless a consumer requires it; OSV—GO with existing external scanner/adaptor, NO-GO for Lean reimplementation of a vulnerability engine; Syft/Grype—GO for bounded artifact-based comparison, NO-GO for a Lean replacement; ORT—GO for a policy/use-case-driven comparative evaluation, NO-GO for a bespoke license engine; fuzzing—GO for a bounded non-blocking `lean-fuzz` custom-target PoC at the JSON parsing boundary, NO-GO as a blocking gate before oracle/reproducibility/reduction qualification; SAST Lean—NO-GO for integration/gating, with `pc-sast-lean` only a research scaffold lacking real-language source extraction; WCAG/ARIA—NO-GO for general Lean compliance claims, GO to retain focused automated checks with human/assistive-technology evaluation.

**Remaining work before closure:** obtain at least two more completed independent full PR CI runs using identical source/tool/lock/input hashes; inspect JSON artefacts and error/diagnostic outputs; review probe expectations against SPDX 2.3; record what the independent validator does not detect; update this note and the workstream with observed rather than inferred results; review links and full CI. The completed full run #38118879020 validates the current commit; the next two runs must be allowed to finish before another branch write because the CI workflow cancels an in-progress pull-request run when a newer commit arrives. Do not close issue #122 or merge the evaluation PR before those steps and an accountable human decision. Do not modify normative `spec/` or K7PL implementation as part of this research pass.

The OpenSSF/security track is separate. Its operational status and ordered human actions remain in `docs/security/OPENSSF-ROADMAP.md` and `docs/security/ACTIONS-HUMAINES.md`; nothing in workstream K implies BadgeApp submission or a security attestation.
