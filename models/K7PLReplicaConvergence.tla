(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-15 conditional candidate. Grow-only-set replication only; fairness assumes connected reliable delivery. *)
---------------- MODULE K7PLReplicaConvergence ----------------
EXTENDS FiniteSets
CONSTANTS InitialA, InitialB, NetworkConnected, RequireFairDelivery, UnsafeOverwriteMerge
ASSUME
    /\ InitialA # {}
    /\ InitialB # {}
    /\ InitialA \cap InitialB = {}
    /\ NetworkConnected \in BOOLEAN
    /\ RequireFairDelivery \in BOOLEAN
    /\ UnsafeOverwriteMerge \in BOOLEAN
Updates == InitialA \cup InitialB
VARIABLES replicaA, replicaB, outAB, outBA
vars == <<replicaA, replicaB, outAB, outBA>>
Init ==
    /\ replicaA = InitialA
    /\ replicaB = InitialB
    /\ outAB = {}
    /\ outBA = {}
TypeOK ==
    /\ replicaA \subseteq Updates
    /\ replicaB \subseteq Updates
    /\ outAB \subseteq Updates
    /\ outBA \subseteq Updates
GossipAB ==
    /\ outAB = {}
    /\ ~(replicaA \subseteq replicaB)
    /\ outAB' = replicaA
    /\ UNCHANGED <<replicaA, replicaB, outBA>>
DeliverAB ==
    /\ NetworkConnected
    /\ outAB # {}
    /\ replicaB' = IF UnsafeOverwriteMerge THEN outAB ELSE replicaB \cup outAB
    /\ outAB' = {}
    /\ UNCHANGED <<replicaA, outBA>>
GossipBA ==
    /\ outBA = {}
    /\ ~(replicaB \subseteq replicaA)
    /\ outBA' = replicaB
    /\ UNCHANGED <<replicaA, replicaB, outAB>>
DeliverBA ==
    /\ NetworkConnected
    /\ outBA # {}
    /\ replicaA' = IF UnsafeOverwriteMerge THEN outBA ELSE replicaA \cup outBA
    /\ outBA' = {}
    /\ UNCHANGED <<replicaB, outAB>>
Next == \/ GossipAB \/ DeliverAB \/ GossipBA \/ DeliverBA
FairDelivery ==
    IF RequireFairDelivery
    THEN /\ WF_vars(GossipAB)
         /\ WF_vars(DeliverAB)
         /\ WF_vars(GossipBA)
         /\ WF_vars(DeliverBA)
    ELSE TRUE
Spec == Init /\ [][Next]_vars /\ FairDelivery
AllIssuedUpdatesRetained ==
    Updates \subseteq replicaA \cup replicaB \cup outAB \cup outBA
Converged ==
    /\ replicaA = replicaB
    /\ outAB = {}
    /\ outBA = {}
EventuallyConverged == <> Converged
=============================================================================
