(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-05 candidate. Commit/cancel race and post-ack guarantee are exploratory contract alternatives. *)
---------------- MODULE K7PLCancellation ----------------
EXTENDS Naturals
CONSTANT UnsafePostAckCommit
ASSUME UnsafePostAckCommit \in BOOLEAN
VARIABLES
    requestSent, accepted, cancelRequested, cancelAcknowledged,
    committed, timedOut, serviceState, commitCount, retrySeen
vars == <<requestSent, accepted, cancelRequested, cancelAcknowledged,
          committed, timedOut, serviceState, commitCount, retrySeen>>
Init ==
    /\ requestSent = FALSE
    /\ accepted = FALSE
    /\ cancelRequested = FALSE
    /\ cancelAcknowledged = FALSE
    /\ committed = FALSE
    /\ timedOut = FALSE
    /\ serviceState = "Idle"
    /\ commitCount = 0
    /\ retrySeen = FALSE
TypeOK ==
    /\ requestSent \in BOOLEAN
    /\ accepted \in BOOLEAN
    /\ cancelRequested \in BOOLEAN
    /\ cancelAcknowledged \in BOOLEAN
    /\ committed \in BOOLEAN
    /\ timedOut \in BOOLEAN
    /\ serviceState \in {"Idle", "Accepted", "Cancelled", "Committed", "Failed"}
    /\ commitCount \in 0..1
    /\ retrySeen \in BOOLEAN
SendRequest ==
    /\ ~requestSent
    /\ requestSent' = TRUE
    /\ serviceState' = "Idle"
    /\ UNCHANGED <<accepted, cancelRequested, cancelAcknowledged, committed,
                   timedOut, commitCount, retrySeen>>
AcceptRequest ==
    /\ requestSent
    /\ ~accepted
    /\ accepted' = TRUE
    /\ serviceState' = "Accepted"
    /\ UNCHANGED <<requestSent, cancelRequested, cancelAcknowledged, committed,
                   timedOut, commitCount, retrySeen>>
RequestCancellation ==
    /\ accepted
    /\ serviceState = "Accepted"
    /\ ~cancelRequested
    /\ cancelRequested' = TRUE
    /\ UNCHANGED <<requestSent, accepted, cancelAcknowledged, committed,
                   timedOut, serviceState, commitCount, retrySeen>>
AcknowledgeCancellation ==
    /\ cancelRequested
    /\ serviceState = "Accepted"
    /\ ~cancelAcknowledged
    /\ ~committed
    /\ cancelAcknowledged' = TRUE
    /\ serviceState' = "Cancelled"
    /\ UNCHANGED <<requestSent, accepted, cancelRequested, committed,
                   timedOut, commitCount, retrySeen>>
CommitEffect ==
    /\ accepted
    /\ serviceState = "Accepted"
    /\ ~committed
    /\ (~cancelAcknowledged \/ UnsafePostAckCommit)
    /\ committed' = TRUE
    /\ commitCount' = commitCount + 1
    /\ serviceState' = "Committed"
    /\ UNCHANGED <<requestSent, accepted, cancelRequested, cancelAcknowledged,
                   timedOut, retrySeen>>
FailService ==
    /\ accepted
    /\ serviceState = "Accepted"
    /\ serviceState' = "Failed"
    /\ UNCHANGED <<requestSent, accepted, cancelRequested, cancelAcknowledged,
                   committed, timedOut, commitCount, retrySeen>>
RetryRequest ==
    /\ requestSent
    /\ ~retrySeen
    /\ retrySeen' = TRUE
    /\ UNCHANGED <<requestSent, accepted, cancelRequested, cancelAcknowledged,
                   committed, timedOut, serviceState, commitCount>>
TimeoutRequest ==
    /\ requestSent
    /\ ~timedOut
    /\ timedOut' = TRUE
    /\ UNCHANGED <<requestSent, accepted, cancelRequested, cancelAcknowledged,
                   committed, serviceState, commitCount, retrySeen>>
Next ==
    \/ SendRequest
    \/ AcceptRequest
    \/ RequestCancellation
    \/ AcknowledgeCancellation
    \/ CommitEffect
    \/ FailService
    \/ RetryRequest
    \/ TimeoutRequest
Spec == Init /\ [][Next]_vars
EffectAtMostOnce == commitCount <= 1 /\ (committed <=> commitCount = 1)
AcknowledgedCancellationMeansNoCommit == cancelAcknowledged => ~committed
CommittedNotCancelled == committed => serviceState = "Committed"
TimeoutIsNotAcknowledgement == timedOut /\ ~cancelAcknowledged => serviceState # "Cancelled"
=============================================================================
