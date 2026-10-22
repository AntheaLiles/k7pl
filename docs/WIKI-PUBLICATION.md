<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# GitHub Wiki publication

## Authority and scope

The repository is the sole authoring source. Changes are made in docs/ through pull requests; the wiki is generated output and must not be edited as an independent source of truth.

The publication includes every file under docs/ except docs/archives/**. The archive exclusion is deliberate: this subtree preserves frozen legacy manuscripts and tooling and is not part of the active Wiki navigation. Links to excluded archive files are redirected to the immutable source commit.

Markdown pages are flattened into the Wiki page namespace. Their names include their source directory path where needed, so repeated basenames such as README.md or AUDIT.md remain distinct. Non-Markdown files are copied below assets/. Generated indexes provide navigation by source directory; _Sidebar.md is generated as well.

## Source of truth and traceability

Each publication is tied to the exact commit SHA that triggered it. The generated Publication-manifest.json records the source path, output path, source SHA-256, and published SHA-256 for every included file. K7PL--Publication.md gives the corresponding human-readable provenance.

The SHA-256 values have a precise scope: source_sha256 hashes the bytes committed in docs/; published_sha256 hashes the exact page bytes after link rewriting and the standard provenance banner (for Home.md). They do not assert that GitHub's rendered HTML is semantically equivalent to the source Markdown.

## CI and publication policy

Pull requests run the exporter's dependency-free Node.js tests and build the proposed export without writing to the wiki. Pushes to main run the same validation before publication. workflow_dispatch can republish main.

The workflow commits the complete generated tree to the wiki repository using a normal fast-forward push. It does not force-push or modify the main repository. If the wiki has uncommitted/manual pages, they are replaced by the generated export on the next successful publication. This is intentional: the wiki is a publication target, not a second authoring surface.

The wiki repository must be initialized once through GitHub before the first publication. If cloning the wiki fails, the workflow stops with an actionable error instead of attempting to initialize or overwrite a repository.

The workflow uses the repository-provided GITHUB_TOKEN with contents: write only in the publication job. Whether GitHub permits that token to push to the wiki must be verified by the first controlled run; permissions or repository policy may require a maintainer-side adjustment.

## Checks

The exporter fails on a missing docs/README.md, invalid UTF-8 in a Markdown page, or symbolic links under docs/. The tests cover archive exclusion, link rewrites, preserved resources, duplicate page basenames, the provenance manifest, and symlink rejection. The workflow runs the test suite on pull requests; the repository CI retains its separate documentation-link, REUSE, specification, Lean, and security checks.

The export is designed to be deterministic for a fixed source tree and source SHA. It does not guarantee resolution of every external URL, validate Markdown rendering in GitHub itself, or replace the repository's other checks.
