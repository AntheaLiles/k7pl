<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 38 : décomposition de la loi de cohérence

**Date :** 7 octobre 2026

La comparaison règle par règle et le test budgétaire permettent maintenant de distinguer deux
situations que l'ancienne loi de cohérence regroupait artificiellement.

## 1. Loi générale historique

La forme

\`r · ψ(Δ, ε) = ψ(r · Δ, φ_r(ε))\`

est correcte comme obligation générale pour une architecture dans laquelle le même scalaire agit
sur le contexte et transforme également l'effet traversé.

Elle n'est toutefois pas une loi que K7PL peut déclarer universellement satisfaite tant que le grade
complet ne possède pas une action totale sur toutes ses composantes et que \`φ_r\` n'est pas défini
pour les grades d'usage rationnels.

## 2. Décomposition sous l'architecture factorisée

Sous le candidat

\`𝒢 \xrightarrow{π_U} 𝓡 \xrightarrow{!} End(C)\`

et l'action

\`Scale_Usage(u,\langle v,m,\ell,\beta\rangle)
 = \langle u v,m,\ell,\beta\rangle\`,

la mise à l'échelle d'usage ne modifie ni le niveau, ni la monotonie, ni le budget.

Or \`ψ\` modifie actuellement uniquement le budget. Elle laisse donc la composante d'usage inchangée.
Il en résulte la loi candidate beaucoup plus faible :

\`Scale_Usage(u,ψ(Δ,ε)) = ψ(Scale_Usage(u,Δ),ε)\`.

Cette loi n'a besoin d'aucune transformation \`φ_u\` de l'effet. En particulier, elle reste bien
définie pour les usages rationnels, puisque la rationalité intervient seulement dans la multiplication
de la composante d'usage.

La conséquence est importante pour \`Box\`, \`App\` et substitution : ces règles peuvent utiliser
l'action d'usage sans convertir un usage rationnel en nombre d'exécutions.

## 3. Loi d'exécution séparée

Le cas où une exécution est réellement répétée reste différent. Pour une multiplicité entière finie
\`n\`, le candidat est :

\`Scale_Exec(n,\langle u,m,\ell,\beta\rangle)
 = \langle n u,m,\ell,n\beta\rangle\`

sur le domaine où l'action budgétaire est définie.

L'effet correspondant est \`Action_Exec(n,ε)=ε^n\`. C'est ce couple d'actions qui doit porter la loi
de cohérence pertinente pour \`Sc\` et les constructions qui représentent une répétition effective.

Sur le budget, cette loi requiert l'identité arithmétique

\`n(β ⊖ k)=nβ ⊖ nk\`

dans son domaine de validité. Elle ne peut pas être étendue automatiquement aux usages rationnels,
ni aux cas d'exécution non bornée.

## 4. Substitution

La preuve de substitution n'a donc plus besoin de la loi générale pour ses cas \`Box\`, \`App\` et
substitution : elle a besoin de la loi d'usage factorisée, de l'additivité de \`Scale_Usage\` et de sa
composition :

\`SU_a(Δ₁+Δ₂)=SU_a(Δ₁)+SU_a(Δ₂)\`

et

\`SU_a(SU_b(Δ))=SU_{ab}(Δ)\`.

Les cas d'exécution effective conservent une dette séparée. Cette partition réduit l'obligation
initiale sans supprimer la preuve de cohérence du système complet.

## 5. Mise en parallèle

La même séparation s'applique à la loi

\`φ_r(ε₁ ∥ ε₂)=φ_r(ε₁) ∥ φ_r(ε₂)\`.

Pour \`Scale_Usage\`, aucune transformation de l'effet n'est nécessaire : la loi est une propriété
de \`Action_Exec\` seulement si l'on parle de répétition d'exécution. Il faut donc éviter d'utiliser
la loi de parallélisme comme preuve indirecte d'une action sur les grades d'usage.

## 6. Statut

**Établi au niveau architectural :** la loi générale se décompose en lois distinctes dès que les
sortes du scalaire sont distinguées.

**Résultat local démontré sur le candidat :** \`Scale_Usage\` commute avec \`ψ\` sans transformation
de l'effet, parce que \`Scale_Usage\` laisse la seule composante modifiée par \`ψ\` inchangée.

**Résultat conditionnel :** \`Scale_Exec\` commute avec \`ψ\` sous la loi arithmétique du budget et
la définition correspondante de \`φ_n\`.

**Conséquence :** la substitution \`Box/App/Substitution\` n'exige plus une \`φ_r\` définie pour
des grades d'usage rationnels.

**Dette restante :** démontrer les propriétés de l'action d'exécution et vérifier les constructions
qui réalisent effectivement une répétition avant de considérer \`Scale_Exec\` comme partie normative.

Cette décomposition constitue désormais le test de référence pour les autres emplois de la prétendue
« loi de cohérence ».
