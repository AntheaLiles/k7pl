#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Writes current (the toolchain of lean-toolchain), latest (the latest release shared by Lean,
# Mathlib, CSLib and Verso, from scripts/latest-lean-version.sh) and newer (true when latest sorts
# after current) to GITHUB_OUTPUT, and states both toolchains, with the Paperproof workspace's (not
# bumped), in the job summary.
#
# Called by: .github/workflows/bump-lean.yaml, job `build` (no secret), step "Find the latest common
# release" (id `version`), from the repository root.
# Environment: PAPERPROOF_WORKSPACE (workflow `env`); GITHUB_OUTPUT, GITHUB_STEP_SUMMARY (set by the
# runner).
#
#   bash scripts/ci/bump_lean_find_version.sh
set -euo pipefail

current="$(cut -d: -f2 lean-toolchain)"
latest="$(scripts/latest-lean-version.sh)"
echo "current=$current" >> "$GITHUB_OUTPUT"
echo "latest=$latest" >> "$GITHUB_OUTPUT"
if [ "$latest" != "$current" ] && \
   [ "$(printf '%s\n%s\n' "$current" "$latest" | sort -V | tail -n 1)" = "$latest" ]; then
  echo "newer=true" >> "$GITHUB_OUTPUT"
else
  echo "newer=false" >> "$GITHUB_OUTPUT"
fi
{
  echo "### Lean toolchains"
  echo "- K7PL (root workspace): \`$current\`; latest common release: \`$latest\`"
  echo "- Paperproof extraction workspace (\`$PAPERPROOF_WORKSPACE\`, not bumped): \`$(cat "$PAPERPROOF_WORKSPACE/lean-toolchain")\`"
} >> "$GITHUB_STEP_SUMMARY"
