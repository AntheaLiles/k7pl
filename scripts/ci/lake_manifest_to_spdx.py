#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Generate a scoped SPDX 2.3 JSON inventory from the pinned Lake manifest.

This is an inventory of packages listed by Lake, not a claim that the manifest contains a
complete direct/transitive dependency graph. Unknown licence and copyright data remain
NOASSERTION. It does not inventory build tools, GitHub Actions, or generated artifacts.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

from check_manifest import check_consistency, check_manifest

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_MANIFEST = ROOT / "lake-manifest.json"
MAX_MANIFEST_BYTES = 1 << 20
TOOL_NAME = "k7pl-lake-sbom"
TOOL_VERSION = "0.1.0"


def normalize_created(value: str | None = None) -> str:
    """Return an SPDX UTC timestamp, honoring an explicit value or SOURCE_DATE_EPOCH."""
    if value is not None:
        raw = value
    elif "SOURCE_DATE_EPOCH" in os.environ:
        try:
            epoch = int(os.environ["SOURCE_DATE_EPOCH"])
            moment = datetime.fromtimestamp(epoch, tz=timezone.utc)
        except (ValueError, OverflowError, OSError) as error:
            raise ValueError("SOURCE_DATE_EPOCH must be a valid Unix timestamp") from error
        return moment.strftime("%Y-%m-%dT%H:%M:%SZ")
    else:
        moment = datetime.now(timezone.utc)
        return moment.strftime("%Y-%m-%dT%H:%M:%SZ")

    try:
        moment = datetime.fromisoformat(raw.replace("Z", "+00:00"))
    except ValueError as error:
        raise ValueError("created timestamp must be ISO 8601 with an explicit timezone") from error
    if moment.tzinfo is None or moment.utcoffset() is None:
        raise ValueError("created timestamp must include an explicit timezone")
    return moment.astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def _canonical_manifest(manifest: dict[str, Any]) -> str:
    """Serialize the validated manifest's package inventory in a stable order."""
    packages = sorted(
        manifest["packages"],
        key=lambda package: (package["url"], package["name"], package["rev"]),
    )
    normalized = {
        "name": manifest["name"],
        "version": manifest.get("version"),
        "packages": packages,
    }
    return json.dumps(normalized, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def _spdx_id(package: dict[str, Any]) -> str:
    """Build a stable SPDX identifier without punctuation outside the SPDX identifier subset."""
    slug = re.sub(r"[^A-Za-z0-9.-]", "-", package["name"]).strip(".-") or "package"
    return f"SPDXRef-Dependency-{slug}-{package['rev'][:12]}"


def generate_sbom(
    manifest: object,
    lakefile: str,
    toolchain: str,
    created: str,
) -> dict[str, Any]:
    """Build SPDX 2.3 JSON only from a valid manifest consistent with the repository's pins."""
    errors = check_manifest(manifest)
    if errors:
        raise ValueError("invalid Lake manifest:\n" + "\n".join(f"- {error}" for error in errors))
    assert isinstance(manifest, dict)  # established by check_manifest above

    consistency_errors = check_consistency(manifest, lakefile, toolchain)
    if consistency_errors:
        raise ValueError(
            "inconsistent Lake inputs:\n"
            + "\n".join(f"- {error}" for error in consistency_errors)
        )

    created_utc = normalize_created(created)
    canonical = _canonical_manifest(manifest)
    inventory_hash = hashlib.sha256(canonical.encode("utf-8")).hexdigest()
    namespace = f"https://spdx.org/spdxdocs/k7pl-lake-dependencies-{inventory_hash}"

    packages: list[dict[str, Any]] = []
    relationships: list[dict[str, str]] = []
    for item in sorted(manifest["packages"], key=lambda package: (package["url"], package["name"], package["rev"])):
        spdx_id = _spdx_id(item)
        input_rev = item.get("inputRev", "unknown")
        inherited = str(item.get("inherited", "unknown")).lower()
        scope = item.get("scope", "unknown")
        packages.append(
            {
                "name": item["name"],
                "SPDXID": spdx_id,
                "versionInfo": item["rev"],
                "downloadLocation": item["url"],
                "filesAnalyzed": False,
                "licenseConcluded": "NOASSERTION",
                "licenseDeclared": "NOASSERTION",
                "copyrightText": "NOASSERTION",
                "packageComment": (
                    "Listed in lake-manifest.json. versionInfo is the exact resolved Git commit, "
                    "not a semantic version. "
                    f"Requested inputRev: {input_rev}; inherited: {inherited}; scope: {scope or '(empty)'}. "
                    "The manifest is a flattened package inventory and does not establish a complete "
                    "direct/transitive dependency graph; no dependency edge is inferred here."
                ),
            }
        )
        relationships.append(
            {
                "spdxElementId": "SPDXRef-DOCUMENT",
                "relationshipType": "DESCRIBES",
                "relatedSpdxElement": spdx_id,
            }
        )

    return {
        "spdxVersion": "SPDX-2.3",
        "dataLicense": "CC0-1.0",
        "SPDXID": "SPDXRef-DOCUMENT",
        "name": "K7PL Lake dependency inventory",
        "documentNamespace": namespace,
        "creationInfo": {
            "creators": [f"Tool: {TOOL_NAME}-{TOOL_VERSION}"],
            "created": created_utc,
        },
        "comment": (
            "Scoped inventory generated from lake-manifest.json. It covers only the package entries "
            "in that manifest; it does not assert completeness for build tools, CI actions, source files, "
            "generated artifacts, or direct/transitive dependency edges. Unknown licence and copyright "
            "information is represented as NOASSERTION."
        ),
        "packages": packages,
        "relationships": relationships,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--lakefile", type=Path, default=ROOT / "lakefile.lean")
    parser.add_argument("--toolchain", type=Path, default=ROOT / "lean-toolchain")
    parser.add_argument(
        "--created",
        help="ISO 8601 timestamp with timezone; defaults to SOURCE_DATE_EPOCH or current UTC time",
    )
    parser.add_argument(
        "--output",
        type=Path,
        help="write the SPDX JSON to this path; omit to write to standard output",
    )
    args = parser.parse_args()

    try:
        raw = args.manifest.read_bytes()
        if len(raw) > MAX_MANIFEST_BYTES:
            raise ValueError(f"manifest exceeds {MAX_MANIFEST_BYTES} bytes")
        manifest = json.loads(raw)
        lakefile = args.lakefile.read_text(encoding="utf-8")
        toolchain = args.toolchain.read_text(encoding="utf-8")
        created = normalize_created(args.created)
        result = generate_sbom(manifest, lakefile, toolchain, created)
        encoded = json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
        if args.output is None:
            sys.stdout.write(encoded)
        else:
            args.output.write_text(encoded, encoding="utf-8")
    except (OSError, UnicodeDecodeError, json.JSONDecodeError, ValueError) as error:
        print(f"lake_manifest_to_spdx.py: {error}", file=sys.stderr)
        return 1

    print(
        f"Generated scoped SPDX 2.3 inventory with {len(result['packages'])} Lake package entries",
        file=sys.stderr,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
