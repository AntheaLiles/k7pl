-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "A.8. Lecture du texte et appariement des délimiteurs" =>
%%%
file := "annexe-lecture-du-texte-et-appariement-des-delimiteurs"
tag := "annexe-lecture-du-texte-et-appariement-des-delimiteurs"
number := false
%%%

Ces codes refusent, dès la lecture du texte, des délimiteurs qui ne s'apparient pas, guillemets
d'une chaîne compris. Le lecteur les signale avec la ligne du délimiteur en cause et les
délimiteurs concernés. Après un délimiteur fermant, il ferme le délimiteur ouvert le plus proche de
sa paire, et ceux qui ont été ouverts depuis restent sans fermeture. Une chaîne peut courir sur
plusieurs lignes : celle qui n'est jamais refermée court jusqu'à la fin du texte.

::::k7table (label := "tab:err-delimiteurs") (align := "lZ{1.00}")
:::caption
Codes refusant un texte dont les délimiteurs ne s'apparient pas
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `ERR-DLM-001`
  * Délimiteur ouvrant jamais refermé. Ajouter le délimiteur fermant de sa paire, ou retirer l'ouvrant.
* * `ERR-DLM-002`
  * Délimiteur fermant sans délimiteur ouvrant. Retirer le fermant, ou ajouter l'ouvrant de sa paire.
* * `ERR-DLM-003`
  * Délimiteur fermant d'une autre paire que les délimiteurs encore ouverts. Fermer le dernier délimiteur ouvert par le fermant de sa paire.
* * `ERR-DLM-004`
  * Chaîne jamais refermée : elle court jusqu'à la fin du texte. Ajouter le guillemet fermant.
:::
::::

Un avertissement de lecture ne refuse pas le texte : il signale ce que la lecture a dû supposer.

::::k7table (label := "tab:avertissements-lecture") (align := "lZ{1.00}")
:::caption
Avertissements émis à la lecture du texte
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `WRN-LEX-001`
  * Étiquette de délimiteur qualifié non déclarée : le littéral reste un texte ordinaire, typé par l'étiquette. Déclarer le type de l'étiquette.
:::
::::

Une remarque n'est ni une erreur ni un avertissement : elle signale ce que l'outillage a réécrit.

::::k7table (label := "tab:remarques-lecture") (align := "lZ{1.00}")
:::caption
Remarques émises sur le texte d'un fichier
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `HEY-LEX-001`
  * Glyphe écrit hors d'un texte, réécrit par son mot. S'il était voulu comme caractère, l'écrire dans un texte par son nom LaTeX.
:::
::::
