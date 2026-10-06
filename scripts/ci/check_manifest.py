#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Check a Lake manifest, treated as untrusted data, against the repository's own pins.

The manifest produced by `lake update` is the only file of a Lean bump that comes from a job which
executed upstream code. This script decides whether it is acceptable to put in a pull request.

Always checked (no network):

* the manifest only has keys of a Lake manifest, `packagesDir` is `.lake/packages`, `lakeDir` is
  `.lake`, `version` (when present) looks like `1.2.0`, `fixedToolchain` (when present) is a boolean,
  and its `name` is the package name declared by `lakefile.lean`;
* every package only has keys of a Lake package (`inputRev` and `subDir` may be absent) and is a Git
  dependency;
* every package name is one of the 14 known packages (`ALLOWED_PACKAGES`, taken from the manifest
  of the 6 October 2026), and its URL is exactly the GitHub repository recorded for that name:
  no other package, no other repository, whatever the organisation;
* every `rev` is exactly 40 lowercase hexadecimal digits;
* `subDir`, `configFile`, `manifestFile` and `scope` are plain relative paths (no `..`, no
  absolute path, only `[A-Za-z0-9._/-]`), `configFile` is `lakefile.lean` or `lakefile.toml`,
  `manifestFile` is `lake-manifest.json`, and `inputRev` is a plain name that does not start with
  `refs/` and has no `..`;
* `lean-toolchain` and the `@ "vX.Y.Z"` requirements of `lakefile.lean` name the same release;
* the packages that are not `inherited` are exactly the `require`s of `lakefile.lean`, with the
  same URL and the same requested revision (`inputRev`).

With `--check-tags` (network, off by default): the `rev` of each direct dependency is the commit of
the upstream tag it was resolved from. This cannot detect a tag that upstream moved *before* the
bump; it detects a manifest altered after resolution.

With `--check-upstream` (network, off by default; implies `--check-tags`): for each direct
dependency whose `rev` passed the tag check, the `lake-manifest.json` that upstream committed at
that `rev` is fetched, and every inherited package of the manifest must appear in one of them with
the same name, URL and `rev`. A package that no verified direct dependency lists is refused.
Not covered: a package missing from the manifest, and anything the upstream manifests themselves
get wrong.

The standard library only: it runs without any installation step.

Usage (from the repository root):

    python3 scripts/ci/check_manifest.py
    python3 scripts/ci/check_manifest.py --manifest /path/to/untrusted/lake-manifest.json
    python3 scripts/ci/check_manifest.py --check-tags --check-upstream

Exit status: 0 when every check passes, 1 when a check fails, 2 on a usage error.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import urllib.error
import urllib.request
from collections.abc import Callable
from pathlib import Path
from urllib.parse import urlsplit

# The only packages that may appear in the manifest, with the only repository each may come from
# (GitHub, HTTPS). A new transitive dependency makes the check fail until a human adds it here.
ALLOWED_PACKAGES = {
    "mathlib": "leanprover-community/mathlib4",
    "cslib": "leanprover/cslib",
    "verso": "leanprover/verso",
    "plausible": "leanprover-community/plausible",
    "LeanSearchClient": "leanprover-community/LeanSearchClient",
    "importGraph": "leanprover-community/import-graph",
    "proofwidgets": "leanprover-community/ProofWidgets4",
    "aesop": "leanprover-community/aesop",
    "Qq": "leanprover-community/quote4",
    "batteries": "leanprover-community/batteries",
    "Cli": "leanprover/lean4-cli",
    "illuminate": "leanprover/illuminate",
    "MD4Lean": "acmepjz/md4lean",
    "subverso": "leanprover/subverso",
}
ALLOWED_REPOSITORIES = frozenset(ALLOWED_PACKAGES.values())
ALLOWED_HOST = "github.com"
RAW_HOST = "raw.githubusercontent.com"
PACKAGES_DIR = ".lake/packages"
CONFIG_FILES = frozenset({"lakefile.lean", "lakefile.toml"})
MANIFEST_FILE = "lake-manifest.json"
LAKE_DIR = ".lake"
# A manifest is a few kilobytes; refuse anything absurd before parsing untrusted JSON.
MAX_MANIFEST_BYTES = 1 << 20

TOP_LEVEL_KEYS = frozenset({"version", "packagesDir", "packages", "name", "lakeDir", "fixedToolchain"})
PACKAGE_KEYS = frozenset(
    {"configFile", "inherited", "inputRev", "manifestFile", "name", "rev", "scope", "subDir", "type", "url"}
)

REV_RE = re.compile(r"[0-9a-f]{40}")
MANIFEST_VERSION_RE = re.compile(r"[0-9]+\.[0-9]+\.[0-9]+")
NAME_RE = re.compile(r"[A-Za-z0-9._-]+")
SEGMENT_RE = re.compile(r"[A-Za-z0-9][A-Za-z0-9._-]*")
TAG_RE = re.compile(r"[A-Za-z0-9][A-Za-z0-9._-]*")
PATH_RE = re.compile(r"[A-Za-z0-9._/-]+")
INPUT_REV_RE = re.compile(r"[A-Za-z0-9][A-Za-z0-9._/-]*")
TOOLCHAIN_RE = re.compile(r"leanprover/lean4:(v[0-9]+\.[0-9]+\.[0-9]+(?:-rc[0-9]+)?)")
REQUIRE_RE = re.compile(r'^require\s+(\S+)\s+from\s+git\s+"([^"]+)"(?:\s+@\s+"([^"]+)")?', re.M)
REQUIRE_ANY_RE = re.compile(r"^require\b", re.M)
PACKAGE_DECL_RE = re.compile(r"^package\s+(\S+)", re.M)

# Direct dependencies that `scripts/bump-lean.sh` keeps on the toolchain release.
TOOLCHAIN_PINNED = ("mathlib", "cslib", "verso")

# (url, tag) -> `git ls-remote` output lines, "<sha>\t<ref>".
LsRemote = Callable[[str, str], list[str]]
# URL -> response body.
Fetch = Callable[[str], bytes]


def clean(text: str) -> str:
    """`text` with every non-printable character (newlines included) replaced by `?`.

    The messages are printed as GitHub workflow commands (`::error::…`); a newline taken from the
    untrusted manifest would let it start a command of its own (`::notice::…`, `::add-mask::…`).
    """
    return "".join(c if c.isprintable() else "?" for c in text)


def check_url(label: str, url: object) -> list[str]:
    """Errors for a package URL that is not an HTTPS GitHub URL of an allowed repository."""
    if not isinstance(url, str):
        return [f"{label}: `url` is not a string"]
    try:
        parts = urlsplit(url)
        port = parts.port
    except ValueError:
        return [f"{label}: `url` is not a valid URL: {url!r}"]
    segments = parts.path.split("/")
    problems: list[str] = []
    if parts.scheme != "https":
        problems.append("the scheme is not https")
    if parts.hostname != ALLOWED_HOST or parts.netloc != ALLOWED_HOST or port is not None:
        problems.append(f"the host is not exactly {ALLOWED_HOST}")
    # `urlsplit` reports an empty query or fragment ("…repo#", "…repo?") as absent: look at the text.
    if parts.query or parts.fragment or "?" in url or "#" in url:
        problems.append("it has a query or a fragment")
    if len(segments) != 3 or segments[0] != "":
        problems.append("the path is not /<owner>/<repository>")
    else:
        owner, repo = segments[1], segments[2]
        if not SEGMENT_RE.fullmatch(repo):
            problems.append(f"the repository name {repo!r} is not a plain name")
        elif f"{owner}/{repo}" not in ALLOWED_REPOSITORIES:
            problems.append(f"the repository {owner}/{repo} is not in the allow-list")
    if problems:
        return [f"{label}: url {url!r} rejected: " + "; ".join(problems)]
    return []


def check_relative_path(label: str, key: str, value: object, optional: bool) -> list[str]:
    """Errors for a field that must be a plain relative path (`..`, absolute paths refused)."""
    if value is None and optional:
        return []
    if not isinstance(value, str):
        return [f"{label}: `{key}` is not a string"]
    if key == "scope" and value == "":
        return []
    if (
        not PATH_RE.fullmatch(value)
        or value.startswith(("/", "-"))
        or ".." in value
    ):
        return [f"{label}: `{key}` must be a plain relative path, got {value!r}"]
    return []


def check_package(index: int, package: object, seen: set[str]) -> list[str]:
    """Errors for one entry of `packages`."""
    label = f"packages[{index}]"
    if not isinstance(package, dict):
        return [f"{label} is not an object"]
    errors: list[str] = []
    name = package.get("name")
    if not isinstance(name, str) or not NAME_RE.fullmatch(name):
        errors.append(f"{label}: `name` must match [A-Za-z0-9._-]+, got {name!r}")
    else:
        label = name
        if name in seen:
            errors.append(f"{label}: duplicate package")
        seen.add(name)
        if name not in ALLOWED_PACKAGES:
            errors.append(f"{label}: not one of the known packages (an extra package?)")
    unknown = sorted(str(key) for key in package if key not in PACKAGE_KEYS)
    if unknown:
        errors.append(f"{label}: unknown key(s) {unknown!r}")
    if package.get("type") != "git":
        errors.append(f"{label}: `type` must be 'git', got {package.get('type')!r}")
    if not isinstance(package.get("inherited"), bool):
        errors.append(f"{label}: `inherited` must be a boolean, got {package.get('inherited')!r}")
    rev = package.get("rev")
    if not isinstance(rev, str) or not REV_RE.fullmatch(rev):
        errors.append(f"{label}: `rev` must be 40 lowercase hexadecimal digits, got {rev!r}")
    errors.extend(check_url(label, package.get("url")))
    expected = ALLOWED_PACKAGES.get(name) if isinstance(name, str) else None
    url = package.get("url")
    if expected is not None and isinstance(url, str) and url != f"https://{ALLOWED_HOST}/{expected}":
        errors.append(f"{label}: url {url!r} is not the repository of this package ({expected})")
    input_rev = package.get("inputRev")
    if input_rev is not None and (
        not isinstance(input_rev, str)
        or not INPUT_REV_RE.fullmatch(input_rev)
        or input_rev.startswith("refs/")
        or ".." in input_rev
    ):
        errors.append(f"{label}: `inputRev` must be a plain name that does not start with refs/, got {input_rev!r}")
    errors.extend(check_relative_path(label, "subDir", package.get("subDir"), optional=True))
    errors.extend(check_relative_path(label, "configFile", package.get("configFile"), optional=False))
    errors.extend(check_relative_path(label, "manifestFile", package.get("manifestFile"), optional=False))
    errors.extend(check_relative_path(label, "scope", package.get("scope"), optional=False))
    config_file = package.get("configFile")
    if isinstance(config_file, str) and config_file not in CONFIG_FILES:
        errors.append(f"{label}: `configFile` must be one of {sorted(CONFIG_FILES)}, got {clean(config_file)!r}")
    manifest_file = package.get("manifestFile")
    if isinstance(manifest_file, str) and manifest_file != MANIFEST_FILE:
        errors.append(f"{label}: `manifestFile` must be {MANIFEST_FILE!r}, got {clean(manifest_file)!r}")
    return errors


def check_manifest(manifest: object) -> list[str]:
    """Structural checks of the manifest alone (no lakefile, no toolchain, no network)."""
    if not isinstance(manifest, dict):
        return ["the manifest is not a JSON object"]
    errors: list[str] = []
    unknown = sorted(str(key) for key in manifest if key not in TOP_LEVEL_KEYS)
    if unknown:
        errors.append(f"unknown top-level key(s) {unknown!r}")
    if manifest.get("packagesDir") != PACKAGES_DIR:
        errors.append(f"`packagesDir` must be {PACKAGES_DIR!r}, got {manifest.get('packagesDir')!r}")
    if manifest.get("lakeDir") != LAKE_DIR:
        errors.append(f"`lakeDir` must be {LAKE_DIR!r}, got {manifest.get('lakeDir')!r}")
    name = manifest.get("name")
    if not isinstance(name, str) or not NAME_RE.fullmatch(name):
        errors.append(f"`name` must match [A-Za-z0-9._-]+, got {name!r}")
    if "version" in manifest:
        version = manifest["version"]
        if not isinstance(version, str) or not MANIFEST_VERSION_RE.fullmatch(version):
            errors.append(f"`version` must look like 1.2.0, got {clean(str(version))!r}")
    if "fixedToolchain" in manifest and not isinstance(manifest["fixedToolchain"], bool):
        errors.append(f"`fixedToolchain` must be a boolean, got {clean(str(manifest['fixedToolchain']))!r}")
    packages = manifest.get("packages")
    if not isinstance(packages, list) or not packages:
        errors.append("`packages` is missing, empty or not a list")
        return errors
    seen: set[str] = set()
    for index, package in enumerate(packages):
        errors.extend(check_package(index, package, seen))
    return errors


def parse_toolchain(text: str) -> str | None:
    """The release named by `lean-toolchain` (e.g. `v4.34.0`), or None when it is not recognised."""
    match = TOOLCHAIN_RE.fullmatch(text.strip())
    return match.group(1) if match else None


def parse_requires(lakefile: str) -> tuple[list[tuple[str, str, str | None]], int]:
    """The `require <name> from git "<url>" @ "<rev>"` declarations, and the number of `require`s."""
    return REQUIRE_RE.findall(lakefile), len(REQUIRE_ANY_RE.findall(lakefile))


def check_consistency(manifest: dict, lakefile: str, toolchain: str) -> list[str]:
    """Cross-checks between the manifest, `lakefile.lean` and `lean-toolchain`."""
    errors: list[str] = []
    release = parse_toolchain(toolchain)
    if release is None:
        errors.append(f"lean-toolchain: unrecognised content {toolchain.strip()!r}")
    declared = PACKAGE_DECL_RE.findall(lakefile)
    if len(declared) != 1:
        errors.append(f"lakefile.lean: expected one `package` declaration, found {len(declared)}")
    elif manifest.get("name") != declared[0]:
        errors.append(f"manifest `name` {manifest.get('name')!r} != lakefile package {declared[0]!r}")
    requires, total = parse_requires(lakefile)
    if len(requires) != total:
        errors.append(
            f"lakefile.lean: {total - len(requires)} `require` declaration(s) are not of the form "
            '`require <name> from git "<url>" @ "<tag>"`'
        )
    by_name = {name: (url, rev) for name, url, rev in requires}
    for name in TOOLCHAIN_PINNED:
        if name not in by_name:
            errors.append(f"lakefile.lean: missing `require {name}`")
        elif release is not None and by_name[name][1] != release:
            errors.append(
                f"lakefile.lean: `require {name}` is pinned to {by_name[name][1]!r} "
                f"but lean-toolchain is {release!r}"
            )
    packages = {
        p["name"]: p
        for p in manifest.get("packages", [])
        if isinstance(p, dict) and isinstance(p.get("name"), str)
    }
    for name, url, rev in requires:
        label = f"lakefile.lean `require {name}`"
        errors.extend(check_url(label, url))
        if name not in ALLOWED_PACKAGES:
            errors.append(f"{label}: not one of the known packages")
        elif url != f"https://{ALLOWED_HOST}/{ALLOWED_PACKAGES[name]}":
            errors.append(f"{label}: url {url!r} is not the repository of this package")
        package = packages.get(name)
        if package is None:
            errors.append(f"manifest: no package named {name!r} for the lakefile requirement")
            continue
        if package.get("url") != url:
            errors.append(f"{name}: manifest url {package.get('url')!r} != lakefile url {url!r}")
        if package.get("inputRev") != rev:
            errors.append(
                f"{name}: manifest inputRev {package.get('inputRev')!r} != lakefile tag {rev!r}"
            )
        if package.get("inherited") is not False:
            errors.append(f"{name}: a direct dependency must have `inherited: false`")
    direct = {name for name, p in packages.items() if p.get("inherited") is False}
    for name in sorted(direct - set(by_name)):
        errors.append(f"{name}: not inherited, but no `require` of lakefile.lean names it")
    return errors


def git_ls_remote_tag(url: str, tag: str) -> list[str]:
    """`git ls-remote --tags` for one tag, plain and peeled; the caller validated `url` and `tag`."""
    result = subprocess.run(
        ["git", "ls-remote", "--tags", url, f"refs/tags/{tag}", f"refs/tags/{tag}^{{}}"],
        check=True,
        text=True,
        capture_output=True,
        timeout=120,
        env={**os.environ, "GIT_TERMINAL_PROMPT": "0"},
    )
    return result.stdout.splitlines()


def verify_tags(manifest: dict, ls_remote: LsRemote) -> tuple[list[str], set[str]]:
    """Errors, and the names of the direct dependencies whose `rev` is the commit of their tag."""
    errors: list[str] = []
    verified: set[str] = set()
    for package in manifest.get("packages", []):
        if not isinstance(package, dict) or package.get("inherited") is not False:
            continue
        name, url, tag, rev = (package.get(k) for k in ("name", "url", "inputRev", "rev"))
        if check_url(str(name), url):
            errors.append(f"{name}: not querying a url that failed the allow-list check")
            continue
        if not isinstance(tag, str) or not TAG_RE.fullmatch(tag):
            errors.append(f"{name}: inputRev {tag!r} is not a plain tag name")
            continue
        try:
            lines = ls_remote(str(url), tag)
        except (OSError, subprocess.SubprocessError) as error:
            errors.append(f"{name}: could not query tag {tag!r} upstream: {error}")
            continue
        refs: dict[str, str] = {}
        for line in lines:
            sha, _, ref = line.partition("\t")
            refs[ref] = sha
        upstream = refs.get(f"refs/tags/{tag}^{{}}") or refs.get(f"refs/tags/{tag}")
        if upstream is None:
            errors.append(f"{name}: tag {tag!r} not found upstream")
        elif upstream != rev:
            errors.append(f"{name}: rev {rev} != upstream commit {upstream} of tag {tag!r}")
        else:
            verified.add(str(name))
    return errors, verified


def check_tags(manifest: dict, ls_remote: LsRemote = git_ls_remote_tag) -> list[str]:
    """Compare the `rev` of each direct dependency with the upstream commit of its tag.

    An annotated tag is compared through its peeled commit (`^{}`); a lightweight tag, which has no
    peeled line, through the ref itself. Both forms occur upstream (Mathlib, CSLib and Verso use
    lightweight tags at the time of writing).
    """
    return verify_tags(manifest, ls_remote)[0]


def fetch_upstream_manifest(url: str) -> bytes:
    """GET a `lake-manifest.json` from raw.githubusercontent.com (https only, size bounded)."""
    parts = urlsplit(url)
    if parts.scheme != "https" or parts.netloc != RAW_HOST:
        raise ValueError(f"refusing to fetch {url!r}")
    request = urllib.request.Request(url, headers={"User-Agent": "k7pl-check-manifest"})
    with urllib.request.urlopen(request, timeout=60) as response:  # noqa: S310 - https, fixed host
        body = response.read(MAX_MANIFEST_BYTES + 1)
    if len(body) > MAX_MANIFEST_BYTES:
        raise ValueError(f"{url} is larger than {MAX_MANIFEST_BYTES} bytes")
    return body


def upstream_manifest_url(url: str, rev: str) -> str:
    """Where upstream committed `lake-manifest.json` at `rev`; both come from the checked manifest."""
    owner, repo = urlsplit(url).path.strip("/").split("/")
    return f"https://{RAW_HOST}/{owner}/{repo}/{rev}/lake-manifest.json"


def check_upstream(manifest: dict, verified: set[str], fetch: Fetch = fetch_upstream_manifest) -> list[str]:
    """Compare the inherited packages with the manifests of the verified direct dependencies.

    `verified` holds the names of the direct dependencies whose `rev` was matched to their upstream
    tag: only those manifests are trusted. Every inherited package must be listed, with the same
    name, URL and `rev`, by at least one of them; a package nobody lists is refused.
    """
    errors: list[str] = []
    listed: list[tuple[str, str, str]] = []
    packages = [p for p in manifest.get("packages", []) if isinstance(p, dict)]
    for package in packages:
        name, url, rev = package.get("name"), package.get("url"), package.get("rev")
        if package.get("inherited") is not False or name not in verified:
            continue
        if check_url(str(name), url) or not isinstance(rev, str) or not REV_RE.fullmatch(rev):
            errors.append(f"{name}: not fetching the upstream manifest of an invalid url or rev")
            continue
        try:
            document = json.loads(fetch(upstream_manifest_url(str(url), rev)))
        except (OSError, ValueError, RecursionError, urllib.error.URLError) as error:
            errors.append(f"{name}: could not read the upstream lake-manifest.json at {rev}: {error}")
            continue
        entries = document.get("packages") if isinstance(document, dict) else None
        if not isinstance(entries, list):
            errors.append(f"{name}: the upstream lake-manifest.json at {rev} has no package list")
            continue
        for entry in entries:
            if isinstance(entry, dict) and all(isinstance(entry.get(k), str) for k in ("name", "url", "rev")):
                listed.append((entry["name"], entry["url"], entry["rev"]))
    for package in packages:
        if package.get("inherited") is not True:
            continue
        name, url, rev = package.get("name"), package.get("url"), package.get("rev")
        same_name = [(u, r) for n, u, r in listed if n == name]
        if not same_name:
            errors.append(f"{name}: not listed by the manifest of any verified direct dependency")
        elif (url, rev) not in same_name:
            seen = ", ".join(dict.fromkeys(f"{u} @ {r}" for u, r in same_name))
            errors.append(f"{name}: url {url!r} / rev {rev!r} differ from upstream ({seen})")
    return errors


def load_manifest(path: Path) -> object:
    """Parse the manifest; refuse oversized, unreadable or non-JSON input with a clear message."""
    if path.is_symlink() or not path.is_file():
        raise ValueError(f"{path} is not a regular file")
    if path.stat().st_size > MAX_MANIFEST_BYTES:
        raise ValueError(f"{path} is larger than {MAX_MANIFEST_BYTES} bytes")
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError, RecursionError) as error:
        raise ValueError(f"{path} is not valid JSON: {error}") from error


def run(
    root: Path,
    manifest_path: Path | None,
    tags: bool,
    ls_remote: LsRemote,
    upstream: bool = False,
    fetch: Fetch = fetch_upstream_manifest,
) -> list[str]:
    """All errors for the repository rooted at `root`, with an optional manifest override."""
    manifest_path = manifest_path or root / "lake-manifest.json"
    try:
        manifest = load_manifest(manifest_path)
        lakefile = (root / "lakefile.lean").read_text(encoding="utf-8")
        toolchain = (root / "lean-toolchain").read_text(encoding="utf-8")
    except (OSError, ValueError) as error:
        return [str(error)]
    errors = check_manifest(manifest)
    if not isinstance(manifest, dict) or not isinstance(manifest.get("packages"), list):
        return errors  # the structure is too broken for the cross-checks to mean anything
    errors.extend(check_consistency(manifest, lakefile, toolchain))
    if tags or upstream:
        tag_errors, verified = verify_tags(manifest, ls_remote)
        errors.extend(tag_errors)
        if upstream:
            errors.extend(check_upstream(manifest, verified, fetch))
    return errors


def main(
    argv: list[str] | None = None,
    ls_remote: LsRemote = git_ls_remote_tag,
    fetch: Fetch = fetch_upstream_manifest,
) -> int:
    """Command line entry point; `ls_remote` and `fetch` are replaced by doubles in the tests."""
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--root", type=Path, default=Path("."), help="repository root (default: .)")
    parser.add_argument(
        "--manifest",
        type=Path,
        help="manifest to check instead of <root>/lake-manifest.json (e.g. an untrusted artifact)",
    )
    parser.add_argument(
        "--check-tags",
        action="store_true",
        help="also compare each direct dependency's rev with its upstream tag (network; off by default)",
    )
    parser.add_argument(
        "--check-upstream",
        action="store_true",
        help="also compare the inherited packages with the manifests of the verified direct "
        "dependencies (network; off by default; implies --check-tags)",
    )
    args = parser.parse_args(argv)
    errors = run(
        args.root, args.manifest, args.check_tags, ls_remote, upstream=args.check_upstream, fetch=fetch
    )
    annotate = os.environ.get("GITHUB_ACTIONS") == "true"
    for error in errors:
        message = clean(error)
        print(f"::error::{message}" if annotate else f"error: {message}", file=sys.stderr)
    if errors:
        print(f"{len(errors)} problem(s) found: the manifest must not be used.", file=sys.stderr)
        return 1
    extra = " (including upstream tags and manifests)" if args.check_upstream else (
        " (including upstream tags)" if args.check_tags else ""
    )
    print(f"lake-manifest.json: all checks passed{extra}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
