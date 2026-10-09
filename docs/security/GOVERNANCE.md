<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Gouvernance du projet K7PL

## Portée et état réel

Ce document décrit le modèle de gouvernance actuellement pratiqué, et non une structure souhaitée. À la date de rédaction, K7PL est porté par une seule personne. L'autrice-mainteneuse est responsable des décisions, de l'acceptation des contributions, de la fusion, des releases et de la gestion des incidents. Les agents logiciels peuvent aider à rédiger, analyser et tester ; ils ne sont ni des mainteneurs indépendants ni des approbateurs humains.

Cette concentration des responsabilités est un risque connu. Ce document ne prétend donc pas satisfaire les critères exigeant un facteur de bus supérieur à un, une continuité assurée par une autre personne, ou une revue humaine indépendante.

## Rôles et responsabilités

| Rôle | Titulaire actuel | Responsabilités |
|---|---|---|
| Mainteneuse / autrice | Une seule personne : propriétaire du dépôt | Fixer le périmètre et les priorités ; arbitrer les décisions ; examiner les issues et PR ; vérifier les résultats de CI ; fusionner ; décider et publier les releases ; traiter les signalements de sécurité. |
| Contributrice ou contributeur | Toute personne proposant une contribution | Décrire le problème et le changement proposé ; respecter le processus de contribution ; fournir tests, documentation et éléments de validation pertinents ; répondre aux demandes de clarification. |
| Agent logiciel d'assistance | Outil, sans autorité propre | Produire des propositions et analyses. Ses conclusions doivent être contrôlées ; il ne compte pas comme une personne indépendante, une approbation, un titulaire de rôle humain ou une preuve d'acceptation. |
| Relecteur humain indépendant | Aucun titulaire actuellement | Rôle souhaitable pour une revue indépendante avant fusion ; le rôle n'est pas pourvu et aucune PR ne doit être présentée comme revue par un tiers en son absence. |

## Prise de décision

1. Les propositions non triviales — notamment une modification du langage, de sa sémantique, de ses dépendances ou de la chaîne de publication — doivent être discutées dans une issue avant implémentation.
2. Les décisions de portée scientifique ou architecturale sont prises par la mainteneuse et, lorsqu'elles ont un effet durable, consignées dans les registres de décisions ou la documentation normative appropriée.
3. Les modifications sont proposées par pull request. Les contrôles automatisés requis doivent réussir avant fusion ; un résultat de CI n'est toutefois ni une revue indépendante ni une validation scientifique.
4. Les changements touchant la sécurité, les licences, les dépendances, les releases ou les données de suivi doivent expliquer leurs preuves et limites. Les affirmations de conformité ne peuvent être déduites de la seule présence d'un document.
5. Les versions sont préparées via les procédures décrites dans [CONTRIBUTING.md](../../CONTRIBUTING.md). La publication est un acte explicite de la mainteneuse après vérification du brouillon et des contrôles de release.

## Contributions et résolution des conflits

Le canal normal de discussion est GitHub Issues et Pull Requests. Les contributions doivent suivre [CONTRIBUTING.md](../../CONTRIBUTING.md) et le [code de conduite](../../CODE_OF_CONDUCT.md). La mainteneuse peut demander des modifications, différer une proposition jusqu'à clarification de son impact, ou la refuser en expliquant la raison lorsque cela est utile.

Les signalements de vulnérabilité suivent exclusivement le processus privé décrit dans [SECURITY.md](../../SECURITY.md), et non une issue publique.

## Continuité et limites

La gouvernance actuelle ne garantit pas qu'une autre personne puisse reprendre le dépôt et publier une version en moins d'une semaine. Aucun facteur de bus de deux personnes n'est revendiqué. L'accès de secours, la délégation des droits et la continuité des secrets doivent faire l'objet d'une action humaine distincte ; voir [les actions humaines de sécurité](ACTIONS-HUMAINES.md).

## Revue périodique

Réexaminer ce document lorsque :
- une autre personne devient mainteneuse ou obtient des droits sensibles ;
- le processus de fusion, de release ou de signalement change ;
- une revue de sécurité modifie les frontières de confiance ;
- le projet prépare une release publique importante.

La prochaine revue doit vérifier la concordance avec les paramètres GitHub réels, qui ne sont pas prouvés par ce seul document.
