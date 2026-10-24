#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Download an axiom report only when it proves the exact checked-out main commit.
# On a push, the K7PL formal-semantics workflow may still be running: absence is recorded
# as unavailable and a workflow_run event retries status generation when that run completes.
set -euo pipefail

: "${EVENT_NAME:?EVENT_NAME is required}"
: "${SOURCE_SHA:?SOURCE_SHA is required}"
: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"
: "${RUNNER_TEMP:?RUNNER_TEMP is required}"
: "${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}"
: "${GH_TOKEN:?GH_TOKEN is required}"
: "${CURRENT_SHA:?CURRENT_SHA is required}"

if [[ ! "$SOURCE_SHA" =~ ^[0-9a-f]{40}$ || ! "$CURRENT_SHA" =~ ^[0-9a-f]{40}$ ]]; then
  echo "::error::Source and current commit identifiers must be full 40-character SHA-1 values."
  exit 1
fi

if [ "$EVENT_NAME" = "workflow_dispatch" ] && [ "$SOURCE_SHA" != "$CURRENT_SHA" ]; then
  git fetch --no-tags origin "$SOURCE_SHA" >/dev/null 2>&1 || {
    echo "::error::Could not fetch the audited source commit $SOURCE_SHA."
    exit 1
  }
  git merge-base --is-ancestor "$SOURCE_SHA" "$CURRENT_SHA" || {
    echo "::error::The audited commit $SOURCE_SHA is not an ancestor of $CURRENT_SHA."
    exit 1
  }
  changed="$(git diff --name-only "$SOURCE_SHA" "$CURRENT_SHA" -- . ':(exclude)docs/STATUS.md')"
  if [ -n "$changed" ]; then
    echo "::error::The audited commit is stale relative to substantive changes in $CURRENT_SHA:"
    printf '%s\\n' "$changed"
    exit 1
  fi
fi

out="$RUNNER_TEMP/k7pl-axiom-evidence"
report="$RUNNER_TEMP/k7pl-axiom-audit.json"
rm -rf "$out" "$report"
mkdir -p "$out"
candidate_run=""
expected_sha="$SOURCE_SHA"

if [ "$EVENT_NAME" = "workflow_run" ]; then
  : "${UPSTREAM_RUN_ID:?UPSTREAM_RUN_ID is required for workflow_run}"
  : "${UPSTREAM_HEAD_SHA:?UPSTREAM_HEAD_SHA is required for workflow_run}"
  : "${UPSTREAM_CONCLUSION:?UPSTREAM_CONCLUSION is required for workflow_run}"
  if [ "$UPSTREAM_CONCLUSION" != "success" ] || [ "$UPSTREAM_HEAD_SHA" != "$SOURCE_SHA" ]; then
    echo "available=false" >> "$GITHUB_OUTPUT"
    echo "report_path=" >> "$GITHUB_OUTPUT"
    echo "No current-commit axiom evidence: upstream conclusion=$UPSTREAM_CONCLUSION, head=$UPSTREAM_HEAD_SHA, checked-out commit=$SOURCE_SHA."
    exit 0
  fi
  candidate_run="$UPSTREAM_RUN_ID"
else
  # On a push, the formal semantics workflow can finish before or after the root CI workflow.
  # Select only a successful run for this exact commit; PR runs and stale evidence do not qualify.
  runs="$(gh run list --repo "$GITHUB_REPOSITORY" --workflow k7pl-semantics.yaml --branch main --commit "$SOURCE_SHA" --limit 30 --json databaseId,status,conclusion,headSha)"
  candidate_run="$(printf '%s' "$runs" | jq -r --arg sha "$SOURCE_SHA" '[.[] | select(.headSha == $sha and .status == "completed" and .conclusion == "success")][0].databaseId // empty')"

  # The trusted status-dispatch job runs as the final job of the formal-semantics workflow. The
  # workflow itself may still be marked in_progress when this dispatched CI starts, so poll briefly
  # for its completed result rather than misreporting its just-produced artifact as absent.
  if [ -z "$candidate_run" ] && [ "$EVENT_NAME" = "workflow_dispatch" ]; then
    for attempt in $(seq 1 36); do
      runs="$(gh run list --repo "$GITHUB_REPOSITORY" --workflow k7pl-semantics.yaml --branch main --commit "$SOURCE_SHA" --limit 30 --json databaseId,status,conclusion,headSha)"
      candidate_run="$(printf '%s' "$runs" | jq -r --arg sha "$SOURCE_SHA" '[.[] | select(.headSha == $sha and .status == "completed" and .conclusion == "success")][0].databaseId // empty')"
      [ -n "$candidate_run" ] && break
      active_run="$(printf '%s' "$runs" | jq -r --arg sha "$SOURCE_SHA" '[.[] | select(.headSha == $sha and .status != "completed")][0].databaseId // empty')"
      [ -z "$active_run" ] && break
      echo "Waiting for matching formal-semantics run $active_run to finish (attempt $attempt/36)."
      sleep 5
    done
  fi
fi

if [ -z "$candidate_run" ]; then
  echo "available=false" >> "$GITHUB_OUTPUT"
  echo "report_path=" >> "$GITHUB_OUTPUT"
  echo "No completed successful K7PL formal-semantics run has published an axiom report for $SOURCE_SHA yet."
  exit 0
fi

if ! gh run download "$candidate_run" --repo "$GITHUB_REPOSITORY" --name "k7pl-axiom-audit-$candidate_run" --dir "$out"; then
  if [ "$EVENT_NAME" = "workflow_run" ]; then
    echo "::error::K7PL formal-semantics run $candidate_run succeeded for $SOURCE_SHA but its required axiom audit artifact could not be downloaded."
    exit 1
  fi
  echo "available=false" >> "$GITHUB_OUTPUT"
  echo "report_path=" >> "$GITHUB_OUTPUT"
  echo "A successful run was listed but its standalone audit artifact is not available yet."
  exit 0
fi

if [ ! -s "$out/k7pl-axiom-audit.json" ]; then
  echo "::error::The downloaded K7PL axiom audit artifact has no k7pl-axiom-audit.json."
  exit 1
fi
cp "$out/k7pl-axiom-audit.json" "$report"
echo "available=true" >> "$GITHUB_OUTPUT"
echo "report_path=$report" >> "$GITHUB_OUTPUT"
echo "Downloaded axiom dependency evidence from K7PL formal-semantics run $candidate_run for commit $SOURCE_SHA."
