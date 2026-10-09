<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Stratégie de vérification

La première question n'est pas « quel test écrire ? », mais « quelle propriété doit être vraie, et quelle erreur le contrôle doit détecter ? ».

## Contrat de vérification

Pour tout changement substantiel, expliciter :

```
Propriété
→ niveau de la propriété
→ oracle / preuve
→ erreur détectable
→ contrôle choisi
→ résultat observé
```

## Niveaux

Ne pas confondre :

- syntaxe ;
- typage ;
- sémantique ;
- invariant interne ;
- propriété métathéorique ;
- comportement de compilation ;
- rendu de la spécification ;
- reproductibilité d'un artefact.

Une vérification plus faible ne peut pas être utilisée comme preuve d'une propriété plus forte.

## Preuve vs test

Les tests explorent des comportements sélectionnés.

Une preuve établit une proposition dans le système formel considéré.

Une absence d'échec de test n'est jamais présentée comme une preuve de correction formelle.

## Régression

Toute correction de bug doit chercher un contrôle qui aurait échoué avant la correction et qui reste pertinent après celle-ci.

## Reproductibilité

Un artefact n'est reproductible que si plusieurs exécutions indépendantes produisent un résultat conforme au critère défini. Le simple épinglage des dépendances ne constitue pas une démonstration.
