// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import {
  auditRoot,
  auditRoots,
  AXIOM_AUDIT_SHA,
  type CaptureFn,
  DEFAULT_ALLOW,
  type InheritFn,
  type Runner,
  toolDirFor,
} from "../src/axiom_audit.ts";

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;

Deno.test("tool dir is pinned by commit under RUNNER_TEMP, null otherwise", () => {
  assertEquals(
    toolDirFor("/tmp/runner"),
    `/tmp/runner/axiom-audit-${AXIOM_AUDIT_SHA}`,
  );
  assertEquals(toolDirFor(undefined), null);
  assertEquals(toolDirFor(""), null);
  assertEquals(DEFAULT_ALLOW, "propext,Classical.choice,Quot.sound");
});

interface StubRunner extends Runner {
  calls: string[];
}

function stubRunner(behavior: {
  revParse: string[];
  diffCode?: number;
  cmpCode?: number;
  inheritCode?: (cmd: string, args: string[]) => number;
}): StubRunner {
  const calls: string[] = [];
  let revParseCount = 0;
  const capture: CaptureFn = (cmd, args) => {
    calls.push(`${cmd} ${args.join(" ")}`);
    if (cmd === "git" && args.includes("rev-parse")) {
      const value = behavior.revParse[
        Math.min(
          revParseCount++,
          behavior.revParse.length - 1,
        )
      ];
      return { code: 0, stdout: `${value}\n`, stderr: "" };
    }
    if (cmd === "git" && args.includes("diff")) {
      return { code: behavior.diffCode ?? 0, stdout: "", stderr: "" };
    }
    if (cmd === "cmp") {
      return { code: behavior.cmpCode ?? 0, stdout: "", stderr: "" };
    }
    return { code: 0, stdout: "", stderr: "" };
  };
  const inherit: InheritFn = (cmd, args) => {
    calls.push(`${cmd} ${args.join(" ")}`);
    return behavior.inheritCode?.(cmd, args) ?? 0;
  };
  return { capture, inherit, calls };
}

async function withToolFixture(
  fn: (
    dirs: { repo: string; runnerTemp: string; tool: string },
  ) => Promise<void>,
): Promise<void> {
  const repo = await Deno.makeTempDir();
  const runnerTemp = await Deno.makeTempDir();
  try {
    await Deno.writeTextFile(
      `${repo}/lean-toolchain`,
      "leanprover/lean4:v4.34.0\n",
    );
    const tool = `${runnerTemp}/axiom-audit-${AXIOM_AUDIT_SHA}`;
    await Deno.mkdir(`${tool}/.lake/build/bin`, { recursive: true });
    const bin = `${tool}/.lake/build/bin/axiom-audit`;
    await Deno.writeTextFile(bin, "#!/bin/sh\nexit 0\n");
    await Deno.chmod(bin, 0o755);
    await Deno.writeTextFile(
      `${tool}/lean-toolchain`,
      "leanprover/lean4:v4.34.0\n",
    );
    await fn({ repo, runnerTemp, tool });
  } finally {
    await Deno.remove(repo, { recursive: true }).catch(() => {});
    await Deno.remove(runnerTemp, { recursive: true }).catch(() => {});
  }
}

Deno.test("reusable tool build is reused, clone is not called", async () => {
  await withToolFixture(async ({ repo, runnerTemp }) => {
    const runner = stubRunner({ revParse: [AXIOM_AUDIT_SHA] });
    const result = await auditRoot({
      root: "K7pl",
      targets: ["K7pl"],
      runnerTemp,
      cwd: repo,
      runner,
    });
    assertEquals(result.code, 0);
    assertEquals(result.reused, true);
    assert(!runner.calls.some((call) => call.startsWith("git clone")));
    assert(runner.calls.some((call) => call.includes("lake env")));
  });
});

Deno.test("non-pinned checkout is rebuilt from the pinned commit", async () => {
  await withToolFixture(async ({ repo, runnerTemp, tool }) => {
    const runner = stubRunner({
      revParse: ["deadbeef", AXIOM_AUDIT_SHA],
      inheritCode: (cmd, args) => {
        // The stubbed clone must create the checkout directory,
        // as a real git clone would, for the lean-toolchain copy.
        if (cmd === "git" && args[0] === "clone") {
          Deno.mkdirSync(args[args.length - 1], { recursive: true });
        }
        return 0;
      },
    });
    const result = await auditRoot({
      root: "K7pl",
      targets: ["K7pl"],
      runnerTemp,
      cwd: repo,
      runner,
    });
    assertEquals(result.code, 0);
    assertEquals(result.reused, false);
    assert(runner.calls.some((call) => call.startsWith("git clone")));
    assert(runner.calls.includes("lake build"));
    // The rebuilt tool's lean-toolchain is the project's, copied by the audit.
    assertEquals(
      await Deno.readTextFile(`${tool}/lean-toolchain`),
      "leanprover/lean4:v4.34.0\n",
    );
  });
});

Deno.test("a failed lake build stops the audit before any tool work", async () => {
  await withToolFixture(async ({ repo, runnerTemp }) => {
    const runner = stubRunner({
      revParse: [AXIOM_AUDIT_SHA],
      inheritCode: (cmd, args) => cmd === "lake" && args[0] === "build" ? 3 : 0,
    });
    const result = await auditRoot({
      root: "K7pl",
      targets: ["K7pl"],
      runnerTemp,
      cwd: repo,
      runner,
    });
    assertEquals(result.code, 3);
    assert(!runner.calls.some((call) => call.startsWith("git clone")));
    assert(!runner.calls.some((call) => call.includes("lake env")));
  });
});

Deno.test("fan-out restricts to <prefix>.* roots, bare prefix root excluded", async () => {
  const audited: string[] = [];
  const result = await auditRoots({
    directory: "tools",
    prefix: "Compliance",
    listRoots: () => ["Compliance", "Compliance.Foo", "Other"],
    audit: (options) => {
      audited.push(options.root);
      return { code: 0, errors: [], reused: false };
    },
  });
  assertEquals(result.code, 0);
  // Mirrors grep "^Compliance\." in the shell fan-out: the bare
  // root itself is not matched, only its dotted children.
  assertEquals(audited, ["Compliance.Foo"]);
});

Deno.test("fan-out with a prefix and no match is an error", async () => {
  const result = await auditRoots({
    directory: "tools",
    prefix: "Missing",
    listRoots: () => ["Compliance.Foo"],
    audit: () => ({ code: 0, errors: [], reused: false }),
  });
  assertEquals(result.code, 1);
  assertEquals(result.audited, []);
});

Deno.test("fan-out audits every root and aggregates failures", async () => {
  const audited: string[] = [];
  const result = await auditRoots({
    directory: "tests",
    listRoots: () => ["A", "B"],
    audit: async (options) => {
      audited.push(options.root);
      return options.root === "B"
        ? { code: 1, errors: ["audit of B failed"], reused: false }
        : { code: 0, errors: [], reused: false };
    },
  });
  assertEquals(result.code, 1);
  assertEquals(audited, ["A", "B"]);
  assert(result.errors.length > 0);
});

Deno.test("fan-out lists real roots from the repository lakefile", async () => {
  const result = await auditRoots({
    directory: "tools",
    repoRoot: REPO_ROOT,
    audit: async () => ({ code: 0, errors: [], reused: false }),
  });
  assertEquals(result.code, 0);
  assert(result.audited.length > 0);
  assert(result.audited.every((root) => root.length > 0));
});
