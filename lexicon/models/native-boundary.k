// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Non-normative K7OS profile model. It does not extend the K7PL language semantics.

module NATIVE-BOUNDARY
  imports INT
  imports BOOL

  syntax BoundaryOp ::= "conformingCall" "(" Int ")" [symbol(conformingCall)]
                      | "nativeWrite" "(" Bool "," Int ")" [symbol(nativeWrite)]
                      | "boundaryResult" "(" Int "," Int ")" [symbol(boundaryResult)]

  configuration <os>
                  <k> $PGM:BoundaryOp </k>
                  <protected> 0 </protected>
                  <service> 0 </service>
                </os>

  rule <k> conformingCall(I:Int) => boundaryResult(P:Int, I) </k>
       <protected> P:Int </protected>
       <service> _S:Int => I </service>
       [label(k7osConformingCall)]

  rule <k> nativeWrite(true, I:Int) => boundaryResult(P:Int, S:Int) </k>
       <protected> P:Int </protected>
       <service> S:Int </service>
       [label(k7osNativeWriteRejected)]

  rule <k> nativeWrite(false, I:Int) => boundaryResult(I, S:Int) </k>
       <protected> P:Int => I </protected>
       <service> S:Int </service>
       [label(k7osNativeWriteBypass)]
endmodule
