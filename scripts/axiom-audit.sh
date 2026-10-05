#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CECILL-2.1
#
# Audit the axioms of a Lean library with leanprover-community/axiom-audit.
# Same logic as the `axiom-audit` input of lean-action, but the build is restricted to the
# targets of the audited library (lean-action runs a bare `lake build`, i.e. every default target).
#
# Usage: scripts/axiom-audit.sh <root-namespace> [lake-target...]
set -euo pipefail

ROOT="${1:?usage: axiom-audit.sh <root-namespace> [lake-target...]}"
shift
ALLOW="${AXIOM_AUDIT_ALLOW:-propext,Classical.choice,Quot.sound}"

# Pinned by tag for readability, and by commit (tags are mutable).
REF="v0.1.2"
SHA="46024e005996495c65ef609368e11ab39c4222e3"

WORKDIR="$(mktemp -d "${RUNNER_TEMP:-/tmp}/axiom-audit.XXXXXX")"
trap 'rm -rf "$WORKDIR"' EXIT

lake build "$@"

git clone --depth 1 --branch "$REF" https://github.com/leanprover-community/axiom-audit.git "$WORKDIR/axiom-audit"
got="$(git -C "$WORKDIR/axiom-audit" rev-parse HEAD)"
if [ "$got" != "$SHA" ]; then
  echo "::error::axiom-audit $REF resolved to $got, expected $SHA"
  exit 1
fi
cp lean-toolchain "$WORKDIR/axiom-audit/"
(cd "$WORKDIR/axiom-audit" && lake build)

lake env "$WORKDIR/axiom-audit/.lake/build/bin/axiom-audit" --allow "$ALLOW" --root "$ROOT"
