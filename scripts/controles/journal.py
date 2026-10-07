# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""The log of verdicts, shared by every check (one list, in a module that is never an entry point)."""

failures: list[str] = []
github: bool = False  # GitHub Actions output: failures become `::error::` annotations


def group(title: str) -> None:
    """Opens a collapsible log group (GitHub format only)."""
    if github:
        print("::group::" + title)


def endgroup() -> None:
    """Closes the current log group (GitHub format only)."""
    if github:
        print("::endgroup::")


def _escape(message: str) -> str:
    """Escapes a message for a GitHub workflow command (`%`, CR and LF are significant)."""
    return message.replace("%", "%25").replace("\r", "%0D").replace("\n", "%0A")


def ko(message: str) -> None:
    """Records and prints a failure; the exit code follows from the list."""
    failures.append(message)
    print("    ECHEC  " + message)
    if github:
        print("::error title=controle.py::" + _escape(message))


def ok(message: str) -> None:
    """Prints a favourable verdict."""
    print("    ok     " + message)
