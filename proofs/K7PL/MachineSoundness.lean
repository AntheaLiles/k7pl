-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import K7PL.Proof
import K7PL.Bridge

/-!
# Machine-level preservation for the exported K semantics

Unlike SurfaceStep, KLean's Rewrites relation operates on complete K
configurations and explicitly stores evaluation contexts in the K continuation.
This module gives those continuations a typing invariant and proves that every
constructor of the generated Rewrites relation preserves that invariant.

The typing judgment is the explicit structural judgment in K7PL.Proof. Klean
does not export the K function equations for typeOf as Rewrite constructors,
so no equivalence between that K classifier and this judgment is claimed here.
-/

namespace K7PL.MachineSoundness

open K7PL.Proof

/-- KLean's subsort injection of an expression into a K item, with built-in
integer and Boolean subsorts represented by their minimal item constructors. -/
def expItem (e : SortK7Exp) : SortKItem :=
  (@Inj.inj SortK7Exp SortKItem) e

/-- The K sequence representation of an unevaluated expression argument. -/
def termK (e : SortK7Exp) : SortK := .kseq (expItem e) .dotk

/--
Typing evidence for a source expression as represented by the K machine term.
The K payload stays the index; its source preimage and typing are separate data.
-/
def EncodedExprTyping (payload : SortK) (τ : K7PLType) : Prop :=
  ∃ e : SortK7Exp, payload = termK e ∧ HasType e τ

/-- Injectivity of the generated expression encoding. -/
private theorem termK_injective {e₁ e₂ : SortK7Exp}
    (h : termK e₁ = termK e₂) : e₁ = e₂ := by
  cases e₁ <;> cases e₂ <;> simp [termK, expItem, Inj.inj] at h ⊢ <;> assumption

/-- Introduce encoded typing evidence from an expression typing derivation. -/
theorem encodedExprTyping_of_hasType {e : SortK7Exp} {τ : K7PLType}
    (h : HasType e τ) : EncodedExprTyping (termK e) τ :=
  ⟨e, rfl, h⟩

/-- Decode the typing evidence for the K encoding of a given expression. -/
theorem hasType_of_encodedExprTyping {e : SortK7Exp} {τ : K7PLType}
    (h : EncodedExprTyping (termK e) τ) : HasType e τ := by
  obtain ⟨e', hEncoded, hTyped⟩ := h
  have hEq := termK_injective hEncoded
  cases hEq
  exact hTyped

/-- Type of each active item in the current K cell. -/
inductive ItemTyping : SortKItem → K7PLType → Prop where
  | intLit (n : SortInt) : ItemTyping (.inj_SortInt n) .int
  | boolLit (b : SortBool) : ItemTyping (.inj_SortBool b) .bool
  | add {e₁ e₂ : SortK7Exp} :
      EncodedExprTyping (termK e₁) .int →
      EncodedExprTyping (termK e₂) .int →
      ItemTyping (.inj_SortK7Exp (.k7Add e₁ e₂)) .int
  | lessThan {e₁ e₂ : SortK7Exp} :
      EncodedExprTyping (termK e₁) .int →
      EncodedExprTyping (termK e₂) .int →
      ItemTyping (.inj_SortK7Exp (.k7Lt e₁ e₂)) .bool
  | select {c t e : SortK7Exp} {τ : K7PLType} :
      EncodedExprTyping (termK c) .bool →
      EncodedExprTyping (termK t) τ →
      EncodedExprTyping (termK e) τ →
      ItemTyping (.inj_SortK7Exp (.k7Select c t e)) τ

/-- Put an expression-level typing derivation on the KLean item encoding. -/
theorem itemTyping_of_hasType {e : SortK7Exp} {τ : K7PLType}
    (h : HasType e τ) : ItemTyping (expItem e) τ := by
  cases h with
  | intLit n => exact ItemTyping.intLit n
  | boolLit b => exact ItemTyping.boolLit b
  | add h₁ h₂ =>
      exact ItemTyping.add
        (encodedExprTyping_of_hasType h₁) (encodedExprTyping_of_hasType h₂)
  | lessThan h₁ h₂ =>
      exact ItemTyping.lessThan
        (encodedExprTyping_of_hasType h₁) (encodedExprTyping_of_hasType h₂)
  | select hc ht he =>
      exact ItemTyping.select
        (encodedExprTyping_of_hasType hc)
        (encodedExprTyping_of_hasType ht)
        (encodedExprTyping_of_hasType he)

/-- Recover a typed active item from its encoded typing witness. -/
theorem itemTyping_of_encodedExprTyping {e : SortK7Exp} {τ : K7PLType}
    (h : EncodedExprTyping (termK e) τ) : ItemTyping (expItem e) τ :=
  itemTyping_of_hasType (hasType_of_encodedExprTyping h)

/-- Recover the structural typing judgment from a typed KLean item. -/
theorem hasType_of_itemTyping (e : SortK7Exp) {τ : K7PLType}
    (h : ItemTyping (expItem e) τ) : HasType e τ := by
  cases e with
  | inj_SortInt n =>
      cases h with
      | intLit _ => exact HasType.intLit n
  | inj_SortBool b =>
      cases h with
      | boolLit _ => exact HasType.boolLit b
  | k7Add e₁ e₂ =>
      cases h with
      | add h₁ h₂ =>
          exact HasType.add
            (hasType_of_encodedExprTyping h₁)
            (hasType_of_encodedExprTyping h₂)
  | k7Lt e₁ e₂ =>
      cases h with
      | lessThan h₁ h₂ =>
          exact HasType.lessThan
            (hasType_of_encodedExprTyping h₁)
            (hasType_of_encodedExprTyping h₂)
  | k7Select c t e =>
      cases h with
      | select hc ht he =>
          exact HasType.select
            (hasType_of_encodedExprTyping hc)
            (hasType_of_encodedExprTyping ht)
            (hasType_of_encodedExprTyping he)

/--
Typing of a continuation as a typed evaluation context. Freezer payloads are
indexed only by their raw K term. Their source expression and typing witness
are kept separate so dependent elimination never needs to invert an injection
while matching the continuation index.
-/
inductive KontTyping : SortK → K7PLType → K7PLType → Prop where
  | empty (τ : K7PLType) : KontTyping .dotk τ τ
  | add0 {payload rest : SortK} {out : K7PLType} :
      EncodedExprTyping payload .int → KontTyping rest .int out →
      KontTyping (.kseq (.«#freezerk7Add0_» payload) rest) .int out
  | add1 {payload rest : SortK} {out : K7PLType} :
      EncodedExprTyping payload .int → KontTyping rest .int out →
      KontTyping (.kseq (.«#freezerk7Add1_» payload) rest) .int out
  | lt0 {payload rest : SortK} {out : K7PLType} :
      EncodedExprTyping payload .int → KontTyping rest .bool out →
      KontTyping (.kseq (.«#freezerk7Lt0_» payload) rest) .int out
  | lt1 {payload rest : SortK} {out : K7PLType} :
      EncodedExprTyping payload .int → KontTyping rest .bool out →
      KontTyping (.kseq (.«#freezerk7Lt1_» payload) rest) .int out
  | select0 {payloadThen payloadElse rest : SortK} {τ out : K7PLType} :
      EncodedExprTyping payloadThen τ →
      EncodedExprTyping payloadElse τ →
      KontTyping rest τ out →
      KontTyping
        (.kseq (.«#freezerk7Select0_» payloadThen payloadElse) rest)
        .bool out

/-- The active K item and its continuation jointly type the whole machine state. -/
inductive MachineTyping : SortGeneratedTopCell → K7PLType → Prop where
  | configuration {active : SortKItem} {rest : SortK}
      {activeTy out : K7PLType} {counter : SortGeneratedCounterCell} :
      ItemTyping active activeTy → KontTyping rest activeTy out →
      MachineTyping
        { k := { val := SortK.kseq active rest }, generatedCounter := counter }
        out

/-- A well-typed expression, embedded as an initial KLean configuration,
starts in a well-typed machine state. -/
theorem initialState_typed {e : SortK7Exp} {τ : K7PLType}
    (h : HasType e τ) :
    MachineTyping (K7PL.Bridge.initialState e) τ := by
  unfold K7PL.Bridge.initialState
  exact MachineTyping.configuration (itemTyping_of_hasType h) (KontTyping.empty τ)

/-- A final integer configuration carries the expected integer type. -/
theorem finalIntState_typed (n : SortInt) :
    MachineTyping (K7PL.Bridge.initialIntState n) .int := by
  unfold K7PL.Bridge.initialIntState
  exact MachineTyping.configuration (ItemTyping.intLit n) (KontTyping.empty .int)

private theorem guard_implies_kresult_true {v₀ v₁ : SortBool}
    (h₁ : _andBool_ true v₀ = some v₁) (hReq : v₁ = true) :
    v₀ = true := by
  cases v₀ with
  | false =>
      simp [_andBool_, _5b9db8d, _61fbef3] at h₁
      simp_all
  | true => rfl

private theorem kresult_int_is_int {e : SortK7Exp}
    (ht : ItemTyping (expItem e) .int)
    (hready : isKResult (termK e) = some true) :
    ∃ n : SortInt, e = .inj_SortInt n := by
  cases e with
  | inj_SortBool b => cases ht
  | inj_SortInt n => exact ⟨n, rfl⟩
  | k7Add e₁ e₂ =>
      have hfalse : isKResult (termK (.k7Add e₁ e₂)) = some false := by
        rfl
      rw [hfalse] at hready
      cases hready
  | k7Lt e₁ e₂ =>
      have hfalse : isKResult (termK (.k7Lt e₁ e₂)) = some false := by
        rfl
      rw [hfalse] at hready
      cases hready
  | k7Select c t e =>
      have hfalse : isKResult (termK (.k7Select c t e)) = some false := by
        rfl
      rw [hfalse] at hready
      cases hready

private theorem kresult_bool_is_bool {e : SortK7Exp}
    (ht : ItemTyping (expItem e) .bool)
    (hready : isKResult (termK e) = some true) :
    ∃ b : SortBool, e = .inj_SortBool b := by
  cases e with
  | inj_SortBool b => exact ⟨b, rfl⟩
  | inj_SortInt n => cases ht
  | k7Add e₁ e₂ =>
      have hfalse : isKResult (termK (.k7Add e₁ e₂)) = some false := by
        rfl
      rw [hfalse] at hready
      cases hready
  | k7Lt e₁ e₂ =>
      have hfalse : isKResult (termK (.k7Lt e₁ e₂)) = some false := by
        rfl
      rw [hfalse] at hready
      cases hready
  | k7Select c t e =>
      have hfalse : isKResult (termK (.k7Select c t e)) = some false := by
        rfl
      rw [hfalse] at hready
      cases hready

private theorem ready_of_cool_guard {e : SortK7Exp} {v₀ v₁ : SortBool}
    (h₀ : isKResult (termK e) = some v₀)
    (h₁ : _andBool_ true v₀ = some v₁)
    (hReq : v₁ = true) :
    isKResult (termK e) = some true := by
  have hv₀ : v₀ = true := guard_implies_kresult_true h₁ hReq
  simpa [hv₀] using h₀

/--
Preservation for the actual KLean-generated relation. Every heat, cool,
computation and conditional rule preserves the continuation-aware machine type.
This is stronger than the SurfaceStep preservation theorem, but it deliberately
does not establish that the K typeOf function equations were extracted.
-/
theorem rewrites_preserve_machine_typing {s s' : SortGeneratedTopCell}
    {τ : K7PLType} (hr : Rewrites s s') (ht : MachineTyping s τ) :
    MachineTyping s' τ := by
  induction hr generalizing τ with
  | tran h₁ h₂ ih₁ ih₂ =>
      exact ih₂ (ih₁ ht)
  | ADD_k7Add1_heat =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | add hHole hRight =>
              exact MachineTyping.configuration (itemTyping_of_encodedExprTyping hHole)
                (KontTyping.add0 hRight hKont)
  | ADD_k7Add1_cool hVal0 hVal1 hReq =>
      cases ht with
      | configuration hItem hKont =>
          cases hKont with
          | add0 hRight hTail =>
              have hReady := ready_of_cool_guard hVal0 hVal1 hReq
              obtain ⟨n, rfl⟩ := kresult_int_is_int hItem hReady
              exact MachineTyping.configuration
                (ItemTyping.add (encodedExprTyping_of_hasType (HasType.intLit n)) hRight) hTail
  | ADD_k7Add2_heat =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | add hLeft hHole =>
              exact MachineTyping.configuration (itemTyping_of_encodedExprTyping hHole)
                (KontTyping.add1 hLeft hKont)
  | ADD_k7Add2_cool hVal0 hVal1 hReq =>
      cases ht with
      | configuration hItem hKont =>
          cases hKont with
          | add1 hLeft hTail =>
              have hReady := ready_of_cool_guard hVal0 hVal1 hReq
              obtain ⟨n, rfl⟩ := kresult_int_is_int hItem hReady
              exact MachineTyping.configuration
                (ItemTyping.add hLeft (encodedExprTyping_of_hasType (HasType.intLit n))) hTail
  | LT_k7Lt1_heat =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | lessThan hHole hRight =>
              exact MachineTyping.configuration (itemTyping_of_encodedExprTyping hHole)
                (KontTyping.lt0 hRight hKont)
  | LT_k7Lt1_cool hVal0 hVal1 hReq =>
      cases ht with
      | configuration hItem hKont =>
          cases hKont with
          | lt0 hRight hTail =>
              have hReady := ready_of_cool_guard hVal0 hVal1 hReq
              obtain ⟨n, rfl⟩ := kresult_int_is_int hItem hReady
              exact MachineTyping.configuration
                (ItemTyping.lessThan (encodedExprTyping_of_hasType (HasType.intLit n)) hRight) hTail
  | LT_k7Lt2_heat =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | lessThan hLeft hHole =>
              exact MachineTyping.configuration (itemTyping_of_encodedExprTyping hHole)
                (KontTyping.lt1 hLeft hKont)
  | LT_k7Lt2_cool hVal0 hVal1 hReq =>
      cases ht with
      | configuration hItem hKont =>
          cases hKont with
          | lt1 hLeft hTail =>
              have hReady := ready_of_cool_guard hVal0 hVal1 hReq
              obtain ⟨n, rfl⟩ := kresult_int_is_int hItem hReady
              exact MachineTyping.configuration
                (ItemTyping.lessThan hLeft (encodedExprTyping_of_hasType (HasType.intLit n))) hTail
  | SELECT_k7Select1_heat =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | select hCond hThen hElse =>
              exact MachineTyping.configuration (itemTyping_of_encodedExprTyping hCond)
                (KontTyping.select0 hThen hElse hKont)
  | SELECT_k7Select1_cool hVal0 hVal1 hReq =>
      cases ht with
      | configuration hItem hKont =>
          cases hKont with
          | select0 hThen hElse hTail =>
              have hReady := ready_of_cool_guard hVal0 hVal1 hReq
              obtain ⟨b, rfl⟩ := kresult_bool_is_bool hItem hReady
              cases b with
              | false =>
                  exact MachineTyping.configuration
                    (ItemTyping.select
                      (encodedExprTyping_of_hasType (HasType.boolLit false))
                      hThen hElse) hTail
              | true =>
                  exact MachineTyping.configuration
                    (ItemTyping.select
                      (encodedExprTyping_of_hasType (HasType.boolLit true))
                      hThen hElse) hTail
  | k7AddEval _hVal0 =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | add _ _ =>
              exact MachineTyping.configuration (ItemTyping.intLit _) hKont
  | k7LessThanEval _hVal0 =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | lessThan _ _ =>
              exact MachineTyping.configuration (ItemTyping.boolLit _) hKont
  | k7SelectFalse =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | select _ _ hElse =>
              exact MachineTyping.configuration (itemTyping_of_encodedExprTyping hElse) hKont
  | k7SelectTrue =>
      cases ht with
      | configuration hItem hKont =>
          cases hItem with
          | select _ hThen _ =>
              exact MachineTyping.configuration (itemTyping_of_encodedExprTyping hThen) hKont

/-- Preservation for complete executions whose endpoints are initial/final
expression configurations with empty continuations. -/
theorem end_to_end_preservation {e e' : SortK7Exp} {τ : K7PLType}
    (ht : HasType e τ)
    (hr : Rewrites (K7PL.Bridge.initialState e) (K7PL.Bridge.initialState e')) :
    HasType e' τ := by
  have hs := rewrites_preserve_machine_typing hr (initialState_typed ht)
  unfold K7PL.Bridge.initialState at hs
  cases hs with
  | configuration hItem hKont =>
      cases hKont with
      | empty _ => exact hasType_of_itemTyping e' hItem

#print axioms rewrites_preserve_machine_typing
#print axioms end_to_end_preservation

end K7PL.MachineSoundness
