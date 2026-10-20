#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Compares the pinned OpenSSF BadgeApp criteria registry with upstream
# (scripts/ci/check_badge_proposals.py --check-upstream), writes the report to
# $RUNNER_TEMP/badge-criteria-drift.json for the upload step, and states the outcome in the job
# summary: 0 unchanged; 1 drift (warning); anything else, check unavailable (warning, which is not
# evidence that the criteria are unchanged). Informative only: it always exits 0 and never
# modifies the registry.
#
# Called by: .github/workflows/security.yaml, job `badge-criteria-drift` (schedule and manual
# runs only), step "Compare pinned criteria blob IDs with upstream", from the repository root.
# Environment: RUNNER_TEMP, GITHUB_STEP_SUMMARY (set by the runner).
#
#   bash scripts/ci/security_badge_criteria_drift.sh
set -euo pipefail

# The step must not fail: the exit status of the check is read, not enforced.
set +e
python3 scripts/ci/check_badge_proposals.py --check-upstream --report "$RUNNER_TEMP/badge-criteria-drift.json"
result=$?
if [ "$result" -eq 0 ]; then
  echo "OpenSSF BadgeApp criteria are unchanged from the pinned registry." >> "$GITHUB_STEP_SUMMARY"
elif [ "$result" -eq 1 ]; then
  echo "::warning::OpenSSF BadgeApp criteria changed upstream; review the report and update the registry deliberately."
  echo "**Upstream criteria drift detected.** The pinned registry was not modified." >> "$GITHUB_STEP_SUMMARY"
else
  echo "::warning::Could not verify OpenSSF BadgeApp criteria drift; inspect the report and retry."
  echo "**Upstream check unavailable.** This is not evidence that the criteria are unchanged." >> "$GITHUB_STEP_SUMMARY"
fi
exit 0
