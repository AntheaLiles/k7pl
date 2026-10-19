<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# k7pl

k7pl is a programming language implemented in Lean 4 with Mathlib and CSLib. Its specification is written in Verso.

## Repository architecture

- `src/`: Lean 4 implementation (CECILL-2.1).
- `tests/`: Lean tests (CECILL-2.1).
- `spec/`: Verso specification (CC-BY-4.0), current normative source.
- `tools/`: Verso generator and extensions, generated bibliography.
- `docs/`: tracking, decisions, research, audits; entry point: `docs/tracking/DASHBOARD.md`.
- `docs/archives/`: frozen former manuscript and tooling; do not correct them to change the current version.
- `.claude/rules/`: specialised rules.
- `.claude/skills/`: reusable procedures.
- `.claude/agents/`: specialised roles and model settings.

Only the specification (`spec/`) is written in French. Everything else is in English: code, identifiers, comments, docstrings, documentation, tracking, agent, rule and skill files, issues, PRs and commit messages. Strings that are rendered into the specification follow it and stay in French. File names are in English. Historical and evidence records (`docs/history/`, `docs/archives/`, `docs/peer-review/`, dated audits) are not translated: they are kept until their content has been analysed and arbitrated (moved elsewhere, abandoned, etc.), then deleted progressively.

## Non-negotiable invariants

`spec/`, `src/`, `tests/` and `docs/` are objects of different kinds. A specification claim, a Lean definition, a proof and a test are never interchangeable.

The manuscript carries the instruction « ne rien modifier sans l'accord de l'auteur » ("change nothing without the author's consent"). Any normative change to `spec/` therefore requires an explicit request and a minimal scope.

Never introduce `sorry`, `admit`, a new `axiom` or `native_decide`. Never weaken a check to make CI, Scorecard or CII pass.

Never invent a review, a contributor, a signature, provenance, an SBOM, a proof of reproducibility or compliance.

Read `.claude/rules/project.md` for any substantial task, then the specialised rule for the area being changed. Read `.claude/skills/writing-rules.md` before any change to code, tests or the specification.

## Epistemic separation

A task that spans the specification and Lean must make explicit:

`specification → formalisation → implementation → proof → test`.

Never silently adapt the specification to the implementation, nor the implementation to an unestablished interpretation of the specification.

The following statuses are distinct: intuition, definition, argued assertion, formalised property, proved property, tested property.

## Agent routing

Agents are roles; skills are procedures. The main session remains the architect and the integrator.

### Specification

- `spec-architect`: design, dependencies, cross-chapter trade-offs; mostly read-only.
- `formal-reviewer`: adversarial review, hypotheses and counterexamples; read-only.
- `spec-editor`: Verso editing, when explicitly requested.
- `consistency-auditor`: consistency `spec ↔ Lean ↔ tests ↔ docs`.

### Lean

- `theorem-prover`: proofs of statements that are already stabilised.
- `lean-implementer`: implementation of `src/` and `tests/`.
- `lean-debugger`: diagnosis and minimal fixes.
- `verification-specialist`: independent verification of the change.

### Assurance

The agents `scorecard-specialist`, `cii-specialist`, `github-governance-specialist`, `supply-chain-release-specialist`, `security-assurance-specialist` and `quality-reproducibility-specialist` form an independent OpenSSF/security assurance layer.

## Models

The `model`, `effort` and `isolation` settings of the subagents are defined in their files. Do not duplicate them in an ad hoc instruction, and do not override them arbitrarily.

For architecture, theory, security, governance or integration tasks, the main session prefers Opus 5.5 with effort `high`. Operational roles use Sonnet 5.5 with effort `high` when their definition says so.

## Orchestration

For a local task, use a single relevant agent.

For a substantial task, follow two waves:

1. **Audit**: launch the relevant agents in parallel, without concurrent changes to the same files. Each agent produces observed facts, evidence, gaps, recommendations and remaining human actions.
2. **Implementation**: after comparing the reports, split the files along responsibility boundaries, integrate the retained changes, then have the whole verified.

Never run several agents that write to the same file at the same time.

For a `spec → Lean` chain, prefer:

`spec-architect → formal-reviewer → (theorem-prover | lean-implementer) → consistency-auditor → verification-specialist`.

For a local Lean fix:

`lean-debugger → verification-specialist`.

For an explicitly authorised editorial change:

`spec-editor → validate-spec`.

For a cross-cutting OpenSSF audit, use the six assurance agents in parallel, then integrate their conclusions before any change.

## Validation

A change is not finished because an agent says it is finished.

For Lean, run at least the relevant checks among:

`lake build`, `lake test`, `lake lint`, `reuse lint`.

For `spec/`, use the repository's Verso checks, in particular:

`lake build Spec`, `lake exe spec --output _out/spec --with-tex`, `python3 scripts/controle.py`.

Also run the tracking checks when the files they cover change.

Classify the results:

`VERIFIED` · `PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE`.

An external or human validation must never be presented as already obtained.

## Documentation

The detailed rules on style, structure, REUSE, tests and commits remain in `.claude/skills/writing-rules.md`.

Domain procedures are in the specialised skills:

- `.claude/skills/spec/` for Verso;
- `.claude/skills/lean/` for Lean 4;
- `.claude/skills/research/` for research;
- `.claude/skills/engineering/` for planning, verification and review.

The `SessionStart` hook (`scripts/claude-session-start.sh`) prepares the Lean environment of web sessions when the network allows it.
