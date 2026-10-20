#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Writes the scoped Lake-to-SPDX documents of the root workspace and of the Paperproof workspace,
# audits the root one with `lake exe sbomAudit`, and has scripts/ci/sbom_evidence.py check the
# report and write the evidence JSON and the job summary. Every output goes to RUNNER_TEMP, where
# the next step of the job uploads it.
#
# Called by: .github/workflows/verify.yaml, job `impl`, step "Audit the scoped Lake-to-SPDX
# inventory", from the repository root, after `lake build ... sbomAudit`.
# Environment: RUNNER_TEMP (set by the runner), PAPERPROOF_WORKSPACE (workflow `env`).
#
#   bash scripts/ci/verify_sbom_audit.sh
set -euo pipefail

python3 scripts/ci/lake_manifest_to_spdx.py \
  --created 2026-10-10T00:00:00Z \
  --output "$RUNNER_TEMP/k7pl-lake.spdx.json"
python3 scripts/ci/lake_manifest_to_spdx.py \
  --manifest "$PAPERPROOF_WORKSPACE/lake-manifest.json" \
  --created 2026-10-10T00:00:00Z \
  --output "$RUNNER_TEMP/k7pl-paperproof-export-lake.spdx.json"
lake exe sbomAudit lake-manifest.json "$RUNNER_TEMP/k7pl-lake.spdx.json" \
  > "$RUNNER_TEMP/k7pl-sbom-audit.json"
python3 scripts/ci/sbom_evidence.py \
  --report "$RUNNER_TEMP/k7pl-sbom-audit.json" \
  --manifest lake-manifest.json \
  --sbom "$RUNNER_TEMP/k7pl-lake.spdx.json" \
  --extra-inventory "$PAPERPROOF_WORKSPACE/lake-manifest.json" \
    "$RUNNER_TEMP/k7pl-paperproof-export-lake.spdx.json" \
  --output "$RUNNER_TEMP/k7pl-sbom-evidence.json"
