# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Tests for the derived, navigable figure-provenance page."""
from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path

SCRIPT = Path(__file__).resolve().parents[2] / "scripts" / "ci" / "build_figure_provenance.py"


def fixture_repo(tmp_path: Path) -> Path:
    root = tmp_path / "repo"
    spec = root / "spec"
    (spec / "Spec" / "C1").mkdir(parents=True)
    (spec / "figures" / "tikz").mkdir(parents=True)
    (spec / "figures" / "sources").mkdir(parents=True)
    (spec / "Spec" / "C1" / "Example.lean").write_text(
        '::::figure (label := "fig:one") (src := "asset-one") (alt := "A & B")\n'
        '::::figure (label := "fig:two") (src := "asset-two") (alt := "Second figure")\n',
        encoding="utf-8",
    )
    (spec / "figures" / "tikz" / "one.tex").write_text(r"\documentclass{standalone}", encoding="utf-8")
    (spec / "figures" / "tikz" / "manifest.json").write_text(
        json.dumps({
            "status": "canonical-tikz-sources",
            "figures": [{
                "id": "one",
                "source": "one.tex",
                "asset_stem": "asset-one",
                "canonical_verso": "spec/Spec/C1/Example.lean#fig:one",
            }],
        }),
        encoding="utf-8",
    )
    (spec / "figures" / "sources" / "asset-two.drawio").write_text("<mxfile/>", encoding="utf-8")
    for stem in ("asset-one", "asset-two"):
        (spec / "figures" / f"{stem}.svg").write_text(
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1 1"><title>test</title></svg>',
            encoding="utf-8",
        )
    return root


def test_generates_catalog_from_verso_and_canonical_sources(tmp_path: Path) -> None:
    root = fixture_repo(tmp_path)
    output = tmp_path / "site" / "navigation" / "figures.html"
    result = subprocess.run(
        [sys.executable, str(SCRIPT), "--repo-root", str(root), "--output", str(output), "--ref", "deadbeef"],
        check=False,
        capture_output=True,
        text=True,
    )
    assert result.returncode == 0, result.stderr
    page = output.read_text(encoding="utf-8")
    assert 'id="asset-one"' in page
    assert 'id="asset-two"' in page
    assert 'alt="A &amp; B"' in page
    assert "spec/figures/tikz/one.tex" in page
    assert "spec/figures/sources/asset-two.drawio" in page
    assert "blob/deadbeef/" in page
    assert "../figures/asset-one.svg" in page
    assert "2 figures déclarées recensées" in page


def test_fails_when_a_declared_figure_has_no_canonical_source(tmp_path: Path) -> None:
    root = fixture_repo(tmp_path)
    (root / "spec" / "figures" / "sources" / "asset-two.drawio").unlink()
    output = tmp_path / "site" / "navigation" / "figures.html"
    result = subprocess.run(
        [sys.executable, str(SCRIPT), "--repo-root", str(root), "--output", str(output)],
        check=False,
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0
    assert "no canonical source mapped" in result.stderr
    assert not output.exists()
