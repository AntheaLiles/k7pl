#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Exports the compiled K definition (src/k/.build/kompiled) to a Lean package with Klean, in
# $RUNNER_TEMP/klean-output/k7pl2lean; replaces the generated lean-toolchain with the repository's
# one; fails when an expected generated file is missing or empty; records the generated file list
# and toolchain in .formal-chain-evidence/ and in the job summary.
#
# Called by: .github/workflows/k7pl-semantics.yaml, job `k-smoke`, step "Export the compiled KORE
# definition to Lean" (id `export_lean`), after "Compile K definition and run examples".
# Environment: RUNNER_TEMP, GITHUB_WORKSPACE, GITHUB_STEP_SUMMARY (set by the runner); klean on
# PATH (added by k7pl_semantics_install_klean.sh).
#
#   bash scripts/ci/k7pl_semantics_export_lean.sh
set -euo pipefail

KLEAN_OUT="$RUNNER_TEMP/klean-output"
EVIDENCE="$GITHUB_WORKSPACE/.formal-chain-evidence"
rm -rf "$KLEAN_OUT" "$EVIDENCE"
mkdir -p "$KLEAN_OUT" "$EVIDENCE"
klean "$GITHUB_WORKSPACE/src/k/.build/kompiled" k7pl2lean \
  --library K7PL2Lean --output "$KLEAN_OUT"

PACKAGE="$KLEAN_OUT/k7pl2lean"
test -d "$PACKAGE"
# Klean's published template currently defaults to Lean 4.30.0. K7PL pins 4.34.0;
# overwrite the generated toolchain only as an explicit compatibility probe, then build.
cp "$GITHUB_WORKSPACE/lean-toolchain" "$PACKAGE/lean-toolchain"

for path in \
  "$PACKAGE/K7PL2Lean.lean" \
  "$PACKAGE/lakefile.toml" \
  "$PACKAGE/lean-toolchain" \
  "$PACKAGE/K7PL2Lean/Prelude.lean" \
  "$PACKAGE/K7PL2Lean/Sorts.lean" \
  "$PACKAGE/K7PL2Lean/Inj.lean" \
  "$PACKAGE/K7PL2Lean/Func.lean" \
  "$PACKAGE/K7PL2Lean/Rewrite.lean"; do
  test -s "$path" || { echo "Missing Klean output: $path" >&2; exit 1; }
done

# NOTE: '%s\\n' makes printf write a literal backslash and `n`, not a newline (the summary
# heading runs into the next line). Kept as the workflow had it; to be fixed separately.
{
  printf '%s\\n' "## Generated Klean package"
  find "$PACKAGE" -maxdepth 2 -type f -print | sort | tee "$EVIDENCE/klean-files.txt"
  printf '%s\\n' "## Generated toolchain"
  tee "$EVIDENCE/klean-toolchain.txt" < "$PACKAGE/lean-toolchain"
} >> "$GITHUB_STEP_SUMMARY"
