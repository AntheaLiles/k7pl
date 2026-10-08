<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 34 : test algébrique de `Scale_Usage`

**Date :** 7 octobre 2026

La séance 33 propose l'action

`Scale_Usage(a,⟨u,m,ℓ,β⟩)=⟨a·u,m,ℓ,β⟩`.

Il faut maintenant vérifier si cette factorisation satisfait effectivement les lois nécessaires à
`Box`, `App`, substitution et `ψ`, plutôt que de la retenir parce qu'elle paraît simple.

## 1. Domaine

On prend `a,u ∈ 𝕌 = ℚ≥0 ∪ {ω}` et un grade complet
`g = ⟨u,m,ℓ,β⟩`.

L'action est définie par

`SU(a,g)=⟨a·u,m,ℓ,β⟩`.

Elle est totale sur le porteur `𝒢` si la composante d'usage est fermée par multiplication. Elle ne
demande aucune multiplication rationnelle sur `β`.

## 2. Identité

`SU(1,g)=g`.

La propriété suit directement de l'identité multiplicative de `𝕌`.

Elle donne le cas neutre de `Box` et de substitution.

## 3. Composition

`SU(a,SU(b,g))=SU(a·b,g)`.

La preuve est composante par composante :

`a·(b·u)=(a·b)·u`

et les trois autres composantes restent inchangées.

Cette loi est donc indépendante d'une multiplication globale sur `𝒢`.

## 4. Préservation de l'agrégation

Supposons que l'agrégation de contexte soit définie composante par composante et que l'usage soit
agrégé par `+`.

Alors

`SU(a,g⊕h)=SU(a,g)⊕SU(a,h)`

sur l'usage par distributivité :

`a·(u+v)=a·u+a·v`.

Sur les autres composantes, `SU` est l'identité ; elle commute donc avec leur opération
d'agrégation quelle qu'elle soit.

Cette observation retire une obligation qui paraissait auparavant globale : il n'est pas nécessaire
de faire de `𝒢` un semi-anneau homogène pour obtenir la bilinéarité requise par la substitution.

## 5. Monotonie pour `≼`

Si

`g ≼ h`

alors, sur l'usage, `u_g ≥ u_h`. La multiplication par un élément positif de `𝕌` préserve cet ordre
et donc aussi sa version opposée. Les trois autres composantes sont identiques après `SU`.

On obtient donc la monotonie de `SU` pour le sous-typage, sous réserve des lois d'ordre déjà
retenues pour `𝒢`.

## 6. Compatibilité avec `ψ`

`ψ` modifie uniquement le budget par `β ⊖ k`.

Comme `SU` ne modifie pas le budget, on obtient le carré de commutation :

`SU(a,ψ(g,ε)) = ψ(SU(a,g),ε)`

lorsque `ψ(g,ε)` est défini.

Ce résultat est particulièrement utile : l'usage rationnel n'oblige plus à définir une multiplication
rationnelle sur le budget pour faire commuter la loi distributive.

## 7. Conséquence pour `φ`

Cette factorisation confirme aussi que `φ` n'a pas besoin d'être paramétré par le grade complet dans
les cas `Box`, `App` et substitution.

Le scalaire de `SU` agit sur le contexte ; l'action `Action_Exec` agit sur l'effet lorsque la règle
possède une multiplicité d'exécution explicite.

On peut donc distinguer les signatures :

`SU : 𝕌 × 𝒢 → 𝒢`

`SE : ℕ∞ × 𝒢 ⇀ 𝒢`

`Action_Exec : ℕ∞ × 𝓔 ⇀ 𝓔`.

Cette séparation est plus stricte que la notation historique `r·Δ` / `φ_r`.

## 8. Ce que le test ne prouve pas

Le calcul ne prouve pas que `SU` est la sémantique correcte de `Box` ou `App`. Il prouve seulement
que cette définition satisfait les lois algébriques identifiées comme nécessaires.

Il ne prouve pas non plus que les composantes `m`, `ℓ` et `β` sont sémantiquement orthogonales
à l'usage. Cette propriété relève de la dénotation des grades et de la sémantique du noyau.

Enfin, il ne résout pas l'indice de `!`. Il rend cependant possible une architecture où
`!_{π_U(r)}` porte l'usage tandis que `r` conserve les annotations complémentaires.

## 9. Conséquence pour la substitution

Dans l'induction de substitution, la difficulté

`(r₁+r₂)·Δ' = r₁·Δ'+r₂·Δ'`

peut être remplacée, pour la partie d'usage, par

`SU(π_U(r₁+r₂),Δ') = SU(π_U(r₁),Δ') + SU(π_U(r₂),Δ')`.

Elle est alors une conséquence de la distributivité de `𝕌`, sous réserve que les composantes
complémentaires soient agrégées indépendamment et que `SU` les laisse invariantes.

Cette réduction rend la preuve nettement plus locale et fournit un test concret pour C3.

## 10. Verdict

**Résultat démontré au niveau algébrique :** l'action candidate `SU` satisfait identité, composition,
préservation de l'agrégation et monotonie sur son domaine.

**Résultat démontré conditionnellement :** `SU` commute avec `ψ` parce que `ψ` ne modifie que le budget.

**Conséquence forte :** le problème des usages rationnels n'impose pas, à lui seul, d'enrichir le
budget avec une multiplication par rationnels.

**Non établi :** que `SU` soit la sémantique normative de `r·Δ`.

**Non établi :** que `!` soit effectivement indexée par `π_U(r)`.

**Position provisoire renforcée :** B et C peuvent désormais être testées avec une action d'usage
explicite et un scalaire d'exécution distinct, sans construire immédiatement une grade algebra globale.