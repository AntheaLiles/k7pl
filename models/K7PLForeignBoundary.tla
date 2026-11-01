(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-06 candidate. Revocation is abstract logical invalidation, not hardware/OS alias invalidation. *)
---------------- MODULE K7PLForeignBoundary ----------------
EXTENDS Naturals
CONSTANTS RetainCallerAlias, UnsafeStaleAccess
ASSUME /\ RetainCallerAlias \in BOOLEAN /\ UnsafeStaleAccess \in BOOLEAN
VARIABLES
    callPhase, capStatus, callerAlias, foreignAlias,
    callerAccessed, foreignWriteOccurred, postAckWriteOccurred
vars == <<callPhase, capStatus, callerAlias, foreignAlias,
          callerAccessed, foreignWriteOccurred, postAckWriteOccurred>>
Init ==
    /\ callPhase = "Idle"
    /\ capStatus = "CallerOwned"
    /\ callerAlias = TRUE
    /\ foreignAlias = FALSE
    /\ callerAccessed = FALSE
    /\ foreignWriteOccurred = FALSE
    /\ postAckWriteOccurred = FALSE
TypeOK ==
    /\ callPhase \in {"Idle", "InCall", "Returned", "Revoked", "Acked", "Failed"}
    /\ capStatus \in {"CallerOwned", "ForeignOwned", "Revoked"}
    /\ callerAlias \in BOOLEAN
    /\ foreignAlias \in BOOLEAN
    /\ callerAccessed \in BOOLEAN
    /\ foreignWriteOccurred \in BOOLEAN
    /\ postAckWriteOccurred \in BOOLEAN
TransferCapability ==
    /\ callPhase = "Idle"
    /\ capStatus = "CallerOwned"
    /\ capStatus' = "ForeignOwned"
    /\ callPhase' = "InCall"
    /\ callerAlias' = RetainCallerAlias
    /\ foreignAlias' = TRUE
    /\ UNCHANGED <<callerAccessed, foreignWriteOccurred, postAckWriteOccurred>>
CallerUse ==
    /\ callPhase = "InCall"
    /\ callerAlias
    /\ ~callerAccessed
    /\ callerAccessed' = TRUE
    /\ UNCHANGED <<callPhase, capStatus, callerAlias, foreignAlias,
                   foreignWriteOccurred, postAckWriteOccurred>>
ForeignUse ==
    /\ callPhase \in {"InCall", "Returned"}
    /\ capStatus = "ForeignOwned"
    /\ foreignAlias
    /\ ~foreignWriteOccurred
    /\ foreignWriteOccurred' = TRUE
    /\ UNCHANGED <<callPhase, capStatus, callerAlias, foreignAlias,
                   callerAccessed, postAckWriteOccurred>>
ReturnFromForeign ==
    /\ callPhase = "InCall"
    /\ callPhase' = "Returned"
    /\ UNCHANGED <<capStatus, callerAlias, foreignAlias, callerAccessed,
                   foreignWriteOccurred, postAckWriteOccurred>>
FailForeignCall ==
    /\ callPhase = "InCall"
    /\ callPhase' = "Failed"
    /\ UNCHANGED <<capStatus, callerAlias, foreignAlias, callerAccessed,
                   foreignWriteOccurred, postAckWriteOccurred>>
RevokeCapability ==
    /\ callPhase \in {"Returned", "Failed"}
    /\ capStatus = "ForeignOwned"
    /\ capStatus' = "Revoked"
    /\ callPhase' = "Revoked"
    /\ UNCHANGED <<callerAlias, foreignAlias, callerAccessed, foreignWriteOccurred, postAckWriteOccurred>>
AcknowledgeRevocation ==
    /\ callPhase = "Revoked"
    /\ capStatus = "Revoked"
    /\ callPhase' = "Acked"
    /\ UNCHANGED <<capStatus, callerAlias, foreignAlias, callerAccessed,
                   foreignWriteOccurred, postAckWriteOccurred>>
StaleForeignUse ==
    /\ callPhase = "Acked"
    /\ capStatus = "Revoked"
    /\ foreignAlias
    /\ UnsafeStaleAccess
    /\ ~postAckWriteOccurred
    /\ postAckWriteOccurred' = TRUE
    /\ UNCHANGED <<callPhase, capStatus, callerAlias, foreignAlias,
                   callerAccessed, foreignWriteOccurred>>
Next ==
    \/ TransferCapability
    \/ CallerUse
    \/ ForeignUse
    \/ ReturnFromForeign
    \/ FailForeignCall
    \/ RevokeCapability
    \/ AcknowledgeRevocation
    \/ StaleForeignUse
Spec == Init /\ [][Next]_vars
NoCallerUseDuringExclusiveCall == ~callerAccessed
NoForeignUseAfterAcknowledgement == ~postAckWriteOccurred
RevokedCapabilityNotOwned == capStatus = "Revoked" => callPhase \in {"Revoked", "Acked"}
=============================================================================
