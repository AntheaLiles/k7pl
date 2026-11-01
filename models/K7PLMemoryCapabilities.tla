(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-07 candidate. Small generation bounds are counterexample devices, not production widths. *)
---------------- MODULE K7PLMemoryCapabilities ----------------
EXTENDS Naturals, FiniteSets

CONSTANTS
    Slots, Generations, MaxGeneration,
    Capabilities, Cells,
    AllowGenerationWrap, UnsafeStaleAccess, UnsafeRestoreRevive

CapSlot(c) == "SlotA"
CapCells(c) == IF c = "CapA" THEN {"CellA"} ELSE {"CellB"}
OwnerOf(c) == IF c = "CapA" THEN "FibreA" ELSE "FibreB"

ASSUME
    /\ IsFiniteSet(Slots)
    /\ IsFiniteSet(Generations)
    /\ IsFiniteSet(Capabilities)
    /\ IsFiniteSet(Cells)
    /\ Slots = {"SlotA"}
    /\ Capabilities = {"CapA", "CapB"}
    /\ Cells = {"CellA", "CellB"}
    /\ MaxGeneration \in Generations
    /\ AllowGenerationWrap \in BOOLEAN
    /\ UnsafeStaleAccess \in BOOLEAN
    /\ UnsafeRestoreRevive \in BOOLEAN

VARIABLES
    generation, activeSlots, staleGenerations,
    validCapabilities, revokedCapabilities, everRevokedCapabilities,
    capabilityGeneration, unsafeReuseSlots, owners, writtenCells,
    unauthorizedAccesses

vars == <<generation, activeSlots, staleGenerations,
          validCapabilities, revokedCapabilities, everRevokedCapabilities,
          capabilityGeneration, unsafeReuseSlots, owners, writtenCells,
          unauthorizedAccesses>>

Init ==
    /\ generation = [s \in Slots |-> 0]
    /\ activeSlots = {}
    /\ staleGenerations = [s \in Slots |-> {}]
    /\ validCapabilities = {}
    /\ revokedCapabilities = {}
    /\ everRevokedCapabilities = {}
    /\ capabilityGeneration = [c \in Capabilities |-> 0]
    /\ unsafeReuseSlots = {}
    /\ owners = [c \in Capabilities |-> OwnerOf(c)]
    /\ writtenCells = {}
    /\ unauthorizedAccesses = 0

TypeOK ==
    /\ generation \in [Slots -> Generations]
    /\ activeSlots \subseteq Slots
    /\ staleGenerations \in [Slots -> SUBSET Generations]
    /\ validCapabilities \subseteq Capabilities
    /\ revokedCapabilities \subseteq Capabilities
    /\ everRevokedCapabilities \subseteq Capabilities
    /\ capabilityGeneration \in [Capabilities -> Generations]
    /\ unsafeReuseSlots \subseteq Slots
    /\ owners \in [Capabilities -> {"FibreA", "FibreB"}]
    /\ writtenCells \subseteq {<<c, cell, fibre>> : c \in Capabilities, cell \in Cells, fibre \in {"FibreA", "FibreB"}}
    /\ unauthorizedAccesses \in Nat

Allocate(s) ==
    /\ s \in Slots \ activeSlots
    /\ (generation[s] \notin staleGenerations[s] \/ s \in unsafeReuseSlots)
    /\ activeSlots' = activeSlots \cup {s}
    /\ unsafeReuseSlots' = unsafeReuseSlots \ {s}
    /\ UNCHANGED <<generation, staleGenerations, validCapabilities,
                   revokedCapabilities, everRevokedCapabilities,
                   capabilityGeneration, owners, writtenCells,
                   unauthorizedAccesses>>

Destroy(s) ==
    /\ s \in activeSlots
    /\ activeSlots' = activeSlots \ {s}
    /\ staleGenerations' = [staleGenerations EXCEPT ![s] = @ \cup {generation[s]}]
    /\ validCapabilities' = validCapabilities \ {c \in validCapabilities : CapSlot(c) = s}
    /\ revokedCapabilities' =
         revokedCapabilities \cup {c \in validCapabilities : CapSlot(c) = s}
    /\ everRevokedCapabilities' =
         everRevokedCapabilities \cup {c \in validCapabilities : CapSlot(c) = s}
    /\ UNCHANGED <<generation, capabilityGeneration, unsafeReuseSlots,
                   owners, writtenCells, unauthorizedAccesses>>

ReuseSlot(s) ==
    LET nextGeneration == IF generation[s] = MaxGeneration THEN 0 ELSE generation[s] + 1
    IN
        /\ s \in Slots \ activeSlots
        /\ (AllowGenerationWrap \/ generation[s] # MaxGeneration)
        /\ generation' = [generation EXCEPT ![s] = nextGeneration]
        /\ unsafeReuseSlots' =
             IF AllowGenerationWrap /\ nextGeneration \in staleGenerations[s]
             THEN unsafeReuseSlots \cup {s}
             ELSE unsafeReuseSlots
        /\ UNCHANGED <<activeSlots, staleGenerations, validCapabilities,
                       revokedCapabilities, everRevokedCapabilities,
                       capabilityGeneration, owners, writtenCells,
                       unauthorizedAccesses>>

GrantCapability(c) ==
    LET slot == CapSlot(c)
    IN
        /\ c \in Capabilities
        /\ slot \in activeSlots
        /\ c \notin validCapabilities
        /\ c \notin revokedCapabilities
        /\ c \notin everRevokedCapabilities
        /\ validCapabilities' = validCapabilities \cup {c}
        /\ capabilityGeneration' =
             [capabilityGeneration EXCEPT ![c] = generation[slot]]
        /\ UNCHANGED <<generation, activeSlots, staleGenerations,
                       revokedCapabilities, everRevokedCapabilities,
                       unsafeReuseSlots, owners, writtenCells,
                       unauthorizedAccesses>>

TransferCapability(c, recipient) ==
    /\ c \in validCapabilities
    /\ recipient \in {"FibreA", "FibreB"}
    /\ recipient # owners[c]
    /\ owners' = [owners EXCEPT ![c] = recipient]
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, validCapabilities,
                   revokedCapabilities, everRevokedCapabilities,
                   capabilityGeneration, unsafeReuseSlots, writtenCells,
                   unauthorizedAccesses>>

RevokeCapability(c) ==
    /\ c \in validCapabilities
    /\ validCapabilities' = validCapabilities \ {c}
    /\ revokedCapabilities' = revokedCapabilities \cup {c}
    /\ everRevokedCapabilities' = everRevokedCapabilities \cup {c}
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, capabilityGeneration,
                   unsafeReuseSlots, owners, writtenCells, unauthorizedAccesses>>

RestoreRevokedCapability(c) ==
    /\ UnsafeRestoreRevive
    /\ c \in revokedCapabilities
    /\ revokedCapabilities' = revokedCapabilities \ {c}
    /\ validCapabilities' = validCapabilities \cup {c}
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, capabilityGeneration,
                   everRevokedCapabilities, unsafeReuseSlots, owners,
                   writtenCells, unauthorizedAccesses>>

WriteCell(c, cell, fibre) ==
    LET slot == CapSlot(c)
    IN
        /\ c \in validCapabilities
        /\ owners[c] = fibre
        /\ slot \in activeSlots
        /\ capabilityGeneration[c] = generation[slot]
        /\ cell \in CapCells(c)
        /\ writtenCells' = writtenCells \cup {<<c, cell, fibre>>}
        /\ UNCHANGED <<generation, activeSlots, staleGenerations, validCapabilities,
                       revokedCapabilities, everRevokedCapabilities,
                       capabilityGeneration, unsafeReuseSlots, owners,
                       unauthorizedAccesses>>

StaleAccess(c) ==
    /\ UnsafeStaleAccess
    /\ c \in revokedCapabilities
    /\ unauthorizedAccesses' = unauthorizedAccesses + 1
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, validCapabilities,
                   revokedCapabilities, everRevokedCapabilities,
                   capabilityGeneration, unsafeReuseSlots, owners, writtenCells>>

Next ==
    \/ \E s \in Slots : Allocate(s)
    \/ \E s \in Slots : Destroy(s)
    \/ \E s \in Slots : ReuseSlot(s)
    \/ \E c \in Capabilities : GrantCapability(c)
    \/ \E c \in Capabilities, recipient \in {"FibreA", "FibreB"} :
          TransferCapability(c, recipient)
    \/ \E c \in Capabilities : RevokeCapability(c)
    \/ \E c \in Capabilities : RestoreRevokedCapability(c)
    \/ \E c \in Capabilities, cell \in Cells, fibre \in {"FibreA", "FibreB"} :
          WriteCell(c, cell, fibre)
    \/ \E c \in Capabilities : StaleAccess(c)

Spec == Init /\ [][Next]_vars

NoStaleEntityAlias ==
    \A s \in activeSlots : generation[s] \notin staleGenerations[s]

ValidCapabilitiesMatchGeneration ==
    \A c \in validCapabilities :
        LET slot == CapSlot(c)
        IN
            /\ slot \in activeSlots
            /\ capabilityGeneration[c] = generation[slot]

NoCapabilityRevival == validCapabilities \cap everRevokedCapabilities = {}

NoUnauthorizedAccess == unauthorizedAccesses = 0

NoOverlappingWriteRights ==
    \A c1, c2 \in validCapabilities :
        c1 # c2 => CapCells(c1) \cap CapCells(c2) = {}

=============================================================================
