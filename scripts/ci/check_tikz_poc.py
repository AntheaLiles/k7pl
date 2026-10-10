#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Validate the static outputs and accessibility metadata of the TikZ POC."""
from __future__ import annotations

import argparse
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
POC_DIR = REPO_ROOT / "docs" / "tracking" / "tikz-poc"


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True, help="directory containing generated PDF/SVG pairs")
    args = parser.parse_args()
    root = args.root.resolve()
    manifest_path = POC_DIR / "manifest.json"
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))

    if manifest.get("status") != "experimental-reconstruction-not-canonical":
        fail("manifest must explicitly identify the sources as experimental reconstructions")
    figures = manifest.get("figures")
    if not isinstance(figures, list) or len(figures) != 3:
        fail("the POC must contain exactly three contrasting figures")

    seen: set[str] = set()
    for figure in figures:
        figure_id = figure.get("id", "")
        if not figure_id or figure_id in seen:
            fail(f"missing or duplicate figure id: {figure_id!r}")
        seen.add(figure_id)
        for field in ("source", "canonical_verso", "caption", "alt", "long_description"):
            if not str(figure.get(field, "")).strip():
                fail(f"{figure_id}: missing required manifest field {field}")
        source = (POC_DIR / figure["source"]).resolve()
        if not source.is_relative_to(POC_DIR.resolve()) or not source.is_file():
            fail(f"{figure_id}: source is missing or escapes the POC directory")
        pdf = root / f"{figure_id}.pdf"
        svg = root / f"{figure_id}.svg"
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
        print(f"validated {figure_id}: source, metadata, PDF and SVG")

    print(f"validated {len(figures)} TikZ POC figures")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
