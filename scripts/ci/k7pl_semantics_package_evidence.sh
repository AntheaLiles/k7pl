#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Gathers the K sources of lexicon/, the generated checker, the Klean output, the proof project,
# the Blueprint sources and HTML and the evidence files under $RUNNER_TEMP/k7pl-formal-chain,
# writes its MANIFEST.txt, and packs it into $RUNNER_TEMP/k7pl-formal-chain-$GITHUB_RUN_ID.tar.gz
# for the upload step.
#
# Called by: .github/workflows/k7pl-semantics.yaml, job `k-smoke`, step "Package formal-chain build
# evidence", from the repository root, when the export and the Blueprint succeeded.
# Environment: RUNNER_TEMP, GITHUB_WORKSPACE, GITHUB_RUN_ID (set by the runner).
#
#   bash scripts/ci/k7pl_semantics_package_evidence.sh
set -euo pipefail

ARTIFACT_ROOT="$RUNNER_TEMP/k7pl-formal-chain"
ARCHIVE="$RUNNER_TEMP/k7pl-formal-chain-${GITHUB_RUN_ID}.tar.gz"
rm -rf "$ARTIFACT_ROOT" "$ARCHIVE"
mkdir -p "$ARTIFACT_ROOT/proofs" "$ARTIFACT_ROOT/spec/formal-chain" "$ARTIFACT_ROOT/src/k" "$ARTIFACT_ROOT/tests/examples/native-boundary" "$ARTIFACT_ROOT/wiki"

cp -a "$GITHUB_WORKSPACE/lexicon" "$ARTIFACT_ROOT/lexicon"
cp -a "$GITHUB_WORKSPACE/src/k/.build/generated/check_k_examples.py" "$ARTIFACT_ROOT/src/k/check_k_examples.py"
cp -a "$GITHUB_WORKSPACE/src/k/Makefile" "$ARTIFACT_ROOT/src/k/"
cp -a "$GITHUB_WORKSPACE/tests/examples/add.k7" "$GITHUB_WORKSPACE/tests/examples/select.k7" "$ARTIFACT_ROOT/tests/examples/"
cp -a "$GITHUB_WORKSPACE/tests/examples/native-boundary/." "$ARTIFACT_ROOT/tests/examples/native-boundary/"
cp -a "$GITHUB_WORKSPACE/wiki/semantics.md" "$ARTIFACT_ROOT/wiki/"
cp -a "$RUNNER_TEMP/klean-output/k7pl2lean" "$ARTIFACT_ROOT/klean-output"
cp -a "$GITHUB_WORKSPACE/proofs/K7PL2Lean.lean" "$ARTIFACT_ROOT/proofs/"
cp -a "$GITHUB_WORKSPACE/proofs/K7PL2Lean" "$ARTIFACT_ROOT/proofs/"
cp -a "$GITHUB_WORKSPACE/proofs/lakefile.toml" "$GITHUB_WORKSPACE/proofs/lean-toolchain" "$GITHUB_WORKSPACE/proofs/lake-manifest.json" "$GITHUB_WORKSPACE/proofs/README.md" "$GITHUB_WORKSPACE/proofs/K7PL.lean" "$GITHUB_WORKSPACE/proofs/Makefile" "$ARTIFACT_ROOT/proofs/"
cp -a "$GITHUB_WORKSPACE/proofs/axiom-audit-contract.json" "$ARTIFACT_ROOT/proofs/"
cp -a "$GITHUB_WORKSPACE/proofs/K7PL" "$ARTIFACT_ROOT/proofs/"

cp -a "$GITHUB_WORKSPACE/spec/formal-chain/BlueprintK7PL.lean" "$GITHUB_WORKSPACE/spec/formal-chain/BlueprintK7PLMain.lean" "$GITHUB_WORKSPACE/spec/formal-chain/lakefile.lean" "$GITHUB_WORKSPACE/spec/formal-chain/lean-toolchain" "$GITHUB_WORKSPACE/spec/formal-chain/lake-manifest.json" "$GITHUB_WORKSPACE/spec/formal-chain/Makefile" "$ARTIFACT_ROOT/spec/formal-chain/"
cp -a "$GITHUB_WORKSPACE/spec/formal-chain/BlueprintK7PL" "$ARTIFACT_ROOT/spec/formal-chain/"
mkdir -p "$ARTIFACT_ROOT/spec/formal-chain/_out/site"
cp -a "$GITHUB_WORKSPACE/spec/formal-chain/_out/site/html-multi" "$ARTIFACT_ROOT/spec/formal-chain/_out/site/"
cp -a "$GITHUB_WORKSPACE/.formal-chain-evidence" "$ARTIFACT_ROOT/evidence"

html_count=$(find "$ARTIFACT_ROOT/spec/formal-chain/_out/site/html-multi" -type f -name '*.html' | wc -l)
test "$html_count" -gt 0
(
  cd "$ARTIFACT_ROOT"
  {
    find . -type f ! -path './MANIFEST.txt' -print
    printf '%s\n' './MANIFEST.txt'
  } | LC_ALL=C sort | sed 's#^\./#k7pl-formal-chain/#'
) > "$ARTIFACT_ROOT/MANIFEST.txt"
tar -czf "$ARCHIVE" -C "$RUNNER_TEMP" k7pl-formal-chain
test -s "$ARCHIVE"
tar -tzf "$ARCHIVE" > "$RUNNER_TEMP/k7pl-formal-chain-${GITHUB_RUN_ID}.manifest.txt"
file_count=$(wc -l < "$RUNNER_TEMP/k7pl-formal-chain-${GITHUB_RUN_ID}.manifest.txt")
echo "Packaged $file_count files ($html_count HTML files) into $ARCHIVE"
ls -lh "$ARCHIVE"
