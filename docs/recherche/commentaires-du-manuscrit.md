# Commentaires d'auteur retirés du texte du manuscrit

Dix commentaires `# …` du manuscrit Org, conservés par la conversion dans des blocs `:::comment` (non rendus), ont été **retirés de `spec/`** le 1er octobre 2026 (anomalie `ANOM-05` : ce sont des éléments de suivi, pas du texte). Ils sont reproduits ici tels quels.

* Les six « À explorer pour un futur état de l'art » sont le **backlog de recherche** des annexes et de la section concernée.
* `[T-12 · ISOLATION PAR TYPES]` et `[HISTORIQUE D'UN ARBITRAGE DEVENU SANS OBJET]` sont des notes de chantier ; elles se rapportent vraisemblablement à `PORT-02` et à l'auto-dualité de `End`.
* Les deux commentaires d'en-tête de l'annexe E étaient devenus faux (ancienne architecture, ancienne lettre `G`) : ils sont archivés ici, non repris (`ANOM-03`).

## `AnnexeA`

```text
À explorer pour un futur état de l'art de cette annexe : conventions de diagnostics riches dans les compilateurs contemporains (Rust, Elm, Roc) ; travaux sur le message d'erreur de type comme objet de recherche à part entière (Wand ; Heeren, Hage et Swierstra).
```

## `AnnexeB`

```text
À explorer pour un futur état de l'art de cette annexe : spécification du Language Server Protocol ; environnements de preuve interactifs à trous typés (Agda, Idris, Hazel — Omar et al.) ; débogueurs à rejeu déterministe (rr, Pernosco) ; notebooks de calcul interactif (Jupyter) pour comparaison avec le REPL tabulaire.
```

## `AnnexeC`

```text
À explorer pour un futur état de l'art de cette annexe : shells structurés à données typées (Nushell, PowerShell, Elvish) ; l'argument de la convergence commande/requête (jq, Miller) ; littérature sur les combinateurs de flux Unix comme fragment d'un calcul plus général (McIlroy).
```

## `AnnexeD`

```text
À explorer pour un futur état de l'art de cette annexe : gestionnaires de paquets adressés par le contenu (Nix, Guix, Unison) ; proof-carrying code (Necula) ; littérature sur l'élimination de la chaîne d'approvisionnement logicielle comme surface d'attaque.
```

## `AnnexeE`

```text
Annexe de présentation formelle. Ce fichier est une SOURCE : il porte les citations sous leur clé symbolique et se destine à être assemblé dans la spécification par le #+INCLUDE: qui s'y trouve. Il ne s'exporte pas seul.
```

## `AnnexeE`

```text
Cette annexe n'est pas exportée. Elle porte du matériau de chantier — protocole de travail, structure des axes, travaux empiriques — qui n'a pas sa place dans un document publié. Les sections G.1 à G.4, en revanche, sont de la spécification : elles migreront vers une annexe exportée dès que le jeu de règles sera écrit, c'est-à-dire dès que G.3 cessera d'être un inventaire. Jusque-là, les publier reviendrait à publier une grammaire sans ses règles.
```

## `AnnexeE/TableDesGlyphes`

```text
À explorer pour un futur état de l'art de cette annexe : la tradition notationnelle APL/J/K/BQN/Uiua dans son ensemble (Hui ; McDonald), et les études d'utilisabilité comparant notation symbolique et alias textuel en pédagogie de la programmation.
```

## `C1/AxiomatiqueGerminale`

```text
[T-12 · ISOLATION PAR TYPES — ch.4 §4.5] Le pari Singularity déplace le poids de l'isolation vers la correction du compilateur. Aucune mesure du risque résiduel n'est produite. À FAIRE : évaluer, ou assumer explicitement le pari dans les limites du document.
```

## `C3/LesContraintesDeValeur`

```text
[HISTORIQUE D'UN ARBITRAGE DEVENU SANS OBJET — auto-dualité de End. Tant que les formes de protocole étaient
 des constructeurs de type primitifs, il fallait définir la dualité par récursion, donc trancher son cas de
 base : End auto-dual, ce qui rend le squelette compact clos et donc dégénéré au sens *-autonome ; ou la voie
 Gay-Vasconcelos, End! et End? duaux l'un de l'autre, qui préserve la distinction entre unité et objet
 dualisant. C'est la convention établie de la discipline que d'adopter la première. La question ne se pose
 plus depuis que la grammaire est syntaxe de surface : la dualité tombe du retournement des arguments de
 l'implication linéaire, il n'y a plus de récursion et donc plus de cas de base à trancher. Consigné pour
 mémoire, et parce que l'arbitrage redeviendrait nécessaire si une extension future faisait des formes de
 protocole des constructeurs primitifs — ou introduisait la délégation de session.]
```

## `C4/ModelesDeMemoire`

```text
À explorer pour un futur état de l'art de cette annexe : gestion mémoire par régions (Tofte et Talpin), hash-consing et structures persistantes (Appel ; Baker), comparaison avec les hiérarchies mémoire sans GC de Rust et de Zig.
```
