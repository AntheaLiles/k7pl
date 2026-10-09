#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Convert the pinned Lake Git manifest into OSV-Scanner's custom-lockfile format.

This adapter intentionally emits repository URLs and exact Git commit hashes, not invented
semantic versions or package-manager identities. It is a vulnerability-query input, not an SPDX
or CycloneDX SBOM and not a claim that OSV contains advisories for every dependency.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from check_manifest import check_consistency, check_manifest

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_MANIFEST = ROOT / "lake-manifest.json"
DEFAULT_OUTPUT = ROOT / "lake-osv-scanner.json"
MAX_MANIFEST_BYTES = 1 << 20


def convert_manifest(manifest: object) -> dict[str, object]:
    """Return OSV-Scanner custom-lockfile data after strict Lake manifest validation."""
    errors = check_manifest(manifest)
    if errors:
        raise ValueError("invalid Lake manifest:\n" + "\n".join(f"- {error}" for error in errors))

    packages = manifest["packages"]
    assert isinstance(packages, list)
    dependencies = []
    for item in sorted(packages, key=lambda package: (package["url"], package["rev"])):
        repository = item["url"].removeprefix("https://")
        dependencies.append({"package": {"name": repository, "commit": item["rev"]}})

    return {"results": [{"packages": dependencies}]}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()

    try:
        raw = args.manifest.read_bytes()
        if len(raw) > MAX_MANIFEST_BYTES:
            raise ValueError(f"manifest exceeds {MAX_MANIFEST_BYTES} bytes")
        manifest = json.loads(raw)
        lakefile = (ROOT / "lakefile.lean").read_text(encoding="utf-8")
        toolchain = (ROOT / "lean-toolchain").read_text(encoding="utf-8")
        result = convert_manifest(manifest, lakefile, toolchain)
        encoded = json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
        args.output.write_text(encoded, encoding="utf-8")
    except (OSError, UnicodeDecodeError, json.JSONDecodeError, ValueError) as error:
        print(f"lake_manifest_to_osv.py: {error}", file=sys.stderr)
        return 1

    count = len(result["results"][0]["packages"])
    print(f"Generated OSV-Scanner custom lockfile with {count} pinned Lake Git dependencies: {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
