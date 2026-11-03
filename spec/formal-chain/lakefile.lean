-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

import Lake
open Lake DSL

require VersoBlueprint from git "https://github.com/leanprover/verso-blueprint"@"v4.34.0"
require K7PLProofs from "../../proofs"

package BlueprintK7PL where
  precompileModules := false
  leanOptions := #[⟨`experimental.module, true⟩]

@[default_target]
lean_lib BlueprintK7PL where
  roots := #[`BlueprintK7PL, `BlueprintK7PL.Chapters.Semantics]
