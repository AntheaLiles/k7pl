#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Writes `epoch=<commit date of HEAD, in seconds>` to GITHUB_OUTPUT, and fails when git does not
# return a plain number. The `spec` job hands it to `spec-pdf` (which has no checkout) as
# SOURCE_DATE_EPOCH. On a `pull_request` event the checkout is GitHub's synthetic merge commit, so
# the date is that of the merge computation, not of the last commit of the branch.
#
# Called by: .github/workflows/verify.yaml, job `spec`, step "Record the commit date of the
# source" (id `source-date`), from the repository root.
# Environment: GITHUB_OUTPUT (set by the runner).
#
#   bash scripts/ci/verify_source_date_epoch.sh
set -euo pipefail

epoch="$(git log -1 --format=%ct)"
case "$epoch" in
  ''|*[!0-9]*)
    echo "::error::unexpected commit date: '$epoch'"
    exit 1
    ;;
esac
echo "epoch=$epoch" >> "$GITHUB_OUTPUT"
