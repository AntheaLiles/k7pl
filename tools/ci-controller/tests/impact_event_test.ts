// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals } from "./assert.ts";
import { classifierArgs, type CommandResult } from "../src/impact_event.ts";

async function assertRejects(
  action: () => Promise<unknown>,
  _errorType: unknown,
  message: string,
): Promise<void> {
  try {
    await action();
  } catch (error) {
    if (error instanceof Error && error.message.includes(message)) return;
    throw new Error(`unexpected rejection: ${String(error)}`);
  }
  throw new Error(`expected rejection containing ${JSON.stringify(message)}`);
}

function mockGit(
  results: Record<string, CommandResult>,
  calls: string[][] = [],
) {
  return {
    calls,
    run: async (args: string[]) => {
      calls.push(args);
      return results[args.join(" ")] ??
        { code: 1, stdout: "", stderr: "unexpected git invocation" };
    },
  };
}

Deno.test("pull request and push events use the supplied base/head", async () => {
  const git = mockGit({});
  assertEquals(
    await classifierArgs({
      EVENT_NAME: "pull_request",
      BASE_SHA: "base123",
      HEAD_SHA: "head456",
    }, git.run),
    ["--base", "base123", "--head", "head456"],
  );
  assertEquals(git.calls, []);
});

Deno.test("manual dispatch always forces full validation", async () => {
  const git = mockGit({});
  assertEquals(
    await classifierArgs({ EVENT_NAME: "workflow_dispatch" }, git.run),
    ["--force-full"],
  );
  assertEquals(git.calls, []);
});

Deno.test("generated-status dispatch forces full validation when head is on main", async () => {
  const git = mockGit({
    "rev-parse --verify --quiet refs/remotes/origin/main": {
      code: 0, stdout: "mainsha\n", stderr: "",
    },
    "merge-base --is-ancestor head456 refs/remotes/origin/main": {
      code: 0, stdout: "", stderr: "",
    },
  });
  assertEquals(
    await classifierArgs({
      EVENT_NAME: "workflow_dispatch",
      REF: "refs/heads/automation/generated-status",
      HEAD_SHA: "head456",
    }, git.run),
    ["--force-full"],
  );
  assertEquals(git.calls.length, 2);
});

Deno.test("generated-status dispatch classifies against merge base", async () => {
  const git = mockGit({
    "rev-parse --verify --quiet refs/remotes/origin/main": {
      code: 0, stdout: "mainsha\n", stderr: "",
    },
    "merge-base --is-ancestor head456 refs/remotes/origin/main": {
      code: 1, stdout: "", stderr: "",
    },
    "merge-base refs/remotes/origin/main head456": {
      code: 0, stdout: "mergebase123\n", stderr: "",
    },
  });
  assertEquals(
    await classifierArgs({
      EVENT_NAME: "workflow_dispatch",
      REF: "refs/heads/automation/generated-status",
      HEAD_SHA: "head456",
    }, git.run),
    ["--base", "mergebase123", "--head", "head456"],
  );
});

Deno.test("generated-status dispatch fails closed when main is unavailable", async () => {
  const git = mockGit({
    "rev-parse --verify --quiet refs/remotes/origin/main": {
      code: 1, stdout: "", stderr: "missing ref",
    },
  });
  await assertRejects(
    () => classifierArgs({
      EVENT_NAME: "workflow_dispatch",
      REF: "refs/heads/automation/generated-status",
      HEAD_SHA: "head456",
    }, git.run),
    Error,
    "origin/main is not available",
  );
});

Deno.test("missing merge base fails closed", async () => {
  const git = mockGit({
    "rev-parse --verify --quiet refs/remotes/origin/main": {
      code: 0, stdout: "mainsha\n", stderr: "",
    },
    "merge-base --is-ancestor head456 refs/remotes/origin/main": {
      code: 1, stdout: "", stderr: "",
    },
    "merge-base refs/remotes/origin/main head456": {
      code: 1, stdout: "", stderr: "no merge base",
    },
  });
  await assertRejects(
    () => classifierArgs({
      EVENT_NAME: "workflow_dispatch",
      REF: "refs/heads/automation/generated-status",
      HEAD_SHA: "head456",
    }, git.run),
    Error,
    "no merge base",
  );
});

Deno.test("ordinary events require both SHAs", async () => {
  await assertRejects(
    () => classifierArgs({ EVENT_NAME: "push", HEAD_SHA: "head456" }, async () => ({
      code: 0, stdout: "", stderr: "",
    })),
    Error,
    "BASE_SHA and HEAD_SHA are required",
  );
});
