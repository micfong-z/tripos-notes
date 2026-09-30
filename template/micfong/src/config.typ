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

#let mds-token = sys.inputs.at("mds-token", default: none)
#assert(
  mds-token == none or mds-token.match(regex("^[0-9A-HJKMNP-TV-Z]{4}$")) != none,
  message: "mds-token must be 4 Crockford base32 characters, got " + repr(mds-token),
)
#let mds-rendition = theme + "-" + font

#let colors = color-tokens(theme)
#let fonts = font-suites.at(font)
#let is-dark = theme == "dark"
