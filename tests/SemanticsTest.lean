-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import K7pl.Semantics

namespace SemanticsTest

open K7pl.Semantics

-- Compile-time checks.
#guard step 3 .incr == 4
#guard step 3 .reset == 0

example : counter.MTr 0 [.incr, .incr] 2 := counter_incr_twice 0

/-- Runtime checks, run by `lake test`. -/
def tests : List (String × Bool) :=
  [("step incr", step 3 .incr == 4),
   ("step reset", step 3 .reset == 0)]

end SemanticsTest
