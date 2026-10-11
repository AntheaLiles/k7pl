<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# C-09 — Audit de provenance et d'instanciation des dépendances externes

**Statut :** audit documentaire provisoire ; C-09 et la porte C restent ouverts.  
**Révision de base examinée :** main — 1dc5beb460a426a2974c0415766670f9ed25c510 (11 octobre 2026).  
**Périmètre :** dépendances formelles invoquées par les objets théoriques de C, de C1 à C3 en priorité, et sources temporelles/fondationnelles mentionnées dans le dossier de sédimentation.  
**Limite :** cet audit n'ajoute aucun import normatif dans spec/, ne transforme pas une preuve externe en preuve K7PL et ne ratifie aucune décision à la place de l'autrice.

## 1. Conclusion de contrôle

Le dépôt contient plusieurs citations pertinentes et certains engagements de statut dans les registres. Il ne contient pas encore, pour chaque dépendance effectivement invoquée, la chaîne complète suivante :

**source/version → hypothèses → résultat externe → fragment K7PL → traduction/instanciation → propriété K7PL démontrée.**

La bibliographie atteste qu'une source est connue ; une citation dans spec/ atteste qu'elle est invoquée ; ni l'une ni l'autre ne démontre à elle seule la correspondance requise. La revue C-01/C-02 indique qu'aucun objet Lean correspondant aux signatures et lois centrales examinées n'a été identifié dans src/. Les résultats portant sur des systèmes externes en Agda, une sémantique catégorique ou un modèle de récursion gardée doivent donc être traités comme des résultats conditionnels de ces systèmes, pas comme des théorèmes K7PL.

**Décision de sortie : NON SATISFAITE.** L'inventaire et les lacunes sont précisés ci-dessous ; plusieurs obligations d'instanciation restent manquantes, et certains imports historiquement dits « validés » demeurent en attente d'une décision explicite quant à leur rôle exact dans le manuscrit.

## 2. Classes de preuve employées

| Marque | Ce qu'elle permet d'affirmer | Ce qu'elle ne permet pas d'affirmer |
|---|---|---|
| Référence primaire/version identifiée | Le résultat externe exact peut être relu et ses hypothèses contrôlées. | Que les hypothèses valent pour K7PL. |
| Citation active dans spec/ | Le texte de spécification invoque cette source à cet endroit. | Que le théorème cité soit prouvé pour K7PL ou que sa transposition soit valide. |
| Mapping écrit mais candidat | Une traduction envisagée entre la source et K7PL est explicite. | Que la traduction est normative ou satisfait les lois requises. |
| Proposition / preuve-esquisse dans Verso | Un énoncé et une piste de preuve sont exposés. | Une preuve mathématique complète, ou une preuve Lean. |
| Compilation / CI / test | Les contrôles exécutés réussissent dans leur périmètre. | La correction de l'argument scientifique ou la fidélité d'une instanciation absente. |

## 3. Matrice des dépendances pertinentes pour C-09

Cette matrice ne prétend pas inventorier toutes les références bibliographiques des chapitres C1–C3. Elle recense les sources qui soutiennent explicitement le cadre modal, la gradation, l'exponentielle catégorique, le coût et la temporalité, ou dont l'import a été spécialement proposé dans les registres PR-02/L1.

| Source / version repérable | Hypothèses et résultat externe disponible | Appel et fragment K7PL | Mapping et instanciation visible sur la base auditée | Statut C-09 |
|---|---|---|---|---|
| **Théorie des modes — Licata, Shulman, Riley (FSCD 2017), DOI [10.4230/LIPIcs.FSCD.2017.25](https://doi.org/10.4230/LIPIcs.FSCD.2017.25)** | Cadre calculatoire paramétré par une théorie des modes. L'admissibilité de l'identité et de la coupure est démontrée indépendamment du choix de théorie des modes dans ce cadre. Cela ne valide pas une théorie modale K7PL particulière sans en construire l'instance. | spec/Spec/C3/LeSystemeGradue.lean, autour de la ligne 174 : justification du cadre général, pas preuve des règles K7PL. | Le texte K7PL définit ses propres grades, permissions et règles. La citation seule ne démontre pas un morphisme entre la théorie des modes externe et tous les jugements/règles K7PL. | **Fondement cité ; instanciation K7PL ouverte.** |
| **Définition GRASS des modes — Hanukaev, Eades III, *A unification of graded and substructural logics*, arXiv [2605.17112v1](https://arxiv.org/abs/2605.17112v1), 2026** | Le préprint définit un mode m=(Rₘ, Cont(m), Weak(m)) : algèbre de grades, idéal de contraction et prédicat d'affaiblissement, avec conditions sur les morphismes. Les règles, opérations et résultats sont ceux de GRASS, non ceux de K7PL par défaut. | C3, autour des lignes 117–157, et C2, autour de la ligne 640. thm:morphismes_modes reste state=under-review, evidence=proofsketch. | K7PL propose M_Lin=(ℛ,{0},false), M_Aff=(ℛ,{0},true), M_Rel=(ℛ,ℛ,false) et M_Unr=(ℛ,ℛ,true), puis quatre flèches candidates par l'identité sur le porteur. Le croquis vérifie certaines inclusions si ℛ possède les structures annoncées ; il ne démontre pas que les permissions sont réalisées par les règles de jugement et de typage, ni la cohérence avec le sous-typage modal. Rel reste absent des règles génératrices courantes. | **Source précise et utilisée ; proposition K7PL non établie.** |
| **Types gradués dépendants formalisés — Abel, Danielsson, Eriksson, ICFP 2023, DOI [10.1145/3607862](https://doi.org/10.1145/3607862)** | Formalisation Agda d'une théorie précise de types dépendants gradués, avec semi-anneau partiellement ordonné, univers et effacement. La préservation du typage/grades et la décidabilité de l'égalité définitionnelle concernent la syntaxe, les règles, les modalités et hypothèses de cette théorie. La correction de l'effacement est limitée à certaines modalités et conditions ; ce n'est pas un théorème uniforme pour toute gradation. | spec/Spec/C3/LeSystemeGradue.lean, au début du chapitre autour de la ligne 31 ; spec/Spec/C3/LesContraintesDeValeur.lean invoque les limites de l'effacement. | K7PL reprend le patron semi-anneau/contexte gradué mais utilise ℛ=ℚ≥0∪{ω}, un grade complet 𝒢=ℛ×𝕄×ℒ×𝔅, un ordre mixte et des effets temporels. BIB-21 laisse précisément à vérifier la restriction sur les instances qui affectent l'égalité définitionnelle par rapport au produit mixte et aux coercions K7PL. Aucun transfert de théorèmes ni correspondance Lean/Agda n'est identifié. | **Fondement normatif déclaré dans L1 ; transposition formelle ouverte ; vérification bibliographique encore partielle.** |
| **Types modaux gradués / Granule — Orchard, Liepelt, Eades, ICFP 2019, DOI [10.1145/3341714](https://doi.org/10.1145/3341714)** | Présente des types modaux gradués pour le raisonnement quantitatif sur les programmes et un outillage propre à Granule. Les propriétés mécanisées sont celles de la formalisation et des opérateurs supportés par cette source. | C1, autour de la ligne 197, et C3, autour de la ligne 25 : provenance explicite de l'approche « modalité comme grade ». | La source motive l'approche, mais ne démontre ni les règles K7PL à effet traversant, ni la structure produit 𝒢, ni les lois de substitution, coercion ou coût. Aucun port formel Granule → K7PL n'est fourni. | **Précédent conceptuel effectivement cité ; pas une preuve d'instanciation.** |
| **Exponentielles linéaires bornées généralisées — Fukihara, Katsumata, FoSSaCS 2021, [notice / DOI Springer](https://doi.org/10.1007/978-3-030-71995-1_12)** | Le modèle utilise une structure graduée multi-objet et des comonades exponentielles linéaires indexées dans le cadre GBLL/GBAL. Les lois et conclusions supposent cette structure de grades et les données catégoriques de l'article. | C2, lignes initiales et autour de la ligne 315 : justification d'une exponentielle indexée ; définitions locales de !:I→End(𝒞), counité w, comultiplication c et coercions. | Le texte distingue correctement I=ℛ de l'annotation complète 𝒢. π_U:𝒢→ℛ, Bang_𝒢 et Scale_Usage restent des ponts candidats. Les domaines exacts et lois de coerce, sa naturalité, les compatibilités avec w et c, et l'instanciation K7PL ne sont pas établis par la citation. C2 précise que les lois de comonade graduée sont posées comme axiomes de structure, distinctement du théorème de cohérence catégorique. | **Dépendance formelle pertinente ; correspondance et lois K7PL ouvertes.** |
| **Calf — Niu, Sterling, Grodin, Harper, POPL 2022, DOI [10.1145/3498670](https://doi.org/10.1145/3498670), version arXiv [2107.04663](https://arxiv.org/abs/2107.04663)** | Cadre logique conscient du coût qui distingue phase extensionnelle et intensionnelle et établit, dans son système et son modèle, une propriété de non-interférence interne entre comportement et comptage du coût. Les preuves et mécanisations annoncées concernent Calf/Agda et ses définitions. | spec/Spec/C1/AxiomatiqueGerminale.lean, autour de la ligne 685, cite la non-interférence pour motiver la séparation comportement/coût. | K7PL n'expose pas de traduction des jugements de Calf, de son effet de coût ou de sa sémantique vers les jugements et effets K7PL. Le résultat Calf ne prouve donc pas la propriété correspondante pour K7PL ; la portée de la phrase dans le manuscrit doit être bornée par la preuve K7PL disponible. | **Citation active ; transfert K7PL à justifier.** |
| **Decalf — Grodin, Niu, Sterling, Harper, POPL 2024, DOI [10.1145/3632852](https://doi.org/10.1145/3632852)** | Extension effectful de Calf, incluant notamment choix probabiliste et état ; le coût est lui-même exprimé comme programme/bornage dans le cadre Decalf. La correction invoque le modèle présenté par les auteurs. | La référence figure dans BIB-20, L1-THEORY-SEDIMENTATION.md et les historiques PR-02. La recherche ciblée de la spécification active C1–C3 n'a pas établi une invocation directe de Decalf comparable à la citation Calf ci-dessus. | Aucun mapping Decalf → effets K7PL, ni résultat K7PL instancié, n'a été localisé. La présence en bibliographie et une validation rapportée en séance ne suffisent pas à en faire un import formel actif. | **Dépendance proposée/historique ; usage actif non établi ; décision de l'autrice en attente.** |
| **Récursion gardée multi-horloges / CloTT — Bizjak et al., *Guarded Dependent Type Theory with Coinductive Types*, FoSSaCS 2016, DOI [10.1007/978-3-662-49630-5_2](https://doi.org/10.1007/978-3-662-49630-5_2) ; sémantique CloTT de Mannaa et Møgelberg, [arXiv 1804.06687](https://arxiv.org/abs/1804.06687)** | Le cadre externe utilise une modalité de retard, des horloges, des règles de ticks et une sémantique dédiées à la récursion gardée/co-induction. Ses garanties de productivité ou de métathéorie sont conditionnelles à ses règles et à son système. | Dans les sources actives C2–C3 examinées, les références à la récursion structurée, aux points fixes et aux copatterns sont distinctes ; l'audit n'a pas établi que CloTT soit l'instance formelle des règles K7PL. CloTT apparaît dans BIB-22 et l'étude d'opportunité historique. | K7PL comporte ○S, □S, ◇S, delay, now, wait et when, ainsi qu'une sémantique d'effets/calendriers. Le mapping ▷ᵏ → ○ noté dans l'étude historique ne constitue pas une traduction préservant typage/progression/productivité. Aucun dossier complet couche → construction → invariant → règle → propriété → preuve/formalisation n'est présent. Les ticks CloTT ne sont ni le compteur de coût K7PL ni, par défaut, ses effets W,D. | **Mécanisme externe à instruire par couche ; pas d'instanciation K7PL démontrée.** |
| **Hypothèses algébriques invoquées via HUANG — entrée actuelle : Yulong Huang, *QTAL: A Quantitatively and Dependently Typed Assembly Language* (2023)** | C2 cite cette entrée après les conditions « zéro-somme » et « zéro-produit » du semi-anneau, utilisées dans l'argument de substitution. L'entrée bibliographique HUANG ne donne actuellement ni DOI ni URL/version primaire directement vérifiable. QTAL et les propriétés algébriques de ℛ ne doivent pas être confondus : la preuve que ℛ satisfait ces propriétés doit être portée par K7PL ou par une source établissant ces résultats exacts. | C2, autour des lignes 52–58 ; C3 ReglesDeTypage.lean, autour de la ligne 81, invoque HUANG à propos de l'identité de support des contextes. | Le texte exige les hypothèses, mais la provenance versionnée est incomplète et le mapping de chaque propriété source vers les règles K7PL n'est pas documenté. ℛ contient les rationnels positifs et ω, alors que les résultats sur ℕ∞ portent sur le sous-ensemble conaturel. | **Contrat algébrique pertinent ; référence/version et transfert à compléter.** |
| **Catégorie fermée / cohérence — Benton (1993), Kelly (1971), sources citées en C2** | Ces sources soutiennent la construction catégorique linéaire/fermée et la cohérence des isomorphismes dans une catégorie symétrique monoïdale fermée sous leurs hypothèses structurelles. | C2, vers les lignes 596–608, dit que le théorème de cohérence est assumé pour les diagrammes catégoriques concernés, mais que les lois de la comonade graduée sont des axiomes de la structure adoptée. C2/C1 relient ce cadre à P1a. | Une catégorie 𝒞 et les opérations catégoriques établissent le cadre annoncé (P1a) ; elles ne construisent pas automatiquement l'interprétation ⟦-⟧𝒞 des jugements K7PL, sa correction, ni le lien avec la compilation. | **P1a — cadre/postulat annoncé ; P1b — interprétation/correction non établie.** |
| **Conteneurs indexés / points fixes — Altenkirch et al. (2009) ; D'Amato et al. (2024), sources citées en C2** | Sources de construction sur conteneurs indexés et propriétés de points fixes dans leurs cadres précis. Les conclusions dépendent des hypothèses faites sur les foncteurs, les conteneurs et les catégories. | spec/Spec/C2/AdjonctionsEtEnrichissement.lean, autour des lignes 46 et 63, invoque les conteneurs indexés et la conservation de points fixes. Le chapitre C2 des algèbres/coalgbères utilise aussi la littérature sur les points fixes imbriqués. | Il manque un relevé, constructeur par constructeur, établissant que les types/foncteurs K7PL visés appartiennent à la classe couverte et que les hypothèses sont préservées par les extensions K7PL. Cela ne remplace pas les obligations sur la récursion gardée ou P1b. | **Sources de construction utilisées ; domaine d'application K7PL à tracer.** |

## 4. Mapping formel exigé — points où la chaîne se rompt

### 4.1 Modes et permissions structurelles

La chaîne revendiquée est :

**théorie des modes → algèbres/idéaux/prédicats → morphismes → permissions des règles → cohérence de typage → propriété métathéorique.**

L'instanciation candidate M=(R,Cont,Weak) et le croquis de thm:morphismes_modes n'en couvrent qu'une partie. Restent à établir :

1. les structures algébriques et idéaux requis pour le ℛ effectivement retenu ;
2. les morphismes et leur conformité au contrat de la source ;
3. le fait que les règles de contexte/typage réalisent ces permissions, en particulier pour Rel et les échanges ;
4. leur cohérence avec ≼, l'ordre mixte du grade complet et les conversions ;
5. la distinction entre ces propriétés et une simple inclusion des intervalles de grades.

L'admissibilité de coupure du calcul paramétré de Licata et al. ne comble pas ces étapes pour la présentation K7PL.

### 4.2 Gradation, substitution et coercions

Le mapping recherché est :

**algèbre de grades externe → ℛ → grade complet 𝒢 → contextes et règles → substitution/effets/coercions → preuve.**

La source d'Abel et al. prouve des propriétés d'une théorie graduée formalisée en Agda. Pour s'en servir au-delà d'une analogie, il faut donner une traduction entre syntaxe, grades, modalités, règles et hypothèses. Cette traduction doit traiter le produit mixte d'ordres, la coordonnée de confidentialité, le budget, les effets temporels et l'usage de ω. Les propriétés des conaturels ne s'étendent pas de plein droit à ℚ≥0∪{ω}, dont l'ordre n'est pas bien fondé sur les rationnels positifs.

Pour l'exponentielle, il faut spécifier une instance dont I, les opérations d'indices et les domaines de coerce sont définis, puis établir les lois effectivement invoquées : identité/composition des coercions, naturalité en l'objet, compatibilités avec w et c, fonctorialité et compatibilité à la substitution. Les audits C-01/C-02 et C-03 détaillent ces obligations. La notation d'une comonade indexée dans la littérature n'est pas une preuve de l'instance.

### 4.3 P1a n'est pas P1b

- **P1a — cadre catégorique annoncé :** la spécification déclare une catégorie ambiante 𝒞, les objets/types, les morphismes/programmes purs et la structure fermée requise. Les théorèmes de cohérence catégorique sont mobilisables uniquement dans leur domaine.
- **P1b — interprétation et correction :** il faut définir la traduction ⟦-⟧𝒞 des termes, jugements et dérivations K7PL, préciser son domaine et ses hypothèses, puis prouver les propriétés de correction invoquées — au minimum le lien entre typage/réduction et interprétation. Les revendications plus fortes exigent leurs propres preuves.

La mention « transparent au sens de P1a » peut être une affirmation sur l'isomorphisme catégorique choisi ; elle ne doit pas être reformulée comme correction de compilation ou préservation sémantique sans P1b. Aucun import examiné ne ferme P1b par simple transfert bibliographique.

### 4.4 Calf/Decalf et récursion gardée : mécanismes, non règles K7PL importées

Pour Calf/Decalf, il faut identifier la construction utilisée, les types/jugements traduits, les hypothèses empruntées et le théorème obtenu. Une propriété de non-interférence coût/comportement dans Calf/Decalf n'est réutilisable dans K7PL qu'après une interprétation et une preuve reliant les systèmes.

Pour CloTT, il faut établir, par couche, une traduction qui préserve les jugements et la notion de progression pertinente. La modalité de retard et les ticks de CloTT ne sont ni le compteur de coût K7PL ni, par défaut, ses effets W,D. La productivité d'un programme CloTT ne prouve pas la productivité ou la terminaison d'une règle K7PL qui n'a pas été traduite.

## 5. Décisions d'auteur à ne pas inférer

1. **Ratifier le statut normatif de la famille modale et graduée.** L1-DECISIONS enregistre les théories des modes et des types gradués formalisés comme NORMATIF. Toutefois, docs/tracking/DECISIONS.md indique encore que l'arbitrage ARB-PR-07 (famille modale et graduée plutôt que socle HoTT) doit être ratifié et motivé au §1.2 ; les imports ciblés dits « validés » en séance ne sont pas tous versés au texte. Cette différence de statut documentaire doit être arbitrée, pas résolue par cette revue.
2. **Calf versus Decalf.** Confirmer si Decalf est une dépendance effectivement utilisée, une piste de construction ou une source comparative seulement. Ne pas ajouter une règle K7PL sur la seule base de BIB-20.
3. **Récursion gardée multi-horloges.** Confirmer si cet import est retenu malgré le fait que le lien historique avec BLOQ-06 a été résolu autrement. À défaut, le garder comme mécanisme candidat/historique, sans prétendre qu'il est la base des règles temporelles.
4. **P1b.** Déclarer la portée attendue de l'interprétation et de sa correction, puis produire les définitions/preuves correspondantes. P1b ne peut pas être ratifié comme théorème par ce dossier.
5. **Ponts du grade complet.** La promotion normative de π_U, Bang_𝒢 et Scale_Usage, le choix du domaine total/partiel de Cost_Budget et les lois de coercion/substitution/effets restent des questions humaines ou obligations scientifiques distinctes, comme l'indique le registre C. Ce dossier n'en choisit aucune.
6. **Référence HUANG.** Fournir une version primaire directement consultable et relier précisément le résultat emprunté aux propriétés algébriques concernées ; ne pas inférer une garantie depuis une entrée bibliographique sans version.
7. **Périmètre du résultat gradué formalisé.** Décider si la version 2023 seule est la source retenue. La mention historique d'une version étendue 2026 ne justifie son emploi que si elle est identifiée, vérifiée et reliée au manuscrit.

## 6. Obligations de clôture C-09

C-09 ne sera clos que lorsque chaque import effectivement utilisé dans les objets C disposera d'une fiche vérifiable comportant :

- la référence primaire et la version exacte réellement employée ;
- les définitions, théorèmes externes sollicités et hypothèses nécessaires, sans élargir leur portée ;
- le fragment K7PL et chaque objet/règle qui en dépend ;
- une traduction ou instanciation définie avec domaines, codomaines et conditions de préservation ;
- la preuve qu'elle satisfait les hypothèses externes, ou l'énoncé explicite des hypothèses K7PL encore ouvertes ;
- la propriété K7PL exacte que la dépendance permet d'établir et son niveau de preuve ;
- le statut normatif ou instrumental, séparé du statut de preuve ;
- la ratification humaine des choix de fond lorsque requise.

Les sources citées mais non employées doivent rester références de contexte, pas devenir des dépendances formelles artificielles. Les imports annoncés en séance mais non versés au manuscrit doivent rester des décisions en attente. Aucune duplication de bibliographie dans spec/ n'est requise par le présent audit.

## 7. Contrôles et limites

- Sources primaires/versionnées consultées pour les affirmations centrales : Licata–Shulman–Riley (2017), Hanukaev–Eades (arXiv v1, 2026), Abel–Danielsson–Eriksson (ICFP 2023), Orchard–Liepelt–Eades (ICFP 2019), Fukihara–Katsumata (2021), Niu et al. (POPL 2022), Grodin et al. (POPL 2024) et sources de théorie gardée citées ci-dessus.
- Les sources actives ont été examinées par leurs fichiers/révisions sur main ; les citations ont été distinguées des résultats formels propres à K7PL.
- Le registre bibliographique identifie HUANG comme QTAL 2023 sans DOI ou URL/version primaire directe dans cette entrée.
- La revue BIB-21 confirme le patron gradué Agda mais laisse explicitement incomplète la vérification de l'égalité définitionnelle par rapport au produit mixte.
- Aucun résultat de cette revue n'est une nouvelle preuve mathématique ou Lean. Aucune conclusion de correction de bout en bout, de productivité K7PL ou de conformité spécification–implémentation n'est revendiquée.
- La CI doit être évaluée sur le SHA exact de la proposition documentaire. L'absence de statut/check-run observé ne doit pas être rapportée comme une réussite.

**Résultat :** inventaire et lacunes explicités ; critères scientifiques de clôture de C-09 non satisfaits. **La porte C demeure NON SATISFAITE.**