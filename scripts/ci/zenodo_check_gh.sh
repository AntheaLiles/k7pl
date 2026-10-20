#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Refuses to go on with a gh that lacks `gh release verify`, `gh release verify-asset` or
# `gh attestation verify`: the next steps must not publish unverified assets. Prints the gh version.
#
# Called by: .github/workflows/zenodo.yaml, job `zenodo`, step "Check that gh can verify releases
# and attestations".
#
#   bash scripts/ci/zenodo_check_gh.sh
set -euo pipefail

gh --version
gh release verify --help > /dev/null || {
  echo "::error::this gh has no 'gh release verify': refusing to publish unverified assets"
  exit 1
}
gh release verify-asset --help > /dev/null || {
  echo "::error::this gh has no 'gh release verify-asset': refusing to publish unverified assets"
  exit 1
}
gh attestation verify --help > /dev/null
