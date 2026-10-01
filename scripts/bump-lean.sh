#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Moves Lean, Mathlib, CSLib and Verso to the same release, then resolves the dependencies.
#
#   scripts/bump-lean.sh v4.35.0               # edit the files and run `lake update`
#   scripts/bump-lean.sh --no-update v4.35.0   # edit the files only
#   scripts/bump-lean.sh                       # use scripts/latest-lean-version.sh
set -euo pipefail

update=true
if [ "${1:-}" = "--no-update" ]; then
  update=false
  shift
fi

cd "$(dirname "$0")/.."
version="${1:-$(scripts/latest-lean-version.sh)}"
if ! [[ "$version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "invalid version: $version (expected vX.Y.Z)" >&2
  exit 2
fi

echo "leanprover/lean4:$version" > lean-toolchain
sed -E -i.bak \
  's#^(  "https://github\.com/(leanprover-community/mathlib4|leanprover/cslib|leanprover/verso)" @ )"v[^"]*"#\1"'"$version"'"#' \
  lakefile.lean
rm -f lakefile.lean.bak

if [ "$(grep -c "@ \"$version\"" lakefile.lean)" -ne 3 ]; then
  echo "lakefile.lean: expected 3 requirements pinned to $version" >&2
  exit 1
fi

if [ "$update" = true ]; then
  lake update
fi
echo "Bumped to $version. Next: lake build && lake test, then update CHANGELOG.md."
