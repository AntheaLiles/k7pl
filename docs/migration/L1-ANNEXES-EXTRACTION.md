<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Extraction des annexes B, C et D

**État :** IN PROGRESS

## 1. Décision

Les annexes B, C et D sont des prototypes d'outillage complémentaire et ne font pas partie du périmètre normatif de K7PL. Elles doivent donc sortir de `spec/`.

Leur retrait ne signifie pas leur suppression historique. Leur contenu doit être conservé avec provenance dans une branche de travail dédiée à l'outillage.

## 2. Contenu identifié

| Annexe | Contenu | Nature |
|---|---|---|
| B | LSP, REPL, Replay Debugger | outil d'édition/exécution/debug |
| C | Sushi, shell applicatif | outil/surface d'administration |
| D | Sugoi, gestionnaire de paquets/services | outil d'écosystème |

Aucun des trois n'est, par cette décision, une composante de la future stdlib.

## 3. Dépendances vers la spécification

L'extraction doit préserver les distinctions suivantes.

### B — LSP/REPL

L'annexe s'appuie sur des mécanismes déjà spécifiés : narrowing, tranche minimale, machines à états, substituabilité, mode JIT et journal d'acteur. Ces mécanismes restent dans la spécification ; c'est leur exposition sous forme d'outil qui sort.

Le passage « le système déjà construit, rendu visible en temps réel » doit être reformulé dans la documentation de l'outil pour ne pas faire de l'existence de l'outil une propriété du langage.

Le Replay Debugger contient également une affirmation forte sur le rejeu. Celle-ci doit être harmonisée avec ARB-PR-04 : la pureté d'un gestionnaire ne suffit pas à établir une identité bit-à-bit générale.

### C — Sushi

Sushi réutilise la syntaxe d'appel universelle et le REPL. La spécification de la syntaxe reste normative ; Sushi comme interprétation administrative ne l'est pas.

Les combinateurs `stream-sed`, `stream-awk` et `spawn-fibrilles` doivent être traités comme propositions d'outillage, et non comme primitives ou composants implicites de la stdlib.

### D — Sugoi

Sugoi dépend de plusieurs mécanismes normatifs : AST normalisé, adressage par contenu, certificats de preuve, vérification locale, capacités matérielles et redémarrage à chaud.

Il faut distinguer strictement les propriétés de K7PL que Sugoi exploite, les formats/protocoles propres à Sugoi, les politiques de distribution, les commandes d'administration et les mécanismes de déploiement.

Le renvoi actuel de C6 vers Sugoi est particulièrement important : il transforme actuellement une propriété d'outillage en référence interne de la spécification. Le texte C6 doit être réécrit pour énoncer directement la règle normative, puis l'outil pourra l'implémenter.

## 4. Renvois actuellement détectés

Les références explicites identifiées dans le corpus courant sont :

- C → B via `sec:annexe-lsp-repl` ;
- D → C via `sec:annexe-sushi` ;
- C6 → D via `sec:annexe-sugoi`.

La recherche doit être répétée après extraction pour vérifier qu'aucun identifiant d'annexe ne subsiste dans le corps normatif.

## 5. Opération d'extraction

L'opération cible une branche dédiée à l'outillage :

1. copier le matériau B/C/D dans le corpus outillage en conservant sa provenance ;
2. retirer les inclusions B/C/D de `spec/Spec.lean` ;
3. supprimer les fichiers normatifs B/C/D de cette branche ;
4. supprimer les renvois croisés entre les annexes ;
5. réécrire C6 pour que sa règle de vérification soit autonome ;
6. vérifier que la spécification se construit sans B/C/D ;
7. vérifier les contrôles de références et de structure ;
8. conserver la branche comme base de développement des prototypes.

Cette branche ne doit pas être fusionnée automatiquement dans `main`. Elle constitue le nouvel emplacement de travail pour les prototypes d'outillage.

## 6. Critère de sortie

L'extraction est terminée lorsque la spécification normative ne dépend plus d'aucune annexe B/C/D, qu'aucune propriété normative n'est perdue, que les affirmations relevant des outils sont reformulées au niveau approprié, que le matériau des prototypes reste récupérable avec provenance et qu'aucune primitive de la stdlib n'est introduite.

**Statut actuel :** analyse prête ; extraction physique à exécuter sur une branche dédiée.
