-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import K7PL2Lean.Sorts

/-!
# Type soundness for the K7PL prefix-language subset

This proof uses Klean-generated `SortK7Exp` constructors, so its syntax
is the syntax actually emitted from the compiled K definition.

`SurfaceStep` is a human-friendly expression-level relation for the computational
rules of the subset. It is not definitionally the generated `Rewrites` relation:
Klean encodes full K configurations, including generated heat/cool transitions,
and currently does not export the K `typeOf` function equations as rewrite constructors.
The companion module `K7PL/MachineSoundness.lean` proves preservation for the generated
configuration relation. The correspondence between K's `typeOf` equations and `HasType`
remains a separate, unproved obligation.
-/

namespace K7PL.Proof


inductive K7PLType where
  | int
  | bool
  deriving DecidableEq, Repr

/-- A typing judgment for the deliberately restricted expression subset. -/
inductive HasType : SortK7Exp → K7PLType → Prop where
  | intLit (n : SortInt) :
      HasType (SortK7Exp.inj_SortInt n) .int
  | boolLit (b : SortBool) :
      HasType (SortK7Exp.inj_SortBool b) .bool
  | add {e₁ e₂ : SortK7Exp} :
      HasType e₁ .int → HasType e₂ .int →
      HasType (SortK7Exp.k7Add e₁ e₂) .int
  | lessThan {e₁ e₂ : SortK7Exp} :
      HasType e₁ .int → HasType e₂ .int →
      HasType (SortK7Exp.k7Lt e₁ e₂) .bool
  | select {c t e : SortK7Exp} {τ : K7PLType} :
      HasType c .bool → HasType t τ → HasType e τ →
      HasType (SortK7Exp.k7Select c t e) τ

/-- Runtime values of the Klean-generated expression AST. -/
inductive Value : SortK7Exp → Prop where
  | intLit (n : SortInt) : Value (SortK7Exp.inj_SortInt n)
  | boolLit (b : SortBool) : Value (SortK7Exp.inj_SortBool b)

/--
Expression-level small-step semantics for the computational subset.
The hook result of integer comparison is represented by the same Bool-valued
comparison used by the generated K prelude. Evaluation is left-to-right;
select evaluates only its condition.
-/
inductive SurfaceStep : SortK7Exp → SortK7Exp → Prop where
  | addRoot (i j : SortInt) :
      SurfaceStep
        (SortK7Exp.k7Add (SortK7Exp.inj_SortInt i) (SortK7Exp.inj_SortInt j))
        (SortK7Exp.inj_SortInt (i + j))
  | addLeft {e e' r : SortK7Exp} :
      SurfaceStep e e' →
      SurfaceStep (SortK7Exp.k7Add e r) (SortK7Exp.k7Add e' r)
  | addRight (i : SortInt) {e e' : SortK7Exp} :
      SurfaceStep e e' →
      SurfaceStep
        (SortK7Exp.k7Add (SortK7Exp.inj_SortInt i) e)
        (SortK7Exp.k7Add (SortK7Exp.inj_SortInt i) e')
  | lessThanRoot (i j : SortInt) :
      SurfaceStep
        (SortK7Exp.k7Lt (SortK7Exp.inj_SortInt i) (SortK7Exp.inj_SortInt j))
        (SortK7Exp.inj_SortBool (i < j))
  | lessThanLeft {e e' r : SortK7Exp} :
      SurfaceStep e e' →
      SurfaceStep (SortK7Exp.k7Lt e r) (SortK7Exp.k7Lt e' r)
  | lessThanRight (i : SortInt) {e e' : SortK7Exp} :
      SurfaceStep e e' →
      SurfaceStep
        (SortK7Exp.k7Lt (SortK7Exp.inj_SortInt i) e)
        (SortK7Exp.k7Lt (SortK7Exp.inj_SortInt i) e')
  | selectTrue {t e : SortK7Exp} :
      SurfaceStep
        (SortK7Exp.k7Select (SortK7Exp.inj_SortBool true) t e) t
  | selectFalse {t e : SortK7Exp} :
      SurfaceStep
        (SortK7Exp.k7Select (SortK7Exp.inj_SortBool false) t e) e
  | selectCondition {c c' t e : SortK7Exp} :
      SurfaceStep c c' →
      SurfaceStep (SortK7Exp.k7Select c t e) (SortK7Exp.k7Select c' t e)

theorem value_int_of_typed {e : SortK7Exp}
    (ht : HasType e .int) (hv : Value e) :
    ∃ n : SortInt, e = SortK7Exp.inj_SortInt n := by
  cases hv with
  | intLit n => exact ⟨n, rfl⟩
  | boolLit b => cases ht

theorem value_bool_of_typed {e : SortK7Exp}
    (ht : HasType e .bool) (hv : Value e) :
    ∃ b : SortBool, e = SortK7Exp.inj_SortBool b := by
  cases hv with
  | intLit n => cases ht
  | boolLit b => exact ⟨b, rfl⟩

/-- Preservation: one expression-level computation step preserves its type. -/
theorem preservation {e e' : SortK7Exp} {τ : K7PLType}
    (ht : HasType e τ) (hs : SurfaceStep e e') :
    HasType e' τ := by
  induction hs generalizing τ with
  | addRoot i j =>
      cases ht with
      | add _ _ => exact HasType.intLit (i + j)
  | addLeft hs ih =>
      cases ht with
      | add h₁ h₂ => exact HasType.add (ih h₁) h₂
  | addRight i hs ih =>
      cases ht with
      | add _ h₂ => exact HasType.add (HasType.intLit i) (ih h₂)
  | lessThanRoot i j =>
      cases ht with
      | lessThan _ _ => exact HasType.boolLit (i < j)
  | lessThanLeft hs ih =>
      cases ht with
      | lessThan h₁ h₂ => exact HasType.lessThan (ih h₁) h₂
  | lessThanRight i hs ih =>
      cases ht with
      | lessThan _ h₂ => exact HasType.lessThan (HasType.intLit i) (ih h₂)
  | selectTrue =>
      cases ht with
      | select _ hₜ _ => exact hₜ
  | selectFalse =>
      cases ht with
      | select _ _ hₑ => exact hₑ
  | selectCondition hs ih =>
      cases ht with
      | select hc ht he => exact HasType.select (ih hc) ht he

/-- Progress: every well-typed expression is a value or can take a step. -/
theorem progress {e : SortK7Exp} {τ : K7PLType}
    (ht : HasType e τ) :
    Value e ∨ ∃ e', SurfaceStep e e' := by
  induction ht with
  | intLit n => exact Or.inl (Value.intLit n)
  | boolLit b => exact Or.inl (Value.boolLit b)
  | add h₁ h₂ ih₁ ih₂ =>
      rcases ih₁ with hv₁ | ⟨e₁', hs₁⟩
      · rcases value_int_of_typed h₁ hv₁ with ⟨i, rfl⟩
        rcases ih₂ with hv₂ | ⟨e₂', hs₂⟩
        · rcases value_int_of_typed h₂ hv₂ with ⟨j, rfl⟩
          exact Or.inr ⟨SortK7Exp.inj_SortInt (i + j), SurfaceStep.addRoot i j⟩
        · exact Or.inr ⟨SortK7Exp.k7Add (SortK7Exp.inj_SortInt i) e₂',
            SurfaceStep.addRight i hs₂⟩
      · exact Or.inr ⟨SortK7Exp.k7Add e₁' _, SurfaceStep.addLeft hs₁⟩
  | lessThan h₁ h₂ ih₁ ih₂ =>
      rcases ih₁ with hv₁ | ⟨e₁', hs₁⟩
      · rcases value_int_of_typed h₁ hv₁ with ⟨i, rfl⟩
        rcases ih₂ with hv₂ | ⟨e₂', hs₂⟩
        · rcases value_int_of_typed h₂ hv₂ with ⟨j, rfl⟩
          exact Or.inr ⟨SortK7Exp.inj_SortBool (i < j), SurfaceStep.lessThanRoot i j⟩
        · exact Or.inr ⟨SortK7Exp.k7Lt (SortK7Exp.inj_SortInt i) e₂',
            SurfaceStep.lessThanRight i hs₂⟩
      · exact Or.inr ⟨SortK7Exp.k7Lt e₁' _, SurfaceStep.lessThanLeft hs₁⟩
  | select hc ht he ihc iht ihe =>
      cases ihc with
      | inl hvc =>
          rcases value_bool_of_typed hc hvc with ⟨b, rfl⟩
          cases b with
          | false => exact Or.inr ⟨_, SurfaceStep.selectFalse⟩
          | true => exact Or.inr ⟨_, SurfaceStep.selectTrue⟩
      | inr hcStep =>
          rcases hcStep with ⟨c', hsc⟩
          exact Or.inr ⟨SortK7Exp.k7Select c' _ _, SurfaceStep.selectCondition hsc⟩

/-- Example program is well-typed and its initial expression step is preserved. -/
def exampleProgram : SortK7Exp :=
  SortK7Exp.k7Add
    (SortK7Exp.inj_SortInt 1)
    (SortK7Exp.k7Add (SortK7Exp.inj_SortInt 2) (SortK7Exp.inj_SortInt 3))

theorem exampleProgram_typed : HasType exampleProgram .int := by
  apply HasType.add
  · exact HasType.intLit 1
  · apply HasType.add <;> exact HasType.intLit _

theorem exampleProgram_steps :
    ∃ e', SurfaceStep exampleProgram e' := by
  rcases progress exampleProgram_typed with hval | hstep
  · cases hval
  · exact hstep

end K7PL.Proof
