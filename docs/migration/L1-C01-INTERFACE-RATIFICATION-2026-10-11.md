<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Décision d’autrice C-01 — interfaces de référence

**Date :** 11 octobre 2026  
**Portée :** C-01/C-02 ; porte C non satisfaite

## Décision

L’autrice confirme que les signatures de `π_U`, `Bang_𝒢` et `Scale_Usage` sont retenues comme interfaces de référence. L’alternative consistant à maintenir ces interfaces au rang de simples candidates n’est pas retenue.

Les signatures de référence sont :

- `π_U : 𝒢 → 𝓡`, projection de `⟨u,m,ℓ,β⟩` vers `u` ;
- `Bang_𝒢(r,A) := !_{π_U(r)} A`, raccourci d’indexation de l’exponentielle par la composante d’usage ;
- `Scale_Usage : 𝓡 × 𝒢 → 𝒢`, avec `Scale_Usage(a,⟨u,m,ℓ,β⟩) = ⟨a·u,m,ℓ,β⟩`.

L’action de `Scale_Usage` modifie uniquement la composante d’usage. Elle ne met à l’échelle ni le mode, ni le niveau, ni le budget. Son extension aux contextes est définie seulement lorsque les liaisons, les types et l’agrégation du contexte sont compatibles.

## Obligations qui restent ouvertes

La décision sur les signatures n’est pas une preuve des lois attendues. Il reste à :

1. normaliser les déclarations, les domaines, les hypothèses de définissabilité et les noms dans les registres et les sources normatives ciblées ;
2. démontrer les lois d’identité, de composition, d’additivité et de monotonie de `Scale_Usage`, sous les hypothèses algébriques effectivement retenues ;
3. établir la compatibilité de `π_U` et `Bang_𝒢` avec `coerce`, `w` et `c`, puis prouver l’identité, la composition, la naturalité et la compatibilité avec les règles de typage ;
4. traiter les cas `Box`, `App`, `SubBox`, la substitution et l’extension de l’action aux contextes typés ;
5. créer ou identifier les déclarations et théorèmes Lean correspondants et vérifier effectivement les preuves. Une preuve sur papier, une esquisse, un test documentaire ou une compilation Verso ne constitue pas une preuve Lean.

Les preuves restent conditionnées par les signatures précises et les structures nécessaires, dont le semi-anneau `𝓡`, les porteurs `𝕄` et `ℒ`, les conditions d’addition de contextes et le contrat de l’exponentielle indexée. Toute hypothèse requise doit être explicite ; aucune loi ne doit être déclarée établie par simple ratification de l’interface.

## Sources et frontières

- [Registre des objets théoriques](L1-THEORY-OBJECTS.md)
- [Audit typé C-01/C-02 du 11 octobre 2026](L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md)
- Source C2 : `spec/Spec/C2/ComonadeExponentielleEtFragments.lean`

C2 affiche encore ces interfaces avec un statut de candidates. Cette source n’a pas été modifiée par la présente décision : les registres documentent le statut architectural ratifié, et une modification normative distincte devra harmoniser les déclarations source après vérification des domaines et préconditions. Ne pas présenter le statut historique du fichier comme une absence de décision humaine, ni la décision humaine comme une preuve ou une normalisation déjà exécutée.

La décision ne tranche pas le contrat exact des morphismes de modes, la totalité ou la partialité de `Cost_Budget`, les domaines complets de `ψ` et `Consume`, la correction des ressources à l’exécution, ni la clôture de C-01/C-02. La porte C reste **NON SATISFAITE**.
