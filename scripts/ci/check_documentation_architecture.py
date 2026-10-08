# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Guard the repository/documentation architecture after the controlled migration."""

from __future__ import annotations

import re
from pathlib import Path

LEGACY_PATHS = (
    "archives/",
    "docs/archive/",
    "docs/journal/",
    "docs/historique/",
    "docs/relectures/",
    "docs/suivi/",
    "docs/recherche/",
    "docs/methode/",
    "docs/bibliographie/",
    "biblio/references.json",
)

REQUIRED_DIRS = (
    "docs/archives",
    "docs/bibliography",
    "docs/history",
    "docs/method",
    "docs/migration",
    "docs/peer-review",
    "docs/research",
    "docs/security",
    "docs/tracking",
)

REQUIRED_FILES = {
    "docs/bibliography/references.json",
    "docs/README.md",
    "docs/ARCHITECTURE.md",
    "docs/ASSURANCE.md",
    "docs/METHOD.md",
    "docs/PROVENANCE.md",
    "docs/RESEARCH.md",
    "docs/STATUS.md",
    "docs/tracking/DASHBOARD.md",
    "docs/migration/README.md",
    "docs/peer-review/README.md",
}

ENGLISH_ENTRY_POINTS = {
    "docs/README.md": "# K7PL Documentation",
    "docs/ARCHITECTURE.md": "# K7PL Architecture",
    "docs/ASSURANCE.md": "# K7PL Scientific Assurance Case",
    "docs/METHOD.md": "# K7PL Method",
    "docs/PROVENANCE.md": "# Document provenance",
    "docs/RESEARCH.md": "# K7PL Research",
    "docs/STATUS.md": "# K7PL Status",
    "docs/tracking/DASHBOARD.md": "# K7PL Project Dashboard",
    "docs/migration/README.md": "# Migration register",
    "docs/peer-review/README.md": "# Peer review",
}

SCAN_EXTENSIONS = {".md", ".py", ".sh", ".lean", ".toml", ".yaml", ".yml", ".cff", ".json"}


def _read_text(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return ""


def check(root: Path) -> list[str]:
    errors: list[str] = []

    for rel in LEGACY_PATHS:
        if (root / rel.rstrip("/")).exists():
            errors.append(f"legacy path still exists: {rel}")

    for rel in REQUIRED_DIRS:
        if not (root / rel).is_dir():
            errors.append(f"required directory missing: {rel}")

    for rel in REQUIRED_FILES:
        if not (root / rel).is_file():
            errors.append(f"required file missing: {rel}")

    for rel, expected in ENGLISH_ENTRY_POINTS.items():
        path = root / rel
        if not path.is_file():
            continue
        first_heading = next((line.strip() for line in _read_text(path).splitlines() if line.startswith("# ")), "")
        if first_heading != expected:
            errors.append(f"non-English or unexpected entry point heading: {rel}: {first_heading!r}")

    scan_roots = [root / "scripts", root / "tools", root / ".github", root / ".claude", root / "docs"]
    excluded_parts = {("docs", "history"), ("docs", "archives"), ("docs", "migration")}
    for base in scan_roots:
        if not base.exists():
            continue
        for path in base.rglob("*"):
            if not path.is_file() or path.suffix.lower() not in SCAN_EXTENSIONS:
                continue
            rel = path.relative_to(root).as_posix()
            parts = rel.split("/")
            if len(parts) >= 2 and tuple(parts[:2]) in excluded_parts:
                continue
            text = _read_text(path)
            if rel in {"scripts/ci/check_documentation_architecture.py", "scripts/ci/test_documentation_architecture.py", "docs/tracking/COHERENCE-REVIEW.md"} or (rel.startswith("docs/security/") and rel.endswith("/AUDIT.md")):
                continue
            legacy_patterns = tuple(re.compile(re.escape(marker)) for marker in LEGACY_PATHS[1:])
            for pattern in legacy_patterns:
                if pattern.search(text):
                    errors.append(f"obsolete path reference in active surface: {rel}: {pattern.pattern}")
    return sorted(set(errors))


def main() -> int:
    root = Path(__file__).resolve().parents[2]
    errors = check(root)
    if errors:
        for error in errors:
            print(f"ERROR: {error}")
        return 1
    print("documentation architecture check: OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
