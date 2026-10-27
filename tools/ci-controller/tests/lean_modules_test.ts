// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  checkLeanModules,
  DEFAULT_SCAN_DIRS,
  importsOf,
  type LeanModulesResult,
  nestedWorkspaces,
  parseLakefile,
  reachableFiles,
  runCheckLeanModulesCommand,
  scan,
  stripComments,
  Unrecognized,
} from "../src/lean_modules.ts";

// Parity cases transcribed from scripts/ci/test_check_lean_modules.py.
// These are the specification for the port: if the Python
// script changes, these tests must change with it, in the
// same commit, and the change must be owner-approved.

const REPO_ROOT = Deno.realPathSync(
  new URL("../../..", import.meta.url).pathname,
);

const LAKEFILE = `import Lake
open Lake DSL

package mini

/-- Library. -/
@[default_target]
lean_lib Mini where
  srcDir := "src"
  roots := #[\`Main, \`Mini]
  leanOptions := #[⟨\`warningAsError, true⟩]

lean_lib MiniTests where
  srcDir := "tests"
  roots := #[\`ATest]

@[test_driver]
lean_exe mainTest where
  srcDir := "tests"
  root := \`MainTest

lean_lib MiniTools where
  srcDir := "tools"
  roots := #[\`Ext]

lean_lib MiniDoc where
  srcDir := "spec"
  roots := #[\`Doc]
`;

const BASE_FILES: Record<string, string> = {
  "lakefile.lean": LAKEFILE,
  "src/Main.lean": "def Main.hello := 1\n",
  "src/Mini.lean": "import Mini.Leaf\n",
  "src/Mini/Leaf.lean": "def Mini.leaf := 1\n",
  "tests/ATest.lean": "import Mini\n#guard 1 + 1 == 2\n",
  "tests/MainTest.lean": "import ATest\ndef main : IO Unit := pure ()\n",
  "tools/Ext.lean": "import Ext.Part\n",
  "tools/Ext/Part.lean": "def Ext.part := 1\n",
  "spec/Doc.lean": "import Ext\n",
};

function writeRepo(dir: string, files: Record<string, string>): void {
  for (const [path, content] of Object.entries(files)) {
    const target = `${dir}/${path}`;
    const slash = target.lastIndexOf("/");
    if (slash > 0) Deno.mkdirSync(target.slice(0, slash), { recursive: true });
    Deno.writeTextFileSync(target, content);
  }
}

function makeRepo(
  overrides: Record<string, string | null> = {},
): string {
  const dir = Deno.makeTempDirSync();
  const files = { ...BASE_FILES };
  for (const [path, content] of Object.entries(overrides)) {
    if (content === null) delete files[path];
    else files[path] = content;
  }
  writeRepo(dir, files);
  return dir;
}

function runRepo(
  overrides: Record<string, string | null> = {},
  scanDirs: readonly string[] = [...DEFAULT_SCAN_DIRS],
  rootsIn?: string,
): LeanModulesResult {
  const repo = makeRepo(overrides);
  try {
    return checkLeanModules(repo, scanDirs, rootsIn);
  } finally {
    Deno.removeSync(repo, { recursive: true });
  }
}

function assertCode(
  result: LeanModulesResult,
  code: number,
  context = "",
): void {
  assertEquals(
    result.code,
    code,
    `${context} stdout=${result.stdout} stderr=${result.stderr}`,
  );
}

function assertUnrecognized(
  result: LeanModulesResult,
  reason: string,
): void {
  assertCode(result, 2);
  assertStringIncludes(result.stderr, "cannot analyse");
  assertStringIncludes(result.stderr, reason);
  assertEquals(result.stdout, "");
}

function lakefileWithout(
  oldText: string,
  replacement = "",
): Record<string, string> {
  assertEquals(
    LAKEFILE.split(oldText).length - 1,
    1,
    `expected one ${oldText}`,
  );
  return { "lakefile.lean": LAKEFILE.replace(oldText, replacement) };
}

Deno.test("complete repository passes with the exact success report", () => {
  const result = runRepo();
  assertCode(result, 0);
  assertEquals(
    result.stdout.trim(),
    "check_lean_modules: 8 Lean file(s) under src, tests, tools, spec, all reachable from " +
      "the 6 root(s) of 5 lean_lib/lean_exe target(s).",
  );
});

Deno.test("orphan module in src is reported", () => {
  const result = runRepo({ "src/Mini/Orphan.lean": "def Mini.orphan := 1\n" });
  assertCode(result, 1);
  assertStringIncludes(result.stdout, "src/Mini/Orphan.lean");
  assert(!result.stdout.includes("src/Mini/Leaf.lean"));
});

Deno.test("orphan test is reported", () => {
  const result = runRepo({ "tests/OrphanTest.lean": "#guard 2 + 2 == 5\n" });
  assertCode(result, 1);
  assertStringIncludes(result.stdout, "tests/OrphanTest.lean");
});

Deno.test("transitive import makes a module reachable", () => {
  const result = runRepo({
    "src/Mini/Leaf.lean": "import Mini.Deep\n",
    "src/Mini/Deep.lean": "def Mini.deep := 1\n",
  });
  assertCode(result, 0);
});

Deno.test("test module imported only by the executable is reachable", () => {
  const result = runRepo({
    "tests/MainTest.lean":
      "import ATest\nimport BTest\ndef main : IO Unit := pure ()\n",
    "tests/BTest.lean": "#guard true\n",
  });
  assertCode(result, 0);
});

Deno.test("imports hidden in comments do not count", () => {
  const result = runRepo({
    "src/Mini.lean":
      "import Mini.Leaf\n-- import Mini.Orphan\n/- import Mini.Orphan -/\n" +
      "/-! import Mini.Orphan\n/- nested -/ import Mini.Orphan -/\n",
    "src/Mini/Orphan.lean": "def Mini.orphan := 1\n",
  });
  assertCode(result, 1);
  assertStringIncludes(result.stdout, "src/Mini/Orphan.lean");
});

Deno.test("import after the header does not count", () => {
  const result = runRepo({
    "src/Mini.lean": "import Mini.Leaf\n\ndef x := 1\nimport Mini.Orphan\n",
    "src/Mini/Orphan.lean": "def Mini.orphan := 1\n",
  });
  assertCode(result, 1);
});

Deno.test("comment between two imports is skipped", () => {
  const result = runRepo({
    "src/Mini.lean": "import Mini.Leaf\n-- a comment inside the header\n" +
      "/- another -/\nimport Mini.Other\n",
    "src/Mini/Other.lean": "def Mini.other := 1\n",
  });
  assertCode(result, 0);
});

Deno.test("import modifiers are followed", () => {
  const result = runRepo({
    "src/Mini.lean": "module\npublic import Mini.Leaf\nimport all Mini.Other\n",
    "src/Mini/Other.lean": "def Mini.other := 1\n",
  });
  assertCode(result, 0);
});

Deno.test("header grammar of Lean 4.34", () => {
  const header =
    "module\nprelude\npublic meta import Mini.A\nmeta import all Mini.B\n" +
    "public import Mini.C\nimport Mini.D\n";
  const overrides: Record<string, string | null> = {
    "src/Mini.lean": header,
    "src/Mini/Leaf.lean": null,
  };
  for (const name of "ABCD") {
    overrides[`src/Mini/${name}.lean`] = `def Mini.x${name} := 1\n`;
  }
  const repo = makeRepo(overrides);
  try {
    assertCode(checkLeanModules(repo, [...DEFAULT_SCAN_DIRS]), 0);
    assertEquals(importsOf(`${repo}/src/Mini.lean`), [
      "Mini.A",
      "Mini.B",
      "Mini.C",
      "Mini.D",
    ]);
  } finally {
    Deno.removeSync(repo, { recursive: true });
  }
});

Deno.test("module and prelude are each optional", () => {
  for (
    const header of [
      "module\nimport Mini.Leaf\n",
      "prelude\nimport Mini.Leaf\n",
      "import Mini.Leaf\n",
    ]
  ) {
    const repo = makeRepo({ "src/Mini.lean": header });
    try {
      assertEquals(importsOf(`${repo}/src/Mini.lean`), ["Mini.Leaf"]);
    } finally {
      Deno.removeSync(repo, { recursive: true });
    }
  }
});

Deno.test("comments separate tokens without whitespace", () => {
  const header = "import Mini.A--line comment right after the name\n" +
    "import/- block -/Mini.B\n" +
    "/- multi\nline\ncomment -/import Mini.C\n" +
    "/-! doc\n/- nested -/\nstill doc -/\nimport Mini.D\n";
  const repo = makeRepo({ "src/Mini.lean": header });
  try {
    assertEquals(importsOf(`${repo}/src/Mini.lean`), [
      "Mini.A",
      "Mini.B",
      "Mini.C",
      "Mini.D",
    ]);
  } finally {
    Deno.removeSync(repo, { recursive: true });
  }
});

Deno.test("import cycles do not hang", () => {
  const result = runRepo({
    "src/Mini.lean": "import Mini.Leaf\n",
    "src/Mini/Leaf.lean": "import Mini.Cycle\n",
    "src/Mini/Cycle.lean": "import Mini.Leaf\n",
  });
  assertCode(result, 0);
});

Deno.test("report names the problem and the remedy", () => {
  const result = runRepo({ "src/Mini/Orphan.lean": "def Mini.orphan := 1\n" });
  assertCode(result, 1);
  assertEquals(result.stderr, "");
  const lines = result.stdout.split("\n");
  assertEquals(
    lines[0],
    "check_lean_modules: Lean files that no lean_lib/lean_exe root reaches:",
  );
  assertEquals(lines[1], "  src/Mini/Orphan.lean");
  assertStringIncludes(lines[2], "`lake build` never compiles them.");
  assertStringIncludes(lines[2], "`roots` of a lean_lib of lakefile.lean");
});

Deno.test("default scan covers tools and spec", () => {
  for (
    const [label, overrides] of [
      ["tools", { "tools/Ext/Orphan.lean": "def Ext.orphan := 1\n" }],
      ["spec", { "spec/Doc/Orphan.lean": "#doc orphan\n" }],
    ] as const
  ) {
    const result = runRepo(overrides);
    assertCode(result, 1);
    assertStringIncludes(result.stdout, `${label}/`);
    assertCode(runRepo(overrides, ["src", "tests"]), 0);
  }
});

Deno.test("a directory outside the source directories is not scanned by default", () => {
  const overrides = { "extra/prototype/Annex.lean": "def annex := 1\n" };
  assertCode(runRepo(overrides), 0);
  const result = runRepo(overrides, [...DEFAULT_SCAN_DIRS, "extra"]);
  assertCode(result, 1);
  assertStringIncludes(result.stdout, "extra/prototype/Annex.lean");
});

Deno.test("a nested Lake workspace is skipped and named", () => {
  for (const lakefile of ["lakefile.lean", "lakefile.toml"]) {
    const result = runRepo({
      [`spec/chain/${lakefile}`]: "-- own workspace\n",
      "spec/chain/Blueprint.lean": "def blueprint := 1\n",
    });
    assertCode(result, 0, lakefile);
    assertEquals(
      result.stdout.split("\n").filter((l) => l !== "").at(-1),
      "check_lean_modules: not scanned: spec/chain/, a separate Lake workspace with " +
        "its own lakefile",
    );
  }
});

Deno.test("without its lakefile the same directory is scanned", () => {
  const result = runRepo({
    "spec/chain/Blueprint.lean": "def blueprint := 1\n",
  });
  assertCode(result, 1);
  assertStringIncludes(result.stdout, "spec/chain/Blueprint.lean");
  assert(!result.stdout.includes("not scanned"));
});

Deno.test("an orphan beside a nested workspace is still reported", () => {
  const result = runRepo({
    "spec/chain/lakefile.lean": "-- own workspace\n",
    "spec/Orphan.lean": "def orphan := 1\n",
  });
  assertCode(result, 1);
  assertStringIncludes(result.stdout, "  spec/Orphan.lean");
  assertStringIncludes(result.stdout, "not scanned: spec/chain/");
});

Deno.test("incomplete import is ignored, not a crash", () => {
  const repo = makeRepo({ "src/Mini.lean": "import Mini.Leaf\nimport all\n" });
  try {
    assertEquals(importsOf(`${repo}/src/Mini.lean`), ["Mini.Leaf"]);
  } finally {
    Deno.removeSync(repo, { recursive: true });
  }
  const repo2 = makeRepo({ "src/Mini.lean": "import" });
  try {
    assertEquals(importsOf(`${repo2}/src/Mini.lean`), []);
  } finally {
    Deno.removeSync(repo2, { recursive: true });
  }
});

Deno.test("text that is not a header stops the scan", () => {
  const repo = makeRepo({
    "src/Mini.lean": "/-! doc -/\nopen Nat\nimport Mini.Leaf\n",
  });
  try {
    assertEquals(importsOf(`${repo}/src/Mini.lean`), []);
  } finally {
    Deno.removeSync(repo, { recursive: true });
  }
});

Deno.test("dirs option limits the scan", () => {
  const overrides = { "tests/OrphanTest.lean": "#guard true\n" };
  assertCode(runRepo(overrides), 1);
  assertCode(runRepo(overrides, ["src"]), 0);
});

Deno.test("every orphan is listed", () => {
  const result = runRepo({
    "src/A.lean": "def a := 1\n",
    "tests/BTest.lean": "def b := 1\n",
  });
  assertCode(result, 1);
  assertStringIncludes(result.stdout, "src/A.lean");
  assertStringIncludes(result.stdout, "tests/BTest.lean");
});

Deno.test("dot-lake is not scanned", () => {
  const result = runRepo({ "src/.lake/Hidden.lean": "def h := 1\n" });
  assertCode(result, 0);
});

Deno.test("loud failures: missing lakefile, toml hint, no targets", () => {
  assertUnrecognized(runRepo({ "lakefile.lean": null }), "not found");
  assertUnrecognized(
    runRepo({ "lakefile.lean": null, "lakefile.toml": "name = 'x'\n" }),
    "lakefile.toml is not supported",
  );
  assertUnrecognized(
    runRepo({ "lakefile.lean": "import Lake\npackage p\n" }),
    "no lean_lib/lean_exe declaration",
  );
  const missing = runRepo({ "lakefile.lean": null });
  assert(missing.stderr.trimEnd().endsWith("lakefile.lean not found"));
  const toml = runRepo({ "lakefile.lean": null, "lakefile.toml": "x = 1\n" });
  assert(
    toml.stderr.trimEnd().endsWith(
      "lakefile.lean not found (lakefile.toml is not supported)",
    ),
  );
});

Deno.test("loud failures: unsupported declaration shapes", () => {
  assertUnrecognized(
    runRepo(lakefileWithout(
      "roots := #[`ATest]",
      "roots := #[`ATest]\n  globs := #[.submodules `ATest]",
    )),
    "`globs`",
  );
  assertUnrecognized(
    runRepo(lakefileWithout("roots := #[`ATest]", "roots := myRoots")),
    "`roots` is missing or is not a literal list",
  );
  assertUnrecognized(
    runRepo(lakefileWithout(
      "roots := #[`ATest]",
      "roots := #[`ATest, mkRoot]",
    )),
    "something other than name literals",
  );
  assertUnrecognized(
    runRepo(lakefileWithout(
      'srcDir := "tests"\n  roots',
      "srcDir := testDir\n  roots",
    )),
    "`srcDir` is missing or is not a string literal",
  );
  const computed: Array<[string, string, string]> = [
    [
      'srcDir := "tests"\n  roots',
      'srcDir := "tests" / "x"\n  roots',
      "`srcDir`",
    ],
    [
      'srcDir := "tests"\n  roots',
      'srcDir := "tests" ++ suffix\n  roots',
      "`srcDir`",
    ],
    ["roots := #[`ATest]", "roots := #[`ATest] ++ more", "`roots`"],
    ["root := `MainTest", "root := `MainTest |>.foo", "`root`"],
  ];
  for (const [oldText, replacement, reason] of computed) {
    assertUnrecognized(runRepo(lakefileWithout(oldText, replacement)), reason);
  }
  assertUnrecognized(
    runRepo(lakefileWithout("root := `MainTest", "root := mkRoot")),
    "`root` is missing or is not a name literal",
  );
  assertUnrecognized(
    runRepo(lakefileWithout("lean_lib MiniTests where", "lean_lib MiniTests")),
    "unsupported syntax",
  );
  assertUnrecognized(
    runRepo(lakefileWithout(
      "@[test_driver]\nlean_exe mainTest where",
      "@[test_driver] lean_exe mainTest where",
    )),
    "unsupported syntax",
  );
  assertUnrecognized(
    runRepo({
      "lakefile.lean":
        `${LAKEFILE}\nmeta if true then\n  lean_lib Hidden where\n    srcDir := "x"\n`,
    }),
    "unsupported syntax",
  );
});

Deno.test("loud failures: Lake defaults are not assumed", () => {
  assertUnrecognized(
    runRepo(
      lakefileWithout(
        '  srcDir := "tests"\n  roots := #[`ATest]',
        "  roots := #[`ATest]",
      ),
    ),
    "`srcDir` is missing",
  );
  assertUnrecognized(
    runRepo(lakefileWithout("  roots := #[`ATest]\n", "")),
    "`roots` is missing",
  );
  assertUnrecognized(
    runRepo(lakefileWithout("  root := `MainTest\n", "")),
    "`root` is missing",
  );
});

Deno.test("accepted shapes: trailing comma, where-line field, multi-line roots, comments", () => {
  assertCode(
    runRepo(lakefileWithout(
      'srcDir := "tests"\n  roots',
      'srcDir := "tests",\n  roots',
    )),
    0,
  );
  assertCode(
    runRepo(lakefileWithout(
      'lean_lib MiniTests where\n  srcDir := "tests"',
      'lean_lib MiniTests where srcDir := "tests"',
    )),
    0,
  );
  assertUnrecognized(
    runRepo(lakefileWithout(
      'lean_lib MiniTests where\n  srcDir := "tests"',
      "lean_lib MiniTests where srcDir := nope",
    )),
    "`srcDir` is missing or is not a string literal",
  );
  assertCode(
    runRepo(lakefileWithout(
      "roots := #[`Main, `Mini]",
      "roots := #[\n    `Main,\n    `Mini\n  ]",
    )),
    0,
  );
  assertCode(
    runRepo(lakefileWithout(
      '  srcDir := "tests"\n  roots := #[`ATest]',
      '  srcDir := "tests"\n  /- a comment\n     over two lines -/\n  roots := #[`ATest]',
    )),
    0,
  );
  assertCode(
    runRepo({
      "lakefile.lean":
        `${LAKEFILE}\n-- lean_lib Ghost where\n/- lean_exe ghost -/\n`,
    }),
    0,
  );
});

Deno.test("a declaration body ends at the next unindented line", () => {
  assertUnrecognized(
    runRepo(lakefileWithout(
      'lean_lib MiniTests where\n  srcDir := "tests"\n  roots := #[`ATest]',
      'lean_lib MiniTests where\n  roots := #[`ATest]\nx srcDir := "tests"',
    )),
    "`srcDir` is missing or is not a string literal",
  );
});

Deno.test("loud failures: missing root file and missing scanned directory", () => {
  assertUnrecognized(
    runRepo({ "tests/ATest.lean": null }),
    "root module ATest has no file",
  );
  assertUnrecognized(
    runRepo({}, ["src", "nowhere"]),
    "nowhere/ does not exist",
  );
});

Deno.test("roots-in lists the roots of one directory", () => {
  const result = runRepo({}, [...DEFAULT_SCAN_DIRS], "tests");
  assertCode(result, 0);
  assertEquals(result.stdout.split("\n").filter((l) => l !== ""), [
    "ATest",
    "MainTest",
  ]);
  const unknown = runRepo({}, [...DEFAULT_SCAN_DIRS], "elsewhere");
  assertCode(unknown, 2);
  assertEquals(unknown.stdout, "");
  assertStringIncludes(unknown.stderr, "cannot analyse");
});

Deno.test("stripComments: line and nested block comments", () => {
  assertEquals(
    stripComments("a -- b\nc /- d /- e -/ f -/ g\n").split(/\s+/).filter(
      Boolean,
    ),
    ["a", "c", "g"],
  );
  assertStringIncludes(stripComments('x := "a -- b /- c"\ny'), '"a -- b /- c"');
  const escaped = stripComments(
    'x := "a\\"b -- still a string" -- real comment\ny',
  );
  assertStringIncludes(escaped, "-- still a string");
  assert(!escaped.includes("real comment"));
  assert(escaped.trimEnd().endsWith("y"));
  assertEquals(stripComments('"abc\\'), '"abc\\');
  assertEquals(stripComments("/- a -/import").split(/\s+/).filter(Boolean), [
    "import",
  ]);
  assertEquals(stripComments("/-a-/x/-b-/y").split(/\s+/).filter(Boolean), [
    "x",
    "y",
  ]);
  assertEquals(
    stripComments("def f (n : Nat) : Nat := n + 1\n"),
    "def f (n : Nat) : Nat := n + 1\n",
  );
  assertEquals(stripComments("a/- x\ny -/b"), "a    \n    b");
  const text = "a\n/- one\ntwo -/\nb\n";
  assertEquals(
    stripComments(text).split("\n").length - 1,
    text.split("\n").length - 1,
  );
});

Deno.test("a CRLF lakefile is accepted, as in Python", () => {
  // Both implementations split the declaration body into
  // lines and rejoin with `\n` before reading fields, so
  // `\r` never reaches the field patterns.
  const crlf = LAKEFILE.replace(/\n/g, "\r\n");
  assertCode(runRepo({ "lakefile.lean": crlf }), 0);
});

Deno.test("malformed inputs: empty lakefile and unreadable Lean files", () => {
  assertUnrecognized(
    runRepo({ "lakefile.lean": "" }),
    "no lean_lib/lean_exe declaration",
  );
  let threw = false;
  try {
    parseLakefile("/definitely/not/a/lakefile.lean");
  } catch (error) {
    threw = error instanceof Unrecognized;
  }
  assert(threw, "parseLakefile on a missing file must throw Unrecognized");
  // A Lean file that is not valid UTF-8 cannot be read as
  // text: like the Python script (UnicodeDecodeError), the
  // port does not turn this into a clean code-2 failure.
  const repo = makeRepo();
  try {
    Deno.writeFileSync(
      `${repo}/src/Mini.lean`,
      new Uint8Array([0xff, 0xfe, 0x0a]),
    );
    let raised = false;
    try {
      checkLeanModules(repo, [...DEFAULT_SCAN_DIRS]);
    } catch {
      raised = true;
    }
    assert(raised, "non-UTF-8 input must raise rather than pass silently");
  } finally {
    Deno.removeSync(repo, { recursive: true });
  }
});

Deno.test("real repository has no orphan and is not vacuous", () => {
  const result = checkLeanModules(REPO_ROOT, [...DEFAULT_SCAN_DIRS]);
  assertCode(result, 0, result.stdout + result.stderr);
  const targets = parseLakefile(`${REPO_ROOT}/lakefile.lean`);
  const names = new Set(targets.map((t) => t.name));
  assert(names.has("K7pl") && names.has("K7plTests") && names.has("mainTest"));
  const reachable = reachableFiles(REPO_ROOT, targets);
  const scanned = scan(REPO_ROOT, [...DEFAULT_SCAN_DIRS]);
  for (
    const expected of [
      "src/K7pl/Arith.lean",
      "src/K7pl/Semantics.lean",
      "tests/ArithTest.lean",
      "tools/SpecExt/IndexCore.lean",
      "tools/prototypes-bcd/AnnexB.lean",
      "spec/Spec.lean",
    ]
  ) {
    assert(reachable.has(`${REPO_ROOT}/${expected}`), expected);
    assert(scanned.includes(`${REPO_ROOT}/${expected}`), expected);
  }
  assert(scanned.length >= 100, `scanned ${scanned.length} files`);
  const workspaces = nestedWorkspaces(REPO_ROOT, [...DEFAULT_SCAN_DIRS]);
  assert(workspaces.includes(`${REPO_ROOT}/spec/formal-chain`));
  assert(workspaces.includes(`${REPO_ROOT}/tools/paperproof-export`));
  assertStringIncludes(result.stdout, "not scanned: spec/formal-chain/");
  assertStringIncludes(result.stdout, "not scanned: tools/paperproof-export/");
  // Every srcDir is a scanned directory or lies under one,
  // and every scanned directory is a srcDir.
  const srcDirs = new Set(targets.map((t) => t.srcDir));
  const scannedSet = new Set(DEFAULT_SCAN_DIRS);
  for (const srcDir of srcDirs) {
    assert(
      [...scannedSet].some((d) => srcDir === d || srcDir.startsWith(`${d}/`)),
      srcDir,
    );
  }
  assertEquals([...scannedSet].filter((d) => !srcDirs.has(d)), []);
  const roots = checkLeanModules(REPO_ROOT, [...DEFAULT_SCAN_DIRS], "tests");
  assertCode(roots, 0);
  const rootNames = new Set(roots.stdout.split(/\s+/).filter(Boolean));
  assert(
    rootNames.has("ArithTest") && rootNames.has("SemanticsTest") &&
      rootNames.has("MainTest"),
  );
});

Deno.test("check-lean-modules command usage handling", () => {
  assertEquals(runCheckLeanModulesCommand(["--help"]), 0);
  assertEquals(runCheckLeanModulesCommand(["--no-such-option"]), 2);
  assertEquals(runCheckLeanModulesCommand(["--repo"]), 2);
});
