-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Lake
open Lake DSL

package k7pl where
  version := v!"0.1.0"

/-- Implémentation du langage (dossier `src/`). -/
@[default_target]
lean_lib K7pl where
  srcDir := "src"
  roots := #[`Main]

/-- Exécutable de tests (dossier `tests/`), lancé par `lake test`. -/
@[test_driver]
lean_exe mainTest where
  srcDir := "tests"
  root := `MainTest
