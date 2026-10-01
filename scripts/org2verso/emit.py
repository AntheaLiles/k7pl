# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Emission of Verso source from the nodes `orgparse` produces.

The Verso extensions it targets (`tools/SpecExt/`) are: `{num}`, `{label}`, `{cite}`, `{sc}`,
`{rmq}`, `{missing}`, `{amp}`, `{refsection}`, `{bibliography}`, `{listof}`, `{texsetup}` and the
directives `thm`, `formula`, `figure`, `k7table`, `listing`, `comment` with their slots
(`caption`, `desc`, `note`, `source`, `title`, `statement`, `proofsketch`).
"""

from __future__ import annotations

import re
import unicodedata
from dataclasses import dataclass, field

from orgparse import DIAG, parse_inline, parse_latex

WIDTH = 100

# --------------------------------------------------------------------------------------
# Strings
# --------------------------------------------------------------------------------------


def lean_str(s: str) -> str:
    """A Lean string literal."""
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n") + '"'


_ESC = re.compile(r"([\\*_`\[\]{}$])")


def esc(s: str) -> str:
    """Escapes what Verso would read as markup."""
    return _ESC.sub(r"\\\1", s)


def slugify(s: str) -> str:
    """Lower-case ASCII identifier, words separated by hyphens."""
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode()
    s = re.sub(r"[^A-Za-z0-9]+", "-", s).strip("-").lower()
    return s or "x"


def camel(s: str, limit: int = 40) -> str:
    """Lean module name: ASCII words in CamelCase."""
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode()
    words = re.findall(r"[A-Za-z0-9]+", s)
    out = ""
    for w in words:
        if len(out) + len(w) > limit and out:
            break
        out += w[:1].upper() + w[1:]
    if not out or out[0].isdigit():
        out = "S" + out
    return out


# --------------------------------------------------------------------------------------
# Emission context
# --------------------------------------------------------------------------------------


@dataclass
class Ctx:
    """Emission state of one module."""

    file: str
    labels: set[str]
    #: known numbers (sections and numbered objects), for the mermaid figures
    numbers: dict[str, str] = field(default_factory=dict)
    footnotes: list[tuple[str, list]] = field(default_factory=list)
    fn_count: int = 0
    unresolved: list[tuple[str, int, str]] = field(default_factory=list)
    line: int = 0
    refs_seen: list[str] = field(default_factory=list)


# A piece of text: `str` (unbreakable) or `None` (a space where the line may break).
Tok = str | None

DANGER = re.compile(r"^(#|[-+*]$|\d+[.)]$|:[: ]|:$|>|%%%|\{)")


def words(s: str) -> list[Tok]:
    """Splits plain text into escaped words separated by breakable spaces."""
    out: list[Tok] = []
    parts = re.split(r"([ \t\n]+)", s)
    for p in parts:
        if not p:
            continue
        if re.fullmatch(r"[ \t\n]+", p):
            if not out or out[-1] is not None:
                out.append(None)
        else:
            out.append(esc(p))
    return out


def wrap(open_: str, close: str, toks: list[Tok]) -> list[Tok]:
    """Wraps pieces in markup; blanks at the edges stay outside the markup."""
    lead: list[Tok] = []
    trail: list[Tok] = []
    toks = list(toks)
    while toks and toks[0] is None:
        lead.append(toks.pop(0))
    while toks and toks[-1] is None:
        trail.append(toks.pop())
    if not toks:
        return lead + trail
    toks[0] = open_ + toks[0]  # type: ignore[operator]
    toks[-1] = toks[-1] + close  # type: ignore[operator]
    return lead + toks + trail


def math_tok(body: str, display: bool, ctx: Ctx) -> str:
    body = re.sub(r"\s*\n\s*", " ", body.strip())
    run = max((len(m.group(0)) for m in re.finditer(r"`+", body)), default=0)
    ticks = "`" * (run + 1)
    return ("$$" if display else "$") + ticks + body + ticks


def code_tok(body: str) -> str:
    run = max((len(m.group(0)) for m in re.finditer(r"`+", body)), default=0)
    ticks = "`" * (run + 1)
    pad = " " if body.startswith("`") or body.endswith("`") else ""
    return ticks + pad + body + pad + ticks


def role_arg(s: str) -> str:
    return lean_str(s)


def inl(nodes: list, ctx: Ctx) -> list[Tok]:
    """Inline nodes → Verso text pieces."""
    out: list[Tok] = []

    def push(ts: list[Tok]) -> None:
        for t in ts:
            if t is None and (not out or out[-1] is None):
                continue
            out.append(t)

    for n in nodes:
        k = n[0]
        if k == "text":
            push(words(n[1]))
        elif k in ("emph", "bold"):
            inner = n[1]
            # `**x**` in Org is a bold nested in a bold: one marker is enough
            while len(inner) == 1 and inner[0][0] == k:
                inner = inner[0][1]
            mark = "_" if k == "emph" else "*"
            push(wrap(mark, mark, inl(inner, ctx)))
        elif k in ("code", "verb"):
            push([code_tok(n[1])])
        elif k == "math":
            push([math_tok(n[1], n[2], ctx)])
        elif k == "ref":
            push([ref_tok(n[1], ctx)])
        elif k == "eqref":
            push(["(" + ref_tok(n[1], ctx) + ")"])
        elif k == "cite":
            push(["{cite " + role_arg(",".join(n[1])) + "}[]"])
        elif k == "sc":
            push(wrap("{sc}[", "]", inl(n[1], ctx)))
        elif k == "rmq":
            push(wrap("{rmq}[", "]", inl(n[1], ctx)))
        elif k == "group":
            push(inl(n[1], ctx))
        elif k == "target":
            push(words(n[1]))
        elif k == "fn":
            ctx.fn_count += 1
            fid = f"fn{ctx.fn_count}"
            ctx.footnotes.append((fid, n[2]))
            push([f"[^{fid}]"])
        elif k == "link":
            tgt, desc = n[1], n[2]
            m = re.match(r"(tab|lst|fig|img|eq|thm|sec):(.*)$", tgt)
            if m:
                push([ref_tok(tgt, ctx)])
            else:
                DIAG.warn("lien-externe", tgt)
                text = inl(desc, ctx) if desc else words(tgt)
                push(wrap("[", f"]({tgt})", text))
        elif k == "br":
            DIAG.warn("saut-de-ligne", "\\\\ dans un paragraphe")
            push([None])
        elif k == "labeldef":
            DIAG.warn("label-en-ligne", n[1])
        elif k == "rawtex":
            DIAG.warn("latex-brut", n[1])
            push(words(n[1]))
        else:
            DIAG.warn("noeud-inconnu", str(n)[:60])
    while out and out[-1] is None:
        out.pop()
    return out


def ref_tok(label: str, ctx: Ctx) -> str:
    """`\\ref{label}` → `{num "label"}[]`, or `{missing "label"}[]` if the label does not exist."""
    ctx.refs_seen.append(label)
    if label in ctx.labels:
        return "{num " + role_arg(label) + "}[]"
    ctx.unresolved.append((ctx.file, DIAG.line, label))
    return "{missing " + role_arg(label) + "}[]"


def danger_escape(w: str) -> str:
    """Neutralises a word that would be read as the start of a block at the start of a line."""
    if w.startswith("{"):
        return w
    if re.fullmatch(r"\d+[.)]", w):
        return w[:-1] + "\\" + w[-1]
    return "\\" + w


def fill(toks: list[Tok], indent: str = "", first: str | None = None, width: int = WIDTH) -> list[str]:
    """Fills pieces into lines of at most `width` columns, never starting a line with something
    Verso would read as the start of a block."""
    ws: list[str] = []
    cur: list[str] = []
    for t in toks:
        if t is None:
            if cur:
                ws.append("".join(cur))
                cur = []
        else:
            cur.append(t)
    if cur:
        ws.append("".join(cur))
    if not ws:
        return [(first if first is not None else indent).rstrip()]
    if DANGER.match(ws[0]):
        ws[0] = danger_escape(ws[0])
    lines: list[str] = []
    line = first if first is not None else indent
    empty = True
    for w in ws:
        if empty:
            line += w
            empty = False
        elif len(line) + 1 + len(w) > width and not DANGER.match(w):
            lines.append(line)
            line = indent + w
        else:
            line += " " + w
    lines.append(line)
    return lines


def one_line(toks: list[Tok]) -> str:
    return " ".join(fill(toks, "", None, 10**9))


def para_lines(nodes: list, ctx: Ctx, indent: str = "", first: str | None = None) -> list[str]:
    return fill(inl(nodes, ctx), indent, first)


def flush_footnotes(ctx: Ctx) -> list[list[str]]:
    """Footnote definitions accumulated by the preceding paragraphs."""
    out = []
    pending, ctx.footnotes = ctx.footnotes, []
    for fid, nodes in pending:
        out.append([f"[^{fid}]: " + one_line(inl(nodes, ctx))])
    return out


# --------------------------------------------------------------------------------------
# Blocks
# --------------------------------------------------------------------------------------

Chunk = list[str]


def fence_for(text: str) -> str:
    run = max((len(m.group(0)) for m in re.finditer(r"`+", text)), default=0)
    return "`" * max(3, run + 1)


def code_block(text: str, lang: str = "") -> Chunk:
    f = fence_for(text)
    return [f + lang, *text.split("\n"), f]


def directive(name: str, args: str, body: list[Chunk], depth: int = 3) -> Chunk:
    colons = ":" * depth
    out: Chunk = [f"{colons}{name}" + (f" {args}" if args else "")]
    for i, c in enumerate(body):
        if i:
            out.append("")
        out.extend(c)
    out.append(colons)
    return out


def slot(name: str, nodes: list, ctx: Ctx, depth: int = 3, flags: str = "") -> Chunk:
    return directive(name, flags, [para_lines(nodes, ctx)], depth)


def kwargs(**kw: str | None) -> str:
    return " ".join(f"({k} := {lean_str(v)})" for k, v in kw.items() if v is not None)


def emit_list(items: list[dict], ctx: Ctx, indent: str = "") -> list[Chunk]:
    """A (possibly nested) list as Verso blocks."""
    ordered = items[0]["bullet"][0].isdigit()
    if all(it["term"] is not None for it in items):
        chunks: Chunk = []
        for it in items:
            chunks.append(indent + ": " + one_line(inl(it["term"], ctx)))
            chunks.append("")
            for i, p in enumerate(it["paras"]):
                if i:
                    chunks.append("")
                chunks.extend(para_lines(p, ctx, indent + "  "))
            chunks.append("")
        while chunks and chunks[-1] == "":
            chunks.pop()
        return [chunks]
    out: Chunk = []
    for n, it in enumerate(items, 1):
        bullet = f"{n}." if ordered else "*"
        pad = " " * (len(bullet) + 1)
        if it["term"] is not None:
            DIAG.warn("liste-mixte", "terme dans une liste ordinaire")
        paras = it["paras"] or [[]]
        for i, p in enumerate(paras):
            if i == 0:
                out.extend(para_lines(p, ctx, indent + pad, indent + bullet + " "))
            else:
                out.append("")
                out.extend(para_lines(p, ctx, indent + pad))
        for sub in it["sub"]:
            out.append("")
            for c in emit_list(sub, ctx, indent + pad):
                out.extend(c)
        if n < len(items):
            out.append("")
    return [out]


def table_cell(text: str, ctx: Ctx) -> str:
    nodes = parse_inline(text) if text.strip() else []
    toks = inl(nodes, ctx)
    s = one_line(toks) if toks else "\u00a0"
    return s


def emit_table(rows: list, kw: dict, ctx: Ctx) -> Chunk:
    """Org table → `k7table` (caption, slots, `:::table`)."""
    body_rows: list[list[str]] = [r for r in rows if r != "rule"]
    # header: the rows before the first horizontal rule
    first_rule = next((i for i, r in enumerate(rows) if r == "rule"), None)
    header = first_rule is not None and first_rule > 0 and any(r != "rule" for r in rows[first_rule + 1 :])
    ncols = max((len(r) for r in body_rows), default=1)
    for r in body_rows:
        if len(r) != ncols:
            DIAG.warn("tableau-irrégulier", f"{len(r)} colonnes au lieu de {ncols}")
            r.extend([""] * (ncols - len(r)))
    align = ""
    for a in kw.get("ATTR_LATEX", []):
        m = re.search(r":align\s+(\S+)", a)
        if m:
            align = m.group(1)
    label = kw.get("NAME")
    body: list[Chunk] = []
    if kw.get("CAPTION"):
        body.append(slot("caption", parse_inline(kw["CAPTION"]), ctx))
    cells: Chunk = []
    for r in body_rows:
        cells.append("* * " + table_cell(r[0], ctx))
        for c in r[1:]:
            cells.append("  * " + table_cell(c, ctx))
    body.append(directive("table", "+header" if header else "", [cells], 3))
    return directive("k7table", kwargs(label=label, align=align or None), body, 4)


# --------------------------------------------------------------------------------------
# LaTeX export blocks
# --------------------------------------------------------------------------------------

ENV = re.compile(r"\\begin\{(\w+\*?)\}")


def split_envs(text: str) -> tuple[list[tuple[str, str]], list[str]]:
    """Splits LaTeX text into top-level environments; also returns the rest."""
    parts: list[tuple[str, str]] = []
    rest: list[str] = []
    i = 0
    pre_start = 0
    while True:
        m = ENV.search(text, i)
        if not m:
            rest.append(text[pre_start:])
            break
        env = m.group(1)
        end_tok = "\\end{" + env + "}"
        depth = 1
        j = m.end()
        while depth:
            nb = text.find("\\begin{" + env + "}", j)
            ne = text.find(end_tok, j)
            if ne < 0:
                DIAG.warn("env-non-fermé", env)
                return parts, rest
            if 0 <= nb < ne:
                depth += 1
                j = nb + len(env) + 7
            else:
                depth -= 1
                j = ne + len(end_tok)
        parts.append((env, text[pre_start:j]))
        pre_start = j
        i = j
    return parts, rest


def balanced_arg(s: str, i: int, open_: str = "{", close: str = "}") -> tuple[str, int]:
    """Content of the group starting at `s[i] == open_`, and the index that follows it."""
    assert s[i] == open_
    depth = 0
    j = i
    while j < len(s):
        c = s[j]
        if c == "\\":
            j += 2
            continue
        if c == open_:
            depth += 1
        elif c == close:
            depth -= 1
            if depth == 0:
                return s[i + 1 : j], j + 1
        j += 1
    raise ValueError("groupe non refermé")


def opt_args(s: str, i: int) -> tuple[list[str], int]:
    """The consecutive optional arguments `[...]` from `i`."""
    out = []
    while i < len(s) and s[i] == "[":
        a, i = balanced_arg(s, i, "[", "]")
        out.append(a)
    return out, i


def latex_paragraphs(text: str, ctx: Ctx, indent: str = "") -> list[Chunk]:
    """LaTeX body (text and mathematics) → Verso paragraphs."""
    out: list[Chunk] = []
    for p in re.split(r"\n\s*\n", text.strip()):
        if not p.strip():
            continue
        out.append(para_lines(parse_latex(p.strip()), ctx, indent))
        out.extend(flush_footnotes(ctx))
    return out


def emit_theorem(text: str, kw: dict, ctx: Ctx) -> Chunk:
    t = text.strip()
    m = re.match(r"\\begin\{theorem\}", t)
    assert m
    i = m.end()
    opts, i = opt_args(t, i)
    title = opts[0] if opts else ""
    status, level = "theoreme", "langage"
    for o in opts[1:]:
        for kv in o.split(","):
            if "=" in kv:
                a, b = (x.strip() for x in kv.split("=", 1))
                if a == "statut":
                    status = b
                elif a == "niveau":
                    level = b
                else:
                    DIAG.warn("option-théorème", kv)
    labels: list[str] = []
    rest = t[i:]
    for lm in re.finditer(r"\\label\{([^}]*)\}", rest):
        pass
    # labels placed before \begin{statement}
    head_end = rest.find("\\begin{statement}")
    head = rest[:head_end] if head_end >= 0 else rest
    labels = re.findall(r"\\label\{([^}]*)\}", head)
    if len(labels) > 1:
        DIAG.warn("théorème-multi-label", ",".join(labels))
    label = labels[0] if labels else None
    stm = re.search(r"\\begin\{statement\}(.*?)\\end\{statement\}", rest, re.S)
    prf = re.search(r"\\begin\{proofsketch\}(.*?)\\end\{proofsketch\}", rest, re.S)
    leftover = rest
    for mm in (stm, prf):
        if mm:
            leftover = leftover.replace(mm.group(0), "")
    leftover = re.sub(r"\\label\{[^}]*\}|\\end\{theorem\}", "", leftover).strip()
    if leftover:
        DIAG.warn("théorème-reste", leftover[:80])
    args = kwargs(label=label, status=status if status != "theoreme" else None,
                  level=level if level != "langage" else None)
    body: list[Chunk] = []
    if title:
        body.append(directive("title", "", [para_lines(parse_latex(title), ctx)], 3))
    if stm:
        sbody = stm.group(1)
        sopts, k = opt_args(sbody.lstrip(), 0)
        sbody = sbody.lstrip()[k:]
        paras = latex_paragraphs(sbody, ctx)
        if sopts:
            paras.insert(0, para_lines(parse_latex(sopts[0]), ctx))
        body.append(directive("statement", "+titled" if sopts else "", paras, 3))
    else:
        DIAG.warn("théorème-sans-énoncé", label or "?")
    if prf:
        body.append(directive("proofsketch", "", latex_paragraphs(prf.group(1), ctx), 3))
    return directive("thm", args, body, 4)


def emit_formula(text: str, kw: dict, ctx: Ctx) -> Chunk:
    t = text.strip()
    # caption and label outside the environments
    caption = None
    cm = re.search(r"\\captionof\{formule\}\{", t)
    if cm:
        cap, end = balanced_arg(t, cm.end() - 1)
        caption = cap
        t = t[: cm.start()] + t[end:]
    parts, rest = split_envs(t)
    outside = " ".join(r for r in rest if r.strip())
    labels = re.findall(r"\\label\{([^}]*)\}", outside)
    outside = re.sub(r"\\label\{[^}]*\}", "", outside)
    # stray TeX comments after the last environment
    outside = "\n".join(l for l in outside.split("\n") if l.strip())
    chunks: list[Chunk] = []
    kind = "formule" if caption is not None else "plain"
    for env, src in parts:
        inner_labels = re.findall(r"\\label\{([^}]*)\}", src)
        if inner_labels:
            labels.extend(inner_labels)
            src = re.sub(r"\n?\s*\\label\{[^}]*\}", "", src)
        if env == "equation" and caption is None:
            kind = "equation"
        chunks.append(code_block(src.strip("\n")))
    if outside.strip():
        DIAG.warn("formule-reste", outside.strip()[:80])
    if len(labels) > 1:
        DIAG.warn("formule-multi-label", ",".join(labels))
    label = labels[0] if labels else None
    body: list[Chunk] = []
    body.extend(chunks)
    if caption is not None:
        body.append(directive("caption", "", [para_lines(parse_latex(caption), ctx)], 3))
    return directive("formula", kwargs(label=label, kind=kind if kind != "plain" else None), body, 4)


def emit_export(b, ctx: Ctx) -> list[Chunk]:
    text = b.data["text"]
    t = text.strip()
    if t.startswith("\\begin{theorem}"):
        parts, rest = split_envs(t)
        out = []
        for env, src in parts:
            if env != "theorem":
                DIAG.warn("export-mixte", env)
                continue
            out.append(emit_theorem(src, b.kw, ctx))
        left = " ".join(r.strip() for r in rest if r.strip())
        if left:
            DIAG.warn("export-reste", left[:80])
        return out
    if ENV.search(t) or t.startswith("%"):
        return [emit_formula(text, b.kw, ctx)]
    DIAG.warn("export-inconnu", t[:60])
    return [code_block(text)]


# --------------------------------------------------------------------------------------
# Figures and listings
# --------------------------------------------------------------------------------------


def width_of(kw: dict) -> str:
    for a in kw.get("ATTR_LATEX", []):
        m = re.search(r"width=([0-9.]+)\\(?:line|text)width", a)
        if m:
            return str(round(float(m.group(1)) * 100))
    return "90"


def float_slots(kw: dict, ctx: Ctx) -> list[Chunk]:
    out: list[Chunk] = []
    if kw.get("CAPTION"):
        out.append(slot("caption", parse_inline(kw["CAPTION"]), ctx))
    for name, key in (("desc", "DESC"), ("note", "NOTE"), ("source", "SOURCE")):
        if kw.get(key):
            out.append(slot(name, parse_inline(kw[key]), ctx))
    return out


def emit_figure(path: str, kw: dict, ctx: Ctx, src: str, nodes_alt: str = "") -> Chunk:
    alt = kw.get("ALT_TEXT") or kw.get("CAPTION") or ""
    return directive(
        "figure",
        kwargs(label=kw.get("NAME"), src=src, alt=alt, width=width_of(kw)),
        float_slots(kw, ctx),
        4,
    )


def emit_listing(text: str, lang: str, kw: dict, ctx: Ctx) -> Chunk:
    body = float_slots(kw, ctx)
    if kw.get("CAPTION") is None:
        DIAG.warn("listing-sans-légende", kw.get("NAME") or "?")
    body.append(code_block(text))
    return directive("listing", kwargs(label=kw.get("NAME")), body, 4)
