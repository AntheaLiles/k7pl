# Branch status

**Reconciliation: 2026-10-12, on `main` = `200b6935f5622e93d9add104e1f0e46dae6f6e6b`.**  
**State observed before that reconciliation:** 44 remote branch references (including `main` and the session branch `ccr-c4afa630-5uz1ic`) and three open PRs (#170, #182, #183).  
**Same-day updates:** #183 was merged (`ee0d05a`, tree identical to its head), then #184 and #185 (`main` = `96e1b1e`). The branches `research/c-kernel-effective-rules-2026-10-12`, `rebase/feat/navigation-graph-mvp` and `rebase/split/pr10-1-outillage-spec` were deleted on merge.

**Remote check of 2026-10-14** (`git ls-remote --heads origin`, `main` = `d03d166`). Seven branches remain: `main`, `automation/generated-status` and the five `valuable/*` branches of section 5. Every branch named in sections 1 to 4 and 6 is absent from the remote, under its original name and under its `obsolete/` name; so is `ccr-c4afa630-5uz1ic`. This register does not establish who deleted them or when. #170 and #182 were closed without merge on 2026-10-12 (19:03 and 19:02 UTC). #186, which carried this register, was merged on 2026-10-12 at 19:23 UTC. **Sections 1 to 4 and 6 are therefore closed**; their tables are kept as the record of what was checked. Section 5 remains live.

This register replaced the inventory of 11 October. It carried out the hygiene pass announced by [the recovery snapshot of 11 October](https://github.com/AntheaLiles/k7pl/blob/f1d25e42ffb8badd62918f713142794a957aff4b/docs/tracking/RECOVERY-STATUS-2026-10-11.md), § 5: for each head without an open PR, it records whether unique content remains. It recommends; it **authorises neither merge nor deletion**. No branch was deleted or rewritten during the reconciliation. Recovered content was carried by new `rebase/…` branches, and the original branches were left intact.

## 0. `obsolete/` and `valuable/` renaming (12 October 2026)

At the author's request, each work branch received a prefix stating its fate:

- **`obsolete/<original name>`**: 34 branches that no longer bring anything to `main`, sections 2 to 4 below. They were planned for deletion **after the merge of the PR carrying this register** (#186). That PR also restored the only content still unique to the `research/*` stack (see section 3).
- **`valuable/<original name>`**: 5 branches to keep: `claude/lean4-reuse-init-qvzlcg` and the four `split/pr10-*`, section 5. For `split/pr10-1-outillage-spec`, the prefix follows the instruction "the `split/*` are valuable"; its commit `c4aea10` is also contained in `split/pr10-2`, `-3` and `-4`, and its only useful residue was merged by #185.

Each new name pointed exactly at the SHA given in the tables; the 39 correspondences were checked after creation. Not renamed: `main`, `ccr-c4afa630-5uz1ic` (head of this register's PR) and `automation/generated-status` (automatically generated PR).

**State at the time of writing (12 October):** the new names existed, but **the old names had not been deleted**. The deletion was refused by the destructive-action control of the agent's session. Each branch therefore existed temporarily under both names, on the same commit. **Update of 14 October:** neither the old names nor the `obsolete/*` names exist on the remote any more (see the header).

In the tables below, branches are designated by their original name.

## Method and limits

Observed facts, in order:

1. The session clone was shallow (50 commits). The full history was fetched before any comparison, because a shallow clone distorts ahead/behind counts.
2. For each branch: `git cherry origin/main <branch>` (patch equivalence), then a real `git rebase origin/main` in a throwaway worktree. The rebase drops the commits whose patch is already in `main`.
3. For conflicting rebases, I measured the **residue** with the rule "the `main` version wins on every conflicting hunk", then inspected that residue by hand. This rule measures what remains; it does not decide between the branch and `main`.
4. Archive branches were compared file by file, and PR history was read through the GitHub API.

Limits: patch equivalence is not semantic equivalence. A null residue means that the branch adds nothing more to `main` without conflict. It does not say that the `main` version is the right one. This register is a dated snapshot: check the live references again before any deletion.

## 1. Open PRs (as of 12 October)

**Closed (2026-10-14).** All PRs below are merged or closed; their branches are absent from the remote.

| PR | Branch (head) | State checked on 12 October | Proposed action |
|---|---|---|---|
| [#183](https://github.com/AntheaLiles/k7pl/pull/183) | `research/c-kernel-effective-rules-2026-10-12` (`64d98e7`) | **Merged** on 12 October, after a full green CI (run [38293553896](https://github.com/AntheaLiles/k7pl/actions/runs/38293553896)). It contained the whole tree of #170: `git diff b055e38 9a1409a2` is empty. C3 kernel compiled and audited (258 declarations under `Spec.C3.EffectiveKernel`). | None. Gate C remains **NOT SATISFIED**. |
| [#170](https://github.com/AntheaLiles/k7pl/pull/170) | `research/c01-interface-ratification-2026-10-11` (`9a1409a`) | All its content has been in `main` since the merge of #183. It now conflicts with `main` on the pins of `tests/python/test_stage_c_interface_audit.py`, which #183 updated. Besides, a rebase merge was impossible: three merge commits (`0d575f7`, `a353c09`, `5de8d73`). | Close without merge, then delete the branch. History remains available through `refs/pull/170/head`. Do not rewrite the branch. *Closed without merge on 12 October, 19:03 UTC.* |
| [#182](https://github.com/AntheaLiles/k7pl/pull/182) | `feat/semantic-navigation-rendered-links` (`cc415a4`) | Empty diff with `main`: content integrated by #141; the head is a merge of `main`. | Close without merge, then delete the branch. *Closed without merge on 12 October, 19:02 UTC.* |
| [#184](https://github.com/AntheaLiles/k7pl/pull/184) | `rebase/feat/navigation-graph-mvp` (`be612be`) | **Merged** on 12 October. Conflict-free rebase of `feat/navigation-graph-mvp` (`f24763a`): "graph derived from the rendered HTML" approach, next to `build_semantic_graph.py`. No workflow called it yet. | Delete `feat/navigation-graph-mvp`: its two files are identical in `main`. |
| [#185](https://github.com/AntheaLiles/k7pl/pull/185) | `rebase/split/pr10-1-outillage-spec` (`f2b17f1`) | **Merged** on 12 October: the only residue of `split/pr10-1-outillage-spec` (`c4aea10`), two lines of `writing-rules.md` documenting `{printindex}`, `{idx}` and `{gloss}`. | Delete `split/pr10-1-outillage-spec`. Its commit remains contained in `split/pr10-2`, `-3` and `-4`. |

## 2. Branches integrated into `main` — empty rebase

**Closed (2026-10-14).** None of these branches exists on the remote any more.

Rebasing onto `main` left no change. These branches could be deleted after your verification.

| Branch | Head | Trace |
|---|---|---|
| `docs/semantic-navigation-model` | `5f2d9ce` | #137 merged |
| `feat/c8-shared-statement-ontology` | `335faf3` | #130 closed; patches present in `main` through #131 |
| `feat/figure-provenance-navigation` | `22aadf9` | #136 merged |
| `feat/semantic-navigation-graph` | `d68ebaa` | #138 merged |
| `feat/semantic-navigation-multi-slice` | `8957c46` | #144 merged |
| `feat/tikz-figure-poc` | `710ca34` | #127 merged |
| `feat/tikz-production-artifacts` | `b3dc217` | #135 merged |
| `feat/tikz-production-integration` | `87c7201` | #133 merged |
| `fix/semantic-graph-auto-width` | `83a1685` | #146 merged |
| `fix/tikz-visual-fidelity` | `3684370` | #142 merged |
| `fix/verso-figure-assets-html` | `d2cb684` | #124 merged |
| `research/stage-c-interface-closure` | `ce686c0` | #154 merged |
| `repair/pr54-coherence-2026-10-08` | `ebd08e7` | No PR under that name. 86 commits ahead: 78 are equivalent to commits of `main`, and the other 8 become empty on rebase. All its content is therefore in `main`; only the commit trajectory was specific to the branch. This corrected the "to keep" status of 11 October, which relied on a comparison not checked file by file. |
| `feat/semantic-navigation-rendered-links` | `cc415a4` | See #182 |

## 3. Branches contained in #170 and #183

**Closed (2026-10-14).** None of these branches exists on the remote any more; the restoration described below was merged with #186.

These are the stacked steps of decisions D3 to D11 and of the independent audit of gate C. They were merged into the #170 stack, not into `main`. `git cherry` against the head of #170 finds no patch without an equivalent, except for `research/l1-rel-mode-opportunities-2026-10-11`: its two remaining patches touch files that #170 takes over and revises (`L1-REL-MODE-OPPORTUNITIES-2026-10-11.md`, D-16 in `DECISIONS.md`).

**Correction of 12 October.** Patch equivalence was not enough. The merge commit `a353c09` of #170 kept the old version of two registers of `docs/migration/`. The D3, D5, D6 and D7 records of `L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md`, and one sentence of `L1-THEORY-OBJECTS.md`, were therefore missing from `main`. The typed register still said "D3 — OPEN", while `DECISIONS.md` records D-17 to D-21. The PR of this register carried over, unchanged, the residue of `research/d11-audit-multiplicity-sites-2026-10-11` (`37160f8`), which is also that of `research/c-gate-independent-audit-2026-10-11`. The residues of the other branches of the stack are earlier versions of it.

| Branch | Head | PR (base) |
|---|---|---|
| `research/mode-scope-c01-c02-2026-10-11` | `ec7076f` | #171 (stack #170) |
| `research/d3-cost-budget-total-2026-10-11` | `5f9ef4c` | #172 |
| `research/d4-empty-sup-zero-2026-10-11` | `183f17d` | #173 |
| `research/d5-adm-principle-2026-10-11` | `bf8234f` | #174 |
| `research/d6-partial-consume-2026-10-11` | `18d7c88` | #175 |
| `research/d7-psi-independent-domain-2026-10-11` | `855fb23` | #176 |
| `research/d8-global-truncated-subtraction-2026-10-11` | `6d10441` | #177 |
| `research/d9-admissible-multiplicity-law-2026-10-11` | `6928e07` | #178 |
| `research/d10-restrict-multiplicity-law-2026-10-11` | `a322e33` | #179 |
| `research/d11-audit-multiplicity-sites-2026-10-11` | `37160f8` | #180; direct ancestor of the head of #170 |
| `research/c-gate-independent-audit-2026-10-11` | `596a957` | #181 |
| `research/l1-rel-mode-opportunities-2026-10-11` | `f1901f8` | no PR |

Proposed action (12 October): these branches could be deleted after the merge of this register's PR, which contains the restoration above.

## 4. Superseded branches — no useful residue

**Closed (2026-10-14).** None of these branches exists on the remote any more.

| Branch | Head | Trace | Residue after rebase |
|---|---|---|---|
| `ci/diagnostic-localization` | `e340d38` | #65 closed | None: the three files conflict with the later version integrated into `main` (REUSE problem matcher and its test). |
| `feat/c8-dependency-cycle-audit` | `ee658aa` | #87 closed | None (`statement_inventory.py` was replaced by #91). |
| `feat/c8-statement-dependency-check` | `ea845ef` | #85 closed | None. |
| `feat/lake-osv-scanning` | `ce6ace6` | #103 closed, replaced by #104 | None. |
| `tooling/prototypes-bcd` | `df200aa` | #25 closed, replaced by #26 | None. |
| `feat/c8-controlled-statement-migration-ci` | `da6c657` | #143 closed, replaced by #139 | Artefacts only: a duplicated paragraph in `LEAN-STATEMENT-ONTOLOGY-IMPLEMENTATION.md`, the removal of an `import re` that `statement_inventory.py` uses, and a whole Verso file pasted in the middle of a sentence of `SixSchemasDeMetatheorie.lean`. Nothing to recover. |
| `feat/tikz-production-figures` | `030737e` | #132 closed | `--check-tracked` option of `check_tikz_poc.py`. It compared against `spec/figures/<figure>.pdf` and `.svg`, which `main` no longer tracks for TikZ figures since #135: obsolete. (`check_tikz_poc.py` itself was removed by #223.) |
| `improvement-suggestions-c74e0` | `65e726b` | #27 closed | Hybrid inconsistent with `main`: 3 failures of `scripts/ci/test_impact.py`, and loss of the executable bit of `scripts/axiom-audit.sh`. Two ideas could be redesigned, not merged: fetching `axiom-audit` by SHA, and classifying `scripts/axiom-audit.sh` among the triggers of the full path. |

Proposed action (12 October): these branches could be deleted after your verification. No PR was opened for them: it would have been empty, obsolete, or would have failed CI.

## 5. Branches to keep — author decision required

These branches carry content absent from `main` that I did not integrate: integrating it would require deciding a normative semantics or a semantic migration. On the remote they are named `valuable/<name>`.

### `claude/lean4-reuse-init-qvzlcg` (`d39d012`) — scientific archive

PR #10 was closed without merge. The branch contains a single commit of 115 files. Content absent from `main`:

- 13 reports of PR-02 sessions numbered 21 to 33 (5 to 7 October);
- 16 notes of the `analyses-decisions/` folder of the former research directory (index, `∥`/`vmap`, `spawn`, ANOM-18, singularities, seals, ARB-PR-04, ratifications, T-68);
- the studies `etude-parallele-fourche-entrelacement` and `etude-spawn-fil-de-temps`, `instruction-des-decisions` and `t68-vocabulaire-en-bloc`;
- the T-68 renaming tables and the scripts `vocabulaire.py` and `t68_renommer.py`;
- changes to `spec/`, to registers and to tooling. The rebase reports 36 content, modify/delete or add/add conflicts, plus 34 location conflicts for added files.

**Blocking finding.** `main` already contains **another** series of "PR-02 21 to 62" sessions, dated 7 October (`docs/history/2026-10-07-pr-02-21-grade-architecture.md` and following). Numbers 21 to 33 therefore collide with different subjects: these are two distinct PR-02 trajectories. Moreover, the research notes cite the old tracking and research directories from before the physical migration. `scripts/ci/check_documentation_architecture.py` rejects those paths outside `docs/history`, `docs/archives` and `docs/migration`. I therefore produced neither a rebase nor a PR.

**Review against the C registers (13 October 2026).** The recovery snapshot of 11 October asked for the archive's own notes to be compared with the current C registers before any decision. The review was done read-only, in four batches, on `d39d012` compared with `main` `489b082`. Registers consulted: `L1-THEORY-OBJECTS.md` and the `docs/migration/` audits, `DECISIONS.md`, the C8 migration register, `fiches-statuts.csv`, `docs/history/`, `docs/research/` and `spec/`. A sample of citations from each batch was re-checked in `main`. The review classifies the notes; it is neither a proof nor a ratification, and recommended no option.

| Batch | Archive files | Unit | Covered | Partial | Absent | Superseded | Outside C | Other |
|---|---|---|---|---|---|---|---|---|
| 1 | reports 21 to 33; `analyses-decisions/README.md`, `00-index-design.md`, `00-index-ratifications.md` | 16 files | 0 | 11 | 1 | 3 | — | 1 non-scientific |
| 2 | `analyses-decisions/01` to `07` | 31 points | 2 | 10 | 10 | 6 | 3 | — |
| 3 | `analyses-decisions/ratifications-*` (5 notes) | 31 points | 5 | 16 | 7 | 2 | — | 1 not checked |
| 4 | `∥` and `spawn` studies, `instruction-des-decisions.md`, T-68 notes and tables, `t68_renommer.py`, `vocabulaire.py` | 48 points | 4 | 14 | 9 | 6 | 10 | 5 tooling |

For batch 3, "covered" means recorded identically and "partial" means recorded differently. "Outside C" refers to stages E (`∥`), F (`spawn`), D (singularities) and G2 (T-68). "Superseded": `main` carries a later state, against which a recovery would have to confront the note.

Cross-cutting findings:

- **What `main` has already received.** The archive's other 25 reports are in `docs/history/`: 24 are byte-identical, and the 15th differs only by a link path. Other commits brought session 28 (`5fa5634`), the French index tooling (`abd88ea`), `docs/research/sources-singularites.md` and `scripts/verif_singularites.py` (`b6683da`). The archive's other changes to `spec/` are absent: of the lines it adds, 0 out of 40 are found in `AxiomatiqueGerminale.lean` and 11 out of 286 in `SemantiqueOperationnelle.lean`. These changes were not reviewed one by one.
- **Another specification.** The notes describe the specification of the archive trajectory: they cite labels and rules absent from `main` (`eq:reductions-orientees`, `eq:traduction-fils`, `thm:chaine_fils`, `thm:correspondance_niveaux`, rules `Nxt` and `Loc`) and the paths from before the physical migration.
- **Alleged decisions.** No note is a proof or a ratification. Several nevertheless present author decisions as taken, often through quotations dated 6 October, that `DECISIONS.md` does not record or contradicts (`D-7`). They are listed in [`DECISIONS.md`](DECISIONS.md).

Scientific findings of the archive that were absent from the registers of `main` and **not checked** in this review. Each called for a C instruction before any recovery; that instruction is now in [the C instruction of the archive findings](../migration/L1-C-ARCHIVE-FINDINGS-INSTRUCTION-2026-10-14.md):

- `φ_n(ε) = ε^n` would not be a monoid morphism if the effect is non-commutative, since `(εδ)^n ≠ ε^n δ^n` (session 24, `instruction-des-decisions.md`). `spec/Spec/C3/ReglesDeTypage.lean`, l. 642–645 and 657, places `φ_n` in `End_mon(ℰ)`; the justification given, `φ_n ∘ φ_m = φ_{nm}`, concerns the composition of the `φ_n`. The review did not establish whether `ℰ` is commutative. Objects C-01, C-03, C-06.
- `at`, `wait` and `when` do not reduce on a closed term: temporal introductions are computations, and their eliminations wait for values (`spec/Spec/C3/GrammaireDesTermes.lean`, l. 33). Risk reported for `thm:progres` (sessions 29 and 32, `instruction-des-decisions.md`). Object C-07.
- `Λα.c` and the copattern are missing from the terminal forms of `thm:progres`; the `Guard` branches do not encode the multiple message (session 29).
- Monotonicity in `ℓ` would be false on function types (`FACT-07`, session 28).
- `spawn`, `send` and `guard` have no translation in `thm:confinement_sortes`; no clause couples `Spawn`, `Send` and `Move`; `w` and `s` are not defined; `Tick` is scalar (analyses 02 and 03). Stages F and C-07.

The archive's own content, usable only if the author chose a selective recovery (option C):

- **Non-integrated normative drafts**, which would require a mandate: distributive law and index lemma (24); reduction schemes (29, 31, 32); phases 0 to 10 (32); §3.2 and singularities (31 to 33); `E_repro` "on one machine" and SPSC topology (31); preservation order of §6.1 (22); reading-guide sentences for `STRUCT-15` and `TRANS-08` (21, 25).
- **Research or tracking pieces**: design dossiers (`00-index-design.md`) and verdicts on 15 records, with five model questions (`00-index-ratifications.md`); V0 to V7 grid and map of the ambivalences of `∥` (E); options O1 to O4 and E1 to E10 grid for `spawn` (F); impact table of `∘` and `δ` (D); third BIB check (28); codes-and-premises table (17 of 48) and `TRANS-06` table (32); module hypotheses "`ℒ` finite" and "`⟦operation⟧` without thread" (29).
- **T-68 tooling**: the reported collisions remain checkable on `main` (`at` for two forms, `open` and `unpack`). The tables, `t68_renommer.py` and `vocabulaire.py` use the pre-migration paths and their counts are wrong on `main`, which counts 45 entries (`docs/migration/L1-T68-AUDIT.md`).

Discrepancies internal to `main` found by the review, **not corrected** here:

- `spec/Spec/C3/LesContraintesDeValeur.lean`, l. 403, reads « en roues `1/0 = ⊥` »; `docs/research/sources-singularites.md`, l. 39, gives `1/0 = ∞` from the summary of Carlström. Which statement holds remains to be established on the source; the correction would touch `spec/` (see `DECISIONS.md`).
- `docs/research/sources-singularites.md`, l. 50 and 55, and the header of `scripts/verif_singularites.py` said the label-union rule was written in the manuscript. The Verso of `main` keeps four singularities (`LesContraintesDeValeur.lean`, l. 366–368): that rewriting exists only in the archive. Wording corrected on 14 October 2026 (PR #220).
- `ARB-PR-04`: `fiches-statuts.csv`, l. 125, and `FICHES-PR02.md`, l. 270, keep « orientation B puis C à confirmer », while `DECISIONS.md` records a replaced wording.
- Reported by batch 1 but not retained after checking: `PREUVE-08` "partial" (`fiches-statuts.csv`, l. 63) is consistent with the C8 register, where `thm:troncature_comonade` is `under-review` with a sketched proof.

**Author's choice (13 October 2026): option C**, selective recovery note by note in a `docs/migration/` batch. Fate of each piece, obligations and non-applied proposals: [recovery batch](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md); scientific findings instructed against `main`: [C instruction](../migration/L1-C-ARCHIVE-FINDINGS-INSTRUCTION-2026-10-14.md). Options A (deposit the reports into `docs/history/`) and B (archive referenced without recovery) were not retained; a possible deposit of the reports remains a separate question ([`DECISIONS.md`](DECISIONS.md)). The branch is kept.

### `split/pr10-2-troncature-conformite` (`99bc514`), `split/pr10-3-singularites` (`927a6fd`) and `split/pr10-4-manuscrit-semantique` (`b0d2cbf`)

These three branches share the commit `c4aea10` of `split/pr10-1`, whose only residue was recovered by #185. The rest of their content is mostly normative:

- **pr10-2**: §2.3 (truncation) and §6.2 (conformance), in conflict with the current version.
- **pr10-3**: wheel singularities (`LesContraintesDeValeur.lean`), with 56 lines of bibliography entries, `scripts/controles/singularites.py` and `SpecBib.lean`. This belongs to D/BLOQ-12, blocked by gate C. The non-normative part depends on the normative part, which I did not recover.
- **pr10-4**: about 30 `spec/` files. 57 of its 61 files are identical to those of `claude/lean4-reuse-init-qvzlcg`.

Recovering part of this text requires an author decision and, for D, the closure of gate C. To be kept as a historical reference until that decision is taken.

`split/pr10-1-outillage-spec` (`c4aea10`) is also kept under `valuable/`; its only residue is in `main` (#185) and its commit is contained in the three branches above.

## 6. Branches created by the reconciliation

**Closed (2026-10-14).** None of these branches exists on the remote any more.

| Branch | Role |
|---|---|
| `rebase/feat/navigation-graph-mvp` | head of #184 (merged) |
| `rebase/split/pr10-1-outillage-spec` | head of #185 (merged) |
| `ccr-c4afa630-5uz1ic` | session branch carrying this register (#186, merged) |

## Cleanup policy

1. This register authorises no mass cleanup. Each deletion remains a human decision, branch by branch.
2. Before deleting a branch, re-check its head: a head different from the one in the table invalidates the row.
3. The branches of section 5 are kept as long as no explicit author decision is recorded in [`DECISIONS.md`](DECISIONS.md).
4. Cumulative migration branches never replace exit gates. In particular, `split/pr10-3-singularites` does not allow bypassing stage C.
5. The recovery snapshot of 11 October (`RECOVERY-STATUS-2026-10-11.md`) was checked point by point on 13 October 2026, then deleted; its still-useful rules are in [the master plan](PROJECT-MASTER-PLAN.md) (§ 7 and X6). Last version: [`f1d25e4`](https://github.com/AntheaLiles/k7pl/blob/f1d25e42ffb8badd62918f713142794a957aff4b/docs/tracking/RECOVERY-STATUS-2026-10-11.md).
