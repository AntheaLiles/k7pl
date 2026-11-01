(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)

---------------- MODULE D01NativeBoundary ----------------
EXTENDS Naturals, Sequences

CONSTANT BoundaryEnforced
ASSUME BoundaryEnforced \in BOOLEAN

Values == {0, 1}
Events == {"Init", "ConformingCall", "NativeWriteRejected", "NativeWriteBypass"}

VARIABLES protectedValue, serviceValue, lastEvent
vars == <<protectedValue, serviceValue, lastEvent>>

Init ==
    /\ protectedValue = 0
    /\ serviceValue = 0
    /\ lastEvent = "Init"

TypeOK ==
    /\ protectedValue \in Values
    /\ serviceValue \in Values
    /\ lastEvent \in Events

ProtectedIntegrity == protectedValue = 0

ConformingCall(v) ==
    /\ v \in Values
    /\ protectedValue' = protectedValue
    /\ serviceValue' = v
    /\ lastEvent' = "ConformingCall"

NativeWrite(v) ==
    /\ v \in Values
    /\ IF BoundaryEnforced
          THEN
            /\ protectedValue' = protectedValue
            /\ lastEvent' = "NativeWriteRejected"
          ELSE
            /\ protectedValue' = v
            /\ lastEvent' = "NativeWriteBypass"
    /\ UNCHANGED serviceValue

Next ==
    \/ \E v \in Values : ConformingCall(v)
    \/ \E v \in Values : NativeWrite(v)

Spec == Init /\ [][Next]_vars

=============================================================================
