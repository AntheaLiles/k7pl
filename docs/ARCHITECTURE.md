<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Architecture

K7PL separates what it specifies from what it formalizes, implements, proves, and tests.

**Document version:** 1.0.0  
**Last updated:** 2026-10-06  
**Audience:** researchers, reviewers, contributors.

## Conceptual architecture

    Scientific question
            │
            ▼
       Specification
            │
            ▼
       Formalisation
            │
            ▼
       Implementation
          /       \
         ▼         ▼
      Proofs      Tests
          \       /
           ▼     ▼
           Assurance

The arrows indicate intended relationships, not automatic guarantees.

The specification states normative commitments. Formalisation represents selected formalizable commitments in Lean. Implementation is executable realization. Proofs establish mathematical propositions. Tests provide computational evidence about exercised behaviour.

A successful proof, test, compilation, or review must not be interpreted as establishing a stronger claim than the artefact supports.

## Repository layers

| Layer | Location | Role |
|---|---|---|
| Normative specification | spec/ | Authoritative language specification |
| Formalisation and implementation | src/ | Lean formal representation and executable implementation |
| Tests | tests/ | Executable behavioural checks |
| Specification tooling | tools/ | Verso generator and extensions |
| Auxiliary tooling | scripts/ | Maintenance, analysis, CI support |
| Scientific documentation | docs/ | Current research, method, assurance, status, review navigation |
| Historical material | docs/ and archives/ | Historical evidence and provenance |
| Automation | .github/ | CI, security, release, repository automation |
| Agent infrastructure | .claude/ | Claude Code rules, skills, agents |

The detailed historical documentation tree is intentionally not being moved by this change.

## Authority rules

1. Normative commitments in the current specification are authoritative for language requirements.
2. Formalisation is a representation of identified normative commitments, not a replacement for them.
3. Implementation behaviour is evidence about the implementation and does not silently redefine the specification.
4. Proofs establish the propositions they actually prove.
5. Tests establish the behaviours they actually exercise.
6. Historical documents provide provenance unless explicitly promoted into current project state.

A change that requires weakening a normative claim merely to make an implementation compile is a specification issue, not an implementation shortcut.

## Interactive presentation and exploration

K7PL is also developing an interactive presentation and exploration layer. The purpose is not to replace the repository's canonical sources, but to make relationships between specification, formalisation, implementation, proofs, tests, documentation, bibliography, decisions, and history navigable.

The proposed architecture is documented in [INTERACTIVE-EXPLORATION.md](INTERACTIVE-EXPLORATION.md) and its executable backlog in [tracking/INTERACTIVE-EXPLORATION-PLAN.md](tracking/INTERACTIVE-EXPLORATION-PLAN.md).

The project treats Lean as a possible transformation language from a formal documentary/semantic model to a navigable representation rendered with Verso. A graph view may complement document navigation. Development is gated by a demonstration of value on a real comprehension path; a global Markdown-to-MDX migration is not an objective.

## Current limitations

This architecture does not establish that every specification commitment is formalized, that implementation conforms to the specification, or that every scientific claim is proved. See [ASSURANCE.md](ASSURANCE.md) and CI-generated [STATUS.md](STATUS.md).
