#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Writes `current=true` to GITHUB_OUTPUT when docs/STATUS.md was generated for an ancestor of
# GITHUB_SHA and only docs/STATUS.md changed since that commit, `current=false` otherwise (no
# `Generated for commit:` line, commit not fetchable or not an ancestor, other changes).
#
# Called by: .github/workflows/ci.yaml, job `status`, step "Check whether STATUS already covers
# the current history" (id `baseline`), from the repository root of a full-history checkout whose
# credentials are kept (the `git fetch` uses them).
# Environment: GITHUB_SHA, GITHUB_OUTPUT (set by the runner).
#
#   bash scripts/ci/ci_status_baseline.sh
set -euo pipefail

generated_for="$(sed -n 's/^\*\*Generated for commit:\*\* \([0-9a-f]\{40\}\)$/\1/p' docs/STATUS.md)"
if [ -n "$generated_for" ] \
  && git fetch --no-tags origin "$generated_for" >/dev/null 2>&1 \
  && git merge-base --is-ancestor "$generated_for" "$GITHUB_SHA" \
  && [ -z "$(git diff --name-only "$generated_for" "$GITHUB_SHA" -- . ':(exclude)docs/STATUS.md')" ]; then
  echo "current=true" >> "$GITHUB_OUTPUT"
  echo "STATUS already describes the latest substantive commit ($generated_for); only docs/STATUS.md changed afterwards."
else
  echo "current=false" >> "$GITHUB_OUTPUT"
fi
