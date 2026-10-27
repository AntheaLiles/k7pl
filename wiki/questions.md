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
- Tcl: `\a` `\b` `\f` `\n` `\r` `\t` `\v` `\\`, octal `\ooo`, `\xhh`, `\uhhhh`, `\Uhhhhhhhh` (Tcl(n), rule 9 (https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm)).

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


## Lot of 2026-10-27, fifth part: escapes, one rule for strings, monomorphisation, branchings and definitions, numbers, white brackets

Questions opened by the answers to the fourth part. They follow the
same rules: options to enumerate and objectify, then the author's
choice; **Other** and **Clarify** are always available. The
options were built from the research recorded in
[research](research.md), "Reading lot: research of 2026-10-27, fifth part".

Words of the examples that no answer has fixed yet (`accept`, `outcome`, `def`, `defunc`…) are placeholders.

### Strings

#### Q-STR-301 — Escapes: other traditions

**Object.** The backslash lists of the fourth part (POSIX, C, Rust) did not satisfy you (Q-STR-201). Here are seven other traditions, each answering in its own way the three needs of an escape list: writing the quote itself, writing a control character, writing any character by its number. Several may be combined; any escape outside the list K7PL keeps is refused (Q-STR-102), with the first code of `ERR-LEX` (Q-STR-205). Strings already span lines (Q-STR-103), so a line break never needs an escape.

**Facts.**

- Ada: `string_element ::= "" | non_quotation_mark_graphic_character`; « A string_element is either a pair of quotation marks (""), or a single graphic_character other than a quotation mark » (Ada RM, 2.6 (https://www.adaic.org/resources/add_content/standards/22rm/html/RM-2-6.html)). BQN: « Pairs of quotes `""` in between represent one quote character, and other characters (including `'`) represent themselves » (BQN, syntax (https://mlochbaum.github.io/BQN/doc/syntax.html)); « the character with code point `n` is `@+n` » (BQN, arithmetic (https://mlochbaum.github.io/BQN/doc/arithmetic.html)). SQL doubles its quote too (fourth part, research).
- Common Lisp: « If a single escape character is seen, the single escape character is discarded, the next character is accumulated, and accumulation continues » (CLHS 2.4.5 (https://www.lispworks.com/documentation/HyperSpec/Body/02_de.htm)): `\` takes the next character as it is, and there is no other escape.
- Python: `\N{name}`, « Named Unicode character » (Python reference, 2.5.4 (https://docs.python.org/3/reference/lexical_analysis.html)). Haskell names the ASCII controls, `\NUL` `\SOH` … `\ESC` … `\DEL`, and writes `\^A` for a control; « The escape character `\&` is provided as a “null character” to allow strings such as `"\137\&9"` and `"\SO\&H"` to be constructed » (Haskell 2010, §2.6 (https://www.haskell.org/onlinereport/haskell2010/haskellch2.html)).
- XML: `CharRef ::= '&#' [0-9]+ ';' | '&#x' [0-9a-fA-F]+ ';'`; `&` and `<` « MUST be escaped using either numeric character references or the strings "&amp;" and "&lt;" » (XML 1.0, §2.4 and §4.1 (https://www.w3.org/TR/xml/)). R7RS: `\x<hex scalar value>;`, « specified character (note the terminating semi-colon) » (R7RS, §6.7 (https://small.r7rs.org/attachment/r7rs.pdf)).
- JSON: « All Unicode characters may be placed within the quotation marks, except for the characters that MUST be escaped: quotation mark, reverse solidus, and the control characters (U+0000 through U+001F) » (RFC 8259, §7 (https://www.rfc-editor.org/rfc/rfc8259#section-7)). URIs: « A percent-encoded octet is encoded as a character triplet, consisting of the percent character "%" followed by the two hexadecimal digits representing that octet's numeric value » (RFC 3986, §2.1 (https://www.rfc-editor.org/rfc/rfc3986#section-2.1)), the rule K7PL took for spaces in paths (Q-STR-203).

Several options may be chosen.

- **double — Doubling, no escape character (Ada, SQL, BQN).** A quote is written twice; nothing else is special. A control character is written as itself in a string that spans lines, or computed outside the literal, as BQN's `@+10`. Example: `"say ""hi"""`. *For:* no backslash at all. *Against:* `""` can no longer open a raw string (Q-STR-302); no tab written visibly.
- **single — One escape, the next character as it is (Common Lisp).** `\"` and `\\` only; every other escape is refused. Example: `"say \"hi\" or \\"`. *For:* the smallest list; `\` keeps one meaning. *Against:* no control character written visibly.
- **named — Characters by their Unicode name (Python, Raku).** Example: `"col\N{CHARACTER TABULATION}umn"`. *For:* readable; Unicode names are stable. *Against:* long.
- **ascii — ASCII mnemonics (Haskell).** Example: `"col\HTumn\LF"`. *For:* short names from one table. *Against:* `\SOH` and `\SO` followed by `H` collide: Haskell needs `\&`.
- **term — A number ended by a semicolon (XML, R7RS).** Example: `"\x41; \x1F600;"`. *For:* any code point; the end of the number is visible, with no fixed width and no braces. *Against:* outside strings, `;` already marks comments and disabled trees.
- **json — JSON's list.** Example: `\"  \\  \/  \b  \f  \n  \r  \t  \uXXXX`. *For:* a K7PL string is a JSON string. *Against:* `\uXXXX` reaches only the first 65,536 code points; beyond, two escapes (a surrogate pair).
- **percent — Percent-encoding, as paths.** Example: `"line%0Anext, 100%25"`. *For:* one rule for paths and strings. *Against:* encodes bytes, not characters; every `%` of a text becomes `%25`.

#### Q-STR-302 — One rule for every string

**Object.** You ask that `""`, `"string"`, `""string""` and `"""string"""` be treated alike (Q-STR-202). Already decided: a string spans lines (Q-STR-103); `""…""` is a raw string, with the meaning of Raku's `｢…｣` (Q-STR-104); a heredoc is written between triple quotes (Q-STR-204). One conflict remains: `""` is also the empty string.

**Facts.**

- CommonMark: « A backtick string is a string of one or more backtick characters (`) that is neither preceded nor followed by a backtick. A code span begins with a backtick string and ends with a backtick string of equal length »; « If the resulting string both begins and ends with a space character, but does not consist entirely of space characters, a single space character is removed from the front and back » (CommonMark 0.31.2, §6.1 (https://spec.commonmark.org/0.31.2/#code-spans)).
- C#: « A raw string literal starts and ends with a minimum of three double quote (") characters »; « When your string literal contains three consecutive double-quotes, you start and end the raw string literal with four double quote characters »; for a raw string on several lines, « Any whitespace to the left of the closing quotes is removed from all lines of the raw string literal » (C# reference, raw string literals (https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/raw-string)). `""` stays the empty string.
- OCaml: « Quoted strings are delimited by a matching pair of `{ quoted-string-id |` and `| quoted-string-id }` with the same quoted-string-id on both sides » (OCaml manual, lexical conventions (https://ocaml.org/manual/5.2/lex.html)). Go: raw strings stand between back quotes, « Within the quotes, any character may appear except back quote » (Go specification (https://go.dev/ref/spec#String_literals)).

- **A — The count of quotes (CommonMark's rule).** A string opens with a run of *n* quotes and closes at the next run of exactly *n*. One quote: escapes apply (Q-STR-301). Two or more: raw, as `｢…｣`; with three or more, a block when the opening run ends its line, the indentation of the closing run being removed from every line (Q-STR-204). A run of two quotes followed by a space, a delimiter or the end of a line is the empty string. *For:* one rule for every length, your three forms kept. *Against:* a raw string cannot begin with a space after two quotes (it would read as the empty string): it takes three.

  ```text
  ""                 ;; the empty string
  "a \"b\""          ;; one quote: escapes
  ""a "b" c""        ;; two: raw, as ｢a "b" c｣
  """a ""b"" c"""    ;; three: raw, may hold ""
  """
    a block
    """              ;; three, alone on the line: a block
  ```

- **B — C#'s rule.** `""` is always the empty string; a raw string takes at least three quotes, and as many as needed to hold shorter runs; a block when the opening run ends its line. *For:* no exception; a rule in use (C# 11). *Against:* `""…""` of Q-STR-104 becomes `"""…"""`.

  ```text
  ""                 ;; the empty string
  """a "b" c"""      ;; raw
  """"a """b""" c""""  ;; raw, holds """
  ```

- **C — Two quotes typed, corner brackets stored.** `""` is the empty string; the file holds `｢…｣`, which the editor or the formatter writes when `""…""` is typed; blocks between triple quotes. *For:* no exception in the reader. *Against:* non-ASCII characters in files; a formatter becomes part of the toolchain.

### Monomorphisation

#### Q-TYP-301 — A mechanism, from chapter 6 and from MLton and rustc

**Object.** You asked (Q-TYP-203) for the mechanisms of other compilers, weighed, then for one that keeps the best of them without distorting chapter 6. Chapter 6 already fixes: Phase 3 « monomorphise chaque appel générique en une copie concrète », once (« La monomorphisation, elle, ne s'exécute qu'une seule fois »); monomorphisation « n'est qu'une intégration dirigée par les types » and decrements the budget of specialisation, a grade carried by the unit of compilation, shared with inlining (« une seule décision les gouverne »); the interface of a unit carries its grade (`thm:interface_jugement`); a binary is addressed by the BLAKE3 hash of its normalised AST. Annex A refuses dynamic dispatch: `ERR-POL-001`, « Distribution dynamique ou table virtuelle détectée. Utiliser une résolution `comptime` ou des variantes monomorphes ».

**Facts.**

- MLton: « The monomorphiser works by making one pass over the entire program », with « a cache for each variable declared in a polymorphic declaration that maps a lists of type arguments to a new variable name »; the instances are finite « due to the absence of polymorphic recursion in SML » (MLton guide, Monomorphise (https://github.com/MLton/mlton/blob/master/doc/guide/src/Monomorphise.adoc)); « Whole-program compilation is an integral part of the design of MLton and is not likely to change » (MLton guide, WholeProgramOptimization (https://github.com/MLton/mlton/blob/master/doc/guide/src/WholeProgramOptimization.adoc)).
- rustc: « The roots of the mono item graph correspond to the public non-generic syntactic items »; then, « Starting from the roots, find uses […] until no more new nodes are found »; « A generic definition in crate X might produce monomorphizations that are compiled into crate Y »; a lazy strategy, « items will only be instantiated when actually used » (rustc 1.80.0, collector (https://github.com/rust-lang/rust/blob/1.80.0/compiler/rustc_monomorphize/src/collector.rs)). Limits: `recursion_limit`, 128 by default; `type_length_limit`, « the maximum number of type substitutions allowed when constructing a concrete type during monomorphization » (Rust reference, limits (https://doc.rust-lang.org/reference/attributes/limits.html)).
- C++: « There is an implementation-defined quantity that specifies the limit on the total depth of recursive instantiations […]. The result of an infinite recursion in instantiation is undefined », with `X<T>` requiring `X<T*>`, which requires `X<T**>`… (C++ draft, [temp.inst] (https://eel.is/c++draft/temp.inst)). Zig: « Compile-time parameters is how Zig implements generics. It is compile-time duck typing. » (Zig 0.14.0 (https://ziglang.org/documentation/0.14.0/)).
- Code shared at run time: Go 1.18 generates « a single chunk of assembly for each unique GC shape », each taking « a *dictionary* » (Go design, GC shape stenciling (https://github.com/golang/proposal/blob/master/design/generics-implementation-gcshape.md)); .NET makes one copy per value type, while « every time that a constructed type is instantiated with a reference type as its parameter, regardless of what type it is, the runtime reuses the previously created specialized version » (.NET guide (https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/generics-in-the-run-time)); Swift specialises only « If the generic function's definition is visible to the optimizer and the concrete type is known » (Swift, OptimizationTips (https://github.com/swiftlang/swift/blob/main/docs/OptimizationTips.rst)); GHC's `SPECIALIZE` asks « that GHC create a copy of a function with specific arguments; most commonly, a copy of an overloaded function with specific class dictionary arguments » (GHC user guide (https://downloads.haskell.org/ghc/latest/docs/users_guide/exts/pragmas.html)). `ERR-POL-001` keeps all four outside K7PL.

- **A — Proposed: collect from the roots, name instances by their hash, count them in the budget.** *For:* chapter 6 is kept as written; every step has a precedent; separate compilation stays possible. *Against:* a generic's source is part of its unit's interface, as C++ headers or rustc's metadata, so changing it recompiles the units that use it.

  1. **Collection** (rustc): from the roots of the unit — its entry points and what its interface exports — follow the uses, instance by instance, until nothing new appears; only the instances reached are made (MLton's cache, keyed by the type arguments, is the table).
  2. **Identity by content**: an instance is named by the hash of the generic's normalised AST and of its type arguments, as the binary is in chapter 6; an instance needed by two units is made once and linked once. A generic of another unit is instantiated in the unit that uses it (rustc), its source travelling in the interface.
  3. **Budget**: each new instance decrements the budget of specialisation written in the source; an instance already made costs nothing.
  4. **Growth refused**: a chain of instances whose types grow on a cycle (polymorphic recursion, C++'s `X<T*>`) is refused by its own code, naming the cycle, whatever the budget — where rustc and C++ only meet a limit.
  5. **Nothing shared at run time**: no dictionary, no table (`ERR-POL-001`); the rows of layer 2 (Phase 4) are instantiated like types; effect handlers keep chapter 6's capability passing, a capability being a value of layer 1.

- **B — The whole program at once (MLton).** One pass over the whole program; every instance is known. *For:* the simplest. *Against:* no separate compilation, against the grade carried by the unit of compilation in chapter 6.
- **C — Shared code by layout (Go).** One copy per memory layout, a dictionary for the rest. *Against:* a dictionary is dynamic dispatch, refused by `ERR-POL-001`; « tout est monomorphé » would no longer hold.

#### Q-TYP-302 — When the budget of specialisation runs out

**Object.** Chapter 6 says of the budget that its exhaustion « arrête la duplication au lieu d'échouer ». For inlining, stopping leaves a call, which works. For monomorphisation, a generic call left without its instance has no code to call, since nothing is shared at run time (`ERR-POL-001`).

**Facts.**

- Chapter 6, on the solver: « un refus qui nomme l'obligation qu'il n'a pas su décider, ce qu'il y a consacré et ce qui la déciderait est une assistance »; « le budget relevé doit être écrit dans la source »; « Le budget du solveur est un compte de ressource, jamais un délai ».
- rustc and C++ stop at a fixed limit (Q-TYP-301); chapter 6 replaces such limits by grades carried by the unit.

- **A — Inlining stops, monomorphisation refuses.** Exhaustion stops inlining (calls stay), and refuses the program if an instance is still missing, with a code naming the generic, the chain of instances, the budget spent and the budget that would suffice. The sentence of chapter 6 is made precise: « au lieu d'échouer » holds for inlining. *For:* the solver's kind of refusal; nothing hidden.
- **B — A, with instances served first.** Instances draw on the budget before inlining, which gets what remains; the refusal comes only when the instances alone exceed it. *For:* inlining never starves a needed instance. *Against:* an order between the two uses of one budget.
- **C — Two budgets.** One for instances, one for inlining. *Against:* chapter 6 says « une seule décision les gouverne ».

#### Q-TYP-303 — Functions as arguments: one copy per function?

**Object.** Chapter 6 leaves a decision open: in defunctionalisation, « l'unité de spécialisation — une fonction d'ordre supérieur employée avec deux arguments fonctionnels distincts se spécialise en deux fonctions distinctes, et il faut décider si c'est ce qu'on veut » (Brandon et al., 2023, in its bibliography). It extends monomorphisation from types to function arguments.

**Facts.**

- Lean: « Specialization is an optimization in the code generator for generating variants of a function that are specialized to specific parameter values. This is in particular useful for functions that take other functions as parameters » (`@[specialize]`, Lean 4.34.0, Specialize.lean (https://github.com/leanprover/lean4/blob/v4.34.0/src/Lean/Compiler/Specialize.lean)).
- Julia: « As a heuristic, Julia avoids automatically specializing on argument type parameters in three specific cases: Type, Function, and Vararg » (Julia manual, performance tips (https://docs.julialang.org/en/v1/manual/performance-tips/)). GHC: a `SPECIALIZE` pragma generates « (a) a specialised version of the function and (b) a rewrite rule » (GHC user guide).

- **A — Yes, in the same budget.** A higher-order function is copied for each distinct function argument known at compile time, each copy decrementing the budget; beyond it, the arguments are defunctionalised into tags and the function chooses by a `case` over that closed set, decided at compile time. *For:* one rule for types and functions; no closure to allocate.
- **B — Only when asked.** A property, `:specialize` for instance, asks for copies, as Lean's attribute; otherwise one function with tagged arguments. *For:* code size stays under the programmer's eye. *Against:* a property to write where the gain is wanted.
- **C — Never.** One function per higher-order definition, its function arguments defunctionalised into tags. *Against:* a `case` at each call of the argument.

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

#### Q-SPEC-202 — Rewriting lst:gestionnaire and lst:acteur

**Object.** Your answer to Q-SPEC-102: a handler binds actors, `{defhandler beta :bind actor-name}`; an actor binds productive or terminating functions, `{defactor actor-name :bind (selection algorythm) :result [transformation algorythm]}`. Below, the counter of chapter 5 rewritten on that model, with what the prose would then say. Nothing is applied before your choice.

**Facts.**

- Chapter 3 defines a pure layer-2 handler by its transition, « une application (Message × Capacités × État) → État dont l'effet est neutre », whose result « n'est pas un effet exécuté mais une description d'effets, une liste d'instructions que l'exécutif réalise ».
- Chapter 5 reads today: « Un acteur est la paire additive dépendante (état : S) & Handler(S) du chapitre 3, et `bind-to` n'est qu'un accès de champ », the elaborator filling the handler by type-directed search when it is omitted, ambiguity being refused in Phase 1.

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

#### Q-SPEC-203 — The generic definition word

**Object.** Q-TYP-201: a generic word, as Racket's `define`, from which guided envelopes are built (`defhandler`, `defunc`, `defanything`), a `defunc` carrying its function type, and a composed definition building refined types — « Toujours pas de l'objet mais très proche sans mutation ». An envelope reads as the generic word with its properties filled in.

**Facts.**

- Racket: `(define id expr)`, `(define (head args) body ...+)`; « The first form binds id to the result of expr, and the second form binds id to a procedure » (Racket reference, define (https://docs.racket-lang.org/reference/define.html)).
- Clojure's `defn` is a macro: « Same as `(def name (fn [params* ] exprs*))` […] with any doc-string or attrs added to the var metadata » (clojure.core (https://clojure.github.io/clojure/clojure.core-api.html)). Common Lisp: `defun` « Defines a new function named function-name in the global environment » (CLHS, defun (https://www.lispworks.com/documentation/HyperSpec/Body/m_defun.htm)).
- You wrote `(defvar alpha :num int32)` (Q-LEX-002); chapter 5 writes `defn`, `defhandler`, `defactor`.

- **A — def.** Example: `{def ?increment-bounded :type {function int32 int32 {result int32 overflow}} …}`. *For:* short; the root of every `def…` envelope; Clojure's special form.
- **B — define.** Example: `{define ?increment-bounded :type {function int32 int32 {result int32 overflow}} …}`. *For:* Racket's and Scheme's word. *Against:* the envelopes would read `define-…` or keep `def…`.
- **C — defn.** Example: `{defn ?increment-bounded :type {function …} …}`. *For:* the word chapter 5 already writes. *Against:* Clojure's `defn` defines functions only.

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


#### Q-SPEC-205 — The name of the function envelope

**Object.** You wrote `defunc`; the head of a function type is `function` (Q-TYP-202) and the abstraction is `lambda` (VOC-2026-10-26-002).

- **A — defunc.** *For:* your word; reads « define function ».
- **B — defun.** *For:* Common Lisp's word.
- **C — defn.** *For:* Clojure's word, and chapter 5's today.
- **D — deffunction.** *For:* the type's head, whole. *Against:* the longest.

### Numbers

#### Q-NUM-301 — « fixN = two floN/2 »

**Object.** Your justification of Q-NUM-201 reads: « spécifier une "default value" en cas d'oubli : flo8 = flo8e4 by default ; la corrolaire fixN = two floN/2 ». Two readings are possible.

**Facts.**

- The complex numbers: `com64 = two flo32` (VOC-2026-10-26-023). The fixed-point numbers: `fix4.16`, « 4bit devant et 16bit derrière » (Q-NUM-004).

- **A — comN: the complex numbers.** The corollary is `comN = two floN/2`, as `com64 = two flo32`.
- **B — fixN alone: halves by default.** A fixed-point number given without its point, `fix32`, is `fix16.16` by default, with a warning, as `flo8` is `flo8e4`. Example: `fix32   ;; fix16.16, with a warning`.
- **C — Both.**

#### Q-NUM-302 — The codes of warnings

**Object.** `flo8` alone gives a warning, not an error (Q-NUM-201). Codes so far are `ERR-XXX-NNN`; Q-ERR-004 plans an index with one page per code, as GHC and Rust do.

**Facts.**

- GHC: « started emiting a code with the format [GHC-12345] for its messages in version 9.6.1 », the index describing « both errors and warnings » (The Haskell Error Index (https://errors.haskell.org/)). C#: an error number such as « CS0029 » (C# compiler messages (https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-messages/)), and « Compiler Warning (level 3) CS0168 » (C# reference (https://learn.microsoft.com/en-us/dotnet/csharp/misc/cs0168)): one prefix for both.
- rustc: « lints are divided into six levels: allow expect warn force-warn deny forbid » (rustc book, lint levels (https://doc.rust-lang.org/rustc/lints/levels.html)).

- **A — A prefix of their own.** Example: `WRN-NUM-001  flo8 without its format: flo8e4 assumed`. *For:* the severity reads in the code; the segments stay shared with errors.
- **B — Named lints with levels (rustc).** Example: `flo8-default   ;; warn by default; allow or deny`. *For:* a project may turn a warning into an error. *Against:* names beside numbered codes.
- **C — One numbering, the level beside the code (GHC, C#).** Example: `NUM-001 (warning)`. *Against:* the existing `ERR-` codes lose their prefix, or warnings carry `ERR`.

#### Q-NUM-303 — The code of an unresolved typed hole

**Object.** Q-NUM-203: a typed hole takes the smallest width that holds every value the solver can bound, and is refused when the solver bounds none.

**Facts.**

- Annex A: `ERR-SMT-001`, « Intervalle du témoin contredisant les contraintes inférées », and `ERR-SMT-002`; the `ERR-TYP` segment ends at `ERR-TYP-012`.
- Chapter 6: a refusal « nomme l'obligation qu'il n'a pas su décider, ce qu'il y a consacré et ce qui la déciderait ».

- **A — ERR-TYP-013.** A type left incomplete. *For:* the user's view: a type is missing.
- **B — ERR-SMT-003.** The solver bounded nothing. *For:* the message names what the solver spent, as chapter 6 asks.
- **C — ERR-NUM-001.** A segment for numbers, beside the warning of `flo8`. *Against:* a new segment.

### Doubled forms and white brackets

#### Q-LEX-401 — ⟦ ⟧ in layer 3: which precision?

**Object.** Q-LEX-302: `[[ x ]]` is `⟦ x ⟧`, a precision dedicated to layer 3 — the stack, pure and terminating computations — on a memory action, a grade or a resource. Your example: more dimensions for an array, cubes.

**Facts.**

- J: « The verb `u"n` applies u to each cell as specified by the rank n » (J Dictionary, Rank (https://www.jsoftware.com/help/dictionary/d600v.htm)); BQN's Range given a list of lengths gives an array of index lists (fourth part).
- Chapter 3: `Vec n V` is the only array type of the grammar, its literal `[v₀, …, vₙ₋₁]`; chapter 2 writes `⟦·⟧` for a translation.

Several options may be chosen.

- **rank — Arrays of any rank.** The nesting gives the dimensions: a matrix, a cube, not a vector of vectors. Example: `[[ [1 2 3] [4 5 6] ]]   ;; a 2×3 matrix, checked rectangular`.
- **range — Ranges.** The fourth part's proposal D (Q-LEX-304 waits for this answer). Example: `[[ 1..9 ]]`.
- **frame — Placed in the caller's frame.** Storage whose size is known at compile time, reserved in the frame of the calling function and freed with it, its grade explicit. Example: `[[ buffer 256 ]]`.
- **cells — Applied cell by cell (rank of a function).** A function applied to the cells of a given rank, as J's `"`. Example: `[[ f 1 ]]   ;; f on each row`.

#### Q-LEX-402 — ⦅ ⦆ in layer 2: which precision?

**Object.** `(( x ))` is `⦅ x ⦆`, a precision dedicated to layer 2 — the heap, orchestration, productive computations. Your example: another resolution scheme for a list graph.

**Facts.**

- Clojure's `lazy-seq` « yields a Seqable object that will invoke the body only the first time seq is called, and will cache the result » (clojure.core (https://clojure.github.io/clojure/clojure.core-api.html)).
- McBride and Paterson write `⟦f u₁ … uₙ⟧`, « indicating a shift into the idiom of an Applicative functor, where a pure function is applied to a sequence of effectful arguments » (Applicative programming with effects, preprint, p. 4 (https://www.staff.city.ac.uk/~ross/papers/Applicative.pdf)); Idris: « `[| f a1 …an |]` is translated into `pure f <*> a1 <*> … <*> an` » (Idris tutorial, idiom brackets (https://docs.idris-lang.org/en/latest/tutorial/interfaces.html)).

Several options may be chosen.

- **lazy — Produced on demand.** A list whose elements are computed when first read, then kept. Example: `(( naturals ))`.
- **shared — A graph with sharing.** Equal elements shared rather than copied, and the order of traversal stated (breadth or depth first). Example: `(( a b a ))   ;; a once, referenced twice`.
- **idiom — Idiom brackets.** A pure function applied to effectful arguments, each effect in order: McBride and Paterson's own white brackets. Example: `(( + (read-a) (read-b) ))`.
- **heap — Another heap region.** Allocation in a named region rather than the standard heap. Example: `(( :region frames … ))`.

#### Q-LEX-403 — ⦃ ⦄ in layer 1: which precision?

**Object.** `{{ x }}` is `⦃ x ⦄`, a precision dedicated to layer 1 — the linear arena, declarations and types. Your example: another arena than the standard one.

**Facts.**

- Zig: « by convention, there is no default allocator in Zig. Instead, functions which need to allocate accept an Allocator parameter » (Zig 0.14.0 (https://ziglang.org/documentation/0.14.0/)). C++: « The memory_resource class is an abstract interface to an unbounded set of classes encapsulating memory resources » (C++ draft, [mem.res] (https://eel.is/c++draft/mem.res)). Rust's `Vec::with_capacity_in`, « nightly-only experimental », builds a vector « with the provided allocator » (Rust std, Vec (https://doc.rust-lang.org/std/vec/struct.Vec.html)).
- Agda: instance arguments are written `{{x : T}}` or `⦃ x : T ⦄`, and are found when « a unique instance of the required type can be built from declared instances and the current context » (Agda documentation (https://agda.readthedocs.io/en/latest/language/instance-arguments.html)). Chapter 3 has `Arena V`, `Cap ρ` and `slice`.

Several options may be chosen.

- **arena — Another arena.** The declarations are placed in a named arena rather than the standard one. Example: `{{ :arena scratch {field buffer :num int8} }}`.
- **instance — Filled by search (Agda).** An argument the elaborator finds by type, as it fills a handler in chapter 5, written to make the search visible or to give its result. Example: `{{ counter-handler }}`.
- **comptime — Evaluated at compile time.** Example: `{{ table-of-squares 256 }}`.
- **capability — A capability given explicitly.** A capability `Cap ρ` granted to what follows, as chapter 3's handlers receive non-determinism. Example: `{{ :cap clock }}`.

#### Q-LEX-404 — Spacing white brackets

**Object.** The reader does not read white brackets yet. K, which reads K7PL, refuses non-ASCII characters inside a negated character class or a range, so the class of symbols cannot exclude them: `⟦x⟧` is read as one symbol. Spaced, `⟦ x ⟧` reads as a pair, the delimiter winning over the symbol of the same length.

**Facts.**

- Agda: instance arguments « can be enclosed, with proper spacing, e.g. `⦃ x : T ⦄`, in the unicode braces » (Agda documentation (https://agda.readthedocs.io/en/latest/language/instance-arguments.html)).
- Checked with K 7.1.337 on 2026-10-27: a token with priority, made of the symbol characters around a white bracket, catches `⟦x⟧` and `a⟦b` while `a≠b⊏c` stays a symbol and `⟦ a≠b [c] ⟦ x ⟧ ⟧` reads as nested pairs.

- **A — Spaces required; a glued bracket refused.** A white bracket stands between spaces or other delimiters; an atom that holds one is refused with a code of `ERR-LEX`. *For:* feasible in K today; Agda's rule. *Against:* spaces that ASCII pairs do not need.

  ```text
  ⟦ x ⟧    ;; a pair
  ⟦x⟧      ;; refused: ERR-LEX
  ```

- **B — Glued allowed.** Example: `⟦x⟧   ;; a pair`. *Against:* needs a reader that keeps white brackets out of symbols, which K's regular expressions cannot express; a pre-pass or a hand-written reader.
- **C — ASCII in files, white brackets on screen.** Files hold `[[ x ]]`; editors may display `⟦ x ⟧`. The reader never meets a white bracket. *Against:* fonts or an editor setting; the two writings of Q-LEX-302 become one.

### Names that link statements, K and proofs

Added on 2026-10-27 at the author's request, while the fifth part was open.

#### Q-TRC-001 — English labels, aligned with the names of K and Lean

**Object.** Your proposal: the names of statements and listings in the Verso document follow the English names specified in K, so that `lst:gestionnaire` becomes `lst:handler` and its proof is attached to a `handler` type. Today the specification holds 234 labels — 77 `thm`, 52 `sec`, 51 `eq`, 31 `tab`, 12 `fig`, 8 `lst`, 3 `req`, 1 `def` — with French slugs (`thm:preservation_type`, `thm:terminaison_couche_3`, `lst:gestionnaire`), referenced 594 times by `{num …}`. A label is never displayed — the reader sees a number — but it becomes the anchor of the published page (`#lbl-lst-gestionnaire`). Page addresses come from section tags (`c5-mise-en-pratique`), not from labels. The 101 Lean theorems of `src/` and `proofs/` are named in English (`linear_to_affine`); K names few elements yet (`LAYERS`, `ADD`…), the core words being chosen in the vocabulary lots (`lambda` for `Lam`).

**Facts.**

- Lean blueprint: a statement carries its label and, beside it, the Lean names that formalise it — `\label{thm:sphere_eversion}` then `\lean{sphere_eversion}`; « `\lean` that lists the Lean declaration names corresponding to the surrounding definition or statement (including namespaces) » (leanblueprint, README (https://github.com/PatrickMassot/leanblueprint)).
- Mathlib: « Terms of Props (e.g. proofs, theorem names) use snake_case. Props and Types (or Sort) (inductive types, structures, classes) are in UpperCamelCase. » (Mathlib naming conventions (https://leanprover-community.github.io/contribute/naming.html)).
- The frozen inventory of `wiki/assurance.md` and the pins of the stage C test name statements by their present labels; like the former file names, they would keep them, with a table of correspondence.

- **A — Every label in English, once the words are chosen.** Labels take the English names fixed by the vocabulary lots and by K; a table records each former label; the frozen inventory keeps the former ones. Section tags, which make page addresses, are not touched. *For:* one name from the text to K and Lean. *Against:* published links to a statement's anchor break; 594 references to rewrite, mechanically.

  ```text
  lst:gestionnaire          → lst:handler
  thm:terminaison_couche_3  → thm:layer-3-termination
  ```

- **B — English for new or rewritten objects only.** A label changes when its object is rewritten (as `lst:gestionnaire` and `lst:acteur` in Q-SPEC-202), not before. *For:* no mass rename. *Against:* two languages of labels for a long time.
- **C — Labels unchanged; the link carried by fields.** Names stay as they are; the attachment to K and Lean is written in fields (Q-TRC-002). *For:* nothing published breaks. *Against:* the name alone no longer tells what it is about.

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
