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
        self.base_href: str | None = None

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        values = dict(attrs)
        if tag.lower() == "base" and self.base_href is None:
            self.base_href = values.get("href")
            return
        if tag.lower() != "img":
            return
        self.images.append(
            (values.get("src"), values.get("alt"), values.get("class"), self.getpos()[0])
        )


def check(html_root: Path, source_figures: Path) -> list[str]:
    errors: list[str] = []
    html_root = html_root.resolve()
    source_figures = source_figures.resolve()
    pages = sorted(html_root.rglob("*.html"))
    if not pages:
        return [f"no HTML pages found under {html_root}"]

    expected_svgs = sorted(source_figures.glob("*.svg"))
    if not expected_svgs:
        errors.append(f"no source SVG assets found under {source_figures}")
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

        base_dir = page.parent
        if parser.base_href:
            base = urlsplit(parser.base_href)
            if base.scheme or base.netloc:
                base_dir = None
            else:
                base_path = unquote(base.path)
                base_dir = (
                    (html_root / base_path.lstrip("/"))
                    if base_path.startswith("/")
                    else (page.parent / base_path)
                ).resolve()

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
            if parsed.scheme or parsed.netloc or parsed.scheme == "data":
                continue
            path = unquote(parsed.path)
            if path.startswith("/"):
                target = html_root / path.lstrip("/")
            elif base_dir is not None:
                target = base_dir / path
            else:
                errors.append(
                    f"{page.relative_to(html_root)}:{line}: relative image uses an external base URL: {src}"
                )
                continue
            target = target.resolve()
            if not target.is_relative_to(html_root):
                errors.append(f"{page.relative_to(html_root)}:{line}: image path escapes the HTML site: {src}")
            elif not target.is_file():
                errors.append(f"{page.relative_to(html_root)}:{line}: image asset does not exist: {src}")

    if figure_count == 0:
        errors.append("no K7PL figure elements found in generated HTML")
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
    failed = not (len(results) == 1 and results[0].startswith("validated "))
    for result in results:
        print(("ERROR: " if failed else "OK: ") + result)
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
