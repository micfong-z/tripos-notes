// Pieces shared by every cover: the title block, the frame, and the helpers
// that format identity fields. Each takes a colour-token set `c`, so a cover
// can be drawn in another scheme than the document's.

#import "config.typ": colors
#import "elements.typ": rule

#let lines(t) = if type(t) == str { t.split("\n").join(linebreak()) } else { t }
#let plain(t) = if type(t) == str { t.replace("\n", " ") } else { t }

/// Named date formats. Anything else is used as a Typst format string.
#let date-formats = (
  iso: "[year]-[month]-[day]", // 2026-09-27
  compact: "[year][month][day]", // 20260927
  long: "[day padding:none] [month repr:long] [year]", // 27 September 2026
)

#let format-date(d, format: "iso") = if type(d) == datetime {
  d.display(date-formats.at(format, default: format))
} else { d }

/// Title and subtitle on the left, metadata on the right; the first metadata
/// line is bold.
#let title-block(id, c: colors) = grid(
  columns: (1fr, auto),
  column-gutter: 2em,
  {
    set text(size: 1.75em, weight: 700)
    set par(leading: 0.45em)
    block(below: 0.6em, lines(id.title))
    if id.subtitle != none {
      block(above: 0.6em, text(fill: c.text-secondary, lines(id.subtitle)))
    }
  },
  align(right, {
    for (i, line) in id.meta.enumerate() {
      if i > 0 { linebreak() }
      if i == 0 { strong(line) } else { line }
    }
  }),
)

/// The cover's signature diagonal, bottom left to top right.
#let diagonal(c: colors, paint: auto) = place(line(
  start: (1em, 100% - 1em),
  end: (100% - 1em, 1em),
  stroke: (if paint == auto { c.border-light } else { paint }) + rule,
))

/// The cover frame. `art` is auto for the diagonal, none for an empty frame,
/// or content that fills the frame edge to edge (e.g. an image with
/// `width: 100%, height: 100%, fit: "cover"`). Art starts half a rule in, at
/// the stroke's inner edge, so a fill never paints over the frame.
#let frame(art, inset: 0pt, c: colors) = block(
  width: 100%,
  height: 1fr,
  stroke: c.border-light + rule,
  inset: inset + rule / 2,
  clip: true,
  if art == auto { diagonal(c: c) } else { art },
)
