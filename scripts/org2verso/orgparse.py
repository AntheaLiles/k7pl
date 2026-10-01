# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Org-mode parser limited to the subset the K7PL manuscript uses.

It does not try to be a general Org parser: it recognises exactly the constructs found in the
sources (headings, paragraphs, lists, tables, blocks, affiliated keywords, inline markup) and
raises a warning for anything else, so that no content is lost unnoticed.

Emphasis delimiting follows Org's rules (the default `org-emphasis-regexp-components`): a
passage that the original LaTeX export left plain stays plain.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from typing import Any

# --------------------------------------------------------------------------------------
# Warnings
# --------------------------------------------------------------------------------------


@dataclass
class Warning_:
    file: str
    line: int
    kind: str
    text: str


class Diagnostics:
    """Collects the conversion warnings, by file and line."""

    def __init__(self) -> None:
        self.items: list[Warning_] = []
        self.file = "?"
        self.line = 0

    def warn(self, kind: str, text: str) -> None:
        self.items.append(Warning_(self.file, self.line, kind, text))


DIAG = Diagnostics()

# --------------------------------------------------------------------------------------
# Inline nodes
# --------------------------------------------------------------------------------------
# ('text', s) ('emph', [n]) ('bold', [n]) ('code', s) ('verb', s) ('math', s, display)
# ('ref', label) ('cite', [keys]) ('rmq', [n]) ('fn', [n]) ('link', target, [n] | None)
# ('rawtex', source) ('target', name) ('sc', [n]) ('br',)

Inline = tuple

PRE = " \t\n-('\"{"
POST = " \t\n-.,:!?;'\")}\\["
EMPH = {"/": "emph", "*": "bold", "~": "code", "=": "verb", "_": "underline", "+": "strike"}


def _balanced(s: str, i: int, open_: str, close: str) -> int:
    """Index of the closing delimiter matching the one before `i`, or -1."""
    depth = 1
    while i < len(s):
        c = s[i]
        if c == "\\":
            i += 2
            continue
        if c == open_:
            depth += 1
        elif c == close:
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


def _bracket_end(s: str, i: int) -> int:
    """End of a `[...]` whose content starts at `i` (balanced brackets)."""
    depth = 1
    while i < len(s):
        if s[i] == "[":
            depth += 1
        elif s[i] == "]":
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


LATEX_ARG_COMMANDS = {
    "ref", "eqref", "label", "emph", "textsc", "texttt", "textbf", "textit", "textrm",
    "textsf", "cite", "footnote", "nolinkurl", "url", "href", "orcidlink",
}

_DOLLAR = re.compile(r"\$([^\s$][^$]*?)\$(?![0-9A-Za-z])", re.S)


def _try_emphasis(s: str, i: int) -> tuple[Inline, int] | None:
    """Recognises `/x/`, `*x*`, `~x~`, `=x=` at `i` under Org's boundary rules."""
    m = s[i]
    if m not in "/*~=":
        return None
    if i > 0 and s[i - 1] not in PRE:
        return None
    if i + 1 >= len(s) or s[i + 1] in " \t\n":
        return None
    # closing: same marker, preceded by a non-blank, followed by a POST character or the end
    j = i + 1
    nl = 0
    while j < len(s):
        if s[j] == "\n":
            nl += 1
            if nl > 1:
                return None
        if s[j] == m and s[j - 1] not in " \t\n" and (j + 1 == len(s) or s[j + 1] in POST):
            body = s[i + 1 : j]
            if m in "~=":
                return (("code" if m == "~" else "verb", body), j + 1)
            return ((EMPH[m], parse_inline(body)), j + 1)
        j += 1
    return None


def _latex_command(s: str, i: int) -> tuple[Inline, int] | None:
    """Recognises `\\cmd[opt]{arg}...` at `i` (which points at the backslash)."""
    m = re.match(r"\\([A-Za-z]+)\*?", s[i:])
    if not m:
        return None
    name = m.group(1)
    j = i + m.end()
    args: list[str] = []
    opts: list[str] = []
    while j < len(s):
        if s[j] == "[" and not args:
            e = _bracket_end(s, j + 1)
            if e < 0:
                break
            opts.append(s[j + 1 : e])
            j = e + 1
        elif s[j] == "{":
            e = _balanced(s, j + 1, "{", "}")
            if e < 0:
                break
            args.append(s[j + 1 : e])
            j = e + 1
        else:
            break
    src = s[i:j]
    if name == "ref" and len(args) == 1:
        return (("ref", args[0]), j)
    if name == "eqref" and len(args) == 1:
        return (("eqref", args[0]), j)
    if name == "label" and len(args) == 1:
        return (("labeldef", args[0]), j)
    if name == "emph" and len(args) == 1:
        return (("emph", parse_inline(args[0])), j)
    if name == "textit" and len(args) == 1:
        return (("emph", parse_inline(args[0])), j)
    if name == "textbf" and len(args) == 1:
        return (("bold", parse_inline(args[0])), j)
    if name == "texttt" and len(args) == 1:
        return (("code", args[0]), j)
    if name == "textsc" and len(args) == 1:
        return (("sc", parse_inline(args[0])), j)
    if name == "textup" and len(args) == 1:
        return (("group", parse_inline(args[0])), j)
    if name == "S" and args == [""]:
        return (("text", "§"), j)
    if name == "S" and not args:
        return (("text", "§"), j)
    return (("rawtex", src), j)


_MODE = {"latex": False}


def parse_latex(s: str) -> list[Inline]:
    """Parses LaTeX text (body of an export block): no Org markup, `~` is a no-break space,
    `--` and `---` are dashes."""
    old = _MODE["latex"]
    _MODE["latex"] = True
    try:
        return parse_inline(s)
    finally:
        _MODE["latex"] = old


def parse_inline(s: str) -> list[Inline]:
    latex = _MODE["latex"]
    out: list[Inline] = []
    buf: list[str] = []

    def flush() -> None:
        if buf:
            out.append(("text", "".join(buf)))
            buf.clear()

    i = 0
    n = len(s)
    while i < n:
        c = s[i]
        # --- mathématiques ---------------------------------------------------------
        if c == "\\" and s.startswith("\\(", i):
            e = s.find("\\)", i + 2)
            if e >= 0:
                flush()
                out.append(("math", s[i + 2 : e], False))
                i = e + 2
                continue
        if c == "\\" and s.startswith("\\[", i):
            e = s.find("\\]", i + 2)
            if e >= 0:
                flush()
                out.append(("math", s[i + 2 : e], True))
                i = e + 2
                continue
        if c == "$":
            if s.startswith("$$", i):
                e = s.find("$$", i + 2)
                if e >= 0:
                    flush()
                    out.append(("math", s[i + 2 : e], True))
                    i = e + 2
                    continue
            m = _DOLLAR.match(s, i)
            if m and (i == 0 or s[i - 1] not in "\\$"):
                body = m.group(1)
                if not body.endswith((" ", "\t", "\n")):
                    flush()
                    out.append(("math", body, False))
                    i = m.end()
                    continue
        # --- commandes LaTeX ---------------------------------------------------------
        if c == "\\":
            if s.startswith("\\\\", i):
                flush()
                out.append(("br",))
                i += 2
                continue
            r = _latex_command(s, i)
            if r:
                flush()
                node, i = r
                out.append(node)
                continue
            if i + 1 < n and s[i + 1] in "&%_#{}$":
                buf.append(s[i + 1])
                i += 2
                continue
            if i + 1 < n and s[i + 1] == " ":
                buf.append("\u00a0")
                i += 2
                continue
            if latex and i + 1 < n and s[i + 1] in ",;:!":
                buf.append("\u202f" if s[i + 1] == "," else "\u2009")
                i += 2
                continue
            DIAG.warn("latex-inconnu", s[i : i + 24])
            buf.append(c)
            i += 1
            continue
        # --- crochets : citations, remarques, notes, liens ----------------------------
        if c == "[" and not latex:
            if s.startswith("[cite", i):
                m = re.match(r"\[cite(/[\w-]+)?:", s[i:])
                if m:
                    e = _bracket_end(s, i + m.end())
                    if e >= 0:
                        raw = s[i + m.end() : e]
                        keys = re.findall(r"@([^\s;,\]]+)", raw)
                        flush()
                        out.append(("cite", keys, raw))
                        i = e + 1
                        continue
            if s.startswith("[rmq:", i):
                e = _bracket_end(s, i + 5)
                if e >= 0:
                    flush()
                    out.append(("rmq", parse_inline(s[i + 5 : e])))
                    i = e + 1
                    continue
                DIAG.warn("rmq-non-refermé", s[i : i + 40])
            if s.startswith("[fn:", i):
                m = re.match(r"\[fn:([^\]:]*):?", s[i:])
                e = _bracket_end(s, i + 4)
                if m and e >= 0:
                    body = s[i + m.end() : e]
                    flush()
                    out.append(("fn", m.group(1), parse_inline(body)))
                    i = e + 1
                    continue
            if s.startswith("[[", i):
                e = s.find("]]", i + 2)
                if e >= 0:
                    inner = s[i + 2 : e]
                    flush()
                    if "][" in inner:
                        tgt, desc = inner.split("][", 1)
                        out.append(("link", tgt, parse_inline(desc)))
                    else:
                        out.append(("link", inner, None))
                    i = e + 2
                    continue
        # --- cibles ---------------------------------------------------------------------
        if c == "<" and not latex and s.startswith("<<<", i):
            e = s.find(">>>", i + 3)
            if e >= 0:
                flush()
                out.append(("target", s[i + 3 : e]))
                i = e + 3
                continue
        if c == "<" and not latex and s.startswith("<<", i):
            e = s.find(">>", i + 2)
            if e >= 0:
                flush()
                out.append(("target", s[i + 2 : e]))
                i = e + 2
                continue
        # --- emphase ----------------------------------------------------------------------
        if c in "/*~=" and not latex:
            r = _try_emphasis(s, i)
            if r:
                flush()
                node, i = r
                out.append(node)
                continue
        # --- chaînes spéciales (Org : --- → —, -- → –, ... → …) ----------------------------
        if c == "-" and s.startswith("---", i) and (i == 0 or s[i - 1] in " \t\n") and (
            i + 3 >= n or s[i + 3] in " \t\n"
        ):
            buf.append("—")
            i += 3
            continue
        if c == "-" and s.startswith("--", i) and (i == 0 or s[i - 1] in " \t\n") and (
            i + 2 >= n or s[i + 2] in " \t\n"
        ):
            buf.append("–")
            i += 2
            continue
        if latex:
            if c == "~":
                buf.append("\u00a0")
                i += 1
                continue
            if c == "-" and s.startswith("---", i):
                buf.append("—")
                i += 3
                continue
            if c == "-" and s.startswith("--", i):
                buf.append("–")
                i += 2
                continue
        buf.append(c)
        i += 1
    flush()
    return out


# --------------------------------------------------------------------------------------
# Block nodes
# --------------------------------------------------------------------------------------

HEAD = re.compile(r"^(\*+) +(.*?)\s*$")
KEYWORD = re.compile(r"^\s*#\+(\w+)(?:\[(.*?)\])?:[ \t]*(.*?)\s*$")
BEGIN = re.compile(r"^\s*#\+BEGIN_(\w+)[ \t]*(.*?)\s*$", re.I)
END = re.compile(r"^\s*#\+END_(\w+)\s*$", re.I)
LIST = re.compile(r"^(\s*)([-+]|\d+[.)])[ \t]+(.*)$")
TABLE = re.compile(r"^\s*\|")
RULE = re.compile(r"^\s*\|[-+]+\|?\s*$")
AFFILIATED = {"NAME", "CAPTION", "ATTR_LATEX", "DESC", "NOTE", "SOURCE", "ALT_TEXT", "ATTR_HTML"}


@dataclass
class Block:
    type: str
    line: int
    data: dict[str, Any] = field(default_factory=dict)
    kw: dict[str, Any] = field(default_factory=dict)


def _split_row(line: str) -> list[str]:
    cells = line.strip()
    cells = cells[1:] if cells.startswith("|") else cells
    cells = cells[:-1] if cells.endswith("|") else cells
    return [c.strip() for c in cells.split("|")]


def parse_blocks(text: str, filename: str) -> list[Block]:
    DIAG.file = filename
    lines = text.split("\n")
    blocks: list[Block] = []
    kw: dict[str, Any] = {}
    i = 0
    n = len(lines)

    def take_kw() -> dict[str, Any]:
        nonlocal kw
        k, kw = kw, {}
        return k

    while i < n:
        line = lines[i]
        DIAG.line = i + 1
        if not line.strip():
            i += 1
            continue

        # heading -----------------------------------------------------------------------
        m = HEAD.match(line)
        if m:
            if kw:
                DIAG.warn("mot-clé-orphelin", f"{list(kw)} avant un titre")
                kw = {}
            blocks.append(Block("heading", i + 1, {"level": len(m.group(1)), "title": m.group(2)}))
            i += 1
            continue

        # #+BEGIN ... #+END block ---------------------------------------------------------
        m = BEGIN.match(line)
        if m:
            kind = m.group(1).upper()
            args = m.group(2)
            j = i + 1
            body: list[str] = []
            while j < n and not (END.match(lines[j]) and END.match(lines[j]).group(1).upper() == kind):
                body.append(lines[j])
                j += 1
            if j >= n:
                DIAG.warn("bloc-non-fermé", f"#+BEGIN_{kind}")
            content = "\n".join(body)
            if kind == "EXPORT":
                blocks.append(Block("export", i + 1, {"lang": args.split()[0] if args else "", "text": content}, take_kw()))
            elif kind == "SRC":
                parts = args.split()
                blocks.append(Block("src", i + 1, {"lang": parts[0] if parts else "", "args": parts[1:], "text": content}, take_kw()))
            elif kind == "QUOTE":
                inner = parse_blocks(content, filename)
                DIAG.file = filename
                blocks.append(Block("quote", i + 1, {"blocks": inner}, take_kw()))
            else:
                DIAG.warn("bloc-inconnu", f"#+BEGIN_{kind}")
                blocks.append(Block("rawblock", i + 1, {"kind": kind, "text": content}, take_kw()))
            i = j + 1
            continue

        # keyword ------------------------------------------------------------------------
        m = KEYWORD.match(line)
        if m:
            name = m.group(1).upper()
            val = m.group(3)
            if name in AFFILIATED:
                if name == "ATTR_LATEX":
                    kw.setdefault("ATTR_LATEX", []).append(val)
                elif name == "CAPTION":
                    kw["CAPTION"] = val
                    kw["CAPTION_SHORT"] = m.group(2)
                else:
                    kw[name] = val
            else:
                blocks.append(Block("keyword", i + 1, {"name": name, "value": val}))
            i += 1
            continue

        # comment -----------------------------------------------------------------------
        if line.startswith("# ") or line.rstrip() == "#":
            j = i
            com: list[str] = []
            while j < n and (lines[j].startswith("# ") or lines[j].rstrip() == "#"):
                com.append(lines[j][2:] if lines[j].startswith("# ") else "")
                j += 1
            blocks.append(Block("comment", i + 1, {"text": "\n".join(com)}))
            i = j
            continue

        # table ----------------------------------------------------------------------------
        if TABLE.match(line):
            rows: list[Any] = []
            j = i
            while j < n and TABLE.match(lines[j]):
                if RULE.match(lines[j]):
                    rows.append("rule")
                else:
                    rows.append(_split_row(lines[j]))
                j += 1
            blocks.append(Block("table", i + 1, {"rows": rows}, take_kw()))
            i = j
            continue

        # list ---------------------------------------------------------------------------------
        m = LIST.match(line)
        if m:
            j, items = _parse_list(lines, i, filename)
            blocks.append(Block("list", i + 1, {"items": items}, take_kw()))
            i = j
            continue

        # paragraph ----------------------------------------------------------------------------
        j = i
        para: list[str] = []
        while j < n:
            l = lines[j]
            if (
                not l.strip()
                or HEAD.match(l)
                or BEGIN.match(l)
                or KEYWORD.match(l)
                or TABLE.match(l)
                or LIST.match(l)
                or l.startswith("# ")
            ):
                break
            para.append(l)
            j += 1
        if not para:  # a line nothing recognises: do not loop
            para = [line]
            j = i + 1
        text_ = "\n".join(para)
        # a line holding only a file link is a figure
        mm = re.fullmatch(r"\s*\[\[([^\]]+)\]\]\s*", text_)
        if mm and ("/" in mm.group(1) or "." in mm.group(1)):
            blocks.append(Block("figure", i + 1, {"path": mm.group(1)}, take_kw()))
        else:
            blocks.append(Block("para", i + 1, {"raw": text_, "inlines": parse_inline(text_)}, take_kw()))
        i = j

    if kw:
        DIAG.warn("mot-clé-orphelin", f"{list(kw)} en fin de fichier")
    return blocks


def _parse_list(lines: list[str], i: int, filename: str) -> tuple[int, list[dict[str, Any]]]:
    """Parses a (possibly nested) list starting at line `i`."""
    n = len(lines)
    m0 = LIST.match(lines[i])
    assert m0
    base = len(m0.group(1))
    items: list[dict[str, Any]] = []
    j = i
    while j < n:
        m = LIST.match(lines[j])
        if not m or len(m.group(1)) != base:
            break
        bullet = m.group(2)
        first = m.group(3)
        DIAG.line = j + 1
        j += 1
        body = [first]
        sub: list[Any] = []
        while j < n:
            l = lines[j]
            if not l.strip():
                # a blank line followed by more indented text continues the item
                k = j
                while k < n and not lines[k].strip():
                    k += 1
                if k < n and (len(lines[k]) - len(lines[k].lstrip())) > base and not LIST.match(lines[k]):
                    body.append("")
                    j = k
                    continue
                if k < n and LIST.match(lines[k]) and len(LIST.match(lines[k]).group(1)) > base:
                    j = k
                    continue
                break
            ind = len(l) - len(l.lstrip())
            ml = LIST.match(l)
            if ml and len(ml.group(1)) > base:
                j2, subitems = _parse_list(lines, j, filename)
                sub.append(subitems)
                j = j2
                continue
            if ml and len(ml.group(1)) <= base:
                break
            if ind > base:
                body.append(l.strip())
                j += 1
                continue
            break
        text = "\n".join(body).strip()
        term = None
        mt = re.match(r"^(.*?) :: (.*)$", text, re.S)
        if mt:
            term, text = mt.group(1), mt.group(2)
        items.append(
            {
                "bullet": bullet,
                "term": parse_inline(term) if term is not None else None,
                "raw": text,
                "paras": [parse_inline(p.strip()) for p in re.split(r"\n\s*\n", text) if p.strip()],
                "sub": sub,
            }
        )
    return j, items
