# Reste à faire

Vue **produite** par `scripts/suivi.py reste` à partir de [`fiches-statuts.csv`](fiches-statuts.csv) (colonnes `nature`, `avancement`, `suite`, `depend`). Ne pas éditer ce fichier : tenir le CSV.

**32 fiches** restent à traiter sur 190 ; 156 sont fermées, 2 écartées. `avancement` est une estimation du travail accompli sur la fiche, pas une mesure.

| Nature | Fiches | Avancement moyen |
|---|--:|--:|
| À ratifier (appliqué, non confirmé) | 15 | 84 % |
| Travaux de conception | 1 | 10 % |
| Preuves à conduire | 7 | 57 % |
| Contrôles et outillage | 1 | 90 % |
| Recherches et vérifications de sources | 8 | 43 % |

## À ratifier (appliqué, non confirmé)

| Fiche | Titre | Avancement | Prochaine étape | Dépend de |
|---|---|--:|---|---|
| `BLOQ-12` | Le Th. 18 n'établit aucun homomorphisme et sa conclusion sur les lois de la théorie des ro | 90 % | ratifier la définition de ∘ et δ (extension sans source ; réunion d'étiquettes |  priorité fixe ou retrait) ; lire Carlström 2004 dans son corps (accès fermé) |
| `STRUCT-06` | Le pipeline n'a pas de Phase 0 ; « élaboration » désigne deux opérations différentes | 90 % | ratifier la numérotation consécutive (décision de l'auteur : renuméroter toutes les phases ; le choix du schéma est le nôtre) |  |
| `STRUCT-16` | Quatre régimes de grade théoriques, trois exposés : la clôture n'est pas établie | 90 % | ratifier |  |
| `PREUVE-05` | Écrire les règles de la loi distributive graduée et vérifier leur cohérence | 90 % | ratifier la loi affaiblie ; relire LET/APP |  |
| `FACT-09` | L'inexpressibilité comme unique mode de garantie, et la réduction des familles d'erreurs | 90 % | ratifier l'appariement ; décider si l'annexe A reprend les quatre messages-types | — |
| `FACT-14` | Cadre unique des structures monotones | 90 % | ratifier |  |
| `ARB-PR-04` | Le statut du rejeu bit-à-bit | 90 % | ratifier la voie B puis C ; repli sur la voie A si la réalisation ne peut la tenir |  |
| `STRUCT-01` | Inversion d'antériorité : le jugement germinal n'est pas germinal | 85 % | ratifier avec TRANS-02 | TRANS-02 |
| `IMPL-04` | Structure réelle des boîtes aux lettres et protocole d'appariement atomique | 85 % | ratifier la topologie ; lire le corps de BIB-04 et BIB-27 | BIB-04, BIB-27 |
| `FACT-12` | Adjonction graduée unifiant coeffets et effets | 85 % | ratifier avec TRANS-02 | TRANS-02 |
| `TRANS-02` | Décomposition module × ordre du grade | 85 % | ratifier (table de sédimentation et fragments du ch. 2 repris selon les images réciproques, séance 32) | — |
| `IMPL-07` | Table de propagation des singularités | 80 % | ratifier les tables et la règle d'entrée ; vérification par test différentiel à l'implémentation (hors ∞+∞ de même signe) | BLOQ-12 |
| `ARB-PR-03` | Le traitement des effets à portée | 80 % | ratifier ℰ_alg / ℰ_scoped ; BIB-01 reste non instruit | — |
| `STRUCT-05` | La trace τ est à la fois grandeur de coût à optimiser et observable de sûreté à préserver  | 70 % | ratifier l'ordre de préservation ; écrire les trois lemmes de compatibilité | TRANS-04 |
| `TRANS-04` | Déclarer ce qu'une passe, une représentation et un environnement doivent préserver | 70 % | ratifier ; écrire les trois lemmes de compatibilité | STRUCT-05 |

## Travaux de conception

| Fiche | Titre | Avancement | Prochaine étape | Dépend de |
|---|---|--:|---|---|
| `PREUVE-02` | Th. 36 : préservation graduée par abaissement | 10 % | conduire passe par passe sur le fragment monomorphisé ; objectif déclaré (ARB-PR-06) | BIB-03 |

## Preuves à conduire

| Fiche | Titre | Avancement | Prochaine étape | Dépend de |
|---|---|--:|---|---|
| `BLOQ-05` | Le niveau d'un calcul est invoqué par cinq démonstrations et produit par aucune règle ; le | 80 % | conduire l'induction sur les règles de couche 2 ; relire la préservation et la non-interférence sous les clauses | PREUVE-03 |
| `PREUVE-04` | Th. 7 (divulgation délimitée) : l'esquisse est circulaire | 80 % | conduire le lemme fondamental sur tous les cas | PREUVE-05 |
| `PREUVE-07` | Lemme de simulation entre `→` et `⟦·⟧` | 80 % | conduire l'induction sur les schémas écrits ; clauses de traduction manquantes (formes de ANOM-17 comprises) | — |
| `PREUVE-03` | Non-interférence graduée sur le fragment avec communication | 65 % | conduire l'induction du lemme fondamental sur la couche 2 (apparentement des boîtes) ; clause de traduction du fil pour l'application, l'opération à portée et spawn ; délégation ; déterminisme observationnel | BIB-26 |
| `BLOQ-07` | Deux sémantiques opérationnelles concurrentes, sans théorème d'accord | 50 % | conduire la simulation Sim sur les schémas écrits ; écrire les clauses de traduction du copatron, de la couche 2, de la fourche-jointure, des modalités temporelles, de la localisation et de la déclassification | PREUVE-07 |
| `FACT-10` | Séquencement dans la quantale et préfixage dans le calcul de processus | 30 % | factoriser quantale et préfixage une fois la simulation conduite | PREUVE-07 |
| `PREUVE-01` | Th. 45 (correction de ressource) : la dette la plus lourde, et deux postulats en dépendent | 20 % | conduire la correction de ressource (potentiel) ; route calf/decalf | BIB-20 |

## Contrôles et outillage

| Fiche | Titre | Avancement | Prochaine étape | Dépend de |
|---|---|--:|---|---|
| `IMPL-08` | Renforcer le croisement mécanique grammaire × règles | 90 % | porter le contrôle des occurrences effectives des métavariables si on le juge utile | — |

## Recherches et vérifications de sources

| Fiche | Titre | Avancement | Prochaine étape | Dépend de |
|---|---|--:|---|---|
| `BIB-12` | Extension additive de la logique linéaire classique, transport intuitionniste | 70 % | lire le corps : extension additive et possibilité de la transporter à l'intuitionniste | — |
| `BIB-04` | Join-calculus de Fournet–Gonthier [60] — file de jonction | 50 % | join-calculus confirmé ; protocole = IMPL-04 | — |
| `BIB-21` | Théorie des types graduée formalisée (Abel–Danielsson–Eriksson) | 50 % | confirmé ; restriction sur l'égalité définitionnelle à lire dans le corps | — |
| `BIB-24` | Théorie cubique sans types Glue (XTT et variantes) | 50 % | XTT : extensionnalité sans univalence ; compatibilité avec la sédimentation à instruire | — |
| `BIB-25` | Algèbre de Kleene concurrente (Hoare, Möller, Struth, Wehrman) | 50 % | loi d'échange confirmée ; compatibilité avec la résiduation à vérifier | — |
| `BIB-27` | Types de boîtes aux lettres (de'Liguoro–Padovani, ECOOP 2018) ; *Special Delivery* (Fowler | 50 % | confirmé ; théorème d'interblocage à lire | — |
| `PREUVE-16` | Th. 3 : transposition graduée de la préservation des conteneurs | 30 % | transposition graduée de la sédimentation ; type de chemin cubique absent de l'outil | BIB-14, BIB-24 |
| `BIB-01` | *Hefty Algebras* (Van der Rest & Bach Poulsen, 2023/2025) | 0 % | ne pas instruire tant que ARB-PR-03 n'est pas ratifiée | ARB-PR-03 |
