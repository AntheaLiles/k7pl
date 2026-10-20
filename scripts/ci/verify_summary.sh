#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Appends one section to the job summary of a verify.yaml job. Informative only: no threshold is
# enforced here, and a missing input is reported, not fatal (except the TikZ checksums, whose
# files the previous steps of that job must have produced).
#
# Called by: .github/workflows/verify.yaml, from the repository root, with the argument
#   implementation  job `impl`, step "Summary";
#   tikz            job `tikz-assets`, step "Summarise TikZ figure assets";
#   specification   job `spec`, step "Summary";
#   pdf-log         job `spec-pdf`, step "Summarise the compilation log".
# Environment: GITHUB_STEP_SUMMARY (set by the runner); for `tikz`, TECTONIC_VERSION (step `env`)
# and SOURCE_DATE_EPOCH (job `env`).
#
#   bash scripts/ci/verify_summary.sh implementation|tikz|specification|pdf-log
set -euo pipefail

case "${1:-}" in
  implementation)
    {
      echo "### Implementation"
      echo "- Modules: $(find src tests -name '*.lean' | wc -l)"
      echo "- Lean: $(cat lean-toolchain)"
    } >> "$GITHUB_STEP_SUMMARY"
    ;;
  tikz)
    {
      echo "### TikZ figure assets"
      echo "Tectonic: ${TECTONIC_VERSION} (SHA-256 checked)"
      echo "SOURCE_DATE_EPOCH: ${SOURCE_DATE_EPOCH}"
      sha256sum out/tikz-production/*.pdf out/tikz-production/*.svg
    } >> "$GITHUB_STEP_SUMMARY"
    ;;
  specification)
    {
      echo "### Specification"
      echo "- HTML pages: $(find _out/spec/html-multi -name '*.html' 2>/dev/null | wc -l)"
      echo "- Verso modules: $(find spec -name '*.lean' | wc -l)"
    } >> "$GITHUB_STEP_SUMMARY"
    ;;
  pdf-log)
    log=_out/spec/tex/main.log
    {
      echo "### PDF compilation log"
      if [ -f "$log" ]; then
        echo "- Lines in the log: $(wc -l < "$log")"
        echo "- Lines containing 'Warning': $(grep -a -c 'Warning' "$log" || true)"
        echo "- Lines containing 'Undefined' or 'undefined': $(grep -a -c -i 'undefined' "$log" || true)"
        echo "- Lines containing 'Missing character': $(grep -a -c 'Missing character' "$log" || true)"
      else
        echo "- No log found at $log"
      fi
    } >> "$GITHUB_STEP_SUMMARY"
    ;;
  *)
    echo "usage: verify_summary.sh implementation|tikz|specification|pdf-log" >&2
    exit 2
    ;;
esac
