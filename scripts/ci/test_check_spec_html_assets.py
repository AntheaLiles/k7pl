# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

from __future__ import annotations

import shutil
import tempfile
import unittest
from pathlib import Path

from check_spec_html_assets import check


SVG = '<svg xmlns="http://www.w3.org/2000/svg"><title>Test</title></svg>'


class CheckSpecHtmlAssetsTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.site = self.root / "html-multi"
        self.source = self.root / "source-figures"
        (self.site / "figures").mkdir(parents=True)
        (self.site / "chapter").mkdir()
        self.source.mkdir()
        (self.source / "test.svg").write_text(SVG, encoding="utf-8")
        shutil.copy2(self.source / "test.svg", self.site / "figures" / "test.svg")
        (self.site / "index.html").write_text("<html><body>Index</body></html>", encoding="utf-8")

    def tearDown(self) -> None:
        self.temp.cleanup()

    def write_page(self, src: str, alt: str = "A test figure") -> None:
        (self.site / "chapter" / "index.html").write_text(
            f'<html><body><img class="k7-img" src="{src}" alt="{alt}"></body></html>',
            encoding="utf-8",
        )

    def test_accepts_nested_relative_image_path(self) -> None:
        self.write_page("../figures/test.svg")
        results = check(self.site, self.source)
        self.assertEqual(len(results), 1)
        self.assertTrue(results[0].startswith("validated "), results)

    def test_rejects_missing_image_asset(self) -> None:
        self.write_page("../figures/missing.svg")
        results = check(self.site, self.source)
        self.assertTrue(any("image asset does not exist" in result for result in results), results)

    def test_rejects_empty_alternative_text(self) -> None:
        self.write_page("../figures/test.svg", "")
        results = check(self.site, self.source)
        self.assertTrue(any("no alternative text" in result for result in results), results)

    def test_rejects_missing_copied_svg(self) -> None:
        (self.site / "figures" / "test.svg").unlink()
        self.write_page("../figures/test.svg")
        results = check(self.site, self.source)
        self.assertTrue(any("was not copied" in result for result in results), results)

    def test_rejects_malformed_svg(self) -> None:
        (self.site / "figures" / "test.svg").write_text("<svg>", encoding="utf-8")
        self.write_page("../figures/test.svg")
        results = check(self.site, self.source)
        self.assertTrue(any("invalid SVG" in result for result in results), results)


if __name__ == "__main__":
    unittest.main()
