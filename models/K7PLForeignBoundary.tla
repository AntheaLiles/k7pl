(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-06 candidate. Revocation is abstract logical invalidation, not hardware/OS alias invalidation. *)
---------------- MODULE K7PLForeignBoundary ----------------
EXTENDS Naturals
CONSTANTS RetainCallerAlias, UnsafeStaleAccess
ASSUME /\ RetainCallerAlias \in BOOLEAN /\ UnsafeStaleAccess \in BOOLEAN
VARIABLES
    callPhase, capStatus, callerAlias, foreignAlias,
    callerAccesses, foreignWrites, postAckWrites
vars == <<callPhase, capStatus, callerAlias, foreignAlias,
          callerAccesses, foreignWrites, postAckWrites>>
Init ==
    /\ callPhase = "Idle"
    /\ capStatus = "CallerOwned"
    /\ callerAlias = TRUE
    /\ foreignAlias = FALSE
    /\ callerAccesses = 0
    /\ foreignWrites = 0
    /\ postAckWrites = 0
TypeOK ==
    /\ callPhase \in {"Idle", "InCall", "Returned", "Revoked", "Acked", "Failed"}
    /\ capStatus \in {"CallerOwned", "ForeignOwned", "Revoked"}
    /\ callerAlias \in BOOLEAN
    /\ foreignAlias \in BOOLEAN
    /\ callerAccesses \in Nat
    /\ foreignWrites \in Nat
    /\ postAckWrites \in Nat
TransferCapability ==
    /\ callPhase = "Idle"
    /\ capStatus = "CallerOwned"
    /\ capStatus' = "ForeignOwned"
    /\ callPhase' = "InCall"
    /\ callerAlias' = RetainCallerAlias
    /\ foreignAlias' = TRUE
    /\ UNCHANGED <<callerAccesses, foreignWrites, postAckWrites>>
CallerUse ==
    /\ callPhase = "InCall"
    /\ callerAlias
    /\ callerAccesses' = callerAccesses + 1
    /\ UNCHANGED <<callPhase, capStatus, callerAlias, foreignAlias,
                   foreignWrites, postAckWrites>>
ForeignUse ==
    /\ callPhase = "InCall"
    /\ capStatus = "ForeignOwned"
    /\ foreignAlias
    /\ foreignWrites' = foreignWrites + 1
    /\ UNCHANGED <<callPhase, capStatus, callerAlias, foreignAlias,
                   callerAccesses, postAckWrites>>
ReturnFromForeign ==
    /\ callPhase = "InCall"
    /\ callPhase' = "Returned"
    /\ UNCHANGED <<capStatus, callerAlias, foreignAlias, callerAccesses,
                   foreignWrites, postAckWrites>>
FailForeignCall ==
    /\ callPhase = "InCall"
    /\ callPhase' = "Failed"
    /\ UNCHANGED <<capStatus, callerAlias, foreignAlias, callerAccesses,
                   foreignWrites, postAckWrites>>
RevokeCapability ==
    /\ callPhase \in {"Returned", "Failed"}
    /\ capStatus = "ForeignOwned"
    /\ capStatus' = "Revoked"
    /\ callPhase' = "Revoked"
    /\ UNCHANGED <<callerAlias, foreignAlias, callerAccesses, foreignWrites, postAckWrites>>
AcknowledgeRevocation ==
    /\ callPhase = "Revoked"
    /\ capStatus = "Revoked"
    /\ callPhase' = "Acked"
    /\ UNCHANGED <<capStatus, callerAlias, foreignAlias, callerAccesses,
                   foreignWrites, postAckWrites>>
StaleForeignUse ==
    /\ callPhase = "Acked"
    /\ capStatus = "Revoked"
    /\ foreignAlias
    /\ UnsafeStaleAccess
    /\ postAckWrites' = postAckWrites + 1
    /\ UNCHANGED <<callPhase, capStatus, callerAlias, foreignAlias,
                   callerAccesses, foreignWrites>>
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
NoCallerUseDuringExclusiveCall == callerAccesses = 0
NoForeignUseAfterAcknowledgement == postAckWrites = 0
RevokedCapabilityNotOwned == capStatus = "Revoked" => callPhase \in {"Revoked", "Acked"}
=============================================================================
