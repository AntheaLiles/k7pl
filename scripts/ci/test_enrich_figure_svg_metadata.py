# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Tests for accessible names and long descriptions in rendered SVG assets."""
from __future__ import annotations

import tempfile
import unittest
import xml.etree.ElementTree as ET
from pathlib import Path

from enrich_figure_svg_metadata import enrich_site

SVG_NS = "http://www.w3.org/2000/svg"
SVG = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10"><rect width="10" height="10"/></svg>'


class EnrichFigureSvgMetadataTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        (self.root / "figures").mkdir()
        (self.root / "chapter").mkdir()
        (self.root / "figures" / "test.svg").write_text(SVG, encoding="utf-8")
        (self.root / "chapter" / "index.html").write_text(
            '<img class="k7-img" src="figures/test.svg" alt="Figure title" '
            'aria-describedby="figure-description">'
            '<div id="figure-description" class="k7-desc">A <strong>detailed</strong> '
            'description &amp; context.</div>',
            encoding="utf-8",
        )

    def tearDown(self) -> None:
        self.temp.cleanup()

    def test_adds_svg_title_and_long_description(self) -> None:
        count = enrich_site(self.root)
        root = ET.parse(self.root / "figures" / "test.svg").getroot()
        title = root.find(f"{{{SVG_NS}}}title")
        description = root.find(f"{{{SVG_NS}}}desc")
        self.assertEqual(count, 1)
        self.assertIsNotNone(title)
        self.assertEqual(title.text, "Figure title")
        self.assertEqual(root.get("role"), "img")
        self.assertEqual(root.get("aria-labelledby"), title.get("id"))
        self.assertIsNotNone(description)
        self.assertEqual(description.text, "A detailed description & context.")
        self.assertEqual(root.get("aria-describedby"), description.get("id"))

    def test_fails_without_a_valid_long_description_target(self) -> None:
        page = self.root / "chapter" / "index.html"
        page.write_text(
            '<img class="k7-img" src="figures/test.svg" alt="Figure title" '
            'aria-describedby="missing-description">',
            encoding="utf-8",
        )
        with self.assertRaisesRegex(ValueError, "missing or empty long description"):
            enrich_site(self.root)

    def test_fails_without_alternative_text(self) -> None:
        page = self.root / "chapter" / "index.html"
        page.write_text(
            '<img class="k7-img" src="figures/test.svg" alt="" '
            'aria-describedby="figure-description">'
            '<div id="figure-description" class="k7-desc">Description.</div>',
            encoding="utf-8",
        )
        with self.assertRaisesRegex(ValueError, "no src or alternative text"):
            enrich_site(self.root)


if __name__ == "__main__":
    unittest.main()
