#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Treats the artifact of the `build` job as untrusted data: it must hold exactly one regular file,
# lake-manifest.json, which must pass scripts/ci/check_manifest.py --check-tags --check-upstream
# (network: upstream tags and manifests) before it replaces the checkout's lake-manifest.json.
#
# Called by: .github/workflows/bump-lean.yaml, job `open-pr`, step "Validate the manifest and put it
# in place", from the root of the clean checkout, after the artifact download to
# RUNNER_TEMP/untrusted.
# Environment: RUNNER_TEMP (set by the runner).
#
#   bash scripts/ci/bump_lean_validate_manifest.sh
set -euo pipefail

dir="$RUNNER_TEMP/untrusted"
[ "$(find "$dir" -mindepth 1 | wc -l)" -eq 1 ] || {
  echo "::error::l'artefact doit contenir uniquement lake-manifest.json"
  exit 1
}
if [ ! -f "$dir/lake-manifest.json" ] || [ -L "$dir/lake-manifest.json" ]; then
  echo "::error::lake-manifest.json est absent ou n'est pas un fichier ordinaire"
  exit 1
fi
python3 scripts/ci/check_manifest.py --manifest "$dir/lake-manifest.json" \
  --check-tags --check-upstream
cp "$dir/lake-manifest.json" lake-manifest.json
