-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

import Lake
open Lake DSL

require k7pl from ".."

package K7PLProofs where
  version := v!"0.2.0"

@[default_target]
lean_lib K7PL2Lean where
  roots := #[`K7PL2Lean]
  leanOptions := #[⟨`maxHeartbeats, 10000000⟩]

/-- Historical proof-of-concept using the generated KLean rewrite relation. -/
@[default_target]
lean_lib KLeanArchive where
  srcDir := "archive"
  roots := #[`KLean]
  leanOptions := #[⟨`maxHeartbeats, 10000000⟩]

/-- Maintained domain-oriented K7PL formalisation. -/
@[default_target]
lean_lib K7PLProofs where
  roots := #[`Grades, `Structural, `Memory, `Metatheory]
  leanOptions := #[
    ⟨`maxHeartbeats, 10000000⟩,
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩,
    ⟨`warningAsError, true⟩
  ]
