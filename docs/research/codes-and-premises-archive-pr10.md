<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Error codes and missing premise (`FACT-09`, `PORT-07`) (PR #10 archive)

> **Status: non-normative archived research material.** This table comes from PR #10 (archive commit `d39d012`), which was closed without merge. It has not been reviewed or ratified by the author. This is an English translation made on 2026-10-14; the original French text and its exact provenance are recorded in the [PR #10 archive recovery lot](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 4 (deposit V-07). In case of discrepancy, the original prevails. The current normative source is `spec/`; the pairing below is a reading, not a statement of the manuscript.

> **Editorial note (2026-10-14): read against `main` at `7af5581`.**
>
> - **Phase numbers.** "Phase 2", "Phase 3", "Phase 4", "Phase 5" and "Phase 7" below follow the archive's consecutive numbering from 0 to 10 (archive `spec/Spec/C6/LeProcessusDeCompilation.lean`, l. 33-40), which `main` does not have. `main` keeps eight phases with the intercalary checkpoints 1.5 and 2.5 (`spec/Spec/C6/LeProcessusDeCompilation.lean`, l. 30-36): for example, strict linearity is "Phase 3" in the archive (l. 122) and "Phase 2" on `main` (l. 106), and the termination of the solver is "Phase 7" in the archive (l. 158) and "Phase 5" on `main` (l. 142). The numbering of the phases is an open decision (`docs/tracking/DECISIONS.md`, l. 65). The phase numbers below must not be read against `main`.
> - **The completeness guard does not exist on `main`.** The sentence stating that `scripts/controles/structure.py` checks that every code of the catalogue appears in this table describes the archive (archive `scripts/controles/structure.py`, function `error_codes_paired`, l. 114-120). On `main`, `scripts/controles/structure.py` has no such function and no script refers to this table. `scripts/controles/indexation.py` exists on `main`.
> - **Codes and labels.** The 48 codes paired below are exactly the 48 distinct `ERR-*` codes of annex A on `main` (`spec/Spec/AnnexeA/`). Every label cited exists on `main` except `tab:propagation-addition` (row `ERR-TYP-005`). Section numbers of the manuscript (§3.3, §4.4, §4.5) are those cited by the archive.
> - **Card state.** On `main`, `FACT-09` is partial, with the note "table code ⟷ prémisse à écrire (PORT-07)" (`docs/tracking/fiches-statuts.csv`, l. 97); `PORT-07` is closed (l. 45). This deposit does not change either card.

**Session 32 (6 October 2026).** Pairing of each of the **48 codes** of annex A with what is missing for the derivation to exist, as the card `FACT-09` asked (« rattacher chaque famille de codes à la prémisse manquante », "attach each family of codes to the missing premise"). The pairing is a **reading**: I carried it out by hand on the text of the trigger of each code (annex A) and on the premises of the rules (ch. 3). It is not written in the manuscript, which is not modified; it is to be ratified. `scripts/controles/indexation.py` does not read it, but `scripts/controles/structure.py` checks that each code of the catalogue appears here (completeness guard).

**Mechanisms** (column "Mech."): **A** absence of contraction or weakening (the derivation would require copying or abandoning a resource); **B** indexing by scope (a value leaves the region or scope that indexes it); **C** one-way nesting of delimiters or absence of a rule (layer boundary); **P** phase distinction (a compile-time object read at run time); **E** effect: the effect index is not neutral or is not covered; **K** coverage: a sum, a pattern or a message is not covered; **T** termination or productivity (size index); **S** bound or refinement obligation (budget, solver, certificate); **G** graph: acyclicity of the wiring; **H** outside the judgement: compilation policy, metric, hardware protocol.

| Code | Mech. | What is missing (rule, theorem or phase) |
|---|:-:|---|
| `ERR-TOP-001` | C | nesting rule of the delimiters (`tab:delimiteurs`): the fragment `( )` does not nest inside `[ ]`; checked in Phase 3 |
| `ERR-TOP-002` | C | same for `{ }` inside `[ ]` |
| `ERR-TOP-003` | P | `thm:schema_effacement`, `thm:non_interference`: no production path reads a compile-time object (the phase restriction does not derive it) |
| `ERR-TOP-005` | C | no synchronous tensor rule in layer 2: emission is primitively asynchronous (`Send`) |
| `ERR-TOP-011` | H | name resolution, Phase 4: topological filter without target |
| `ERR-POL-001` | H | policy P3: complete static resolution of calls, Phase 3 (monomorphisation) and Phase 4 |
| `ERR-TYP-010` | H | coherence of instance resolution: uniqueness per pair (type, trait), Phase 4 |
| `ERR-PUR-001` | E | effect index `𝟏` of a `pure` or `[ ]` block: `Fo`, `Op` conclude `ε ≠ 𝟏`; Phase 5 |
| `ERR-EFF-001` | E | coverage of the operation by a handler (`Op`, `Sc`); Phase 5 |
| `ERR-LOG-001` | K | `Case`: only the branches of a sum, exhaustive, condition; no imperative conditional |
| `ERR-TOP-010` | E | same as `ERR-PUR-001` for a function suffixed `!` |
| `ERR-TYP-009` | E | same as `ERR-EFF-001` for a function suffixed `?` |
| `ERR-TER-001` | T | `Fix` (`eq:regle-fix`): domain of finite height (`Trellis_fin`); no general recursion rule; `thm:terminaison_couche_3` |
| `ERR-IND-001` | T | `Cop`: the corecursive call is made at the lower size index (guard); `thm:productivite_couche_2` |
| `ERR-IND-003` | T | same: a tacit filter that may never emit has no decreasing index |
| `ERR-CMP-001` | A | `Var`, `Pair`: the usage `1` of a variable annotated `@linear` admits no contraction; `thm:lemme_capacite` |
| `ERR-CMP-004` | S | budget `β ⊖ k` defined (the function `ψ` is partial): the cost of the `comptime` evaluation exceeds the budget |
| `ERR-STK-001` | H | ordinary typing of application: arity of the argument (`App`, `Lam`) |
| `ERR-STK-003` | S | `𝒢_pile`, preimage of a projection of the grade: the stack height exceeds the preallocated size (solver, Phase 7) |
| `ERR-MEM-009` | A | weakening of a resource of usage `1`: a consumer abandons a non-exhausted `StreamContext` |
| `ERR-MEM-004` | A | contraction of a write capability: a canonical state borrowed for writing is not copied; `Slice` |
| `ERR-MEM-006` | H | memory model (§4.4): layout by relative offsets, outside the judgement |
| `ERR-TYP-006` | A | weakening of a resource `Lin T` or of a session endpoint before `end`; `Var` allows it only at grade zero |
| `ERR-CMP-003` | A | affine weakening of layer 2 conditioned on a constant destructor |
| `ERR-TOP-006` | H | memory model (§4.5), `E_repro`: barrier on an inter-core write |
| `ERR-TOP-007` | A | `Slice`, `Cap ρ`: the region is not reallocated while a part `ρ₁` is lent, `ρ = ρ₁ ⊎ ρ₂` |
| `ERR-TOP-008` | B | `Cap ρ`, `Arena`: a `tref` view does not leave the region that indexes it |
| `ERR-FFI-001` | A | trust boundary (§3.3), `thm:surete_ffi`: a linear `ForeignHandle` is neither copied nor abandoned |
| `ERR-TYP-008` | A | same (code merged with `ERR-FFI-001` in the catalogue) |
| `ERR-TYP-007` | H | ordinary typing of protocols: the type of the current state is that of the continuation `V ⊸ S` (`App`) |
| `ERR-TOP-009` | K | `Case` or `Proj` of the negative product: all the branches of `&{ℓ_i : S_i}` are handled |
| `ERR-ACT-002` | K | `Guard`: the decomposition `E = Σ P_i · E_i` does not cover the combination received; `thm:sync_motifs_jonction` |
| `ERR-ACT-003` | G | acyclicity of the dependency graph between actors and streams; `thm:liberte_initialisation` |
| `ERR-ARC-001` | G | acyclicity of the wiring graph, Phase 2; `thm:tri_topologique`, `thm:deadlock_acyclique` |
| `ERR-ARC-002` | H | design metric (centrality): no rule carries it |
| `ERR-TYP-011` | B | `Open`, side condition on the witness: the witness does not leave the scope of the existential when its grade is erasable |
| `ERR-TYP-012` | P | `Case`: the scrutinee must have a non-zero grade; no eliminator discriminates on an argument of the compile phase |
| `ERR-MAC-001` | B | `thm:hygiene`: the AST is indexed by scope; an undeclared capturable binding (`binds`) is outside the index |
| `ERR-MAC-002` | H | signature lint: `binds` without binding asserts nothing, no rule is violated |
| `ERR-SMT-001` | S | refinement obligation: the witness contradicts the inferred constraints, Phase 7 |
| `ERR-SMT-002` | S | refinement obligation falsified by a property test, mode `+verify` |
| `ERR-DPL-001` | H | versioned schema (`E_repro`): the pure morphism between schemas is not provided |
| `ERR-PKG-003` | S | certificate of the SMT proof of a package (certificate clause of Phase 7) |
| `ERR-CMP-002` | S | temporal types `○`, `□`, `◇` of the composition: rate schedule not compatible |
| `ERR-TYP-005` | K | `Case` on `Result(Float64, Singularity)`: the singularity case is not handled; `tab:propagation-addition` |
| `ERR-SLC-001` | A | `Slice`: the requested partition `ρ = ρ₁ ⊎ ρ₂` is not a partition |
| `ERR-ROW-001` | S | row solver (Phase 7): conflict of row constraints |
| `ERR-FLD-001` | S | same: conflict of field presence |

## What the table establishes, and what it does not

According to the table, the 48 codes are distributed as follows: **A** 9, **B** 3, **C** 3, **P** 2, **E** 4, **K** 4, **T** 3, **S** 8, **G** 2, **H** 10.
Only A, B, C and P — the four mechanisms of non-derivability that `FACT-09` names (absence of contraction, indexing by scope, nesting of delimiters, general principle of phase distinction) — reduce to "the missing premise is the one that would prevent the derivation": **17 codes out of 48**.

**The objective announced by review F, "18 families → 4 universal fibred diagnostics", is therefore not reached.** It holds for the 17 codes of structural non-derivability, whose diagnosis is said in one sentence ("this would require copying or abandoning", "this leaves the scope that indexes it", "this crosses a layer boundary", "this reads a compile-time object"). The 31 others fall under mechanisms that are not non-derivabilities: coverage of sums (4), effects (4), size indices (3), bounds and solver obligations (8), graph (2), and ten codes that the judgement does not carry (policies, lint, memory model). The prefix of the code does not follow the mechanism: `MEM`, `TOP`, `TYP` and `CMP` each carry codes of several mechanisms. The reduction "one family of codes, one diagnosis" is false; the reduction "one mechanism, one message type" is true for the 17 codes of non-derivability, and this is what the annex may take up if the author so decides.
