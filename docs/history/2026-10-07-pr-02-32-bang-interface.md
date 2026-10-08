<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 32 : interface formelle de l'exponentielle `!`

**Date :** 7 octobre 2026

La question n'est plus « `!` est-elle indexée par `𝓡` ou `𝒢` ? », mais : quelle est la signature
minimale de l'interface d'exponentiation dont `Box`, `Unbox`, `SubBox`, contraction et substitution
ont effectivement besoin ?

## 1. Interface abstraite minimale

On note `I` le support d'indexation de l'exponentielle. Une interface candidate est :

```text
!     : I → End(C)
0_I   : I
1_I   : I
⊕     : I × I → I
w     : !_{0_I} A → A
c     : !_{i ⊕ j} A → !_{i} A ⊗ !_{j} A
comp  : I × I → I
```

Cette notation sépare volontairement l'opération d'agrégation `⊕` de l'opération qui compose les
indices. Dans une grade algebra classique elles peuvent correspondre respectivement à `+` et `·`.
Dans une architecture hétérogène, elles peuvent appartenir à une structure plus riche.

Les lois minimales attendues sont celles qui rendent `w` et `c` compatibles avec les indices :

`i ⊕ 0_I = i`,

`comp(1_I,i) = i = comp(i,1_I)`,

`comp(i, comp(j,k)) = comp(comp(i,j), k)` lorsque l'architecture choisie donne une associativité
strictement ou à isomorphisme près,

ainsi que les lois de compatibilité de `c` avec l'addition des indices.

Ces équations sont des obligations d'interface. Elles ne constituent pas encore une définition
normative de K7PL.

## 2. Ce que `Box` demande réellement

La règle actuelle est :

```text
Box   Δ ⊢ v : V
      ─────────────────────────
      r·Δ ⊢ box_r v : !_r V
```

Elle demande trois choses distinctes :

1. un indice capable d'annoter le résultat `!_r V` ;
2. une action capable de transformer le contexte `Δ` ;
3. une compatibilité entre ces deux usages du même `r`.

Elle ne demande pas encore que ces trois objets soient une seule multiplication.

On peut donc abstraire `Box` par :

`Box(r,Δ,v) : Scale_r(Δ) ⊢ box_r(v) : !_{Index(r)} V`.

Le choix de `Index` et de `Scale` constitue précisément la dette restante.

## 3. Ce que `Unbox` demande

`Unbox` utilise le même indice pour la valeur exponentiée et pour la liaison extraite :

`Δ₁ ⊢ v : !_r V` et `Δ₂, x:_r V ⊢ c : C | ε`.

Il faut donc une opération d'élimination qui préserve l'identité de l'indice :

`Unbox(r, !_r V) ↦ x:_r V`.

Il n'y a pas besoin ici d'une multiplication d'indices. Le point critique est la correspondance
entre la représentation syntaxique de `r` et l'indice effectivement porté par la comonade.

## 4. Ce que la contraction demande

La présentation graduée actuellement utilisée contient la structure :

`c_{r,s} : !_{r+s} A → !_r A ⊗ !_s A`.

Cette règle donne la contrainte la plus forte sur l'indexation : elle exige une opération
d'agrégation d'indices fermée sur le support de `!`.

Si `!` est indexée par `𝕌`, cette loi est directement exprimable avec l'addition de `𝕌`.

Si `!` est indexée par `𝒢`, il faut une opération `⊕_G : 𝒢×𝒢→𝒢` et une preuve de fermeture.

Mais la contraction ne justifie pas, à elle seule, une multiplication sur `𝒢`.

## 5. Ce que `SubBox` ajoute

`SubBox` compare le grade complet :

`r ≼ r'  ⇒  !_r V <: !_{r'} V`.

Cela introduit une seconde structure sur le support syntaxique : un préordre de conversion.

Si `I = 𝕌`, il faut alors une projection ou une reconstruction reliant le grade complet au seul
indice de `!`.

Si `I = 𝒢`, le préordre est directement porté par l'indice syntaxique, mais il faut démontrer
que les conversions ainsi définies sont compatibles avec l'exponentielle.

Dans les deux cas, une propriété essentielle est :

`r ≼ r'  ⇒  Index(r) ≤_I Index(r')`

ou la variante contravariante correspondante selon la convention retenue pour `!`.

Le sens ne doit pas être choisi par analogie : il doit être dérivé de la direction exacte des
coercions de `SubBox`.

## 6. Confrontation règle par règle

| Construction | Indice de `!` | Action de contexte | Relation avec `≼` | Obligation centrale |
|---|---|---|---|---|
| `Box` | introduit | `Scale(r,-)` | aucune au départ | compatibilité `Index/Scale` |
| `Unbox` | lit | aucune | aucune au départ | conservation de l'indice |
| `SubBox` | transforme | aucune | oui | fonctorialité des conversions |
| contraction | combine | éventuellement aucune | pas directement | fermeture de `⊕` |
| substitution | indirect | `Scale(r,-)` | oui dans les cas de conversion | compatibilité avec `AggG` et `Scale` |
| `Sc` | aucun `!` direct | `Scale_Exec(n,-)` | aucune | ne pas injecter `n` dans l'indice de `!` sans justification |

Le point décisif est visible dans la dernière ligne : `Sc` n'a pas besoin de redéfinir l'exponentielle
pour exprimer la répétition d'un calcul. Cela renforce la séparation entre l'indice de `!` et le
scalaire d'exécution.

## 7. Test `I = 𝕌`

Cette architecture conserve directement la structure de comonade graduée déjà construite :

`!_u`, avec `u ∈ 𝕌`,

`c_{u,v} : !_{u+v} A → !_u A ⊗ !_v A`,

et les morphismes de conversion entre indices d'usage.

Elle impose cependant que les composantes `m`, `ℓ` et `β` du grade complet soient transportées
hors de l'index de la comonade. `SubBox` doit alors comparer une annotation complète tout en ne
pilotant directement que sa projection d'usage.

Le point à démontrer devient donc une propriété de projection, pas une algèbre globale nouvelle.

## 8. Test `I = 𝒢`

Cette architecture respecte immédiatement la syntaxe `!_r` et fait de `SubBox` une relation
directement interne au support de l'exponentielle.

Mais il faut alors fournir au support `𝒢` :

- une agrégation d'indices pour la contraction ;
- une composition d'indices pour la comonade graduée ;
- un ordre compatible avec les conversions ;
- les unités et absorptions correspondantes ;
- et les actions nécessaires à `Box`, `App` et substitution.

Les séances 25–31 n'ont pas démontré que ces structures existent avec les opérations sémantiques
déjà requises par K7PL.

## 9. Test intermédiaire : indice structurel + annotation complète

Une troisième forme mérite donc d'être explicitement distinguée des deux précédentes :

`!_{Index(r)} V`, où `r = ⟨u,m,ℓ,β⟩` reste l'annotation complète portée par le type ou la liaison.

Cette forme n'est pas une nouvelle architecture au sens sémantique. C'est une factorisation de la
syntaxe actuelle qui permet de tester séparément :

`Index : 𝒢 → I`,

`Scale : I × 𝒢 ⇀ 𝒢`,

`SubBox : 𝒢 × 𝒢 → Prop`.

Elle rend surtout explicite ce qui était auparavant contenu implicitement dans le symbole `r`.

## 10. Critère de rejet

Une architecture d'indexation sera rejetée si elle exige l'une des identifications suivantes sans
preuve :

`Usage = Exec`,

`MulG = Scale`,

`Scale = φ`,

`Consume = MulG`,

ou

`index syntaxique de ! = totalité du grade`.

Ces identifications sont des simplifications possibles, mais aucune n'est gratuite.

## 11. Verdict

**Établi :** l'interface minimale de `!` exige un support d'indices, une agrégation pour la
contraction, une opération de composition des indices, des conversions et des lois de compatibilité.

**Établi :** `Box` couple l'indice de `!` à une action sur le contexte, mais n'établit pas que cette
action soit la multiplication de l'algèbre d'indices.

**Établi :** `SubBox` ajoute une structure de conversion indépendante des lois d'agrégation.

**Établi :** `Sc` constitue un témoin indépendant du régime `Exec`.

**Non établi :** `I = 𝕌` comme architecture complète de K7PL, car il faut reconstruire la place de
`m`, `ℓ` et `β` dans `SubBox` et `Box`.

**Non établi :** `I = 𝒢`, car la structure algébrique complète nécessaire n'est pas démontrée.

**Résultat provisoire :** la factorisation `Index : 𝒢 → I` est le meilleur objet de comparaison pour
la suite, car elle permet de tester `I = 𝕌` et `I = 𝒢` sans modifier prématurément les règles.

Cette démarche est cohérente avec les deux familles de résultats consultées : les grades hétérogènes
peuvent être construits à partir de plusieurs algèbres et de morphismes explicites, tandis que les
ILEC permettent une indexation de `!` par une structure multi-objet plus riche qu'un simple
semi-anneau. [Bianchini et al., 2023](https://doi.org/10.4230/LIPIcs.ECOOP.2023.3) ;
[Fukihara & Katsumata, 2021](https://doi.org/10.1007/978-3-030-71995-1_12).