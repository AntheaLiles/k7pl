> **Périmé le 8 septembre.** Remplacé par `REMISE-EMACS-07-09.md` puis par
> `REMISE-EMACS-08-09.md`, qui font foi. Conservé pour la trace des raisons.

# Corrections à porter dans ta configuration Emacs

Établi le 4 septembre 2026, après lecture de `init.el`, `my-export-config.el`,
`my-export-async.el`, `my-paths.el` et `preamble-article.tex`.

**Rien de ce qui suit n'est une hypothèse sur la panne d'export.** Ce sont des défauts
lisibles dans les fichiers, indépendants les uns des autres. Le premier et le deuxième
peuvent être la panne ; les trois autres ne le sont pas mais coûteront un jour.

---

## 1. `my-export-async.el` — `'reversed` n'est pas une option de `org-map-entries`

```elisp
(org-map-entries (lambda () ...) nil nil 'reversed)
```

La signature est `(FUNC &optional MATCH SCOPE &rest SKIP)`. Le quatrième argument
tombe donc dans `SKIP`, et org en fait un `org-agenda-skip-function` :

```elisp
(org-agenda-skip-function (car (org-delete-all '(comment archive) skip)))
```

À chaque titre rencontré, org appelle `(funcall 'reversed)`. **Le parcours inversé
que le commentaire annonce n'a jamais lieu**, et la suppression se fait donc en ordre
croissant — c'est-à-dire avec le décalage de positions que le commentaire dit vouloir
éviter.

**Remplacement :**

```elisp
(defun my/org-export-ignore-headlines (_backend)
  "Remove headlines tagged :ignore: but keep their contents.
Les positions sont RELEVÉES d'abord, puis supprimées en ordre décroissant :
supprimer de la fin vers le début est ce qui évite le décalage."
  (org-with-wide-buffer
   (let (positions)
     (org-map-entries
      (lambda ()
        (when (member "ignore" (org-get-tags nil t))
          (push (point) positions))))
     (dolist (p (sort positions #'>))
       (goto-char p)
       (delete-region (line-beginning-position) (line-beginning-position 2))))))
```

---

## 2. `my-export-async.el` — `engrave-faces-latex` chargé en silence

```elisp
(require 'engrave-faces-latex nil t)
```

Le `t` final rend l'échec **silencieux**, alors que `my-export-config.el` pose
`org-latex-src-block-backend 'engraved`. Si le paquet n'a pas chargé, la transcription
du premier bloc `#+BEGIN_SRC` appelle une fonction inexistante — et c'est exactement
la forme d'erreur qui fait imprimer l'arbre entier dans `*Org Export Process*`.

Le manuscrit porte huit blocs : sept en `k7pl`, un en `mermaid`. Aucun ne porte
d'en-tête babel, donc aucun ne s'exécute ; ils sont seulement colorés.

**Remplacement :**

```elisp
(unless (require 'engrave-faces-latex nil t)
  (message "ATTENTION : engrave-faces-latex absent — bascule sur le rendu verbatim")
  (with-eval-after-load 'ox-latex
    (setopt org-latex-src-block-backend 'verbatim)))
```

Une dégradation annoncée vaut mieux qu'une erreur muette.

---

## 3. `init.el` — `k7pl` n'est pas dans `org-src-lang-modes`

Les entrées existent pour `lean`, `ebnf`, `typescript`, `ocaml`, pas pour `k7pl`.
Sans mode associé, les sept blocs du manuscrit ne sont pas colorés — ce n'est pas
une erreur, c'est une perte silencieuse.

```elisp
(add-to-list 'org-src-lang-modes '("k7pl" . prog))
```

À remplacer par le vrai mode le jour où il existera.

---

## 4. `init.el` — trois `add-to-list` hors du `with-eval-after-load`

```elisp
:config
(with-eval-after-load 'org
  (add-to-list 'org-src-lang-modes '("lean" . lean-ts-mode))
  (add-to-list 'org-src-lang-modes '("ebnf" . ebnf)))
  (add-to-list 'org-src-lang-modes '("typescript" . typescript))   ; <- dehors
  (add-to-list 'org-src-lang-modes '("ocaml" . neocaml))           ; <- dehors
```

La parenthèse fermante du `with-eval-after-load` tombe après `ebnf`. Les deux
dernières lignes s'exécutent hors du bloc différé. Ici c'est sans conséquence — le
`:config` d'org s'exécute de toute façon après le chargement d'org — mais
l'indentation dit le contraire de ce que le code fait, et c'est ainsi qu'une
troisième ligne ajoutée plus tard cassera.

---

## 5. `my-export-config.el` — `my/org-convert-drawio` peut bloquer sans trace

```elisp
(call-process "drawio" nil nil nil "-x" "-f" "pdf" "--crop" "-o" pdf-path drawio-path)
```

`call-process` est **synchrone et sans délai maximal**, et sa destination de sortie
est `nil`, donc tout est jeté. Si `drawio` — qui est un Electron — se bloque sous WSL
faute d'affichage, l'export se bloque avec lui et aucun journal ne le dira.

Tes douze PDF sont à jour à l'instant, donc le convertisseur ne se lance pas
aujourd'hui. Le jour où tu modifieras un diagramme, il se lancera.

**Rendre l'attente visible et bornée :**

```elisp
(message "Conversion de %s..." drawio-file)
(let ((code (call-process "timeout" nil "*drawio*" nil "60"
                          "drawio" "-x" "-f" "pdf" "--crop"
                          "-o" pdf-path drawio-path)))
  (unless (eq code 0)
    (message "ATTENTION : conversion de %s échouée ou expirée (code %s)"
             drawio-file code)))
```

Et le cas symétrique mérite un mot : si `drawio` n'est pas sur le `PATH` du processus
fils, le `(when (executable-find "drawio") ...)` saute **toute** la fonction, les liens
ne sont pas réécrits, et les douze figures sortent en liens textuels sans que rien ne
le signale. Un `(unless (executable-find "drawio") (message "..."))` suffirait.

---

## Ce qui n'est PAS à corriger

`preamble-article.tex` est complet et cohérent : il déclare `theorem`, `statement` et
`proofsketch` par `ntheorem`, `\llbracket` par `unicode-math`, `\orcidlink` à la main,
et charge `amsmath`, `amssymb`, `mathtools`, `multicol`. Je l'ai compilé ici avec les
quarante-quatre théorèmes réels du manuscrit : **41 pages, zéro erreur, aucune boucle.**

La bibliographie n'est pas en cause : `org-cite-export-processors` vaut
`((latex biblatex) (t csl))`, donc le fichier part chez biber, un binaire compilé que
sa taille ne gêne pas.

---

## Ce qui a été corrigé côté manuscrit, en parallèle

**Deux `\eqref` pointaient dans le vide** — `eq:reductions-pures` et `eq:reductions-effets`,
appelés trois fois dans l'esquisse de preuve de la préservation. Les deux cibles existaient
en `#+NAME:`, mais posées sur des blocs `#+BEGIN_EXPORT latex` : **org n'engendre aucun
`\label` pour un bloc export**, il le recopie tel quel. Et le contenu était un `align*`,
donc non numéroté — un `\label` seul n'aurait rien donné non plus.

Les deux blocs sont passés en `equation` enveloppant un `aligned` : un numéro pour le bloc
entier, ce qui est ce que le renvoi demande. Vérifié par deux passes lualatex sur ton vrai
préambule : plus aucune référence non définie du côté des équations.

L'effet sur ta panne est indirect mais réel : `LaTeX Warning: There were undefined
references` **fait relancer latexmk**, et chaque passe lualatex sur cent vingt-trois pages
écrit un journal entier dans `*Org Export Process*`.

Un contrôle a été ajouté à `outils/controle.py` — *tout `\ref` ou `\eqref` doit avoir son
`\label`* — pour que ce défaut ne puisse plus s'installer en silence.

---

## Ordre suggéré

1. Lancer `sh outils/diagnostic-export.sh` — cinq essais, chacun neutralisant un suspect.
   Le premier qui aboutit nomme le coupable ; si aucun n'aboutit, l'essai 0 affiche le
   message d'erreur, qui est ce qui manque depuis le début.
2. Porter les corrections 1 et 2 ci-dessus, qui sont les deux seules susceptibles d'être
   la panne.
3. Les corrections 3, 4 et 5 quand tu voudras : aucune n'est urgente.
