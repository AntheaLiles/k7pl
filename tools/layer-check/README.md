<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# `tools/layer-check/`

Checks the K7PL texts of the repository with the two K readers of
[`lexicon/syntax/`](../../lexicon/syntax/), which are the only judges.

- **Texts.** The code blocks without a language inside the `listing` directives of `spec/`, and the
  `.k7` files of the repository, except the inputs of the non-normative K7OS model
  (`tests/examples/native-boundary/`).
- **Readers.** The balance reader (`balance.k`) reads every text as a stream of delimiters and
  reports, with the line of the delimiter at fault, the delimiters that do not pair (`ERR-DLM-001`
  to `ERR-DLM-003`) and the refused inclusions (`ERR-TOP-001` to `ERR-TOP-003`). The tree reader
  (`refusals.k`) reads a text as a tree of expressions, along the grammar of the layers.
- **Verdict.** A text passes when the balance reader emits exactly the codes it declares, with a
  comment `;; rejeté : ERR-…` (specification) or `;; refused: ERR-…` (tests); a test may add the
  expected line, `ERR-DLM-001 at line 6`. A text that declares nothing must emit nothing. A declared
  code that these readers cannot emit (a typing error, say) is reported as not checked here.
- **Agreement.** When the balance reader finds no delimiter fault, the tree reader must read the
  text and emit the same `ERR-TOP` codes in the same order; when it finds one, the tree reader must
  fail specifically during parsing. A process or runtime failure is not accepted as a parse refusal.
  Repeated refusal codes are compared with multiplicity, not collapsed into a set. The listing
  collector also fails closed on unterminated or nested listing structures, and an integration test
  reconciles every `listing` directive in the real Verso corpus with one collected unit.
- **Lexical probes.** The `.k7` files of [`tests/lexical/`](../../tests/lexical/) give, after
  `;; expect:`, the class (`Symbol`, `Train`, `Number`, `String`) the tree reader must give each
  atom of the line; `kast --output json` reads them.
- **Glyphs.** The glyphs of the `Train` token of `lexicon/syntax/tokens.k` must be the glyphs of the
  table of chapter 1 (`tab:glyphes`) and the modifiers `´` and `¨` of chapter 5, no more, no less.
- **Association.** Every message that K emits must be the text of the row of its code in annex A,
  word for word, and every code that `lexicon/syntax/codes.k` declares must have such a row and be
  emitted by at least one text ([`tests/layers/`](../../tests/layers/) holds probes for every code).

Run it from the repository root with `make -C src/k layers-check` (it compiles both readers first),
or directly:

```sh
deno run --allow-read --allow-write --allow-run tools/layer-check/src/main.ts check \
  --definition src/k/.build/layers-kompiled --balance src/k/.build/balance-kompiled --kast kast
```

The unit tests need no K installation: `deno task test` from this directory. Like
`tools/ci-controller/` (pull request #309), the tool has no dependency outside Deno itself.

**Limits.** K 7.1.337 aborts on the `locations` attribute for these definitions, so a line is the
balance reader's own count of line breaks, and a column is not given. Inline code spans of the
specification are not checked: nothing in their markup says which ones are K7PL. A quote inside a
comment gets no code (Q-ERR-101): a comment runs to the end of its line.
