<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Selective recovery of the PR #10 archive (`d39d012`)

**Status:** IN PROGRESS. Non-normative deposits V-02, V-03, V-05, V-06 and V-07 made on 2026-10-14 (§ 4); the exit criteria of § 9 are not all met.
**Original decision:** option C, retained by the author on 13 October 2026: selective recovery, note by note, in a lot of `docs/migration/`.
**Source:** branch `valuable/claude/lean4-reuse-init-qvzlcg`, commit `d39d012ea77277bfd774f67985966fb6ba7340cf` (PR #10, closed without merge).
**Base revision examined:** `main`, SHA `99a7375e764e86b3c19c19be82accd8db6096a91`; no cited file changes up to `06f8466`.
**Prior review:** [`BRANCHES-STATUS.md`](../tracking/BRANCHES-STATUS.md), section 5 (four lots, 126 classified rows).
**Epistemic limit:** migration qualification. This lot is neither a proof, nor a ratification, nor a modification of `spec/`.

## 1. Rules of the recovery

1. No normative modification of `spec/` without an explicit mandate, point by point. The normative drafts of the archive become **proposals** (§ 6), not applied.
2. No note is a proof or a ratification. The decisions that the archive attributes to the author are handled in [`DECISIONS.md`](../tracking/DECISIONS.md), not here.
3. Useful non-normative contents may be deposited in `main` at the appropriate living place, with provenance and a status banner (§ 4).
4. The session numbers 21 to 33 of the archive collide with the series `docs/history/2026-10-07-pr-02-21…62` of `main`; any deposit of a session record requires a distinct series name.
5. The pre-migration paths (`docs/journal/`, `docs/recherche/`, `docs/suivi/`, `biblio/references.json`) are refused by `scripts/ci/check_documentation_architecture.py` outside `docs/history/`, `docs/archives/` and `docs/migration/`, even inside a URL. Permalinks to the archive therefore appear only in this lot or in `docs/history/`.

**Categories.** DEPOSITED (historical or research piece, with banner) · EXTRACT (part taken up) · OBLIGATION (non-normative obligation attached to a C object or to a stage) · PROPOSAL (normative draft subject to a mandate) · SET ASIDE (reason given).

## 2. Provenance and access

Each piece is cited by its permalink `https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/<path>`, written ⟨path⟩ below. These permalinks depend on the preservation of the `valuable/…` branch or of an archive tag (decision pending). The line numbers of the archive refer to `d39d012`; those of `main` to the base revision.

Abbreviations: DEC = `docs/tracking/DECISIONS.md`; CSV = `docs/tracking/fiches-statuts.csv`; LSM = `docs/tracking/LEAN-STATEMENT-MIGRATION.md`; PMP = `docs/tracking/PROJECT-MASTER-PLAN.md`; INS = [stage C instruction of the archive's findings](L1-C-ARCHIVE-FINDINGS-INSTRUCTION-2026-10-14.md).

## 3. Decision table, piece by piece

### 3.1 Session records 21 to 33 (`docs/journal/`)

Common fate: **not deposited in this lot**. Depositing the thirteen session records in `docs/history/` corresponds to option A, which the author did not retain; it remains a separate decision (DEC, "Archive PR #10: deposit of the session records"). Their content is routed below, each piece being cited by permalink.

| Session | Piece | Content routed | Finding on `main` |
|---|---|---|---|
| 21 | [⟨docs/journal/2026-10-05-pr-02-21-struct-et-facts.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-05-pr-02-21-struct-et-facts.md) | O-20, P-17 | declares STRUCT-15/19/20/21, FACT-11/18, BLOQ-08 handled; CSV l. 9, 30, 34-36 keep them open or partial |
| 22 | [⟨…-22-preuves-fin.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-05-pr-02-22-preuves-fin.md) | P-16 | "PREUVE-09/15 closed", "PREUVE-04 proved": contradicted by LSM l. 77, 175, 235 |
| 23 | [⟨…-23-reprises-et-suivi.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-05-pr-02-23-reprises-et-suivi.md) | O-24 | not scientific; structure checks absent from `main` |
| 24 | [⟨…-24-loi-distributive.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-24-loi-distributive.md) | O-01, P-01 | examined: INS § 1 |
| 25 | [⟨…-25-trans.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-25-trans.md) | P-17 | TRANS-02 superseded (decision C-01 of 11 October); TRANS-03: CSV l. 115 |
| 26 | [⟨…-26-arene.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-26-arene.md) | — | superseded: the route retained corresponds to route (b) of H1, not ratified (DEC, row H1); CSV l. 10, 67 |
| 27 | [⟨…-27-coercions-produit.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-27-coercions-produit.md) | O-21 | superseded (`ReglesDeTypage.lean`, l. 437-439; DEC, `thm:relation_produit`) |
| 28 | [⟨…-28-troncature-et-conformite.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-28-troncature-et-conformite.md) | P-10, P-19, V-06 | truncation already in `main` (`AlgebresCoalgebresEtPointsFixes.lean`, l. 567-619, via `5fa5634`); FACT-07 examined: INS § 2 |
| 29 | [⟨…-29-anom-17-et-preuve-03.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-29-anom-17-et-preuve-03.md) | O-02, O-27, P-02, P-09, P-10 | examined: INS §§ 3 and 4 |
| 30 | [⟨…-30-arbitrages-deja-pris.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-30-arbitrages-deja-pris.md) | — | alleged "retained" decisions: DEC; D-7 is filed there among the entries **not** arbitrated (l. 47-48), contrary to the archive's README |
| 31 | [⟨…-31-orientations-appliquees.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-31-orientations-appliquees.md) | P-11, P-12, P-14, P-18, P-22 | its table "Modifications du manuscrit" describes changes **absent from `main`** |
| 32 | [⟨…-32-redactions-de-l-auteur.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-06-pr-02-32-redactions-de-l-auteur.md) | P-04, P-05, P-14, P-15, V-07 | quotations attributed to the author (l. 17, 79, 111, 154): DEC; ANOM-09 superseded (DEC, "Index PDF") |
| 33 | [⟨docs/journal/2026-10-07-pr-02-33-sources-des-singularites.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/journal/2026-10-07-pr-02-33-sources-des-singularites.md) | P-14, O-15 | examined: INS § 6; `docs/research/sources-singularites.md` is already in `main` |

### 3.2 Notes `docs/recherche/analyses-decisions/`

None is deposited in full.

| Piece | Fate | Destination | Reason |
|---|---|---|---|
| [⟨README.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/README.md) | SET ASIDE | — | § 5 handled in DEC; § 4 tracked by `FICHES-PR02.md` and `docs/bibliography/verifications-pr02.md`; false banner (PR closed without merge) |
| [⟨00-index-design.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/00-index-design.md) | EXTRACT | O-03, O-05, O-06, O-12 | cross-cutting findings (l. 35-41); recommendations set aside (regression `504739d` inaccessible) |
| [⟨00-index-ratifications.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/00-index-ratifications.md) | EXTRACT | O-16, O-17, O-19, P-05, P-11 | five model questions requalified (Q1 superseded: usage carrier `WithTop ℚ≥0`; Q2 belongs to D); R/N verdicts set aside |
| [⟨01-parallele-et-vmap.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/01-parallele-et-vmap.md) | OBLIGATION (E, FUTURE) | O-03, O-04, O-05 | grid V0-V7 and formulations of § 7: E material, aimed at `eq:reductions-orientees`, absent from `main` |
| [⟨02-spawn-et-fil-de-temps.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/02-spawn-et-fil-de-temps.md) | OBLIGATION (F, C-07) | O-07, P-06 | examined: INS § 5; table O1a-O4c and clause O1b: F material |
| [⟨03-anom-18-facteur-temporel.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/03-anom-18-facteur-temporel.md) | OBLIGATION (C-01, C-05) | O-06 | form of `κ` already in `main` (`GrammaireDesTypes.lean`, l. 109-118); Q1-Q2 superseded by D-17; remainder: INS § 5 |
| [⟨04-singularites-comp-et-delta.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/04-singularites-comp-et-delta.md) | EXTRACT (D, FUTURE) | O-10, P-14 | options A-E, impact table, reproduced computations: INS § 6; D blocked (PMP) |
| [⟨05-sceaux-progres-preservation.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/05-sceaux-progres-preservation.md) | OBLIGATION (C8) | O-11, O-29, P-20 | seals replaced by the C8.0 classification (role and state separated) |
| [⟨06-formes-temporelles-declassify-at-move.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/06-formes-temporelles-declassify-at-move.md) | OBLIGATION (C-06, C-07, G2) | O-08, O-09, O-10, P-05 | T-A reading superseded by P3-B |
| [⟨07-arb-pr-04-rejeu-binaire.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/07-arb-pr-04-rejeu-binaire.md) | OBLIGATION (C-08, G1) | O-13, O-14, P-11 | the rest is superseded (ARB-PR-04 reformulated, DEC) |
| [⟨ratifications-anom-17.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-anom-17.md) | OBLIGATION; verdicts SET ASIDE | O-18, O-19, P-02, P-03, P-07, P-08, P-22 | D-7 contradicted by DEC; ANOM-09 superseded |
| [⟨ratifications-effets-et-fermetures.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-effets-et-fermetures.md) | EXTRACT (G1) | O-22, P-01, P-13, V-07 | seven deduced closures: G1 material, to be checked again (CSV l. 46, 54, 137, 141, 142, 146, 160) |
| [⟨ratifications-grades-et-cadre.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-grades-et-cadre.md) | partly SET ASIDE | O-01, P-01, P-18 | STRUCT-16 superseded by D-16; TRANS-02, FACT-12, STRUCT-01 superseded |
| [⟨ratifications-numerique-et-execution.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-numerique-et-execution.md) | EXTRACT (D, FUTURE) | O-23, P-11, P-12 | false banner set aside |
| [⟨ratifications-pipeline-et-preuves.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/ratifications-pipeline-et-preuves.md) | PROPOSAL | O-16, O-17, P-15, P-16 | — |
| [⟨t68-vocabulaire-face-au-manuscrit.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/t68-vocabulaire-face-au-manuscrit.md) | EXTRACT (G2) | V-05, O-25, O-26 | dry run (counts false on `main`) and "en bloc" plan (alleged decision) set aside |

### 3.3 Studies and notes of `docs/recherche/`

| Piece | Fate | Destination | Reason |
|---|---|---|---|
| [⟨etude-parallele-fourche-entrelacement.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/etude-parallele-fourche-entrelacement.md) | DEPOSITED (§ 4) | V-02 | E material; its "verified facts" bear on `d39d012` |
| [⟨etude-spawn-fil-de-temps.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/etude-spawn-fil-de-temps.md) | DEPOSITED (§ 4) | V-03 | F and C-07 material; presupposes `eq:traduction-fils`, `thm:chaine_fils`, absent from `main` |
| [⟨instruction-des-decisions.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/instruction-des-decisions.md) | OBLIGATION, not deposited | O-01, O-02, O-08, P-04, P-05, P-07, P-08, P-12, P-22 | examined: INS §§ 1, 3, 4; header "orientations appliquées" (applied orientations): alleged decisions (DEC) |
| [⟨t68-vocabulaire-en-bloc.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/t68-vocabulaire-en-bloc.md) | EXTRACT (G2) | V-05 | registers K/N/S, rules R-K/R-N, table of 49 rows (base `d39d012`), collisions; alleged "en bloc" decision (DEC) |

### 3.4 T-68 pieces and scripts

| Piece | Fate | Reason |
|---|---|---|
| [⟨docs/suivi/t68-renommage.csv⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/suivi/t68-renommage.csv) | SET ASIDE | counts false on `main`; the six K correspondences are taken up by V-05 |
| [⟨docs/suivi/t68-table-de-renommage.md⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/suivi/t68-table-de-renommage.md) | SET ASIDE | refused path, false counts; the prose to be reread is covered by V-05 |
| [⟨scripts/t68_renommer.py⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/scripts/t68_renommer.py) | SET ASIDE | reads `docs/suivi/`; with `--appliquer`, would rewrite `spec/` according to a non-ratified vocabulary |
| [⟨scripts/controles/vocabulaire.py⟩](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/scripts/controles/vocabulaire.py) | SET ASIDE; G2 check proposal (FUTURE) | not wired; would fail on `main` (`Nxt`, `Loc`, `Declassify` without a rule against the 46 of `scripts/controles/croise.py`) |

## 4. Non-normative deposits

Deposited on 2026-10-14 as **English translations** of the archived French text (the project's language rule: only `spec/` is written in French). Each deposited file opens with a status banner (non-normative archived material from PR #10, closed without merge; not reviewed or ratified by the author; date of the translation; the original prevails in case of discrepancy; the current normative source is `spec/`), and carries its annotations in blocks marked "Editorial note (2026-10-14)", distinct from the translated text. The translations keep formulas, notation, Lean identifiers, labels, code, citation keys and table structure verbatim, and do not correct the scientific content. The annotations were checked against `main` at `7af5581`. The original French text of each piece is the one at its permalink below.

| Id | Content | Target | Archive source (exact path and permalink) | Translated | Annotations made | State |
|---|---|---|---|---|---|---|
| V-02 | study on `∥` (300 lines) | [`docs/research/2026-10-06-study-parallel-fork-interleaving.md`](../research/2026-10-06-study-parallel-fork-interleaving.md) | `docs/recherche/etude-parallele-fourche-entrelacement.md` — [permalink](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/etude-parallele-fourche-entrelacement.md) | l. 7-300 (whole text after the SPDX header) | labels absent from `main`: `eq:reductions-orientees`, `eq:reductions-couche2`, `eq:traduction-fils`, `eq:relation-sessions-mondes`, `thm:chaine_fils`, `thm:correspondance_niveaux`, `tab:invariants-de-passe`; no reduction scheme for `∥` or `vmap` on `main` (`SemantiqueOperationnelle.lean`, blocks at l. 42 and 82), so "applied" describes the archive; the correction of `thm:determinisme_parallele` "in session 31" is not on `main` (DEC l. 48, open); session records not deposited; the quoted author decision is the archive's attribution (DEC l. 123); stage E NOT STARTED (PMP l. 46). Rewritten: `biblio/references.json` → `docs/bibliography/references.json`; link to the sister study → V-03 | DEPOSITED (2026-10-14) |
| V-03 | study on `spawn` (291 lines) | [`docs/research/2026-10-06-study-spawn-time-thread.md`](../research/2026-10-06-study-spawn-time-thread.md) | `docs/recherche/etude-spawn-fil-de-temps.md` — [permalink](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/etude-spawn-fil-de-temps.md) | l. 7-291 (whole text after the SPDX header) | labels absent from `main`: `eq:traduction-fils`, `eq:reductions-couche2`, `eq:relation-sessions-mondes`, `sec:g-sortes-fil`, `tab:couverture-reductions`, `thm:chaine_fils`, `thm:correspondance_niveaux`; on `main` the questions are tracked by [`C-07-SIMULATION-AUDIT.md`](C-07-SIMULATION-AUDIT.md), § 5 (l. 105-115), and DEC l. 63 (D-S1 to D-S3); stage F NOT STARTED (PMP l. 47); session records not deposited; quoted author decision: archive's attribution (DEC l. 123); `hypotheses-de-module.md` is at `docs/tracking/` on `main`. Rewritten: `biblio/references.json` → `docs/bibliography/references.json`, `docs/recherche/corpus.md` → `docs/research/corpus.md`; link to the sister study → V-02; link to the writing rules unchanged (resolves) | DEPOSITED (2026-10-14) |
| V-05 | T-68 note (extracts) | [`docs/research/t68-vocabulary-proposal-archive-pr10.md`](../research/t68-vocabulary-proposal-archive-pr10.md) | (A) `docs/recherche/analyses-decisions/t68-vocabulaire-face-au-manuscrit.md` — [permalink](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/analyses-decisions/t68-vocabulaire-face-au-manuscrit.md); (B) `docs/recherche/t68-vocabulaire-en-bloc.md` — [permalink](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/recherche/t68-vocabulaire-en-bloc.md) | A: l. 161-191 (§ 4), 222-262 (§ 6), 337-354 (§ 10), 356-366 (§ 11); B: l. 29-38 (§ 2), 40-54 (§ 3), 56-122 (§ 4, as an annex on base `d39d012`), 133-150 (§ 6), 165-179 (§ 9). Not taken: A § 0-3, 5, 7-9, 12 (dry run, "en bloc" plan); B § 1, 5, 7, 8, 10 | the "en bloc" method and "retained by the author" are the archive's statements (DEC l. 24, 66, 70 item 3, 123); grammar base differs from `main` (`GrammaireDesTermes.lean`, l. 27-37: no `next`, no `loc_n`, `always`/`now` are computations); `croise.py` has 46 rules on `main`, `primitives.md` 45 entries (l. 3), cardinal under audit (`L1-T68-AUDIT.md`, l. 14-18); K-word counts on `main` (e.g. `at_n` 2, not 7; `loc` 0); every citation of `main` files re-checked: discrepancies annotated (`open Verso.Genre Manual` in 63 of 64 files, exception `spec/Spec/C3/EffectiveKernel.lean`; `current` once in a docstring of that file, l. 171; « placé » 3; words in « extract… » 11 in 7 files; « déclassification » 17, not 22; measured "values" line not that of `main`, O-25; occurrence counts not re-measured, O-26; "Phase 4"/"Phase 1" are archive numbering, `LeTheoremeDElaboration.lean` l. 28, `GrammaireDesTermes.lean` l. 62, DEC l. 65; prose `open` at `CalculDeProcessusSousJacent.lean` l. 315), and agreements stated (`unpack` 5 uses in 3 files; glossary 99 entries, l. 165, 290, 304; `AutoMark.lean` l. 19-22, `IndexCore.lean` l. 12-13, `IndexTerms.lean` l. 21-27; `GrammaireDesTermes.lean` l. 64-73; `ReglesDeTypage.lean` l. 587-589, 1490; `ERR-SLC-001`). Replaced: three links to undeposited design notes and one mention of the archive's register path | DEPOSITED (2026-10-14); see the pending decision below |
| V-06 | BIB records 3 to 5 | [`docs/bibliography/verifications-pr02-archive-pr10.md`](../bibliography/verifications-pr02-archive-pr10.md) | `docs/bibliographie/verifications-pr02.md` — [permalink, l. 42-81](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/bibliographie/verifications-pr02.md#L42-L81) | l. 42-81 (third, fourth and fifth records; records 1-2 are already in `main`) | "corrected text" false on `main`: `spec/Spec/C3/LesContraintesDeValeur.lean`, l. 403, still writes `1/0 = ⊥` (note of `req:homomorphisme_roues_realisation`, l. 387; DEC l. 84); `BIB-17` said closed while CSV l. 179 keeps it open; none of the other closures carried by CSV (l. 164, 167, 171, 173-178, 181, 188); IEEE 754 notice absent from `docs/bibliography/references.json`; union rule "corrected" absent from `main` (`LesContraintesDeValeur.lean`, l. 352, 366-368; `sources-singularites.md`, l. 11); `BIB-15` "a sentence now writes it": not found at `EchelleDuSysteme.lean`, l. 89-95. Rewritten: link `../recherche/sources-singularites.md` → `../research/sources-singularites.md` | DEPOSITED (2026-10-14) |
| V-07 | `docs/suivi/codes-et-premisses.md` | [`docs/research/codes-and-premises-archive-pr10.md`](../research/codes-and-premises-archive-pr10.md) | `docs/suivi/codes-et-premisses.md` — [permalink](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/docs/suivi/codes-et-premisses.md) | l. 7-87 (whole text after the SPDX header) | phase numbers are the archive's numbering 0 to 10 (archive `LeProcessusDeCompilation.lean`, l. 33-40), not that of `main` (l. 30-36; examples l. 106 and 142; DEC l. 65); the `structure.py` guard is absent from `main` (archive `error_codes_paired`, l. 114-120; nothing on `main`); the 48 codes are exactly those of annex A on `main`; `tab:propagation-addition` absent from `main`; FACT-09 partial (CSV l. 97), PORT-07 closed (CSV l. 45) | DEPOSITED (2026-10-14) |

These deposits are made in a change separate from the one that introduced this lot; none has been reread by the author. In `docs/research/` and `docs/bibliography/`, there is no string of an old path, even inside a URL: the exact provenance stays in this lot. **V-01** (deposit of the thirteen session records in `docs/history/`) is not planned: see § 3.1. The identifier V-04 is not used in this lot. **V-05 and a pending decision:** depositing the T-68 extract now or at stage G2 is listed as awaiting the author's decision (DEC l. 70, item 3); V-05 is deposited in a commit of its own, so that it can be withdrawn without affecting the other deposits.

## 5. Obligations (non-normative)

Working numbering; O-28 is not assigned. The obligations already examined refer to the stage C instruction, which details them.

| Id | Object or stage | Obligation | State |
|---|---|---|---|
| O-01 | C-01, C-03, C-06 | commutativity of `ℰ`, multiplicativity of `φ_n`, ω case | examined: INS § 1 |
| O-02 | C-04, C-07 | reduction of the temporal forms on a closed term | examined: INS § 3 |
| O-03 | E | "layer 3" strict or timed (`AxiomatiqueGerminale.lean`, l. 788-790, against `ReglesDeTypage.lean`, l. 1323-1326) | FUTURE |
| O-04 | C-08 | `Par` used with linear capabilities (`ModelesDeMemoire.lean`, l. 49-51) | open |
| O-05 | E | progress of `∥` requires the termination of the branches (`ReglesDeTypage.lean`, l. 1338-1343) | FUTURE |
| O-06 | C-01, C-05 | `w`, `s`, `δ_ℓ`, `ℓ̂`, coupling `Spawn`/`Send`/`Move` | examined: INS § 5 |
| O-07 | F | level of the `spawn` event | FUTURE |
| O-08 | C-06, C-07 | `@_nε`, `loc(Δ)`, `Ser(V)` and the cost `c` not defined (`ReglesDeTypage.lean`, l. 1476, 1490, 1496) | open |
| O-09 | C-07 | `○` without elimination; `F` without effect index (l. 1496) | open; see INS § 3 |
| O-10 | G2, D | notation collisions: `δ` (three meanings), `at`/`at_n`, `open`/`unpack`, « localisation » | open; INS § 6 (W3) |
| O-11 | C8 (checks) | `scripts/controles/notation.py` examines only the text that follows the cross-reference; measure before strengthening | open |
| O-12 | C-08 | `Π` without a coordinate for scheduling or for the compilation chain (`EchelleDuSysteme.lean`, l. 175, 189) | open |
| O-13 | C-07, C-08 | "per actor" scope of replay, D-loc variant | open |
| O-14 | G1 | ARB-PR-04: CSV l. 125 and `FICHES-PR02.md` l. 270 against DEC | open |
| O-15 | D | status of the claims of `sources-singularites.md` | lifted by the correction of the note (INS § 6) |
| O-16 | C8 | sketch of `thm:stabilisation_pipeline` (`LeProcessusDeCompilation.lean`, l. 155) | open |
| O-17 | G1 | `ERR-TOP-001` attributed to two phases; doctests "in Phase 1" | open |
| O-18 | C-06, C-07 | binding of the copattern (not checked) | open; INS § 4 |
| O-19 | F | double counting of the work in `spawn` | FUTURE |
| O-20 | G1 | STRUCT-15/19/21 and BLOQ-08 (CSV l. 9, 30, 34, 36) | open |
| O-21 | C-03 | "terminal unit" argument to be checked again under the usage `WithTop ℚ≥0` | open |
| O-22 | C-09 | option b of BIB-01 (CSV l. 163) | open |
| O-23 | D | the "finite" class hides floating-point overflow; the IEEE gap affects subtraction | FUTURE |
| O-24 | checks | structure checks of session 23 absent from `main` | open |
| O-25 | J | measured overflow of the "values" line (517 pt against 345 pt) on a substitute document | HUMAN ACTION: measure on the real PDF |
| O-26 | G2 | noise of the AutoMark tooltips (`tools/SpecExt/AutoMark.lean`, l. 21) | open |
| O-27 | C-07 | hypotheses "`ℒ` finite" and "`⟦operation⟧` without thread", conditional on P-10 | open |
| O-29 | C8 | `declassify` exception in ARB-PR-06 (LSM l. 402) | open |

## 6. Normative proposals (not applied)

None is to be applied without an explicit mandate, point by point. Working numbering; P-21 is not assigned.

| Id | Proposal | Passage of `spec/` | Object or stage |
|---|---|---|---|
| P-01 | "weakened" distributive law if `ℰ₀` is not commutative | `ReglesDeTypage.lean`, l. 642-645, 657; `AxiomatiqueGerminale.lean`, l. 317-321 | C-01, C-03, C-06; INS § 1 (D-φ2) |
| P-02 | `Λα.c` and copattern in the terminal forms of `thm:progres` | `SemantiqueOperationnelle.lean`, l. 209-210 | C-07; INS § 4 (D-P1) |
| P-03 | subtyping of sizes `νC⟨j⟩ <: νC⟨i⟩` | `ReglesDeTypage.lean`, l. 237-239 | C-06, C-07 |
| P-04 | grammar of the temporal forms (`next`, `loc_n`, `Nxt`, `Loc`, `Declassify`, six schemes) | `GrammaireDesTermes.lean`, l. 33; `GrammaireDesTypes.lean`, l. 42-44 | C-04, C-07, G2; INS § 3 (D-T1) |
| P-05 | `declassify`: premise `fv(v) = ∅` against `e ∈ 𝒳`; level of the box | `AdjonctionsEtEnrichissement.lean`, l. 224 | C-07, C8 |
| P-06 | restrict « Couche 2 — tous les cas » ("Layer 2 — all cases") to the translated cases | `LeSystemeDeSortesDuMetalangage.lean`, l. 247 | C-07; INS § 5 (D-S3) |
| P-07 | `Guard` with several messages against `thm:sync_motifs_jonction` | `ReglesDeTypage.lean`, l. 1407; `EchelleDuSysteme.lean`, l. 486 | C-07, C-08; INS § 4 (D-P2) |
| P-08 | failure of `try` | `SemantiqueOperationnelle.lean`, l. 42-103 | C-07 |
| P-09 | missing schemes: `fix`, `out`, layer-2 globals, contexts | `SemantiqueOperationnelle.lean`, l. 42, 82 | C-07; INS § 4 (P3) |
| P-10 | time thread: kind `maillon`, translation per level, `thm:chaine_fils` | `LeSystemeDeSortesDuMetalangage.lean` (`tab:capacites`) | C-07 |
| P-11 | `E_repro` and `Π`: "three" against four components, per-actor scope | `EchelleDuSysteme.lean`, l. 113-116, 175, 189 | C-08, G1 |
| P-12 | SPSC topology per pair and join queue (IMPL-04) | `EchelleDuSysteme.lean`, l. 507-508 | I, C-08 |
| P-13 | direction of the invalidation at the destructor (BIB-17) | `EchelleDuSysteme.lean`, l. 565-567 | C-08, G1 |
| P-14 | singularities `∘` and `δ`, propagation tables, `1/0` | `LesContraintesDeValeur.lean`, l. 352, 366-368, 403 | D, blocked; INS § 6 |
| P-15 | phases numbered from 0 to 10 (STRUCT-06) | `LeProcessusDeCompilation.lean`, l. 34, 47-49 | G1 |
| P-16 | preservation order of § 6.1 and `tab:invariants-de-passe` | `LeProcessusDeCompilation.lean`, § 6.1 | C8, G1 |
| P-17 | reading guide: TRANS-08, STRUCT-15 | after `GuideDeLecture.lean`, l. 35-36 | G1 (editorial) |
| P-18 | "no single framework" for the notions of monotonicity (FACT-14) | `AdjonctionsEtEnrichissement.lean`, l. 385 | G1 |
| P-19 | non-monotonicity in `ℓ` of the logical relation (FACT-07) | `SemantiqueOperationnelle.lean`, § logical relation | C8; INS § 2 (D-ℓ) |
| P-20 | « sont démontrés » ("are proved"), « exactement la seconde » ("exactly the second"); `declassify` exception | `SemantiqueOperationnelle.lean`, l. 27-28; `StructuresOuvertesEffetsEtMetaTheorie.lean`, l. 311-318 | editorial corrections |
| P-22 | ANOM-17 routes (in the archive's sense): `slice`, `∥`/`vmap`, accounting of `spawn` | `ReglesDeTypage.lean`, l. 1228, 1289, 1393 | C-08, E, F |

PREUVE-08 (truncation) calls for no proposal: the text is already in `main`; only its ratification is in question (DEC).

## 7. Decisions attributed to the author

Handled in [`DECISIONS.md`](../tracking/DECISIONS.md). This lot does not take them up and does not hold them as taken.

## 8. Checks

Run for the PR that introduces this lot: `scripts/controle.py`, `scripts/ci/check_documentation_architecture.py`, `scripts/suivi.py check` then `all`, `pytest tests/python`, `statement_inventory`. Lychee runs in CI. None of these checks validates the scientific content.

Run for the deposits of § 4 and the English translation of this lot and of INS (2026-10-14): the same checks, plus `reuse lint` and a local check that every relative link of the deposited files resolves; all pass. Lychee was not run locally.

## 9. Exit criterion

The lot moves to UNDER REVIEW when: each piece has a fate (done); V-02 to V-07 are deposited or set aside; each obligation is attached to a C register or to a stage; each proposal has received a mandate, a refusal, or remains explicitly open in `DECISIONS.md`; the checks pass. It moves to VALIDATED only after the author's rereading.

**State on 2026-10-14, after the deposits of § 4: the lot remains IN PROGRESS.**

- Each piece has a fate: met (§ 3).
- V-02 to V-07: V-02, V-03, V-05, V-06 and V-07 are deposited (§ 4) by a change awaiting review and merge; V-05 remains subject to the pending decision of DEC l. 70, item 3; the identifier V-04 is not used. Met once that change is merged.
- Obligations: every row of § 5 names an object or a stage, except O-24, attached to "checks" only; whether each obligation is carried in the corresponding C register has not been checked. Open.
- Proposals: none has received a mandate or a refusal; DEC l. 70, item 4, lists "mandate or refusal for each normative proposal P-01 to P-22" as awaiting the author's decision, as one collective entry, without one entry per proposal. Open.
- Checks: they pass for the change that makes the deposits (§ 8); lychee runs only in CI.
- VALIDATED: requires the author's rereading, not done (HUMAN ACTION REQUIRED).
