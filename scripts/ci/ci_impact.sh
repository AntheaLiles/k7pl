#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Runs the impact classifier (scripts/ci/impact.py, which writes the surfaces to GITHUB_OUTPUT) on
# the right range for the event:
#   - workflow_dispatch on automation/generated-status (dispatched by the `status` job): the
#     branch is classified against origin/main, as a pull request would be; a commit already on
#     main gets the full validation; no shared history fails;
#   - any other workflow_dispatch: the full validation;
#   - pull_request and push: BASE_SHA..HEAD_SHA.
# The base comes from the checkout (full history), never from an input.
#
# Called by: .github/workflows/ci.yaml, job `impact`, step "Run CI impact classifier" (id
# `impact`), from the repository root.
# Environment: EVENT_NAME, REF, BASE_SHA, HEAD_SHA (step `env`); GITHUB_OUTPUT (set by the runner).
#
#   bash scripts/ci/ci_impact.sh
set -euo pipefail

if [ "$EVENT_NAME" = "workflow_dispatch" ] && [ "$REF" = "refs/heads/automation/generated-status" ]; then
  git rev-parse --verify --quiet refs/remotes/origin/main > /dev/null || {
    echo "::error::origin/main is not available in the checkout"
    exit 1
  }
  if git merge-base --is-ancestor "$HEAD_SHA" refs/remotes/origin/main; then
    python3 scripts/ci/impact.py --force-full
  else
    # Fails, and so fails `CI OK`, when the branch shares no history with main.
    base="$(git merge-base refs/remotes/origin/main "$HEAD_SHA")"
    python3 scripts/ci/impact.py --base "$base" --head "$HEAD_SHA"
  fi
elif [ "$EVENT_NAME" = "workflow_dispatch" ]; then
  python3 scripts/ci/impact.py --force-full
else
  python3 scripts/ci/impact.py --base "$BASE_SHA" --head "$HEAD_SHA"
fi
