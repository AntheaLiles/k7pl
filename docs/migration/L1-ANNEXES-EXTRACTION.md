<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Annexes B, C et D : options à arbitrer

**État :** ANALYSE PRÉPARÉE ; DÉCISION DE L'AUTRICE REQUISE  
**Périmètre :** qualification sémantique seulement. Ce document n'autorise aucun déplacement physique et ne modifie pas le contenu normatif.

## 1. État courant vérifié

Observation sur `main` au commit [`86959948ff36deb6e8ee0985cf22740787696720`](https://github.com/AntheaLiles/k7pl/commit/86959948ff36deb6e8ee0985cf22740787696720) :

- `spec/Spec.lean` importe l'annexe A ; les modules `spec/Spec/AnnexeB.lean`, `AnnexeC.lean` et `AnnexeD.lean` n'existent pas dans l'arbre courant.
- Le matériau prototype correspondant existe déjà dans [`tools/prototypes-bcd/AnnexB.lean`](../../tools/prototypes-bcd/AnnexB.lean), [`AnnexC.lean`](../../tools/prototypes-bcd/AnnexC.lean) et [`AnnexD.lean`](../../tools/prototypes-bcd/AnnexD.lean). Les sources Org historiques restent dans [`docs/archives/manuscrit-org/`](../archives/manuscrit-org/).
- La recherche des étiquettes `sec:annexe-lsp-repl`, `sec:annexe-sushi` et `sec:annexe-sugoi` ne trouve, dans le code courant indexé, que les prototypes d'outillage et les registres de migration ; aucun résultat correspondant n'a été retrouvé dans `spec/`.
- Le registre central [`docs/tracking/DECISIONS.md`](../tracking/DECISIONS.md) garde D-7 ouvert (« décider avant la première release »). Le texte précédent de ce dossier affirmait au contraire qu'une décision définitive avait été prise. Aucune source consultée ne permet de traiter cette affirmation du dossier comme une ratification explicite de l'autrice.

Conséquence : la séparation physique actuelle entre le Verso normatif et les prototypes est un fait de l'arbre courant. Le choix éditorial et scientifique de maintenir, réunir ou redévelopper ces annexes reste à décider. Il ne faut ni rétablir leurs contenus dans `spec/`, ni modifier des énoncés normatifs pour justifier rétroactivement leur retrait sans cette décision.

## 2. Nature des contenus et frontières

| Contenu historique | Fonction proposée à qualifier | Frontière à préserver |
|---|---|---|
| B — LSP, REPL, Replay Debugger | exposition d'outils d'édition, d'interaction et de débogage | Les mécanismes du langage éventuellement utilisés par ces outils restent normatifs indépendamment de l'existence d'un LSP, REPL ou debugger. La promesse de rejeu doit rester compatible avec ARB-PR-04 et le profil `Π`. |
| C — Sushi | shell d'administration utilisant la syntaxe d'appel universelle et le REPL | Les commandes, combinateurs et conventions de shell ne deviennent pas des primitives ou une partie implicite de la bibliothèque standard. |
| D — Sugoi | prototype de gestion de paquets et de services | Séparer les propriétés garanties par K7PL des formats, protocoles, politiques de distribution, commandes et mécanismes de déploiement propres à l'outil. Une idée de vérification locale dans un prototype n'est pas une preuve de sûreté du produit. |

Sources de provenance : [B historique](../archives/manuscrit-org/K7_LSP_REPL.org), [C historique](../archives/manuscrit-org/K7_Sushi.org), [D historique](../archives/manuscrit-org/K7_Sugoi.org), leurs variantes Verso dans `tools/prototypes-bcd/`, et l'inventaire de conversion [`scripts/org2verso/convert.py`](../../scripts/org2verso/convert.py). Ces sources décrivent le contenu et son origine ; elles ne décident pas à elles seules du périmètre de la prochaine release.

## 3. Options de décision

### Option A — Développer les trois annexes séparément

**Principe :** reprendre B, C et D comme descriptions d'outils documentées et vérifiables, avec statut explicite (prototype, prévu ou implémenté), dépendances, interfaces et références. Chaque affirmation de disponibilité ou de garantie serait vérifiée contre le dépôt de l'outil concerné ; à défaut, elle serait marquée comme proposition.

**Avantages :** conserve l'intention et le contexte propres à chaque outil ; permet une feuille de route distincte par prototype ; évite de fondre des propriétés hétérogènes.

**Coûts/risques :** trois sections demandent une maintenance distincte ; le contenu historique est incomplet et parfois hypothétique ; annoncer leur existence dans le manuscrit pourrait être lu comme une promesse d'implémentation si les statuts ne sont pas précis.

**À fournir avant publication :** responsable et état réel de chaque outil, lien vers implémentation accessible (si elle existe), tests ou démonstrations observés, sources pour les garanties revendiquées.

### Option B — Regrouper en une seule annexe « Outillage complémentaire »

**Principe :** présenter B/C/D dans une annexe unique avec trois sous-sections, une introduction explicite sur leur statut et une table des dépendances vers les mécanismes normatifs.

**Avantages :** réduit la fragmentation et le coût de navigation ; rend plus visible la frontière « langage spécifié / outils envisagés » ; permet d'exposer les prototypes sans les promouvoir comme fonctionnalités garanties.

**Coûts/risques :** la structure historique et les renvois entre annexes changent ; les exemples pourraient laisser croire que ces outils sont un écosystème déjà implémenté ; la réécriture éditoriale et la revue des références restent nécessaires.

**À fournir avant publication :** contenu révisé et sourcé, étiquettes de statut pour chaque outil, liens vérifiés, revue de toutes les références à l'annexe.

### Option C — Différer les annexes hors du document normatif jusqu'à l'implémentation

**Principe :** garder le Verso normatif actuel limité à la spécification du langage ; conserver les prototypes dans `tools/prototypes-bcd/` et les sources initiales dans l'archive, sans présenter les trois contenus comme annexes de la release courante.

**Avantages :** limite les engagements publiés à ce qui est réellement spécifié ; ne nécessite aucune modification du contenu normatif maintenant ; maintient une provenance récupérable pour une décision ultérieure.

**Coûts/risques :** le manuscrit courant expose moins l'écosystème envisagé ; un lecteur ne découvre les prototypes qu'en suivant les liens documentaires ; il faudra réexaminer leur statut avant une release ultérieure.

**Preuve requise :** vérifier les références du texte normatif et le PDF/HTML courant ; ne pas prétendre que le report équivaut à une suppression historique.

## 4. Recommandation d'instruction, sans présumer de la décision

Le dépôt actuel est déjà proche de l'Option C sur le plan du rendu normatif, tandis que la provenance matérielle des trois prototypes est conservée. C'est une observation de l'état existant, pas un choix éditorial ratifié.

Avant de clore ANOM-04, l'autrice doit choisir A, B ou C. Si A ou B est choisi, les affirmations sur les outils devront être reprises et sourcées ; le texte normatif ne sera modifié que si un renvoi ou une proposition courante s'avère effectivement dépendant de ces contenus. Si C est choisi, vérifier que la distinction entre spécification et prototypes est assez visible dans les points d'entrée documentaires.

## 5. Critère de sortie

ANOM-04 ne sera clôturée qu'après : (1) décision explicite de l'autrice, (2) vérification des renvois du Verso, (3) vérification de la provenance des trois prototypes, (4) cohérence du registre central D-7, (5) validation réelle des liens et du rendu. La décision n'autorise aucune nouvelle réorganisation physique.
