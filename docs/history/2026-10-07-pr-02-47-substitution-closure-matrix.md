<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 47 : matrice de clôture de la substitution graduée

**Date :** 7 octobre 2026

Les séances 35 à 46 ont transformé la question initiale « quelle algèbre porte le grade ? » en un
ensemble borné d'interfaces. La présente séance vérifie que le lemme de substitution ne fait pas
apparaître un nouvel objet théorique caché.

## 1. Colonne scalaire : `Scale_Usage`

Les règles qui répliquent une dépendance dans un contexte utilisent la même interface :

`Scale_Usage(a,<u,m,ℓ,β>)=<a·u,m,ℓ,β>`.

Les obligations algébriques nécessaires sont déjà séparées et établies sur le candidat :

`SU(1,Δ)=Δ`,

`SU(a,SU(b,Δ))=SU(ab,Δ)`,

`SU(a,Δ₁+Δ₂)=SU(a,Δ₁)+SU(a,Δ₂)`.

La substitution n'introduit donc pas une seconde action scalaire.

## 2. Colonne effet : `φ_n`

Les répétitions effectives ne sont plus représentées par un grade rationnel. Lorsqu'une construction
produit explicitement une multiplicité entière `n`, la transformation de l'effet est
`φ_n`.

La substitution n'impose aucune définition de `φ_u` pour un usage rationnel. Les macros ont
confirmé ce point : la borne `r_i` et le compte syntaxique `occ_i(m)` sont deux objets
distincts.

## 3. Colonne consommation : `Cost_Budget` puis `Consume`

La consommation budgétaire se décompose désormais en deux opérations :

`Cost_Budget : (ℕ∞×ℕ∞)^ℒ ⇀ ℕ∞`,

puis

`Consume(β,κ) = β ⊖ Cost_Budget(κ)`

lorsque le coût est défini.

La substitution n'utilise pas directement `Cost_Budget`. Elle utilise `ψ`; cette
fonction encapsule la consommation.

Il n'est donc pas nécessaire de choisir à ce stade entre `Cost_Total` et `Cost_Max`
pour stabiliser l'architecture de `Scale_Usage`.

## 4. Colonne coercion

Pour `SubBox`, la relation complète

`r ≼ r'`

se projette en

`π_U(r) ≥ π_U(r')`.

Le lemme de substitution requiert ensuite que les transports de niveau, monotonie et budget soient
compatibles avec les constructeurs de types. Cette obligation est une propriété de conversions,
non une nouvelle composante du grade et non une nouvelle opération scalaire.

## 5. Colonne temporelle

La règle `When` transforme explicitement la famille temporelle en une approximation non
bornée. Elle doit donc être traitée comme une transformation d'effet. Elle n'ajoute aucune action
sur `𝒢`.

La règle courante exige déjà le contexte `□Δ_2`; elle fournit ainsi la disponibilité temporelle
persistante nécessaire à l'attente non bornée. La dette restante porte sur la définition exacte de
la transformation d'effet et son interaction avec la consommation budgétaire, pas sur l'index de
la comonade.

## 6. Matrice de clôture

| Cas | Objet théorique mobilisé | Statut |
|---|---|---|
| Variable | `Scale_Usage`, unité zéro | fermé au niveau architectural |
| Pair/Inj | additivité de `Scale_Usage` | fermé |
| Let/App | commutation `Scale_Usage`/`ψ` | fermée sur le candidat |
| Unbox/Open | même action contextuelle | fermé sous conversions |
| Sc | `Scale_Usage(n,-)` + `φ_n` | séparé, sans `Scale_Exec` |
| Sub/SubBox | conversions du grade complet | proposition conditionnelle |
| When | transformation de la famille `κ` + consommation | interface sémantique encore ouverte |
| Macro | `r_i` vs `occ_i(m)` | séparation établie |

Aucun nouveau type d'objet n'est nécessaire pour compléter cette matrice.

## 7. Conclusion sur l'étape C

Le point essentiel est désormais acquis au niveau architectural :

`𝒢` n'a pas besoin d'être une grade algebra homogène pour expliquer les règles actuelles.

Le noyau de `!` peut être indexé par `𝓡`, avec conservation du grade complet
`𝒢` dans l'annotation ;

`Scale_Usage` est l'action contextuelle unique requise par les règles de réplication ;

les transformations d'effets comme `φ_n` restent séparées ;

la consommation de budget est une interface `Cost_Budget` suivie de `Consume` ;

les coercions du grade complet sont un produit de transports composante par composante.

La question restante n'est donc plus « quel nouvel objet théorique faut-il inventer ? ». Elle est :
quelles propriétés de ces interfaces faut-il démontrer pour obtenir les théorèmes de substitution,
de cohérence et de préservation ?

**Statut de `TRANS-02` :** encore partiel. La théorie des objets est suffisamment structurée pour
que les dettes restantes soient des propriétés localisées plutôt que des ambiguïtés de signature.
La clôture scientifique de l'étape C exige encore l'instruction de `Cost_Budget`, la
fonctorialité des conversions du grade complet et les obligations de gradation indexée.
