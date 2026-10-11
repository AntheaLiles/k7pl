<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Analyse des fondations théoriques et de la sédimentation temporelle

**État :** IN PROGRESS

Ce document constitue le dossier d'instruction des imports théoriques arrêtés dans [L1-DECISIONS.md](L1-DECISIONS.md), désormais intégré à la branche principale. Il distingue ce qui est déjà explicitement présent dans la spécification de ce qui doit encore être démontré.

## 1. Théorie des modes — statut NORMATIF

La spécification distingue les intervalles d'usage des modes structurels : les premiers ne sont pas, à eux seuls, des modes. C2 présente le diamant candidat `M_Lin → M_Aff → M_Unr` et `M_Lin → M_Rel → M_Unr`, avec `M_Aff` et `M_Rel` incomparables. La sédimentation triadique actuellement retenue instancie la branche `Lin` (couche 1), `Aff` (couche 2), `Unr` (couche 3). Par décision D-16 du 11 octobre 2026, `Rel` reste hors périmètre des règles génératrices actuelles ; les opportunités sont documentées dans [L1-REL-MODE-OPPORTUNITIES-2026-10-11.md](L1-REL-MODE-OPPORTUNITIES-2026-10-11.md). En particulier, `U_Rel` est l'intervalle d'usage `[1..ω]`, tandis que `M_Rel` est le triplet structurel candidat : ils ne doivent pas être confondus.

L'enjeu n'est donc pas d'ajouter une définition isolée. Il faut démontrer que cette théorie est le principe qui relie effectivement :

| Composante | Dépendance à démontrer |
|---|---|
| Axiomatique des grades | les opérations structurelles autorisées par un mode |
| Jugement germinal | passage du mode aux règles structurelles |
| Sédimentation | restriction successive des règles par les modes |
| Types et termes | propagation des annotations de grade et des contraintes modales |
| Localité/zones | extension du mode par la donnée d'échange |
| Effets | interaction entre structure modale et composante d'effet |
| Formalisation | représentation fidèle des mêmes obligations |
| Preuves | préservation des invariants induits par les modes |

Le critère de clôture sera une chaîne de correspondance suffisamment explicite pour que l'ajout ou le retrait d'une composante puisse être analysé comme modification de la théorie des modes, plutôt que comme juxtaposition de règles.

**Point de vigilance :** la spécification affirme déjà des relations fortes entre modes, grades, fragments et règles. Ces relations doivent être séparées entre définitions, lemmes établis et objectifs de preuve.

## 2. Théorie des types graduée formalisée — statut NORMATIF

Le chapitre 3 porte explicitement un système gradué avec semi-anneau ordonné, contexte gradué, règles de propagation, effacement et propriétés métathéoriques. Le chapitre 2 donne l'interprétation catégorique par comonades graduées et fragments.

La théorie graduée doit être instruite comme un axe transversal :

`algèbre des grades → jugement → typage → effets → ressources → coûts → temporalité → sémantique → formalisation`.

L'analyse doit établir, pour chaque transition, quelle structure mathématique est utilisée et quelle propriété est requise.

Le registre historique indique notamment que la formalisation de référence apporte un patron de mécanisation comprenant semi-anneau partiellement ordonné, univers, effacement, normalisation et décidabilité de l'égalité définitionnelle. Le point délicat explicitement identifié est la restriction concernant les instances susceptibles d'affecter l'égalité définitionnelle. Cette restriction doit être vérifiée contre le produit mixte et les coercions propres à K7PL.

Le statut normatif signifie que la théorie n'est pas seulement une méthode de preuve. Les structures graduées doivent expliquer la cohérence entre les différentes composantes du langage. En revanche, le fait qu'un patron de mécanisation existe ne prouve pas que toutes les propriétés de K7PL sont déjà couvertes par ce patron.

## 3. Calf/Decalf — dépendance formelle

Calf/Decalf intervient différemment. Le registre historique le décrit comme un cadre logique conscient du coût, avec distinction de phase et mécanismes utiles à certaines preuves.

L'instruction doit donc produire une frontière explicite :

`K7PL normative → propriété à formaliser → construction Calf/Decalf → obligation obtenue`.

Il faut éviter l'inférence inverse :

`construction disponible dans Calf/Decalf 
otRightarrow construction normative de K7PL`.

Le dossier doit également identifier les hypothèses de Calf/Decalf qui ne sont pas des engagements du langage et vérifier qu'aucune d'elles n'est importée silencieusement dans la spécification.

## 4. Récursion gardée multi-horloges — analyse par sédimentation

La spécification contient actuellement trois modalités temporelles dans les types de session :

`○S`, `□S`, `◇S`.

Elle utilise également `delay`, `now`, `wait` et `when`. Le registre historique rapproche `○` de la modalité de récursion gardée et note que la productivité temporelle ne doit pas être confondue avec la taille inductive/coinductive.

L'instruction est maintenant décomposée par couche.

### Couche 1

Question : quelle partie de la discipline temporelle est nécessaire au fragment strictement linéaire ?

À établir :

- formes temporelles effectivement admissibles ;
- interaction avec la consommation unique des ressources ;
- obligations de typage et de substitution ;
- rapport entre délai et borne temporelle ;
- éventuelle nécessité d'une structure de garde ;
- propriétés de terminaison/productivité pertinentes.

### Couche 2

Question : comment la discipline temporelle se compose-t-elle avec les acteurs, flux, boîtes aux lettres et garanties de productivité ?

À établir :

- interaction entre `when`, continuation de motif et productivité ;
- propagation des calendriers à travers les calculs concurrents ;
- relation entre `◇` et attente non bornée ;
- interaction avec les grades de travail/profondeur ;
- distinction entre progression d'une fibrille et consommation d'une taille.

### Couche 3

Question : quelle partie de la temporalité subsiste lorsque les ressources et effets sont abandonnés au profit de la terminaison ?

À établir :

- formes temporelles réellement nécessaires ;
- compatibilité avec les constructions inductives ;
- relation entre récursion, garde temporelle et hauteur du treillis ;
- absence éventuelle de transport indu de garanties de couche 2.

Le résultat attendu est :

`couche → construction temporelle → invariant → règle → propriété → preuve/formalisation`.

Une théorie globale de la récursion gardée ne sera pas considérée comme suffisante si elle ne permet pas d'expliquer sa sédimentation dans ces trois régimes.

## 5. Point déjà établi sur when

La règle actuelle de when est explicitement :

Δ₁ ⊢ v : ◇V et □Δ₂, x :ᵣ V ⊢ c : ◇C | ε.

La contrainte de reportabilité du contexte n'est pas la même obligation que la comptabilisation du coût. Les séances 59–62 arrêtent comme interface de conception que when transforme la famille temporelle de l'effet en κω(ℓ)=⟨ω,ω⟩, avec Cost_Budget(κ)=max(W(κ),D(κ)). Le budget n'est pas consommé à la seule introduction de l'effet : Adm(β,κ) est vérifiée au passage de l'effet par ψ dans la composition des contextes, puis Consume actualise le budget si l'admissibilité est satisfaite.

Cette résolution remplace l'alternative architecturale « interdire immédiatement when avec un budget fini » contre « attente externe hors budget ». Elle n'est toutefois pas une preuve de correction : le domaine partiel de ψ, la relation exacte entre l'effet κ et le coût de chaque règle, la preuve de correction budgétaire et la compatibilité avec la substitution restent ouvertes. La structure de reportabilité retenue doit encore être reliée par couche aux règles et invariants correspondants ; elle ne doit pas conduire à supprimer le cas d'usage exprimé par ◇ ni à introduire implicitement un nouvel opérateur.

## 6. État de l'instruction

| Élément | Statut | Prochaine action |
|---|---|---|
| Théorie des modes | NORMATIF | construire la chaîne de cohérence inter-composantes |
| Types gradués formalisés | NORMATIF | établir la correspondance théorie → règles → formalisation |
| Calf/Decalf | DÉPENDANCE FORMELLE | isoler les constructions et hypothèses effectivement utilisées |
| Récursion gardée | DÉPENDANCE FORMELLE | produire les trois dossiers de sédimentation |
| `when` / duale | choix de structure arrêté ; preuve non acquise | prouver le typage/sédimentation et le contrat When → effet non borné → ψ/Adm/Consume, règle par règle ; ratifier l'interprétation normative de P3 si nécessaire |

Aucune de ces étapes ne justifie encore une déclaration d'établissement global. Elles constituent les preuves nécessaires à la clôture de l'instruction.
