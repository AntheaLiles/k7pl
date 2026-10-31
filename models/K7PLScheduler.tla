(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-03 candidate. Fairness is an explicit profile parameter; no scheduler contract is ratified. *)
---------------- MODULE K7PLScheduler ----------------
EXTENDS Naturals, FiniteSets
CONSTANTS Fibres, FairPerFibre, AllowStarvation, AllowSuspend, AllowTerminate
ASSUME
    /\ IsFiniteSet(Fibres)
    /\ Cardinality(Fibres) > 0
    /\ FairPerFibre \in BOOLEAN
    /\ AllowStarvation \in BOOLEAN
    /\ AllowSuspend \in BOOLEAN
    /\ AllowTerminate \in BOOLEAN
VARIABLES fibreStatus, pc, served, stalled
vars == <<fibreStatus, pc, served, stalled>>
Init ==
    /\ fibreStatus = [f \in Fibres |-> "Ready"]
    /\ pc = [f \in Fibres |-> 0]
    /\ served = {}
    /\ stalled = FALSE
TypeOK ==
    /\ fibreStatus \in [Fibres -> {"Ready", "Waiting", "Terminated"}]
    /\ pc \in [Fibres -> {0, 1}]
    /\ served \subseteq Fibres
    /\ stalled \in BOOLEAN
RunStep(f) ==
    /\ fibreStatus[f] = "Ready"
    /\ ~stalled
    /\ pc' = [pc EXCEPT ![f] = 1 - @]
    /\ served' = served \cup {f}
    /\ UNCHANGED <<fibreStatus, stalled>>
Suspend(f) ==
    /\ AllowSuspend
    /\ fibreStatus[f] = "Ready"
    /\ fibreStatus' = [fibreStatus EXCEPT ![f] = "Waiting"]
    /\ UNCHANGED <<pc, served, stalled>>
Wake(f) ==
    /\ fibreStatus[f] = "Waiting"
    /\ fibreStatus' = [fibreStatus EXCEPT ![f] = "Ready"]
    /\ UNCHANGED <<pc, served, stalled>>
Terminate(f) ==
    /\ AllowTerminate
    /\ fibreStatus[f] = "Ready"
    /\ fibreStatus' = [fibreStatus EXCEPT ![f] = "Terminated"]
    /\ UNCHANGED <<pc, served, stalled>>
StallScheduler ==
    /\ AllowStarvation
    /\ ~stalled
    /\ stalled' = TRUE
    /\ UNCHANGED <<fibreStatus, pc, served>>
Next ==
    \/ \E f \in Fibres : RunStep(f)
    \/ \E f \in Fibres : Suspend(f)
    \/ \E f \in Fibres : Wake(f)
    \/ \E f \in Fibres : Terminate(f)
    \/ StallScheduler
Fairness ==
    IF FairPerFibre
    THEN \A f \in Fibres : WF_vars(RunStep(f))
    ELSE TRUE
Spec == Init /\ [][Next]_vars /\ Fairness
NoStall == ~stalled
NoTerminatedFibreExecutes ==
    \A f \in Fibres : fibreStatus[f] = "Terminated" => f \notin served \/ pc[f] \in {0, 1}
EventuallyEachServed == \A f \in Fibres : <> (f \in served)
=============================================================================
