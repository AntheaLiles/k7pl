# K7PL — plan de reprise et de réalisation

> Archivé le 2026-10-01 : ce document décrit l'état du 8 septembre 2026 et a été remplacé par [le tableau de bord](../tracking/DASHBOARD.md). Il est conservé pour la trace, tel qu'écrit alors ; les noms de fichiers et les commandes qu'il cite désignent l'ancien arbre de travail (Org-mode).

8 septembre 2026. Établi sur l'état mesuré du dépôt, non sur `meta/plan.org`,
qui date du 2 septembre et se dit lui-même en retard sur le travail.

**Les trois arbitrages rendus.** La destination est **l'implémentation** : le
manuscrit devient la spécification qui la guide. La mécanisation LEAN4 va
**jusqu'à l'abaissement**. Le prototype vient **tôt**, parce qu'il est ce qui
rend les mesures possibles.

---

## 1. Ce que ces trois choix engagent, dit franchement

Ils sont cohérents, et ils sont lourds. Le manuscrit chiffre lui-même une
mécanisation comparable — le suivi d'emprunts par expressions régulières — à
trente-neuf mille lignes, dont trois cinquièmes de preuves. CompCert, qui est
l'exemple que le chapitre 6 invoque pour l'abaissement, représente un ordre de
grandeur au-dessus et plusieurs années-personnes. K7PL demande davantage que
l'un et l'autre : gradation, sessions, effets à portée, et un abaissement vers
MLIR.

Je ne dis pas cela pour dissuader. Je le dis parce qu'un plan qui ne le dirait
pas te ferait découvrir la taille du travail dans dix-huit mois, au lieu de te
laisser décider maintenant ce que tu réduis. **Le plan ci-dessous est donc
construit pour que chaque phase tienne debout seule** — pour qu'un arrêt à la
fin de la phase 2, ou de la phase 3, laisse un résultat et non un chantier.

---

## 2. L'objet qui ordonne tout le reste

Une seule construction sert les trois arbitrages à la fois, et c'est elle qui
donne son ordre au plan : **l'interpréteur de référence**.

- C'est le **prototype**. Il exécute le langage, donc il rend mesurable ce que
  le manuscrit affirme sans mesure.
- C'est l'**oracle**. Le chapitre 6 le conçoit déjà comme le témoin contre
  lequel chaque transformation du compilateur optimisant se compare.
- C'est l'**objet de la dette de preuve**. Le cinquième engagement — la
  fidélité de l'interpréteur — est aujourd'hui « une voie désignée, non
  parcourue ». Le mécaniser, c'est le tenir.

Un même travail répond donc au prototype, à la mesure et à la preuve. Tout ce
qui le précède dans ce plan existe pour le rendre écrivable ; tout ce qui le
suit s'appuie sur lui.

**Ce qui le bloque aujourd'hui : T-68.** On n'écrit pas l'interpréteur d'un
langage dont les vingt et une primitives du noyau n'ont pas de nom.

---

## 3. Le chemin critique

```
  T-68  ──►  gel de la spécification  ──►  interpréteur de référence
    │                                              │
    │                                    ┌─────────┴─────────┐
    │                                    ▼                   ▼
    │                          mécanisation du front    les mesures
    │                                    │              (8 entrées)
    │                                    ▼
    │                         les cinq preuves ouvertes
    │                                    │
    │                                    ▼
    └──────────────────────────►    l'abaissement
```

Tout le reste — les vingt-huit légendes muettes, la table des préfixes
d'erreur, l'intégration de l'annexe E — est hors du chemin critique et se fait
quand l'attente le permet.

---

## 4. Les six phases

### Phase 0 — Clore la spécification (le seul travail purement documentaire)

Ce n'est plus « publier » : c'est **geler une cible** contre laquelle une
implémentation puisse travailler.

| Chantier | Ce qu'il ferme | Mesure |
|---|---|---|
| **T-68, temps 1 : les six questions de conception** | La coalgèbre terminale est-elle dérivable ; la règle d'élimination du diamant et sa contrainte manquante ; le pas différé, une modalité ou deux ; le point fixe déductif, exclu de la liste et pourtant doté d'une règle ; les formes du quantificateur universel ; la comonade a-t-elle une codéréliction | 6 entrées `TODO` → `DONE` |
| **T-68, temps 2 : nommer les vingt et une primitives** | Le choix des mots — ce que tu appelles l'aspect sémantique. L'arc G a arbitré la méthode ; il reste à l'appliquer | 21 entrées `DOING` → `DONE` |
| **Intégrer l'annexe E** | Sa condition de migration est **remplie** : elle disait « les sections G.1 à G.4 migreront dès que le jeu de règles sera écrit », et le jeu de règles est écrit. Son en-tête dit encore le contraire | l'en-tête corrigé, les sections migrées, `main.org` à jour |
| **La table des préfixes d'erreur** | Vingt et un segments — ARC, TYP, MEM, SLC… — n'ont leur table nulle part. Un lecteur qui rencontre `ERR-SLC-001` n'a aucun moyen de savoir | 21 préfixes documentés, 48 codes rattachés |
| **L'inventaire des soixante et une dettes** | Le manuscrit déclare 61 fois qu'il ne démontre pas, ne mesure pas, ou laisse ouvert. Elles ne sont réunies nulle part. Chacune doit devenir : dette datée, hors périmètre assumé, ou à tenir en phase N | un tableau, une ligne par dette |
| **Les vingt-huit légendes muettes** | Vingt-huit `#+CAPTION:` posées sur des blocs export, qu'Org ignore. Écrites, jamais imprimées. Tu dois trancher entre les supprimer, les imprimer sans numéro, ou en faire des flottants | décision rendue, appliquée |
| **Le gel** | Une version de spécification numérotée et datée, qui cesse de bouger sauf correction de faute | `make tout` vert sur la version gelée |

**Ce que la phase 0 ne fait pas** : elle ne cherche pas à tenir les huit
engagements. Quatre sont aujourd'hui tenus par « Rien » ou par « un pari ».
C'est licite pour une spécification, à condition que le texte le dise — et il
le dit.

### Phase 1 — Le noyau exécutable

L'ordre suit les phases de compilation du chapitre 6, qui sont déjà un ordre de
vérification.

1. **Lecteur** — grammaire des termes de l'annexe E, S-expressions du chapitre 5.
2. **Vérificateur** — le jugement germinal et ses trois spécialisations ; les
   phases 1 à 4 du chapitre 6, sans optimisation.
3. **Interpréteur de référence** — la sémantique opérationnelle de l'annexe E,
   schéma par schéma.
4. **Instrumentation** — le journal Cap'n Proto, qui sert au rejeu et donc à la
   mesure.

**Jalon** : un programme des trois couches se lit, se vérifie et s'exécute. Pas
de compilateur, pas d'optimisation, pas de cible native.

**Ce qui devient possible dès ce jalon** : les huit entrées empiriques, les deux
paris — le coût d'expressivité de P3 et P4, la rareté des changements de
fragment — et les six affirmations « aucune mesure ». C'est le retour sur
investissement le plus rapide du plan.

### Phase 2 — Mécaniser le front

On mécanise ce qui est **déjà démontré sur papier**, donc on vérifie plutôt
qu'on ne découvre : grammaires, jeu de règles, préservation, progrès, lemme de
substitution.

Puis la fidélité de l'interpréteur, qui **ferme le cinquième engagement**.

**Jalon** : le noyau de K7PL est un objet formel vérifié, et son interpréteur
est prouvé fidèle à cet objet. C'est le premier point où le projet peut
s'arrêter en ayant produit un résultat citable.

### Phase 3 — Les cinq preuves ouvertes

Préservation du typage par la traduction ; non-interférence graduée ;
divulgation délimitée ; règles de la loi distributive ; règles de la gradation
indexée.

L'annexe E dit que chacune a désormais son support. Deux réserves y sont
attachées et devront être levées ou requalifiées : l'extension de la
non-interférence au fragment avec communication, et la discipline qui garantit
qu'aucun programme traduit n'accède aux canaux distingués.

**Jalon** : le document cesse d'être esquissé. Les théorèmes qui portaient une
esquisse portent une preuve.

### Phase 4 — L'abaissement

La dette que le chapitre 6 nomme sans la tenir, et la plus lourde du plan.

- La préservation graduée **par l'abaissement** : rien n'établit aujourd'hui
  que descendre vers MLIR préserve ce que le chapitre 1 a posé.
- La compilation séparée, et le prix de vérifier l'édition de liens.
- La commutativité entre liage et compilation, qui casse à la transition entre
  l'étage insensible à l'ordre et l'étage qui en dépend.

**Point de décision, à inscrire dès maintenant** : c'est ici que le périmètre
se réduit si le projet doit se réduire. Un abaissement non vérifié mais mesuré
laisse un langage utilisable ; un abaissement vérifié demande CompCert.

### Phase 5 — La mesure, et ce qu'elle rend au manuscrit

Les huit entrées empiriques, les deux arbitrages qui te reviennent — G-06 le
modèle matériel de référence, G-01 et G-05 l'évaluation — et les mesures que le
prototype a rendues possibles depuis la phase 1.

**Le manuscrit se corrige de ce que l'implémentation découvre.** C'est la
conséquence directe du choix « le manuscrit est la spécification » : il n'est
plus figé après le gel de la phase 0, il est *versionné*, et chaque écart
constaté par l'implémentation ouvre une correction datée.

---

## 5. Ce que tu ne m'avais pas nommé

Tu disais sentir qu'il y avait d'autres actions. Voici celles que la mesure a
fait sortir, et que rien dans `meta/` ne portait.

1. **Deux chaînes de production parallèles.** `construire.py` assemble depuis
   `src/` et taille une bibliographie de 249 entrées ; ton export Emacs part du
   même `src/` mais tire `~/wiki/00.resources/references.bib`, 4 326 entrées.
   Les deux produisent un document, aucune ne sait que l'autre existe. Tant que
   c'est ainsi, « tous les contrôles passent » ne dit rien du PDF que tu lis.
2. **Le lectorat n'est fixé nulle part.** Aucun fichier de `meta/` ne dit à qui
   ce document s'adresse. Or il commande tout : ce qu'on définit, ce qu'on
   suppose acquis, ce qu'on démontre. La charte de rédaction a été écrite sans
   cette donnée, et s'en est ressentie.
3. **Soixante et une dettes déclarées, jamais réunies.** Le manuscrit est
   honnête au fil du texte — « ce document ne démontre pas », « aucune mesure »,
   « hors périmètre » — mais personne ne peut les compter en les lisant.
4. **L'annexe E attend une migration dont la condition est remplie.** Son
   en-tête dit encore qu'elle attend le jeu de règles ; le jeu de règles est
   écrit depuis.
5. **Les six questions de conception de T-68 ne sont pas des questions de
   nommage.** Elles sont classées avec les vingt et une primitives à nommer,
   alors qu'elles décident du contenu de la liste. Les traiter ensemble, c'est
   nommer avant de savoir quoi.
6. **Vingt-huit légendes ne s'impriment pas**, et vingt et un préfixes de codes
   d'erreur n'ont pas de table.
7. **`meta/plan.org` est en retard sur le travail** — il le dit lui-même, à la
   quatrième reprise. Un fichier de pilotage qui se sait en retard n'est plus
   un pilotage.

---

## 6. Les jalons, et ce qui les vérifie

| Jalon | Vérifié par |
|---|---|
| T-68 clos | 30 entrées `DONE`, aucune `DOING` ni `TODO` |
| Spécification gelée | `make tout` vert sur une version datée, et le PDF composé sans débordement (`make pdf`) |
| Noyau exécutable | un programme des trois couches lu, vérifié, exécuté |
| Front mécanisé | LEAN4 sans `sorry`, sans axiome en suspens |
| Cinq preuves | les esquisses remplacées, les deux réserves levées ou requalifiées |
| Abaissement | la préservation graduée établie du source au binaire |
| Mesures | les 8 entrées empiriques renseignées, les 2 paris tranchés |

---

## 7. Les risques, et ce qui les tient

**Le manuscrit dérive pendant l'implémentation.** C'est le risque propre au
choix « le manuscrit est la spécification ». *Tenu par* le gel de la phase 0 et
par des corrections datées, jamais par une réécriture au fil de l'eau.

**La mécanisation absorbe tout.** Elle est de très loin le poste le plus lourd,
et elle ne produit rien d'utilisable avant son terme. *Tenu par* l'ordre des
phases : le noyau exécutable vient **avant** la mécanisation, de sorte qu'un
enlisement en phase 2, 3 ou 4 laisse un langage qui tourne.

**T-68 s'éternise.** Nommer vingt et une primitives est un travail de jugement
sans critère d'arrêt naturel. *Tenu par* la séparation en deux temps : les six
questions de conception d'abord, qui ont un critère d'arrêt, puis le nommage —
et par la méthode que l'arc G a déjà arbitrée.

**Le prototype devient le langage.** Un interpréteur écrit vite finit
spécification de fait. *Tenu par* la règle inverse : l'interpréteur suit
l'annexe E schéma par schéma, et tout écart est un défaut de l'interpréteur,
jamais une évolution du langage.
