<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Research

K7PL is a research project on the design and formal treatment of a programming language whose specification, formalisation, implementation, proofs, and executable tests remain traceable but distinct.

**Document version:** 1.0.0  
**Last updated:** 2026-10-25  
**Audience:** researchers, reviewers, contributors.

## Research problem

The problem is not merely to implement another programming language. It is to establish a development chain in which semantic and structural commitments made by a language specification can be represented, analyzed, formalized, implemented, and verified without silently changing their meaning between stages.

This combines language design, formal semantics, proof engineering, and scientific traceability.

## Research hypothesis

A language specification can be developed as a scientific object when its normative commitments are explicit, dependencies are traceable, formalizable content is represented in a proof assistant, and implementation and testing evidence can be related back to those commitments.

The hypothesis is stronger than “the implementation compiles” but weaker than a claim that the complete language is already formally verified.

## Scientific object

The object comprises language concepts and dependencies, the normative specification, its formal representation, properties selected for proof, the executable implementation, tests and counterexamples, and the assurance argument connecting them.

## Expected contributions

The project aims to contribute a precise language design and specification, a formal account of selected properties, proof-oriented Lean representations, an executable implementation with an explicit relation to the formal model, a reproducible assurance process, and a methodology for moving from specification claims to formal and executable evidence.

The exact scientific contribution claims remain subject to formal review.

## Validation strategy

Validation is multi-layered: specification review; formalisation analysis; Lean proofs; executable tests; consistency audits; and reproducibility through CI.

No individual layer substitutes for the others.

## Current limitations

The project remains under active specification review. Lean infrastructure and executable tests must not be interpreted as evidence that the complete normative specification has been formalized or that implementation conformance is already proven.

See [ASSURANCE.md](ASSURANCE.md) and [STATUS.md](STATUS.md).

## Open research questions

Open questions include the characterization of the mathematical foundations, the architecture of formal semantics, completeness of specification-to-formalisation correspondence, and properties for which implementation conformance can ultimately be established.

Detailed research history is kept in [research/](research/) (working analyses, research questions and corpus notes), [bibliography/](bibliography/) (the machine-readable bibliography and former sourcing lists), [peer-review/](peer-review/README.md) and [history/](history/). This material is provenance and evidence; it does not become a current research claim merely by being retained.

## Research and bibliography material

The files below are indexed so that each is reachable from a current page. Many come from the former working folder (origin recorded in [the provenance table](history/2026-10-07-provenance-migration.md)); most are written in French, and each carries its own dates. An entry here does not promote a file's conclusions to current research claims.

### docs/research/

- [2026-09-08-analyse-b-et-f.md](research/2026-09-08-analyse-b-et-f.md) — analyses B and F (8 September 2026): cost, risk and opportunity of the rule shape for the terminal coalgebra (B), and an attempt to show that a finite biproduct is necessary to K7PL and that codereliction matters (F).
- [2026-09-08-analyse-b-approfondie.md](research/2026-09-08-analyse-b-approfondie.md) — analysis B revisited after the author's correction (8 September 2026): where the earlier analysis was wrong and what decision B-b actually commits to.
- [2026-09-09-focus-f-route-4.md](research/2026-09-09-focus-f-route-4.md) — research focus F, route 4 (9 September 2026): the intuitionistic and probabilistic opening through measurable cones; verdict F4-3.
- [LEAN-COMPLIANCE-ASSURANCE.md](research/LEAN-COMPLIANCE-ASSURANCE.md) — workstream K (issue #122), Lean-tooled compliance assurance: the bounded Lake→SPDX 2.3 demonstrator, its evaluation runs, limits and extension decisions.
- [LEAN-COMPLIANCE-DECISION.md](research/LEAN-COMPLIANCE-DECISION.md) — proposed research decision for issue #122 (17 October 2026): conditional go for a bounded hybrid demonstrator (Lake inventory consistency, independent SPDX validation, separate OSV query); no-go for a general production compliance gate or legal/regulatory compliance claims.
- [POSITIONING.md](research/POSITIONING.md) — skeleton positioning table of K7PL against graded and quantitative type systems (Granule, quantitative type theory, Moon–Eades–Orchard, Abel et al.): bibliography keys and quotations of the specification only; the comparison column is left to the owner.
- [REQUIREMENT-EVIDENCE-MODEL.md](research/REQUIREMENT-EVIDENCE-MODEL.md) — non-normative research demonstrator for requirement-to-evidence traceability (`tools/Compliance/RequirementEvidence.lean`), a second work item of issue #122; in English.
- [SPDX-NEGATIVE-CORPUS-REVIEW.md](research/SPDX-NEGATIVE-CORPUS-REVIEW.md) — review of the non-blocking SPDX 2.3 negative corpus (issue #122): case-by-case observations from workflow run #39025036478 and the human decisions required before the corpus could become blocking.
- [ancienne-annexe-e-preambule.md](research/ancienne-annexe-e-preambule.md) — preamble of the former Annex E (formal presentation), kept verbatim after the annex was merged into chapters 1, 3 and 4 on 1 October 2026.
- [core-vocabulary-audit-2026-10-25.md](research/core-vocabulary-audit-2026-10-25.md) — current-SHA audit and initial findings for the non-normative core-vocabulary workstream.
- [core-vocabulary-historical-inventory-2026-10-25.md](research/core-vocabulary-historical-inventory-2026-10-25.md) — consolidated provenance inventory for Arc G, T-68, PR #10 and the archived Org toolchain; authority and cleanup status for each source family.
- [core-vocabulary-ontology-2026-10-25.md](research/core-vocabulary-ontology-2026-10-25.md) — non-normative ontology and lexical register, distinguishing current term forms from open minimality claims.
- [core-vocabulary-qcm-2026-10-25.md](research/core-vocabulary-qcm-2026-10-25.md) — individual lexical QCMs, token-vs-lemma questions and explicitly blocked decisions.
- [core-vocabulary-decisions-2026-10-25.md](research/core-vocabulary-decisions-2026-10-25.md) — append-only decision register template; author choice, scientific justification, ratification, integration and verification remain distinct.
- [core-vocabulary-closure-plan-2026-10-25.md](research/core-vocabulary-closure-plan-2026-10-25.md) — dependency-ordered closure plan and exit criteria for the vocabulary workstream.
- [arc-g-methode.md](research/arc-g-methode.md) — arc G naming method (31 August 2026): a five-step method written before any reading for the arc.
- [arc-g-collecte.md](research/arc-g-collecte.md) — arc G, step 3 (2 September 2026): collection of the names used elsewhere, by category; it records, it does not choose.
- [commentaires-du-manuscrit.md](research/commentaires-du-manuscrit.md) — author comments removed from the manuscript text on 1 October 2026 (`ANOM-05`), reproduced with their location.
- [corpus.md](research/corpus.md) — the literature corpus and what it allows one to read (28 August 2026, with a state note of 3 September); publisher abstracts removed.
- [instruction-arb-pr-04-rejeu-binaire.md](research/instruction-arb-pr-04-rejeu-binaire.md) — instruction of `ARB-PR-04` (1 October 2026): what the document promises for bit-for-bit replay; it instructs, it does not decide.
- [manques.md](research/manques.md) — corpus gaps (28 August 2026): missing sources by arc and commitment, with their resolution status.
- [questions.md](research/questions.md) — research question sets (28 August 2026), each with its status and follow-up.
- [rapport-qa-28.md](research/rapport-qa-28.md) — QA-28 instruction report (2 September 2026): does every binding need all four grade components?
- [registre-empirique.md](research/registre-empirique.md) — empirical register: the G entries, questions answered by measurement rather than by proof or reasoning.
- [sources-singularites.md](research/sources-singularites.md) — sources for the singularity propagations (`BLOQ-12`, `IMPL-07`): what is sourced and at which verification level.

### docs/bibliography/

- [references.json](bibliography/references.json) — the selected bibliography (251 entries), machine-readable source of the generated `tools/SpecBib.lean`; see [PROVENANCE.md](PROVENANCE.md).
- [decisions-bibliographiques.json](bibliography/decisions-bibliographiques.json) — dated decisions to keep uncited keys in the bibliography; referenced only by the archived former tooling.
- [verifications-pr02.md](bibliography/verifications-pr02.md) — bibliographic checks of the PR-02 campaign (`BIB` cards instructed by online search on 1 October 2026).
- [a-ajouter-collection.md](bibliography/a-ajouter-collection.md) — keys requested for the project collection; marked absorbed on 3 September 2026 and kept for the trace.
- [a-charger.md](bibliography/a-charger.md) — DOIs to load: the three of twenty still missing on 3 September 2026.
- [a-sourcer-manques.md](bibliography/a-sourcer-manques.md) — sourcing of the corpus gaps (31 August 2026), distinguishing identifiers verified online from those given from memory.
- [a-sourcer-nommage.md](bibliography/a-sourcer-nommage.md) — empirical naming literature for arc G (QG-8 to QG-11, 3 September 2026): eleven references not in the collection, no longer blocking.
- [a-traiter.md](bibliography/a-traiter.md) — state of the references on 3 September 2026 after the switch to two BibTeX files; its open points are marked settled.
