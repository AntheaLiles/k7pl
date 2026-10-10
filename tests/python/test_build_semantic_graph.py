# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Tests for the provenance-preserving semantic graph prototype."""
from __future__ import annotations

import json
import subprocess
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

SCRIPT = Path(__file__).resolve().parents[2] / "scripts" / "ci" / "build_semantic_graph.py"


def fixture_repo(tmp_path: Path) -> Path:
    root = tmp_path / "repo"
    spec = root / "spec"
    source_dir = spec / "Spec" / "C6"
    target_dir = spec / "Spec" / "C3"
    tikz_dir = spec / "figures" / "tikz"
    bib_dir = root / "docs" / "bibliography"
    for directory in (source_dir, target_dir, tikz_dir, spec / "figures"):
        directory.mkdir(parents=True, exist_ok=True)
    bib_dir.mkdir(parents=True)

    (source_dir / "Example.lean").write_text(
        '#doc (Manual) "Example section" =>\n'
        '{label "sec:example"}\n'
        'This text references {num "fig:one"}[] and {num "sec:target"}[] and cites {cite "KEY"}[].\n'
        '::::figure (label := "fig:one") (src := "asset-one") (alt := "An example figure") (width := "90")\n',
        encoding="utf-8",
    )
    (target_dir / "Target.lean").write_text(
        '#doc (Manual) "Target section" =>\n'
        '{label "sec:target"}\n',
        encoding="utf-8",
    )
    (tikz_dir / "one.tex").write_text(r"\documentclass{standalone}", encoding="utf-8")
    (tikz_dir / "manifest.json").write_text(
        json.dumps({
            "status": "canonical-tikz-sources",
            "figures": [{
                "id": "one",
                "source": "one.tex",
                "asset_stem": "asset-one",
                "canonical_verso": "spec/Spec/C6/Example.lean#fig:one",
            }],
        }),
        encoding="utf-8",
    )
    (bib_dir / "references.json").write_text(
        json.dumps({"entries": {"KEY": {"title": "A source"}}}),
        encoding="utf-8",
    )
    (spec / "figures" / "asset-one.svg").write_text(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1 1"><title>figure</title></svg>',
        encoding="utf-8",
    )
    (spec / "figures" / "asset-one.pdf").write_bytes(b"%PDF-1.7 test fixture")
    return root


def test_generates_graph_from_explicit_references_and_citations(tmp_path: Path) -> None:
    root = fixture_repo(tmp_path)
    output = tmp_path / "site" / "navigation" / "semantic-graph.html"
    result = subprocess.run(
        [
            sys.executable, str(SCRIPT), "--repo-root", str(root),
            "--output", str(output), "--ref", "deadbeef",
            "--source", "spec/Spec/C6/Example.lean", "--label", "sec:example",
            "--start-line", "1", "--end-line", "5",
        ],
        check=False,
        capture_output=True,
        text=True,
    )
    assert result.returncode == 0, result.stderr
    page = output.read_text(encoding="utf-8")
    assert "Target section" in page
    assert "A source" in page
    assert "fig:one" in page
    assert "références Verso" in page
    assert "generated-from" not in page
    assert "blob/deadbeef/" in page
    svg_start = page.index("<svg ")
    svg_end = page.index("</svg>", svg_start) + len("</svg>")
    svg = ET.fromstring(page[svg_start:svg_end])
    assert svg.tag.endswith("svg")
    assert (root / "spec" / "figures" / "asset-one.svg").is_file()


def test_fails_on_unresolved_explicit_reference(tmp_path: Path) -> None:
    root = fixture_repo(tmp_path)
    source = root / "spec" / "Spec" / "C6" / "Example.lean"
    source.write_text(
        '#doc (Manual) "Example section" =>\n'
        '{label "sec:example"}\n'
        'This text references {num "sec:missing"}[].\n',
        encoding="utf-8",
    )
    output = tmp_path / "site" / "navigation" / "semantic-graph.html"
    result = subprocess.run(
        [
            sys.executable, str(SCRIPT), "--repo-root", str(root),
            "--output", str(output), "--ref", "deadbeef",
            "--source", "spec/Spec/C6/Example.lean", "--label", "sec:example",
            "--start-line", "1", "--end-line", "5",
        ],
        check=False,
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0
    assert "unresolved num reference" in result.stderr
    assert not output.exists()
