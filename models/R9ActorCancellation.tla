(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)

---------------- MODULE R9ActorCancellation ----------------
EXTENDS Naturals, Sequences

CONSTANTS A, B
ASSUME A # B

Actors == {A, B}
MaxBudget == 2
BudgetValues == 0..MaxBudget

ActorStates ==
    {"Ready", "Waiting", "CancelRequested", "Cancelled", "Completed"}
ServiceStates == {"Idle", "Handling", "IdleAfterCancel", "Done"}
RequestStates == {"None", "Pending", "Accepted", "Cancelled", "Committed"}
EventTypes == {"Send", "Accept", "CancelRequest", "CancelAck", "EffectCommit"}

VARIABLES aState, bState, requestState, cancelRequested, cancelAck, effectCount, budget, trace

vars == <<aState, bState, requestState, cancelRequested, cancelAck, effectCount, budget, trace>>

Init ==
    /\ aState = "Ready"
    /\ bState = "Idle"
    /\ requestState = "None"
    /\ cancelRequested = FALSE
    /\ cancelAck = FALSE
    /\ effectCount = 0
    /\ budget = [p \in Actors |-> MaxBudget]
    /\ trace = <<>>

TypeOK ==
    /\ aState \in ActorStates
    /\ bState \in ServiceStates
    /\ requestState \in RequestStates
    /\ cancelRequested \in BOOLEAN
    /\ cancelAck \in BOOLEAN
    /\ effectCount \in 0..1
    /\ budget \in [Actors -> BudgetValues]
    /\ trace \in Seq(EventTypes)

BudgetInRange ==
    \A p \in Actors : budget[p] \in BudgetValues

CancelAckSound ==
    cancelAck =>
        /\ requestState = "Cancelled"
        /\ effectCount = 0
        /\ aState = "Cancelled"

CommitStateConsistent ==
    effectCount = 1 =>
        /\ requestState = "Committed"
        /\ aState = "Completed"
        /\ bState = "Done"

EffectAtMostOnce == effectCount \in 0..1

\* Deliberately too strong: a request is not an acknowledgement.
\* The negative model configuration asks TLC to find a counterexample.
NoCommitAfterCancelRequest == cancelRequested => effectCount = 0

Send ==
    /\ aState = "Ready"
    /\ requestState = "None"
    /\ budget[A] > 0
    /\ aState' = "Waiting"
    /\ requestState' = "Pending"
    /\ budget' = [budget EXCEPT ![A] = @ - 1]
    /\ trace' = Append(trace, "Send")
    /\ UNCHANGED <<bState, cancelRequested, cancelAck, effectCount>>

Accept ==
    /\ requestState = "Pending"
    /\ bState = "Idle"
    /\ ~cancelRequested
    /\ budget[B] > 0
    /\ requestState' = "Accepted"
    /\ bState' = "Handling"
    /\ budget' = [budget EXCEPT ![B] = @ - 1]
    /\ trace' = Append(trace, "Accept")
    /\ UNCHANGED <<aState, cancelRequested, cancelAck, effectCount>>

RequestCancellation ==
    /\ aState = "Waiting"
    /\ ~cancelRequested
    /\ budget[A] > 0
    /\ aState' = "CancelRequested"
    /\ cancelRequested' = TRUE
    /\ budget' = [budget EXCEPT ![A] = @ - 1]
    /\ trace' = Append(trace, "CancelRequest")
    /\ UNCHANGED <<bState, requestState, cancelAck, effectCount>>

CancelPending ==
    /\ aState = "CancelRequested"
    /\ requestState = "Pending"
    /\ bState = "Idle"
    /\ cancelRequested
    /\ ~cancelAck
    /\ budget[B] > 0
    /\ aState' = "Cancelled"
    /\ requestState' = "Cancelled"
    /\ cancelAck' = TRUE
    /\ budget' = [budget EXCEPT ![B] = @ - 1]
    /\ trace' = Append(trace, "CancelAck")
    /\ UNCHANGED <<bState, cancelRequested, effectCount>>

InterruptAccepted ==
    /\ aState = "CancelRequested"
    /\ requestState = "Accepted"
    /\ bState = "Handling"
    /\ cancelRequested
    /\ ~cancelAck
    /\ budget[B] > 0
    /\ aState' = "Cancelled"
    /\ bState' = "IdleAfterCancel"
    /\ requestState' = "Cancelled"
    /\ cancelAck' = TRUE
    /\ budget' = [budget EXCEPT ![B] = @ - 1]
    /\ trace' = Append(trace, "CancelAck")
    /\ UNCHANGED <<cancelRequested, effectCount>>

Commit ==
    /\ requestState = "Accepted"
    /\ bState = "Handling"
    /\ ~cancelAck
    /\ effectCount = 0
    /\ budget[B] > 0
    /\ aState' = "Completed"
    /\ bState' = "Done"
    /\ requestState' = "Committed"
    /\ effectCount' = 1
    /\ budget' = [budget EXCEPT ![B] = @ - 1]
    /\ trace' = Append(trace, "EffectCommit")
    /\ UNCHANGED <<cancelRequested, cancelAck>>

Next ==
    \/ Send
    \/ Accept
    \/ RequestCancellation
    \/ CancelPending
    \/ InterruptAccepted
    \/ Commit

Spec == Init /\ [][Next]_vars

=============================================================================
