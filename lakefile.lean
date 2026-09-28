-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Lake
open Lake DSL

package k7pl where
  version := v!"0.1.0"

-- Les trois dépendances sont alignées sur la version de Lean de `lean-toolchain`.
require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.34.0"

require cslib from git
  "https://github.com/leanprover/cslib" @ "v4.34.0"

require verso from git
  "https://github.com/leanprover/verso" @ "v4.34.0"

/-- Implémentation du langage (dossier `src/`). -/
@[default_target]
lean_lib K7pl where
  srcDir := "src"
  roots := #[`Main, `K7pl]

/-- Modules de tests (dossier `tests/`). -/
lean_lib K7plTests where
  srcDir := "tests"
  roots := #[`ArithTest, `SemanticsTest]

/-- Exécutable de tests, lancé par `lake test`. -/
@[test_driver]
lean_exe mainTest where
  srcDir := "tests"
  root := `MainTest

/-- Spécification du langage, écrite en Verso (dossier `spec/`). -/
@[default_target]
lean_lib Spec where
  srcDir := "spec"
  roots := #[`Spec]

/-- Générateur HTML de la spécification : `lake exe spec --output _out/spec`. -/
lean_exe spec where
  srcDir := "tools"
  root := `SpecMain
  supportInterpreter := true
