# Ce qui a changé depuis la relecture du 8 septembre

9 septembre 2026, au soir. À joindre à la prochaine relecture, ou à garder pour
lire ce qu'elle rendra.

**État : tous les contrôles passent, trente-six désormais.** Trois entrées
restent ouvertes, et trois seulement.

---

## Comment lire la prochaine relecture

**Elle repartira du document imprimé, et les numéros auront bougé.** Quarante-quatre
théorèmes sur cinquante-et-un ont changé de numéro, du seul fait d'avoir remonté
un théorème de l'annexe au chapitre 2. Celui qui était le 33 est le 1.

`meta/correspondance-theoremes.org` porte les deux colonnes et se régénère par
`python3 outils/correspondance.py`. **À joindre au manuscrit envoyé**, faute de
quoi la relecture citera des numéros qu'on mettra une heure à retrouver.

---

## Les quatre défauts de fond, et ce qu'ils sont devenus

| | Ce que la relecture disait | État |
|---|---|---|
| La structure de co-Kleisli graduée n'est pas une catégorie | erreur formelle nue | **corrigée** — structure de Kleisli graduée, avec les deux grades qui portent une vraie catégorie |
| ℛ était à la fois ℚ≥0 ∪ {ω} et ℕ∞ | porteurs confondus | **corrigée** — et la clause de bonne formation sur les tailles est écrite |
| Le hachage « sans collision » en O(1) | trois erreurs en une phrase | **corrigées** toutes les trois, plus la quatrième au chapitre 6 |
| Le graphe statique ne borne pas le graphe d'attente | invariant manquant | **partiellement** — le manuscrit faisait déjà la distinction ; la simulation manquante est nommée, non démontrée |

**Le dernier est le seul qui reste ouvert au fond**, et il l'est honnêtement :
le texte porte « s'il tient / s'il tombe », et l'étape de préservation que la
coinduction demande est désormais écrite comme ce qui manque.

---

## Ce qui a été distillé

Sept objets formels remplacent une vingtaine de démonstrations et de
paragraphes. C'est la partie où le document devrait se lire différemment.

- **Compatibilité de l'action graduée** — remontée au chapitre 2. Les quatre
  annonces de comptage — « pour la deuxième fois », « une troisième fois »,
  « pour la quatrième fois » — ont disparu.
- **Schéma de commutation**, **schéma de préservation par traduction**, **tri
  topologique**, **lemme de capacité** — une section neuve au chapitre 2, et six
  théorèmes qui les instancient au lieu de refaire l'argument.
- **Théorème d'élaboration** — les six formes de surface du chapitre 5 tiennent
  en un tableau de six lignes, et la staticité de la syntaxe en est un
  corollaire.
- **Garantie par inexpressibilité** — définie une fois au chapitre 1, trois
  redéveloppements réduits à des renvois.

Et deux factorisations que les deux relectures demandaient : **terminaison et
productivité sont écrites comme les deux instances qu'elles sont**, la
substitution simultanée est un corollaire de la substitution élémentaire.

---

## Ce qui a été normalisé

- **18 occurrences** de `□_r` unifiées vers `!_r`. Le carré est libre pour le
  temps. *(Les deux relecteurs recommandaient l'inverse l'un de l'autre ; le
  motif de l'arbitrage est écrit au chapitre 1.)*
- Les trois `Γ ⊢` corrigés, le quatrième conservé avec l'incise qui dit que
  c'est l'objet catégorique.
- `⊑_{<:}` devient `≼`, visuellement disjoint de `⊑`.
- L'ensemble d'échappatoires devient `𝒳`.
- `fold` désignait deux constructions ; le parcours de vecteur est `iter_V`.
- **Une table normative des symboles** au chapitre 1 — normative, non
  descriptive : aucune section ne peut introduire de variante locale.
- La nomenclature des statuts passe de quatre à **sept mots**.

---

## Ce qui a été décidé et écrit

**A1** — la duale de ◇ existe, sous le nom `■`, et `When` porte sa contrainte de
report. Le coût est inscrit : la grammaire gagne un connecteur, la condition de
clôture est tenue parce que `■` se projette sur Δ, et le document ne prétend pas
qu'elle se dérive.

**B** — `να.C` est habité. Deux formes de terme, deux règles sur copatrons
dimensionnés, l'anamorphisme dérivé. L'argument est interne : le théorème de
progression présupposait déjà l'indice de taille du côté coinductif.

**C3** — vingt-neuf légendes qui ne s'imprimaient pas. Dix-neuf sont devenues
une famille **Formule**, numérotée et listée ; dix ont été retirées, un théorème
étant déjà un objet numéroté qui porte son nom.

**Doctrine E** — tout engagement nomme sa route : littérature, démonstration ou
mesure. En l'appliquant, on a trouvé que **la table s'accusait d'une dette
qu'elle avait payée** — la fidélité de l'interpréteur est démontrée à l'annexe,
et la table l'ignorait.

**G-01, G-05, G-06** — instruits, rendus, intégrés. Les deux paris portent
désormais leur protocole de mesure ; la borne mémoire est requalifiée comme
relative à un profil ; le registre empirique a enfin un fichier.

**F, route 4** — conduit, verdict F4-3. Deux acquis : l'extension probabiliste
ne demande aucun connecteur, et **le risque différentiel vient de la liberté de
l'exponentielle, non de l'additivité** — ce qui corrige le chapitre 2 dans le
sens de la robustesse. Une question reste, et elle est versée comme telle.

---

## Les six contrôles neufs

Ils gardent ce qui vient d'être fait, et l'un d'eux m'a rattrapé le jour même.

| | Contrôle | Ce qu'il refuse |
|---|---|---|
| 1 | `contexte_du_jugement` | `Γ ⊢` hors du chapitre 2 |
| 2 | `un_glyphe_par_modalite` | tout carré indicé |
| 3 | `affirmations_sur_le_hachage` | « sans collision », « injectif » près d'un hachage |
| 4 | `grades_et_tailles_distingues` | ℛ identifié aux conaturels sans restriction |
| 5 | `symboles_a_la_table_normative` | un symbole gouverné absent de la table |
| 6 | `route_de_chaque_engagement` | un engagement sans route, ou une quatrième route |
| 7 | `familles_de_flottants_listees` | une famille déclarée dont la liste n'est jamais imprimée |

**Le septième a servi tout de suite** : j'avais déclaré la famille des formules,
écrit son message de repli, défini sa commande — et jamais appelé la liste.

---

## Ce qui reste ouvert, et c'est tout

1. **T-68** — la sélection des mots pour les trente-quatre primitives en cours.
   À ta main.
2. **QF-21** — les cônes intégrables portent-ils une exponentielle graduée sur
   ℛ ? Versée aux questions avec son critère de réouverture, et sans urgence :
   l'inférence probabiliste est hors périmètre.
3. **L'enrichissement sur les préordres**, part excédant l'ordre des fibres. Le
   seul engagement ouvert, démontrable, et sans théorème assigné. La doctrine E
   le rend visible ; c'est le candidat naturel au prochain travail de fond.

---

## Deux choses que je surveillerais dans la prochaine relecture

**Si elle relève à nouveau la structure de Kleisli, le hachage ou ℛ**, c'est que
la correction n'a pas porté, et il faudra regarder pourquoi — le contrôle passe,
donc ce serait une seconde occurrence ailleurs.

**Si elle ne relève rien de neuf sur la factorisation**, c'est le meilleur signe
possible : les sept objets formels auront fait leur travail. Si elle en demande
d'autres, la question à se poser est celle que la relecture précédente posait
bien — *quel objet formel aurait permis de ne jamais écrire ces paragraphes ?*
