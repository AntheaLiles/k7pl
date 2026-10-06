# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the Lake manifest check.

Standard library only, no network: `git ls-remote` is replaced by an injected function that fails
the test if it is called when the property under test does not involve the network. Every
mutation test also asserts that the unmodified inputs pass, so a helper that breaks the inputs
cannot make a test succeed for the wrong reason.
"""

import contextlib
import copy
import io
import json
import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

import check_manifest
from check_manifest import check_consistency, check_manifest as check_structure, check_tags, run

ROOT = Path(__file__).resolve().parents[2]
REAL_MANIFEST = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
REAL_LAKEFILE = (ROOT / "lakefile.lean").read_text(encoding="utf-8")
REAL_TOOLCHAIN = (ROOT / "lean-toolchain").read_text(encoding="utf-8")
SCRIPT = ROOT / "scripts" / "ci" / "check_manifest.py"
DIRECT = ("mathlib", "cslib", "verso")


def no_network(url, tag):
    raise AssertionError(f"unexpected network query for {url} {tag}")


def manifest_with(**changes_on_first):
    """A copy of the real manifest whose first package (mathlib) has the given fields replaced."""
    manifest = copy.deepcopy(REAL_MANIFEST)
    manifest["packages"][0].update(changes_on_first)
    return manifest


class RealRepositoryTests(unittest.TestCase):
    def test_real_manifest_passes_without_network(self):
        self.assertEqual(run(ROOT, None, False, no_network), [])

    def test_real_manifest_has_the_expected_shape(self):
        # Guards the premise of the other tests: a real, non-trivial manifest.
        names = [p["name"] for p in REAL_MANIFEST["packages"]]
        self.assertTrue({"mathlib", "cslib", "verso"} <= set(names))
        self.assertGreaterEqual(len(names), 10)


class RevTests(unittest.TestCase):
    def test_unmodified_manifest_is_accepted(self):
        self.assertEqual(check_structure(REAL_MANIFEST), [])

    def test_short_rev_is_rejected(self):
        errors = check_structure(manifest_with(rev=REAL_MANIFEST["packages"][0]["rev"][:7]))
        self.assertTrue(any("40 lowercase hexadecimal" in e for e in errors), errors)

    def test_branch_name_instead_of_rev_is_rejected(self):
        errors = check_structure(manifest_with(rev="main"))
        self.assertTrue(any("40 lowercase hexadecimal" in e for e in errors), errors)

    def test_uppercase_rev_is_rejected(self):
        errors = check_structure(manifest_with(rev="A" * 40))
        self.assertTrue(any("40 lowercase hexadecimal" in e for e in errors), errors)

    def test_overlong_rev_is_rejected(self):
        errors = check_structure(manifest_with(rev="a" * 41))
        self.assertTrue(any("40 lowercase hexadecimal" in e for e in errors), errors)

    def test_rev_with_trailing_newline_is_rejected(self):
        # `re.match("$")` would accept a trailing newline; the check must not.
        errors = check_structure(manifest_with(rev="a" * 40 + "\n"))
        self.assertTrue(any("40 lowercase hexadecimal" in e for e in errors), errors)

    def test_missing_or_non_string_rev_is_rejected(self):
        for value in (None, 12345, ["a" * 40]):
            with self.subTest(value=value):
                errors = check_structure(manifest_with(rev=value))
                self.assertTrue(any("40 lowercase hexadecimal" in e for e in errors), errors)


class UrlTests(unittest.TestCase):
    def assert_url_rejected(self, url):
        errors = check_structure(manifest_with(url=url))
        self.assertTrue(any("rejected" in e or "`url`" in e for e in errors), (url, errors))

    def test_owner_outside_the_list_is_rejected(self):
        self.assert_url_rejected("https://github.com/evil/mathlib4")

    def test_lookalike_owner_is_rejected(self):
        self.assert_url_rejected("https://github.com/leanprover-community-evil/mathlib4")
        self.assert_url_rejected("https://github.com/Leanprover/mathlib4")

    def test_other_host_is_rejected(self):
        self.assert_url_rejected("https://gitlab.com/leanprover-community/mathlib4")
        self.assert_url_rejected("https://github.com.evil.example/leanprover-community/mathlib4")

    def test_userinfo_and_port_are_rejected(self):
        self.assert_url_rejected("https://github.com@evil.example/leanprover-community/mathlib4")
        self.assert_url_rejected("https://user:pw@github.com/leanprover-community/mathlib4")
        self.assert_url_rejected("https://github.com:8443/leanprover-community/mathlib4")

    def test_plain_http_and_other_schemes_are_rejected(self):
        self.assert_url_rejected("http://github.com/leanprover-community/mathlib4")
        self.assert_url_rejected("git@github.com:leanprover-community/mathlib4")
        self.assert_url_rejected("ssh://git@github.com/leanprover-community/mathlib4")
        self.assert_url_rejected("file:///tmp/mathlib4")

    def test_extra_path_query_and_git_suffix_are_rejected(self):
        self.assert_url_rejected("https://github.com/leanprover-community/mathlib4/tree/main")
        self.assert_url_rejected("https://github.com/leanprover-community/mathlib4?x=1")
        self.assert_url_rejected("https://github.com/leanprover-community/mathlib4.git")
        self.assert_url_rejected("https://github.com/leanprover-community")

    def test_non_string_url_is_rejected(self):
        self.assert_url_rejected(None)
        self.assert_url_rejected(["https://github.com/leanprover/verso"])

    def test_url_with_a_fragment_is_rejected(self):
        for suffix in ("#x", "#", "?#"):
            with self.subTest(suffix=suffix):
                errors = check_structure(manifest_with(url="https://github.com/leanprover-community/mathlib4" + suffix))
                self.assertTrue(any("query or a fragment" in e for e in errors), errors)

    def test_repository_name_must_be_a_plain_name(self):
        for repo in ("", ".", "..", "-x", "a b", "mathlib4.git", "mäthlib", "mathlib4%20"):
            with self.subTest(repo=repo):
                errors = check_structure(manifest_with(url="https://github.com/leanprover-community/" + repo))
                self.assertTrue(errors, repo)

    def test_each_known_package_is_accepted_with_its_own_repository(self):
        # Positive control for the allow-list: the real names and repositories pass...
        for name, repository in check_manifest.ALLOWED_PACKAGES.items():
            with self.subTest(name=name):
                package = {**REAL_MANIFEST["packages"][0], "name": name, "url": f"https://github.com/{repository}"}
                manifest = {**REAL_MANIFEST, "packages": [package]}
                self.assertEqual(check_structure(manifest), [])

    def test_the_allow_list_is_exactly_what_the_real_manifest_holds(self):
        real = {p["name"]: p["url"].removeprefix("https://github.com/") for p in REAL_MANIFEST["packages"]}
        self.assertEqual(check_manifest.ALLOWED_PACKAGES, real)


class StructureTests(unittest.TestCase):
    def test_non_git_package_type_is_rejected(self):
        errors = check_structure(manifest_with(type="path"))
        self.assertTrue(any("must be 'git'" in e for e in errors), errors)

    def test_duplicate_package_is_rejected(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"].append(copy.deepcopy(manifest["packages"][0]))
        self.assertTrue(any("duplicate" in e for e in check_structure(manifest)))

    def test_packages_directory_must_not_move(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packagesDir"] = "/tmp/elsewhere"
        self.assertTrue(any("packagesDir" in e for e in check_structure(manifest)))

    def test_empty_or_missing_package_list_is_rejected(self):
        for packages in ([], None, "x"):
            with self.subTest(packages=packages):
                manifest = copy.deepcopy(REAL_MANIFEST)
                manifest["packages"] = packages
                self.assertTrue(check_structure(manifest))
        manifest = copy.deepcopy(REAL_MANIFEST)
        del manifest["packages"]
        self.assertTrue(check_structure(manifest))

    def test_non_object_manifest_is_rejected(self):
        for value in ([], "text", 3, None):
            with self.subTest(value=value):
                self.assertTrue(check_structure(value))


class ConsistencyTests(unittest.TestCase):
    def test_real_files_are_consistent(self):
        self.assertEqual(check_consistency(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN), [])

    def test_toolchain_older_than_the_lakefile_tags_is_rejected(self):
        errors = check_consistency(REAL_MANIFEST, REAL_LAKEFILE, "leanprover/lean4:v4.0.1\n")
        self.assertTrue(any("lean-toolchain is 'v4.0.1'" in e for e in errors), errors)
        self.assertEqual(sum("lean-toolchain is" in e for e in errors), 3, errors)

    def test_one_requirement_on_another_tag_is_rejected(self):
        lakefile = REAL_LAKEFILE.replace(
            '"https://github.com/leanprover/verso" @ "v4.34.0"',
            '"https://github.com/leanprover/verso" @ "v4.33.0"',
        )
        self.assertNotEqual(lakefile, REAL_LAKEFILE)
        errors = check_consistency(REAL_MANIFEST, lakefile, REAL_TOOLCHAIN)
        self.assertTrue(any("`require verso` is pinned to 'v4.33.0'" in e for e in errors), errors)

    def test_unrecognised_toolchain_is_rejected(self):
        for text in ("", "leanprover/lean4:nightly\n", "other/toolchain:v4.34.0\n", "v4.34.0\n"):
            with self.subTest(text=text):
                errors = check_consistency(REAL_MANIFEST, REAL_LAKEFILE, text)
                self.assertTrue(any("unrecognised content" in e for e in errors), errors)

    def test_manifest_input_rev_differing_from_the_lakefile_is_rejected(self):
        manifest = manifest_with(inputRev="v4.33.0")
        errors = check_consistency(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)
        self.assertTrue(any("inputRev" in e for e in errors), errors)

    def test_manifest_url_differing_from_the_lakefile_is_rejected(self):
        manifest = manifest_with(url="https://github.com/leanprover/mathlib4")
        errors = check_consistency(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)
        self.assertTrue(any("manifest url" in e for e in errors), errors)

    def test_missing_direct_dependency_is_rejected(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"] = [p for p in manifest["packages"] if p["name"] != "cslib"]
        errors = check_consistency(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)
        self.assertTrue(any("no package named 'cslib'" in e for e in errors), errors)

    def test_direct_dependency_marked_inherited_is_rejected(self):
        errors = check_consistency(manifest_with(inherited=True), REAL_LAKEFILE, REAL_TOOLCHAIN)
        self.assertTrue(any("inherited: false" in e for e in errors), errors)

    def test_requirement_missing_from_the_lakefile_is_rejected(self):
        lakefile = REAL_LAKEFILE.replace("require cslib from git", "-- require cslib from git")
        errors = check_consistency(REAL_MANIFEST, lakefile, REAL_TOOLCHAIN)
        self.assertTrue(any("missing `require cslib`" in e for e in errors), errors)

    def test_non_git_requirement_is_rejected(self):
        lakefile = REAL_LAKEFILE + '\nrequire local from "../elsewhere"\n'
        errors = check_consistency(REAL_MANIFEST, lakefile, REAL_TOOLCHAIN)
        self.assertTrue(any("not of the form" in e for e in errors), errors)

    def test_requirement_with_a_url_outside_the_list_is_rejected(self):
        lakefile = REAL_LAKEFILE + '\nrequire extra from git "https://github.com/evil/extra" @ "v1"\n'
        errors = check_consistency(REAL_MANIFEST, lakefile, REAL_TOOLCHAIN)
        self.assertTrue(any("evil" in e and "rejected" in e for e in errors), errors)


class RunTests(unittest.TestCase):
    """End to end on a temporary copy of the three files, through `run` and `main`."""

    def make_root(self, manifest=None, lakefile=None, toolchain=None):
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        root = Path(tmp.name)
        (root / "lake-manifest.json").write_text(json.dumps(manifest or REAL_MANIFEST), encoding="utf-8")
        (root / "lakefile.lean").write_text(lakefile or REAL_LAKEFILE, encoding="utf-8")
        (root / "lean-toolchain").write_text(toolchain or REAL_TOOLCHAIN, encoding="utf-8")
        return root

    def run_main(self, *argv):
        stdout, stderr = io.StringIO(), io.StringIO()
        with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
            code = check_manifest.main(list(argv))
        return code, stdout.getvalue(), stderr.getvalue()

    def test_unmodified_copy_passes(self):
        root = self.make_root()
        self.assertEqual(run(root, None, False, no_network), [])
        code, out, _ = self.run_main("--root", str(root))
        self.assertEqual(code, 0)
        self.assertIn("all checks passed", out)

    def test_a_name_that_is_not_a_string_is_a_clean_rejection_not_a_crash(self):
        for name in (["mathlib"], {"a": 1}, 3, None):
            with self.subTest(name=name):
                manifest = manifest_with(name=name)
                self.assertTrue(check_structure(manifest))
                errors = check_consistency(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)  # must not raise
                self.assertTrue(errors)
                code, _, err = self.run_main("--root", str(self.make_root(manifest=manifest)))
                self.assertEqual(code, 1)
                self.assertNotIn("Traceback", err)

    def test_inconsistent_toolchain_fails_with_status_1(self):
        root = self.make_root(toolchain="leanprover/lean4:v4.0.1\n")
        code, _, err = self.run_main("--root", str(root))
        self.assertEqual(code, 1)
        self.assertIn("lean-toolchain is 'v4.0.1'", err)

    def test_short_rev_fails_with_status_1(self):
        root = self.make_root(manifest=manifest_with(rev="abc1234"))
        code, _, err = self.run_main("--root", str(root))
        self.assertEqual(code, 1)
        self.assertIn("40 lowercase hexadecimal", err)

    def test_url_outside_the_list_fails_with_status_1(self):
        root = self.make_root(manifest=manifest_with(url="https://github.com/evil/mathlib4"))
        code, _, err = self.run_main("--root", str(root))
        self.assertEqual(code, 1)
        self.assertIn("rejected", err)

    def test_manifest_option_checks_another_file_against_the_repository_pins(self):
        root = self.make_root()
        other = tempfile.TemporaryDirectory()
        self.addCleanup(other.cleanup)
        altered = Path(other.name) / "lake-manifest.json"
        altered.write_text(json.dumps(manifest_with(rev="abc1234")), encoding="utf-8")
        code, _, err = self.run_main("--root", str(root), "--manifest", str(altered))
        self.assertEqual(code, 1)
        self.assertIn("40 lowercase hexadecimal", err)
        # The file in the root was untouched and still passes.
        self.assertEqual(self.run_main("--root", str(root))[0], 0)

    def test_invalid_json_oversized_and_missing_files_fail(self):
        root = self.make_root()
        manifest = root / "lake-manifest.json"
        manifest.write_text("{not json", encoding="utf-8")
        code, _, err = self.run_main("--root", str(root))
        self.assertEqual(code, 1)
        self.assertIn("is not valid JSON", err)
        manifest.unlink()
        code, _, err = self.run_main("--root", str(root))
        self.assertEqual(code, 1)
        self.assertIn("is not a regular file", err)

    def test_a_valid_but_oversized_manifest_is_refused_for_its_size(self):
        # Valid JSON (padding inside a string), so that only the size ceiling can reject it.
        limit = check_manifest.MAX_MANIFEST_BYTES
        root = self.make_root()
        manifest = root / "lake-manifest.json"

        def with_padding(total):
            document = dict(REAL_MANIFEST)
            document["padding"] = ""
            base = len(json.dumps(document))
            document["padding"] = "x" * (total - base)
            text = json.dumps(document)
            assert len(text) == total
            return text

        manifest.write_text(with_padding(limit + 1), encoding="utf-8")
        json.loads(manifest.read_text(encoding="utf-8"))  # it really is valid JSON
        code, _, err = self.run_main("--root", str(root))
        self.assertEqual(code, 1)
        self.assertIn("is larger than", err)
        self.assertNotIn("is not valid JSON", err)
        # Positive control: the same document one byte under the ceiling gets past the size check
        # (it is then refused for its unknown key, which proves it was read and parsed).
        manifest.write_text(with_padding(limit), encoding="utf-8")
        code, _, err = self.run_main("--root", str(root))
        self.assertEqual(code, 1)
        self.assertNotIn("is larger than", err)
        self.assertIn("unknown top-level key", err)

    def test_deeply_nested_json_fails_cleanly(self):
        root = self.make_root()
        (root / "lake-manifest.json").write_text("[" * 100_000 + "]" * 100_000, encoding="utf-8")
        self.assertEqual(self.run_main("--root", str(root))[0], 1)

    def test_symlinked_manifest_is_refused(self):
        root = self.make_root()
        target = root / "elsewhere.json"
        target.write_text(json.dumps(REAL_MANIFEST), encoding="utf-8")
        link = root / "link.json"
        try:
            link.symlink_to(target)
        except OSError:
            self.skipTest("symbolic links are not available")
        code, _, err = self.run_main("--root", str(root), "--manifest", str(link))
        self.assertEqual(code, 1)
        self.assertIn("not a regular file", err)


class TagTests(unittest.TestCase):
    DIRECT = ("mathlib", "cslib", "verso")

    @staticmethod
    def upstream(manifest, peeled=()):
        """An `ls-remote` double answering from the manifest itself (lightweight tags), or with a
        peeled line for the names in `peeled` (annotated tags: the plain line is a tag object)."""
        by_url = {p["url"]: p for p in manifest["packages"]}

        def ls_remote(url, tag):
            package = by_url[url]
            if package["name"] in peeled:
                return [f"{'f' * 40}\trefs/tags/{tag}", f"{package['rev']}\trefs/tags/{tag}^{{}}"]
            return [f"{package['rev']}\trefs/tags/{tag}"]

        return ls_remote

    def test_matching_lightweight_and_annotated_tags_pass(self):
        self.assertEqual(check_tags(REAL_MANIFEST, self.upstream(REAL_MANIFEST)), [])
        peeled = self.upstream(REAL_MANIFEST, peeled=self.DIRECT)
        self.assertEqual(check_tags(REAL_MANIFEST, peeled), [])

    def test_rev_differing_from_the_upstream_tag_is_rejected(self):
        upstream = self.upstream(REAL_MANIFEST)
        altered = manifest_with(rev="0" * 40)
        errors = check_tags(altered, upstream)
        self.assertTrue(any("mathlib" in e and "!= upstream commit" in e for e in errors), errors)

    def test_annotated_tag_is_compared_through_its_peeled_commit(self):
        # With a peeled line present, comparing against the plain (tag object) line would fail.
        upstream = self.upstream(REAL_MANIFEST, peeled=self.DIRECT)
        self.assertEqual(check_tags(REAL_MANIFEST, upstream), [])
        errors = check_tags(manifest_with(rev="f" * 40), upstream)
        self.assertTrue(any("mathlib" in e for e in errors), errors)

    def test_missing_tag_and_failing_query_are_rejected(self):
        errors = check_tags(REAL_MANIFEST, lambda url, tag: [])
        self.assertEqual(sum("not found upstream" in e for e in errors), 3, errors)

        def failing(url, tag):
            raise OSError("no network")

        errors = check_tags(REAL_MANIFEST, failing)
        self.assertEqual(sum("could not query" in e for e in errors), 3, errors)

    def test_only_direct_dependencies_are_queried(self):
        queried = []

        def recording(url, tag):
            queried.append(url)
            return self.upstream(REAL_MANIFEST)(url, tag)

        check_tags(REAL_MANIFEST, recording)
        direct_urls = {p["url"] for p in REAL_MANIFEST["packages"] if p["inherited"] is False}
        self.assertEqual(set(queried), direct_urls)
        self.assertEqual(len(queried), 3)

    def queried_by(self, manifest):
        """Run `check_tags` with a recording double; return (errors, [(url, tag), ...])."""
        queried = []
        upstream = self.upstream(REAL_MANIFEST)

        def recording(url, tag):
            queried.append((url, tag))
            return upstream(url, tag) if url in {p["url"] for p in REAL_MANIFEST["packages"]} else []

        return check_tags(manifest, recording), queried

    def test_url_outside_the_list_is_never_queried(self):
        evil = "https://github.com/evil/mathlib4"
        errors, queried = self.queried_by(manifest_with(url=evil))
        self.assertTrue(any("allow-list" in e for e in errors), errors)
        self.assertNotIn(evil, [url for url, _ in queried])
        self.assertEqual(len(queried), 2)  # the two other direct dependencies

    def test_tag_names_that_could_act_as_options_are_never_queried(self):
        for tag in ("--upload-pack=evil", "-x", "v1 v2", "", "../x"):
            with self.subTest(tag=tag):
                errors, queried = self.queried_by(manifest_with(inputRev=tag))
                self.assertTrue(any("not a plain tag name" in e for e in errors), errors)
                self.assertNotIn(tag, [queried_tag for _, queried_tag in queried])
                self.assertEqual(len(queried), 2)

    def test_default_query_uses_an_argument_list_with_both_ref_forms(self):
        completed = mock.Mock(stdout=f"{'a' * 40}\trefs/tags/v1\n")
        with mock.patch.object(check_manifest.subprocess, "run", return_value=completed) as run_mock:
            lines = check_manifest.git_ls_remote_tag("https://github.com/leanprover/verso", "v1")
        command = run_mock.call_args.args[0]
        self.assertIsInstance(command, list)
        self.assertEqual(command[:3], ["git", "ls-remote", "--tags"])
        self.assertEqual(command[4:], ["refs/tags/v1", "refs/tags/v1^{}"])
        self.assertNotIn("shell", run_mock.call_args.kwargs)
        self.assertEqual(lines, [f"{'a' * 40}\trefs/tags/v1"])



def manifest_changing(package_name, /, **changes):
    """A copy of the real manifest where the package `package_name` has the given fields replaced."""
    manifest = copy.deepcopy(REAL_MANIFEST)
    package = next(p for p in manifest["packages"] if p["name"] == package_name)
    package.update(changes)
    return manifest


def manifest_with_top_level(**changes):
    manifest = copy.deepcopy(REAL_MANIFEST)
    manifest.update(changes)
    return manifest


def upstream_documents(manifest):
    """What the three direct dependencies' upstream manifests would say about this manifest.

    Every inherited package is listed (name, url, rev) by one direct dependency, and `batteries` by
    all three, as the real upstream manifests overlap. Keyed by the URL that is fetched.
    """
    direct = [p for p in manifest["packages"] if p["inherited"] is False]
    inherited = [p for p in manifest["packages"] if p["inherited"] is True]
    documents = {}
    for index, parent in enumerate(direct):
        listed = [
            {"name": p["name"], "url": p["url"], "rev": p["rev"]}
            for position, p in enumerate(inherited)
            if position % len(direct) == index or p["name"] == "batteries"
        ]
        url = check_manifest.upstream_manifest_url(parent["url"], parent["rev"])
        documents[url] = json.dumps({"version": "1.2.0", "packages": listed}).encode()
    return documents


class FakeUpstream:
    """A `fetch` double: serves `documents` by URL and records every request."""

    def __init__(self, documents):
        self.documents = documents
        self.calls = []

    def __call__(self, url):
        self.calls.append(url)
        if url not in self.documents:
            raise OSError(f"no such upstream document: {url}")
        return self.documents[url]


class FakeTags:
    """An `ls_remote` double answering from a manifest's own revs (lightweight tags)."""

    def __init__(self, manifest):
        self.by_url = {p["url"]: p["rev"] for p in manifest["packages"]}
        self.calls = []

    def __call__(self, url, tag):
        self.calls.append((url, tag))
        return [f"{self.by_url[url]}\trefs/tags/{tag}"]


class PackageConstraintTests(unittest.TestCase):
    """The packages that are not direct dependencies were once accepted whatever they held."""

    def assert_refused(self, manifest, message):
        errors = check_structure(manifest)
        self.assertTrue(any(message in e for e in errors), (message, errors))

    def test_the_real_manifest_passes_every_constraint(self):
        self.assertEqual(check_structure(REAL_MANIFEST), [])

    def test_inherited_package_pointing_at_another_known_repository_is_refused(self):
        manifest = manifest_changing("batteries", url="https://github.com/leanprover-community/mathlib4")
        self.assert_refused(manifest, "is not the repository of this package")

    def test_inherited_package_pointing_at_an_unlisted_repository_is_refused(self):
        for url in ("https://github.com/acmepjz/anything", "https://github.com/leanprover/anything"):
            with self.subTest(url=url):
                self.assert_refused(manifest_changing("batteries", url=url), "is not in the allow-list")

    def test_every_name_is_bound_to_one_repository(self):
        for name, repository in check_manifest.ALLOWED_PACKAGES.items():
            other = next(r for r in sorted(check_manifest.ALLOWED_REPOSITORIES) if r != repository)
            with self.subTest(name=name):
                manifest = manifest_changing(name, url=f"https://github.com/{other}")
                self.assert_refused(manifest, "is not the repository of this package")

    def test_extra_package_is_refused(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        batteries = next(p for p in manifest["packages"] if p["name"] == "batteries")
        manifest["packages"].append({**batteries, "name": "extra"})
        self.assert_refused(manifest, "extra: not one of the known packages")

    def test_extra_package_with_a_known_name_is_refused_as_a_duplicate(self):
        manifest = copy.deepcopy(REAL_MANIFEST)
        manifest["packages"].append(copy.deepcopy(manifest["packages"][-1]))
        self.assert_refused(manifest, "duplicate package")

    def test_path_fields_refuse_traversal_absolute_paths_and_odd_characters(self):
        bad = ["../../..", "..", "a/../b", "/etc/passwd", "a b", "a;b", "$(id)", "x\n", "-rf", "~", "a\\b"]
        for key in ("subDir", "configFile", "manifestFile", "scope"):
            for value in bad:
                with self.subTest(key=key, value=value):
                    self.assert_refused(manifest_changing("batteries", **{key: value}), "plain relative path")
        for key in ("configFile", "manifestFile"):
            with self.subTest(key=key, value=""):
                self.assert_refused(manifest_changing("batteries", **{key: ""}), "plain relative path")
        for key in ("subDir", "configFile", "manifestFile", "scope"):
            with self.subTest(key=key, value=5):
                self.assert_refused(manifest_changing("batteries", **{key: 5}), "is not a string")

    def test_plain_relative_paths_are_accepted(self):
        cases = (("subDir", "sub/dir"), ("subDir", None), ("configFile", "lakefile.toml"), ("scope", ""))
        for key, value in cases:
            with self.subTest(key=key, value=value):
                self.assertEqual(check_structure(manifest_changing("batteries", **{key: value})), [])

    def test_input_rev_must_be_a_plain_name_and_not_a_full_ref(self):
        for value in ("refs/heads/evil", "refs/tags/v1", "../x", "a b", "-x", "main\n", "", 5):
            with self.subTest(value=value):
                manifest = manifest_changing("batteries", inputRev=value)
                self.assert_refused(manifest, "`inputRev` must be a plain name")
        for value in ("main", "master", "v4.34.0", "feature/x", None):
            with self.subTest(value=value):
                self.assertEqual(check_structure(manifest_changing("batteries", inputRev=value)), [])

    def test_package_names_are_plain_names(self):
        for value in ("a b", "x\n::notice::y", "", 5, None, "a/b"):
            with self.subTest(value=value):
                self.assert_refused(manifest_changing("batteries", name=value), "`name` must match")

    def test_unknown_and_mistyped_package_keys_are_refused(self):
        self.assert_refused(manifest_changing("batteries", extra="x"), "unknown key")
        self.assert_refused(manifest_changing("batteries", inherited="yes"), "`inherited` must be a boolean")

    def test_top_level_lake_dir_name_and_unknown_keys_are_refused(self):
        self.assert_refused(manifest_with_top_level(lakeDir="../../x"), "`lakeDir` must be")
        self.assert_refused(manifest_with_top_level(lakeDir=None), "`lakeDir` must be")
        self.assert_refused(manifest_with_top_level(name="evil name"), "`name` must match")
        self.assert_refused(manifest_with_top_level(name="x\n::notice::y"), "`name` must match")
        self.assert_refused(manifest_with_top_level(extra=1), "unknown top-level key")

    def test_manifest_name_must_be_the_package_declared_by_the_lakefile(self):
        errors = check_consistency(manifest_with_top_level(name="evil"), REAL_LAKEFILE, REAL_TOOLCHAIN)
        self.assertTrue(any("manifest `name` 'evil' != lakefile package 'k7pl'" in e for e in errors), errors)
        self.assertEqual(check_consistency(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN), [])

    def test_packages_that_are_not_inherited_must_be_required_by_the_lakefile(self):
        manifest = manifest_changing("batteries", inherited=False)
        errors = check_consistency(manifest, REAL_LAKEFILE, REAL_TOOLCHAIN)
        self.assertTrue(any("batteries: not inherited, but no `require`" in e for e in errors), errors)

    def test_a_well_formed_rev_is_not_caught_offline(self):
        # Documents the limit that --check-upstream exists for: an all-zero rev has the right shape.
        self.assertEqual(check_structure(manifest_changing("batteries", rev="0" * 40)), [])


class IndependentAuditFollowUpTests(unittest.TestCase):
    """Gaps found by an independent audit of the first version of these checks."""

    def test_the_config_and_manifest_file_names_are_closed_lists(self):
        for value in ("evil.lean", "tools/run.lean", "lakefile.lean.bak", "Lakefile.lean"):
            with self.subTest(configFile=value):
                errors = check_structure(manifest_changing("batteries", configFile=value))
                self.assertTrue(any("`configFile` must be one of" in e for e in errors), errors)
        for value in ("other.json", "sub/lake-manifest.json"):
            with self.subTest(manifestFile=value):
                errors = check_structure(manifest_changing("batteries", manifestFile=value))
                self.assertTrue(any("`manifestFile` must be" in e for e in errors), errors)
        for value in ("lakefile.lean", "lakefile.toml"):
            with self.subTest(accepted=value):
                self.assertEqual(check_structure(manifest_changing("batteries", configFile=value)), [])

    def test_version_and_fixed_toolchain_must_be_well_formed_when_present(self):
        for value in ("", "1.2", "v1.2.0", "1.2.0\n", 1, None, ["1.2.0"]):
            with self.subTest(version=value):
                errors = check_structure(manifest_with_top_level(version=value))
                self.assertTrue(any("`version` must look like" in e for e in errors), errors)
        for value in ("false", 0, None, [False]):
            with self.subTest(fixedToolchain=value):
                errors = check_structure(manifest_with_top_level(fixedToolchain=value))
                self.assertTrue(any("`fixedToolchain` must be a boolean" in e for e in errors), errors)
        self.assertEqual(check_structure(manifest_with_top_level(version="1.3.0", fixedToolchain=True)), [])

    def test_a_parent_directory_inside_input_rev_is_refused(self):
        for value in ("a/../b", "v1..2", "main/.."):
            with self.subTest(inputRev=value):
                errors = check_structure(manifest_changing("batteries", inputRev=value))
                self.assertTrue(any("`inputRev` must be a plain name" in e for e in errors), errors)

    def test_the_toolchain_file_must_be_exactly_one_release_and_nothing_else(self):
        for text in (
            "junk leanprover/lean4:v4.34.0\n",
            "leanprover/lean4:v4.34.0 junk\n",
            "leanprover/lean4:v4.34.0\nleanprover/lean4:v4.0.1\n",
            "# comment\nleanprover/lean4:v4.34.0\n",
        ):
            with self.subTest(text=text):
                errors = check_consistency(REAL_MANIFEST, REAL_LAKEFILE, text)
                self.assertTrue(any("unrecognised content" in e for e in errors), errors)
        self.assertEqual(check_consistency(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN), [])

    def test_a_second_package_declaration_in_the_lakefile_is_refused(self):
        errors = check_consistency(REAL_MANIFEST, REAL_LAKEFILE + "\npackage other\n", REAL_TOOLCHAIN)
        self.assertTrue(any("expected one `package` declaration, found 2" in e for e in errors), errors)
        errors = check_consistency(REAL_MANIFEST, REAL_LAKEFILE.replace("package ", "-- package ", 1), REAL_TOOLCHAIN)
        self.assertTrue(any("expected one `package` declaration, found 0" in e for e in errors), errors)


class UpstreamTests(unittest.TestCase):
    def errors_for(self, manifest, documents=None, verified=DIRECT):
        docs = documents if documents is not None else upstream_documents(REAL_MANIFEST)
        fetch = FakeUpstream(docs)
        return check_manifest.check_upstream(manifest, set(verified), fetch), fetch

    def test_a_faithful_upstream_is_accepted(self):
        errors, fetch = self.errors_for(REAL_MANIFEST)
        self.assertEqual(errors, [])
        self.assertEqual(len(fetch.calls), 3)
        for parent in (p for p in REAL_MANIFEST["packages"] if p["name"] in DIRECT):
            owner_repo = parent["url"].removeprefix("https://github.com/")
            expected = f"https://raw.githubusercontent.com/{owner_repo}/{parent['rev']}/lake-manifest.json"
            self.assertIn(expected, fetch.calls)

    def test_inherited_rev_differing_from_upstream_is_refused(self):
        errors, _ = self.errors_for(manifest_changing("batteries", rev="0" * 40))
        self.assertTrue(any(e.startswith("batteries:") and "differ from upstream" in e for e in errors), errors)
        self.assertEqual(len(errors), 1, errors)

    def test_inherited_url_differing_from_upstream_is_refused(self):
        manifest = manifest_changing("batteries", url="https://github.com/leanprover-community/mathlib4")
        errors, _ = self.errors_for(manifest)
        self.assertTrue(any(e.startswith("batteries:") and "differ from upstream" in e for e in errors), errors)

    def test_a_package_that_no_verified_dependency_lists_is_refused(self):
        documents = {
            url: json.dumps(
                {"packages": [e for e in json.loads(body)["packages"] if e["name"] != "aesop"]}
            ).encode()
            for url, body in upstream_documents(REAL_MANIFEST).items()
        }
        errors, _ = self.errors_for(REAL_MANIFEST, documents)
        self.assertEqual(errors, ["aesop: not listed by the manifest of any verified direct dependency"])

    def test_a_package_that_only_an_unverified_dependency_lists_is_refused(self):
        documents = upstream_documents(REAL_MANIFEST)

        def names(selector):
            return {
                e["name"]
                for url, body in documents.items()
                if selector("/verso/" in url)
                for e in json.loads(body)["packages"]
            }

        only_in_verso = names(lambda is_verso: is_verso) - names(lambda is_verso: not is_verso)
        self.assertTrue(only_in_verso)
        errors, fetch = self.errors_for(REAL_MANIFEST, documents, verified={"mathlib", "cslib"})
        self.assertEqual(len(fetch.calls), 2)
        self.assertFalse(any("/verso/" in url for url in fetch.calls))
        self.assertEqual({e.split(":")[0] for e in errors}, only_in_verso)

    def test_unreadable_or_malformed_upstream_manifests_are_refused(self):
        answers = (
            ("os error", OSError("boom")),
            ("not json", b"not json"),
            ("not utf-8", b"\xff\xfe"),
            ("no list", b'{"packages": 3}'),
            ("not an object", b"[]"),
        )
        for label, answer in answers:
            with self.subTest(label=label):

                def fetch(url, answer=answer):
                    if isinstance(answer, Exception):
                        raise answer
                    return answer

                errors = check_manifest.check_upstream(REAL_MANIFEST, set(DIRECT), fetch)
                self.assertTrue(any(e.startswith("mathlib:") for e in errors), errors)
                self.assertTrue(any("not listed" in e for e in errors), errors)

    def test_the_manifest_of_an_unverified_or_invalid_dependency_is_never_fetched(self):
        errors, fetch = self.errors_for(REAL_MANIFEST, verified=())
        self.assertEqual(fetch.calls, [])
        self.assertTrue(errors)
        errors, fetch = self.errors_for(manifest_changing("mathlib", rev="main"))
        self.assertFalse(any("/mathlib4/main/" in url for url in fetch.calls))
        self.assertTrue(any("not fetching the upstream manifest" in e for e in errors), errors)

    def test_the_default_fetch_only_talks_https_to_the_raw_host_and_bounds_the_size(self):
        refused = (
            "http://raw.githubusercontent.com/a/b/c/lake-manifest.json",
            "https://evil.example/a/b/c/lake-manifest.json",
            "https://raw.githubusercontent.com.evil.example/a/b/c/lake-manifest.json",
            "file:///etc/passwd",
        )
        for url in refused:
            with self.subTest(url=url), mock.patch.object(check_manifest.urllib.request, "urlopen") as opener:
                with self.assertRaises(ValueError):
                    check_manifest.fetch_upstream_manifest(url)
                opener.assert_not_called()
        url = "https://raw.githubusercontent.com/a/b/c/lake-manifest.json"
        big = mock.MagicMock()
        big.__enter__.return_value.read.return_value = b"x" * (check_manifest.MAX_MANIFEST_BYTES + 1)
        with mock.patch.object(check_manifest.urllib.request, "urlopen", return_value=big):
            with self.assertRaises(ValueError):
                check_manifest.fetch_upstream_manifest(url)
        small = mock.MagicMock()
        small.__enter__.return_value.read.return_value = b"{}"
        with mock.patch.object(check_manifest.urllib.request, "urlopen", return_value=small):
            self.assertEqual(check_manifest.fetch_upstream_manifest(url), b"{}")


class WiringTests(unittest.TestCase):
    """`main` -> `run` -> `check_tags` / `check_upstream`, with doubles injected at the entry point."""

    def run_main(self, *argv, ls_remote=no_network, fetch=None):
        stdout, stderr = io.StringIO(), io.StringIO()
        with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
            code = check_manifest.main(
                ["--root", str(ROOT), *argv], ls_remote=ls_remote, fetch=fetch or FakeUpstream({})
            )
        return code, stdout.getvalue(), stderr.getvalue()

    def test_without_flags_nothing_is_fetched_or_queried(self):
        fetch = FakeUpstream({})
        code, out, _ = self.run_main(ls_remote=no_network, fetch=fetch)
        self.assertEqual(code, 0)
        self.assertNotIn("upstream", out)
        self.assertEqual(fetch.calls, [])

    def test_check_tags_reaches_the_tag_comparison(self):
        tags, fetch = FakeTags(REAL_MANIFEST), FakeUpstream({})
        code, out, _ = self.run_main("--check-tags", ls_remote=tags, fetch=fetch)
        self.assertEqual(code, 0)
        self.assertIn("including upstream tags", out)
        self.assertEqual(len(tags.calls), 3)
        self.assertEqual(fetch.calls, [])  # --check-tags alone never fetches a manifest

    def test_check_tags_failure_is_reported_with_status_1(self):
        tags = FakeTags(manifest_changing("mathlib", rev="0" * 40))
        code, _, err = self.run_main("--check-tags", ls_remote=tags)
        self.assertEqual(code, 1)
        self.assertIn("mathlib: rev", err)

    def test_check_upstream_reaches_both_comparisons(self):
        tags, fetch = FakeTags(REAL_MANIFEST), FakeUpstream(upstream_documents(REAL_MANIFEST))
        code, out, _ = self.run_main("--check-upstream", ls_remote=tags, fetch=fetch)
        self.assertEqual(code, 0)
        self.assertIn("including upstream tags and manifests", out)
        self.assertEqual(len(tags.calls), 3)  # --check-upstream implies the tag check
        self.assertEqual(len(fetch.calls), 3)

    def test_check_upstream_alone_still_refuses_a_wrong_tag(self):
        tags = FakeTags(manifest_changing("cslib", rev="0" * 40))
        fetch = FakeUpstream(upstream_documents(REAL_MANIFEST))
        code, _, err = self.run_main("--check-upstream", ls_remote=tags, fetch=fetch)
        self.assertEqual(code, 1)
        self.assertIn("cslib: rev", err)
        self.assertFalse(any("/cslib/" in url for url in fetch.calls))  # unverified: not trusted

    def test_check_upstream_refuses_a_forged_inherited_rev_end_to_end(self):
        forged = manifest_changing("batteries", rev="0" * 40)
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "lake-manifest.json"
            path.write_text(json.dumps(forged), encoding="utf-8")
            code, _, err = self.run_main(
                "--manifest",
                str(path),
                "--check-upstream",
                ls_remote=FakeTags(REAL_MANIFEST),
                fetch=FakeUpstream(upstream_documents(REAL_MANIFEST)),
            )
        self.assertEqual(code, 1)
        self.assertIn("batteries:", err)
        self.assertIn("differ from upstream", err)

    def test_check_upstream_refuses_when_upstream_cannot_be_read(self):
        code, _, err = self.run_main("--check-upstream", ls_remote=FakeTags(REAL_MANIFEST))
        self.assertEqual(code, 1)
        self.assertIn("could not read the upstream lake-manifest.json", err)


class OutputInjectionTests(unittest.TestCase):
    """Text taken from the untrusted manifest must not become a workflow command."""

    def run_annotated(self, manifest, *argv, ls_remote=no_network):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "lake-manifest.json"
            path.write_text(json.dumps(manifest), encoding="utf-8")
            stdout, stderr = io.StringIO(), io.StringIO()
            with mock.patch.dict(os.environ, {"GITHUB_ACTIONS": "true"}):
                with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                    code = check_manifest.main(
                        ["--root", str(ROOT), "--manifest", str(path), *argv], ls_remote=ls_remote
                    )
        return code, stdout.getvalue(), stderr.getvalue()

    def assert_no_injected_command(self, stderr):
        lines = stderr.splitlines()
        self.assertTrue(lines)
        for line in lines[:-1]:
            self.assertTrue(line.startswith("::error::"), line)
        commands = ("::notice", "::warning", "::add-mask", "::stop-commands")
        self.assertFalse(any(line.startswith(commands) for line in lines))

    def test_a_package_name_cannot_inject_a_command(self):
        payload = "x\n::notice::pwned\n::add-mask::secret"
        code, _, err = self.run_annotated(manifest_changing("batteries", name=payload))
        self.assertEqual(code, 1)
        self.assert_no_injected_command(err)
        self.assertIn("`name` must match", err)

    def test_a_top_level_name_cannot_inject_a_command(self):
        code, _, err = self.run_annotated(manifest_with_top_level(name="y\r\n::notice::pwned"))
        self.assertEqual(code, 1)
        self.assert_no_injected_command(err)

    def test_other_fields_cannot_inject_a_command_either(self):
        evil = "a\n::notice::pwned"
        for field in ("rev", "url", "inputRev", "subDir", "configFile", "type", "scope"):
            with self.subTest(field=field):
                code, _, err = self.run_annotated(manifest_changing("batteries", **{field: evil}))
                self.assertEqual(code, 1)
                self.assert_no_injected_command(err)

    def test_a_rev_printed_by_the_tag_check_cannot_inject_a_command(self):
        # check_tags prints the manifest's rev unquoted; only the final sanitising protects it.
        manifest = manifest_changing("mathlib", rev="a" * 40 + "\n::notice::pwned")
        code, _, err = self.run_annotated(manifest, "--check-tags", ls_remote=FakeTags(REAL_MANIFEST))
        self.assertEqual(code, 1)
        self.assertIn("mathlib: rev", err)
        self.assert_no_injected_command(err)

    def test_clean_replaces_every_non_printable_character(self):
        self.assertEqual(check_manifest.clean("a\nb\rc\td\x00e f\x85g"), "a?b?c?d?e?f?g")
        self.assertEqual(check_manifest.clean("plain text: ok"), "plain text: ok")


class ProcessTests(unittest.TestCase):
    """The script as a command: its exit status is what the workflow sees."""

    def run_script(self, *args):
        env = {"PATH": os.environ.get("PATH", ""), "LANG": "C.UTF-8"}  # a controlled environment
        return subprocess.run(
            [sys.executable, "-I", str(SCRIPT), *args],
            cwd=ROOT,
            env=env,
            capture_output=True,
            text=True,
            timeout=60,
            check=False,
        )

    def test_exit_status_is_0_for_the_real_repository(self):
        result = self.run_script()
        self.assertEqual((result.returncode, result.stderr), (0, ""))
        self.assertIn("all checks passed", result.stdout)

    def test_exit_status_is_1_when_a_check_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            bad = Path(tmp) / "lake-manifest.json"
            bad.write_text(json.dumps(manifest_changing("batteries", rev="abc")), encoding="utf-8")
            result = self.run_script("--manifest", str(bad))
        self.assertEqual(result.returncode, 1)
        self.assertIn("40 lowercase hexadecimal", result.stderr)
        self.assertIn("must not be used", result.stderr)

    def test_exit_status_is_1_for_a_missing_manifest(self):
        with tempfile.TemporaryDirectory() as tmp:
            result = self.run_script("--root", tmp)
        self.assertEqual(result.returncode, 1)

    def test_exit_status_is_2_for_a_usage_error(self):
        result = self.run_script("--no-such-option")
        self.assertEqual(result.returncode, 2)
        self.assertIn("usage:", result.stderr)

    def test_help_documents_the_upstream_option(self):
        result = self.run_script("--help")
        self.assertEqual(result.returncode, 0)
        self.assertIn("--check-upstream", result.stdout)


if __name__ == "__main__":
    unittest.main()
