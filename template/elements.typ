// Page furniture and figure helpers. Every function that renders differently in
// HTML branches on `is-html` at call time, so one definition serves both
// targets. The `typst-*` class names are a contract with the exporter
// (ponder/scripts/document-index.ts, ponder/scripts/html.ts) and the website
// CSS: do not rename them.

#import "@preview/grayness:0.5.0": plg
#import "config.typ": colors, is-html
#import "palette.typ": color-palette

#let separator = line(length: 100%, stroke: colors.border-light + 0.75pt)

#let fade(content) = if is-html {
  html.span(class: "typst-fade", content)
} else {
  text(content, fill: colors.text-secondary)
}

#let mathsec(x) = text(fill: colors.text-secondary, $#x$)

#let end-of-document() = if is-html { [] } else {
  [
    #line(length: 100%, stroke: colors.border-light + 0.75pt)
    #align(end, text(weight: 700, fill: colors.text-secondary, "END OF DOCUMENT ■"))
  ]
}

#let boxed(content) = if is-html {
  html.frame(box(stroke: colors.text + 0.75pt, inset: 0.5em, content))
} else {
  box(stroke: colors.text + 0.75pt, inset: 0.5em, content)
}

#let boxed-header(title) = if is-html {
  html.div(class: "typst-boxed-header", text(upper(title)))
} else {
  box(
    stroke: colors.border-dark + 0.75pt,
    inset: 0.5em,
    width: 100%,
    align(center, text()[#upper(title)]),
  )
}

#let lecture-separator(lecture: "", date: "") = if is-html {
  html.div(class: "typst-lecture-separator", [Lecture #lecture · #date])
} else {
  grid(
    columns: (1fr, auto, 1fr),
    align: horizon,
    column-gutter: 1em,
    separator, text(fill: colors.text-secondary)[Lecture #lecture · #date], separator,
  )
}

#let figure-req(idx) = box(fill: white, inset: 2pt, text(fill: black)[*FIGURE #idx REQUIRED*])

/// Inkscape figures are authored in black on white. In the dark theme the SVG
/// source is recoloured on the fly rather than kept as a second asset.
#let dynamic-svg(path, width: 2.5cm, height: auto) = if colors == color-palette.dark [
  #image(
    bytes(
      read(path)
        .replace("#000000", "#ffffff")
        .replace("black", "white")
        .replace("rgb(0%,0%,0%)", "rgb(100%,100%,100%)"),
    ),
    width: width,
    height: height,
  )
] else [
  #image(bytes(read(path)), width: width, height: height)
]

/// Same idea for full-colour figures: invert, then rotate the hue back.
#let dynamic-svg2(path, width: 2.5cm, height: auto) = if colors == color-palette.dark [
  #let img = read(path, encoding: none)
  #let img2 = plg.svg_invert(img)
  #let img3 = plg.svg_huerotate(img2, float(185).to-bytes(size: 4))
  #image(img3, width: width, height: height)
] else [
  #image(bytes(read(path)), width: width, height: height)
]

#let logic-sym-layout(
  ..stmts,
) = {
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
