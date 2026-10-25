#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Writes `current=true` when wiki/STATUS.md covers the substantive commit and, when
# REQUIRE_AXIOM_AUDIT=true, includes PASS evidence for the current GITHUB_SHA. This lets a
# successful K7PL formal-semantics workflow refresh a status generated before its evidence existed.
#
# Called by: .github/workflows/ci.yaml, job `status`, step "Check whether STATUS already covers
# the current history" (id `baseline`), from the repository root of a full-history checkout whose
# credentials are kept (the `git fetch` uses them).
# Environment: GITHUB_SHA, GITHUB_OUTPUT (set by the runner); optional REQUIRE_AXIOM_AUDIT=true.
#
#   bash scripts/ci/ci_status_baseline.sh
set -euo pipefail

generated_for="$(sed -n 's/^\*\*Generated for commit:\*\* \([0-9a-f]\{40\}\)$/\1/p' wiki/STATUS.md)"
current=false
if [ -n "$generated_for" ] \
  && git fetch --no-tags origin "$generated_for" >/dev/null 2>&1 \
  && git merge-base --is-ancestor "$generated_for" "$GITHUB_SHA" \
  && [ -z "$(git diff --name-only "$generated_for" "$GITHUB_SHA" -- . ':(exclude)wiki/STATUS.md')" ]; then
  current=true
fi

if [ "$current" = true ] && [ "${REQUIRE_AXIOM_AUDIT:-false}" = "true" ]; then
  evidence_sha="${STATUS_EVIDENCE_SHA:-$GITHUB_SHA}"
  if [[ ! "$evidence_sha" =~ ^[0-9a-f]{40}$ ]] \
    || ! git fetch --no-tags origin "$evidence_sha" >/dev/null 2>&1 \
    || ! git merge-base --is-ancestor "$evidence_sha" "$GITHUB_SHA" \
    || [ -n "$(git diff --name-only "$evidence_sha" "$GITHUB_SHA" -- . ':(exclude)wiki/STATUS.md')" ] \
    || ! grep -Fxq "**Axiom audit evidence for commit:** $evidence_sha" wiki/STATUS.md \
    || ! grep -Fxq "**Axiom audit status:** PASS" wiki/STATUS.md; then
    current=false
  fi
fi

echo "current=$current" >> "$GITHUB_OUTPUT"
if [ "$current" = true ]; then
  echo "STATUS already describes the latest substantive commit ($generated_for); only wiki/STATUS.md changed afterwards."
else
  echo "STATUS regeneration required."
fi
