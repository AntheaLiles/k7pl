-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import VersoManual
import SpecExt
import SpecExt.CodeArtifacts

open Verso.Genre Manual
open SpecExt
open SpecExt.CodeArtifacts

#doc (Manual) "Artefacts exécutables expérimentaux" =>
%%%
number := false
tag := "experimental-code-artifacts"
%%%

Les définitions K du projet résident dans le dossier `lexicon/` : `lexicon/lexemes/` pour les
lemmes, mots primitifs du langage, `lexicon/syntax/` pour les règles de structure et le sucre
syntaxique. Chaque bloc K de ce document affiche l'un de ces fichiers, lu à l'élaboration ; le
fichier en est l'unique copie et la source éditable. Les blocs K de sémantique du sous-langage K7PL
ci-dessous sont la source éditable normative pour ce sous-langage expérimental, répartie entre ses
lemmes et le module qui les compose. Le modèle K7OS séparé est explicitement non normatif : il
explore une hypothèse de profil sans l'imposer au langage. Le script Python est un outil de
vérification et n'est pas normatif ; il est extrait dans `src/k/.build/generated/`, fichier généré,
ignoré par Git, qui ne doit pas être modifié directement. La grammaire des couches et les inclusions
qu'elle refuse sont affichées au chapitre 5 (§{num "sec:c5-s-expressions-universelles"}[]).

La commande `lake exe spec --extract-code-only` effectue uniquement l'extraction, sans produire
le site ; elle vérifie aussi que chaque fichier K de `lexicon/` est affiché par un bloc K.
`make k-check` compile la sémantique du sous-langage et exécute ses exemples.
`make boundary-check` compile séparément le modèle K7OS et vérifie ses trois résultats.
`make layers-check` compile la grammaire des couches et vérifie les listings de ce document.
L'affichage ne valide pas le code : les compilateurs et tests restent responsables
de vérifier les fichiers.

# Définition K expérimentale

Le sous-langage compte quatre lemmes : les littéraux entiers et booléens, `+`, `<` et `select`.

```K (file := "lexicon/lexemes/literals.k")
```

```K (file := "lexicon/lexemes/add.k")
```

```K (file := "lexicon/lexemes/lt.k")
```

```K (file := "lexicon/lexemes/select.k")
```

Le module `LEXICON` compose ces lemmes en une définition exécutable.

```K (file := "lexicon/lexicon.k")
```

# Lecture des textes par couches

Le lecteur voit un texte comme une suite d'expressions ; sa syntaxe lexicale est tenue à part du
module des règles. Le module `REFUSALS` rend, pour chaque inclusion refusée, son code et son message,
ceux de l'annexe {num "sec:annexe-a-codes"}[].

```K (file := "lexicon/syntax/reader.k")
```

```K (file := "lexicon/syntax/tokens.k")
```

```K (file := "lexicon/syntax/refusals.k")
```

# Modèle d'exécution K7OS : frontière native (profil non normatif)

Ce bloc est un modèle d'exploration du système envisagé, pas une règle du langage K7PL.
Le booléen passé à nativeWrite représente uniquement l'hypothèse abstraite d'une frontière
appliquée. Il ne modélise ni une MMU, ni un IOMMU, ni une isolation matérielle particulière.

```K (file := "lexicon/models/native-boundary.k")
```

# Script Python de vérification des exemples

Ce script exécute krun sur les programmes maintenus sous tests/examples/ et vérifie leurs
résultats attendus. Il est lui aussi généré depuis Verso : il ne constitue pas une seconde source
à maintenir dans le dépôt.

```pythonScript (file := "src/k/.build/generated/check_k_examples.py")
#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CECILL-2.1
"""Run the experimental K7PL example corpus and check expected results."""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

EXPECTED_OUTPUTS = {
    "add.k7": "6",
    "select.k7": "3",
}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--definition", required=True, type=Path)
    parser.add_argument("--examples", required=True, type=Path)
    parser.add_argument("--krun", default="krun")
    args = parser.parse_args()

    failures = 0
    for filename, expected in EXPECTED_OUTPUTS.items():
        program = args.examples / filename
        try:
            result = subprocess.run(
                [args.krun, "--definition", str(args.definition), str(program)],
                check=False,
                capture_output=True,
                text=True,
            )
        except OSError as error:
            print(f"Unable to execute {args.krun!r}: {error}", file=sys.stderr)
            return 2

        if result.stdout:
            print(result.stdout, end="" if result.stdout.endswith("\n") else "\n")
        if result.stderr:
            print(result.stderr, file=sys.stderr, end="" if result.stderr.endswith("\n") else "\n")

        if result.returncode != 0:
            print(
                f"{filename}: krun exited with status {result.returncode}",
                file=sys.stderr,
            )
            failures += 1
            continue

        if re.search(rf"(?<![0-9]){re.escape(expected)}(?![0-9])", result.stdout) is None:
            print(
                f"{filename}: expected output containing the integer {expected}",
                file=sys.stderr,
            )
            failures += 1

    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
```
