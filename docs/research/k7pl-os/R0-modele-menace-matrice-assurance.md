# R0 — Modèle de menace et matrice d’assurance (P0)

**Question centrale :** quelles garanties un OS envisagé en K7PL doit-il fournir, contre quels adversaires, à travers quelles frontières de confiance et sous quelles hypothèses ?

## Travail demandé

Identifier les actifs (mémoire, secrets, intégrité du code et des données, périphériques, ressources, communications, logs, disponibilité) et les adversaires : acteur K7PL compromis, entrée externe de faible intégrité, FFI non sûre, pilote, DMA, composant privilégié, observateur temporel, boot et matériel compromis.

Distinguer sûreté mémoire, isolation, intégrité, confidentialité, autorité, sûreté protocolaire, vivacité, disponibilité, temps réel et reproductibilité. Définir les observations pertinentes : valeurs, présence/ordre des messages, terminaison, durée, consommation, erreurs, logs et effets de bord.

## Livrable

Un modèle de menace versionné et une matrice comprenant : propriété ; adversaire ; actif ; observation ; mécanisme ; énoncé formel ; composant d’application ; hypothèses ; preuve disponible/manquante ; test ou contre-exemple ; statut. Documenter autant les exclusions que les menaces couvertes.

## Prompt prêt à copier

> Construis le modèle de menace pour un OS envisagé en K7PL. N’assume ni que le code K7PL est le seul adversaire ni que le typage suffit à isoler les composants. Analyse langage, runtime, compilateur, FFI/assembleur, pilotes, entrées externes, DMA, boot et matériel. Pour chaque propriété, définis l’observation contrôlée, les hypothèses et la frontière de confiance. Livre une matrice d’assurance, les contre-exemples prioritaires et les décisions architecturales nécessaires avant d’ajouter des mécanismes au langage.

## Sources

- [STATUS.md](../../STATUS.md), [ASSURANCE.md](../../ASSURANCE.md), [DASHBOARD.md](../../tracking/DASHBOARD.md)
- [Architecture système C4](../../../spec/Spec/C4/EchelleDuSysteme.lean)

## Critère de sortie

Aucune revendication générale de sécurité sans propriété et périmètre précis ; toutes les hypothèses, exclusions et obligations de preuve sont identifiées.