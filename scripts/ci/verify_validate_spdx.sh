#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Validates the two SPDX 2.3 documents written by the previous step with the hash-locked
# spdx-tools validator (scripts/ci/validate_spdx.py), checks both reports, and writes the job
# summary. The reports are written next to the documents, in RUNNER_TEMP, for the upload step.
#
# Called by: .github/workflows/verify.yaml, job `python-tests`, step "Validate SPDX 2.3 with
# spdx-tools", from the repository root, after "Generate deterministic SPDX 2.3 validation input".
# Environment: RUNNER_TEMP, GITHUB_STEP_SUMMARY (set by the runner).
#
#   bash scripts/ci/verify_validate_spdx.sh
set -euo pipefail

for name in k7pl-spdx-validation k7pl-paperproof-export-spdx-validation; do
  python3 scripts/ci/validate_spdx.py "$RUNNER_TEMP/$name.spdx.json" > "$RUNNER_TEMP/$name.json"
done
python3 - "$RUNNER_TEMP/k7pl-spdx-validation.json" \
  "$RUNNER_TEMP/k7pl-paperproof-export-spdx-validation.json" <<'PY'
import json
import os
import sys

reports = []
for path in sys.argv[1:]:
    with open(path, encoding="utf-8") as stream:
        report = json.load(stream)
    assert report["schemaVersion"] == "k7pl.spdx-validation/v1", report
    assert report["status"] == "PASS", report
    assert report["validator"]["name"] == "spdx-tools", report
    assert report["validator"]["version"] == "0.8.5", report
    assert report["diagnostics"] == [], report
    assert len(report["input"]["sha256"]) == 64, report
    assert isinstance(report["elapsedMs"], (int, float)), report
    assert isinstance(report["validator"]["elapsedMs"], (int, float)), report
    reports.append(report)
print("Independent SPDX 2.3 validator: PASS (spdx-tools 0.8.5)")
report, paperproof = reports
with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as summary:
    summary.write("### Independent SPDX 2.3 validation\n")
    summary.write("- Validator: `spdx-tools 0.8.5` (hash-locked runtime closure).\n")
    summary.write("- Result: PASS; generated JSON validated against SPDX 2.3.\n")
    summary.write("- SBOM SHA-256: `" + report["input"]["sha256"] + "`\n")
    summary.write("- Wrapper elapsed: `" + str(report["elapsedMs"]) + " ms`; validator subprocess: `" + str(report["validator"]["elapsedMs"]) + " ms`.\n")
    summary.write("- Separate document of the Paperproof workspace: PASS; SHA-256 `" + paperproof["input"]["sha256"] + "`\n")
PY
