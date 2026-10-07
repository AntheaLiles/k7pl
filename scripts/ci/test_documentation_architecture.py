# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the documentation architecture guard."""

import tempfile
import unittest
from pathlib import Path

from check_documentation_architecture import check


class DocumentationArchitectureTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp.name)
        self.addCleanup(self.tmp.cleanup)
        for rel in (
            "docs/archives",
            "docs/bibliography",
            "docs/history",
            "docs/method",
            "docs/migration",
            "docs/peer-review",
            "docs/research",
            "docs/security",
            "docs/tracking",
        ):
            (self.root / rel).mkdir(parents=True)
        for rel, heading in {
            "docs/README.md": "# K7PL Documentation",
            "docs/ARCHITECTURE.md": "# K7PL Architecture",
            "docs/ASSURANCE.md": "# K7PL Scientific Assurance Case",
            "docs/METHOD.md": "# K7PL Method",
            "docs/PROVENANCE.md": "# Document provenance",
            "docs/RESEARCH.md": "# K7PL Research",
            "docs/STATUS.md": "# K7PL Status",
            "docs/tracking/TABLEAU-DE-BORD.md": "# K7PL Project Dashboard",
            "docs/tracking/DOCUMENTATION-ARCHITECTURE-PLAN.md": "# Documentation architecture and migration plan",
            "docs/migration/README.md": "# Migration register",
            "docs/peer-review/README.md": "# Peer review",
        }.items():
            path = self.root / rel
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(heading + "\n", encoding="utf-8")
        (self.root / "docs/bibliography/references.json").write_text("{}\n", encoding="utf-8")

    def test_clean_tree(self):
        self.assertEqual(check(self.root), [])

    def test_root_biblio_is_rejected(self):
        path = self.root / "biblio/references.json"
        path.parent.mkdir(parents=True)
        path.write_text("{}\n", encoding="utf-8")
        self.assertTrue(any("legacy path still exists: biblio/references.json" in e for e in check(self.root)))

    def test_current_archive_path_is_allowed(self):
        path = self.root / "docs/README.md"
        path.write_text("# K7PL Documentation\nSee docs/archives/.\n", encoding="utf-8")
        self.assertEqual(check(self.root), [])

    def test_root_archive_path_is_rejected(self):
        path = self.root / "docs/README.md"
        path.write_text("# K7PL Documentation\nSee archives/.\n", encoding="utf-8")
        self.assertTrue(any("archives/" in e for e in check(self.root)))

    def test_legacy_reference_is_rejected(self):
        path = self.root / "docs/README.md"
        path.write_text("# K7PL Documentation\nSee docs/suivi/.\n", encoding="utf-8")
        self.assertTrue(any("obsolete path reference" in e for e in check(self.root)))

    def test_non_english_entry_point_is_rejected(self):
        path = self.root / "docs/PROVENANCE.md"
        path.write_text("# Provenance des documents\n", encoding="utf-8")
        self.assertTrue(any("non-English or unexpected" in e for e in check(self.root)))
