#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Downloads the PDF, its SHA-256 and its Sigstore bundle from the published release into out/
# (which must not exist yet), and fails when one of the three is missing.
#
# Called by: .github/workflows/zenodo.yaml, job `zenodo`, step "Download the published assets", from
# the repository root.
# Environment: TAG, GH_REPO (job `env`); GH_TOKEN (step `env`, the job's read-only GITHUB_TOKEN).
#
#   bash scripts/ci/zenodo_download_assets.sh
set -euo pipefail

mkdir out
gh release download "$TAG" --dir out \
  --pattern k7pl-spec.pdf \
  --pattern k7pl-spec.pdf.sha256 \
  --pattern k7pl-spec.pdf.sigstore.json
for f in k7pl-spec.pdf k7pl-spec.pdf.sha256 k7pl-spec.pdf.sigstore.json; do
  [ -f "out/$f" ] || { echo "::error::asset $f is missing from release $TAG"; exit 1; }
done
