-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import K7PL.Proof
import K7PL.Bridge
import K7PL.MachineSoundness

/-!
Executable/Lean bridge smoke test for the minimal example.
The surface relation has preservation and progress theorems, while
K7PL.MachineSoundness proves preservation for the generated machine relation
`Rewrites`. The relationship between K's `typeOf` and `HasType` remains open.
-/

namespace K7PL.Example

open K7PL.Proof

theorem example_add_is_well_typed :
    HasType exampleProgram .int :=
  exampleProgram_typed

theorem example_add_has_next_step :
    ∃ e', SurfaceStep exampleProgram e' :=
  exampleProgram_steps

def rootAdd : SortK7Exp :=
  SortK7Exp.k7Add
    ((@Inj.inj SortInt SortK7Exp) (1 : SortInt))
    ((@Inj.inj SortInt SortK7Exp) (2 : SortInt))

theorem root_add_is_klean_rewrite :
    Rewrites
      (K7PL.Bridge.initialState rootAdd)
      (K7PL.Bridge.initialIntState 3) := by
  exact K7PL.Bridge.add_root_is_klean_rewrite 1 2

/-- Typing of the same root addition expression used by the Klean bridge. -/
theorem root_add_well_typed : HasType rootAdd .int := by
  unfold rootAdd
  exact HasType.add (HasType.intLit 1) (HasType.intLit 2)

/--
Example-specific safety witness: this concrete Klean-generated transition
starts at a well-typed addition and lands at a well-typed integer result.
This is not a universal preservation theorem for every generated Rewrites step.
-/
theorem root_add_klean_preserves_type :
    HasType rootAdd .int ∧
      Rewrites
        (K7PL.Bridge.initialState rootAdd)
        (K7PL.Bridge.initialIntState 3) ∧
      HasType (SortK7Exp.inj_SortInt 3) .int := by
  exact ⟨root_add_well_typed, root_add_is_klean_rewrite, HasType.intLit 3⟩



/--
The exact source example in `tests/examples/add.k7`, `(+ 1 (+ 2 3))`,
reduces to the integer `6` in the actual Klean-generated configuration
relation. This trace composes the root right-argument heat step, the
`2 + 3` computation under its continuation, the corresponding cool step,
and the outer `1 + 5` computation. This is a witness for this concrete
program, not a simulation theorem for all generated transitions.
-/
theorem nested_add_example_evaluates_to_six :
    Rewrites
      (K7PL.Bridge.initialState exampleProgram)
      (K7PL.Bridge.initialIntState 6) := by
  apply Rewrites.tran
  · exact Rewrites.ADD_k7Add2_heat
      (K0 := SortK7Exp.inj_SortInt 1)
      (HOLE := SortK7Exp.k7Add
        (SortK7Exp.inj_SortInt 2)
        (SortK7Exp.inj_SortInt 3))
      (by rfl) (by rfl) (by rfl) (by rfl)
  · apply Rewrites.tran
    · exact Rewrites.k7AddEval
        (I := 2) (J := 3) (_Val0 := 5) (by rfl)
    · apply Rewrites.tran
      · exact Rewrites.ADD_k7Add2_cool
          (K0 := SortK7Exp.inj_SortInt 1)
          (HOLE := SortK7Exp.inj_SortInt 5)
          (by rfl) (by rfl) (by rfl)
      · exact Rewrites.k7AddEval
          (I := 1) (J := 5) (_Val0 := 6) (by rfl)

/-- The source example is well typed, reaches K's observed result, and the
result has the corresponding Lean type. -/
theorem add_example_end_to_end :
    HasType exampleProgram .int ∧
      Rewrites
        (K7PL.Bridge.initialState exampleProgram)
        (K7PL.Bridge.initialIntState 6) ∧
      HasType (SortK7Exp.inj_SortInt 6) .int := by
  exact ⟨example_add_is_well_typed,
    nested_add_example_evaluates_to_six,
    HasType.intLit 6⟩

#print axioms K7PL.Proof.preservation
#print axioms K7PL.Proof.progress
#print axioms K7PL.Bridge.add_root_is_klean_rewrite
#print axioms K7PL.Example.root_add_klean_preserves_type
#print axioms K7PL.Example.nested_add_example_evaluates_to_six
#print axioms K7PL.Example.add_example_end_to_end

end K7PL.Example
