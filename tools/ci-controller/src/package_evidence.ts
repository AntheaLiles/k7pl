// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Port of scripts/ci/k7pl_semantics_package_evidence.sh.
 *
 * Gathers the K sources of lexicon/, the generated checker,
 * the Klean output, the proof project, the Blueprint sources
 * and HTML and the evidence files under
 * $RUNNER_TEMP/k7pl-formal-chain,
 * writes its MANIFEST.txt, and packs it into
 * $RUNNER_TEMP/k7pl-formal-chain-$GITHUB_RUN_ID.tar.gz for
 * the upload step.
 *
 * Unlike the shell script, which reads GITHUB_WORKSPACE,
 * RUNNER_TEMP and GITHUB_RUN_ID from the environment, this
 * port takes the workspace root, the runner-temp root and
 * the run id as explicit arguments, so tests can run it
 * against fixture trees. main() below restores the
 * environment-variable behaviour for the future CLI wiring.
 *
 * Fidelity notes: a missing input aborts the run, as
 * `cp -a` under `set -e` would; the MANIFEST lists every
 * staged file plus MANIFEST.txt itself, sorted in C-locale
 * (byte) order and prefixed with `k7pl-formal-chain/`;
 * the "Packaged N files" count counts tar listing lines,
 * which include directory entries, exactly as the shell
 * script's `wc -l` over `tar -tzf` does. The shell script's
 * trailing `ls -lh` line (a human-readable listing, not a
 * machine contract) is not reproduced; the archive path
 * and size are in the returned value instead. Packing
 * itself still shells out to `tar`, as the original does.
 */

export interface PackageEvidenceOptions {
  workspace: string;
  runnerTemp: string;
  runId: string;
  /** Line sink, defaulting to console.log. */
  log?: (line: string) => void;
}

export interface EvidencePackage {
  artifactRoot: string;
  archive: string;
  manifestPath: string;
  manifestEntries: string[];
  fileCount: number;
  htmlCount: number;
  archiveSize: number;
}

function requiredEnv(name: string): string {
  const value = Deno.env.get(name);
  if (value === undefined) throw new Error(`${name}: unbound variable`);
  return value;
}

async function removeIfPresent(path: string): Promise<void> {
  try {
    await Deno.remove(path, { recursive: true });
  } catch (error) {
    if (!(error instanceof Deno.errors.NotFound)) throw error;
  }
}

async function copyTree(source: string, dest: string): Promise<void> {
  await Deno.mkdir(dest, { recursive: true });
  for await (const entry of Deno.readDir(source)) {
    const from = `${source}/${entry.name}`;
    const to = `${dest}/${entry.name}`;
    if (entry.isDirectory) {
      await copyTree(from, to);
    } else {
      await Deno.copyFile(from, to);
    }
  }
}

/**
 * `cp -a <source> <dest>`: when dest is an existing
 * directory, the source lands under its own basename;
 * otherwise dest is the target path itself.
 */
async function copyItem(source: string, dest: string): Promise<void> {
  let destIsDir = false;
  try {
    destIsDir = (await Deno.stat(dest)).isDirectory;
  } catch (error) {
    if (!(error instanceof Deno.errors.NotFound)) throw error;
  }
  const sourceStat = await Deno.stat(source);
  const target = destIsDir ? `${dest}/${source.split("/").pop()}` : dest;
  if (sourceStat.isDirectory) {
    await copyTree(source, target);
  } else {
    await Deno.mkdir(target.split("/").slice(0, -1).join("/"), {
      recursive: true,
    });
    await Deno.copyFile(source, target);
  }
}

/** `cp -a <dir>/. <dest>`: copy a directory's contents. */
async function copyContents(sourceDir: string, dest: string): Promise<void> {
  await Deno.mkdir(dest, { recursive: true });
  for await (const entry of Deno.readDir(sourceDir)) {
    const from = `${sourceDir}/${entry.name}`;
    const to = `${dest}/${entry.name}`;
    if (entry.isDirectory) {
      await copyTree(from, to);
    } else {
      await Deno.copyFile(from, to);
    }
  }
}

async function listFilesRelative(root: string, prefix = ""): Promise<string[]> {
  const files: string[] = [];
  for await (const entry of Deno.readDir(`${root}${prefix}`)) {
    const rel = `${prefix}/${entry.name}`;
    if (entry.isDirectory) {
      files.push(...await listFilesRelative(root, rel));
    } else if (entry.isFile) {
      files.push(rel);
    }
  }
  return files;
}

async function countHtml(dir: string): Promise<number> {
  let count = 0;
  for await (const entry of Deno.readDir(dir)) {
    const entryPath = `${dir}/${entry.name}`;
    if (entry.isDirectory) {
      count += await countHtml(entryPath);
    } else if (entry.isFile && entry.name.endsWith(".html")) {
      count += 1;
    }
  }
  return count;
}

async function runTar(args: string[], cwd?: string): Promise<string> {
  const process = new Deno.Command("tar", {
    args,
    cwd,
    stdout: "piped",
    stderr: "piped",
  });
  const { code, stdout, stderr } = await process.output();
  if (code !== 0) {
    throw new Error(
      `tar ${args.join(" ")} failed with exit status ${code}: ${
        new TextDecoder().decode(stderr).trim()
      }`,
    );
  }
  return new TextDecoder().decode(stdout);
}

export async function packageEvidence(
  options: PackageEvidenceOptions,
): Promise<EvidencePackage> {
  const log = options.log ?? ((line: string) => console.log(line));
  const { workspace, runnerTemp, runId } = options;
  const artifactRoot = `${runnerTemp}/k7pl-formal-chain`;
  const archive = `${runnerTemp}/k7pl-formal-chain-${runId}.tar.gz`;
  const manifestPath = `${runnerTemp}/k7pl-formal-chain-${runId}.manifest.txt`;
  await removeIfPresent(artifactRoot);
  await removeIfPresent(archive);
  for (
    const dir of [
      `${artifactRoot}/proofs`,
      `${artifactRoot}/spec/formal-chain`,
      `${artifactRoot}/src/k`,
      `${artifactRoot}/tests/examples/native-boundary`,
      `${artifactRoot}/wiki`,
    ]
  ) {
    await Deno.mkdir(dir, { recursive: true });
  }

  const ws = (rel: string) => `${workspace}/${rel}`;
  const art = (rel: string) => `${artifactRoot}/${rel}`;
  await copyItem(ws("lexicon"), art("lexicon"));
  await copyItem(
    ws("src/k/.build/generated/check_k_examples.py"),
    art("src/k/check_k_examples.py"),
  );
  await copyItem(ws("src/k/Makefile"), art("src/k/"));
  await copyItem(ws("tests/examples/add.k7"), art("tests/examples/"));
  await copyItem(ws("tests/examples/select.k7"), art("tests/examples/"));
  await copyContents(
    ws("tests/examples/native-boundary"),
    art("tests/examples/native-boundary"),
  );
  await copyItem(ws("wiki/semantics.md"), art("wiki/"));
  await copyItem(`${runnerTemp}/klean-output/k7pl2lean`, art("klean-output"));
  await copyItem(ws("proofs/K7PL2Lean.lean"), art("proofs/"));
  await copyItem(ws("proofs/K7PL2Lean"), art("proofs/"));
  for (
    const name of [
      "lakefile.toml",
      "lean-toolchain",
      "lake-manifest.json",
      "README.md",
      "K7PL.lean",
      "Makefile",
    ]
  ) {
    await copyItem(ws(`proofs/${name}`), art("proofs/"));
  }
  await copyItem(ws("proofs/axiom-audit-contract.json"), art("proofs/"));
  await copyItem(ws("proofs/K7PL"), art("proofs/"));
  for (
    const name of [
      "BlueprintK7PL.lean",
      "BlueprintK7PLMain.lean",
      "lakefile.lean",
      "lean-toolchain",
      "lake-manifest.json",
      "Makefile",
    ]
  ) {
    await copyItem(ws(`spec/formal-chain/${name}`), art("spec/formal-chain/"));
  }
  await copyItem(
    ws("spec/formal-chain/BlueprintK7PL"),
    art("spec/formal-chain/"),
  );
  await Deno.mkdir(art("spec/formal-chain/_out/site"), { recursive: true });
  await copyItem(
    ws("spec/formal-chain/_out/site/html-multi"),
    art("spec/formal-chain/_out/site/"),
  );
  await copyItem(ws(".formal-chain-evidence"), art("evidence"));

  const htmlCount = await countHtml(
    art("spec/formal-chain/_out/site/html-multi"),
  );
  if (htmlCount <= 0) {
    throw new Error(
      `no HTML pages in ${art("spec/formal-chain/_out/site/html-multi")}`,
    );
  }

  const staged = (await listFilesRelative(artifactRoot)).map((rel) =>
    `.${rel}`
  );
  const manifestLines = [...staged, "./MANIFEST.txt"]
    .sort((a, b) => (a < b ? -1 : a > b ? 1 : 0))
    .map((line) => line.replace(/^\.\//, "k7pl-formal-chain/"));
  await Deno.writeTextFile(
    art("MANIFEST.txt"),
    `${manifestLines.join("\n")}\n`,
  );

  await runTar(["-czf", archive, "-C", runnerTemp, "k7pl-formal-chain"]);
  const archiveStat = await Deno.stat(archive);
  if (archiveStat.size === 0) {
    throw new Error(`empty archive: ${archive}`);
  }
  const listing = await runTar(["-tzf", archive]);
  await Deno.writeTextFile(manifestPath, listing);
  const fileCount = listing.split("\n").filter((line) => line !== "").length;
  log(`Packaged ${fileCount} files (${htmlCount} HTML files) into ${archive}`);
  return {
    artifactRoot,
    archive,
    manifestPath,
    manifestEntries: manifestLines,
    fileCount,
    htmlCount,
    archiveSize: archiveStat.size,
  };
}

export async function mainFromEnv(): Promise<EvidencePackage> {
  return await packageEvidence({
    workspace: requiredEnv("GITHUB_WORKSPACE"),
    runnerTemp: requiredEnv("RUNNER_TEMP"),
    runId: requiredEnv("GITHUB_RUN_ID"),
  });
}

if (import.meta.main) {
  try {
    await mainFromEnv();
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
