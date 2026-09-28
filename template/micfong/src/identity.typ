// Identity marks: the wordmark, the per-page Data Matrix and the cover barcode.
//
// A document id such as `D/ACD/UND/NTE/5` is printed on the first page and
// encoded, with the page number, into every page header. The payload format is
// `<doc-id>-<page in hex, zero-padded to 4>`, e.g. `D/ACD/UND/NTE/5-000A`.

#import "@preview/tiaoma:0.3.0"
#import "config.typ": colors
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

// The marks take explicit colours so a cover drawn in another scheme can use them.

#let data-matrix(payload, fg: auto, bg: auto) = box(tiaoma.data-matrix(
  payload,
  options: (
    fg-color: if fg == auto { colors.text } else { fg },
    bg-color: if bg == auto { colors.page } else { bg },
    show-hrt: false,
    scale: 0.5,
  ),
))

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
