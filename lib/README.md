<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# `lib/`

This directory contains a single file, `lib-example.k7`. This README records
only what the repository itself shows about that file.

## Content of `lib-example.k7`

The file has five lines:

1. a REUSE header (`SPDX-FileCopyrightText: 2026 Cyprien PIERRE`,
   `SPDX-License-Identifier: CECILL-C`) on lines 1 to 3;
2. an empty line;
3. one comment: `;; Example of a K7PL library file.`

It contains no K7PL code. Its comments start with `;`, the comment character of
K7PL (chapter 5); `#` is the comptime sigil. `tools/layer-check` reads it, like
every `.k7` file of the repository, against the grammar of the layers.

## History

- The file was added as `lib-exemple.k7` by commit `123cb64` ("docs:
  establish current documentation architecture", Cyprien PIERRE, 2026-10-06),
  in the same commit as `LICENSES/CECILL-C.txt`. The commit message has no body.
- On 2026-10-26 its `#` comments became `;;` comments (owner instruction), and
  it was renamed `lib-example.k7` with an English comment: file names and
  content outside `spec/` are in English (owner instruction of the same day).
- The `REUSE.toml` annotation `lib/**` (`CECILL-C`, precedence `aggregate`),
  with the comment "Bibliothèque d'exemple écrite en K7PL." ("Example library
  written in K7PL."), appears in commit `7d60c2a` ("licensing: classify
  REUSE.toml correctly").

## Recorded purpose

No purpose for this specific file is stated in the commit that introduced it.
The only related statements found in the repository are:

- `LICENSE.md`: libraries and components written in K7PL, notably `lib/`, use
  the CeCILL-C weak copyleft;
- `REUSE.toml`: the comment on `lib/**` quoted above;
- `.claude/skills/writing-rules.md`: libraries written in the k7pl language
  (as opposed to Lean) are recommended under `CECILL-C`.

These statements describe the licensing of `lib/`. None of them says what
`lib-example.k7` is used for. No build target (`lakefile.lean`) refers to this
directory explicitly; REUSE linting scans it like any other file, and the layer
check of `k7pl-semantics.yaml` reads its `.k7` file.

## Licensing

Files under `lib/` are covered by the `REUSE.toml` annotation `lib/**`
(`CECILL-C`). This README is documentation and is declared `CC-BY-4.0`, through
its own header and a dedicated `REUSE.toml` annotation.
