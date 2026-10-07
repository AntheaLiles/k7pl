# -*- coding: utf-8 -*-
"""Contrôles d'algèbre, nés de la campagne PR-02.

Le 9 septembre, j'ai remonté au chapitre 2 une loi « vraie pour tout grade r »
sans vérifier son élément absorbant. Six relecteurs sur six ne l'ont pas vue ;
le septième, oui, et il avait raison : la loi est fausse en \\(\\omega\\).

Trente-six contrôles vérifiaient la cohérence interne du document. Aucun ne
vérifiait qu'une algèbre se comporte à ses bornes. Ceux qui suivent le font,
par le calcul plutôt que par la lecture.

Le principe est le même que celui du croisement grammaire/règles : le document
DÉCLARE son algèbre, et l'outil la CALCULE. Un écart fait échouer la
construction plutôt que d'attendre une relecture.
"""
import io, os, re, itertools

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

from controles.journal import ko, ok


# ── L'arithmétique de ℕ∞, telle que le document la déclare ────────────────────
# ω est écrit OMEGA ici, et il n'est pas un entier : les quatre égalités qui le
# gouvernent — 0·ω, ω·0, ω+ω, ω·ω — doivent être écrites au document. Tant
# qu'elles ne le sont pas, ce module porte la convention qu'il vérifie, et le
# contrôle `conventions_de_l_infini_ecrites` réclame qu'elles soient dites.
OMEGA = float("inf")


def _plus(a, b):
    return OMEGA if (a == OMEGA or b == OMEGA) else a + b


def _fois(a, b):
    if a == 0 or b == 0:
        return 0                      # 0 absorbe, y compris 0·ω = 0
    return OMEGA if (a == OMEGA or b == OMEGA) else a * b


def _moins_residu(beta, k):
    """⊖ comme RÉSIDU de l'addition : le plus petit x tel que k + x ≥ β.

    C'est la définition que le chapitre 2 donne aujourd'hui. Elle a une
    conséquence que personne n'avait calculée : ω ⊖ ω = 0, puisque ω + 0 ≥ ω.
    """
    if k >= beta:
        return 0
    if beta == OMEGA:
        return OMEGA                  # aucun x fini ne majore ω
    return beta - k


def _moins_tronque(beta, k):
    """⊖ comme soustraction tronquée PROLONGÉE en ω : β = ω donne ω.

    C'est la définition que la correction retient. Elle n'est pas le résidu, et
    le document doit le dire : pour une borne, ω ⊖ ω = ω est la
    sur-approximation sûre, quand le résidu rendrait 0 — c'est-à-dire une
    promesse que rien ne tient.
    """
    if beta == OMEGA:
        return OMEGA
    if k >= beta:
        return 0
    return beta - k


ECHANTILLON = [0, 1, 2, 3, 5, OMEGA]


def _contre_exemples(moins, restreinte=False):
    """Les couples où r·ψ(Δ,ε) = ψ(r·Δ, φ_r(ε)) échoue, sur la composante budget.

    Membre gauche  : u · (β ⊖ k)
    Membre droit   : (u · β) ⊖ (u · k)

    `restreinte` applique la condition de bord que le document porte depuis le
    30 septembre : usage fini, ou effet sans coût temporel. Le calcul établit
    qu'AUCUNE définition de ⊖ ne rend la loi vraie sans elle — pour u = ω,
    β = k demande ω ⊖ ω = 0 et β > k demande ω ⊖ ω = ω.
    """
    fautes = []
    for u, beta, k in itertools.product(ECHANTILLON, repeat=3):
        if restreinte and u == OMEGA and k != 0:
            continue
        g = _fois(u, moins(beta, k))
        d = moins(_fois(u, beta), _fois(u, k))
        if g != d:
            fautes.append((u, beta, k, g, d))
    return fautes


def loi_d_action_aux_bornes(ctx):
    """La compatibilité de l'action graduée tient-elle à 0 et à ω ?

    Le contrôle calcule les deux membres sur un échantillon incluant les deux
    éléments absorbants, et sous la définition de ⊖ que le document donne.
    """
    c2 = os.path.join(BASE, "src", "chapitres", "c2-fondements.org")
    texte = io.open(c2, encoding="utf-8").read()

    # Quelle définition de ⊖ le document porte-t-il ?
    residu = bool(re.search(r"/r[ée]sidu/ de l'addition", texte))
    tronquee = bool(re.search(r"soustraction tronqu[ée]e\s+/?prolong", texte))

    if residu and not tronquee:
        moins, nom = _moins_residu, "résidu de l'addition"
    elif tronquee:
        moins, nom = _moins_tronque, "soustraction tronquée prolongée"
    else:
        ko("la définition de ⊖ n'est pas identifiable au chapitre 2")
        return

    # Le document restreint-il la loi ? La condition de bord est « usage fini,
    # ou effet sans coût temporel ».
    restreinte = bool(re.search(
        r"composante d'usage \$u\$ est \\emph\{finie\}|u\s*\\neq\s*\\omega", texte))

    fautes = _contre_exemples(moins, restreinte)
    fmt = lambda x: "ω" if x == OMEGA else "%g" % x
    if fautes:
        u, beta, k, g, d = fautes[0]
        ko("loi d'action FAUSSE sous « %s »%s — %d couple(s) ; "
           "ex. u=%s β=%s k=%s : gauche %s, droit %s"
           % (nom, " (restreinte)" if restreinte else "", len(fautes),
              fmt(u), fmt(beta), fmt(k), fmt(g), fmt(d)))
    elif not restreinte:
        ko("loi d'action énoncée sans restriction — aucune définition de ⊖ ne "
           "la rend vraie en u = ω, quel que soit ⊖")
    else:
        ok("loi d'action : restreinte et vérifiée aux bornes sous « %s »" % nom)


def action_sur_la_composition_parallele(ctx):
    """L'action du grade traverse-t-elle la mise en parallèle ?

    Depuis que les effets se composent de deux façons, une loi qui ne vaudrait
    que du séquencement ne vaudrait que de la moitié du langage. Le contrôle
    vérifie les deux composantes du facteur temporel : le travail s'additionne,
    la profondeur prend le maximum.

    Le cas qui mérite le calcul est celui de la profondeur à l'infini —
    u · max(s₁,s₂) = max(u·s₁, u·s₂) tient en ω parce que la multiplication y
    est croissante, mais cela se vérifie plutôt que cela ne se suppose.
    """
    c2 = os.path.join(BASE, "src", "chapitres", "c2-fondements.org")
    texte = io.open(c2, encoding="utf-8").read()
    if "thm:action_parallele" not in texte:
        ok("action graduée : aucune composition parallèle déclarée")
        return

    travail = [(u, a, b) for u, a, b in itertools.product(ECHANTILLON, repeat=3)
               if _fois(u, _plus(a, b)) != _plus(_fois(u, a), _fois(u, b))]
    profondeur = [(u, a, b) for u, a, b in itertools.product(ECHANTILLON, repeat=3)
                  if _fois(u, max(a, b)) != max(_fois(u, a), _fois(u, b))]
    if travail or profondeur:
        fmt = lambda t: "u=%s a=%s b=%s" % tuple(
            "ω" if x == OMEGA else "%g" % x for x in t)
        ko("l'action ne traverse pas ∥ — travail : %d, profondeur : %d ; ex. %s"
           % (len(travail), len(profondeur),
              fmt((travail or profondeur)[0])))
    else:
        ok("action graduée : traverse ∥ sur les deux composantes (%d triplets)"
           % (len(ECHANTILLON) ** 3))


def conventions_de_l_infini_ecrites(ctx):
    """Les quatre égalités qui gouvernent ω sont-elles écrites ?

    ℕ∞ porte les indices de taille, les budgets et la composante d'usage. Les
    relecteurs ont relevé qu'aucune des quatre — 0·ω, ω·0, ω+ω, ω·ω — n'est
    écrite nulle part, alors que trois démonstrations en dépendent.
    """
    sources = [os.path.join(BASE, "src", "chapitres", "c2-fondements.org"),
               os.path.join(BASE, "src", "K7_Semantique.org")]
    texte = "".join(io.open(p, encoding="utf-8").read() for p in sources
                    if os.path.exists(p))
    # On cherche une table ou une suite d'égalités portant sur ω.
    attendues = [
        (r"0\s*\\cdot\s*\\omega|0\s*\\times\s*\\omega", "0 · ω"),
        (r"\\omega\s*\\cdot\s*0|\\omega\s*\\times\s*0", "ω · 0"),
        (r"\\omega\s*\+\s*\\omega", "ω + ω"),
        (r"\\omega\s*\\cdot\s*\\omega|\\omega\s*\\times\s*\\omega", "ω · ω"),
    ]
    manquantes = [nom for motif, nom in attendues
                  if not re.search(motif, texte)]
    if manquantes:
        ko("égalité(s) de ℕ∞ jamais écrite(s) : %s" % manquantes)
    else:
        ok("conventions de ℕ∞ : les quatre égalités de ω sont écrites")


def clause_laisse_habitable(ctx):
    """Une clause de bonne formation laisse-t-elle vivre ce qu'elle gouverne ?

    Le 9 septembre, j'ai borné tout indice de taille à ℕ∞ ∖ {ω} et appliqué la
    clause aux deux polarités. Conséquence, qu'aucun contrôle n'a vue : un flux
    de taille n rend n observations puis n'est plus éliminable. La couche 2 ne
    portait plus aucun processus non terminé — ce pour quoi elle existe.

    La règle que ce contrôle tient : une clause qui exclut le plus grand élément
    ne peut pas gouverner une polarité coinductive. Les deux sortes doivent être
    distinctes et nommées.
    """
    sources = [os.path.join(BASE, "src", "chapitres", "c2-fondements.org"),
               os.path.join(BASE, "src", "K7_Semantique.org")]
    texte = "".join(io.open(p, encoding="utf-8").read() for p in sources
                    if os.path.exists(p))

    mu = re.search(r"\\mathbb\{S\}_\\mu", texte)
    nu = re.search(r"\\mathbb\{S\}_\\nu", texte)
    if not (mu and nu):
        ko("les deux sortes de tailles ne sont pas toutes deux nommées : "
           "𝕊_μ %s, 𝕊_ν %s" % ("oui" if mu else "NON", "oui" if nu else "NON"))
        return

    # 𝕊_μ doit exclure ω ; 𝕊_ν doit le retenir. L'inverse rendrait le pli
    # non terminant, ou le flux non typable.
    bloc_mu = texte[mu.start(): mu.start() + 220]
    bloc_nu = texte[nu.start(): nu.start() + 220]
    if "setminus" not in bloc_mu:
        ko("𝕊_μ n'exclut pas ω — un pli de taille ω ne terminerait pas")
    elif "setminus" in bloc_nu:
        ko("𝕊_ν exclut ω — aucun flux non terminé ne serait typable")
    else:
        ok("sortes de tailles : 𝕊_μ sans ω, 𝕊_ν avec ω, disjointes")
