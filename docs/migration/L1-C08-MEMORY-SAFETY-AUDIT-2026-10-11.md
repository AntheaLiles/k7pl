<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C-08 — Audit de justification de la sûreté mémoire, H1/H2/H3 et profil Π

**État :** audit documentaire provisoire ; aucune décision normative ni ratification de l’autrice.  
**Révision source examinée :** `main` — `1dc5beb460a426a2974c0415766670f9ed25c510` (11 octobre 2026).  
**Périmètre :** `spec/Spec/C4/ModelesDeMemoire.lean`, les règles d’arène et de découpe en C3, la contrainte de délimiteurs en C5 et les registres sémantiques C-08.  
**Limite épistémique :** lecture des sources documentaires Verso et des esquisses complètes ; ce document n’est ni une preuve Lean, ni une ratification, ni un contrôle d’exécution.

## 1. Conclusion de l’audit

La sûreté spatiale (`thm:surete_spatiale`) est énoncée **sous H1, H2 et H3**. Elle ne les démontre pas. La proposition `thm:introduction_unique` ambitionne de prouver plusieurs conclusions différentes — unicité d’introduction, acyclicité des destinations et terminaison de la construction d’arène — mais son esquisse déclare expressément que le cas d’élimination de l’arène reste à écrire et que H1 en dépend.

Le graphe des références de labels n’est pas cyclique : le bloc `thm:introduction_unique` référence `thm:surete_spatiale` pour nommer H1 ; le bloc de sûreté ne référence pas l’autre proposition par label. Le lien direct est donc une **arête syntaxique à sens unique**, pas un cycle syntaxique.

Le défaut de justification est réel, mais doit être formulé avec précision : l’esquisse disponible ne montre pas que le théorème de sûreté est effectivement utilisé comme prémisse pour prouver H1. Elle révèle plutôt un **cas de base non justifié** dans la proposition d’introduction unique. Il y aurait circularité de justification si ce résultat conditionnel était ensuite utilisé pour établir l’hypothèse dont il dépend ; ce chemin de preuve n’est pas établi par les blocs présents. L’absence du cas d’élimination d’arène suffit à empêcher de considérer H1 comme indépendamment prouvée.

**État retenu pour cet audit :**
- H1 : non démontrée indépendamment par les sources examinées ; cas d’introduction initiale via élimination de l’arène non traité.
- H2 : justification arithmétique annoncée, mais la liaison formelle entre disjonction de `Range` et identité/non-chevauchement des régions doit être spécifiée.
- H3 : contrainte de langage documentée, mais l’argument spécifique empêchant toute capture cartésienne d’une capacité linéaire doit être prouvé au niveau des règles et des contextes.
- Π : périmètre de représentation/exécution ; il ne remplace aucune de ces obligations abstraites et ne garantit pas par lui-même la conformité concrète.

## 2. Sources et faits vérifiés

- [Bloc complet de `ModelesDeMemoire.lean`](https://github.com/AntheaLiles/k7pl/blob/1dc5beb460a426a2974c0415766670f9ed25c510/spec/Spec/C4/ModelesDeMemoire.lean) : `thm:surete_spatiale` est marqué `state=under-review`, `evidence=proofsketch`, `scope=memory-safety`. Il pose H1/H2/H3 dans son énoncé et dit que la linéarité empêche la duplication d’une capacité donnée, mais n’empêche pas l’introduction de deux capacités distinctes sur une même région.
- Même source, `thm:introduction_unique` : `role=proposition`, `state=under-review`, `evidence=proofsketch`. Le texte regroupe l’unicité, l’absence de cycles et la terminaison ; il explicite que H1 dépend encore du cas d’élimination de l’arène.
- [Règles de typage C3](https://github.com/AntheaLiles/k7pl/blob/1dc5beb460a426a2974c0415766670f9ed25c510/spec/Spec/C3/ReglesDeTypage.lean), section sur les connecteurs restants et règle `Slice` : la source dit que l’élimination de l’arène n’est pas donnée dans ce jeu de règles et qu’elle doit être spécifiée à partir du chapitre 4 ou admise comme paramètre. La règle `Slice` consomme une capacité déjà détenue pour produire deux capacités sur des segments disjoints.
- [S-expressions universelles, C5](https://github.com/AntheaLiles/k7pl/blob/1dc5beb460a426a2974c0415766670f9ed25c510/spec/Spec/C5/SExpressionsUniverselles.lean) : le sens d’imbrication des délimiteurs et les rejets `ERR-TOP-001` sont explicités ; la preuve de la conséquence mémoire pour toute capture cartésienne reste à établir.
- [Revue sémantique des dépendances](../tracking/LEAN-DEPENDENCY-SEMANTIC-REVIEW.md) et [audit C8, lot 11, dernière version](https://github.com/AntheaLiles/k7pl/blob/0dd701cba6ae6bdcc35377638a92c375df03be29/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-11.md) (obligations reprises au [registre de migration](../tracking/LEAN-STATEMENT-MIGRATION.md)) consignent déjà le blocage sans promouvoir le statut épistémique.
- [Registre C-08](L1-THEORY-OBJECTS.md) conserve le critère de clôture : H1 indépendamment prouvée ou explicitement admise avec portée déclarée, H2/H3 prouvées séparément et affirmations concrètes bornées par un Π versionné. Le registre lui-même n’est pas modifié par cet audit.

Ces sources sont des blocs de spécification et des esquisses textuelles. Aucune compilation Verso, règle syntaxique, recherche de labels ou réussite CI ne constitue une preuve mathématique de H1/H2/H3.

## 3. Graphe contrôlé des dépendances

Le graphe de justification visé par les textes peut être représenté ainsi :

```text
Règle Arena-Elim + contrat de provenance/identité des régions
                 │
                 └── ? preuve indépendante de H1 (unicité)
                              │
                              ▼
H2 : disjonction Range ─────► sûreté spatiale ◄───── H3 : discipline d’imbrication
                                     ▲
                                     │
                            règle Par + lemme de capacité
```

Le point d’interrogation est substantiel. La règle `Slice` couvre la découpe d’une capacité existante : elle consomme la capacité source et produit deux capacités de segments disjoints. Elle ne résout pas le cas racine où l’élimination de l’arène produit la capacité portant sur la région entière. Pour prouver H1 par induction sur les dérivations, il faut couvrir explicitement ce cas racine et exclure toute autre introduction, coercion ou passerelle qui pourrait recréer une capacité sur la même région.

La relation de référence de labels observée est `thm:introduction_unique → thm:surete_spatiale`. Elle identifie l’hypothèse nommée ; elle ne prouve pas que `thm:surete_spatiale` soit une prémisse valide de la preuve d’introduction unique. Il ne faut donc ni faire signaler ce couple comme un cycle syntaxique, ni déclarer le problème de justification résolu.

## 4. H1 — trois voies possibles, aucune sélectionnée

### Voie A — établir H1 indépendamment à partir des règles

**Hypothèses/contrats à rendre explicites :**
- la règle complète d’élimination de l’arène et son contrat de consommation de la ressource arène ;
- le sens exact de « même région » : identité d’arène, identité de segment, égalité sémantique ou chevauchement concret ;
- la génération initiale de `WriteCap`, son lien à l’arène consommée et l’absence d’autres constructeurs qui créent une capacité équivalente ;
- la linéarité du contexte fermé, la portée de `Par` et les conversions autorisées qui transportent les capacités.

**Obligations et règles concernées :** formaliser `Arena`/Arena-Elim depuis le modèle mémoire ; démontrer le cas racine ; démontrer que `Slice` ne fait que consommer une capacité existante et partitionner sa région ; couvrir toutes les règles, conversions et chemins de frontière pertinents ; fournir une induction sur la dérivation pour H1. Séparer cette preuve d’un argument de terminaison : une mesure strictement décroissante peut établir la terminaison ou l’acyclicité, mais pas à elle seule l’unicité sémantique des régions.

**Preuve minimale attendue :** un énoncé bien typé du contrat Arena-Elim, puis un théorème d’unicité quantifié sur les dérivations closes et tous les constructeurs de capacités, dont les cas sont couverts exhaustivement. Si la région est un objet concret, la preuve doit aussi établir que deux racines autorisées ne désignent pas silencieusement la même région.

**Conséquence :** H1 pourrait devenir un résultat indépendant et être ensuite utilisé comme prémisse de sûreté. Cela ne prouverait ni H2 ni H3.

### Voie B — conserver H1 comme hypothèse normative ou du modèle

**Hypothèse à déclarer :** pour une région donnée, au plus une capacité d’écriture est introduite dans le domaine explicitement indiqué — par exemple par une garantie du modèle d’arène, du compilateur ou de l’interface d’allocation.

**Preuve minimale attendue :** spécifier le domaine exact de l’hypothèse, les configurations auxquelles elle s’applique, les composants qui en sont responsables, et la façon dont le modèle/conformité garantit ce contrat. La démonstration de sûreté resterait explicitement conditionnelle à H1 ∧ H2 ∧ H3.

**Conséquence :** ne pas présenter `thm:introduction_unique` comme une preuve de H1. Il faut soit le laisser ouvert, soit réduire sa portée aux seules conclusions effectivement justifiées (par exemple des obligations distinctes d’acyclicité/terminaison, après leurs propres preuves). Une garantie de modèle ou de compilateur ne doit pas être attribuée aux seules règles de typage.

### Voie C — reformuler si plusieurs notions d’unicité ont été confondues

Cette voie n’est pertinente que si l’autrice confirme que le texte mélange réellement des objets différents. Il pourrait alors être nécessaire de distinguer :
- unicité de la lignée d’une capacité sous une identité d’arène donnée ;
- fraîcheur/absence d’alias entre les régions introduites par des arènes distinctes ;
- unicité ou sûreté d’une région dans la représentation concrète et l’exécution.

**Preuve minimale attendue :** définir séparément les relations d’identité, de découpe et de dénotation ; montrer quelle règle établit chacune ; reformuler les énoncés et leurs portées sur cette base. Il ne faut pas effectuer ce découpage par simple correction d’étiquette.

**Conséquence :** les résultats peuvent avoir des prémisses et des portées différentes. L’autrice doit confirmer cette distinction avant toute modification normative.

## 5. H2 — disjonction des intervalles, obligation séparée

L’esquisse donne, pour des intervalles valides `[a,b]` et `[c,d]` d’une même arène, le critère arithmétique `b < c ∨ d < a`. Ce calcul peut établir une disjonction des intervalles sous ses hypothèses de bornes et d’ordre. Il ne suffit pas de conclure que deux valeurs de `Range` désignent des régions distinctes tant que le modèle de dénotation n’est pas spécifié.

**Obligation minimale :**
1. définir le domaine admissible de `Range` et les conditions sur les bornes ;
2. définir la fonction/relations d’interprétation de `Range` en région mémoire ;
3. prouver que l’arithmétique de disjonction implique la disjonction des régions selon cette interprétation ;
4. si une revendication concrète est formulée, démontrer séparément l’adéquation entre cette interprétation et l’adressage/layout du profil Π.

Un solveur SMT peut décharger la formule arithmétique formalisée ; son succès ne prouve pas une relation de dénotation qui n’a pas été encodée. H2 reste ouverte indépendamment du choix qui sera fait sur H1.

## 6. H3 — discipline d’imbrication, obligation séparée

C5 définit le sens permis d’imbrication des délimiteurs et les rejets syntaxiques correspondants. Pour obtenir H3 comme propriété de sûreté mémoire, il faut prouver plus que le rejet syntaxique : aucune dérivation admissible ne doit permettre à une valeur cartésienne ou une fermeture duplicable de capturer une capacité d’écriture linéaire qui demeure accessible.

**Obligation minimale :**
1. formaliser les jugements/couches, les inclusions de contextes et le traitement des délimiteurs ;
2. démontrer que les constructeurs cartésiens et les substitutions qu’ils permettent ne peuvent pas capturer ou faire survivre une `WriteCap` linéaire ;
3. couvrir les paires de couches/délimiteurs pertinentes, les valeurs composées, fermetures, tuples, substitutions et conversions ;
4. soit prouver qu’une imbrication inverse n’a pas de dérivation typée, soit fournir le contre-exemple qui démontre pourquoi elle doit être rejetée.

L’existence d’un résultat dans la littérature sur les logiques adjointes motive la conception, mais ne fournit pas à elle seule l’instance et la preuve K7PL. H3 ne découle pas automatiquement de H1 ou H2.

## 7. Limites de Π et séparation des garanties

Le profil de représentation/exécution `Π` doit au minimum identifier :
- la version de la spécification et du langage (idéalement une révision immuable) ;
- la version de la représentation et de la formalisation concernées ;
- l’implémentation et la chaîne d’exécution, dont les outils/compilateur pertinents ;
- l’architecture et les paramètres matériels pertinents ;
- les paramètres d’exécution, entrées et état initial pertinents ;
- les sources de non-déterminisme qui influencent la revendication et la manière dont elles sont contrôlées, capturées ou rejouées.

Ces champs bornent une revendication ; ils ne constituent pas une preuve à eux seuls. Les propriétés suivantes doivent rester distinctes :

| Niveau | Revendication | Ce qui manque pour la justifier |
|---|---|---|
| Mémoire abstraite | Une capacité linéaire ne permet pas plusieurs écritures sur une région, sous H1/H2/H3. | Preuves indépendantes des hypothèses et exactitude du modèle abstrait. |
| Sémantique du langage | Les réductions préservent les invariants de sûreté mémoire. | Relation de réduction, préservation et liaison explicite entre typage et état mémoire. |
| Conformité concrète sous Π | L’implémentation respecte le modèle et les hypothèses pour ce profil précis. | Correspondance/formalisation validée et preuves ou tests adaptés à la chaîne déclarée. |
| Rejeu logique | Les mêmes observations sont reproduites selon une relation d’observation définie. | Journal complet des observations externes non déterministes, schéma et preuve de substitution des résultats enregistrés. |
| Identité bit-à-bit | Les octets d’un artefact ou résultat concret sont identiques dans le contexte étudié. | Artefacts, sérialisation, entrées/états, environnement et évidence sur ce Π exact. Ce n’est pas une propriété sémantique générale. |
| Conformité ABI | L’interface respecte layout, alignement, convention d’appel, propriété/lifetime et exigences FFI de la cible. | Contrat ABI explicite et validation indépendante sur versions/cibles déclarées. L’identité binaire ne l’implique pas. |

Ne pas revendiquer un rejeu bit-à-bit général sur la seule base de la sémantique ou d’une compilation réussie. La décision consignée dans `L1-DECISIONS.md` limite le bit-à-bit à une propriété concrète sous profil, si elle est effectivement établie.

## 8. Décisions humaines et blocages

L’autrice doit encore décider, sans que cet audit choisisse à sa place :

1. **H1 :** établir la preuve indépendante depuis Arena-Elim ; ou accepter explicitement H1 comme hypothèse de modèle/normative avec portée ; ou confirmer que des notions distinctes doivent être séparées.
2. **H2 :** ratifier la définition de `Range` et son lien à la sémantique des régions, de manière à savoir exactement quel énoncé doit être prouvé.
3. **H3 :** ratifier la discipline de délimiteurs/contextes qui sert d’invariant, puis exiger la preuve complète ou accepter que la garantie soit limitée.
4. **Π :** choisir la granularité du profil concret et les éléments de preuve exigés pour chaque revendication d’implémentation, de rejeu ou d’ABI.

Aucun de ces choix n’est inféré d’une séance, d’un résultat de compilation, d’un contrôle de syntaxe ou de la présence d’une référence bibliographique.

## 9. Changements et vérification de cette passe

Cette passe ajoute une analyse documentaire autonome uniquement. Elle ne change ni `spec/`, ni `src/`, ni les hypothèses/énoncés normatifs, ni les statuts des blocs ; elle ne modifie pas les registres déjà visés par des PR ouvertes et ne touche pas à `docs/STATUS.md`. Elle ne ferme ni C-08 ni la porte C.

**Preuve produite par cette passe :** aucune preuve mathématique nouvelle. Le résultat est une analyse contrôlable des dépendances et des obligations de preuve à partir des sources citées.

**Prochain pas autorisé :** obtenir la ratification de l’autrice sur la voie H1 et sur les contrats de H2/H3 ; ensuite seulement préparer la définition ou la preuve strictement requise dans un travail séparé et autorisé. Jusque-là, toute modification sémantique de `spec/` et toute déclaration de clôture restent bloquées.
