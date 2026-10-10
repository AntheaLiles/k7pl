#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Validate TikZ PDF/SVG outputs and the POC accessibility metadata."""
from __future__ import annotations

import argparse
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
POC_DIR = REPO_ROOT / "docs" / "tracking" / "tikz-poc"
SOURCE_DIR = REPO_ROOT / "spec" / "figures" / "tikz"


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True, help="directory containing generated PDF/SVG pairs")
    args = parser.parse_args()
    root = args.root.resolve()
    poc_manifest = json.loads((POC_DIR / "manifest.json").read_text(encoding="utf-8"))
    source_manifest = json.loads((SOURCE_DIR / "manifest.json").read_text(encoding="utf-8"))

    if poc_manifest.get("status") != "experimental-rendering-evaluation":
        fail("POC manifest must explicitly identify this as a rendering evaluation")
    if source_manifest.get("status") != "canonical-tikz-sources":
        fail("source manifest must identify the repository's canonical TikZ sources")
    poc_figures = poc_manifest.get("figures")
    source_figures = source_manifest.get("figures")
    if not isinstance(poc_figures, list) or len(poc_figures) != 3:
        fail("the POC must contain exactly three contrasting figures")
    if not isinstance(source_figures, list) or len(source_figures) != 3:
        fail("the canonical source manifest must contain exactly three figures")

    sources = {figure.get("id"): figure for figure in source_figures}
    seen: set[str] = set()
    for figure in poc_figures:
        figure_id = figure.get("id", "")
        if not figure_id or figure_id in seen:
            fail(f"missing or duplicate figure id: {figure_id!r}")
        seen.add(figure_id)
        for field in ("canonical_verso", "caption", "alt", "long_description"):
            if not str(figure.get(field, "")).strip():
                fail(f"{figure_id}: missing required POC field {field}")
        source_entry = sources.get(figure_id)
        if source_entry is None:
            fail(f"{figure_id}: no matching canonical source entry")
        source = (SOURCE_DIR / source_entry.get("source", "")).resolve()
        if not source.is_relative_to(SOURCE_DIR.resolve()) or not source.is_file():
            fail(f"{figure_id}: source is missing or escapes the canonical source directory")
        stem = source_entry.get("asset_stem", "")
        if not stem:
            fail(f"{figure_id}: missing output asset stem")
        pdf = root / f"{stem}.pdf"
        svg = root / f"{stem}.svg"
        if not pdf.is_file() or pdf.stat().st_size < 100:
            fail(f"{figure_id}: missing or implausibly small PDF")
        if pdf.read_bytes()[:5] != b"%PDF-":
            fail(f"{figure_id}: invalid PDF signature")
        if not svg.is_file() or svg.stat().st_size < 100:
            fail(f"{figure_id}: missing or implausibly small SVG")
        try:
            tree = ET.parse(svg)
        except ET.ParseError as exc:
            fail(f"{figure_id}: malformed SVG: {exc}")
        if tree.getroot().tag.split("}")[-1] != "svg":
            fail(f"{figure_id}: root element is not SVG")
        print(f"validated {figure_id}: canonical source, POC metadata, PDF and SVG")

    print(f"validated {len(poc_figures)} TikZ POC figures")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
