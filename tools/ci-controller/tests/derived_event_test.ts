// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

// End-to-end tests of the impact job's decision entry point, through a
// real git diff in temporary repositories. Ported at cutover C4 from
// the diff tests of scripts/ci/test_impact.py, which exercised the
// legacy Python classifier; the decision has been the derived
// classifier's since C3, so these tests now exercise it.

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { gitRunner } from "../src/changes.ts";
import { runImpact } from "../src/derived_event.ts";

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;
const REGISTRY = `${REPO_ROOT}.github/ci/components.yaml`;

const KEYS = [
  "full",
  "docs_links",
  "spec_check",
  "spec_build",
  "lean_build",
  "python_tests",
  "tracking_views",
  "unclassified",
  "axiom_audit",
  "k_compile",
  "k_examples",
  "klean_export",
  "tla_model_check",
];

async function git(cwd: string, ...args: string[]): Promise<string> {
  const result = await gitRunner(cwd)(args);
  if (result.code !== 0) {
    throw new Error(`git ${args.join(" ")} failed: ${result.stderr}`);
  }
  return result.stdout.trim();
}

async function writeFile(repo: string, path: string, content: string) {
  const slash = path.lastIndexOf("/");
  if (slash > 0) {
    await Deno.mkdir(`${repo}/${path.slice(0, slash)}`, { recursive: true });
  }
  await Deno.writeTextFile(`${repo}/${path}`, content);
}

/** A repository holding `files` at base, and `change` applied at head. */
async function scenario(
  files: Record<string, string>,
  change: (repo: string) => Promise<void> | void,
): Promise<{ repo: string; base: string; head: string }> {
  const repo = await Deno.makeTempDir({ prefix: "k7pl-impact-" });
  await git(repo, "init", "--quiet");
  await git(repo, "config", "user.email", "ci@example.invalid");
  await git(repo, "config", "user.name", "CI test");
  await git(repo, "config", "commit.gpgsign", "false");
  for (const [path, content] of Object.entries(files)) {
    await writeFile(repo, path, content);
  }
  await git(repo, "add", "-A");
  await git(repo, "commit", "--quiet", "--allow-empty", "-m", "base");
  const base = await git(repo, "rev-parse", "HEAD");
  await change(repo);
  await git(repo, "add", "-A");
  await git(repo, "commit", "--quiet", "--allow-empty", "-m", "head");
  const head = await git(repo, "rev-parse", "HEAD");
  return { repo, base, head };
}

interface Run {
  code: number;
  stdout: string;
  stderr: string;
  outputs: Record<string, string>;
  outputLines: string[];
}

async function runIn(
  cwd: string,
  env: Record<string, string | undefined>,
): Promise<Run> {
  const out: string[] = [];
  const err: string[] = [];
  const outputLines: string[] = [];
  const code = await runImpact(env, {
    git: gitRunner(cwd),
    registryPath: REGISTRY,
    log: (line) => out.push(line),
    error: (line) => err.push(line),
    writeOutput: (lines) => outputLines.push(...lines),
  });
  const outputs: Record<string, string> = {};
  for (const line of outputLines) {
    const eq = line.indexOf("=");
    outputs[line.slice(0, eq)] = line.slice(eq + 1);
  }
  return {
    code,
    stdout: out.map((line) => `${line}\n`).join(""),
    stderr: err.join("\n"),
    outputs,
    outputLines,
  };
}

function pullRequest(base: string, head: string) {
  return {
    EVENT_NAME: "pull_request",
    REF: "refs/pull/1/merge",
    BASE_SHA: base,
    HEAD_SHA: head,
  };
}

async function impactOfChange(
  path: string,
  change: (repo: string) => Promise<void> | void,
): Promise<Run> {
  const { repo, base, head } = await scenario({ [path]: "# base\n" }, change);
  const run = await runIn(repo, pullRequest(base, head));
  assertEquals(run.code, 0, run.stderr);
  return run;
}

Deno.test("full paths force full through the diff", async () => {
  for (
    const path of [
      "lakefile.lean",
      "lean-toolchain",
      "lake-manifest.json",
      ".github/workflows/end-to-end.txt",
      "scripts/ci/end-to-end.txt",
    ]
  ) {
    const run = await impactOfChange(
      path,
      (repo) => Deno.writeTextFile(`${repo}/${path}`, "# head\n"),
    );
    assertEquals(run.outputs.full, "true", path);
    assertEquals(run.outputs.unclassified, "false", path);
  }
});

Deno.test("every kind of change to a full path forces full", async () => {
  const changes: Record<string, (repo: string) => Promise<void>> = {
    modified: (repo) => Deno.writeTextFile(`${repo}/lakefile.lean`, "# head\n"),
    deleted: (repo) => Deno.remove(`${repo}/lakefile.lean`),
    "type changed": async (repo) => {
      await Deno.remove(`${repo}/lakefile.lean`);
      await Deno.symlink("elsewhere", `${repo}/lakefile.lean`);
    },
  };
  for (const [label, change] of Object.entries(changes)) {
    const run = await impactOfChange("lakefile.lean", change);
    assertEquals(run.outputs.full, "true", label);
    assertStringIncludes(run.stdout, "lakefile.lean");
  }
});

Deno.test("an added full path forces full", async () => {
  const { repo, base, head } = await scenario(
    { "docs/note.md": "x\n" },
    (repo) => Deno.writeTextFile(`${repo}/lake-manifest.json`, "{}\n"),
  );
  const run = await runIn(repo, pullRequest(base, head));
  assertEquals([run.outputs.full, run.outputs.unclassified], [
    "true",
    "false",
  ]);
});

Deno.test("deleting the lakefile alone forces full", async () => {
  const { repo, base, head } = await scenario(
    { "lakefile.lean": "x\n", "docs/note.md": "x\n" },
    (repo) => Deno.remove(`${repo}/lakefile.lean`),
  );
  const run = await runIn(repo, pullRequest(base, head));
  assertStringIncludes(run.stdout, "Changed paths: 1");
  assertEquals([run.outputs.full, run.outputs.unclassified], [
    "true",
    "false",
  ]);
});

Deno.test("a rename is seen as a deletion and an addition", async () => {
  const renames: Record<string, [string, string]> = {
    "light to full": ["docs/note.md", "lakefile.lean"],
    "full to light": ["lakefile.lean", "docs/lakefile.md"],
    "full to full": ["lean-toolchain", "scripts/ci/toolchain.txt"],
  };
  for (const [label, [from, to]] of Object.entries(renames)) {
    const { repo, base, head } = await scenario(
      { [from]: "same content\n" },
      async (repo) => {
        const slash = to.lastIndexOf("/");
        if (slash > 0) {
          await Deno.mkdir(`${repo}/${to.slice(0, slash)}`, {
            recursive: true,
          });
        }
        await Deno.rename(`${repo}/${from}`, `${repo}/${to}`);
      },
    );
    // Precondition: with rename detection, git lists the new path
    // only, so a classifier reading that listing would not see the
    // old path disappear.
    assertEquals(await git(repo, "diff", "--name-only", base, head), to);
    const run = await runIn(repo, pullRequest(base, head));
    assertStringIncludes(run.stdout, "Changed paths: 2", label);
    assertStringIncludes(run.stdout, `  '${from}'\n`, label);
    assertStringIncludes(run.stdout, `  '${to}'\n`, label);
    assertEquals(
      [run.outputs.full, run.outputs.unclassified],
      ["true", "false"],
      label,
    );
  }
});

Deno.test("a light rename stays light", async () => {
  const { repo, base, head } = await scenario(
    { "docs/old.md": "same content\n" },
    (repo) => Deno.rename(`${repo}/docs/old.md`, `${repo}/docs/new.md`),
  );
  const run = await runIn(repo, pullRequest(base, head));
  assertStringIncludes(run.stdout, "Changed paths: 2");
  assertEquals([run.outputs.full, run.outputs.docs_links], ["false", "true"]);
});

Deno.test("a failed diff is fatal and writes nothing", async () => {
  const { repo, base, head } = await scenario(
    { "docs/note.md": "x\n" },
    () => {},
  );
  const notRepository = await Deno.makeTempDir({ prefix: "k7pl-norepo-" });
  // What github.event.before holds when a branch is created.
  const zeros = "0".repeat(40);
  const cases: Record<string, [string, string, string]> = {
    "unknown base": [repo, zeros, head],
    "unknown head": [repo, base, zeros],
    "not a repository": [notRepository, base, head],
  };
  for (const [label, [cwd, from, to]] of Object.entries(cases)) {
    const run = await runIn(cwd, pullRequest(from, to));
    assert(run.code !== 0, `${label}: a failed diff must fail the job`);
    assertEquals(run.outputLines, [], `${label}: no output may be written`);
    assertStringIncludes(run.stderr, "git diff", label);
    assertStringIncludes(run.stderr, "failed", label);
    assert(!run.stdout.includes("Impact:"), label);
  }
});

Deno.test("a missing commit range is an error, not a silent pass", async () => {
  const { repo, base, head } = await scenario(
    { "docs/note.md": "x\n" },
    () => {},
  );
  const ranges: Record<string, Record<string, string | undefined>> = {
    "no range": {},
    "base only": { BASE_SHA: base },
    "head only": { HEAD_SHA: head },
    "empty base": { BASE_SHA: "", HEAD_SHA: head },
  };
  for (const [label, range] of Object.entries(ranges)) {
    const run = await runIn(repo, {
      EVENT_NAME: "pull_request",
      REF: "refs/pull/1/merge",
      ...range,
    });
    assertEquals(run.code, 1, label);
    assertStringIncludes(run.stderr, "BASE_SHA and HEAD_SHA are required");
    assertEquals(run.outputLines, [], label);
  }
});

Deno.test("identical commits validate nothing, explicitly", async () => {
  const { repo, base } = await scenario({ "docs/note.md": "x\n" }, () => {});
  const run = await runIn(repo, pullRequest(base, base));
  assertEquals(run.code, 0);
  assertStringIncludes(run.stdout, "Changed paths: 0");
  assertEquals(Object.keys(run.outputs), KEYS);
  assertEquals([...new Set(Object.values(run.outputs))], ["false"]);
});

Deno.test("outputs have exactly the keys the workflows read", async () => {
  const run = await impactOfChange(
    "src/K7pl/X.lean",
    (repo) => Deno.writeTextFile(`${repo}/src/K7pl/X.lean`, "# head\n"),
  );
  assertEquals(Object.keys(run.outputs), KEYS);
  assert(
    Object.values(run.outputs).every((v) => v === "true" || v === "false"),
  );
  assertEquals(run.outputs.lean_build, "true");
});

Deno.test("the log shows the decision", async () => {
  const run = await impactOfChange(
    "docs/note.md",
    (repo) => Deno.writeTextFile(`${repo}/docs/note.md`, "# head\n"),
  );
  assertStringIncludes(run.stdout, "Changed paths: 1\n  'docs/note.md'\n");
  assertStringIncludes(
    run.stdout,
    "Impact: full=false docs_links=true spec_check=false spec_build=false " +
      "lean_build=false python_tests=false tracking_views=false unclassified=false\n",
  );
  assert(!run.stdout.includes("Unclassified paths:"));
});

Deno.test("a path that looks like a workflow command is not printed as one", async () => {
  const name = "::warning::pwned";
  const run = await impactOfChange(
    name,
    (repo) => Deno.writeTextFile(`${repo}/${name}`, "x\n"),
  );
  for (const line of run.stdout.split("\n")) {
    assert(!line.trimStart().startsWith("::"), line);
  }
  assertStringIncludes(run.stdout, `  '${name}'\n`);
});

Deno.test("the log lists the unclassified paths", async () => {
  const run = await impactOfChange(
    "new-format.toml",
    (repo) => Deno.writeTextFile(`${repo}/new-format.toml`, "# head\n"),
  );
  assertStringIncludes(
    run.stdout,
    "Unclassified paths:\n  'new-format.toml'\n",
  );
  assertStringIncludes(
    run.stdout,
    "Impact: full=true docs_links=true spec_check=true spec_build=true " +
      "lean_build=true python_tests=true tracking_views=true unclassified=true\n",
  );
  assertEquals([run.outputs.full, run.outputs.unclassified], ["true", "true"]);
});

Deno.test("a manual dispatch needs no commit range and validates everything", async () => {
  const cwd = await Deno.makeTempDir({ prefix: "k7pl-dispatch-" });
  const run = await runIn(cwd, {
    EVENT_NAME: "workflow_dispatch",
    REF: "refs/heads/topic",
  });
  assertEquals(run.code, 0, run.stderr);
  assertEquals(Object.keys(run.outputs), KEYS);
  for (const key of KEYS) {
    assertEquals(
      run.outputs[key],
      key === "unclassified" ? "false" : "true",
      key,
    );
  }
});

Deno.test("unusual path names fall back on full", async () => {
  // git quotes such names; the classifier does not recognise the
  // quoted form: unknown, hence full.
  const run = await impactOfChange(
    "src/é.lean",
    (repo) => Deno.writeTextFile(`${repo}/src/é.lean`, "# head\n"),
  );
  assertEquals([run.outputs.full, run.outputs.unclassified], ["true", "true"]);
});

Deno.test("the axiom-audit script runs the Lean and specification builds", async () => {
  const run = await impactOfChange(
    "scripts/axiom-audit.sh",
    (repo) => Deno.writeTextFile(`${repo}/scripts/axiom-audit.sh`, "#\n"),
  );
  assertEquals(
    {
      full: run.outputs.full,
      lean_build: run.outputs.lean_build,
      spec_build: run.outputs.spec_build,
      spec_check: run.outputs.spec_check,
    },
    {
      full: "false",
      lean_build: "true",
      spec_build: "true",
      spec_check: "false",
    },
  );
});

Deno.test("a Markdown-only change stays light through the diff", async () => {
  const run = await impactOfChange(
    "docs/note.md",
    (repo) => Deno.writeTextFile(`${repo}/docs/note.md`, "# head\n"),
  );
  assertEquals(
    {
      full: run.outputs.full,
      lean_build: run.outputs.lean_build,
      spec_build: run.outputs.spec_build,
      docs_links: run.outputs.docs_links,
    },
    {
      full: "false",
      lean_build: "false",
      spec_build: "false",
      docs_links: "true",
    },
  );
});
