#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: Apache-2.0
"""Extract selected K7PL tactic proofs through Paperproof and emit versioned JSON for Verso."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import tempfile
from pathlib import Path
from typing import Any

PAPERPROOF_REVISION = "05c68e9cb8e881f9e971abb94efd231a269e0229"
PAPERPROOF_TOOLCHAIN = "leanprover/lean4:v4.34.0"
SCHEMA_VERSION = "k7pl.proof-visualization/v1"
REPOSITORY_URL = "https://github.com/AntheaLiles/k7pl"
TARGETS = (
    {
        "slug": "eval-double",
        "title": "Conservation sémantique de double",
        "source": "src/K7pl/Arith.lean",
        "declaration": "K7pl.Arith.eval_double",
        "description": "Preuve arithmétique : simplification puis normalisation par ring.",
    },
    {
        "slug": "scale-usage-comp",
        "title": "Composition de Scale_Usage",
        "source": "src/K7pl/UsageScale.lean",
        "declaration": "K7pl.UsageScale.scaleUsage_comp",
        "description": "Analyse de cas sur le grade puis simplification algébrique.",
    },
    {
        "slug": "project-usage-context-scale",
        "title": "Projection d’usage et mise à l’échelle du contexte",
        "source": "src/K7pl/UsageScale.lean",
        "declaration": "K7pl.UsageScale.projectUsageContext_scale",
        "description": "Extensionalité fonctionnelle, puis distinction des cas none/some.",
    },
    {
        "slug": "grade-budget-finite-multiplicity",
        "title": "Compatibilité de la multiplication finie avec la consommation de budget",
        "source": "src/K7pl/GradeBudget.lean",
        "declaration": "K7pl.GradeBudget.finite_multiplicity_compatibility",
        "description": "Preuve par cas imbriqués sur le budget, le coût et la multiplicité, avec hypothèse locale.",
    },
    {
        "slug": "memory-capability-allocate-unique",
        "title": "Préservation de l’unicité des capacités après allocation",
        "source": "src/K7pl/MemoryCapability.lean",
        "declaration": "K7pl.MemoryCapability.allocate_preserves_unique",
        "description": "Preuve avec by_cases, subst, hypothèses locales, simp et omega.",
    },
)


def as_dict(value: Any, where: str) -> dict[str, Any]:
    if not isinstance(value, dict):
        raise ValueError(f"{where} must be an object")
    return value


def validate_export(value: Any) -> dict[str, Any]:
    data = as_dict(value, "Paperproof export")
    if not isinstance(data.get("steps"), list) or not data["steps"]:
        raise ValueError("Paperproof export has no tactic steps; refusing to claim a visualization")
    if not isinstance(data.get("allGoals"), list):
        raise ValueError("Paperproof export is missing allGoals")
    for index, value in enumerate(data["steps"]):
        step = as_dict(value, f"steps[{index}]")
        if not isinstance(step.get("tacticString"), str) or not step["tacticString"].strip():
            raise ValueError(f"steps[{index}] has no tacticString")
        as_dict(step.get("goalBefore"), f"steps[{index}].goalBefore")
        for field in ("goalsAfter", "spawnedGoals"):
            if not isinstance(step.get(field), list):
                raise ValueError(f"steps[{index}].{field} must be an array")
        dependencies = step.get("tacticDependsOn")
        if not isinstance(dependencies, list):
            raise ValueError(f"steps[{index}].tacticDependsOn must be an array")
        for dependency_index, dependency in enumerate(dependencies):
            if not isinstance(dependency, str) or not dependency.strip():
                raise ValueError(
                    f"steps[{index}].tacticDependsOn[{dependency_index}] must be a non-empty string identifier"
                )
        position = as_dict(step.get("position"), f"steps[{index}].position")
        for end in ("start", "stop"):
            point = as_dict(position.get(end), f"steps[{index}].position.{end}")
            for coordinate in ("line", "character"):
                if type(point.get(coordinate)) is not int or point[coordinate] < 0:
                    raise ValueError(f"steps[{index}].position.{end}.{coordinate} must be a nonnegative integer")
        start, stop = position["start"], position["stop"]
        if (stop["line"], stop["character"]) < (start["line"], start["character"]):
            raise ValueError(f"steps[{index}].position has a stop before its start")
    return data


def declaration_line(source: str, name: str) -> int:
    short = re.escape(name.rsplit(".", 1)[-1])
    pattern = re.compile(r"^\s*(?:(?:private|protected|noncomputable)\s+)*(?:theorem|lemma)\s+" + short + r"\b")
    lines = [index for index, line in enumerate(source.splitlines(), 1) if pattern.search(line)]
    if len(lines) != 1:
        raise ValueError(f"expected one declaration for {name}, found {lines}")
    return lines[0]


def build_artifact(target: dict[str, str], export_value: Any, source: str, revision: str,
                   main_toolchain: str, source_bytes: bytes | None = None) -> dict[str, Any]:
    export = validate_export(export_value)
    start = declaration_line(source, target["declaration"])
    source_line_count = len(source.splitlines())
    step_ends = []
    for index, step in enumerate(export["steps"]):
        position = step["position"]
        start_line = position["start"]["line"] + 1
        stop_line = position["stop"]["line"] + 1
        if start_line < start or stop_line > source_line_count:
            raise ValueError(
                f"steps[{index}] position lines {start_line}-{stop_line} fall outside "
                f"the source span (declaration starts at {start}, file has {source_line_count} lines)"
            )
        step_ends.append(stop_line)
    end = max([start, *step_ends])
    source_url = f"{REPOSITORY_URL}/blob/{revision}/{target['source']}#L{start}-L{end}"
    goals = sorted(export["allGoals"], key=lambda item: str(item.get("id", "")) if isinstance(item, dict) else str(item))
    return {
        "schemaVersion": SCHEMA_VERSION,
        "status": "extracted",
        "slug": target["slug"],
        "identity": {
            "declaration": target["declaration"], "source": target["source"],
            "sourceRevision": revision, "declarationLine": start,
            "sourceLines": {"start": start, "end": end}, "sourceUrl": source_url,
            "sourceSha256": hashlib.sha256(source_bytes if source_bytes is not None else source.encode("utf-8")).hexdigest(),
        },
        "editorial": {"title": target["title"], "description": target["description"]},
        "provenance": {
            "extractor": "Paperproof terminal export",
            "paperproofRevision": PAPERPROOF_REVISION,
            "paperproofToolchain": PAPERPROOF_TOOLCHAIN,
            "k7plMainToolchain": main_toolchain,
            "generatedFromExactRevision": revision,
        },
        "guarantees": {
            "paperproofProducedTacticObservations": True,
            "k7plMainToolchainVerifiedByThisArtifact": False,
            "semanticCorrespondenceToNormativeSpecificationEstablished": False,
            "proofAuthority": "Lean kernel checking is independent of this visualization artifact.",
        },
        "limits": [
            "The extractor runs under a separate Lean toolchain; this artifact does not replace the K7PL Lean 4.34.0 build.",
            "Paperproof reports observed tactic goals and hypotheses, not a universal representation of all Lean proof forms.",
            "This curated target list is not an exhaustive inventory of declarations.",
            "No normative specification-to-declaration correspondence is inferred.",
            "A missing after-goal association means it was not reported for this transition, not that no goal ever existed.",
        ],
        "extracted": {"steps": export["steps"], "allGoals": goals},
    }


def extract_one(root: Path, extractor: Path, target: dict[str, str], revision: str,
                main_toolchain: str, output_root: Path) -> dict[str, Any]:
    source_path = root / target["source"]
    source_bytes = source_path.read_bytes()
    source = source_bytes.decode("utf-8")
    raw_path = output_root / f".{target['slug']}.paperproof.json"

    # Paperproof's Lean frontend rejects source paths outside its Lake workspace.
    # Stage an exact text copy inside that workspace; source links and provenance
    # continue to refer to the canonical repository file, never to this temporary copy.
    raw_path.unlink(missing_ok=True)
    with tempfile.TemporaryDirectory(prefix="k7pl-proof-source-", dir=extractor) as staging_dir:
        staged_path = Path(staging_dir) / source_path.name
        staged_path.write_bytes(source_bytes)
        command = ["lake", "exe", "terminal", str(staged_path.resolve()),
                   target["declaration"], str(raw_path.resolve())]
        try:
            result = subprocess.run(command, cwd=extractor, text=True, capture_output=True, check=False)
            if result.returncode or not raw_path.is_file():
                raise RuntimeError(
                    f"Paperproof extraction failed for {target['declaration']} (exit {result.returncode}).\n"
                    f"stdout:\n{result.stdout}\nstderr:\n{result.stderr}")
            raw = json.loads(raw_path.read_text(encoding="utf-8"))
            return build_artifact(target, raw, source, revision, main_toolchain, source_bytes)
        finally:
            raw_path.unlink(missing_ok=True)


def validate_lock(extractor: Path) -> None:
    toolchain = (extractor / "lean-toolchain").read_text(encoding="utf-8").strip()
    if toolchain != PAPERPROOF_TOOLCHAIN:
        raise ValueError(f"Paperproof toolchain drift: expected {PAPERPROOF_TOOLCHAIN}, got {toolchain}")
    lock = json.loads((extractor / "lake-manifest.json").read_text(encoding="utf-8"))
    packages = {item["name"]: item for item in lock.get("packages", [])}
    pp = packages.get("Paperproof", {})
    mathlib = packages.get("mathlib", {})
    if pp.get("rev") != PAPERPROOF_REVISION or pp.get("subDir") != "lean":
        raise ValueError("Paperproof must remain pinned to the reviewed commit and lean subdirectory")
    if mathlib.get("inputRev") != "v4.34.0":
        raise ValueError("the isolated Paperproof workspace must use Mathlib v4.34.0")


def validate_checkout_revision(root: Path, revision: str) -> None:
    """Refuse provenance labels that do not identify the exact checked-out source tree."""
    if not re.fullmatch(r"[0-9a-f]{40}", revision):
        raise ValueError("--ref must be a full, lowercase 40-character Git commit SHA")
    result = subprocess.run(
        ["git", "rev-parse", "HEAD"], cwd=root, text=True, capture_output=True, check=False
    )
    if result.returncode:
        raise RuntimeError(f"Unable to resolve the checked-out Git revision: {result.stderr.strip()}")
    checkout_revision = result.stdout.strip()
    if checkout_revision != revision:
        raise ValueError(
            f"Source revision mismatch: --ref is {revision}, but the checked-out HEAD is {checkout_revision}"
        )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-root", type=Path, default=Path("."))
    parser.add_argument("--data-dir", type=Path, default=Path("_out/proof-visualizations/data"))
    parser.add_argument("--ref", required=True, help="full Git commit SHA matching the checked-out source tree")
    parser.add_argument("--extractor-dir", type=Path, default=Path("tooling/paperproof-export"))
    parser.add_argument("--main-toolchain", default="leanprover/lean4:v4.34.0")
    args = parser.parse_args()

    root = args.repo_root.resolve()
    extractor = (root / args.extractor_dir).resolve()
    data_dir = (root / args.data_dir).resolve()
    validate_checkout_revision(root, args.ref)
    validate_lock(extractor)
    data_dir.mkdir(parents=True, exist_ok=True)

    artifacts = [
        extract_one(root, extractor, target, args.ref, args.main_toolchain, data_dir)
        for target in TARGETS
    ]
    for artifact in artifacts:
        slug = artifact["slug"]
        (data_dir / f"{slug}.json").write_text(
            json.dumps(artifact, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )

    manifest = {
        "schemaVersion": SCHEMA_VERSION,
        "sourceRevision": args.ref,
        "mainToolchain": args.main_toolchain,
        "extractorToolchain": PAPERPROOF_TOOLCHAIN,
        "paperproofRevision": PAPERPROOF_REVISION,
        "declarations": [item["identity"]["declaration"] for item in artifacts],
        "limits": [
            "Curated tactic proofs only",
            "No inferred normative correspondence",
            "JSON contains observations, not proof evidence",
        ],
    }
    (data_dir / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )

    print(f"Generated {len(artifacts)} proof data artifacts for {args.ref}")
    for artifact in artifacts:
        print(
            f"  {artifact['identity']['declaration']}: "
            f"{len(artifact['extracted']['steps'])} tactic observations"
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
