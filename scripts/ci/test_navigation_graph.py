# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Tests for the generated Verso navigation graph."""
from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from build_navigation_graph import build_graph, inject_navigation_link


class NavigationGraphTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.site = Path(self.temp.name)
        (self.site / "Spec" / "C3").mkdir(parents=True)
        (self.site / "Spec" / "C2").mkdir(parents=True)
        (self.site / "Spec").mkdir(exist_ok=True)
        (self.site / "index.html").write_text(
            '<html><head><base href="./"><title>K7PL</title></head><body>'
            '<h1 id="home-heading">Accueil</h1>'
            '<p><a class="k7-ref" href="Spec/C3/page.html#lbl-sec-chapter">Chapitre</a></p>'
            '</body></html>',
            encoding="utf-8",
        )
        (self.site / "Spec" / "C3" / "page.html").write_text(
            '<html><head><base href="./../../"><title>Chapitre C3</title></head><body>'
            '<h1 id="chapter-heading">Contraintes de valeur</h1>'
            '<span class="k7-anchor" id="lbl-sec-chapter"></span>'
            '<div class="k7-float k7-figure" id="lbl-fig-demo">'
            '<img alt="Automate de démonstration" src="figures/demo.svg">'
            '<div class="k7-caption">Automate de démonstration '
            '<a class="k7-ref" href="Spec/C2/ambient.html#lbl-sec-ambient">Catégorie ambiante</a>'
            '</div></div>'
            '<p>Source <span class="k7-cite">[<a href="Spec/references.html#bib-example">1</a>]</span></p>'
            '</body></html>',
            encoding="utf-8",
        )
        (self.site / "Spec" / "C2" / "ambient.html").write_text(
            '<html><head><base href="./../../"><title>Catégorie ambiante</title></head><body>'
            '<h1 id="ambient-heading">Catégorie ambiante</h1>'
            '<span class="k7-anchor" id="lbl-sec-ambient"></span>'
            '</body></html>',
            encoding="utf-8",
        )
        (self.site / "Spec" / "references.html").write_text(
            '<html><head><base href="./../"><title>Références</title></head><body>'
            '<h1 id="references-heading">Références</h1>'
            '<div class="k7-bib"><ol><li id="bib-example">Exemple bibliographique</li></ol></div>'
            '</body></html>',
            encoding="utf-8",
        )

    def tearDown(self) -> None:
        self.temp.cleanup()

    def test_extracts_explicit_reference_and_citation_edges(self) -> None:
        graph = build_graph(self.site)
        nodes = {node["id"]: node for node in graph["nodes"]}
        edges = graph["edges"]
        figure_id = "Spec/C3/page.html#lbl-fig-demo"
        section_id = "Spec/C2/ambient.html#ambient-heading"
        bibliography_id = "Spec/references.html#bib-example"
        self.assertEqual(nodes[figure_id]["kind"], "figure")
        self.assertEqual(nodes[section_id]["kind"], "section")
        self.assertEqual(nodes[bibliography_id]["kind"], "bibliography")
        self.assertTrue(any(edge["source"] == figure_id and edge["target"] == section_id and edge["kind"] == "references" for edge in edges))
        self.assertTrue(any(edge["kind"] == "cites" and edge["target"] == bibliography_id for edge in edges))
        self.assertGreaterEqual(graph["summary"]["containment"], 1)
        self.assertEqual(graph["unresolved_links"], [])

    def test_resolves_nested_links_using_verso_base_href(self) -> None:
        graph = build_graph(self.site)
        figure_id = "Spec/C3/page.html#lbl-fig-demo"
        target_id = "Spec/C2/ambient.html#ambient-heading"
        self.assertTrue(any(edge["source"] == figure_id and edge["target"] == target_id for edge in graph["edges"]))

    def test_fails_when_an_explicit_internal_link_is_unresolved(self) -> None:
        page = self.site / "Spec" / "C3" / "page.html"
        content = page.read_text(encoding="utf-8").replace(
            "</body>",
            '<p><a class="k7-ref" href="Spec/Missing.html#lbl-no">Missing</a></p></body>',
        )
        page.write_text(content, encoding="utf-8")
        with self.assertRaisesRegex(ValueError, "explicit internal navigation links"):
            build_graph(self.site)

    def test_navigation_entry_injection_is_idempotent(self) -> None:
        page = self.site / "Spec" / "C3" / "page.html"
        inject_navigation_link(page, self.site)
        inject_navigation_link(page, self.site)
        content = page.read_text(encoding="utf-8")
        self.assertEqual(content.count('id="k7pl-navigation-entry"'), 1)
        self.assertIn('href="navigation/index.html"', content)


if __name__ == "__main__":
    unittest.main()
