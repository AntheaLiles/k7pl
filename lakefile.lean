-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Lake
open Lake DSL

/-!
# Build configuration of k7pl

Lean, Mathlib, CSLib and Verso are pinned to the same release: bump them together with
`scripts/bump-lean.sh`.
-/

/-- Options shared by every library of the project. -/
abbrev k7plBaseOptions : Array LeanOption := #[
  ⟨`autoImplicit, false⟩,
  ⟨`relaxedAutoImplicit, false⟩,
  ⟨`pp.unicode.fun, true⟩,
  -- Any warning (including `declaration uses 'sorry'`) fails the build.
  ⟨`warningAsError, true⟩
]

/-- Mathlib's standard linter set. The header linter is disabled because our file headers follow
REUSE (SPDX tags) instead of Mathlib's copyright block. The `weak.` prefix lets files that do not
import Mathlib ignore these options. -/
abbrev k7plLinters : Array LeanOption := #[
  ⟨`weak.linter.mathlibStandardSet, true⟩,
  ⟨`weak.linter.style.header, false⟩,
  ⟨`weak.linter.style.longFile, .ofNat 1500⟩
]

package k7pl where
  version := v!"0.1.0"
  lintDriver := "batteries/runLinter"
  lintDriverArgs := #["K7pl"]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.34.0"

require cslib from git
  "https://github.com/leanprover/cslib" @ "v4.34.0"

require verso from git
  "https://github.com/leanprover/verso" @ "v4.34.0"

/-- Implementation of the language (`src/`). -/
@[default_target]
lean_lib K7pl where
  srcDir := "src"
  roots := #[`Main, `K7pl]
  leanOptions := k7plBaseOptions ++ k7plLinters

/-- Test modules (`tests/`). Like Mathlib's own tests, they do not run the style linters. -/
lean_lib K7plTests where
  srcDir := "tests"
  roots := #[`ArithTest, `SemanticsTest]
  leanOptions := k7plBaseOptions

/-- Test runner, invoked by `lake test`. -/
@[test_driver]
lean_exe mainTest where
  srcDir := "tests"
  root := `MainTest

/-- Specification of the language, written with Verso (`spec/`). -/
@[default_target]
lean_lib Spec where
  srcDir := "spec"
  roots := #[`Spec]
  leanOptions := k7plBaseOptions

/-- HTML generator for the specification: `lake exe spec --output _out/spec`. -/
lean_exe spec where
  srcDir := "tools"
  root := `SpecMain
  supportInterpreter := true
