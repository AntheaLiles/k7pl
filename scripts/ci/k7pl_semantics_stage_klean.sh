#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Copies the Klean-generated K7PL2Lean modules into proofs/ (ignored by Git), replacing any earlier
# copy, and fails unless proofs/lean-toolchain is leanprover/lean4:v4.34.0.
#
# Called by: .github/workflows/k7pl-semantics.yaml, job `k-smoke`, step "Stage generated Klean
# modules into the maintained proof project", after the export and the compatibility shim.
# Environment: RUNNER_TEMP, GITHUB_WORKSPACE (set by the runner).
#
#   bash scripts/ci/k7pl_semantics_stage_klean.sh
set -euo pipefail

PACKAGE="$RUNNER_TEMP/klean-output/k7pl2lean"
PROOF_ROOT="$GITHUB_WORKSPACE/proofs"
rm -rf "$PROOF_ROOT/K7PL2Lean" "$PROOF_ROOT/K7PL2Lean.lean"
cp -a "$PACKAGE/K7PL2Lean" "$PROOF_ROOT/K7PL2Lean"
cp "$PACKAGE/K7PL2Lean.lean" "$PROOF_ROOT/K7PL2Lean.lean"
test "$(cat "$PROOF_ROOT/lean-toolchain")" = "leanprover/lean4:v4.34.0"
echo "Staged generated Klean sources into proofs/ (ignored by Git)."
