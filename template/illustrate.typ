// Illustrations for theorems and proofs: coloured terms, highlights, boxes,
// short labels with leaders, block matrices, arrow diagrams and small cetz
// drawings, all in the theme's colours so the dark build needs nothing extra.
//
// Not re-exported from lib.typ, because it loads cetz, fletcher and mannot; a
// course that draws such pictures imports it from its symbols.typ:
//
//     #import "/template/illustrate.typ": *
//
// Every name works inside maths. The six hues are blue, red, green, orange,
// purple and gray; within one picture a hue should keep one meaning (say blue
// for the part in U, red for the part in W).
//
//   $cblue(x)$            x in blue ink
//   $hblue(x)$            x on a blue tint, as with a highlighter
//   $bblue(x)$            x in a blue rectangle
//   $cblue(x, tag: #<t>)$ any of these, tagged for a label:
//   #annot(<t>)[in $U$]   a few words under the tagged term, with a leader
//   blocks(...)           a matrix drawn as tinted blocks
//   canvas({...})         a cetz drawing
//   fletcher-diagram(...) an arrow diagram

#import "@preview/cetz:0.4.2" as cetz
#import "@preview/fletcher:0.5.8" as fletcher
#import "@preview/mannot:0.4.0": annot as _annot, mark as _mark, markhl as _markhl, markrect as _markrect
#import "config.typ": colors, is-html

#let draw = cetz.draw
#let node = fletcher.node
#let edge = fletcher.edge

// --------------------------------------------------------------------- colours

/// Ink for text and lines of a hue, readable on the page in either theme.
#let ink(hue) = if hue == "gray" { colors.text-secondary } else { colors.at(hue).strong }
/// The hue's rule colour (its 500 level in both themes).
#let rule(hue) = if hue == "gray" { colors.gray } else { colors.at(hue).base }
/// A fill for the hue, light on the light page and dark on the dark one.
#let tint(hue) = if hue == "gray" { colors.surface-strong } else { colors.at(hue).soft }

// ------------------------------------------------------------- marked terms

/// `body` in the hue's ink; with `tag`, it can carry an `annot`.
// mannot cannot lay out its marks in the HTML export, so there every marker is
// plain coloured ink and `annot` draws nothing.
#let colour(hue, body, tag: none) = if tag == none or is-html {
  text(fill: ink(hue), body)
} else {
  _mark(body, tag: tag, color: ink(hue))
}

/// `body` on the hue's tint. The tint is drawn behind, so the layout is unchanged.
#let highlight-term(hue, body, tag: none) = if is-html { colour(hue, body) } else { _markhl(
  body,
  tag: tag,
  color: ink(hue),
  fill: tint(hue),
  radius: 0.15em,
  outset: (x: 0.08em, y: 0.18em),
) }

/// `body` in a rectangle of the hue.
#let box-term(hue, body, tag: none) = if is-html { colour(hue, body) } else { _markrect(
  body,
  tag: tag,
  color: ink(hue),
  stroke: 0.06em + rule(hue),
  radius: 0.15em,
  outset: (x: 0.12em, y: 0.22em),
) }

#let cblue = colour.with("blue")
#let cred = colour.with("red")
#let cgreen = colour.with("green")
#let corange = colour.with("orange")
#let cpurple = colour.with("purple")
#let cgray = colour.with("gray")

#let hblue = highlight-term.with("blue")
#let hred = highlight-term.with("red")
#let hgreen = highlight-term.with("green")
#let horange = highlight-term.with("orange")
#let hpurple = highlight-term.with("purple")
#let hgray = highlight-term.with("gray")

#let bblue = box-term.with("blue")
#let bred = box-term.with("red")
#let bgreen = box-term.with("green")
#let borange = box-term.with("orange")
#let bpurple = box-term.with("purple")
#let bgray = box-term.with("gray")

/// A few words attached to a tagged term, in the term's colour, with an elbow
/// leader. Use it after the equation that holds the tag, as mannot requires;
/// leave room under (or over) the equation for the label.
#let annot(tag, body, ..args) = if is-html { [] } else { _annot(
  tag,
  // At its natural width: mannot places the label in a zero-width frame.
  context box(width: measure(body).width + 0.01em, body),
  annot-text-props: (size: 0.85em),
  leader-connect: "elbow",
  ..args,
) }

// ------------------------------------------------------------ block matrices

/// One block of `blocks`: `body` centred on the hue's tint, spanning
/// `colspan` columns and `rowspan` rows of the grid. With no hue the block is
/// left blank, as for a zero block.
#let blk(body, hue: none, colspan: 1, rowspan: 1) = grid.cell(
  colspan: colspan,
  rowspan: rowspan,
  fill: if hue == none { none } else { tint(hue) },
  align(center + horizon, if hue == none { body } else { text(fill: ink(hue), body) }),
)

/// A matrix drawn as blocks, in square brackets, centred on the maths axis.
/// `cols` and `rows` are the block widths and heights in units of `unit`; the
/// cells are `blk(...)`s (or plain content), row by row.
///
///     $ #blocks((2, 1), (2, 1), blk($A$, hue: "blue"), blk($B$), blk($0$), blk($C$, hue: "red")) $
#let blocks(cols, rows, ..cells, unit: 1.1em, lines: true) = {
  let g = grid(
    columns: cols.map(c => c * unit),
    rows: rows.map(r => r * unit),
    stroke: if lines { (paint: colors.border-dark, thickness: 0.5pt) } else { none },
    inset: 0pt,
    ..cells.pos().map(c => if type(c) == content and c.func() == grid.cell { c } else { blk(c) }),
  )
  let height = rows.sum() * unit
  math.lr($[#box(g, baseline: 50% - 0.25em)]$, size: height + 0.3em)
}

// ---------------------------------------------------------------- drawings

/// A cetz drawing in the theme's ink, centred. Lines default to the text
/// colour at 0.6pt and content to the body text, so colour only what means
/// something, with `ink(hue)`, `rule(hue)` and `tint(hue)`.
#let canvas(body, length: 1cm, ..args) = {
  let c = cetz.canvas(length: length, ..args, {
    draw.set-style(
      stroke: (paint: colors.text, thickness: 0.6pt),
      fill: none,
      mark: (fill: colors.text, stroke: (paint: colors.text, thickness: 0.6pt)),
      content: (padding: 0.1),
    )
    body
  })
  if is-html { html.frame(c) } else { align(center, c) }
}

/// An arrow diagram (fletcher) in the theme's ink, centred.
#let fletcher-diagram(..args) = {
  let d = fletcher.diagram(
    edge-stroke: colors.text + 0.6pt,
    node-stroke: none,
    ..args,
  )
  if is-html { html.frame(d) } else { align(center, d) }
}
