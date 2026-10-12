#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Validate the published interactive navigation page and its generated relation graph."""
from __future__ import annotations

import argparse
import json
import posixpath
import sys
from collections import Counter
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import parse_qs, unquote, urljoin, urlsplit

NAVIGATION_PAGE = "navigation/index.html"
GRAPH_DATA = "navigation/graph.json"
EXPECTED_NAV_LINKS = (
    "../index.html",
    "figures.html",
    "semantic-graph.html",
    "semantic-graph-c3.html",
)
NODE_KINDS = {"document", "section", "figure", "table", "listing", "statement", "bibliography", "anchor"}
EDGE_KINDS = {"contains", "references", "cites"}
VOID_TAGS = {
    "area", "base", "br", "col", "embed", "hr", "img", "input", "link",
    "meta", "param", "source", "track", "wbr",
}


class HTMLFacts(HTMLParser):
    """Collect the small subset of HTML facts needed for deterministic validation."""

    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.ids: list[str] = []
        self.links: list[str] = []
        self.base_href: str | None = None
        self.generated_ref: str | None = None
        self.scripts: list[dict[str, str | None]] = []
        self.nav_entry_count = 0
        self.nav_entry_links: list[str] = []
        self._stack: list[tuple[str, bool]] = []
        self._in_nav_entry = False

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        values = dict(attrs)
        identifier = values.get("id")
        if identifier:
            self.ids.append(identifier)
        if tag == "base" and self.base_href is None:
            self.base_href = values.get("href")
        if tag == "meta" and values.get("name") == "k7pl-generated-ref":
            self.generated_ref = values.get("content")
        if tag == "script":
            self.scripts.append(values)
        href = values.get("href")
        if tag == "a" and href is not None:
            self.links.append(href)
            if self._in_nav_entry:
                self.nav_entry_links.append(href)
        is_entry = identifier == "k7pl-navigation-entry"
        if is_entry:
            self.nav_entry_count += 1
        previous = self._in_nav_entry
        if is_entry:
            self._in_nav_entry = True
        if tag not in VOID_TAGS:
            self._stack.append((tag, self._in_nav_entry))
        elif is_entry:
            self._in_nav_entry = previous

    def handle_startendtag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        self.handle_starttag(tag, attrs)
        if tag not in VOID_TAGS:
            self.handle_endtag(tag)

    def handle_endtag(self, tag: str) -> None:
        for index in range(len(self._stack) - 1, -1, -1):
            if self._stack[index][0] == tag:
                self._in_nav_entry = self._stack[index - 1][1] if index > 0 else False
                del self._stack[index:]
                return


def parse_html(path: Path) -> HTMLFacts:
    parser = HTMLFacts()
    parser.feed(path.read_text(encoding="utf-8"))
    parser.close()
    return parser


def resolved_local_target(site_root: Path, source_page: str, base_href: str | None, href: str) -> tuple[str, str]:
    """Return the site-relative path and fragment after browser-like base URL resolution."""
    parsed_href = urlsplit(href)
    if parsed_href.scheme or parsed_href.netloc:
        raise ValueError(f"expected a local URL, got {href!r}")
    origin = "https://k7pl.invalid/"
    page_url = urljoin(origin, source_page)
    base_url = urljoin(page_url, base_href or ".")
    resolved = urlsplit(urljoin(base_url, href))
    path = posixpath.normpath(unquote(resolved.path).lstrip("/"))
    if path in {"", "."}:
        path = "index.html"
    if path == ".." or path.startswith("../"):
        raise ValueError(f"local URL escapes the site root: {href!r} from {source_page}")
    return path, unquote(resolved.fragment)


def check(site_root: Path, expected_ref: str) -> list[str]:
    errors: list[str] = []
    site_root = site_root.resolve()
    page_path = site_root / NAVIGATION_PAGE
    graph_path = site_root / GRAPH_DATA
    if not site_root.is_dir():
        return [f"generated HTML root does not exist: {site_root}"]
    if not page_path.is_file():
        return [f"interactive navigation page is missing: {NAVIGATION_PAGE}"]
    if not graph_path.is_file():
        return [f"interactive relation data is missing: {GRAPH_DATA}"]

    try:
        page_source = page_path.read_text(encoding="utf-8")
        page = parse_html(page_path)
        graph = json.loads(graph_path.read_text(encoding="utf-8"))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        return [f"cannot read generated interactive navigation output: {exc}"]

    if page.generated_ref != expected_ref:
        errors.append(f"stale interactive page revision: {page.generated_ref!r} != {expected_ref!r}")
    if graph.get("generated_ref") != expected_ref:
        errors.append(f"stale graph data revision: {graph.get('generated_ref')!r} != {expected_ref!r}")
    if page_source.count("__GENERATED_REF__"):
        errors.append("interactive page contains an unresolved revision placeholder")
    if page_source.count('id="search"') != 1 or page_source.count('id="depth"') != 1:
        errors.append("interactive page must expose exactly one node search and one depth control")
    if page_source.count('id="reset-selection"') != 1:
        errors.append("interactive page must provide a return-to-start control")
    if page_source.count('id="selected-link"') != 1:
        errors.append("interactive page must provide a direct link to the selected document object")
    if page_source.count('id="detail-level"') != 1 or page_source.count('id="object-detail"') != 1:
        errors.append("interactive page must provide progressive object-detail controls")
    if 'class="graph-scroll"' not in page_source or "Défilement horizontal possible" not in page_source:
        errors.append("interactive graph must remain horizontally navigable on narrow screens")
    if "<noscript>" not in page_source or "La vue interactive nécessite JavaScript" not in page_source:
        errors.append("interactive page must provide an explicit no-script fallback")
    if 'id="node-list"' not in page_source or 'id="relations"' not in page_source:
        errors.append("interactive page must expose text lists as an alternative to the graph drawing")
    if "Source de la relation" not in page_source:
        errors.append("interactive page must expose each relation's source page in its details")
    if "listLimit" not in page_source or "Afficher les " not in page_source:
        errors.append("interactive page must let readers reach search results beyond the initial page")
    for kind in EDGE_KINDS:
        if f'data-edge-kind="{kind}"' not in page_source:
            errors.append(f"interactive page has no filter for relation type {kind!r}")
    if page_source.count('fetch("./graph.json")') != 1:
        errors.append("interactive page must load its co-generated graph.json")
    if len(page.scripts) != 1 or page.scripts[0].get("src"):
        errors.append("interactive page must have exactly one inline script and no remote script dependency")
    if "<noscript>" not in page_source or "La vue interactive nécessite JavaScript" not in page_source:
        errors.append("interactive page must provide an explicit no-script fallback")

    nav_links = set(page.links)
    for href in EXPECTED_NAV_LINKS:
        if href not in nav_links:
            errors.append(f"interactive page is missing navigation link {href!r}")
        target = site_root / posixpath.normpath(posixpath.join("navigation", href))
        if not target.is_file():
            errors.append(f"interactive navigation target does not exist: {href!r}")

    if graph.get("schema_version") != 1:
        errors.append(f"unsupported graph schema_version: {graph.get('schema_version')!r}")
    if graph.get("unresolved_links") != []:
        errors.append("graph contains unresolved explicit links")
    nodes = graph.get("nodes")
    edges = graph.get("edges")
    summary = graph.get("summary")
    if not isinstance(nodes, list) or not nodes:
        errors.append("graph must contain a non-empty nodes array")
        nodes = []
    if not isinstance(edges, list):
        errors.append("graph must contain an edges array")
        edges = []
    if not isinstance(summary, dict):
        errors.append("graph summary is missing")
        summary = {}

    node_ids: set[str] = set()
    for index, node in enumerate(nodes):
        if not isinstance(node, dict):
            errors.append(f"graph node {index} is not an object")
            continue
        node_id = node.get("id")
        kind = node.get("kind")
        url = node.get("url")
        if not isinstance(node_id, str) or not node_id:
            errors.append(f"graph node {index} has no stable string id")
            continue
        if node_id in node_ids:
            errors.append(f"duplicate graph node id: {node_id!r}")
        node_ids.add(node_id)
        if not isinstance(kind, str) or kind not in NODE_KINDS:
            errors.append(f"graph node {node_id!r} has unknown kind {kind!r}")
        description = node.get("description")
        if not isinstance(description, str):
            errors.append(f"graph node {node_id!r} has no rendered description field")
        if not isinstance(url, str) or not url:
            errors.append(f"graph node {node_id!r} has no destination URL")
            continue
        try:
            target_path, fragment = resolved_local_target(site_root, NAVIGATION_PAGE, None, "../" + url)
        except ValueError as exc:
            errors.append(f"invalid destination for graph node {node_id!r}: {exc}")
            continue
        target_file = site_root / target_path
        if not target_file.is_file():
            errors.append(f"graph node {node_id!r} targets missing HTML: {target_path}")
            continue
        if fragment:
            try:
                target_facts = parse_html(target_file)
            except (OSError, UnicodeDecodeError) as exc:
                errors.append(f"cannot inspect target for node {node_id!r}: {exc}")
                continue
            if fragment not in target_facts.ids:
                errors.append(f"graph node {node_id!r} targets missing anchor {target_path}#{fragment}")

    edge_counts: Counter[str] = Counter()
    for index, edge in enumerate(edges):
        if not isinstance(edge, dict):
            errors.append(f"graph edge {index} is not an object")
            continue
        source, target, kind = edge.get("source"), edge.get("target"), edge.get("kind")
        if not isinstance(source, str) or source not in node_ids or not isinstance(target, str) or target not in node_ids:
            errors.append(f"graph edge {index} has missing endpoint: {source!r} -> {target!r}")
        if not isinstance(kind, str) or kind not in EDGE_KINDS:
            errors.append(f"graph edge {index} has unknown type {kind!r}")
        else:
            edge_counts[kind] += 1
        provenance = edge.get("provenance")
        if not isinstance(provenance, dict) or not isinstance(provenance.get("page"), str):
            errors.append(f"graph edge {index} has no page provenance")
        elif not (site_root / provenance["page"]).is_file():
            errors.append(f"graph edge {index} points to missing provenance page {provenance['page']!r}")

    expected_summary = {
        "nodes": len(nodes),
        "edges": len(edges),
        "references": edge_counts["references"],
        "citations": edge_counts["cites"],
        "containment": edge_counts["contains"],
    }
    for key, expected in expected_summary.items():
        if summary.get(key) != expected:
            errors.append(f"graph summary {key!r} is {summary.get(key)!r}; expected {expected}")

    # Every generated document page must offer a context-aware entry point into the graph.
    document_pages = sorted(
        path for path in site_root.rglob("*.html")
        if "navigation" not in path.relative_to(site_root).parts
    )
    if not document_pages:
        errors.append("no rendered document pages found")
    for path in document_pages:
        relative = path.relative_to(site_root).as_posix()
        try:
            facts = parse_html(path)
        except (OSError, UnicodeDecodeError) as exc:
            errors.append(f"cannot inspect document page {relative}: {exc}")
            continue
        if facts.nav_entry_count != 1:
            errors.append(f"{relative} must contain exactly one interactive navigation entry; found {facts.nav_entry_count}")
            continue
        if len(facts.nav_entry_links) != 1:
            errors.append(f"{relative} must contain exactly one link inside its navigation entry")
            continue
        href = facts.nav_entry_links[0]
        try:
            target_path, _fragment = resolved_local_target(site_root, relative, facts.base_href, href)
        except ValueError as exc:
            errors.append(f"invalid interactive navigation entry in {relative}: {exc}")
            continue
        query = parse_qs(urlsplit(href).query)
        selected = query.get("node", [])
        if target_path != NAVIGATION_PAGE:
            errors.append(f"navigation entry in {relative} targets {target_path!r}, not {NAVIGATION_PAGE!r}")
        if len(selected) != 1 or selected[0] not in node_ids:
            errors.append(f"navigation entry in {relative} does not select a known starting node: {selected!r}")

    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--site", type=Path, required=True, help="rendered Verso HTML root")
    parser.add_argument("--ref", default="local", help="expected source revision")
    args = parser.parse_args()
    errors = check(args.site, args.ref)
    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1
    print(f"interactive navigation validated: {args.site} (ref={args.ref})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
