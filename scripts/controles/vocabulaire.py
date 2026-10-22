# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Enforce the specification's prohibited French lexical-family policy.

This is a token-level check over authored textual sources, not a substring search:
unrelated words such as "violet" are not matched.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
SPEC_ROOT = REPOSITORY_ROOT / "spec"

TEXT_SUFFIXES = {
    ".csv",
    ".drawio",
    ".json",
    ".k7",
    ".lean",
    ".markdown",
    ".md",
    ".mermaid",
    ".mmd",
    ".svg",
    ".tex",
    ".txt",
    ".xml",
    ".yaml",
    ".yml",
}

# Inflections and established derivatives of the prohibited French lexical family.
# Do not broaden this to \\bviol\\w*\\b: that would incorrectly match words such as
# "violet", whose spelling overlaps but whose lexeme is unrelated.
FORBIDDEN_LEXEME = re.compile(
    r"\b(?:"
    r"viol(?:s|er|e|es|ent|ons|ez|ais|ait|ions|iez|aient|ai|as|a|âmes|âtes|èrent|"
    r"erai|eras|era|erons|erez|eront|erais|erait|erions|eriez|eraient|asse|asses|ât|"
    r"assions|assiez|assent|ant|é|ée|és|ées)?"
    r"|violation(?:s)?"
    r"|violence(?:s)?"
    r"|violent(?:e|es|s|ement)?"
    r"|violemment"
    r"|violateur(?:s)?"
    r"|violatrice(?:s)?"
    r"|violable(?:s)?"
    r"|violabilité(?:s)?"
    r"|inviolable(?:s)?"
    r"|inviolabilité(?:s)?"
    r"|inviolablement"
    r")\b",
    re.IGNORECASE,
)


@dataclass(frozen=True)
class Finding:
    """A prohibited lexical occurrence and its 1-based source coordinates."""

    path: Path
    term: str
    line: int
    column: int


def source_files(root: Path | None = None) -> list[Path]:
    """Return authored textual sources under the specification tree."""
    spec_root = root if root is not None else SPEC_ROOT
    if not spec_root.is_dir():
        return []
    return sorted(
        path for path in spec_root.rglob("*")
        if path.is_file() and path.suffix.lower() in TEXT_SUFFIXES
    )


def find_forbidden_terms(text: str, path: Path = Path("<memory>")) -> list[Finding]:
    """Find lexical-family matches, preserving line and column coordinates."""
    findings = []
    for match in FORBIDDEN_LEXEME.finditer(text):
        line = text.count("\n", 0, match.start()) + 1
        previous_newline = text.rfind("\n", 0, match.start())
        column = match.start() - previous_newline
        findings.append(Finding(path=path, term=match.group(0), line=line, column=column))
    return findings


def scan(root: Path | None = None) -> list[Finding]:
    """Scan authored textual sources under the supplied or canonical spec directory."""
    findings = []
    for path in source_files(root):
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            # A source with a text suffix must be UTF-8; do not silently skip it.
            findings.append(Finding(path=path, term="<invalid UTF-8>", line=1, column=1))
            continue
        findings.extend(find_forbidden_terms(text, path))
    return findings


def run() -> None:
    """Emit source-anchored CI diagnostics for every prohibited occurrence."""
    files = source_files()
    if not SPEC_ROOT.is_dir():
        from .journal import ko

        ko(f"specification directory not found: {SPEC_ROOT}")
        return

    findings = scan()
    from .journal import ko, ok

    if findings:
        for finding in findings:
            path = finding.path.relative_to(REPOSITORY_ROOT).as_posix()
            ko(
                f"prohibited lexical form {finding.term!r}",
                path=path,
                line=finding.line,
                col=finding.column,
                end_line=finding.line,
                end_column=finding.column + len(finding.term),
            )
    else:
        ok(f"vocabulary policy: no prohibited forms in {len(files)} authored source files")
