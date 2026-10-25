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
LEAN_PREFIXES = ("src/", "tests/")
# Called by both the `impl` and the `spec` job of verify.yaml, so a change must run both.
LEAN_AND_SPEC_BUILD_EXACT = {"scripts/axiom-audit.sh"}
SPEC_BUILD_EXACT = {
    "scripts/controle.py",
    "scripts/manuscript_metrics.py",
    # Bibliography data moved from docs/bibliography/ in the
    # security/decisions/docs-root/bibliography closing: a change
    # to the cited-works data is a specification build, not a
    # light documentation change.
    "wiki/references.json",
}
SPEC_BUILD_PREFIXES = ("spec/", "tools/", "scripts/controles/", "scripts/biblio/")
# Retired 2026-10-25 with the tracking folder: the primitive list moved to
# wiki/research.md (read by scripts/controles/croise.py, which is on the
# specification-build surface), and the tracking views were frozen and
# deleted with scripts/suivi.py. No path triggers the tracking_views
# surface on its own any more; it is set only by a full validation.
SPEC_CHECK_EXACT = set()
LIGHT_PREFIXES = ("docs/", ".claude/", ".github/ISSUE_TEMPLATE/", "LICENSES/")
LIGHT_EXACT = {"CITATION.cff"}
PYTHON_TEST_EXACT = {"scripts/generate_status.py"}
PYTHON_TEST_PREFIXES = ("tests/python/",)

# Files that a check reads although they belong to another surface. These rules only add the
# check to whatever else the path triggers; test_impact_coverage.py derives the need from the code
# of the checks and fails when a file they read does not trigger them.
# tests/python reads the statement migration register (through statement_inventory.py);
# couverture.py scans src/ for coupling anchors, in controle.py and in the
# `real_lean` pytest fixture. The stage C audits in docs/migration/ were read
# here until the complete migration closing of 2026-10-25 deleted them; their
# verdicts were traced in the migration matrix, deleted at the final closing,
# and survive in git history.
PYTHON_TEST_READ_EXACT = {"wiki/assurance.md"}  # C8 inventory appendix, read by the statement-inventory tests
PYTHON_TEST_READ_PREFIXES = ("src/",)
SPEC_CHECK_READ_PREFIXES = ("src/",)
# Imported by tests/SpecToolsTest.lean and tests/SbomAuditTest.lean, or roots of K7plCompliance and
# sbomAudit: only the `impl` job builds them.
LEAN_BUILD_READ_EXACT = {
    "tools/SpecExt/IndexCore.lean",
    "tools/SpecExt/IndexTerms.lean",
    "tools/SpecExt/Translate.lean",
}
LEAN_BUILD_READ_PREFIXES = ("tools/Compliance/",)


def starts(path: str, prefixes: tuple[str, ...]) -> bool:
    return any(path.startswith(prefix) for prefix in prefixes)


def is_markdown(path: str) -> bool:
    return path.lower().endswith((".md", ".markdown"))


def changed_paths(base: str, head: str) -> list[str]:
    """Paths that differ between two commits.

    Two properties matter for safety. `--no-renames` reports a rename as a deletion plus an
    addition: with rename detection only the new path is listed, so moving `lakefile.lean` under
    `docs/` would look like a documentation change. There is no `--diff-filter`: every kind of
    change counts. A failed diff must stop the script, never become "no changed path", which
    would classify nothing and validate nothing.
    """
    result = subprocess.run(
        ["git", "diff", "--name-only", "--no-renames", base, head],
        text=True,
        capture_output=True,
    )
    if result.returncode != 0:
        raise SystemExit(
            f"impact.py: git diff {base} {head} failed with exit status {result.returncode}: "
            f"{result.stderr.strip()}"
        )
    return [line for line in result.stdout.splitlines() if line]


def classify(paths: list[str], force_full: bool = False) -> dict[str, object]:
    full = force_full
    docs_links = False
    spec_check = False
    spec_build = False
    lean_build = False
    python_tests = False
    tracking_views = force_full
    unknown: list[str] = []

    for path in paths:
        if is_markdown(path):
            docs_links = True

        if path in PYTHON_TEST_READ_EXACT or starts(path, PYTHON_TEST_READ_PREFIXES):
            python_tests = True

        if starts(path, SPEC_CHECK_READ_PREFIXES):
            spec_check = True

        if path in LEAN_BUILD_READ_EXACT or starts(path, LEAN_BUILD_READ_PREFIXES):
            lean_build = True

        if path in FULL_EXACT or starts(path, FULL_PREFIXES):
            full = True
        elif path in SPEC_BUILD_EXACT or starts(path, SPEC_BUILD_PREFIXES):
            spec_check = True
            spec_build = True
            python_tests = True
        elif path in SPEC_CHECK_EXACT:
            spec_check = True
        elif path in PYTHON_TEST_EXACT or starts(path, PYTHON_TEST_PREFIXES):
            python_tests = True
        elif starts(path, LEAN_PREFIXES):
            lean_build = True
        elif path in LEAN_AND_SPEC_BUILD_EXACT:
            lean_build = True
            spec_build = True
        elif is_markdown(path) or starts(path, LIGHT_PREFIXES) or path in LIGHT_EXACT:
            pass
        else:
            unknown.append(path)

    if unknown:
        full = True

    if full:
        tracking_views = True
        docs_links = True
        spec_check = True
        spec_build = True
        lean_build = True
        python_tests = True

    return {
        "full": full,
        "docs_links": docs_links,
        "spec_check": spec_check,
        "spec_build": spec_build,
        "lean_build": lean_build,
        "python_tests": python_tests,
        "tracking_views": tracking_views,
        "unclassified": bool(unknown),
        "unknown_paths": unknown,
    }


def write_outputs(result: dict[str, object]) -> None:
    output = os.environ.get("GITHUB_OUTPUT")
    if not output:
        return
    with open(output, "a", encoding="utf-8") as handle:
        for key in ("full", "docs_links", "spec_check", "spec_build", "lean_build", "python_tests", "tracking_views", "unclassified"):
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
        print(f"  {path!r}")  # quoted: a path such as `::warning::x` must not become a log command
    print("Impact: " + " ".join(f"{key}={str(value).lower()}" for key, value in result.items() if key not in {"unknown_paths"}))
    if result["unknown_paths"]:
        print("Unclassified paths:")
        for path in result["unknown_paths"]:
            print(f"  {path!r}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
