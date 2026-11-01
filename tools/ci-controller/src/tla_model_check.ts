// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/** Run the registry-backed, finite TLA-01..16 TLC profile suite. */

export type TlaProfile =
  | {
    kind: "positive";
    config: string;
    module: string;
    label: string;
  }
  | {
    kind: "negative";
    config: string;
    module: string;
    label: string;
    expectedInvariant: string;
  };

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

export function parseTlaProfiles(value: unknown): TlaProfile[] {
  if (!isRecord(value) || value.schemaVersion !== 1 ||
    !Array.isArray(value.profiles)) {
    throw new Error("TLC-PROFILES.json must have schemaVersion 1 and a profiles array");
  }

  return value.profiles.map((entry, index): TlaProfile => {
    if (!isRecord(entry)) {
      throw new Error("profile " + index + " must be an object");
    }
    const kind = entry.kind;
    const config = entry.config;
    const module = entry.module;
    const label = entry.label;
    if (kind !== "positive" && kind !== "negative") {
      throw new Error("profile " + index + " has an invalid kind");
    }
    if (typeof config !== "string" ||
      !/^TLA\d{2}-[A-Za-z0-9-]+\.cfg$/.test(config)) {
      throw new Error("profile " + index + " has an invalid TLA config filename");
    }
    if (typeof module !== "string" || !/^[A-Za-z][A-Za-z0-9]*$/.test(module)) {
      throw new Error("profile " + index + " has an invalid module name");
    }
    if (typeof label !== "string" || !/^[a-z0-9-]+$/.test(label)) {
      throw new Error("profile " + index + " has an invalid label");
    }
    if (kind === "negative") {
      if (typeof entry.expectedInvariant !== "string" ||
        !/^[A-Za-z][A-Za-z0-9]*$/.test(entry.expectedInvariant)) {
        throw new Error("negative profile " + label + " must name expectedInvariant");
      }
      return {
        kind,
        config,
        module,
        label,
        expectedInvariant: entry.expectedInvariant,
      };
    }
    if ("expectedInvariant" in entry) {
      throw new Error("positive profile " + label + " must not declare expectedInvariant");
    }
    return { kind, config, module, label };
  });
}

export function validateProfileInventory(
  profiles: readonly TlaProfile[],
  configFiles: readonly string[],
  moduleFiles: readonly string[],
): string[] {
  const errors: string[] = [];
  const configNames = configFiles.filter((name) =>
    /^TLA\d{2}-.+\.cfg$/.test(name)
  ).sort();
  const moduleNames = moduleFiles.filter((name) =>
    /^(TLA\d{2}.*|K7PL.*)\.tla$/.test(name)
  ).map((name) => name.slice(0, -4)).sort();

  const registeredConfigs = new Set<string>();
  const labels = new Set<string>();
  const usedModules = new Set<string>();

  for (const profile of profiles) {
    if (registeredConfigs.has(profile.config)) {
      errors.push("duplicate profile config: " + profile.config);
    }
    registeredConfigs.add(profile.config);

    if (labels.has(profile.label)) {
      errors.push("duplicate profile label: " + profile.label);
    }
    labels.add(profile.label);
    usedModules.add(profile.module);

    if (!configNames.includes(profile.config)) {
      errors.push("registered config is missing from models/: " + profile.config);
    }
    if (!moduleNames.includes(profile.module)) {
      errors.push("profile module is missing from models/: " + profile.module + ".tla");
    }
  }

  for (const config of configNames) {
    if (!registeredConfigs.has(config)) {
      errors.push("unregistered TLA config: " + config);
    }
  }
  for (const module of moduleNames) {
    if (!usedModules.has(module)) {
      errors.push("TLA model module has no registered profile: " + module + ".tla");
    }
  }
  return errors;
}

function joined(directory: string, filename: string): string {
  return directory === "." || directory === ""
    ? filename
    : directory.replace(/\/+$/, "") + "/" + filename;
}

function parseOptions(args: string[]): Map<string, string | boolean> {
  const options = new Map<string, string | boolean>();
  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    if (arg === "--validate-only" || arg === "--help") {
      options.set(arg, true);
    } else if (
      ["--model-dir", "--tlc-jar", "--evidence"].includes(arg) &&
      i + 1 < args.length
    ) {
      options.set(arg, args[++i]);
    } else {
      throw new Error("unknown or incomplete argument: " + arg);
    }
  }
  return options;
}

async function commandOutput(
  command: string,
  args: string[],
  cwd?: string,
): Promise<{ code: number; stdout: string; stderr: string }> {
  const result = await new Deno.Command(command, {
    args,
    cwd,
    stdout: "piped",
    stderr: "piped",
  }).output();
  return {
    code: result.code,
    stdout: new TextDecoder().decode(result.stdout),
    stderr: new TextDecoder().decode(result.stderr),
  };
}

async function inventory(modelDir: string): Promise<TlaProfile[]> {
  const manifestPath = joined(modelDir, "TLC-PROFILES.json");
  const raw = JSON.parse(await Deno.readTextFile(manifestPath)) as unknown;
  const profiles = parseTlaProfiles(raw);
  const entries = [...Deno.readDirSync(modelDir)];
  const configs = entries.filter((entry) =>
    entry.isFile && entry.name.endsWith(".cfg")
  ).map((entry) => entry.name);
  const modules = entries.filter((entry) =>
    entry.isFile && entry.name.endsWith(".tla")
  ).map((entry) => entry.name);
  const errors = validateProfileInventory(profiles, configs, modules);
  if (errors.length > 0) {
    throw new Error(
      "TLA profile inventory mismatch:\n" +
        errors.map((error) => "- " + error).join("\n"),
    );
  }
  return profiles;
}

function evidenceSource(name: string): boolean {
  return name === "TLC-PROFILES.json" ||
    /^(TLA\d{2}.*|K7PL.*)\.tla$/.test(name) ||
    /^TLA\d{2}-.+\.cfg$/.test(name) ||
    /^TLA.*\.json$/.test(name);
}

async function runSuite(
  profiles: readonly TlaProfile[],
  modelDir: string,
  jar: string,
  evidenceDir: string,
): Promise<number> {
  await Deno.mkdir(evidenceDir, { recursive: true });
  const entries = [...Deno.readDirSync(modelDir)];
  for (const entry of entries) {
    if (entry.isFile && evidenceSource(entry.name)) {
      await Deno.copyFile(
        joined(modelDir, entry.name),
        joined(evidenceDir, entry.name),
      );
    }
  }

  const javaVersion = await commandOutput("java", ["-version"]);
  await Deno.writeTextFile(
    joined(evidenceDir, "java-version.txt"),
    javaVersion.stderr + javaVersion.stdout,
  );
  if (javaVersion.code !== 0) {
    throw new Error("java -version failed with exit code " + javaVersion.code);
  }

  const jarDigest = await commandOutput("sha256sum", [jar]);
  await Deno.writeTextFile(
    joined(evidenceDir, "tla2tools.jar.sha256"),
    jarDigest.stdout + jarDigest.stderr,
  );
  if (jarDigest.code !== 0) {
    throw new Error("sha256sum failed for TLC JAR with exit code " + jarDigest.code);
  }

  let failures = 0;
  for (const profile of profiles) {
    const metaDir = await Deno.makeTempDir({ prefix: "tlc-" + profile.label + "-" });
    const args = [
      "-cp",
      jar,
      "tlc2.TLC",
      "-workers",
      "1",
      "-metadir",
      metaDir,
      "-config",
      profile.config,
      profile.module,
    ];
    let code = 1;
    let output = "";
    try {
      const result = await commandOutput("java", args, modelDir);
      code = result.code;
      output = result.stdout + result.stderr;
    } catch (error) {
      output = error instanceof Error ? error.message : String(error);
    } finally {
      await Deno.remove(metaDir, { recursive: true });
    }

    const logPath = joined(evidenceDir, profile.label + ".log");
    await Deno.writeTextFile(logPath, output);
    console.log("===== " + profile.label + " (" + profile.kind + ") =====\n" + output);

    const passed = profile.kind === "positive"
      ? code === 0 && output.includes("Model checking completed. No error has been found.")
      : code !== 0 && output.includes("Invariant " + profile.expectedInvariant);
    if (!passed) {
      failures++;
      if (profile.kind === "positive") {
        console.error(
          "TLC positive profile " + profile.config +
            " failed or did not complete exploration",
        );
      } else {
        console.error(
          "TLC negative profile " + profile.config +
            " did not violate " + profile.expectedInvariant,
        );
      }
    }
  }

  if (failures > 0) {
    console.error(
      failures + " of " + profiles.length +
        " registered TLA profiles failed their expected result",
    );
    return 1;
  }
  console.log(
    "All " + profiles.length + " registered TLA profiles matched their expected result.",
  );
  return 0;
}

async function main(args: string[]): Promise<number> {
  const options = parseOptions(args);
  if (options.get("--help") === true) {
    console.log(
      "Usage: tla_model_check.ts [--model-dir DIR] [--validate-only] " +
        "[--tlc-jar FILE --evidence DIR]",
    );
    return 0;
  }

  const modelDir = String(options.get("--model-dir") ?? "models");
  const profiles = await inventory(modelDir);
  console.log("TLA inventory: " + profiles.length + " profiles registered and covered.");
  if (options.get("--validate-only") === true) return 0;

  const jar = options.get("--tlc-jar");
  const evidence = options.get("--evidence");
  if (typeof jar !== "string" || typeof evidence !== "string") {
    throw new Error("--tlc-jar and --evidence are required unless --validate-only is used");
  }
  return await runSuite(profiles, modelDir, jar, evidence);
}

if (import.meta.main) {
  try {
    Deno.exit(await main(Deno.args));
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
