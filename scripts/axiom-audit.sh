#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CECILL-2.1
#
# Audit the axioms of a Lean library with leanprover-community/axiom-audit.
# Same logic as the `axiom-audit` input of lean-action, but the build is restricted to the
# targets of the audited library (lean-action runs a bare `lake build`, i.e. every default target).
#
# Usage: scripts/axiom-audit.sh <root-namespace> [lake-target...]
#
# The tool is cloned and built once per GitHub Actions job: with RUNNER_TEMP set, its checkout is
# kept in $RUNNER_TEMP/axiom-audit-<commit> and reused by the next calls of the same job, after
# checking that it is still the pinned commit, with no tracked file changed, built for this
# lean-toolchain. It is built with the project's toolchain, already installed: no other toolchain
# is downloaded. RUNNER_TEMP is emptied at the end of every job. Without RUNNER_TEMP, a temporary
# directory is used and removed, as before.
set -euo pipefail

ROOT="${1:?usage: axiom-audit.sh <root-namespace> [lake-target...]}"
shift
ALLOW="${AXIOM_AUDIT_ALLOW:-propext,Classical.choice,Quot.sound}"

# Pinned by tag for readability, and by commit (tags are mutable).
REF="v0.1.2"
SHA="46024e005996495c65ef609368e11ab39c4222e3"

if [ -n "${RUNNER_TEMP:-}" ]; then
  TOOL="$RUNNER_TEMP/axiom-audit-$SHA"
else
  WORKDIR="$(mktemp -d "/tmp/axiom-audit.XXXXXX")"
  trap 'rm -rf "$WORKDIR"' EXIT
  TOOL="$WORKDIR/axiom-audit"
fi
BIN="$TOOL/.lake/build/bin/axiom-audit"

lake build "$@"

# An earlier call of this job built the tool from the pinned commit for this toolchain, and no
# tracked file of the checkout changed since (lean-toolchain is the project's, copied on purpose).
reusable() {
  [ -x "$BIN" ] &&
    [ "$(git -C "$TOOL" rev-parse HEAD 2>/dev/null)" = "$SHA" ] &&
    git -C "$TOOL" diff --quiet HEAD -- . ':(exclude)lean-toolchain' &&
    cmp -s lean-toolchain "$TOOL/lean-toolchain"
}

if reusable; then
  echo "axiom-audit $REF: reusing the build made earlier in this job ($TOOL)"
else
  rm -rf "$TOOL"
  git clone --depth 1 --branch "$REF" https://github.com/leanprover-community/axiom-audit.git "$TOOL"
  got="$(git -C "$TOOL" rev-parse HEAD)"
  if [ "$got" != "$SHA" ]; then
    echo "::error::axiom-audit $REF resolved to $got, expected $SHA"
    exit 1
  fi
  cp lean-toolchain "$TOOL/"
  (cd "$TOOL" && lake build)
fi

lake env "$BIN" --allow "$ALLOW" --root "$ROOT"
