<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Recovery status — K7PL

**Snapshot:** 2026-10-11, 13:20 Europe/Paris  
**Repository:** [AntheaLiles/k7pl](https://github.com/AntheaLiles/k7pl)  
**Purpose:** establish a restartable operational state after interrupted sessions. This is a dated tracking record, not a generated live view and not a scientific ratification.

## 1. Authoritative baseline

At snapshot time, `main` points to `5655628693eb86eca8f8bef026a1d1f384264a71`. Its latest observed verification-gate run is [38133276339](https://github.com/AntheaLiles/k7pl/actions/runs/38133276339), which reports `CI OK` success. The run was path-filtered: several full-build jobs (Lean implementation, Verso specification, PDF, TikZ and Python tools) were skipped for that status-only update. Do not interpret it as a fresh full build of every layer at that exact SHA.

The live source of project execution state remains [the project master plan](PROJECT-MASTER-PLAN.md), the [C object register](../migration/L1-THEORY-OBJECTS.md), [decisions and ratifications](DECISIONS.md), and [generated CI status](../STATUS.md). This page consolidates the status observed during recovery and must be refreshed before future merges, branch deletion, or publication.

## 2. Critical scientific gate: Stage C is OPEN

**C has not passed its exit gate. D–F and downstream E–J must not begin substantive work.**

PR [#54](https://github.com/AntheaLiles/k7pl/pull/54) was merged on 2026-10-08. This is delivery history, not evidence that the theoretical obligations are closed. The current gate in [L1-THEORY-OBJECTS.md](../migration/L1-THEORY-OBJECTS.md) explicitly remains **NON SATISFIED**.

The remaining matrix is C-01–C-09:

| ID | Residual obligation |
|---|---|
| C-01 | Explicit signatures and carriers for grades, usage, modes and central operations |
| C-02 | Domains and directions of modal relations; structural-mode morphisms and counterexamples |
| C-03 | `coerce`, `w`, `c`, conversions, `ConvCtx` and `Scale_Usage` laws |
| C-04 | `When`, `ψ`, `Cost_Budget`, `Adm` and `Consume` contract, rule by rule |
| C-05 | Exact definitions, domains and properties of `W`, `D` and cost scalarization |
| C-06 | Substitution closure under conversions, `Scale_Usage`, effects and effective repetition `φ_n` |
| C-07 | Source reduction, directional simulation `Sim`, traces and representation adequacy |
| C-08 | Abstract memory hypotheses H1/H2/H3 and the separate concrete representation profile `Π` |
| C-09 | External formal dependencies, exact assumptions, versions, mappings and proven scope |

Three human decisions remain material blockers, not choices for an agent to infer:

1. Ratify or revise the normative interpretation of P3/`When`, including whether resource consumption is checked across context through `ψ` and the exact role of `Adm`/`Consume`.
2. Resolve the source mismatch where `π_U` and `Scale_Usage` are still marked as architectural candidates in the normative source while session notes use them as the intended interface; decide whether `Cost_Budget` is partial or total under stated hypotheses.
3. Decide whether H1 is independently proved or explicitly retained as an assumption with its scope reduced; keep H2 and H3 distinct. If the candidate mode morphisms fail, evidence and consequences must be shown before a normative choice.

Session reports and conditional paper derivations are evidence for analysis, not proofs or automatic authorial ratifications. No edit to `spec/` or Lean semantics should be made just to remove a blocker from a register.

The open draft [PR #154](https://github.com/AntheaLiles/k7pl/pull/154) is already dedicated to documenting this residual C state. Its previous run, [38134812884](https://github.com/AntheaLiles/k7pl/actions/runs/38134812884), passed the aggregate tracking checks but skipped the core build/render jobs due to path filters. The added recovery material must receive a new run on its actual head; the earlier result does not validate later commits.

## 3. The attempted D session and BLOQ-12

Treat the D attempt as **blocked at the C dependency gate**, not as an authorized D implementation. The current mainline contains no new D PR demonstrating that BLOQ-12 is resolved. The old branch `split/pr10-3-singularites` is historical material; it is not authority to merge its prior approach into current `spec/`.

Until C closes, a D session may do only bounded dependency triage: locate the exact singular object and relevant claims, classify dependencies on C, record the evidence and stop before a normative decision, architectural extension, or source mutation. No E/F work may be launched in parallel to bypass this gate.

## 4. Open pull requests observed

Five PRs were open at snapshot time. Their states are distinct; a green run does not authorize a merge or imply scientific closure.

| PR | Workstream | Observed state | Restart action |
|---|---|---|---|
| [#154](https://github.com/AntheaLiles/k7pl/pull/154) | Stage C residual obligations | Draft tracking PR; last recorded run passed tracking checks, core jobs skipped | Review the C matrix and author-decision blockers; rerun checks after this recovery update. Keep C marked open. |
| [#148](https://github.com/AntheaLiles/k7pl/pull/148) | Generated status | Automated update to `docs/STATUS.md` on `automation/generated-status` | Treat as generated-only; do not hand-edit `docs/STATUS.md`. Refresh its status from the current mainline before integrating. |
| [#153](https://github.com/AntheaLiles/k7pl/pull/153) | Semantic documentation migration | Draft; its recorded full CI run succeeded, but its branch is 12 commits behind and has diverged from current `main` | Reconcile/rebase before merge; review the `spec/` and tooling changes as well as documentation. Physical migration remains closed. |
| [#139](https://github.com/AntheaLiles/k7pl/pull/139) | C8 statement ontology migration | Open; full CI passed on recorded head | Review the controlled migration of 69 historical labels plus five companion labels. Build/render validates document mechanics, not mathematical truth. |
| [#151](https://github.com/AntheaLiles/k7pl/pull/151) | Independent K — Lean/SPDX assurance evaluation | Draft; full CI passed on recorded head | Continue bounded evaluation separately from C; retain the no-go for production/global compliance claims. Reconcile its master-plan edits before merge. |

Related milestones already integrated: [#129](https://github.com/AntheaLiles/k7pl/pull/129) OpenSSF automation, [#131](https://github.com/AntheaLiles/k7pl/pull/131) shared C8 statement ontology, [#134](https://github.com/AntheaLiles/k7pl/pull/134) C8 ontology controls, [#147](https://github.com/AntheaLiles/k7pl/pull/147) Lean assurance plan closeout, and [#152](https://github.com/AntheaLiles/k7pl/pull/152) OpenSSF evidence closeout are recorded as merged. These do not close all follow-up work within their broader workstreams.

## 5. Remote branch inventory and handling policy

The API listed 33 branch references including `main`, of which the five open-PR heads above are the only current open-PR branches. See [BRANCHES-STATUS.md](BRANCHES-STATUS.md) for the classification. Its prior 2026-10-08 inventory was stale and is being replaced in this recovery change.

The remaining branch refs must not be mass-merged or mass-deleted. Some are branches for merged PRs retained after rebase/squash; commit ancestry counts therefore do not reliably indicate whether their content is unique. Use file-level comparison and PR history.

- Preserve `claude/lean4-reuse-init-qvzlcg` as a **non-normative scientific archive** until its unique session notes are reviewed against current C records.
- Preserve `repair/pr54-coherence-2026-10-08` for controlled review of its residual scientific material; do not merge it as a whole.
- Treat `feat/c8-controlled-statement-migration-ci` as superseded by #139; `feat/c8-shared-statement-ontology` by #131; `feat/c8-statement-dependency-check` and `feat/c8-dependency-cycle-audit` as superseded by the integrated dependency-check work. Do not resume these instead of the mainline PR.
- Treat old navigation/TikZ branches with merged counterparts as provenance only unless a specific missing artifact is demonstrated.
- Treat `split/pr10-1-outillage-spec` as explicitly abandoned; the other `split/pr10-*` branches are historical material, not ready-to-merge work.
- Treat `ci/diagnostic-localization`, `improvement-suggestions-c74e0`, and `feat/navigation-graph-mvp` as requiring content-level triage before deletion or reuse.

This snapshot does not authorize deleting branches. A subsequent dedicated branch-hygiene pass should reconcile every non-PR head, record whether any unique changes remain, and only then recommend deletions.

## 6. Parallel work that may continue without bypassing C

The C gate does not require idling unrelated work, but independent work must remain clearly isolated:

- **C8 / PR #139:** complete the ontology migration review, preserve the 69 historical labels and five companion objects, and do not infer theorem validity from command classification.
- **Semantic migration / PR #153:** finish its review and reconcile branch drift without reopening the physical directory migration or rewriting normative B/C/D content implicitly.
- **K / PR #151:** continue tests and cross-run characterization of the bounded Lake→SPDX audit; no production-compliance or exhaustive-SBOM claim.
- **OpenSSF:** #129 and #152 are integrated. Remaining tasks are external/human actions in [ACTIONS-HUMAINES.md](../security/ACTIONS-HUMAINES.md); a document update or CI result does not establish that settings, BadgeApp or Zenodo operations occurred.
- **Figures/navigation:** the mainline already contains static figure generation and the initial provenance/semantic navigation tranche. Remaining user-value and PDF/UA checks belong to that plan; do not reconstruct the merged prototype from old branches.

## 7. Resume order

1. Reconcile C evidence and authorial decisions; work through C-01–C-09.
2. Close the C gate only after an explicit evidence review says every obligation is proved, properly scoped/open by a ratified decision, or otherwise resolved under the documented exit criterion.
3. Only then resume D/BLOQ-12.
4. After D, proceed to E (parallel composition), then F (`spawn`), then G (ratifications/T-68), H (semantic spec↔Lean traceability), I (bounded implementation conformance), and J (release/reproducibility) in the dependency order in [PROJECT-MASTER-PLAN.md](PROJECT-MASTER-PLAN.md).
5. In every stage, check the live PR/branch/CI state again. Do not infer current status from this dated snapshot.

## 8. Completion semantics

A workstream may be marked complete only when its own exit criteria are evidenced. Keep these states distinct: implemented, compiled, tested, reviewed, author-ratified, scientifically established, operationally exercised, and released. No downstream stage may silently promote an upstream claim.
