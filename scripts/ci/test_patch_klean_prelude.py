# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
"""Regression tests for the narrowly-scoped Klean/Lean compatibility shim."""

import unittest

from patch_klean_prelude import DECLARATION, INSTANCE, patch_text


class PatchKleanPreludeTests(unittest.TestCase):
    def test_removes_only_duplicate_helper_and_keeps_instance(self) -> None:
        prefix = "import Lean\n\n-- Prelude fixture\n"
        block = (
            DECLARATION
            + "\n  match a, b with\n"
            + "  | x, y => exact x\n\n"
        )
        suffix = INSTANCE + "\n"
        patched = patch_text(prefix + block + suffix)
        self.assertEqual(patched, prefix + suffix)
        self.assertNotIn(DECLARATION, patched)
        self.assertIn(INSTANCE, patched)

    def test_fails_closed_when_signature_changes(self) -> None:
        with self.assertRaisesRegex(ValueError, "generator output changed"):
            patch_text("import Lean\n\n" + INSTANCE + "\n")

    def test_fails_closed_when_instance_anchor_is_missing(self) -> None:
        source = DECLARATION + "\n  := by decide\n"
        with self.assertRaisesRegex(ValueError, "instance"):
            patch_text(source)


if __name__ == "__main__":
    unittest.main()
