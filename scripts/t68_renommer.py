#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Applies the T-68 renaming table (`docs/suivi/t68-renommage.csv`) in one go.

    python3 scripts/t68_renommer.py              # dry run: what would change, per file
    python3 scripts/t68_renommer.py --diff       # dry run, with the changed lines
    python3 scripts/t68_renommer.py --appliquer  # writes the files

Each row of the CSV is `ancien, nouveau, motif, remplacement, fichier, occurrences`. A pattern that
starts with `LITERAL:` is a plain string (the regular expressions of the control scripts are written
as Python strings, and contain braces); any other pattern is a regular expression and the
replacement is a `re.sub` template. Only the files the table names are touched. Nothing is renamed
until the author has ratified `docs/recherche/t68-vocabulaire-en-bloc.md`.
"""

from __future__ import annotations

import csv
import difflib
import re
import sys
from collections import OrderedDict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TABLE = ROOT / "docs" / "suivi" / "t68-renommage.csv"


def rows() -> list[dict]:
    with TABLE.open(encoding="utf-8", newline="") as fh:
        return list(csv.DictReader(fh))


def apply(text: str, row: dict) -> tuple[str, int]:
    """The text after one row, and how many replacements it made."""
    pattern, replacement = row["motif"], row["remplacement"]
    if pattern.startswith("LITERAL:"):
        literal = pattern[len("LITERAL:") :]
        return text.replace(literal, replacement), text.count(literal)
    return re.subn(pattern, replacement, text)


def main(argv: list[str]) -> int:
    write = "--appliquer" in argv
    by_file: "OrderedDict[str, list[dict]]" = OrderedDict()
    for row in rows():
        by_file.setdefault(row["fichier"], []).append(row)
    total = 0
    for name, file_rows in by_file.items():
        path = ROOT / name
        text = path.read_text(encoding="utf-8")
        new = text
        counts = []
        for row in file_rows:
            new, n = apply(new, row)
            counts.append("%s -> %s : %d" % (row["ancien"], row["nouveau"], n))
            total += n
        print("%s%s" % (name, "" if write else "  (essai)"))
        for c in counts:
            print("    " + c)
        if "--diff" in argv and new != text:
            for line in difflib.unified_diff(text.splitlines(), new.splitlines(), lineterm="", n=0):
                if line[:1] in "+-" and line[:3] not in ("+++", "---"):
                    print("      " + line[:160])
        if write and new != text:
            path.write_text(new, encoding="utf-8")
    print("%d remplacement(s)%s" % (total, "" if write else " : essai à blanc, rien n'est écrit (--appliquer pour écrire)"))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
