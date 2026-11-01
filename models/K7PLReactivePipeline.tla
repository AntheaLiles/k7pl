(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-12 candidate. Frame ticks are logical counters, not WCET or physical latency guarantees. *)
---------------- MODULE K7PLReactivePipeline ----------------
EXTENDS Naturals, Sequences, FiniteSets
CONSTANTS Events, InitialEvents, WriterCapabilityInitially, UnsafeLayer2Write, FrameLimit
ASSUME
    /\ IsFiniteSet(Events)
    /\ InitialEvents \subseteq Events
    /\ Events = {"Event1", "Event2"}
    /\ WriterCapabilityInitially \in BOOLEAN
    /\ UnsafeLayer2Write \in BOOLEAN
    /\ FrameLimit \in Nat \ {0}
EventRank(e) == IF e = "Event1" THEN 1 ELSE 2
VARIABLES delivered, pending, handled, handledOrder, logicalVersion, domVersion, patchReady,
          patchBase, patchTarget, appliedTargets, writerCapability, unauthorizedWrites, frame, frameOverrun
vars == <<delivered, pending, handled, handledOrder, logicalVersion, domVersion, patchReady,
          patchBase, patchTarget, appliedTargets, writerCapability, unauthorizedWrites, frame, frameOverrun>>
Init ==
    /\ delivered = InitialEvents
    /\ pending = InitialEvents
    /\ handled = {}
    /\ handledOrder = <<>>
    /\ logicalVersion = 0
    /\ domVersion = 0
    /\ patchReady = FALSE
    /\ patchBase = 0
    /\ patchTarget = 0
    /\ appliedTargets = {}
    /\ writerCapability = WriterCapabilityInitially
    /\ unauthorizedWrites = 0
    /\ frame = 0
    /\ frameOverrun = FALSE
TypeOK ==
    /\ delivered \subseteq Events
    /\ pending \subseteq Events
    /\ handled \subseteq Events
    /\ handledOrder \in Seq(Events)
    /\ logicalVersion \in Nat
    /\ domVersion \in Nat
    /\ patchReady \in BOOLEAN
    /\ patchBase \in Nat
    /\ patchTarget \in Nat
    /\ appliedTargets \subseteq Nat
    /\ writerCapability \in BOOLEAN
    /\ unauthorizedWrites \in Nat
    /\ frame \in 0..FrameLimit
    /\ frameOverrun \in BOOLEAN
ReceiveEvent(e) ==
    /\ e \in Events \ delivered
    /\ \A done \in handled : EventRank(done) < EventRank(e)
    /\ delivered' = delivered \cup {e}
    /\ pending' = pending \cup {e}
    /\ UNCHANGED <<handled, handledOrder, logicalVersion, domVersion, patchReady, patchBase,
                   patchTarget, appliedTargets, writerCapability, unauthorizedWrites, frame, frameOverrun>>
HandleEvent(e) ==
    /\ e \in pending
    /\ \A other \in pending : EventRank(e) <= EventRank(other)
    /\ ~patchReady
    /\ pending' = pending \ {e}
    /\ handled' = handled \cup {e}
    /\ handledOrder' = Append(handledOrder, e)
    /\ logicalVersion' = logicalVersion + 1
    /\ patchReady' = TRUE
    /\ patchBase' = domVersion
    /\ patchTarget' = logicalVersion + 1
    /\ UNCHANGED <<delivered, domVersion, appliedTargets, writerCapability, unauthorizedWrites, frame, frameOverrun>>
ApplyPatch ==
    /\ patchReady
    /\ patchBase = domVersion
    /\ (writerCapability \/ UnsafeLayer2Write)
    /\ domVersion' = patchTarget
    /\ patchReady' = FALSE
    /\ appliedTargets' = appliedTargets \cup {patchTarget}
    /\ unauthorizedWrites' = IF writerCapability THEN unauthorizedWrites ELSE unauthorizedWrites + 1
    /\ UNCHANGED <<delivered, pending, handled, handledOrder, logicalVersion, patchBase,
                   patchTarget, writerCapability, frame, frameOverrun>>
(* FrameLimit bounds exploration; it is not a physical frame-rate claim. *)
AdvanceFrame ==
    /\ frame < FrameLimit
    /\ frame' = frame + 1
    /\ frameOverrun' = frameOverrun \/ patchReady
    /\ UNCHANGED <<delivered, pending, handled, handledOrder, logicalVersion, domVersion,
                   patchReady, patchBase, patchTarget, appliedTargets, writerCapability, unauthorizedWrites>>
Next ==
    \/ \E receivedEvent \in Events : ReceiveEvent(receivedEvent)
    \/ \E handledEvent \in Events : HandleEvent(handledEvent)
    \/ ApplyPatch
    \/ AdvanceFrame
Spec == Init /\ [][Next]_vars
EventConservation == delivered = pending \cup handled /\ pending \cap handled = {}
StreamOrderPreserved ==
    \A i, j \in 1..Len(handledOrder) : i < j => EventRank(handledOrder[i]) < EventRank(handledOrder[j])
DOMWriteRequiresCapability == unauthorizedWrites = 0
PatchVersionConsistent == domVersion <= logicalVersion /\ (patchReady => patchBase = domVersion)
=============================================================================
