<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 30 : le triplet `!` / `Scale` / `φ`

**Date :** 7 octobre 2026

Les séances 28 et 29 ont séparé les opérations de grade et distingué les sortes `Usage` et `Exec`.
Le texte contient cependant encore trois interfaces qui pourraient être traitées séparément : l'indice
de la comonade `!`, l'action `Scale` sur les contextes et l'action `φ` sur les effets. La lecture croisée
des règles montre qu'elles forment en réalité un seul point de cohérence.

## 1. Le couplage dans les règles

`Box` introduit `!_r V` tout en appliquant `r·Δ` au contexte. La règle d'application reprend le même
`r` dans le type de fonction et dans la mise à l'échelle du contexte de l'argument. Enfin la loi
distributive relie l'action sur le contexte à une action sur l'effet.

On a donc le schéma minimal :

```text
                    r
                    │
          ┌─────────┼─────────┐
          ▼         ▼         ▼
       Index!      Scale      φ / Action
          │         │         │
          └─────────┼─────────┘
                    ▼
              cohérence de Box/App
                    │
                    ▼
              substitution
```

Ce schéma impose une conséquence méthodologique : démontrer séparément `!`, `Scale` et `φ` ne suffit
pas. Il faut aussi démontrer qu'ils reçoivent des indices compatibles.

## 2. Deux architectures minimales

### Architecture I — indice d'usage

`!` est indexée par `u ∈ 𝕌`, et l'annotation complète
`r = ⟨u,m,ℓ,β⟩` est décomposée en un indice modal `u` et des annotations orthogonales.

La règle `Box` devient conceptuellement :

`Scale_u(Δ) ⊢ box_r v : !u V`.

Cette forme est cohérente avec la partie déjà établie de la comonade graduée. Elle ne résout pas pour
autant le budget : une mise à l'échelle par un usage rationnel ne produit pas automatiquement une
mise à l'échelle entière de `β`.

### Architecture II — indice complet

`!` est indexée directement par `r ∈ 𝒢`.

Cette forme conserve la syntaxe actuelle, mais exige alors une structure d'indexation complète sur
`𝒢`, ainsi qu'une multiplication d'indices compatible avec la comonade. Les séances 25–29 ont montré
que cette multiplication ne peut pas être supposée identique aux opérations d'agrégation du niveau
ou à la consommation budgétaire.

## 3. Critère de comparaison

Les deux architectures doivent être comparées sur quatre propriétés, et non sur la seule élégance de
la notation.

| Propriété | Indice d'usage | Indice complet |
|---|---|---|
| comonade graduée existante | directe | à construire |
| usages rationnels | naturels | naturels si `𝒢` les conserve |
| budget dans l'indice | orthogonal, à transporter | intrinsèque mais algébriquement exigeant |
| `SubBox` sur `r` complet | nécessite une coercion entre annotations | naturel syntaxiquement, sémantique à établir |

Le critère décisif est le coût des transports. Une architecture qui exige une conversion implicite
entre `u`, `n`, `β` et `r` n'est pas plus simple parce que sa notation est plus compacte.

## 4. Conséquence pour `φ`

`φ` ne peut pas être défini seulement à partir de l'indice syntaxique de `!`.

Pour l'usage `u`, la structure disponible décrit un degré d'emploi. Pour `Exec = ℕ∞`, la structure
décrit une répétition d'exécution et supporte l'action

`Action(n,ε) = ε^n`.

Le candidat naturel est donc une factorisation où la règle connaît explicitement le type du scalaire :

`r --usage--> u` pour la discipline de ressource ;

`r --exec--> n` lorsque l'effet et le temps doivent être répétés.

Une telle factorisation ne dit pas encore comment `n` est obtenu à partir de `r`. Elle dit seulement
qu'aucune règle ne doit l'inférer par simple convention `n = u`.

## 5. Conséquence pour `Box` et `App`

Le symbole `r·Δ` masque désormais un choix qui doit être rendu local à chaque règle.

Pour `Box`, le terme introduit une valeur sous `!`. Son corps est une valeur et ne possède pas, par
lui-même, un effet à répéter. Une action de type `Exec` n'est donc pas automatiquement justifiée.

Pour `App`, le contexte de l'argument est utilisé à hauteur de la demande portée par la fonction.
Cette demande relève directement de l'usage de l'argument. Si cet usage peut être rationnel, une
action de contexte par `Usage` peut être nécessaire, mais elle ne doit pas être confondue avec la
répétition d'un effet.

Le choix le plus sobre à ce stade est donc un opérateur paramétré par sorte, éventuellement partiel :

`Scale(kind, scalar, grade)`.

Il laisse ouverte la question de savoir quelles composantes du grade sont modifiées par chaque sorte.

## 6. Nouvelle obligation de preuve

Avant de mécaniser la substitution, il faut établir un diagramme de commutation de la forme :

```text
          r
       ┌───────┐
       ▼       │
    Index!    Scale
       │       │
       └───┬───┘
           ▼
       Action/φ
           │
           ▼
          ψ
```

Plus précisément, les morphismes induits par un même indice doivent être compatibles avec :

1. l'agrégation des contextes ;
2. la consommation budgétaire ;
3. l'action sur les effets ;
4. les conversions de `SubBox`.

Ce diagramme remplace une partie de la formulation globale précédente. Il ne rajoute pas une hypothèse
aux quatre composantes : il identifie la frontière exacte où elles doivent interagir.

## 7. Verdict

**Établi :** `!`, `Scale` et `φ` forment un même groupe de dépendances pour `Box`, `App` et substitution.

**Établi :** `!` indexée par `𝕌` est cohérente avec la construction de comonade déjà disponible.

**Établi :** une indexation complète par `𝒢` est possible en principe mais demande une algèbre d'indices
complète qui n'est pas encore établie.

**Établi :** `Usage` et `Exec` ne peuvent pas être identifiés par convention.

**Non établi :** le scalaire exact de `Box` et `App`.

**Non établi :** le statut des composantes `m`, `ℓ` et `β` dans l'index de `!`.

**Décision provisoire :** traiter `r·Δ` comme une notation de surface pour une famille d'actions `Scale`
paramétrées par sorte, jusqu'à résolution de `QA-32`.

Cette formulation est compatible avec la littérature sur les grades hétérogènes : le problème n'est pas
de savoir si plusieurs structures de grades peuvent coexister, mais de déterminer quelles traductions et
quelles lois croisées K7PL exige réellement. {cite "bianchiniMultiGradedFeatherweightJava2023"}[]
Les systèmes multimodaux plus récents renforcent ce point en permettant à des notions de ressource
distinctes de coexister explicitement. {cite "hanukaevUnificationGradedSubstructural2026"}[]