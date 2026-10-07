-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import SpecExt.IndexCore

/-!
# The terms of the index

The index lists what the document _treats_ in several distinct places, not what it merely mentions
(the rule of ISO 999, which the Org manuscript applied : a concept treated once is found by the table
of contents, a word present everywhere is not looked up). The thirty-one terms are those of the
manuscript, unchanged. Each is recognised in the text with an optional plural mark, ignoring case
and accents (`SpecExt.IndexCore`).
-/

namespace SpecExt

/-- The terms of the index, in the order of the manuscript. -/
def indexTerms : Array IndexCore.Entry :=
  #["terminaison", "productivité", "progression", "préservation du typage", "substitution",
    "cohérence de la subsomption", "confidentialité", "intégrité", "effacement de phase",
    "inférence de type", "vérification bidirectionnelle", "principalité", "décidabilité",
    "unification", "amortissement", "analyse de coût", "borne de temps d'exécution",
    "partage en lecture", "emprunt", "réplication", "convergence", "absence de blocage",
    "acyclicité", "localité", "atomicité", "ordonnancement", "reprise après panne",
    "compilation séparée", "édition de liens", "mécanisation", "differential testing"].map
    fun term => { term }

end SpecExt
