-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Main

namespace MainTest

def testHello : Bool := Main.hello == "Hello, world!"

end MainTest

def main : IO UInt32 := do
  if MainTest.testHello then
    IO.println "ok: testHello"
    return 0
  else
    IO.eprintln "FAIL: testHello"
    return 1
