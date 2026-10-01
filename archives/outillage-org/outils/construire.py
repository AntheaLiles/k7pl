#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Assemble le document depuis les sources et valide ses citations.

    python3 outils/construire.py [numéro de version]

    src/K7_Specification.org   porte [cite:@CLÉ] et les #+INCLUDE:
    src/K7_Semantique.org      annexe G
    src/K7_LSP_REPL.org        annexe D
    src/K7_Sushi.org           annexe E
    src/K7_Sugoi.org           annexe F
    src/K7_TODO_LIST.org       suivi de projet, non exporté
        -> build/K7_Specification-vNN.org
           build/K7_TODO_LIST-vNN.org

Ce script ne numérote plus et n'engendre plus de bibliographie : la source
déclare #+BIBLIOGRAPHY: et #+print_bibliography:, et c'est org-cite qui s'en
charge à l'export, depuis bib/K7PL-Biblio/refs-pour-citations.bib — la référence
absolue au sens de la règle d'Anthea. Il ne reste à ce script que ce qu'org
ne fait pas : assembler les fichiers, et vérifier que les citations sont
saines avant qu'un export ne les rencontre.

Trois vérifications, chacune née d'un défaut constaté :
  — toute clé citée existe dans le fonds bibliographique ;
  — toute entrée du fonds est citée, sauf décision déclarée (É-01 : une
    référence a traversé vingt-cinq versions sans emploi) ;
  — aucune citation ne subsiste sous forme de numéro écrit à la main.
"""
import io, os, re, sys, json

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(BASE, "src")
BUILD = os.path.join(BASE, "build")
BIB = os.path.join(BASE, "bib", "K7PL-Biblio", "refs-pour-citations.bib")
DEC = json.load(io.open(os.path.join(BASE, "bib", "decisions-bibliographiques.json"),
                        encoding="utf-8"))["maintenues_sans_citation"]

# org-cite admet la citation MULTIPLE — [cite:@a;@b;@c]. La forme simple était seule
# reconnue, si bien qu'une citation multiple n'était vue par AUCUN contrôle : ni comptée,
# ni vérifiée contre le fonds. Un trou silencieux vaut moins qu'un échec bruyant.
# Trouvé le 2 septembre en citant les trois clés de la spécification WebAssembly.
CITE = r'@([A-Za-z0-9_.:+\-]+)(?=[;\]])'
MARQUE = r'~cite:@([A-Za-z0-9_.:+\-]+)~'   # désignation d'une fiche du chantier

def cles_designees():
    """Les clés qu'une FICHE du chantier désigne, au marqueur ~cite:@clé~.

    On lit les fichiers SUR DISQUE et non le document assemblé : le gros du
    dépouillement — chantier/litterature-grise.org, chantier/arc-theorique.org,
    chantier/reste-a-lire.org — est un fichier de travail que chantier/index.org
    n'assemble pas. Une désignation y reste une appropriation par le projet, et
    doit donc entrer au fonds-projet.
    """
    import glob
    d = set()
    for motif in ("meta/*.org", "OLD/chantier/*.org", "OLD/theorisation/*.org"):
        for f in glob.glob(os.path.join(BASE, motif)):
            d |= set(re.findall(MARQUE, io.open(f, encoding="utf-8").read()))
    return d

# Le « [1] » qui illustre le piège du crochet est lui-même une instance du piège.
PIEGE = "un « [1] » dans un commentaire"


def lire(nom):
    """Chemin relatif à src/ ; les inclusions sont résolues depuis le dossier du fichier."""
    return io.open(os.path.normpath(os.path.join(SRC, nom)), encoding="utf-8").read()


_REP = [SRC]


def cles_du_fonds():
    t = io.open(BIB, encoding="utf-8").read()
    return set(re.findall(r'^@\w+\{([^,]+),', t, re.M))


def _resoudre(t):
    """Remplace #+INCLUDE: "fichier" [options] par son contenu, en-tête ôté.

    L'en-tête d'un fichier inclus est son bloc de mots-clés #+TITLE:, #+AUTHOR:
    et consorts, plus ses commentaires de tête : il décrit le fichier source et
    n'a pas sa place au milieu du document assemblé.

    L'option :minlevel N est honorée comme org l'honore — les titres sont
    décalés pour que le PLUS HAUT d'entre eux tombe au niveau N. Ne pas la
    reconnaître ferait échouer l'inclusion en silence, ce qui est arrivé le
    4 août : cinq annexes avaient disparu du document assemblé sans qu'aucun
    contrôle ne le signale.

    Les inclusions sont RÉCURSIVES et résolues relativement au dossier du fichier
    qui les porte : main.org inclut chapitres/annexes.org, qui inclut ses annexes.
    """
    vus = []

    def rempl(m):
        vus.append(m.group(1))
        chemin = os.path.normpath(os.path.join(_REP[-1], m.group(1)))
        lignes = io.open(chemin, encoding="utf-8").read().split("\n")
        i = 0
        while i < len(lignes) and (lignes[i].startswith("# ")
                                   or re.match(r'^#\+[A-Za-z_]+:', lignes[i])
                                   or not lignes[i].strip()):
            i += 1
        lignes = lignes[i:]
        if m.group(2):
            n = int(m.group(2))
            niveaux = [len(x) - len(x.lstrip("*"))
                       for x in lignes if re.match(r'^\*+ ', x)]
            if niveaux:
                d = n - min(niveaux)
                if d:
                    lignes = [("*" * max(1, (len(x) - len(x.lstrip("*")) + d)) + x.lstrip("*"))
                              if re.match(r'^\*+ ', x) else x for x in lignes]
        # récursion : le dossier courant devient celui du fichier inclus
        _REP.append(os.path.dirname(chemin))
        res, sous = _resoudre("\n".join(lignes).strip("\n"))
        _REP.pop()
        vus.extend(sous)
        return res

    r = re.sub(r'^#\+INCLUDE:\s*"([^"]+)"(?:[^\n]*?:minlevel\s+(\d+))?[^\n]*$',
               rempl, t, flags=re.M)
    return r, vus


def resoudre_include(t, depuis=None):
    """Point d'entrée : résout toutes les inclusions, récursivement."""
    if depuis:
        _REP.append(depuis)
    r, vus = _resoudre(t)
    if depuis:
        _REP.pop()
    restants = re.findall(r'^#\+INCLUDE:.*$', r, re.M)
    if restants:
        sys.exit("ARRET : #+INCLUDE: non résolus — %s" % restants)
    print("  %d fichiers inclus : %s" % (len(vus), ", ".join(vus)))
    return r


def main(version):
    # REFONTE DU 28 AOÛT — chantier/ et theorisation/ ont basculé vers OLD/ après
    # compaction. Ce qui vit désormais hors du manuscrit est dans meta/ : le plan,
    # les questions, le corpus, le protocole, la liste des primitives. Ces fichiers
    # ne s'ASSEMBLENT pas — ils ne sont pas des annexes du document — mais leurs
    # DÉSIGNATIONS ~cite:@clé~ restent contrôlées, comme celles du chantier l'étaient.
    spec = resoudre_include(lire("main.org"))
    chantier = ""
    # L'arc théorique est archivé dans theorisation/ depuis le 5 août. Il est
    # assemblé à part pour que le dossier reste navigable, mais il continue
    # d'être ASSEMBLÉ et CONTRÔLÉ : une archive dont les citations ne seraient
    # plus vérifiées cesserait d'être une source et deviendrait un dépotoir.
    theorie = ""
    fonds = cles_du_fonds()
    echecs = []

    # --- deux ensembles, deux contrôles ---
    # RÈGLE ARRÊTÉE LE 10 AOÛT PAR ANTHEA, ET ELLE EST SIMPLE :
    #     « le RDF sert à la RECHERCHE, le BIB sert à CITER dans le manuscrit ».
    # D'où DEUX contrôles distincts, tous deux stricts :
    #   — toute clé CITÉE doit être dans refs.bib      (on ne cite pas dans le vide) ;
    #   — toute clé DÉSIGNÉE au chantier doit être au CORPUS DE LECTURE
    #     (on ne désigne pas une fiche qu'on ne peut pas ouvrir).
    # Une clé peut être les deux ; aucune ne peut n'être ni l'un ni l'autre.
    designees = cles_designees()
    citees = (set(re.findall(CITE, spec)) | set(re.findall(CITE, chantier))
              | set(re.findall(CITE, theorie)))
    corpus = set()
    _pi = os.path.join(BASE, "bib", "pdf-index.json")
    if os.path.exists(_pi):
        corpus = set(json.load(io.open(_pi, encoding="utf-8")))
    hors_bib = sorted(citees - fonds)
    if hors_bib:
        echecs.append("clés CITÉES absentes de refs-pour-citations.bib : %s" % hors_bib)
    hors_corpus = sorted(designees - corpus - fonds)
    if hors_corpus:
        echecs.append("clés DÉSIGNÉES au chantier absentes du corpus de lecture : %s"
                      % hors_corpus)

    # --- toute entrée du FONDS-PROJET est citée, sauf décision déclarée ---
    citees_spec = set(re.findall(CITE, spec))
    projet = (citees | designees) & fonds
    orphelines = sorted(projet - citees_spec - set(DEC))
    if orphelines:
        echecs.append("entrées du FONDS-PROJET citées nulle part et sans décision : %s"
                      % orphelines)
    print("  fonds-projet : %d clés réclamées sur %d entrées de bibliothèque"
          % (len(projet), len(fonds)))
    for k in sorted(set(DEC) & projet - citees_spec):
        print("  décision : %s maintenue sans citation — %s" % (k, DEC[k]["motif"][:70]))

    # --- aucune citation numérique écrite à la main ---
    for nom, t in (("spécification", spec), ("suivi", chantier), ("théorisation", theorie)):
        restes = []
        for ln, l in enumerate(t.split("\n"), 1):
            if l.startswith("#") or PIEGE in l:
                continue
            for m in re.finditer(r'(?<!cite:@)\[(\d{1,3})\]', l):
                restes.append("%s l.%d : [%s]" % (nom, ln, m.group(1)))
        if restes:
            echecs.append("citations numériques résiduelles — %s" % restes[:5])

    # Séparation posée le 2 septembre : LE BUILD ASSEMBLE, LE CONTRÔLE JUGE.
    # Un défaut de bibliographie empêchait jusqu'ici d'assembler, donc de conduire
    # les vingt autres contrôles — une clé manquante masquait tout le reste. Elle
    # reste un ÉCHEC, elle cesse d'être un ARRÊT : le document est écrit, le défaut
    # est écrit à côté de lui, et outils/controle.py le refuse comme avant.
    ARRET_DUR = ("#+INCLUDE:", "citations numériques")
    durs = [e for e in echecs if any(x in e for x in ARRET_DUR)]
    if durs:
        for e in durs:
            print("ARRET : " + e)
        sys.exit(1)
    if echecs:
        for e in echecs:
            print("ÉCHEC (non bloquant pour l'assemblage) : " + e)
        io.open(os.path.join(BASE, "build", "ECHECS-v%s.txt" % version), "w",
                encoding="utf-8").write("\n".join(echecs) + "\n") if os.path.isdir(
                    os.path.join(BASE, "build")) else None

    os.makedirs(BUILD, exist_ok=True)
    a = os.path.join(BUILD, "K7_Specification-v%s.org" % version)
    b = os.path.join(BUILD, "K7_TODO_LIST-v%s.org" % version)
    c = os.path.join(BUILD, "K7_Theorisation-v%s.org" % version)
    io.open(a, "w", encoding="utf-8").write(spec)
    io.open(b, "w", encoding="utf-8").write(chantier)
    io.open(c, "w", encoding="utf-8").write(theorie)
    print("assemblé :\n  %s\n  %s\n  %s" % (a, b, c))
    n, avant, apres = bibliographie_d_export(citees_spec)
    print("%d clés citées sur %d au fonds ; bibliographie d'export : %d entrées, "
          "%.2f Mo au lieu de %.2f" % (len(citees_spec), len(fonds), n,
                                       apres / 1048576., avant / 1048576.))


def bibliographie_d_export(citees):
    """Écrit build/refs-export.bib : les seules entrées CITÉES, sans les résumés.

    POURQUOI CE FICHIER EXISTE, ET C'EST UN DÉFAUT MESURÉ LE 4 SEPTEMBRE.
    L'export org vers PDF tournait sans fin et le tampon du processus enflait
    jusqu'à saturer la mémoire. La cause n'est pas dans le manuscrit — aucun bloc
    non fermé, aucun environnement déséquilibré, aucun caractère de contrôle —
    elle est dans ce qu'org-cite doit AVALER pour résoudre les citations.

    Le 3 septembre, la bibliothèque a basculé d'un fonds-projet de quatre cent
    cinquante entrées à la collection complète : 4 326 entrées, 6,75 Mo, dont
    59 pour cent de RÉSUMÉS. Or aucun processeur de citation n'emploie un résumé.
    Et les processeurs écrits en Lisp — « basic », qui est le défaut, comme
    « csl » — analysent le fichier ENTIER, en Lisp, avant de formater la première
    citation. Le manuscrit en cite 249, soit 6,2 pour cent du fichier : l'export
    lisait dix-sept fois ce dont il avait besoin.

    CE FICHIER NE VIOLE PAS LA RÈGLE D'ANTHEA, et il faut le dire ici pour qu'on
    ne le corrige pas de travers plus tard. `refs-pour-citations.bib` reste la
    RÉFÉRENCE ABSOLUE : ce fichier-ci en DÉRIVE, il est écrit dans build/ et
    jamais dans bib/, et il est réengendré à chaque assemblage. Rien n'est écrit
    dans ce que Zotero produit.

    LES CHAMPS ÔTÉS sont ceux qu'aucun style de citation ne lit : le résumé,
    le chemin du fichier, les mots-clés, les notes. Le reste passe intact.
    """
    OTES = ("abstract", "file", "keywords", "annote", "note", "urldate")
    sortie = os.path.join(BUILD, "refs-export.bib")
    t = io.open(BIB, encoding="utf-8").read()
    deb = [(m.start(), m.group(1).strip())
           for m in re.finditer(r"^@\w+\{([^,\n]+),", t, re.M)]
    gardees, taille = [], 0
    for i, (p, cle) in enumerate(deb):
        fin = deb[i + 1][0] if i + 1 < len(deb) else len(t)
        if cle not in citees:
            continue
        corps = t[p:fin]
        # On retire le champ ligne à ligne, en suivant la profondeur d'accolades :
        # un résumé contient des accolades, et un découpage naïf couperait au
        # milieu. C'est la même prudence que dans outils/pdf_index.py.
        #
        # LA PROFONDEUR D'UN CHAMP EST UN, PAS ZÉRO — la ligne « @article{clé, »
        # a déjà ouvert une accolade. Écrite avec zéro, la condition n'était
        # jamais vraie et la fonction rendait le fichier INCHANGÉ, ce qu'un
        # simple comptage d'octets a révélé. Une coupe qui ne coupe rien ne se
        # voit pas au résultat : elle se voit à la mesure.
        lignes, garde, prof = [], True, 0
        for l in corps.split("\n"):
            if prof <= 1:
                m = re.match(r"\s*(\w+)\s*=", l)
                if m:
                    garde = m.group(1).lower() not in OTES
                elif prof == 0:
                    garde = True
            if garde:
                lignes.append(l)
            prof += l.count("{") - l.count("}")
            if prof < 0:
                prof = 0
        e = "\n".join(lignes).rstrip().rstrip(",")
        # Ôter des champs peut emporter la ligne qui refermait l'entrée. On la
        # referme sur la profondeur RÉELLE plutôt que sur la présence d'une
        # accolade en fin de chaîne : « langid = {english} » finit par « } »
        # sans refermer l'entrée pour autant, et le test naïf s'y laissait
        # prendre. Défaut trouvé le 4 septembre par un comptage d'accolades.
        d = e.count("{") - e.count("}")
        if d > 0:
            e += "\n" + "}" * d
        gardees.append(e)
        taille += len(e)
    texte = ("% Engendré par outils/construire.py — NE PAS ÉDITER.\n"
             "% Dérivé de bib/K7PL-Biblio/refs-pour-citations.bib, "
             "qui reste la référence absolue.\n"
             "% Ne porte que les clés CITÉES au manuscrit, et sans les champs "
             "qu'aucun style de citation ne lit.\n\n"
             + "\n\n".join(gardees) + "\n")
    # CONTRÔLE DU PRODUIT, ET IL EST NÉ DE DEUX FAUTES DE CETTE FONCTION MÊME.
    # La première ne coupait rien, la seconde ne refermait pas. Aucune des deux
    # ne se voyait au résultat : un .bib légèrement faux se lit comme un .bib.
    # On mesure donc, à chaque assemblage, ce qu'on vient d'écrire.
    v = re.sub(r"\\[{}]", "", texte)
    if v.count("{") != v.count("}"):
        sys.exit("ARRET : build/refs-export.bib déséquilibré — { =%d } =%d"
                 % (v.count("{"), v.count("}")))
    rendues = set(re.findall(r"^@\w+\{([^,\n]+),", texte, re.M))
    perdues = sorted(citees - rendues)
    if perdues:
        sys.exit("ARRET : clés citées absentes de la bibliographie d'export : %s"
                 % perdues[:10])
    io.open(sortie, "w", encoding="utf-8").write(texte)
    return len(gardees), len(t), taille


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "66")
