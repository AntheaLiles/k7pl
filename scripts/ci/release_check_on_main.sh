#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Refuses a release whose commit is not an ancestor of origin/main and, for a pushed tag, a tag that
# no longer points at the commit this run was triggered for (the tag moved). These checks protect
# against mistakes, not against someone able to push a tag (see the header of release.yaml).
#
# Called by: .github/workflows/release.yaml, job `check`, step "Check that the tagged commit is on
# main", from the root of a full-history checkout (fetch-depth: 0).
# Environment: TAG, DRY_RUN (step `env`, the outputs of the resolve step); GITHUB_SHA (set by the
# runner).
#
#   bash scripts/ci/release_check_on_main.sh
set -euo pipefail

fail() { echo "::error::$1"; exit 1; }
git rev-parse --verify --quiet refs/remotes/origin/main > /dev/null ||
  fail "origin/main is not available in the checkout"
if [ "$DRY_RUN" != "true" ]; then
  tag_commit="$(git rev-parse "refs/tags/$TAG^{commit}")"
  [ "$tag_commit" = "$GITHUB_SHA" ] ||
    fail "tag $TAG points at $tag_commit but this run was triggered for $GITHUB_SHA: the tag moved"
fi
git merge-base --is-ancestor "$GITHUB_SHA" refs/remotes/origin/main ||
  fail "commit $GITHUB_SHA is not an ancestor of origin/main: refusing to release it"
echo "$GITHUB_SHA is on main."
