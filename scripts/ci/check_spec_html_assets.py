#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Validate local image references in the generated multi-page Verso HTML."""

from __future__ import annotations

import sys
import xml.etree.ElementTree as ET
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


class ImageParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.images: list[tuple[str | None, str | None, str | None, int]] = []
        self._line = 1

    def feed(self, data: str) -> None:
        super().feed(data)

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        if tag.lower() != "img":
            return
        values = dict(attrs)
        self.images.append((values.get("src"), values.get("alt"), values.get("class"), self.getpos()[0]))


def check(html_root: Path, source_figures: Path) -> list[str]:
    errors: list[str] = []
    html_root = html_root.resolve()
    source_figures = source_figures.resolve()
    pages = sorted(html_root.rglob("*.html"))
    if not pages:
        return [f"no HTML pages found under {html_root}"]

    expected_svgs = sorted(source_figures.glob("*.svg"))
    for source in expected_svgs:
        copied = html_root / "figures" / source.name
        if not copied.is_file():
            errors.append(f"figure asset was not copied into the HTML site: {copied.relative_to(html_root)}")
            continue
        try:
            ET.parse(copied)
        except (ET.ParseError, OSError) as exc:
            errors.append(f"invalid SVG {copied.relative_to(html_root)}: {exc}")

    image_count = 0
    figure_count = 0
    for page in pages:
        try:
            parser = ImageParser()
            parser.feed(page.read_text(encoding="utf-8"))
        except (OSError, UnicodeDecodeError) as exc:
            errors.append(f"cannot read HTML page {page.relative_to(html_root)}: {exc}")
            continue

        for src, alt, classes, line in parser.images:
            image_count += 1
            if not src:
                errors.append(f"{page.relative_to(html_root)}:{line}: img has no src")
                continue
            if classes and "k7-img" in classes.split():
                figure_count += 1
                if not alt or not alt.strip():
                    errors.append(f"{page.relative_to(html_root)}:{line}: K7PL figure has no alternative text")

            parsed = urlsplit(src)
            if parsed.scheme or parsed.netloc or parsed.path.startswith("data:"):
                continue
            path = unquote(parsed.path)
            target = (html_root / path.lstrip("/")) if path.startswith("/") else (page.parent / path)
            target = target.resolve()
            if not target.is_relative_to(html_root):
                errors.append(f"{page.relative_to(html_root)}:{line}: image path escapes the HTML site: {src}")
            elif not target.is_file():
                errors.append(f"{page.relative_to(html_root)}:{line}: image asset does not exist: {src}")

    if errors:
        return errors
    return [
        f"validated {len(pages)} HTML pages, {image_count} local image references, "
        f"{len(expected_svgs)} copied SVG assets ({figure_count} image references in the HTML source lines)"
    ]


def main() -> int:
    root = Path(__file__).resolve().parents[2]
    html_root = Path(sys.argv[1]) if len(sys.argv) > 1 else root / "_out/spec/html-multi"
    source_figures = root / "spec/figures"
    results = check(html_root, source_figures)
    failed = any(result.startswith(("no HTML pages", "figure asset", "invalid SVG", "cannot read", "image path", "img has", "K7PL figure",)) for result in results)
    for result in results:
        print(("ERROR: " if failed else "OK: ") + result)
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
