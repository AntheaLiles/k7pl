#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Fails unless the working tree differs from the checkout in exactly lake-manifest.json,
# lakefile.lean and lean-toolchain, with nothing staged and no untracked file, and prints what
# differs otherwise.
#
# Called by: .github/workflows/bump-lean.yaml, job `open-pr`, step "Check that exactly the expected
# files differ", from the repository root, before the pull request is opened.
#
#   bash scripts/ci/bump_lean_check_diff.sh
set -euo pipefail

expected=$'lake-manifest.json\nlakefile.lean\nlean-toolchain'
changed="$(git diff --name-only | sort)"
staged="$(git diff --cached --name-only)"
untracked="$(git ls-files --others --exclude-standard)"
if [ "$changed" != "$expected" ] || [ -n "$staged" ] || [ -n "$untracked" ]; then
  echo "::error::seuls lake-manifest.json, lakefile.lean et lean-toolchain doivent différer"
  printf 'modified:\n%s\nstaged:\n%s\nuntracked:\n%s\n' "$changed" "$staged" "$untracked"
  exit 1
fi
