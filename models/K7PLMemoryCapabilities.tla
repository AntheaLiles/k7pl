(* SPDX-FileCopyrightText: 2026 Cyprien PIERRE *)
(* SPDX-License-Identifier: CC-BY-4.0 *)
(* TLA-07 candidate. Small generation bounds are counterexample devices, not production widths. *)
---------------- MODULE K7PLMemoryCapabilities ----------------
EXTENDS Naturals, FiniteSets
CONSTANTS
    Slots, Generations, MaxGeneration,
    Capabilities, CapSlot, CapCells, OwnerOf, Cells,
    AllowGenerationWrap, UnsafeStaleAccess, UnsafeRestoreRevive
ASSUME
    /\ IsFiniteSet(Slots)
    /\ IsFiniteSet(Generations)
    /\ IsFiniteSet(Capabilities)
    /\ IsFiniteSet(Cells)
    /\ MaxGeneration \in Generations
    /\ CapSlot \in [Capabilities -> Slots]
    /\ CapCells \in [Capabilities -> SUBSET Cells]
    /\ OwnerOf \in [Capabilities -> {"FibreA", "FibreB"}]
    /\ AllowGenerationWrap \in BOOLEAN
    /\ UnsafeStaleAccess \in BOOLEAN
    /\ UnsafeRestoreRevive \in BOOLEAN
VARIABLES
    generation, activeSlots, staleGenerations,
    validCapabilities, revokedCapabilities, capabilityGeneration,
    owners, unauthorizedAccesses
vars == <<generation, activeSlots, staleGenerations,
          validCapabilities, revokedCapabilities, capabilityGeneration,
          owners, unauthorizedAccesses>>
Init ==
    /\ generation = [s \in Slots |-> 0]
    /\ activeSlots = {}
    /\ staleGenerations = [s \in Slots |-> {}]
    /\ validCapabilities = {}
    /\ revokedCapabilities = {}
    /\ capabilityGeneration = [c \in Capabilities |-> 0]
    /\ owners = OwnerOf
    /\ unauthorizedAccesses = 0
TypeOK ==
    /\ generation \in [Slots -> Generations]
    /\ activeSlots \subseteq Slots
    /\ staleGenerations \in [Slots -> SUBSET Generations]
    /\ validCapabilities \subseteq Capabilities
    /\ revokedCapabilities \subseteq Capabilities
    /\ capabilityGeneration \in [Capabilities -> Generations]
    /\ owners \in [Capabilities -> {"FibreA", "FibreB"}]
    /\ unauthorizedAccesses \in Nat
Allocate(s) ==
    /\ s \in Slots \ activeSlots
    /\ activeSlots' = activeSlots \cup {s}
    /\ UNCHANGED <<generation, staleGenerations, validCapabilities,
                   revokedCapabilities, capabilityGeneration, owners, unauthorizedAccesses>>
Destroy(s) ==
    /\ s \in activeSlots
    /\ activeSlots' = activeSlots \ {s}
    /\ staleGenerations' = [staleGenerations EXCEPT ![s] = @ \cup {generation[s]}]
    /\ validCapabilities' = validCapabilities \ {c \in validCapabilities : CapSlot[c] = s}
    /\ revokedCapabilities' = revokedCapabilities \cup {c \in validCapabilities : CapSlot[c] = s}
    /\ UNCHANGED <<generation, capabilityGeneration, owners, unauthorizedAccesses>>
ReuseSlot(s) ==
    /\ s \in Slots \ activeSlots
    /\ (AllowGenerationWrap \/ generation[s] # MaxGeneration)
    /\ generation' =
         [generation EXCEPT
             ![s] = IF @ = MaxGeneration THEN 0 ELSE @ + 1]
    /\ UNCHANGED <<activeSlots, staleGenerations, validCapabilities,
                   revokedCapabilities, capabilityGeneration, owners, unauthorizedAccesses>>
GrantCapability(c) ==
    /\ c \in Capabilities
    /\ CapSlot[c] \in activeSlots
    /\ c \notin validCapabilities
    /\ c \notin revokedCapabilities
    /\ validCapabilities' = validCapabilities \cup {c}
    /\ capabilityGeneration' =
         [capabilityGeneration EXCEPT ![c] = generation[CapSlot[c]]]
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, revokedCapabilities,
                   owners, unauthorizedAccesses>>
RevokeCapability(c) ==
    /\ c \in validCapabilities
    /\ validCapabilities' = validCapabilities \ {c}
    /\ revokedCapabilities' = revokedCapabilities \cup {c}
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, capabilityGeneration,
                   owners, unauthorizedAccesses>>
RestoreRevokedCapability(c) ==
    /\ UnsafeRestoreRevive
    /\ c \in revokedCapabilities
    /\ revokedCapabilities' = revokedCapabilities \ {c}
    /\ validCapabilities' = validCapabilities \cup {c}
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, capabilityGeneration,
                   owners, unauthorizedAccesses>>
WriteCell(c, cell) ==
    /\ c \in validCapabilities
    /\ CapSlot[c] \in activeSlots
    /\ capabilityGeneration[c] = generation[CapSlot[c]]
    /\ cell \in CapCells[c]
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, validCapabilities,
                   revokedCapabilities, capabilityGeneration, owners, unauthorizedAccesses>>
StaleAccess(c) ==
    /\ UnsafeStaleAccess
    /\ c \in revokedCapabilities
    /\ unauthorizedAccesses' = unauthorizedAccesses + 1
    /\ UNCHANGED <<generation, activeSlots, staleGenerations, validCapabilities,
                   revokedCapabilities, capabilityGeneration, owners>>
Next ==
    \/ \E s \in Slots : Allocate(s)
    \/ \E s \in Slots : Destroy(s)
    \/ \E s \in Slots : ReuseSlot(s)
    \/ \E c \in Capabilities : GrantCapability(c)
    \/ \E c \in Capabilities : RevokeCapability(c)
    \/ \E c \in Capabilities : RestoreRevokedCapability(c)
    \/ \E c \in Capabilities, cell \in Cells : WriteCell(c, cell)
    \/ \E c \in Capabilities : StaleAccess(c)
Spec == Init /\ [][Next]_vars
NoStaleEntityAlias ==
    \A s \in activeSlots : generation[s] \notin staleGenerations[s]
ValidCapabilitiesMatchGeneration ==
    \A c \in validCapabilities :
        /\ CapSlot[c] \in activeSlots
        /\ capabilityGeneration[c] = generation[CapSlot[c]]
NoCapabilityRevival == validCapabilities \cap revokedCapabilities = {}
NoUnauthorizedAccess == unauthorizedAccesses = 0
NoOverlappingWriteRights ==
    \A c1, c2 \in validCapabilities :
        c1 # c2 => CapCells[c1] \cap CapCells[c2] = {}
=============================================================================
