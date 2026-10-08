# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

from __future__ import annotations

import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
MATCHER = ROOT / ".github" / "reuse-problem-matcher.json"


def test_reuse_problem_matcher_is_scoped_to_reuse_lines_output():
    payload = json.loads(MATCHER.read_text(encoding="utf-8"))
    problem = payload["problemMatcher"][0]
    assert problem["severity"] == "error"
    expression = re.compile(problem["pattern"][0]["regexp"])

    cases = (
        ("scripts/controle.py: no license identifier", "scripts/controle.py", "no license identifier"),
        ("LICENSES/CECILL-2.1: bad license 'CECILL-2.1'", "LICENSES/CECILL-2.1", "bad license 'CECILL-2.1'"),
        ("README.md: invalid SPDX License Expression 'GPL-3.0'", "README.md", "invalid SPDX License Expression 'GPL-3.0'"),
    )

    for text, expected_file, expected_message in cases:
        match = expression.fullmatch(text)
        assert match is not None
        assert match.group(1) == expected_file
        assert match.group(2) == expected_message


def test_reuse_problem_matcher_does_not_capture_summary_lines():
    expression = re.compile(
        json.loads(MATCHER.read_text(encoding="utf-8"))["problemMatcher"][0]["pattern"][0]["regexp"]
    )

    for text in (
        "# SUMMARY",
        "* Missing licenses: 0",
        "Congratulations! Your project is compliant with version 3.3 of the REUSE Specification :-)",
    ):
        assert expression.fullmatch(text) is None
