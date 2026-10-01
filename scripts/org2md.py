# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Converts an Org-mode note into GitHub-flavoured Markdown with pandoc.

    python3 org2md.py <note.org> <note.md> [--title "Title"] [--drop-abstracts] [--banner "text"]

What pandoc loses on its own is kept:

* property drawers become a one-line verbatim block (`ARC: A | QUID: QA-1 …`);
* TODO keywords stay visible (`[DONE]`, `[TODO]`);
* `foo_bar` is not read as a subscript (`#+OPTIONS: ^:nil`);
* `#+TITLE:` / `#+SUBTITLE:` become the first heading.

With `--drop-abstracts`, the `#+BEGIN_ABSTRACT` blocks (publisher abstracts, third-party text) are
removed.
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
import tempfile
from pathlib import Path

LUA_FILTER = """
function Span(el)
  if el.classes:includes('todo') or el.classes:includes('done') then
    return pandoc.Str('[' .. pandoc.utils.stringify(el.content) .. ']')
  end
end
"""

DRAWER = re.compile(r"^[ \t]*:PROPERTIES:\n(.*?)^[ \t]*:END:\n", re.S | re.M)
PROP = re.compile(r"^[ \t]*:([A-Za-z0-9_.-]+):[ \t]*(.*)$", re.M)


def drawers_to_quotes(text: str) -> str:
    def repl(m: re.Match[str]) -> str:
        props = [(k, v.strip()) for k, v in PROP.findall(m.group(1))]
        if not props:
            return ""
        line = " | ".join(f"{k}: {v}" if v else k for k, v in props)
        return f"#+BEGIN_EXAMPLE\n{line}\n#+END_EXAMPLE\n"

    return DRAWER.sub(repl, text)


def convert(src: Path, dst: Path, title: str | None, drop_abstracts: bool, banner: str | None) -> None:
    text = src.read_text(encoding="utf-8")
    meta = dict(re.findall(r"^#\+(TITLE|SUBTITLE|DATE):[ \t]*(.*)$", text, re.M))
    text = re.sub(r"^#\+(TITLE|SUBTITLE|DATE|EMAIL|STARTUP|COLUMNS|PROPERTY|TODO|AUTHOR):.*\n", "", text, flags=re.M)
    if drop_abstracts:
        text = re.sub(r"#\+BEGIN_ABSTRACT.*?#\+END_ABSTRACT\n?", "", text, flags=re.S)
    text = drawers_to_quotes(text)
    text = "#+OPTIONS: ^:nil\n" + text
    with tempfile.TemporaryDirectory() as tmp:
        flt = Path(tmp) / "todo.lua"
        flt.write_text(LUA_FILTER)
        proc = subprocess.run(
            ["pandoc", "-f", "org", "-t", "gfm", "--wrap=none", "--shift-heading-level-by=1", f"--lua-filter={flt}"],
            input=text, capture_output=True, text=True,
        )
        if proc.returncode:
            raise SystemExit(f"pandoc failed on {src}: {proc.stderr[:500]}")
        out = proc.stdout
    head = f"# {title or meta.get('TITLE', src.stem)}\n"
    if meta.get("SUBTITLE"):
        head += f"\n*{meta['SUBTITLE']}*\n"
    if meta.get("DATE"):
        head += f"\n{meta['DATE']}\n"
    if banner:
        head += f"\n> {banner}\n"
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(head + "\n" + out.lstrip("\n"), encoding="utf-8")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("src", type=Path)
    ap.add_argument("dst", type=Path)
    ap.add_argument("--title")
    ap.add_argument("--drop-abstracts", action="store_true")
    ap.add_argument("--banner")
    a = ap.parse_args()
    convert(a.src, a.dst, a.title, a.drop_abstracts, a.banner)
    return 0


if __name__ == "__main__":
    sys.exit(main())
