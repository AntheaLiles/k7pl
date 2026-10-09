<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Revue sémantique des dépendances à risque

**État :** note de revue provisoire, à ratifier.  
**Périmètre :** deux situations relevées dans les blocs `::::thm` actifs.  
**Règle :** cette note distingue les références syntaxiques des dépendances réelles de preuve. Elle ne modifie ni les énoncés sources ni leur statut épistémique.

## 1. Résumé des constats

| Cas | Références directes observées | Nature du problème | Conclusion autorisée |
|---|---|---|---|
| `thm:surete_spatiale` / `thm:introduction_unique` | `thm:introduction_unique → thm:surete_spatiale` | Circularité argumentative autour de H1, mais pas de cycle syntaxique | Revue sémantique requise ; ne pas compter comme cycle détecté |
| `thm:lemme_fondamental` / `thm:divulgation_delimitee` | `thm:lemme_fondamental → thm:divulgation_delimitee` et `thm:divulgation_delimitee → thm:lemme_fondamental` | Cycle syntaxique ; le sens des deux arêtes n’est pas identique | Bloquant pour l’affirmation d’une preuve complète ; statuts à laisser ouverts |

## 2. H1 — sûreté spatiale et introduction unique

Sources : `spec/Spec/C4/ModelesDeMemoire.lean`, labels `thm:surete_spatiale` et `thm:introduction_unique`.

Le théorème de sûreté spatiale pose H1 — au plus une capacité d’écriture par région — parmi ses hypothèses. Son esquisse explique que H1 exclut l’introduction de deux capacités distinctes sur une même région. Le théorème d’introduction unique prétend établir cette propriété, mais la désigne comme « hypothèse H1 du théorème `thm:surete_spatiale` ». Son esquisse ajoute que le cas d’élimination de l’arène reste à écrire et que H1 en dépend.

La référence directe est unidirectionnelle : le bloc d’introduction unique cite le théorème de sûreté ; le bloc de sûreté ne cite pas le bloc d’introduction unique par label. Il s’agit donc d’une circularité argumentative potentielle, pas d’un cycle dans le graphe syntaxique.

### Décision à prendre

Il faut établir d’où vient H1, sans utiliser le résultat qu’elle conditionne comme sa propre justification. Les voies possibles à examiner sont :

1. **Compléter la preuve de la règle d’élimination de l’arène.** Si cette règle permet réellement de dériver l’unicité, `thm:introduction_unique` pourrait fournir un résultat indépendant, puis devenir une dépendance de `thm:surete_spatiale`.
2. **Conserver H1 comme hypothèse normative ou architecturale.** Dans ce cas, le théorème d’introduction unique ne peut pas être présenté comme établi par la seule hypothèse qu’il prétend justifier ; sa portée doit être restreinte ou son statut laissé ouvert.
3. **Reformuler les objets et les prémisses après revue des règles.** À envisager seulement si les deux énoncés parlent en réalité de niveaux différents d’unicité.

Aucune de ces voies n’est ratifiée ici. H2 (disjonction des intervalles) et H3 (sens d’imbrication des délimiteurs) doivent rester explicites et distinctes ; la résolution de H1 ne les élimine pas.

## 3. Déclassification — lemme fondamental et divulgation délimitée

Sources : `spec/Spec/C4/SemantiqueOperationnelle.lean`, label `thm:lemme_fondamental` ; `spec/Spec/C2/AdjonctionsEtEnrichissement.lean`, label `thm:divulgation_delimitee`.

Le croquis du lemme fondamental traite les cas ordinaires, puis indique que le cas `Declassify` n’est pas traité et renvoie à `thm:divulgation_delimitee`. L’énoncé du lemme fondamental reste pourtant formulé pour tout terme bien typé. La divulgation délimitée, de son côté, dit explicitement que son croquis n’est pas une preuve et propose une route par paramétricité qui utilise le lemme fondamental et la non-interférence.

Le graphe contient donc bien deux références directes. Leur rôle n’est toutefois pas symétrique :
- l’arête du lemme fondamental vers la divulgation est une référence à la lacune laissée dans son esquisse, pas une prémisse positive de preuve ;
- l’arête de la divulgation vers le lemme fondamental est une dépendance explicite de l’argument proposé.

Ce cycle syntaxique ne suffit pas à démontrer une circularité mathématique formelle ; il établit en revanche que la documentation actuelle ne présente pas encore une dérivation complète et ordonnée des deux résultats.

### Architectures possibles à examiner

1. **Lemme fondamental pour le langage de base.** Restreindre explicitement le lemme fondamental au fragment sans `Declassify`, puis prouver séparément l’admissibilité de la déclassification et la divulgation délimitée. Cette option exige de réexaminer les théorèmes de non-interférence qui dépendent du lemme.
2. **Lemme fondamental paramétré par une relation de libération.** Formuler le cas `Declassify` avec une condition locale de compatibilité ou d’admissibilité, prouver le lemme sous cette condition, puis établir que la construction de divulgation la satisfait.
3. **Résultat auxiliaire indépendant.** Isoler un lemme de paramétricité ou de clôture des échappatoires, démontré sans utiliser le lemme fondamental complet, puis l’utiliser pour établir la divulgation et compléter le cas `Declassify`.

Ces options sont des architectures de preuve candidates, pas des résultats validés. Il faut vérifier leur compatibilité avec la définition des échappatoires, leur clôture, la substitution, la non-interférence et le sens exact de « tout terme bien typé ».

### Décision à prendre

Avant la migration des commandes :
- décider si `thm:lemme_fondamental` porte sur le langage entier ou seulement sur le fragment de base ;
- expliciter le statut du cas `Declassify` (hypothèse locale, obligation ouverte, ou cas démontré) ;
- établir une séquence de dépendances acyclique pour les résultats effectivement prouvés ;
- conserver `thm:divulgation_delimitee` comme non démontré tant qu’une preuve complète n’a pas été fournie et revue.

## 4. Conséquences pour C8

1. Le détecteur de cycles syntaxiques doit signaler le couple lemme fondamental / divulgation délimitée, mais pas le couple sûreté spatiale / introduction unique.
2. La détection syntaxique ne remplace pas la classification des arêtes : preuve, hypothèse, obligation ouverte, citation ou mention contextuelle.
3. Les classifications candidates des quatre énoncés restent provisoires. Aucun ne doit être automatiquement promu à l’état `established`.
4. La migration mécanique ne doit pas résoudre ces questions en changeant silencieusement l’ordre des références, les hypothèses ou les textes.
5. C8.0 reste ouvert jusqu’à résolution documentée de ces points et revue intégrale des énoncés, hypothèses et esquisses concernés.

## 5. Vérifications effectuées

- Lecture des blocs complets `thm:surete_spatiale`, `thm:introduction_unique`, `thm:lemme_fondamental` et `thm:divulgation_delimitee`.
- Extraction des références directes `{num "thm:..."}` dans chacun des blocs.
- Distinction explicite entre cycle syntaxique et circularité argumentative.
- Aucun changement apporté aux sources mathématiques.
