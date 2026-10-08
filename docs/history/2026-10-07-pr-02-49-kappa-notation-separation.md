<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 49 : séparation des deux usages de `κ`

**Date :** 7 octobre 2026

La revue de C4 a révélé une collision de symbole entre deux objets sans rapport : la composante
temporelle `κ` d'un effet, qui est une famille de coûts travail/profondeur indexée par les niveaux,
et le compteur dynamique utilisé pour démontrer la correction des usages de ressources.

## 1. Objet statique

Dans la grammaire normative, un effet est de la forme

`ε = ⟨φ,κ⟩`

avec

`κ : 𝓛 → (ℕ∞×ℕ∞)`.

Cette `κ` appartient à l'algèbre des effets. Elle est consultée par les projections de niveau,
par `Cost_Budget`, et par les opérations de composition temporelle.

## 2. Objet dynamique

Dans la machine instrumentée du théorème de correction de ressource, il faut un compteur distinct
qui associe à chaque liaison le nombre d'accès effectivement réalisés.

Il est désormais noté `ν`. Le jugement instrumenté devient ainsi

`⟨𝒫 | μ | 𝓜 | τ | ν⟩`

et l'invariant porte sur

`ν(x) ≤ usage(r_x)`.

`ν` est une mesure d'exécution ; `κ` est une annotation statique d'effet. Leur domaine, leur ordre et
leur rôle sont différents.

## 3. Conséquence méthodologique

La séparation interdit une confusion qui devenait dangereuse dans les preuves :

- `κ` est transformée par `φ_n`, combinée par les opérations de l'algèbre d'effets et transmise à
  `Cost_Budget` ;
- `ν` croît avec l'exécution et intervient dans le théorème de correction des ressources ;
- `u` reste la composante d'usage du grade et ne doit être assimilée ni à `κ` ni à `ν`.

Le triplet conceptuel est donc :

`u : grade statique`,

`κ : coût d'effet statique`,

`ν : usage effectif dynamique`.

## 4. Statut

**Corrigé :** le conflit de notation C4 est supprimé dans le théorème de correction de ressource.

**Établi :** le coût temporel et le compteur dynamique ne sont pas le même objet théorique.

**Préservé :** aucune modification du grade, de `Cost_Budget` ou de la comonade n'est nécessaire.

Cette séparation clôt une dette de frontière d'objet ; elle ne constitue pas une preuve de correction du
théorème de ressource lui-même.
