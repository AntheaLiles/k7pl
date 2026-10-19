# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Keep docs/history/README.md complete.

Every Markdown record in docs/history/ (except the index itself) must be linked from the index,
and every relative link in the index must resolve. Run from anywhere with
`python3 -m unittest discover -s scripts/ci -p 'test_*.py'`.
"""

import re
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
HISTORY = REPO_ROOT / "docs" / "history"
INDEX = HISTORY / "README.md"
LINK_RE = re.compile(r"\]\(([^)\s]+)\)")


def relative_targets(text: str) -> list[str]:
    """Relative link targets of a Markdown text, without their anchors."""
    targets = []
    for target in LINK_RE.findall(text):
        if target.startswith(("#", "http://", "https://", "mailto:")):
            continue
        targets.append(target.split("#", 1)[0])
    return targets


class HistoryIndexTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue(INDEX.is_file(), f"missing index: {INDEX.relative_to(REPO_ROOT)}")
        self.text = INDEX.read_text(encoding="utf-8")

    def test_relative_links_resolve(self):
        broken = [t for t in relative_targets(self.text) if not (HISTORY / t).exists()]
        self.assertEqual(broken, [], "docs/history/README.md has links that do not resolve: " + ", ".join(broken))

    def test_every_record_is_indexed(self):
        records = sorted(p.name for p in HISTORY.glob("*.md") if p.name != "README.md")
        # Guard against vacuity: the check means nothing if the directory is not found.
        self.assertGreater(len(records), 0, "no Markdown record found in docs/history/")
        linked = {(HISTORY / t).resolve() for t in relative_targets(self.text)}
        missing = [name for name in records if (HISTORY / name).resolve() not in linked]
        self.assertEqual(
            missing,
            [],
            "docs/history/README.md does not link these records; add one line per file to the index: "
            + ", ".join(missing),
        )


if __name__ == "__main__":
    unittest.main()
