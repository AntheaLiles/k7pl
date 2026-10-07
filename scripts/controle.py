#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Runs every check on the specification (reads `spec/`, read-only). Exit code 1 if any fails.

    python3 scripts/controle.py [--format {text,github}]

The `github` format emits one log group per check, an `::error::` annotation per failure and a
summary in `$GITHUB_STEP_SUMMARY`.
"""

import argparse
import os
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from controles import algebre, croise, journal, notation, semantique, singularites, structure  # noqa: E402
from controles.journal import failures  # noqa: E402


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--format", choices=("text", "github"), default="text")
    journal.github = parser.parse_args().format == "github"
    for module in (structure, algebre, notation, croise, semantique, singularites):
        name = module.__name__.rsplit(".", 1)[-1]
        before = len(failures)
        journal.group(name)
        module.run()
        journal.endgroup()
        if journal.github and len(failures) > before:
            print("::error title=controle.py::%d échec(s) dans le contrôle « %s »" % (len(failures) - before, name))
    print()
    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a", encoding="utf-8") as out:
            if failures:
                out.write("### Contrôles du Verso : %d échec(s)\n\n" % len(failures))
                out.writelines("- %s\n" % f for f in failures)
            else:
                out.write("### Contrôles du Verso : tous passent\n")
    if failures:
        print("%d ECHEC(S)" % len(failures))
        return 1
    print("TOUS LES CONTROLES PASSENT")
    return 0


if __name__ == "__main__":
    sys.exit(main())
