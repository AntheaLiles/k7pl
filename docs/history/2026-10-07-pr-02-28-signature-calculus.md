<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 28 : calcul de signatures pour les grades

**Date :** 7 octobre 2026

La séance précédente avait isolé deux opérations qui ne doivent pas être confondues :

`MulG : 𝒢 × 𝒢 → 𝒢`, multiplication éventuelle d'une algèbre de grades globale ;

`Scale : S × 𝒢 ⇀ 𝒢`, action qui réalise la mise à l'échelle effectivement écrite par les règles.

La présente séance descend d'un niveau supplémentaire : elle inventorie les opérations réellement demandées par le fragment minimal `Box–App–SubBox–substitution`, puis vérifie si une même famille algébrique peut les porter.

## 1. Quatre familles d'opérations

Le texte actuel superpose quatre choses.

1. **Agrégation de contextes.** `Δ₁ + Δ₂` combine deux exigences portant sur les mêmes liaisons. C'est une opération binaire sur les annotations de contexte. Elle intervient notamment dans `Pair`, `Par` et dans la définition de `⊠`.

2. **Composition graduée.** Une éventuelle `MulG(r,s)` serait l'opération interne de l'algèbre de grades qui apparaît dans les lois de composition d'une comonade graduée ou d'un système de types paramétré par une grade algebra.

3. **Mise à l'échelle.** `r·Δ` est une action utilisée par `Box`, `App` et substitution. Son domaine n'est pas encore fixé et rien n'impose qu'elle soit `MulG`.

4. **Consommation budgétaire.** `ψ(Δ,ε)` applique `β ⊖ k`. Cette opération est indexée par un effet et n'est ni l'agrégation d'exigences, ni une multiplication de grades.

La première conclusion est donc négative : une table unique « composante → opération de composition » ne peut pas être retenue comme interface normative.

## 2. Signature minimale

On retient, à ce stade, les signatures abstraites suivantes.

```text
AggG       : 𝒢 × 𝒢 → 𝒢
MulG       : 𝒢 × 𝒢 → 𝒢
Scale      : S × 𝒢 ⇀ 𝒢
Consume    : 𝔅 × Time → 𝔅 ⇀ 𝔅
```

`AggG` est la reconstruction de `Δ₁ + Δ₂` sur les annotations ; `Consume` désigne `β ⊖ k`.

La notation `⇀` est intentionnelle. Une action n'est pas déclarée totale avant que son domaine soit connu.

Le scalaire de `Scale` ne doit pas être appelé « grade » sans qualification. Deux candidats existent :

`S = 𝕌`, pour une mise à l'échelle directement commandée par l'usage ;

`S = 𝔑∞`, pour une mise à l'échelle commandée par une multiplicité d'exécution.

Le second est le candidat sémantiquement le plus sûr pour les effets et le budget, car l'exponentiation des effets et la multiplication du temps comptent une répétition d'exécution. Le premier est nécessaire pour conserver l'expression de certaines capacités fractionnaires, mais ne peut pas être appliqué par simple exponentiation aux effets.

## 3. Tableau du fragment minimal

| Règle / construction | Scalaire effectif | Agrégation de contexte | Action requise sur le grade | Autre obligation |
|---|---|---|---|---|
| `Box` | annotation de la boîte | aucune nouvelle agrégation | mise à l'échelle du contexte interne | domaine de `Scale` |
| `App` | `r` de la flèche | addition avec le contexte de la fonction | mise à l'échelle du contexte de l'argument | compatibilité avec `AggG` |
| `SubBox` | aucun scalaire | aucune | conversion selon `≼` | cohérence des coercions |
| substitution | le grade `r` de la liaison substituée | recomposition des contextes | mise à l'échelle de `Δ'` | bilinéarité et compatibilité avec substitution |
| `Par` / `Vmap` | multiplicité `n` | addition | action par multiplicité | travail et profondeur distincts |

Le tableau fait apparaître une propriété importante : `SubBox` ne dépend pas de `Scale`, alors que la substitution dépend de ses lois. La cohérence du sous-typage ne peut donc pas être absorbée dans la preuve de l'action graduée.

## 4. Test par composante

### Usage

Pour `𝕌 = ℚ_{ge 0} ∪ {ω}`, les opérations usuelles de grade fournissent naturellement addition et multiplication. Elles permettent de représenter les usages fractionnaires et les usages non bornés.

Mais une puissance d'effet `ε^u` n'est disponible que lorsque `u` représente une multiplicité d'exécution admissible. L'usage et l'exécution restent donc deux sortes distinctes.

**Verdict : compatible avec `AggG` et `MulG` ; action d'effet partielle.**

### Monotonie

La marque binaire de monotonie peut recevoir une structure booléenne avec addition idempotente et multiplication conjonctive. La multiplication « composition de deux preuves de monotonie » peut alors être distincte de l'agrégation « au moins une branche requiert la monotonie ».

**Verdict : algébriquement plausible ; la correspondance exacte avec les règles K7PL reste à formaliser.**

### Budget

Le budget `𝔅 = ℕ∞` peut recevoir addition et multiplication usuelles, tandis que `⊖` reste une opération de consommation supplémentaire.

La loi
`n(β ⊖ k) = nβ ⊖ nk`
est valable sur son domaine fini établi lors de la séance 26, mais elle ne s'étend pas à une mise à l'échelle infinie universelle. Aucun passage des rationnels de `𝕌` vers `𝔅` n'est encore défini.

**Verdict : compatible avec une algèbre globale sous réserve de distinguer `MulG` de `Consume` ; `Scale` reste partielle.**

### Niveau

Le niveau est le cas décisif.

Les règles de K7PL utilisent le joint `⊔` pour l'agrégation conservative d'annotations de niveau dans les branchements. En parallèle, la composition séquentielle d'annotations de confidentialité demande également une opération qui ne doit pas perdre la borne supérieure pertinente.

Or, dans la construction standard d'une algèbre de grades à partir d'un treillis distributif, le couple est `(+ = ⊔, × = ⊓)` sous l'ordre usuel. La multiplication n'est donc pas le joint.

On peut dualiser l'ordre pour obtenir `× = ⊔`, mais alors l'ordre algébrique ne coïncide plus directement avec l'ordre de confidentialité utilisé par `SubBox`. Il faut démontrer une correspondance de deux ordres plutôt que la supposer.

Une troisième possibilité consiste à conserver `ℒ` comme treillis de qualification et à ne pas lui imposer la structure de facteur d'une unique grade algebra. Dans ce cas, `Scale` devient nécessairement une action externe ou une action indexée par sorte.

**Verdict : point de décision architectural. Le produit global n'est pas falsifié mathématiquement ; l'identification de sa multiplication avec toutes les opérations de niveau requises par K7PL n'est pas établie.**

## 5. Conséquence architecturale

Le test produit un résultat plus précis que la séance 27.

**A — grade global homogène.** Toujours possible en principe, conformément aux constructions de grades hétérogènes par produit et homomorphismes de Bianchini et al. Mais K7PL devrait fournir, pour chaque composante, une structure compatible avec les deux rôles qu'elle joue : agrégation et multiplication. Le niveau est actuellement l'obstacle principal.

**A2 — grade global + action externe.** Cette architecture absorbe directement la dissociation `MulG ≠ Scale`. Elle conserve le produit global comme porteur des annotations, mais ne tire plus de la grade algebra toutes les lois utilisées par les règles.

**C — architecture par sortes / grades hétérogènes.** Elle représente explicitement la différence entre usage, exécution, monotonie, niveau et budget. Elle évite de construire une multiplication artificielle pour une composante qui n'en a pas besoin.

Le test ne permet donc pas encore de ratifier C, mais il donne un critère de décision robuste : une architecture est acceptable seulement si elle réduit, et non augmente, le nombre de coercions et de lois croisées.

## 6. Correction nécessaire dans la spécification

La section de C3 qui concluait que la comonade graduée « survit » au produit mixte doit rester conditionnelle. Sa démonstration utilisait `⊖` comme « opération de composition » du budget, alors que `⊖` est une consommation indexée par l'effet.

La formulation correcte est :

> chaque composante doit fournir séparément une opération d'agrégation, une éventuelle multiplication de grade et, si elle participe à une mise à l'échelle, une action du scalaire ; la monotonie de chacune de ces opérations doit être démontrée dans la direction de son sous-typage.

La séance 28 clôt donc une confusion de signature, mais pas encore le choix architectural.

## 7. Statut

**Établi :** les opérations `AggG`, `MulG`, `Scale` et `Consume` doivent être distinguées.

**Établi :** `𝕌` et `𝔑∞` jouent des rôles différents pour l'action sur les effets et le budget.

**Établi :** le budget peut posséder une structure algébrique propre ; `⊖` est une opération supplémentaire.

**Non établi :** le niveau peut recevoir une multiplication de grade compatible à la fois avec son agrégation et avec l'ordre de confidentialité.

**Non établi :** `Scale` peut être une action totale sur `𝒢`.

**Décision provisoire :** conserver A, A2 et C en concurrence ; ne pas ratifier l'une d'elles avant un test formel des signatures du niveau et de la substitution.
