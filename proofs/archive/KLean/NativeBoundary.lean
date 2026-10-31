-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CECILL-2.1

/-!
A finite-state assurance model for SPEC-D-01. It formalises the distinction between
a conforming foreign call and an arbitrary native write. The profile flag abstracts
an enforcement boundary; it does not model any particular hardware or OS mechanism.
-/

namespace K7PL.NativeBoundary

inductive Profile where
  | enforcedBoundary
  | sharedUnconfined
  deriving DecidableEq, Repr

inductive Event where
  | conformingCall (value : Nat)
  | nativeWrite (value : Nat)
  deriving DecidableEq, Repr

structure State where
  protectedValue : Nat
  serviceValue : Nat
  deriving DecidableEq, Repr

def initial : State := ⟨0, 0⟩

inductive Step : Profile → State → Event → State → Prop where
  | conformingCall (profile : Profile) (state : State) (value : Nat) :
      Step profile state (.conformingCall value) ⟨state.protectedValue, value⟩
  | rejectedNativeWrite (state : State) (value : Nat) :
      Step .enforcedBoundary state (.nativeWrite value) state
  | bypassedNativeWrite (state : State) (value : Nat) :
      Step .sharedUnconfined state (.nativeWrite value) ⟨value, state.serviceValue⟩

inductive Steps (profile : Profile) : State → List Event → State → Prop where
  | nil (state : State) : Steps profile state [] state
  | cons {state intermediate final : State} {event : Event} {tail : List Event} :
      Step profile state event intermediate →
      Steps profile intermediate tail final →
      Steps profile state (event :: tail) final

theorem enforcedBoundary_step_preserves_protected
    {state final : State} {event : Event}
    (step : Step .enforcedBoundary state event final) :
    final.protectedValue = state.protectedValue := by
  cases step <;> rfl

theorem enforcedBoundary_trace_preserves_protected
    {start final : State} {events : List Event}
    (trace : Steps .enforcedBoundary start events final) :
    final.protectedValue = start.protectedValue := by
  induction trace with
  | nil _ => rfl
  | cons step rest ih =>
      exact ih.trans (enforcedBoundary_step_preserves_protected step)

/-- Exact one-step replay of the D-01 TLC counterexample with the shared value 1. -/
theorem unconfined_native_write_trace_replay :
    Steps .sharedUnconfined initial [.nativeWrite 1] ⟨1, 0⟩ := by
  exact Steps.cons (Step.bypassedNativeWrite initial 1) (Steps.nil ⟨1, 0⟩)

theorem unconfined_native_write_counterexample :
    ∃ final,
      Step .sharedUnconfined initial (.nativeWrite 1) final ∧
      final.protectedValue ≠ initial.protectedValue := by
  refine ⟨⟨1, 0⟩, ?_, ?_⟩
  · exact Step.bypassedNativeWrite initial 1
  · decide

#print axioms K7PL.NativeBoundary.enforcedBoundary_step_preserves_protected
#print axioms K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected
#print axioms K7PL.NativeBoundary.unconfined_native_write_trace_replay
#print axioms K7PL.NativeBoundary.unconfined_native_write_counterexample

end K7PL.NativeBoundary
