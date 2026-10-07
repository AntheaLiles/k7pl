#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Le fonds documentaire : son registre, et son classement par arc.

    python3 outils/corpus.py            reconstruit le registre puis classe
    python3 outils/corpus.py registre   le registre seul
    python3 outils/corpus.py arcs       le classement seul

DEUX QUESTIONS SUR LE MÊME FONDS, réunies le 8 septembre. Le registre associe
à chaque clé de citation son titre, son résumé, son année et le chemin de son
PDF ; le classement range ces mêmes clés par arc de recherche. Les tenir dans
deux fichiers obligeait à se rappeler lequel relancer après un réexport Zotero
— et `arcs.py` n'était nommé nulle part.

Sortie : 0 si tout s'est écrit, 2 si une source manque (export Zotero absent).
"""

import io
import json
import os
import re
import sys

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BIBDIR = os.path.join(BASE, "bib", "K7PL-Biblio")
CITATIONS = os.path.join(BIBDIR, "refs-pour-citations.bib")
FICHIERS = os.path.join(BIBDIR, "K7PL-Biblio.bib")
SORTIE = os.path.join(BASE, "bib", "pdf-index.json")


def _decouper(chemin):
    """Rend la liste des (clé, corps) d'un fichier BibTeX.

    Le découpage se fait sur la LIGNE d'entrée — « @type{clé, » en début de
    ligne — et non sur un comptage d'accolades. Un résumé contient des
    accolades déséquilibrées bien plus souvent qu'on ne le croit, et un
    compteur d'accolades s'y perd sans le dire.
    """
    t = io.open(chemin, encoding="utf-8", errors="ignore").read()
    deb = [(m.start(), m.group(1)) for m in
           re.finditer(r"^@\w+\{([^,\n]+),", t, re.M)]
    out = []
    for i, (p, cle) in enumerate(deb):
        fin = deb[i + 1][0] if i + 1 < len(deb) else len(t)
        out.append((cle.strip(), t[p:fin]))
    return out


def _champ(corps, nom):
    """Rend la valeur d'un champ, accolades équilibrées, ou une chaîne vide."""
    m = re.search(r"^\s*%s\s*=\s*" % nom, corps, re.M)
    if not m:
        return ""
    i = m.end()
    if i >= len(corps):
        return ""
    if corps[i] == "{":
        prof, j = 0, i
        while j < len(corps):
            if corps[j] == "{":
                prof += 1
            elif corps[j] == "}":
                prof -= 1
                if prof == 0:
                    return re.sub(r"\s+", " ", corps[i + 1:j]).strip()
            j += 1
        return ""
    m2 = re.match(r'"([^"]*)"|([^,\n]*)', corps[i:])
    return re.sub(r"\s+", " ", (m2.group(1) or m2.group(2) or "")).strip()


def _pdf(valeur):
    """Extrait un chemin relatif « files/... » d'un champ file de Zotero.

    La forme est « Étiquette:chemin:type », parfois répétée et séparée par des
    points-virgules. On ne retient que ce qui commence par « files/ » : le
    reste est un chemin absolu d'une autre machine, et le retenir donnerait un
    registre qui promet des fichiers qu'on ne peut pas ouvrir.
    """
    # Le séparateur d'entrées est « ; », mais Zotero ÉCHAPPE en « \; » les
    # points-virgules qui appartiennent au nom du fichier — et un titre en
    # contient plus souvent qu'on ne le croit. Découper naïvement sur « ; »
    # tronque le chemin au milieu, et l'entrée passe pour être sans PDF.
    # Trouvé le 3 septembre sur la taxonomie de Rasmussen, dont le titre
    # porte un point-virgule.
    valeur = valeur.replace("\\;", "\x00")
    for part in valeur.split(";"):
        for morceau in part.split(":"):
            morceau = morceau.replace("\x00", ";").strip()
            if morceau.startswith("files/") and morceau.lower().endswith(".pdf"):
                return morceau
    return None


def construire():
    idx = {}
    for cle, corps in _decouper(CITATIONS):
        titre = _champ(corps, "title")
        titre = re.sub(r"[{}]", "", titre)
        da = _champ(corps, "date") or _champ(corps, "year")
        an = re.search(r"(\d{4})", da)
        idx[cle] = {
            "pdf": None,
            "titre": titre,
            "annee": int(an.group(1)) if an else None,
            "resume": re.sub(r"[{}]", "", _champ(corps, "abstract"))[:1200],
            "doi": _champ(corps, "doi") or None,
            "type": re.match(r"@(\w+)\{", corps).group(1),
        }
    # Le SECOND fichier n'est consulté que pour le chemin du PDF.
    manquantes = 0
    for cle, corps in _decouper(FICHIERS):
        if cle not in idx:
            manquantes += 1
            continue
        p = _pdf(_champ(corps, "file"))
        # Le nom de fichier écrit au champ ne coïncide pas toujours avec celui
        # du disque : un « ! », un « : » ou une lettre grecque du titre ont été
        # transcrits d'une manière à l'export et d'une autre au nommage. Le
        # DOSSIER, lui, est fiable — c'est l'identifiant de la pièce jointe.
        # Quand le chemin exact manque et que le dossier ne contient qu'un seul
        # PDF, c'est celui-là : la correspondance est certaine, non devinée.
        if p and not os.path.exists(os.path.join(BIBDIR, p)):
            d = os.path.join(BIBDIR, os.path.dirname(p))
            if os.path.isdir(d):
                cands = [f for f in os.listdir(d) if f.lower().endswith(".pdf")]
                if len(cands) == 1:
                    p = os.path.join(os.path.dirname(p), cands[0]).replace("\\", "/")
        idx[cle]["pdf"] = p
    if manquantes:
        sys.stderr.write(
            "  %d clés de K7PL-Biblio.bib absentes de refs-pour-citations.bib\n"
            % manquantes)
    return idx


if __name__ == "__main__":
    idx = construire()
    if len(sys.argv) > 1:
        for k in sys.argv[1:]:
            v = idx.get(k)
            print("%-46s %s" % (k, v if v else "ABSENTE"))
    else:
        io.open(SORTIE, "w", encoding="utf-8").write(
            json.dumps(idx, ensure_ascii=False, indent=1))
        avec = sum(1 for v in idx.values() if v["pdf"])
        print("%d entrées, %d avec PDF -> %s"
              % (len(idx), avec, os.path.relpath(SORTIE, BASE)))


# ── classement par arc ────────────────────────────────────────────────────
# Repris de outils/arcs.py, rejouable après chaque réexport Zotero.

import io, os, sys, json

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
IDX = os.path.join(BASE, "bib", "pdf-index.json")
OUT = os.path.join(BASE, "bib", "arcs.json")

ARCS = {
 "A categories": ["categor","functor","comonad","monad","adjunct","monoidal","topos","enrich",
   "fibration","kan ","coalgebra","algebra","duality","yoneda","sheaf","operad","profunctor",
   "bicategor","natural transformation"],
 "B types-preuves": ["type theor","type system","typed","dependent type","refinement","subtyp",
   "polymorph","inference","normalis","normaliz","cut elimination","proof assistant","coq","agda",
   "lean","isabelle","rocq","mechani","formaliz","formalis","curry-howard","logical relation",
   "parametric","gradual typ","synthesis","inhabit"],
 "C automates": ["automat","regular expression","transducer","grammar","parsing","parser",
   "pushdown","büchi","monadic second","tree automat","minimiz","language inclusion"],
 "D calcul-complexite": ["computab","complexity","decidab","undecidab","recursion theor","turing",
   "halting","polynomial","incompleteness","model theor","decision procedur","smt","sat solv",
   "satisfiab","presburger","abstract interpret"],
 "E graphes-ordres-jeux": ["graph","game semantic","game theor","lattice","order theor",
   "domain theor","fixpoint","fixed point","well-founded","petri","bisimulation","metric"],
 "F concurrence": ["concurren","distribut","process calcul","pi-calculus","pi calculus","session",
   "actor","linearizab","memory model","weak memory","consensus","causal","transaction","lock",
   "atomic"],
 "G syntaxe-legibilite": ["readab","legib","syntax","notation","naming","identifier","code style",
   "comprehension","cognitive dimension","usability","program comprehension","editor","developer",
   "api design","error message","documentation","refactor"],
 "I compilation": ["compil","code generation","llvm","mlir","backend","optimiz",
   "intermediate representation","register alloc","linking","bootstrap","abstract machine",
   "garbage collect","memory manag","runtime","inlin","fusion","defunctionaliz",
   "partial evaluat","staging"],
 "J effets-ressources": ["effect","capabilit","ownership","borrow","linear type","substructur",
   "graded","coeffect","region","resource","permission","uniqueness"],
 "K verif-securite": ["information flow","noninterference","non-interference","security",
   "separation logic","verification","verified","model check","hoare","refinement calculus",
   "invariant","contract","testing","fuzz"],
 "L donnees-requetes": ["datalog","query","database","relational","incremental","stream","tensor",
   "array program","dataframe"],
 "M probabiliste-apprentissage": ["probabilistic","bayesian","differentiable","machine learning",
   "statistical","sampling","inference algorithm","random"],
}

# ── arc H : pondéré, parce que le genre ne se lit pas sur un mot ──────────────
H_FORT = ["lessons learn","lesson learned","years later","years of experience","looking back",
 "retrospect","postmortem","post-mortem","hopl","history of programming","a history of",
 "personal account","first-hand","reminiscen","memoir","obituary","what went wrong",
 "our experience with","we learned","design decisions","design rationale","why we chose",
 "twenty years","ten years","thirty years","forty years","fifty years","anniversar",
 "then and now","past, present","past present","genesis of","origins of","the making of",
 "experience report","industrial experience","in the trenches","war stories","field report"]
H_FAIBLE = ["history","historical","review","legacy","evolution","evolved","interview","recollect",
 "in practice","experience with","practical experience","pitfalls","mistakes","regret",
 "case study","field study","industrial","deployment","adoption","migration","rewrite",
 "critique","criticism","reflections","perspective","assessment","appraisal","revisited",
 "rationale","survey of","overview of","a tour of","decade","state of the practice"]
H_AVANT = 1995


def classer():
    idx = json.load(io.open(IDX, encoding="utf-8"))
    lis = {k: v for k, v in idx.items() if v.get("pdf")}
    out = {}
    for nom, mots in ARCS.items():
        out[nom] = sorted(k for k, v in lis.items()
                          if any(m in (k + " " + v["titre"]).lower() for m in mots))
    h = []
    for k, v in lis.items():
        s = (v["titre"] + " " + v.get("resume", "")).lower()
        if (v.get("annee") and v["annee"] < H_AVANT) \
           or any(m in s for m in H_FORT) \
           or sum(1 for m in H_FAIBLE if m in s) >= 2:
            h.append(k)
    out["H histoire-retours"] = sorted(h)
    return out, len(lis)


if __name__ == "__main__":
    arcs, n = classer()
    if len(sys.argv) > 1:
        cle = [a for a in arcs if a.startswith(sys.argv[1])]
        idx = json.load(io.open(IDX, encoding="utf-8"))
        for a in cle:
            for k in arcs[a]:
                print("%-46s %s" % (k[:46], idx[k]["titre"][:70]))
    else:
        json.dump(arcs, io.open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
        u = set().union(*arcs.values())
        for a in sorted(arcs):
            print("  %-30s %4d" % (a, len(arcs[a])))
        print("  %-30s %4d" % ("UNION", len(u)))
        print("  %-30s %4d" % ("residu", n - len(u)))
