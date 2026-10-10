<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# OpenSSF — clôture de la vague d'automatisation et de consolidation documentaire

| | |
|---|---|
| Date | 2026-10-10 |
| État | **Vague d'automatisation préparée ; campagne de conformité encore ouverte** |
| PR | [#129](https://github.com/AntheaLiles/k7pl/pull/129) — reste soumise à revue et fusion humaine |
| Limite | Ce compte rendu retrace le travail préparatoire. Il ne constitue ni une auto-certification ni une preuve de sauvegarde de réponses sur BadgeApp. |

## Travaux préparés

La PR #129 ajoute un contrôle local de cohérence entre métadonnées du dépôt, README, badge et registre de critères ; un générateur validant des propositions explicitement relues ; un instantané amont identifié par SHA ; un contrôle read-only de dérive ; des tests unitaires et des vérifications CI. Aucune automatisation n'écrit dans BadgeApp ou ne réactualise silencieusement le registre.

La documentation a été consolidée pour distinguer :
- **actif** : docs/security/OPENSSF-ROADMAP.md, ACTIONS-HUMAINES.md, DECISIONS-REQUISES.md, BADGE-AUTOMATION.md et BADGE-CONFORMANCE-MATRIX.md ;
- **preuve** : audit consolidé, état d'implémentation, modèle de menace, cas d'assurance et rapports de workstreams ;
- **historique** : ancienne checklist, plan initial et présent compte rendu sous docs/history/.

La checklist déplacée n'est pas supprimée : elle demeure une trace datée, mais ne doit plus servir de tableau de bord courant. Le plan maître scientifique ne duplique plus l'action de reprise OpenSSF.

## Validation et limites

Le run [CI #38059644310](https://github.com/AntheaLiles/k7pl/actions/runs/38059644310) était entièrement vert sur la tête antérieure 1b5950350588742f2b0681e37565f85d70527d98. Les changements de consolidation documentaire décrits ici changent le commit et doivent donc être validés par le nouveau run CI de la PR ; le résultat antérieur ne prouve pas la validation de ce contenu révisé.

Au moment de cette archive :
- la PR n'est pas fusionnée ;
- le contrôle réel par schedule ou workflow_dispatch de la dérive des critères amont n'a pas encore été observé ;
- le profil BadgeApp reste in_progress et les champs projet nom, description, licence et langages sont vides ;
- aucune réponse BadgeApp, aucun réglage administrateur, secret, environnement, règle de tags, publication, attestation réelle ni action Zenodo n'a été modifié ou exécuté par cette vague ;
- la publication réelle, la reproductibilité du PDF, la validation indépendante du prototype SPDX/SBOM et la revue de sécurité humaine demeurent non démontrées.

## Suite

La mainteneuse doit relire puis décider de la fusion de la PR. Après fusion, exécuter ou attendre la première exécution réelle du contrôle de dérive et examiner son artefact. Le reste est ordonné dans [docs/security/ACTIONS-HUMAINES.md](../security/ACTIONS-HUMAINES.md). Le statut détaillé et les conditions de clôture restent dans [docs/security/OPENSSF-ROADMAP.md](../security/OPENSSF-ROADMAP.md).

La fin de cette vague signifie que la préparation automatisable proposée est mise en place dans la branche de PR. Elle ne signifie pas que la campagne de conformité OpenSSF est terminée.
