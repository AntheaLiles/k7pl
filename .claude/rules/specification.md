<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Règles de travail sur la spécification

## Statut

`spec/` est la source normative de « K7PL : KonSept Programming Language ».

Le manuscrit porte « ne rien modifier sans l'accord de l'auteur ». Une modification du contenu conceptuel, d'un énoncé, d'une définition ou d'une structure du manuscrit exige donc une demande explicite.

## Avant d'éditer

Identifier :

1. le chapitre et la section concernés ;
2. les définitions utilisées ;
3. les énoncés dépendants ;
4. les références croisées et citations ;
5. le statut actuel de l'assertion ;
6. les fiches de suivi ou obligations liées.

Ne jamais corriger un énoncé simplement parce que l'implémentation est plus facile ainsi.

## Statuts épistémiques

Distinguer au minimum :

- intuition ;
- définition ;
- exigence ;
- assertion argumentée ;
- proposition ;
- théorème ;
- conjecture ;
- propriété formalisée ;
- propriété mécanisée et prouvée.

« Formellement exprimé » ne signifie pas « démontré ».

## Énoncés

Un théorème principal ne doit pas être modifié par un agent sans accord explicite.

Une preuve manquante doit conduire à un problème de preuve ou à une reformulation proposée, pas à une réécriture opportuniste du texte.

## Verso

Respecter la structure existante, les labels, les sceaux, les bibliographies et les extensions de `tools/SpecExt`.

Après une modification pertinente :

```
lake build Spec
lake exe spec --output _out/spec --with-tex
python3 scripts/controle.py
```

Si le suivi est concerné, exécuter également `python3 scripts/suivi.py all`.

## Recherche

Toute affirmation externe nouvelle doit être sourcée. Les agents ne doivent pas convertir une hypothèse de conception en fait littéraire sans source.
