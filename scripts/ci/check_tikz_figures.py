#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Validate the TikZ figure manifest against the Verso figure declarations and generated assets.

Every ``::::figure`` declaration of the specification must have exactly one manifest entry
(same source file, same label, ``src`` equal to the entry's asset stem), and every manifest entry
must match exactly one declaration. When ``--generated`` is given, each entry must also have a
plausible PDF/SVG pair in that directory.
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
DECLARATION = re.compile(r'^::::figure\b.*?\(label := "([^"]+)"\).*?\(src := "([^"]+)"\)')


def figure_declarations(repo_root: Path) -> dict[tuple[str, str], str]:
    """Map (Verso source path, figure label) to the declared asset stem."""
    declarations: dict[tuple[str, str], str] = {}
    for path in sorted((repo_root / "spec" / "Spec").rglob("*.lean")):
        relative = path.relative_to(repo_root).as_posix()
        for line in path.read_text(encoding="utf-8").splitlines():
            if not line.startswith("::::figure"):
                continue
            match = DECLARATION.match(line)
            if match is None:
                raise ValueError(f"{relative}: figure declaration without label or src: {line[:80]!r}")
            key = (relative, match.group(1))
            if key in declarations:
                raise ValueError(f"{relative}: duplicate figure label {match.group(1)!r}")
            declarations[key] = match.group(2)
    return declarations


def validate(repo_root: Path, generated_root: Path | None = None) -> list[str]:
    """Return the list of validation errors (empty when the manifest is consistent)."""
    errors: list[str] = []
    source_dir = repo_root / "spec" / "figures" / "tikz"
    manifest = json.loads((source_dir / "manifest.json").read_text(encoding="utf-8"))
    if manifest.get("status") != "canonical-tikz-sources":
        return ["source manifest has an unexpected status"]
    figures = manifest.get("figures")
    if not isinstance(figures, list) or not figures:
        return ["source manifest lists no figure"]

    try:
        declarations = figure_declarations(repo_root)
    except ValueError as exc:
        return [str(exc)]

    seen_ids: set[str] = set()
    seen_stems: set[str] = set()
    covered: set[tuple[str, str]] = set()
    for figure in figures:
        figure_id = figure.get("id", "")
        source_name = figure.get("source", "")
        stem = figure.get("asset_stem", "")
        if not figure_id or figure_id in seen_ids:
            errors.append(f"missing or duplicate figure id: {figure_id!r}")
            continue
        seen_ids.add(figure_id)
        if not stem or stem in {".", ".."} or "/" in stem or "\\" in stem or stem in seen_stems:
            errors.append(f"{figure_id}: missing, duplicate or unsafe asset stem: {stem!r}")
            continue
        seen_stems.add(stem)
        source = (source_dir / source_name).resolve()
        if not source.is_relative_to(source_dir.resolve()) or not source.is_file():
            errors.append(f"{figure_id}: source is missing or escapes the canonical source directory")

        canonical = str(figure.get("canonical_verso", ""))
        if "#" not in canonical:
            errors.append(f"{figure_id}: canonical_verso must identify a source file and figure label")
            continue
        key = tuple(canonical.split("#", 1))
        if key not in declarations:
            errors.append(f"{figure_id}: no figure declaration {key[1]!r} in {key[0]}")
            continue
        if declarations[key] != stem:
            errors.append(f"{figure_id}: declaration {key[1]!r} uses src {declarations[key]!r}, not {stem!r}")
        covered.add(key)

        if generated_root is not None:
            errors.extend(_generated_errors(figure_id, generated_root, stem))

    for path, label in sorted(set(declarations) - covered):
        errors.append(f"figure {label!r} in {path} has no TikZ source in the manifest")
    return errors


def _generated_errors(figure_id: str, generated_root: Path, stem: str) -> list[str]:
    pdf = generated_root / f"{stem}.pdf"
    svg = generated_root / f"{stem}.svg"
    if not pdf.is_file() or pdf.stat().st_size < 100:
        return [f"{figure_id}: missing or implausibly small PDF"]
    if pdf.read_bytes()[:5] != b"%PDF-":
        return [f"{figure_id}: invalid PDF signature"]
    if not svg.is_file() or svg.stat().st_size < 100:
        return [f"{figure_id}: missing or implausibly small SVG"]
    try:
        tree = ET.parse(svg)
    except ET.ParseError as exc:
        return [f"{figure_id}: malformed SVG: {exc}"]
    if tree.getroot().tag.split("}")[-1] != "svg":
        return [f"{figure_id}: root element is not SVG"]
    return []


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--generated", type=Path, help="directory containing generated PDF/SVG pairs")
    args = parser.parse_args()
    generated_root = args.generated.resolve() if args.generated else None
    errors = validate(REPO_ROOT, generated_root)
    for error in errors:
        print(f"ERROR: {error}", file=sys.stderr)
    if errors:
        return 1
    manifest = json.loads((REPO_ROOT / "spec" / "figures" / "tikz" / "manifest.json").read_text(encoding="utf-8"))
    checked = "sources, declarations and generated assets" if generated_root else "sources and declarations"
    print(f"validated {len(manifest['figures'])} canonical TikZ figures ({checked})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
