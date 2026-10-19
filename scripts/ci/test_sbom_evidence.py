# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline tests for the SBOM evidence step (`sbom_evidence.py`).

`lake exe sbomAudit` is replaced by a double that answers like the Lean executable; the Lean
executable itself is exercised by the `impl` job of verify.yaml, not here.
"""

import contextlib
import copy
import hashlib
import io
import json
import subprocess
import tempfile
import unittest
from pathlib import Path

import lake_manifest_to_spdx
import sbom_evidence

ROOT = Path(__file__).resolve().parents[2]
REAL_MANIFEST = json.loads((ROOT / "lake-manifest.json").read_text(encoding="utf-8"))
REAL_LAKEFILE = (ROOT / "lakefile.lean").read_text(encoding="utf-8")
REAL_TOOLCHAIN = (ROOT / "lean-toolchain").read_text(encoding="utf-8")
CREATED = "2026-10-10T00:00:00Z"


def lean_report(status="PASS", diagnostics=(), sources=("lake-manifest.json", "/tmp/k7pl-lake.spdx.json")):
    """A report shaped like the one `lake exe sbomAudit` prints (tools/Compliance/SbomAudit.lean)."""
    return {
        "schemaVersion": "k7pl.compliance-report/v1",
        "tool": "k7pl-sbom-audit",
        "toolVersion": "0.1.0",
        "status": status,
        "assuranceScope": "scope",
        "sourceArtifacts": list(sources),
        "limitations": ["limit"],
        "diagnostics": [
            {"ruleId": rule, "severity": "error", "message": "m", "artifact": "a"} for rule in diagnostics
        ],
    }


class FakeAudit:
    """Answers like the Lean executable on the four negative inputs, PASS otherwise.

    ERROR/2 on unparsable JSON; FAIL/1 on an empty inventory, on a blank package name, or on a
    revision that differs from `manifest`. `overrides` maps a rule to the (exit status, report)
    to answer instead, to model a broken executable.
    """

    def __init__(self, manifest, **overrides):
        self.manifest = manifest
        self.overrides = overrides
        self.calls = []

    def answer(self, key, code, report):
        code, report = self.overrides.get(key, (code, report))
        return subprocess.CompletedProcess([], code, json.dumps(report), "")

    def __call__(self, manifest_path, sbom_path):
        self.calls.append((manifest_path, sbom_path))
        try:
            manifest = json.loads(Path(manifest_path).read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            return self.answer("malformed", 2, lean_report("ERROR", ["INPUT-JSON-MANIFEST"]))
        sbom = json.loads(Path(sbom_path).read_text(encoding="utf-8"))
        if not manifest["packages"]:
            return self.answer("empty", 1, lean_report("FAIL", ["SBOM-EMPTY-INVENTORY"]))
        if any(not p["name"].strip() for p in manifest["packages"]):
            return self.answer("blank", 1, lean_report(
                "FAIL", ["SBOM-MANIFEST-EMPTY-IDENTITY", "SBOM-PACKAGE-EMPTY-IDENTITY"]))
        manifest_revs = {(p["name"], p["rev"]) for p in self.manifest["packages"]}
        sbom_revs = {(p["name"], p["versionInfo"]) for p in sbom["packages"]}
        if manifest_revs != sbom_revs:
            return self.answer("mismatch", 1, lean_report("FAIL", ["SBOM-INVENTORY-MISMATCH"]))
        return subprocess.CompletedProcess([], 0, json.dumps(lean_report()), "")


class Workspace:
    """A temporary RUNNER_TEMP holding the generated SBOM, the report and the event payload."""

    def __init__(self, test, manifest=REAL_MANIFEST, report=None, pull_request_head="a" * 40):
        tmp = tempfile.TemporaryDirectory()
        test.addCleanup(tmp.cleanup)
        self.dir = Path(tmp.name)
        self.manifest_data = manifest
        self.manifest = self.dir / "lake-manifest.json"
        self.manifest.write_text(json.dumps(manifest), encoding="utf-8")
        sbom = lake_manifest_to_spdx.generate_sbom(REAL_MANIFEST, REAL_LAKEFILE, REAL_TOOLCHAIN, CREATED)
        self.sbom = self.dir / "k7pl-lake.spdx.json"
        self.sbom.write_text(json.dumps(sbom, indent=2, sort_keys=True) + "\n", encoding="utf-8")
        self.report = self.dir / "k7pl-sbom-audit.json"
        report = report or lean_report(sources=("lake-manifest.json", str(self.sbom)))
        self.report.write_text(json.dumps(report), encoding="utf-8")
        self.output = self.dir / "k7pl-sbom-evidence.json"
        self.summary = self.dir / "summary.md"
        self.event = self.dir / "event.json"
        event = {"pull_request": {"head": {"sha": pull_request_head}}} if pull_request_head else {}
        self.event.write_text(json.dumps(event), encoding="utf-8")
        self.env = {
            "RUNNER_TEMP": str(self.dir),
            "GITHUB_RUN_ID": "123",
            "GITHUB_RUN_ATTEMPT": "2",
            "GITHUB_SHA": "b" * 40,
            "GITHUB_WORKFLOW": "Full Verification",
            "GITHUB_EVENT_PATH": str(self.event),
            "GITHUB_STEP_SUMMARY": str(self.summary),
        }

    def argv(self):
        return [
            "--report", str(self.report),
            "--manifest", str(self.manifest),
            "--sbom", str(self.sbom),
            "--output", str(self.output),
            "--root", str(ROOT),
        ]

    def run(self, audit=None, env=None):
        stdout, stderr = io.StringIO(), io.StringIO()
        with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
            code = sbom_evidence.main(self.argv(), env=self.env if env is None else env,
                                      run_audit=audit or FakeAudit(self.manifest_data))
        return code, stdout.getvalue(), stderr.getvalue()


def sha256(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


class ReportTests(unittest.TestCase):
    def test_a_clean_pass_is_accepted(self):
        report = lean_report()
        self.assertIs(sbom_evidence.check_report(report), report)

    def test_every_deviation_is_refused(self):
        cases = {
            "schema": {"schemaVersion": "other/v1"},
            "tool": {"tool": "other"},
            "tool version": {"toolVersion": ""},
            "status FAIL": {"status": "FAIL"},
            "status ERROR": {"status": "ERROR"},
            "diagnostics": {"diagnostics": [{"ruleId": "X"}]},
            "manifest source": {"sourceArtifacts": ["other.json", "/tmp/k7pl-lake.spdx.json"]},
            "sbom source": {"sourceArtifacts": ["lake-manifest.json", "/tmp/other.spdx.json"]},
            "bare sbom name": {"sourceArtifacts": ["lake-manifest.json", "k7pl-lake.spdx.json"]},
            "one source": {"sourceArtifacts": ["lake-manifest.json"]},
        }
        for label, change in cases.items():
            with self.subTest(label=label):
                with self.assertRaises(sbom_evidence.EvidenceError):
                    sbom_evidence.check_report({**lean_report(), **change})
        for key in ("schemaVersion", "tool", "toolVersion", "status", "diagnostics", "sourceArtifacts"):
            with self.subTest(missing=key):
                report = lean_report()
                del report[key]
                with self.assertRaises(sbom_evidence.EvidenceError):
                    sbom_evidence.check_report(report)
        with self.assertRaises(sbom_evidence.EvidenceError):
            sbom_evidence.check_report([])


RECORDED_CASES = [
    {"case": "malformed manifest JSON", "exitCode": 2, "status": "ERROR"},
    {"case": "mutated package revision", "exitCode": 1, "status": "FAIL"},
    {"case": "empty manifest and SPDX inventory", "exitCode": 1, "status": "FAIL"},
    {"case": "Unicode blank package name (U+00A0)", "exitCode": 1, "status": "FAIL"},
]


class NegativeCaseTests(unittest.TestCase):
    def test_the_expected_failures_are_recorded(self):
        ws = Workspace(self)
        audit = FakeAudit(REAL_MANIFEST)
        cases = sbom_evidence.run_negative_cases(ws.manifest, ws.sbom, ws.dir, audit)
        self.assertEqual(cases, RECORDED_CASES)
        self.assertEqual(audit.calls, [
            (str(ws.dir / "malformed-manifest.json"), str(ws.sbom)),
            (str(ws.manifest), str(ws.dir / "mismatched.spdx.json")),
            (str(ws.dir / "empty-manifest.json"), str(ws.dir / "empty-inventory.spdx.json")),
            (str(ws.dir / "blank-name-manifest.json"), str(ws.dir / "blank-name.spdx.json")),
        ])

    def test_the_negative_inputs_are_those_of_the_former_inline_step(self):
        # Byte-for-byte what the inline Python of verify.yaml wrote at 3f1cbe6.
        ws = Workspace(self)
        sbom_evidence.run_negative_cases(ws.manifest, ws.sbom, ws.dir, FakeAudit(REAL_MANIFEST))
        read = lambda name: (ws.dir / name).read_text(encoding="utf-8")  # noqa: E731
        self.assertEqual(read("malformed-manifest.json"), "{")
        self.assertEqual(read("empty-manifest.json"), '{"name":"k7pl","packages":[]}')
        self.assertEqual(json.loads(read("empty-inventory.spdx.json")), {
            "spdxVersion": "SPDX-2.3", "SPDXID": "SPDXRef-DOCUMENT", "packages": [], "relationships": [],
        })
        self.assertEqual(json.loads(read("blank-name-manifest.json")), {
            "name": "k7pl",
            "packages": [{"name": "\u00a0", "url": "https://github.com/example/alpha", "rev": "a" * 40}],
        })
        self.assertIn('"name": "\\u00a0"', read("blank-name-manifest.json"))  # json.dumps escapes it
        blank_sbom = json.loads(read("blank-name.spdx.json"))
        self.assertEqual(blank_sbom["packages"][0]["name"], "\u00a0")
        self.assertEqual(blank_sbom["packages"][0]["SPDXID"], "SPDXRef-Package-alpha")
        self.assertEqual(blank_sbom["packages"][0]["versionInfo"], "a" * 40)
        self.assertEqual(blank_sbom["relationships"], [{
            "spdxElementId": "SPDXRef-DOCUMENT",
            "relationshipType": "DESCRIBES",
            "relatedSpdxElement": "SPDXRef-Package-alpha",
        }])
        for key in ("licenseDeclared", "licenseConcluded", "copyrightText"):
            self.assertEqual(blank_sbom["packages"][0][key], "NOASSERTION")
        self.assertTrue("\u00a0".isspace() and not "\u00a0".strip())  # really a Unicode blank

    def test_the_mutation_changes_exactly_the_first_revision(self):
        sbom = json.loads(Workspace(self).sbom.read_text(encoding="utf-8"))
        for first in ("f", "0"):
            with self.subTest(first=first):
                original = copy.deepcopy(sbom)
                original["packages"][0]["versionInfo"] = first + "1" * 39
                mutated = sbom_evidence.mutate_first_revision(original)
                self.assertNotEqual(mutated["packages"][0]["versionInfo"], original["packages"][0]["versionInfo"])
                self.assertEqual(mutated["packages"][0]["versionInfo"][1:], "1" * 39)
                self.assertEqual(mutated["packages"][1:], original["packages"][1:])
                self.assertEqual(original["packages"][0]["versionInfo"][0], first)  # input untouched

    def test_an_audit_that_accepts_a_bad_input_is_refused(self):
        ws = Workspace(self)
        wrong = {
            "malformed exit status": {"malformed": (1, lean_report("ERROR", ["INPUT-JSON-MANIFEST"]))},
            "malformed status": {"malformed": (2, lean_report("FAIL", ["INPUT-JSON-MANIFEST"]))},
            "malformed rule": {"malformed": (2, lean_report("ERROR", ["INPUT-SHAPE"]))},
            "mismatch passes": {"mismatch": (0, lean_report())},
            "mismatch rule": {"mismatch": (1, lean_report("FAIL", ["SBOM-RELATIONSHIP-COUNT"]))},
            "mismatch error": {"mismatch": (2, lean_report("ERROR", ["SBOM-INVENTORY-MISMATCH"]))},
            "empty passes": {"empty": (0, lean_report())},
            "empty rule": {"empty": (1, lean_report("FAIL", ["SBOM-CONTRACT"]))},
            "empty error": {"empty": (2, lean_report("ERROR", ["SBOM-EMPTY-INVENTORY"]))},
            "blank passes": {"blank": (0, lean_report())},
            "blank manifest rule only": {"blank": (1, lean_report("FAIL", ["SBOM-MANIFEST-EMPTY-IDENTITY"]))},
            "blank package rule only": {"blank": (1, lean_report("FAIL", ["SBOM-PACKAGE-EMPTY-IDENTITY"]))},
            "blank exit status": {"blank": (2, lean_report(
                "FAIL", ["SBOM-MANIFEST-EMPTY-IDENTITY", "SBOM-PACKAGE-EMPTY-IDENTITY"]))},
        }
        for label, overrides in wrong.items():
            with self.subTest(label=label):
                with self.assertRaises(sbom_evidence.EvidenceError):
                    sbom_evidence.run_negative_cases(ws.manifest, ws.sbom, ws.dir, FakeAudit(REAL_MANIFEST, **overrides))

    def test_a_diagnostic_without_a_rule_is_refused(self):
        ws = Workspace(self)
        report = lean_report("FAIL", ["SBOM-EMPTY-INVENTORY"])
        report["diagnostics"].append({"severity": "error"})
        with self.assertRaisesRegex(sbom_evidence.EvidenceError, "malformed diagnostics"):
            sbom_evidence.run_negative_cases(ws.manifest, ws.sbom, ws.dir, FakeAudit(REAL_MANIFEST, empty=(1, report)))

    def test_a_report_that_is_not_json_is_refused(self):
        ws = Workspace(self)

        def garbage(manifest, sbom):
            return subprocess.CompletedProcess([], 2, "not json", "")

        with self.assertRaisesRegex(sbom_evidence.EvidenceError, "did not print a JSON report"):
            sbom_evidence.run_negative_cases(ws.manifest, ws.sbom, ws.dir, garbage)


class EvidenceTests(unittest.TestCase):
    def test_end_to_end_evidence_and_summary(self):
        ws = Workspace(self)
        code, out, err = ws.run()
        self.assertEqual((code, err), (0, ""))
        self.assertIn("negative CLI cases: PASS", out)
        evidence = json.loads(ws.output.read_text(encoding="utf-8"))
        self.assertEqual(evidence["schemaVersion"], "k7pl.ci-evidence/v1")
        self.assertEqual(evidence["workflow"], {
            "name": "Full Verification",
            "runId": 123,
            "runAttempt": 2,
            "checkedOutSha": "b" * 40,
            "pullRequestHeadSha": "a" * 40,
        })
        self.assertEqual(evidence["audit"]["status"], "PASS")
        self.assertEqual(evidence["negativeCases"], RECORDED_CASES)

    def test_the_inputs_keep_their_names_order_and_real_hashes(self):
        ws = Workspace(self)
        self.assertEqual(ws.run()[0], 0)
        inputs = json.loads(ws.output.read_text(encoding="utf-8"))["inputs"]
        self.assertEqual([item["artifact"] for item in inputs], [
            "lake-manifest.json",
            "lakefile.lean",
            "lean-toolchain",
            "scripts/ci/lake_manifest_to_spdx.py",
            "tools/Compliance/SbomAudit.lean",
            "tools/Compliance/SbomAuditMain.lean",
            "k7pl-lake.spdx.json",
        ])
        self.assertEqual(inputs[0]["sha256"], sha256(ws.manifest))
        self.assertEqual(inputs[1]["sha256"], sha256(ROOT / "lakefile.lean"))
        self.assertEqual(inputs[6]["sha256"], sha256(ws.sbom))

    def test_the_summary_reports_the_spdx_hash_not_the_lakefile_hash(self):
        # Regression: the inline step printed inputs[1] (lakefile.lean) as the SPDX hash.
        ws = Workspace(self)
        self.assertEqual(ws.run()[0], 0)
        summary = ws.summary.read_text(encoding="utf-8")
        self.assertIn(f"- Generated SPDX SHA-256: `{sha256(ws.sbom)}`", summary)
        self.assertIn(f"- Manifest SHA-256: `{sha256(ws.manifest)}`", summary)
        self.assertNotIn(sha256(ROOT / "lakefile.lean"), summary)

    def test_the_component_count_comes_from_the_manifest(self):
        ws = Workspace(self)
        self.assertEqual(ws.run()[0], 0)
        expected = len(REAL_MANIFEST["packages"])
        self.assertIn(f"- Valid input: PASS; {expected} manifest components checked.", ws.summary.read_text(encoding="utf-8"))
        smaller = copy.deepcopy(REAL_MANIFEST)
        smaller["packages"] = smaller["packages"][:3]
        ws = Workspace(self, manifest=smaller)
        audit = FakeAudit(REAL_MANIFEST)  # the double compares against the full inventory
        self.assertEqual(ws.run(audit=audit)[0], 0)
        self.assertIn("- Valid input: PASS; 3 manifest components checked.", ws.summary.read_text(encoding="utf-8"))

    def test_the_summary_states_the_observed_negative_results(self):
        ws = Workspace(self)
        self.assertEqual(ws.run()[0], 0)
        self.assertIn(
            "- Negative integration cases: malformed manifest JSON → ERROR/2; mutated package revision → FAIL/1; "
            "empty manifest and SPDX inventory → FAIL/1; Unicode blank package name (U+00A0) → FAIL/1.",
            ws.summary.read_text(encoding="utf-8"),
        )

    def test_tool_versions_are_not_duplicated(self):
        ws = Workspace(self)
        self.assertEqual(ws.run()[0], 0)
        toolchain = json.loads(ws.output.read_text(encoding="utf-8"))["toolchain"]
        self.assertEqual(toolchain["sbomGenerator"],
                         f"{lake_manifest_to_spdx.TOOL_NAME}@{lake_manifest_to_spdx.TOOL_VERSION}")
        self.assertEqual(toolchain["leanAudit"], "k7pl-sbom-audit@0.1.0")
        self.assertEqual(toolchain["lean"], REAL_TOOLCHAIN.strip())
        report = lean_report(sources=("lake-manifest.json", str(ws.sbom)))
        report["toolVersion"] = "9.9.9"
        ws.report.write_text(json.dumps(report), encoding="utf-8")
        self.assertEqual(ws.run()[0], 0)
        toolchain = json.loads(ws.output.read_text(encoding="utf-8"))["toolchain"]
        self.assertEqual(toolchain["leanAudit"], "k7pl-sbom-audit@9.9.9")

    def test_without_a_pull_request_event_the_head_is_null(self):
        ws = Workspace(self, pull_request_head=None)
        self.assertEqual(ws.run()[0], 0)
        self.assertIsNone(json.loads(ws.output.read_text(encoding="utf-8"))["workflow"]["pullRequestHeadSha"])
        env = dict(ws.env)
        del env["GITHUB_EVENT_PATH"]
        self.assertEqual(ws.run(env=env)[0], 0)

    def test_failures_write_no_evidence_and_exit_1(self):
        ws = Workspace(self, report=lean_report("FAIL", ["SBOM-INVENTORY-MISMATCH"]))
        code, _, err = ws.run()
        self.assertEqual(code, 1)
        self.assertIn("not PASS", err)
        self.assertFalse(ws.output.exists())
        self.assertFalse(ws.summary.exists())

    def test_the_github_environment_is_required(self):
        for name in ("GITHUB_RUN_ID", "GITHUB_RUN_ATTEMPT", "GITHUB_SHA", "GITHUB_WORKFLOW",
                     "GITHUB_STEP_SUMMARY", "RUNNER_TEMP"):
            with self.subTest(missing=name):
                ws = Workspace(self)
                env = dict(ws.env)
                del env[name]
                code, _, err = ws.run(env=env)
                self.assertEqual(code, 1)
                self.assertIn(name, err)
        ws = Workspace(self)
        code, _, err = ws.run(env={**ws.env, "GITHUB_RUN_ID": "abc"})
        self.assertEqual(code, 1)
        self.assertIn("not an integer", err)

    def test_errors_are_annotations_without_injected_commands(self):
        ws = Workspace(self, report={**lean_report(), "status": "FAIL\n::notice::pwned"})
        code, _, err = ws.run(env={**ws.env, "GITHUB_ACTIONS": "true"})
        self.assertEqual(code, 1)
        lines = err.splitlines()
        self.assertEqual(len(lines), 1, lines)
        self.assertTrue(lines[0].startswith("::error::"), lines)


if __name__ == "__main__":
    unittest.main()
