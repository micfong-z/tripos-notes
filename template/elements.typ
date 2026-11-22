// Page furniture and figure helpers. The PDF branch of each is the design
// system's element; the HTML branch is what the Ponder exporter and the website
// CSS were built against. Every function that renders differently in HTML
// branches on `is-html` at call time, so one definition serves both targets.
// The `typst-*` class names are a contract with the exporter
// (ponder/scripts/document-index.ts, ponder/scripts/html.ts) and the website
// CSS: do not rename them.

#import "micfong/src/elements.typ" as ds
#import "micfong/src/furniture.typ": contents as ds-contents
#import "config.typ": colors, is-html

#let separator = ds.separator

#let fade(content) = if is-html {
  html.span(class: "typst-fade", content)
} else {
  ds.fade(content)
}

/// A faded aside of several paragraphs, set off by a square bracket on each
/// side drawn as tall as the note, in place of a literal `[` and `]` in
/// `fade[[...]]`. The brackets stand on the column's edges and the text is set
/// inside them. Across a page break the open ends carry on, as a long
/// bracket would. In HTML it is also `typst-fade`, so it fades without CSS of
/// its own.
#let fade-block(body) = if is-html {
  html.div(class: "typst-fade typst-fade-block", body)
} else {
  let paint = colors.text-secondary
  // From the text to a bracket's stem, the length of its feet, and how far
  // the bracket reaches above and below the text.
  let gap = 0.6em
  let foot = 0.35em
  let pad = 0.2em
  // Square caps close the corner the stem's butt end leaves open.
  let foot-line = line(length: foot, stroke: (paint: paint, thickness: ds.rule, cap: "square"))
  // Placed content lands in the fragment it sits in, so the top feet go
  // before the body and the bottom feet after it: a note split across pages
  // opens on the first and closes on the last.
  let feet(end) = for side in (left, right) {
    let dx = if side == left { -gap } else { gap }
    let dy = if end == top { -pad } else { pad }
    place(end + side, dx: dx, dy: dy, foot-line)
  }
  block(
    width: 100%,
    breakable: true,
    stroke: (x: ds.rule + paint),
    inset: (x: gap, y: pad),
    ds.fade({
      feet(top)
      body
      feet(bottom)
    }),
  )
}

#let end-of-document() = if is-html { [] } else { ds.end-of-document() }

#let boxed(content) = if is-html {
  html.frame(ds.boxed(content))
} else {
  ds.boxed(content)
}

#let boxed-header(title) = if is-html {
  html.div(class: "typst-boxed-header", text(upper(title)))
} else {
  ds.boxed-header(title)
}

#let lecture-separator(lecture: "", date: "") = if is-html {
  html.div(class: "typst-lecture-separator", [Lecture #lecture · #date])
} else {
  ds.divider[Lecture #lecture · #date]
}

/// `˄ ES1 ──── ES2 ˅`: the sheet above ends, the sheet below begins. The
/// chevrons are drawn rather than typeset, centred on the capitals, with the
/// same 0.75pt pen as the rule.
#let example-sheet-separator(from: "", to: "") = if is-html {
  none
} else {
  let paint = colors.text-secondary
  let arrow(up) = {
    let (top, bottom) = if up { (0em, 0.35em) } else { (0.35em, 0em) }
    box(baseline: -0.175em, height: 0.35em, width: 0.7em, curve(
      stroke: (paint: paint, thickness: ds.rule, cap: "round", join: "round"),
      curve.move((0em, bottom)),
      curve.line((0.35em, top)),
      curve.line((0.7em, bottom)),
    ))
  }
  let sheet(n) = text(fill: paint)[ES\##n]
  block(width: 100%, above: 1.5em, below: 1.5em, grid(
    columns: (auto, 1fr, auto),
    align: horizon,
    column-gutter: 0.75em,
    [#arrow(true)#h(0.35em)#sheet(from)],
    line(length: 100%, stroke: colors.border-dark + ds.rule),
    [#sheet(to)#h(0.35em)#arrow(false)],
  ))
}

#let figure-req(idx) = ds.figure-required(idx)

/// The table of contents. In a series it lists only the volume it appears in;
/// in HTML it is a plain outline, whose title the HTML body rules remove.
#let contents(depth: none) = if is-html { outline(depth: depth) } else { ds-contents(depth: depth) }

/// Inkscape figures are authored in black on white. In the dark theme the SVG
/// source is recoloured on the fly rather than kept as a second asset. Paths are
/// root-absolute, since `read` resolves against this file, not the caller.
#let dynamic-svg(path, width: 2.5cm, height: auto) = ds.recolor-svg(read(path), width: width, height: height)

/// Same idea for full-colour figures: invert, then rotate the hue back.
#let dynamic-svg2(path, width: 2.5cm, height: auto) = ds.invert-svg(
  read(path, encoding: none),
  width: width,
  height: height,
)

#let logic-sym-layout(
  ..stmts,
) = {
  import "micfong/src/maths.typ": mathsec
  [$
    #for stmt in stmts.pos().slice(0, -1) {
      stmt.at(0)
      stmt.at(1)
      mathsec(":")
      mathsec("(")
      stmt.at(2)
      mathsec(")")
      if stmt.at(0) == $forall$ { mathsec($=> ($) } else { mathsec($and ($) }
    }
    #stmts.pos().at(-1)
    #mathsec(")" * (stmts.pos().len() - 1))
  $]
}
