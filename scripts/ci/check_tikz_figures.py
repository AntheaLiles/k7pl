#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Validate generated TikZ figure assets against the canonical source manifest."""
from __future__ import annotations

import argparse
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
SOURCE_DIR = REPO_ROOT / "spec" / "figures" / "tikz"
FIGURE_DIR = REPO_ROOT / "spec" / "figures"


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--generated", type=Path, required=True, help="directory containing generated PDF/SVG pairs")
    parser.add_argument("--check-tracked", action="store_true", help="require generated assets to match spec/figures byte-for-byte")
    args = parser.parse_args()
    generated_root = args.generated.resolve()
    manifest = json.loads((SOURCE_DIR / "manifest.json").read_text(encoding="utf-8"))

    if manifest.get("status") != "canonical-tikz-sources":
        fail("source manifest has an unexpected status")
    figures = manifest.get("figures")
    if not isinstance(figures, list) or len(figures) != 3:
        fail("expected exactly three canonical TikZ figures")

    seen_ids: set[str] = set()
    seen_stems: set[str] = set()
    for figure in figures:
        figure_id = figure.get("id", "")
        source_name = figure.get("source", "")
        stem = figure.get("asset_stem", "")
        if not figure_id or figure_id in seen_ids:
            fail(f"missing or duplicate figure id: {figure_id!r}")
        if not stem or stem in seen_stems or Path(stem).name != stem:
            fail(f"missing, duplicate or unsafe asset stem: {stem!r}")
        seen_ids.add(figure_id)
        seen_stems.add(stem)
        source = (SOURCE_DIR / source_name).resolve()
        if not source.is_relative_to(SOURCE_DIR.resolve()) or not source.is_file():
            fail(f"{figure_id}: source is missing or escapes the canonical source directory")

        pdf = generated_root / f"{stem}.pdf"
        svg = generated_root / f"{stem}.svg"
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

        if args.check_tracked:
            for suffix, generated in (("pdf", pdf), ("svg", svg)):
                tracked = FIGURE_DIR / f"{stem}.{suffix}"
                if not tracked.is_file() or tracked.read_bytes() != generated.read_bytes():
                    fail(f"{figure_id}: generated {suffix.upper()} differs from tracked asset {tracked.relative_to(REPO_ROOT)}")
        print(f"validated {figure_id}: source, PDF and SVG" + ("; tracked outputs match" if args.check_tracked else ""))

    print(f"validated {len(figures)} canonical TikZ figure assets")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
