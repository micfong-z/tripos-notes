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
