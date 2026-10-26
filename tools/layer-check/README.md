<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# `tools/layer-check/`

Checks the K7PL texts of the repository against the grammar of the three layers, using the K
definition of [`lexicon/syntax/`](../../lexicon/syntax/) as the only judge.

- **Texts.** The code blocks without a language inside the `listing` directives of `spec/`, and the
  `.k7` files of the repository, except the inputs of the non-normative K7OS model
  (`tests/examples/native-boundary/`).
- **Verdict.** For each text, `krun --output json` reports the refused inclusions of delimiters
  (`ERR-TOP-001` to `ERR-TOP-003`), with their messages. A text passes when K emits exactly the
  codes it declares, with a comment `; rejeté : ERR-…` (specification) or `; refused: ERR-…`
  (tests); a text that declares nothing must emit nothing. A declared code that this grammar cannot
  emit (a typing error, say) is reported as not checked here.
- **Association.** Every message that K emits must be the text of the row of its code in annex A,
  word for word, and every code that `lexicon/syntax/refusals.k` declares must have such a row and
  be emitted by at least one text ([`tests/layers/`](../../tests/layers/) holds one probe per code).

Run it from the repository root with `make -C src/k layers-check` (it compiles the grammar first),
or directly:

```sh
deno run --allow-read --allow-write --allow-run tools/layer-check/src/main.ts check \
  --definition src/k/.build/layers-kompiled
```

The unit tests need no K installation: `deno task test` from this directory. Like
`tools/ci-controller/` (pull request #309), the tool has no dependency outside Deno itself.

**Limits.** K 7.1.337 aborts on the `locations` attribute for this definition, so a refusal is
reported with its unit (file, line of the listing, label) but without a position inside it. Inline
code spans of the specification are not checked: nothing in their markup says which ones are K7PL.
Well-bracketedness itself (`[a (b]`, an unclosed delimiter) is refused by the K parser without an
`ERR` code.
