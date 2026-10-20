#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Installs kframework 7.1.337 (which provides the Klean generator) in a virtual environment under
# RUNNER_TEMP, checks that `klean --help` runs, and adds the environment's bin directory to
# GITHUB_PATH for the later steps of the job.
#
# Called by: .github/workflows/k7pl-semantics.yaml, job `k-smoke`, step "Install the pinned Klean
# generator", from the repository root.
# Environment: RUNNER_TEMP, GITHUB_PATH (set by the runner).
#
#   bash scripts/ci/k7pl_semantics_install_klean.sh
set -euo pipefail

python3 -m venv "$RUNNER_TEMP/klean-venv"
"$RUNNER_TEMP/klean-venv/bin/python" -m pip install --disable-pip-version-check "kframework==7.1.337"
"$RUNNER_TEMP/klean-venv/bin/klean" --help
echo "$RUNNER_TEMP/klean-venv/bin" >> "$GITHUB_PATH"
