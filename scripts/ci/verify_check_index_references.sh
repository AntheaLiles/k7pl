#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Fails when main.log of the current directory reports an undefined hyper reference to an index
# entry (`idx-...`): a page reference of the generated index without an emitted target. The
# offending lines are printed.
#
# Called by: .github/workflows/verify.yaml, job `spec-pdf`, step "Reject unresolved index page
# references", with working-directory `_out/spec/tex`, after "Compile the PDF".
#
#   bash "$GITHUB_WORKSPACE/scripts/ci/verify_check_index_references.sh"
set -euo pipefail

if grep -F 'Hyper reference' main.log | grep -F 'idx-' | grep -F 'undefined'; then
  echo "::error::The generated index contains a page reference without an emitted target."
  exit 1
fi
