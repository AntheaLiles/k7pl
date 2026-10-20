#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Opens the pull request automation/generated-status -> main unless one is already open (the
# force-push of the previous step updated it).
#
# Called by: .github/workflows/ci.yaml, job `status` (pull-requests: write), step "Open or update
# status pull request", from the repository root.
# Environment: GH_TOKEN (step `env`, the job's GITHUB_TOKEN), used by gh.
#
#   bash scripts/ci/ci_status_pull_request.sh
set -euo pipefail

count="$(gh pr list --head automation/generated-status --base main --state open --json number --jq 'length')"
if [ "$count" -eq 0 ]; then
  gh pr create \
    --base main \
    --head automation/generated-status \
    --title "ci: update generated project status" \
    --body "Automated update of docs/STATUS.md from the CI verification gate. This file is generated; no manual status editing is required."
fi
