# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Regression tests for the published interactive relation graph validator."""
from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from check_navigation_graph_output import check


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


if __name__ == "__main__":
    unittest.main()
