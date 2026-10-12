<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Piste de recherche L1 — opportunités autour de Rel

**Date :** 11 octobre 2026  
**Statut :** HORS PÉRIMÈTRE NORMATIF ACTUEL — note d'opportunité  
**Effet :** aucun changement des règles, de la grammaire ou de la spécification normative

## 1. Décision de périmètre pour la triade actuelle

Pour le périmètre courant de K7PL, les trois modes à retenir comme références de la sédimentation triadique sont :

| Couche | Mode de référence | Permissions structurelles visées | Rôle de couche |
|---|---|---|---|
| 1 | `Lin` | ni affaiblissement ni contraction | infrastructure linéaire et ressources uniques |
| 2 | `Aff` | affaiblissement, sans contraction | orchestration, flux et processus productifs |
| 3 | `Unr` | affaiblissement et contraction | calcul non restreint et constructions inductives |

La sélection de ces trois modes comme périmètre de référence est une décision d'architecture. Elle ne prouve pas à elle seule que les règles, conversions et propriétés métathéoriques réalisent déjà toutes les permissions énoncées. Ces correspondances, ainsi que le contrat exact des morphismes de modes, restent à normaliser et à prouver.

La quatrième possibilité, `Rel`, ne fait pas partie des modes instanciés dans les règles génératrices actuelles. Elle reste hors périmètre de l'implémentation et du langage normatif courant. Cette exclusion n'est pas une conclusion selon laquelle `Rel` serait inutile ou impossible : elle réserve les questions ci-dessous à une recherche ultérieure, sans les introduire implicitement dans les règles actuelles.

## 2. Deux objets distincts : intervalle d'usage et mode structurel

C2/C3 distinguent explicitement les intervalles d'usage des modes structurels.

### Intervalles d'usage

Le support d'usage est `𝓡 = ℚ≥0 ∪ {ω}`. Les domaines présentés sont :

| Intervalle | Domaine | Lecture intuitive |
|---|---|---|
| `U_Lin` | `[1..1]` | usage exactement une fois |
| `U_Aff` | `[0..1]` | usage au plus une fois |
| `U_Rel` | `[1..ω]` | usage au moins égal à la borne inférieure, sans borne supérieure finie |
| `U_Unr` | `[0..ω]` | usage sans restriction de borne |

Les inclusions ensemblistes donnent deux branches :
`U_Lin ⊆ U_Aff ⊆ U_Unr` et `U_Lin ⊆ U_Rel ⊆ U_Unr`.
`U_Aff` et `U_Rel` sont incomparables. Ces relations ensemblistes ne suffisent pas à établir des morphismes de modes.

Ces intervalles ne sont pas, avec les opérations héritées de `𝓡`, des algèbres de grades en général : par exemple `U_Aff` n'est pas clos sous addition, et `U_Rel` ne contient pas le neutre additif `0`. Il ne faut donc pas identifier `U_Rel` à lui seul à une réalisation structurelle de mode.

### Triplets structurels

La réalisation structurelle candidate exposée dans C2/C3 est :

| Mode candidat | Porteur | Grades contractables `Cont` | Affaiblissement `Weak` |
|---|---|---|---|
| `M_Lin` | `𝓡` | `{0}` | `false` |
| `M_Aff` | `𝓡` | `{0}` | `true` |
| `M_Rel` | `𝓡` | `𝓡` | `false` |
| `M_Unr` | `𝓡` | `𝓡` | `true` |

Les identités sur le porteur commun donnent, sous le contrat de morphisme envisagé, les flèches `M_Lin → M_Aff`, `M_Lin → M_Rel`, `M_Aff → M_Unr` et `M_Rel → M_Unr`. Il n'y a pas de flèche entre `M_Aff` et `M_Rel` dans l'un ou l'autre sens. C'est un diamant, dont la chaîne de sédimentation actuelle `Lin → Aff → Unr` constitue une branche.

Le candidat `M_Rel` n'est pas simplement le même objet que l'intervalle `U_Rel` : il a pour porteur toute l'algèbre `𝓡`, avec `Cont(M_Rel)=𝓡` et `Weak(M_Rel)=false`. La relation exacte entre cette structure et la restriction syntaxique d'usage `U_Rel` reste à définir et à justifier.

## 3. Opportunité architecturale à examiner plus tard

L'hypothèse architecturale à conserver pour une évolution future est que la couche 2 pourrait offrir deux régimes intermédiaires alternatifs entre Lin et Unr :

- **affine** : une ressource peut être abandonnée mais pas dupliquée ;
- **pertinent** : une ressource ne peut pas être abandonnée mais peut être dupliquée.

Dans le périmètre normatif courant, seule la branche Aff est instanciée en couche 2. Cette note documente l'opportunité de Rel sans l'activer et sans prétendre que les règles actuelles le réalisent.

Cette piste enrichirait la couche intermédiaire sans identifier `Aff` et `Rel` l'un à l'autre. Elle pourrait permettre d'exprimer des API, des ressources ou des contrats où l'existence d'un consommateur est obligatoire, mais où plusieurs usages sont permis. Ce bénéfice est une hypothèse de conception à instruire, pas un résultat établi sur les programmes K7PL.

Les questions ouvertes prioritaires sont les suivantes.

1. **Sémantique de l'usage.** Que signifie précisément `U_Rel=[1..ω]` lorsque `𝓡` contient les rationnels ? Le domaine contient des valeurs entre `1` et `2`, pas seulement des multiplicités entières. Il faut distinguer une quantité graduée abstraite d'un nombre discret d'utilisations et ne pas imposer une interprétation opérationnelle sans contrat.
2. **Lien entre `U_Rel` et `M_Rel`.** Définir la relation entre le domaine syntaxique d'usage, l'algèbre porteuse, l'idéal `Cont` et le prédicat `Weak`. Le simple fait qu'un grade appartienne à `U_Rel` ne prouve ni qu'il est contractable au sens structurel ni que les règles garantissent l'absence d'abandon.
3. **Sédimentation et couche 2.** Préciser en quoi une variante pertinente peut être associée au rôle de couche 2 sans rendre `Aff` et `Rel` comparables. Il faudrait décrire la relation entre les deux variantes et les structures communes de temporalité, effets, flux et productivité, plutôt que forcer une chaîne totale.
4. **Morphismes et fragments.** Définir complètement le contrat de morphisme des modes : préservation des opérations et de l'ordre, image des grades contractables, préservation de l'affaiblissement. Établir les flèches et les deux non-flèches sous ce contrat, puis vérifier leur réalisation dans les jugements et les règles K7PL.
5. **Métathéorie.** Examiner coupure/substitution, conversions `coerce`, identité et composition, conservation des budgets, compatibilité avec les effets et les règles de concurrence. Une esquisse des inclusions de `Cont` et de `Weak` ne remplace pas ces résultats.
6. **Coût d'intégration.** Identifier toutes les règles de grammaire, typage, inférence, diagnostics, exemples, tests et documents affectés. Comparer ce coût au cas d'usage qui justifierait réellement une quatrième réalisation.

## 4. Critères avant toute réouverture de périmètre

Une proposition future d'intégration de `Rel` devrait fournir, avant tout changement normatif :

- un cas d'usage précis qui n'est pas exprimable de manière satisfaisante par `Lin`, `Aff` ou `Unr` ;
- une définition cohérente qui sépare `U_Rel` comme intervalle d'usage de `M_Rel` comme triplet structurel ;
- le contrat de morphisme et le diagramme exact des inclusions et non-inclusions ;
- une analyse règle par règle, avec les obligations de substitution et de coupure correspondantes ;
- une séparation explicite entre preuve sur papier, formalisation Lean, tests et propriétés encore conjecturales ;
- une décision explicite sur la modification de la sédimentation publiée et des règles génératrices.

Jusqu'à satisfaction de ces critères et décision séparée, `Rel` reste une possibilité documentée et non une quatrième modalité activée. Aucun cas `U_Rel` ne doit être traité comme accepté par le seul fait que C2 en donne la formule.

## 5. Sources vérifiées dans le dépôt

- [C2 — Comonade exponentielle et fragments](../../spec/Spec/C2/ComonadeExponentielleEtFragments.lean) : triplets structurels, diamant des morphismes candidats, intervalles d'usage et distinctions entre ces objets.
- [C3 — Le système gradué](../../spec/Spec/C3/LeSystemeGradue.lean) : définition des intervalles, rappel qu'ils ne suffisent pas à définir des modes structurels, et statut de `thm:morphismes_modes` (`under-review`, `proofsketch`).
- [C1 — Axiomatique germinale](../../spec/Spec/C1/AxiomatiqueGerminale.lean) : sédimentation triadique actuelle — couche 1 linéaire, couche 2 affine, couche 3 cartésienne/non restreinte.
- [Audit typé C-01/C-02](L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md) : signatures, domaines et preuves conditionnelles des interfaces et des modes.

**État final de cette note :** opportunité de recherche documentée ; `Rel` hors périmètre normatif actuel ; aucune promotion d'un énoncé au statut de preuve ; porte C inchangée.
