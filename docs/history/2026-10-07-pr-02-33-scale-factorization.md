<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 33 : factorisation locale de `Scale`

**Date :** 7 octobre 2026

La confrontation de `Box`, `App`, `SubBox`, substitution et `Sc` permet maintenant de construire un
candidat plus précis que la simple opposition `Usage` / `Exec`.

## 1. Projection du grade complet

On conserve

`𝒢 = 𝕌 × 𝕄 × ℒ × 𝔅`

et on définit la projection

`π_U : 𝒢 → 𝕌`

par

`π_U(⟨u,m,ℓ,β⟩) = u`.

Cette projection ne signifie pas que les trois autres composantes deviennent décoratives. Elle indique
seulement quelle composante peut servir de scalaire d'une action donnée.

## 2. Candidat `Scale_Usage`

Pour les règles qui répètent l'usage d'une liaison mais ne répètent pas directement l'exécution d'un
calcul, le candidat le plus sobre est :

`Scale_Usage(u, ⟨v,m,ℓ,β⟩) = ⟨u·v,m,ℓ,β⟩`.

L'action ne modifie donc ni la marque de monotonie, ni le niveau, ni le budget.

Ce choix n'est pas encore normatif. Il faut le vérifier contre la signification donnée à `β` dans la
sémantique de coût. Mais il a une propriété méthodologique importante : il ne crée aucune opération
nouvelle de passage des rationnels vers `ℕ∞`.

## 3. Pourquoi cette action correspond à `Box`

`Box` reçoit une valeur, non un calcul effectif à répéter.

La règle

`r·Δ ⊢ box_r v : !_r V`

peut donc être factorisée conceptuellement en :

`π_U(r) = u`,

`Scale_Usage(u,Δ) ⊢ box_r v : Bang(r,V)`.

`Bang(r,V)` conserve la totalité de l'annotation syntaxique si le langage en a besoin, mais son indice
comonadique peut être `u`.

La compatibilité demandée par `Box` devient alors une propriété de factorisation entre l'annotation
syntaxique et la comonade, et non une multiplication du grade complet.

## 4. Pourquoi cette action correspond à `App`

Dans

`App : c : V_r ⊸ C` et `v : V`

la demande `r` porte sur le nombre d'emplois de l'argument.

Le contexte de l'argument peut donc être transformé par

`Scale_Usage(π_U(r), Δ₂)`.

Cette opération ne prétend pas répéter un effet ni multiplier directement le budget. Elle exprime
la duplication ou le partage des dépendances nécessaires à la fourniture d'une valeur utilisée à la
hauteur demandée par la fonction.

Le point devra cependant être confronté à la sémantique d'évaluation retenue pour confirmer que le
budget attaché au contexte de la valeur n'est pas un coût d'exécution répété.

## 5. Pourquoi la substitution pointe dans la même direction

Le lemme actuel contient

`Δ ⊠ (r·Δ') ⊢ c[v/x]`.

Le même raisonnement donne

`Scale_Usage(π_U(r),Δ')`

plutôt qu'une opération sur `𝒢` entier.

Cela réduit fortement l'obligation de preuve : la bilinéarité nécessaire à l'induction ne porte plus
sur une multiplication inconnue du grade complet, mais sur l'action multiplicative de `𝕌` sur sa seule
coordonnée d'usage, sous réserve des lois de l'agrégation de contexte.

## 6. `Sc` reste dans `Exec`

La règle `Sc` fournit un contraste utile :

`n·Δ` et `φ_n` utilisent une multiplicité d'exécution explicite.

On peut donc définir séparément un candidat

`Scale_Exec(n,⟨u,m,ℓ,β⟩) = ⟨n·u,m,ℓ,n·β⟩`

sur le domaine où le scaling budgétaire est défini.

Cette action est compatible avec la lecture de `n` comme nombre d'exécutions : l'usage des ressources
et le budget de répétition sont tous deux multipliés.

Elle ne doit pas être confondue avec `Scale_Usage`.

## 7. `SubBox` et projection

Le sous-typage complet reste :

`r ≼ r' ⇔ u ≥ u' ∧ m ⪰ m' ∧ ℓ ≤ ℓ' ∧ β ≤ β'`.

Il implique immédiatement

`π_U(r) ≥ π_U(r')`.

Cette propriété fournit exactement la condition nécessaire pour que la projection du grade complet
vers l'indice d'usage respecte la direction de coercion observée sur `!`.

Les trois autres composantes exigent alors leurs propres conversions. Si elles ne jouent aucun rôle
dans l'indice comonadique, ces conversions peuvent être des réétiquetages ; cette hypothèse doit être
vérifiée dans la sémantique de `!`, et non seulement dans la syntaxe.

## 8. Bilan des deux actions

| Propriété | `Scale_Usage` | `Scale_Exec` |
|---|---|---|
| scalaire | `𝕌` | `ℕ∞` |
| occurrence principale | `Box`, `App`, substitution | `Sc`, répétitions effectives |
| usage | multiplié | multiplié |
| monotonie | inchangée | inchangée |
| niveau | inchangé | inchangé |
| budget | invariant candidat | multiplié sur domaine défini |
| effet | pas d'itération directe | `φ_n(ε)=ε^n` |

Cette matrice permet de comparer les architectures sans exiger une multiplication homogène de `𝒢`.

## 9. Critères de falsification

Le candidat doit être rejeté si l'un des quatre faits suivants est établi :

1. `Box` exige une modification du budget proportionnelle à `u` même pour un usage rationnel ;
2. `App` ou substitution nécessitent une multiplication des composantes `m` ou `ℓ` incompatible
   avec leur sémantique ;
3. l'indice comonadique de `!` doit porter intrinsèquement `β` ou `ℓ` pour rendre `SubBox` ou
   `Unbox` corrects ;
4. les lois de `Scale_Usage` échouent sur l'agrégation réelle des contextes.

Ces quatre tests sont suffisamment locaux pour permettre une décision sans construire d'abord toute
l'algèbre globale `𝒢`.

## 10. Verdict

**Établi :** `r` peut être décomposé en un indice d'usage `π_U(r)` et des annotations orthogonales
sans perdre l'information syntaxique du grade complet.

**Candidat fortement soutenu :** `Scale_Usage` pour `Box`, `App` et substitution.

**Candidat séparé :** `Scale_Exec` pour les règles qui disposent explicitement d'une multiplicité
d'exécution `n`.

**Non établi :** l'invariance du budget sous `Scale_Usage` ; elle dépend de la signification sémantique
de `β`.

**Non établi :** l'indice exact de la comonade `!` ; `I=𝕌` est désormais un candidat particulièrement
parcimonieux, avec `!_r` traité comme une annotation syntaxique factorisable par `π_U`.

**Conséquence architecturale :** A devient moins attractive comme multiplication globale obligatoire,
car les règles principales peuvent être satisfaites par deux actions typées. B et C gagnent en netteté,
mais aucune n'est encore ratifiée.