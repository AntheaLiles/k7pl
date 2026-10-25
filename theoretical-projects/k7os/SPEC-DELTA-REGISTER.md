<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Registre provisoire des évolutions de la spécification après R0–R9

**Date de rédaction :** 2026-10-24  
**Mise à jour D-01/D-02 :** 2026-10-25 ; D-01 intégré par la fusion de la PR #302, merge commit `662d14c3494834517c70125ed11953923514738a`. Les changements en cours sur D-02 sont proposés dans une PR distincte et ne sont pas encore intégrés à main.

**Statut :** document de travail non normatif ; registre initial, incomplet par construction.  
**Révision de rédaction initiale :** `AntheaLiles/k7pl@6062a683aa8c14c9bb396632ec070cba69c90623`.
**Base de consolidation de la PR #300 :** `AntheaLiles/k7pl@76d8c1c5cb54ebaa6ab43d78b53979f63a0de8fd`.
**Périmètre :** évolutions à examiner pour la spécification K7PL, son modèle formel et sa future toolchain MLIR/LLVM. Aucune modification normative n'est décidée par ce document.

## 1. Objet et règle de lecture

Ce registre transforme les résultats de recherche R0–R9 et les décisions de conception exprimées au cours des échanges en un inventaire traçable des compléments, ajustements, clarifications et obligations de preuve à instruire dans la spécification.

L'objectif premier est la fiabilité du **langage K7PL et de sa toolchain**. L'OS envisagé en K7PL est un cas d'étude exigeant, utile pour révéler les lacunes de la sémantique, des types, des capacités, des effets, de la concurrence et de la compilation. Il ne doit pas devenir une spécification indépendante qui dicterait prématurément le langage ou choisirait son matériel. Les variantes d'architecture, les mécanismes système et les objectifs de réalisation déjà étudiés sont conservés séparément dans [K7OS — Exploration conjointe](K7OS-EXPLORATION-CONJOINTE.md), afin que leur retrait d'une clause normative ne soit pas interprété comme un abandon de la cible.

Le registre distingue quatre états qui ne sont pas interchangeables :

- **Constat documentaire** : le texte ou l'artefact décrit quelque chose ; cela n'établit pas sa correction.
- **Définition/formalisation présente** : une structure ou un jugement existe dans les sources Lean ; sa portée doit être lue dans le code.
- **Résultat démontré** : un théorème est effectivement vérifié dans le noyau Lean ou un autre outil dont la portée est explicitée.
- **Obligation ouverte** : hypothèse, définition, preuve, validation ou relation de correspondance encore nécessaire.

Les étiquettes Verso telles que `under-review` et `proofsketch`, une compilation réussie, un test, un modèle borné ou un job CI ne doivent pas être présentés comme un théorème général. Les identifiants SPEC-D-xx de ce registre sont provisoires : ils ne sont ni des identifiants normatifs ni des noms de théorèmes à créer immédiatement.

Ce document ne prescrit pas encore la rédaction définitive des clauses normatives. Pour chaque ligne, l'étape suivante est : relire la source courante, établir le besoin exact, choisir le niveau normatif adéquat, fixer les dépendances, puis définir des critères de clôture vérifiables.

## 2. Provenance et limites de la consolidation

Le registre a été rédigé initialement à partir de la révision `6062a683aa8c14c9bb396632ec070cba69c90623` et des rapports disponibles alors. Pour la présente mise à jour sur la PR #300, la base de comparaison de la spécification est `main@76d8c1c5cb54ebaa6ab43d78b53979f63a0de8fd` (2026-10-24). Ce SHA est une base de travail pour cette PR, pas l'affirmation que tous les fichiers normatifs ont fait l'objet d'un nouvel audit exhaustif.

Les dossiers R0–R9 sont désormais tous présents dans le dépôt de travail. Les PR R4 et R5, ouvertes lors de la rédaction initiale du registre, ont été fusionnées avant cette révision :

- R4 — [PR #286, concurrence, protocoles, vivacité et annulation](https://github.com/AntheaLiles/k7pl/pull/286), fusionnée le 2026-10-24 à 12:49:29 UTC ; commit de fusion `7db485bdeba67195a3827406d5c4b6449c54af32`.
- R5 — [PR #287, permissions mémoire, emprunt, aliasing et logique de séparation](https://github.com/AntheaLiles/k7pl/pull/287), fusionnée le 2026-10-24 à 12:52:26 UTC ; commit de fusion `76d8c1c5cb54ebaa6ab43d78b53979f63a0de8fd`.

Leur présence dans `main` établit l'intégration des **rapports de recherche**, non celle de leurs recommandations dans les clauses normatives. Les sources d'analyse de R0–R9 sont des snapshots de dates et de commits différents ; les liens doivent être lus comme provenance de la recherche. Avant de modifier une règle normative ou de déclarer une obligation close, il faut confronter la clause à la tête courante, établir ses hypothèses et vérifier l'artefact de preuve pertinent.

Les éléments d'architecture système retirés ou rendus non prescriptifs ne doivent pas disparaître. Le dossier [K7OS — Exploration conjointe](K7OS-EXPLORATION-CONJOINTE.md) les conserve comme cibles historiques, variantes de réalisation, mécanismes candidats et obligations ouvertes. Le registre présent reste centré sur les évolutions du langage K7PL, de son modèle formel et de sa toolchain ; le dossier K7OS garde les options propres au système d'exploitation. Les deux se référencent sans confondre une option d'architecture avec une exigence normative du langage.

## 3. Décisions et contraintes de conception déjà exprimées

Les points suivants doivent guider le dépouillement ; ils ne valent pas preuve de faisabilité.

1. **Finalité.** Consolider K7PL comme langage fiable et sa future toolchain. L'OS est un cas d'étude, pas la finalité normative première.
2. **Profils de menace.** Utiliser plusieurs familles indépendantes de profils, sans imposer une échelle unique. La relation entre profils, leur éventuelle composition et les garanties communes restent à préciser.
3. **Domaines adversariaux examinés.** Autres composants logiciels, pilotes, périphériques DMA et firmware/chaîne de démarrage. Pour la première portée normative, les canaux temporels et auxiliaires sont modélisés séparément ; le modèle de panne doit être décomposé par extension.
4. **Démarrage.** Firmware et chaîne de démarrage sont exclus de la garantie initiale sous réserve d'énoncer les préconditions sur l'état initial et les composants de confiance. Une exclusion ne vaut pas hypothèse tacite de sécurité.
5. **Natif et FFI.** Deux profils sont requis : natif de confiance sous contrat et natif potentiellement hostile. Une signature typée ou une capacité logique ne constitue pas seule un mécanisme de confinement.
6. **Sûreté.** La cible envisagée couvre les propriétés essentielles du langage ; la progression doit rester conditionnelle aux hypothèses adéquates et distinguée de la sûreté mémoire.
7. **Zones unsafe.** Les obligations de l'implémenteur et de l'appelant sont toutes deux normatives. Le sens exact des comportements indéfinis dans ces zones reste ouvert : unsafe ne doit pas devenir une permission générale de sortir de la sémantique.
8. **Compilation.** Le contrat source-vers-binaire doit être formulé dès le départ et prouvé progressivement. Les étapes non prouvées doivent être identifiées et leur confiance documentée.
9. **Abstraction et réalisation.** La machine abstraite normative doit être distincte des profils concrets. Aucun matériel n'est choisi dans ce registre.
10. **DMA et autorité matérielle.** L'autorité effective d'un périphérique doit être traitée explicitement ; son contrôle par des capacités matérielles est une exigence à évaluer au niveau du contrat, sans sélectionner ici une technologie.
11. **Grades et budgets.** Ne pas ajouter de coordonnée aux grades au seul motif qu'une propriété reste ouverte. Déterminer d'abord si elle relève de la sémantique graduée, d'un contrat distinct, de la compilation, du runtime ou d'une hypothèse de plateforme.
12. **Temps.** Travail, profondeur, budget abstrait, coût machine, WCET, échéance et latence d'attente environnementale sont des notions distinctes. La décision de recherche séparant la latence d'attente de `When` du coût d'exécution doit être conservée ; la représentation formelle précise de cette observation reste ouverte.

13. **Abstraction sûre.** Toute abstraction exposée comme sûre doit préserver les invariants internes de K7PL pour tout usage conforme à son contrat, même si elle délègue un service au code étranger. La correction fonctionnelle de ce service n'est pas garantie par K7PL et ne doit pas être une prémisse implicite de la sûreté mémoire interne.

14. **Frontière d'interopérabilité.** Le code K7PL n'est pas conçu comme un mode où l'auteur peut désactiver arbitrairement la sûreté. Le marquage à définir concerne les opérations, déclarations ou modules qui ouvrent une interaction avec du code étranger et engagent un contrat externe. « Interface unsafe » reste un terme de travail.

15. **Responsabilités.** Le pilote ou la bibliothèque étrangère porte la responsabilité de respecter son contrat de service. K7PL spécifie le protocole, les représentations, les effets et les erreurs observables ; il ne certifie pas l'implémentation étrangère. Cela ne confère aucun droit d'accès à la mémoire, aux capacités ou aux états internes protégés de K7PL.

16. **Natif hostile.** L'absence d'accès étranger aux états internes K7PL est plus forte qu'une convention ABI. Elle requiert une frontière effectivement appliquée ou une restriction dont l'efficacité est formellement justifiée. Un espace mémoire partagé autorisant des lectures/écritures arbitraires du natif est incompatible avec cette exigence.

17. **Signalement des écarts.** Le contrat précise les violations détectables, leur signalement et les garanties restantes après détection. Ne pas promettre la détection de tout comportement arbitraire : seuls les écarts observables par le protocole ou un mécanisme défini peuvent être signalés. Un écart non détecté ne donne pas au code étranger un droit sur les états protégés.

18. **Garanties inconditionnelles.** L'ambition porte sur les invariants internes explicitement définis, et non sur une garantie inconditionnelle de terminaison, de disponibilité d'un service étranger, de progrès sous tout ordonnanceur ou de respect de toute échéance. Ces propriétés ont des contrats et prémisses propres ; leur échec ne doit pas annuler la sûreté mémoire ou l'intégrité interne.

**Deltas concernés par les décisions 13–18 :** SPEC-D-01 (périmètre des garanties intrinsèques), SPEC-D-04 (obligations des opérations et abstractions unsafe), SPEC-D-05 (contrat d'interopérabilité et séparation des responsabilités), SPEC-D-08 (préconditions et comportements hors contrat), SPEC-D-18 (préservation des états et traces), SPEC-D-19 (préservation par la toolchain). Ces lignes restent à instruire ; les décisions ci-dessus ne constituent ni une formalisation Lean ni une preuve.

## 4. Registre des deltas à instruire

Les priorités sont des priorités d'instruction, pas l'ordre obligatoire des commits normatifs. « Cible » désigne les fichiers à examiner, non une décision définitive de déplacer ou réécrire leur contenu. Chaque delta doit être affecté au bon niveau : garantie du langage, contrat de profil, preuve de raffinement, runtime/noyau, hypothèse de plateforme ou cible propre à K7OS. Les choix de réalisation qui ne sont pas universels sont reportés dans [K7OS — Exploration conjointe](K7OS-EXPLORATION-CONJOINTE.md), sans être supprimés de l'historique de recherche.

### A. Périmètre normatif, hypothèses et états des preuves

#### SPEC-D-01 — Délimiter les garanties intrinsèques de K7PL

**Nature :** clarification normative et correction des sur-affirmations.

**Sources :** R0, R1, R2, R3, R5, R8.  
**Cibles à examiner :** C1/Postulats ; C1/AxiomatiqueGerminale ; C4/EchelleDuSysteme ; Annexe A/FrontieresDeCouchesEtDisciplineDe.

**Delta candidat :** distinguer explicitement les garanties promises à tout programme K7PL sûr, celles qui ne valent que sous contrats de bibliothèques ou d'opérations unsafe, celles de la chaîne de compilation, et celles qui exigent le runtime ou un profil concret. Corriger toute formulation qui attribuerait au système de types une isolation de code natif arbitraire sans hypothèse ou mécanisme supplémentaire.

**Question ouverte :** l'actuelle description d'acteurs dans un même espace physique est-elle un exemple d'architecture, une hypothèse de profil, ou une revendication normative générale ? Le texte doit lever cette ambiguïté sans choisir à ce stade une architecture.

**Critère de clôture :** chaque garantie globale citée dans les chapitres système pointe vers un contrat, ses hypothèses, son périmètre et un statut de preuve.

**Résultat de l'instruction — 2026-10-24 : portée clarifiée.** Le terme « isolation » dans le modèle abstrait d'acteur désigne l'encapsulation vis-à-vis des transitions de communication définies par ce modèle. Il ne constitue pas une preuve d'inaccessibilité physique, de confinement de code natif arbitraire ou de révocation d'un accès déjà accordé à une autre composante. La source normative C1/AxiomatiqueGerminale a été ajustée dans la PR #302 pour éviter cette lecture plus forte. C4/EchelleDuSysteme maintient séparément le contrat de frontière `unsafe`, l'obligation de préserver les invariants lors des transitions autorisées et les obligations de réalisation.

**Chaîne d'évidence K7PL :** pour le sous-langage K7PL effectivement implémenté en K, les quatre règles de calcul racine (addition, comparaison et les deux branches de `select`) disposent maintenant chacune d'un pont explicite vers le constructeur `Rewrites` généré par KLean. Les preuves d'entrée se trouvent dans `proofs/K7PL/Bridge.lean`; la table de correspondance est publiée dans `docs/formal-semantics.md`. Les preuves de préservation sur la relation générée et sur le petit pas de surface restent des résultats distincts. La correspondance générale pour tous les pas de contexte/continuation et l'équivalence entre le classificateur K `typeOf` et le jugement Lean `HasType` ne sont pas affirmées.

**Rôle du cas K7OS :** le modèle de frontière native et son contre-exemple TLC sont des instruments de falsification qui rendent explicite la prémisse externe nécessaire. Ils ne sont ni une sémantique normative de K7PL ni une preuve que K7PL confine lui-même du natif arbitraire. Aucun mécanisme matériel n'est choisi.

**Clôture du traitement D-01 dans le périmètre instruit :** la portée des garanties intrinsèques est clarifiée dans la source normative et dans ce registre ; les quatre règles de calcul racine du sous-langage effectivement implémenté disposent de ponts unidirectionnels explicites vers les transitions KLean générées. Cette clôture ne déclare pas démontrée l'isolation physique ni le confinement concret d'un code natif arbitraire. La simulation générale des pas de contexte/continuation, la projection complète entre représentations, les contrats FFI et la preuve de leur réalisation restent des obligations distinctes, à traiter dans les travaux de sémantique opérationnelle, d'interface et de correction source-vers-binaire.

**Provenance de clôture :** la PR [#302](https://github.com/AntheaLiles/k7pl/pull/302) a été fusionnée le 24 octobre 2026 à 22:09:25 UTC, avec le commit de fusion `662d14c3494834517c70125ed11953923514738a`. Ce commit établit l'intégration des changements ; la preuve reste attachée à ses artefacts : le modèle TLC est un contrôle du modèle fini/configuré, les ponts Lean sont des témoins unidirectionnels pour quatre règles racines, et les théorèmes de préservation ont les énoncés précis définis dans leurs modules. La clôture D-01 ne transforme pas ces niveaux d'évidence en simulation générale du langage ou en preuve de confinement natif.

#### SPEC-D-02 — Définir un vocabulaire d'assurance cohérent

**Nature :** clarification éditoriale et exigence de traçabilité de l'assurance.

**Sources :** R0, R2, R3, R6, R7, R9.  
**Cibles :** C1/GuideDeLecture ; C2/SixSchemasDeMetatheorie ; documentation d'assurance et de statut des résultats.

**Delta candidat :** définir et utiliser de manière cohérente les distinctions entre spécifié, formalisé, démontré, vérifié par model checking dans un domaine fini, testé, mesuré, supposé, exclu et ouvert. Les esquisses de preuve et les propositions sous revue ne doivent pas être présentées comme résultats établis.

**Critère de clôture :** toutes les revendications normatives ou métathéoriques importantes ont un statut et un type d'évidence explicitement identifiables ; une CI verte est décrite comme un résultat de CI et non comme une preuve générale de sécurité.

**Résultat de la première instruction — 2026-10-25 : vocabulaire et traçabilité d'axiomes explicités, couverture globale encore ouverte.** La source normative C1/GuideDeLecture distingue maintenant la présence d'une clause spécifiée, l'existence d'une formalisation, une démonstration écrite, une preuve vérifiée par Lean avec audit d'axiomes, le model checking dans le périmètre du modèle/configuration, le test, la mesure, l'hypothèse, l'exclusion et l'obligation ouverte. Elle sépare ces qualifications des métadonnées C8 (`kind/role`, `state`, `evidence`) et des états d'assurance d'un document ou chantier. C2/SixSchemasDeMetatheorie rappelle que le statut de schéma n'acquitte pas les obligations de ses instances. Les documents [ASSURANCE.md](../../wiki/assurance.md) et [METHOD.md](../../wiki/method.md) rappellent la séparation des niveaux.

**Rétablissement de la chaîne axiomes → théorèmes → statut :** le contrat versionné [proofs/axiom-audit-contract.json](../../proofs/axiom-audit-contract.json) fixe, pour chaque déclaration retenue dans la tranche KLean, l'ensemble exact d'axiomes attendu. Le vérificateur `scripts/ci/k7pl_semantics_axiom_report.py` compare cet ensemble au rapport `#print axioms` du build, refuse les déclarations absentes, les rapports contradictoires, les dépendances différentes et les axiomes non autorisés, puis produit un JSON lié au commit, à l'exécution CI, à la version de Lean et au hachage du contrat. La liste d'axiomes standard admise est fixée aussi dans le vérificateur ; un changement du contrat seul ne peut pas élargir la politique. L'artefact formel conserve le contrat et le rapport observé. Le générateur de `docs/STATUS.md` affiche les ensembles attendus, puis le résultat, l'identifiant de run, la version de Lean, le hachage du contrat et les ensembles observés lorsqu'un rapport réussi correspond exactement au commit généré. À défaut de rapport courant, le statut reste `NOT AVAILABLE`, et les ensembles attendus ne sont jamais convertis en preuve d'audit. Après succès du workflow de sémantique formelle sur `main`, un job doté uniquement du droit `actions: write` déclenche `workflow_dispatch` sur le workflow racine. Celui-ci retrouve le rapport de la même révision, vérifie son contrat et régénère le statut même si la première exécution de CI s'était achevée avant l'audit. Les tests couvrent les rapports manquants, les écarts de dépendances, les rapports contradictoires, les axiomes non autorisés, le refus d'élargissement de la liste admise et `sorryAx`.

**Limite de méthode :** ce contrôle vérifie les sorties `#print axioms` des déclarations listées ; il ne remplace pas l'audit de tous les modules de preuve ni les contrôles indépendants sur les attributs d'exécution (`implemented_by`, `extern`, `csimp`) mentionnés dans [ADR-0005](../../wiki/decisions.md). Il ne faut donc pas présenter cette tranche comme un audit exhaustif du trusted computing base.

**Limite et prochaine étape :** cette première tranche ne satisfait pas encore le critère de clôture global de D-02. Il reste à inventorier les revendications normatives et métathéoriques importantes du manuscrit, à contrôler la cohérence de leurs champs C8 et de leurs identifiants d'artefacts, à distinguer les hypothèses de preuve des résultats calculés, et à assurer la traçabilité automatique des états d'exécution dans les vues publiées. Le travail de cette PR est donc une avancée vérifiable de D-02, pas la déclaration prématurée de sa clôture.


#### SPEC-D-03 — Structurer les profils de menace et la base de confiance

**Nature :** ajout/clarification des contrats de profil et des hypothèses.

**Sources :** R0, R1, R3, R8.  
**Cibles :** C1/Postulats ; C4/EchelleDuSysteme ; Annexe A/FrontieresDeCouchesEtDisciplineDe.

**Delta candidat :** décrire plusieurs familles de profils indépendantes, leurs capacités adversariales, les ressources protégées, les observations retenues, les hypothèses, exclusions et garanties attendues. Identifier la base de confiance par couche : code K7PL, code natif, compilateur, runtime, pilotes, périphériques et environnement initial.

**Points à ne pas figer :** la structure exacte de l'espace des profils, le matériel, les mécanismes concrets d'isolation et le périmètre final de chaque extension.

**Critère de clôture :** aucune propriété d'isolation, de confidentialité ou de progrès n'est annoncée sans profil identifiable et hypothèses minimales.

### B. Sûreté mémoire, permissions et frontières unsafe

#### SPEC-D-04 — Définir les obligations bilatérales de unsafe

**Nature :** précision normative du régime unsafe.

**Sources :** R1, R2, R5.  
**Cibles :** C3/ReglesDeTypage ; C3/GrammaireDesTypes ; C4/SemantiqueOperationnelle ; C5/LeTheoremeDElaboration ; Annexe A/CapabilitesEtMemoire.

**Delta candidat :** spécifier les préconditions auxquelles l'appelant est tenu, les invariants que l'implémenteur doit préserver et les garanties promises aux appelants sûrs d'une abstraction encapsulant unsafe. La frontière doit concerner aussi la substitution, les fermetures, les structures composites et les valeurs de retour, pas seulement la syntaxe d'appel.

**Question ouverte :** quelles constructions constituent le régime unsafe et comment leurs obligations apparaissent-elles à l'élaboration et dans les IR ? Une simple annotation lexicale ne détermine pas les propriétés garanties.

**Critère de clôture :** chaque opération non sûre possède un contrat vérifiable ; une abstraction sûre reste sûre pour tout usage qui respecte son interface, sous des hypothèses explicites sur ses dépendances.

#### SPEC-D-05 — Distinguer contrat FFI et confinement du code natif

**Nature :** ajout de contrats d'interface et clarification des hypothèses de confiance.

**Sources :** R0, R1, R2, R3, R8.  
**Cibles :** C3/StructuresOuvertesEffetsEtMetaTheorie ; C4/EchelleDuSysteme ; C4/EchelleDeLActeur ; C5/LeTheoremeDElaboration ; C6/LeProcessusDeCompilation.

**Delta candidat :** définir les contrats FFI : types et représentation des valeurs, préconditions, postconditions, effets, erreurs, callback, propriété/durée de vie, alias, threads, réentrance et autorité transmise. Distinguer explicitement le profil où le natif respecte son contrat du profil où le natif peut le violer.

**Incompatibilité à traiter :** dans un même domaine mémoire, du natif arbitraire capable de lire/écrire la mémoire peut contourner les types K7PL. Pour le profil hostile, la garantie exigera une frontière effectivement appliquée ou une autre restriction prouvée ; l'interface FFI ne suffit pas.

**Cible POSIX et acteurs :** faire correspondre chaque primitive POSIX admise à la sémantique abstraite d'acteur et à ses erreurs et effets observables ; expliciter les hypothèses de l'OS hôte plutôt que les inclure tacitement dans la sémantique du langage.

#### SPEC-D-06 — Relier les capacités et le comptage abstrait à l'autorité effective

**Nature :** précision sémantique et obligations de preuve d'application.

**Sources :** R1, R5, R7.  
**Cibles :** C2/AdjonctionsEtEnrichissement ; C3/ReglesDeTypage ; C4/EchelleDeLActeur ; Annexe A/CapabilitesEtMemoire ; modules d'implémentation MemoryCapability et MemoryRange, à titre de points de comparaison et non de preuves normatives automatiques.

**Delta candidat :** séparer propriété linéaire d'une valeur, capacité logicielle protégée, capacité noyau, droit de service et autorité de périphérique. Spécifier création, possession, transfert, atténuation, délégation, révocation, appels en vol, handles obsolètes et point de prise d'effet de la révocation.

**Critère de clôture :** l'unicité ou la restriction des droits n'est pas déduite uniquement du comptage abstrait ; une relation relie les capacités source aux opérations qu'elles autorisent effectivement dans le modèle d'exécution.

#### SPEC-D-07 — Compléter le modèle mémoire : régions, aliasing, emprunts et provenance

**Nature :** compléments sémantiques et formalisation manquante ; aucune primitive n'est décidée ici.

**Sources :** R1, R5, R8.  
**Cibles :** C3/ReglesDeTypage ; C4/ModelesDeMemoire ; C4/EchelleDeLActeur ; Annexe A/CapabilitesEtMemoire ; Annexe A/ContraintesDeValeurEtPreuvesResiduelles.

**Delta candidat :** préciser l'identité d'une région, la provenance d'une référence ou d'un offset, les bornes de chaque accès, l'allocation/destruction, la durée de vie, le recyclage et les générations, le découpage/recomposition de plages, les références vides et les débordements. Déterminer comment la source exprime propriété exclusive, lecture partagée, emprunt mutable, réemprunt et restitution des droits.

**Obligations identifiées par R5 :**
- H1 : introduction unique des capacités pour une région ;
- H2 : relation entre intervalles numériques et identité des régions ;
- H3 : impossibilité de capturer indirectement une autorité mémoire linéaire dans une valeur duplicable.

Ces hypothèses sont indépendantes et doivent chacune être justifiées. Les théorèmes arithmétiques des modules d'intervalles et de comptage de capacités ne démontrent pas à eux seuls la sûreté spatiale des règles source.

**Question ouverte :** quelle algèbre minimale de permissions suffit au modèle K7PL ? Évaluer emprunt et permissions fractionnaires sans imposer une logique particulière avant d'avoir établi les opérations et les lemmes requis.

#### SPEC-D-08 — Définir les comportements hors domaine et la sémantique de unsafe

**Nature :** clarification normative nécessaire aux optimisations.

**Sources :** R1, R2, R5.  
**Cibles :** C1/AxiomatiqueGerminale ; C3/ReglesDeTypage ; C4/SemantiqueOperationnelle ; C6/LeProcessusDeCompilation.

**Delta candidat :** inventorier les opérations nécessitant des préconditions, définir les cas où ces préconditions sont violées et leurs conséquences sur les garanties, puis décider si une catégorie générale de comportement indéfini est nécessaire. Expliquer quelles hypothèses le compilateur est autorisé à exploiter.

**Réserve :** « autorisé uniquement en unsafe » ne doit pas être interprété comme « tout comportement est permis dans unsafe ». Le domaine de validité et les conséquences de sa violation doivent être nommés.

### C. Confidentialité, intégrité et observables

#### SPEC-D-09 — Formaliser confidentialité, intégrité et non-interférence comme contrats distincts

**Nature :** ajout/instanciation de contrats relationnels, sous périmètre explicite.

**Sources :** R0, R3, R8.  
**Cibles :** C1/Postulats ; C2/SixSchemasDeMetatheorie ; C2/AdjonctionsEtEnrichissement ; C3/LeSystemeGradue ; C3/ReglesDeTypage ; C4/SemantiqueOperationnelle.

**Delta candidat :** définir domaines de sécurité, ordre de flux, observateurs, entrées publiques et secrètes, sorties permises, relation d'équivalence d'états et de traces, déclassification et endorsement. Séparer confidentialité (influence d'un secret sur les observations) et intégrité (influence d'une donnée non fiable sur un état ou une décision de confiance).

**Limite actuelle :** la présence d'un ordre de précision, d'un niveau dans un grade ou d'une règle de déclassification ne constitue pas à elle seule une politique de flux d'information ni un théorème de non-interférence global.

**Critère de clôture :** au moins un fragment fermé est défini et traité relationnellement ; toute extension aux effets, à la concurrence ou au natif indique ses obligations propres.

#### SPEC-D-10 — Nommer les observables et les exclusions de canaux auxiliaires

**Nature :** définition normative des observations et précision des exclusions.

**Sources :** R0, R3, R6, R9.  
**Cibles :** C1/Postulats ; C4/SemantiqueOperationnelle ; C4/CalculDeProcessusSousjacent ; C6/StrategiesDeVerificationEtDeTest.

**Delta candidat :** déclarer quelles observations entrent dans chaque contrat : valeurs, messages et leur ordre causal, erreurs, exceptions, terminaison/divergence, effets externes, ressources, temps, journaux et état après reprise. Les canaux temporels et auxiliaires sont séparés du contrat initial de confidentialité, mais cette exclusion doit être explicite.

**Point de cohérence :** les temps restent pertinents pour les budgets et le WCET même si la non-interférence temporelle est reportée. Il faut donc distinguer observation de coût, observabilité par un adversaire et obligation de confidentialité.

#### SPEC-D-11 — Relier le calcul d'acteurs au graphe d'attente réel

**Nature :** complément de sémantique opérationnelle et obligation de simulation.

**Sources :** R4, R9.  
**Cibles :** C3/LesContraintesDeValeur ; C3/ReglesDeTypage ; C4/SemantiqueOperationnelle ; C4/EchelleDuSysteme ; C4/CalculDeProcessusSousjacent.

**Delta candidat :** définir une configuration complète multi-acteurs comportant calculs, état mémoire, boîtes, protocoles résiduels, tâches, timers, annulation, supervision et trace. Définir la relation entre le graphe de dépendances statique et les attentes réellement atteignables ; prouver la prémisse Sim règle par règle, au lieu de la déduire du seul typage.

**Critère de clôture :** les états et événements pris en compte sont définis ; les transitions Send, réception/Guard, consommation/libération, Timeout, annulation et terminaison conservent l'invariant de correspondance ou sont explicitement exclus.

#### SPEC-D-12 — Séparer fidélité de protocole, progrès, absence de blocage, famine et terminaison

**Nature :** clarification des propriétés et des prémisses de théorèmes.

**Sources :** R4, R9.  
**Cibles :** C3/LesContraintesDeValeur ; C4/SemantiqueOperationnelle ; C4/CalculDeProcessusSousjacent.

**Delta candidat :** donner des énoncés distincts à la conformité locale des sessions, au progrès d'un calcul, au progrès d'un pool, à l'absence de blocage mutuel, à l'absence de famine et à la terminaison sous équité. Énoncer séparément les hypothèses sur ordonnanceur, mémoire, transport, horloge et environnement.

**Critère de clôture :** aucun théorème d'absence de blocage ne se fonde uniquement sur le tri topologique tant que l'exhaustivité du graphe d'attente et la relation Sim ne sont pas démontrées. La dualité de sessions ne doit pas être présentée comme preuve de progression globale.

#### SPEC-D-13 — Définir les contrats d'annulation, timeout et erreurs de protocole

**Nature :** complément normatif des transitions et des états terminaux.

**Sources :** R4, R7, R9.  
**Cibles :** C3/ReglesDeTypage ; C4/SemantiqueOperationnelle ; C4/EchelleDuSysteme ; Annexe A/ProtocolesSessionsEtTopologieDistribuee.

**Delta candidat :** distinguer demande d'annulation, annulation confirmée, interruption avant commit, commit déjà validé et accusé. Préciser les messages pendants, les ressources détenues, le pair distant, les points de commit et les états terminaux. Une annulation demandée ne doit pas être assimilée à une opération annulée.

**Trace R9 :** le modèle TLC borné illustre un entrelacement dans lequel un commit peut gagner la course sur une requête déjà acceptée. Ce contre-exemple est utile pour préciser le contrat, mais il n'établit pas encore que le modèle de recherche correspond à toute la sémantique normative K7PL.

### D. Grades, ressources et temps

#### SPEC-D-14 — Définir la quantité représentée par les grades de budget

**Nature :** clarification de la sémantique des grades et ajout des obligations de coût.

**Sources :** R2, R4, R6, R9.  
**Cibles :** C1/AxiomatiqueGerminale ; C2/SystemeDeRaffinement ; C3/EffectiveKernel ; C3/LeSystemeGradue ; C3/ReglesDeTypage ; C4/SemantiqueOperationnelle.

**Delta candidat :** définir les domaines, unités, ordre et composition du travail W, de la profondeur D, de Cost_Budget et des budgets ; préciser leur relation à chaque transition et effet. Couvrir séquencement, branchement, appels, récursion, parallélisme, allocation, synchronisation, exceptions et annulation.

**Point existant à préserver :** la décision de recherche Cost_Budget = max(W,D) doit être interprétée dans ses hypothèses abstraites. Elle ne donne pas à elle seule un temps mural, une borne CPU ni un WCET.

**Critère de clôture :** un théorème relie le jugement de grade au coût de la sémantique opérationnelle instrumentée sur un fragment explicitement annoncé ; les obligations de composition ouvertes sont listées.

#### SPEC-D-15 — Séparer coût abstrait, coût machine, WCET et faisabilité d'échéance

**Nature :** clarification des contrats et extension d'assurance dépendante de la cible.

**Sources :** R2, R6, R8.  
**Cibles :** C1/AxiomatiqueGerminale ; C4/SemantiqueOperationnelle ; C6/LeProcessusDeCompilation ; C6/CeQueLeSolveurRetourne ; C6/StrategiesDeVerificationEtDeTest.

**Delta candidat :** séparer les budgets abstraits, le coût d'une exécution cible, les quotas CPU, le WCET, l'ordonnancement et la faisabilité des échéances. Attribuer des contrats aux primitives, bibliothèques, appels système, FFI et runtime ; exclure ou borner les opérations dont le coût n'est pas maîtrisé.

**Hypothèses externes à déclarer :** cible et binaire exacts, options, ABI, bibliothèques, comportement mémoire/cache, interruptions, DMA, ordonnancement et interférences. Une correction fonctionnelle de compilation ne prouve pas la préservation du coût.

**Point When :** la latence d'attente environnementale de When doit rester distincte du coût de déclenchement/exécution. La représentation et le type exacts de l'observation de latence restent ouverts ; ne pas les injecter implicitement dans les effets ou dans Cost_Budget.

### E. Pannes, persistance et restauration des ressources

#### SPEC-D-16 — Décomposer le modèle de panne et les garanties de récupération

**Nature :** définition de profils/ extensions et explicitation des exclusions.

**Sources :** R0, R4, R7, R8, R9.  
**Cibles :** C4/EchelleDuSysteme ; C4/SemantiqueOperationnelle ; C4/ModelesDeMemoire ; Annexe A/CapabilitesEtMemoire ; Annexe A/ProtocolesSessionsEtTopologieDistribuee.

**Delta candidat :** distinguer échec coopératif, erreur applicative, crash d'acteur, redémarrage de processus, perte d'alimentation, corruption, partition et restauration d'un ancien état. Définir pour chaque classe les transitions et les états après reprise. Les pannes additionnelles doivent être des extensions nommées, non des hypothèses implicites.

**Critère de clôture :** les propriétés démontrées sous un modèle de panne ne sont pas généralisées à un autre sans hypothèse ou preuve supplémentaire.

#### SPEC-D-17 — Préciser journal, checkpoint, commit et effets externes

**Nature :** complément de sémantique pour les extensions de persistance.

**Sources :** R4, R7, R9.  
**Cibles :** C4/EchelleDuSysteme ; C4/SemantiqueOperationnelle ; Annexe A/ProtocolesSessionsEtTopologieDistribuee.

**Delta candidat :** décrire l'état volatile et l'état durable, le format et l'ordre des entrées du journal, les enregistrements partiels, les checkpoints, le préfixe durable, les points de commit, les effets externes, la déduplication, les tentatives et la reprise des ressources linéaires. Indiquer ce qui peut être perdu, répété, compensé ou rester incertain.

**Limite :** le rejeu logique ne prouve pas la durabilité du support ni l'exécution unique d'un effet externe. Le budget consommé par une tentative échouée ne doit pas être restauré automatiquement sans définir sa signification.

### F. Toolchain, préservation sémantique et traçabilité

#### SPEC-D-18 — Établir la relation d'adéquation entre source et exécution

**Nature :** définition formelle de la relation de simulation et obligations de preuve.

**Sources :** R2, R4, R5, R9.  
**Cibles :** C4/SemantiqueOperationnelle ; C4/CalculDeProcessusSousjacent ; C5/LeTheoremeDElaboration ; C6/LeProcessusDeCompilation ; audits C-04/C-07/C-08.

**Delta candidat :** définir une relation sur les configurations complètes, et pas seulement entre termes : calcul, arène/état mémoire, capacités, trace d'effets, messages, événements d'erreur, coût retenu et observation d'attente. Préciser la relation de simulation, les pas administratifs, l'équivalence structurelle cible, l'ordre causal de traces concurrentes et les conditions de substitution.

**Critère de clôture :** chaque règle source couverte possède un cas de simulation ; le résultat ne revendique ni bisimulation, ni équivalence observationnelle, ni pleine abstraction si seule une simulation avant est établie.

#### SPEC-D-19 — Spécifier la préservation à chaque étape de la chaîne MLIR/LLVM

**Nature :** contrat normatif de compilation et feuille de route de preuve.

**Sources :** R2, R5, R6, R8.  
**Cibles :** C5/LeTheoremeDElaboration ; C6/LeProcessusDeCompilation ; C6/CeQueLeSolveurRetourne ; C6/StrategiesDeVerificationEtDeTest ; CodeArtifacts et formal-chain comme expériences distinctes.

**Delta candidat :** définir la chaîne sémantique visée, du programme élaboré aux IR K7PL, MLIR, LLVM IR, code machine, linking et runtime. Pour chaque transformation, préciser le langage source/cible, la relation de correction, les observables préservées, les hypothèses et le niveau d'assurance (preuve, validation de traduction, test différentiel ou outil placé dans le TCB).

**Propriétés à traiter séparément :** résultats fonctionnels, mémoire, autorité, effets/traces, protocoles, terminaison/échec, budgets et propriétés relationnelles de confidentialité. Une IR valide ou des tests passés ne prouvent pas ces propriétés de bout en bout.

#### SPEC-D-20 — Déclarer la base de confiance et l'assurance reproductible

**Nature :** précision des hypothèses et compléments de traçabilité de la toolchain.

**Sources :** R0, R2, R9.  
**Cibles :** C5/phase 0 et élaboration ; C6/ProcessusDeCompilation ; documentation d'assurance ; CI, dépendances et artefacts de build.

**Delta candidat :** inventorier macros et métaprogrammes exécutés dans le compilateur, imports, solveurs, optimiseurs, versions et options, outils externes, backend, assembleur, linker, runtime, génération de fichiers et publication. Fixer ce qui est vérifié, validé, testé ou supposé. La compilation reproductible et l'intégrité de provenance doivent être énoncées comme objectifs jusqu'à ce que leurs critères et preuves soient satisfaits.

**Critère de clôture :** un artefact final est relié à la source examinée, aux paramètres et dépendances exacts, à la cible et à ses résultats d'assurance ; les éléments non vérifiés de la chaîne sont explicites.

#### SPEC-D-21 — Établir la traçabilité exigences–définitions–preuves–tests

**Nature :** exigence transversale d'assurance ; partiellement documentaire, pas une nouvelle règle du langage à elle seule.

**Sources :** R0, R2, R3, R4, R5, R6, R7, R9.  
**Cibles :** identifiants normatifs, déclarations Lean, tests, modèles bornés et documentation d'assurance.

**Delta candidat :** relier dans les deux sens chaque exigence à sa définition, ses hypothèses, ses théorèmes, ses contre-exemples, ses tests et les configurations/outils qui les ont produits. Les identifiants de recherche R9 et les noms de blocs Verso ne doivent pas être assimilés automatiquement à des identifiants sémantiques ou à des preuves.

**Critère de clôture :** tout résultat d'assurance est classé par type de preuve, version, périmètre, paramètres, hypothèses, contre-exemples connus et exigence soutenue.

#### SPEC-D-22 — Encadrer les revendications d'absence de surcoût

**Nature :** clarification des engagements de performance et critères expérimentaux.

**Sources :** R2, R6.  
**Cibles :** C5/élaboration et effacement ; C6/pipeline et optimisation ; contraintes de grade/budget.

**Delta candidat :** séparer effacement des preuves, absence d'instrumentation redondante, préservation d'un contrat de coût abstrait et non-régression empirique. Chaque affirmation de performance doit préciser métrique, baseline, cible, options, corpus, dispersion et environnement.

**Limite :** aucune preuve fonctionnelle ne garantit l'optimalité universelle ni l'absence de coût pour tous les programmes et toutes les cibles.

### G. Architecture de l'étude OS comme test du langage

#### SPEC-D-23 — Découpler machine abstraite normative et profils concrets

**Nature :** clarification d'architecture sémantique et des préconditions de réalisation.

**Sources :** R0, R1, R6, R7, R8.  
**Cibles :** C1/Postulats ; C4/EchelleDuSysteme ; C4/ModelesDeMemoire ; Annexe A/FrontieresDeCouchesEtDisciplineDe.

**Delta candidat :** définir ce que la machine abstraite exige sans choisir de matériel, puis représenter séparément chaque profil concret par ses préconditions, ABI, modèle mémoire, privilèges, interrupts, DMA, runtime, ordonnanceur et limites de confiance. Pour le profil initial, exclure firmware et démarrage de façon explicite, tout en posant la conformité de l'état initial comme précondition.

**Critère de clôture :** aucune propriété abstraite n'est attribuée à un profil concret sans relation d'adéquation ; aucun choix matériel n'est caché dans le vocabulaire du langage.

#### SPEC-D-24 — Exploiter les comparaisons d'OS comme critères de falsification

**Nature :** méthode d'évaluation non normative ; ne doit pas devenir une exigence de langage par simple analogie.

**Sources :** R0, R1, R2, R6, R7, R8.  
**Cibles :** C7/études de cas ; architecture de validation et tests d'acceptation.

**Delta candidat :** utiliser les systèmes comparés comme sources de mécanismes et de contre-exemples, pas comme preuves transférables. Définir des scénarios communs pour code natif hostile, fuite par observation, famine, DMA, révocation, restauration après panne et conservation des budgets. Mesurer les coûts sur des configurations équivalentes lorsque la performance est comparée.

**Limite :** cette ligne organise l'évaluation de l'OS comme banc d'essai ; elle ne ratifie aucune architecture, aucun noyau et aucun composant matériel.

#### SPEC-D-25 — Relier les modèles bornés et contre-exemples à la sémantique K7PL

**Nature :** méthode de vérification et contrat de traçabilité entre modèle, preuve et test.

**Sources :** R4, R6, R7, R9.  
**Cibles :** C3/C4 ; tests ; modèles TLA+/TLC ou Apalache ; preuve Lean ; documentation d'assurance.

**Delta candidat :** conserver les modèles finis comme instruments de falsification ; identifier les abstractions et bornes ; convertir les traces pertinentes en vecteurs de test ; relier leurs états et événements à la sémantique normative par une projection explicitement définie. Les invariants d'une exploration finie ne doivent pas être annoncés comme théorèmes généraux du langage.

**Cas d'école déjà utile :** la demande d'annulation et le commit peuvent entrer en concurrence après acceptation d'une requête. La distinction entre demande, interruption effective, commit et accusé doit être testée dans la sémantique retenue.

## 5. Carte provisoire entre dossiers R0–R9 et deltas

| Dossier | Apport retenu pour la spec | Deltas concernés |
|---|---|---|
| [R0 — Menaces et assurance](R0-threat-model-assurance-matrix.md) | Profils, actifs, adversaires, observables, hypothèses, frontières et tests de falsification | SPEC-D-01 à D-03, D-05, D-09, D-10, D-16, D-20, D-23 |
| [R1 — Autorité et FFI](R1-authority-capabilities-ffi-boundaries.md) | Distinction type linéaire / capacité effective / droit noyau / droit matériel ; révocation et confinement natif | SPEC-D-04 à D-06, D-08, D-20 |
| [R2 — Source vers binaire](R2-source-to-binary-correctness.md) | Simulation sur configurations, séparation du coût fonctionnel/abstrait/machine, TCB et absence de surcoût | SPEC-D-01, D-04, D-05, D-08, D-14, D-15, D-18 à D-22 |
| [R3 — Confidentialité et intégrité](R3-confidentialite-integrite-non-interference.md) | Non-interférence relationnelle, déclassement, endorsement, observables et canaux temporels | SPEC-D-02, D-03, D-09, D-10, D-18 à D-20 |
| [R4 — Concurrence et annulation](https://github.com/AntheaLiles/k7pl/pull/286/files) | Graphe d'attente dynamique, Sim, équité, distinctions entre sûreté/progrès/vivacité/terminaison, courses d'annulation | SPEC-D-11 à D-13, D-16, D-17, D-18, D-25 |
| [R5 — Mémoire et séparation](https://github.com/AntheaLiles/k7pl/pull/287/files) | H1/H2/H3, régions, aliasing, emprunt, provenance, permissions et frontière FFI | SPEC-D-04 à D-08, D-18, D-19 |
| [R6 — Grades et temps réel](R6-grades-budgets-WCET-temps-reel.md) | Définition du coût abstrait, composition des budgets, relation coût-source/coût-machine, WCET et scheduling | SPEC-D-10, D-14, D-15, D-19, D-22 à D-24 |
| [R7 — Pannes et persistance](R7-pannes-ressources-lineaires-persistance.md) | État volatile/durable, journal, checkpoint, commit, effets externes, incarnation et récupération des ressources | SPEC-D-06, D-13, D-16, D-17, D-21, D-23, D-25 |
| [R8 — Comparaison d'OS](R8-comparaison-systemes-exploitation.md) | Distinction entre protection du langage, noyau, matériel, compilation et système complet ; profils à comparer sans en choisir un | SPEC-D-01, D-03, D-05, D-06, D-15, D-19, D-23, D-24 |
| [R9 — Model checking et traçabilité](R9-model-checking-contre-exemples-tracabilite.md) | Modèle fini, témoin de course, différence entre test, exploration bornée et preuve générale | SPEC-D-02, D-10 à D-13, D-18, D-21, D-25 |

## 6. Points de contrôle dans les sources Lean existantes

Les fichiers suivants constituent les premiers lieux de confrontation du registre avec les termes normatifs. Cette liste est un point de départ, pas un inventaire exhaustif des lignes à modifier.

### C1 — Postulats et axiomatique

- [Postulats](../../spec/Spec/C1/Postulats.lean) et [axiomatique germinale](../../spec/Spec/C1/AxiomatiqueGerminale.lean) : distinguer les postulats sémantiques, les choix de profil, les hypothèses d'exécution et les objectifs d'assurance ; vérifier que les exclusions sont explicites.
- [Guide de lecture](../../spec/Spec/C1/GuideDeLecture.lean) : assurer que le statut des propositions, preuves et hypothèses se lit sans ambiguïté.

### C2 — Métathéorie et raffinement

- [Six schémas de métathéorie](../../spec/Spec/C2/SixSchemasDeMetatheorie.lean) : vérifier la portée de chaque schéma et l'écart entre gabarit documentaire, énoncé instancié et preuve.
- [Système de raffinement](../../spec/Spec/C2/SystemeDeRaffinement.lean) et [adjonctions/enrichissement](../../spec/Spec/C2/AdjonctionsEtEnrichissement.lean) : examiner les relations nécessaires à la simulation entre représentations et les conditions d'une composition des preuves.
- Ne pas transformer un besoin de confidentialité, d'autorité ou de temps en nouvelle coordonnée de grade avant d'avoir établi son statut sémantique.

### C3 — Types, grades, effets et ressources

- [Noyau effectif](../../spec/Spec/C3/EffectiveKernel.lean) et [règles de typage](../../spec/Spec/C3/ReglesDeTypage.lean) : vérifier la couverture du noyau, des règles, des conversions, de la substitution et des cas restants.
- [Système gradué](../../spec/Spec/C3/LeSystemeGradue.lean), [contraintes de valeur](../../spec/Spec/C3/LesContraintesDeValeur.lean) et [structures ouvertes/effets](../../spec/Spec/C3/StructuresOuvertesEffetsEtMetaTheorie.lean) : relier les grades et effets aux garanties revendiquées ; formaliser le rapport entre dépendances statiques et comportements atteignables.
- [Grammaire des types](../../spec/Spec/C3/GrammaireDesTypes.lean) : examiner les contrats de session, les capacités, les modes et les éventuelles règles nécessaires à unsafe/FFI.

### C4 — Sémantique, mémoire et acteurs

- [Sémantique opérationnelle](../../spec/Spec/C4/SemantiqueOperationnelle.lean) : clarifier configuration, transition, état mémoire, trace, observation et coûts.
- [Modèles de mémoire](../../spec/Spec/C4/ModelesDeMemoire.lean), [échelle de l'acteur](../../spec/Spec/C4/EchelleDeLActeur.lean) et [échelle du système](../../spec/Spec/C4/EchelleDuSysteme.lean) : revisiter H1/H2/H3, frontières de confiance, configurations multi-acteurs, pannes et profils.
- [Calcul de processus sous-jacent](../../spec/Spec/C4/CalculDeProcessusSousJacent.lean) et [preuves ouvertes](../../spec/Spec/C4/CeQueChaquePreuveOuverteYPuise.lean) : fermer la relation de traduction sans confondre simulation, bisimulation et équivalence observationnelle.

### C5–C6 — Élaboration et compilation

- [Théorème d'élaboration](../../spec/Spec/C5/LeTheoremeDElaboration.lean), [déclaration de macros](../../spec/Spec/C5/CeQuUneMacroDeclare.lean) et [S-expressions universelles](../../spec/Spec/C5/SExpressionsUniverselles.lean) : préciser la sémantique de la source canonique, la phase d'expansion et les obligations liées à du code exécuté au moment de la compilation.
- [Processus de compilation](../../spec/Spec/C6/LeProcessusDeCompilation.lean), [sortie du solveur](../../spec/Spec/C6/CeQueLeSolveurRetourne.lean) et [stratégies de vérification/test](../../spec/Spec/C6/StrategiesDeVerificationEtDeTest.lean) : construire le contrat par étape, expliciter les éléments de confiance, tracer les certificats et séparer preuve, validation, test et mesure.

### Annexes

- [Capacités et mémoire](../../spec/Spec/AnnexeA/CapabilitesEtMemoire.lean) : aligner vocabulaire, codes d'erreur et contrats sur les règles réellement spécifiées.
- [Frontières de couches](../../spec/Spec/AnnexeA/FrontieresDeCouchesEtDisciplineDe.lean), [protocoles et topologie](../../spec/Spec/AnnexeA/ProtocolesSessionsEtTopologieDistribuee.lean), [contraintes de valeur et preuves résiduelles](../../spec/Spec/AnnexeA/ContraintesDeValeurEtPreuvesResiduelles.lean) : éliminer les glissements entre intention architecturale, hypothèse et garantie.

## 7. Ordre de travail proposé après dépouillement complet

L'ordre suivant permet de réduire les ambiguïtés en amont et d'éviter de corriger la spec à partir de mécanismes choisis trop tôt.

### P0 — Stabiliser les revendications et leur périmètre

1. Les rapports R4/R5 étant fusionnés dans `main` (PR #286/#287), confronter leurs constats à la tête courante des sources normatives ; leur intégration documentaire ne vaut pas clôture des obligations de preuve. Reporter les cibles système retirées des clauses générales dans [K7OS — Exploration conjointe](K7OS-EXPLORATION-CONJOINTE.md).
2. Marquer chaque revendication à portée globale comme garantie, objectif, hypothèse ou obligation ouverte.
3. Corriger les formulations absolues sur l'isolation, le progrès, la mémoire, le rejeu, le temps réel et la correction de compilation lorsque leurs prémisses manquent.
4. Figer uniquement les distinctions conceptuelles nécessaires : langage vs système, sûreté vs vivacité, capacité logique vs autorité effective, coût abstrait vs WCET, modèle de panne vs profil nominal.

### P1 — Compléter les contrats sémantiques fondamentaux

1. Définir le régime unsafe et les contrats FFI.
2. Relier les règles source aux permissions mémoire et aux identités des régions.
3. Compléter les configurations et transitions nécessaires pour effets, acteurs, traces, attente et annulation.
4. Formaliser observables, politique de flux et périmètre de confidentialité.
5. Définir les quantités des grades et les contrats de coût sans les confondre avec le WCET.

### P2 — Démontrer les propriétés sur des fragments ciblés

1. Fermer un fragment source explicite pour la sûreté mémoire et les propriétés de préservation.
2. Traiter séparément substitution, préservation du typage, progrès local et correspondance des traces.
3. Utiliser TLA+/TLC ou un outil symbolique pour falsifier les contrats concurrents bornés ; relier chaque témoin à une exigence.
4. Établir les premiers lemmes de simulation entre source et IR, puis étendre la relation aux représentations et propriétés supplémentaires.

### P3 — Préparer les profils concrets sans les imposer au langage

1. Prototyper les mécanismes d'application requis par les profils natif de confiance et natif hostile.
2. Définir des contrats de runtime pour capacités, acteurs, POSIX, mémoire, annulation et ressources.
3. Évaluer les budgets sur un modèle abstrait, puis seulement ensuite les relier à une analyse machine et à un ordonnanceur concrets.
4. Décomposer les extensions de panne, persistance, canaux auxiliaires et chaîne de démarrage en contrats séparés.

## 8. Questions à résoudre avant toute réécriture normative

Le dépouillement doit fournir des réponses, ou déclarer explicitement les décisions reportées, pour ces points :

1. Quelle est la plus petite définition de « programme K7PL sûr » indépendante du modèle d'OS ?
2. Quelles propriétés un appelant sûr peut-il compter sur une abstraction utilisant unsafe, et quelles obligations sont à la charge de son implémenteur ?
3. Quelles opérations FFI sont autorisées, et que peut garantir le profil natif hostile si le mécanisme de confinement concret n'est pas encore sélectionné ?
4. Quelle relation lie les régions, leurs capacités, leurs références et les adresses produites par le backend ?
5. Quel fragment de non-interférence est réaliste à démontrer en premier, avec quelles observations et quelles exclusions ?
6. Quelles transitions exactes définissent attente, timeout, annulation, commit, panne et reprise ?
7. Quel est l'objet précis compté par le budget abstrait, et quelles propriétés doivent survivre à MLIR/LLVM ?
8. Quelle relation relie une configuration source complète à l'état cible et à ses événements ?
9. Quelles parties de la toolchain sont vérifiées, validées, testées, mesurées ou explicitement placées dans la base de confiance ?
10. Quelle trace ou quel contre-exemple permettrait de falsifier chaque contrat important ?

## 9. Critères de sortie du registre

Ce registre ne sera considéré comme exploitable pour planifier les modifications normatives que lorsque :

- chaque rapport R0–R9 aura une révision, un statut et une liste d'apports confirmés ;
- chaque delta aura des sources exactes, une portée, ses dépendances et ses critères de clôture ;
- les doublons entre deltas auront été fusionnés sans perdre les obligations propres à chaque dossier ;
- les contradictions entre chapitres auront été recensées avant toute réécriture ;
- chaque proposition de modification sera classée comme clarification, ajout normatif, ajustement d'une garantie existante, suppression d'une sur-affirmation, définition Lean manquante ou obligation de preuve ;
- les décisions reportées seront séparées des décisions ratifiées ;
- les états de preuve ne seront pas déduits du style du texte, du nom du théorème ou de la seule réussite de CI.

**Conclusion provisoire.** Les recherches convergent vers un besoin de contrats et de relations de préservation, pas vers l'ajout immédiat de primitives ou de coordonnées de grade. Les évolutions les plus structurantes concernent la frontière sûr/unsafe, le modèle mémoire et l'autorité effective, la sémantique complète des acteurs et des traces, la distinction entre sûreté et vivacité, et la chaîne de correction source–IR–binaire. Ce registre sera affiné au fil du QCM et du dépouillement des rapports ; il ne déclare aucune de ces propriétés démontrée.

## 9. Traçabilité vers l'exploration K7OS

Les deltas ci-dessous ont deux destinations possibles qui doivent rester distinctes : la définition et l'assurance de K7PL d'une part, la conception d'un système concret K7OS d'autre part. Un même thème peut nécessiter les deux, avec des obligations différentes.

| Famille de deltas | Traitement K7PL à poursuivre | Conservation / exploration K7OS |
|---|---|---|
| D-01 à D-03 — garanties, statuts de preuve, menaces et TCB | Définir les garanties intrinsèques et les hypothèses de profil ; traçabilité des preuves | Profils de menace, frontières de confiance, options d'isolation et démarrage |
| D-04 à D-08 — unsafe, FFI, capacités, mémoire et hors-domaine | Contrats du langage, sémantique et preuves H1/H2/H3 ; simulation vers l'exécution | Tables de handles, frontières natives, isolation, stratégie DMA, modèles d'autorité candidats |
| D-09 à D-10 — confidentialité, intégrité et observables | Relations d'équivalence, observations, déclassification et obligations relationnelles | Canaux temporels/auxiliaires, journaux, observateurs et profils de co-résidence |
| D-11 à D-13 — attente, progression, erreur, timeout et annulation | Formaliser `Sim`, transitions et propriétés distinctes de progrès/terminaison | Ordonnanceur, files, protocoles candidats, arbitrage commit/annulation et récupération |
| D-14 à D-15 et D-22 — grades, budget, WCET et coût | Clarifier coûts abstraits et contrats ; relier source et binaire | Quotas, cible temps réel, mesures matérielles, latence, coûts de changement de domaine |
| D-16 à D-17 — panne, journal, checkpoint et commit | Définir la sémantique abstraite du modèle de panne pris en charge | Supervision, battements de cœur, snapshots, journaux, durabilité et effets externes |
| D-18 à D-21 — simulation, compilation, TCB et traçabilité | Relations de préservation de la source aux IR/binaires ; preuve et evidence ledger | Outillage de build, mécanismes de confinement de phase 0, signature/provenance, configuration de déploiement |
| D-23 à D-24 — machine abstraite, profils et comparaison | Exprimer la machine abstraite sans choisir un matériel ; préciser les préconditions de réalisation | Comparer domaine partagé, unikernel, micro-noyau, capacités matérielles et multikernel |
| D-25 — model checking et correspondance sémantique | Lier les traces bornées à des projections définies vers la sémantique | Banc de falsification K7OS, vecteurs de test, traces de concurrence et de reprise |

Les 25 lignes restent provisoires. La présence d'une piste dans le dossier K7OS ne clôt pas le delta associé ; inversement, une exigence du langage n'impose pas le mécanisme système utilisé pour la satisfaire.

