// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import { check, SELF_EXEMPTIONS } from "../src/documentation_architecture.ts";

const HEADINGS: Record<string, string> = {
  "wiki/HOME.md": "# K7PL Wiki",
  "wiki/understanding.md": "# Understanding K7PL",
  "wiki/layers.md": "# The Three Layers",
  "wiki/research.md": "# Research",
  "wiki/assurance.md": "# Assurance",
  "wiki/method.md": "# Method",
  "wiki/STATUS.md": "# K7PL Status",
};

async function cleanTree(): Promise<
  { root: string; cleanup: () => Promise<void> }
> {
  const root = await Deno.makeTempDir();
  await Deno.mkdir(`${root}/wiki`, { recursive: true });
  for (const [rel, heading] of Object.entries(HEADINGS)) {
    await Deno.writeTextFile(`${root}/${rel}`, `${heading}\n`);
  }
  await Deno.writeTextFile(`${root}/wiki/references.json`, "{}\n");
  return { root, cleanup: () => Deno.remove(root, { recursive: true }) };
}

async function write(
  root: string,
  rel: string,
  content: string,
): Promise<void> {
  const path = `${root}/${rel}`;
  await Deno.mkdir(path.split("/").slice(0, -1).join("/"), { recursive: true });
  await Deno.writeTextFile(path, content);
}

function contains(errors: string[], needle: string): boolean {
  return errors.some((error) => error.includes(needle));
}

Deno.test("documentation_architecture: clean tree passes", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    assertEquals(await check(root), []);
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: docs/ is no longer required", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    let docsExists = true;
    try {
      await Deno.stat(`${root}/docs`);
    } catch {
      docsExists = false;
    }
    assert(!docsExists);
    assertEquals(await check(root), []);
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: root biblio file is rejected", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await write(root, "biblio/references.json", "{}\n");
    assert(
      contains(
        await check(root),
        "legacy path still exists: biblio/references.json",
      ),
    );
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: docs/archives/ and docs/history/ directories are legacy", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await Deno.mkdir(`${root}/docs/archives`, { recursive: true });
    await Deno.mkdir(`${root}/docs/history`, { recursive: true });
    const errors = await check(root);
    assert(contains(errors, "legacy path still exists: docs/archives/"));
    assert(contains(errors, "legacy path still exists: docs/history/"));
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: root archives/ directory is rejected", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await Deno.mkdir(`${root}/archives`);
    assert(contains(await check(root), "legacy path still exists: archives/"));
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: legacy reference in a scanned file is rejected", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await write(
      root,
      "scripts/ci/note.md",
      "# Note\nSee [the old tracker](docs/suivi/README.md).\n",
    );
    assert(contains(await check(root), "obsolete path reference"));
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: docs/archives/ reference from a scanned surface is now obsolete", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await write(
      root,
      "scripts/ci/note.md",
      "# Note\nSee docs/archives/old.md.\n",
    );
    const errors = await check(root);
    assert(contains(errors, "obsolete path reference"));
    assert(contains(errors, "docs/archives/"));
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: docs/history/ reference from a scanned surface is now obsolete", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await write(root, "tools/note.md", "# Note\nSee docs/history/old.md.\n");
    assert(contains(await check(root), "obsolete path reference"));
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: bare archives/ reference is allowed (first legacy marker is not scanned)", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await write(
      root,
      "scripts/ci/note.md",
      "# Note\nHistorical material is kept in archives/.\n",
    );
    assertEquals(await check(root), []);
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: a docs/ file is unscanned, so its historical references pass", async () => {
  // Adapted from the Python tests: the old self-exceptions
  // for docs/tracking/COHERENCE-REVIEW.md and for
  // docs/security/*/AUDIT.md are dropped because docs/ is
  // no longer a scan root at all.
  const { root, cleanup } = await cleanTree();
  try {
    await write(
      root,
      "docs/README.md",
      "# K7PL Documentation\nSee docs/archives/.\n",
    );
    await write(
      root,
      "docs/security/workstreams/cii/AUDIT.md",
      "# Audit\nHistorical reviews were under `docs/relectures/`.\n",
    );
    assertEquals(await check(root), []);
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: non-English entry point is rejected", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await write(root, "wiki/method.md", "# Méthode K7PL\n");
    assert(contains(await check(root), "non-English or unexpected"));
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: missing required file is rejected", async () => {
  const { root, cleanup } = await cleanTree();
  try {
    await Deno.remove(`${root}/wiki/method.md`);
    assert(
      contains(await check(root), "required file missing: wiki/method.md"),
    );
  } finally {
    await cleanup();
  }
});

Deno.test("documentation_architecture: guard and legacy reference files are exempt", async () => {
  for (
    const path of [
      "scripts/ci/check_documentation_architecture.py",
      "scripts/ci/test_documentation_architecture.py",
      "tools/ci-controller/src/documentation_architecture.ts",
      "tools/ci-controller/tests/documentation_architecture_test.ts",
    ]
  ) {
    assert(SELF_EXEMPTIONS.has(path), path);
  }
  const { root, cleanup } = await cleanTree();
  try {
    for (
      const path of [
        "scripts/ci/check_documentation_architecture.py",
        "scripts/ci/test_documentation_architecture.py",
        "tools/ci-controller/src/documentation_architecture.ts",
        "tools/ci-controller/tests/documentation_architecture_test.ts",
      ]
    ) {
      await write(
        root,
        path,
        "legacy table mentions docs/suivi/, docs/archives/ and docs/history/\n",
      );
    }
    assertEquals(await check(root), []);
  } finally {
    await cleanup();
  }
});
