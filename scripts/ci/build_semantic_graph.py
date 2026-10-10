#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Generate a small, provenance-preserving graph from explicit Verso references."""
from __future__ import annotations

import argparse
import html
import json
import os
import re
import sys
import textwrap
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import quote
import xml.etree.ElementTree as ET

REPO_ROOT = Path(__file__).resolve().parents[2]
GITHUB_REPO = "AntheaLiles/k7pl"
LABEL_ROLE = re.compile(r'\{label\s+"((?:\\.|[^"])*)"\}')
NUM_ROLE = re.compile(r'\{num\s+"((?:\\.|[^"])*)"\}')
CITE_ROLE = re.compile(r'\{cite\s+"((?:\\.|[^"])*)"\}')
NAMED_LABEL = re.compile(r'\(label\s*:=\s*"((?:\\.|[^"])*)"\)')
NAMED_SRC = re.compile(r'\(src\s*:=\s*"((?:\\.|[^"])*)"\)')
DOC_TITLE = re.compile(r'^#doc\s+\(Manual\)\s+"([^"]+)"')
DECL = re.compile(r'::::([A-Za-z][A-Za-z0-9_]*)')


@dataclass(frozen=True)
class LabelTarget:
    label: str
    title: str
    kind: str
    path: str
    line: int
    asset_stem: str | None = None


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def lean_string(value: str) -> str:
    try:
        return json.loads('"' + value + '"')
    except json.JSONDecodeError:
        return value


def github_url(ref: str, path: str, line: int | None = None) -> str:
    url = f"https://github.com/{GITHUB_REPO}/blob/{quote(ref, safe='')}/{quote(path, safe='/')}"
    return f"{url}#L{line}" if line is not None else url


def source_lines(root: Path, path: str) -> list[str]:
    file = root / path
    if not file.is_file():
        fail(f"source file is missing: {path}")
    return file.read_text(encoding="utf-8").splitlines()


def label_index(root: Path) -> dict[str, LabelTarget]:
    index: dict[str, LabelTarget] = {}
    spec_root = root / "spec" / "Spec"
    for file in sorted(spec_root.rglob("*.lean")):
        lines = file.read_text(encoding="utf-8").splitlines()
        rel = file.relative_to(root).as_posix()
        doc_title = next((m.group(1) for line in lines if (m := DOC_TITLE.match(line.strip()))), file.stem)
        for number, line in enumerate(lines, 1):
            label: str | None = None
            kind = "objet"
            stem: str | None = None
            if match := LABEL_ROLE.search(line):
                label, kind = lean_string(match.group(1)), "section"
                title = doc_title
            elif (match := NAMED_LABEL.search(line)) and (decl := DECL.search(line)):
                label = lean_string(match.group(1))
                command = decl.group(1).lower()
                kind = {
                    "figure": "figure",
                    "k7table": "tableau",
                    "table": "tableau",
                    "thm": "théorème",
                    "theorem": "théorème",
                    "formula": "formule",
                    "listing": "listing",
                }.get(command, "objet")
                src_match = NAMED_SRC.search(line)
                stem = lean_string(src_match.group(1)) if src_match else None
                title = f"Figure {stem}" if kind == "figure" and stem else label
            else:
                continue
            if label in index:
                fail(f"duplicate canonical label {label!r} in {rel}:{number}")
            index[label] = LabelTarget(label, title, kind, rel, number, stem)
    return index


def extract_edges(root: Path, source_path: str, source_label: str, targets: dict[str, LabelTarget], start_line: int, end_line: int) -> tuple[LabelTarget, list[dict[str, object]]]:
    lines = source_lines(root, source_path)
    source = targets.get(source_label)
    if source is None or source.path != source_path:
        fail(f"source label {source_label!r} is not declared in {source_path}")

    bibliography_path = "docs/bibliography/references.json"
    try:
        bibliography = json.loads((root / bibliography_path).read_text(encoding="utf-8"))["entries"]
    except (OSError, json.JSONDecodeError, KeyError, TypeError) as exc:
        fail(f"cannot read bibliography entries: {exc}")

    edges: list[dict[str, object]] = []
    if start_line < 1 or end_line < start_line or start_line > len(lines):
        fail(f"invalid source range {start_line}-{end_line} for {source_path}")
    end_line = min(end_line, len(lines))
    for number, line in enumerate(lines, 1):
        if number < start_line or number > end_line:
            continue
        for match in NUM_ROLE.finditer(line):
            target_label = lean_string(match.group(1))
            target = targets.get(target_label)
            if target is None:
                fail(f"{source_path}:{number}: unresolved num reference {target_label!r}")
            edges.append({
                "kind": "references",
                "target_id": target_label,
                "target_title": target.title,
                "target_kind": target.kind,
                "target_path": target.path,
                "target_line": target.line,
                "source_line": number,
                "source_path": source_path,
                "basis": "référence Verso explicite",
            })
        for match in CITE_ROLE.finditer(line):
            keys = [lean_string(key.strip()) for key in match.group(1).split(",") if key.strip()]
            for key in keys:
                entry = bibliography.get(key)
                if entry is None:
                    fail(f"{source_path}:{number}: unresolved bibliography key {key!r}")
                edges.append({
                    "kind": "cites",
                    "target_id": f"cite:{key}",
                    "target_title": entry.get("title", key),
                    "target_kind": "source bibliographique",
                    "target_path": bibliography_path,
                    "target_line": next((i for i, text in enumerate((root / bibliography_path).read_text(encoding="utf-8").splitlines(), 1) if re.match(rf'\s*"{re.escape(key)}"\s*:', text)), 1),
                    "source_line": number,
                    "source_path": source_path,
                    "basis": "citation Verso explicite",
                    "key": key,
                })
    if not edges:
        fail(f"no explicit num/cite relations found in {source_path}")

    # Deduplicate repeated references for the visual edge, while preserving every source line.
    grouped: dict[tuple[str, str], dict[str, object]] = {}
    for edge in edges:
        key = (str(edge["kind"]), str(edge["target_id"]))
        if key not in grouped:
            grouped[key] = dict(edge)
            grouped[key]["source_lines"] = [edge["source_line"]]
        else:
            grouped[key]["source_lines"].append(edge["source_line"])
    return source, list(grouped.values())


def xml_text(value: str) -> str:
    return html.escape(value, quote=False)


def svg_node(node_id: str, title: str, kind: str, href: str, x: int, y: int, width: int = 230, height: int = 74) -> str:
    fills = {
        "section": "#e8eef5",
        "figure": "#e7f2ea",
        "source bibliographique": "#f6f0df",
        "source": "#ededed",
        "artefact": "#ededed",
        "outil": "#ededed",
    }
    fill = fills.get(kind, "#f1f1f1")
    lines = textwrap.wrap(title, width=27)[:2] or [title]
    label_lines = "".join(
        f'<text x="{x + 12}" y="{y + 28 + i * 18}" font-size="13">{xml_text(line)}</text>'
        for i, line in enumerate(lines)
    )
    return (
        f'<a href="{html.escape(href, quote=True)}" aria-label="{html.escape(title, quote=True)}">'
        f'<rect x="{x}" y="{y}" width="{width}" height="{height}" rx="8" fill="{fill}" stroke="#5b6570" stroke-width="1.2"/>'
        f'{label_lines}<text x="{x + 12}" y="{y + height - 8}" font-size="10" fill="#424b55">{xml_text(kind)}</text></a>'
    )


def svg_edge(x1: int, y1: int, x2: int, y2: int, label: str) -> str:
    middle_x = (x1 + x2) // 2
    middle_y = (y1 + y2) // 2 - 6
    return (
        f'<path d="M {x1} {y1} L {x2} {y2}" fill="none" stroke="#68717a" stroke-width="1.5" marker-end="url(#arrow)"/>'
        f'<text x="{middle_x}" y="{middle_y}" text-anchor="middle" font-size="10" fill="#4a525a">{xml_text(label)}</text>'
    )


def build(root: Path, output: Path, ref: str, source_path: str, source_label: str, start_line: int, end_line: int) -> None:
    targets = label_index(root)
    source, edges = extract_edges(root, source_path, source_label, targets, start_line, end_line)
    tikz_manifest = json.loads((root / "spec" / "figures" / "tikz" / "manifest.json").read_text(encoding="utf-8"))
    tikz_by_stem = {item["asset_stem"]: item for item in tikz_manifest["figures"]}

    section_edges = [edge for edge in edges if edge["kind"] == "references"]
    citation_edges = [edge for edge in edges if edge["kind"] == "cites"]
    relation_nodes: list[dict[str, object]] = []
    for edge in section_edges:
        relation_nodes.append({
            "id": str(edge["target_id"]),
            "title": str(edge["target_title"]),
            "kind": str(edge["target_kind"]),
            "href": github_url(ref, str(edge["target_path"]), int(edge["target_line"])),
            "edge": edge,
        })
    for edge in citation_edges:
        relation_nodes.append({
            "id": str(edge["target_id"]),
            "title": str(edge["target_title"]),
            "kind": "source bibliographique",
            "href": github_url(ref, str(edge["target_path"]), int(edge["target_line"])),
            "edge": edge,
        })

    width = 1380
    row_gap = 100
    height = max(520, 120 + len(relation_nodes) * row_gap)
    source_y = (height - 74) // 2
    source_x, relation_x = 35, 360
    nodes: list[str] = []
    paths: list[str] = []
    source_url = github_url(ref, source.path, source.line)
    nodes.append(svg_node(source.label, source.title, "section", source_url, source_x, source_y, 260, 90))
    relation_positions: dict[str, tuple[int, int]] = {}
    for i, node in enumerate(relation_nodes):
        x, y = relation_x, 40 + i * row_gap
        relation_positions[str(node["id"])] = (x, y)
        nodes.append(svg_node(str(node["id"]), str(node["title"]), str(node["kind"]), str(node["href"]), x, y, 250, 74))
        edge = node["edge"]
        line_label = "num" if edge["kind"] == "references" else "cite"
        paths.append(svg_edge(source_x + 260, source_y + 45, x, y + 37, line_label))

    # Resolve the figure by its label target's asset stem, not by visual label or filename similarity.
    figure_node = next(
        (
            node for node in relation_nodes
            if node["kind"] == "figure"
            and targets.get(str(node["id"])) is not None
            and targets[str(node["id"])].asset_stem in tikz_by_stem
        ),
        None,
    )

    provenance_summary = ""
    if figure_node is not None:
        target = targets[str(figure_node["id"])]
        stem = target.asset_stem or ""
        manifest_item = tikz_by_stem[stem]
        tex_path = f"spec/figures/tikz/{manifest_item['source']}"
        tex_url = github_url(ref, tex_path)
        renderer_path = "tools/SpecExt/Float.lean"
        workflow_path = ".github/workflows/verify.yaml"
        prov_x, output_x = 700, 1040
        fy = relation_positions[str(figure_node["id"])][1]
        source_pos = (prov_x, max(30, fy - 15))
        renderer_pos = (prov_x, source_pos[1] + 105)
        workflow_pos = (prov_x, renderer_pos[1] + 105)
        svg_pos = (output_x, source_pos[1] - 10)
        pdf_pos = (output_x, source_pos[1] + 90)

        nodes.append(svg_node("source:" + stem, Path(tex_path).name, "source", tex_url, *source_pos, 250, 74))
        nodes.append(svg_node("renderer", "Renderer Verso Float.lean", "outil", github_url(ref, renderer_path), *renderer_pos, 250, 74))
        nodes.append(svg_node("workflow", "Validation CI", "outil", github_url(ref, workflow_path), *workflow_pos, 250, 74))
        nodes.append(svg_node("svg:" + stem, f"SVG {stem}", "artefact", f"../figures/{quote(stem, safe='-')}.svg", *svg_pos, 250, 74))

        fx, fy0 = relation_positions[str(figure_node["id"])]
        paths.append(svg_edge(fx + 250, fy0 + 37, source_pos[0], source_pos[1] + 37, "source canonique"))
        paths.append(svg_edge(fx + 250, fy0 + 45, renderer_pos[0], renderer_pos[1] + 37, "rendu"))
        paths.append(svg_edge(source_pos[0] + 250, source_pos[1] + 37, svg_pos[0], svg_pos[1] + 37, "génère"))
        paths.append(svg_edge(workflow_pos[0] + 250, workflow_pos[1] + 37, svg_pos[0], svg_pos[1] + 37, "valide"))

        pdf_path = root / "spec" / "figures" / f"{stem}.pdf"
        if pdf_path.is_file():
            nodes.append(svg_node("pdf:" + stem, f"PDF {stem}", "artefact", f"../figures/{quote(stem, safe='-')}.pdf", *pdf_pos, 250, 74))
            paths.append(svg_edge(source_pos[0] + 250, source_pos[1] + 45, pdf_pos[0], pdf_pos[1] + 37, "génère"))

        svg_path = root / "spec" / "figures" / f"{stem}.svg"
        if not svg_path.is_file():
            fail(f"figure SVG is missing for provenance graph: {svg_path.relative_to(root)}")
        provenance_summary = (
            f'<p>La chaîne de provenance de la figure <a href="../figures/{quote(stem, safe="-")}.svg">{html.escape(stem)}</a> '
            f'est étayée par le manifeste TikZ et la validation CI.</p>'
        )

    svg = (
        f'<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
        f'viewBox="0 0 {width} {height}" role="img" aria-labelledby="graph-title graph-desc">'
        '<title id="graph-title">Relations explicites et provenance de la section</title>'
        '<desc id="graph-desc">Le nœud principal est relié aux références num et citations cite de la source. '
        'La figure possède une chaîne de provenance séparée vers sa source, le renderer et les artefacts.</desc>'
        '<defs><marker id="arrow" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">'
        '<path d="M0,0 L0,6 L6,3 z" fill="#68717a"/></marker></defs>'
        + "".join(paths) + "".join(nodes) + "</svg>"
    )
    # Parse the generated SVG before embedding it so malformed markup fails the build.
    try:
        ET.fromstring(svg)
    except ET.ParseError as exc:
        fail(f"generated graph SVG is invalid: {exc}")

    edge_items: list[str] = []
    for edge in edges:
        target_href = github_url(ref, str(edge["target_path"]), int(edge["target_line"]))
        relation = "Référence explicite" if edge["kind"] == "references" else "Citation bibliographique"
        lines = ", ".join(str(n) for n in edge["source_lines"])
        edge_items.append(
            f'<li><strong>{relation}</strong> : <a href="{html.escape(target_href, quote=True)}">'
            f'{html.escape(str(edge["target_title"]))}</a> — ligne(s) source '
            f'<a href="{html.escape(github_url(ref, source.path, int(edge["source_line"])), quote=True)}">{lines}</a>.</li>'
        )

    page = f"""<!doctype html>
<html lang="fr"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Graphe sémantique — {html.escape(source.title)}</title>
<style>
:root {{ color-scheme: light dark; font-family: system-ui, sans-serif; line-height: 1.5; }}
body {{ max-width: 1440px; margin: 0 auto; padding: 1.25rem; }}
nav {{ display: flex; flex-wrap: wrap; gap: 1rem; margin-bottom: 1rem; }}
.graph {{ overflow-x: auto; border: 1px solid #8888; border-radius: .5rem; padding: .5rem; }}
.graph svg {{ min-width: 960px; width: 100%; height: auto; }}
ul {{ padding-left: 1.4rem; }}
li {{ margin: .5rem 0; }}
.note {{ border-left: 4px solid #777; padding-left: .8rem; }}
</style></head>
<body>
<nav aria-label="Navigation du prototype"><a href="figures.html">Catalogue des figures</a>
<a href="{html.escape(source_url, quote=True)}">Source canonique de la section</a></nav>
<h1>Graphe local : {html.escape(source.title)}</h1>
<p>Ce graphe montre les références Verso et citations explicitement présentes aux lignes {start_line}–{end_line} de la source. Les arêtes de provenance de la figure sont distinguées des relations documentaires. Il ne représente pas les dépendances de preuve ni les liens vers les tests.</p>
<div class="graph">{svg}</div>
<h2>Relations et provenance</h2>
<ul>{''.join(edge_items)}</ul>
{provenance_summary}
<p class="note">Les références et citations sont des liens documentaires explicites ; elles ne prouvent pas à elles seules une dépendance logique. Les liens de génération sont limités aux correspondances attestées par le manifeste et la CI.</p>
</body></html>
"""
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(page, encoding="utf-8")
    print(f"generated semantic graph: {output} ({len(edges)} explicit relations, {len(relation_nodes)} target nodes)")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", type=Path, default=REPO_ROOT)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--ref", default=os.environ.get("GITHUB_SHA", "main"))
    parser.add_argument("--source", default="spec/Spec/C6/LeProcessusDeCompilation.lean")
    parser.add_argument("--label", default="sec:c6-le-processus-de-compilation")
    parser.add_argument("--start-line", type=int, default=22)
    parser.add_argument("--end-line", type=int, default=50)
    args = parser.parse_args()
    root = args.repo_root.resolve()
    output = args.output if args.output.is_absolute() else root / args.output
    build(root, output, args.ref, args.source, args.label, args.start_line, args.end_line)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
