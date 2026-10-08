<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 37 : fermeture de la collision de notation du grade

**Date :** 7 octobre 2026

La confrontation règle par règle a confirmé une architecture où \`𝒢\` porte l'annotation complète et
où \`𝓡\` porte l'usage. Une vérification terminologique a cependant retrouvé deux formulations de
C1 qui réintroduisaient une collision : \`𝓤\` était utilisé localement pour le semi-anneau d'usage,
et \`𝒢_pile\` / \`𝒢_budget\` étaient encore qualifiés de « sous-algèbres de \`𝓡\` ».

## 1. Convention retenue

La convention désormais uniforme est :

\`𝓡\` : semi-anneau d'usage ;

\`𝒢 = 𝓡 × 𝕄 × ℒ × 𝔅\` : porteur du grade complet ;

\`𝔅 = ℕ∞\` : composante budgétaire.

La lettre \`𝕌\` n'est plus utilisée comme second nom du semi-anneau d'usage dans le texte normatif.
Elle reste possible comme abréviation de domaine dans un document externe, mais pas comme synonyme local
de \`𝓡\`.

Cette correction est nécessaire pour que la projection \`π_U : 𝒢 → 𝓡\` ne soit pas ambiguë au niveau
des types et des registres.

## 2. Statut de \`𝒢_pile\` et \`𝒢_budget\`

Ces deux objets ne sont plus qualifiés de sous-algèbres de \`𝓡\`. Ils sont des sous-domaines de
\`𝒢\`, obtenus par spécialisation des composantes du grade complet.

Cette formulation ne préjuge pas de l'existence d'une algèbre globale sur \`𝒢\`. Elle permet en
revanche d'exprimer les spécialisations de couches sans affirmer des opérations qui n'ont pas encore
été établies sur toutes les composantes.

Le changement ferme donc une implication indésirable :

\`𝒢\` porteur de grades  \not\Rightarrow  𝒢\` déjà muni d'une multiplication globale.

La question de \`MulG\` reste traitée séparément dans les séances 27 à 34.

## 3. Conséquence pour la factorisation de \`!\`

Le noyau d'indexation peut maintenant être écrit sans collision :

\`𝒢 \xrightarrow{π_U} 𝓡 \xrightarrow{!} End(C)\`.

La notation de la séance 35 \`π_U : 𝒢 → 𝕌\` est donc à lire comme un nom historique du domaine
d'usage. Dans la rédaction normative, le codomaine de la projection est désormais \`𝓡\`.

Cela ne change pas le résultat conceptuel : la comonade consomme un indice d'usage, tandis que le grade
complet demeure dans le jugement et dans les interprétations qui consultent ses autres composantes.

## 4. Statut

**Corrigé normativement :** la collision \`𝓡/𝓤\` dans C1 est supprimée.

**Corrigé normativement :** \`𝒢_pile\` et \`𝒢_budget\` sont des sous-domaines de \`𝒢\`, non des
sous-algèbres de \`𝓡\`.

**Préservé :** aucune décision de cette séance ne transforme \`𝒢\` en grade algebra globale.

**Préservé :** l'architecture factorisée de l'exponentielle reste une hypothèse fortement soutenue,
et non une ratification finale.

La dette suivante est désormais mieux localisée : démontrer la cohérence entre \`Scale_Usage\`,
\`Consume\` et les conversions du grade complet lors des preuves de substitution et de préservation.
