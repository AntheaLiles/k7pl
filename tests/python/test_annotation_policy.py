# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

from __future__ import annotations

import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def load(name: str) -> dict:
    return json.loads((ROOT / ".github" / name).read_text(encoding="utf-8"))


def matcher_expression(name: str) -> re.Pattern[str]:
    payload = load(name)
    pattern = payload["problemMatcher"][0]["pattern"][0]
    return re.compile(pattern["regexp"])


def test_annotation_policy_prioritizes_specification():
    policy = load("annotation-policy.json")
    assert policy["priorities"]["P0"] == {
        "surface": "specification",
        "error": "annotate",
        "warning": "annotate-major",
    }
    assert policy["priorities"]["P1"]["warning"] == "report-only"
    assert policy["priorities"]["P2"]["warning"] == "report-only"
    assert policy["default"] == "report-only"


def test_lean_error_matcher_excludes_warnings():
    expression = matcher_expression("lean-problem-matcher.json")
    assert expression.fullmatch(
        "spec/Spec/C3/ReglesDeTypage.lean:1598:37: error: expected identifier"
    )
    assert not expression.fullmatch(
        "spec/Spec/C3/ReglesDeTypage.lean:1598:37: warning: declaration uses 'sorry'"
    )


def test_specification_warning_matcher_matches_only_warnings():
    expression = matcher_expression("lean-spec-warning-problem-matcher.json")
    assert expression.fullmatch(
        "spec/Spec/C3/ReglesDeTypage.lean:1598:37: warning: declaration uses 'sorry'"
    )
    assert not expression.fullmatch(
        "spec/Spec/C3/ReglesDeTypage.lean:1598:37: error: expected identifier"
    )
