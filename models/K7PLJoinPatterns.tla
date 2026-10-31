(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-02 candidate. Selection ordering is an exploratory finite policy, not ratified. *)
---------------- MODULE K7PLJoinPatterns ----------------
EXTENDS Naturals, FiniteSets
CONSTANTS Messages, LeftMessages, RightMessages, KeyOf, Rank, InitiallyAvailable, NoPair, AllowPartialConsume
ASSUME
    /\ IsFiniteSet(Messages)
    /\ LeftMessages \subseteq Messages
    /\ RightMessages \subseteq Messages
    /\ LeftMessages \cap RightMessages = {}
    /\ KeyOf \in [Messages -> Nat]
    /\ Rank \in [Messages -> 1..Cardinality(Messages)]
    /\ \A m, n \in Messages : Rank[m] = Rank[n] => m = n
    /\ InitiallyAvailable \subseteq Messages
    /\ InitiallyAvailable \cap LeftMessages # {}
    /\ InitiallyAvailable \cap RightMessages # {}
    /\ NoPair \notin (Messages \X Messages)
    /\ AllowPartialConsume \in BOOLEAN
VARIABLES available, enqueued, consumedLeft, consumedRight, joinedPairs, selected
vars == <<available, enqueued, consumedLeft, consumedRight, joinedPairs, selected>>
AdmissiblePairs ==
    {<<l, r>> :
        l \in available \cap LeftMessages,
        r \in available \cap RightMessages,
        KeyOf[l] = KeyOf[r]}
PairRank(pair) == Rank[pair[1]] * (Cardinality(Messages) + 1) + Rank[pair[2]]
BestPair ==
    CHOOSE pair \in AdmissiblePairs :
        \A other \in AdmissiblePairs : PairRank(pair) <= PairRank(other)
Init ==
    /\ available = InitiallyAvailable
    /\ enqueued = InitiallyAvailable
    /\ consumedLeft = {}
    /\ consumedRight = {}
    /\ joinedPairs = {}
    /\ selected = NoPair
TypeOK ==
    /\ available \subseteq Messages
    /\ enqueued \subseteq Messages
    /\ consumedLeft \subseteq LeftMessages
    /\ consumedRight \subseteq RightMessages
    /\ joinedPairs \subseteq (Messages \X Messages)
    /\ selected \in (Messages \X Messages) \cup {NoPair}
Enqueue(m) ==
    /\ m \in Messages \ enqueued
    /\ enqueued' = enqueued \cup {m}
    /\ available' = available \cup {m}
    /\ UNCHANGED <<consumedLeft, consumedRight, joinedPairs, selected>>
Join ==
    /\ AdmissiblePairs # {}
    /\ LET pair == BestPair IN
        /\ available' = available \ {pair[1], pair[2]}
        /\ consumedLeft' = consumedLeft \cup {pair[1]}
        /\ consumedRight' = consumedRight \cup {pair[2]}
        /\ joinedPairs' = joinedPairs \cup {pair}
        /\ selected' = pair
    /\ UNCHANGED enqueued
PartialConsumeLeft ==
    /\ AllowPartialConsume
    /\ available \cap LeftMessages # {}
    /\ LET m == CHOOSE x \in (available \cap LeftMessages) : TRUE IN
        /\ available' = available \ {m}
        /\ consumedLeft' = consumedLeft \cup {m}
    /\ UNCHANGED <<enqueued, consumedRight, joinedPairs, selected>>
Next ==
    \/ \E m \in Messages : Enqueue(m)
    \/ Join
    \/ PartialConsumeLeft
Spec == Init /\ [][Next]_vars
Conservation == enqueued = available \cup consumedLeft \cup consumedRight
NoReconsumption == available \cap (consumedLeft \cup consumedRight) = {}
BalancedConsumption == Cardinality(consumedLeft) = Cardinality(consumedRight)
JoinedPairsConsumed ==
    \A pair \in joinedPairs :
        /\ pair[1] \in consumedLeft
        /\ pair[2] \in consumedRight
        /\ KeyOf[pair[1]] = KeyOf[pair[2]]
=============================================================================
