-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import Spec

open Verso.Genre Manual

/-- Génère la spécification en HTML (répertoire `_out/` par défaut, ou `--output <dir>`). -/
def main := manualMain (%doc Spec)
