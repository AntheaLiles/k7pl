# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Converts the Org-mode manuscript of K7PL into Verso documents.

    python3 convert.py --src <src/ folder of the manuscript> --meta <meta/ folder> \\
        --out <root of the repository> [--report report.md] [--mmdc path/to/mmdc]

Input: `main.org` and the files it includes (chapters, appendices), `K7PL-glossary.org`, and the
figures `meta/*.pdf` (drawio exports).

Output: `spec/Spec.lean`, `spec/Spec/**` (one module per chapter, one per level-2 section),
`spec/figures/*` (SVG and PDF) and a conversion report.

The conversion is faithful: no text is corrected or reworded (the manuscript says "do not change
anything without the author's agreement"). What cannot be converted is reported, never lost
silently.
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
import unicodedata
from dataclasses import dataclass, field
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

import emit
from emit import Chunk, Ctx, camel, directive, lean_str, slugify
from orgparse import DIAG, Block, parse_blocks, parse_inline

HEADER = """-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.
"""

# Order and nature of the units of the document (mirrors `main.org`).
CHAPTERS = [
    ("chapitres/c1-prolegomenes.org", "C1", False),
    ("chapitres/c2-fondements.org", "C2", False),
    ("chapitres/c3-types.org", "C3", False),
    ("chapitres/c4-automates.org", "C4", False),
    ("chapitres/c5-syntaxe.org", "C5", False),
    ("chapitres/c6-compilation.org", "C6", False),
    ("chapitres/c7-integration.org", "C7", False),
    ("chapitres/refs.org", "Refs", False),
    ("K7_Errors.org", "AnnexeA", True),
    ("K7_LSP_REPL.org", "AnnexeB", True),
    ("K7_Sushi.org", "AnnexeC", True),
    ("K7_Sugoi.org", "AnnexeD", True),
    ("K7_Semantique.org", "AnnexeE", True),
]


@dataclass
class Sec:
    level: int
    title: str
    line: int
    labels: list[str] = field(default_factory=list)
    blocks: list[Chunk] = field(default_factory=list)
    children: list["Sec"] = field(default_factory=list)
    num: str = ""
    tag: str = ""
    file: str = ""
    module: str = ""


# --------------------------------------------------------------------------------------
# Reading
# --------------------------------------------------------------------------------------


def read_blocks(path: Path) -> list[Block]:
    return parse_blocks(path.read_text(encoding="utf-8"), path.name)


LABEL_KW = re.compile(r"\\label\{([^}]*)\}")


def collect_labels(blocks_by_file: dict[str, list[Block]]) -> set[str]:
    """Every label the manuscript defines (what LaTeX would be able to resolve)."""
    labels: set[str] = set()

    def walk(bs: list[Block]) -> None:
        for b in bs:
            if b.type == "keyword" and b.data["name"] == "LATEX":
                labels.update(LABEL_KW.findall(b.data["value"]))
            elif b.type in ("table", "figure", "src") and b.kw.get("NAME"):
                labels.add(b.kw["NAME"])
            elif b.type == "export":
                labels.update(LABEL_KW.findall(b.data["text"]))
            elif b.type == "quote":
                walk(b.data["blocks"])

    for bs in blocks_by_file.values():
        walk(bs)
    return labels


# --------------------------------------------------------------------------------------
# Glossary
# --------------------------------------------------------------------------------------


def plain(nodes: list) -> str:
    out = []
    for n in nodes:
        if n[0] == "text":
            out.append(n[1])
        elif n[0] in ("emph", "bold", "group", "sc"):
            out.append(plain(n[1]))
        elif n[0] in ("code", "verb", "target"):
            out.append(n[1])
        else:
            DIAG.warn("terme-complexe", str(n)[:40])
    return "".join(out)


def sort_key(s: str) -> str:
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode()
    return re.sub(r"[^a-z0-9 ]+", "", s.lower())


def load_glossary(path: Path) -> dict[str, list]:
    """Terms, acronyms and index of `K7PL-glossary.org`."""
    bs = read_blocks(path)
    sections: dict[str, list] = {"glossary": [], "acronym": [], "index": []}
    cur = None
    for b in bs:
        DIAG.file = path.name
        if b.type == "heading" and b.data["level"] == 1:
            t = b.data["title"].strip().lower()
            cur = {"glossary": "glossary", "acronyms": "acronym", "index": "index"}.get(t)
        elif b.type == "list" and cur:
            for it in b.data["items"]:
                if cur == "index":
                    sections[cur].append((" ".join(it["raw"].split()), None))
                    continue
                if it["term"] is None:
                    DIAG.warn("glossaire-sans-terme", it["raw"][:40])
                    continue
                term = plain(it["term"]).strip()
                sections[cur].append((term, it["raw"]))
        elif b.type == "list" and cur is None:
            DIAG.warn("glossaire-liste-hors-section", "")
    return sections


def emit_glossary(kind: str, data: dict[str, list], ctx: Ctx) -> list[Chunk]:
    entries = data[kind]
    if kind == "index":
        items = sorted((t for t, _ in entries), key=sort_key)
        return [[f"* {emit.one_line(emit.words(t))}" for t in items]]
    if kind == "glossary":
        rows = sorted(((t.split(",")[0].strip(), d) for t, d in entries), key=lambda r: sort_key(r[0]))
    else:
        rows = sorted(entries, key=lambda r: sort_key(r[0]))
    out: Chunk = []
    for term, desc in rows:
        out.append(": " + emit.one_line(emit.words(term)))
        out.append("")
        out.extend(emit.para_lines(parse_inline(" ".join(desc.split())), ctx, "  "))
        out.append("")
    while out and out[-1] == "":
        out.pop()
    return [out]


# --------------------------------------------------------------------------------------
# Building the sections
# --------------------------------------------------------------------------------------


class Builder:
    def __init__(self, src: Path, labels: set[str], glossary: dict, figdir: Path):
        self.src = src
        self.labels = labels
        self.glossary = glossary
        self.figdir = figdir
        self.unresolved: list[tuple[str, int, str]] = []
        self.number_of: dict[str, str] = {}
        self.figures: list[tuple[str, str]] = []
        self.tags: set[str] = set()

    # ---- blocs ----------------------------------------------------------------------

    def emit_block(self, b: Block, ctx: Ctx, cur: Sec, root: Sec, appendix: bool) -> None:
        DIAG.line = b.line
        ctx.line = b.line
        t = b.type
        if t == "para":
            cur.blocks.append(emit.para_lines(b.data["inlines"], ctx))
            cur.blocks.extend(emit.flush_footnotes(ctx))
        elif t == "list":
            cur.blocks.extend(emit.emit_list(b.data["items"], ctx))
            cur.blocks.extend(emit.flush_footnotes(ctx))
        elif t == "table":
            cur.blocks.append(emit.emit_table(b.data["rows"], b.kw, ctx))
        elif t == "export":
            cur.blocks.extend(emit.emit_export(b, ctx))
        elif t == "comment":
            cur.blocks.append(directive("comment", "", [emit.code_block(b.data["text"])], 3))
        elif t == "quote":
            lines: Chunk = []
            for sub in b.data["blocks"]:
                if sub.type != "para":
                    DIAG.warn("citation-bloc", sub.type)
                    continue
                if lines:
                    lines.append(">")
                lines.extend("> " + l for l in emit.para_lines(sub.data["inlines"], ctx))
            cur.blocks.append(lines)
        elif t == "figure":
            path = b.data["path"]
            name = Path(path).stem
            self.figures.append((name, path))
            cur.blocks.append(emit.emit_figure(path, b.kw, ctx, name))
        elif t == "src":
            if b.data["lang"] == "mermaid":
                name = emit.slugify((b.kw.get("NAME") or "mermaid").split(":", 1)[-1])
                text = re.sub(r"\\ref\{([^}]*)\}", lambda m: self.number_of.get(m.group(1), "?"), b.data["text"])
                self.figures.append((name, "mermaid:" + text))
                cur.blocks.append(emit.emit_figure(name, b.kw, ctx, name))
            else:
                cur.blocks.append(emit.emit_listing(b.data["text"], b.data["lang"], b.kw, ctx))
        elif t == "keyword":
            self.emit_keyword(b, ctx, cur, root)
        elif t == "rawblock":
            DIAG.warn("bloc-brut", b.data["kind"])
        else:
            DIAG.warn("bloc-non-géré", t)

    def emit_keyword(self, b: Block, ctx: Ctx, cur: Sec, root: Sec) -> None:
        name, val = b.data["name"], b.data["value"]
        if name == "LATEX":
            m = LABEL_KW.fullmatch(val.strip())
            if m:
                cur.labels.append(m.group(1))
                return
            m = re.fullmatch(r"\\listof(figures|tables|formules|listings)", val.strip())
            if m:
                kind = {"figures": "figure", "tables": "table", "formules": "formule", "listings": "listing"}[m.group(1)]
                cur.blocks.append(["{listof " + lean_str(kind) + "}"])
                return
            if val.strip() in ("\\footnotesize{", "}", "\\clearpage", "\\appendix"):
                return
            DIAG.warn("latex-ignoré", val[:50])
        elif name == "TOC":
            return
        elif name == "PRINT_BIBLIOGRAPHY":
            cur.blocks.append(["{bibliography}"])
        elif name == "PRINT_GLOSSARY":
            m = re.search(r":type\s+(\w+)", val)
            kind = m.group(1) if m else "glossary"
            cur.blocks.extend(emit_glossary(kind, self.glossary, ctx))
        elif name in ("TITLE", "AUTHOR"):
            return
        else:
            DIAG.warn("mot-clé-ignoré", f"{name} {val[:40]}")

    # ---- fichier -> arbre de sections -------------------------------------------------

    def build(self, path: str, ch_module: str, appendix: bool, number: str) -> Sec:
        blocks = read_blocks(self.src / path)
        ctx = Ctx(file=Path(path).name, labels=self.labels)
        root = Sec(0, "", 0)
        stack: list[Sec] = [root]
        top: Sec | None = None
        counters = [0, 0, 0, 0, 0, 0]
        for b in blocks:
            if b.type == "heading":
                lvl = b.data["level"]
                if lvl == 1 and top is None:
                    top = Sec(1, b.data["title"], b.line)
                    top.num = number
                    stack = [top]
                    continue
                if top is None:
                    DIAG.warn("titre-sans-chapitre", b.data["title"])
                    continue
                while stack[-1].level >= lvl:
                    stack.pop()
                if stack[-1].level != lvl - 1:
                    DIAG.warn("saut-de-niveau", f"{stack[-1].level} → {lvl}")
                sec = Sec(lvl, b.data["title"], b.line)
                stack[-1].children.append(sec)
                stack.append(sec)
                continue
            if top is None:
                if b.type == "keyword" and b.data["name"] in ("TITLE", "AUTHOR"):
                    continue
                if b.type == "comment":
                    ctx2 = ctx
                    # header comment, before the title: attached to the chapter afterwards
                    root.blocks.append(directive("comment", "", [emit.code_block(b.data["text"])], 3))
                    continue
                DIAG.warn("bloc-avant-chapitre", b.type)
                continue
            self.emit_block(b, ctx, stack[-1], top, appendix)
        assert top is not None, path
        top.blocks = root.blocks + top.blocks
        self.unresolved.extend(ctx.unresolved)
        self.number_tree(top, number, appendix)
        return top

    def number_tree(self, sec: Sec, num: str, appendix: bool) -> None:
        sec.num = num
        for lab in sec.labels:
            self.number_of[lab] = num
        for i, c in enumerate(sec.children, 1):
            self.number_tree(c, f"{num}.{i}" if num else str(i), appendix)

    # ---- étiquettes et noms ----------------------------------------------------------

    def assign_names(self, sec: Sec, ch_module: str, ch_id: str, used: set[str]) -> None:
        def unique_tag(base: str) -> str:
            t = base
            n = 2
            while t in self.tags:
                t = f"{base}-{n}"
                n += 1
            self.tags.add(t)
            return t

        def visit(s: Sec, parent: str) -> None:
            lab = next((l for l in s.labels if l.startswith("sec:")), None)
            if s.level == 1:
                base = ch_id
            elif lab:
                base = slugify(lab.split(":", 1)[1])
            else:
                base = (parent + "-" + slugify(s.title)) if parent else slugify(s.title)
                base = base[:60].rstrip("-")
            s.tag = unique_tag(base)
            s.file = s.tag
            for c in s.children:
                visit(c, ch_id.split("-")[0] if s.level == 1 else s.tag)

        visit(sec, "")
        # modules: one per level-2 section
        sec.module = ch_module
        for c in sec.children:
            name = camel(c.title)
            n = 2
            while name in used:
                name = f"{camel(c.title)}{n}"
                n += 1
            used.add(name)
            c.module = f"{ch_module}.{name}"


# --------------------------------------------------------------------------------------
# Writing
# --------------------------------------------------------------------------------------


def esc_title(s: str) -> str:
    toks = emit.inl(parse_inline(s), Ctx(file="", labels=set()))
    # LaTeX does not escape `&` in a section title: a role does it
    return emit.one_line(toks).replace("&", "{amp}[]")


def meta_block(sec: Sec, appendix: bool) -> Chunk:
    lines = ["%%%", f"file := {lean_str(sec.file)}" if sec.level <= 2 else None,
             f"tag := {lean_str(sec.tag)}", "number := false" if appendix else None, "%%%"]
    return [l for l in lines if l is not None]


def title_of(sec: Sec, appendix: bool) -> str:
    t = esc_title(sec.title)
    return f"{sec.num}. {t}" if appendix else t


def label_cmds(sec: Sec, appendix: bool) -> list[str]:
    out = []
    for lab in sec.labels:
        disp = f" (display := {lean_str(sec.num)})" if appendix else ""
        out.append("{label " + lean_str(lab) + disp + "}")
    return out


def render_section_body(sec: Sec, appendix: bool, base_level: int, module_children: bool) -> list[str]:
    """Body of a section: labels, blocks, sub-sections (`#` headings)."""
    out: list[str] = []
    cmds = label_cmds(sec, appendix)
    if cmds:
        out.extend(cmds)
        out.append("")
    for ch in sec.blocks:
        out.extend(ch)
        out.append("")
    for c in sec.children:
        if module_children and c.level == 2:
            out.append("{include 0 Spec." + c.module + "}")
            out.append("")
            continue
        depth = c.level - base_level
        out.append("#" * depth + " " + title_of(c, appendix))
        out.extend(meta_block(c, appendix))
        out.append("")
        out.extend(render_section_body(c, appendix, base_level, False))
    return out


def module_text(sec: Sec, appendix: bool, imports: list[str], base_level: int, module_children: bool,
                refsec: str | None) -> str:
    lines = [HEADER.rstrip("\n"), "", "import VersoManual", "import SpecExt"]
    lines += [f"import Spec.{m}" for m in imports]
    lines += ["", "open Verso.Genre Manual", "open SpecExt", "", "set_option linter.unusedVariables false", ""]
    lines.append(f"#doc (Manual) {lean_str(title_of(sec, appendix))} =>")
    lines.extend(meta_block(sec, appendix))
    lines.append("")
    if refsec:
        lines.append("{refsection " + lean_str(refsec) + "}")
        lines.append("")
    lines.extend(render_section_body(sec, appendix, base_level, module_children))
    while lines and lines[-1] == "":
        lines.pop()
    return "\n".join(lines) + "\n"


# --------------------------------------------------------------------------------------
# Figures
# --------------------------------------------------------------------------------------


def make_figures(builder: Builder, meta: Path, out: Path, mmdc: str | None) -> list[str]:
    out.mkdir(parents=True, exist_ok=True)
    (out / "sources").mkdir(exist_ok=True)
    notes = []
    seen = set()
    for name, src in builder.figures:
        if name in seen:
            continue
        seen.add(name)
        if src.startswith("mermaid:"):
            code = src[len("mermaid:") :]
            (out / "sources" / f"{name}.mmd").write_text(code + "\n", encoding="utf-8")
            if mmdc:
                cfg = out / ".pp.json"
                cfg.write_text('{"executablePath":"/opt/pw-browsers/chromium","args":["--no-sandbox"]}')
                for ext in ("svg", "pdf"):
                    r = subprocess.run([mmdc, "-p", str(cfg), "-i", str(out / "sources" / f"{name}.mmd"), "-o", str(out / f"{name}.{ext}")],
                                       capture_output=True, text=True)
                    if r.returncode:
                        notes.append(f"mermaid {name}.{ext} : {r.stderr.strip()[:200]}")
                cfg.unlink(missing_ok=True)
            else:
                notes.append(f"mermaid {name} : pas de mmdc, figure non générée")
            continue
        pdf = meta / (name + ".pdf")
        if not pdf.exists():
            notes.append(f"figure {name} : {pdf} absent")
            continue
        shutil.copy(pdf, out / f"{name}.pdf")
        if (meta / f"{name}.drawio").exists():
            shutil.copy(meta / f"{name}.drawio", out / "sources" / f"{name}.drawio")
        try:
            import pymupdf

            doc = pymupdf.open(pdf)
            svg = doc[0].get_svg_image(text_as_path=False)
            (out / f"{name}.svg").write_text(svg, encoding="utf-8")
        except Exception as e:  # noqa: BLE001
            notes.append(f"figure {name} : SVG non produit ({e})")
    return notes


# --------------------------------------------------------------------------------------
# Main program
# --------------------------------------------------------------------------------------


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--src", required=True, type=Path, help="dossier src/ du manuscrit")
    ap.add_argument("--meta", required=True, type=Path, help="dossier meta/ (figures drawio exportées en PDF)")
    ap.add_argument("--out", required=True, type=Path, help="racine du dépôt")
    ap.add_argument("--report", type=Path)
    ap.add_argument("--mmdc", default=None)
    args = ap.parse_args()

    blocks_by_file = {p: read_blocks(args.src / p) for p, _, _ in CHAPTERS}
    labels = collect_labels(blocks_by_file)
    glossary = load_glossary(args.src / "K7PL-glossary.org")
    builder = Builder(args.src, labels, glossary, args.out / "spec" / "figures")

    chapter_no = 0
    letters = iter("ABCDEFGHIJ")
    plan = []
    for path, mod, appendix in CHAPTERS:
        if appendix:
            num = next(letters)
        else:
            chapter_no += 1
            num = str(chapter_no)
        plan.append((path, mod, appendix, num))
    # first pass: section numbers, so that the mermaid figures can refer to them
    pre = Builder(args.src, labels, glossary, args.out / "spec" / "figures")
    for path, mod, appendix, num in plan:
        pre.build(path, mod, appendix, num)
    builder = Builder(args.src, labels, glossary, args.out / "spec" / "figures")
    builder.number_of = dict(pre.number_of)
    DIAG.items.clear()
    spec_dir = args.out / "spec"
    mod_dir = spec_dir / "Spec"
    if mod_dir.exists():
        for f in mod_dir.rglob("*.lean"):
            f.unlink()
    mod_dir.mkdir(parents=True, exist_ok=True)

    tops = []
    for path, mod, appendix, num in plan:
        top = builder.build(path, mod, appendix, num)
        stem = slugify(Path(path).stem.removeprefix("K7_"))
        builder.assign_names(top, mod, f"annexe-{stem}" if appendix else stem, set())
        tops.append((top, mod, appendix, path))

    n_files = 0
    for top, mod, appendix, path in tops:
        refsec = slugify(Path(path).stem)
        imports = [c.module for c in top.children if c.level == 2]
        text = module_text(top, appendix, imports, 1, True, refsec)
        (mod_dir / f"{mod}.lean").write_text(text, encoding="utf-8")
        n_files += 1
        for c in top.children:
            sub = mod_dir / mod
            sub.mkdir(exist_ok=True)
            name = c.module.split(".")[-1]
            (sub / f"{name}.lean").write_text(module_text(c, appendix, [], 2, False, None), encoding="utf-8")
            n_files += 1

    # root
    root = [HEADER.rstrip("\n"), "", "import VersoManual", "import SpecExt"]
    root += [f"import Spec.{mod}" for _, mod, _, _ in tops]
    root += ["", "open Verso.Genre Manual", "open SpecExt", "", '#doc (Manual) "K7PL : KonSept Programming Language" =>',
             "%%%", 'authors := ["Cyprien PIERRE"]', 'shortTitle := "K7PL"', "%%%", "",
             "{texsetup}", "", "*A functional layered programming language*", "",
             "*Cyprien PIERRE* — [ORCID 0009-0009-9040-6795](https://orcid.org/0009-0009-9040-6795)", "",
             "DOI : [10.5281/zenodo.23040451](https://doi.org/10.5281/zenodo.23040451) · "
             "Source : [github.com/AntheaLiles/k7pl](https://github.com/AntheaLiles/k7pl)", "",
             "{ccby}[] © Cyprien PIERRE 2026. Cette spécification est publiée sous licence "
             "[Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).", ""]
    for _, mod, _, _ in tops:
        root += ["{include 0 Spec." + mod + "}", ""]
    (spec_dir / "Spec.lean").write_text("\n".join(root).rstrip("\n") + "\n", encoding="utf-8")

    notes = make_figures(builder, args.meta, spec_dir / "figures", args.mmdc)

    # report
    rep = ["# Rapport de conversion Org → Verso", "", f"{n_files + 1} fichiers Lean générés.", ""]
    rep += ["## Références non résolues", ""]
    if builder.unresolved:
        rep += ["| Fichier | Ligne | Label |", "|---|---|---|"]
        rep += [f"| {f} | {l} | `{lab}` |" for f, l, lab in builder.unresolved]
    else:
        rep.append("Aucune.")
    rep += ["", "## Avertissements de l'analyseur", ""]
    if DIAG.items:
        rep += ["| Fichier | Ligne | Nature | Détail |", "|---|---|---|---|"]
        rep += ["| %s | %d | %s | %s |" % (w.file, w.line, w.kind, w.text.replace("|", "\\|")) for w in DIAG.items]
    else:
        rep.append("Aucun.")
    rep += ["", "## Figures", ""] + ([f"- {n}" for n in notes] or ["Toutes les figures ont été produites."])
    if args.report:
        args.report.write_text("\n".join(rep) + "\n", encoding="utf-8")
    print("\n".join(rep[:6]))
    print(f"{len(builder.unresolved)} références non résolues, {len(DIAG.items)} avertissements")
    return 0


if __name__ == "__main__":
    sys.exit(main())
