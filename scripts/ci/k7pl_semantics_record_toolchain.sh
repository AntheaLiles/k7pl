#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Records in the log where the K tools are and which versions of K, Python and pip the job runs
# (the container image pins K). Fails when kompile or krun is not on PATH.
#
# Called by: .github/workflows/k7pl-semantics.yaml, job `k-smoke` (in the K container), step
# "Record K toolchain", from the repository root.
#
#   bash scripts/ci/k7pl_semantics_record_toolchain.sh
set -euo pipefail

command -v kompile
command -v krun
kompile --version
python3 --version
python3 -m pip --version
