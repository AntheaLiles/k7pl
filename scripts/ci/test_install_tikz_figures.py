# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Tests for installing generated TikZ assets under canonical filenames."""
from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from install_tikz_figures import install_assets


class InstallTikzFiguresTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        root = Path(self.temp.name)
        self.source = root / "generated"
        self.target = root / "figures"
        self.source.mkdir()
        for figure_id in ("pipeline", "protocol", "matrix"):
            for extension in ("pdf", "svg"):
                (self.source / f"{figure_id}.{extension}").write_bytes(b"x" * 120)
        self.manifest = {
            "status": "experimental-reconstruction-not-canonical",
            "figures": [
                {"id": "pipeline", "production_asset": "canonical-pipeline"},
                {"id": "protocol", "production_asset": "canonical-protocol"},
                {"id": "matrix", "production_asset": "canonical-matrix"},
            ],
        }

    def tearDown(self) -> None:
        self.temp.cleanup()

    def test_installs_both_formats_using_explicit_mapping(self) -> None:
        installed = install_assets(self.manifest, self.source, self.target)
        self.assertEqual(len(installed), 6)
        self.assertTrue((self.target / "canonical-pipeline.svg").is_file())
        self.assertTrue((self.target / "canonical-pipeline.pdf").is_file())
        self.assertFalse((self.target / "pipeline.svg").exists())

    def test_rejects_missing_generated_output(self) -> None:
        (self.source / "protocol.pdf").unlink()
        with self.assertRaisesRegex(ValueError, "missing or unsafe generated pdf"):
            install_assets(self.manifest, self.source, self.target)

    def test_rejects_path_traversal_in_asset_mapping(self) -> None:
        self.manifest["figures"][0]["production_asset"] = "../outside"
        with self.assertRaisesRegex(ValueError, "plain filename stem"):
            install_assets(self.manifest, self.source, self.target)

    def test_rejects_duplicate_ids(self) -> None:
        self.manifest["figures"][1]["id"] = "pipeline"
        with self.assertRaisesRegex(ValueError, "duplicate figure id"):
            install_assets(self.manifest, self.source, self.target)

    def test_rejects_duplicate_production_assets(self) -> None:
        self.manifest["figures"][1]["production_asset"] = "canonical-pipeline"
        with self.assertRaisesRegex(ValueError, "duplicate production_asset"):
            install_assets(self.manifest, self.source, self.target)


if __name__ == "__main__":
    unittest.main()
