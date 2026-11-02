<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Règles de rédaction de la spécification

Ce fichier fixe les règles d'écriture des sources de la spécification
(`spec/Spec.lean`, `spec/Spec/`, et les textes qui les accompagnent). Il
s'adresse à toute personne — auteur ou agent — qui rédige ou corrige la
spécification. Il ne dit rien du fond : les conventions épistémiques
(postulat, théorème, engagement, lecture, réserve, obligation, exigence, et les
états d'évidence) sont définies par le Guide de lecture du chapitre 1 et ne
sont pas répétées ici. Le présent fichier règle la **forme** : structure,
registre, terminologie, exemples, et la manière de proposer une correction.

Ces règles sont issues du pré-audit rédactionnel du 2026-11-01 et des
arbitrages de l'auteur. Une correction qui contredit l'une d'elles doit le
dire et obtenir l'arbitrage de l'auteur, plutôt que la contourner.

## 1. Architecture du texte

1. **Résumé d'ouvrage.** La spécification s'ouvre sur un résumé unique :
   problème posé, hypothèse, contributions, limites, et renvoi à la taxonomie
   de maturité (arrêté / construit, non éprouvé / nommé, non posé). Toute
   évolution majeure d'un chapitre se reflète dans ce résumé.
2. **Seuil de chapitre.** Chaque chapitre s'ouvre par un seuil : la question
   à laquelle il répond, ce qu'il présuppose, ce qu'il établit, son plan. Un
   fichier de chapitre réduit à un sommaire d'inclusions n'est pas un seuil.
   Le seuil indique aussi, lorsqu'il y en a un, l'outillage avec lequel les
   énoncés du chapitre sont modélisés et vérifiés (par exemple Lean 4 pour
   les preuves, le Framework K pour la sémantique exécutable, TLA+ pour les
   modèles concurrents) : l'outillage n'est pas une fin en soi, il est le
   continuum de la démarche scientifique, et le lecteur doit savoir dès le
   seuil quel artefact porte quelle vérification. Tous les seuils suivent la même structure (objet du chapitre, ce qu'il établit, ce qu'il ajoute, outillage en prose linéaire et sans étiquette), pour que le lecteur retrouve chaque information à la même place d'un chapitre à l'autre.
3. **Seuil et bilan de section.** Une section longue annonce son objet en
   ouverture et, si elle établit quelque chose, le dit en clôture avant de
   passer à la suivante.
4. **Conclusion.** L'ouvrage se conclut par une synthèse qui répond aux
   questions de l'introduction : ce qui est acquis, ce qui déciderait entre
   K7PL et ses alternatives, la prochaine épreuve. Les études de cas ne
   remplacent pas cette conclusion ; elles l'alimentent.
5. **Ordre linéaire d'abord.** Un résultat n'est employé avant d'être établi
   que si le renvoi avant est explicite, local et motivé. Le nombre de renvois
   internes est un coût : on ne crée un renvoi que si la lecture linéaire y
   perdrait davantage.

## 2. Trois régimes de discours, tenus distincts

Le texte mêle trois régimes qu'il doit rendre reconnaissables à la lecture :

- **normatif** : ce qu'une implémentation doit satisfaire (définitions,
  règles, tables, codes d'erreur, blocs `requirement`) ;
- **explicatif** : comment lire le normatif (conventions, exemples,
  commentaires de lecture) ;
- **justificatif** : pourquoi ce choix plutôt qu'un autre (raisons,
  alternatives écartées, littérature).

Règles :

1. Un même paragraphe ne change pas de régime sans le signaler (transition,
   titre, ou bloc distinct).
2. **Modalité contrôlée.** Le « doit » normatif est réservé aux exigences
   sur l'implémentation. Une conséquence logique se dit « il en résulte »,
   « donc », ou se démontre ; elle ne se décrète pas par « il faut ». Les
   tournures déontiques vagues (« il faut », « on doit ») sont à remplacer
   par l'agent et l'obligation explicites : qui doit quoi, en vertu de quoi.
3. Le méta-discours d'assurance (états, évidences, réserves) se place là où
   il borne un résultat — en tête ou en queue de l'énoncé concerné — et non
   en interruption du fil technique. Le vocabulaire du Guide de lecture
   suffit ; on n'en crée pas de synonyme local.

## 3. Revendications, raisons, objections

Suivant la discipline de *The Craft of Research* (Booth et al.) :

1. Toute revendication substantielle énonce sa **raison** et son
   **évidence** dans le voisinage immédiat ; le garant (pourquoi cette
   évidence soutient cette revendication) est explicité dès qu'un lecteur
   compétent pourrait ne pas le partager.
2. La justification d'un choix de conception est d'abord **technique**
   (propriété obtenue, coût évité, cas tranché). Un précédent historique
   (Haskell, APL, la littérature) illustre ou avertit ; il ne tient pas lieu
   de raison à lui seul.
3. Au point où un choix est fait, l'**alternative écartée** est nommée et la
   raison de l'écartement dite en une phrase au moins. Les objections
   prévisibles sont reconnues et reçoivent une réponse ou une réserve
   explicite — pas seulement une borne de portée.
4. Les statuts d'énoncé restent ceux du Guide de lecture ; en particulier,
   une esquisse de preuve se présente comme telle dans la prose qui
   l'introduit, pas seulement dans les métadonnées du bloc.

## 4. Définitions et terminologie

1. **Définir avant d'employer.** Aucun terme technique du langage n'est
   employé dans la prose avant son lieu de définition, sauf renvoi avant
   explicite et local.
2. **Un terme, un concept.** Un même concept reçoit un seul terme dans tout
   l'ouvrage ; un même terme ne désigne jamais deux concepts. Toute
   synonymie héritée est résolue au profit d'un seul terme, l'autre étant
   mentionné une fois comme ancien usage.
3. Les **glosses** et le développement des **acronymes** sont donnés à la
   première occurrence dans le texte, en plus des listes de référence en fin
   d'ouvrage. Ces listes restent exhaustives et servent de contrôle : tout
   terme de la prose y figure, tout terme qui y figure est employé.
4. Les étiquettes internes (identifiants de sections, codes) suivent la
   dénomination courante du texte ; une étiquette héritée qui ne correspond
   plus à son contenu est renommée, et les doublons d'étiquettes sont
   interdits.

## 5. Exemples et figures

1. Tout mécanisme central (règle de typage, discipline de couche, protocole,
   construction catégorique employée ensuite) est accompagné d'au moins un
   **exemple travaillé** : entrée, déroulement, résultat — y compris, quand
   le mécanisme en prévoit, un cas de refus ou d'échec.
2. Un exemple se place au plus près de la définition qu'il éclaire, pas en
   fin de chapitre. Les études de cas du chapitre 7 ne dispensent pas des
   exemples locaux.
3. Toute relation qui se décrit comme un diagramme, un treillis, un
   enchaînement ou une correspondance donne lieu à une **figure** ; la prose
   ne porte pas seule ce qu'un schéma établit d'un coup d'œil.
4. Les tableaux sont réservés aux correspondances exhaustives (tables
   normatives, codes, correspondances de notations) ; un tableau
   partiellement rempli ou redondant avec la prose est supprimé ou complété.

## 6. Registre et voix

1. **Une seule voix.** L'ouvrage adopte un registre unique : scientifique,
   direct, sans familiarité ni emphase essayistique. Les passages
   d'argumentation historique ou rhétorique existent, mais comme régime
   justificatif identifiable (§2), pas comme ton par défaut des chapitres
   techniques.
2. **Instance d'auteur cohérente.** L'ouvrage est d'un auteur unique ; il
   est désigné uniformément par « l'auteur ». Toute autre désignation est
   une coquille à corriger.
3. Les références au texte lui-même (« ce document », « le présent
   chapitre ») sont parcimonieuses : elles servent la navigation, pas
   l'argumentation.

## 7. Micro-style

1. Phrases courtes par défaut ; une phrase qui dépasse deux propositions
   subordonnées est coupée ou restructurée. L'information nouvelle se place
   en fin de phrase ; le sujet de la phrase est, quand c'est possible, ce
   dont le paragraphe parle.
2. Les nominalisations sont dépliées en verbes dès qu'elles cachent un
   agent ou une action (« la levée de la réserve s'opère » → qui lève quoi).
3. Négations : une négation à la fois ; une double négation est réécrite en
   affirmation bornée. Les tournures impersonnelles (« il est », « il y a »)
   cèdent la place à un sujet nommé dès qu'un agent existe.
4. Aucun adverbe d'intensité sans quantité (« très », « largement »,
   « la plupart ») : soit un nombre, soit une borne, soit la suppression.
5. Le tiret quadratin (—) ne s'emploie pas : rarement utilisé dans l'usage
   réel et souvent mal compris des lecteurs, il se remplace par une
   restructuration de la phrase (deux phrases, deux-points, parenthèse
   technique quand elle est brève).
6. Dans les sources, un paragraphe forme un bloc, sans ligne vide en
   son intérieur. Le texte est renvoyé à la ligne à 120 caractères au
   plus ; le code, les formules et les lignes de tableau gardent leur
   ligne propre.
7. Aucun gras dans la spécification : ni graisse typographique sur les
   glyphes mathématiques (un R script gras se lit comme un N et a fait
   croire à un second objet), ni emphase en gras ; l'emphase passe par
   l'italique.

## 8. Manière de corriger

1. Les corrections procèdent **par lots** : un axe des présentes règles, un
   périmètre délimité, un commit. Chaque lot distingue explicitement les
   retouches de **forme** (sans effet sur le sens) des retouches de
   **fond** (toute altération du sens, même légère) ; une retouche de fond
   exige l'arbitrage exprès de l'auteur et n'est jamais noyée dans un lot
   de forme.
2. Aucune correction n'affaiblit un énoncé pour le rendre plus lisse : un
   statut épistémique, une réserve, une obligation ne sont ni supprimés ni
   adoucis par une retouche de forme.
3. Tout fichier nouveau porte son en-tête SPDX (CC-BY-4.0 dans `spec/`),
   `reuse lint` passe sur les fichiers touchés, et les en-têtes de commit
   suivent les Conventional Commits (100 caractères maximum).
