#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Repeat the pinned SPDX validator against one fixed input and record descriptive timings."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import statistics
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
VALIDATOR = ROOT / "scripts" / "ci" / "validate_spdx.py"
LOCKFILE = ROOT / "scripts" / "requirements-spdx-validator.txt"
EXPECTED_VALIDATOR_VERSION = "0.8.5"
METRICS = ("processWallMs", "wrapperElapsedMs", "validatorElapsedMs")


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def validate_repetitions(value: int) -> int:
    if value < 2 or value > 25:
        raise ValueError("repetitions must be between 2 and 25")
    return value


def summarize_samples(samples: list[dict[str, Any]]) -> dict[str, dict[str, float]]:
    """Return min/median/max for each timing field; reject incomplete measurements."""
    if len(samples) < 2:
        raise ValueError("at least two samples are required to summarize repeated runs")

    result: dict[str, dict[str, float]] = {}
    for metric in METRICS:
        try:
            values = [float(sample[metric]) for sample in samples]
        except (KeyError, TypeError, ValueError) as error:
            raise ValueError(f"sample data is missing a numeric {metric}") from error
        result[metric] = {
            "minMs": round(min(values), 3),
            "medianMs": round(statistics.median(values), 3),
            "maxMs": round(max(values), 3),
        }
    return result


def workflow_identity() -> dict[str, Any]:
    result: dict[str, Any] = {
        "runId": os.environ.get("GITHUB_RUN_ID"),
        "runAttempt": os.environ.get("GITHUB_RUN_ATTEMPT"),
        "checkedOutSha": os.environ.get("GITHUB_SHA"),
    }
    event_path = os.environ.get("GITHUB_EVENT_PATH")
    if event_path:
        try:
            with open(event_path, encoding="utf-8") as stream:
                event = json.load(stream)
            result["pullRequestHeadSha"] = (
                (event.get("pull_request") or {}).get("head", {}).get("sha")
            )
        except (OSError, json.JSONDecodeError, AttributeError):
            result["pullRequestHeadSha"] = None
    return result


def run_benchmark(input_path: Path, repetitions: int) -> dict[str, Any]:
    repetitions = validate_repetitions(repetitions)
    input_path = input_path.resolve()
    expected_digest = sha256_file(input_path)
    samples: list[dict[str, Any]] = []

    for iteration in range(1, repetitions + 1):
        started_ns = time.perf_counter_ns()
        completed = subprocess.run(
            [sys.executable, str(VALIDATOR), str(input_path)],
            cwd=ROOT,
            check=False,
            capture_output=True,
            text=True,
        )
        process_wall_ms = round((time.perf_counter_ns() - started_ns) / 1_000_000, 3)

        try:
            report = json.loads(completed.stdout)
        except json.JSONDecodeError as error:
            raise RuntimeError(
                f"validator invocation {iteration} did not emit one JSON report: "
                f"stdout={completed.stdout[-1000:]!r} stderr={completed.stderr[-1000:]!r}"
            ) from error

        if completed.returncode != 0 or report.get("status") != "PASS":
            raise RuntimeError(
                f"validator invocation {iteration} failed: exit={completed.returncode}, "
                f"status={report.get('status')!r}, diagnostics={report.get('diagnostics')!r}, "
                f"stderr={completed.stderr[-2000:]!r}"
            )
        if report.get("validator", {}).get("version") != EXPECTED_VALIDATOR_VERSION:
            raise RuntimeError(
                f"unexpected validator version in invocation {iteration}: "
                f"{report.get('validator', {}).get('version')!r}"
            )
        if report.get("input", {}).get("sha256") != expected_digest:
            raise RuntimeError(f"input digest changed in validator report for invocation {iteration}")
        if not isinstance(report.get("elapsedMs"), (int, float)):
            raise RuntimeError(f"wrapper elapsed time is missing in invocation {iteration}")
        validator_ms = report.get("validator", {}).get("elapsedMs")
        if not isinstance(validator_ms, (int, float)):
            raise RuntimeError(f"validator elapsed time is missing in invocation {iteration}")

        samples.append(
            {
                "iteration": iteration,
                "exitCode": completed.returncode,
                "status": report["status"],
                "inputSha256": report["input"]["sha256"],
                "processWallMs": process_wall_ms,
                "wrapperElapsedMs": round(float(report["elapsedMs"]), 3),
                "validatorElapsedMs": round(float(validator_ms), 3),
            }
        )

    final_digest = sha256_file(input_path)
    if final_digest != expected_digest:
        raise RuntimeError("input bytes changed during repeated validation")

    return {
        "schemaVersion": "k7pl.spdx-validation-benchmark/v1",
        "measuredAt": datetime.now(timezone.utc).isoformat(timespec="milliseconds").replace(
            "+00:00", "Z"
        ),
        "method": {
            "repetitions": repetitions,
            "design": (
                "Separate Python CLI invocations against identical input bytes in a single CI job; "
                "the first and subsequent runs share the same runner and filesystem caches."
            ),
        },
        "workflow": workflow_identity(),
        "input": {
            "artifact": input_path.name,
            "sha256": expected_digest,
            "unchangedAcrossSamples": True,
        },
        "validator": {
            "name": "spdx-tools",
            "version": EXPECTED_VALIDATOR_VERSION,
        },
        "environment": {
            "pythonVersion": platform.python_version(),
            "platform": platform.platform(),
        },
        "toolInputs": {
            "validatorScriptSha256": sha256_file(VALIDATOR),
            "requirementsLockSha256": sha256_file(LOCKFILE),
        },
        "samples": samples,
        "summary": summarize_samples(samples),
        "limitations": [
            "This is a small within-run micro-measurement, not a controlled cross-machine benchmark.",
            "Process wall time includes Python startup; wrapper time begins inside validate_spdx.py after imports.",
            "The subprocess metric measures the pyspdxtools invocation only; input reads, hashing, and report serialization are outside that metric.",
            "Repeated runs share one runner and may benefit from warm filesystem caches.",
        ],
    }


def append_step_summary(report: dict[str, Any]) -> None:
    summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
    if not summary_path:
        return
    summary = report["summary"]
    labels = {
        "processWallMs": "Whole CLI process",
        "wrapperElapsedMs": "Validator wrapper",
        "validatorElapsedMs": "pyspdxtools subprocess",
    }
    with open(summary_path, "a", encoding="utf-8") as stream:
        stream.write("### Repeated SPDX validation timing (5 samples)\n")
        stream.write("- Input SHA-256: `" + report["input"]["sha256"] + "`\n")
        for metric, label in labels.items():
            values = summary[metric]
            stream.write(
                "- "
                + label
                + ": min `"
                + str(values["minMs"])
                + " ms`, median `"
                + str(values["medianMs"])
                + " ms`, max `"
                + str(values["maxMs"])
                + " ms`.\n"
            )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="SPDX 2.3 JSON document to validate repeatedly")
    parser.add_argument("--repetitions", type=int, default=5)
    parser.add_argument("--output", type=Path, required=True, help="path for the JSON measurement report")
    args = parser.parse_args(argv)

    try:
        report = run_benchmark(args.input, args.repetitions)
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(
            json.dumps(report, indent=2, sort_keys=True, ensure_ascii=False) + "\n",
            encoding="utf-8",
        )
        append_step_summary(report)
    except (OSError, json.JSONDecodeError, ValueError, RuntimeError) as error:
        print(f"benchmark_spdx_validator.py: {error}", file=sys.stderr)
        return 1

    summary = report["summary"]["validatorElapsedMs"]
    print(
        "Repeated SPDX validation probe: PASS; "
        f"samples={len(report['samples'])}; "
        f"pyspdxtools median={summary['medianMs']} ms "
        f"(min={summary['minMs']} ms, max={summary['maxMs']} ms)"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
