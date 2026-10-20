#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Fails unless GITHUB_SHA carries a successful `CI OK` check run posted by GitHub Actions (another
# app could post a run with that name).
#
# Called by: .github/workflows/release.yaml, job `check` (checks: read), step "Check that CI OK
# succeeded on the tagged commit".
# Environment: GH_TOKEN (step `env`, the job's read-only GITHUB_TOKEN), GH_REPO (job `env`),
# GITHUB_SHA (set by the runner).
#
#   bash scripts/ci/release_check_ci_ok.sh
set -euo pipefail

count="$(gh api --paginate "repos/$GH_REPO/commits/$GITHUB_SHA/check-runs?per_page=100" \
  --jq '.check_runs[] | select(.name == "CI OK" and .conclusion == "success" and .app.slug == "github-actions") | .id' \
  | wc -l)"
if [ "$count" -lt 1 ]; then
  echo "::error::no successful 'CI OK' check run from GitHub Actions on $GITHUB_SHA"
  exit 1
fi
echo "CI OK succeeded on $GITHUB_SHA."
