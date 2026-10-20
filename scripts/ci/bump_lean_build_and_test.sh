#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Fetches the Mathlib cache for the newly resolved revisions (a warning, not a failure, when it is
# unavailable), then builds and tests the project. Runs upstream code: the job holds no secret.
#
# Called by: .github/workflows/bump-lean.yaml, job `build`, step "Build and test", from the
# repository root, after `lake update` and the early manifest check.
#
#   bash scripts/ci/bump_lean_build_and_test.sh
set -euo pipefail

lake exe cache get || echo "::warning::Mathlib cache unavailable, full rebuild ahead"
lake build
lake test
