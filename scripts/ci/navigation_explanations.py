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
    },
    {
        "id": "k7pl-graded-system",
        "title": "Que distingue un grade, une modalité et un mode ?",
        "target_url": GRADED_SYSTEM,
        "notice": (
            "Synthèse éditoriale non normative, rédigée à partir de la section C3. "
            "Les définitions et statuts de la spécification Verso font autorité."
        ),
        "levels": {
            "intro": {
                "text": (
                    "Le système gradué de K7PL organise des contraintes d’usage dans un "
                    "même langage. Pour le lire correctement, il faut distinguer la valeur "
                    "qui annote une liaison, le domaine autorisé pour cette valeur et les "
                    "permissions structurelles associées à un type."
                ),
                "sources": [source("Le système gradué (C3)", GRADED_SYSTEM)],
            },
            "concept": {
                "text": (
                    "Un grade est une annotation portée par une liaison : il exprime les "
                    "conditions et la quantité d’usage de cette liaison. Une modalité est "
                    "un intervalle de grades autorisés par un type. Un mode structurel décrit "
                    "plus précisément une algèbre de grades, les grades contractables et "
                    "la permission d’affaiblissement. Ces notions sont liées, mais ne sont "
                    "pas interchangeables."
                ),
                "sources": [source("Définitions et distinctions (C3)", GRADED_SYSTEM)],
            },
            "detail": {
                "text": (
                    "Les intervalles d’usage Lin [1..1], Aff [0..1], Rel [1..ω] et Unr "
                    "[0..ω] classent les usages permis par la syntaxe. La section précise "
                    "que ces intervalles ne sont ni l’ordre de sous-typage, ni l’ordre de "
                    "précision, et qu’ils ne forment pas automatiquement une algèbre de modes."
                ),
                "sources": [source("Intervalles d’usage et leurs limites (C3)", GRADED_SYSTEM)],
            },
            "formalization": {
                "text": (
                    "Le périmètre normatif décrit dans C3 retient trois modes structurels "
                    "de référence : Lin, Aff et Unr. Le quadruplet structurel candidat Rel "
                    "reste une possibilité théorique séparée ; il ne devient pas normatif "
                    "parce que l’intervalle d’usage Rel existe. Il faut donc lire les "
                    "annotations, les intervalles et les triplets de mode comme trois niveaux "
                    "de formalisation distincts."
                ),
                "sources": [source("Modes structurels de référence (C3)", GRADED_SYSTEM)],
            },
            "verification": {
                "text": (
                    "La proposition sur les morphismes entre les trois modes est explicitement "
                    "marquée under-review avec une esquisse de preuve. La section précise les "
                    "obligations encore ouvertes et avertit que cette esquisse ne démontre ni "
                    "la réalisation des permissions par les règles de typage K7PL, ni la "
                    "préservation de leur dénotation. Un candidat formel ne doit pas être "
                    "présenté comme un résultat établi."
                ),
                "sources": [source("Proposition et obligations ouvertes (C3)", GRADED_SYSTEM)],
            },
            "sources": {
                "text": (
                    "C3 cite des travaux sur les systèmes gradués et les théories de modes. "
                    "Ces citations documentent les choix de conception ; leur présence ne "
                    "signifie pas que les propriétés spécifiques de K7PL sont démontrées par "
                    "ces références. Les états et obligations internes restent à consulter "
                    "dans la source Verso."
                ),
                "sources": [source("Section canonique C3 et ses citations", GRADED_SYSTEM)],
            },
        },
    },
]
