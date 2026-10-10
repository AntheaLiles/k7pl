# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Tests for the generated navigation artifact contract."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

SCRIPT = Path(__file__).resolve().parents[2] / "scripts" / "ci" / "check_navigation_outputs.py"


def make_fixture(tmp_path: Path) -> tuple[Path, Path]:
    root = tmp_path / "repo"
    site = tmp_path / "site"
    files = {
        "spec/Spec/C1/Example.lean": "line one\nline two\n",
        "spec/figures/sources/asset-one.drawio": "<mxfile/>\n",
        "spec/figures/tikz/manifest.json": '{"figures":[]}\n',
        "tools/SpecExt/Float.lean": "def render := true\n",
        ".github/workflows/verify.yaml": "name: verify\n",
    }
    for relative, content in files.items():
        path = root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
    (site / "Spec" / "C1").mkdir(parents=True)
    (site / "figures").mkdir(parents=True)
    (site / "Spec" / "C1" / "Example.html").write_text(
        '<html><body><div id="lbl-fig-one"></div>'
        '<a href="../../navigation/figures.html#asset-one">Sources et rendus</a></body></html>',
        encoding="utf-8",
    )
    (site / "figures" / "asset-one.svg").write_text(
        '<svg xmlns="http://www.w3.org/2000/svg"><title>one</title></svg>', encoding="utf-8"
    )
    (site / "figures" / "asset-one.pdf").write_bytes(b"%PDF-1.7 fixture")

    catalog = """<!doctype html>
<html lang="fr" data-k7pl-generated-ref="deadbeef"><head><style>
@media (max-width: 560px) { .figure-card { grid-template-columns: 1fr; } }
</style></head><body>
<article class="figure-card" id="asset-one"><h2>Figure one</h2></article>
<a href="../Spec/C1/Example.html#lbl-fig-one">Page documentaire</a>
<a href="../figures/asset-one.svg">SVG</a>
<a href="../figures/asset-one.pdf">PDF</a>
<a href="semantic-graph.html">C6</a><a href="semantic-graph-c3.html">C3</a>
<a href="https://github.com/AntheaLiles/k7pl/blob/deadbeef/spec/Spec/C1/Example.lean#L1">Déclaration</a>
<a href="https://github.com/AntheaLiles/k7pl/blob/deadbeef/spec/figures/sources/asset-one.drawio">Source</a>
</body></html>"""
    graph = """<!doctype html>
<html lang="fr" data-k7pl-generated-ref="deadbeef"><head><style>
.graph { overflow-x: auto; } .graph svg { min-width: 960px; width: 100%; }
</style></head><body>
<a href="figures.html">Catalogue</a><a href="semantic-graph-c3.html">C3</a>
<a href="../Spec/C1/Example.html#lbl-fig-one">Page documentaire</a>
<a href="https://github.com/AntheaLiles/k7pl/blob/deadbeef/spec/Spec/C1/Example.lean#L1">Source</a>
</body></html>"""
    navigation = site / "navigation"
    navigation.mkdir(parents=True)
    (navigation / "figures.html").write_text(catalog, encoding="utf-8")
    (navigation / "semantic-graph.html").write_text(graph, encoding="utf-8")
    (navigation / "semantic-graph-c3.html").write_text(
        graph.replace('href="semantic-graph-c3.html">C3', 'href="semantic-graph.html">C6'),
        encoding="utf-8",
    )
    return root, site


def run_checker(root: Path, site: Path, ref: str = "deadbeef") -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [
            sys.executable, str(SCRIPT), "--repo-root", str(root),
            "--html-root", str(site), "--ref", ref,
        ],
        check=False, capture_output=True, text=True,
    )


def test_valid_static_navigation_artifacts_pass(tmp_path: Path) -> None:
    root, site = make_fixture(tmp_path)
    result = run_checker(root, site)
    assert result.returncode == 0, result.stderr
    assert "3 pages" in result.stdout
    assert "pinned GitHub source links" in result.stdout
    assert "1 reversible figure links" in result.stdout


def test_stale_generated_page_is_rejected(tmp_path: Path) -> None:
    root, site = make_fixture(tmp_path)
    page = site / "navigation" / "semantic-graph.html"
    page.write_text(
        page.read_text(encoding="utf-8").replace("deadbeef", "oldsha"),
        encoding="utf-8",
    )
    result = run_checker(root, site)
    assert result.returncode != 0
    assert "stale generated output" in result.stderr


def test_missing_figure_to_catalog_link_is_rejected(tmp_path: Path) -> None:
    root, site = make_fixture(tmp_path)
    document = site / "Spec" / "C1" / "Example.html"
    document.write_text('<html><body><div id="lbl-fig-one"></div></body></html>', encoding="utf-8")
    result = run_checker(root, site)
    assert result.returncode != 0
    assert "catalog figures lack a rendered-document entry link" in result.stderr


def test_missing_local_anchor_is_rejected(tmp_path: Path) -> None:
    root, site = make_fixture(tmp_path)
    document = site / "Spec" / "C1" / "Example.html"
    document.write_text("<html><body>No target</body></html>", encoding="utf-8")
    result = run_checker(root, site)
    assert result.returncode != 0
    assert "local anchor 'lbl-fig-one' must occur exactly once" in result.stderr


def test_missing_local_asset_is_rejected(tmp_path: Path) -> None:
    root, site = make_fixture(tmp_path)
    page = site / "navigation" / "figures.html"
    page.write_text(
        page.read_text(encoding="utf-8").replace("../figures/asset-one.svg", "../figures/missing.svg"),
        encoding="utf-8",
    )
    result = run_checker(root, site)
    assert result.returncode != 0
    assert "broken local link" in result.stderr
