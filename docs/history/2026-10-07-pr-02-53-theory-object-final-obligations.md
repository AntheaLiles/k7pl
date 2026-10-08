<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 53 : fermeture des signatures et bornage des obligations restantes

**Date :** 7 octobre 2026

La séance 52 avait établi que les ambiguïtés de signature étaient résolues. La présente séance
vérifie que les objets restants peuvent être décrits par des propriétés de cohérence localisées,
sans rouvrir l'architecture générale du grade.

## 1. Action contextuelle

L'action de référence reste

`Scale_Usage(a,⟨u,m,ℓ,β⟩)=⟨a·u,m,ℓ,β⟩`.

Sur son candidat, les lois suivantes sont des conséquences de l'arithmétique du semi-anneau d'usage :

`Scale_Usage(1,Δ)=Δ` ;

`Scale_Usage(a,Scale_Usage(b,Δ))=Scale_Usage(a·b,Δ)` ;

`Scale_Usage(a,Δ₁+Δ₂)=Scale_Usage(a,Δ₁)+Scale_Usage(a,Δ₂)` lorsque l'agrégation est définie.

La monotonie sur la composante usage suit de la monotonie de la multiplication dans `𝓡`. La
commutation avec `ψ` suit du fait que `ψ` ne modifie que le budget.

Il n'y a donc aucune obligation de définir `φ_a` pour les usages rationnels.

## 2. Répétition effective

`Sc` utilise la même action contextuelle `Scale_Usage(n,-)` que les autres règles de mise à l'échelle.
La répétition effective est représentée séparément par `φ_n` sur l'effet.

Le langage actuel ne requiert donc pas d'objet `Scale_Exec` sur `𝒢`. Une telle action resterait une
extension possible, mais elle ne doit pas figurer dans l'architecture de référence.

## 3. Coercions du grade

Le transport associé à `r≼r'` doit être factorisé en un transport d'usage et trois transports
orthogonaux pour monotonie, niveau et budget.

Les propriétés à démontrer sont :

`Conv(r,r)=id` ;

`Conv(r,t)=Conv(s,t)∘Conv(r,s)` pour `r≼s≼t` ;

compatibilité de la conversion d'usage avec `coerce`, `w` et `c` ;

compatibilité de l'ensemble avec `Scale_Usage` et les constructeurs de `!`.

Les jointures du produit des quatre ordres ne démontrent aucune de ces propriétés à elles seules.

## 4. Consommation budgétaire

Le coût temporel est une famille

`κ : ℒ → (ℕ∞×ℕ∞)`.

Le travail et la profondeur sont

`W(κ)=Σℓ wℓ` et `D(κ)=supℓ sℓ`.

Si le budget reste scalaire et P3 exige une borne commune des deux dimensions, alors toute
scalarisation `C` admissible doit satisfaire `W≤C` et `D≤C`. Elle vérifie donc nécessairement
`max(W,D)≤C`.

Le candidat minimal est par conséquent

`Cost_Budget(κ)=max(W(κ),D(κ))`.

Ce résultat est conditionnel aux deux décisions déjà présentes dans la spécification : budget scalaire
et borne simultanée du travail et de la profondeur. Il ne crée pas une nouvelle propriété du grade.

Une précision supplémentaire est nécessaire : l'opération arithmétique `β⊖k` est définie par cas
pour toutes les valeurs, mais la consommation sémantiquement admissible est partielle. Il faut donc
distinguer l'opération `⊖` de la condition d'admissibilité `k≤β` ou `β=ω`.

## 5. Gradation indexée

Le support effectif de `!` reste `𝓡`. Les lois minimales sont celles de `coerce`, `w` et `c`, avec
leurs compatibilités usuelles. La projection

`π_U : 𝒢→𝓡`

relie ces indices au grade complet ; elle conserve la direction de `SubBox`.

La syntaxe `!_r A` doit donc être comprise comme une annotation complète factorisée par l'indice
d'usage, et non comme la preuve d'une algèbre globale de `𝒢`.

## 6. Substitution et `When`

Les cas de substitution hors conversions utilisent uniquement `Scale_Usage` et ses lois closes.
Les cas `Sub`/`SubBox` exigent les conversions du grade ; `When` reste une transformation temporelle
qui doit être cohérente avec l'interface `Cost_Budget` et la disponibilité temporelle.

Ces deux dettes sont donc des propriétés de preuves, pas des objets théoriques supplémentaires.

## 7. Verdict

**Signatures stabilisées :** `𝓡`, `𝒢`, `!`, `Scale_Usage`, `Consume`, `Cost_Budget` et les conversions
du grade ont des frontières explicites.

**Architecture stabilisée au niveau conceptuel :** `𝒢 → 𝓡 → !`, avec `Scale_Usage` comme action
contextuelle et `φ_n` comme transformation séparée des effets.

**Objet dérivé sous hypothèses déjà normatives :** `Cost_Budget=max(W,D)` comme scalarisation scalaire
minimale.

**Obligations restantes :** fonctorialité sémantique des conversions, fermeture de la substitution
sous ces conversions, définition exacte des agrégateurs temporels sur `ℒ`, et interaction de `When`
avec la consommation budgétaire.

À partir de cet état, une nouvelle exploration d'une algèbre globale homogène de `𝒢` ne serait plus
justifiée par les règles actuelles. La suite doit se concentrer sur les preuves et la ratification.