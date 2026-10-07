# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Index check: every term of the index occurs in the text, and the printed index is wired in.

The index is not written by hand: `tools/SpecExt/AutoMark.lean` recognises the terms of
`tools/SpecExt/IndexTerms.lean` in the prose of the document at generation time (word boundaries,
case and accents ignored, optional plural). A term that no prose contains would print as nothing,
which this check reports. The text is searched the way the generator does, in a rougher manner:
a normalised substring on word boundaries.
"""

from __future__ import annotations

import re
import unicodedata

from . import corpus
from .journal import ko, ok

TERMS_FILE = corpus.SPEC.parent / "tools" / "SpecExt" / "IndexTerms.lean"
LISTINGS = ("Refs.",)  # the index and the lists of terms are not prose
#: terms of the manuscript's index that the Verso text never writes (found on 6 October 2026):
#: kept in the list, printed nowhere ; the author decides whether to write them or drop them
KNOWN_ABSENT = {"analyse de coût"}


def fold(text: str) -> str:
    text = unicodedata.normalize("NFKD", text.replace(" ", " ").replace("’", "'"))
    return "".join(c for c in text if not unicodedata.combining(c)).lower()


def terms() -> list[str]:
    source = TERMS_FILE.read_text(encoding="utf-8")
    block = source[source.index("#[") : source.index("].map")]
    return re.findall(r'"([^"]+)"', block)


def run() -> None:
    print("\n[Index]")
    listed = terms()
    prose = fold(
        "\n".join(t for name, _, t in corpus.modules() if not name.startswith(LISTINGS))
    )
    absent = [
        t for t in listed if not re.search(r"(?<![a-z0-9])" + re.escape(fold(t)) + r"[sx]?(?![a-z0-9])", prose)
    ]
    unknown = [t for t in absent if t not in KNOWN_ABSENT]
    if unknown:
        ko("termes de l'index absents du texte : %s" % unknown)
    else:
        known = sorted(KNOWN_ABSENT & set(absent))
        ok("index : %d termes, %d présents dans le texte, absents connus : %s" % (len(listed), len(listed) - len(absent), known))
    index_page = corpus.raw("Refs.Index")
    if "{printindex}" in index_page:
        ok("index : la page porte le bloc {printindex}")
    else:
        ko("la page de l'index ne porte pas {printindex}")
