<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Sources des propagations de singularités (`BLOQ-12`, `IMPL-07`)

Demande de l'auteur : « Les singularités sont à définir, leurs propagations réelles sont à sourcer dans les références. » Ce document dit, pour chaque propagation du §3.2 du chapitre 3, ce qui est sourcé, à quel **niveau de vérification**, et ce qui est une extension de K7PL.

## Niveau de vérification atteint

Le 7 octobre 2026, les pages des éditeurs (Cambridge, Springer), d'arXiv, de Wikipédia, de MathWorld, de Zenodo, de Stockholm (`math.su.se`, DiVA), de `studylib` et d'IEEE (`grouper.ieee.org`) sont **bloquées** par le proxy de sortie de la session (`EGRESS_BLOCKED`, 403 au `CONNECT`) ; ne sont atteignables que les résumés de la recherche en ligne. **Aucune source n'a donc été lue dans son corps.** Les niveaux utilisés ci-dessous :

* **notice** : l'existence de l'œuvre, ses auteurs, son lieu de publication, confirmés par la recherche ;
* **résumé** : le résumé de l'éditeur ou de l'auteur, tel que la recherche le rend ;
* **corps lu** : jamais atteint ici ;
* **calculé** : vérifié par un calcul de ce dépôt, sur une définition rappelée de mémoire (donc exact seulement si le rappel l'est) ;
* **extension de K7PL** : aucune source ; définition du manuscrit.

## Les œuvres

| Œuvre | Niveau | Ce qui est attesté |
|---|---|---|
| Carlström, *Wheels — On Division by Zero*, MSCS 14(1), 143–184, 2004 (préimpression : Research Reports in Mathematics 2001:11, Stockholm) | notice + résumé | une roue étend un anneau commutatif (ou semi-anneau) de sorte que la division par tout élément, zéro compris, soit possible ; `0x = 0` ne tient pas en général ; le sous-ensemble `{x ∣ 0x = 0}` est un anneau ; `⊥` remplace `0/0` ; la division est un opérateur unaire `/x` involutif et multiplicatif ; la roue des fractions est `A × A/≡`, avec `0 = [0,1]`, `1 = [1,1]` |
| Setzer, *Wheels (Draft)*, 1997, non publié | notice | `1/0 = ∞` et un élément d'erreur `⊥` ; l'idée vient de la droite projective plus le point `0/0` |
| Bergstra et Ponse, *Division by Zero in Common Meadows*, LNCS 8950, 2015 (arXiv 1406.6878) | résumé | un méadow commun est un corps muni d'un inverse total ; la division par zéro produit **une** valeur supplémentaire `a` qui se propage à travers toutes les opérations de la signature |
| Bergstra, *Division by Zero: a Survey of Options*, Transmathematica, 2019, DOI 10.36285/tm.v0i0.17 | notice | recense les options de totalisation de la division (cadre du « premeadow ») ; **à lire** pour dire si une structure à plusieurs valeurs d'erreur y figure |
| Anderson, Reis et al., arithmétique transréelle (IAENG IJAM 45(1), « Transreal Calculus ») | résumé | trois non-finis : `+∞`, `−∞` et la nullité `Φ = 0/0` ; le produit de zéro, d'un infini ou de la nullité par son inverse est `Φ`, non l'unité ; deux infinis **signés**, comme IEEE 754, contrairement à la roue |
| IEEE 754-2019 (norme) | résumés secondaires (manuels Intel et glibc, document WG14 N1053), jamais la norme | opérations invalides rendant un NaN : `∞ − ∞`, `0 × ∞`, `0/0`, `∞/∞` ; `∞ + ∞ = ∞` quand les signes concordent ; division d'un fini non nul par zéro : infini signé |
| Goguen, « Abstract Errors for Abstract Data Types », 1977/1978 | notice | cadre des algèbres d'erreurs : porteurs scindés en valeurs ordinaires et erronées, propagation des erreurs ; la bibliographie de la séance n'a pas pu dire si des éléments d'erreur **distincts** y sont ordonnés |
| Schwartz, « Sur l'impossibilité de la multiplication des distributions », 1954 | résumé de recherche | le carré de la distribution de Dirac n'est pas une distribution ; aucune algèbre différentielle ne contient les distributions en conservant le produit des fonctions continues (les algèbres de Colombeau relâchent l'exigence) |

## Propagation par propagation

| Propagation (§3.2) | Source | Niveau | Remarque |
|---|---|---|---|
| `⊥` absorbe `+`, `·`, `1/·` sur les classes `0, x, ∞, ⊥` | Carlström (axiome `0/0 + x = 0/0`) ; Bergstra–Ponse (valeur d'erreur qui se propage) ; Anderson (nullité) | résumé (Carlström : l'axiome rappelé, non lu) ; **calculé** sur la roue des fractions de GF(2), GF(3), GF(5) | l'axiome tient sur le modèle |
| `1/0 = ∞`, `0/0 = ⊥`, `1/∞ = 0`, `1/⊥ = ⊥` | Carlström, Setzer | résumé pour `1/0` et `0/0` ; `1/∞ = 0` et `1/⊥ = ⊥` **calculés** | |
| `∞ + ∞ = ⊥`, `0 · ∞ = ⊥`, `∞ · ∞ = ∞`, `x + ∞ = ∞`, `x · ∞ = ∞` (`x ≠ 0`) | aucun énoncé lu ; Carlström pour la construction | **calculé** sur la construction `(ad + bc, bd)`, `(ac, bd)` | le manuscrit le dit déjà : valeurs calculées, non citées |
| `∞ + ∞ = ∞` en IEEE 754 (signes égaux) : **écart** avec la roue | IEEE 754-2019 | résumés secondaires | la roue n'a qu'un infini ; l'arithmétique transréelle et IEEE ont deux infinis signés |
| `0/0`, `∞ − ∞`, `0 · ∞` rendent un NaN, lu `⊥` | IEEE 754-2019 | résumés secondaires | |
| règle d'entrée : `±∞ → ∞`, `±0 → 0`, tout NaN `→ ⊥` | aucune : choix de K7PL (identification des signes) | extension de K7PL | écrit comme tel |
| classes `∘`, `δ`, `∘δ` et leur propagation (réunion d'étiquettes, valeur de la roue oubliée) | **aucune** | **extension de K7PL, non sourcée** | voir plus bas ; la forme est celle d'un produit de la roue par le semi-treillis des étiquettes, que rien dans les sources atteintes ne contredit ni n'appuie |

## Ce que les sources infirment, ou ce que le calcul infirme

1. **« Une roue n'a que deux éléments hors du corps »** : vrai de la roue des fractions d'un corps, faux d'une roue quelconque. Corrigé au §3.2.
2. **Les lois de la roue sur l'extension** (`∘`, `δ` bornes supérieures, `∘ ⋆ δ = ⊥`, `⊥` absorbant) : la séance 32 ne les avait pas vérifiées et écrivait que « `+` et `·` restent commutatives et associatives sur les six classes ». **C'est faux** : `(∞ + ∞) + ∘ = ⊥ + ∘ = ⊥` mais `∞ + (∞ + ∘) = ∞ + ∘ = ∘`. Plus généralement, si `∘` absorbe `∞`, associativité de `+` et `∞ + ∞ = ⊥` forcent `⊥ + ∘ = ∘`, et `∘ ⋆ δ = ⊥` est alors incompatible avec l'associativité (`(∘ + δ) + δ = δ` mais `∘ + (δ + δ) = ⊥`). Le calcul exhaustif est `scripts/verif_singularites.py` (modèle fini, axiomes **rappelés**, non lus).
3. **Réécriture** : une erreur est un ensemble d'étiquettes ; `+`, `·`, `/` font la réunion ; `∘δ` est une cinquième singularité ; `⊥` n'absorbe plus les erreurs. Le programme confirme associativité, commutativité, neutres, involution de l'inverse, multiplicativité de l'inverse et tous les autres axiomes rappelés, **sauf** `0/0 + x = 0/0` pour `x` porteur d'étiquette : l'extension n'est donc **pas une roue**. Le manuscrit l'écrit.

## Alternatives laissées à l'auteur (`BLOQ-12`)

* (i) retirer `∘`, `δ` (et `∘δ`) de l'encodage : le reste est inchangé, les quatre classes de la roue suffisent ;
* (ii) garder la réunion d'étiquettes (appliquée) ;
* (iii) une priorité fixe (`∘` l'emporte sur `δ`, qui l'emporte sur `⊥`) : six classes, associative sans doute aussi (quotient de (ii), non vérifié séparément), mais asymétrique et arbitraire ;
* (iv) renoncer à ce que `∘` absorbe `∞` : `∘ + ∞ = ⊥`, mais l'inverse cesse alors d'être multiplicatif (`1/(∘ · ∞) = ⊥` contre `1/∘ · 1/∞ = ∘`), ce qu'un essai local a confirmé (non conservé dans le dépôt).

**Dirac.** Rien dans les sources ne rattache `δ` à la distribution de Dirac, et le texte ne le prétend pas : `δ` est un nom de classe d'erreur. Si on l'entendait comme la distribution, la règle `δ ⋆ δ = δ` serait contredite par l'impossibilité de Schwartz (un `δ²` n'existe pas) ; ce n'est pas le sens retenu.

## À lire quand l'accès sera rendu

Carlström 2004, définition d'une roue et théorème sur la roue des fractions (pour confronter la liste d'axiomes rappelée et le calcul de `∞ + ∞`) ; Bergstra 2019 (autres valeurs d'erreur) ; Bergstra–Ponse 2015 (comparaison explicite avec les roues) ; IEEE 754-2019, §6.1 et §7.2 ; Goguen 1977/1978 ; Anderson et Reis, théorie des nombres transréels, pour la propagation de `Φ`. Aucune de ces lectures n'a eu lieu.
