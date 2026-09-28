-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import K7pl.Arith

namespace ArithTest

open K7pl.Arith

/-- The expression `2 + 3 * 4`. -/
def sample : Expr := .add (.lit 2) (.mul (.lit 3) (.lit 4))

-- Compile-time checks.
#guard sample.eval == 14
#guard (double sample).eval == 28

example : (double sample).eval = 2 * sample.eval := eval_double sample

/-- Runtime checks, run by `lake test`. -/
def tests : List (String × Bool) :=
  [("eval sample", sample.eval == 14),
   ("eval double", (double sample).eval == 2 * sample.eval)]

end ArithTest
