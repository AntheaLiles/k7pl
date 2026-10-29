// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Single entry point of the compiled controller.
 *
 * `deno task compile` turns this file into one self-contained
 * executable, dist/k7pl-ci, which needs neither Deno nor any other
 * runtime on the machine that runs it: a job whose image lacks Deno
 * (the K Framework container of k7pl-semantics.yaml) runs the
 * controller steps without installing Deno, nor the unzip that Deno's
 * installer needs there.
 *
 * A compiled binary carries one fixed set of permissions, given at
 * compile time. COMMANDS declares what each command uses; the binary
 * is compiled with their union (compilePermissionFlags, which a test
 * checks against deno.json), and before a command runs, every
 * permission category it does not use at all is revoked
 * (narrowPermissions). Deno can revoke a whole category, not narrow
 * one, so within a category a command gets the union: the commands
 * that run one known program can run any program the binary may, and
 * the binary may run any program because install-klean runs the
 * Python of a virtual environment whose path is only known at run
 * time (as `deno run --allow-run` already granted it).
 *
 * The commands are those of the K formal chain (k-smoke job); the
 * table is meant to grow as other jobs move to the binary.
 */

import { runAxiomReportCli } from "./axiom_report.ts";
import { runBuildProofsCli } from "./build_proofs.ts";
import { exportLean } from "./export_lean.ts";
import { installKlean } from "./install_klean.ts";
import { runKleanPreludeCli } from "./klean_prelude.ts";
import { main as runOsBoundaryCheckCli } from "./os_boundary_check.ts";
import { mainFromEnv } from "./package_evidence.ts";
import { recordToolchain } from "./record_toolchain.ts";
import { renderBlueprint } from "./render_blueprint.ts";
import { stageKlean } from "./stage_klean.ts";

/** The programs a command runs: none, these names, or any. */
export type RunUse = "none" | "any" | readonly string[];

export interface CommandSpec {
  summary: string;
  run: RunUse;
  /** The environment variables the command reads. */
  env: readonly string[];
  /** Whether the command writes files. Every command reads files. */
  write: boolean;
  /** Takes command-line arguments (otherwise reads the environment). */
  takesArgs: boolean;
  main: (args: string[]) => Promise<number>;
}

/** Run an action that reports failure by throwing. */
async function exitStatus(action: () => Promise<unknown>): Promise<number> {
  try {
    await action();
    return 0;
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    return 1;
  }
}

export const COMMANDS: Readonly<Record<string, CommandSpec>> = {
  "record-toolchain": {
    summary: "Record the K, Python and pip versions found on PATH",
    run: "any",
    env: ["PATH"],
    write: false,
    takesArgs: false,
    main: () => exitStatus(() => recordToolchain()),
  },
  "install-klean": {
    summary: "Install the pinned Klean generator in a virtual environment",
    run: "any",
    env: ["RUNNER_TEMP", "GITHUB_PATH"],
    write: true,
    takesArgs: false,
    main: () => exitStatus(() => installKlean()),
  },
  "export-lean": {
    summary: "Export the compiled KORE definition to Lean with Klean",
    run: ["klean"],
    env: ["RUNNER_TEMP", "GITHUB_WORKSPACE", "GITHUB_STEP_SUMMARY"],
    write: true,
    takesArgs: false,
    main: () => exitStatus(() => exportLean()),
  },
  "klean-prelude": {
    summary: "Apply the pinned Klean/Lean compatibility shim to a Prelude",
    run: "none",
    env: [],
    write: true,
    takesArgs: true,
    main: runKleanPreludeCli,
  },
  "stage-klean": {
    summary: "Stage the generated Klean modules into the proof project",
    run: "none",
    env: ["RUNNER_TEMP", "GITHUB_WORKSPACE"],
    write: true,
    takesArgs: false,
    main: () => exitStatus(() => stageKlean()),
  },
  "build-proofs": {
    summary: "Build the proof project with lake and keep its log",
    run: ["lake"],
    env: [],
    write: true,
    takesArgs: true,
    main: runBuildProofsCli,
  },
  "axiom-report": {
    summary: "Turn the proof build log into the axiom audit record",
    run: "none",
    env: ["GITHUB_SHA", "GITHUB_RUN_ID"],
    write: true,
    takesArgs: true,
    main: runAxiomReportCli,
  },
  "render-blueprint": {
    summary: "Render the Verso Blueprint documentation with lake",
    run: ["lake"],
    env: ["GITHUB_STEP_SUMMARY"],
    write: true,
    takesArgs: false,
    main: () => exitStatus(() => renderBlueprint()),
  },
  "os-boundary-check": {
    summary: "Run the K7OS native-boundary examples with krun",
    run: "any",
    env: [],
    write: false,
    takesArgs: true,
    main: (args) => runOsBoundaryCheckCli(args),
  },
  "package-evidence": {
    summary: "Package the formal-chain sources, HTML and evidence with tar",
    run: ["tar"],
    env: ["GITHUB_WORKSPACE", "RUNNER_TEMP", "GITHUB_RUN_ID"],
    write: true,
    takesArgs: false,
    main: () => exitStatus(() => mainFromEnv()),
  },
};

/** The permission flags the binary is compiled with: the union of COMMANDS. */
export function compilePermissionFlags(
  commands: Readonly<Record<string, CommandSpec>> = COMMANDS,
): string[] {
  const specs = Object.values(commands);
  const flags = ["--allow-read"];
  if (specs.some((spec) => spec.write)) flags.push("--allow-write");
  if (specs.some((spec) => spec.run === "any")) {
    flags.push("--allow-run");
  } else {
    const programs = new Set<string>();
    for (const spec of specs) {
      if (Array.isArray(spec.run)) spec.run.forEach((p) => programs.add(p));
    }
    if (programs.size > 0) {
      flags.push(`--allow-run=${[...programs].sort().join(",")}`);
    }
  }
  const variables = new Set<string>();
  for (const spec of specs) spec.env.forEach((v) => variables.add(v));
  if (variables.size > 0) {
    flags.push(`--allow-env=${[...variables].sort().join(",")}`);
  }
  return flags;
}

/** Revoke every permission category the command does not use at all. */
export async function narrowPermissions(spec: CommandSpec): Promise<void> {
  if (spec.run === "none") await Deno.permissions.revoke({ name: "run" });
  if (spec.env.length === 0) await Deno.permissions.revoke({ name: "env" });
  if (!spec.write) await Deno.permissions.revoke({ name: "write" });
}

/**
 * The state of each permission category, as the running command sees
 * it: "granted" when any access of the category remains. A category
 * granted for a list of names (the variables of --allow-env=...)
 * answers "prompt" to a query of the whole category, so each name of
 * the binary's union is queried as well.
 */
export async function permissionStates(): Promise<Record<string, string>> {
  const query = async (descriptor: Deno.PermissionDescriptor) =>
    (await Deno.permissions.query(descriptor)).state;
  const variables = new Set<string>();
  const programs = new Set<string>();
  for (const spec of Object.values(COMMANDS)) {
    spec.env.forEach((variable) => variables.add(variable));
    if (Array.isArray(spec.run)) spec.run.forEach((p) => programs.add(p));
  }
  const states: Record<string, string> = {};
  for (const name of ["read", "write", "net", "ffi", "sys"] as const) {
    states[name] = await query({ name });
  }
  states.run = await query({ name: "run" });
  for (const command of programs) {
    if (states.run === "granted") break;
    if (await query({ name: "run", command }) === "granted") {
      states.run = "granted";
    }
  }
  states.env = await query({ name: "env" });
  for (const variable of variables) {
    if (states.env === "granted") break;
    if (await query({ name: "env", variable }) === "granted") {
      states.env = "granted";
    }
  }
  return states;
}

function usage(): string {
  const width = Math.max(...Object.keys(COMMANDS).map((name) => name.length));
  return [
    "Usage: k7pl-ci <command> [arguments]",
    "       k7pl-ci permissions <command>",
    "",
    "Commands:",
    ...Object.entries(COMMANDS).map(([name, spec]) =>
      `  ${name.padEnd(width)}  ${spec.summary}`
    ),
  ].join("\n");
}

export async function runCli(argv: string[]): Promise<number> {
  const [command, ...rest] = argv;
  if (command === undefined || command === "--help" || command === "-h") {
    console.log(usage());
    return command === undefined ? 2 : 0;
  }
  // Diagnostic: the permissions a command would run with, after
  // narrowing, without running it.
  if (command === "permissions") {
    const spec = rest.length === 1 ? COMMANDS[rest[0]] : undefined;
    if (spec === undefined) {
      console.error(`permissions: expected one command\n${usage()}`);
      return 2;
    }
    await narrowPermissions(spec);
    console.log(JSON.stringify(await permissionStates()));
    return 0;
  }
  const spec = Object.hasOwn(COMMANDS, command) ? COMMANDS[command] : undefined;
  if (spec === undefined) {
    console.error(`unknown command: ${command}\n${usage()}`);
    return 2;
  }
  if (!spec.takesArgs && rest.length > 0) {
    console.error(`${command} takes no arguments: it reads the environment`);
    return 2;
  }
  await narrowPermissions(spec);
  return await spec.main(rest);
}

if (import.meta.main) {
  Deno.exit(await runCli(Deno.args));
}
