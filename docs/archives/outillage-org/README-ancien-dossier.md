# K7PL — organisation du dossier de travail

4 août 2026

> Organisation de l'ancien dossier de travail (4 août 2026), obsolète : voir le [README de l'archive](README.md) et le [tableau de bord](../../tracking/TABLEAU-DE-BORD.md).

Ce fichier remplace le manifeste comme index vivant. Il dit où sont les choses, comment on construit, et ce qui reste à faire à la main.

## Ce qui a changé le 4 août 2026

Le fichier unique de spécification portait trois matières distinctes : le document publié, la présentation formelle, et le suivi du projet. Elles sont désormais dans trois sources séparées. Les numéros de citation ont quitté la source. Et les soixante-trois versions en copies séparées sont devenues un historique git.

Le découpage a été vérifié par aller-retour : reconstruire depuis les trois sources redonne v64 caractère pour caractère. La migration aux clés est donc sans perte, et non « probablement sans perte ».

## Arborescence

    src/                       LA SOURCE. C'est ici qu'on écrit.
      K7_Specification.org       corps, annexes A-F et H ; un #+INCLUDE: pour la sémantique
      K7_Semantique.org          annexe G, sections G.1 à G.5 — grammaires, règles, sémantique
      K7_TODO_LIST.org           protocole des acteurs, chantier, travaux empiriques, gestion
      K7_Sushi.org               vides — voir « Points restés ouverts »
      K7_Sugoi.org
      K7_LSP_REPL.org

    build/                     PRODUIT. Régénéré, jamais édité à la main.
    bib/                       refs.json, refs.bib, sondes.json, décisions, gel de non-régression
    outils/                    construire.py, controle.py
    corpus/                    extractions de corpus, sous des noms parlants
    ref/                       PDF sources
    archive/                   dossier de transfert, manifeste, scripts à usage unique déjà joués
    k7pl-historique.bundle     copie de sauvegarde du dépôt

## Comment on travaille désormais

### Modifier le document

On édite `src/`. On ne touche jamais à `build/`.

``` bash
make passe V=65        # construit depuis src/, puis rejoue tous les contrôles
```

### Les citations

La source porte la syntaxe de citation **native d'org-mode** : `[cite:@ALGEHED]`, jamais `[58]`. Les numéros IEEE sont engendrés à la construction, par ordre de première apparition (R2).

Deux conséquences utiles. Org lit ces citations lui-même : un export direct par `#+CITE_EXPORT` adossé à `bib/refs.bib` reste possible sans passer par `construire.py`. Et le fichier de suivi, qui portait déjà ses citations sous forme de clés nues `[HEFTY]`, emploie désormais la même syntaxe que le reste — 263 citations converties en tout.

Ce que cela supprime : la table de correspondance à reconstruire à chaque passe, la renumérotation, et le risque qu'un crochet numérique traînant épingle une référence. Une référence qui cesse d'être citée se voit désormais d'un `grep`.

Ce que cela conserve : les sondes sémantiques, qui vérifient qu'un passage cite le bon auteur — question qu'aucune mécanique de numérotation ne résout.

Une clé maintenue en bibliographie sans être citée doit être déclarée dans `bib/decisions-bibliographiques.json`, avec sa date, son motif et sa date de revue. Sans quoi la construction refuse d'écrire. C'est ce qui manquait quand la référence Atkey a traversé vingt-cinq versions sans emploi.

### L'historique

**Le dépôt est déployé et vérifié.** 64 commits, 63 étiquettes `v1` à `v64`, objets sains à `git fsck`, arbre de travail conforme au dernier commit.

Une seule chose reste à faire, et une seule fois : supprimer les fichiers de verrou que git n'a pas pu effacer depuis cet espace. Tant qu'ils sont là, git refusera d'écrire.

``` bash
del .git\index.lock .git\HEAD.lock .git\objects\maintenance.lock
del .git\objects\6e\tmp_obj_*
git status                             # doit répondre sans se plaindre
git add .gitignore && git commit -m "ignore _t"
```

Ce que l'historique rend possible, et qu'il fallait scripter jusqu'ici :

``` bash
git log -S'preuve par réalisabilité'   # -> apparue en v3, disparue en v39
git log -S'Storage as tensorial'       # -> apparue en v11
git diff v38 v39                       # 87 insertions, 41 suppressions
git show v20:k7pl-specification.org    # n'importe quelle version, restituée
git log --follow src/K7_Specification.org   # traverse le découpage
```

Le renommage a été enregistré comme tel : `git log --follow` remonte au-delà de la réorganisation, jusqu'à v1.

### La bibliographie

`bib/refs.bib` est engendré depuis `refs.json` pour reprise dans Zotero. Les clés BibTeX sont celles employées dans la source : ce qui est corrigé dans Zotero se réinjecte sans réappariement.

Rien n'y a été complété par déduction. Quarante-sept entrées sur cent vingt-deux demandent une complétion, parce que la chaîne IEEE d'origine ne portait ni l'année ni le lieu. Elles sont étiquetées pour qu'on puisse filtrer le travail dans Zotero :

|                       |                                                |
|-----------------------|------------------------------------------------|
| `k7pl`                | tout le fonds                                  |
| `k7pl-sans-annee`     | l'année n'est pas dans la chaîne source        |
| `k7pl-sans-lieu`      | ni revue, ni actes, ni éditeur, ni institution |
| `k7pl-type-incertain` | type non déterminable, importé en `@misc`      |
| `k7pl-a-completer`    | réunion des trois précédents                   |

Chaque entrée porte en `note` la chaîne IEEE d'origine : elle est vérifiable contre sa source sans quitter Zotero. Le détail est dans `bib/rapport-conversion.txt`.

## À faire à la main

Cet espace ne peut pas effacer de fichier dans le dossier. Restent donc à retirer :

- les verrous de git, listés plus haut — c'est le seul point bloquant ;
- `spec/` — **vérifié supprimable**. Aucun outil actif ne le lit : `construire.py` et `controle.py` n'ouvrent que `src/`, `bib/` et `build/`. La non-régression bibliographique est gelée dans `bib/non-regression-v64.json`. Et les soixante-trois versions sont dans le dépôt, dont v64 restituée identique au fichier. La chaîne complète a été rejouée sans `spec/` : tous les contrôles passent.
- `outils/apply_v64_mine.py`, `outils/controle_passe_mine.py`, `outils/decouper_mine.py` — scripts à usage unique, déjà joués, copiés dans `archive/`. Ce sont les trois derniers fichiers qui mentionnaient `spec/` ;
- `_essai.txt`, `_t`, `.git-import/` — résidus de la session du 4 août.

## Points restés ouverts

- `src/K7_Sushi.org`, `src/K7_Sugoi.org`, `src/K7_LSP_REPL.org` sont vides. Les annexes correspondantes — E « Sushi », F « Sugoi », D « Interface de développement, LSP et REPL » — sont encore dans `K7_Specification.org`. Je ne les ai pas déplacées sans instruction : sortir une annexe du document publié change sa structure, et c'est un arbitrage. Le déplacement se fait en une passe si vous le voulez.
- `ref/ergonomics-of-sexp.pdf` — 2623 pages, extraites dans `corpus/N-ergonomie-esthetique.txt`, non dépouillées. C'est le corpus de l'axe N.
- Le passage de `K7_TODO_LIST.org` qui décrit l'invariant « clés symboliques » décrit désormais une pratique révolue : la tokenisation en ~@@CLÉ@@ à chaque passe n'a plus lieu d'être puisque la source porte les clés en permanence. À réécrire.
- La suite de sondes compte dix-sept couples ; celle d'origine en comptait trente-quatre. Les dix-sept manquants ne figurent dans aucun fichier transféré et restent à reconstituer.
- Pour ouvrir F1 : quelle version de LEAN4 et de Mathlib, et où vit le dépôt de preuves.

## Où se trouve quoi — *refonte du 28 août 2026*

|  |  |
|----|----|
| `src/` | ***le document*** — `main.org`, `chapitres/`, les annexes `K7_*.org` |
| `bib/` | la bibliographie — `refs.bib` (ce qui est CITÉ), `K7PL-Biblio/` (ce qui est LISIBLE), les décisions |
| `meta/` | ***ce qui gouverne le travail*** — le plan, les questions, le corpus, le protocole, les primitives ; et les figures |
| `outils/` | l'outillage — assemblage, contrôle, index des PDF |
| `build/` | les versions assemblées |
| `OLD/` | ***l'archive*** — le chantier et la théorisation clos, le corpus fusionné, les scripts de passe |

**Pour savoir où nous en sommes** : `meta/plan.org`, une page. **Pour ce qu'il reste à instruire** : `meta/questions.org`, deux cent vingt-quatre questions par arc. **Pour ce qu'on peut lire** : `meta/corpus.org`. **Pour comment on travaille** : `meta/protocole.org`.

**CE QUI A BASCULÉ VERS `OLD/` LE 28 AOÛT, ET POURQUOI CE N'EST PAS UNE PERTE** : /le chantier et la théorisation portaient vingt mille lignes de dépouillement, d'arbitrages et d'entrées de travaux. Ce qui en était VIF — l'état, l'ordre, les questions ouvertes, les règles de travail, les répercussions dues au manuscrit — a été récolté dans `meta/` avant le déplacement. Le reste est consultable et reste CONTRÔLÉ : les entrées T et G y sont comptées à chaque passe, et les désignations bibliographiques y sont vérifiées./
