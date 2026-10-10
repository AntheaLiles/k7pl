#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Add accessible names and long descriptions to figure SVGs in rendered site assets."""
from __future__ import annotations

import argparse
import re
import sys
import xml.etree.ElementTree as ET
from collections import Counter
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit

SVG_NS = "http://www.w3.org/2000/svg"
XLINK_NS = "http://www.w3.org/1999/xlink"
ET.register_namespace("", SVG_NS)
ET.register_namespace("xlink", XLINK_NS)


class FigureMetadataParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.images: list[tuple[str | None, str | None, str | None, str | None, int]] = []
        self.descriptions: dict[str, str] = {}
        self.active_id: str | None = None
        self.active_tag: str | None = None
        self.active_depth = 0
        self.active_line = 0
        self.active_text: list[str] = []
        self.errors: list[str] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        values = dict(attrs)
        classes = (values.get("class") or "").split()

        if self.active_id is not None and tag.lower() == self.active_tag:
            self.active_depth += 1
        elif self.active_id is None and tag.lower() == "div" and "k7-desc" in classes:
            identifier = values.get("id")
            if not identifier:
                self.errors.append(f"line {self.getpos()[0]}: long description has no id")
            else:
                self.active_id = identifier
                self.active_tag = "div"
                self.active_depth = 1
                self.active_line = self.getpos()[0]
                self.active_text = []

        if tag.lower() == "img" and "k7-img" in classes:
            self.images.append((
                values.get("src"),
                values.get("alt"),
                values.get("aria-describedby"),
                values.get("class"),
                self.getpos()[0],
            ))

    def handle_endtag(self, tag: str) -> None:
        if self.active_id is None or tag.lower() != self.active_tag:
            return
        self.active_depth -= 1
        if self.active_depth == 0:
            text = " ".join("".join(self.active_text).replace("\xa0", " ").split())
            if self.active_id in self.descriptions:
                self.errors.append(f"line {self.active_line}: duplicate long-description id {self.active_id!r}")
            elif not text:
                self.errors.append(f"line {self.active_line}: long description {self.active_id!r} is empty")
            else:
                self.descriptions[self.active_id] = text
            self.active_id = None
            self.active_tag = None
            self.active_text = []

    def handle_data(self, data: str) -> None:
        if self.active_id is not None:
            self.active_text.append(data)


def collect_metadata(html_root: Path) -> dict[str, tuple[str, str]]:
    metadata: dict[str, tuple[str, str]] = {}
    errors: list[str] = []
    pages = sorted(html_root.rglob("*.html"))
    if not pages:
        raise ValueError(f"no HTML pages found under {html_root}")

    for page in pages:
        parser = FigureMetadataParser()
        try:
            parser.feed(page.read_text(encoding="utf-8"))
            parser.close()
        except (OSError, UnicodeDecodeError) as exc:
            errors.append(f"cannot read {page.relative_to(html_root)}: {exc}")
            continue
        errors.extend(f"{page.relative_to(html_root)}:{item}" for item in parser.errors)

        for src, alt, described_by, _classes, line in parser.images:
            if not src or not alt or not alt.strip():
                errors.append(f"{page.relative_to(html_root)}:{line}: figure image has no src or alternative text")
                continue
            targets = described_by.split() if described_by else []
            if len(targets) != 1:
                errors.append(f"{page.relative_to(html_root)}:{line}: figure must reference one long description")
                continue
            description = parser.descriptions.get(targets[0])
            if not description:
                errors.append(
                    f"{page.relative_to(html_root)}:{line}: missing or empty long description {targets[0]!r}"
                )
                continue

            parsed = urlsplit(src)
            if parsed.scheme or parsed.netloc or not parsed.path.lower().endswith(".svg"):
                errors.append(f"{page.relative_to(html_root)}:{line}: unsupported figure SVG source {src!r}")
                continue
            path = unquote(parsed.path)
            if Path(path).parent.as_posix() != "figures":
                errors.append(f"{page.relative_to(html_root)}:{line}: figure SVG is not under figures/: {src!r}")
                continue
            stem = Path(path).stem
            if stem in metadata:
                errors.append(f"{page.relative_to(html_root)}:{line}: duplicate figure SVG reference {stem!r}")
                continue
            metadata[stem] = (" ".join(alt.split()), description)

    if not metadata:
        errors.append(f"no K7PL figure metadata found under {html_root}")
    if errors:
        raise ValueError("\n".join(errors))
    return metadata


def enrich_svg(svg_path: Path, title: str, description: str) -> None:
    try:
        tree = ET.parse(svg_path)
    except (ET.ParseError, OSError) as exc:
        raise ValueError(f"cannot parse SVG {svg_path}: {exc}") from exc
    root = tree.getroot()
    if root.tag.split("}")[-1] != "svg":
        raise ValueError(f"root element is not SVG: {svg_path}")
    namespace = root.tag[1:].split("}")[0] if root.tag.startswith("{") else SVG_NS
    title_tag = f"{{{namespace}}}title"
    desc_tag = f"{{{namespace}}}desc"

    for child in list(root):
        if child.tag in (title_tag, desc_tag):
            root.remove(child)

    title_id = f"k7pl-{svg_path.stem}-title"
    description_id = f"k7pl-{svg_path.stem}-description"
    title_element = ET.Element(title_tag, {"id": title_id})
    title_element.text = title
    description_element = ET.Element(desc_tag, {"id": description_id})
    description_element.text = description
    root.set("role", "img")
    root.set("aria-labelledby", title_id)
    root.set("aria-describedby", description_id)
    root.insert(0, title_element)
    root.insert(1, description_element)
    tree.write(svg_path, encoding="utf-8", xml_declaration=True)


def enrich_site(html_root: Path) -> int:
    html_root = html_root.resolve()
    metadata = collect_metadata(html_root)
    figures_dir = (html_root / "figures").resolve()
    if not figures_dir.is_relative_to(html_root) or not figures_dir.is_dir():
        raise ValueError(f"figure SVG directory is missing or escapes HTML site: {figures_dir}")

    for stem, (title, description) in metadata.items():
        if not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9._-]*", stem):
            raise ValueError(f"unsafe figure SVG stem {stem!r}")
        svg = figures_dir / f"{stem}.svg"
        if not svg.is_file() or not svg.resolve().is_relative_to(figures_dir):
            raise ValueError(f"declared figure SVG is missing or escapes figures/: {stem}.svg")
        enrich_svg(svg, title, description)
    return len(metadata)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--html-root", type=Path, default=Path("_out/spec/html-multi"))
    args = parser.parse_args()
    try:
        count = enrich_site(args.html_root)
    except (OSError, ValueError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1
    print(f"enriched {count} published SVGs with accessible title and description")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
