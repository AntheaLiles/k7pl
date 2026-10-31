(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-14 conditional candidate. Handshake state only; no cryptographic primitive is modelled or proved. *)
---------------- MODULE K7PLNoiseSession ----------------
EXTENDS Naturals, FiniteSets
CONSTANT UnsafeSkipMessage
ASSUME UnsafeSkipMessage \in BOOLEAN
VARIABLES clientPhase, serverPhase, sent, accepted, closed, failed
vars == <<clientPhase, serverPhase, sent, accepted, closed, failed>>
Init ==
    /\ clientPhase = 0
    /\ serverPhase = 0
    /\ sent = {}
    /\ accepted = {}
    /\ closed = FALSE
    /\ failed = FALSE
TypeOK ==
    /\ clientPhase \in 0..4
    /\ serverPhase \in 0..4
    /\ sent \subseteq {"ClientHello", "ServerHello", "ClientFinish", "ServerFinish"}
    /\ accepted \subseteq {"ClientHello", "ServerHello", "ClientFinish", "ServerFinish"}
    /\ closed \in BOOLEAN
    /\ failed \in BOOLEAN
SendClientHello ==
    /\ ~failed
    /\ clientPhase = 0
    /\ ~closed
    /\ sent' = sent \cup {"ClientHello"}
    /\ clientPhase' = 1
    /\ UNCHANGED <<serverPhase, accepted, closed, failed>>
AcceptClientHello ==
    /\ ~failed
    /\ serverPhase = 0
    /\ "ClientHello" \in sent
    /\ accepted' = accepted \cup {"ClientHello"}
    /\ serverPhase' = 1
    /\ UNCHANGED <<clientPhase, sent, closed, failed>>
SendServerHello ==
    /\ ~failed
    /\ serverPhase = 1
    /\ "ClientHello" \in accepted
    /\ sent' = sent \cup {"ServerHello"}
    /\ serverPhase' = 2
    /\ UNCHANGED <<clientPhase, accepted, closed, failed>>
AcceptServerHello ==
    /\ ~failed
    /\ clientPhase = 1
    /\ "ServerHello" \in sent
    /\ accepted' = accepted \cup {"ServerHello"}
    /\ clientPhase' = 2
    /\ UNCHANGED <<serverPhase, sent, closed, failed>>
SendClientFinish ==
    /\ ~failed
    /\ clientPhase = 2
    /\ "ServerHello" \in accepted
    /\ sent' = sent \cup {"ClientFinish"}
    /\ clientPhase' = 3
    /\ UNCHANGED <<serverPhase, accepted, closed, failed>>
AcceptClientFinish ==
    /\ ~failed
    /\ serverPhase = 2
    /\ "ClientFinish" \in sent
    /\ accepted' = accepted \cup {"ClientFinish"}
    /\ serverPhase' = 3
    /\ UNCHANGED <<clientPhase, sent, closed, failed>>
SendServerFinish ==
    /\ ~failed
    /\ serverPhase = 3
    /\ "ClientFinish" \in accepted
    /\ sent' = sent \cup {"ServerFinish"}
    /\ serverPhase' = 4
    /\ UNCHANGED <<clientPhase, accepted, closed, failed>>
AcceptServerFinish ==
    /\ ~failed
    /\ clientPhase = 3
    /\ serverPhase = 4
    /\ "ServerFinish" \in sent
    /\ accepted' = accepted \cup {"ServerFinish"}
    /\ clientPhase' = 4
    /\ closed' = TRUE
    /\ UNCHANGED <<serverPhase, sent, failed>>
UnsafeSkipAccept ==
    /\ ~failed
    /\ UnsafeSkipMessage
    /\ serverPhase = 2
    /\ "ClientFinish" \notin accepted
    /\ accepted' = accepted \cup {"ClientFinish"}
    /\ serverPhase' = 3
    /\ UNCHANGED <<clientPhase, sent, closed, failed>>
FailSession ==
    /\ ~closed
    /\ ~failed
    /\ failed' = TRUE
    /\ UNCHANGED <<clientPhase, serverPhase, sent, accepted, closed>>
Next ==
    \/ SendClientHello
    \/ AcceptClientHello
    \/ SendServerHello
    \/ AcceptServerHello
    \/ SendClientFinish
    \/ AcceptClientFinish
    \/ SendServerFinish
    \/ AcceptServerFinish
    \/ UnsafeSkipAccept
    \/ FailSession
Spec == Init /\ [][Next]_vars
NoPhaseSkip ==
    /\ ("ServerHello" \in accepted => "ClientHello" \in accepted)
    /\ ("ClientFinish" \in accepted => "ServerHello" \in accepted)
    /\ ("ServerFinish" \in accepted => "ClientFinish" \in accepted)
MessagesAcceptedWereSent == accepted \subseteq sent
ClosedHandshakeComplete ==
    closed => /\ clientPhase = 4 /\ serverPhase = 4 /\ "ServerFinish" \in accepted
=============================================================================
