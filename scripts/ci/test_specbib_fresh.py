# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Freshness of `tools/SpecBib.lean`, generated from `wiki/references.json`.

The Lean bibliography is committed, so a notice added to `references.json` without regenerating
it is silently missing from the specification build. These tests run the documented generator
into a temporary directory and require the committed file to be byte-identical to its output.
They run on every pull request, in the impact job.
"""

from __future__ import annotations

import difflib
import json
import os
import re
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
GENERATOR = ROOT / "scripts" / "biblio" / "biblio.py"
REFERENCES = ROOT / "wiki" / "references.json"
COMMITTED = ROOT / "tools" / "SpecBib.lean"
CITE_RENDERER = ROOT / "tools" / "SpecExt" / "Cite.lean"
sys.path.insert(0, str(GENERATOR.parent))
import biblio
REGENERATE = (
    "python3 scripts/biblio/biblio.py lean wiki/references.json tools/SpecBib.lean"
)
ENTRY_KEY = re.compile(r'^  \("((?:[^"\\]|\\.)*)", \[', re.MULTILINE)


def regenerate() -> str:
    """The text that the generator writes today for the committed references."""
    with tempfile.TemporaryDirectory() as tmp:
        output = Path(tmp) / "SpecBib.lean"
        done = subprocess.run(
            [sys.executable, str(GENERATOR), "lean", str(REFERENCES), str(output)],
            capture_output=True, text=True, timeout=120,
            env={**os.environ, "PYTHONDONTWRITEBYTECODE": "1"},
        )
        if done.returncode != 0:
            raise AssertionError(f"the generator failed ({done.returncode}): {done.stderr}")
        return output.read_text(encoding="utf-8")


class SpecBibFreshnessTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.generated = regenerate()
        cls.committed = COMMITTED.read_text(encoding="utf-8")

    def test_every_reference_has_exactly_one_notice(self):
        references = set(json.loads(REFERENCES.read_text(encoding="utf-8"))["entries"])
        keys = ENTRY_KEY.findall(self.committed)
        self.assertEqual(len(keys), len(set(keys)), "duplicate notices in tools/SpecBib.lean")
        missing, extra = sorted(references - set(keys)), sorted(set(keys) - references)
        self.assertEqual(
            (missing, extra), ([], []),
            f"tools/SpecBib.lean is stale (missing notices: {missing}; notices without a "
            f"reference: {extra}). Regenerate it with:\n  {REGENERATE}",
        )

    def test_committed_file_is_the_generator_output(self):
        if self.committed == self.generated:
            return
        diff = difflib.unified_diff(
            self.committed.splitlines(), self.generated.splitlines(),
            "tools/SpecBib.lean (committed)", "tools/SpecBib.lean (regenerated)", lineterm="", n=0,
        )
        excerpt = [line[:160] for line in diff][:20]
        self.fail(
            "tools/SpecBib.lean differs from what scripts/biblio/biblio.py generates from "
            f"wiki/references.json. Regenerate it with:\n  {REGENERATE}\n"
            + "\n".join(excerpt)
        )

    def test_generated_header_is_the_licence_of_the_committed_file(self):
        # Generated data carries CC0-1.0 (d87455f); the generator writes the same header. The
        # tags are split so that REUSE does not read them as this file's own licence.
        tag = "SPDX-"
        header = self.generated.splitlines()[:3]
        self.assertEqual(
            header,
            [
                f"-- {tag}FileCopyrightText: 2026 Cyprien PIERRE",
                "--",
                f"-- {tag}License-Identifier: CC0-1.0",
            ],
        )

    def test_the_comparison_is_not_vacuous(self):
        self.assertGreater(len(ENTRY_KEY.findall(self.generated)), 200)
        self.assertIn("def SpecBib.entries : Array SpecBib.Entry := #[", self.generated)


class BibliographyFormattingTests(unittest.TestCase):
    @staticmethod
    def author(last: str, first: str) -> dict:
        return {"last": last, "first": first, "lineage": ""}

    def test_three_authors_and_doi_use_compact_reference(self):
        record = {
            "type": "inproceedings",
            "persons": {"author": [
                self.author("Becker", "Brett A."),
                self.author("Denny", "Paul"),
                self.author("Pettit", "Raymond"),
            ]},
            "title": "Compiler Error Messages Considered Unhelpful",
            "booktitle": "Proceedings of a Conference",
            "location": "Aberdeen Scotland Uk",
            "publisher": "ACM",
            "year": "2019",
            "pages": "177--210",
            "doi": "10.1145/3344429.3372508",
            "url": "https://dl.acm.org/doi/10.1145/3344429.3372508",
            "urldate": "2026-08-19",
        }
        parts, doi, url = biblio.fmt(record)
        rendered = "".join(text for _, text in parts)
        self.assertEqual(
            rendered,
            "BECKER, Brett A. et al., Compiler Error Messages Considered Unhelpful. "
            "In: Proceedings of a Conference, Aberdeen Scotland Uk: ACM, 2019, p. 177–210.",
        )
        self.assertEqual(doi, "10.1145/3344429.3372508")
        self.assertIsNone(url)
        self.assertNotIn("[en ligne]", rendered)
        self.assertNotIn("[visité le", rendered)
        self.assertNotIn("Disp. à l’adr.", rendered)

    def test_one_or_two_authors_are_all_retained(self):
        record = {
            "type": "article",
            "persons": {"author": [
                self.author("Becker", "Brett A."),
                self.author("Denny", "Paul"),
            ]},
            "title": "A title",
            "year": "2020",
        }
        parts, _, _ = biblio.fmt(record)
        rendered = "".join(text for _, text in parts)
        self.assertTrue(rendered.startswith("BECKER, Brett A.; DENNY, Paul, A title."))

    def test_html_and_tex_doi_labels_match(self):
        source = CITE_RENDERER.read_text(encoding="utf-8")
        self.assertIn('Output.Html.text true " DOI: "', source)
        self.assertIn('some d, _ => s!" DOI: ', source)
        self.assertIn('https://doi.org/{d}', source)
        self.assertNotIn("Disp. à l’adr. DOI:", source)


if __name__ == "__main__":
    unittest.main()
