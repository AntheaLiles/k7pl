<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 24 : la loi distributive, écrite

`PREUVE-05` / `STRUCT-20` : `λ_{r,ε}` écrite avec φ_n(ε) = ε^n ; unité, composition (y compris ω) et
naturalité vérifiées (`thm:loi_distributive_conditions`). **Constat nouveau** : la compatibilité avec la
multiplication de la monade exigerait que φ_n soit un morphisme de monoïde, ce qui est faux dans une
quantale non commutative ((εδ)^n ≠ ε^n δ^n). Les règles n'emploient pas cette condition ; la loi est
donc *affaiblie*. Réponse naturelle pour la décision sur la forme de la loi : garder la loi affaiblie,
écrire la condition sur une partie commutative pour toute extension qui en aurait besoin.

`PREUVE-06` / `STRUCT-21` : monade graduée indexée dans le cas clos, `thm:substitution_indices`.
