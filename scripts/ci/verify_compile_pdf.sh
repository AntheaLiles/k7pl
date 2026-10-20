#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Compiles main.tex of the current directory with the pinned Tectonic, then copies the PDF to
# $GITHUB_WORKSPACE/out/k7pl-spec.pdf. SOURCE_DATE_EPOCH and `-Z deterministic-mode` remove two
# known sources of variation (the build date and absolute paths). They do not pin the TeX bundle,
# which Tectonic downloads at run time, and nothing here compares two builds.
#
# Called by: .github/workflows/verify.yaml, job `spec-pdf`, step "Compile the PDF", with
# working-directory `_out/spec/tex`.
# Environment: SOURCE_DATE_EPOCH (a number, from the `spec` job's output), TECTONIC_BIN_DIR (the
# `bin-dir` output of .github/actions/setup-tectonic), GITHUB_WORKSPACE (set by the runner).
#
#   bash "$GITHUB_WORKSPACE/scripts/ci/verify_compile_pdf.sh"
set -euo pipefail

export PATH="$TECTONIC_BIN_DIR:$PATH"
case "$SOURCE_DATE_EPOCH" in
  ''|*[!0-9]*)
    echo "::error::SOURCE_DATE_EPOCH is not a number: '$SOURCE_DATE_EPOCH'"
    exit 1
    ;;
esac
tectonic -X compile --keep-logs -Z deterministic-mode main.tex
mkdir -p "$GITHUB_WORKSPACE/out"
cp main.pdf "$GITHUB_WORKSPACE/out/k7pl-spec.pdf"
