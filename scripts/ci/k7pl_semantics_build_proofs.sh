#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Builds K7PL2Lean and K7PL in the proof project and audits the build log: it must not contain
# sorryAx, and it must report the axioms of the two machine-soundness theorems.
#
# Called by: .github/workflows/k7pl-semantics.yaml, job `k-smoke`, step "Build the Klean-generated
# Lean project", with working-directory `proofs`.
# Environment: RUNNER_TEMP (set by the runner).
#
#   bash "$GITHUB_WORKSPACE/scripts/ci/k7pl_semantics_build_proofs.sh"
set -euo pipefail

lean --version
lake --version
BUILD_LOG="$RUNNER_TEMP/k7pl-lake-build.log"
lake build K7PL2Lean K7PL 2>&1 | tee "$BUILD_LOG"
if grep -Fq "sorryAx" "$BUILD_LOG"; then
  echo "::error::Lean axiom audit found sorryAx in the build output."
  exit 1
fi
grep -Fq "'K7PL.MachineSoundness.rewrites_preserve_machine_typing' depends on axioms:" "$BUILD_LOG" || {
  echo "::error::Missing axiom audit for rewrites_preserve_machine_typing." >&2
  exit 1
}
grep -Fq "'K7PL.MachineSoundness.end_to_end_preservation' depends on axioms:" "$BUILD_LOG" || {
  echo "::error::Missing axiom audit for end_to_end_preservation." >&2
  exit 1
}

for declaration in \
  "K7PL.Bridge.add_root_is_klean_rewrite" \
  "K7PL.Bridge.less_than_root_is_klean_rewrite" \
  "K7PL.Bridge.select_true_root_is_klean_rewrite" \
  "K7PL.Bridge.select_false_root_is_klean_rewrite" \
  "K7PL.NativeBoundary.enforcedBoundary_step_preserves_protected" \
  "K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected" \
  "K7PL.NativeBoundary.unconfined_native_write_counterexample" \
  "K7PL.NativeBoundary.unconfined_native_write_trace_replay"; do
  grep -Fq "'$declaration' depends on axioms:" "$BUILD_LOG" || {
    echo "::error::Missing axiom audit for $declaration." >&2
    exit 1
  }
done
