#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Build a minimal SARIF report from a BadgeApp criteria drift report.

The drift report is the JSON written by
``check_badge_proposals.py --check-upstream --report``. The SARIF
is what surfaces the finding in the repository's Security tab
(Code Scanning) via ``github/codeql-action/upload-sarif``; the
drift script also writes the human-readable report as an
artifact, and the job itself fails on drift or on an
unavailable check (F3, owner decision 2026-10-25).

One result per drifted blob or per check error, located at the
pinned registry file: the registry is the artefact that is
stale, and updating it deliberately is the only fix. An
unchanged report produces a SARIF with no results, so the
upload step still runs and closes any previous alert.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path

REGISTRY_LOCATION = "scripts/ci/badge_criteria_registry.json"
TOOL_NAME = "BadgeApp criteria drift"
TOOL_URI = "https://github.com/ossf/best-practices-badge"

RULES = [
    {
        "id": "badge-criteria-drift",
        "name": "BadgeCriteriaDrift",
        "shortDescription": {"text": "OpenSSF BadgeApp criteria changed upstream"},
        "fullDescription": {
            "text": "A pinned BadgeApp criteria blob differs from upstream. "
            "The pinned registry is stale; update it deliberately, "
            "never automatically."
        },
        "defaultConfiguration": {"level": "error"},
        "help": {
            "text": "Review the drift report artifact and update "
            "scripts/ci/badge_criteria_registry.json deliberately."
        },
    },
    {
        "id": "badge-criteria-unavailable",
        "name": "BadgeCriteriaUnavailable",
        "shortDescription": {"text": "OpenSSF BadgeApp criteria drift could not be verified"},
        "fullDescription": {
            "text": "The upstream check failed, so the pinned registry "
            "cannot be shown to be current. This is not evidence "
            "that the criteria are unchanged."
        },
        "defaultConfiguration": {"level": "warning"},
        "help": {"text": "Inspect the drift report and retry the check."},
    },
]


def build_sarif(report: dict) -> dict:
    results = []
    for item in report.get("drift", []):
        results.append(
            {
                "ruleId": "badge-criteria-drift",
                "level": "error",
                "message": {
                    "text": "BadgeApp criteria blob changed upstream for "
                    f"{item.get('path')}: pinned "
                    f"{item.get('expected_blob_sha')}, observed "
                    f"{item.get('observed_blob_sha')}."
                },
                "locations": [
                    {
                        "physicalLocation": {
                            "artifactLocation": {"uri": REGISTRY_LOCATION},
                            "region": {"startLine": 1},
                        }
                    }
                ],
            }
        )
    for item in report.get("errors", []):
        results.append(
            {
                "ruleId": "badge-criteria-unavailable",
                "level": "warning",
                "message": {
                    "text": "Could not verify BadgeApp criteria for "
                    f"{item.get('path')}: {item.get('error')}."
                },
                "locations": [
                    {
                        "physicalLocation": {
                            "artifactLocation": {"uri": REGISTRY_LOCATION},
                            "region": {"startLine": 1},
                        }
                    }
                ],
            }
        )
    return {
        "$schema": "https://json.schemastore.org/sarif-2.1.0.json",
        "version": "2.1.0",
        "runs": [
            {
                "tool": {
                    "driver": {
                        "name": TOOL_NAME,
                        "informationUri": TOOL_URI,
                        "rules": RULES,
                    }
                },
                "results": results,
            }
        ],
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--report", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args(argv)
    report = json.loads(args.report.read_text(encoding="utf-8"))
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(build_sarif(report), ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
