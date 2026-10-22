# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Regression tests for the published interactive relation graph validator."""
from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from .build_navigation_graph import add_license_footer, insert_toc_navigation_link, localize_page_references
from .check_navigation_graph_output import check


class InteractiveNavigationOutputTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.site = Path(self.temp.name)
        (self.site / "Spec").mkdir()
        (self.site / "navigation").mkdir()
        for name in ("figures.html", "semantic-graph.html", "semantic-graph-c3.html"):
            (self.site / "navigation" / name).write_text("<!doctype html><html><body></body></html>", encoding="utf-8")

        (self.site / "index.html").write_text(
            '<!doctype html><html lang="fr"><head><base href="./"></head><body>'
            '<h1 id="home">K7PL</h1>'
            '<p id="k7pl-navigation-entry"><a href="navigation/index.html?node=index.html">'
            'Explorer les relations de cette page</a></p></body></html>',
            encoding="utf-8",
        )
        (self.site / "Spec" / "page.html").write_text(
            '<!doctype html><html lang="fr"><head><base href="../"></head><body>'
            '<h1 id="chapter">Chapitre</h1><span id="lbl-section"></span>'
            '<p id="k7pl-navigation-entry"><a href="navigation/index.html?node=Spec%2Fpage.html">'
            'Explorer les relations de cette page</a></p></body></html>',
            encoding="utf-8",
        )
        (self.site / "navigation" / "index.html").write_text(
            '<!doctype html><html lang="fr"><head>'
            '<meta name="k7pl-generated-ref" content="abc123"></head><body>'
            '<nav aria-label="Navigation du site"><a href="../index.html">Retour</a>'
            '<a href="figures.html">Figures</a><a href="semantic-graph.html">C6</a>'
            '<a href="semantic-graph-c3.html">C3</a></nav><noscript>La vue interactive nécessite JavaScript.</noscript>'
            '<label for="search">Recherche</label><input id="search" type="search">'
            '<label for="depth">Profondeur</label><select id="depth"></select><button id="reset-selection" type="button">Revenir au point de départ</button>'
            '<label for="detail-level">Niveau de lecture</label><select id="detail-level"></select>'
            '<section><p id="object-detail">Contexte</p></section>'
            '<label for="explanation-level">Niveau progressif</label><select id="explanation-level"></select><div id="authored-explanation">Explication</div>'
            '<div class="graph-scroll" tabindex="0" aria-label="Graphe relationnel, défilement horizontal possible"></div>'
            '<input type="checkbox" data-edge-kind="contains">'
            '<input type="checkbox" data-edge-kind="references">'
            '<input type="checkbox" data-edge-kind="cites">'
            '<ul id="node-list"></ul><ul id="relations"></ul><p><span id="selected"></span><a id="selected-link" href="../index.html">Ouvrir</a></p><p id="summary">Chargement</p><script>let listLimit = 120; const moreLabel = "Afficher les "; const provenanceLabel = "Source de la relation"; fetch("./graph.json");</script>'
            '</body></html>',
            encoding="utf-8",
        )
        graph = {
            "schema_version": 1,
            "generated_ref": "abc123",
            "generated_from": "rendered Verso HTML",
            "summary": {
                "pages": 2, "nodes": 3, "edges": 1,
                "references": 0, "citations": 0, "containment": 1,
            },
            "nodes": [
                {"id": "index.html", "kind": "document", "label": "K7PL", "description": "", "url": "index.html", "page": "index.html"},
                {"id": "Spec/page.html", "kind": "document", "label": "Chapitre", "description": "", "url": "Spec/page.html", "page": "Spec/page.html"},
                {"id": "Spec/page.html#lbl-section", "kind": "section", "label": "Chapitre", "description": "Chapitre", "url": "Spec/page.html#lbl-section", "page": "Spec/page.html"},
            ],
            "edges": [
                {
                    "source": "index.html",
                    "target": "Spec/page.html#lbl-section",
                    "kind": "contains",
                    "provenance": {"page": "index.html", "source": "document structure"},
                },
            ],
            "unresolved_links": [],
            "explanations": [{
                "id": "fixture-explanation",
                "title": "Pourquoi cette section ?",
                "notice": "Synthèse éditoriale non normative.",
                "target_node_ids": ["Spec/page.html", "Spec/page.html#lbl-section"],
                "levels": {
                    level: {
                        "text": "Texte explicatif de test.",
                        "sources": [{"label": "Source canonique", "url": "Spec/page.html#lbl-section"}],
                    }
                    for level in ("intro", "concept", "detail", "formalization", "verification", "sources")
                },
            }],
        }
        (self.site / "navigation" / "graph.json").write_text(json.dumps(graph), encoding="utf-8")

    def tearDown(self) -> None:
        self.temp.cleanup()

    def test_accepts_complete_graph_and_contextual_document_entries(self) -> None:
        self.assertEqual(check(self.site, "abc123"), [])

    def test_rejects_stale_html_or_graph_data(self) -> None:
        errors = check(self.site, "different-ref")
        self.assertTrue(any("stale interactive page revision" in error for error in errors))
        self.assertTrue(any("stale graph data revision" in error for error in errors))

    def test_rejects_missing_anchor_and_edge_endpoint(self) -> None:
        graph_path = self.site / "navigation" / "graph.json"
        graph = json.loads(graph_path.read_text(encoding="utf-8"))
        graph["nodes"][1]["url"] = "Spec/page.html#missing-anchor"
        graph["edges"][0]["target"] = "not-a-node"
        graph_path.write_text(json.dumps(graph), encoding="utf-8")
        errors = check(self.site, "abc123")
        self.assertTrue(any("targets missing anchor" in error for error in errors))
        self.assertTrue(any("missing endpoint" in error for error in errors))

    def test_rejects_document_without_contextual_entry(self) -> None:
        page = self.site / "Spec" / "page.html"
        page.write_text(page.read_text(encoding="utf-8").replace('id="k7pl-navigation-entry"', 'id="ordinary-footer"'), encoding="utf-8")
        errors = check(self.site, "abc123")
        self.assertTrue(any("interactive navigation entry" in error for error in errors))

    def test_localizes_only_references_cited_on_each_page(self) -> None:
        (self.site / "index.html").write_text(
            '<!doctype html><html><head><base href="./"></head><body>'
            '<p><span class="k7-cite"><a href="Spec/page.html#bib-c1-second">2</a>, '
            '<a href="Spec/page.html#bib-c1-used">1</a></span></p></body></html>',
            encoding="utf-8",
        )
        source_page = self.site / "Spec" / "page.html"
        source_page.write_text(
            '<!doctype html><html><head><base href="../"></head><body>'
            '<p><a href="../Spec/page.html#bib-c1-used">1</a></p>'
            '<div class="k7-bib"><div class="k7-bib-title">Références</div><ol>'
            '<li id="bib-c1-used" value="1">Source utilisée</li>'
            '<li id="bib-c1-second" value="2">Seconde source utilisée</li>'
            '<li id="bib-c1-unused" value="3">Source non citée sur cette page</li>'
            '</ol></div></body></html>',
            encoding="utf-8",
        )

        localize_page_references(self.site)
        localize_page_references(self.site)

        page = (self.site / "index.html").read_text(encoding="utf-8")
        self.assertIn('href="index.html#bib-c1-second"', page)
        self.assertIn('id="bib-c1-second"', page)
        self.assertIn('id="bib-c1-used"', page)
        self.assertNotIn('id="bib-c1-unused"', page)
        self.assertNotIn("Spec/page.html#bib-c1-second", page)
        self.assertEqual(page.count("Références citées sur cette page"), 1)
        self.assertLess(page.index('id="bib-c1-second"'), page.index('id="bib-c1-used"'))
        nested = source_page.read_text(encoding="utf-8")
        self.assertNotIn('class="k7-bib"', nested)
        self.assertIn('href="Spec/page.html#bib-c1-used"', nested)
        self.assertIn('id="bib-c1-used"', nested)

    def test_relation_explorer_follows_experimental_artifacts_in_toc(self) -> None:
        toc = (
            '<html><body><nav><ul>'
            '<li><a href="Spec/CodeArtifacts.html">Artefacts exécutables expérimentaux</a></li>'
            '<li><a href="Spec/Annexe.html">Annexe</a></li>'
            '</ul></nav></body></html>'
        )
        updated = insert_toc_navigation_link(toc, "navigation/index.html")
        self.assertIn(
            '</a></li><li class="k7pl-toc-navigation"><a href="navigation/index.html">'
            'Explorer les relations explicites de K7PL</a></li><li><a href="Spec/Annexe.html">',
            updated,
        )
        self.assertEqual(insert_toc_navigation_link(updated, "navigation/index.html"), updated)

    def test_license_footer_is_present_and_idempotent(self) -> None:
        page = self.site / "index.html"
        add_license_footer(page)
        first = page.read_text(encoding="utf-8")
        add_license_footer(page)
        second = page.read_text(encoding="utf-8")
        self.assertIn('id="k7pl-license-footer"', first)
        self.assertIn("creativecommons.org/licenses/by/4.0/", first)
        self.assertEqual(first, second)


if __name__ == "__main__":
    unittest.main()
