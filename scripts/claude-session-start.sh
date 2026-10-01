#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

# SessionStart hook for Claude Code on the web: installs elan and fetches the Mathlib cache so
# that `lake build` and `lake test` can run in the session. Best effort: never blocks the session.
set -uo pipefail

[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/..}" || exit 0

export PATH="$HOME/.elan/bin:$PATH"
if ! command -v lake >/dev/null 2>&1; then
  if ! curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
      | sh -s -- -y --default-toolchain none >/dev/null 2>&1; then
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
