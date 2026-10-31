(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)

---------------- MODULE TLA01SessionNetwork ----------------
EXTENDS Naturals, FiniteSets

CONSTANTS
    Actors, ActorIdA, ActorIdB, ActorIdC,
    External, NoActor, StaticDependencies,
    ReceiveFromA, ReceiveFromB, ReceiveFromC,
    SendToA, SendToB, SendToC,
    InitialResidualA, InitialResidualB, InitialResidualC,
    TimeoutsEnabled, ExternalDeliveryEnabled

ResidualStates == {"Recv", "Send", "End", "Aborted"}
InitialResidualStates == {"Recv", "Send", "End"}
ActorStates == {"Runnable", "Waiting", "Terminal", "Failed"}
TimeoutStates == {"Disabled", "Armed", "Expired"}
MessageSenders == Actors \cup {External}
Messages == MessageSenders \X Actors

ReceiveFrom(a) ==
    CASE a = ActorIdA -> ReceiveFromA
      [] a = ActorIdB -> ReceiveFromB
      [] OTHER -> ReceiveFromC

SendTo(a) ==
    CASE a = ActorIdA -> SendToA
      [] a = ActorIdB -> SendToB
      [] OTHER -> SendToC

InitialResidual(a) ==
    CASE a = ActorIdA -> InitialResidualA
      [] a = ActorIdB -> InitialResidualB
      [] OTHER -> InitialResidualC

StaticDependencyExists(a, b) ==
    \/ (a = ActorIdA /\ b = ActorIdB /\ "A>B" \in StaticDependencies)
    \/ (a = ActorIdA /\ b = ActorIdC /\ "A>C" \in StaticDependencies)
    \/ (a = ActorIdB /\ b = ActorIdA /\ "B>A" \in StaticDependencies)
    \/ (a = ActorIdB /\ b = ActorIdC /\ "B>C" \in StaticDependencies)
    \/ (a = ActorIdC /\ b = ActorIdA /\ "C>A" \in StaticDependencies)
    \/ (a = ActorIdC /\ b = ActorIdB /\ "C>B" \in StaticDependencies)

ASSUME
    /\ IsFiniteSet(Actors)
    /\ Cardinality(Actors) \in {2, 3}
    /\ External \notin Actors
    /\ NoActor \notin Actors
    /\ External # NoActor
    /\ Actors \subseteq {ActorIdA, ActorIdB, ActorIdC}
    /\ ActorIdA # ActorIdB
    /\ ActorIdA # ActorIdC
    /\ ActorIdB # ActorIdC
    /\ StaticDependencies \subseteq {"A>B", "A>C", "B>A", "B>C", "C>A", "C>B"}
    /\ ReceiveFromA \in (Actors \cup {External, NoActor})
    /\ ReceiveFromB \in (Actors \cup {External, NoActor})
    /\ ReceiveFromC \in (Actors \cup {External, NoActor})
    /\ SendToA \in (Actors \cup {NoActor})
    /\ SendToB \in (Actors \cup {NoActor})
    /\ SendToC \in (Actors \cup {NoActor})
    /\ InitialResidualA \in InitialResidualStates
    /\ InitialResidualB \in InitialResidualStates
    /\ InitialResidualC \in InitialResidualStates
    /\ TimeoutsEnabled \in BOOLEAN
    /\ ExternalDeliveryEnabled \in BOOLEAN
    /\ \A a \in Actors : ReceiveFrom(a) # a
    /\ \A a \in Actors : SendTo(a) # a
    /\ \A a \in Actors :
          InitialResidual(a) = "Recv" => ReceiveFrom(a) \in (Actors \cup {External})
    /\ \A a \in Actors :
          InitialResidual(a) = "Send" => SendTo(a) \in Actors

VARIABLES
    residual,
    actorStatus,
    mailboxes,
    waitTarget,
    timeoutStatus,
    sent,
    consumed

vars == <<residual, actorStatus, mailboxes, waitTarget, timeoutStatus, sent, consumed>>

ExpectedMessage(a) == <<ReceiveFrom(a), a>> \in mailboxes[a]

Init ==
    /\ residual = [a \in Actors |-> InitialResidual(a)]
    /\ actorStatus =
          [a \in Actors |->
              IF InitialResidual(a) = "End" THEN "Terminal" ELSE "Runnable"]
    /\ mailboxes = [a \in Actors |-> {}]
    /\ waitTarget = [a \in Actors |-> NoActor]
    /\ timeoutStatus = [a \in Actors |-> "Disabled"]
    /\ sent = {}
    /\ consumed = {}

TypeOK ==
    /\ residual \in [Actors -> ResidualStates]
    /\ actorStatus \in [Actors -> ActorStates]
    /\ mailboxes \in [Actors -> SUBSET Messages]
    /\ waitTarget \in [Actors -> (Actors \cup {External, NoActor})]
    /\ timeoutStatus \in [Actors -> TimeoutStates]
    /\ sent \subseteq Messages
    /\ consumed \subseteq Messages

SessionEndpointDuality ==
    /\ \A receiver \in Actors :
          ReceiveFrom(receiver) \in Actors =>
              SendTo(ReceiveFrom(receiver)) = receiver
    /\ \A sender \in Actors :
          SendTo(sender) \in Actors =>
              ReceiveFrom(SendTo(sender)) = sender

StaticHasCycle(relation) ==
    \/ \E a \in Actors : <<a, a>> \in relation
    \/ \E a, b \in Actors :
          /\ a # b
          /\ <<a, b>> \in relation
          /\ <<b, a>> \in relation
    \/ \E a, b, c \in Actors :
          /\ a # b
          /\ b # c
          /\ a # c
          /\ <<a, b>> \in relation
          /\ <<b, c>> \in relation
          /\ <<c, a>> \in relation

StaticDependencyEdges ==
    UNION {
        {<<a, b>> : b \in Actors /\ StaticDependencyExists(a, b)} :
            a \in Actors
    }

StaticAcyclic == ~StaticHasCycle(StaticDependencyEdges)

WaitFor ==
    {<<a, waitTarget[a]>> :
        a \in Actors /\ actorStatus[a] = "Waiting" /\ waitTarget[a] \in Actors}

ExternalWaiters ==
    {a \in Actors : actorStatus[a] = "Waiting" /\ waitTarget[a] = External}

WaitingOnFailedActor ==
    {a \in Actors :
        actorStatus[a] = "Waiting" /\ waitTarget[a] \in Actors /\
        actorStatus[waitTarget[a]] = "Failed"}

InternalWaitCycle == StaticHasCycle(WaitFor)

(* A timeout-enabled waiter is an available escape from the current wait cycle. *)
NonTimeoutWaitFor ==
    {edge \in WaitFor : timeoutStatus[edge[1]] # "Armed"}

MutualWaitDeadlock == StaticHasCycle(NonTimeoutWaitFor)
NoMutualWaitDeadlock == ~MutualWaitDeadlock

(* This is the explicit premise (Sim) of thm:deadlock_acyclique. *)
Simulation == WaitFor \subseteq StaticDependencyEdges

ActiveActors ==
    {a \in Actors : actorStatus[a] \notin {"Terminal", "Failed"}}

AllActorsTerminal == \A a \in Actors : actorStatus[a] = "Terminal"
AllActorsQuiescent ==
    \A a \in Actors : actorStatus[a] \in {"Terminal", "Failed"}

PendingMessages == UNION {mailboxes[a] : a \in Actors}
MessageConservation ==
    /\ sent = PendingMessages \cup consumed
    /\ PendingMessages \cap consumed = {}
    /\ PendingMessages \subseteq sent
    /\ consumed \subseteq sent

MailboxOwnership ==
    \A receiver \in Actors :
        \A message \in mailboxes[receiver] : message[2] = receiver

StateConsistency ==
    /\ \A a \in Actors :
          actorStatus[a] = "Waiting" =>
              /\ residual[a] = "Recv"
              /\ waitTarget[a] = ReceiveFrom(a)
              /\ ~ExpectedMessage(a)
              /\ timeoutStatus[a] =
                    IF TimeoutsEnabled THEN "Armed" ELSE "Disabled"
    /\ \A a \in Actors :
          actorStatus[a] # "Waiting" => waitTarget[a] = NoActor
    /\ \A a \in Actors :
          actorStatus[a] = "Terminal" => residual[a] = "End"
    /\ \A a \in Actors :
          actorStatus[a] = "Failed" => residual[a] = "Aborted"
    /\ \A a \in Actors :
          residual[a] = "Send" => actorStatus[a] = "Runnable"
    /\ \A a \in Actors :
          timeoutStatus[a] = "Armed" => actorStatus[a] = "Waiting"

Block(a) ==
    /\ actorStatus[a] = "Runnable"
    /\ residual[a] = "Recv"
    /\ ReceiveFrom(a) \in (Actors \cup {External})
    /\ ~ExpectedMessage(a)
    /\ actorStatus' = [actorStatus EXCEPT ![a] = "Waiting"]
    /\ waitTarget' = [waitTarget EXCEPT ![a] = ReceiveFrom(a)]
    /\ timeoutStatus' =
          [timeoutStatus EXCEPT
              ![a] = IF TimeoutsEnabled THEN "Armed" ELSE "Disabled"]
    /\ UNCHANGED <<residual, mailboxes, sent, consumed>>

Send(a) ==
    /\ actorStatus[a] = "Runnable"
    /\ residual[a] = "Send"
    /\ SendTo(a) \in Actors
    /\ LET receiver == SendTo(a)
           message == <<a, receiver>>
           wakesReceiver ==
               actorStatus[receiver] = "Waiting" /\ waitTarget[receiver] = a
       IN
           /\ message \notin sent
           /\ mailboxes' =
                 [mailboxes EXCEPT ![receiver] = @ \cup {message}]
           /\ sent' = sent \cup {message}
           /\ actorStatus' =
                 IF wakesReceiver
                 THEN [actorStatus EXCEPT
                         ![a] = "Terminal",
                         ![receiver] = "Runnable"]
                 ELSE [actorStatus EXCEPT ![a] = "Terminal"]
           /\ waitTarget' =
                 IF wakesReceiver
                 THEN [waitTarget EXCEPT ![receiver] = NoActor]
                 ELSE waitTarget
           /\ timeoutStatus' =
                 IF wakesReceiver
                 THEN [timeoutStatus EXCEPT ![receiver] = "Disabled"]
                 ELSE timeoutStatus
    /\ residual' = [residual EXCEPT ![a] = "End"]
    /\ UNCHANGED consumed

Consume(a) ==
    /\ actorStatus[a] = "Runnable"
    /\ residual[a] = "Recv"
    /\ ReceiveFrom(a) \in (Actors \cup {External})
    /\ ExpectedMessage(a)
    /\ LET message == <<ReceiveFrom(a), a>>
           nextResidual == IF SendTo(a) \in Actors THEN "Send" ELSE "End"
           nextStatus == IF SendTo(a) \in Actors THEN "Runnable" ELSE "Terminal"
       IN
           /\ mailboxes' = [mailboxes EXCEPT ![a] = @ \ {message}]
           /\ consumed' = consumed \cup {message}
           /\ residual' = [residual EXCEPT ![a] = nextResidual]
           /\ actorStatus' = [actorStatus EXCEPT ![a] = nextStatus]
    /\ UNCHANGED <<waitTarget, timeoutStatus, sent>>

ExternalDeliver(a) ==
    /\ ExternalDeliveryEnabled
    /\ ReceiveFrom(a) = External
    /\ actorStatus[a] \in {"Runnable", "Waiting"}
    /\ residual[a] = "Recv"
    /\ LET message == <<External, a>>
           wakesReceiver == actorStatus[a] = "Waiting"
       IN
           /\ message \notin sent
           /\ mailboxes' = [mailboxes EXCEPT ![a] = @ \cup {message}]
           /\ sent' = sent \cup {message}
           /\ actorStatus' =
                 IF wakesReceiver
                 THEN [actorStatus EXCEPT ![a] = "Runnable"]
                 ELSE actorStatus
           /\ waitTarget' =
                 IF wakesReceiver
                 THEN [waitTarget EXCEPT ![a] = NoActor]
                 ELSE waitTarget
           /\ timeoutStatus' =
                 IF wakesReceiver
                 THEN [timeoutStatus EXCEPT ![a] = "Disabled"]
                 ELSE timeoutStatus
    /\ UNCHANGED <<residual, consumed>>

Timeout(a) ==
    /\ actorStatus[a] = "Waiting"
    /\ timeoutStatus[a] = "Armed"
    /\ ~ExpectedMessage(a)
    /\ actorStatus' = [actorStatus EXCEPT ![a] = "Failed"]
    /\ residual' = [residual EXCEPT ![a] = "Aborted"]
    /\ waitTarget' = [waitTarget EXCEPT ![a] = NoActor]
    /\ timeoutStatus' = [timeoutStatus EXCEPT ![a] = "Expired"]
    /\ UNCHANGED <<mailboxes, sent, consumed>>

Next ==
    \/ \E a \in Actors : Block(a)
    \/ \E a \in Actors : Send(a)
    \/ \E a \in Actors : Consume(a)
    \/ \E a \in Actors : ExternalDeliver(a)
    \/ \E a \in Actors : Timeout(a)

Spec == Init /\ [][Next]_vars

=============================================================================
