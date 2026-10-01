# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""The log of verdicts, shared by every check (one list, in a module that is never an entry point)."""

failures: list[str] = []


def ko(message: str) -> None:
    """Records and prints a failure; the exit code follows from the list."""
    failures.append(message)
    print("    ECHEC  " + message)


def ok(message: str) -> None:
    """Prints a favourable verdict."""
    print("    ok     " + message)
