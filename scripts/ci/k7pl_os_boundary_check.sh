#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CECILL-2.1
set -euo pipefail

if [ "$#" -lt 3 ]; then
  echo "usage: k7pl_os_boundary_check.sh DEFINITION KRUN EXAMPLE_DIRECTORY" >&2
  exit 2
fi
definition="$1"
krun_cmd="$2"
examples="$3"

run_case() {
  local file=$1 expected=$2 output
  output="$("$krun_cmd" --definition "$definition" "$examples/$file")"
  printf '%s\n' "=== $file ===" "$output"
  if ! grep -Eq "$expected" <<<"$output"; then
    printf 'Expected result pattern %q not found for %s\n' "$expected" "$file" >&2
    return 1
  fi
}

run_case conforming-call.k7 'boundaryResult[[:space:]]*\([[:space:]]*0[[:space:]]*,[[:space:]]*1[[:space:]]*\)'
run_case native-write-confined.k7 'boundaryResult[[:space:]]*\([[:space:]]*0[[:space:]]*,[[:space:]]*0[[:space:]]*\)'
run_case native-write-unconfined.k7 'boundaryResult[[:space:]]*\([[:space:]]*1[[:space:]]*,[[:space:]]*0[[:space:]]*\)'
