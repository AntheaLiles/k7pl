#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1
"""Extract explicitly marked fenced code blocks from the Verso source page."""

from __future__ import annotations
import re
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "spec/Spec/CodeArtifacts.lean"
GENERATED_PREFIX = "src/k/.build/generated/"
FENCE = re.compile(
    r"(?m)^EXTRACT: ([^\r\n]+)\r?\n```(k|python)\r?\n(.*?)^```\s*$",
    re.DOTALL,
)

def main() -> int:
    try:
        source = SOURCE.read_text(encoding="utf-8")
    except OSError as error:
        print(f"Cannot read Verso source {SOURCE}: {error}", file=sys.stderr)
        return 2
    artifacts: dict[str, str] = {}
    for match in FENCE.finditer(source):
        target, language, code = match.groups()
        path = Path(target)
        if (
            not target.startswith(GENERATED_PREFIX)
            or path.is_absolute()
            or "\\" in target
            or any(part in ("", ".", "..") for part in target.split("/"))
            or (language == "k" and path.suffix != ".k")
            or (language == "python" and path.suffix != ".py")
        ):
            print(f"Refusing unsafe or unsupported artifact target: {target!r}", file=sys.stderr)
            return 2
        if target in artifacts:
            print(f"Duplicate artifact target: {target}", file=sys.stderr)
            return 2
        artifacts[target] = code if code.endswith("\n") else code + "\n"
    if not artifacts:
        print(f"No marked code blocks found in {SOURCE}", file=sys.stderr)
        return 1
    generated_dir = ROOT / GENERATED_PREFIX
    if generated_dir.exists():
        shutil.rmtree(generated_dir)
    for target, contents in artifacts.items():
        destination = ROOT / target
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(contents, encoding="utf-8")
    print(f"Extracted {len(artifacts)} artifact(s) from {SOURCE.relative_to(ROOT)}")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
