// Compile-time configuration, driven by `--input` flags:
//
//   --input theme=light|dark   colour scheme   (default light)
//   --input font=sans|serif    font suite      (default sans)
//
// Read at module scope rather than inside `context`, because `set` rules and
// the `colors` dictionary every element closes over need plain values.

#import "tokens.typ": color-tokens
#import "fonts.typ": font-suites

#let theme = sys.inputs.at("theme", default: "light")
#let font = sys.inputs.at("font", default: "sans")

#assert(theme in ("light", "dark"), message: "theme must be light or dark, got " + theme)
#assert(font in ("sans", "serif"), message: "font must be sans or serif, got " + font)

#let colors = color-tokens(theme)
#let fonts = font-suites.at(font)
#let is-dark = theme == "dark"
