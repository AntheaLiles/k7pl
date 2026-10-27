// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  BRIDGE_NATIVE_DECLARATIONS,
  checkBuildLog,
  MACHINE_SOUNDNESS_THEOREMS,
  parseCliArgs,
} from "../src/build_proofs.ts";
import { parseAxiomRecords } from "../src/axiom_report.ts";

// Fixture-log cases for the structural build-log audit ported
// from scripts/ci/k7pl_semantics_build_proofs.sh. Lake/Lean are
// not available on this VM, so the audit is exercised on
// fixture logs, including logs where a theorem name appears
// without its axiom record (which must still fail).

function dependsLine(name: string, axioms = ["propext"]): string {
  return `info: K7PL/Generated.lean:1:0: '${name}' depends on axioms: [${
    axioms.join(", ")
  }]`;
}

function noneLine(name: string): string {
  return `info: K7PL/Generated.lean:1:0: '${name}' does not depend on any axioms`;
}

function passingLog(): string {
  const lines = [
    "info: building K7PL2Lean",
    ...MACHINE_SOUNDNESS_THEOREMS.map((name) => dependsLine(name)),
    // Bridge declarations with axiom sets, native-boundary
    // declarations with explicit empty sets: both forms counted.
    ...BRIDGE_NATIVE_DECLARATIONS.map((name) =>
      name.startsWith("K7PL.Bridge") ? dependsLine(name) : noneLine(name)
    ),
  ];
  return lines.join("\n") + "\n";
}

Deno.test("passing fixture log satisfies the contract", () => {
  assertEquals(checkBuildLog(passingLog()), []);
});

Deno.test("sorryAx anywhere in the log fails", () => {
  assert(
    checkBuildLog(passingLog() + "warning: sorryAx used somewhere\n").some(
      (error) => error.includes("sorryAx"),
    ),
  );
});

Deno.test("missing machine-soundness theorem line fails", () => {
  for (const theorem of MACHINE_SOUNDNESS_THEOREMS) {
    const log = passingLog().split("\n").filter((line) =>
      !line.includes(`'${theorem}'`)
    ).join("\n");
    const errors = checkBuildLog(log);
    assert(
      errors.some((error) =>
        error.includes("Missing axiom audit") && error.includes(theorem)
      ),
      JSON.stringify(errors),
    );
  }
});

Deno.test("missing bridge/native-boundary declaration line fails", () => {
  for (const declaration of BRIDGE_NATIVE_DECLARATIONS) {
    const log = passingLog().split("\n").filter((line) =>
      !line.includes(`'${declaration}'`)
    ).join("\n");
    const errors = checkBuildLog(log);
    assert(
      errors.some((error) =>
        error.includes("Missing axiom audit") && error.includes(declaration)
      ),
      JSON.stringify(errors),
    );
  }
});

Deno.test("theorem name in an unrelated line does not satisfy the check", () => {
  // The old grep rejected this too (it required the full
  // "'<name>' depends on axioms:" string); the structural
  // parser must not be fooled by a bare mention either.
  const theorem = MACHINE_SOUNDNESS_THEOREMS[0];
  const log =
    passingLog().split("\n").filter((line) => !line.includes(`'${theorem}'`))
      .join("\n") +
    `info: see ${theorem} in the documentation for details\n`;
  const errors = checkBuildLog(log);
  assert(
    errors.some((error) => error.includes(theorem)),
    JSON.stringify(errors),
  );
});

Deno.test("theorem name as a prefix of a longer name does not satisfy the check", () => {
  const theorem = MACHINE_SOUNDNESS_THEOREMS[0];
  const log =
    passingLog().split("\n").filter((line) => !line.includes(`'${theorem}'`))
      .join("\n") +
    dependsLine(`${theorem}_extra`) + "\n";
  assert(
    checkBuildLog(log).some((error) => error.includes(theorem)),
    "longer-name record must not satisfy the exact-name check",
  );
});

Deno.test("theorem name inside another declaration's axiom set does not satisfy the check", () => {
  const theorem = MACHINE_SOUNDNESS_THEOREMS[1];
  const log =
    passingLog().split("\n").filter((line) => !line.includes(`'${theorem}'`))
      .join("\n") +
    // Not a real Lean axiom name, but it proves the parser only
    // reads the quoted declaration position, never the set.
    `info: x: 'K7PL.Other.decl' depends on axioms: [${theorem}]\n`;
  assert(
    checkBuildLog(log).some((error) => error.includes(theorem)),
    "axiom-set mention must not satisfy the declaration check",
  );
});

Deno.test("does-not-depend line does not satisfy a machine-soundness theorem (preserved grep quirk)", () => {
  const theorem = MACHINE_SOUNDNESS_THEOREMS[0];
  const log =
    passingLog().split("\n").filter((line) => !line.includes(`'${theorem}'`))
      .join("\n") + noneLine(theorem) + "\n";
  assert(
    checkBuildLog(log).some((error) => error.includes(theorem)),
    "the old grep required a depends-on line for these theorems",
  );
});

Deno.test("does-not-depend line does satisfy a bridge/native-boundary declaration", () => {
  const declaration = "K7PL.Bridge.add_root_is_klean_rewrite";
  const log =
    passingLog().split("\n").filter((line) =>
      !line.includes(`'${declaration}'`)
    ).join("\n") + noneLine(declaration) + "\n";
  assert(
    !checkBuildLog(log).some((error) => error.includes(declaration)),
    JSON.stringify(checkBuildLog(log)),
  );
});

Deno.test("parser yields declaration to axiom-set pairs", () => {
  const records = parseAxiomRecords(
    dependsLine("K7PL.A", ["propext", "Quot.sound"]) + "\n" +
      noneLine("K7PL.B") + "\n",
  );
  assertEquals(records, [
    { name: "K7PL.A", kind: "depends", axioms: ["Quot.sound", "propext"] },
    { name: "K7PL.B", kind: "none", axioms: [] },
  ]);
});

Deno.test("duplicate records are presence, not a build-log failure (axiom audit owns conflicts)", () => {
  const log = passingLog() + dependsLine(MACHINE_SOUNDNESS_THEOREMS[0]) + "\n";
  assertEquals(checkBuildLog(log), []);
  assertStringIncludes(passingLog(), MACHINE_SOUNDNESS_THEOREMS[0]);
});

Deno.test("CLI parser preserves --build before value-taking options", () => {
  const args = parseCliArgs([
    "--build",
    "--workdir",
    "/tmp/proofs",
    "--log-output",
    "/tmp/build.log",
  ]);
  assertEquals(args.get("build"), true);
  assertEquals(args.get("workdir"), "/tmp/proofs");
  assertEquals(args.get("log-output"), "/tmp/build.log");
});
