#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Prints the latest stable release (vX.Y.Z) published by Lean, Mathlib, CSLib and Verso alike.
set -euo pipefail
export LC_ALL=C

tags() {
  git ls-remote --tags --refs "https://github.com/$1" \
    | sed 's#.*refs/tags/##' \
    | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' \
    | sort -u
}

common="$(comm -12 <(tags leanprover/lean4) <(tags leanprover-community/mathlib4))"
common="$(comm -12 <(printf '%s\n' "$common") <(tags leanprover/cslib))"
common="$(comm -12 <(printf '%s\n' "$common") <(tags leanprover/verso))"

latest="$(printf '%s\n' "$common" | sort -V | tail -n 1)"
if [ -z "$latest" ]; then
  echo "no common release found" >&2
  exit 1
fi
echo "$latest"
