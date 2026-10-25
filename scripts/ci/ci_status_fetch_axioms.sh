#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Download an axiom report only when it proves the exact source commit requested by trusted CI.
# On a push, the formal-semantics workflow may still be running; the successful workflow's
# narrowly permissioned dispatch retries status generation after that workflow completes.
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
  changed="$(git diff --name-only "$SOURCE_SHA" "$CURRENT_SHA" -- . ':(exclude)wiki/STATUS.md')"
  if [ -n "$changed" ]; then
    echo "::error::The audited commit is stale relative to substantive changes in $CURRENT_SHA:"
    printf '%s\n' "$changed"
    exit 1
  fi
fi

out="$RUNNER_TEMP/k7pl-axiom-evidence"
report="$RUNNER_TEMP/k7pl-axiom-audit.json"
rm -rf "$out" "$report"
mkdir -p "$out"
candidate_run=""

# Select only a successful formal-semantics run for the exact source commit.
# Pull-request runs and stale evidence do not qualify.
runs="$(gh run list --repo "$GITHUB_REPOSITORY" --workflow k7pl-semantics.yaml --branch main --commit "$SOURCE_SHA" --limit 30 --json databaseId,status,conclusion,headSha)"
candidate_run="$(printf '%s' "$runs" | jq -r --arg sha "$SOURCE_SHA" '[.[] | select(.headSha == $sha and .status == "completed" and .conclusion == "success")][0].databaseId // empty')"

# The final status-dispatch job can launch CI before the enclosing workflow has switched to
# completed. Poll briefly so the workflow can finish and publish its standalone audit artifact.
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

if [ -z "$candidate_run" ]; then
  echo "available=false" >> "$GITHUB_OUTPUT"
  echo "report_path=" >> "$GITHUB_OUTPUT"
  echo "No completed successful K7PL formal-semantics run has published an axiom report for $SOURCE_SHA yet."
  exit 0
fi

if ! gh run download "$candidate_run" --repo "$GITHUB_REPOSITORY" --name "k7pl-axiom-audit-$candidate_run" --dir "$out"; then
  echo "::error::K7PL formal-semantics run $candidate_run succeeded for $SOURCE_SHA but its required axiom audit artifact could not be downloaded."
  exit 1
fi

if [ ! -s "$out/k7pl-axiom-audit.json" ]; then
  echo "::error::The downloaded K7PL axiom audit artifact has no k7pl-axiom-audit.json."
  exit 1
fi
cp "$out/k7pl-axiom-audit.json" "$report"
echo "available=true" >> "$GITHUB_OUTPUT"
echo "report_path=$report" >> "$GITHUB_OUTPUT"
echo "Downloaded axiom dependency evidence from K7PL formal-semantics run $candidate_run for commit $SOURCE_SHA."
