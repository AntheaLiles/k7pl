<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 27 : multiplication du grade global et mise à l'échelle

**Date :** 7 octobre 2026

Le test de la séance 25 a établi que `ℒ` n'est pas encore une grade algebra. La question suivante
est plus précise : même après enrichissement de `ℒ`, la multiplication de la grade algebra globale
pourrait-elle être l'opération `r·Δ` utilisée par K7PL ?

## 1. Deux opérations à ne pas confondre

Dans une grade algebra produit `𝓖 = 𝕌 × 𝕄 × ℒ × 𝔅`, la multiplication est normalement définie
composante par composante. Si `ℒ` est une treillis distributif muni de la construction standard
`+_L = ⊔`, `×_L = ⊓`, alors le produit global donne

`r * g = ⟨u_r*u, m_r*m, ℓ_r ⊓ ℓ, β_r*β⟩`.

Le rôle actuel de l'action `r·Δ` est différent dans la preuve de cohérence : l'usage est multiplié,
la monotonie prend le minimum, mais le niveau prend le joint. Le comportement sur le niveau n'est
donc pas celui de la multiplication standard du grade algebra si `ℒ` est munie de `⊔/⊓`.

Cette différence ne prouve pas que A est impossible. Elle prouve que l'identification

`r·Δ = r * Δ`

est une hypothèse supplémentaire qui doit être falsifiée.

## 2. Trois moyens de sauver A

### A1 — Changer l'ordre algébrique du niveau

On peut munir `ℒ` d'une structure ordonnée duale de son ordre de confidentialité, afin que la
rencontre de l'ordre algébrique corresponde à la jointure de l'ordre de confidentialité.

Obligation : montrer que les unités, zéros, monotonies et coercions induits restent compatibles
avec la signification de `ℓ ≤ ℓ'` utilisée par `SubBox` et par la non-interférence. Cette option
ne peut pas être validée par un simple renommage de l'ordre.

### A2 — Conserver la grade algebra globale mais définir une action externe

`Scale : Scalar × 𝓖 → 𝓖` est une action distincte de la multiplication de `𝓖`.

Elle pourrait laisser `Mono` et `Level` inchangés, ou appliquer une opération propre à chacun.
Dans ce cas, la propriété requise par `Box`, `App` et substitution n'est plus une conséquence de
la grade algebra : il faut démontrer explicitement les lois de module/action de `Scale`.

Cette solution reste compatible avec les grades globaux de Bianchini, mais elle réduit le gain
théorique que procurait la multiplication globale.

### A3 — Revenir à une architecture hétérogène/multimodale

Chaque dimension possède son domaine et ses morphismes de transport. La mise à l'échelle n'a alors
pas besoin d'être une multiplication du produit global ; elle est une opération construite à partir
des actions de chaque mode.

Cette option est la plus proche des mécanismes multimodaux de GRASS et des grades hétérogènes.

## 3. Test falsifiant

Le test décisif est maintenant concret.

Pour le niveau, vérifier si l'opération exigée par les règles est `⊓_L`, `⊔_L`, ou une action
triviale. Pour le budget, vérifier si la mise à l'échelle utilise réellement la multiplication
de `ℕ∞`. Pour la monotonie, vérifier si `⊓_M` suffit. Pour l'usage, vérifier si la même opération
porte à la fois `!_u`, `SubBox` et l'action sur les effets.

Si les quatre composantes exigent quatre opérations qui ne peuvent pas être réunies sous une même
multiplication compatible avec les lois de grade algebra, A doit passer par A2 ou être abandonnée.
Si elles peuvent être réunies, A redevient le candidat le plus économique.

## 4. Conséquence pour la substitution

Le lemme de substitution utilise `r·Δ'`. Il n'a donc pas besoin, en soi, que `r·Δ'` soit la
multiplication de la grade algebra. Il a besoin d'une action satisfaisant les lois de composition
et de distributivité nécessaires à l'induction.

Cela clarifie l'objectif de la formalisation Lean : définir d'abord `Scale` et ses lois ; décider
ensuite seulement si `Scale` coïncide avec la multiplication de `𝓖`.

## 5. Résultat

La question architecturale est maintenant mieux factorisée.

Établi : un produit de grade algebras peut porter des grades hétérogènes.
Établi : K7PL peut conserver `ℒ` comme treillis sans ajouter immédiatement une multiplication.
Non établi : la multiplication de la grade algebra globale est l'action `r·Δ`.
Non établi : l'ordre de `ℒ` peut être choisi ou dualisé sans effet sur la sémantique.
Non établi : une action externe `Scale` peut satisfaire les lois nécessaires à la substitution.

Le prochain livrable doit donc construire les deux interfaces minimales :

`MulG : 𝓖 × 𝓖 → 𝓖` et `Scale : Scalar × 𝓖 → 𝓖`,

puis vérifier quelles équations du noyau sont satisfaites par chacune. Tant que cette comparaison
n'est pas faite, toute ratification de `TRANS-02` serait prématurée.