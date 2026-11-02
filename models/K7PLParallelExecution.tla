(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-08 candidate. Causality is a partial order; TLC exploration order is not a global trace order. *)
---------------- MODULE K7PLParallelExecution ----------------
EXTENDS Naturals, FiniteSets
CONSTANTS Branches, Events, UnsafeEarlyJoin
ASSUME
    /\ IsFiniteSet(Branches)
    /\ IsFiniteSet(Events)
    /\ Branches = {"Left", "Right"}
    /\ Events = {"L1", "L2", "R1", "R2"}
    /\ UnsafeEarlyJoin \in BOOLEAN
BranchOf(e) == IF e \in {"L1", "L2"} THEN "Left" ELSE "Right"
EventIndex(e) ==
    CASE e = "L1" -> 1
      [] e = "L2" -> 2
      [] e = "R1" -> 1
      [] OTHER -> 2
Predecessors(e) ==
    CASE e = "L2" -> {"L1"}
      [] e = "R2" -> {"R1"}
      [] OTHER -> {}
VARIABLES stepCount, emitted, joined, results, published
vars == <<stepCount, emitted, joined, results, published>>
Init ==
    /\ stepCount = [b \in Branches |-> 0]
    /\ emitted = {}
    /\ joined = FALSE
    /\ results = {}
    /\ published = FALSE
TypeOK ==
    /\ stepCount \in [Branches -> 0..2]
    /\ emitted \subseteq Events
    /\ joined \in BOOLEAN
    /\ results \subseteq Branches
    /\ published \in BOOLEAN
StepBranch(b) ==
    /\ ~joined
    /\ stepCount[b] < 2
    /\ LET e == CHOOSE x \in Events :
                    BranchOf(x) = b /\ EventIndex(x) = stepCount[b] + 1
       IN
        /\ Predecessors(e) \subseteq emitted
        /\ stepCount' = [stepCount EXCEPT ![b] = @ + 1]
        /\ emitted' = emitted \cup {e}
    /\ UNCHANGED <<joined, results, published>>
JoinBranches ==
    /\ ~joined
    /\ (UnsafeEarlyJoin \/ \A b \in Branches : stepCount[b] = 2)
    /\ joined' = TRUE
    /\ results' = Branches
    /\ UNCHANGED <<stepCount, emitted, published>>
PublishResults ==
    /\ joined
    /\ ~published
    /\ published' = TRUE
    /\ UNCHANGED <<stepCount, emitted, joined, results>>
Next ==
    \/ \E b \in Branches : StepBranch(b)
    \/ JoinBranches
    \/ PublishResults
Spec == Init /\ [][Next]_vars
CausalPredecessorsEmitted ==
    \A e \in emitted : Predecessors(e) \subseteq emitted
JoinRequiresAllBranches ==
    joined => \A b \in Branches : stepCount[b] = 2
PublishedResultsComplete ==
    published => /\ joined /\ results = Branches
=============================================================================
