-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Lake
open Lake DSL

package k7plProofExport where
  version := v!"0.1.0"

-- Keep the extractor isolated from K7PL's root Lake workspace, but use its exact Lean release.
require Paperproof from git "https://github.com/Paper-Proof/paperproof" @ "05c68e9cb8e881f9e971abb94efd231a269e0229" / "lean"
require mathlib from git "https://github.com/leanprover-community/mathlib4" @ "v4.34.0"

lean_exe terminal where
  srcDir := ".lake/packages/Paperproof/lean"
  supportInterpreter := true
