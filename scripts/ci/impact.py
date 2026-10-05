#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Classify changed repository paths into the CI validation surfaces."""

from __future__ import annotations

import argparse
import os
import subprocess

FULL_EXACT = {
    ".github/dependabot.yml",
    "lakefile.lean",
    "lean-toolchain",
    "lake-manifest.json",
    "scripts/sync_zenodo.py",
    "scripts/requirements-zenodo.txt",
}
FULL_PREFIXES = (".github/workflows/", "scripts/ci/")
LEAN_EXACT = {"scripts/axiom-audit.sh"}
LEAN_PREFIXES = ("src/", "tests/")
SPEC_BUILD_EXACT = {
    "scripts/controle.py",
    "scripts/manuscript_metrics.py",
}
SPEC_BUILD_PREFIXES = ("spec/", "tools/", "biblio/", "scripts/controles/")
SPEC_CHECK_EXACT = {"docs/suivi/primitives.md"}
LIGHT_PREFIXES = ("docs/", ".claude/", ".github/ISSUE_TEMPLATE/", "LICENSES/")
LIGHT_EXACT = {"CITATION.cff"}


def starts(path: str, prefixes: tuple[str, ...]) -> bool:
    return any(path.startswith(prefix) for prefix in prefixes)


def is_markdown(path: str) -> bool:
    return path.lower().endswith((".md", ".markdown"))


def changed_paths(base: str, head: str) -> list[str]:
    result = subprocess.run(
        ["git", "diff", "--name-only", "--diff-filter=ACDMRT", "--no-renames", base, head],
        check=True,
        text=True,
        capture_output=True,
    )
    return [line for line in result.stdout.splitlines() if line]


def classify(paths: list[str], force_full: bool = False) -> dict[str, object]:
    full = force_full
    docs_links = False
    spec_check = False
    spec_build = False
    lean_build = False
    unknown: list[str] = []

    for path in paths:
        if is_markdown(path):
            docs_links = True
        elif starts(path, LIGHT_PREFIXES) or path in LIGHT_EXACT:
            pass

        if path in FULL_EXACT or starts(path, FULL_PREFIXES):
            full = True
        elif path in LEAN_EXACT or starts(path, LEAN_PREFIXES):
            lean_build = True
        elif path in SPEC_CHECK_EXACT:
            spec_check = True
        elif path in SPEC_BUILD_EXACT or starts(path, SPEC_BUILD_PREFIXES):
            spec_check = True
            spec_build = True
        elif is_markdown(path) or starts(path, LIGHT_PREFIXES) or path in LIGHT_EXACT:
            pass
        else:
            unknown.append(path)

    if unknown:
        full = True

    if full:
        docs_links = True
        spec_check = True
        spec_build = True
        lean_build = True

    return {
        "full": full,
        "docs_links": docs_links,
        "spec_check": spec_check,
        "spec_build": spec_build,
        "lean_build": lean_build,
        "unclassified": bool(unknown),
        "unknown_paths": unknown,
    }


def write_outputs(result: dict[str, object]) -> None:
    output = os.environ.get("GITHUB_OUTPUT")
    if not output:
        return
    with open(output, "a", encoding="utf-8") as handle:
        for key in ("full", "docs_links", "spec_check", "spec_build", "lean_build", "unclassified"):
            handle.write(f"{key}={str(result[key]).lower()}\n")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--base", help="Base commit for git diff")
    parser.add_argument("--head", help="Head commit for git diff")
    parser.add_argument("--force-full", action="store_true", help="Force the complete validation")
    args = parser.parse_args()

    if args.force_full:
        paths: list[str] = []
    elif not args.base or not args.head:
        parser.error("--base et --head sont requis sauf avec --force-full")
    else:
        paths = changed_paths(args.base, args.head)

    result = classify(paths, force_full=args.force_full)
    write_outputs(result)
    print(f"Changed paths: {len(paths)}")
    for path in paths:
        print(f"  {path}")
    print("Impact: " + " ".join(f"{key}={str(value).lower()}" for key, value in result.items() if key not in {"unknown_paths"}))
    if result["unknown_paths"]:
        print("Unclassified paths:")
        for path in result["unknown_paths"]:
            print(f"  {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())