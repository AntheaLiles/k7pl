#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Contrôle de passe K7PL — lecture seule, sur le document assemblé.

    python3 outils/controle.py <version>
    ex.   python3 outils/controle.py 66

Depuis que la source porte [cite:@CLÉ] et qu'org-cite engendre la
bibliographie, trois des contrôles historiques n'ont plus d'objet : la
conformité R2, la séquence de la bibliographie et la table de correspondance.
Ils ne sont pas abandonnés — ils sont devenus impossibles à violer, la source
ne portant plus de numéro.

Ce qui reste, et qui ne se déduit d'aucune mécanique :
  — les sondes sémantiques, qui vérifient qu'un passage cite le bon auteur.
    Elles sont désormais exactes plutôt qu'approchées : elles lisent la clé,
    non un numéro dont il faudrait retrouver l'attribution ;
  — l'intégrité des renvois par étiquettes nommées ;
  — la non-régression bibliographique, contre le gel de v64 ;
  — les comptages de structure et la pagination.

Sort 0 si tout passe, 1 sinon.
"""
import io, os, re, sys, json, unicodedata
from collections import Counter

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from controles.journal import ko, ok, echecs
SPEC = os.path.join(BASE, "build", "K7_Specification-v%s.org")
CHANT = os.path.join(BASE, "build", "K7_TODO_LIST-v%s.org")
THEO = os.path.join(BASE, "build", "K7_Theorisation-v%s.org")
# org-cite admet la citation MULTIPLE — [cite:@a;@b;@c]. La forme simple était seule
# reconnue, si bien qu'une citation multiple n'était vue par AUCUN contrôle : ni comptée,
# ni vérifiée contre le fonds. Un trou silencieux vaut moins qu'un échec bruyant.
# Trouvé le 2 septembre en citant les trois clés de la spécification WebAssembly.
CITE = r'@([A-Za-z0-9_.:+\-]+)(?=[;\]])'
def norm_texte(s):
    """Ancrage des sondes : balisage org retiré, ponctuation typographique repliée,
    pour qu'une mise en italique ne désancre pas une sonde (É-13)."""
    s = unicodedata.normalize("NFKD", s)
    s = "".join(c for c in s if not unicodedata.combining(c))
    s = re.sub(r'[/=~*_]', '', s)
    s = s.replace("\u2019", "'").replace("\u2018", "'")
    s = re.sub(r'[\u00ab\u00bb\u201c\u201d]', '', s)
    s = re.sub(r'[\u2013\u2014\u2212]', '-', s)
    return re.sub(r'\s+', ' ', s.lower())


def dernier_assemblage():
    """Rend le numéro du dernier assemblage écrit, ou None s'il n'y en a aucun.

    Le numéro de version n'est ni le temps ni un compteur fiable : v335 date du
    2 septembre, v230 du 28 août. On prend donc le plus RÉCENT sur disque, pas
    le plus grand."""
    import glob as _g
    fichiers = _g.glob(SPEC % "*")
    if not fichiers:
        return None
    recent = max(fichiers, key=os.path.getmtime)
    return re.search(r"-v([^.]+)\.org$", recent).group(1)


def verifier_fraicheur(v):
    """Refuse de contrôler un assemblage plus vieux que la source la plus récente.

    Motif, écrit le 8 septembre. `make controle` portait V ?= 230, dont le build
    datait du 28 août quand les sources dataient du 8 septembre. Vingt-deux des
    trente contrôles lisaient ce fichier : onze jours de travail hors du champ,
    et un « tous les contrôles passent » qui ne voulait plus rien dire.

    Un avertissement s'apprendrait à ignorer. C'est donc un refus."""
    import glob as _g
    build = SPEC % v
    if not os.path.exists(build):
        print("    ECHEC  assemblage introuvable : %s" % build)
        print("           lancer d'abord : python3 outils/construire.py %s" % v)
        sys.exit(2)
    sources = _g.glob(os.path.join(BASE, "src", "*.org")) \
        + _g.glob(os.path.join(BASE, "src", "chapitres", "*.org"))
    if not sources:
        return
    plus_recente = max(sources, key=os.path.getmtime)
    if os.path.getmtime(plus_recente) > os.path.getmtime(build):
        import datetime as _d
        fmt = lambda p: _d.datetime.fromtimestamp(
            os.path.getmtime(p)).strftime("%d/%m %H:%M")
        print("=" * 74)
        print("CONTROLE REFUSÉ — l'assemblage est plus vieux que la source")
        print("=" * 74)
        print("    source la plus récente : %-40s %s"
              % (os.path.relpath(plus_recente, BASE), fmt(plus_recente)))
        print("    assemblage v%-11s %-40s %s"
              % (v, os.path.relpath(build, BASE), fmt(build)))
        print("")
        print("    Contrôler un assemblage périmé rend un verdict sur un document")
        print("    qui n'existe plus. Assembler d'abord :")
        print("")
        print("        python3 outils/construire.py %s && python3 outils/controle.py %s"
              % (v, v))
        sys.exit(2)


def controler(v):
    verifier_fraicheur(v)
    corps = io.open(SPEC % v, encoding="utf-8").read()
    # Le suivi est en deux morceaux depuis le 5 août — ce qui est vif dans
    # chantier/, l'arc clos dans theorisation/. Les comptages portent sur la
    # RÉUNION : une séquence d'entrées T ne doit pas paraître trouée du seul
    # fait qu'on a rangé les closes ailleurs.
    suivi = (io.open(CHANT % v, encoding="utf-8").read()
             + "\n" + io.open(THEO % v, encoding="utf-8").read())
    t = corps + suivi
    bib = io.open(os.path.join(BASE, "bib", "K7PL-Biblio",
                              "refs-pour-citations.bib"), encoding="utf-8").read()
    fonds = set(re.findall(r'^@\w+\{([^,]+),', bib, re.M))
    dec = json.load(io.open(os.path.join(BASE, "bib", "decisions-bibliographiques.json"),
                            encoding="utf-8"))["maintenues_sans_citation"]

    print("=" * 74); print("CONTROLE v%s" % v); print("=" * 74)

    ctx = {"corps": corps, "suivi": suivi, "t": t, "bib": bib, "fonds": fonds, "dec": dec, "v": v}
    from controles import citations as _citations
    from controles import structure as _structure
    from controles import source as _source
    from controles import figures as _figures
    from controles import glossaire as _glossaire
    from controles import semantique as _semantique
    from controles import notation as _notation
    _citations.citations(ctx)
    _citations.non_regression_bibliographique(ctx)
    _citations.lisibilite_des_citations(ctx)
    _citations.analyse_des_cles_citees(ctx)
    _structure.renvois(ctx)
    _structure.objets_et_renvois(ctx)
    _structure.comptages(ctx)
    _structure.coherence_plan_org_questions_org(ctx)
    _structure.croisement_manques_questions(ctx)
    _structure.renvois_et_etiquettes_latex(ctx)
    _structure.renvois_vers_un_bloc_export(ctx)
    _structure.pagination(ctx)
    _source.marqueurs_de_bloc_export(ctx)
    _source.citations_hors_des_blocs_export(ctx)
    _source.pile_de_mots_cles_affilies(ctx)
    _source.liens_de_fichier_avant_et_apres_inclusion(ctx)
    _source.toc_locales_et_bibliographies_par_partie(ctx)
    _source.mots_cles_personnels_en_tete(ctx)
    _source.hygiene_org(ctx)
    _figures.tables_bornees_a_la_largeur_d_impression(ctx)
    _figures.legendes_et_textes_de_remplacement(ctx)
    _glossaire.sigles_et_glossaire(ctx)
    _glossaire.table_des_glyphes(ctx)
    _semantique.sondes_semantiques(ctx)
    _semantique.croisement_g_2_g_3(ctx)
    _semantique.vocabulaire_de_l_axiome(ctx)
    _notation.contexte_du_jugement(ctx)
    _notation.un_glyphe_par_modalite(ctx)
    _notation.affirmations_sur_le_hachage(ctx)
    _notation.grades_et_tailles_distingues(ctx)
    _notation.symboles_a_la_table_normative(ctx)
    _notation.sceau_des_enonces(ctx)
    _notation.mentions_propagees(ctx)
    _notation.route_de_chaque_engagement(ctx)
    _notation.familles_de_flottants_listees(ctx)
    from controles import algebre as _algebre
    _algebre.loi_d_action_aux_bornes(ctx)
    _algebre.action_sur_la_composition_parallele(ctx)
    _algebre.conventions_de_l_infini_ecrites(ctx)
    _algebre.clause_laisse_habitable(ctx)

if __name__ == "__main__":
    # Défaut : le dernier assemblage écrit, jamais un numéro figé. Un numéro
    # explicite reste accepté.
    if len(sys.argv) > 1:
        controler(sys.argv[1])
    else:
        v = dernier_assemblage()
        if v is None:
            print("    ECHEC  aucun assemblage dans build/")
            print("           lancer : python3 outils/construire.py")
            sys.exit(2)
        controler(v)
    print("\n" + "=" * 74)
    if echecs:
        print("%d ECHEC(S)" % len(echecs)); sys.exit(1)
    print("TOUS LES CONTROLES PASSENT")
