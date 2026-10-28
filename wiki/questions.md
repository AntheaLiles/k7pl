<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Vocabulary questions

This is the working questionnaire for the future collaborative
vocabulary work, carried from the research closing of
2026-10-25. It is **not** a normative page and it ratifies
nothing: it is the instrument with which the vocabulary
questions will be answered, one lot at a time, under the
method recorded below. An answer is recorded in
[decisions](decisions.md) with its date and scope; it never
modifies `spec/`, the macros, the AST, the proofs or the
tests on its own.

## Provenance and status

The questionnaire below is the body of
`docs/research/core-vocabulary-qcm-2026-10-25.md` (2026-10-25,
1,688 lines), carried here verbatim in French, because the
questions weigh candidate words in French and English and
translating them would lose distinctions the research itself
is about — the same reason the per-entry prose of
[primitives](primitives.md) is kept verbatim in French.
File references inside the body that point to deleted
`docs/` sources survive in git history; they are not live
links. Mentions of archives inside status lines are
provenance warnings (a candidate is explicitly *not*
ratified), not endorsements and not a historical narrative:
no historical lineage is retold here.

Organisation, preserved: 58 questions — 48 term questions
(Q-TERM-001 to Q-TERM-048), 8 token questions (Q-TOKEN-001,
Q-TOKEN-002, Q-TOKEN-003A, Q-TOKEN-003B, Q-TOKEN-004 to
Q-TOKEN-007) and 2 method questions (Q-METH-001,
Q-METH-002) — grouped in families (values, products and
sums; suspension, computation and quantification; time,
coinduction and concurrency; token questions; method
arbitrations), followed by the blockers that are not
lexical votes (B-ONTO-01 to B-ONTO-07) and the
consequences of an answer.

Two method answers are recorded. The author's method choice
of 2026-10-25 (VOC-2026-10-25-001, question Q-METH-002,
option A — a global lot after the ontological audit, no
individual ratification of lemmas or tokens until the scope,
categorisation and formal-chain contradictions are
delimited), and the arbitration sequence of 2026-10-26
(VOC-2026-10-26-001, question Q-METH-001, option A), which
lifts blocker B-ONTO-07. Individual answers are recorded as
dated preferences, ratified only in the global lot
(VOC-2026-10-26-002); the first is `lambda` for `Lam`
(Q-TERM-012, and the `Lam` entry of
[primitives](primitives.md)). None of them ratifies a term,
and none authorises a renaming. See
[decisions](decisions.md) and the roadmap section "Work
the research lot follow-ups", which owns the answering
work. The blockers are open items in the same roadmap
section; the ontological audit and the closure plan that
framed them are closed with the research lot, their
verdicts carried here, in [decisions](decisions.md) and
in [vocabulary](vocabulary.md), not recopied as registers.

## Working rules added on 2026-10-26

These rules are new content, in English; the verbatim catalogue
below keeps its French.

- **Dated preferences.** An individual answer on a lemma or a
  token of the core vocabulary (the verbatim catalogue below) is
  recorded as a dated preference and ratified only in the global
  lot (VOC-2026-10-26-002). The answers of the reading lot
  (Q-LEX), which settle how a text is read rather than which word
  names a construct, are recorded as the author's choices and
  applied to `lexicon/` and `spec/` (reading of 2026-10-26, put
  to the author for confirmation).
- **The λ overlap is explained every time.** Whenever `lambda` is
  a candidate lemma, the question states that the symbol λ names
  two objects in the specification — the abstraction `λx.c`
  (rule `Lam`) and, in chapter 3, a natural transformation of the
  graded distributive law — and that the candidate must only ever
  name the first (owner instruction of 2026-10-26).
- **Proposals are material, not decisions.** A definition already
  written in `lexicon/` before its question is answered (for
  example the lexical classes of `lexicon/syntax/tokens.k`) is
  listed in the question as material to consider, never as the
  default answer.
- **Clickable form.** The questions of a lot are also published
  as a clickable questionnaire; the answers given there are
  copied into [decisions](decisions.md) with their date, and the
  question here records the choice.

## Lot of 2026-10-26: reading and delimiters

New questions, in English, for the reading of a K7PL text by
`lexicon/syntax/`. Each one is answered along the M-A sequence
(Q-METH-001): non-collision, scientific exactness, family and grade
invariants, provisional ecological grid, mnemonic arguments,
brevity. Each has the options **Other** (another proposal) and
**Clarify** (ask for more analysis, sources or candidates).

### Q-LEX-001 — What is a symbol?

**Object.** The lexical class `symbol` of the author's grammar
(`atom = symbol | number | string`). It decides which character
sequences form one atom, hence how glyphs, sigils, suffixes, the
dot and the bar are read.
**Facts in `spec/`.** 28 glyphs of layer 3, each an alias of one
standard-library macro, written by their Unicode code point, with
a confusable-skeleton admission rule (chapter 1, glyph table);
`#` reserved for comptime; `:` opens a label, in a namespace of
its own (chapter 5); `@` marks complexity annotations (`@linear`,
chapter 4); the suffixes `?` and `!` carry contracts (chapter 3,
annex A: `ERR-TYP-009`, `ERR-TOP-010`); `.` is projection or
decimal point by position (chapter 1); `|` separates the rows of
an array literal `[1 2 | 3 4]` (chapter 5); the modifiers `´` and
`¨` attach to glyphs in trains such as `+´÷≠` (chapter 5); Phase 0
"désucre les sigils en attributs" (chapter 6).

- **A — one rule, meaning later (proposal of `tokens.k`, material
  to consider).** A symbol is any run of characters other than
  white space, the six delimiters, `"` and `;`. Sigils, glyphs and
  suffixes are parts of symbols; their meaning is given by Phase 0
  and name resolution. *For:* one rule, a fixed reader. *Against:*
  `+´÷≠` and `x.y` are single atoms: the reader sees neither the
  train nor the projection.
- **B — symbols and sigils.** As A, but `#`, `:` and `@` at the
  start of an atom are read as sigils attached to the atom that
  follows, so that Phase 0 can turn them into attributes as
  chapter 6 says. *For:* matches chapter 6; *against:* three more
  lexical rules.
- **C — glyph-aware reading.** Each glyph of the chapter 1 table
  is a token of its own (so `+´÷≠` reads as a train of glyphs),
  identifiers follow Unicode identifier syntax (UAX #31,
  https://www.unicode.org/reports/tr31/), sigils are separate.
  *For:* trains and confusables are visible at reading; *against:*
  the reader depends on the glyph table.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** B et C sont tous les deux vrais car B est la règle générale et C concerne la rédaction de trains à la BQN/Uiua sauf que les symboles sont en réalité des macros à définir pour ensuite les composer en couche 3. Il me semble que ce fonctionnement est bien documenté dans la spec.
- **Clarification:** On respectera systématiquement l'anglais en kebab-case à notation infixe donc "Incrémente-compteur?" est totalement faux et devrait ressembler à "?increase-counter" si tant est que ce lemme soit nécessaire.
- **Reading:** sigils are read apart at the start of an atom (option B, the general rule), and trains are written glyph by glyph (option C), each glyph being a macro to define and then compose in layer 3. Identifiers are English, in kebab-case; the contract mark `?` is written before the name (`?increase-counter`), and the name of the listing's function is itself questioned. Still to choose: whether `!` moves before the name too, the exact sigil set, and how the reader recognises a glyph (lot of 2026-10-26, second part).

### Q-LEX-002 — What is a number?

**Object.** The lexical class `number`. **Facts in `spec/`:** `.` is
also projection; `Decimal128`, overflow behaviour per layer and
SI units as phantom parameters (chapter 3); sizes in types
(`Vector(n, T)`).

- **A — proposal of `tokens.k` (material to consider).** An
  optionally signed decimal with an optional fractional part:
  `[+-]?[0-9]+(\.[0-9]+)?`. `-2` is a number, `-` alone a symbol.
- **B — A with exponents, radix prefixes and digit separators**
  (`1.5e-3`, `0x1F`, `1_000`).
- **C — numbers typed by suffix** (`1u8`, `2.5d128`): the reader
  keeps the suffix, the type system interprets it.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-004), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** All kind of number shall be computable : reals, decimals, floats, integers, fixed point, complexes, irrationals, and so on. Preserves the infix notation. but the type of a number shall be defined as a property so (defvar alpha :num int32) shall be the targetted structure. Such way we can further precise alpha to construct its precise form with i.e. a unit symbol (units having their transformations rules in mathematics) so we can write (defvar alpha :num int32 :unit mm). I like the :num for the number property and 3 letter plus byte precisions for the number's type (flo16, dec32, int8, com64, you name it)
- **Reading:** every kind of number is computable; a number keeps its usual written form; its type is a property, `:num`, written with three letters and a bit width (`int32`, `flo16`, `dec32`, `int8`, `com64`), and may be refined by further properties such as `:unit mm`. Still to enumerate and choose: the list of number kinds and their three-letter names, the meaning of the width for complex numbers, the unit vocabulary, and the delimiter of a declaration such as `(defvar alpha :num int32)`, since types are set in layer 1 (Q-LEX-005).

### Q-LEX-003 — What is a string?

**Object.** The lexical class `string`. **Fact found while
testing:** the builtin string literals of K reject non-ASCII
characters in programs, so K7PL strings have a token sort of
their own.

- **A — proposal of `tokens.k` (material to consider).** Double
  quotes; a backslash escapes the next character; a string may
  span lines; any UTF-8 text.
- **B — escapes of a closed list** (`\n`, `\t`, `\"`, `\\`,
  `\u{…}`), no raw line break.
- **C — B plus raw strings** with a distinct opening mark.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-005), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** We shall further explore how strings are handled in SNOBOL (Icon), Tcl, Emacs Lisp, TeX, SQL, Raku and other "string-capable" languages.
- **Reading:** no choice yet; a research step comes first, on SNOBOL and Icon, Tcl, Emacs Lisp, TeX, SQL, Raku and other languages built to handle text (see [research](research.md), "Strings in text-handling languages"). The proposal of `lexicon/syntax/tokens.k` stays as material to consider.

### Q-LEX-004 — Comments, and disabling a whole tree

**Object.** Chapter 5: `;` in a line, `;;` for a block, `;;;` for a
section, `;;;;` for a module, "et sa mise entre parenthèses,
crochets ou accolades désactive l'arbre entier qui suit sans
rompre la syntaxe". `tokens.k` reads every `;` comment to the end
of the line and does not implement the tree-disabling form.

- **A — the delimited semicolon.** `(;)`, `[;]` or `{;}` written
  before a tree disables that tree; the delimiter of the mark must
  be admitted where it stands (the layer grammar still applies).
- **B — the disabled tree is not checked.** As A, but the
  disabled tree is skipped by every check, nesting included.
- **C — keep line comments only** and amend chapter 5.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-006), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:**

  ```text
  ;; this is a standard comment
  ;;; this is a heading comment as Emacs' outline mode handle
  ;;;; so this is a sub heading

  ;; in an s-expression
  (this is run ;; not this
    but this will run
    hence ;(this will not run) but this will)

  ;; this way a single semicolon used in an other context can be handle as an ascii char
  ```

- **Reading:** `;;` opens a comment to the end of the line, `;;;` a heading and `;;;;` a sub-heading, as in Emacs's outline mode; a semicolon written just before an opening delimiter (`;(`, `;[`, `;{`) disables the tree it opens; anywhere else a single semicolon is an ordinary character. Applied to chapter 5 on 2026-10-26. Still to choose: whether a disabled tree is still checked for nesting, and how `a;` reads (one atom or two).

### Q-LEX-005 — Delimiters in type, pattern and literal positions

**Object.** The grammar of the layers is checked at reading,
whatever a delimiter denotes. Chapter 5 also says that in
binding, pattern or literal position a delimiter announces no
layer. Three notations of `spec/` then fall foul of the grammar:
the refinement type `{x : T | p}` (chapter 3) is refused inside
any `( )` or `[ ]`, that is in every signature outside a layer 1
block (`ERR-TOP-002`, `ERR-TOP-003`); applied type notations such
as `Vector(n, T)`, `Result(T, OutOfBounds)`, `File(Open)` or
`WriteCap(Arena<T>, Range(0,k))` (chapters 3 and 4) put `( )`
inside the `[ ]` of a layer 3 signature (`ERR-TOP-001`), and are
not S-expressions; a brace pattern or literal is refusable
outside layer 1. `[ ]` lists such as `:requires [NetworkCap
ClockCap]` or `[attributs]` are never refused, and chapter 5
already sends a layer 2 computation out of `[attributs]`.

- **A — types are written in `[ ]`.** Types and refinements are
  compile-time, erased, pure objects; they take the layer 3
  delimiter, admitted everywhere: `[Vector n T]`,
  `[Result T OutOfBounds]`, and a refinement in a head form to
  choose (`[refine x T p]`, `[x : T :where p]`; `[x : T | p]`
  would collide with the row bar of array literals).
- **B — a fourth, layer-neutral pair** for types, patterns and
  literals (for example `⟨ ⟩`), admitted everywhere and containing
  anything. *Against:* chapter 5 counts three pairs; `⟨ ⟩` already
  writes pairs and the additive conjunction in chapters 3 and 4.
- **C — a marker switches to a type mode.** After a marker such as
  `:`, the next group is read as a type and nesting is not checked
  in it. *Against:* the reader becomes position-dependent.
- **D — keep the grammar as it is.** Refinement types and brace
  patterns only exist in layer 1, and the chapter 3 and 4
  notations are amended one by one.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-007), given in the clickable questionnaire, quoted as given.**

- **Choice:** D
- **Justification:** Types are setted in layer 1 only, layer 2 is used to orchestrate and layer 3 consume types to run pure and safe powerful calculation, this is really clear in the spec.
- **Reading:** option D, with the reason the author gives: types are set in layer 1 only; layer 2 orchestrates and produces; layer 3 consumes types to compute purely and terminate. Notations such as `Vector(n, T)` do not follow the K7PL syntax and must be formalised, either as S-expressions following the K7PL prescriptions or in a neutral algorithmic format (owner message of 2026-10-26).

### Q-LEX-006 — Codes for unbalanced delimiters

**Object.** The owner decided on 2026-10-26 that unbalanced
delimiters get error codes, in the manner of Parinfer. Parinfer
3.13.1 names eight errors (`parinfer.js`, `errorMessages`,
https://github.com/parinfer/parinfer.js): `quote-danger`,
`eol-backslash`, `unclosed-quote`, `unclosed-paren`,
`unmatched-close-paren`, `unmatched-open-paren`,
`leading-close-paren`, `unhandled`. A scratch prototype shows that
K can read a text as a visibly pushdown automaton (push on an
opener, pop on a closer) and report, with line numbers: an opener
never closed, a closer with no opener, a closer of another pair,
an unclosed string, and the three nesting refusals.

- **Which infractions get a code** (several may be chosen): an
  opener never closed; a closer with no opener; a closer of another
  pair (`[ … )`); an unclosed string; a backslash at the end of a
  line in a string; a quote inside a comment.
- **Numbering.** A — continue `ERR-TOP` after `ERR-TOP-003`,
  ordered from layer 3 to layer 1 (the specification-block code,
  now `ERR-TOP-004`, moves again). B — a new three-letter segment
  for reading errors (for example `ERR-RDR-` or `ERR-DLM-`),
  leaving `ERR-TOP` as it is. C — `ERR-TOP-001` to `ERR-TOP-n` cover
  every delimiter infraction, nesting and balance, ordered by
  container layer then by kind.
- **Granularity.** One code per kind, the delimiter named in the
  message; or one code per kind and per delimiter (`[`, `(`, `{`).
- **Recovery after a closer of another pair.** Close the innermost
  opener and go on (as the prototype does), or look for a matching
  opener further out and report the openers left unclosed.

Sub-questions as published: a — which infractions, b — numbering, c — granularity, d — recovery.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-008), given in the clickable questionnaire, quoted as given.**

- **Choice:** 1, 2, 3, 4, 6
- **Other:** Rule 5 require further exploration through K7PL's point of view and genneraly we shall explore TXR Lisp's, Raku's and Icon's way as they are precisely designed to handle texts
- **Reading:** codes for an opener never closed, a closer with no opener, a closer of another pair, an unclosed string and an odd number of quotes inside a comment. A backslash at the end of a line in a string needs its own study from K7PL's point of view, with TXR Lisp, Raku and Icon as references.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-009), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** Generaly, the error codes requiers their own studies to provide clearer codes and messages.
- **Reading:** a new segment for reading errors, outside `ERR-TOP`; its name and the messages come out of a dedicated study of error codes and messages.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-010), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** It's a syntax error that shall be easilly displayed through LSP and such kind of tools. Here, layer awareness is irrelevant because syntax itselve is corrupted hence the code can't and musn't compile.
- **Reading:** one code per kind; the message names the delimiters; layers play no part in a corrupted syntax.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-011), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** Delimitors are precises and works by two. Nothing more, nothing less.
- **Reading:** a closer looks for its matching opener further out; the openers in between are reported as never closed.

## Lot of 2026-10-26, second part: reading details, types, numbers, strings, error codes

Questions opened by the answers to the first part. They follow the
same rules: options to enumerate and objectify, then the author's
choice; **Other** and **Clarify** are always available. The
options were built from the research recorded in
[research](research.md), "Reading lot: research of 2026-10-26".

Words in the examples (`defn`, `sig`, `defvar`…) are placeholders: they are chosen in the vocabulary lots, not here.

### Reader details

#### Q-LEX-101 — Where does the mark ! go?

**Object.** Q-LEX-001 puts the contract mark `?` before the name (`?increase-counter`). The mark `!` of an impure function is still written after the name.

**Facts.**

- Annex A, `ERR-TOP-010`: « Fonction impure, suffixée `!` »; `ERR-TYP-009`: « Fonction suffixée `?` ».
- Chapter 5 (`sec:c5-mise-en-pratique`): « Le suffixe `?` engage le contrat du chapitre 3 ».

- **A — Before the name, like ?.** Example: `!write-log   ?increase-counter`. *For:* one position for the two contract marks; both are sigils (Q-LEX-102). *Against:* annex A and chapters 3 and 5 are rewritten for both marks.
- **B — After the name.** Example: `write-log!   ?increase-counter`. *For:* no change for `!`. *Against:* two marks of one family in two positions.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-012), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** the contract marks `?` and `!` are both written before the name (`?increase-counter`, `!write-log`). Annex A (`ERR-TOP-010`, `ERR-TYP-009`), chapter 5 and the listing `lst:fonction-pure` still write them as suffixes; they change together with the listings of chapter 5, whose rewrite is put to the author in the third part of the lot (Q-SPEC-001).

#### Q-LEX-102 — Which characters are sigils?

**Object.** Q-LEX-001 (option B): a sigil at the start of an atom is read apart and attached to the atom that follows; Phase 0 turns it into an attribute (chapter 6). Choose every character that is a sigil.

Several options may be chosen.

- **1 — # — comptime.** Reserved for comptime evaluation (chapter 5, chapter 1 glyph table).
- **2 — : — label or property.** `:état` in chapter 5; `:num int32`, `:unit mm` in Q-LEX-002.
- **3 — @ — annotation.** `@linear`, `@polynomial`, `@:stream` (chapter 4).
- **4 — ? — pure contract.** `?increase-counter` (Q-LEX-001).
- **5 — ! — impure contract.** If Q-LEX-101 puts it before the name.
- **6 — ^ — lens.** `^.` reads a field, `^=` updates it (chapter 5). As a sigil, `^.` becomes `^` attached to `.`.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-013), given in the clickable questionnaire, quoted as given.**

- **Choice:** 1, 2, 3, 4, 5
- **Justification:** Je ne suis pas très sur pour `^`
- **Reading:** `#`, `:`, `@`, `?` and `!` are sigils. `^` is not chosen and the author is unsure of it: its status comes back with more analysis in the third part (Q-LEX-202).

#### Q-LEX-103 — How does the reader recognise a glyph?

**Object.** Glyphs are macros composed in layer 3 (Q-LEX-001), so the reader must cut `+´÷≠` into glyphs. On what basis?

**Facts.**

- Chapter 1: 28 layer 3 glyphs, each the alias of one standard-library macro, written by its Unicode code point; no two glyphs share a confusable skeleton.
- BQN: « Otherwise, a single character forms a token. Only the specified set of characters can be used; others result in an error. » (BQN spec, Tokens (https://mlochbaum.github.io/BQN/spec/token.html)).
- Uiua: each primitive can be typed as its lower-case name, which the formatter replaces with the glyph (APL Wiki, secondary source).

- **A — A closed list of glyphs.** The reader knows the glyphs of the chapter 1 table and their modifiers; any other symbol character is part of a name. *For:* exact; confusables are checked at reading. *Against:* a new glyph changes the reader.
- **B — Unicode symbol categories.** Every character of the Unicode categories Sm and So (mathematical and other symbols) forms a one-character token. *For:* the reader does not depend on the table. *Against:* a symbol character can no longer appear inside a name.
- **C — A, with ASCII names turned into glyphs.** As A; each glyph can also be typed by the name of its macro, and the formatter writes the glyph (as Uiua does). *For:* no special keyboard needed. *Against:* a formatter becomes part of the toolchain.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-014), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** Déjà expliqué : un glyphe est un caractère unicode attribué en alias d'un symbole
- **Reading:** the reader knows the closed list of glyphs of the chapter 1 table, a glyph being a Unicode character given as the alias of a symbol; each glyph can also be typed by its alias, which a formatter turns into the glyph. Found while applying it: five glyphs of the table are ASCII characters (`+`, `-`, `=`, `<`, `>`); `-` also joins the words of kebab-case names, and `+` and `-` sign numbers. How a run such as `increase-counter`, `-2` or `+´÷≠` is cut is put to the author in the third part (Q-LEX-201).

#### Q-LEX-104 — Is a disabled tree still checked?

**Object.** Q-LEX-004: `;(`, `;[` or `;{` disables the tree it opens. Is that tree still checked?

- **A — Balance and nesting.** Example: `[f ;(g x) y]   ;; refused: ( ) inside [ ] (ERR-TOP-001)`. *For:* a disabled tree can be re-enabled as it is. *Against:* a tree of another layer cannot be parked here.
- **B — Balance only.** Example: `[f ;(g x) y]   ;; accepted: the tree is ignored once it is closed`. *For:* any tree can be parked. *Against:* re-enabling it may raise a nesting refusal.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-015), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** L'arbre commenté doit rester valide car il peut constituer une composante du code comme un quasiquote ou quote si un statement le précise
- **Reading:** a disabled tree is read and checked like any other tree, for balance and for nesting. It stays a valid tree because a declaration may use it as a part of the code, as a quote or a quasiquote. Applied to chapter 5 and to the reader.

#### Q-LEX-105 — How does a; read?

**Object.** A lone semicolon is an ordinary character (Q-LEX-004). Where does it belong when it touches a name?

- **A — One atom.** Example: `a;   ->  the symbol a;`.
- **B — Two atoms (what `lexicon/` reads today, material to consider).** What `lexicon/syntax/tokens.k` reads today; `a;b` stays one atom. Example: `a;   ->  a  and  ;`.
- **C — Refused.** Example: `a;   ->  write a ; with a space`.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-016), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** `a;` reads as the atom `a` followed by the atom `;`; `a;b` stays one atom. This is what `lexicon/syntax/tokens.k` already reads; stated in chapter 5.

### Types

#### Q-TYP-001 — How are type notations written in the specification?

**Object.** Types are set in layer 1 only (Q-LEX-005). The specification writes 35 type notations (47 occurrences) in three incompatible styles, none of them K7PL: application `Vector(n, T)`, angle brackets `WriteCap<T>`, juxtaposition `Vec n T`. Full list: `wiki/research.md`, « Notations of the specification that are not K7PL ».

- **A — K7PL S-expressions in layer 1.** Example: `{Vector n T}   {Result T OutOfBounds}   {WriteCap {Arena T} {Range 0 k}}   {refine x T p}`. *For:* one syntax, checked by the reader like any listing. *Against:* prose about theory carries code syntax.
- **B — A neutral algorithmic format.** Mathematical notation in math spans, as chapter 3 already writes its grammar of types; never as code. *For:* no confusion with K7PL code. *Against:* programs still need a K7PL form for the same types.
- **C — By role.** K7PL S-expressions wherever a program is meant (listings, code spans); mathematical notation in rules, theorems and their proofs. *For:* each reader sees the notation of the task. *Against:* two notations of one object to keep aligned.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-017), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** La spécification (dans le sens "expliquer l'intention") doit être écris en notation mathématique puis être présentée en code K7PL.
- **Reading:** by role. The specification explains the intention in mathematical notation, then presents it in K7PL code. Applied: the type notations of the theory prose become math spans. Those that stand for a program (rows of annex A, case studies of chapter 7) wait for the K7PL writing of types, put to the author in the third part (Q-TYP-101).

#### Q-TYP-002 — Metalanguage formulas written as code

**Object.** 20 formulas of the metalanguage are written as code spans although they are mathematics: `Cost_Budget(κ) ≤ β`, `Scale_Usage(a, Δ₁+Δ₂)=…`, `Adm(β, κ)`…

- **A — Rewrite them as math spans.** *For:* code spans keep a single meaning: K7PL text.
- **B — Keep them as they are.** *Against:* a reader may take them for K7PL.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-018), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** the formulas of the metalanguage become math spans; code spans are kept for K7PL text and for identifiers (codes, labels, files, Lean names). Applied, together with the other formulas of the same paragraphs.

#### Q-TYP-003 — Where does a layer 2 or layer 3 function get its type?

**Object.** Types are set in layer 1 only. Chapter 3: « Toute définition de plus haut niveau porte une signature »; default grades and local inference shorten it, and K7PL does not infer the grades of an unannotated definition.

- **A — A layer 1 signature beside the definition.** Example: `{sig ?increase-counter {fn [int32 int32] {result int32 overflow}}} ⏎ [defn ?increase-counter [value bound] …]`. *For:* the definition stays entirely in its layer. *Against:* name repeated; signature and body can drift apart.
- **B — The definition opens in layer 1.** Example: `{defn ?increase-counter :type {fn [int32 int32] {result int32 overflow}} ⏎   [value bound] ⏎   [select …]}`. *For:* one place per definition; the delimiters show where layer 1 ends. *Against:* every definition is written in braces.
- **C — Types at the module interface only.** A layer 1 interface declares the exported types; inside the module, types are inferred. *For:* fewer annotations. *Against:* chapter 3 asks for a signature on every top-level definition.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-019), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** On va coder la stdlib en layer 1 pour définir les fonctions et leurs comportement dans les couches 2 et 3.
- **Reading:** a definition opens in layer 1, where its type is set; its parameters and its body are written in the delimiters of their layer. The standard library will be written in layer 1, defining the functions and their behaviour in layers 2 and 3. The words of the form (`defn`, `:type`, the writing of a function type) were placeholders: the listings of chapter 5 are rewritten once they are chosen (Q-SPEC-001, Q-TYP-101).

#### Q-TYP-004 — Declarations that carry a type inside ( )

**Object.** Two declarations carry a type inside a layer 2 group: `(defvar alpha :num int32)` (Q-LEX-002) and `(champ valeur : Int)` (`lst:acteur`).

- **A — They move to { }.** Example: `{defvar alpha :num int32}   {field value :num int32}`.
- **B — The type part is a layer 1 group.** Example: `(defvar alpha {num int32})   (field value {num int32})`.
- **C — A property is not a type definition.** `:num int32` names a type set elsewhere, in layer 1; using it in layer 2 is allowed. Example: `(defvar alpha :num int32)`.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-020), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a declaration that carries a type is written in `{ }`: `{defvar alpha :num int32}`, `{field value :num int32}`. It applies to `lst:acteur` with the rewrite of the listings (Q-SPEC-001).

### Numbers

#### Q-NUM-001 — Which number kinds get a three-letter name?

**Object.** Q-LEX-002: every kind of number is computable; its type is a property `:num`, three letters and a bit width (`int32`, `flo16`, `dec32`, `com64`). Choose the kinds.

**Facts.**

- IEEE 754-2019 (named in chapter 3, not in the bibliography) defines binary floating-point formats of 16, 32, 64 and 128 bits and decimal formats of 32, 64 and 128 bits.

Several options may be chosen.

- **int — signed integers.** `int8` … `int128`.
- **nat — unsigned integers (name in Q-NUM-002).** `nat8` … `nat128`, or the name chosen in Q-NUM-002.
- **flo — binary floating point.** `flo16`, `flo32`, `flo64`, `flo128` (IEEE 754).
- **dec — decimal floating point.** `dec32`, `dec64`, `dec128` (IEEE 754).
- **fix — fixed point.** Notation chosen in Q-NUM-004.
- **com — complex.** Width chosen in Q-NUM-003.
- **rat — exact rationals.** Numerator and denominator of bounded width.
- **rea — exact reals (name to choose).** Irrationals such as π or √2, computed to any requested precision.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-021), given in the clickable questionnaire, quoted as given.**

- **Choice:** int, nat, flo, dec, fix, com, rat, rea, OTHER
- **Other:** La liste doit être complete.
- **Reading:** every kind listed is kept, and the list must be complete: a research step enumerates the other kinds of numbers before the choice (third part, Q-NUM-101).

#### Q-NUM-002 — Name of the unsigned integers

**Object.** Three letters and a width, like the other kinds.

- **A — nat.** Example: `nat8  nat32`. *For:* the mathematical name of the non-negative integers.
- **B — uin.** Example: `uin8  uin32`. *For:* close to the usual uint.
- **C — int with a property.** Example: `:num int32 :sign none`. *Against:* no three-letter name of its own.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-022), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** unsigned integers are `nat`: `nat8`, `nat32`.

#### Q-NUM-003 — What is the width of a complex number?

**Object.** `com64` in Q-LEX-002.

- **A — Total width.** Example: `com64 = two flo32`. *For:* same reading of the width as the other kinds: the size in memory.
- **B — Width of each part.** Example: `com64 = two flo64`. *For:* the precision of the parts is read directly.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-023), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** L'option A préserve la cohérence d'ensemble. Cependant, tel que posé cela indique que 'com8 = two flo4' et je pense que ce n'est pas une bonne idée d'encoder un float4 qui n'est pas standard sur le hardware alors il est probablement préférable d'encoder à minima un 'com64 = two flo32' pour avoir un seuil de précision et scale ensuite à com128 et com256.
- **Reading:** the width of a complex number is its total width, as for the other kinds. Read literally, that would allow `com8`, two four-bit floats, a format that hardware does not provide; the smallest complex type is therefore `com64` (two `flo32`), for a floor of precision, followed by `com128` (two `flo64`) and `com256` (two `flo128`).

#### Q-NUM-004 — How is a fixed-point type written?

**Object.** A fixed-point number needs a total width and a position of the point.

- **A — Integer and fraction bits.** Example: `fix16.16`.
- **B — Total width and a scale property.** Example: `:num fix32 :scale 16`.
- **C — Decimal digits.** Example: `:num fix :digits 12 :frac 2`. *For:* money and decimal quantities.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-024), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** On pourrait ainsi dire 'fix4.16' pour 4bit devant et 16bit derrière.
- **Reading:** a fixed-point type is written with its integer bits and its fraction bits: `fix16.16`, `fix4.16` (4 bits before the point, 16 after). Whether the sign bit is counted is put to the author in the third part (Q-NUM-102).

#### Q-NUM-005 — Which unit vocabulary?

**Object.** `(defvar alpha :num int32 :unit mm)`: a unit is a property; units have their own transformation rules (Q-LEX-002).

**Facts.**

- UCUM 2.2 (2024-06-17), « a code system intended to include all units of measures being contemporarily used in international science, engineering, and business », SI and non-SI units, a case-insensitive variant of every symbol; degree Celsius: `Cel` (ucum.org (https://ucum.org/ucum)).

- **A — UCUM codes.** Example: `:unit mm   :unit Cel   :unit m/s`. *For:* a published grammar of units, ASCII only. *Against:* some codes differ from printed symbols.
- **B — SI symbols as printed.** Example: `:unit mm   :unit °C   :unit m·s⁻¹`. *For:* what a reader expects. *Against:* non-ASCII; no published grammar for combinations.
- **C — K7PL names, mapped to UCUM.** Example: `:unit millimetre`. *Against:* a third vocabulary.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-025), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** UCUM est cohérent
- **Reading:** units are written with UCUM codes: `:unit mm`, `:unit Cel`, `:unit m/s`.

### Strings

#### Q-STR-001 — How is a quote or a control character escaped?

**Object.** Research in `wiki/research.md`, « Strings in text-handling languages ».

- **A — Backslash escapes.** As Emacs Lisp, Tcl and Icon; the list of escapes to choose. Example: `"say \"hi\"\n"`.
- **B — Doubled quote, no other escape.** As SQL (with single quotes) and BQN. Example: `"say ""hi"""`.
- **C — No escape.** As SNOBOL4, with two kinds of quote marks: a literal can only contain the other mark.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-026), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a backslash escapes a quote or a control character; the list of escapes is chosen in the third part (Q-STR-101).

#### Q-STR-002 — What does a line break inside a literal mean?

**Object.** This also settles Q-LEX-006 case 5 (a backslash at the end of a line).

- **A — A character of the string.** As Emacs Lisp: « The newline character is not special in the read syntax for strings ».
- **B — Dropped after a backslash.** Emacs Lisp drops an escaped newline; Tcl replaces backslash, newline and the following indentation with one space.
- **C — Dropped after an underscore.** Unicon (Icon family): the underscore, the newline and the leading white space of the next line are not part of the literal.
- **D — Forbidden; literals joined across lines.** One literal per line; two literals separated by a line break are concatenated, as SQL specifies.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-027), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** J'ai besoin d'une évaluation des tradeoff pour éviter un choix arbitraire
- **Reading:** kept open: the author asks for an evaluation of the trade-offs, so that the choice is not arbitrary. It comes back in the third part (Q-STR-102), with case 5 of Q-LEX-006 (a backslash at the end of a line).

#### Q-STR-003 — Does a literal interpolate?

- **A — Never.** *For:* a literal is a constant.
- **B — Only in a distinct form.** As Raku's `qq` beside `q`.
- **C — Always.** *Against:* every literal may run code.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-028), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a literal never interpolates.

#### Q-STR-004 — Raw and heredoc forms

Several options may be chosen.

- **raw — A raw form.** Content taken literally, as Raku's `Q` or `｢…｣`.
- **heredoc — Heredocs.** As Raku's `q:to/END/`, the terminator's indentation removed from every line.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-029), given in the clickable questionnaire, quoted as given.**

- **Choice:** raw, heredoc
- **Reading:** K7PL has a raw form and heredocs; their notations are chosen in the third part (Q-STR-103, Q-STR-104).

### Error codes and messages

#### Q-ERR-001 — Segment of the reading errors

**Object.** Q-LEX-006-b: a new segment for unbalanced delimiters, named by a study. The glossary defines a code as `ERR`, a three-letter segment naming the protected invariant, and an order number.

- **RDR — reader.** `ERR-RDR-`: the invariant is a text that can be read.
- **LEX — lexical analysis.** `ERR-LEX-`: also covers unclosed strings and comments.
- **SYN — syntax.** `ERR-SYN-`: syntax in general.
- **DLM — delimiters.** `ERR-DLM-`: delimiters only.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-030), given in the clickable questionnaire, quoted as given.**

- **Choice:** DLM
- **Reading:** the segment of the delimiter errors is `ERR-DLM`. Whether an unclosed string and an odd number of quotes in a comment fall under it is put to the author in the third part (Q-ERR-101).

#### Q-ERR-002 — Shape of a message

**Facts.**

- Annex A distinguishes three levels after Rasmussen: signal, rule, knowledge.
- Rust: codes `E0001`…`E0806`, a page per code with explanation and examples (error index (https://doc.rust-lang.org/error_codes/error-index.html)). GHC: `[GHC-12345]` since 9.6.1, indexed at errors.haskell.org (https://errors.haskell.org/).

- **A — Signal and correction.** One sentence each, as annex A today.
- **B — Signal, rule, knowledge.** The three levels of the annex A introduction, each code carrying all three.
- **C — Short message, code, explanation page.** As Rust's and GHC's indexes: the compiler prints little; each code has a page with examples.
- **D — B and C.**

**Answer of the author — 2026-10-26 (VOC-2026-10-26-031), given in the clickable questionnaire, quoted as given.**

- **Choice:** D
- **Reading:** each code carries the three levels of annex A (signal, rule, knowledge), and the compiler prints a short message with the code, each code having an explanation page with examples, as in Rust and GHC.

#### Q-ERR-003 — Internationalising the messages

**Facts.**

- rustc makes its diagnostics translatable with Fluent resources, one identifier per message; as of October 2024 that infrastructure « is waiting for a yet-to-be-proposed redesign » (rustc dev guide (https://rustc-dev-guide.rust-lang.org/diagnostics/translation.html)).
- Fluent: « translations are asymmetric »: a translation may use its language's grammar freely (projectfluent.org (https://projectfluent.org/)).

- **A — A catalogue keyed by code, Fluent style.** *For:* one entry per code and language; the code is the key.
- **B — Catalogues keyed by the French text.** In the manner of gettext. *Against:* changing the French text breaks every translation.
- **C — French in annex A, translations generated beside it.** *For:* annex A stays the reference.
- **D — Later.** Keep French only until the codes are stable.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-032), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** messages are translated through a catalogue keyed by code, in the manner of Fluent.

#### Q-ERR-004 — Recomposing annex A from K, Lean and TLA+

**Object.** Owner message of 2026-10-26: annex A « devra être recomposée à partir des implémentations K, Lean et TLA+ ».

- **A — Generated.** Each code is declared once, with its message, in the K, Lean or TLA+ text that emits it; the specification displays the generated table, as it displays the K files. *For:* one home per code. *Against:* Lean and TLA+ need the same declaration convention as K.
- **B — Written, then checked.** Annex A stays hand-written; a check compares it word for word with the implementations, as `tools/layer-check` does for K now. *For:* editorial freedom. *Against:* two copies kept aligned by a check.

**Answer of the author — 2026-10-26 (VOC-2026-10-26-033), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** On attend d'avoir implémenté l'annexe A avant de la recomposée. l'avantage c'est que l'on pourra construire un index cohérent et consolidé suivi d'une page par code d'erreur comme GHC et Rust.
- **Reading:** annex A is recomposed once it is implemented, not before; the recomposition then builds a consolidated index and one page per error code, as GHC and Rust do. The message shape (Q-ERR-002) and the catalogue (Q-ERR-003) take effect at that recomposition; until then a new code is written in the current form of annex A.

## Lot of 2026-10-27, third part: glyphs, types in K7PL, chapter 5, numbers, strings, error codes

Questions opened by the answers to the second part, and points
found while applying them. They follow the same rules: options to
enumerate and objectify, then the author's choice; **Other** and
**Clarify** are always available. The options were built from the
research recorded in
[research](research.md), "Reading lot: research of 2026-10-27".

Words of the examples that no answer has fixed yet (`defn`, `fn`, `field`, `Ok`, `Err`…) are the words the specification already uses, or placeholders.

### Reader details

#### Q-LEX-201 — How are the ASCII glyphs read?

**Object.** Found while applying Q-LEX-103: five glyphs of the chapter 1 table are ASCII characters, `+` (`add`), `-` (`sub`), `=` (`eq`), `<` (`lt`) and `>` (`gt`). If the reader cuts every glyph of the closed list, `increase-counter` becomes `increase`, `-`, `counter`, and `-2` a glyph and a number.

**Facts.**

- Chapter 1, `tab:glyphes`: 28 glyphs, five of them ASCII.
- Q-LEX-001: identifiers are English kebab-case, whose words are joined by `-`; Q-LEX-002 keeps signed numbers (`-2`, `+4`).
- Raku allows in an identifier « embedded apostrophes `'` and/or hyphens `-`, provided that the next character is each time alphabetic » (Raku, Syntax (https://docs.raku.org/language/syntax)).
- BQN has no `-` in names: « Word tokens are formed from the numeric characters `¯∞π0123456789` » and the alphabetic ones; a negative number is written with the high minus `¯` (BQN spec, Tokens (https://mlochbaum.github.io/BQN/spec/token.html)).

- **A — A run of glyphs is a train; any other run is read whole.** A run made only of glyphs and modifiers is cut into glyphs; a run that holds any other character is a name or a number, as today. *For:* kebab-case names, signed numbers and the chapter 1 table stay as they are. *Against:* `x-1` is one name, never a subtraction (which is written `[- x 1]` anyway).

  ```text
  +´÷≠  ->  + ´ ÷ ≠        -  ->  the glyph sub
  increase-counter  ->  one name        -2  ->  a number        <=  ->  < =
  ```

- **B — Raku's rule.** `-` belongs to a name only between two letters; anywhere else it is the glyph. Example: `increase-counter  ->  one name        x-1  ->  x  -  1`. *For:* a rule with a precedent. *Against:* no digit after a hyphen in a name (`vector-3d`); a prefix language gains nothing from reading `x-1` as three atoms.
- **C — A non-ASCII code point for sub.** The table writes sub as `−` (U+2212, minus sign); `-` is then never a glyph. *For:* names and numbers keep `-`; the reader needs no rule. *Against:* chapter 1 changes; `−` and `-` look alike, the confusion the admission rule of the table guards against.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a run made only of glyphs and modifiers is a train, cut into glyphs; any other run is read whole, as a name or a number. `increase-counter` is one name, `-2` a number, `+´÷≠` a train. Applied to chapter 5 and to the balance reader, whose list of glyphs is checked against `tab:glyphes`.

#### Q-LEX-202 — What is ^?

**Object.** Q-LEX-102 left `^` out of the sigils, the author being unsure. It writes the lenses of chapter 5: `[^. state value]` reads a field, `(^= state value new-value)` updates one (`lst:gestionnaire`).

- **A — Not a sigil: ^. and ^= are names.** Each is one atom, the name of a lens macro. This is how the reader reads them today. *For:* no reading rule; other lenses get names of their own. *Against:* the family is a naming habit, which the reader does not see.
- **B — A sigil, read apart like :.** `^.` is the sigil `^` attached to `.`, `^=` the sigil attached to `=`; Phase 0 makes it an attribute. *For:* the lens family is visible to the reader. *Against:* `=` is a glyph, and `.` means projection or decimal point (chapter 1).
- **C — Glyphs of the chapter 1 table.** Each lens becomes a glyph of the closed list (Q-LEX-103), with an alias such as `view` or `set`. *For:* the lenses join the glyphs they are used with. *Against:* the table holds single code points; `^.` has two.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-002), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** Je préfère des noms clairs comme "set" et "view"
- **Reading:** the lenses get clear names, such as `view` and `set`, instead of `^.` and `^=`; `^` is neither a sigil nor a glyph. Applied to `lst:gestionnaire` and its prose with `view` and `set`.

### Writing types in K7PL

#### Q-TYP-101 — How are type names written?

**Object.** Types are set in layer 1 (Q-LEX-005, Q-TYP-003). Number types are written `int32`, `flo64` (Q-LEX-002); identifiers are English kebab-case (Q-LEX-001). The theory now writes `\mathsf{Result}`, `\mathsf{Vector}`, `\mathsf{WriteCap}` in mathematics (Q-TYP-001).

- **A — Lowercase kebab-case, like int32.** Example: `{vector n t}   {result int32 overflow}   {write-cap {arena t}}`. *For:* one case for every identifier. *Against:* a type and a value look alike; only the layer tells them apart.
- **B — Type constructors capitalised.** Example: `{Vector n T}   {Result int32 Overflow}   {WriteCap {Arena T}}`. *For:* types stand out, as in the theory and in most typed languages. *Against:* two cases, against “English kebab-case, systematically”; `int32` stays lowercase.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** Je pense que nous pouvons trouver d'autres possibilités de rédactions.
- **Reading:** kept open: the author expects other ways of writing type names than the two options. They come back, researched, in the fourth part of the lot (Q-TYP-201).

#### Q-TYP-102 — How is a type variable told from a type name?

- **A — By a binder.** A layer 1 form lists the variables of a type; any other name is a type name. Example: `{forall [t] {fn [t] t}}`. *For:* explicit, as the quantifiers of chapter 3. *Against:* every polymorphic type is wrapped.
- **B — By a mark, ML style.** A name that starts with `'` is a type variable. Example: `{fn ['t] 't}`. *For:* short, with a precedent (Standard ML, OCaml). *Against:* one more reading rule; `'` is free today.
- **C — By case.** A single capital letter is a variable. Example: `{fn [T] T}`. *Against:* only meaningful if type names are lowercase (Q-TYP-101 A).

**Answer of the author — 2026-10-27 (VOC-2026-10-27-004), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Polymorphisme est interdit en K7PL => tout est monomorphé.
- **Reading:** a type variable is introduced by a binder. The author adds that polymorphism is forbidden in K7PL: everything is monomorphised. How this meets the type quantification of chapter 3 (`∀α. C`, `Λα. c`, `c[W]`) is put to the author in the fourth part (Q-TYP-203).

#### Q-TYP-103 — How is a function type written?

**Object.** In layer 1 the grammar admits `[ ]` and `( )` inside `{ }`; but a delimiter defines the layer it opens, so a `[ ]` inside a type is a layer 3 group.

- **A — Braces only.** Example: `{fn {int32 int32} {result int32 overflow}}`. *For:* a type is layer 1 all through. *Against:* a list of types and an applied type look alike.
- **B — The parameters in [ ].** Example: `{fn [int32 int32] {result int32 overflow}}`. *For:* the parameter list stands out, as in a definition. *Against:* a layer 3 group inside a type, which is set in layer 1.
- **C — An arrow head.** The last type is the result. Example: `{→ int32 int32 {result int32 overflow}}`. *For:* the notation of the theory. *Against:* `→` is non-ASCII; the ASCII `->` is two glyphs (Q-LEX-201).

**Answer of the author — 2026-10-27 (VOC-2026-10-27-005), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** L'option C avec un vrais lemme à la place de la flèche
- **Reading:** a function type is written with its parameter types and its result type flat after a head (option C), the head being a true lemma rather than an arrow; the lemma is chosen in the fourth part (Q-TYP-202). The listings keep the placeholder `fn` until then.

#### Q-TYP-104 — What does Int of lst:acteur become?

**Object.** `(champ valeur : Int)` declares an integer field without a width; K7PL types carry one (Q-LEX-002).

- **A — int64.** Example: `{field value :num int64}`.
- **B — int32.** Example: `{field value :num int32}`.
- **C — An unbounded integer.** If Q-NUM-101 keeps one. Example: `{field value :num big}`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-006), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:**

  > Ici c'etait probablement une illustration historique d'un mécanisme lors duquel les types numériques n'étaient pas défini.
  >
  > On peut désormais considérer que "int" non précisé est un typed hole qui se résoudra dans la famille "int" des types.

- **Reading:** the `Int` of `lst:acteur` was a historical illustration from before number types were defined. An `int` without a width is a typed hole, resolved within the family of `int` types: `{field value :num int}`. Applied to `lst:acteur`.

### Rewriting chapter 5

#### Q-SPEC-001 — The four listings and their prose

**Object.** Your answers change the four listings of chapter 5 together: contract marks before the name (Q-LEX-101), English kebab-case (Q-LEX-001), definitions opened in layer 1 (Q-TYP-003), declarations with a type in `{ }` (Q-TYP-004). The prose follows: « Le préfixe `?` engage le contrat… »; a sentence states that types are set in layer 1 only, that layer 2 orchestrates and produces and that layer 3 computes and terminates; a sentence lists the sigils `#`, `:`, `@`, `?`, `!`; annex A writes « préfixée » for `ERR-TOP-010` and `ERR-TYP-009`. The type lines follow Q-TYP-101 to Q-TYP-104 (shown here with option A or B where it is shorter).

Several options may be chosen.

- **pure — lst:fonction-pure.**

  ```text
  {defn ?increment-bounded :type {fn [int32 int32] {result int32 overflow}}
    [value bound]
    [select [< value bound]
            [Ok [+ value 1]]
            [Err Overflow]]}
  ```

- **handler — lst:gestionnaire.** A handler is a definition too, so it opens in layer 1; its type, a handler of the counter's state, is written once Q-TYP-101 to Q-TYP-103 are answered.

  ```text
  {defhandler counter-handler :type …
    (message state)
    (match message
      ((Increment n)
       (match [?increment-bounded [^. state value] [^. state bound]]
         ((Ok new-value)
          (HandlerResult :state (^= state value new-value) :response (Ok new-value)))
         ((Err e)
          (HandlerResult :state state :response (Err e))))))}
  ```

- **actor — lst:acteur.** The prose that says « `champ` et `bind-to` s'écrivent entre parenthèses » changes: the fields are now in braces.

  ```text
  {defactor Counter
    {field value :num int32}
    {field bound :num int32}
    (bind-to counter-handler)}
  ```

- **error — lst:erreur-remontee.** The refusal stays `ERR-TOP-001`: a `( )` inside the `[ ]` of the body.

  ```text
  {defn ?increment-bounded :type …
    [value bound]
    [Ok (HandlerResult :state value :response (Ok value))]}  ;; rejeté : ERR-TOP-001
  ```


**Answer of the author — 2026-10-27 (VOC-2026-10-27-007), given in the clickable questionnaire, quoted as given.**

- **Choice:** pure, handler, actor, error, OTHER
- **Other:**

  > "bind-to" n'est pas un lemme évalué, comparé et choisi.
  > Ici je cherchais à représenter le `>>=` de haskell.

- **Reading:** the four listings are accepted as shown, together with the prose they come with; the words fixed by the other answers of this part are applied in them (`view` and `set`, the flat function type, the typed hole `int`). The author adds that `bind-to` is not a lemma that was evaluated, compared and chosen: it stands for Haskell's `>>=`. The lemma, and what this means for the prose of `lst:acteur`, are put to the author in the fourth part (Q-SPEC-101).

#### Q-SPEC-002 — Other identifiers of the specification

**Object.** Outside chapter 5, a few code spans still break the naming rules: snake_case primitives `hollow_alloc` (chapter 3), `alloc_range` (chapter 4), `provenance_id` (chapter 6); the law `coherence_usage` (chapter 2); number types `Float64` (annex A, `ERR-TYP-005`) and `Decimal128` (chapter 7).

- **A — Rename them now.** The law name, which belongs to the metalanguage, is written in mathematics. Example: `hollow-alloc   alloc-range   provenance-id   flo64   dec128`.
- **B — With the vocabulary lots.** They stay as they are until their lemma is chosen.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-008), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** the snake_case identifiers and the number type names left in the specification wait for the vocabulary lots.

#### Q-NOT-001 — A judgement with Γ

**Object.** Chapter 3 (`sec:c3-structures-ouvertes-effets-et`) writes the judgement `Δ;Γ ⊢ C at d ▷ Δ';Γ'[m]`, which « décompose un contexte en un trou et son environnement ». Written in mathematics (Q-TYP-002), it fails a check of the specification: Δ is the only context of a judgement, Γ keeps its categorical sense (`scripts/spec_checks/notation.py`). It stays in code until you choose.

- **A — Two Δ zones.** Example: `Δ₁;Δ₂ ⊢ C at d ▷ Δ₁';Δ₂'[m]`. *For:* the notation rule holds everywhere.
- **B — Keep it as code.** As a notation quoted from its source. *Against:* one formula of the metalanguage stays in a code span.
- **C — Allow Γ in this judgement.** The rule names this judgement as an exception. *Against:* Γ gets two meanings again.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-009), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** the judgement of chapter 3 is written with two Δ zones, `Δ₁;Δ₂ ⊢ C at d ▷ Δ₁';Δ₂'[m]`, in mathematics. Applied.

### Numbers

#### Q-NUM-101 — Which other kinds complete the list?

**Object.** Kept so far: `int`, `nat`, `flo`, `dec`, `fix`, `com`, `rat` and exact reals (Q-NUM-001), and the list must be complete. These are the kinds found in standards and languages, every one computable (Q-LEX-002). Three-letter names are proposals.

**Facts.**

- Not listed, because not computable in general: hyperreals and surreal numbers.

Several options may be chosen.

- **big — big — unbounded integers.** Arbitrary precision: Julia `BigInt`, Scheme exact integers (Julia manual (https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/)).
- **mod — mod — modular integers.** Arithmetic wraps around a modulus: Ada `mod` types, RM 3.5.4 (Ada RM (https://www.adaic.org/resources/add_content/standards/05aarm/html/AA-3-5-4.html)).
- **dfx — dfx — decimal fixed point.** A scale that is a power of ten, for money: Ada `delta … digits`, RM 3.5.9 (Ada RM (https://www.adaic.org/resources/add_content/standards/05aarm/html/AA-3-5-9.html)).
- **bfl — bfl — bfloat16.** 8 exponent bits, 7 fraction bits; the first 16 bits of a `flo32`.
- **f8 — 8-bit floats E4M3 and E5M2.** OCP 8-bit Floating Point Specification (OFP8), revision 1.0, 2023. Name to choose.
- **pos — pos — posits.** Standard for Posit Arithmetic (2022), Posit Working Group; posit8 to posit32 and their quires.
- **itv — itv — intervals.** IEEE Std 1788-2015, Standard for Interval Arithmetic, and its simplified subset 1788.1-2017.
- **qua — qua — quaternions (and octonions).** Boost.Math `quaternion` and `octonion`.
- **dua — dua — dual numbers.** `a + bε` with `ε² = 0`, the carrier of forward automatic differentiation.
- **gau — gau — Gaussian integers.** Complex numbers with integer parts.
- **alg — alg — exact algebraic numbers.** Exact arithmetic on roots of polynomials: SageMath `QQbar` (Sage reference (https://doc.sagemath.org/html/en/reference/number_fields/sage/rings/qqbar.html)).
- **pad — pad — p-adic numbers.** To a chosen precision, as in number theory systems.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-010), given in the clickable questionnaire, quoted as given.**

- **Choice:** mod, dfx, bfl, f8, pos, itv, qua, dua, gau, alg, pad
- **Clarification:** f8 is specific but remains flo8
- **Justification:** big étant arbitraire (soit du fait de l'implémentation) je le refuse => un typed hole évite un choix arbitraire
- **Reading:** the kinds `mod`, `dfx`, `bfl`, the 8-bit floats, `pos`, `itv`, `qua`, `dua`, `gau`, `alg` and `pad` complete the list; the 8-bit floats remain `flo8`. Unbounded integers (`big`) are refused: their bound would be arbitrary or set by the implementation, and a typed hole avoids the arbitrary choice. How the two 8-bit formats are told apart, and the name of exact reals, are put in the fourth part (Q-NUM-201, Q-NUM-202).

#### Q-NUM-102 — Which floating-point widths?

**Facts.**

- IEEE 754-2019: basic formats binary32, binary64, binary128, decimal64, decimal128; interchange formats binary16, binary256, decimal32, and any multiple of 32 bits (Wikipedia, IEEE 754, secondary source).

- **A — The basic formats.** Example: `flo32 flo64 flo128   dec64 dec128`.
- **B — Basic and interchange formats.** Example: `flo16 flo32 flo64 flo128 flo256   dec32 dec64 dec128`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-011), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** floating-point widths are the basic and interchange formats of IEEE 754-2019: `flo16`, `flo32`, `flo64`, `flo128`, `flo256`, `dec32`, `dec64`, `dec128`.

#### Q-NUM-103 — Which integer widths?

**Facts.**

- Julia: `Int8` to `Int128`, `UInt8` to `UInt128`.
- Zig: « arbitrary bit-width integers can be referenced by using an identifier of `i` or `u` followed by digits », up to 65535 bits (Zig 0.14.0 reference (https://ziglang.org/documentation/0.14.0/)).

- **A — Powers of two, 8 to 128.** Example: `int8 int16 int32 int64 int128`.
- **B — Powers of two, 8 to 256.** Example: `… int256`.
- **C — Any width.** Example: `int7 int24 nat12`. *For:* exact layouts for protocols and hardware registers.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-012), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** integers take any width: `int7`, `int24`, `nat12`.

#### Q-NUM-104 — Does fix count the sign bit?

**Object.** `fix4.16`: 4 bits before the point, 16 after (Q-NUM-004).

**Facts.**

- Q notation, Texas Instruments variant: the sign bit is « not counted in the m parameter »; ARM variant: « the m number also counts the sign bit »; a `U` prefix marks an unsigned format, `UQ` (Wikipedia, Q (number format), secondary source).

- **A — Signed, the sign counted in the integer bits.** Example: `fix4.16  =  20 bits, sign included (ARM)`.
- **B — Signed, the sign added.** Example: `fix4.16  =  21 bits (Texas Instruments)`.
- **C — Unsigned, a property for signed.** Example: `fix4.16 unsigned,   :num fix4.16 :signed`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-013), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a fixed-point type is signed and its integer bits count the sign bit (ARM convention): `fix4.16` is 20 bits.

#### Q-NUM-105 — Which literal forms?

**Object.** How a number is written in a text, whatever its type (Q-LEX-002 keeps the usual written form).

Several options may be chosen.

- **dec — Decimal with a fraction.** What the reader reads today. Example: `42   -2   3.25`.
- **exp — Exponent.** Example: `1.5e-3`.
- **radix — Radix prefixes.** Example: `0x1F   0b1010   0o17`.
- **sep — Digit separator.** Example: `1_000_000`.
- **rat — Rational.** Example: `1/3`.
- **com — Complex.** Example: `3+4i`.
- **spec — Infinities and NaN.** Example: `inf   -inf   nan`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-014), given in the clickable questionnaire, quoted as given.**

- **Choice:** dec, exp, sep, rat, com, spec
- **Justification:** Radix et autre registres de classifications sont plutot destinés à créer des matrices de nombres et pourra être modélisés pour instrumenter la couche 3
- **Reading:** literals: decimal with a fraction, exponent, digit separator `_`, rational `1/3`, complex `3+4i`, `inf`, `-inf` and `nan`. Radix prefixes are refused: radixes and other registers of classification rather serve to build matrices of numbers, and may be modelled to instrument layer 3. Applied to `lexicon/syntax/tokens.k`.

### Strings

#### Q-STR-101 — Which escapes?

**Object.** Backslash escapes (Q-STR-001). `\"` and `\\` are needed anyway.

**Facts.**

- Rust: `\'` `\"`, `\x41` (two hex digits, up to 0x7F), `\n` `\r` `\t` `\\` `\0`, `\u{7FFF}` (« up to 6 hex digits », a Unicode scalar value) (Rust reference (https://doc.rust-lang.org/reference/tokens.html)).
- Tcl: `\a` `\b` `\f` `\n` `\r` `\t` `\v` `\\`, octal `\ooo`, `\xhh`, `\uhhhh`, `\Uhhhhhhhh` (Tcl(n), rule 9 (https://core.tcl-lang.org/tcl/doc/core-8-6-branch/doc/Tcl.n)).

Several options may be chosen.

- **nrt — \n \r \t.** Line feed, carriage return, tab.
- **nul — \0.** The null character.
- **ctl — \a \b \f \v \e.** Bell, backspace, form feed, vertical tab, escape.
- **uni — \u{…}.** A Unicode scalar value, 1 to 6 hex digits (Rust).
- **hex — \xHH.** A byte or an ASCII character, two hex digits.
- **oct — \ooo.** Octal, one to three digits (Tcl, C).

**Answer of the author — 2026-10-27 (VOC-2026-10-27-015), given in the clickable questionnaire, quoted as given.**

- **Choice:** CLARIFY
- **Clarification:** Besoin d'explications car je ne comprend pas trop les divergences de paradigme, est-ce qu'ici nous pourrions "simplement" suivre la norme POSIX ?
- **Reading:** clarification asked: the author does not see why the languages differ, and asks whether K7PL could simply follow POSIX. Answered, with the POSIX escapes, in the fourth part (Q-STR-201).

#### Q-STR-102 — What does an unknown escape do?

**Object.** For example `\q`.

- **A — Refused.** A reading error with its code, as Rust does. *For:* every escape means something.
- **B — The backslash is dropped.** Tcl: « the backslash is dropped and the following character is treated as an ordinary character ».
- **C — Kept as written.** The backslash and the character stay in the string.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-016), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** an unknown escape is refused, as Rust does. Its code is put in the fourth part (Q-STR-205).

#### Q-STR-103 — Line breaks inside a literal: the trade-offs

**Object.** Q-STR-002 was kept open for an evaluation. Here each option is weighed along the M-A sequence. Two facts bear on all of them: heredocs exist for long texts (Q-STR-004), and the balance reader reports a fault at the line of the delimiter at fault.

- **A — A character of the string (Emacs Lisp).** *For:* exactness: what is seen is the value; brevity. *Against:* non-collision: a forgotten quote swallows the rest of the text, and the error is found at the end of the file, far from the slip; diffs of literals spread over lines.
- **B — Dropped after a backslash (Emacs Lisp, Tcl).** *For:* long lines can be folded. *Against:* a space after the backslash changes the meaning invisibly (Parinfer's `eol-backslash`); a forgotten quote still swallows the text.
- **C — Dropped after an underscore (Unicon).** *For:* a visible continuation mark. *Against:* a reading rule of its own; same forgotten-quote cost as A.
- **D — Forbidden; literals joined across lines (SQL).** *For:* non-collision: an unclosed quote is reported on its own line; every line of a text is read the same way; long texts go to heredocs. *Against:* a long literal is written as pieces; the joining rule is one more rule.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-017), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Important pour les docstrings
- **Reading:** a line break inside a literal is a character of the string, as in Emacs Lisp; the author notes it matters for docstrings. This is what the readers already read.

#### Q-STR-104 — How is a raw string written?

**Object.** Q-STR-004 keeps a raw form. Its delimiters must not be `( )`, `[ ]`, `{ }` (layers), `;` (comments) or a sigil (`#`, `:`, `@`, `?`, `!`).

**Facts.**

- Rust: « Raw string literals do not process any escapes », `r"…"` and `r#"…"#` with up to 255 `#` (Rust reference (https://doc.rust-lang.org/reference/tokens.html)).
- Raku: « in the plain `Q` form, backslash escapes aren't allowed »; `｢…｣` is its shortcut (Raku, Quoting (https://docs.raku.org/language/quoting)).
- Swift and C# delimit raw strings with `#"…"#` and with three or more quotes.

- **A — Corner brackets ｢…｣ (Raku).** Example: `｢C:\path\no\escape｣`. *For:* no ASCII collision; can nest. *Against:* non-ASCII: typed through the editor or a formatter.
- **B — A prefix r (Rust).** Example: `r"C:\path"   r#"he said "hi""#`. *Against:* `r` glued to a string changes meaning; `#` is the comptime sigil.
- **C — Backquotes (Go).** Example: ``C:\path\no\escape``. *For:* ASCII, one character, free in K7PL. *Against:* a raw string cannot hold a backquote.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-018), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** Double quote qui doivent se remplacer par les corner de Raku `""raw "string" writen""` : remplacement donc sémantiquement équivalent.
- **Justification:** Concernant les path : j'aimerais que leurs syntaxe soient valides inline `from dos c/user/username/downloads` où "dos" réfère aux familles d'os windows, et peut être remplacé par bsd ou autres.
- **Reading:** a raw string is written between doubled double quotes, `""raw "string" writen""`, an ASCII stand-in for Raku's corner brackets and equivalent to them. The author also wants paths valid inline, `from dos c/user/username/downloads`, where `dos` names the Windows family of systems and can be replaced by `bsd` or another family. The collision of `""` with the empty string and the inline paths are put in the fourth part (Q-STR-202, Q-STR-203).

#### Q-STR-105 — How is a heredoc written?

**Facts.**

- Java text blocks: `"""` then a line break; « the position of the closing `"""` characters does have an effect if placed on its own line » (JEP 378 (https://openjdk.org/jeps/378)); C#: « Any whitespace to the left of the closing quotes is removed from all lines » (C# reference (https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/raw-string)).
- Raku heredocs `q:to/END/`: « If the terminator is indented, that amount of indention is removed »; Perl 5.26 `<<~` does the same.
- Zig: « Multiline string literals have no escapes and can span across multiple lines », each line starting with `\\` (Zig reference (https://ziglang.org/documentation/0.14.0/)).

- **A — Triple quotes (Java, C#, Swift).** *For:* no terminator word; the closing quotes set the indentation to remove. *Against:* a forgotten closing `"""` swallows the rest of the text.

  ```text
  """
      first line
      second line
      """
  ```

- **B — A terminator word (Raku, Perl).** *Against:* the opening form is still to design; `<<` would be two glyphs (Q-LEX-201).

  ```text
  (heredoc END)
      first line
      END
  ```

- **C — A prefix on every line (Zig).** *For:* each line is read alone: nothing can swallow the text; no indentation rule. *Against:* a mark on every line.

  ```text
  \\first line
  \\second line
  ```


**Answer of the author — 2026-10-27 (VOC-2026-10-27-019), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:**

  > Zig propose la méthode la plus claire mais elle reste à harmoniser avec les backslash, j'aimerais éviter de changer le sens sémentique des symboles et si \ indique un escape alors que signifie \\ ? Dans ce cas je préfèrerais un symbole sémantiquement correct pour indiquer du text comme § par exemple qui en plus se trouve disponible sur de nombreux layout de claviers.
  >
  > Cela donnerait :
  > §Fist line
  > §second line
  >
  > Comment fait TeX ? Comment font d'autres langages de script ? Éventuellement les Array languages et autres Lisp.

- **Reading:** kept open. Zig's line prefix is the clearest, but `\\` would give the backslash, an escape, a second meaning; the author prefers a mark that means text, such as `§`, available on many keyboard layouts (`§First line` then `§second line`), and asks how TeX, other scripting languages, array languages and Lisps do it. Researched in the fourth part (Q-STR-204).

### Error codes

#### Q-ERR-101 — Where do an unclosed string and a quote in a comment go?

**Object.** Q-LEX-006-a gives them codes; Q-ERR-001 names the segment of the delimiters `ERR-DLM`. The reader does not give them a code yet: a text with an unclosed string is refused by the K parser.

**Facts.**

- In K7PL a comment runs to the end of its line, so a quote inside it never opens a string. Parinfer's `quote-danger` guards its own inference of parentheses, which K7PL does not do.

- **A — Both in ERR-DLM.** A quote delimits a string: `ERR-DLM-004` an unclosed string, `ERR-DLM-005` an odd number of quotes in a comment.
- **B — A segment of their own.** For example `ERR-STR`.
- **C — The unclosed string in ERR-DLM; no code for the comment.** Given the fact above.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-020), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** an unclosed string gets a code in `ERR-DLM`; an odd number of quotes in a comment gets none, since a comment runs to the end of its line. Applied: `ERR-DLM-004`, its message a proposal.

#### Q-ERR-102 — The recovery rule and the three messages

**Object.** What `lexicon/syntax/balance.k` does now, from your answer to Q-LEX-006-d, and the messages of annex A, section A.8, which are proposals.

**Facts.**

- A closer of the pair of the innermost open delimiter closes it.
- A closer whose pair is open further out closes that one; the delimiters opened since are reported `ERR-DLM-001`, never closed.
- A closer whose pair is not open closes nothing: `ERR-DLM-003`, at the closer, naming the innermost open delimiter; with nothing open, `ERR-DLM-002`.
- At the end of the text, each delimiter still open is reported `ERR-DLM-001`, in the order they opened.
- `ERR-DLM-001` « Délimiteur ouvrant jamais refermé. Ajouter le délimiteur fermant de sa paire, ou retirer l'ouvrant. »
- `ERR-DLM-002` « Délimiteur fermant sans délimiteur ouvrant. Retirer le fermant, ou ajouter l'ouvrant de sa paire. »
- `ERR-DLM-003` « Délimiteur fermant d'une autre paire que les délimiteurs encore ouverts. Fermer le dernier délimiteur ouvert par le fermant de sa paire. »

- **A — Confirm the rule and the messages.**
- **B — Confirm the rule; messages changed in Other.**
- **C — Change the rule (Other or Clarify).**

**Answer of the author — 2026-10-27 (VOC-2026-10-27-021), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** the recovery rule and the messages of `ERR-DLM-001` to `ERR-DLM-003` are confirmed.

## Lot of 2026-10-27, fourth part: escapes, raw strings, paths, heredocs, types, bind, numbers, empty and doubled delimiters

Questions opened by the answers to the third part, and, at the author's request, the empty and doubled delimiters. They follow the
same rules: options to enumerate and objectify, then the author's
choice; **Other** and **Clarify** are always available. The
options were built from the research recorded in
[research](research.md), "Reading lot: research of 2026-10-27, fourth part".

Words of the examples that no answer has fixed yet (`defn`, `fn`, `field`, `from`…) are placeholders.

### Strings

#### Q-STR-201 — Escapes, explained, and POSIX

**Object.** You asked why languages differ, and whether K7PL could simply follow POSIX. An escape list answers three needs: writing the quote and the backslash themselves; writing control characters (line feed, tab…); writing any character by its number. Languages agree on the first need. On the second they differ by history: the C list comes from the controls of terminals. On the third they differ by what a string is: a sequence of bytes (C, POSIX: `\xHH` and `\ddd` give a byte) or of Unicode characters (Rust, Raku: `\u{…}` gives a code point). Every other escape is refused (Q-STR-102).

**Facts.**

- POSIX defines two lists. The File Format Notation: `\\` `\a` `\b` `\f` `\n` `\r` `\t` `\v` (POSIX.1-2024, XBD chapter 5 (https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap05.html)). The shell's dollar-single-quotes `$'…'` add `\"` `\'` `\e` `\cX` `\xXX` `\ddd` (bytes), and « The behavior of an unescaped <backslash> immediately followed by any other character, including <newline>, is unspecified » (POSIX.1-2024, Shell Command Language (https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html)).
- Rust: `\n` `\r` `\t` `\\` `\0` `\'` `\"`, `\x41` up to 0x7F only, `\u{…}` a Unicode scalar value (Rust reference (https://doc.rust-lang.org/reference/tokens.html)).

- **A — POSIX File Format Notation, and the quote.** Example: `\\  \"  \a  \b  \f  \n  \r  \t  \v`. *For:* a published standard list; every escape is a character. *Against:* no way to write a character by its number.
- **B — POSIX dollar-single-quotes.** Example: `\"  \'  \\  \a  \b  \e  \f  \n  \r  \t  \v  \cX  \xHH  \ddd`. *For:* the fullest POSIX list. *Against:* `\xHH` and `\ddd` give bytes: a string could hold bytes that are not text.
- **C — A, plus Unicode code points.** Example: `\\  \"  \a  \b  \f  \n  \r  \t  \v  \u{…}`. *For:* the POSIX controls, and any character by its code point, never a stray byte. *Against:* `\u{…}` comes from Rust, not POSIX.
- **D — Rust's list.** Example: `\\  \"  \'  \n  \r  \t  \0  \x41  \u{…}`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-022), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** Explorons encore d'autres traditions dans les langages, celles-ci ne me satisfont pas. documentons les tout de même pour pouvoir les comparer avec d'autres approches.
- **Reading:** kept open: the author is not satisfied by these traditions; others are to be explored, and all of them documented so that they can be compared with other approaches. Researched in the fifth part (Q-STR-301).


#### Q-STR-202 — Raw strings and the empty string

**Object.** Q-STR-104: a raw string is written between doubled double quotes, `""raw "string" writen""`. But `""` is also the empty string: the reader must tell `(f "" x)` from a raw string that opens.

- **A — "" then a character opens a raw string.** `""` followed by a space, a delimiter or the end of a line is the empty string; followed by any other character, it opens a raw string, which closes at the next `""`. *Against:* a raw string can neither start with a space nor hold `""`.

  ```text
  (f "" x)          ;; the empty string
  (f ""C:\path"" x)  ;; a raw string
  ```

- **B — Three quotes.** As C# and Python: the empty string stays `""`. Example: `"""raw "string" writen"""`. *For:* no collision; the content may hold `""`. *Against:* one quote more than your form; `"""` is also a heredoc candidate (Q-STR-204).
- **C — Corner brackets in the text, "" only typed.** The file holds `｢…｣`; the editor or the formatter turns `""…""`, as typed, into corner brackets. *For:* no collision in the text. *Against:* non-ASCII characters in the files; a formatter becomes part of the toolchain.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-023), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** traiter le sujet des string de manière homogène entre "" "sting" ""string"" et """string"""
- **Reading:** kept open: strings are to be treated homogeneously across `""`, `"string"`, `""string""` and `"""string"""`. A homogeneous design is put in the fifth part (Q-STR-302).


#### Q-STR-203 — Paths written inline

**Object.** Your wish (Q-STR-104): `from dos c/user/username/downloads`, where `dos` names the Windows family of systems and can be replaced by `bsd` or another family. The reader already reads `c/user/username/downloads` as one symbol: it holds no space and no delimiter.

**Facts.**

- Rebol: « The percent sign is necessary to prevent file names from being interpreted as words »; backslashes are converted to forward slashes; a drive is written `%/C/docs/file.txt`; a name with spaces goes in quotes, `%"cool movie clip.mpg"` (REBOL/Core guide, Files (https://www.rebol.com/docs/core23/rebolcore-12.html)).
- Nix: « A path literal must contain at least one slash to be recognised as such » (Nix manual, syntax (https://nix.dev/manual/nix/2.24/language/syntax)).

- **A — A symbol with slashes, given its family by a form.** Example: `(from dos c/user/username/downloads)`. *For:* no new reading rule. *Against:* a path that holds a space or a delimiter cannot be written.
- **B — A path mark, Rebol style.** Example: `(from dos %c/user/username/downloads)   (from bsd %"My Documents/notes")`. *For:* a path is a lexical class: the reader knows it; spaces through quotes. *Against:* `%` becomes a mark of its own.
- **C — Nix's rule.** Any atom holding a slash is a path. *For:* no mark. *Against:* spaces cannot be written; `1/3` must stay a number.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-024), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** option A mais avec l'encodage HTTP pour les espaces.
- **Reading:** a path is a symbol with slashes, given its family of systems by a form (option A); a space in a path is written with the percent-encoding of URLs, `%20`. The reader already reads such a path as one symbol; a probe of `tests/lexical/` checks it.


#### Q-STR-204 — Heredocs: § and the others

**Object.** Your proposal: each line of a heredoc starts with `§` (U+00A7), like Zig's `\\` without giving the backslash a second meaning. Ordinary strings already span lines (Q-STR-103); a heredoc adds a text without escapes, whose indentation is not part of the text.

**Facts.**

- TeX: the `verbatim` environment ends at `\end{verbatim}`, whose content « cannot include the string `\end{verbatim}` »; « carriage returns and blanks are taken literally » (LaTeX2e reference (https://latexref.xyz/verbatim.html)).
- Racket here strings `#<<END`: the body ends before a line holding only the terminator; « No escape sequences are recognized » (Racket reader (https://docs.racket-lang.org/reference/reader.html)).
- Lua long brackets `[[…]]`, `[==[…]==]`: no escapes, a first line break dropped (Lua 5.4 manual (https://www.lua.org/manual/5.4/manual.html)). J `0 : 0` (`noun define`): « the entry is terminated by a lone right parenthesis » (J Dictionary, II.H Scripts (https://www.jsoftware.com/help/dictionary/dicth.htm)).
- Python triple quotes: « Unescaped newlines are also allowed and retained » (Python reference (https://docs.python.org/3/reference/lexical_analysis.html)). Common Lisp: a string accumulates characters « until another double-quote is encountered », line breaks included (CLHS 2.4.5 (https://www.lispworks.com/documentation/HyperSpec/Body/02_de.htm)).
- In K7PL, `[[…]]` and `)` are layer delimiters and `#` the comptime sigil: Lua's, J's and Racket's forms collide.

- **A — § at the start of each line (your proposal).** The text of a line is what follows `§`; the lines are joined by line breaks; no escape; what precedes `§` is indentation, not text. *For:* each line is read alone: nothing can swallow the text; no indentation rule. *Against:* `§` is non-ASCII; a reading rule of its own, like `;;` for comments.

  ```text
  §First line
  §second line
  ```

- **B — Triple quotes (Python, Java, C#).** *For:* familiar. *Against:* a forgotten closing `"""` swallows the rest of the text.

  ```text
  """
      First line
      second line
      """
  ```

- **C — A terminator word, given by a form.** *Against:* the form and its word are still to design.

  ```text
  (text END)
  First line
  second line
  END
  ```

**Answer of the author — 2026-10-27 (VOC-2026-10-27-025), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** je préfère préserver l'emploi des `"` pour le texte car les utilisateurs le comprennent.
- **Reading:** a heredoc is written between triple quotes, as in Python, Java and C#: the double quote stays the mark of text, which users understand. How it fits with the other string forms is part of Q-STR-302.


#### Q-STR-205 — The code of an unknown escape

**Object.** Q-STR-102: an unknown escape is refused. `ERR-DLM` names delimiters (Q-ERR-001), which an escape is not.

- **A — A segment for strings: ERR-STR.** Example: `ERR-STR-001  unknown escape`.
- **B — A segment for lexical errors: ERR-LEX.** Which later reading errors of a token would join.
- **C — In ERR-DLM.** The escape lives between the delimiters of a string. *Against:* the segment no longer names one invariant.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-026), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** lexical errors, an unknown escape among them, form the segment `ERR-LEX`. Its first code waits for the list of escapes (Q-STR-301).


### Types in K7PL

#### Q-TYP-201 — How are type names written? Other ways

**Object.** You kept Q-TYP-101 open, expecting other ways than lowercase and capitalised names. Number types are written `int32`, as a property `:num`; chapter 1 (`tab:dimensions`) gives layer 1 a Lisp-2 namespace, with separate spaces.

**Facts.**

- Common Lisp writes types in lowercase, `integer`, `(function (integer) integer)` (CLHS, function (https://www.lispworks.com/documentation/HyperSpec/Body/t_fn.htm)); Typed Racket capitalises base types joined by hyphens, `Integer`, `Exact-Rational` (Typed Racket reference (https://docs.racket-lang.org/ts-reference/type-ref.html)).
- C and POSIX mark many type names with a suffix, `size_t`, `pid_t`.

- **A — Lowercase; the namespace of layer 1 tells types apart.** Example: `{vector n t}   {result int32 overflow}`. *For:* one case, as `int32`; the Lisp-2 namespace of layer 1 already separates types and values. *Against:* nothing in the text marks a type.
- **B — Capitalised words joined by hyphens (Typed Racket).** Example: `{Vector n T}   {Result int32 Overflow}   {Exact-Rational}`. *Against:* two cases; `int32` stays lowercase.
- **C — Every type position opened by a property.** Names stay lowercase; a type appears only after a property that announces it (`:num`, `:type`…), so the reader of the text always knows. Example: `{field value :num int}   {defn f :type {fn int32 {result int32 overflow}}}`. *Against:* a property to choose for each kind of position.
- **D — A suffix.** Example: `{vector-t n t}   {result-t int32 overflow-t}`. *Against:* a suffix on every type name; `int32` would break the rule.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-027), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:**

  > L'option C reste ce qu'il y a de plus proche de la notion "typer une fonction c'est préparer un objet immuable" et que "K7PL préfère la clarté à la concision"
  >
  > par contre, les définitions il faudrait prévoir un mot comme Racket "define" générique qui permette de créer des enveloppe guides pour defhandler defunc defanything ce qui permet de proposer un defunc qui possède déjà son type de fonction, une définition composée permettrait ainsi d'élaborer des types raffinés. Toujours pas de l'objet mais très proche sans mutation

- **Reading:** type names stay lowercase and a type appears only after a property that announces it (`:num`, `:type`…), the closest to « typer une fonction c'est préparer un objet immuable » and to K7PL's preference for clarity over brevity. Applied to the prose of chapter 5. The author also asks for a generic definition word, like Racket's `define`, from which guided envelopes are built (`defhandler`, `defunc`, `defanything`): a `defunc` would carry its function type, and a composed definition would build refined types — not objects, but close to them, without mutation. Researched in the fifth part (Q-SPEC-203).


#### Q-TYP-202 — The lemma of a function type

**Object.** Q-TYP-103: a function type is written flat, parameters then result, after a true lemma. Weighed along the M-A sequence.

**Facts.**

- Chapter 3 writes computation types `V ⊸ C`, and chapter 2 the internal hom `[A ⊸ B]` beside `Hom`.
- Common Lisp: `(function (integer) integer)`; Typed Racket: `(-> Integer Integer Integer)`, the last type being the result; Carp: `(Fn [Int] Int)`.
- `lambda` is the preferred lemma of the abstraction `Lam` (VOC-2026-10-26-002), whose candidates included `fn` and `fun`.

- **A — function.** Example: `{function int32 int32 {result int32 overflow}}`. *For:* exact: the type of functions; Common Lisp's word. *Against:* the longest.
- **B — fn.** Example: `{fn int32 int32 {result int32 overflow}}`. *For:* brief; Carp, Rust. *Against:* non-collision: a candidate for `Lam`, which is the abstraction, not its type.
- **C — arrow.** Example: `{arrow int32 int32 {result int32 overflow}}`. *For:* names the arrow of the theory. *Against:* the theory's arrow is `⊸`, linear, not `→`.
- **D — hom.** Example: `{hom int32 int32 {result int32 overflow}}`. *For:* the word of chapter 2 for morphisms. *Against:* a categorical word in programs.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-028), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** the head of a function type is `function`: `{function int32 int32 {result int32 overflow}}`. Applied to the listings of chapter 5.


#### Q-TYP-203 — Polymorphism forbidden: what remains of ∀?

**Object.** Q-TYP-102: « Polymorphisme est interdit en K7PL => tout est monomorphé. » Chapter 3 has type quantification: `∀α. C` in the grammar of types, `Λα. c` and `c[W]` among the terms, with their typing rules.

**Facts.**

- MLton: « Monomorphisation eliminates polymorphic values and datatype declarations by duplicating them for each type at which they are used » (MLton guide, Monomorphise (https://github.com/MLton/mlton/blob/master/doc/guide/src/Monomorphise.adoc)).
- rustc limits « the maximum number of type substitutions allowed when constructing a concrete type during monomorphization » (Rust reference, limits (https://doc.rust-lang.org/reference/attributes/limits.html)); an unbounded chain of instances fails with « reached the recursion limit while instantiating » (rustc 1.80.0, messages.ftl (https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_monomorphize/messages.ftl)).

- **A — Polymorphism at compile time only.** `∀` stays in the calculus; every instance is made at compile time, so no polymorphic value exists at run time; a definition that would need infinitely many instances is refused. *For:* chapter 3 keeps its rules.
- **B — No type quantification.** Every type is written concrete; `∀α. C`, `Λα. c` and `c[W]` leave chapter 3. *Against:* a change of the core calculus and of its proofs.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-029), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Other:** lis les pièces fournis dans la justification, elles décrivent précisément le fonctionnement attendu. ensuite MLton et rustc proposent 2 approches complémentaires de la monomorphisation. K7PL essais de synthétiiser les bonnes idées donc on peut trouver un fonctionnement cohérent.
- **Clarify:** Il serait pertinent que tu référence d'autres mécanismes de monomorphisation, que tu en explore les avantages, limites, inconvénients, opportunités et que tu essais de proposer un mécanisme qui tire le meilleur de tout cela en essayant de ne pas dénaturer la spec qui elle se base sur une revue de littérature scientifique rigoureuse et donne les objectifs à atteindre.
- **Justification:**

  > tes propositions semble ne pas tenir compte du processus décrits dans la spécification : https://anthealiles.github.io/k7pl/find/?domain=Verso.Genre.Manual.section&name=c6-le-processus-de-compilation
  > https://anthealiles.github.io/k7pl/find/?domain=Verso.Genre.Manual.section&name=c6-ce-que-le-solveur-retourne

- **Reading:** kept open. The author points to the two sections of chapter 6 that describe the expected process, the compilation process and what the solver returns, notes that MLton and rustc offer two complementary approaches to monomorphisation, and asks for other mechanisms with their advantages, limits, drawbacks and opportunities, then for a proposed mechanism that keeps the best of them without distorting the specification, which rests on a review of the literature and sets the goals. Researched in the fifth part (Q-TYP-301).


### bind-to

#### Q-SPEC-101 — The lemma for Haskell's >>=

**Object.** Q-SPEC-001: `bind-to` is not a lemma that was weighed; it stands for Haskell's `>>=`.

**Facts.**

- Rust's `Option::and_then`: « Some languages call this operation flatmap » (Rust std (https://doc.rust-lang.org/std/option/enum.Option.html)).
- Written `>>=`, it would read as a train of three glyphs (Q-LEX-201).

- **A — bind.** *For:* the name of the operation in the theory of monads.
- **B — and-then.** *For:* reads as a sequence (Rust).
- **C — flat-map.** *For:* names what it does on collections.
- **D — then.** *For:* the shortest. *Against:* says nothing of the value passed on.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-030), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:**

  > de mon point de vue, les constructions monadiques sont des "branchements" explicites déclarés avec le préfixe ":" donc ":bind something" et ":return somethingelse"
  >
  > je pense que nous manquons encore de l'inventaire complet des "branchement" (co)monadiques sans oublier l'héritage de CLOS avec les méthodes :around :before et :after ainsi que les divers lemmes exprimés dans la  spec/ autour des ressources, du temps etc.

- **Reading:** the lemma is `bind`. Monadic constructions are explicit branchings declared with the prefix `:`, as `:bind something` and `:return somethingelse`. The complete inventory of (co)monadic branchings is still missing, CLOS's `:around`, `:before` and `:after` methods included, with the lemmas of the specification about resources, time and so on. Inventory in the fifth part (Q-SPEC-201).


#### Q-SPEC-102 — What the prose of lst:acteur says

**Object.** Chapter 5 reads `bind-to` otherwise: « Un acteur est la paire additive dépendante (état : S) & Handler(S) du chapitre 3, et `bind-to` n'est qu'un accès de champ », the elaborator filling the handler by type-directed search when it is omitted.

- **A — Rewrite it as a monadic bind.** The actor's state is bound to its handler as by `>>=`; the prose is rewritten from that reading.
- **B — Keep the reading, change the lemma.** The form stays an access to the second component of the pair; only its lemma changes (Q-SPEC-101).

**Answer of the author — 2026-10-27 (VOC-2026-10-27-031), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:**

  > nous devons ajuster la construction en code K7PL pour faire porter la responsabilité au bon périmètre :
  > a) dans un handler je bind des acteurs `{defhandler beta :bind actor-name}`
  > a) dans un acteur je bind des fonctions productives ou terminante `{defactor actor-name :bind (selection algorythm) :result [transformation algorythm]}` => ceci est un exemple biensur

- **Reading:** the code is adjusted so that responsibility lies at the right perimeter: a handler binds actors, `{defhandler beta :bind actor-name}`; an actor binds productive or terminating functions, `{defactor actor-name :bind (selection algorythm) :result [transformation algorythm]}` (an example). The rewrite of `lst:gestionnaire` and `lst:acteur`, with their prose, is put to the author in the fifth part (Q-SPEC-202).


### Numbers

#### Q-NUM-201 — Two 8-bit floats

**Object.** E4M3 and E5M2 (OCP OFP8) both take 8 bits; Q-NUM-101 names them `flo8`.

- **A — A property for the exponent bits.** Example: `:num flo8 :exp 4     :num flo8 :exp 5`.
- **B — Two names.** Example: `flo8e4   flo8e5`.
- **C — flo8 is one format, a property marks the other.** Example: `flo8 (E4M3)     :num flo8 :exp 5`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-032), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** spécifier une "default value" en cas d'oubli : flo8 = flo8e4 by default ; la corrolaire fixN = two floN/2 ; etc. et ajouter un Warning (pas une erreur) invitant à préciser le type
- **Reading:** the two 8-bit floats get two names, `flo8e4` and `flo8e5`; `flo8` alone means `flo8e4` by default, with a warning, not an error, inviting the programmer to give the format. The corollary is written « fixN = two floN/2 »: read as the complex numbers, `comN` being two `floN/2` (VOC-2026-10-26-023), to confirm in the fifth part (Q-NUM-301), with the codes of warnings.


#### Q-NUM-202 — The name of exact reals

**Object.** Irrationals such as π or √2, computed to any requested precision (Q-NUM-001).

- **A — rea.** *For:* real.
- **B — cre.** *For:* computable real, the name of the theory.
- **C — exr.** *For:* exact real.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-033), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** rea dans le code et on y applique les logiques de calculs de la théorie "cre"
- **Reading:** exact reals are named `rea` in code, and their computations follow the theory of computable reals (« cre »).


#### Q-NUM-203 — Typed holes: when and how are they resolved?

**Object.** Q-TYP-104 and Q-NUM-101: a kind without a width, such as `int`, is a typed hole resolved within its family.

- **A — From the uses, at compile time; refused if they fix no width.** A reading error with its code when nothing fixes the width.
- **B — The smallest width that holds every value the solver can bound.** Refused if the solver bounds nothing. *For:* the solver of chapter 6 already bounds values.
- **C — A default width per kind.** *Against:* the arbitrary choice that the hole is meant to avoid.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-034), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** a typed hole is resolved to the smallest width that holds every value the solver can bound; it is refused when the solver bounds nothing. Applied to the prose of chapter 5; the code of that refusal is put in the fifth part (Q-NUM-302).


### Empty and doubled delimiters

#### Q-LEX-301 — What does an empty pair mean?

**Object.** Your grammar repeats contents zero or more times (`{ square-content }`…), and `layers.k` reads `[]`, `()` and `{}`; nothing gives them a meaning yet. Inside a form, an empty pair is first an empty list of what the form expects at that place: `{defn ?now :type … [] …}` is a function without parameters, as Clojure's `(fn [] …)`. The question is what an empty pair means as an expression of its own.

**Facts.**

- Chapter 3 writes, in mathematics, the unit value `()` and the vector literal `[v₀, …, vₙ₋₁]`, whose empty case is `[]` (`eq:grammaire-termes`). In K7PL text, `()` opens layer 2 and `[]` layer 3. In category theory, a terminal object « may also be viewed as a limit over the empty diagram » (nLab, terminal object (https://ncatlab.org/nlab/show/terminal+object)): the empty product is the unit `1`.
- Common Lisp: `()` is « an alternative notation for writing the symbol nil, used to emphasize the use of nil as an empty list » (CLHS glossary (https://www.lispworks.com/documentation/HyperSpec/Body/26_glo_9.htm)). Scheme: « In many dialects of Lisp, the empty list, (), is a legitimate expression evaluating to itself. In Scheme, it is an error. » (R7RS, §4.1.3 (https://small.r7rs.org/attachment/r7rs.pdf)). Clojure: « An empty list () evaluates to an empty list. » (Clojure reference, evaluation (https://clojure.org/reference/evaluation)).
- Rust: the tuple type with no fields `()` « is often called unit »; « When a block does not contain a final operand and the block does not diverge, the block has unit type and unit value » (Rust reference, tuple types (https://doc.rust-lang.org/reference/types/tuple.html); block expressions (https://doc.rust-lang.org/reference/expressions/block-expr.html)). Haskell: « The unit datatype () has one non-⊥ member, the nullary constructor () » (Haskell 2010, §6.1.5 (https://www.haskell.org/onlinereport/haskell2010/haskellch6.html)). Python: `()` an empty tuple, `[]` an empty list, `{}` an empty dictionary (Python reference, §6.2 (https://docs.python.org/3/reference/expressions.html)).

- **A — The unit of each layer.** An empty pair is the neutral element of its layer: `[]` the unit value, pure (the `1` of the cartesian layer); `()` the computation that does nothing and gives the unit value (`return ()`); `{}` the unit type `1`, types being set in layer 1. *For:* one rule, and each meaning stays in the layer that owns it: values in layer 3, effects in layer 2, types in layer 1. *Against:* three different objects behind one shape.

  ```text
  []   ;; the unit value
  ()   ;; does nothing, gives []
  {}   ;; the unit type
  ```

- **B — The unit value everywhere.** Each empty pair is the unit value, checked in its layer, as Rust's empty block. *For:* simple; Rust, Haskell. *Against:* the delimiter tells nothing more.
- **C — Empty collections.** `[]` the empty vector (the vector literal of chapter 3), `()` the empty list, `{}` the empty record or map, as Clojure or Python. *Against:* K7PL delimiters announce layers, not data structures.
- **D — Refused as an expression of its own.** An empty pair stands only inside a form (no parameters, no fields); alone, it is a reading error with its code, and the unit value is written with a lemma, as Scheme refuses `()`. *For:* no implicit meaning. *Against:* a lemma for a frequent value; a new code.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-035), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** la couche est elle même une datastructure puisqu'elle prend la forme d'une arène linéraire en couche 1, d'un heap en couche 2 et d'une stack en couche 3 => c'est donc bien une datastructure. en complément, la forme vide porte le sens du fragment cartésien et donc des grades etc. qui doivent être respectés et donc vérifié au comptime.
- **Reading:** an empty pair is the empty data structure of its layer: `[]` the empty vector, `()` the empty list, `{}` the empty record or map. A layer is itself a data structure — a linear arena in layer 1, a heap in layer 2, a stack in layer 3 — and the empty form carries the meaning of its fragment, so its grades must hold and are checked at compile time. Applied to chapter 5.


#### Q-LEX-302 — What does a doubled pair mean?

**Object.** The grammar reads `[[e]]`, `((e))` and `{{e}}`: a block whose only element is a block of the same layer. By the head rule of S-expressions, the first element of a form is its operator: `((e))` would call the result of `(e)` with no argument. The listings of chapter 5 already open a match clause with a doubled parenthesis, `((Ok new-value) …)`, whose head is a pattern; chapter 2 writes `⟦·⟧` for a translation. You suggest ranges: `[[range]]`, a matrix range of Unicode characters, and `((1..9))`, a list.

**Facts.**

- Scheme: the operator of a call is any expression, `((if #f + *) 3 4) ⟹ 12` (R7RS, §4.1.3 (https://small.r7rs.org/attachment/r7rs.pdf)). Common Lisp allows only a lambda expression there: « A lambda form is similar to a function form, except that the function name is replaced by a lambda expression » (CLHS 3.1.2.1.2.4 (https://www.lispworks.com/documentation/HyperSpec/Body/03_ababd.htm)).
- Bash: `((expression))` evaluates an arithmetic expression, `[[ expression ]]` a conditional expression (bash(1) (https://man7.org/linux/man-pages/man1/bash.1.html)). C++: an attribute is written `[[ … ]]` (C++ draft, [dcl.attr.grammar] (https://eel.is/c++draft/dcl.attr.grammar)). Lua: `[[…]]` is a long string (Lua 5.4 manual (https://www.lua.org/manual/5.4/manual.html)); Org mode: `[[LINK]]` is a link (Org manual (https://orgmode.org/manual/Link-Format.html)).
- Agda: « Instance arguments are enclosed in double curly braces {{ }} » (Agda documentation (https://agda.readthedocs.io/en/latest/language/instance-arguments.html)); Lean 4 reads `{{x : Nat}}` as the strict implicit binder `⦃x : Nat⦄` (checked with Lean 4.34.0, the version of this repository). Mustache: « A {{name}} tag in a basic template will try to find the name key in the current context » (mustache(5) (https://mustache.github.io/mustache.5.html)); Rust's format strings escape `{` as `{{` (std::fmt (https://doc.rust-lang.org/std/fmt/index.html)).
- In French mathematics, an interval of integers is sometimes written with white brackets, `⟦−5, 3⟧` (Wikipédia, Intervalle (mathématiques) (https://fr.wikipedia.org/wiki/Intervalle_(math%C3%A9matiques)), secondary source).

- **A — The head rule, nothing more.** A doubled pair is a form whose head is a form: `((e))` calls the result of `(e)` with no argument; `[[e]]` likewise in layer 3; `{{e}}` is a block of declarations holding one block. Example: `((make-counter))   ;; calls the counter that (make-counter) returns`. *For:* no special case; Scheme. *Against:* `((e))` and `(e)` differ by a call that is easy to miss.
- **B — Grouping.** Doubling changes nothing: `((e))` is `(e)`, as parentheses in mathematics; a formatter removes the extra pair. *Against:* contradicts the head rule: in `((f x) y)` the inner form is an operator.
- **C — Refused when the inner block is alone.** A code for `((e))`, `[[e]]` and `{{e}}` with nothing else; `((Ok v) body)` stays valid. *For:* no ambiguity. *Against:* calling a returned function without argument needs a lemma.
- **D — Ranges and collections, by layer (your proposal).** A doubled pair writes a collection, by its elements or by a range, and its layer gives the kind: `[[…]]` a finite array or matrix, on the stack, computed in layer 3; `((…))` a list produced in layer 2, which may be unbounded; `{{…}}` a type, set in layer 1 (Q-LEX-303). *For:* each layer keeps its role: finite and terminating in layer 3, productive in layer 2, types in layer 1; close to the white brackets of French mathematics, `⟦1, 9⟧`. *Against:* a doubled pair is no longer read by the head rule; the range notation is to choose (Q-LEX-304).

  ```text
  [[1..9]]             ;; a vector of nine integers, layer 3
  [[1..3 1..3]]        ;; a 3×3 matrix of index pairs
  [[U+0041..U+005A]]   ;; the Latin capital letters
  ((1..9))             ;; a list, layer 2
  ((1..))              ;; an unbounded list, produced on demand
  {{1..31}}            ;; a type, layer 1 (Q-LEX-303)
  ```

- **E — Another notation per pair.** Each doubled pair gets a meaning of its own, chosen pair by pair: for example `[[e]]` the denotation `⟦e⟧` or a quotation, `{{e}}` an implicit argument (Agda, Lean). *Against:* three new notations, unrelated to each other.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-036), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** je préfère que `{{ atom }}` corresponde à `⦃ atom ⦄`, `(( atom ))` à `⦅ atom ⦆` et `[[ atom]]` à `⟦ atom ⟧` c'est à dire que ce soit sémantiquement équivalent.  mais que chaque forme doublée soit une précision ou forme spécifique dédiée à la couche source et dont l'usage permet d'apporter une précision forte sur une action mémorielle ou sur un grade ou sur une ressource ou autre => recherches à poursuivre => on peux considérer cela comme du sucre synthaxique ou comme une contrainte formelle pour accéder à un élément dont la modification doit être explicite (eg. utiliser une arene non standard, utiliser un schéma de résolution de graph de liste différent, augmenter le nombre de dimensions de l'array pour faire par exemple des cubes...)
- **Reading:** the doubled pairs are the white brackets: `{{ atom }}` is `⦃ atom ⦄`, `(( atom ))` is `⦅ atom ⦆` and `[[ atom ]]` is `⟦ atom ⟧`, with the same meaning. Each doubled form is a precision, a form dedicated to its source layer, stating a memory action, a grade, a resource or another aspect explicitly; it may be read as syntactic sugar, or as a formal constraint for reaching an element whose change must be explicit (another arena than the standard one, another resolution scheme for a list graph, more dimensions for an array, such as cubes). Applied to chapter 5. The reader does not read the white brackets yet: K's regular expressions cannot keep them out of symbols, so their spacing is put to the author in the fifth part (Q-LEX-404); the meanings are researched there too (Q-LEX-401 to Q-LEX-403).


#### Q-LEX-303 — With ranges: what does {{…}} hold?

**Object.** If doubled pairs write ranges and collections (Q-LEX-302, D), `{{…}}` lives in layer 1, where types are set. You ask what it holds.

**Facts.**

- Ada: « A range has a lower bound and an upper bound and specifies a subset of the values of some scalar type (the type of the range). » (Ada RM, 3.5 (https://www.adaic.org/resources/add_content/standards/22rm/html/RM-3-5.html)); « Discrete types are either integer types or are defined by enumeration of their values (enumeration types). » (Ada RM, 3.2 (https://www.adaic.org/resources/add_content/standards/22rm/html/RM-3-2.html)), as `type Color is (White, Red, Yellow, Green, Blue, Brown, Black);` (Ada RM, 3.5.1 (https://www.adaic.org/resources/add_content/standards/22rm/html/RM-3-5-1.html)).
- Chapter 3 writes refinement types `{x : T | p}`: a range type is the refinement `{x : int | 1 ≤ x ≤ 31}`.

- **A — A discrete type, by range or by enumeration.** `{{1..31}}` is the type of the integers from 1 to 31, `{{red amber green}}` the type of three values, as Ada's discrete types; the refinement of chapter 3 gives their meaning. *For:* types stay in layer 1; ranges and enumerations form one family; values come from `[[…]]` and `((…))`.

  ```text
  {field day :num {{1..31}}}
  {field light :type {{red amber green}}}
  ```

- **B — A set of values, known at compile time.** `{{1..9}}` is the set of the nine values, a constant computed at compile time. *Against:* a value set in layer 1, where types are set.
- **C — A repetition of declarations.** `{{…}}` repeats the declarations it holds for each value of a range, at compile time, as a macro would. Example: `{{i 1..4 {field reg-i :num int32}}}`. *Against:* a macro hidden in a delimiter; the declarations it makes are not in the text.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-037), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** idem Q-LEX-302
- **Reading:** kept open, as Q-LEX-302: what `{{…}}` holds follows from the meaning of the doubled forms (Q-LEX-401).


#### Q-LEX-304 — With ranges: how is a range written?

**Object.** Today the reader reads `1..9` as one symbol: it holds no space and no delimiter. A range notation is a lexical class to add, checked like the others by the probes of `tests/lexical/`.

**Facts.**

- Haskell: `[e1, e2 .. e3]`, the second element giving the step, and `[e1 ..]` without end (Haskell 2010, §3.10 (https://www.haskell.org/onlinereport/haskell2010/haskellch3.html)). Rust: `a..b` excludes `b`, `a..=b` includes it, `a..` has no end (Rust reference, range expressions (https://doc.rust-lang.org/reference/expressions/range-expr.html)). Raku: ranges are written with « two dots, and optionally a caret which indicates that the endpoint marked with it is excluded », `1 ..^5` (Raku documentation, Range (https://docs.raku.org/type/Range)). Ruby: `Range.new(2, 5).to_a # => [2, 3, 4, 5]`, and `Range.new(2, 5, true).to_a # => [2, 3, 4]` excludes the end (Ruby documentation, Range (https://docs.ruby-lang.org/en/master/Range.html)).
- Unicode writes its ranges with two dots: « 0000..007F; Basic Latin » (Unicode Character Database, Blocks.txt (https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt)). POSIX regular expressions write a character class such as `[:alpha:]` inside a bracket expression, hence `[[:alpha:]]` (POSIX.1-2024, XBD chapter 9 (https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap09.html)).
- BQN's Range `↕`, given a list of lengths, « returns an array of index lists »: a matrix of indices (BQN, Range (https://mlochbaum.github.io/BQN/doc/range.html)). In K7PL's table of glyphs, `↕` is `windows`, sliding windows.

Several options may be chosen.

- **incl — Inclusive bounds, a..b.** `1..9` holds 9, as Ada, Haskell, Ruby and Unicode. Example: `[[1..9]]`.
- **excl — An excluded end, a..<b.** `0..<n` holds the n indices from 0. Example: `[[0..<n]]`. *For:* indices without writing `n-1`. *Against:* a second notation.
- **step — A step.** The second value gives the step, as Haskell. Example: `((1 3..9))   ;; 1 3 5 7 9`. *Against:* two elements before `..`.
- **open — No end, in layer 2 only.** `1..` has no end; layer 3 terminates, so only `((…))` may hold it. Example: `((1..))`.
- **dims — Several ranges, a matrix.** `[[1..3 1..3]]` is the 3×3 matrix of index pairs, as BQN's `↕` given a list. Example: `[[1..3 1..3]]`.
- **chars — Characters, by code point.** A range of code points in Unicode's notation; a range of characters written as characters waits for the character literal. Example: `[[U+0041..U+005A]]`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-038), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** on traite le cas des doubles délimiteurs avant de résoudre ce sujet
- **Reading:** kept open until the doubled delimiters are settled.


## Lot of 2026-10-27, fifth part (revised): texts, qualified delimiters, character classes, trains, doubled forms, monomorphisation, branchings and definitions, numbers, names, the old K archive

Opened on 2026-10-27 and revised the same day, before any answer, after the
conversation recorded in [decisions](decisions.md) (« Conversation of 2026-10-27 on
texts, doubled and qualified delimiters, escapes and trains »). The questions follow
the same rules: options to enumerate and objectify, then the author's choice;
**Other** and **Clarify** are always available. The research is in
[research](research.md), « Reading lot: research of 2026-10-27, fifth part », its
« Conversation of 2026-10-27 », and « Archive review: early K premises ».

Withdrawn as settled in the conversation:

- Q-STR-301: `\` escapes the character that follows, special characters take their LaTeX names, a code point is written `\u'…'`.
- Q-LEX-404: files keep ASCII and the editor shows the Unicode forms, so the reader never meets a white bracket.

Words of the examples that no answer has fixed yet (`accept`, `outcome`, `def`, `defunc`…) are placeholders.

### Texts

#### Q-STR-302 — Reading `""`: the empty text or an opening

**Object.** Decided in the conversation: `"` is the fourth typed pair, with `""` the empty text, `"s"` a text and `""s""` a raw text that the editor shows as `« s »` while files keep ASCII; repeating a delimiter raises its level, and three quotes make a block (Q-STR-204). The reader still meets `""` in files and must tell the empty text from an opening run of two quotes.

**Facts.**

- CommonMark: « A code span begins with a backtick string and ends with a backtick string of equal length » (CommonMark 0.31.2, §6.1 (https://spec.commonmark.org/0.31.2/#code-spans)). C#: « A raw string literal starts and ends with a minimum of three double quote (") characters », and `""` stays the empty string (C# reference (https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/raw-string)).

- **A — Two quotes then a separator: the empty text.** `""` followed by a space, a delimiter or the end of a line is the empty text; followed by anything else, it opens a raw text. *For:* your forms kept as decided. *Against:* a raw text cannot begin with a space after two quotes; it takes three.

  ```text
  (f "" x)            ;; the empty text
  (f ""C:\path"" x)   ;; a raw text, shown « C:\path »
  ```

- **B — C#'s rule: `""` is always empty.** A raw text takes three quotes or more. *Against:* the decided `""s""` becomes `"""s"""`, and raw text and blocks share three quotes.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-039), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** ""%20text"" permetterait d'encoder l'espace en début de raw text
- **Reading:** `""` followed by a space, a delimiter or the end of a line is the empty text; followed by anything else, it opens a raw text (option A). A raw text that begins with a space writes it `%20`, as paths do (VOC-2026-10-27-024). Whether `%20` is then decoded everywhere in a raw text, or only at its start, follows from Q-STR-303.


#### Q-STR-303 — Raw text and the backslash

**Object.** Decided: in `"…"`, `\` escapes the character that follows (« j'accepte que `\` échappe le caractère qui le suit »). What does `\` do in a raw text `""…""`, whose main uses — regular expressions, Windows paths, quoted TeX — are full of backslashes?

**Facts.**

- Python: « Even in a raw literal, quotes can be escaped with a backslash, but the backslash remains in the result » (Python reference, 2.5.6 (https://docs.python.org/3/reference/lexical_analysis.html)).
- OpTeX: in `\code{⟨text⟩}`, « you have to escape the following characters in the ⟨text⟩: \, #, %, braces (if the braces are unmatched in the ⟨text⟩), and space or ^ (if there are more than one subsequent spaces or ^ in the ⟨text⟩) » (OpTeX manual, 1.4.7 (https://petr.olsak.net/ftp/olsak/optex/optex-doc.pdf)).
- Common Lisp: « the single escape character is discarded, the next character is accumulated » (CLHS 2.4.5 (https://www.lispworks.com/documentation/HyperSpec/Body/02_de.htm)).

- **A — Only before the closing delimiter.** In a raw text, `\` escapes the closing quotes and stays literal everywhere else. Example: `""\d+""   ;; the text \d+`. *For:* a raw text stays raw; Python and OpTeX escape only what the reader would misread.
- **B — As in an ordinary text.** `\` escapes any character and is dropped. Example: `""\d+""   ;; the text d+`. *For:* one rule for both forms. *Against:* regular expressions and paths must double every backslash.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-040), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** L'objectif ici est que l'ensemble du raw text puisse être parsé, il faudra utiliser le code d'encodage http pour les guillemets %22 : je trouve cela cohérent puisque ce type de text semble adapté à la rédaction de liens.
- **Reading:** in a raw text, `\` stays literal (option A). The justification goes further than A: the whole raw text must be readable without escapes, quotation marks inside it being written `%22`, as in a URL, which suits a text made to hold links. Put to the next part: whether every `%XX` is decoded in a raw text (a literal `%` then being `%25`), or only `%20` and `%22`; and whether `\` still escapes the closing quotes, which `%22` makes unnecessary.


#### Q-STR-304 — Characters that cannot be seen

**Object.** Decided: special characters take their LaTeX names (`\guillemetright`), one space after a name is absorbed, and any code point is written `\u'…'`. LaTeX's text symbols name no control character: there is no tab, and `\n` or `\t` are not LaTeX names. A line break is written as such, since texts span lines (Q-STR-103).

**Facts.**

- The LaTeX reference lists 72 commands under « Text symbols », among them logos (`\LaTeX`), font commands (`\texttt`) and commands with an argument (`\textcircled`), which name no single character (LaTeX2e reference, Text symbols (https://latexref.xyz/Text-symbols.html)).

- **A — Code points only.** Example: `"a\u'09'b"   ;; a, a tab, b`. *For:* no name outside LaTeX. *Against:* a tab reads as a number.
- **B — A few K7PL names beside LaTeX's.** A short closed list for invisible characters (tab, no-break space…), written like LaTeX names. Example: `"a\tab b"`. *Against:* names that LaTeX does not define.
- **C — C's `\n` and `\t` kept as exceptions.** *Against:* `\n` would read as a name under the TeX rule; two traditions.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-041), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** a short closed list of K7PL names for invisible characters, written like LaTeX names (option B; example `"a\tab b"`). The list itself is to be drawn up.


#### Q-STR-305 — The length of a text

**Object.** Your « délimiteur typé (varchar 0-n) »: a text carries a bound n. In what unit is a length counted? A text type without its bound would be a typed hole, resolved as the integers are (Q-NUM-203).

**Facts.**

- UAX #29 describes « grapheme clusters (“user-perceived characters”) » (Unicode, UAX #29 (https://www.unicode.org/reports/tr29/)).
- The old K archive measured « en graphèmes (UAX #29), pas en octets ni en code points », with a grapheme index for access by position in O(1).

- **A — Graphemes (UAX #29).** *For:* what a reader counts. *Against:* depends on the Unicode version; an index to keep for O(1) access.
- **B — Code points.** *For:* stable; what `\u'…'` names. *Against:* `é` may count two.
- **C — Bytes of UTF-8.** *For:* the memory cost, visible (P3). *Against:* far from what a reader counts.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-042), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** Il faut dissocier deux points de vue : la longueur de rédaction en graphème recommandé dans une ligne que le lecteur lit et qui a pour objectif de préserver la lisibilité du code source (règles de fmt/linter) et le typage d'une chaine rédigée dans le code source qui prend en mémoire l'ensemble du bytecode utf-8 qui compose la chaine de caractère et commençant à 0 pour une chaine vide. En ce sens, A et C sont vrais mais n'encodent pas la même chose.
- **Reading:** two measures, kept apart. The length that bounds a text type counts the bytes of its UTF-8 encoding, from 0 for the empty text (option C): it is what the text takes in memory. Graphemes (option A) measure a line as a reader sees it, for the formatter and the linter, which keep source lines readable. A and C are both true and do not encode the same thing.


#### Q-STR-306 — A character literal

**Object.** K7PL has no character literal yet; ranges of characters wait for one (Q-LEX-304), and `'` now closes a code point in `\u'…'`.

**Facts.**

- BQN: « Character literals start and end with `'`, and have exactly one character in between » (BQN, syntax (https://mlochbaum.github.io/BQN/doc/syntax.html)). R7RS: « Characters are written using the notation #\⟨character⟩ or #\⟨character name⟩ or #\x⟨hex scalar value⟩ » (R7RS, §6.6 (https://small.r7rs.org/attachment/r7rs.pdf)).
- The old K archive wrote `'a'`, `'\n'`, `'\u{1F600}'`.

- **A — Between apostrophes.** Example: `'a'   '»'`. *Against:* a code point inside collides with `\u'…'`: `'\u'bb''`.
- **B — A one-character text with its type.** Example: `{c :type char "a"}`. *For:* no new delimiter. *Against:* heavy for a frequent value.
- **C — Scheme's `#\a`.** *Against:* `#` is the comptime sigil.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-043), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** Un caractère littéral : "a", "μ", "\lambda", etc.
- **Reading:** no new delimiter: a character is written like a text of one character, `"a"`, `"μ"`, `"\lambda"`. Put to the next part: how a character is told from a text of length one — by the type the context expects, or as a typed hole resolved like the integers (Q-NUM-203).


#### Q-STR-307 — How a hole is written in a qualified literal

**Object.** Decided: a hole in a qualified literal is a typed hole, passed as a parameter, never pasted as text; Q-STR-003 is reopened for these forms only, a plain `"…"` never interpolates. Your example wrote `$something`.

**Facts.**

- PostgreSQL: « A dollar sign ($) followed by digits is used to represent a positional parameter in the body of a function definition or a prepared statement. In other contexts the dollar sign can be part of an identifier or a dollar-quoted string constant. » (PostgreSQL manual, lexical structure (https://www.postgresql.org/docs/current/sql-syntax-lexical.html)).

- **A — `$name`, told apart by the validator.** Example: `(sql|SELECT * FROM users WHERE name = $who|sql)`. *Against:* the tag's validator must tell it from the foreign language's own `$`.
- **B — The tag's type declares its hole syntax.** SQL could keep `$1` or `:name`, another language its own. *For:* each foreign language keeps its idiom. *Against:* one rule per tag.
- **C — `@name`, the attribute sigil.** *Against:* `@` is frequent in foreign texts (addresses, decorators).

**Answer of the author — 2026-10-27 (VOC-2026-10-27-044), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Clarification:** Nous n'avons pas encore creusé en profondeur ce sujet qui mérite de prendre le temps, de comparer les approches, notamment d'observer comment OCaml traite le sujet, idem en observant des langages memory safe, etc. Et le "@" je le réserve vraiment pour le pattern-matching inspiré de TXR Lisp
  (man page <https://man.uex.se/1/txr>, mirroir <https://github.com/salewski/txr-mirror>)
- **Reading:** kept open: the writing of holes deserves time and a comparison of approaches, OCaml's and those of memory-safe languages among them. `@` is reserved for pattern matching inspired by TXR Lisp; chapter 5 makes `@` a sigil read as an attribute, a reading this reservation questions (next part).


#### Q-STR-308 — Quotation marks in the view

**Object.** Decided: files keep `""s""`, the editor shows `« s »`.

**Facts.**

- OpTeX: `\"⟨quoted text⟩"` « prints language-dependent normal or alternative quotes around ⟨quoted text⟩ » (OpTeX manual, 1.7.1 (https://petr.olsak.net/ftp/olsak/optex/optex-doc.pdf)).

- **A — Always « s ».**
- **B — By language.** « s » in French, “s” in English, from a setting of the editor or of the document.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-045), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** the editor always shows a raw text as `« s »` (option A).


### Qualified delimiters

#### Q-LEX-501 — Declaring the type of a qualified delimiter

**Object.** Decided: in `tag|…|tag`, the tag names a defined type, whose syntax rules may later validate the literal; K7PL does not compile it, the user gets the checks of the foreign language. Decided too, the four forms of one tag: `"sql|…|sql"` typed text, `{sql|…|sql}` declared and checked at compile time, `(sql|…|sql)` executed, `[sql|…|sql]` pure and terminating, limited to the monotone fragment.

**Facts.**

- Haskell: « The ⟨quoter⟩ must be the name of an imported quoter, either qualified or unqualified » (GHC user guide (https://downloads.haskell.org/ghc/latest/docs/users_guide/exts/template_haskell.html)). Julia: « Users and packages may also define new non-standard string literals » (Julia manual, strings (https://docs.julialang.org/en/v1/manual/strings/)).
- OpTeX gives packages their own names, `\_pkg_foo` (TUGboat 42:1, 2021).

- **A — A layer-1 type; an unknown tag is refused.** The tag is declared in layer 1, with an optional grammar; an unknown tag is a reading error with its code. Example: `{deftype sql :syntax …}`.
- **B — A, with the tags of a library under its name.** Example: `(pkg.sql|…|pkg.sql)`.
- **C — An unknown tag is plain text, with a warning.**

**Answer of the author — 2026-10-27 (VOC-2026-10-27-046), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** Option A mais les tags inconnus son du text plein avec le tag appliqué comme type tout de même : cela permet de faire des opérations en invoquant le tag comme référence sans nécessité un typage intégral (bon pour le prototypage)
- **Reading:** a tag is a layer-1 type, declared with an optional grammar (option A), but an unknown tag is not refused: its literal is plain text, typed by the tag all the same, so that operations can name the tag without a full type — useful when prototyping. Put to the next part: whether an undeclared tag gives a warning.


#### Q-LEX-502 — Fences and the view inside a literal

**Object.** Decided: repeating a delimiter raises its level, and `||` shows as `‖`. A literal that holds `|sql}` needs a longer fence; SQL's own `||` is concatenation.

**Facts.**

- OCaml: « the word-delimited form, for example {sql|...|sql}, should not be used for signaling that an extension is in use […] giving semantics to a specific delimiter limits the freedom to change the delimiter to avoid escaping issues » (OCaml manual, extension nodes (https://ocaml.org/manual/5.2/extensionnodes.html)). Scribble: « punctuation characters can be added between the | and the braces » (Scribble reader (https://docs.racket-lang.org/scribble/reader.html)).

- **A — Repeated bars; the view never touches a literal's content.** Example: `{sql|| SELECT a || b ||sql}`. *For:* the tag keeps the type, the bars the fence; SQL's `||` stays as written.
- **B — A second word for the fence, as OCaml.** Example: `{sql x| … |x sql}`. *Against:* two words to write.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-047), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** `{tag|` doit être traité comme un unique symbole délimiteur attendant sa paire fermante `|tag}`
- **Justification:** Keep it simple
- **Reading:** `{tag|` is read as one opening delimiter that waits for its closing pair `|tag}`; the same holds for the other three forms. Neither repeated bars nor a second word is added (« Keep it simple »). Put to the next part: what a literal that holds its own `|tag}` does.


#### Q-SPEC-206 — Negation in a recursive layer-3 query

**Object.** Decided: `[tag|…|tag]` is pure and terminating, limited to the monotone fragment, and `⦅…⦆` or `⦃…⦄` cannot enter layer 3. A negation `¬⟦…⟧` inside a recursive query breaks monotonicity.

**Facts.**

- Chapter 7, case study III: « La négation stratifiée, absente ici, changerait le tableau : une règle qui conclut de l'absence d'un fait n'est pas monotone, et le point fixe qui la contiendrait ne relèverait plus du théorème thm:terminaison_lfp. La stratification est le remède connu ; ce document ne la traite pas. »
- PostgreSQL: « When working with recursive queries it is important to be sure that the recursive part of the query will eventually return no tuples, or else the query will loop indefinitely » (PostgreSQL manual, WITH queries (https://www.postgresql.org/docs/current/queries-with.html)).

- **A — Refused inside recursion.** A negation in a recursive layer-3 query is refused; the query moves to layer 2. *For:* nothing to add to the specification.
- **B — Stratified negation, checked at compile time.** Chapter 7's gap is filled by a new statement, to prove. *Against:* a theorem to write and prove.
- **C — Only of a relation fixed before the recursion.** One stratum: the negated relation does not depend on the query. *For:* monotone by construction.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-048), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Clarification:** J'ai besoin d'en connaitre les limites et effets d'opportunités
- **Reading:** a negation in a recursive layer-3 query is allowed only of a relation fixed before the recursion, which keeps the query monotone by construction (option C). The author asks for the limits of this choice and the opportunities it opens before it enters chapter 7 (next part).


### Character classes

#### Q-LEX-503 — Classes: `:alpha:` and its forms

**Object.** Your proposal: `[[:alpha:]]` a matrix range, `((:alpha:))` a contiguous list, `{{:alpha:}}` a refined Unicode type. The class name needs a form of its own, apart from the label `:alpha` of the sigil `:`; by the head rule, `[:alpha: c]` is a predicate.

**Facts.**

- POSIX: « A character class expression is expressed as a character class name enclosed within bracket-<colon> ("[:" and ":]") delimiters » and is used inside a bracket expression, `[[:alpha:]]` (POSIX.1-2024, XBD 9.3.5 (https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap09.html)). Unicode maps `alpha` to `\p{Alphabetic}` (UTS #18, annex C (https://www.unicode.org/reports/tr18/)).
- Counted on Unicode 18.0 (DerivedCoreProperties): `Alphabetic` holds 160,254 code points in 775 contiguous runs — a 775×2 matrix of bounds is about 6 KB, the code points themselves about 640 KB.

- **A — As proposed, with these readings.** `[:alpha: c]` a predicate; `[[:alpha:]]` the matrix of bounds (n×2); `((:alpha:))` the code points in order, produced on demand; `{{:alpha:}}` the refined type `{c : char | Alphabetic(c)}`; POSIX names mapped to Unicode by UTS #18.
- **B — Types and predicates only.** `{{:alpha:}}` and `[:alpha: c]`; no materialised list or matrix. *For:* nothing costly to hide.
- **C — POSIX names by locale, without Unicode.** *Against:* the meaning depends on the machine.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-049), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Bien que je ne vois pas encore la profondeur de ce choix, il me semble plus pertinent de voter A au regard de l'expressivité qu'il permet.
- **Reading:** the class forms as proposed (option A): `[:alpha: c]` a predicate, `[[:alpha:]]` the matrix of bounds, `((:alpha:))` the code points in order, produced on demand, `{{:alpha:}}` the refined type, POSIX names mapped to Unicode by UTS #18.


#### Q-LEX-504 — `¬` on a class: within what?

**Object.** The glyph table gives `¬` (`not`) as « Négation bit-à-bit »: the complement of a class is the bitwise negation of its characteristic vector, which needs a universe.

- **A — All code points.** U+0000 to U+10FFFF, 1,114,112 values, surrogates included.
- **B — Unicode scalar values.** The same less the 2,048 surrogates: 1,112,064 values, what a text can hold. *For:* the complement stays within valid characters.
- **C — Assigned characters.** *Against:* changes with each Unicode version.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-050), given in the clickable questionnaire, quoted as given.**

- **Choice:** CLARIFY
- **Clarification:** Qu'est-ce qui empecherait A ou favoriserait B?
- **Reading:** clarification asked: what would prevent A, or favour B. Answered in the next part.


### Trains and views

#### Q-SPEC-207 — Rewriting the trains of chapter 5

**Object.** Accepted in the conversation: a train is written as text, left to right with S-expression logic; the glyph form is a view of the same code; arities are typed (monadic, dyadic, at most triadic, never n-ary), so the elaboration tells a train from an application without a head word. Chapter 5 writes the mean `+´÷≠` and the standard deviation `√(+´(⊢-+´÷≠)²÷≠)` in BQN's order, modifier after its function.

**Facts.**

- Chapter 5: « un 2-train `(f g)` dénote λx. f(g(x)), un 3-train `(f g h)` dénote la fourche λx. (f x) g (h x) »; « Chaque opération de la bibliothèque standard y porte un glyphe Unicode concis et un alias textuel strictement équivalent au niveau de l'AST »; annex A, `ERR-STK-001`.

- **A — Text form first, view in the text's order.** Chapter 5 shows the text form and, beside it, the view, where each word becomes its glyph in place; the standard deviation is rewritten once its aliases are chosen (Q-LEX-505). Example: `((fold add) div length)   ;; view: ´+÷≠`.
- **B — Text form first, view in BQN's order.** The view moves a modifier after its function (`+´`), as chapter 5 writes today. *Against:* the view no longer replaces words in place.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-051), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Je dirais plutot soit (fold add div lenght) -> (´+÷≠) soit ((fold add) div length) -> ((´+)÷≠) ; le premier nécessite des arités fixes systématiques, le second est une réduction symbolique qui peut laisser une arité n-air à un opérateur, je préfèrerais une arité fixe systématique et si fold doit s'appliquer à plusieurs sous ensembles alors utiliser la sémantique d'emacs eg (fold '(exp) '(exp2) '(exp3)) où les exp sont évaluées en parallele puis fold ensemble.
- **Reading:** text form first, the view replacing each word by its glyph in place, parentheses kept (option A). The author gives two writings of the mean: `(fold add div length)`, viewed `(´+÷≠)`, and `((fold add) div length)`, viewed `((´+)÷≠)`. The first needs fixed arities everywhere; the second is a symbolic reduction that could leave an operator n-ary. The author prefers fixed arities everywhere, hence the first. To fold several subsets, Emacs's way: `(fold '(exp) '(exp2) '(exp3))`, the expressions evaluated in parallel, then folded together. Put to the next part: the arity of `fold` in that form, and `'` as a quote in K7PL.


#### Q-LEX-505 — One alias per arity

**Object.** With typed arities, each use of a glyph needs its own alias. The glyph table lacks: the monadic `≠` (length; the table gives only `neq`), `´`, `¨`, `√`, `²`, the monadic `-` (the table gives `sub`) and the monadic `⊢` (the table gives `right-id`).

**Facts.**

- Chapter 5 already names `´` « pli » and `¨` « chacun ».

- **A — length, fold, each, sqrt, square, negate, identity.** Example: `≠ length (1) / neq (2)   ´ fold   ¨ each   √ sqrt   ² square   - negate (1) / sub (2)   ⊢ identity (1) / right-id (2)`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-052), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Le plus proche de ce que je recherche mais les bons lemmes sont encore à évaluer un à un, comme pour tous les autres lemmes du langage.
- **Reading:** one alias per arity, as listed (option A), as a direction: each lemma is still to be weighed one by one, as for every lemma of the language.


#### Q-LEX-506 — The boolean values

**Object.** The specification names no boolean value; your example ended with `;; t nil`; the old K archive wrote `true` and `false`.

- **A — true / false.**
- **B — t / nil.** *For:* Lisp's. *Against:* `nil` is also the empty list in Lisp, which is `()` here (Q-LEX-301).
- **C — yes / no.**

**Answer of the author — 2026-10-27 (VOC-2026-10-27-053), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** J'y ai beaucoup réfléchi et pour la valeur booleenne je préfèrerais simplement `t` pour true et `f` pour false pour une raison simple : `access-f` ou autres constructions de cette nature permettrait d'aisément comprendre l'objectif du test conditionnel (si je veux un comportement spécifique sur un test booleen sans avoir à expliquer quoi faire lorsque le booléen renvois l'autre condition)
- **Justification:** Je réfléchi à la composition de fonction à travers cet exemple illustratif
- **Reading:** the boolean values are `t` and `f`. A name such as `access-f` would then state which outcome of a test it acts on, without saying what to do on the other; the author thinks about the composition of functions through this example. Put to the next part: whether `-f` and `-t` are a naming convention or a derived form, and the consequence that `f` and `t` can no longer name anything else (chapter 5 writes the trains `(f g)` and `(f g h)`).


#### Q-LEX-507 — Flags

**Object.** Chapter 6 writes modes `+verify` and `+introspect`; the reader reads `-2` and `+4` as numbers. The old K archive made `+name` and `-name` boolean arguments of any form, a letter after the sign telling them from numbers.

- **A — `+name` / `-name` everywhere.** Example: `(spawn counter +restart-always -verbose)`.
- **B — Modes only, as today.** Example: `+verify`.
- **C — Properties instead.** Example: `(spawn counter :restart-always true)`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-054), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** Le projet mélangeait encore shell + langage, la notion de flag permettrait éventuellement de désactiver des paramètres ou d'ajouter des paramètres optionnels mais je n'ai pas encore étudier cela. Cette recherche mérite qu'on travail ensemble parce que l'emplois de flags `+` et `-` pour indiquer "avec" ou "sans" suppose de connaitre un état par défaut, que des paramètres puissent être désactivée de façon sûre ce qui les rendrait par nature optionnelle donc est-ce que dans ce context l'on pourrait simplement utiliser le flag `+` ? Est-ce que ce serait `+parametrename` ou `+:parametrename`? Bref je n'ai pas encore réexplorer ce sujet depuis l'importante réécriture du projet durant l'été.
- **Reading:** properties rather than flags for now (option C). Flags are to be studied together: `+` and `-` for « with » and « without » assume a default state, and a parameter that can be switched off safely is optional by nature, so `+` alone might do; written `+name` or `+:name`. The modes `+verify` and `+introspect` of chapter 6 stay as written until then (next part).


### Doubled forms and white brackets

#### Q-LEX-401 — ⟦ ⟧ in layer 3: which precision?

**Object.** Q-LEX-302: `[[ x ]]` is `⟦ x ⟧`, a precision dedicated to layer 3 — the stack, pure and terminating computations — on a memory action, a grade or a resource. Your example: more dimensions for an array, cubes. Decided since: dimensions are written with bars (`[1 2 | 3 4 || 5 6 | 7 8]`), so cubes no longer need `[[ ]]`; files keep `[[ ]]` and the editor shows `⟦ ⟧`.

**Facts.**

- J: « The verb `u"n` applies u to each cell as specified by the rank n » (J Dictionary, Rank (https://www.jsoftware.com/help/dictionary/d600v.htm)); BQN's Range given a list of lengths gives an array of index lists (fourth part).
- Chapter 3: `Vec n V` is the only array type of the grammar, its literal `[v₀, …, vₙ₋₁]`; chapter 2 writes `⟦·⟧` for a translation.

Several options may be chosen.

- **range — Ranges.** The fourth part's proposal D (Q-LEX-304 waits for this answer). Example: `[[ 1..9 ]]`.
- **frame — Placed in the caller's frame.** Storage whose size is known at compile time, reserved in the frame of the calling function and freed with it, its grade explicit. Example: `[[ buffer 256 ]]`.
- **cells — Applied cell by cell (rank of a function).** A function applied to the cells of a given rank, as J's `"`. Example: `[[ f 1 ]]   ;; f on each row`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-055), given in the clickable questionnaire, quoted as given.**

- **Choice:** range, frame, cells, OPEN
- **Justification:** Keep open pour continuer d'observer les opportunités.
- **Reading:** `⟦ ⟧` in layer 3 holds ranges, storage placed in the caller's frame, and functions applied cell by cell; the question stays open to further uses. Ranges (Q-LEX-304), which waited for this answer, come back in the next part, with the rule that tells the three uses apart.


#### Q-LEX-402 — ⦅ ⦆ in layer 2: which precision?

**Object.** `(( x ))` is `⦅ x ⦆`, a precision dedicated to layer 2 — the heap, orchestration, productive computations. Your example: another resolution scheme for a list graph. Decided since: `⦅…⦆` stays in layer 2, refused in layer 3; files keep `(( ))`.

**Facts.**

- Clojure's `lazy-seq` « yields a Seqable object that will invoke the body only the first time seq is called, and will cache the result » (clojure.core (https://clojure.github.io/clojure/clojure.core-api.html)).
- McBride and Paterson write `⟦f u₁ … uₙ⟧`, « indicating a shift into the idiom of an Applicative functor, where a pure function is applied to a sequence of effectful arguments » (Applicative programming with effects, preprint, p. 4 (https://www.staff.city.ac.uk/~ross/papers/Applicative.pdf)); Idris: « `[| f a1 …an |]` is translated into `pure f <*> a1 <*> … <*> an` » (Idris tutorial, idiom brackets (https://docs.idris-lang.org/en/latest/tutorial/interfaces.html)).
- The old K archive had regions, `(in-region :name body)`, and allocation annotations `+stack`, `+region`, `+rc`, `+arena`.

Several options may be chosen.

- **lazy — Produced on demand.** A list whose elements are computed when first read, then kept. Example: `(( naturals ))`.
- **shared — A graph with sharing.** Equal elements shared rather than copied, and the order of traversal stated (breadth or depth first). Example: `(( a b a ))   ;; a once, referenced twice`.
- **idiom — Idiom brackets.** A pure function applied to effectful arguments, each effect in order: McBride and Paterson's own white brackets. Example: `(( + (read-a) (read-b) ))`.
- **heap — Another heap region.** Allocation in a named region rather than the standard heap. Example: `(( :region frames … ))`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-056), given in the clickable questionnaire, quoted as given.**

- **Choice:** idiom
- **Justification:** La composition du heap reviens à l'isolation des acteurs. Le partage devrait être une optimisation de compilation. K7PL se veut Lazy en toute circonstance. Ainsi, seule l'option "idiom" parmis les proposition fait sens.
- **Reading:** `⦅ ⦆` in layer 2 are idiom brackets: a pure function applied to effectful arguments, each effect in order. Composing heaps amounts to isolating actors; sharing should be an optimisation of the compiler; « K7PL se veut Lazy en toute circonstance ». Laziness here is that of the orchestration (author's remark below): the automata compiled in layer 3 are invoked lazily by the orchestrator, which agrees with chapter 1, « stricte en couches 1 et 3, par nécessité en couche 2 ». Put to the next part: `((:alpha:))` of Q-LEX-503 must be read as an idiom bracket or given another form.

**Author's remark of 2026-10-27, given in the conversation after answering, quoted as given.** On the reading that « Lazy en toute circonstance » clashed with chapter 1's « stricte en couches 1 et 3, par nécessité en couche 2 »:

> c'est pas tout a fait ça, les automates compilés en couche 3 sont invoqués paresseusement par l'orchestrateur


#### Q-LEX-403 — ⦃ ⦄ in layer 1: which precision?

**Object.** `{{ x }}` is `⦃ x ⦄`, a precision dedicated to layer 1 — the linear arena, declarations and types. Your example: another arena than the standard one. Decided since: `⦃…⦄` stays in layer 1; files keep `{{ }}`.

**Facts.**

- Zig: « by convention, there is no default allocator in Zig. Instead, functions which need to allocate accept an Allocator parameter » (Zig 0.14.0 (https://ziglang.org/documentation/0.14.0/)). C++: « The memory_resource class is an abstract interface to an unbounded set of classes encapsulating memory resources » (C++ draft, [mem.res] (https://eel.is/c++draft/mem.res)). Rust's `Vec::with_capacity_in`, « nightly-only experimental », builds a vector « with the provided allocator » (Rust std, Vec (https://doc.rust-lang.org/std/vec/struct.Vec.html)).
- Agda: instance arguments are written `{{x : T}}` or `⦃ x : T ⦄`, and are found when « a unique instance of the required type can be built from declared instances and the current context » (Agda documentation (https://agda.readthedocs.io/en/latest/language/instance-arguments.html)). Chapter 3 has `Arena V`, `Cap ρ` and `slice`.
- The old K archive chose the place of a value along a hierarchy, register, stack, region, owned heap, reference counting, arena, linear memory, with annotations to force one.

Several options may be chosen.

- **arena — Another arena.** The declarations are placed in a named arena rather than the standard one. Example: `{{ :arena scratch {field buffer :num int8} }}`.
- **instance — Filled by search (Agda).** An argument the elaborator finds by type, as it fills a handler in chapter 5, written to make the search visible or to give its result. Example: `{{ counter-handler }}`.
- **comptime — Evaluated at compile time.** Example: `{{ table-of-squares 256 }}`.
- **capability — A capability given explicitly.** A capability `Cap ρ` granted to what follows, as chapter 3's handlers receive non-determinism. Example: `{{ :cap clock }}`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-057), given in the clickable questionnaire, quoted as given.**

- **Choice:** CLARIFY, OPEN
- **Clarification:** J'ai besoin d'une évaluation plus approfondie pour bien comprendre ce que les choix impliqueraient. Dans l'idée j'aime bien la définition d'Agda, j'aimerais bien savoir comment Clojure ou Lean4 utilise ces écritures, j'aime bien la notion de branchement spécifique de capability mais que signifie {{:alpha:}} dans ce contexte?
- **Reading:** kept open, with a clarification asked: a deeper evaluation of what each option implies; the author likes Agda's definition (instance arguments) and the notion of a branching specific to a capability, and asks how Clojure and Lean 4 use these notations and what `{{:alpha:}}` means in this context. Answered in the next part.


### Monomorphisation

#### Q-TYP-301 — A mechanism, from chapter 6 and from MLton and rustc

**Object.** You asked (Q-TYP-203) for the mechanisms of other compilers, weighed, then for one that keeps the best of them without distorting chapter 6. Chapter 6 already fixes: Phase 3 « monomorphise chaque appel générique en une copie concrète », once (« La monomorphisation, elle, ne s'exécute qu'une seule fois »); monomorphisation « n'est qu'une intégration dirigée par les types » and decrements the budget of specialisation, a grade carried by the unit of compilation, shared with inlining (« une seule décision les gouverne »); the interface of a unit carries its grade (`thm:interface_jugement`); a binary is addressed by the BLAKE3 hash of its normalised AST. Annex A refuses dynamic dispatch: `ERR-POL-001`, « Distribution dynamique ou table virtuelle détectée. Utiliser une résolution `comptime` ou des variantes monomorphes ».

**Facts.**

- MLton: « The monomorphiser works by making one pass over the entire program », with « a cache for each variable declared in a polymorphic declaration that maps a lists of type arguments to a new variable name »; the instances are finite « due to the absence of polymorphic recursion in SML » (MLton guide, Monomorphise (https://github.com/MLton/mlton/blob/master/doc/guide/src/Monomorphise.adoc)); « Whole-program compilation is an integral part of the design of MLton and is not likely to change » (MLton guide, WholeProgramOptimization (https://github.com/MLton/mlton/blob/master/doc/guide/src/WholeProgramOptimization.adoc)).
- rustc: « The roots of the mono item graph correspond to the public non-generic syntactic items »; then, « Starting from the roots, find uses […] until no more new nodes are found »; « A generic definition in crate X might produce monomorphizations that are compiled into crate Y »; a lazy strategy, « items will only be instantiated when actually used » (rustc 1.80.0, collector (https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_monomorphize/src/collector.rs)). Limits: `recursion_limit`, 128 by default; `type_length_limit`, « the maximum number of type substitutions allowed when constructing a concrete type during monomorphization » (Rust reference, limits (https://doc.rust-lang.org/reference/attributes/limits.html)).
- C++: « There is an implementation-defined quantity that specifies the limit on the total depth of recursive instantiations […]. The result of an infinite recursion in instantiation is undefined », with `X<T>` requiring `X<T*>`, which requires `X<T**>`… (C++ draft, [temp.inst] (https://eel.is/c++draft/temp.inst)). Zig: « Compile-time parameters is how Zig implements generics. It is compile-time duck typing. » (Zig 0.14.0 (https://ziglang.org/documentation/0.14.0/)).
- Code shared at run time: Go 1.18 generates « a single chunk of assembly for each unique GC shape », each taking « a *dictionary* » (Go design, GC shape stenciling (https://github.com/golang/proposal/blob/master/design/generics-implementation-gcshape.md)); .NET makes one copy per value type, while « every time that a constructed type is instantiated with a reference type as its parameter, regardless of what type it is, the runtime reuses the previously created specialized version » (.NET guide (https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/generics-in-the-run-time)); Swift specialises only « If the generic function's definition is visible to the optimizer and the concrete type is known » (Swift, OptimizationTips (https://github.com/swiftlang/swift/blob/main/docs/OptimizationTips.rst)); GHC's `SPECIALIZE` asks « that GHC create a copy of a function with specific arguments; most commonly, a copy of an overloaded function with specific class dictionary arguments » (GHC user guide (https://downloads.haskell.org/ghc/latest/docs/users_guide/exts/pragmas.html)). `ERR-POL-001` keeps all four outside K7PL.
- The old K archive's « B+ » templates: « Pas de `∀T` », « Pas de `∃T` », no higher kinds, every template monomorphised (« `List(Int64)` est un type concret `List_Int64` »).

- **A — Proposed: collect from the roots, name instances by their hash, count them in the budget.** *For:* chapter 6 is kept as written; every step has a precedent; separate compilation stays possible. *Against:* a generic's source is part of its unit's interface, as C++ headers or rustc's metadata, so changing it recompiles the units that use it.

  1. **Collection** (rustc): from the roots of the unit — its entry points and what its interface exports — follow the uses, instance by instance, until nothing new appears; only the instances reached are made (MLton's cache, keyed by the type arguments, is the table).
  2. **Identity by content**: an instance is named by the hash of the generic's normalised AST and of its type arguments, as the binary is in chapter 6; an instance needed by two units is made once and linked once. A generic of another unit is instantiated in the unit that uses it (rustc), its source travelling in the interface.
  3. **Budget**: each new instance decrements the budget of specialisation written in the source; an instance already made costs nothing.
  4. **Growth refused**: a chain of instances whose types grow on a cycle (polymorphic recursion, C++'s `X<T*>`) is refused by its own code, naming the cycle, whatever the budget — where rustc and C++ only meet a limit.
  5. **Nothing shared at run time**: no dictionary, no table (`ERR-POL-001`); the rows of layer 2 (Phase 4) are instantiated like types; effect handlers keep chapter 6's capability passing, a capability being a value of layer 1.

- **B — The whole program at once (MLton).** One pass over the whole program; every instance is known. *For:* the simplest. *Against:* no separate compilation, against the grade carried by the unit of compilation in chapter 6.
- **C — Shared code by layout (Go).** One copy per memory layout, a dictionary for the rest. *Against:* a dictionary is dynamic dispatch, refused by `ERR-POL-001`; « tout est monomorphé » would no longer hold.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-058), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Ce qui est le plus proche de la phylosophie de K7PL mais le "against" reste préoccupant et mérite de noter la limite avec pour objectif d'y trouver une solution élégante et ne dénaturant pas le mécanisme.
- **Reading:** the mechanism proposed in option A is adopted: collection from the roots, instances named by their hash, counted in the budget, growth on a cycle refused, nothing shared at run time. Its limit — a generic's source is part of its unit's interface, so changing it recompiles the units that use it — is recorded, to be solved elegantly without distorting the mechanism.


#### Q-TYP-302 — When the budget of specialisation runs out

**Object.** Chapter 6 says of the budget that its exhaustion « arrête la duplication au lieu d'échouer ». For inlining, stopping leaves a call, which works. For monomorphisation, a generic call left without its instance has no code to call, since nothing is shared at run time (`ERR-POL-001`).

**Facts.**

- Chapter 6, on the solver: « un refus qui nomme l'obligation qu'il n'a pas su décider, ce qu'il y a consacré et ce qui la déciderait est une assistance »; « le budget relevé doit être écrit dans la source »; « Le budget du solveur est un compte de ressource, jamais un délai ».
- rustc and C++ stop at a fixed limit (Q-TYP-301); chapter 6 replaces such limits by grades carried by the unit.

- **A — Inlining stops, monomorphisation refuses.** Exhaustion stops inlining (calls stay), and refuses the program if an instance is still missing, with a code naming the generic, the chain of instances, the budget spent and the budget that would suffice. The sentence of chapter 6 is made precise: « au lieu d'échouer » holds for inlining. *For:* the solver's kind of refusal; nothing hidden.
- **B — A, with instances served first.** Instances draw on the budget before inlining, which gets what remains; the refusal comes only when the instances alone exceed it. *For:* inlining never starves a needed instance. *Against:* an order between the two uses of one budget.
- **C — Two budgets.** One for instances, one for inlining. *Against:* chapter 6 says « une seule décision les gouverne ».

**Answer of the author — 2026-10-27 (VOC-2026-10-27-059), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** exhaustion stops inlining, whose calls stay, and refuses the program if an instance is still missing, with a code naming the generic, the chain of instances, the budget spent and the budget that would suffice (option A). « au lieu d'échouer » in chapter 6 holds for inlining.


#### Q-TYP-303 — Functions as arguments: one copy per function?

**Object.** Chapter 6 leaves a decision open: in defunctionalisation, « l'unité de spécialisation — une fonction d'ordre supérieur employée avec deux arguments fonctionnels distincts se spécialise en deux fonctions distinctes, et il faut décider si c'est ce qu'on veut » (Brandon et al., 2023, in its bibliography). It extends monomorphisation from types to function arguments.

**Facts.**

- Lean: « Specialization is an optimization in the code generator for generating variants of a function that are specialized to specific parameter values. This is in particular useful for functions that take other functions as parameters » (`@[specialize]`, Lean 4.34.0, Specialize.lean (https://github.com/leanprover/lean4/blob/v4.34.0/src/Lean/Compiler/Specialize.lean)).
- Julia: « As a heuristic, Julia avoids automatically specializing on argument type parameters in three specific cases: Type, Function, and Vararg » (Julia manual, performance tips (https://docs.julialang.org/en/v1/manual/performance-tips/)). GHC: a `SPECIALIZE` pragma generates « (a) a specialised version of the function and (b) a rewrite rule » (GHC user guide).

- **A — Yes, in the same budget.** A higher-order function is copied for each distinct function argument known at compile time, each copy decrementing the budget; beyond it, the arguments are defunctionalised into tags and the function chooses by a `case` over that closed set, decided at compile time. *For:* one rule for types and functions; no closure to allocate.
- **B — Only when asked.** A property, `:specialize` for instance, asks for copies, as Lean's attribute; otherwise one function with tagged arguments. *For:* code size stays under the programmer's eye. *Against:* a property to write where the gain is wanted.
- **C — Never.** One function per higher-order definition, its function arguments defunctionalised into tags. *Against:* a `case` at each call of the argument.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-060), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** L'approche de Lean est trés pertinente ici!
- **Reading:** a higher-order function is copied for each distinct function argument known at compile time, each copy counted in the same budget, the arguments being defunctionalised beyond it (option A). The author finds Lean's approach very relevant; Lean specialises the functions marked `@[specialize]`, which is option B's request by property. Put to the next part: whether such a property complements A.


### Branchings and definitions

#### Q-SPEC-201 — The inventory of branchings

**Object.** You decided (Q-SPEC-101) that monadic constructions are explicit branchings, properties written with `:` — `:bind something`, `:return somethingelse` — and asked for the whole inventory, CLOS's `:before`, `:after` and `:around` included, with the constructions of the specification about resources and time. The inventory below is the term grammar of chapter 3 (`eq:grammaire-termes`), grouped by the modality each family builds or consumes. Tick the families that become branchings; the property names repeat the words of chapter 3.

**Facts.**

- Haskell: `return a >>= k = k a` among the laws of `Monad` (base, Control.Monad (https://hackage.haskell.org/package/base/docs/Control-Monad.html)); a comonad has `extract :: w a -> a`, `duplicate :: w a -> w (w a)` and `extend :: (w a -> b) -> w a -> w b` (comonad, Control.Comonad (https://hackage.haskell.org/package/comonad/docs/Control-Comonad.html)).
- CLOS: « An auxiliary method is a method whose qualifier is :before, :after, or :around »; « All the before methods are called, in most-specific-first order. Their values are ignored »; inside an around method, « call-next-method can be used to call the next method » (CLHS 7.6.6.2 (https://www.lispworks.com/documentation/HyperSpec/Body/07_ffb.htm)).
- Chapter 3, types: `F_ε` the computation that returns a value, `U_ε` its suspension, `!_r` the graded comonad, `□` `◇` `◯` the three temporal modalities, `@_n` localisation, `μ` and `ν` the fixed points, `Arena` and `Cap` the resources.

Several options may be chosen.

- **monad — The computation F_ε (decided).** `return v`, and `let x ← c in c`. Example: `:return  :bind`.
- **thunk — Suspension U_ε.** `thunk c` holds a computation as a value; `force v` runs it. Example: `:thunk  :force`.
- **comonad — The graded comonad !_r.** `box_r v` promotes a value under a grade; `unbox v as x in c` extracts it — Haskell's `extract`, of which `extend` and `duplicate` are built. Example: `:box  :unbox`.
- **time — Time: □ ◇ ◯.** `always v`, `now v`, `next v`, `delay c`, `wait v`, `when x = v in c`. Example: `:always  :now  :next  :delay  :wait  :when`.
- **place — Place: @_n.** `at_n c` runs at a place, `move_{n→m} v` carries a value between places. Example: `:at  :move`.
- **effect — Operations and handlers.** `operation_ε(v)`, `scoped_f(v, c)`, `try c catch c`. Example: `:perform  :scoped  :try  :catch`.
- **cofix — Productive streams: ν.** `out c` observes one step of a productive computation; copatterns `⟨⟨j ↦ c_j⟩⟩` answer each observation. Example: `:out`.
- **resource — Resources.** `free v`, `slice v as (x, y) in c` splits an arena, `declassify_ℓ(v)` lowers a confidentiality level. Example: `:free  :slice  :declassify`.
- **clos — Method combination (CLOS).** Auxiliary definitions run before, after or around a primary one, the around one calling the next. Example: `:before  :after  :around`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-061), given in the clickable questionnaire, quoted as given.**

- **Choice:** monad, effect, clos
- **Justification:** Je ne suis pas sur d'avoir bien tout choisi mais ma méthode est la suivante : qu'est-ce qui a le plus de sens à exposer comme paramètre comparer à ce qui a le plus de sens à proposer comme fonction ? (free, slice, at, when, etc. semble être plus utiles dans un algoritme que présentés comme paramètres)
- **Reading:** branchings — properties written with `:` — for the computation (`:return`, `:bind`), for operations and handlers (`:perform`, `:scoped`, `:try`, `:catch`) and for method combination (`:before`, `:after`, `:around`). Suspension, the graded comonad, time, place, productive streams and resources stay functions (`free`, `slice`, `at`, `when` are more useful in an algorithm than as parameters). The criterion is recorded with the choice: what makes most sense as a parameter, against what makes most sense as a function; the author is not sure every family is placed right.


#### Q-SPEC-202 — Rewriting lst:gestionnaire and lst:acteur

**Object.** Your answer to Q-SPEC-102: a handler binds actors, `{defhandler beta :bind actor-name}`; an actor binds productive or terminating functions, `{defactor actor-name :bind (selection algorythm) :result [transformation algorythm]}`. Below, the counter of chapter 5 rewritten on that model, with what the prose would then say. Nothing is applied before your choice.

**Facts.**

- Chapter 3 defines a pure layer-2 handler by its transition, « une application (Message × Capacités × État) → État dont l'effet est neutre », whose result « n'est pas un effet exécuté mais une description d'effets, une liste d'instructions que l'exécutif réalise ».
- Chapter 5 reads today: « Un acteur est la paire additive dépendante (état : S) & Handler(S) du chapitre 3, et `bind-to` n'est qu'un accès de champ », the elaborator filling the handler by type-directed search when it is omitted, ambiguity being refused in Phase 1.
- The old K archive bound logic to an actor as `(bind-to actor-name (init …) (on-message :tag (msg state) (handler-result :new-state … :reply … :emit […])))`, the runtime committing the result or rolling it back.

- **A — As proposed.** The actor holds its fields, binds by `:bind` the selection (layer 2, productive: which messages it accepts) and gives by `:result` the transformation (layer 3, terminating: the pure function of `lst:fonction-pure`). The handler binds the actor by `:bind` and realises its outcome: the new state and the response, described by `HandlerResult`. The prose: an actor is the pair of its state and of its two functions, the transition of chapter 3 being its `:result`; the handler's `:bind` is what the elaborator fills by type-directed search when it is omitted, the paragraph on coherence moving to it.

  ```text
  {defactor counter
    {field value :num int}
    {field bound :num int}
    :bind (accept Increment)
    :result [?increment-bounded [view state value] [view state bound]]}
  
  {defhandler counter-handler :type …
    :bind counter
    (match outcome
      ((Ok new-value)
       (HandlerResult :state (set state value new-value) :response (Ok new-value)))
      ((Err e)
       (HandlerResult :state state :response (Err e))))}
  ```

- **B — The listings as proposed, the prose to rework together.** The two listings of A enter chapter 5; the paragraphs on the pair and on coherence are rewritten in a later lot.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-062), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** C'est hyper verbeux, j'aimerais qu'on réflechisse à comment rendre cela plus naturel voir implicite. aussi un `:bind (exp)` me parait sémantiquement criticable comparer à un `:run (exp)` ou similaires (plus expressif)
- **Reading:** kept open: the proposed listings are too verbose; a more natural, even implicit, form is to be found together, and `:bind (exp)` for an actor's selection is criticised next to `:run (exp)` or a similar, more expressive word.


#### Q-SPEC-203 — The generic definition word

**Object.** Q-TYP-201: a generic word, as Racket's `define`, from which guided envelopes are built (`defhandler`, `defunc`, `defanything`), a `defunc` carrying its function type, and a composed definition building refined types — « Toujours pas de l'objet mais très proche sans mutation ». An envelope reads as the generic word with its properties filled in.

**Facts.**

- Racket: `(define id expr)`, `(define (head args) body ...+)`; « The first form binds id to the result of expr, and the second form binds id to a procedure » (Racket reference, define (https://docs.racket-lang.org/reference/define.html)).
- Clojure's `defn` is a macro: « Same as `(def name (fn [params* ] exprs*))` […] with any doc-string or attrs added to the var metadata » (clojure.core (https://clojure.github.io/clojure/clojure.core-api.html)). Common Lisp: `defun` « Defines a new function named function-name in the global environment » (CLHS, defun (https://www.lispworks.com/documentation/HyperSpec/Body/m_defun.htm)).
- You wrote `(defvar alpha :num int32)` (Q-LEX-002); chapter 5 writes `defn`, `defhandler`, `defactor`.
- The old K archive's definition word was `define`.

- **A — def.** Example: `{def ?increment-bounded :type {function int32 int32 {result int32 overflow}} …}`. *For:* short; the root of every `def…` envelope; Clojure's special form.
- **B — define.** Example: `{define ?increment-bounded :type {function int32 int32 {result int32 overflow}} …}`. *For:* Racket's and Scheme's word. *Against:* the envelopes would read `define-…` or keep `def…`.
- **C — defn.** Example: `{defn ?increment-bounded :type {function …} …}`. *For:* the word chapter 5 already writes. *Against:* Clojure's `defn` defines functions only.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-063), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** L'approche de Clojure est la plus pertinente ici.
- **Reading:** the generic definition word is `def`, as Clojure (option A).


#### Q-SPEC-204 — How envelopes are made

**Object.** An envelope (`defunc`, `defhandler`, `defactor`, `defvar`) is the generic word with properties filled in. Who may make one, and how does a composed definition refine a type?

**Facts.**

- Q-TYP-003: « On va coder la stdlib en layer 1 pour définir les fonctions et leurs comportement dans les couches 2 et 3. »
- Annex A, `ERR-MAC-001`: « Macro dont l'expansion introduit une liaison capturable par le site d'appel sans l'avoir déclarée. »

- **A — Layer-1 macros, open to everyone.** An envelope is a layer-1 macro expanded at compile time; the standard library defines `defunc`, `defhandler`, `defactor`, `defvar`, and a program may add its own, under the hygiene of `ERR-MAC-001`.

  ```text
  {defunc ?increment-bounded :type {function …} …}
  ;; reads as
  {def ?increment-bounded :kind function :type {function …} …}
  ```

- **B — A closed set, given by the language.** *For:* every envelope known to the tools. *Against:* a new kind of definition waits for the language.
- **C — A, and envelopes compose.** An envelope may be built from another and add properties to it, each step refining the type of the definitions it makes, without mutating the one it builds on.

  ```text
  {defenvelope defpure :from defunc :purity ?}
  {defpure increment-bounded …}   ;; a defunc that must be pure
  ```

**Answer of the author — 2026-10-27 (VOC-2026-10-27-064), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** an envelope is a layer-1 macro, expanded at compile time, open to every program under the hygiene of `ERR-MAC-001`, and envelopes compose: an envelope may be built from another and add properties to it, each step refining the type of the definitions it makes (option C).


#### Q-SPEC-205 — The name of the function envelope

**Object.** You wrote `defunc`; the head of a function type is `function` (Q-TYP-202) and the abstraction is `lambda` (VOC-2026-10-26-002).

- **A — defunc.** *For:* your word; reads « define function ».
- **B — defun.** *For:* Common Lisp's word.
- **C — defn.** *For:* Clojure's word, and chapter 5's today.
- **D — deffunction.** *For:* the type's head, whole. *Against:* the longest.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-065), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** the function envelope is `defn` (option C), the word chapter 5 already writes.


### Numbers

#### Q-NUM-301 — « fixN = two floN/2 »

**Object.** Your justification of Q-NUM-201 reads: « spécifier une "default value" en cas d'oubli : flo8 = flo8e4 by default ; la corrolaire fixN = two floN/2 ». Two readings are possible.

**Facts.**

- The complex numbers: `com64 = two flo32` (VOC-2026-10-26-023). The fixed-point numbers: `fix4.16`, « 4bit devant et 16bit derrière » (Q-NUM-004).

- **A — comN: the complex numbers.** The corollary is `comN = two floN/2`, as `com64 = two flo32`.
- **B — fixN alone: halves by default.** A fixed-point number given without its point, `fix32`, is `fix16.16` by default, with a warning, as `flo8` is `flo8e4`. Example: `fix32   ;; fix16.16, with a warning`.
- **C — Both.**

**Answer of the author — 2026-10-27 (VOC-2026-10-27-066), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** On applique la même logique pour chaque type qui nécessite de préciser deux segments et on remonte toujours un warning.
- **Reading:** the corollary concerns the complex numbers, `comN = two floN/2`, as `com64 = two flo32` (option A). The same logic holds for every type whose name needs two segments: a default when the second is omitted, always with a warning (`flo8` is `flo8e4`). By this rule a `fixN` given without its point also takes a default with a warning; the default of each such type is put to the next part.


#### Q-NUM-302 — The codes of warnings

**Object.** `flo8` alone gives a warning, not an error (Q-NUM-201). Codes so far are `ERR-XXX-NNN`; Q-ERR-004 plans an index with one page per code, as GHC and Rust do.

**Facts.**

- GHC: « started emiting a code with the format [GHC-12345] for its messages in version 9.6.1 », the index describing « both errors and warnings » (The Haskell Error Index (https://errors.haskell.org/)). C#: an error number such as « CS0029 » (C# compiler messages (https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-messages/)), and « Compiler Warning (level 3) CS0168 » (C# reference (https://learn.microsoft.com/en-us/dotnet/csharp/misc/cs0168)): one prefix for both.
- rustc: « lints are divided into six levels: allow expect warn force-warn deny forbid » (rustc book, lint levels (https://doc.rust-lang.org/rustc/lints/levels.html)).

- **A — A prefix of their own.** Example: `WRN-NUM-001  flo8 without its format: flo8e4 assumed`. *For:* the severity reads in the code; the segments stay shared with errors.
- **B — Named lints with levels (rustc).** Example: `flo8-default   ;; warn by default; allow or deny`. *For:* a project may turn a warning into an error. *Against:* names beside numbered codes.
- **C — One numbering, the level beside the code (GHC, C#).** Example: `NUM-001 (warning)`. *Against:* the existing `ERR-` codes lose their prefix, or warnings carry `ERR`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-067), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** L'approche GHC et CS sont intéressante pour un seul point : préétablir des range de codes pour accueillir de futures messages. Mais je préfère que le code soit explicite, c'est une leçon que j'ai appris dans le monde du contrôle commande qui produit des milliers de codes aux labels incompréhensibles ce qui entraine des acquitements plutot que de déclancher des correctifs.
- **Reading:** warnings take a prefix of their own, `WRN-`, their segments shared with errors (option A): `WRN-NUM-001`. Codes stay explicit: no ranges reserved for future messages, the lesson of control systems whose thousands of obscure codes get acknowledged rather than fixed.


#### Q-NUM-303 — The code of an unresolved typed hole

**Object.** Q-NUM-203: a typed hole takes the smallest width that holds every value the solver can bound, and is refused when the solver bounds none.

**Facts.**

- Annex A: `ERR-SMT-001`, « Intervalle du témoin contredisant les contraintes inférées », and `ERR-SMT-002`; the `ERR-TYP` segment ends at `ERR-TYP-012`.
- Chapter 6: a refusal « nomme l'obligation qu'il n'a pas su décider, ce qu'il y a consacré et ce qui la déciderait ».

- **A — ERR-TYP-013.** A type left incomplete. *For:* the user's view: a type is missing.
- **B — ERR-SMT-003.** The solver bounded nothing. *For:* the message names what the solver spent, as chapter 6 asks.
- **C — ERR-NUM-001.** A segment for numbers, beside the warning of `flo8`. *Against:* a new segment.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-068), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** Un trou typé est à résoudre, si le solveur n'aboutit pas alors le développeur doit préciser son intention dans son code.
- **Reading:** an unresolved typed hole is refused with `ERR-SMT-003`: the solver bounded nothing, and the developer must state the intent in the code (option B).


### Names that link statements, K and proofs

#### Q-TRC-001 — English labels, aligned with the names of K and Lean

**Object.** Your proposal: the names of statements and listings in the Verso document follow the English names specified in K, so that `lst:gestionnaire` becomes `lst:handler` and its proof is attached to a `handler` type. Today the specification holds 234 labels — 77 `thm`, 52 `sec`, 51 `eq`, 31 `tab`, 12 `fig`, 8 `lst`, 3 `req`, 1 `def` — with French slugs (`thm:preservation_type`, `thm:terminaison_couche_3`, `lst:gestionnaire`), referenced 594 times by `{num …}`. A label is never displayed — the reader sees a number — but it becomes the anchor of the published page (`#lbl-lst-gestionnaire`). Page addresses come from section tags (`c5-mise-en-pratique`), not from labels. The 101 Lean theorems of `src/` and `proofs/` are named in English (`linear_to_affine`); K names few elements yet (`LAYERS`, `ADD`…), the core words being chosen in the vocabulary lots (`lambda` for `Lam`).

**Facts.**

- Lean blueprint: a statement carries its label and, beside it, the Lean names that formalise it — `\label{thm:sphere_eversion}` then `\lean{sphere_eversion}`; « `\lean` that lists the Lean declaration names corresponding to the surrounding definition or statement (including namespaces) » (leanblueprint, README (https://github.com/PatrickMassot/leanblueprint)).
- Mathlib: « Terms of Props (e.g. proofs, theorem names) use snake_case. Props and Types (or Sort) (inductive types, structures, classes) are in UpperCamelCase. » (Mathlib naming conventions (https://leanprover-community.github.io/contribute/naming.html)).
- The frozen inventory of `wiki/assurance.md` and the pins of the stage C test name statements by their present labels; like the former file names, they would keep them, with a table of correspondence.

- **A — Every label in English, once the words are chosen.** Labels take the English names fixed by the vocabulary lots and by K; the frozen inventory takes the new labels directly, without a table of correspondence (author's remark). Section tags, which make page addresses, are not touched. *For:* one name from the text to K and Lean. *Against:* published links to a statement's anchor break; 594 references to rewrite, mechanically.

  ```text
  lst:gestionnaire          → lst:handler
  thm:terminaison_couche_3  → thm:layer-3-termination
  ```

- **B — English for new or rewritten objects only.** A label changes when its object is rewritten (as `lst:gestionnaire` and `lst:acteur` in Q-SPEC-202), not before. *For:* no mass rename. *Against:* two languages of labels for a long time.
- **C — Labels unchanged; the link carried by fields.** Names stay as they are; the attachment to K and Lean is written in fields (Q-TRC-002). *For:* nothing published breaks. *Against:* the name alone no longer tells what it is about.

**Author's remark of 2026-10-27, given in the conversation before answering, quoted as given.**

> "l'inventaire figé de wiki/assurance.md garde les anciennes étiquettes, avec une table de correspondance, comme pour les noms de fichiers." non il faut lui donner directement les bons noms pour ne pas maintenir des fichiers de correspondances qui n'ont aucune valeur ajoutée.

- **Reading:** no table of correspondence: if labels are renamed, the frozen inventory takes the new labels directly. Applied at once to file names, which the inventory and the notes of the stage C pins now give in English ([decisions](decisions.md)).

**Answer of the author — 2026-10-27 (VOC-2026-10-27-069), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** every label goes into English once its words are chosen, the frozen inventory taking the new labels directly; section tags are not touched (option A).


#### Q-TRC-002 — How a statement is attached to what it is about and to its proof

**Object.** A shared name makes the link readable, but alone it is a convention: nothing fails if the K element or the Lean proof is renamed or missing. The extension of the specification already has a field for the proof, `formalArtifact := "Module.declaration"`, required with `evidence := "lean-proof"`; no statement uses it yet (64 proof sketches, 12 without evidence, 1 from the literature), and the check of `scripts/spec_checks/statement_ontology.py` is syntactic: it does not look the declaration up. A metatheorem such as type preservation is about the whole calculus, not one type, so a statement may concern several elements, or none.

**Facts.**

- Verso, which builds the specification, resolves a Lean name at elaboration: its `{name}` role calls `realizeGlobalConstNoOverloadWithInfo` and logs an error when the constant does not exist (Verso v4.34.0, InlineLean.lean (https://github.com/leanprover/verso/blob/v4.34.0/src/verso-manual/VersoManual/InlineLean.lean)). The `Spec` library and the implementation `K7pl` are in the same Lake package.
- Lean blueprint: « `\leanok` which claims the surrounding environment is fully formalized »; « `\uses` that lists LaTeX labels that are used in the surrounding environment. This information is used to create the dependency graph »; « `leanblueprint checkdecls` to check that every Lean declaration name that appear in the blueprint exist in the project » (leanblueprint, README (https://github.com/PatrickMassot/leanblueprint)).
- Epistemic separation (project rules): a statement, a K definition, a Lean proof and a test stay distinct objects; a link says which object a proof concerns, it does not make a sketch a proof.

- **A — By name only.** The key of the label is the K name and the Lean name; a script checks that the three agree. *For:* nothing to write beyond the name. *Against:* a statement about several elements, or about the whole calculus, has no single name to share.
- **B — Explicit fields, checked by the build (blueprint style).** Each statement may carry `subject` (the K7PL elements it is about, found in `lexicon/`), `formalArtifact` (its Lean proof, the existing field) and `uses` (the statements it relies on). The build resolves the Lean name as Verso's `{name}` does and the subject in `lexicon/`, and fails if either is missing; the graph of dependencies is drawn from `uses`. *For:* every link checked at each build; several subjects allowed; the graph of the proofs comes for free. *Against:* three fields to keep; the extension and its check to extend.

  ```text
  ::::theorem (label := "thm:handler-purity") (subject := "handler")
    (evidence := "lean-proof") (formalArtifact := "K7pl.Handler.purity")
    (uses := "thm:substitution") …
  ```

- **C — A separate table.** `wiki/assurance.md` maps each label to its K elements, its Lean proof and its tests; a script checks the table. *For:* the manuscript is not touched. *Against:* the link lives away from the statement.

**Author's remark of 2026-10-27, given in the conversation before answering, quoted as given.**

> "un lien vers une preuve pourrait faire échouer le build s'il est cassé" oui s'il s'agit d'une régression, autrement cela ferait un bon compteur pour la mise à jour du STATUS.md

- **Reading:** a link that resolved and no longer does is a regression and fails the build; a link declared but not yet resolvable, such as a proof still to write, is counted, and the count feeds the generated `wiki/STATUS.md`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-070), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** explicit fields, checked by the build: `subject`, `formalArtifact` and `uses` (option B). With the author's remark: a link that resolved and no longer does fails the build; one declared but not yet resolvable is counted for `wiki/STATUS.md`.


#### Q-TRC-003 — The form of the shared key

**Object.** K7PL writes its identifiers in kebab-case (`increase-counter`, Q-LEX-001); Lean refuses the hyphen in a name (it would need `«»`) and Mathlib writes proofs in snake_case and types in UpperCamelCase; the present labels mix `_` and `-`.

- **A — Each place its own case, one mapping rule.** One key, written by the rules of each place, the mapping being mechanical and checked. *For:* each place keeps its conventions.

  ```text
  K7PL     handler, handler-purity
  label    thm:handler-purity
  Lean     K7pl.Handler, K7pl.Handler.purity
  K        HANDLER, rule [handler-purity]
  ```

- **B — Dotted names everywhere.** The key is a path, element then property. *For:* the same text in labels and Lean. *Against:* a dot in labels; K7PL identifiers stay kebab-case.

  ```text
  label    thm:handler.purity
  Lean     K7pl.Handler.purity
  ```

- **C — kebab-case everywhere, Lean included.** Example: `Lean     K7pl.«handler-purity»`. *Against:* every Lean name between «».

**Answer of the author — 2026-10-27 (VOC-2026-10-27-071), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** one key, written by the rules of each place, the mapping between them mechanical and checked (option A).


### The old K archive

#### Q-ARC-001 — Keeping the old K archive

**Object.** Evaluated in research (« Archive review: early K premises »): 20 modules, a K sketch that K 7.1.337 does not compile, with the layers numbered the other way round; much of its intent is in the current specification, and some of it feeds questions of this part.

- **A — Leave it out; the research section is its record.**
- **B — Archive it unchanged in the repository.** Under an archive folder, with REUSE headers.
- **C — Keep only its design notes.**

**Answer of the author — 2026-10-27 (VOC-2026-10-27-072), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Extract remaining value (eg lemme candidat, glyphes, etc.) Then trash it out.
- **Reading:** the archive is not added (option A). What value remains — candidate lemmas, glyphs and the like — is extracted into the research, then the archive is discarded.


## Lot of 2026-10-27, sixth part: texts and holes, `@`, tags and fences, negation, trains and glyphs, booleans and flags, doubled forms and ranges, monomorphisation, handlers and actors, numbers

Opened on 2026-10-27 after the answers to the fifth part. It takes the questions that
the author kept open or asked to clarify there, with the research they asked for, and
the questions those answers raise. Same rules: options to enumerate and objectify, then
the author's choice; **Other** and **Clarify** are always available. The research is
quoted in each question's facts.

Words of the examples that no answer has fixed yet (`accept`, `:on`, `:run`, `sum`…) are placeholders.

### Texts and holes

#### Q-STR-401 — Which `%XX` a raw text decodes

**Object.** Your answer to Q-STR-303: in a raw text `\` stays literal, a quotation mark is written `%22` and a leading space `%20`, so that « l'ensemble du raw text puisse être parsé ». Since a quotation mark inside is `%22`, the closing quotes are found without any escape, and `\` can stay literal everywhere, the closing quotes included. What remains is which `%XX` sequences are decoded.

**Facts.**

- RFC 3986: « A percent-encoded octet is encoded as a character triplet, consisting of the percent character "%" followed by the two hexadecimal digits representing that octet's numeric value », and « Because the percent ("%") character serves as the indicator for percent-encoded octets, it must be percent-encoded as "%25" for that octet to be used as data within a URI » (RFC 3986, §2.1 and §2.4 (https://www.rfc-editor.org/rfc/rfc3986)).

- **A — Every `%XX`, as a URL.** Any `%` followed by two hexadecimal digits is decoded; a literal `%` is written `%25`. Example: `""100%25 sure, %22quoted%22""   ;; the text 100% sure, "quoted"`. *For:* one rule, that of URLs; any byte of the text can be written. *Against:* a `%` before two hexadecimal digits in a regular expression or a format string must be written `%25`.
- **B — Only `%22`, and `%20` at the start.** Every other `%` stays literal. Example: `""%22quoted%22 at 50%""   ;; the text "quoted" at 50%`. *For:* a raw text stays raw almost everywhere. *Against:* the three characters `%22` themselves cannot be written in a raw text.
- **C — `%22`, `%20` and `%25`.** The three sequences that a raw text needs, and `%25` so that the other two can be written literally. Example: `""%2522 is written %22""   ;; the text %22 is written "`. *For:* every text can be written; other `%` stay literal. *Against:* three sequences to remember instead of a rule.

*Not answered yet; carried into the seventh part.*


#### Q-STR-402 — A character and a text of one character

**Object.** Q-STR-306: a character is written like a text of one character, `"a"`, `"μ"`, `"\lambda"`. A character is what a class `{{:alpha:}}` refines (Q-LEX-503), so the type `char` exists; something must tell a character from a text of length one.

**Facts.**

- Python: « There is no separate character type; a character is simply a string of size one » (Python tutorial, 3.1.2 (https://docs.python.org/3/tutorial/introduction.html)).
- Q-NUM-203: a typed hole takes the smallest width that holds every value the solver can bound.

- **A — By the expected type.** A one-character literal is a `char` where a `char` is expected, a text elsewhere. Example: `{field initial :type char}   ;; "a" given to it is a char`. *For:* no mark. *Against:* where nothing expects a type, it is a text.
- **B — A typed hole, resolved like the integers.** A literal holding one Unicode scalar value resolves to `char` unless a text is expected. *Against:* `"é"` written as `e` and a combining accent holds two values, and is a text.
- **C — No `char`, as Python.** A character is a text of length one; classes refine texts. *Against:* ranges of characters and the predicate `[:alpha: c]` then range over texts.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-073), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** No char but varchar as in PostgreSQL and varchar(1) is a single char string, a varchar(0) is an empty string and a varchar(n) is a string of the size n. Hence as a string is typed, it's either explicit in graphem or in bytecode or seen as a typed hole.
- **Reading:** there is no character type. As PostgreSQL's `varchar`, a text type carries its bound: a text of bound 1 is a text of one character, of bound 0 the empty text, of bound n a text of size n. The unit of the bound is stated, graphemes or bytes of UTF-8, and a text type written without it is a typed hole. This makes the unit of Q-STR-305 explicit instead of fixed to bytes. Classes then refine texts of one character. Put to the next part: how a text type is written, and what a class tests when one grapheme holds several code points.


#### Q-STR-403 — The names of invisible characters

**Object.** Q-STR-304: a short closed list of K7PL names for invisible characters, written like LaTeX names, one space after the name being absorbed. A line break is written as such (Q-STR-103). Tick the names to keep; the names are proposals, the characters those of the Unicode Character Database.

**Facts.**

- The Unicode names, from UnicodeData.txt (https://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt): U+0009 CHARACTER TABULATION, U+000D CARRIAGE RETURN, U+00A0 NO-BREAK SPACE, U+00AD SOFT HYPHEN, U+200B ZERO WIDTH SPACE, U+200C ZERO WIDTH NON-JOINER, U+200D ZERO WIDTH JOINER, U+FEFF ZERO WIDTH NO-BREAK SPACE (the byte order mark).

Several options may be chosen.

- **tab — `\tab` — U+0009.** Example: `"a\tab b"`.
- **cr — `\return` — U+000D.** For a text that must hold a carriage return; a line break inside a text is the file's own.
- **nbsp — `\nbsp` — U+00A0.**
- **shy — `\shy` — U+00AD.**
- **zwsp — `\zwsp` — U+200B.**
- **zwnj — `\zwnj` — U+200C.**
- **zwj — `\zwj` — U+200D.**
- **bom — `\bom` — U+FEFF.**

**Answer of the author — 2026-10-27 (VOC-2026-10-27-074), given in the clickable questionnaire, quoted as given.**

- **Choice:** tab, cr, nbsp, shy, zwsp, zwnj, zwj, bom, OTHER
- **Other:** À ajouter au fil de l'eau.
- **Reading:** the eight names are kept — `\tab`, `\return`, `\nbsp`, `\shy`, `\zwsp`, `\zwnj`, `\zwj`, `\bom` — and others are added as they are needed.


#### Q-STR-404 — How a hole is written in a qualified literal, compared

**Object.** Q-STR-307, kept open: compare the approaches, OCaml's and those of memory-safe languages, `@` being reserved for pattern matching inspired by TXR Lisp. Decided: a hole in a qualified literal is a typed hole, passed as a parameter, never pasted as text; a plain text never interpolates. In each option below, the literal and its holes reach the tag's type separately, as Python's templates and JavaScript's tagged templates do.

**Facts.**

- OCaml: « Quoted strings do not interpret any character in a special way but requires that the sequence |quoted-string-id} does not occur in the string itself » (OCaml manual, lexical conventions (https://ocaml.org/manual/5.2/lex.html)): no hole at all.
- Swift: « Each item that you insert into the string literal is wrapped in a pair of parentheses, prefixed by a backslash (`\`) » (Swift book, strings (https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters/)). Kotlin: « To insert a variable into a string, use the $ symbol », and `${}` for an expression (Kotlin, strings (https://kotlinlang.org/docs/strings.html)). Rust: « If a named parameter does not appear in the argument list, format! will reference a variable with that name in the current scope », `format!("{argument}")` (Rust std::fmt (https://doc.rust-lang.org/std/fmt/index.html)).
- Python's template strings evaluate to a `Template`: « Templates provide developers with access to the string and its interpolated values before they are combined », which « enables safety checks, web templating, domain-specific languages » (PEP 750 (https://peps.python.org/pep-0750/)). JavaScript: « Tags allow you to parse template literals with a function » (MDN, template literals (https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals)).
- OWASP: « Prepared statements treat bound values as data rather than SQL syntax. Concatenating untrusted values into the query before preparing it defeats this protection » (SQL injection prevention (https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)).
- TXR: « Free variables occurring in the pattern (denoted by the @ symbol) are bound to the pieces of text occurring in the corresponding positions »; in an output clause, « Variables occurring in an output clause do not match anything; instead their contents are output » (TXR manual (https://man.uex.se/1/txr)).

- **A — `@name`, as TXR.** One mark for a hole that a pattern binds and a template fills; a literal `@` in the foreign text is written `%40`, as in a raw text. Example: `(sql|SELECT * FROM users WHERE name = @who|sql)`. *For:* holes and pattern variables are one notion, as in TXR; `@` keeps the role you reserve for it. *Against:* `@` is frequent in foreign texts (addresses, decorators); `@` stops being an attribute sigil (Q-LEX-601).
- **B — `\(expr)`, as Swift.** The escape character opens a layer-2 expression whose value is passed as a parameter. Example: `(sql|SELECT * FROM users WHERE name = \(who)|sql)`. *For:* `\` already marks what the reader must not take literally. *Against:* the foreign language's own `\` must then be escaped.
- **C — `$name` and `${expr}`, as Kotlin.** *Against:* `$` is SQL's positional parameter and the shell's variable.
- **D — Declared by the tag's type.** Each tag's type declares how its holes are written (Q-STR-307 B). *For:* each foreign language keeps its idiom. *Against:* one rule per tag.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-075), given in the clickable questionnaire, quoted as given.**

- **Choice:** D
- **Justification:** One rule per tag makes sens because we shall specify languages' behaviors at some point, this is just an entry point that wont be available until we specify the type of such tag. We can use SQL as a basis for this feature and define a sql tag (standard sql, not pgsql, nor other rdbms).
- **Reading:** each tag's type declares how its holes are written (option D). It is an entry point, available only once the type of a tag is specified; the first tag to specify is `sql`, after standard SQL, not PostgreSQL's dialect nor another vendor's.


### `@`, tags and fences

#### Q-LEX-601 — `@` reserved for pattern matching: the sigil

**Object.** You reserve `@` for pattern matching inspired by TXR Lisp (Q-STR-307). Chapter 5 makes `@` one of five sigils read at the head of an atom, which « la Phase 0 en fait des attributs », and chapter 4 annotates the constructors of R-expressions, which are patterns, with `@linear`, `@polynomial`, `@stack` and `@backtrack`.

**Facts.**

- TXR: « Query material which is not escaped by the special character @ is literal text, which matches input character for character » (TXR manual (https://man.uex.se/1/txr)).

- **A — `@` for pattern variables only.** `@name` binds in a pattern and fills a template; attributes become properties written with `:`, the R-expression annotations among them (`:linear`). Example: `(match line (@key "=" @value) …)`. *For:* one meaning for `@`. *Against:* chapter 4's annotations are rewritten.
- **B — Two roles told apart by place.** In a pattern or a qualified literal, `@name` is a variable; elsewhere `@` stays an attribute. *For:* chapter 4 unchanged. *Against:* one sigil, two meanings.
- **C — Pattern variables and pattern annotations.** `@` belongs to patterns: `@name` is a variable, and the four annotations of R-expressions stay, as properties of a pattern; outside patterns `@` is no longer a sigil. *For:* every use of `@` is about patterns.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-076), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** @name defines a pattern. @ alone is a char, text@text isn't a pattern but a string (eg. emails)
- **Reading:** `@` belongs to patterns (option C): `@name` defines a pattern, the four annotations of R-expressions (`@linear`, `@polynomial`, `@stack`, `@backtrack`) stay as properties of a pattern, `@` alone is a character, and `text@text` is a text, not a pattern (an e-mail address). The sigils are `#`, `:`, `?` and `!`. The four annotation names cannot name a pattern variable.


#### Q-LEX-602 — An undeclared tag: a warning?

**Object.** Q-LEX-501: an unknown tag leaves its literal plain text, typed by the tag all the same, which helps prototyping. Q-NUM-302: warnings take the prefix `WRN-`.

- **A — No warning.** *For:* prototyping stays quiet.
- **B — A warning, `WRN-LEX-001`.** Example: `WRN-LEX-001  tag sql not declared: its literal is plain text`.
- **C — A warning, and a refusal in a strict mode.** As chapter 6's `+strict-tdd`, a mode that refuses what prototyping allows. Example: `+strict-tags`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-077), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** Warnings shall not block compilation unless the developpers requires "no warning" with some flags.
- **Reading:** an undeclared tag gives the warning `WRN-LEX-001` (option B). A warning never blocks compilation unless the developer asks for « no warning » with a flag.


#### Q-LEX-603 — A literal that holds its own closer

**Object.** Q-LEX-502: `{tag|` is one opening delimiter that waits for `|tag}` (« Keep it simple »), without repeated bars or a second word. What does a literal do when its content holds `|tag}`? The tag names a type, so it cannot be changed freely as OCaml's identifier can.

**Facts.**

- OCaml: the identifier of a quoted string « is a (possibly empty) sequence of lowercase letters and underscores that can be freely chosen to avoid such issue » (OCaml manual, lexical conventions (https://ocaml.org/manual/5.2/lex.html)).

- **A — Percent-encoded, as a raw text.** The `|` of the content is written `%7C`, and the tag's validator reads it back. Example: `{sql|SELECT '%7Csql}' AS s|sql}`. *For:* the rule of raw texts (Q-STR-303). *Against:* the foreign text holds `%7C`.
- **B — Refused, with a code.** Such a literal is rare; it moves to a block or a file. *For:* nothing to learn. *Against:* a few literals cannot be written inline.
- **C — An alias of the tag.** A second name declared for the same type gives another closer, as OCaml chooses another identifier. Example: `{deftype sql2 :alias sql}   {sql2|… |sql} …|sql2}`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-078), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** a literal that holds its own closer is written with an alias of its tag, a second name declared for the same type (option C).


### Negation

#### Q-SPEC-301 — Negation in a recursive query: limits and opportunities

**Object.** Your choice for Q-SPEC-206: a negation in a recursive layer-3 query only of a relation fixed before the recursion (C), with « J'ai besoin d'en connaitre les limites et effets d'opportunités ». The databases literature calls this semipositive Datalog¬. Opportunities: (1) a query stays monotone once each negated relation is replaced by its complement, computed beforehand, so it has a least fixpoint reached by iteration, and chapter 7's `thm:terminaison_lfp` applies as it stands, without a new statement; (2) composing queries gives the stratified negation of option B: one query computes a relation, the next negates it, the order of strata being written in the code. Limits: (1) a query cannot negate what it is computing: the complement of a transitive closure takes two queries; (2) a negation needs a universe — the closed world of the values present —, as `¬` on a class does (Q-LEX-604).

**Facts.**

- « We consider now semipositive datalog¬ programs, which only apply negation to edb relations » (edb: the relations given to a program, not computed by it); « One could eliminate negation from semipositive programs by adding, for each edb relation […], a new edb relation […] holding the complement […] (with respect to the active domain) »; such a program has « a unique minimal fixpoint » (theorem 15.2.2); the program for the complement of transitive closure « is not a semipositive program. However, it can naturally be viewed as the composition of two semipositive programs »; « Stratification, which is studied next, may be viewed as the closure of semipositive programs under composition » (Abiteboul, Hull and Vianu, Foundations of Databases, 1995, chapter 15, §15.2 (http://webdam.inria.fr/Alice/pdfs/Chapter-15.pdf)).

- **A — C enters chapter 7, with these limits.** Case study III states the rule, its reading as semipositive queries, and that a computed relation is negated by a following query.
- **B — A, and the compiler splits a query into strata.** A negation of a relation computed in the same query is accepted when the query can be split into strata, the compiler composing them. *Against:* the stratified negation of Q-SPEC-206 B, with its statement to write and prove.
- **C — Not yet in the specification.**

**Answer of the author — 2026-10-27 (VOC-2026-10-27-079), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** B me parait plus propre, on reprend Q-SPEC-206 en conséquence
- **Reading:** option B: the rule of Q-SPEC-206 C enters the specification, and the compiler also accepts the negation of a relation computed in the same query when the query splits into strata, which it composes. Q-SPEC-206 is revised accordingly to its option B: stratified negation, checked at compile time, with a statement to write and prove.


#### Q-LEX-604 — `¬` on a class: within what? (answer to the clarification)

**Object.** You asked (Q-LEX-504) what would prevent A or favour B. A text holds only Unicode scalar values: Q-STR-305 counts a text in bytes of UTF-8, and UTF-8 cannot encode a surrogate. Under A, `¬[:alpha:]` holds the 2,048 surrogates, which no text can hold: a predicate on a character of a text never meets them, but a materialised complement, `[[¬:alpha:]]` or `((¬:alpha:))`, would list values that are not characters. Nothing prevents A for sets of integers; B keeps the complement inside the type `char`.

**Facts.**

- Unicode: « Unicode scalar value: Any Unicode code point except high-surrogate and low-surrogate code points » (D76); « Because surrogate code points are not Unicode scalar values, any UTF-8 byte sequence that would otherwise map to code points U+D800..U+DFFF is ill-formed » (The Unicode Standard 16.0, chapter 3 (https://www.unicode.org/versions/Unicode16.0.0/core-spec/chapter-3/)).

- **A — All code points.** U+0000 to U+10FFFF, 1,114,112 values, surrogates included.
- **B — Unicode scalar values.** 1,112,064 values, what a text can hold. *For:* the complement stays a set of characters.
- **C — Assigned characters.** *Against:* changes with each Unicode version.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-080), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** the complement of a class is taken among the Unicode scalar values (option B).


### Trains and glyphs

#### Q-SPEC-302 — The delimiter of a train

**Object.** Chapter 5: « La couche 3 admet, en plus de l'écriture nommée, une notation point-free ». Your examples write trains between parentheses — `(fold add div length)`, `(not ((…)))` — which the layer grammar reads as layer 2: inside a `[ ]` block a `( )` is refused (`ERR-TOP-001`). Chapter 5 now writes the mean and the standard deviation between parentheses, as you did.

- **A — Brackets: a train is layer 3.** Example: `[fold add div length]   ;; view: [´+÷≠]`. *For:* the layer grammar is unchanged; a train can sit inside any block.
- **B — Parentheses: a train composes in layer 2.** A train is a layer-2 composition of layer-3 functions, the orchestrator invoking the compiled automata lazily (your remark on laziness). *Against:* a train cannot appear inside a `[ ]` block.
- **C — Either, the delimiter giving the train's layer.** *For:* a train is written where it is used. *Against:* two writings of one train.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-081), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a train is a layer-3 expression, written between brackets (option A): `[fold add div length]`, viewed `[´+÷≠]`.


#### Q-SPEC-303 — Trains of more than three words

**Object.** With typed arities, `(fold add div length)` is a fork. For `(identity sub fold add div length)`, the arities leave two readings: `(identity sub (fold add div length))`, the deviation from the mean, or `((identity sub fold add) div length)`. Chapter 5 now writes its standard deviation with parenthesised trains of at most three words, so that no grouping is assumed.

**Facts.**

- BQN: « In a train, arguments alternate strictly with combining functions between them. Arguments can be either functions or subjects, except for the rightmost one, which has to be a function », and « To keep track of the alternation in a train of all functions, you need to know where each function is relative to the end of the train » (BQN, trains (https://mlochbaum.github.io/BQN/doc/train.html)).

- **A — From the right, as BQN and APL.** The last three words form a fork, which becomes the right argument of the words before it. Example: `(identity sub fold add div length)   ;; x minus its mean`.
- **B — From the left, as the text is read.** The first three words form a fork, which becomes the left argument of the words after it. Example: `(identity sub fold add div length)   ;; (x minus its sum) divided by its length`.
- **C — At most three words.** A longer train is refused with a code; parentheses group it. *For:* nothing to know to read a train. *Against:* more parentheses.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-082), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** Les propositions sont arbitraires et non satisfaisantes.
- **Reading:** kept open: the three groupings proposed are arbitrary and do not satisfy; a principled rule is to be found (next part). Until then, the trains of chapter 5 are grouped explicitly, three words at most.


#### Q-SPEC-304 — Folding several expressions, and quotation

**Object.** Your justification of Q-SPEC-207: « si fold doit s'appliquer à plusieurs sous ensembles alors utiliser la sémantique d'emacs eg (fold '(exp) '(exp2) '(exp3)) où les exp sont évaluées en parallele puis fold ensemble ». With a fixed arity, `fold` takes one function; the reading proposed: the quoted expressions form one list, evaluated in parallel, whose results are folded — `((fold add) '(exp exp2 exp3))`. `'` is not yet a notation of K7PL; chapter 5 already compares a disabled tree (`;(`) to Lisp's quote.

**Facts.**

- Common Lisp: « Single-quote followed by an expression exp is treated by the Lisp reader as an abbreviation for and is parsed identically to the expression (quote exp) » (CLHS 2.4.3 (https://www.lispworks.com/documentation/HyperSpec/Body/02_dc.htm)); « reduce uses a binary operation, function, to combine the elements of sequence » (CLHS, reduce (https://www.lispworks.com/documentation/HyperSpec/Body/f_reduce.htm)).

- **A — `'` is Lisp's quote.** Example: `((fold add) '(exp exp2 exp3))`.
- **B — The disabled tree is the quote.** `;(…)` already reads a tree without running it; a declaration makes it a component of the code. Example: `((fold add) ;(exp exp2 exp3))`. *For:* no new mark.
- **C — No quotation: a list of expressions in layer 2.** Example: `((fold add) (exp exp2 exp3))`. *Against:* evaluation order and parallelism follow the layer, not the form.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-083), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** L'objectif premier de `;(...` est de désactiver une partie de l'arbre
- **Reading:** `'` is Lisp's quote (option A): `'x` reads `(quote x)`. The disabled tree `;(` keeps its first purpose, disabling a part of the tree.


#### Q-LEX-605 — Glyphs in files

**Object.** Decided: files keep the ASCII forms and the editor shows the Unicode ones; a train is written in words. The reader of `lexicon/` still reads a run of glyphs as a train (third part). Uiua stores glyphs, its formatter rewriting names into them (research, fifth part); K7PL stores names.

- **A — Refused outside texts, with a code.** Example: `ERR-LEX-…  glyph in a file: write its alias`.
- **B — Accepted, read as their aliases.** *Against:* a file may hold either form.
- **C — Accepted with a warning.** The formatter rewrites them as words. Example: `WRN-LEX-…`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-084), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** Ppas un warning mais une remarque comme "HEY-LEX-... The glyph has been rewriten... if it's not intended, use the LaTeX description \glyphname"
- **Reading:** a glyph written in a file outside a text is accepted and rewritten as its word by the formatter (option C), not with a warning but with a remark, of the form « HEY-LEX-… The glyph has been rewriten… if it's not intended, use the LaTeX description \glyphname »: a glyph meant as a character is written by its LaTeX name. Put to the next part: the prefix of remarks.


#### Q-LEX-606 — Glyphs to add to the table

**Object.** Chapter 5 writes `´`, `¨`, `√` and `²`, which `tab:glyphes` does not hold; the old K archive had others (research, « Decision and extracted value »). Each added glyph takes an alias per arity, the lemma still to weigh (Q-LEX-505). `«` `»` now show a raw text, and `←` gives way to `def`.

Several options may be chosen.

- **fold — `´` fold.**
- **each — `¨` each.**
- **sqrt — `√` sqrt.**
- **square — `²` square.**
- **swap — `˜` swap.**
- **scan — `` ` `` scan.**
- **table — `⌜` table.**
- **atop — `∘` atop.**
- **over — `○` over.**
- **index — `⊐` index-of.**
- **pick — `⊑` pick.**

**Withdrawn on 2026-10-27 by the author, unanswered: « retire le choix des glyphes car celui ci se fait après le choix des lemmes ». Glyphs are chosen after the lemmas of the vocabulary lots.**


### Booleans and flags

#### Q-LEX-607 — `t`, `f`, and names ending in `-t` or `-f`

**Object.** Q-LEX-506: the boolean values are `t` and `f`, and « `access-f` ou autres constructions de cette nature permettrait d'aisément comprendre l'objectif du test conditionnel ». Two consequences to settle: whether `t` and `f` can still be bound as names (chapter 5's train shapes `(f g)` are now written in mathematics), and what `-f` does in a name.

**Facts.**

- Common Lisp: `t` is a « Constant Variable », « The boolean representing true, and the canonical generalized boolean representing true » (CLHS, t (https://www.lispworks.com/documentation/HyperSpec/Body/v_t.htm)).

- **A — A convention only.** `t` and `f` are constants that nothing can rebind; `access-f` is an ordinary name, the suffix telling the reader which outcome the function acts on. *For:* nothing new for the elaborator.
- **B — A derived form.** For a predicate `access`, `access-f` is the one-armed branch on its false outcome and `access-t` on its true one; `t` and `f` cannot be rebound. Example: `(access-f key (log "missing"))   ;; runs only when (access key) is f`. *For:* a test states the case it handles without writing the other. *Against:* every predicate gains two names.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-085), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** `t` and `f` are constants that nothing can rebind; `access-f` is an ordinary name, its suffix a convention for the reader (option A).


#### Q-LEX-608 — Flags

**Object.** Q-LEX-507: properties for now, flags to study together. « l'emplois de flags `+` et `-` pour indiquer "avec" ou "sans" suppose de connaitre un état par défaut, que des paramètres puissent être désactivée de façon sûre ce qui les rendrait par nature optionnelle donc est-ce que dans ce context l'on pourrait simplement utiliser le flag `+` ? Est-ce que ce serait `+parametrename` ou `+:parametrename`? » Chapter 6 writes the modes `+verify`, `+introspect` and `+strict-tdd`.

**Facts.**

- Rebol: « A refinement specifies a variation in the normal evaluation of a function. Refinements also allow optional arguments to be provided », written after the function name, `copy/part` (REBOL/Core guide, functions (https://www.rebol.com/docs/core23/rebolcore-9.html)).

- **A — `+name` alone: an optional parameter switched on.** Absent means off; there is no `-name`, so no default to know. Example: `(spawn counter +restart-always)`.
- **B — `+name` as a shorthand for `:name t`.** Flags are properties; `+name` only saves writing `t`. Example: `(spawn counter +restart-always)   ;; (spawn counter :restart-always t)`. *For:* one mechanism.
- **C — `+:name`.** The sign applied to a property. Example: `(spawn counter +:restart-always)`. *Against:* two marks.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-086), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** Cela signifie que dans un type composé
  {deftype name
     :process
     :options {
          :some-option
  }}
  les paramètres sous ":option" ont implicitement une propriété booleene dont la valeur par défaut est f
- **Reading:** `+name` is a shorthand for the property `:name t` (option B). In a composed type, the parameters listed under `:options` implicitly carry a boolean property whose default is `f`: an option not written is `f`, and `+name` sets it.


### Doubled forms and ranges

#### Q-LEX-609 — Telling apart the three uses of `[[ … ]]`

**Object.** Q-LEX-401: in layer 3, `[[ … ]]` holds ranges, storage in the caller's frame, and functions applied cell by cell, open to more.

- **A — By what it holds.** A range notation is a range; a type and a size, storage; a function and a rank, cells. Example: `[[ 1..9 ]]   [[ buffer 256 ]]   [[ sum 1 ]]`. *Against:* a further use must not collide with these shapes.
- **B — By a head word.** Example: `[[ range 1 9 ]]   [[ frame buffer 256 ]]   [[ cells sum 1 ]]`. *For:* open to more uses.
- **C — By a property.** Example: `[[ :range 1..9 ]]   [[ :frame buffer 256 ]]   [[ :rank 1 sum ]]`.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-087), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** "range" plutot que ":range" indique l'action de mettre en 'range' (positionner les items en mémoire) ce qui fait plus de sens que de dire qu'il s'agit d'une propriété accueillant un attribut.
- **Reading:** the uses of `[[ … ]]` are told apart by a head word (option B): `[[ range 1 9 ]]`, `[[ frame buffer 256 ]]`, `[[ cells sum 1 ]]`. `range` rather than `:range`: the word names the action of ranging items in memory, not a property holding an attribute. How bounds are written follows in the next part (Q-LEX-610, revised).


#### Q-LEX-610 — How a range is written (Q-LEX-304, reopened)

**Object.** Q-LEX-304 waited for the doubled forms; `[[ … ]]` now holds ranges in layer 3, and `(( … ))` are idiom brackets in layer 2. Today the reader reads `1..9` as one symbol.

**Facts.**

- Haskell: `[e1, e2 .. e3]`, the second element giving the step, and `[e1 ..]` without end (Haskell 2010, §3.10 (https://www.haskell.org/onlinereport/haskell2010/haskellch3.html)). Rust: `a..b` excludes `b`, `a..=b` includes it, `a..` has no end (Rust reference, range expressions (https://doc.rust-lang.org/reference/expressions/range-expr.html)).
- Unicode writes its ranges with two dots: « 0000..007F; Basic Latin » (Unicode Character Database, Blocks.txt (https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt)).

Several options may be chosen.

- **incl — Inclusive bounds, `a..b`.** Example: `[[ 1..9 ]]`.
- **excl — An excluded end, `a..<b`.** Example: `[[ 0..<n ]]`. *For:* indices without writing `n-1`. *Against:* a second notation.
- **step — A step, as Haskell.** Example: `[[ 1 3..9 ]]   ;; 1 3 5 7 9`.
- **open — No end, outside layer 3.** Layer 3 terminates, so an endless range is a lazy list of layer 2, written in a plain pair. Example: `(1..)`.
- **dims — Several ranges, a matrix.** Example: `[[ 1..3 1..3 ]]`.
- **chars — Characters, now that a character is written as a text.** Example: `[[ "a".."z" ]]`.

*Not answered yet; carried into the seventh part, revised for the head word `range` (Q-LEX-609).*


#### Q-LEX-611 — `((:alpha:))` and idiom brackets

**Object.** Q-LEX-503 reads `((:alpha:))` as the code points of the class in order, produced on demand; Q-LEX-402 makes `(( … ))` idiom brackets: a pure function applied to effectful arguments.

**Facts.**

- McBride and Paterson: « any expression built from the Applicative combinators can be transformed to a canonical form in which a single pure function is ‘applied’ to the effectful parts in depth-first order: pure f ⊛ u1 ⊛ … ⊛ un », written `⟦f u1 … un⟧` (Applicative programming with effects, p. 4 (https://www.staff.city.ac.uk/~ross/papers/Applicative.pdf)). With no effectful argument, the form is `pure f`.

- **A — An idiom bracket without arguments.** `((:alpha:))` lifts the class's code points into layer 2 by `pure`: a stream read on demand. The two readings agree. *For:* nothing changes.
- **B — Another form for the stream.** Example: `(stream :alpha:)`.
- **C — No stream form.** Classes keep the predicate, the matrix and the type.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-088), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** `((:alpha:))` is an idiom bracket without arguments (option A): the class lifted into layer 2 by `pure`, a stream read on demand.


#### Q-LEX-612 — `{{ … }}` in layer 1: an evaluation (Q-LEX-403, reopened)

**Object.** You asked for a deeper evaluation of what each option implies, liked Agda's definition and a branching specific to a capability, and asked how Clojure and Lean 4 use these notations and what `{{:alpha:}}` means here. Agda's `{{ }}` are instance arguments; Lean 4's `{{ }}`, also written `⦃ ⦄`, are strict-implicit parameters; Clojure gives `{{ }}` no meaning of its own — it reads a map whose first key is a map — and attaches declarations to a form with metadata, `^{…}`. What each option implies, and what `{{:alpha:}}` would mean under it: **arena** — a named arena is a layer-1 value; `{{:alpha:}}` would name an arena, which a class is not. **instance** — the elaborator searches an argument by its type, as chapter 5 fills a handler, an ambiguous search being refused; `{{:alpha:}}` would ask for a value of the class's type, found by search. **strict** — an argument inferred only once a later explicit argument is given; `{{:alpha:}}` has no reading. **comptime** — overlaps the sigil `#`. **capability** — a `Cap ρ` granted to what follows, a branching specific to capabilities; a class is not a capability. **refine** — `{{ x }}` is a refined type, as Q-LEX-503 reads `{{:alpha:}}`: the characters of the class.

**Facts.**

- Agda: « Instance arguments are a special kind of implicit arguments that get solved by a special instance resolution algorithm, rather than by the unification algorithm used for normal implicit arguments » (Agda documentation (https://agda.readthedocs.io/en/latest/language/instance-arguments.html)).
- Lean 4: « Strict implicit parameters are identical to ordinary implicit parameters, except Lean will only attempt to find argument values when subsequent explicit arguments are provided at a call site. Strict implicit parameters are written in double curly braces (⦃ and ⦄, or {{ and }}) »; instance-implicit parameters, found by type class synthesis, « are written in square brackets » (Lean language reference, functions (https://lean-lang.org/doc/reference/latest/Terms/Functions/)).
- Clojure: « The metadata reader macro first reads the metadata and attaches it to the next form read » (Clojure reader (https://clojure.org/reference/reader)).

Several options may be chosen.

- **arena — Another arena.** Example: `{{ :arena scratch {field buffer :num int8} }}`.
- **instance — Filled by search (Agda).** Example: `{{ counter-handler }}`.
- **strict — Strict implicit (Lean 4).**
- **comptime — Evaluated at compile time.** Example: `{{ table-of-squares 256 }}`.
- **capability — A capability given explicitly.** Example: `{{ :cap clock }}`.
- **refine — A refined type.** Example: `{{:alpha:}}   {{ x :num int32 | [> x 0] }}`.

*Not answered yet; carried into the seventh part.*


### Monomorphisation

#### Q-TYP-401 — The codes of the two refusals of monomorphisation

**Object.** Chapter 6 now refuses a program when an instance is still missing at the exhaustion of the budget, naming the generic, the chain of instances, the budget spent and the budget that would suffice; and it refuses a chain of instances that grows on a cycle, naming the cycle. Neither has a code. Annex A has `ERR-POL-001` for dynamic dispatch, `ERR-TYP` up to `-012`, `ERR-SMT` up to `-003`.

- **A — `ERR-POL-002` and `ERR-POL-003`.** *For:* beside `ERR-POL-001`: nothing shared at run time.
- **B — `ERR-TYP-013` and `ERR-TYP-014`.**
- **C — A new segment, `ERR-MON-001` and `ERR-MON-002`.** *Against:* a new segment.

*Not answered yet; carried into the seventh part.*


#### Q-TYP-402 — Lean's attributes beside the rule of Q-TYP-303

**Object.** Q-TYP-303: a higher-order function is copied for each distinct function argument, in the same budget, and defunctionalised beyond it; « L'approche de Lean est trés pertinente ici! ».

**Facts.**

- Lean 4: `@[specialize]` « Marks a definition to always be specialized during code generation […] By default, instance and function parameters are specialized »; `@[nospecialize]` « Marks a definition to never be specialized during code generation » (Lean 4.34.0, Specialize.lean (https://github.com/leanprover/lean4/blob/v4.34.0/src/Lean/Compiler/Specialize.lean)).

- **A — None: the budget decides alone.**
- **B — `:nospecialize`.** A property that keeps a function defunctionalised, to save code size.
- **C — `:specialize` and `:nospecialize`.** `:specialize` serves a function's copies first in the budget; `:nospecialize` keeps it defunctionalised.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-089), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** no attribute: the budget decides alone (option A).


#### Q-TYP-403 — The limit on recompilation

**Object.** Q-TYP-301 records a limit, to solve without distorting the mechanism: a generic's source is part of its unit's interface, so changing it recompiles the units that use it. Chapter 6 already names a binary, and now an instance, by the hash of a normalised AST.

**Facts.**

- Unison: « Because Unison definitions are identified by their hash, they never change. […] Thus, we can parse and typecheck definitions once, and then store the results in a cache which is never invalidated » (Unison, the big idea (https://www.unison-lang.org/docs/the-big-idea/)).

- **A — A cache keyed by content.** An instance is kept under its hash; a change that leaves the generic's normalised AST unchanged recompiles nothing, and a real change recompiles the instances of that generic, not the units that use it. *For:* follows from naming instances by their hash.
- **B — Instances in the interface.** A unit exports the instances of its generics for type arguments it declares; others are made by the user. *Against:* a list to maintain.
- **C — Accept the limit.**

**Answer of the author — 2026-10-27 (VOC-2026-10-27-090), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a cache keyed by content (option A): an instance is kept under its hash; a change that leaves a generic's normalised AST unchanged recompiles nothing, and a real change recompiles that generic's instances, not the units that use it. This answers the limit recorded with Q-TYP-301.


### Handlers and actors

#### Q-SPEC-305 — Handler and actor, less verbose (Q-SPEC-202, reopened)

**Object.** Q-SPEC-202: « C'est hyper verbeux, j'aimerais qu'on réflechisse à comment rendre cela plus naturel voir implicite. aussi un `:bind (exp)` me parait sémantiquement criticable comparer à un `:run (exp)` ou similaires ». Chapter 5 already lets the elaborator fill an actor's handler by type-directed search when it is omitted, an ambiguous search being refused.

- **A — The actor alone, its handler implicit.** `:run` selects the messages, `:result` gives the pure transition; the handler is found by type and written only to replace it.

  ```text
  {defactor counter
    {field value :num int}
    {field bound :num int}
    :run (accept Increment)
    :result [?increment-bounded [view state value] [view state bound]]}
  ```

- **B — One clause per message.** `:on` pairs a message with its pure transition; the handler is implicit.

  ```text
  {defactor counter
    {field value :num int}
    {field bound :num int}
    :on (Increment [?increment-bounded [view state value] [view state bound]])}
  ```

- **C — Both listings of Q-SPEC-202, with `:run`.** `:bind` is kept for the monadic bind (Q-SPEC-101).

**Answer of the author — 2026-10-27 (VOC-2026-10-27-091), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** one clause per message (option B): `:on` pairs a message with its pure transition, and the handler is implicit. Put to the next part, before the listings of chapter 5 are rewritten: what the implicit handler makes of the transition's result — the new state and the response.


### Numbers

#### Q-NUM-401 — Defaults of the types written with two segments

**Object.** Q-NUM-301: « On applique la même logique pour chaque type qui nécessite de préciser deux segments et on remonte toujours un warning ». Known so far: `flo8` is `flo8e4` with a warning (Q-NUM-201); `com64` is `two flo32` (VOC-2026-10-26-023); `fix4.16` has 4 bits before the point and 16 after (Q-NUM-004).

- **A — Halves, for every such type.** A missing second segment splits the width in two, with a warning. Example: `fix32   ;; fix16.16, with WRN-NUM-…`.
- **B — A default stated with each type.** `fix32` is `fix16.16` now; each later type states its own.
- **C — Only `flo8` and `com` default.** `fix` is refused without its point.

**Answer of the author — 2026-10-27 (VOC-2026-10-27-092), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** halves for every type written with two segments (option A): a missing second segment splits the width in two, with a warning (`fix32` is `fix16.16`).


## Lot of 2026-10-27, seventh part: what the sixth leaves open — texts, trains, ranges and doubled forms, actors, codes and remarks

Opened on 2026-10-27, once the author had answered 20 of the 25 questions of the sixth part.
It carries the four questions not answered yet (Q-LEX-610 revised for the head word `range`)
and the questions those answers raise. Q-LEX-606 is withdrawn: glyphs are chosen after the
lemmas. Same rules: options to enumerate and objectify, then the author's choice; **Other** and
**Clarify** are always available.

Words of the examples that no answer has fixed yet (`accept`, `:sets`, `:reply`, `sum`, `text32g`…) are placeholders.

### Texts

#### Q-STR-401 — Which `%XX` a raw text decodes

**Object.** Your answer to Q-STR-303: in a raw text `\` stays literal, a quotation mark is written `%22` and a leading space `%20`, so that « l'ensemble du raw text puisse être parsé ». Since a quotation mark inside is `%22`, the closing quotes are found without any escape, and `\` can stay literal everywhere, the closing quotes included. What remains is which `%XX` sequences are decoded.

**Facts.**

- RFC 3986: « A percent-encoded octet is encoded as a character triplet, consisting of the percent character "%" followed by the two hexadecimal digits representing that octet's numeric value », and « Because the percent ("%") character serves as the indicator for percent-encoded octets, it must be percent-encoded as "%25" for that octet to be used as data within a URI » (RFC 3986, §2.1 and §2.4 (https://www.rfc-editor.org/rfc/rfc3986)).

- **A — Every `%XX`, as a URL.** Any `%` followed by two hexadecimal digits is decoded; a literal `%` is written `%25`. Example: `""100%25 sure, %22quoted%22""   ;; the text 100% sure, "quoted"`. *For:* one rule, that of URLs; any byte of the text can be written. *Against:* a `%` before two hexadecimal digits in a regular expression or a format string must be written `%25`.
- **B — Only `%22`, and `%20` at the start.** Every other `%` stays literal. Example: `""%22quoted%22 at 50%""   ;; the text "quoted" at 50%`. *For:* a raw text stays raw almost everywhere. *Against:* the three characters `%22` themselves cannot be written in a raw text.
- **C — `%22`, `%20` and `%25`.** The three sequences that a raw text needs, and `%25` so that the other two can be written literally. Example: `""%2522 is written %22""   ;; the text %22 is written "`. *For:* every text can be written; other `%` stay literal. *Against:* three sequences to remember instead of a rule.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** every `%XX` is decoded in a raw text, as in a URL, and a literal `%` is written `%25` (option A). `\` stays literal everywhere, the closing quotes being found without escape.


#### Q-STR-405 — How a text type is written

**Object.** Q-STR-402: no character type; as `varchar`, a text type carries its bound, counted in graphemes or in bytes of UTF-8 as the type states, and a text type written without them is a typed hole. Numbers are written as a family and a width, `int32`, `flo64`, after a property that announces them (`:num int32`).

- **A — A family, a bound and a unit letter.** *For:* written as the numbers are.

  ```text
  {field name :text text32g}   ;; 32 graphemes
  {field key :text text16b}    ;; 16 bytes
  {field note :text text}      ;; a typed hole
  ```

- **B — `varchar`, with the same suffix.** Example: `{field name :text varchar32g}`. *For:* the word you used. *Against:* longer, and `var` reads as variable.
- **C — The unit as a property.** Example: `{field name :text {text 32 :unit grapheme}}`. *Against:* heavier for a frequent type.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-002), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** str, str8, etc.
  Les grapèmes sont comptés que pour l'interface de développement, le type préserve la mémoire, donc strN est équivament à intN => alloue un nombre de bits
- **Reading:** text types are written `str` and `strN` (`str8`…). Graphemes are counted only by the development interface; the type keeps to memory: `strN`, as `intN`, allocates N bits, and `str` alone is a typed hole. This replaces the unit stated by the type (Q-STR-402): the bound always counts bits. Put to the next part: a width that is not a multiple of 8.


#### Q-STR-406 — A class tested on a grapheme of several code points

**Object.** A class such as `:alpha:` is a set of code points (UTS #18), and a text of bound 1 counted in graphemes may hold several of them: `é` written as `e` and a combining accent is one grapheme and two code points. What does `[:alpha: c]` answer then?

**Facts.**

- UTS #18: « an implementation could interpret \X as matching any extended grapheme cluster, while interpreting "." as matching any single code point » (Unicode, UTS #18 (https://www.unicode.org/reports/tr18/)).

- **A — Every code point is in the class.** Example: `[:alpha: "é"]   ;; t: e and the accent are both Alphabetic`.
- **B — The first code point, the base, is in the class.** *For:* the base names the character a reader sees.
- **C — Only a text of one code point.** A class tests a text of bound 1 counted in bytes or code points; a grapheme of several code points is refused with a code. *Against:* a third unit.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** a class tested on a grapheme of several code points tests the first, its base (option B).


### Trains

#### Q-SPEC-306 — Trains longer than three words: a principled reading

**Object.** Q-SPEC-303, kept open: « Les propositions sont arbitraires et non satisfaisantes ». Three readings follow from a principle already in K7PL rather than from a convention: the types (chapter 5 refuses an ambiguous search rather than choosing), the fixed arities you asked for (prefix notation needs no grouping once every arity is fixed), and the stack effects that chapter 5 gives its concatenative blocks (`[dup *]` has the effect `(1 – 2)`). Until then, chapter 5 groups its trains explicitly, three words at most.

**Facts.**

- J: « A train of two or three verbs produces a verb and (by repeated resolution), a verb train of any length also produces a verb. For example, the trains +-*% and +-*%^ are equivalent to +(-*%) and +-(*%^) » (J Dictionary, F. Trains (https://www.jsoftware.com/help/dictionary/dictf.htm)).
- Prefix notation: « Assuming a given arity of all involved operators […], any well-formed prefix representation is unambiguous, and brackets within the prefix expression are unnecessary » (Wikipedia, Polish notation (https://en.wikipedia.org/wiki/Polish_notation)).
- Factor: « A stack effect declaration takes the following form: ( input1 input2 ... -- output1 ... ) » (Factor documentation, stack effect declarations (https://docs.factorcode.org/content/article-effects.html)).

- **A — By the types: one reading or a refusal.** The elaboration keeps the groupings that type-check; one is accepted, several are refused as ambiguous with a code that shows them, as an ambiguous handler search is. Example: `[identity sub fold add div length]   ;; two readings type-check: refused, both shown`. *For:* no grouping to learn. *Against:* whether a train is accepted depends on the types of its words.
- **B — By the arities, in prefix order.** Each word takes as many operands as its arity, read left to right; composition is written by a word (`atop`). *For:* never ambiguous, whatever its length. *Against:* the combining word comes first, not between its operands.

  ```text
  [div fold add length]                ;; the mean
  [sub identity div fold add length]   ;; x minus its mean
  ```

- **C — By the stack, as the concatenative blocks.** A train is a block whose words consume and produce values on a stack, each by its stack effect. Example: `[dup fold add swap length div]   ;; the mean`. *For:* one reading for trains and blocks. *Against:* stack words (`dup`, `swap`) appear in the train.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-004), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** Explore comment FIXAPL aborde le sujet. Une notion importante ici, c'est que le type d'opération indique l'arité attendue, ce qui permet de colorer le graphème comme Uiua, BQN, FIXAPL, etc., mais aussi comme colorForth. Recherche dans la spec ce que j'ai déjà écrit, car une bonne partie des réponses s'y trouve.
- **Reading:** kept open, with research asked for: how FIXAPL treats trains; the type of an operation gives its expected arity, which lets the view colour a glyph, as Uiua, BQN and FIXAPL do, and also as colorForth does; and what the specification already says, where much of the answer is. Researched in the eighth part.


### Doubled forms and ranges

#### Q-LEX-610 — How a range is written, with the head word `range`

**Object.** Revised after Q-LEX-609: the uses of `[[ … ]]` take a head word, and `[[ range 1 9 ]]` ranges items in memory. What remains is how bounds, ends, steps and dimensions are written. Today the reader reads `1..9` as one symbol.

**Facts.**

- Haskell: `[e1, e2 .. e3]`, the second element giving the step, and `[e1 ..]` without end (Haskell 2010, §3.10 (https://www.haskell.org/onlinereport/haskell2010/haskellch3.html)). Rust: `a..b` excludes `b`, `a..=b` includes it, `a..` has no end (Rust reference, range expressions (https://doc.rust-lang.org/reference/expressions/range-expr.html)).
- Unicode writes its ranges with two dots: « 0000..007F; Basic Latin » (Unicode Character Database, Blocks.txt (https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt)).

Several options may be chosen.

- **args — Bounds as arguments, both included.** Example: `[[ range 1 9 ]]   ;; 1 to 9`.
- **dots — `a..b` kept, inside `range`.** Example: `[[ range 1..9 ]]`. *Against:* two notations for one range.
- **below — An excluded end, by a property.** Example: `[[ range 0 :below n ]]   ;; 0 to n-1`. *For:* indices without writing `n-1`.
- **step — A step, by a property.** Example: `[[ range 1 9 :step 2 ]]   ;; 1 3 5 7 9`.
- **open — No end, outside layer 3.** Layer 3 terminates, so an endless range is a lazy list of layer 2. Example: `(range 1)`.
- **dims — Several ranges, a matrix of index pairs.** Example: `[[ range [1 3] [1 3] ]]`.
- **chars — Texts of one character.** Example: `[[ range "a" "z" ]]`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-005), given in the clickable questionnaire, quoted as given.**

- **Choice:** CLARIFY
- **Clarification:** est-ce que ça fait vraiment sens au regard de la nature de la couche 3? critique cela. je préfèrerais systématiquement garder {{:alpha:}}, ((:alpha:)) et [[:alpha:]] face à des formes syntaxique ambigües
- **Reading:** clarification asked: whether `[[ range … ]]` makes sense given the nature of layer 3, with a critique; the author would rather always keep `{{:alpha:}}`, `((:alpha:))` and `[[:alpha:]]` than ambiguous syntactic forms. Answered in the eighth part.


#### Q-LEX-614 — `[[:alpha:]]` beside the head words

**Object.** Q-LEX-503 reads `[[:alpha:]]` as the matrix of the bounds of a class's runs; Q-LEX-609 gives every use of `[[ … ]]` a head word (`range`, `frame`, `cells`).

- **A — `[[ range :alpha: ]]`.** The runs of a class are its ranges. *For:* one head word for ranges of numbers and of characters.
- **B — `[[:alpha:]]` kept.** A class name alone is a fourth use, recognised by its colons.
- **C — No matrix form.** Classes keep the predicate, the stream and the type.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-006), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** `[[:alpha:]]` is kept, a use of `[[ … ]]` recognised by the colons of the class name (option B).


#### Q-LEX-612 — `{{ … }}` in layer 1: an evaluation (Q-LEX-403, reopened)

**Object.** You asked for a deeper evaluation of what each option implies, liked Agda's definition and a branching specific to a capability, and asked how Clojure and Lean 4 use these notations and what `{{:alpha:}}` means here. Agda's `{{ }}` are instance arguments; Lean 4's `{{ }}`, also written `⦃ ⦄`, are strict-implicit parameters; Clojure gives `{{ }}` no meaning of its own — it reads a map whose first key is a map — and attaches declarations to a form with metadata, `^{…}`. What each option implies, and what `{{:alpha:}}` would mean under it: **arena** — a named arena is a layer-1 value; `{{:alpha:}}` would name an arena, which a class is not. **instance** — the elaborator searches an argument by its type, as chapter 5 fills a handler, an ambiguous search being refused; `{{:alpha:}}` would ask for a value of the class's type, found by search. **strict** — an argument inferred only once a later explicit argument is given; `{{:alpha:}}` has no reading. **comptime** — overlaps the sigil `#`. **capability** — a `Cap ρ` granted to what follows, a branching specific to capabilities; a class is not a capability. **refine** — `{{ x }}` is a refined type, as Q-LEX-503 reads `{{:alpha:}}`: since Q-STR-402, the texts of one character that the class admits.

**Facts.**

- Agda: « Instance arguments are a special kind of implicit arguments that get solved by a special instance resolution algorithm, rather than by the unification algorithm used for normal implicit arguments » (Agda documentation (https://agda.readthedocs.io/en/latest/language/instance-arguments.html)).
- Lean 4: « Strict implicit parameters are identical to ordinary implicit parameters, except Lean will only attempt to find argument values when subsequent explicit arguments are provided at a call site. Strict implicit parameters are written in double curly braces (⦃ and ⦄, or {{ and }}) »; instance-implicit parameters, found by type class synthesis, « are written in square brackets » (Lean language reference, functions (https://lean-lang.org/doc/reference/latest/Terms/Functions/)).
- Clojure: « The metadata reader macro first reads the metadata and attaches it to the next form read » (Clojure reader (https://clojure.org/reference/reader)).

Several options may be chosen.

- **arena — Another arena.** Example: `{{ :arena scratch {field buffer :num int8} }}`.
- **instance — Filled by search (Agda).** Example: `{{ counter-handler }}`.
- **strict — Strict implicit (Lean 4).**
- **comptime — Evaluated at compile time.** Example: `{{ table-of-squares 256 }}`.
- **capability — A capability given explicitly.** Example: `{{ :cap clock }}`.
- **refine — A refined type.** Example: `{{:alpha:}}   {{ x :num int32 | [> x 0] }}`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-007), given in the clickable questionnaire, quoted as given.**

- **Choice:** refine
- **Reading:** `{{ … }}` in layer 1 is a refined type; `{{:alpha:}}` is the refined type of the texts of one character that the class admits.


### Actors

#### Q-SPEC-307 — What the implicit handler makes of a transition

**Object.** Q-SPEC-305: an actor pairs each message with its pure transition, `:on`, and its handler is implicit. In chapter 5 the transition `?increment-bounded` returns a `Result`, and the handler of `lst:gestionnaire` turns `Ok` into a new value of the field `value` with the response `Ok`, and `Err` into an unchanged state with the response `Err`. Layer 3 cannot build a `HandlerResult`, a layer-2 construction (`ERR-TOP-001`), so the implicit handler, in layer 2, builds it.

- **A — The rule of `Result`, the field named in the clause.** `Ok v` sets the named field to `v` and answers `Ok v`; `Err e` leaves the state and answers `Err e`.

  ```text
  {defactor counter
    {field value :num int}
    {field bound :num int}
    :on (Increment :sets value [?increment-bounded [view state value] [view state bound]])}
  ```

- **B — The whole new state, the response by a property.** The transition returns the new state; `:reply` gives the response.

  ```text
  {defactor counter
    {field value :num int}
    {field bound :num int}
    :on (Increment [set state value [+ [view state value] 1]] :reply …)}
  ```

- **C — A, and a handler written out when the rule does not fit.** The handler stays implicit for the rule of `Result` and is written as in `lst:gestionnaire` otherwise.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-008), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** B est possible aussi mais c'est qu'il nous faut une approche plus systémique pour identifier et composer les scénarios avec la question : est-ce que je souhaite séparer une vérification d'une transformation, d'une livraison, etc. c'est ici encore un point sur lequel dous devrions échanger donc pour l'instant on valide A.
- **Reading:** the rule of `Result`, the field named in the clause (option A): `Ok v` sets the field named by `:sets` to `v` and answers `Ok v`; `Err e` leaves the state and answers `Err e`. B is possible too, but a more systemic approach is needed to identify and compose scenarios — whether to separate a check from a transformation, from a delivery, and so on —, a point to discuss together; A is accepted for now.


### Codes and remarks

#### Q-TYP-401 — The codes of the two refusals of monomorphisation

**Object.** Chapter 6 now refuses a program when an instance is still missing at the exhaustion of the budget, naming the generic, the chain of instances, the budget spent and the budget that would suffice; and it refuses a chain of instances that grows on a cycle, naming the cycle. Neither has a code. Annex A has `ERR-POL-001` for dynamic dispatch, `ERR-TYP` up to `-012`, `ERR-SMT` up to `-003`.

- **A — `ERR-POL-002` and `ERR-POL-003`.** *For:* beside `ERR-POL-001`: nothing shared at run time.
- **B — `ERR-TYP-013` and `ERR-TYP-014`.**
- **C — A new segment, `ERR-MON-001` and `ERR-MON-002`.** *Against:* a new segment.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-009), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** `ERR-POL-002` for an instance still missing when the budget is spent, `ERR-POL-003` for a chain of instances that grows on a cycle (option A).


#### Q-SPEC-308 — The code of a query that does not stratify

**Object.** The corollary `thm:terminaison_strates` (chapter 2): the compiler refuses a layer-3 query whose dependencies cycle through a negation. Annex A has `ERR-TER-001` for a recursion without a fold or `terminates`.

- **A — `ERR-TER-002`.** *For:* beside the other refusal of termination.
- **B — A new segment, `ERR-STR-001`.** *Against:* a new segment.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-010), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a query that does not stratify is refused with `ERR-TER-002` (option A).


#### Q-LEX-613 — The prefix of remarks

**Object.** Q-LEX-605: a glyph written in a file is rewritten as its word, « pas un warning mais une remarque comme "HEY-LEX-..." ». A remark is a third kind beside errors (`ERR-`) and warnings (`WRN-`).

- **A — `HEY-`, as you wrote.** Example: `HEY-LEX-001  glyph ´ rewritten as fold`.
- **B — `NOTE-`.** Example: `NOTE-LEX-001`.
- **C — `INF-`.** Example: `INF-LEX-001`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-011), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** remarks take the prefix `HEY-`, as written (option A): `HEY-LEX-001` for a rewritten glyph.


## Lot of 2026-10-28, eighth part: trains after FIXAPL, a critique of `[[ range … ]]`, text widths, the actor

Opened on 2026-10-28, once the author had answered the seventh part. It carries the research
those answers asked for — how FIXAPL reads trains and how languages colour words, a critique of
`[[ range … ]]` given the nature of layer 3 — and the questions they raise. Same rules: options
to enumerate and objectify, then the author's choice; **Other** and **Clarify** are always
available.

Words of the examples that no answer has fixed yet (`fold`, `square`, `identity`, `rank`, `+frame`…) are placeholders.

### Trains

#### Q-SPEC-309 — Trains: FIXAPL's rule, the arity of each word

**Object.** Q-SPEC-306, kept open with research asked for. What the specification already says: every word of a train carries a typed arity — monadic, dyadic, at most triadic, never n-ary — and it is what tells a train from an application (chapter 5); the glossary reads the arity of a train from the number of its terms, which settles two and three words but not more. FIXAPL draws the missing rule from fixed arities: the arity of each word, not the length of the train, decides how it combines. Applied to K7PL, read from the right, a monadic word composes (atop) with everything on its right, a dyadic word forms a fork with the word on its left and everything on its right, a dyadic word with nothing on its left takes the train's left argument, and a bracketed group counts as one word. The standard deviation then needs one inner group instead of five. FIXAPL knows two arities only, and K7PL a third.

**Facts.**

- FIXAPL: « Fixed-arity functions provide a wonderful solution to the age-old train problem of how to divide a tacit expression of juxtaposed functions into fork, atop, or hook combinators. […] If a function is dyadic, apply it like a fork (or a hook, if applicable). If a function is monadic, apply it as atop »; « FIXAPL expressions run from right to left »; « A dyadic function with another function directly to its left forms a fork. The function on the left is called with the input argument(s), and the result is passed as the left argument to the right function »; « If the leftmost part of an expression is a dyadic function, the left argument to that function is the left input »; « The arity of the resulting function is the greatest number of inputs required by any of these rules »; for a function written out, « If only `⍵` is present, the function is monadic, if `⍺` is present, the function is dyadic » (FIXAPL, README (https://github.com/Jacob-Lockwood/fixapl)).
- Chapter 5 today: « Un train de plus de trois mots s'écrit groupé, trois mots au plus par paire de crochets »; the standard deviation is `[sqrt [[fold add [square [identity sub [fold add div length]]]] div length]]`.
- Chapter 4: « R-expressions et calcul tacite sont ainsi les deux visages d'une même exigence : toute exécution de couche 3 est un automate dont la mémoire se calcule avant l'exécution, jamais pendant »; the glossary: a train is a « Suite de fonctions composées par juxtaposition, dont l'arité de l'assemblage se lit sur le nombre de termes ».

- **A — FIXAPL's rule, triadic words taking two words on their left.** Read from the right: a monadic word is an atop, a dyadic word a fork with the word on its left, a triadic word a fork with the two words on its left. *For:* no length rule; grouping follows the arities the types already carry. *Against:* the triadic case is K7PL's own, without precedent in FIXAPL.

  ```text
  [fold add div length]                                          ;; the mean
  [identity sub fold add div length]                             ;; x minus its mean
  [sqrt [fold add square identity sub fold add div length] div length]   ;; the standard deviation
  ```

- **B — FIXAPL's rule, triadic words kept out of trains.** As A, but a triadic word is only ever applied, never placed in a train. *For:* exactly FIXAPL's rule.
- **C — Explicit grouping, three words at most.** As chapter 5 writes today. *Against:* five inner groups for the standard deviation.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-012), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** FIXAPL's rule, triadic words kept out of trains (option B). A train is read from the right: a monadic word applies to the result of what is on its right; a dyadic word with a word on its left forms a fork with it, the word on the left being applied to the train's arguments and giving the dyadic word its left argument; a dyadic word with nothing on its left takes the train's left argument; a bracketed group counts as one word; a triadic word is only ever applied, never placed in a train. This replaces the grouping by three words at most: the standard deviation is written `[sqrt [fold add square identity sub fold add div length] div length]`.


#### Q-LEX-617 — Colouring words by what their type says

**Object.** Q-SPEC-306: « le type d'opération indique l'arité attendue, ce qui permet de colorer le graphème comme Uiua, BQN, FIXAPL, etc., mais aussi comme colorForth ». In K7PL the colour would be a view, like the glyphs: files keep the words, and the editor colours them from their types. The view could also mark the groups a train forms (Q-SPEC-309).

**Facts.**

- colorForth: « The colors of program code in colorForth have semantic meaning. Red words start a definition, and green words are compiled into the current definition. […] Yellow words are executed » (Wikipedia, colorForth (https://en.wikipedia.org/wiki/ColorForth)).
- BQN: « Every value can be used in any of four syntactic roles »; « Primitive glyphs follow patterns: 1-modifiers like ˝ are superscripts and 2-modifiers like ○ use circles » (BQN, context-free grammar (https://mlochbaum.github.io/BQN/doc/context.html)).

- **A — By arity.** One colour for monadic, dyadic and triadic words, one for modifiers.
- **B — By role, the four roles of BQN.** Values, functions, modifiers taking one function, modifiers taking two; BQN marks the role in the shape of its glyphs.
- **C — Both.** The hue gives the role, the shade the arity.
- **D — Not in the specification.** Left to the editor.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-013), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** words are coloured by role (option B), read from their types: values, functions, modifiers taking one function, modifiers taking two. The colouring is a view of the editor, as the glyphs are; the colours themselves are not chosen.


### Doubled forms in layer 3

#### Q-LEX-615 — `[[ … ]]` in layer 3: a critique of the head words

**Object.** Q-LEX-610, clarification asked: « est-ce que ça fait vraiment sens au regard de la nature de la couche 3? critique cela. je préfèrerais systématiquement garder {{:alpha:}}, ((:alpha:)) et [[:alpha:]] face à des formes syntaxique ambigües ». The critique: (1) layer 3 runs as an automaton whose memory is computed before execution, so a range is a layer-3 value only if its size is known before running — bounds written as literals, computed at compile time (`#`), or bounded by a grade; (2) with a head word, `[[ range 1 9 ]]` reads as `range` applied to 1 and 9, which the plain `[range 1 9]` already says, a word in head position applied to the rest: the doubled bracket adds nothing, although a doubled form is meant to make precise, by its content, a form of its layer; (3) chapter 5 says `[[ range … ]]` « range des éléments en mémoire, comme un intervalle »: placing in memory is what `[[ frame … ]]` does, a property of storage rather than a value, and applying a function cell by cell is the rank of a function, which J writes with a conjunction, `u"n`, not with a bracket; (4) the class forms you keep are literals recognised by the shape of their content, without a head word, and an interval written `[[1..9]]` would be one more, whose size the reader sees.

**Facts.**

- Chapter 4: « R-expressions et calcul tacite sont ainsi les deux visages d'une même exigence : toute exécution de couche 3 est un automate dont la mémoire se calcule avant l'exécution, jamais pendant »; the glossary: a train is a « Suite de fonctions composées par juxtaposition, dont l'arité de l'assemblage se lit sur le nombre de termes ».
- J: « The verb `u"n` applies u to each cell as specified by the rank n » (J Dictionary, Rank (https://www.jsoftware.com/help/dictionary/d600v.htm)).

- **A — Literal shapes only.** `[[ … ]]` holds an interval or a class, recognised by its content; storage in the caller's frame is a property of a declaration, and cell-wise application a modifier of trains. Revises Q-LEX-609 B. Example: `[[1..9]]   [[:alpha:]]   {field buffer :num int8 +frame}   [rank sum 1]`. *For:* no head word to tell apart; every size is visible before execution.
- **B — Head words kept (Q-LEX-609 B).** Bounds must then be known before execution: literals, `#`, or a grade. Example: `[[ range 1 9 ]]   [[ frame buffer 256 ]]   [[ cells sum 1 ]]   [[:alpha:]]`.
- **C — Literal shapes for intervals and classes, head words for the rest.** Example: `[[1..9]]   [[:alpha:]]   [[ frame buffer 256 ]]   [[ cells sum 1 ]]`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-014), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** literal shapes only (option A), which revises Q-LEX-609 B: in layer 3, `[[ … ]]` holds an interval or a class, recognised by its content, without a head word; storage in the caller's frame is a property of a declaration (`+frame`), and cell-wise application a modifier of trains (`rank`), both words being placeholders.


#### Q-LEX-616 — How an interval is written, if it is a literal

**Object.** For options A and C of Q-LEX-615. Its bounds are literals or computed at compile time, so its size is known before execution. By chapter 5's reading rule, `1..9` is one atom today, like `x-1`.

**Facts.**

- Haskell: « The arithmetic sequence [e1, e2 .. e3] denotes a list of values of type t », the second element giving the step, and `[ e1.. ] = enumFrom e1` has no end (Haskell 2010, §3.10 (https://www.haskell.org/onlinereport/haskell2010/haskellch3.html)).
- Rust: `start..end` is the range `start ≤ x < end`, `start..=end` the range `start ≤ x ≤ end` (Rust reference, range expressions (https://doc.rust-lang.org/reference/expressions/range-expr.html)).
- Unicode writes its ranges with two dots: « 0000..007F; Basic Latin » (Unicode Character Database, Blocks.txt (https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt)).

Several options may be chosen.

- **incl — Inclusive bounds, `a..b`.** Example: `[[1..9]]   ;; 1 to 9`.
- **excl — An excluded end, `a..<b`.** Example: `[[0..<#n]]   ;; 0 to n-1, n known at compile time`.
- **step — A step, as Haskell.** Example: `[[1 3..9]]   ;; 1 3 5 7 9`.
- **dims — Several intervals, a matrix of index pairs.** Example: `[[1..3 1..3]]`.
- **chars — Texts of one character.** Example: `[["a".."z"]]`.
- **open — No end, in layer 2 only.** A lazy list, outside layer 3. Example: `(1..)`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-015), given in the clickable questionnaire, quoted as given.**

- **Choice:** incl, step, dims, chars, OTHER
- **Other:** open en couche 2 serait logiquement ((1..n))

  pour le bornage, je préfèrerais utiliser un mot clé dédié pour représenter les bornes suivantes : `]1..9] ; [1..9] ; [1..9[ et ]1..9[` (p.ex "inner, outer, left, right => largement criticable)
- **Reading:** inclusive bounds `a..b`, a step given by a second element (`[[1 3..9]]`), several intervals forming a matrix of index pairs (`[[1..3 1..3]]`), and texts of one character as bounds (`[["a".."z"]]`); the excluded end `a..<b` is not taken. Bounds other than the closed ones of `a..b` — written `]1..9]`, `[1..9[` and `]1..9[` in the author's message, with `[1..9]` — are marked by a dedicated keyword; the author's example names (inner, outer, left, right) are open to criticism and wait for the choice of words. In layer 2, the lazy interval is written in the doubled pair of its layer, `((1..n))`, rather than `(1..)`; whether its end may be left out is not said.


### Texts

#### Q-STR-407 — A text width that is not a multiple of 8

**Object.** Q-STR-405: `strN`, as `intN`, allocates N bits, and the text is encoded in UTF-8, whose units are bytes. Integers take any width (third part). What does `str12` mean?

- **A — Refused, with a code.** *For:* every width holds whole bytes.
- **B — Rounded up to a whole byte, with a warning.** Example: `str12   ;; str16, WRN-…`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-016), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** Emacs encode le text sur 7bits, il existe d'autres conventions dans la nature, donc bien que utf8 soit un défaut appliqué à K7PL en cas de résolution de typed hole, il faut laisser la possibilité de créer du typage ascii, utf16, utf32, emacs, etc.
- **Reading:** the width question is not answered as asked; the encoding becomes part of the text type. UTF-8 is the default, the one chosen when a typed hole is resolved, and other conventions — ASCII, UTF-16, UTF-32, Emacs's, and so on — can be written in the type. Still open: how the encoding is written, and what a width that is not a multiple of the encoding's unit means (`str12` in UTF-8). On Emacs, the Emacs Lisp manual describes its internal representation as an extension of UTF-8 that stores each character as 1 to 5 bytes, a codepoint being a 22-bit integer (research).


### Actors

#### Q-SPEC-310 — Applying the actor's `:on … :sets` form now

**Object.** Q-SPEC-307: A is accepted « pour l'instant », with « il nous faut une approche plus systémique pour identifier et composer les scénarios ». Applying it to chapter 5 goes beyond the listings: `bind-to` is one of the six written forms of the definition `def:elaboration`, and the proof sketch of the corollary on static syntax (`thm:staticite_syntaxe`) names its resolution by type-directed search as the only place where a name is produced. With `:on … :sets`, the handler is derived by the rule of `Result` and no name is searched.

- **A — Now.** `lst:acteur` takes the `:on … :sets` form, `lst:gestionnaire` shows the handler the clause implies, the row of `def:elaboration` becomes the `:on` clause, the remark on `bind-to` in « Mise en pratique » is rewritten, and the proof sketch and the note of `thm:staticite_syntaxe` no longer name it; the statement itself is unchanged.
- **B — After the discussion on scenarios.** Chapter 5 keeps `bind-to` until checks, transformations and deliveries are composed.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-017), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** rappel toi qu'on a retiré "bind-to" au profit de "bind" et des mots issues des monades. nous devons encore les comparer avec les mots des effets algébriques.
- **Reading:** apply now (option A). The author recalls that `bind-to` already gave way to `bind` and the words of monads (fourth part: `bind` for Haskell's `>>=`, `:bind`, `:return`), and that those words must still be compared with the words of algebraic effects; that comparison belongs to the choice of words.


## Lot of 2026-10-28, ninth part: the forms left before the choice of words — trains, intervals, types, patterns, modules and macros

Opened on 2026-10-28 at the author's request, after the eighth part: a short part on the
points A1 to A4 of the inventory of what remains before the choice of words. Points B (decided,
to carry into the specification and the reader) and C (the words themselves) are not asked
here; the composition of actor scenarios is discussed separately. Same rules: options to
enumerate and objectify, then the author's choice; **Other** and **Clarify** are always
available.

Every word of the examples (`fold`, `rank`, `step`, `all`, `module`, `use`, `defmacro`, `:for`, `:encoding`…) is a placeholder: the words are chosen after these forms.

### A1 — Trains

#### Q-SPEC-401 — How a modifier takes its operands

**Object.** Chapter 5 writes the mean `[fold add div length]` and displays it `[´+÷≠]`: the modifier comes before the word it modifies. The arity rule of the eighth part assembles functions; it does not yet say when a modifier takes its operands, nor where a modifier of two operands (`rank`, a function and a number) puts them.

**Facts.**

- FIXAPL: « dyadic modifiers come infix (`+⟜-`) while monadic modifiers come postfix (`+/`). Modifiers have greater operator precedence than functions, and modifiers are left-associative, while functions are right-associative » (FIXAPL, README (https://github.com/Jacob-Lockwood/fixapl)).
- BQN: « In three cases a simpler 1-modifier is paired with a generalized 2-modifier: for each of these the 1-modifier happens to be the same as the 2-modifier with a right operand of ¯1 », Cells `˘` with Rank `⎉` among them (BQN, primitives (https://mlochbaum.github.io/BQN/doc/primitive.html)).

- **A — Before their operands, taken first.** A modifier takes, on its right, as many operands as its type says, before the train is assembled. *For:* chapter 5 and its glyph view stay as they are.

  ```text
  [fold add div length]      ;; [[fold add] div length]
  [rank sum 1 div length]    ;; [[rank sum 1] div length]
  ```

- **B — After or between them, as BQN and FIXAPL.** A modifier of one operand follows it, a modifier of two stands between them; modifiers are taken first. *For:* the order of the APL family; the glyph view reads as BQN.

  ```text
  [add fold div length]      ;; viewed [+´÷≠], as BQN writes it
  [sum rank 1 div length]
  ```

- **C — Always grouped.** A modified word is written in its own brackets. Example: `[[fold add] div length]`. *Against:* one group more for each modifier.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-018), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** l'objectif est de garder le même modèle mental que dans le reste du langage "lisp-like" soit [fn1 [fn2 fn3] [fn4 fn5]] donne [fn1 fn2bis fn4bis] ordre de prévalences, puis que selon l'arité fixée et la nature des fn restante, que le reste du train se résolve.  la rédaction est composée de gauche à droite pour que la dernière action réalisée soit celle de gauche. en lisp : (+ x y) instancie y et x puis applique l'addition. en K7PL couche 2 les opérateurs sont n-air et demande des délimiteurs pour scoper leurs actions. en couche 3 les opérateurs sont obligatoirement Monadique OU Dyadique.
  en les résolvant toujours de droite à gauche alors leurs prévaleuce est déterministe, homogène et prévisible. je prend A pour argument (un élément consommé par les opérateurs), D pour dyadique et M pour monadique. en générant alléatoirement le train suivant :
  "M A D M A D M D" et en le résolvant : le dernier D attend deux A donc une erreur à corriger :
  "M A D M A D M D A A" produisant
  "M A D M A D M A" puis
  "M A D M A D A" il manque donc un A :
  "M A D M A D A M D A A" =>
  "M A D M A D A A" =>
  "M A D M A A" les "A" sont passifs donc on va les numéroter pour mieux les identifier :
  "M A1 D M A2 A3" =>
  "M A1 D A2bis A3" =>
  "M A1 A2ter" =>
  "A1bis A2ter" le train produit donc A1bis et A2ter.
- **Reading:** a modifier of one operand follows it and a modifier of two stands between them, as BQN and FIXAPL, modifiers being taken first (option B): the mean is written `[add fold div length]`, viewed `[+´÷≠]`. The justification states the author's model: as in the rest of the language, inner groups resolve first (`[fn1 [fn2 fn3] [fn4 fn5]]` gives `[fn1 fn2bis fn4bis]`), then the rest by the fixed arities; written left to right, a train is resolved right to left, so the last action is the leftmost; in layer 2 operators are n-ary and scoped by delimiters, in layer 3 they are necessarily monadic or dyadic; each operator takes the values on its right, a train may leave several values (`M A1 D M A2 A3` gives `A1bis A2ter`), and an operator short of values is an error to correct. Put back to the author: in that example a value on the left of a dyadic word is not its argument, while FIXAPL's fork (eighth part) gives a dyadic word the result of the word on its left; and « obligatoirement Monadique OU Dyadique » against chapter 5's « au plus triadique » and the triadic `select` of `lst:fonction-pure`.

**Follow-up of the author — 2026-10-28 (VOC-2026-10-28-033), in the conversation, quoted as given.**

- **Answer:** Couche 3 monadique ET dyadique, pas de triadique. En couche 2 c'est n-air.
- **Reading:** layer-3 words are monadic or dyadic, never triadic; n-ary operators belong to layer 2,
  scoped by its delimiters. This withdraws the triadic arity of chapter 5 and leaves the triadic
  `select` of `lst:fonction-pure` and of `lexicon/lexemes/select.k` to be rethought.


#### Q-SPEC-402 — A value inside a train: `[sub 1]`

**Object.** Chapter 5: the arity of each word « permet à l'élaboration de distinguer un train d'une application ». `[range 1 9]` gives `range` all its arguments: an application. `[sub 1]` gives `sub` one argument of two: a train, an application missing an argument, or an error?

**Facts.**

- FIXAPL: « This even allows trains to have a value rather than a function as their rightmost tine (`-1` is a monadic function to subtract one), unlike other languages » (FIXAPL, README (https://github.com/Jacob-Lockwood/fixapl)).

- **A — As FIXAPL: a value may end a train.** `[sub 1]` is the function x − 1; a bracket is an application only when its head receives all its arguments.

  ```text
  [sub 1]          ;; x - 1
  [range 1 9]      ;; application
  ```

- **B — Applied from the left.** `[sub 1]` gives `sub` its first argument and waits for the second. Example: `[sub 1]          ;; 1 - y`.
- **C — Refused.** A bracket that holds a value is an application, and one whose head lacks arguments is refused with a code.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-019), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** vois la justification de Q-SPEC-401
- **Reading:** a value may end a train, as in FIXAPL (option A): a bracket is an application only when its head receives all its arguments (`[range 1 9]`). Which value `[sub 1]` computes, x − 1 or 1 − x, depends on the reading put back to the author under Q-SPEC-401.

**Follow-up of the author — 2026-10-28 (VOC-2026-10-28-032), in the conversation, quoted as given.** To
« De ce choix dépend la valeur de [sub 1] : x − 1 ou 1 − x. »:

- **Answer:** x-1.
- **Reading:** `[sub 1]` is the function x − 1: the value is the right argument of `sub`, whose left
  argument is the train's, as in FIXAPL's rule for a dyadic word with nothing on its left. The wider
  question put back under Q-SPEC-401 — a value on the left of a dyadic word in the author's example —
  stays open.


#### Q-SPEC-403 — The concatenative blocks of chapter 5

**Object.** Chapter 5: « Les blocs concaténatifs comme `[dup * +]`, dans la tradition de Forth et Factor, portent leur effet de pile directement dans leur type ». Chapter 4 reads a fold as a stack machine and cites the same block. Between brackets, the arity rule now reads `[dup * +]` as a train of functions, not as a sequence of stack operations.

**Facts.**

- Factor: « dup ( x -- x x ) » (Factor, dup (https://docs.factorcode.org/content/word-dup,kernel.html)).

- **A — Withdrawn from chapter 5.** Tacit code is written as trains; the stack reading stays in chapter 4 as the way a fold executes, not as a syntax.
- **B — Kept, in a qualified delimiter.** A block read by the stack is a literal of its own, its effect checked by its type. Example: `[stack| dup * + |stack]`.
- **C — Kept between brackets.** The type of the words decides: words typed by a stack effect make a block, words typed by an arity a train.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-020), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** la couche 3 s'execute dans la stack, toujours, point. la syntaxe pour manipuler la stack est l'écriture tacite concaténative à arité fixe de couche 3 qui se compose en train éxecutée de droite à gauche. voir la justification de Q-SPEC-401
- **Reading:** the concatenative blocks are withdrawn from chapter 5 (option A): the train is itself the concatenative writing of layer 3, of fixed arity and executed right to left on the stack, where every layer-3 execution takes place.


#### Q-SPEC-404 — The stack effect written for `[dup *]`

**Object.** Chapter 5: « `[dup *]` a l'effet `(1 – 2)` ». By the Forth standard, `dup` takes one value and leaves two, `*` takes two and leaves one: `[dup *]` takes one value and leaves one, `(1 – 1)`. Text of the manuscript: nothing changes without your consent.

**Facts.**

- Forth 2012, DUP: « ( x -- x x ) Duplicate x » (Forth standard, DUP (https://forth-standard.org/standard/core/DUP)); `*`: « ( n1 | u1 n2 | u2 -- n3 | u3 ) Multiply n1 | u1 by n2 | u2 giving the product n3 | u3 » (Forth standard, * (https://forth-standard.org/standard/core/Times)).

- **A — Corrected to `(1 – 1)`.**
- **B — Kept: `(1 – 2)` means something else.** Say what, with Clarify.
- **C — Settled by Q-SPEC-403.** The sentence goes if the blocks are withdrawn.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-021), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** attention aux choix des mots : pas d'effets en couche 3, c'est une couche pure.
- **Reading:** settled by Q-SPEC-403 (option C): the sentence goes with the blocks. Layer 3 is pure: no « effet » is to be named in it, not even a stack effect.

**Follow-up of the author — 2026-10-28 (VOC-2026-10-28-036), in the conversation, quoted as given.** To
« Le chapitre 4 dit encore que `[dup * +]` « décrit littéralement l'effet de pile de son exécution ». Je
n'y ai pas touché ; veux-tu une reformulation, par exemple « le mouvement de pile » ? »:

- **Answer:** mets en conformité le texte
- **Reading:** chapter 4 is brought into line with the ninth part: the tacit writing of layer 3 is the
  concatenative train, executed right to left on the stack, whose stack movement it describes; the
  block `[dup * +]` gives way to a train, and no effect is named in layer 3.


### A2 — Intervals

#### Q-LEX-701 — A layer-2 interval without an end

**Object.** Eighth part: « open en couche 2 serait logiquement ((1..n)) ». A layer-2 interval is a lazy list; can its end be left out?

**Facts.**

- Raku: « Use ∞ or * (Whatever) to indicate an end point to be open-ended »: `1 .. *` (Raku, Range (https://docs.raku.org/type/Range)). Haskell: `[ e1.. ] = enumFrom e1` (eighth part).

- **A — Yes, `((1..))`.** An endless lazy list.
- **B — Yes, with `inf` as its end.** `inf` is already a number literal. Example: `((1..inf))`.
- **C — No.** The end is always written; an endless sequence is a stream, not an interval.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-022), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** an endless layer-2 interval takes `inf` as its end: `((1..inf))` (option B).


#### Q-LEX-702 — A step and several dimensions together

**Object.** Eighth part: a second element gives the step (`[[1 3..9]]`), several intervals form a matrix of index pairs (`[[1..3 1..3]]`). Together, `[[1 3..9 1..3]]` must be read by a rule.

**Facts.**

- Kotlin: « You can also iterate over numbers with a custom step using the step() function »: `0..8 step 2` (Kotlin, ranges (https://kotlinlang.org/docs/ranges.html)).

- **A — A number just before an interval is its second element.** Example: `[[1 3..9 1..3]]   ;; (1 3 5 7 9) by (1 2 3)`.
- **B — A step word after the interval, as Kotlin.** Example: `[[1..9 step 2 1..3]]`.
- **C — A step only in a literal of one interval.** A matrix of intervals has no step.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-023), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** il faut décomposer : `1..9` en premier mot veut dire "créer une suite de 1 à 9 inclu" donc 1 2 3 4 5 6 7 8 9, en ajoutant 'step' qui signifie sauter et en y passant l'argument 2 c'est confusant : sauter 2 puis imprimer la liste de 1 à 9 ?
  aussi je préfère indiquer [[1..9 skip 1 2]] où 'skip' prend "combien" et "tous les combiens" ce qui instruit plus clairement l'intégration de la suite de 1 à 9 en sautant 1 valeur sur 2.
  1 3 5 7 9.
- **Reading:** a word after the interval (option B), in the author's form `[[1..9 skip 1 2]]`: the word takes how many values to skip and every how many, giving 1 3 5 7 9; `step` is set aside as confusing. Read as replacing the second-element form of the eighth part (`[[1 3..9]]`), which made a step and several dimensions ambiguous together; to be confirmed by the author.

**Follow-up of the author — 2026-10-28 (VOC-2026-10-28-035), in the conversation, quoted as given.** To
« garder les deux laisserait l'ambiguïté avec plusieurs dimensions. Confirmes-tu ? »:

- **Answer:** Oui
- **Reading:** confirmed: the `skip` word replaces the second-element step `[[1 3..9]]`.


#### Q-LEX-703 — Elements or bounds

**Object.** Chapter 5: `[[1..9]]` holds the elements 1 to 9, while « `[[:alpha:]]` [est] la matrice des bornes de ses plages ». The same pair gives elements for an interval and bounds for a class.

**Facts.**

- Raku: « Ranges serve two main purposes: to generate lists of consecutive numbers or strings, and to act as a matcher to check if a number or string is within a certain range » (Raku, Range (https://docs.raku.org/type/Range)).

- **A — Kept as is.** A class is a set of ranges, an interval a sequence.
- **B — Elements for both.** `[[:alpha:]]` holds its code points; its bounds come from a function.
- **C — Bounds for both.** `[[1..9]]` holds the pair 1 9; its elements come from a function.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-024), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** comme Raku.
- **Reading:** elements for both, as in Raku (option B): `[[:alpha:]]` holds the code points of the class; its bounds come from a function.


### A3 — Types

#### Q-STR-501 — How the encoding is written in a text type

**Object.** Eighth part: the encoding belongs to the text type, UTF-8 by default, and ASCII, UTF-16, UTF-32, Emacs's and others can be written. `strN` counts bits.

**Facts.**

- Unicode: « The Unicode Standard uses 8-bit code units in the UTF-8 encoding form, 16-bit code units in the UTF-16 encoding form, and 32-bit code units in the UTF-32 encoding form » (Unicode glossary, Code Unit (https://www.unicode.org/glossary/)).

- **A — A property beside the type.** Example: `{field name :type str256 :encoding utf16}`.
- **B — A type constructor.** Example: `{field name :type {str 256 utf16}}`.
- **C — One type name per encoding.** Example: `str256   utf16-256   ascii-56`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-025), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** Prenons l'exemple de l'UTF-16, comparé à str, qui peut prendre de 0 à n bits (en théorie) et qui se résout par défaut en str8 pour respecter l'UTF-8, alors l'UTF-8 comme l'UTF-16 sont des types raffinés de str, qui est lui un type secondaire composé d'une allocation d'un espace mémoire, etc. voir la spec concernant la construction de types qui est vraiment très riche et précise, sans oublier que plutot que de focus sur le type, il faut aussi comprendre que cette composition mémoire est associée à une gradation, l'association d'effet, de budgets, etc. car, et je le rappel clairement, tout est fonction dans K7PL, il n'y a pas d'objet au sens de la POO, un type est une composition fonctionnelle immuable. relire précisément la spec pour bien l'intégrer, c'est essentiel. il serait probablement pertinent de définir comment on compose un objet au sens de K7PL (composition de fonctions raffinées), la définition d'un "objet" dans le contexte de K7PL est également dans la specification.
- **Reading:** a type constructor (option B): `{str 256 utf16}`. An encoding is a refined type of `str`, and a type is an immutable composition of functions, with its grade, effects and budgets — no object in the sense of object-oriented programming. In the specification an object is an object of the ambient category: « les objets sont les types et les programmes purs en sont les morphismes » (chapter 1). Put back to the author: the message has `str` resolve to `str8` « pour respecter l'UTF-8 », reading N as the width of the code unit, while the seventh part reads N as the bits the whole text allocates, as in `intN`.

**Follow-up of the author — 2026-10-28 (VOC-2026-10-28-034), in the conversation, quoted as given.** To
« `{str 256 utf16}`, ce sont 256 bits de texte (16 unités), ou autre chose ? »:

- **Answer:** {str 256 utf16}, ce sont 256 bits de texte (16 unités)
- **Reading:** N counts the bits of the whole text, as in the seventh part: `{str 256 utf16}` allocates
  256 bits, sixteen UTF-16 units.


#### Q-STR-502 — A width that is not a multiple of the encoding's unit

**Object.** `str12` in UTF-8 (units of 8 bits), `str40` in UTF-16 (units of 16 bits).

- **A — Refused, with a code.**
- **B — Rounded up to whole units, with a warning.** Example: `str12   ;; str16, WRN-…`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-026), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** si on type avec un type rafiné en utf8 et que le type rafiné utf8 est défini sur 8 octets alors la chaine de bits qui lui est passée sera slicée en blocs de 8 octets et interprétés au sens de utf8. si le développeur essais de faire rentrer sciement une string str12 dans un utf8 alors c'est visible en phase 0 et refusé avec un code. on ne peut pas déspécialiser un type non plus : utf8 porte son tag donc comparé str12, même si utf8 est basé sur str8 et donc pourrait rentrer dans un str12 cela est interdit car str12 n'est pas labélisé "utf8", c'est voulu, par contre str8 peut être stocké dans str12 mais bon, à ce moment là autant allouer 12 octets d'entrée de jeu.
- **Reading:** refused with a code (option A), visible from phase 0. A refined encoding type carries its tag and is never despecialised: a `utf8` text does not go into a `str12`, which is not labelled `utf8`, even though `utf8` rests on `str8`; a plain `str8` may be stored in a `str12`. The message writes « octets » where the seventh part counts bits; read as bits.


#### Q-TYP-501 — How the parameters of a generic are introduced

**Object.** Third part: a type variable is introduced by a binder; chapter 6 monomorphises each generic call. No notation is written yet.

**Facts.**

- Typed Racket: « (All (a ...) t) […] is a parameterization of type t, with type variables a ... » (Typed Racket, types (https://docs.racket-lang.org/ts-reference/type-ref.html)).
- Rust: « we place type name declarations inside angle brackets, <>, between the name of the function and the parameter list »: `fn largest<T>(list: &[T]) -> &T` (Rust book, generics (https://doc.rust-lang.org/book/ch10-01-syntax.html)).

- **A — A property of the definition, as Rust.** Example: `{defn first :for [t] :type {function {vector t} t} …}`.
- **B — A binder inside the type, as Typed Racket.** Example: `{defn first :type {all [t] {function {vector t} t}} …}`.
- **C — Implicit.** A name in a type position that names no type is a parameter. *Against:* a misspelt type name becomes a parameter.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-027), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** attention 't' signifie 'true'. nous avions défini une stratégie de monomorfisation sans "for" (sans forall surtout) et il serait bien de lire exactement ce que la spec préconise pour cela avant de fixer un mécanisme issu d'ailleurs car c'est typiquement un pour qui a fait l'objet d'une recherche approfondie pour trouver un mécanisme naturel et ancré dans la littérature scientifique.
- **Reading:** kept open. `t` is the constant true and cannot name a type parameter. The monomorphisation strategy was defined without « for », above all without forall, after a researched choice: what the specification prescribes is to be read before any mechanism is taken from elsewhere. Read on 2026-10-28: the kernel has `∀α.C` with the rules Gen and Inst (chapter 3), chapter 6 monomorphises each generic call into a concrete copy, a typed hole is resolved in its family (chapter 5), and records open by row variables (chapter 3); no surface notation for a type parameter is written anywhere.

**Follow-up of the author — 2026-10-28 (VOC-2026-10-28-037), in the conversation, quoted as given.** To
the reading « la généricité passe par les trous typés et la monomorphisation, sans paramètre nommé »:

- **Answer:** Paramètre de type : ton interprétation est juste, {function int int} doit résoudre deux trous typés de famille int
- **Reading:** a generic names no type parameter: it is written with typed holes, which each use resolves
  in their family and monomorphisation copies into concrete instances; `{function int int}` resolves two
  typed holes of the integer family. Not said: whether two holes can be required to resolve to the same
  width.


#### Q-TYP-502 — What a refined type `{{ … }}` contains

**Object.** Seventh part: `{{ … }}` in layer 1 is a refined type; `{{:alpha:}}` refines texts of one character by a class.

**Facts.**

- F*: « let nat = x:int{x >= 0} »; « whose general form is x:t { e } where t is a type, and e is a bool-typed term that may refer to the t-typed bound variable x » (F* tutorial, part 1 (https://fstar-lang.org/tutorial/book/part1/part1_getting_off_the_ground.html)).
- LiquidHaskell: `nats :: [{v:Int | 0 <= v}]` (LiquidHaskell, specifications (https://ucsd-progsys.github.io/liquidhaskell/specifications/)).

- **A — A base type and a predicate on `_`.** Example: `{{int32 [<= 0 _]}}`.
- **B — A named variable, as F* and LiquidHaskell.** Example: `{{v int32 [<= 0 v]}}`.
- **C — A base type and a named predicate.** Example: `{{int32 non-negative}}   {{:alpha:}}`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-028), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** lis la specification, c'est très précisément expliqué.
- **Reading:** the specification answers it: chapter 3 writes a refinement type `{x : T | p}`, a bound variable, a support type and a predicate whose proof obligation the SMT solver of chapter 6 discharges, subtyping between two refinements of the same support being the implication of their predicates. `{{ … }}` holds these three.


### A4 — Forms not written yet

#### Q-SPEC-405 — How a pattern is written

**Object.** Sixth part: « @name defines a pattern », and `@linear`, `@polynomial`, `@stack`, `@backtrack` are properties of a pattern. Chapter 4: « Les R-expressions unifient sous une seule interface, `(match ...)`, le filtrage structurel, PCRE, PEG et les grammaires ». Chapter 5 matches `((Increment n) …)`. How a pattern is written is not.

**Facts.**

- F#: « Active patterns enable you to define named partitions that subdivide input data, so that you can use these names in a pattern matching expression » (F#, active patterns (https://learn.microsoft.com/en-us/dotnet/fsharp/language-reference/active-patterns)).
- Rust: « The at operator @ lets us create a variable that holds a value at the same time we’re testing that value for a pattern match » (Rust book, patterns (https://doc.rust-lang.org/book/ch19-03-pattern-syntax.html)); in K7PL `@` names a pattern instead.

- **A — S-expressions only.** A constructor and its fields, `_`, literals, classes and intervals; repetition and choice by words; `@name` defined like any definition.

  ```text
  {def @digit [[0..9]]}
  {def @number [many @digit] @linear}
  (match m ((Increment n) …))
  ```

- **B — S-expressions, and foreign pattern languages in qualified delimiters.** PCRE or PEG text compiles to the same automata. Example: `{def @number [pcre|[0-9]+|pcre] @linear}`.
- **C — Text patterns only in qualified delimiters.** S-expressions destructure structures; text is matched by a foreign pattern language.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-029), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** everything is a pattern, even a type, a construct, a trace, an algebraic effect. so '@' in front of anything means "catch this pattern" and inherit all its construction. this way we can get matching patterns straight into the network or in a data flow. PCRE/PEG automata arn't foreign things but someting K7PL compiles and put in production as an atomic operator through an orchestrator/an actor. better read the chapter about the actor model and how automatas are handled.
- **Reading:** everything is a pattern — a type, a construct, a trace, an algebraic effect —, so `@` in front of anything means « catch this pattern » and inherits all its construction, which lets matching patterns go straight into the network or a data flow. PCRE and PEG automata are not foreign: K7PL compiles them and puts them in production as an atomic operator through an orchestrator or an actor (chapter 4 on actors and automata).


#### Q-SPEC-406 — Modules

**Object.** Paths are symbols with `/` (fourth part). Nothing yet says what a module is, what it exports, or how one is imported.

**Facts.**

- Racket: « Each Racket module typically resides in its own file », which lists its exports with `provide` (Racket guide, modules (https://docs.racket-lang.org/guide/module-basics.html)).
- Rust: « A module is a container for zero or more items »; « Modules can nest arbitrarily » (Rust reference, modules (https://doc.rust-lang.org/reference/items/modules.html)).

- **A — One file, one module, exports listed.**

  ```text
  {module :export [print-cake]}
  {use geometry/shapes}
  ```

- **B — Modules nested in a file, exports listed.** Example: `{module shapes :export [area] …}`.
- **C — One file, one module, everything exported but what is marked.** Example: `{defn helper +private …}`.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-030), given in the clickable questionnaire, quoted as given.**

- **Choice:** CLARIFY
- **Clarification:** emacs lexical binding pour définir un périmètre général, pour le reste, il faut préciser la question parce qu'une S-Expression non encapsulée dans une autre est un processus autonome executable en parallele des autres du même rang. il faut donc définir ce qu'est un module parce que là je ne comprend pas et ai peur de mélanger les sujets
- **Reading:** clarification asked. Emacs's lexical binding, to set a general perimeter; for the rest, the question has to be made precise, because an S-expression not enclosed in another is an autonomous process, executable in parallel with the others of the same rank: what a module is must be defined first, so as not to mix subjects.


#### Q-SPEC-407 — How a macro or an envelope is declared

**Object.** Chapter 5: « Une enveloppe est une macro de couche 1, développée à la compilation et ouverte à tout programme sous l'hygiène de `ERR-MAC-001` ; une enveloppe peut en étendre une autre et lui ajouter des propriétés ». Its typing is written (`binds`, the rule of expansion), its surface is not.

**Facts.**

- Racket: « The simplest way to create a macro is to use define-syntax-rule: (define-syntax-rule pattern template) » (Racket guide, pattern-based macros (https://docs.racket-lang.org/guide/pattern-macros.html)).

- **A — A definition like any other.** `def` with a property that makes it a macro; an envelope is `def` with properties already filled.

  ```text
  {def swap +macro [a b] …}
  {def defn :extends def :fills {:type function}}
  ```

- **B — A head word of its own, by pattern and template.** Example: `{defmacro swap [a b] …}`.
- **C — Both.** Pattern and template for simple macros, a procedural form for envelopes.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-031), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** on a déjà acté que le mot primitif est def, de def on défini defmacro qui fournis l'envelope.
  donc {def defmacro <rules and shapes>}  pas besoin de préciser "refine" ou "extend" (en K7PL, rien ne s'étend, tout se précise.)  puisqu'en matière de définition d'enveloppe "def" est la primitive.
- **Reading:** a head word of its own (option B), defined with `def`, the primitive word: `{def defmacro <rules and shapes>}`, and `defmacro` provides envelopes. No « refine » or « extend » is needed: in K7PL nothing extends, everything is made more precise.


## Lot of 2026-10-28, tenth part: every open subject — layer 3, typed holes, patterns, modules, actor scenarios — and the gaps of the specification

Opened on 2026-10-28 at the author's request: every subject left open after the ninth part,
the actor-scenario discussion split into questions, and, with the same analysis, the places
where the specification was found imprecise or contradictory (titles « Gap »). Each question
gives its context in the specification, what the literature or other languages do, and options
with their pros and cons. **Other** and **Clarify** are always available.

Every word of the examples (`select`, `choose`, `match`, `decide`, `evolve`, `deliver`, `:same`…) is a placeholder: the words are chosen later. Questions titled « Gap » point at places where the specification is imprecise or contradicts itself.

### Layer 3 after the arity decision

#### Q-SPEC-501 — A conditional without a triadic word

**Object.** You decided that layer 3 has monadic and dyadic words only (VOC-2026-10-28-033). Chapter 5's pure function `lst:fonction-pure` still reads `[select [< value bound] [Ok [+ value 1]] [Err Overflow]]`, and K's lexeme `lexicon/lexemes/select.k` reads `(select C E1 E2)`, « Only the condition is strict: select does not evaluate its unchosen branch »; the proofs of `proofs/` export it. The conditional needs a form with at most two operands, and should keep running one branch only.

**Facts.**

- BQN: « The 2-modifier Choose (◶) applies one function from a list 𝕘, based on the selecting index returned by a function 𝔽 »: `0⊸≤◶⟨-⟜1,+⟜1⟩` subtracts 1 from a negative number and adds 1 otherwise (BQN, Choose (https://mlochbaum.github.io/BQN/doc/choose.html)).
- J: « m@.v uses the result of the verb v to perform the selection » of a verb in the list m (J Dictionary, Agenda (https://www.jsoftware.com/help/dictionary/d621.htm)).
- Factor's `if` takes three inputs, « ? a generalized boolean, true a quotation, false a quotation » (Factor, if (https://docs.factorcode.org/content/word-if,kernel.html)): the triadic form, in a stack language.

- **A — A dyadic `select` over a pair of branches.** The condition, then a pair whose two branches are functions (or quoted), so only the chosen one runs. Example: `[select [< value bound] [[Ok increment] [Err overflow]]]`. *For:* closest to today's listing; one word. *Against:* the pair must hold unevaluated branches, or both are computed.
- **B — A modifier of two operands, as BQN's Choose and J's Agenda.** A condition function on the left selects one function from a list on the right; the train's argument goes to the chosen one only. Example: `[below-bound choose [overflow-err increment-ok]]`. *For:* tacit, fits trains and the modifier rule of the ninth part; only the chosen branch runs. *Against:* the condition and the branches must be written as functions.
- **C — No conditional in layer 3.** Layer 3 computes without branching (masks, arithmetic); choosing between `Ok` and `Err` is done in layer 2, where words are n-ary. *For:* layer 3 stays branch-free, which suits its automata and vector code. *Against:* `?increment-bounded` can no longer return a `Result` by itself; chapter 5's listings are rewritten.

#### Q-SPEC-502 — A value on the left of a dyadic word: one result or several

**Object.** In your example of the ninth part, `M A1 D M A2 A3` gives `A1bis A2ter`: `D` takes the values on its right and `A1` stays apart, so the train leaves two results. FIXAPL, chosen in the eighth part, calls a dyadic word infix: a value on its left is its left argument, and a train leaves one result; `[sub 1]` = x − 1 (VOC-2026-10-28-032) follows it. Take `[abs 4 sub neg 7 2]`.

**Facts.**

- FIXAPL: « Dyadic function calls come in the infix position (`⍺+⍵`) and monadic function calls come in the prefix position (`¬⍵`) » (FIXAPL, README (https://github.com/Jacob-Lockwood/fixapl)).
- Factor: « dup ( x -- x x ) »: a stack word may leave several values (Factor, dup (https://docs.factorcode.org/content/word-dup,kernel.html)).

- **A — Infix, as FIXAPL: one result.** A value on the left of a dyadic word is its left argument. Example: `[abs 4 sub neg 7]       ;; abs (4 - (neg 7)) = 11`. *For:* a train has one value, as a `{function …}` type says; agrees with x − 1 and with the fork. *Against:* the stack is not read word by word: values combine by position.
- **B — Stack, as your example: several results.** An operator takes the values on its right; a value on its left stays on the stack; a train may return several values, typed as a product. Example: `[abs 4 sub neg 7 2]     ;; 4 and (neg 7) - 2 = -9`. *For:* the stack execution of layer 3 is read literally, as in Forth and Factor. *Against:* the fork of the eighth part no longer applies to values; a train's type lists all its results.

### Typed holes

#### Q-TYP-601 — Two holes that must be the same width

**Object.** `{function int int}` resolves two typed holes of the integer family (VOC-2026-10-28-037). Some functions need both to be equal — an identity, or a function that must return the width it receives. Chapter 6 already unifies types in Phase 3 with unification variables, which Phase 4 resolves (« résoudre chaque égalité α̂ := τ par substitution immédiate »).

**Facts.**

- Rust: `impl Trait` « in argument position (where it can act as an anonymous type parameter to functions) » (Rust reference, impl Trait (https://doc.rust-lang.org/reference/types/impl-trait.html)): anonymous, as K7PL's holes.

- **A — Always independent.** Each hole is resolved for itself; a function that needs equal widths writes the width. *For:* nothing to add; a signature says exactly what it constrains. *Against:* an identity on any integer cannot be written once.
- **B — Linked by the data flow.** Holes are unification variables of their family: when the body sends a value from one hole's position to the other's, Phase 3 unifies them. *For:* no syntax; uses the unification chapter 6 describes. *Against:* the link is read from the body, not from the signature.
- **C — Linked by a property of the type.** A property says which holes are the same. Example: `{function int int :same [1 2]}`. *For:* visible in the signature; still no named parameter. *Against:* one more property to learn.

#### Q-TYP-602 — Gap: which phase resolves a typed hole, and how instances are named

**Object.** Three passages disagree. Chapter 5: « un trou typé que l'élaboration résout dans la famille des entiers : à la plus petite largeur qui contient toutes les valeurs que le solveur sait borner ». The elaboration theorem: « la phase de résolution du pipeline (Phase 4) résout des variables d'unification, et n'est pas une élaboration au sens du théorème ». Chapter 6: Phase 3 « monomorphise chaque appel générique en une copie concrète », naming an instance « par le condensat de l'AST normalisé de son générique et de ses arguments de type », while « bornes numériques » are left to the SMT solver in Phase 7. A width known in Phase 7 cannot name a Phase-3 copy.

**Facts.**

- rustc: « The monomorphization collector is run just before MIR lowering and codegen », after type checking (rustc dev guide, monomorphization (https://rustc-dev-guide.rust-lang.org/backend/monomorph.html)).

- **A — Two steps.** Phase 3 copies per family, the hole staying a hole; Phase 7 fixes the widths and names the final instances. Chapter 5 says « résolution », not « élaboration ». *For:* keeps chapter 6's order and its cache by hash. *Against:* an instance has two names over its life.
- **B — Monomorphisation after Phase 7.** Phase 3 only unifies; copies are made once every width is known, as rustc collects just before code generation. *For:* one naming, by concrete types. *Against:* moves a step of chapter 6 and what Phases 5 and 6 check.
- **C — Widths fixed in Phase 3 where narrowing finds them.** The solver of Phase 7 only checks; a hole that narrowing cannot bound is refused (`ERR-SMT-003`). *For:* chapter 6's text barely changes. *Against:* refuses holes the solver could have bounded.

#### Q-TYP-603 — Gap: the phase of `ERR-TYP-013`

**Object.** Ninth part: a text width that is not a multiple of its encoding's unit is refused « en phase 0 » (now `ERR-TYP-013`). Chapter 6: Phase 0 builds the tree and desugars sigils, « un travail purement syntaxique, qui ne discute encore aucun des trois ordres »; types are established in Phase 3.

- **A — Phase 0.** The reader knows the units of the built-in encodings and checks `{str 12 utf8}` as it reads it. *For:* the earliest refusal, as you asked. *Against:* Phase 0 is no longer purely syntactic; chapter 6 says so.
- **B — Phase 3.** Where types are established. *For:* chapter 6 unchanged. *Against:* later than you asked.
- **C — Phase 0 for built-in encodings, Phase 3 for declared ones.** *For:* earliest where possible. *Against:* one code, two places.

### Patterns

#### Q-SPEC-503 — What `@x` gives when it catches

**Object.** Ninth part: everything is a pattern, and `@` in front of a construction « catch[es] this pattern » and inherits all its construction (VOC-2026-10-28-029). Also: « en K7PL, rien ne s'étend, tout se précise » (VOC-2026-10-28-031). Chapter 5 now says « en hérite toute la construction ». Open: what `@x` gives the code that follows.

**Facts.**

- Rust: « The at operator @ lets us create a variable that holds a value at the same time we’re testing that value for a pattern match » (Rust book, patterns (https://doc.rust-lang.org/book/ch19-03-pattern-syntax.html)).
- F#: « Active patterns enable you to define named partitions that subdivide input data » (F#, active patterns (https://learn.microsoft.com/en-us/dotnet/fsharp/language-reference/active-patterns)).

- **A — A refinement.** What `@x` catches is typed by `x`'s construction made precise — a refined type, as `{{ }}`; « hérite » is read as « se précise ». *For:* fits « tout se précise » and the refinement types of chapter 3.
- **B — A filter.** `@x` lets through what matches, on a flow or the network, and binds nothing. *For:* simplest on a data flow. *Against:* the code after the match does not know what matched.
- **C — Both.** In a `match`, `@x` binds the value refined by `x`; on a flow it filters. *For:* one sign, two uses that agree. *Against:* two readings to describe.

### Modules and top-level forms

#### Q-SPEC-504 — What a module is

**Object.** Ninth part, clarification: Emacs's lexical binding for a general perimeter, and the fear of mixing subjects. Three things already exist: a file, which lexical binding would scope; the compilation unit of chapter 6 (« Partant des racines de l'unité de compilation — ses points d'entrée et ce que son interface exporte »); and paths, symbols with `/`.

**Facts.**

- Emacs: `lexical-binding` « is typically set for a whole Emacs Lisp file, as a file-local variable » (Emacs Lisp manual, variables.texi (https://github.com/emacs-mirror/emacs/blob/emacs-30/doc/lispref/variables.texi)).
- OCaml: « Compilation units bridge the module system and the separate compilation system. A compilation unit is composed of two parts: an interface and an implementation » (OCaml manual, compilation units (https://ocaml.org/manual/latest/compunit.html)).
- Racket: « Each Racket module typically resides in its own file » (Racket guide, modules (https://docs.racket-lang.org/guide/module-basics.html)).

- **A — A file is the module.** Its lexical perimeter, its compilation unit and its path at once. *For:* one notion, as Racket and OCaml. *Against:* a unit cannot span files.
- **B — The compilation unit is the module.** A unit may span files; each file is only a lexical perimeter. *For:* chapter 6 already defines it, with its interface. *Against:* two notions to name.
- **C — No module.** The file is a lexical perimeter, the compilation unit is the program, and paths only name definitions. *For:* nothing new. *Against:* no separate compilation; chapter 6's interfaces lose their object.

#### Q-SPEC-505 — Gap: top-level forms as autonomous processes

**Object.** Ninth part: « une S-Expression non encapsulée dans une autre est un processus autonome executable en parallele des autres du même rang ». The specification says nothing of top-level forms. Chapter 6's Phase 2 collects actor definitions and checks the wiring graph is acyclic; chapter 4: « la coalgèbre qui produit l'état suivant n'est plus celle d'un acteur isolé, mais celle de l'orchestrateur tout entier ».

- **A — Every top-level form, whatever its layer.** Declarations `{ }` run in parallel at compile time, `( )` and `[ ]` at run time. *For:* one rule. *Against:* a declaration is not a process in chapter 6's phases.
- **B — Top-level layer-2 forms only.** `( )` at top level are processes started by the orchestrator; `{ }` are declarations; a top-level `[ ]` is a pure value. *For:* fits the layers and the orchestrator of chapter 4.
- **C — B, ordered by dependencies.** Top-level processes start in parallel, ordered only by their data dependencies and the wiring graph of Phase 2. *For:* « même rang » gets a meaning: the same depth in the dependency graph. *Against:* one more rule to write in chapter 4.

### Actor scenarios

#### Q-ACT-001 — What a scenario is

**Object.** Seventh part: « il nous faut une approche plus systémique pour identifier et composer les scénarios avec la question : est-ce que je souhaite séparer une vérification d'une transformation, d'une livraison, etc. ». A scenario may be the reaction to one message, or a sequence of messages between actors.

**Facts.**

- Chapter 3: « Un type de session n'en est que la version distribuée : le même automate, sauf que ses transitions sont déclenchées par l'échange de messages entre deux extrémités ».
- Saga: « A saga is a reliably coordinated sequence of local transactions […] either all steps complete successfully or, if a local transaction fails […], the changes made by the completed steps are undone by compensating transactions » (microservices.io, Saga (https://microservices.io/patterns/data/saga.html)).

- **A — The reaction to one message.** Check, transform, deliver.
- **B — A sequence of messages.** A protocol between actors, typed by a session type.
- **C — Both, the second built from the first.** A protocol is a session type whose steps are reactions. *For:* each level keeps its own tools.

#### Q-ACT-002 — The shape of a reaction

**Object.** Chapter 3: a pure layer-2 handler returns « une description d'effets, une liste d'instructions que l'exécutif réalise ». Chapter 5 today: `:on (Increment :sets value […])`, the rule of `Result`.

**Facts.**

- Erlang `gen_server`: `handle_call` returns « {reply,Reply,NewState} » (Erlang, gen_server (https://www.erlang.org/doc/apps/stdlib/gen_server.html)).
- Decider: « type Decide = Command -> State -> Event list »; « type Evolve = State -> Event -> State » (J. Chassaing, decider (https://thinkbeforecoding.com/post/2021/12/17/functional-event-sourcing-decider)).
- Elm: « our programs can command the runtime system to make an HTTP request or to generate a random number » (Elm guide, effects (https://guide.elm-lang.org/effects/)).

- **A — One transition, as today.** New state and reply together, as `gen_server`. *For:* short. *Against:* check, transformation and delivery are not told apart.
- **B — Decide and evolve, as the decider.** `decide` (layer 3) gives events or a refusal, `evolve` (layer 3) applies each event, the delivery (layer 2) is described. *For:* the three steps fall on the layers. *Against:* more to write for a simple actor.

  ```text
  :on (Increment :decide [...] :deliver (reply Ok))
  :evolve ((Incremented n) :sets value [...])
  ```

- **C — B, with today's form as its shorthand.** `:on … :sets` stays as a decision of one event that sets one field. *For:* simple actors stay short.

#### Q-ACT-003 — Named events

**Object.** Should what happened be named — `Incremented` —, apart from the new state?

**Facts.**

- Fowler: « Capture all changes to an application state as a sequence of events » (Event Sourcing (https://martinfowler.com/eaaDev/EventSourcing.html)).

- **A — Yes, always.** *For:* the journal holds facts; decide and evolve separate.
- **B — No: the new state and the reply only.** *For:* less to declare.
- **C — When an actor declares them.** *For:* event sourcing where it is wanted.

#### Q-ACT-004 — A refused check

**Object.** When the check of a message fails (today `Err Overflow`).

- **A — State intact, an error reply only.**
- **B — State intact, an error reply, and the refusal recorded as an event.** *For:* refusals are audited.
- **C — Left to the decision.** A refusal may produce events like any decision.

#### Q-ACT-005 — What a delivery covers

**Object.** Each kind is described by the reaction and executed by the executive (chapter 3).

**Facts.**

- Akka: side effects « should be performed in thenRun from the command handler after persisting the event » (Akka, persistence (https://doc.akka.io/libraries/akka-core/current/typed/persistence.html)).

Several options may be chosen.

- **reply — A reply to the sender.**
- **send — Messages to other actors.**
- **persist — What is persisted (events or state).**
- **outside — The outside world, through capabilities and FFI.**
- **later — A delivery deferred in time (a timer).**

#### Q-ACT-006 — Steps shared between messages

**Object.** Can a check or a delivery be written once and used by several messages?

- **A — No, per message.**
- **B — Within an actor.** Example: `{defstep below-bound …}  :on (Increment :check below-bound …)`.
- **C — Across actors too.** A library of checks and deliveries. *For:* reuse. *Against:* a step's type must be generic over the state it reads.

#### Q-ACT-007 — Gap: what the journal holds

**Object.** Chapter 3: « c'est cette exécution, non la transition, qui est journalisée ». Chapter 4, `thm:determinisme_rejeu`: replaying « les messages journalisés J(H) à travers les gestionnaires purs »; non-deterministic operations are « journalisées comme entrées factuelles ». The two do not name the same contents.

**Facts.**

- Akka: « The event handler must only update the state and never perform side effects, as those would also be executed during recovery of the persistent actor » (Akka, persistence (https://doc.akka.io/libraries/akka-core/current/typed/persistence.html)).

- **A — Messages and capability values.** As chapter 4; replay runs the transitions again, never the deliveries; chapter 3's sentence is reworded. *For:* the replay theorem stays as stated.
- **B — Events.** Replay applies `evolve` again, never `decide` nor the deliveries. *For:* short journal of facts. *Against:* the replay theorem is restated over events.
- **C — Both.** Messages and capability values as inputs, events as outputs; deliveries are never replayed. *For:* audit and replay both. *Against:* a larger journal.

## The catalogue, verbatim


## K7PL — catalogue QCM du vocabulaire du noyau

> **Statut : proposition de recherche non normative.** Photographie initiale de main au SHA c88c968e66e5951bbf300efe3e39a515df8d8aa3 ; les réponses ultérieures citent leur révision dans le journal de décision. Une réponse vaut décision de méthode ou préférence selon son type, pas preuve scientifique de validité, minimalité ou correction. Pour la provenance des candidats et les statuts historiques, consulter l'inventaire consolidé (deleted with the research lot; survives in git history).

## 1. Règle de réponse

Chaque question possède une option de choix, une option « Autre » et une option « Précision ». Les variantes de mots présentes dans des archives restent explicitement historiques/non ratifiées. Les évaluations mnémonique et écologique sont des arguments qualitatifs à tester, non des mesures. Pour les questions bloquées, le choix rationnel est « Précision / maintenir ouvert » tant que la dépendance théorique n'est pas résolue.

Format court d'enregistrement :

```text
Question: Q-…
Choix: A | B | C | AUTRE | PRÉCISION | MAINTENIR OUVERT
Autre terme:
Précision demandée:
Justification (facultative):
Objection à la définition ou au périmètre:
Dépendances/artefacts à mettre à jour:
```

Pour chaque proposition, trois dimensions restent distinctes :
- **Scientifique** : ajustement à la définition et aux obligations, y compris ce que le nom pourrait faussement suggérer.
- **Mnémonique** : familiarité, régularité de famille et transparence supposées ; aucune mesure propre à K7PL n'est disponible.
- **Écologique (hypothèse de transfert)** : capacité du terme à attirer l'attention sur une relation fonctionnelle ou une contrainte d'utilisation importante. Ce n'est pas une propriété mesurée du seul mot.

Les objets complets et les règles sont détaillés dans le registre ontologique (core-vocabulary-ontology-2026-10-25.md, deleted with the research lot; survives in git history). Les QCM sont ordonnés par familles, pas par importance esthétique.

## 2. Famille : valeurs, produits et sommes

### Q-TERM-001 — Variable / occurrence liée

**Objet exact :** `x` / Var. Occurrence d'un nom lié, dans un jugement qui impose ses grades et les autres liaisons nulles.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — variable liée**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Occurrence d'un nom lié, dans un jugement qui impose ses grades et les autres liaisons nulles. Risque connu : Le mot « variable » peut désigner l'objet abstrait aussi bien que son occurrence concrète.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — occurrence de variable**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Le mot « variable » peut désigner l'objet abstrait aussi bien que son occurrence concrète.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Occurrence d'un nom lié, dans un jugement qui impose ses grades et les autres liaisons nulles. Risque connu : Le mot « variable » peut désigner l'objet abstrait aussi bien que son occurrence concrète.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — nom lié**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Le mot « variable » peut désigner l'objet abstrait aussi bien que son occurrence concrète.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Occurrence d'un nom lié, dans un jugement qui impose ses grades et les autres liaisons nulles. Risque connu : Le mot « variable » peut désigner l'objet abstrait aussi bien que son occurrence concrète.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-002 — Valeur unité

**Objet exact :** `() ` / One. Valeur unique de type unité, distincte du type 1 et de son éliminateur.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — valeur unité**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Valeur unique de type unité, distincte du type 1 et de son éliminateur. Risque connu : « Trivial » est trop large ; « unité » peut référer au type.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — valeur unitaire**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : « Trivial » est trop large ; « unité » peut référer au type.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Valeur unique de type unité, distincte du type 1 et de son éliminateur. Risque connu : « Trivial » est trop large ; « unité » peut référer au type.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — valeur triviale**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. « Trivial » est trop large ; « unité » peut référer au type.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Valeur unique de type unité, distincte du type 1 et de son éliminateur. Risque connu : « Trivial » est trop large ; « unité » peut référer au type.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-003 — Paire tensorielle

**Objet exact :** `(v₁,v₂)` / Pair. Construction de valeur tensorielle qui additionne les contextes consommés.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — paire linéaire**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Construction de valeur tensorielle qui additionne les contextes consommés. Risque connu : Paire décrit l'arité ; tenseur nomme aussi le type ; composition peut sembler une opération sur contextes.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — tenseur**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Paire décrit l'arité ; tenseur nomme aussi le type ; composition peut sembler une opération sur contextes.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Construction de valeur tensorielle qui additionne les contextes consommés. Risque connu : Paire décrit l'arité ; tenseur nomme aussi le type ; composition peut sembler une opération sur contextes.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — composition de ressources**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Paire décrit l'arité ; tenseur nomme aussi le type ; composition peut sembler une opération sur contextes.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Construction de valeur tensorielle qui additionne les contextes consommés. Risque connu : Paire décrit l'arité ; tenseur nomme aussi le type ; composition peut sembler une opération sur contextes.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-004 — Introduction de somme

**Objet exact :** `injᵢ v` / Inj. Introduire une branche indexée dans une somme disjointe.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — injection**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Introduire une branche indexée dans une somme disjointe. Risque connu : Injection est terme logique reçu ; marquage n'expose pas la somme.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — marquage d'étiquette**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Injection est terme logique reçu ; marquage n'expose pas la somme.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Introduire une branche indexée dans une somme disjointe. Risque connu : Injection est terme logique reçu ; marquage n'expose pas la somme.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — injection dans une somme**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Injection est terme logique reçu ; marquage n'expose pas la somme.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Introduire une branche indexée dans une somme disjointe. Risque connu : Injection est terme logique reçu ; marquage n'expose pas la somme.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-005 — Modalité graduée

**Objet exact :** `boxᵣ v` / Box. Introduire !ᵣ V en mettant le contexte à l'échelle du grade complet.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — promotion**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Introduire !ᵣ V en mettant le contexte à l'échelle du grade complet. Risque connu : Promotion peut laisser croire à une seule dimension monotone ; emboîtage ne rend pas les obligations du grade.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — modalisation graduée**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Promotion peut laisser croire à une seule dimension monotone ; emboîtage ne rend pas les obligations du grade.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Introduire !ᵣ V en mettant le contexte à l'échelle du grade complet. Risque connu : Promotion peut laisser croire à une seule dimension monotone ; emboîtage ne rend pas les obligations du grade.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — emboîtage gradué**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Promotion peut laisser croire à une seule dimension monotone ; emboîtage ne rend pas les obligations du grade.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Introduire !ᵣ V en mettant le contexte à l'échelle du grade complet. Risque connu : Promotion peut laisser croire à une seule dimension monotone ; emboîtage ne rend pas les obligations du grade.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-006 — Suspension de calcul

**Objet exact :** `thunk c` / Th. Construire une valeur contenant un calcul et son effet déclaré.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — suspension**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Construire une valeur contenant un calcul et son effet déclaré. Risque connu : Le mot doit éviter de promettre partage, mémoïsation ou une politique d'évaluation non spécifiée.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — calcul suspendu**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Le mot doit éviter de promettre partage, mémoïsation ou une politique d'évaluation non spécifiée.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Construire une valeur contenant un calcul et son effet déclaré. Risque connu : Le mot doit éviter de promettre partage, mémoïsation ou une politique d'évaluation non spécifiée.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — thunk**  
Origine : Candidat mentionné dans l'archive PR #10 ; archive expressément non normative/non ratifiée.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Le mot doit éviter de promettre partage, mémoïsation ou une politique d'évaluation non spécifiée.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Construire une valeur contenant un calcul et son effet déclaré. Risque connu : Le mot doit éviter de promettre partage, mémoïsation ou une politique d'évaluation non spécifiée.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-007 — Introduction existentielle

**Objet exact :** `pack (W,v)` / Pack. Associer le témoin de type W à une valeur de V[W/α].  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — empaquetage existentiel**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Associer le témoin de type W à une valeur de V[W/α]. Risque connu : Le témoin doit rester visible conceptuellement ; « conditionnement » peut évoquer une hypothèse logique.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — conditionnement existentiel**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Le témoin doit rester visible conceptuellement ; « conditionnement » peut évoquer une hypothèse logique.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Associer le témoin de type W à une valeur de V[W/α]. Risque connu : Le témoin doit rester visible conceptuellement ; « conditionnement » peut évoquer une hypothèse logique.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — pack**  
Origine : Candidat mentionné dans l'archive PR #10 ; archive expressément non normative/non ratifiée.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Le témoin doit rester visible conceptuellement ; « conditionnement » peut évoquer une hypothèse logique.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Associer le témoin de type W à une valeur de V[W/α]. Risque connu : Le témoin doit rester visible conceptuellement ; « conditionnement » peut évoquer une hypothèse logique.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-008 — Point fixe inductif — introduction

**Objet exact :** `fold v` / Fold. Introduire le type inductif en repliant une valeur du corps déplié.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — repliage**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Introduire le type inductif en repliant une valeur du corps déplié. Risque connu : Le candidat doit rester cohérent avec l'élimination unfold sans confondre le pli indexé d'un vecteur.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — pliage inductif**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Le candidat doit rester cohérent avec l'élimination unfold sans confondre le pli indexé d'un vecteur.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Introduire le type inductif en repliant une valeur du corps déplié. Risque connu : Le candidat doit rester cohérent avec l'élimination unfold sans confondre le pli indexé d'un vecteur.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — fold**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Le candidat doit rester cohérent avec l'élimination unfold sans confondre le pli indexé d'un vecteur.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Introduire le type inductif en repliant une valeur du corps déplié. Risque connu : Le candidat doit rester cohérent avec l'élimination unfold sans confondre le pli indexé d'un vecteur.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-009 — Littéral de vecteur

**Objet exact :** `[v₀,…,vₙ₋₁]` / VecI. Valeur d'un vecteur de longueur connue ; le type Vec est déclaré dérivé, mais ses règles restent à auditer.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — littéral de vecteur**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Valeur d'un vecteur de longueur connue ; le type Vec est déclaré dérivé, mais ses règles restent à auditer. Risque connu : « Littéral » suppose une forme de surface ; « introduction » décrit plutôt la règle.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — construction de vecteur**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : « Littéral » suppose une forme de surface ; « introduction » décrit plutôt la règle.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Valeur d'un vecteur de longueur connue ; le type Vec est déclaré dérivé, mais ses règles restent à auditer. Risque connu : « Littéral » suppose une forme de surface ; « introduction » décrit plutôt la règle.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — introduction de vecteur**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. « Littéral » suppose une forme de surface ; « introduction » décrit plutôt la règle.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Valeur d'un vecteur de longueur connue ; le type Vec est déclaré dérivé, mais ses règles restent à auditer. Risque connu : « Littéral » suppose une forme de surface ; « introduction » décrit plutôt la règle.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-010 — Retour de valeur

**Objet exact :** `return v` / Ret. Former un calcul de type F₁V qui restitue v sans ajouter d'effet non trivial.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — retour**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Former un calcul de type F₁V qui restitue v sans ajouter d'effet non trivial. Risque connu : Retour peut évoquer la fin d'une fonction ; production omet l'effet unité ; injection dans un calcul est précis mais lourd.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — production de valeur**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Retour peut évoquer la fin d'une fonction ; production omet l'effet unité ; injection dans un calcul est précis mais lourd.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Former un calcul de type F₁V qui restitue v sans ajouter d'effet non trivial. Risque connu : Retour peut évoquer la fin d'une fonction ; production omet l'effet unité ; injection dans un calcul est précis mais lourd.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — injection de valeur dans un calcul**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Retour peut évoquer la fin d'une fonction ; production omet l'effet unité ; injection dans un calcul est précis mais lourd.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Former un calcul de type F₁V qui restitue v sans ajouter d'effet non trivial. Risque connu : Retour peut évoquer la fin d'une fonction ; production omet l'effet unité ; injection dans un calcul est précis mais lourd.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-011 — Liaison séquentielle

**Objet exact :** `let x ← c₁ in c₂` / Let. Lier le résultat du premier calcul dans le second et composer contextes et effets.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — liaison séquentielle**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Lier le résultat du premier calcul dans le second et composer contextes et effets. Risque connu : « Séquencement » seul perd la liaison ; « bind »/« enchaînement » peuvent importer des hypothèses monadiques.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — enchaînement lié**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : « Séquencement » seul perd la liaison ; « bind »/« enchaînement » peuvent importer des hypothèses monadiques.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Lier le résultat du premier calcul dans le second et composer contextes et effets. Risque connu : « Séquencement » seul perd la liaison ; « bind »/« enchaînement » peuvent importer des hypothèses monadiques.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — liaison du résultat**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. « Séquencement » seul perd la liaison ; « bind »/« enchaînement » peuvent importer des hypothèses monadiques.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Lier le résultat du premier calcul dans le second et composer contextes et effets. Risque connu : « Séquencement » seul perd la liaison ; « bind »/« enchaînement » peuvent importer des hypothèses monadiques.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-012 — Abstraction de calcul

**Objet exact :** `λx.c` / Lam. Abstraire un calcul sur un argument gradué ; le type fonctionnel porte usage et effet.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — abstraction de calcul**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Abstraire un calcul sur un argument gradué ; le type fonctionnel porte usage et effet. Risque connu : Lambda nomme le symbole ; abstraction doit distinguer calcul, type et confidentialité.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — abstraction lambda**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Lambda nomme le symbole ; abstraction doit distinguer calcul, type et confidentialité.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Abstraire un calcul sur un argument gradué ; le type fonctionnel porte usage et effet. Risque connu : Lambda nomme le symbole ; abstraction doit distinguer calcul, type et confidentialité.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — fonction calcul**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Lambda nomme le symbole ; abstraction doit distinguer calcul, type et confidentialité.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Abstraire un calcul sur un argument gradué ; le type fonctionnel porte usage et effet. Risque connu : Lambda nomme le symbole ; abstraction doit distinguer calcul, type et confidentialité.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

**Dated preference of the author — 2026-10-26 (VOC-2026-10-26-002), new content in English:** `lambda`, the retained lemma of rule `Lam` in the primitives register (candidates: lambda, fn, fun, abstraction); a lambda is an anonymous function, a named function is *defined*. Argument: the `Lam` entry of [primitives](primitives.md). A preference, not a ratification; the choice of the French lemma asked by this question stays open.

**λ overlap (rule of 2026-10-26, applies wherever `lambda` is a candidate, here option B):** the symbol λ names two different objects in the specification. In `λx.c` (rule `Lam`) it is the abstraction, a term former. In chapter 3 (`ReglesDeTypage.lean`, the graded distributive law), λ is a natural transformation, with naturality and compatibility conditions of its own. The surface word `lambda` only ever names the first; a lemma such as "abstraction lambda" must not suggest the second.

### Q-TERM-013 — Application

**Objet exact :** `c v` / App. Appliquer un calcul-fonction à une valeur, avec mise à l'échelle du contexte par l'usage de l'argument.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — application**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Appliquer un calcul-fonction à une valeur, avec mise à l'échelle du contexte par l'usage de l'argument. Risque connu : Appel est familier mais peut suggérer exécution ordinaire ; le grade et l'effet sont constitutifs.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — appel**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Appel est familier mais peut suggérer exécution ordinaire ; le grade et l'effet sont constitutifs.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Appliquer un calcul-fonction à une valeur, avec mise à l'échelle du contexte par l'usage de l'argument. Risque connu : Appel est familier mais peut suggérer exécution ordinaire ; le grade et l'effet sont constitutifs.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — application de calcul**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Appel est familier mais peut suggérer exécution ordinaire ; le grade et l'effet sont constitutifs.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Appliquer un calcul-fonction à une valeur, avec mise à l'échelle du contexte par l'usage de l'argument. Risque connu : Appel est familier mais peut suggérer exécution ordinaire ; le grade et l'effet sont constitutifs.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-014 — Élimination de suspension

**Objet exact :** `force v` / Fo. Récupérer le calcul suspendu avec l'effet qu'il déclare.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — forçage**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Récupérer le calcul suspendu avec l'effet qu'il déclare. Risque connu : Forçage peut suggérer répétition ; reprise peut laisser entendre que le calcul a déjà commencé.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — reprise**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Forçage peut suggérer répétition ; reprise peut laisser entendre que le calcul a déjà commencé.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Récupérer le calcul suspendu avec l'effet qu'il déclare. Risque connu : Forçage peut suggérer répétition ; reprise peut laisser entendre que le calcul a déjà commencé.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — évaluation du calcul suspendu**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Forçage peut suggérer répétition ; reprise peut laisser entendre que le calcul a déjà commencé.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Récupérer le calcul suspendu avec l'effet qu'il déclare. Risque connu : Forçage peut suggérer répétition ; reprise peut laisser entendre que le calcul a déjà commencé.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-015 — Élimination de somme

**Objet exact :** `case v of …` / Case. Choisir la branche de somme correspondant à l'étiquette ; la règle impose aussi une contrainte de niveau.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — discrimination de somme**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Choisir la branche de somme correspondant à l'étiquette ; la règle impose aussi une contrainte de niveau. Risque connu : Sélection peut masquer la preuve de branche ; discrimination est exact mais moins familier.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — sélection de branche**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Sélection peut masquer la preuve de branche ; discrimination est exact mais moins familier.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Choisir la branche de somme correspondant à l'étiquette ; la règle impose aussi une contrainte de niveau. Risque connu : Sélection peut masquer la preuve de branche ; discrimination est exact mais moins familier.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — filtrage par étiquette**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Sélection peut masquer la preuve de branche ; discrimination est exact mais moins familier.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Choisir la branche de somme correspondant à l'étiquette ; la règle impose aussi une contrainte de niveau. Risque connu : Sélection peut masquer la preuve de branche ; discrimination est exact mais moins familier.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

### Q-TERM-016 — Élimination de l'unité

**Objet exact :** `let () = v in c` / OneE. Consommer une valeur d'unité puis poursuivre sans liaison de donnée utile.  
**Statut :** lemme ouvert ; le token/forme actuellement écrite n'est pas automatiquement une ratification lexicale séparée.  
**Objectif :** choisir un lemme français qui désigne précisément cette règle sans perdre la sorte, la ressource ou la contrainte distinctive.

**A — élimination de l'unité**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence à tester contre la définition ci-dessus.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Consommer une valeur d'unité puis poursuivre sans liaison de donnée utile. Risque connu : Consommation risque une lecture de coût ou de ressource ; liaison d'unité surdécrit la syntaxe.  
Limite/conséquence : Ne pas conserver au seul motif qu'il figure déjà dans le registre.

**B — consommation de l'unité**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative de portée ou de famille ; risque particulier : Consommation risque une lecture de coût ou de ressource ; liaison d'unité surdécrit la syntaxe.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Consommer une valeur d'unité puis poursuivre sans liaison de donnée utile. Risque connu : Consommation risque une lecture de coût ou de ressource ; liaison d'unité surdécrit la syntaxe.  
Limite/conséquence : Ne pas préférer au seul motif qu'il est plus parlant.

**C — liaison d'unité**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative descriptive ; il faut vérifier qu'elle n'élargit pas le référent au-delà de la règle. Consommation risque une lecture de coût ou de ressource ; liaison d'unité surdécrit la syntaxe.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Consommer une valeur d'unité puis poursuivre sans liaison de donnée utile. Risque connu : Consommation risque une lecture de coût ou de ressource ; liaison d'unité surdécrit la syntaxe.  
Limite/conséquence : Ne pas promouvoir sans vérifier les collisions de famille et de namespace.

**Autre —** proposer un terme inédit ou rejeter tous les candidats : ______  
**Précision —** demander une analyse approfondie, une autre liste de candidats, une source ou un retour sur les critères : ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection au périmètre ______ ; conséquences sur les autres questions ______ ; conséquences formelles à vérifier ______.

## 3. Famille : suspension, calculs et quantification

### Q-TERM-017 — Décomposition de paire

**Objet exact :** `let (x,y) = v in c` / Split. Extraire les deux composants d'une valeur tensorielle en les liant sous contraintes graduées.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — décomposition de paire**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Extraire les deux composants d'une valeur tensorielle en les liant sous contraintes graduées. Risque connu : Décomposition a une collision avec le produit module×ordre du grade ; la sorte doit être nommée.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — déstructuration de tenseur**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Décomposition a une collision avec le produit module×ordre du grade ; la sorte doit être nommée.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Extraire les deux composants d'une valeur tensorielle en les liant sous contraintes graduées. Risque connu : Décomposition a une collision avec le produit module×ordre du grade ; la sorte doit être nommée.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — séparation de paire**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Décomposition a une collision avec le produit module×ordre du grade ; la sorte doit être nommée.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Extraire les deux composants d'une valeur tensorielle en les liant sous contraintes graduées. Risque connu : Décomposition a une collision avec le produit module×ordre du grade ; la sorte doit être nommée.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-018 — Conjonction additive — introduction

**Objet exact :** `⟨cᵢ⟩ᵢ∈I` / With. Offrir plusieurs calculs indexés accessibles sous le même contexte par choix d'observation.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — offre d'observations**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Offrir plusieurs calculs indexés accessibles sous le même contexte par choix d'observation. Risque connu : « Record » ou « objet » importerait un modèle de champs ; « conjonction » est exact mais logique.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — conjonction additive**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : « Record » ou « objet » importerait un modèle de champs ; « conjonction » est exact mais logique.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Offrir plusieurs calculs indexés accessibles sous le même contexte par choix d'observation. Risque connu : « Record » ou « objet » importerait un modèle de champs ; « conjonction » est exact mais logique.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — famille indexée de calculs**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. « Record » ou « objet » importerait un modèle de champs ; « conjonction » est exact mais logique.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Offrir plusieurs calculs indexés accessibles sous le même contexte par choix d'observation. Risque connu : « Record » ou « objet » importerait un modèle de champs ; « conjonction » est exact mais logique.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-019 — Conjonction additive — élimination

**Objet exact :** `c.i` / Proj. Sélectionner un calcul dans la famille indexée.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — projection additive**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Sélectionner un calcul dans la famille indexée. Risque connu : Projection collisionne avec πℓ ; sélection est plus claire mais peut effacer le connecteur logique.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — sélection d'observation**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Projection collisionne avec πℓ ; sélection est plus claire mais peut effacer le connecteur logique.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Sélectionner un calcul dans la famille indexée. Risque connu : Projection collisionne avec πℓ ; sélection est plus claire mais peut effacer le connecteur logique.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — projection de branche**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Projection collisionne avec πℓ ; sélection est plus claire mais peut effacer le connecteur logique.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Sélectionner un calcul dans la famille indexée. Risque connu : Projection collisionne avec πℓ ; sélection est plus claire mais peut effacer le connecteur logique.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-020 — Élimination de modalité graduée

**Objet exact :** `unbox … as x in c` / Unbox. Exposer une valeur de grade r depuis !ᵣV et composer les contextes sous les obligations de modalité.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — restitution**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Exposer une valeur de grade r depuis !ᵣV et composer les contextes sous les obligations de modalité. Risque connu : Extraction collisionne avec l'extraction de preuve ; sortie est imprécis ; restitution peut impliquer un retour de ressource.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — extraction graduée**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Extraction collisionne avec l'extraction de preuve ; sortie est imprécis ; restitution peut impliquer un retour de ressource.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Exposer une valeur de grade r depuis !ᵣV et composer les contextes sous les obligations de modalité. Risque connu : Extraction collisionne avec l'extraction de preuve ; sortie est imprécis ; restitution peut impliquer un retour de ressource.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — sortie de modalité**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Extraction collisionne avec l'extraction de preuve ; sortie est imprécis ; restitution peut impliquer un retour de ressource.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Exposer une valeur de grade r depuis !ᵣV et composer les contextes sous les obligations de modalité. Risque connu : Extraction collisionne avec l'extraction de preuve ; sortie est imprécis ; restitution peut impliquer un retour de ressource.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-021 — Élimination existentielle

**Objet exact :** `open … as (α,x) in c` / Open. Substituer témoin de type et valeur, sous condition de fraîcheur et de non-fuite du type.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — ouverture existentielle**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Substituer témoin de type et valeur, sous condition de fraîcheur et de non-fuite du type. Risque connu : Ouverture est large et collisionne avec le mot-clé Lean ; dépaquetage est descriptif mais peu théorique.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — dépaquetage existentiel**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Ouverture est large et collisionne avec le mot-clé Lean ; dépaquetage est descriptif mais peu théorique.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Substituer témoin de type et valeur, sous condition de fraîcheur et de non-fuite du type. Risque connu : Ouverture est large et collisionne avec le mot-clé Lean ; dépaquetage est descriptif mais peu théorique.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — dépaquetage**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Ouverture est large et collisionne avec le mot-clé Lean ; dépaquetage est descriptif mais peu théorique.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Substituer témoin de type et valeur, sous condition de fraîcheur et de non-fuite du type. Risque connu : Ouverture est large et collisionne avec le mot-clé Lean ; dépaquetage est descriptif mais peu théorique.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-022 — Point fixe inductif — élimination

**Objet exact :** `unfold v` / Unfold. Exposer un cran de la structure du point fixe inductif.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — dépliage**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Exposer un cran de la structure du point fixe inductif. Risque connu : Dépliage est symétrique à repliage ; décomposition inductive est explicite mais longue.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — décomposition inductive**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Dépliage est symétrique à repliage ; décomposition inductive est explicite mais longue.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Exposer un cran de la structure du point fixe inductif. Risque connu : Dépliage est symétrique à repliage ; décomposition inductive est explicite mais longue.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — unfold**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Dépliage est symétrique à repliage ; décomposition inductive est explicite mais longue.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Exposer un cran de la structure du point fixe inductif. Risque connu : Dépliage est symétrique à repliage ; décomposition inductive est explicite mais longue.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-023 — Quantification de type — introduction

**Objet exact :** `Λα.c` / Gen. Généraliser un calcul par rapport à une variable de type absente du contexte.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — généralisation de type**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Généraliser un calcul par rapport à une variable de type absente du contexte. Risque connu : Généralisation est aussi le terme de la résolution de variables d'unification ; abstraction est plus large.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — abstraction universelle**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Généralisation est aussi le terme de la résolution de variables d'unification ; abstraction est plus large.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Généraliser un calcul par rapport à une variable de type absente du contexte. Risque connu : Généralisation est aussi le terme de la résolution de variables d'unification ; abstraction est plus large.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — abstraction de type**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Généralisation est aussi le terme de la résolution de variables d'unification ; abstraction est plus large.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Généraliser un calcul par rapport à une variable de type absente du contexte. Risque connu : Généralisation est aussi le terme de la résolution de variables d'unification ; abstraction est plus large.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-024 — Quantification de type — élimination

**Objet exact :** `c[W]` / Inst. Instancier une variable de type abstraite par substitution d'un type.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — instanciation de type**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Instancier une variable de type abstraite par substitution d'un type. Risque connu : Application décrit la forme d'appel ; substitution nomme une opération métathéorique plus large.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — application de type**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Application décrit la forme d'appel ; substitution nomme une opération métathéorique plus large.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Instancier une variable de type abstraite par substitution d'un type. Risque connu : Application décrit la forme d'appel ; substitution nomme une opération métathéorique plus large.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — substitution de type**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Application décrit la forme d'appel ; substitution nomme une opération métathéorique plus large.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Instancier une variable de type abstraite par substitution d'un type. Risque connu : Application décrit la forme d'appel ; substitution nomme une opération métathéorique plus large.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-025 — Point fixe déductif

**Objet exact :** `fix v` / eq:regle-fix. Selon la description du registre, point fixe d'une fonction monotone sur Trellis_fin, sous effet pur ; la stabilisation bornée est affirmée par le registre, mais sa preuve n'est pas déclarée vérifiée dans le présent dossier.  
**Statut :** objet conceptuel à vérifier contre le blocage de contrôle T-68 ; forme de surface écrite.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — point fixe déductif**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Point fixe d'une fonction monotone sur Trellis_fin, sous effet pur ; stabilisation bornée par la hauteur finie. Risque connu : Récursion bornée risque d'être comprise comme récursion générale ; itération de Kleene nomme aussi un procédé.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — itération de Kleene**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Récursion bornée risque d'être comprise comme récursion générale ; itération de Kleene nomme aussi un procédé.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Point fixe d'une fonction monotone sur Trellis_fin, sous effet pur ; stabilisation bornée par la hauteur finie. Risque connu : Récursion bornée risque d'être comprise comme récursion générale ; itération de Kleene nomme aussi un procédé.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — récursion bornée**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Récursion bornée risque d'être comprise comme récursion générale ; itération de Kleene nomme aussi un procédé.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Point fixe d'une fonction monotone sur Trellis_fin, sous effet pur ; stabilisation bornée par la hauteur finie. Risque connu : Récursion bornée risque d'être comprise comme récursion générale ; itération de Kleene nomme aussi un procédé.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-026 — Déclassification

**Objet exact :** `declassifyℓ(v)` / eq:regle-declassify. Opération contrôlée de déclassification associée à un niveau de confidentialité.  
**Statut :** objet conceptuel à vérifier contre le blocage de contrôle T-68 ; forme de surface écrite.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — déclassification**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Opération contrôlée de déclassification associée à un niveau de confidentialité. Risque connu : Le terme doit conserver la condition de sécurité, plutôt que suggérer une permission générale de divulguer.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — relâchement de confidentialité**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Le terme doit conserver la condition de sécurité, plutôt que suggérer une permission générale de divulguer.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Opération contrôlée de déclassification associée à un niveau de confidentialité. Risque connu : Le terme doit conserver la condition de sécurité, plutôt que suggérer une permission générale de divulguer.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — déclassement de niveau**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Le terme doit conserver la condition de sécurité, plutôt que suggérer une permission générale de divulguer.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Opération contrôlée de déclassification associée à un niveau de confidentialité. Risque connu : Le terme doit conserver la condition de sécurité, plutôt que suggérer une permission générale de divulguer.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-027 — Parcours/itération de vecteur

**Objet exact :** `iter_V v c` / VecE. Parcourir le vecteur en composant les effets indexés et en respectant les grades des positions.  
**Statut :** objet conceptuel à vérifier contre le blocage de contrôle T-68 ; forme de surface écrite.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — itération de vecteur**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Parcourir le vecteur en composant les effets indexés et en respectant les grades des positions. Risque connu : Pli indexé est une hypothèse de factorisation ; ne pas la choisir lexicalement comme si le théorème de dérivation existait.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — parcours de vecteur**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Pli indexé est une hypothèse de factorisation ; ne pas la choisir lexicalement comme si le théorème de dérivation existait.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Parcourir le vecteur en composant les effets indexés et en respectant les grades des positions. Risque connu : Pli indexé est une hypothèse de factorisation ; ne pas la choisir lexicalement comme si le théorème de dérivation existait.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — pli indexé gradué**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Pli indexé est une hypothèse de factorisation ; ne pas la choisir lexicalement comme si le théorème de dérivation existait.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Parcourir le vecteur en composant les effets indexés et en respectant les grades des positions. Risque connu : Pli indexé est une hypothèse de factorisation ; ne pas la choisir lexicalement comme si le théorème de dérivation existait.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-028 — Opération d'effet ordinaire

**Objet exact :** `operationε(v)` / Op. Déclencher une opération de signature à effet selon le modèle, avec contrainte de niveau.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — opération de signature**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Déclencher une opération de signature à effet selon le modèle, avec contrainte de niveau. Risque connu : perform décrit un acte de surface ; raise importe le modèle des exceptions.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — opération d'effet**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : perform décrit un acte de surface ; raise importe le modèle des exceptions.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Déclencher une opération de signature à effet selon le modèle, avec contrainte de niveau. Risque connu : perform décrit un acte de surface ; raise importe le modèle des exceptions.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — invocation d'opération**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. perform décrit un acte de surface ; raise importe le modèle des exceptions.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Déclencher une opération de signature à effet selon le modèle, avec contrainte de niveau. Risque connu : perform décrit un acte de surface ; raise importe le modèle des exceptions.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-029 — Opération à portée

**Objet exact :** `scoped_f(v,c)` / Sc. Opération recevant un calcul dont la sémantique dépend d'une transformation de portée soumise à ses propres lois.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — opération à portée**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Opération recevant un calcul dont la sémantique dépend d'une transformation de portée soumise à ses propres lois. Risque connu : « Gestionnaire » nomme une valeur et « handle » une action de surface ; aucun ne doit remplacer la construction.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — interprétation à portée**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : « Gestionnaire » nomme une valeur et « handle » une action de surface ; aucun ne doit remplacer la construction.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Opération recevant un calcul dont la sémantique dépend d'une transformation de portée soumise à ses propres lois. Risque connu : « Gestionnaire » nomme une valeur et « handle » une action de surface ; aucun ne doit remplacer la construction.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — gestion de portée**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. « Gestionnaire » nomme une valeur et « handle » une action de surface ; aucun ne doit remplacer la construction.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Opération recevant un calcul dont la sémantique dépend d'une transformation de portée soumise à ses propres lois. Risque connu : « Gestionnaire » nomme une valeur et « handle » une action de surface ; aucun ne doit remplacer la construction.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

### Q-TERM-030 — Pas différé

**Objet exact :** `delay c` / Del. Reporter un calcul d'un pas ; ce n'est pas une durée arbitraire.  
**Statut :** lemme à arbitrer ; aucune ratification T-68 n'est présumée.  
**Objectif :** trouver un nom qui rende la règle sans confondre l'objet formel, l'action de surface ou une opération voisine.

**A — différé d'un pas**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat de référence ; vérifier la correspondance exacte avec la définition.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Reporter un calcul d'un pas ; ce n'est pas une durée arbitraire. Risque connu : Délai peut évoquer une quantité de temps libre plutôt qu'un pas de sémantique.  
Limite/conséquence : Usage actuel ≠ ratification.

**B — report temporel**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; vérifier le risque sémantique suivant : Délai peut évoquer une quantité de temps libre plutôt qu'un pas de sémantique.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Reporter un calcul d'un pas ; ce n'est pas une durée arbitraire. Risque connu : Délai peut évoquer une quantité de temps libre plutôt qu'un pas de sémantique.  
Limite/conséquence : La transparence n'établit pas la correction.

**C — délai**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; son origine historique reste à vérifier. Délai peut évoquer une quantité de temps libre plutôt qu'un pas de sémantique.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Reporter un calcul d'un pas ; ce n'est pas une durée arbitraire. Risque connu : Délai peut évoquer une quantité de temps libre plutôt qu'un pas de sémantique.  
Limite/conséquence : La longueur ne doit pas masquer une obligation distincte.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; liens aux questions dépendantes ______ ; vérifications K/TLA+/Lean ______.

## 4. Famille : temps, coinduction et concurrence

### Q-TERM-031 — Garantie permanente — introduction

**Objet exact :** `always v` / Alw. Poser une disponibilité permanente sous le contexte requis.  
**Statut :** **BLOQUÉ PAR UNE OBLIGATION THÉORIQUE.** D-T1/D-T2 et/ou correction de ressource doivent être résolus avant de ratifier un nom. Cette question sert à conserver les candidats et les objections, non à trancher prématurément.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — garantie permanente**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Poser une disponibilité permanente sous le contexte requis. Risque connu : « Garantie » est parlant mais peut sur-promettre ; la catégorie grammaticale valeur/calcul reste bloquée par D-T1.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**B — modalité de permanence**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : « Garantie » est parlant mais peut sur-promettre ; la catégorie grammaticale valeur/calcul reste bloquée par D-T1.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Poser une disponibilité permanente sous le contexte requis. Risque connu : « Garantie » est parlant mais peut sur-promettre ; la catégorie grammaticale valeur/calcul reste bloquée par D-T1.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**C — disponibilité permanente**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. « Garantie » est parlant mais peut sur-promettre ; la catégorie grammaticale valeur/calcul reste bloquée par D-T1.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Poser une disponibilité permanente sous le contexte requis. Risque connu : « Garantie » est parlant mais peut sur-promettre ; la catégorie grammaticale valeur/calcul reste bloquée par D-T1.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-032 — Lecture d'une valeur permanente

**Objet exact :** `at v` / Alw⁻. Utiliser une valeur disponible sous garantie permanente ; distinct de la localisation at_n.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — lecture permanente**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Utiliser une valeur disponible sous garantie permanente ; distinct de la localisation at_n. Risque connu : Le token at est une préposition faible et collisionne avec at_n ; le nom doit rendre l'action.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — lecture garantie**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Le token at est une préposition faible et collisionne avec at_n ; le nom doit rendre l'action.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Utiliser une valeur disponible sous garantie permanente ; distinct de la localisation at_n. Risque connu : Le token at est une préposition faible et collisionne avec at_n ; le nom doit rendre l'action.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — emploi d'une garantie**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Le token at est une préposition faible et collisionne avec at_n ; le nom doit rendre l'action.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Utiliser une valeur disponible sous garantie permanente ; distinct de la localisation at_n. Risque connu : Le token at est une préposition faible et collisionne avec at_n ; le nom doit rendre l'action.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-033 — Garantie immédiate

**Objet exact :** `now v` / Now. Introduire une disponibilité immédiate distincte de permanence et d'éventualité.  
**Statut :** **BLOQUÉ PAR UNE OBLIGATION THÉORIQUE.** D-T1/D-T2 et/ou correction de ressource doivent être résolus avant de ratifier un nom. Cette question sert à conserver les candidats et les objections, non à trancher prématurément.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — garantie immédiate**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Introduire une disponibilité immédiate distincte de permanence et d'éventualité. Risque connu : « Maintenant » peut indiquer une horloge ; D-T1 bloque la catégorie exacte.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**B — disponibilité immédiate**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : « Maintenant » peut indiquer une horloge ; D-T1 bloque la catégorie exacte.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Introduire une disponibilité immédiate distincte de permanence et d'éventualité. Risque connu : « Maintenant » peut indiquer une horloge ; D-T1 bloque la catégorie exacte.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**C — modalité d'instant**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. « Maintenant » peut indiquer une horloge ; D-T1 bloque la catégorie exacte.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Introduire une disponibilité immédiate distincte de permanence et d'éventualité. Risque connu : « Maintenant » peut indiquer une horloge ; D-T1 bloque la catégorie exacte.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-034 — Attente / report temporel

**Objet exact :** `wait v` / Wait. Transformer une garantie pour le pas suivant en garantie éventuelle selon la règle temporelle.  
**Statut :** **BLOQUÉ PAR UNE OBLIGATION THÉORIQUE.** D-T1/D-T2 et/ou correction de ressource doivent être résolus avant de ratifier un nom. Cette question sert à conserver les candidats et les objections, non à trancher prématurément.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — attente temporelle**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Transformer une garantie pour le pas suivant en garantie éventuelle selon la règle temporelle. Risque connu : Attendre évoque potentiellement une attente bloquante et non bornée ; la règle exacte doit commander le nom.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**B — attente d'un pas**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Attendre évoque potentiellement une attente bloquante et non bornée ; la règle exacte doit commander le nom.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Transformer une garantie pour le pas suivant en garantie éventuelle selon la règle temporelle. Risque connu : Attendre évoque potentiellement une attente bloquante et non bornée ; la règle exacte doit commander le nom.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**C — report vers l'éventuel**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Attendre évoque potentiellement une attente bloquante et non bornée ; la règle exacte doit commander le nom.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Transformer une garantie pour le pas suivant en garantie éventuelle selon la règle temporelle. Risque connu : Attendre évoque potentiellement une attente bloquante et non bornée ; la règle exacte doit commander le nom.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-035 — Consommation éventuelle

**Objet exact :** `when x = v in c` / When. Poursuivre par substitution lorsque la valeur devient disponible ; latence environnementale distincte du coût de l'automate.  
**Statut :** **BLOQUÉ PAR UNE OBLIGATION THÉORIQUE.** D-T1/D-T2 et/ou correction de ressource doivent être résolus avant de ratifier un nom. Cette question sert à conserver les candidats et les objections, non à trancher prématurément.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — liaison éventuelle**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Poursuivre par substitution lorsque la valeur devient disponible ; latence environnementale distincte du coût de l'automate. Risque connu : Lorsque la représentation de l'attente et la correction de ressource restent ouvertes, aucun candidat ne doit être ratifié.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**B — consommation d'une garantie éventuelle**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Lorsque la représentation de l'attente et la correction de ressource restent ouvertes, aucun candidat ne doit être ratifié.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Poursuivre par substitution lorsque la valeur devient disponible ; latence environnementale distincte du coût de l'automate. Risque connu : Lorsque la représentation de l'attente et la correction de ressource restent ouvertes, aucun candidat ne doit être ratifié.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**C — déclenchement à disponibilité**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Lorsque la représentation de l'attente et la correction de ressource restent ouvertes, aucun candidat ne doit être ratifié.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Poursuivre par substitution lorsque la valeur devient disponible ; latence environnementale distincte du coût de l'automate. Risque connu : Lorsque la représentation de l'attente et la correction de ressource restent ouvertes, aucun candidat ne doit être ratifié.  
Limite/conséquence : ne pas ratifier avant fermeture des dépendances théoriques.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-036 — Observation coinductive

**Objet exact :** `out c` / Out. Observer un cran du point fixe coinductif ; pour les tailles finies, l'observation consomme une unité de disponibilité.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — observation coinductive**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Observer un cran du point fixe coinductif ; pour les tailles finies, l'observation consomme une unité de disponibilité. Risque connu : Observation peut collisionner avec équivalence observationnelle ; extraction collisionne avec les preuves.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — sortie de coalgèbre**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Observation peut collisionner avec équivalence observationnelle ; extraction collisionne avec les preuves.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Observer un cran du point fixe coinductif ; pour les tailles finies, l'observation consomme une unité de disponibilité. Risque connu : Observation peut collisionner avec équivalence observationnelle ; extraction collisionne avec les preuves.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — extraction de flux**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Observation peut collisionner avec équivalence observationnelle ; extraction collisionne avec les preuves.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Observer un cran du point fixe coinductif ; pour les tailles finies, l'observation consomme une unité de disponibilité. Risque connu : Observation peut collisionner avec équivalence observationnelle ; extraction collisionne avec les preuves.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-037 — Définition par copatrons

**Objet exact :** `⟨⟨j ↦ cⱼ⟩⟩` / Cop. Définir une structure coinductive par les réponses aux observations indexées.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — copatron**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Définir une structure coinductive par les réponses aux observations indexées. Risque connu : Copatron est le terme historique ; son usage français et son extension doivent être clarifiés.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — définition par copatron**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Copatron est le terme historique ; son usage français et son extension doivent être clarifiés.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Définir une structure coinductive par les réponses aux observations indexées. Risque connu : Copatron est le terme historique ; son usage français et son extension doivent être clarifiés.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — spécification de sorties**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Copatron est le terme historique ; son usage français et son extension doivent être clarifiés.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Définir une structure coinductive par les réponses aux observations indexées. Risque connu : Copatron est le terme historique ; son usage français et son extension doivent être clarifiés.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-038 — Parallélisme de calcul

**Objet exact :** `c₁ ∥ c₂` / Par. Exécuter les calculs sans ordonner leurs pas ; travail sommé et profondeur déterminée par un maximum.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — mise en parallèle**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Exécuter les calculs sans ordonner leurs pas ; travail sommé et profondeur déterminée par un maximum. Risque connu : Le nom doit suggérer l'indépendance des pas sans promettre un ordonnanceur ou une synchronisation.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — composition parallèle**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Le nom doit suggérer l'indépendance des pas sans promettre un ordonnanceur ou une synchronisation.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Exécuter les calculs sans ordonner leurs pas ; travail sommé et profondeur déterminée par un maximum. Risque connu : Le nom doit suggérer l'indépendance des pas sans promettre un ordonnanceur ou une synchronisation.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — exécution parallèle**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Le nom doit suggérer l'indépendance des pas sans promettre un ordonnanceur ou une synchronisation.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Exécuter les calculs sans ordonner leurs pas ; travail sommé et profondeur déterminée par un maximum. Risque connu : Le nom doit suggérer l'indépendance des pas sans promettre un ordonnanceur ou une synchronisation.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-039 — Application sur vecteur

**Objet exact :** `vmap f v` / Vmap. Appliquer la fonction à chaque élément ; la profondeur annoncée ne dépend pas de la longueur.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — application vectorisée**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Appliquer la fonction à chaque élément ; la profondeur annoncée ne dépend pas de la longueur. Risque connu : Map est familier mais anglais ; élément-par-élément peut masquer le coût en profondeur.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — application élément par élément**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Map est familier mais anglais ; élément-par-élément peut masquer le coût en profondeur.  
Mnémonique : Terme scientifique/familial potentiellement familier à un lecteur formé ; aucune mesure d'apprentissage pour ce contexte n'est disponible.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Appliquer la fonction à chaque élément ; la profondeur annoncée ne dépend pas de la longueur. Risque connu : Map est familier mais anglais ; élément-par-élément peut masquer le coût en profondeur.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — mapping vectoriel**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Map est familier mais anglais ; élément-par-élément peut masquer le coût en profondeur.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Appliquer la fonction à chaque élément ; la profondeur annoncée ne dépend pas de la longueur. Risque connu : Map est familier mais anglais ; élément-par-élément peut masquer le coût en profondeur.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-040 — Localisation de calcul

**Objet exact :** `at_n c` / At. Exécuter le calcul dans un lieu nommé auquel ses ressources sont rattachées.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — localisation**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Exécuter le calcul dans un lieu nommé auquel ses ressources sont rattachées. Risque connu : Placement peut évoquer une décision d'ordonnanceur ; le token at collisionne avec la lecture permanente.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — placement**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Placement peut évoquer une décision d'ordonnanceur ; le token at collisionne avec la lecture permanente.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Exécuter le calcul dans un lieu nommé auquel ses ressources sont rattachées. Risque connu : Placement peut évoquer une décision d'ordonnanceur ; le token at collisionne avec la lecture permanente.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — exécution située**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Placement peut évoquer une décision d'ordonnanceur ; le token at collisionne avec la lecture permanente.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Exécuter le calcul dans un lieu nommé auquel ses ressources sont rattachées. Risque connu : Placement peut évoquer une décision d'ordonnanceur ; le token at collisionne avec la lecture permanente.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-041 — Déplacement d'une valeur

**Objet exact :** `move_{n→m} v` / Move. Transporter une valeur sérialisable vers un lieu dominant, payer le coût réseau sans la copier.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — déplacement**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Transporter une valeur sérialisable vers un lieu dominant, payer le coût réseau sans la copier. Risque connu : Le nom doit faire percevoir la contrainte de lieux dominants, et ne pas suggérer migration d'un processus entier.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — transport de valeur**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Le nom doit faire percevoir la contrainte de lieux dominants, et ne pas suggérer migration d'un processus entier.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Transporter une valeur sérialisable vers un lieu dominant, payer le coût réseau sans la copier. Risque connu : Le nom doit faire percevoir la contrainte de lieux dominants, et ne pas suggérer migration d'un processus entier.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — migration de valeur**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Le nom doit faire percevoir la contrainte de lieux dominants, et ne pas suggérer migration d'un processus entier.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Transporter une valeur sérialisable vers un lieu dominant, payer le coût réseau sans la copier. Risque connu : Le nom doit faire percevoir la contrainte de lieux dominants, et ne pas suggérer migration d'un processus entier.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-042 — Récupération d'échec

**Objet exact :** `try c catch c` / Try. Délimiter un calcul susceptible d'échouer et définir un recours, sans garantir l'absence de panne.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — récupération**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Délimiter un calcul susceptible d'échouer et définir un recours, sans garantir l'absence de panne. Risque connu : Rattrapage peut suggérer la prévention ; récupération n'expose pas seul les conditions de déclenchement.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — traitement de défaillance**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Rattrapage peut suggérer la prévention ; récupération n'expose pas seul les conditions de déclenchement.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Délimiter un calcul susceptible d'échouer et définir un recours, sans garantir l'absence de panne. Risque connu : Rattrapage peut suggérer la prévention ; récupération n'expose pas seul les conditions de déclenchement.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — rattrapage**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Rattrapage peut suggérer la prévention ; récupération n'expose pas seul les conditions de déclenchement.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Délimiter un calcul susceptible d'échouer et définir un recours, sans garantir l'absence de panne. Risque connu : Rattrapage peut suggérer la prévention ; récupération n'expose pas seul les conditions de déclenchement.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-043 — Engendrement de tâche

**Objet exact :** `spawn c` / Spawn. Engendrer une tâche concurrente sans présupposer que le parent doit attendre son achèvement.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — engendrement**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Engendrer une tâche concurrente sans présupposer que le parent doit attendre son achèvement. Risque connu : Le nom ne doit pas présupposer jonction, ordre d'exécution ou stratégie d'ordonnancement.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — création de tâche concurrente**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Le nom ne doit pas présupposer jonction, ordre d'exécution ou stratégie d'ordonnancement.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Engendrer une tâche concurrente sans présupposer que le parent doit attendre son achèvement. Risque connu : Le nom ne doit pas présupposer jonction, ordre d'exécution ou stratégie d'ordonnancement.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — lancement de tâche**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Le nom ne doit pas présupposer jonction, ordre d'exécution ou stratégie d'ordonnancement.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Engendrer une tâche concurrente sans présupposer que le parent doit attendre son achèvement. Risque connu : Le nom ne doit pas présupposer jonction, ordre d'exécution ou stratégie d'ordonnancement.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-044 — Création de boîte aux lettres

**Objet exact :** `new_E` / New. Créer une boîte vide dont les messages admissibles sont déterminés par un motif.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — création de boîte aux lettres**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Créer une boîte vide dont les messages admissibles sont déterminés par un motif. Risque connu : Allocation peut confondre communication et mémoire ; le motif admissible est une contrainte centrale.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — initialisation de boîte**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Allocation peut confondre communication et mémoire ; le motif admissible est une contrainte centrale.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Créer une boîte vide dont les messages admissibles sont déterminés par un motif. Risque connu : Allocation peut confondre communication et mémoire ; le motif admissible est une contrainte centrale.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — allocation de boîte**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Allocation peut confondre communication et mémoire ; le motif admissible est une contrainte centrale.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Créer une boîte vide dont les messages admissibles sont déterminés par un motif. Risque connu : Allocation peut confondre communication et mémoire ; le motif admissible est une contrainte centrale.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-045 — Envoi asynchrone

**Objet exact :** `send m(v̄) to v` / Send. Déposer un message dans une boîte sans attendre sa lecture.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — émission**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Déposer un message dans une boîte sans attendre sa lecture. Risque connu : Envoi peut suggérer un rendez-vous ; émission ne garantit pas la réception ; dépôt de message est précis mais long.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — envoi asynchrone**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Envoi peut suggérer un rendez-vous ; émission ne garantit pas la réception ; dépôt de message est précis mais long.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Déposer un message dans une boîte sans attendre sa lecture. Risque connu : Envoi peut suggérer un rendez-vous ; émission ne garantit pas la réception ; dépôt de message est précis mais long.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — dépôt de message**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Envoi peut suggérer un rendez-vous ; émission ne garantit pas la réception ; dépôt de message est précis mais long.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Déposer un message dans une boîte sans attendre sa lecture. Risque connu : Envoi peut suggérer un rendez-vous ; émission ne garantit pas la réception ; dépôt de message est précis mais long.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-046 — Réception gardée

**Objet exact :** `guard v {mᵢ(x̄ᵢ) ↦ cᵢ}` / Guard. Attendre et consommer un message conforme à un motif, puis poursuivre avec le calcul de la branche sélectionnée.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — réception gardée**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Attendre et consommer un message conforme à un motif, puis poursuivre selon le motif restant. Risque connu : Filtrage suggère une donnée déjà disponible ; réception décrit mieux attente et consommation. L'atomicité multi-message est ouverte.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — sélection de message**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Filtrage suggère une donnée déjà disponible ; réception décrit mieux attente et consommation. L'atomicité multi-message est ouverte.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Attendre et consommer un message conforme à un motif, puis poursuivre selon le motif restant. Risque connu : Filtrage suggère une donnée déjà disponible ; réception décrit mieux attente et consommation. L'atomicité multi-message est ouverte.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — filtrage bloquant**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Filtrage suggère une donnée déjà disponible ; réception décrit mieux attente et consommation. L'atomicité multi-message est ouverte.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Attendre et consommer un message conforme à un motif, puis poursuivre selon le motif restant. Risque connu : Filtrage suggère une donnée déjà disponible ; réception décrit mieux attente et consommation. L'atomicité multi-message est ouverte.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-047 — Libération de boîte

**Objet exact :** `free v` / Free. Détruire une boîte seulement si son motif est épuisé et qu'aucun message admissible ne reste.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — libération**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Transparence lexicale plausible, mais l'association verbale seule ne permet pas de conclure à la mémorabilité.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Détruire une boîte seulement si son motif est épuisé et qu'aucun message admissible ne reste. Risque connu : Clôture peut laisser une ressource lisible ; destruction ne rend pas le prérequis d'épuisement.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — destruction de boîte**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Clôture peut laisser une ressource lisible ; destruction ne rend pas le prérequis d'épuisement.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Détruire une boîte seulement si son motif est épuisé et qu'aucun message admissible ne reste. Risque connu : Clôture peut laisser une ressource lisible ; destruction ne rend pas le prérequis d'épuisement.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — clôture de boîte**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Clôture peut laisser une ressource lisible ; destruction ne rend pas le prérequis d'épuisement.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Détruire une boîte seulement si son motif est épuisé et qu'aucun message admissible ne reste. Risque connu : Clôture peut laisser une ressource lisible ; destruction ne rend pas le prérequis d'épuisement.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

### Q-TERM-048 — Découpe de capacité

**Objet exact :** `slice v as (x,y) in c` / Slice. Consommer une capacité d'écriture sur un segment et produire deux capacités sur des segments disjoints.  
**Statut :** lemme non ratifié ; le token courant est un fait de grammaire, pas une preuve de priorité lexicale.  
**Objectif :** rendre l'effet fonctionnel, les contraintes temporelles/ressources et la portée exacte visibles sans introduire une garantie absente de la règle.

**A — découpe de capacité**  
Origine : lemme descriptif de départ utilisé dans ce dossier ; sa présence ne prouve pas ratification.  
Ancrage scientifique : Candidat nominal à vérifier contre la règle et ses préconditions.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Expose directement l'action nominalisée ; vérifier qu'il rend aussi visible la ressource/condition de typage exigée par la règle. Référent à contrôler : Consommer une capacité d'écriture sur un segment et produire deux capacités sur des segments disjoints. Risque connu : Partition collisionne avec la relation de disjonction ; découpe doit préciser que la capacité est consommée.  
Limite/conséquence : le mot actuel n'est pas un verdict.

**B — partition d'écriture**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Alternative ; objection à instruire : Partition collisionne avec la relation de disjonction ; découpe doit préciser que la capacité est consommée.  
Mnémonique : Composé descriptif qui explicite le référent, au prix d'une plus grande longueur ; facilité d'apprentissage non mesurée.  
Écologique : Met l'accent sur le résultat ou la structure ; peut cacher la contrainte de grade, de temps ou de fraîcheur qui gouverne l'usage. Référent à contrôler : Consommer une capacité d'écriture sur un segment et produire deux capacités sur des segments disjoints. Risque connu : Partition collisionne avec la relation de disjonction ; découpe doit préciser que la capacité est consommée.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**C — tranchage**  
Origine : Proposition de travail de ce dossier ; origine historique non vérifiée et à rechercher.  
Ancrage scientifique : Proposition descriptive ; aucune origine historique/supériorité n'est établie. Partition collisionne avec la relation de disjonction ; découpe doit préciser que la capacité est consommée.  
Mnémonique : Convention anglophone/code potentiellement familière à certains programmeurs ; dépend de l'expérience et de la langue de travail, non mesurée ici.  
Écologique : Fait ressortir une relation fonctionnelle spécifique ; s'il induit une analogie avec un autre formalisme, cette analogie doit être explicitée et testée. Référent à contrôler : Consommer une capacité d'écriture sur un segment et produire deux capacités sur des segments disjoints. Risque connu : Partition collisionne avec la relation de disjonction ; découpe doit préciser que la capacité est consommée.  
Limite/conséquence : les conséquences sur les autres mots de la famille doivent être vérifiées.

**Autre —** ______  
**Précision —** ______  

**Enregistrement :** choix ______ ; statut ______ ; justification facultative ______ ; objection de définition/périmètre ______ ; dépendances ______ ; artefacts formels à vérifier ______.

## 5. Questions liées : token canonique du noyau et lemme français

Ces questions ne sont pas des autorisations de renommage. Elles séparent la décision sur le mot canonique K de celle du lemme français N. Le token de surface S, les labels de règle et le nom d'objet de documentation sont quatre champs distincts. Les candidats marqués « archive » ne sont pas ratifiés.

### Q-TOKEN-001 — nom canonique K de l'introduction de somme

Objet lié : Q-TERM-004 / TERM-INJ ; le noyau écrit actuellement injᵢ.  
A — **inj** : token courant, court et déjà lié à la règle Inj ; risque de forme abrégée contraire au projet de vocabulaire en mots entiers.  
B — **inject** : proposé par l'archive PR #10 pour un mot anglais entier ; origine documentée mais proposition non ratifiée.  
C — **tag** : met en avant l'étiquette ; scientifiquement moins exact si l'injection dans une somme indexée devient invisible.  
Écologique : comparer la visibilité de « branche choisie » à la visibilité de la somme et de l'indice i. Mnémonique : familiarité anglophone potentielle, non mesurée.  
Autre — ______. Précision — ______. Réponse et justification — ______.

### Q-TOKEN-002 — nom canonique K de l'élimination existentielle

Objet lié : Q-TERM-021 / TERM-OPEN ; token courant : open.  
A — **open** : forme courante dans spec ; collision avec le mot-clé Lean open et occurrences de prose repérées par l'archive.  
B — **unpack** : utilisé en prose, proposé par l'archive ; fait ressortir l'opposition avec pack, mais peut évoquer un dépaquetage mémoire.  
C — **open conservé avec distinction de sorte** : évite un renommage sans preuve, mais laisse le risque d'ambiguïté dans les outils futurs.  
Autre — ______. Précision — ______. Réponse — ______. Lien obligatoire à Q-TERM-007 / Pack.

### Q-TOKEN-003A — token pour lire une valeur permanente

Objet lié : Q-TERM-032 / TERM-ALWAYS-READ ; token courant : at v.  
A — **at** : statu quo syntaxique, mais collision avec at_n pour localiser un calcul.  
B — **current** : candidat de l'archive ; suggère une valeur présente, sans garantir qu'il s'agit d'une lecture modale permanente.  
C — **sample** ou **extract** : candidats archivés ; sample peut suggérer un échantillonnage et extract collisionne avec l'extraction de preuve.  
Autre — ______. Précision — ______. Réponse — ______. D-T1 bloque la ratification avant clarification des formes temporelles.

### Q-TOKEN-003B — token de localisation

Objet lié : Q-TERM-040 / TERM-AT-LOCATION ; token courant : at_n.  
A — **at_n** : conserve le token écrit, mais maintient une collision familiale avec at v.  
B — **placed_n** : proposition de l'archive ; explicite le lieu, risque de suggérer un placement d'ordonnanceur.  
C — **here_n / loc_n** : autres candidats historiques de l'archive ; here peut suggérer un lieu courant non présent dans la configuration, loc est une abréviation.  
Autre — ______. Précision — ______. Réponse — ______. À arbitrer avec Q-TOKEN-003A, jamais isolément.

### Q-TOKEN-004 — itération de vecteur

Objet lié : Q-TERM-027 ; token courant : iter_V.  
A — **iter** : courant et lié à la règle VecE ; forme abrégée.  
B — **iterate** : proposition de l'archive PR #10 pour un mot entier ; non ratifiée.  
C — **fold** : rejet provisoire en tant que synonyme sans preuve, car la dérivation en pli indexé gradué est ouverte.  
Autre — ______. Précision — ______. Réponse — ______. Le choix du token ne tranche pas la factorisation théorique.

### Q-TOKEN-005 — application sur vecteur

Objet lié : Q-TERM-039 ; token courant : vmap.  
A — **vmap** : token actuel, compact et familier dans certaines bibliothèques, mais abrégé.  
B — **vectormap** : proposition de l'archive ; explicite le domaine au prix de longueur et n'est pas ratifiée.  
C — **map** : candidat simple mais risque de collision avec une opération générique non limitée aux vecteurs.  
Autre — ______. Précision — ______. Réponse — ______.

### Q-TOKEN-006 — découpe de capacité

Objet lié : Q-TERM-048 ; token courant : slice.  
A — **slice** : token courant, un emprunt connu mais pas ratifié par une décision T-68 finale.  
B — **partition** : candidat de recherche, mais risque sérieux de collision avec la relation de disjonction ρ = ρ₁ ⊎ ρ₂ utilisée comme prémisse.  
C — **slice conservé ; lemme N français arbitré séparément** : distingue stabilité de syntaxe et choix de description.  
Autre — ______. Précision — ______. Réponse — ______.

### Q-TOKEN-007 — noms formels des effets

Objet lié : Q-TERM-028/029 ; les formes courantes operation et scoped sont les noms du noyau, perform et handle sont des actions de surface et handler une valeur.  
A — **operation / scoped conservés** : respecte la distinction type/espèce et action ; le lemme français reste séparé.  
B — **perform / handle comme noms K** : plus familiers comme verbes d'action mais effacent la distinction explicitement documentée entre espèces formelles et actions.  
C — **autre paire** : permise seulement si elle préserve l'argument reçu et les lois de portée différents.  
Autre — ______. Précision — ______. Réponse — ______. REFUS-07 à conserver comme contre-test.

## 6. Arbitrages méthodologiques

### Q-METH-001 — place du critère écologique dans la séquence Arc G

Objectif : fixer un protocole d'arbitrage séquentiel sans score composite, en tenant compte du fait que Vicente/Rasmussen étudient l'interface d'un système complexe, pas un nom seul.

A — **M-A, extension séquentielle** : non-collision → exactitude scientifique → famille et invariants de grade → grille écologique provisoire → arguments mnémoniques → brièveté.  
Ancrage : séquence candidate explicitement proposée par ce dossier ; aucun article ne ratifie cet ordre pour K7PL. Mnémonique : rend visibles les critères sans prétendre à leur mesure. Écologique : priorise les invariants de fonctionnement avant la préférence verbale. Limite : l'ordre écologique reste une décision de conception.

B — **M-B, priorité scientifique stricte** : non-collision → exactitude et préservation des obligations ; famille, écologie, familiarité et longueur servent seulement ensuite à départager les candidats admissibles.  
Ancrage : cohérent avec la doctrine du projet ; ce n'est pas la séquence historique complète d'Arc G. Mnémonique : empêche la familiarité de faire passer une fausse équivalence. Écologique : interdit à un joli mot de compenser une relation fonctionnelle erronée. Limite : moins directement comparable à la collecte historique.

C — **autre protocole séquentiel explicite** : ______. Aucune moyenne pondérée ne sera introduite sans justification et décision distinctes.  
Autre — ______. Précision — ______. Réponse — ______.

**Explicit answer of the author — 2026-10-26 — recorded as VOC-2026-10-26-001 (new content, in English).**

- **Choice: A — M-A, sequential extension**: non-collision → scientific exactness → family and grade invariants → provisional ecological grid → mnemonic arguments → brevity.
- **Status:** the author's method choice; it gives the ecological criterion a rank and lifts blocker B-ONTO-07. It ratifies no term.
- **Recording rule (VOC-2026-10-26-002):** an individual answer to this questionnaire is recorded as a dated preference; it is ratified only in the global lot (VOC-2026-10-25-001).
- **Decision reference:** [decisions](decisions.md), itemised register, section "Decided".

### Q-METH-002 — fermeture du vocabulaire en bloc ou progressivement

A — **lot global après audit ontologique** : ne pas figer de lemmes tant que les écarts de grammaire/règles et les statuts ouverts ne sont pas délimités ; arbitrage lexical en lot une fois les blocages levés.  
B — **familles successives** : ouvrir des questions par famille, mais ne ratifier que celles dont les dépendances scientifiques sont fermées.  
C — **mot par mot dans primitives.md** : seulement avec les dépendances et les conflits reliés et les réponses précédentes enregistrées.  
L'archive PR #10 a proposé la ratification en bloc sans ratification de l'autrice.  
Autre — ______. Précision — ______. Justification — ______.


**Réponse explicite de l'autrice — 25 octobre 2026 — enregistrée sous VOC-2026-10-25-001.**

- **Choix retenu : A — lot global après audit ontologique.** Les lemmes et tokens ne seront pas ratifiés individuellement tant que les contradictions de périmètre, de catégorisation et de chaîne formelle n'auront pas été délimitées.
- **Statut :** choix méthodologique de l'autrice ; il ne constitue ni une ratification scientifique de chaque terme proposé, ni une autorisation de changer les formes normatives.
- **Conséquences immédiates :** poursuivre la vérification des règles, de l'AST Lean, des réductions, des preuves et des tests ; maintenir les questions lexicales ouvertes jusqu'à la clôture ontologique.
- **Référence de décision :** `docs/research/core-vocabulary-decisions-2026-10-25.md`, entrée VOC-2026-10-25-001.

## 7. Blocages qui ne sont pas des votes lexicaux

| ID de blocage | Fait/dépendance | Action avant ratification |
|---|---|---|
| B-ONTO-01 | Le compte de 46 annoncé par C3 et croise.py omet les formes fix et declassify de la table EXPECTED alors qu'elles figurent dans la grammaire et que C3 leur consacre des règles dans le corps. | Audit de couverture du croisement, distinct du QCM ; ne pas renommer ou supprimer ces formes sur cette base. |
| B-ONTO-02 | D-T1 : catégories/typage des formes temporelles, déclassification, at_n et move. | Résoudre les catégories et aligner grammaire, règles et réduction. |
| B-ONTO-03 | D-T2 / P3-B : représentation de l'attente environnementale de When. | Définir l'observation/l'orchestration séparée et réviser l'obligation concernée avant choix final. |
| B-ONTO-04 | When : correction de ressource et éventuelle modalité duale demandée dans l'audit. | Compléter la preuve ou modifier la proposition théorique sous ratification explicite. |
| B-ONTO-05 | Vec : le type est déclaré dérivé, les règles du vecteur et la possibilité de pli indexé gradué exigent leur propre preuve. | Établir obligations conservées/perdues avant d'utiliser fold comme nom ou factorisation. |
| B-ONTO-06 | ν / Out / Cop : règles présentes dans C3 mais récit de registre disant règles manquantes. | Rapprocher l'état du registre avec l'état normatif et les preuves réelles. |
| B-ONTO-07 | Arc G : critères historiques ne donnent pas un rang ratifié au critère écologique. | Lifted on 2026-10-26: Q-METH-001, option A (VOC-2026-10-26-001), ranks the provisional ecological grid fourth. |

## 8. Conséquences de la réponse

Un choix entraîne une nouvelle entrée dans le registre des décisions, avec la date, l'identifiant de question, la version de la définition, le candidat retenu, la justification facultative, les objections, les dépendances et les artefacts à vérifier. Il ne modifie pas automatiquement spec/ ni le code.

L'intégration éventuelle suit un chantier distinct approuvé par l'autrice : mettre à jour les sources normatives et les références dépendantes, vérifier la compilation Verso/Lean et les contrôles de cohérence, puis examiner séparément les preuves et les traces K/TLA+. La réussite de la CI n'établira pas la validité scientifique d'un choix lexical.
