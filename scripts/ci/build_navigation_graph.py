#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Build a static, source-derived navigation graph from rendered Verso HTML."""
from __future__ import annotations

import argparse
import hashlib
import html
import json
import posixpath
import sys
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urljoin, urlsplit


VOID_TAGS = {
    "area", "base", "br", "col", "embed", "hr", "img", "input", "link",
    "meta", "param", "source", "track", "wbr",
}
HEADING_TAGS = {"h1", "h2", "h3", "h4", "h5", "h6"}
SEMANTIC_CLASSES = {
    "k7-figure": "figure",
    "k7-table": "table",
    "k7-listing": "listing",
    "k7-theorem": "statement",
}


class Element:
    def __init__(self, tag: str, attrs: dict[str, str | None], parent: Element | None):
        self.tag = tag
        self.attrs = attrs
        self.parent = parent
        self.children: list[Element | str] = []

    def text(self) -> str:
        if self.tag in {"script", "style", "noscript"}:
            return ""
        value = "".join(child.text() if isinstance(child, Element) else child for child in self.children)
        return " ".join(value.split())


class DOMBuilder(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.root = Element("document", {}, None)
        self.stack = [self.root]

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        element = Element(tag, dict(attrs), self.stack[-1])
        self.stack[-1].children.append(element)
        if tag not in VOID_TAGS:
            self.stack.append(element)

    def handle_startendtag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        element = Element(tag, dict(attrs), self.stack[-1])
        self.stack[-1].children.append(element)

    def handle_endtag(self, tag: str) -> None:
        for index in range(len(self.stack) - 1, 0, -1):
            if self.stack[index].tag == tag:
                del self.stack[index:]
                break

    def handle_data(self, data: str) -> None:
        self.stack[-1].children.append(data)


def descendants(root: Element):
    for child in root.children:
        if isinstance(child, Element):
            yield child
            yield from descendants(child)


def classes(element: Element) -> set[str]:
    return set((element.attrs.get("class") or "").split())


def has_class_ancestor(element: Element, class_name: str) -> Element | None:
    current = element.parent
    while current is not None:
        if class_name in classes(current):
            return current
        current = current.parent
    return None


def nearest_semantic_ancestor(element: Element, semantic_elements: dict[int, str]) -> str | None:
    current = element.parent
    while current is not None:
        found = semantic_elements.get(id(current))
        if found is not None:
            return found
        current = current.parent
    return None


def first_descendant_text(element: Element, class_name: str) -> str:
    for child in descendants(element):
        if class_name in classes(child):
            text = child.text()
            if text:
                return text
    return ""


def semantic_kind(element: Element) -> str | None:
    found = classes(element)
    for class_name, kind in SEMANTIC_CLASSES.items():
        if class_name in found:
            return kind
    if element.tag == "li" and element.attrs.get("id") and has_class_ancestor(element, "k7-bib"):
        return "bibliography"
    return None


def make_node(node_id: str, kind: str, label: str, url: str, page: str) -> dict[str, str]:
    return {
        "id": node_id,
        "kind": kind,
        "label": label or node_id,
        "url": url,
        "page": page,
    }


def normalize_target(page: str, base_href: str, href: str) -> str | None:
    parts = urlsplit(href.strip())
    if parts.scheme or parts.netloc or href.strip().startswith(("mailto:", "data:", "javascript:")):
        return None
    base = urljoin(page, base_href or ".")
    resolved = urlsplit(urljoin(base, href.strip()))
    target_path = posixpath.normpath(unquote(resolved.path)).lstrip("/")
    if target_path in {"", "."}:
        target_path = page
    if target_path == ".." or target_path.startswith("../"):
        return None
    fragment = unquote(resolved.fragment)
    return f"{target_path}#{fragment}" if fragment else target_path


def parse_page(path: Path, site_root: Path) -> dict:
    page = path.relative_to(site_root).as_posix()
    parser = DOMBuilder()
    parser.feed(path.read_text(encoding="utf-8"))
    elements = list(descendants(parser.root))
    base_href = next(
        (element.attrs.get("href") or "." for element in elements if element.tag == "base"),
        ".",
    )
    title = next((element.text() for element in elements if element.tag == "h1" and element.text()), "")
    if not title:
        title = next((element.text() for element in elements if element.tag == "title" and element.text()), Path(page).stem)

    return {
        "path": page,
        "root": parser.root,
        "elements": elements,
        "base_href": base_href,
        "title": title,
        "element_by_id": {
            element.attrs["id"]: element
            for element in elements
            if element.attrs.get("id")
        },
    }


def build_graph(site_root: Path) -> dict:
    site_root = site_root.resolve()
    if not site_root.is_dir():
        raise ValueError(f"site output directory does not exist: {site_root}")

    page_paths = sorted(
        path for path in site_root.rglob("*.html")
        if path.relative_to(site_root).as_posix() != "navigation/index.html"
        and "navigation" not in path.relative_to(site_root).parts
    )
    if not page_paths:
        raise ValueError(f"no rendered HTML pages found under {site_root}")

    pages = {record["path"]: record for record in (parse_page(path, site_root) for path in page_paths)}
    nodes: dict[str, dict[str, str]] = {}
    anchor_to_node: dict[str, str] = {}
    element_to_node: dict[tuple[str, int], str] = {}
    element_heading: dict[tuple[str, int], str] = {}
    semantic_elements: dict[tuple[str, int], dict[int, str]] = {}
    containment: list[dict] = []
    link_candidates: list[dict] = []
    target_keys: set[str] = set()

    for page, record in pages.items():
        elements = record["elements"]
        page_node_id = page
        nodes[page_node_id] = make_node(page_node_id, "document", record["title"], page, page)

        semantic_map: dict[int, str] = {}
        semantic_elements[(page, 0)] = semantic_map
        current_heading: str | None = None
        heading_stack: list[tuple[int, str]] = []
        heading_number = 0

        for element in elements:
            key = (page, id(element))
            if element.tag in HEADING_TAGS:
                level = int(element.tag[1])
                while heading_stack and heading_stack[-1][0] >= level:
                    heading_stack.pop()
                heading_number += 1
                element_id = element.attrs.get("id")
                node_id = f"{page}#{element_id}" if element_id else f"{page}#heading-{heading_number}"
                label = element.text() or f"Section {heading_number}"
                url = f"{page}#{element_id}" if element_id else page
                nodes[node_id] = make_node(node_id, "section", label, url, page)
                if element_id:
                    anchor_to_node[f"{page}#{element_id}"] = node_id
                if heading_stack:
                    containment.append({
                        "source": heading_stack[-1][1],
                        "target": node_id,
                        "kind": "contains",
                        "provenance": {"page": page, "source": "heading hierarchy"},
                    })
                heading_stack.append((level, node_id))
                current_heading = node_id

            element_heading[key] = current_heading or page_node_id

            kind = semantic_kind(element)
            element_id = element.attrs.get("id")
            if kind and element_id:
                node_id = f"{page}#{element_id}"
                label = ""
                if kind == "figure":
                    label = first_descendant_text(element, "k7-caption")
                    if not label:
                        image = next((child for child in descendants(element) if child.tag == "img"), None)
                        label = (image.attrs.get("alt") or "") if image else ""
                elif kind in {"table", "listing"}:
                    label = first_descendant_text(element, "k7-caption")
                elif kind == "statement":
                    label = first_descendant_text(element, "k7-thm-head") or first_descendant_text(element, "k7-stm-head")
                elif kind == "bibliography":
                    label = element.text()
                nodes[node_id] = make_node(node_id, kind, label, f"{page}#{element_id}", page)
                semantic_map[id(element)] = node_id
                element_to_node[key] = node_id
                anchor_to_node[f"{page}#{element_id}"] = node_id
                if current_heading and current_heading != node_id:
                    containment.append({
                        "source": current_heading,
                        "target": node_id,
                        "kind": "contains",
                        "provenance": {"page": page, "source": "document structure"},
                    })

            if element.tag == "span" and "k7-anchor" in classes(element) and element_id:
                semantic_parent = nearest_semantic_ancestor(element, semantic_map)
                section_node = semantic_parent or current_heading
                if section_node:
                    anchor_to_node[f"{page}#{element_id}"] = section_node
                    if section_node in nodes and nodes[section_node]["kind"] == "section":
                        nodes[section_node]["url"] = f"{page}#{element_id}"
                else:
                    node_id = f"{page}#{element_id}"
                    nodes.setdefault(node_id, make_node(node_id, "anchor", element_id, f"{page}#{element_id}", page))
                    anchor_to_node[f"{page}#{element_id}"] = node_id

            if element_id and element_id.startswith(("lbl-", "bib-")):
                target = f"{page}#{element_id}"
                if target not in anchor_to_node:
                    semantic_parent = nearest_semantic_ancestor(element, semantic_map)
                    node_id = semantic_parent or current_heading or f"{page}#{element_id}"
                    if node_id not in nodes:
                        nodes[node_id] = make_node(node_id, "anchor", element_id, target, page)
                    anchor_to_node[target] = node_id

        for element in elements:
            classes_here = classes(element)
            in_citation = has_class_ancestor(element, "k7-cite") is not None
            if element.tag != "a" or not element.attrs.get("href"):
                continue
            if "k7-ref" not in classes_here and not in_citation:
                continue
            href = element.attrs["href"] or ""
            target = normalize_target(page, record["base_href"], href)
            if target is None:
                continue
            target_keys.add(target)
            semantic_source = nearest_semantic_ancestor(element, semantic_map)
            source = semantic_source or element_heading.get((page, id(element))) or page_node_id
            link_candidates.append({
                "source": source,
                "target_key": target,
                "kind": "cites" if in_citation else "references",
                "provenance": {
                    "page": page,
                    "source_node": source,
                    "link_text": element.text(),
                    "href": href,
                },
            })

    # Resolve targets that are explicit anchors but do not belong to a known
    # figure, statement, section, or bibliography entry.
    for target in sorted(target_keys):
        if target in anchor_to_node or target in nodes:
            continue
        if "#" not in target:
            if target in pages:
                anchor_to_node[target] = target
            continue
        target_page, fragment = target.split("#", 1)
        record = pages.get(target_page)
        element = record["element_by_id"].get(fragment) if record else None
        if element is None or record is None:
            continue
        page_node_id = target_page
        node_id = target
        label = element.text() or fragment
        nodes[node_id] = make_node(node_id, "anchor", label, target, target_page)
        anchor_to_node[target] = node_id

    edges = list(containment)
    unresolved: list[dict] = []
    for candidate in link_candidates:
        target_id = anchor_to_node.get(candidate["target_key"])
        if target_id is None:
            unresolved.append({
                "page": candidate["provenance"]["page"],
                "href": candidate["provenance"]["href"],
                "target": candidate["target_key"],
                "link_text": candidate["provenance"]["link_text"],
            })
            continue
        source_id = candidate["source"]
        if source_id not in nodes:
            unresolved.append({
                "page": candidate["provenance"]["page"],
                "href": candidate["provenance"]["href"],
                "target": candidate["target_key"],
                "reason": f"missing source node {source_id}",
            })
            continue
        if target_id not in nodes:
            unresolved.append({
                "page": candidate["provenance"]["page"],
                "href": candidate["provenance"]["href"],
                "target": candidate["target_key"],
                "reason": f"missing target node {target_id}",
            })
            continue
        edge_key = json.dumps([source_id, target_id, candidate["kind"], candidate["provenance"]["page"], candidate["provenance"]["link_text"]], ensure_ascii=False)
        edge_id = hashlib.sha256(edge_key.encode("utf-8")).hexdigest()[:16]
        edges.append({
            "id": edge_id,
            "source": source_id,
            "target": target_id,
            "kind": candidate["kind"],
            "provenance": candidate["provenance"],
        })

    if unresolved:
        examples = "\n".join(
            f"  - {item.get('page')}: {item.get('href')} -> {item.get('target', item.get('reason', 'unresolved'))}"
            for item in unresolved[:12]
        )
        raise ValueError(f"{len(unresolved)} explicit internal navigation links could not be resolved:\n{examples}")

    return {
        "schema_version": 1,
        "generated_from": "rendered Verso HTML; only explicit cross-references and citation links are used",
        "summary": {
            "pages": len(pages),
            "nodes": len(nodes),
            "edges": len(edges),
            "references": sum(edge["kind"] == "references" for edge in edges),
            "citations": sum(edge["kind"] == "cites" for edge in edges),
            "containment": sum(edge["kind"] == "contains" for edge in edges),
        },
        "nodes": sorted(nodes.values(), key=lambda node: (node["kind"], node["label"].casefold(), node["id"])),
        "edges": edges,
        "unresolved_links": unresolved,
    }


HTML_TEMPLATE = r"""<!doctype html>
<html lang="fr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Explorer les relations — K7PL</title>
<style>
:root { color-scheme: light dark; font-family: system-ui, sans-serif; }
body { max-width: 1200px; margin: 0 auto; padding: 1.2rem; line-height: 1.45; }
a { text-underline-offset: .15em; }
.controls { display: grid; grid-template-columns: minmax(16rem, 1fr) 2fr; gap: 1rem; align-items: start; }
.panel { border: 1px solid #8c959f; border-radius: .4rem; padding: .8rem; min-width: 0; }
input[type="search"] { box-sizing: border-box; width: 100%; padding: .6rem; font: inherit; }
#node-list { max-height: 28rem; overflow: auto; padding-left: 1.2rem; }
#node-list li { margin: .35rem 0; }
#node-list button { font: inherit; text-align: left; }
#graph { display: block; width: 100%; height: auto; min-height: 20rem; border: 1px solid #8c959f; border-radius: .3rem; }
.node-card { fill: Canvas; stroke: #57606a; stroke-width: 1.5; }
.node-root .node-card { stroke: #0969da; stroke-width: 3; }
.node-label { fill: CanvasText; font-size: 13px; }
.node-kind { fill: CanvasText; opacity: .72; font-size: 10px; }
.edge-line { stroke: #8c959f; stroke-width: 1.5; fill: none; }
.edge-label { fill: CanvasText; font-size: 11px; }
#relations { padding-left: 1.2rem; }
.muted { opacity: .78; }
.status { min-height: 1.5rem; }
@media (max-width: 760px) { .controls { grid-template-columns: 1fr; } }
</style>
</head>
<body>
<p><a href="../index.html">Retour à la spécification</a></p>
<h1>Explorer les relations explicites de K7PL</h1>
<p>Cette vue est dérivée des liens et citations présents dans le HTML Verso. Elle n'infère ni dépendance de code, ni preuve, ni statut épistémique absent de la source.</p>
<p id="summary" class="muted" role="status">Chargement du graphe…</p>
<div class="controls">
<section class="panel" aria-labelledby="nodes-title">
<h2 id="nodes-title">Objets navigables</h2>
<label for="search">Rechercher un objet</label>
<input id="search" type="search" autocomplete="off" placeholder="Titre, identifiant ou type">
<ul id="node-list"></ul>
</section>
<section class="panel" aria-labelledby="graph-title">
<h2 id="graph-title">Voisinage explicite</h2>
<p id="selected" class="muted"></p>
<svg id="graph" viewBox="0 0 1000 640" role="img" aria-label="Graphe des relations explicites autour de l'objet sélectionné">
<title>Relations explicites de l'objet sélectionné</title>
<desc>Les liens sont extraits des références internes, citations et structures de sections de la spécification Verso.</desc>
<defs><marker id="arrow" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6 Z" fill="#8c959f"></path></marker></defs>
<g id="edges"></g><g id="nodes"></g>
</svg>
<h3>Relations autour de l'objet</h3>
<ul id="relations"></ul>
</section>
</div>
<script>
"use strict";
const svgNS = "http://www.w3.org/2000/svg";
let graphData = null;
let selectedId = null;
const byId = new Map();
const nodeList = document.getElementById("node-list");
const search = document.getElementById("search");
function addSvg(tag, attrs, parent) {
  const element = document.createElementNS(svgNS, tag);
  Object.keys(attrs || {}).forEach(function (key) { element.setAttribute(key, attrs[key]); });
  parent.appendChild(element);
  return element;
}
function openHref(node) { return "../" + node.url; }
function nodeLabel(node) { return node.label || node.id; }
function selectNode(id) {
  if (!byId.has(id)) return;
  selectedId = id;
  renderGraph();
  renderRelations();
  const node = byId.get(id);
  document.getElementById("selected").textContent = node.kind + " — " + nodeLabel(node);
}
function renderList() {
  const query = search.value.trim().toLocaleLowerCase();
  nodeList.replaceChildren();
  const matches = graphData.nodes.filter(function (node) {
    if (node.kind === "document" && !query) return false;
    return (nodeLabel(node) + " " + node.kind + " " + node.id).toLocaleLowerCase().includes(query);
  }).slice(0, 120);
  matches.forEach(function (node) {
    const li = document.createElement("li");
    const button = document.createElement("button");
    button.type = "button";
    button.textContent = node.kind + " — " + nodeLabel(node);
    button.addEventListener("click", function () { selectNode(node.id); });
    const link = document.createElement("a");
    link.href = openHref(node);
    link.textContent = " Ouvrir";
    li.append(button, link);
    nodeList.appendChild(li);
  });
  if (!matches.length) {
    const li = document.createElement("li");
    li.textContent = "Aucun objet correspondant.";
    nodeList.appendChild(li);
  }
}
function neighborhood(rootId) {
  const distance = new Map([[rootId, 0]]);
  const queue = [rootId];
  const maxDepth = 2;
  const maxNodes = 24;
  while (queue.length) {
    const current = queue.shift();
    const depth = distance.get(current);
    if (depth >= maxDepth) continue;
    graphData.edges.forEach(function (edge) {
      let other = null;
      if (edge.source === current) other = edge.target;
      else if (edge.target === current) other = edge.source;
      if (other && !distance.has(other) && distance.size < maxNodes) {
        distance.set(other, depth + 1);
        queue.push(other);
      }
    });
  }
  return {
    distance: distance,
    nodes: Array.from(distance.keys()).map(function (id) { return byId.get(id); }).filter(Boolean),
    edges: graphData.edges.filter(function (edge) { return distance.has(edge.source) && distance.has(edge.target); }),
    clipped: distance.size >= maxNodes
  };
}
function renderGraph() {
  const edgeLayer = document.getElementById("edges");
  const nodeLayer = document.getElementById("nodes");
  edgeLayer.replaceChildren();
  nodeLayer.replaceChildren();
  const view = neighborhood(selectedId);
  const positions = new Map();
  const root = byId.get(selectedId);
  positions.set(selectedId, {x: 500, y: 320});
  [1, 2].forEach(function (depth) {
    const layer = view.nodes.filter(function (node) { return view.distance.get(node.id) === depth; });
    layer.forEach(function (node, index) {
      const angle = (2 * Math.PI * index / Math.max(1, layer.length)) - Math.PI / 2;
      const radius = depth === 1 ? 165 : 275;
      positions.set(node.id, {x: 500 + radius * Math.cos(angle), y: 320 + radius * Math.sin(angle)});
    });
  });
  view.edges.forEach(function (edge) {
    const a = positions.get(edge.source);
    const b = positions.get(edge.target);
    if (!a || !b || edge.source === edge.target) return;
    addSvg("line", {x1: a.x, y1: a.y, x2: b.x, y2: b.y, class: "edge-line", "marker-end": "url(#arrow)"}, edgeLayer);
    const label = addSvg("text", {x: (a.x + b.x) / 2, y: (a.y + b.y) / 2 - 5, class: "edge-label", "text-anchor": "middle"}, edgeLayer);
    label.textContent = edge.kind;
  });
  view.nodes.forEach(function (node) {
    const p = positions.get(node.id);
    if (!p) return;
    const group = addSvg("g", {
      class: "node " + (node.id === selectedId ? "node-root" : ""),
      tabindex: "0",
      role: "button",
      "aria-label": node.kind + " — " + nodeLabel(node),
      transform: "translate(" + (p.x - 88) + " " + (p.y - 28) + ")"
    }, nodeLayer);
    addSvg("rect", {width: 176, height: 56, rx: 7, class: "node-card"}, group);
    const kindText = addSvg("text", {x: 9, y: 15, class: "node-kind"}, group);
    kindText.textContent = node.kind;
    const labelText = addSvg("text", {x: 9, y: 35, class: "node-label"}, group);
    const label = nodeLabel(node);
    labelText.textContent = label.length > 24 ? label.slice(0, 23) + "…" : label;
    const title = addSvg("title", {}, group);
    title.textContent = node.kind + " — " + label;
    group.addEventListener("click", function () { selectNode(node.id); });
    group.addEventListener("keydown", function (event) {
      if (event.key === "Enter" || event.key === " ") { event.preventDefault(); selectNode(node.id); }
    });
  });
  const note = view.clipped ? " Voisinage limité à 24 objets ; la liste conserve tous les objets." : "";
  document.getElementById("summary").textContent =
    graphData.summary.nodes + " objets · " + graphData.summary.edges + " relations explicites · " +
    graphData.summary.references + " références · " + graphData.summary.citations + " citations." + note;
}
function renderRelations() {
  const list = document.getElementById("relations");
  list.replaceChildren();
  const edges = graphData.edges.filter(function (edge) { return edge.source === selectedId || edge.target === selectedId; });
  if (!edges.length) {
    const li = document.createElement("li");
    li.textContent = "Aucune relation explicite trouvée pour cet objet.";
    list.appendChild(li);
    return;
  }
  edges.forEach(function (edge) {
    const li = document.createElement("li");
    const source = byId.get(edge.source);
    const target = byId.get(edge.target);
    const first = document.createElement("a");
    first.href = openHref(source);
    first.textContent = nodeLabel(source);
    const second = document.createElement("a");
    second.href = openHref(target);
    second.textContent = nodeLabel(target);
    li.append(first, document.createTextNode(" — " + edge.kind + " → "), second);
    if (edge.provenance && edge.provenance.link_text) {
      li.append(document.createTextNode(" (lien : « " + edge.provenance.link_text + " »)"));
    }
    list.appendChild(li);
  });
}
search.addEventListener("input", renderList);
fetch("./graph.json").then(function (response) {
  if (!response.ok) throw new Error("Impossible de charger graph.json");
  return response.json();
}).then(function (data) {
  graphData = data;
  graphData.nodes.forEach(function (node) { byId.set(node.id, node); });
  const preferred = graphData.nodes.find(function (node) {
    return node.kind === "figure" && node.id.includes("LesContraintesDeValeur.html#lbl-fig-session-automate");
  });
  const fallback = graphData.nodes.find(function (node) { return node.kind === "figure"; }) || graphData.nodes[0];
  selectedId = (preferred || fallback).id;
  renderList();
  selectNode(selectedId);
}).catch(function (error) {
  document.getElementById("summary").textContent = "Erreur de chargement du graphe : " + error.message;
});
</script>
</body>
</html>
"""


def inject_navigation_link(page_path: Path, site_root: Path) -> None:
    content = page_path.read_text(encoding="utf-8")
    if 'id="k7pl-navigation-entry"' in content:
        return
    parser = DOMBuilder()
    parser.feed(content)
    base_href = next(
        (element.attrs.get("href") or "." for element in descendants(parser.root) if element.tag == "base"),
        None,
    )
    if base_href:
        href = "navigation/index.html"
    else:
        rel = page_path.relative_to(site_root).as_posix()
        href = posixpath.relpath("navigation/index.html", posixpath.dirname(rel) or ".")
    entry = (
        '<p id="k7pl-navigation-entry" style="margin-top:2rem;padding-top:.8rem;'
        'border-top:1px solid #8c959f"><a href="' + html.escape(href, quote=True) +
        '">Explorer les relations explicites de K7PL</a></p>'
    )
    marker = "</body>"
    if marker not in content.lower():
        raise ValueError(f"HTML page has no closing body tag: {page_path}")
    index = content.lower().rfind(marker)
    content = content[:index] + entry + content[index:]
    page_path.write_text(content, encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--site", type=Path, required=True, help="rendered Verso HTML root, e.g. _out/spec/html-multi")
    args = parser.parse_args()
    site_root = args.site.resolve()
    try:
        graph = build_graph(site_root)
        navigation_dir = site_root / "navigation"
        navigation_dir.mkdir(parents=True, exist_ok=True)
        (navigation_dir / "graph.json").write_text(
            json.dumps(graph, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        (navigation_dir / "index.html").write_text(HTML_TEMPLATE, encoding="utf-8")
        for page in sorted(
            path for path in site_root.rglob("*.html")
            if "navigation" not in path.relative_to(site_root).parts
        ):
            inject_navigation_link(page, site_root)
    except (OSError, ValueError, json.JSONDecodeError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1

    summary = graph["summary"]
    print(
        f"generated navigation graph: {summary['pages']} pages, {summary['nodes']} nodes, "
        f"{summary['edges']} edges ({summary['references']} references, {summary['citations']} citations)"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
