<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 31 : typage local des scalaires de mise à l'échelle

**Date :** 7 octobre 2026

Les séances 29 et 30 avaient établi que `Scale` doit être typée et que `!`, `Scale` et `φ` forment une
interface couplée. La lecture de toutes les occurrences de `r·Δ` et `n·Δ` permet maintenant de préciser
le rôle de chaque règle sans modifier encore sa syntaxe normative.

## 1. Deux classes de règles

Les règles ne demandent pas toutes la même notion de répétition.

| Règle | Scalaire syntaxique | Interprétation candidate | Statut |
|---|---|---|---|
| `Box` | `r` de `!_r` | usage de la ressource capturée | à confirmer |
| `App` | `r` du domaine de la fonction | multiplicité d'emploi de l'argument | usage candidate |
| substitution | `r` de la liaison substituée | sensibilité du contexte à l'emploi de la liaison | usage candidate |
| `Sc` | `n` | répétition effective d'un calcul | établi par la forme de la règle |
| `VecI` | `n` | construction à partir de `n` valeurs | taille, pas grade de liaison |
| `VecE` | `n` | répétition du parcours sur `n` positions | exécution structurée par la taille |

Le résultat important est que `r` et `n` ne sont pas seulement deux notations d'un même scalaire.
`n` apparaît là où une cardinalité d'exécution ou de parcours est explicitement connue. `r` apparaît
dans une discipline de ressources portée par les liaisons.

## 2. `Sc` fournit le témoin positif

La règle `Sc` emploie déjà `n·Δ` et le transformateur `φ_n`. Son `n` provient du domaine de répétition
et non d'une projection implicite d'un grade complet.

Pour ce cas, la chaîne est donc :

`n : Exec → Scale_Exec → action sur le temps et les effets`.

Cette chaîne confirme le résultat de la séance 29 : `Exec` est la sorte naturelle pour une action qui
répète un calcul.

## 3. `Box`, `App` et substitution

Ces trois règles réutilisent `r`, mais pour une opération de contexte et non pour l'itération directe
d'un effet.

Le candidat le plus parcimonieux est donc une factorisation :

`r --usage--> u --Scale_Usage--> contexte`.

Cette factorisation permet d'utiliser des valeurs rationnelles lorsque la discipline de ressource le
requiert, sans prétendre qu'elles représentent une demi-exécution.

Elle rencontre toutefois une limite immédiate : le contexte porte aussi un budget `β`. Si `Scale_Usage`
modifie `β`, son action doit donner un sens à la mise à l'échelle d'un entier par un rationnel. Ce n'est
pas le cas dans `𝔅 = ℕ∞` sans structure supplémentaire.

Deux solutions sont alors conceptuellement disponibles.

**U1 — budget invariant sous `Scale_Usage`.**

L'action d'usage modifie la composante d'usage mais laisse `m`, `ℓ` et `β` inchangés. Le budget reste une
borne attachée au calcul ou à la ressource, non une quantité multipliée par un usage fractionnaire.

**U2 — budget mis à l'échelle.**

`Scale_Usage` doit alors posséder une application `𝕌 → End(ℕ∞)` au moins sur un sous-domaine. Pour les
réguliers rationnels cette extension n'est pas donnée par l'arithmétique actuelle ; il faut soit un
arrondi sûr explicite, soit une autre structure de budget.

U1 est plus sobre, mais elle doit encore être vérifiée contre `ψ` et P3. U2 est plus expressive, mais
elle ajoute précisément la structure que les séances 26 et 29 avaient identifiée comme absente.

## 4. Conséquence pour l'indice de `!`

Si `Box` utilise `Scale_Usage`, deux lectures de `!_r` deviennent possibles :

```text
A. !_{u} V                  -- indice comonadique = usage
B. !_{r} V, r=<u,m,ℓ,β>    -- indice syntaxique complet
   avec projection vers u   -- pour l'index de la comonade
```

La seconde conserve la grammaire actuelle mais fait de `r` un emballage syntaxique autour d'un indice
plus petit. Elle exige donc des lois de projection et de conversion.

La première est sémantiquement plus directe, mais oblige à déplacer `m`, `ℓ` et `β` hors de l'index de la
comonade et à reconstruire la règle `SubBox` sur l'annotation complète.

Le choix ne peut donc pas être fait sur la seule théorie de `Scale`.

## 5. Conséquence pour le sous-typage

`SubBox` compare le grade complet, alors que `!` pourrait n'être indexée que par `u`. Il faut alors un
morphisme de projection :

`π_U : 𝒢 → 𝕌`.

La question n'est pas de savoir si cette projection existe ensemblistement, ce qui est immédiat, mais si
elle préserve exactement les relations utilisées par le sous-typage et par les conversions de `!`.

En particulier, si

`r ≼ r'` implique `π_U(r) ≥ π_U(r')`,

alors le sens de la coercion sur l'indice d'usage est compatible avec `SubBox`. Cette compatibilité est
une condition précise et testable.

## 6. Nouvelle formulation de `Scale`

La notation actuelle peut maintenant être reconstruite comme une famille indexée par sorte :

```text
Scale_Usage : 𝕌 × 𝒢 ⇀ 𝒢
Scale_Exec  : ℕ∞ × 𝒢 ⇀ 𝒢
```

avec, au minimum, identité, composition, préservation de l'agrégation et monotonie pour chacune des
deux familles sur son domaine.

`Scale_Exec` doit en outre être compatible avec l'action sur les effets et avec la multiplication du
temps. `Scale_Usage` doit être compatible avec la discipline de ressource et le sous-typage.

Cette séparation est plus informative qu'une unique signature `Scale : S × 𝒢 ⇀ 𝒢` et ne préjuge pas
encore de l'architecture finale.

## 7. Verdict

**Établi :** les occurrences de `n·Δ` appartiennent au régime `Exec`, distinct du grade d'usage.

**Établi :** `Box`, `App` et substitution ont un scalaire attaché à une liaison.

**Candidat provisoire :** la lecture la plus économique de ce scalaire est une action d'usage, sous réserve
du traitement du budget et de l'indice de `!`.

**Non établi :** le traitement du budget par `Scale_Usage`.

**Non établi :** la correspondance entre `!_r` et un éventuel indice `!_u`.

**Résultat discriminant :** le grade complet ne peut plus être considéré comme un scalaire homogène.
La forme actuellement la plus parsimonieuse est une famille d'actions par sorte, avec `Scale_Usage` et
`Scale_Exec` distinctes.

**Conséquence :** `QA-32` peut désormais être traitée non comme un choix binaire de scalaire, mais comme
une question de factorisation de l'action : projection du grade → sorte du scalaire → action sur les
composantes effectivement concernées.