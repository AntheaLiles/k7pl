# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Notation checks: one symbol per object, status seals, propagation of open statements."""

from __future__ import annotations

import re

import manuscript_metrics as mm

from . import corpus
from .journal import ko, ok

STATUSES = {"theoreme", "proposition", "conjecture", "definition", "exigence", "litterature"}
LEVELS = {"langage", "compilation", "representation", "deploiement"}


def judgement_context():
    """Δ is the context of the judgement; Γ never is (chapter 2 reads Γ ⊢ t : T categorically)."""
    bad = []
    for name, _, text in corpus.modules():
        if name.startswith("C2"):
            continue
        for i, line in enumerate(text.split("\n"), 1):
            if re.search(r"\\Gamma\s*[_\d{}]*\s*\\vdash", line):
                bad.append(f"{name}:{i}")
    if bad:
        ko("Γ employé comme zone du jugement — Δ est le seul contexte : %s" % bad[:6])
    else:
        ok("contexte du jugement : Δ partout, Γ au seul sens catégorique")


def one_glyph_per_modality():
    """Resource carries !, time carries the square; a subscripted square is a resource modality misspelt."""
    bad = []
    for name, _, text in corpus.modules():
        for i, line in enumerate(text.split("\n"), 1):
            if re.search(r"\\(Box|square)_", line):
                bad.append(f"{name}:{i}")
    if bad:
        ko("carré indicé — la modalité de ressource s'écrit !_r : %s" % bad[:6])
    else:
        ok("modalités : ! pour la ressource, carré nu pour le temps")


def hashing_claims():
    """A digest is collision-resistant, not injective; only comparing two computed digests is O(1)."""
    forbidden = ("sans collision", "injectif", "injective", "sans conflit")
    bad = set()
    for name, _, text in corpus.modules():
        for m in re.finditer(r"(?i)(hachage|condensat|hash|BLAKE3)", text):
            window = text[max(0, m.start() - 200): m.end() + 200].lower()
            for word in forbidden:
                if word in window:
                    bad.add(f"{name} : « {word} » près de « {m.group(1)} »")
    if bad:
        ko("affirmation trop forte sur un hachage : %s" % sorted(bad)[:4])
    else:
        ok("hachage : résistance aux collisions, jamais injectivité")


def grades_and_sizes():
    """ℚ≥0 carries the grades, ℕ∞ the sizes: do not identify ℛ with the conaturals without restriction."""
    bad = []
    for name, _, text in corpus.modules():
        t = corpus.flat(text)
        for m in re.finditer(r"conaturels", t):
            window = t[max(0, m.start() - 320): m.end() + 320]
            if "N}_\\infty" in window and not re.search(r"sous-semi-anneau|restreint|fragment des entiers", window):
                bad.append(f"{name}, position {m.start()}")
    if bad:
        ko("ℛ identifié aux conaturels sans restriction déclarée : %s" % bad[:4])
    else:
        ok("grades et indices de taille : porteurs distingués")


def float_families_listed():
    """Every numbered family (figure, table, formule, listing) has its list printed."""
    text = corpus.raw("Refs") + "".join(t for n, _, t in corpus.modules() if n.startswith("Refs."))
    used = {"figure": "::::figure", "table": "::::k7table", "formule": "::::formula (label", "listing": "::::listing"}
    everything = corpus.everything()
    orphans = [kind for kind, marker in used.items() if marker in everything and f'{{listof "{kind}"}}' not in text]
    if orphans:
        ko("famille numérotée jamais listée : %s" % orphans)
    else:
        ok("familles numérotées : toutes listées")


def seal():
    """The seal carries only declared statuses and levels; nothing unproven is a theorem."""
    bad = []
    for r in mm.statements():
        if r["statut"] not in STATUSES:
            bad.append(f"{r['label']} : statut « {r['statut']} »")
        if r["niveau"] not in LEVELS:
            bad.append(f"{r['label']} : niveau « {r['niveau']} »")
        if r["statut"] == "theoreme" and not r["esquisse"]:
            bad.append(f"{r['label']} : théorème sans esquisse de preuve")
        if r["statut"] == "exigence" and r["esquisse"]:
            bad.append(f"{r['label']} : une exigence ne porte pas d'esquisse")
    labels = [r["label"] for r in mm.statements()]
    bad += [f"étiquette en double : {l}" for l in {l for l in labels if labels.count(l) > 1}]
    if bad:
        ko("sceau : %s" % bad[:4])
    else:
        ok("sceau des énoncés : statuts et niveaux déclarés, preuves cohérentes avec le statut")


def propagated_mentions():
    """No mention asserts an open statement as established ("établit", "démontre", "garantit"…)."""
    open_ = {r["label"] for r in mm.statements() if r["statut"] in ("proposition", "conjecture", "exigence")}
    if not open_:
        ok("propagation : aucun énoncé ouvert, rien à propager")
        return
    assertive = r"(?:établit|démontre|garantit|prouve|assure|acquitte)"
    bad = []
    for name, _, text in corpus.modules():
        for m in re.finditer(r'\{num "(thm:[^"]+)"\}\[\]', text):
            if m.group(1) not in open_:
                continue
            window = text[m.end(): m.end() + 90].split(".")[0]
            v = re.search(assertive, window)
            if v:
                bad.append(f"{name} : « {m.group(1)} » affirmé {v.group(0)}")
    if bad:
        ko("mention non propagée — un énoncé ouvert dit acquis : %s" % bad[:4])
    else:
        ok("propagation : %d énoncé(s) ouvert(s), aucune mention les disant acquis" % len(open_))


def route_of_each_commitment():
    """Every commitment names its route: littérature, démonstration or mesure (nothing else)."""
    text = corpus.raw("C1.GuideDeLecture")
    m = re.search(r'::::k7table[^\n]*"tab:engagements"[^\n]*\n(.*?)\n::::$', text, re.S | re.M)
    if not m:
        ko("la table des engagements est introuvable")
        return
    cells = re.findall(r"^\s*\*(?: \*)? (.*)$", m.group(1), re.M)
    cells = [c for c in cells]
    header = cells[:4]
    rows = [cells[i: i + 4] for i in range(0, len(cells), 4)][1:]
    allowed = {"littérature", "démonstration", "mesure"}
    bad = []
    if len(header) < 4 or not header[3].strip() or header[3].strip() == "\u00a0":
        bad.append("en-tête sans colonne « Route »")
    routes = set()
    for row in rows:
        if len(row) < 4 or not row[3].strip("\u00a0 "):
            bad.append("engagement sans route : " + row[0][:40])
            continue
        route = re.sub(r"\s*\(.*\)", "", row[3]).strip("`_* ")
        routes.add(route)
        if re.search(r"\b(démonstration|littérature|mesure)\s*$", row[2]):
            bad.append("route parasite en fin de troisième cellule : " + row[0][:40])
    if routes - allowed:
        bad.append("route hors des trois admises : %s" % sorted(routes - allowed))
    if bad:
        ko("engagements : %s" % bad[:3])
    else:
        ok("engagements : %d route(s) distincte(s), toutes admises" % len(routes))


def symbols_in_the_normative_table():
    """The normative table of chapter 1 exists and covers the symbols the document governs."""
    text = corpus.chapter("C1")
    if "tab:c1-symboles" not in text:
        ko("la table normative des symboles est absente du chapitre 1")
        return
    expected = ["\\Delta", "\\Gamma", "\\mathcal{R}", "\\mathcal{X}", "!_r", "\\varphi_r", "\\boxtimes"]
    missing = [s for s in expected if s not in text]
    if missing:
        ko("symboles absents de la table normative : %s" % missing)
    else:
        ok("table normative : présente et couvrant les symboles gouvernés")


def run():
    print("\n[Notation]")
    for check in (judgement_context, one_glyph_per_modality, hashing_claims, grades_and_sizes, float_families_listed,
                  seal, propagated_mentions, route_of_each_commitment, symbols_in_the_normative_table):
        check()
