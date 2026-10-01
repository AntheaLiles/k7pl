# -*- coding: utf-8 -*-
"""Le journal des verdicts, partagé par tous les contrôles.

POURQUOI CE MODULE EXISTE, et il vaut d'être dit. Au découpage du 8 septembre,
chaque module de `controles/` importait `ko` et `ok` depuis `controle.py`.
Lancé en `__main__`, `controle.py` est chargé DEUX FOIS par Python : une fois
comme `__main__`, une fois comme module `controle` pour satisfaire l'import.
Chaque copie porte alors sa propre liste `echecs`, et les échecs relevés par
les modules atterrissaient dans la copie que personne ne lisait.

Le symptôme est le pire qui soit : les ECHEC s'impriment, et le verdict final
annonce « TOUS LES CONTROLES PASSENT ». Un contrôle qui échoue sans être
compté est plus dangereux qu'un contrôle absent.

Une seule liste, dans un module qui n'est jamais un point d'entrée, et le
problème ne peut pas se reposer.
"""

echecs = []


def ko(m):
    """Consigne un échec et l'imprime. Le code de sortie s'en déduit."""
    echecs.append(m)
    print("    ECHEC  " + m)


def ok(m):
    """Imprime un verdict favorable. N'entre pas au journal."""
    print("    ok     " + m)
