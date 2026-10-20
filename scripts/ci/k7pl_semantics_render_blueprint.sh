#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Renders the Verso Blueprint of the formal chain (`lake exe vbp build`), fails when it produced no
# HTML page, and writes the page count to the job summary.
#
# Called by: .github/workflows/k7pl-semantics.yaml, job `k-smoke`, step "Render Verso Blueprint
# documentation" (id `blueprint`), with working-directory `spec/formal-chain`.
# Environment: GITHUB_STEP_SUMMARY (set by the runner).
#
#   bash "$GITHUB_WORKSPACE/scripts/ci/k7pl_semantics_render_blueprint.sh"
set -euo pipefail

lake exe vbp build
test -d _out/site/html-multi
html_count=$(find _out/site/html-multi -type f -name '*.html' | wc -l)
test "$html_count" -gt 0
# NOTE: '%s\\n' makes printf write a literal backslash and `n`, not a newline (the summary
# heading runs into the next line). Kept as the workflow had it; to be fixed separately.
{
  printf '%s\\n' "## Verso Blueprint"
  printf 'Generated HTML files: %s\\n' "$html_count"
  printf '%s\\n' "Output: spec/formal-chain/_out/site/html-multi/"
} >> "$GITHUB_STEP_SUMMARY"
