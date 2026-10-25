#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Writes `changed=true` to GITHUB_OUTPUT when the working tree's wiki/STATUS.md differs from the
# index (scripts/generate_status.py rewrote it), `changed=false` otherwise.
#
# Called by: .github/workflows/ci.yaml, job `status`, step "Check for generated changes" (id
# `changes`), from the repository root, after "Generate STATUS.md".
# Environment: GITHUB_OUTPUT (set by the runner).
#
#   bash scripts/ci/ci_status_changes.sh
set -euo pipefail

if git diff --quiet -- wiki/STATUS.md; then
  echo "changed=false" >> "$GITHUB_OUTPUT"
else
  echo "changed=true" >> "$GITHUB_OUTPUT"
fi
