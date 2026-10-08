<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Politique de sécurité

## Versions prises en charge

Aucune version de l'implémentation n'est publiée : seule la branche `main` est maintenue.
Une release de spécification, `spec-v0.0.0-alpha.1`, existe ; elle ne porte aucun fichier joint.

## Signaler une vulnérabilité

Merci de **ne pas** ouvrir d'issue publique. Utilisez le signalement privé de
GitHub : onglet **Security**, puis **Report a vulnerability**
(<https://github.com/AntheaLiles/k7pl/security/advisories/new>).

Indiquez la version (commit), les étapes pour reproduire et l'impact supposé.
Un premier retour est fait sous 7 jours ; le correctif et l'avis de sécurité
sont publiés ensemble, avec mention de la personne qui a fait le signalement si
elle le souhaite.

## Périmètre

Sont notamment concernés :

- une faille de **cohérence** : preuve de `False`, contournement de l'audit des
  axiomes, théorème prouvé grâce à un comportement non voulu de l'implémentation ;
- un défaut de l'implémentation du langage permettant d'exécuter du code ou
  d'accéder à des ressources non prévues ;
- une compromission de la chaîne de construction (workflows, dépendances).

Aujourd'hui, k7pl n'a ni analyseur ni interpréteur : le deuxième point ci-dessus ne s'appliquera
qu'à partir de leur apparition. Le risque d'exécution de code présent est celui de la chaîne de
construction (le troisième point).

## Vérifier une release

Aucune release ne porte encore d'artefact vérifiable. Une release de spécification produite par le
flux décrit dans [`CONTRIBUTING.md`](CONTRIBUTING.md) peut l'être ainsi (procédure cible, **non
encore éprouvée**) ; `gh release verify` et `gh release verify-asset` ne fonctionnent qu'après la
publication de la release (pour un brouillon, les notes de la release donnent la procédure
« Avant publication ») :

```sh
gh release verify       spec-vX.Y.Z -R AntheaLiles/k7pl
gh release download     spec-vX.Y.Z -R AntheaLiles/k7pl -p 'k7pl-spec.pdf*'
gh release verify-asset spec-vX.Y.Z k7pl-spec.pdf -R AntheaLiles/k7pl
# depuis un clone du dépôt, tags récupérés : le commit attendu est celui du tag
gh attestation verify   k7pl-spec.pdf --repo AntheaLiles/k7pl \
    --bundle k7pl-spec.pdf.sigstore.json \
    --signer-workflow AntheaLiles/k7pl/.github/workflows/release.yaml \
    --source-ref refs/tags/spec-vX.Y.Z \
    --source-digest "$(git rev-parse spec-vX.Y.Z^{commit})" \
    --deny-self-hosted-runners
sha256sum -c k7pl-spec.pdf.sha256      # détecte la corruption, n'authentifie rien
```

Ce que cela prouve : le fichier est celui enregistré par GitHub à la publication immuable de la
release, et il a été attesté par une exécution du workflow `release.yaml` de ce dépôt, à ce tag, sur
un runner hébergé par GitHub. Ce que cela ne prouve pas : que le PDF soit reproductible, que les
entrées de la construction (toolchain, bundle TeX) soient exemptes de code malveillant, que le commit
ait été relu, ni quoi que ce soit sur la justesse de la spécification. L'identité attestée est un
workflow, pas une personne.

## Limites connues de la chaîne de construction

Ces limites sont connues et **non traitées** ; les actions GitHub sont épinglées par SHA, mais cela ne
couvre pas ce qu'elles téléchargent ensuite.

- Le toolchain Lean est installé par elan, que `leanprover/lean-action` récupère par un script
  distant de la branche `master` d'elan, puis un binaire `latest`, sans empreinte ; elan télécharge
  ensuite le toolchain sans vérification (constat par recherche de motifs, non exhaustif).
- Le bundle TeX de Tectonic est téléchargé à l'exécution et n'est pas épinglé. La somme SHA-256 de
  l'archive de Tectonic, enregistrée dans ce dépôt, détecte une dérive mais n'authentifie pas
  l'archive.
- D'autres actions téléchargent des binaires (`actionlint` en `latest`, gitleaks, lychee) ou
  construisent des images Docker par tag (`fsfe/reuse`, `node`, `scorecard-action`), sans empreinte.
- Le cache binaire de Mathlib (`lake exe cache get`) n'est pas revérifié par le noyau à l'import.
- Le hook de session des agents installe elan par version et par somme enregistrée : cette somme est
  une première observation, non une empreinte publiée par l'amont.
- Le PDF de la spécification n'est pas démontré reproductible.
- Un seul humain porte le projet, sans revue indépendante (voir `CONTRIBUTING.md`, « Revue »).
