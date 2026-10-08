<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 56 : loi exacte de conversion du grade complet

**Date :** 7 octobre 2026

Les séances précédentes ont montré que les conversions du grade complet ne nécessitent pas une
algèbre globale. La présente séance formule exactement la propriété qui reste à démontrer.

## 1. Conversion factorisée

Pour `r≼r'`, on décompose

`r = ⟨u,m,ℓ,β⟩`, `r' = ⟨u',m',ℓ',β'⟩`

avec `u≥u'`, `m⪰m'`, `ℓ≤ℓ'`, `β≤β'`.

Sur le constructeur exponentiel, la conversion candidate est

`Conv^!_{r,r',A} = coerce_{π_U(r),π_U(r'),A}`

accompagnée des transports orthogonaux des annotations `m`, `ℓ` et `β` dans le jugement.

Le grade complet n'est donc pas un indice supplémentaire de la comonade.

## 2. Fonctorialité

Les obligations exactes sont :

`Conv(r,r)=id` ;

`Conv(r,t)=Conv(s,t)∘Conv(r,s)` pour `r≼s≼t`.

Pour les composantes orthogonales, ces lois sont les lois de l'identité et de la composition des
relations d'annotation. Pour `!`, elles se réduisent aux lois de `coerce` de l'interface indexée.

Le véritable contenu de la preuve est donc la compatibilité de `coerce` avec les constructeurs
exponentiels, pas une multiplication sur `𝒢`.

## 3. Compatibilité avec l'échelle d'usage

Pour tout scalaire `a∈𝓡`, la direction de `SubBox` se conserve :

`r≼r' ⇒ a·π_U(r) ≥ a·π_U(r')`.

Une preuve complète doit en outre établir la commutation du transport avec l'action contextuelle,
c'est-à-dire une naturalité de la forme

`Conv(a·r,a·r') ∘ Scale_Usage(a,-) = Scale_Usage(a,-) ∘ Conv(r,r')`

après projection sur l'usage et identification des composantes orthogonales.

Cette loi est la condition exacte qui manque à l'induction de substitution lorsqu'une étape de
sous-typage apparaît autour d'un constructeur portant `!`.

## 4. Compatibilité avec `w` et `c`

La famille `coerce` doit également préserver la structure comonadique : les diagrammes de `w` et de
`c` doivent commuter pour les couples d'indices admissibles.

Il s'agit des lois standard de naturalité de la comonade graduée, spécialisées au support `𝓡`.
Elles ne demandent aucune opération sur `𝕄`, `ℒ` ou `𝔅`.

## 5. Verdict

**Objet architectural : fermé.** La conversion du grade complet est un produit de conversions
composante par composante.

**Dette de preuve localisée :** naturalité/fonctorialité de `coerce`, compatibilité avec `w` et `c`,
et commutation avec `Scale_Usage`.

Ces propriétés suffisent à remplacer l'ancienne dette vague de « cohérence des conversions ».
Elles doivent désormais être traitées comme obligations de preuve de l'architecture factorisée, et
non comme raisons de rouvrir le choix du porteur de grade.