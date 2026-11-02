(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-10 candidate. Logical wait ticks and abstract execution cost are separate domains. *)
---------------- MODULE K7PLTemporalScheduling ----------------
EXTENDS Naturals, Integers
CONSTANTS Deadline, InitialBudget, UnsafeChargeWait
ASSUME /\ Deadline \in Nat /\ InitialBudget \in Nat /\ UnsafeChargeWait \in BOOLEAN
VARIABLES phase, logicalTime, triggerReceived, activated, executionCost, remainingBudget, timeoutExpired
vars == <<phase, logicalTime, triggerReceived, activated, executionCost, remainingBudget, timeoutExpired>>
Init ==
    /\ phase = "Waiting"
    /\ logicalTime = 0
    /\ triggerReceived = FALSE
    /\ activated = FALSE
    /\ executionCost = 0
    /\ remainingBudget = InitialBudget
    /\ timeoutExpired = FALSE
TypeOK ==
    /\ phase \in {"Waiting", "Active", "Completed", "TimedOut", "Cancelled"}
    /\ logicalTime \in Nat
    /\ triggerReceived \in BOOLEAN
    /\ activated \in BOOLEAN
    /\ executionCost \in Nat
    /\ remainingBudget \in Int
    /\ timeoutExpired \in BOOLEAN
AdvanceWait ==
    /\ phase = "Waiting"
    /\ logicalTime < Deadline
    /\ logicalTime' = logicalTime + 1
    /\ remainingBudget' = IF UnsafeChargeWait THEN remainingBudget - 1 ELSE remainingBudget
    /\ UNCHANGED <<phase, triggerReceived, activated, executionCost, timeoutExpired>>
DeliverTrigger ==
    /\ phase = "Waiting"
    /\ ~triggerReceived
    /\ triggerReceived' = TRUE
    /\ UNCHANGED <<phase, logicalTime, activated, executionCost, remainingBudget, timeoutExpired>>
Activate ==
    /\ phase = "Waiting"
    /\ triggerReceived
    /\ phase' = "Active"
    /\ activated' = TRUE
    /\ UNCHANGED <<logicalTime, triggerReceived, executionCost, remainingBudget, timeoutExpired>>
ExecuteTransition ==
    /\ phase = "Active"
    /\ executionCost < InitialBudget
    /\ executionCost' = executionCost + 1
    /\ remainingBudget' = remainingBudget - 1
    /\ UNCHANGED <<phase, logicalTime, triggerReceived, activated, timeoutExpired>>
Complete ==
    /\ phase = "Active"
    /\ phase' = "Completed"
    /\ UNCHANGED <<logicalTime, triggerReceived, activated, executionCost, remainingBudget, timeoutExpired>>
ExpireTimeout ==
    /\ phase = "Waiting"
    /\ logicalTime >= Deadline
    /\ phase' = "TimedOut"
    /\ timeoutExpired' = TRUE
    /\ UNCHANGED <<logicalTime, triggerReceived, activated, executionCost, remainingBudget>>
CancelWait ==
    /\ phase = "Waiting"
    /\ phase' = "Cancelled"
    /\ UNCHANGED <<logicalTime, triggerReceived, activated, executionCost, remainingBudget, timeoutExpired>>
Next == \/ AdvanceWait \/ DeliverTrigger \/ Activate \/ ExecuteTransition \/ Complete \/ ExpireTimeout \/ CancelWait
Spec == Init /\ [][Next]_vars
WhenOnlyAfterTrigger == activated => triggerReceived
BudgetAccounting == remainingBudget = InitialBudget - executionCost
ExecutionCostBounded == executionCost <= InitialBudget
=============================================================================
