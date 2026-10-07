# -*- coding: utf-8 -*-
"""Sondes de sens, croisement grammaire/règles, vocabulaire."""
import io, os, re, sys, json, unicodedata, glob
from collections import Counter

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

from controles.journal import ko, ok
from controle import norm_texte, CITE, SPEC, CHANT, THEO

def sondes_semantiques(ctx):
    """Sondes semantiques."""
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
    # ── sondes sémantiques ─────────────────────────────────────────────────
    print("\n[Sondes semantiques]")
    S = json.load(io.open(os.path.join(BASE, "bib", "sondes.json"), encoding="utf-8"))
    fen = S.get("_fenetre", 700)
    plat = norm_texte(corps)
    reussies = 0
    for s in S["sondes"]:
        i = plat.find(norm_texte(s["passage"]))
        if i < 0:
            ko("sonde non ancrée (passage disparu ou reformulé) : « %s »" % s["passage"])
            continue
        m = re.search(r'\[cite:@([a-z0-9_.:+\-]+)\]', plat[i:i + fen])
        # le corps est cherché sous forme normalisée, donc en bas de casse :
        # la clé Zotero est en casse mixte, la comparaison l'ignore.
        got = m.group(1) if m else None
        if got is not None and got == s["cle"].lower():
            reussies += 1
        else:
            ko("sonde mal attribuée : « %s » attendu %s, obtenu %s" % (s["passage"], s["cle"], got))
    print("    resultat : %d/%d" % (reussies, len(S["sondes"])))

def croisement_g_2_g_3(ctx):
    """Croisement G.2 / G.3."""
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
    # ── croisement grammaire / règles ──────────────────────────────────────
    # Ajouté le 28 août. Trois objets devraient coïncider — la liste des primitives,
    # la grammaire des termes, le jeu de règles — et rien ne les comparait. G.2 avait
    # dix-sept constructeurs de retard sur G.3, sans qu'aucun contrôle le voie.
    print("\n[Croisement G.2 / G.3]")
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    from controles.croise import verifier as _croise
    _ok, _msg = _croise(t)
    for _l in _msg:
        (ok if _ok else ko)(_l) if not _l.startswith("   ") else print("        " + _l.strip())

def vocabulaire_de_l_axiome(ctx):
    """Vocabulaire de l'axiome."""
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

    print("\n[Vocabulaire de l'axiome]")
    fautes = [
        (r'\\mid \\mathcal\{C\}',
         "\\mathcal{C} employée comme composante du jugement — elle est répartie"),
        (r'grade \\\(\\mathcal\{G\}\\\)',
         "un grade particulier noté \\mathcal{G} — un grade se note r, \\mathcal{G} est l'algèbre"),
        (r'\\mathcal\{G\} \\ni',
         "\\mathcal{G} traitée comme un contenant de valeurs — c'est une algèbre"),
        (r'(cinq|quatre) composantes du jugement',
         "arité fantôme du jugement — il en porte trois"),
    ]
    for motif, msg in fautes:
        vus = re.findall(motif, corps)
        ko("%s (%d occurrence(s))" % (msg, len(vus))) if vus else None
    if not any(re.findall(m, corps) for m, _ in fautes):
        ok("\\mathcal{G} est l'algèbre, \\mathcal{C} est répartie, le jugement porte trois composantes")

