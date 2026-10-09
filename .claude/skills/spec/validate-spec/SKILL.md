<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

---
name: validate-spec
description: Valider mécaniquement la spécification Verso et ses artefacts dérivés.
---

# Validation Verso

Exécuter selon le changement :

```
lake build Spec
lake exe spec --output _out/spec --with-tex
python3 scripts/controle.py
```

Ajouter `python3 scripts/suivi.py all` lorsque les fiches de suivi ont changé.

Vérifier également labels, références, bibliographie, figures et liens pertinents.

Rapporter séparément :

- compilation ;
- validation sémantique ;
- rendu ;
- suivi.

Un rendu réussi ne prouve pas la validité conceptuelle du manuscrit.
