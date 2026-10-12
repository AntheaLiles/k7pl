-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Data.ENat.Lattice
import K7pl.GradeBudget

/-!
# Parametric accounting interface for reactive `When`

P3-B separates environmental waiting from the execution cost of the automaton
started by an event. The latency observation type remains a parameter: this
module deliberately does not select its concrete representation.

The result is a typed accounting contract. It does not define the operational
`When` rule, orchestration policy, or the source/target traces.
-/

namespace K7pl.WhenBoundary

universe u v

/-- A triggered run separates wait observation from body execution. -/
structure TriggeredRun (LatencyObservation : Type u) (L : Type v) where
  /-- Abstract observation of environmental waiting before the trigger. -/
  waitObservation : LatencyObservation
  /-- Temporal profile of the automaton body after the trigger. -/
  executionProfile : GradeBudget.K L
  /-- Budget certificate for the body profile, not for the wait observation. -/
  budgetCertificate : GradeBudget.BudgetBoundaryCertificate L
  /-- The certified profile is exactly the profile of the triggered body. -/
  profile_matches : budgetCertificate.profile = executionProfile

/-- Only the triggered automaton profile contributes to the charged cost. -/
noncomputable def chargedCost {LatencyObservation : Type u} {L : Type v}
    (run : TriggeredRun LatencyObservation L) : ℕ∞ :=
  GradeBudget.costBudgetK run.executionProfile

/-- The certified residual conserves budget against the triggered body cost. -/
theorem TriggeredRun.conservation {LatencyObservation : Type u} {L : Type v}
    (run : TriggeredRun LatencyObservation L) :
    run.budgetCertificate.budgetAfter + chargedCost run =
      run.budgetCertificate.budgetBefore := by
  unfold chargedCost
  rw [← run.profile_matches]
  exact run.budgetCertificate.conservation

/-- Equal body profiles incur equal charged cost, independently of wait observations. -/
theorem chargedCost_eq_of_profile_eq {LatencyObservation : Type u} {L : Type v}
    (left right : TriggeredRun LatencyObservation L)
    (sameBody : left.executionProfile = right.executionProfile) :
    chargedCost left = chargedCost right := by
  simp [chargedCost, sameBody]

end K7pl.WhenBoundary
