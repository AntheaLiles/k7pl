<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL proof layer

This Lake package gathers the maintained Lean proofs of the experimental semantic chain.
`K7PL/Proof.lean` defines the structural judgement `HasType` and `SurfaceStep`, with the theorems
`preservation` and `progress`. `K7PL/Bridge.lean` links concrete steps to the generated relation.
`K7PL/MachineSoundness.lean` proves the preservation of `MachineTyping` for the constructors
of the KLean relation `Rewrites`, including the continuation frames. `K7PL/Example.lean`
holds the concrete end-to-end witnesses.

The KLean modules are generated during the build under `K7PL2Lean/` and
`K7PL2Lean.lean`; they are ignored by Git and are not maintained sources. From
the repository root, `make proof` compiles K, generates and adapts KLean, copies the generated
modules into this package, then runs `lake build`.

Formal limit: the sublanguage contains integers, booleans, addition, comparison and
`select`. KLean does not encode the equations of the K function `typeOf` as constructors of
`Rewrites`; no equivalence between `typeOf` and the judgement `HasType` is claimed.
This result does not constitute a safety proof of the complete K7PL.
