// Identity marks: the wordmark, the per-page Data Matrix and the cover barcode.
//
// A document id such as `D/ACD/UND/NTE/5` is printed on the first page and
// encoded, with the page number, into every page header. The payload format is
// `<doc-id>-<page in hex, zero-padded to 4>`, e.g. `D/ACD/UND/NTE/5-000A`.

#import "@preview/tiaoma:0.3.0"
#import "config.typ": colors, mds-token
#import "fonts.typ": brand, mono

/// `MICFONG ▲`. The triangle is drawn rather than typeset, because Plex's
/// U+25B2 sits well below cap height and would change with the font suite.
#let wordmark(size: 11pt, fill: auto) = {
  let paint = if fill == auto { colors.text } else { fill }
  text(font: brand, size: size, weight: "bold", fill: paint)[
    MICFONG#h(0.35em)#box(polygon(
      fill: paint,
      (0em, 0.7em),
      (0.4em, 0em),
      (0.8em, 0.7em),
    ))
  ]
}

/// `D/ACD/UND/NTE/5` + page 10 -> `D/ACD/UND/NTE/5-000A`.
#let hex-id(doc-id, page-number) = {
  let hex-page = upper(str(page-number, base: 16))
  doc-id + "-" + ("0" * calc.max(0, 4 - hex-page.len())) + hex-page
}

#let page-payload(doc-id, page-number) = hex-id(doc-id, page-number) + if mds-token == none { "" } else { "+" + mds-token }

#let _dm-module = 0.75pt
#let _dm-squares = (
  "10": 3, "12": 5, "14": 8, "16": 12, "18": 18, "20": 22, "22": 30, "24": 36, "26": 44, "32": 62, "36": 86, "40": 114,
  "44": 144, "48": 174, "52": 204, "64": 280, "72": 368, "80": 456, "88": 576, "96": 696, "104": 816, "120": 1050,
  "132": 1304, "144": 1558,
)
#let _dm-rectangles = (
  (rows: 8, cols: 18, capacity: 5, option: 25),
  (rows: 8, cols: 32, capacity: 10, option: 26),
  (rows: 12, cols: 26, capacity: 16, option: 27),
  (rows: 12, cols: 36, capacity: 22, option: 28),
  (rows: 16, cols: 36, capacity: 32, option: 29),
  (rows: 16, cols: 48, capacity: 49, option: 30),
)

#let _dm-auto-size(payload) = {
  let svg = str(tiaoma.zint-wasm.gen_with_options(
    cbor.encode((symbology: "DataMatrix", show-hrt: false, scale: 0.5)),
    bytes(payload),
  ))
  let m = svg.match(regex("<svg width=\"(\\d+)\" height=\"(\\d+)\""))
  (rows: int(m.captures.at(1)), cols: int(m.captures.at(0)))
}

#let _dm-capacity(size) = if size.rows == size.cols { _dm-squares.at(str(size.rows)) } else {
  _dm-rectangles.find(r => r.rows == size.rows and r.cols == size.cols).capacity
}

#let _dm-rectangle(payload) = {
  let needed = _dm-capacity(_dm-auto-size(payload))
  _dm-rectangles.find(r => r.capacity >= needed)
}

// The marks take explicit colours so a cover drawn in another scheme can use them.

#let data-matrix(payload, fg: auto, bg: auto) = {
  let options = (
    fg-color: if fg == auto { colors.text } else { fg },
    bg-color: if bg == auto { colors.page } else { bg },
    show-hrt: false,
    scale: 0.5,
  )
  let suffix = if mds-token == none { none } else { "+" + mds-token }
  if suffix == none or not payload.ends-with(suffix) { return box(tiaoma.data-matrix(payload, options: options)) }
  let size = _dm-rectangle(payload)
  let symbol = tiaoma.data-matrix(payload, options: options + if size == none { (:) } else { (option-2: size.option) })
  let tokenless = _dm-auto-size(payload.slice(0, payload.len() - suffix.len()))
  box(height: tokenless.rows * _dm-module, align(horizon, symbol))
}

#let barcode(payload, fg: auto, bg: auto) = box(tiaoma.code128(
  payload,
  options: (
    fg-color: if fg == auto { colors.text } else { fg },
    bg-color: if bg == auto { colors.page } else { bg },
    show-hrt: false,
    height: 10.0,
    scale: 0.5,
  ),
))

/// The document id as printed beside the barcode.
#let doc-id-label(doc-id, fill: auto) = text(
  size: 11pt,
  weight: "bold",
  font: mono,
  fill: if fill == auto { colors.text-secondary } else { fill },
  doc-id,
)
