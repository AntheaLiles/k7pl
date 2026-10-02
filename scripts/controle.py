#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Runs every check on the specification (reads `spec/`, read-only). Exit code 1 if any fails.

    python3 scripts/controle.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from controles import algebre, croise, notation, structure  # noqa: E402
from controles.journal import failures  # noqa: E402


def main() -> int:
    for module in (structure, algebre, notation, croise):
        module.run()
    print()
    if failures:
        print("%d ECHEC(S)" % len(failures))
        return 1
    print("TOUS LES CONTROLES PASSENT")
    return 0


if __name__ == "__main__":
    sys.exit(main())
