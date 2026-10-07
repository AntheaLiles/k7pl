<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 15 : fusion de l'annexe E, décisions du 1er octobre

## Fusion de l'annexe E (`STRUCT-23`)

L'annexe E, « Présentation formelle », est dissoute dans le corps :

| Ancienne section | Nouveau lieu |
|---|---|
| E.1 Grammaire des types, E.2 Grammaire des termes, E.3 Règles de typage (substitution comprise) | ch. 3, fin |
| E.4 Sémantique opérationnelle, E.5 Sortes du métalangage, E.6 Ce que chaque preuve ouverte y puise | ch. 4, fin |
| E.7 Table des glyphes | ch. 1, après la table normative des symboles |

Les modules ont été déplacés (`spec/Spec/C1`, `C3`, `C4`), les préfixes « E.n » retirés des titres,
tous les renvois « l'annexe » réécrits en renvois de section (une quarantaine), le préambule de
l'annexe archivé dans [`docs/research/ancienne-annexe-e-preambule.md`](../research/ancienne-annexe-e-preambule.md).
Les étiquettes `sec:g-*` sont conservées. Les annexes restantes sont A à D. Le §1.1 est corrigé : le
jeu de règles existe, ce sont ses propriétés qui restent à établir.

## Décisions de l'auteur

`ARB-PR-07` / `D-2` : famille modale et graduée (motif écrit au §1.2). `ARB-PR-06` : objectif
déclaré (§6.2). `ARB-PR-04` : à instruire. `T-68` : avant-dernier. Première release : porte P6.
