# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Semantic probes and vocabulary checks, ported from the former Org tooling.

A probe says: the passage "…" must be followed, within a window, by a citation of key K. It catches a
citation that drifted away from the sentence it supports (a reformulation, a moved paragraph).
"""

from __future__ import annotations

import json
import re
import unicodedata
from pathlib import Path

from . import corpus
from .journal import ko, ok

PROBES = Path(__file__).parent / "donnees" / "sondes.json"


def norm(text: str) -> str:
    text = unicodedata.normalize("NFKD", text)
    text = "".join(c for c in text if not unicodedata.combining(c)).lower()
    return re.sub(r"\s+", " ", text.replace("\u00a0", " "))


def probes():
    data = json.loads(PROBES.read_text(encoding="utf-8"))
    window = data.get("_fenetre", 700)
    flat = norm(corpus.everything())
    done = 0
    for s in data["sondes"]:
        i = flat.find(norm(s["passage"]))
        if i < 0:
            ko("sonde non ancrée (passage disparu ou reformulé) : « %s »" % s["passage"])
            continue
        keys = re.findall(r'\{cite "([^"]+)"\}', flat[i : i + window])
        keys = [k.lower() for ks in keys for k in ks.split(",")]
        if s["cle"].lower() in keys:
            done += 1
        else:
            ko("sonde mal attribuée : « %s » attendu %s, obtenu %s" % (s["passage"], s["cle"], keys[:3]))
    if done == len(data["sondes"]):
        ok("sondes sémantiques : %d/%d" % (done, len(data["sondes"])))


def vocabulary():
    text = corpus.flat_everything()
    faults = [
        (r"\\mid \\mathcal\{C\}", "\\mathcal{C} employée comme composante du jugement"),
        (r"(cinq|quatre) composantes du jugement", "arité fantôme du jugement — il en porte trois"),
    ]
    bad = [(msg, len(re.findall(p, text))) for p, msg in faults if re.search(p, text)]
    for msg, n in bad:
        ko("%s (%d occurrence(s))" % (msg, n))
    if not bad:
        ok("vocabulaire de l'axiome : \\mathcal{C} répartie, jugement à trois composantes")


def numeric_citations():
    text = corpus.everything()
    body = re.sub(r"```.*?```", "", text, flags=re.S)
    body = re.sub(r"\$+`[^`]*`", "", body)
    found = re.findall(r"(?<![\w\"])\[(\d{1,3})\](?!\()", body)
    if found:
        ko("citations numériques écrites à la main : %s" % found[:6])
    else:
        ok("aucune citation numérique écrite à la main")


def run():
    print("\n[Sémantique]")
    probes()
    vocabulary()
    numeric_citations()
