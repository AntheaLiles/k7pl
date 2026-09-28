-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import VersoManual
import K7pl.Arith

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean

#doc (Manual) "Expressions arithmétiques" =>

Une _expression_ est un littéral entier, une somme ou un produit.
Sa valeur est donnée par la fonction {lean}`K7pl.Arith.Expr.eval`.

Le bloc suivant est vérifié par Lean à chaque compilation de la spécification :
si l'implémentation change de comportement, la spécification ne compile plus.

```lean
example : (K7pl.Arith.Expr.add (.lit 2) (.lit 3)).eval = 5 := rfl
```

# Doublement

La fonction {lean}`K7pl.Arith.double` construit une expression qui vaut deux fois la valeur de son argument, sans multiplication.
