<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 28 : troncature par conteneur, abaissement en conformité

`PREUVE-08` close. La condition « F préserve les troncatures » n'est pas une hypothèse sur F : sous la
convention d'écartement (`N_0 A = A`, `N_{r+1} A = A × F(N_r A)`), la troncature est _définie_ par
`T_{r+1,n+1}(a,t) = (a, F(T_{r,n}) t)`, et les lois de comonade se démontrent par récurrence sur le rang
extérieur pour **tout** foncteur F, donc tout conteneur : aucune restriction de la classe admissible. Le
théorème `thm:troncature_comonade` change d'énoncé (et de sceau : théorème) ; la preuve est sur papier,
non mécanisée.

Trois précisions que la vérification a imposées, à confirmer par l'auteur :

* **La graduation est additive.** `δ_{r,s} : N_{r+s} → N_r N_s` : la fenêtre extérieure de r niveaux
  porte en chaque nœud une fenêtre intérieure de s niveaux, et ces fenêtres se recouvrent. Le texte écrivait
  « l'indice du produit du semi-anneau » ; avec l'écartement, un indice produit est impossible
  (r = s = 1 : `N_1 → N_1 N_1` exigerait trois valeurs d'un arbre qui n'en porte que deux). La phrase du
  §2.3 est corrigée au minimum.
* **L'idempotence** s'entend comme la tour `T_{r,s} ∘ T_{s,n} = T_{r,n}` : sans valeur de remplissage,
  `N_r` n'est pas un sous-objet de `N`, et `T_r ∘ T_r` n'a pas de sens.
* **`λ_r`** se définit directement (`λ_0 = id`, `λ_{r+1} = ⟨F fst, F(λ_r) ∘ F snd⟩`), sans l'injection
  `η_r` de l'ancien énoncé ; elle vérifie `λ_r ∘ F(T_r) = T_r ∘ λ`.

`IMPL-06` close. Le Th. 36 (`thm:abaissement_grades`, conjecture ⟨compilation⟩) se lit, comme les
théorèmes de disposition et de rejeu binaire, comme une propriété de conformité du compilateur à un profil
de représentation, vérifiée passe par passe par le pipeline de validation ; la phrase dit où l'obligation
se vérifie, non qu'elle est acquise.

## Lot BIB

Huit fiches closes (`BIB-02`, `-09`, `-11`, `-13`, `-14`, `-15`, `-17`, `-19`) : détail dans
[`../bibliographie/verifications-pr02.md`](../bibliographie/verifications-pr02.md). Trois d'entre elles
n'étaient pas des références introuvables mais des **références déjà au manuscrit sous un autre nom** que celui de la
fiche (`BIB-11` : Fluet–Morrisett ; `BIB-19` : Pédrot–Tabareau ; `BIB-02` : Saffrich et al. sur les canaux). Un texte
corrigé (§4.2, file prouvée et anneau décrit : deux objets). À arbitrer par l'auteur : le sens de l'invalidation au
destructeur d'une capacité exportée (`BIB-17`).

## Simulation, relation logique, anomalie

* `PREUVE-07` et `BLOQ-07` restent partielles. En conduisant l'induction on trouve que la relation → **n'a de
  schéma que pour une partie des constructeurs** (`ANOM-17`) : point fixe, formes temporelles, parallèle,
  localisation et couche 2 n'ont aucune règle de réduction ; les « règles globales » de la couche 2 renvoient à des
  règles non écrites. La simulation, comme le progrès (une phrase l'écrit désormais dans les deux esquisses), ne
  porte donc que sur les formes réduites. Il manquait en outre la clause de `return` : sans transfert du canal de
  temps, un `let` à première branche pure laissait `t''` sans lien avec le journal ; elle est écrite (transfert de
  la logique linéaire). Décision de portée à prendre par l'auteur : quels constructeurs entrent dans le noyau réduit.
* `FACT-07` close : la relation du §4.7 est la seule famille dont les trois énoncés (non-interférence, divulgation
  délimitée, lemme fondamental) sont des lectures. Une monotonie en ℓ avait été envisagée : elle est **fausse** sur les
  types de fonction (abaisser ℓ agrandit les arguments et la relation des résultats), et le texte le dit. La préservation
  n'est pas absorbée (énoncé sur un pas, non sur deux exécutions).
* `FACT-10` partielle (identification écrite, factorisation en attente de la simulation).
* `PREUVE-06` close : le cas des indices dynamiques est déjà déclaré hors périmètre.
* Laissées ouvertes : `PREUVE-03` (les clauses de session de la relation logique et le système de sortes sont à
  construire, travail unique partagé avec la traduction) et `BLOQ-05` (la correspondance ℓ/ℓ̂ n'a de contenu que par
  nœud de dérivation : pour un terme clos elle est triviale, `niv(0) = ⊥` ; l'énoncé demande une reformulation
  avant la preuve).
