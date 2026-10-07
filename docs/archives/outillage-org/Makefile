# K7PL — refonte du 28 août 2026.
#
#   make tout             assemble puis contrôle — le geste ordinaire
#   make construire       assemble src/main.org vers build/
#   make controle         contrôle le dernier assemblage
#   make mesure           mesure la prose contre la charte
#   make pdf              relève ce que le PDF composé montre
#   make corpus           registre du fonds et classement par arc
#   make filtres          éprouve les filtres d'export hors d'Emacs
#   make plan             où en est le projet        (meta/plan.org)
#   make questions        ce qu'il reste à instruire (meta/questions.org)
#   make carte            où se trouve quoi
#
# V n'est plus figé. Sans argument, controle prend le DERNIER assemblage écrit
# et refuse de tourner s'il est plus vieux que la source — c'est le défaut du
# 8 septembre, où V ?= 230 faisait contrôler un document du 28 août.
# Pour viser un assemblage nommé : make controle V=231

V ?=

.PHONY: plan questions carte construire controle mesure pdf corpus filtres index tout

tout: construire controle

construire:
	@python3 outils/construire.py $(V)

controle:
	@python3 outils/controle.py $(V)

mesure:
	@python3 outils/mesure.py

pdf:
	@python3 outils/pdf.py

corpus:
	@python3 outils/corpus.py

filtres:
	@python3 outils/filtres.py

index: corpus

plan:
	@sed -n '/^\* OÙ NOUS EN SOMMES/,/^\* CE QUI BLOQUE QUOI/p' meta/plan.org

questions:
	@grep -cE '^\s+- \*/Q' meta/questions.org | xargs -I{} echo "{} questions dans meta/questions.org"
	@grep -E '^\* ARC ' meta/questions.org

carte:
	@echo "src/       LE DOCUMENT — main.org, chapitres/, annexes K7_*.org"
	@echo "bib/       refs.bib (ce qui est CITÉ) · K7PL-Biblio/ (ce qui est LISIBLE) · décisions"
	@echo "meta/      CE QUI GOUVERNE LE TRAVAIL"
	@echo "             plan.org        l'état, l'ordre, ce qui bloque quoi"
	@echo "             questions.org   224 questions de recherche, par arc"
	@echo "             corpus.org      ce qu'on peut lire, et dans quel ordre"
	@echo "             protocole.org   comment on travaille, et ce qui a été payé cher"
	@echo "             primitives.org  T-68 — la liste des primitives et son dossier"
	@echo "             *.drawio *.pdf  les figures"
	@echo "outils/    construire · controle (+controles/) · mesure · pdf · corpus · filtres"
	@echo "build/     les versions assemblées"
	@echo "OLD/       L ARCHIVE — chantier et théorisation clos, corpus fusionné, scripts de passe"
	@echo ""
	@echo "L archive reste CONTRÔLÉE : entrées T et G comptées, désignations vérifiées."
