# -*- coding: utf-8 -*-
"""Citations, fonds bibliographique et non-régression."""
import io, os, re, sys, json, unicodedata, glob
from collections import Counter

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

from controles.journal import ko, ok
from controle import norm_texte, CITE, SPEC, CHANT, THEO

def citations(ctx):
    """Citations."""
    corps = ctx.get("corps")
    suivi = ctx.get("suivi")
    t = ctx.get("t")
    bib = ctx.get("bib")
    fonds = ctx.get("fonds")
    dec = ctx.get("dec")
    v = ctx.get("v")
    citees = ctx.get("citees")
    corpus = ctx.get("corpus")
    labels = ctx.get("labels")
    manque = ctx.get("manque")
    designees = ctx.get("designees")
    projet = ctx.get("projet")
    # ── citations ──────────────────────────────────────────────────────────
    # Depuis le 10 août, refs.bib est un export de la BIBLIOTHÈQUE Zotero et non
    # le fonds du projet. On distingue donc :
    #   — le FONDS-PROJET : les clés que le projet s'est appropriées, soit en les
    #     citant dans le corps, soit en les désignant dans une fiche du chantier
    #     (marqueur ~cite:@clé~, écrit au dépouillement pour la rédaction) ;
    #   — la BIBLIOTHÈQUE : tout le reste, qui appartient à Anthea et que ce
    #     contrôle compte sans rien en exiger.
    # L'exigence de décision datée porte sur le premier, jamais sur la seconde.
    print("\n[Citations]")
    citees = set(re.findall(CITE, corps))
    # Les fiches de dépouillement — litterature-grise.org, arc-theorique.org —
    # sont des fichiers de travail que chantier/index.org n'assemble pas. On les
    # lit donc SUR DISQUE : une désignation y vaut appropriation.
    import glob
    designees = set()
    for motif in ("meta/*.org", "OLD/chantier/*.org", "OLD/theorisation/*.org"):
        for f in glob.glob(os.path.join(BASE, motif)):
            designees |= set(re.findall(r'~cite:@([A-Za-z0-9_.:+\-]+)~',
                                        io.open(f, encoding="utf-8").read()))
    # RÈGLE DU 10 AOÛT : « le RDF sert à la RECHERCHE, le BIB sert à CITER ».
    # Deux ensembles, deux contrôles, tous deux stricts.
    corpus = set()
    _pi = os.path.join(BASE, "bib", "pdf-index.json")
    if os.path.exists(_pi):
        corpus = set(json.load(io.open(_pi, encoding="utf-8")))
    hors_bib = sorted((citees | set(re.findall(CITE, suivi))) - fonds)
    ko("clés CITÉES absentes de refs-pour-citations.bib : %s" % hors_bib) if hors_bib else \
        ok("%d clés citées, toutes dans refs-pour-citations.bib (%d entrées)" % (len(citees), len(fonds)))
    hors_corpus = sorted(designees - corpus - fonds)
    ko("clés DÉSIGNÉES absentes du corpus de lecture : %s" % hors_corpus) if hors_corpus else \
        ok("%d clés désignées au chantier, toutes au corpus (%d entrées lisibles)"
           % (len(designees), len(corpus)))
    # Le FONDS-PROJET reste ce que le projet s'est approprié ET qui est au fonds.
    projet = (citees | designees) & fonds
    orph = sorted(projet - citees - set(dec))
    if orph:
        ko("entrées du FONDS-PROJET citées nulle part et sans décision : %s" % orph)
    else:
        ok("aucune orpheline dans le fonds-projet (%d clés)" % len(projet))
    ok("%d entrées de bibliothèque hors fonds-projet — non exigées (arbitrage du 10 août)"
       % len(fonds - projet))
    for k in sorted(set(dec) & projet - citees):
        ok("%s non citée, MAINTENUE PAR DECISION du %s — à revoir à : %s"
           % (k, dec[k]["depuis"], dec[k]["revoir_a"]))
    num = [m.group(0) for l in corps.split("\n") if not l.startswith("#")
           for m in re.finditer(r'(?<!cite:@)\[(\d{1,3})\]', l)]
    if num:
        ko("citations numériques résiduelles dans le corps : %s" % num[:6])
    else:
        ok("aucune citation numérique écrite à la main")
    ctx.update({"citees": citees, "corpus": corpus, "designees": designees, "projet": projet})

def non_regression_bibliographique(ctx):
    """Non-regression bibliographique."""
    corps = ctx.get("corps")
    suivi = ctx.get("suivi")
    t = ctx.get("t")
    bib = ctx.get("bib")
    fonds = ctx.get("fonds")
    dec = ctx.get("dec")
    v = ctx.get("v")
    citees = ctx.get("citees")
    corpus = ctx.get("corpus")
    labels = ctx.get("labels")
    manque = ctx.get("manque")
    designees = ctx.get("designees")
    projet = ctx.get("projet")
    # ── non-régression contre le gel de v64 ────────────────────────────────
    print("\n[Non-regression bibliographique]")
    gel = json.load(io.open(os.path.join(BASE, "bib", "non-regression-v64.json"),
                            encoding="utf-8"))
    perdues = sorted(set(gel["cles"]) - citees - set(dec))
    if perdues:
        for p in perdues:
            ko("référence de v%d qui cesse d'être citée, sans décision : %s" % (gel["_version"], p))
    else:
        ok("aucune des %d références de v%d n'a été perdue" % (len(gel["cles"]), gel["_version"]))

def lisibilite_des_citations(ctx):
    """Lisibilité des citations."""
    corps = ctx.get("corps")
    suivi = ctx.get("suivi")
    t = ctx.get("t")
    bib = ctx.get("bib")
    fonds = ctx.get("fonds")
    dec = ctx.get("dec")
    v = ctx.get("v")
    citees = ctx.get("citees")
    corpus = ctx.get("corpus")
    labels = ctx.get("labels")
    manque = ctx.get("manque")
    designees = ctx.get("designees")
    projet = ctx.get("projet")
    # ── lisibilité des citations ───────────────────────────────────────────
    print("\n[Lisibilité des citations]")
    from controles.croise import citations_lisibles as _lis
    _ok3, _msg3 = _lis(BASE, corps)
    for _l in _msg3:
        (ok if _ok3 else ko)(_l) if not _l.startswith("   ") else print("        " + _l.strip())

def analyse_des_cles_citees(ctx):
    """Analyse des clés citées."""
    corps = ctx.get("corps")
    suivi = ctx.get("suivi")
    t = ctx.get("t")
    bib = ctx.get("bib")
    fonds = ctx.get("fonds")
    dec = ctx.get("dec")
    v = ctx.get("v")
    citees = ctx.get("citees")
    corpus = ctx.get("corpus")
    labels = ctx.get("labels")
    manque = ctx.get("manque")
    designees = ctx.get("designees")
    projet = ctx.get("projet")
    # ── ce qu'une clé citée doit comme ANALYSE ─────────────────────────────
    # CORP-IDENT, 3 septembre. Citer et dépouiller ne sont pas le même acte.
    # Une clé citée UNE fois l'est pour une affirmation précise, et n'appelle
    # pas de note d'analyse ; une clé citée trois fois porte trois affirmations
    # distinctes, et l'absence de note laisse le lecteur sans le fil qui les
    # relie. Le seuil est à trois, et il est arbitraire — mais un seuil déclaré
    # vaut mieux qu'une dette de soixante-dix qu'on ne saura jamais solder.
    # L'analyse peut vivre à deux endroits : le drapeau SYNTHESE du corpus, ou
    # le dépouillement d'une question close. Les deux comptent.
    print("\n[Analyse des clés citées]")
    cp = os.path.join(BASE, "meta", "corpus.org")
    qp0 = os.path.join(BASE, "meta", "questions.org")
    if not (os.path.exists(cp) and os.path.exists(qp0)):
        ok("corpus ou questions absents — contrôle non conduit")
    else:
        ct = io.open(cp, encoding="utf-8").read()
        qt0 = io.open(qp0, encoding="utf-8").read()
        occ = {}
        for bl in re.findall(r"\[cite:([^\]]+)\]", corps):
            for kk in re.findall(r"@([A-Za-z0-9\-\._:+]+)", bl):
                occ[kk] = occ.get(kk, 0) + 1
        avec = set()
        for mm in re.finditer(r"^\*\* (?:\w+ )?(\S+)\n:PROPERTIES:\n(.*?):END:",
                              ct, re.M | re.S):
            if re.search(r":SYNTHESE: *t\b", mm.group(2)):
                avec.add(mm.group(1))
        # dépouillements : champ REF et lignes de suivi des questions closes
        lignes = qt0.split("\n")
        deb = [i for i, l in enumerate(lignes)
               if re.match(r"^\*\* (TODO|DOING|DONE) ", l)] + [len(lignes)]
        for i in range(len(deb) - 1):
            bloc = "\n".join(lignes[deb[i]:deb[i + 1]])
            if not bloc.startswith("** DONE"):
                continue
            rr = re.search(r":REF: ([^\n]*)", bloc)
            if rr:
                for x in re.split(r"[,;]\s*", rr.group(1).strip()):
                    if re.match(r"^[A-Za-z][A-Za-z0-9\.\-_]{4,}$", x.strip()):
                        avec.add(x.strip())
            for mm in re.finditer(
                    r"^\*\*\*\* (?:TODO|DOING|DONE) ([A-Za-z][A-Za-z0-9\.\-_]{4,})\s*$",
                    bloc, re.M):
                avec.add(mm.group(1))
        dus = sorted(k for k, n in occ.items() if n >= 3 and k not in avec)
        if dus:
            ko("clés citées 3 fois ou plus, sans analyse au corpus ni en question : %s" % dus)
        else:
            n1 = sum(1 for k, n in occ.items() if n == 1 and k not in avec)
            ok("toute clé citée 3 fois ou plus porte son analyse "
               "(%d clés citées une seule fois n'en demandent pas)" % n1)

