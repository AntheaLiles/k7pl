# B — reprise après ta correction

8 septembre 2026, second temps. **Tu avais raison, et mon analyse était fausse
à sa base.** Ce document dit où, ce que la littérature apprend, et ce que la
décision B-b engage réellement.

---

## 1. Ce que j'ai eu tort d'écrire

J'ai chiffré B-b comme « un second indice sur les types » et « la reprise des
trente-six règles ». Le manuscrit dit le contraire, chapitre 2 :

> « K7PL l'adopte à peu de frais : **une taille est un ordinal, un ordinal est
> un grade**, et ℛ porte déjà ω. »

**La taille n'est pas un indice à ajouter : c'est un grade, et le grade est
déjà là.** Le théorème de terminaison de la couche 3 s'en sert :

> « Le type du pli porte un indice de taille *i*, et celui de l'appel récursif
> un indice strictement inférieur : la décroissance est un fait de typage. »

Mon objection tombe. Et ta seconde remarque tombe juste aussi : refuser B-b
parce qu'elle *paraît* plus difficile aurait contredit une doctrine que le
document applique déjà — il a choisi le critère porté par le type contre le
gardiennage syntaxique, en écrivant que le second « n'est pas compositionnel ».

## 2. L'argument interne qui rend B-b nécessaire, et non seulement préférable

Le théorème `thm:progression_polarisee` énonce :

> « Un calcul de couche ℓ défini sur *p(ℓ)F* par un schéma **dont le type porte
> un indice de taille décroissant au sens de p(ℓ)** progresse en un nombre fini
> d'étapes […] en *p = ν*, jusqu'à production d'une observation — c'est la
> productivité. »

et sa preuve : « Par bien-fondation de l'ordre sur les tailles, dans *C* pour
*p = μ* et dans *C*ᵒᵖ pour *p = ν*. La décroissance étant un fait de typage […]
l'argument ne dépend pas de la forme du terme, donc pas de la polarité :
**c'est le même des deux côtés**. »

**Le théorème présuppose déjà l'indice de taille du côté ν.** Choisir B-a —
prouver la productivité par la terminalité — donnerait à la couche 2 un
argument *différent* de celui de la couche 3, et l'unification que le théorème
revendique ne serait plus qu'apparente. B-b n'ajoute rien : elle écrit ce que
le théorème central suppose depuis le début.

## 3. Ce que la littérature apprend, et c'est un risque

### Le défaut d'Agda, et sa cause exacte

Les types dimensionnés ont une implantation dans Agda, et **elle est
inconsistante**. Le ticket #1946, ouvert depuis 2016 et toujours ouvert,
construit un type `U` à la fois inductif — structurellement, par son
constructeur — et coinductif — par les tailles — et en tire une preuve de ⊥ :

```agda
data U (i : Size) : Set where
  c : ((s : SizeLt i) → U (getSize s)) → U i
empty : U ∞ → ⊥ ;  inh : ∀ i → U i ;  absurd = empty (inh ∞)
```

La cause tient en une ligne, et les travaux de 2026 la nomment :

> « Agda introduces a special largest size ∞ […] However, this approach leads
> to inconsistencies: **Agda proves ∞ < ∞, while any strict well-order < can be
> proven to be irreflexive.** »

### Pourquoi cela vise K7PL directement

**ℛ porte ω, et le manuscrit fait de ω une taille.** C'est exactement la plus
grande taille dont Agda tire son inconsistance. Le risque n'est pas ouvert par
B-b : **il est déjà dans le manuscrit, du côté μ**, depuis que le théorème de
terminaison de la couche 3 s'appuie sur un indice de taille pris dans ℛ.

Et K7PL porte un second danger, celui-là qui lui est propre. Le porteur de ℛ
est **ℚ≥0 ∪ {ω}**, les rationnels ayant été admis pour les capacités de lecture
divisées du chapitre 3. Or l'ordre strict sur ℚ≥0 **n'est pas bien fondé** :

> 1 > 1/2 > 1/4 > 1/8 > …

Les deux théorèmes invoquent « la bien-fondation de l'ordre sur les tailles ».
Sur la partie rationnelle du porteur, cette bien-fondation est fausse. Agda n'a
pas ce défaut — ses tailles sont des ordinaux.

**C'est le genre de chose que le pair qui tente de reproduire trouvera.**

## 4. La réparation, et elle emploie ce que le langage a déjà

Le travail de 2026 donne la voie : **retirer la plus grande taille**, et coder
les types par quantification paramétrique sur les tailles.

> « we construct both the initial algebra and the final coalgebra for any
> polynomial endofunctor » — avec `Ind := ∃i. Indⁱ` et `CoInd := ∀i. CoIndⁱ`.

Deux choses en découlent pour K7PL, et elles sont heureuses.

**Première : les quantificateurs existent déjà.** ∃ et ∀ sont à la grammaire,
avec leurs règles `Pack`/`Open` et `Gen`/`Inst` — ces mêmes règles que le
croisement a trouvées sans entrée à la liste ce matin. La condition de clôture
est donc tenue : rien n'est ajouté, une construction est faite.

**Seconde, et c'est la plus jolie.** Le codage exige des quantificateurs
*paramétriques* — « our parametric quantifiers have the same effect as
**forbidding pattern matching on sizes** ». Or K7PL interdit déjà ce filtrage,
et pour une raison sans rapport : l'effacement. Le chapitre 3 écrit que

> « les variables qui n'interviennent que dans la formation d'une contrainte de
> valeur — **indices de taille**, paramètres fantômes, bornes — sont exclues du
> suivi de ressource et portent un grade nul »

et le document démontre qu'aucun éliminateur ne discrimine sur un argument
effacé. **La paramétricité que la cohérence réclame, K7PL l'a déjà, par sa
discipline d'effacement.** Elle a été posée pour le coût ; elle sert ici la
correction.

## 5. Trois lemmes d'épreuve

Écrits pour être éprouvés, non pour être adoptés. Ils disent ce que B-b demande.

> **Lemme d'épreuve 1 — les tailles vivent dans le fragment bien fondé.**
> Soit ℛ = (ℚ≥0 ∪ {ω}, +, ×, 0, 1, ≤). Le sous-semi-anneau des conaturels
> ℕ∞ ⊂ ℛ est le seul fragment de ℛ dont l'ordre strict soit bien fondé.
> *Tout indice de taille est pris dans ℕ∞ \ {ω}.*
> **Ce qu'il coûte** : une clause de bonne formation sur les grades employés
> comme tailles. **Ce qu'il achète** : la bien-fondation que les théorèmes
> `thm:terminaison_couche_3` et `thm:progression_polarisee` invoquent déjà sans
> l'avoir bornée.

> **Lemme d'épreuve 2 — l'effacement donne la paramétricité.**
> Un indice de taille portant un grade nul, aucun éliminateur ne discrimine sur
> lui. *La quantification sur les tailles est donc paramétrique, au sens que la
> construction des types (co)inductifs par grandes tailles exige.*
> **Ce qu'il coûte** : rien — c'est une conséquence de la règle d'effacement.
> **Ce qu'il achète** : la condition de cohérence, obtenue d'un mécanisme déjà
> posé pour une autre raison. C'est exactement la forme d'économie que la
> condition de clôture recherche.

> **Lemme d'épreuve 3 — l'anamorphisme est dérivable.**
> Soit `f : U(V ⊸ C[V/α])` une coalgèbre. Le copatron
> `⟨ j ↦ (out (f v)).j ⟩` définit `ana f : U(V ⊸ ∀i. να.C ⟨i⟩)`, dont chaque
> observation consomme une unité de taille. *B-a est un cas particulier de
> B-b, à une seule observation et à état exposé.*
> **Ce qu'il coûte** : une définition de bibliothèque. **Ce qu'il achète** : la
> forme catégorique reste disponible pour les preuves, sans être une primitive.

## 6. La complémentarité de B-a et B-b, telle qu'elle est réellement

Tu m'as demandé de l'évaluer. Elle n'est pas celle que j'ai décrite : ce ne sont
pas deux rivales, c'est **une construction et son cas dégénéré**.

| | B-a, anamorphisme | B-b, copatrons dimensionnés |
|---|---|---|
| Ce que c'est | l'unique morphisme depuis une coalgèbre | la définition par observations, gardée par la taille |
| Rapport | **dérivable de B-b** (lemme 3) | primitive |
| Argument de productivité | terminalité, dans *C*ᵒᵖ | bien-fondation de la taille — **celui du théorème** |
| État exposé | oui, obligatoire | non |
| Compositionnalité | l'appel corécursif ne peut pas passer sous un combinateur défini par l'utilisateur | l'information de taille traverse les appels |

Et le travail de 2026 les réconcilie formellement : la coalgèbre terminale s'y
**construit** depuis les approximations dimensionnées. B-a n'est pas écartée —
elle devient un théorème plutôt qu'une règle.

Ton observation « le copatron s'apparente à un anamorphisme » est donc exacte,
et elle est le fond de l'affaire : ils ne s'opposent pas, l'un engendre l'autre.

## 7. Ce que B-b engage, corrigé

| Poste | Quantité |
|---|---|
| Formes ajoutées à la grammaire des termes | 2 — `out c` et le copatron `⟨ j ↦ c_j ⟩` |
| Règles ajoutées | 2 — `Out` et `Cop` |
| Indices nouveaux | **zéro** — la taille est un grade, déjà porté par ℛ |
| Clause de bonne formation à écrire | 1 — les tailles dans ℕ∞ \ {ω} *(lemme 1)* |
| Cas d'induction | 36 |
| Théorème à écrire | 1 — l'anamorphisme comme dérivé *(lemme 3)* |
| Dette refermée au passage | la bien-fondation que deux théorèmes invoquaient sans la borner |

**L'opportunité est plus grande que la question ne le laissait voir.** B-b ne
répare pas seulement le côté ν : elle oblige à écrire la restriction qui manque
au côté μ, et referme un défaut de cohérence que le manuscrit portait sans le
savoir depuis qu'il a mis les rationnels dans ℛ.

## 8. Ce qui reste à instruire

Trois points que je n'ai pas tranchés, et qui demandent la suite du travail.

1. **La restriction des tailles à ℕ∞ heurte-t-elle un usage réel ?** Les
   rationnels sont dans ℛ pour les capacités de lecture divisées. Rien
   n'indique qu'une taille fractionnaire ait un sens — mais il faut relire les
   emplois du grade avant de l'affirmer.
2. **La quantification sur les tailles demande-t-elle des variables de taille
   distinctes des variables de type ?** ∀ et ∃ de K7PL portent sur des types.
   Le codage `∀i. να.C ⟨i⟩` suppose qu'un grade puisse être quantifié.
3. **Le modèle.** La cohérence du codage par grandes tailles est justifiée par
   un modèle de réalisabilité imprédicative interprétant les tailles comme un
   ordinal indénombrable. Ce que /C/ doit vérifier pour le porter reste à dire —
   et cela rejoint la réserve F sur le choix d'un modèle concret.

---

## Sources

- [Sized types allow a type which is both inductive and coinductive in an inconsistent way — agda/agda #1946](https://github.com/agda/agda/issues/1946)
- [Constructing (Co)inductive Types via Large Sizes](https://arxiv.org/html/2602.18921)
- [Quantitative Program Reasoning with Graded Modal Types (Granule)](https://www.cs.kent.ac.uk/people/staff/dao7/publ/granule-icfp19.pdf)
- [Practical Subtyping for System F with Sized (Co-)Induction](https://arxiv.org/pdf/1604.01990)
