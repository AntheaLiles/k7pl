(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-04 candidate. Snapshot persistence is atomic in this abstraction; storage crash consistency is external. *)
---------------- MODULE K7PLActorLifecycle ----------------
EXTENDS Naturals, Sequences, FiniteSets
CONSTANTS Events, InitialMailbox, DeltaOf, UnsafePublishEarly
ASSUME
    /\ IsFiniteSet(Events)
    /\ InitialMailbox \subseteq Events
    /\ DeltaOf \in [Events -> Nat]
    /\ UnsafePublishEarly \in BOOLEAN
VARIABLES
    phase, mailbox, processed, journal, logicalState,
    snapshotDurable, snapshotPublished, snapshotCursor, snapshotState,
    replayCursor, replayState
vars == <<phase, mailbox, processed, journal, logicalState,
          snapshotDurable, snapshotPublished, snapshotCursor, snapshotState,
          replayCursor, replayState>>
Init ==
    /\ phase = "Running"
    /\ mailbox = InitialMailbox
    /\ processed = {}
    /\ journal = <<>>
    /\ logicalState = 0
    /\ snapshotDurable = FALSE
    /\ snapshotPublished = FALSE
    /\ snapshotCursor = 0
    /\ snapshotState = 0
    /\ replayCursor = 0
    /\ replayState = 0
TypeOK ==
    /\ phase \in {"Running", "Frozen", "Failed", "Restoring"}
    /\ mailbox \subseteq Events
    /\ processed \subseteq Events
    /\ journal \in Seq(Events)
    /\ logicalState \in Nat
    /\ snapshotDurable \in BOOLEAN
    /\ snapshotPublished \in BOOLEAN
    /\ snapshotCursor \in Nat
    /\ snapshotState \in Nat
    /\ replayCursor \in Nat
    /\ replayState \in Nat
Process(e) ==
    /\ phase = "Running"
    /\ e \in mailbox
    /\ mailbox' = mailbox \ {e}
    /\ processed' = processed \cup {e}
    /\ journal' = Append(journal, e)
    /\ logicalState' = logicalState + DeltaOf[e]
    /\ UNCHANGED <<phase, snapshotDurable, snapshotPublished, snapshotCursor,
                   snapshotState, replayCursor, replayState>>
Freeze ==
    /\ phase = "Running"
    /\ phase' = "Frozen"
    /\ UNCHANGED <<mailbox, processed, journal, logicalState, snapshotDurable,
                   snapshotPublished, snapshotCursor, snapshotState, replayCursor, replayState>>
PersistSnapshot ==
    /\ phase = "Frozen"
    /\ Len(journal) > 0
    /\ ~snapshotDurable
    /\ snapshotCursor' = Len(journal) - 1
    /\ snapshotState' = logicalState - DeltaOf[journal[Len(journal)]]
    /\ snapshotDurable' = TRUE
    /\ UNCHANGED <<phase, mailbox, processed, journal, logicalState, snapshotPublished,
                   replayCursor, replayState>>
PublishSnapshot ==
    /\ phase = "Frozen"
    /\ (snapshotDurable \/ UnsafePublishEarly)
    /\ ~snapshotPublished
    /\ snapshotPublished' = TRUE
    /\ UNCHANGED <<phase, mailbox, processed, journal, logicalState, snapshotDurable,
                   snapshotCursor, snapshotState, replayCursor, replayState>>
ReleaseVolatileState ==
    /\ phase = "Frozen"
    /\ snapshotPublished
    /\ phase' = "Failed"
    /\ UNCHANGED <<mailbox, processed, journal, logicalState, snapshotDurable,
                   snapshotPublished, snapshotCursor, snapshotState, replayCursor, replayState>>
Crash ==
    /\ phase \in {"Running", "Frozen"}
    /\ phase' = "Failed"
    /\ UNCHANGED <<mailbox, processed, journal, logicalState, snapshotDurable,
                   snapshotPublished, snapshotCursor, snapshotState, replayCursor, replayState>>
BeginRestore ==
    /\ phase = "Failed"
    /\ snapshotPublished
    /\ snapshotDurable
    /\ phase' = "Restoring"
    /\ replayCursor' = snapshotCursor
    /\ replayState' = snapshotState
    /\ UNCHANGED <<mailbox, processed, journal, logicalState, snapshotDurable,
                   snapshotPublished, snapshotCursor, snapshotState>>
ReplayOne ==
    /\ phase = "Restoring"
    /\ replayCursor < Len(journal)
    /\ replayState' = replayState + DeltaOf[journal[replayCursor + 1]]
    /\ replayCursor' = replayCursor + 1
    /\ UNCHANGED <<phase, mailbox, processed, journal, logicalState, snapshotDurable,
                   snapshotPublished, snapshotCursor, snapshotState>>
FinishRestore ==
    /\ phase = "Restoring"
    /\ replayCursor = Len(journal)
    /\ logicalState' = replayState
    /\ phase' = "Running"
    /\ UNCHANGED <<mailbox, processed, journal, snapshotDurable, snapshotPublished,
                   snapshotCursor, snapshotState, replayCursor, replayState>>
Next ==
    \/ \E e \in Events : Process(e)
    \/ Freeze
    \/ PersistSnapshot
    \/ PublishSnapshot
    \/ ReleaseVolatileState
    \/ Crash
    \/ BeginRestore
    \/ ReplayOne
    \/ FinishRestore
Spec == Init /\ [][Next]_vars
NoMessageLoss ==
    mailbox \cup processed = InitialMailbox
    /\ mailbox \cap processed = {}
PublishedSnapshotDurable == snapshotPublished => snapshotDurable
ReplayCursorBounded == replayCursor <= Len(journal)
=============================================================================
