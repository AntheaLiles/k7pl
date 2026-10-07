-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Main
import ArithTest
import SemanticsTest
import SpecToolsTest

namespace MainTest

/-- Checks the smoke-test value of `Main`. -/
def testHello : Bool := Main.hello == "Hello, world!"

/-- Every runtime check of the project. -/
def tests : List (String × Bool) :=
  [("hello", testHello)] ++ ArithTest.tests ++ SemanticsTest.tests ++ SpecToolsTest.tests

end MainTest

/-- Runs every check and fails if one of them does not hold. -/
def main : IO UInt32 := do
  let mut failures := 0
  for (name, ok) in MainTest.tests do
    if ok then
      IO.println s!"ok: {name}"
    else
      IO.eprintln s!"FAIL: {name}"
      failures := failures + 1
  IO.println s!"{MainTest.tests.length - failures}/{MainTest.tests.length} tests passed"
  return if failures == 0 then 0 else 1
