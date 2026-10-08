<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 22 : test du noyau à grades typés

**Date :** 7 octobre 2026

La séance précédente a montré que le grade complet ne peut pas être considéré sans précaution
comme un scalaire homogène. Cette séance teste l'hypothèse plus faible selon laquelle les opérations
du noyau utilisent des grades appartenant à des sortes différentes, chacune avec son algèbre et,
si nécessaire, ses morphismes de transport.

## 1. Question

Le problème à tester est :

> Peut-on conserver une annotation complète `⟨u,m,ℓ,β⟩` tout en attribuant à chaque position le
> domaine algébrique qui lui est propre, et en distinguant le scalaire d'une règle de la totalité
> des annotations du contexte ?

Cette question se situe entre les architectures B et C de la séance 21.

## 2. Fait discriminant

Dans le noyau actuel, `r` intervient comme annotation complète dans :

`!_r V`,
`V_r \multimap C`,
`SubBox`,
`r·Δ`.

Dans `VecI`, `VecE` et `Scoped`, le scalaire est au contraire `n`, issu d'une taille ou d'une
multiplicité d'itération, et l'opération est `n·Δ`.

La syntaxe utilise donc déjà deux familles de scalaires. Les assimiler est une hypothèse
supplémentaire, non une conséquence de la notation.

## 3. Test d'une architecture à grades typés

On introduit ici une hypothèse de travail, sans nouvelle syntaxe normative :

- `Usage` : grades de ressource pouvant contenir des valeurs rationnelles comme `1/N` ;
- `Exec` : multiplicateurs servant à répéter un calcul et son effet ;
- `Mono` : marque de monotonie ;
- `Level` : niveau de confidentialité ;
- `Budget` : potentiel temporel dans `ℕ∞`.

Le grade complet reste alors une annotation composée, mais ses opérations ne sont plus supposées
être celles d'un seul scalaire.

Cette séparation est compatible avec deux résultats publiés mais ne s'y réduit pas. Bianchini et
al. montrent qu'une famille d'algèbres de grades reliées par des homomorphismes peut produire des
grades hétérogènes tout en conservant la métathéorie de la gradation. GRASS, de son côté, associe
chaque mode à une algèbre de grades et définit la mise à l'échelle d'un vecteur via des morphismes
de modes. Ces cadres constituent donc des modèles de conception, pas une preuve que K7PL doit les
adopter.

## 4. Pré-modèle minimal

Un candidat minimal serait :

`g = ⟨u,m,ℓ,β⟩`

avec une opération de combinaison

`g ⊕ h = ⟨u ⊕_U u', m ⊕_M m', ℓ ⊕_L ℓ', β ⊕_B β'⟩`

et une opération scalaire distincte

`q ⋅ g = ⟨q ⋅_U u, q ⋅_M m, q ⋅_L ℓ, q ⋅_B β⟩`

lorsque le scalaire `q` appartient à un domaine qui agit effectivement sur chacune des
composantes.

Cette écriture est volontairement incomplète. Elle expose précisément ce qu'il faut décider :
pour chaque `q`, quelles composantes reçoivent une action, avec quelles opérations, et quels
morphismes rendent cette action typée.

Elle interdit en revanche la formulation actuelle « multiplier tous les grades par `r` » tant que
le type de `r` n'a pas été déterminé.

## 5. Conséquence pour `φ`

Le pré-modèle sépare immédiatement deux usages :

`Exec × Effect → Effect` pour l'itération d'un calcul ;
`Usage` pour la quantité de ressource exigée par une liaison.

La définition `φ_r(ε)` ne peut donc pas être acceptée seulement parce que `r` contient un champ
`Usage`. Il faut un morphisme ou une application explicite de `r` vers `Exec` si le grade complet
doit déterminer une itération.

Pour `u = 1/N`, une telle application ne peut être donnée par identité. Une capacité fractionnée
n'est pas une multiplicité d'exécution.

## 6. Test des architectures

A — **Algèbre globale `𝓖`** : elle est mathématiquement recevable. Bianchini et al. montrent
qu'un produit de grade algebras est encore un grade algebra. Le problème n'est donc pas l'existence
d'une structure algébrique possible, mais son adéquation aux quatre composantes de K7PL : il faut
définir des opérations sur la monotonie, le niveau et le budget qui aient exactement le sens demandé
par les règles, puis montrer que le même produit rend correctement compte de `r·Δ`, de `SubBox`
et de la contraction. L'existence abstraite du produit ne vaut pas preuve de cette adéquation.

B — **Comonade indexée par `𝕌` + annotations orthogonales** : elle résout naturellement la
distinction entre index comonadique et grade complet, mais elle doit expliquer comment une
annotation complète participe à `SubBox`, `Box` et à l'application. Une solution par simple
sucre syntaxique reste à construire.

C — **Grades hétérogènes / multimodaux** : elle fournit directement le vocabulaire des sortes,
des algèbres et des morphismes. Elle peut également faire porter la restriction « ce scalaire est
de type `Exec` » dans le système de sortes plutôt que comme condition textuelle sur les preuves.
C'est actuellement l'architecture qui offre la meilleure réduction des hypothèses implicites.

D — **ILEC** : elle traite proprement l'indexation catégorique multi-objet, mais n'élimine pas à
elle seule la distinction `Usage` / `Exec`. Son coût ne serait justifié que si l'indexation de
`!` s'avère elle-même multi-objet après le test B/C.

## 7. Résultat de la séance

La préférence pour une architecture à grades typés/kindés devient **provisoire**, mais le
résultat doit être lu comme un critère de comparaison et non comme une élimination de A. A reste
un candidat mathématiquement viable ; C est préféré provisoirement parce qu'il permet de rendre
explicites les domaines des scalaires et des morphismes. Cette préférence sera abandonnée si A fournit
la même expressivité avec moins d'hypothèses sémantiques et une preuve plus simple.

Deux questions doivent désormais être falsifiées :

1. Peut-on typer toutes les occurrences de `r·Δ` et `n·Δ` sans ajouter une opération artificielle ?
2. Peut-on faire dériver `φ` d'un domaine `Exec` sans perdre les comportements actuellement
attribués aux grades rationnels ?

La prochaine étape est donc la construction d'une table règle → type du scalaire → composantes
affectées → loi requise. Cette table devra être suffisamment précise pour servir ensuite de
spécification de l'encodage Lean.

## Références

Bianchini, Riccardo; Dagnino, Francesco; Giannini, Paola; Zucca, Elena. *Multi-Graded Featherweight
Java*. ECOOP 2023, LIPIcs 263, 3:1–3:27. DOI 10.4230/LIPIcs.ECOOP.2023.3.

Hanukaev, Peter; Eades, Harley. *A Unification of Graded and Substructural Logics*. 2026,
arXiv:2605.17112, DOI 10.48550/ARXIV.2605.17112.

Fukihara, Yōji; Katsumata, Shin-ya. *Generalized Bounded Linear Logic and Its Categorical Semantics*.
FoSSaCS 2021, LNCS 12650, pp. 226–246. DOI 10.1007/978-3-030-71995-1_12.