<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 40 : distinction borne d'occurrences / multiplicité d'effet

**Date :** 7 octobre 2026

La règle d'expansion des macros contenait encore une identification implicite : le grade `r_i` qui
borne les occurrences d'un argument était également utilisé comme indice de `φ`. Cette identification
est indue dès que les grades d'usage peuvent être rationnels.

## 1. Deux quantités distinctes

Pour une macro `m`, notons

`n_i = occ_i(m)` le nombre syntaxique d'occurrences de la métavariable `x_i` dans le corps,

et conservons `r_i` comme borne graduée déclarée par la signature de la macro.

Le rôle de `r_i` est contextuel :

`Scale_Usage(π_U(r_i),Δ_i)`.

Le rôle de `n_i` est effectuel : le code produit contient exactement `n_i` copies de l'argument,
et son effet séquentiel peut être noté `φ_{n_i}(ε_i)` lorsque le fragment effectuel définit cette
action pour les multiplicités entières finies.

## 2. Pourquoi `φ_{r_i}` est trop fort

Le semi-anneau d'usage de K7PL contient les rationnels positifs. Un grade `r_i = 3/2` peut être une
borne quantitative sans constituer un nombre d'exécutions. L'expression `φ_{3/2}` n'a pas de
définition acquise dans le système d'effets.

La formule actuelle qui écrit `φ_{r_i}(ε_i)` impose donc implicitement une identification entre
borne d'usage et multiplicité d'effet. Cette identification ne suit ni de la grammaire ni de la
factorisation de l'indice.

## 3. Dérivation corrigée

L'expansion est une suite finie de substitutions. Pour chaque occurrence de `x_i`, le lemme de
substitution fournit le contexte mis à l'échelle par `Scale_Usage(π_U(r_i),Δ_i)` et l'effet
de l'argument. En composant les effets dans l'ordre des occurrences, on obtient le produit correspondant
à `n_i` copies, donc `φ_{n_i}(ε_i)` si `φ_n(ε)=ε^n` sur les indices entiers.
Aucune loi globale `r·ψ = ψ(r·,φ_r)` n'est nécessaire pour cette dérivation.

Le budget de `Δ_i` reste celui porté par son grade et n'est pas multiplié lors de l'expansion.
Si l'effet produit traverse ensuite un contexte, `ψ` consomme le budget selon le coût de
l'effet effectivement construit.

## 4. Conséquence normative candidate

La règle d'expansion doit donc être comprise avec les deux index suivants :

`r_i` : borne quantitative d'usage du paramètre ;

`n_i = occ_i(m) ∈ ℕ` : multiplicité syntaxique exacte de l'effet du paramètre.

Le choix entre un effet exact et une borne d'effet reste une question séparée. Si les annotations
d'effet sont des bornes, une relation de monotonie entre `n_i` et la borne déclarée devra être
établie ; aucune opération de type `φ_{r_i}` n'est à inventer pour contourner cette question.

## 5. Statut

**Établi :** `r_i` ne doit pas être assimilé à une multiplicité d'exécution.

**Établi :** la règle macro a besoin de deux quantités différentes, une pour le contexte et une pour
l'effet produit.

**Correction candidate forte :** remplacer `φ_{r_i}(ε_i)` par `φ_{occ_i(m)}(ε_i)` dans la
règle d'expansion.

**Obligation restante :** préciser si l'annotation d'effet est exacte ou une borne, et donc quelle
relation permet de passer du produit des effets observés à l'annotation de conclusion.