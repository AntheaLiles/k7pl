#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Validate the generated navigation slice, including freshness and link provenance."""
from __future__ import annotations

import argparse
import os
import re
import sys
from collections import Counter
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit

REPO_ROOT = Path(__file__).resolve().parents[2]
PAGES = (
    "navigation/figures.html",
    "navigation/semantic-graph.html",
    "navigation/semantic-graph-c3.html",
)
GITHUB_BLOB = re.compile(r"^/AntheaLiles/k7pl/blob/([^/]+)/(.+)$")
LINE_FRAGMENT = re.compile(r"^L([1-9][0-9]*)(?:-L([1-9][0-9]*))?$")


class PageParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.ids: Counter[str] = Counter()
        self.links: list[str] = []
        self.scripts = 0
        self.styles: list[str] = []
        self._in_style = False

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        values = dict(attrs)
        identifier = values.get("id")
        if identifier:
            self.ids[identifier] += 1
        if tag.lower() == "a" and values.get("href") is not None:
            self.links.append(values["href"] or "")
        if tag.lower() == "script":
            self.scripts += 1
        if tag.lower() == "style":
            self._in_style = True

    def handle_startendtag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        self.handle_starttag(tag, attrs)
        if tag.lower() == "style":
            self._in_style = False

    def handle_endtag(self, tag: str) -> None:
        if tag.lower() == "style":
            self._in_style = False

    def handle_data(self, data: str) -> None:
        if self._in_style:
            self.styles.append(data)


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def parse_html(path: Path) -> tuple[str, PageParser]:
    try:
        source = path.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as exc:
        fail(f"cannot read HTML page {path}: {exc}")
    parser = PageParser()
    parser.feed(source)
    parser.close()
    return source, parser


def check_github_blob(repo_root: Path, href: str, expected_ref: str) -> None:
    parsed = urlsplit(href)
    match = GITHUB_BLOB.fullmatch(unquote(parsed.path))
    if not match:
        return
    ref, repo_path = match.groups()
    if ref != expected_ref:
        fail(f"stale source link points to ref {ref!r}, expected {expected_ref!r}: {href}")
    source_path = (repo_root / unquote(repo_path)).resolve()
    if not source_path.is_relative_to(repo_root.resolve()) or not source_path.is_file():
        fail(f"source link points to a missing canonical file: {href}")
    if parsed.fragment:
        line_match = LINE_FRAGMENT.fullmatch(parsed.fragment)
        if line_match:
            line = int(line_match.group(1))
            try:
                count = len(source_path.read_text(encoding="utf-8").splitlines())
            except (OSError, UnicodeDecodeError) as exc:
                fail(f"cannot inspect source link target {source_path}: {exc}")
            if line > count:
                fail(f"source link points beyond end of file (line {line}, file has {count}): {href}")
            if line_match.group(2) and int(line_match.group(2)) > count:
                fail(f"source link range points beyond end of file: {href}")


def check_local_link(html_root: Path, page: Path, href: str) -> None:
    parsed = urlsplit(href)
    if parsed.scheme:
        if parsed.scheme.lower() == "javascript":
            fail(f"JavaScript URL is not permitted in the static navigation slice: {href}")
        return
    if parsed.netloc:
        return
    rel_path = unquote(parsed.path)
    candidate = (page.parent / rel_path).resolve() if rel_path else page.resolve()
    root = html_root.resolve()
    if not candidate.is_relative_to(root):
        fail(f"local link escapes generated site root: {href} from {page}")
    if candidate.is_dir():
        candidate = candidate / "index.html"
    if not candidate.is_file():
        fail(f"broken local link: {href} from {page}")
    if parsed.fragment and candidate.suffix.lower() in {".html", ".htm"}:
        _, target = parse_html(candidate)
        fragment = unquote(parsed.fragment)
        count = target.ids.get(fragment, 0)
        if count != 1:
            fail(f"local anchor {fragment!r} must occur exactly once, found {count}: {href} from {page}")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", type=Path, default=REPO_ROOT)
    parser.add_argument("--html-root", type=Path, required=True)
    parser.add_argument("--ref", default=os.environ.get("GITHUB_SHA", "main"))
    args = parser.parse_args()
    repo_root = args.repo_root.resolve()
    html_root = args.html_root.resolve()
    if not html_root.is_dir():
        fail(f"generated HTML root does not exist: {html_root}")

    total_links = 0
    local_links = 0
    github_links = 0
    for relative in PAGES:
        page = html_root / relative
        if not page.is_file():
            fail(f"required navigation output is missing: {relative}")
        source, parsed = parse_html(page)
        ref = re.search(r'\bdata-k7pl-generated-ref="([^"]+)"', source)
        if not ref:
            fail(f"generated output lacks a revision marker: {relative}")
        if ref.group(1) != args.ref:
            fail(f"stale generated output {relative}: {ref.group(1)!r} != {args.ref!r}")
        if parsed.scripts:
            fail(f"navigation output must work without JavaScript; script element found in {relative}")
        if re.search(r"outline\s*:\s*(?:none|0)(?:\s*!important)?\s*[;}]", "".join(parsed.styles), re.I):
            fail(f"navigation output removes native focus indication: {relative}")

        styles = "".join(parsed.styles)
        if relative.endswith("figures.html") and "@media (max-width: 560px)" not in styles:
            fail("figure catalog lacks the expected narrow-screen responsive rule")
        if "semantic-graph" in relative and (
            "overflow-x: auto" not in styles or "min-width: 960px" not in styles
        ):
            fail(f"graph view must keep a horizontally scrollable narrow-screen viewport: {relative}")

        for href in parsed.links:
            total_links += 1
            url = urlsplit(href)
            if url.scheme.lower() == "javascript":
                fail(f"JavaScript URL is not permitted in the static navigation slice: {href}")
            if url.scheme.lower() in {"http", "https"} and url.hostname == "github.com":
                check_github_blob(repo_root, href, args.ref)
                if GITHUB_BLOB.fullmatch(unquote(url.path)):
                    github_links += 1
                continue
            if url.scheme or url.netloc:
                continue
            check_local_link(html_root, page, href)
            local_links += 1

    print(
        f"navigation outputs validated: {len(PAGES)} pages, {total_links} links "
        f"({local_links} local, {github_links} pinned GitHub source links), ref={args.ref}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
