#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Commits the regenerated docs/STATUS.md on automation/generated-status, as github-actions[bot],
# and force-pushes that branch to origin with the credentials that the checkout kept. Nothing but
# docs/STATUS.md is staged.
#
# Called by: .github/workflows/ci.yaml, job `status` (contents: write), step "Publish generated
# status branch", from the repository root, when the previous step found a change.
#
#   bash scripts/ci/ci_status_publish.sh
set -euo pipefail

git switch -C automation/generated-status
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add docs/STATUS.md
git commit -m "ci: update generated project status"
git push --force origin automation/generated-status
