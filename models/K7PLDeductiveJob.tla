(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-13 candidate. Closure is a finite monotone relation; Lean remains responsible for general fixed-point results. *)
---------------- MODULE K7PLDeductiveJob ----------------
EXTENDS Naturals, FiniteSets
CONSTANTS Facts, Closure, InitialFacts, InitialBudget, UnsafePublishEarly
ASSUME
    /\ IsFiniteSet(Facts)
    /\ Closure \in [Facts -> SUBSET Facts]
    /\ InitialFacts \subseteq Facts
    /\ InitialBudget \in Nat
    /\ UnsafePublishEarly \in BOOLEAN
VARIABLES known, delta, budgetRemaining, iterations, status, published, publishedFacts
vars == <<known, delta, budgetRemaining, iterations, status, published, publishedFacts>>
Derived(ks) == UNION {Closure[f] : f \in ks}
Init ==
    /\ known = InitialFacts
    /\ delta = {}
    /\ budgetRemaining = InitialBudget
    /\ iterations = 0
    /\ status = "Ready"
    /\ published = FALSE
    /\ publishedFacts = {}
TypeOK ==
    /\ known \subseteq Facts
    /\ delta \subseteq Facts
    /\ budgetRemaining \in Nat
    /\ iterations \in Nat
    /\ status \in {"Ready", "Running", "Saturated", "Refused", "Cancelled", "Failed"}
    /\ published \in BOOLEAN
    /\ publishedFacts \subseteq Facts
StartJob ==
    /\ status = "Ready"
    /\ status' = "Running"
    /\ delta' = Derived(known) \ known
    /\ UNCHANGED <<known, budgetRemaining, iterations, published, publishedFacts>>
Iterate ==
    /\ status = "Running"
    /\ delta # {}
    /\ budgetRemaining > 0
    /\ LET nextKnown == known \cup delta IN
        /\ known' = nextKnown
        /\ delta' = Derived(nextKnown) \ nextKnown
    /\ budgetRemaining' = budgetRemaining - 1
    /\ iterations' = iterations + 1
    /\ UNCHANGED <<status, published, publishedFacts>>
MarkSaturated ==
    /\ status = "Running"
    /\ delta = {}
    /\ status' = "Saturated"
    /\ UNCHANGED <<known, delta, budgetRemaining, iterations, published, publishedFacts>>

CancelJob ==
    /\ status \in {"Ready", "Running"}
    /\ status' = "Cancelled"
    /\ UNCHANGED <<known, delta, budgetRemaining, iterations, published, publishedFacts>>

FailJob ==
    /\ status \in {"Ready", "Running"}
    /\ status' = "Failed"
    /\ UNCHANGED <<known, delta, budgetRemaining, iterations, published, publishedFacts>>
RefuseOnBudget ==
    /\ status = "Running"
    /\ delta # {}
    /\ budgetRemaining = 0
    /\ status' = "Refused"
    /\ UNCHANGED <<known, delta, budgetRemaining, iterations, published, publishedFacts>>
PublishResult ==
    /\ ~published
    /\ (status = "Saturated" \/ (UnsafePublishEarly /\ status = "Running"))
    /\ published' = TRUE
    /\ publishedFacts' = known
    /\ UNCHANGED <<known, delta, budgetRemaining, iterations, status>>
Next == \/ StartJob \/ Iterate \/ MarkSaturated \/ RefuseOnBudget \/ PublishResult
Spec == Init /\ [][Next]_vars
PublishedImpliesSaturated == published => status = "Saturated"
PublishedResultIsKnown == published => publishedFacts \subseteq known
SaturatedMeansClosed == status = "Saturated" => Derived(known) \subseteq known
CancelledNotPublished == status = "Cancelled" => ~published
FailedNotPublished == status = "Failed" => ~published
=============================================================================
