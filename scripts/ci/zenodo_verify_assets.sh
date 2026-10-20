#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Verifies, before anything is deposited, the release attestation (`gh release verify`), the PDF
# against the release (`gh release verify-asset`), the PDF's build attestation against release.yaml
# of GH_REPO at refs/tags/TAG and GITHUB_SHA on a GitHub-hosted runner (`gh attestation verify`),
# and the checksum (which only detects corruption); then states the verifications in the job
# summary. Nothing is rebuilt: these bytes are the ones uploaded next.
#
# Called by: .github/workflows/zenodo.yaml, job `zenodo`, step "Verify the release, the PDF and its
# build attestation", from the repository root, after "Download the published assets".
# Environment: TAG, GH_REPO (job `env`); GH_TOKEN (step `env`); GITHUB_SHA, GITHUB_STEP_SUMMARY (set
# by the runner).
#
#   bash scripts/ci/zenodo_verify_assets.sh
set -euo pipefail

gh release verify "$TAG"
gh release verify-asset "$TAG" out/k7pl-spec.pdf
gh attestation verify out/k7pl-spec.pdf \
  --repo "$GH_REPO" \
  --bundle out/k7pl-spec.pdf.sigstore.json \
  --signer-workflow "$GH_REPO/.github/workflows/release.yaml" \
  --source-ref "refs/tags/$TAG" \
  --source-digest "$GITHUB_SHA" \
  --deny-self-hosted-runners
# The checksum only detects corruption: it authenticates nothing.
(cd out && sha256sum --check --strict k7pl-spec.pdf.sha256)
{
  echo "## Vérification avant dépôt"
  echo
  echo "- \`gh release verify $TAG\` : réussi"
  echo "- \`gh release verify-asset $TAG k7pl-spec.pdf\` : réussi"
  echo "- \`gh attestation verify\` (bundle, \`release.yaml\`, \`refs/tags/$TAG\`, \`$GITHUB_SHA\`) : réussi"
} >> "$GITHUB_STEP_SUMMARY"
