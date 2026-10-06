<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Décisions et analyses spécifiques

**État :** IN PROGRESS  
**Périmètre :** migration sémantique de `docs/suivi/`  
**Objet :** convertir les arbitrages historiques en critères scientifiques et en actions traçables, sans promouvoir prématurément leur contenu dans la spécification normative.

Ce document complète [L1-SUIVI.md](L1-SUIVI.md). Il ne remplace ni la spécification, ni les documents d'architecture, de méthode ou d'assurance. Une décision y décrite comme retenue correspond à l'état de migration arrêté ; sa traduction normative ou formelle reste une action distincte lorsqu'elle n'est pas encore réalisée.

## 1. Rejeu et reproductibilité — ARB-PR-04

### Décision

La revendication générale de rejeu bit-à-bit est abandonnée comme propriété sémantique générale de K7PL.

La reproductibilité est formulée relativement à un profil d'exécution `Π`. Le profil doit permettre de distinguer au minimum :

- la version de la spécification et du langage ;
- la représentation/formalisation concernée ;
- l'implémentation ou la chaîne d'exécution ;
- l'architecture et les paramètres matériels pertinents ;
- les paramètres d'exécution ;
- les sources de non-déterminisme pertinentes.

Le bit-à-bit peut rester une propriété expérimentale d'une chaîne concrète lorsqu'elle est effectivement établie. Il ne constitue pas une obligation sémantique universelle du langage.

### Portée scientifique

Cette distinction sépare :

1. la reproductibilité computationnelle d'un résultat ou d'une trace ;
2. le déterminisme sémantique lorsqu'il est défini ;
3. l'identité binaire d'un artefact ou d'une exécution particulière.

Elle évite de faire porter à la sémantique une propriété qui dépend de toute la chaîne matérielle et logicielle.

### Actions

1. Remplacer la formulation historique d'ARB-PR-04 par cette distinction dans le registre de migration.
2. Vérifier la cohérence de la définition de `E_repro` et du profil `Π` avec cette portée.
3. Tracer la revendication retenue vers `ASSURANCE.md`, sans déclarer la propriété établie avant production de l'évidence correspondante.
4. Conserver la promesse bit-à-bit historique comme provenance, non comme engagement normatif.

**État :** DÉCISION ARRÊTÉE ; FORMALISATION À EFFECTUER.

## 2. Imports théoriques ciblés

Les imports ne doivent pas être traités comme un bloc homogène. Le statut est désormais déterminé par le rôle effectivement joué dans la cohérence du projet.

| Élément | Statut retenu | Rôle | Travail requis |
|---|---|---|---|
| Théorie des modes | **NORMATIF** | Fondation normative reliant les composantes modales du langage | Démontrer la cohérence inter-composantes et expliciter les dépendances |
| Théorie des types graduée formalisée | **NORMATIF** | Fondation normative reliant les grades, les usages et les obligations de typage | Démontrer la cohérence inter-composantes et établir la correspondance avec la formalisation |
| Calf/Decalf | **DÉPENDANCE FORMELLE** | Mécanisme de construction utilisé pour obtenir certaines structures formelles | Décrire précisément ce qui est construit avec lui et ce qui ne devient pas pour autant normatif |
| Récursion gardée multi-horloges | **DÉPENDANCE FORMELLE**, à qualifier par sédimentation | Mécanisme temporel dont le statut et les obligations diffèrent selon les couches | Produire une analyse séparée pour les couches 1, 2 et 3 |

### 2.1 Théorie des modes

La théorie des modes n'est pas un simple support bibliographique. Elle doit être traitée comme une composante normative dont la fonction est de relier plusieurs parties du système.

Le travail attendu n'est donc pas seulement de « verser un import » dans la spécification. Il faut établir une chaîne de cohérence montrant comment les notions modales interviennent conjointement dans :

- les jugements ;
- les règles de typage ;
- les usages/ressources concernés ;
- les constructions dépendantes ;
- les propriétés de préservation ou de cohérence qui leur correspondent ;
- leur représentation formelle ;
- les preuves et tests qui constituent l'évidence associée.

Le critère d'achèvement est une démonstration de cohérence inter-composantes, et non la seule présence d'une définition importée.

### 2.2 Théorie des types graduée formalisée

La théorie des types graduée formalisée possède le même statut normatif. Elle doit donc être reconstruite comme une dépendance conceptuelle de bout en bout.

Le travail doit notamment distinguer :

- les notions graduées qui sont constitutives du langage ;
- les règles qui les propagent ;
- les obligations mathématiques qu'elles imposent ;
- la formalisation Lean correspondante ;
- les propriétés qui doivent être démontrées pour justifier la cohérence de la chaîne.

La formalisation existante ne vaut pas, à elle seule, démonstration que toutes les composantes normatives du langage sont cohérentes avec cette théorie. Cette correspondance doit être construite explicitement.

### 2.3 Calf/Decalf

Calf/Decalf ne doit pas être promu au même niveau normatif. Il constitue un mécanisme de construction.

Le travail consiste à établir une frontière explicite entre :

- les objets ou propriétés de K7PL qui sont normatifs ;
- les constructions obtenues au moyen de Calf/Decalf ;
- les résultats formels qui dépendent de ce mécanisme ;
- les éventuelles hypothèses importées avec le mécanisme.

Le mécanisme peut être indispensable à la construction d'une formalisation sans devenir une composante normative de K7PL.

### 2.4 Récursion gardée multi-horloges

La récursion gardée multi-horloges doit être analysée par sédimentation. Une qualification globale serait trop grossière.

Le chantier doit produire trois analyses distinctes :

| Couche | Question directrice |
|---|---|
| Couche 1 | Quelle structure temporelle minimale est normative et quelles obligations de récursion lui sont propres ? |
| Couche 2 | Quelles structures supplémentaires de communication/concurrence utilisent ou transforment la discipline temporelle ? |
| Couche 3 | Quelles constructions de niveau supérieur réutilisent cette discipline et quelles nouvelles obligations apparaissent ? |

Le résultat attendu est une carte « couche → mécanisme → obligation → preuve/formalisation », et non une simple citation de la littérature sur la récursion gardée.

**État global :** DÉCISION ARRÊTÉE ; ANALYSE FORMELLE À CONDUIRE.

## 3. `when` et diamant temporel

### Décision

La voie retenue est l'introduction de la structure supplémentaire correspondant à l'option A de l'arbitrage historique.

La complexité de cette solution n'est pas un motif de réduction du périmètre. Le principe architectural de K7PL est au contraire de sédimenter la complexité jusqu'à obtenir un modèle cohérent et globalement compréhensible.

L'existence éventuelle d'une restriction locale suffisante de `when` reste une question de sédimentation et de preuve, mais elle ne constitue plus un critère permettant d'écarter la structure supplémentaire.

### Conséquence

La question « une restriction locale suffit-elle ? » devient une question de couche :

- déterminer à quelle couche l'information manquante apparaît ;
- identifier la structure qui doit la porter ;
- formuler les règles correspondantes ;
- vérifier que les invariants nécessaires sont restaurés ;
- établir les obligations de préservation.

Il ne faut donc pas transformer cette recherche en alternative éditoriale entre « simplifier » et « ajouter ». La structure est retenue ; la sédimentation détermine où et comment elle apparaît.

**État :** DÉCISION ARRÊTÉE ; SÉDIMENTATION ET PREUVES À CONDUIRE.

## 4. T-68 — minimalité des 44 primitives

T-68 constitue désormais un chantier scientifique autonome et bloquant pour l'étape d'implémentation/mécanisation.

La question n'est pas de stabiliser une liste de noms. Il faut démontrer que chaque primitive conservée correspond à une obligation que les constructions disponibles ne permettent pas de satisfaire sans réintroduire une primitive de même niveau.

Le critère de minimalité retenu est donc :

> Une primitive est minimale si aucune factorisation ou dérivation disponible ne préserve l'ensemble de ses obligations normatives et formelles sans introduire une autre primitive de même niveau.

L'analyse doit distinguer au minimum :

- primitive conceptuelle ;
- primitive syntaxique ;
- primitive formelle ;
- primitive d'implémentation.

La similarité de forme ou de notation ne constitue jamais un critère suffisant de factorisation. Les sept factorisations refusées constituent une base de contre-exemples et de critères négatifs ; elles doivent être réutilisées dans l'audit T-68.

Pour chaque primitive, le dossier final devra pouvoir relier :

`primitive → obligation → règle → propriété → preuve`

et, lorsqu'une factorisation a été examinée :

`primitive → factorisation candidate → obligation perdue ou conservée → décision`.

### Gate

T-68 doit être suffisamment établi avant :

- la stabilisation de l'implémentation du noyau ;
- la mécanisation systématique correspondante ;
- toute conclusion de minimalité du langage.

Cela ne signifie pas qu'aucun prototype exploratoire ne puisse exister ; cela signifie qu'un prototype ne doit pas être pris comme fondement d'une architecture normative encore non stabilisée.

**État :** CHANTIER MAJEUR ; BLOQUANT POUR LA STABILISATION DE L'IMPLÉMENTATION ET DE LA MÉCANISATION.

## 5. Annexes B, C et D

### Décision

Les annexes B, C et D ne font pas partie de la spécification normative à venir.

Elles correspondent à des ébauches d'outils complémentaires :

- annexe B : LSP / REPL ;
- annexe C : Sushi ;
- annexe D : Sugoi.

Ces éléments doivent sortir de la spécification et être traités dans une branche de travail distincte consacrée à l'outillage complémentaire.

Ils ne sont pas, par principe, des composantes de la future bibliothèque standard.

### Conséquence normative

Le problème historique d'ANOM-04 n'est donc pas de « compléter » les annexes jusqu'à leur donner une fausse complétude.

La correction consiste à rétablir la frontière entre :

1. ce que la spécification formalise et rend normatif ;
2. les outils susceptibles d'exploiter cette spécification ;
3. les futurs composants éventuels de l'écosystème ;
4. les idées ou prototypes qui ne font pas partie du langage.

Les annexes doivent donc être retirées du corpus normatif, avec conservation de leur provenance et de leur statut historique.

### Action de migration

1. Identifier les renvois du corps de la spécification vers B, C et D.
2. Pour chaque renvoi, déterminer s'il décrit une propriété normative ou seulement un outil.
3. Réécrire le texte normatif lorsqu'il dépend actuellement du matériau outillage.
4. Déplacer le matériau d'outillage dans une branche/documentation dédiée, sans le promouvoir dans la stdlib.
5. Conserver la provenance de la décision dans le registre de migration.
6. Vérifier ensuite que la spécification peut être comprise et formalisée sans ces trois annexes.

**État :** DÉCISION ARRÊTÉE ; EXTRACTION DE L'OUTILLAGE À EFFECTUER.

## 6. Synthèse des décisions arrêtées

| Point | Décision | Prochaine preuve/action | Bloquant |
|---|---|---|---|
| ARB-PR-04 | Reproductibilité paramétrée par `Π`, pas de rejeu bit-à-bit général | Formaliser `Π), `E_repro`, puis assurer la traçabilité | Non |
| Imports | Modes + types gradués = NORMATIF ; Calf/Decalf = DÉPENDANCE FORMELLE ; récursion gardée multi-horloges = qualification par couche | Construire les chaînes de cohérence et la sédimentation | Oui pour la clôture théorique |
| `when` | Option A retenue | Sédimenter la structure supplémentaire et établir les invariants | Oui pour la formalisation temporelle |
| T-68 | Audit autonome de minimalité des 44 primitives | Primitive → obligation → règle → propriété → preuve | **Oui : implémentation/mécanisation** |
| Annexes B/C/D | Sortie de la spécification ; branche outillage séparée ; pas stdlib par défaut | Extraire les renvois et créer la frontière d'outillage | Oui pour la cohérence normative |

## 7. Décisions restant ouvertes

Aucune décision d'auteur supplémentaire n'est requise pour engager les cinq chantiers ci-dessus.

Les choix futurs doivent porter sur les résultats produits par ces chantiers, notamment lorsqu'une preuve, un contre-exemple ou une analyse de sédimentation révélera une contrainte nouvelle. Ils ne doivent pas rouvrir les décisions arrêtées ici sans élément scientifique nouveau.

## 8. Provenance

Sources principales de la migration :

- `docs/suivi/DECISIONS.md` — arbitrages et décisions historiques ;
- `docs/suivi/primitives.md` — inventaire et justification lexicale des primitives ;
- `docs/suivi/factorisations-refusees.md` — contre-exemples aux factorisations ;
- `docs/suivi/hypotheses-de-module.md` — hypothèses de formalisation et obstacles ;
- `docs/suivi/ANOMALIES.md` — état des anomalies de conversion et des annexes.

Les formulations de ce document sont une qualification de migration. Elles ne valent pas preuve mathématique des propriétés qu'elles prescrivent de démontrer.
