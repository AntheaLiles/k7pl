# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for scripts/ci/citation_version.sh, the CITATION.cff version read by release.yaml and
zenodo.yaml (they compare it with the release tag)."""

import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts" / "ci" / "citation_version.sh"


@unittest.skipIf(shutil.which("bash") is None or shutil.which("sed") is None, "bash and sed are required")
class CitationVersionTests(unittest.TestCase):
    def version_of(self, text):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "CITATION.cff"
            path.write_text(text, encoding="utf-8")
            result = subprocess.run(["bash", str(SCRIPT), str(path)], capture_output=True, text=True, check=False)
        self.assertEqual(result.returncode, 0, result.stderr)
        return result.stdout

    def test_quoted_and_unquoted_versions(self):
        self.assertEqual(self.version_of('cff-version: 1.2.0\nversion: "0.1.0-alpha.2"\n'), "0.1.0-alpha.2\n")
        self.assertEqual(self.version_of("cff-version: 1.2.0\nversion: 0.1.0\n"), "0.1.0\n")
        self.assertEqual(self.version_of('version:"1.0.0"   \n'), "1.0.0\n")

    def test_only_a_top_level_version_line_counts(self):
        text = 'cff-version: 1.2.0\nreferences:\n  - version: "9.9.9"\nversion-note: x\n'
        self.assertEqual(self.version_of(text), "")
        self.assertEqual(self.version_of("# version: 1.0.0\n"), "")

    def test_no_version_prints_nothing_so_that_the_caller_refuses(self):
        self.assertEqual(self.version_of("title: k7pl\n"), "")

    def test_the_repository_citation_declares_a_version(self):
        result = subprocess.run(["bash", str(SCRIPT)], cwd=ROOT, capture_output=True, text=True, check=False)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertRegex(result.stdout, r"^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?\n$")

    def test_a_missing_file_is_an_error(self):
        with tempfile.TemporaryDirectory() as tmp:
            result = subprocess.run(["bash", str(SCRIPT), str(Path(tmp) / "absent.cff")],
                                    capture_output=True, text=True, check=False)
        self.assertNotEqual(result.returncode, 0)


if __name__ == "__main__":
    unittest.main()
