<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Politique de gestion des secrets et identifiants

## Objet et état

Cette politique couvre les secrets et identifiants utilisés pour maintenir K7PL : jetons GitHub, jetons d'archivage ou de publication, credentials de CI, clés de signature éventuelles et informations permettant l'accès aux rapports privés.

Elle documente les règles attendues. Elle ne prouve pas que chaque réglage GitHub, environnement, droit d'accès ou secret existant est correctement configuré ; les vérifications administratives sont suivies dans [ACTIONS-HUMAINES.md](ACTIONS-HUMAINES.md).

## Règles obligatoires

1. **Ne jamais committer un secret.** Ne pas placer de jeton, mot de passe, clé privée, cookie de session ou valeur confidentielle dans le code, les issues, les logs, les exemples, les artefacts ou la documentation. Les exemples utilisent des valeurs fictives.
2. **Privilèges minimaux.** Accorder à chaque workflow et à chaque jeton uniquement les permissions nécessaires à son opération. Préférer les permissions explicites au niveau du job ; un workflow de vérification ne reçoit pas de droits d'écriture sans justification documentée.
3. **Séparer les contextes.** Les secrets de publication ne doivent pas être disponibles aux tâches de test ou de construction qui n'en ont pas besoin. Utiliser des environnements GitHub protégés pour les opérations de publication lorsque la configuration et le plan GitHub le permettent.
4. **Ne pas transmettre les secrets en ligne de commande.** Les fournir via le mécanisme de secrets de la plateforme et des variables d'environnement lorsque c'est compatible avec l'outil ; éviter qu'ils apparaissent dans l'historique du shell, les arguments de processus ou les traces.
5. **Pas d'exposition au code non fiable.** Une PR non approuvée, une dépendance ou un contenu externe ne doit pas pouvoir lire un secret de publication ni obtenir un jeton d'écriture. Les workflows déclenchés par du code non fiable doivent utiliser des permissions minimales et éviter les credentials persistants du checkout.
6. **Rotation et révocation.** Révoquer immédiatement tout secret soupçonné d'exposition, puis le remplacer par un nouveau secret après avoir identifié les workflows et ressources qui en dépendent. Ne jamais « réparer » une fuite en supprimant seulement la valeur du dernier commit : l'historique doit être traité comme potentiellement compromis.
7. **Journalisation.** Ne jamais journaliser les valeurs secrètes. Les logs peuvent indiquer le nom du secret ou l'étape concernée, jamais sa valeur.
8. **Accès et continuité.** Réexaminer les personnes et applications ayant accès aux secrets lors de chaque changement de rôle, de permission ou de mainteneur. Une procédure de succession sûre doit être organisée hors du dépôt ; ne pas committer de coffre, de sauvegarde de clé ou de secret de secours.

## Détection et réponse

- La CI exécute Gitleaks ; ce contrôle réduit le risque mais ne prouve pas l'absence de toute donnée sensible, notamment dans les anciens commits, artefacts ou services externes.
- Si une fuite est détectée ou suspectée, suspendre le workflow concerné si nécessaire, révoquer/faire tourner le credential, déterminer son périmètre d'accès, examiner les journaux disponibles et documenter l'incident sans republier la valeur.
- Les vulnérabilités du produit ou de la chaîne de construction doivent être signalées selon [SECURITY.md](../../SECURITY.md).
- Toute exception doit être limitée, motivée, datée et assortie d'une mesure compensatoire. Une exception n'autorise jamais la conservation d'un secret connu comme compromis.

## Vérifications opérationnelles requises

Les éléments suivants restent à vérifier dans les réglages et services réels :
- droits de chaque workflow et jeton, y compris les permissions au niveau des jobs ;
- protection et approbation des environnements de publication ;
- obligation de MFA/2FA pour les personnes ayant accès au dépôt et aux rapports privés ;
- présence, portée, date de dernière rotation et propriétaire des secrets configurés, sans en afficher les valeurs ;
- procédure de révocation et possibilité de continuité si la mainteneuse est indisponible.

Voir [ACTIONS-HUMAINES.md](ACTIONS-HUMAINES.md) et [la checklist OpenSSF](../tracking/OPENSSF-CHECKLIST.md). Aucun de ces points ne doit être coché sur la seule base de cette politique.
