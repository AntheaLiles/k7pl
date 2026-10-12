<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C-05 — audit des agrégateurs temporels et de la scalarisation

**État :** AUDIT DE PREUVE NON NORMATIF — C-05 OUVERT  
**Révision de référence :** `main`, SHA `414ce6a1d2347de11397002980f3e0fe0b1e8205`  
**Périmètre :** définitions, propriétés, contre-exemples et obligations de formalisation pour `W`, `D` et `Cost_Budget`.  
**Exclusions :** aucune modification de `spec/` ou `src/`; aucune décision sur C-04; aucune ratification de la totalité ou de la partialité de `Cost_Budget`.

Ce document distingue le modèle mathématique idéal, son association aux symboles effectivement présents dans la spécification, puis les obligations de consommation budgétaire qui restent en dehors de C-05. Une dérivation sur papier ne vaut ni preuve Lean ni décision normative.

## 1. Sources confrontées

- [C2 — interface du coût budgétaire](../../spec/Spec/C2/ComonadeExponentielleEtFragments.lean), section `sec:c2-interface-cout-budgetaire` et formule `eq:cost-max-both`.
- [C3 — grammaire des types et effets](../../spec/Spec/C3/GrammaireDesTypes.lean), définition de `\mathcal E` et de la famille temporelle.
- [C3 — règles de typage](../../spec/Spec/C3/ReglesDeTypage.lean), règle `When`.
- [Séance 60 — agrégateurs canoniques](../history/2026-10-07-pr-02-60-canonical-cost-aggregators.md).
- [Registre des objets théoriques](L1-THEORY-OBJECTS.md), entrée C-05.
- [Dossier probant du stade C](L1-STAGE-C-EVIDENCE-DOSSIER-2026-10-11.md), entrée C-05.
- [Audit d'interfaces typées C-01/C-02](L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md).

La séance 60 fixe une conception candidate et propose des lois sur papier. C2, source de spécification courante au SHA de référence, conserve cependant une flèche partielle pour `Cost_{\mathcal B}` puis donne la formule de maximum sans domaine explicite. C-05 ne peut résoudre cet écart en requalifiant la note de séance en définition normative.

## 2. Reconstruction des signatures

Soit `\mathcal L` l'ensemble/type des niveaux temporels, encore à vérifier comme porteur canonique avec ses éventuelles propriétés structurelles. Le modèle écrit dans C2 et C3 donne :

```text
K := (\mathbb N_\infty \times \mathbb N_\infty)^{\mathcal L},\qquad
\kappa : \mathcal L \to \mathbb N_\infty \times \mathbb N_\infty,
```
avec `\kappa(\ell)=(w_\ell,s_\ell)`, où `w_\ell` est le travail et `s_\ell` la profondeur au niveau `\ell`.

Les reconstructions de signature sont :

| Objet | Signature dans le modèle idéal | Qualification |
|---|---|---|
| `W` | `W : K → ℕ∞`, `W(κ) = sup { Σ_{ℓ∈F} wℓ | F ⊆ ℒ, F fini }` | Totale si le supremum requis existe dans le codomaine choisi. |
| `D` | `D : K → ℕ∞`, `D(κ) = sup { sℓ | ℓ ∈ ℒ }` | Totale si le supremum, notamment celui de l'ensemble vide, a une valeur spécifiée. |
| `Cost_Budget` candidat | `K → ℕ∞`, `κ ↦ max(W(κ),D(κ))` | Totale dans le modèle complet ci-dessous, sous les hypothèses qui rendent `W` et `D` totales. |
| `Cost_𝓑` dans C2 | `K ⇀ ℕ∞` | Signature partielle explicitement imprimée dans la source normative. Le domaine n'y est pas spécifié par la formule de maximum. |

Dans C2, `Cost_{\mathcal B}` et `Cost_Budget` sont associés à la même construction par l'équation affichée, mais le registre doit garder visibles les deux questions : uniformiser le nommage sans modifier le sens, et déterminer ce que signifie la flèche partielle dans la signature source.

### Hypothèses nécessaires au modèle usuel de `ℕ∞`

La démonstration qui suit est conditionnelle au modèle `\mathbb N_\infty=\mathbb N\cup\{\omega\}` avec l'ordre usuel en chaîne, `0` comme plus petit élément et `\omega` comme élément supérieur, plus l'addition étendue non négative (`n+\omega=\omega`). Dans ce modèle, tout sous-ensemble possède un supremum et `sup ∅ = 0`.

C2 nomme `ℕ∞` et décrit `ω`, mais la clause des agrégateurs ne donne pas à elle seule une définition formelle de la structure complète de supremum ni de la convention pour le supremum vide. Il faut vérifier le contrat exact de cette structure avant de transférer les lois à une formalisation ou à un autre porteur.

Le domaine de `K` exige seulement que chaque niveau porte une paire dont les deux coordonnées appartiennent à `ℕ∞`. Les compositions point par point supposent en plus que les familles comparées sont sur le même `\mathcal L` et que l'addition / le maximum de profondeur sont ceux définis pour les effets. Un ensemble arbitraire de valeurs réelles, des coordonnées négatives ou des familles sur des porteurs différents ne relèvent pas de cette signature.

## 3. Existence des suprema et cas vides

Pour `W`, l'ensemble des sommes contient toujours la somme vide `0`, puisque `∅ ⊆ ℒ` est fini, même lorsque `ℒ = ∅`. Le supremum de l'ensemble des sommes finies est donc défini dans le modèle complet. Si `ℒ` est fini, ce supremum est simplement la somme de toutes les coordonnées de travail (non négatives).

Pour `D`, l'ensemble des profondeurs est non vide seulement si `ℒ` l'est. Dans le modèle complet avec `sup ∅ = 0`, `D` reste total et vaut `0` quand `ℒ = ∅`. Cette convention doit être explicitée plutôt que présupposée à partir du symbole `sup`.

Conséquence discriminante : si `ℒ = ∅`, la famille `κω(ℓ)=⟨ω,ω⟩` est la fonction vide. Alors `W(κω)=D(κω)=max(W,D)=0` dans le modèle usuel, et non `ω`. Le résultat de la séance 60 « When a un coût scalaire ω » exige donc `\mathcal L \ne \varnothing` (ou une autre prémisse/convention explicitement justifiée). Cette condition n'est pas ajoutée à la spécification ici.

Autre contre-exemple de codomaine : si le codomaine était `ℕ` sans `ω`, alors sur `ℒ=ℕ`, la famille `w_n=1` rend l'ensemble des sommes finies non borné dans `ℕ`; aucun supremum dans `ℕ` ne pourrait représenter `W`. De même, `s_n=n` rendrait `D` sans supremum dans `ℕ`. L'élément `ω` évite ce défaut dans le modèle idéal, mais cela ne suffit pas à prouver que l'instance normative est déjà correctement formalisée.

## 4. Propriétés dérivées sous contrat explicite

Toutes les propriétés de cette section sont des dérivations mathématiques conditionnelles, pas des théorèmes Lean localisés. On suppose le modèle complet de la section 2, l'ordre ponctuel sur `K`, et les opérateurs d'effets ci-dessous lorsqu'une composition est invoquée.

### 4.1 Bornes et minimalité du maximum

Pour tout `F ⊆ ℒ` fini, sa somme de travail est un élément de l'ensemble dont `W(κ)` est le supremum, donc `Σ_{ℓ∈F}wℓ ≤ W(κ)`. En particulier, si `ℓ∈ℒ`, le singleton `{ℓ}` donne `wℓ ≤ W(κ)`. Par définition du supremum, `sℓ ≤ D(κ)` pour chaque `ℓ∈ℒ`.

Dans un ordre total, `W ≤ max(W,D)` et `D ≤ max(W,D)`. Si un autre scalaire `c∈ℕ∞` satisfait simultanément `W(κ)≤c` et `D(κ)≤c`, alors `max(W(κ),D(κ))≤c`. Le maximum est donc la plus petite borne scalaire dominante **si** le choix normatif de budget scalaire et de borne simultanée par P3 est accepté. Cette propriété algébrique ne ratifie pas ces hypothèses.

### 4.2 Monotonie

Définissons `κ₁ ≤ κ₂` par `w₁ℓ≤w₂ℓ` et `s₁ℓ≤s₂ℓ` pour tout niveau `ℓ`. L'addition étendue étant monotone, pour tout sous-ensemble fini `F`, `Σ_F w₁ℓ ≤ Σ_F w₂ℓ`. Le supremum préserve cette comparaison, d'où `W(κ₁)≤W(κ₂)`. La même propriété du supremum ponctuel donne `D(κ₁)≤D(κ₂)`. La monotonie de `max` donne enfin `C*(κ₁)≤C*(κ₂)`, où `C*(κ)=max(W(κ),D(κ))`.

### 4.3 Zéro

Pour la famille nulle `κ₀(ℓ)=(0,0)`, chaque somme finie de travail vaut `0` et chaque profondeur vaut `0`. Le supremum des ensembles singleton/de sommes vaut donc `0`, y compris dans le cas vide si `sup∅=0`. Ainsi `W(κ₀)=D(κ₀)=C*(κ₀)=0`. Ceci est une propriété de l'agrégateur candidat, pas encore une garantie pour un `Cost_Budget` partiel dont le domaine serait différent.

### 4.4 Valeurs finies et infinies

- Sur un ensemble fini de niveaux, `W` vaut la somme finie des travaux et `D` le maximum des profondeurs; l'un ou l'autre peut toutefois valoir `ω` dès qu'une coordonnée correspondante vaut `ω`.
- Si `\mathcal L=\mathbb N` et `w_n=1` pour tout `n`, chaque somme finie est finie, mais les cardinalités des sous-ensembles finis ne sont pas bornées par un entier fini : `W=ω`. Ce résultat est une preuve sur la famille infinie idéale, non l'exécution du test fini ci-joint.
- Si `s_n=n`, toutes les profondeurs sont finies individuellement mais leur supremum vaut `ω`; donc `D=ω`.
- Si `\mathcal L\ne\varnothing` et qu'une coordonnée travail (respectivement profondeur) vaut `ω`, le singleton correspondant donne `W=ω` (respectivement `D=ω`).
- La somme étendue satisfait `a+ω=ω`; le maximum des valeurs finies et de `ω` suit l'ordre étendu. Un test sur un tableau fini vérifie seulement les cas concrets qu'il exécute.

### 4.5 Séquencement et parallèle : inégalités, pas des égalités indues

Posons conditionnellement :
- séquencement `κ₁·κ₂` : `(w,s)(ℓ)=(w₁ℓ+w₂ℓ,s₁ℓ+s₂ℓ)` ;
- parallèle `κ₁∥κ₂` : `(w,s)(ℓ)=(w₁ℓ+w₂ℓ,max(s₁ℓ,s₂ℓ))`.

Pour chacun, le travail agrégé est `W(κ₁ op κ₂)=W(κ₁)+W(κ₂)` : l'inégalité supérieure suit de la décomposition des sommes finies; la borne inverse se reconstruit en réunissant les deux sous-ensembles finis qui réalisent les maxima lorsque les suprema sont finis, et par non-bornitude lorsqu'un supremum vaut `ω`. Cet argument demande des coordonnées non négatives, l'addition étendue et la fermeture des sous-ensembles finis par union.

En séquencement, `s₁ℓ+s₂ℓ≤D(κ₁)+D(κ₂)` pour chaque niveau, donc `D(κ₁·κ₂)≤D(κ₁)+D(κ₂)`. En parallèle, `supℓ max(s₁ℓ,s₂ℓ)=max(D(κ₁),D(κ₂))` dans l'ordre complet, donc `D(κ₁∥κ₂)=max(D(κ₁),D(κ₂))`.

Par monotonie de l'addition et les lois de `max`, on obtient, dans les deux cas, `C*(κ₁ op κ₂)≤C*(κ₁)+C*(κ₂)`. Il ne faut **pas** renforcer la borne séquentielle de profondeur en égalité : pour deux niveaux `a,b`, prenez les profondeurs de `κ₁` égales à `(1,0)` et celles de `κ₂` à `(0,1)`. Alors `D(κ₁)=D(κ₂)=1`, tandis que `D(κ₁·κ₂)=1<2=D(κ₁)+D(κ₂)`.

## 5. Trois couches de résultat

### A. Modèle mathématique idéal

Sous les hypothèses explicites précédentes, `W` et `D` sont des fonctions totales `K→ℕ∞`; `C*(κ)=max(W(κ),D(κ))` est une fonction totale `K→ℕ∞`; bornes, monotonie, minimalité, zéro et lois conditionnelles de composition se démontrent. Les familles infinies requièrent le supremum complet, et le résultat sur `κω` requiert `ℒ≠∅`.

### B. Correspondance avec la spécification

C2/C3 affichent le porteur pair-valué `(ℕ∞×ℕ∞)^ℒ`. C2 affiche en même temps `Cost_𝓑 : K ⇀ ℕ∞`, puis définit la valeur par maximum sans restriction d'argument. La séance 60 ne peut pas rendre cette interface totale par son seul statut de note de conception.

Deux autres écarts de représentation doivent rester visibles. (1) Dans C3, le texte d'explication de `When` donne `⟨φ,κ⟩[ω]=⟨φ,⊤⟩` avec `⊤(ℓ)=ω`, c'est-à-dire une définition scalaire du canal supérieur, alors que la grammaire d'effet C3 et l'interface C2 présentent `κ` comme une famille de paires travail/profondeur. (2) C4, section sur les sortes du métalangage, décrit également une famille temporelle scalaire `κ ∈ ℕ∞^ℒ`, distincte de la forme pair-valuée de C2/C3. Les sources examinées ne spécifient pas explicitement les applications qui relieraient ces représentations. Cet audit ne décide pas s'il s'agit d'autres notions ou d'incohérences; ces correspondances doivent être instruites aux endroits appropriés.

### C. Frontière avec C-04 : `Adm`, `Consume`, `ψ`

Les registres décrivent l'intention `Adm(β,κ) := (β=ω) ∨ (Cost_Budget(κ)≤β)` et `Consume(β,κ)=β⊖Cost_Budget(κ)` sur le domaine admissible. C-05 peut établir des propriétés de coût candidat, mais ne prouve pas que la famille portée par un effet est celle effectivement consommée par `ψ`, qu'un passage non admissible ne peut pas être typé, ni que les définitions sont bien définies si `Cost_Budget` est partiel. Si `Cost_Budget` reste partiel, le contrat d'interface doit traiter la définissabilité de l'appel à `Cost_Budget` — y compris lorsque `β=ω` — au lieu de supposer que le disjoncteur rend automatiquement la fonction définie. Ceci est un blocage d'intégration transmis à C-04, non résolu ici.

## 6. Options de domaine à faire ratifier

**Option A — total sous contrat explicite.** Retenir `Cost_Budget : K→ℕ∞` et la formule du maximum pour toute famille valide `κ∈K`, avec structures d'ordre/supremum/arithmétique nommées et convention du supremum vide spécifiée. Dans ce cas, la partialité pertinente resterait sur `Consume` (et potentiellement `ψ`), non sur l'agrégateur, sous réserve de la cohérence des autres règles. Conséquence : les propriétés algébriques portent partout sur `K`; il faut justifier le choix de scalarisation et la correspondance temporelle de C4.

**Option B — coût partiel.** Conserver `Cost_Budget : K⇀ℕ∞`, mais définir un domaine `Dom_Cost ⊆ K` et stipuler précisément sur quels `κ` les suprema/formule sont admissibles. La formule serait alors un théorème/une définition sous condition sur `Dom_Cost`; la totalité des agrégateurs ne suffit pas à effacer celle de l'interface composée. Conséquence : `Adm`, `Consume` et `ψ` doivent exposer leur comportement quand `κ∉Dom_Cost`. Ne pas déplacer implicitement cette partialité d'une fonction à l'autre.

**Aucune option n'est sélectionnée ici.** Le simple choix du maximum ne détermine pas si la signature normative imprimée est intentionnellement partielle ou historiquement incohérente. Décisions à obtenir de l'autrice : totalité vs partialité et, si partielle, domaine exact; ratification explicite, si elle n'est pas déjà acquise, du budget scalaire et de P3 comme borne simultanée du travail et de la profondeur; confirmation des hypothèses sur `ℒ`, les supremums et les deux coordonnées temporelles.

## 7. Lemmas et preuves à formaliser

À formaliser sur le porteur et les opérations effectivement retenus, sans déclarer le résultat normatif avant ratification :

1. existence et spécification du supremum de `ℕ∞`, addition étendue monotone, `sup∅`, et fermeture de l'ensemble des sommes finies;
2. borne de chaque somme finie de travail par `W`, et `wℓ≤W` / `sℓ≤D` pour chaque `ℓ`;
3. monotonie de `W`, `D` et de la candidate `max(W,D)`;
4. nullité de `W`, `D`, et de la candidate pour l'effet nul;
5. minimalité de `max(W,D)) parmi les scalarisations qui dominent les deux coordonnées;
6. additivité du travail pour les compositions séquentielle et parallèle, sous les opérations retenues;
7. sous-additivité de `D` en séquence et loi `D(∥)=max(D₁,D₂)` en parallèle;
8. sous-additivité de la candidate `C*` pour les deux compositions;
9. cas `κω`: `W=D=ω` sous `ℒ≠∅`, avec une démonstration du rôle de cette hypothèse;
10. si l'option B est retenue, preuves à énoncer sur `Dom_Cost` et vérification séparée de toutes les prémisses d'utilisation.

Aucune déclaration Lean correspondante n'a été identifiée dans les fichiers/recherches examinés. Les tests exécutables ajoutés avec cet audit sont des régressions sur un modèle fini en Python; ils ne prouvent ni la complétude de l'ordre mathématique, ni les propriétés de familles infinies, ni le lien normatif.

## 8. Tests et critères de non-clôture

Le test compagnon `scripts/ci/test_cost_aggregators_model.py` vérifie des instances finies du modèle : valeurs finies et `ω`, index vide, monotonie, borne/minimalité du maximum, composition séquentielle et parallèle, contre-exemple d'égalité séquentielle de profondeur, et rejet d'entrées hors du porteur annoncé. Les séquences finies de taille croissante sont des témoins bornés, non une exécution de supremum sur un ensemble infini.

Le test ne décide pas la totalité normative, ne simule pas C-04 comme preuve et n'autorise pas de modifier `spec/`. C-05 reste ouvert tant que la signature, les domaines, les hypothèses de porteur et les lois formelles correspondantes ne sont pas tranchés et démontrés au niveau requis.
