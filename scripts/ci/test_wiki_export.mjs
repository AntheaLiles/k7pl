// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1

import assert from "node:assert/strict";
import { access, mkdir, mkdtemp, readFile, rm, symlink, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { buildWikiExport } from "./wiki_export.mjs";

async function fixture(t) {
  const root = await mkdtemp(path.join(os.tmpdir(), "k7pl-wiki-export-"));
  t.after(async () => rm(root, { recursive: true, force: true }));
  const docs = path.join(root, "docs");
  const output = path.join(root, "output");
  await mkdir(path.join(docs, "tracking"), { recursive: true });
  await mkdir(path.join(docs, "archives"), { recursive: true });
  await mkdir(path.join(docs, "security", "workstreams", "cii"), { recursive: true });
  await mkdir(path.join(docs, "security", "workstreams", "scorecard"), { recursive: true });
  await mkdir(path.join(docs, "data"), { recursive: true });
  await mkdir(path.join(root, "spec"), { recursive: true });
  const fence = String.fromCharCode(96).repeat(3);
  await writeFile(path.join(docs, "HOME.md"),
    "# K7PL Wiki\n\n[Nested page](tracking/DASHBOARD.md#state)\n\n" +
    "[Resource](data/references.json)\n\n[Archive](archives/README.md)\n\n" +
    "[Specification](../spec/SPEC.md)\n\n[reference][design]\n\n" +
    fence + "md\n[not a link](missing.md)\n" + fence + "\n\n" +
    "[design]: tracking/DASHBOARD.md\n");
  await writeFile(path.join(docs, "tracking", "DASHBOARD.md"), "# Dashboard\n\n[Home](../HOME.md)\n");
  await writeFile(path.join(docs, "archives", "README.md"), "# Frozen archive\n");
  await writeFile(path.join(docs, "security", "workstreams", "cii", "AUDIT.md"), "# CII audit\n");
  await writeFile(path.join(docs, "security", "workstreams", "scorecard", "AUDIT.md"), "# Scorecard audit\n");
  await writeFile(path.join(docs, "data", "references.json"), "{\"ok\":true}\n");
  await writeFile(path.join(root, "spec", "SPEC.md"), "# Normative spec\n");
  return { root, docs, output };
}

test("excludes docs/archives and publishes pages, resources, indexes, and provenance", async (t) => {
  const f = await fixture(t);
  const result = await buildWikiExport({
    sourceDir: f.docs, destDir: f.output, repository: "owner/repo", sourceRef: "abc123def456",
  });
  const names = await (await import("node:fs/promises")).readdir(f.output);
  for (const name of [
    "Home.md", "tracking--DASHBOARD.md", "security--workstreams--cii--AUDIT.md",
    "security--workstreams--scorecard--AUDIT.md", "_Sidebar.md", "Publication-manifest.json",
    "K7PL--Publication.md",
  ]) assert.ok(names.includes(name), "missing expected output: " + name);
  assert.equal(names.includes("README.md"), false);
  assert.equal(names.includes("HOME.md"), false);
  assert.equal(result.excludedPaths[0], "docs/archives/**");

  const home = await readFile(path.join(f.output, "Home.md"), "utf8");
  assert.match(home, /tracking--DASHBOARD#state/);
  assert.match(home, /assets\/data\/references\.json/);
  assert.match(home, /https:\/\/github\.com\/owner\/repo\/blob\/abc123def456\/docs\/archives\/README\.md/);
  assert.match(home, /https:\/\/github\.com\/owner\/repo\/blob\/abc123def456\/spec\/SPEC\.md/);
  assert.match(home, /\[reference\]\[design\]/);
  assert.match(home, /\[design\]: tracking--DASHBOARD/);
  assert.match(home, /\[not a link\]\(missing\.md\)/);
  assert.equal(await readFile(path.join(f.output, "assets", "data", "references.json"), "utf8"), "{\"ok\":true}\n");
  await assert.rejects(access(path.join(f.output, "assets", "archives", "README.md")));
  const manifest = JSON.parse(await readFile(path.join(f.output, "Publication-manifest.json"), "utf8"));
  assert.equal(manifest.source_ref, "abc123def456");
  assert.deepEqual(manifest.excluded_paths, ["docs/archives/**"]);
  assert.ok(manifest.files.some((file) => file.source === "docs/tracking/DASHBOARD.md"));
  assert.ok(!manifest.files.some((file) => file.source.startsWith("docs/archives/")));
  assert.equal(manifest.files.length, result.files);
});

test("keeps flattened page names distinct when source basenames collide", async (t) => {
  const f = await fixture(t);
  await buildWikiExport({
    sourceDir: f.docs, destDir: f.output, repository: "owner/repo", sourceRef: "abc123",
  });
  const names = await (await import("node:fs/promises")).readdir(f.output);
  assert.deepEqual(names.filter((name) => name.endsWith("AUDIT.md")).sort(), [
    "security--workstreams--cii--AUDIT.md",
    "security--workstreams--scorecard--AUDIT.md",
  ]);
});

test("fails rather than silently excluding a required source page", async (t) => {
  const f = await fixture(t);
  await rm(path.join(f.docs, "HOME.md"));
  await assert.rejects(
    buildWikiExport({ sourceDir: f.docs, destDir: f.output, repository: "owner/repo", sourceRef: "abc123" }),
    /docs\/HOME\.md is required/,
  );
});

test("rejects symlinks so the export cannot read outside docs/", async (t) => {
  const f = await fixture(t);
  await symlink(path.join(f.root, "spec", "SPEC.md"), path.join(f.docs, "link.md"));
  await assert.rejects(
    buildWikiExport({ sourceDir: f.docs, destDir: f.output, repository: "owner/repo", sourceRef: "abc123" }),
    /Symbolic links are not supported/,
  );
});
