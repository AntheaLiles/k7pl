<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 35 : tests décisifs de l'indice de \`!\`

**Date :** 7 octobre 2026

Les séances 32 à 34 ont fourni une interface abstraite de l'exponentielle et une action candidate
sur les contextes. La présente séance confronte maintenant les deux architectures d'indexation
directement au jeu de règles, au lieu de comparer leurs signatures isolément.

## 1. Objet du test

Le point à décider n'est pas encore si l'annotation complète doit disparaître. Il est plus précis :
déterminer si l'index effectivement requis par l'exponentielle peut être la projection d'usage du
grade complet, tout en conservant les autres composantes là où les règles ou la sémantique les
consultent.

On pose le candidat :

\`Index = π_U : 𝒢 → 𝕌\`

avec

\`π_U(⟨u,m,ℓ,β⟩) = u\`.

La notation syntaxique historique \`!_r A\` est alors lue comme une notation factorisée :

\`Bang_G(r,A) \coloneqq !_{π_U(r)} A\`

mais cette égalité concerne l'index de la comonade, non l'effacement de l'annotation complète
\`r\`. Celle-ci reste disponible dans le jugement et dans les interprétations qui en ont besoin.

Cette précaution est nécessaire : la relation logique de C4 interprète actuellement \`!_r V\` en
consultant \`niv(r)\`. Le niveau du grade a donc bien une fonction sémantique indépendante de l'index
d'usage. Une factorisation correcte doit conserver cette donnée au niveau de l'annotation ou de son
interprétation ; elle ne peut pas simplement remplacer partout \`r\` par \`π_U(r)\`.

## 2. Test de Box

La règle actuelle est :

\`\`\`text
Box   Δ ⊢ v : V
      ─────────────────────────
      r·Δ ⊢ box_r v : !_r V
\`\`\`

Sous la factorisation, le candidat devient :

\`Scale_Usage(π_U(r),Δ) ⊢ box_r v : Bang_G(r,V)\`.

La règle exige alors deux objets distincts et une compatibilité :

1. l'usage \`π_U(r)\` doit fournir l'action sur le contexte ;
2. \`Bang_G\` doit conserver l'annotation complète \`r\` pour les propriétés orthogonales ;
3. l'élaboration de \`box_r\` doit relier les deux sans supposer que \`Scale_Usage\` est une
   multiplication globale de \`𝒢\`.

Aucune composante \`m\`, \`ℓ\` ou \`β\` n'est utilisée par la formation de la boîte elle-même dans
la règle. Elles ne doivent donc pas être introduites dans l'index comonadique sans obligation
indépendante.

**Résultat :** la factorisation par \`𝕌\` satisfait la forme de la règle sans nouvelle opération
sur le niveau ou le budget. Elle reste toutefois conditionnelle à la justification sémantique de
l'action de \`Scale_Usage\`.

## 3. Test de Unbox

La règle est :

\`Δ₁ ⊢ v : !_r V\` et \`Δ₂, x:_r V ⊢ c : C\`.

Aucune opération d'index n'intervient dans l'élimination. Le contrat pertinent est seulement :

\`Bang_G(r,V) → x:_r V\`.

Le même \`r\` est donc conservé entre le type exponentié et la liaison introduite.

**Résultat :** \`Unbox\` ne fournit aucun argument en faveur d'un index complet \`𝒢\`. Au contraire,
il montre que l'indice de la comonade peut être plus pauvre que l'annotation que l'éliminateur
restitue.

## 4. Test de SubBox

La règle est :

\`r ≼ r' ⇒ !_r V <: !_{r'} V\`

avec

\`r ≼ r' ⇔ u ≥ u' ∧ m ⪰ m' ∧ ℓ ≤ ℓ' ∧ β ≤ β'\`.

Par projection :

\`r ≼ r' ⇒ π_U(r) ≥ π_U(r')\`.

Cette implication est immédiate sur la première composante et correspond à la direction de
coercion déjà retenue pour l'usage.

La conséquence est importante : la coercion sur \`!\` peut être définie sur l'indice \`𝕌\`, tandis
que les trois autres composantes restent dans le jugement de sous-typage. Il faut alors fournir une
famille de conversions orthogonales pour l'annotation complète, mais aucune de ces conversions ne
force la comonade à être indexée par \`𝒢\`.

**Résultat décisif :** l'ordre de \`SubBox\` ne contredit pas l'indexation par \`𝕌\`. Il la
factorise naturellement sur sa composante d'usage.

## 5. Test de contraction

L'interface graduée exige une contraction de la forme :

\`c_{i,j,A} : !_{i +_I j} A → !_i A ⊗ !_j A\`.

Pour \`I = 𝕌\`, on obtient directement :

\`c_{u,v,A} : !_{u+v} A → !_u A ⊗ !_v A\`.

La syntaxe historique \`c_{r,s}\` avec \`r,s\` interprétés comme grades complets ne peut en revanche
être conservée comme une opération de \`𝒢\` qu'après définition d'une agrégation complète
\`AggG(r,s)\` satisfaisant notamment :

\`π_U(AggG(r,s)) = π_U(r) + π_U(s)\`.

Sans cette loi, il serait faux de conclure que la contraction du noyau d'usage est déjà une
contraction du grade complet.

**Résultat :** la contraction confirme l'indexation par \`𝕌\` au niveau comonadique et impose
seulement une condition de projection si la notation complète est conservée.

## 6. Test de App

La règle est :

\`Δ₁ \boxtimes_{ε₀} (r·Δ₂) ⊢ c\,v\`.

Le rôle de \`r\` est celui de la demande portée par le domaine de la fonction. La factorisation
candidate donne :

\`Δ₁ \boxtimes_{ε₀} Scale_Usage(π_U(r),Δ₂)\`.

Cette réécriture n'agit que sur l'exigence d'usage de l'argument. Elle n'exige pas que le niveau ou le
budget soient multipliés par un usage rationnel.

Le point encore ouvert est sémantique : il faut établir que le budget attaché au contexte de
l'argument représente une borne indépendante du nombre d'emplois, ou, dans le cas contraire, déplacer
sa propagation dans une action d'exécution distincte. La notation seule ne tranche pas entre ces deux
lectures.

**Résultat :** \`App\` est compatible avec \`Scale_Usage\` comme lecture structurelle de la demande
du domaine ; il ne constitue pas une preuve que cette action soit déjà la sémantique normative.

## 7. Test de substitution

Le lemme actuel emploie :

\`Δ \boxtimes (r·Δ') ⊢ c[v/x]\`.

Après factorisation :

\`Δ \boxtimes Scale_Usage(π_U(r),Δ') ⊢ c[v/x]\`.

La loi d'agrégation de la séance 34 donne alors, sur la composante d'usage :

\`Scale_Usage(a,Δ₁ + Δ₂)
 = Scale_Usage(a,Δ₁) + Scale_Usage(a,Δ₂)\`.

La composition des mises à l'échelle donne en outre :

\`Scale_Usage(a,Scale_Usage(b,Δ))
 = Scale_Usage(a·b,Δ)\`.

Ces deux propriétés sont précisément celles dont l'induction a besoin pour normaliser les
contextes après substitution.

La substitution ne demande donc pas, à elle seule, une multiplication totale sur \`𝒢\`. Ce qui reste
à établir est la conservation de ces lois lorsque les annotations complètes sont recomposées et
lorsque les conversions de \`SubBox\` interviennent pendant l'induction.

**Résultat :** la partie usage de la preuve est factorisable ; la cohérence complète de la
substitution reste une obligation indépendante.

## 8. Test de Sc

La règle \`Sc\` emploie une multiplicité explicite \`n\` et la transformation d'effet
\`φ_n\`. Ce cas ne requiert donc pas le même scalaire que \`Box\`, \`App\` ou substitution.

Le candidat séparé reste :

\`Scale_Exec(n,⟨u,m,ℓ,β⟩)
 = ⟨n·u,m,ℓ,n·β⟩\`

sur le domaine budgétaire où cette action est définie.

L'effet suit :

\`Action_Exec(n,ε)=ε^n\`.

**Résultat :** \`Sc\` confirme la distinction entre multiplicité d'usage et multiplicité d'exécution.
Il ne fournit aucun motif pour indexer \`!\` par \`𝒢\`.

## 9. Test sémantique complémentaire : la relation logique

La relation logique du C4 définit une clause spécifique pour \`!_r V\` qui dépend de
\`niv(r)\`. Ce fait interdit deux conclusions excessives :

- il serait faux de dire que \`!_r V\` est simplement syntaxiquement remplaçable par \`!_{π_U(r)} V\`
  en toute occurrence ;
- il serait également faux d'en conclure que l'indice de la comonade doit porter \`ℓ\`.

La lecture compatible est plus précise : \`!\` peut être indexée par \`𝕌\`, tandis que le constructeur
de type gradué conserve \`r\` comme annotation et que la sémantique de confidentialité consulte
\`ℓ\` indépendamment.

Il s'agit d'une factorisation à deux niveaux :

\`𝒢 → 𝕌 → !\`

et, en parallèle, une interprétation des annotations complètes dans les propriétés de sûreté.

**Résultat :** la sémantique actuelle renforce la nécessité d'une annotation complète persistante,
mais ne force pas son emploi comme indice de la comonade.

## 10. Test de l'architecture \`I = 𝒢\`

L'index complet reste mathématiquement possible. Il rendrait les écritures historiques directes :

\`!_r A\`,
\`c_{r,s}:!_{r+s}A→!_rA⊗!_sA\`,
\`SubBox\`.

Mais chaque écriture deviendrait alors porteuse de quatre obligations supplémentaires : fermeture de
l'agrégation complète, composition des indices, ordre compatible avec les conversions et actions
de mise à l'échelle.

Or les tests précédents n'ont fourni aucune règle qui ait besoin de ces quatre opérations sur
\`m\`, \`ℓ\` et \`β\` à l'intérieur du noyau de \`!\`.

**Résultat :** \`I = 𝒢\` n'est pas réfutée ; elle est strictement plus exigeante que ce que demandent
les règles effectivement analysées.

## 11. Critère de décision

Le test produit désormais un critère local :

Une architecture est retenue comme noyau d'indexation si elle satisfait toutes les opérations
effectivement exigées par \`Box\`, \`Unbox\`, \`SubBox\`, contraction, \`App\`, substitution et
\`Sc\`, sans introduire d'opération supplémentaire sur des composantes qui ne sont jamais consultées
par ces règles.

Sous ce critère :

\`I = 𝕌\` satisfait les besoins d'indexation de l'exponentielle ;

la factorisation \`π_U : 𝒢 → 𝕌\` conserve l'annotation complète ;

\`Scale_Usage\` fournit l'action candidate requise par \`Box\`, \`App\` et substitution ;

\`Scale_Exec\` reste séparée pour \`Sc\` et les répétitions effectives.

La seule difficulté qui ne se réduit pas par ce test est la preuve sémantique que le budget est bien
orthogonal à la quantité d'usage dans \`Scale_Usage\`. C'est donc désormais le test prioritaire.

## 12. Verdict

**Résultat fortement soutenu :** l'index d'usage \`𝕌\` suffit pour le noyau de l'exponentielle si
l'annotation complète \`r\` est conservée au niveau du type et du jugement.

**Résultat établi :** \`SubBox\` se projette dans la bonne direction sur \`𝕌\`.

**Résultat établi :** \`Unbox\` et \`Sc\` n'exigent pas un indice complet.

**Résultat conditionnel :** \`Box\`, \`App\` et substitution admettent \`Scale_Usage\` comme action
candidate et ses lois algébriques sont déjà vérifiées sur les hypothèses de la séance 34.

**Non établi :** la correction sémantique de \`Scale_Usage\` au regard du budget et du modèle
d'exécution.

**Non établi :** la cohérence complète entre les conversions de l'annotation \`𝒢\` et la famille
\`!_{π_U(r)}\`.

**Position de recherche :** la comparaison ne porte plus principalement sur \`I=𝕌\` contre
\`I=𝒢\`. Les règles favorisent désormais une architecture factorisée \`𝒢 → 𝕌 → !\`, tandis que
\`𝒢\` reste le porteur statique des annotations complètes. L'architecture \`I=𝒢\` demeure une
alternative de généralisation, mais elle n'est plus nécessaire pour expliquer le jeu de règles
actuel.

La prochaine falsification utile est donc ciblée : vérifier, dans la sémantique de coût et les
invariants de \`ψ\`, si \`Scale_Usage\` laisse effectivement \`β\` invariant. Si ce test passe, la
séparation \`Usage/Exec\` devient une architecture nettement mieux soutenue ; s'il échoue, le
contre-exemple dira exactement quelle action budgétaire manque.
