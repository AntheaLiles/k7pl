# -*- coding: utf-8 -*-
"""Sigles, glossaire et table des glyphes."""
import io, os, re, sys, json, unicodedata, glob
from collections import Counter

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

from controles.journal import ko, ok
from controle import norm_texte, CITE, SPEC, CHANT, THEO

def sigles_et_glossaire(ctx):
    """Sigles et glossaire."""
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
    # ── tout sigle employé en prose est déclaré au glossaire ────────────────
    # Ajouté le 8 septembre. « Tous les acronymes du document doivent figurer
    # au glossaire » : le contrôle le tient dans la durée plutôt qu'une fois.
    # Un sigle nouveau introduit demain échouera ici tant qu'il n'aura pas reçu
    # son développement, ou tant qu'il n'aura pas été rangé parmi les noms
    # propres que le glossaire écarte en le disant.
    print("\n[Sigles et glossaire]")
    _glo = os.path.join(BASE, "src", "K7PL-glossary.org")
    if not os.path.exists(_glo):
        ko("src/K7PL-glossary.org est introuvable")
    else:
        _G = io.open(_glo, encoding="utf-8").read()
        _decl = set()
        _m = re.search(r"^\* Acronyms\n(.*?)(?=^\* Index)", _G, re.S | re.M)
        for _l in (_m.group(1).split("\n") if _m else []):
            _mm = re.match(r"^- (.+?),? :: ", _l)
            if _mm:
                _decl.add(_mm.group(1).rstrip(",").strip())
        # Les exclusions sont celles que le glossaire nomme dans son commentaire
        # final : noms propres, et segments des codes d'erreur.
        _queue = _G[_G.index("# Ne figurent pas"):] if "# Ne figurent pas" in _G else ""
        _excl = set(re.findall(r"\b([A-Z][A-Za-z0-9]{1,11})\b", _queue))
        _MOTS = re.compile(
            r"^(LA|LE|LES|ET|DE|DU|UN|UNE|EN|NE|SI|CAS|PAR|SANS|DES|RIEN|TYPES|USAGE|"
            r"OBJET|DEVENU|SECONDE|CONTEXTE|FORMELLE|SOURCE|NOTE|DESC|FAIRE|MISE|"
            r"PRATIQUE|SYNTAXE|CODES|ERREUR|DOCUMENT|AUTEUR|ACCORD|MODIFIER|PIERRE|"
            r"II|III|IV|VI|VII|VIII|IX|XI|XII|ERR|OneE|VecE|SubBox|Sub|Sc|Op|App|Box|"
            r"Unbox|PhaseImport4|OCaml|GitHub|JavaScript|Gerbil|Zig|Rust|Arrow|Yoneda|"
            r"Kleisli|Int)$")
        _inconnus = {}
        for _r, _, _fs in os.walk(os.path.join(BASE, "src")):
            for _f in sorted(_fs):
                if not _f.endswith(".org") or "glossary" in _f:
                    continue
                _p = io.open(os.path.join(_r, _f), encoding="utf-8").read()
                _p = re.sub(r"(?s)#\+BEGIN_(SRC|EXPORT|EXAMPLE).*?#\+END_\1", "",
                            _p, flags=re.I)
                _p = "\n".join(_x for _x in _p.split("\n")
                               if not _x.startswith(("#+", "#", "*", "|", ":")))
                _p = re.sub(r"\\[A-Za-z@]+\*?|\[cite:[^\]]*\]|~[^~\n]+~", "", _p)
                _p = re.sub(r"\\\(.*?\\\)|\$[^$]*\$", "", _p, flags=re.S)
                # SPIR-V, UTF-8 : le sigle porte son tiret, il faut le garder
                for _mm in re.finditer(
                        r"\b([A-Z][A-Za-z0-9]*[A-Z][A-Za-z0-9]*(?:-[A-Z0-9]+)?"
                        r"|[A-Z]{2,}(?:-[A-Z0-9]+)?)\b", _p):
                    _a = _mm.group(1)
                    if _MOTS.match(_a) or _a in _decl or _a in _excl:
                        continue
                    if _a.split("-")[0] in _excl:
                        continue
                    # ERR-XXX : segment d'un code d'erreur, dont l'entrée
                    # « code d'erreur » du glossaire donne la forme.
                    if _a.startswith("ERR-"):
                        continue
                    _inconnus.setdefault(_a, 0)
                    _inconnus[_a] += 1
        if _inconnus:
            ko("%d sigle(s) employé(s) en prose sans être déclaré(s) au "
               "glossaire ni écarté(s) : %s"
               % (len(_inconnus), sorted(_inconnus)[:8]))
        else:
            ok("%d sigles déclarés, tout sigle employé en prose est couvert"
               % len(_decl))

def table_des_glyphes(ctx):
    """Table des glyphes."""
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
    # ── bijection glyphe ↔ alias ───────────────────────────────────────────
    # Q24, 10 août. La quatrième règle d'admission de TXR — « toutes les
    # combinaisons ne se rendent pas par la notation » — est SANS OBJET pour
    # K7PL, parce que notre notation est un RENOMMAGE et non un sucre : elle ne
    # change pas l'arbre, donc elle n'a pas de cas exclus. Ce qui la remplace
    # est la condition qui rend cette phrase vraie : la correspondance doit
    # être une BIJECTION. Deux macros ne partagent pas un glyphe ; une macro
    # n'a pas deux glyphes.
    print("\n[Table des glyphes]")
    # C2, 3 septembre : la table porte désormais une colonne POINT DE CODE
    # entre le glyphe et l'alias. Le point de code est la forme normative ;
    # il est donc contrôlé, et non seulement toléré.
    lignes = re.findall(r"^\| ~(\S+)~ \| ~((?:U\+[0-9A-F]{4} ?)+)~ \| ~([\w\-]+)~ \|", corps, re.M)
    if not lignes:
        ko("table des glyphes introuvable")
    else:
        gl = [a for a, _, _ in lignes]
        cp = [b for _, b, _ in lignes]
        al = [c for _, _, c in lignes]
        faux = [(g, c) for g, c in zip(gl, cp)
                if c != " ".join("U+%04X" % ord(ch) for ch in g)]
        ko("point de code faux : %s" % faux) if faux else \
            ok("%d points de code, chacun conforme à son glyphe (arbitrage 15)" % len(cp))
        dg = sorted({x for x in gl if gl.count(x) > 1})
        da = sorted({x for x in al if al.count(x) > 1})
        ko("glyphes en double : %s" % dg) if dg else None
        ko("alias en double : %s" % da) if da else None
        if not dg and not da:
            ok("%d glyphes, bijection glyphe ↔ alias (Q24, règle 4)" % len(gl))

    # ── croisement des DEUX tables de glyphes ──────────────────────────────
    # C8-C9, 3 septembre. L'inventaire du temps 4 de l'arc G portait sur les
    # NOMS et déclarait les glyphes hors périmètre ; conséquence, les deux
    # tables de glyphes n'avaient jamais été croisées l'une contre l'autre.
    # Le croisement rend trois coexistences, dont deux étaient inconnues.
    # Une coexistence n'est pas une faute si les contextes se séparent, mais
    # elle doit être DÉCLARÉE dans l'annexe. Ce contrôle vérifie la déclaration,
    # non l'absence : il échoue sur un partage que l'annexe passe sous silence.
    rexp = re.findall(r"^\|\s*[\wÀ-ÿ ]+\s*\| ~(\S+)~\s+\|", corps, re.M)
    partages = sorted({g for g in gl if g in rexp})
    if partages:
        nondit = [g for g in partages if ("~%s~" % g) not in corps.split("Trois signes de ce document")[-1][:2000]]
        ko("glyphes partagés entre les deux tables et non déclarés : %s" % nondit) if nondit else \
            ok("%d glyphe(s) partagé(s) entre les deux tables, déclaré(s) dans l'annexe : %s"
               % (len(partages), " ".join(partages)))
    else:
        ok("aucun glyphe partagé entre les deux tables")

    # ── cinquième règle d'admission, instrumentée ──────────────────────────
    # QG-16, 3 septembre. La règle « aucun couple de glyphes ne se ressemble à
    # l'œil » était un jugement humain. UTS #39 en donne l'instrument : deux
    # caractères sont confusables si et seulement si leur SQUELETTE coïncide,
    # et le squelette se calcule sur une donnée normative et versionnée.
    # Le contrôle fait deux choses que la règle écrite ne faisait pas :
    #   1. il vérifie que deux glyphes du jeu ne partagent pas un squelette ;
    #   2. il vérifie que tout glyphe confusable HORS du jeu est DÉCLARÉ.
    # Le second point est le vrai apport : la règle regardait à l'intérieur du
    # jeu, et le danger est à l'extérieur — × se confond avec x, ∨ avec v, et
    # ces deux cibles sont des caractères d'identifiant légaux.
    import json as _json
    cf = os.path.join(BASE, "bib", "confusables-glyphes.json")
    if not os.path.exists(cf):
        ko("données de confusabilité absentes — cinquième règle non instrumentée")
    else:
        cd = _json.load(io.open(cf, encoding="utf-8"))
        sq, dec = cd["squelettes"], cd["confusables_declares"]
        pts = [" ".join("%04X" % ord(ch) for ch in g) for g in gl]
        inconnus = [p for p in pts if p not in sq]
        par = {}
        for p in pts:
            par.setdefault(sq.get(p, p), []).append(p)
        collision = {k: v for k, v in par.items() if len(v) > 1}
        sortants = [p for p in pts if sq.get(p, p) != p]
        nondeclares = [p for p in sortants if p not in dec]
        if inconnus:
            ko("glyphes sans squelette relevé : %s — réextraire confusables.txt" % inconnus)
        elif collision:
            ko("deux glyphes partagent un squelette UTS #39 : %s" % collision)
        elif nondeclares:
            ko("glyphes confusables hors du jeu et NON déclarés : %s" % nondeclares)
        else:
            hauts = [p for p in sortants if dec[p].get("gravite") == "haute"]
            ok("cinquième règle : 0 collision interne, %d confusable(s) sortant(s) "
               "déclaré(s) dont %d de gravité haute (UTS #39 v%s)"
               % (len(sortants), len(hauts), cd["_provenance"]["version"]))

