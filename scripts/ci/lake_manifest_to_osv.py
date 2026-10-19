#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Convert the pinned Lake Git manifest into OSV-Scanner's custom-lockfile format.

This adapter emits repository identities and exact Git commit hashes, not invented semantic
versions or package-manager identities. It is a vulnerability-query input, not an SPDX or CycloneDX
SBOM, and does not imply that OSV contains advisories for every dependency.

The manifest is read and validated by `check_manifest.py` (`load_workspace_inputs`,
`validated_manifest`): a manifest that this adapter converts is one that check would accept, for
the Lake workspace it belongs to (the root one unless `--manifest` names the manifest of the
Paperproof workspace, `check_manifest.PAPERPROOF_DIRECTORY`).
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from check_manifest import ROOT_WORKSPACE, Workspace, load_workspace_inputs, validated_manifest

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_MANIFEST = ROOT / "lake-manifest.json"
DEFAULT_OUTPUT = ROOT / "lake-osv-scanner.json"


def convert_manifest(
    manifest: object, lakefile: str, toolchain: str, workspace: Workspace = ROOT_WORKSPACE
) -> dict[str, object]:
    """Convert only a structurally valid manifest consistent with Lake's declared pins."""
    manifest = validated_manifest(manifest, lakefile, toolchain, workspace)

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
        inputs = load_workspace_inputs(ROOT, args.manifest)
        result = convert_manifest(inputs.manifest, inputs.lakefile, inputs.toolchain, inputs.workspace)
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
