// General-purpose elements. Everything is drawn with the same few strokes: a
// 0.75pt rule, a left-ruled callout, and a titled panel with a tinted strip.

#import "@preview/grayness:0.5.0": plg
#import "config.typ": colors, is-dark
#import "icons.typ": icon

#let rule = 0.75pt

/// Resolve a colour family by name ("blue") or pass a family dictionary through.
#let _family(accent) = if type(accent) == str { colors.at(accent) } else { accent }

// ------------------------------------------------------------------ inline bits

/// Marks a link the layouts leave without an underline.
#let plain-link-label = <micfong-plain-link>

/// A link without the usual underline, for indexes where a whole row is the
/// link and underlining every cell would be noise.
#let plain-link(dest, body) = [#link(dest, body)#plain-link-label]

/// Secondary text: asides, annotations, metadata.
#let fade(body) = text(fill: colors.text-secondary, body)

/// A keyboard key, or a chord: `kbd("Cmd", "Shift", "P")`.
#let kbd(..keys) = {
  let cap(k) = box(
    fill: colors.surface-strong,
    stroke: rule + colors.border-dark,
    inset: (x: 0.3em),
    outset: (y: 0.2em),
    text(size: 0.85em, weight: "medium", k),
  )
  keys.pos().map(cap).join(text(fill: colors.text-secondary, [#h(0.15em)+#h(0.15em)]))
}

/// A small label, e.g. `badge("beta", accent: "purple")`.
#let badge(body, accent: "gray") = {
  let (fill, paint) = if accent == "gray" {
    (colors.surface-strong, colors.text-secondary)
  } else {
    let f = _family(accent)
    (f.soft, f.strong)
  }
  box(
    fill: fill,
    inset: (x: 0.35em),
    outset: (y: 0.2em),
    text(size: 0.8em, weight: "bold", fill: paint, upper(body)),
  )
}

/// Draw a box around inline content, e.g. a final answer.
#let boxed(body) = box(stroke: colors.text + rule, inset: 0.5em, body)

// ------------------------------------------------------------------- separators

#let separator = line(length: 100%, stroke: colors.border-light + rule)

/// A rule with a label in the middle, e.g. `divider[Lecture 3 · 14 Oct]`.
#let divider(label) = grid(
  columns: (1fr, auto, 1fr),
  align: horizon,
  column-gutter: 1em,
  separator, text(fill: colors.text-secondary, label), separator,
)

/// A full-width boxed caption in capitals, for splitting a page into parts.
#let boxed-header(title) = box(
  stroke: colors.border-dark + rule,
  inset: 0.5em,
  width: 100%,
  align(center, upper(title)),
)

/// `END OF DOCUMENT ■`. The square is drawn rather than typeset, as the
/// wordmark's triangle is: Plex has no U+25A0, so the glyph would come from a
/// fallback face. It spans baseline to cap height, like the capitals beside it.
#let end-of-document() = {
  separator
  align(end, text(weight: 700, fill: colors.text-secondary)[
    END OF DOCUMENT#h(0.35em)#box(square(size: 0.7em, fill: colors.text-secondary))
  ])
}

// --------------------------------------------------------------------- callouts

/// A left-ruled note. `accent` is none for the neutral grey rule (used by
/// proofs), or a colour family whose `base` rules the edge and whose `strong`
/// shade marks the label. An `icon` name puts an MDI glyph before the label.
#let callout(name, accent: none, icon-name: none, label: auto, body) = {
  let family = if accent == none { none } else { _family(accent) }
  let marker = if label == auto { [*#name.*] } else { label }
  if icon-name != none { marker = [#icon(icon-name)#h(0.3em)#marker] }
  if family != none { marker = text(fill: family.strong, marker) }
  block(
    width: 100%,
    stroke: (left: rule + if family == none { colors.gray } else { family.base }),
    inset: (left: 1em, y: 0.5em),
    breakable: true,
    [#marker #body],
  )
}

// GitHub's alert set, in this system's colours.
#let note(body) = callout("Note", accent: "blue", icon-name: "information-outline", body)
#let tip(body) = callout("Tip", accent: "green", icon-name: "lightbulb-on-outline", body)
#let important(body) = callout("Important", accent: "yellow", icon-name: "star-four-points-outline", body)
#let warning(body) = callout("Warning", accent: "orange", icon-name: "alert-outline", body)
#let caution(body) = callout("Caution", accent: "red", icon-name: "alert-octagon-outline", body)

/// A block quotation, `#quote(block: true, attribution: [Name])[...]` or `> `.
#let quote-rules(body) = {
  show quote.where(block: true): it => block(
    width: 100%,
    stroke: (left: rule + colors.border-dark),
    inset: (left: 1em, y: 0.5em),
    breakable: true,
    {
      emph(it.body)
      if it.attribution != none {
        align(end, text(fill: colors.text-secondary)[— #it.attribution])
      }
    },
  )
  body
}

// ------------------------------------------------------------------------ panels

/// A titled panel: a tinted title strip over a body, both ruled on the left in
/// the family's key colour. The theorem environments are built on this.
///
/// A stroke is centred on the block's edge, and children paint over their
/// parent's stroke, so the strips start half a rule in: they meet the rule's
/// inner edge instead of covering half of it.
#let panel(title: none, accent: "orange", footer: none, body) = {
  let f = _family(accent)
  block(
    width: 100%,
    stroke: (left: rule + f.base),
    inset: (left: rule / 2),
    breakable: true,
    {
      if title != none {
        block(
          width: 100%,
          fill: f.soft,
          inset: (x: 1em, y: 0.6em),
          spacing: 0pt,
          sticky: true,
          text(fill: f.strong, title),
        )
      }
      block(width: 100%, inset: 1em, spacing: 0pt, body)
      if footer != none {
        block(width: 100%, fill: f.subtle, inset: (x: 1em, y: 0.6em), spacing: 0pt, footer)
      }
    },
  )
}

// ----------------------------------------------------------------------- figures

/// Black-on-white line art (e.g. Inkscape) drawn white-on-grey in the dark
/// theme. Pass the file's contents, since a package cannot read your files:
///
///     #recolor-svg(read("media/triangle.svg"), width: 4cm)
#let recolor-svg(data, ..args) = {
  let svg = if type(data) == bytes { str(data) } else { data }
  if is-dark {
    svg = svg.replace("#000000", "#ffffff").replace("black", "white").replace("rgb(0%,0%,0%)", "rgb(100%,100%,100%)")
  }
  image(bytes(svg), format: "svg", ..args)
}

/// Full-colour art in the dark theme: invert, then rotate the hue back so the
/// colours keep their identity.
#let invert-svg(data, ..args) = {
  let raw-bytes = if type(data) == str { bytes(data) } else { data }
  if is-dark {
    raw-bytes = plg.svg_huerotate(plg.svg_invert(raw-bytes), float(185).to-bytes(size: 4))
  }
  image(raw-bytes, format: "svg", ..args)
}

/// A placeholder for a figure still to be drawn.
#let figure-required(body) = block(
  width: 100%,
  height: 4em,
  stroke: (paint: colors.border-dark, thickness: rule, dash: "dashed"),
  align(center + horizon, text(weight: "bold", fill: colors.text-secondary)[FIGURE REQUIRED · #body]),
)
