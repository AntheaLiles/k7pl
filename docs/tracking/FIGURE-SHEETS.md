<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Figure sheets

**Status:** OPEN. Findings listed for the owner; nothing in `spec/` was changed to produce this file.
**Snapshot:** `main` at `7d522ab` (2026-10-20).
**Nature:** tracking register (item 30). One sheet per figure of the specification: what the TikZ
source draws, compared with the caption, the alt text, the long description and the text around the
figure.

## How the sheets were made

- **Read from the TikZ source, not from a rendered image.** Each sheet transcribes the nodes and
  arrows of `spec/figures/tikz/<source>.tex`, the twelve sources listed in
  [`spec/figures/tikz/manifest.json`](../../spec/figures/tikz/manifest.json). No SVG or PDF was opened. Positions
  ("left", "below", "loop") are read from the coordinates and the `positioning` keys of the source;
  what a reader sees after rendering (overlaps, legibility, colour) was not checked.
- Labels are copied as written in the source: TeX math is kept as written (`$\Delta_{\omega}$`), a
  `\\` line break is shown as ` / `, `\_` as `_`, and `---` as `—`.
- The caption (`:::caption`), the alt text (`alt :=`), the long description (`:::desc`) and the note
  (`:::note`) come from the `::::figure` block in `spec/`. Line numbers are those of the snapshot.
- **Cited text.** Only `fig:comp-process` is cited by `{num}` (C6 `LeProcessusDeCompilation.lean:27`).
  The other eleven figures are placed in the text without a reference; for them, "adjacent text" is
  the paragraph before and after the block, plus the passages elsewhere that describe the same
  object, found by searching the labels drawn. Each sheet names the passages it used.
- **Rule applied.** Owner's decision 51 (2026-10-19, [`DECISIONS.md`](DECISIONS.md)): « le dessin fait
  toujours foi et l'alt-text doit correspondre au dessin ». The decision covers the alt text. It does
  not authorise changes to captions, descriptions or body text: the findings below are listed for the
  owner, not applied.
- **Kinds of finding.** *Mismatch*: the drawing and a text say different things. *Omission*: one of
  them shows or states something the other leaves out, without contradiction (only omissions that a
  reader could notice are listed). *Interpretation*: the finding depends on a reading that the text
  does not settle; it is marked as such and is a question, not a verdict.

## Alt texts fixed in `59c5493`: verification

Commit `59c5493` rewrote four alt texts to match the drawings. Each was compared again with its TikZ
source on the snapshot:

| Figure | Alt text now says | Drawing | Verdict |
|---|---|---|---|
| `fig:dualite-algebre-coalgebre` | dotted double arrow; `in` and `out` are isomorphisms | `link` style is `{Stealth[length=2mm]}-{Stealth[length=2mm]}, dotted`; labels `$\mathrm{in} : F(\mu F) \cong \mu F$`, `$\mathrm{out} : \nu F \cong F(\nu F)$` | matches |
| `fig:session-dualite` | two horizontal arrows, `Send(Int)` A→B then `Send(Bool)` B→A; a note spanning both lifelines | arrows at y = −14 mm (A→B) and y = −24 mm (B→A); note 92 mm wide across both lifelines | matches |
| `fig:rexp-complexite` | chain of three classes, left to right, two arrows | `right=of` chain `@linear` → `@polynomial` → `@stack` | matches |
| `fig:acteur-cycle-de-vie` | an initial point leads to `Désactivé` | `\draw[transition] (start) -- (off)` | matches |

The caption of `fig:circuit-breaker`, changed in `379d53c` to « rejet avant réveil de la fibrille »,
now matches the drawing (`Fibrille de l'acteur`). The other eight alt texts were also compared: none
contradicts its drawing (details in each sheet).

## Summary

| # | Label | Source | Block | Alt vs drawing | Findings |
|--:|---|---|---|---|---|
| 1 | `fig:comp-process` | `compilation-pipeline.tex` | C6 `LeProcessusDeCompilation.lean:47` | matches | FS-01 (mismatch), FS-02 (acknowledged by the text) |
| 2 | `fig:session-automate` | `session-protocol.tex` | C3 `LesContraintesDeValeur.lean:140` | matches | FS-03 (interpretation) |
| 3 | `fig:modalites-structurelles` | `structural-modes.tex` | C3 `LeSystemeGradue.lean:315` | matches | none |
| 4 | `fig:specialisation-couches` | `specialisation-du-jugement.tex` | C1 `AxiomatiqueGerminale.lean:824` | matches | FS-04 (omission), FS-05 (mismatch) |
| 5 | `fig:dualite-algebre-coalgebre` | `co-algebra-duality.tex` | C2 `AlgebresCoalgebresEtPointsFixes.lean:458` | matches | FS-06 (interpretation) |
| 6 | `fig:fragments-emboites` | `fragments-nestings.tex` | C2 `ComonadeExponentielleEtFragments.lean:681` | matches | FS-07 (interpretation) |
| 7 | `fig:session-dualite` | `session-protocol-as-dual-exchange.tex` | C3 `LesContraintesDeValeur.lean:339` | matches | FS-08 (placement) |
| 8 | `fig:rexp-complexite` | `rexp-hierarchy-complexity.tex` | C4 `EchelleLocale.lean:162` | matches | FS-09 (mismatch), FS-10 (mismatch), FS-11 (interpretation) |
| 9 | `fig:arene-partition` | `soa-partitionning.tex` | C4 `EchelleDeLActeur.lean:113` | matches | FS-12 (omission) |
| 10 | `fig:acteur-cycle-de-vie` | `virtual-actor-lca.tex` | C4 `EchelleDuSysteme.lean:65` | matches | none |
| 11 | `fig:circuit-breaker` | `session-circuit-breaker.tex` | C4 `EchelleDuSysteme.lean:647` | matches | FS-13 (mismatch), FS-14 (interpretation), FS-15 (placement) |
| 12 | `fig:cycle-reactif` | `unidirectionnal-reactive-cycle.tex` | C7 `EtudeDeCasIArchitectureReactiveNative.lean:37` | matches | FS-16 (mismatch) |

Paths in the sheets are relative to `spec/Spec/` unless they start with `spec/`.

## Sheets

### 1. `fig:comp-process` — compilation pipeline

Source `spec/figures/tikz/compilation-pipeline.tex`; block C6 `LeProcessusDeCompilation.lean:47-56`,
cited at `:27`.

**Drawing.** Ten boxes in two rows.
- Top row, left to right: `Phase 1 : Parse`, `Phase 1.5 : ConfigAnalysis`, `Phase 2 : TypeCheck`,
  `Phase 2.5 : Résolution`, `Phase 3 : PurityCheck`.
- Bottom row, right to left, the first box below `PurityCheck`: `Phase 4 : TermProof`,
  `Phase 5 : ConstraintSolve`, `Phase 6 : Optimize`, `Phase 7 : CodeGen`, `Phase 8 : Link`.
- Nine unlabelled arrows: each top box to the next; `PurityCheck` down to `TermProof`; each bottom box
  to the next, ending at `Link`. No loop, no branch.

**Caption** « Les huit phases du pipeline de compilation ». **Alt** « Pipeline en serpentin : huit
phases principales et deux étapes intercalaires, lues en aller-retour. » **Desc** (`:53-54`) ten steps
in a serpentine, top row left to right, down to TermProof, bottom row right to left to Link.
Caption, alt and desc agree with the drawing; `:32` explains why ten boxes are counted as eight phases.

**Text used.** `:24-36`, `:58-64`, `:66-77`, `:97`, `:146-153`; Phase 1.5 in C3
`LesContraintesDeValeur.lean:292-293, 301, 326, 332-334`, C4 `EchelleDuSysteme.lean:347, 355`, C7
`EtudeDeCasIIIMoteurDeductifSurArenes.lean:34`.

**Findings.**
- **FS-01 (mismatch).** `LeProcessusDeCompilation.lean:33-34` names the two intermediate steps « la
  vérification d'acyclicité en 1.5, la résolution de configuration en 2.5 ». The drawing labels them
  `Phase 1.5 : ConfigAnalysis` and `Phase 2.5 : Résolution`, and has no box for an acyclicity check.
  The prose at `:58-64` describes a configuration pass right after parsing (« Une passe de
  configuration lui succède aussitôt »), which is where the drawing puts `ConfigAnalysis`; the
  passages in C3, C4 and C7 listed above put the acyclicity check (topological sort, `ERR-ARC-001`)
  in Phase 1.5. Question for the owner: what is step 1.5 and what is step 2.5, and should the
  sentence at `:33-34` or the drawing change?
- **FS-02 (acknowledged by the text).** The drawing has one forward arrow from `Phase 5 :
  ConstraintSolve` to `Phase 6 : Optimize`. `:146-153` says the correct conduct is to iterate these
  two phases until stabilisation, and adds « Ce que la suite linéaire décrit n'est donc pas le modèle
  défendu, et l'écart se referme par un énoncé plutôt que par une figure » (see also `:24`). The text
  states the gap itself; recorded so that it is not mistaken for an oversight.
- *Not a finding.* `:97` names « Une phase d'élaboration »; no box carries that name. The text does not
  say which box it is, and this sheet does not guess.

### 2. `fig:session-automate` — session protocol as an automaton

Source `spec/figures/tikz/session-protocol.tex`; block C3 `LesContraintesDeValeur.lean:140-153`; not
cited by `{num}`.

**Drawing.**
- Nodes, left to right: a filled black initial point; box `EXPECT_INT`; box `EXPECT_BOOL`; a final
  state drawn as a double circle with a small filled violet disc inside.
- Arrows: initial point → `EXPECT_INT` (unlabelled); `EXPECT_INT` → `EXPECT_BOOL` labelled
  `send(Int)`; `EXPECT_BOOL` → final state labelled `recv(Bool)`.

**Caption** « Un protocole de session comme automate à états ». **Alt** « Automate de session avec un
état initial, EXPECT_INT, EXPECT_BOOL et un état final en double cercle. » **Desc** (`:146-147`) gives
the same nodes and both transition labels. **Note** (`:151`) « L'automate représenté est celui du
protocole `Send(Int, Recv(Bool, End))`. » All agree with the drawing; the alt omits the two transition
labels and the inner disc of the final state (omission only).

**Text used.** `:129-138` (typestate; a session type is « le même automate » triggered by messages),
`:155-159` (duality). Both are consistent with the drawing.

**Findings.**
- **FS-03 (interpretation).** The state left by `send(Int)` is named `EXPECT_INT`, and the state left by
  `recv(Bool)` is named `EXPECT_BOOL`. For the endpoint whose protocol is `Send(Int, Recv(Bool, End))`
  the first state is the one that *sends* the integer. No text says whether `EXPECT_` means "expects
  to send" or "expects to receive". Question for the owner: is the naming intended?

### 3. `fig:modalites-structurelles` — contraction and weakening

Source `spec/figures/tikz/structural-modes.tex`; block C3 `LeSystemeGradue.lean:315-324`; not cited by
`{num}`.

**Drawing.** A 2 × 2 grid, no arrows.
- Columns, labels below: left `Contraction interdite`, right `Contraction admise`.
- Rows, labels at the left, rotated: top `Affaiblissement admis`, bottom `Affaiblissement interdit`.
- Cells: top left `Aff (couche 2)` with a black point labelled `Aff`; top right `Unr (couche 3)` with a
  point labelled `Unr`; bottom left `Lin (couche 1)` with a point labelled `Lin`; bottom right `non
  instancié par K7PL`, no point.

**Caption** « Contraction et affaiblissement, trois modalités sur quatre combinaisons possibles ».
**Alt** « Matrice 2 x 2 des autorisations de contraction et d'affaiblissement pour Lin, Aff, Unr et le
cas non instancié. » **Desc** (`:321-322`) matches the axes and the points. The alt omits the layer
numbers drawn in each cell (omission only).

**Text used.** `:326-329`: the fourth combination, contraction without weakening (relevant logic), is
not instantiated. It matches the empty bottom-right cell.

**Findings.** None.

### 4. `fig:specialisation-couches` — specialisation of the germinal judgement

Source `spec/figures/tikz/specialisation-du-jugement.tex`; block C1 `AxiomatiqueGerminale.lean:824-833`;
not cited by `{num}`.

**Drawing.**
- Top box: `Jugement germinal / $\Delta \vdash_{G} t : A \mid E$`.
- Three boxes below, left to right:
  `Couche 3 — $\Delta = \Delta_{\omega}$ / $E = \varnothing$`;
  `Couche 2 — $\Delta = \Delta_{\text{aff}}$ / $E$ actif, tick`;
  `Couche 1 — $\Delta = \Delta_{\text{lin}}$ / $G \ni{}$ budget, $E \ni{}$ tick`.
- Three unlabelled arrows from the top box to each lower box.

**Caption** « Spécialisation du jugement germinal en trois instances de couche ». **Alt** an
« Arbre à trois branches » from the germinal judgement to the three layer instances, with the contents
of the three boxes. **Desc** (`:830-831`) the judgement and its three specialisations side by side.
The alt agrees with the drawing.

**Text used.** `:780-822` (the three equations `eq:instance-L3`, `eq:instance-L2`, `eq:instance-L1`),
`:835-845`.

**Findings.**
- **FS-04 (omission).** `eq:instance-L3` (`:796`) and `:790-791` restrict the grade carrier in layer 3
  to `\mathcal{G}_{\text{pile}}`; the layer-3 box shows no grade constraint. `eq:instance-L2`
  (`:807`) has `\Delta_{\text{aff}} \neq \emptyset`; the layer-2 box does not show it.
- **FS-05 (mismatch).** The layer-1 box writes `$G \ni{}$ budget`, a membership. `eq:instance-L1`
  (`:819`) writes `\mathcal{G} = \mathcal{G}_{\text{budget}}`, and `:837-838` says
  « $`\mathcal{G}_{\text{pile}}` et $`\mathcal{G}_{\text{budget}}` sont deux sous-domaines de
  $`\mathcal{G}`, non deux valeurs ». Read literally, the drawing's notation names a value, which the
  text rules out. The alt follows the drawing (« budget dans le grade »).
- *Other observation, outside decision 51.* The alt is written without accents and reads « couche 3
  ou le contexte est omega »: « ou » ("or") stands for « où » ("where"); a screen reader will say "or".

### 5. `fig:dualite-algebre-coalgebre` — initial algebra and terminal coalgebra

Source `spec/figures/tikz/co-algebra-duality.tex`; block C2 `AlgebresCoalgebresEtPointsFixes.lean:458-467`;
not cited by `{num}`.

**Drawing.**
- Left frame titled `Catégorie $C$`, containing the box `$\mu F$ — algèbre initiale /
  $\mathrm{in} : F(\mu F) \cong \mu F$ / fonde la terminaison`.
- Right frame titled `Catégorie $C^{op}$`, containing the box `$\nu F$ — coalgèbre terminale /
  $\mathrm{out} : \nu F \cong F(\nu F)$ / fonde la productivité`.
- One dotted double-headed arrow between the two boxes, labelled `même construction, / lue dans la
  catégorie opposée`.

**Caption** « Dualité algèbre initiale / coalgèbre terminale, dans C et C^op ». **Alt** (rewritten in
`59c5493`) matches the drawing (see the verification table). **Desc** (`:464-465`) termination and
productivity as one property read in two dual categories.

**Text used.** `:429-456`, in particular `:450-456`.

**Findings.**
- **FS-06 (interpretation; for the owner or the formal reviewer).** `:450-453` says « une
  $`F`-algèbre dans _C_ est une $`F^{\text{op}}`-coalgèbre dans $`\mathcal{C}^{\text{op}}` — la même
  paire $`(A, \alpha)` [...] — et l'initialité dans _C_ correspond à la terminalité dans
  $`\mathcal{C}^{\text{op}}` ». On that reading, what sits in `C^{op}` opposite `(\mu F, \mathrm{in})`
  is the same pair seen as an `F^{op}`-coalgebra. The drawing instead puts `\nu F`, with
  `\mathrm{out} : \nu F \cong F(\nu F)` written with `F`, inside the frame `Catégorie $C^{op}$`, and
  the caption repeats « dans C et C^op ». Whether the right-hand frame, the box, or the sentence is
  meant differently is a mathematical question; this sheet records the difference and does not
  decide it.

### 6. `fig:fragments-emboites` — nested fragments

Source `spec/figures/tikz/fragments-nestings.tex`; block C2 `ComonadeExponentielleEtFragments.lean:681-690`;
not cited by `{num}`.

**Drawing.** Three nested rectangles, no arrows: outer `Fragment cartésien : affaiblissement et
contraction`; inside it `Fragment affine : affaiblissement seul`; innermost box `Fragment linéaire
strict : ni l'un ni l'autre`.

**Caption** « Emboîtement des trois fragments logiques par restriction successive des règles
structurelles ». **Alt** « Trois cadres emboites, du plus large au plus etroit » with the same three
fragments and their rules: matches (written without accents). **Desc** (`:687-688`) three successive
restrictions of one construction.

**Text used.** `:662-679` (modes versus usage intervals), `:692-702`.

**Findings.**
- **FS-07 (interpretation).** The drawing and the caption show the nesting as given. The surrounding
  text treats the inclusions between fragments as still to be established: « Ce constat structurel ne
  suffit pas à prouver que le jugement de typage K7PL réalise effectivement ces permissions » (`:675`),
  « Les formules $`F_{1 \to 2}` et $`F_{2 \to 3}` restent des objectifs de la construction » and « La
  simple inclusion des ensembles $`U_m` n'établit aucune de ces propriétés » (`:694-697`). Question for
  the owner: is the figure meant to show the order of the structural rules (which the text states), or
  the inclusion functors (which the text marks as objectives)? If the latter, the caption or the desc
  could say so.

### 7. `fig:session-dualite` — the protocol as a dual exchange

Source `spec/figures/tikz/session-protocol-as-dual-exchange.tex`; block C3 `LesContraintesDeValeur.lean:339-348`;
not cited by `{num}`.

**Drawing.** A sequence diagram.
- Two lifelines, each with its head box repeated at the bottom: left `Extrémité A : / Send(Int,
  Recv(Bool, / End))`; right `Extrémité B : / Recv(Int, Send(Bool, / End))`.
- Arrows, top to bottom: `Send(Int)` from A to B; `Send(Bool)` from B to A.
- A note across both lifelines: `End — les deux extrémités se terminent ensemble`.

**Caption** « Le même protocole, lu comme échange dual entre deux extrémités ». **Alt** (rewritten in
`59c5493`) matches the drawing; it does not mention the repeated head boxes (omission only). **Desc**
(`:345-346`) « Le protocole précédent vu depuis ses deux bouts ».

**Text used.** `:155-159` (« à un `Send(T,P)` correspond nécessairement un `Recv(T,P^⊥)` du côté
opposé »), consistent with endpoint B; `:331-337`, the paragraph just before the block.

**Findings.**
- **FS-08 (placement).** The paragraph just before the block (`:331-337`) is about deadlock freedom
  and Phase 1.5; it does not discuss duality. The duality is explained at `:155-159`, next to
  `fig:session-automate`, which the desc calls « Le protocole précédent ». Question for the owner:
  should the figure sit nearer `:155-159`, or be cited from there?

### 8. `fig:rexp-complexite` — complexity of R-expressions

Source `spec/figures/tikz/rexp-hierarchy-complexity.tex`; block C4 `EchelleLocale.lean:162-171`; not
cited by `{num}`.

**Drawing.** Three boxes, left to right: `@linear — DFA / O(n) ; O(1)/bloc`; `@polynomial — NFA`;
`@stack — PDA / profondeur bornée par un grade`. Two unlabelled arrows: `@linear` → `@polynomial` →
`@stack`.

**Caption** « Hiérarchie de complexité des R-expressions ». **Alt** (rewritten in `59c5493`) matches the
drawing. **Desc** (`:168-169`) « Les trois classes de complexité qu'une R-expression peut atteindre, et
l'automate qui répond à chacune. »

**Text used.** `:29-52` (the annotations), the table `tab:classes-motifs` (`:59-96`), `:149-160`.

**Findings.**
- **FS-09 (mismatch).** `:31-35` defines four annotations: `@linear`, `@polynomial`, `@stack` and
  `@backtrack`, the last « seul exponentiel ». The drawing has no `@backtrack` box, and the desc says
  an R-expression can reach « trois classes ».
- **FS-10 (mismatch between two objects of the same section).** The table `tab:classes-motifs`
  (`:59-96`) lists `@linear`, `@stack` and `@backtrack`, and no `@polynomial`; the figure lists
  `@linear`, `@polynomial` and `@stack`, and no `@backtrack`.
- **FS-11 (interpretation).** The two arrows are unlabelled and no text says what they mean (inclusion
  of the recognised classes, growing cost, or another order). `:33` says `@stack` analysis is
  polynomial, so the chain is not ordered by running time alone.

### 9. `fig:arene-partition` — partition of an SoA arena

Source `spec/figures/tikz/soa-partitionning.tex`; block C4 `EchelleDeLActeur.lean:113-121`; not cited by
`{num}`.

**Drawing.** A frame titled `Arène SoA — un seul bloc contigu` containing two boxes: `Segment 0..k /
WriteCap fibrille A` and `Segment k+1..2k / WriteCap fibrille B`, joined by a plain line without
arrowhead.

**Caption** « Partitionnement statique d'une arène SoA entre fibrilles concurrentes (SWMR) ». **Alt**
« Une arene SoA figuree comme un seul bloc contigu, coupee en deux segments » with the two segments and
their two `WriteCap`: matches (written without accents; « a » stands for « à »). **Desc** (`:119`) what
a disjointness proof becomes in memory.

**Text used.** `:88-111`; `:105-107` gives `WriteCap(Arena<T>, Range(0,k))` and
`WriteCap(Arena<T>, Range(k+1,2k))`, consistent with the drawing.

**Findings.**
- **FS-12 (omission).** The caption says « (SWMR) », expanded in `Refs/ListeDesAcronymes.lean:190-192`
  as « Single Writer, Multiple Readers ». The drawing shows one writer per segment and no reader, and
  the paragraph `:104-111` mentions only `WriteCap`. The "multiple readers" half has no counterpart
  in the drawing or the adjacent text.

### 10. `fig:acteur-cycle-de-vie` — life cycle of a virtual actor

Source `spec/figures/tikz/virtual-actor-lca.tex`; block C4 `EchelleDuSysteme.lean:65-74`; not cited by
`{num}`.

**Drawing.**
- Nodes: a filled black initial point; box `Désactivé`; box `Actif`.
- Arrows: initial point → `Désactivé` (unlabelled); `Désactivé` → `Actif` above, labelled `activation /
  (charge l'instantané, rejoue le journal)`; `Actif` → `Désactivé` below, labelled `inactivité / (gèle
  l'état, persiste, libère la mémoire)`; a loop on `Actif` labelled `traitement de message`.

**Caption** « Cycle de vie d'un acteur virtuel ». **Alt** (rewritten in `59c5493`) matches the drawing.
**Desc** (`:71-72`) two states and the two transitions between them, « dont la reprise de coalgèbre à
l'activation »; the loop and the initial arrow are not counted, which is not a contradiction.

**Text used.** `:58-63`, `:76-82`. `:62-63` adds that the orchestrator « relâche le handler » after
replaying the log; the activation label does not say it (omission only).

**Findings.** None.

### 11. `fig:circuit-breaker` — session circuit breaker

Source `spec/figures/tikz/session-circuit-breaker.tex`; block C4 `EchelleDuSysteme.lean:647-656`; not
cited by `{num}`.

**Drawing.** A sequence diagram.
- Three lifelines, each with its head box repeated at the bottom: `Pair distant`, `Runtime L1`,
  `Fibrille de l'acteur`.
- Arrow `Message (tag d'état)` from `Pair distant` to `Runtime L1`.
- A dotted `alt` frame with two cases. Guard `[Tag conforme au protocole attendu]`: arrow `Réveil et
  traitement` from `Runtime L1` to `Fibrille de l'acteur`. Guard `[Tag non conforme]`: dashed arrow
  `Rejet (circuit breaker) — zéro coût pour F` from `Runtime L1` back to `Pair distant`.

**Caption** « Le circuit breaker de session : rejet avant réveil de la fibrille » (since `379d53c`).
**Alt** « Diagramme de sequence a trois lignes de vie » with the same lifelines, message and two cases;
it matches the drawing (written without accents). **Desc** (`:653-654`) what is decided before the
fibrille is woken, and what the rejection costs it.

**Text used.** `:527-533`, `:549-553`; the glossary entry « circuit breaker de session »
(`Refs/ListeDesGlosses.lean:96-99`); C3 `LesContraintesDeValeur.lean:203-205, 231-233`.

**Findings.**
- **FS-13 (mismatch).** `:549-552` says the message is rejected « avant même que la fibre de l'acteur ne
  soit réveillée ». The drawing says `Fibrille de l'acteur`, as do the caption (fixed in `379d53c`),
  the desc and the glossary. The commit message of `379d53c` records the owner's statement of
  2026-10-20 that fibre, fibrille and cofibrille are distinct notions. The body text still says
  « fibre ». PR #263 changes it to « fibrille » under that statement; this finding closes when
  it merges.
- **FS-14 (interpretation).** The rejection label says `zéro coût pour F`; `F` is not defined in
  the drawing, the caption or the desc. The alt reads it as the fibrille (« a cout nul pour elle »).
  The text (`:552-553`) gives the cost of a desynchronisation as « une lecture de tag, une comparaison
  entière et un échange de pointeur », without naming `F`. The drawing also sends the rejection back
  to `Pair distant` as a reply; the text says only « le message est rejeté » and does not say whether
  the peer is told.
- **FS-15 (placement).** The block follows the FFI revocation requirement (`:611-645`); the paragraph
  that describes the circuit breaker is `:549-553`, about a hundred lines earlier.

### 12. `fig:cycle-reactif` — unidirectional reactive cycle

Source `spec/figures/tikz/unidirectionnal-reactive-cycle.tex`; block C7
`EtudeDeCasIArchitectureReactiveNative.lean:37-46`; not cited by `{num}`.

**Drawing.**
- Six boxes on a loop: `Événement — L1`, `Flux FRP — L2`, `Nouvel état — L2`, `X-expression — L2`,
  `Diffing — L3`, `Liste de patches — L1`.
- Six unlabelled arrows: `Événement` → `Flux FRP` → `Nouvel état` → `X-expression` → `Diffing` →
  `Liste de patches` → `Événement`.

**Caption** « Le cycle réactif unidirectionnel à travers les trois couches ». **Alt** « Cycle ferme a
six etapes traversant les trois couches » with the six steps and their layers: matches (written
without accents; « ferme » stands for « fermé »). **Desc** (`:43-44`) the path of an event through the
three layers and the point where it closes the cycle.

**Text used.** `:24-35`, `:48-79`.

**Findings.**
- **FS-16 (mismatch).** The drawing closes the loop with an arrow from `Liste de patches — L1` back to
  `Événement — L1`. The text describes a chain that ends when the patch vector « redescend enfin en
  couche 1, où il est appliqué au DOM réel » (`:62-63`); it does not say that the patch list leads to
  the next event, and the application to the DOM has no box. Question for the owner: what does the
  closing arrow stand for?
- *Wording, not a contradiction.* The text says « vecteur de correctifs » (`:55`, `:62`), the drawing
  `Liste de patches`. The text says the new state is « purement représenté comme une X-expression »
  (`:50-51`); the drawing has two successive boxes, `Nouvel état` then `X-expression`.

## Out of scope

- `spec/figures/services-lsp.svg` and `services-lsp.pdf` are not declared by any `::::figure` block and
  have no TikZ source; their fate is question (5) of the « TikZ en production » row of
  [`DECISIONS.md`](DECISIONS.md).
- Four alt texts are written without accents (`fig:fragments-emboites`, `fig:arene-partition`,
  `fig:circuit-breaker`, `fig:cycle-reactif`) and one mostly without (`fig:specialisation-couches`).
  This is a matter of spelling, not of agreement with the drawing; it is listed so that the owner can
  decide whether it falls under decision 51.

## Remaining actions

| Action | Owner | Status |
|---|---|---|
| Decide FS-01, FS-05, FS-09, FS-10 and FS-16 (text or drawing to change) | owner | HUMAN ACTION REQUIRED |
| Close FS-13 (text changed by PR #263) | owner merges PR #263 | PREPARED |
| Answer the interpretation questions FS-03, FS-06, FS-07, FS-11 and FS-14 | owner (FS-06: with the formal reviewer) | HUMAN ACTION REQUIRED |
| Decide the placement questions FS-08 and FS-15, and the omissions FS-04 and FS-12 | owner | HUMAN ACTION REQUIRED |
| Check the rendered SVG and PDF of each figure against these sheets | maintainer | FUTURE |
