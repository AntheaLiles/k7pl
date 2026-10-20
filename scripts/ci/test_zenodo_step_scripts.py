# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Dry runs of the shell steps of zenodo.yaml that guard the deposit.

zenodo.yaml runs when a `spec-v*` release is published, never on a pull request. Its shell steps
are run here with a stub gh first on PATH (the real sha256sum checks the checksum), no network and
no token. The tests pin the verifications that must precede a deposit: the metadata match, the
gh capabilities, the three downloaded assets, and the exact `gh release verify`,
`gh release verify-asset` and `gh attestation verify` invocations.
"""

from __future__ import annotations

import hashlib
import shutil
import unittest

from step_script_testing import SCRIPTS, StepScriptCase

TAG = "spec-v1.0.0"
SHA = "a" * 40
REPO = "owner/k7pl"
ASSETS = ["k7pl-spec.pdf", "k7pl-spec.pdf.sha256", "k7pl-spec.pdf.sigstore.json"]


class MetadataTests(StepScriptCase):
    """Step "Check that the release matches CITATION.cff and spec/CHANGELOG.md"."""

    def setUp(self):
        super().setUp()
        (self.work / "scripts" / "ci").mkdir(parents=True)
        shutil.copy(SCRIPTS / "citation_version.sh", self.work / "scripts" / "ci")
        (self.work / "CITATION.cff").write_text('cff-version: 1.2.0\nversion: "1.0.0"\n')
        (self.work / "spec").mkdir()
        (self.work / "spec" / "CHANGELOG.md").write_text("# Spec\n\n## [1.0.0]\n\n- Added x.\n")

    def test_a_matching_release_passes(self):
        result = self.run_script("zenodo_check_release_metadata.sh", TAG=TAG)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_a_mismatch_is_refused(self):
        result = self.run_script("zenodo_check_release_metadata.sh", TAG="spec-v1.1.0")
        self.assertEqual(result.returncode, 1)
        self.assertIn("::error::CITATION.cff déclare '1.0.0' mais la release est 'spec-v1.1.0'", result.stdout)
        (self.work / "CITATION.cff").write_text('version: "1.1.0"\n')
        result = self.run_script("zenodo_check_release_metadata.sh", TAG="spec-v1.1.0")
        self.assertEqual(result.returncode, 1)
        self.assertIn("::error::spec/CHANGELOG.md ne contient pas la section '## [1.1.0]'", result.stdout)


class GhCapabilityTests(StepScriptCase):
    """Step "Check that gh can verify releases and attestations"."""

    def check(self, missing: str):
        self.stub("gh", f'[ "$*" != "{missing} --help" ] || exit 1')
        return self.run_script("zenodo_check_gh.sh")

    def test_every_verification_command_is_required(self):
        result = self.check("none")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual([row[1:] for row in self.calls("gh")], [
            ["--version"], ["release", "verify", "--help"], ["release", "verify-asset", "--help"],
            ["attestation", "verify", "--help"],
        ])
        for missing in ("release verify", "release verify-asset", "attestation verify"):
            with self.subTest(missing=missing):
                self.assertNotEqual(self.check(missing).returncode, 0)


class DownloadTests(StepScriptCase):
    """Step "Download the published assets"."""

    def download(self, skip: str = "none", status: int = 0):
        self.stub("gh", f'''dir="$5"  # release download TAG --dir DIR ...
for f in {" ".join(ASSETS)}; do [ "$f" = "{skip}" ] || echo "$f" > "$dir/$f"; done
exit {status}''')
        return self.run_script("zenodo_download_assets.sh", TAG=TAG, GH_REPO=REPO, GH_TOKEN="t")

    def test_the_three_assets_of_the_release_are_downloaded(self):
        result = self.download()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(self.calls("gh")[0][1:], [
            "release", "download", TAG, "--dir", "out",
            "--pattern", ASSETS[0], "--pattern", ASSETS[1], "--pattern", ASSETS[2],
        ])
        self.assertEqual(sorted(path.name for path in (self.work / "out").iterdir()), sorted(ASSETS))

    def test_a_missing_asset_is_refused(self):
        result = self.download(skip=ASSETS[2])
        self.assertEqual(result.returncode, 1)
        self.assertIn(f"::error::asset {ASSETS[2]} is missing from release {TAG}", result.stdout)

    def test_a_failed_download_is_refused(self):
        self.assertNotEqual(self.download(status=1).returncode, 0)

    def test_an_existing_out_directory_is_refused_before_any_download(self):
        (self.work / "out").mkdir()
        self.assertNotEqual(self.download().returncode, 0)
        self.assertEqual(self.calls("gh"), [])


class VerifyTests(StepScriptCase):
    """Step "Verify the release, the PDF and its build attestation"."""

    def setUp(self):
        super().setUp()
        out = self.work / "out"
        out.mkdir()
        (out / "k7pl-spec.pdf").write_bytes(b"pdf bytes")
        (out / "k7pl-spec.pdf.sigstore.json").write_text("{}")
        digest = hashlib.sha256(b"pdf bytes").hexdigest()
        (out / "k7pl-spec.pdf.sha256").write_text(f"{digest}  k7pl-spec.pdf\n")

    def verify(self, fail_at: str = "none"):
        self.stub("gh", f'[ "$1 $2" != "{fail_at}" ] || exit 1')
        return self.run_script("zenodo_verify_assets.sh", TAG=TAG, GH_REPO=REPO, GH_TOKEN="t", GITHUB_SHA=SHA)

    def test_the_release_the_asset_and_the_build_attestation_are_verified(self):
        result = self.verify()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual([row[1:] for row in self.calls("gh")], [
            ["release", "verify", TAG],
            ["release", "verify-asset", TAG, "out/k7pl-spec.pdf"],
            ["attestation", "verify", "out/k7pl-spec.pdf", "--repo", REPO,
             "--bundle", "out/k7pl-spec.pdf.sigstore.json",
             "--signer-workflow", f"{REPO}/.github/workflows/release.yaml",
             "--source-ref", f"refs/tags/{TAG}", "--source-digest", SHA, "--deny-self-hosted-runners"],
        ])
        self.assertIn(f"`gh release verify {TAG}` : réussi", self.summary.read_text())

    def test_any_failed_verification_stops_before_the_summary(self):
        for fail_at in ("release verify", "release verify-asset", "attestation verify"):
            with self.subTest(fail_at=fail_at):
                self.calls_file.write_text("")
                self.assertNotEqual(self.verify(fail_at).returncode, 0)
                self.assertEqual(self.summary.read_text(), "")

    def test_a_corrupted_pdf_fails_the_checksum(self):
        (self.work / "out" / "k7pl-spec.pdf").write_bytes(b"other bytes")
        self.assertNotEqual(self.verify().returncode, 0)
        self.assertEqual(self.summary.read_text(), "")


if __name__ == "__main__":
    unittest.main()
