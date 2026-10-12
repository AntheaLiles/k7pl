#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Generate a navigable figure-provenance page from canonical Verso declarations."""
from __future__ import annotations

import argparse
import html
import json
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import quote

REPO_ROOT = Path(__file__).resolve().parents[2]
DECLARATION = re.compile(r'::::figure\b')
NAMED_STRING = re.compile(r'\((label|src|alt)\s*:=\s*"((?:\\.|[^"])*)"\)')
GITHUB_REPO = "AntheaLiles/k7pl"


@dataclass(frozen=True)
class Figure:
    label: str
    stem: str
    alt: str
    description: str
    source_path: str
    source_kind: str
    verso_path: str
    line: int


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def lean_string(value: str) -> str:
    """Decode the common Lean/JSON string escapes without corrupting UTF-8."""
    try:
        return json.loads('"' + value + '"')
    except json.JSONDecodeError:
        return value


def github_url(ref: str, path: str, line: int | None = None) -> str:
    url = f"https://github.com/{GITHUB_REPO}/blob/{quote(ref, safe='')}/{quote(path, safe='/')}"
    return f"{url}#L{line}" if line is not None else url


def rendered_label_href(site_root: Path, output: Path, label: str) -> str:
    """Resolve a canonical figure label to exactly one rendered document anchor."""
    anchor = f"lbl-{label.replace(':', '-')}"
    pattern = re.compile(r'\bid=["\']' + re.escape(anchor) + r'["\']')
    matches: list[Path] = []
    for page in sorted(site_root.rglob("*.html")):
        if page.resolve() == output.resolve():
            continue
        try:
            source = page.read_text(encoding="utf-8")
        except (OSError, UnicodeDecodeError) as exc:
            fail(f"cannot inspect rendered HTML {page}: {exc}")
        if pattern.search(source):
            matches.append(page)
    if len(matches) != 1:
        fail(
            f"rendered anchor {anchor!r} must resolve to exactly one HTML page "
            f"under {site_root}; found {len(matches)}"
        )
    relative = os.path.relpath(matches[0], output.parent).replace(os.sep, "/")
    return f"{quote(relative, safe='/.-_')}#{quote(anchor, safe='-:')}"


def long_description(lines: list[str], declaration_line: int) -> str:
    """Extract the canonical :::desc slot and normalize it for plain-text metadata."""
    inside_description = False
    parts: list[str] = []
    for line in lines[declaration_line + 1:]:
        stripped = line.strip()
        if stripped == "::::":
            break
        if stripped == ":::desc":
            inside_description = True
            continue
        if inside_description and stripped == ":::":
            break
        if inside_description:
            parts.append(stripped)
    text = " ".join(parts)
    text = re.sub(r'§?\{num\s+"[^"]+"\}\[\]', "la section correspondante", text)
    text = re.sub(r'\{cite\s+"[^"]+"\}\[\]', "", text)
    text = re.sub(r'\$\x60([^\x60]*)\x60', r'\1', text)
    text = re.sub(r'\x60([^\x60]*)\x60', r'\1', text)
    text = re.sub(r'[*_]+', "", text)
    return " ".join(text.split())


def discover_figures(root: Path) -> list[Figure]:
    tikz_dir = root / "spec" / "figures" / "tikz"
    try:
        manifest = json.loads((tikz_dir / "manifest.json").read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        fail(f"cannot read canonical TikZ manifest: {exc}")
    if manifest.get("status") != "canonical-tikz-sources":
        fail("TikZ manifest has an unexpected status")

    tikz_by_stem: dict[str, str] = {}
    for item in manifest.get("figures", []):
        stem = item.get("asset_stem", "")
        source = item.get("source", "")
        if not stem or not source or stem in tikz_by_stem:
            fail(f"invalid or duplicate TikZ asset mapping: {item!r}")
        source_path = (tikz_dir / source).resolve()
        if not source_path.is_relative_to(tikz_dir.resolve()) or not source_path.is_file():
            fail(f"TikZ source is missing or escapes its directory: {source!r}")
        tikz_by_stem[stem] = f"spec/figures/tikz/{source}"

    figures_dir = root / "spec" / "figures"
    spec_dir = root / "spec" / "Spec"
    figures: list[Figure] = []
    seen_stems: set[str] = set()
    seen_labels: set[str] = set()

    for source_file in sorted(spec_dir.rglob("*.lean")):
        relative_source = source_file.relative_to(root).as_posix()
        source_lines = source_file.read_text(encoding="utf-8").splitlines()
        for line_index, line in enumerate(source_lines):
            line_number = line_index + 1
            if not DECLARATION.search(line):
                continue
            fields = {key: lean_string(value) for key, value in NAMED_STRING.findall(line)}
            missing = {"label", "src", "alt"} - fields.keys()
            if missing:
                fail(f"{relative_source}:{line_number}: figure declaration misses {sorted(missing)}")
            label, stem, alt = fields["label"], fields["src"], fields["alt"]
            description = long_description(source_lines, line_index)
            if not label or not stem or not alt.strip() or not description:
                fail(f"{relative_source}:{line_number}: empty label, asset stem, alt text or long description")
            if stem in seen_stems or label in seen_labels:
                fail(f"{relative_source}:{line_number}: duplicate figure label or asset stem")
            seen_stems.add(stem)
            seen_labels.add(label)

            if stem in tikz_by_stem:
                source_path, source_kind = tikz_by_stem[stem], "TikZ"
            else:
                drawio = figures_dir / "sources" / f"{stem}.drawio"
                if not drawio.is_file():
                    fail(f"{relative_source}:{line_number}: no canonical source mapped for {stem!r}")
                source_path, source_kind = drawio.relative_to(root).as_posix(), "draw.io"

            svg = figures_dir / f"{stem}.svg"
            if not svg.is_file():
                fail(f"{relative_source}:{line_number}: published SVG is missing: {svg.relative_to(root)}")
            figures.append(Figure(label, stem, alt, description, source_path, source_kind, relative_source, line_number))

    if not figures:
        fail("no figure declarations found under spec/Spec")
    if len(figures) != len(seen_stems):
        fail("figure inventory is inconsistent")
    return figures


def render_page(root: Path, output: Path, ref: str) -> None:
    figures = discover_figures(root)
    renderer_url = github_url(ref, "tools/SpecExt/Float.lean")
    workflow_url = github_url(ref, ".github/workflows/verify.yaml")
    manifest_url = github_url(ref, "spec/figures/tikz/manifest.json")

    cards: list[str] = []
    for figure in figures:
        stem = html.escape(figure.stem, quote=True)
        alt = html.escape(figure.alt, quote=True)
        description = html.escape(figure.description)
        description_id = html.escape(f"figure-description-{figure.stem}", quote=True)
        label = html.escape(figure.label)
        source_path = html.escape(figure.source_path)
        source_url = github_url(ref, figure.source_path)
        verso_url = github_url(ref, figure.verso_path, figure.line)
        document_href = rendered_label_href(output.parent.parent, output, figure.label)
        svg_url = f"../figures/{quote(figure.stem, safe='-')}.svg"
        pdf_path = root / "spec" / "figures" / f"{figure.stem}.pdf"
        pdf_link = (
            f'<a href="../figures/{quote(figure.stem, safe="-")}.pdf">PDF</a>'
            if pdf_path.is_file()
            else '<span class="unavailable">PDF non disponible</span>'
        )
        cards.append(
            f'<article class="figure-card" id="{stem}">'
            f'<div class="figure-preview"><a href="{svg_url}"><img class="k7-provenance-img" src="{svg_url}" '
            f'alt="{alt}" aria-describedby="{description_id}" loading="lazy"></a></div>'
            f'<div class="figure-details"><h2>{label}</h2>'
            f'<p class="figure-description" id="{description_id}">{description}</p>'
            f'<p class="asset">{stem}</p>'
            f'<p class="source-kind">Source canonique : {html.escape(figure.source_kind)}</p>'
            f'<p class="actions"><a href="{html.escape(document_href, quote=True)}">Page documentaire</a>'
            f'<a href="{html.escape(verso_url, quote=True)}">Déclaration Verso</a>'
            f'<a href="{html.escape(source_url, quote=True)}">Source graphique</a>'
            f'<a href="{svg_url}">SVG publié</a>{pdf_link}</p>'
            f'<p class="source-path"><code>{source_path}</code></p></div></article>'
        )

    page = f"""<!doctype html>
<html lang="fr" data-k7pl-generated-ref="{html.escape(ref, quote=True)}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Provenance des figures — K7PL</title>
<style>
:root {{ color-scheme: light dark; font-family: system-ui, sans-serif; line-height: 1.5; }}
body {{ max-width: 1120px; margin: 0 auto; padding: 1.25rem; }}
a {{ text-underline-offset: .18em; }}
header {{ border-bottom: 1px solid currentColor; padding-bottom: 1rem; margin-bottom: 1.5rem; }}
nav {{ display: flex; flex-wrap: wrap; gap: .8rem; }}
.figure-list {{ display: grid; grid-template-columns: repeat(auto-fit, minmax(min(100%, 440px), 1fr)); gap: 1rem; }}
.figure-card {{ display: grid; grid-template-columns: minmax(120px, 42%) 1fr; gap: 1rem; align-items: start; border: 1px solid #8888; border-radius: .6rem; padding: .8rem; min-width: 0; }}
.figure-preview img {{ display: block; width: 100%; height: auto; max-height: 230px; object-fit: contain; }}
.figure-details h2 {{ font-size: 1.05rem; margin: 0 0 .25rem; overflow-wrap: anywhere; }}
.figure-description {{ margin: .3rem 0; font-size: .92rem; overflow-wrap: anywhere; }}
.asset, .source-path {{ font-size: .85rem; overflow-wrap: anywhere; }}
.source-kind {{ font-size: .9rem; }}
.actions {{ display: flex; flex-wrap: wrap; gap: .6rem; }}
.unavailable {{ opacity: .75; font-size: .9rem; }}
footer {{ margin-top: 2rem; border-top: 1px solid currentColor; padding-top: 1rem; }}
@media (max-width: 560px) {{ .figure-card {{ grid-template-columns: 1fr; }} .figure-preview img {{ max-height: 260px; }} }}
</style>
</head>
<body>
<header>
<h1>Provenance des figures K7PL</h1>
<p>Catalogue généré à partir des déclarations de figures Verso et du manifeste des sources TikZ. Il relie chaque figure à sa déclaration, sa source graphique et ses rendus publiés ; il ne prétend pas encore représenter les relations conceptuelles de la spécification.</p>
<nav aria-label="Sources de la chaîne de rendu">
<a href="index.html">Exploration générale</a>
<a href="{html.escape(renderer_url, quote=True)}">Renderer Verso</a>
<a href="{html.escape(workflow_url, quote=True)}">Workflow de validation</a>
<a href="{html.escape(manifest_url, quote=True)}">Manifeste des sources TikZ</a>
<a href="semantic-graph.html">Graphe du processus de compilation (C6)</a>
<a href="semantic-graph-c3.html">Graphe du système gradué (C3)</a>
</nav>
<p>{len(figures)} figures déclarées recensées. Les liens vers les sources sont épinglés à la révision qui a généré cette page.</p>
</header>
<main class="figure-list" aria-label="Figures et provenance">
{''.join(cards)}
</main>
<footer>
<p>Cette page est un artefact dérivé : ne pas éditer son HTML. Les légendes et textes alternatifs restent dans les déclarations Verso ; les sources graphiques restent dans leurs fichiers canoniques. Le graphe sémantique et la navigation entre concepts, preuves et tests constituent une étape distincte.</p>
</footer>
</body>
</html>
"""
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(page, encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", type=Path, default=REPO_ROOT)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--ref", default=os.environ.get("GITHUB_SHA", "main"))
    args = parser.parse_args()
    root = args.repo_root.resolve()
    output = args.output if args.output.is_absolute() else root / args.output
    try:
        render_page(root, output, args.ref)
    except OSError as exc:
        fail(f"cannot generate provenance page: {exc}")
    print(f"generated figure provenance page: {output} ({len(discover_figures(root))} figures)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
