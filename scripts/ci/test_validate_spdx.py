#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Offline regression tests for the SPDX validator wrapper and its diagnostic contract."""

from __future__ import annotations

import io
import json
import unittest
from contextlib import redirect_stdout
from importlib.metadata import PackageNotFoundError
from pathlib import Path
from tempfile import TemporaryDirectory
from types import SimpleNamespace
from unittest.mock import patch

from validate_spdx import main, preflight_issues, sha256_file, validate


PYTHON313_STRIP_WHITESPACE_CODEPOINTS = (
    0x0009, 0x000A, 0x000B, 0x000C, 0x000D, 0x001C, 0x001D, 0x001E, 0x001F,
    0x0020, 0x0085, 0x00A0, 0x1680, 0x2000, 0x2001, 0x2002, 0x2003, 0x2004,
    0x2005, 0x2006, 0x2007, 0x2008, 0x2009, 0x200A, 0x2028, 0x2029, 0x202F,
    0x205F, 0x3000,
)
PYTHON313_NON_WHITESPACE_BOUNDARY_CODEPOINTS = (
    0x0008, 0x000E, 0x001B, 0x0021, 0x0084, 0x0086, 0x009F, 0x00A1, 0x167F,
    0x1681, 0x1FFF, 0x200B, 0x2027, 0x202A, 0x205E, 0x3001, 0xFEFF,
)


VALIDATOR_VERSION = "0.8.5"


class PreflightTests(unittest.TestCase):
    def test_named_package_has_no_preflight_issue(self) -> None:
        document = {"packages": [{"name": "mathlib"}]}
        self.assertEqual(preflight_issues(document), [])

    def test_empty_name_is_rejected_for_known_upstream_gap(self) -> None:
        document = {"packages": [{"name": ""}]}
        issues = preflight_issues(document)
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGE-NAME"])
        self.assertIn("#885", issues[0]["message"])

    def test_missing_name_is_rejected(self) -> None:
        issues = preflight_issues({"packages": [{}]})
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGE-NAME"])

    def test_whitespace_only_name_is_rejected(self) -> None:
        issues = preflight_issues({"packages": [{"name": "   "}]})
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGE-NAME"])

    def test_python_313_strip_whitespace_set_matches_runtime_and_is_rejected(self) -> None:
        observed = tuple(
            code_point for code_point in range(0x110000)
            if chr(code_point).strip() == ""
        )
        self.assertEqual(observed, PYTHON313_STRIP_WHITESPACE_CODEPOINTS)

        for code_point in PYTHON313_STRIP_WHITESPACE_CODEPOINTS:
            name = chr(code_point)
            with self.subTest(codepoint=f"U+{code_point:04X}"):
                self.assertEqual(name.strip(), "")
                issues = preflight_issues({"packages": [{"name": name}]})
                self.assertEqual(
                    [issue["ruleId"] for issue in issues],
                    ["SPDX-PREFLIGHT-PACKAGE-NAME"],
                )

    def test_non_whitespace_boundary_code_points_are_not_treated_as_blank(self) -> None:
        for code_point in PYTHON313_NON_WHITESPACE_BOUNDARY_CODEPOINTS:
            name = chr(code_point)
            with self.subTest(codepoint=f"U+{code_point:04X}"):
                self.assertNotEqual(name.strip(), "")
                self.assertEqual(preflight_issues({"packages": [{"name": name}]}), [])

    def test_non_object_package_is_rejected(self) -> None:
        issues = preflight_issues({"packages": ["not-an-object"]})
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGE"])

    def test_missing_packages_array_is_rejected(self) -> None:
        issues = preflight_issues({})
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-PACKAGES"])

    def test_non_object_document_is_rejected(self) -> None:
        issues = preflight_issues([])
        self.assertEqual([issue["ruleId"] for issue in issues], ["SPDX-PREFLIGHT-DOCUMENT"])

    def test_unknown_root_property_is_rejected_by_pinned_spdx_23_schema_guard(self) -> None:
        document = {
            "packages": [{"name": "mathlib"}],
            "k7plProbeUnknownProperty": "probe-only",
        }
        issues = preflight_issues(document)
        self.assertEqual(
            [(issue["ruleId"], issue["artifact"]) for issue in issues],
            [("SPDX-PREFLIGHT-UNKNOWN-DOCUMENT-FIELD", "document.k7plProbeUnknownProperty")],
        )

    def test_multiple_preflight_issues_keep_rule_ids_and_paths(self) -> None:
        issues = preflight_issues({
            "packages": [
                {},
                {"name": "  "},
                "not-an-object",
                {"name": "mathlib"},
            ]
        })
        self.assertEqual(
            [(issue["ruleId"], issue["artifact"]) for issue in issues],
            [
                ("SPDX-PREFLIGHT-PACKAGE-NAME", "packages[0].name"),
                ("SPDX-PREFLIGHT-PACKAGE-NAME", "packages[1].name"),
                ("SPDX-PREFLIGHT-PACKAGE", "packages[2]"),
            ],
        )

    def test_cli_rejects_unknown_root_property_before_external_validator(self) -> None:
        document = {
            "packages": [{"name": "mathlib"}],
            "k7plProbeUnknownProperty": "probe-only",
        }
        with TemporaryDirectory() as temporary_directory:
            path = Path(temporary_directory) / "unknown-field.spdx.json"
            path.write_text(json.dumps(document), encoding="utf-8")
            captured = io.StringIO()
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value="/usr/bin/pyspdxtools"),
                patch("validate_spdx.subprocess.run") as external_validator,
                redirect_stdout(captured),
            ):
                exit_code = main(["validate_spdx.py", str(path)])

        report = json.loads(captured.getvalue())
        self.assertEqual(exit_code, 1)
        self.assertEqual(report["status"], "FAIL")
        self.assertEqual(
            [item["ruleId"] for item in report["diagnostics"]],
            ["SPDX-PREFLIGHT-UNKNOWN-DOCUMENT-FIELD"],
        )
        external_validator.assert_not_called()

    def test_cli_rejects_empty_package_name_before_external_validator(self) -> None:
        document = {"packages": [{"name": ""}]}
        with TemporaryDirectory() as temporary_directory:
            path = Path(temporary_directory) / "empty-name.spdx.json"
            path.write_text(json.dumps(document), encoding="utf-8")
            captured = io.StringIO()
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value="/usr/bin/pyspdxtools"),
                patch("validate_spdx.subprocess.run") as external_validator,
                redirect_stdout(captured),
            ):
                exit_code = main(["validate_spdx.py", str(path)])

        report = json.loads(captured.getvalue())
        self.assertEqual(exit_code, 1)
        self.assertEqual(report["status"], "FAIL")
        self.assertIsInstance(report["elapsedMs"], (int, float))
        self.assertIsNone(report["validator"]["elapsedMs"])
        self.assertEqual(
            [item["ruleId"] for item in report["diagnostics"]],
            ["SPDX-PREFLIGHT-PACKAGE-NAME"],
        )
        external_validator.assert_not_called()


class ValidatorDiagnosticsTests(unittest.TestCase):
    def write_document(self, directory: str, payload: object) -> Path:
        path = Path(directory) / "input.spdx.json"
        path.write_text(json.dumps(payload), encoding="utf-8")
        return path

    def test_missing_validator_package_is_an_error(self) -> None:
        with TemporaryDirectory() as directory:
            path = self.write_document(directory, {"packages": [{"name": "mathlib"}]})
            with patch("validate_spdx.version", side_effect=PackageNotFoundError):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("ERROR", 2))
        self.assertEqual(report["diagnostics"][0]["ruleId"], "SPDX-VALIDATOR-MISSING")

    def test_unexpected_validator_version_is_an_error(self) -> None:
        with TemporaryDirectory() as directory:
            path = self.write_document(directory, {"packages": [{"name": "mathlib"}]})
            with (
                patch("validate_spdx.version", return_value="0.8.4"),
                patch("validate_spdx.shutil.which") as executable_lookup,
            ):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("ERROR", 2))
        self.assertEqual(report["diagnostics"][0]["ruleId"], "SPDX-VALIDATOR-VERSION")
        executable_lookup.assert_not_called()

    def test_missing_validator_executable_is_an_error(self) -> None:
        with TemporaryDirectory() as directory:
            path = self.write_document(directory, {"packages": [{"name": "mathlib"}]})
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value=None),
            ):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("ERROR", 2))
        self.assertEqual(report["diagnostics"][0]["ruleId"], "SPDX-VALIDATOR-CLI-MISSING")

    def test_malformed_json_is_an_error(self) -> None:
        with TemporaryDirectory() as directory:
            path = Path(directory) / "broken.spdx.json"
            path.write_text('{"packages": [', encoding="utf-8")
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value="/usr/bin/pyspdxtools"),
            ):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("ERROR", 2))
        self.assertEqual(report["diagnostics"][0]["ruleId"], "SPDX-INPUT-JSON")

    def test_unreadable_input_is_an_error(self) -> None:
        with TemporaryDirectory() as directory:
            path = Path(directory) / "missing.spdx.json"
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value="/usr/bin/pyspdxtools"),
            ):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("ERROR", 2))
        self.assertEqual(report["diagnostics"][0]["ruleId"], "SPDX-INPUT-READ")

    def test_external_validator_failure_is_a_fail_with_diagnostic(self) -> None:
        with TemporaryDirectory() as directory:
            path = self.write_document(directory, {"packages": [{"name": "mathlib"}]})
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value="/usr/bin/pyspdxtools"),
                patch(
                    "validate_spdx.subprocess.run",
                    return_value=SimpleNamespace(returncode=1, stderr="invalid SPDX document", stdout=""),
                ),
            ):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("FAIL", 1))
        self.assertEqual(report["diagnostics"][0]["ruleId"], "SPDX-TOOLS-VALIDATION")
        self.assertIn("invalid SPDX document", report["diagnostics"][0]["message"])

    def test_external_validator_execution_error_is_an_error(self) -> None:
        with TemporaryDirectory() as directory:
            path = self.write_document(directory, {"packages": [{"name": "mathlib"}]})
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value="/usr/bin/pyspdxtools"),
                patch("validate_spdx.subprocess.run", side_effect=OSError("exec failed")),
            ):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("ERROR", 2))
        self.assertEqual(report["diagnostics"][0]["ruleId"], "SPDX-VALIDATOR-EXEC")

    def test_input_change_during_validation_is_an_error(self) -> None:
        with TemporaryDirectory() as directory:
            path = self.write_document(directory, {"packages": [{"name": "mathlib"}]})
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value="/usr/bin/pyspdxtools"),
                patch("validate_spdx.subprocess.run", return_value=SimpleNamespace(returncode=0, stderr="", stdout="")),
                patch("validate_spdx.sha256_file", side_effect=["a" * 64, "b" * 64]),
            ):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("ERROR", 2))
        self.assertEqual(report["diagnostics"][0]["ruleId"], "SPDX-INPUT-CHANGED")

    def test_valid_wrapper_path_preserves_sha_and_report_contract(self) -> None:
        with TemporaryDirectory() as directory:
            path = self.write_document(directory, {"packages": [{"name": "mathlib"}]})
            expected_digest = sha256_file(path)
            with (
                patch("validate_spdx.version", return_value=VALIDATOR_VERSION),
                patch("validate_spdx.shutil.which", return_value="/usr/bin/pyspdxtools"),
                patch("validate_spdx.subprocess.run", return_value=SimpleNamespace(returncode=0, stderr="", stdout="")) as run,
            ):
                report, exit_code = validate(path)

        self.assertEqual((report["status"], exit_code), ("PASS", 0))
        self.assertEqual(report["schemaVersion"], "k7pl.spdx-validation/v1")
        self.assertEqual(report["input"]["sha256"], expected_digest)
        self.assertEqual(report["validator"]["version"], VALIDATOR_VERSION)
        self.assertEqual(report["diagnostics"], [])
        self.assertTrue(
            any("additionalProperties=false" in limitation for limitation in report["limitations"]),
            report["limitations"],
        )
        self.assertTrue(
            any("root-only guard" in limitation for limitation in report["limitations"]),
            report["limitations"],
        )
        run.assert_called_once()
        self.assertEqual(run.call_args.args[0][-3:], [str(path), "--version", "SPDX-2.3"])


class CommandLineDiagnosticsTests(unittest.TestCase):
    def test_usage_error_emits_structured_json_and_exit_code_two(self) -> None:
        captured = io.StringIO()
        with redirect_stdout(captured):
            exit_code = main(["validate_spdx.py"])

        report = json.loads(captured.getvalue())
        self.assertEqual(exit_code, 2)
        self.assertEqual(report["status"], "ERROR")
        self.assertEqual(report["diagnostics"][0]["ruleId"], "USAGE")
        self.assertIsInstance(report["elapsedMs"], (int, float))


if __name__ == "__main__":
    unittest.main()
