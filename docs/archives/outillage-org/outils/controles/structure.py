# -*- coding: utf-8 -*-
"""Renvois, étiquettes, comptages et cohérence du pilotage."""
import io, os, re, sys, json, unicodedata, glob
from collections import Counter

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

from controles.journal import ko, ok
from controle import norm_texte, CITE, SPEC, CHANT, THEO

def renvois(ctx):
    """Renvois."""
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
    # ── renvois ────────────────────────────────────────────────────────────
    print("\n[Renvois]")
    # org-latex-prefer-user-labels étant à t, un #+NAME: posé sur un flottant
    # produit son \label sans qu'on l'écrive. Le compter comme étiquette : ne
    # pas le faire faisait passer pour orpheline toute table nommée à l'org.
    # Corrigé le 8 septembre — c'était le doublon non tenu à jour du contrôle
    # [Renvois et étiquettes LaTeX], qui lit src/ et portait déjà la règle.
    labels = set(re.findall(r'\\label\{([^}]+)\}', t)) \
        | set(re.findall(r'^#\+NAME:\s*(\S+)\s*$', t, re.M))
    refs = re.findall(r'\\ref\{([^}]+)\}', t)
    o = sorted(set(r for r in refs if r not in labels))
    if o:
        ko("renvois orphelins : %s" % o)
    else:
        ok("%d étiquettes, %d renvois, aucun orphelin" % (len(labels), len(refs)))
    dbl = [k for k, n in Counter(re.findall(r'\\label\{([^}]+)\}', t)).items() if n > 1]
    if dbl:
        ko("étiquettes en double : %s" % dbl)
    else:
        ok("aucune étiquette en double")
    for zone, txt in (("corps", corps), ("suivi", suivi)):
        n = [m.group(0) for m in re.finditer(r'§\s?\d+\.\d+', txt)
             if "RENVOIS PAR" not in txt[max(0, m.start() - 400):m.start()]
             and not txt[:m.start()].rsplit("\n", 1)[-1].startswith("#")]
        if n:
            ko("renvois numériques dans le %s : %s" % (zone, n))
        else:
            ok("aucun renvoi numérique dans le %s" % zone)
    ctx.update({"labels": labels})

def objets_et_renvois(ctx):
    """Objets et renvois."""
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
    # ── objets flottants et renvois ────────────────────────────────────────
    print("\n[Objets et renvois]")
    import glob as _g2
    noms, liens, sans_nom = set(), [], 0
    for _f in _g2.glob(os.path.join(BASE, "src", "*.org")):
        _t = io.open(_f, encoding="utf-8").read()
        noms |= set(re.findall(r'^#\+NAME:\s*(\S+)', _t, re.M))
        liens += re.findall(r'\[\[((?:fig|tab|lst|eq|img):[^\]]+)\]\]', _t)
        # le #+NAME: peut précéder ou suivre la légende — org accepte les deux
        _lignes = _t.split("\n")
        for _i, _l in enumerate(_lignes):
            if _l.startswith("#+CAPTION:"):
                _voisins = _lignes[max(0, _i - 2):_i] + _lignes[_i + 1:_i + 3]
                if not any(x.startswith("#+NAME:") for x in _voisins):
                    sans_nom += 1
    morts = sorted(set(l for l in liens if l not in noms))
    ko("liens internes sans cible : %s" % morts) if morts else \
        ok("%d objets nommés, %d renvois internes, aucun mort" % (len(noms), len(liens)))
    ko("%d objet(s) légendé(s) sans #+NAME" % sans_nom) if sans_nom else \
        ok("tout objet légendé porte un nom")

def comptages(ctx):
    """Comptages."""
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
    # ── comptages ──────────────────────────────────────────────────────────
    print("\n[Comptages]")
    th = re.findall(r'\\begin\{theorem\}(.*?)\\end\{theorem\}', t, re.S)
    # Une EXIGENCE ne porte pas d'esquisse, et c'est ce qui la définit : elle
    # énonce ce que la réalisation doit tenir, non ce que le document démontre.
    # Exiger une preuve d'elle reviendrait à nier la distinction que le sceau
    # vient d'introduire. Posé le 1er octobre, avec la première exigence écrite.
    demonstrables = [x for x in th if "statut=exigence" not in x[:220]]
    sans = sum(1 for x in demonstrables if "proofsketch" not in x)
    ko("%d théorème(s) sans esquisse" % sans) if sans else \
        ok("%d énoncés démontrables avec esquisse, %d exigence(s) sans"
           % (len(demonstrables), len(th) - len(demonstrables)))
    nreg = (len(re.findall(r'\\textsc\{[A-Za-z]+\}(?:\^\{[^}]*\})?\s*\\;?\s*\\frac', t))
            + len(re.findall(r'\\label\{eq:regle-[^}]+\}', t)))
    # PLANCHERS. Un assemblage qui perd une annexe faisait chuter ces comptes sans
    # qu'aucun contrôle ne bronche — c'est arrivé le 4 août avec :minlevel.
    # Plancher relevé de 34 à 40 le 28 août : One, OneE, Split, Case ont été
    # écrites, et Proj s'est détachée de With en passant à la forme indexée.
    # écrites (T-69). Un plancher qu'on ne relève pas après un ajout cesse de
    # protéger ce qu'on vient d'écrire.
    ko("%d règles d'inférence — le jeu en compte 40, l'assemblage a perdu un morceau" % nreg) \
        if nreg < 40 else ok("%d règles d'inférence" % nreg)
    # Plancher relevé de 32 à 34 le 28 août : préservation et progrès sont
    # démontrés (T-69). Un plancher qu'on ne relève pas cesse de protéger.
    if len(th) < 34:
        ko("%d théorèmes — le document en compte 34" % len(th))
    # Chaque fichier inclus doit avoir contribué son titre au document assemblé.
    # Contrôle plus sûr qu'un comptage : il nomme celui qui manque.
    # Le contrôle est piloté par CE QUE main.org INCLUT, et non par un parcours du
    # dossier. Un fichier que l'assembleur ne mentionne plus n'est pas un fichier
    # perdu : c'est un fichier retiré, et le signaler comme un défaut ferait crier
    # l'outil à chaque réorganisation. Ce qui doit alerter est l'inverse — un
    # fichier INCLUS qui ne contribue rien.
    inclus = set(re.findall(r'^#\+INCLUDE:\s*"[^"]*?([^/"]+\.org)"',
                            io.open(os.path.join(BASE, "src", "main.org"),
                                    encoding="utf-8").read(), re.M))
    import glob as _g
    manquants = []
    for f in sorted(_g.glob(os.path.join(BASE, "src", "*.org"))
                + _g.glob(os.path.join(BASE, "src", "chapitres", "*.org"))):
        b = os.path.basename(f)
        if b not in inclus:
            continue   # non inclus par main.org : hors périmètre de ce contrôle
        titre = next((l for l in io.open(f, encoding="utf-8") if re.match(r'^\*+ ', l)), None)
        if titre is None:
            manquants.append("%s (aucun titre)" % b); continue
        if titre.lstrip("* ").rstrip() not in corps:
            manquants.append(b)
    ko("fichiers inclus absents du document assemblé : %s" % manquants) if manquants else \
        ok("les %d fichiers inclus ont contribué leur section"
           % (len(_g.glob(os.path.join(BASE, "src", "*.org")))
              + len(_g.glob(os.path.join(BASE, "src", "chapitres", "*.org"))) - 3))
    # saut de niveau : un titre de niveau 3 sous un titre de niveau 1
    sauts = []
    prec = 0
    for l in corps.split("\n"):
        m = re.match(r'^(\*+) ', l)
        if m:
            n = len(m.group(1))
            if prec and n > prec + 1:
                sauts.append(l.strip()[:52])
            prec = n
    if sauts:
        ok("saut de niveau de titre (org l'accepte, LaTeX moins) : %s" % sauts[:3])
    # Depuis le 5 août les entrées sont réparties par ÉTAT et non par numéro —
    # les ouvertes dans chantier/, les closes dans theorisation/. L'ordre de
    # lecture n'est donc plus croissant, et exiger qu'il le soit reviendrait à
    # interdire le rangement. Ce qui protège d'une entrée perdue est la
    # COMPLÉTUDE de l'ensemble et l'absence de doublon, non l'ordre.
    # REFONTE DU 28 AOÛT — le suivi (entrées T et G) a basculé vers OLD/ avec le
    # chantier. Ce contrôle ne doit donc PAS devenir vide en silence : il lit
    # l'archive, et il ÉCHOUE s'il ne trouve rien là où il trouvait soixante-neuf
    # entrées. Un contrôle qui passe sur zéro élément ne contrôle rien.
    import glob as _g3
    for _f in sorted(_g3.glob(os.path.join(BASE, "OLD", "chantier", "*.org"))
                     + _g3.glob(os.path.join(BASE, "OLD", "theorisation", "*.org"))):
        suivi += "\n" + io.open(_f, encoding="utf-8").read()
    ent = re.findall(r'^\*\*\* (TODO|DOING|WAITING|DONE|CANCELLED) \[T-(\d+)\]', suivi, re.M)
    if not ent:
        ko("aucune entrée T trouvée — le suivi a-t-il été déplacé sans réoutiller ?")
    ids = sorted(int(x[1]) for x in ent)
    manque = sorted(set(range(1, (max(ids) if ids else 0) + 1)) - set(ids))
    dbl = [k for k, n in Counter(ids).items() if n > 1]
    if manque or dbl:
        ko("entrées T — manquantes : %s ; en double : %s" % (manque, dbl))
    else:
        ok("%d entrées T, aucune manquante ni en double — %s"
           % (len(ent), dict(Counter(x[0] for x in ent))))
    g = re.findall(r'^\*\*\*+ (TODO|DOING|WAITING|DONE|CANCELLED) \[G-(\d+)\]', suivi, re.M)
    gid = [int(x[1]) for x in g]
    ko("entrées G : séquence trouée") if gid != list(range(1, len(gid) + 1)) else \
        ok("%d entrées G, séquence croissante — %s" % (len(g), dict(Counter(x[0] for x in g))))
    ctx.update({"manque": manque})

def coherence_plan_org_questions_org(ctx):
    """Cohérence plan.org / questions.org."""
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
    # ── cohérence des fichiers de suivi ────────────────────────────────────
    # Ajouté le 31 août. L'arc H annonçait six questions repondues au plan et
    # zero au fichier de suivi : le travail existait, sa trace non. Un ecart de
    # ce genre ne se voit pas a la lecture et invalide tout comptage.
    print("\n[Cohérence plan.org / questions.org]")
    from controles.croise import coherence_plan as _coh
    _ok2, _msg2 = _coh(BASE)
    for _l in _msg2:
        (ok if _ok2 else ko)(_l) if not _l.startswith("   ") else print("        " + _l.strip())

def croisement_manques_questions(ctx):
    """Croisement manques / questions."""
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
    # ── croisement manques.org / questions.org ─────────────────────────────
    # 3 septembre, cinquième occurrence du même défaut. Un manque porte au champ
    # BLOQUE la ou les questions qu'il empêche de fermer. Quand ces questions se
    # ferment, rien ne referme le manque : les deux fichiers ne se parlent pas.
    # Cinq fois en trois jours, un travail fait a laissé sa trace ouverte — et
    # une trace ouverte fait refaire, ce qui coûte plus qu'elle n'informe.
    print("\n[Croisement manques / questions]")
    mp = os.path.join(BASE, "meta", "manques.org")
    qp = os.path.join(BASE, "meta", "questions.org")
    if not (os.path.exists(mp) and os.path.exists(qp)):
        ok("fichiers de manques ou de questions absents — croisement non conduit")
    else:
        qt = io.open(qp, encoding="utf-8").read()
        etats = {}
        for mm in re.finditer(r"^\*\* (TODO|DOING|DONE) .*?\n:PROPERTIES:\n(.*?):END:",
                              qt, re.M | re.S):
            qq = re.search(r":QUID: ([\w\-]+)", mm.group(2))
            if qq:
                etats[qq.group(1)] = mm.group(1)
        mt = io.open(mp, encoding="utf-8").read()
        perimes = []
        for mm in re.finditer(r"^\*\* (TODO|DOING|CHERCHE) ([^\n]*)\n:PROPERTIES:\n(.*?):END:",
                              mt, re.M | re.S):
            bl = re.search(r":BLOQUE: ([^\n]*)", mm.group(3))
            if not bl:
                continue
            vises = re.findall(r"\bQ[A-K]-\d+\b", bl.group(1))
            if vises and all(etats.get(v) == "DONE" for v in vises):
                perimes.append((mm.group(2)[:52], vises))
        if perimes:
            ko("manques OUVERTS dont toutes les questions sont closes : %s"
               % [t for t, _ in perimes])
            msg = ("   → le travail est fait et la trace ne l'a pas suivi ; "
                   "clore le manque ou dire ce qu'il bloque encore.")
            print(msg)
            echecs.append(msg)
        else:
            ok("aucun manque ouvert dont les questions visées soient toutes closes")

    # ── vocabulaire de l'axiome ────────────────────────────────────────────
    # ARBITRAGE du 5 août : \mathcal{G} nomme l'ALGÈBRE de grades, jamais un
    # grade ni une composante du jugement ; la contrainte de complexité
    # \mathcal{C} n'existe plus comme composante, ayant été répartie sur le
    # budget du grade et le facteur temporel de l'effet.
    # Ces trois fautes s'étaient installées sur vingt versions sans qu'aucun
    # contrôle ne les voie, et chacune fait lire au jugement une arité
    # qu'il n'a pas. Elles sont désormais des échecs.

def renvois_et_etiquettes_latex(ctx):
    """Renvois et étiquettes LaTeX."""
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
    # ── tout renvoi LaTeX a son étiquette ──────────────────────────────────
    # Ajouté le 4 septembre. Deux \eqref pointaient dans le vide depuis que les
    # deux jeux de réductions avaient été écrits en align* : un #+NAME: org ne
    # produit AUCUN \label sur un bloc export — org recopie le bloc tel quel.
    # Le renvoi sortait en « ?? », et LaTeX prévenait « undefined references »,
    # ce qui fait relancer latexmk à chaque passe. Un renvoi cassé ne casse rien
    # de visible : il fait juste mentir le document et grossir le journal.
    print("\n[Renvois et étiquettes LaTeX]")
    _lab, _ref = set(), {}
    for _r, _, _fs in os.walk(os.path.join(BASE, "src")):
        for _f in sorted(_fs):
            if not _f.endswith(".org"):
                continue
            for _n, _l in enumerate(io.open(os.path.join(_r, _f),
                                            encoding="utf-8").read().split("\n"), 1):
                for _m in re.finditer(r"\\label\{([^}]+)\}", _l):
                    _lab.add(_m.group(1))
                # org-latex-prefer-user-labels étant à t, un #+NAME: posé sur un
                # flottant produit son \label sans qu'on ait à l'écrire. Le
                # compter comme étiquette — ne pas le faire ferait passer pour
                # orphelin tout renvoi vers une table nommée à l'org.
                _m = re.match(r"^#\+NAME:\s*(\S+)\s*$", _l)
                if _m:
                    _lab.add(_m.group(1))
                for _m in re.finditer(r"\\(?:eq)?ref\{([^}]+)\}", _l):
                    _ref.setdefault(_m.group(1), []).append("%s l.%d" % (_f, _n))
    _orph = sorted(k for k in _ref if k not in _lab)
    if _orph:
        ko("%d renvoi(s) sans étiquette : %s" % (len(_orph), _orph[:6]))
        for _k in _orph[:6]:
            print("        \\ref{%s} — %s" % (_k, ", ".join(_ref[_k][:3])))
    else:
        ok("%d étiquettes, %d renvois distincts, tous résolus"
           % (len(_lab), len(_ref)))

def renvois_vers_un_bloc_export(ctx):
    """Renvois vers un bloc export."""
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
    # ── tout renvoi interne aboutit à une étiquette réelle ──────────────────
    # Org n'attache ni légende ni étiquette à un bloc #+BEGIN_EXPORT. Un
    # « #+NAME: eq:x » posé sur un tel bloc ne produit donc aucun \label, et
    # tout renvoi vers lui s'imprime « ?? ». Deux cas se lisaient ainsi aux
    # pages 232 et 241.
    print("\n[Renvois vers un bloc export]")
    _src = ""
    for _r, _, _fs in os.walk(os.path.join(BASE, "src")):
        for _f in sorted(_fs):
            if _f.endswith(".org"):
                _src += io.open(os.path.join(_r, _f), encoding="utf-8").read()
    _labels = set(re.findall(r"\\label\{([^}]+)\}", _src))
    _pendants = []
    for _cle in set(re.findall(r"\\ref\{([^}]+)\}", _src)) \
            | set(re.findall(r"\[\[([\w:-]+)\]\]", _src)):
        if _cle.startswith(("http", "file:", "./", "sec:")):
            continue
        if _cle in _labels:
            continue
        # sinon il faut un #+NAME: porté par un flottant, non par un bloc export
        _m = re.search(r"#\+NAME:\s*%s\s*\n(#\+[^\n]*\n)*?#\+BEGIN_EXPORT"
                       % re.escape(_cle), _src)
        if _m or not re.search(r"#\+NAME:\s*%s\s*$" % re.escape(_cle),
                               _src, re.M):
            _pendants.append(_cle)
    if _pendants:
        ko("%d renvoi(s) sans étiquette atteignable : %s"
           % (len(_pendants), sorted(_pendants)[:6]))
    else:
        ok("tout renvoi interne aboutit à une étiquette réelle")

def pagination(ctx):
    """Pagination."""
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
    # ── pagination du corps, hors annexes ──────────────────────────────────
    # La borne des annexes était la section « * ANNEXES ». main.org a été
    # restructuré : les annexes sont incluses directement sous \appendix, sans
    # section enveloppe. L'ancre est donc la commande LaTeX, qui est le seul
    # marqueur que les deux formes ont en commun.
    ia = corps.index("#+LATEX: \\appendix")
    c = "\n".join(l for l in corps[:ia].split("\n") if not l.startswith("#"))
    c = re.sub(r'\\label\{[^}]*\}|\\ref\{[^}]*\}|#\+[A-Za-z_+]+:.*', '', c)
    c = re.sub(r'\\[a-zA-Z]+\*?(\[[^\]]*\])?(\{[^}]*\})?', '', c)
    print("\n[Pagination]  corps hors annexes : %.1f pages" % (len(c) / 3800.0))

