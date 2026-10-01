#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Contrôle croisé G.2 / G.3 : la grammaire des termes doit couvrir le jeu de règles.

Trois objets devraient coïncider et rien ne les comparait : la grammaire des termes de
l'annexe G.2, le jeu de règles de G.3, et la liste des primitives de T-68. Ce contrôle
compare les deux premiers, qui sont dans le document, et rend le compte des constructeurs
de termes — ce qui règle la question du compte sans arbitrage d'opinion.

Employé seul :   python3 outils/croise.py [version]
Employé depuis controle.py : importer verifier() et lui passer le corps assemblé.
"""
import io, os, re, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

# Les constructeurs de TERMES que le document nomme, avec la règle qui les gouverne.
# Une entrée absente de ce tableau et présente dans les règles fera échouer le contrôle :
# c'est le point du contrôle, et il ne s'assouplit pas pour passer.
ATTENDUS = {
    # règle       : (motif dans la grammaire G.2, sorte)
    "Var":     (r"::= x ",                                  "valeur"),
    "One":     (r"\\mid \(\)",                              "valeur"),
    "Pair":    (r"\\mid \(v, v\)",                          "valeur"),
    "Inj":     (r"mathsf\{inj\}",                           "valeur"),
    "Box":     (r"mathsf\{box\}",                           "valeur"),
    "Th":      (r"mathsf\{thunk\}",                         "valeur"),
    "Pack":    (r"mathsf\{pack\}",                          "valeur"),
    "Fold":    (r"mathsf\{fold\}\\;v",                       "valeur"),
    "Ret":     (r"mathsf\{return\}",                        "calcul"),
    "Let":     (r"mathsf\{let\}.{0,3}x .{0,3}leftarrow",      "calcul"),
    "Lam":     (r"lambda x\.",                              "calcul"),
    "App":     (r"mid c.{0,3}v ",                            "calcul"),
    "Fo":      (r"mathsf\{force\}",                         "calcul"),
    "Case":    (r"mathsf\{case\}",                          "calcul"),
    "Unbox":   (r"mathsf\{unbox\}",                         "calcul"),
    "Op":      (r"mathsf\{operation\}",                     "calcul"),
    "OneE":    (r"mathsf\{let\}.{0,3}\(\) *=",                "calcul"),
    "Split":   (r"mathsf\{let\}.{0,3}\(x, ?y\)",              "calcul"),
    "With":    (r"langle c",                                "calcul"),
    "Proj":    (r"c\.i|mathsf\{pr\}",                       "calcul"),
    "Open":    (r"mathsf\{open\}",                          "calcul"),
    "Unfold":  (r"mathsf\{unfold\}",                        "calcul"),
    "Gen":     (r"Lambda.{0,8}alpha\.",                     "calcul"),
    "Inst":    (r"c.{0,3}\[W\]",                             "calcul"),
    "Sc":      (r"mathsf\{scoped\}",                        "calcul"),
    "Del":     (r"mathsf\{delay\}",                         "calcul"),
    "Alw":     (r"mathsf\{always\}",                        "calcul"),
    "Alw^{-}": (r"mathsf\{at\}",                            "calcul"),
    "Now":     (r"mathsf\{now\}",                           "calcul"),
    "Wait":    (r"mathsf\{wait\}",                          "calcul"),
    "When":    (r"mathsf\{when\}",                          "calcul"),
    "VecI":    (r"\[v_0",                                    "valeur"),
    # Renommé le 9 septembre : `fold` désignait deux constructions distinctes,
    # le constructeur du point fixe inductif et le parcours de vecteur. Une
    # relecture externe l'a relevé, et le second porte désormais son nom.
    "VecE":    (r"mathsf\{iter\}_\{?V",                      "calcul"),
    # Le point fixe coinductif, écrit le 9 septembre. C'est ce contrôle qui
    # avait isolé ν comme le seul connecteur de type inhabité, sur dix-neuf.
    "Out":     (r"mathsf\{out\}",                            "calcul"),
    "Cop":     (r"langle\\!\\langle j",                      "calcul"),
    # Le parallélisme de couche 3, écrit le 30 septembre. La campagne PR-02
    # avait relevé que le noyau formel était séquentiel ; c'en est la première
    # pièce, et la plus sûre — le fragment cartésien n'a pas d'endroit où deux
    # branches pourraient interférer.
    "Par":     (r"mid\\; c \\parallel c",                    "calcul"),
    "Vmap":    (r"mathsf\{vmap\}",                           "calcul"),
    # La couche 2, écrite le 1er octobre. C'est ce que la campagne PR-02
    # reprochait au premier chef : des acteurs décrits au corps du texte et
    # absents de l'appareil.
    "Spawn":   (r"mathsf\{spawn\}",                          "calcul"),
    "New":     (r"mathsf\{new\}_E",                          "calcul"),
    "Send":    (r"mathsf\{send\}",                           "calcul"),
    "Guard":   (r"mathsf\{guard\}",                          "calcul"),
    "Free":    (r"mathsf\{free\}",                           "calcul"),
    # La couche 1 — distribution. Les trois aspects se rangent dans les trois
    # strates existantes : c'est l'épreuve la plus sévère de la condition de
    # clôture, et elle la passe.
    "At":      (r"mathsf\{at\}_n",                           "calcul"),
    "Move":    (r"mathsf\{move\}_\{n",                       "calcul"),
    "Try":     (r"mathsf\{try\}",                            "calcul"),
}
# Deux règles gouvernent un objet qui n'est pas un terme de cette grammaire, et leur
# absence est correcte : tick est une INSTANCE du schéma operation (R-37), et Expand opère en
# Phase 0 sur l'arbre, avant que la grammaire des termes ne s'applique.
SANS_TERME_EN_PLUS = {"Tick", "Expand"}
# Règles qui ne gouvernent AUCUN constructeur de terme : ce sont des règles de
# structure ou de sous-typage, et leur absence de la grammaire est correcte.
SANS_TERME = {"Sub", "SubBox"} | SANS_TERME_EN_PLUS


def verifier(corps, verbeux=True):
    """Rend (ok, messages). corps est le document assemblé."""
    msg = []
    ok = True

    # ── la grammaire des termes, telle qu'elle est écrite ─────────────────────
    m = re.search(r"NAME: eq:grammaire-termes(.*?)#\+END_EXPORT", corps, re.S)
    if not m:
        return False, ["la grammaire des termes (eq:grammaire-termes) est introuvable"]
    gram = m.group(1)

    # ── les règles, telles qu'elles sont écrites ──────────────────────────────
    regles = set(re.findall(r"\\textsc\{([A-Za-z]+)\}(\^\{[^}]*\})?\s*\\;?\s*\\frac", corps))
    regles = {a + (b or "") for a, b in
              re.findall(r"\\textsc\{([A-Za-z]+)\}(\^\{[^}]*\})?\s*\\;?\s*\\frac", corps)}

    # ── 1. toute règle connue doit être déclarée ici ──────────────────────────
    inconnues = sorted(regles - set(ATTENDUS) - SANS_TERME)
    if inconnues:
        ok = False
        msg.append("règles absentes du tableau de croisement : %s" % inconnues)
        msg.append("   → une règle nouvelle doit être déclarée dans outils/croise.py,")
        msg.append("     avec le motif qui la retrouve dans la grammaire des termes.")

    # ── 1 bis. toute règle à terme doit avoir son entrée à la liste T-68 ─────
    # Ajouté le 8 septembre. Le croisement portait sur deux jeux — la grammaire
    # et les règles — quand il y en a trois : la LISTE DES PRIMITIVES en est le
    # troisième, et c'est elle qui nomme. Elle a dérivé sans que rien le voie :
    # la grammaire a reçu dix-sept constructeurs le 3 septembre, la liste n'en a
    # suivi aucun. Quatorze règles écrites n'avaient plus d'entrée.
    #
    # La liste désigne ses règles par la propriété :REGLE:. Ce contrôle exige
    # que toute règle gouvernant un constructeur de terme y figure — celles qui
    # n'en gouvernent aucun (SANS_TERME) en sont dispensées, et le disent.
    _prim = os.path.join(BASE, "meta", "primitives.org")
    if os.path.exists(_prim):
        _p = io.open(_prim, encoding="utf-8").read()
        _listees = set()
        for _l in re.findall(r"^:REGLE:\s*(.+)$", _p, re.M):
            for _x in re.split(r"[,;/ ]+", _l.strip()):
                if _x:
                    _listees.add(_x.strip().lower())
        _sans_entree = sorted(r for r in (regles & set(ATTENDUS))
                              if r.lower() not in _listees)
        if _sans_entree:
            ok = False
            msg.append("règles écrites sans entrée à la liste des primitives "
                       "(meta/primitives.org) : %s" % _sans_entree)
            msg.append("   → la liste nomme ce que le langage a ; une règle sans")
            msg.append("     entrée est une primitive que personne ne nommera.")
    else:
        msg.append("meta/primitives.org introuvable — croisement à trois non conduit")

    # ── 1 ter. tout connecteur de TYPE doit avoir ses règles de terme ────────
    # Ajouté le 8 septembre. Les trois premiers volets partent des RÈGLES ; ce
    # sens-là ne voit pas un connecteur de type qu'aucun terme n'habite. C'est
    # le cas de \nu\alpha.C : il figure à la grammaire des types, la couche 2
    # appuie sa productivité dessus, et aucune règle ne l'introduit ni ne
    # l'élimine. Le défaut a vécu sans être vu parce que rien ne regardait dans
    # ce sens.
    #
    # Deux familles en sont dispensées, et le manuscrit les déclare :
    #   — les formes de session sont de la syntaxe de surface sur l'implication
    #     linéaire, et leurs règles sont celles de cette implication ;
    #   — l'arène est une exception écrite, son élimination relevant du modèle
    #     mémoire et non du système de types.
    _m = re.search(r"NAME: eq:grammaire-types(.*?)#\+END_EXPORT", corps, re.S)
    if _m:
        _gt = _m.group(1)
        _TYPES = [
            (r"\\mu\\alpha", "mu", ("Fold", "Unfold")),
            (r"\\nu\\alpha", "nu", ("Nu", "Out", "Cop")),
            (r"\\exists", "existentiel", ("Pack", "Open")),
            (r"\\forall", "universel", ("Gen", "Inst")),
            (r"\\Box_", "modalite graduee", ("Box", "Unbox")),
            (r"\\otimes", "tenseur", ("Pair", "Split")),
            (r"\\bigoplus", "somme", ("Inj", "Case")),
            (r"\\mathop\{&\}", "conjonction additive", ("With", "Proj")),
            (r"\\multimap", "implication", ("Lam", "App")),
            (r"\\mathsf\{Vec\}", "vecteur", ("VecI", "VecE")),
        ]
        _orph = [n for motif, n, rgl in _TYPES
                 if re.search(motif, _gt) and not (set(rgl) & regles)]
        if _orph:
            ok = False
            msg.append("connecteurs de type qu'aucune règle de terme n'habite : %s"
                       % _orph)
            msg.append("   → un type que nul terme n'introduit ni n'élimine est")
            msg.append("     une promesse sans support.")

    # ── 2. toute règle à terme doit avoir son constructeur dans la grammaire ──
    absents = []
    for r in sorted(regles & set(ATTENDUS)):
        motif, _ = ATTENDUS[r]
        if not re.search(motif, gram):
            absents.append(r)
    if absents:
        ok = False
        msg.append("constructeurs gouvernés par une règle mais ABSENTS de la grammaire G.2 : %s"
                   % absents)
        msg.append("   → la grammaire des termes est en retard sur le jeu de règles.")

    # ── 3. le compte ─────────────────────────────────────────────────────────
    gouvernes = sorted(regles & set(ATTENDUS))
    v = [r for r in gouvernes if ATTENDUS[r][1] == "valeur"]
    c = [r for r in gouvernes if ATTENDUS[r][1] == "calcul"]
    if verbeux:
        msg.append("%d règles de typage, dont %d sans constructeur de terme"
                   % (len(regles), len(regles & SANS_TERME)))
        msg.append("%d constructeurs de termes gouvernés par une règle : %d valeurs, %d calculs"
                   % (len(gouvernes), len(v), len(c)))
    return ok, msg


# Le bloc __main__ a été retiré le 8 septembre. Il relançait `verifier` sur un
# assemblage figé — v297, du 2 septembre — et rendait donc un verdict sur un
# document périmé : « la grammaire des termes est en retard sur le jeu de
# règles », vrai ce jour-là, faux depuis, et crié dans le vide chaque fois
# qu'on lançait le fichier seul. Ces trois fonctions sont des BIBLIOTHÈQUES ;
# le point d'entrée est outils/controle.py, qui refuse un build périmé.



# ── contrôle de cohérence plan.org / questions.org, ajouté le 31 août ─────────
# Motif : l'arc H portait « 6 questions répondues » au plan et zéro au fichier
# de suivi. Le travail existait, sa trace non. Un écart de ce genre ne se voit
# pas à la lecture et invalide tout comptage. Il se voit en trois lignes.
def coherence_plan(base):
    """Rend (ok, messages). Compare les compteurs de plan.org aux états réels."""
    import collections
    msg = []; ok = True
    L = io.open(os.path.join(base, 'meta/questions.org'), encoding='utf-8').read().split('\n')
    par = collections.defaultdict(collections.Counter)
    for i, l in enumerate(L):
        if l.startswith('** ') and i + 2 < len(L) and L[i + 2].startswith(':ARC:'):
            par[L[i + 2].split()[1]][l.split(' ')[1]] += 1
    P = io.open(os.path.join(base, 'meta/plan.org'), encoding='utf-8').read()
    for m in re.finditer(r':TID: ARC-(\w)\n:QUESTIONS: (\d+)\n:REPONDUES: (\d+)', P):
        a, q, r = m.group(1), int(m.group(2)), int(m.group(3))
        n = sum(par[a].values()); d = par[a]['DONE']
        if q != n or r != d:
            ok = False
            msg.append("arc %s : plan annonce %d/%d, le suivi porte %d/%d" % (a, r, q, d, n))
    if ok:
        msg.append("plan.org et questions.org concordent sur les onze arcs")
    else:
        msg.append("   → corriger le compteur du plan, ou reporter le travail au suivi.")
        msg.append("     Un compteur qui ne correspond à rien est pire qu'un compteur absent.")
    return ok, msg


# ── troisième relation : toute clé CITÉE doit avoir un PDF ───────────────────
# Ajouté le 1er septembre. Deux contrôles existaient — la clé citée est-elle au
# bib, la clé désignée est-elle au corpus — et aucun ne demandait si la pièce est
# LISIBLE. Vingt-huit références sont restées citées sans PDF jusqu'à ce qu'une
# passe manuelle les collecte ; rien ne les avait signalées.
def citations_lisibles(base, corps):
    """Rend (ok, messages). Toute clé citée doit avoir un PDF au registre."""
    import json
    msg = []
    pi = os.path.join(base, "bib", "pdf-index.json")
    if not os.path.exists(pi):
        return True, ["registre des PDF absent — contrôle non conduit"]
    idx = json.load(io.open(pi, encoding="utf-8"))
    dec = {}
    dp = os.path.join(base, "bib", "decisions-bibliographiques.json")
    if os.path.exists(dp):
        d = json.load(io.open(dp, encoding="utf-8"))
        dec = d.get("citees_sans_pdf", {})
    # 3 septembre. La citation MULTIPLE — [cite:@a;@b;@c] — n'était vue ici que par
    # sa PREMIÈRE clé : le motif s'arrêtait au préfixe « cite:@ », que les suivantes
    # n'ont pas. controle.py avait été corrigé le 2 septembre, celui-ci non, de sorte
    # que cinq clés étaient citées au manuscrit sans qu'aucun contrôle ne les voie.
    # C'est la sixième « sonde incomplète », et la première qui touche un CONTRÔLE
    # plutôt qu'une recherche : un contrôle aveugle est pire qu'une absence de contrôle,
    # puisqu'il rend un vert que rien ne justifie.
    citees = set(re.findall(r"@([A-Za-z0-9_.:+\-]+)(?=[;\]])", corps))
    hors = sorted(k for k in citees if k not in idx and k not in dec)
    sans = sorted(k for k in citees
                  if k in idx and not idx[k].get("pdf") and k not in dec)
    ok = not (hors or sans)
    if hors:
        msg.append("clés citées ABSENTES du registre de lecture : %s" % hors)
    if sans:
        msg.append("clés citées SANS PDF et sans décision : %s" % sans)
        msg.append("   → une référence citée doit être lisible, ou porter une décision")
        msg.append("     datée dans decisions-bibliographiques.json, clé citees_sans_pdf.")
    if ok:
        msg.append("%d clés citées, toutes lisibles au registre" % len(citees))
    return ok, msg
