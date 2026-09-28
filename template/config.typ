// Compile-time configuration, all driven by `--input` flags:
//
//   --input target=pdf|html    output flavour     (default pdf)
//   --input theme=light|dark   colour scheme      (default light)
//   --input font=sans|serif    font suite         (default sans)
//
// Theme and font are the design system's own inputs, so its tokens and font
// suites are used as they are. `target` is the notes' addition: the design
// system is PDF-only, and the HTML branch exists for the Ponder exporter.
//
// These are read at module scope, not inside `context`, because `set` rules and
// top-level `#let colors = ...` need plain values. Typst's `target()` is not
// usable here: it is undefined unless `--features html` is passed.

#import "micfong/src/config.typ": colors, font, fonts, is-dark, theme
#import "micfong/src/fonts.typ": mono, reset

#let target = sys.inputs.at("target", default: "pdf")
#assert(target in ("pdf", "html"), message: "target must be pdf or html, got " + target)
#let is-html = target == "html"

/// Body, maths and code faces for the selected suite, for the HTML export. The
/// PDF layouts apply the same suite themselves.
#let apply-fonts(body) = {
  set text(
    size: 11pt,
    font: fonts.body,
    lang: "en",
    features: fonts.body-features,
    fill: colors.text,
  )
  show raw: set text(size: 10pt, font: mono, features: reset(fonts.body-features))
  show math.equation: set text(font: fonts.math, features: reset(fonts.body-features) + fonts.math-features)
  body
}
