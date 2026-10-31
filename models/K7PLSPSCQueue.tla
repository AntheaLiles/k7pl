(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-16 abstract SPSC ring. Atomic visibility is assumed; weak-memory refinement is not modelled here. *)
---------------- MODULE K7PLSPSCQueue ----------------
EXTENDS Naturals, FiniteSets
CONSTANTS Slots, Messages, Empty, UnsafeOverwriteUnread
ASSUME
    /\ Slots = {"Slot0", "Slot1"}
    /\ IsFiniteSet(Messages)
    /\ Empty \notin Messages
    /\ UnsafeOverwriteUnread \in BOOLEAN
VARIABLES buffer, producerIndex, consumerIndex, published, consumed, overwritten
vars == <<buffer, producerIndex, consumerIndex, published, consumed, overwritten>>
NextSlot(s) == IF s = "Slot0" THEN "Slot1" ELSE "Slot0"
PendingMessages == {buffer[s] : s \in Slots /\ buffer[s] # Empty}
Init ==
    /\ buffer = [s \in Slots |-> Empty]
    /\ producerIndex = "Slot0"
    /\ consumerIndex = "Slot0"
    /\ published = {}
    /\ consumed = {}
    /\ overwritten = 0
TypeOK ==
    /\ buffer \in [Slots -> Messages \cup {Empty}]
    /\ producerIndex \in Slots
    /\ consumerIndex \in Slots
    /\ published \subseteq Messages
    /\ consumed \subseteq Messages
    /\ overwritten \in Nat
Publish(m) ==
    /\ m \in Messages \ published
    /\ (buffer[producerIndex] = Empty \/ UnsafeOverwriteUnread)
    /\ buffer' = [buffer EXCEPT ![producerIndex] = m]
    /\ producerIndex' = NextSlot(producerIndex)
    /\ published' = published \cup {m}
    /\ overwritten' = IF buffer[producerIndex] = Empty THEN overwritten ELSE overwritten + 1
    /\ UNCHANGED <<consumerIndex, consumed>>
Consume ==
    /\ buffer[consumerIndex] # Empty
    /\ LET m == buffer[consumerIndex] IN
        /\ consumed' = consumed \cup {m}
        /\ buffer' = [buffer EXCEPT ![consumerIndex] = Empty]
    /\ consumerIndex' = NextSlot(consumerIndex)
    /\ UNCHANGED <<producerIndex, published, overwritten>>
Next == \/ \E m \in Messages : Publish(m) \/ Consume
Spec == Init /\ [][Next]_vars
MessageConservation ==
    published = consumed \cup PendingMessages
    /\ consumed \cap PendingMessages = {}
NoOverwriteUnread == overwritten = 0
=============================================================================
