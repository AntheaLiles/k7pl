<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# K7PL — inventaire consolidé des sources historiques du vocabulaire du noyau

> **Statut : inventaire de provenance non normatif.** Établi le 25 octobre 2026 à partir de main, SHA `c88c968e66e5951bbf300efe3e39a515df8d8aa3`. Cet inventaire est le point d'entrée unique pour le présent chantier lexical. Il n'efface pas les sources, ne ratifie aucun choix de nom et n'autorise aucun renommage.

## 1. Finalité et règle d'autorité

Ce fichier rassemble les sources historiques qui ont influencé, décrit ou discuté le vocabulaire du noyau, ses frontières ontologiques, les propositions de T-68 et les critères d'Arc G. Il vise à éviter que les mêmes arguments soient redécouverts dans plusieurs notes, qu'une formulation ancienne soit prise pour l'état courant, ou qu'une proposition attribuée à l'autrice dans une archive soit transformée en décision.

**Règle de lecture :** pour un fait sur le langage courant, la source de départ est la spécification Verso sous `spec/`, à la révision mentionnée ci-dessus. Pour l'état d'une décision, utiliser les registres actuels de `docs/tracking/` et `docs/migration/`. Les archives servent à retracer une origine ou à récupérer un argument, jamais à établir seules l'état normatif.

Les fichiers historiques ne sont pas supprimés ou déplacés par ce lot. L'inventaire enregistre leur contenu utile, leur lien vers les sources parentes, leur autorité et la suite à donner. Une phase de nettoyage distincte devra ajouter des bandeaux de statut ou des renvois, puis retirer les copies devenues inutiles uniquement après vérification de la provenance et accord explicite lorsque le fichier est le seul témoin d'un choix ou d'une analyse.

## 2. Carte d'autorité actuelle — à consulter avant l'historique

| ID | Source courante | Rôle faisant autorité | Limite |
|---|---|---|---|
| C-01 | [Doctrine](../method/doctrine.md) | Priorité des fondements et discipline de recherche. | Contient aussi des passages historiques anciens sur le nombre de constructeurs et le statut de T-68 ; ceux-ci sont précisément à rapprocher de l'audit actuel. |
| C-02 | [Grammaire des termes](../../spec/Spec/C3/GrammaireDesTermes.lean) | Formes de termes présentes dans la spécification à la révision examinée. | La complétude ontologique ne découle pas du seul inventaire syntaxique. |
| C-03 | [Grammaire des types](../../spec/Spec/C3/GrammaireDesTypes.lean) | Formateurs de types, sessions, grades et effets. | Certaines correspondances avec les règles ou avec des constructions génératrices demeurent des obligations ouvertes. |
| C-04 | [Règles de typage](../../spec/Spec/C3/ReglesDeTypage.lean) | Règles et prémisses qui gouvernent les objets. | Plusieurs énoncés sont explicitement au statut under-review/proofsketch ; leur présence ne signifie pas qu'ils sont démontrés. |
| C-05 | [Sémantique opérationnelle](../../spec/Spec/C4/SemantiqueOperationnelle.lean) | Réductions et configuration spécifiées. | Les obligations non déchargées et les décisions temporelles ouvertes restent ouvertes. |
| C-06 | [Table des glyphes](../../spec/Spec/C1/TableDesGlyphes.lean) et [chapitre C5](../../spec/Spec/C5.lean) | Frontière courante entre noyau, macros, alias et formes de surface. | Les glyphes/alias de la bibliothèque ne sont pas à ajouter comme primitives autonomes. |
| C-07 | [Registre des primitives](../tracking/primitives.md) | État courant des entrées et des propositions. | Les entrées DOING ne sont pas le cardinal des primitives normatives. |
| C-08 | [Audit T-68](../migration/L1-T68-AUDIT.md) | Audit de minimalité, critère par obligations, anomalies à instruire. | État OPEN/IN PROGRESS ; il interdit de présenter un cardinal final comme établi. |
| C-09 | [Décisions actuelles](../tracking/DECISIONS.md) | État des choix déjà ratifiés et des arbitrages ouverts. | Une décision d'autrice peut fixer une option sans prouver ses conséquences mathématiques. |
| C-10 | [Plan directeur](../tracking/PROJECT-MASTER-PLAN.md), [statut des branches](../tracking/BRANCHES-STATUS.md), [décisions L1](../migration/L1-DECISIONS.md) | Dépendances, statut des propositions historiques et gouvernance. | Ce sont des registres datés ; vérifier les objets normatifs auxquels ils renvoient. |
| C-11 | [Factorisations refusées](../tracking/factorisations-refusees.md) | Sept tests négatifs contre les fusions abusives. | Ne pas les résumer à une liste de noms : conserver les obligations qui motivent chaque refus. |
| C-12 | [Contrôle croisé actuel](../../scripts/controles/croise.py) | Contrôle structurel grammaire/règles/registre. | Le contrôle a une table explicite de correspondance ; les formes fix et declassify présentes dans la grammaire ne sont pas dans EXPECTED. C'est une lacune de couverture à instruire, pas une raison de supprimer ces formes. |
| C-13 | [Contrôle lexical actuel](../../scripts/controles/vocabulaire.py) | Politique lexicale ciblée sur une famille française interdite dans spec. | Ce script n'est pas le renommage automatique T-68 de l'archive PR #10 ; les deux ne doivent pas être confondus. |

## 3. Sources historiques de la méthode Arc G

| ID | Source et période | Objet et contenu récupérable | Statut de provenance | Réutilisation autorisée / piège à éviter |
|---|---|---|---|---|
| H-G01 | [arc-g-methode.md](arc-g-methode.md), 31 août 2026, 199 lignes | Méthode en cinq temps : périmètre, besoin, collecte, comparaison, choix ; inventaire historique de dix espaces de noms et critères séquentiels : non-collision, famille, comportement sous grades, mnémonique, brièveté. | Note de recherche historique, toujours pertinente comme méthode à instruire. | Le décompte de 33 constructeurs et les « vingt-et-une entrées » reflètent son instantané. Le texte ne définit pas le rang du critère écologique demandé dans le présent mandat ; sa séquence ne peut pas être réputée ratifiée sur ce point. |
| H-G02 | [arc-g-collecte.md](arc-g-collecte.md), 2 septembre 2026, 251 lignes | Comparaisons, par catégorie, des termes de CBPV, des connecteurs, des existentielles, des modalités et des effets ; arguments de familiarité ; arbitrages historiques « return/let » et distinction des noms formels operation/scoped des actions de surface perform/handle. | Collecte historique qui contient aussi ses propres sections d'arbitrage ; elle n'est pas en soi un registre normatif de décision. | Les observations trans-langages n'établissent pas automatiquement la justesse d'un mot pour les contraintes graduées de K7PL. Toute décision historique doit être revalidée contre spec et DECISIONS.md. |
| H-G03 | [questions.md](questions.md), corpus de questions du 28 août 2026 | Registre des questions de recherche, dont les questions nommage QG-8 à QG-11 et leurs états. | Inventaire historique de recherche ; statut enregistré à l'époque. | Ne pas confondre « question close » avec « candidat de nom validé » ou avec lecture intégrale de toutes les études citées. |
| H-G04 | [manques.md](manques.md), 28 août 2026 avec suivis ultérieurs | Manques de corpus par arc et par engagement ; références à la littérature empirique du nommage et au corpus APL/BQN/Uiua. | Historique des lacunes et de leur évolution. | Une mention « manque levé » ne remplace pas l'inspection de la source utilisée ; une absence constatée en août n'est pas automatiquement un état bibliographique de 2026-10-25. |
| H-G05 | [a-sourcer-nommage.md](../bibliography/a-sourcer-nommage.md), 3 septembre 2026 | Onze références supplémentaires issues de la revue d'Oliveira et al.; indication explicite que les questions Arc G ont été closes sans ces lectures et que les références ne débloquent plus l'arc. | Liste de sourçage historique, non bloquante pour Arc G selon sa propre note. | Ne pas présenter les onze lectures comme requise avant de finir le présent QCM. Elles peuvent servir à un protocole empirique distinct. |
| H-G06 | [a-sourcer-manques.md](../bibliography/a-sourcer-manques.md), 31 août 2026 | Historique de vérification de sources manquantes, notamment documentation BQN et Uiua ; les statuts de vérification sont datés. | Note bibliographique de travail. | Les revendications d'absence ou de statut de publication sont historiques : les revérifier avant toute affirmation actuelle sur ces langages. |
| H-G07 | [a-charger.md](../bibliography/a-charger.md), 3 septembre 2026 et lots antérieurs | Liste de chargement Zotero incluant un volet historique « T-68 × question 30 » et d'autres fondations. | Liste d'acquisition historisée ; non une décision de vocabulaire. | Ne pas la réactiver comme liste d'achats sans réexaminer ce qui est déjà dans refs et ce qui bloque réellement une décision. |
| H-G08 | [protocole.md](../method/protocole.md), 28 août 2026 | Ancien protocole de lecture de littérature : source primaire, correspondance passage/énoncé, journal des contradictions, résultats établis versus titres cités. | Méthode historique du dispositif Org-mode ; le travail courant est gouverné par le dashboard et les règles actuelles. | Réutiliser la discipline de provenance et de réfutation ; ne pas réactiver l'ancien outillage ni les anciens chemins. |

## 4. Évolution historique du périmètre T-68

| ID | Source | Ce qu'elle apporte | Statut / traitement |
|---|---|---|---|
| H-T68-01 | [Plan du 2 septembre](../history/2026-09-02-plan.md) | Instantané des chantiers et de l'Arc G/T-68 début septembre ; anciens nombres et priorités. | Archivé le 1er octobre ; ne décrit pas l'état courant. |
| H-T68-02 | [Stratégie du 2 septembre](../history/2026-09-02-strategie.md) et [arbitrages du 2 septembre](../history/2026-09-02-arbitrages.md) | Ordre de clôture et questions théoriques alors ouvertes. | Les fichiers déclarent eux-mêmes qu'ils sont des états du 2 septembre, sans arbitrage lexical final. |
| H-T68-03 | [Arbitrages ouverts du 8 septembre](../history/2026-09-08-arbitrages-ouverts.md) | Volet historique de décisions, y compris un groupe « G » empirique qui précise ne pas être l'Arc G de nommage. | À consulter uniquement pour la question historique visée ; risque de collision entre identifiants de groupes. |
| H-T68-04 | [Instruction G-01/G-05/G-06](../history/2026-09-08-instruction-g-01-g-05-g-06.md) | Questions historiques de garanties, de coût d'expressivité et de modèle matériel. | Pas une source directe de lemmes ; utile uniquement pour tracer les anciennes obligations qui ont pu être rapprochées de l'ergonomie. |
| H-T68-05 | [Plan de réalisation du 8 septembre](../history/2026-09-08-plan-realisation.md) | Le chemin critique historique faisant de T-68 un préalable à l'interpréteur de référence. | Remplacé comme plan actif ; ne l'utiliser que pour la provenance de l'ordre ancien des travaux. |
| H-T68-06 | [Séance du 9 septembre](../history/2026-09-09-seance.md) | Déclare que le point fixe coinductif a été habité par deux règles de terme et que le contrôle est vert à cette date. | Preuve historique de l'évolution du texte ; vérifier les règles actuelles dans C3. Le registre de primitives contient encore une narration qui dit que des règles de coalgèbre manquent : divergence à rapprocher, non à résoudre à partir de cette seule note. |
| H-T68-07 | [Séance Slice, PR-02 no 20](../history/2026-10-05-pr-02-20-slice.md) | Ajout historique de Slice/Cap, annonce 50 règles et 46 constructeurs, et dit explicitement que le mot slice est provisoire et rejoint T-68. | Historique concis ; c'est une trace d'origine pour Q-TERM-048 et Q-TOKEN-006, pas une ratification. |
| H-T68-08 | [Provenance de migration](../history/2026-10-07-provenance-migration.md) | Correspondances des sources Org vers les chemins courants, notamment meta/primitives.org, meta/arcG-methode.org, meta/questions.org et meta/manques.org. | Carte de migration historique ; permet de retrouver l'origine, ne rend pas les anciens fichiers actuels. |
| H-T68-09 | [Revue de cohérence du 9 octobre](../history/2026-10-09-coherence-review.md) | Audit fermé de cohérence, de contrôles et d'hygiène des branches ; signale notamment le suivi T-68. | Archives d'audit fermées ; les cases ouvertes y sont un snapshot, pas un backlog actuel. |
| H-T68-10 | [Index de l'historique](../history/README.md) | Index exhaustif des notes et rapports datés sous docs/history/. | Entrée unique pour les autres rapports historiques. Les 13 sessions PR #10 nos 21–33 ne sont pas déposées ici, car elles doublonneraient les numéros avec l'historique courant 21–62. Voir la section 6 pour leur provenance. |

## 5. Archive PR #10 : filiation, dépôts et copies à ne pas traiter comme décision

### 5.1 Chronologie vérifiée par les dossiers GitHub

- **PR #10** — [docs(spec): campaign PR-02, sessions 28–33](https://github.com/AntheaLiles/k7pl/pull/10), ouverte le 5 octobre 2026, fermée le 7 octobre 2026 **sans fusion** ; commit d'archive pertinent : [d39d012ea77277bfd774f67985966fb6ba7340cf](https://github.com/AntheaLiles/k7pl/commit/d39d012ea77277bfd774f67985966fb6ba7340cf), 115 fichiers. Les propositions T-68 de ce commit ne décrivent pas main.
- **PR #23** — [docs: start T-68 primitive minimality audit](https://github.com/AntheaLiles/k7pl/pull/23), fusionnée le 6 octobre. Elle a apporté le critère de minimalité par obligations et le constat que les 45 entrées DOING ne permettent pas de conclure au cardinal normatif.
- **PR #220** — [instruction des constats de l'archive PR #10](https://github.com/AntheaLiles/k7pl/pull/220), fusionnée le 14 octobre. L'autrice a retenu la reprise sélective, note par note ; l'instruction sémantique en C porte les constats examinés sans changement de spec.
- **PR #237** — [dépôt des pièces non normatives de PR #10](https://github.com/AntheaLiles/k7pl/pull/237), fusionnée le 19 octobre. Elle a déposé cinq pièces avec bannières d'archive et annotations de divergence. Traductions anglaises et extraits n'ont pas été ratifiés par la seule fusion.

### 5.2 Pièces déposées en main depuis le commit d'archive

Le registre de migration maître est [L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md). Sa table (§ 4) est le relevé de provenance de référence pour les pièces V-02/V-03/V-05/V-06/V-07.

| ID | Fichier courant | Objet lexical ou ontologique pertinent | Traitement recommandé dans ce chantier |
|---|---|---|---|
| V-02 | [Study: parallel fork/interleaving](2026-10-06-study-parallel-fork-interleaving.md) | Analyse historique de parallèle et vmap ; dépend de labels et schémas absents de main selon les annotations du lot. | Ne pas en faire une preuve ni source de candidats lexicaux sans vérifier chaque assertion contre C3/C4 courants. Garder pour la provenance de Par/Vmap. |
| V-03 | [Study: spawn time thread](2026-10-06-study-spawn-time-thread.md) | Analyse de spawn, temps et fils ; le lot indique que ses équations/théorèmes cités ne sont pas présents en main. | Garder comme historique de conception, non comme correspondance K/TLA+ établie. |
| V-05 | [T-68 vocabulary proposal archive](t68-vocabulary-proposal-archive-pr10.md) | Extraits de l'ancienne proposition en bloc et de son analyse contre le manuscrit. | Source historique unique pour consulter les candidats extraits ; les extraits originaux français en commit d39d012 restent la provenance exacte. Ne pas répéter son tableau dans d'autres notes. |
| V-06 | [Bibliographic checks, records 3–5](../bibliography/verifications-pr02-archive-pr10.md) | Vérifications bibliographiques liées aux sessions PR-02, y compris des revendications corrigées ou non concordantes. | Référence auxiliaire seulement ; pour une affirmation bibliographique, vérifier la notice courante et la publication elle-même. |
| V-07 | [Codes and premises archive](codes-and-premises-archive-pr10.md) | Table d'erreurs/prémisses, dont Guard et des codes d'erreur. | Source historique, pas une preuve que les règles/labels concernés existent dans main. |

### 5.3 Sources originales de la proposition T-68 (sur le commit d'archive)

La provenance précise est dans [L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 3.2–3.4 et § 4, avec les liens immuables vers d39d012. Les sources d'origine sont :

| Source originale | Permalien à l'archive | Contenu et statut |
|---|---|---|
| Proposition en bloc — source originale répertoriée au [lot de reprise PR #10](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 3.3–3.4 et § 4 (V-05) | Entrée de provenance canonique : table V-05 du lot de reprise, commit d'archive `d39d012ea77277bfd774f67985966fb6ba7340cf` | Registres K/N/S, règles de forme R-K/R-N, tableau de 49 lignes sur l'ancienne base, collisions et propositions. Les sections présentant la méthode « en bloc » comme décision sont écartées du dépôt traduit. Le lot de reprise conserve le permalien du fichier source exact. |
| Analyse face au manuscrit — source originale répertoriée au [lot de reprise PR #10](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 3.2 et § 4 (V-05) | Entrée de provenance canonique : table V-05 du lot de reprise, commit d'archive `d39d012ea77277bfd774f67985966fb6ba7340cf` | Analyse de collisions et d'applications à l'ancienne base. Le dry run, les anciens comptes et le plan de ratification groupée ont été écartés parce qu'ils ne tiennent pas sur main et ne sont pas ratifiés. Le lot de reprise conserve le permalien du fichier source exact. |
| CSV de renommage — source originale répertoriée au [lot de reprise PR #10](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 3.4 | Entrée de provenance canonique : table des scripts/T-68 set aside, commit d'archive `d39d012ea77277bfd774f67985966fb6ba7340cf` | Ancienne table de correspondance, comptes obsolètes ; set aside. Le lot de reprise conserve le permalien du CSV exact. |
| Table de renommage — source originale répertoriée au [lot de reprise PR #10](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 3.4 | Entrée de provenance canonique : table des artefacts T-68 set aside, commit d'archive `d39d012ea77277bfd774f67985966fb6ba7340cf` | Table et prose attachées à l'ancien registre ; set aside, ses éléments de comparaison sont partiellement extraits dans V-05. Le lot de reprise conserve le permalien du fichier exact. |
| Script `scripts/t68_renommer.py` | [Ouvrir le script d'archive](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/scripts/t68_renommer.py) | Lit l'ancien chemin docs/suivi et, avec --appliquer, réécrit spec depuis une proposition non ratifiée. **Ne pas exécuter ni réutiliser.** |
| Contrôle lexical homonyme, `scripts/controles/vocabulaire.py` dans l'archive | [Ouvrir le script d'archive](https://github.com/AntheaLiles/k7pl/blob/d39d012ea77277bfd774f67985966fb6ba7340cf/scripts/controles/vocabulaire.py) | Proposition ancienne non câblée ; son contenu n'est pas le contrôle lexical actuellement présent sous le même chemin dans main. **Ne pas confondre par le seul nom de fichier.** |

### 5.4 Analyses voisines conservées dans l'archive

Le lot PR #10 recovery liste 13 comptes rendus de session 21–33 et 16 notes d'analyse de décisions qui n'ont pas été déposés en entier. Certaines conclusions ont été reprises comme obligations sous C-01 à C-09 dans [L1-C-ARCHIVE-FINDINGS-INSTRUCTION-2026-10-14.md](../migration/L1-C-ARCHIVE-FINDINGS-INSTRUCTION-2026-10-14.md) ; elles ne sont pas des décisions normatives. Pour les détails, les lignes sources de d39d012 figurent dans le lot de reprise, §§ 3.1–3.3.

Les rapports de session de l'archive ne doivent pas être copiés en vrac dans docs/history : la séquence 21–33 y ferait collision avec la série courante PR-02 21–62. Le lot de reprise conserve les liens d'origine et les verdicts de dépôt, ce qui suffit comme index sans introduire une seconde série de rapports quasi identiques.

## 6. Sources Org-mode et ancien outillage

| ID | Source archive | Fonction historique | Autorité et conduite recommandée |
|---|---|---|---|
| A-01 | [README des archives](../archives/README.md) et [README du manuscrit Org](../archives/manuscrit-org/README.md) | Définissent le manuscrit Org du 1er octobre comme instantané historique et désignent spec/ (Verso) comme source de référence. | Ces README gouvernent la lecture des archives : ne jamais corriger l'Org pour modifier le langage courant. |
| A-02 | [Ancien glossaire](../archives/manuscrit-org/K7PL-glossary.org), [chapitre C3 Org](../archives/manuscrit-org/chapitres/c3-types.org), [chapitre C5 Org](../archives/manuscrit-org/chapitres/c5-syntaxe.org), [annexes Org](../archives/manuscrit-org/chapitres/annexes.org), [main.org](../archives/manuscrit-org/main.org) | Glossaire ancien, description des termes et des formes de surface au moment de la conversion Verso. | Témoin historique utile pour comparer les formulations et les noms ; toujours subordonné à la source Verso courante et aux décisions postérieures au 1er octobre. |
| A-03 | [Ancien contrôle croisé](../archives/outillage-org/outils/controles/croise.py) | Contrôle de la grammaire et du registre dans le dispositif Org. | Code archivé, non exécuté par la CI courante ; jamais une autorité pour le cardinal actuel. |
| A-04 | [Ancien contrôle du glossaire](../archives/outillage-org/outils/controles/glossaire.py), [correspondance](../archives/outillage-org/outils/correspondance.py), [registre](../archives/outillage-org/outils/registre.py), [corpus](../archives/outillage-org/outils/corpus.py) | Génération/contrôle du glossaire, rapprochement et suivi de littérature dans l'ancien système. | Source de la méthode historique et du chemin des données ; les sorties, comptes et bases de l'ancien système ne sont pas réutilisables sans recalcul sur les données actuelles. |
| A-05 | [données arcs.json](../archives/outillage-org/donnees/arcs.json), [refs.json](../archives/outillage-org/donnees/refs.json), [README de l'ancien outillage](../archives/outillage-org/README.md) | Cartes et données du système de travail antérieur. | Matériau d'archive ; les clés et résumés ne prouvent pas ce qu'une publication établit. Ne pas exécuter l'ancien outillage comme s'il s'agissait d'un générateur actuel. |
| A-06 | [Provenance de migration](../history/2026-10-07-provenance-migration.md) | Trace la migration meta/primitives.org vers docs/tracking/primitives.md, meta/arcG-methode.org vers docs/research/arc-g-methode.md, meta/questions.org vers docs/research/questions.md et meta/manques.org vers docs/research/manques.md. | Utiliser comme guide de provenance et de déduplication, jamais comme source des statuts courants. |

## 7. Comptes historiques non comparables

| Nombre | Source | Unité de compte | Verdict au 25 octobre 2026 |
|---:|---|---|---|
| 20/21 | Versions anciennes de la méthode Arc G et de certains plans de travail | Entrées d'une revue lexicale préliminaire / formes ou familles comptées dans un périmètre alors restreint. | Ne pas réutiliser comme cardinal normatif. |
| 33 | arc-g-methode.md et certaines notes d'août/septembre | Constructeurs annoncés par une ancienne extraction de grammaire. | Supplanté par le texte courant qui annonce 46 ; le contrôle doit être rapproché de toutes les formes écrites. |
| 44 | Intitulé historique « 44 primitives » repris dans des documents anciens. | Étiquette de chantier, non une mesure fiable. | Explicitement réconcilié comme historique dans L1-T68-AUDIT.md. |
| 45 | primitives.md / L1-T68-AUDIT.md | Entrées DOING du registre au 8 octobre. | Compte de lignes de registre uniquement. |
| 46 | Grammaire/texte C3 et EXPECTED dans croise.py | Constructeurs comptés par le contrôle et annoncés par le texte ; neuf valeurs et trente-sept calculs selon le texte. | La table EXPECTED n'inclut pas explicitement fix et declassify, pourtant écrits dans la grammaire. Le dossier relève 48 alternatives textuelles en les comptant, neuf valeurs et trente-neuf calculs. L'écart reste une obligation de contrôle, pas une décision de sémantique. |
| 49/50/53 | Proposition et rapports PR #10 sur commit d39d012 | Lignes ou règles comptées sur la base d'archive et sa grammaire antérieure. | Comptes de l'archive ; leur base diffère de main et ils ne doivent pas être transposés. |

Les nombres ne doivent jamais être mis en colonne comme s'ils mesuraient la même chose. L'audit final de cardinalité doit être reconstruit à partir de la grammaire, des règles et des obligations actuelles.

## 8. Décisions et contradictions à garder visibles

1. **Proposition en bloc non ratifiée.** Le registre courant laisse ouvert le choix de la méthode de T-68 ; l'archive dit que la méthode en bloc aurait été retenue, mais cette attribution est explicitement non confirmée par main.
2. **Noms K, lemmes N et formes de surface S distincts.** L'archive K/N/S fournit une distinction utile ; elle ne prescrit pas que le français, le token canonique et les verbes de surface partagent un nom.
3. **at / at_n.** La collision est documentée dans l'archive et signalée par les sources courantes ; les candidats current, placed_n ou autres restent historiques, non ratifiés.
4. **open / unpack.** Le token open est dans la grammaire courante ; unpack apparaît dans la prose et la proposition d'archive. Aucun renommage n'est autorisé par cet inventaire.
5. **operation/scoped vs perform/handle/handler.** La source C3 actuelle explique une différence de niveau ontologique ; la collecte historique la reprend, mais une décision de surface ne remplace pas la définition formelle.
6. **Vec / VecI / VecE / vmap.** Le type Vec est historiquement qualifié de dérivé ; cette qualification ne prouve pas que ses règles ou la famille de pli indexé gradué soient dérivées.
7. **ν / Out / Cop.** La séance du 9 septembre annonce les règles coinductives ; C3 actuel porte eq:regles-nu ; le registre contient encore un texte disant que les règles manquent. Rapprocher le registre au lieu de reprendre l'ancienne note.
8. **Formes temporelles et When.** Les désaccords de catégorie syntaxique, de typage, d'attente environnementale et de correction de ressource restent séparés sous D-T1/D-T2 et les obligations C. Aucun QCM lexical ne les ferme.
9. **Le contrôle du vocabulaire n'est pas l'audit des primitives.** Le script actuel de contrôle lexical vise une politique de mots interdits ; le script T-68 archivistique de renommage modifiait les tokens. Même nom historique ou homonymie de fichier n'implique pas une même fonction.

## 9. Politique de nettoyage des sources historiques

Le nettoyage doit maintenant suivre un seul registre d'inventaire et ne pas lancer de migration globale.

### Phase 1 — réalisée par ce dossier

- Regrouper les sources par filiation, statut et utilité.
- Établir les liens entre les documents vivants, leurs versions historiques et la PR/branche d'origine.
- Marquer les sources d'autorité et les propositions non ratifiées.
- Éviter les duplications : V-05 est la porte d'entrée pour la proposition T-68 déposée ; le lot L1-PR10 conserve ses liens à toutes les pièces originales.

### Phase 2 — hygiène non destructive des sources historiques (en cours)

**Première passe réalisée le 25 octobre 2026** : des bandeaux de statut et un renvoi vers le présent inventaire ont été ajoutés aux sept sources anciennes les plus directement susceptibles d'être réutilisées pour le vocabulaire ou le corpus :

- [Méthode Arc G](arc-g-methode.md) et [collecte Arc G](arc-g-collecte.md) : instantanés datés, méthode/collecte non normative et noms non ratifiés.
- [Ensembles de questions](questions.md) et [manques de corpus](manques.md) : états historiques et balises à revérifier avant de rouvrir une question ou une acquisition.
- [Liste de chargement](../bibliography/a-charger.md) et [sourçage des manques](../bibliography/a-sourcer-manques.md) : listes d'acquisition datées, pas backlog courant.
- [Sourçage du nommage](../bibliography/a-sourcer-nommage.md) : piste empirique explicitement non bloquante pour l'Arc G achevé.

Cette intervention est volontairement additive : elle conserve le texte, mais pose devant le lecteur le statut temporel et le point d'entrée courant. Les documents de `docs/history/` possèdent déjà leur propre index et leur bannière d'archive ; l'inventaire les référence sans copier leurs contenus. Les sources originales de PR #10 restent consultables par les permaliens inscrits dans le registre de reprise, et aucune copie supplémentaire n'est créée.

**Reste à faire**, par lots limités : vérifier les analyses de recherche voisines qui ne sont pas propres au vocabulaire, remplacer les résumés répétés de T-68 par des renvois vers V-05/inventaire là où ils n'apportent rien de distinct, puis ne supprimer une note que si sa provenance et ses objections sont déjà préservées dans une source de remplacement. Ne pas réécrire les analyses historiques ni lancer de nettoyage global.

### Phase 3 — réduction contrôlée de la duplication

- Garder les sources Org et l'ancien outillage dans docs/archives comme témoins de conversion, sans les promouvoir en entrée du chantier lexical.
- Garder les originaux de PR #10 accessibles par permalien au commit d39d012 ; ne pas recoller les treize sessions ni les notes d'analyse entières dans docs/history.
- À l'intérieur des documents vivants, remplacer les longs résumés répétés de la proposition en bloc par un lien vers V-05 et vers cet inventaire, sans supprimer les objections qui n'apparaissent nulle part ailleurs.
- N'effacer une note qu'après avoir confirmé que sa provenance, ses objections et son statut sont repris dans une source de remplacement. Les pièces qui portent un résultat négatif doivent demeurer consultables.

### Phase 4 — critères de fin

- Le présent inventaire est lié depuis docs/RESEARCH.md et depuis le rapport, le registre ontologique, le catalogue QCM, le registre de décisions et le plan de clôture.
- Aucune note historique ne sert de source de vérité lorsque la spec ou un registre courant contient l'objet équivalent.
- Chaque proposition lexicale a un seul point d'entrée historique, un statut et la définition courante à laquelle elle doit être confrontée.
- Aucun ancien script de renommage n'est appelé ; aucun changement de nom n'est effectué sans décision d'autrice et autorisation d'intégration normative.
- Le nettoyage documentaire ne supprime aucune divergence : la divergence est soit résolue contre la source actuelle, soit indexée comme obligation ouverte.

## 10. Références d'accès rapides

- [Spécification courante — C3, grammaire et typage](../../spec/Spec/C3/GrammaireDesTermes.lean)
- [Audit de minimalité T-68](../migration/L1-T68-AUDIT.md)
- [Registre courant des décisions](../tracking/DECISIONS.md)
- [Registre courant des primitives](../tracking/primitives.md)
- [Fichier de reprise PR #10](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md)
- [Instruction scientifique des constats d'archive](../migration/L1-C-ARCHIVE-FINDINGS-INSTRUCTION-2026-10-14.md)
- [Index des archives Org](../archives/README.md)
- [Index des documents historiques](../history/README.md)
- [Index de la recherche](../RESEARCH.md)
