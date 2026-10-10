# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

from __future__ import annotations

import shutil
import tempfile
import unittest
from pathlib import Path

from check_spec_html_assets import check


SVG = '<svg xmlns="http://www.w3.org/2000/svg"><title>Test</title><desc>A test long description.</desc></svg>'


class CheckSpecHtmlAssetsTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.site = self.root / "html-multi"
        self.source = self.root / "source-figures"
        self.spec = self.root / "spec" / "Spec"
        (self.site / "figures").mkdir(parents=True)
        (self.site / "chapter").mkdir()
        self.source.mkdir()
        self.spec.mkdir(parents=True)
        (self.source / "test.svg").write_text(SVG, encoding="utf-8")
        (self.source / "test.pdf").write_bytes(b"%PDF-1.4\nvalid test fixture")
        shutil.copy2(self.source / "test.svg", self.site / "figures" / "test.svg")
        self.write_spec("test")
        (self.site / "index.html").write_text("<html><body>Index</body></html>", encoding="utf-8")

    def tearDown(self) -> None:
        self.temp.cleanup()

    def write_spec(self, *stems: str) -> None:
        declarations = "\n".join(
            f'::::figure (label := "fig:{stem}") (src := "{stem}") (alt := "A test figure")'
            for stem in stems
        )
        (self.spec / "Example.lean").write_text(declarations + "\n", encoding="utf-8")

    def write_page(
        self,
        src: str,
        alt: str = "A test figure",
        described_by: str | None = "k7-long-description",
    ) -> None:
        relation = f' aria-describedby="{described_by}"' if described_by is not None else ""
        (self.site / "chapter" / "index.html").write_text(
            f'<html><body><img class="k7-img" src="{src}" alt="{alt}"{relation}>'
            '<div id="k7-long-description" class="k7-desc">A detailed description.</div>'
            '</body></html>',
            encoding="utf-8",
        )

    def test_accepts_nested_relative_image_path(self) -> None:
        self.write_page("../figures/test.svg")
        results = check(self.site, self.source, self.spec)
        self.assertEqual(len(results), 1)
        self.assertTrue(results[0].startswith("validated "), results)

    def test_resolves_image_against_verso_base_href(self) -> None:
        (self.site / "chapter" / "index.html").write_text(
            '<html><head><base href="./../"></head><body>'
            '<img class="k7-img" src="figures/test.svg" alt="A test figure" aria-describedby="description">'
            '<div id="description" class="k7-desc">Detailed description.</div></body></html>',
            encoding="utf-8",
        )
        results = check(self.site, self.source, self.spec)
        self.assertEqual(len(results), 1)
        self.assertTrue(results[0].startswith("validated "), results)

    def test_detects_double_prefix_with_verso_base_href(self) -> None:
        (self.site / "chapter" / "index.html").write_text(
            '<html><head><base href="./../"></head><body>'
            '<img class="k7-img" src="../figures/test.svg" alt="A test figure" aria-describedby="description">'
            '<div id="description" class="k7-desc">Detailed description.</div></body></html>',
            encoding="utf-8",
        )
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("escapes the HTML site" in result for result in results), results)

    def test_rejects_missing_image_asset(self) -> None:
        self.write_page("../figures/missing.svg")
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("image asset does not exist" in result for result in results), results)

    def test_rejects_empty_alternative_text(self) -> None:
        self.write_page("../figures/test.svg", "")
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("no alternative text" in result for result in results), results)


    def test_rejects_missing_declared_pdf_asset(self) -> None:
        (self.source / "test.pdf").unlink()
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("no source PDF asset: test.pdf" in result for result in results), results)

    def test_rejects_missing_copied_svg(self) -> None:
        (self.site / "figures" / "test.svg").unlink()
        self.write_page("../figures/test.svg")
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("was not copied" in result for result in results), results)

    def test_rejects_malformed_svg(self) -> None:
        (self.site / "figures" / "test.svg").write_text("<svg>", encoding="utf-8")
        self.write_page("../figures/test.svg")
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("invalid SVG" in result for result in results), results)

    def test_rejects_svg_without_accessible_title_and_description(self) -> None:
        (self.site / "figures" / "test.svg").write_text(
            '<svg xmlns="http://www.w3.org/2000/svg"><rect width="10" height="10"/></svg>',
            encoding="utf-8",
        )
        self.write_page("../figures/test.svg")
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("non-empty title" in result for result in results), results)
        self.assertTrue(any("non-empty desc" in result for result in results), results)

    def test_accepts_provenance_preview_with_its_long_description(self) -> None:
        self.write_page("../figures/test.svg")
        navigation = self.site / "navigation"
        navigation.mkdir()
        (navigation / "figures.html").write_text(
            '<img class="k7-provenance-img" src="../figures/test.svg" '
            'alt="A test figure" aria-describedby="figure-description-test">'
            '<p class="figure-description" id="figure-description-test">Full description.</p>',
            encoding="utf-8",
        )
        results = check(self.site, self.source, self.spec)
        self.assertEqual(len(results), 1)
        self.assertTrue(results[0].startswith("validated "), results)




    def test_rejects_missing_aria_describedby(self) -> None:
        self.write_page("figures/test.svg", described_by=None)
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("aria-describedby" in result for result in results), results)

    def test_rejects_dangling_long_description_reference(self) -> None:
        self.write_page("figures/test.svg", described_by="missing-description")
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("is not a k7-desc element" in result for result in results), results)

    def test_rejects_duplicate_long_description_id(self) -> None:
        self.write_page("figures/test.svg")
        page = self.site / "chapter" / "index.html"
        page.write_text(
            page.read_text(encoding="utf-8")
            + '<div id="k7-long-description" class="k7-desc">Duplicate.</div>',
            encoding="utf-8",
        )
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("duplicate long-description id" in result for result in results), results)

    def test_rejects_declared_figure_missing_from_html(self) -> None:
        (self.source / "second.svg").write_text(SVG, encoding="utf-8")
        (self.source / "second.pdf").write_bytes(b"%PDF-1.4\nvalid test fixture")
        shutil.copy2(self.source / "second.svg", self.site / "figures" / "second.svg")
        self.write_spec("test", "second")
        self.write_page("figures/test.svg")
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("do not match canonical declarations" in result and "second" in result for result in results), results)

    def test_rejects_undeclared_figure_in_html(self) -> None:
        (self.source / "orphan.svg").write_text(SVG, encoding="utf-8")
        shutil.copy2(self.source / "orphan.svg", self.site / "figures" / "orphan.svg")
        self.write_page("../figures/orphan.svg")
        page = self.site / "chapter" / "index.html"
        page.write_text(
            page.read_text(encoding="utf-8")
            + '<img class="k7-img" src="../figures/test.svg" alt="A test figure" aria-describedby="k7-long-description">',
            encoding="utf-8",
        )
        # The file exists and is valid; reject the extra HTML reference because it has no declaration.
        results = check(self.site, self.source, self.spec)
        self.assertTrue(any("do not match canonical declarations" in result and "orphan" in result for result in results), results)

if __name__ == "__main__":
    unittest.main()
