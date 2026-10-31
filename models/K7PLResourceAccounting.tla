(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-09 candidate. Cost is an abstract integer unit, not cycles or wall-clock time. *)
---------------- MODULE K7PLResourceAccounting ----------------
EXTENDS Naturals, Integers, FiniteSets
CONSTANTS Bindings, Fibres, LinearBindings, SharedBindings, OwnerOf, GradeLimit, CostOf, InitialBudget, UnsafeGradeOveruse, UnsafeBudgetOverdraw
ASSUME
    /\ IsFiniteSet(Bindings)
    /\ IsFiniteSet(Fibres)
    /\ LinearBindings \subseteq Bindings
    /\ SharedBindings \subseteq Bindings
    /\ OwnerOf \in [Bindings -> Fibres]
    /\ GradeLimit \in [Bindings -> Nat]
    /\ CostOf \in [Bindings -> Nat]
    /\ InitialBudget \in Nat
    /\ UnsafeGradeOveruse \in BOOLEAN
    /\ UnsafeBudgetOverdraw \in BOOLEAN
VARIABLES uses, usesByFibre, remainingBudget, totalCost, finished
vars == <<uses, usesByFibre, remainingBudget, totalCost, finished>>
Init ==
    /\ uses = [b \in Bindings |-> 0]
    /\ usesByFibre = [f \in Fibres |-> [b \in Bindings |-> 0]]
    /\ remainingBudget = InitialBudget
    /\ totalCost = 0
    /\ finished = FALSE
TypeOK ==
    /\ uses \in [Bindings -> Nat]
    /\ usesByFibre \in [Fibres -> [Bindings -> Nat]]
    /\ remainingBudget \in Int
    /\ totalCost \in Nat
    /\ finished \in BOOLEAN
Use(b, f) ==
    /\ ~finished
    /\ b \in Bindings
    /\ f \in Fibres
    /\ (b \in SharedBindings \/ OwnerOf[b] = f)
    /\ (uses[b] < GradeLimit[b] \/ UnsafeGradeOveruse)
    /\ (remainingBudget >= CostOf[b] \/ UnsafeBudgetOverdraw)
    /\ uses' = [uses EXCEPT ![b] = @ + 1]
    /\ usesByFibre' = [usesByFibre EXCEPT ![f][b] = @ + 1]
    /\ remainingBudget' = remainingBudget - CostOf[b]
    /\ totalCost' = totalCost + CostOf[b]
    /\ UNCHANGED finished
Finish ==
    /\ ~finished
    /\ \A b \in LinearBindings : uses[b] >= 1
    /\ finished' = TRUE
    /\ UNCHANGED <<uses, usesByFibre, remainingBudget, totalCost>>
Next == \/ \E b \in Bindings, f \in Fibres : Use(b, f) \/ Finish
Spec == Init /\ [][Next]_vars
UsageWithinGrade == \A b \in Bindings : uses[b] <= GradeLimit[b]
BudgetNonNegative == remainingBudget >= 0
BudgetAccounting == remainingBudget = InitialBudget - totalCost
LinearBindingsConsumedAtFinish == finished => \A b \in LinearBindings : uses[b] >= 1
=============================================================================
