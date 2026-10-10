#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Install deterministic TikZ PDF/SVG outputs under their canonical figure filenames."""
from __future__ import annotations

import argparse
import json
import shutil
import sys
from pathlib import Path
from typing import Any

REPO_ROOT = Path(__file__).resolve().parents[2]
MANIFEST_PATH = REPO_ROOT / "docs" / "tracking" / "tikz-poc" / "manifest.json"


def fail(message: str) -> None:
    raise ValueError(message)


def install_assets(manifest: dict[str, Any], source_dir: Path, target_dir: Path) -> list[Path]:
    """Copy validated PDF/SVG pairs according to the manifest's explicit output mapping."""
    if manifest.get("status") != "experimental-reconstruction-not-canonical":
        fail("manifest status does not identify the experimental TikZ sources")
    figures = manifest.get("figures")
    if not isinstance(figures, list) or len(figures) != 3:
        fail("expected exactly three TikZ figure mappings")

    source_dir = source_dir.resolve()
    target_dir.mkdir(parents=True, exist_ok=True)
    installed: list[Path] = []
    seen: set[str] = set()

    for figure in figures:
        figure_id = str(figure.get("id", ""))
        asset = str(figure.get("production_asset", ""))
        if not figure_id or figure_id in seen:
            fail(f"missing or duplicate figure id: {figure_id!r}")
        seen.add(figure_id)
        if not asset or asset in {".", ".."} or "/" in asset or "\\" in asset:
            fail(f"{figure_id}: production_asset must be a plain filename stem")

        for extension in ("pdf", "svg"):
            source = (source_dir / f"{figure_id}.{extension}").resolve()
            if not source.is_relative_to(source_dir) or not source.is_file():
                fail(f"{figure_id}: missing or unsafe generated {extension} output")
            if source.stat().st_size < 100:
                fail(f"{figure_id}: generated {extension} output is implausibly small")
            destination = target_dir / f"{asset}.{extension}"
            shutil.copyfile(source, destination)
            installed.append(destination)

    return installed


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True, help="directory containing validated TikZ outputs")
    parser.add_argument("--target", type=Path, default=REPO_ROOT / "spec" / "figures")
    args = parser.parse_args()

    manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
    try:
        installed = install_assets(manifest, args.source, args.target)
    except (OSError, ValueError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1

    for path in installed:
        print(f"installed {path}")
    print(f"installed {len(installed) // 2} TikZ figures ({len(installed)} files)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
