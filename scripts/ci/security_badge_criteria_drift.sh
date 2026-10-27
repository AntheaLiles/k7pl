#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Compares the pinned OpenSSF BadgeApp criteria registry with upstream
# (scripts/ci/check_badge_proposals.py --check-upstream), writes the report to
# $RUNNER_TEMP/badge-criteria-drift.json for the upload step, a minimal SARIF
# report to $RUNNER_TEMP/badge-criteria-drift.sarif for the Code Scanning
# upload step, and states the outcome in the job summary.
#
# F3, owner decision 2026-10-25: this script FAILS on drift and on an
# unavailable check (exit 1 for drift, 2 for unavailable, 0 unchanged).
# It never modifies the registry: a drift is fixed by a deliberate manual
# update of the pinned registry, after review of the report.
#
# Called by: .github/workflows/security.yaml, job `badge-criteria-drift` (schedule and manual
# runs only), step "Compare pinned criteria blob IDs with upstream", from the repository root.
# Environment: RUNNER_TEMP, GITHUB_STEP_SUMMARY (set by the runner).
#
#   bash scripts/ci/security_badge_criteria_drift.sh
set -euo pipefail

REPORT="${RUNNER_TEMP:-/tmp}/badge-criteria-drift.json"
SARIF="${RUNNER_TEMP:-/tmp}/badge-criteria-drift.sarif"
SUMMARY="${GITHUB_STEP_SUMMARY:-/dev/null}"

set +e
python3 scripts/ci/check_badge_proposals.py --check-upstream --report "$REPORT"
result=$?
set -e

if [ -f "$REPORT" ]; then
  # Reporting must not mask the verdict: a SARIF failure is
  # annotated, and the upload step (always()) fails on a missing
  # file, but the script's exit status stays the check's result.
  python3 scripts/ci/badge_criteria_drift_sarif.py --report "$REPORT" --output "$SARIF" || echo "::error::Failed to generate BadgeApp drift SARIF."
else
  echo "::error::BadgeApp criteria drift report was not produced; no SARIF to upload."
  exit 1
fi

if [ "$result" -eq 0 ]; then
  echo "OpenSSF BadgeApp criteria are unchanged from the pinned registry." >> "$SUMMARY"
elif [ "$result" -eq 1 ]; then
  echo "::error::OpenSSF BadgeApp criteria changed upstream; review the report and update the registry deliberately."
  echo "**Upstream criteria drift detected.** The pinned registry was not modified." >> "$SUMMARY"
else
  echo "::error::Could not verify OpenSSF BadgeApp criteria drift; inspect the report and retry."
  echo "**Upstream check unavailable.** This is not evidence that the criteria are unchanged." >> "$SUMMARY"
fi
exit "$result"
