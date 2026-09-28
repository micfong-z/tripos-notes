// Code: the syntax theme, block and inline styling, and the `code` wrapper.
//
// The syntax theme is generated from the palette as a TextMate theme, so it
// follows `--input theme` without a second file to keep in sync.

#import "config.typ": colors, fonts
#import "fonts.typ": mono, reset
#import "icons.typ": icon

#let _rule = 0.75pt

#let _tm-rule(scope, paint, style: none) = {
  let settings = if paint == none { "" } else { "<key>foreground</key><string>" + paint.to-hex() + "</string>" }
  if style != none { settings += "<key>fontStyle</key><string>" + style + "</string>" }
  "<dict><key>scope</key><string>" + scope + "</string><key>settings</key><dict>" + settings + "</dict></dict>"
}

/// A TextMate theme built from the active colour tokens.
#let syntax-theme = {
  let s = colors.syntax
  let rules = (
    _tm-rule("comment, punctuation.definition.comment", s.gray, style: "italic"),
    _tm-rule("string, punctuation.definition.string, string.regexp", s.green),
    _tm-rule("constant.numeric, constant.language, constant.character, constant.other, support.constant", s.orange),
    _tm-rule("keyword, storage, storage.type, storage.modifier, keyword.control", s.purple),
    _tm-rule("keyword.operator, punctuation", colors.text),
    _tm-rule("entity.name.function, support.function, meta.function-call.generic, variable.function", s.blue),
    _tm-rule("entity.name.type, entity.name.class, entity.name.struct, entity.name.enum, support.type, support.class, entity.other.inherited-class", s.yellow),
    _tm-rule("variable.parameter, entity.name.tag, entity.other.attribute-name, variable.language, markup.deleted, invalid", s.red),
    _tm-rule("markup.heading, markup.bold", none, style: "bold"),
    _tm-rule("markup.italic", none, style: "italic"),
    _tm-rule("markup.inserted", s.green),
    _tm-rule("markup.raw, markup.inline.raw", s.orange),
    _tm-rule("markup.underline.link", s.blue),
  )
  bytes(
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
      + "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">"
      + "<plist version=\"1.0\"><dict><key>name</key><string>Micfong</string><key>settings</key><array>"
      + "<dict><key>settings</key><dict><key>foreground</key><string>"
      + colors.text.to-hex()
      + "</string></dict></dict>"
      + rules.join()
      + "</array></dict></plist>",
  )
}

// Code is bracketed rather than boxed, as on micfong.space: inline code sits
// between thin square brackets, and a block between a top and a bottom rule
// whose ends turn inwards. Nothing is filled, so code reads the same on any
// ground.

#let _stroke = (paint: colors.border-dark, thickness: _rule, cap: "square")
#let _tick = 0.45em // length of the turned-in ends
#let _edge-height = 1em // a block edge is this tall, with its rule at mid-height
#let _label-inset = 0.9em // labels sit this far in from the ends
#let _label-gap = 0.45em // and this much rule is cleared either side of them

/// The top or bottom edge of a code block: a rule whose ends turn towards the
/// code, broken to make room for a label at either end.
#let _edge(top: true, start-label: none, end-label: none) = context {
  let y = _edge-height / 2
  let turn = if top { _tick } else { -_tick }
  let cuts = ()
  if start-label != none {
    let w = measure(start-label).width
    cuts.push((_label-inset - _label-gap, _label-inset + w + _label-gap))
  }
  if end-label != none {
    let w = measure(end-label).width
    cuts.push((100% - _label-inset - w - _label-gap, 100% - _label-inset + _label-gap))
  }
  block(width: 100%, height: _edge-height, spacing: 0pt, sticky: top, {
    let from = 0%
    for (a, b) in cuts {
      place(line(start: (from, y), end: (a, y), stroke: _stroke))
      from = b
    }
    place(line(start: (from, y), end: (100%, y), stroke: _stroke))
    for x in (0%, 100%) { place(line(start: (x, y), end: (x, y + turn), stroke: _stroke)) }
    if start-label != none { place(left + horizon, dx: _label-inset, start-label) }
    if end-label != none { place(right + horizon, dx: -_label-inset, end-label) }
  })
}

/// Render a block of raw text between bracket edges. A title (file name) and
/// the language label sit in the top edge; line numbers fill the gutter.
#let render-code(it, title: none, numbers: true) = {
  let lang = if it.lang != none and it.lang != "" {
    text(size: 0.8em, weight: "bold", fill: colors.text-secondary, upper(it.lang))
  }
  let title = if title != none {
    text(size: 0.8em, fill: colors.text-secondary)[#text(fill: colors.text, weight: "bold", title)]
  }
  let body = if numbers and it.lines.len() > 1 {
    grid(
      columns: (auto, 1fr),
      column-gutter: 1.2em,
      row-gutter: 0.65em, // Typst's default leading, as unnumbered raw uses
      align: (right, left),
      ..it
        .lines
        .map(l => (
          text(fill: colors.text-secondary, str(l.number)),
          // A zero-width space keeps a blank line from collapsing to nothing.
          l.body + sym.zws,
        ))
        .flatten(),
    )
  } else {
    it.lines.map(l => l.body).join(linebreak())
  }
  block(width: 100%, spacing: 1.2em, breakable: true, {
    _edge(top: true, start-label: title, end-label: lang)
    block(width: 100%, inset: (x: 0.8em, top: 0.3em, bottom: 0.4em), spacing: 0pt, breakable: true, {
      set align(start)
      body
    })
    _edge(top: false)
  })
}

// JetBrains Mono's regular `[` and `]`, traced from the vendored font: points
// in em, x from the left of the 0.6em cell, y up from the baseline. Drawing the
// outlines, rather than typing the characters, keeps the brackets out of text
// selection and copying in every viewer, as `user-select: none` does on the
// website. Retrace them if the mono face changes.
#let _bracket-points = (
  open: ((0.205, -0.11), (0.205, 0.83), (0.45, 0.83), (0.45, 0.75), (0.295, 0.75), (0.295, -0.03), (0.45, -0.03), (0.45, -0.11)),
  close: ((0.15, -0.11), (0.15, -0.03), (0.305, -0.03), (0.305, 0.75), (0.15, 0.75), (0.15, 0.83), (0.395, 0.83), (0.395, -0.11)),
)

#let _bracket(kind) = pdf.artifact(box(
  width: 0.6em,
  height: 0.94em,
  baseline: 0.11em,
  place(polygon(
    fill: colors.border-dark,
    ..(_bracket-points.at(kind).map(((x, y)) => (x * 1em, (0.83 - y) * 1em))),
  )),
))

/// Inline code between brackets, as on micfong.space.
#let render-inline-code(it) = text(size: 0.9em / 0.8)[#_bracket("open")#sym.wj#it#sym.wj#_bracket("close")]

/// Code rules, applied once by the layouts.
#let code-rules(line-numbers: true, body) = {
  set raw(theme: syntax-theme)
  show raw: set text(font: mono, features: reset(fonts.body-features))
  show raw.where(block: true): set text(size: 0.9em / 0.8)
  show raw.where(block: true): it => render-code(it, numbers: line-numbers)
  show raw.where(block: false): render-inline-code
  body
}

/// A code block with a file name in its top edge, or with different numbering
/// from the document default:
///
///     #code(title: "main.rs")[```rust
///     fn main() {}
///     ```]
#let code(title: none, numbers: true, body) = {
  show raw.where(block: true): it => render-code(it, title: title, numbers: numbers)
  body
}
