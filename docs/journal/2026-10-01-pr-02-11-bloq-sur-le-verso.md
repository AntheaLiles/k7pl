<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 11 : les BLOQ, corrigés dans le Verso

Première séance conduite directement sur `spec/` (le Verso fait foi). Autorisation de l'auteur :
corriger les bloquants ; modifications minimales, chacune nommée ici.

| Fiche | Correction | Reste |
|---|---|---|
| `BLOQ-14` | ch. 1 §1.3 : l'ordre `Unr ⊑ Aff ⊑ Lin` est nommé ordre de précision, distinct du sous-typage `≼` (qui descend sur l'usage) ; ch. 2 (deux phrases) alignés. Règles de l'annexe intactes. | remonter la table 20 (TRANS-06) ; relire les autres `<:` des §3.1 et §4.5 |
| `BLOQ-11` | ch. 2 §2.4 : `∀e ∈ 𝒳, fv(e) = ∅` écrit avant la règle, avec le contre-exemple de substitution. | — |
| `BLOQ-10` | Th. reproductibilité du rejet (ch. 6) : l'invocation de l'inférence principale est remplacée par l'hypothèse nommée `D_det`. | écrire les trois hypothèses de déterminisme (PREUVE-15) |
| `BLOQ-12` | Th. 18 (ch. 3 §3.2) réécrit en proposition de représentation (i) injectivité, (ii) `select` exact, (iii) arithmétique spécifiée par K7PL ; « homomorphisme » et `⊥ + y = ⊥` retirés ou subordonnés. Étiquette `thm:homomorphisme_roues` conservée (identifiant stable). | table de propagation des singularités (IMPL-07) |
| `BLOQ-09` | Th. surêté spatiale (ch. 4 §4.3) : hypothèses H1 (unicité d'introduction), H2 (portée), H3 (imbrication des délimiteurs) explicites ; attribution du §1.3 corrigée. | démontrer H1 et H2 comme lemmes (PREUVE-12) ; définir « région » |
| `BLOQ-07` | Th. fidélité de l'interpréteur (ch. 4 §4.6) : conditionnel à Sim, statut `proposition` ; engagement rouvert dans le guide de lecture. | établir Sim (PREUVE-07) |
| `BLOQ-08` | P1 scindé en P1a (postulat) et P1b (obligation) ; trois arguments invoquant P1 reformulés (monomorphisation, abaissement, réécritures). | arguments des Th. 31 (ch. 5) et §4.6 |
| `BLOQ-05` | non traitée (refonte lourde ℓ / ℓ̂, nouvelles règles : décision sur le décompte 49/45). | à faire |
