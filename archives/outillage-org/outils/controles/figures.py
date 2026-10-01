# -*- coding: utf-8 -*-
"""Flottants : tables, légendes, textes de remplacement."""
import io, os, re, sys, json, unicodedata, glob
from collections import Counter

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

from controles.journal import ko, ok
from controle import norm_texte, CITE, SPEC, CHANT, THEO

def tables_bornees_a_la_largeur_d_impression(ctx):
    """Tables bornées à la largeur d'impression."""
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
    # ── toute table est bornée à la largeur d'impression ───────────────────
    # Ajouté le 4 septembre, après la mesure du PDF : vingt et une pages
    # laissaient 439 mots HORS DE LA FEUILLE, tous dans des tables. Une table
    # org sans attribut sort en « tabular » nu, qui prend la largeur que son
    # contenu demande, sans borne. Les trois attributs sont solidaires :
    # sans :width org écrit \begin{tabularx}{lll}, qui est malformé ; sans une
    # colonne X dans :align, tabularx n'a rien pour absorber la largeur.
    print("\n[Tables bornées à la largeur d'impression]")
    _sansattr, _sanscap = [], []
    for _r, _, _fs in os.walk(os.path.join(BASE, "src")):
        for _f in sorted(_fs):
            if not _f.endswith(".org"):
                continue
            _L = io.open(os.path.join(_r, _f), encoding="utf-8").read().split("\n")
            _i = 0
            while _i < len(_L):
                if not _L[_i].strip().startswith("|"):
                    _i += 1
                    continue
                _amont = " ".join(_L[max(0, _i - 4):_i])
                if ("tabularx" not in _amont or ":width" not in _amont
                        or not re.search(r":align\s+\S*[XZ]", _amont)):
                    _sansattr.append("%s l.%d" % (_f, _i + 1))
                if "#+CAPTION:" not in " ".join(_L[max(0, _i - 5):_i]):
                    _sanscap.append("%s l.%d" % (_f, _i + 1))
                while _i < len(_L) and _L[_i].strip().startswith("|"):
                    _i += 1
    if _sanscap:
        ko("%d table(s) sans #+CAPTION: — hors de la liste des tableaux : %s"
           % (len(_sanscap), _sanscap[:6]))
    else:
        ok("toute table porte sa légende")
    if _sansattr:
        ko("%d table(s) sans les trois attributs — elles déborderont : %s"
           % (len(_sansattr), _sansattr[:6]))
    else:
        ok("toute table porte :environment tabularx, :width et une colonne souple")

def legendes_et_textes_de_remplacement(ctx):
    """Légendes et textes de remplacement."""
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
    # ── chaque item porte sa légende, chaque figure son texte de remplacement ─
    # Ajouté le 7 septembre. Une figure sans alt= est muette pour un lecteur
    # d'écran, et un flottant sans légende n'entre dans aucune liste.
    # Deux-points interdits dans un alt= : org lit la ligne #+ATTR_LATEX: avec
    # org-babel-parse-header-arguments, qui prendrait « : » pour une clé neuve.
    print("\n[Légendes et textes de remplacement]")
    _sanslegende, _sansalt, _altdeuxpoints, _nbfig, _nbflot = [], [], [], 0, 0
    for _r, _, _fs in os.walk(os.path.join(BASE, "src")):
        for _f in sorted(_fs):
            if not _f.endswith(".org"):
                continue
            _L = io.open(os.path.join(_r, _f), encoding="utf-8").read().split("\n")
            for _i, _l in enumerate(_L):
                _img = re.match(r"\s*\[\[[^\]]*\.(?:drawio|png|pdf|jpg|svg)\]\]\s*$", _l)
                _blc = _l.lower().startswith(("#+begin_src", "#+begin_example"))
                if not (_img or _blc):
                    continue
                _nbflot += 1
                _amont = _L[max(0, _i - 5):_i]
                if not any(_a.startswith("#+CAPTION:") for _a in _amont):
                    _sanslegende.append("%s l.%d" % (_f, _i + 1))
                if _img:
                    _nbfig += 1
                    # Depuis le 8 septembre le texte de remplacement s'écrit
                    # #+ALT_TEXT:, que le filtre replie dans :options alt={}.
                    # L'ancienne forme reste acceptée : c'est la même donnée.
                    _amont7 = _L[max(0, _i - 7):_i]
                    _attr = [_a for _a in _amont7
                             if _a.startswith(("#+ATTR_LATEX:", "#+ALT_TEXT:"))]
                    if not any("alt=" in _a or _a.startswith("#+ALT_TEXT:")
                               for _a in _attr):
                        _sansalt.append("%s l.%d" % (_f, _i + 1))
                    for _a in _attr:
                        _m = re.search(r"alt=\{([^}]*)\}", _a)
                        _v = _m.group(1) if _m else (
                            _a[len("#+ALT_TEXT:"):] if _a.startswith("#+ALT_TEXT:")
                            else None)
                        if _v and re.search(r"(^|\s):\w", _v):
                            _altdeuxpoints.append("%s l.%d" % (_f, _i + 1))
    if _sanslegende:
        ko("%d flottant(s) sans #+CAPTION: : %s" % (len(_sanslegende), _sanslegende[:6]))
    else:
        ok("%d flottants, chacun avec sa légende" % _nbflot)
    if _sansalt:
        ko("%d figure(s) sans alt= : %s" % (len(_sansalt), _sansalt[:6]))
    elif _altdeuxpoints:
        ko("%d alt= contenant un deux-points, qu'org lirait comme une clé : %s"
           % (len(_altdeuxpoints), _altdeuxpoints[:6]))
    else:
        ok("%d figures, chacune avec son texte de remplacement" % _nbfig)

