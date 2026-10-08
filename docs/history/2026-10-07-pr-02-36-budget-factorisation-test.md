<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 36 : test budgétaire de la factorisation

**Date :** 7 octobre 2026

La séance 35 a réduit l'alternative d'indexation de \`!\` à une question de cohérence sémantique :
peut-on laisser le budget inchangé dans \`Scale_Usage\` sans contredire le rôle que le jugement lui
attribue ? La présente séance vérifie d'abord la définition effective de \`⊖\`, puis sa place dans
\`ψ\`, et enfin ce que ces deux faits permettent de conclure.

## 1. Définition effectivement normative de \`⊖\`

La spécification courante définit :

\`β ⊖ k = ω\` si \`β=ω\`,
\`β ⊖ k = 0\` si \`β<k\`,
\`β ⊖ k = β-k\` sinon.

Cette opération est une soustraction tronquée prolongée à l'infini. Elle ne doit pas être appelée
résidu de l'addition.

Pour une résiduation de l'addition sur \`ℕ∞\` avec l'ordre usuel, le cas \`ω ⊖ ω\` serait imposé
à \`0\` par la condition de plus petit complément. La convention K7PL donne au contraire
\`ω ⊖ ω = ω\`, afin de conserver une borne sûre lorsqu'une borne non bornée rencontre une dépense
non bornée. Les deux constructions coïncident sur les cas finis pertinents et divergent au point
\`(ω,ω)\`.

Le registre de questions contenait encore la formulation inverse. Il s'agit d'une trace de recherche
devenue obsolète, et non d'un résultat à réintroduire dans C2.

## 2. Ce que \`ψ\` fait réellement

La définition de \`ψ\` laisse inchangées l'usage, la monotonie et le niveau ; elle agit sur le budget
par \`β ⊖ k\`, où \`k\` est la composante temporelle de l'effet.

Le rejet d'un budget insuffisant ne provient donc pas de l'identification de \`⊖\` à une opération de
grade. Il provient de la condition de définition de \`ψ\` et des règles qui exigent que cette
composition soit admissible.

Il faut par conséquent distinguer :

\`Consume : 𝔅 × Time ⇀ 𝔅\`

pour la consommation admissible, et la fonction arithmétique \`⊖\` utilisée dans sa définition.

Cette séparation est compatible avec la décision antérieure de distinguer \`Consume\` de \`MulG\`.

## 3. Test de \`Scale_Usage\`

Le candidat de la séance 33 est :

\`Scale_Usage(a,⟨u,m,ℓ,β⟩)=⟨a·u,m,ℓ,β⟩\`.

La question est de savoir si cette invariance du budget contredit \`ψ\`.

Elle ne le fait pas sur les règles analysées. \`ψ\` n'est déclenchée que lorsqu'un effet traverse un
contexte. \`Box\`, \`App\` et substitution mettent à l'échelle les dépendances d'une valeur ou d'un
argument ; elles n'exécutent pas cet argument au moment où le contexte est construit. Rien dans leur
forme ne demande donc une consommation temporelle supplémentaire.

Le budget reste néanmoins disponible pour une exécution ultérieure : lorsque cette exécution produit
un effet de coût \`k\`, \`ψ\` applique alors \`β ⊖ k\`.

La distinction est donc :

\`Scale_Usage\` décrit combien de fois une dépendance doit être disponible ;

\`Consume\` décrit combien de coût temporel reste après le passage d'un effet.

Aucune équation de la spécification actuelle ne requiert que la première transforme nécessairement la
seconde.

## 4. Test par contre-exemple

Pour réfuter \`Scale_Usage\` avec budget invariant, il faudrait exhiber une règle dans laquelle un
usage rationnel \`a\` représente une répétition d'exécution et où cette répétition doit consommer le
budget immédiatement.

Le fragment étudié ne contient pas ce cas.

À l'inverse, \`Sc\` possède explicitement une multiplicité d'exécution \`n\`. C'est précisément là
que \`Scale_Exec\` et la compatibilité budgétaire entière doivent intervenir :

\`Scale_Exec(n,⟨u,m,ℓ,β⟩)=⟨n·u,m,ℓ,n·β⟩\`

sur le domaine admissible, avec \`Action_Exec(n,ε)=ε^n\`.

Le système dispose ainsi de deux causes distinctes de transformation :

\`Usage\` pour la disponibilité structurelle ;

\`Exec\` pour la répétition effective et son coût.

Le fait qu'un contre-exemple ne se trouve pas dans les règles de \`Box\`, \`App\`, \`SubBox\`,
substitution et \`Sc\` ne constitue pas une preuve générale d'orthogonalité sémantique ; c'est un
résultat borné au fragment courant.

## 5. Conséquence pour l'indice de \`!\`

Le test budgétaire ne fournit pas de motif obligeant l'indice de \`!\` à porter \`β\`.

Au contraire, la factorisation suivante reste cohérente avec tous les usages observés :

\`𝒢 \xrightarrow{π_U} 𝕌 \xrightarrow{!} End(C)\`.

L'annotation complète conserve \`β\` pour la discipline de coût, tandis que \`!\` n'en dépend pas
comme indice du noyau exponentiel.

La même conclusion vaut pour \`ℓ\` au sens du noyau comonadique, mais pas au sens de la sémantique
de confidentialité : la relation logique de C4 consulte \`niv(r)\`. Le niveau doit donc persister
dans l'annotation complète même s'il ne fait pas partie de l'indice de \`!\`.

## 6. Ce que le test établit réellement

Le test établit trois choses.

Premièrement, la définition courante de \`⊖\` ne doit pas être qualifiée de résiduation ; elle
constitue une consommation tronquée avec une convention explicite à l'infini.

Deuxièmement, la consommation budgétaire et la mise à l'échelle d'usage peuvent rester distinctes
sans contradiction dans le fragment de règles étudié.

Troisièmement, aucune règle analysée n'impose d'introduire \`β\` dans l'indice de la comonade.

Il ne s'ensuit pas que le budget soit sémantiquement indépendant de l'usage dans tout le langage. Une
preuve globale demanderait de traiter les constructions qui convertissent effectivement une
disponibilité en exécutions, en particulier les formes récursives, vectorielles et à portée qui ne
sont pas encore toutes stabilisées.

## 7. Statut

**Établi :** \`⊖\` et \`Consume\` ne sont pas des opérations de grade global.

**Établi :** la convention \`ω ⊖ ω = ω\` exclut la qualification de résidu.

**Résultat local :** le fragment \`Box\`, \`App\`, \`SubBox\`, substitution et \`Sc\` ne fournit aucun
contre-exemple à \`Scale_Usage\` avec budget invariant.

**Résultat fortement soutenu :** l'indice de \`!\` peut rester sur \`𝕌\` sans porter directement
\`β\`, sous réserve que les constructions d'exécution continuent de consommer le budget par
\`Consume\`.

**Non établi :** l'orthogonalité sémantique globale de l'usage et du budget.

**Position provisoire renforcée :** la factorisation \`𝒢 → 𝕌 → !\` constitue désormais
l'architecture de référence pour les tests suivants ; \`I=𝒢\` reste une architecture générale
possible mais n'est plus nécessaire pour expliquer les règles actuellement examinées.
