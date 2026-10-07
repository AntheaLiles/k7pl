# PR-02 — plan de traitement

> État au 30 septembre 2026. Les décisions D-1 (voie 2 : formaliser la couche 2) et D-3 (position intermédiaire, `ℰ_alg` / `ℰ_scoped`) ont depuis été tranchées ; l'avancement à jour est dans le [tableau de bord](../tracking/TABLEAU-DE-BORD.md).

30 septembre 2026. Six relectures, un méta-relecteur, trois études annexes,
**127 fiches**. Ce document ne refait pas leur travail : il dit dans quel ordre
le prendre, ce qui te revient, et ce que je peux conduire seul.

---

## 0. Ce que je dois dire avant tout le reste

**Deux des corrections que j'ai écrites le 9 septembre sont mises en cause, et
les relecteurs ont raison sur les deux.** Je l'ai vérifié à la source avant
d'écrire ce plan.

### BLOQ-03 — j'ai promu au chapitre 2 un théorème faux au grade ω

La loi de compatibilité de l'action graduée, que j'ai remontée de l'annexe au
chapitre 2 pour qu'elle serve de fondation, **est fausse au grade ω** sous la
définition que le même chapitre donne de ⊖.

Le chapitre 2 définit ⊖ comme *le résidu de l'addition, le plus petit x tel que
k + x ≥ β*. Sous cette définition, **ω ⊖ ω = 0**, puisque ω + 0 ≥ ω. Alors pour
β = 5, k = 3, u = ω :

- membre gauche : ω · (5 ⊖ 3) = ω · 2 = **ω**
- membre droit : (ω·5) ⊖ (ω·3) = ω ⊖ ω = **0**

L'annexe conduisait le calcul en supposant silencieusement ω ⊖ ω = ω. En
remontant le théorème sans vérifier le cas ω, **j'ai donné une place de
fondation à un énoncé faux**, et six démonstrations l'invoquent nommément.

La correction recommandée est bonne et légère : définir ⊖ comme la soustraction
tronquée prolongée en ω, écrire explicitement que *ce n'est pas le résidu*, et
la loi devient vraie sans restriction. Ce que j'aurais dû faire, c'est vérifier
le cas absorbant avant de déplacer.

### BLOQ-06 — ma clause de taille interdit ce que la couche 2 doit porter

J'ai écrit que tout indice de taille est pris dans **ℕ∞ ∖ {ω}**, et je l'ai
appliquée aux deux polarités. Les règles `Out` et `Cop` que j'ai écrites la
citent.

Conséquence, vérifiée : de `να.C⟨i+1⟩` on tire `C[να.C⟨i⟩/α]`, donc un flux
initialisé à i = n rend au plus n observations et atteint `να.C⟨0⟩` où `Out`
n'est plus instanciable. **Aucun processus non terminé n'est typable** — alors
que c'est exactement ce que la couche 2 existe pour porter.

Pire, l'argument que j'ai avancé est un mésusage de sa source. J'ai cité le
ticket Agda en concluant qu'il fallait exclure ω. **Le ticket incrimine le
partage d'une sorte de taille entre les deux polarités**, non l'existence d'un
plus grand élément du côté coinductif — et son titre le dit : *un type qui est à
la fois inductif et coinductif*. J'ai cité correctement et conclu de travers.

La correction est une distinction, non un mécanisme : deux sortes de tailles,
𝕊_μ = ℕ∞ ∖ {ω} bien fondée pour le côté inductif, 𝕊_ν = ℕ∞ avec un plus grand
élément absorbant pour le côté coinductif, et **aucun type ne porte les deux** —
ce qui est la leçon exacte du ticket.

### Ce que j'en retiens pour la suite

Mes trente-six contrôles vérifient la cohérence interne. **Aucun ne vérifie
qu'une algèbre se comporte à ses éléments absorbants**, ni qu'une clause de
bonne formation laisse habitable ce qu'elle gouverne. C'est la classe de défaut
que cette campagne trouve et que le harnais ne trouvera jamais seul ; le lot
d'outillage ci-dessous en tient compte.

---

## 1. Ce que la campagne vaut, et ce qu'elle ne demande pas

**Le méta-relecteur a déjà fait le travail de planification.** Son document
porte les 127 fiches, un graphe de dépendances, six vagues, sept arbitrages et
une table de couverture qui rattache chaque point de chaque rapport. Il a en
outre vérifié ses arbitrages sur le PDF et déplacé deux cibles de correction.

**Je ne le refais pas.** Ce plan s'y adosse et ajoute ce qu'il ne pouvait pas
avoir : l'état du dépôt, ce que l'outillage peut garder, et la distinction entre
ce qui demande ta décision et ce qui demande seulement du travail.

**Quinze points sont relevés par au moins trois relecteurs indépendamment.**
C'est le signal le plus fort de la campagne, et c'est l'ordre auquel se fier
quand deux fiches se disputent la priorité.

---

## 2. Les quatre décisions qui te reviennent, par ordre d'effet

Elles ne sont pas de même poids. La première change la **taille** du travail ;
les trois autres n'en changent que la forme.

### D-1 — Le périmètre du noyau formel *(ARB-PR-05, puis BLOQ-01)*

**C'est la seule décision qui change l'ampleur de tout le reste : une page
contre quarante.**

Le constat qui l'ouvre est sévère et convergent : *le noyau formel est
séquentiel — la couche 2 n'a ni règles, ni constructeurs, ni types habitables*.
Les acteurs, les sessions et la concurrence sont décrits au corps du texte et
absents de l'appareil.

Deux voies, et le dossier contient déjà les deux :

| | Voie | Ce qu'elle coûte | Ce qu'elle rend |
|---|---|---|---|
| **1** | **Requalifier** — le noyau formel est séquentiel, et le document le dit. La concurrence devient une extension déclarée, non formalisée. | une page, plus la requalification en chaîne de neuf théorèmes | le document redevient exact ; la thèse de sédimentation perd un étage |
| **2** | **Formaliser** — écrire les règles, les constructeurs et les théorèmes de la couche 2. | le programme de concurrence du dossier chiffre l'opération | la thèse tient entière |

**Mon avis, et il n'engage que la méthode.** La voie 1 n'est pas un repli : elle
rend le document vrai immédiatement, et elle ne ferme pas la voie 2, qui
devient un travail daté plutôt qu'une dette masquée. La voie 2 conduite sous
pression produirait un appareil dont la relecture suivante dirait qu'il n'est
pas démontré — ce que cette campagne vient précisément de reprocher à neuf
théorèmes.

### D-2 — Le socle : famille modale et graduée, ou homotopique *(ARB-PR-07)*

**L'étude d'opportunité y répond déjà, et il te reste à ratifier.** Verdict :
fausse bonne idée sur le tout, quatre obstacles dont trois de fond — l'univalence
rend inexprimable ce que trois théorèmes doivent prouver, le transport a un coût
que P3 interdit de dissimuler, l'assistant de preuve visé est structurellement
incompatible, et aucune brique n'offre le semi-anneau agissant sur le contexte
qui est le cœur du langage.

Mais **quatre imports ciblés sont rentables**, et deux seulement appartiennent à
HoTT au sens strict : la théorie de modes *(déjà citée par le manuscrit)*, calf
et decalf pour la distinction de phase et le coût, la théorie des types graduée
formalisée, et la récursion gardée multi-horloges — **celle-là répond
directement à BLOQ-06**, ma clause de taille.

Ratifier revient à écrire : pas de socle homotopique, quatre emprunts nommés.

### D-3 — Le traitement des effets à portée *(ARB-PR-03)*

Cinq relecteurs sur six relèvent que le monoïde ℳ est **une pièce nouvelle** que
la composante d'effet n'absorbe pas — ce qui met en jeu la condition de clôture.
J'avais traité le symptôme le 9 septembre en supprimant la fausse piste ; la
cause reste.

### D-4 — Le statut du rejeu bit-à-bit *(ARB-PR-04)*

J'ai scindé le théorème en logique et binaire sous hypothèse. Les relecteurs
disent l'hypothèse **insuffisante ou tardive**. La décision porte sur ce que le
document promet, pas sur la forme.

---

## 3. Le séquencement, et qui fait quoi

Je reprends les vagues du méta-relecteur, en marquant ce qui ne demande que du
travail et ce qui demande une décision.

| Vague | Contenu | Demande |
|---|---|---|
| **0** | Sceau de statut à deux axes, registre des obligations, table des symboles étendue, comptes produits par l'outil, le glyphe manquant de `When` | **travail seul** — et le sceau de statut « révèle 18 résultats acquis que le document ignore posséder » |
| **1** | Fondations algébriques : ℛ unifié, ⊖ redéfini, **BLOQ-03**, **BLOQ-06** | travail seul, sauf **D-2** pour l'emprunt multi-horloges |
| **2** | Périmètre du noyau | **D-1 d'abord**, tout le reste en dépend |
| **3** | Remontées, sémantique primitive, ordre de préservation | travail seul, après D-1 |
| **4** | Dettes de preuve et factorisations | travail, long |
| **5** | Réécriture des énoncés | travail, en dernier — les énoncés ne se stabilisent qu'ici |

**La vague 0 commence maintenant et ne dépend de rien.** Le méta-relecteur la
qualifie de typographique ; elle porte pourtant la correction au meilleur
rapport de toute la campagne, parce qu'on ne peut pas corriger ce dont on ne
sait pas le statut.

**Deux exceptions à l'ordre, et je les prends immédiatement :** BLOQ-03 et
BLOQ-06 sont mes erreurs, elles sont en vague 1, et je ne veux pas les laisser
courir pendant qu'on décide du périmètre. Elles sont indépendantes de D-1.

---

## 4. Ce que l'outillage doit apprendre

Six contrôles nouveaux, dérivés de ce que la campagne a trouvé et que le harnais
n'a pas vu. Chacun garde une classe de défaut, pas une occurrence.

| | Contrôle | La classe qu'il ferme |
|---|---|---|
| 1 | **éléments absorbants** — toute loi algébrique énoncée « pour tout grade » est vérifiée numériquement en 0 et en ω | BLOQ-03, et les quatre égalités de ℕ∞ que le document n'écrit nulle part |
| 2 | **habitabilité sous clause** — toute clause de bonne formation sur un indice laisse le connecteur qu'elle gouverne habitable à l'infini quand sa polarité l'exige | BLOQ-06 |
| 3 | **sceau de statut** — tout énoncé porte sa nature épistémique et son niveau ; aucun n'emprunte l'environnement d'un autre | TRANS-01, et les 11 faux théorèmes |
| 4 | **un symbole, un objet** — la table normative devient exécutable, collisions comprises | NOTA-01 |
| 5 | **comptes produits, jamais écrits** — les effectifs de règles, de constructeurs et de théorèmes sont engendrés, non saisis | NOTA-03 |
| 6 | **hypothèse déclarée avant emploi** — un théorème cité comme acquis l'est là où il est démontré | PORT-16, PREUVE-02 |

Le premier aurait attrapé BLOQ-03 le jour même. **C'est celui que j'écris en
premier**, avant de corriger quoi que ce soit, pour que la correction soit
vérifiée par autre chose que moi.

---

## 5. Ce que je propose de faire dès maintenant

Sans attendre aucune décision, et dans cet ordre :

1. **Écrire le contrôle des éléments absorbants**, et le faire échouer sur ⊖.
2. **Corriger BLOQ-03** — redéfinir ⊖ comme soustraction tronquée prolongée,
   écrire que ce n'est pas le résidu, et isoler la distributivité en lemme nommé
   avec les quatre égalités de ℕ∞ écrites une fois.
3. **Corriger BLOQ-06** — deux sortes de tailles, la clause d'Agda requalifiée
   en *aucun type ne porte les deux*, et le théorème de progression réénoncé
   comme schéma à deux instances de sortes plutôt qu'un ordre lu deux fois.
4. **Écrire le contrôle d'habitabilité**, qui garde le 3.
5. **Conduire la vague 0** en entier.

Puis m'arrêter, et attendre **D-1**.

---

## 6. Ce que je surveillerai

**Le risque de cette campagne n'est pas de mal corriger, c'est de tout
corriger.** Cent vingt-sept fiches invitent à une passe exhaustive qui
occuperait des semaines et produirait un document plus lourd.

Trois garde-fous, et je les tiendrai :

- **Ce qui est relevé par un seul relecteur attend.** Quinze points convergent à
  trois voix ou plus ; ils passent devant, toujours.
- **Le lot des factorisations refusées se documente, il ne s'exécute pas.** Le
  méta-relecteur a isolé sept fusions tentantes et fausses ; les écrire comme
  refusées, avec leur motif, vaut mieux que de les faire.
- **Un énoncé affaibli au bon moment coûte moins qu'un théorème démontré trop
  tôt.** C'est la leçon des neuf requalifications qui pendent à D-1.
