# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Checks on the specification, reading the Verso sources (`spec/`).

Ported from the checks of the former Org tooling (`archives/outillage-org/`). Run them all with
`python3 scripts/controle.py`; each module is one family of questions:

* `algebre`    — laws of the algebra at the absorbing elements, size sorts, the conventions of ω;
* `notation`   — one symbol per object, status seals, propagation of open statements;
* `croise`     — the grammar of terms against the typing rules, and the counts the prose states;
* `structure`  — appendix letters, tables, comments, hand-written counts, unique labels.
"""
