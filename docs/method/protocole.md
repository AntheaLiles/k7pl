# K7PL — protocole de travail

28 août 2026

> Protocole de travail de l'ancien dispositif (Org-mode, assistants et contrôles Python). La conduite du travail sur la spécification Verso est décrite dans [le tableau de bord](../tracking/TABLEAU-DE-BORD.md) et dans `.claude/skills/writing-rules.md`.

## Protocole des acteurs

#### Ce que ce protocole gouverne

Les travaux de vérification contre la littérature, conduits par cinq agents dont les rôles sont fixés ci-dessous. Il ne gouverne pas la rédaction du corps, qui reste une écriture continue.

#### Les cinq rôles

A1 RÉSUMÉ FORMEL. Lit un article ou une grappe et en extrait ce qu'il ÉTABLIT, pas ce qu'il suggère. Sortie : formal_summary + key_concepts. Interdit : toute comparaison avec K7PL. A2 MATRICE DE COMPARAISON. Confronte chaque énoncé de la source à une localisation PRÉCISE du document (chapitre, section nommée, numéro de version d'introduction). Sortie : un item par confrontation, avec source_location, article_position, compatibility_status, justification. Le statut est l'un de : Compatible / Partiellement compatible / Incompatible, et chaque Incompatible doit produire une issue en A3. A3 JOURNAL DES CONTRADICTIONS. Une issue par divergence, avec severity (Bloquant, Majeur, Mineur), location, description, article_evidence (CITATION, non paraphrase), proposed_fix. A4 ACTIONS DE CITATION. Références au format IEEE, et LISTE EXPLICITE des entrées consultées SANS insertion, avec la raison. Une entrée lue et écartée doit être dite écartée. A5 SYNTHÈSE. concordance_summary, divergence_summary, action_plan ordonné par sévérité.

#### Vérification récursive — obligatoire en fin de rapport

Reprendre chaque conclusion antérieure que la grappe touche, et dire si elle est confirmée, précisée ou INFIRMÉE. Une grappe qui n'infirme jamais rien est suspecte : soit elle n'a rien trouvé, soit elle n'a pas cherché.

#### Invariants de traitement — non négociables

1.  TABLE DE CORRESPONDANCE DÉRIVÉE. Jamais saisie à la main. Une table manuscrite a réattribué 28 références sur 50 en v10, défaut découvert vingt passes plus tard.
2.  CLÉS SYMBOLIQUES. Les citations sont tokenisées en @@CLÉ@@ avant toute réécriture, et renumérotées à la fin. Les commentaires sont EXCLUS de la tokenisation — un « \[cite:@munch-maccagnoniResourcePolymorphism2018\] » dans un commentaire a épinglé une référence pendant huit versions.
3.  SONDES SÉMANTIQUES. Une suite de couples « passage → auteur attendu », rejouée à chaque passe. Elle est passée de 3/34 à 34/34 lors de la réparation de v20. Sans elle, les contrôles formels — ordre, non-régression — passent tous sur une bibliographie fausse.
4.  NON-RÉGRESSION. Aucune référence de la version précédente ne doit disparaître sans décision.
5.  RENVOIS PAR ÉTIQUETTES NOMMÉES. Jamais par numéro. Six renvois « §1.5 » ont été faux pendant dix versions ; 66 renvois du chapitre de gestion l'étaient encore en v40.

#### Pièges vérifiés au moins une fois

— Un compte d'occurrence de 1 ne dit pas LAQUELLE. Vérifier le chapitre d'atterrissage. — Une sonde peut être mal ancrée et attraper la citation SUIVANTE. Vérifier amont et aval. — Un contrôle qui trie par ligne seule donne un ordre arbitraire quand plusieurs citations partagent une ligne. Trier par ligne ET colonne. — Trois fois au cours de ce travail, un script apply_vNN.py de provenance inconnue était présent avant écriture. NE PAS L'EXÉCUTER : inspecter, supprimer, réécrire.

#### Constitution d'un corpus

PICOC explicite avant recherche. Requêtes en quatre blocs dont le dernier est CONTRAIGNANT. Prédiction nominative : nommer deux ou trois travaux dont l'absence signalerait une requête mal formée. Signaler les polysémies attendues. Après dépouillement, dire ce qui a été consulté sans prise, et pourquoi — une grappe qui ne rapporte que ses trouvailles cache son taux de bruit.

## Vérification d'attribution

Ajoutée le 5 août 2026, à la suite d'un défaut que la suite de sondes ne pouvait pas voir.

CE QUE LES SONDES VÉRIFIENT DÉJÀ : qu'un passage cite le bon auteur. Une sonde est un couple « passage attendu -\> clé attendue », et elle attrape les réattributions — c'est elle qui a réparé les vingt-huit références déplacées de la v10.

CE QU'ELLES NE VOIENT PAS : ce que la source établit. Une citation peut porter le bon auteur et lui faire dire l'inverse de ce qu'il dit. C'est arrivé, et pendant longtemps. Le document écrivait « il est établi qu'un tel encodage n'appartient à aucune interface d'effet », en citant une œuvre dont c'est le PROBLÈME et non le résultat, et dont la contribution est précisément de le RÉSOUDRE. La sonde disait bon auteur ; le document disait le contraire de l'auteur.

LA RÈGLE, et elle est courte. Toute citation qui soutient une revendication d'ÉTABLISSEMENT — « il est établi que », « la littérature montre que », « on sait que » — doit désigner un RÉSULTAT et non une œuvre. Théorème, proposition, section : quelque chose qu'on puisse ouvrir et lire. Une citation qui ne désigne qu'un titre ne peut pas soutenir une affirmation d'établissement, et doit alors être reformulée en emprunt d'idée plutôt qu'en appui de preuve.

LA SUITE DE SONDES D'ATTRIBUTION, à constituer sur le même principe que les sondes sémantiques : des couples « énoncé du document -\> ce que la source établit », rejoués lorsqu'une source est relue ou remplacée. Une source dont on n'a lu que le titre ne peut pas y figurer, et c'est le point : la suite mesure ce qui a été VÉRIFIÉ, non ce qui a été cité.

CE QUE CELA IMPOSE AU DÉPOUILLEMENT : l'agent A4 dit déjà ce qui a été consulté sans prise. Il doit dire en outre, pour chaque insertion, QUEL RÉSULTAT de la source la soutient. Une insertion qui ne peut pas nommer son résultat est une insertion à reformuler.

ORIGINE : grappe S1, issue S1-002. Trois sites du document étaient touchés.

## Ordre de prévalence des arguments

Arbitrage d'Anthea, 4 août 2026. Cette règle gouverne tout écart entre deux parties du document et mérite d'être ici plutôt que dans une entrée, puisqu'elle décide de toutes.

POSTULATS \> AXIOME \> DÉMONSTRATIONS

Lorsqu'une formalisation diverge de ce que l'axiomatique pose, ce n'est pas une contradiction entre deux énoncés de même rang : c'est une ERREUR DE FORMALISATION AU REGARD DE L'AXIOMATIQUE, et c'est la formalisation qui se met en conformité. Nommer l'écart « contradiction » suppose une symétrie de faute qui n'existe pas ; le nommer erreur dit de quel côté est le tort, et le dire est la moitié de la correction.

L'AXIOME NE BOUGE QUE SUR INFAISABILITÉ. Il n'évolue que si le raffinement des concepts révèle une impossibilité, pour lui, de respecter les postulats. Un embarras de formalisation n'est pas une infaisabilité, et l'inconfort d'écrire ne se paie jamais sur les fondations.

LA DÉMARCHE EST À DEUX SENS. Descendante, l'axiomatique contraint la formalisation ; montante, le raffinement progressif de chaque mécanisme éprouve l'axiomatique et peut, à la longue, révéler une infaisabilité. Ce qui touche aux fondations s'arbitre donc plus strictement que ce qui touche à la formalisation, et l'asymétrie est voulue.

L'ANCRAGE DANS L'ÉTAT DE L'ART sert cette dérivation : formaliser en s'appuyant sur ce que d'autres ont déjà vérifié évite d'inventer là où il suffit d'emprunter, et donne à la formalisation une réalité qui ne dépend pas de ce document seul.

CE QU'IL FAUT EN ATTENDRE, et qui est arrivé une fois. En construisant une formalisation conforme, on peut découvrir qu'elle se simplifie localement — qu'à telle couche, ou sous telle condition, la généralisation redevient le cas particulier. C'est ce qui s'est produit lorsque la zone Gamma s'est absorbée dans Delta, une liaison non restreinte n'étant que la partie de grade omega de l'autre. Ces simplifications ne se décrètent pas d'avance : elles se démontrent une fois la forme générale posée, et ce sont de bonnes surprises plutôt qu'un plan.

## LES RÈGLES ACQUISES DEPUIS — *août 2026*

### Sur l'arbitrage

***Une question qui propose trois arbitrages du type « on laisse tomber » ou « on fait qu'à moitié » indique que nous n'avons pas fait suffisamment de recherches.*** /L'objectif premier est une DISTILLATION de la recherche vers un cadre théorique piloté par des postulats forts, et l'absence de réponse convaincante constitue un AXE DE RECHERCHE, pas un axe d'abandon ou de compromis./ ***Et avant de monter un dossier d'arbitrage : vérifier si la DOCTRINE répond déjà. Si oui, écrire le CONSTAT et non la démonstration — un acquis sur-argumenté se lit comme une question ouverte.***

### Sur les contrôles

***UN CONTRÔLE NE S'ASSOUPLIT JAMAIS POUR PASSER. Il s'AFFINE, et il en dit alors davantage.*** /Le contrôle des clés a été affiné deux fois en août : d'abord pour distinguer le fonds-projet de la bibliothèque, puis pour distinguer le corpus de LECTURE du fonds de CITATION. Les deux fois, il est devenu plus informatif, jamais plus permissif./ **Et une orpheline se règle par une DÉCISION datée et motivée, avec une échéance de révision — jamais en retirant l'entrée.**

### Sur la bibliographie

***LES FICHIERS DE BIBLIOGRAPHIE SONT ENGENDRÉS ET MAINTENUS PAR ZOTERO. Le projet n'y écrit jamais.*** *Les références à intégrer se communiquent en DOI, ISBN ou URL, pour import par Anthea.* ***ET ILS SONT DEUX, AVEC UNE HIÉRARCHIE STRICTE — règle posée par Anthea le 3 septembre.*** `bib/K7PL-Biblio/refs-pour-citations.bib` est la RÉFÉRENCE ABSOLUE : on passe toujours par là, pour les clés, les titres, les résumés, les dates et les identifiants. `bib/K7PL-Biblio/K7PL-Biblio.bib` ne se consulte QUE pour retrouver le chemin d'un PDF, et uniquement dans ce cas. ***LA RAISON DE LA RÈGLE EST UNE FAUTE DATÉE*** : /deux sources pour un même fait est exactement ce qui a produit les erreurs du 3 septembre. La hiérarchie ne dit pas quel fichier est meilleur, elle dit lequel PRÉVAUT, ce qui rend l'autre inutile à consulter pour tout le reste./ *Le RDF a été supprimé le 3 septembre : il n'y a plus de troisième format à synchroniser.* ***UNE CLÉ DE CITATION N'EST PAS UN IDENTIFIANT STABLE : elle dépend de ce qui est EXPORTÉ.*** **Et toute fiche dépouillée porte son `~cite:@clé~` le jour même** : *une fiche lue qui ne porte pas son marqueur est, pour tout contrôle futur, une fiche non lue.*

### Sur la recherche de sources

***AVANT DE DÉCLARER UNE SOURCE ABSENTE, LA CHERCHER PAR SON SUPPORT — non par la description qu'on en a écrite.*** /Les groupes E et F ont été déclarés absents trois semaines durant alors qu'ils étaient dans un PDF livré : ils avaient été cherchés sous les noms que le document leur donnait, non sous leurs titres réels./ **Et croiser la recherche par RÉSUMÉ avec une recherche dans le TEXTE** : *un résumé erroné rend une entrée invisible, et c'est arrivé.*

### Sur le transport d'une leçon d'un langage à l'autre

> ***« Les mots sont effectivement très proches mais le CONTEXTE est hyper important pour bien évaluer leur poids. »*** — *Anthea, 28 août*

***AVANT DE TRANSPORTER UNE LEÇON D'UN LANGAGE À K7PL, VÉRIFIER QUE L'OBJET DONT ELLE PARLE FAIT CHEZ NOUS LE MÊME TRAVAIL.*** /Deux fois le 28 août, un rapprochement PLAUSIBLE et bien formé s'est révélé faux : « trois paires de délimiteurs » chez Oz construisent des DONNÉES là où les nôtres annoncent un FRAGMENT ; et la « syntaxe inhabituelle » d'Oz était SUI GENERIS quand K7PL hérite de celle de Lisp./ **C'est la faute la plus difficile à voir** : *les trois autres étaient des vérifications omises ; celle-ci produit des conclusions bien formées à partir d'une proximité lexicale.*

### Sur ce qui se démontre et ce qui se constate

***UNE POSITION SE DÉFEND MIEUX PAR CE QU'ELLE REND SUPERFLU QUE PAR CE QU'ELLE INTERDIT.*** *Deux fois en août, une IMPOSSIBILITÉ a été énoncée là où il y avait une INUTILITÉ, ce qui fait lire une contrainte au lieu d'une propriété.* **Et avant d'invoquer une règle du langage sur un objet** : *vérifier que l'objet est DU langage. Un commentaire n'est pas parsé.*

## LA RÈGLE D'APL2 — *ajoutée le 28 août, et elle vaut pour tous les arbitrages à venir*

> ***DEVANT UN CAS QU'UNE RÈGLE NE COUVRE PAS, CHERCHER D'ABORD LA MESURE QUI RENDRAIT LA RÈGLE INUTILE. N'AJOUTER UNE RÈGLE QU'APRÈS AVOIR ÉCHOUÉ À LA TROUVER.***

/Brown 1985, sur les extensions qui cassaient la syntaxe d'APL1 : « ces questions AURAIENT PU être résolues en stipulant de nouvelles règles couvrant les cas, suivies d'une vérification qu'aucune ambiguïté n'était introduite. ***Au lieu de quoi APL2 emploie le concept de FORCE DE LIAISON, qui rassemble EN UNE SEULE MESURE tous les concepts de syntaxe.*** »/ ***C'EST LA VERSION CONSTRUCTIVE DE LA LEÇON DE LA QUESTION 4*** — /« une position se défend mieux par ce qu'elle rend SUPERFLU que par ce qu'elle interdit ». Là, Anthea corrigeait une défense maladroite ; ici, la même idée devient une méthode de conception./ **Et le corollaire de forme** : /quand une mesure existe, la préférer sous forme de HIÉRARCHIE LINÉAIRE plutôt que de matrice — « même une petite matrice est difficile à retenir et à appliquer en pratique »./

## ET UNE OBSERVATION SUR CE QUE L'ARC H RAPPORTE, APRÈS ONZE PIÈCES

***LE RENDEMENT EST RÉGULIER ET IL A TROIS FORMES, TOUJOURS LES MÊMES :***

|  |  |
|----|----|
| 1 | ***un PRÉCÉDENT pour un geste que le document fait sans le savoir*** — *Rabbit et Bare pour T-68 ; APL2 pour l'architecture de la méthode ; Herman et Wand pour `binds`* |
| 2 | ***une FACTURE que le document ne chiffrait pas*** — *le coût de la Phase 0 ; la translucidité obligée des interfaces ; la dette de bibliothèque* |
| 3 | ***un ACQUIS que le document ne revendique pas*** — *`binds` contre l'extraction de Petrofsky ; `ℰ` contre l'optimisation de curryfication ; l'unikernel contre la pluralité des modèles de compilation* |

*Les articles techniques donnent des théorèmes ; les rétrospectives donnent ces trois-là. Aucune ne se substitue à l'autre, mais le projet avait beaucoup des premiers et aucune des secondes.*

## LA RÈGLE DU 28 AOÛT AU SOIR — *relire l'instruction avant de raisonner par-dessus*

> ***AVANT DE RAISONNER SUR UNE QUESTION DÉJÀ INSTRUITE, RELIRE L'INSTRUCTION.***

*Extension de la règle du 10 août — « avant d'ouvrir une source, lire le chapitre que la question touche ». Celle-ci vise le cas plus insidieux où le dossier est à NOUS.* **Le cas** : /j'ai fondé le retrait des deux shifts sur la prémisse « ADJ a un contexte par mode ». Le dossier R-35, écrit trois heures plus tôt dans le même fichier, disait le contraire — ADJ a un séquent `Ψ ⊣ A_k` avec une présupposition d'ordre, et note même que cette présupposition « généralise la présentation à deux zones »./ \*/LA CONCLUSION ÉTAIT JUSTE ; LA PRÉMISSE ÉTAIT FAUSSE ; ET LE BON ARGUMENT ÉTAIT DANS LE MÊME DOSSIER — le mode de ADJ est, chez K7PL, la composante `u` du grade, et en changer est du SOUS-TYPAGE./\* /Rattrapé par la suspension qu'Anthea a demandée. C'est la deuxième fois dans la journée qu'une conclusion plausible et bien formée repose sur une vérification omise, et la première — le lot Oz — avait donné la même leçon sous un autre angle./

> ***LE POINT COMMUN DES CINQ FAUTES DE LA CAMPAGNE : aucune n'était une erreur de RAISONNEMENT. Toutes étaient une vérification qu'on n'a pas faite parce que la conclusion paraissait tenir sans elle.***

/Corollaire pratique : plus un raisonnement est élégant, plus il faut chercher la pièce du dossier qui le contredirait. C'est peu coûteux — le dossier est à nous — et c'est le seul filtre qui ait attrapé quelque chose jusqu'ici./

## LA RÈGLE ÉLARGIE, 28 août au soir — *le corpus le plus mal lu est le nôtre*

> ***AVANT D'AFFIRMER QUE LE DOCUMENT N'A PAS QUELQUE CHOSE, CHERCHER DANS LES SEPT CHAPITRES — PAS DANS CEUX OÙ ON S'ATTEND À LE TROUVER.***

/J'ai écrit « noms de module : INEXISTANTS, le document n'en a pas », après avoir grepé c5 et c6. Le chapitre 4 porte une théorie complète : les modules sont les objets d'une catégorie engendrée par le graphe des dépendances, et un namespace est une SOUS-CATÉGORIE LARGE obtenue en restreignant à une dimension — la pureté, l'effet, le couplage./ ***J'AI CHERCHÉ LES MODULES DANS LE CHAPITRE DE LA SYNTAXE ET DANS CELUI DE LA COMPILATION. ILS SONT DANS CELUI DES AUTOMATES, PARCE QUE C'EST LÀ QUE VIT LE GRAPHE DE DÉPENDANCES.*** *Le classement d'un sujet dans le document ne suit pas le classement qu'on lui donne d'ordinaire, et c'est précisément ce qui rend le grep partiel dangereux.* **Corollaire opératoire** : *un grep négatif sur deux fichiers n'est pas un résultat. Ou bien on grep `src/` en entier, ou bien on ne conclut pas.*

> \*/BILAN DES CINQ FAUTES DE LA CAMPAGNE : une impossibilité pour une inutilité ; une règle du langage appliquée à un commentaire ; un écart signalé sans relire le chapitre ; une leçon transportée sur la proximité des mots ; une prémisse fausse tirée d'un dossier qu'on avait soi-même écrit ; et maintenant une absence conclue d'un grep partiel. AUCUNE N'ÉTAIT UNE ERREUR DE RAISONNEMENT./\*

## CONVENTION DE NOMMAGE DES SYMBOLES — *Anthea, 28 août*

> ***LORSQU'UN SYMBOLE EST NOMMÉ — `Δ`, `□`, `λ`, `⊸`, `⊗` —, DONNER LE MOT ANGLAIS OU LE TERME SCIENTIFIQUE : « bind », « restrict », « lambda », « fork », « join ».***

/Un symbole n'est pas un nom : c'est une orthographe. Le mot est ce qui se prononce, ce qui s'écrit dans un message d'erreur, ce qui se cherche dans une documentation — et c'est lui que l'arc G doit choisir./ \*/CETTE CONVENTION N'EST PAS UNE COMMODITÉ DE LECTURE : elle est le TEMPS 0 de l'arc G appliqué en continu. Chaque fois qu'un symbole est cité sans son mot, un mot reste à choisir sans qu'on le sache./\* *Et elle rejoint le principe de Brown 1985 : le nom est le jeton, sa structure cesse d'intéresser une fois qu'il est reconnu. Encore faut-il qu'il y ait un nom.* **Applicable rétroactivement** : *les fiches de dépouillement antérieures citent des symboles nus. Elles ne seront pas reprises, mais toute fiche nouvelle porte le mot.*
