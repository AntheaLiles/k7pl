<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit indépendant de sortie — porte scientifique C

Date : 11 octobre 2026.  
Révision de `main` vérifiée : `bfe20580a7839e36702ec178e6c8eff671b60ce8`.  
Chaîne documentaire de décisions examinée : PR #170 à #180 ; tête antérieure à ce rapport : `7ec2d1f76713d42d763b0dd9694d37f071f572b8`.  
Portée : réévaluation indépendante des critères C-01 à C-09, de la traçabilité des décisions et des preuves formelles disponibles.

**Verdict : PORTE C NON SATISFAITE.** Cette conclusion ne vient pas du seul statut des audits antérieurs. Elle résulte de la comparaison des critères de sortie avec les sources, les objets de `src/`, les décisions ratifiées ou en attente, et le statut réel des PR.

## 1. Méthode et état du dépôt

L’audit a repris les critères de sortie de [L1-THEORY-OBJECTS.md](L1-THEORY-OBJECTS.md), le [dossier probant antérieur](L1-STAGE-C-EVIDENCE-DOSSIER-2026-10-11.md) et les audits C-01/C-02 à C-09. J’ai vérifié la tête de `main` via GitHub et relu les sources C2, C3, C4 et les tables de correspondance d’énoncés.

Distinctions maintenues :
- un texte Verso qui expose un énoncé et un `proofsketch` n’est pas une preuve Lean ;
- la compilation Verso, les contrôles documentaires et les tests ne prouvent pas la correction mathématique ;
- une décision sur une branche de PR ouverte n’est pas intégrée à `main` ;
- une identité arithmétique formalisée pour un modèle ne prouve pas à elle seule la correction d’une règle K7PL qui pourrait l’utiliser.

### État réel de GitHub

`main` est au SHA `bfe20580a7839e36702ec178e6c8eff671b60ce8`. Les PR #170–#180 restent **ouvertes et non fusionnées**, empilées de manière séquentielle : #170 vise `main`, #171 vise la tête de #170, …, #180 vise la tête de #179. Les ratifications C-01/C-02 et D3–D11 enregistrées dans cette chaîne ne figurent donc pas encore dans `main`. Le run CI réussi de PR #180 porte sur la chaîne documentaire et ne valide pas de preuve scientifique.

Les audits historiques ne partagent pas tous la même révision source : certains indiquent les SHAs `414ce6…`, `1dc5be…` ou `de1f6b…`. Ils restent utiles comme rapports de provenance et de lacunes, mais ne peuvent être cités comme s’ils portaient tous sur le même snapshot. Le présent rapport prend `bfe2058…` comme référence de branche principale et conserve cette distinction.

## 2. Matrice de sortie C-01 à C-09

| Lot | État indépendant | Ce qui existe | Condition encore non satisfaite |
|---|---|---|---|
| **C-01 — grades et interfaces** | **PARTIEL** | Les signatures de référence `π_U`, `Bang_𝒢` et `Scale_Usage` ont été ratifiées dans la chaîne #170. | Décisions pas encore intégrées dans `main` ; les porteurs, domaines de `ψ` et `φ_n`, conversions `coerce/w/c` et les compatibilités requises ne sont pas formalisés en preuves K7PL. |
| **C-02 — modes** | **PARTIEL** | La chaîne #171 retient `M_Lin`, `M_Aff`, `M_Unr` et réserve `Rel` comme piste. | La correspondance mode → jugement → règles n’est pas prouvée ; les contrats et morphismes ne découlent pas des seuls intervalles et aucun lemme Lean d’instance K7PL n’a été trouvé. |
| **C-03 — conversions** | **OUVERT** | Audits et dérivations conditionnelles sur identité/composition de certains transports. | Lois `coerce`, naturalité, compatibilité avec counité/comultiplication, conversions `Sub/SubBox` et leurs cas dans l’induction de substitution restent à établir ou à rattacher à un contrat externe effectivement instancié. |
| **C-04 — When et correction de ressource** | **OUVERT** | Décisions D5–D8 proposées dans les PR #174–#177 ; `Adm`, `Consume`, `ψ` et le coût non borné sont séparés conceptuellement. | Le contrat exact de traversée et l’intégration de l’admissibilité dans les règles ne sont pas prouvés. L’interprétation normative P3/When et la question de savoir si le coût non borné doit être rejeté sous budget fini restent explicitement à résoudre. |
| **C-05 — W, D, Cost_Budget** | **PARTIEL** | D3/D4 enregistrent dans les PR #172–#173 la scalarisation `max(W,D)` et `sup ∅ = 0`. Une preuve arithmétique supplémentaire est préparée dans `src/K7pl/GradeBudget.lean`. | Les agrégateurs sur la famille temporelle, leurs lois de composition, monotonie, nullité et minimalité ne sont pas formalisés ; la correspondance avec l’interface normative C2 reste à vérifier. |
| **C-06 — substitution** | **OUVERT** | La source expose `thm:substitution`, la substitution simultanée et une induction esquissée ; D11 ordonne l’audit de ses dépendances. | Pas d’induction Lean complète ; les cas par constructeur, conversions, contextes partagés, `ψ`, effets répétés, fraîcheur et compatibilité restent à prouver. |
| **C-07 — simulation sémantique** | **OUVERT** | Audit règle par règle de la traduction annoncé dans `C-07-SIMULATION-AUDIT.md`. | `Sim` n’a pas de contrat complet sur configurations/traces/canaux et n’est pas démontrée pour chaque règle. Aucune équivalence, bisimulation ou pleine abstraction n’est justifiée. |
| **C-08 — mémoire H1/H2/H3** | **OUVERT** | Les hypothèses et le profil `Π` sont documentés ; l’audit localise le cas incomplet d’élimination d’arène. | Choix A/B pour H1 non ratifié ; H2 et H3 n’ont pas de preuves séparées ; les affirmations de représentation n’ont pas de rattachement complet à un profil Π versionné. |
| **C-09 — dépendances externes** | **OUVERT** | Un inventaire distingue le rôle des cadres cités de la preuve d’une instance K7PL. | Il manque encore des mappings détaillés, hypothèses/version/fragment par import et la ratification du rôle des références en suspens. P1a (cadre) ne constitue pas P1b (interprétation et correction). |

Les étiquettes d’état `PARTIEL` et `OUVERT` sont des conclusions d’audit, pas des statuts formels du langage.

## 3. Résultat formel ajouté : arithmétique budgétaire limitée

Le fichier candidat [`src/K7pl/GradeBudget.lean`](../../src/K7pl/GradeBudget.lean) définit la soustraction tronquée sur `ℕ∞` selon D8, prouve la loi de compatibilité pour toute multiplicité naturelle **finie** et fournit un contre-exemple à l’extension à une multiplicité infinie. L’objet est isolé sous `K7pl.GradeBudget` et relié au module racine pour qu’il fasse partie de la compilation de la bibliothèque.

Ce résultat, même si sa compilation est validée par CI, ne prouverait que les identités arithmétiques énoncées dans ce module. Il ne prouverait pas :
- le domaine de l’opération partielle `Consume` ;
- la correction de `ψ` ou le refus d’un franchissement inadmissible ;
- une compatibilité générale avec les grades rationnels ;
- la substitution K7PL ou l’invariant instrumenté de correction de ressource ;
- les agrégateurs temporels `W`, `D` et `Cost_Budget`.

La loi arithmétique reste donc un candidat formellement vérifiable à rattacher à des lieux d’usage prouvés, pas une prémisse universelle autorisée par son seul nom.

## 4. Audit D11 : références historiques et usage actuel de la loi

La revue consolidée cite les anciens numéros « Th. 38, 41, 45, 47 (LET/APP), 48/27, 32 ». La table [`correspondance-theoremes-org.md`](../history/correspondance-theoremes-org.md) montre que la numérotation « relu » et la numérotation courante divergent, et que plusieurs nombres cités ne sont pas des numéros « relu » dans cette table. Certains rapprochements sont possibles — par exemple le 38 relu correspond à `thm:correction_ressource`, le 41 à `thm:commutation_traduction` et le 32 à `thm:commutation_monoide` — mais cela ne réconcilie pas tous les cas et n’établit pas quelles expressions de budget les preuves invoquaient réellement. Voir l’[addendum D11](L1-D11-AUDIT-MULTIPLICITY-SITES-2026-10-11.md).

Sur les sources actuelles :
- `thm:coherence_usage` sépare `Scale_Usage` (usage seulement) et `ψ` (budget) ; il ne requiert pas `n(β ⊖ k)=nβ ⊖ nk`.
- `thm:action_parallele` traite travail et profondeur pour multiplicité naturelle finie et exclut explicitement la transformation du budget.
- `thm:substitution` sépare action de contexte et transformation d’effet ; l’esquisse ne prouve pas l’identité budgétaire.
- `thm:coherence_axiome` reste une obligation de compatibilité générale dont la composante budget dépend d’une action et d’un domaine commun qui restent à définir.
- `thm:correction_ressource`, `thm:commutation_traduction` et `thm:expansion_macro` ne possèdent pas de preuves Lean correspondantes. Il faut déterminer l’usage effectif de la loi dans chaque dérivation, plutôt que de leur attribuer une dépendance par numérotation historique.

**Conclusion D11 : partiellement exécutée.** Le rapprochement a progressé, mais il reste incorrect de prétendre que les six sites historiques ont tous été audités et classés définitivement.

## 5. Décisions et travaux bloquants pour fermer C

Le présent chantier a pu produire un état de preuve plus précis et une première brique arithmétique, mais ne peut convertir les choix suivants en décisions d’autrice implicites :

1. **P3/When (C-04).** Le registre contient la scalarisation du coût et le principe de couverture du budget, mais la sémantique normative exacte du report et de la latence doit être fixée, puis reflétée dans la règle et prouvée.
2. **H1/H2/H3 (C-08).** Il faut choisir si H1 est prouvée via un contrat complet d’élimination d’arène ou assumée explicitement comme hypothèse de modèle ; H2/H3 ont leurs propres contrats et preuves. La portée des garanties dépend de ce choix.
3. **Dépendances importées (C-09).** Le rôle normatif des théories citées et les hypothèses reprises doivent être approuvés objet par objet ; aucune citation ne vaut transfert automatique de preuve.

Même après ces choix, restent les formalismes non documentaires C-03 à C-07 et les preuves de composition de C-05. Ce sont des obligations de fond, pas des tâches de présentation qu’un nouveau rapport peut clôturer.

## 6. Critère de réévaluation

La porte C pourra faire l’objet d’un nouvel audit de sortie lorsque :
- les décisions de conception restantes seront intégrées explicitement ;
- chaque objet central aura un type, domaine et préconditions canoniques ;
- chaque loi invoquée sera soit prouvée sur son domaine, soit déclarée hypothèse externe avec une instanciation et une portée vérifiées ;
- la substitution, la correction de ressource et la simulation seront prouvées règle par règle dans un artefact formel relié aux énoncés et aux règles Verso ;
- H1/H2/H3 seront traitées séparément et les affirmations de représentation bornées par un profil Π explicite ;
- les références et versions externes seront entièrement rapprochées et la traçabilité vers les preuves sera reproductible ;
- une revue humaine indépendante vérifiera le SHA exact de l’ensemble intégré.

## 7. Verdict

**La porte scientifique C reste NON SATISFAITE.** La chaîne #170–#180 est ouverte et non intégrée ; les décisions consignées ne remplacent pas l’harmonisation de la source. L’ajout arithmétique est local et ne décharge pas les obligations C-03/C-04/C-06/C-07/C-08/C-09. Aucun succès de rendu, de test ou de CI n’est présenté comme preuve scientifique de ces objets.

Aucune modification de `spec/` n’a été effectuée dans ce chantier. La modification de `src/` est strictement limitée à l’arithmétique des budgets explicitement consignée dans la chaîne D8–D11. Aucune PR n’a été fusionnée.
