# -*- coding: utf-8 -*-
"""Hygiène de la source org : blocs, piles de mots-clés, liens."""
import io, os, re, sys, json, unicodedata, glob
from collections import Counter

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

from controles.journal import ko, ok
from controle import norm_texte, CITE, SPEC, CHANT, THEO

def marqueurs_de_bloc_export(ctx):
    """Marqueurs de bloc export."""
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
    # ── un marqueur de bloc export est seul sur sa ligne ────────────────────
    # Ajouté le 7 septembre, après avoir lu « #+END_EXPORT La dette qu'il
    # reste à acquitter… » imprimé tel quel en page 149. Org ne reconnaît un
    # #+BEGIN_EXPORT ou un #+END_EXPORT que seul sur sa ligne ; suivi de texte,
    # il devient du texte, et le bloc ne se ferme pas.
    print("\n[Marqueurs de bloc export]")
    _colles = []
    for _r, _, _fs in os.walk(os.path.join(BASE, "src")):
        for _f in sorted(_fs):
            if not _f.endswith(".org"):
                continue
            for _n, _l in enumerate(io.open(os.path.join(_r, _f),
                                            encoding="utf-8"), start=1):
                _s = _l.rstrip("\n")
                if re.search(r"#\+(BEGIN|END)_EXPORT", _s, re.I):
                    _propre = (re.match(r"^\s*#\+BEGIN_EXPORT\s+\w+\s*$", _s, re.I)
                               or re.match(r"^\s*#\+END_EXPORT\s*$", _s, re.I))
                    if not _propre:
                        _colles.append("%s l.%d" % (_f, _n))
    if _colles:
        ko("%d marqueur(s) de bloc export accompagné(s) de texte sur leur "
           "ligne : %s" % (len(_colles), _colles[:6]))
    else:
        ok("tout #+BEGIN_EXPORT et tout #+END_EXPORT est seul sur sa ligne")

def citations_hors_des_blocs_export(ctx):
    """Citations hors des blocs export."""
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
    # ── aucune citation dans un bloc export ─────────────────────────────────
    # Ajouté le 7 septembre, après lecture de la page 73 du PDF, où l'on lit
    # « [cite:@dilavoreMonoidalStreamsDataflow2022] » en toutes lettres au
    # milieu d'une esquisse de preuve. Org ne traite pas org-cite à l'intérieur
    # d'un #+BEGIN_EXPORT latex : la clé traverse l'export sans être résolue et
    # s'imprime telle quelle. Ce n'est donc pas seulement une mauvaise pratique
    # de rédaction — les sources doivent se citer dans la prose qui porte le
    # théorème, non dans sa preuve — c'est une sortie fausse.
    print("\n[Citations hors des blocs export]")
    _piegees = {}
    for _r, _, _fs in os.walk(os.path.join(BASE, "src")):
        for _f in sorted(_fs):
            if not _f.endswith(".org"):
                continue
            _dans, _n = False, 0
            for _l in io.open(os.path.join(_r, _f), encoding="utf-8"):
                _s = _l.strip().lower()
                if _s.startswith("#+begin_export"):
                    _dans = True
                    continue
                if _s.startswith("#+end_export"):
                    _dans = False
                    continue
                if _dans:
                    _n += len(re.findall(r"\[cite[:/@]", _l))
            if _n:
                _piegees[_f] = _n
    if _piegees:
        ko("%d citation(s) piégée(s) dans un bloc export, elles s'impriment "
           "telles quelles : %s"
           % (sum(_piegees.values()),
              ", ".join("%s %d" % _kv for _kv in sorted(_piegees.items()))))
    else:
        ok("aucune citation prisonnière d'un bloc export")

def pile_de_mots_cles_affilies(ctx):
    """Pile de mots-clés affiliés."""
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
    # ── intégrité de la pile de mots-clés affiliés ──────────────────────────
    # Ajouté le 8 septembre, après lecture de la page 80 du PDF, où la table
    # 3.1 s'imprimait sans légende et où son renvoi remontait au titre de
    # sous-section. La cause était une ligne « #+LATEX: \label{...} » glissée
    # entre #+NAME: et #+ATTR_LATEX:. Un mot-clé qui n'est pas affilié rompt
    # la pile : la légende et l'étiquette cessent de s'attacher au flottant,
    # celui-ci perd son numéro, et le \label émis en cours de texte capte le
    # dernier compteur incrémenté — le titre de section.
    print("\n[Pile de mots-clés affiliés]")
    _AFFILIES = ("#+CAPTION", "#+NAME", "#+ATTR_", "#+HEADER", "#+RESULTS",
                 "#+PLOT", "#+DESC:", "#+NOTE:", "#+SOURCE:", "#+ALT_TEXT:")
    _rompues = []
    for _r, _, _fs in os.walk(os.path.join(BASE, "src")):
        for _f in sorted(_fs):
            if not _f.endswith(".org"):
                continue
            _L = io.open(os.path.join(_r, _f), encoding="utf-8").read().split("\n")
            for _i, _l in enumerate(_L):
                if not _l.upper().startswith(_AFFILIES):
                    continue
                _j = _i + 1
                while _j < len(_L) and _L[_j].startswith("#+"):
                    if not _L[_j].upper().startswith(_AFFILIES) \
                       and not _L[_j].upper().startswith("#+BEGIN"):
                        if _j + 1 < len(_L) and _L[_j + 1].upper().startswith(_AFFILIES):
                            _rompues.append("%s l.%d : %s"
                                            % (_f, _j + 1, _L[_j][:46]))
                        break
                    _j += 1
    if _rompues:
        ko("%d pile(s) de mots-clés rompue(s) par un mot-clé non affilié : %s"
           % (len(_rompues), _rompues[:4]))
    else:
        ok("aucun mot-clé non affilié inséré dans une pile de mots-clés")

def liens_de_fichier_avant_et_apres_inclusion(ctx):
    """Liens de fichier, avant et après inclusion."""
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
    # ── les liens de fichier survivent-ils à l'inclusion ? ─────────────────
    # Ajouté le 4 septembre, et c'est LA panne d'export, trouvée par la trace
    # d'Anthea. Les douze liens de figure vivaient dans src/chapitres/ et
    # écrivaient « ../meta/ », qui désigne src/meta/ — un dossier inexistant.
    #
    # DEUX CONDITIONS, ET LA SECONDE EST CELLE QU'ON NE DEVINE PAS.
    # Org réécrit les chemins relatifs d'un fichier INCLUS pour les rendre
    # relatifs au fichier QUI INCLUT. « src/chapitres/../meta/x » devient donc
    # « meta/x » vu de src/ — et « meta/x » ne commence plus par « ./ » ni
    # « ../ ». Or c'est exactement à ce signe qu'org reconnaît un lien de
    # FICHIER. Sans lui, le lien bascule en type « fuzzy », org cherche une
    # cible NOMMÉE de ce nom, n'en trouve pas, et AVORTE l'export entier.
    # Un lien peut donc désigner un fichier qui existe et casser quand même.
    print("\n[Liens de fichier, avant et après inclusion]")
    _racine = os.path.join(BASE, "src")
    _casses = []
    for _r, _, _fs in os.walk(_racine):
        for _f in sorted(_fs):
            if not _f.endswith(".org"):
                continue
            _p = os.path.join(_r, _f)
            _t = io.open(_p, encoding="utf-8").read()
            for _m in re.finditer(r"\[\[([^\]]+\.(?:drawio|pdf|png|jpg|svg))\]\]", _t):
                _lien = _m.group(1)
                _abs = os.path.normpath(os.path.join(os.path.dirname(_p), _lien))
                if not os.path.exists(_abs):
                    _casses.append("%s : %s ne désigne aucun fichier depuis %s"
                                   % (_f, _lien, os.path.relpath(os.path.dirname(_p), BASE)))
                    continue
                _re = os.path.relpath(_abs, _racine)
                if not _re.startswith(("./", "../")):
                    _casses.append("%s : %s devient « %s » à l'inclusion, "
                                   "donc un lien fuzzy et non un fichier"
                                   % (_f, _lien, _re))
    if _casses:
        ko("%d lien(s) de fichier casseraient l'export" % len(_casses))
        for _c in _casses[:8]:
            print("        " + _c)
    else:
        ok("tous les liens de fichier existent et restent des liens de fichier "
           "après réécriture d'inclusion")

def toc_locales_et_bibliographies_par_partie(ctx):
    """TOC locales et bibliographies par partie."""
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
    # ── chaque partie ouvre sa TOC locale et ferme sa bibliographie ──────────
    # Ajouté le 7 septembre, après avoir constaté que c1 avait gardé un
    # bricolage LaTeX manuel là où les onze autres avaient la directive org,
    # et surtout que main.org avait PERDU l'inclusion de c1 et la TOC générale.
    print("\n[TOC locales et bibliographies par partie]")
    _parties = ["chapitres/c%d-%s.org" % (_n, _s) for _n, _s in [
        (1, "prolegomenes"), (2, "fondements"), (3, "types"), (4, "automates"),
        (5, "syntaxe"), (6, "compilation"), (7, "integration")]] + [
        "K7_Errors.org", "K7_LSP_REPL.org", "K7_Sushi.org",
        "K7_Sugoi.org", "K7_Semantique.org"]
    _main = io.open(os.path.join(BASE, "src", "main.org"), encoding="utf-8").read()
    _horsplan, _sanstoc, _biblio = [], [], []
    for _rel in _parties:
        _p = os.path.join(BASE, "src", _rel)
        if os.path.basename(_rel) not in _main and _rel not in _main:
            _horsplan.append(_rel)
        _t = io.open(_p, encoding="utf-8").read()
        if not re.search(r"^#\+TOC: headlines \d+ local\s*$", _t, re.M):
            _sanstoc.append(_rel)
        _cites = len(re.findall(r"\[cite[:/@]", _t))
        _sub = "#+print_bibliography: :heading subbibliography" in _t
        if _cites and not _sub:
            _biblio.append("%s cite %d fois sans sous-bibliographie" % (_rel, _cites))
        if _sub and not _cites:
            _biblio.append("%s a une sous-bibliographie sans rien citer" % _rel)
    if _horsplan:
        ko("%d partie(s) absente(s) de main.org : %s" % (len(_horsplan), _horsplan))
    else:
        ok("les 12 parties sont inclues par main.org")
    if not re.search(r"^#\+TOC: headlines 1\s*$", _main, re.M):
        ko("main.org n'a plus sa table des matières générale (#+TOC: headlines 1)")
    else:
        ok("main.org porte sa table des matières générale")
    if _sanstoc:
        ko("%d partie(s) sans TOC locale : %s" % (len(_sanstoc), _sanstoc))
    else:
        ok("les 12 parties ouvrent leur TOC locale")
    if _biblio:
        ko("sous-bibliographies mal appariées : %s" % _biblio)
    else:
        ok("toute partie qui cite ferme sur sa sous-bibliographie, et elle seule")




# ── hygiène de la source org ──────────────────────────────────────────────────
# Repris de outils/audit_org.py le 8 septembre. C'était un outil séparé, donc
# facultatif, donc oublié — alors que ce qu'il attrape casse l'export au lieu de
# le dégrader : un bloc jamais fermé, un tiroir ouvert, une emphase impaire.
# Il devient une section du contrôle, lancée avec les autres.
#
# Le fichier d'origine était un SCRIPT : son corps s'exécutait à l'import. Il
# fallait donc l'envelopper, non l'importer — c'est ce qui suit.

BLOQUANT = ["BLOC JAMAIS FERMÉ", "TIROIR JAMAIS FERMÉ",
            "ENVIRONNEMENT LATEX JAMAIS FERMÉ", "blocs entrelacés",
            "environnements LaTeX entrelacés", "bloc fermé sans ouverture",
            ":END: sans tiroir", "\\end sans \\begin"]


def _auditer_source():
    """Rend le dictionnaire des anomalies relevées dans src/, par genre."""
    import collections
    FICHIERS = []
    for r, _, fs in os.walk(os.path.join(BASE, "src")):
        for f in sorted(fs):
            if f.endswith(".org"):
                FICHIERS.append(os.path.join(r, f))
    FICHIERS.sort()

    anomalies = collections.defaultdict(list)
    def sig(f, n, genre, txt):
        anomalies[genre].append((f, n, txt))

    for chemin in FICHIERS:
        rel = os.path.relpath(chemin, BASE)
        L = io.open(chemin, encoding="utf-8").read().split("\n")

        # ── 1. blocs #+BEGIN_ / #+END_ ────────────────────────────────────────
        pile = []
        for i, l in enumerate(L, 1):
            m = re.match(r"^\s*#\+(?:BEGIN|begin)_(\w+)", l)
            if m:
                pile.append((m.group(1).lower(), i))
            m = re.match(r"^\s*#\+(?:END|end)_(\w+)", l)
            if m:
                nom = m.group(1).lower()
                if not pile:
                    sig(rel, i, "bloc fermé sans ouverture", "#+END_%s" % nom)
                elif pile[-1][0] != nom:
                    sig(rel, i, "blocs entrelacés",
                        "#+END_%s ferme #+BEGIN_%s ouvert l.%d" % (nom, pile[-1][0], pile[-1][1]))
                    pile.pop()
                else:
                    pile.pop()
        for nom, i in pile:
            sig(rel, i, "BLOC JAMAIS FERMÉ", "#+BEGIN_%s" % nom)

        # ── 2. tiroirs :PROPERTIES: ... :END: ─────────────────────────────────
        ouvert = None
        for i, l in enumerate(L, 1):
            s = l.strip()
            if re.match(r"^:(PROPERTIES|LOGBOOK|RESULTS):\s*$", s, re.I):
                if ouvert:
                    sig(rel, i, "TIROIR JAMAIS FERMÉ", "ouvert l.%d, réouvert ici" % ouvert)
                ouvert = i
            elif s == ":END:":
                if not ouvert:
                    sig(rel, i, ":END: sans tiroir", ":END:")
                ouvert = None
            elif ouvert and re.match(r"^\*+ ", l):
                sig(rel, ouvert, "TIROIR JAMAIS FERMÉ",
                    "titre rencontré l.%d avant :END:" % i)
                ouvert = None
        if ouvert:
            sig(rel, ouvert, "TIROIR JAMAIS FERMÉ", "fin de fichier atteinte")

        # ── 3. environnements LaTeX ───────────────────────────────────────────
        pile = []
        for i, l in enumerate(L, 1):
            # Les COMMENTAIRES org ne sont pas exportés : ce qu'ils citent ne compte
            # pas. Sans cette ligne, l'auditeur se signale ses propres commentaires,
            # ce qui est arrivé le 4 septembre sur bibliographie.org.
            if l.lstrip().startswith("#") and not l.lstrip().startswith("#+"):
                continue
            for m in re.finditer(r"\\(begin|end)\{([^}]+)\}", l):
                quoi, nom = m.group(1), m.group(2)
                if quoi == "begin":
                    pile.append((nom, i))
                else:
                    if not pile:
                        sig(rel, i, "\\end sans \\begin", "\\end{%s}" % nom)
                    elif pile[-1][0] != nom:
                        sig(rel, i, "environnements LaTeX entrelacés",
                            "\\end{%s} ferme \\begin{%s} de l.%d" % (nom, pile[-1][0], pile[-1][1]))
                        pile.pop()
                    else:
                        pile.pop()
        for nom, i in pile:
            sig(rel, i, "ENVIRONNEMENT LATEX JAMAIS FERMÉ", "\\begin{%s}" % nom)

        # ── 4. maths : $...$ et \[...\] ───────────────────────────────────────
        dans_bloc = False
        for i, l in enumerate(L, 1):
            if re.match(r"^\s*#\+(BEGIN|END)_", l, re.I):
                dans_bloc = not dans_bloc if l.upper().strip().startswith("#+BEGIN") else False
            # $ non appariés hors $$
            sans = re.sub(r"\\\$", "", l)
            sans = re.sub(r"\$\$", "", sans)
            if sans.count("$") % 2:
                sig(rel, i, "dollar math non apparié", l.strip()[:100])
        ouv = sum(l.count(r"\[") for l in L)
        fer = sum(l.count(r"\]") for l in L)
        if ouv != fer:
            sig(rel, 0, "\\[ et \\] en nombres inégaux", "%d ouvertures, %d fermetures" % (ouv, fer))

        # ── 5. accolades LaTeX, sur le fichier entier ─────────────────────────
        t = "\n".join(L)
        t2 = re.sub(r"\\[{}]", "", t)
        if t2.count("{") != t2.count("}"):
            sig(rel, 0, "accolades déséquilibrées",
                "%d ouvrantes, %d fermantes" % (t2.count("{"), t2.count("}")))

        # ── 6. tables ─────────────────────────────────────────────────────────
        for i, l in enumerate(L, 1):
            s = l.strip()
            if s.startswith("|") and not s.startswith("|-") and not s.endswith("|"):
                sig(rel, i, "ligne de table non terminée par |", s[:100])

        # ── 7. emphase : marqueurs impairs sur une ligne ──────────────────────
        #    Org exige que l'emphase se ferme sur la MÊME ligne ou le même
        #    paragraphe. Un marqueur seul ne boucle pas, mais il produit une
        #    sortie fausse et masque parfois un vrai déséquilibre.
        for i, l in enumerate(L, 1):
            if re.match(r"^\s*[#|]", l) or re.match(r"^\s*:\w+:", l):
                continue
            for marq, nom in [("*", "gras"), ("/", "italique"), ("_", "souligné"),
                              ("=", "verbatim"), ("~", "code")]:
                # on ne compte que les marqueurs en position d'emphase org
                n = len(re.findall(
                    r"(?:^|[\s\-(\['\"{])%s(?=[^\s%s])" % (re.escape(marq), re.escape(marq)), l))
                n += len(re.findall(
                    r"(?<=[^\s%s])%s(?=$|[\s\-.,:;!?')\]}\"])" % (re.escape(marq), re.escape(marq)), l))
                if n % 2:
                    sig(rel, i, "emphase %s impaire" % nom, l.strip()[:110])


    BLOQUANT = ["BLOC JAMAIS FERMÉ", "TIROIR JAMAIS FERMÉ",
                "ENVIRONNEMENT LATEX JAMAIS FERMÉ", "blocs entrelacés",
                "environnements LaTeX entrelacés", "bloc fermé sans ouverture",
                ":END: sans tiroir", "\\end sans \\begin"]



    return anomalies


def hygiene_org(ctx):
    """Blocs non fermés, tiroirs ouverts, emphase impaire — ce qui casse l'export."""
    print("\n[Hygiène de la source org]")
    anomalies = _auditer_source()
    bloquantes = [g for g in BLOQUANT if anomalies.get(g)]
    for g in bloquantes:
        for f, n, txt in anomalies[g][:4]:
            ko("%s — %s l.%s %s" % (g, f, n, txt))
    autres = sum(len(anomalies[g]) for g in anomalies if g not in BLOQUANT)
    if bloquantes:
        ko("%d genre(s) d'anomalie bloquante pour l'export" % len(bloquantes))
    else:
        ok("aucune anomalie bloquante pour l'export (%d anomalies de forme)" % autres)


# ── les mots-clés personnels sont en tête de pile ─────────────────────────────
# Ajouté le 8 septembre, après que les douze figures ont perdu leurs légendes à
# l'export. Org n'attache à un élément que les mots-clés affiliés qui le
# précèdent SANS INTERRUPTION. #+DESC:, #+NOTE:, #+SOURCE: et #+ALT_TEXT: n'en
# sont pas : posés au milieu ou en fin de pile, ils coupent la chaîne, et
# #+CAPTION: comme #+NAME: cessent de s'attacher. La figure perd alors sa
# légende, son numéro et son étiquette — c'est le défaut de la table 3.1,
# reproduit douze fois.
#
# Posés en tête, ils ne coupent rien, et le document se compose correctement
# MÊME SANS le filtre : sans les items, mais avec ses légendes. C'est la
# dégradation qu'on veut d'une source qui dépend d'un outil.

PERSO = ("#+DESC:", "#+NOTE:", "#+SOURCE:", "#+ALT_TEXT:")


def mots_cles_personnels_en_tete(ctx):
    """Un #+DESC:, #+NOTE:, #+SOURCE: ou #+ALT_TEXT: doit ouvrir sa pile."""
    print("\n[Mots-clés personnels en tête de pile]")
    fautives = []
    for r, _, fs in os.walk(os.path.join(BASE, "src")):
        for f in sorted(fs):
            if not f.endswith(".org") or "glossary" in f:
                continue
            L = io.open(os.path.join(r, f), encoding="utf-8").read().split("\n")
            i = 0
            while i < len(L):
                if not L[i].startswith("#+"):
                    i += 1
                    continue
                j = i
                while (j < len(L) and L[j].startswith("#+")
                       and not re.match(r"^#\+BEGIN_", L[j], re.I)):
                    j += 1
                run = L[i:j]
                vu_standard = False
                for k, x in enumerate(run):
                    if x.upper().startswith(PERSO):
                        if vu_standard:
                            fautives.append("%s l.%d : %s" % (f, i + k + 1, x[:40]))
                            break
                    else:
                        vu_standard = True
                i = j if j > i else i + 1
    if fautives:
        ko("%d mot(s)-clé(s) personnel(s) hors tête de pile — la légende s'y "
           "détache : %s" % (len(fautives), fautives[:4]))
    else:
        ok("tout #+DESC:, #+NOTE:, #+SOURCE: et #+ALT_TEXT: ouvre sa pile")
