<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 62 : frontière de clôture des objets théoriques

**Date :** 7 octobre 2026

La passe précédente a testé les interactions entre les objets. Le résultat permet maintenant de
séparer définitivement deux classes de dettes : les choix d'objets et les preuves que ces objets
doivent satisfaire.

## 1. Objets dont la signature est désormais fixée

Le noyau de grade est désormais décrit par :

`𝒢 = 𝓡 × 𝕄 × ℒ × 𝔅`

avec 𝓡 semi-anneau d'usage et 𝔅 = ℕ∞.

L'index de l'exponentielle est factorisé :

`π_U : 𝒢 → 𝓡`

et

`Bang_𝒢(r,A) := !_{π_U(r)}A`.

L'action contextuelle utilisée par Box, App et substitution est :

`Scale_Usage(a,⟨u,m,ℓ,β⟩)=⟨a·u,m,ℓ,β⟩`.

La consommation temporelle est séparée :

`Adm(β,κ) := (β=ω) ∨ (Cost_Budget(κ)≤β)`

et

`Consume(β,κ)=β⊖Cost_Budget(κ)` sur le domaine admissible.

Le coût scalaire minimal sous budget scalaire est :

`Cost_Budget(κ)=max(W(κ),D(κ))`

avec W et D définis par les agrégats précédemment fixés.

Les transformations d'effets liées aux répétitions restent φ_n et sont distinctes de
Scale_Usage.

## 2. Objets dont le support est fixé mais dont les lois restent à prouver

La famille de coercions de l'exponentielle est `coerce` sur 𝓡.
Les opérations de comonade sont w et c.

Les conversions de grade complet sont des transports sur le jugement, et Conv! est l'instance de
ces transports sur !.

Il reste à établir les lois de naturalité, d'identité et de composition nécessaires à ces objets.
Ce sont désormais des obligations de preuve, non des raisons de modifier leurs signatures.

De même, ψ est l'unique lieu où la consommation budgétaire est appliquée. La dette restante est de
prouver que le coût annoncé par l'effet κ correspond exactement au coût que ψ doit soustraire,
règle par règle.

Enfin, la substitution reste une proposition conditionnelle dont les hypothèses sont maintenant
nommées : lois de Scale_Usage, compatibilité avec Sub/SubBox, et compatibilité des conversions
de type avec les constructeurs.

## 3. Ce qui ne doit plus être rouvert dans l'étape C

Aucune nouvelle multiplication globale de 𝒢 n'est nécessaire pour les règles actuellement
analysées.

Aucun budget vectoriel n'est nécessaire pour satisfaire P3 dans la formulation actuelle.

When ne constitue plus une branche architecturale ouverte : son effet porte explicitement la perte
de borne, et l'incompatibilité avec un budget fini apparaît lors de l'application de Adm à une
traversée par ψ.

I=𝒢 reste une généralisation possible, mais elle n'est plus nécessaire pour expliquer les règles
actuelles et ne doit pas être promue sans un besoin syntaxique ou sémantique nouveau.

## 4. Critère de sortie de l'exploration des objets

L'étape C peut être considérée comme architecturalement stabilisée lorsque :

1. aucune règle du noyau n'exige un objet dont la signature n'est pas inscrite ;
2. aucune signature retenue n'exige implicitement une opération absente d'un de ses facteurs ;
3. chaque interaction restante est rattachée à une obligation de preuve ou de sémantique identifiée ;
4. les alternatives concurrentes ont un contre-critère explicite ou sont classées comme généralisations
   hors besoin courant.

Ces quatre conditions sont maintenant satisfaites pour le sous-système grade/exponentielle/coût.

Le statut de TRANS-02 reste néanmoins **partiel** tant que les preuves finales ne sont pas
déchargées. Cette distinction est intentionnelle : clôturer l'exploration architecturale ne vaut pas
preuve de correction.

## 5. Conséquence méthodologique

La suite de PR-02 ne doit plus ajouter des objets théoriques par précaution. Elle doit traiter les
obligations restantes comme des problèmes de preuve, en particulier :

coerce / w / c → naturalité et cohérence ;

SubBox + Conv! → transport des conversions ;

substitution → compatibilité quantitative complète ;

ψ + Cost_Budget → correction de la consommation par rapport à l'effet.

Le passage à cette seconde classe d'objets constitue la frontière entre l'exploration théorique et la
validation métathéorique.
