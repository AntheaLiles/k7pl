<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Security and assurance rules

The repository must favour real security over optimising a score.

Never fabricate:

- a review or an approval;
- a contributor;
- a signature;
- provenance;
- an SBOM;
- a proof of reproducibility;
- a SAST check;
- Scorecard or CII compliance.

Always distinguish:

`VERIFIED` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE`.

Workflows with GitHub writes, secrets or elevated permissions must be examined before they are modified.

Assurance agents must not impose a change to the language's architecture when a documentation or CI check is enough.
