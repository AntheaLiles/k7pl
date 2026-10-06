#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# SessionStart hook for Claude Code on the web: installs elan and fetches the Mathlib cache so
# that `lake build` and `lake test` can run in the session. Best effort: never blocks the session.
#
# elan is installed from a pinned release archive whose SHA-256 is recorded below and checked
# BEFORE anything is extracted or executed. The script never pipes remote code into a shell.
#
# What the recorded sums are, and are not:
#   * They are a first observation (trust on first use, TOFU): the archives were downloaded over
#     HTTPS from the GitHub release page of leanprover/elan and hashed. Upstream does not publish
#     a checksum or a signature for them, so the sums do not prove that the first archive was
#     authentic. They detect a later replacement of the asset, a corrupted download or a
#     tampered mirror. Anyone who can edit this file can edit the sums too.
#   * elan itself downloads the Lean toolchain afterwards without verifying a digest (observed
#     by pattern search in the upstream sources, not exhaustively); that step is NOT covered.
#
# Updating elan: pick the new tag, download both archives, hash them in a clean directory, compare
# with a second download, then replace ELAN_VERSION and the sums in the same commit.
set -uo pipefail

ELAN_VERSION="v4.2.4"
ELAN_SHA256_X86_64="42b94d4244e8353142c456ec0e4ca6528fd898a6c604d4059f494e706e431f63"
ELAN_SHA256_AARCH64="05febd124d84ebf994b2e7479922a5650b1e950c17ae3bd1ddd776b65bb72bf9"

# Installs elan (no toolchain) from the pinned archive. Returns non-zero, without running any
# downloaded code, when the platform is unsupported, the download fails or the sum differs.
install_elan() {
  local target expected archive url tmp actual

  if [ "$(uname -s)" != "Linux" ]; then
    echo "k7pl: no pinned elan archive for $(uname -s)." >&2
    return 1
  fi
  case "$(uname -m)" in
    x86_64 | amd64)
      target="x86_64-unknown-linux-gnu"
      expected="$ELAN_SHA256_X86_64"
      ;;
    aarch64 | arm64)
      target="aarch64-unknown-linux-gnu"
      expected="$ELAN_SHA256_AARCH64"
      ;;
    *)
      echo "k7pl: no pinned elan archive for architecture $(uname -m)." >&2
      return 1
      ;;
  esac
  if ! command -v sha256sum >/dev/null 2>&1; then
    echo "k7pl: sha256sum is not available; refusing to install an unverified elan." >&2
    return 1
  fi

  archive="elan-$target.tar.gz"
  url="https://github.com/leanprover/elan/releases/download/$ELAN_VERSION/$archive"
  tmp="$(mktemp -d)" || return 1

  if ! curl --proto '=https' --tlsv1.2 -sSfL "$url" -o "$tmp/$archive"; then
    rm -rf "$tmp"
    return 1
  fi

  actual="$(sha256sum "$tmp/$archive" | cut -d ' ' -f 1)"
  if [ "$actual" != "$expected" ]; then
    echo "k7pl: SHA-256 mismatch for $archive ($ELAN_VERSION): expected $expected, got $actual." >&2
    echo "k7pl: elan was NOT installed." >&2
    rm -rf "$tmp"
    return 1
  fi

  # Extract only the installer (no other member can write outside $tmp), then run that binary.
  if ! tar -xzf "$tmp/$archive" -C "$tmp" elan-init \
      || ! "$tmp/elan-init" -y --default-toolchain none >/dev/null 2>&1; then
    rm -rf "$tmp"
    return 1
  fi
  rm -rf "$tmp"
}

[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/..}" || exit 0

export PATH="$HOME/.elan/bin:$PATH"
if ! command -v lake >/dev/null 2>&1; then
  if ! install_elan; then
    echo "k7pl: elan could not be installed (network policy?); rely on CI to build." >&2
    exit 0
  fi
fi
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  echo "export PATH=\"$HOME/.elan/bin:\$PATH\"" >> "$CLAUDE_ENV_FILE"
fi

if ! lake exe cache get >/dev/null 2>&1; then
  echo "k7pl: Lean toolchain or Mathlib cache unavailable (network policy?); rely on CI to build." >&2
fi
exit 0
