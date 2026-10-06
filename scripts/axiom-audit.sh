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

# Fetch strategy, in order of preference:
#  1. the pinned commit directly (`git fetch origin $SHA`): independent of ref mutability, and it
#     also tolerates annotated tags (which `--branch $REF` resolves to the tag object, not the
#     commit, on some Git versions);
#  2. the tag as a fallback, still verified against the pinned SHA below — the verification is the
#     real gate; the fetch method only decides how graceful the common path is.
AUDIT_REPO="https://github.com/leanprover-community/axiom-audit.git"
git init -q "$WORKDIR/axiom-audit"
if ! git -C "$WORKDIR/axiom-audit" fetch --depth 1 --no-tags "$AUDIT_REPO" "$SHA"; then
  git -C "$WORKDIR/axiom-audit" fetch --depth 1 --tags "$AUDIT_REPO" "refs/tags/$REF"
fi
git -C "$WORKDIR/axiom-audit" checkout --quiet FETCH_HEAD
got="$(git -C "$WORKDIR/axiom-audit" rev-parse HEAD)"
if [ "$got" != "$SHA" ]; then
  echo "::error::axiom-audit resolved to $got, expected $SHA ($REF)"
  exit 1
fi
cp lean-toolchain "$WORKDIR/axiom-audit/"
(cd "$WORKDIR/axiom-audit" && lake build)

lake env "$WORKDIR/axiom-audit/.lake/build/bin/axiom-audit" --allow "$ALLOW" --root "$ROOT"
