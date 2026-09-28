<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# Politique de sécurité

## Versions prises en charge

k7pl n'a pas encore de version publiée : seule la branche `main` est maintenue.

## Signaler une vulnérabilité

Merci de **ne pas** ouvrir d'issue publique. Utilisez le signalement privé de
GitHub : onglet **Security**, puis **Report a vulnerability**
(<https://github.com/AntheaLiles/k7pl/security/advisories/new>).

Indiquez la version (commit), les étapes pour reproduire et l'impact supposé.
Un premier retour est fait sous 7 jours ; le correctif et l'avis de sécurité
sont publiés ensemble, avec mention de la personne qui a fait le signalement si
elle le souhaite.

## Périmètre

Sont notamment concernés :

- une faille de **cohérence** : preuve de `False`, contournement de l'audit des
  axiomes, théorème prouvé grâce à un comportement non voulu de l'implémentation ;
- un défaut de l'implémentation du langage permettant d'exécuter du code ou
  d'accéder à des ressources non prévues ;
- une compromission de la chaîne de construction (workflows, dépendances).
