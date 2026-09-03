// Compile-time configuration, all driven by `--input` flags:
//
//   --input target=pdf|html    output flavour     (default pdf)
//   --input theme=light|dark   colour scheme      (default light)
//   --input font=sans|serif    font suite         (default sans)
//
// These are read at module scope, not inside `context`, because `set` rules and
// top-level `#let colors = ...` need plain values. Typst's `target()` is not
// usable here: it is undefined unless `--features html` is passed.

#import "palette.typ": color-palette
#import "fonts.typ": font-suites, mono

#let target = sys.inputs.at("target", default: "pdf")
#let theme = sys.inputs.at("theme", default: "light")
#let font = sys.inputs.at("font", default: "sans")

#assert(target in ("pdf", "html"), message: "target must be pdf or html, got " + target)
#assert(theme in ("light", "dark"), message: "theme must be light or dark, got " + theme)
#assert(font in ("sans", "serif"), message: "font must be sans or serif, got " + font)

#let is-html = target == "html"
#let colors = color-palette.at(theme)
#let fonts = font-suites.at(font)

/// Body, maths and code faces for the selected suite. Applied once, by `project`.
#let apply-fonts(body) = {
  set text(
    size: 11pt,
    font: fonts.body,
    lang: "en",
    features: fonts.body-features,
    fill: colors.text,
  )
  show raw: set text(size: 10pt, font: mono)
  show math.equation: set text(font: fonts.math, features: fonts.math-features)
  body
}
