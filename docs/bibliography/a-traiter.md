# État des références au 3 septembre, après la bascule en deux fichiers BibTeX

> **Relu le 3 septembre au soir : les deux points qui te revenaient sont réglés, il ne reste rien à
> faire de ton côté.** Le détail est plus bas, sections 1 et 2, conservées avec leur résolution
> plutôt que supprimées — c'est ce qui permet de relire pourquoi elles s'étaient posées.

Le RDF a disparu. `refs-pour-citations.bib` est la **référence absolue** — clés, titres, résumés,
identifiants — et `K7PL-Biblio.bib` n'est consulté que pour retrouver le **chemin d'un PDF**, ses
chemins étant relatifs quand ceux de la référence sont absolus sur ta machine.

L'outillage est recâblé sur cette règle : `pdf_index.py` joint les deux, la substance venant de la
référence et le chemin de l'autre. Aucun autre emprunt n'est fait au second, et c'est délibéré —
deux sources pour un même fait est exactement ce qui a produit les fautes d'hier.

---

## Ce que la bascule a réglé

| | avant | après |
|---|---|---|
| entrées lisibles | 4 327 | **4 325**, les deux fichiers portant alors exactement les mêmes clés |
| PDF atteignables | 4 286 | **4 290**, et les 4 290 chemins existent réellement sur le disque |
| titres = titre du contenant | 2 502 | **0** |
| clés citées à résumé partagé | 7 | **0** |
| doublons `DATAFUN` / `THEOCHARIS` | 2 | **0**, fusionnés |

**Zéro clé citée ne porte plus un résumé qui n'est pas le sien.** Quatre-vingt-quatorze entrées de
la bibliothèque en partagent encore un, mais aucune n'est citée : cela ne touche plus le manuscrit.

## Deux corrections que mon lecteur de fichiers a demandées

**Le point-virgule échappé.** Zotero écrit `\;` quand le nom du fichier en contient un — et un titre
en contient plus souvent qu'on ne le croit. Découper naïvement sur `;` tronquait le chemin, et
l'entrée passait pour être sans PDF. Trouvé sur la taxonomie de Rasmussen, dont le titre porte un
point-virgule ; sept entrées récupérées.

**Le nom de fichier qui ne coïncide pas.** Vingt-cinq chemins n'existaient pas sur le disque : un
`!`, un `:` ou une lettre grecque du titre avait été transcrit d'une manière à l'export et d'une
autre au nommage. Le **dossier**, lui, est fiable — c'est l'identifiant de la pièce jointe. Quand le
chemin exact manque et que le dossier ne contient qu'un seul PDF, c'est celui-là : la correspondance
est certaine, non devinée. Vingt-cinq entrées récupérées.

---

## Ce qui restait — les deux points sont réglés

### 1. `UnicodeStandardV17` — RÉGLÉ

La clé est au fonds, titre « The Unicode® Standard », et elle est citable. Le manuscrit, les
questions, le corpus et les décisions la portent en lieu et place de `UTS39`.

**Une divergence subsiste entre les deux fichiers, et elle est normale** : `refs-pour-citations.bib`
compte 4 326 entrées quand `K7PL-Biblio.bib` en compte 4 325, et l'écart est exactement cette clé.
Elle n'a pas de PDF, donc rien à trouver dans le second fichier. Ce n'est pas un défaut de
synchronisation et il n'y a rien à réexporter — c'est noté ici pour qu'une relecture ultérieure ne
le prenne pas pour tel.

### 2. La spécification Arrow — RÉGLÉE, et j'avais mal cherché

Elle n'avait pas disparu. Elle est au fonds sous `SpecificationsApacheArrow`, titre
« Specifications — Apache Arrow V25.0.1 ». Je l'avais cherchée par « Arrow Columnar Format », qui est
l'ancien intitulé, et j'en avais conclu à une absence — puis je t'ai demandé d'arbitrer entre
réajouter la source et retirer l'argument du chapitre 4, un arbitrage qui n'existait pas.

**La règle qui en sort** : une chaîne exacte confirme une présence, jamais une absence. Pour établir
qu'une pièce manque, on cherche le terme le plus large.

La citation du chapitre 4 tient donc, et l'argument avec elle — la couche 3 étant totale, un vecteur
n'a jamais de valeur absente, et l'omission du bitmap de validité est acquise et non concédée.

### 3. Onze clés citées n'ont pas de résumé, et six seulement le devraient

État inchangé au 3 septembre au soir, et sans conséquence.

Cinq sont des spécifications ou un billet technique, qui n'en ont pas par nature — Cap'n Proto, la
norme Unicode, Arrow, SBE, le billet sur les effets et la propriété.

Les six autres sont des articles : `CICEK`, `HUANG`, `SCHALK`, `grabmayerMaximalSharingLam`,
`kellyCoherenceClosedCategories1971`, `oliveiraEvaluatingCodeReadability2020`. Sans conséquence pour
la bibliographie — mes sondes par mots-clés ne les atteignent simplement pas.
