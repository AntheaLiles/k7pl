<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# `lib/`

This directory contains a single file, `lib-exemple.k7`. This README records
only what the repository itself shows about that file.

## Content of `lib-exemple.k7`

The file has five lines:

1. a REUSE header (`SPDX-FileCopyrightText: 2026 Cyprien PIERRE`,
   `SPDX-License-Identifier: CECILL-C`) on lines 1 to 3;
2. an empty line;
3. one `#` comment, in French: `Exemple de fichier de bibliothèque K7PL.`
   ("Example of a K7PL library file.").

It contains no K7PL code. No other tracked file refers to `lib-exemple.k7`,
and the `.k7` extension appears nowhere else in the repository.

## History

- The file was added by commit `123cb64` ("docs: establish current
  documentation architecture", Cyprien PIERRE, 2026-10-06), in the same commit
  as `LICENSES/CECILL-C.txt`. The commit message has no body. The file has not
  been modified since.
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
`lib-exemple.k7` is used for. No build target (`lakefile.lean`), test or CI
workflow refers to this directory explicitly; REUSE linting scans it like any
other file.

## Licensing

Files under `lib/` are covered by the `REUSE.toml` annotation `lib/**`
(`CECILL-C`). This README is documentation and is declared `CC-BY-4.0`, through
its own header and a dedicated `REUSE.toml` annotation.
