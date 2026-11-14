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

**Answer of the author — 2026-10-28 (VOC-2026-10-28-038), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** a modifier of two operands, as BQN's Choose and J's Agenda (option B): the condition, on its left, designates in the list of branches on its right the only one that runs, `f` the first and `t` the second, as BQN indexes its list. `lst:fonction-pure` becomes `[[< value bound] choose [[Err Overflow] [Ok [+ value 1]]]]`. The `(select C E1 E2)` of the K lexicon is a layer-2 form, in parentheses, where words are n-ary: it is unchanged, and so are the proofs that export it. Put back to the author: chapter 1's synopsis gives layer 3 « `select` vectoriel (dispatch) » as its branching, and `thm:homomorphisme_roues` lowers `select` to a branch-free vector mask, which computes both branches.


#### Q-SPEC-502 — A value on the left of a dyadic word: one result or several

**Object.** In your example of the ninth part, `M A1 D M A2 A3` gives `A1bis A2ter`: `D` takes the values on its right and `A1` stays apart, so the train leaves two results. FIXAPL, chosen in the eighth part, calls a dyadic word infix: a value on its left is its left argument, and a train leaves one result; `[sub 1]` = x − 1 (VOC-2026-10-28-032) follows it. Take `[abs 4 sub neg 7 2]`.

**Facts.**

- FIXAPL: « Dyadic function calls come in the infix position (`⍺+⍵`) and monadic function calls come in the prefix position (`¬⍵`) » (FIXAPL, README (https://github.com/Jacob-Lockwood/fixapl)).
- Factor: « dup ( x -- x x ) »: a stack word may leave several values (Factor, dup (https://docs.factorcode.org/content/word-dup,kernel.html)).

- **A — Infix, as FIXAPL: one result.** A value on the left of a dyadic word is its left argument. Example: `[abs 4 sub neg 7]       ;; abs (4 - (neg 7)) = 11`. *For:* a train has one value, as a `{function …}` type says; agrees with x − 1 and with the fork. *Against:* the stack is not read word by word: values combine by position.
- **B — Stack, as your example: several results.** An operator takes the values on its right; a value on its left stays on the stack; a train may return several values, typed as a product. Example: `[abs 4 sub neg 7 2]     ;; 4 and (neg 7) - 2 = -9`. *For:* the stack execution of layer 3 is read literally, as in Forth and Factor. *Against:* the fork of the eighth part no longer applies to values; a train's type lists all its results.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-039), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Précision : si "abs (4 - (neg 7)) = 11" est la forme mathématique, que l'on peut écrire alors "|4-(-7)| = 11" dans ce cas la bonne écriture en couche 3 est : "[abs sub 4 neg 7]" donnant en décomposition : abs sub 4 -7 => |4 -  -7| => |4 + 7| => |11| => 11. CQFD.

  Autrement : "[abs 4 sub neg 7]" voudrait dire "|4|" et "x+7".
- **Reading:** a train has one result (option A). The justification writes the layer-3 form of |4 − (−7)| = 11 as `[abs sub 4 neg 7]`, decomposed « abs sub 4 -7 », and reads `[abs 4 sub neg 7]` as « |4| » and « x+7 »: a dyadic word followed by two operands takes them in order, and a value on the left of a dyadic word is not its argument. This is the opposite of option A's body (« A value on the left of a dyadic word is its left argument »), which is FIXAPL's infix rule, cited by chapter 5. Applied: one result per train. Put back to the author: how a dyadic word takes values, prefix (`[abs sub 4 neg 7]`) or infix (`[abs 4 sub neg 7]`), and how that reading meets the fork (`[add fold div length]`) and the section `[sub 1]` = x − 1.


### Typed holes

#### Q-TYP-601 — Two holes that must be the same width

**Object.** `{function int int}` resolves two typed holes of the integer family (VOC-2026-10-28-037). Some functions need both to be equal — an identity, or a function that must return the width it receives. Chapter 6 already unifies types in Phase 3 with unification variables, which Phase 4 resolves (« résoudre chaque égalité α̂ := τ par substitution immédiate »).

**Facts.**

- Rust: `impl Trait` « in argument position (where it can act as an anonymous type parameter to functions) » (Rust reference, impl Trait (https://doc.rust-lang.org/reference/types/impl-trait.html)): anonymous, as K7PL's holes.

- **A — Always independent.** Each hole is resolved for itself; a function that needs equal widths writes the width. *For:* nothing to add; a signature says exactly what it constrains. *Against:* an identity on any integer cannot be written once.
- **B — Linked by the data flow.** Holes are unification variables of their family: when the body sends a value from one hole's position to the other's, Phase 3 unifies them. *For:* no syntax; uses the unification chapter 6 describes. *Against:* the link is read from the body, not from the signature.
- **C — Linked by a property of the type.** A property says which holes are the same. Example: `{function int int :same [1 2]}`. *For:* visible in the signature; still no named parameter. *Against:* one more property to learn.

**Answer of the author — 2026-10-28 (VOC-2026-10-28-040), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Imagine : fonction int int => exponent int int
  tel que "int int" signifie "input output"
  Donc que le flux est "input => e^input => output"
  si "input = 10" donc "e int8 int"
  Alors "output = e^10 ≈ 22 026"
  Ce qui implique "exp int8 int16"
  Les deux trous sont donc autonomes et doivent s'adapter à la plus petite allocation nécessaire.
- **Reading:** typed holes are always independent (option A): each is resolved for itself, at the smallest width it needs. The justification reads `{function int int}` as input and output: an exponential of the input 10 takes an `int8` and returns e^10 ≈ 22 026, an `int16`. A function that needs two equal widths writes the width. Chapter 5 states the same case with an integer power, 2^10 = 1 024 in an `int16`, e^10 not being an integer.


#### Q-TYP-602 — Gap: which phase resolves a typed hole, and how instances are named

**Object.** Three passages disagree. Chapter 5: « un trou typé que l'élaboration résout dans la famille des entiers : à la plus petite largeur qui contient toutes les valeurs que le solveur sait borner ». The elaboration theorem: « la phase de résolution du pipeline (Phase 4) résout des variables d'unification, et n'est pas une élaboration au sens du théorème ». Chapter 6: Phase 3 « monomorphise chaque appel générique en une copie concrète », naming an instance « par le condensat de l'AST normalisé de son générique et de ses arguments de type », while « bornes numériques » are left to the SMT solver in Phase 7. A width known in Phase 7 cannot name a Phase-3 copy.

**Facts.**

- rustc: « The monomorphization collector is run just before MIR lowering and codegen », after type checking (rustc dev guide, monomorphization (https://rustc-dev-guide.rust-lang.org/backend/monomorph.html)).

- **A — Two steps.** Phase 3 copies per family, the hole staying a hole; Phase 7 fixes the widths and names the final instances. Chapter 5 says « résolution », not « élaboration ». *For:* keeps chapter 6's order and its cache by hash. *Against:* an instance has two names over its life.
- **B — Monomorphisation after Phase 7.** Phase 3 only unifies; copies are made once every width is known, as rustc collects just before code generation. *For:* one naming, by concrete types. *Against:* moves a step of chapter 6 and what Phases 5 and 6 check.
- **C — Widths fixed in Phase 3 where narrowing finds them.** The solver of Phase 7 only checks; a hole that narrowing cannot bound is refused (`ERR-SMT-003`). *For:* chapter 6's text barely changes. *Against:* refuses holes the solver could have bounded.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-008), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** les phases de compilations sont réputés non fiabilisées. par exemple, la résolution SMT n'a pas suffisament été explorée pour identifier les traitements paralleles etc. ici, dans la mesure du possible, j'aimerais trouver les stratégies permettant de limiter les temps de compilations hyper longs de Rust.
- **Reading:** monomorphisation after Phase 7 (option B): Phase 3 only unifies, a typed hole stays a variable of its family, and the copies are made once the solver has fixed every width, so that an instance has one name, from its concrete types. Placed at the opening of Phase 8, where chapter 6 already has monomorphisation share the specialisation budget of inlining (« laquelle n'est qu'une intégration dirigée par les types »): Phases 5 and 6 then check each generic once, not each copy, as rustc checks a generic before its monomorphisation collector runs. The justification: the compilation phases are not yet made reliable, and SMT solving has not been explored enough to identify what can run in parallel; the author asks for strategies that avoid Rust's very long compilation times. That research is the third report of the reading lot after the tenth part (research.md).


#### Q-TYP-603 — Gap: the phase of `ERR-TYP-013`

**Object.** Ninth part: a text width that is not a multiple of its encoding's unit is refused « en phase 0 » (now `ERR-TYP-013`). Chapter 6: Phase 0 builds the tree and desugars sigils, « un travail purement syntaxique, qui ne discute encore aucun des trois ordres »; types are established in Phase 3.

- **A — Phase 0.** The reader knows the units of the built-in encodings and checks `{str 12 utf8}` as it reads it. *For:* the earliest refusal, as you asked. *Against:* Phase 0 is no longer purely syntactic; chapter 6 says so.
- **B — Phase 3.** Where types are established. *For:* chapter 6 unchanged. *Against:* later than you asked.
- **C — Phase 0 for built-in encodings, Phase 3 for declared ones.** *For:* earliest where possible. *Against:* one code, two places.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-009), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** un lsp devrait vérifier cela au fur et à mesure de l'écriture du code ce qui permettrait de remonter les problématiques à l'utilisateur avant de réaliser la compilation qui elle doit suivre un protocole strict et reproductible.
- **Reading:** Phase 3, where types are established (option B): chapter 6 keeps Phase 0 purely syntactic. The justification gives the earliness to tooling: a language server checks the width while the code is written, before compilation, which follows a strict and reproducible protocol.


### Patterns

#### Q-SPEC-503 — What `@x` gives when it catches

**Object.** Ninth part: everything is a pattern, and `@` in front of a construction « catch[es] this pattern » and inherits all its construction (VOC-2026-10-28-029). Also: « en K7PL, rien ne s'étend, tout se précise » (VOC-2026-10-28-031). Chapter 5 now says « en hérite toute la construction ». Open: what `@x` gives the code that follows.

**Facts.**

- Rust: « The at operator @ lets us create a variable that holds a value at the same time we’re testing that value for a pattern match » (Rust book, patterns (https://doc.rust-lang.org/book/ch19-03-pattern-syntax.html)).
- F#: « Active patterns enable you to define named partitions that subdivide input data » (F#, active patterns (https://learn.microsoft.com/en-us/dotnet/fsharp/language-reference/active-patterns)).

- **A — A refinement.** What `@x` catches is typed by `x`'s construction made precise — a refined type, as `{{ }}`; « hérite » is read as « se précise ». *For:* fits « tout se précise » and the refinement types of chapter 3.
- **B — A filter.** `@x` lets through what matches, on a flow or the network, and binds nothing. *For:* simplest on a data flow. *Against:* the code after the match does not know what matched.
- **C — Both.** In a `match`, `@x` binds the value refined by `x`; on a flow it filters. *For:* one sign, two uses that agree. *Against:* two readings to describe.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** a refinement (option A): what `@x` catches is typed by `x`'s construction made precise, a refined type such as `{{ … }}` writes; « hérite » is read as « se précise ».


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

**Answer of the author — 2026-10-29 (VOC-2026-10-29-011), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** j'ai besoin d'un rapport analytique adversarial complet sur ce sujet avec limites, opportunités, exemples, etc. et notamment un paragraphe d'analyse scientifique sur le sujet et les possibilités concernant K7PL.
- **Reading:** kept open: the author asks for a complete adversarial analytical report on the subject, with its limits, opportunities and examples, and a paragraph of scientific analysis of the subject and of K7PL's possibilities. The report is in research.md (reading lot after the tenth part); the question is asked again after it.


#### Q-SPEC-505 — Gap: top-level forms as autonomous processes

**Object.** Ninth part: « une S-Expression non encapsulée dans une autre est un processus autonome executable en parallele des autres du même rang ». The specification says nothing of top-level forms. Chapter 6's Phase 2 collects actor definitions and checks the wiring graph is acyclic; chapter 4: « la coalgèbre qui produit l'état suivant n'est plus celle d'un acteur isolé, mais celle de l'orchestrateur tout entier ».

- **A — Every top-level form, whatever its layer.** Declarations `{ }` run in parallel at compile time, `( )` and `[ ]` at run time. *For:* one rule. *Against:* a declaration is not a process in chapter 6's phases.
- **B — Top-level layer-2 forms only.** `( )` at top level are processes started by the orchestrator; `{ }` are declarations; a top-level `[ ]` is a pure value. *For:* fits the layers and the orchestrator of chapter 4.
- **C — B, ordered by dependencies.** Top-level processes start in parallel, ordered only by their data dependencies and the wiring graph of Phase 2. *For:* « même rang » gets a meaning: the same depth in the dependency graph. *Against:* one more rule to write in chapter 4.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-010), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** j'ai besoin d'un rapport analytique adversarial complet sur ce sujet avec limites, opportunités, exemples, etc. et notamment un paragraphe d'analyse scientifique sur le sujet et les possibilités concernant K7PL.
- **Reading:** kept open, with the same request as Q-SPEC-504: a complete adversarial analytical report, its limits, opportunities and examples, and a paragraph of scientific analysis. The report is in research.md (reading lot after the tenth part); the question is asked again after it.


### Actor scenarios

#### Q-ACT-001 — What a scenario is

**Object.** Seventh part: « il nous faut une approche plus systémique pour identifier et composer les scénarios avec la question : est-ce que je souhaite séparer une vérification d'une transformation, d'une livraison, etc. ». A scenario may be the reaction to one message, or a sequence of messages between actors.

**Facts.**

- Chapter 3: « Un type de session n'en est que la version distribuée : le même automate, sauf que ses transitions sont déclenchées par l'échange de messages entre deux extrémités ».
- Saga: « A saga is a reliably coordinated sequence of local transactions […] either all steps complete successfully or, if a local transaction fails […], the changes made by the completed steps are undone by compensating transactions » (microservices.io, Saga (https://microservices.io/patterns/data/saga.html)).

- **A — The reaction to one message.** Check, transform, deliver.
- **B — A sequence of messages.** A protocol between actors, typed by a session type.
- **C — Both, the second built from the first.** A protocol is a session type whose steps are reactions. *For:* each level keeps its own tools.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-002), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** Précision : l'objectif est de réagir donc pas de "check" => c'est la cible "event-based" de K7PL qui vient compléter la phylosophie "lazy"
- **Reading:** both, the second built from the first (option C): a protocol between actors is a session type whose steps are reactions. The justification: the aim is to react, so a reaction has no « check » step of its own; this is K7PL's event-based target, which complements its lazy philosophy, the one recorded on 2026-10-27 (the automata compiled in layer 3 are invoked lazily by the orchestrator).


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

**Answer of the author — 2026-10-29 (VOC-2026-10-29-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** decide and evolve, with today's form as their shorthand (option C): the decision (layer 3) gives events or a refusal, the evolution (layer 3) applies each event to the state, and the delivery (layer 2) is described; `:on … :sets` stays as a decision of one event that sets one field.


#### Q-ACT-003 — Named events

**Object.** Should what happened be named — `Incremented` —, apart from the new state?

**Facts.**

- Fowler: « Capture all changes to an application state as a sequence of events » (Event Sourcing (https://martinfowler.com/eaaDev/EventSourcing.html)).

- **A — Yes, always.** *For:* the journal holds facts; decide and evolve separate.
- **B — No: the new state and the reply only.** *For:* less to declare.
- **C — When an actor declares them.** *For:* event sourcing where it is wanted.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-004), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** events are named when an actor declares them (option C): event sourcing where it is wanted.


#### Q-ACT-004 — A refused check

**Object.** When the check of a message fails (today `Err Overflow`).

- **A — State intact, an error reply only.**
- **B — State intact, an error reply, and the refusal recorded as an event.** *For:* refusals are audited.
- **C — Left to the decision.** A refusal may produce events like any decision.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-005), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** l'option B est compatible avec l'option C : l'utilisateur peut choisir de logger les refus ou non, d'y réagir ou non
- **Reading:** left to the decision (option C): a refusal is a decision like any other and may produce events. The justification: option B fits within C, the developer choosing whether refusals are recorded and whether anything reacts to them.


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

**Answer of the author — 2026-10-29 (VOC-2026-10-29-012), given in the clickable questionnaire, quoted as given.**

- **Choice:** send, persist
- **Justification:** reply est inutile et la cible du message doit avoir un :on pour acceuillir le message envoyé par send. persist est effectivement important, outside est inutile car il s'agit d'envoyer (send) un message à un acteur qui prend en charge l'interopérabilité étrangère. later n'est pas pertnent, je préfère un 'defer' dans un statement :on
- **Reading:** a delivery covers sending messages to actors and persisting. No reply of its own: a reply is a message sent to the sender, which receives it through its own `:on`. No outside world of its own: it is reached by sending to an actor in charge of foreign interoperability. No timer: a `defer` inside an `:on` clause defers. Put back to the author: what `defer` takes, and what `persist` writes beside the journal of Q-ACT-007.


#### Q-ACT-006 — Steps shared between messages

**Object.** Can a check or a delivery be written once and used by several messages?

- **A — No, per message.**
- **B — Within an actor.** Example: `{defstep below-bound …}  :on (Increment :check below-bound …)`.
- **C — Across actors too.** A library of checks and deliveries. *For:* reuse. *Against:* a step's type must be generic over the state it reads.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-006), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** dans l'espace mémoire du cluster d'acteur tel que défini dans le chapitre sur l'execution parallele et concourante
- **Reading:** steps are shared « dans l'espace mémoire du cluster d'acteur tel que défini dans le chapitre sur l'exécution parallèle et concourante ». Read on 2026-10-29: the specification names clusters once (chapter 1: « c'est le macro-modèle des acteurs et des clusters ») and defines none; chapter 4 has fibrils share « la mémoire d'une même instance d'exécution » under acquire-release; the archive of early K premises declared clusters with `defcluster` (research.md). Put back to the author as a gap: where the cluster and its memory space are defined.


#### Q-ACT-007 — Gap: what the journal holds

**Object.** Chapter 3: « c'est cette exécution, non la transition, qui est journalisée ». Chapter 4, `thm:determinisme_rejeu`: replaying « les messages journalisés J(H) à travers les gestionnaires purs »; non-deterministic operations are « journalisées comme entrées factuelles ». The two do not name the same contents.

**Facts.**

- Akka: « The event handler must only update the state and never perform side effects, as those would also be executed during recovery of the persistent actor » (Akka, persistence (https://doc.akka.io/libraries/akka-core/current/typed/persistence.html)).

- **A — Messages and capability values.** As chapter 4; replay runs the transitions again, never the deliveries; chapter 3's sentence is reworded. *For:* the replay theorem stays as stated.
- **B — Events.** Replay applies `evolve` again, never `decide` nor the deliveries. *For:* short journal of facts. *Against:* the replay theorem is restated over events.
- **C — Both.** Messages and capability values as inputs, events as outputs; deliveries are never replayed. *For:* audit and replay both. *Against:* a larger journal.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-007), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** A par défaut avec la possibilité d'ajouter les events au journal de l'acteur
- **Reading:** the journal holds the messages and the capability values by default (option A, as chapter 4's `thm:determinisme_rejeu`), and an actor may add its events to its journal. Replay runs the transitions again, never the deliveries. Applied: chapter 3's « c'est cette exécution, non la transition, qui est journalisée » is reworded.


## Lot of 2026-10-29, eleventh part: modules, top-level forms and compilation time after the reports, and the points put back

Opened on 2026-10-29 after the tenth part: Q-SPEC-504 and Q-SPEC-505 asked again after the
reports the author requested (research.md, reading lot after the tenth part), the strategies
against long compilations of Report 3, and the points put back from the tenth part. Same rules:
context in the specification, literature, options with their pros and cons; **Other** and
**Clarify** are always available.

Every word of the examples (`choose`, `defunit`, `defmodule`, `defer`, `persist`…) is a placeholder: the words are chosen later. The three reports are in the wiki, research.md, « Reading lot: research of 2026-10-29, after the tenth part »; each question below sums up what it needs. Questions titled « Gap » point at places where the specification is imprecise or contradicts itself.

### Modules, after Report 1

#### Q-SPEC-601 — What a module is, after the report

**Object.** Report 1 (research.md (https://github.com/AntheaLiles/k7pl/blob/claude/nifty-bardeen-whx5pv/wiki/research.md)) finds that the specification already has four groupings: the namespace, a view of the dependency graph (chapter 4: « remplace la hiérarchie de dossiers physiques par une lecture purement logique du graphe de types »); the module, an object of that graph, used but never defined; the compilation unit, with its roots, its budget, its stamp and its interface, which chapter 6 defines as its judgement (`thm:interface_jugement`: « le langage n'a pas de langage de modules séparé à maintenir »); and the package, where certificates are required. The file is a fifth, implicit one. Scope (which names a text sees) is fixed at Phase 1 and needs only a lexical perimeter.

**Facts.**

- Leroy: « Modularization is the process of decomposing a program in small units (modules) that can be understood in isolation by the programmers […]. Separate compilation is the process of decomposing a program in small units (compilation units) that can be typechecked and compiled separately by the compiler »; identifying them « is limiting » (Leroy, POPL 1994 (https://xavierleroy.org/publi/manifest-types-popl.pdf)).
- Rust: « A crate is a unit of compilation and linking, as well as versioning, distribution, and runtime loading. A crate contains a tree of nested module scopes » (Rust reference (https://doc.rust-lang.org/reference/crates-and-source-files.html)).
- Unison: « Each Unison definition is identified by a hash of its syntax tree »; « we can parse and typecheck definitions once, and then store the results in a cache which is never invalidated » (Unison, the big idea (https://www.unison-lang.org/docs/the-big-idea/)).
- Backpack: in ML-style systems « explicit interfaces express assumptions about dependencies, and each module can be typechecked and reasoned about independently » (Backpack (https://plv.mpi-sws.org/backpack/)).

- **A — The file is the module.** Its lexical perimeter, its compilation unit and its path at once. *For:* one notion; Emacs's file-local lexical binding is exactly this. *Against:* chapter 4 has already replaced folders by the dependency graph; the budget and the cache become per file; renaming a file changes a module.
- **B — The compilation unit is the module; a file is a lexical perimeter.** Example: `{defunit math/stats :roots (mean std-dev) :budget 64}   ;; spans several files`. *For:* chapter 6 already defines it with its interface, budget and stamp; Leroy's two processes kept apart. *Against:* the unit is the grain of parallelism and reuse unless split again (Report 3).
- **D — Definitions identified by hash; a module is a named, versioned set with an interface.** As Unison for identity, as B for the boundary that carries interface, budget, stamp and certificate; files are lexical perimeters. Example: `{defmodule math/stats :version 1.2.0 :exports (mean std-dev)}`. *For:* extends chapter 6's hashed instances to every definition: typed once, cached for good, checked in parallel. *Against:* a tool must map names, versions and files to hashes; changing a widely used definition re-checks its dependents.
- **E — ML-style modules: signatures, structures, functors.** *For:* the strongest separate type checking. *Against:* chapter 6 already rules out a separate module language; a functor names parameters, which VOC-2026-10-28-037 refuses.
- **C — No module.** *For:* nothing new. *Against:* chapter 6's interface, budget, stamp and certificate lose their object; no separate compilation.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-013), given in the clickable questionnaire, quoted as given.**

- **Choice:** D
- **Reading:** definitions are identified by a hash of their normalised tree, as chapter 6 already names its instances, so that each is typed once and its results are cached for good; a module is a named set of definitions with an interface, the boundary that carries the interface, the specialisation budget and the stamp; files are lexical perimeters only (option D). Read with Q-SPEC-602, which puts the version and the certificate on the package: option D's example wrote `:version` on the module, and whether a module carries a version of its own is put back. Applied: chapter 6.


#### Q-SPEC-602 — Module, unit, package: how many words

**Object.** Chapter 6 says « Une interface de module doit énoncer trois choses » and then defines the interface of a compilation unit; it also speaks of « la frontière de paquet ». Whatever Q-SPEC-601 decides, the specification needs to say whether these name one thing or several.

- **A — One word for all three.** *For:* nothing to tell apart. *Against:* what is distributed and certified cannot be larger than what is compiled.
- **B — Two: the module (= the unit) and the package, what is distributed, versioned and certified.** *For:* as Rust's crate and Cargo package; the certificate boundary of chapter 6 gets its own word. *Against:* two words to choose.
- **C — Three: module, unit and package apart.** *For:* each of Leroy's processes and distribution has its word. *Against:* three notions to keep consistent.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-014), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** two words: the module, which is the compilation unit, and the package, which is distributed, versioned and certified, the certificate boundary of chapter 6 being the package's (option B). The words themselves are chosen later. Applied: chapter 6.


#### Q-SPEC-603 — Gap: « paquet » names two things

**Object.** Chapter 3 calls an existential package a « paquet » (`pack`, `unpack`, « filtrage sur paquet effacé »); chapter 6 calls « frontière de paquet » the boundary across which SMT obligations need a certificate, and chapter 3 names « la signature des paquets » among boundary strategies.

- **A — « paquet » stays for existentials; the distributed thing takes another word.** *For:* the type-theoretic term is the older and the more precise. *Against:* chapter 6 and chapter 3's boundary sentence are reworded.
- **B — « paquet » is the distributed thing; chapter 3 writes « paquet existentiel » in full.** *For:* matches common usage of « package ». *Against:* chapter 3's existential passages are reworded.
- **C — Leave both, the context telling them apart.** *For:* no change. *Against:* a reader of chapter 6 may read an existential where a distribution is meant.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-025), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** Vérifie qu'il n'y a pas d'ambigüité entre `pack` `unpack` et `box` `unbox`.
- **Reading:** left open: the author asks to check that `pack`/`unpack` and `box`/`unbox` are not ambiguous. The check is in research.md (« Reading lot: research after the eleventh part »); what it finds returns as a question of the next part. Nothing is applied.


### Top-level forms, after Report 2

#### Q-SPEC-604 — Top-level forms, after the report

**Object.** Report 2 finds that the specification has the target — chapter 4's « composition parallèle d'acteurs sous restriction des canaux privés », Phase 2's acyclic wiring graph, the journal — and already has virtual actors: « Un acteur virtuel est une adresse logique dans le modèle abstrait », activated by loading a snapshot and replaying its journal (chapter 4). Nothing maps a text's top-level forms to that composition, and chapter 6's « points d'entrée » are undefined. Your statement: « une S-Expression non encapsulée dans une autre est un processus autonome executable en parallele des autres du même rang ».

**Facts.**

- Go: « package-level variable initialization proceeds stepwise, with each step selecting the variable earliest in declaration order which has no dependencies on uninitialized variables »; cycles make the program « not valid » (Go specification (https://go.dev/ref/spec#Package_initialization)).
- Orleans: « Actors are purely logical entities that always exist, virtually. An actor cannot be explicitly created nor destroyed […]. Since actors always exist, they are always addressable » (Orleans overview (https://learn.microsoft.com/en-us/dotnet/orleans/overview)).
- Haskell: « A Haskell program is a collection of modules, one of which, by convention, must be called Main and must export the value main » (Haskell 2010, chapter 5 (https://www.haskell.org/onlinereport/haskell2010/haskellch5.html)).

- **A — Every top-level form, whatever its layer.** *For:* your statement taken literally. *Against:* a `{ }` declaration and a `[ ]` value have no behaviour to run.
- **B — Top-level `( )` forms are processes; `{ }` declare; a top-level `[ ]` is a value.** *For:* follows the layers. *Against:* says nothing of start order.
- **C — B, started in dependency order.** Phase 2's topological order; processes of one rank start in parallel. *For:* Go's precedent; cycles already refused (`ERR-ARC-001`). *Against:* the start takes as many steps as the graph is deep.
- **D — B, activated lazily.** Top-level processes are chapter 4's virtual actors, activated by their first message; only event sources (an ingress, a `defer`) start at once. *For:* the lazy, event-based target; no start order to specify; chapter 4 already has the lifecycle. *Against:* what starts the program must be named; the first message pays the activation.

  ```text
  (counter)                              ;; virtual until its first message
  (http-ingress :port 8080 :to counter)  ;; an event source, started at once
  ```

- **F — D, with C's order among the event sources.** *For:* lazy processes, ordered sources. *Against:* two rules.
- **E — One entry point (`main`).** *For:* explicit, as Haskell and Pony. *Against:* contradicts autonomous top-level processes.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-015), given in the clickable questionnaire, quoted as given.**

- **Choice:** F
- **Reading:** top-level `( )` forms are processes, `{ }` forms declare and a top-level `[ ]` is a value; top-level processes are chapter 4's virtual actors, activated by their first message, and only event sources (an ingress, a `defer`) start at once, in Phase 2's dependency order, the sources of one rank starting in parallel (option F). What starts a program is thus its event sources. Applied: chapter 4, after the virtual actor.


#### Q-SPEC-605 — What « même rang » means

- **A — The same depth in the dependency order.** A stratification: one stratum in parallel, strata in sequence, as the strata of chapter 2's `thm:terminaison_strates`. *For:* a precise meaning, already computed in Phase 2. *Against:* only useful if start is ordered (C or F).
- **B — The same layer, not nested.** *For:* read off the text. *Against:* gives no order; order comes from messages.
- **C — Nothing more is needed.** Under lazy activation (D), processes have no rank, only messages. *For:* one notion less. *Against:* your statement loses a word.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-016), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** « même rang » is the same depth in the dependency order: the forms of one stratum start in parallel, the strata in sequence (option A); with Q-SPEC-604 it orders the event sources. Applied: chapter 4.


#### Q-SPEC-606 — Kahn sub-networks, a hypothesis

**Object.** Report 2: actors whose mailbox merges several senders are not deterministic, which is why chapter 1 journals their interleaving. A sub-network whose channels each have one writer and one reader, read by blocking receives, is a Kahn network.

**Facts.**

- Lee: « In the original PN model due to Kahn and MacQueen [31], the blocking reads ensure that every network defines a deterministic computation » (E. A. Lee, The Problem with Threads (https://www2.eecs.berkeley.edu/Pubs/TechRpts/2006/EECS-2006-1.pdf)).

- **A — Pursue it as an open proposition of chapter 4.** Phase 2 recognises such sub-networks, and their interleavings are not journaled. *For:* a shorter journal without weaker replay. *Against:* a proof that the executive preserves the restriction is owed.
- **B — Keep it in research only.** *For:* no commitment yet.
- **C — Drop it.** *For:* one journal rule for every actor.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-017), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** Kahn sub-networks are pursued as an open proposition of chapter 4: Phase 2 recognises the sub-networks whose channels each have one writer and one reader, read by blocking receives, and their interleavings are not journaled; the proof that the executive preserves the restriction is owed (option A). Applied: chapter 4, as a conjecture that cites Kahn and MacQueen through Lee.


### Compilation time, after Report 3

#### Q-TYP-701 — Strategies against long compilations

**Object.** Report 3 lists eight strategies, marked as already in the specification, compatible, or closed. Chapter 6 already requires that « Tout travail de compilation est borné par un grade porté par l'unité de compilation, et ce grade se mesure en compte de ressource reproductible — jamais en délai ». Choose those to write into the specification as aims.

**Facts.**

- Mokhov, Mitchell and Peyton Jones: « A build system is minimal if it executes tasks at most once per build and only if they transitively depend on inputs that changed since the previous build » (Build Systems à la Carte (https://www.microsoft.com/en-us/research/uploads/prod/2018/03/build-systems-a-la-carte.pdf)).
- F*: « Even a single poorly chosen quantified assumption in the prover’s context can make an otherwise simple proof take very long » (F* tutorial (https://fstar-lang.org/tutorial/book/under_the_hood/uth_smt.html)).
- Leino and Wüstholz: caching « uses the program’s call graph and control-flow graph to focus the verification effort on just the parts of the program that were affected by the user’s most recent modifications » (CAV 2015 (https://www.microsoft.com/en-us/research/publication/fine-grained-caching-of-verification-results/)).
- rustc: « These are then generated by independent instances of LLVM running in parallel » (rustc dev guide (https://rustc-dev-guide.rust-lang.org/parallel-rustc.html)); Cranelift « has the potential to improve compilation times in debug mode » (rustc_codegen_cranelift (https://github.com/rust-lang/rustc_codegen_cranelift)).

Several options may be chosen.

- **S1 — Every phase's results keyed by hash (compiler included).** *For:* an incremental build equals a clean one. *Against:* a store to collect.
- **S2 — Query-based incremental compilation with early cutoff.** *For:* redo only what changed. *Against:* complex; needs S1 to stay reproducible.
- **S3 — Parallelism by independence: definitions, obligations, instances.** *For:* names fixed at Phase 1 and obligatory signatures make definitions independent. *Against:* Phases 7 and 8 iterate over the whole unit.
- **S4 — Cached and replayed verification (certificates used locally too).** *For:* the verifier costs what changed. *Against:* checking a certificate is not free.
- **S5 — Solver discipline: 𝒯₀, no quantifiers, small queries, resource counts.** *For:* predictable and repeatable verification. *Against:* 𝒯₀ is not yet delimited; more refusals.
- **S6 — Fewer instances (reached only, by hash, budgeted).** *For:* already in chapter 6. *Against:* Go's shape stenciling is closed by `ERR-POL-001`.
- **S7 — Two back ends: a fast one for development, an optimising one for release.** *For:* short loops; the language server checks while writing. *Against:* two back ends to keep equivalent.
- **S8 — Fail early (Phase 2's manifest, the language server).** *For:* already in chapter 6. *Against:* none new.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-018), given in the clickable questionnaire, quoted as given.**

- **Choice:** S1, S2, S3, S4, S5, S8
- **Reading:** six strategies are written into the specification as aims: every phase's results keyed by hash, the compiler included (S1); query-based incremental compilation with early cutoff (S2); parallelism by the independence of definitions, obligations and instances (S3); cached and replayed verification, certificates being used locally too (S4); a solver discipline of 𝒯₀, no quantifiers, small queries and resource counts (S5); failing early (S8). Not retained: fewer instances (S6), already in chapter 6 and unchanged there, and two back ends (S7). Applied: chapter 6, after the bounded-compilation requirement.


#### Q-TYP-702 — Independent holes and the number of instances

**Object.** Report 3, inferred: holes resolved each at its smallest width (VOC-2026-10-28-040) multiply instances — a `{function int int}` used with four input widths and four output widths may need up to sixteen copies. The specialisation budget bounds them, and refuses beyond it (`ERR-POL-002`).

**Facts.**

- Go stencils « a single chunk of assembly for each unique GC shape » and passes a dictionary for the rest (Go, GC shape stenciling (https://github.com/golang/proposal/blob/master/design/generics-implementation-gcshape.md)); chapter 6 forbids run-time dictionaries (`ERR-POL-001`).

- **A — Keep the smallest width; the budget decides.** *For:* the « plus petite largeur » rule unchanged. *Against:* instances may multiply up to the budget.
- **B — Round hole widths to a small set (8, 16, 32, 64…).** *For:* few instances, shared between uses. *Against:* a hole may get more bits than it needs.
- **C — Smallest width, rounded only when the budget would be exceeded.** The compiler rounds and reports it with a `HEY-` remark. *For:* precision by default, compilation still bounded. *Against:* an instance's width depends on the rest of the program.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-019), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** hole widths are rounded to a small set, 8, 16, 32, 64 bits and so on, read as the powers of two from 8: a typed hole takes the smallest width of that set that holds every value the solver bounds (option B). This replaces « la plus petite largeur » of VOC-2026-10-28-040; the example of chapter 5 keeps its widths, 8 and 16 being in the set. Applied: chapter 5.


### Layer 3, put back

#### Q-SPEC-607 — How a dyadic word takes values

**Object.** Your precision to Q-SPEC-502 (VOC-2026-10-28-039): the layer-3 form of |4 − (−7)| = 11 is `[abs sub 4 neg 7]`, and `[abs 4 sub neg 7]` would mean « |4| » and « x+7 ». The option you chose, A, said the opposite: « A value on the left of a dyadic word is its left argument », FIXAPL's infix rule that chapter 5 cites. Both readings keep the section `[sub 1]` = x − 1 and the fork `[add fold div length]`; they differ on values.

**Facts.**

- FIXAPL: « Dyadic function calls come in the infix position (`⍺+⍵`) and monadic function calls come in the prefix position (`¬⍵`) » (FIXAPL (https://github.com/Jacob-Lockwood/fixapl)).
- Chapter 5: layers 1 and 2 write prefix S-expressions, as `(abs (sub 4 (neg 7)))`; with fixed arities, the same prefix order reads without parentheses (inferred).

- **A — Infix, as FIXAPL.** A value on the left of a dyadic word is its left argument; a dyadic word never takes two values on its right. *For:* one rule for values and functions; FIXAPL as cited. *Against:* your writing is refused; layer 3 reads in another order than layer 2.

  ```text
  [abs 4 sub neg 7]    ;; 11
  [abs sub 4 neg 7]    ;; refused: two values side by side
  ```

- **B — Prefix, as your precision.** A dyadic word followed by two operands takes them in order; followed by one, that one is its right argument and the left comes from the word on its left (fork) or from the train's argument. *For:* the same order as layer 2, without parentheses; your example as written. *Against:* two ways to give a dyadic word its left argument; whether a group is one operand or two depends on values and functions.

  ```text
  [abs sub 4 neg 7]    ;; 11, as (abs (sub 4 (neg 7)))
  [abs 4 sub neg 7]    ;; refused: two results, |4| and x+7
  ```

**Answer of the author — 2026-10-29 (VOC-2026-10-29-020), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** B et sans équivoque. Le dyadique regarde le premier et le deuxième à droite. Pure application de la Polish Notation. Le débat est clos. Pas d'histoire de regarder à gauche ou je sais pas quoi.
- **Reading:** prefix, as option B without its fork: a dyadic word takes the first and the second operand on its right, as in Polish notation, and no word takes an operand on its left. Kept from option B's body: a dyadic word followed by one operand takes it as its right argument, the train's argument giving the left one, so `[sub 1]` stays x − 1 (VOC-2026-10-28-032); a monadic word with nothing on its right takes the train's argument. Withdrawn: the fork of the eighth part (VOC-2026-10-28-012), where a dyadic word took the word on its left. The mean `[add fold div length]` keeps its writing and its value, read now as the sum of each element divided by the length; the standard deviation, which needed the fork, is rewritten `[sqrt [add fold div length] square sub add fold div length]`. Put back: whether the rule extends to modifiers, which still follow their operand (`add fold`) or stand between two (`choose`). Applied: chapter 5.


#### Q-SPEC-608 — Gap: `choose` and the vector mask

**Object.** Chapter 5 now writes the layer-3 conditional with `choose`, which evaluates only the designated branch (VOC-2026-10-28-038). Chapter 1's synopsis gives layer 3 « `select` vectoriel (dispatch) » as its branching, and `thm:homomorphisme_roues` lowers `select` to « masquage vectoriel sans branchement », which computes both branches and keeps one per lane. Layer 3 being pure and total, computing an unchosen branch is not observable, except in cost.

**Facts.**

- BQN's Choose « applies one function from a list 𝕘, based on the selecting index returned by a function 𝔽 » (BQN, Choose (https://mlochbaum.github.io/BQN/doc/choose.html)).

- **A — Two words.** `choose` for one condition, one branch evaluated; the dyadic `select` (⊏, selection by indices) with a mask over a pair for vectors, both branches computed. *For:* each says its cost; chapter 1 and the theorem keep `select`. *Against:* two ways to branch.
- **B — `choose` lowers to a mask when its condition is a vector.** *For:* one word; purity makes both lowerings equal in value. *Against:* the cost of a `choose` depends on its condition's type.
- **C — `choose` only; masks written with arithmetic.** *For:* one form. *Against:* chapter 1's synopsis and the theorem are rewritten.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-021), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Je pense que select suffit mais nous le vérifierons plus tard.
- **Reading:** two words: `choose`, for one condition, evaluates only the designated branch; the dyadic `select`, selection by indices, applied with a mask over a pair, computes both branches lane by lane, as chapter 1's synopsis and `thm:homomorphisme_roues` say (option A). The justification expects `select` may suffice; that is to be checked later, and is recorded so. Applied: chapter 5.


### Actors, put back

#### Q-ACT-008 — Gap: where the actor cluster is defined

**Object.** Your answer to Q-ACT-006 (VOC-2026-10-29-006): shared steps live « dans l'espace mémoire du cluster d'acteur tel que défini dans le chapitre sur l'exécution parallèle et concourante ». The specification names clusters once (chapter 1: « le macro-modèle des acteurs et des clusters ») and defines none. Chapter 4 says: « Dans un profil où plusieurs fibrilles partagent la mémoire d'une même instance d'exécution, le modèle acquisition-libération gouverne cette mémoire partagée ». The archive of early K premises declared clusters with `defcluster`.

- **A — The cluster is chapter 4's execution instance.** The actors whose fibrils share one instance's memory; shared steps are definitions placed in that memory. *For:* uses what chapter 4 states. *Against:* an execution instance is a realisation choice, not a source construct.
- **B — The cluster is a module (Q-SPEC-601).** Shared steps are its definitions, visible to its actors. *For:* no new notion. *Against:* a module is a unit of compilation, not of memory.
- **C — A declared cluster.** Example: `{defcluster billing :actors (invoice payment) :steps (below-bound notify)}`. *For:* explicit, in the source; the archive's form. *Against:* a new declaration and its rules to write in chapter 4.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-022), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** C'est la seule façon de spécifier le partage sécurisé et sûre d'un espace mémoire à des acteurs différents. Et c'est précisément l'objectif de notre spécification.
- **Reading:** the actor cluster is chapter 4's execution instance: the actors whose fibrils share one instance's memory, under the acquire-release model; shared steps are definitions placed in that memory (option A). The justification gives the reason: it is the only way to specify the safe sharing of one memory space between different actors, which is what the specification aims at. Applied: chapter 4.


#### Q-ACT-009 — What `defer` defers

**Object.** Your answer to Q-ACT-005 (VOC-2026-10-29-012): no timer delivery, « je préfère un 'defer' dans un statement :on ».

**Facts.**

- Erlang: « send_after(Time, Dest, Msg, Options) Starts a timer. When the timer expires, the message Msg is sent to the process identified by Dest » (Erlang, erlang module (https://www.erlang.org/doc/apps/erts/erlang.html)).
- Go: « A "defer" statement invokes a function whose execution is deferred to the moment the surrounding function returns » (Go specification (https://go.dev/ref/spec#Defer_statements)).
- Akka: side effects « should be performed in thenRun from the command handler after persisting the event » (Akka, persistence (https://doc.akka.io/libraries/akka-core/current/typed/persistence.html)).

- **A — A delivery at a later time.** Example: `:on (Tick :defer 5s (send self Tick))`. *For:* Erlang's `send_after`. *Against:* in Go, `defer` means « when the surrounding function returns », not « later ».
- **B — A delivery after the reaction is persisted.** The delivery runs once the decision's events are in the journal, as Akka's `thenRun`. *For:* the meaning `defer` has in Go; deliveries never precede what replay needs. *Against:* timers need another form.
- **C — Both, by what follows the word.** *For:* one word. *Against:* two meanings to learn.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-023), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** Ce qui suis `:deffer` devra être typé en unité de temps ou unité de compte (epoch, tick, etc.)
- **Reading:** `defer` has both meanings, told apart by what follows it, and what follows `:defer` is typed in a unit of time or a unit of count, an epoch or a tick for instance (option C, with the justification). Read: a duration defers a delivery to a later time, as Erlang's `send_after`; a count defers it by logical steps. Which count expresses option B's meaning, a delivery once the reaction is persisted, is put back. Applied: chapter 5.


#### Q-ACT-010 — What `persist` writes beside the journal

**Object.** The journal holds messages and capability values, and an actor may add its events (VOC-2026-10-29-007). Chapter 4: « Une réalisation peut sérialiser l'état inactif dans un instantané journalisé, restituer sa mémoire puis rejouer les messages consignés lors de la réactivation », snapshot and journal being « des choix de réalisation ».

- **A — The events the actor declares.** *For:* event sourcing where it is declared (Q-ACT-003). *Against:* replay needs every event since the start.
- **B — A snapshot of the state.** *For:* short replay; chapter 4's lifecycle. *Against:* the history between snapshots is in messages only.
- **C — Both, the snapshot bounding the replay of events.** *For:* audit and short replay. *Against:* two things to keep consistent.

**Answer of the author — 2026-10-29 (VOC-2026-10-29-024), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** Déjà répondu, par défaut l'option B qui permet de redémarrer au dernier état connu (Erlang et compagnie) et si le développeur le choisi explicitement il peut ajouter le message, l'évènement, etc.
- **Reading:** by default `persist` writes a snapshot of the state (option B), so that an actor restarts at its last known state, as in Erlang; the developer may explicitly add the messages, the events and so on. The author recalls that this was already answered: it agrees with VOC-2026-10-29-007, where the journal holds the messages and the capability values and an actor may add its events. Applied: chapter 5.


## Lemma lot 1 of 2026-11-02: the kernel of call-by-push-value and the connectives

Opened on 2026-11-02, once the reading lots were answered: the first lot that chooses words. One
question per construct, grouped by family, starting from the register of
[primitives](primitives.md) and the old catalogue below (Q-TERM, Q-TOKEN), revised against the
current specification. Each question gives a fiche of the construct (symbol, family, rule, layer,
its current form in the specification and the lexicon, the register's candidates, the recorded
preferences, the overlaps), the specification's text, what the literature and other languages do,
and options weighed on the six criteria of Q-METH-001 (option A) in their order, with their pros
and cons. **Other** and **Clarify** are always available.

One question per construct of the kernel. Each option is weighed on the six criteria in the order of Q-METH-001 (option A): non-collision, scientific exactness, family and grade invariants, the provisional ecological grid, mnemonic, brevity last. An answer is a dated preference, ratified only in the global lot (VOC-2026-10-26-002). The word you choose is the K7PL word: it is modelled in K as `lexicon/lexemes/<word>.k`, exported to Lean and TLA+, and the specification displays the `.k` without rewriting it. The candidates of the register (`wiki/primitives.md`) and my proposals are material, never defaults; French prose terms are not chosen here, and glyphs come after the lemmas. Already recorded and not asked again: `variable` for `Var`, and the preference `lambda` for `Lam` (VOC-2026-10-26-002). Questions titled « Gap » point at places where the specification is imprecise or contradicts itself. Every word of the examples other than the one asked is a placeholder.

Constructs of the grammar that have no register entry yet, for the following lots: `iter_V`,
`fix`, and `catch` beside `try`; the words of chapter 5's listings (`perform`, `handle`,
`handler`, `defhandler`, `defactor`, `field`, `view`, `set`, `HandlerResult`) wait for the lots
of effects and definitions.

### Method

#### Q-LEM-001 — One construct, one word, from the formula to the program?

**Object.** You asked to select the words of K7PL « à modéliser en K et à utiliser partout ailleurs ». Chapter 3 already names each construct in its grammar `eq:grammaire-termes` (TermGrammar (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TermGrammar.lean)) — `thunk`, `force`, `return`, `let x ← c in c`, `case v of`, `inj_i`, `⟨c_i⟩`, `c.i` — and states a rule: « Les constructeurs du noyau nomment ce qu'une chose _est_ ; les mots de surface nomment ce qu'un programme en _fait_ […] Ce ne sont donc pas deux jeux de noms pour les mêmes objets, et aucune table de correspondance n'est due au lecteur ». This question fixes where a word chosen in this lot is written, before the questions that follow.

**Facts.**

- Chapter 3's example of its rule: « `operation` et `scoped` sont deux espèces d'opération d'effet […] ; `perform` et `handle` sont deux actions, invoquer et traiter ; `handler` n'est ni l'un ni l'autre, c'est le nom d'une _valeur_ » (TermGrammar (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TermGrammar.lean)).
- Today the K lexicon has four lemmas, « les littéraux entiers et booléens, `+`, `<` et `select` » (CodeArtifacts (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/CodeArtifacts.lean)); `src/` has no term syntax of call-by-push-value yet; chapter 5's listings write `match`, `view`, `set`, `choose` and `(Ok v)`.
- Levy writes the same constructs as keywords of the calculus: `thunk M`, `force V`, `return V`, `M to x. N`, `pm V as …` (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Recorded preferences: `lambda` for `Lam` (VOC-2026-10-26-002); `bind` for Haskell's `>>=`, monadic constructions being branchings `:bind` and `:return` (VOC-2026-10-27-030, VOC-2026-10-27-061).

- **A — One word everywhere.** The chosen word is the surface word, the name of `lexicon/lexemes/<word>.k`, of the Lean constructor, of the TLA+ operator, and the name in chapter 3's formulas; where the formula has another name today, the formula takes the word. Two words remain only for two objects, as chapter 3's rule says (`operation` and `perform`).

  1. *Non-collision:* one name per object, so nothing collides between artefacts.
  2. *Scientific exactness:* exact as long as the word names the object; chapter 3's rule decides when there are two objects.
  3. *Family and grade invariants:* a family keeps one form in every artefact.
  4. *Ecological grid (provisional):* neutral.
  5. *Mnemonic:* one word to learn per construct.
  6. *Brevity:* neutral.

  *For:* your « partout ailleurs »; chapter 3's rule as written; no table. *Against:* chapter 3's grammar is normative: where a word differs from Levy's notation, the formulas, rules and theorems that write it change, by an explicit decision.

- **B — One word in code, the literature's notation in the formulas.** The surface, K, Lean and TLA+ use the chosen word; chapter 3's formulas keep Levy's notation as mathematics, and chapter 3 states once which construct each symbol is.

  1. *Non-collision:* none inside the code; the formulas may show another name.
  2. *Scientific exactness:* the formulas stay readable against the literature.
  3. *Family and grade invariants:* code families are uniform; formulas follow the literature.
  4. *Ecological grid (provisional):* neutral.
  5. *Mnemonic:* two names to know where they differ.
  6. *Brevity:* neutral.

  *For:* no theorem is rewritten. *Against:* where the formula's name and the word differ, a table is due, which chapter 3 refuses.

- **C — Two vocabularies.** The kernel (formulas and Lean) keeps the literature's names; the surface (K and listings) gets its own words; a table maps them.

  1. *Non-collision:* a word may name one object in Lean and another in the surface.
  2. *Scientific exactness:* each side exact in its own field.
  3. *Family and grade invariants:* two families of names for one construct.
  4. *Ecological grid (provisional):* each audience reads its own names.
  5. *Mnemonic:* two names to learn.
  6. *Brevity:* neutral.

  *For:* each audience reads its own names. *Against:* contradicts « pas deux jeux de noms pour les mêmes objets »; the export from K to Lean would translate names.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** one word per construct, everywhere (option A): the chosen word is the surface word, the name of `lexicon/lexemes/<word>.k`, of the Lean constructor and of the TLA+ operator, and the name in chapter 3's formulas; where a formula writes another name today, the formula takes the word. Two words remain only for two objects, as chapter 3's rule says (`operation` and `perform`).

### Kernel of call-by-push-value

#### Q-LEM-002 — Application, `c v`

**Fiche.**

- **Symbol:** `M V`, chapter 3 `c v`
- **Family:** noyau_CBPV
- **Rule:** App
- **Layer:** every layer: in layer 2 the parenthesis `(f x y)`; in layer 3 a bracket whose head receives all its arguments
- **Now in the specification:** no word; the form itself
- **Register:** none retained; candidates `application`, `apply`, `juxtaposition`
- **Overlaps:** Lisp's `apply` applies a function to a list of arguments, another object

**Object.** Chapter 5: « Un crochet n'est une application que lorsque sa tête y reçoit tous ses arguments (`[add 1 2]`) » (UniversalSExpressions (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)). Application is written by the form itself; what is asked is the name of the construct where it must be named: its K file, the Lean constructor, the diagnostics and the English prose.

**Facts.**

- Levy: « We write ‘ for application in reverse order » — `V ‘M` (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Pretnar's effect calculus writes application `v1 v2` and names it « application » (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).
- Racket's `apply`: « Applies proc using the content of (list* v ... lst) as the (by-position) arguments » (Racket, procedures (https://docs.racket-lang.org/reference/procedures.html)).
- The register: « En forme Lisp l'application n'a pas de nom : elle est la forme elle-même. Le mot ne s'écrit donc jamais, sauf en diagnostic » (primitives (https://github.com/AntheaLiles/k7pl/blob/main/wiki/primitives.md)).

- **A — No written word; the construct is named `application`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the literature's term for this very construct.
  3. *Family and grade invariants:* a noun naming what the thing is, as chapter 3's rule asks of constructors.
  4. *Ecological grid (provisional):* universal.
  5. *Mnemonic:* transparent.
  6. *Brevity:* long, but never written in a program.

  *For:* names the object, not an action; leaves `apply` free. *Against:* the K file and the Lean constructor carry an eleven-letter name.

- **B — No written word; named `apply`, also the word that spreads a list of arguments.**

  1. *Non-collision:* collision: one word for static application and for application to a list of arguments.
  2. *Scientific exactness:* exact for the second object, approximate for the first.
  3. *Family and grade invariants:* a verb.
  4. *Ecological grid (provisional):* Lisp family, Racket.
  5. *Mnemonic:* known.
  6. *Brevity:* short.

  *For:* one short word. *Against:* two objects under one word.

- **C — No written word; named `apply`; spreading a list takes another word.**

  1. *Non-collision:* no collision once spreading is named otherwise.
  2. *Scientific exactness:* a verb for the construct.
  3. *Family and grade invariants:* a verb, as `force` and `return`.
  4. *Ecological grid (provisional):* Lisp family, where it names spreading: readers expect that sense.
  5. *Mnemonic:* known.
  6. *Brevity:* short.

  *For:* short, and a verb like its neighbours. *Against:* Lisp readers expect `apply` to spread a list.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-002), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** If we expect to spread something, hence we shall use `spread` 🤷
- **Reading:** application has no written word; the construct is named `apply` in K, Lean, TLA+ and the diagnostics (option C). Applying a function to a list of arguments, Lisp's `apply`, takes another word, `spread`, as the justification proposes.

#### Q-LEM-003 — Suspending a computation as a value, `thunk c`

**Fiche.**

- **Symbol:** `{M}`, chapter 3 `thunk c`
- **Family:** noyau_CBPV
- **Rule:** Th
- **Layer:** kernel; a value of type `U C`
- **Now in the specification:** `thunk` in chapter 3; no listing writes it
- **Register:** retained `thunk`; candidates `thunk`, `suspend`, `delay`, `suspension`
- **Recorded:** suspension stays a function, not a branching (VOC-2026-10-27-061)
- **Overlaps:** `delay c` is a kernel construct of its own, the introduction of `○C`; Racket's `delay` makes a memoised promise

**Object.** Chapter 3 ranks constructs by one rule — « une valeur est ce qui s'introduit, un calcul est ce qui s'élimine ou s'exécute » — and keeps a separate temporal construct: « `delay c` reste un calcul, d'introduction du type ○C » (TermGrammar (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TermGrammar.lean)). `thunk c` turns a computation into a value; `force` runs it again each time.

**Facts.**

- Levy: « CBPV retains the distinction between a computation and its thunk »; for call-by-value « write thunk M and force N for λ( ).M and N ( ) respectively » (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Levy's page: « The main difference is that CBPV distinguishes a computation from its thunk, which is a value » (Levy, CBPV (https://pblevy.github.io/cbpv.html)).
- Racket: « The thunk form creates a nullary function that evaluates the given body » (Racket, procedures (https://docs.racket-lang.org/reference/procedures.html)); `delay`: « Creates a promise that, when forced, evaluates the bodys to produce its value. The result is then cached » (Racket, delayed evaluation (https://docs.racket-lang.org/reference/Delayed_Evaluation.html)).

- **A — `thunk`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* Levy's word for exactly this object.
  3. *Family and grade invariants:* pairs with `force`, Levy's pair; a noun naming what the value is.
  4. *Ecological grid (provisional):* the literature of call-by-push-value; Racket (a nullary function).
  5. *Mnemonic:* opaque to a newcomer.
  6. *Brevity:* five letters.

  *For:* the field's word; no reader of Levy hesitates. *Against:* says nothing to who has not met it.

- **B — `suspend`.**

  1. *Non-collision:* no collision found in the specification.
  2. *Scientific exactness:* names the action, not the value it builds.
  3. *Family and grade invariants:* would pair with `resume` (Q-LEM-004); a verb where chapter 3 asks constructors to name what a thing is.
  4. *Ecological grid (provisional):* not the word of the literature of call-by-push-value.
  5. *Mnemonic:* says what happens.
  6. *Brevity:* seven letters.

  *For:* readable without the literature. *Against:* a verb for a value; to be defended against the literature.

- **C — `delay`.**

  1. *Non-collision:* collision: `delay c` is already the introduction of `○C`, another construct.
  2. *Scientific exactness:* inexact twice: a delay is temporal, and Racket's `delay` caches its result where a thunk runs again at each `force`.
  3. *Family and grade invariants:* would join the temporal family, not this one.
  4. *Ecological grid (provisional):* Scheme and Racket, with the cached sense.
  5. *Mnemonic:* known in the Lisp family.
  6. *Brevity:* five letters.

  *For:* Lisp familiarity. *Against:* two kernel constructs under one word.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** `thunk` (option A).

#### Q-LEM-004 — Running a suspended computation, `force v`

**Fiche.**

- **Symbol:** `V!`, chapter 3 `force v`
- **Family:** noyau_CBPV
- **Rule:** Fo
- **Layer:** kernel; a computation
- **Now in the specification:** `force` in chapter 3
- **Register:** retained `force`; candidates `force`, `run`, `resume`
- **Overlaps:** you found `:run (exp)` more expressive than `:bind (exp)` for an actor (VOC-2026-10-27-062); `resume` is what a handler's continuation does

**Object.** The eliminator of the thunk: a value of type `U C` becomes the computation it holds, run anew.

**Facts.**

- Levy writes `force V` and states `force thunk M` evaluates as `M` (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Racket: « If v is a promise, then the promise is forced to obtain a value » (Racket, delayed evaluation (https://docs.racket-lang.org/reference/Delayed_Evaluation.html)).
- Pretnar: when an operation is handled, the rest of the computation, « called a continuation, resumes » (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).

- **A — `force`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* Levy's word for this eliminator.
  3. *Family and grade invariants:* pairs with `thunk`.
  4. *Ecological grid (provisional):* call-by-push-value and Scheme/Racket promises, a double use.
  5. *Mnemonic:* known in both families.
  6. *Brevity:* five letters.

  *For:* the register's « meilleur cas du critère 6 de tout l'inventaire ». *Against:* none found.

- **B — `run`.**

  1. *Non-collision:* risk: the word you proposed for an actor's step (`:run`, VOC-2026-10-27-062) and the running of a program.
  2. *Scientific exactness:* too general: every computation runs.
  3. *Family and grade invariants:* no pair with `thunk`.
  4. *Ecological grid (provisional):* common outside the field.
  5. *Mnemonic:* readable at once.
  6. *Brevity:* three letters.

  *For:* readable without culture. *Against:* confused with running a program and with `:run`.

- **C — `resume`.**

  1. *Non-collision:* risk: the word of continuations in handlers (Pretnar), another object.
  2. *Scientific exactness:* inexact: a thunk is not stopped and resumed, it is run anew.
  3. *Family and grade invariants:* would pair with `suspend` (Q-LEM-003 B).
  4. *Ecological grid (provisional):* coroutines and effects.
  5. *Mnemonic:* says what happens.
  6. *Brevity:* six letters.

  *For:* pairs with `suspend`. *Against:* names what a continuation does, not what `force` does.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-004), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** `force` (option A).

#### Q-LEM-005 — Returning a value as a computation, `return v`

**Fiche.**

- **Symbol:** `return V`
- **Family:** noyau_CBPV
- **Rule:** Ret
- **Layer:** kernel; a computation of type `F V`
- **Now in the specification:** `return` in chapter 3; the branching `:return` (VOC-2026-10-27-030, VOC-2026-10-27-061)
- **Register:** retained `return`; candidates `return`, `produce`, `pure`, `unit`
- **Overlaps:** `pure` is a reserved head keyword; `unit` names the unit type and value (Q-LEM-007); in most languages `return` leaves a function

**Object.** Chapter 3: `at v`, `wait v` and `declassify` « sont des calculs, de type F_1 V, et le rendu de leur résultat passe par `return` » (TermGrammar (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TermGrammar.lean)). You asked that the words of monads be compared with the words of algebraic effects (VOC-2026-10-28-017): the facts below give both.

**Facts.**

- Levy lists the syntax changed since 1999: `produce V` became `return V` (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf), §1.4).
- Haskell's `Monad` class: `return :: a -> m a` (Haskell 2010, ch. 9 (https://www.haskell.org/onlinereport/haskell2010/haskellch9.html)).
- Algebraic effects: Pretnar's calculus writes `return v` (« return ») and gives a handler an « (optional) return clause » `handler {return x ↦ c_r, …}` (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).
- Python: « return leaves the current function call with the expression list (or None) as return value » (Python reference, 7.6 (https://docs.python.org/3/reference/simple_stmts.html)).
- Chapter 5: five head keywords, `pure` among them, « ne sont réservés qu'en position de tête d'une S-expression » (UniversalSExpressions (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)).

- **A — `return`.**

  1. *Non-collision:* no collision in K7PL; the handler's return clause of effects is the same notion, not a collision.
  2. *Scientific exactness:* exact in call-by-push-value, in monads and in algebraic effects.
  3. *Family and grade invariants:* already the branching `:return`.
  4. *Ecological grid (provisional):* universal in the literature; imperative languages give it the opposite sense (leave a function).
  5. *Mnemonic:* known.
  6. *Brevity:* six letters.

  *For:* monads and effects agree on it; Levy moved to it. *Against:* a newcomer from Python or C may read « leave the function ».

- **B — `produce`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* exact: the computation produces a value; Levy's first word.
  3. *Family and grade invariants:* the branching would become `:produce`.
  4. *Ecological grid (provisional):* rare; Levy himself abandoned it.
  5. *Mnemonic:* says what happens, without the imperative misreading.
  6. *Brevity:* seven letters.

  *For:* removes the misreading. *Against:* the literature moved away from it.

- **C — `pure`.**

  1. *Non-collision:* collision: `pure` is a reserved head keyword that demands an empty effect.
  2. *Scientific exactness:* Haskell's applicative word for the same role (register).
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* functional family.
  5. *Mnemonic:* known to Haskell readers.
  6. *Brevity:* four letters.

  *For:* short. *Against:* `(pure x)` would read as the purity keyword.

- **D — `unit`.**

  1. *Non-collision:* collision: the unit type and its value (Q-LEM-007).
  2. *Scientific exactness:* the categorical name of a monad's unit (register).
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* category theory.
  5. *Mnemonic:* ambiguous.
  6. *Brevity:* four letters.

  *For:* categorical precision. *Against:* names the unit type in every ML.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-005), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** `return` (option A), as the construct, the formula and the branching `:return` already write it.

#### Q-LEM-006 — Sequencing two computations, `let x ← c in c`

**Fiche.**

- **Symbol:** `x ← M in N`, chapter 3 `let x ← c in c`
- **Family:** noyau_CBPV
- **Rule:** Let
- **Layer:** kernel; the binding of layer 2
- **Now in the specification:** chapter 3 `let x ← c in c`; chapter 5's `let`; the branching `:bind`
- **Register:** none retained; candidates `bind`, `let`, `do`, `sequence`
- **Recorded:** `bind` for Haskell's `>>=`, with `:bind` and `:return` (VOC-2026-10-27-030)
- **Overlaps:** chapter 3 also heads `let () = v in c` and `let (x,y) = v in c` with `let`; glyph aliases `bind-left`, `bind-right`; the kernel's `send m(v) to v` uses `to`; Clojure's `do` sequences without binding

**Object.** One construct, written two ways today. Chapter 5: « Le `let` n'introduit que des liaisons scopées, immuables et séquentielles — un `let*` implicite » (UniversalSExpressions (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)); the branchings `:bind` and `:return` declare the monadic construction of a definition. K7PL's grammar has no plain binding of a value: a value is bound by `let x ← return v in c`.

**Facts.**

- Levy: « We use the keyword to corresponding to the Haskell idiom >>= λ […] We reserve let for plain binding » (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Pretnar: `do x ← c1 in c2`, « sequencing »; « If x does not appear in c2, we abbreviate the sequencing to c1 ; c2 » (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).
- Clojure's `let`: « The bindings are sequential, so each binding can see the prior bindings » (Clojure, special forms (https://clojure.org/reference/special_forms)).
- Your answer to Q-SPEC-101: « les constructions monadiques sont des "branchements" explicites déclarés avec le préfixe ":" donc ":bind something" et ":return somethingelse" » (VOC-2026-10-27-030).

- **A — `let`.** The construct, its formula and chapter 5 share `let`; the patterns `()` and `(x y)` make the two other `let` of chapter 3 forms of it (Q-LEM-008, Q-LEM-010). `:bind` stays only if it names another object — the operation a definition supplies to its monad, as chapter 3 separates `operation` and `perform`; otherwise it becomes `:let`. Example: `(let [x (read-sensor)] (return [mul x 2]))`.

  1. *Non-collision:* no collision once the three `let` of chapter 3 are one form with patterns.
  2. *Scientific exactness:* Levy's warning: it hides that the first computation must produce a value.
  3. *Family and grade invariants:* one word for binding, by value or by pattern.
  4. *Ecological grid (provisional):* ML, Lisp, Clojure.
  5. *Mnemonic:* read at once.
  6. *Brevity:* three letters.

  *For:* chapter 3 and chapter 5 already agree. *Against:* the recorded `bind` names the branching only if it is another object.

- **B — `bind`.** The recorded preference: the construct, the formula and the branching `:bind` share it; chapter 5's `let` becomes `bind`. Example: `(bind [x (read-sensor)] (return [mul x 2]))`.

  1. *Non-collision:* crowded: the glyph aliases `bind-left` and `bind-right` of chapter 1.
  2. *Scientific exactness:* exact: the monad's name for `>>=`.
  3. *Family and grade invariants:* the branching and the term share one word.
  4. *Ecological grid (provisional):* monads; not the binding word of Lisp or ML.
  5. *Mnemonic:* known to Haskell readers.
  6. *Brevity:* four letters.

  *For:* your recorded preference; one word for the term and the branching. *Against:* chapter 5 changes; `bind-left` and `bind-right` stay near.

- **C — `do`.**

  1. *Non-collision:* risk: Clojure's `do` sequences without binding, a familiar other object.
  2. *Scientific exactness:* exact in Pretnar's calculus of effects.
  3. *Family and grade invariants:* would compete with Q-LEM-008 B.
  4. *Ecological grid (provisional):* algebraic effects; Haskell's do-notation.
  5. *Mnemonic:* short and known.
  6. *Brevity:* two letters.

  *For:* the word of algebraic effects, which you asked to compare. *Against:* Lisp readers expect a block without binding.

- **D — `to`.**

  1. *Non-collision:* collision: the kernel's `send m(v) to v`.
  2. *Scientific exactness:* Levy's exact word.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Levy only.
  5. *Mnemonic:* infix in Levy; nothing in a prefix S-expression.
  6. *Brevity:* two letters.

  *For:* Levy's keyword. *Against:* made for an infix writing.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-006), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** Pas de bind-left ou bind-right, un seul bind qui branche l'expression à sa droite (defun lambda :bind exp)
- **Reading:** `bind` (option B): the construct, its formula and the branching `:bind` share it, and chapter 5's `let` becomes `bind`. The glyph aliases `bind-left` and `bind-right` are withdrawn: there is one `bind`, which branches the expression on its right, as in `(defun lambda :bind exp)` (the other words of the example are placeholders).
- **Put back to the author:** what replaces, in chapter 1's glyph table, the glyphs `↢` and `↣` that the two aliases named, and the paragraph that justifies their pair.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-018), given in the conversation, quoted as given.**

> Les glyphe on les traite quand tous les lemmes sont fixés

- **Reading:** the glyphs, `↢` and `↣` among them, are dealt with once every lemma is fixed.


### Connectives

#### Q-LEM-007 — Gap — the unit value, `()`

**Fiche.**

- **Symbol:** `()`
- **Family:** connecteurs
- **Rule:** One
- **Layer:** a value of type `1`
- **Now in the specification:** chapter 3 writes `()`; chapter 5 makes `()` the empty list
- **Register:** none retained; candidates `unit`, `nil`, `void`
- **Overlaps:** in ML and Haskell the type and the value share a name; `()` is the empty list in chapter 5

**Object.** Gap: two objects, one writing. Chapter 3's grammar writes the unit value `()`; chapter 5: « `[]` est le vecteur vide, `()` la liste vide et `{}` l'enregistrement ou la table vide » (UniversalSExpressions (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)). A type appears only after a property that announces it (VOC-2026-10-27-027), so a value and a type may share a word.

**Facts.**

- Linear logic: « the multiplicative ⊗ (tensor) and 1 (one) » (SEP, linear logic (https://plato.stanford.edu/entries/logic-linear/)).
- Haskell: « The unit expression () has type () » (Haskell 2010, ch. 3 (https://www.haskell.org/onlinereport/haskell2010/haskellch3.html)); OCaml: « evaluates to the unit value () » (OCaml manual (https://ocaml.org/manual/5.2/expr.html)).
- Common Lisp, `nil`: « the object that is at once the symbol named "NIL" in the COMMON-LISP package, the empty list, » and « the boolean (or generalized boolean) representing false, and the name of the empty type » (CLHS glossary (https://www.lispworks.com/documentation/HyperSpec/Body/26_glo_n.htm)).

- **A — `unit`, a word for the value.** `()` stays the empty list; the type is also `unit`, after `:type`.

  1. *Non-collision:* no collision; value and type are told apart by the type position.
  2. *Scientific exactness:* the type's exact name.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* ML's name of the type.
  5. *Mnemonic:* known.
  6. *Brevity:* four letters.

  *For:* removes the gap without touching chapter 5. *Against:* a word where ML writes two characters.

- **B — `()`, as in chapter 3.** Chapter 5's empty list takes another writing.

  1. *Non-collision:* collision with the empty list until chapter 5 changes.
  2. *Scientific exactness:* ML and Haskell.
  3. *Family and grade invariants:* breaks chapter 5's rule that an empty pair is the empty structure of its layer.
  4. *Ecological grid (provisional):* universal in ML and Haskell.
  5. *Mnemonic:* known.
  6. *Brevity:* two characters.

  *For:* the kernel's writing and the ML habit. *Against:* reopens an answered rule of chapter 5.

- **C — `{}`, the empty record.** The unit is the product of no fields.

  1. *Non-collision:* `{}` is also the empty table in chapter 5.
  2. *Scientific exactness:* exact: 1 is the empty product.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* none.
  5. *Mnemonic:* needs explaining.
  6. *Brevity:* two characters.

  *For:* exact. *Against:* the table keeps `{}` too.

- **D — `nil`.**

  1. *Non-collision:* three jobs in Lisp: empty list, false, empty type.
  2. *Scientific exactness:* inexact: not the empty list here.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Lisp.
  5. *Mnemonic:* known, with the wrong sense.
  6. *Brevity:* three letters.

  *For:* Lisp familiarity. *Against:* the register's arbitration 23 forbids one word for three jobs.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-007), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** `unit` (option A): a word for the value, also the name of the type after `:type`; `()` stays the empty list of chapter 5, which closes the gap.

#### Q-LEM-008 — Consuming the unit, `let () = v in c`, and sequencing that discards

**Fiche.**

- **Symbol:** `let () = V in N`
- **Family:** connecteurs
- **Rule:** OneE
- **Layer:** a computation
- **Now in the specification:** chapter 3 only
- **Register:** no candidate: « cette élimination n'a pas de nom dans la littérature, étant toujours écrite comme un motif »
- **Overlaps:** `let` shared with Let and Split; Clojure's `do`

**Object.** The construct consumes the unit. In a program it appears when a computation is run for its effect and another follows: `c1 ; c2` is `let x ← c1 in let () = x in c2`. The Lisp blocks below discard a value of any type; this construct only accepts the unit, so discarding anything else would be a type error.

**Facts.**

- Pretnar abbreviates sequencing without use to `c1 ; c2` (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).
- Clojure's `do`: « Evaluates the expressions exprs in order and returns the value of the last » (Clojure, special forms (https://clojure.org/reference/special_forms)).
- Common Lisp: « progn evaluates forms, in the order in which they are given » (CLHS, progn (https://www.lispworks.com/documentation/HyperSpec/Body/s_progn.htm)).
- Racket's `begin`: « the exprs are evaluated in order, and the results are ignored for all but the last expr » (Racket, begin (https://docs.racket-lang.org/reference/begin.html)).

- **A — No word: the unit pattern of the binding form.** A run of effects is several bindings with the unit pattern (Q-LEM-006, Q-LEM-007).

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* as the literature writes it, a pattern.
  3. *Family and grade invariants:* one binding form with patterns.
  4. *Ecological grid (provisional):* ML.
  5. *Mnemonic:* nothing to learn.
  6. *Brevity:* verbose for a run of effects.

  *For:* no new word. *Against:* a list of effects repeats the binding form.

- **B — `do`: a block of computations, each but the last returning the unit.**

  1. *Non-collision:* collides with Q-LEM-006 C if `do` is taken there.
  2. *Scientific exactness:* stricter than Clojure: a non-unit value is refused.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Clojure, Haskell.
  5. *Mnemonic:* known.
  6. *Brevity:* two letters.

  *For:* the common case, short. *Against:* Clojure readers expect any value to be discarded.

- **C — `begin`, as Scheme and Racket.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* same strictness as B.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Scheme and Racket.
  5. *Mnemonic:* known in the Lisp family.
  6. *Brevity:* five letters.

  *For:* frees `do`. *Against:* longer.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-008), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

#### Q-LEM-009 — Joining two disjoint resources, `(v, v)`

**Fiche.**

- **Symbol:** `(V₁, V₂)`
- **Family:** connecteurs
- **Rule:** Pair
- **Layer:** a value of type `A ⊗ B`
- **Now in the specification:** chapter 3 `(v, v)`; no surface writing; `()` is the list and `[1 2]` a vector in chapter 5
- **Register:** none retained; candidates `pair`, `tensor`, `tuple`, `cons`
- **Overlaps:** `tensor` names multi-dimensional arrays in machine learning; `cons` builds a list cell in Lisp

**Object.** The pair says that its two parts are separate resources: « deux capacités _séparées_ — c'est ce que le tenseur sert à dire » (GradedSystem (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/GradedSystem.lean)). The register notes that `pair` « ne dit pas la disjonction des ressources ».

**Facts.**

- Linear logic: « the multiplicative ⊗ (tensor) and 1 (one) » (SEP, linear logic (https://plato.stanford.edu/entries/logic-linear/)).
- OCaml: « evaluates to the n-tuple of the values of expressions »; Haskell: « Tuples are written (e1, …, ek), and may be of arbitrary length k ≥ 2 » (OCaml manual (https://ocaml.org/manual/5.2/expr.html); Haskell 2010, ch. 3 (https://www.haskell.org/onlinereport/haskell2010/haskellch3.html)).
- Common Lisp: « Creates a fresh cons, the car of which is object-1 and the cdr of which is object-2 » (CLHS, cons (https://www.lispworks.com/documentation/HyperSpec/Body/f_cons.htm)).
- TensorFlow: « Tensors are multi-dimensional arrays with a uniform type » (TensorFlow (https://www.tensorflow.org/guide/tensor)).

- **A — `pair`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* exact for two parts; silent on their separation, which the type carries.
  3. *Family and grade invariants:* would pair with `unpair` (Q-LEM-010 D).
  4. *Ecological grid (provisional):* universal.
  5. *Mnemonic:* immediate.
  6. *Brevity:* four letters.

  *For:* immediate. *Against:* does not say « separate ».

- **B — `tuple`, nested pairs.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* n-ary where the kernel is binary; the n-tuple is nested pairs.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* ML, Haskell, Python.
  5. *Mnemonic:* known.
  6. *Brevity:* five letters.

  *For:* one word for any length. *Against:* the kernel construct is binary.

- **C — `tensor`.**

  1. *Non-collision:* ecological collision: arrays in TensorFlow and PyTorch, numerous among layer-3 users.
  2. *Scientific exactness:* exact: it says the separation.
  3. *Family and grade invariants:* the name of the type `⊗`.
  4. *Ecological grid (provisional):* linear logic only.
  5. *Mnemonic:* opaque outside the field.
  6. *Brevity:* six letters.

  *For:* the only candidate that says the separation. *Against:* layer 3 computes on arrays, where « tensor » means something else.

- **D — `cons`.**

  1. *Non-collision:* collision: Lisp's list cell.
  2. *Scientific exactness:* inexact: the second part of a cons is a list.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Lisp.
  5. *Mnemonic:* known with another sense.
  6. *Brevity:* four letters.

  *For:* Lisp familiarity. *Against:* not the same object.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-009), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** Why not "join" and sql's/nosql's lemmas?
- **Reading:** kept open: the author asks to weigh `join` and the words of SQL and NoSQL.

#### Q-LEM-010 — Taking a pair apart, `let (x,y) = v in c`

**Fiche.**

- **Symbol:** `let (x,y) = V in N`
- **Family:** connecteurs
- **Rule:** Split
- **Layer:** a computation
- **Now in the specification:** chapter 3 only
- **Register:** none retained; candidates `split`, `unpair`, `destructure`
- **Overlaps:** the kernel's `slice v as (x,y) in c` cuts an arena in two; libraries `split` sequences; `let` shared with Let and OneE

**Object.** Both components are bound at once: the pair is consumed, each part used under the grade of its resource.

**Facts.**

- Levy writes `pm V as ⟨x, y⟩.M`: « The keyword pm stands for “pattern-match” » (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Common Lisp: « destructuring-bind binds the variables specified in lambda-list to the corresponding values in the tree structure » (CLHS, destructuring-bind (https://www.lispworks.com/documentation/HyperSpec/Body/m_destru.htm)).
- The kernel's `slice κ as (x,y) in c` splits a capability in two (chapter 4, `eq:reductions-orientees`); the register names it « découpe ».

- **A — No word: a pattern of the binding form.** Example: `(let [(x y) (sensor-pair)] …)`.

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* as Levy and ML: a pattern match.
  3. *Family and grade invariants:* one binding form with patterns (Q-LEM-006 A).
  4. *Ecological grid (provisional):* ML, Haskell, Clojure's destructuring.
  5. *Mnemonic:* nothing to learn.
  6. *Brevity:* the shortest.

  *For:* no word. *Against:* depends on Q-LEM-006.

- **B — `split`.**

  1. *Non-collision:* near `slice`, which cuts an arena; library `split` of sequences.
  2. *Scientific exactness:* says what happens.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* common.
  5. *Mnemonic:* clear.
  6. *Brevity:* five letters.

  *For:* direct. *Against:* two meanings in the library.

- **C — `destructure`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* exact.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Common Lisp, JavaScript.
  5. *Mnemonic:* clear.
  6. *Brevity:* eleven letters.

  *For:* exact. *Against:* long for a common case.

- **D — `unpair`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* exact for a pair.
  3. *Family and grade invariants:* symmetric with `pair` (Q-LEM-009 A).
  4. *Ecological grid (provisional):* rare.
  5. *Mnemonic:* readable by symmetry.
  6. *Brevity:* six letters.

  *For:* family symmetry. *Against:* rare.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-010), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** The reverse of Q-LEM-006 is `unbind`
- **Reading:** taking a pair apart is `unbind`, the reverse of `bind` (Q-LEM-006).
- **Put back to the author:** in Lisp, `makunbound` removes a binding, a sense of « unbind » to keep apart from taking a pair apart into two bindings.

#### Q-LEM-011 — Tagging a value for a sum, `inj_i v`

**Fiche.**

- **Symbol:** `inj_i V`
- **Family:** connecteurs
- **Rule:** Inj
- **Layer:** a value of type `Σ A_i`
- **Now in the specification:** chapter 3 `inj_i v`; chapter 5 writes the tag applied, `(Ok new-value)`, `(Err e)`
- **Register:** none retained; candidates `inject`, `tag`, `variant`
- **Overlaps:** chapter 3 calls the index of a sum an « étiquette », and also the labels of structural modes; Annex A writes « Porter un tag explicite »

**Object.** Programs write the tag applied to its value, as `lst:gestionnaire` does (InPractice (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean)). The question is the construct's name — K file, Lean constructor, diagnostics — and whether a word is also written.

**Facts.**

- OCaml: « evaluates to the unary variant value whose constructor is constr » (OCaml manual (https://ocaml.org/manual/5.2/expr.html)).
- Levy writes the injection `⟨î, V⟩`, the tag beside the value (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Chapter 3: « une somme sur un ensemble infini d'étiquettes est un type licite » (TypingRules (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)).

- **A — The tag applied; the construct is named `inject`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the categorical term.
  3. *Family and grade invariants:* a verb, as `force`, `return`.
  4. *Ecological grid (provisional):* category theory, the register.
  5. *Mnemonic:* clear to the literature.
  6. *Brevity:* never written in programs.

  *For:* exact; programs unchanged. *Against:* a technical name in diagnostics.

- **B — The tag applied; the construct is named `tag`.**

  1. *Non-collision:* « étiquette » already names the labels of structural modes in chapter 3.
  2. *Scientific exactness:* suggests a representation, where the constructor is logical.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* common.
  5. *Mnemonic:* says what is stored.
  6. *Brevity:* three letters.

  *For:* short. *Against:* two kinds of label in chapter 3.

- **C — The tag applied; the construct is named `variant`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* names the value built, as chapter 3's rule asks of constructors.
  3. *Family and grade invariants:* a noun.
  4. *Ecological grid (provisional):* OCaml.
  5. *Mnemonic:* known.
  6. *Brevity:* seven letters.

  *For:* names what the thing is. *Against:* OCaml also calls the type a variant.

- **D — A written word, `(inject Ok v)`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* exact.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* no language writes it.
  5. *Mnemonic:* clear.
  6. *Brevity:* verbose for every `Ok`.

  *For:* explicit. *Against:* chapter 5's listings change for nothing they lack.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-011), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** If tag and label are two, then whe shall use tag and label
- **Reading:** the tag is applied to its value, as `(Ok v)`, and the construct is named `tag` (option B). Since chapter 3's « étiquette » names two things, the index of a sum and the labels of structural modes, the first is `tag` and the second `label`.

#### Q-LEM-012 — Branching on a tag, `case v of {i ↦ c}`

**Fiche.**

- **Symbol:** `case V of {i ↦ N_i}`
- **Family:** connecteurs
- **Rule:** Case
- **Layer:** a computation
- **Now in the specification:** chapter 3 `case v of`; chapter 5 `(match message ((Increment n) …))`; chapter 4's R-expressions under `(match ...)`; Annex A advises `match`
- **Register:** none retained; candidates `case`, `match`, `switch`; it warns of « collision entre le filtrage de sommes et le filtrage de textes »
- **Overlaps:** `match` is already chapter 4's single interface of R-expressions

**Object.** Chapter 4: « Les R-expressions unifient sous une seule interface, `(match ...)`, le filtrage structurel, PCRE, PEG et les grammaires » (LocalScale (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/LocalScale.lean)). The kernel's `case` eliminates one level of a sum; a `match` with nested patterns compiles to nested `case`.

**Facts.**

- Haskell: « A case expression has the general form case e of { p1 match1 ; … ; pn matchn } » (Haskell 2010, ch. 3 (https://www.haskell.org/onlinereport/haskell2010/haskellch3.html)).
- OCaml: « matches the value of expr against the patterns » (OCaml manual (https://ocaml.org/manual/5.2/expr.html)); Rust: « A match expression branches on a pattern » (Rust reference (https://doc.rust-lang.org/reference/expressions/match-expr.html)).
- Racket's `case`: « Evaluates val-expr and uses the result to select a case-clause », by equality of data, not by tag (Racket, case (https://docs.racket-lang.org/reference/case.html)).
- Levy's `pm` « stands for “pattern-match” » (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).

- **A — `match` for all: sums, nested patterns, R-expressions.**

  1. *Non-collision:* no collision: chapter 4 unifies them on purpose.
  2. *Scientific exactness:* the kernel's one-level `case` is the simplest `match`.
  3. *Family and grade invariants:* one eliminator word for every filter.
  4. *Ecological grid (provisional):* OCaml, Rust.
  5. *Mnemonic:* known.
  6. *Brevity:* five letters.

  *For:* chapter 4 and chapter 5 already write it. *Against:* the K file and Lean name of the one-level construct are `match` too; the cost of a textual `match` hides behind the same word (its annotation shows it).

- **B — `case` for the kernel construct, `match` for patterns that compile to it.**

  1. *Non-collision:* no collision: two objects, two words.
  2. *Scientific exactness:* exact: one level against nested patterns.
  3. *Family and grade invariants:* matches chapter 3's rule.
  4. *Ecological grid (provisional):* Haskell has both.
  5. *Mnemonic:* two words to learn.
  6. *Brevity:* four letters.

  *For:* each word names one object. *Against:* programs rarely write `case`.

- **C — `case` everywhere, R-expressions included.**

  1. *Non-collision:* Racket's `case` dispatches on equality of data.
  2. *Scientific exactness:* exact for sums.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* ML, Haskell, Scheme.
  5. *Mnemonic:* known.
  6. *Brevity:* four letters.

  *For:* the kernel's word. *Against:* chapter 4, chapter 5 and Annex A change.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-012), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** `case` everywhere, R-expressions included (option C): chapter 4's single interface, chapter 5's listings and Annex A write `case` where they write `match` today.

#### Q-LEM-013 — Offering several observations of one computation, `⟨c_i⟩`

**Fiche.**

- **Symbol:** `⟨M_i⟩`
- **Family:** connecteurs
- **Rule:** With
- **Layer:** a computation of type `Π B_i`, the negative product
- **Now in the specification:** chapter 3 `⟨c_i⟩`; no surface writing
- **Register:** none retained; candidates `with`, `record`, `object`, `handler`; prose also weighs `copattern`
- **Overlaps:** `with v handle c` in effects; `handler` names a value in chapter 3; `record` is chapter 5's `{}`, a value; the copatterns `⟨⟨j ↦ c_j⟩⟩` are another rule (Cop)

**Object.** A computation that waits to be asked which of its components to run: only the asked one runs. The register links it to the actor, « la famille de ses réponses aux messages ». About composed definitions you wrote: « Toujours pas de l'objet mais très proche sans mutation » (VOC-2026-10-27-027).

**Facts.**

- Linear logic: « split into the additive & (with) » (SEP, linear logic (https://plato.stanford.edu/entries/logic-linear/)).
- Levy writes it `λ{i.M_i}`: « Because we think of Π as the type of functions taking each i ∈ I to a computation of type B_i, we have made its syntax similar to that of → » (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Agda's copatterns: « we can define the fields of a record as separate declarations » (Agda, copatterns (https://agda.readthedocs.io/en/latest/language/copatterns.html)).
- Pretnar writes handling `with v handle c` (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).

**The λ overlap.** The symbol λ names two objects in the specification: the abstraction `λx.c` (rule `Lam`) and, in chapter 3, a natural transformation of the graded distributive law. A candidate must only ever name the first.

- **A — `with`.**

  1. *Non-collision:* risk: `with v handle c` in effects, and a very common English word.
  2. *Scientific exactness:* linear logic's name of `&`.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* linear logic only.
  5. *Mnemonic:* opaque.
  6. *Brevity:* four letters.

  *For:* the logic's word. *Against:* read as an effect handler by effect readers.

- **B — `record`.**

  1. *Non-collision:* collision: chapter 5's `{}` record, a value.
  2. *Scientific exactness:* inexact: a record is a positive product of values; this is a negative product of computations.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Agda calls its copattern records « record ».
  5. *Mnemonic:* known.
  6. *Brevity:* six letters.

  *For:* Agda's usage. *Against:* two objects under one word.

- **C — `object`.**

  1. *Non-collision:* no collision in the specification.
  2. *Scientific exactness:* a thing known by what it answers; without mutation here.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* object-oriented languages, with mutation.
  5. *Mnemonic:* your « très proche sans mutation ».
  6. *Brevity:* six letters.

  *For:* your notion. *Against:* readers expect mutable state.

- **D — The abstraction's word over labels, as Levy's `λ{i.M_i}`.** Read the λ note: the word would name the abstraction `λx.c` only, extended to labels, never chapter 3's natural transformation.

  1. *Non-collision:* one word for `Lam` and `With`.
  2. *Scientific exactness:* exact in Levy's reading: a function from labels.
  3. *Family and grade invariants:* one family: abstraction over a value or over a label.
  4. *Ecological grid (provisional):* Levy.
  5. *Mnemonic:* reuses a known word.
  6. *Brevity:* the length of the abstraction's word.

  *For:* no new word. *Against:* two kernel constructs under one word.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-013), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

#### Q-LEM-014 — Asking one observation, `c.i`

**Fiche.**

- **Symbol:** `M.i`, chapter 3 `c.i`
- **Family:** connecteurs
- **Rule:** Proj
- **Layer:** a computation
- **Now in the specification:** chapter 1: `.` serves projection and the decimal point; chapter 5's lens `view` reads a field of a record
- **Register:** none retained; candidates `project`, `select`, `send`
- **Overlaps:** `select` (Q-LEM-015); the kernel's `send m(v) to v`; `view` reads a record value; Annex A writes `e.τ` for an existential projection

**Object.** Chapter 1: « Le point `.` enfin sert la projection et la décimale, séparés par la position » (GlyphTable (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C1/GlyphTable.lean)). The With of Q-LEM-013 runs only the observation asked.

**Facts.**

- Levy writes the projection `î‘M`, the same ‘ as application: « We write ‘ for application in reverse order » (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).
- Clojure: « Keywords implement IFn for invoke() of one argument (a map) »; « (:mykey my-hash-map :none) means the same as (get my-hash-map :mykey :none) » (Clojure, data structures (https://clojure.org/reference/data_structures)).
- Annex A: « Projection implicite `e.τ` sur un paquet existentiel » (PhaseDistinction (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/AnnexA/PhaseDistinctionAndMetaprogramming.lean)).
- `send` is not proposed: the kernel's `send m(v) to v` is an asynchronous message, another construct.

- **A — `.` only; the construct is named `project`.**

  1. *Non-collision:* `.` also writes the decimal point and `e.τ`, told apart by position.
  2. *Scientific exactness:* the categorical term.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* universal dot notation.
  5. *Mnemonic:* known.
  6. *Brevity:* one character.

  *For:* chapter 1 already says so. *Against:* `project` suggests a cartesian product (register).

- **B — The label applied, as Levy and Clojure keywords.** Example: `(:increment counter)`.

  1. *Non-collision:* risk: `:` opens properties and branchings in K7PL.
  2. *Scientific exactness:* Levy's reading.
  3. *Family and grade invariants:* projection as application, one rule.
  4. *Ecological grid (provisional):* Clojure.
  5. *Mnemonic:* known to Clojure readers.
  6. *Brevity:* short.

  *For:* no word, one rule. *Against:* `:` already has a role.

- **C — `project`, written.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* exact.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* category theory.
  5. *Mnemonic:* clear.
  6. *Brevity:* seven letters.

  *For:* explicit. *Against:* long for a common case.

- **D — `view`, one word with the lens.**

  1. *Non-collision:* the lens reads a record value; this asks a computation.
  2. *Scientific exactness:* inexact for the negative product.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* optics libraries.
  5. *Mnemonic:* already in chapter 5.
  6. *Brevity:* four letters.

  *For:* an existing word. *Against:* two objects under one word.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-014), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

### Gaps of the specification

#### Q-LEM-015 — Gap — the words of the conditional: `select`, `choose`

**Fiche.**

- **Constructs:** the layer-2 conditional; layer 3's `choose`; selection by indices `⊏`
- **Now in the specification:** chapter 5: `choose` runs one branch, the dyadic `select` with a mask computes both (VOC-2026-10-29-021)
- **Now in the lexicon:** `select.k`: « The lexeme `select` in its conditional reading (chapter 5) », triadic, layer 2
- **Recorded:** your remark: « Je pense que select suffit mais nous le vérifierons plus tard »

**Object.** Three writings branch on a boolean or a mask: the K form `(select C E1 E2)` (select.k (https://github.com/AntheaLiles/k7pl/blob/main/lexicon/lexemes/select.k)), which evaluates only the chosen branch; chapter 5's `choose`, a modifier of two operands in layer 3; and the dyadic `select` of layer 3, alias of `⊏` « Sélection par indices » (InPractice (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean), GlyphTable (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C1/GlyphTable.lean)). The experimental K subset lists « `+`, `<` et `select` » (CodeArtifacts (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/CodeArtifacts.lean)); Annex A's `ERR-LOG-001` advises « Utiliser `match`, `cond` ou `select` » and names neither `choose` nor the cost of a mask (PurityAndLayer3Discipline (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/AnnexA/PurityAndLayer3Discipline.lean)). A boolean is a sum of two units, so a conditional is also a `case` (Q-LEM-012).

**Facts.**

- BQN's Choose « applies one function from a list 𝕘, based on the selecting index returned by a function 𝔽 » (BQN, Choose (https://mlochbaum.github.io/BQN/doc/choose.html)).
- Pretnar's calculus has `if v then c1 else c2`, « conditional » (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).

- **A — `select` for all (your remark).** `choose` is withdrawn; the cost follows the condition: a boolean runs one branch, a mask computes both.

  1. *Non-collision:* one word, two arities by layer.
  2. *Scientific exactness:* exact for selection; the cost depends on the argument's type.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* APL family for selection.
  5. *Mnemonic:* one word.
  6. *Brevity:* six letters.

  *For:* one word, as you expect. *Against:* VOC-2026-10-29-021 chose two words so that each says its cost.

- **B — `choose` for every conditional that runs one branch.** The K lexeme becomes `choose.k` (layer 2, triadic in parentheses); `select` keeps only selection by indices; chapter 5's K section and `ERR-LOG-001` follow.

  1. *Non-collision:* removes the double reading of `select`.
  2. *Scientific exactness:* each word says its cost.
  3. *Family and grade invariants:* one word per cost across layers.
  4. *Ecological grid (provisional):* BQN.
  5. *Mnemonic:* clear.
  6. *Brevity:* six letters.

  *For:* matches VOC-2026-10-29-021 in every layer. *Against:* the K lemma and the names its proofs export change.

- **C — No conditional word in layer 2: a `case` on `true`/`false`.** Layer 3 keeps `choose` and `select`; the K lexeme is replaced by the lemma of Q-LEM-012.

  1. *Non-collision:* no collision.
  2. *Scientific exactness:* exact: a boolean is `1 + 1`.
  3. *Family and grade invariants:* one eliminator for sums.
  4. *Ecological grid (provisional):* ML writes `if` though it is a `match`.
  5. *Mnemonic:* verbose.
  6. *Brevity:* long for the commonest branch.

  *For:* no word added. *Against:* the commonest branch becomes verbose; the K subset changes.

- **D — As is, told apart by layer.** `select` triadic in layer 2 runs one branch; `select` dyadic in layer 3 computes both; `choose` in layer 3.

  1. *Non-collision:* one word, two costs.
  2. *Scientific exactness:* the cost is not in the word.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* two meanings to remember.
  6. *Brevity:* —

  *For:* nothing changes. *Against:* the gap stays.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-015), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:**

  > Need an overview because case is great in patter matching and in real-time programing we will try to catch things on the flow rather than get them from a disk to memory to compute them.
  >
  > catch <construct>
  >     case <formA> <transformA>
  >     case <formB> <transformB>
  >
  > Pouvant donner
  > (case (catch <form>)
  >             <formA> <transformA>
  >             <formB> <transformB>)
  > Où la forme peut représenter le type rafiné, le budget, la valeur binaire, ou toute autre construction.

- **Reading:** kept open: the author asks for an overview. `case` serves pattern matching, and a real-time program catches values on the flow rather than bringing them from disk to memory to compute them; the author sketches a `catch` of a construct followed by `case` clauses, each a form and a transformation, or `(case (catch <form>) <formA> <transformA> <formB> <transformB>)`, where a form may be a refinement type, a budget, a binary value or any other construction.
- **Put back to the author:** `catch` already names the handler of the kernel's `try c catch c` (chapter 3's grammar); under Q-LEM-001, a second object needs a second word, or the two must be shown to be one object.

#### Q-LEM-016 — Gap — `cond`, named and never defined

**Fiche.**

- **Mentions:** chapter 3 (GradedSystem, ValueConstraints); Annex A (`ERR-LOG-001`, `ERR-TYP-012`)
- **Definition:** none; no listing, no register entry

**Object.** Chapter 3: « Deux branches d'un `match` ou d'un `cond` ne consomment pas nécessairement les mêmes ressources » (GradedSystem (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/GradedSystem.lean)); « ni `match` sur un paramètre de typestate, ni `cond` sur un paramètre fantôme » (ValueConstraints (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/ValueConstraints.lean)); Annex A repeats both. `cond` is defined nowhere.

**Facts.**

- Common Lisp: « Test-forms are evaluated one at a time in the order in which they are given in the argument list » « until a test-form is found that evaluates to true » (CLHS, cond (https://www.lispworks.com/documentation/HyperSpec/Body/m_cond.htm)).

- **A — Define `cond` in layer 2: a chain of guarded clauses.** Elaborated into nested conditionals (Q-LEM-015) or `case`.

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* Lisp's exact sense.
  3. *Family and grade invariants:* a derived form, not a kernel construct.
  4. *Ecological grid (provisional):* Lisp family.
  5. *Mnemonic:* known.
  6. *Brevity:* four letters.

  *For:* the mentions become true. *Against:* one more form.

- **B — Remove `cond`: guards of `match` cover it.**

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* —
  3. *Family and grade invariants:* one eliminator form.
  4. *Ecological grid (provisional):* Rust, OCaml guards.
  5. *Mnemonic:* nothing to learn.
  6. *Brevity:* —

  *For:* fewer forms. *Against:* chapter 3 and Annex A are reworded.

- **C — Replace `cond` by the conditional word of Q-LEM-015.**

  1. *Non-collision:* depends on Q-LEM-015.
  2. *Scientific exactness:* —
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* —
  6. *Brevity:* —

  *For:* one word for conditionals. *Against:* a chain of clauses is not a single condition.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-016), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:**

  > Pas de conditionnel, on passe par le pattern matching
  >
  > Donc `catch` et `case`

- **Reading:** no conditional form: branching goes through pattern matching, with `catch` and `case`; `cond` leaves chapter 3 and Annex A.
- **Put back to the author:** how this reads with `choose` and the dyadic `select` of layer 3 (VOC-2026-10-29-021), with the triadic `select` of the K lexicon, and with Q-LEM-015, kept open; and the same remark on `catch` as in Q-LEM-015.

## Lemma lot 2 of 2026-11-03: matching after lot 1, products asked again, existentials, grading, effects, types, time, place, concurrency

Opened on 2026-11-03, after the answers to lemma lot 1, and extended on 2026-11-04 to 24 questions at the
author's request (Q-LEM-112 to Q-LEM-124: types and recursion, time, place, concurrency and memory,
confidentiality). Same format: a fiche of the construct, the specification's text, what the literature and
other languages do, and options weighed on the six criteria of Q-METH-001 (option A) in their order, with
their pros and cons. **Other** and **Clarify** are always available.

Second lot of lemmas. It asks again what lot 1 kept open, now that `bind`, `unbind`, `unit`, `tag` and `case` are preferred, and goes on with the existentials, the grading, the operations of effects, the types and recursion, time, place, concurrency, memory and confidentiality. Recorded since lot 1: `catch` and the kernel's `try c catch c` are one object, a generalisation of pattern matching (VOC-2026-11-03-017); the glyphs are dealt with once every lemma is fixed (VOC-2026-11-03-018); every construction is a pattern, `@x` being every pattern of `x`, and `case` sets conditions on what was caught, as SQL's `CASE` (VOC-2026-11-04-001, -002). Q-LEM-101, Q-LEM-102 and Q-LEM-119 are withdrawn: how a program connects to its flows comes first, in the research of 2026-11-04 (research.md). Each option is weighed on the six criteria of Q-METH-001 (option A), in their order; an answer is a dated preference, ratified only in the global lot (VOC-2026-10-26-002). Every word of the examples other than the one asked is a placeholder.

**Answers of the author — 2026-11-04, given in the conversation, quoted as given.**

The author asked for a summary of what is understood of pattern matching, then answered:

> Tu as bien compris et bien résumé. case garde un role pour définir des conditions sur un motif attrapé à l'image du CASE en SQL, @x est tout motif de x.
>
> Les réflexions que nous devrions alors avoir c'est comment se connecter au flux et comment simuler un flux lorsque l'on doit lire ailleurs que sur un réseau. Nous avons :on qui semble alors redondant avec catch dans le sens où en data-flow le fait d'envoyer un flux à un automate est un routage naturel et implicite... nous devrions approfondir comment gèrent les langages de control-flow et de pattern-matching avancés comme TXR Lisp, Go, etc.

- **VOC-2026-11-04-001, reading:** the summary stands: every construction is a pattern (a type, refined or not, with its grades and budget; a construction or tag; a binary value; an R-expression; a trace; an algebraic effect), written with the language itself and turned into a pattern by `@`; `@x` is every pattern of `x`; what is caught carries the refined type of its construction; matching generalises in what is matched, where (a value present or a flow arriving: data, messages, events, effects, failures) and how (a pattern compiled into an automaton put in production by an actor or an orchestrator).
- **VOC-2026-11-04-002, reading:** `case` keeps a role: it sets conditions on what a pattern has caught, as SQL's `CASE`.
- **VOC-2026-11-04-003, reading:** to study next, how a program connects to a flow, how a flow is simulated when reading elsewhere than on a network, and whether `:on` is redundant with `catch` when routing a flow to an automaton is natural and implicit in data-flow, from what TXR Lisp, Go and other control-flow and pattern-matching languages do. Done in [research](research.md), « Reading lot: research of 2026-11-04, connecting to a flow ».

### Matching, after lot 1

#### Q-LEM-101 — What `catch` gathers

**Withdrawn on 2026-11-04, unanswered.** The author confirmed the reading of pattern matching given in the conversation and asked first how a program connects to its flows (VOC-2026-11-04-001 to -003, below); the research of 2026-11-04 in [research](research.md) replaces this question.

**Fiche.**

- **Constructs:** the kernel's eliminators that choose a continuation by what they meet: `case v of` (Case), `try c catch h` (Try), the handling of operations (Op, Sc), `guard v {p_i ↦ c_i}` (Guard), `when x = v in c` (When)
- **Recorded:** `case` for sums (VOC-2026-11-03-012); no conditional, branching by `catch` and `case` (VOC-2026-11-03-016); `catch` and `try … catch` are one object, a generalisation of pattern matching (VOC-2026-11-03-017)

**Object.** Five kernel constructs choose a continuation by what they meet: a value's tag (`case`), a failure (`try c catch h`, which on failure gives `⟨h ∣ μ ∣ τ·fail⟩`, OperationalSemantics (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/OperationalSemantics.lean)), an operation of an effect (its handler), messages in a mailbox (`guard`: « La branche ne s'ouvre que si tous les messages du motif sont présents, et les consomme d'un seul tenant », TypingRules (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)), and an event (`when`). Tick those that become forms of `catch`; the others keep a word of their own, asked later.

**Facts.**

- OCaml 5: « Similar to exception patterns in a match ... with expression, OCaml also supports effect patterns »; one `match f () with` may hold a value case, `| exception e ->` and `| effect Yield, k ->` (OCaml manual, effect handlers (https://ocaml.org/manual/5.3/effects.html)).
- Erlang's `receive`: « The patterns in the clauses are matched against a message from top to bottom »; « The execution is suspended, possibly indefinitely, until a message arrives that matches one of the patterns » (Erlang, expressions (https://www.erlang.org/doc/system/expressions.html)).
- Algebraic effects: a handler is a list of clauses, `handler {return x ↦ c_r, op_1(x; k) ↦ c_1, …}`, used by `with v handle c` (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).

Several options may be chosen.

- **fail — Failures: `try c catch h`.** Already recorded (VOC-2026-11-03-017).
  *For:* the kernel's word. *Against:* —

- **operation — Operations of effects: the handler's clauses.** A catch matches the operations its computation performs, each clause receiving the continuation.
  *For:* OCaml 5 puts effect cases in its `match`; one construct for failures and effects. *Against:* a handler is also a value (chapter 3's rule names `handler` a value); the value and the matching must still be told apart.

- **message — Messages: `guard`.** A catch on a mailbox waits for the messages its patterns name, join patterns included.
  *For:* Erlang's `receive` is this; real-time code « catches things on the flow » (VOC-2026-11-03-015). *Against:* `guard` consumes several messages at once and waits: its cost and its blocking must stay visible.

- **event — Events: `when x = v in c`.** A catch on a temporal value waits for the event and binds what it carries.
  *For:* the same shape: wait, then branch on what arrives. *Against:* time is a modality of its own (chapter 3); its words are in lot 3.

- **value — Values: `case` itself.** `case` becomes the clause list of a catch on a value already present.
  *For:* one construct for everything that is matched. *Against:* `case` is the preferred word for sums (VOC-2026-11-03-012); this makes it a part of `catch`.


#### Q-LEM-102 — How a catch is written

**Withdrawn on 2026-11-04, unanswered.** Replaced by the research of 2026-11-04 in [research](research.md): how a catch is written follows from how it connects to its flow.

**Fiche.**

- **Now in the specification:** chapter 3 `try c catch h`; no surface form
- **Recorded:** your two sketches (VOC-2026-11-03-015): `catch <construct>` followed by `case <form> <transform>` clauses; and `(case (catch <form>) <formA> <transformA> <formB> <transformB>)`
- **Overlaps:** layer 2's words are n-ary, in parentheses; `case` is the eliminator of sums

**Object.** Whatever Q-LEM-101 gathers, a catch has three parts: what is watched (a computation, a mailbox, a flow), the clauses (a form and its transformation), and for an operation the continuation. A form may be « le type raffiné, le budget, la valeur binaire, ou toute autre construction » (VOC-2026-11-03-015).

**Facts.**

- OCaml 5: « Similar to exception patterns in a match ... with expression, OCaml also supports effect patterns »; one `match f () with` may hold a value case, `| exception e ->` and `| effect Yield, k ->` (OCaml manual, effect handlers (https://ocaml.org/manual/5.3/effects.html)).
- OCaml keeps `try … with` beside `match … with`: `try comp1 () with | effect (Xchg n), k -> continue k (n+1)` (OCaml manual, effect handlers (https://ocaml.org/manual/5.3/effects.html)).

- **A — `case` gives the clauses, `catch` marks what is caught.** Example: `(case (catch (read-sensor)) (ok v) (use v) timeout (retry))`.

  1. *Non-collision:* no new word.
  2. *Scientific exactness:* `catch` produces what `case` matches.
  3. *Family and grade invariants:* `case` is the only clause list.
  4. *Ecological grid (provisional):* close to OCaml's `match f () with`.
  5. *Mnemonic:* your second sketch.
  6. *Brevity:* short.

  *For:* one clause syntax for everything. *Against:* `catch` alone reads as a value, not as a wait.

- **B — `catch` heads, each clause introduced by `case`.** Example: `(catch (read-sensor) (case (ok v) (use v)) (case timeout (retry)))`.

  1. *Non-collision:* no new word.
  2. *Scientific exactness:* the watched computation is the head.
  3. *Family and grade invariants:* `case` names a clause, not the eliminator of sums.
  4. *Ecological grid (provisional):* Erlang's `receive` with clauses.
  5. *Mnemonic:* your first sketch.
  6. *Brevity:* one `case` per clause.

  *For:* what is watched comes first. *Against:* `case` takes a second sense, a clause.

- **C — `catch` heads, the kind of what is caught written in the pattern.** As OCaml 5 writes `exception e` and `effect E, k` inside its patterns. Example: `(catch (read-sensor) v (use v) (fail e) (log e) (effect tick k) (resume k))`.

  1. *Non-collision:* the kinds (`fail`, `effect`) need words.
  2. *Scientific exactness:* each clause says what it catches.
  3. *Family and grade invariants:* one form for every kind.
  4. *Ecological grid (provisional):* OCaml 5.
  5. *Mnemonic:* explicit.
  6. *Brevity:* longer patterns.

  *For:* one form; nothing hidden. *Against:* two more words in patterns.

- **D — `case` for values present, `catch` for what arrives, one clause syntax.** Example: `(case v (ok x) (use x) (err e) (log e))   (catch (read-sensor) (ok x) (use x) timeout (retry))`.

  1. *Non-collision:* two heads for two situations.
  2. *Scientific exactness:* the head says whether the form waits.
  3. *Family and grade invariants:* the same clauses under both.
  4. *Ecological grid (provisional):* Erlang's `case` and `receive`.
  5. *Mnemonic:* clear.
  6. *Brevity:* short.

  *For:* the cost (waiting or not) is in the word. *Against:* two heads for one generalisation.


#### Q-LEM-103 — Consuming the unit, asked again

**Fiche.**

- **Symbol:** `let () = V in N`
- **Rule:** OneE
- **Recorded:** kept open (VOC-2026-11-03-008); since then: `bind` (VOC-2026-11-03-006), `unit` (VOC-2026-11-03-007)

**Object.** A computation run for its effect returns `unit`; the next one follows. With the words of lot 1, the kernel writes it `bind () = c1 in c2`.

**Facts.**

- Common Lisp's implicit progn: « an ordered set of adjacent forms appearing in another form, and defined by their context in that form » « to be executed as if within a progn » (CLHS glossary (https://www.lispworks.com/documentation/HyperSpec/Body/26_glo_i.htm)).
- Pretnar abbreviates sequencing without use to `c1 ; c2` (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).

- **A — The pattern `unit` of `bind`.** Example: `(bind [unit (log x)] (return x))`.

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* the kernel's pattern.
  3. *Family and grade invariants:* one binding form with patterns.
  4. *Ecological grid (provisional):* ML.
  5. *Mnemonic:* explicit.
  6. *Brevity:* verbose for a run of effects.

  *For:* no word. *Against:* every effect costs a binding.

- **B — An implicit sequence: a body runs its forms in order.** Example: `(bind [x (read)] (log x) (return x))`.

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* each form but the last must return `unit`, checked by the type.
  3. *Family and grade invariants:* the bodies of `bind` and definitions alike.
  4. *Ecological grid (provisional):* Lisp's implicit progn.
  5. *Mnemonic:* familiar to Lisp readers.
  6. *Brevity:* the shortest.

  *For:* no word, no binding. *Against:* the order is carried by position, not by a word.

- **C — A block word, `seq`.** Example: `(seq (log x) (return x))`.

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* exact if every form but the last returns `unit`.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Clojure's `do`, Scheme's `begin`.
  5. *Mnemonic:* clear.
  6. *Brevity:* three letters.

  *For:* the sequence is named. *Against:* one more word.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-007), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

### Products, asked again

#### Q-LEM-104 — The pair, with `join` and the words of SQL and NoSQL

**Fiche.**

- **Symbol:** `(V₁, V₂)`
- **Rule:** Pair
- **Recorded:** kept open: « Why not "join" and sql's/nosql's lemmas? » (VOC-2026-11-03-009)
- **Overlaps:** `join` is the alias of the glyph `∾`, « Concaténation verticale » (chapter 1); the lattice's « joint » `⊔`; the « motif de jonction » of chapters 1 and 4

**Object.** The pair joins two separate resources. Chapter 1's glyph table already gives `join` to `∾` (GlyphTable (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C1/GlyphTable.lean)); chapter 2 writes the lattice's least upper bound « joint ⊔ ».

**Facts.**

- PostgreSQL: « Queries that access multiple tables (or multiple instances of the same table) at one time are called join queries »; « A row constructor is an expression that builds a row value (also called a composite value) using values for its member fields », written `ROW(1,2.5,'this is a test')` (PostgreSQL, joins (https://www.postgresql.org/docs/current/tutorial-join.html); PostgreSQL, row constructors (https://www.postgresql.org/docs/current/sql-expressions.html)).
- MongoDB's `$lookup`: « Performs a left outer join to a collection in the same database » (MongoDB (https://www.mongodb.com/docs/manual/reference/operator/aggregation/lookup/)); Cassandra: « CQL also support tuples and tuple types (where the elements can be of different types) » (CQL types (https://cassandra.apache.org/doc/latest/cassandra/developing/cql/types.html)).

- **A — `pair`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* exact for two parts.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* universal.
  5. *Mnemonic:* immediate.
  6. *Brevity:* four letters.

  *For:* immediate. *Against:* silent on the separation, which the type carries.

- **B — `tuple`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* n-ary where the kernel is binary.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* ML, Haskell, Python, Cassandra.
  5. *Mnemonic:* known.
  6. *Brevity:* five letters.

  *For:* one word for any length. *Against:* the kernel construct is binary.

- **C — `row`, as SQL's row constructor.**

  1. *Non-collision:* no collision found in the specification.
  2. *Scientific exactness:* a row is a composite value of named or ordered fields.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* SQL.
  5. *Mnemonic:* known to database readers.
  6. *Brevity:* three letters.

  *For:* the database reading you suggest. *Against:* suggests a table around it.

- **D — `join`.**

  1. *Non-collision:* collisions: the alias of `∾`, the lattice's join `⊔`, the join patterns.
  2. *Scientific exactness:* inexact: a SQL join combines tables by a condition, not two values.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* SQL, MongoDB.
  5. *Mnemonic:* known with another sense.
  6. *Brevity:* four letters.

  *For:* the database word. *Against:* three objects already carry it in K7PL.


#### Q-LEM-105 — The negative product, with codata

**Fiche.**

- **Symbol:** `⟨M_i⟩`
- **Rule:** With
- **Recorded:** kept open (VOC-2026-11-03-013); « Toujours pas de l'objet mais très proche sans mutation » (VOC-2026-10-27-027)
- **Overlaps:** `case` is the eliminator of sums; this construct is its dual

**Object.** A computation that waits to be asked which of its components to run. The literature on codata describes it as an object known by the observations it answers; `case` being preferred for sums, the dual is open to a dual word.

**Facts.**

- « codata declarations define the types of destructors (which consume values of the codata type) »; « The combination of observation-based interfaces, message-passing, and dynamic dispatch are exactly the tools needed for procedural abstraction »; its values are written `{H1 → e1, …, Hn → en}` (Downen et al., Codata in Action (https://www.microsoft.com/en-us/research/uploads/prod/2020/01/CoDataInAction.pdf)).
- Agda: « we can define the fields of a record as separate declarations » (Agda, copatterns (https://agda.readthedocs.io/en/latest/language/copatterns.html)).
- Levy writes it `λ{i.M_i}` (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).

**The λ overlap.** The symbol λ names two objects in the specification: the abstraction `λx.c` (rule `Lam`) and, in chapter 3, a natural transformation of the graded distributive law. A candidate must only ever name the first.

- **A — `object`.**

  1. *Non-collision:* no collision in the specification.
  2. *Scientific exactness:* the codata reading: known by what it answers.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* object-oriented languages, with mutation.
  5. *Mnemonic:* your « très proche sans mutation ».
  6. *Brevity:* six letters.

  *For:* the codata literature's own reading. *Against:* readers expect mutable state.

- **B — `cocase`, the dual of `case` (a proposal, without a source for the word).**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* names the duality with the eliminator of sums.
  3. *Family and grade invariants:* pairs with `case`.
  4. *Ecological grid (provisional):* no source checked for the word.
  5. *Mnemonic:* clear to who knows duality.
  6. *Brevity:* six letters.

  *For:* the family `case`/`cocase`. *Against:* a coinage.

- **C — `with`.**

  1. *Non-collision:* risk: `with v handle c` in effects.
  2. *Scientific exactness:* linear logic's name of `&`.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* linear logic.
  5. *Mnemonic:* opaque.
  6. *Brevity:* four letters.

  *For:* the logic's word. *Against:* read as a handler.

- **D — The abstraction's word over labels, as Levy's `λ{i.M_i}`.** Read the λ note: the word would name the abstraction `λx.c` only, extended to labels.

  1. *Non-collision:* one word for `Lam` and `With`.
  2. *Scientific exactness:* exact in Levy's reading.
  3. *Family and grade invariants:* abstraction over a value or a label.
  4. *Ecological grid (provisional):* Levy.
  5. *Mnemonic:* a known word.
  6. *Brevity:* the abstraction's length.

  *For:* no new word. *Against:* two kernel constructs under one word.


#### Q-LEM-106 — Asking one observation, with codata

**Fiche.**

- **Symbol:** `M.i`
- **Rule:** Proj
- **Recorded:** kept open (VOC-2026-11-03-014)
- **Overlaps:** chapter 1: `.` for projection and decimals; Annex A's `e.τ`; the rule Out's retained « observation » (`ν`); the kernel's `send m(v) to v`

**Object.** The negative product of Q-LEM-105 runs only the component asked.

**Facts.**

- « codata observations of the form t.H using “dot notation”, which can be thought of as sending the message H to the object t or as a method invocation from object-oriented languages » (Downen et al., Codata in Action (https://www.microsoft.com/en-us/research/uploads/prod/2020/01/CoDataInAction.pdf)).
- Clojure: « Keywords implement IFn for invoke() of one argument (a map) » (Clojure, data structures (https://clojure.org/reference/data_structures)).

- **A — `.` only; the construct is named `project`.**

  1. *Non-collision:* `.` also writes decimals and `e.τ`, told apart by position.
  2. *Scientific exactness:* the categorical term.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* dot notation everywhere.
  5. *Mnemonic:* known.
  6. *Brevity:* one character.

  *For:* chapter 1 already says so. *Against:* `project` suggests a cartesian product.

- **B — `.` only; the construct is named `observe`.**

  1. *Non-collision:* near the rule Out's « observation » (`ν`).
  2. *Scientific exactness:* the codata word.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* codata literature.
  5. *Mnemonic:* clear.
  6. *Brevity:* seven letters.

  *For:* names what happens. *Against:* two kernel constructs near one word.

- **C — The label applied, as Clojure keywords.** Example: `(:increment counter)`.

  1. *Non-collision:* `:` opens properties and branchings.
  2. *Scientific exactness:* Levy's `î‘M`.
  3. *Family and grade invariants:* projection as application.
  4. *Ecological grid (provisional):* Clojure.
  5. *Mnemonic:* known to Clojure readers.
  6. *Brevity:* short.

  *For:* one rule. *Against:* `:` already has a role.


### Existentials

#### Q-LEM-107 — Hiding a witness, `pack (W, v)`

**Fiche.**

- **Symbol:** `pack (W, V)`
- **Family:** existentielle
- **Rule:** Pack
- **Now in the specification:** chapter 3 `pack (V, v)`; prose « empaquète », « paquet »; Annex A also calls a verified SMT proof « un paquet »
- **Register:** retained `pack`; candidates `pack`, `seal`, `abstract`
- **Recorded:** Q-SPEC-603 put back « paquet » and « empaqueter », each naming two things

**Object.** Chapter 3: « $`\exists a.\, \tau` empaquète une valeur d'un type réel mais dissimulé » (OpenStructuresEffectsAndMetatheory (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/OpenStructuresEffectsAndMetatheory.lean)).

**Facts.**

- OCaml's first-class modules: « pack a module as a first-class value, which can later be dynamically unpacked into a module » (OCaml manual, first-class modules (https://ocaml.org/manual/5.3/firstclassmodules.html)).

- **A — `pack`.**

  1. *Non-collision:* « paquet » names a proof bundle too, in French prose only.
  2. *Scientific exactness:* the literature's word.
  3. *Family and grade invariants:* pairs with `unpack`.
  4. *Ecological grid (provisional):* OCaml, type theory.
  5. *Mnemonic:* known.
  6. *Brevity:* four letters.

  *For:* the register's retained word. *Against:* the French « paquet » stays ambiguous.

- **B — `seal`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* says the witness is closed off.
  3. *Family and grade invariants:* pairs with `unseal`.
  4. *Ecological grid (provisional):* rare.
  5. *Mnemonic:* evocative.
  6. *Brevity:* four letters.

  *For:* frees « paquet ». *Against:* less usual.

- **C — `abstract`.**

  1. *Non-collision:* collision: « abstraction » names `λ`.
  2. *Scientific exactness:* the type-theory sense (abstract types).
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* ML's abstract types.
  5. *Mnemonic:* ambiguous.
  6. *Brevity:* eight letters.

  *For:* the theory's sense. *Against:* two meanings of « abstraction ».

**Answer of the author — 2026-11-03 (VOC-2026-11-03-019), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** hiding a witness is `pack` (option A).

#### Q-LEM-108 — Opening an existential, `open v as (α,x) in c`

**Fiche.**

- **Symbol:** `open V as (α,x) in N`
- **Rule:** Open
- **Now in the specification:** the formula writes `open`; the prose writes `unpack` (`ERR-TYP-011`)
- **Recorded:** Q-SPEC-603 put back `open` against `unpack`; `unbind` takes a pair apart (VOC-2026-11-03-010)

**Object.** Chapter 3: « l'élimination, une simple projection `e.τ`, ne demande aucun `unpack` explicite en surface », but « le compilateur exige alors un `unpack` explicite (`ERR-TYP-011`) » when the witness carries an erasable grade (OpenStructuresEffectsAndMetatheory (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/OpenStructuresEffectsAndMetatheory.lean)).

**Facts.**

- OCaml: `(val e : S)` « extracts the module that was encapsulated in this value » (OCaml manual, first-class modules (https://ocaml.org/manual/5.3/firstclassmodules.html)).

- **A — `unpack`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the reverse of `pack`.
  3. *Family and grade invariants:* pairs with `pack`, as `unbind` with `bind`.
  4. *Ecological grid (provisional):* OCaml's wording.
  5. *Mnemonic:* clear.
  6. *Brevity:* six letters.

  *For:* what the prose and `ERR-TYP-011` already say. *Against:* the formula changes.

- **B — `open`.**

  1. *Non-collision:* risk: OCaml's `open` brings a module's names into scope; files are opened.
  2. *Scientific exactness:* the formula's word.
  3. *Family and grade invariants:* no pair with `pack`.
  4. *Ecological grid (provisional):* type theory.
  5. *Mnemonic:* ambiguous.
  6. *Brevity:* four letters.

  *For:* the formula's word. *Against:* the prose and the error message change.

- **C — A pattern of `unbind`.** The witness and the value are bound together, as `unbind` takes a pair apart. Example: `(unbind [(a x) v] …)`.

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* an existential is a pair of a type and a value.
  3. *Family and grade invariants:* one decomposition form.
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* needs explaining.
  6. *Brevity:* short.

  *For:* no word. *Against:* the witness is a type, not a value.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-020), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** opening an existential is `unpack` (option A), the reverse of `pack`.

### Grading

#### Q-LEM-109 — Promoting a value under a grade, `box_r v`

**Fiche.**

- **Symbol:** `box_r V`
- **Family:** gradation
- **Rule:** Box
- **Register:** none retained; candidates `box`, `promote`, `grade`
- **Recorded:** Q-SPEC-603 put back « box », which GHC and Rust use for heap allocation

**Object.** The value enters the graded comonad `!_r`, usable `r` times.

**Facts.**

- Granule: « can be constructed by promotion, written [t], which promotes a term t to a graded modal type » (Orchard et al., ICFP 2019 (https://www.cs.kent.ac.uk/people/staff/dao7/publ/granule-icfp19.pdf)).
- Rust: « Box<T>, casually referred to as a ‘box’, provides the simplest form of heap allocation in Rust » (Rust, std::boxed (https://doc.rust-lang.org/std/boxed/index.html)).

- **A — `box`.**

  1. *Non-collision:* ecological collision: heap allocation in Rust and GHC.
  2. *Scientific exactness:* the modal-logic word.
  3. *Family and grade invariants:* pairs with `unbox`.
  4. *Ecological grid (provisional):* modal type theory.
  5. *Mnemonic:* known, with the heap sense.
  6. *Brevity:* three letters.

  *For:* the kernel's word. *Against:* readers from Rust expect an allocation.

- **B — `promote`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* Granule's term.
  3. *Family and grade invariants:* pairs with `demote`, or with the pattern of Q-LEM-110.
  4. *Ecological grid (provisional):* Granule.
  5. *Mnemonic:* says what happens.
  6. *Brevity:* seven letters.

  *For:* no heap sense. *Against:* longer.

- **C — `grade`.**

  1. *Non-collision:* « grade » already names the annotation.
  2. *Scientific exactness:* names the annotation, not the act.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* five letters.

  *For:* the grade is visible. *Against:* the noun and the act share a word.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-021), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** promoting a value under a grade is `box` (option A).

#### Q-LEM-110 — Using a graded value, `unbox v as x in c`

**Fiche.**

- **Symbol:** `unbox V as x in N`
- **Rule:** Unbox
- **Register:** none retained; candidates `unbox`, `extract`, `let-box`

**Object.** The graded value is taken out and bound to `x`, which may then be used as its grade allows.

**Facts.**

- Granule: « The “boxing” (promotion) construct [t] is dualised by the unboxing pattern [p] », with `let [p] = t1 in t2` as sugar (Orchard et al., ICFP 2019 (https://www.cs.kent.ac.uk/people/staff/dao7/publ/granule-icfp19.pdf)).
- Haskell's comonads: `extract :: w a -> a` (comonad, Control.Comonad (https://hackage.haskell.org/package/comonad/docs/Control-Comonad.html)).

- **A — `unbox`.**

  1. *Non-collision:* « unboxed » means without indirection in GHC and Rust.
  2. *Scientific exactness:* the dual of `box`.
  3. *Family and grade invariants:* pairs with `box`.
  4. *Ecological grid (provisional):* modal type theory.
  5. *Mnemonic:* known.
  6. *Brevity:* five letters.

  *For:* the kernel's word. *Against:* follows `box` into the heap sense.

- **B — A pattern of `bind`, as Granule's unboxing pattern.** Example: `(bind [(promoted x) v] …)`.

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* Granule's reading.
  3. *Family and grade invariants:* one binding form with patterns.
  4. *Ecological grid (provisional):* Granule.
  5. *Mnemonic:* needs the pattern word.
  6. *Brevity:* short.

  *For:* no word. *Against:* the pattern still needs a name.

- **C — `extract`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the comonad's operation, ungraded.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Haskell.
  5. *Mnemonic:* says what happens.
  6. *Brevity:* seven letters.

  *For:* the comonad reading. *Against:* Haskell's `extract` has no grade.

**Answer of the author — 2026-11-03 (VOC-2026-11-03-022), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** using a graded value is `unbox` (option A), the reverse of `box`.

### Effects

#### Q-LEM-111 — Invoking an operation, `operation_ε(v)`

**Fiche.**

- **Symbol:** `perform_op(V)`, chapter 3 `operation_ε(v)`
- **Family:** effets
- **Rule:** Op
- **Now in the specification:** chapter 3 `operation`; the surface word `perform`; the branching `:perform` (VOC-2026-10-27-061)
- **Overlaps:** chapter 3's rule: `operation` and `scoped` are kinds of operation, `perform` and `handle` actions, `handler` a value

**Object.** Chapter 3: « `perform` et `handle` sont deux actions, invoquer et traiter ; `handler` n'est ni l'un ni l'autre, c'est le nom d'une _valeur_ » (TermGrammar (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TermGrammar.lean)). Under Q-LEM-001, the formula takes the surface word when they name one object.

**Facts.**

- OCaml 5: « The computation comp1 performs the effect twice using the perform primitive », `perform (Xchg 0)` (OCaml manual, effect handlers (https://ocaml.org/manual/5.3/effects.html)).
- Pretnar writes the operation applied, `op(v; y. c)`, « operation call » (Pretnar 2015 (https://www.eff-lang.org/handlers-tutorial.pdf)).

- **A — `perform` for the term; `operation` stays the kind declared.**

  1. *Non-collision:* no collision.
  2. *Scientific exactness:* two objects, two words, as chapter 3's rule says.
  3. *Family and grade invariants:* a verb for the term.
  4. *Ecological grid (provisional):* OCaml 5, Eff.
  5. *Mnemonic:* known.
  6. *Brevity:* seven letters.

  *For:* the surface and the branching already write it. *Against:* the formula changes.

- **B — `operation` for both.**

  1. *Non-collision:* one word for the kind and the term.
  2. *Scientific exactness:* conflates the declaration and its use.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* nine letters.

  *For:* the formula's word. *Against:* chapter 3's rule says they are two objects.

- **C — No word: the operation applied, as a tag is applied.** Example: `(tick 1)`.

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* Pretnar's `op(v; y. c)`.
  3. *Family and grade invariants:* like `tag`: the name applied.
  4. *Ecological grid (provisional):* effect calculi.
  5. *Mnemonic:* the operation's own name.
  6. *Brevity:* the shortest.

  *For:* an operation reads as a function call. *Against:* an effect does not show in the text.


### Types and recursion

#### Q-LEM-112 — Generalising over a type, `Λα.c`

**Fiche.**

- **Symbol:** `Λα. c`
- **Rule:** Gen
- **Register:** none retained; « généralisation », the word of Damas and Milner
- **Overlaps:** type positions are opened by a property such as `:type` (VOC-2026-10-27-027)

**Object.** A computation abstracted over a type variable absent from its context, the dual of the existential's `pack`.

**Facts.**

- GHC: « Allow use of the forall keyword in places where universal quantification is implicit », `g :: forall b. (b -> b)` (GHC, explicit forall (https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/explicit_forall.html)).

**The λ overlap.** The symbol λ names two objects in the specification: the abstraction `λx.c` (rule `Lam`) and, in chapter 3, a natural transformation of the graded distributive law. A candidate must only ever name the first.

- **A — `forall`, the word of the type, also names the term.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the quantifier itself.
  3. *Family and grade invariants:* one word for the type and its introduction.
  4. *Ecological grid (provisional):* Haskell, logic.
  5. *Mnemonic:* known.
  6. *Brevity:* six letters.

  *For:* what readers of types know. *Against:* a term named after its type.

- **B — No written word, inferred; the construct is named `generalise`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* Damas and Milner's word.
  3. *Family and grade invariants:* a verb, as `bind`.
  4. *Ecological grid (provisional):* ML inference.
  5. *Mnemonic:* clear.
  6. *Brevity:* never written in programs.

  *For:* programs stay unannotated where inference works. *Against:* a long name in diagnostics.

- **C — The abstraction's word over types.** Read the λ note: the word would name the abstraction `λx.c` only, extended to types.

  1. *Non-collision:* one word for `Lam` and `Gen`.
  2. *Scientific exactness:* System F writes both as abstractions.
  3. *Family and grade invariants:* one family.
  4. *Ecological grid (provisional):* System F.
  5. *Mnemonic:* a known word.
  6. *Brevity:* the abstraction's length.

  *For:* no new word. *Against:* two kernel constructs under one word.


#### Q-LEM-113 — Instantiating a type, `c [W]`

**Fiche.**

- **Symbol:** `c [W]`
- **Rule:** Inst
- **Register:** none retained; « instanciation » (Damas and Milner), « application de type » rejected as naming the form
- **Recorded:** application is named `apply` (VOC-2026-11-03-002)
- **Overlaps:** `@x` is a refinement in chapter 5; `@_n` is the localisation

**Object.** Substituting a type for the variable a generalised computation abstracts.

**Facts.**

- GHC: « The TypeApplications extension allows you to use visible type application in expressions », `show (read @Int "5")` (GHC, type applications (https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/type_applications.html)).

- **A — No written word, inferred; the construct is named `instantiate`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* Damas and Milner's word.
  3. *Family and grade invariants:* a verb.
  4. *Ecological grid (provisional):* ML inference.
  5. *Mnemonic:* clear.
  6. *Brevity:* never written in programs.

  *For:* names the act. *Against:* a long name in diagnostics.

- **B — `apply`, one word for applying to a value or to a type.**

  1. *Non-collision:* one name for two kernel constructs.
  2. *Scientific exactness:* System F writes both as application.
  3. *Family and grade invariants:* one family with `apply`.
  4. *Ecological grid (provisional):* System F.
  5. *Mnemonic:* nothing new to learn.
  6. *Brevity:* five letters.

  *For:* no new word. *Against:* two constructs, one name.

- **C — The type written with `@`, as GHC.**

  1. *Non-collision:* collision: `@x` refinements and `@_n` places.
  2. *Scientific exactness:* exact.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Haskell.
  5. *Mnemonic:* known to Haskell readers.
  6. *Brevity:* one character.

  *For:* short. *Against:* `@` already carries two senses.


#### Q-LEM-114 — Folding and unfolding a recursive type, `fold v`, `unfold v`

**Fiche.**

- **Symbol:** `fold v`, `unfold v`
- **Rules:** Fold, Unfold
- **Register:** retained `fold` and `unfold` (« repliage », « dépliage »)
- **Overlaps:** layer 3's `fold` is BQN's Fold, a reduction: `[add fold div length]` (chapter 5)

**Object.** The two halves of an iso-recursive type: `fold` makes a value of the unfolded type a value of the recursive type, `unfold` exposes one step. Chapter 5 already writes `fold` for reduction in layer 3 (InPractice (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean)).

**Facts.**

- Isorecursive types « are distinct (and disjoint) types with special term constructs, usually called roll and unroll » (Wikipedia, recursive data type (https://en.wikipedia.org/wiki/Recursive_data_type)).
- BQN's Fold « applies 𝔽 between elements—always two at a time—of the list to yield a single result value » (BQN, Fold (https://mlochbaum.github.io/BQN/doc/fold.html)).

- **A — `fold` and `unfold`.**

  1. *Non-collision:* collision: layer 3's `fold`, a reduction.
  2. *Scientific exactness:* the recursion-schemes word.
  3. *Family and grade invariants:* a pair.
  4. *Ecological grid (provisional):* type theory.
  5. *Mnemonic:* known in two senses.
  6. *Brevity:* four and six letters.

  *For:* the register's words. *Against:* `fold` names two things.

- **B — `roll` and `unroll`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the iso-recursive word.
  3. *Family and grade invariants:* a pair.
  4. *Ecological grid (provisional):* type theory.
  5. *Mnemonic:* clear.
  6. *Brevity:* four and six letters.

  *For:* frees `fold` for reduction. *Against:* less known than fold.

- **C — No word: a recursive type's tags fold and `case` unfolds.** Values of a recursive type are built by their tags (`tag`, VOC-2026-11-03-011) and taken apart by `case`.

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* folding is hidden in the constructors.
  3. *Family and grade invariants:* one family with `tag` and `case`.
  4. *Ecological grid (provisional):* ML datatypes.
  5. *Mnemonic:* nothing to learn.
  6. *Brevity:* the shortest.

  *For:* no word. *Against:* the kernel still names the constructs in K and Lean.


#### Q-LEM-115 — Recursion, `fix v`

**Fiche.**

- **Symbol:** `fix v`
- **Rule:** the kernel's fixed point
- **Overlaps:** the register's `fold`, `unfold` and `out`

**Object.** The fixed point of a suspended computation, the source of general recursion in the kernel.

**Facts.**

- Haskell: « fix f is the least fixed point of the function f, i.e. the least defined x such that f x = x » (Haskell, Data.Function (https://hackage.haskell.org/package/base/docs/Data-Function.html)).
- Levy writes recursion `rec x. M`, which steps to `M[thunk rec x. M/x]` (Levy 2006 (https://pblevy.github.io/papers/hosc05.pdf)).

- **A — `fix`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the fixed point.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Haskell, PCF.
  5. *Mnemonic:* known.
  6. *Brevity:* three letters.

  *For:* the kernel's word. *Against:* opaque without the theory.

- **B — `rec`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* Levy's word.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Levy, OCaml's `let rec`.
  5. *Mnemonic:* says recursion.
  6. *Brevity:* three letters.

  *For:* reads as recursion. *Against:* an abbreviation.

- **C — No term word: a definition may call itself by its name.**

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* recursion through names.
  3. *Family and grade invariants:* definitions only.
  4. *Ecological grid (provisional):* most languages.
  5. *Mnemonic:* nothing to learn.
  6. *Brevity:* —

  *For:* no word. *Against:* anonymous recursion needs a name in K and Lean anyway.


#### Q-LEM-116 — Going through a vector, `iter_V v c`

**Fiche.**

- **Symbol:** `iter_V v c`
- **Rules:** VecI, VecE
- **Register:** none retained; « pli indexé gradué »
- **Overlaps:** the glyph alias `repeat` (`⍟`, « Applique une fonction n fois »); layer 3's `fold`; `vmap` (Q-LEM-121)

**Object.** The elimination of a vector: the body runs once per position, the context multiplied by the length, and « le parcourir compose n effets qui _ne sont pas les mêmes_ » (TypingRules (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)).

**Facts.**

- BQN: « Repeat (⍟) is a 2-modifier that applies its operand function 𝔽 multiple times » (BQN, Repeat (https://mlochbaum.github.io/BQN/doc/repeat.html)).

- **A — `iter`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the kernel's word.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Gödel's T, OCaml's `List.iter`.
  5. *Mnemonic:* known.
  6. *Brevity:* four letters.

  *For:* the kernel's word. *Against:* an abbreviation.

- **B — `each`.**

  1. *Non-collision:* near BQN's Each, a map without sequenced effects.
  2. *Scientific exactness:* says per element.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* BQN, Ruby.
  5. *Mnemonic:* clear.
  6. *Brevity:* four letters.

  *For:* readable. *Against:* suggests independence, where effects are composed in order.

- **C — `for`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* a loop over the positions.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* most languages.
  5. *Mnemonic:* immediate.
  6. *Brevity:* three letters.

  *For:* immediate. *Against:* an imperative word.

**Answer of the author — 2026-11-04 (VOC-2026-11-04-004), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** going through a vector is `iter` (option A).

### Time

#### Q-LEM-117 — The next step, `next v` and `delay c`

**Fiche.**

- **Symbols:** `next v` (value, `○V`), `delay c` (computation, `○C`)
- **Rules:** Nxt, Del
- **Register:** none retained; candidates `suivant`, `next`; « différer », to arbitrate « au temps 2 »
- **Overlaps:** `:defer` of the actor clause (lot 11)

**Object.** Chapter 3 ranks `next v` among values and keeps `delay c` among computations: « $`\mathsf{delay}\;c` reste un calcul, d'introduction du type ○C » (TermGrammar (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TermGrammar.lean)).

**Facts.**

- Temporal logic reads `X` as « NeXt Time » or « Tomorrow » (SEP, temporal logic (https://plato.stanford.edu/entries/logic-temporal/)).

- **A — `next` for the value, `delay` for the computation.**

  1. *Non-collision:* `delay` is Scheme's memoised promise.
  2. *Scientific exactness:* two objects, two words.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* temporal logic, Scheme.
  5. *Mnemonic:* clear.
  6. *Brevity:* four and five letters.

  *For:* the specification's words. *Against:* two words for one modality.

- **B — `next` for both.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* one modality, ○.
  3. *Family and grade invariants:* value and computation alike.
  4. *Ecological grid (provisional):* temporal logic.
  5. *Mnemonic:* one word.
  6. *Brevity:* four letters.

  *For:* one word per modality. *Against:* Q-LEM-001 asks two words for two objects.


#### Q-LEM-118 — Gap — `at` names two constructs

**Fiche.**

- **Constructs:** `at v`, the elimination of `□V` (rule Alw⁻); `at_n c`, running a computation at a place (rule At)
- **Register:** for Alw⁻: « Le mot actuel est une préposition, ce qui rompt la règle de forme des constructeurs »; for At: « localisation »
- **Recorded:** one word per construct (VOC-2026-11-03-001)

**Object.** The kernel writes `at v` (time: read at an instant a value available at every instant) and `at_n c` (place) (TermGrammar (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TermGrammar.lean)). Two objects under one word.

**Facts.**

- Temporal logic reads `G` as « It is always going to be the case that … » (SEP, temporal logic (https://plato.stanford.edu/entries/logic-temporal/)).

- **A — The place keeps `at`; the elimination of `□` takes another word (`sample`, a proposal).**

  1. *Non-collision:* removes the double use.
  2. *Scientific exactness:* `at` reads as a place.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* —

  *For:* `at` reads naturally for places. *Against:* a new word for time.

- **B — Time keeps `at`; the place takes another word (`on`, a proposal).**

  1. *Non-collision:* removes the double use.
  2. *Scientific exactness:* `at` reads as an instant.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* —

  *For:* the temporal family keeps its words. *Against:* a preposition still names a constructor.

- **C — No word for the elimination of `□`: a pattern of `unbind`.**

  1. *Non-collision:* removes the double use.
  2. *Scientific exactness:* `□V` gives its value now.
  3. *Family and grade invariants:* one decomposition form.
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* needs explaining.
  6. *Brevity:* short.

  *For:* no word. *Against:* the instant is implicit.


#### Q-LEM-119 — Waiting for an event, `when x = v in c`

**Answered before its withdrawal.** This record withdrew the question on 2026-11-04 without seeing that the author had answered it in the questionnaire the same morning (VOC-2026-11-04-005, below); the answer stands.

**Fiche.**

- **Symbol:** `when x = v in c`
- **Rule:** When
- **Neighbours:** `now v` introduces `◇V`; `wait v` turns `○◇V` into `◇V`
- **Recorded:** Q-LEM-101 asks whether events become a form of `catch`

**Object.** The value of an eventual guarantee is bound as soon as it arrives; the result stays eventual.

**Facts.**

- JavaScript: « The await operator is used to wait for a Promise and get its fulfillment value » (MDN, await (https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/await)).
- Temporal logic reads `F` as « It will (at some point in the Future) be the case that … » (SEP, temporal logic (https://plato.stanford.edu/entries/logic-temporal/)).

- **A — `when`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the specification's word.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* reads naturally.
  6. *Brevity:* four letters.

  *For:* the kernel's word. *Against:* a conjunction for a constructor.

- **B — `await`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* names the wait.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* JavaScript, Rust, C#.
  5. *Mnemonic:* known.
  6. *Brevity:* five letters.

  *For:* widely known. *Against:* suggests a promise, not a temporal modality.

- **C — A form of `catch` on an eventual value.**

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* wait, then branch on what arrives.
  3. *Family and grade invariants:* one matching family.
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* follows Q-LEM-101.
  6. *Brevity:* —

  *For:* your generalisation. *Against:* depends on Q-LEM-101.

**Answer of the author — 2026-11-04 (VOC-2026-11-04-005), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Reading:** waiting for an event is a form of `catch` on an eventual value (option C), with no word of its own, as VOC-2026-11-04-001 reads matching.
- **Put back to the author:** chapter 3's `when x = v in c` and `wait v` become forms of `catch`; whether the kernel keeps them as constructs is asked in lemma lot 3 (Q-LEM-217).

### Place

#### Q-LEM-120 — Places: `loc_n v` and `move_{n→m} v`

**Fiche.**

- **Symbols:** `loc_n v` (a value at a place, `@_n V`), `move_{n→m} v`
- **Rules:** Loc, Move
- **Register:** Loc: candidates « lieu », « localisée »; Move: retained « déplacement », « migration » rejected
- **Overlaps:** `at_n c` (Q-LEM-118); `@x` refinements

**Object.** A value labelled with its place, and its transport to a place that dominates it, paying the network.

**Facts.**

- Erlang's `spawn(Node, Fun)` starts a process on a named node: `spawn(Fun)` « Returns the process identifier of a new process started by the application of Fun to the empty list [] » (Erlang, erts (https://www.erlang.org/doc/apps/erts/erlang.html)).

- **A — `loc` and `move`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the kernel's words.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* short.

  *For:* the specification's words. *Against:* `loc` is an abbreviation.

- **B — `place` and `move`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* names the label.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* five letters.

  *For:* a full word. *Against:* `place` also reads as a verb.

- **C — `at` and `move`, if Q-LEM-118 gives `at` to places.**

  1. *Non-collision:* depends on Q-LEM-118.
  2. *Scientific exactness:* one word for the place of a value and of a computation.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* reads naturally.
  6. *Brevity:* two letters.

  *For:* one family for places. *Against:* two constructs under `at`.


### Concurrency and memory

#### Q-LEM-121 — Parallelism: `c ∥ c` and `vmap`

**Fiche.**

- **Symbols:** `c ∥ c`, `vmap v v`
- **Rules:** Par, Vmap
- **Register:** retained « mise en parallèle » and « application vectorisée »
- **Overlaps:** `iter` (Q-LEM-116)

**Object.** `c ∥ c` runs two computations without ordering their steps; `vmap` applies one function to every element of a vector, paying its depth once.

**Facts.**

- Haskell's `par`: « Indicates that it may be beneficial to evaluate the first argument in parallel with the second » (Haskell, Control.Parallel (https://hackage.haskell.org/package/parallel/docs/Control-Parallel.html)).
- JAX: « Vectorizing map. Creates a function which maps fun over argument axes » (JAX, vmap (https://docs.jax.dev/en/latest/_autosummary/jax.vmap.html)).

- **A — `par` and `vmap`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the kernel's words.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Haskell, JAX.
  5. *Mnemonic:* known.
  6. *Brevity:* short.

  *For:* the literature's words. *Against:* two abbreviations.

- **B — `par` and `each`.**

  1. *Non-collision:* near `iter` if Q-LEM-116 takes `each`.
  2. *Scientific exactness:* BQN's Each is a map.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* BQN.
  5. *Mnemonic:* clear.
  6. *Brevity:* short.

  *For:* readable. *Against:* does not say parallel.

- **C — `both` and `vmap`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* says two at once.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* four letters.

  *For:* plain English. *Against:* binary only.


#### Q-LEM-122 — Actors: `spawn c`, `new_E`, `send m(v) to v`

**Fiche.**

- **Symbols:** `spawn c`, `new_E`, `send m(v̄) to v`
- **Rules:** Spawn, New, Send
- **Register:** retained « engendrement », « création de boîte », « émission »
- **Overlaps:** codata reads an observation as sending a message (Q-LEM-106); `guard` may become a `catch` (Q-LEM-101)

**Object.** Starting a task its parent does not wait for; creating an empty mailbox whose pattern says what it accepts; dropping a message in a mailbox without waiting for it to be read.

**Facts.**

- Erlang: `spawn(Fun)` « Returns the process identifier of a new process started by the application of Fun to the empty list [] » (Erlang, erts (https://www.erlang.org/doc/apps/erts/erlang.html)); `Expr1 ! Expr2` « Sends the value of Expr2 as a message to the process specified by Expr1 » (Erlang, expressions (https://www.erlang.org/doc/system/expressions.html)).

- **A — `spawn`, `new`, `send`.**

  1. *Non-collision:* `new` is generic.
  2. *Scientific exactness:* the kernel's words.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Erlang.
  5. *Mnemonic:* known.
  6. *Brevity:* short.

  *For:* the specification's words. *Against:* `new` says nothing of a mailbox.

- **B — `spawn`, `mailbox`, `send`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* names what is created.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Erlang's vocabulary.
  5. *Mnemonic:* clear.
  6. *Brevity:* seven letters.

  *For:* says what it creates. *Against:* a noun for an act.

**Answer of the author — 2026-11-04 (VOC-2026-11-04-006), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** If the actor is self-healing (auto recovery on its own failure, eg. for the main orchestrator) then it shall be considered evil `daemon`. Asking for such evil shall be done with `summon`. If you prefer a friendly and peacefull actor then you shall `invoke` it instead.
- **Justification:** mailbox and co. seems to suggest other meenings
- **Reading:** an ordinary actor is started by `invoke`; an actor that heals itself, recovering from its own failure as the main orchestrator does, is a `daemon`, and is started by `summon`. `mailbox` is set aside, as suggesting other meanings. Creating a mailbox (`new_E`) and sending (`send`) are not answered.
- **Put back to the author:** chapter 3 writes « `perform` et `handle` sont deux actions, invoquer et traiter », and Q-LEM-111 asks the word for invoking an operation: `invoke` would name starting an actor and, in the prose, calling an operation. What creates a mailbox and what sends are left without a word; lemma lot 3 asks what produces what a catch catches (Q-LEM-215) and how a program connects to its flows (Q-LEM-218).

#### Q-LEM-123 — Memory: `free v` and `slice v as (x,y) in c`

**Fiche.**

- **Symbols:** `free v`, `slice v as (x,y) in c`
- **Rules:** Free, Slice
- **Register:** Free: retained « libération », « fermeture » rejected; Slice: « découpe », provisional
- **Recorded:** taking a pair apart is `unbind` (VOC-2026-11-03-010)

**Object.** `free` destroys a mailbox or a resource once exhausted; `slice` consumes a write capability on a segment and gives two on disjoint segments.

**Facts.**

- Rust: `std::mem::drop` « Disposes of a value » (Rust, drop (https://doc.rust-lang.org/std/mem/fn.drop.html)); `split_at_mut` « Divides one mutable slice into two at an index » (Rust, slice (https://doc.rust-lang.org/std/primitive.slice.html)).

- **A — `free` and `slice`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the kernel's words.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* C's `free`.
  5. *Mnemonic:* known.
  6. *Brevity:* short.

  *For:* the specification's words. *Against:* `free` suggests manual memory management.

- **B — `drop` and `split`.**

  1. *Non-collision:* `split` was weighed for pairs in lot 1.
  2. *Scientific exactness:* Rust's words.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Rust.
  5. *Mnemonic:* known.
  6. *Brevity:* short.

  *For:* Rust's vocabulary for the same discipline. *Against:* `split` also splits sequences.

- **C — `release` and `slice`.**

  1. *Non-collision:* near the « delimited release » of declassification (Q-LEM-124).
  2. *Scientific exactness:* says a resource is given back.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* seven letters.

  *For:* no manual-memory sense. *Against:* longer.


### Confidentiality

#### Q-LEM-124 — Lowering a level, `declassify_ℓ(v)`

**Fiche.**

- **Symbol:** `declassify_ℓ(v)`
- **Rule:** Declassify
- **Register:** retained « déclassification », « le terme de Sabelfeld et Myers »

**Object.** An escape hatch, closed and named in advance, that lowers the confidentiality level of a value; chapter 2 bounds what it may release by « la divulgation délimitée » (AdjunctionsAndEnrichment (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C2/AdjunctionsAndEnrichment.lean)).

**Facts.**

- Chapter 2 cites Sabelfeld and Myers, « A Model for Delimited Information Release » (2004), for the laundering attack and delimited release.

- **A — `declassify`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* the literature's word.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* information-flow languages.
  5. *Mnemonic:* known.
  6. *Brevity:* ten letters.

  *For:* the specification's word. *Against:* long.

- **B — `release`.**

  1. *Non-collision:* near Q-LEM-123 C.
  2. *Scientific exactness:* the « delimited release » of the cited model.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* seven letters.

  *For:* names what the guarantee bounds. *Against:* says nothing of the level.

- **C — `downgrade`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* names the lowering.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* nine letters.

  *For:* plain. *Against:* not the literature's word.

## Lemma lot 3 of 2026-11-04: pattern matching, control flow, joins and reactivity

Opened on 2026-11-04 at the author's request: « On va, ensemble, trancher tout ce qui concerne le pattern
matching, le control flow, le joint pattern, le reactive etc. puisque c'est l'un des focus important de K7PL.
Cela nous permettera d'en délimiter la discipline et de pouvoir en déduire les besoins réels connexes. » The
page shows this lot with the questions of lemma lot 2 that bear on it, unchanged and kept under lot 2 below
(Q-LEM-103, Q-LEM-111, Q-LEM-115, Q-LEM-105, Q-LEM-106, Q-LEM-121, Q-LEM-117, Q-LEM-118); the other unanswered questions of lot 2 are set aside on the page until this lot is answered
(Q-LEM-104, Q-LEM-112, Q-LEM-113, Q-LEM-114, Q-LEM-120, Q-LEM-123, Q-LEM-124). The research behind the lot is in [research](research.md), « Reading lot: research of
2026-11-04, pattern matching, control flow, joins and reactivity ». **Other** and **Clarify** are always
available.

Third lot of lemmas, asked on 2026-11-04: settle together everything about pattern matching, control flow, join patterns and reactivity, one of K7PL's main focuses, to delimit the discipline and deduce the real needs around it. It starts from what is recorded: every construction is a pattern, `@x` is every pattern of `x`, what is caught carries the refined type of its construction, and a pattern compiles into an automaton put in production by an actor or an orchestrator; `case` sets conditions on what was caught, as SQL's `CASE` (VOC-2026-11-04-001, -002); `catch` and `try … catch` are one object (VOC-2026-11-03-017); there is no conditional form (VOC-2026-11-03-016); waiting for an event is a form of `catch` (VOC-2026-11-04-005). It also starts from what the specification already writes: chapter 3's `guard` with conjunctive patterns, its algebra of mailbox patterns and their residual; chapter 4's join patterns, mailboxes, R-expression classes and Kahn sub-networks. The questions of lemma lot 2 that bear on the subject are asked again here, unchanged; its other unanswered questions are set aside until this lot is answered. Options that choose a word are weighed on the six criteria of Q-METH-001 in their order; options that choose a behaviour carry what is for and against them. An answer is a dated preference, ratified only in the global lot (VOC-2026-10-26-002). Every word of the examples other than the one asked is a placeholder.

### The pattern

#### Q-LEM-201 — How a pattern names what it catches

**Fiche.**

- **Now in the specification:** chapter 5's handler binds with bare names: `((Increment n) …)`, `((Ok new-value) …)`
- **Recorded:** `@` belongs to patterns and `@name` defines a pattern (VOC-2026-10-27-076); `@x` is every pattern of `x` (VOC-2026-11-04-002); a label is never binding (chapter 5)
- **Overlaps:** TXR's `@name` binds a variable

**Object.** A pattern catches a whole and often parts of it that the clause then uses: something must say which parts are named. Chapter 5 already closes the trap for labels: without its rule « une étiquette mal orthographiée serait une variable fraîche, donc un motif qui filtre tout et ne signale rien » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)).

**Facts.**

- Chapter 5: « `@` appartient aux motifs, et tout est motif […] : `@` placé devant une construction capture ce motif et en hérite toute la construction, précisée — ce qu'il capture reçoit un type raffiné de cette construction » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)).
- TXR: « Query material which is not escaped by the special character @ is literal text, which matches input character for character » (TXR manual (https://man.uex.se/1/txr)); a TXR variable is written `@name`.
- Python: « Capture patterns take on the form of a name that accepts any value and binds it to a (local) variable », and « any dotted name (i.e., attribute access) is to be interpreted as a value pattern » (PEP 635 (https://peps.python.org/pep-0635/)).
- OCaml: « Patterns are linear: a variable cannot be bound several times by a given pattern » (OCaml manual, patterns (https://ocaml.org/manual/5.3/patterns.html)).

- **A — A bare name binds; `@` marks the pattern.** Inside a pattern, a declared construction or tag is matched and any other name binds. Chapter 5's rule on labels extends to tags: an undeclared tag in a pattern is an error, not a fresh variable. Example: `(catch inbox (@(Increment n) (add n)))`.
  *For:* the specification's listings already read so; ML, Python. *Against:* what binds is not visible; it rests on every tag being declared.

- **B — `@name` binds inside a pattern, as TXR.** A bare name inside a pattern is a declared construction or a value; `@n` binds. Example: `(catch inbox ((Increment @n) (add n)))`.
  *For:* what binds is visible; a misspelled bare name is an unknown construction, an error. *Against:* `@name` also defines a pattern and `@x` catches every pattern of `x`: `@n` would bind when `n` is fresh and catch when `n` names a construction, one sign read two ways by what is declared.

- **C — Patterns never bind; what was caught is named after the pattern.** `@x` catches; the caught value is named once, after the pattern, and its parts are taken by `unbind` (VOC-2026-11-03-010). Example: `(catch inbox (@Increment :as m (unbind [(Increment n) m] (add n))))`.
  *For:* one meaning for `@`; a pattern is only a pattern. *Against:* every part costs a second step.


#### Q-LEM-202 — Matching a value already known

**Object.** A clause may need to catch only the reply whose identifier equals one already held, the `id` of a request sent earlier. If a bare name binds (Q-LEM-201 A), a bare `id` would catch every identifier.

**Facts.**

- Elixir's pin operator `^` is used to « pattern match against a variable's existing value rather than rebinding the variable » (Elixir, pattern matching (https://elixir.hexdocs.pm/pattern-matching.html)).
- Python reads dotted names as values, which « precludes, in particular, local variables and global variables defined in the current module from acting as constants » (PEP 635 (https://peps.python.org/pep-0635/)).
- OCaml: « Patterns are linear: a variable cannot be bound several times by a given pattern » (OCaml manual, patterns (https://ocaml.org/manual/5.3/patterns.html)).

- **A — A mark compares with the value held, as Elixir's `^`.** The sign is chosen with the glyphs, once every lemma is fixed (VOC-2026-11-03-018). Example: `(catch inbox (@(Reply ^id body) (use body)))`.
  *For:* the comparison is in the pattern, so the automaton tests it and leaves other replies in place. *Against:* one more sign in patterns.

- **B — The comparison goes in the `case` conditions.** Example: `(catch inbox (@(Reply other body) (case [= other id] (use body))))`.
  *For:* no new sign; SQL's reading of `case` (VOC-2026-11-04-002). *Against:* the reply is caught before its condition is tested: on a mailbox, a failed condition must give it back (Q-LEM-210).

- **C — A name already bound compares, a name used twice means equal.** Non-linear patterns, as Prolog and Erlang. Example: `(catch inbox (@(Reply id body) (use body)))`.
  *For:* nothing to write. *Against:* OCaml forbids it; a name that happens to be bound turns a binder into a test silently.

**Answer of the author — 2026-11-06 (VOC-2026-11-06-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Je pense que le symbole `^` n'est pas pertinent mais que l'approche d'elixir est intéressante. Il manque par contre de pouvoir faire des motifs à trous (comme like avec des wildcards en SQL)
- **Reading:** a value already held is compared inside the pattern, as Elixir does (option A), but `^` is not the sign for it. A need is added: patterns with holes, as the wildcards of SQL's `LIKE`.
- **Put back to the author:** dossier 1 proposes to mark the holes rather than the value held, so that no sign such as `^` is needed, and to write the holes of a text in a qualified literal (Q-FRM-003).

#### Q-LEM-203 — Naming the whole and its parts

**Fiche.**

- **Overlaps:** Rust and Haskell write the alias with `@`, which K7PL gives to patterns

**Object.** A clause may use a part and the whole it caught, the whole to forward it and a part to decide.

**Facts.**

- OCaml: « The pattern pattern1 as value-name matches the same values as pattern1 » (OCaml manual, patterns (https://ocaml.org/manual/5.3/patterns.html)).
- Rust: « To bind the matched value of a pattern to a variable, use the syntax `variable @ subpattern` » (Rust reference, patterns (https://doc.rust-lang.org/reference/patterns.html)).

- **A — `:as`, a property after the pattern.** Example: `(catch inbox (@(Order id lines) :as order (forward order)))`.

  1. *Non-collision:* no collision: a property, like `:sets`.
  2. *Scientific exactness:* names the whole caught.
  3. *Family and grade invariants:* the property family of K7PL.
  4. *Ecological grid (provisional):* OCaml's `as`.
  5. *Mnemonic:* reads « as order ».
  6. *Brevity:* three characters.

  *For:* K7PL's property syntax. *Against:* outside the pattern, so not usable on a part.

- **B — `as` inside the pattern, as OCaml.** Example: `(catch inbox (@((Order id lines) as order) (forward order)))`.

  1. *Non-collision:* `as` is the kernel's binder in `unbox v as x in c`.
  2. *Scientific exactness:* OCaml's alias.
  3. *Family and grade invariants:* usable on any part.
  4. *Ecological grid (provisional):* OCaml.
  5. *Mnemonic:* known.
  6. *Brevity:* two letters.

  *For:* an alias at any depth. *Against:* `as` already reads in chapter 3's `… as x in c`.

- **C — No alias: the whole is caught, its parts taken by `unbind`.** Example: `(catch inbox (@Order :as order (unbind [(Order id lines) order] …)))`.

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* two steps.
  3. *Family and grade invariants:* `unbind` reverses `bind`.
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* —
  6. *Brevity:* longer.

  *For:* no word. *Against:* verbose for a frequent need.

**Answer of the author — 2026-11-06 (VOC-2026-11-06-002), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

#### Q-LEM-204 — Alternatives and conjunctions in one pattern

**Fiche.**

- **Now in the specification:** chapter 3's guard patterns `p ::= m(x̄) | p & p`, `&` joining messages
- **Overlaps:** R-expressions already have alternation; SQL's row patterns write `|`

**Object.** A pattern may accept one of several shapes, or require several at once. On one value, « both » means the value matches both; on a mailbox, chapter 3 reads `&` as « every message present ».

**Facts.**

- OCaml: « The pattern pattern1 | pattern2 represents the logical "or" of the two patterns pattern1 and pattern2 » (OCaml manual, patterns (https://ocaml.org/manual/5.3/patterns.html)); Rust refuses `p | q` when « the same set of bindings are not introduced in `p` and `q` » (Rust reference, patterns (https://doc.rust-lang.org/reference/patterns.html)).
- F# combines two active patterns on one value with `&`: `| Cube x & Square _ ->` (F#, active patterns (https://learn.microsoft.com/en-us/dotnet/fsharp/language-reference/active-patterns)).
- Chapter 3, rule Guard: each branch carries a conjunctive pattern `m1(x1) & … & mk(xk)`; « La branche ne s'ouvre que si tous les messages du motif sont présents, et les consomme d'un seul tenant » (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)).

- **A — `|` and `&`, `&` meaning every part present, on a value as on a mailbox.** Example: `(catch inbox (@(Done r) | @(Cancelled r) (close r)) (@(Ping) & @(Tick) (pong)))`.
  *For:* one sign for conjunctions and joins, as F# on values and chapter 3 on messages. *Against:* on a mailbox `&` consumes several messages, on a value it tests one twice: the cost differs.

- **B — `|` only; `&` kept for joins of messages.**
  *For:* `&` keeps one reading, the join. *Against:* two refinements of one value are combined in `case`.

- **C — No alternative inside a pattern: one clause per shape; `&` for joins.**
  *For:* each clause one shape; the automaton is simpler. *Against:* a shared transformation is repeated.

**Answer of the author — 2026-11-06 (VOC-2026-11-06-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** En fait il manque les constructeurs logiques `or, nor, xor, xnor, and, nand, xand, xnand`, associés à catch et case nous devrions avoirs tous les constructeurs logiques suffisants.
- **Reading:** the logical constructors are missing: `or`, `nor`, `xor`, `xnor`, `and`, `nand`, `xand`, `xnand`; with the reading of a flow and `case`, they should be all the logical constructors needed.
- **Put back to the author:** `xand` and `xnand` have no agreed truth table: XAND is listed as another name of XNOR. Which functions are meant? Dossier 1 separates the connectives on one element from the join between elements (Q-FRM-004).

#### Q-LEM-205 — A pattern that computes

**Fiche.**

- **Recorded:** `@name` defines a pattern (VOC-2026-10-27-076)
- **Now in the specification:** R-expressions carry one of four automaton classes (chapter 4)

**Object.** A defined pattern may be structural (shapes and refinements, compiled into the automaton) or may compute (« parses as an integer », « is even »), calling a function.

**Facts.**

- F#: « Active patterns enable you to define named partitions that subdivide input data, so that you can use these names in a pattern matching expression just as you would for a discriminated union »; « Active patterns that do not always produce a value are called partial active patterns; they have a return value that is an option type » (F#, active patterns (https://learn.microsoft.com/en-us/dotnet/fsharp/language-reference/active-patterns)).
- Chapter 4: « Les R-expressions unifient sous une seule interface, `(match ...)`, le filtrage structurel, PCRE, PEG et les grammaires ; leur compilation ne masque jamais la complexité qu'un motif engage, elle l'expose » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/LocalScale.lean)).

- **A — Structural only: what computes goes in `case`.**
  *For:* a pattern's class, hence its cost, is known from its text. *Against:* a computed view of data (F#'s RGB and HSB views of one colour) is written as a condition.

- **B — A defined pattern may call a layer 3 function returning an option.** As F#'s partial active patterns. The function is pure and terminating; its budget adds to the pattern's class and is checked as chapter 6 checks the annotations. Example: `{def @integer [parse-int]}   (catch line (@(integer n) (add n)))`.
  *For:* several views of the same data; the automaton calls the function as an atomic operator. *Against:* the class alone no longer tells the whole cost.

**Answer of the author — 2026-11-05 (VOC-2026-11-05-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** Quand on attrape un pattern pour en faire quelque chose, c'est un traitement parallèle à l'action initiée par le flux, ce qui signifie qu'un envoi d'une matrice de pixels colorés vers un affichage s'affiche et qu'on peut apporter un traitement parallèle suivant des conditions attrapées en vol. Cela n'empêche donc pas la computation du flux et le cas permet la computation déclenchée par le pattern.
- **Reading:** structural only (option A): what computes goes in `case`. Catching a pattern is a processing parallel to the action the flow starts: a matrix of coloured pixels sent to a display is displayed, and a parallel processing is brought on conditions caught in flight. Catching does not prevent the flow's own computation; the case allows the computation the pattern triggers.
- **Put back to the author:** chapter 3's `guard` consumes the messages it matches, and `free` asks for an empty mailbox. Dossier 1 proposes that the flow's usage grade decide whether a case observes or takes (Q-FRM-002).

#### Q-LEM-206 — The automaton class when none is written

**Fiche.**

- **Now in the specification:** `@linear` (DFA), `@polynomial` (NFA), `@stack` (pushdown, depth a grade), `@backtrack` (exponential)

**Object.** Chapter 4 annotates every R-expression constructor; nothing says what holds when the program writes none.

**Facts.**

- Chapter 4: « Le vérificateur de complexité (chapitre 6) rejette toute structure non linéaire apparaissant dans un contexte annoté `@linear` » ; « c'est une preuve d'admissibilité, qui prévient structurellement le déni de service par expression régulière » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/LocalScale.lean)).
- Maranget: « The primary advantage of decision trees is that they never test a given subterm of the subject value more than once (and their primary drawback is potential code size explosion) » (Maranget 2008 (https://www.cs.tufts.edu/~nr/cs257/archive/luc-maranget/good-trees08.pdf)).

- **A — `@linear` by default; more must be written.**
  *For:* real time is the default; a costlier pattern says so in the text. *Against:* back-references and nesting always need an annotation.

- **B — Inferred: the least class that compiles it, shown by the language server.**
  *For:* nothing to write; the annotation is written only to require a bound. *Against:* a small change can raise a pattern's class without the text showing it.

- **C — Inferred, but `@linear` required on a flow from outside.**
  *For:* what comes from the network, files or processes is guarded; inside, nothing to write. *Against:* two rules, by where the flow comes from.

**Answer of the author — 2026-11-05 (VOC-2026-11-05-002), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** Pour moi la class ne doit pas être déclarée car il s'agit d'un effet de couche d'une part et d'algorithme d'autre part. donc inférence systématique
- **Reading:** inferred, always (option B): the class is not declared, since it is an effect of the layer on one hand and of the algorithm on the other.

### Clauses: writing, order, coverage

#### Q-LEM-207 — How a catch and its cases are written

**Fiche.**

- **Recorded:** your sketches (VOC-2026-11-03-015); `case` sets conditions on what was caught, as SQL's `CASE` (VOC-2026-11-04-002)
- **Replaces:** Q-LEM-102, withdrawn on 2026-11-04

**Object.** A catch has three parts: what it watches (a value, a computation, a mailbox, a flow), its patterns, and for each pattern the conditions and the transformations.

**Facts.**

- PostgreSQL: `CASE WHEN condition THEN result [WHEN ...] [ELSE result] END` (PostgreSQL, conditional expressions (https://www.postgresql.org/docs/current/functions-conditional.html)).
- Python: « guards are only supported on the level of case clauses and not for individual patterns » (PEP 635 (https://peps.python.org/pep-0635/)).
- Erlang: « The patterns in the clauses are matched against a message from top to bottom »; « The first message from the start of the message queue that matches will be selected »; « All other messages in the message queue remain unchanged » (Erlang, expressions (https://www.erlang.org/doc/system/expressions.html)).

- **A — `catch` heads; a clause per pattern; `case` inside a clause for its conditions.** Example: `(catch inbox
  (@(Increment n) (case [< n 0] (refuse n) else (add n)))
  (@(Reset) (reset)))`.
  *For:* patterns and conditions on two levels, each with one role. *Against:* two levels of nesting for a simple clause with a condition.

- **B — `catch` heads; each clause a pattern, an optional `case` condition, a transformation.** Example: `(catch inbox
  @(Increment n) case [< n 0] (refuse n)
  @(Increment n) (add n)
  @(Reset) (reset))`.
  *For:* flat, as Python's guarded clauses. *Against:* a pattern is repeated for each condition.

- **C — `case` heads with one catch as its subject; several patterns, several catches.** Your second sketch, `case` keeping SQL's role. Example: `(case (catch inbox @(Increment n))
  [< n 0] (refuse n)
  else (add n))`.
  *For:* reads as SQL's `CASE` on what was caught. *Against:* a mailbox watched for several patterns needs one catch per pattern, or a pattern with `|`.


#### Q-LEM-208 — Which clause wins

**Object.** When what arrives matches several clauses, or several automata read the same flow.

**Facts.**

- Maranget on ML: « the matched rule is unique, thanks to the textual priority scheme » (Maranget 2008 (https://www.cs.tufts.edu/~nr/cs257/archive/luc-maranget/good-trees08.pdf)).
- AWK: « An awk program is composed of pairs of the form: pattern { action } »; « When input is read that matches a pattern, the action associated with that pattern is carried out » (POSIX, awk (https://pubs.opengroup.org/onlinepubs/9799919799/utilities/awk.html)); every pair is tried on every record.
- Erlang: « The patterns in the clauses are matched against a message from top to bottom »; « The first message from the start of the message queue that matches will be selected »; « All other messages in the message queue remain unchanged » (Erlang, expressions (https://www.erlang.org/doc/system/expressions.html)).
- Chapter 4: « la boîte n'a qu'un consommateur, l'acteur qui la détient » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)).

- **A — The first that matches, top to bottom.**
  *For:* ML, Erlang; the order of the text is the priority. *Against:* a clause can hide a later one.

- **B — Every clause that matches runs, as AWK.**
  *For:* data-flow: one record feeds every rule that wants it. *Against:* the order of the runs must be fixed, and on a mailbox only one clause may consume.

- **C — The first within a catch; every automaton fed by a flow receives it.** Two levels: inside one catch, the text's order; between the automata a flow is wired to, each receives the element and picks its own first clause.
  *For:* data-flow routing between automata, ML's priority inside one. *Against:* a mailbox has one consumer: a flow read by two automata needs an explicit fan-out, a copy or an unrestricted grade.

- **D — The most specific, whatever the order.** A clause whose refinement is contained in another's wins.
  *For:* the order of the text does not matter. *Against:* two clauses neither of which contains the other need a rule; the solver must decide containment.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** All of them as AWK but the flow is rooted to automatas (eg. 1 flow and 3 patterns to catch with dedicated actions to run on them, the flow is divided and piped to 3 sub-automatas ; 1 flow and 1 pattern to catch but cached 3 times the flow is wired to a single automata with its mailbox until the mailbox is full and a new instance of the automata is rased to assure scalability)
- **Clarify:** Il serait intéressant d'évaluer si un pattent trouvé est passé avec un label pour faciliter son identification par l'automate suivant ou non
- **Reading:** every case that matches runs, as AWK, and the flow is routed to automata. One flow and three patterns, each with its action: the flow is divided and piped to three sub-automata. One flow and one pattern caught three times: the flow is wired to a single automaton with its mailbox, until the mailbox is full and a new instance of the automaton is raised, for scalability.
- **Put back to the author:** « cached 3 times » is read as « caught three times »; to confirm. The label asked for is weighed in dossier 1 (Q-FRM-006), with the bound on instances that P3 asks for.

#### Q-LEM-209 — Coverage

**Object.** Must the clauses of a catch cover everything its subject may be?

**Facts.**

- The glossary defines a join pattern as « Règle qui ne se déclenche qu'à l'arrivée d'une combinaison de messages, et dont la couverture de toutes les combinaisons se vérifie statiquement » (glossary (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/Refs/GlossList.lean)); Annex A lists among rejections « Combinaison de messages non couverte par un motif de jonction » (Annex A (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/AnnexA/ProtocolsSessionsAndDistributedTopology.lean)).
- Chapter 4: « Dans le profil qui adopte la couverture exhaustive, les combinaisons admissibles non couvertes sont à rejeter en compilation » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)).
- Annex A: « Singularité non gérée : la division renvoie `Result<Float64, Singularity>`, exigeant un filtrage exhaustif en couche 2 » (Annex A (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/AnnexA/ValueConstraintsAndResidualProofs.lean)).

- **A — Always required; a default clause covers the rest.** A clause that can never be reached gives a warning.
  *For:* nothing unforeseen; the glossary and Annex A as written. *Against:* a prototype must write its default clauses.

- **B — Required in a profile that adopts it, a warning elsewhere.** As chapter 4 writes it; warnings never block compilation unless a flag asks (VOC-2026-10-27-077).
  *For:* prototyping stays light. *Against:* a program's meaning on unforeseen input depends on its profile.

- **C — A warning only.**
  *For:* nothing blocks. *Against:* contradicts the glossary and Annex A, which reject.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-002), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** Je pense que nous pouvons adopter A de manière graduée pour faciliter le prototypage et donc proposer un hybride entre A et B.
- **Reading:** option A, graduated to ease prototyping: a hybrid of A (always required) and B (required in a profile, a warning elsewhere).
- **Put back to the author:** how to graduate: by the layer and the usage grade, by a flag, or both (Q-FRM-008).

#### Q-LEM-210 — What no clause catches, on a mailbox or a flow

**Object.** On a value, coverage settles it. On a mailbox or a flow, a message may arrive that no clause catches at that moment.

**Facts.**

- Erlang: « The patterns in the clauses are matched against a message from top to bottom »; « The first message from the start of the message queue that matches will be selected »; « All other messages in the message queue remain unchanged » (Erlang, expressions (https://www.erlang.org/doc/system/expressions.html)).
- Chapter 3, rule Free: `free` requires an empty mailbox, so that « un acteur ne peut pas disparaître en laissant des messages non lus »; rule Guard requires the mailbox type `E` to be the sum of the branches' patterns, `E = Σ P_i · E_i` (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)).

- **A — It cannot arrive: the mailbox's type says what may come, and the catch covers it.** As chapter 3's Guard. What comes from outside is typed at the boundary: what fails its type arrives as an error value, itself caught.
  *For:* no hidden queue; the type says everything. *Against:* the boundary actor must type the outside world completely.

- **B — It stays for a later catch, as Erlang.**
  *For:* a catch waits for what it wants without losing the rest. *Against:* a mailbox can grow with messages nobody catches; `free` then refuses it.

- **C — It goes to a flow of letters nobody caught, journaled, which another automaton may catch.**
  *For:* nothing is lost and nothing piles up. *Against:* one more flow per actor to wire.


#### Q-LEM-211 — The type seen by the following clauses

**Object.** What a clause catches carries the refined type of its construction (VOC-2026-11-04-001). The question is what the next clauses, and the default, see.

**Facts.**

- Typed Racket's occurrence typing « allows the type system to ascribe more precise types based on whether a predicate check succeeds or fails » (Typed Racket guide (https://docs.racket-lang.org/ts-guide/occurrence-typing.html)).
- Chapter 3: the residual `E / m` « donne le motif restant après consommation d'un message » and makes a mailbox « un objet à état typé plutôt qu'un sac » (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)).

- **A — The remainder: each following clause sees the type minus what earlier ones caught.**
  *For:* the default knows what it receives; the same idea as chapter 3's residual. *Against:* the solver computes a difference of refinements at each clause.

- **B — The declared type: only the catching clause gets a refinement.**
  *For:* simpler to check. *Against:* the default must test again what it could know.


#### Q-LEM-212 — `case` after a catch: order and default

**Fiche.**

- **Recorded:** `case` sets conditions on what was caught, as SQL's `CASE` (VOC-2026-11-04-002)

**Object.** How the conditions of a `case` are tried, and what holds when none is true.

**Facts.**

- PostgreSQL: « If the condition's result is not true, any subsequent `WHEN` clauses are examined in the same manner »; « If no `WHEN` condition yields true, the value of the `CASE` expression is the result of the `ELSE` clause »; « If the `ELSE` clause is omitted and no condition is true, the result is null » (PostgreSQL, conditional expressions (https://www.postgresql.org/docs/current/functions-conditional.html)).
- Python: « The wildcard pattern is a special case of a ‘capture’ pattern: it accepts any value, but does not bind it to a variable » (PEP 635 (https://peps.python.org/pep-0635/)).

- **A — In order, the first true wins; `else` gives the default, as SQL.** Without `else`, the conditions must cover (Q-LEM-209): there is no null. Example: `(case [< n 0] (refuse n) [= n 0] (ignore) else (add n))`.
  *For:* SQL's reading, the word you named. *Against:* order matters, as in any first-match.

- **B — In order; `_` is the default condition, as ML's wildcard.** Example: `(case [< n 0] (refuse n) _ (add n))`.
  *For:* one sign for « anything » in patterns and conditions. *Against:* less readable than a word.

- **C — Unordered: the conditions must be disjoint, proved by the solver; `else` optional.**
  *For:* no hidden priority; each condition reads alone. *Against:* the solver must prove disjointness, which can fail on conditions it cannot decide.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:**

  > (case <pattern> <computation>)
  > (case <pattern> <computation>)
  > (case <pattern> <computation>)
  >
  > Si le pattern n'est pas trouvé alors il ne se passe rien, si l'inverse est recherché alors :
  > (case <not-pattern> <computation>)

- **Reading:** a `case` takes a pattern and a computation, `(case <pattern> <computation>)`, and cases follow one another. When a pattern is not found nothing happens; there is no default. The reverse is asked by a pattern that negates: `(case <not-pattern> <computation>)`.
- **Put back to the author:** with no default and no order, coverage and the reverse rest on `not`; on a linear flow, chapter 3's Guard asks that the cases cover (Q-FRM-002, Q-FRM-008).

### Control flow without a conditional

#### Q-LEM-213 — `choose` and `select` in layer 3

**Fiche.**

- **Recorded:** no conditional form; `cond` leaves (VOC-2026-11-03-016); put back: how this reads with `choose` and `select`

**Object.** Layer 3 has two words that pick among branches without being a conditional form.

**Facts.**

- Chapter 5: « `choose` prend à sa gauche la condition et à sa droite la liste des branches, dont il n'évalue que celle que la condition désigne » ; « Chacun dit ainsi son coût, `choose` n'évaluant qu'une branche et `select` les deux » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean)).

- **A — Both stay: `choose` indexes a list of branches, `select` applies a mask.**
  *For:* no branching syntax: an index and a mask; the cost is in the word. *Against:* `choose` with a boolean reads as a conditional.

- **B — `choose` goes, layer 3 branching by `catch` and `case`; `select` stays.**
  *For:* one way to branch; `select` does not branch. *Against:* layer 3 gets the full matching machinery.

- **C — Both go: `case` on values, mapped over a vector for masks.**
  *For:* one family. *Against:* loses the vector `select` without branching of chapter 1.

**Answer of the author — 2026-11-05 (VOC-2026-11-05-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** je pense que nous pouvons tout de même trouver comment assurer le branching.
- **Reading:** both go (option C): `choose` and `select` leave layer 3, and branching is to be found again with `case`.
- **Put back to the author:** layer-3 words are monadic or dyadic (VOC-2026-10-28-033); `case` takes two operands, but several cases are an n-ary form. Three ways are weighed in dossier 1 (Q-FRM-005).

#### Q-LEM-214 — Chaining catches

**Object.** Several steps, each of which may fail: parse, then check, then store. Without a conditional, the chain must stop at the first failure and give it back.

**Facts.**

- Elixir's `with`: « Combine matching clauses. »; « `<-` will simply abort the `with` chain and return the non-matched value. » (Elixir, special forms (https://elixir.hexdocs.pm/Kernel.SpecialForms.html)).

- **A — A refutable pattern in `bind`: the first value that fails is the result.** Example: `(bind [@(Ok a) (parse x)] [@(Ok b) (check a)] (store b))`.
  *For:* no word; `bind` is the sequence (VOC-2026-11-03-006). *Against:* `bind` then branches, which a reader may not expect.

- **B — A word for the chain, as Elixir's `with`.**
  *For:* the chain is named. *Against:* `with` is a candidate for the negative product (Q-LEM-105).

- **C — Nested catches only.**
  *For:* nothing new. *Against:* depth grows with each step.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-004), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

#### Q-LEM-215 — What produces what a catch catches

**Fiche.**

- **Now in the specification:** `send m(v̄) to v` (messages), `operation_ε(v)` (operations, surface `perform`), failures caught by `try c catch h`
- **Recorded:** `catch` gathers every kind (VOC-2026-11-04-001)

**Object.** If one `catch` catches failures, operations, messages and events, the question is whether what produces them is one word or several.

**Facts.**

- Esterel: « The “emit O” statement is instantaneous. It emits the signal O and terminates at the time it starts » (Esterel v5 primer (https://www.rw.cdl.uni-saarland.de/people/kaestner/private/es0203/esterel_primer.pdf)).
- OCaml 5 performs an operation with `perform` and ends a continuation without resuming it with `discontinue` (OCaml manual, effect handlers (https://ocaml.org/manual/5.3/effects.html)).
- Chapter 3: « l'émission ne bloque pas, la réception bloque » (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)).

- **A — One word for all, `emit`; the type says what is emitted and where.**
  *For:* the dual of one `catch` is one word. *Against:* waiting or not waiting (an operation resumes, a message does not) no longer shows in the text.

- **B — Two: `send` to a mailbox or flow, without waiting; `perform` to the enclosing catch.** A failure is an operation that is never resumed.
  *For:* the difference that costs (waiting or not) is in the word. *Against:* failures have no word of their own.

- **C — Three: `send`, `perform`, and a word for failures (`fail`, `raise` or `throw`).**
  *For:* each kind visible. *Against:* three words for what one `catch` gathers.


#### Q-LEM-216 — Resuming after a catch

**Object.** When a catch catches an operation, it receives the rest of the computation, the continuation, and may resume it. K7PL's grades can say how many times.

**Facts.**

- OCaml 5: « The handler uses the continue primitive to resume the suspended computation with the successor of the offered value »; « every captured continuation must be resumed either with a continue or discontinue exactly once »; « Hence, OCaml does not support multi-shot continuations. » (OCaml manual, effect handlers (https://ocaml.org/manual/5.3/effects.html)).

- **A — `continue` and `discontinue`, the continuation linear.**

  1. *Non-collision:* no loop `continue` in K7PL, which has no loops.
  2. *Scientific exactness:* OCaml's one-shot continuations.
  3. *Family and grade invariants:* a pair, positive and negative.
  4. *Ecological grid (provisional):* OCaml 5.
  5. *Mnemonic:* known.
  6. *Brevity:* eight and eleven letters.

  *For:* an established pair. *Against:* `continue` reads as a loop keyword in most languages.

- **B — `resume`, the continuation's grade saying how often (1, n, ω).**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* names the act.
  3. *Family and grade invariants:* the grade carries the count, as for any value.
  4. *Ecological grid (provisional):* —
  5. *Mnemonic:* clear.
  6. *Brevity:* six letters.

  *For:* one-shot by default, more when the grade says so. *Against:* ending without resuming needs a word.

- **C — No word: the continuation is a function, applied.**

  1. *Non-collision:* nothing new.
  2. *Scientific exactness:* a continuation is a function.
  3. *Family and grade invariants:* `apply` unwritten (VOC-2026-11-03-002).
  4. *Ecological grid (provisional):* effect calculi.
  5. *Mnemonic:* —
  6. *Brevity:* the shortest.

  *For:* nothing to learn. *Against:* resuming does not show in the text.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-005), given in the clickable questionnaire, quoted as given.**

- **Choice:** C
- **Justification:** Limité par le grade. En control flow l'objectif est de traiter le flux de donnée de manière productive (K7PL couche 2) donc d'attraper chaque patter survenant.
- **Reading:** no word (option C): the continuation is a function, applied, and its grade limits how often. In control flow the aim is to process the data flow productively, in layer 2, hence to catch each pattern that occurs.

#### Q-LEM-217 — One construct in the kernel, or three

**Fiche.**

- **Now in the specification:** chapter 3's rules Try (`try c catch h`), Guard (`guard v {p_i ↦ c_i}`) and the handlers of operations (`handle`)
- **Recorded:** `catch` and `try … catch` are one object (VOC-2026-11-03-017); `catch` gathers every kind (VOC-2026-11-04-001); one word per construct, everywhere (VOC-2026-11-03-001)

**Object.** Whether the surface `catch` is one construct of the kernel, or the name of three.

**Facts.**

- OCaml 5: « Similar to exception patterns in a match ... with expression, OCaml also supports effect patterns »: one `match` holds value, exception and effect cases (OCaml manual, effect handlers (https://ocaml.org/manual/5.3/effects.html)).
- Chapter 3: « `perform` et `handle` sont deux actions, invoquer et traiter » (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TermGrammar.lean)).

- **A — One construct and one rule, `catch`, replacing Try, Guard and the handlers.** What it watches (a computation, a mailbox, a flow) is its argument; its patterns say what they catch.
  *For:* the kernel says what the surface says. *Against:* the metatheory of three rules is rewritten as one: a proof obligation.

- **B — Three kernel constructs under one word, indexed by what they catch.** `catch_fail`, `catch_msg`, `catch_op`, each keeping its rule.
  *For:* the proofs stand. *Against:* Q-LEM-001 counts one word per construct: the index is a second name.

- **C — Three constructs, three words (`catch`, `guard`, `handle`).**
  *For:* each rule its word. *Against:* against VOC-2026-11-04-001.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-006), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:**

  > Je préfèrerais même retirer le mot `catch` qui est un implicite du paramètre de `case` au profit d'un mot plus facile à comprendre indiquant que l'on regarde, que l'on lit, un flux de donnée identifié
  > (<lire le flux> <le flux à lire>
  >     <case-1>
  >     <case-2>
  >     ...)

- **Reading:** the word `catch` is withdrawn: it is implicit in what `case` takes. A word easier to understand takes the head, saying that one watches, or reads, an identified data flow; the cases follow it: `(<read the flow> <the flow to read> <case-1> <case-2> ...)`.
- **Put back to the author:** the word that reads is asked in dossier 1 (Q-FRM-001): `read`, `watch`, `on`, `from`, `observe`.

### Flows

#### Q-LEM-218 — How a program connects to its flows

**Fiche.**

- **Research:** « Reading lot: research of 2026-11-04, connecting to a flow », question 1

**Object.** Chapter 4: « Ce qui démarre un programme est donc l'ensemble de ses sources d'événements » ; chapter 5: « le monde extérieur se joint par un message à l'acteur qui porte l'interopérabilité étrangère » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean), chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean)).

**Facts.**

- AWK: « Input shall be interpreted as a sequence of records »; « each file operand (or standard input if no files were specified) shall be processed in turn » (POSIX, awk (https://pubs.opengroup.org/onlinepubs/9799919799/utilities/awk.html)).
- TXR: `next` « indicates that the remaining directives in the current block are to be applied against a new input source » (TXR manual (https://www.nongnu.org/txr/txr-manpage.html)).
- Go: « A channel provides a mechanism for concurrently executing functions to communicate by sending and receiving values of a specified element type » (Go specification (https://go.dev/ref/spec)).
- Erlang: `Expr1 ! Expr2` « Sends the value of Expr2 as a message to the process specified by Expr1 » (Erlang, expressions (https://www.erlang.org/doc/system/expressions.html)).

- **A — Implicit, data-flow: a pattern placed on a source receives it.** As AWK. Phase 2's wiring graph connects sources to automata.
  *For:* the program is patterns and transformations; routing is natural. *Against:* the wiring is read from the graph, not from the clause.

- **B — Named in the catch: the catch says what it reads.** As TXR's `next` or a Go channel. Example: `(catch (source "orders.log") (@(Order id) …))`.
  *For:* the graph is readable from the text. *Against:* every catch names its source.

- **C — Through a mailbox only: every source becomes messages to an actor.** As Erlang, and chapter 5 today.
  *For:* one kind of flow; the journal sees everything. *Against:* a file read becomes a stream of messages.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-008), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

#### Q-LEM-219 — Which sources are flows of the same kind

**Fiche.**

- **Research:** question 2

**Object.** Which sources a catch reads in the same way, with the same patterns.

**Facts.**

- Go: « Reader is the interface that wraps the basic Read method » (io (https://pkg.go.dev/io)); a file, a socket and a string are readers.
- Elixir: `IO.stream/2` « streams input lines, one by one » (Elixir, Stream (https://elixir.hexdocs.pm/Stream.html)).
- Chapter 4: « Seules les sources d'événements — une entrée du monde extérieur, un `defer` — démarrent aussitôt » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)).

Several options may be chosen.

- **net — The network.**
- **file — Files.**
- **proc — Processes (their output).**
- **mem — Values in memory.**
- **journal — The journal.**
- **tick — Ticks of `defer`.**
- **mailbox — Mailboxes.**

#### Q-LEM-220 — How a flow is simulated

**Fiche.**

- **Research:** question 3

**Object.** Testing a program that reads the network without the network.

**Facts.**

- TXR: `@(next :list lisp-expr)` « treats TXR Lisp expression lisp-expr as a source of text […] as if it were the lines of a text file » (TXR manual (https://www.nongnu.org/txr/txr-manpage.html)).
- Go: `strings.NewReader` « returns a new Reader reading from s » (strings (https://pkg.go.dev/strings)).
- Chapter 5: an actor « redémarre à son dernier état connu » from its snapshot and its journal (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean)).

Several options may be chosen.

- **mem — A value in memory read as a flow.**
- **file — A file read as a flow.**
- **journal — A recorded journal replayed.**
- **tick — Ticks of `defer` driving time.**

#### Q-LEM-221 — What becomes of `:on`

**Fiche.**

- **Research:** question 4
- **Now in the specification:** `:on (Increment :sets value […])`

**Object.** Chapter 5: « la clause `:on … :sets` n'est que la forme abrégée d'une réaction » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean)). In data-flow, sending a flow to an automaton is routing.

**Facts.**

- Chapter 5: « `@` appartient aux motifs, et tout est motif […] : `@` placé devant une construction capture ce motif et en hérite toute la construction, précisée — ce qu'il capture reçoit un type raffiné de cette construction » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)).

- **A — An abbreviation of a catch on the actor's mailbox; it stays.**
  *For:* the actor's listing stays short. *Against:* two ways to write a catch.

- **B — Withdrawn: an actor's reactions are its catch clauses.**
  *For:* one form. *Against:* the `:sets` abbreviation goes with it.

- **C — The declaration of routing: which flow feeds the actor; `catch` matches.**
  *For:* the wiring graph is explicit in the actor. *Against:* `:on` changes meaning.


#### Q-LEM-222 — Reading several sources at once

**Fiche.**

- **Research:** question 5

**Object.** A catch that waits on several sources and takes whichever comes first chooses between channels. Waiting for all of them, in a fixed order, does not.

**Facts.**

- Chapter 4's conjecture `thm:sous_reseaux_kahn` drops the journal of interleavings for a sub-network whose channels have « un seul écrivain et un seul lecteur », read « par des réceptions bloquantes sur un canal à la fois, sans tester la présence d'un message ni choisir entre plusieurs canaux » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)).
- Go: « A "select" statement chooses which of a set of possible send or receive operations will proceed » (Go specification (https://go.dev/ref/spec)).

- **A — One source per catch: Kahn's determinism, no journal.**
  *For:* every such sub-network replays without a journal of interleavings. *Against:* a result-or-deadline wait cannot be written.

- **B — Several, whichever comes first, the journal recording the choice.**
  *For:* Go's `select`; deadlines and cancellations are natural. *Against:* the sub-network leaves Kahn's class.

- **C — Several only when all are required (a join); one otherwise.** Waiting for all sources reads each in turn, which stays deterministic; a first-of choice needs the journal and is written as such.
  *For:* determinism by default, the choice explicit and paid for. *Against:* two forms to learn.


#### Q-LEM-223 — The order of a mailbox

**Object.** Which message a catch may take when several are waiting.

**Facts.**

- Chapter 4: « La boîte aux lettres abstraite est un multi-ensemble de ressources linéaires indexé par canal »; its structure: « un anneau SPSC par couple (émetteur, boîte), et une file de jonction par acteur » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)).
- Erlang: « The patterns in the clauses are matched against a message from top to bottom »; « The first message from the start of the message queue that matches will be selected »; « All other messages in the message queue remain unchanged » (Erlang, expressions (https://www.erlang.org/doc/system/expressions.html)).

- **A — A multiset: any message that matches, as the abstract model.**
  *For:* the model of chapter 3 and 4. *Against:* two messages from one sender may be taken out of order.

- **B — In order per sender: the first that matches in each sender's ring.**
  *For:* the physical structure of chapter 4; a sender's order is kept. *Against:* the order between senders is the fixed order of chapter 4, not arrival.

- **C — Strictly first in, first out: only the oldest message may be caught.**
  *For:* Kahn's blocking read. *Against:* a message no clause catches blocks the mailbox.


### Joins and parallelism

#### Q-LEM-224 — How a join is written

**Fiche.**

- **Now in the specification:** chapter 4's listing `define-join-pattern`; chapter 3's `guard` with `p & p`
- **Observed:** the listing's two clauses take one message each, a choice between a result and a deadline, not a conjunction; its second clause uses `id`, which only the first binds

**Object.** Chapter 4: « Un acteur peut exprimer l'attente simultanée d'un résultat et d'une échéance par deux clauses d'un même motif » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)).

**Facts.**

- Chapter 3, rule Guard: each branch carries a conjunctive pattern `m1(x1) & … & mk(xk)`; « La branche ne s'ouvre que si tous les messages du motif sont présents, et les consomme d'un seul tenant » (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)).
- Chapter 4 reads the join queue « au sens du calcul de jonction » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)) and writes a join pattern `J ::= x1(y1) & … & xn(yn)` (chapter 4, process calculus (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/UnderlyingProcessCalculus.lean)).

- **A — A join is a catch whose pattern is a conjunction; `define-join-pattern` and `guard` leave.** Example: `(catch inbox (@(Done id r) & @(Ack id) (finish r)))`.
  *For:* one construct (Q-LEM-217 A). *Against:* the name « join » disappears from the text.

- **B — A join is a named pattern, defined with `@name` and caught by name.** Example: `{def @done-and-acked (& (Done id r) (Ack id))}   (catch inbox (@done-and-acked (finish r)))`.
  *For:* reusable; `@name` defines a pattern (VOC-2026-10-27-076). *Against:* one more definition.

- **C — `define-join-pattern` stays, as the definition form of joins.**
  *For:* the specification's listing. *Against:* a second definition form beside `def`.


### Time and reactivity

#### Q-LEM-225 — The model of time

**Object.** Chapter 3 makes asynchrony primitive: « l'émission ne bloque pas, la réception bloque » (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)). Synchronous languages make a reaction instantaneous and deterministic.

**Facts.**

- Esterel: « A system is said to be deterministic if the same sequence of inputs always produces the same sequence of outputs »; its program ABRO, `loop [ await A || await B ]; emit O each R`, emits `O` as soon as `A` and `B` have both occurred, and restarts at each `R` (Esterel v5 primer (https://www.rw.cdl.uni-saarland.de/people/kaestner/private/es0203/esterel_primer.pdf)).
- Lustre « is a data flow synchronous language, designed for programming reactive systems » (Halbwachs et al. 1991 (https://homepage.divms.uiowa.edu/~tinelli/classes/181/Fall20/Papers/Halb91.pdf)).

- **A — Asynchronous only, as now; time comes from `defer` ticks.**
  *For:* one model. *Against:* simultaneity cannot be written.

- **B — Synchronous inside an actor, asynchronous between actors.** A reaction is a logical instant: what it emits is simultaneous; actors exchange messages.
  *For:* deterministic reactions; the network stays asynchronous. *Against:* two models to explain.

- **C — Synchronous everywhere.**
  *For:* determinism everywhere, as Esterel. *Against:* a distributed program cannot share one clock.


#### Q-LEM-226 — Patterns over time

**Fiche.**

- **Recorded:** a trace is a pattern (VOC-2026-11-04-001)

**Object.** A pattern that catches a sequence of events: an order, then its payment, then no cancellation.

**Facts.**

- SQL's row pattern recognition: `MATCH_RECOGNIZE` « is used to detect patterns in a set of rows »; « Row pattern is a form of a regular expression with some syntactical extensions specific to row pattern recognition », as `PATTERN (A B+ C+ D+)` with conditions in `DEFINE` (Trino (https://trino.io/docs/current/sql/match-recognize.html)).
- Flink CEP: « It allows you to detect event patterns in an endless stream of events »; relaxed contiguity « Ignores non-matching events appearing in-between the matching ones » (Flink CEP (https://nightlies.apache.org/flink/flink-docs-stable/docs/libs/cep/)).

- **A — R-expressions over the events of a flow.** Concatenation, `|`, repetition, conditions in `case`; the same automata and classes as on text. Example: `(catch orders (@[(Order id) (Paid id) (not (Cancelled id))] (ship id)))`.
  *For:* one pattern language for text, values and time. *Against:* sequence operators to fix for events.

- **B — Combinators: next, followed by, not followed by.**
  *For:* Flink's vocabulary. *Against:* a second pattern language.

- **C — Statements: await, every, abort, as Esterel.**
  *For:* control written as control. *Against:* not patterns: outside the generalisation.


#### Q-LEM-227 — Deadlines and windows

**Object.** A pattern over time must often complete within a delay, or give up.

**Facts.**

- Flink CEP: `within` « Defines the maximum time interval for an event sequence to match the pattern »; « If a non-completed event sequence exceeds this time, it is discarded » (Flink CEP (https://nightlies.apache.org/flink/flink-docs-stable/docs/libs/cep/)).
- Erlang: « receive...after works exactly as receive, except that if no matching message has arrived within ExprT milliseconds », « then BodyT is evaluated instead » (Erlang, expressions (https://www.erlang.org/doc/system/expressions.html)).
- Chapter 5: `defer` takes « une quantité typée dans une unité de temps […] ou dans une unité de compte, une époque ou un tic par exemple » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean)).

- **A — A window word, `within`, with a typed quantity of time or count.** Example: `(catch orders (@[(Order id) (Paid id)] :within 30 s (ship id)))`.
  *For:* the deadline is part of the pattern. *Against:* one more word.

- **B — No window: a deadline is a clause catching a `defer` tick.** As chapter 4's result-or-deadline and Erlang's `after`.
  *For:* nothing new: a tick is an event. *Against:* the deadline is far from the pattern it bounds.

- **C — Both: `within` elaborates into a tick clause.**
  *For:* short to write, one semantics. *Against:* one more abbreviation.


#### Q-LEM-228 — Previous values and sampling

**Fiche.**

- **Overlaps:** Lustre's `when` samples a flow; chapter 3's `when x = v in c` waits (Q-LEM-119: a form of `catch`)

**Object.** Whether a flow is also a value with a history: its previous value, its first value, a slower clock.

**Facts.**

- Lustre: « pre (“previous”) acts as a memory »; `E -> F` « is always equal to F, but at the first time of its clock »; « when “samples” an expression according to a slower clock »; « current “interpolates” an expression on the clock immediately faster than its own » (Halbwachs et al. 1991 (https://homepage.divms.uiowa.edu/~tinelli/classes/181/Fall20/Papers/Halb91.pdf)).

- **A — No: a flow is only caught; state lives in an actor.** The previous value is the actor's state, updated by its evolution (chapter 5).
  *For:* one model. *Against:* a filter or a derivative needs an actor.

- **B — Yes: Lustre's operators in layer 3, on flows.**
  *For:* control laws and filters as equations; compiled to automata. *Against:* four more words.

- **C — Only the previous value, as a pattern looking back on the trace.**
  *For:* the most frequent need, no clock calculus. *Against:* no sampling.


#### Q-LEM-229 — When a flow is faster than its automaton

**Object.** Chapter 4: « chaque anneau a une capacité qui est un grade » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)). The question is what happens when the ring is full.

**Facts.**

- Reactive Streams: « Reactive Streams is an initiative to provide a standard for asynchronous stream processing with non-blocking back pressure », so that « the receiving side is not forced to buffer arbitrary amounts of data » (Reactive Streams (https://www.reactive-streams.org/)).

- **A — The writer waits when the ring is full.**
  *For:* bounded memory; Kahn's networks with bounded channels. *Against:* a slow reader slows its writers.

- **B — A policy declared per channel: wait, drop the oldest, drop the newest, keep the latest.**
  *For:* sensors drop, orders wait. *Against:* a declaration per channel.

- **C — Demand: the reader grants credit, the writer sends within it.**
  *For:* Reactive Streams. *Against:* a protocol under every channel.

## Statement of 2026-11-12: philosophy, method, and the nesting of delimiters

**Statement of the author — 2026-11-12, given in the conversation, quoted as given.**

> J'ai répondu à quelques questions mais je pense qu'il faut retravailler les questions et propositions au regard des commentaires que j'ai exprimé. Reprend l'objectif phylosophique de K7PL notamment dans son ancrage pattern-matching, data-flow, control-flow, constraint programming, logic programming et fonctionnel.
>
> Réélabore sur ce que nous avons exploré ensemble, sur les précédentes réponses et commentaires, sur les divers choix et orientations explorés et documentés.
>
> Je pense que nous avons une problématique de méthode car cette recherche lexicale a du mal à aboutir... probablement parce que chaque sujet est très découpé là où je pense que je préfèrerais des recherches cohérentes de thématiques permettant d'aboutir sur les formes génériques à employer, sur lesquelles s'appuyer. Je note en plus que des propositions de code en exemple de réponses violent la règle synthaxique la plus élémentaire de K7PL sur l'imbrication des délimiteurs de couches.

- **VOC-2026-11-12-009, reading:** the questions and their options are to be reworked from the comments given, starting again from K7PL's philosophical aim and its anchoring in pattern matching, data-flow, control-flow, constraint programming, logic programming and functional programming, and from everything explored, answered and documented so far.
- **VOC-2026-11-12-010, reading:** a problem of method: the lexical research does not converge, probably because each subject is cut too finely. The author would prefer coherent research by theme, leading to the generic forms to use and to rest on. Proposed in answer, to be confirmed (Q-METH-003): one dossier per theme, ending in generic forms; the words come last, per form.
- **VOC-2026-11-12-011, reading:** examples of code offered in the options break K7PL's most elementary rule of syntax, the nesting of the layer delimiters. Checked: 12 of the 123 K7PL texts of the three lemma lots are at fault, all by a `( )` inside a `[ ]` (`ERR-TOP-001`); the list is in [research](research.md), « Thematic dossier 1 », erratum. From this record on, every example is checked against the nesting rule before it is published.

These statements are answered by [research](research.md), « Thematic dossier 1 of 2026-11-12: reading a flow », and by the questions Q-METH-003, Q-FRM-001 to Q-FRM-008 and Q-DOS-001 below. The questions of lemma lot 3 left unanswered, and those of lemma lot 2 carried with it, are set aside: the dossier's forms replace them or a later dossier takes them up.

## Thematic dossier 1 of 2026-11-12: reading a flow (Q-METH-003, Q-FRM-001 to Q-FRM-008, Q-DOS-001)

Opened on 2026-11-12 in answer to the author's statement of the same day (above). The argument and its
sources are in [research](research.md), « Thematic dossier 1 of 2026-11-12: reading a flow ». Each card
gives one generic form, what it rests on, what it absorbs, and the decision that remains on the whole
form. **Other** and **Clarify** are always available.

First thematic dossier, written on 2026-11-12 after your statement that the lexical research does not converge because each subject is cut too finely, and that you would prefer coherent research by theme leading to the generic forms to use (VOC-2026-11-12-010). It starts again from what K7PL sets out to do and from everything you have answered, and reads pattern matching, data-flow, control-flow, constraint programming, logic programming and functional programming as six readings of one form: a flow is read, and each `case` joins a pattern to a computation. The whole argument, with its sources, is in research.md, « Thematic dossier 1 of 2026-11-12: reading a flow ». Each card below gives one generic form, what it rests on and what it absorbs, and asks about the form as a whole. Every example is written on one scenario, yours: frames sent to a display, and conditions caught in flight. Every example has been checked against the nesting rule of the layers (`[ ]` holds only `[ ]`; `( )` holds `( )` and `[ ]`; `{ }` holds all three). Every word of the examples other than `case` is a placeholder, the reading word `read` included. An answer is a dated preference, ratified only in the global lot (VOC-2026-10-26-002). **Other** and **Clarify** are always available, and a comment is worth more than a choice.

**Set aside by this dossier.** The questions of lemma lot 3 left unanswered and those of lemma lot 2
carried with it are no longer shown on the page. Each is replaced by a form or goes to a later dossier:

- Q-LEM-105: the dossier on objects and observations.
- Q-LEM-106: the dossier on objects and observations.
- Q-LEM-111: Q-FRM-006, then the dossier on sequencing and effects.
- Q-LEM-115: Q-FRM-007.
- Q-LEM-117: the dossier on time and order.
- Q-LEM-118: the dossier on time and order.
- Q-LEM-121: Q-FRM-002.
- Q-LEM-201: Q-FRM-003.
- Q-LEM-207: Q-FRM-001.
- Q-LEM-210: Q-FRM-002 and Q-FRM-008.
- Q-LEM-211: Q-FRM-006.
- Q-LEM-215: Q-FRM-006, then the dossier on sequencing and effects.
- Q-LEM-219: the dossier on sources, places and distribution.
- Q-LEM-220: the dossier on sources, places and distribution.
- Q-LEM-221: Q-FRM-001.
- Q-LEM-222: Q-FRM-004.
- Q-LEM-223: the dossier on time and order.
- Q-LEM-224: Q-FRM-004.
- Q-LEM-225: the dossier on time and order.
- Q-LEM-226: the dossier on time and order.
- Q-LEM-227: the dossier on time and order.
- Q-LEM-228: the dossier on time and order.
- Q-LEM-229: Q-FRM-006, then the dossier on time and order.

### Method

#### Q-METH-003 — The method from here on: a dossier per theme

**Fiche.**

- **Recorded:** the arbitration sequence for words (Q-METH-001, option A); ratification in a global lot (Q-METH-002, option A)
- **Your statement:** « cette recherche lexicale a du mal à aboutir... probablement parce que chaque sujet est très découpé là où je pense que je préfèrerais des recherches cohérentes de thématiques permettant d'aboutir sur les formes génériques à employer, sur lesquelles s'appuyer » (VOC-2026-11-12-010)
- **Observed:** in lemma lot 3, 8 of your 13 answers are **Other** or **Keep open**, and the 5 others each add a comment that changes the option: 62% outside the options, the highest of the fourteen lots (the others range from 14% to 47%). 12 of the 123 K7PL texts of the three lemma lots break the nesting rule, all by a `( )` inside a `[ ]`

**Object.** What went wrong, as I read it. The lemma lots asked for a word, construct by construct, before the form that carries the word was settled, so that each answer depended on neighbours not yet answered. The options were taken from other languages (ML, Erlang, OCaml, Clojure) rather than derived from K7PL's own principles. And the examples were not passed through the layer grammar. This card asks whether the way dossier 1 is built is the method to keep.

- **A — A dossier per theme, ending in generic forms; the words come last.** Each dossier gives, in order: what the specification states and what you have answered on the theme, quoted; outside work read as a whole, not option by option; the generic forms, written in K7PL on one running scenario and checked against the layer grammar; what each form absorbs or changes in the kernel; a few decisions, each on a whole form; then the words of the forms kept, weighed on Q-METH-001. Answers stay dated preferences until the global lot (Q-METH-002).

  *For:* decisions bear on forms that hold together; a word is chosen for a form already kept. *Against:* a dossier is longer to read than a question.

- **B — Dossiers discussed in the conversation only, recorded verbatim; no cards.**

  *For:* your comments have carried more than your choices. *Against:* nothing marks what is settled and what is not, short of rereading the record.

- **C — Separate questions as before, grouped by theme behind a synthesis.**

  *For:* the smallest change. *Against:* the cutting you point at stays.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-012), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** the method is kept (option A): one dossier per theme, ending in generic forms written in K7PL and checked against the nesting rule; the words come last, per form.

### The generic forms

#### Q-FRM-001 — Reading a flow: the form, and its word

**Fiche.**

- **Your sketch:** « Je préfèrerais même retirer le mot `catch` qui est un implicite du paramètre de `case` au profit d'un mot plus facile à comprendre indiquant que l'on regarde, que l'on lit, un flux de donnée identifié » : `(<lire le flux> <le flux à lire> <case-1> <case-2> ...)` (VOC-2026-11-12-006)
- **Recorded:** `catch` and `try … catch` are one object (VOC-2026-11-03-017); waiting for an event is a form of it (VOC-2026-11-04-005); `:on` seems redundant, routing being implicit in data-flow (VOC-2026-11-04-003)
- **Absorbs:** Q-LEM-207, 217, 218, 221; in the kernel `try … catch`, `guard`, `when` and the handlers of operations; in chapter 4 `(match …)` and `define-join-pattern`; in chapter 5 `:on`

**Form.**

```text
;; `read` is a placeholder: the word is what this card asks
(read frames
  (case @dark   [count])
  (case @bright [histogram]))
```

**Object.** The form is yours. What is read comes first and is named: a source, a mailbox, the flow another reading gives, or a computation, whose results, failures and operations are then what its cases catch. Chapter 4 already says what such a form is when nothing encloses it: « Une forme `( )` qu'aucune autre n'encapsule est un processus : un acteur virtuel, activé par son premier message » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)). An actor's `:on` clause is then the same reading with the flow left unsaid: its own mailbox. What the card asks is the word.

**Facts.**

- Go: « Reader is the interface that wraps the basic Read method » (io (https://pkg.go.dev/io)); a file, a socket and a text in memory are all read alike.
- Esterel's first versions wrote « do...watching », later replaced by « abort...when » (Esterel v5 primer (https://www.rw.cdl.uni-saarland.de/people/kaestner/private/es0203/esterel_primer.pdf)).
- Chapter 4: an actor is « un état auquel on ne pose que des questions », defined by the family of its observations (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/Introduction.lean)).

- **A — `read`.**

  1. *Non-collision:* Lisp's `read` and K7PL's own Phase 0 reader read a text into a tree; the old K archive had a property `:read` for an access right.
  2. *Scientific exactness:* names reading; says nothing false when a case takes what it reads.
  3. *Family and grade invariants:* pairs with a writing word, should one be kept.
  4. *Ecological grid (provisional):* Unix, Go's `Reader`.
  5. *Mnemonic:* your « lire ».
  6. *Brevity:* four letters.

  *For:* the plainest word for what you describe. *Against:* the reader of Phase 0 already « reads ».

- **B — `watch`.**

  1. *Non-collision:* no collision found in the specification.
  2. *Scientific exactness:* names looking without taking: exact for a flow that goes on, less so where a case takes.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* Esterel's former `watching`; file watchers.
  5. *Mnemonic:* your « regarder ».
  6. *Brevity:* five letters.

  *For:* says that the flow is not diverted. *Against:* wrong where reading consumes.

- **C — `on`.**

  1. *Non-collision:* the actor's `:on` exists: one object under one word if the clause abbreviates this form (Q-LEM-001), a collision otherwise.
  2. *Scientific exactness:* names the occasion, not the act.
  3. *Family and grade invariants:* the property `:on` and the form share a word, as `:bind` and `bind`.
  4. *Ecological grid (provisional):* event handlers named `on…` in many languages.
  5. *Mnemonic:* weak alone.
  6. *Brevity:* two letters.

  *For:* nothing new: the word is already in chapter 5. *Against:* a preposition for a head word.

- **D — `from`.**

  1. *Non-collision:* no collision found.
  2. *Scientific exactness:* names the source and is silent on the act.
  3. *Family and grade invariants:* —
  4. *Ecological grid (provisional):* SQL's `FROM`, beside your SQL `CASE` and `LIKE`.
  5. *Mnemonic:* reads « from frames, case … ».
  6. *Brevity:* four letters.

  *For:* the SQL family you draw on. *Against:* does not say that something is watched.

- **E — `observe`.**

  1. *Non-collision:* chapter 4 and codata use « observation » for what an actor answers; Q-LEM-106 weighs `observe` for the projection.
  2. *Scientific exactness:* exact where the flow goes on.
  3. *Family and grade invariants:* the dual of a pattern is a copattern, an observation.
  4. *Ecological grid (provisional):* ReactiveX's Observable.
  5. *Mnemonic:* clear.
  6. *Brevity:* seven letters.

  *For:* ties reading a flow to the theory of observations. *Against:* long, and already claimed.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-013), given in the clickable questionnaire, quoted as given.**

- **Choice:** E
- **Justification:** L'observation ressemble beaucoup plus à mon modèle mental, un flux a déjà sa destination, en l'observant on peut réaliser des opérations par réaction sans dévier le flux. Considérant la nature pub/sub de K7PL, un flux est envoyé à un automate le demandant, un observeur est un traitement parallele au flux.
- **Reading:** `observe` (option E). Observation is closer to the author's mental model: a flow already has its destination, and by observing it one carries out operations by reaction without diverting it. K7PL being publish and subscribe, a flow is sent to an automaton that asks for it; an observer is a processing parallel to the flow.

#### Q-FRM-002 — What a case does to what it reads: observe, or take

**Fiche.**

- **Recorded:** « `(case <pattern> <computation>)` […] Si le pattern n'est pas trouvé alors il ne se passe rien, si l'inverse est recherché alors : `(case <not-pattern> <computation>)` » (VOC-2026-11-12-003); « All of them as AWK but the flow is rooted to automatas » (VOC-2026-11-12-001)
- **Your example:** « Quand on attrape un pattern pour en faire quelque chose, c'est un traitement parallèle à l'action initiée par le flux, ce qui signifie qu'un envoi d'une matrice de pixels colorés vers un affichage s'affiche et qu'on peut apporter un traitement parallèle suivant des conditions attrapées en vol. Cela n'empêche donc pas la computation du flux et le cas permet la computation déclenchée par le pattern. » (VOC-2026-11-05-001)
- **Absorbs:** Q-LEM-208, 210, 212, 121

**Form.**

```text
(read frames                          ;; every case whose pattern is found runs, each for itself
  (case @dark       [count])
  (case (not @dark) [histogram]))     ;; the reverse is a pattern, not a default
```

**Object.** Settled by your answers: a case is a pattern and a computation; cases do not know one another; nothing happens when a pattern is not found; the reverse is a pattern. One thing is not settled. In your example a case *observes*: the frame still reaches the display. In chapter 3 a case *takes*: « La branche ne s'ouvre que si tous les messages du motif sont présents, et les consomme d'un seul tenant », and `free` asks for an empty mailbox (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/TypingRules.lean)). K7PL has a place for this difference. P2 holds that how a thing may be used, its grade, is independent of what it is (chapter 1 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C1/Postulates.lean)); and chapter 3 gives a linear region a readable image, a `ReadCap`, where « N lecteurs simultanés sont exprimables » (chapter 3 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C3/GradedSystem.lean)).

**Facts.**

- Linda has both gestures: `in` « Takes out a tuple that matches a given pattern from the tuplespace », `rd` « Copies a tuple that matches a given pattern »; « (input) consumes the tuple […] whereas (read) only reads it » (Linda (https://en.wikipedia.org/wiki/Linda_(coordination_language))).
- Constraint Handling Rules have both kinds of rule: propagation rules « add the constraints in the body to the store, without removing the heads », simplification rules rewrite the heads into the body (CHR (https://en.wikipedia.org/wiki/Constraint_Handling_Rules)).
- Unix: « The tee utility shall copy standard input to standard output, making a copy in zero or more files » (POSIX, tee (https://pubs.opengroup.org/onlinepubs/9799919799/utilities/tee.html)).

- **A — The flow's usage grade decides.** One form, three behaviours, by the grade of what flows. Unrestricted: every case that matches observes, and the flow goes on to where it was going — your display. Affine: at most one case takes an element, and one that no case catches is dropped. Linear: exactly one case takes it, so the cases must be disjoint and cover, which is checked at compile time — chapter 3's Guard as it stands. To observe a linear flow, one reads its readable image.

  *For:* nothing is added: the grade P2 already gives does the work; Guard, `free` and your display are one form at three grades. *Against:* whether cases observe or take is read from the flow's type, not from the text of the reading.

- **B — A case always observes; taking is another word.**

  *For:* the frequent case reads simply. *Against:* two words; a linear element observed by a case and taken by none must be caught by another check.

- **C — A case always takes; observing asks for a copy written upstream.**

  *For:* chapter 3 unchanged. *Against:* against your example: catching would divert the frame from the display.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-014), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** `read <something>` consomme donc le `case` prend et produit, `observe <something>` regarde le flux lui même et y réagit. C'est comme si on mettait une loupe sur un flux de message et que tout en les laissant passer on prennait des notes en remarquant des mots.
- **Reading:** two words, not one form graded by the flow. `read <something>` consumes: its `case` takes and produces. `observe <something>` looks at the flow itself and reacts to it: a magnifying glass on a flow of messages, notes being taken on the words noticed while the messages pass.
- **Put back to the author:** Q-FRM-001's answer then names one of two forms. Does `observe` take the same `case` clauses as `read`, consumption being the only difference?

#### Q-FRM-003 — The pattern: a construction with holes

**Fiche.**

- **Recorded:** `@` belongs to patterns (VOC-2026-10-27-076); everything is a pattern, and `@x` is every pattern of `x` (VOC-2026-11-04-002); what is caught has the refined type of its construction (VOC-2026-11-04-001)
- **Your comment:** « Je pense que le symbole `^` n'est pas pertinent mais que l'approche d'elixir est intéressante. Il manque par contre de pouvoir faire des motifs à trous (comme like avec des wildcards en SQL) » (VOC-2026-11-06-001)
- **Already in K7PL:** the typed hole: « Un générique ne nomme aucun paramètre de type : il s'écrit avec des trous typés »; `int` without a width, `str`, and the holes of a qualified literal, each « un trou typé, passé en paramètre »
- **Absorbs:** Q-LEM-201, 202, 203

**Form.**

```text
(read replies
  (case (Reply id @body)   [parse body])   ;; `id` is held: compared. `@body` is a hole: caught and named
  (case (Reply @int @str)  [count])        ;; holes typed by a declared construction, left unnamed
  (case @Reply             [archive]))     ;; every Reply, whole: it is the computation's argument
```

**Object.** K7PL already has the notion you ask for. A typed hole is a place left open, with a type, that something fills later: the solver and monomorphisation for a generic, a parameter for a qualified literal (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)). A pattern is then a construction some of whose places are holes, and matching is what fills them. `@` marks the hole, never the value held: it is Elixir's distinction with the mark on the other side, so no `^` is needed. `@x` where `x` is declared is « tout motif de x », a hole of that type left unnamed; `@x` where `x` is a new name is a hole named `x`, typed by its place in the construction. The whole that a case caught is the argument of its computation, as a train takes its missing operands from its arguments; the parts are the named holes. No alias word is needed (Q-LEM-203, kept open).

**Facts.**

- Elixir's pin is used to « pattern match against a variable's existing value rather than rebinding the variable » (Elixir, pattern matching (https://elixir.hexdocs.pm/pattern-matching.html)): there the mark is on the value held.
- CDuce: « A value identifier inside a pattern behaves as a capture variable: it accepts and binds any value »; « a pattern without any capture variable is nothing but a closed type » (CDuce manual (https://www.cduce.org/manual_types_patterns.html)).
- SQL: « An underscore (`_`) in pattern stands for (matches) any single character; a percent sign (`%`) matches any sequence of zero or more characters » (PostgreSQL, LIKE (https://www.postgresql.org/docs/current/functions-matching.html)).
- Chapter 5: « Chaque type d'étiquette déclare comment ses trous s'écrivent […] ; `sql`, d'après le SQL standard, sera le premier »; the four forms of a tag follow their layers, `[sql|…|sql]` being « pur et termine » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)).

- **A — `@` marks the holes; a bare name is held or declared; texts take their holes in a qualified literal.** As above. The holes of a text are those its tag declares, SQL's `LIKE` first, written in the qualified literal of the layer where the pattern stands.

  ```text
  (case (Order [like|FR-%|like] @total) [add total])
  ```

  *For:* one notion, the typed hole, for generics, literals and patterns; no new sign, no alias word. *Against:* `@name` reads two ways by what is declared, so a hole may not take the name of a declared construction: the compiler must refuse it.

- **B — A bare name binds, as in chapter 5's handler today; a held value takes a mark.**

  *For:* chapter 5's listing stays as written. *Against:* needs the mark you set aside; a misspelled construction becomes a variable, « un motif qui filtre tout et ne signale rien » (chapter 5).

- **C — Holes are typed and never named; parts are taken afterwards by `unbind`.**

  ```text
  (case (Reply id @str) [parse])
  ```

  *For:* `@x` keeps one reading. *Against:* every part used costs a second step.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-016), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Justification:** Réexplorer TXR Lisp, AWK, Jq, Perl/Raku. Un pattern peut etre lié à des propriétés, au grade, aux labels, aux types, mais aussi une regex, une table de caractère, etc. ce qui signifie que je pourrais demander @"jul?" Et trouver jul jule julie julia juliette etc. => ici je veux indiquer que les wildcards font parti des trous typés et permettent également de créer des pattern. Ensuite, `case` est le mot de déclanchement d'action par réaction à un fait observé/lu ce qui est une propriété exclusive de la couche 2 (la couche 3 est passive, pure, sans effets) donc créer un case en couche 3 est incohérent. La couche 3 utilise uniquement des opérateurs sur la stack issue des travaux historiques CBQN, Uiua, KAP, J, FIXAPL, etc.
- **Reading:** kept open, with research asked for: TXR Lisp, AWK, jq, Perl and Raku are to be explored again. A pattern can be tied to properties, to the grade, to labels, to types, and can also be a regular expression, a character table and so on: `@"jul?"` would find jul, jule, julie, julia, juliette. Wildcards are part of typed holes and also create patterns. `case` is the word that triggers an action in reaction to a fact observed or read, which belongs to layer 2 only: layer 3 is passive, pure, without effects, so a `case` in layer 3 is incoherent. Layer 3 uses only operators on the stack, in the line of CBQN, Uiua, KAP, J and FIXAPL.
- **Put back to the author:** what `?` denotes in `@"jul?"`: one character in a glob, an optional `l` in a regular expression; neither gives that list as whole words. To settle with the exploration asked for.

#### Q-FRM-004 — Combining patterns: the logical connectives, and the join

**Fiche.**

- **Your answer:** « En fait il manque les constructeurs logiques `or, nor, xor, xnor, and, nand, xand, xnand`, associés à catch et case nous devrions avoirs tous les constructeurs logiques suffisants. » (VOC-2026-11-06-003)
- **Recorded:** you asked to weigh `join` and the words of SQL (VOC-2026-11-03-009); layer-3 words are monadic or dyadic, n-ary operators being those of layer 2 (VOC-2026-10-28-033)
- **Now in the specification:** chapter 3's guard patterns `p ::= m(x̄) | p & p`; chapter 4's `define-join-pattern`
- **Absorbs:** Q-LEM-204, 222, 224

**Form.**

```text
(read frames
  (case (and @dark (not @corrupt)) [count])        ;; one element that is both
  (case (nor @dark @bright)        [histogram]))   ;; one element that is neither

(read orders payments
  (case (join (Order @id @total) (Paid @id)) [ship id]))   ;; two elements, one from each flow, the same `id`
```

**Object.** Two things are called « and ». On one element, a connective is an operation on what a pattern accepts: `and` what both accept, `or` what either accepts, `not` what it refuses, and `nand`, `nor`, `xor`, `xnor` follow. Chapter 4 notes that recognisable languages stay « close par réunion, intersection et projection » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/LocalScale.lean)), so `and` and `or` leave a pattern in its class. Between elements — a result and its acknowledgement — « and » is a join: several elements present together, linked by a hole written twice, which is the join's condition. `not` is monadic and the others dyadic, so they are layer-3 words as they stand, and n-ary in layer 2. One point is put back to you: `xand` and `xnand` have no agreed table.

**Facts.**

- CDuce « recognizes the full set of boolean connectives, whose interpretation is purely set-theoretic »; « a capture variable cannot appear on both side » of `&`, and the right side of a difference « is necessarily a type (no capture variable) » (CDuce manual (https://www.cduce.org/manual_types_patterns.html)).
- Datalog: « The `:-` symbol is read as "if", and the comma is read "and" »: `ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).` joins two facts by the shared `Z` (Datalog (https://en.wikipedia.org/wiki/Datalog)).
- The XNOR gate is « sometimes ENOR, EXNOR, NXOR, XAND » (XNOR gate (https://en.wikipedia.org/wiki/XNOR_gate)).

- **A — Connectives for one element; `join` between elements.** `and`, `or`, `not`, `nand`, `nor`, `xor`, `xnor` act on one element. `join` asks for several elements together, a hole written twice being their link. A hole under `not`, or on one side only of `or`, names nothing.

  *For:* each word has one meaning and one cost; `(and (Order …) (Paid …))` is then a pattern nothing can match, which the solver can report. *Against:* one word more than chapter 3's `&`.

- **B — `and` does both, as chapter 3's `p & p`.**

  *For:* fewer words. *Against:* one word, two costs: a test on one element, a wait for several.

- **C — Connectives only between conditions, patterns staying whole.**

  *For:* patterns stay simple. *Against:* against your answer.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-015), given in the clickable questionnaire, quoted as given.**

- **Choice:** OTHER
- **Other:** Utiliser directement les opérateurs logiques, demande moi la table exacte, je l'ai préparée `and or nand nor xor xnor imply nimply yes not`
- **Reading:** the logical operators are used directly; the author has prepared their exact table: `and`, `or`, `nand`, `nor`, `xor`, `xnor`, `imply`, `nimply`, `yes`, `not`. The table was given on the same evening and is recorded below (VOC-2026-11-12-018). It replaces the list of VOC-2026-11-06-003: `xand` and `xnand` are gone, `imply`, `nimply` and `yes` come in.

#### Q-FRM-005 — Where each part is written: the three layers

**Fiche.**

- **The rule:** « les types se posent en couche 1 seulement, la couche 2 orchestre et produit, la couche 3 calcule et termine » (chapter 5)
- **Your answers:** « Pour moi la class ne doit pas être déclarée car il s'agit d'un effet de couche d'une part et d'algorithme d'autre part. donc inférence systématique » (VOC-2026-11-05-002); `choose` and `select` leave: « je pense que nous pouvons tout de même trouver comment assurer le branching. » (VOC-2026-11-05-003)
- **Erratum:** 12 examples of the lemma lots put a `( )` inside a `[ ]` (`ERR-TOP-001`), as `(bind [x (read-sensor)] …)`; they are listed in research.md
- **Absorbs:** Q-LEM-205, 206, 213

**Form.**

```text
{def dark :type {{f frame [lt mean f 16]}}}   ;; layer 1: the shape is declared, with its type

(read frames                                   ;; layer 2: the flow is read, and reading does not end
  (case @dark [count]))                        ;; layer 3: the computation is pure, and ends
```

**Object.** The nesting rule gives the form its three places, and each place its guarantee. A pattern that needs a type — a refinement, a budget, a binary layout — is declared in layer 1 and named; layer 2 can only name it, since a `{ }` inside a `( )` is `ERR-TOP-003`. The reading is layer 2: productive, with as many cases as needed. The computation is layer 3 when it is pure, and then it ends; one that has effects stays in `( )`. The class of the automaton is not written: it follows from the layer the pattern stands in and from the pattern itself. What remains is branching *inside* layer 3. `case` takes a pattern and a computation, two operands, so it is a layer-3 word as it stands; but several cases are an n-ary form, and layer 3 has none.

**Facts.**

- Chapter 5: « Une parenthèse à l'intérieur d'un bloc `[ ]` n'y est jamais légitime : elle annonce la couche 2 dans un bloc qui n'en dispose pas » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)).
- Chapter 4: « toute exécution de couche 3 est un automate dont la mémoire se calcule avant l'exécution, jamais pendant » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/LocalScale.lean)).

- **A — In layer 3, a case that finds nothing gives the value back unchanged.** « Il ne se passe rien » is the identity. On a vector, a case computes on the cells its pattern catches and leaves the others, which is the mask of the former `select` written with a pattern. Cases follow one another as the words of a train.

  ```text
  [case @negative neg]   ;; the absolute value, of a number or of each cell of a vector
  ```

  *For:* total, one result, no branching construct; your sentence taken to the letter. *Against:* what leaves has the type of what entered, or their union; two outcomes of one test, `Ok` and `Err`, need two cases in a row, the second seeing what the first gave.

- **B — Layer 3 has no alternatives: a value that needs several cases is read in layer 2.**

  ```text
  (read value
    (case @below-bound       (Ok [add value 1]))
    (case (not @below-bound) (Err Overflow)))
  ```

  *For:* one reading form everywhere; layer 3 stays without branches, which suits its automata and its vector code. *Against:* `?increment-bounded` is no longer a layer-3 function by itself.

- **C — A dyadic word gives a case its other outcome: what to compute where it finds nothing.**

  ```text
  [else [case @below-bound [Ok add value 1]] [Err Overflow]]
  ```

  *For:* alternatives stay in layer 3. *Against:* a default comes back, which your answer to Q-LEM-212 leaves out; one more word.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-017), given in the clickable questionnaire, quoted as given.**

- **Choice:** CLARIFY
- **Clarify:** Il y a ici diverses mécompréhensions. Il est parfaitement possible de calculer en couche 2 qui est un Lisp/Scheme classique, sur le heap (sans gc ni rc, avec borrow checking et tout le reste.) Donc dans ton exemple [add value 1] demanderait de créer un automate de couche 3 procédant simplement à l'augmentation d'un compteur, ce qui serait overkill et pourrait être très simplement réaliser en couche 2 (car cdr).
- **Reading:** a clarification is asked, the card holding several misunderstandings. Layer 2 is a classic Lisp or Scheme, on the heap, without garbage collection or reference counting, with borrow checking and the rest: one computes there. `[add value 1]` would ask for a layer-3 automaton that only increases a counter, which is overkill; it is done simply in layer 2 (`car`, `cdr`).
- **Put back to the author:** the dossier followed chapter 5, which opens on « Écrire du K7PL, c'est choisir, à chaque expression, le fragment le moins permissif que la tâche autorise » and gives as its first example a bounded counter whose increment is « une fonction pure de couche 3 » (`lst:fonction-pure`), called between brackets from the actor's `:on` clause. What sends a computation to layer 3, and does that example stand?

#### Q-FRM-006 — What a case gives: a flow, its label, its instances

**Fiche.**

- **Your answer:** « 1 flow and 3 patterns to catch with dedicated actions to run on them, the flow is divided and piped to 3 sub-automatas ; 1 flow and 1 pattern to catch but cached 3 times the flow is wired to a single automata with its mailbox until the mailbox is full and a new instance of the automata is rased to assure scalability » (VOC-2026-11-12-001)
- **You asked:** « Il serait intéressant d'évaluer si un pattent trouvé est passé avec un label pour faciliter son identification par l'automate suivant ou non »
- **Recorded:** the injection into a sum is `tag` (VOC-2026-11-03-011); an operation's continuation is a function, applied, limited by its grade (VOC-2026-11-12-005)
- **Absorbs:** Q-LEM-211, 214, 215, 229, 111

**Form.**

```text
{def dark-means (read frames (case @dark [mean]))}   ;; a reading that is named: what its cases give is a flow

(read dark-means                                     ;; which another reading reads
  (case @near-black [alarm]))
```

**Object.** Three consequences of reading a flow as data-flow. First, what the computations of a reading give is itself a flow; naming the reading names it, and another reading reads it. Chaining steps (Q-LEM-214, kept open) is reading what a case gave, and sending needs no word as long as the wiring says where things go — your remark that routing is natural and implicit. Second, the label you ask about. What a case caught already has the refined type of its pattern, so a later reading that asks `@dark` of a flow of `dark` has nothing to test. Where the results of several cases meet in one flow, that flow's type is their sum, and the sum's `tag` is the label; where nothing meets, nothing is carried. Third, instances. A case whose computation is layer 3 keeps no state, so its copies are interchangeable; P3 asks that their number be a bound known beforehand — chapter 4: « chaque anneau a une capacité qui est un grade » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)) — and P4 that the order of what they give be restored or journaled.

**Facts.**

- Orleans: « The Orleans Runtime automatically creates additional activations of a stateless worker grain if the existing ones are busy. The maximum number of activations per silo is limited by default by the number of CPU cores on the machine »; such activations « aren't individually addressable » (Orleans, stateless workers (https://learn.microsoft.com/en-us/dotnet/orleans/grains/stateless-worker-grains)).
- The old K archive listed the properties `:replicas`, `:policy` and `:growth-policy`, and the back-pressure policies `block` and `drop-oldest` (research (https://github.com/AntheaLiles/k7pl/blob/main/wiki/research.md)).

- **A — The type is the label; a `tag` only where cases meet; instances for cases without state, within a grade.** As above. A new instance is raised when a mailbox is full, up to a bound written as a grade; beyond it the writer waits. What the instances give is merged in the order the journal records.

  *For:* no cost that the text does not show (P3); a label only where something must be told apart. *Against:* a case that keeps state cannot be copied; the next automaton must know the wiring to know the type it receives.

- **B — Everything caught always travels with a label naming its case.**

  *For:* the next automaton reads the label without knowing the wiring. *Against:* a cost on every element, which P3 would have the text show.

- **C — No instance by itself: a full mailbox makes its writer wait; copies are asked by a property.**

  *For:* bounded and visible in the text. *Against:* against your answer on scalability.

#### Q-FRM-007 — Rules: the same form for logic and for constraints

**Fiche.**

- **Now in the specification:** the deductive extension: a set of rules compiled into `fix f`, relations as layer-1 arenas, semi-naive evaluation, stratified negation (`ERR-TER-002`); `[sql|…|sql]`, pure and terminating; refinement types and the solver of Phase 7
- **Recorded:** the semipositive rule for negation, taken in the closed world of the values present (sixth part); coverage graduated (VOC-2026-11-12-002)
- **Absorbs:** Q-LEM-115; part of Q-LEM-209

**Form.**

```text
[fix [case [join [edge @a @b] [path @b @c]] [path a c]]]   ;; layer 3: closed to a fixed point, and it ends
```

**Object.** A rule of a deductive engine is a case: its pattern joins facts through shared holes, and its computation gives a fact. Closed by `fix` over relations, it is chapter 4's deductive extension, in layer 3, where the whole program is then `fix f` (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)); `not` is its stratified negation. Read on a flow in layer 2, the same case fires at each new fact, which is what semi-naive evaluation does round by round: it « ne considère que les faits nouveaux du tour précédent ». The hole is the variable of logic programming and of constraint solving alike: Phase 3 unifies, and the solver of Phase 7 decides at compile time what it can of a pattern — that two cases are disjoint, that they cover, that an `and` accepts nothing — the rest staying a test the automaton runs.

**Facts.**

- Datalog: « evaluating Datalog programs always terminates »; bottom-up strategies « repeatedly add consequences of the rules until a fixpoint is reached » (Datalog (https://en.wikipedia.org/wiki/Datalog)).
- Constraint Handling Rules: « In contrast to Prolog, CHR rules are multi-headed and are executed in a committed-choice manner using a forward chaining algorithm » (CHR (https://en.wikipedia.org/wiki/Constraint_Handling_Rules)).
- Chapter 7: « Le calcul lui-même est un `fix` de couche 3 sur le type des relations, dont la hauteur finie tient au nombre fini de sommets » (chapter 7 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C7/CaseStudyIIIDeductiveEngineOnColumnarArenas.lean)).

- **A — Rules are cases: the deductive extension is written with this form.** `[sql|…|sql]` remains what it is, a text of another language.

  *For:* one form for matching, routing and deduction; a rule can be read on a flow or closed over a relation without being rewritten. *Against:* the kernel's `fix` and its theorem must be stated for cases; a proof obligation.

- **B — Rules stay in qualified literals; cases read flows and values only.**

  *For:* nothing to prove anew. *Against:* two ways to write a join: in a case and in a foreign text.

- **C — Rules are cases read in layer 2 only; the compiler writes the layer-3 fixed point.**

  *For:* the programmer writes one thing. *Against:* termination is no longer visible in the text.

#### Q-FRM-008 — Coverage, graduated

**Fiche.**

- **Your answer:** « Je pense que nous pouvons adopter A de manière graduée pour faciliter le prototypage et donc proposer un hybride entre A et B. » (VOC-2026-11-12-002)
- **Recorded:** a warning never blocks compilation unless a flag asks for it (VOC-2026-10-27-077)
- **Observed:** the glossary and Annex A refuse an uncovered combination of messages; chapter 4 refuses it only « dans le profil qui adopte la couverture exhaustive »
- **Absorbs:** Q-LEM-209, 210

**Object.** K7PL's own word for « graduated » is in its first page: to graduate, « dans un seul langage et sans changer de paradigme, le niveau de rigueur payé localement ». The question is what graduates coverage: something the program already says, or something set beside it. Chapter 6 has a precedent for the second: « En mode `+strict-tdd`, un symbole public sans doctest associé est lui-même rejeté » (chapter 6 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C6/VerificationAndTestStrategies.lean)).

- **A — By what K7PL already grades: the layer and the usage grade.** Coverage is required where it is owed: on a linear flow, each element having to be taken once; and on a value read in layer 3, which is total. Elsewhere an element no case catches goes on (unrestricted) or is dropped (affine), and the compiler says so in a remark.

  *For:* nothing to set; a prototype on unrestricted flows is free, and rigour comes with the grade. *Against:* no way to ask for more on an unrestricted flow.

- **B — By a flag: a warning by default, a refusal under a strict flag.**

  *For:* simple to explain; as `+strict-tdd`. *Against:* a program's meaning on unforeseen input depends on how it is compiled.

- **C — Both: A's minimum by structure, and a flag that turns the remaining remarks into refusals.**

  *For:* your hybrid: what is owed is always required, the rest can be raised. *Against:* two mechanisms.

### What follows

#### Q-DOS-001 — The dossiers that follow

**Object.** If Q-METH-003 keeps the method, which themes come next, and in what order (say the order in the comment)? Each takes up the questions set aside, as whole forms. The questions of lemma lots 2 and 3 that each would take up are named.

Several options may be chosen.

- **time — Time and order over flows.** Sequences of events, windows and deadlines, the model of time, previous values, the order of a mailbox, a flow faster than its reader (Q-LEM-117, 118, 223, 225 to 229).

- **effects — Sequencing and effects.** `bind` and the unit, operations and what resumes them, scoped operations, failures (Q-LEM-103, 111, 215); the faulty examples of `bind` are rewritten there.

- **objects — Objects and observations.** The negative product, codata and copatterns, actors, `invoke`, `summon` and `daemon` (Q-LEM-105, 106, 122).

- **types — Definitions, types and holes.** `def` and its envelopes, typed holes and generics, refinements, existentials, recursive types (Q-LEM-112 to 114).

- **resources — Resources and grades.** The pair, `box` and `unbox`, `free`, `slice`, budgets, `declassify` (Q-LEM-104, 123, 124).

- **place — Sources, places and distribution.** Which sources are flows, how a flow is simulated, `loc`, `move`, `at`, clusters (Q-LEM-120, 219, 220).

## Statement of 2026-11-12 (evening): the logic gates, and a misunderstanding of the layers

**Statement of the author — 2026-11-12 (VOC-2026-11-12-018), given in the conversation with an attached table, quoted as given.**

> En pièce jointe les portes logiques exactes avec leurs symboles, nom, usage en s-exp, tables de vérité.
>
> J'ai répondu à 6 questions sur 10 et m'arrete là pour l'instant parce qu'il y a encore un problème de compréhension fondamentale de K7PL

- **Reading:** the ten logical operators of K7PL are given with their symbols, names, S-expressions and truth tables (table below). The author answered six of the ten cards of dossier 1 and stops there: the dossier still misunderstands K7PL at its base. The six answers, recorded above under their cards (VOC-2026-11-12-012 to -017), say where: the layers.

**The table of the attachment**, transcribed. The four columns of results follow the rows of the author's tables: `a` and `b` true; `a` true and `b` false; `a` false and `b` true; both false. The symbol is described as drawn; glyphs are dealt with once every lemma is fixed (VOC-2026-11-03-018).

| Name | Symbol, as drawn | S-expression | T T | T F | F T | F F |
| --- | --- | --- | --- | --- | --- | --- |
| OR | `∨` | `(or a b)` | T | T | T | F |
| NOR | `∨` with a bar above | `(nor a b)` | F | F | F | T |
| XOR | `∨` with a bar below | `(xor a b)` | F | T | T | F |
| XNOR | `∨` with a bar above and a bar below | `(xnor a b)` | T | F | F | T |
| AND | `∧` | `(and a b)` | T | F | F | F |
| NAND | `∧` with a bar above | `(nand a b)` | F | T | T | T |
| IMPLY | `⇒` | `(imply a b)` | T | F | T | T |
| NIMPLY | `⇏` | `(nimply a b)` | F | T | F | F |

The two operators of one operand:

| Name | Symbol, as drawn | S-expression | T | F |
| --- | --- | --- | --- | --- |
| YES | `⌟` | `(yes a)` | T | F |
| NOT | `¬` | `(not a)` | F | T |

- **Corrected on the author's instruction (VOC-2026-11-12-022):** the attachment drew for NAND the table of NOR (F, F, F, T). The gate drawn, an AND whose output is negated, gives F, T, T, T, which the row above now records.

**What the six answers correct**, as read, to be confirmed by the author before dossier 1 is rewritten.

- The dossier placed every computation in layer 3 and left layer 2 to route. The author: layer 2 is a classic Lisp or Scheme on the heap, where one computes; layer 3 is passive, pure, made only of operators on the stack, and going there asks for an automaton.
- The dossier wrote `case` in layer 3 (Q-FRM-005, Q-FRM-007). The author: `case` triggers an action in reaction to a fact observed or read, and belongs to layer 2 only.
- The dossier let the flow's usage grade decide whether a case observes or takes (Q-FRM-002). The author: two words, `read`, which consumes, and `observe`, which looks at a flow that keeps its destination.
- The dossier separated connectives from a `join` (Q-FRM-004). The author: the logical operators, used directly.
- The dossier reduced a pattern to a construction with holes (Q-FRM-003). The author: a pattern can be tied to properties, grades, labels and types, and can be a regular expression or a character table; wildcards are typed holes and create patterns.

The cards Q-FRM-006, Q-FRM-007, Q-FRM-008 and Q-DOS-001 are not answered. They rest on the same readings and are left as asked until the dossier is rewritten.

## Confirmation of 2026-11-12: the corrected reading of the layers

After the statement above, five questions were put to the author in the conversation:

1. whether the corrected reading was right (layer 2 a classic Lisp or Scheme on the heap, where one computes, orchestrates and reacts; layer 3 passive and pure, made only of operators on the stack; `case` in layer 2 only; K7PL publish and subscribe, with `read`, which consumes, and `observe`, which looks at a flow that keeps its destination; patterns tied to properties, grades, labels and types, or being a regular expression or a character table, wildcards being typed holes; ten logical operators used directly);
2. what sends a computation to layer 3, and whether chapter 5's first example, `?increment-bounded`, stands;
3. whether `observe` takes the same `case` clauses as `read`;
4. whether NAND is F, T, T, T;
5. what `?` denotes in `@"jul?"`.

**Answer of the author — 2026-11-12 (VOC-2026-11-12-019 to -023), given in the conversation, quoted as given.**

> 1. Le résumé est juste
> 2. La couche 3 a vocation à accueillir des calculs de très haute performance (tenseurs, calcul matriciel, prise en charge de protocol strictement borné, etc.)
> 3. read peut même être abandonné si on applique une véritable logique pub/sub en sachant que le routage est instrumentable de manière expressive par les connecteurs monadiques
> 4. Oui corrige l'anomalie
> 5. Mon exemple etait purement indicatif et méritte d'être critiqué.

- **VOC-2026-11-12-019, reading:** the corrected reading of question 1 is right.
- **VOC-2026-11-12-020, reading:** layer 3 is meant for computation of very high performance: tensors, matrix computation, the handling of a strictly bounded protocol, and so on. Whether chapter 5's first example stands is not answered; it is asked in Q-FRM-107.
- **VOC-2026-11-12-021, reading:** `read` can even be abandoned if a true publish and subscribe logic is applied, routing being expressible by the monadic connectors. The connectors are read as the properties recorded on 2026-10-27 (VOC-2026-10-27-030, VOC-2026-10-27-061): `:return`, `:bind`; `:perform`, `:scoped`, `:try`, `:catch`; `:before`, `:after`, `:around`. This reading is put to the author in Q-FRM-103. Question 3 falls with `read`.
- **VOC-2026-11-12-022, reading:** NAND is F, T, T, T; the anomaly of the attachment is corrected in the table above.
- **VOC-2026-11-12-023, reading:** the example `@"jul?"` was only indicative and is to be criticised; done in Q-FRM-105.

A word corrected in this record: the author's « branchement » (VOC-2026-10-27-030) was translated by « branching ». It is a connection, a plug, as in « un seul bind qui branche l'expression à sa droite » (VOC-2026-11-03-006). From here on the record writes « connector ».

## Thematic dossier 1, second version, of 2026-11-12: observing a flow (Q-FRM-101 to Q-FRM-108, Q-DOS-002)

Opened on 2026-11-13, once the author had confirmed the corrected reading (above). The argument and its
sources are in [research](research.md), « Thematic dossier 1, second version (2026-11-12): observing a
flow ». Each card gives one form and asks about it as a whole. **Other** and **Clarify** are always
available.

Dossier 1, rewritten on 2026-11-12 after your corrections. You confirmed the reading it now starts from (VOC-2026-11-12-019 to -021). Layer 2 is a classic Lisp or Scheme on the heap, where one computes, orchestrates and reacts. Layer 3 is passive and pure, made only of operators on the stack, and meant for very-high-performance computation: tensors, matrix computation, strictly bounded protocols. `case` triggers an action in reaction to a fact, and exists in layer 2 only. K7PL is publish and subscribe: a flow is sent to the automaton that asks for it, `observe` looks at a flow that keeps its destination, and `read` may be abandoned, routing being written with the monadic connectors. The ten logical operators of your table are used directly. As you asked, TXR, AWK, jq, Perl and Raku were read again for patterns, with a survey of publish and subscribe; the reading is in research.md, « Thematic dossier 1, second version ». Each card gives one form and asks about it as a whole. Every example is on your scenario, frames sent to a display. In every example a computation is written in layer 2, between parentheses; brackets appear only where a matrix is computed. Every example has been checked against the nesting rule of the layers. Every word of the examples other than `observe`, `case` and the ten operators is a placeholder. An answer is a dated preference, ratified only in the global lot (VOC-2026-10-26-002). **Other** and **Clarify** are always available, and a comment is worth more than a choice.

**Withdrawn.** The four cards of the first version left unanswered are no longer shown on the page:

- Q-DOS-001: asked again as Q-DOS-002.
- Q-FRM-006: rewritten as Q-FRM-108.
- Q-FRM-007: withdrawn: it wrote `case` in layer 3; rules go to a later dossier (Q-DOS-002).
- Q-FRM-008: withdrawn: coverage is owed by what an automaton is sent, not by what it observes; it goes with automata and actors (Q-DOS-002).

### Observing and routing

#### Q-FRM-101 — Observing: the one form, and the place of `:on`

**Fiche.**

- **Your answers:** `observe` (VOC-2026-11-12-013): « un flux a déjà sa destination, en l'observant on peut réaliser des opérations par réaction sans dévier le flux »; « read peut même être abandonné si on applique une véritable logique pub/sub » (VOC-2026-11-12-021)
- **Recorded:** `case` is « le mot de déclanchement d'action par réaction à un fait observé/lu ce qui est une propriété exclusive de la couche 2 » (VOC-2026-11-12-016); cases do not know one another, and nothing happens when a pattern is not found (VOC-2026-11-12-003)
- **Now in the specification:** an actor's `:on (Increment :sets value …)`, « la forme abrégée d'une réaction »; chapter 3's `guard`, which consumes the messages it matches
- **Replaces:** Q-FRM-001 and Q-FRM-002 of the first version

**Form.**

```text
(observe frames
  (case @dark   (warn operator))
  (case @bright (dim display)))
```

**Object.** The form as you corrected it. An observer stands beside a flow that has its destination; each `case` reacts, in layer 2, and nothing is diverted. This is the one gesture of publish and subscribe: being notified. Taking is the gesture of tuple spaces and queues, where « consumers pull new tuples from the space in a synchronous style » (Eugster et al. (https://www.cs.princeton.edu/courses/archive/spr17/cos598D/PublishSubscribe03.pdf)). If `read` goes, one thing is left to place: the automaton a flow is sent to. Its reactions are written today in its `:on` clauses.

**Facts.**

- Eugster et al.: in publish and subscribe, « subscribers register their interest in an event, or a pattern of events, and are subsequently asynchronously notified of events generated by publishers » (The Many Faces of Publish/Subscribe (https://www.cs.princeton.edu/courses/archive/spr17/cos598D/PublishSubscribe03.pdf)).
- The same survey on Linda: « in() to import (and remove) a tuple from the tuple space, and read() to read (without removing) a tuple »; and on the event service: « every subscriber will receive an event for every event conforming to its interest » (Eugster et al. (https://www.cs.princeton.edu/courses/archive/spr17/cos598D/PublishSubscribe03.pdf)).
- Chapter 5: « la clause `:on … :sets` n'est que la forme abrégée d'une réaction » (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean)).

- **A — One form everywhere: an automaton observes what it is sent as it observes any flow.** `:on` becomes the abbreviation of `observe` inside an actor, its own input being the flow left unsaid.

  *For:* one form and one word for every reaction. *Against:* the text no longer tells the destination of a flow from those that look at it.

- **B — Two places: `observe` for a flow that goes elsewhere, `:on` for what the automaton itself is sent.**

  *For:* the destination is visible in the text; chapter 5's actor stays as written. *Against:* a reaction has two writings.

- **C — `read` stays beside `observe` after all, for what is taken.**

  *For:* your first answer (VOC-2026-11-12-014). *Against:* you said since that true publish and subscribe does without it.

**Answer of the author — 2026-11-14 (VOC-2026-11-14-002), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:** :on n'est pas une forme d'observe mais un déclancheur de séquence dans un acteur.
- **Reading:** two places (option B): `observe` for a flow that goes elsewhere, `:on` for what the automaton itself is sent. `:on` is not a form of `observe`: it triggers a sequence inside an actor.

#### Q-FRM-102 — Asking for a flow: by name, by type, by content

**Fiche.**

- **Your answers:** « un flux est envoyé à un automate le demandant » (VOC-2026-11-12-013); your sketch reads « un flux de donnée identifié » (VOC-2026-11-12-006)
- **Recorded:** everything is a pattern, and `@x` is every pattern of `x` (VOC-2026-11-04-002); « Un pattern peut etre lié à des propriétés, au grade, aux labels, aux types » (VOC-2026-11-12-016)

**Form.**

```text
(observe frames                          (case @dark (warn operator)))   ;; by name: the flow called `frames`
(observe @frame                          (case @dark (warn operator)))   ;; by type: whatever is published that is a `frame`
(observe (and @frame (not @test-frame))  (case @dark (warn operator)))   ;; by a pattern: types and properties, combined
```

**Object.** Publish and subscribe systems differ by how a subscriber says what it wants, and the survey names three ways. By topic: a name, with hierarchies and wildcards. By content: events are classified « according to the properties of the events themselves », and the filters « can be logically combined (and, or, etc.) to form complex subscription patterns ». By type: « a scheme that filters events according to their type », where « type safety can be ensured at compile-time » (Eugster et al. (https://www.cs.princeton.edu/courses/archive/spr17/cos598D/PublishSubscribe03.pdf)). K7PL's patterns already cover the three: a name or a label, a type or a refinement, properties, and the logical operators to combine them. The question is what may stand after `observe`.

**Facts.**

- NATS: « While publishers always send to a fully specified subject, subscribers can use wildcards to receive messages from multiple subjects » (NATS, subjects (https://docs.nats.io/nats-concepts/subjects)).
- The survey on what a subscriber knows: subscribers register « without knowing the effective sources of these events » (Eugster et al. (https://www.cs.princeton.edu/courses/archive/spr17/cos598D/PublishSubscribe03.pdf)).

- **A — A name: the flow is identified, as in your sketch; the patterns are in the cases.**

  *For:* the wiring is read from the text: each observer names its flow. *Against:* an observer must know the name of what it looks at.

- **B — A pattern: a name is the simplest one; a type, a refinement or a combination can stand there too.**

  *For:* « tout est motif »; subscription by type is checked at compile time, and an observer need not know who publishes. *Against:* the wiring must be computed from the types; an observer may receive flows it did not foresee.

- **C — A type, always.**

  *For:* one rule, checked at compile time. *Against:* two flows of one type cannot be told apart.

**Answer of the author — 2026-11-14 (VOC-2026-11-14-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Reading:** a pattern stands after `observe` (option B): a name is the simplest one; a type, a refinement or a combination can stand there too.

#### Q-FRM-103 — Routing: the destination of a flow, and the connectors

**Fiche.**

- **Your answer:** « le routage est instrumentable de manière expressive par les connecteurs monadiques » (VOC-2026-11-12-021)
- **Recorded:** « les constructions monadiques sont des "branchements" explicites déclarés avec le préfixe ":" donc ":bind something" et ":return somethingelse" » (VOC-2026-10-27-030); « un seul bind qui branche l'expression à sa droite (defun lambda :bind exp) » (VOC-2026-11-03-006); the families kept on 2026-10-27 (VOC-2026-10-27-061): `:return`, `:bind`; `:perform`, `:scoped`, `:try`, `:catch`; `:before`, `:after`, `:around`
- **A word corrected:** this record has translated « branchement » by « branching »; it is a connection, a plug, and the cards now write « connector »

**Form.**

```text
(capture camera :bind display)   ;; `:bind` plugs what the form gives into what stands on its right
```

**Object.** My reading of your sentence, to confirm: the monadic connectors are the properties recorded on 2026-10-27. `:bind` gives a flow its destination, as a pipe does. `:before` and `:after` attach a treatment whose result is not used, which is what an observer is. `:around` stands in the path and decides whether what it wraps runs: it is the only one that can divert. `:try` and `:catch` route a failure. If « monadique » meant instead the operators of one operand, `yes` and `not`, say so: the card is then beside the point.

**Facts.**

- jq: « The | operator combines two filters by feeding the output(s) of the one on the left into the input of the one on the right »; « If two filters are separated by a comma, then the same input will be fed into both » (jq manual (https://jqlang.org/manual/)).
- CLOS: « All the before methods are called, in most-specific-first order. Their values are ignored »; inside an around method, « call-next-method can be used to call the next method » (CLHS 7.6.6.2 (https://www.lispworks.com/documentation/HyperSpec/Body/07_ffb.htm)).

- **A — `:bind` writes the destination; `observe` is how one stands beside a flow; `:before`, `:after` and `:around` attach to a definition, as in CLOS.**

  *For:* each connector keeps the sense it was recorded with. *Against:* two ways to stand beside something: `observe` for a flow, `:after` for a definition.

- **B — The same connectors attach to flows: `:after` is an observer, `:around` an interception; `observe` is their long form.**

  *For:* one family for all routing; what `read` did is `:around`. *Against:* `observe` and `:after` then say one thing twice.

- **C — Other connectors are meant.**

**Answer of the author — 2026-11-14 (VOC-2026-11-14-003), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** :after n'est pas équivalent à observe car il agit sur le flux comme dans CLOS là où observe est parallele au flux.
- **Reading:** the monadic connectors are the properties recorded on 2026-10-27 (option A): `:bind` writes the destination of a flow; `observe` is how one stands beside a flow; `:before`, `:after` and `:around` attach to a definition, as in CLOS. `:after` is not equivalent to `observe`: it acts on the flow, as in CLOS, where `observe` is parallel to the flow.

### Patterns

#### Q-FRM-104 — What a pattern can be, and how what was caught is named

**Fiche.**

- **Your answer:** « Un pattern peut etre lié à des propriétés, au grade, aux labels, aux types, mais aussi une regex, une table de caractère, etc. » (VOC-2026-11-12-016)
- **Recorded:** `@` in front of a construction catches that pattern; what is caught has the refined type of its construction (VOC-2026-11-04-001); a held value is compared, without `^` (VOC-2026-11-06-001)
- **Already in K7PL:** a type name without a width is a typed hole (`int`, `str`); « une étiquette n'est jamais liante »; a field is read with the lens `view`; in an actor's `:on` clause « `state` désigne l'état de l'acteur », without being declared
- **Replaces:** Q-FRM-003 of the first version, kept open

**Form.**

```text
(case @frame                    (count it))   ;; a type
(case @dark                     (count it))   ;; a refinement, declared in layer 1
(case @(Reply id str)           (count it))   ;; a construction: `id` is held and compared, `str` is a typed hole
(case @(Order :priority urgent) (count it))   ;; a property
(case @"jul*"                   (count it))   ;; a text with holes: the next card
```

**Object.** One relation, « is this an x? », for many kinds of x. Raku has it in one operator: « The semantics are left to the type of the right-hand side operand » — a type checks the type, a regular expression matches, a piece of code is called (Raku, operators (https://docs.raku.org/language/operators)). On values held, TXR needs no mark either: a variable without a binding matches and binds, and one that has a value is compared, « The bound variable is effectively replaced by the text which it denotes » (TXR manual (https://man.uex.se/1/txr)). K7PL can go one step further with what it has: a bare type name is already a typed hole, so inside `@( … )` a type name is a hole of that type and anything else is held and compared. No mark, and no word that both binds and compares. What remains is how a reaction names what was caught. In the examples, `it` is a placeholder for that.

**Facts.**

- Raku's refinement of a type is a pattern of its own: « A `subset` declares a new type that will re-dispatch to its base type. If a where clause is supplied any assignment will be checked against the given code object », as `subset Positive of Int where * > -1` (Raku, type system (https://docs.raku.org/language/typesystem)).
- AWK names nothing: the record is `$0` and « The awk utility shall denote the first field in a record $1, the second $2, and so on » (POSIX, awk (https://pubs.opengroup.org/onlinepubs/9799919799/utilities/awk.html)). jq's filter receives its input as `.`.
- Raku's regexes take Unicode properties as classes: « `<:Lu>` matches a single, uppercase letter », and « Categories can be used together, with an infix operator » (Raku, regexes (https://docs.raku.org/language/regexes)). Perl's `tr` works from a table: « the transliteration table is built at compile time » (perlop (https://perldoc.perl.org/perlop)).

- **A — Nothing is named in a pattern: the reaction receives what was caught under one fixed word, and reads its parts with `view`.**

  ```text
  (case @(Reply id str) (parse (view it body)))
  ```

  *For:* `@` has one reading and a pattern never binds; AWK's `$0`, jq's `.`, the `state` of `:on`. *Against:* one observer inside another hides the outer word.

- **B — The whole is named by a property after the pattern; its parts are read with `view`.**

  ```text
  (case @(Reply id str) :as reply (parse (view reply body)))
  ```

  *For:* explicit, and it nests. *Against:* one more property to write each time.

- **C — A hole can carry a name, as TXR's variables and ML's patterns.**

  *For:* the part is at hand without `view`. *Against:* needs a writing for a named hole, which `@name` cannot be while `@x` is every pattern of `x`.

**Answer of the author — 2026-11-14 (VOC-2026-11-14-004), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

#### Q-FRM-105 — Holes in a text: your `@"jul?"`, criticised

**Fiche.**

- **Your example:** « je pourrais demander @"jul?" Et trouver jul jule julie julia juliette etc. => ici je veux indiquer que les wildcards font parti des trous typés et permettent également de créer des pattern » (VOC-2026-11-12-016); « Mon exemple etait purement indicatif et méritte d'être critiqué » (VOC-2026-11-12-023)
- **Recorded:** a plain text never interpolates; `text@text` is a text; a class is written `:alpha:`, and `[[:alpha:]]` holds its code points

**Form.**

```text
@"jul*"            ;; the glob alphabet: `*` any text, `?` one grapheme
@("jul" str)       ;; the same pattern, its hole written as a typed hole
@("jul" :alpha:)   ;; `jul` then one letter: a hole typed by a class
```

**Object.** The criticism, in three points. First, `?` has three senses. In a shell pattern « A <question-mark> is a pattern that shall match any character » (POSIX, pattern matching (https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html)); in a regular expression « The `?` quantifier makes the preceding atom match zero or once » (Raku, regexes (https://docs.raku.org/language/regexes)); in SQL's `LIKE` it is an ordinary character, the wildcards being `_` and `%` (PostgreSQL (https://www.postgresql.org/docs/current/functions-matching.html)). None of the three gives your five names as whole texts: the shell pattern finds only `jule`, the regular expression only `ju` and `jul`. Your list is what `jul*` gives in a shell, `jul%` in SQL, or a search for `jul` inside the text. Second, the example therefore hides two choices: which alphabet of wildcards, and whether a pattern must cover the whole text or may be found inside it. Third, what your sentence adds is the part to keep: a wildcard is a typed hole. `?` is a hole of one grapheme and `*` a hole of `str`; a class types a hole more finely. A plain text never interpolates, so it is `@` that makes the text a pattern.

**Facts.**

- POSIX: « The <asterisk> ('*') is a pattern that shall match any string, including the null string » (POSIX, pattern matching (https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html)).
- SQL: « An underscore (`_`) in pattern stands for (matches) any single character; a percent sign (`%`) matches any sequence of zero or more characters » (PostgreSQL, LIKE (https://www.postgresql.org/docs/current/functions-matching.html)).
- TXR writes a hole with its width or its regular expression: a variable with a regular expression « extends over all characters from the current position which match the regular expression » (TXR manual (https://man.uex.se/1/txr)).

- **A — The shell alphabet inside `@"…"`: `?` one grapheme, `*` any text; the whole text must match.**

  ```text
  @"jul*"
  ```

  *For:* the shortest; known from shells and from the subjects of publish and subscribe. *Against:* `?` and `*` become special in a pattern text and need an escape; the holes have no finer type.

- **B — Holes written as typed holes: a text pattern is a sequence of texts and holes.**

  ```text
  @("jul" str)
  ```

  *For:* your sentence to the letter; no character becomes special; a class or a type refines the hole. *Against:* longer for the frequent case.

- **C — Both: A is the short writing of B, the formatter showing either.**

  *For:* short to write, one meaning. *Against:* two writings to learn.

- **D — The alphabet of regular expressions, as Perl and Raku.**

  ```text
  @"jul.*"
  ```

  *For:* the most expressive, and R-expressions already compile it. *Against:* the class of the automaton is less visible; `?` then means « optional », not « one character ».

**Answer of the author — 2026-11-14 (VOC-2026-11-14-005), given in the clickable questionnaire, quoted as given.**

- **Choice:** OPEN
- **Reading:** kept open.

#### Q-FRM-106 — The ten operators: how many operands

**Fiche.**

- **Your table:** `or`, `nor`, `xor`, `xnor`, `and`, `nand`, `imply`, `nimply`, each written `(op a b)`; `yes` and `not`, written `(op a)` (VOC-2026-11-12-018); NAND corrected to F, T, T, T (VOC-2026-11-12-022)
- **Your answer:** « Utiliser directement les opérateurs logiques » (VOC-2026-11-12-015)
- **Recorded:** « Couche 3 monadique ET dyadique, pas de triadique. En couche 2 c'est n-air. » (VOC-2026-10-28-033)
- **Replaces:** Q-FRM-004 of the first version

**Form.**

```text
(observe frames
  (case (and @dark (not @corrupt)) (warn operator))
  (case (nor @dark @bright)        (store sample)))
```

**Object.** Used directly: a pattern answers yes or no of what is observed, so the operators of the language combine patterns and none is reserved for them. AWK does so: its pattern is « any valid expression, a range specified by two expressions separated by a comma », or one of two special words (POSIX, awk (https://pubs.opengroup.org/onlinepubs/9799919799/utilities/awk.html)). So does a subscription by content, whose constraints « can be logically combined (and, or, etc.) » (Eugster et al. (https://www.cs.princeton.edu/courses/archive/spr17/cos598D/PublishSubscribe03.pdf)). Having one or two operands, the ten are also layer-3 operators as they stand: on vectors of truth values, cell by cell. One point remains for layer 2, whose words take any number of operands. `and` and `or` extend without question. With three operands `xor` has two readings, and `imply` and `nimply` have none.

**Facts.**

- TXR combines patterns the same way: `all` fails « If any of the clauses fails to match »; `some` succeeds « If any of the clauses succeed »; `none` « succeeds only if all of the clauses fail » (TXR manual (https://man.uex.se/1/txr)).
- Raku's junctions: `all`, « no value evaluates to False »; `any`, « at least one value evaluates to True »; `one`, « exactly one value evaluates to True »; `none`, « no value evaluates to True » (Raku, Junction (https://docs.raku.org/type/Junction)).

**Note.** One more point, for your comment and for the dossier on time: `(and @order @payment)`. No single element is both. Either the pattern matches nothing, or it asks for the two events together, what the survey calls correlation: « participants can subscribe to logical combinations of elementary events and are only notified upon occurrence of the composite events ». The second reading needs to say within what span of time.

- **A — Two operands, as your table; more by nesting.**

  ```text
  (and @dark (and (not @corrupt) (not @test-frame)))
  ```

  *For:* the table is the whole definition; the same words in layers 2 and 3. *Against:* layer 2 nests where its other words do not.

- **B — Any number of operands in layer 2 where the sense is one: `and`, `or`, `nand`, `nor`; `xor` and `xnor` by parity; `imply` and `nimply` of two.**

  ```text
  (and @dark (not @corrupt) (not @test-frame))
  ```

  *For:* layer 2's habit; parity is what nesting `xor` gives. *Against:* `(xor a b c)` is true when all three are, which surprises.

- **C — As B, but `xor` of several operands means exactly one, as Raku's `one`.**

  *For:* the sense most readers expect of « one or the other ». *Against:* `(xor a b c)` is no longer `(xor a (xor b c))`: the n-ary word and the table part ways.

**Answer of the author — 2026-11-14 (VOC-2026-11-14-006), given in the clickable questionnaire, quoted as given.**

- **Choice:** B
- **Justification:**

  > Un LSP devrait indiquer au développeur les conditions de succes des opérateurs.
  >
  > Not également, nous devons ajouter `equiv` `equal` `nequiv` `nequal` etc. (Les comparateurs de valeurs, formes, etc.)

- **Reading:** in layer 2, `and`, `or`, `nand` and `nor` take any number of operands, `xor` and `xnor` read by parity, and `imply` and `nimply` take two (option B). A language server should show the developer the conditions under which each operator succeeds. To add: `equiv`, `equal`, `nequiv`, `nequal` and the like, the comparators of values, forms and so on.
- **Put back to the author:** the comparators are a family of their own, to weigh in the dossier on definitions, types and holes: equality of values, of forms (structural), of types, and their negations.

### Layers

#### Q-FRM-107 — What layer 3 is asked for; chapter 5's sentence and its first example

**Fiche.**

- **Your answers:** « La couche 3 a vocation à accueillir des calculs de très haute performance (tenseurs, calcul matriciel, prise en charge de protocol strictement borné, etc.) » (VOC-2026-11-12-020); layer 2 is « un Lisp/Scheme classique, sur le heap », and `[add value 1]` « serait overkill » (VOC-2026-11-12-017); « La couche 3 utilise uniquement des opérateurs sur la stack » (VOC-2026-11-12-016)
- **Recorded:** « les automates compilés en couche 3 sont invoqués paresseusement par l'orchestrateur » (fifth part)
- **Now in the specification:** « Écrire du K7PL, c'est choisir, à chaque expression, le fragment le moins permissif que la tâche autorise »; a bounded counter whose increment is « une fonction pure de couche 3 » (`lst:fonction-pure`), called between brackets from `:on`; « la couche 2 orchestre et produit, la couche 3 calcule et termine »
- **Replaces:** Q-FRM-005 of the first version

**Form.**

```text
{def dark :type {{f frame [lt mean f 16]}}}   ;; layer 1 declares the type; the mean of a matrix is layer-3 work

(observe frames
  (case @dark   (add dark-count 1))           ;; a counter: layer 2, where any Lisp computes
  (case @bright (store [histogram it])))      ;; the histogram of a matrix: layer 3, between brackets
```

**Object.** The corrected reading in one example: the counter is computed in layer 2, and brackets appear where a matrix is computed. The specification points the other way in three places: its rule of the least permissive fragment sends every pure computation to layer 3, its first example is a counter written there, and its summary of the roles leaves computing to layer 3 alone (chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/InPractice.lean), chapter 5 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C5/UniversalSExpressions.lean)). The first version of this dossier followed them. Whether the specification changes is yours to decide, and nothing is applied without your go-ahead.

- **A — Rewrite the three: the rule says what layer 3 is for, the roles say that layer 2 computes, the example counts in layer 2 and shows layer 3 on a matrix or a bounded protocol.**

  *For:* the specification says what you say. *Against:* the example runs through four listings of chapter 5 and the text around them; a wide change.

- **B — Keep the rule and add its cost, a bracket asking for an automaton; change the example only.**

  *For:* a smaller change. *Against:* the rule still reads as « pure, hence layer 3 ».

- **C — Leave the three as they are.**

  *For:* nothing to rewrite. *Against:* the next reader makes the mistake this dossier made.

**Answer of the author — 2026-11-14 (VOC-2026-11-14-007), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Justification:** La vision doit être claire : tu touche à la mémoire c'est couche 1 ; tu fait un dev classique voir non optimisé c'est couche 2 ; tu veux la plus grande puissance de calcul c'est couche 3 ; et il y a un "prix d'expressivité" à chaque fois.
- **Reading:** chapter 5's three passages are to be rewritten (option A): the rule says what layer 3 is for, the roles say that layer 2 computes, and the first example counts in layer 2 and shows layer 3 on a matrix or a bounded protocol. The vision to state: touching memory is layer 1; ordinary development, even unoptimised, is layer 2; the greatest computing power is layer 3; and each time there is a « prix d'expressivité ».
- **Put back to the author:** applying the rewrite to `spec/` waits for the author's go-ahead, as every change to the specification: chapter 5's rule of the least permissive fragment, its summary of the roles, the four listings of the bounded counter, and chapter 1's table of dimensions, which gives layer 3 the « Paradigme » « Fonctionnel total ».

#### Q-FRM-108 — What a reaction gives: publication, label, instances

**Fiche.**

- **Your answer:** « 1 flow and 3 patterns to catch with dedicated actions to run on them, the flow is divided and piped to 3 sub-automatas ; […] the flow is wired to a single automata with its mailbox until the mailbox is full and a new instance of the automata is rased to assure scalability » (VOC-2026-11-12-001)
- **You asked:** « Il serait intéressant d'évaluer si un pattent trouvé est passé avec un label pour faciliter son identification par l'automate suivant ou non »
- **Recorded:** the injection into a sum is `tag` (VOC-2026-11-03-011); an operation's continuation is a function, applied, limited by its grade (VOC-2026-11-12-005)
- **Replaces:** Q-FRM-006 of the first version, not answered

**Form.**

```text
(observe frames
  (case @dark (mean-of it) :bind dark-means))   ;; what the reaction gives is published to `dark-means`

(observe dark-means
  (case @near-black (warn operator)))
```

**Object.** Under publish and subscribe a reaction that only reacts publishes nothing; one that gives something publishes it where its connector says. On the label you asked to evaluate: what a case caught has the refined type of its pattern, and subscription by type lets the next observer ask for that type, with nothing to test again. Where what several cases give is published to one flow, that flow's type is their sum, and the sum's `tag` tells them apart. So the type is the label, and a `tag` is carried only where flows meet. On instances: P3 asks that their number be known beforehand — chapter 4, « chaque anneau a une capacité qui est un grade » (chapter 4 (https://github.com/AntheaLiles/k7pl/blob/main/spec/Spec/C4/SystemScale.lean)) — and a reaction that keeps state cannot be copied.

**Facts.**

- Orleans: « The Orleans Runtime automatically creates additional activations of a stateless worker grain if the existing ones are busy. The maximum number of activations per silo is limited by default by the number of CPU cores on the machine » (Orleans, stateless workers (https://learn.microsoft.com/en-us/dotnet/orleans/grains/stateless-worker-grains)).
- The survey on subscription by type: it « can lead to a natural description of content-based filtering through public members of the considered event type » (Eugster et al. (https://www.cs.princeton.edu/courses/archive/spr17/cos598D/PublishSubscribe03.pdf)).

- **A — The type is the label; a `tag` only where flows meet; instances for reactions without state, up to a bound written as a grade.** Beyond the bound, whoever publishes waits.

  *For:* no cost that the text does not show; a label only where something must be told apart. *Against:* the next automaton must know the types published to it.

- **B — Everything caught always travels with a label naming its case.**

  *For:* the next automaton reads the label and needs nothing else. *Against:* a cost on every element, which P3 would have the text show.

- **C — No instance by itself: copies are asked by a property.**

  *For:* bounded and visible. *Against:* against your answer on scalability.

**Answer of the author — 2026-11-13 (VOC-2026-11-13-001), given in the clickable questionnaire, quoted as given.**

- **Choice:** A
- **Reading:** the type is the label, and a `tag` is carried only where what several cases give meets in one flow; a reaction without state may have instances, up to a bound written as a grade, beyond which whoever publishes waits (option A).

### What follows

#### Q-DOS-002 — The dossiers that follow

**Object.** Which themes come next, and in what order (say the order in the comment)? Each takes up, as whole forms, the questions set aside.

Several options may be chosen.

- **layer3 — Layer 3: the operators on the stack.** Tensors, matrix computation, strictly bounded protocols; the line of CBQN, Uiua, KAP, J and FIXAPL; what replaces `choose` and `select` (Q-LEM-213).

- **time — Time, order and correlation over flows.** Two events « together », sequences, windows and deadlines, previous values, the order of a mailbox, a flow faster than its observers (Q-LEM-117, 118, 223, 225 to 229).

- **connectors — The connectors, sequencing and effects.** The whole inventory of connectors, `bind` and the unit, operations and what resumes them, failures (Q-LEM-103, 111, 215); the faulty examples of `bind` are rewritten there.

- **actors — Automata, actors and what they are sent.** Destinations and their mailboxes, coverage of what an automaton is sent, `invoke`, `summon` and `daemon`, objects and observations (Q-LEM-105, 106, 122, 209).

- **rules — Rules and deduction.** A rule as an observer that correlates facts and publishes one; the fixed point computed in layer 3; negation and its strata (Q-LEM-115).

- **types — Definitions, types and holes.** `def` and its envelopes, typed holes and generics, refinements, existentials, recursive types (Q-LEM-112 to 114).

- **resources — Resources, grades, places.** The pair, `box` and `unbox`, `free`, `slice`, budgets, `declassify`, `loc` and `move`, sources and their simulation (Q-LEM-104, 120, 123, 124, 219, 220).

**Answer of the author — 2026-11-14 (VOC-2026-11-14-008), given in the clickable questionnaire, quoted as given.**

- **Choice:** actors, rules, types, resources
- **Justification:** Je veux qu'on consolide les actions de couches 1 avant d'approfondir les autres couches qui en dérivent.
- **Reading:** the dossiers to come are automata and actors, rules and deduction, definitions, types and holes, and resources, grades and places. The author wants to consolidate the actions of layer 1 before going deeper into the layers that derive from it. Layer 3's operators, time and order, and the connectors with sequencing and effects are not chosen for now.
- **Put back to the author:** the order among the four. Read from the justification: what layer 1 does first (definitions and types, then resources and grades), then what derives from it (automata and actors, rules).

## Statement of 2026-11-14: n-ary logic, layer 3, layer 1, and when the specification is written

After the answers to dossier 1, second version, three questions were put to the author in the conversation: whether the reading of layer 1 was right (a strictly linear context, a budget and a `tick`; four families of actions: declaring and typing, holding memory, touching the outside world, supervising); whether the proposed order of the dossiers suited (dossier 2 on layer 1, merging definitions and types with resources and grades; then automata and actors; then rules); and whether chapter 5's rewrite (Q-FRM-107) is applied now or once the dossiers are done, chapter 1's table of dimensions giving layer 3 the « Paradigme » « Fonctionnel total ».

**Statement of the author — 2026-11-14 (VOC-2026-11-14-009 to -013), given in the conversation, quoted as given.**

> Logique de couche 2 : tous sont n-air.
> La couche 3 reste bien fonctionnelle totale au sens premier du terme.
> Ta définition de couche 1 est ok. L'ordre me convient. Les rédactions se font une fois que nous avons fini de tout traiter car nous devrions itérrer probablement sur divers points.

- **VOC-2026-11-14-009, reading:** in layer 2 all ten logical operators are n-ary. This corrects the reading of Q-FRM-106 (VOC-2026-11-14-006), which kept `imply` and `nimply` to two operands. Put back: the n-ary reading of `imply` and `nimply`, proposed as the right fold, `(imply a b c)` being `(imply a (imply b c))`, that is `(imply (and a b) c)`; and of `xor` and `xnor`, read by parity.
- **VOC-2026-11-14-010, reading:** layer 3 stays functional and total in the first sense of the term: chapter 1's « Fonctionnel total » stands.
- **VOC-2026-11-14-011, reading:** the reading of layer 1 is right: a strictly linear context, with a finite budget in the grades and a `tick` in the effects; four families of actions, declaring and typing, holding memory, touching the outside world, supervising.
- **VOC-2026-11-14-012, reading:** the order suits: dossier 2 on layer 1, then automata and actors, then rules and deduction.
- **VOC-2026-11-14-013, reading:** the writing of the specification comes once everything has been dealt with, since several points will probably be iterated on. Nothing is applied to `spec/` or `lexicon/` before then, chapter 5's rewrite (Q-FRM-107) included.

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

**Answer of the author — 2026-11-03 (VOC-2026-11-03-017), given in the conversation, quoted as given.**

> Pour catch c'est le même objet (généralisation du pattern matching)

- **Reading:** the `catch` of Q-LEM-015 and Q-LEM-016 and the `catch` of the kernel's `try c catch c` are one object, a generalisation of pattern matching. What it gathers and how it is written are asked in lemma lot 2 (Q-LEM-101, Q-LEM-102).


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
