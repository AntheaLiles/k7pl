<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 38 : séparation et vérification des lois de cohérence

**Date :** 7 octobre 2026

La séance 37 a stabilisé la notation `𝓡`/`𝒢`. La présente séance teste maintenant les lois exactes
requises par la substitution après séparation entre `Usage` et `Exec`.

## 1. Action d'usage

Le candidat est

`Scale_Usage(a,⟨u,m,ℓ,β⟩) = ⟨a·u,m,ℓ,β⟩`.

Cette action est précisément adaptée à `Box`, `App` et substitution. Elle ne transforme ni le niveau,
ni la monotonie, ni le budget.

## 2. Commutation avec `ψ`

`ψ` traverse inchangées les composantes usage, monotonie et niveau ; elle ne modifie que le budget.
`Scale_Usage` ne modifie elle-même que l'usage. Dès lors, pour tout couple où `ψ(Δ,ε)` est définie,

`Scale_Usage(a,ψ(Δ,ε)) = ψ(Scale_Usage(a,Δ),ε)`.

Cette égalité ne demande aucune transformation d'effet `φ_a`. Elle est donc valable indépendamment
du caractère rationnel de `a` et retire la principale difficulté artificielle de l'ancienne loi
universelle `r·ψ = ψ(r·Δ,φ_r ε)`.

## 3. Composition de l'action d'usage

Par associativité et multiplication du semi-anneau d'usage :

`Scale_Usage(a,Scale_Usage(b,Δ)) = Scale_Usage(a·b,Δ)`.

L'identité est `Scale_Usage(1,Δ)=Δ`.

Ces deux lois sont établies sur la définition candidate elle-même, sans hypothèse sur une algèbre
globale `MulG`.

## 4. Distribution sur l'agrégation

Pour l'agrégation des contextes définie composante par composante, et dès lors que la composante usage
est agrégée par `+` :

`Scale_Usage(a,Δ₁+Δ₂) = Scale_Usage(a,Δ₁)+Scale_Usage(a,Δ₂)`.

Le facteur usage utilise la distributivité du semi-anneau. Les trois autres composantes sont inchangées
par `Scale_Usage`, donc leurs opérations d'agrégation apparaissent identiquement des deux côtés.

Cette loi est la propriété manquante dans les cas `Pair`, `Inj` et les recombinaisons de contextes de
la substitution.

## 5. Monotonie

Pour `a` positif dans le semi-anneau d'usage, la multiplication préserve l'ordre usuel de `𝓡`. Elle
préserve donc également la direction inversée du sous-typage sur la composante usage : si
`u ≥ u'`, alors `a·u ≥ a·u'`.

Le facteur usage de `Scale_Usage` est ainsi compatible avec la projection de `SubBox` :

`r ≼ r' ⇒ π_U(r) ≥ π_U(r') ⇒ a·π_U(r) ≥ a·π_U(r')`.

Il n'y a donc pas de conflit local entre la projection du sous-typage et la mise à l'échelle d'usage.

## 6. Action d'exécution

Pour une multiplicité finie et positive `n`, le candidat est

`Scale_Exec(n,⟨u,m,ℓ,β⟩) = ⟨n·u,m,ℓ,n·β⟩`.

L'action d'effet associée est

`Action_Exec(n,ε)=ε^n`.

`Scale_Exec` est donc la bonne action pour les règles où `n` représente réellement une répétition.

## 7. Test budgétaire exact

Sur `β∈ℕ∞`, avec la définition normative actuelle de `⊖`, l'égalité

`n(β⊖k)=nβ⊖nk`

est vraie pour toute multiplicité finie `n≥1` et tout `β,k∈ℕ∞`.

Le contrôle se fait par cas :

- si `β` et `k` sont finis, c'est la distributivité de la multiplication entière sur la soustraction tronquée ;
- si `β=ω`, les deux côtés valent `ω` pour `n≥1` ;
- si `k=ω` et `β<ω`, les deux côtés valent `0` ;
- les cas `n>0` et les conventions `ω·a=ω` pour `a>0` ferment les cas restants.

Le cas `n=0` est volontairement séparé : comme `ψ` est une opération partielle, l'équivalence des
domaines doit alors être formulée autrement. Il ne faut pas inclure ce cas dans la loi de commutation
générale sans le traiter explicitement.

Pour `n≥1`, la condition d'admissibilité budgétaire est également préservée : `β` couvre `k` si et
seulement si `nβ` couvre `nk`.

## 8. Commutation `Scale_Exec` / `ψ`

Sur le domaine `n≥1`, la loi budgétaire précédente et la définition de `Action_Exec` donnent la loi
candidate :

`Scale_Exec(n,ψ(Δ,ε)) = ψ(Scale_Exec(n,Δ),Action_Exec(n,ε))`.

Contrairement à `Scale_Usage`, cette loi nécessite réellement une transformation de l'effet.
Elle ne s'applique donc que sur le domaine des multiplicité d'exécution effectives.

## 9. Conséquence pour la substitution

La preuve de substitution peut désormais utiliser deux paquets de lois différents.

Pour `Box`, `App`, `Pair`, `Inj` et substitution :

`Scale_Usage` apporte identité, composition, distribution sur l'agrégation, commutation avec `ψ` et
monotonie.

Pour `Sc` et les constructions explicitement répétitives :

`Scale_Exec` apporte l'action temporelle et la compatibilité budgétaire avec `ψ` sur son domaine.

Il n'est donc plus nécessaire de supposer une action unique du grade complet ni une famille
`φ_r` définie pour tout `r∈𝒢`.

## 10. Dette restante

Deux obligations restent non résolues.

Premièrement, les conversions de `Sub` et `SubBox` doivent être fonctorielles et compatibles avec
les constructeurs qui portent `!` et avec `Scale_Usage`.

Deuxièmement, la règle `When` transforme la composante temporelle du grade sans que la compatibilité
de cette transformation avec `Scale_Usage` et `Scale_Exec` soit encore démontrée.

La première dette concerne désormais la cohérence des conversions ; la seconde concerne la temporalité.
Ni l'une ni l'autre ne justifie de réintroduire une multiplication globale `𝒢×𝒢→𝒢`.

## 11. Verdict

**Établi sur le candidat `Scale_Usage` :** identité, composition, distribution sur l'agrégation,
commutation avec `ψ` et compatibilité avec la direction du sous-typage d'usage.

**Établi arithmétiquement :** la loi budgétaire de `Scale_Exec` pour toute multiplicité finie positive.

**Établi architecturalement :** les lois nécessaires à l'usage et à l'exécution sont de deux sortes
distinctes ; leur fusion en une loi `φ_r` universelle est inutile et scientifiquement trop forte.

**Encore ouvert :** cohérence des conversions de `Sub`/`SubBox` et interaction avec `When`.

Le noyau de l'architecture factorisée `𝒢 → 𝓡 → !`, avec `Scale_Usage` pour l'usage et `Scale_Exec`
pour l'exécution, devient donc la construction de référence pour la suite de PR-02, sans encore être
ratifié comme résultat final.