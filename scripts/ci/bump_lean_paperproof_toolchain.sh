#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Writes toolchain=<the Paperproof workspace's lean-toolchain> to GITHUB_OUTPUT, for the pull
# request body only, after checking that it is a plain leanprover/lean4:vX.Y.Z name.
#
# Called by: .github/workflows/bump-lean.yaml, job `open-pr`, step "Record the toolchain of the
# Paperproof workspace (not bumped)" (id `paperproof`), from the root of the clean checkout.
# Environment: PAPERPROOF_WORKSPACE (workflow `env`); GITHUB_OUTPUT (set by the runner).
#
#   bash scripts/ci/bump_lean_paperproof_toolchain.sh
set -euo pipefail

toolchain="$(cat "$PAPERPROOF_WORKSPACE/lean-toolchain")"
[[ "$toolchain" =~ ^leanprover/lean4:v[0-9]+\.[0-9]+\.[0-9]+$ ]] || {
  echo "::error::unexpected toolchain in $PAPERPROOF_WORKSPACE/lean-toolchain: '$toolchain'"
  exit 1
}
echo "toolchain=$toolchain" >> "$GITHUB_OUTPUT"
