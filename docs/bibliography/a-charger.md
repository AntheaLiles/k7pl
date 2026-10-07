# À CHARGER — solde au 3 septembre 2026

> **Dix-sept des vingt DOI de cette liste sont désormais au fonds.** Ce qui suit est le solde,
> revérifié le 3 septembre au soir contre `refs-pour-citations.bib`. Le reste du fichier est
> conservé pour sa trace : chaque entrée y porte le motif de sa demande.

## Le solde — trois DOI

| DOI | Pièce | Pour quoi |
|---|---|---|
| `10.1007/978-3-662-44202-9_20` | *Name-fix : avoiding and hygienic program transformations*, ECOOP 2014 | l'hygiène des transformations, A.2.1 |
| `10.1145/2594291.2594319` | *Lifting evaluation sequences through syntactic sugar*, PLDI 2014 | le resucrage, A.2.1 |
| `10.1145/987298.987299` | Griswold, *Suggested revisions and additions to the syntax and control mechanisms of SNOBOL4*, 1974 | un langage qui révise sa syntaxe après adoption, par son auteur |

**Aucune des trois ne bloque quoi que ce soit** — le manuscrit est stabilisé sans elles, et ce sont
des appuis souhaitables, non des dettes.

**Les deux qui portaient une réserve sont arrivées, et la réserve était justifiée dans sa forme.**
Girard, *Linear logic*, et Milner–Parrow–Walker, *A calculus of mobile processes*, figuraient ici
avec des DOI reconstitués de mémoire et signalés comme tels. Les deux pièces sont au fonds, et les
deux identifiants s'y retrouvent. Cela ne valide pas la reconstitution de mémoire : cela montre
seulement qu'écrire la réserve à côté de l'identifiant a permis de la lever par une vérification
plutôt que de la propager en silence.

---

# À charger dans Zotero — T-68, 10 août 2026

Deux listes, deux gestes différents. **La seconde est la plus importante.**

---

## A · Entrées DÉJÀ dans Zotero — il manque seulement le PDF

Rien à créer. Ouvrir l'entrée, « Find Available PDF » ou glisser le fichier.

| clé Zotero | identifiant |
|---|---|
| `wadlerPropositionsSessions2012` | `10.1145/2364527.2364568` |
| `bentonLinearLcalculusCategorical1993` | `10.1007/3-540-56992-8_6` |
| `fournetJoinCalculusLanguage2002` | `10.1007/3-540-45699-6_6` |
| `lindleyTalkingBananasStructural2016` | `10.1145/2951913.2951921` |
| `leijenTypeDirectedCompilation2017` | `10.1145/3009837.3009872` |
| `curienIntroductionLinearLogic2005` | `arXiv:cs/0501039` |
| `arntzenius2025FiniteFunctionalProgramming` | `10.1007/978-981-92-0184-6_1` |
| `erikssonGradedModalType2025` | `https://hdl.handle.net/2077/86472` |
| `speightImpredicativeEncodingsLinear2025` | *sans DOI dans l'entrée* — chercher par titre |
| `piercePictProgrammingLanguage1997` | *sans DOI dans l'entrée* — chercher par titre |
| `longMutationLocalExplicit2026` | *sans DOI dans l'entrée* — chercher par titre |

**Priorité dans cette liste : Wadler, Benton, Fournet.** Benton est la source de l'adjonction LNL dont dépend tout le chapitre 2, et le projet l'a citée sans jamais l'ouvrir.

---

## B · Entrées ABSENTES du fonds — et ce sont des fondations

Le constat qui motive cette liste : **le fonds est riche en travaux récents et lui manquent cinq de ses propres fondations.** C'est ce qui explique que plusieurs questions R aient rebondi — je lisais des articles qui *citent* la réponse au lieu d'articles qui la *donnent*.

### B.1 — Levy, et c'est le manque le plus grave

Le chapitre 1 écrit « **K7PL retient l'appel par poussée de valeur** ». **Il n'y a aucun Levy au fonds.**

- Paul Blain Levy, *Call-by-Push-Value: A Subsuming Paradigm*, TLCA 1999 — DOI probable `10.1007/3-540-48959-2_17` *(à vérifier)*
- Paul Blain Levy, *Call-By-Push-Value: A Functional/Imperative Synthesis*, Springer, Semantics Structures in Computation vol. 2, 2003 — ISBN probable `978-1-4020-1730-8` *(à vérifier)*

> Chercher plutôt par titre exact : Zotero résout mieux, et je ne veux pas te faire importer un identifiant approximatif.

### B.2 — Plotkin et Pretnar, les gestionnaires

R-7 demande « le gestionnaire a-t-il un terme ? ». Le chapitre 1 écrit « chaque gestionnaire est un morphisme d'algèbres ». **Aucun Plotkin, aucun Pretnar au fonds.**

- Gordon Plotkin, Matija Pretnar, *Handlers of Algebraic Effects*, ESOP 2009 — DOI probable `10.1007/978-3-642-00590-9_7` *(à vérifier)*
- Gordon Plotkin, John Power, *Adequacy for Algebraic Effects*, FoSSaCS 2001 *(chercher par titre)*

### B.3 — Girard, la logique linéaire

- Jean-Yves Girard, *Linear Logic*, Theoretical Computer Science 50(1), 1987, p. 1–101 — DOI `10.1016/0304-3975(87)90045-4`

Et, si tu veux la source de LU que van den Heuvel cite pour ULL :

- Jean-Yves Girard, *On the Unity of Logic*, Annals of Pure and Applied Logic 59(3), 1993 *(chercher par titre)*

### B.4 — Pruiksma, la logique adjointe

Grass la nomme comme l'un des trois systèmes qu'il subsume, avec LNL et mGL. Elle est le chaînon entre les deux zones de Vollmer et la zone unique de K7PL.

- Klaas Pruiksma, William Chargin, Frank Pfenning, Jason Reed, *Adjoint Logic* — rapport technique CMU, 2018 *(chercher par titre)*

### B.5 — Milner, le π-calcul

Le chapitre 1 pose `K7PL = (λ-linéaire) ⊂ (π-calcul + Join Patterns)`. **Aucun Milner au fonds.**

- Robin Milner, Joachim Parrow, David Walker, *A Calculus of Mobile Processes, Part I*, Information and Computation 100(1), 1992 — DOI probable `10.1016/0890-5401(92)90008-4` *(à vérifier)*

### B.6 — Curien, Part I

Le fonds a le Part II, qui porte sur les réseaux de preuve et la ludique. **Les règles d'introduction et d'élimination sont dans le Part I.**

- Pierre-Louis Curien, *Introduction to Linear Logic and Ludics, Part I* — sur arXiv, chercher par titre *(je ne veux pas te donner un identifiant arXiv de mémoire)*

---

## Ce que ces neuf ajouts débloquent

| ref | question |
|---|---|
| Levy | **R-1** — la grammaire CBPV de référence, et l'arbitrage `dCBPV−` / `dCBPV+` |
| Plotkin-Pretnar | **R-7** — `perform` et `handle` comme termes |
| Girard | **R-3** — les règles de tous les connecteurs, à la source |
| Pruiksma | **R-22** — le chaînon entre une zone et deux |
| Milner | **R-19** — les primitives du π-calcul, à la source |
| Curien I | **R-3** — la présentation pédagogique des mêmes règles |
| Wadler | **R-18** — fonder la correspondance au lieu de l'emprunter |
| Benton | **R-23** — l'adjonction dont `!` se décompose |
| Fournet | **R-19** — les motifs de jonction par leur auteur |

---

## Note de méthode, à corriger dans Zotero au passage

`cervesatoLogicalMeetingPoint2004` porte, dans son champ `abstract`, **le résumé d'un autre article** — celui de Das et Pfenning sur les types de session temporels. Rien à voir avec son contenu réel.

Conséquence : l'entrée est **invisible à toute recherche par mots-clés du résumé**, et c'est exactement pourquoi la table de traçabilité ne l'avait pas relevée.

---

# Lot arc H — 28 août

## C — Références à ajouter à Zotero, livrées en DOI

Elles sortent du dépouillement de l'arc H et servent la jonction **T-68 × question 30** : si tout ce
qui est au-dessus des vingt constructeurs est une macro, alors toute erreur que l'utilisateur
rencontre sort d'une expansion, et le vérificateur parle du noyau quand le programmeur a écrit de la
bibliothèque. Ces trois pièces traitent exactement ce point.

| # | référence | identifiant | ce qu'elle débloque |
|---|---|---|---|
| 1 | Pombrio & Krishnamurthi, *Hygienic Resugaring of Compositional Desugaring*, ICFP 2015 | `10.1145/2784731.2784755` | **déjà au corpus RDF** — à faire passer au fonds si la citation est retenue. Donne **R-51** (la compositionnalité comme condition du rapport d'erreur de surface) et **R-52** (la portée de `thm:hygiene`) |
| 2 | Pombrio & Krishnamurthi, *Resugaring: lifting evaluation sequences through syntactic sugar*, PLDI 2014 | `10.1145/2594291.2594319` | l'article fondateur, **absent du corpus**. C'est lui qui pose le problème dans sa forme générale |
| 3 | Erdweg, van der Storm & Dai, *Capture-Avoiding and Hygienic Program Transformations* (name-fix), ECOOP 2014 | `10.1007/978-3-662-44202-9_20` | **absent du corpus**. L'approche alternative : réparer la capture *après* coup plutôt que l'éviter — la seule qui n'exige rien du macro-écrivain |

## D — Entrées du fonds dépouillées ce jour, non encore citées

Portées au registre des décisions, à revoir à la passe de répercussions (tâche 81).

| clé | ce qu'elle rend |
|---|---|
| `hickeyHistoryClojure2020` | **QH-14 tranchée** (l'obstacle à l'adoption est le déploiement, non la syntaxe) ; l'argument du refus des macros de lecture pour l'arbitrage 15 ; le regret des transducteurs pour QH-1 |
| `macqueenHistoryStandardML2020` | le langage *Bare* comme précédent de T-68, **et son coût** — la syntaxe complète reste due ; §5.7 pour la question 21 |
| `clingerHygienicMacroTechnology` | Rabbit 1977, troisième précédent de T-68 ; la justification historique de `thm:hygiene` ; **R-49** |
| `brooksCritiqueCommonLISP1984` | le précédent documenté de P3 ; le critère de concision intellectuelle |
| `vanroyHistoryOzMultiparadigm2020` | l'explicité comme leçon d'échec ; implémenteur *et* théoricien |
| `hermanTheoryHygienicMacros2008` | **la boucle se ferme** : la préconisation de Herman et Wand — que les macros spécifient la structure de liaison qu'elles introduisent — *est* le `binds` de c5. La clé était maintenue sans citation avec ce motif exact ; elle a maintenant sa place |

## E — Second lot arc H, 28 août (après-midi)

Quatre pièces dépouillées, **toutes hors du fonds** (corpus RDF seul). Livrées en DOI ; la première
et la deuxième sont, à mon sens, à citer au manuscrit.

| # | référence | identifiant | ce qu'elle débloque |
|---|---|---|---|
| 1 | Hudak, Hughes, Peyton Jones & Wadler, *A History of Haskell: being lazy with class*, HOPL III 2007 | `10.1145/1238844.1238856` | **le quatrième et meilleur appui de P3** — les fuites d'espace de la paresse, et le remède : rendre la strictesse écrivable. Plus l'avertissement à T-69 (R-53) et le cadrage de la question 21 |
| 2 | Berry, *Lessons from the design of a Standard ML library*, JFP 3(4), 1993 | `10.1017/S0956796800000873` | **la facture de T-68** : un noyau minimal contracte une dette nommée bibliothèque standard. Et R-54, le test le moins cher du projet |
| 3 | Brown, *A development of APL2 syntax*, IBM J. Res. Develop. 29(1), janvier 1985, p. 37–48 | *DOI non confirmé* — l'entrée est trouvable par titre ; le fonds APL de la Software Preservation Group en héberge le PDF | la méthode de dérivation d'une syntaxe ; la hiérarchie linéaire contre la matrice ; le nom comme jeton atomique, qui **fonde l'arbitrage 15** |
| 4 | Clinger & Wand, *Hygienic Macro Technology*, HOPL IV 2020 | `10.1145/3386330` | Rabbit 1977 comme précédent de T-68 ; la justification historique de `thm:hygiene` ; R-49 |

**Note** : je n'ai pas confirmé le DOI de Brown 1985 et je préfère ne pas en inventer un. Les autres
sont vérifiés — celui de Berry est imprimé dans le PDF, celui de Hudak vérifié à l'ACM DL.

## F — Troisième lot arc H, 28 août (soirée) — **les deux plus importantes de la journée**

| # | référence | identifiant | ce qu'elle débloque |
|---|---|---|---|
| 1 | Reynolds, *GEDANKEN — a simple typeless language based on the principle of completeness and the reference concept*, CACM 13(5), mai 1970 | `10.1145/362349.362364` | **la pièce la plus importante du fonds pour le chapitre 1.** Trois de ses six problèmes ouverts sont K7PL : (1) ajouter les types dépendants sans détruire la généralité — « un problème théorique majeur » ; (3) le coût en pile de la complétude, avec les **deux remèdes que K7PL emploie** — des facilités de langage marquant les contextes à discipline de pile (nos couches) et des déclarations de type permettant l'analyse (nos grades) ; (4) « une forme limitée de traits impératifs ajoutée à un langage applicatif sans détruire l'indépendance à l'ordre d'évaluation » — les effets algébriques, en 1970 |
| 2 | Appel, *A critique of Standard ML*, JFP 3(4), 1993 | `10.1017/S0956796800000836` | **la forme nette de R-42** — les trois questions : démontrable, implantable, utile. Et l'argument décisif pour R-54 : « les bons côtés d'un langage sont généraux ; ses défauts sont étroits, techniques, sans intérêt théorique — et affectent tous l'utilisabilité » |

Ces deux-là, plus Hudak et Berry, sont à mon sens les quatre entrées de la journée qui méritent
d'être citées au manuscrit. Les autres servent le travail de recherche sans avoir à y figurer.

## G — Clôture de l'arc H, 28 août (nuit)

| # | référence | identifiant | ce qu'elle débloque |
|---|---|---|---|
| 1 | Syme, *The Early History of F#*, HOPL IV 2020 | `10.1145/3386325` | **le précédent industriel du délimiteur-régime** : `async { ... }`, « réinterprétation *localisée* des constructions de contrôle existantes », devenue standard de fait (C#, TypeScript, Kotlin, Python, Java, JS). Plus **R-47 presque tranchée** — troisième concepteur à regretter l'égalité structurelle générique — et **R-57** |
| 2 | Griswold, *Suggested Revisions and Additions to the Syntax and Control Mechanisms of SNOBOL4*, SIGPLAN Notices, févr. 1974 | `10.1145/987298.987299` *(à vérifier)* | **R-56** — une position privilégiée accordée à un opérande crée une classe d'opérations hors du format général, et bloque les extensions douze ans. Et le contre-exemple qui **justifie l'arbitrage 23** : le même symbole pour des travaux *différents*, désambiguïsés par la position |
| 3 | Saal, *Considerations in the design of a compiler for APL*, IBM TR 03.045, mars 1978 | rapport technique interne — *pas de DOI* | les traits d'espace de noms rendent APL non compilable statiquement ; **la Phase 0 de K7PL achète la staticité de la syntaxe**, ce que c3 ne revendique pas. Et le premier item de l'arc I |

Le DOI de Griswold 1974 est à confirmer ; celui de Syme est vérifié.

---

# Récapitulatif des livraisons du 28 août

**Quatre entrées que je recommande de citer au manuscrit** : Reynolds 1970, Hudak 2007, Berry 1993,
Appel 1993. Elles portent respectivement l'ancêtre des postulats, le meilleur appui de P3, la facture
de T-68, et la forme nette de R-42.

**Trois entrées utiles au travail sans avoir à figurer** : Clinger & Wand, Syme, Brown.

**Tout le reste** sert la recherche et reste au corpus RDF.

---

# CORRECTION — 28 août, fin de journée

La section **D** ci-dessus annonçait MacQueen, Brooks, Van Roy et Clinger comme « entrées du fonds
dépouillées ce jour ». **Vérification faite sur `refs.bib` : aucune des quatre n'y est.** Seule
`hickeyHistoryClojure2020` l'était — ce que le contrôle avait d'ailleurs signalé le jour même, en
exigeant une décision datée.

**L'état exact de chaque référence est désormais tenu dans `meta/corpus.org`**, en drawers org-mode
avec les propriétés `REF.BIB`, `RDF`, `PDF` et `LU`, visualisables en vue colonnes. Ce fichier-ci
reste la liste de ce qu'il y a **à charger** ; `corpus.org` est la liste de ce qu'il y a **à citer**,
et c'est lui qui fait foi.

**Bilan des dix-huit références en jeu** : trois sont au fonds (Hickey, Orchard, Herman & Wand),
quinze sont au corpus RDF avec leur PDF et n'ont qu'à passer. **Aucune recherche à mener, aucun
paywall à franchir** — c'est un import, pas une campagne de sourçage. Sept identifiants restent à
vérifier ou sont absents (Brown 1985 introuvable ; Saal 1978 et Pruiksma sont des rapports sans DOI ;
quatre DOI déduits de la série sans confirmation) : je les ai marqués plutôt que de les inventer.
