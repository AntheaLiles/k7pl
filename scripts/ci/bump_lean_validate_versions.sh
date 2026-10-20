#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Refuses versions that are not vX.Y.Z: LATEST and CURRENT come from the `build` job, which ran
# upstream code, and reach the branch name, the commit message and the pull request.
#
# Called by: .github/workflows/bump-lean.yaml, job `open-pr`, step "Validate the version".
# Environment: LATEST, CURRENT (job `env`, the outputs of the `build` job).
#
#   bash scripts/ci/bump_lean_validate_versions.sh
set -euo pipefail

for v in "$LATEST" "$CURRENT"; do
  [[ "$v" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || {
    echo "::error::version invalide : '$v' (attendu : vX.Y.Z)"
    exit 1
  }
done
