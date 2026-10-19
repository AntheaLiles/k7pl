<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# T-68: the primitive vocabulary proposal and its analysis against the manuscript (PR #10 archive extracts)

> **Status: non-normative archived research material.** These extracts come from PR #10 (archive commit `d39d012`), which was closed without merge. They have not been reviewed or ratified by the author. This is an English translation made on 2026-10-14; the original French text and its exact provenance are recorded in the [PR #10 archive recovery lot](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 4 (deposit V-05). In case of discrepancy, the original prevails. The current normative source is `spec/`; nothing below describes `main` unless an editorial note says so. No word of the manuscript has been renamed.

> **Editorial note (2026-10-14): what is extracted, and why.** This document gathers extracts of two archive documents, both dated 6 October 2026 (session 32 of the archive):
>
> - **source B**, the proposal "T-68 — le vocabulaire des primitives, en un seul bloc" (185 lines). Kept: § 2 (registers), § 3 (form rules), § 6 (collisions), § 9 (arbitrated points and alternatives), and the table of § 4 as an annex on the archive base `d39d012`. Not kept: § 1 and § 10, which present the "en bloc" (all-at-once) ratification as decided; § 5 (completeness counts, superseded); § 7 (morphological consistency); § 8 (cross-references to archive files);
> - **source A**, the analysis note "T-68 : ratifier le vocabulaire des primitives, face au manuscrit" (372 lines). Kept: § 4 (collisions), § 6 (PDF and HTML rendering), § 10 (most debatable rows), § 11 (corrections to the proposal). Not kept: § 0 to § 3 (including the dry run and the trial application in a copy, whose counts do not hold on `main`), § 5, § 7, § 8 and § 9 (the "en bloc" ratification plan and its decision blocks), § 12.
>
> The "en bloc" method is the archive's attribution to the author. On `main`, `docs/tracking/DECISIONS.md` records only the place of `T-68` in the finishing order (l. 24), lists the method as an open decision whose option (a) is "en bloc (archive PR #10)" (l. 66), lists "deposit the T-68 extract now or at stage G2" as a pending decision (l. 70, item 3), and states that none of the decisions the archive attributes to the author is decided in `main` (l. 123). The words "retained by the author" (_retenu_) below are the archive's statements; they have not been checked against a record on `main`.
>
> Section numbers in the extracts are those of the original documents (A § n, B § n); references to sections that are not extracted point to the originals, available through the lot. "The CSV", "the renaming table", `t68_renommer.py` and `vocabulaire.py` are archive files that are not on `main` (set aside by the lot, § 3.4). Square brackets `[…]` in the translated text mark editorial replacements of archive paths or links. N names (register N) are French by design and are kept verbatim, as are K words, formulas, labels and rule names.

> **Editorial note (2026-10-14): the base of the extracts differs from `main`.** Checked on `main` at `7af5581`:
>
> - the grammar of terms on `main` (`spec/Spec/C3/GrammaireDesTermes.lean`, l. 27-37) has no `next` and no `loc_n`; its values line (l. 27) does not contain `always v`, `now v`, `next v`, `loc_n v`, which the archive's values line contains; on `main`, `always` and `now` are computations (l. 33); `declassify` is written `\mathbf{declassify}_{\ell}` (l. 31);
> - `scripts/controles/croise.py` on `main` lists 46 rules in `EXPECTED` (from l. 21), without `Nxt`, `Loc` or `Declassify`; `docs/tracking/primitives.md`, l. 3, counts 45 `DOING` entries; the cardinal of the kernel is under audit ([`L1-T68-AUDIT.md`](../migration/L1-T68-AUDIT.md), l. 14-18). The archive's counts (49 rows, 50 constructor rules, 53 rules of the cross-check) are therefore not those of `main`;
> - occurrences of the K words under `spec/Spec/` on `main`, as `\mathsf{…}`: `inj` 6, `iter` 5, `vmap` 3, `open` 3, `at` (□, not followed by `_`) 3, `at_n` 2, `loc` 0, `next` 0. The archive's figures (for example 8 for `at`, 7 for `at_n`, 8 for `loc`, 6 for `vmap`) were counted on `d39d012`.

## Part 1 — The proposal (source B)

### B § 2. The three registers, and what a "word" is

| Register | What it names | Language | Where it is read |
|---|---|---|---|
| **K** | the _kernel constructor_: what the grammar of terms writes (`\mathsf{…}`) | English, one whole word, lower case | grammars, rules, operational semantics |
| **N** | the _name_ of the primitive in prose, in the glossary and in the index | French, a noun | chapters, glossary |
| **S** | the _surface word_ that the program writes (chapter 5) | English | syntax of chapter 5; **unchanged** by `T-68` |

The "word" of the table of 6 October becomes the **name N**. Register K changes only where a form rule requires it (§3), and register S is not touched: `perform`, `handle`, `match`, `cond`, `select`, `pure`, `terminates` remain what they are, and `operation` and `scoped` remain the K names of what `perform` and `handle` write on the surface.

### B § 3. The form rules

**For K.**

* **R-K1** — a _whole_ English word, no truncation: `inject`, `iterate`, `vectormap`, `placed`; the established one-word mathematical names (`fix`, `out`, `fold`, `unfold`, `box`, `try`) qualify, being whole words.
* **R-K2** — the introduction and the elimination of the same form carry symmetric words: `pack`/`unpack`, `box`/`unbox`, `fold`/`unfold`.
* **R-K3** — a K word denotes _one_ form: `at` now denotes only execution at a place, `at_n`; reading a permanent value is called `current`.
* **R-K4** — temporal introductions are adverbs (`always`, `now`, `next`), their eliminations verbs or a conjunction (`current`, `wait`, `when`); `delay` is the verb of the delayed computation.

**For N.**

* **R-N1** — a French noun, in the singular, without article; a complement is added only to remove a collision (« décomposition de paire », « élimination de l'unité », « opération à portée »).
* **R-N2** — four English borrowings only, those that the author _retained_: `thunk`, `force`, `return`, `pack`; `unpack`, their symmetric, is a fifth by R-K2.
* **R-N3** — a word retained by the author is kept as is; the table indicates it (column "Origin").
* **R-N4** — two primitives never carry the same N name nor the same K word; an N name that also denotes another object of the manuscript is flagged in §4.

### B § 6. Collisions

Checked against the reserved words of K7PL (`pure`, `terminates`, `event`, `contract`, `logic`, `perform`, `handle`, `handler`, `match`, `cond`, `select`, `comptime`, `binds`, `bind-to`, `var`, `end`) and against the words of the manuscript.

| Word | Collision | Verdict |
|---|---|---|
| K `unpack` | none; the manuscript already uses « `unpack` explicite » (§3.3, annex A, §6.1) | **resolves** a collision: `open` is taken by the files |
| K `current` | none; `extract` would have clashed with the « fonction d'extraction » ("extraction function") of §3.2 (proof extraction) | set aside in favour of `current` |
| K `placed` | none | — |
| K `inject`, `iterate`, `vectormap` | none; `inject` agrees with `injection` (N) | — |
| N « projection » | the observational projection π_ℓ (ch. 2, ch. 4) | **accepted**: two objects, the context decides, the glossary distinguishes them |
| N « généralisation » | the generalisation of unification variables (§6.1, Phase 4) | **accepted**, same reason |
| N « abstraction » | the data abstraction of non-interference (ch. 2) | **accepted**; the doctrine of 31 August already uses this word for `Lam` |
| N « observation » | observational equivalence | **accepted**: it is the same idea (what can be distinguished by `out`) |
| N « liaison séquentielle » | the sequencing of effects | **intended**: `let` implements sequencing; the word is that of the doctrine of 31 August |
| N « décomposition de paire » | the module × order decomposition of the grade | **removed** by the complement « de paire » |
| N « libération » | the release of layer-1 resources | **intended**: same idea |
| N « délai » | « après un délai » ("after a delay") (temporal modalities) | **intended** |

> **Editorial note (2026-10-14).** On `main`, the sections cited here hold the passages described: « `unpack` explicite » in § 3.3 (`spec/Spec/C3/StructuresOuvertesEffetsEtMetaTheorie.lean`, l. 76), annex A (`spec/Spec/AnnexeA/DistinctionDePhaseEtMetaprogrammation.lean`, l. 38) and § 6.1 (`spec/Spec/C6/LeProcessusDeCompilation.lean`, l. 98); the extraction function in § 3.2 (`spec/Spec/C3/LesContraintesDeValeur.lean`, l. 60). "Phase 4" is the archive's numbering of the phases: on `main`, the resolution of unification variables is the intercalary checkpoint 2.5 (`spec/Spec/C5/LeTheoremeDElaboration.lean`, l. 28), and the numbering of the phases is an open decision (`docs/tracking/DECISIONS.md`, l. 65).

### B § 9. Points on which the proposal arbitrates, and its alternatives

To be ratified with the block, or to be amended one by one without undoing the rest (the rules of §3 say what must remain true).

| Point | Proposed | Alternative | Why the proposed |
|---|---|---|---|
| reading a permanent value | `current` | `extract` (the name of the counit); `sample` | `extract` clashes with « extraction »; `sample` evokes sampling |
| introduction of `@ₙV` | `placed_n` | `here_n`; `loc_n` | R-K1 rules out `loc`; `here` denotes a current place that the configuration does not have |
| truncated words | `inject`, `iterate`, `vectormap` | keep `inj`, `iter`, `vmap` (usage of the literature) | R-K1: the grammar has no other truncated word; the renaming is mechanical |
| language of the N name | French, five borrowings | English everywhere | the manuscript and the glossary are in French; the doctrine of 31 August already named in French |
| `slice` | kept | `partition` | word of the code `ERR-SLC` and of the rule; `partition` clashes with the partition `ρ = ρ₁ ⊎ ρ₂` that it requires |
| `Sc`, `Op` | K unchanged | `handle`, `perform` as K | passage of ch. 3: the kernel names what the thing _is_ |
| N names of the CBPV kernel and of the existential | `thunk`, `force`, `return`, `pack`, `unpack` (retained borrowings) | `suspension`, `forçage`, `retour`, `empaquetage`, `ouverture` (doctrine of 31 August, descriptive) | the author retained the four borrowings in the card; the French names of the doctrine denoted families |
| N of `Sc` | « opération à portée » | « gestionnaire » (doctrine) | « gestionnaire » names a _value_ (ch. 3), not the form `scoped` |
| N of `Box`, `Unbox` | « promotion », « restitution » | « entrée sous la modalité », « sortie » (doctrine) | simple names; « promotion » is already used |

> **Editorial note (2026-10-14).** On `main`, the passage of chapter 3 invoked here is `spec/Spec/C3/GrammaireDesTermes.lean`, l. 64-73; `ERR-SLC-001` is in `spec/Spec/AnnexeA/ContraintesDeValeurEtPreuvesResiduelles.lean`, l. 43.

## Part 2 — The analysis against the manuscript (source A)

### A § 4. Collisions

#### A § 4.1 The six K words

| Word | Lean | Verso | LaTeX | Words of K7PL | In `spec/` | Verdict |
|---|---|---|---|---|---|---|
| `inject` | not reserved | not applicable (inside a formula) | `\mathsf{inject}`: no command | not reserved (list of `vocabulaire.py` and §6 of the proposal) | 0 uses, apart from « injecté » (3 uses of the common verb) | none |
| `iterate` | not reserved | same | none | not reserved | 0 uses; the French « itération » (chapters 2 and 6) denotes something else, see §5.2 | none |
| `vectormap` | not reserved | same | none | not reserved | 0 | none |
| `unpack` | not reserved | same | none | not reserved | 5 uses in prose with the intended meaning | **removes** a collision: `open` is a Lean keyword (`open Verso.Genre Manual` at the head of every file of `spec/`), and a word of the manuscript (« ouvrir », "to open") for something else |
| `current` | not reserved | same | none | not reserved | 0 uses in `spec/` (the uses in `tools/` and `scripts/` are code English) | none; `extract` would have clashed with « extraction » (five occurrences of « extract » or « extraction » in five files; I have not reread which ones are proof extraction) |
| `placed` | not reserved | same | none | not reserved | 0 uses (the French participle « placé » appears once, unrelated) | none |

Note: `at` and `open` **are** Lean tokens (`simp at h`, `open Foo`). They are not read by Lean here, since they are inside formula strings, but they would be if one day the kernel were written in a Lean file; this is one more weak argument for `unpack`, none for `current` (which could have stayed `at`).

The K words are not words of the (French) language; their reading in English is unambiguous. **Case sensitivity and ligatures**: `\mathsf` in math mode applies no ligature (`unicode-math`), so that `inject`, `iterate`, `vectormap` contain no faulty ligature.

> **Editorial note (2026-10-14): the counts of this table, on `main` at `7af5581`, under `spec/Spec/`.** `inject`: 0; forms of « injecté »: 3 (unchanged). `unpack` in prose: 5 uses in 3 files (unchanged; `C3/StructuresOuvertesEffetsEtMetaTheorie.lean`, l. 76, 77, 81; `AnnexeA/DistinctionDePhaseEtMetaprogrammation.lean`, l. 38; `C6/LeProcessusDeCompilation.lean`, l. 98). `open Verso.Genre Manual`: 63 of the 64 `.lean` files; the exception is `spec/Spec/C3/EffectiveKernel.lean`, added after the archive. `current`: one occurrence, in an English docstring of `spec/Spec/C3/EffectiveKernel.lean`, l. 171. `placed`: 0; « placé » as a whole word: 3 (`C2/SixSchemasDeMetatheorie.lean`, l. 117; `C4/EchelleDuSysteme.lean`, l. 543; `C6/CeQueLeSolveurRetourne.lean`, l. 277). Words beginning with « extract »: 11 in 7 files, 3 of them in `spec/Spec/ProofVisualizations.lean` and 3 in `spec/Spec/CodeArtifacts.lean`, both added after the archive. `vocabulaire.py` is not on `main`.

#### A § 4.2 The N names

The proposal in block (§6) identifies nine collisions. Two more appear on reading the current **glossary** (`spec/Spec/Refs/ListeDesGlosses.lean`, 99 entries):

| N name | Collision | Proposed verdict |
|---|---|---|
| « localisation » (`At`) | the glossary already defines « localisation » as the **element of the semilattice** where a value resides, carried by a graded modality (« Élément du demi-treillis où réside une valeur… »). The proposal gives this same word to the **primitive** `at_n`. Two objects, one word: this is exactly what rule R-N4 forbids, and the table of the proposal does not flag it (it says "same word as the modality that types it", which is the same idea seen from another side) | to be **flagged** in §6 of the proposal; or name the primitive « exécution en un lieu »; the glossary entry stays as is |
| « déclassification » (`Declassify`) | the glossary defines it as the **named authorisation** to make a datum go down a level. The primitive `declassify_ℓ(v)` is the act | same remark, weaker: the word is used 22 times in the broad sense; to be noted |

And a **proximity**: « lecture instantanée » (`Alw^{-}`) against the glossary entry « instantané » (« État d'un acteur figé et persisté à un instant donné »). No recognition collision (recognition is done on word boundaries, and « instantanée » is not « instantané » + plural mark), but two neighbouring uses of « instant » in two senses.

> **Editorial note (2026-10-14).** On `main`, the glossary still has 99 entries; the entries cited are at `spec/Spec/Refs/ListeDesGlosses.lean`, l. 304 (« localisation »), l. 165 (« déclassification ») and l. 290 (« instantané »), with the wording quoted. Words beginning with « déclassification » (case-insensitive) occur 17 times under `spec/Spec/`, the glossary entry included, against 22 in the archive.

#### A § 4.3 Inverse collisions (one word for two primitives)

Checked by `vocabulaire.py` and recounted: no K word or N name is shared between two rows; `at` denotes only one form after renaming.

### A § 6. PDF and HTML rendering

#### A § 6.1 Width of the formulas

Measurement (`lualatex`, `amsmath`, `unicode-math`, class `report` 10 pt: `\textwidth` = 345 pt; **the real document is not this document**: the measurement compares before and after, it does not say what the width of the repository's PDF is) of the `align*` lines of the grammar of terms:

| Line of the grammar (numbered in the order of the `align*` block) | Renamed words | Before | After | Difference |
|---|---|--:|--:|--:|
| 1. values (a single line) | `inject`, `placed_n` | 517 pt | 544 pt | +27 pt (+5 %) |
| 2. computations, first line | none | 344 pt | 344 pt | 0 |
| 4. `unbox … unpack … unfold` | `unpack` | 223 pt | 232 pt | +10 pt |
| 5. `Λα … iterate_V` | `iterate` | 213 pt | 226 pt | +13 pt |
| 7. `delay … current … wait … when` | `current` | 179 pt | 201 pt | +21 pt |
| 9. `∥ … vectormap` | `vectormap` | 84 pt | 105 pt | +21 pt |
| 11. `spawn … slice` | none | 360 pt | 360 pt | 0 |
| 3, 6, 8, 10, 12 | none | 101 to 210 pt | unchanged | 0 |

What to retain: **the "values" line is already much wider than the page** (517 pt for a 345 pt line in this substitute document; the `spawn … slice` line too: 360 pt, and the first line of the computations is at 344 pt) and the renaming widens the first by 5 %. It is therefore already a line-break case to be settled (a `\\` after half of the alternatives), independently of `T-68`; the renaming creates no new one in this measurement (none of the other lines crosses 345 pt after renaming). The `\frac` typing rules were not measured (character count only: the `Vmap` rule gains 5 rendered characters, `Open` 2, on rules that are already long); they are to be looked at on the PDF. **Check at renaming time**: compile the PDF and compare the "Overfull \hbox" of the LaTeX log before and after.

HTML: the formulas are typeset by Verso's mathematics engine; `\mathsf{…}` is standard, no engine differs on it. Wide lines scroll rather than overflow. No effect other than length.

> **Editorial note (2026-10-14).** The measured "values" line is that of the archive (`spec/Spec/C3/GrammaireDesTermes.lean`, l. 27, at `d39d012`), which ends with `\mathsf{always}\;v \mid \mathsf{now}\;v \mid \mathsf{next}\;v \mid \mathsf{loc}_n\,v`; on `main`, the same line stops at `[v_0,\ldots,v_{n-1}]`, and the block has 11 lines instead of 12. The figures were measured on a substitute document, not on the repository's PDF; they are not reproduced here. The lot records this as obligation O-25, which needs a measurement on the real PDF (human action).

#### A § 6.2 Glossary and automatic recognition

The pass `tools/SpecExt/AutoMark.lean` recognises in the text of paragraphs (never in code or formulas) each glossary term, **on word boundaries, ignoring case and accents, with an optional plural mark**, and places a **glossary bubble at the first occurrence in each chapter**. If the 44 missing names are added (the renaming table provides for this step):

* they have **733 occurrences in prose** in `spec/`;
* they would produce up to **121 bubbles** (one per chapter and per word; an upper bound, because the longer terms — « opération à portée », « application vectorisée » — mask their beginning), against 99 entries today for the whole manuscript;
* most of them on **ordinary words**: « opération » (185 uses in 7 chapters), « projection » (67; 7 chapters), « point fixe » (62; 6), « variable » (61; 7), « application » (50; 6), « unité » (47; 8), « paire » (26), « émission » (26), « attente » (24; 2 chapters), « abstraction » (23), « présence » (15; 7), « filtrage » (17; 7), « force » (11; the noun or the common verb). A bubble "Variable: …" on every first « variable » of each chapter does not help the reader, and a bubble "Force: …" on « la force de » ("the strength of") misleads them;
* the current glossary, for its part, contains only specialist terms (« abaissement », « anamorphisme », « sédimentation »…), no everyday word.

Three options for the author's decision (§9, D5):

| Option | What it adds | Noise | Consistency with the need for completeness |
|---|---|---|---|
| **(a) the 44** | the 44 entries | up to 121 bubbles, about a hundred of them on common words | maximal completeness; reading cost |
| **(b) the phrases and the borrowings** | the 14 phrases (« liaison séquentielle », « décomposition de paire », « élimination de l'unité », « conjonction additive », « lecture instantanée », « pas suivant », « pli indexé gradué », « mise en parallèle », « application vectorisée », « création de boîte », « réception gardée », « marque de lieu », « opération à portée » already present, « point fixe ») and the borrowings `thunk`, `pack`, `unpack` (not `force`, `return`) | a few dozen bubbles, on rare expressions | the complete table remains in the proposal; the glossary keeps its nature |
| **(c) none for now, a table of primitives** | a table (chapter 3, §3.5) "rule; K word; N name" of 49 rows, outside automatic recognition | none | completeness is in chapter 3, not scattered; contradicts however the sentence of chapter 3 « aucune table de correspondance n'est due au lecteur » ("no correspondence table is owed to the reader") **for `operation`/`perform`** (another object: that sentence concerns K and S, the proposed table concerns K and N) |

It is not my role to choose: (a) answers "completeness" most literally, (b) avoids the noise, (c) moves completeness.

The printed index is not concerned (31 terms, none renamed).

> **Editorial note (2026-10-14).** On `main`, the recognition rules described here are stated in `tools/SpecExt/AutoMark.lean`, l. 19-22, and `tools/SpecExt/IndexCore.lean`, l. 12-13; the printed index has 31 terms (`tools/SpecExt/IndexTerms.lean`, l. 21-27); the sentence of chapter 3 is at `spec/Spec/C3/GrammaireDesTermes.lean`, l. 69. The occurrence counts (733 uses, 121 bubbles, and the per-word figures) were computed on `d39d012` and have not been re-measured on `main`. The lot records the noise of the glossary bubbles as obligation O-26.

### A § 10. The most debatable rows, with alternatives

Ranked from the most to the least debatable.

| Rank | Row | Why debatable | Alternatives | Effect of the alternative on the renaming |
|--:|---|---|---|---|
| 1 | `Vmap` → `vectormap` | the proposal posits "a whole English word" (R-K1), and `vectormap` is a weld; the established name (`vmap`) is the same as that of the literature | (i) keep `vmap` and add it to the exceptions of R-K1 (established one-word names like `fix`); (ii) `vecmap` (still truncated); (iii) `parmap` (says parallelism, but `Par` has its own word); (iv) `map` (the simplest whole word; possible conflict with a future surface word) | remove 3 rows of the CSV (6 occurrences) and 1 of `croise.py` for (i); change the replacement for the others |
| 2 | N of `Op`: « opération » | genus and species conflated (§5.1); 185 uses in prose | « opération algébrique » (paired with « opération à portée » and with `ℰ_alg`/`ℰ_scoped`, `ARB-PR-03`); « opération d'effet » (formula of chapter 3) | none on K; the N row of the table and its check (`vocabulaire.py` does not tolerate two identical N) |
| 3 | `Alw^{-}`: `at` → `current` | close to `now` in meaning; neither verb nor conjunction (R-K4); outside the criterion of chapter 3 | (i) `extract` (name of the counit; set aside because of « extraction »: to be checked on the five uses); (ii) `sample` (evokes sampling); (iii) a verb, for example `sustain` (leads, not investigated); (iv) keep `at` for □ and rename `at_n` (for example `execat_n`, a mere illustration) | for (i)–(iii): change `current` in the row of the CSV (8 occurrences) and the pattern of `croise.py`; for (iv): 7 occurrences of `at_n` to rename, the `At` row of the table, `croise.py` |
| 4 | `Loc` → `placed` | `here_n` or `loc_n` set aside; `located_n` is also a participle | `located`; `site`; `loc` kept (R-K1 set aside for a single abbreviation: `loc` also denotes `\mathrm{loc}(\Delta)`) | 8 occurrences; the row of the CSV |
| 5 | `iter` → `iterate` | suggests an unbounded loop; `iterate_V v c` is bounded by the vector | `foreach`, `each`, `traverse` (more exact, but « traverse » belongs to another vocabulary) | 5 occurrences; one row |
| 6 | N of `At`: « localisation » | collision with the glossary entry (§4.2) | « exécution localisée »; « exécution en un lieu » | none on K |
| 7 | N of `Now`: « présence »; of `Alw^{-}`: « lecture instantanée » | common words (15 uses; proximity with « instantané » of the glossary) | for `Now`: « actualité » (little used), « instant courant »; for `Alw^{-}`: « lecture de l'instant » | none on K |
| 8 | rule R-K1 itself (for `inj`, `iter`, `vmap`) | three renamings "of form": if the author prefers the usage of the literature to the rule, they keep these three words; `unpack` goes through alone, because `open` remains taken by the files | keep `inj`, `iter`, `vmap`; chapter 3 (« deux abréviations de longueurs différentes n'en sont pas [de même forme] », "two abbreviations of different lengths are not [of the same form]") pleads for R-K1 | remove from the CSV the three rows of each word (9 rows) and the corresponding row of `croise.py`; 17 occurrences remain unchanged |

In the order of what I would have the author look at first: ranks 1 to 3. The others are preferences.

**Links with the design files** (see [the archive's design index, `00-index-design.md`]). Rank 1 (`vmap`) depends on [design file 1, `01-parallele-et-vmap.md`]: if the form of `∥` and `vmap` is repaired (restriction to pure parallelism, recommended by that file), the word is to be taken up again with it; it is better to decide that file before freezing `vectormap`. Ranks 3 and 4 touch the forms that [design file 6, `06-formes-temporelles-declassify-at-move.md`] deals with (`at`, `loc_n`, `move`, `declassify`): that file deals with the **forms** and their rules, not with the words; the two do not contradict each other, but if file 6 modifies the `Alw^{-}` or `Loc` rule, the renaming will apply to the rules then written (the script rewrites patterns, not rules).

> **Editorial note (2026-10-14).** The three design notes linked in the original are archive notes that are not deposited in `main`; the lot cites each by permalink and records what is kept from them (§ 3.2). The occurrence figures of this table were counted on `d39d012`; for `main`, see the second editorial note at the head of this document (for example 2 occurrences of `\mathsf{at}_n`, not 7, and none of `\mathsf{loc}`). `ℰ_alg` and `ℰ_scoped` are named on `main` in `spec/Spec/C3/ReglesDeTypage.lean`, l. 587-589; `\mathrm{loc}(\Delta)` is in the `At` rule, l. 1490.

### A § 11. Corrections to make to the proposal, unrelated to the choice

These corrections do not depend on the decision; they are not applied here (the proposal is a session document, which the author ratifies).

1. **Renaming table, §2**: `unpack` in prose counts 5 uses in 3 files (`C3/StructuresOuvertesEffetsEtMetaTheorie` ×3, `AnnexeA/DistinctionDePhaseEtMetaprogrammation` ×1, `C6/LeProcessusDeCompilation` ×1) and not 3 in 2 files.
2. **Renaming table and `t68_renommer.py`**: they announce that [the archive's register of primitives, `primitives.md`] follows the renaming; the CSV has no row for this file (§2.3).
3. **Proposal, §7**: `next`/`wait` is not an introduction/elimination pair (§5.3).
4. **Proposal, §6**: add « localisation » and « déclassification » to the collisions of N names (§4.2).
5. **The CSV** would gain a `LITERAL:` row for the prose `open` (§2.3), so that the trial counts 43 and nothing remains to be done by hand.

Checked and **exact** in the proposal: the 49 rows, the 35 one-word N names and 14 phrases, the count of K words (28 unchanged K words plus `move_{n→m}`, 14 symbolic forms without a word, 6 words that change), the 50 constructor rules and the 53 rules of the cross-check.

> **Editorial note (2026-10-14).** Item 2: the archive's register of primitives corresponds to `docs/tracking/primitives.md` on `main`, which differs from the archive version (45 `DOING` entries, l. 3). Item 5: on `main`, the prose `open` is at `spec/Spec/C4/CalculDeProcessusSousJacent.lean`, l. 315 (« `unbox` sur `box`, `open` sur `pack` »). Last paragraph: the counts were "exact" on `d39d012`; on `main`, `croise.py` has 46 rules in `EXPECTED` (see the second editorial note at the head of this document).

## Annex — The table of the proposal (source B, § 4; base `d39d012`)

> **Editorial note (2026-10-14).** This table describes the archive state `d39d012`, not `main`: the rows `Nxt` (`next`) and `Loc` (`loc_n`) have no counterpart in the grammar of `main`, and the rows `Nxt`, `Loc` and `Declassify` have no counterpart in `EXPECTED` of `scripts/controles/croise.py` on `main` (see the second editorial note at the head of this document). The "6 Oct." column refers to the archive's version of the register of primitives (46 rows). "Phase 1" for macro expansion, in the second table, is the archive's numbering; `main` calls it Phase 0 (`spec/Spec/C3/GrammaireDesTermes.lean`, l. 62). K words and N names are kept verbatim; the other cells are translated.

Columns: the typing rule; the family of the review; the current and proposed K constructor; the proposed N name; the state of the proposal of 6 October (word, state); the origin of the word; the reason.
"**Origin**": _retained_ = word retained by the author in the card; _arc G_ = naming doctrine of 31 August; _proposed_ = proposal of the review; _usage_ = established usage of the manuscript; _session 32_ = new primitive or word.

| Rule | Family | Current K | Proposed K | Proposed N | 6 Oct.: word (state) | Origin | Reason |
|---|---|---|---|---|---|---|---|
| `Var` | kernel | `x` | `x` | variable | variable (retained) | retained | universal |
| `Lam` | kernel | `λx.c` | `λx.c` | abstraction | lambda (proposed) | arc G | established French calque; the English word "lambda" remains a code word, not the name of the rule |
| `App` | kernel | `c v` | `c v` | application | application (proposed) | proposed | exact term, also covers composition; never written |
| `Th` | kernel | `thunk` | `thunk` | thunk | thunk (retained) | retained | retained borrowing (Levy): the first of the four kept borrowings |
| `Fo` | kernel | `force` | `force` | force | force (retained) | retained | retained borrowing (Levy): the second |
| `Ret` | kernel | `return` | `return` | return | return (retained) | retained | retained borrowing (Levy): the third |
| `Let` | kernel | `let x ← c in c` | `let x ← c in c` | liaison séquentielle | let (proposed) | arc G | the word of the doctrine of 31 August; sequencing is the name of the composition of effects, which `let` implements |
| `One` | connectives | `()` | `()` | unité | unit (proposed) | arc G | name of the unit type |
| `OneE` | connectives | `let () = v in c` | `let () = v in c` | élimination de l'unité | (no word) (to be arbitrated) | session 32 | no word of its own: the rule has only its form |
| `Pair` | connectives | `(v, v)` | `(v, v)` | paire | pair (proposed) | arc G | usual; does not say the disjointness of resources (P1), which a remark says |
| `Split` | connectives | `let (x,y) = v in c` | `let (x,y) = v in c` | décomposition de paire | split (proposed) | arc G | the complement « de paire » avoids the collision with the module × order decomposition of the grade |
| `Inj` | connectives | `inj_i` | `inject_i` **→** | injection | inject (proposed) | arc G | R-K1: no truncated word |
| `Case` | connectives | `case` | `case` | filtrage | case (proposed) | arc G | `match` remains reserved for text matching |
| `With` | connectives | `⟨c_i⟩` | `⟨c_i⟩` | conjonction additive | with (proposed) | usage | the name of the form throughout the manuscript |
| `Proj` | connectives | `c.i` | `c.i` | projection | project (proposed) | arc G | collision with the observational projection π_ℓ: same word, two objects, flagged |
| `Pack` | existential | `pack` | `pack` | pack | pack (retained) | retained | retained borrowing: the fourth |
| `Open` | existential | `open` | `unpack` **→** | unpack | unpack (proposed) | proposed | R-K2: symmetric of `pack`; `open` is taken by the files; the text already writes « unpack explicite » |
| `Box` | grading | `box_r` | `box_r` | promotion | box (proposed) | usage | the word of linear logic, already used (ch. 3, ch. 4) |
| `Unbox` | grading | `unbox` | `unbox` | restitution | unbox (proposed) | session 32 | says what the rule gives back: the grade |
| `Sc` | effects | `scoped_f` | `scoped_f` | opération à portée | handle (proposed) | usage | the kernel names what the thing is; the surface word is `handle` |
| `Op` | effects | `operation_ε` | `operation_ε` | opération | perform (proposed) | usage | the kernel names what the thing is; the surface word is `perform` |
| `Fold` | fixed points | `fold` | `fold` | repliage | repliage (retained) | retained | Malcolm; no competitor |
| `Unfold` | fixed points | `unfold` | `unfold` | dépliage | dépliage (retained) | retained | exact inverse of the previous one |
| `Out` | fixed points | `out` | `out` | observation | observation (retained) | retained | structure of the terminal coalgebra |
| `Cop` | fixed points | `⟨⟨j ↦ c_j⟩⟩` | `⟨⟨j ↦ c_j⟩⟩` | copatron | copatron (retained) | retained | Abel and Pientka, the only one in use |
| `Gen` | connectives | `Λα. c` | `Λα. c` | généralisation | généralisation (proposed) | proposed | collision with the generalisation of unification variables (§6.1), flagged |
| `Inst` | connectives | `c [W]` | `c [W]` | instanciation | instanciation (proposed) | proposed | Damas and Milner |
| `Del` | temporal | `delay` | `delay` | délai | différer (to be arbitrated) | session 32 | the text writes « après un délai »; introduction of ○C |
| `Alw` | temporal | `always` | `always` | permanence | toujours (to be arbitrated) | session 32 | introduction of □V: adverb |
| `Alw^{-}` | temporal | `at` | `current` **→** | lecture instantanée | à (to be arbitrated) | session 32 | R-K3: `at` denoted two forms (□ and @); the current value of a permanent value |
| `Now` | temporal | `now` | `now` | présence | maintenant (to be arbitrated) | session 32 | introduction of ◇V: adverb |
| `Nxt` | temporal | `next` | `next` | pas suivant | suivant (to be arbitrated) | session 32 | introduction of ○V: adverb; added with the correction of the grammars |
| `Wait` | temporal | `wait` | `wait` | attente | attendre (to be arbitrated) | session 32 | elimination of ○◇V: verb |
| `When` | temporal | `when` | `when` | déclenchement | quand (to be arbitrated) | session 32 | elimination of ◇V: conjunction |
| `VecI`, `VecE` | grading | `[v₀,…] / iter_V` | `[v₀,…] / iterate_V` **→** | pli indexé gradué | pli indexé gradué (proposed) | proposed | R-K1: `iter` becomes `iterate`; the vector is an instance of the fold |
| `Fix` | fixed points | `fix` | `fix` | point fixe | point fixe (retained) | retained | Datafun; « récursion » would be wrong; unnamed rule (`eq:regle-fix`) |
| `Par` | parallel | `c ∥ c` | `c ∥ c` | mise en parallèle | mise en parallèle (retained) | retained | says the absence of order |
| `Vmap` | parallel | `vmap` | `vectormap` **→** | application vectorisée | application vectorisée (retained) | retained | R-K1: `vmap` becomes `vectormap` |
| `Spawn` | layer 2 | `spawn` | `spawn` | engendrement | engendrement (retained) | retained | creation without waiting |
| `Slice` | memory | `slice` | `slice` | découpe | découpe (provisional) | proposed | provisional status lifted: `slice` is the word of the error code `ERR-SLC` and of the rule; `partition` and `tranche` set aside |
| `New` | layer 2 | `new_E` | `new_E` | création de boîte | création de boîte (retained) | retained | null context: nothing |
| `Send` | layer 2 | `send` | `send` | émission | émission (retained) | retained | asynchrony is primitive |
| `Guard` | layer 2 | `guard` | `guard` | réception gardée | réception gardée (retained) | retained | a conjunctive pattern of messages is consumed in one piece |
| `Free` | layer 2 | `free` | `free` | libération | libération (retained) | retained | same word as for layer-1 resources |
| `Loc` | layer 1 | `loc_n` | `placed_n` **→** | marque de lieu | lieu (to be arbitrated) | session 32 | R-K1: no abbreviation; introduction of @ₙV; not to be confused with `at_n` |
| `At` | layer 1 | `at_n` | `at_n` | localisation | localisation (retained) | retained | same word as the modality that types it |
| `Move` | layer 1 | `move_{n→m}` | `move_{n→m}` | déplacement | déplacement (retained) | retained | the resource remains unique |
| `Try` | layer 1 | `try` | `try` | récupération | récupération (retained) | retained | a recourse, not a guarantee of avoiding the fall |
| `Declassify` | kernel | `declassify_ℓ` | `declassify_ℓ` | déclassification | déclassification (retained) | usage | Sabelfeld and Myers, word of the manuscript (22 uses); rule named in session 32 |

The four typing rules that govern no constructor have no word, and receive none:

| Rule | Why |
|---|---|
| `Tick` | instance of `Op`: has no word of its own, `tick` is the name of the operation and not of a constructor |
| `Expand` | macro expansion takes place in Phase 1, before the grammar: not a constructor |
| `Sub` | subtyping rule: applies to any term without forming one |
| `SubBox` | subtyping rule of the graded modality |
