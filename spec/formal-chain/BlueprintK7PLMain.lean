-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CECILL-2.1
import VersoManual
import VersoBlueprint.PreviewManifest
import BlueprintK7PL.Blueprint

open Verso Doc
open Verso.Genre Manual

def main (args : List String) : IO UInt32 :=
  Informal.PreviewManifest.blueprintMainWithPreviewData
    (%doc BlueprintK7PL.Blueprint)
    args
    (extensionImpls := by exact extension_impls%)
