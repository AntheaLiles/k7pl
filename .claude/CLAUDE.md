<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# k7pl

k7pl est un langage de programmation implémenté en Lean 4 avec Mathlib et CSLib. Sa spécification est écrite en Verso.

## Architecture du dépôt

- `src/` : implémentation Lean 4 (CECILL-2.1).
- `tests/` : tests Lean (CECILL-2.1).
- `spec/` : spécification Verso (CC-BY-4.0), source normative courante.
- `tools/` : générateur et extensions Verso, bibliographie générée.
- `docs/` : suivi, décisions, recherche, audits ; point d'entrée : `docs/tracking/TABLEAU-DE-BORD.md`.
- `archives/` : ancien manuscrit et outillage figés ; ne pas les corriger pour modifier la version courante.
- `.claude/rules/` : règles spécialisées.
- `.claude/skills/` : procédures réutilisables.
- `.claude/agents/` : rôles spécialisés et paramètres de modèle.

Code, identifiants, commentaires et docstrings : anglais. Documentation, spécification, issues, PR et messages de commit : français.

## Invariants non négociables

`spec/`, `src/`, `tests/` et `docs/` sont des objets de nature différente. Une affirmation de spécification, une définition Lean, une preuve et un test ne sont jamais interchangeables.

Le manuscrit porte « ne rien modifier sans l'accord de l'auteur ». Toute modification normative de `spec/` exige donc une demande explicite et une portée minimale.

Ne jamais introduire `sorry`, `admit`, nouvel `axiom` ou `native_decide`. Ne jamais affaiblir un contrôle pour faire passer CI, Scorecard ou CII.

Ne jamais inventer une revue, un contributeur, une signature, une provenance, un SBOM, une preuve de reproductibilité ou une conformité.

Lire `.claude/rules/project.md` pour toute tâche substantielle, puis la règle spécialisée de la zone modifiée. Lire `.claude/skills/writing-rules.md` avant toute modification de code, test ou spécification.

## Séparation épistémique

Une tâche traversant la spécification et Lean doit expliciter :

`specification → formalisation → implémentation → preuve → test`.

Ne jamais adapter silencieusement la spécification à l'implémentation, ni l'implémentation à une interprétation non établie de la spécification.

Les statuts suivants sont distincts : intuition, définition, assertion argumentée, propriété formalisée, propriété prouvée, propriété testée.

## Routage des agents

Les agents sont des rôles, les skills sont des procédures. La session principale reste l'architecte et l'intégrateur.

### Spécification

- `spec-architect` : conception, dépendances, arbitrages interchapitres ; lecture principalement.
- `formal-reviewer` : revue antagoniste, hypothèses et contre-exemples ; lecture.
- `spec-editor` : édition Verso explicitement demandée.
- `consistency-auditor` : cohérence `spec ↔ Lean ↔ tests ↔ docs`.

### Lean

- `theorem-prover` : preuves pour des énoncés déjà stabilisés.
- `lean-implementer` : implémentation de `src/` et `tests/`.
- `lean-debugger` : diagnostic et correctifs minimaux.
- `verification-specialist` : vérification indépendante du changement.

### Assurance

Les agents `scorecard-specialist`, `cii-specialist`, `github-governance-specialist`, `supply-chain-release-specialist`, `security-assurance-specialist` et `quality-reproducibility-specialist` forment une couche indépendante d'assurance OpenSSF/sécurité.

## Modèles

Les paramètres `model`, `effort` et `isolation` des subagents sont définis dans leurs fichiers. Ne pas les dupliquer dans une consigne ad hoc ni les remplacer arbitrairement.

Pour les tâches d'architecture, de théorie, de sécurité, de gouvernance ou d'intégration, la session principale privilégie Opus 5.5 avec effort `high`. Les rôles opérationnels utilisent Sonnet 5.5 avec effort `high` quand leur définition l'indique.

## Orchestration

Pour une tâche locale, utiliser un seul agent pertinent.

Pour une tâche substantielle, suivre deux vagues :

1. **Audit** : lancer les agents concernés en parallèle, sans modifications concurrentes des mêmes fichiers. Chaque agent produit faits observés, preuves, écarts, recommandations et actions humaines restantes.
2. **Implémentation** : après comparaison des rapports, répartir les fichiers par frontière de responsabilité, intégrer les changements retenus, puis faire vérifier l'ensemble.

Ne jamais lancer simultanément plusieurs agents en écriture sur le même fichier.

Pour une chaîne `spec → Lean`, préférer :

`spec-architect → formal-reviewer → (theorem-prover | lean-implementer) → consistency-auditor → verification-specialist`.

Pour une correction Lean locale :

`lean-debugger → verification-specialist`.

Pour une modification éditoriale explicitement autorisée :

`spec-editor → validate-spec`.

Pour un audit OpenSSF transversal, utiliser les six agents d'assurance en parallèle, puis intégrer leurs conclusions avant toute modification.

## Validation

Un changement n'est pas terminé parce qu'un agent dit qu'il est terminé.

Pour Lean, exécuter au minimum les contrôles pertinents parmi :

`lake build`, `lake test`, `lake lint`, `reuse lint`.

Pour `spec/`, utiliser les contrôles Verso du dépôt, notamment :

`lake build Spec`, `lake exe spec --output _out/spec --with-tex`, `python3 scripts/controle.py`.

Vérifier également les contrôles de suivi lorsque les fichiers concernés changent.

Classer les résultats :

`VERIFIED` · `PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE`.

Une validation externe ou humaine ne doit jamais être présentée comme déjà acquise.

## Documentation

Les règles détaillées de style, structure, REUSE, tests et commits restent dans `.claude/skills/writing-rules.md`.

Les procédures métier sont dans les skills spécialisées :

- `.claude/skills/spec/` pour Verso ;
- `.claude/skills/lean/` pour Lean 4 ;
- `.claude/skills/research/` pour la recherche ;
- `.claude/skills/engineering/` pour planification, vérification et revue.

Le hook `SessionStart` (`scripts/claude-session-start.sh`) prépare l'environnement Lean des sessions web quand le réseau le permet.
