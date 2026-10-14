<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Peer review

This directory is the current entry point for active peer-review material.

Reviews remain evidence and adversarial assessment; they are not themselves normative project state. Findings that affect current assurance should eventually be linked from [../ASSURANCE.md](../ASSURANCE.md).

The former `relectures/` material has been consolidated into this directory. Historical review evidence remains evidence; it is not promoted to normative status.

## Index

The files below are evidence records: their content has not changed since their import on 2026-10-01 (they were only moved on 2026-10-07). They are written in French, except `pr-02/deepseek.md`, which is in English; their origin is recorded in [the provenance table](../history/2026-10-07-provenance-migration.md).

### pr-01/ — reviews of 8–9 September 2026

- [2026-09-08-relectures-triage.md](pr-01/2026-09-08-relectures-triage.md) — the three reviews, each serious objection checked against the source (8 September 2026).
- [2026-09-09-conformite-gpt.md](pr-01/2026-09-09-conformite-gpt.md) — the twenty-eight executable instructions derived from the GPT review (9 September 2026).
- [2026-09-09-conformite-appliquee.md](pr-01/2026-09-09-conformite-appliquee.md) — execution log of the twenty-eight instructions applied to the manuscript (9 September 2026).
- [2026-09-09-avant-relecture-2.md](pr-01/2026-09-09-avant-relecture-2.md) — what changed since the 8 September review, prepared for the next review (9 September 2026).

### pr-02/ — six peer reviews of the 2026-09-09 manuscript and their consolidation

- [claude.md](pr-02/claude.md), [deepseek.md](pr-02/deepseek.md), [flash.md](pr-02/flash.md), [gemini.md](pr-02/gemini.md), [gpt.md](pr-02/gpt.md), [qwen.md](pr-02/qwen.md) — the six review reports; `claude.md` and `flash.md` are Markdown conversions of `.docx` exports that include the conversation, prompt first.
- [taches-consolidees.md](pr-02/taches-consolidees.md) — consolidated correction plan drawn from the six reviews (2026-09-14, revision 2): the `BLOQ`, `STRUCT`, `PORT`, `PREUVE`, `NOTA`, `IMPL` … cards that [scripts/suivi.py](../../scripts/suivi.py) reads.
- [etudes/contributions-formelles.md](pr-02/etudes/contributions-formelles.md) — formal development of the three contributions identified as unpublished by the concurrency programme, and analysis of the `GUARD` rule (2026-09-15).
- [etudes/etude-opportunite-hott.md](pr-02/etudes/etude-opportunite-hott.md) — opportunity study of homotopy type theory and its variants as a unifying basis for K7PL (2026-09-15).
- [etudes/programme-concurrence.md](pr-02/etudes/programme-concurrence.md) — programme for formalising concurrency, parallelism and distribution per layer (2026-09-15).

**Duplicated prompt in two reports.** In `pr-02/claude.md` and `pr-02/flash.md`, the first user turn contains the review prompt twice: lines 3–959 and lines 961–1905. Apart from the title and the opening "0. Rôle" block, rendered as a table in the second copy, the two copies consist of the same 936 lines. Lines 1–1906 are identical in both files; the reviews themselves start after line 1906. These evidence files are left unchanged; the duplication is recorded here instead.
