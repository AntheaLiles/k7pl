<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Documentation architecture and migration plan

**Status:** IN PROGRESS — PHYSICAL REORGANIZATION  
**Scope:** repository documentation and historical artefacts  
**Principle:** classify knowledge before moving files

## 1. Purpose

The current documentation tree contains several information classes whose roles have become ambiguous. The problem is therefore structural rather than cosmetic.

The current tree mixes active project state, operational registers, historical records, peer-review evidence, research notes, and frozen source artefacts. The directory names also mix French and English while the project is intended to converge toward English maintained documentation.

This plan defines the target information architecture and the controlled migration process. The current branch executes the physical reorganization after classification and dependency analysis; final CI/link validation remains separate.

The governing rule is:

> A file must be classified by the role of the knowledge it carries before its physical location is changed.

A successful migration must improve epistemic clarity, not merely rename directories.

## 2. Information classes

The migration should preserve five distinct classes.

| Class | Function | Examples |
|---|---|---|
| Current knowledge | Reader-facing project knowledge | architecture, research, method, assurance |
| Active tracking | Current work state | TODOs, decisions, obligations, anomalies, traceability |
| Historical evidence | Record of project evolution | dated sessions, former plans, historical analyses |
| Frozen archives | Preserved artefacts | old manuscript, retired tooling, fixed snapshots |
| Peer-review evidence | Adversarial assessment | reviews, reviewer findings, responses, consolidation |

Age is not sufficient to classify a document. A recent document may be historical evidence; an old document may still be an active register.

## 3. Proposed target architecture

~~~text
docs/
├── README.md
├── ARCHITECTURE.md
├── ASSURANCE.md
├── METHOD.md
├── PROVENANCE.md
├── RESEARCH.md
├── STATUS.md
│
├── archives/
├── bibliography/
├── history/
├── migration/
├── peer-review/
├── research/
├── security/
└── tracking/
~~~

The normative specification remains outside docs/ in spec/.

The proposed roles are:

### docs/archives/

Frozen artefacts whose value is provenance, reproducibility, or historical reconstruction.

The frozen Org manuscript and former Org tooling are now under docs/archives/. The former root archives/ location has been retired by the physical migration.

The former docs/archive/ singular container has been removed after reconciliation.

Archives answer:

> What exact artefact existed?

They should not become a second active documentation tree.

### docs/history/

Chronological evidence about how the project evolved: dated sessions, superseded plans, milestone reports, historical decisions, and other records whose primary value is historical.

The current journal/ and historique/ directories should converge here.

History answers:

> What happened, when, and why?

### docs/peer-review/

The single location for peer-review evidence.

The existing docs/peer-review/ entry point should remain canonical. Material currently under docs/relectures/ should be migrated into it.

A review document does not become normative merely because it is stored here.

### docs/tracking/

Active operational registers and work management.

This should become the home of material currently spread across docs/suivi/ and parts of other legacy areas:

- dashboards;
- active TODOs;
- decision and ratification registers;
- obligation registers;
- anomaly registers;
- traceability matrices;
- active primitive inventories;
- current status views.

Tracking answers:

> What is currently open, decided, blocked, or to be done?

### docs/research/

Active exploratory and analytical research material that contributes to current understanding but is not itself normative.

The current docs/recherche/ naturally maps here. The top-level docs/RESEARCH.md remains the reader-facing synthesis.

### docs/bibliography/

Bibliographic acquisition, verification, and source-analysis records.

The current docs/bibliographie/ maps directly here.

### docs/migration/

Controlled migration records only. It must not become generic historical storage.

### docs/security/

Remain separate because security and supply-chain assurance have a distinct evidentiary scope.

## 4. Archives versus history

This distinction must be fixed before physical relocation.

Archives preserve an artefact. Examples include the frozen Org manuscript, retired tooling, or a historical corpus preserved exactly.

History preserves an account of change. Examples include a dated session, former project plan, rationale for a decision, or record of a research campaign.

Therefore:

> archives/ answers what artefact existed; history/ answers how the project evolved.

They should not be collapsed.

## 5. Tracking versus history

A file belongs in tracking/ when its primary question is:

> What remains open, current, decided, blocked, or to be done?

A file belongs in history/ when its primary question is:

> What happened, when, and why?

Consequences:

- TABLEAU-DE-BORD.md is active tracking.
- DECISIONS.md is active tracking while it records current decision and ratification state.
- dated PR-02 session reports belong in history/.
- a historical PR-02 plan remains useful evidence even after a new plan supersedes it.
- a current obligation register belongs in tracking/ even if it cites historical sessions.

This distinction should drive the journal/ plus historique/ merge.

## 6. Preliminary directory migration map

| Current location | Target | Initial interpretation |
|---|---|---|
| root archives/ | docs/archives/ | frozen source artefacts |
| docs/archive/ | remove after reconciliation | redundant container |
| docs/journal/ | docs/history/ | dated research/project records |
| docs/historique/ | docs/history/ | historical snapshots and plans |
| docs/relectures/ | docs/peer-review/ | review evidence |
| docs/peer-review/ | unchanged | canonical review entry point |
| docs/suivi/ | mostly docs/tracking/ | active registers and dashboards |
| docs/recherche/ | docs/research/ | active research notes |
| docs/methode/ | docs/method/ | methodological material |
| docs/bibliographie/ | docs/bibliography/ | bibliographic work |
| docs/migration/ | unchanged | migration control |

This table is a migration hypothesis, not yet a file-by-file decision.

## 7. Preliminary classification of docs/suivi/

The current suivi/ directory is heterogeneous and must not simply be renamed.

| File | Preliminary target | Comment |
|---|---|---|
| TABLEAU-DE-BORD.md | tracking/ | current dashboard |
| FICHES-PR02.md | tracking/ | generated current view |
| fiches-statuts.csv | tracking/ | source of current statuses |
| DECISIONS.md | tracking/ | active decision and ratification register |
| registre-obligations.md | tracking/ | active obligations |
| ANOMALIES.md | tracking/ | active anomaly register |
| pr-02-plan-de-traitement.md | history/ after replacement by a current plan | historical planning artefact |
| factorisations-refusees.md | tracking/ or research-support | active negative knowledge; review needed |
| primitives.md | tracking/ | active T-68 inventory |
| hypotheses-de-module.md | tracking/ or assurance-support | formalisation assumptions; review needed |
| correspondance-enonces.md | tracking/ or assurance-support | current traceability |
| correspondance-theoremes-org.md | history/ or archives/ candidate | historical Org-to-Verso correspondence |
| registre-empirique.md | tracking/ or research/ candidate | requires semantic classification |

The purpose of this pass is to avoid recreating the current ambiguity under the new name tracking/.

## 8. English naming policy

The target directory names should be:

- archives/
- bibliography/
- history/
- method/
- migration/
- peer-review/
- research/
- security/
- tracking/

For maintained documentation:

- active Markdown should be English;
- generated Markdown should be generated in English;
- historical documents may retain their original language when translation would damage provenance;
- archived source material must not be silently translated.

The language migration is therefore a maintenance operation, not an archival rewrite.

## 9. Controlled migration protocol

No bulk move.

For each file:

1. classify its epistemic role;
2. classify it as current, historical, frozen, generated, obsolete, or mixed;
3. identify incoming and outgoing references;
4. identify scripts and CI jobs that depend on its path;
5. decide whether to move, rewrite, merge, split, supersede, or archive it;
6. preserve provenance until validation is complete;
7. perform the change;
8. update references and generators;
9. run CI and documentation controls;
10. only then mark the item complete.

Generated files must be migrated through their generators.

## 10. Migration checklist

### D0 — Freeze and inventory

- [x] Record the current docs/ tree as the migration baseline.
- [x] Search for references to root archives/, docs/archive/, docs/journal/, docs/historique/, docs/relectures/, and docs/suivi/.
- [x] Enumerate scripts and CI jobs that depend on those paths.
- [x] Identify generated files and their generators.
- [x] Produce a file-level classification table.
- [x] Do not physically move anything before this inventory is validated.

### D1 — Ratify the target ontology

- [x] Ratify archives/ versus history/.
- [x] Ratify history/ as the merger target for journal/ and historique/.
- [x] Ratify tracking/ as the target for active follow-up material.
- [x] Ratify peer-review/ as the single review-evidence location.
- [x] Ratify the English directory names.
- [x] Define current, historical, archived, generated, and obsolete precisely.

### D2 — Reorganize archives

- [x] Reconcile root archives/ with docs/archive/.
- [x] Move the frozen manuscript and former tooling to docs/archives/ only after dependency analysis.
- [x] Finalize docs/archives/ as the only documentation archive directory.
- [x] Update repository READMEs and conversion documentation.
- [x] Update scripts that refer to the old archive paths.
- [x] Validate reproducible Org-to-Verso conversion after relocation.
- [x] Treat migrated archive contents as frozen unless an explicit archival decision is made.

### D3 — Merge journal and historique

- [x] Classify every file in docs/journal/.
- [x] Classify every file in docs/historique/.
- [x] Detect duplicate or superseded plans.
- [x] Preserve dates and provenance.
- [x] Merge both directories into docs/history/.
- [x] Update historical cross-references.
- [x] Mark obsolete snapshots rather than silently deleting them.
- [ ] Verify that no current status depends on a history file.

### D4 — Consolidate peer review

- [x] Inventory docs/relectures/.
- [x] Merge the material into docs/peer-review/.
- [x] Preserve reviewer identity and dates.
- [x] Separate active review findings from historical review evidence.
- [x] Update the peer-review README.
- [x] Update references from tracking registers.
- [ ] Remove docs/relectures/ only after link and provenance validation.

### D5 — Extract active tracking

- [x] Classify every file in docs/suivi/.
- [x] Move dated session reports to history/ where appropriate.
- [x] Keep current dashboards and registers in tracking/.
- [ ] Identify documents that should instead become assurance evidence.
- [ ] Identify documents that should instead become research notes.
- [x] Identify generated files and their authoritative generators.
- [x] Rename remaining active tracking material in English.
- [x] Update generators and CI before moving generated files.
- [ ] Eliminate the current semantic ambiguity of suivi/.

### D6 — Rename remaining legacy directory names

- [x] bibliographie/ → bibliography/
- [x] methode/ → method/
- [x] recherche/ → research/
- [x] suivi/ → tracking/
- [x] relectures/ → merged into peer-review/
- [x] historique/ + journal/ → merged into history/

### D7 — English migration

- [ ] Translate active Markdown in the target tree.
- [ ] Translate generated prose in Python generators.
- [ ] Preserve historical and archived source text unless a translated companion is deliberately created.
- [ ] Check terminology across docs/ and spec/.
- [ ] Add a control preventing maintained documentation from reintroducing mixed-language structure.

### D8 — Final validation

- [ ] Run repository documentation checks.
- [ ] Run Verso build and HTML rendering.
- [ ] Run PDF generation.
- [ ] Run generated-status validation.
- [ ] Run link and provenance checks.
- [ ] Compare pre/post file inventories.
- [ ] Verify that no historical artefact has become current knowledge accidentally.
- [ ] Verify that no current obligation exists only in history/ or archives/.
- [ ] Update docs/README.md last, once the physical architecture is stable.

## 11. Explicit non-goals

The migration must not:

- rewrite scientific content merely because files move;
- translate archived source material and present the translation as the original;
- delete historical evidence because a newer document supersedes it;
- promote peer-review findings to normative status without an explicit scientific decision;
- create a second normative specification inside tracking/;
- infer epistemic status from a directory name alone.

## 12. Success criteria

The migration is successful only when a reader can answer, without reconstructing project history:

1. Where is the current project knowledge?
2. Where are current open tasks and decisions?
3. Where are peer-review findings?
4. Where is project history?
5. Where are immutable historical artefacts?
6. Which files are generated?
7. Which document is authoritative for each category?

The final test is therefore navigational and epistemic, not merely structural.

A clean directory tree with ambiguous roles is still a failed migration.

## Current execution note

This branch performs the planned physical reorganization as a controlled tree migration. Scientific content is not rewritten. Final validation (links, REUSE, generated views, CI, and the English-maintained-documentation pass) remains pending.
