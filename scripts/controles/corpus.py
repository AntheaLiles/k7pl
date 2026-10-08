# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""The text of the specification, as the checks read it.

`flat()` turns the Verso markup back into the notation the checks were written for (`\\(x\\)`
for inline mathematics, `/x/` for emphasis, `\\ref{l}` for references), so that a pattern such as
`\\mathbb{S}_\\mu` or `composante d'usage` finds the same thing in the Verso as it did in the Org.
"""

from __future__ import annotations

import re
import sys
from functools import lru_cache
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import manuscript_metrics as mm  # noqa: E402

SPEC = mm.SPEC


@lru_cache(maxsize=1)
def modules() -> list[tuple[str, str, str]]:
    """(module name, section number, raw text) in document order."""
    return [(m.name or "Spec", n, m.text) for m, n in mm.walk()]


def module_path(name: str) -> str:
    """Return the repository-relative path of a parsed specification module."""
    for mod, _ in mm.walk():
        if (mod.name or "Spec") == name:
            try:
                return mod.path.relative_to(SPEC.parent).as_posix()
            except ValueError:
                return mod.path.as_posix()
    raise KeyError(name)


def raw(name: str) -> str:
    """Raw text of a module (`C2.ComonadeExponentielleEtFragments`), or of a chapter (`C2`)."""
    for n, _, t in modules():
        if n == name:
            return t
    raise KeyError(name)


def chapter(prefix: str) -> str:
    """Raw text of a chapter and all its sections."""
    return "\n".join(t for n, _, t in modules() if n == prefix or n.startswith(prefix + "."))


def flat(text: str) -> str:
    # mathematics first, kept verbatim; emphasis is only converted in the prose between
    parts = re.split(r"(\$\$`+.*?`+|\$`+.*?`+)", text, flags=re.S)
    out = []
    for i, part in enumerate(parts):
        if i % 2:  # a math span
            m = re.match(r"(\$\$?)(`+)(.*?)\2$", part, re.S)
            out.append(("\\[" + m.group(3) + "\\]") if m.group(1) == "$$" else ("\\(" + m.group(3) + "\\)"))
        else:
            part = re.sub(r'\{num "([^"]+)"\}\[\]', r"\\ref{\1}", part)
            part = re.sub(r'\{cite "([^"]+)"\}\[\]', lambda m: "".join(f"[cite:@{k}]" for k in m.group(1).split(",")), part)
            part = re.sub(r"(?<![\w\\])_([^_\s](?:[^_]*?[^_\s])?)_(?![\w])", r"/\1/", part)
            out.append(part)
    return "".join(out)


def everything() -> str:
    return "\n".join(t for _, _, t in modules())


def flat_everything() -> str:
    return flat(everything())


def formula(label: str) -> str:
    """The TeX of the formula block labelled `label` (all its code blocks)."""
    for _, _, t in modules():
        for m in re.finditer(r'^::::formula[^\n]*\(label := "' + re.escape(label) + r'"\)[^\n]*\n(.*?)\n::::$', t, re.S | re.M):
            return "\n".join(re.findall(r"```\n(.*?)\n```", m.group(1), re.S))
    return ""
