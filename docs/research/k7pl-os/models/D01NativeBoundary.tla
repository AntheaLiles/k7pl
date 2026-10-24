(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)

---------------- MODULE D01NativeBoundary ----------------
EXTENDS Naturals, Sequences

CONSTANT BoundaryEnforced
ASSUME BoundaryEnforced \in BOOLEAN

Values == {0, 1}
Events == {"ConformingCall", "NativeWriteRejected", "NativeWriteBypass"}

VARIABLES protectedValue, serviceValue, trace
vars == <<protectedValue, serviceValue, trace>>

Init ==
    /\ protectedValue = 0
    /\ serviceValue = 0
    /\ trace = <<>>

TypeOK ==
    /\ protectedValue \in Values
    /\ serviceValue \in Values
    /\ trace \in Seq(Events)

ProtectedIntegrity == protectedValue = 0

ConformingCall(v) ==
    /\ v \in Values
    /\ protectedValue' = protectedValue
    /\ serviceValue' = v
    /\ trace' = Append(trace, "ConformingCall")

NativeWrite(v) ==
    /\ v \in Values
    /\ IF BoundaryEnforced
          THEN
            /\ protectedValue' = protectedValue
            /\ trace' = Append(trace, "NativeWriteRejected")
          ELSE
            /\ protectedValue' = v
            /\ trace' = Append(trace, "NativeWriteBypass")
    /\ UNCHANGED serviceValue

Next ==
    \/ \E v \in Values : ConformingCall(v)
    \/ \E v \in Values : NativeWrite(v)

Spec == Init /\ [][Next]_vars

=============================================================================
