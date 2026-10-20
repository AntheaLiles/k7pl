#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Refuses to archive a release whose tag spec-vX.Y.Z does not match the version of CITATION.cff
# (read by scripts/ci/citation_version.sh) or has no `## [X.Y.Z]` section in spec/CHANGELOG.md.
#
# Called by: .github/workflows/zenodo.yaml, job `zenodo`, step "Check that the release matches
# CITATION.cff and spec/CHANGELOG.md", from the repository root.
# Environment: TAG (job `env`, the published release's tag).
#
#   bash scripts/ci/zenodo_check_release_metadata.sh
set -euo pipefail

version="${TAG#spec-v}"
cff="$(bash scripts/ci/citation_version.sh)"
if [ "$cff" != "$version" ]; then
  echo "::error::CITATION.cff déclare '$cff' mais la release est '$TAG'"
  exit 1
fi
grep -q "^## \[$version\]" spec/CHANGELOG.md || {
  echo "::error::spec/CHANGELOG.md ne contient pas la section '## [$version]'"
  exit 1
}
