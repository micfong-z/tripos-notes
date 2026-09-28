// Series cover styles, chosen with `series(cover-style: ..., cover-accent: ...)`.
//
//   frame      the book cover's frame and diagonal, with the volume index on top;
//              with an accent, the whole cover sits on that colour
//   smear      the frame's layout over a dark ground of downward-smeared streaks
//              in the accent family
//   drafting   a drawing sheet filling the page, the identity only in its title
//              block, with the parts list beside it; `cover-corner` places both
//
// Like the frame, the drafting sheet draws nothing that carries no information:
// the accent angles register its corners, and the parts list and title block
// hold everything else, once each.
//
// A style is four parts: the tokens its page is drawn in, a full-page
// background, the header and footer marks, and the body. Furniture draws the
// first three on the series' first page; `cover-body` draws the last.

#import "config.typ": colors
#import "palette.typ": palette
#import "fonts.typ": mono
#import "elements.typ": plain-link, rule
#import "identity.typ": barcode, data-matrix, doc-id-label, hex-id, wordmark
#import "covers.typ": diagonal, frame, lines, plain, title-block

#let volume-label = <micfong-volume>

#let cover-styles = ("frame", "smear", "drafting")

/// The accent a style uses when none is given: frame stays in the page's own
/// colours; smear and the drafting corner angles are orange.
#let default-accent(style) = if style == "frame" { none } else { "orange" }

/// Tokens for a page on a coloured ground.
#let _ground(page, text, secondary, light, dark) = colors + (
  page: page,
  text: text,
  text-secondary: secondary,
  border-light: light,
  border-dark: dark,
  surface: page,
  surface-strong: page,
)

/// The tokens a style's page is drawn in. An accent on `frame` puts the cover
/// on that family's key colour with black type; on `smear` it colours the
/// streaks; on `drafting` it colours only the corner angles.
#let cover-tokens(style, accent) = {
  if accent == none or style == "drafting" { return colors }
  let f = palette.at(accent)
  if style == "frame" {
    _ground(f.at("500"), palette.gray.at("1000"), f.at("900"), f.at("700"), f.at("800"))
  } else {
    _ground(f.at("950"), palette.gray.at("0"), f.at("300"), f.at("700"), f.at("600"))
  }
}

/// The volumes, one row each: numeral, title, doc id and starting page. Every
/// cell links to the volume's first page.
#let volume-index(c: colors) = context {
  let row(i, v) = {
    let info = v.value
    (
      text(size: 2em, weight: 500, fill: c.text-secondary, "#" + str(i + 1)),
      {
        strong(lines(info.title))
        if info.subtitle != none { [\ #text(fill: c.text-secondary, lines(info.subtitle))] }
      },
      align(right, {
        if info.doc-id != none { text(font: mono, size: 0.9em, weight: "bold", fill: c.text-secondary, info.doc-id) }
        [\ Page #v.location().page()]
      }),
    ).map(cell => plain-link(v.location(), cell))
  }
  grid(
    columns: (auto, 1fr, auto),
    inset: (x: 0.6em, y: 0.9em),
    align: (left + horizon, left + horizon, right + horizon),
    stroke: (_, y) => if y > 0 { (top: rule + c.border-light) },
    ..query(volume-label).enumerate().map(((i, v)) => row(i, v)).flatten(),
  )
}

/// The index on a page-coloured panel, over the diagonal that carries on below.
#let _index-panel(c, index) = block(
  width: 100%,
  fill: c.page,
  stroke: (bottom: rule + c.border-light),
  inset: (x: 0.9em, top: 0.3em, bottom: 0.6em),
  index,
)

// ---------------------------------------------------------------- the smear

// A tiny linear congruential generator, so a seed always draws the same cover.
#let _lcg(s) = calc.rem(s * 1103515245 + 12345, 2147483648)

/// The picture being smeared: low-frequency smoke with two glowing arcs across
/// the lower middle of the page. u and v run from 0 to 1 across the page.
#let _smear-source(u, v) = {
  let smoke = (
    0.20
      + 0.13 * calc.sin(u * 7.1 + 1.3) * calc.cos(v * 5.3 + 0.4)
      + 0.08 * calc.sin((u + 1.7 * v) * 11.0)
      + 0.06 * calc.cos((2.3 * u - v) * 17.0)
  )
  let d1 = (v - (0.50 + 0.14 * calc.sin(u * 3.46 + 0.3))) / 0.018
  let d2 = (v - (0.63 + 0.09 * calc.cos(u * 5.03))) / 0.011
  smoke + 0.85 * calc.exp(-d1 * d1) + 0.45 * calc.exp(-d2 * d2)
}

/// Thin columns cut into pieces, each piece filled with the source colour from
/// a little higher up the same column: long calm streaks at the top, short
/// broken ones at the bottom.
#let _smear(family, seed: 11, column: 1.2) = layout(size => {
  let (w, h) = (size.width / 1mm, size.height / 1mm)
  let ramp = gradient.linear(..("1000", "950", "900", "800", "700", "600", "500", "300", "100").map(l => family.at(l)))
  let s = seed
  let pieces = ()
  let x = 0.0
  while x < w {
    let y = 0.0
    while y < h {
      s = _lcg(s)
      let r1 = s / 2147483648
      s = _lcg(s)
      let r2 = s / 2147483648
      s = _lcg(s)
      let r3 = s / 2147483648
      let p = y / h
      let length = (2.5 + 55 * calc.pow(1 - p, 1.6)) * (0.3 + 0.9 * r1)
      let lift = 28 * r2 * (1 - 0.5 * p)
      let b = _smear-source(x / w, calc.max(0, y - lift) / h)
      if r3 < 0.10 + 0.35 * p { b *= 0.25 }
      // Quieter behind the header and the title block.
      b *= 0.4 + 0.6 * calc.min(1, calc.max(0, (p - 0.15) / 0.32))
      pieces.push(place(top + left, dx: x * 1mm, dy: y * 1mm, rect(
        width: (column + 0.08) * 1mm,
        height: length * 1mm,
        fill: ramp.sample(calc.clamp(b, 0, 1) * 100%),
      )))
      y += length
    }
    x += column
  }
  // A box the size of the page, since `layout` itself has no height to align to.
  box(width: size.width, height: size.height, fill: family.at("950"), pieces.join())
})

// ------------------------------------------------------------- the drafting sheet

#let _inset = 6mm // from the sheet's border to its tables

/// Angles on the sheet's corners, drawn over its border.
#let _corner-marks(paint, arm: 5mm) = {
  let s = (paint: paint, thickness: 1.2pt, cap: "square", join: "miter")
  let mark(sx, sy) = curve(stroke: s, curve.move((0mm, sy * arm)), curve.line((0mm, 0mm)), curve.line((sx * arm, 0mm)))
  place(top + left, mark(1, 1))
  place(top + right, mark(-1, 1))
  place(bottom + left, mark(1, -1))
  place(bottom + right, mark(-1, -1))
}

#let _drafting-label(t, c) = text(font: mono, size: 6.5pt, weight: "bold", tracking: 0.06em, fill: c.text-secondary, upper(t))

/// The volumes as a parts list: number, title, doc id and starting page, with
/// its sides closed so it joins the title block as one table.
#let _parts-list(c) = context {
  let volumes = query(volume-label)
  let edge = rule + c.border-dark
  grid(
    columns: (auto, 1fr, auto, auto),
    inset: (x: 0.6em, y: 0.55em),
    stroke: (x, y) => (
      top: rule + if y <= 1 { c.border-dark } else { c.border-light },
      bottom: if y == volumes.len() { edge },
      left: if x == 0 { edge },
      right: if x == 3 { edge },
    ),
    fill: c.page,
    align: (left, left, left, right),
    _drafting-label("#", c), _drafting-label("Title", c), _drafting-label("Doc ID", c), _drafting-label("Page", c),
    ..volumes
      .enumerate()
      .map(((i, v)) => (
        text(font: mono, str(i + 1)),
        strong(plain(v.value.title)),
        text(font: mono, size: 0.9em, fill: c.text-secondary, if v.value.doc-id == none { "—" } else { v.value.doc-id }),
        text(font: mono, str(v.location().page())),
      ).map(cell => plain-link(v.location(), cell)))
      .flatten(),
  )
}

/// The drawing's title block: the series' identity, each field once.
#let _title-block-table(id, c) = {
  let cell(label, value, span: 1) = grid.cell(colspan: span, [#_drafting-label(label, c)\ #value])
  let fields = ()
  if id.show-authors and id.authors.len() > 0 { fields.push(("Author", id.authors.join(", "))) }
  if id.date-text != none { fields.push(("Date", id.date-text)) }
  if id.version-text != none { fields.push(("Version", id.version-text)) }
  let cells = fields.map(((l, v)) => cell(l, v))
  if calc.odd(cells.len()) { cells.at(-1) = cell(..fields.last(), span: 2) }

  let title = cell("Series", span: 2, {
    text(size: 1.3em, weight: 700, lines(id.title))
    if id.subtitle != none { [\ #text(fill: c.text-secondary, lines(id.subtitle))] }
    for note in id.info { [\ #text(size: 0.9em, fill: c.text-secondary, note)] }
  })
  grid(columns: (1fr, 1fr), inset: 0.55em, stroke: rule + c.border-dark, fill: c.page, align: left, title, ..cells)
}

/// The title block and the parts list as one table, in a corner of the sheet.
/// The parts list faces the middle of the page: below the title block in the
/// top left, above it in the bottom right (as on an engineering drawing).
#let _tables(id, c, corner) = box(width: 64%, if corner == "top-left" {
  stack(_title-block-table(id, c), _parts-list(c))
} else {
  stack(_parts-list(c), _title-block-table(id, c))
})

/// A drawing sheet of the given size: the frame and its diagonal, the tables in
/// the chosen corner, and the corner angles over the frame.
#let _sheet(width, height, id, c, paint, corner) = {
  assert(corner in ("top-left", "bottom-right"), message: "cover-corner must be top-left or bottom-right")
  let where = if corner == "top-left" { top + left } else { bottom + right }
  box(width: width, height: height, {
    place(top + left, rect(width: width, height: height, stroke: c.border-light + rule))
    place(top + left, line(start: (1em, height - 1em), end: (width - 1em, 1em), stroke: c.border-light + rule))
    place(top + left, box(width: width, height: height, inset: _inset, align(where, _tables(id, c, corner))))
    _corner-marks(paint)
  })
}

// ----------------------------------------------------------------- public parts

/// Full-page artwork behind the series' first page.
#let cover-background(info) = {
  let (style, accent) = (info.cover-style, info.cover-accent)
  if style == "frame" and accent != none {
    rect(width: 100%, height: 100%, fill: cover-tokens(style, accent).page)
  } else if style == "smear" {
    _smear(palette.at(accent))
  }
}

#let cover-header(info) = {
  let c = cover-tokens(info.cover-style, info.cover-accent)
  let code = if info.codes and info.doc-id != none {
    data-matrix(hex-id(info.doc-id, 1), fg: c.text, bg: c.page)
  }
  let mark = if info.wordmark == auto { wordmark(fill: c.text) } else { info.wordmark }
  grid(columns: (auto, 1fr), align: (left + horizon, right + horizon), code, mark)
  line(length: 100%, stroke: c.border-light + rule)
}

#let cover-footer(info) = {
  if info.doc-id == none { return }
  let c = cover-tokens(info.cover-style, info.cover-accent)
  if info.codes { barcode(info.doc-id, fg: c.text, bg: c.page) }
  h(1fr)
  doc-id-label(info.doc-id, fill: c.text-secondary)
}

/// The cover's own content, in the page's body area.
#let cover-body(id, style: "frame", accent: none, corner: "top-left", cover: auto) = {
  assert(style in cover-styles, message: "cover-style must be one of " + cover-styles.join(", "))
  let c = cover-tokens(style, accent)
  set text(fill: c.text)

  if style == "drafting" {
    let paint = if accent == none { colors.brand } else { palette.at(accent).at("500") }
    block(width: 100%, height: 1fr, layout(size => _sheet(size.width, size.height, id, c, paint, corner)))
  } else {
    title-block(id, c: c)
    frame(if cover == auto { diagonal(c: c) + _index-panel(c, volume-index(c: c)) } else { cover }, c: c)
  }
}
