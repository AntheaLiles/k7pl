# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""The log of verdicts, shared by every check (one list, in a module that is never an entry point)."""

from __future__ import annotations

from dataclasses import dataclass
import re

failures: list[str] = []
github: bool = False  # GitHub Actions output: failures become annotations


_LOCATION = re.compile(r"(?<![\w.])([A-Za-z][\w]*(?:\.[A-Za-z][\w]*)*)\s*:\s*(\d+)")


@dataclass(frozen=True)
class Location:
    """A repository source position accepted by a GitHub annotation."""

    path: str
    line: int
    column: int | None = None
    end_line: int | None = None
    end_column: int | None = None


def group(title: str) -> None:
    """Opens a collapsible log group (GitHub format only)."""
    if github:
        print("::group::" + title)


def endgroup() -> None:
    """Closes the current log group (GitHub format only)."""
    if github:
        print("::endgroup::")


def _escape(value: str) -> str:
    """Escapes workflow-command data (percent, CR and LF)."""
    return value.replace("%", "%25").replace("\r", "%0D").replace("\n", "%0A")


def _property(value: str) -> str:
    """Escapes a workflow-command property value."""
    return _escape(value).replace(",", "%2C")


def _infer_locations(message: str) -> list[Location]:
    """Recover source positions already embedded in control messages, such as C2.Foo:42."""
    try:
        from . import corpus
    except ImportError:
        return []

    try:
        module_names = {name for name, _, _ in corpus.modules()}
    except Exception:
        return []

    locations: list[Location] = []
    seen: set[tuple[str, int]] = set()
    for match in _LOCATION.finditer(message):
        module, line_text = match.groups()
        if module not in module_names:
            continue
        try:
            path = corpus.module_path(module)
        except (KeyError, AttributeError):
            continue
        location = Location(path=path, line=int(line_text))
        key = (location.path, location.line)
        if key not in seen:
            locations.append(location)
            seen.add(key)
    return locations


def _emit_error(message: str, location: Location | None = None) -> None:
    """Emit a global or source-anchored GitHub error annotation."""
    if not github:
        return
    if location is None:
        print("::error title=controle.py::" + _escape(message))
        return

    fields = [
        "file=" + _property(location.path),
        "line=" + str(location.line),
        "title=controle.py",
    ]
    if location.column is not None:
        fields.insert(2, "col=" + str(location.column))
    if location.end_line is not None:
        fields.append("endLine=" + str(location.end_line))
    if location.end_column is not None:
        fields.append("endColumn=" + str(location.end_column))
    print("::error " + ",".join(fields) + "::" + _escape(message))


def ko(
    message: str,
    path: str | None = None,
    line: int | None = None,
    col: int | None = None,
    end_line: int | None = None,
    end_column: int | None = None,
) -> None:
    """Records a failure and anchors it to a source location when one is known."""
    failures.append(message)
    print("    ECHEC  " + message)
    if not github:
        return

    if path is not None and line is not None:
        _emit_error(
            message,
            Location(
                path=path,
                line=line,
                column=col,
                end_line=end_line,
                end_column=end_column,
            ),
        )
        return

    locations = _infer_locations(message)
    if locations:
        for location in locations[:10]:
            _emit_error(message, location)
        return

    _emit_error(message)


def ok(message: str) -> None:
    """Prints a favourable verdict."""
    print("    ok     " + message)
