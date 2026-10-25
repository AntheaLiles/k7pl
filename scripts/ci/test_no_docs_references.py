# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Guard against live references to the deleted docs/ directory.

The docs/ directory was closed completely on 2026-10-25 (its content was
integrated into the project, consolidated into wiki/, or abandoned with a
recorded reason). Any new reference to a docs/ path in an executable script
or workflow is therefore a regression: the path no longer exists, and the
script would fail or silently read nothing.

Scope, deliberately narrow so the guard stays honest:
- scanned: executable surfaces only -- scripts/ci (except test files),
  scripts/controles, top-level scripts/*.py, and .github/workflows.
- NOT scanned: tests/ and scripts/ci/test_*.py (their docs/ strings are
  synthetic fixtures, not reads of the repository), and prose files
  (.md), whose historical mentions are not executable paths.
- allowlisted, with a reason each: files that mention docs/ only as
  historical prose, as a classification prefix, or as the legacy-path
  guard itself. A new docs/ reference in any other scanned file fails
  this test, even if it is only a comment: the point of the guard is
  that docs/ must stop appearing in the active tooling surface at all.
"""

import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

# Files whose docs/ mentions are known, historical, and not live reads.
# - check_documentation_architecture.py: the legacy-path guard itself;
#   its LEGACY_PATHS list is intentional, and its own tests cover it.
# - impact.py: LIGHT_PREFIXES classifies any future docs/ path in a
#   diff as a light change; it never reads a docs/ file.
# - suivi.py: frozen since 2026-10-25; its docs/ mentions are the
#   prose of a script that generates nothing and is not run by CI.
# - verif_singularites.py: a single historical comment quoting a
#   deleted research file; the script reads spec/, not docs/.
# - controles/croise.py, controles/couverture.py, controles/structure.py:
#   historical comments/docstrings only; their live inputs are
#   wiki/research.md, wiki/STATUS.md, and spec/ respectively.
ALLOWLIST = {
    "scripts/ci/check_documentation_architecture.py",
    "scripts/ci/impact.py",
    "scripts/suivi.py",
    "scripts/verif_singularites.py",
    "scripts/controles/croise.py",
    "scripts/controles/couverture.py",
    "scripts/controles/structure.py",
}

SCAN_EXTENSIONS = {".py", ".sh", ".yaml", ".yml"}


def scanned_files(root: Path) -> list[Path]:
    bases = [
        root / "scripts" / "ci",
        root / "scripts" / "controles",
        root / ".github" / "workflows",
    ]
    files: list[Path] = []
    for base in bases:
        if not base.exists():
            continue
        for path in sorted(base.rglob("*")):
            if not path.is_file():
                continue
            if path.suffix.lower() not in SCAN_EXTENSIONS:
                continue
            rel = path.relative_to(root).as_posix()
            if rel in ALLOWLIST:
                continue
            if path.name.startswith("test_"):
                continue
            files.append(path)
    # Top-level scripts/*.py only (not subdirectories, which are
    # covered above or are data, not executable tooling).
    scripts_dir = root / "scripts"
    if scripts_dir.exists():
        for path in sorted(scripts_dir.glob("*.py")):
            rel = path.relative_to(root).as_posix()
            if rel not in ALLOWLIST:
                files.append(path)
    return files


class TestNoDocsReferences(unittest.TestCase):
    def test_no_live_docs_reference(self):
        # A docs/ reference is a path token: docs/ at a word boundary.
        # This excludes substrings such as "spdxdocs/" in a URL, where
        # docs/ is preceded by an alphanumeric character, while still
        # catching "$GITHUB_WORKSPACE/docs/..." (slash before docs/).
        pattern = re.compile(r"(?<![A-Za-z0-9])docs/")
        offenders = []
        for path in scanned_files(ROOT):
            try:
                text = path.read_text(encoding="utf-8")
            except UnicodeDecodeError:
                continue
            for lineno, line in enumerate(text.splitlines(), start=1):
                if pattern.search(line):
                    offenders.append(
                        f"{path.relative_to(ROOT).as_posix()}:{lineno}: {line.strip()}"
                    )
        self.assertEqual(
            offenders,
            [],
            "docs/ references in the executable tooling surface "
            "(repoint to wiki/ or theoretical-projects/k7os/, or add a "
            "justified allowlist entry):\n" + "\n".join(offenders),
        )


if __name__ == "__main__":
    unittest.main()
