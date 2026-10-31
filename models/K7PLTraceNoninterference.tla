(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-11 candidate. This profile checks value/output leakage only; timing and scheduling observations are omitted. *)
---------------- MODULE K7PLTraceNoninterference ----------------
EXTENDS Sequences, FiniteSets
CONSTANTS LowInput, HighLeft, HighRight, HighInfluence
ASSUME
    /\ LowInput \in {0, 1}
    /\ HighLeft \in {0, 1}
    /\ HighRight \in {0, 1}
    /\ HighInfluence \in BOOLEAN
    /\ HighLeft # HighRight
VARIABLES lowTraceLeft, lowTraceRight, highTraceLeft, highTraceRight, completed
vars == <<lowTraceLeft, lowTraceRight, highTraceLeft, highTraceRight, completed>>
Init ==
    /\ lowTraceLeft = <<>>
    /\ lowTraceRight = <<>>
    /\ highTraceLeft = {}
    /\ highTraceRight = {}
    /\ completed = FALSE
TypeOK ==
    /\ lowTraceLeft \in Seq({0, 1})
    /\ lowTraceRight \in Seq({0, 1})
    /\ highTraceLeft \subseteq {"HighLeftEvent"}
    /\ highTraceRight \subseteq {"HighRightEvent"}
    /\ completed \in BOOLEAN
RunPairedObservation ==
    /\ ~completed
    /\ lowTraceLeft' = Append(lowTraceLeft, IF HighInfluence THEN HighLeft ELSE LowInput)
    /\ lowTraceRight' = Append(lowTraceRight, IF HighInfluence THEN HighRight ELSE LowInput)
    /\ highTraceLeft' = {"HighLeftEvent"}
    /\ highTraceRight' = {"HighRightEvent"}
    /\ completed' = TRUE
Next == RunPairedObservation
Spec == Init /\ [][Next]_vars
LowObservationEquality == lowTraceLeft = lowTraceRight
HighTraceRetainedSeparately ==
    /\ highTraceLeft \subseteq {"HighLeftEvent"}
    /\ highTraceRight \subseteq {"HighRightEvent"}
=============================================================================
