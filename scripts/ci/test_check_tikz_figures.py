# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the TikZ figure manifest and completeness check."""

import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import check_tikz_figures as check  # noqa: E402

DECLARATION = '::::figure (label := "{label}") (src := "{src}") (alt := "Figure.")\n'


def make_repo(root: Path, declarations: dict[str, str], figures: list[dict[str, str]]) -> None:
    """Write a minimal repository with one Verso file and a TikZ manifest."""
    chapter = root / "spec" / "Spec" / "C1"
    chapter.mkdir(parents=True)
    (chapter / "Figures.lean").write_text(
        "".join(DECLARATION.format(label=label, src=src) for label, src in declarations.items()),
        encoding="utf-8",
    )
    tikz = root / "spec" / "figures" / "tikz"
    tikz.mkdir(parents=True)
    for figure in figures:
        (tikz / figure["source"]).write_text("% TikZ\n", encoding="utf-8")
    manifest = {"status": "canonical-tikz-sources", "figures": figures}
    (tikz / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")


def entry(stem: str, label: str) -> dict[str, str]:
    return {
        "id": stem,
        "source": f"{stem}.tex",
        "asset_stem": stem,
        "canonical_verso": f"spec/Spec/C1/Figures.lean#{label}",
    }


class TikzFigureCheckTest(unittest.TestCase):
    def test_repository_manifest_covers_every_declaration(self) -> None:
        self.assertEqual(check.validate(check.REPO_ROOT), [])

    def test_consistent_manifest_passes(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            make_repo(root, {"fig:a": "a", "fig:b": "b"}, [entry("a", "fig:a"), entry("b", "fig:b")])
            self.assertEqual(check.validate(root), [])

    def test_declaration_without_tikz_source_fails(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            make_repo(root, {"fig:a": "a", "fig:b": "b"}, [entry("a", "fig:a")])
            errors = check.validate(root)
            self.assertTrue(any("'fig:b'" in error and "no TikZ source" in error for error in errors), errors)

    def test_label_is_matched_exactly_not_as_substring(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            make_repo(root, {"fig:ab": "a"}, [entry("a", "fig:a")])
            errors = check.validate(root)
            self.assertTrue(any("no figure declaration 'fig:a'" in error for error in errors), errors)

    def test_mismatched_asset_stem_fails(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            make_repo(root, {"fig:a": "other"}, [entry("a", "fig:a")])
            errors = check.validate(root)
            self.assertTrue(any("uses src 'other'" in error for error in errors), errors)

    def test_missing_generated_assets_fail(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            make_repo(root, {"fig:a": "a"}, [entry("a", "fig:a")])
            generated = root / "out"
            generated.mkdir()
            errors = check.validate(root, generated)
            self.assertTrue(any("missing or implausibly small PDF" in error for error in errors), errors)


if __name__ == "__main__":
    unittest.main()
