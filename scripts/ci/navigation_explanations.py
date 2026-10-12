# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC-BY-4.0
"""Curated, non-normative progressive explanations for the generated K7PL site.

Each explanation explicitly names a rendered source anchor and links back to the
canonical Verso material. It does not add or infer scientific relations.
"""

INTRO = "c1-prolegomenes/c1-introduction/index.html"
GRADED_SYSTEM = "c3-types/c3-le-systeme-gradue/index.html#lbl-sec-c3-le-systeme-gradue"
VERIFICATION = "c6-compilation/c6-strategies-de-verification-et/index.html#lbl-sec-c6-strategies-de-verification-et"


def source(label: str, url: str) -> dict[str, str]:
    return {"label": label, "url": url}


EXPLANATION_CATALOG = [
    {
        "id": "k7pl-graded-design",
        "title": "Pourquoi K7PL organise-t-il la rigueur par niveaux ?",
        "target_url": INTRO,
        "notice": (
            "Synthèse éditoriale non normative, rédigée à partir de l’introduction de la "
            "spécification. Elle oriente la lecture ; la source Verso fait autorité."
        ),
        "levels": {
            "intro": {
                "text": (
                    "K7PL part d’un problème de conception : un langage doit pouvoir "
                    "s’exécuter près du matériel, préserver la sûreté mémoire et concurrence, "
                    "et rester vérifiable avant la mise en production. L’introduction propose "
                    "de ne pas traiter ces exigences comme un compromis global unique."
                ),
                "sources": [source("Introduction de la spécification", INTRO)],
            },
            "concept": {
                "text": (
                    "L’idée directrice est de graduer localement le niveau de rigueur dans "
                    "un même langage. La spécification soutient que plusieurs exigences "
                    "peuvent être exprimées comme instances d’une même structure algébrique. "
                    "C’est l’hypothèse organisatrice du projet, pas à elle seule une preuve "
                    "de correction."
                ),
                "sources": [
                    source("Introduction de la spécification", INTRO),
                    source("Le système gradué (C3)", GRADED_SYSTEM),
                ],
            },
            "detail": {
                "text": (
                    "L’introduction distingue trois états de maturité : « arrêté », "
                    "« construit, non éprouvé » et « nommé, non posé ». Une notion peut donc "
                    "être construite alors que ses propriétés ne sont pas encore établies ; "
                    "ces statuts ne doivent pas être confondus."
                ),
                "sources": [source("Introduction : état des constructions", INTRO)],
            },
            "formalization": {
                "text": (
                    "Pour suivre la formalisation du principe de gradation, passer de "
                    "l’introduction à la section sur le système gradué. Le graphe expose les "
                    "renvois présents dans le document ; il ne déclare pas, de lui-même, "
                    "qu’un lien de lecture est une dépendance de preuve."
                ),
                "sources": [
                    source("Introduction de la spécification", INTRO),
                    source("Le système gradué (C3)", GRADED_SYSTEM),
                ],
            },
            "verification": {
                "text": (
                    "L’introduction précise que le jeu de règles de typage est construit, "
                    "mais que certaines propriétés restent à établir. Il faut donc distinguer "
                    "l’existence d’une construction, un résultat démontré et une vérification "
                    "encore planifiée. La section de C6 fournit le parcours consacré aux "
                    "stratégies de vérification et de test."
                ),
                "sources": [
                    source("Introduction : état des constructions", INTRO),
                    source("Stratégies de vérification et de test (C6)", VERIFICATION),
                ],
            },
            "sources": {
                "text": (
                    "Les liens vers une section et les citations bibliographiques n’ont pas "
                    "la même portée : le graphe distingue les références documentaires des "
                    "citations. Une citation indique qu’une source est citée ; elle ne prouve "
                    "pas, à elle seule, qu’un résultat de K7PL en découle."
                ),
                "sources": [
                    source("Introduction de la spécification", INTRO),
                    source("Le système gradué (C3)", GRADED_SYSTEM),
                    source("Stratégies de vérification et de test (C6)", VERIFICATION),
                ],
            },
        },
    }
]
