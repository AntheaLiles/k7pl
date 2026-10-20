#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Checks that the release metadata name the released version (lakefile.lean for an implementation
# release; CITATION.cff, through scripts/ci/citation_version.sh, for a specification release) and
# writes the `## [VERSION]` section of the changelog (CHANGELOG.md or spec/CHANGELOG.md),
# without its heading, to release-notes.md. Fails when that section is missing or blank.
#
# Called by: .github/workflows/release.yaml, job `check`, step "Check the release metadata and
# extract the notes", from the repository root, after "Resolve what is being released".
# Environment: KIND, VERSION, TAG (step `env`, the outputs of the resolve step).
#
#   bash scripts/ci/release_check_metadata.sh
set -euo pipefail

fail() { echo "::error::$1"; exit 1; }
# Lines of the `## [VERSION]` section of a changelog, without the heading itself.
section() {
  awk -v heading="## [$2]" '
    index($0, heading) == 1 { found = 1; next }
    found && index($0, "## [") == 1 { exit }
    found { print }
  ' "$1"
}
if [ "$KIND" = "implementation" ]; then
  lake_version="$(sed -n 's/^ *version := v!"\(.*\)"$/\1/p' lakefile.lean)"
  [ "$lake_version" = "$VERSION" ] ||
    fail "lakefile.lean déclare '$lake_version' mais la release est '$TAG'"
  changelog=CHANGELOG.md
else
  cff="$(bash scripts/ci/citation_version.sh)"
  [ "$cff" = "$VERSION" ] || fail "CITATION.cff déclare '$cff' mais la release est '$TAG'"
  changelog=spec/CHANGELOG.md
fi
# Written to a file, not piped into grep -q: with pipefail, grep closing the pipe early
# could make a successful check look like a failure.
section "$changelog" "$VERSION" > release-notes.md
grep -q '[^[:space:]]' release-notes.md ||
  fail "$changelog n'a pas de section '## [$VERSION]' non vide"
