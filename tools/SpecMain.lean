-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import Spec

open Verso.Genre Manual

/-- Renders the specification to HTML (into `_out/` by default, or `--output <dir>`). -/
def main := manualMain (%doc Spec)
