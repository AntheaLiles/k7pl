#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Runs scripts/axiom-audit.sh on every lean_lib/lean_exe root that lakefile.lean declares under a
# directory, as read by scripts/ci/check_lean_modules.py --roots-in. Every root is audited even if
# an earlier one fails; the exit status is 1 when any audit failed. With a module prefix, only the
# roots `<prefix>.*` are audited, and finding none is an error.
#
# Called by: .github/workflows/verify.yaml, job `impl`, from the repository root, by the steps
#   "Audit the axioms (compliance tooling)": bash scripts/ci/verify_audit_axioms.sh tools Compliance
#   "Audit the axioms (tests)":              bash scripts/ci/verify_audit_axioms.sh tests
# Arguments: the directory of the roots; optionally a module prefix (a plain module name).
#
#   bash scripts/ci/verify_audit_axioms.sh <directory> [<module-prefix>]
set -euo pipefail

directory="${1:?usage: verify_audit_axioms.sh <directory> [<module-prefix>]}"
prefix="${2:-}"

if [ -n "$prefix" ]; then
  roots="$(python3 scripts/ci/check_lean_modules.py --roots-in "$directory" | grep "^$prefix\.")" || {
    echo "::error::lakefile.lean declares no $prefix.* root in $directory/"
    exit 1
  }
else
  roots="$(python3 scripts/ci/check_lean_modules.py --roots-in "$directory")"
fi
status=0
for root in $roots; do
  echo "::group::axiom-audit $root"
  scripts/axiom-audit.sh "$root" "+$root" || {
    echo "::error::the axiom audit of $root failed"
    status=1
  }
  echo "::endgroup::"
done
exit "$status"
