# K7PL — les fonctions primitives : questions de recherche

28 août 2026

## IDENTIFICATION DES PRIMITIVES

### DOING Désigner une liaison

    SYMBOLE: x | FAMILLE: noyau_CBPV | REGLE: Var | LEMME-RETENU: variable | LEMME-CANDIDAT: variable

variable  
Une occurrence d'un nom lié par une forme liante. Universel dans toute la littérature ; aucun langage ne le nomme autrement. Aucun.

### DOING Fabriquer un calcul qui attend un argument

    SYMBOLE: λx.M | FAMILLE: noyau_CBPV | REGLE: Lam | LEMME-RETENU | LEMME-CANDIDAT: lambda, fn, fun, abstraction

lambda  
Le mot de Church, et celui de la famille Lisp. Scheme, Clojure, Common Lisp l'emploient ; K7PL hérite de cette forme, et Anthea a établi que cet héritage est un acquis. Long à écrire dans le cas courant ; Oz a échoué en partie sur la verbosité de sa lambda.

fn  
Abréviation employée par Clojure et Standard ML. Brièveté du cas courant, qui est le critère 2 de l'arc G ; et la famille Lisp l'admet. Moins mnémonique pour qui n'a pas la culture ML.

fun  
Abréviation d'OCaml et de F#. Même argument de brièveté. Trois abréviations concurrentes dans la même famille : le critère 6 demande de choisir l'usuel, et il n'y en a pas un seul.

abstraction  
Le terme scientifique. Exact. Personne ne l'écrit dans du code.

### DOING Appliquer un calcul à une valeur

    SYMBOLE: M V | FAMILLE: noyau_CBPV | REGLE: App | LEMME-RETENU | LEMME-CANDIDAT: application, apply, juxtaposition

application  
Le terme scientifique ; et chez K7PL c'est AUSSI la composition, puisqu'il n'y a pas d'opérateur de composition séparé. Terme exact ; R-2 établit qu'il couvre les deux rôles. En forme Lisp l'application n'a pas de nom : elle est la forme elle-même. Le mot ne s'écrit donc jamais, sauf en diagnostic.

apply  
Le mot que Lisp emploie quand l'application doit être réifiée. Usuel dans la famille. Réserve à l'application dynamique ; ce n'est pas le même objet.

### DOING Suspendre un calcul en une valeur

    SYMBOLE: {M} | FAMILLE: noyau_CBPV | REGLE: Th | LEMME-RETENU: thunk | LEMME-CANDIDAT: thunk, suspend, delay, suspension

thunk  
Le mot de Levy et de toute la littérature CBPV. Universel dans le domaine ; critère 6 satisfait par l'usage. Et c'est le mot des trois références du fonds sur CBPV. Opaque pour qui vient d'ailleurs.

suspend  
Le verbe, plus explicite. c1 emploie déjà « suspension » en français. Non usuel dans la littérature CBPV, et il faudrait le défendre.

delay  
Le mot de Scheme pour la promesse. Famille Lisp. Chez K7PL le mot est pris : la modalité temporelle a une règle Del, et un délai n'est pas une suspension.

### DOING Reprendre un calcul suspendu

    SYMBOLE: V! | FAMILLE: noyau_CBPV | REGLE: Fo | LEMME-RETENU: force | LEMME-CANDIDAT: force, run, resume

force  
Le mot de Levy, et celui de Scheme pour la promesse. Doublement usuel : littérature CBPV et famille Lisp. Meilleur cas du critère 6 de tout l'inventaire. Aucun connu.

run  
Plus commun hors du domaine. Lisible sans culture préalable. Trop générique ; se confondrait avec l'exécution d'un programme.

### DOING Injecter une valeur dans un calcul trivial

    SYMBOLE: return V | FAMILLE: noyau_CBPV | REGLE: Ret | LEMME-RETENU: return | LEMME-CANDIDAT: return, produce, pure, unit

return  
Le mot de Levy et celui des monades. Universel. Dans la plupart des langages, return sort d'une fonction : le sens est presque inverse. Risque réel de contresens pour un arrivant.

produce  
Le verbe que la littérature CBPV emploie parfois pour éviter le contresens. Lève exactement l'objection ci-dessus. Moins usuel.

pure  
Le mot de Haskell pour le même rôle applicatif. Usuel dans la famille fonctionnelle. Chez K7PL le mot est PRIS : pure est l'un des cinq mots-clés réservés en position de tête, et il exige un effet vide. Collision à éviter.

### DOING Séquencer deux calculs en liant le résultat du premier

    SYMBOLE: x ← M in N | FAMILLE: noyau_CBPV | REGLE: Let | LEMME-RETENU | LEMME-CANDIDAT: bind, let, do, sequence

bind  
Le mot des monades et de la littérature CBPV. Exact et usuel dans le domaine. Chez K7PL, bind-to a déjà été employé au chapitre 5 pour un accès de champ, et bind-left / bind-right sont des alias glyphiques. Le mot est encombré : trois emplois pour un seul terme.

let  
Le mot de la famille Lisp et ML pour une liaison. Usuel, court, et la forme (let \[x M\] N) est immédiatement lisible. En CBPV la liaison séquentielle n'est pas un let ordinaire : elle exige que M s'évalue en un return. Le mot masquerait cette exigence.

do  
La notation de Haskell pour l'enchaînement. Brièveté du cas courant, et il est le cas courant. Suppose un bloc, donc une forme différente de la forme générale.

### DOING Dénoter la seule valeur du type unité

    SYMBOLE: () | FAMILLE: connecteurs | REGLE: One | LEMME-RETENU | LEMME-CANDIDAT: unit, nil, void

unit  
Le terme scientifique. Exact ; c'est le nom du type. Le nom du type et celui de la valeur sont alors les mêmes, ce qui demande que le langage sépare les deux espaces de noms — critère 1.

nil  
Le mot de Lisp. Famille. Chez Lisp, nil est aussi la liste vide et le faux : trois travaux pour un mot, ce que l'arbitrage 23 proscrit.

void  
Le mot des langages à la C. Connu très largement. Void y désigne l'absence de valeur, pas une valeur unique : contresens.

### DOING Consommer l'unité sans rien lier

    SYMBOLE: let () = V in N | FAMILLE: connecteurs | REGLE: OneE | LEMME-RETENU | LEMME-CANDIDAT

(aucun candidat)  
Aucun candidat relevé : cette élimination n'a pas de nom dans la littérature, étant toujours écrite comme un motif. Question ouverte : faut-il un mot, ou la forme de motif suffit-elle ? Voir le débat motif contre forme dédiée, ouvert par la comparaison avec Granule.

### DOING Réunir deux ressources disjointes

    SYMBOLE: (V₁, V₂) | FAMILLE: connecteurs | REGLE: Pair | LEMME-RETENU | LEMME-CANDIDAT: pair, tensor, tuple, cons

pair  
Le mot usuel pour une paire. Immédiat. Ne dit pas la disjonction des ressources, qui est le contenu de P1.

tensor  
Le terme de la logique linéaire. Exact, et il porte la disjonction. Opaque hors du domaine ; et le symbole est déjà celui du produit tensoriel.

cons  
Le constructeur de Lisp. Famille. Chez Lisp, cons construit une paire pointée dont le second champ est une liste : ce n'est pas le même objet.

### DOING Défaire une paire en liant ses deux composantes

    SYMBOLE: let (x,y) = V in N | FAMILLE: connecteurs | REGLE: Split | LEMME-RETENU | LEMME-CANDIDAT: split, unpair, destructure

split  
Le verbe le plus direct. Court, et il dit ce qui se passe. Split est employé ailleurs pour découper une séquence : collision de sens possible dans la bibliothèque.

unpair  
Symétrique de pair. Cohérence de famille, qui est le critère 3. Peu usuel.

### DOING Marquer une valeur d'une étiquette de somme

    SYMBOLE: inj_i V | FAMILLE: connecteurs | REGLE: Inj | LEMME-RETENU | LEMME-CANDIDAT: inject, tag, variant

inject  
Le terme catégorique. Exact. Long, et le cas courant l'écrit souvent.

tag  
Le mot opérationnel. Court, et il dit ce qui est stocké. Suggère une représentation, alors que le constructeur est logique.

### DOING Choisir une branche selon l'étiquette

    SYMBOLE: case V of {i ↦ N_i} | FAMILLE: connecteurs | REGLE: Case | LEMME-RETENU | LEMME-CANDIDAT: case, match, switch

case  
Le mot de ML, de Haskell et de Scheme. Usuel dans les trois familles dont K7PL hérite. Aucun connu.

match  
Le mot d'OCaml et de Rust. Également usuel. Chez K7PL, le filtrage de motifs des R-expressions emploiera probablement ce mot : risque de collision entre le filtrage de sommes et le filtrage de textes.

### DOING Offrir plusieurs observations sur un même calcul

    SYMBOLE: ⟨M_i⟩ | FAMILLE: connecteurs | REGLE: With | LEMME-RETENU | LEMME-CANDIDAT: with, record, object, handler

with  
Le mot de la logique linéaire pour la conjonction additive. Exact. Opaque, et with est un mot très employé ailleurs.

handler  
Le mot que c4 emploie déjà pour l'acteur. Décrit l'usage réel : un acteur est la famille de ses réponses aux messages. Confond le type et son usage principal.

copattern  
Le terme d'Abel et Pientka : un objet défini par ce qu'on peut en observer. Terme scientifique exact, et il rattache l'acteur à une métathéorie faite. Nomme la méthode de définition, pas le constructeur.

### DOING Sélectionner une observation

    SYMBOLE: M.i | FAMILLE: connecteurs | REGLE: Proj | LEMME-RETENU | LEMME-CANDIDAT: project, select, send

project  
Le terme catégorique. Exact. Suggère un produit cartésien, alors qu'il s'agit d'un produit additif où une seule branche est consommée.

send  
Le mot des acteurs. Décrit l'usage : sélectionner une observation d'un acteur, c'est lui envoyer un message. Ne vaut que pour l'usage acteur, pas pour le cas général.

### DOING Cacher un témoin de type

    SYMBOLE: pack (W, V) | FAMILLE: existentielle | REGLE: Pack | LEMME-RETENU: pack | LEMME-CANDIDAT: pack, seal, abstract

pack  
Le mot de la littérature sur les existentiels. Usuel et exact. Aucun connu.

seal  
Le mot de la littérature sur les modules. Dit l'intention — rendre inatteignable. Moins usuel pour l'existentiel lui-même.

### DOING Ouvrir un témoin caché sans le laisser fuir

    SYMBOLE: open V as (α,x) in N | FAMILLE: existentielle | REGLE: Open | LEMME-RETENU | LEMME-CANDIDAT: open, unpack

open  
Le mot du manuscrit et de la littérature modulaire. Usuel. Open est très employé ailleurs, notamment pour les fichiers.

unpack  
Symétrique de pack. Cohérence de famille, critère 3. Aucun connu.

### DOING Entrer sous une modalité graduée

    SYMBOLE: box_r V | FAMILLE: gradation | REGLE: Box | LEMME-RETENU | LEMME-CANDIDAT: box, promote, grade

box  
Le mot de la logique modale, et celui du manuscrit. Usuel dans le domaine modal. Suggère un conteneur, alors que la modalité multiplie le contexte.

promote  
Le mot de la logique linéaire pour cette règle. Exact au sens de la règle. Brunel et Vollmer établissent que la promotion est une RÈGLE et non un terme : employer le mot pour le terme brouillerait cette distinction, qui est acquise.

grade  
Le mot du projet. Cohérent avec le vocabulaire interne. Le document emploie déjà grade pour l'élément de l'algèbre ; le réemployer pour le constructeur ajouterait un troisième sens à un mot qui en a déjà deux.

### DOING Sortir d'une modalité graduée en restituant le grade

    SYMBOLE: unbox V as x in N | FAMILLE: gradation | REGLE: Unbox | LEMME-RETENU | LEMME-CANDIDAT: unbox, extract, let-box

unbox  
Symétrique de box. Cohérence de famille. Aucun connu.

extract  
Le mot des comonades. Exact catégoriquement. Extract est la counité de la comonade, donc la déréliction — qui est une règle, non ce terme.

### DOING Interpréter un calcul à effets dans un modèle donné

    SYMBOLE: handle / sc_f(V, M) | FAMILLE: effets | REGLE: Sc | LEMME-RETENU | LEMME-CANDIDAT: handle, handler, with, interpret

handle  
Le mot de Plotkin et Pretnar, et de tous les langages à effets. Universel dans le domaine. Aucun connu.

interpret  
Décrit ce que fait le gestionnaire : appliquer l'unique homomorphisme du modèle libre vers un modèle défini. Exact. Long, et non usuel.

with  
Le mot d'Eff et de Koka pour la forme d'installation. Usuel dans deux langages à effets. Collision avec la conjonction additive, dont le nom logique est with.

### DOING Déclencher une opération de la signature

    SYMBOLE: perform_op(V) | FAMILLE: effets | REGLE: Op | LEMME-RETENU | LEMME-CANDIDAT: perform, do, raise, invoke

perform  
Le mot d'Eff et d'OCaml 5. Usuel dans les deux implantations d'effets les plus visibles. Aucun connu.

do  
Le mot de Frank. Court. Collision avec la notation d'enchaînement de Haskell, qui est un autre objet.

raise  
Le mot des exceptions. Familier. Une opération d'effet n'est pas une exception : elle peut reprendre. Contresens.

## REVUE PRIMITIVE / DÉRIVÉ

### DOING Replier un point fixe de type

    SYMBOLE: fold | FAMILLE: connecteurs | REGLE: Fold | LEMME-RETENU: fold | LEMME-CANDIDAT: fold

Faire d'une valeur du type déplié une valeur du type récursif lui-même.

repliage  
Le terme reçu, de Malcolm à la littérature des schémas de récursion. Aucun concurrent.

### DOING Déplier un point fixe de type

    SYMBOLE: unfold | FAMILLE: connecteurs | REGLE: Unfold | LEMME-RETENU: unfold | LEMME-CANDIDAT: unfold

L'inverse du repliage : exposer un cran de la structure d'un type récursif.

dépliage  
Le terme reçu, et l'inverse exact du précédent. Aucun concurrent.

### DOING Observer un point fixe coinductif

    SYMBOLE: out | FAMILLE: connecteurs | REGLE: Out | LEMME-RETENU: observation | LEMME-CANDIDAT: observation

Exposer un cran d'un flux, en consommant une unité de sa taille.

observation  
Le terme reçu depuis la coalgèbre terminale, où `out` est la structure elle-même. Le mot dit ce que l'on obtient plutôt que ce que l'on fait, ce qui convient à un connecteur dont l'emploi est passif.

dépliage coinductif  
Écarté. Le dépliage est déjà pris par `unfold`, du côté inductif, et employer le même mot des deux côtés effacerait la seule chose qui les distingue — l'un rend une structure, l'autre en consomme la disponibilité.

### DOING Définir par observations

    SYMBOLE: \\langle\\!\\langle j \\mapsto c_j \\rangle\\!\\rangle | FAMILLE: connecteurs | REGLE: Cop | LEMME-RETENU: copatron | LEMME-CANDIDAT: copatron

Définir un flux par ce qu'il rend à chaque observation, plutôt que par ce qu'il construit.

copatron  
Le terme d'Abel et Pientka, et le seul en usage. Le préfixe dit exactement le rapport au filtrage par motif : là où un motif décompose une entrée, un copatron compose une sortie.

comotif  
Écarté. Le calque est plus littéral mais moins parlant, et il n'a pas d'usage établi en français.

### DOING Généraliser sur une variable de type

    SYMBOLE: \\Lambda\\alpha. c | FAMILLE: connecteurs | REGLE: Gen | LEMME-RETENU | LEMME-CANDIDAT

Abstraire un calcul sur une variable de type absente du contexte — le dual de la mise en paquet existentielle.

généralisation  
Le mot de Damas et Milner, et de toute la littérature du polymorphisme. Concurrent : « abstraction de type », plus long et moins employé.

### DOING Instancier une variable de type

    SYMBOLE: c\\,[W] | FAMILLE: connecteurs | REGLE: Inst | LEMME-RETENU | LEMME-CANDIDAT

Substituer un type à la variable qu'un calcul généralisé a abstraite.

instanciation  
Le mot de Damas et Milner. Concurrent : « application de type », qui dit la forme et non l'acte.

### DOING Différer un calcul d'un pas

    SYMBOLE: delay | FAMILLE: temporelles | REGLE: Del | LEMME-RETENU | LEMME-CANDIDAT

Reporter un calcul au pas suivant du calendrier, sans en changer le contenu.

différer  
À arbitrer au temps 2. Le pas est unique — voir le verdict rendu le 8 septembre.

### DOING Poser une garantie permanente

    SYMBOLE: always | FAMILLE: temporelles | REGLE: Alw | LEMME-RETENU | LEMME-CANDIDAT

Attester qu'une valeur est disponible à tout instant, sous un contexte lui-même permanent.

toujours  
À arbitrer au temps 2.

### DOING Employer une garantie permanente

    SYMBOLE: at | FAMILLE: temporelles | REGLE: Alw^{-} | LEMME-RETENU | LEMME-CANDIDAT

Lire, à un instant donné, une valeur attestée disponible à tout instant.

à  
À arbitrer au temps 2. Le mot actuel est une préposition, ce qui rompt la règle de forme des constructeurs.

### DOING Poser une garantie immédiate

    SYMBOLE: now | FAMILLE: temporelles | REGLE: Now | LEMME-RETENU | LEMME-CANDIDAT

Attester qu'une valeur est disponible dès maintenant, donc éventuellement.

maintenant  
À arbitrer au temps 2.

### DOING Reporter une garantie éventuelle d'un pas

    SYMBOLE: wait | FAMILLE: temporelles | REGLE: Wait | LEMME-RETENU | LEMME-CANDIDAT

Faire d'une garantie disponible au pas suivant une garantie éventuelle.

attendre  
À arbitrer au temps 2, et sous la décision rendue sur la contrainte manquante.

### DOING Consommer une garantie éventuelle

    SYMBOLE: when | FAMILLE: temporelles | REGLE: When | LEMME-RETENU | LEMME-CANDIDAT

Lier la valeur d'une garantie éventuelle dès qu'elle se présente, le résultat restant lui-même éventuel.

quand  
À arbitrer au temps 2, et sous la décision rendue sur la contrainte manquante.

### DOING Plier une famille indexée sous grade

    SYMBOLE: VecI/VecE | FAMILLE: gradation | REGLE: VecI VecE | LEMME-RETENU | LEMME-CANDIDAT

Introduire et éliminer une famille dont chaque position porte son propre grade — l'introduction multiplie le contexte par la longueur, l'élimination compose des effets qui diffèrent d'une position à l'autre.

pli indexé gradué  
Nommé ici en exécution de l'action que l'entrée du vecteur prescrivait. Le vecteur en est une instance, non une primitive.

### \[DONE\] Le vecteur — dérivé comme TYPE, non comme constructeur

    CONSTRUCTEURS: VecI, VecE | REF: altenkirchIndexedContainers2015 | VERDICT: type dérivé, constructeur à reformuler

Une famille strictement positive s'interprète par un conteneur indexé, lequel se construit dans un noyau à nombre fixe de constructeurs sans que ce noyau ait à être étendu. Le type du vecteur est donc dérivé, et il a une forme normale. Les deux règles ne le sont pas. L'introduction multiplie le contexte par la longueur, l'élimination compose des effets qui diffèrent d'une position à l'autre, et aucune réduction de conteneur ne donne cette arithmétique. La primitive dont ces règles sont une instance est le pli indexé GRADUÉ, que la liste ne nomme pas et que le document n'a pas isolé. Action : nommer le pli indexé gradué, et ranger le vecteur parmi ses instances.

### \[DONE\] La coalgèbre terminale — primitive, et il lui manque ses deux règles

    SYMBOLE: \\nu\\alpha. C | FAMILLE: connecteurs | REGLE: (manquantes) | CONSTRUCTEURS: nu | REF: altenkirchIndexedContainers2015, ABEL-COALG, abelWellfoundedRecursionCopatterns2016 | VERDICT: primitive, deux règles à écrire — tranché le 8 septembre

La question demandait si la coalgèbre terminale se dérive. Le croisement des trois jeux répond avant elle, et plus platement : $`\nu\alpha. C`$ figure à la grammaire des types et ****aucune règle de terme ne le gouverne**** — ni introduction, ni élimination. Sur les dix-neuf connecteurs de type du langage, c'est le seul orphelin non déclaré ; les trois formes de session sont de la syntaxe de surface sur l'implication linéaire, et l'arène est une exception que l'annexe déclare.

La productivité de la couche 2, sur laquelle le document appuie un théorème et deux garanties, repose donc aujourd'hui sur un connecteur qu'aucun terme n'habite.

LA VOIE DE LA DÉRIVATION EST FERMÉE, et les deux réserves que la question posait suffisent. La dérivation des M-types depuis les W-types suppose une théorie extensionnelle, et postule l'extensionnalité de la bisimulation plutôt que de la démontrer ; K7PL n'est pas extensionnel. Et rien n'établit que la chaîne survive à la gradation. Ce qu'apporte réellement la référence est autre chose, que le chapitre 2 emploie déjà : les conteneurs PRÉSERVENT les plus petits et les plus grands points fixes, de sorte que l'emboîtement de $`\mu`$ et de $`\nu`$ ne sort pas de la classe. C'est une clôture, non une dérivation — et les deux ont été confondues.

LA FORME DES DEUX RÈGLES EST DÉJÀ ARRÊTÉE AILLEURS. Le chapitre 4 écrit qu'un acteur est une définition par *copatrons*, et que la métathéorie de cette forme est faite dans le même cadre à tailles que le chapitre 2 emploie pour sa terminaison. L'introduction de $`\nu`$ est donc le filtrage par copatrons, et son élimination l'observation $`\mathsf{out}`$.

Action : écrire les deux règles. Ce n'est pas de la recherche, c'est de la transcription — le cadre est cité, la forme est fixée, et le document s'en sert déjà sans l'avoir posée.

coalgèbre terminale  
Le terme du chapitre 2, et celui de la littérature. Aucun concurrent.

### \[DONE\] Le diamant et ses trois formes — primitifs, et le verdict précédent était mal transporté

    CONSTRUCTEURS: now, wait, when | REF: dasParallelComplexityAnalysis, bahrDiamondsAreNot2021 | VERDICT: primitifs dans le cadre des types de session

Premier verdict, rendu sur la littérature de la programmation réactive : le diamant s'encode comme l'unité until A, donc il est dérivé et K7PL prend le dérivé pour primitif. Ce verdict est retiré. Il vaut pour le diamant de la logique temporelle en cadre de récursion gardée ; il ne vaut pas pour le diamant des types de session. Das, Hoffmann et Pfenning ajoutent les trois modalités conservativement comme constructeurs de types de session, sans until, et ce sont des primitives dans ce cadre. K7PL est dans ce cadre. Sixième faute de transport de la campagne, et toujours la même : une conclusion juste dans son cadre, appliquée hors de lui. Ce qui reste vrai des deux lectures, et qui est l'acquis : les deux diamants ne sont pas le même, l'un exprime un non-déterminisme sur la date et l'autre une vivacité stricte, et c'est la RÉCURSION qui décide. Sans récursion non restreinte, le sens fort est pleinement restauré — ce que K7PL satisfait sans le dire.

### \[DONE\] La règle d'élimination du diamant — la contrainte manque, et sa réparation coûte un connecteur

    SYMBOLE: when | FAMILLE: temporelles | REGLE: When | CONSTRUCTEURS: when | REF: dasParallelComplexityAnalysis | VERDICT: lacune réelle, réparation ARBITRÉE PAR ANTHEA — 8 septembre

La lacune est confirmée et l'annexe la décrit déjà : la règle est *trop permissive*, elle admet un contexte dont une liaison porterait une borne temporelle stricte alors que l'attente peut la dépasser, de sorte que la conclusion promet une borne que le contexte ne peut pas tenir.

CE QUE LA LISTE DISAIT EST FAUX SUR UN POINT, et c'est ce qui change la décision. Elle annonçait « réparable en une ligne ». L'annexe, qui a regardé, écrit l'inverse : la correction demande d'exiger de chaque liaison du contexte qu'elle soit sous la modalité DUALE de $`{\Diamond}`$, c'est-à-dire indéfiniment reportable — et cette duale n'existe pas dans la grammaire des types. La réparation coûte donc un connecteur de type nouveau.

Ce n'est plus une question de rédaction mais une décision de conception, et elle touche la condition de clôture : un connecteur ajouté doit se dériver de ce qui est posé, ou être admis comme extension motivée. Trois issues, et le choix revient à Anthea.

1.  Introduire la duale de $`{\Diamond}`$ dans la grammaire des types, et poser la contrainte. La règle devient correcte ; la grammaire gagne un connecteur, et la condition de clôture doit être réexaminée.
2.  Restreindre $`{\Diamond}`$ aux contextes déjà bornés. Aucun connecteur nouveau ; la modalité perd le cas que le chapitre 4 signale, celui du transducteur qui produit à un rythme que son entrée ne détermine pas.
3.  Laisser la réserve écrite, et ne pas employer $`{\Diamond}`$ dans le noyau exécutable. Coût nul aujourd'hui, dette portée.

attendre  
Le mot que la règle emploie déjà. À trancher avec la décision ci-dessus, la troisième issue rendant le nommage sans objet à court terme.

### \[DONE\] Le pas différé — une seule modalité suffit, et la raison se vérifie

    SYMBOLE: delay | FAMILLE: temporelles | REGLE: Del | CONSTRUCTEURS: delay | REF: bahrDiamondsAreNot2021, bahrModalFRPAll2022 | VERDICT: une seule — tranché le 8 septembre

Le conflit que Bahr décrit demande, pour détruire la terminaison, de prendre un point fixe GARDÉ afin de construire un élément divergent du diamant. K7PL n'en a pas les moyens, et pour deux raisons indépendantes qui se lisent sur la règle .

Son point fixe n'est pas gardé : la règle ne porte aucune prémisse en $`{\bigcirc}`$, et sa terminaison vient de la hauteur du treillis, non d'une garde. Et son domaine exclut le diamant : $`\mathsf{Trellis}_{\text{fin}}`$ est engendré par quatre clauses — un type de base à porteur fini, l'unité, une somme ou un produit de deux tels types, un vecteur de longueur finie — dont aucune n'admet une modalité temporelle. On ne peut donc pas prendre $`\mathbf{fix}`$ sur $`{\Diamond}V`$.

La configuration du conflit n'est pas réunie. Un seul pas différé suffit, et c'est celui de la logique temporelle.

Action : l'écrire au manuscrit, là où $`{\bigcirc}`$ est introduit — la garantie tient aujourd'hui sans que le texte dise pourquoi.

pas  
Le mot de la logique temporelle, et celui que le manuscrit emploie déjà. Aucun détracteur.

### \[DONE\] La déclassification — primitive, et le traitement actuel est le bon

    CONSTRUCTEURS: declassify | REF: rajaniGradedModalRelaxed2025 | VERDICT: primitive, confirmée

Un calcul qui possède déjà une monade graduée pour classer l'information doit lui AJOUTER une modalité pour déclassifier. La déclassification n'est donc pas une forme dérivée de la composante de confidentialité du grade. Deux choses restent à écrire, que la source nomme : l'interaction entre la modalité de déclassification et le grade se fait par des lois distributives, et la modalité ne forme une comonade que sous conditions. K7PL a déjà une loi distributive entre ressource et effet, la forme convient, mais il ne dit ni l'une ni l'autre.

### \[DONE\] Le point fixe déductif — primitive, et l'exclusion reposait sur une confusion

    SYMBOLE: fix | FAMILLE: noyau_CBPV | REGLE: Fix | CONSTRUCTEURS: fix | REF: DATAFUN | VERDICT: primitive — tranché le 8 septembre

La liste l'excluait au motif que la récursion générale est interdite dans les trois couches. La règle (chapitre 2, ) montre que ce n'en est pas : elle type une fonction MONOTONE d'un type dans lui-même, à condition que ce type appartienne à $`\mathsf{Trellis}_{\text{fin}}`$, et elle conclut sur un calcul PUR — $`\mathcal{E} = \emptyset`$.

Ce que le théorème établit achève de lever la contradiction : la suite $`x_0 = \bot`$, $`x_{n+1} = f(x_n)`$ est croissante et stationnaire en au plus $`h`$ étapes, $`h`$ étant la hauteur du treillis. C'est une itération bornée, pas un point fixe général. L'exclusion confondait deux objets que la règle distingue.

Action : la liste compte $`\mathbf{fix}`$ parmi ses primitives, et la phrase qui l'excluait est à corriger là où elle est écrite.

point fixe  
Le terme de la littérature des treillis et de Datafun. Aucun concurrent sérieux ; « récursion » serait faux, et c'est la confusion qu'on vient de lever.

### \[DONE\] Les constructeurs sans entrée — onze, et non trois

    VERDICT: liste complétée — 8 septembre

La question annonçait trois constructeurs. Le croisement de la grammaire, du jeu de règles et de cette liste en trouve ONZE, et la cause n'est pas l'oubli : la grammaire a reçu dix-sept constructeurs le 3 septembre, cette liste n'en a suivi aucun. Elle est tenue EN PARALLÈLE du jeu de règles au lieu d'en être dérivée.

Les onze entrées manquantes sont créées ci-dessous. Trois règles n'en reçoivent pas, et c'est correct : est une instance du schéma $`\mathsf{operation}`$ et non un constructeur, et sont interstitielles et ne gouvernent aucun terme. outils/controles/croise.py le sait déjà et les dispense.

Un contrôle nouveau interdit la rechute : toute règle gouvernant un constructeur de terme doit désormais porter son entrée ici, faute de quoi la passe échoue.

### \[DONE\] La codéréliction — écartée, et par une raison plus forte que celle qu'on cherchait

    SYMBOLE: (aucun) | FAMILLE: gradation | REGLE: (sans objet) | CONSTRUCTEURS: box, unbox | REF: lemayCoderelictionsFreeExponential2021, bluteDifferentialCategories2006 | VERDICT: pas de codéréliction — tranché le 8 septembre

Le théorème demande DEUX hypothèses : une catégorie de Lafont — exponentielle libre, $`!A`$ cofibre sur $`A`$ — et des biproduits finis. Le chapitre 2 refuse les deux, explicitement, et cite Lemay en le faisant : « K7PL ne suppose pas son exponentielle *libre* : la structure de comonoïde gradué y est donnée, non construite comme comonoïde cocommutatif cofibre sur $`A`$, de sorte que *C* n'est pas une catégorie de Lafont. Et K7PL ne suppose pas de biproduits finis. »

L'argument par la polarisation, que cette entrée avançait, n'était donc pas celui qui porte. Il aurait fallu montrer qu'une séparation grammaticale se transporte à la catégorie ; les deux abstentions de l'axiomatique suffisent, et elles ne demandent aucun transport.

UNE RÉSERVE SUBSISTE, ET ELLE EST POUR L'IMPLÉMENTATION. Ces deux abstentions sont des hypothèses de l'axiomatique, non des propriétés démontrées d'un modèle. ****Rel**** et ****Vect****, modèles usuels de la logique linéaire, sont l'un et l'autre des catégories de Lafont à biproduits : y instancier *C* ferait réapparaître la codéréliction, et le langage hériterait d'une primitive qu'il ne déclare pas. Tout modèle concret retenu pour *C* doit donc être vérifié contre ces deux abstentions — à porter au chantier de mécanisation.

(sans objet)  
L'opération n'existe pas dans ce langage ; il n'y a rien à nommer.

### DOING Mettre deux calculs en parallèle

    SYMBOLE: c \\parallel c | FAMILLE: connecteurs | REGLE: Par | LEMME-RETENU: mise en parallèle | LEMME-CANDIDAT: mise en parallèle

Exécuter deux calculs sans ordonner leurs pas, et payer la somme de leurs travaux pour le maximum de leurs profondeurs.

mise en parallèle  
Le terme reçu, et le seul qui dise l'absence d'ordre plutôt qu'un ordre particulier.

composition parallèle  
Écarté. « Composition » est déjà pris par le séquencement des effets et par la coupure ; l'employer ici ferait porter au même mot deux opérations que tout ce chapitre s'emploie à distinguer.

### DOING Appliquer une fonction à tout un vecteur

    SYMBOLE: vmap | FAMILLE: connecteurs | REGLE: Vmap | LEMME-RETENU: application vectorisée | LEMME-CANDIDAT: application vectorisée

Appliquer une même fonction à chaque élément d'un vecteur, en payant sa profondeur une seule fois.

application vectorisée  
Le terme reçu. Il dit ce que la règle achète — la profondeur ne dépend pas de la longueur — là où « application point par point » dirait l'inverse.

pli parallèle  
Écarté. Ce n'est pas un pli : rien n'est accumulé, et l'indépendance des éléments est précisément ce qui rend la profondeur constante.

### DOING Engendrer une tâche concurrente

    SYMBOLE: spawn | FAMILLE: couche 2 | REGLE: Spawn | LEMME-RETENU: engendrement | LEMME-CANDIDAT: engendrement

Lancer un calcul qui s'exécutera sans que celui qui le lance l'attende.

engendrement  
Le terme reçu. Il dit la création sans dire l'attente, ce qui est exactement ce que la règle fait — le travail de la fille s'ajoute, sa profondeur non.

bifurcation  
Écarté. Le mot suppose une jonction symétrique, que cette règle ne donne pas : rien n'oblige la mère à rejoindre la fille.

### DOING Découper une capacité d'écriture

    SYMBOLE: slice | FAMILLE: modèle mémoire | REGLE: Slice | LEMME-RETENU: découpe | LEMME-CANDIDAT: découpe, partition, tranche

Consommer une capacité d'écriture sur un segment et en rendre deux sur des segments disjoints.

découpe  
Provisoire. Il dit la consommation de la capacité et la naissance de deux autres, et laisse à la condition de disjonction le soin de dire que les segments ne se chevauchent pas.

### DOING Créer une boîte aux lettres

    SYMBOLE: new | FAMILLE: couche 2 | REGLE: New | LEMME-RETENU: création de boîte | LEMME-CANDIDAT: création de boîte

Produire une boîte vide dont le motif dit ce qu'elle acceptera de recevoir.

création de boîte  
Le terme reçu, et le contexte nul de la règle dit ce qu'il coûte : rien.

allocation  
Écarté. Le mot appartient au régime mémoire du chapitre 4 et ferait croire à une réservation de région, quand il s'agit d'un objet de communication.

### DOING Émettre un message vers une boîte

    SYMBOLE: send | FAMILLE: couche 2 | REGLE: Send | LEMME-RETENU: émission | LEMME-CANDIDAT: émission

Déposer un message dans une boîte sans attendre qu'il soit lu.

émission  
Le terme reçu. L'asynchronie étant primitive, le mot ne doit rien suggérer d'un rendez-vous.

envoi  
Écarté. Trop proche de l'usage courant où envoyer suppose un destinataire qui reçoit ; ici le destinataire peut ne jamais lire.

### DOING Recevoir sous garde

    SYMBOLE: guard | FAMILLE: couche 2 | REGLE: Guard | LEMME-RETENU: réception gardée | LEMME-CANDIDAT: réception gardée

Attendre d'une boîte l'un des motifs de messages que son type annonce — un message, ou une conjonction de messages consommés d'un seul tenant —, et poursuivre avec le motif qui reste.

réception gardée  
Le terme reçu. La garde est ce qui distingue cette règle d'une lecture : plusieurs motifs sont possibles, un seul est consommé, et le type de la boîte en est transformé.

filtrage de boîte  
Écarté. Le filtrage décompose une valeur donnée ; ici rien n'est donné tant qu'un message n'est pas arrivé, et c'est l'attente qui fait la différence.

### DOING Libérer une boîte vide

    SYMBOLE: free | FAMILLE: couche 2 | REGLE: Free | LEMME-RETENU: libération | LEMME-CANDIDAT: libération

Détruire une boîte dont le motif est épuisé, ce qui est la seule façon de la détruire.

libération  
Le terme reçu, et le même mot que pour les ressources de couche 1, à bon droit : c'est la même idée, rendre une ressource dont on a fini.

fermeture  
Écarté. Fermer suggère qu'on pourrait encore lire ce qui reste ; la règle exige au contraire qu'il ne reste rien.

### DOING Poser une garantie pour le pas suivant

    SYMBOLE: next | FAMILLE: temporelles | REGLE: Nxt | LEMME-RETENU | LEMME-CANDIDAT: suivant, next

Attester qu'une valeur sera disponible au pas suivant, sous un contexte lui-même différé.

suivant  
À arbitrer avec les autres formes temporelles (T-68, consolidation de la séance 32). Ajoutée avec la correction de la grammaire : sans elle, aucune valeur close n'habite ○◇V.

### DOING Attester qu'une valeur est à un lieu

    SYMBOLE: loc_n | FAMILLE: couche 1 | REGLE: Loc | LEMME-RETENU | LEMME-CANDIDAT: lieu, localisée

Introduire la modalité de localisation sur une valeur : l'étiquette de lieu, sans déplacer.

lieu  
À arbitrer (T-68, séance 32). Ajoutée avec la correction de la grammaire : sans elle, aucune valeur close n'habite @ₙV, et la prémisse de `Move` n'a rien à recevoir.

### DOING Abaisser le niveau d'une valeur nommée à l'avance

    SYMBOLE: declassify_ℓ | FAMILLE: noyau | REGLE: Declassify | LEMME-RETENU: déclassification | LEMME-CANDIDAT: déclassification

Rendre, au niveau abaissé, une boîte déjà nommée par une échappatoire.

déclassification  
Le terme de Sabelfeld et Myers, déjà employé par tout le manuscrit. La règle porte désormais son nom (séance 32).

### DOING Localiser un calcul

    SYMBOLE: at | FAMILLE: couche 1 | REGLE: At | LEMME-RETENU: localisation | LEMME-CANDIDAT: localisation

Exécuter un calcul à un endroit nommé, dont toutes ses ressources relèvent.

localisation  
Le terme reçu, et le même mot que la modalité qui le type. L'unité entre la règle et le coeffet est voulue.

placement  
Écarté. Le mot suggère une décision d'ordonnanceur révisable, quand la localisation est portée par le type et donc fixée au typage.

### DOING Déplacer une valeur d'un lieu à un autre

    SYMBOLE: move | FAMILLE: couche 1 | REGLE: Move | LEMME-RETENU: déplacement | LEMME-CANDIDAT: déplacement

Transporter une valeur sérialisable vers un lieu qui domine le sien, en payant le coût du réseau.

déplacement  
Le terme reçu. Il dit le changement de lieu sans rien dire de la copie, et la règle non plus — ce qui est délibéré, la ressource restant unique.

migration  
Écarté. Trop chargé par l'usage des systèmes répartis, où il désigne le déplacement d'un processus entier et non d'une valeur.

### DOING Récupérer d'une défaillance

    SYMBOLE: try | FAMILLE: couche 1 | REGLE: Try | LEMME-RETENU: récupération | LEMME-CANDIDAT: récupération

Donner une portée à un calcul susceptible d'échouer, et un recours s'il échoue.

récupération  
Le terme reçu. Il dit ce que la règle offre — un recours — sans prétendre que la défaillance serait évitée.

rattrapage  
Écarté. Le mot suggère qu'on empêche la chute ; la règle ne l'empêche pas, elle en borne la portée.
