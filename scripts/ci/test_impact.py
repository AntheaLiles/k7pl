# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the CI impact classifier."""

import unittest

from impact import classify


class ImpactTests(unittest.TestCase):
    def test_markdown_is_light(self):
        result = classify(["docs/foo.md"])
        self.assertTrue(result["docs_links"])
        self.assertFalse(result["full"])
        self.assertFalse(result["spec_build"])
        self.assertFalse(result["lean_build"])

    def test_claude_markdown_is_light(self):
        result = classify([".claude/agents/example.md"])
        self.assertTrue(result["docs_links"])
        self.assertFalse(result["full"])

    def test_lean_surface(self):
        result = classify(["src/K7pl/Foo.lean"])
        self.assertTrue(result["lean_build"])
        self.assertFalse(result["spec_build"])
        self.assertFalse(result["full"])

    def test_spec_surface(self):
        result = classify(["spec/Spec/C1.lean"])
        self.assertTrue(result["spec_check"])
        self.assertTrue(result["spec_build"])
        self.assertFalse(result["lean_build"])

    def test_spec_tracking_file(self):
        result = classify(["docs/suivi/primitives.md"])
        self.assertTrue(result["docs_links"])
        self.assertTrue(result["spec_check"])
        self.assertFalse(result["spec_build"])

    def test_ci_change_forces_full(self):
        result = classify([".github/workflows/ci.yaml"])
        self.assertTrue(result["full"])
        self.assertTrue(result["spec_build"])
        self.assertTrue(result["lean_build"])

    def test_unknown_path_forces_full(self):
        result = classify(["new-format.toml"])
        self.assertTrue(result["full"])
        self.assertTrue(result["unclassified"])

    def test_mixed_surfaces_are_unioned(self):
        result = classify(["src/K7pl/Foo.lean", "docs/foo.md", "spec/Spec/C2.lean"])
        self.assertTrue(result["lean_build"])
        self.assertTrue(result["spec_build"])
        self.assertTrue(result["docs_links"])
        self.assertFalse(result["full"])

    def test_full_flag_dominates(self):
        result = classify(["docs/foo.md"], force_full=True)
        self.assertTrue(all(result[key] for key in ("full", "docs_links", "spec_check", "spec_build", "lean_build")))


if __name__ == "__main__":
    unittest.main()