<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Decision d'autrice C-01 — interfaces de reference

**Date :** 11 octobre 2026  
**Portee :** C-01/C-02 ; porte C non satisfaite

## Decision

L'autrice confirme que les signatures de `pi_U`, `Bang_G` et `Scale_Usage` sont retenues comme interfaces de reference. L'alternative consistant a maintenir ces interfaces au rang de simples candidates n'est pas retenue.

Les signatures de reference sont :

- `pi_U : G -> R`, projection de `<u,m,l,beta>` vers `u` ;
- `Bang_G(r,A) := !_{pi_U(r)} A`, raccourci d'indexation de l'exponentielle par la composante d'usage ;
- `Scale_Usage : R x G -> G`, avec `Scale_Usage(a,<u,m,l,beta>) = <a*u,m,l,beta>`.

La notation ci-dessus est une transcription lisible ; les sources doivent conserver leurs glyphes et conventions typographiques canoniques. L'action Scale_Usage modifie uniquement la composante d'usage. Elle ne met pas a l'echelle le mode, le niveau ou le budget. Son extension aux contextes est definie seulement lorsque les liaisons, les types et l'agregation de contexte sont compatibles.

## Obligations qui restent ouvertes

La decision de signature n'est pas une preuve des lois attendues. Il reste a :

1. normaliser les declarations, les domaines, les hypotheses de definissabilite et les noms dans les registres et dans les sources normatives ciblees ;
2. demontrer les lois d'identite, composition, additivite et monotonie de Scale_Usage sous les hypotheses algebriques effectivement retenues ;
3. etablir la compatibilite de pi_U et Bang_G avec coerce, w et c, et prouver identite, composition, naturalite et compatibilite avec les regles de typage ;
4. traiter les cas Box, App, SubBox, substitution et extension de l'action aux contextes types ;
5. creer ou identifier les declarations et theoremes Lean correspondants et verifier effectivement les preuves. Une preuve papier, une esquisse, un test documentaire ou une compilation Verso ne constitue pas une preuve Lean.

Les preuves restent conditionnees par les signatures precises et les structures necessaires, dont le semi-anneau R, les porteurs M et L, les conditions d'addition de contextes et le contrat de l'exponentielle indexee. Toute hypothese requise doit etre explicite ; aucune loi ne doit etre declaree etablie par simple ratification de l'interface.

## Sources et frontieres

- [Registre des objets theoriques](L1-THEORY-OBJECTS.md)
- [Audit typé C-01/C-02 du 11 octobre 2026](L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md)
- Source C2 : `spec/Spec/C2/ComonadeExponentielleEtFragments.lean`

C2 affiche encore ces interfaces avec un statut candidat. Cette source n'a pas ete modifiee par la presente decision : les registres documentent le statut architectural ratifie, et une modification normative distincte devra harmoniser les declarations source apres verification des domaines et preconditions. Ne pas presenter le statut historique du fichier comme une absence de decision humaine, ni la decision humaine comme une preuve ou une normalisation deja executee.

La decision ne tranche pas le contrat exact des morphismes de modes, la totalite ou partialite de Cost_Budget, les domaines complets de psi et Consume, la correction de ressources a l'execution, ni la cloture C-01/C-02. La porte C reste **NON SATISFAITE**.
