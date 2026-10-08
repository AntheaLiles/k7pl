<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 21 : architecture du grade complet (TRANS-02)

**Date :** 7 octobre 2026

La reprise de C a déplacé la question de l'exactitude notationnelle vers l'architecture
mathématique du noyau. Le problème n'est plus seulement de définir les quatre composantes de
`r = ⟨u,m,ℓ,β⟩`, mais de déterminer quelles structures portent les opérations qui font
effectivement intervenir ce grade.

## 1. État épistémique

### Établi

`𝓡` peut désigner le semi-anneau d'usage
`𝕌 = ℚ_{≥0} ∪ {ω}`, tandis que `𝓖 = 𝕌 × 𝕄 × ℒ × 𝔅` désigne l'annotation complète du
jugement, avec `𝔅 = ℕ∞`.

Les intervalles

`U_Lin = [1..1]`,
`U_Aff = [0..1]`,
`U_Rel = [1..ω]`,
`U_Unr = [0..ω]`

sont des domaines syntaxiques d'usage. Leur inclusion est un fait ensembliste ; elle ne constitue
ni un morphisme de modes, ni la relation de sous-typage `≼`, ni l'ordre de précision `⊑`.

La théorie des modes de Hanukaev et Eades définit un mode comme une structure combinant une algèbre
de grades, une politique de contraction et une politique d'affaiblissement. GRASS admet en outre
plusieurs algèbres de grades dans un même système et utilise des morphismes entre modes pour rendre
les opérations inter-modales bien définies. (Hanukaev & Eades, 2026.)

Les grades hétérogènes de Bianchini et al. constituent un second cadre pertinent : une famille
d'algèbres de grades et de morphismes d'algèbres permet de construire un grade hétérogène auquel la
métathéorie du système gradué peut être appliquée. (Bianchini et al., ECOOP 2023.)

Fukihara et Katsumata proposent enfin les ILEC, qui généralisent l'indexation de la modalité `!`
d'une graduation par semi-anneau vers une structure à plusieurs objets assimilable à un
pseudo-semi-anneau multi-objet. Leur motivation est précisément de séparer les exigences
d'indexation catégorique des contraintes particulières d'un calcul gradué.

### Non établi

`𝓖` constitue lui-même un semi-anneau compatible avec la comonade graduée.

L'action `r · Δ` est définie pour tout `r ∈ 𝓖`.

`φ_r` est définie pour tout grade complet, notamment lorsque `u` est rationnel.

La modalité syntaxique `!_r` est exactement l'indexation de la comonade actuellement décrite dans
C2.

La cohérence des coercions induites par `≼` est démontrée.

Le lemme de substitution est donc encore un résultat conditionnel.

## 2. Distinction des objets

La reprise impose quatre niveaux qui avaient été amalgamés.

`𝓡` est le support algébrique de l'usage.

`𝓖` est le produit hétérogène portant l'annotation complète d'une liaison.

`M_m = (R_m, Cont(m), Weak(m))` est un mode structurel qui détermine les permissions de
contraction et d'affaiblissement.

`U_m` est une strate syntaxique qui sélectionne les usages admis par une modalité donnée.

Aucun de ces objets ne doit être identifié à un autre sans définition et preuve explicites.

## 3. Quatre architectures concurrentes

### A — Semi-anneau global `𝓖`

Hypothèse : donner à `𝓖` une structure de semi-anneau complète et faire de ce porteur le support
direct de `!_r`, de la composition graduée et de la mise à l'échelle des contextes.

Avantage : conserve au maximum la syntaxe actuelle.

Obligations : définir addition, multiplication, ordre, zéro, unité et actions sur chaque composante ;
établir leur compatibilité avec `φ`, `ψ`, la contraction, `SubBox` et la substitution.

Risque : fabriquer une structure globale dont les composantes n'ont pas le même rôle mathématique.
La simple construction produit des ordres ne fournit pas cette structure.

### B — Comonade indexée par l'usage, annotations orthogonales

Hypothèse : conserver `!_u` comme modalité comonadique indexée par le semi-anneau d'usage et
transporter `m`, `ℓ` et `β` dans le jugement comme annotations supplémentaires.

Avantage : respecte directement les modèles classiques de comonades graduées indexées par un
semi-anneau.

Obligations : reconstruire la signification de `!_r`, de `SubBox` et de la contraction sur une
annotation complète.

Risque : la syntaxe actuelle pourrait s'avérer un sucre regroupant plusieurs mécanismes distincts.

### C — Grade hétérogène / multimodal

Hypothèse : chaque dimension pertinente possède sa propre algèbre ou structure ordonnée ; les
combinaisons passent par des morphismes explicites. Une opération sur le grade complet est alors
une opération sur un vecteur de grades, et non la multiplication naïve d'un quadruplet par un
scalaire.

Avantage : la monotonie et le niveau n'ont plus à être transformés artificiellement en modules sur
`𝕌`. Cette architecture est directement comparable aux constructions de grades hétérogènes de
Bianchini et aux mécanismes multimodaux de GRASS.

Obligations : définir les sortes de grades et les morphismes nécessaires pour K7PL ; montrer que
`+`, `≼`, `SubBox`, contraction et substitution se factorisent correctement.

Risque : modifier la notion même de mode et donc la sédimentation.

### D — Comonade exponentielle à indexation multi-objet

Hypothèse : ne pas forcer l'indexation de `!` dans un seul semi-anneau. Une structure de type ILEC
fournit un support catégorique à plusieurs objets et morphismes d'indexation.

Avantage : sépare explicitement l'indexation de la modalité des différentes algèbres d'annotation.

Obligations : identifier les objets et morphismes nécessaires et factoriser `Box`, `Unbox`,
`SubBox` et la contraction dans cette structure.

Risque : appareil catégorique nettement plus lourd que les architectures A-C si celles-ci suffisent.

Aucune des quatre architectures n'est ratifiée à cette séance.

## 4. Inventaire des signatures du noyau

| Construction | Signature minimale à établir | Site(s) principaux | Statut |
|---|---|---|---|
| addition de contextes | `Ctx(𝓖) × Ctx(𝓖) ⇀ Ctx(𝓖)` | Pair, Par, Case/With selon le régime | définie, lois à vérifier |
| addition de grades | `𝓖 × 𝓖 → 𝓖` | recomposition, contraction | non close comme structure globale |
| produit des indices de `!` | `I × I → I` | comultiplication graduée | index encore à déterminer |
| multiplication d'un contexte par un grade | `I × Ctx(𝓖) ⇀ Ctx(𝓖)` | Box, App, substitution | non définie pour le grade complet |
| multiplication d'un contexte par une taille | `ℕ∞ × Ctx(𝓖) ⇀ Ctx(𝓖)` | VecI, VecE, Sc | distincte de `r·Δ` |
| transport d'un effet | `φ : I × ℰ ⇀ ℰ` | loi distributive | domaine à déterminer |
| transport d'un contexte | `ψ : 𝓖 × ℰ ⇀ 𝓖` | `⊠_ε` | partiellement défini |
| sous-typage de grades | `𝓖 × 𝓖 → Prop` | Sub, SubBox | orientation explicitée |
| précision | `X × X → Prop` | Sub et jointures | distincte de `≼` |

Le point le plus discriminant est la coexistence de `r·Δ` et `n·Δ`. Le premier prend son
scalaire dans l'annotation de ressource, le second dans un domaine de tailles ou de multiplicités.
Ils ne peuvent pas être identifiés sans démonstration.

## 5. Découverte critique sur usage et exécution

Le grade d'usage `u` mesure une propriété de ressource. Une multiplicité d'exécution `n` compte
des répétitions effectives d'un calcul. La relation implicative « exécuter `n` fois ⇒ employer
certaines ressources `n` fois » ne permet pas d'identifier les deux notions.

Cela devient décisif pour `u = 1/N`. Une capacité de lecture fractionnée peut représenter une
répartition de capacité sans signifier une fraction d'exécution. La définition
`φ_r(ε) = ε^u` ne peut donc pas être étendue à tous les grades d'usage.

Pour `n ∈ ℕ∞`, une action d'itération `ε ↦ ε^n` est compatible avec la composition répétée des
effets. Pour un grade d'usage rationnel, une autre action devrait être définie, ou la loi devrait
être restreinte à un sous-domaine.

Toute preuve qui remplace silencieusement `u` par une multiplicité d'exécution `n` est donc
insuffisamment justifiée.

## 6. Critères de décision pour TRANS-02

Une architecture ne pourra être retenue que si elle satisfait simultanément :

1. elle conserve le sens de `u = 1/N` sans introduire d'exécution fractionnaire ;
2. elle donne une signature précise à chaque occurrence de `r·Δ` ;
3. elle distingue cette opération de `n·Δ` ;
4. elle rend compatibles `SubBox`, contraction, affaiblissement et sous-typage ;
5. elle donne un domaine explicite à `φ_r` et `ψ` ;
6. elle permet d'énoncer puis de mécaniser la substitution sans opération implicite ;
7. elle permet de relier la structure obtenue à la sémantique de C sans fusionner les niveaux.

Le choix ne doit pas être fait sur la seule élégance catégorique. Une architecture plus générale est
préférable seulement si elle réduit effectivement le nombre d'hypothèses ad hoc et de preuves
spécifiques à K7PL.

## 7. Comparaison provisoire des architectures

| Critère | A : 𝓖 global | B : ! indexé par 𝕌 | C : hétérogène/multimodal | D : ILEC |
|---|---|---|---|---|
| `u=1/N` | compatible comme valeur de `𝕌`, mais ne résout pas `φ_r` | naturel pour `!_u` | naturel si l'usage conserve sa propre algèbre | compatible, mais sans avantage démontré |
| `r·Δ` | exige une action globale artificiellement forte | exige de décomposer l'annotation complète | correspond précisément à une action par composantes/morphismes | peut être factorisé catégoriquement |
| `SubBox` / contraction | possibles si les lois globales existent | doivent combiner plusieurs annotations autour de `!_u` | relèvent des modes et de leurs morphismes | relèvent des objets/morphismes d'indexation |
| `φ_r` / `ψ` | exigent des actions sur un porteur unique | `φ` peut rester liée à `𝕌`, `ψ` aux annotations | actions et transports typés par dimension | expressifs, mais plus abstraits |
| substitution | simple en surface, difficile en fondation | nécessite une reconstruction de `!_r` | signature explicite et factorisable | mécanisable mais appareil lourd |
| coût de mécanisation | faible après définition globale, mais risque de grosses preuves | moyen à élevé | moyen, avec plus de types/morphismes explicites | élevé |
| risque scientifique | produire une algèbre globale sans nécessité | masquer une fusion de mécanismes distincts | introduire une sémantique multimodale réellement justifiée | sur-modéliser le noyau |

**Conclusion provisoire.** A ne peut plus être traitée comme l'architecture par défaut : elle doit justifier
pourquoi quatre dimensions de rôles différents constituent une seule algèbre scalaire. D reste viable
comme solution catégorique de dernier recours, mais son coût théorique est actuellement sans bénéfice
établi. B et C sont les deux architectures qui méritent une comparaison constructive.

La priorité suivante est donc un test B-versus-C sur un fragment minimal contenant seulement
`Box`, `Unbox`, `App`, `SubBox`, contraction et substitution. Le fragment est suffisamment
riche pour falsifier une architecture, mais suffisamment petit pour rendre les signatures auditables.

## 8. Décision de séance

TRANS-02 passe de **OPEN** à **PARTIAL**.

Résultats acquis : séparation `𝓡/𝓖`, séparation modes/intervalles, définition explicite de `≼`,
identification de `r·Δ` comme action non encore définie, distinction entre `r·Δ` et `n·Δ`,
et ouverture de quatre architectures concurrentes.

Résultats non acquis : structure algébrique du grade complet, support d'indexation exact de `!`,
action `r·Δ`, domaine général de `φ_r`, cohérence des coercions et preuve non conditionnelle de la
substitution.

La prochaine séance doit comparer A-D au niveau des signatures, et non produire immédiatement une
nouvelle notation normative.

## 9. Références

Hanukaev, Peter; Eades, Harley. *A Unification of Graded and Substructural Logics*. 2026,
arXiv:2605.17112, DOI 10.48550/ARXIV.2605.17112.

Hanukaev, Peter; Eades III, Harley. *Combining Dependency, Grades, and Adjoint Logic*. TyDe 2023,
DOI 10.1145/3609027.3609408.

Bianchini, Riccardo; Dagnino, Francesco; Giannini, Paola; Zucca, Elena. *Multi-Graded Featherweight
Java*. ECOOP 2023, LIPIcs 263, 3:1–3:27. DOI 10.4230/LIPIcs.ECOOP.2023.3.

Fukihara, Yōji; Katsumata, Shin-ya. *Generalized Bounded Linear Logic and Its Categorical Semantics*.
FoSSaCS 2021, LNCS 12650, pp. 226–246. DOI 10.1007/978-3-030-71995-1_12.
