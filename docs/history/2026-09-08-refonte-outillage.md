# Refonte de l'outillage — audit, plan, et ce qu'il faut trancher

> Archivé le 2026-10-01 : ce document décrit l'état du 8 septembre 2026 et a été remplacé par [le tableau de bord](../tracking/DASHBOARD.md). Il est conservé pour la trace, tel qu'écrit alors ; les noms de fichiers et les commandes qu'il cite désignent l'ancien arbre de travail (Org-mode).

État au 8 septembre 2026. Ce document s'arrête avant l'exécution : il attend
validation.

---

## 0. Ce que valent les chiffres qui suivent

Je ne peux pas compter les invocations : rien ne les journalise. Ce que je peux
mesurer, et que j'ai mesuré :

- **les mentions** de chaque outil ailleurs que dans son propre fichier —
  Makefile, README, autres outils, livrables, `meta/` ;
- **s'il tourne aujourd'hui**, en le lançant, ceux qui écrivent exceptés ;
- **sa date**, et son historique git — mince : quatre outils sur vingt ont un
  commit ;
- **ce que ses chemins d'entrée exigent**, et si ces chemins existent encore.

Quand je dis « jamais employé », je dis : zéro mention, aucun commit, et une
intention datée d'une passe close. C'est un faisceau, pas une preuve. Là où le
faisceau est mince, je le dis.

---

## 1. Le relevé qui commande tout le reste

**Le contrôle a décroché du document.** `make controle` porte `V ?= 230`. Le
fichier `build/K7_Specification-v230.org` date du **28 août**. Les sources
datent d'**aujourd'hui**. Onze jours de travail — la charte de rédaction, la
passe des théorèmes, les remarques en marge, le glossaire — ne sont pas dans le
document que le contrôle contrôle.

Vingt-deux des trente contrôles lisent ce fichier assemblé. Huit lisent `src/`
directement — et ce sont, sans exception, ceux que j'ai ajoutés ces derniers
jours. Je contournais un socle périmé sans le nommer.

La preuve tient en deux lancements. Sur `v230`, tout passe. Sur un assemblage
frais que je viens de produire, **un contrôle échoue** : `renvois orphelins :
tab:modalites-intervalles`. C'est la table de la page 80, celle dont j'ai retiré
hier le `\label` parasite. J'avais corrigé le contrôle qui lit `src/`, pas son
doublon qui lit le build.

Même histoire pour `croise.py` : lancé seul, il crie que « la grammaire des
termes est en retard sur le jeu de règles ». Lancé sur un assemblage frais, il
passe. Son défaut par défaut est `v297`, du 2 septembre. **L'alarme était vraie
il y a une semaine, et elle sonne encore dans le vide.**

Un outillage qui crie au loup sur des artefacts périmés est pire qu'un outillage
absent : il produit de la confiance imméritée dans un sens, et du bruit qu'on
apprend à ignorer dans l'autre.

---

## 2. Inventaire

Vingt outils, 3 762 lignes. `controle.py` en porte 936 — un quart de l'atelier
dans un seul fichier.

| Outil | Intention d'origine | Usage réel | État | Effets de bord d'une modification |
|---|---|---|---|---|
| `construire.py` | Assembler `src/` vers `build/`, résoudre les inclusions, tailler la bibliographie d'export | 5 mentions ; tourne ; pivot du Makefile | **conserver** | Toute la chaîne en dépend |
| `controle.py` | Contrôle de passe sur le document assemblé | 15 mentions ; tourne ; lancé à chaque séance | **réécrire** (découper) | Importe `croise` ; 936 lignes, 30 sections hétérogènes |
| `croise.py` | Croiser grammaire et jeu de règles ; deux contrôles annexes | 1 mention, comme bibliothèque de `controle.py` | **fusionner** dans `controle.py` | Son `__main__` fait double emploi et ment |
| `audit_org.py` | Blocs non fermés, emphase impaire — ce qui casse l'export | 2 mentions ; tourne ; lancé souvent | **fusionner** dans `controle.py` | Aucun : lecture seule, sans dépendance |
| `mesure_prose.py` | Mesurer la prose contre la charte | 4 mentions ; tourne ; pivot de la passe d'écriture | **conserver**, renommer | Cibles lues dans `CHARTE-REDACTION.md` |
| `pdf_index.py` | Registre du fonds : clé → titre, résumé, PDF | 3 mentions ; tourne ; `make index` | **conserver**, renommer | Écrit `bib/pdf-index.json`, lu par `controle.py` |
| `arcs.py` | Classer le corpus par arc après réexport Zotero | 0 mention ; tourne | **fusionner** avec le registre | Écrit dans `meta/` |
| `deborde.py` | Relever ce qui sort de la marge dans le PDF | 2 mentions ; **ne tourne pas** — `src/main.pdf` n'existe pas | **réécrire** | Dépend d'un artefact que l'outillage ne produit pas |
| `diagnostic-export.sh` | Diagnostic de l'export org → PDF | 1 mention ; jamais relancé | **fusionner** avec `deborde` | Shell au milieu de dix-neuf fichiers Python |
| `derouler.py` | Rendre un paragraphe à une seule ligne | 0 mention ; passe du 3 septembre, jouée | **archiver** | Écrit dans `src/` |
| `derouler_listes.py` | Même chose pour les continuations d'item | 0 mention ; suite de la précédente, jouée | **archiver** | Écrit dans `src/` |
| `style_org.py` | Emphase impaire et découpage des lignes | 0 mention ; passe jouée | **archiver** | Écrit dans `src/` |
| `passe_annexes_mine.py` | Restructurer les annexes — 4 août | 0 mention ; **déjà copié dans `OLD/archive/`** | **supprimer** | Aucun |
| `passe_documentaire_mine.py` | Qualité documentaire — 4 août | 0 mention ; **déjà dans `OLD/archive/`** | **supprimer** | Aucun |
| `passe_latex_mine.py` | Passe typographique — 4 août | 0 mention ; **déjà dans `OLD/archive/`** | **supprimer** | Aucun |
| `passe_T42_mine.py` | Construire le monoïde des transformateurs | 0 mention ; T-42 close | **archiver** | Écrit dans `src/` |
| `remap_cles_mine.py` | Réappliquer les clés Zotero révisées | 0 mention ; passe jouée le 3 septembre | **archiver** | Écrit dans `src/` |
| `apply_v64_mine.py` | v63 → v64, passe de consignation | 1 mention, dans le README qui dit de le retirer ; **lit `spec/`, disparu** | **supprimer** | Aucun : mort par disparition de son entrée |
| `controle_passe_mine.py` | Ancêtre de `controle.py` | 1 mention, la même ; **lit `spec/`** | **supprimer** | Aucun |
| `decouper_mine.py` | Découper v64 en trois sources | 1 mention, la même ; **lit `spec/`** | **supprimer** | Aucun |

Et hors `outils/` : **`build/` pèse 238 Mo pour 769 fichiers**, dont 271
assemblages du même document, numérotés de 65 à 335 avec des trous.

---

## 3. Les quatre relevés

### Doublons fonctionnels

1. **Deux contrôles de renvoi.** `[Renvois]` lit le build, `[Renvois et
   étiquettes LaTeX]` lit `src/`. Même question, deux réponses, une seule tenue
   à jour. C'est le contrôle qui échoue aujourd'hui.
2. **`croise.py` en double emploi avec lui-même.** `controle.py` en importe
   trois fonctions ; son `__main__` refait le travail sur une autre version et
   rend un autre verdict.
3. **Trois scripts d'hygiène org** — `derouler`, `derouler_listes`, `style_org`
   — qui font la même chose à trois moments : normaliser la mise en source. Le
   deuxième est écrit dans son propre en-tête comme le rattrapage du premier.
4. **`audit_org.py` recouvre partiellement `controle.py`** sur les délimiteurs
   mathématiques. Deux comptages, deux formulations, un seul sujet.
5. **Trois `passe_*_mine.py` existent en double** : dans `outils/` et dans
   `OLD/archive/`.

### Zones mortes

- `apply_v64_mine.py`, `controle_passe_mine.py`, `decouper_mine.py` : leur
  entrée, `spec/`, n'existe plus. Ils ne peuvent pas tourner. Le README dit
  depuis le 28 août qu'ils sont à retirer.
- `passe_T42_mine.py`, `remap_cles_mine.py`, `derouler*.py`, `style_org.py` :
  passes closes, zéro mention, zéro commit.
- `deborde.py` : vise `src/main.pdf`, qui n'est pas là.
- 271 assemblages dans `build/`.

### Points de friction récurrents

1. **Le décrochage du contrôle**, décrit au § 1. Le plus coûteux : il a rendu
   « tous les contrôles passent » douteux pendant onze jours.
2. **Le numéro de version.** Il n'est ni le temps ni un compteur : `v335` date
   du 2 septembre, `v230` du 28 août, et en assemblant tout à l'heure j'ai
   **écrasé un `v231` d'août** sans m'en apercevoir. Trois outils portent trois
   défauts différents — 230, 297, 66.
3. **Pas d'Emacs dans mon bac à sable.** Chaque fois que j'écris un filtre
   elisp, je le transcris en Python pour l'éprouver. Je l'ai fait deux fois
   aujourd'hui, dans `/tmp`, et les deux fois le fichier a disparu avec la
   séance. C'est ainsi que j'ai trouvé la boucle infinie qui aurait figé ton
   export — la méthode est bonne, son absence d'atelier ne l'est pas.
4. **Le PDF n'est pas dans la boucle.** Aucun outil ne le produit, un seul le
   lit, et il ne le trouve pas. Tout ce que je sais du rendu, je l'obtiens en
   écrivant du `pdfplumber` à la main dans la séance.
5. **Les livrables s'empilent sans se périmer.** Huit fichiers, dont
   `CORRECTIONS-EMACS.md` (4 septembre) que `REMISE-EMACS-07-09.md` puis
   `REMISE-EMACS-08-09.md` ont remplacé. Rien ne dit lequel fait foi.

### Manques

- **Un simulateur des filtres org.** Récurrent, éprouvé, jamais rangé.
- **Un relevé du PDF composé** : débordements, remarques en marge, notes de bas
  de page, pages d'un flottant. Je le refais à la main à chaque fois.
- **Un contrôle de fraîcheur** : refuser de contrôler un build plus vieux que
  la source la plus récente. C'est la seule chose qui aurait évité le § 1.

---

## 4. Architecture cible

Un principe de rangement, et il tranche la moitié des cas : **`outils/` ne
porte que ce qui se relance.** Une passe d'écriture jouée une fois n'est pas un
outil, c'est une trace — elle va dans `OLD/patches/`, où quarante autres
l'attendent déjà. La convention existe ; elle n'était pas tenue.

```
outils/
  construire.py    assemble src/ vers build/                    (inchangé)
  controle.py      vérifie tout, et refuse un build périmé      (réécrit, découpé)
  controles/       une question par fichier, importés par controle.py
    citations.py   clés, fonds, non-régression
    structure.py   renvois, étiquettes, comptages, plan
    source.py      hygiène org, piles de mots-clés, blocs
    figures.py     légendes, textes de remplacement, tables
    glossaire.py   sigles, termes, index
    semantique.py  sondes, croisement grammaire/règles, axiome
  mesure.py        mesure la prose contre la charte             (ex-mesure_prose)
  pdf.py           relève ce que le PDF composé montre          (deborde + diagnostic)
  corpus.py        registre du fonds et classement par arc      (pdf_index + arcs)
  filtres.py       simule les filtres elisp hors Emacs          (nouveau)
```

Sept points d'entrée au lieu de vingt. Chacun répond à une question qu'on se
pose vraiment : *assemble*, *est-ce que ça tient*, *comment se porte la prose*,
*que montre le PDF*, *où en est le fonds*, *que produira mon export*.

### Conventions unifiées

**Nommage.** Un nom de fichier = un verbe ou un objet, en français, sans
suffixe. `_mine` disparaît : il ne voulait rien dire d'autre que « écrit par
Claude », ce qui est vrai de tout le dossier.

**Signature.** Tout outil s'appelle `python3 outils/<nom>.py [cible]`. La cible
par défaut n'est jamais un numéro figé : c'est **le dernier assemblage**, résolu
à l'exécution. Un numéro explicite reste accepté.

**Sortie.** Une ligne par contrôle, préfixée `ok` ou `ECHEC`, groupée sous un
titre entre crochets. C'est déjà la forme de `controle.py` ; elle devient la
règle pour tous.

**Erreurs.** Sortie `0` si tout passe, `1` si un contrôle échoue, `2` si l'outil
n'a pas pu s'exécuter — entrée absente, dépendance manquante. Aujourd'hui
`deborde.py` rend `2` pour un PDF absent, et c'est le bon comportement ; il est
seul à l'avoir.

**Fraîcheur.** `controle.py` compare la date du build à la source la plus
récente. Si le build est plus vieux, il **refuse de tourner** et le dit. Pas
d'avertissement qu'on apprend à ignorer : un refus.

**Journalisation.** Aucune. Ajouter un journal serait une abstraction
spéculative — la sortie console suffit, et le Makefile la capture déjà dans
`build/ECHECS-v*.txt`.

---

## 5. Ordre des opérations, du moins risqué au plus risqué

1. **Ranger.** Déplacer les sept passes closes vers `OLD/patches/`, supprimer
   les trois doublons déjà archivés et les trois scripts qui lisent `spec/`.
   *Réversible : tout est dans `OLD/`.*
2. **Périmer les livrables.** Une ligne en tête de chaque document remplacé,
   qui dit par quoi. *Sans risque.*
3. **Poser la fraîcheur.** Le refus de contrôler un build périmé, et la
   résolution du dernier assemblage. *Cinq lignes ; c'est le correctif qui a le
   meilleur rapport.*
4. **Réparer les deux doublons de contrôle.** Fusionner les deux contrôles de
   renvoi, retirer le `__main__` menteur de `croise.py`. *Le contrôle rouge
   d'aujourd'hui passe au vert pour la bonne raison.*
5. **Fusionner.** `croise` et `audit_org` dans `controle.py` ; `deborde` et
   `diagnostic-export.sh` dans `pdf.py` ; `pdf_index` et `arcs` dans
   `corpus.py`. *Renommages : le Makefile et le README suivent.*
6. **Découper `controle.py`.** Six modules sous `controles/`, `controle.py`
   devenant l'orchestrateur. *Le plus risqué : 936 lignes déplacées. Vérifié en
   comparant la sortie complète avant et après, ligne à ligne.*
7. **Écrire `filtres.py`.** Le seul ajout. *Neuf ; ne casse rien.*

### Ce que je supprime, et pourquoi

| Supprimé | Justification |
|---|---|
| `apply_v64_mine.py` | Lit `spec/`, disparu. Ne peut pas tourner. README le dit depuis le 28 août. |
| `controle_passe_mine.py` | Idem. Ancêtre de `controle.py`, qui fait tout ce qu'il faisait. |
| `decouper_mine.py` | Idem. Le découpage qu'il a opéré est le `src/` d'aujourd'hui. |
| `passe_annexes_mine.py` | Copie exacte d'un fichier de `OLD/archive/`. |
| `passe_documentaire_mine.py` | Idem. |
| `passe_latex_mine.py` | Idem. |
| `croise.py` (comme fichier) | Ses trois fonctions passent dans `controles/semantique.py`. Son `__main__` disparaît : il rendait un verdict faux. |
| `audit_org.py` (comme fichier) | Devient une section de `controle.py`. Rien n'est perdu ; le contrôle cesse d'être facultatif. |
| `diagnostic-export.sh` | Seul script shell, jamais relancé. Ce qu'il fait entre dans `pdf.py`. |

Déplacés, non supprimés : `passe_T42_mine.py`, `remap_cles_mine.py`,
`derouler.py`, `derouler_listes.py`, `style_org.py` — vers `OLD/patches/`.

**Ce que je ne touche pas.** `build/` et ses 238 Mo. Purger 270 assemblages est
une décision d'archivage qui t'appartient, pas une refonte d'outillage. Je la
signale ; je ne la prends pas.

### Risques de régression, et comment je les vérifie

| Risque | Vérification |
|---|---|
| Un contrôle perdu au découpage | Sortie complète de `controle.py` capturée avant, comparée après : même nombre de sections, mêmes libellés, mêmes verdicts |
| Un import cassé entre modules | La chaîne complète rejouée : `construire` puis `controle`, code de sortie attendu `0` |
| Le Makefile désaccordé des renommages | `make tout`, `make index`, `make carte` rejoués |
| Une passe archivée dont j'aurais eu besoin | Aucune ne tourne aujourd'hui sans écrire dans `src/` ; toutes restent dans `OLD/` |
| La fraîcheur bloquant un usage légitime | Un numéro explicite reste accepté, et le refus dit quoi lancer |

---

## 6. Ce que j'ai appris de nos échanges

Ces enseignements ne sont pas décoratifs : chacun a tranché un arbitrage
ci-dessus.

1. **Tu corriges le fond, pas la forme.** Sur des dizaines d'échanges, tes
   reprises portent sur ce que le document dit, jamais sur la façon dont mes
   scripts sont écrits. L'outillage est mon affaire — d'où ce document, et
   d'où le fait qu'il te demande de trancher l'archivage, pas le nommage.
2. **Tu veux la cause, pas le symptôme.** « La table 3.1 n'a pas de caption » a
   appelé le diagnostic de la pile de mots-clés rompue, pas un `\caption`
   ajouté à la main. C'est pourquoi la refonte pose un *refus* de contrôler un
   build périmé plutôt qu'un avertissement.
3. **Un contrôle vaut mieux qu'une correction.** À chaque défaut trouvé, tu as
   laissé passer — ou demandé — le contrôle qui l'empêche de revenir. C'est la
   raison pour laquelle `audit_org` cesse d'être un outil facultatif et devient
   une section obligatoire.
4. **Mesurer avant d'agir.** La charte de rédaction n'a tenu que parce qu'elle
   était chiffrée. J'ai donc audité en lançant les outils, pas en les lisant —
   et c'est ce qui a révélé le décrochage du § 1, qu'une lecture n'aurait jamais
   montré.
5. **Tu tolères une cible manquée, pas une cible maquillée.** Sur le neuvième
   décile de la charte, j'ai écrit que la cible n'était pas atteinte et
   pourquoi ; tu ne l'as pas contesté. D'où la franchise du § 1 sur onze jours
   de contrôles douteux.
6. **Le travail se fait par lots vérifiés.** Tu as choisi « un chapitre d'abord,
   pour valider ». L'ordre du § 5 va donc du rangement au découpage, chaque lot
   étant vérifiable seul.
7. **Ce qui est écrit une fois doit être trouvable.** Tu as perdu le traitement
   des `[rmq:]` en refondant ta configuration. Un savoir non rangé se perd —
   d'où `filtres.py`, qui est le seul ajout que je m'autorise.
8. **La convention prime sur la règle nouvelle.** `OLD/patches/` existait ; je
   n'en invente pas une autre. Le rangement consiste à tenir ce qui était déjà
   décidé.

---

## 7. Angles morts — ce que j'ai demandé, ce qui a été tranché

Trois points où mon jugement seul ne suffisait pas, et un aveu.

**L'aveu d'abord.** Je n'ai aucune mémoire de mes propres exécutions. Je
reconstruis mon usage par indices — mentions, dates, si ça tourne. Quand
j'écris « jamais employé », je peux me tromper sur un outil que tu lances
toi-même hors de nos séances.

### Arbitrages rendus le 8 septembre

**Usage réel — je peux me fier à mes indices.** Aucun outil n'est lancé hors
de nos séances. Le lot 1 s'exécute tel que décrit : six suppressions, cinq
déplacements.

**Le découpage se fait maintenant.** Le lot le plus risqué reste au programme.
Je le tiens sous une vérification stricte : la sortie complète de `controle.py`
est capturée avant, puis comparée après, section par section et verdict par
verdict. Une section manquante ou un libellé changé arrête le lot.

**`build/` : les dix derniers, le reste archivé.** Cela ajoute un huitième lot,
et il change une chose au § 4 : les assemblages sont reproductibles depuis
`src/`, leur valeur est celle d'un instantané et non d'une source. Rien n'est
effacé — `OLD/build-avant-8-septembre/` les recueille. Le numérotage, lui, reste
en l'état : c'est la résolution du *dernier* assemblage, posée au lot 3, qui
retire au numéro son rôle de repère. Écraser un ancien assemblage redevient
possible mais cesse d'être une conséquence.

### Le plan, dans sa forme arbitrée — **exécuté le 8 septembre**

1. Ranger — six suppressions, cinq déplacements vers `OLD/patches/`.
2. Périmer les livrables remplacés.
3. Poser la fraîcheur et la résolution du dernier assemblage.
4. Réparer les deux doublons de contrôle.
5. Fusionner — `croise` et `audit_org` dans `controle.py` ; `deborde` et
   `diagnostic-export.sh` dans `pdf.py` ; `pdf_index` et `arcs` dans
   `corpus.py`.
6. Découper `controle.py` en six modules sous `controles/`.
7. Écrire `filtres.py`.
8. Archiver `build/` sauf les dix derniers assemblages.

---

## 8. Inventaire avant / après

| | avant | après |
|---|---|---|
| fichiers dans `outils/` | 20 | 14 (6 points d'entrée + `controles/`) |
| lignes | 3 762 | 2 980 |
| plus gros fichier | 936 (`controle.py`) | 432 (`controles/source.py`) |
| points d'entrée | 20, dont 11 morts ou joués | 6, tous éprouvés |
| `build/` | 238 Mo, 769 fichiers | 6,3 Mo, 40 fichiers |
| contrôles | 24 sections dans un fichier | 25 sections dans 6 modules |

| Outil | Devenu |
|---|---|
| `construire.py` | inchangé |
| `controle.py` | orchestrateur, 180 lignes ; refuse un assemblage périmé |
| `croise.py` | `controles/croise.py`, sans son `__main__` |
| `audit_org.py` | `controles/source.py` → `hygiene_org`, **plus facultatif** |
| `mesure_prose.py` | `mesure.py` |
| `deborde.py` + `diagnostic-export.sh` | `pdf.py` — voir l'écart n° 2 |
| `pdf_index.py` + `arcs.py` | `corpus.py` |
| — | `filtres.py`, le seul ajout |
| 11 passes closes et doublons | `OLD/patches/`, `OLD/doublons-outils-8-septembre/` |

Les six points d'entrée, avec leur comportement en cas d'échec :

| Commande | Répond à | 0 | 1 | 2 |
|---|---|---|---|---|
| `make construire` | assemble `src/` vers `build/` | assemblé | — | source absente |
| `make controle` | est-ce que ça tient ? | tout passe | un contrôle échoue | assemblage absent ou périmé |
| `make mesure` | comment se porte la prose ? | mesuré | — | charte absente |
| `make pdf` | que montre le PDF composé ? | sain | débordement, auxiliaire corrompu | PDF absent |
| `make corpus` | où en est le fonds ? | écrit | — | export Zotero absent |
| `make filtres` | que produira l'export org ? | essais passés | un essai échoue | source absente |

---

## 9. Journal de décisions

**Le contexte plutôt que les paramètres.** Chaque contrôle reçoit un `ctx`
unique et en dépaquette tout, y compris ce dont il ne se sert pas. *Alternative
écartée :* des signatures explicites, une par contrôle. *Compromis :* le
dépaquetage est bavard, mais un oubli lève un `NameError` au premier lancement
— bruyant, jamais silencieux. C'est ce qui a rattrapé la Pagination.

**Le découpage sur les bannières, non sur les `print`.** Le premier découpage
coupait à la ligne `print("\n[Section]")`. Pagination calcule avant d'imprimer :
son calcul est resté dans la section précédente et le `NameError` est tombé au
premier essai. *Compromis :* les bannières `# ── … ──` deviennent une
convention structurante, à tenir pour toute section nouvelle.

**Un refus, pas un avertissement.** `controle.py` sort en 2 sur un assemblage
périmé. *Alternative écartée :* imprimer un avertissement et continuer.
*Compromis :* un refus peut gêner un usage légitime — un numéro explicite reste
accepté, et le message dit quoi lancer. Un avertissement, lui, s'apprend à
ignorer, et c'est précisément ce qui a permis onze jours de contrôles douteux.

**Le dernier assemblage plutôt que le plus grand numéro.** `v335` date du
2 septembre, `v230` du 28 août : le numéro n'est ni le temps ni un compteur.
*Alternative écartée :* passer à un horodatage, ce que tu avais proposé en
troisième option. *Compromis :* le numéro reste ambigu et un assemblage ancien
peut encore être écrasé — c'est arrivé pendant l'audit — mais plus aucun outil
ne s'en sert comme repère, donc l'ambiguïté n'a plus de conséquence. Changer le
schéma aurait touché `construire.py`, le Makefile et 271 fichiers pour un gain
devenu nul.

**`outils/` ne porte que ce qui se relance.** C'est le principe qui tranche la
moitié des cas. *Compromis :* la frontière demande un jugement pour une passe
qu'on croit rejouable. La règle de départage : si elle écrit dans `src/`, c'est
une passe, elle va dans `OLD/patches/`.

**Le simulateur de filtres reste un banc d'essai, non une seconde implantation.**
*Alternative écartée :* engendrer l'elisp depuis le Python, pour n'avoir qu'une
source. *Compromis :* les deux peuvent diverger, et l'en-tête du fichier le dit
en toutes lettres. Engendrer aurait été une abstraction spéculative pour deux
filtres.

---

## 10. Trois écarts au plan, et pourquoi

**1. Rien n'a pu être supprimé.** L'espace de travail refuse `rm` :
*Operation not permitted*. Les six suppressions sont devenues des déplacements
vers `OLD/doublons-outils-8-septembre/`. Les six fichiers y sont des doublons
exacts de `OLD/archive/` — vérifié par `diff` avant de bouger. **Un seul geste
te reste, si tu veux vraiment les effacer : supprimer ce dossier.**

**2. `diagnostic-export.sh` archivé, non fusionné.** Le plan disait de le
fondre dans `pdf.py`. À l'exécution, les deux ne répondent pas à la même
question : l'un demande *pourquoi l'export se bloque* et a besoin d'Emacs,
l'autre *ce que le PDF composé montre* et a besoin d'un PDF. Les fusionner
aurait été forcer. Il a été écrit pour un blocage du 4 septembre, résolu depuis,
et le blocage d'aujourd'hui avait une tout autre cause qu'il n'aurait pas
trouvée. Il est dans `OLD/patches/`.

**3. L'ordre des sections a changé.** Conséquence du regroupement thématique.
Vérifié : 24 sections avant, 24 après, mêmes libellés, mêmes verdicts, aucune
perdue, aucune apparue. La référence est dans
`REFERENCE-controle-avant-decoupage.txt`.

Et un piège rencontré, qui n'était pas au plan : **`audit_org.py` était un
script, non une bibliothèque** — son corps s'exécutait à l'import. La première
fusion produisait un module qui auditait dès qu'on l'importait, et appelait une
fonction inexistante. Repris en enveloppant le corps dans une fonction.
