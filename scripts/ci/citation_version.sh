#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Prints the version that CITATION.cff declares on a top-level `version:` line, quoted or not.
# release.yaml and zenodo.yaml compare it with the release tag. A file with no such line prints
# nothing (the callers then refuse the release); a missing file is an error.
#
#   bash scripts/ci/citation_version.sh [CITATION.cff]
set -euo pipefail

sed -n 's/^version: *"\{0,1\}\([^"]*\)"\{0,1\} *$/\1/p' "${1:-CITATION.cff}"
