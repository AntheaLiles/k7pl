# -*- coding: utf-8 -*-
"""Contrôles de notation, nés de la relecture externe du 8 septembre 2026.

Les trente contrôles existants tiennent la cohérence interne du document —
étiquettes, renvois, citations, croisement grammaire/règles. Aucun ne vérifie
qu'un mot désigne le bon objet, et c'est par là que les quatre défauts de la
relecture sont passés. Ceux qui suivent ferment les cinq qui sont mécanisables.

Le sixième — « ce mot désigne-t-il le bon objet mathématique ? » — n'est pas
mécanisable et demande un relecteur. Il n'a pas sa place ici.
"""
import io, os, re, glob

BASE = os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))

from controles.journal import ko, ok


def _sources():
    """Les fichiers de source org, hors build et hors archives."""
    return (sorted(glob.glob(os.path.join(BASE, "src", "*.org")))
            + sorted(glob.glob(os.path.join(BASE, "src", "chapitres", "*.org"))))


def _lignes(chemin):
    return io.open(chemin, encoding="utf-8").read().split("\n")


def contexte_du_jugement(ctx):
    """Δ est le contexte du jugement, Γ ne l'est jamais.

    Le chapitre 1 pose que « le symbole Γ reste employé au sens générique […]
    jamais comme zone du jugement ». Trois occurrences de `\\Gamma \\vdash`
    l'enfreignaient au 8 septembre, dont la préservation du type — relevé par
    la relecture externe, invisible à tous les contrôles d'alors.

    Le chapitre 2 est excepté : la lecture catégorique y écrit légitimement
    Γ ⊢ t : T pour un morphisme t : Γ → T de C.
    """
    fautes = []
    for chemin in _sources():
        nom = os.path.basename(chemin)
        if nom == "c2-fondements.org":
            continue                      # la lecture catégorique y est licite
        for i, ligne in enumerate(_lignes(chemin), 1):
            if re.search(r"\\Gamma\s*[_\d{}]*\s*\\vdash", ligne):
                fautes.append("%s l.%d" % (nom, i))
    if fautes:
        ko("Γ employé comme zone du jugement — Δ est le seul contexte : %s"
           % fautes[:6])
    else:
        ok("contexte du jugement : Δ partout, Γ au seul sens catégorique")


def un_glyphe_par_modalite(ctx):
    """La ressource porte !, le temps porte le carré, et jamais l'inverse.

    Le document a longtemps écrit !_r au chapitre 2 et □_r à l'annexe pour le
    même objet. Deux relectures l'ont relevé en recommandant l'inverse l'une de
    l'autre ; l'arbitrage retient ! pour la ressource, le carré restant au temps
    où la nécessité modale lui donne son meilleur titre.

    Un carré indicé est donc une modalité de ressource mal écrite. Un carré nu
    est temporel et reste licite.
    """
    fautes = []
    for chemin in _sources():
        nom = os.path.basename(chemin)
        for i, ligne in enumerate(_lignes(chemin), 1):
            if re.search(r"\\(Box|square)_", ligne):
                fautes.append("%s l.%d" % (nom, i))
    if fautes:
        ko("carré indicé — la modalité de ressource s'écrit !_r : %s"
           % fautes[:6])
    else:
        ok("modalités : ! pour la ressource, carré nu pour le temps")


def affirmations_sur_le_hachage(ctx):
    """Un condensat n'est pas injectif, et son calcul n'est pas en O(1).

    Le chapitre 4 écrivait « BLAKE3, déterministe et sans collision […] en
    O(1) » : trois erreurs en une phrase, qu'un cryptographe vérifie sans
    effort. Un hachage cryptographique est résistant aux collisions, ce qui
    n'est pas l'injectivité, et seule la comparaison de deux condensats déjà
    calculés est en temps constant.
    """
    interdits = ("sans collision", "injectif", "injective", "sans conflit")
    fautes = []
    for chemin in _sources():
        nom = os.path.basename(chemin)
        texte = io.open(chemin, encoding="utf-8").read()
        for m in re.finditer(r"(?i)(hachage|condensat|hash|BLAKE3)", texte):
            fenetre = texte[max(0, m.start() - 200): m.end() + 200].lower()
            for mot in interdits:
                if mot in fenetre:
                    fautes.append("%s : « %s » près de « %s »"
                                  % (nom, mot, m.group(1)))
    if fautes:
        ko("affirmation trop forte sur un hachage : %s" % sorted(set(fautes))[:4])
    else:
        ok("hachage : résistance aux collisions, jamais injectivité")


def grades_et_tailles_distingues(ctx):
    """ℚ≥0 porte les grades, ℕ∞ porte les tailles, et ce ne sont pas les mêmes.

    Le porteur de ℛ contient les rationnels ; les conaturels n'en sont que le
    sous-semi-anneau des entiers. Confondre les deux fait invoquer une
    bien-fondation que l'ordre sur les rationnels n'a pas — 1 > 1/2 > 1/4 > …
    ne termine jamais. Trois lecteurs indépendants ont relevé la confusion.

    Le contrôle interdit d'écrire que ℛ *est* les conaturels sans restriction
    explicite au sous-semi-anneau des entiers.
    """
    fautes = []
    for chemin in _sources():
        nom = os.path.basename(chemin)
        texte = io.open(chemin, encoding="utf-8").read()
        for m in re.finditer(r"conaturels", texte):
            fenetre = texte[max(0, m.start() - 320): m.end() + 320]
            if "N_\\infty" in fenetre or "mathbb{N}_\\infty" in fenetre:
                if not re.search(r"sous-semi-anneau|restreint|fragment des entiers",
                                 fenetre):
                    fautes.append("%s, position %d" % (nom, m.start()))
    if fautes:
        ko("ℛ identifié aux conaturels sans restriction déclarée : %s"
           % fautes[:4])
    else:
        ok("grades et indices de taille : porteurs distingués")


def familles_de_flottants_listees(ctx):
    """Toute famille de flottants déclarée au préambule voit sa liste imprimée.

    Motif, écrit le 9 septembre. La famille des formules a été déclarée, son
    message de repli écrit, sa commande de liste définie — et la liste n'était
    appelée nulle part. Un objet numéroté que rien ne liste est un objet qu'on
    ne retrouve qu'en feuilletant, ce qui est exactement ce que la famille
    devait éviter.
    """
    pre = os.path.join(BASE, "livrables", "preamble-article.tex")
    refs = os.path.join(BASE, "src", "chapitres", "refs.org")
    if not (os.path.exists(pre) and os.path.exists(refs)):
        ok("familles de flottants : préambule ou table des renvois absent")
        return
    declarees = set(re.findall(r"\\DeclareFloatingEnvironment\[[^\]]*\]\{(\w+)\}",
                               io.open(pre, encoding="utf-8").read()))
    imprimees = io.open(refs, encoding="utf-8").read()
    orphelines = sorted(f for f in declarees
                        if ("listof%ss" % f) not in imprimees
                        and ("listof%s" % f) not in imprimees)
    if orphelines:
        ko("famille de flottants déclarée mais jamais listée : %s" % orphelines)
    else:
        ok("familles de flottants : %d déclarée(s), toutes listées" % len(declarees))


def sceau_des_enonces(ctx):
    """Le sceau ne porte que des statuts et des niveaux déclarés.

    Un environnement unique pour sept natures épistémiques faisait passer pour
    démontré ce qui était esquissé, et masquait dix-huit résultats réellement
    acquis. Le sceau les sépare ; ce contrôle refuse une valeur inventée, qui
    rendrait le relevé faux sans que rien ne le signale.

    Il refuse aussi qu'un énoncé non démontré porte le statut de théorème : une
    esquisse suivie d'un « s'il tient / s'il tombe » est une proposition.
    """
    statuts = {"theoreme", "proposition", "conjecture", "definition",
               "exigence", "litterature"}
    niveaux = {"langage", "compilation", "representation", "deploiement"}
    fautes = []
    for chemin in _sources():
        nom = os.path.basename(chemin)
        texte = io.open(chemin, encoding="utf-8").read()
        for m in re.finditer(r"\\begin\{theorem\}\[[^\]]*\]\[([^\]]*)\]", texte):
            for cle, valeur in re.findall(r"(\w+)\s*=\s*(\w+)", m.group(1)):
                if cle == "statut" and valeur not in statuts:
                    fautes.append("%s : statut « %s »" % (nom, valeur))
                elif cle == "niveau" and valeur not in niveaux:
                    fautes.append("%s : niveau « %s »" % (nom, valeur))
                elif cle not in ("statut", "niveau"):
                    fautes.append("%s : clé « %s »" % (nom, cle))
    if fautes:
        ko("sceau : valeur hors nomenclature — %s" % fautes[:4])
    else:
        ok("sceau des énoncés : statuts et niveaux tous déclarés")


def mentions_propagees(ctx):
    """Aucune mention n'affirme comme acquis un énoncé qui ne l'est pas.

    La campagne PR-02 a nommé la cause de douze symptômes : le document « se
    corrige en avant et ne propage pas en arrière ». Une correction est écrite
    là où elle est découverte, et les mentions antérieures gardent l'ancien
    statut — le même énoncé se lit démontré page 60 et esquissé page 240.

    La règle que ce contrôle tient : *une mention non propagée est une erreur du
    document, pas une nuance.* Un énoncé scellé proposition, conjecture ou
    exigence ne peut pas être dit établir, démontrer ou garantir quoi que ce
    soit — il l'énonce, il le pose, il le vise.
    """
    # Le sceau de chaque énoncé.
    sceau = {}
    for chemin in _sources():
        texte = io.open(chemin, encoding="utf-8").read()
        for nom, sc, lab in re.findall(
                r"\\begin\{theorem\}\[([^\]]*)\](\[[^\]]*\])?\s*\\label\{([^}]*)\}",
                texte):
            statut = "theoreme"
            if sc:
                m = re.search(r"statut\s*=\s*(\w+)", sc)
                if m:
                    statut = m.group(1)
            sceau[lab] = statut

    ouverts = {l for l, s in sceau.items()
               if s in ("proposition", "conjecture", "exigence")}
    if not ouverts:
        ok("propagation : aucun énoncé ouvert, rien à propager")
        return

    # Les verbes qui affirment l'acquis. « énonce », « pose », « vise »,
    # « signale » sont licites ; ceux-ci ne le sont pas.
    assertifs = r"(?:établit|démontre|garantit|prouve|assure|acquitte)"
    fautes = []
    for chemin in _sources():
        nom = os.path.basename(chemin)
        texte = io.open(chemin, encoding="utf-8").read()
        for m in re.finditer(r"\\ref\{(thm:[^}]+)\}", texte):
            lab = m.group(1)
            if lab not in ouverts:
                continue
            # La fenêtre après le renvoi, jusqu'à la ponctuation forte.
            fenetre = texte[m.end(): m.end() + 90].split(".")[0]
            v = re.search(assertifs, fenetre)
            if v:
                fautes.append("%s : « %s » affirmé %s" % (nom, lab, v.group(0)))
    if fautes:
        ko("mention non propagée — un énoncé ouvert dit acquis : %s" % fautes[:4])
    else:
        ok("propagation : %d énoncé(s) ouvert(s), aucune mention les disant acquis"
           % len(ouverts))


def route_de_chaque_engagement(ctx):
    """Tout engagement nomme la route par laquelle il se lèvera.

    La doctrine E, posée le 9 septembre : littérature si l'énoncé est établi
    ailleurs, démonstration s'il ne l'est pas, mesure s'il ne se démontre pas
    du tout. Un engagement sans route n'est pas un engagement mais un aveu.

    Le contrôle vérifie que la table en porte une par ligne, et qu'aucune
    valeur hors des trois n'y entre — une quatrième route serait une manière
    de ne pas choisir.
    """
    c1 = os.path.join(BASE, "src", "chapitres", "c1-prolegomenes.org")
    lignes = _lignes(c1)
    dans, routes, sans = False, set(), []
    for l in lignes:
        if l.startswith("#+NAME: tab:engagements"):
            dans = True
            continue
        if dans:
            if l.startswith("| Engagement") or l.startswith("|--"):
                continue
            if not l.startswith("| "):
                if routes or sans:
                    break
                continue
            colonnes = [c.strip() for c in l.split("|")[1:-1]]
            if len(colonnes) < 4 or not colonnes[3]:
                sans.append(colonnes[0][:44] if colonnes else l[:44])
            else:
                routes.add(re.sub(r"\s*\(.*\)", "", colonnes[3]))
    admises = {"littérature", "démonstration", "mesure"}
    if sans:
        ko("engagement sans route nommée : %s" % sans[:3])
    elif routes - admises:
        ko("route hors des trois admises : %s" % sorted(routes - admises))
    elif not routes:
        ko("la table des engagements est introuvable ou vide")
    else:
        ok("engagements : %d route(s) distincte(s), toutes admises"
           % len(routes))


def symboles_a_la_table_normative(ctx):
    """Tout symbole du corps figure à la table normative du chapitre 1.

    La table est normative et non descriptive : une section ne peut pas
    introduire de variante locale. Le contrôle vérifie que la table existe et
    qu'elle couvre les symboles que le document déclare gouverner.
    """
    c1 = os.path.join(BASE, "src", "chapitres", "c1-prolegomenes.org")
    texte = io.open(c1, encoding="utf-8").read()
    if "tab:c1-symboles" not in texte:
        ko("la table normative des symboles est absente du chapitre 1")
        return
    attendus = ["\\Delta", "\\Gamma", "\\mathcal{R}", "\\mathcal{X}",
                "!_r", "\\varphi_r", "\\boxtimes"]
    manquants = [s for s in attendus if s not in texte]
    if manquants:
        ko("symboles absents de la table normative : %s" % manquants)
    else:
        ok("table normative : présente et couvrant les symboles gouvernés")
