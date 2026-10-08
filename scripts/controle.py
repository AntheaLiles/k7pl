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

from controles import algebre, couverture, croise, indexation, notation, semantique, structure  # noqa: E402
from controles import journal  # noqa: E402
from controles.journal import failures  # noqa: E402


def _lexical_guard() -> None:
    """Reject the three lexical regressions previously observed in Verso sources."""
    import re

    spec_root = Path(__file__).resolve().parent.parent / "spec"
    errors = []
    for path in sorted(spec_root.rglob("*.lean")):
        source = path.read_text(encoding="utf-8")
        if source.count("```") % 2:
            errors.append(f"{path}: odd number of fenced-code delimiters")
        if re.search(r"\$(?:\\`|\\\\`)", source):
            errors.append(f"{path}: legacy Verso math delimiter")
        for match in re.finditer(r"(?<!\$)\#!/usr/bin/env python3
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

from controles import algebre, couverture, croise, indexation, notation, semantique, structure  # noqa: E402
from controles import journal  # noqa: E402
from controles.journal import failures  # noqa: E402


def _lexical_guard() -> None:
    """Reject the three lexical regressions previously observed in Verso sources."""
    import re

    spec_root = Path(__file__).resolve().parent.parent / "spec"
    errors = []
    for path in sorted(spec_root.rglob("*.lean")):
        source = path.read_text(encoding="utf-8")
        if source.count("```") % 2:
            errors.append(f"{path}: odd number of fenced-code delimiters")
        if re.search(r"\$(?:\\`|\\\\`)", source):
            errors.append(f"{path}: legacy Verso math delimiter")
([^`\n]*)`", source):
            if "\\\\" in match.group(1):
                errors.append(f"{path}: double backslash inside inline span")
    for error in errors:
        journal.ko(error)

def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--format", choices=("text", "github"), default="text")
    journal.github = parser.parse_args().format == "github"
    _lexical_guard()
    for module in (structure, algebre, notation, croise, semantique, couverture, indexation):
        name = module.__name__.rsplit(".", 1)[-1]
        journal.group(name)
        module.run()
        journal.endgroup()
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
