-- SPDX-FileCopyrightText: 2026 K7PL contributors
-- SPDX-License-Identifier: CC0-1.0
import K7PL2Lean.Rewrite

/-!
A machine-checked bridge for the root integer-addition rule.

Klean emits transitions over complete configurations and uses explicit
subsort injections. The two constructors below make the intended encodings
explicit: a compound expression is injected as SortK7Exp, while an integer
result is injected directly as SortInt. This mirrors the constructor type
emitted in the generated Rewrite.lean.
-/

namespace K7PL.Bridge

/-- Embed a compound K7PL expression in an initial K configuration. -/
def initialState (e : SortK7Exp) : SortGeneratedTopCell :=
  { k := { val := SortK.kseq ((@Inj.inj SortK7Exp SortKItem) e) SortK.dotk }
    generatedCounter := { val := 0 } }

/-- Embed an integer result at its minimal K subsort, as Klean does. -/
def initialIntState (n : SortInt) : SortGeneratedTopCell :=
  { k := { val := SortK.kseq ((@Inj.inj SortInt SortKItem) n) SortK.dotk }
    generatedCounter := { val := 0 } }

/-- The labelled K addition rule is a constructor of generated Rewrites. -/
theorem add_root_is_klean_rewrite (i j : SortInt) :
    Rewrites
      (initialState
        (SortK7Exp.k7Add
          ((@Inj.inj SortInt SortK7Exp) i)
          ((@Inj.inj SortInt SortK7Exp) j)))
      (initialIntState (i + j)) := by
  exact Rewrites.k7AddEval
    (I := i) (J := j) (_Val0 := i + j)
    (_DotVar0 := ⟨0⟩) (_DotVar1 := SortK.dotk)
    (by rfl)

end K7PL.Bridge
