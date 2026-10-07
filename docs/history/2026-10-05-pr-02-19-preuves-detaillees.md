<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 19 : preuves détaillées

Aucune preuve n'est close ; chacune est ramenée à ce qui manque exactement.

* `PREUVE-07` : simulation. Cas pures (β, éliminations, vecteur), congruence ; la trace exige que la
  traduction **enfile le canal de temps** — exigence nouvelle sur la traduction, non conséquence du
  typage. Les clauses de traduction des opérations et de `tick` ne sont qu'en prose.
* `PREUVE-08` : convention de remplissage (structure plus profonde écartée) et récurrence sur r.
* `PREUVE-10` : conversions par facteur (identité sauf l'usage) ; reste `w ∘ ε = w`.
* `PREUVE-11` : clause par facteur ; le facteur budget reste à écrire.
