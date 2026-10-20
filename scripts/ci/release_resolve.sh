#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# Resolves what is released and writes kind (spec | implementation), version, tag and dry_run to
# GITHUB_OUTPUT. A pushed tag spec-vX.Y.Z or vX.Y.Z is a release; a workflow_dispatch is a rehearsal
# (dry_run=true), whose kind and version come from the inputs. Fails unless the version is X.Y.Z or
# X.Y.Z-pre.release.
#
# Called by: .github/workflows/release.yaml, job `check`, step "Resolve what is being released" (id
# `resolve`), from the repository root.
# Environment: EVENT_NAME, REF_NAME, REF_TYPE, INPUT_KIND, INPUT_VERSION (step `env`, from the event
# and the dispatch inputs); GITHUB_OUTPUT, GITHUB_STEP_SUMMARY (set by the runner).
#
#   bash scripts/ci/release_resolve.sh
set -euo pipefail

fail() { echo "::error::$1"; exit 1; }
if [ "$EVENT_NAME" = "workflow_dispatch" ]; then
  dry_run=true
  version="$INPUT_VERSION"
  case "$INPUT_KIND" in
    spec) kind=spec; tag="spec-v$version" ;;
    implementation) kind=implementation; tag="v$version" ;;
    *) fail "unknown kind '$INPUT_KIND'" ;;
  esac
else
  dry_run=false
  [ "$REF_TYPE" = "tag" ] || fail "expected a tag, got $REF_TYPE '$REF_NAME'"
  tag="$REF_NAME"
  case "$tag" in
    spec-v*) kind=spec; version="${tag#spec-v}" ;;
    v*) kind=implementation; version="${tag#v}" ;;
    *) fail "tag '$tag' is neither spec-vX.Y.Z nor vX.Y.Z" ;;
  esac
fi
semver='^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z][0-9A-Za-z.-]*)?$'
[[ "$version" =~ $semver ]] || fail "'$version' is not a version (X.Y.Z or X.Y.Z-pre.release)"
{
  echo "kind=$kind"
  echo "version=$version"
  echo "tag=$tag"
  echo "dry_run=$dry_run"
} >> "$GITHUB_OUTPUT"
if [ "$dry_run" = "true" ]; then
  echo "Rehearsal of $tag: checks and build only. No draft, no attestation, nothing written." \
    >> "$GITHUB_STEP_SUMMARY"
fi
