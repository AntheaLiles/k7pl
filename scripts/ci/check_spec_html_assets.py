#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Validate declared figure assets and local image references in rendered Verso HTML."""

from __future__ import annotations

import re
import sys
from collections import Counter
import xml.etree.ElementTree as ET
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


FIGURE_DECLARATION = re.compile(r"::::figure\b")
FIGURE_SRC = re.compile(r'\(src\s*:=\s*"([^"]+)"\)')


class ImageParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.images: list[tuple[str | None, str | None, str | None, str | None, int]] = []
        self.descriptions: list[tuple[str | None, int]] = []
        self.base_href: str | None = None

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        values = dict(attrs)
        if tag.lower() == "base" and self.base_href is None:
            self.base_href = values.get("href")
            return
        if tag.lower() == "div" and "k7-desc" in (values.get("class") or "").split():
            self.descriptions.append((values.get("id"), self.getpos()[0]))
        if tag.lower() != "img":
            return
        self.images.append(
            (
                values.get("src"),
                values.get("alt"),
                values.get("class"),
                values.get("aria-describedby"),
                self.getpos()[0],
            )
        )


def declared_figure_stems(spec_root: Path) -> tuple[list[str], list[str]]:
    """Return canonical figure asset stems and declaration errors from Verso sources."""
    stems: list[str] = []
    errors: list[str] = []
    for source in sorted(spec_root.rglob("*.lean")):
        try:
            lines = source.read_text(encoding="utf-8").splitlines()
        except (OSError, UnicodeDecodeError) as exc:
            errors.append(f"cannot read Verso source {source}: {exc}")
            continue
        for line_number, line in enumerate(lines, 1):
            if not FIGURE_DECLARATION.search(line):
                continue
            match = FIGURE_SRC.search(line)
            if not match:
                errors.append(f"{source}:{line_number}: figure declaration has no literal src")
                continue
            stem = match.group(1)
            if not stem or stem in {".", ".."} or "/" in stem or "\\" in stem:
                errors.append(f"{source}:{line_number}: unsafe figure asset stem {stem!r}")
                continue
            stems.append(stem)
    duplicates = sorted(stem for stem, count in Counter(stems).items() if count > 1)
    if duplicates:
        errors.append(f"duplicate declared figure asset stems: {', '.join(duplicates)}")
    return stems, errors


def check(html_root: Path, source_figures: Path, spec_root: Path | None = None) -> list[str]:
    errors: list[str] = []
    html_root = html_root.resolve()
    source_figures = source_figures.resolve()
    pages = sorted(html_root.rglob("*.html"))
    if not pages:
        return [f"no HTML pages found under {html_root}"]

    expected_svgs = sorted(source_figures.glob("*.svg"))
    if not expected_svgs:
        errors.append(f"no source SVG assets found under {source_figures}")

    expected_stems: list[str] | None = None
    if spec_root is not None:
        expected_stems, declaration_errors = declared_figure_stems(spec_root.resolve())
        errors.extend(declaration_errors)
        if not expected_stems:
            errors.append(f"no canonical figure declarations found under {spec_root}")
        for stem in sorted(set(expected_stems)):
            for extension in ("svg", "pdf"):
                asset = source_figures / f"{stem}.{extension}"
                if not asset.is_file():
                    errors.append(f"declared figure has no source {extension.upper()} asset: {stem}.{extension}")
            pdf = source_figures / f"{stem}.pdf"
            if pdf.is_file():
                try:
                    if pdf.stat().st_size < 5 or pdf.read_bytes()[:5] != b"%PDF-":
                        errors.append(f"invalid PDF asset for declared figure: {stem}.pdf")
                except OSError as exc:
                    errors.append(f"cannot read PDF asset for declared figure {stem}.pdf: {exc}")
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
    rendered_stems: list[str] = []
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

        description_ids = [identifier for identifier, _ in parser.descriptions if identifier]
        for identifier, line in parser.descriptions:
            if not identifier:
                errors.append(
                    f"{page.relative_to(html_root)}:{line}: K7PL long description has no id"
                )
        duplicate_description_ids = sorted(
            identifier for identifier, count in Counter(description_ids).items() if count > 1
        )
        for identifier in duplicate_description_ids:
            errors.append(
                f"{page.relative_to(html_root)}: duplicate long-description id {identifier!r}"
            )

        for src, alt, classes, described_by, line in parser.images:
            image_count += 1
            if not src:
                errors.append(f"{page.relative_to(html_root)}:{line}: img has no src")
                continue
            is_figure = classes is not None and "k7-img" in classes.split()
            if is_figure:
                figure_count += 1
                if not alt or not alt.strip():
                    errors.append(f"{page.relative_to(html_root)}:{line}: K7PL figure has no alternative text")
                targets = described_by.split() if described_by else []
                if len(targets) != 1:
                    errors.append(
                        f"{page.relative_to(html_root)}:{line}: K7PL figure must reference one long description with aria-describedby"
                    )
                elif targets[0] not in description_ids:
                    errors.append(
                        f"{page.relative_to(html_root)}:{line}: aria-describedby target {targets[0]!r} is not a k7-desc element on this page"
                    )

            parsed = urlsplit(src)
            if is_figure and parsed.path.lower().endswith(".svg"):
                rendered_stems.append(Path(unquote(parsed.path)).stem)
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
    if expected_stems is not None:
        expected_counts = Counter(expected_stems)
        rendered_counts = Counter(rendered_stems)
        if expected_counts != rendered_counts:
            missing = sorted((expected_counts - rendered_counts).elements())
            extra = sorted((rendered_counts - expected_counts).elements())
            errors.append(
                "rendered K7PL figures do not match canonical declarations"
                + (f"; missing: {', '.join(missing)}" if missing else "")
                + (f"; unexpected/duplicate: {', '.join(extra)}" if extra else "")
            )
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
    results = check(html_root, source_figures, root / "spec" / "Spec")
    failed = not (len(results) == 1 and results[0].startswith("validated "))
    for result in results:
        print(("ERROR: " if failed else "OK: ") + result)
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
